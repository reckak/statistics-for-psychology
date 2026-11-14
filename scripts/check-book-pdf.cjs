// Verify the PDF-only rearrangement of the book PDF (all chapters and overviews).
// Run after scripts/render-book-pdf.ps1, which assembles tmp/pdf-book/quarto/kniha.qmd.
// Usage: node scripts/check-book-pdf.cjs [path/to/quarto.exe]
const assert = require('node:assert/strict');
const {spawnSync} = require('node:child_process');
const path = require('node:path');
const fs = require('node:fs');
const root = path.resolve(__dirname, '..');
const build = path.join(root, 'tmp/pdf-book');
const bundled = 'C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe';
const quarto = process.argv[2] || (fs.existsSync(bundled) ? bundled : 'quarto');
assert(fs.existsSync(path.join(build, 'quarto/kniha.qmd')), 'Run scripts/render-book-pdf.ps1 first.');
// Chapters of the book and their exercise counts, both read from the sources.
const chapters = [...fs.readFileSync(path.join(root, '_quarto.yml'), 'utf8')
  .matchAll(/quarto\/kapitola_(\d\d)\.qmd/g)].map(m => Number(m[1]));
assert(chapters.length > 0, 'No chapters found in _quarto.yml');
const expected = Object.fromEntries(chapters.map(c => [c, fs.readFileSync(
  path.join(root, `quarto/kapitola_${String(c).padStart(2, '0')}.qmd`), 'utf8')
  .split('title="Ukázat řešení"').length - 1]));
const inPdf = target => chapters.includes(Number(target.match(/kapitola_(\d\d)\./)[1]));

function parse(filtered) {
  const args = ['pandoc', 'quarto/kniha.qmd', '--from=markdown', '--to=json'];
  if (filtered) args.push('--lua-filter=book.lua');
  const run = spawnSync(quarto, args, {cwd: build, encoding: 'utf8', maxBuffer: 1 << 28});
  assert.equal(run.status, 0, run.stderr);
  return JSON.parse(run.stdout);
}
function nodes(value, type, result = []) {
  if (Array.isArray(value)) value.forEach(x => nodes(x, type, result));
  else if (value && typeof value === 'object') {
    if (value.t === type) result.push(value);
    Object.values(value).forEach(x => nodes(x, type, result));
  }
  return result;
}
// Links are rewritten on purpose; compare everything else.
const normal = value => JSON.stringify(value, (k, v) =>
  v && v.t === 'Link' ? {...v, c: [v.c[0], v.c[1], ['', '']]} : v);
const counts = list => list.reduce((m, x) => m.set(x, (m.get(x) || 0) + 1), new Map());
const before = parse(false), after = parse(true);

// Overview paragraphs that only point to chapters outside the PDF are omitted on purpose.
const chapterLinks = block => nodes(block, 'Link').map(x => x.c[2][0])
  .filter(t => /kapitola_\d\d\.(qmd|html)/.test(t));
const onlyLater = block => {
  const t = chapterLinks(block);
  return t.length > 0 && t.every(x => !inPdf(x));
};
const overviews = before.blocks.findIndex(b => b.t === 'Header' && b.c[1][0] === 'pdf-literatura');
assert(overviews > 0, 'Literature heading not found');
const omitted = before.blocks.slice(overviews).filter(b => b.t === 'Para' && onlyLater(b));
const kept = before.blocks.filter(b => !omitted.includes(b));
// Chapter text keeps its references to chapters outside the PDF.
const afterText = new Set(nodes(after, 'Para').map(p => normal(p.c)));
for (const para of nodes(before.blocks.slice(0, overviews), 'Para').filter(onlyLater)) {
  assert(afterText.has(normal(para.c)), 'Chapter paragraph referring to chapters outside the PDF was dropped');
}

// Nothing else from the source text is lost; overview tables only add converted content.
for (const type of ['Math', 'Code', 'Image', 'Cite']) {
  const b = counts(nodes(kept, type).map(normal)), a = counts(nodes(after, type).map(normal));
  for (const [item, n] of b) assert((a.get(item) || 0) >= n, `${type} lost: ${item.slice(0, 120)}`);
}
assert.equal(nodes(after, 'Table').length, nodes(before, 'Table').length + 3, 'Three overview tables expected');
assert(!nodes(after, 'RawBlock').some(b => b.c[0] === 'html' && b.c[1].includes('<table')));

// Exercises and solutions: per chapter, reciprocal links, solutions after the section.
const headers = nodes(after, 'Header');
const index = id => after.blocks.findIndex(b => b.t === 'Header' && b.c[1][0] === id);
const links = new Set(nodes(after, 'Link').map(x => x.c[2][0]));
const beforeSolutions = nodes(before, 'Div').filter(b =>
  b.c[0][2].some(([k, v]) => k === 'title' && v === 'Ukázat řešení'));
assert.equal(beforeSolutions.length, Object.values(expected).reduce((a, b) => a + b));
for (const [chapter, total] of Object.entries(expected)) {
  const key = `k${String(chapter).padStart(2, '0')}`;
  const start = index(`sec-kapitola-${key.slice(1)}`), solutions = index(`pdf-${key}-solutions`);
  const next = after.blocks.findIndex((b, i) => i > start && b.t === 'Header' && b.c[0] === 1);
  assert(start >= 0 && solutions > start && (next < 0 || solutions < next), `Chapter ${chapter}: solutions misplaced`);
  for (let i = 1; i <= total; i++) {
    const sol = index(`pdf-${key}-solution-${i}`);
    assert(sol > solutions && (next < 0 || sol < next), `Chapter ${chapter}, solution ${i}: wrong location`);
    assert(links.has(`#pdf-${key}-solution-${i}`), `Chapter ${chapter}, solution ${i}: no link to it`);
    const back = after.blocks[sol + 2];
    const target = back.c[0].c[2][0].slice(1);
    const ex = index(target);
    assert(ex > start && ex < solutions, `Chapter ${chapter}, exercise ${i}: return link broken`);
  }
  assert.equal(index(`pdf-${key}-solution-${total + 1}`), -1, `Chapter ${chapter}: unexpected solution`);
}
assert(!nodes(after, 'Div').some(b => b.c[0][2].some(([k, v]) => k === 'title' && v === 'Ukázat řešení')));

// Internal links resolve; relative links to web pages or workbooks are gone.
const ids = new Set();
const collect = value => {
  if (Array.isArray(value)) value.forEach(collect);
  else if (value && typeof value === 'object') {
    if (['Header', 'Div', 'Span', 'Image', 'Figure', 'Table', 'CodeBlock'].includes(value.t)) {
      const attr = value.t === 'Header' ? value.c[1] : value.c[0];
      if (attr && attr[0]) ids.add(attr[0]);
    }
    if ((value.t === 'RawInline' || value.t === 'RawBlock') && value.c[0] === 'typst') {
      for (const m of value.c[1].matchAll(/<([\w-]+)>/g)) ids.add(m[1]);
    }
    Object.values(value).forEach(collect);
  }
};
collect(after.blocks);
for (const link of links) {
  assert(!/\.qmd(?:#|$)|\.html(?:#|$)/.test(link) || link.startsWith('https://'), `Relative page link left: ${link}`);
  assert(!/^(\.\.\/)?data\//.test(link), `Relative workbook link left: ${link}`);
  if (link.startsWith('#')) assert(ids.has(link.slice(1)), `Internal link without target: ${link}`);
}

// Overview rows explained only in chapters outside the PDF are omitted; others keep their anchors.
const web = 'https://reckak.github.io/statistics-for-psychology/quarto/';
for (const table of nodes(after, 'Table').slice(-3)) {
  for (const body of table.c[4]) for (const row of body[3]) {
    const targets = nodes(row, 'Link').map(x => x.c[2][0]);
    const outside = targets.filter(t => /kapitola_\d\d\.html/.test(t) && !inPdf(t)).length;
    const inside = targets.filter(t => t.startsWith('#')).length;
    assert(!(outside > 0 && inside === 0), `Overview row only for chapters outside the PDF: ${JSON.stringify(targets)}`);
    assert(!targets.some(t => t.startsWith(web) && ids.has(t.split('#')[1])),
      `Overview link leaves the PDF unnecessarily: ${targets}`);
  }
}
const duplicates = headers.map(h => h.c[1][0]).filter((id, i, all) => id && all.indexOf(id) !== i);
assert.equal(duplicates.length, 0, `Duplicate heading identifiers: ${duplicates}`);
console.log(`Book PDF transformation: ${beforeSolutions.length} solutions moved within chapters ${chapters.join(', ')} ` +
  `with reciprocal links; math, code, images and citations preserved; ${links.size} link targets checked; ` +
  `${omitted.length} overview paragraphs about chapters outside the PDF omitted.`);
