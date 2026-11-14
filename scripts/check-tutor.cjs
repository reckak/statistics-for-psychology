// Independent source-to-package checks; no model or network calls are needed.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const {root, name, source, web, read, files, hash, quarto, pandoc, parseSource,
  nodes, attr, text, documents, skillName, splitSkill, imageLine, geminiSkill, geminiNote} = require('./tutor/common.cjs');
const {bookChapters, scopes} = require('./tutor/plans.cjs');
const args = process.argv.slice(2);
const option = flag => args.includes(flag) ? args[args.indexOf(flag) + 1] : undefined;
const lastExport = option('--package') ? null : JSON.parse(read(path.join(root, 'ai-tutor/overeni.json')));
const packageRoot = option('--package') || lastExport.package_directory;
const claudeRoot = option('--claude') || lastExport?.claude?.skill_directory;
const geminiRoot = option('--gemini') || lastExport?.gemini?.skill_directory;
const q = quarto(option('--quarto'));
const skillDir = path.join(packageRoot, 'skills', skillName);
const refs = path.join(skillDir, 'references');
const manifest = JSON.parse(read(path.join(packageRoot, 'plugin.json')));
const overlay = JSON.parse(read(path.join(packageRoot, '.codex-plugin/plugin.json')));
const sourceManifest = JSON.parse(read(path.join(source, 'plugin.json')));
assert.equal(manifest.name, name);
assert.equal(manifest.version, sourceManifest.version);
assert.equal(overlay.version, manifest.version);
assert.deepEqual(overlay.interface, manifest.extensions['com.openai'].interface);
assert.deepEqual(manifest.extensions['com.openai'].interface.defaultPrompt,
  sourceManifest.extensions['com.openai'].interface.defaultPrompt);
assert.equal(hash(path.join(packageRoot, 'assets/logo.png')), hash(path.join(source, 'assets/logo.png')));
assert.equal(manifest.$schema, 'https://agent-plugins.org/schemas/1.0.0/plugin.schema.json');
const skill = read(path.join(packageRoot, 'skills/statistika-tutor/SKILL.md'));
// The frontmatter uses the JSON flow-mapping subset of YAML 1.2.
const frontmatter = JSON.parse(skill.match(/^---\n([\s\S]*?)\n---\n/)[1]);
assert.equal(frontmatter.name, 'statistika-tutor');
assert(frontmatter.description);
assert(Buffer.byteLength(skill) <= 16000, 'Keep the main skill compact, including the generated menu');
assert(!skill.includes('<!-- tutor:chapter-menu -->'), 'Chapter menu was not generated');
assert(!skill.includes('„4.3“'), 'Concrete ambiguity belongs in regression prompts');
assert(!/\b\d+\.\d+\.\d+\b/.test(skill), 'Read release version from metadata');
assert(skill.includes('## Cvičení z učebnice'));
const prompts = manifest.extensions['com.openai'].interface.defaultPrompt;
assert(Array.isArray(prompts) && prompts.length === 3);
// Authoring guard for compact desktop starters; not a documented host limit.
for (const prompt of prompts) {
  assert(Array.from(prompt).length <= 100, 'Keep starter prompts within 100 characters');
  assert(prompt.startsWith('Načti SKILL.md tutora a katalog.'));
}
assert(prompts[0].includes('kapitolu, způsob a rozsah studia'));
assert(prompts[1].includes('sokratovsky, jednou otázkou'));
assert(prompts[2].includes('Vyzkoušej mě') && prompts[2].includes('pravidel tutora'));
assert(skill.includes('Bez přečteného katalogu nesestavuj nabídku kapitol zpaměti'));
assert(skill.includes('Vyhledávání pluginů ani čtení starších chatů tento krok nenahrazuje'));
for (const ref of ['VIZUALIZACE.md', 'ZKOUSENI.md', 'OTAZKY.md']) {
  assert(skill.includes(`references/${ref}`));
  assert(fs.statSync(path.join(refs, ref)).size > 0);
}
assert(!/Registr verze 0\.1\.0|seznam kapitol je prázdný/.test(skill));
const registry = JSON.parse(read(path.join(refs, 'KAPITOLY.json')));
assert.equal(registry.status, 'chapters_available');
assert.equal(registry.schema_version, 2);
assert.equal(registry.package_version, manifest.version);
assert.equal(registry.chapters.length, bookChapters(q).length);
assert.equal(registry.plans.length, 6);
assert.equal(registry.overviews.length, 3);
const bundled = registry.chapters.filter(d => d.availability === 'bundled');
assert.equal(bundled.length, 6);
const book = bookChapters(q);
assert.deepEqual(registry.chapters.map(d => d.source), book.map(d => d.source));
const index = read(path.join(refs, 'INDEX.md'));
let menuPosition = -1;
for (const [i, entry] of registry.chapters.entries()) {
  const before = parseSource(q, entry.source);
  const title = text(nodes(before.blocks, 'Header')[0].c[2]);
  assert.equal(entry.title, title, `Exact chapter title: ${entry.id}`);
  assert.equal(entry.number, i + 1);
  assert.equal(entry.web_url, `${web}quarto/${entry.id}.html`);
  assert(index.includes(`| ${entry.number}. ${title} |`), 'Complete catalog in index');
  if (entry.availability === 'bundled') {
    const position = skill.indexOf(`${entry.number}. **${title}**`);
    assert(position > menuPosition, `Missing/out-of-order chapter menu: ${entry.id}`);
    menuPosition = position;
    assert.equal(entry.plan, `plany/${entry.id}.md`);
  } else {
    assert.equal(entry.availability, 'web_only');
    assert.equal(entry.path, null);
    assert.equal(entry.plan, null);
    assert(!fs.existsSync(path.join(refs, `kapitoly/${entry.id}.md`)));
  }
}
for (const entry of [...bundled, ...registry.plans, ...registry.overviews, registry.introduction, registry.bibliography]) {
  assert.equal(hash(path.join(refs, entry.path)), entry.sha256, `Registry checksum: ${entry.path}`);
}
const parse = p => JSON.parse(pandoc(q, [p, '--from=markdown-smart', '--to=json']));
const parsed = new Map();
for (const file of files(packageRoot).filter(f => f.endsWith('.md'))) parsed.set(path.resolve(file), parse(file));
const ids = ast => new Set(nodes(ast).map(n => attr(n)?.[0]).filter(Boolean));
let checkedLinks = 0, math = 0, images = 0, solutions = 0, rows = 0;
for (const [file, ast] of parsed) {
  assert.equal(nodes(ast, 'Cite').length, 0, `Unresolved citation/cross-reference in ${file}`);
  const explicit = nodes(ast).map(n => attr(n)?.[0]).filter(Boolean);
  assert.equal(new Set(explicit).size, explicit.length, `Duplicate identifier in ${file}`);
  for (const node of [...nodes(ast, 'Link'), ...nodes(ast, 'Image')]) {
    const target = node.c[2][0];
    if (/^[a-z][a-z0-9+.-]*:|^\/\//i.test(target)) continue;
    const [part, fragment] = target.split('#');
    const destination = path.resolve(path.dirname(file), decodeURIComponent(part || path.basename(file)));
    assert(!path.relative(packageRoot, destination).startsWith('..'), `Link leaves plugin: ${target}`);
    // The Claude upload contains only the skill folder.
    if (!path.relative(skillDir, file).startsWith('..')) {
      assert(!path.relative(skillDir, destination).startsWith('..'), `${file}: link leaves skill folder: ${target}`);
    }
    assert(fs.existsSync(destination), `${file}: missing file ${target}`);
    if (fragment) assert(ids(parsed.get(destination)).has(decodeURIComponent(fragment)), `${file}: missing anchor ${target}`);
    checkedLinks++;
  }
}

const frequency = values => values.reduce((m, x) => m.set(x, (m.get(x) || 0) + 1), new Map());
function retains(before, after, label) {
  const b = frequency(before), a = frequency(after);
  for (const [value, count] of b) assert((a.get(value) || 0) >= count, `${label}: lost ${value.slice(0, 180)}`);
}
function words(value) {
  if (Array.isArray(value)) return value.flatMap(words);
  if (!value || typeof value !== 'object') return [];
  if (['Cite', 'Math', 'Image', 'Note'].includes(value.t)) return [];
  if (value.t === 'Span' && value.c[0][1].includes('citation')) return [];
  if (value.t === 'Str') return value.c.normalize('NFC').split(/\s+/).filter(Boolean);
  if (value.t === 'Code') return value.c[1].split(/\s+/).filter(Boolean);
  if (['Link', 'Span'].includes(value.t)) return words(value.c[1]);
  return words(value.c);
}
function subsequence(needle, haystack) {
  let p = 0;
  for (const token of haystack) if (token === needle[p]) p++;
  return p === needle.length;
}
const expectedSolutions = {kapitola_01: 9, kapitola_02: 10, kapitola_03: 15,
  kapitola_04: 10, kapitola_05: 12, kapitola_06: 16};
for (const d of documents.filter(d => d.kind !== 'overview')) {
  const before = parseSource(q, d.source, false);
  const after = parsed.get(path.resolve(refs, d.output));
  const afterIds = ids(after);
  for (const id of ids(before)) assert(afterIds.has(id), `${d.id}: lost identifier ${id}`);
  for (const type of ['Math', 'Code']) {
    const values = ast => nodes(ast, type).map(n => n.c[1]);
    retains(values(before), values(after), `${d.id} ${type}`);
  }
  math += nodes(before, 'Math').length;
  const aParagraphs = [...nodes(after, 'Para'), ...nodes(after, 'Plain')].map(p => words(p.c));
  const byFirst = new Map();
  for (const p of aParagraphs) for (const token of new Set(p)) {
    if (!byFirst.has(token)) byFirst.set(token, []);
    byFirst.get(token).push(p);
  }
  for (const paragraph of [...nodes(before, 'Para'), ...nodes(before, 'Plain')]) {
    const tokens = words(paragraph.c);
    if (!tokens.length) continue;
    assert((byFirst.get(tokens[0]) || []).some(p => subsequence(tokens, p)),
      `${d.id}: paragraph/cell lost or changed: ${tokens.slice(0, 26).join(' ')}`);
  }
  assert.equal(nodes(after, 'Table').length, nodes(before, 'Table').length, `${d.id}: table count`);
  assert.equal(nodes(after, 'Image').length, nodes(before, 'Image').length, `${d.id}: image count`);
  for (const image of nodes(before, 'Image')) {
    const input = path.resolve(root, path.dirname(d.source), image.c[2][0]);
    const output = nodes(after, 'Image').find(n => path.basename(n.c[2][0]) === path.basename(input));
    assert(output, `Missing image ${input}`);
    assert.equal(hash(path.resolve(refs, path.dirname(d.output), output.c[2][0])), hash(input));
    const alt = image.c[0][2].find(([k]) => k === 'fig-alt')?.[1];
    assert(alt && nodes(after, 'Para').some(p => text(p).includes(alt)), `Missing visible text description: ${input}`);
  }
  images += nodes(before, 'Image').length;
  const count = nodes(after, 'Div').filter(div => div.c[0][1].includes('callout-note') &&
    div.c[1][0]?.t === 'Para' && text(div.c[1][0]).trim() === 'Ukázat řešení').length;
  if (d.kind === 'chapter') assert.equal(count, expectedSolutions[d.id], `${d.id}: exercise solutions`);
  solutions += count;
  const expectedCites = nodes(before, 'Cite').flatMap(n => n.c[0].map(c => c.citationId)).filter(k => !/^(fig|tbl|sec|eq|lst)-/.test(k));
  const actualCites = nodes(after, 'Span').filter(n => n.c[0][1].includes('citation'))
    .flatMap(n => n.c[0][2].find(([k]) => k === 'data-cites')[1].split(' '));
  retains(expectedCites, actualCites, `${d.id}: citations`);
}

const entities = {amp: '&', lt: '<', gt: '>', quot: '"', apos: "'", nbsp: ' '};
const decode = s => s.replace(/&#(x[\da-f]+|\d+);|&([a-z]+);/gi, (whole, num, named) => {
  if (num) return String.fromCodePoint(num[0].toLowerCase() === 'x' ? parseInt(num.slice(1), 16) : Number(num));
  assert(Object.hasOwn(entities, named.toLowerCase()), `Unrecognised entity: ${whole}`);
  return entities[named.toLowerCase()];
});
const normalized = s => decode(s.replace(/<\/?[a-z][^>]*>/gi, '')).replace(/[$*]/g, '').replace(/\s+/g, ' ').trim();
for (const d of documents.filter(d => d.kind === 'overview')) {
  const original = read(path.join(root, d.source));
  const expected = [...original.matchAll(/<tr id="([^"]+)">([\s\S]*?)<\/tr>/g)];
  const after = parsed.get(path.resolve(refs, d.output));
  const headings = nodes(after, 'Header').filter(h => h.c[0] === 2);
  assert.deepEqual(headings.map(h => h.c[1][0]), expected.map(m => m[1]), `${d.id}: overview rows/order`);
  const blocks = nodes(after, 'Div').find(n => /^(glossary|notation|excel)-table$/.test(n.c[0][0])).c[1];
  for (const [i, row] of expected.entries()) {
    const start = blocks.findIndex(b => b.t === 'Header' && b.c[1][0] === row[1]);
    const next = blocks.findIndex((b, j) => j > start && b.t === 'Header');
    const section = blocks.slice(start + 1, next < 0 ? undefined : next);
    const cells = [...row[2].matchAll(/<t[hd][^>]*>([\s\S]*?)<\/t[hd]>/g)];
    assert.equal(section.length, cells.length * 2, `${d.id}/${row[1]}: labeled fields`);
    for (const [field, cell] of cells.entries()) {
      assert.equal(normalized(text(section[field * 2 + 1])), normalized(cell[1]), `${d.id}/${row[1]}: field ${field + 1}`);
      // Excel absolute references and literal formulas must survive exactly.
      const sourceCode = [...cell[1].matchAll(/<code>([\s\S]*?)<\/code>/g)].map(m => decode(m[1]));
      const outputCode = nodes(section[field * 2 + 1], 'Code').map(n => n.c[1]);
      assert.deepEqual(outputCode, sourceCode, `${d.id}/${row[1]}: code`);
    }
  }
  rows += expected.length;
}
// Check plans against source goals, all section scopes, every overview row
// referring to this chapter, and the original chapter-card skill table.
for (const entry of registry.plans) {
  const chapter = bundled.find(x => x.id === entry.chapter);
  const before = parseSource(q, chapter.source);
  const plan = parsed.get(path.resolve(refs, entry.path));
  const planText = read(path.join(refs, entry.path));
  assert(planText.startsWith(`# ${chapter.number}. ${chapter.title}\n`));
  assert.equal(registry.source_hashes[entry.card], hash(path.join(root, entry.card)));
  const goals = nodes(before.blocks, 'Div').find(x => text(x.c[1][0]) === 'Co budete po prostudování umět');
  const goalBullets = nodes(goals, 'BulletList')[0];
  const planBullets = nodes(plan, 'BulletList').flatMap(x => x.c.map(item => text(item)));
  for (const item of goalBullets.c) assert(planBullets.includes(text(item)), `Plan lost a learning goal: ${entry.chapter}`);
  const originalScope = scopes(before);
  assert.deepEqual(entry.headings, originalScope.headings, 'Source-to-plan optional/exercise scope');
  const optional = nodes(before, 'Div').filter(x => x.c[0][2].some(([key, title]) => key === 'title' && /^Nepovinné rozšíření/.test(title))).map(x => x.c[0][0]);
  // parseSource's conversion puts title text into the first paragraph.
  if (!optional.length) optional.push(...nodes(before, 'Div').filter(x => /^Nepovinné rozšíření/.test(text(x.c[1][0]))).map(x => x.c[0][0]));
  assert.deepEqual(entry.optional_blocks, optional);
  const links = nodes(plan, 'Link').map(x => x.c[2][0]);
  for (const h of entry.headings.filter(h => h.level > 1)) {
    const target = `../${chapter.path}#${h.id}`;
    assert(links.includes(target), `Plan lost heading: ${h.id}`);
    if (!/^sec-shrnuti|^sec-cviceni/.test(h.id)) {
      const item = planText.split('\n').find(line => /^\s*- \[/.test(line) && line.includes(`](${target})`));
      assert(item, `Plan lost study step: ${h.id}`);
      assert.equal(item.includes('— nepovinné'), h.optional, `Visible optional label: ${h.id}`);
    }
  }
  for (const id of optional) assert(links.includes(`../${chapter.path}#${id}`));
  for (const overview of registry.overviews) {
    const original = read(path.join(root, overview.source));
    const expected = [...original.matchAll(/<tr id="([^"]+)">([\s\S]*?)<\/tr>/g)]
      .filter(m => m[2].includes(`${entry.chapter}.html`)).map(m => m[1]);
    const actual = entry.concepts.filter(x => x.overview === overview.id).map(x => x.id);
    assert.deepEqual(actual, expected, `Plan concept inventory: ${entry.chapter}/${overview.id}`);
    for (const id of expected) assert(links.includes(`../${overview.path}#${id}`));
  }
  const card = read(path.join(root, entry.card));
  const section = card.split(/### Cvičení a očekávané[^\n]*\n/)[1].split(/^### |^## /m)[0];
  const cardAst = JSON.parse(pandoc(q, ['--from=markdown-smart', '--to=json'], section));
  const cardTables = nodes(cardAst, 'Table');
  const planTables = nodes(plan, 'Table');
  for (const t of cardTables) {
    assert(planTables.some(p => subsequence(words(t), words(p))), `Plan lost exercise skills: ${entry.chapter}`);
  }
}
const scope3 = registry.plans.find(p => p.chapter === 'kapitola_03').headings;
assert(scope3.find(x => x.id === 'sec-momenty').optional, 'Nested optional heading');
assert(!scope3.find(x => x.id === 'sec-excel-poloha').optional, 'Optional scope must end');
assert(scope3.find(x => x.title.startsWith('14.')).optional, 'Optional exercise');
assert(!scope3.find(x => x.title.startsWith('13.')).optional, 'Required exercise');
const bibliography = parsed.get(path.resolve(refs, 'literatura.md'));
for (const key of registry.bibliography.citation_keys) assert(ids(bibliography).has(`ref-${key}`));
for (const f of files(packageRoot)) assert(!/(?:^|[\\/])(?:sources|node_modules|\.git)(?:[\\/]|$)/.test(f), `Unexpected package file ${f}`);
assert(!files(refs).some(f => /kapitola_0[78]\.md$|\.xlsx$/.test(f)));

// Claude skill: same files as the plugin skill, only the frontmatter differs.
let claude = 'not checked (no Claude skill directory given)';
if (claudeRoot) {
  assert.equal(path.basename(claudeRoot), skillName, 'Claude skill folder must match the skill name');
  const claudeText = read(path.join(claudeRoot, 'SKILL.md'));
  const {frontmatter: yaml, body} = splitSkill(claudeText);
  assert.equal(body, splitSkill(skill).body, 'Claude SKILL.md body must match the plugin skill');
  const lines = yaml.split('\n');
  assert.equal(lines.length, 2, 'Claude frontmatter has exactly name and description');
  const yamlName = lines[0].match(/^name: ([a-z0-9-]+)$/)?.[1];
  const yamlDescription = JSON.parse(lines[1].match(/^description: (".*")$/)[1]);
  assert.equal(yamlName, frontmatter.name);
  assert(yamlName.length <= 64 && !/anthropic|claude/.test(yamlName), 'Claude skill name rules');
  assert.equal(yamlDescription, frontmatter.description);
  assert(yamlDescription.length <= 1024 && !/[<>]/.test(yamlDescription), 'Claude skill description rules');
  const rel = (base, f) => path.relative(base, f).split(path.sep).join('/');
  const expected = files(skillDir).map(f => rel(skillDir, f)).sort();
  const actual = files(claudeRoot).map(f => rel(claudeRoot, f)).sort();
  assert.deepEqual(actual, expected, 'Claude skill file list');
  for (const f of expected.filter(f => f !== 'SKILL.md')) {
    assert.equal(hash(path.join(claudeRoot, f)), hash(path.join(skillDir, f)), `Claude skill file differs: ${f}`);
  }
  claude = {skill: yamlName, files: actual.length, descriptionChars: yamlDescription.length};
}

// Gemini skill: the Claude skill without SVG files. Chapters swap image lines
// for web links; a generated register keeps every caption and description.
let gemini = 'not checked (no Gemini skill directory given)';
if (geminiRoot) {
  assert(claudeRoot, 'The Gemini check compares against the Claude skill');
  assert.equal(path.basename(geminiRoot), skillName, 'Gemini skill folder must match the skill name');
  const rel = (base, f) => path.relative(base, f).split(path.sep).join('/');
  const geminiFiles = files(geminiRoot).map(f => rel(geminiRoot, f)).sort();
  // Authoring guard from the observed upload error; Google documents no exact limit.
  assert(geminiFiles.length <= 100, `Gemini skill has ${geminiFiles.length} files (limit 100)`);
  assert(Math.max(...geminiFiles.map(f => f.split('/').length)) <= 10, 'Gemini skill nesting depth');
  assert(!geminiFiles.some(f => /\.svg$/i.test(f) || f.includes('/assets/')), 'Gemini skill must not contain image files');
  assert.equal(read(path.join(geminiRoot, 'SKILL.md')), geminiSkill(read(path.join(claudeRoot, 'SKILL.md'))), 'Gemini SKILL.md');
  assert(read(path.join(geminiRoot, 'SKILL.md')).includes(geminiNote));
  const changed = new Set(['SKILL.md', 'references/KAPITOLY.json', 'references/INDEX.md', 'references/obrazky.md',
    ...bundled.map(d => `references/${d.path}`)]);
  const claudeFiles = files(claudeRoot).map(f => rel(claudeRoot, f)).filter(f => !f.startsWith('references/assets/')).sort();
  assert.deepEqual(geminiFiles.filter(f => f !== 'references/obrazky.md'), claudeFiles, 'Gemini file list');
  for (const f of claudeFiles.filter(f => !changed.has(f))) {
    assert.equal(hash(path.join(geminiRoot, f)), hash(path.join(claudeRoot, f)), `Gemini skill file differs: ${f}`);
  }
  const geminiRefs = path.join(geminiRoot, 'references');
  const register = read(path.join(geminiRefs, 'obrazky.md'));
  let figureCount = 0;
  for (const entry of bundled) {
    const webPage = `${web}quarto/${entry.id}.html`;
    const source = parseSource(q, entry.source, false);
    const figs = nodes(source, 'Figure').filter(f => nodes(f, 'Image').length);
    assert.equal(figs.length, nodes(source, 'Image').length, `${entry.id}: every image is a figure`);
    const original = read(path.join(claudeRoot, 'references', entry.path)).split('\n');
    const rewritten = read(path.join(geminiRefs, entry.path)).split('\n');
    assert.equal(rewritten.length, original.length, `${entry.id}: line count`);
    let replaced = 0;
    for (let i = 0; i < original.length; i++) {
      if (original[i] === rewritten[i]) continue;
      assert(imageLine.test(original[i]), `${entry.id}: unexpected change on line ${i + 1}`);
      assert.match(rewritten[i], new RegExp(`^\\[Obrázek ve webové učebnici\\]\\(${webPage.replace(/[.]/g, '\\.')}#fig-[^)]+\\)$`));
      replaced++;
    }
    assert.equal(replaced, figs.length, `${entry.id}: replaced images`);
    assert(!rewritten.some(line => line.includes('../assets/')), `${entry.id}: leftover image link`);
    for (const fig of figs) {
      const id = fig.c[0][0];
      const alt = nodes(fig, 'Image')[0].c[0][2].find(([k]) => k === 'fig-alt')?.[1];
      assert(alt, `${entry.id}/${id}: text description`);
      assert(rewritten.includes(`[Obrázek ve webové učebnici](${webPage}#${id})`), `${entry.id}/${id}: web link`);
      assert(rewritten.includes(`Textový popis obrázku: ${alt}`), `${entry.id}/${id}: description in chapter`);
      assert(register.includes(`{#${id}}`) && register.includes(`Textový popis: ${alt}`), `${entry.id}/${id}: register entry`);
      assert(register.includes(`[V kapitole](${entry.path}#${id})`) && register.includes(`(${webPage}#${id})`), `${entry.id}/${id}: register links`);
      figureCount++;
    }
  }
  assert.equal((register.match(/^### Obrázek \d+\.\d+: /gm) || []).length, figureCount, 'Register entry count');
  const geminiRegistry = JSON.parse(read(path.join(geminiRefs, 'KAPITOLY.json')));
  assert.equal(geminiRegistry.images, 'web_only');
  assert.equal(geminiRegistry.figures.count, figureCount);
  assert.equal(geminiRegistry.figures.sha256, hash(path.join(geminiRefs, 'obrazky.md')));
  for (const entry of geminiRegistry.chapters.filter(c => c.availability === 'bundled')) {
    assert.equal(geminiRegistry.chapters.length, registry.chapters.length);
    assert.equal(entry.sha256, hash(path.join(geminiRefs, entry.path)), `Gemini registry checksum: ${entry.path}`);
  }
  // Every local Markdown link stays inside the skill and reaches an existing file.
  let geminiLinks = 0;
  for (const f of geminiFiles.filter(f => f.endsWith('.md'))) {
    const file = path.join(geminiRoot, f);
    for (const m of read(file).matchAll(/\]\(([^)\s]+)\)/g)) {
      if (/^[a-z][a-z0-9+.-]*:|^\/\/|^#/i.test(m[1])) continue;
      const destination = path.resolve(path.dirname(file), decodeURIComponent(m[1].split('#')[0]));
      assert(!path.relative(geminiRoot, destination).startsWith('..'), `${f}: link leaves skill folder: ${m[1]}`);
      assert(fs.existsSync(destination), `${f}: missing file ${m[1]}`);
      geminiLinks++;
    }
  }
  gemini = {files: geminiFiles.length, figures: figureCount, localLinks: geminiLinks};
}
console.log(JSON.stringify({checks: 'passed', claude, gemini, chapters: 6, catalogChapters: registry.chapters.length, plans: registry.plans.length, overviewEntries: rows,
  math, images, solutions, checkedLinks, citations: registry.bibliography.citation_keys.length}));
