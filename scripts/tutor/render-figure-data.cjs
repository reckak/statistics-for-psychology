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
const colors = ['#245D78', '#B54E24', '#3E7B4F', '#6B4E9B', '#8A6D1B', '#4D5A63'];
function extent(values, given) {
  if (given) return given;
  const finite = values.filter(Number.isFinite);
  const lo = Math.min(...finite), hi = Math.max(...finite);
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
const tableHtml = (s, W) => `<div style="width:${W - 16}px;font-size:11px;padding:0 8px"><b>${esc(s.name)}</b><table style="border-collapse:collapse;font-size:11px">` +
  `<tr>${s.data.columns.map(c => `<th style="border-bottom:1px solid #223744;padding:1px 6px;text-align:left">${esc(c)}</th>`).join('')}</tr>` +
  s.data.rows.map(r => `<tr>${r.map(v => `<td style="padding:1px 6px">${esc(typeof v === 'number' ? cz(v) : v ?? '')}</td>`).join('')}</tr>`).join('') + '</table></div>';
function panelSvg(p, W, H) {
  const head = `<div style="width:${W}px;font-size:11px;font-weight:bold;text-align:center">${esc(p.title)}</div>` +
    (p.note ? `<div style="width:${W - 16}px;font-size:10px;color:#4D5A63;padding:0 8px">${esc(p.note)}</div>` : '');
  if (!p.x || !p.y || p.series.every(s => s.mark === 'tabulka')) return `<div>${head}${p.series.map(s => tableHtml(s, W)).join('')}</div>`;
  const m = {l: 58, r: 12, t: 10, b: 44};
  const col = (s, name) => s.data.columns.indexOf(name);
  // Categories share one axis per panel; the axis is x unless a horizontal mark carries them.
  const cats = [];
  const position = (s, row, name) => {
    const k = col(s, 'kategorie');
    if (k < 0) return row[col(s, name)];
    if (!cats.includes(row[k])) cats.push(row[k]);
    return cats.indexOf(row[k]) + 1;
  };
  // Categories on the vertical axis are listed top to bottom.
  const flip = (s, pos) => horizontal(s) && col(s, 'kategorie') >= 0 ? -pos : pos;
  const horizontal = s => s.direction === 'vodorovně';
  let catAxis = null;
  const xs = [], ys = [];
  const groups = s => col(s, 'skupina') < 0 ? [] : [...new Set(s.data.rows.map(r => r[col(s, 'skupina')]))];
  const marks = [];
  for (const s of p.series) {
    if (s.mark === 'tabulka') continue;
    const has = name => col(s, name) >= 0;
    if (has('kategorie')) catAxis = horizontal(s) ? 'y' : 'x';
    if (s.mark === 'histogram') {
      const h = ['cetnost', 'hustota', 'podil'].find(has);
      for (const row of s.data.rows) { xs.push(row[col(s, 'od')], row[col(s, 'do')]); ys.push(0, row[col(s, h)]); }
      marks.push({s, h});
    } else if (s.mark === 'usecky') {
      for (const row of s.data.rows) { xs.push(row[col(s, 'x0')], row[col(s, 'x1')]); ys.push(row[col(s, 'y0')], row[col(s, 'y1')]); }
      marks.push({s});
    } else if (s.mark === 'interval' || s.mark === 'krabice') {
      const names = s.mark === 'interval' ? ['od', 'do', 'stred'] : ['dolni_vous', 'q1', 'median', 'q3', 'horni_vous'];
      const rows = s.data.rows.map(row => ({pos: flip(s, position(s, row, 'poloha')), v: Object.fromEntries(names.filter(has).map(n => [n, row[col(s, n)]])), row}));
      for (const r of rows) { (horizontal(s) ? ys : xs).push(r.pos - 0.5, r.pos + 0.5); (horizontal(s) ? xs : ys).push(...Object.values(r.v)); }
      marks.push({s, rows});
    } else {
      const g = groups(s), stacked = s.arrangement === 'skládané', base = new Map();
      const rows = s.data.rows.map(row => {
        const pos = position(s, row, 'x'), y = row[col(s, 'y')], y0 = has('y0') ? row[col(s, 'y0')] : 0;
        let from = y0, to = y, shift = 0;
        if (s.mark === 'sloupce' && g.length) {
          const k = g.indexOf(row[col(s, 'skupina')]);
          if (stacked) { from = base.get(pos) || 0; to = from + y; base.set(pos, to); }
          else shift = (k - (g.length - 1) / 2) * 0.8 / g.length;
          return {pos: pos + shift, from, to, k, row};
        }
        return {pos, from, to, k: 0, row};
      });
      for (const r of rows) { xs.push(r.pos); ys.push(r.to); if (s.mark === 'sloupce' || s.mark === 'plocha') ys.push(r.from); }
      if (s.mark === 'sloupce') xs.push(Math.min(...rows.map(r => r.pos)) - 0.5, Math.max(...rows.map(r => r.pos)) + 0.5);
      marks.push({s, rows, g});
    }
  }
  const xr = extent(xs, p.x.range), yr = extent(ys, p.y.range);
  const X = v => m.l + (v - xr[0]) / (xr[1] - xr[0]) * (W - m.l - m.r);
  const Y = v => H - m.b - (v - yr[0]) / (yr[1] - yr[0]) * (H - m.t - m.b);
  const g = [`<rect width="${W}" height="${H}" fill="#fff"/>`,
    `<path d="M${m.l} ${m.t}V${H - m.b}H${W - m.r}" fill="none" stroke="#223744"/>`,
    `<text x="${(m.l + W - m.r) / 2}" y="${H - 8}" text-anchor="middle" font-size="11">${esc(p.x.label)}</text>`,
    `<text transform="translate(11 ${(m.t + H - m.b) / 2}) rotate(-90)" text-anchor="middle" font-size="11">${esc(p.y.label)}</text>`];
  const short = s => esc(String(s).length > 16 ? String(s).slice(0, 15) + '…' : s);
  if (catAxis === 'x') cats.forEach((c, i) => g.push(`<text x="${X(i + 1)}" y="${H - m.b + 14}" text-anchor="middle" font-size="9">${short(c)}</text>`));
  else for (const t of ticks(xr)) g.push(`<text x="${X(t)}" y="${H - m.b + 14}" text-anchor="middle" font-size="10">${cz(t)}</text>`);
  if (catAxis === 'y') cats.forEach((c, i) => g.push(`<text x="${m.l - 4}" y="${Y(-(i + 1)) + 3}" text-anchor="end" font-size="8">${short(c).slice(0, 12)}</text>`));
  else for (const t of ticks(yr)) g.push(`<text x="${m.l - 5}" y="${Y(t) + 3}" text-anchor="end" font-size="10">${cz(t)}</text>`);
  for (const guide of p.guides || []) {
    if (guide.axis === 'pasmo x') g.push(`<rect x="${X(guide.value[0])}" width="${X(guide.value[1]) - X(guide.value[0])}" y="${m.t}" height="${H - m.b - m.t}" fill="#FAECDD"/>`);
    if (guide.axis === 'pasmo y') g.push(`<rect y="${Y(guide.value[1])}" height="${Y(guide.value[0]) - Y(guide.value[1])}" x="${m.l}" width="${W - m.l - m.r}" fill="#FAECDD"/>`);
    if (guide.axis === 'x') g.push(`<line x1="${X(guide.value)}" x2="${X(guide.value)}" y1="${m.t}" y2="${H - m.b}" stroke="#4D5A63" stroke-dasharray="5 4"/>`);
    if (guide.axis === 'y') g.push(`<line y1="${Y(guide.value)}" y2="${Y(guide.value)}" x1="${m.l}" x2="${W - m.r}" stroke="#4D5A63" stroke-dasharray="5 4"/>`);
    if (guide.axis === 'primka') {
      const [a, b] = guide.value;
      g.push(`<line x1="${X(xr[0])}" y1="${Y(a + b * xr[0])}" x2="${X(xr[1])}" y2="${Y(a + b * xr[1])}" stroke="#4D5A63" stroke-dasharray="2 4"/>`);
    }
  }
  const clamp = (v, r) => v === null || v === undefined ? null : Math.max(r[0], Math.min(r[1], v));
  marks.forEach(({s, rows, h, g: grp}, k) => {
    const c = colors[k % colors.length];
    const flag = col(s, 'zvyrazneno');
    const levels = flag < 0 ? [] : [...new Set(s.data.rows.map(r => r[flag]))].filter(v => v && v !== 'ne');
    const tone = row => flag >= 0 && row[flag] && row[flag] !== 'ne' ? colors[1 + levels.indexOf(row[flag]) % 4] : null;
    if (s.mark === 'histogram') {
      for (const row of s.data.rows) {
        const a = X(row[col(s, 'od')]), b = X(row[col(s, 'do')]), top = Y(row[col(s, h)]);
        g.push(`<rect x="${a}" y="${top}" width="${Math.max(b - a - 0.6, 0.5)}" height="${Y(0) - top}" fill="${tone(row) || '#B8DDE8'}"/>`);
      }
    } else if (s.mark === 'usecky') {
      for (const row of s.data.rows) g.push(`<line x1="${X(row[col(s, 'x0')])}" y1="${Y(row[col(s, 'y0')])}" x2="${X(row[col(s, 'x1')])}" y2="${Y(row[col(s, 'y1')])}" stroke="${c}" stroke-opacity="0.6"/>`);
    } else if (s.mark === 'interval') {
      for (const r of rows) {
        const axis = horizontal(s) ? xr : yr, lo = r.v.od ?? axis[0], hi = r.v.do ?? axis[1], col2 = tone(r.row) || c;
        const P = (v, pos) => horizontal(s) ? `${X(v)},${Y(pos)}` : `${X(pos)},${Y(v)}`;
        g.push(`<polyline points="${P(lo, r.pos)} ${P(hi, r.pos)}" stroke="${col2}" stroke-width="2" fill="none"/>`);
        if (Number.isFinite(r.v.stred)) { const [cx, cy] = P(r.v.stred, r.pos).split(','); g.push(`<circle cx="${cx}" cy="${cy}" r="3" fill="${col2}"/>`); }
      }
    } else if (s.mark === 'krabice') {
      for (const r of rows) {
        const P = (v, pos) => horizontal(s) ? `${X(v)},${Y(pos)}` : `${X(pos)},${Y(v)}`;
        g.push(`<polyline points="${P(r.v.dolni_vous, r.pos)} ${P(r.v.horni_vous, r.pos)}" stroke="${c}" fill="none"/>`,
          `<polygon points="${P(r.v.q1, r.pos - 0.25)} ${P(r.v.q3, r.pos - 0.25)} ${P(r.v.q3, r.pos + 0.25)} ${P(r.v.q1, r.pos + 0.25)}" fill="#B8DDE8" stroke="${c}"/>`,
          `<polyline points="${P(r.v.median, r.pos - 0.25)} ${P(r.v.median, r.pos + 0.25)}" stroke="${c}" stroke-width="2.5" fill="none"/>`);
      }
    } else if (s.mark === 'sloupce') {
      const span = Math.abs(X(1) - X(0)), n = new Set(rows.map(r => Math.round(r.pos * 1000))).size;
      const width = Math.max(2, Math.min(40, (W - m.l - m.r) / (n + 1) * 0.8, grp.length && s.arrangement !== 'skládané' ? span * 0.8 / grp.length : 1e9));
      for (const r of rows) {
        const a = Y(clamp(r.from, yr)), b = Y(clamp(r.to, yr));
        g.push(`<rect x="${X(r.pos) - width / 2}" width="${width}" y="${Math.min(a, b)}" height="${Math.abs(a - b)}" fill="${tone(r.row) || (grp.length ? colors[r.k % colors.length] : '#A9BAC3')}" fill-opacity="0.85"/>`);
      }
    } else if (s.mark === 'cara') {
      g.push(`<polyline fill="none" stroke="${c}" stroke-width="2" points="${rows.map(r => `${X(r.pos)},${Y(r.to)}`).join(' ')}"/>`);
    } else if (s.mark === 'plocha') {
      g.push(`<polygon fill="${c}" fill-opacity="0.3" points="${rows.map(r => `${X(r.pos)},${Y(r.to)}`).join(' ')} ${rows.slice().reverse().map(r => `${X(r.pos)},${Y(r.from)}`).join(' ')}"/>`);
    } else {
      const size = col(s, 'pocet_studentu');
      for (const r of rows) {
        const col2 = tone(r.row) || c;
        g.push(`<circle cx="${X(r.pos)}" cy="${Y(r.to)}" r="${size >= 0 ? 3 + 2.5 * r.row[size] : 3.2}" fill="${col2}" fill-opacity="0.55" stroke="${col2}"/>`);
      }
    }
  });
  const legend = marks.map(({s}, k) => `<span style="color:${colors[k % colors.length]}">■</span> ${esc(s.name)} (${esc(s.mark)}, ${s.data.rows.length})`).join(' · ');
  const tables = p.series.filter(s => s.mark === 'tabulka').map(s => tableHtml(s, W)).join('');
  return `<div>${head}<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${H}" font-family="Arial, sans-serif" fill="#223744">${g.join('')}</svg>` +
    `<div style="width:${W - 16}px;font-size:10px;padding:0 8px">${legend}</div>${tables}</div>`;
}

(async () => {
  const only = process.argv[4] ? process.argv[4].split(',') : null;
  const names = fs.readdirSync(dataDir).filter(f => f.endsWith('.json')).map(f => f.slice(0, -5)).sort().filter(n => !only || only.includes(n));
  const browser = await chromium.launch({headless: true, ...(process.env.CHROME_PATH ? {executablePath: process.env.CHROME_PATH} : {})});
  let drawn = 0;
  try {
    const page = await (await browser.newContext({viewport: {width: 1300, height: 900}})).newPage();
    for (const name of names) {
      const fig = JSON.parse(fs.readFileSync(path.join(dataDir, `${name}.json`), 'utf8'));
      if (fig.kind === 'schema') continue;
      const panels = fig.panels || [];
      const perRow = panels.length > 4 ? (panels.length > 6 ? 4 : 3) : Math.max(panels.length, 1);
      const W = Math.floor(1240 / perRow), H = Math.round(Math.min(W * 0.8, 340));
      const original = pathToFileURL(path.join(root, `assets/chapter-${number}/plots/${name}.svg`)).href;
      const html = `<body style="margin:12px;font-family:Arial,sans-serif;background:#fff">
<h3 style="margin:4px 0">${esc(name)} — originál</h3><img src="${original}" style="max-width:1240px;max-height:480px;border:1px solid #ccc">
<h3 style="margin:10px 0 4px">${esc(name)} — překresleno z dat (${esc(fig.kind)})</h3>
${fig.note ? `<div style="font-size:11px;color:#4D5A63;max-width:1240px">${esc(fig.note)}</div>` : ''}
<div style="display:grid;grid-template-columns:repeat(${perRow},${W}px);row-gap:10px">${panels.map(p => panelSvg(p, W, H)).join('')}</div></body>`;
      const file = path.join(out, `${name}.html`);
      fs.writeFileSync(file, html, 'utf8');
      await page.goto(pathToFileURL(file).href);
      await page.screenshot({path: path.join(out, `${name}.png`), fullPage: true});
      fs.rmSync(file);
      drawn++;
    }
  } finally {
    await browser.close();
  }
  console.log(JSON.stringify({chapter, figures: names.length, drawn, out}));
})().catch(error => { console.error(error.stack || String(error)); process.exit(1); });
