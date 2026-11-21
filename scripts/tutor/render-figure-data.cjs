// Authoring check: redraws tutor figure data with a deliberately generic plotter and saves the
// result next to the original, so that one can see whether the data suffice to redraw the figure.
// Usage: node scripts/tutor/render-figure-data.cjs <chapter id, e.g. kapitola_10> [output dir]
// It shows that the data are sufficient; it does not show how a tutor draws them in a client.
const fs = require('node:fs');
const path = require('node:path');
const {pathToFileURL} = require('node:url');
const {chromium} = require(process.env.PLAYWRIGHT_MODULE || 'playwright');
const root = path.resolve(__dirname, '../..');
const chapter = process.argv[2];
if (!/^kapitola_\d+$/.test(chapter || '')) throw new Error('Chapter id required, e.g. kapitola_10');
const number = chapter.slice(-2);
const dataDir = path.join(root, 'tmp/tutor-figures', chapter);
const out = path.resolve(process.argv[3] || path.join(root, 'tmp/tutor-figures-check', chapter));
fs.mkdirSync(out, {recursive: true});

const esc = s => String(s).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
const cz = v => String(Math.round(v * 1000) / 1000).replace('.', ',').replace('-', '−');
const colors = ['#245D78', '#B54E24', '#3E7B4F', '#6B4E9B'];
function extent(values, given) {
  if (given) return given;
  const lo = Math.min(...values), hi = Math.max(...values);
  const pad = (hi - lo || 1) * 0.06;
  return [lo - pad, hi + pad];
}
function ticks([lo, hi]) {
  const raw = (hi - lo) / 5, mag = 10 ** Math.floor(Math.log10(raw));
  const step = [1, 2, 5, 10].map(m => m * mag).find(s => s >= raw);
  const list = [];
  for (let t = Math.ceil(lo / step) * step; t <= hi + step * 1e-9; t += step) list.push(Math.round(t / step) * step);
  return list;
}
function panelSvg(p, W, H) {
  const m = {l: 52, r: 12, t: 46, b: 44};
  const col = (s, name) => s.data.columns.indexOf(name);
  const xs = [], ys = [];
  for (const s of p.series) for (const row of s.data.rows) {
    if (s.mark === 'histogram') { xs.push(row[col(s, 'od')], row[col(s, 'do')]); ys.push(0, row[col(s, 'cetnost')]); }
    else { xs.push(row[col(s, 'x')]); ys.push(row[col(s, 'y')]); if (s.mark === 'sloupce') ys.push(0); }
  }
  const xr = extent(xs, p.x.range), yr = extent(ys, p.y.range);
  const X = v => m.l + (v - xr[0]) / (xr[1] - xr[0]) * (W - m.l - m.r);
  const Y = v => H - m.b - (v - yr[0]) / (yr[1] - yr[0]) * (H - m.t - m.b);
  const g = [`<rect width="${W}" height="${H}" fill="#fff"/>`,
    `<text x="${W / 2}" y="16" text-anchor="middle" font-size="11" font-weight="bold">${esc(p.title.slice(0, 70))}</text>`,
    p.title.length > 70 ? `<text x="${W / 2}" y="30" text-anchor="middle" font-size="11">${esc(p.title.slice(70))}</text>` : '',
    `<path d="M${m.l} ${m.t}V${H - m.b}H${W - m.r}" fill="none" stroke="#223744"/>`,
    `<text x="${(m.l + W - m.r) / 2}" y="${H - 8}" text-anchor="middle" font-size="11">${esc(p.x.label)}</text>`,
    `<text transform="translate(13 ${(m.t + H - m.b) / 2}) rotate(-90)" text-anchor="middle" font-size="11">${esc(p.y.label)}</text>`];
  for (const t of ticks(xr)) g.push(`<text x="${X(t)}" y="${H - m.b + 14}" text-anchor="middle" font-size="10">${cz(t)}</text>`);
  for (const t of ticks(yr)) g.push(`<text x="${m.l - 5}" y="${Y(t) + 3}" text-anchor="end" font-size="10">${cz(t)}</text>`);
  for (const guide of p.guides || []) {
    if (guide.axis === 'x') g.push(`<line x1="${X(guide.value)}" x2="${X(guide.value)}" y1="${m.t}" y2="${H - m.b}" stroke="#4D5A63" stroke-dasharray="5 4"/>`);
    if (guide.axis === 'y') g.push(`<line y1="${Y(guide.value)}" y2="${Y(guide.value)}" x1="${m.l}" x2="${W - m.r}" stroke="#4D5A63" stroke-dasharray="5 4"/>`);
    if (guide.axis === 'primka') {
      const [a, b] = guide.value;
      g.push(`<line x1="${X(xr[0])}" y1="${Y(a + b * xr[0])}" x2="${X(xr[1])}" y2="${Y(a + b * xr[1])}" stroke="#4D5A63" stroke-dasharray="2 4"/>`);
    }
  }
  p.series.forEach((s, k) => {
    const c = colors[k % colors.length];
    if (s.mark === 'histogram') {
      for (const row of s.data.rows) {
        const a = X(row[col(s, 'od')]), b = X(row[col(s, 'do')]), top = Y(row[col(s, 'cetnost')]);
        g.push(`<rect x="${a}" y="${top}" width="${Math.max(b - a - 0.6, 0.5)}" height="${Y(0) - top}" fill="#B8DDE8"/>`);
      }
    } else if (s.mark === 'sloupce') {
      const flag = col(s, 'zvyrazneno');
      for (const row of s.data.rows) {
        g.push(`<line x1="${X(row[col(s, 'x')])}" x2="${X(row[col(s, 'x')])}" y1="${Y(0)}" y2="${Y(row[col(s, 'y')])}" stroke="${flag >= 0 && row[flag] === 'ano' ? '#B54E24' : '#A9BAC3'}" stroke-width="9"/>`);
      }
    } else if (s.mark === 'cara') {
      g.push(`<polyline fill="none" stroke="${c}" stroke-width="2" points="${s.data.rows.map(r => `${X(r[col(s, 'x')])},${Y(r[col(s, 'y')])}`).join(' ')}"/>`);
    } else {
      const size = col(s, 'pocet_studentu');
      for (const row of s.data.rows) {
        g.push(`<circle cx="${X(row[col(s, 'x')])}" cy="${Y(row[col(s, 'y')])}" r="${size >= 0 ? 3 + 2.5 * row[size] : 3.5}" fill="${c}" fill-opacity="0.55" stroke="${c}"/>`);
      }
    }
  });
  return `<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${H}" font-family="Arial, sans-serif" fill="#223744">${g.join('')}</svg>`;
}

(async () => {
  const names = fs.readdirSync(dataDir).filter(f => f.endsWith('.json')).map(f => f.slice(0, -5)).sort();
  const browser = await chromium.launch({headless: true, ...(process.env.CHROME_PATH ? {executablePath: process.env.CHROME_PATH} : {})});
  try {
    const page = await (await browser.newContext({viewport: {width: 1300, height: 900}})).newPage();
    for (const name of names) {
      const fig = JSON.parse(fs.readFileSync(path.join(dataDir, `${name}.json`), 'utf8'));
      const panels = fig.panels || [];
      const perRow = panels.length > 4 ? 3 : Math.max(panels.length, 1);
      const W = Math.floor(1240 / perRow), H = Math.round(Math.min(W * 0.8, 380));
      const original = pathToFileURL(path.join(root, `assets/chapter-${number}/plots/${name}.svg`)).href;
      const html = `<body style="margin:12px;font-family:Arial,sans-serif;background:#fff">
<h3 style="margin:4px 0">${esc(name)} — originál</h3><img src="${original}" style="max-width:1240px;max-height:520px;border:1px solid #ccc">
<h3 style="margin:10px 0 4px">${esc(name)} — překresleno z dat (${esc(fig.kind)})</h3>
<div style="display:grid;grid-template-columns:repeat(${perRow},${W}px)">${panels.map(p => panelSvg(p, W, H)).join('')}</div></body>`;
      const file = path.join(out, `${name}.html`);
      fs.writeFileSync(file, html, 'utf8');
      await page.goto(pathToFileURL(file).href);
      await page.screenshot({path: path.join(out, `${name}.png`), fullPage: true});
      fs.rmSync(file);
    }
  } finally {
    await browser.close();
  }
  console.log(JSON.stringify({chapter, figures: names.length, out}));
})().catch(error => { console.error(error.stack || String(error)); process.exit(1); });
