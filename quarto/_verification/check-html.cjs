const fs = require('node:fs');
const path = require('node:path');
const http = require('node:http');
const assert = require('node:assert/strict');
const { pathToFileURL } = require('node:url');
const { chromium } = require(process.env.PLAYWRIGHT_MODULE || 'playwright');
const root = path.resolve('_book');
const prefix = '/statistics-for-psychology/';
const files = fs.readdirSync(path.join(root, 'quarto')).filter(f => f.endsWith('.html'));
const paths = ['index.html', ...files.map(f => `quarto/${f}`)];
const types = { '.html': 'text/html', '.js': 'text/javascript', '.css': 'text/css', '.json': 'application/json' };
const server = http.createServer((req, res) => {
  let route = decodeURIComponent(new URL(req.url, 'http://localhost').pathname);
  if (!route.startsWith(prefix)) { res.writeHead(404); return res.end(); }
  route = route.slice(prefix.length) || 'index.html';
  const file = path.resolve(root, route);
  if (!file.startsWith(root + path.sep) || !fs.existsSync(file) || !fs.statSync(file).isFile()) { res.writeHead(404); return res.end(); }
  res.setHeader('Content-Type', types[path.extname(file)] || 'application/octet-stream');
  fs.createReadStream(file).pipe(res);
});
(async () => {
  await new Promise(resolve => server.listen(0, '127.0.0.1', resolve));
  const base = `http://127.0.0.1:${server.address().port}${prefix}`;
  const browser = await chromium.launch({ headless: true, ...(process.env.CHROME_PATH ? { executablePath: process.env.CHROME_PATH } : {}) });
  const page = await browser.newPage({ viewport: { width: 1360, height: 1000 } });
  const errors = [];
  page.on('pageerror', e => errors.push(e.message));
  page.on('response', r => { if (r.url().startsWith(base) && r.status() >= 400) errors.push(`${r.status()} ${r.url()}`); });
  fs.mkdirSync('tmp/verification', { recursive: true });
  const documents = {};
  let solutionCount = 0;
  try {
    for (const file of paths) {
      await page.goto(base + file, { waitUntil: 'networkidle' });
      documents[file] = await page.evaluate(() => ({ ids: [...document.querySelectorAll('[id]')].map(x => x.id), links: [...document.querySelectorAll('a[href]')].map(x => x.getAttribute('href')) }));
      const ids = documents[file].ids;
      assert.equal(ids.length, new Set(ids).size, `Duplicate IDs: ${file}`);
      assert.equal(await page.locator('pre.sourceCode.r, div.cell-output-stderr').count(), 0, `Leaked R: ${file}`);
      for (const width of [1360, 1920]) {
        await page.setViewportSize({ width, height: 1000 });
        const layout = await page.locator('main').boundingBox();
        assert(Math.abs(layout.x + layout.width / 2 - width / 2) < 2, `Centered content at ${width}px: ${file}`);
        assert(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth + 1), `Desktop overflow: ${file}`);
      }
      await page.setViewportSize({ width: 1360, height: 1000 });
      if (file === 'quarto/kapitola_01.html') {
        const references = page.locator('#refs .csl-entry');
        assert.equal(await references.count(), 14, 'All fourteen chapter sources are included');
        const howell = await page.locator('#ref-howell').innerText();
        assert.match(howell, /^Howell, D\. C\. \(2013\)\./, 'APA author initials and year');
        assert.match(await page.locator('#ref-howell em').innerText(), /Statistical methods for psychology/, 'APA book title');
        assert.match(await page.locator('.citation[data-cites="aron"]').first().innerText(), /Aron et al\. \(2014, s\. 3–5\)/, 'APA narrative citation for three authors');
        assert.match(await page.locator('.citation[data-cites="cumming"]').first().innerText(), /Cumming & Calin-Jageman, 2024/, 'APA parenthetical citation for two authors');
        assert.equal(await page.locator('#ref-lord a').getAttribute('href'), 'https://doi.org/10.1037/h0063675');
        const newSources = {
          henrich: ['2010', '10.1017/S0140525X0999152X'],
          simons: ['2017', '10.1177/1745691617708630'],
          michell: ['1997', '10.1111/j.2044-8295.1997.tb02641.x'],
          liddell: ['2018', '10.1016/j.jesp.2018.08.009'],
          borsboom2002: ['2002', '10.1016/S0160-2896(02)00082-X']
        };
        for (const [key, [year, doi]] of Object.entries(newSources)) {
          const entry = page.locator(`#ref-${key}`);
          assert((await entry.innerText()).includes(`(${year})`), `Year: ${key}`);
          assert.equal(await entry.locator('a').getAttribute('href'), `https://doi.org/${doi}`);
          assert(await entry.locator('em').count() >= 1, `APA journal italics: ${key}`);
        }
        const optional = page.locator('#chyba-mereni-podrobne');
        assert.equal(await optional.locator('.callout-collapse').isVisible(), false);
        await optional.locator('[data-bs-toggle="collapse"]').focus();
        await page.keyboard.press('Enter');
        await optional.locator('.callout-collapse').waitFor({ state: 'visible' });
        await optional.screenshot({ path: 'tmp/verification/measurement-error-desktop.png' });
        await optional.locator('[data-bs-toggle="collapse"]').click();
        await optional.locator('.callout-collapse').waitFor({ state: 'hidden' });
        for (const id of ['sec-stejna-vlastnost', 'sec-kvaziintervalove', 'sec-uroven-a-spojitost', 'refs']) {
          await page.locator(`#${id}`).screenshot({ path: `tmp/verification/${id}-desktop.png` });
        }
        const links = page.locator('#TOC > ul > li > a');
        assert.equal(await links.count(), await page.locator('main > section.level2').count(), 'TOC covers chapter sections');
        for (const link of await links.all()) assert(await link.isVisible(), 'TOC link is visible');
        const target = page.locator('#toc-sec-datova-matice');
        await target.focus();
        await page.keyboard.press('Enter');
        await page.waitForFunction(() => location.hash === '#sec-datova-matice' && document.querySelector('#sec-datova-matice').getBoundingClientRect().top < 100);
        await page.evaluate(() => window.scrollTo(0, 0));
      }
      if (file !== 'index.html') assert.equal(await page.locator('.ref-controls').count(), file.includes('kapitola') ? 0 : 1);
      const solutions = page.locator('.callout[title="Ukázat řešení"]');
      solutionCount += await solutions.count();
      if (file === 'quarto/kapitola_01.html') assert.equal(await solutions.count(), 8, 'All eight exercises must have a solution');
      for (let i = 0; i < await solutions.count(); i++) {
        const item = solutions.nth(i);
        const toggle = item.locator('[data-bs-toggle="collapse"]');
        const body = item.locator('.callout-collapse');
        assert.equal(await toggle.getAttribute('aria-expanded'), 'false');
        assert.equal(await body.isVisible(), false, 'Solution must be initially hidden');
        await toggle.focus(); await page.keyboard.press('Enter');
        await body.waitFor({ state: 'visible' });
        assert.equal(await toggle.getAttribute('aria-expanded'), 'true');
        await page.waitForTimeout(400);
        await toggle.click(); await body.waitFor({ state: 'hidden' });
      }
      await page.evaluate(() => window.scrollTo(0, 0));
      await page.screenshot({ path: `tmp/verification/${path.basename(file, '.html')}-desktop.png` });
      await page.setViewportSize({ width: 390, height: 844 });
      assert.equal(await page.locator('#quarto-margin-sidebar').isVisible(), false, 'Mobile layout hides right sidebar');
      assert(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth + 1), `Mobile overflow: ${file}`);
      if (file === 'quarto/kapitola_01.html') {
        const optional = page.locator('#chyba-mereni-podrobne');
        await optional.locator('[data-bs-toggle="collapse"]').click();
        await optional.locator('.callout-collapse').waitFor({ state: 'visible' });
        assert(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth + 1), 'Open optional explanation overflow');
        await optional.screenshot({ path: 'tmp/verification/measurement-error-mobile.png' });
        await optional.locator('[data-bs-toggle="collapse"]').click();
        await optional.locator('.callout-collapse').waitFor({ state: 'hidden' });
        for (const id of ['sec-stejna-vlastnost', 'sec-kvaziintervalove', 'sec-uroven-a-spojitost', 'refs']) {
          await page.locator(`#${id}`).screenshot({ path: `tmp/verification/${id}-mobile.png` });
        }
      }
      if (await solutions.count()) {
        const last = solutions.last();
        await last.locator('[data-bs-toggle="collapse"]').click();
        await last.locator('.callout-collapse').waitFor({ state: 'visible' });
        await page.waitForTimeout(400);
        assert(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth + 1), `Open solution overflow: ${file}`);
        await last.screenshot({ path: 'tmp/verification/solution-mobile.png' });
        await last.locator('[data-bs-toggle="collapse"]').click();
        await last.locator('.callout-collapse').waitFor({ state: 'hidden' });
      }
      await page.evaluate(() => window.scrollTo(0, 0));
      await page.screenshot({ path: `tmp/verification/${path.basename(file, '.html')}-mobile.png` });
      await page.setViewportSize({ width: 1360, height: 1000 });
    }
    for (const [file, doc] of Object.entries(documents)) {
      for (const href of doc.links) {
        if (!href || /^(https?:|mailto:|tel:|javascript:)/.test(href)) continue;
        const url = new URL(href, base + file);
        assert(url.pathname.startsWith(prefix), `Link escapes site prefix: ${href}`);
        const target = decodeURIComponent(url.pathname.slice(prefix.length)) || 'index.html';
        assert(fs.existsSync(path.join(root, target)), `Missing target ${file}: ${href}`);
        if (url.hash && documents[target]) assert(documents[target].ids.includes(decodeURIComponent(url.hash.slice(1))), `Missing anchor ${file}: ${href}`);
      }
    }
    await page.goto(base + 'quarto/slovnicek.html', { waitUntil: 'networkidle' });
    const total = await page.locator('#glossary-table tbody tr').count();
    if (total > 10) {
      const visible = () => page.locator('#glossary-table tbody tr:visible').count();
      assert.equal(await visible(), 10);
      await page.getByRole('button', { name: 'Další', exact: true }).click();
      assert.equal(await page.locator('#glossary-table tbody tr').first().isVisible(), false);
      const lastId = await page.locator('#glossary-table tbody tr').last().getAttribute('id');
      await page.locator('input[type=search]').last().fill('nenalezitelnypojem');
      assert.equal(await visible(), 0);
      await page.evaluate(id => { location.hash = id; }, lastId);
      await page.locator(`#${lastId}`).waitFor({ state: 'visible' });
      assert.equal(await page.locator('.ref-controls input').inputValue(), '');
      // Direct entry must also reveal an item beyond the first page.
      await page.goto(base + `quarto/slovnicek.html#${lastId}`, { waitUntil: 'networkidle' });
      assert(await page.locator(`#${lastId}`).isVisible());
      for (const size of ['25', '50', 'all', '10']) {
        await page.locator('.ref-controls select').selectOption(size);
        assert.equal(await visible(), Math.min(total, size === 'all' ? total : +size));
      }
      await page.locator('.ref-controls input').fill('measurement');
      assert(await visible() > 0, 'English search');
      await page.locator('.ref-controls input').fill('convenience');
      assert.equal(await visible(), 1, 'Search for the new English sampling term');
      assert(await page.locator('#pojem-prilezitostny-vyber').isVisible());
      await page.locator('.ref-controls input').fill('dostupny vyber');
      assert.equal(await visible(), 1, 'Search for an alternative Czech term without diacritics');
      assert(await page.locator('#pojem-prilezitostny-vyber').isVisible());
      await page.locator('.ref-controls input').fill('uroven mereni');
      assert(await visible() > 0, 'Search without Czech diacritics');
      await page.locator('.ref-controls input').fill('codebook');
      assert.equal(await visible(), 1, 'Search must reach the last row, beyond the first page');
      assert(await page.locator('#pojem-codebook').isVisible());
      await page.locator('.ref-controls input').focus();
      await page.keyboard.press('Tab');
      assert.equal(await page.evaluate(() => document.activeElement.tagName), 'SELECT');
    } else assert.equal(await page.locator('.ref-pagination button:not([disabled])').count(), 0);
    for (const file of ['znaceni', 'excel']) {
      await page.goto(base + `quarto/${file}.html`, { waitUntil: 'networkidle' });
      if (!(await page.locator('tbody tr').count())) assert.equal(await page.locator('.ref-pagination button:not([disabled])').count(), 0);
    }
    assert(!fs.existsSync(path.join(root, 'sources')), 'Private sources copied to web');
    assert(!fs.existsSync(path.join(root, 'quarto/README.md')), 'Author documentation copied to web');
    const noScript = await browser.newContext({ javaScriptEnabled: false });
    const plain = await noScript.newPage();
    await plain.goto(base + 'quarto/slovnicek.html');
    assert.equal(await plain.locator('tbody tr:visible').count(), total, 'All glossary rows readable without JavaScript');
    if (solutionCount) {
      await plain.goto(base + 'quarto/kapitola_01.html');
      assert.equal(await plain.locator('.callout[title="Ukázat řešení"] .callout-collapse:visible').count(), solutionCount, 'Solutions readable without JavaScript');
      assert(await plain.locator('#chyba-mereni-podrobne .callout-collapse').isVisible(), 'Optional explanation readable without JavaScript');
      await plain.setViewportSize({ width: 1360, height: 1000 });
      assert(await plain.locator('#toc-sec-datova-matice').isVisible(), 'TOC readable without JavaScript');
    }
    await noScript.close();
    const local = await browser.newPage({ viewport: { width: 1360, height: 1000 } });
    await local.goto(pathToFileURL(path.join(root, 'quarto/kapitola_01.html')).href);
    const localLink = local.locator('#toc-sec-datova-matice');
    assert(await localLink.isVisible(), 'TOC readable via file://, where module scripts are blocked');
    await localLink.click();
    await local.waitForFunction(() => location.hash === '#sec-datova-matice');
    await local.close();
    assert.deepEqual(errors, []);
    console.log(JSON.stringify({ pages: paths.length, glossaryItems: total, internalLinks: 'passed', solutionCount, solutions: 'keyboard + hidden/open/closed passed', centeredWidths: [1360, 1920], toc: 'HTTP + keyboard + no JavaScript + file:// passed', mobileWidth: 390, errors }, null, 2));
  } finally { await browser.close(); server.close(); }
})().catch(error => { console.error(error); server.close(); process.exitCode = 1; });
