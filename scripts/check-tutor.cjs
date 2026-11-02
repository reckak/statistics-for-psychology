// Independent source-to-package checks; no model or network calls are needed.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const {root, name, source, web, read, files, hash, quarto, pandoc, parseSource,
  nodes, attr, text, documents} = require('./tutor/common.cjs');
const args = process.argv.slice(2);
const option = flag => args.includes(flag) ? args[args.indexOf(flag) + 1] : undefined;
const packageRoot = option('--package') || JSON.parse(read(path.join(root, 'output/tutor/overeni.json'))).package_directory;
const q = quarto(option('--quarto'));
const refs = path.join(packageRoot, 'skills/statistika-tutor/references');
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
assert(Buffer.byteLength(skill) < 1024 * 1024);
assert(!/Registr verze 0\.1\.0|seznam kapitol je prázdný/.test(skill));
const registry = JSON.parse(read(path.join(refs, 'KAPITOLY.json')));
assert.equal(registry.status, 'chapters_available');
assert.equal(registry.package_version, manifest.version);
assert.equal(registry.chapters.length, 6);
assert.equal(registry.overviews.length, 3);
assert(!registry.chapters.some(d => /kapitola_0[78]/.test(d.id)));
for (const entry of [...registry.chapters, ...registry.overviews, registry.introduction, registry.bibliography]) {
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
const bibliography = parsed.get(path.resolve(refs, 'literatura.md'));
for (const key of registry.bibliography.citation_keys) assert(ids(bibliography).has(`ref-${key}`));
for (const f of files(packageRoot)) assert(!/(?:^|[\\/])(?:sources|node_modules|\.git)(?:[\\/]|$)/.test(f), `Unexpected package file ${f}`);
assert(!files(refs).some(f => /kapitola_0[78]\.md$|\.xlsx$/.test(f)));
console.log(JSON.stringify({checks: 'passed', chapters: 6, overviewEntries: rows,
  math, images, solutions, checkedLinks, citations: registry.bibliography.citation_keys.length}));
