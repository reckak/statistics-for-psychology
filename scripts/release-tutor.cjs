// Prepares a GitHub release of the last tutor export. Without --draft it only
// reports what it would do; publishing a draft is always the author's step.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const {root, source, web, read, hash, run} = require('./tutor/common.cjs');
const args = process.argv.slice(2);
const option = flag => args.includes(flag) ? args[args.indexOf(flag) + 1] : undefined;
for (const arg of args.filter(x => x.startsWith('--'))) {
  assert(['--draft', '--report', '--skip-check'].includes(arg), `Unknown option: ${arg}`);
}
const draft = args.includes('--draft');
const reportPath = path.resolve(root, option('--report') || 'ai-tutor/overeni.json');
assert(!(draft && option('--report')), '--report is only for testing the safeguards; it cannot create a release');
const report = JSON.parse(read(reportPath));
const {version, source_revision: revision} = report;
const tag = `tutor-v${version}`;
const ok = (command, commandArgs) => {
  try { run(command, commandArgs); return true; } catch { return false; }
};

// Safeguards: a release must match a clean, pushed source revision exactly.
assert.equal(report.source_dirty, false, 'Export was made from uncommitted sources; commit and export again');
assert.match(revision, /^[0-9a-f]{40}$/, 'Missing source revision');
assert.equal(JSON.parse(read(path.join(source, 'plugin.json'))).version, version,
  'Version in the export differs from the plugin source; export again');
run('git', ['fetch', '--quiet', 'origin']);
assert(run('git', ['branch', '-r', '--contains', revision]).trim() !== '', `Revision ${revision} is not pushed to origin`);
assert(!ok('git', ['rev-parse', '--verify', '--quiet', `refs/tags/${tag}`]), `Tag ${tag} already exists locally`);
assert.equal(run('git', ['ls-remote', '--tags', 'origin', tag]).trim(), '', `Tag ${tag} already exists on GitHub`);
// A draft release has no tag yet, so ask GitHub for the release itself.
assert(!ok('gh', ['release', 'view', tag]), `Release ${tag} (possibly a draft) already exists`);

// Release assets keep the same names in every release, so the book can link
// to releases/latest/download/<name>. Local archives keep the version.
const assets = [
  {platform: 'ChatGPT', archive: report.archive, sha: report.archive_sha256, name: 'statistika-tutor-chatGPT.zip'},
  {platform: 'Claude', archive: report.claude?.archive, sha: report.claude?.archive_sha256, name: 'statistika-tutor-claude.zip'},
  {platform: 'Gemini', archive: report.gemini?.archive, sha: report.gemini?.archive_sha256, name: 'statistika-tutor-gemini.zip'}
];
for (const a of assets) {
  assert(a.archive && fs.existsSync(a.archive), `Missing ${a.platform} archive: ${a.archive}`);
  assert(path.basename(a.archive).endsWith(`-${version}.zip`), `${a.platform} archive is not version ${version}`);
  assert.equal(hash(a.archive), a.sha, `${a.platform} archive differs from the checked export`);
}
if (!args.includes('--skip-check')) {
  run('node', ['scripts/check-tutor.cjs', '--package', report.package_directory,
    '--claude', report.claude.skill_directory, '--gemini', report.gemini.skill_directory]);
}

const out = path.join(root, 'tmp', `tutor-release-${version}`);
fs.rmSync(out, {recursive: true, force: true});
fs.mkdirSync(out, {recursive: true});
for (const a of assets) {
  a.file = path.join(out, a.name);
  fs.copyFileSync(a.archive, a.file);
  assert.equal(hash(a.file), a.sha);
}
const page = `${web}quarto/ai_tutor.html`;
const notes = [
  `AI tutor k učebnici Základy statistiky pro psychology, verze ${version} (sestaveno ${report.date}).`,
  '',
  `Návod ke stažení a instalaci je ve webové učebnici: [AI tutor: stažení a instalace](${page}).`,
  'Stáhněte soubor pro svou platformu a nahrajte jej nerozbalený:',
  '',
  ...assets.map(a => `- **${a.platform}:** \`${a.name}\``),
  '',
  `Tutor obsahuje úplný text kapitol 1–${report.chapters} včetně cvičení a řešení a tři přehledy (slovníček, značení a vzorce, funkce Excelu). Učebnici nenahrazuje; při rozporu platí učebnice.`,
  '',
  `Revize zdroje: ${revision}`,
  '',
  'SHA-256:',
  '',
  ...assets.map(a => `- \`${a.name}\`: \`${a.sha}\``),
  ''
].join('\n');
const notesFile = path.join(out, 'poznamky.md');
fs.writeFileSync(notesFile, notes, 'utf8');

const create = ['release', 'create', tag, ...assets.map(a => a.file), '--target', revision,
  '--draft', '--title', `AI tutor ${version}`, '--notes-file', notesFile];
if (draft) {
  run('gh', create);
  console.log(`Koncept vydání ${tag} vytvořen. Zkontrolujte jej na GitHubu a zveřejněte ručně.`);
} else {
  console.log(`Suchý běh: nic se nenahrálo. Spuštění s --draft vytvoří koncept:\n  gh ${create.join(' ')}`);
}
console.log(JSON.stringify({tag, revision, assets: assets.map(a => ({name: a.name, sha256: a.sha})), notes: notesFile}, null, 2));
