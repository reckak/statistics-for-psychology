// Verify the PDF-only rearrangement without changing or rendering the HTML book.
// Usage: node scripts/check-chapter-pdf.cjs [path/to/quarto.exe]
const assert = require('node:assert/strict');
const {spawnSync} = require('node:child_process');
const path = require('node:path');
const fs = require('node:fs');
const root = path.resolve(__dirname, '..');
const bundled = 'C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe';
const quarto = process.argv[2] || (fs.existsSync(bundled) ? bundled : 'quarto');
function parse(filtered) {
  const args = ['pandoc', 'quarto/kapitola_03.qmd', '--from=markdown', '--to=json'];
  if (filtered) args.push('--lua-filter=scripts/pdf/chapter.lua');
  const run = spawnSync(quarto, args, {cwd: root, encoding: 'utf8'});
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
function normal(value) {
  return JSON.stringify(value).replaceAll(
    'https://reckak.github.io/statistics-for-psychology/quarto/', '').replaceAll('.html', '.qmd');
}
const before = parse(false), after = parse(true);
for (const type of ['Math', 'Code', 'Image', 'Table', 'Cite']) {
  assert.deepEqual(nodes(after, type).map(normal).sort(), nodes(before, type).map(normal).sort(),
    `${type}: content lost or changed during PDF conversion`);
}
const solutions = before.blocks.filter(b => b.t === 'Div' &&
  b.c[0][2].some(([k,v]) => k === 'title' && v === 'Ukázat řešení'));
assert.equal(solutions.length, 14);
const start = after.blocks.findIndex(b => b.t === 'Header' && b.c[1][0] === 'pdf-solutions');
assert(start > 0);
for (let i = 1; i <= solutions.length; i++) {
  const ex = after.blocks.findIndex(b => b.t === 'Header' && b.c[1][0] === `pdf-exercise-${i}`);
  const sol = after.blocks.findIndex(b => b.t === 'Header' && b.c[1][0] === `pdf-solution-${i}`);
  assert(ex >= 0 && ex < start && sol > start, `Exercise/solution ${i}: wrong location`);
  // Header, sticky block opener, return link, block closer, then the original content.
  assert.equal(normal(after.blocks.slice(sol + 4, sol + 4 + solutions[i-1].c[1].length)),
    normal(solutions[i-1].c[1]), `Solution ${i}: content changed`);
}
const links = nodes(after, 'Link').map(x => x.c[2][0]);
for (let i = 1; i <= solutions.length; i++) {
  assert(links.includes(`#pdf-exercise-${i}`) && links.includes(`#pdf-solution-${i}`));
}
assert(!links.some(x => /\.qmd(?:#|$)|^\.\.\/data\//.test(x)));
assert(!nodes(after, 'Div').some(b => b.c[0][2].some(([k,v]) => k === 'title' && v === 'Ukázat řešení')));
console.log('PDF transformation: all 14 solutions preserved and moved, reciprocal links present; math, code, images, tables and citations unchanged.');
