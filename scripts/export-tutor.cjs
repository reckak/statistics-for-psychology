// Windows authoring command; student use requires neither these tools nor local files.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const c = require('./tutor/common.cjs');
const {root, name, source, web, posix, read, hash, files, run, quarto, pandoc,
  parseSource, nodes, attr, text, str, para, link, documents} = c;
const args = process.argv.slice(2);
const option = flag => args.includes(flag) ? args[args.indexOf(flag) + 1] : undefined;
for (const arg of args.filter(x => x.startsWith('--'))) {
  assert(['--quarto', '--rscript', '--skip-figures'].includes(arg), `Unknown option: ${arg}`);
}
const q = quarto(option('--quarto'));
const manifest = JSON.parse(read(path.join(source, 'plugin.json')));
const version = manifest.version;
assert.equal(manifest.name, name);
assert.match(version, /^\d+\.\d+\.\d+$/);
assert(manifest.extensions['com.openai'].interface.shortDescription.length <= 30);
const workRoot = path.join(root, 'tmp');
fs.mkdirSync(workRoot, {recursive: true});
const work = fs.mkdtempSync(path.join(workRoot, 'tutor-export-'));
const stage = path.join(work, name);
fs.cpSync(source, stage, {recursive: true});
const refs = path.join(stage, 'skills/statistika-tutor/references');
const write = (relative, body) => {
  const target = path.join(refs, relative);
  fs.mkdirSync(path.dirname(target), {recursive: true});
  fs.writeFileSync(target, body, 'utf8');
};

if (!args.includes('--skip-figures')) {
  const r = option('--rscript') || (fs.existsSync('C:/Program Files/R/R-4.5.1/bin/Rscript.exe') ?
    'C:/Program Files/R/R-4.5.1/bin/Rscript.exe' : 'Rscript');
  for (let n = 1; n <= 6; n++) {
    const nn = String(n).padStart(2, '0');
    console.log(`Obrázky kapitoly ${n}/6`);
    run(r, ['--vanilla', '-e', `Sys.setlocale('LC_CTYPE', '.UTF-8'); source('scripts/kapitola_${nn}.R', encoding='UTF-8')`]);
  }
}

const sourceRevision = run('git', ['rev-parse', 'HEAD']).trim();
const inputPaths = [...documents.map(d => d.source), 'quarto/kapitola_07.qmd', 'quarto/kapitola_08.qmd',
  ...Array.from({length: 6}, (_, i) => `scripts/kapitola_0${i + 1}.R`),
  'references.bib', 'styles/apa.csl', 'LICENSE-TEXT.md',
  'LICENSE', 'scripts/export-tutor.cjs', 'scripts/check-tutor.cjs', 'scripts/tutor/common.cjs', 'scripts/tutor/prepare.lua',
  ...files(source).map(f => posix(path.relative(root, f)))];
const inputs = Object.fromEntries(inputPaths.map(f => [f, hash(path.join(root, f))]));
const sourceDirty = run('git', ['status', '--porcelain', '--', ...inputPaths]).trim() !== '';
const stamp = new Intl.DateTimeFormat('sv-SE', {timeZone: 'Europe/Prague', dateStyle: 'short'}).format(new Date());
const docs = documents.map(d => ({...d, ast: parseSource(q, d.source)}));
const idMap = new Map();
const pages = new Map(docs.map(d => [d.id, d]));

// A missing chapter may still be an authored cross-reference target, never bundled content.
for (const n of [7, 8]) {
  const id = `kapitola_0${n}`;
  pages.set(id, {id, source: `quarto/${id}.qmd`, external: true, number: n,
    ast: parseSource(q, `quarto/${id}.qmd`)});
}
for (const d of pages.values()) {
  let figure = 0, table = 0;
  d.title = text(nodes(d.ast.blocks, 'Header')[0].c[2]);
  d.ids = new Set();
  for (const node of nodes(d.ast.blocks)) {
    const a = attr(node);
    if (!a?.[0]) continue;
    const id = a[0];
    assert(!d.ids.has(id), `${d.source}: duplicate identifier ${id}`);
    d.ids.add(id);
    const record = {doc: d, id};
    if (id.startsWith('fig-')) Object.assign(record, {label: 'Obrázek', number: `${d.number}.${++figure}`});
    if (id.startsWith('tbl-')) Object.assign(record, {label: 'Tabulka', number: d.number ? `${d.number}.${++table}` : ''});
    if (node.t === 'Header') record.title = text(node.c[2]);
    if (!idMap.has(id)) idMap.set(id, []);
    idMap.get(id).push(record);
  }
}

function targetFor(from, to, fragment = '') {
  if (to.external) return `${web}quarto/${to.id}.html${fragment ? '#' + fragment : ''}`;
  const relative = from.output === to.output ? '' : posix(path.relative(path.dirname(from.output), to.output));
  return `${relative}${fragment ? '#' + fragment : ''}` || path.basename(to.output);
}
function crossReferences(value, d) {
  if (Array.isArray(value)) {
    const result = [];
    for (const item of value) {
      const changed = crossReferences(item, d);
      if (item?.t === 'Cite' && Array.isArray(changed)) result.push(...changed);
      else result.push(changed);
    }
    return result;
  }
  if (!value || typeof value !== 'object') return value;
  if (value.t === 'Cite') {
    const flags = value.c[0].map(x => /^(fig|tbl|sec|eq|lst)-/.test(x.citationId));
    if (flags.some(Boolean)) {
      assert(flags.every(Boolean), `${d.source}: mixed bibliographic and cross-reference citation`);
      return value.c[0].flatMap((citation, i) => {
        const matches = idMap.get(citation.citationId) || [];
        const r = matches.find(m => m.doc.id === d.id) || (matches.length === 1 ? matches[0] : null);
        assert(r, `${d.source}: missing cross-reference ${citation.citationId}`);
        const label = r.number ? (citation.citationMode.t === 'SuppressAuthor' ? r.number : `${r.label} ${r.number}`) : r.title;
        assert(label, `Missing cross-reference label: ${r.id}`);
        return [...(i ? [str('; ')] : []), ...citation.citationPrefix,
          link(label, targetFor(d, r.doc, r.id)), ...citation.citationSuffix];
      });
    }
    return value;
  }
  return Object.fromEntries(Object.entries(value).map(([key, v]) => [key, crossReferences(v, d)]));
}

for (const d of docs) d.ast.blocks = crossReferences(d.ast.blocks, d);
const citedKeys = [...new Set(docs.flatMap(d => nodes(d.ast.blocks, 'Cite').flatMap(n => n.c[0].map(x => x.citationId))))].sort();
// One citeproc pass keeps name/year disambiguation identical across all files and the book.
const combined = {
  'pandoc-api-version': docs[0].ast['pandoc-api-version'],
  meta: {
    bibliography: {t: 'MetaString', c: 'references.bib'},
    csl: {t: 'MetaString', c: 'styles/apa.csl'},
    lang: {t: 'MetaString', c: 'cs'},
    'link-citations': {t: 'MetaBool', c: true},
    nocite: {t: 'MetaInlines', c: [{t: 'Cite', c: [[{citationId: '*', citationPrefix: [], citationSuffix: [],
      citationMode: {t: 'NormalCitation'}, citationNoteNum: 0, citationHash: 0}], [str('[@*]')]]}]}
  },
  blocks: docs.map(d => ({t: 'Div', c: [[`tutor-document-${d.id}`, [], []], d.ast.blocks]}))
};
const cited = JSON.parse(pandoc(q, ['--from=json', '--to=json', '--citeproc'], JSON.stringify(combined)));
const bibliography = cited.blocks.find(b => b.t === 'Div' && b.c[0][0] === 'refs');
assert(bibliography, 'Citation processor did not produce a bibliography');
bibliography.c[1] = bibliography.c[1].filter(b => citedKeys.includes(b.c?.[0]?.[0]?.replace(/^ref-/, '')));
assert.equal(bibliography.c[1].length, citedKeys.length, 'Incomplete bibliography');
// Pandoc's Markdown writer deliberately suppresses a generated Div named "refs".
// Keep the entry anchors, but serialize the already formatted bibliography as prose.
bibliography.c[0] = ['literatura-zdroje', [], []];
for (const item of bibliography.c[1]) item.c[0][1] = [];
const literature = {id: 'literatura', output: 'literatura.md', title: 'Literatura citovaná v přibalených materiálech', ids: new Set(['literatura-zdroje', ...citedKeys.map(k => `ref-${k}`)])};
pages.set(literature.id, literature);

function rewriteTarget(target, d) {
  if (/^[a-z][a-z0-9+.-]*:|^\/\//i.test(target)) return target;
  const [part, fragment = ''] = target.split('#');
  if (!part) {
    if (fragment.startsWith('ref-')) return targetFor(d, literature, fragment);
    assert(d.ids.has(fragment), `${d.id}: missing local anchor ${fragment}`);
    return target;
  }
  const page = path.basename(part).replace(/\.(qmd|html)$/, '');
  if (pages.has(page)) return targetFor(d, pages.get(page), fragment);
  if (/\.xlsx$/i.test(part) && /(?:^|\/)data\//.test(part)) return `${web}data/${path.basename(part)}`;
  if (/\.md$/.test(part)) return target; // Already rewritten cross-reference.
  throw new Error(`${d.source || d.id}: unhandled relative link ${target}`);
}

const assetFiles = new Map();
function finish(value, d) {
  if (Array.isArray(value)) return value.map(x => finish(x, d));
  if (!value || typeof value !== 'object') return value;
  if (value.t === 'Cite') {
    return {t: 'Span', c: [['', ['citation'], [['data-cites', value.c[0].map(x => x.citationId).join(' ')]]], finish(value.c[1], d)]};
  }
  const copy = Object.fromEntries(Object.entries(value).map(([k, v]) => [k, finish(v, d)]));
  if (copy.t === 'Link') copy.c[2][0] = rewriteTarget(copy.c[2][0], d);
  if (copy.t === 'Image') {
    const sourceFile = path.resolve(root, path.dirname(d.source), copy.c[2][0]);
    const relative = posix(path.relative(path.join(root, 'assets'), sourceFile));
    assert(relative && !relative.startsWith('../') && !path.isAbsolute(relative), `Image outside assets/: ${sourceFile}`);
    const output = `assets/${relative}`;
    assetFiles.set(output, sourceFile);
    copy.c[2][0] = posix(path.relative(path.dirname(d.output), output));
  }
  if (copy.t === 'Figure') {
    for (const image of nodes(copy.c[2], 'Image')) {
      const alt = image.c[0][2].find(([key]) => key === 'fig-alt')?.[1];
      assert(alt, `${d.source}: figure without a text description`);
      copy.c[2].push(para(`Textový popis obrázku: ${alt}`));
    }
    const record = idMap.get(copy.c[0][0])?.find(r => r.doc.id === d.id);
    const label = record?.number ? `${record.label} ${record.number}: ` : '';
    const captions = copy.c[1][1].map(block => ({t: 'Para', c: [str(label), ...block.c]}));
    // A multi-block Figure would be emitted as raw HTML, hiding math and anchors
    // from Markdown readers. A fenced Div keeps the original figure identifier.
    return {t: 'Div', c: [copy.c[0], [...copy.c[2], ...captions]]};
  }
  if (copy.t === 'Table') {
    const record = idMap.get(copy.c[0][0])?.find(r => r.doc.id === d.id);
    if (record?.number && copy.c[1][1][0]) {
      copy.c[1][1][0].c.unshift(str(`${record.label} ${record.number}: `));
    }
  }
  return copy;
}

const writer = ['--from=json', '--to=markdown-smart+pipe_tables-simple_tables-multiline_tables-grid_tables+tex_math_dollars+fenced_divs+bracketed_spans',
  '--wrap=none', '--columns=120'];
const exported = [];
for (const d of docs) {
  const wrapper = cited.blocks.find(b => b.t === 'Div' && b.c[0][0] === `tutor-document-${d.id}`);
  assert(wrapper, `Document lost during citation processing: ${d.id}`);
  const out = {...d.ast, meta: {}, blocks: finish(wrapper.c[1], d)};
  const markdown = pandoc(q, writer, JSON.stringify(out));
  write(d.output, markdown);
  exported.push({...d, markdown, out});
}
write(literature.output, pandoc(q, writer, JSON.stringify({
  'pandoc-api-version': cited['pandoc-api-version'], meta: {},
  blocks: [{t: 'Header', c: [1, ['literatura-tutora', [], []], [str(literature.title)]]}, finish(bibliography, literature)]
})));
for (const [output, input] of assetFiles) {
  const dest = path.join(refs, output);
  fs.mkdirSync(path.dirname(dest), {recursive: true});
  fs.copyFileSync(input, dest);
}
fs.copyFileSync(path.join(root, 'LICENSE-TEXT.md'), path.join(refs, 'LICENCE.md'));
fs.copyFileSync(path.join(root, 'LICENSE'), path.join(refs, 'LICENSE'));
fs.writeFileSync(path.join(stage, 'README.md'), `# Statistika pro psychology – AI tutor\n\n` +
  `Verze ${version}; autor Karel Rečka.\n\n` +
  'Vyber plugin v ChatGPT a uveď téma a režim: vysvětlení, sokratovské vedení, procvičování nebo zkoušení.\n\n' +
  'Kapitoly 1–6 a tři celé aktuální přehledy jsou přibalené; nemusíš je nahrávat. Úplné kapitoly 7–8 nejsou součástí této verze.\n\n' +
  '[Obsah podkladů](skills/statistika-tutor/references/INDEX.md) · ' +
  '[Údržba a distribuce](skills/statistika-tutor/references/PRIPOJENI-KAPITOL.md) · ' +
  '[Původ a licence](skills/statistika-tutor/references/LICENCE.md)\n\n' +
  'Instrukce usměrňují jazykový model, nezaručují bezchybnost odpovědí. Zkoušení je formativní nácvik.\n', 'utf8');

const entry = d => ({id: d.id, title: d.title, path: d.output, source: d.source,
  sha256: hash(path.join(refs, d.output)), bytes: Buffer.byteLength(d.markdown),
  headings: nodes(d.out.blocks, 'Header').map(h => ({id: h.c[1][0], title: text(h.c[2]), level: h.c[0]}))});
const catalog = {
  schema_version: 1, package_version: version, updated: stamp, status: 'chapters_available',
  source_revision: sourceRevision, source_dirty: sourceDirty, reference_package: 'REFERENCE.md', index: 'INDEX.md',
  notice: 'Úplný výklad kapitol 1–6; celé aktuální přehledy obsahují i hesla kapitol 7–8. Úplné kapitoly 7–8 nejsou přibalené.',
  chapters: exported.filter(d => d.kind === 'chapter').map(entry),
  overviews: exported.filter(d => d.kind === 'overview').map(entry),
  introduction: entry(exported.find(d => d.kind === 'introduction')),
  bibliography: {path: literature.output, citation_keys: citedKeys, sha256: hash(path.join(refs, literature.output))},
  source_hashes: inputs
};
write('KAPITOLY.json', JSON.stringify(catalog, null, 2) + '\n');
const index = [`# Obsah podkladů AI tutora`, '', `Verze ${version}; snímek učebnice z ${stamp}.`, '',
  'Student nemusí nahrávat kapitoly 1–6 ani tři přehledy. Načítej potřebný oddíl, nikoli všechny soubory najednou.', '',
  'Úplné kapitoly 7–8 nejsou přibalené. Hesla z těchto kapitol jsou dostupná ve třech přehledech; jejich odkazy na výklad vedou na web.', '',
  '[O učebnici a původu dat](uvod.md) · [Krátká reference](REFERENCE.md) · [Literatura](literatura.md) · [Licence](LICENCE.md)', '',
  '## Výkladové kapitoly', ''];
for (const d of exported.filter(d => d.kind === 'chapter')) {
  index.push(`### ${d.number}. ${d.title}`, '', `[Celá kapitola](${d.output})`, '');
  for (const h of nodes(d.out.blocks, 'Header').filter(h => h.c[0] === 2)) {
    index.push(`- [${text(h.c[2])}](${d.output}#${h.c[1][0]})`);
  }
  index.push('');
}
index.push('## Celé aktuální přehledy', '');
for (const d of exported.filter(d => d.kind === 'overview')) {
  const count = nodes(d.out.blocks, 'Header').filter(h => h.c[0] === 2).length;
  index.push(`- [${d.title}](${d.output}) — ${count} hesel; vyhledej název, značku nebo funkci a načti konkrétní heslo.`);
}
index.push('', 'Registr KAPITOLY.json obsahuje přesná ID oddílů, zdrojovou verzi a otisky souborů; není nutné jej číst celý při běžném studiu.', '');
write('INDEX.md', index.join('\n'));

// Validate the complete staged package before replacing a previous release artifact.
const validation = JSON.parse(run(process.execPath, ['scripts/check-tutor.cjs', '--package', stage, '--quarto', q]));
console.log(JSON.stringify(validation));
for (const [file, digest] of Object.entries(inputs)) assert.equal(hash(path.join(root, file)), digest, `Input changed during export: ${file}`);
for (const [output, input] of assetFiles) assert.equal(hash(path.join(refs, output)), hash(input));
const inventory = files(stage).map(f => ({path: posix(path.relative(stage, f)), bytes: fs.statSync(f).size, sha256: hash(f)}));
const stageArchive = path.join(work, `${name}-${version}.zip`);
const psQuote = s => `'${s.replace(/'/g, "''")}'`;
// Windows PowerShell's older .NET writes backslashes with CreateFromDirectory.
// Explicit POSIX entry names make the same archive portable to cloud clients.
const createZip = `$ErrorActionPreference='Stop'; Add-Type -AssemblyName System.IO.Compression; Add-Type -AssemblyName System.IO.Compression.FileSystem; $base=${psQuote(stage)}; $zip=[IO.Compression.ZipFile]::Open(${psQuote(stageArchive)}, [IO.Compression.ZipArchiveMode]::Create); try { foreach($file in Get-ChildItem -LiteralPath $base -File -Recurse -Force) { $relative=$file.FullName.Substring($base.Length+1).Replace([char]92,[char]47); [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $file.FullName, $relative, [IO.Compression.CompressionLevel]::Optimal) | Out-Null } } finally { $zip.Dispose() }`;
run('powershell.exe', ['-NoProfile', '-Command', createZip]);
const report = {version, source_revision: sourceRevision, source_dirty: sourceDirty, date: stamp, package_directory: stage,
  files: inventory, chapters: catalog.chapters.length, overviews: catalog.overviews.length,
  overview_entries: catalog.overviews.map(d => ({id: d.id, entries: d.headings.filter(h => h.level === 2).length})),
  images: assetFiles.size, citations: citedKeys.length, validation, archive_sha256: hash(stageArchive)};
fs.writeFileSync(path.join(work, 'inventory.json'), JSON.stringify(report, null, 2) + '\n');
// Read every archive member independently with .NET, including hidden compatibility files.
const checkZip = `$ErrorActionPreference='Stop'; Add-Type -AssemblyName System.IO.Compression.FileSystem; $zip=[IO.Compression.ZipFile]::OpenRead(${psQuote(stageArchive)}); try { $rows=@(foreach($entry in $zip.Entries) { $stream=$entry.Open(); try { $sha=[Security.Cryptography.SHA256]::Create(); $digest=([BitConverter]::ToString($sha.ComputeHash($stream))).Replace('-','').ToLowerInvariant(); [pscustomobject]@{path=$entry.FullName; bytes=$entry.Length; sha256=$digest} } finally { $stream.Dispose() } }); ConvertTo-Json -InputObject $rows -Compress } finally { $zip.Dispose() }`;
const archiveMembers = JSON.parse(run('powershell.exe', ['-NoProfile', '-Command', checkZip]));
archiveMembers.sort((a, b) => a.path.localeCompare(b.path));
inventory.sort((a, b) => a.path.localeCompare(b.path));
assert.equal(archiveMembers.length, inventory.length, 'Archive member count');
for (let i = 0; i < inventory.length; i++) assert.deepEqual(archiveMembers[i], inventory[i], `Archive member ${inventory[i].path}`);
const output = path.join(root, 'output/tutor');
fs.mkdirSync(output, {recursive: true});
const archive = path.join(output, `${name}-${version}.zip`);
fs.copyFileSync(stageArchive, archive);
fs.writeFileSync(path.join(output, 'overeni.json'), JSON.stringify({...report, archive}, null, 2) + '\n');
console.log(JSON.stringify({archive, package: stage, version, chapters: report.chapters,
  overviews: report.overview_entries, images: report.images, citations: report.citations}, null, 2));
