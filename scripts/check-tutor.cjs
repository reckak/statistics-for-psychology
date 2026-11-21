// Independent source-to-package checks; no model or network calls are needed.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const {root, name, source, web, read, files, hash, quarto, pandoc, parseSource,
  nodes, attr, text, documents, skillName, splitSkill, imageLine, geminiSkill, geminiNote, geminiRenames, geminiAllowed, geminiNames,
  headingLines, divEnd, solutionOpen, figuresLine, figureDataChapters, figureDataBlock, registerPath} = require('./tutor/common.cjs');
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
// The packaged registry is a small catalog (version, revision, chapter list);
// headings, concept inventories, line ranges and checksums are verification
// data written next to the staged packages, outside every archive.
const registryText = read(path.join(refs, 'KAPITOLY.json'));
const registry = JSON.parse(registryText);
const dataPath = option('--data') || lastExport.check_data;
assert(path.relative(packageRoot, dataPath).startsWith('..'), 'Verification data stays outside the package');
const data = JSON.parse(read(dataPath));
assert.equal(registry.status, 'chapters_available');
assert.equal(registry.schema_version, 3);
assert.equal(registry.package_version, manifest.version);
assert.equal(data.package_version, manifest.version);
assert.equal(data.source_revision, registry.source_revision);
assert(Buffer.byteLength(registryText) <= 8000, 'Keep the packaged registry a small catalog');
for (const key of ['plans', 'source_hashes']) assert(!(key in registry), `Verification data in the packaged registry: ${key}`);
assert(!/"(?:sha256|headings|concepts)"/.test(registryText), 'Verification data in the packaged registry');
assert.equal(registry.chapters.length, bookChapters(q).length);
assert.equal(registry.overviews.length, 3);
assert.deepEqual(registry.chapters, data.chapters.map(d => ({id: d.id, number: d.number, title: d.title, path: d.path,
  plan: d.plan, source: d.source, availability: d.availability, web_url: d.web_url})), 'Registry catalog and verification data');
const bundled = data.chapters.filter(d => d.availability === 'bundled');
const packagedChapters = documents.filter(d => d.kind === 'chapter');
assert.deepEqual(bundled.map(d => d.id), packagedChapters.map(d => d.id), 'Every chapter of the book is bundled');
assert.equal(data.plans.length, bundled.length);
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
for (const entry of [...bundled, ...data.plans, ...data.overviews, data.introduction, data.bibliography, ...data.figures.registers]) {
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
const expectedSolutions = {kapitola_01: 9, kapitola_02: 10, kapitola_03: 16,
  kapitola_04: 10, kapitola_05: 12, kapitola_06: 16, kapitola_07: 14,
  kapitola_08: 14, kapitola_09: 15, kapitola_10: 18};
for (const d of packagedChapters) assert(Number.isInteger(expectedSolutions[d.id]), `${d.id}: expected number of exercise solutions`);
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
    // The package holds a PNG rendering; its checksum and size are verified with the figure registers.
    const output = nodes(after, 'Image').find(n => path.basename(n.c[2][0]) === path.basename(input).replace(/\.svg$/, '.png'));
    assert(output && fs.existsSync(path.resolve(refs, path.dirname(d.output), output.c[2][0])), `Missing image ${input}`);
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

const entities = {amp: '&', lt: '<', gt: '>', quot: '"', apos: "'", nbsp: ' '};
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
      const sourceCode = [...cell[1].matchAll(/<code(?:\s[^>]*)?>([\s\S]*?)<\/code>/g)].map(m => decode(m[1]));
      const outputCode = nodes(section[field * 2 + 1], 'Code').map(n => n.c[1]);
      assert.deepEqual(outputCode, sourceCode, `${d.id}/${row[1]}: code`);
    }
  }
  rows += expected.length;
}
// Check plans against source goals, all section scopes, every overview row
// referring to this chapter, and the original chapter-card skill table.
for (const entry of data.plans) {
  const chapter = bundled.find(x => x.id === entry.chapter);
  const before = parseSource(q, chapter.source);
  const plan = parsed.get(path.resolve(refs, entry.path));
  const planText = read(path.join(refs, entry.path));
  assert(planText.startsWith(`# ${chapter.number}. ${chapter.title}\n`));
  assert.equal(data.source_hashes[entry.card], hash(path.join(root, entry.card)));
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
  for (const overview of data.overviews) {
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
const scope3 = data.plans.find(p => p.chapter === 'kapitola_03').headings;
assert(scope3.find(x => x.id === 'sec-momenty').optional, 'Nested optional heading');
assert(!scope3.find(x => x.id === 'sec-excel-poloha').optional, 'Optional scope must end');
assert(scope3.find(x => x.title.startsWith('14.')).optional, 'Optional exercise');
assert(!scope3.find(x => x.title.startsWith('13.')).optional, 'Required exercise');

// Line ranges are navigation for reading one step at a time. This verifies them
// against the exported Markdown only; what a client actually loads is a client test.
const span = (a, b) => a === b ? `${a}` : `${a}–${b}`;
const blank = (lines, from, to) => lines.slice(from - 1, to).every(l => l.trim() === '');
let checkedRanges = 0;
const overviewText = {};
for (const entry of data.plans) {
  const chapter = bundled.find(x => x.id === entry.chapter);
  const markdown = read(path.join(refs, chapter.path));
  const lines = markdown.split('\n');
  const planText = read(path.join(refs, entry.path));
  const marks = headingLines(markdown);
  const {sections, exercises, optional} = entry.ranges;
  assert.equal(sections.length, marks.length, `${entry.chapter}: one range per heading`);
  assert.equal(sections.length, entry.headings.length);
  sections.forEach((s, i) => {
    const label = `${entry.chapter}/${s.id}`;
    assert.equal(s.id, entry.headings[i].id, `${label}: heading order`);
    assert.equal(s.start, marks[i].line, `${label}: range starts at its heading`);
    assert.equal(s.level, marks[i].level, `${label}: heading level`);
    // Explicit identifiers are written on the heading line itself.
    if (lines[s.start - 1].includes('{#')) assert(lines[s.start - 1].includes(`{#${s.id}`), `${label}: identifier on the first line`);
    const next = marks.slice(i + 1).find(m => m.level <= s.level);
    const limit = next ? next.line : lines.length + 1;
    assert(s.end >= s.start && s.end < limit, `${label}: range ends before the next heading of the same or a higher level`);
    assert(lines[s.end - 1].trim() !== '' && blank(lines, s.end + 1, limit - 1), `${label}: range ends on the last line of the section`);
    const h = entry.headings[i];
    if (h.level > 1 && !h.exercise && !/^sec-shrnuti/.test(h.id)) {
      assert(planText.includes(`](../${chapter.path}#${s.id}) — řádky ${span(s.start, s.end)}`), `${label}: range in the plan`);
    }
    checkedRanges++;
  });
  // Section intro: from the heading to the last line before the first subsection.
  sections.forEach((s, i) => {
    if (!s.intro) return;
    const child = sections[i + 1];
    assert(child && child.level > s.level && s.intro[0] === s.start && s.intro[1] > s.start && s.intro[1] < child.start, `${entry.chapter}/${s.id}: section intro range`);
    assert(lines[s.intro[1] - 1].trim() !== '' && blank(lines, s.intro[1] + 1, child.start - 1), `${entry.chapter}/${s.id}: section intro ends before the subsection`);
    checkedRanges++;
  });
  // Overview entries listed in the plan carry the line range of the entry.
  for (const concept of entry.concepts) {
    const overview = data.overviews.find(o => o.id === concept.overview);
    const overviewLines = (overviewText[overview.id] ||= read(path.join(refs, overview.path)).split('\n'));
    assert(overviewLines[concept.lines[0] - 1].startsWith('## ') && overviewLines[concept.lines[0] - 1].includes(`{#${concept.id}`), `${entry.chapter}: overview entry ${concept.id} starts at its heading`);
    assert(!overviewLines.slice(concept.lines[0], concept.lines[1]).some(l => /^## /.test(l)), `${entry.chapter}: overview entry ${concept.id} holds one entry`);
    assert(planText.includes(`](../${overview.path}#${concept.id}) — řádky ${span(...concept.lines)}`), `${entry.chapter}: overview entry ${concept.id} range in the plan`);
    checkedRanges++;
  }
  const located = entry.headings.map((h, i) => ({...h, ...sections[i]}));
  const exerciseHeadings = located.filter(h => h.exercise && h.level === 3);
  assert.deepEqual(exercises.map(e => e.id), exerciseHeadings.map(h => h.id), `${entry.chapter}: exercise ranges`);
  let solutionBlocks = 0;
  exercises.forEach((e, k) => {
    const h = exerciseHeadings[k];
    const label = `${entry.chapter}/${h.title}`;
    const parts = [...e.statement.map(r => ['statement', ...r]), ...e.solutions.map(r => ['solution', ...r])].sort((a, b) => a[1] - b[1]);
    assert(e.statement.length && e.solutions.length, `${label}: statement and solution`);
    assert.deepEqual([parts[0][0], parts[0][1]], ['statement', h.start], `${label}: statement starts at the exercise heading`);
    assert.equal(parts.at(-1)[2], h.end, `${label}: ranges cover the exercise`);
    parts.forEach(([kind, a, b], j) => {
      assert(a <= b, `${label}: ordered range`);
      if (j) assert(a > parts[j - 1][2] && blank(lines, parts[j - 1][2] + 1, a - 1), `${label}: ranges neither overlap nor skip text`);
      if (kind === 'statement') {
        for (let n = a; n <= b; n++) {
          assert(lines[n - 1] !== '**Ukázat řešení**' && !solutionOpen(lines, n - 1), `${label}: statement range contains a solution`);
        }
      } else {
        assert(solutionOpen(lines, a - 1), `${label}: solution range starts with the solution block`);
        assert.equal(divEnd(lines, a), b, `${label}: solution range ends with the solution block`);
        solutionBlocks++;
      }
      checkedRanges++;
    });
    assert(planText.includes(`zadání řádky ${e.statement.map(r => span(...r)).join(' a ')}; řešení řádky ${e.solutions.map(r => span(...r)).join(' a ')}`),
      `${label}: exercise ranges in the plan`);
  });
  assert.equal(solutionBlocks, expectedSolutions[entry.chapter], `${entry.chapter}: every solution has a range`);
  assert.deepEqual(optional.map(o => o.id), entry.optional_blocks, `${entry.chapter}: optional block ranges`);
  for (const o of optional) {
    const label = `${entry.chapter}/${o.id}`;
    assert(new RegExp(`^:{3,} \\{#${o.id}[ }]`).test(lines[o.start - 1]), `${label}: range starts with the optional block`);
    assert.equal(divEnd(lines, o.start), o.end, `${label}: range ends with the optional block`);
    assert(planText.includes(`](../${chapter.path}#${o.id}) — řádky ${span(o.start, o.end)}`), `${label}: range in the plan`);
    checkedRanges++;
  }
  // Each figure belongs to the innermost section that contains its block.
  const chapterFigures = data.figures.entries.filter(f => f.chapter === entry.chapter);
  assert.deepEqual(sections.flatMap(s => s.figures).sort(), chapterFigures.map(f => f.id).sort(), `${entry.chapter}: figures in the plan`);
  for (const s of sections) for (const id of s.figures) {
    const at = lines.findIndex(l => new RegExp(`^:{3,} \\{#${id}[ }]`).test(l)) + 1;
    assert(at >= s.start && at <= s.end, `${entry.chapter}/${id}: figure inside its section`);
    assert(!sections.some(x => x.start > s.start && x.start <= at), `${entry.chapter}/${id}: innermost section`);
    const f = chapterFigures.find(x => x.id === id);
    // A figure inside an optional block (or an optional section) is marked as such in the plan.
    const isOptional = optional.some(o => at >= o.start && at <= o.end) || entry.headings[sections.indexOf(s)].optional;
    assert.equal(s.optionalFigures.includes(id), isOptional, `${entry.chapter}/${id}: optional figure flag`);
    assert(planText.includes(`[${f.number}](../${registerPath(entry.chapter)}#${f.id}) (řádky ${span(...f.range)}${f.data ? ', s daty' : ''}${isOptional ? ', v nepovinné části' : ''})`), `${entry.chapter}/${id}: figure link in the plan`);
  }
  // Every interactive page the chapter links to is named in the plan.
  const vizPages = [...new Set([...markdown.matchAll(/quarto\/(viz_[a-z0-9_]+)\.html/g)].map(m => m[1]))];
  assert.deepEqual([...new Set(sections.flatMap(s => s.viz))].sort(), [...vizPages].sort(), `${entry.chapter}: interactive pages`);
  for (const page of vizPages) {
    assert(fs.existsSync(path.join(root, 'quarto', `${page}.qmd`)), `Missing interactive page ${page}`);
    // The offer carries the full address as plain text, so that a tutor copies it instead of composing one.
    assert(planText.includes(` — <${web}quarto/${page}.html>`), `${entry.chapter}: ${page} in the plan`);
  }
}

// Every interactive page of the book has its address and advice in the visualization guide.
const vizGuide = read(path.join(refs, 'VIZUALIZACE.md'));
const bookViz = [...read(path.join(root, '_quarto.yml')).matchAll(/^\s*-\s*quarto\/(viz_[a-z0-9_]+)\.qmd\s*$/gm)].map(m => m[1]);
assert(bookViz.length > 0, 'Interactive pages in _quarto.yml');
for (const page of bookViz) assert(vizGuide.includes(`${web}quarto/${page}.html |`), `Interactive page missing in VIZUALIZACE.md: ${page}`);
assert.equal((vizGuide.match(/quarto\/viz_[a-z0-9_]+\.html/g) || []).length, bookViz.length, 'VIZUALIZACE.md lists exactly the interactive pages of the book');
// One figure register per chapter ships in every variant.
assert(index.includes(figuresLine(true)), 'Figure registers in the index');
assert.equal(registry.figures.count, data.figures.entries.length);
assert.deepEqual(registry.figures.registers, bundled.map(d => registerPath(d.id)));
assert.equal(registry.figures.with_data, data.figures.entries.filter(f => f.data).length);
// Descriptions are plain text, so they are compared after parsing, not as raw
// Markdown: the writer escapes characters such as "<".
const squeeze = s => s.replace(/\s+/g, ' ').trim();
const paragraphs = ast => new Set(nodes(ast, 'Para').map(p => squeeze(text(p))));
const pngSize = file => {
  const b = fs.readFileSync(file);
  assert.equal(b.subarray(0, 8).toString('hex'), '89504e470d0a1a0a', `Not a PNG file: ${file}`);
  assert.equal(b.subarray(12, 16).toString('latin1'), 'IHDR', `PNG header: ${file}`);
  return {width: b.readUInt32BE(16), height: b.readUInt32BE(20)};
};
let registerFigures = 0, figuresWithData = 0, dataRows = 0;
for (const entry of bundled) {
  const source = parseSource(q, entry.source, false);
  const figs = nodes(source, 'Figure').filter(f => nodes(f, 'Image').length);
  assert.equal(figs.length, nodes(source, 'Image').length, `${entry.id}: every image is a figure`);
  const registerFile = path.join(refs, registerPath(entry.id));
  const register = read(registerFile);
  const registerLines = register.split('\n');
  assert(index.includes(`](${registerPath(entry.id)})`), `${entry.id}: register in the index`);
  assert.equal(registerLines[0], `# Obrázky kapitoly ${entry.number}: ${entry.title}`);
  const registerParagraphs = paragraphs(parsed.get(path.resolve(registerFile)));
  const marks = headingLines(register).filter(h => h.level === 2);
  assert.equal(marks.length, figs.length, `${entry.id}: one register entry per figure`);
  const records = data.figures.entries.filter(f => f.chapter === entry.id);
  assert.deepEqual(records.map(r => r.id), figs.map(fig => fig.c[0][0]), `${entry.id}: register order follows the chapter`);
  const wantsData = figureDataChapters.includes(entry.id);
  figs.forEach((fig, i) => {
    const id = fig.c[0][0], label = `${entry.id}/${id}`;
    const image = nodes(fig, 'Image')[0];
    const alt = image.c[0][2].find(([k]) => k === 'fig-alt')?.[1];
    const record = records[i];
    assert(record && alt, `${label}: register record and text description`);
    // The package holds a PNG rendering of the SVG source, and no SVG.
    const sourceSvg = path.relative(root, path.resolve(root, path.dirname(entry.source), image.c[2][0])).split(path.sep).join('/');
    assert.equal(record.file, sourceSvg.replace(/\.svg$/, '.png'), `${label}: PNG beside the source path`);
    const png = path.join(refs, record.file);
    assert.equal(hash(png), record.sha256, `${label}: PNG written by this export`);
    assert.deepEqual(pngSize(png), {width: record.width, height: record.height}, `${label}: PNG size`);
    assert(record.width >= 500 && record.height >= 250, `${label}: PNG too small to read`);
    assert.equal(record.image, `${web}${sourceSvg}`, `${label}: web address of the image`);
    assert(fs.existsSync(path.join(root, sourceSvg)), `${label}: source figure`);
    // Register entry: heading, range, description, links and web addresses.
    const [start, end] = record.range;
    assert.equal(registerLines[start - 1], `## Obrázek ${record.number} {#${id}}`, `${label}: register range starts at the entry`);
    assert.equal(marks[i].line, start, `${label}: register entry order`);
    const limit = marks[i + 1] ? marks[i + 1].line : registerLines.length + 1;
    assert(end >= start && end < limit && registerLines[end - 1].trim() !== '' && blank(registerLines, end + 1, limit - 1), `${label}: register range ends with the entry`);
    const own = registerLines.slice(start - 1, end);
    assert(registerParagraphs.has(squeeze(`Textový popis: ${alt}`)), `${label}: text description`);
    assert(own.includes(`[V kapitole](../${entry.path}#${id}) · [Soubor obrázku](../${record.file})`), `${label}: register links`);
    assert(own.includes(`Stránka učebnice s obrázkem: ${web}quarto/${entry.id}.html#${id}`) && own.includes(`Samotný obrázek na webu: ${record.image}`), `${label}: web addresses`);
    // Data for redrawing: present for every figure of the chapters that export them.
    assert.equal(Boolean(record.data), wantsData, `${label}: figure data`);
    const open = own.indexOf('```text');
    if (!record.data) assert.equal(open, -1, `${label}: no data block`);
    else {
      assert.equal(record.data.figure, path.basename(sourceSvg, '.svg'), `${label}: data belong to this figure`);
      assert(['data', 'simulace', 'krivka', 'sloupce', 'schema'].includes(record.data.kind), `${label}: data kind`);
      if (record.data.kind === 'schema') assert.equal(open, -1, `${label}: a diagram has no data block`);
      else {
        assert(record.data.panels.length > 0 && open > 0 && own[open - 2] === 'Data pro překreslení:' && own.at(-1) === '```', `${label}: data block`);
        assert.deepEqual(own.slice(open + 1, -1), figureDataBlock(record.data), `${label}: data block matches the exported data`);
        for (const [k, p] of record.data.panels.entries()) {
          assert(p.title && p.type && p.x.label && p.y.label && p.series.length > 0, `${label}: panel ${k + 1} is described`);
          for (const axis of [p.x, p.y]) if (axis.range) assert(axis.range.length === 2 && axis.range[0] < axis.range[1], `${label}: axis range`);
          for (const series of p.series) {
            const need = {histogram: ['od', 'do', 'cetnost']}[series.mark] || ['x', 'y'];
            assert(need.every(c => series.data.columns.includes(c)), `${label}: columns of ${series.name}`);
            assert(series.data.rows.length > 0, `${label}: ${series.name} has rows`);
            for (const row of series.data.rows) {
              assert.equal(row.length, series.data.columns.length, `${label}: row width in ${series.name}`);
              for (const c of need) assert(Number.isFinite(row[series.data.columns.indexOf(c)]), `${label}: finite numbers in ${series.name}`);
            }
            dataRows += series.data.rows.length;
          }
        }
      }
      figuresWithData++;
    }
    registerFigures++;
  });
}
assert.equal(registerFigures, data.figures.entries.length, 'Every figure of the book is in a register');
assert(!files(packageRoot).some(f => /\.svg$/i.test(f)), 'The packages ship PNG figures, no SVG');
assert(!fs.existsSync(path.join(refs, 'obrazky.md')), 'Figure registers are per chapter');

const bibliography = parsed.get(path.resolve(refs, 'literatura.md'));
for (const key of data.bibliography.citation_keys) assert(ids(bibliography).has(`ref-${key}`));
for (const f of files(packageRoot)) assert(!/(?:^|[\\/])(?:sources|node_modules|\.git)(?:[\\/]|$)/.test(f), `Unexpected package file ${f}`);
assert(!files(refs).some(f => /\.xlsx$/.test(f)));
assert(!fs.existsSync(path.join(refs, 'PRIPOJENI-KAPITOL.md')), 'The authoring guide is not packaged');

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
  assert(!geminiFiles.some(f => /\.(svg|png)$/i.test(f) || f.includes('/assets/')), 'Gemini skill must not contain image files');
  assert.equal(read(path.join(geminiRoot, 'SKILL.md')), geminiSkill(read(path.join(claudeRoot, 'SKILL.md'))), 'Gemini SKILL.md');
  assert(read(path.join(geminiRoot, 'SKILL.md')).includes(geminiNote));
  // The upload dialog accepts only CSV, PY, TXT and MD files.
  for (const f of geminiFiles) assert(geminiAllowed.test(f), `Gemini skill file type: ${f}`);
  const renamed = f => f.replace(/[^/]+$/, n => geminiRenames[n] || n);
  const changed = new Set(['SKILL.md', 'references/KAPITOLY.json', 'references/INDEX.md', 'references/LICENCE.md',
    ...bundled.flatMap(d => [`references/${d.path}`, `references/${registerPath(d.id)}`])]);
  const claudeFiles = files(claudeRoot).map(f => rel(claudeRoot, f)).filter(f => !f.startsWith('references/assets/')).sort();
  assert.deepEqual(geminiFiles, claudeFiles.map(renamed).sort(), 'Gemini file list');
  for (const f of claudeFiles.filter(f => !changed.has(f))) {
    assert.equal(hash(path.join(geminiRoot, renamed(f))), hash(path.join(claudeRoot, f)), `Gemini skill file differs: ${f}`);
  }
  const geminiRefs = path.join(geminiRoot, 'references');
  // Same registers without the links to image files; the intro says so.
  for (const entry of bundled) {
    const fullRegister = read(path.join(claudeRoot, 'references', registerPath(entry.id))).split('\n');
    const textRegister = read(path.join(geminiRefs, registerPath(entry.id))).split('\n');
    assert.equal(textRegister.length, fullRegister.length, `${entry.id}: Gemini figure register line count`);
    fullRegister.forEach((line, i) => {
      if (line === textRegister[i]) return;
      assert(i === 2 || textRegister[i] === line.replace(/ · \[Soubor obrázku\]\([^)]+\)/, ''), `${entry.id}: Gemini figure register line ${i + 1}`);
    });
    assert(textRegister[2].startsWith('Soubory obrázků nejsou v této verzi přibalené.'));
    assert(!textRegister.some(l => l.includes('Soubor obrázku') || l.includes('../assets/')), `${entry.id}: Gemini figure register links no image file`);
    assert.equal(data.gemini.registers[entry.id], hash(path.join(geminiRefs, registerPath(entry.id))), `${entry.id}: Gemini register checksum`);
  }
  assert.equal(read(path.join(geminiRefs, 'INDEX.md')), geminiNames(read(path.join(claudeRoot, 'references/INDEX.md')).replace(figuresLine(true), figuresLine(false))), 'Gemini INDEX.md');
  assert.equal(read(path.join(geminiRefs, 'LICENCE.md')), geminiNames(read(path.join(claudeRoot, 'references/LICENCE.md'))), 'Gemini LICENCE.md');
  let figureCount = 0;
  for (const entry of bundled) {
    const webPage = `${web}quarto/${entry.id}.html`;
    const source = parseSource(q, entry.source, false);
    const figs = nodes(source, 'Figure').filter(f => nodes(f, 'Image').length);
    assert.equal(figs.length, nodes(source, 'Image').length, `${entry.id}: every image is a figure`);
    const original = read(path.join(claudeRoot, 'references', entry.path)).split('\n');
    const rewritten = read(path.join(geminiRefs, entry.path)).split('\n');
    const rewrittenParagraphs = paragraphs(parse(path.join(geminiRefs, entry.path)));
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
      assert(rewrittenParagraphs.has(squeeze(`Textový popis obrázku: ${alt}`)), `${entry.id}/${id}: description in chapter`);
      figureCount++;
    }
  }
  const {images: geminiImages, ...geminiRegistry} = JSON.parse(read(path.join(geminiRefs, 'KAPITOLY.txt')));
  assert.equal(geminiImages, 'web_only');
  assert.deepEqual(geminiRegistry, registry, 'Gemini registry differs only by the image note');
  assert.equal(geminiRegistry.figures.count, figureCount);
  for (const entry of bundled) {
    assert.equal(data.gemini.chapters[entry.id], hash(path.join(geminiRefs, entry.path)), `Gemini chapter checksum: ${entry.path}`);
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
console.log(JSON.stringify({checks: 'passed', claude, gemini, chapters: bundled.length, catalogChapters: registry.chapters.length, plans: data.plans.length, overviewEntries: rows,
  math, images, solutions, checkedLinks, checkedRanges, registerFigures, figuresWithData, dataRows, interactivePages: bookViz.length, skillBytes: Buffer.byteLength(skill), registryBytes: Buffer.byteLength(registryText),
  citations: data.bibliography.citation_keys.length}));
