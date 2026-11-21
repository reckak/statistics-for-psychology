// Authoring check of the figure data of one chapter before a full export:
// node scripts/tutor/check-figure-data.cjs kapitola_09
// Every image of the chapter needs a record; records follow the vocabulary of figure-data.R.
// The export repeats these checks on the packaged registers (scripts/check-tutor.cjs).
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const {root, read, figureDataBlock, markColumns} = require('./common.cjs');
const chapter = process.argv[2];
assert(/^kapitola_\d+$/.test(chapter || ''), 'Chapter id required, e.g. kapitola_09');
const dir = path.join(root, 'tmp/tutor-figures', chapter);
const images = [...read(path.join(root, 'quarto', `${chapter}.qmd`)).matchAll(/\]\(([^)\s]+\.svg)\)/g)].map(m => path.basename(m[1], '.svg'));
assert(images.length > 0 && new Set(images).size === images.length, 'Images of the chapter');
const records = fs.readdirSync(dir).filter(f => f.endsWith('.json')).map(f => f.slice(0, -5));
assert.deepEqual(records.filter(r => !images.includes(r)), [], 'Records without an image in the chapter');
assert.deepEqual(images.filter(i => !records.includes(i)), [], 'Images without a record');
const summary = [];
for (const name of images) {
  const fig = JSON.parse(read(path.join(dir, `${name}.json`)));
  assert.equal(fig.figure, name);
  assert(['data', 'simulace', 'krivka', 'sloupce', 'schema'].includes(fig.kind), `${name}: kind`);
  let rows = 0;
  if (fig.kind === 'schema') assert(!fig.panels, `${name}: a diagram has no panels`);
  else {
    assert(fig.panels?.length > 0, `${name}: panels`);
    for (const [k, p] of fig.panels.entries()) {
      const noAxes = ['tabulka', 'výsečový graf'].includes(p.type);
      assert(p.title && p.type && p.series.length > 0 && (noAxes || (p.x?.label && p.y?.label)), `${name}: panel ${k + 1} needs a title and axis labels`);
      for (const axis of [p.x, p.y]) if (axis?.range) assert(axis.range.length === 2 && axis.range[0] < axis.range[1], `${name}: axis range`);
      for (const g of p.guides || []) assert([g.value].flat().every(Number.isFinite) && [g.value].flat().length === (/^(x|y)$/.test(g.axis) ? 1 : 2), `${name}: guide values`);
      for (const s of p.series) {
        const need = markColumns[s.mark];
        assert(need, `${name}: mark of ${s.name}`);
        assert.equal(['interval', 'krabice'].includes(s.mark), Boolean(s.direction), `${name}: direction of ${s.name}`);
        const columns = need.map(spec => {
          const open = spec.endsWith('?'), found = spec.replace('?', '').split('|').filter(c => s.data.columns.includes(c));
          assert.equal(found.length, 1, `${name}: column ${spec} of ${s.name}`);
          return {index: s.data.columns.indexOf(found[0]), open, text: found[0] === 'kategorie'};
        });
        assert(s.data.rows.length > 0, `${name}: ${s.name} has rows`);
        for (const row of s.data.rows) {
          for (const c of columns) {
            if (c.text) assert(typeof row[c.index] === 'string' && row[c.index], `${name}: category in ${s.name}`);
            else assert(Number.isFinite(row[c.index]) || (c.open && row[c.index] === null), `${name}: finite numbers in ${s.name}`);
          }
          if (s.mark === 'interval') assert(columns.filter(c => c.open).some(c => row[c.index] !== null), `${name}: an interval needs one bound`);
        }
        rows += s.data.rows.length;
      }
    }
    assert(rows <= 800, `${name}: ${rows} data rows; bin or thin the series`);
  }
  summary.push({figure: name, kind: fig.kind, panels: fig.panels?.length || 0, rows, bytes: Buffer.byteLength(figureDataBlock(fig).join('\n'))});
}
console.log(JSON.stringify({chapter, figures: summary.length, rows: summary.reduce((a, s) => a + s.rows, 0),
  bytes: summary.reduce((a, s) => a + s.bytes, 0), summary}, null, 1));
