const fs = require('node:fs');
const path = require('node:path');
const http = require('node:http');
const assert = require('node:assert/strict');
const { pathToFileURL } = require('node:url');
const { chromium } = require(process.env.PLAYWRIGHT_MODULE || 'playwright');
const root = path.resolve('_book');
const expectedReferences = [...fs.readFileSync('references.bib','utf8').matchAll(/^@\w+\{/gm)].length;
const prefix = '/statistics-for-psychology/';
const files = fs.readdirSync(path.join(root, 'quarto')).filter(f => f.endsWith('.html'));
const paths = ['index.html', ...files.map(f => `quarto/${f}`)];
const types = { '.html': 'text/html', '.js': 'text/javascript', '.css': 'text/css', '.json': 'application/json', '.svg': 'image/svg+xml', '.png': 'image/png' };
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
  page.on('pageerror', e => errors.push(`${page.url()}: ${e.stack || e.message}`));
  page.on('response', r => { if (r.url().startsWith(base) && r.status() >= 400) errors.push(`${r.status()} ${r.url()}`); });
  fs.mkdirSync('tmp/verification', { recursive: true });
  const documents = {};
  const referenceRecords = {};
  let solutionCount = 0;
  const solutionsByPage = {};
  try {
    for (const file of paths) {
      await page.goto(base + file, { waitUntil: 'networkidle' });
      documents[file] = await page.evaluate(() => ({ ids: [...document.querySelectorAll('[id]')].map(x => x.id), links: [...document.querySelectorAll('a[href]')].map(x => x.getAttribute('href')) }));
      referenceRecords[file] = await page.locator('#refs .csl-entry').evaluateAll(items=>Object.fromEntries(items.map(el=>[el.id,el.textContent.replace(/\s+/g,' ').trim()])));
      const ids = documents[file].ids;
      assert.equal(ids.length, new Set(ids).size, `Duplicate IDs: ${file}`);
      assert.equal(await page.locator('pre.sourceCode.r, div.cell-output-stderr').count(), 0, `Leaked R: ${file}`);
      // R43: approximate equality uses one symbol, including text and MathML.
      assert.ok(!(await page.locator('main').textContent()).includes('≐'), `Obsolete approximate equality: ${file}`);
      const approximateOperators = await page.locator('math').evaluateAll(items => items
        .filter(m => (m.querySelector('annotation[encoding="application/x-tex"]')?.textContent || '').includes('\\approx'))
        .filter(m => ![...m.querySelectorAll('mo')].some(op => op.textContent === '≈')).length);
      assert.equal(approximateOperators, 0, `Approximate equality missing in MathML: ${file}`);
      // R49: a bare @fig/@tbl renders in the nominative ("Obrázek 4.1"); after a preposition or governing noun it must be declined.
      const undeclined = (await page.locator('main').textContent()).match(/(?<!\p{L})(?:[Vv]e?|[Nn]a|[Zz]e?|[Kk]e?|[Oo]|[Pp]o|část[iy]?|řad[aěy]|řád(?:ek|ku)|panel[u]?|grafu|odpovídá)\s+(?:Obrázek|Tabulka)\s+\d+\.\d+/gu) || [];
      assert.deepEqual(undeclined, [], `Undeclined figure/table reference: ${file}`);
      // Decimal commas written as {,} must stay inside one <mn>, never become a spaced <mo>,</mo>.
      const decimalCommas = await page.evaluate(() => [...document.querySelectorAll('math')].map(m => {
        const tex = m.querySelector('annotation[encoding="application/x-tex"]')?.textContent || '';
        const marked = (tex.match(/\{,\}/g) || []).length;
        const inNumbers = [...m.querySelectorAll('mn')].reduce((sum, n) => sum + (n.textContent.match(/,/g) || []).length, 0);
        return { tex, marked, inNumbers };
      }).filter(x => x.marked !== x.inNumbers));
      assert.deepEqual(decimalCommas, [], `Decimal commas split in MathML: ${file}`);
      // Every student table has a static APA-style label and a nonempty title.
      const tableIssues = await page.locator('main table').evaluateAll(tables => tables.flatMap(table => {
        const figure = table.closest('figure.quarto-float-tbl');
        const caption = figure?.querySelector('figcaption');
        const label = caption?.querySelector('.quarto-float-caption-prefix');
        const title = caption?.cloneNode(true);
        title?.querySelector('.quarto-float-caption-prefix')?.remove();
        const issues = [];
        // A live table inside an interactive visualization changes with the inputs and has a panel title instead of a number.
        const live = table.closest('.viz') && table.getAttribute('aria-label');
        if (!live && (!label || !/^Tabulka\s+\d+(?:\.\d+)*$/.test(label.textContent.trim()))) issues.push('missing number');
        if (!live && !title?.textContent.trim()) issues.push('missing title');
        if (label && (getComputedStyle(label).display !== 'block' || Number(getComputedStyle(label).fontWeight) < 600)) issues.push('label styling');
        if (caption && getComputedStyle(caption).fontStyle !== 'italic') issues.push('title styling');
        if (caption && getComputedStyle(caption).textAlign !== 'left') issues.push('caption alignment');
        const head = table.tHead;
        if (head && (parseFloat(getComputedStyle(head).borderTopWidth) < 2 || parseFloat(getComputedStyle(head).borderBottomWidth) < 2)) issues.push('header rules');
        return issues.map(issue => `${table.id || figure?.parentElement.id}: ${issue}`);
      }));
      assert.deepEqual(tableIssues, [], `Table captions and styles: ${file}`);
      for (const width of [1360, 1920]) {
        await page.setViewportSize({ width, height: 1000 });
        const layout = await page.locator('main').boundingBox();
        assert(Math.abs(layout.x + layout.width / 2 - width / 2) < 2, `Centered content at ${width}px: ${file}`);
        assert(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth + 1), `Desktop overflow: ${file}`);
      }
      await page.setViewportSize({ width: 1360, height: 1000 });
      if (file === 'quarto/kapitola_01.html') {
        const pedagogy = page.locator('#souvislost-pedagogicka');
        assert.equal(await pedagogy.locator('.callout-collapse').isVisible(), false);
        await pedagogy.locator('[data-bs-toggle="collapse"]').focus();
        await page.keyboard.press('Enter');
        await pedagogy.locator('.callout-collapse').waitFor({state:'visible'});
        const figures01 = page.locator('main .quarto-figure img');
        assert.equal(await figures01.count(), 12, 'Chapter 1 has ten diagrams and two simulated scatterplots');
        for (const img of await figures01.all()) {
          assert(await img.evaluate(e => e.complete && e.naturalWidth > 0), 'Chapter 1 figure loaded');
          assert((await img.getAttribute('alt')).length > 40, 'Chapter 1 descriptive alt text');
        }
        const body01 = await page.locator('main').innerText();
        assert(body01.includes('Náhodné přiřazení k podmínkám'), 'Preferred assignment term');
        assert(!body01.includes('náhodné přidělení'), 'Old preferred assignment term removed from exposition');
        for (const region of await page.locator('.teaching-figure').all()) {
          await region.screenshot({path:`tmp/verification/ch01-${await region.locator('[id^="fig-"]').first().getAttribute('id')}-desktop.png`});
        }
        const references = page.locator('#refs .csl-entry');
        assert.equal(await references.count(), expectedReferences, 'Shared citation data remains available for consistent APA suffixes and popovers');
        const howell = (await page.locator('#ref-howell').innerText()).trim();
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
          borsboom2002: ['2002', '10.1016/S0160-2896(02)00082-X'],
          stevens1946: ['1946', '10.1126/science.103.2684.677'],
          weigl2021: ['2021', '10.1177/0013164420952118']
        };
        for (const [key, [year, doi]] of Object.entries(newSources)) {
          const entry = page.locator(`#ref-${key}`);
          assert((await entry.innerText()).includes(`(${year})`), `Year: ${key}`);
          assert.equal(await entry.locator('a').getAttribute('href'), `https://doi.org/${doi}`);
          assert(await entry.locator('em').count() >= 1, `APA journal italics: ${key}`);
        }
        assert.equal(await page.locator('#ref-salzberger2010 a').getAttribute('href'), 'https://www.rasch.org/rmt/rmt242a.htm');
        assert.match(await page.locator('#ref-salzberger2010').innerText(), /Salzberger, T\. \(2010\)/);
        const optional = page.locator('#chyba-mereni-podrobne');
        assert.equal(await optional.locator('.callout-collapse').isVisible(), false);
        await optional.locator('[data-bs-toggle="collapse"]').focus();
        await page.keyboard.press('Enter');
        await optional.locator('.callout-collapse').waitFor({ state: 'visible' });
        await optional.screenshot({ path: 'tmp/verification/measurement-error-desktop.png' });
        await optional.locator('[data-bs-toggle="collapse"]').click();
        await optional.locator('.callout-collapse').waitFor({ state: 'hidden' });
        for (const id of ['sec-role-promennych', 'sec-interni-externi-validita', 'sec-kodovani', 'sec-chybejici', 'sec-stejna-vlastnost', 'sec-kvaziintervalove', 'sec-uroven-a-spojitost']) {
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
      if (file === 'quarto/kapitola_02.html') {
        await page.waitForFunction(() => !!document.querySelector('math'));
        assert.equal(await page.locator('merror').count(), 0, 'No MathML parse errors');
        const images = page.locator('main img');
        assert.equal(await images.count(), 17, 'Fourteen figures and three Excel illustrations');
        for (const img of await images.all()) {
          assert(await img.evaluate(el => el.complete && el.naturalWidth > 0), 'Figure loaded');
          assert((await img.getAttribute('alt')).length > 30, 'Descriptive figure alternative');
        }
        for (const fig of await page.locator('main figure.quarto-float-fig').all()) {
          if (!await fig.isVisible()) continue; // Tables in collapsed solutions are checked when opened below.
          const id = await fig.evaluate(el => el.closest('[id]').id);
          await fig.screenshot({ path: `tmp/verification/ch02-${id}.png` });
        }
        assert.equal(await page.locator('#refs .csl-entry').count(), expectedReferences);
        assert.match(await page.locator('#ref-cleveland1984').innerText(), /Cleveland, W. S., & McGill, R. \(1984\)/);
        assert.equal(await page.locator('#ref-cleveland1984 a').getAttribute('href'), 'https://doi.org/10.1080/01621459.1984.10478080');
        assert.match(await page.locator('#ref-howell').innerText(), /8\. vyd\./);
        assert.equal(await page.locator('#ref-nistHandbook a').getAttribute('href'), 'https://doi.org/10.18434/M32189');
        for (const section of ['eda35h.htm', 'eda3662.htm']) {
          assert.equal(await page.locator(`.citation[data-cites="nistHandbook"] a[href="https://www.itl.nist.gov/div898/handbook/eda/section3/${section}"]`).count(), 1, 'Specific NIST section remains directly linked');
        }
        assert(await page.locator('#tbl-hranice-intervalu').isVisible(), 'Both boundary conventions are available');

        assert.equal(await page.locator('#ref-msExcel a').getAttribute('href'), 'https://support.microsoft.com/cs-cz/excel/');
        for (const section of ['functions/count-function','functions/countifs-function','functions/sum-function','create-a-histogram']) {
          assert.equal(await page.locator(`.citation[data-cites="msExcel"] a[href="https://support.microsoft.com/cs-cz/excel/${section}"]`).count(), 1, 'Specific Excel documentation remains directly linked');
        }
        for (const id of ['sec-sumace','sec-excel-histogram','sec-hranice-intervalu','sec-kumulativni-graf','sec-polygon-cetnosti','sec-tvar-rozdeleni']) {
          await page.locator(`#${id}`).screenshot({path:`tmp/verification/ch02-${id}-desktop.png`});
        }
        fs.writeFileSync('tmp/verification/ch02-citations.json', JSON.stringify(await page.locator('.citation, #refs .csl-entry').allTextContents(),null,2));
      }
      if (file === 'quarto/literatura.html') {
        assert.equal(await page.locator('#refs .csl-entry:visible').count(),expectedReferences,'All cited sources appear in the shared bibliography');
        assert.equal(await page.locator('h1 .chapter-number').count(),0,'Bibliography is unnumbered');
        for (const [key, year] of Object.entries({nistHandbook: 2022, msExcel: 2026, rDocumentation: 2026, scipyDocumentation: 2026, nistShannon: 2016})) {
          assert.equal(await page.locator(`#ref-${key}`).count(), 1, 'One reference per documentation work');
          assert.match(await page.locator(`#ref-${key}`).innerText(), new RegExp(`\\(${year}[,)]`), 'Agreed documentation year');
        }
        assert.match(await page.locator('#ref-onsBar').innerText(), /Získáno\s+5\. října 2026, z/, 'Czech retrieval date for an undated source');
        assert.doesNotMatch(await page.locator('#refs').innerText(), /Retrieved|n\.d\./, 'Czech citation labels');
        await page.locator('#refs').screenshot({path:'tmp/verification/bibliography-desktop.png'});
      }
      if (file.includes('kapitola_')) {
        const number=String(Number(file.match(/kapitola_(\d+)\.html/)[1]));
        assert.equal((await page.locator('h1 .chapter-number').innerText()).trim(),number,'Part headings must not change chapter numbers');
        assert.equal(await page.locator('#refs .csl-entry:visible').count(),0,'Bibliography appears only on its own page');
        for (const cite of await page.locator('a[role="doc-biblioref"]').all()) {
          const target=new URL(await cite.getAttribute('href'),page.url()); assert.equal(target.pathname,prefix+'quarto/literatura.html','Citation links to the common bibliography'); assert(target.hash.startsWith('#ref-'));
        }
      }
      if (file !== 'index.html') assert.equal(await page.locator('.ref-controls').count(), ['quarto/slovnicek.html','quarto/znaceni.html','quarto/excel.html'].includes(file) ? 1 : 0);
      const solutions = page.locator('.callout[title="Ukázat řešení"]');
      solutionsByPage[file] = await solutions.count();
      solutionCount += await solutions.count();
      if (file === 'quarto/kapitola_02.html') assert.equal(await solutions.count(), 10);
      if (file === 'quarto/kapitola_05.html') {
        assert.equal(await solutions.count(),12,'Chapter 5 has twelve complete exercise solutions');
        assert.equal(await page.locator('merror').count(),0,'Chapter 5 mathematics parses');
        assert.equal(await page.locator('main img').count(),13);
        for(const img of await page.locator('main img').all()) {
          await img.scrollIntoViewIfNeeded();
          assert(await img.evaluate(el=>el.complete && el.naturalWidth>0));
          assert((await img.getAttribute('alt')).length>30);
        }
        const greek5=await page.locator('main math mi').evaluateAll(items=>items.filter(e=>/[πμσ]/.test(e.textContent)).map(e=>({text:e.textContent,variant:e.getAttribute('mathvariant')})));
        assert(greek5.filter(e=>e.text.includes('π')).length>12,'Success probability actually rendered as pi');
        assert(greek5.every(e=>e.variant==='normal'),'Greek parameters of chapter 5 must be upright');
        assert((await page.locator('main math mi').evaluateAll(items=>items.filter(e=>e.textContent==='P').length))>40,'Probability notation uses capital P');
        for(const id of ['rozsireni-sance','rozsireni-stredni-hodnota','rozsireni-variace']) {
          assert.equal(await page.locator(`#${id} [data-bs-toggle="collapse"]`).getAttribute('aria-expanded'),'false',`Optional extension starts collapsed: ${id}`);
        }
        for(const id of ['sec-uplna-pravdepodobnost','sec-dve-prevalence','sec-normalni-aproximace','sec-konjunkcni-klam']) assert(await page.locator('#'+id).isVisible(),`Core section present: ${id}`);
        assert.equal(await page.locator('#sec-uplna-pravdepodobnost .callout-collapse, #sec-normalni-aproximace .callout-collapse').count(),0,'Total probability and approximation are not optional');
        for(const fig of await page.locator('main figure.quarto-float-fig').all()) {
          const id=await fig.evaluate(el=>el.closest('[id]').id);
          await fig.screenshot({path:`tmp/verification/ch05-${id}.png`});
        }
        for(const id of ['sec-kontingencni-tabulka','sec-bayesova-veta','sec-binomicky-vzorec','sec-excel-binom','sec-aproximace-presnost']) {
          await page.locator('#'+id).screenshot({path:`tmp/verification/ch05-${id}-desktop.png`});
        }
      }
      if (file === 'quarto/kapitola_06.html') {
        assert.equal(await solutions.count(),16,'Chapter 6 has twelve core and four optional exercise solutions');
        assert.equal(await page.locator('merror').count(),0,'Chapter 6 mathematics parses');
        assert.equal(await page.locator('main img').count(),17);
        assert.equal(await page.locator('#rozsireni-rozdeleni-p #fig-rozdeleni-p').count(),1,'p-value distribution figure is inside its optional extension');
        const pdist6=page.locator('#fig-rozdeleni-p');
        assert.equal(await pdist6.isVisible(),false,'Optional p-value figure is hidden initially');
        assert.equal(await page.locator('#rozsireni-rozdeleni-p [data-bs-toggle="collapse"]').getAttribute('aria-expanded'),'false','Optional extension starts collapsed: rozsireni-rozdeleni-p');
        const pdistToggle=page.locator('#rozsireni-rozdeleni-p [data-bs-toggle="collapse"]');
        await pdistToggle.focus();await page.keyboard.press('Enter');await pdist6.waitFor({state:'visible'});
        for(const img of await page.locator('main img').all()) {
          await img.scrollIntoViewIfNeeded();
          assert(await img.evaluate(el=>el.complete && el.naturalWidth>0));
          assert((await img.getAttribute('alt')).length>30);
        }
        const greek6=await page.locator('main math mi').evaluateAll(items=>items.filter(e=>/[πμσαβ]/.test(e.textContent)).map(e=>({text:e.textContent,variant:e.getAttribute('mathvariant')})));
        assert(greek6.filter(e=>e.text.includes('σ')).length>12,'Standard error notation actually rendered with sigma');
        assert(greek6.filter(e=>e.text.includes('α')).length>5,'Significance level rendered as alpha');
        assert(greek6.every(e=>e.variant==='normal'),'Greek symbols of chapter 6 must be upright');
        for(const id of ['rozsireni-odvozeni-chyby','rozsireni-vypocet-sily','rozsireni-standardizovany-rozdil','rozsireni-test-screening','rozsireni-omyly-p','rozsireni-dve-tradice']) {
          assert.equal(await page.locator(`#${id} [data-bs-toggle="collapse"]`).getAttribute('aria-expanded'),'false',`Optional extension starts collapsed: ${id}`);
        }
        for(const id of ['sec-devet-vyberu','sec-odhad-chyby','sec-zakon-velkych-cisel','sec-clv-zneni','sec-smer-testu','sec-nezamitnuti','sec-zaver-testu','sec-binomicky-test','sec-z-test']) assert(await page.locator('#'+id).isVisible(),`Core section present: ${id}`);
        assert.equal(await page.locator('#sec-odhad-chyby .callout-collapse, #sec-zakon-velkych-cisel .callout-collapse, #sec-dva-testy .callout-collapse').count(),0,'Estimated standard error, law of large numbers and worked tests are not optional');
        const main6=await page.locator('main').innerText();
        assert(!/přijímáme nulovou hypotézu|nulová hypotéza byla přijata/i.test(main6.replace(/„[^“]*“/g,'')),'Non-rejection is never worded as acceptance outside quoted counterexamples');
        for(const fig of await page.locator('main figure.quarto-float-fig').all()) {
          const id=await fig.evaluate(el=>el.closest('[id]').id);
          await fig.screenshot({path:`tmp/verification/ch06-${id}.png`});
        }
        for(const id of ['sec-devet-vyberu','sec-pet-pojmu','sec-hladina-kriticky-obor','sec-statisticka-sila','sec-zaver-testu','sec-kroky-testu']) {
          await page.locator('#'+id).screenshot({path:`tmp/verification/ch06-${id}-desktop.png`});
        }
        await page.locator('#rozsireni-rozdeleni-p').screenshot({path:'tmp/verification/ch06-rozsireni-rozdeleni-p-desktop.png'});
        await pdistToggle.click();await pdist6.waitFor({state:'hidden'});
      }
      if (file === 'quarto/kapitola_10.html') {
        assert.equal(await solutions.count(),18,'Chapter 10 has sixteen core and two optional exercise solutions');
        assert.equal(await page.locator('merror').count(),0,'Chapter 10 mathematics parses');
        assert.equal(await page.locator('main img').count(),18,'Chapter 10 has seventeen figures in the text and one in an optional extension');
        for(const img of await page.locator('main img').all()) {
          if(await img.isVisible()) await img.scrollIntoViewIfNeeded();
          assert(await img.evaluate(async el=>{ if(!el.complete) await el.decode().catch(()=>{}); return el.complete && el.naturalWidth>0; }));
          assert((await img.getAttribute('alt')).length>30);
        }
        for(const id of ['fig-stejne-r','fig-prekryvani','sec-prekryvani-bodu','fig-fisher-transformace','fig-permutace-presna','fig-odlehle-typy','fig-reliabilita','fig-rpb-d','tbl-k10-preskupeni','tbl-k10-09','rozsireni-meze-r','rozsireni-korekce-reliabilita']) assert.equal(await page.locator('#'+id).count(),1,`Chapter 10 revision element: ${id}`);
        const text10=await page.locator('main').innerText();
        assert(!/(Pearsonů?v|Spearmanů?v|Kendallů?v|Pearsonov[aěuy]m?|Spearmanov[aěuy]m?|Kendallov[aěuy]m?) koeficient/.test(text10),'Chapter 10 uses the full names of the correlation coefficients');
        assert(!/(lineární|zakřivený|stoupající|klesající) mrak/.test(text10),'Chapter 10 does not describe relationships as clouds');
        assert(/observační studie/.test(text10) && /Anscomb/.test(text10) && /\[−0,72; −0,49\]/.test(text10),'Chapter 10 revision content is rendered');
        assert(await page.locator('#ref-anscombe1973').count()===1 && await page.locator('#ref-muchinsky1996').count()===1,'Anscombe and Muchinsky in the bibliography');
        const greek10=await page.locator('main math mi').evaluateAll(items=>items.filter(e=>/[ρτφχΦ]/.test(e.textContent)).map(e=>({text:e.textContent,variant:e.getAttribute('mathvariant')})));
        assert(greek10.filter(e=>e.text.includes('τ')).length>5,'Kendall tau rendered');
        assert(greek10.filter(e=>/[ρτφχ]/.test(e.text)).every(e=>e.variant==='normal'),'Greek symbols of chapter 10 must be upright');
        for(const id of ['rozsireni-meze-r','rozsireni-bca','rozsireni-korekce-reliabilita','rozsireni-d-r']) {
          assert.equal(await page.locator(`#${id} [data-bs-toggle="collapse"]`).getAttribute('aria-expanded'),'false',`Optional extension starts collapsed: ${id}`);
        }
        // Lightbox caption with inline math (assets/lightbox-captions.js): rendered MathML, no TeX source.
        const lb10=page.locator('#fig-permutace-presna a.lightbox');
        assert(!/\\mathrm/.test(await lb10.getAttribute('title')) && (await lb10.getAttribute('title')).includes('τb'),'Lightbox tooltip shows readable math, not TeX');
        await lb10.scrollIntoViewIfNeeded();
        await lb10.click();
        const lb10Title=page.locator('.glightbox-container .gslide.current .gslide-title');
        await lb10Title.locator('math').first().waitFor();
        assert(!/\\mathrm/.test(await lb10Title.innerText()) && (await lb10Title.innerText()).includes('720 přiřazení'),'Lightbox caption renders math instead of TeX source');
        await page.waitForTimeout(600);
        await page.screenshot({path:'tmp/verification/ch10-lightbox-math-desktop.png'});
        await page.keyboard.press('Escape');
        await page.locator('.glightbox-container').waitFor({state:'detached'});
        const main10=await page.locator('main').innerText();
        assert(!/přijímáme nulovou hypotézu|nulová hypotéza byla přijata/i.test(main10.replace(/„[^“]*“/g,'')),'Non-rejection is never worded as acceptance');
        assert(/dynamickými poli/.test(main10),'The Excel version requirement is stated');
        for(const fig of await page.locator('main figure.quarto-float-fig').all()) {
          const id=await fig.evaluate(el=>el.closest('[id]').id);
          if(!await fig.isVisible()) {
            const ext=fig.locator('xpath=ancestor::div[contains(concat(" ",@class," ")," callout ")][1]');
            await ext.locator('[data-bs-toggle="collapse"]').first().click();
            await fig.waitFor({state:'visible'});
          }
          await fig.screenshot({path:`tmp/verification/ch10-${id}.png`});
        }
        for(const id of ['sec-ctyri-casti','sec-cist-r','sec-tau-b','sec-fisher-interval','sec-nahodny-permutacni','sec-pocet-opakovani','sec-rozhodovaci-tabulka','sec-korelacni-matice']) {
          await page.locator('#'+id).screenshot({path:`tmp/verification/ch10-${id}-desktop.png`});
        }
      }
      if (file === 'quarto/kapitola_09.html') {
        assert.equal(await solutions.count(),15,'Chapter 9 has thirteen core and two optional exercise solutions');
        assert.equal(await page.locator('merror').count(),0,'Chapter 9 mathematics parses');
        assert.equal(await page.locator('main img').count(),12);
        for(const img of await page.locator('main img').all()) {
          if(await img.isVisible()) await img.scrollIntoViewIfNeeded();
          assert(await img.evaluate(async el=>{ if(!el.complete) await el.decode().catch(()=>{}); return el.complete && el.naturalWidth>0; }));
          assert((await img.getAttribute('alt')).length>30);
        }
        for(const id of ['fig-wilson-odvozeni','fig-pokryti','fig-newcombe','fig-z2-chi2','fig-fisher','fig-monte-carlo','fig-kappa','sec-monte-carlo','sec-znamenkovy-test','tbl-k09-13','tbl-k09-14']) assert.equal(await page.locator('#'+id).count(),1,`Chapter 9 revision element: ${id}`);
        const greek9=await page.locator('main math mi').evaluateAll(items=>items.filter(e=>/[πχφκα]/.test(e.textContent)).map(e=>({text:e.textContent,variant:e.getAttribute('mathvariant')})));
        assert(greek9.filter(e=>e.text.includes('χ')).length>10,'Chi-square rendered with chi');
        assert(greek9.every(e=>e.variant==='normal'),'Greek symbols of chapter 9 must be upright');
        for(const id of ['rozsireni-wilson-odvozeni','rozsireni-ganzfeld','rozsireni-proc-chi','rozsireni-holm','rozsireni-fisher','rozsireni-intervaly-pomeru','rozsireni-simpson','rozsireni-kappa']) {
          assert.equal(await page.locator(`#${id} [data-bs-toggle="collapse"]`).getAttribute('aria-expanded'),'false',`Optional extension starts collapsed: ${id}`);
        }
        const main9=await page.locator('main').innerText();
        assert(!/přijímáme nulovou hypotézu|nulová hypotéza byla přijata/i.test(main9.replace(/„[^“]*“/g,'')),'Non-rejection is never worded as acceptance');
        assert(!/kategorick/i.test(main9),'Only the approved variant "kategoriální" is used');
        assert(!/rozložen|upraven\S+ rezidu|tabulk\S+ přechod/i.test(main9),'Chapter 9 uses rozdělení, standardizované reziduum and tabulka párových dat');
        assert.equal(await page.locator('main blockquote em').evaluateAll(items=>items.filter(e=>/χ/.test(e.textContent)).length),0,'Chi in APA report examples is upright');
        for(const fig of await page.locator('main figure.quarto-float-fig').all()) {
          const id=await fig.evaluate(el=>el.closest('[id]').id);
          if(!(await fig.isVisible())) await fig.evaluate(el=>{const c=el.closest('.callout');if(c)c.querySelectorAll('.callout-collapse').forEach(x=>x.classList.add('show'));});
          await fig.screenshot({path:`tmp/verification/ch09-${id}.png`});
        }
        for(const id of ['sec-wald','sec-interval-podilu-excel','sec-newcombe','sec-dobra-shoda-excel','sec-pearson-upravena','sec-tabulka-excel','sec-fisher','sec-pomer-rizik-sanci','sec-phi-v','sec-monte-carlo','sec-mcnemaruv-test','sec-znamenkovy-test','sec-ktery-postup-09','sec-ukazka-sdeleni-09']) {
          await page.locator('#'+id).screenshot({path:`tmp/verification/ch09-${id}-desktop.png`});
        }
      }
      if (file === 'quarto/kapitola_08.html') {
        assert.equal(await solutions.count(),14,'Chapter 8 has twelve core and two optional exercise solutions');
        assert.equal(await page.locator('merror').count(),0,'Chapter 8 mathematics parses');
        assert.equal(await page.locator('main img').count(),10);
        assert.equal(await page.locator('.callout-body-container #fig-qq-rozdily-08').count(),1,'Exercise 3 Q-Q plot is inside the solution');
        const qq8=page.locator('#fig-qq-rozdily-08');
        assert.equal(await qq8.isVisible(),false,'Exercise Q-Q plot is hidden initially');
        const qq8Toggle=qq8.locator('xpath=ancestor::div[contains(@class,"callout") and contains(@class,"callout-style-default")][1]').locator('[data-bs-toggle="collapse"]');
        await qq8Toggle.focus();await page.keyboard.press('Enter');await qq8.waitFor({state:'visible'});
        for(const img of await page.locator('main img').all()) {
          // Figures inside collapsed optional extensions are checked after expanding them below.
          if(!(await img.isVisible())) { assert((await img.getAttribute('alt')).length>30); continue; }
          await img.scrollIntoViewIfNeeded();
          assert(await img.evaluate(el=>el.complete && el.naturalWidth>0));
          assert((await img.getAttribute('alt')).length>30);
        }
        const greek8=await page.locator('main math mi').evaluateAll(items=>items.filter(e=>/[μσα]/.test(e.textContent)).map(e=>({text:e.textContent,variant:e.getAttribute('mathvariant')})));
        assert(greek8.filter(e=>e.text.includes('μ')).length>10,'Population means rendered with mu');
        assert(greek8.every(e=>e.variant==='normal'),'Greek symbols of chapter 8 must be upright');
        for(const id of ['rozsireni-rozptyl-rozdilu-08','rozsireni-welch-stupne','rozsireni-interval-d','rozsireni-standardizace-08','rozsireni-tost-skupiny']) {
          assert.equal(await page.locator(`#${id} [data-bs-toggle="collapse"]`).getAttribute('aria-expanded'),'false',`Optional extension starts collapsed: ${id}`);
        }
        const main8=await page.locator('main').innerText();
        assert(!/přijímáme nulovou hypotézu|nulová hypotéza byla přijata/i.test(main8.replace(/„[^“]*“/g,'')),'Non-rejection is never worded as acceptance outside quoted counterexamples');
        assert(!/nevypovídají vůbec/.test(main8),'Approved wording about paired intervals');
        for(const fig of await page.locator('main figure.quarto-float-fig').all()) {
          const id=await fig.evaluate(el=>el.closest('[id]').id);
          if(!(await fig.isVisible())) continue; // collapsed optional extensions are captured in the mobile figure check
          await fig.screenshot({path:`tmp/verification/ch08-${id}.png`});
        }
        for(const id of ['sec-neuplne-dvojice','sec-parovy-excel','sec-chybna-analyza','sec-welch-excel','sec-dva-intervaly','sec-rozdil-zmen','sec-ekvivalence-skupin','sec-ktery-postup']) {
          await page.locator('#'+id).screenshot({path:`tmp/verification/ch08-${id}-desktop.png`});
        }
        await qq8Toggle.click();await qq8.waitFor({state:'hidden'});
      }
      if (file === 'quarto/kapitola_07.html') {
        assert.equal(await solutions.count(),14,'Chapter 7 has twelve core and two optional exercise solutions');
        assert.equal(await page.locator('merror').count(),0,'Chapter 7 mathematics parses');
        assert.equal(await page.locator('main img').count(),10,'Chapter 7 has ten figures including the mirror and one-sided interval figures');
        assert.equal(await page.locator('.callout-body-container #fig-qq-uzkost-07').count(),1,'Exercise 7 Q-Q plot is inside the solution');
        const qq7=page.locator('#fig-qq-uzkost-07');
        assert.equal(await qq7.isVisible(),false,'Exercise Q-Q plot is hidden initially');
        const qqToggle=qq7.locator('xpath=ancestor::div[contains(@class,"callout") and contains(@class,"callout-style-default")][1]').locator('[data-bs-toggle="collapse"]');
        await qqToggle.focus();await page.keyboard.press('Enter');await qq7.waitFor({state:'visible'});
        for(const img of await page.locator('main img').all()) {
          await img.scrollIntoViewIfNeeded();
          assert(await img.evaluate(el=>el.complete && el.naturalWidth>0));
          assert((await img.getAttribute('alt')).length>30);
        }
        const greek7=await page.locator('main math mi').evaluateAll(items=>items.filter(e=>/[μσαΔ]/.test(e.textContent)).map(e=>({text:e.textContent,variant:e.getAttribute('mathvariant')})));
        assert(greek7.filter(e=>e.text.includes('Δ')).length>5,'Equivalence bound rendered with Delta');
        assert(greek7.filter(e=>e.text.includes('μ')).length>20,'Population mean rendered with mu');
        assert(greek7.every(e=>e.variant==='normal'),'Greek symbols of chapter 7 must be upright');
        const quantiles=await page.locator('main math msub').evaluateAll(items=>items.filter(e=>e.firstElementChild&&e.firstElementChild.textContent==='t'&&/v/.test(e.lastElementChild.textContent)).length);
        assert(quantiles>5,'t quantiles carry the level and degrees of freedom in the subscript');
        for(const id of ['rozsireni-tezsi-chvosty','rozsireni-odolnost-t','rozsireni-tost-vypocet','rozsireni-noninferiorita']) {
          assert.equal(await page.locator(`#${id} [data-bs-toggle="collapse"]`).getAttribute('aria-expanded'),'false',`Optional extension starts collapsed: ${id}`);
        }
        for(const id of ['sec-co-znamena-95','sec-interval-predpoklady','sec-t-rozdeleni','sec-interval-t','sec-t-test','sec-interval-a-p','sec-pasmo-ekvivalence','sec-test-ekvivalence','sec-ctyri-kombinace','sec-meze-ekvivalence']) assert(await page.locator('#'+id).isVisible(),`Core section present: ${id}`);
        assert.equal(await page.locator('#sec-test-ekvivalence .callout-collapse, #sec-proc-90 .callout-collapse, #sec-interval-a-p .callout-collapse').count(),0,'TOST logic and the interval-test link are not optional');
        const main7=await page.locator('main').innerText();
        assert(!/přijímáme nulovou hypotézu|nulová hypotéza byla přijata/i.test(main7.replace(/„[^“]*“/g,'')),'Non-rejection is never worded as acceptance outside quoted counterexamples');
        for(const fig of await page.locator('main figure.quarto-float-fig').all()) {
          const id=await fig.evaluate(el=>el.closest('[id]').id);
          await fig.screenshot({path:`tmp/verification/ch07-${id}.png`});
        }
        for(const id of ['sec-interval-z-vypocet','sec-co-znamena-95','sec-interval-t-excel','sec-t-test-pozornost','sec-mnozina-nezamitnutych','sec-proc-90','sec-ctyri-kombinace','sec-ukazka-sdeleni']) {
          await page.locator('#'+id).screenshot({path:`tmp/verification/ch07-${id}-desktop.png`});
        }
        await qqToggle.click();await qq7.waitFor({state:'hidden'});
      }
      if (file === 'quarto/kapitola_04.html') {
        assert.equal(await solutions.count(),10,'Chapter 4 has ten complete exercise solutions');
        assert.equal(await page.locator('merror').count(),0,'Chapter 4 mathematics parses');
        assert.equal(await page.locator('main img').count(),21);
        // The finished Q-Q plot is shown in the principle section, before its Excel construction.
        assert.equal(await page.locator('#sec-qq-graf #fig-qq-priklad-04').count(),1,'Q-Q example appears with the principle');
        for(const id of ['fig-qq-sikme-vlevo-04','fig-qq-lehke-04']) assert.equal(await page.locator('#'+id).count(),1,`New diagnostic figure: ${id}`);
        // The P-P figure sits in a collapsed optional extension: closed by default, opens by keyboard.
        const pp = page.locator('#rozsireni-pp-graf');
        assert.equal(await pp.locator('.callout-collapse').isVisible(), false, 'P-P extension is collapsed by default');
        await pp.locator('[data-bs-toggle="collapse"]').focus();
        await page.keyboard.press('Enter');
        await pp.locator('.callout-collapse').waitFor({state:'visible'});
        for(const img of await page.locator('main img').all()) {
          await img.scrollIntoViewIfNeeded();
          assert(await img.evaluate(el=>el.complete && el.naturalWidth>0));
          assert((await img.getAttribute('alt')).length>30);
        }
        const greek=await page.locator('main math mi').evaluateAll(items=>items.filter(e=>/[μσ]/.test(e.textContent)).map(e=>({text:e.textContent,variant:e.getAttribute('mathvariant')})));
        assert(greek.length>12,'Population notation actually rendered');
        assert(greek.every(e=>e.variant==='normal'),'Greek parameters must be upright');
        assert(await page.locator('#sec-primerenost-modelu').isVisible(),'Model assessment is core material');
        assert.equal(await page.locator('#sec-excel-qq .callout-collapse').count(),0,'Q-Q construction is not optional/collapsed');
        for(const fig of await page.locator('main figure.quarto-float-fig').all()) {
          const id=await fig.evaluate(el=>el.closest('[id]').id);
          await fig.screenshot({path:`tmp/verification/ch04-${id}.png`});
        }
        for(const id of ['sec-parametry-normalniho','sec-excel-normalni','sec-centralni-podil','sec-steny-staniny','sec-excel-qq']) {
          await page.locator('#'+id).screenshot({path:`tmp/verification/ch04-${id}-desktop.png`});
        }
        // Lightbox: every figure opens enlarged with its caption and closes by Escape.
        assert.equal(await page.locator('main img:not(a.lightbox img)').count(),0,'Every chapter 4 image opens in the lightbox');
        const lbFigure=page.locator('#fig-distribucni-04');
        const lbSrc=await lbFigure.locator('img').getAttribute('src');
        await lbFigure.locator('a.lightbox').scrollIntoViewIfNeeded();
        await lbFigure.locator('a.lightbox').click();
        const lbSlide=page.locator('.glightbox-container .gslide.current');
        await lbSlide.locator('img').waitFor({state:'visible'});
        assert((await lbSlide.locator('img').getAttribute('src')).endsWith(lbSrc.replace(/^(\.\.\/)+/,'')),'Lightbox shows the clicked figure');
        assert((await lbSlide.locator('.gslide-description').textContent()).includes('distribuční funkce'),'Lightbox shows the figure caption');
        await page.waitForTimeout(600);
        const lbBox=await lbSlide.locator('img').boundingBox();
        const inlineWidth=(await lbFigure.locator('img').boundingBox()).width;
        assert(lbBox.width>inlineWidth && lbBox.height>500,'Lightbox enlarges the figure beyond its page size');
        assert.equal(await page.locator('.glightbox-container .gnext, .glightbox-container .gprev').filter({visible:true}).count(),0,'No unusable gallery arrows');
        await page.screenshot({path:'tmp/verification/ch04-lightbox-desktop.png'});
        await page.keyboard.press('Escape');
        await page.locator('.glightbox-container').waitFor({state:'detached'});
        fs.writeFileSync('tmp/verification/ch04-citations.json',JSON.stringify(await page.locator('.citation,#refs .csl-entry').allTextContents(),null,2));
      }
      if (file === 'quarto/kapitola_03.html') {
        assert.equal(await solutions.count(),16,'Thirteen core and three optional exercises');
        assert.equal(await page.locator('merror').count(),0,'Chapter 3 formulas parse');
        assert.equal(await page.locator('main img').count(),18);
        // Shape coefficients are core material; only their formulas stay in the collapsed extension.
        assert(await page.locator('#sec-ukazatele-tvaru').isVisible(),'Shape section is core material');
        assert(await page.locator('#fig-ukazatele-tvaru img').isVisible() && await page.locator('#fig-spicatost img').isVisible(),'Shape figures are outside collapsed blocks');
        assert.equal(await page.locator('#refs .csl-entry').count(),expectedReferences);
        for(const id of ['rozsireni-korekce-rozptylu','rozsireni-entropie','rozsireni-momenty','rozsireni-excel-03']) {
          const block=page.locator('#'+id);
          assert(!await block.locator('.callout-collapse').isVisible(),'Optional material initially closed');
          await block.locator('[data-bs-toggle="collapse"]').click();
          await block.locator('.callout-collapse').waitFor({state:'visible'});
          await page.waitForTimeout(350);
        }
        for(const img of await page.locator('main img').all()) {
          await img.scrollIntoViewIfNeeded();
          assert(await img.evaluate(el=>el.complete&&el.naturalWidth>0),'Chapter 3 figure loaded');
          assert((await img.getAttribute('alt')).length>30);
        }
        for(const fig of await page.locator('main figure.quarto-float-fig').all()) {
          const id=await fig.evaluate(el=>el.closest('[id]').id);
          await fig.screenshot({path:`tmp/verification/ch03-${id}.png`});
        }
        for(const id of ['sec-modus','sec-median','sec-volba-stredu','sec-stred-tvar','sec-vypocet-kvantilu','sec-kvantil-kumulativni','sec-orezani-winsorizace','sec-percentilove-poradi','sec-rozptyl','sec-korekce-rozptylu','sec-median-absolutnich','sec-boxplot','sec-zmena-skaly','sec-reportovani-apa','sec-entropie','sec-ukazatele-tvaru','sec-excel-tvar','sec-momenty','sec-excel-poloha']) {
          await page.locator('#'+id).screenshot({path:`tmp/verification/ch03-${id}-desktop.png`});
        }
        for(const id of ['rozsireni-korekce-rozptylu','rozsireni-entropie','rozsireni-momenty','rozsireni-excel-03']) {
          const block=page.locator('#'+id);
          await block.locator('[data-bs-toggle="collapse"]').click();
          await block.locator('.callout-collapse').waitFor({state:'hidden'});
        }
        fs.writeFileSync('tmp/verification/ch03-citations.json',JSON.stringify(await page.locator('.citation,#refs .csl-entry').allTextContents(),null,2));
      }
      if (file === 'quarto/kapitola_01.html') assert.equal(await solutions.count(), 9, 'All nine exercises must have a solution');
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
      if(file==='quarto/kapitola_04.html') {
        for(const id of ['sec-parametry-normalniho','sec-excel-normalni','sec-steny-staniny','sec-excel-qq','fig-qq-priklad-04','fig-qq-smes-04']) {
          await page.locator('#'+id).screenshot({path:`tmp/verification/ch04-${id}-mobile.png`});
        }
        for(const solution of await solutions.all()) {
          await solution.locator('[data-bs-toggle="collapse"]').click();
          await solution.locator('.callout-collapse').waitFor({state:'visible'});
          await page.waitForTimeout(350); // Bootstrap ignores a second toggle during its transition.
          assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1),'Chapter 4 open solution mobile overflow');
          await solution.locator('[data-bs-toggle="collapse"]').click();
          await solution.locator('.callout-collapse').waitFor({state:'hidden'});
          await page.waitForTimeout(350);
        }
        const table=page.locator('.chapter-04-wide').first();
        assert(await table.evaluate(e=>e.scrollWidth>e.clientWidth),'Wide chapter 4 table scrolls within its region');
        await table.focus();await page.keyboard.press('End');
        await table.evaluate(e=>e.scrollLeft=e.scrollWidth);
        await table.screenshot({path:'tmp/verification/ch04-table-right-mobile.png'});
        const figure=page.locator('.chapter-04-figure').last();
        assert(await figure.evaluate(e=>e.scrollWidth>e.clientWidth),'Detailed plots stay legible with local scrolling');
        await figure.evaluate(e=>e.scrollLeft=e.scrollWidth);
        await figure.screenshot({path:'tmp/verification/ch04-figure-right-mobile.png'});
      }
      if (file === 'quarto/kapitola_01.html') {
        const regions01 = page.locator('.teaching-figure');
        assert.equal(await regions01.count(), 11, 'Nine diagrams and two scatterplots have accessible scroll regions');
        for (let i=0; i<await regions01.count(); i++) {
          const region=regions01.nth(i);
          assert(await region.evaluate(e=>e.scrollWidth>e.clientWidth), 'Chapter 1 diagram scrolls locally');
          await region.focus();
          await page.keyboard.press('ArrowRight');
          await page.waitForFunction(i=>document.querySelectorAll('.teaching-figure')[i].scrollLeft>0,i);
          await region.screenshot({path:`tmp/verification/ch01-figure-${i+1}-mobile.png`});
          await region.evaluate(e=>{e.scrollLeft=e.scrollWidth;e.blur();});
          await region.screenshot({path:`tmp/verification/ch01-figure-${i+1}-right-mobile.png`});
          await region.evaluate(e=>e.scrollLeft=0);
        }
        const scales01=page.getByRole('region',{name:'Úroveň měření a diskrétní nebo spojité hodnoty',exact:true});
        assert(await scales01.evaluate(e=>e.scrollWidth>e.clientWidth),'Chapter 1 comparison table retains readable columns');
        await scales01.focus();
        await page.keyboard.press('ArrowRight');
        await page.waitForFunction(()=>document.querySelector('#srovnani-urovni-hodnot').scrollLeft>0);
        await scales01.evaluate(e=>{e.scrollLeft=0;e.blur();});
        await scales01.screenshot({path:'tmp/verification/ch01-scales-mobile.png'});
        await scales01.evaluate(e=>e.scrollLeft=e.scrollWidth);
        await scales01.screenshot({path:'tmp/verification/ch01-scales-right-mobile.png'});
        assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1),'Chapter 1 diagrams do not overflow the page');
        const optional = page.locator('#chyba-mereni-podrobne');
        await optional.locator('[data-bs-toggle="collapse"]').click();
        await optional.locator('.callout-collapse').waitFor({ state: 'visible' });
        assert(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth + 1), 'Open optional explanation overflow');
        await optional.screenshot({ path: 'tmp/verification/measurement-error-mobile.png' });
        await optional.locator('[data-bs-toggle="collapse"]').click();
        await optional.locator('.callout-collapse').waitFor({ state: 'hidden' });
        for (const id of ['sec-role-promennych', 'sec-interni-externi-validita', 'sec-kodovani', 'sec-chybejici', 'sec-stejna-vlastnost', 'sec-kvaziintervalove', 'sec-uroven-a-spojitost']) {
          await page.locator(`#${id}`).screenshot({ path: `tmp/verification/${id}-mobile.png` });
        }
      }
      if (file === 'quarto/kapitola_02.html') {
        const intervalRegion = page.getByRole('region', { name: 'Srovnání mezí intervalů' });
        assert(await intervalRegion.evaluate(el => el.scrollWidth > el.clientWidth), 'Interval table scrolls within its region on mobile');
        await intervalRegion.focus();
        await page.keyboard.press('ArrowRight');
        await page.waitForFunction(() => document.querySelector('[aria-label="Srovnání mezí intervalů"]').scrollLeft > 0);
        await intervalRegion.evaluate(el => { el.scrollLeft = el.scrollWidth; });
        await intervalRegion.screenshot({ path: 'tmp/verification/ch02-interval-table-right-mobile.png' });
        await intervalRegion.evaluate(el => { el.scrollLeft = 0; el.blur(); });
        for (const id of ['sec-sumace','sec-excel-histogram','sec-hranice-intervalu','sec-kumulativni-graf','sec-polygon-cetnosti','sec-tvar-rozdeleni']) {
          await page.locator(`#${id}`).screenshot({path:`tmp/verification/ch02-${id}-mobile.png`});
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
      if(file==='quarto/kapitola_03.html') {
        for(const id of ['rozsireni-korekce-rozptylu','rozsireni-entropie','rozsireni-momenty','rozsireni-excel-03']) {
          const block=page.locator('#'+id);
          await block.locator('[data-bs-toggle="collapse"]').click();
          await block.locator('.callout-collapse').waitFor({state:'visible'});
          await page.waitForTimeout(350);
          assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1),`Optional chapter 3 mobile overflow: ${id}`);
          await block.screenshot({path:`tmp/verification/ch03-${id}-mobile.png`});
          await block.locator('[data-bs-toggle="collapse"]').click();
          await block.locator('.callout-collapse').waitFor({state:'hidden'});
        }
        for(const id of ['sec-modus','sec-median','sec-volba-stredu','sec-stred-tvar','sec-vypocet-kvantilu','sec-kvantil-kumulativni','sec-orezani-winsorizace','sec-percentilove-poradi','sec-rozptyl','sec-korekce-rozptylu','sec-boxplot','sec-zmena-skaly','sec-reportovani-apa','sec-excel-zaklad-03']) {
          await page.locator('#'+id).screenshot({path:`tmp/verification/ch03-${id}-mobile.png`});
        }
      }
      if(file==='quarto/kapitola_03.html') {
        for(const table of await page.locator('#sec-kvantil-kumulativni .table-scroll').all()) {
          await table.focus();
          assert(await table.evaluate(el=>el===document.activeElement));
          if(await table.evaluate(el=>el.scrollWidth>el.clientWidth)) {
            await page.keyboard.press('ArrowRight');
            await page.waitForTimeout(300);
            assert(await table.evaluate(el=>el.scrollLeft>0),'Cumulative table scrolls with keyboard');
          }
        }
        const region=page.locator('.table-scroll').filter({has:page.locator('#tbl-percentilove-poradi')});
        assert.equal(await region.locator('tbody tr').count(),4);
        await region.focus();
        await page.keyboard.press('ArrowRight');
        await page.waitForTimeout(250);
        assert(await region.evaluate(el=>el.scrollLeft>0),'Rank table scrolls with keyboard');
        await region.evaluate(el=>el.scrollLeft=el.scrollWidth);
        await region.screenshot({path:'tmp/verification/ch03-ranks-right-mobile.png'});
        assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
      }
      await page.evaluate(() => window.scrollTo(0, 0));
      // New concept diagrams must remain readable and keyboard-scrollable on phones.
      const conceptFigures = {
        'quarto/kapitola_02.html': ['fig-zaklad-procent','fig-princip-kumulace','fig-meze-intervalu','fig-sirka-intervalu'],
        'quarto/kapitola_03.html': ['fig-vazeny-prumer','fig-percentil-a-poradi','fig-orezani-winsorizace'],
        'quarto/kapitola_04.html': ['fig-z-jako-jednotka','fig-distribucni-04','fig-mezi-04','fig-oblasti-04','fig-normalizace-04','fig-histogram-krivka-04','fig-skaly-04','fig-pasma-skoru','fig-qq-konstrukce'],
        'quarto/kapitola_05.html': ['fig-relativni-cetnost','fig-karticky','fig-prunik-sjednoceni','fig-podmineni','fig-nezavislost','fig-strom','fig-dve-prevalence','fig-rozdeleni-model-data','fig-kombinace','fig-binomicke-tvar','fig-binom-oblasti','fig-aproximace'],
        'quarto/kapitola_06.html': ['fig-tri-vrstvy','fig-podil-rozdeleni','fig-devet-vyberu','fig-tri-urovne','fig-prumery-simulace','fig-smerodatna-chyba','fig-trychtyr','fig-zvc-clv','fig-clv-qq','fig-jine-statistiky','fig-plocha-prumeru','fig-extremnejsi','fig-p-hodnota','fig-sila','fig-rozdeleni-p','fig-stejny-rozdil','fig-dva-testy'],
        'quarto/kapitola_07.html': ['fig-opakovane-intervaly','fig-sirka-intervalu','fig-t-rozdeleni','fig-p-funkce','fig-pasmo-pouziti','fig-hypotezy-ekvivalence','fig-ctyri-kombinace','fig-qq-uzkost-07'],
        'quarto/kapitola_08.html': ['fig-dve-usporadani','fig-parova-data','fig-korelace-rozdily','fig-pomer-skupin','fig-dve-skupiny','fig-welch-stupne','fig-intervaly-vedle-sebe','fig-zmeny-skupin','fig-ekvivalence-skupin','fig-qq-rozdily-08']
      };
      for (const id of conceptFigures[file] || []) {
        const fig = page.locator('#'+id);
        const hiddenSolution=id==='fig-qq-uzkost-07'||id==='fig-rozdeleni-p'||id==='fig-qq-rozdily-08'||id==='fig-korelace-rozdily'||id==='fig-welch-stupne';
        const toggle=hiddenSolution ? fig.locator('xpath=ancestor::div[contains(@class,"callout") and contains(@class,"callout-style-default")][1]').locator('[data-bs-toggle="collapse"]') : null;
        if(hiddenSolution){await toggle.click();await fig.waitFor({state:'visible'});}
        const region = fig.locator('xpath=ancestor::div[contains(@class,"teaching-figure") or contains(@class,"chapter-04-figure")][1]');
        assert.equal(await region.getAttribute('tabindex'),'0',`Keyboard region: ${id}`);
        assert((await region.getAttribute('aria-label')).length>10);
        assert(await region.evaluate(e=>e.scrollWidth>e.clientWidth),`Local mobile scrolling: ${id}`);
        assert(await fig.locator('img').evaluate(e=>e.getBoundingClientRect().width>=650),`Legible mobile width: ${id}`);
        assert(await page.locator(`main a[href="#${id}"]`).count()>0,`Figure discussed in prose: ${id}`);
        await region.evaluate(e=>e.scrollLeft=0);
        await region.screenshot({path:`tmp/verification/${id}-mobile-left.png`});
        await region.focus();await page.keyboard.press('ArrowRight');await page.waitForTimeout(200);
        assert(await region.evaluate(e=>e.scrollLeft>0),`Keyboard scrolling: ${id}`);
        await region.evaluate(e=>e.scrollLeft=e.scrollWidth);
        await region.screenshot({path:`tmp/verification/${id}-mobile-right.png`});
        await region.evaluate(e=>e.scrollLeft=0);
        assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1),`No page overflow: ${id}`);
        if(hiddenSolution){await toggle.click();await fig.waitFor({state:'hidden'});}
      }
      await page.screenshot({ path: `tmp/verification/${path.basename(file, '.html')}-mobile.png` });
      await page.setViewportSize({ width: 1360, height: 1000 });
    }
    for (const [file, doc] of Object.entries(documents)) {
      // APA disambiguation must not assign different suffixes in chapter popovers and the common bibliography.
      for(const [id,text] of Object.entries(referenceRecords[file])) assert.equal(text,referenceRecords['quarto/literatura.html'][id],`Inconsistent bibliography record or year suffix: ${file} ${id}`);
      for (const href of doc.links) {
        if (!href || /^(https?:|mailto:|tel:|javascript:)/.test(href)) continue;
        const url = new URL(href, base + file);
        assert(url.pathname.startsWith(prefix), `Link escapes site prefix: ${href}`);
        const target = decodeURIComponent(url.pathname.slice(prefix.length)) || 'index.html';
        assert(fs.existsSync(path.join(root, target)), `Missing target ${file}: ${href}`);
        if (url.hash && documents[target]) assert(documents[target].ids.includes(decodeURIComponent(url.hash.slice(1))), `Missing anchor ${file}: ${href}`);
      }
    }
    await page.goto(base+'quarto/kapitola_02.html',{waitUntil:'networkidle'});
    const sidebar=page.locator('#quarto-sidebar');
    const groups=sidebar.locator('.sidebar-item-section');
    assert.equal(await groups.count(),4,'Four sidebar groups');
    assert.match(await groups.nth(0).innerText(),/Výkladové kapitoly/);
    assert.match(await groups.nth(1).innerText(),/Interaktivní vizualizace/);
    assert.match(await groups.nth(2).innerText(),/Statistické aplikace/);
    assert.match(await groups.nth(3).innerText(),/Literatura a přehledy/);
    assert.equal(await groups.nth(0).locator('a.sidebar-item-text[href]').count(),10);
    assert.deepEqual((await groups.nth(1).locator('a.sidebar-item-text[href]').allTextContents()).map(s=>s.trim()),['Co s rozdělením udělá posun a změna jednotek','Plochy pod normální křivkou','Co znamená pozitivní výsledek testu','Pravděpodobnost počtu úspěchů','Výběrové rozdělení průměru','Na čem závisí statistická síla','Jak se t-rozdělení liší od normovaného normálního','Jak často interval spolehlivosti zachytí populační průměr','Jak spolu souvisí interval spolehlivosti a p-hodnota','Kdy párování zpřesní odhad průměrného rozdílu','Co znamená rozdíl o d směrodatných odchylek','Co prozradí dva intervaly vedle sebe o rozdílu průměrů','Proč odhadujeme podíl Wilsonovým intervalem','Jak daleko je tabulka četností od nezávislosti','Co říkají rozdíl podílů, poměr rizik a poměr šancí o téže tabulce','Jak tvar mraku bodů souvisí s korelačním koeficientem']);
    assert.deepEqual((await groups.nth(2).locator('a.sidebar-item-text[href]').allTextContents()).map(s=>s.trim()),['Test jednoho podílu','Test dvou podílů','Test jednoho průměru']);
    assert.equal(await groups.nth(3).locator('a.sidebar-item-text[href]').count(),4);
    assert.equal(await sidebar.locator('.sidebar-menu-container > ul > li').first().innerText(),'O učebnici');
    assert.deepEqual((await groups.nth(3).locator('a.sidebar-item-text[href]').allTextContents()).map(s=>s.trim()),['Literatura','Slovníček pojmů','Matematické a statistické značení a vzorce','Užitečné funkce Excelu']);
    // The part with visualizations starts collapsed outside its own pages (assets/sidebar-collapse.js) and opens from the keyboard.
    const vizToggle=groups.nth(1).locator('.sidebar-item-text[data-bs-toggle="collapse"]').first();
    const vizList=groups.nth(1).locator('ul.sidebar-section');
    assert.equal(await vizToggle.getAttribute('aria-expanded'),'false','Visualizations start collapsed in the sidebar');
    assert.equal(await vizList.isVisible(),false,'Collapsed visualizations are hidden');
    // The part with statistical apps also starts collapsed outside its own pages.
    assert.equal(await groups.nth(2).locator('.sidebar-item-text[data-bs-toggle="collapse"]').first().getAttribute('aria-expanded'),'false','Statistical apps start collapsed in the sidebar');
    assert.equal(await groups.nth(2).locator('ul.sidebar-section').isVisible(),false,'Collapsed statistical apps are hidden');
    for (const i of [0,3]) assert.equal(await groups.nth(i).locator('ul.sidebar-section').isVisible(),true,'Other sidebar groups stay open');
    await vizToggle.focus();await page.keyboard.press('Enter');await vizList.waitFor({state:'visible'});
    await page.waitForTimeout(350);
    assert.equal(await vizToggle.getAttribute('aria-expanded'),'true');
    const appToggle=groups.nth(2).locator('.sidebar-item-text[data-bs-toggle="collapse"]').first();
    await appToggle.focus();await page.keyboard.press('Enter');await groups.nth(2).locator('ul.sidebar-section').waitFor({state:'visible'});
    await page.waitForTimeout(350);
    assert.equal(await appToggle.getAttribute('aria-expanded'),'true');
    for (const group of await groups.all()) {
      const toggle=group.locator('.sidebar-item-text[data-bs-toggle="collapse"]').first();
      const body=group.locator('ul.sidebar-section');
      await toggle.click();await body.waitFor({state:'hidden'});
      await toggle.focus();await page.keyboard.press('Enter');await body.waitFor({state:'visible'});
      await page.waitForTimeout(350);
      await page.keyboard.press('Space');await body.waitFor({state:'hidden'});
      await page.keyboard.press('Enter');await body.waitFor({state:'visible'});
      await page.waitForTimeout(350);
      assert.equal(await toggle.getAttribute('aria-expanded'),'true');
    }
    await sidebar.screenshot({path:'tmp/verification/book-groups-desktop.png'});
    await page.setViewportSize({width:390,height:844});
    await page.locator('header .quarto-btn-toggle').click();
    await sidebar.waitFor({state:'visible'});
    const mobileGroup=groups.nth(3);
    const mobileToggle=mobileGroup.locator('.sidebar-item-text[data-bs-toggle="collapse"]').first();
    await mobileToggle.click();await mobileGroup.locator('ul').waitFor({state:'hidden'});
    await mobileToggle.click();await mobileGroup.locator('ul').waitFor({state:'visible'});
    await page.waitForTimeout(350);
    await page.screenshot({path:'tmp/verification/book-groups-mobile.png'});
    await mobileGroup.locator('a[href$="literatura.html"]').click();
    await page.waitForURL('**/quarto/literatura.html');
    assert(await page.locator('#refs').isVisible());
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
    await page.setViewportSize({width:1360,height:1000});

    // Interactive visualization: renders without code, matches R, validates inputs, caps draws and fits a phone screen.
    await page.goto(base + 'quarto/viz_vyberove_rozdeleni_prumeru.html', { waitUntil: 'networkidle' });
    const viz = page.locator('#viz-vyberove-rozdeleni-prumeru');
    const vizPlots = viz.locator('.viz-plots svg');
    // After loading there is one mean, so the right Q–Q plot is replaced by a note.
    await vizPlots.nth(4).waitFor();
    assert.equal(await vizPlots.count(), 5, 'Four panels and the Q–Q plot of the sample');
    assert.match(await viz.innerText(), /Q–Q graf potřebuje alespoň dva průměry/);
    // Quarto keeps the OJS source in a hidden .cell-code block; neither it nor its copy button may become visible.
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const vizState = () => viz.evaluate(el => el.vizCheck.state());
    const notBusy = () => page.waitForFunction(() => !document.querySelector('#viz-vyberove-rozdeleni-prumeru').vizCheck.state().busy, null, { timeout: 120000 });
    // Population densities against R: dnorm(x, 35, 15); dgamma(x, (35/15)^2, scale = 15^2/35);
    // dlnorm(x - shift, meanlog, sdlog) for skewness 2, 4 and 8 (parameters solved in R with uniroot).
    const expectedDensity = {'souměrná': [25, 0.0212965337, 40, 0.0251588818], 'mírně': [25, 0.0278157071, 40, 0.0217839302], 'středně': [25, 0.0388045397, 40, 0.0199820265], 'výrazně': [25, 0.0637308279, 40, 0.0179242954], 'extrémně': [30, 0.0740296572, 40, 0.0160592914]};
    const densities = await viz.evaluate(el => Object.fromEntries(el.vizCheck.populations.map(p => [p.id, [25, 30, 40].map(x => [x, p.pdf(x)])])));
    assert.deepEqual(Object.keys(densities), Object.keys(expectedDensity), 'Five populations');
    for (const [id, [x1, v1, x2, v2]] of Object.entries(expectedDensity)) {
      const got = Object.fromEntries(densities[id]);
      assert(Math.abs(got[x1] - v1) < 1e-9 && Math.abs(got[x2] - v2) < 1e-9, `Population density ${id}`);
    }
    // Smoothed sample density against R: bw.nrd0(s) and mean(dnorm(30, s, bw)); qnorm(0.75).
    const smooth = await viz.evaluate(el => { const s = [21.3, 25.0, 27.8, 30.1, 33.6, 41.2, 52.9, 60.4], c = el.vizCheck, bw = c.bandwidth(s); return [bw, c.smoothDensity(s, bw)(30), c.qnorm(0.75)]; });
    assert(Math.abs(smooth[0] - 7.5440895384) < 1e-9 && Math.abs(smooth[1] - 0.0298135737) < 1e-9 && Math.abs(smooth[2] - 0.6744897502) < 1e-8, 'Smoothed density and normal quantile');
    const thin = await viz.evaluate(el => el.vizCheck.qqPoints(Array.from({length: 2000}, (_, i) => i + 1), 500));
    assert(thin.length === 500 && thin[0].y === 1 && thin[499].y === 2000, 'Thinned Q–Q plot keeps both extremes');
    const nInput = viz.locator('#viz-vrp-n'), drawsInput = viz.locator('#viz-vrp-draws'), drawButton = viz.getByRole('button', { name: 'Vylosovat', exact: true });
    let vs = await vizState();
    assert.equal(vs.pop, 'mírně'); assert.equal(vs.count, 1); assert.equal(vs.draws, 100);
    await drawButton.click();
    assert.equal((await vizState()).count, 101);
    assert.equal(await vizPlots.count(), 6, 'Four panels and two Q–Q plots');
    assert.match(await viz.locator('.viz-stats').innerText(), /Standardizované průměry nad 2 a pod −2\s+\d+,\d % a \d+,\d % \(normální model: 2,3 % a 2,3 %\)/);
    for (const [input, bad, key, kept] of [[nInput, '0', 'n', 30], [nInput, '1001', 'n', 30], [nInput, '2.5', 'n', 30], [drawsInput, '0', 'draws', 100], [drawsInput, '10001', 'draws', 100], [drawsInput, '2.5', 'draws', 100]]) {
      await input.fill(bad); await input.dispatchEvent('change');
      assert.equal(await input.getAttribute('aria-invalid'), 'true', `Rejected ${key} = ${bad}`);
      assert.equal((await vizState())[key], kept);
    }
    assert(await viz.locator('#viz-vrp-n-error').isVisible() && await viz.locator('#viz-vrp-draws-error').isVisible());
    await drawsInput.fill('10000'); await drawsInput.dispatchEvent('change');
    await drawsInput.focus(); await page.keyboard.press('ArrowUp');
    assert.equal((await vizState()).draws, 10000, 'Arrow cannot exceed 10 000');
    await drawsInput.fill('1'); await drawsInput.dispatchEvent('change');
    assert.equal((await vizState()).draws, 1);
    await nInput.fill('1000'); await nInput.dispatchEvent('change');
    vs = await vizState();
    assert.equal(vs.n, 1000); assert.equal(vs.count, 1); assert.equal(vs.sample.length, 1000);
    await nInput.focus(); await page.keyboard.press('ArrowUp');
    assert.equal((await vizState()).n, 1000, 'Arrow cannot exceed 1000');
    await page.keyboard.press('ArrowDown');
    assert.equal((await vizState()).n, 999, 'Arrow decreases n');
    // A large request is drawn in batches: controls are locked and progress is shown until it ends.
    await nInput.fill('1000'); await nInput.dispatchEvent('change');
    await drawsInput.fill('10000'); await drawsInput.dispatchEvent('change');
    await drawButton.click();
    assert((await vizState()).busy && await viz.locator('.viz-progress').isVisible() && await nInput.isDisabled(), 'Batched drawing locks the controls');
    await notBusy();
    assert.equal((await vizState()).count, 10001, 'Batched drawing completes');
    assert(!(await nInput.isDisabled()) && !(await viz.locator('.viz-progress').isVisible()), 'Controls unlocked after drawing');
    await nInput.fill('1'); await nInput.dispatchEvent('change');
    await drawsInput.fill('1'); await drawsInput.dispatchEvent('change');
    vs = await vizState(); assert.equal(vs.n, 1); assert.equal(vs.sample.length, 1); assert.equal(vs.means[0], vs.sample[0]);
    assert.match(await viz.innerText(), /Poslední výběr: 1 řidič(?!\p{L})/u);
    assert.match(await viz.innerText(), /Z jediné hodnoty hustotu neodhadujeme/);
    await drawButton.focus(); await page.keyboard.press('Enter');
    assert.equal((await vizState()).count, 2, 'Keyboard draw');
    // One checkbox adds the normal model to both histograms of means.
    for (const i of [2, 3]) assert.equal(await vizPlots.nth(i).locator('[stroke-dasharray]').count(), 0);
    await viz.locator('#viz-vrp-normal').check();
    for (const i of [2, 3]) assert(await vizPlots.nth(i).locator('[stroke-dasharray]').count() > 0, `Normal model curve in histogram ${i}`);
    assert.match(await viz.locator('.viz-panel-title').nth(3).innerText(), /po standardizaci/);
    for (const id of ['souměrná', 'středně', 'výrazně', 'extrémně']) {
      await viz.locator(`input[name="viz-vrp-pop"][value="${id}"]`).check();
      vs = await vizState(); assert.equal(vs.pop, id); assert.equal(vs.count, 1, `Population ${id} restarts`);
      assert.match(await viz.locator('.viz-panel-title').first().innerText(), new RegExp(id));
    }
    // The cap of 100 000 repetitions: the last request is cut, the button is disabled and a message appears.
    await drawsInput.fill('10000'); await drawsInput.dispatchEvent('change');
    for (let i = 0; i < 11; i++) { await viz.evaluate(el => el.querySelector('[data-draw]').click()); await notBusy(); }
    assert.equal((await vizState()).count, 100000, 'Cap of 100 000 repetitions');
    assert(await drawButton.isDisabled() && await viz.locator('.viz-limit').isVisible(), 'Cap message');
    await viz.getByRole('button', { name: 'Začít znovu' }).click();
    assert.equal((await vizState()).count, 1);
    assert(!(await drawButton.isDisabled()) && !(await viz.locator('.viz-limit').isVisible()), 'Restart lifts the cap');
    await nInput.fill('30'); await nInput.dispatchEvent('change');
    await drawButton.click(); await notBusy();
    assert.equal(await vizPlots.count(), 6, 'Smoothed density, both histograms and both Q–Q plots for n ≥ 2');
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await vizPlots.nth(4).waitFor();
    await drawButton.click();
    await vizPlots.nth(5).waitFor();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Visualization fits a phone');
    await viz.screenshot({path:'tmp/verification/viz-vyberove-rozdeleni-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});
    await page.goto(base + 'quarto/kapitola_06.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('.callout-tip a[href$="viz_vyberove_rozdeleni_prumeru.html"]').count(), 1, 'Chapter 6 links to the visualization');

    // Areas under the normal curve: functions against R, all eight tasks with Excel formulas, input checks and a phone screen.
    await page.goto(base + 'quarto/viz_normalni_rozdeleni.html', { waitUntil: 'networkidle' });
    const nr = page.locator('#viz-normalni-rozdeleni');
    const nrPlots = nr.locator('.viz-plots svg');
    await nrPlots.nth(3).waitFor();
    assert.equal(await nrPlots.count(), 4, 'Density and distribution function in both parts');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const nrState = () => nr.evaluate(el => el.vizCheck.state());
    const near = (a, b, tol, msg) => assert(Math.abs(a - b) <= tol, `${msg}: ${a} vs ${b}`);
    // R: pnorm(c(-6, -1.96, 0, 1, 2.5, 7.5)); qnorm(c(1e-10, 0.001, 0.025, 0.5, 0.9, 0.995)).
    const [nrP, nrQ] = await nr.evaluate(el => [[-6, -1.96, 0, 1, 2.5, 7.5].map(el.vizCheck.pnorm), [1e-10, 0.001, 0.025, 0.5, 0.9, 0.995].map(el.vizCheck.qnorm)]);
    [9.86587645038e-10, 0.0249978951482, 0.5, 0.841344746069, 0.993790334674, 0.999999999999968].forEach((v, i) => near(nrP[i], v, Math.max(1e-12, 1e-9 * v), 'pnorm'));
    [-6.3613409024, -3.09023230617, -1.95996398454, 0, 1.28155156554, 2.57582930355].forEach((v, i) => near(nrQ[i], v, 1e-9, 'qnorm'));
    let ns = await nrState();
    assert.equal(ns.mu, 0); assert.equal(ns.sigma, 1);
    near(ns.forward.value, 0.841344746069, 1e-11, 'Default share to the left of 1');
    near(ns.inverse.bounds[1], 1.95996398454, 1e-9, 'Default middle 95 %');
    const nrInput = id => nr.locator(`#viz-nr-${id}`);
    const nrMode = async (part, value) => { await nr.locator(`input[name="viz-nr-${part}-mode"][value="${value}"]`).check(); return nrState(); };
    await nrInput('mu').fill('50'); await nrInput('sigma').fill('10'); await nrInput('x').fill('60');
    // R: pnorm(60, 50, 10), 1 - pnorm(60, 50, 10), pnorm(70, 50, 10) - pnorm(60, 50, 10), 1 - (pnorm(60, 50, 10) - pnorm(40, 50, 10)).
    ns = await nrMode('a', 'left');
    near(ns.forward.value, 0.841344746069, 1e-11, 'Left of 60'); assert.equal(ns.forward.formula, '=NORM.DIST(60;50;10;PRAVDA)');
    ns = await nrMode('a', 'right');
    near(ns.forward.value, 0.158655253931, 1e-11, 'Right of 60'); assert.equal(ns.forward.formula, '=1-NORM.DIST(60;50;10;PRAVDA)');
    assert.match(await nr.locator('[data-stats="a"]').innerText(), /0,159 \(15,9\s%\)/);
    ns = await nrMode('a', 'between');
    assert(await nrInput('lower').isVisible() && !(await nrInput('x').isVisible()), 'Two bounds replace one');
    await nrInput('lower').fill('60'); await nrInput('upper').fill('70');
    ns = await nrState();
    near(ns.forward.value, 0.135905121983, 1e-11, 'Between 60 and 70'); assert.equal(ns.forward.formula, '=NORM.DIST(70;50;10;PRAVDA)-NORM.DIST(60;50;10;PRAVDA)');
    ns = await nrMode('a', 'outside');
    await nrInput('upper').fill('60'); await nrInput('lower').fill('40');
    ns = await nrState();
    near(ns.forward.value, 0.317310507863, 1e-11, 'Outside 40 to 60'); assert.equal(ns.forward.formula, '=1-(NORM.DIST(60;50;10;PRAVDA)-NORM.DIST(40;50;10;PRAVDA))');
    assert.match(await nr.locator('[data-stats="a"]').innerText(), /0,317 \(31,7\s%\)/);
    // R: qnorm(0.9, 50, 10), qnorm(0.95, 50, 10), qnorm(c(0.025, 0.975), 50, 10).
    ns = await nrMode('b', 'lower');
    near(ns.inverse.bounds[0], 62.8155156554, 1e-8, 'Lower 90 %'); assert.deepEqual(ns.inverse.formulas, ['=NORM.INV(0,9;50;10)']);
    ns = await nrMode('b', 'upper');
    near(ns.inverse.bounds[0], 66.4485362695, 1e-8, 'Upper 5 %'); assert.deepEqual(ns.inverse.formulas, ['=NORM.INV(1-0,05;50;10)']);
    ns = await nrMode('b', 'middle');
    near(ns.inverse.bounds[0], 30.4003601546, 1e-8, 'Middle 95 %, lower'); near(ns.inverse.bounds[1], 69.5996398454, 1e-8, 'Middle 95 %, upper');
    assert.deepEqual(ns.inverse.formulas, ['=NORM.INV((1-0,95)/2;50;10)', '=NORM.INV(1-(1-0,95)/2;50;10)']);
    ns = await nrMode('b', 'tails');
    near(ns.inverse.bounds[0], 30.4003601546, 1e-8, 'Both tails 5 %, lower'); near(ns.inverse.bounds[1], 69.5996398454, 1e-8, 'Both tails 5 %, upper');
    assert.deepEqual(ns.inverse.formulas, ['=NORM.INV(0,05/2;50;10)', '=NORM.INV(1-0,05/2;50;10)']);
    assert.match(await nr.locator('[data-stats="b"]').innerText(), /69,60/);
    // Invalid input is rejected with a visible message and the last valid value stays in use.
    for (const [id, bad, check] of [['sigma', '0', s => s.sigma === 10], ['sigma', '-1', s => s.sigma === 10], ['sigma', 'abc', s => s.sigma === 10], ['share', '0', s => s.inverse.share === 0.05], ['share', '1', s => s.inverse.share === 0.05], ['share', '1,5', s => s.inverse.share === 0.05]]) {
      await nrInput(id).fill(bad);
      assert.equal(await nrInput(id).getAttribute('aria-invalid'), 'true', `Rejected ${id} = ${bad}`);
      assert(await nr.locator(`#viz-nr-${id}-error`).isVisible(), `Message for ${id} = ${bad}`);
      assert(check(await nrState()), `Kept ${id} after ${bad}`);
    }
    await nrInput('sigma').fill('10'); await nrInput('share').fill('0,05');
    await nrInput('lower').fill('80');
    assert(await nr.locator('#viz-nr-order-error').isVisible(), 'Lower bound above upper bound');
    assert.deepEqual((await nrState()).forward.bounds, [40, 60]);
    await nrInput('lower').fill('40');
    assert(!(await nr.locator('#viz-nr-order-error').isVisible()));
    // Decimal comma, typographic minus and keyboard choice of the task; R: pnorm(-1.5, 0.5, 2.5).
    await nrInput('mu').fill('0,5'); await nrInput('sigma').fill('2.5');
    await nr.locator('input[name="viz-nr-a-mode"][value="left"]').focus(); await page.keyboard.press('ArrowRight');
    assert.equal((await nrState()).forward.mode, 'right', 'Keyboard choice of the task');
    await page.keyboard.press('ArrowLeft');
    await nrInput('x').fill('−1,5');
    ns = await nrState();
    assert.equal(ns.forward.mode, 'left'); near(ns.forward.value, 0.211855398583, 1e-11, 'Decimal model');
    assert.equal(ns.forward.formula, '=NORM.DIST(-1,5;0,5;2,5;PRAVDA)');
    assert.match(await nr.locator('[data-model]').innerText(), /N\(0,5; 2,5\)/);
    await nrInput('x').fill('1000');
    assert.match(await nr.locator('[data-plots="a"]').innerText(), /dále než 8 směrodatných odchylek/);
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await nrPlots.nth(3).waitFor();
    await nr.locator('input[name="viz-nr-a-mode"][value="outside"]').check();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Normal-curve visualization fits a phone');
    await nr.screenshot({path:'tmp/verification/viz-normalni-rozdeleni-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});
    await page.goto(base + 'quarto/kapitola_04.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('.callout-tip a[href$="viz_normalni_rozdeleni.html"]').count(), 1, 'Chapter 4 links to the visualization');

    // Binomial distribution: probabilities against R, all check-box combinations, range, both approximations, Excel formulas, input checks and a phone screen.
    await page.goto(base + 'quarto/viz_binomicke_rozdeleni.html', { waitUntil: 'networkidle' });
    const bi = page.locator('#viz-binomicke-rozdeleni');
    const biCharts = bi.locator('.viz-plots svg[aria-label]');
    await biCharts.nth(1).waitFor();
    assert.equal(await biCharts.count(), 2, 'Probabilities and cumulative probability');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const biState = () => bi.evaluate(el => el.vizCheck.state());
    const biInput = id => bi.locator(`#viz-bin-${id}`);
    const biStats = () => bi.locator('[data-stats="q"]').innerText();
    const biBoxes = async (lt, eq, gt) => { for (const [id, v] of [['lt', lt], ['eq', eq], ['gt', gt]]) await biInput(id).setChecked(v); return biState(); };
    const biDashed = () => biCharts.nth(0).locator('[stroke-dasharray="5,4"]').count();
    // R: dbinom(c(2, 5, 10, 120, 0, 500, 30, 1000), c(5, 20, 20, 200, 1000, 1000, 1000, 1000), c(.25, .25, .25, .6, .01, .5, .01, .999)) and pbinom likewise.
    const [biD, biP] = await bi.evaluate(el => [[[2, 5, .25], [5, 20, .25], [10, 20, .25], [120, 200, .6], [0, 1000, .01], [500, 1000, .5], [30, 1000, .01], [1000, 1000, .999]].map(c => el.vizCheck.dbinom(...c)),
      [[5, 20, .25], [9, 20, .25], [10, 20, .25], [134, 200, .6], [7, 20, .5], [12, 20, .5], [20, 1000, .01]].map(c => el.vizCheck.pbinom(...c))]);
    [0.263671875, 0.202331151856924, 0.00992227527967771, 0.0575064320084839, 4.31712474106582e-05, 0.0252250181783608, 1.41799599065819e-07, 0.367695424770967].forEach((v, i) => near(biD[i], v, 1e-10 * v, `dbinom ${i}`));
    [0.617172654387105, 0.986135583056239, 0.996057858335917, 0.982692658948652, 0.131587982177734, 0.868412017822266, 0.998503518452291].forEach((v, i) => near(biP[i], v, 1e-11, `pbinom ${i}`));
    let bs = await biState();
    assert.deepEqual([bs.n, bs.pi, bs.mode, bs.k, bs.key], [20, 0.25, 'single', 5, '=']);
    near(bs.value, 0.202331151856924, 1e-12, 'Default P(X = 5)'); assert.equal(bs.formula, '=BINOM.DIST(5;20;0,25;NEPRAVDA)');
    assert.match(await biStats(), /P\(X = 5\) = 0,202 \(20,2\s%\)/);
    assert.match(await bi.locator('[data-stats="model"]').innerText(), /= √\(20 · 0,25 · 0,75\) = 1,936[\s\S]*= 0,0968[\s\S]*není splněna/);
    // All eight combinations of the check boxes for k = 5; R: pbinom(5 or 4, 20, .25), 1 - dbinom(5, 20, .25).
    for (const [boxes, key, value, formula] of [
      [[false, true, false], '=', 0.202331151856924, '=BINOM.DIST(5;20;0,25;NEPRAVDA)'],
      [[true, true, false], '<=', 0.617172654387105, '=BINOM.DIST(5;20;0,25;PRAVDA)'],
      [[true, false, false], '<', 0.41484150253018, '=BINOM.DIST(5-1;20;0,25;PRAVDA)'],
      [[false, true, true], '=>', 0.58515849746982, '=1-BINOM.DIST(5-1;20;0,25;PRAVDA)'],
      [[false, false, true], '>', 0.382827345612895, '=1-BINOM.DIST(5;20;0,25;PRAVDA)'],
      [[true, false, true], '<>', 0.797668848143076, '=1-BINOM.DIST(5;20;0,25;NEPRAVDA)'],
      [[true, true, true], '<=>', 1, null],
      [[false, false, false], '', 0, null]]) {
      bs = await biBoxes(...boxes);
      assert.equal(bs.key, key, `Combination ${boxes}`); near(bs.value, value, 1e-12, `Probability ${key}`); near(bs.value + bs.rest, 1, 1e-12, `Complement ${key}`);
      assert.equal(bs.formula, formula, `Excel formula ${key}`);
    }
    assert.match(await biStats(), /Není zaškrtnuta žádná možnost/);
    // R: 1 - pbinom(9, 20, .25), 1 - pbinom(10, 20, .25).
    await biInput('k').fill('10');
    bs = await biBoxes(false, true, true); near(bs.value, 0.0138644169437612, 1e-12, 'At least 10'); assert.equal(bs.formula, '=1-BINOM.DIST(10-1;20;0,25;PRAVDA)');
    bs = await biBoxes(false, false, true); near(bs.value, 0.00394214166408347, 1e-12, 'More than 10'); assert.equal(bs.formula, '=1-BINOM.DIST(10;20;0,25;PRAVDA)');
    await biInput('k').fill('20'); assert.equal((await biState()).value, 0); assert.match(await biStats(), /větší než 20/);
    await biInput('k').fill('0'); bs = await biBoxes(true, false, false); assert.equal(bs.value, 0); assert.match(await biStats(), /menší než 0/);
    // Normal approximation of the chapter 5 example; R: 1 - pnorm(c(135, 134.5), 120, sqrt(48)), 1 - pbinom(134, 200, .6).
    assert.equal(await biDashed(), 0, 'No approximation before the switch');
    await biInput('n').fill('200'); await biInput('pi').fill('0.6'); await biInput('k').fill('135');
    await biBoxes(false, true, true); await biInput('approx').check();
    bs = await biState();
    near(bs.value, 0.0173073410513478, 1e-12, 'At least 135'); near(bs.approx.mid, 0.0151914109882888, 1e-12, 'Boundary 135'); near(bs.approx.edge, 0.0181792765863954, 1e-12, 'Boundary 134,5');
    assert.equal(bs.approx.midFormula, '=1-NORM.DIST(135;200*0,6;ODMOCNINA(200*0,6*(1-0,6));PRAVDA)');
    assert.equal(bs.approx.edgeFormula, '=1-NORM.DIST(134,5;200*0,6;ODMOCNINA(200*0,6*(1-0,6));PRAVDA)');
    assert.match(await biStats(), /0,0152 \(přesně 0,0173; rozdíl −0,0021\)[\s\S]*0,0182 \(přesně 0,0173; rozdíl \+0,0009\)/);
    assert.match(await bi.locator('[data-stats="model"]').innerText(), /obě hodnoty jsou alespoň 10, podmínka je splněna/);
    assert(await biDashed() > 0, 'Boundaries at the bar edges drawn');
    assert.deepEqual(bs.window, [85, 155]); assert.match(await bi.locator('[data-plots]').innerText(), /Graf ukazuje počty od 85 do 155/);
    // A lower n lowers the bound; R: pnorm(5.5, 5, sqrt(3.75)) - pnorm(4.5, 5, sqrt(3.75)), pnorm(c(5, 4.5), 5, sqrt(3.75)).
    await biInput('n').fill('20');
    assert.equal((await biState()).k, 20, 'k lowered to n'); assert.match(await bi.locator('[data-clamp]').innerText(), /snížena na n = 20/);
    await biInput('pi').fill('0,25'); await biInput('k').fill('5');
    bs = await biBoxes(false, true, false);
    assert.equal(bs.approx.mid, 0, 'A single point has no area'); near(bs.approx.edge, 0.203746585262361, 1e-12, 'Bar from 4,5 to 5,5');
    assert.match(await biStats(), /Jediný bod nemá v normálním modelu žádnou plochu/);
    bs = await biBoxes(true, false, false); near(bs.approx.mid, 0.5, 1e-12, 'Less than 5 at 5'); near(bs.approx.edge, 0.39812670736882, 1e-12, 'Less than 5 at 4,5');
    bs = await biBoxes(true, false, true);
    assert.equal(bs.approx.edgeFormula, '=NORM.DIST(4,5;20*0,25;ODMOCNINA(20*0,25*(1-0,25));PRAVDA)+1-NORM.DIST(5,5;20*0,25;ODMOCNINA(20*0,25*(1-0,25));PRAVDA)');
    await biInput('approx').uncheck();
    assert.equal((await biState()).approx, null); assert.equal(await biDashed(), 0, 'Approximation removed');
    // Range from 8 to 12 including both bounds; R: pbinom(12, 20, .5) - pbinom(7, 20, .5) and the normal areas from 8 to 12 and from 7,5 to 12,5.
    await bi.locator('input[name="viz-bin-mode"][value="range"]').check();
    assert(await biInput('k1').isVisible() && !(await biInput('k').isVisible()) && !(await biInput('lt').isVisible()), 'Range fields replace the single bound');
    await biInput('pi').fill('0,5'); await biInput('k1').fill('8'); await biInput('k2').fill('12'); await biInput('approx').check();
    bs = await biState();
    assert.equal(bs.key, 'range'); near(bs.value, 0.736824035644531, 1e-12, 'Range 8 to 12'); near(bs.rest, 0.263175964355469, 1e-12, 'Outside 8 to 12');
    assert.equal(bs.formula, '=BINOM.DIST.RANGE(20;0,5;8;12)'); assert.equal(bs.restFormula, '=1-BINOM.DIST.RANGE(20;0,5;8;12)');
    near(bs.approx.mid, 0.628906630477303, 1e-12, 'Range at whole numbers'); near(bs.approx.edge, 0.736447522717027, 1e-12, 'Range at bar edges');
    assert.match(await biStats(), /P\(8 ≤ X ≤ 12\) = 0,737 \(73,7\s%\)[\s\S]*0,263 \(26,3\s%\)/);
    await biInput('k1').fill('13');
    assert(await bi.locator('#viz-bin-order-error').isVisible(), 'Lower bound above upper bound'); assert.equal((await biState()).k1, 8);
    await biInput('k1').fill('8'); assert(!(await bi.locator('#viz-bin-order-error').isVisible()));
    await biInput('pi').fill('0');
    bs = await biState(); assert.equal(bs.approx, null); assert.equal(bs.value, 0); assert.match(await biStats(), /směrodatná odchylka je 0/);
    await biInput('pi').fill('0,5'); await biInput('n').fill('10');
    assert.equal((await biState()).k2, 10, 'Upper bound lowered to n'); assert.match(await bi.locator('[data-clamp]').innerText(), /byla snížena na n = 10/);
    // Invalid input is rejected with a visible message and the last valid value stays in use.
    for (const [id, bad, check] of [['n', '0', st => st.n === 10], ['n', '1001', st => st.n === 10], ['n', '2.5', st => st.n === 10], ['pi', '1,2', st => st.pi === 0.5], ['pi', '-0,1', st => st.pi === 0.5], ['pi', 'abc', st => st.pi === 0.5], ['k2', '11', st => st.k2 === 10]]) {
      await biInput(id).fill(bad);
      assert.equal(await biInput(id).getAttribute('aria-invalid'), 'true', `Rejected ${id} = ${bad}`);
      assert(await bi.locator(`#viz-bin-${id}-error`).isVisible(), `Message for ${id} = ${bad}`);
      assert(check(await biState()), `Kept ${id} after ${bad}`);
    }
    await biInput('pi').fill('0,01'); await biInput('k2').fill('10');
    await biInput('n').fill('1000'); await biInput('n').focus(); await page.keyboard.press('ArrowUp');
    assert.equal((await biState()).n, 1000, 'Arrow cannot exceed 1000');
    await page.keyboard.press('ArrowDown'); assert.equal((await biState()).n, 999, 'Arrow decreases n');
    await biInput('n').fill('1000');
    bs = await biState(); assert.deepEqual(bs.window, [0, 26], 'Window around the mean for n = 1000');
    assert.match(await bi.locator('[data-plots]').innerText(), /Graf ukazuje počty od 0 do 26\. Všechny ostatní počty od 0 do 1\s000 mají dohromady pravděpodobnost < 0,001/);
    await bi.locator('input[name="viz-bin-mode"][value="range"]').focus(); await page.keyboard.press('ArrowLeft');
    assert.equal((await biState()).mode, 'single', 'Keyboard choice of the question');
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await biCharts.nth(1).waitFor();
    await biInput('approx').check();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Binomial visualization fits a phone');
    await bi.screenshot({path:'tmp/verification/viz-binomicke-rozdeleni-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});
    await page.goto(base + 'quarto/kapitola_05.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('.callout-tip a[href$="viz_binomicke_rozdeleni.html"]').count(), 1, 'Chapter 5 links to the binomial visualization');

    // Bayes' theorem: probabilities against R, natural frequencies, grid layouts, Excel formulas, second test, input checks and a phone screen.
    await page.goto(base + 'quarto/viz_bayesova_veta.html', { waitUntil: 'networkidle' });
    const by = page.locator('#viz-bayesova-veta');
    await by.locator('[data-grid] svg').waitFor();
    assert.equal(await by.locator('.viz-plots svg[role="img"], .viz-plots svg[aria-label]').count(), 5, 'Grid, tree, curve, chain and second grid');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error, .quarto-ojs-syntax-error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const byState = () => by.evaluate(el => el.vizCheck.state());
    const byInput = id => by.locator(`#viz-bay-${id}`);
    const byText = key => by.locator(`[data-stats="${key}"]`).innerText();
    const byLayout = async v => { await by.locator(`input[name="viz-bay-layout"][value="${v}"]`).check(); return byState(); };
    // R: pos = p*se + (1-p)*(1-sp); ppv = p*se/pos; npv = (1-p)*sp/neg; postNeg = p*(1-se)/neg (NA when the result cannot occur).
    const byCases = [[.1, .95, .9], [.01, .95, .9], [.01, .95, .99], [.01, .99, .9], [.123, .876, .789], [0, .95, 1], [1, 1, .9]];
    const byRef = [[0.185, 0.513513513513513, 0.993865030674847, 0.00613496932515338], [0.1085, 0.087557603686636, 0.999439147504206, 0.000560852495793607],
      [0.0194, 0.489690721649484, 0.999490108097083, 0.000509891902916582], [0.1089, 0.0909090909090909, 0.999887779149366, 0.000112220850634048],
      [0.292795, 0.367998087399034, 0.978433410397268, 0.0215665896027319], [0, null, 1, 0], [1, 1, null, null]];
    const byGot = await by.evaluate((el, cases) => cases.map(x => el.vizCheck.bayes(...x)), byCases);
    byRef.forEach(([pos, ppv, npv, postNeg], i) => {
      near(byGot[i].pos, pos, 1e-12, `P(positive) ${i}`);
      for (const [key, v] of [['ppv', ppv], ['npv', npv], ['postNeg', postNeg]]) v === null ? assert.equal(byGot[i][key], null, `${key} ${i} undefined`) : near(byGot[i][key], v, 1e-12, `${key} ${i}`);
    });
    // R: two successive updates with the posterior of the first test as the prior of the second.
    const byTwo = await by.evaluate(el => [[.1, .95, .9, true, .95, .9, true], [.01, .95, .9, true, .95, .9, true], [.01, .95, .9, true, .95, .9, false], [.1, .95, .9, false, .95, .9, false], [.1, .95, .9, true, .8, .97, true], [.1, .95, .9, false, .8, .97, true]]
      .map(([p, se, sp, r1, se2, sp2, r2]) => el.vizCheck.update(el.vizCheck.update(p, se, sp, r1), se2, sp2, r2)));
    [0.909319899244332, 0.476882430647292, 0.00530281886687134, 0.000342817963661296, 0.96569250317662, 0.141342756183746].forEach((v, i) => near(byTwo[i], v, 1e-12, `Second test ${i}`));
    const byCounts = await by.evaluate(el => [el.vizCheck.counts(1000, .1, .95, .9), el.vizCheck.counts(10000, .01, .95, .9), el.vizCheck.counts(1000, .123, .876, .789)]);
    assert.deepEqual(byCounts.map(c => [c.present, c.absent, c.tp, c.fn, c.fp, c.tn, c.exact]), [[100, 900, 95, 5, 90, 810, true], [100, 9900, 95, 5, 990, 8910, true], [123, 877, 108, 15, 185, 692, false]]);
    let ys = await byState();
    assert.deepEqual([ys.p, ys.se, ys.sp, ys.N, ys.layout], [0.1, 0.95, 0.9, 1000, 'state']);
    assert.deepEqual(ys.formulas, {pos: '=0,1*0,95+(1-0,1)*(1-0,9)', ppv: '=0,1*0,95/(0,1*0,95+(1-0,1)*(1-0,9))', npv: '=(1-0,1)*0,9/((1-0,1)*0,9+0,1*(1-0,95))'});
    assert.match(await byText('main'), /P\(porucha \| pozitivní\) = 0,514 \(51,4\s%\)[\s\S]*P\(bez poruchy \| negativní\) = 0,994[\s\S]*apriorní 0,100 → aposteriorní po pozitivním výsledku 0,514, po negativním výsledku 0,006/);
    assert.match(ys.caption, /senzitivita, 95\/100 = 0,950[\s\S]*specificita, 810\/900 = 0,900/);
    assert.match(await by.locator('[data-formula]').innerText(), /0,095\s*0,185\s*≈ 0,514/);
    // Grid layouts: the cell size stays, the table emphasises the counts of the layout.
    const gridWidth = () => by.locator('[data-grid] svg').evaluate(el => el.getBoundingClientRect().width);
    const fullWidth = await gridWidth();
    ys = await byLayout('result');
    assert.match(ys.caption, /prediktivní hodnota pozitivního testu, 95\/185 ≈ 0,514[\s\S]*810\/815 ≈ 0,994/);
    assert.deepEqual(await by.locator('.viz-bay-hi').allTextContents(), ['95', '810', '185', '815']);
    ys = await byLayout('pos');
    assert(await gridWidth() < fullWidth / 3, 'Only positive results: a smaller grid with the same cells');
    assert.deepEqual(await by.locator('.viz-bay-hi').allTextContents(), ['95', '90', '185']);
    await by.locator('input[name="viz-bay-layout"][value="pos"]').focus(); await page.keyboard.press('ArrowRight');
    assert.equal((await byState()).layout, 'neg', 'Keyboard choice of the layout');
    // The second example of chapter 5: prevalence 0,01 among 10 000 students; R: 95/1085.
    await by.getByRole('button', { name: /Plošné šetření/ }).click();
    ys = await byState();
    assert.deepEqual([ys.N, ys.p, ys.counts.fp, ys.counts.pos], [10000, 0.01, 990, 1085]); near(ys.ppv, 0.087557603686636, 1e-12, 'Population screening');
    await by.locator('input[name="viz-bay-range"][value="zoom"]').check();
    assert(!(await by.locator('[data-curve-note]').isVisible()), 'Prevalence 0,01 lies in the zoomed range');
    // Second test: the posterior after the first test is the prior for the second; R values above.
    near(ys.p2, 0.476882430647292, 1e-12, 'Two positive results in population screening');
    assert.deepEqual([ys.counts2.tp, ys.counts2.fn, ys.counts2.fp, ys.counts2.tn], [90, 5, 99, 891]);
    await by.getByRole('button', { name: /Poradna/ }).click();
    assert(await byInput('se2').isDisabled(), 'Second test follows the first by default');
    await byInput('same').uncheck(); await byInput('se2').fill('0,8'); await byInput('sp2').fill('0,97');
    near((await byState()).p2, 0.96569250317662, 1e-12, 'Different second test');
    await by.locator('input[name="viz-bay-r1"][value="neg"]').check();
    near((await byState()).p2, 0.141342756183746, 1e-12, 'Negative first, positive second');
    assert((await byText('second')).includes('=(1-B17)*0,8/((1-B17)*0,8+B17*(1-0,97))'), 'Excel formula of the second test');
    await by.locator('input[name="viz-bay-r1"][value="pos"]').check(); await by.locator('input[name="viz-bay-r2"][value="neg"]').check();
    assert((await byText('second')).includes('=B20*(1-0,8)/(B20*(1-0,8)+(1-B20)*0,97)'));
    await byInput('same').check();
    ys = await byState(); assert.deepEqual([ys.se2, ys.sp2], [0.95, 0.9]);
    // Rounding to whole persons and results that cannot occur.
    await byInput('prev').fill('0.123'); await byInput('se').fill('0,876'); await byInput('sp').fill('0,789');
    ys = await byState(); assert.equal(ys.p, 0.123, 'Decimal point accepted'); assert.equal(ys.counts.exact, false);
    assert.match(await by.locator('[data-grid-caption]').innerText(), /přibližně[\s\S]*zaokrouhleny na celé osoby/);
    await byInput('prev').fill('0'); await byInput('sp').fill('1');
    assert.equal((await byState()).ppv, null); assert.match(await byText('main'), /nelze určit: pozitivní výsledek při těchto vstupech nenastane/);
    assert.match(await by.locator('[data-formula]').innerText(), /protože bychom dělili nulou/);
    await byInput('prev').fill('0,3');
    assert(await by.locator('[data-curve-note]').isVisible(), 'Prevalence outside the zoomed range');
    // Invalid input is rejected with a visible message and the last valid value stays in use.
    for (const [id, bad, key, kept] of [['prev', '1,2', 'p', 0.3], ['prev', '-0,1', 'p', 0.3], ['prev', 'abc', 'p', 0.3], ['se', '2', 'se', 0.876], ['sp', '', 'sp', 1]]) {
      await byInput(id).fill(bad);
      assert.equal(await byInput(id).getAttribute('aria-invalid'), 'true', `Rejected ${id} = ${bad}`);
      assert(await by.locator(`#viz-bay-${id}-error`).isVisible(), `Message for ${id} = ${bad}`);
      assert.equal((await byState())[key], kept, `Kept ${id} after ${bad}`);
    }
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await by.locator('[data-grid2] svg').waitFor();
    assert.equal((await byState()).rows, 32, 'Taller grid on a phone');
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Bayes visualization fits a phone');
    assert(await by.locator('.viz-bay-table-wrap').evaluate(el => el.scrollWidth <= el.clientWidth + 1), 'Contingency table fits a phone');
    await by.screenshot({path:'tmp/verification/viz-bayesova-veta-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});
    await page.goto(base + 'quarto/kapitola_05.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('.callout-tip a[href$="viz_bayesova_veta.html"]').count(), 1, 'Chapter 5 links to the Bayes visualization');

    // Statistical power: two situations against R, Excel formulas, shared σ, input checks, keyboard and a phone screen.
    await page.goto(base + 'quarto/viz_statisticka_sila.html', { waitUntil: 'networkidle' });
    const ss = page.locator('#viz-statisticka-sila');
    const ssPlots = ss.locator('.viz-plots svg');
    await ssPlots.nth(2).waitFor();
    assert.equal(await ssPlots.count(), 3, 'Two main charts and the power curve');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    assert(await ss.locator('pattern#viz-ss-hatch-A').count() === 1 && await ss.locator('pattern#viz-ss-hatch-B').count() === 1, 'Hatching for α in both charts');
    const ssState = () => ss.evaluate(el => el.vizCheck.state());
    // R: se <- sigma*sqrt(2/n); k <- qnorm(1 - alpha/2 or 1 - alpha)*se; power from pnorm (scenarios of the chapter 6 power slides, chapter 6 text and edge cases).
    const powerCases = [[5,100,15,.05,'two',0.654345791737], [5,100,15,.01,'two',0.413400719093], [5,200,15,.05,'two',0.915181283302], [5,100,12,.05,'two',0.8380110046],
      [3,100,15,.05,'two',0.292988936448], [5,100,15,.05,'greater',0.76181992745], [5,100,15,.05,'less',3.14210854508e-05], [8,100,15,.05,'two',0.964950640187],
      [3,400,15,.05,'two',0.807430419433], [3,100,15,.05,'greater',0.408797219794], [3,100,7.5,.05,'two',0.807430419433], [0,100,15,.05,'two',0.05], [0,100,15,.05,'greater',0.05],
      [5,1,15,.5,'two',0.511768391359], [-5,50,10,.1,'less',0.88847319552], [-2,50,10,.1,'greater',0.0112579145126], [40,1000,15,.001,'two',1]];
    const ssPowers = await ss.evaluate((el, cases) => cases.map(c => el.vizCheck.power(...c.slice(0, 5))), powerCases);
    powerCases.forEach((c, i) => near(ssPowers[i], c[5], Math.max(1e-11, 1e-9 * c[5]), `Power ${c.slice(0, 5).join(' ')}`));
    let st = await ssState();
    assert.equal(st.sigma, 15); assert.equal(st.A.n, 100); assert.equal(st.B.n, 200);
    near(st.A.power, 0.654345791737, 1e-11, 'Default situation A'); near(st.B.power, 0.915181283302, 1e-11, 'Default situation B');
    near(st.A.crit[1], 4.157711473, 1e-9, 'Critical value'); near(st.A.se, 2.1213203436, 1e-10, 'Standard error of the difference');
    assert.deepEqual([st.A.formulas.se, st.A.formulas.crit, st.A.formulas.power], ['=15*ODMOCNINA(2/100)', '=NORM.S.INV(1-0,05/2)*15*ODMOCNINA(2/100)', '=1-NORM.DIST(4,15771;5;2,12132;PRAVDA)+NORM.DIST(-4,15771;5;2,12132;PRAVDA)']);
    for (const id of ['A', 'B']) near(st[id].formulas.powerValue, st[id].power, 5e-5, `Rounded Excel formula ${id}`);
    assert.match(await ss.locator('#viz-ss-steps').innerText(), /0,6543 \+ < 0,0001 = 0,654/);
    const ssInput = id => ss.locator(`#viz-ss-${id}`);
    // The common σ changes both situations; R: power for σ = 12 s and n = 100 or 200.
    await ssInput('sigma').fill('12');
    st = await ssState();
    near(st.A.power, 0.8380110046, 1e-9, 'σ = 12 in A'); assert.equal(st.B.sigma, 12, 'σ is shared');
    await ssInput('sigma').fill('15');
    await ssInput('B-n').fill('100'); await ssInput('B-alpha').fill('0,01');
    st = await ssState();
    near(st.B.power, 0.413400719093, 1e-11, 'α = 0,01'); near(st.B.crit[1], 5.4641591032, 1e-9, 'Critical value for α = 0,01');
    await ssInput('B-alpha').fill('0.05');
    // Keyboard choice of the direction; one-sided formulas.
    await ss.locator('input[name="viz-ss-B-side"][value="two"]').focus(); await page.keyboard.press('ArrowRight');
    st = await ssState();
    assert.equal(st.B.side, 'less', 'Keyboard choice of the direction');
    near(st.B.power, 3.14210854508e-05, 1e-12, 'Opposite direction'); assert.equal(st.B.formulas.power, '=NORM.DIST(-3,48926;5;2,12132;PRAVDA)');
    assert.equal(st.B.formulas.crit, '=-NORM.S.INV(1-0,05)*15*ODMOCNINA(2/100)');
    assert.match(await ss.locator('[data-panel="B"]').innerText(), /síla 1 − β < 0,001/);
    await page.keyboard.press('ArrowRight');
    st = await ssState();
    assert.equal(st.B.side, 'greater'); near(st.B.power, 0.76181992745, 1e-11, 'One-sided in the chosen direction');
    assert.equal(st.B.formulas.power, '=1-NORM.DIST(3,48926;5;2,12132;PRAVDA)');
    // Zero difference: the shaded area is α, not power.
    await ssInput('A-diff').fill('0');
    st = await ssState();
    near(st.A.power, 0.05, 1e-12, 'Zero difference gives α');
    assert.match(await ss.locator('[data-panel="A"]').innerText(), /nulová hypotéza tedy platí/);
    await ssInput('A-diff').fill('−5'); await ss.locator('input[name="viz-ss-A-side"][value="less"]').check();
    await ssInput('sigma').fill('10'); await ssInput('A-n').fill('50'); await ssInput('A-alpha').fill('0,1');
    near((await ssState()).A.power, 0.88847319552, 1e-10, 'Negative difference, decimal comma and typographic minus');
    // Invalid input is rejected with a visible message and the last valid value stays in use.
    for (const [id, bad, check] of [['A-n', '0', s => s.A.n === 50], ['A-n', '1001', s => s.A.n === 50], ['A-n', '2.5', s => s.A.n === 50], ['sigma', '0', s => s.sigma === 10], ['sigma', 'abc', s => s.sigma === 10], ['A-alpha', '0', s => s.A.alpha === 0.1], ['A-alpha', '0,6', s => s.A.alpha === 0.1], ['A-diff', '1001', s => s.A.d === -5]]) {
      await ssInput(id).fill(bad);
      assert.equal(await ssInput(id).getAttribute('aria-invalid'), 'true', `Rejected ${id} = ${bad}`);
      assert(await ss.locator(`#viz-ss-${id}-error`).isVisible(), `Message for ${id} = ${bad}`);
      assert(check(await ssState()), `Kept ${id} after ${bad}`);
    }
    await ssInput('A-n').fill('1000'); await ssInput('A-n').focus(); await page.keyboard.press('ArrowUp');
    assert.equal((await ssState()).A.n, 1000, 'Arrow cannot exceed 1000');
    await page.keyboard.press('ArrowDown');
    assert.equal((await ssState()).A.n, 999, 'Arrow decreases n');
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await ssPlots.nth(2).waitFor();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Power visualization fits a phone');
    await ss.screenshot({path:'tmp/verification/viz-statisticka-sila-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});
    await page.goto(base + 'quarto/kapitola_06.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('.callout-tip a[href$="viz_statisticka_sila.html"]').count(), 1, 'Chapter 6 links to the power visualization');

    // Shift and change of units: data against the shared data file, statistics against R, presets, Excel formulas, input checks and a phone screen.
    await page.goto(base + 'quarto/viz_posun_a_jednotky.html', { waitUntil: 'networkidle' });
    const pj = page.locator('#viz-posun-a-jednotky');
    await pj.locator('.viz-plots svg').waitFor();
    assert.equal(await pj.locator('.viz-plots svg').count(), 1, 'One chart with both dot plots');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const pjState = () => pj.evaluate(el => el.vizCheck.state());
    const pjNear = (a, b, msg) => assert(Math.abs(a - b) <= 1e-9 * Math.max(1, Math.abs(b)), `${msg}: ${a} vs ${b}`);
    const pjStats = (got, want, msg) => Object.entries(want).forEach(([k, v]) => v === null ? assert.equal(got[k], null, `${msg} ${k}`) : pjNear(got[k], v, `${msg} ${k}`));
    const pjRule = (st, msg) => ['m', 'med', 'q1', 'q3', 'iqr', 'range', 's', 's2', 'skew', 'kurt'].forEach(k => pjNear(st.rule[k], st.converted[k], `${msg} ${k}`));
    // The values on the page are the sleep and word data of chapters 2 and 3 (the three missing sleep values left out).
    const pjCsv = fs.readFileSync('data/kapitola_02.csv', 'utf8').trim().split(/\r?\n/).slice(1).map(l => l.split(','));
    const pjData = await pj.evaluate(el => el.vizCheck.data);
    assert.deepEqual(pjData.sleep, pjCsv.map(r => r[1]).filter(v => v !== '').map(Number), 'Sleep data');
    assert.deepEqual(pjData.words, pjCsv.map(r => Number(r[2])), 'Word data');
    assert.deepEqual(pjData.times, [4, 5, 5, 6, 10], 'Five times');
    // R: mean, median, quantile(type = 7), sd, var and the SKEW/KURT formulas.
    const pjR = {
      times: {m: 6, med: 5, q1: 5, q3: 6, iqr: 1, range: 6, s: 2.34520787991171, s2: 5.5, skew: 1.74436949745499, kurt: 3.32231404958677},
      sleep: {m: 7.063636363636363, med: 7.1, q1: 6.2, q3: 8, iqr: 1.8, range: 5, s: 1.288608304969498, s2: 1.660511363636364, skew: -0.125053652429647, kurt: -0.55379448461621},
      words: {m: 7.027777777777778, med: 7, q1: 5.75, q3: 9, iqr: 3.25, range: 12, s: 2.591040729801843, s2: 6.713492063492064, skew: -0.47057774610161, kurt: 0.481406247639946}
    };
    for (const [k, want] of Object.entries(pjR)) pjStats(await pj.evaluate((el, xs) => el.vizCheck.stats(xs), pjData[k]), want, k);
    // Default: five times from minutes to seconds.
    let pjs = await pjState();
    assert.equal(pjs.data, 'times'); assert.equal(pjs.a, 0); assert.equal(pjs.b, 60); assert.equal(pjs.axis, 'common');
    pjStats(pjs.converted, {m: 360, med: 300, q1: 300, q3: 360, iqr: 60, range: 360, s: 140.71247279470288, s2: 19800, skew: 1.74436949745499, kurt: 3.32231404958678}, 'Seconds');
    pjRule(pjs, 'Seconds by rule');
    assert.equal(pjs.transformFormula, '=60*A2'); assert.equal(pjs.formulas[0], '=PRŮMĚR(B2:B6)');
    assert.match(await pj.locator('[data-table]').innerText(), /19\s800/);
    const pjPreset = async id => { await pj.locator(`[data-preset="${id}"]`).click(); return pjState(); };
    pjs = await pjPreset('plus2');
    pjStats(pjs.converted, {m: 8, med: 7, q1: 7, q3: 8, s: 2.34520787991171, s2: 5.5}, 'Plus 2 minutes');
    assert.equal(pjs.transformFormula, '=2+A2'); assert.match(pjs.description, /posunulo o 2/);
    pjs = await pjPreset('plus2sec');
    pjStats(pjs.converted, {m: 480, med: 420, q1: 420, q3: 480, s: 140.71247279470288, s2: 19800}, 'Plus 2 minutes in seconds');
    assert.equal(pjs.transformFormula, '=120+60*A2');
    pjs = await pjPreset('hmin');
    assert.equal(pjs.data, 'sleep');
    pjStats(pjs.converted, {m: 423.818181818181813, med: 426, q1: 372, q3: 480, iqr: 108, range: 300, s: 77.316498298169904, s2: 5977.840909090909, skew: -0.125053652429647, kurt: -0.55379448461621}, 'Sleep in minutes');
    pjRule(pjs, 'Sleep by rule');
    assert.equal(pjs.transformFormula, '=KDYŽ(B2="";"";60*B2)'); assert.equal(pjs.formulas[2], '=PERCENTIL.INC(F2:F37;0,25)');
    pjs = await pjPreset('reverse');
    assert.equal(pjs.data, 'words');
    pjStats(pjs.converted, {m: 4.972222222222222, med: 5, q1: 3, q3: 6.25, iqr: 3.25, range: 12, s: 2.591040729801843, s2: 6.713492063492064, skew: 0.47057774610161, kurt: 0.481406247639946}, 'Reverse scoring');
    pjRule(pjs, 'Reverse scoring by rule');
    assert.equal(pjs.transformFormula, '=12-C2'); assert.match(pjs.description, /kříží/);
    assert.match(await pj.locator('[data-row="q1"]').innerText(), /pořadí se obrátilo/);
    // Typed values with a decimal comma and a typographic minus; R: 3 - 2.5 * words.
    await pj.locator('#viz-pj-a').fill('3'); await pj.locator('#viz-pj-b').fill('−2,5');
    pjs = await pjState();
    pjStats(pjs.converted, {m: -14.569444444444445, med: -14.5, q1: -19.5, q3: -11.375, iqr: 8.125, range: 30, s: 6.477601824504606, s2: 41.9593253968254, skew: 0.47057774610161, kurt: 0.481406247639947}, 'a = 3, b = -2.5');
    pjRule(pjs, 'a = 3, b = -2.5 by rule');
    assert.equal(pjs.transformFormula, '=3-2,5*C2'); assert.equal(pjs.unit, null);
    // Invalid input is rejected with a visible message and the last valid value stays in use.
    for (const [id, bad] of [['b', 'abc'], ['a', '2000000'], ['b', '1,2,3']]) {
      await pj.locator(`#viz-pj-${id}`).fill(bad);
      assert.equal(await pj.locator(`#viz-pj-${id}`).getAttribute('aria-invalid'), 'true', `Rejected ${id} = ${bad}`);
      assert(await pj.locator(`#viz-pj-${id}-error`).isVisible(), `Message for ${id} = ${bad}`);
      pjs = await pjState(); assert(pjs.a === 3 && pjs.b === -2.5, `Kept a and b after ${bad}`);
    }
    await pj.locator('#viz-pj-a').fill('3'); await pj.locator('#viz-pj-b').fill('-2.5');
    pjs = await pjPreset('zero');
    assert.equal(pjs.b, 0); assert.equal(pjs.converted.s, 0); assert.equal(pjs.converted.skew, null); assert.equal(pjs.rule.kurt, null);
    assert.equal(pjs.transformFormula, '=3'); assert.match(pjs.description, /sbíhají/);
    assert.match(await pj.locator('[data-excel]').innerText(), /#DIV\/0!/);
    // Nonlinear rules: R: mean(c(4, 5, 5, 6, 10)^2) and sqrt of the sleep data.
    await pj.locator('input[name="viz-pj-data"][value="times"]').check();
    await pj.locator('input[name="viz-pj-mode"][value="square"]').check();
    pjs = await pjState();
    assert(!(await pj.locator('#viz-pj-a').isVisible()), 'No a and b for a nonlinear rule');
    pjStats(pjs.converted, {m: 40.4, med: 25, q1: 25, q3: 36, s: 34.06317659878479, s2: 1160.3, skew: 2.00083728368368, kurt: 4.14922077059587}, 'Squares');
    pjNear(pjs.rule.m, 36, 'Square of the mean'); assert.equal(pjs.rule.s, null);
    assert.match(await pj.locator('[data-row="m"]').innerText(), /liší se/); assert.match(await pj.locator('[data-row="med"]').innerText(), /shoduje se/);
    assert.equal(pjs.transformFormula, '=A2^2');
    await pj.locator('input[name="viz-pj-data"][value="sleep"]').check();
    await pj.locator('input[name="viz-pj-mode"][value="sqrt"]').check();
    pjs = await pjState();
    pjStats(pjs.converted, {m: 2.6466380317969085, med: 2.6645825188948455, q1: 2.4899799195977463, q3: 2.8284271247461903, s: 0.2465471079051194, skew: -0.3204218982225787, kurt: -0.4574412001796135}, 'Square roots of sleep');
    assert.equal(pjs.transformFormula, '=KDYŽ(B2="";"";ODMOCNINA(B2))');
    // Keyboard choice of the axis and a phone screen.
    await pj.locator('input[name="viz-pj-axis"][value="common"]').focus(); await page.keyboard.press('ArrowRight');
    assert.equal((await pjState()).axis, 'own', 'Keyboard choice of the axis');
    assert.match((await pjState()).description, /změnil se jeho tvar/);
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await pj.locator('.viz-plots svg').waitFor();
    await pj.locator('[data-preset="reverse"]').click();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Shift-and-units visualization fits a phone');
    await pj.screenshot({path:'tmp/verification/viz-posun-a-jednotky-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});
    await page.goto(base + 'quarto/kapitola_03.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('.callout-tip a[href$="viz_posun_a_jednotky.html"]').count(), 1, 'Chapter 3 links to the shift-and-units visualization');

    // t and standard normal distributions: densities, distribution functions and quantiles against R, slider, bound, error switch, both tables and a phone screen.
    await page.goto(base + 'quarto/viz_t_rozdeleni.html', { waitUntil: 'networkidle' });
    const td = page.locator('#viz-t-rozdeleni');
    const tdPlots = td.locator('.viz-plots svg[aria-label]');
    await tdPlots.nth(3).waitFor();
    assert.equal(await tdPlots.count(), 4, 'Densities, Q–Q plot and two error charts');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const tdState = () => td.evaluate(el => el.vizCheck.state());
    const tdNear = (a, b, msg) => assert(Math.abs(a - b) <= 1e-9 * Math.max(1, Math.abs(b)), `${msg}: ${a} vs ${b}`);
    // R: dt(x, v), pt(x, v) and qt(p, v) for v = 1, 4, 30, 100; pnorm(x), qnorm(p).
    const tdX = [-5, -3, -1.645, -1, 0, 0.5, 2, 4.5], tdP = [0.0005, 0.001, 0.025, 0.3, 0.9, 0.975, 0.9995];
    const tdR = {
      1: {d: [0.0122426879301, 0.0318309886184, 0.0858898378138, 0.159154943092, 0.318309886184, 0.254647908947, 0.0636619772368, 0.0149792887616],
        p: [0.062832958189, 0.10241638235, 0.173864068852, 0.25, 0.5, 0.64758361765, 0.85241638235, 0.930395512727],
        q: [-636.619248769, -318.308838986, -12.7062047362, -0.726542528005, 3.07768353718, 12.7062047362, 636.619248769]},
      4: {d: [0.00264963621656, 0.0196934980908, 0.103042960001, 0.21466252584, 0.375, 0.32226186856, 0.0662912607362, 0.00414382960369],
        p: [0.00374521694064, 0.0199709840359, 0.0876575335631, 0.18695048315, 0.5, 0.678335018409, 0.941941738242, 0.994588724769],
        q: [-8.61030158138, -7.17318221978, -2.7764451052, -0.56864906305, 1.53320627406, 2.7764451052, 8.61030158138]},
      30: {d: [3.28889020529e-05, 0.00677906274609, 0.103738679311, 0.237993342323, 0.395632184894, 0.347878579697, 0.0568522750472, 0.000133371193688],
        p: [1.16483427335e-05, 0.00269498203283, 0.0552046424764, 0.162654307713, 0.5, 0.689638497557, 0.972687477519, 0.999952403203],
        q: [-3.64595863504, -3.38518486683, -2.0422724563, -0.530019003907, 1.31041502539, 2.0422724563, 3.64595863504]},
      100: {d: [5.08005823473e-06, 0.00512608970232, 0.103330927642, 0.240765896929, 0.397946186936, 0.350802833392, 0.0549086432954, 3.59358194751e-05],
        p: [1.22508670675e-06, 0.00170395767166, 0.0515548825875, 0.159862077892, 0.5, 0.690913217085, 0.975893910634, 0.999990807694],
        q: [-3.39049131116, -3.17373949374, -1.98397151852, -0.5260762706, 1.29007476135, 1.98397151852, 3.39049131116]}
    };
    for (const [v, want] of Object.entries(tdR)) {
      const got = await td.evaluate((el, a) => ({d: a.xs.map(x => el.vizCheck.dt(x, a.v)), p: a.xs.map(x => el.vizCheck.pt(x, a.v)), q: a.ps.map(p => el.vizCheck.qt(p, a.v))}), {v: +v, xs: tdX, ps: tdP});
      // Relative tolerance: the R values are printed to 12 significant digits.
      ['d', 'p', 'q'].forEach(k => want[k].forEach((w, i) => assert(Math.abs(got[k][i] - w) <= 1e-9 * Math.abs(w) + 1e-15, `t ${k} v = ${v} #${i}: ${got[k][i]} vs ${w}`)));
    }
    const tdNorm = await td.evaluate((el, xs) => xs.map(el.vizCheck.pnorm), tdX);
    [2.86651571879e-07, 0.00134989803163, 0.0499849055391, 0.158655253931, 0.5, 0.691462461274, 0.977249868052, 0.999996602327].forEach((w, i) => assert(Math.abs(tdNorm[i] - w) <= 1e-9 * w, `pnorm #${i}`));
    // Default: 4 degrees of freedom, bound −1,645, tail shares; R: pt(-1.645, 4), pnorm(-1.645).
    let ts = await tdState();
    assert.equal(ts.v, 4); assert.equal(ts.x, -1.645); assert.equal(ts.mode, 'tail');
    assert.deepEqual(await td.locator('#viz-t-v').evaluate(el => [el.min, el.max, el.step, el.value]), ['1', '100', '1', '4'], 'Slider range');
    tdNear(ts.tail.pT, 0.0876575335631, 'Tail share of t'); tdNear(ts.tail.pN, 0.0499849055391, 'Tail share of the normal');
    tdNear(ts.tail.rel, -42.97705684, 'Relative error of the tail share');
    assert.deepEqual([ts.tail.formulaT, ts.tail.formulaN], ['=T.DIST(-1,645;4;PRAVDA)', '=NORM.S.DIST(-1,645;PRAVDA)']);
    assert.match(await td.locator('[data-stats]').innerText(), /−0,03767 \/ 0,08766 · 100 % = −43,0 %/);
    assert.equal(ts.qqOutside, 6, 'Q–Q points beyond ±8 for 4 degrees of freedom');
    assert.match(await td.locator('[data-qq-note]').innerText(), /8,610/);
    // Live table: R qt(c(.9, .95, .975, .99, .995, .9995), 4) and the relative error (z − t)/t.
    [1.53320627406, 2.13184678633, 2.7764451052, 3.74694738798, 4.60409487135, 8.61030158138].forEach((w, i) => tdNear(ts.live[i].t, w, `Live table t #${i}`));
    tdNear(ts.live[2].r, -29.4074289144, 'Relative error of the 0,975 quantile');
    assert.match(await td.locator('[data-live]').innerText(), /2,776/);
    // Keyboard on the slider: arrows by one, Home and End to the limits.
    await td.locator('#viz-t-v').focus();
    await page.keyboard.press('ArrowRight'); assert.equal((await tdState()).v, 5, 'ArrowRight adds one');
    await page.keyboard.press('ArrowLeft'); await page.keyboard.press('ArrowLeft'); assert.equal((await tdState()).v, 3, 'ArrowLeft subtracts one');
    await page.keyboard.press('Home'); assert.equal((await tdState()).v, 1, 'Home sets 1');
    assert.match(await td.locator('#viz-t-v-value').innerText(), /v = 1 stupeň volnosti/);
    await page.keyboard.press('End'); ts = await tdState();
    assert.equal(ts.v, 100, 'End sets 100'); assert.equal(ts.qqOutside, 0, 'No Q–Q points beyond ±8 for 100 degrees of freedom');
    tdNear(ts.tail.pT, 0.0515548825875, 'Tail share of t, 100 degrees of freedom');
    // A value outside the fixed table is inserted and highlighted; R: qt(0.975, 7).
    await td.locator('#viz-t-v').evaluate(el => { el.value = '7'; el.dispatchEvent(new Event('input', {bubbles: true})); });
    ts = await tdState();
    const tdRow7 = ts.fixed.rows.find(r => r.v === 7);
    assert(tdRow7 && tdRow7.current && tdRow7.inserted, 'Row for 7 degrees of freedom inserted'); tdNear(tdRow7.q[2], 2.36462425159, 'Fixed table t for 7');
    assert.equal(ts.fixed.rows.length, 14); assert.equal(await td.locator('.viz-t-current').count(), 1);
    // Bound on the right and at zero; R: 1 - pt(2, 30), 1 - pnorm(2).
    await td.locator('#viz-t-v').evaluate(el => { el.value = '30'; el.dispatchEvent(new Event('input', {bubbles: true})); });
    await td.locator('#viz-t-x').fill('2');
    ts = await tdState();
    assert(ts.tail.right, 'Bound 2 uses the right tail');
    tdNear(ts.tail.pT, 0.0273125224815, 'Right tail of t'); tdNear(ts.tail.pN, 0.0227501319482, 'Right tail of the normal');
    assert.equal(ts.tail.formulaT, '=1-T.DIST(2;30;PRAVDA)');
    await td.locator('#viz-t-x').fill('0');
    ts = await tdState(); assert.equal(ts.tail.pT, 0.5); assert.equal(ts.tail.abs, 0);
    // Decimal comma, typographic minus and rejected values.
    await td.locator('#viz-t-x').fill('−3');
    ts = await tdState(); tdNear(ts.tail.rel, -49.9106852963, 'Relative error at −3 with 30 degrees of freedom');
    for (const bad of ['abc', '11', '1,2,3']) {
      await td.locator('#viz-t-x').fill(bad);
      assert.equal(await td.locator('#viz-t-x').getAttribute('aria-invalid'), 'true', `Rejected bound ${bad}`);
      assert(await td.locator('#viz-t-x-error').isVisible(), `Message for bound ${bad}`);
      assert.equal((await tdState()).x, -3, `Kept bound after ${bad}`);
    }
    // Density heights; R: dt(-3, 30), dnorm(-3).
    await td.locator('input[name="viz-t-mode"][value="density"]').check();
    ts = await tdState();
    assert.equal(ts.mode, 'density'); tdNear(ts.heights.t, 0.00677906274609, 'Height of t'); tdNear(ts.heights.n, 0.00443184841194, 'Height of the normal');
    assert.match(await td.locator('[data-stats]').innerText(), /=T\.DIST\(-3;30;NEPRAVDA\)/);
    // Full screen (assets/viz-fullscreen.js): the whole block, wider charts, controls still work, Escape closes.
    const tdFull = td.locator(':scope > .viz-fullscreen-bar > button.viz-fullscreen');
    assert.equal(await tdFull.count(), 1, 'One full-screen button');
    assert.equal(await tdFull.getAttribute('aria-pressed'), 'false');
    const tdWidth = () => tdPlots.first().evaluate(el => el.getBoundingClientRect().width);
    const tdInline = await tdWidth();
    assert(tdInline <= 781, `Inline chart width ${tdInline}`);
    await tdFull.click();
    await page.waitForFunction(() => document.fullscreenElement?.id === 'viz-t-rozdeleni');
    await page.waitForFunction(w => document.querySelector('#viz-t-rozdeleni .viz-plots svg[aria-label]').getBoundingClientRect().width > w + 100, tdInline);
    assert.equal(await tdFull.getAttribute('aria-pressed'), 'true');
    assert.match(await tdFull.innerText(), /Zavřít celou obrazovku/);
    assert.equal(await td.evaluate(el => getComputedStyle(el).backgroundColor), 'rgb(255, 255, 255)', 'Opaque full-screen background');
    await td.locator('#viz-t-v').evaluate(el => { el.value = '12'; el.dispatchEvent(new Event('input', {bubbles: true})); });
    assert.equal((await tdState()).v, 12, 'Slider works in full screen');
    assert((await tdWidth()) > tdInline + 100, 'Redraw in full screen keeps the wide charts');
    await page.screenshot({path:'tmp/verification/viz-t-rozdeleni-fullscreen.png'});
    await page.keyboard.press('Escape');
    if (await page.evaluate(() => !!document.fullscreenElement)) await page.evaluate(() => document.exitFullscreen());
    await page.waitForFunction(() => !document.fullscreenElement);
    // fullscreenElement clears before the fullscreenchange event; wait for the button to follow.
    await page.waitForFunction(() => document.querySelector('#viz-t-rozdeleni .viz-fullscreen').getAttribute('aria-pressed') === 'false');
    await page.waitForFunction(w => document.querySelector('#viz-t-rozdeleni .viz-plots svg[aria-label]').getBoundingClientRect().width <= w + 1, tdInline);
    assert(!(await td.evaluate(el => el.classList.contains('viz-is-fullscreen'))), 'Full-screen class removed');
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await tdPlots.nth(3).waitFor();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 't-distribution visualization fits a phone');
    await td.screenshot({path:'tmp/verification/viz-t-rozdeleni-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});
    await page.goto(base + 'quarto/kapitola_07.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('.callout-tip a[href$="viz_t_rozdeleni.html"]').count(), 1, 'Chapter 7 links to the t-distribution visualization');
    assert.equal(await page.locator('.callout-tip a[href$="viz_interval_a_test.html"]').count(), 1, 'Chapter 7 links to the interval and p-value visualization');
    assert.equal(await page.locator('.callout-tip a[href$="viz_pokryti_intervalu.html"]').count(), 1, 'Chapter 7 links to the coverage visualization');

    // Confidence interval and p-value: one-sample t-test against R, both views, sliders, presets, directions, invalid input and a phone screen.
    await page.goto(base + 'quarto/viz_interval_a_test.html', { waitUntil: 'networkidle' });
    const ia = page.locator('#viz-interval-a-test');
    const iaPlots = ia.locator('.viz-plots svg[aria-label]');
    await iaPlots.nth(1).waitFor();
    assert.equal(await iaPlots.count(), 2, 'Interval view and test view');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const iaState = () => ia.evaluate(el => el.vizCheck.state());
    const iaNear = (a, b, msg) => assert(a === b || Math.abs(a - b) <= 1e-9 * Math.max(1, Math.abs(b)), `${msg}: ${a} vs ${b}`);
    // R: p-value, quantile, margin of error and interval (formulas; p and interval also equal t.test on data with this m and s).
    const iaR = [
      {mu0: 50, m: 46, s: 11, n: 25, alpha: 0.05, side: 'two', p: 0.0815402664466, q: 2.06389856163, me: 4.54057683558, ci: [41.4594231644, 50.5405768356]},
      {mu0: 50, m: 46, s: 11, n: 25, alpha: 0.05, side: 'less', p: 0.0407701332233, q: 1.71088207991, me: 3.7639405758, ci: [-Infinity, 49.7639405758]},
      {mu0: 50, m: 46, s: 11, n: 25, alpha: 0.05, side: 'greater', p: 0.959229866777, q: 1.71088207991, me: 3.7639405758, ci: [42.2360594242, Infinity]},
      {mu0: 100, m: 104.125, s: 12.584, n: 56, alpha: 0.05, side: 'two', p: 0.0173653341173, q: 2.00404478329, me: 3.37001720709, ci: [100.754982793, 107.495017207]},
      {mu0: -3, m: 2.7, s: 4.2, n: 7, alpha: 0.01, side: 'greater', p: 0.00574736306005, q: 3.14266840329, me: 4.98883142895, ci: [-2.28883142895, Infinity]},
      {mu0: 500, m: 498, s: 30, n: 200, alpha: 0.1, side: 'two', p: 0.346921762632, q: 1.65254674617, me: 3.50558103133, ci: [494.494418969, 501.505581031]},
      {mu0: 12, m: 12.4, s: 1, n: 2, alpha: 0.5, side: 'less', p: 0.663867824981, q: 0, me: 0, ci: [-Infinity, 12.4]}
    ];
    const iaGot = await ia.evaluate((el, cases) => cases.map(c => { const r = el.vizCheck.compute(c); return {p: r.p, q: r.q, me: r.me, ci: r.ci.map(String), same: [r.byP, r.byT, r.byCI, r.byAcc].every(d => d === r.byP)}; }), iaR);
    iaR.forEach((w, i) => {
      ['p', 'q', 'me'].forEach(k => iaNear(iaGot[i][k], w[k], `Interval case ${i} ${k}`));
      w.ci.forEach((b, j) => Number.isFinite(b) ? iaNear(Number(iaGot[i].ci[j]), b, `Interval case ${i} bound ${j}`) : assert.equal(iaGot[i].ci[j], String(b), `Interval case ${i} infinite bound`));
      assert(iaGot[i].same, `Four routes agree in case ${i}`);
    });
    // Exactly on the bound of the interval the p-value equals α and all four routes reject.
    const iaEdge = await ia.evaluate(el => { const C = el.vizCheck.compute; const b = C({mu0: 50, m: 46, s: 11, n: 25, alpha: 0.05, side: 'two'}).ci[1]; const r = C({mu0: b, m: 46, s: 11, n: 25, alpha: 0.05, side: 'two'}); return [r.p, r.byP, r.byT, r.byCI, r.byAcc]; });
    iaNear(iaEdge[0], 0.05, 'p-value on the bound'); assert.deepEqual(iaEdge.slice(1), [true, true, true, true], 'Rejection on the bound');
    // Default: the two-sided test of attention from chapter 7.
    let is = await iaState();
    assert.deepEqual([is.mu0, is.m, is.s, is.n, is.alpha, is.side], [50, 46, 11, 25, 0.05, 'two']);
    iaNear(is.p, 0.0815402664466, 'Default p-value'); assert.deepEqual(is.dom, [35, 60], 'Default score range');
    iaNear(is.acc[0], 45.4594231644, 'Region of non-rejection'); assert.deepEqual(is.decisions, [false, false, false, false]);
    assert.deepEqual(await ia.locator('#viz-ia-mu0-range').evaluate(el => [el.min, el.max, el.step, el.value]), ['35', '60', '0.1', '50'], 'Slider for μ0');
    let iaText = await ia.locator('[data-stats]').innerText();
    assert(iaText.includes('=T.DIST.2T(ABS((46-50)/(11/ODMOCNINA(25)));24)') && iaText.includes('(41,46; 50,54)') && iaText.includes('=T.INV.2T(0,05;24)'), 'Two-sided formulas and interval');
    assert.match(await ia.locator('[data-ways]').innerText(), /leží uvnitř 95% oboustranného intervalu \(41,46; 50,54\)/);
    // Keyboard on the slider moves μ0 by one step and updates the field.
    await ia.locator('#viz-ia-mu0-range').focus();
    await page.keyboard.press('ArrowRight');
    is = await iaState(); assert.equal(is.mu0, 50.1, 'ArrowRight moves μ0 by 0,1');
    assert.equal(await ia.locator('#viz-ia-mu0').inputValue(), '50,1');
    // One-sided test „menší“: one-sided interval with an upper bound and the 90% two-sided interval share the bound.
    await ia.locator('[data-preset="mensi"]').click();
    is = await iaState();
    iaNear(is.p, 0.0407701332233, 'One-sided p-value'); assert.equal(is.ci[0], '-Infinity'); iaNear(is.ci[1], 49.7639405758, 'Upper bound');
    iaNear(is.central[0], 42.2360594242, '90% interval lower bound'); iaNear(is.acc[0], 46.2360594242, 'One-sided region');
    assert.deepEqual(is.decisions, [true, true, true, true]);
    iaText = await ia.locator('[data-stats]').innerText();
    assert(iaText.includes('=T.DIST((46-50)/(11/ODMOCNINA(25));24;PRAVDA)') && iaText.includes('(−∞; 49,76]') && iaText.includes('(42,24; 49,76)'), 'One-sided formulas and intervals');
    assert.match(await iaPlots.nth(0).getAttribute('aria-description'), /95% jednostranný interval s horní mezí: \(−∞; 49,76\]/);
    await ia.locator('input[name="viz-ia-side"][value="greater"]').check();
    is = await iaState(); iaNear(is.p, 0.959229866777, 'Opposite direction'); iaNear(is.ci[0], 42.2360594242, 'Lower bound'); assert.equal(is.ci[1], 'Infinity');
    // PDI example from Howell.
    await ia.locator('[data-preset="pdi"]').click();
    is = await iaState(); iaNear(is.p, 0.0173653341173, 'PDI p-value'); iaNear(is.ci[0], 100.754982793, 'PDI lower bound');
    assert(is.dom[0] <= 100 && is.dom[1] >= 107.5, 'Range follows the PDI example');
    // A typed value beyond the range widens it; invalid values are rejected and the last valid one kept.
    await ia.locator('#viz-ia-m').fill('130');
    is = await iaState(); assert.equal(is.m, 130); assert(is.dom[1] >= 130, 'Range widened for m = 130');
    for (const [id, bad] of [['s', '0'], ['n', '1'], ['n', '2.5'], ['alpha', '0,6'], ['mu0', 'abc'], ['m', '1,2,3']]) {
      const before = await iaState();
      await ia.locator(`#viz-ia-${id}`).fill(bad);
      assert.equal(await ia.locator(`#viz-ia-${id}`).getAttribute('aria-invalid'), 'true', `Rejected ${id} ${bad}`);
      assert(await ia.locator(`#viz-ia-${id}-error`).isVisible(), `Message for ${id} ${bad}`);
      assert.equal(JSON.stringify((await iaState())[id]), JSON.stringify(before[id]), `Kept ${id} after ${bad}`);
    }
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await iaPlots.nth(1).waitFor();
    await ia.locator('[data-preset="mensi"]').click();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Interval and p-value visualization fits a phone');
    await ia.screenshot({path:'tmp/verification/viz-interval-a-test-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});

    // Coverage of confidence intervals: quantiles, intervals and exact coverage against R, populations, the same samples
    // under another procedure, simulated coverage against scripts/viz-pokryti-intervalu.R, directions, inputs, batches, limit and a phone.
    await page.goto(base + 'quarto/viz_pokryti_intervalu.html', { waitUntil: 'networkidle' });
    const pi = page.locator('#viz-pokryti-intervalu');
    const piPlots = pi.locator('.viz-plots svg[aria-label]');
    await piPlots.nth(3).waitFor();
    assert.equal(await piPlots.count(), 4, 'Intervals, coverage and two histograms; equal widths with known σ need no histogram');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const piState = () => pi.evaluate(el => el.vizCheck.state());
    const piNear = (a, b, msg, tol = 1e-9) => assert(Math.abs(a - b) <= tol * Math.max(1, Math.abs(b)), `${msg}: ${a} vs ${b}`);
    const piWait = () => page.waitForFunction(() => !document.querySelector('#viz-pokryti-intervalu').vizCheck.state().busy, null, { timeout: 120000 });
    // R: qnorm, qt and bounds for m = 46, s = 11, σ = 10, n = 25 at 95 % (scripts/viz-pokryti-intervalu.R).
    const piBase = {pop: 'normalni', mu: 47, sigma: 10, n: 25, level: 95};
    const piQ = await pi.evaluate((el, b) => [['z', 'two'], ['z', 'upper'], ['t', 'two'], ['t', 'lower'], ['zs', 'two']].map(([proc, side]) => el.vizCheck.quantile({...b, proc, side})), piBase);
    [1.95996398454005, 1.64485362695147, 2.06389856162803, 1.71088207990943, 1.95996398454005].forEach((w, i) => piNear(piQ[i], w, `Quantile ${i}`));
    piNear(await pi.evaluate(el => el.vizCheck.quantile({pop: 'normalni', mu: 0, sigma: 1, n: 5, level: 95, proc: 't', side: 'two'})), 2.77644510519779, 't quantile, 4 degrees of freedom');
    const piCI = {
      z: {two: [42.0800720309199, 49.9199279690801], upper: ['-Infinity', 49.2897072539029], lower: [42.7102927460971, 'Infinity']},
      t: {two: [41.4594231644183, 50.5405768355817], upper: ['-Infinity', 49.7639405758007], lower: [42.2360594241993, 'Infinity']},
      zs: {two: [41.6880792340119, 50.3119207659881], upper: ['-Infinity', 49.6186779792932], lower: [42.3813220207068, 'Infinity']}
    };
    for (const [proc, sides] of Object.entries(piCI)) for (const [side, want] of Object.entries(sides)) {
      const got = await pi.evaluate((el, a) => el.vizCheck.interval(46, 11, a), {...piBase, proc, side});
      want.forEach((b, j) => typeof b === 'string' ? assert.equal(got[j], b, `${proc} ${side} infinite bound`) : piNear(got[j], b, `${proc} ${side} bound ${j}`));
    }
    // Two-sided intervals are open, one-sided ones closed at their bound.
    assert.deepEqual(await pi.evaluate(el => { const P = el.vizCheck.position, s = side => ({mu: 47, side}); return [P([40, 47], s('two')), P([47, 50], s('two')), P([-Infinity, 47], s('upper')), P([47, Infinity], s('lower')), P([-Infinity, 46.9], s('upper')), P([47.1, Infinity], s('lower'))]; }), [-1, 1, 0, 0, -1, 1]);
    // R: exact coverage of s with the z quantile in a normal population.
    const piWrong = [[5, 95, 'two', 0.878440340212802], [10, 95, 'two', 0.918350868269318], [25, 95, 'two', 0.938289531058927], [100, 95, 'two', 0.947188613909688],
      [5, 95, 'upper', 0.912327382370723], [25, 95, 'lower', 0.943481873254805], [25, 90, 'two', 0.886963746509610], [25, 99, 'upper', 0.985615771951268]];
    const piExp = await pi.evaluate((el, cases) => cases.map(([n, level, side]) => el.vizCheck.expected({pop: 'normalni', mu: 0, sigma: 1, n, level, side, proc: 'zs'})), piWrong);
    piWrong.forEach((c, i) => {
      piNear(piExp[i].cover, c[3], `Wrong procedure n = ${c[0]}, ${c[1]} %, ${c[2]}`);
      piNear(piExp[i].below + piExp[i].above, 1 - c[3], `Misses add up, case ${i}`);
    });
    assert.deepEqual(await pi.evaluate(el => [el.vizCheck.expected({pop: 'normalni', level: 95, side: 'two', proc: 't', n: 5}), el.vizCheck.expected({pop: 'vyrazne', level: 95, side: 'two', proc: 't', n: 5})]).then(r => [Math.round(r[0].cover * 1e12) / 1e12, Math.round(r[0].below * 1e12) / 1e12, r[1]]), [0.95, 0.025, null]);
    // Populations: mean 0, SD 1, and the exact share at or below the mean (R: pnorm, pgamma).
    const piPops = await pi.evaluate(el => el.vizCheck.populations.map(p => { let s1 = 0, s2 = 0, s3 = 0, le = 0; const N = 200000; const xs = new Float64Array(N);
      for (let i = 0; i < N; i++) { const x = p.std(); xs[i] = x; s1 += x; if (x <= 0) le++; }
      const m = s1 / N; for (const x of xs) { s2 += (x - m) ** 2; s3 += (x - m) ** 3; } const sd = Math.sqrt(s2 / N);
      return {id: p.id, mean: m, sd, skew: s3 / N / sd ** 3, le: le / N}; }));
    const piPopR = {normalni: [0.5, -0.1, 0.1], mirne: [0.547039190513005, 0.6, 0.82], zesikmena: [0.632120558828558, 1.8, 2.2], vyrazne: [0.691462461274013, 4, 10], extremne: [0.707304584890077, 5, 14]};
    for (const p of piPops) {
      const [le, s0, s1] = piPopR[p.id];
      assert(Math.abs(p.mean) < 0.02 && Math.abs(p.sd - 1) < 0.03, `Population ${p.id}: mean ${p.mean}, SD ${p.sd}`);
      assert(Math.abs(p.le - le) < 0.005, `Population ${p.id}: share at or below the mean ${p.le} vs ${le}`);
      assert(p.skew > s0 && p.skew < s1, `Population ${p.id}: skewness ${p.skew}`);
    }
    // Default: the model of chapter 7 with a fixed seed; 94 of the first 100 intervals with known σ capture μ.
    let ps = await piState();
    assert.deepEqual([ps.pop, ps.mu, ps.sigma, ps.n, ps.level, ps.proc, ps.side, ps.K, ps.hit], ['normalni', 47, 10, 25, 95, 'z', 'two', 100, 94]);
    let piText = await pi.locator('[data-calc]').innerText();
    assert(piText.includes('=NORM.S.INV(1-(1-0,95)/2)') && piText.includes('=10/ODMOCNINA(25)'), 'Excel formulas with known σ');
    assert.match(await pi.locator('[data-hist-w]').innerText(), /u všech intervalů stejná, 7,84 bodu/);
    // Counting checked independently from the stored m and s with the R quantiles.
    const piCount = (samples, q, se) => samples.m.reduce((k, m, i) => k + (Math.abs(m - 47) < q * (se ?? samples.s[i] / 5) ? 1 : 0), 0);
    const piSamples = await pi.evaluate(el => el.vizCheck.samples());
    assert.equal(piCount(piSamples, 1.95996398454005, 2), 94, 'Independent count with known σ');
    // Another procedure recomputes the same samples.
    await pi.locator('input[name="viz-pi-proc"][value="t"]').check();
    ps = await piState();
    assert.deepEqual(await pi.evaluate(el => el.vizCheck.samples()), piSamples, 'Same samples after switching to t');
    assert.equal(ps.hit, piCount(piSamples, 2.06389856162803), 'Independent count with t');
    assert.equal(await piPlots.count(), 5, 'Width histogram with s');
    piText = await pi.locator('[data-calc]').innerText();
    assert(piText.includes('=T.INV(1-(1-0,95)/2;24)'), 'Excel t quantile');
    await pi.locator('input[name="viz-pi-side"][value="upper"]').check();
    piText = await pi.locator('[data-calc]').innerText();
    assert(piText.includes('=T.INV(0,95;24)') && piText.includes('(−∞;') && !piText.includes('Dolní mez'), 'One-sided interval with an upper bound');
    ps = await piState(); assert.equal(ps.above, 0, 'An upper bound cannot miss above μ');
    // The axis fits every finite bound of the shown intervals; only infinite bounds reach the edge.
    for (const pop of ['normalni', 'extremne']) {
      if (pop !== 'normalni') { await pi.locator('input[name="viz-pi-pop"][value="extremne"]').check(); await piWait(); }
      for (const side of ['two', 'upper', 'lower']) {
        await pi.locator(`input[name="viz-pi-side"][value="${side}"]`).check();
        ps = await piState();
        const fin = ps.last.flatMap(r => r.ci).filter(v => typeof v === 'number');
        assert(fin.every(v => v >= ps.xDomain[0] && v <= ps.xDomain[1]), `Axis fits finite bounds: ${pop} ${side}`);
      }
    }
    await pi.locator('input[name="viz-pi-pop"][value="normalni"]').check(); await piWait();
    await pi.locator('input[name="viz-pi-side"][value="upper"]').check();
    // Keyboard selection of an interval.
    await pi.locator('[data-intervals]').focus();
    await page.keyboard.press('Home');
    assert.equal((await piState()).selected, 1); assert.match(await pi.locator('[data-detail]').innerText(), /Vybraný výběr č\. 1:/);
    await page.keyboard.press('ArrowUp'); assert.equal((await piState()).selected, 2);
    await page.keyboard.press('End'); assert.equal((await piState()).selected, 100);
    // The confidence level recomputes without new samples.
    await pi.locator('#viz-pi-level').fill('99'); await pi.locator('#viz-pi-level').press('Enter');
    ps = await piState(); assert.deepEqual([ps.level, ps.K], [99, 100], 'Level changed on the same samples');
    // Invalid inputs are rejected and the last valid value kept.
    for (const [id, bad, key] of [['sigma', '0'], ['sigma', '-2'], ['n', '1'], ['n', '1001'], ['level', '50'], ['level', '100'], ['mu', 'abc'], ['draws', '0'], ['draws', '10001']]) {
      const before = await piState();
      await pi.locator(`#viz-pi-${id}`).fill(bad); await pi.locator(`#viz-pi-${id}`).press('Enter');
      assert.equal(await pi.locator(`#viz-pi-${id}`).getAttribute('aria-invalid'), 'true', `Rejected ${id} ${bad}`);
      assert(await pi.locator(`#viz-pi-${id}-error`).isVisible(), `Message for ${id} ${bad}`);
      const after = await piState();
      assert.deepEqual([after[id], after.K], [before[id], before.K], `Kept ${id} after ${bad}`);
    }
    // Normal population, 100 000 samples: simulated coverage within 4 standard errors of the exact one for all procedures.
    await pi.locator('[data-preset="kapitola"]').click(); await piWait();
    await pi.locator('#viz-pi-draws').fill('10000'); await pi.locator('#viz-pi-draws').press('Enter');
    for (let i = 0; i < 10; i++) { await pi.locator('[data-draw]').click(); await piWait(); }
    ps = await piState();
    assert.equal(ps.K, 100000, 'Limit of 100 000 samples');
    assert(await pi.locator('.viz-limit').isVisible() && await pi.locator('[data-draw]').isDisabled(), 'Limit message and disabled button');
    for (const [proc, side, want] of [['z', 'two', 0.95], ['t', 'two', 0.95], ['zs', 'two', 0.938289531058927], ['t', 'lower', 0.95]]) {
      await pi.locator(`input[name="viz-pi-proc"][value="${proc}"]`).check(); await pi.locator(`input[name="viz-pi-side"][value="${side}"]`).check();
      ps = await piState();
      assert(Math.abs(ps.hit / ps.K - want) < 4 * Math.sqrt(want * (1 - want) / ps.K), `Normal ${proc} ${side}: ${ps.hit / ps.K} vs ${want}`);
    }
    await pi.locator('[data-restart]').click(); await piWait();
    ps = await piState(); assert.equal(ps.K, 100, 'Restart draws 100 new samples'); assert(!(await pi.locator('.viz-limit').isVisible()));
    // Skewed populations, n = 25, 95 %: simulated coverage against R (100 000 samples each) and the stated direction.
    // R columns: two-sided, upper bound, lower bound for the procedures z, t, zs (scripts/viz-pokryti-intervalu.R).
    const piSkewR = {
      vyrazne: {z: [0.957, 0.987, 0.938], t: [0.874, 0.837, 0.991], zs: [0.863, 0.829, 0.988]},
      extremne: {z: [0.958, 0.992, 0.939], t: [0.860, 0.819, 0.993], zs: [0.848, 0.810, 0.991]}
    };
    // Expected directions against the R simulations for n = 5, 10, 25 and all skewed populations.
    const piDirR = {
      mirne: {z: [[0.951, 0.960, 0.942], [0.952, 0.957, 0.945], [0.951, 0.954, 0.946]], t: [[0.941, 0.921, 0.970], [0.944, 0.927, 0.968], [0.946, 0.933, 0.963]], zs: [[0.870, 0.877, 0.939], [0.912, 0.907, 0.953], [0.934, 0.926, 0.957]]},
      zesikmena: {z: [[0.956, 0.989, 0.932], [0.955, 0.974, 0.937], [0.952, 0.965, 0.941]], t: [[0.885, 0.843, 0.989], [0.900, 0.866, 0.986], [0.923, 0.897, 0.979]], zs: [[0.812, 0.794, 0.971], [0.869, 0.846, 0.976], [0.912, 0.889, 0.975]]},
      vyrazne: {z: [[0.957, 1.000, 0.940], [0.956, 0.998, 0.938], [0.957, 0.987, 0.938]], t: [[0.820, 0.766, 0.996], [0.840, 0.795, 0.995], [0.874, 0.837, 0.991]], zs: [[0.743, 0.712, 0.986], [0.806, 0.770, 0.989], [0.863, 0.829, 0.988]]},
      extremne: {z: [[0.958, 1.000, 0.942], [0.958, 1.000, 0.941], [0.958, 0.992, 0.939]], t: [[0.799, 0.744, 0.997], [0.817, 0.772, 0.996], [0.860, 0.819, 0.993]], zs: [[0.723, 0.692, 0.989], [0.784, 0.748, 0.992], [0.848, 0.810, 0.991]]}
    };
    const sides = ['two', 'upper', 'lower'];
    const dirs = await pi.evaluate(el => Object.fromEntries(['z', 't', 'zs'].map(proc => [proc, ['two', 'upper', 'lower'].map(side => el.vizCheck.direction({pop: 'mirne', proc, side}).dir)])));
    for (const [pop, procs] of Object.entries(piDirR)) for (const [proc, rows] of Object.entries(procs)) sides.forEach((side, j) => {
      const dir = dirs[proc][j], vals = rows.map(r => r[j]);
      if (dir.startsWith('nižší')) assert(vals.every(v => v < 0.95), `${pop} ${proc} ${side}: lower`);
      else if (dir.includes('vyšší')) assert(vals.every(v => v > 0.95), `${pop} ${proc} ${side}: higher`);
      else assert.match(dir, /nejednoznačné/);
    });
    assert(Object.values(piDirR).some(p => p.zs.some(r => r[2] < 0.95)) && Object.values(piDirR).some(p => p.zs.some(r => r[2] > 0.95)), 'Ambiguous direction occurs both ways');
    for (const [pop, procs] of Object.entries(piSkewR)) {
      await pi.locator(`input[name="viz-pi-pop"][value="${pop}"]`).check(); await piWait();
      for (let i = 0; i < 10; i++) { await pi.locator('[data-draw]').click(); await piWait(); }
      for (const [proc, want] of Object.entries(procs)) for (let j = 0; j < 3; j++) {
        await pi.locator(`input[name="viz-pi-proc"][value="${proc}"]`).check(); await pi.locator(`input[name="viz-pi-side"][value="${sides[j]}"]`).check();
        ps = await piState();
        assert(Math.abs(ps.hit / ps.K - want[j]) < 0.008, `${pop} ${proc} ${sides[j]}: ${ps.hit / ps.K} vs R ${want[j]}`);
        assert.equal(ps.expected, null);
        if (proc !== 'z' && j === 0) assert(ps.below > 20 * ps.above, `${pop} ${proc}: misses lie below μ`);
      }
      assert.match(await pi.locator('[data-cover-note]').innerText(), /přesně spočítat nelze/);
    }
    // Large requests run in batches with locked controls.
    await pi.locator('input[name="viz-pi-pop"][value="normalni"]').check(); await piWait();
    await pi.locator('#viz-pi-n').fill('1000'); await pi.locator('#viz-pi-n').press('Enter'); await piWait();
    await pi.locator('[data-draw]').click();
    await page.waitForFunction(() => document.querySelector('#viz-pokryti-intervalu').vizCheck.state().busy);
    assert(await pi.locator('#viz-pi-mu').isDisabled() && await pi.locator('.viz-progress').isVisible(), 'Locked controls and progress while drawing');
    await piWait();
    ps = await piState(); assert.equal(ps.K, 10100); assert(!(await pi.locator('#viz-pi-mu').isDisabled()));
    // Preset with the wrong procedure for n = 5.
    await pi.locator('[data-preset="male"]').click(); await piWait();
    ps = await piState(); assert.deepEqual([ps.n, ps.proc, ps.K], [5, 'zs', 1000]);
    assert.match(await pi.locator('[data-cover-note]').innerText(), /jen v 87,8 % případů/);
    // Full screen widens the charts.
    const piFull = pi.locator(':scope > .viz-fullscreen-bar > button.viz-fullscreen');
    const piInline = await piPlots.first().evaluate(el => el.getBoundingClientRect().width);
    await piFull.click();
    await page.waitForFunction(w => document.querySelector('#viz-pokryti-intervalu .viz-plots svg[aria-label]').getBoundingClientRect().width > w + 100, piInline);
    await page.screenshot({path:'tmp/verification/viz-pokryti-intervalu-fullscreen.png'});
    await page.keyboard.press('Escape');
    if (await page.evaluate(() => !!document.fullscreenElement)) await page.evaluate(() => document.exitFullscreen());
    await page.waitForFunction(() => !document.fullscreenElement);
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await piPlots.nth(3).waitFor();
    await pi.locator('[data-preset="sikma"]').click(); await piWait();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Coverage visualization fits a phone');
    await pi.screenshot({path:'tmp/verification/viz-pokryti-intervalu-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});

    // Cohen's d: three indicators against R (scripts/viz-cohenovo-d.R), slider, σ field, fill switch, table, full screen, phone and the link from chapter 8.
    await page.goto(base + 'quarto/viz_cohenovo_d.html', { waitUntil: 'networkidle' });
    const cd = page.locator('#viz-cohenovo-d');
    const cdPlots = cd.locator('.viz-plots svg[aria-label]');
    await cdPlots.nth(1).waitFor();
    assert.equal(await cdPlots.count(), 2, 'Two groups and the difference of a random pair');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const cdState = () => cd.evaluate(el => el.vizCheck.state());
    const cdNear = (a, b, msg) => assert(Math.abs(a - b) <= 1e-9, `${msg}: ${a} vs ${b}`);
    // R: pnorm(d), 2 * pnorm(-d / 2), pnorm(d / sqrt(2)); the shared area also by integration of the lower density.
    const cdR = {
      0: [0.5, 1, 0.5], 0.2: [0.579259709439, 0.920344325446, 0.556231458009], 0.47: [0.680822491217, 0.814208733221, 0.630183801126],
      0.5: [0.691462461274, 0.802587348634, 0.638163195084], 0.8: [0.788144601417, 0.689156516779, 0.714196177523],
      0.95: [0.828943873692, 0.634786973283, 0.749129026856], 1: [0.841344746069, 0.617075077452, 0.760249938907],
      1.5: [0.933192798731, 0.453254704754, 0.855577816827], 2: [0.977249868052, 0.317310507863, 0.921350396475]
    };
    for (const [d, want] of Object.entries(cdR)) {
      const got = await cd.evaluate((el, v) => el.vizCheck.indicators(v), +d);
      [got.above, got.shared, got.superior].forEach((g, i) => cdNear(g, want[i], `Indicator ${i} for d = ${d}`));
    }
    // Default: d = 0,5, σ = 10, shared area.
    let cs = await cdState();
    assert.deepEqual([cs.d, cs.sd, cs.fill, cs.diff], [0.5, 10, 'shared', 5]);
    assert.deepEqual(await cd.locator('#viz-cd-d').evaluate(el => [el.min, el.max, el.step, el.value]), ['0', '2', '0.01', '0.5'], 'Slider range');
    assert.deepEqual([cs.formulas.above, cs.formulas.shared, cs.formulas.superior], ['=NORM.S.DIST(0,5;PRAVDA)', '=2*NORM.S.DIST(-0,25;PRAVDA)', '=NORM.S.DIST(0,5/ODMOCNINA(2);PRAVDA)']);
    const cdStats = await cd.locator('[data-stats]').innerText();
    for (const s of ['69,1 %', '80,3 %', '63,8 %', '0,50 · 10 = 5']) assert(cdStats.includes(s), `Stats show ${s}`);
    assert.equal(cs.fixed.length, 7); assert.equal(await cd.locator('.viz-t-current').count(), 1);
    assert.match(await cd.locator('[data-fixed]').innerText(), /0,80\s*\(velký\)/);
    // Keyboard on the slider: arrows by 0,01 without floating-point residue, Home and End to the limits.
    await cd.locator('#viz-cd-d').focus();
    await page.keyboard.press('ArrowRight'); assert.equal((await cdState()).d, 0.51, 'ArrowRight adds 0,01');
    await page.keyboard.press('ArrowLeft'); await page.keyboard.press('ArrowLeft'); assert.equal((await cdState()).d, 0.49, 'ArrowLeft subtracts 0,01');
    await page.keyboard.press('Home'); cs = await cdState();
    assert.equal(cs.d, 0, 'Home sets 0'); assert.deepEqual([cs.indicators.above, cs.indicators.shared, cs.indicators.superior], [0.5, 1, 0.5]);
    await page.keyboard.press('End'); cs = await cdState();
    assert.equal(cs.d, 2, 'End sets 2'); cdNear(cs.indicators.shared, 0.317310507863, 'Shared area for d = 2');
    assert.match(await cd.locator('#viz-cd-d-value').innerText(), /d = 2,00/);
    // A value outside the fixed table is inserted and highlighted.
    await cd.locator('#viz-cd-d').evaluate(el => { el.value = '0.47'; el.dispatchEvent(new Event('input', {bubbles: true})); });
    cs = await cdState();
    const cdRow = cs.fixed.find(r => r.d === 0.47);
    assert(cdRow && cdRow.current && cdRow.inserted, 'Row for d = 0,47 inserted'); assert.equal(cs.fixed.length, 8);
    cdNear(cdRow.superior, 0.630183801126, 'Inserted row, random pair');
    assert.equal(cs.formulas.superior, '=NORM.S.DIST(0,47/ODMOCNINA(2);PRAVDA)');
    // σ field: decimal comma; rejected values keep the last valid one.
    await cd.locator('#viz-cd-sd').fill('14,6');
    cs = await cdState(); assert.equal(cs.sd, 14.6); cdNear(cs.diff, 6.862, 'Difference in seconds');
    for (const bad of ['0', '−1', 'abc', '2000000']) {
      await cd.locator('#viz-cd-sd').fill(bad);
      assert.equal(await cd.locator('#viz-cd-sd').getAttribute('aria-invalid'), 'true', `Rejected σ ${bad}`);
      assert(await cd.locator('#viz-cd-sd-error').isVisible(), `Message for σ ${bad}`);
      assert.equal((await cdState()).sd, 14.6, `Kept σ after ${bad}`);
    }
    // Fill switch.
    await cd.locator('input[name="viz-cd-fill"][value="above"]').check();
    assert.equal((await cdState()).fill, 'above');
    assert.match(await cdPlots.first().getAttribute('aria-description'), /68,1 %/);
    // Full screen widens the charts and Escape closes it.
    const cdFull = cd.locator(':scope > .viz-fullscreen-bar > button.viz-fullscreen');
    assert.equal(await cdFull.count(), 1, 'One full-screen button');
    const cdInline = await cdPlots.first().evaluate(el => el.getBoundingClientRect().width);
    assert(cdInline <= 781, `Inline chart width ${cdInline}`);
    await cdFull.click();
    await page.waitForFunction(w => document.querySelector('#viz-cohenovo-d .viz-plots svg[aria-label]').getBoundingClientRect().width > w + 100, cdInline);
    await page.screenshot({path:'tmp/verification/viz-cohenovo-d-fullscreen.png'});
    await page.keyboard.press('Escape');
    if (await page.evaluate(() => !!document.fullscreenElement)) await page.evaluate(() => document.exitFullscreen());
    await page.waitForFunction(() => !document.fullscreenElement);
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await cdPlots.nth(1).waitFor();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), "Cohen's d visualization fits a phone");
    await cd.screenshot({path:'tmp/verification/viz-cohenovo-d-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});
    await page.goto(base + 'quarto/kapitola_08.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#sec-d-nezavisle .callout-tip a[href$="viz_cohenovo_d.html"]').count(), 1, "Chapter 8 links to the Cohen's d visualization");
    assert.equal(await page.locator('#sec-proc-rozdily .callout-tip a[href$="viz_prinos_parovani.html"]').count(), 1, 'Chapter 8 links to the pairing visualization');

    // Benefit of pairing: both analyses against R (scripts/viz-prinos-parovani.R), model standard errors,
    // data source and model switches, fields, sliders, repeated sampling, Excel formulas, full screen and phone.
    await page.goto(base + 'quarto/viz_prinos_parovani.html', { waitUntil: 'networkidle' });
    const pp = page.locator('#viz-prinos-parovani');
    const ppPlots = pp.locator('.viz-plots svg[aria-label]');
    await ppPlots.nth(3).waitFor();
    assert.equal(await ppPlots.count(), 4, 'Scores, differences, both intervals and the model standard error');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const ppState = () => pp.evaluate(el => el.vizCheck.state());
    const ppNear = (a, b, msg, tol = 1e-9) => assert(Math.abs(a - b) <= tol, `${msg}: ${a} vs ${b}`);
    const ppWait = () => page.waitForFunction(() => !document.querySelector('#viz-prinos-parovani').vizCheck.state().busy, null, { timeout: 120000 });
    const ppSlide = (id, v) => pp.locator(`#viz-pp-${id}`).evaluate((el, x) => { el.value = String(x); el.dispatchEvent(new Event('input', {bubbles: true})); }, v);
    const ppField = async (id, v) => { await pp.locator(`#viz-pp-${id}`).fill(v); await pp.locator(`#viz-pp-${id}`).dispatchEvent('change'); };
    // R: qt(0.975, 11) and qt(0.975, 22).
    ppNear(await pp.evaluate(el => el.vizCheck.qt(0.975, 11)), 2.20098516009, 'qt 11');
    ppNear(await pp.evaluate(el => el.vizCheck.qt(0.975, 22)), 2.07387306790, 'qt 22');
    // R: t.test(paired = TRUE) and t.test(var.equal = TRUE) for three data sets [se, t, df, p, lo, hi].
    const ppR = [
      {x1: [58, 44, 51, 39, 62, 47, 55, 42, 49, 60, 45, 52], x2: [53, 42, 45, 38, 55, 44, 51, 43, 44, 58, 39, 50],
        sd: [7.340217154743, 6.422026490324, 2.393172105652, 0.948193730452],
        paired: [0.690849279708, 5.06622805119, 11, 0.000362722939485, 1.97945098750, 5.02054901250],
        independent: [2.815451593753, 1.24313982445, 22, 0.226902222635770, -2.33888923427, 9.33888923427]},
      {x1: [2, 4, 6], x2: [6, 12, 18], sd: [2, 6, 4, 1],
        paired: [2.30940107676, -3.46410161514, 2, 0.0741799002274, -17.9365508470, 1.93655084700],
        independent: [3.65148371670, -2.19089023002, 4, 0.0935990209704, -18.1381440919, 2.13814409194]},
      {x1: [12.5, 9, 14, 7.5, 11, 10, 13.5, 8], x2: [11, 9.5, 10, 8.5, 12, 7, 15, 6.5],
        sd: [2.477578022413, 2.770217887253, 2.052872551886, 0.699228589097],
        paired: [0.725800051175, 1.033342445741, 7, 0.335817702254, -0.966244402816, 2.46624440282],
        independent: [1.313987252602, 0.570781792985, 14, 0.577195095403, -2.068222367474, 3.56822236747]}
    ];
    for (const [k, set] of ppR.entries()) {
      const got = await pp.evaluate((el, s) => el.vizCheck.analyze(s.x1, s.x2), set);
      [got.s1, got.s2, got.sD, got.r].forEach((g, i) => ppNear(g, set.sd[i], `Data set ${k}, SD ${i}`));
      for (const a of ['paired', 'independent']) ['se', 't', 'df', 'p', 'lo', 'hi'].forEach((key, i) => ppNear(got[a][key], set[a][i], `Data set ${k}, ${a} ${key}`));
    }
    // R: standard errors in the model [paired, independent].
    const ppSE = [
      [{mode: 'osoby', stable: 6.7, noise: 1.7, n: 12}, 0.694022093789, 2.82193786844],
      [{mode: 'osoby', stable: 1, noise: 7, n: 12}, 2.857738033247, 2.88675134595],
      [{mode: 'osoby', stable: 0, noise: 5, n: 12}, 2.041241452319, 2.041241452319],
      [{mode: 'korelace', s1: 7.34, s2: 6.42, rho: 0.95, n: 12}, 0.680605122911, 2.81501924209],
      [{mode: 'korelace', s1: 2, s2: 6, rho: 0.99, n: 12}, 1.163328557774, 1.82574185835],
      [{mode: 'korelace', s1: 7.34, s2: 6.42, rho: -0.5, n: 12}, 3.442562030426, 2.81501924209]
    ];
    for (const [s, p, i] of ppSE) {
      const got = await pp.evaluate((el, v) => el.vizCheck.modelSE(v), s);
      ppNear(got.paired, p, `Model SE paired ${JSON.stringify(s)}`); ppNear(got.independent, i, `Model SE independent ${JSON.stringify(s)}`);
    }
    // Default: variant A, table 8.4 of chapter 8 and the Excel formulas.
    let ppS = await ppState();
    assert.deepEqual([ppS.source, ppS.mode, ppS.n, ppS.muD, ppS.data.x1.length], ['A', 'osoby', 12, 3.5, 12]);
    const ppTable = await pp.locator('[data-compare]').innerText();
    for (const s of ['0,69', '2,82', '5,07', '1,24', '0,0004', '0,227', '(1,98; 5,02)', '(−2,34; 9,34)', '3,8krát']) assert(ppTable.includes(s), `Table shows ${s}`);
    for (const f of ['=2,3932/ODMOCNINA(12)', '=T.DIST.2T(ABS(5,0662);11)', '=T.INV(0,975;11)', '=ODMOCNINA(7,3402^2/12+6,422^2/12)', '=T.DIST.2T(ABS(1,2431);22)', '=T.INV(0,975;22)', '=T.TEST(G2:G14;H2:H14;2;1)', '=T.TEST(G2:G14;H2:H14;2;2)'])
      assert(ppS.excel.some(x => x.includes(f)), `Excel formula ${f}`);
    assert(!ppS.stats.some(x => x.includes('korelační')), 'No r in the first way of setting the model');
    assert.equal(await pp.locator('[data-mode-controls="korelace"]').isVisible(), false, 'Correlation sliders hidden');
    // Keyboard on a slider switches to a model sample.
    await pp.locator('#viz-pp-stable').focus();
    await page.keyboard.press('ArrowRight');
    ppS = await ppState();
    assert.deepEqual([ppS.stable, ppS.source, ppS.data.x1.length], [6.8, 'model', 12], 'ArrowRight adds 0,1 and switches to the model');
    assert(await pp.locator('input[name="viz-pp-source"][value="model"]').isChecked());
    await page.keyboard.press('Home'); assert.equal((await ppState()).stable, 0, 'Home sets 0');
    await page.keyboard.press('End'); assert.equal((await ppState()).stable, 15, 'End sets 15');
    await ppSlide('stable', 6.7);
    // The same random numbers are reused: changing μD shifts the differences exactly.
    const d0 = (await ppState()).data; await ppField('muD', '1,5'); const d1 = (await ppState()).data;
    d0.x1.forEach((v, i) => { ppNear(d1.x1[i], v, 'Same first measurement'); ppNear((d0.x1[i] - d0.x2[i]) - (d1.x1[i] - d1.x2[i]), 2, 'Difference shifted by 2'); });
    await pp.locator('[data-new]').click();
    assert.notEqual((await ppState()).data.x1[0], d1.x1[0], 'New sample');
    // Fields: decimal comma, minus sign and rejected values.
    await ppField('n', '50'); assert.equal((await ppState()).data.x1.length, 50);
    for (const bad of ['2', '201', '2,5', 'abc']) {
      await ppField('n', bad);
      assert.equal(await pp.locator('#viz-pp-n').getAttribute('aria-invalid'), 'true', `Rejected n ${bad}`);
      assert(await pp.locator('#viz-pp-n-error').isVisible(), `Message for n ${bad}`);
      assert.equal((await ppState()).n, 50, `Kept n after ${bad}`);
    }
    for (const bad of ['−60', 'x']) { await ppField('muD', bad); assert.equal((await ppState()).muD, 1.5, `Kept μD after ${bad}`); }
    await ppField('muD', '−2'); assert.equal((await ppState()).muD, -2, 'Minus sign accepted');
    // Batched repeated sampling locks the controls (n = 200: many batches).
    await ppField('n', '200');
    await pp.locator('[data-sim="10000"]').click();
    // Busy state, progress and locked field are read in one step, because the batches may finish quickly.
    await page.waitForFunction(() => { const r = document.querySelector('#viz-prinos-parovani'); return r.vizCheck.state().busy && !r.querySelector('.viz-progress').hidden && r.querySelector('#viz-pp-n').disabled; }, null, { timeout: 20000, polling: 5 })
      .catch(() => assert.fail('Batched drawing locks the controls'));
    await ppWait();
    assert.equal((await ppState()).simK, 10000);
    assert.equal(await pp.locator('[data-sim-plot] svg[aria-label]').count(), 1, 'Histogram of interval widths');
    // Rejection rates against R: paired exact (noncentral t), incorrect analysis simulated; 10 000 samples, about 4 SE.
    const ppSim = async (settings, want) => {
      if (settings.mode) await pp.locator(`input[name="viz-pp-mode"][value="${settings.mode}"]`).check();
      for (const id of ['stable', 'noise', 's1', 's2', 'rho']) if (id in settings) await ppSlide(id, settings[id]);
      await ppField('n', String(settings.n)); await ppField('muD', String(settings.muD).replace('.', ','));
      await pp.locator('[data-sim-reset]').click();
      await pp.locator('[data-sim="10000"]').click(); await ppWait();
      const r = (await ppState()).sim;
      assert.equal(r.K, 10000);
      for (const [key, value, tol] of want) ppNear(r[key], value, `${key} for ${JSON.stringify(settings)}`, tol);
    };
    await ppSim({mode: 'osoby', stable: 6.7, noise: 1.7, n: 12, muD: 0}, [['rejP', 0.05, 0.01], ['covP', 0.95, 0.01], ['rejI', 0, 0.002]]);
    await ppSim({n: 12, muD: 3.5}, [['rejP', 0.995435, 0.004], ['rejI', 0.04816, 0.009]]);
    await ppSim({mode: 'korelace', s1: 7.34, s2: 6.42, rho: -0.5, n: 12, muD: 0}, [['rejP', 0.05, 0.01], ['rejI', 0.1069425, 0.0125]]);
    ppS = await ppState();
    assert(ppS.stats.some(x => x.includes('korelační')), 'Sample r shown in the correlation mode');
    assert(await pp.locator('[data-mode-controls="korelace"]').isVisible() && !(await pp.locator('[data-mode-controls="osoby"]').isVisible()), 'Correlation sliders shown');
    // A change of the model clears repeated sampling; the cap of 100 000 samples.
    await ppSlide('rho', 0.5); assert.equal((await ppState()).simK, 0, 'Model change clears the simulation');
    for (let i = 0; i < 10; i++) { await pp.locator('[data-sim="10000"]').click(); await ppWait(); }
    assert.equal((await ppState()).simK, 100000);
    assert(await pp.locator('.viz-limit').isVisible() && await pp.locator('[data-sim="100"]').isDisabled(), 'Cap of 100 000 samples');
    await pp.locator('[data-sim-reset]').click(); assert.equal((await ppState()).simK, 0);
    // Back to variant A.
    await pp.locator('input[name="viz-pp-source"][value="A"]').check();
    ppS = await ppState();
    ppNear(ppS.analysis.paired.se, 0.690849279708, 'Variant A again');
    // Full screen widens the charts and Escape closes it.
    const ppFull = pp.locator(':scope > .viz-fullscreen-bar > button.viz-fullscreen');
    assert.equal(await ppFull.count(), 1, 'One full-screen button');
    const ppInline = await ppPlots.first().evaluate(el => el.getBoundingClientRect().width);
    assert(ppInline <= 781, `Inline chart width ${ppInline}`);
    await ppFull.click();
    await page.waitForFunction(w => document.querySelector('#viz-prinos-parovani .viz-plots svg[aria-label]').getBoundingClientRect().width > w + 100, ppInline);
    await page.screenshot({path:'tmp/verification/viz-prinos-parovani-fullscreen.png'});
    await page.keyboard.press('Escape');
    if (await page.evaluate(() => !!document.fullscreenElement)) await page.evaluate(() => document.exitFullscreen());
    await page.waitForFunction(() => !document.fullscreenElement);
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await ppPlots.nth(3).waitFor();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Pairing visualization fits a phone');
    await pp.screenshot({path:'tmp/verification/viz-prinos-parovani-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});

    // Two intervals and the interval of the difference: values against R (scripts/viz-dva-intervaly.R),
    // design, method and level switches, presets, fields, the s_D slider, Excel formulas, full screen and phone.
    await page.goto(base + 'quarto/kapitola_08.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#sec-dva-intervaly .callout-tip a[href$="viz_dva_intervaly.html"]').count(), 1, 'Chapter 8 links to the two-intervals visualization');
    await page.goto(base + 'quarto/viz_dva_intervaly.html', { waitUntil: 'networkidle' });
    const di = page.locator('#viz-dva-intervaly');
    const diPlots = di.locator('.viz-plots svg[aria-label]');
    await diPlots.nth(4).waitFor();
    assert.equal(await diPlots.count(), 5, 'Two intervals, difference, band, margins of error and triangle');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const diState = () => di.evaluate(el => el.vizCheck.state());
    const diNear = (a, b, msg, tol = 1e-9) => assert(Math.abs(a - b) <= tol, `${msg}: ${a} vs ${b}`);
    const diCalc = s => di.evaluate((el, v) => el.vizCheck.compute(v), s);
    // R: example of chapter 8 at three levels [lo1, hi1, lo2, hi2, t, p, loD, hiD, sigFrom, apartFrom].
    const diBase = {design: 'nezavisle', method: 'klasicky', m1: 46, s1: 10, n1: 25, m2: 52, s2: 10, n2: 25};
    const diR = {
      0.95: [41.8722028767, 50.1277971233, 47.8722028767, 56.1277971233, 2.1213203435596, 0.0390854943291, 0.3130661135781, 11.6869338864219, 5.68693388642, 8.25559424651],
      0.9: [42.5782358402, 49.4217641598, 48.5782358402, 55.4217641598, 2.1213203435596, 0.0390854943291, 1.2560935894013, 10.7439064105987, 4.74390641060, 6.84352831964],
      0.99: [40.4061209905, 51.5938790095, 46.4061209905, 57.5938790095, 2.1213203435596, 0.0390854943291, -1.5864186239295, 13.5864186239295, 7.58641862393, 11.18775801910]
    };
    for (const [level, want] of Object.entries(diR)) {
      const c = await diCalc({...diBase, level: +level});
      [c.g1.lo, c.g1.hi, c.g2.lo, c.g2.hi, c.diff.t, c.diff.p, c.diff.lo, c.diff.hi, c.sigFrom, c.apartFrom].forEach((g, i) => diNear(g, want[i], `Example at ${level}, value ${i}`, 1e-8));
    }
    // R: Welch and classical for unequal groups; classical with the larger group more variable; paired data of variant A.
    let dc = await diCalc({...diBase, level: 0.95, method: 'welch', s1: 15, n1: 10, s2: 5, n2: 40});
    [dc.diff.df, dc.diff.q, dc.diff.p, dc.diff.lo, dc.diff.hi].forEach((g, i) => diNear(g, [9.50525191383, 2.24395953966, 0.2420028415673, -4.790855891054, 16.7908558911][i], `Welch ${i}`, 1e-8));
    dc = await diCalc({...diBase, level: 0.95, s1: 15, n1: 10, s2: 5, n2: 40});
    [dc.diff.p, dc.diff.lo, dc.diff.hi].forEach((g, i) => diNear(g, [0.0369051690497, 0.380105005036, 11.6198949950][i], `Classical unequal ${i}`, 1e-8));
    dc = await diCalc({...diBase, level: 0.95, s1: 5, n1: 10, m2: 55, s2: 15, n2: 40});
    diNear(dc.diff.p, 0.06915885636057, 'Classical, larger group more variable', 1e-8); diNear(dc.apartFrom, 8.37401726225, 'Apart from', 1e-8);
    assert(!dc.overlaps && !dc.significant, 'Apart but not significant with the classical test');
    const diA = {design: 'parove', level: 0.95, m1: 46.8333333333333, s1: 6.42202649032, n1: 12, m2: 50.3333333333333, s2: 7.34021715474};
    dc = await diCalc({...diA, sD: 2.39317210565});
    [dc.g1.lo, dc.g1.hi, dc.g2.lo, dc.g2.hi, dc.diff.lo, dc.diff.hi, dc.diff.p].forEach((g, i) => diNear(g, [42.7529723701, 50.9136942965, 45.6695818548, 54.9970848119, 1.97945098750, 5.02054901250, 0.000362722939485][i], `Variant A ${i}`, 1e-8));
    dc = await diCalc({...diA, sD: 13.762243645067});
    diNear(dc.diff.lo, -5.24411244173, 'Largest s_D', 1e-8); diNear(dc.diff.me, dc.apartFrom, 'Largest s_D: margin equals the sum', 1e-9);
    // Default state, verdict, statistics and Excel formulas.
    let ds = await diState();
    assert.deepEqual([ds.design, ds.method, ds.level, ds.m1, ds.m2, ds.n2], ['nezavisle', 'klasicky', 0.95, 46, 52, 25]);
    assert.match(ds.verdict, /překrývají, a přesto 95% interval rozdílu nulu nezahrnuje/);
    const diStats = await di.locator('[data-stats]').innerText();
    for (const s of ['(41,87; 50,13)', '(47,87; 56,13)', '(0,31; 11,69)', '0,039', '5,69 / 8,26', '2,26 bodu']) assert(diStats.includes(s), `Statistics show ${s}`);
    for (const f of ['=T.INV(0,975;24)', '=2,0639*10/ODMOCNINA(25)', '=ODMOCNINA(((25-1)*10^2+(25-1)*10^2)/(25+25-2))', '=10*ODMOCNINA(1/25+1/25)', '=T.INV(0,975;48)', '=T.DIST.2T(ABS(2,1213);48)'])
      assert(ds.excel.some(x => x.includes(f)), `Excel formula ${f}`);
    // Level and method switches.
    await di.locator('input[name="viz-di-level"][value="0.99"]').check();
    ds = await diState(); diNear(ds.result.diff.lo, -1.5864186239295, '99 % switch', 1e-8);
    assert.match(ds.verdict, /překrývají a 99% interval rozdílu zahrnuje nulu/);
    assert(ds.excel.some(x => x.includes('=T.INV(0,995;24)')), 'Quantile 0,995');
    // Presets: unequal groups with Welch, the BETA.INV quantile and the switch to the classical test.
    await di.locator('[data-preset="nestejne"]').click();
    ds = await diState();
    assert.deepEqual([ds.method, ds.level, ds.n1, ds.n2], ['welch', 0.95, 10, 40]);
    assert(ds.excel.some(x => x.includes('=ODMOCNINA(9,5053*(1-BETA.INV(0,05;9,5053/2;0,5))/BETA.INV(0,05;9,5053/2;0,5))')), 'Welch quantile through BETA.INV');
    assert(ds.excel.some(x => x.includes('=(22,5+0,625)^2/(22,5^2/(10-1)+0,625^2/(40-1))')), 'Welch degrees of freedom');
    await di.locator('input[name="viz-di-method"][value="klasicky"]').check();
    diNear((await diState()).result.diff.p, 0.0369051690497, 'Classical after the switch', 1e-8);
    // Just touching intervals in the example of chapter 8.
    await di.locator('[data-preset="kapitola"]').click();
    await di.locator('[data-preset="dotyk"]').click();
    ds = await diState();
    diNear(ds.m2, 54.2556, 'Touching mean', 1e-9); diNear(ds.result.diff.p, 0.00533511607874, 'p when the intervals touch', 2e-5);
    // Fields: decimal comma and rejected values.
    await di.locator('[data-preset="kapitola"]').click();
    const diField = async (id, v) => { await di.locator(`#viz-di-${id}`).fill(v); await di.locator(`#viz-di-${id}`).dispatchEvent('change'); };
    await diField('m2', '53,5'); assert.equal((await diState()).m2, 53.5);
    for (const [id, bad, keep] of [['n1', '1', 25], ['n1', '1001', 25], ['n1', '2,5', 25], ['s1', '0', 10], ['s1', '−1', 10], ['s1', 'abc', 10], ['m1', 'x', 46]]) {
      await diField(id, bad);
      assert.equal(await di.locator(`#viz-di-${id}`).getAttribute('aria-invalid'), 'true', `Rejected ${id} ${bad}`);
      assert(await di.locator(`#viz-di-${id}-error`).isVisible(), `Message for ${id} ${bad}`);
      assert.equal((await diState())[id], keep, `Kept ${id} after ${bad}`);
    }
    // Paired data of variant A: hidden fields, the s_D slider by keyboard and its limits.
    await di.locator('[data-preset="variantaA"]').click();
    ds = await diState();
    assert.equal(ds.design, 'parove');
    assert(!(await di.locator('[data-field="n2"]').isVisible()) && !(await di.locator('[data-method]').isVisible()) && await di.locator('#viz-di-sD').isVisible(), 'Paired controls');
    assert.equal(await diPlots.count(), 4, 'No triangle for paired data');
    assert.deepEqual(ds.sdRange, [0.92, 13.76]);
    const g1Before = [ds.result.g1.lo, ds.result.g1.hi];
    await di.locator('#viz-di-sD').focus();
    await page.keyboard.press('Home'); ds = await diState(); assert.equal(ds.sD, 0.92, 'Home sets the smallest s_D');
    assert.deepEqual([ds.result.g1.lo, ds.result.g1.hi], g1Before, 'Condition intervals do not depend on s_D');
    await page.keyboard.press('End'); ds = await diState(); assert.equal(ds.sD, 13.76, 'End sets the largest s_D');
    assert(ds.result.diff.lo < 0, 'Largest s_D: the paired interval includes zero');
    await page.keyboard.press('ArrowLeft'); assert.equal((await diState()).sD, 13.75, 'ArrowLeft subtracts 0,01');
    assert(ds.excel.some(x => x.includes('=13,76/ODMOCNINA(12)')), 'Paired standard error formula');
    // A smaller s1 moves the limits and clamps s_D.
    await diField('s1', '2'); ds = await diState();
    assert.deepEqual(ds.sdRange, [5.34, 9.34]); assert.equal(ds.sD, 9.34, 's_D clamped to the new limit');
    // Full screen widens the charts and Escape closes it.
    await di.locator('[data-preset="kapitola"]').click();
    await diPlots.nth(4).waitFor();
    const diFull = di.locator(':scope > .viz-fullscreen-bar > button.viz-fullscreen');
    assert.equal(await diFull.count(), 1, 'One full-screen button');
    const diInline = await diPlots.nth(2).evaluate(el => el.getBoundingClientRect().width);
    assert(diInline <= 781, `Inline chart width ${diInline}`);
    await diFull.click();
    await page.waitForFunction(w => document.querySelectorAll('#viz-dva-intervaly .viz-plots svg[aria-label]')[2].getBoundingClientRect().width > w + 100, diInline);
    await page.screenshot({path:'tmp/verification/viz-dva-intervaly-fullscreen.png'});
    await page.keyboard.press('Escape');
    if (await page.evaluate(() => !!document.fullscreenElement)) await page.evaluate(() => document.exitFullscreen());
    await page.waitForFunction(() => !document.fullscreenElement);
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await diPlots.nth(4).waitFor();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Two-intervals visualization fits a phone');
    await di.screenshot({path:'tmp/verification/viz-dva-intervaly-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});

    // From a table of frequencies to the chi-square test: values against R (scripts/viz-chi-kvadrat.R),
    // editable table, buttons, rejected inputs, warning for small expected frequencies, full screen and phone.
    await page.goto(base + 'quarto/kapitola_09.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#sec-pearson-upravena .callout-tip a[href$="viz_chi_kvadrat.html"]').count(), 1, 'Chapter 9 links to the chi-square visualization');
    assert.equal(await page.locator('#quarto-sidebar .sidebar-item-section').nth(1).locator('ul.sidebar-section').isVisible(), false, 'Visualizations collapsed on a chapter page');
    await page.goto(base + 'quarto/viz_chi_kvadrat.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#quarto-sidebar .sidebar-item-section').nth(1).locator('ul.sidebar-section').isVisible(), true, 'Visualizations open on their own page');
    assert.equal(await page.locator('#quarto-sidebar .sidebar-item-section').nth(1).locator('a.sidebar-link.active').count(), 1, 'Current visualization marked in the sidebar');
    const chi = page.locator('#viz-chi-kvadrat');
    const chiPlots = chi.locator('.viz-plots svg[aria-label]');
    await chiPlots.nth(1).waitFor();
    assert.equal(await chiPlots.count(), 2, 'Row proportions and the chi-square distribution');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const chiState = () => chi.evaluate(el => el.vizCheck.state());
    const chiNear = (a, b, msg, tol = 1e-8) => assert(Math.abs(a - b) <= tol, `${msg}: ${a} vs ${b}`);
    const chiCalc = f => chi.evaluate((el, v) => el.vizCheck.compute(v), f);
    // R: right tail, density and critical value of the chi-square distribution with 4 degrees of freedom.
    const chiTail = await chi.evaluate(el => [1, 5, 9.49, 11.78, 23.56, 60].map(x => el.vizCheck.chiRt(x, 4)));
    [9.09795989569e-01, 2.87297495184e-01, 4.99531312233e-02, 1.90644694417e-02, 9.78457253274e-05, 2.90086312034e-12].forEach((w, i) => chiNear(chiTail[i], w, `Chi-square tail ${i}`, 1e-10 * Math.max(1, w * 1e4)));
    const chiDens = await chi.evaluate(el => [0.5, 2, 6, 12].map(x => el.vizCheck.dchi(x, 4)));
    [0.0973500978839, 0.1839397205857, 0.0746806025518, 0.0074362565300].forEach((w, i) => chiNear(chiDens[i], w, `Chi-square density ${i}`, 1e-10));
    chiNear(await chi.evaluate(el => el.vizCheck.chiInvRt(0.05, 4)), 9.4877290368, 'Critical value');
    // R: table of chapter 9 [chi2, p, V, minE, e11, contribution, Pearson and standardized residual of seniors x problem solving, standardized residual of young x social support].
    const chiPick = c => [c.chi2, c.p, c.V, c.minE, c.e[0][0], c.contrib[2][0], c.pearson[2][0], c.std[2][0], c.std[0][2]];
    const chiTables = [
      [[[25, 18, 12], [30, 22, 28], [10, 20, 25]], [11.7753496503, 0.01910240056, 0.1760334123, 17.3684210526, 18.81578947, 4.1304747884, -2.0323569540, -2.9725673140, -2.2981938338]],
      [[[50, 36, 24], [60, 44, 56], [20, 40, 50]], [23.5506993007, 9.826603202e-05, 0.1760334123, 34.7368421053, 37.63157895, 8.2609495767, -2.8741867679, -4.203845011, -3.2501368887]],
      [[[19, 17, 19], [27, 26, 27], [19, 17, 19]], [0.0542540793, 0.9996386487, 0.0119488030, 17.3684210526, 18.81578947, 0.001803459698, 0.04246716023, 0.06211334686, 0.06211334686]],
      [[[24, 17, 14], [27, 26, 27], [19, 17, 19]], [1.9385551948, 0.7470592171, 0.0714245129, 17.3684210526, 20.26315789, 0.07874231032, -0.2806106027, -0.4188901711, -1.1592076649]],
      [[[25, 18, 12], [30, 22, 28], [20, 20, 25]], [4.8247265555, 0.3057589651, 0.1098263010, 16.5, 20.625, 0.7852564103, -0.8861469462, -1.364312474, -1.9863874195]],
      [[[5, 4, 2], [6, 4, 6], [2, 4, 5]], [2.9452214452, 0.5670339177, 0.1968575977, 3.4736842105, 3.763157895, 0.82609495767, -0.9088976607, -1.3293725164, -1.3293725164]]
    ];
    for (const [f, want] of chiTables) chiPick(await chiCalc(f)).forEach((g, i) => chiNear(g, want[i], `Table ${f[0]} value ${i}`, 5e-9));
    // Default state, verdict, statistics, derived tables and the Excel formula.
    let chiS = await chiState();
    assert.deepEqual(chiS.f, [[25, 18, 12], [30, 22, 28], [10, 20, 25]]);
    assert.match(chiS.verdict, /χ² = 11,78 je větší než kritická hodnota 9,49 \(p = 0,019\).*zamítáme nulovou hypotézu/);
    assert(!/nezamítáme/.test(chiS.verdict) && !chiS.warning, 'Default table rejects and has no warning');
    assert.equal(chiS.excel, '=CHISQ.DIST.RT(11,7753;4)');
    const chiStats = await chi.locator('[data-stats]').innerText();
    for (const s of ['190', '11,78', '(3 − 1) × (3 − 1) = 4', '0,019', '9,49', '0,18', '17,37', '=CHISQ.DIST.RT(11,7753;4)']) assert(chiStats.includes(s), `Statistics show ${s}`);
    const chiDerived = chi.locator('[data-derived] table');
    assert.equal(await chiDerived.count(), 4, 'Four derived tables');
    assert.deepEqual(await chiDerived.evaluateAll(ts => ts.map(t => t.getAttribute('aria-label'))), ['Očekávané četnosti', 'Příspěvky buněk ke statistice χ²', 'Pearsonova rezidua', 'Standardizovaná rezidua']);
    const chiCells = i => chiDerived.nth(i).locator('tbody tr').evaluateAll(rows => rows.map(r => [...r.querySelectorAll('td')].map(td => td.textContent)));
    assert.deepEqual(await chiCells(0), [['18,82', '17,37', '18,82'], ['27,37', '25,26', '27,37'], ['18,82', '17,37', '18,82']]);
    assert.deepEqual(await chiCells(1), [['2,03', '0,02', '2,47'], ['0,25', '0,42', '0,01'], ['4,13', '0,40', '2,03'], ['11,78']]);
    assert.deepEqual(await chiCells(2), [['1,43', '0,15', '−1,57'], ['0,50', '−0,65', '0,12'], ['−2,03', '0,63', '1,43']]);
    assert.deepEqual(await chiCells(3), [['2,09', '0,22', '−2,30'], ['0,82', '−1,03', '0,20'], ['−2,97', '0,91', '2,09']]);
    // Shading of standardized residuals: blue for positive, orange for negative, stronger for larger values.
    const chiShade = await chiDerived.nth(3).locator('tbody td').evaluateAll(tds => tds.map(td => getComputedStyle(td).backgroundColor));
    assert.match(chiShade[0], /rgba\(36, 93, 120/); assert.match(chiShade[6], /rgba\(181, 78, 36/);
    const chiAlpha = c => Number(c.match(/([\d.]+)\)$/)[1]);
    assert(chiAlpha(chiShade[6]) > chiAlpha(chiShade[2]) && chiAlpha(chiShade[2]) > chiAlpha(chiShade[1]), 'Shading grows with the size of the residual');
    assert.deepEqual(await chi.locator('[data-input] td[data-row-total], [data-input] td[data-col-total], [data-input] td[data-n]').allTextContents(), ['55', '80', '55', '65', '60', '65', '190']);
    // Buttons: doubling keeps V and the row proportions; independence; back to the chapter data.
    const chiInput = (j, l) => chi.locator(`[data-input] input[data-j="${j}"][data-l="${l}"]`);
    await chi.locator('[data-action="double"]').click();
    chiS = await chiState();
    assert.deepEqual(chiS.f, [[50, 36, 24], [60, 44, 56], [20, 40, 50]]);
    chiNear(chiS.result.chi2, 23.5506993007, 'Doubled chi-square'); chiNear(chiS.result.V, 0.1760334123, 'Doubled V'); chiNear(chiS.result.rowProp[0][0], 25 / 55, 'Doubled row proportion', 1e-12);
    assert.equal(await chiInput(0, 0).inputValue(), '50');
    assert((await chi.locator('[data-stats]').innerText()).includes('< 0,001'), 'Small p-value shown as an inequality');
    assert.match(chiS.verdict, /p < 0,001/);
    await chi.locator('[data-action="independence"]').click();
    chiS = await chiState();
    chiNear(chiS.result.chi2, 0.0542540793, 'Independence chi-square'); assert.match(chiS.verdict, /je menší než kritická hodnota.*nezamítáme/);
    await chi.locator('[data-action="chapter"]').click();
    assert.deepEqual((await chiState()).f, [[25, 18, 12], [30, 22, 28], [10, 20, 25]]);
    // Editing one cell from the keyboard changes the whole table of expected frequencies.
    await chiInput(2, 0).focus();
    await chiInput(2, 0).fill('20');
    chiS = await chiState();
    chiNear(chiS.result.chi2, 4.8247265555, 'Edited cell'); chiNear(chiS.result.e[0][0], 20.625, 'Expected frequency in another row', 1e-12);
    assert.equal(await chi.locator('[data-input] td[data-n]').textContent(), '200');
    await page.keyboard.press('ArrowDown'); assert.equal((await chiState()).f[2][0], 19, 'Arrow key lowers the frequency by one');
    // Rejected values keep the last valid table.
    await chi.locator('[data-action="chapter"]').click();
    for (const bad of ['', '-3', '2.5', '100001']) {
      await chiInput(0, 1).fill(bad);
      assert.equal(await chiInput(0, 1).getAttribute('aria-invalid'), 'true', `Rejected frequency "${bad}"`);
      assert(await chi.locator('#viz-chi-error').isVisible(), `Message for "${bad}"`);
      assert.match(await chi.locator('#viz-chi-error').textContent(), /celé číslo od 0 do 100 000\. Používá se dál poslední platná hodnota\./);
      assert.equal((await chiState()).f[0][1], 18, `Kept the frequency after "${bad}"`);
    }
    await chiInput(0, 1).fill('18');
    assert.equal(await chiInput(0, 1).getAttribute('aria-invalid'), 'false'); assert(!(await chi.locator('#viz-chi-error').isVisible()), 'Message hidden after a valid value');
    // A row or a column without people is rejected.
    await chiInput(0, 0).fill('0'); await chiInput(0, 1).fill('0'); await chiInput(0, 2).fill('0');
    assert.equal(await chiInput(0, 2).getAttribute('aria-invalid'), 'true');
    assert.match(await chi.locator('#viz-chi-error').textContent(), /V každé věkové skupině musí být alespoň jeden člověk/);
    assert.deepEqual((await chiState()).f[0], [0, 0, 12], 'Empty row not applied');
    await chi.locator('[data-action="chapter"]').click();
    await chiInput(0, 1).fill('0'); await chiInput(1, 1).fill('0'); await chiInput(2, 1).fill('0');
    assert.match(await chi.locator('#viz-chi-error').textContent(), /Každou strategii musí uvést alespoň jeden člověk/);
    assert.equal((await chiState()).f[2][1], 20, 'Empty column not applied');
    // Small table: warning with a link to the chapter; the doubling button is disabled at the limit.
    await chi.locator('[data-action="chapter"]').click();
    for (const [j, row] of [[5, 4, 2], [6, 4, 6], [2, 4, 5]].entries()) for (const [l, v] of row.entries()) await chiInput(j, l).fill(String(v));
    chiS = await chiState();
    chiNear(chiS.result.chi2, 2.9452214452, 'Small table'); assert(chiS.warning, 'Warning for expected frequencies below 5');
    assert(await chi.locator('[data-warning]').isVisible()); assert.match(await chi.locator('[data-warning]').innerText(), /3,47, tedy menší než 5/);
    assert.equal(await chi.locator('[data-warning] a[href$="kapitola_09.html#sec-male-cetnosti"]').count(), 1, 'Warning links to the chapter');
    await chiInput(1, 1).fill('60000');
    assert(await chi.locator('[data-action="double"]').isDisabled(), 'Doubling disabled above the limit');
    await chi.locator('[data-action="chapter"]').click();
    assert(!(await chi.locator('[data-warning]').isVisible()) && !(await chi.locator('[data-action="double"]').isDisabled()));
    // Full screen widens the charts and Escape closes it.
    await chiPlots.nth(1).waitFor();
    const chiFull = chi.locator(':scope > .viz-fullscreen-bar > button.viz-fullscreen');
    assert.equal(await chiFull.count(), 1, 'One full-screen button');
    const chiInline = await chiPlots.nth(1).evaluate(el => el.getBoundingClientRect().width);
    assert(chiInline <= 781, `Inline chart width ${chiInline}`);
    await chi.screenshot({path:'tmp/verification/viz-chi-kvadrat-desktop.png'});
    await chiFull.click();
    await page.waitForFunction(w => document.querySelectorAll('#viz-chi-kvadrat .viz-plots svg[aria-label]')[1].getBoundingClientRect().width > w + 100, chiInline);
    await page.screenshot({path:'tmp/verification/viz-chi-kvadrat-fullscreen.png'});
    await page.keyboard.press('Escape');
    if (await page.evaluate(() => !!document.fullscreenElement)) await page.evaluate(() => document.exitFullscreen());
    await page.waitForFunction(() => !document.fullscreenElement);
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await chiPlots.nth(1).waitFor();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Chi-square visualization fits a phone');
    await chi.screenshot({path:'tmp/verification/viz-chi-kvadrat-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});

    // Difference of proportions, risk ratio and odds ratio: values against R (scripts/viz-miry-souvislosti.R),
    // both ways of entering the data, both views, the measure held fixed, the retrospective sample, full screen and phone.
    await page.goto(base + 'quarto/kapitola_09.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#sec-phi-v .callout-tip a[href$="viz_miry_souvislosti.html"]').count(), 1, 'Chapter 9 links to the visualization of effect measures');
    await page.goto(base + 'quarto/viz_miry_souvislosti.html', { waitUntil: 'networkidle' });
    const ms = page.locator('#viz-miry-souvislosti');
    const msPlots = ms.locator('.viz-plots svg[aria-label]');
    await msPlots.first().waitFor();
    assert.equal(await msPlots.count(), 1, 'One chart of the three lines');
    assert.equal(await ms.locator('[data-dots] svg[role="img"]').count(), 2, 'Two fields of persons');
    assert.equal(await ms.locator('[data-retro-dots] svg[role="img"]').count(), 2, 'Two fields of the retrospective sample');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    assert(await page.locator('a[href*="ref-magnussonOddsRatio"]').count() > 0, 'The page cites the article that inspired it');
    const msState = () => ms.evaluate(el => el.vizCheck.state());
    const msNear = (a, b, msg, tol = 1e-9) => assert(a !== null && Math.abs(a - b) <= tol, `${msg}: ${a} vs ${b}`);
    const msCalc = t => ms.evaluate((el, v) => el.vizCheck.measures(...v), t);
    // R: [p1, p0, diff, rr, odds1, odds0, or, chi2, phi, colDiff].
    const msPick = m => [m.p1, m.p0, m.diff, m.rr, m.odds1, m.odds0, m.or, m.chi2, m.phi, m.colDiff];
    const msTables = [
      [[56, 84, 20, 97], [0.4, 0.170940170940, 0.229059829060, 2.34, 0.666666666667, 0.206185567010, 3.233333333333, 16.056567825570, 0.249953830955, 0.272753707473]],
      [[20, 97, 56, 84], [0.170940170940, 0.4, -0.229059829060, 0.427350427350, 0.206185567010, 0.666666666667, 0.309278350515, 16.056567825570, -0.249953830955, -0.272753707473]],
      [[189, 10845, 104, 10933], [1.71288743883e-02, 9.42285041225e-03, 7.70602397600e-03, 1.81780179445, 1.74273858921e-02, 9.51248513674e-03, 1.83205394191, 25.0138839672, 3.36650729651e-02, 0.147071582086]],
      [[19, 74, 22, 187], [0.2043010752688, 0.1052631578947, 0.0990379173741, 1.9408602150538, 0.2567567567568, 0.1176470588235, 2.1824324324324, 5.3804030712477, 0.1334762308781, 0.1798897299318]],
      [[40, 60, 17, 83], [0.4, 0.17, 0.23, 2.352941176471, 0.666666666667, 0.204819277108, 3.254901960784, 12.980002453687, 0.254754808136, 0.282173966384]]
    ];
    for (const [t, want] of msTables) msPick(await msCalc(t)).forEach((g, i) => msNear(g, want[i], `Table ${t} value ${i}`, 1e-9 * Math.max(1, Math.abs(want[i]))));
    // A zero that would be divided by gives no value instead of infinity.
    const msZero = await msCalc([5, 0, 0, 7]);
    assert.deepEqual([msZero.rr, msZero.odds1, msZero.or], [null, null, null], 'Measures that cannot be computed are empty');
    // R: lines of equal difference, equal risk ratio and equal odds ratio through the point of the chapter example.
    const msSame = x => ms.evaluate((el, v) => el.vizCheck.same(56, 84, 20, 97, v), x);
    const msLines = [[0.01, [0.2390598291, 0.0234, 0.03162699707]], [0.3, [0.5290598291, 0.702, 0.58083832335]], [0.5, [0.7290598291, null, 0.76377952756]], [0.9, [null, null, 0.96677740864]]];
    for (const [x, want] of msLines) (await msSame(x)).forEach((g, i) => want[i] === null ? assert.equal(g, null, `Line ${i} impossible at ${x}`) : msNear(g, want[i], `Line ${i} at ${x}`, 1e-9));
    // R: retrospective sample keeps the odds ratio and changes the ratio of proportions.
    for (const [k, want] of [[0.5, [0.5714285714, 0.2919708029, 1.957142857]], [0.1, [0.8695652174, 0.6734006734, 1.291304348]]]) {
      const r = await ms.evaluate((el, v) => el.vizCheck.retro(56, 84, 20, 97, v), k);
      [r.share1, r.share0, r.ratio].forEach((g, i) => msNear(g, want[i], `Retrospective sample ${k} value ${i}`, 1e-9)); msNear(r.or, 3.233333333333, 'Odds ratio in the sample', 1e-10);
    }
    // Default state: frequencies of the chapter example, risk view, sentences and measures with substitution.
    let msS = await msState();
    assert.deepEqual([msS.mode, msS.view, msS.t], ['cetnosti', 'riziko', [[56, 84], [20, 97]]]);
    assert.match(msS.verdict, /2,34násobkem rizika v referenční skupině „sportovní výkon“, šance je 3,23násobkem\. Poměr šancí není poměr rizik/);
    const msStats = await ms.locator('[data-stats]').innerText();
    for (const t of ['56/140 = 0,400', '20/117 = 0,171', '22,9 procentního bodu', 'přibližně 40 a 17', '0,400/0,171 = 2,34', '56/84 = 0,667', '20/97 = 0,206', '0,667/0,206 = 3,23']) assert(msStats.includes(t), `Measures show ${t}`);
    const msPhi = await ms.locator('[data-phi]').innerText();
    for (const t of ['257', '16,06', '0,25', '0,737 − 0,464 = 0,273', '0,229 × 0,273 = 0,0625']) assert(msPhi.includes(t), `Phi part shows ${t}`);
    assert.deepEqual(await ms.locator('[data-input] td[data-row-total], [data-input] td[data-col-total], [data-input] td[data-n]').allTextContents(), ['140', '117', '76', '181', '257']);
    const msLineRows = await ms.locator('table.viz-ms-lines tbody tr').evaluateAll(rows => rows.map(r => [...r.children].map(c => c.textContent)));
    assert.deepEqual(msLineRows[0], ['0,01', '0,239', '0,023', '0,032']); assert.deepEqual(msLineRows[4], ['0,50', '0,729', 'není možné', '0,764']);
    assert.match(await ms.locator('[data-dots] .viz-ms-group').first().textContent(), /Sexualizované fotografie: téma přítomno 56, celá skupina 140 osob\. Riziko 56\/140 = 0,400\./);
    // The odds view splits each field into persons with and without the event.
    const msBrackets = () => ms.locator('[data-dots] svg').first().locator('g path').count();
    assert.equal(await msBrackets(), 1, 'Risk view: one bracket over the whole group');
    await ms.locator('input[name="viz-ms-view"][value="sance"]').check();
    assert.equal(await msBrackets(), 2, 'Odds view: brackets over both parts');
    assert.match(await ms.locator('[data-dots] .viz-ms-group').nth(1).textContent(), /Sportovní výkon \(referenční skupina\): téma přítomno 20, téma nepřítomno 97\. Šance 20\/97 = 0,206\./);
    await ms.locator('input[name="viz-ms-view"][value="riziko"]').check();
    // Aspirin study: a rare event, both ratios almost equal, a small difference.
    await ms.locator('[data-preset="aspirin"]').click();
    msS = await msState();
    msNear(msS.result.rr, 1.81780179445, 'Aspirin risk ratio', 1e-9); msNear(msS.result.or, 1.83205394191, 'Aspirin odds ratio', 1e-9);
    assert.match(msS.verdict, /1,82násobkem.*1,83násobkem\. Jev je vzácný/); assert(!msS.dots.scaled && msS.dots.exact, 'Aspirin table drawn person by person');
    const msAsp = await ms.locator('[data-stats]').innerText();
    for (const t of ['0,77 procentního bodu', 'Kolik osob z 1 000', 'přibližně 17 a 9', '189/11 034 = 0,0171']) assert(msAsp.includes(t), `Aspirin measures show ${t}`);
    assert((await ms.locator('[data-phi]').innerText()).includes('0,03'), 'Aspirin phi');
    // Swapping the reference group inverts the ratios and the sign of phi.
    await ms.locator('[data-preset="daniels"]').click();
    await ms.locator('[data-swap]').click();
    msS = await msState();
    assert.deepEqual(msS.t, [[20, 97], [56, 84]]); msNear(msS.result.rr, 0.427350427350, 'Swapped risk ratio'); msNear(msS.result.or, 0.309278350515, 'Swapped odds ratio'); msNear(msS.result.phi, -0.249953830955, 'Swapped phi');
    assert.equal(await ms.locator('[data-input] th[data-row="1"]').textContent(), 'sexualizované fotografie (referenční skupina)');
    assert((await ms.locator('[data-stats]').innerText()).includes('−22,9 procentního bodu'), 'Negative difference with a true minus');
    await ms.locator('[data-swap]').click();
    // Table inputs: rejected values, an empty group, a zero cell and a very large table.
    const msInput = (j, l) => ms.locator(`[data-input] input[data-j="${j}"][data-l="${l}"]`);
    assert.equal(await msInput(1, 0).getAttribute('aria-label'), 'sportovní výkon, téma přítomno');
    for (const bad of ['', '-1', '1.5', '100001']) {
      await msInput(0, 0).fill(bad);
      assert.equal(await msInput(0, 0).getAttribute('aria-invalid'), 'true', `Rejected frequency "${bad}"`);
      assert.match(await ms.locator('#viz-ms-error').textContent(), /celé číslo od 0 do 100 000\. Používá se dál poslední platná hodnota\./);
      assert.equal((await msState()).t[0][0], 56, `Kept the frequency after "${bad}"`);
    }
    await msInput(0, 0).fill('56'); assert(!(await ms.locator('#viz-ms-error').isVisible()), 'Message hidden after a valid value');
    await msInput(1, 0).fill('0'); await msInput(1, 1).fill('0');
    assert.match(await ms.locator('#viz-ms-error').textContent(), /V každé skupině musí být alespoň jedna osoba/); assert.deepEqual((await msState()).t[1], [0, 97], 'Empty group not applied');
    await msInput(1, 1).fill('97');
    msS = await msState(); assert.equal(msS.result.rr, null); assert((await ms.locator('[data-stats]').innerText()).includes('nelze spočítat'), 'Zero reference risk: ratio cannot be computed');
    await msInput(1, 0).focus(); await page.keyboard.press('ArrowUp'); assert.equal((await msState()).t[1][0], 1, 'Arrow key raises the frequency by one');
    await msInput(0, 1).fill('30000');
    msS = await msState(); assert(msS.dots.scaled, 'Large table drawn per 10 000 persons'); assert.equal(msS.dots.g[0].n, 10000);
    // Two risks: equal groups, the measure held fixed and its limits.
    await ms.locator('[data-preset="daniels"]').click();
    await ms.locator('input[name="viz-ms-mode"][value="rizika"]').check();
    msS = await msState();
    assert.deepEqual([msS.mode, msS.size, msS.p1, msS.p0], ['rizika', 100, 0.4, 0.17]); msNear(msS.result.or, 3.254901960784, 'Odds ratio of two risks'); msNear(msS.result.phi, 0.254754808136, 'Phi of two equal groups');
    assert(!(await ms.locator('[data-input]').isVisible()) && await ms.locator('#viz-ms-p0').isVisible(), 'Sliders replace the table');
    await ms.locator('input[name="viz-ms-hold"][value="sance"]').check();
    await ms.locator('#viz-ms-p0').focus();
    await page.keyboard.press('Home'); msS = await msState();
    assert.equal(msS.p0, 0.01, 'Home sets the smallest reference risk'); msNear(msS.result.or, 3.254901960784, 'Odds ratio held at the lowest risk', 1e-9); msNear(msS.result.rr, 3.254901960784 / (0.99 + 3.254901960784 * 0.01), 'Risk ratio near the odds ratio', 1e-9);
    await page.keyboard.press('End'); msS = await msState();
    assert.equal(msS.p0, 0.99); msNear(msS.result.or, 3.254901960784, 'Odds ratio held at the highest risk', 1e-7); assert(!msS.limit, 'Equal odds ratio is always possible');
    const msSlide = (id, v) => ms.locator(`#viz-ms-${id}`).evaluate((el, x) => { el.value = String(x); el.dispatchEvent(new Event('input', {bubbles: true})); }, v);
    await msSlide('p0', 17); msNear((await msState()).p1, 0.4, 'Back on the line', 1e-9);
    await ms.locator('input[name="viz-ms-hold"][value="rizika"]').check();
    await msSlide('p0', 20); msS = await msState(); msNear(msS.p1, 0.2 * 0.4 / 0.17, 'Equal risk ratio', 1e-9); assert(!msS.limit);
    await msSlide('p0', 50); msS = await msState();
    assert(msS.limit && msS.p1 === 0.999, 'Equal risk ratio impossible above 1'); assert(await ms.locator('[data-limit]').isVisible()); assert.match(await ms.locator('[data-limit]').textContent(), /stejný poměr rizik není možný/);
    await msSlide('p0', 17); assert(!(await ms.locator('[data-limit]').isVisible()), 'Limit note hidden again');
    await ms.locator('input[name="viz-ms-hold"][value="rozdil"]').check();
    await msSlide('p0', 30); msNear((await msState()).p1, 0.53, 'Equal difference', 1e-9);
    await ms.locator('input[name="viz-ms-hold"][value="nic"]').check();
    await msSlide('p0', 10); msNear((await msState()).p1, 0.53, 'Nothing held: the compared risk stays', 1e-9);
    await ms.locator('input[name="viz-ms-size"][value="1000"]').check();
    assert.equal(await ms.locator('#viz-ms-p0').getAttribute('step'), '0.1', 'Tenths of a per cent for groups of 1 000');
    await msSlide('p1', 1.7); await msSlide('p0', 0.9); msS = await msState(); msNear(msS.result.rr, 1.88888888889, 'Rare event by sliders', 1e-9); msNear(msS.result.or, 1.90426133152, 'Rare event odds ratio', 1e-9);
    // Retrospective sample in the page: the slider by keyboard and the comparison table.
    await ms.locator('[data-preset="daniels"]').click();
    await ms.locator('#viz-ms-keep').focus(); await page.keyboard.press('Home');
    msS = await msState(); assert.equal(msS.keep, 0.1); msNear(msS.retro.ratio, 1.291304348, 'Ratio of proportions in the sample', 1e-9);
    const msRetro = await ms.locator('table.viz-ms-retro').innerText();
    for (const t of ['0,870', '0,673', '1,29', '2,34', '3,23', '10 % osob bez jevu']) assert(msRetro.includes(t), `Retrospective table shows ${t}`);
    await page.keyboard.press('End'); assert.equal((await msState()).keep, 1);
    // Full screen widens the chart and Escape closes it.
    const msFull = ms.locator(':scope > .viz-fullscreen-bar > button.viz-fullscreen');
    assert.equal(await msFull.count(), 1, 'One full-screen button');
    const msInline = await msPlots.first().evaluate(el => el.getBoundingClientRect().width);
    assert(msInline <= 561, `Inline chart width ${msInline}`);
    await ms.screenshot({path:'tmp/verification/viz-miry-souvislosti-desktop.png'});
    await msFull.click();
    await page.waitForFunction(w => document.querySelector('#viz-miry-souvislosti .viz-plots svg[aria-label]').getBoundingClientRect().width > w + 100, msInline);
    await page.screenshot({path:'tmp/verification/viz-miry-souvislosti-fullscreen.png'});
    await page.keyboard.press('Escape');
    if (await page.evaluate(() => !!document.fullscreenElement)) await page.evaluate(() => document.exitFullscreen());
    await page.waitForFunction(() => !document.fullscreenElement);
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await msPlots.first().waitFor();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Visualization of effect measures fits a phone');
    await ms.locator('[data-preset="aspirin"]').click();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Large fields of persons fit a phone');
    await ms.screenshot({path:'tmp/verification/viz-miry-souvislosti-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});

    // Wald and Wilson interval for a proportion: limits, exact coverage and its summary against R (scripts/viz-interval-podilu.R),
    // inputs and presets, the level slider, the selected π by keyboard and by clicking, the Wald bound, full screen and phone.
    await page.goto(base + 'quarto/kapitola_09.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#sec-wilson .callout-tip a[href$="viz_interval_podilu.html"]').count(), 1, 'Chapter 9 links to the visualization of the interval for a proportion');
    await page.goto(base + 'quarto/viz_interval_podilu.html', { waitUntil: 'networkidle' });
    const ip = page.locator('#viz-interval-podilu');
    const ipPlots = ip.locator('.viz-plots svg[aria-label]');
    await ipPlots.first().waitFor();
    assert.equal(await ipPlots.count(), 6, 'Six charts: intervals, derivation, coverage, Wald outside 0–1 and two bar charts');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    const ipState = () => ip.evaluate(el => el.vizCheck.state());
    const ipNear = (a, b, msg, tol = 1e-9) => assert(a !== null && Math.abs(a - b) <= tol, `${msg}: ${a} vs ${b}`);
    // R: [z, Wald se, lo, hi, Wilson midpoint, half-width, lo, hi]; the roots of the quadratic equal the Wilson limits.
    const ipLimits = [
      [[10, 20, .95], [1.959963984540, 0.111803398875, 0.280869364856, 0.719130635144, 0.5, 0.200701991802, 0.299298008198, 0.700701991802]],
      [[0, 15, .95], [1.959963984540, 0, 0, 0, 0.101941650518, 0.101941650518, 0, 0.203883301036]],
      [[1, 25, .95], [1.959963984540, 0.039191835885, -0.036814586822, 0.116814586822, 0.101268435432, 0.094172201930, 0.007096233502, 0.195440637362]],
      [[20, 20, .95], [1.959963984540, 0, 1, 1, 0.919437420974, 0.080562579026, 0.838874841947, 1]],
      [[0, 1, .95], [1.959963984540, 0, 0, 0, 0.396725342811, 0.396725342811, 0, 0.793450685623]],
      [[10, 20, .5], [0.674489750196, 0.111803398875, 0.424589753422, 0.575410246578, 0.5, 0.074566934911, 0.425433065089, 0.574566934911]],
      [[10, 20, .99], [2.575829303549, 0.111803398875, 0.212013528941, 0.787986471059, 0.5, 0.249552299678, 0.250447700322, 0.749552299678]],
      [[3, 200, .9], [1.644853626951, 0.008595056719, 0.000862389782, 0.029137610218, 0.021473372918, 0.015463145075, 0.006010227843, 0.036936517992]],
      [[199, 200, .99], [2.575829303549, 0.004987484336, 0.982153091697, 1.007846908303, 0.979105909159, 0.020306791079, 0.958799118080, 0.999412700238]]
    ];
    for (const [v, want] of ipLimits) {
      const g = await ip.evaluate((el, a) => { const c = el.vizCheck, W = c.wald(...a), S = c.wilson(...a), R = c.roots(...a); return [c.zq(a[2]), W.se, W.lo, W.hi, S.mid, S.half, S.lo, S.hi, R.lo, R.hi]; }, v);
      want.forEach((w, i) => ipNear(g[i], w, `${v[0]} z ${v[1]} at ${v[2]}: value ${i}`, 1e-10));
      ipNear(g[8], want[6], `${v[0]} z ${v[1]}: smaller root is the Wilson lower limit`, 1e-10); ipNear(g[9], want[7], `${v[0]} z ${v[1]}: larger root is the Wilson upper limit`, 1e-10);
    }
    // R: exact coverage of the Wald and Wilson intervals and the probability that the Wald interval leaves 0–1 or has zero width.
    const ipCover = [
      [[20, .95, .05], [0.638940137257, 0.924516326212, 0.984098473980]], [[20, .95, .10], [0.876037256000, 0.956825504716, 0.867046676566]],
      [[20, .95, .25], [0.894875150591, 0.934762207428, 0.225156077269]], [[20, .95, .5], [0.958610534668, 0.958610534668, 0.002576828003]],
      [[10, .95, .2], [0.886256435200, 0.967206502400, 0.677877452800]], [[50, .95, .02], [0.635352102699, 0.921572251649, 0.982241919302]],
      [[200, .95, .01], [0.865007767992, 0.948253736369, 0.858034034445]], [[15, .95, .1], [0.791859197820, 0.944444369992, 0.944444370333]],
      [[20, .8, .3], [0.779581732619, 0.779581732619, 0.007637261436]], [[20, .99, .3], [0.959378706166, 0.994063915802, 0.237513329131]],
      [[1, .95, .5], [0, 1, 1]], [[10, .5, .37], [0.485501553368, 0.485501553368, 0.009897388763]]
    ];
    for (const [v, want] of ipCover) {
      const g = await ip.evaluate((el, a) => el.vizCheck.coverage(...a), v);
      [g.wald, g.wilson, g.outside].forEach((x, i) => ipNear(x, want[i], `Coverage n = ${v[0]}, level ${v[1]}, π = ${v[2]}: value ${i}`, 1e-10));
    }
    // R: mean and share below the level over π = 0,001 … 0,999 and the lowest coverage including the points next to the limits.
    const ipSummary = [
      [[10, .95], [0.7698579134, 0.9542317222, 1, 0.4424424424, 0.009955000419, 0.8349535233]],
      [[20, .95], [0.8466783079, 0.9531739825, 0.9949949950, 0.4044044044, 0.019811130387, 0.8365889243]],
      [[200, .95], [0.9353491208, 0.9510079723, 0.7997997998, 0.4394394394, 0.112632740415, 0.8380214455]],
      [[20, .8], [0.7250935838, 0.8084449357, 0.7037037037, 0.4114114114, 0.019623400697, 0.7160879679]]
    ];
    for (const [v, want] of ipSummary) {
      const g = await ip.evaluate((el, a) => el.vizCheck.summary(...a), v);
      [g.meanWald, g.meanWilson, g.belowWald, g.belowWilson, g.infWald, g.infWilson].forEach((x, i) => ipNear(x, want[i], `Summary n = ${v[0]}, level ${v[1]}: value ${i}`, 1e-9));
    }
    // Default state: 10 z 20 at 95 % and π = 0,05; texts with substitution, bars and the Excel table.
    let ipS = await ipState();
    assert.deepEqual([ipS.k, ipS.n, ipS.level, ipS.pi, ipS.runs.wald, ipS.runs.wilson, ipS.inequality], [10, 20, 95, 0.05, [[1, 4]], [[0, 2]], false]);
    const ipText = sel => ip.locator(sel).innerText();
    for (const t of ['10/20 = 0,500', '1,9600', '0,1118', '(0,281; 0,719)', '(0,299; 0,701)', 'posun nenastal']) assert((await ipText('[data-stats=intervals]')).includes(t), `Intervals show ${t}`);
    for (const t of ['(0,500 − π)² ≤ 1,9600² · π(1 − π)/20', 'od 0,299 do 0,701', 'neplatí']) assert((await ipText('[data-stats=derivation]')).includes(t), `Derivation shows ${t}`);
    for (const t of ['63,9 %', '92,5 %', '98,4 %', '84,7 %', '95,3 %', '83,7 %', '99,5 %', '40,4 %']) assert((await ipText('[data-stats=coverage]')).includes(t), `Coverage shows ${t}`);
    const ipBars = await ipText('[data-bars]');
    for (const t of ['0,377 + 0,189 + 0,060 + 0,013 = 0,639', '0,358 + 0,377 + 0,189 = 0,925', 'k = 1 až 4', 'k = 0 až 2']) assert(ipBars.includes(t), `Bars show ${t}`);
    const ipExcel = await ip.locator('[data-excel] tbody tr').evaluateAll(rows => rows.map(r => [...r.children].map(c => c.textContent)));
    assert.deepEqual(ipExcel[4], ['B8', 'Kvantil z', '=NORM.S.INV(1-(1-B4)/2)', '1,9600']);
    assert.deepEqual(ipExcel[9], ['B14', 'Wilsonův interval: polovina šířky', '=B8/(1+B8^2/B3)*ODMOCNINA(B7*(1-B7)/B3+B8^2/(4*B3^2))', '0,201']);
    assert(!(await ip.locator('[data-warning]').isVisible()), 'No warning for 10 z 20');
    // Presets: zero width at 0 z 15 and a negative lower limit at 1 z 25; π stays and now lies inside the Wilson interval.
    await ip.locator('[data-preset="0,15"]').click();
    ipS = await ipState(); assert.deepEqual([ipS.k, ipS.n, ipS.level, ipS.inequality], [0, 15, 95, true]);
    assert.match(await ip.locator('[data-warning]').textContent(), /nulovou šířku.*přesně 0.*jen 15 pokusů/);
    await ip.locator('#viz-ip-waldbound').check();
    assert.match(await ipText('[data-stats=derivation]'), /Waldův interval v grafu nerovnice[\s\S]*= 0 a nezávisí na π[\s\S]*dotkne jen v bodě 0/);
    await ip.locator('[data-preset="1,25"]').click();
    assert.match(await ip.locator('[data-warning]').textContent(), /Dolní mez Waldova intervalu −0,037 leží pod nulou/);
    assert((await ipText('[data-stats=intervals]')).includes('pod p sahá o 0,033, nad p o 0,155'), 'Asymmetric Wilson interval around p');
    await ip.locator('#viz-ip-waldbound').uncheck();
    // Whole-number fields: rejected values keep the last valid one; lowering n lowers k.
    await ip.locator('[data-preset="10,20"]').click();
    for (const bad of ['0', '201', '2.5', '-1']) {
      await ip.locator('#viz-ip-n').fill(bad);
      assert.equal(await ip.locator('#viz-ip-n').getAttribute('aria-invalid'), 'true', `Rejected n "${bad}"`);
      assert.match(await ip.locator('#viz-ip-n-error').textContent(), /celé číslo od 1 do 200\. Používá se dál poslední platná hodnota\./);
      assert.equal((await ipState()).n, 20, `Kept n after "${bad}"`);
    }
    await ip.locator('#viz-ip-n').fill('20');
    await ip.locator('#viz-ip-k').fill('21');
    assert.match(await ip.locator('#viz-ip-k-error').textContent(), /od 0 do 20/); assert.equal((await ipState()).k, 10, 'Kept k above n');
    await ip.locator('#viz-ip-k').fill('10');
    await ip.locator('#viz-ip-n').fill('8');
    ipS = await ipState(); assert.deepEqual([ipS.k, ipS.n], [8, 8], 'k lowered to n');
    assert.match(await ip.locator('[data-clamp]').textContent(), /snížen na n = 8/);
    assert.equal(await ip.locator('#viz-ip-k').getAttribute('max'), '8');
    // Level slider by keyboard and by value; the coverage depends on n and the level only.
    await ip.locator('[data-preset="10,20"]').click();
    const ipCov0 = (await ipState()).summary;
    await ip.locator('#viz-ip-k').fill('3');
    assert.deepEqual((await ipState()).summary, ipCov0, 'Coverage does not depend on the observed count');
    await ip.locator('#viz-ip-level').focus();
    await page.keyboard.press('End'); assert.equal((await ipState()).level, 99);
    await page.keyboard.press('Home'); assert.equal((await ipState()).level, 50);
    await ip.locator('#viz-ip-level').evaluate(el => { el.value = '80'; el.dispatchEvent(new Event('input', {bubbles: true})); });
    ipS = await ipState(); assert.equal(ipS.level, 80); ipNear(ipS.summary.meanWilson, 0.8084449357, 'Mean Wilson coverage at 80 %');
    assert.equal(await ip.locator('#viz-ip-cov-title').textContent(), 'Pokrytí obou postupů pro n = 20 a hladinu 80 %');
    assert.equal(await ip.locator('#viz-ip-level-value').textContent(), '80 %');
    // Selected π: arrows by 0,01, with Shift by 0,001, Page Up by 0,1, Home and End; clicking in the coverage chart.
    await ip.locator('[data-preset="10,20"]').click();
    await ip.locator('#viz-ip-pi').focus();
    await page.keyboard.press('ArrowRight'); ipNear((await ipState()).pi, 0.06, 'Arrow moves π by 0,01', 1e-12);
    await page.keyboard.press('Shift+ArrowRight'); ipNear((await ipState()).pi, 0.061, 'Shift+Arrow moves π by 0,001', 1e-12);
    await page.keyboard.press('PageUp'); ipNear((await ipState()).pi, 0.161, 'Page Up moves π by 0,1', 1e-12);
    await page.keyboard.press('Home'); ipNear((await ipState()).pi, 0.001, 'Home sets the smallest π', 1e-12);
    await page.keyboard.press('End'); ipNear((await ipState()).pi, 0.999, 'End sets the largest π', 1e-12);
    const ipBox = await ip.locator('[data-chart=coverage] svg').boundingBox();
    await page.mouse.click(ipBox.x + ipBox.width / 2, ipBox.y + ipBox.height / 2);
    ipS = await ipState(); assert(ipS.pi > 0.4 && ipS.pi < 0.6, `Click selects π near the middle: ${ipS.pi}`);
    ipNear(ipS.cover.wald, (await ip.evaluate((el, p) => el.vizCheck.coverage(20, 0.95, p), ipS.pi)).wald, 'Marker coverage', 1e-15);
    await ip.locator('#viz-ip-zoom').check(); assert((await ipState()).zoom, 'Zoom on');
    await ip.locator('#viz-ip-zoom').uncheck();
    // Large n: the bar charts show a window around the most probable counts.
    await ip.locator('#viz-ip-n').fill('200'); await ip.locator('#viz-ip-k').fill('3');
    await ip.locator('#viz-ip-pi').evaluate(el => { el.value = '0.01'; el.dispatchEvent(new Event('input', {bubbles: true})); });
    ipS = await ipState(); assert(ipS.window[0] === 0 && ipS.window[1] < 200, `Window of counts ${ipS.window}`);
    ipNear(ipS.cover.wald, 0.865007767992, 'Wald coverage at n = 200, π = 0,01', 1e-10);
    assert.match(await ipText('[data-bars]'), /Grafy ukazují počty od 0 do \d+\. Všechny ostatní počty od 0 do 200/);
    // Full screen widens the charts and Escape closes it.
    await ip.locator('[data-preset="10,20"]').click();
    const ipFull = ip.locator(':scope > .viz-fullscreen-bar > button.viz-fullscreen');
    assert.equal(await ipFull.count(), 1, 'One full-screen button');
    const ipInline = await ipPlots.first().evaluate(el => el.getBoundingClientRect().width);
    assert(ipInline <= 781, `Inline chart width ${ipInline}`);
    await ip.screenshot({path:'tmp/verification/viz-interval-podilu-desktop.png'});
    await ipFull.click();
    await page.waitForFunction(w => document.querySelector('#viz-interval-podilu .viz-plots svg[aria-label]').getBoundingClientRect().width > w + 100, ipInline);
    await page.screenshot({path:'tmp/verification/viz-interval-podilu-fullscreen.png'});
    await page.keyboard.press('Escape');
    if (await page.evaluate(() => !!document.fullscreenElement)) await page.evaluate(() => document.exitFullscreen());
    await page.waitForFunction(() => !document.fullscreenElement);
    await page.setViewportSize({width:375,height:812});
    await page.reload({ waitUntil: 'networkidle' });
    await ipPlots.first().waitFor();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Visualization of the interval for a proportion fits a phone');
    await ip.locator('[data-preset="1,25"]').click();
    assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1), 'Wald interval below 0 fits a phone');
    await ip.screenshot({path:'tmp/verification/viz-interval-podilu-mobile.png'});
    await page.setViewportSize({width:1360,height:1000});

    // Correlation in a scatterplot: values against R (scripts/viz-korelace.R), data sets, slider and fields with invalid input,
    // dragging, adding and deleting points with the mouse and the keyboard, display options, derived charts, full screen and phone.
    await page.goto(base + 'quarto/kapitola_10.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#sec-pearsonovo-r .callout-tip a[href$="viz_korelace.html"]').count(), 1, 'Chapter 10 links to the correlation visualization from the Pearson section');
    assert.equal(await page.locator('#sec-odlehle-korelace .callout-tip a[href$="viz_korelace.html"]').count(), 1, 'Chapter 10 links to the correlation visualization from the outlier section');
    await page.goto(base + 'quarto/viz_korelace.html', { waitUntil: 'networkidle' });
    const kor = page.locator('#viz-korelace');
    const korPoints = kor.locator('.viz-kor-svg circle');
    await korPoints.first().waitFor();
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Visualization code, copy button or OJS error visible');
    assert(await page.locator('a[href*="ref-magnussonCorrelation"]').count() > 0, 'The page cites the web app that inspired it');
    const korState = () => kor.evaluate(el => el.vizCheck.state());
    const korNear = (a, b, msg, tol = 1e-9) => assert(a !== null && a !== undefined && Math.abs(a - b) <= tol * Math.max(1, Math.abs(b)), `${msg}: ${a} vs ${b}`);
    const korStats = (xs, ys) => kor.evaluate((el, v) => el.vizCheck.stats(v[0], v[1]), [xs, ys]);
    const uzX = [26,20,33,28,23,33,37,11,21,22,24,20,16,25,29,20,20,26,19,19,26,29,19,28,21,29,23,19,23,14,19,37,24,27,19,27,23,23,22,19];
    const uzY = [16,22,14,20,16,15,15,21,21,25,26,17,17,17,16,19,24,24,20,27,25,19,24,15,22,8,21,19,15,23,23,12,15,22,19,7,18,18,19,30];
    const k8X = [58,44,51,39,62,47,55,42,49,60,45,52], k8Y = [53,42,45,38,55,44,51,43,44,58,39,50];
    const uzOut = uzY.slice(); uzOut[0] = 300;
    // R: stats() in scripts/viz-korelace.R (lm, cor.test and Spearman checked there independently).
    const korWant = [
      ['anxiety', uzX, uzY, {mx: 23.575, my: 19.15, sx: 5.62452277178, sy: 4.83867962494, sxy: -14.2423076923, r: -0.523320583278, rs: -0.554952396894, r2: 0.273864432883,
        b0: 29.7635508906, b1: -0.45020364329, ssres: 663.034386335, sstot: 913.1, t: -3.78573979459, p: 5.30289231186e-4, zr: -0.580901821376, se: 0.164398987305, zlo: -0.903117915589, zhi: -0.258685727162, lo: -0.717812649479, hi: -0.25306583857, pos: 15, neg: 25}],
      ['sleep', k8X, k8Y, {r: 0.948193730452, rs: 0.963223893965, b0: 5.07761529809, b1: 0.829583802025, t: 9.43821460967, p: 2.69332796258e-06, lo: 0.821122005495, hi: 0.985704573398}],
      ['fixed points', [1, 2, 3, 4, 5, 6], [2, 1, 4, 3, 7, 5], {sxy: 3.2, r: 0.7917946548886, rs: 0.8285714285714, b0: 0.4666666666667, b1: 0.9142857142857, ssres: 8.7047619047619, t: 2.5927014206142, p: 0.0605114033628, lo: -0.0553051596733, hi: 0.9761145801153}],
      ['Anscombe IV', [8, 8, 8, 8, 8, 8, 8, 19, 8, 8, 8], [6.58, 5.76, 7.71, 8.84, 8.47, 7.04, 5.25, 12.5, 5.56, 7.91, 6.89], {r: 0.8165214368885, rs: 0.5, b0: 3.0017272727273, b1: 0.4999090909091, p: 0.0021646023472}],
      ['typing error 300', uzX, uzOut, {r: 0.0136038343546, rs: -0.489555653204}]
    ];
    for (const [name, xs, ys, want] of korWant) { const got = await korStats(xs, ys); for (const [k, v] of Object.entries(want)) korNear(got[k], v, `${name}: ${k}`, ['pos', 'neg'].includes(k) ? 0 : 1e-9); }
    // Values that cannot be computed: no variability in X, three points on a line.
    const korFlat = await korStats([5, 5, 5, 5], [1, 2, 3, 4]);
    assert.deepEqual([korFlat.r, korFlat.rs, korFlat.t, korFlat.lo], [null, null, null, null], 'No variability in X gives no correlation');
    const korLine = await korStats([1, 2, 3, 4], [2, 4, 6, 8]);
    korNear(korLine.r, 1, 'Points on a line'); assert.deepEqual([korLine.t, korLine.lo], [null, null], 'No test or interval for r = 1');
    assert.deepEqual(await kor.evaluate(el => el.vizCheck.ranks([3, 1, 3, 2])), [3.5, 1, 3.5, 2], 'Average ranks for ties');
    // R: exact sample r with X, the mean and the SD of Y unchanged.
    for (const [target, first, rs] of [[0.3, [17.4717029142, 19.6160719648, 20.5672810527], 0.2930700707], [-0.8, [16.0318065333, 22.4838762318, 12.0249571511], -0.7941831283]]) {
      const ys = await kor.evaluate((el, v) => el.vizCheck.toR(v[0], v[1], v[2]), [uzX, uzY, target]);
      const s = await korStats(uzX, ys);
      korNear(s.r, target, `Transformed r ${target}`, 1e-12); korNear(s.my, 19.15, 'Mean of Y kept', 1e-12); korNear(s.sy, 4.83867962494, 'SD of Y kept', 1e-10);
      first.forEach((v, i) => korNear(ys[i], v, `Transformed y${i + 1} for r ${target}`, 1e-9)); korNear(s.rs, rs, `Spearman after transformation to ${target}`, 1e-9);
    }
    // R: radii sqrt(qchisq(p, 2)) of the ellipses and the distance of the circles of the Venn diagram.
    const korRad = await kor.evaluate(el => [0.5, 0.8, 0.95, 0.99].map(el.vizCheck.radius));
    [1.17741002252, 1.79412257799, 2.44774683068, 3.03485425877].forEach((v, i) => korNear(korRad[i], v, `Ellipse radius ${i}`, 1e-10));
    const korVenn = await kor.evaluate(el => [0.1, 0.2738645, 0.5, 0.9].map(el.vizCheck.vennDistance));
    [1.61076727304, 1.22149665863, 0.807945506599, 0.157241774836].forEach((v, i) => korNear(korVenn[i], v, `Venn distance ${i}`, 1e-9));

    // Default state: data of the chapter, nothing extra shown except the Venn diagram, substitution in the overview.
    let korS = await korState();
    assert.deepEqual([korS.preset, korS.mode, korS.show, korS.xs.length], ['uzkost', 'move', {quad: false, ell: false, axes: false, reg: false, res: false, venn: true}, 40]);
    assert.equal(await korPoints.count(), 40, 'Forty points');
    const korText = () => kor.locator('[data-stats]').innerText();
    for (const t of ['mx = 23,58; my = 19,15', 'sx = 5,62; sy = 4,84', '−555,45 / 39 = −14,24', '−14,24 / (5,62 · 4,84) = −0,523', '−0,555', 't = −3,79 s 38 stupni volnosti; oboustranná p-hodnota 0,0005', 'zr = −0,581; směrodatná chyba 1/√(n − 3) = 1/√37 = 0,164; na stupnici zr: −0,581 ± 1,96 · 0,164 = (−0,903; −0,259); po převodu zpět na korelace (−0,72; −0,25)', '0,274 (27,4 %)'])
      assert((await korText()).includes(t), `Overview shows ${t}`);
    assert.match(await kor.locator('[data-summary]').innerText(), /Pearsonovo r = −0,523, Spearmanův rs = −0,555, n = 40/);
    assert.equal(await kor.locator('[data-venn] svg[role="img"]').count(), 1, 'Venn diagram shown');
    assert.match(await kor.locator('[data-venn] svg').getAttribute('aria-label'), /r² = 0,274, tedy 27,4 %/);
    assert.equal(await kor.locator('[data-ranks] svg').count(), 1, 'Chart of ranks');
    assert.equal(await kor.locator('[data-slope] svg').count(), 1, 'Slope chart');
    assert.match(await kor.locator('[data-rank-title]').innerText(), /rs = −0,555/);
    assert.match(await kor.locator('[data-slope-note]').innerText(), /průměry 23,58 a 19,15 \(rozdíl průměrů Y − X je −4,43\)/);
    assert.equal(await kor.locator('.viz-kor-svg path[stroke="#B54E24"], .viz-kor-svg line[stroke="#223744"]').count(), 0, 'No residuals or regression line by default');
    // Layout: square drawing areas, the Venn diagram under the main chart, the slope chart under the chart of ranks;
    // the main chart takes the full width of the content; both axes span the same number of SDs (R: K = 2,711897).
    const korRect = sel => kor.locator(sel).first().evaluate(el => { const b = el.getBoundingClientRect(); return {w: b.width, h: b.height, top: b.top, bottom: b.bottom}; });
    const korMain = await korRect('.viz-kor-svg'), korBoxW = await kor.locator('[data-plot]').evaluate(el => el.clientWidth);
    assert(Math.abs((korMain.w - 68) - (korMain.h - 56)) < 1.5, `Square drawing area of the main chart: ${korMain.w} × ${korMain.h}`);
    assert(Math.abs(korMain.w - Math.min(korBoxW, 780)) < 2, `Main chart over the full width: ${korMain.w} of ${korBoxW}`);
    assert((await korRect('[data-venn] svg')).top >= korMain.bottom, 'Venn diagram under the main chart');
    const korRanks = await korRect('[data-ranks] svg'), korSlope = await korRect('[data-slope] svg');
    assert(Math.abs((korRanks.w - 60) - (korRanks.h - 56)) < 1.5, `Square drawing area of the chart of ranks: ${korRanks.w} × ${korRanks.h}`);
    assert(korSlope.top >= korRanks.bottom, 'Slope chart under the chart of ranks');
    korS = await korState();
    korNear((korS.dom.x[1] - 23.575) / 5.62452277178, 2.711897, 'Axis X in SDs', 1e-6); korNear((korS.dom.y[1] - 19.15) / 4.83867962494, 2.711897, 'Axis Y in SDs', 1e-6);
    // Display options: quadrants, regression line, residuals, ellipses with counts from R, Venn diagram off.
    await kor.locator('[data-show="quad"]').check();
    assert((await korText()).includes('kladných 15, záporných 25; součet −555,45'), 'Products of deviations');
    assert.equal(await kor.locator('.viz-kor-svg circle[fill="#B54E24"]').count(), 25, 'Twenty-five orange points with a negative product');
    await kor.locator('[data-show="reg"]').check(); await kor.locator('[data-show="res"]').check();
    for (const t of ['ŷ = 29,76 − 0,450 x', 'b1 = −0,523 · 4,84 / 5,62 = −0,450', 'b0 = 19,15 − (−0,450) · 23,58 = 29,76', '663,03 = (1 − 0,274) · 913,10']) assert((await korText()).includes(t), `Regression overview shows ${t}`);
    assert.equal(await kor.locator('.viz-kor-svg line[stroke="#223744"]').count(), 1, 'Regression line drawn');
    await kor.locator('[data-show="ell"]').check();
    korS = await korState(); assert.deepEqual(korS.counts, [24, 33, 39, 40], 'Points inside the ellipses as in R');
    assert.equal(await kor.locator('.viz-kor-svg path[stroke="#245D78"]').count(), 4, 'Four ellipses');
    assert(korS.dom.x[0] <= 23.575 - 3.03485425877 * 5.62452277178 && korS.dom.y[1] >= 19.15 + 3.03485425877 * 4.83867962494, 'Axes widened for the 99% ellipse');
    // Length (green) and width (orange) of the ellipse: end points on the 99% ellipse as in R (eigen of the correlation matrix).
    await kor.locator('[data-show="axes"]').check();
    assert.equal(await kor.locator('.viz-kor-svg line.viz-kor-length[stroke="#3E7B4F"]').count(), 1, 'Green length of the ellipse');
    assert.equal(await kor.locator('.viz-kor-svg line.viz-kor-width[stroke="#B54E24"]').count(), 1, 'Orange width of the ellipse');
    const korAx = await kor.evaluate(el => el.vizCheck.axes());
    korNear(korAx.halfLength, 3.74570434867, 'Half length'); korNear(korAx.halfWidth, 2.09532328683, 'Half width'); korNear(korAx.ratio, 1.78764984488, 'Ratio of length and width');
    const korEnds = [[korAx.length, [[8.67781617574, 31.9657894926], [38.47218382426, 6.3342105074]]], [korAx.width, [[15.2416097296, 11.9809285349], [31.9083902704, 26.3190714651]]]];
    for (const [got, want] of korEnds) { const g = [...got].sort((a, b) => a[0] - b[0]); g.forEach((p, i) => p.forEach((v, j) => korNear(v, want[i][j], `Ellipse end point ${i}${j}`, 1e-9))); }
    for (const t of ['délka 2 · 3,03 · √(1 + 0,523) = 7,49', 'šířka 2 · 3,03 · √(1 − 0,523) = 4,19', 'poměr délky a šířky 1,79']) assert((await korText()).includes(t), `Overview shows ${t}`);
    await kor.locator('[data-show="axes"]').uncheck();
    await kor.locator('[data-show="venn"]').uncheck();
    assert(await kor.locator('[data-venn]').isHidden(), 'Venn diagram hidden');
    // Data sets: Anscombe I (ellipse counts from R) and the sleep data with their slope chart.
    await kor.locator('[data-preset="anscombe1"]').click();
    korS = await korState(); korNear(korS.stats.r, 0.81642051634484, 'Anscombe I r'); assert.deepEqual(korS.counts, [4, 9, 11, 11], 'Anscombe I inside the ellipses');
    assert.equal(await kor.locator('[data-preset="anscombe1"]').getAttribute('aria-pressed'), 'true');
    await kor.locator('[data-preset="spanek"]').click();
    korS = await korState(); korNear(korS.stats.r, 0.948193730452, 'Sleep r'); assert.equal(korS.xs.length, 12);
    assert.match(await kor.locator('[data-slope-note]').innerText(), /rozdíl průměrů Y − X je −3,50/);
    for (const k of ['quad', 'reg', 'res', 'ell']) await kor.locator(`[data-show="${k}"]`).uncheck();
    await kor.locator('[data-show="venn"]').check();

    // Slider and the number field: exact r, X and the mean and SD of Y unchanged; invalid values rejected.
    await kor.locator('[data-preset="uzkost"]').click();
    await kor.locator('#viz-kor-slider').evaluate(el => { el.value = '-0.8'; el.dispatchEvent(new Event('input', {bubbles: true})); });
    korS = await korState(); korNear(korS.stats.r, -0.8, 'Slider r', 1e-12); assert.deepEqual(korS.xs, uzX, 'Slider keeps X');
    [16.0318065333, 22.4838762318, 12.0249571511].forEach((v, i) => korNear(korS.ys[i], v, `Slider y${i + 1}`, 1e-9));
    korNear(korS.stats.sy, 4.83867962494, 'Slider keeps SD of Y', 1e-10); assert.equal(korS.preset, null, 'Changed data are no longer the preset');
    await kor.locator('#viz-kor-slider').focus(); await page.keyboard.press('ArrowRight');
    korNear((await korState()).stats.r, -0.79, 'Slider by keyboard', 1e-12);
    await kor.locator('#viz-kor-r').fill('0,3'); await kor.locator('#viz-kor-r').press('Tab');
    korNear((await korState()).stats.r, 0.3, 'Correlation typed with a comma', 1e-12);
    await kor.locator('#viz-kor-r').fill('1,5'); await kor.locator('#viz-kor-r').press('Tab');
    assert.match(await kor.locator('#viz-kor-error').innerText(), /Korelace musí být číslo od −1 do 1\. Používá se dál poslední platná hodnota\./);
    assert.equal(await kor.locator('#viz-kor-r').getAttribute('aria-invalid'), 'true'); korNear((await korState()).stats.r, 0.3, 'Invalid correlation ignored', 1e-12);
    // Means and SDs: shift and change of units keep r.
    await kor.locator('#viz-kor-mx').fill('50'); await kor.locator('#viz-kor-mx').press('Tab');
    korS = await korState(); korNear(korS.stats.mx, 50, 'Mean of X set', 1e-12); korNear(korS.stats.r, 0.3, 'Shift keeps r', 1e-12);
    assert(!(await kor.locator('#viz-kor-error').isVisible()), 'Message hidden after a valid value');
    await kor.locator('#viz-kor-sy').fill('-2'); await kor.locator('#viz-kor-sy').press('Tab');
    assert.match(await kor.locator('#viz-kor-error').innerText(), /Směrodatná odchylka musí být kladné číslo/);
    await kor.locator('#viz-kor-sy').fill('10'); await kor.locator('#viz-kor-sy').press('Tab');
    korS = await korState(); korNear(korS.stats.sy, 10, 'SD of Y set', 1e-12); korNear(korS.stats.r, 0.3, 'Change of units keeps r', 1e-12);
    // New random sample: size checked, exact r, means and SDs.
    await kor.locator('#viz-kor-n').fill('2'); await kor.locator('[data-new]').click();
    assert.match(await kor.locator('#viz-kor-error').innerText(), /Počet bodů musí být celé číslo od 4 do 1 000/);
    await kor.locator('#viz-kor-n').fill('1000'); await kor.locator('[data-new]').click();
    korS = await korState(); assert.equal(korS.xs.length, 1000); korNear(korS.stats.r, 0.3, 'New sample r', 1e-12);
    korNear(korS.stats.mx, 50, 'New sample mean of X', 1e-10); korNear(korS.stats.sy, 10, 'New sample SD of Y', 1e-10); assert.equal(korS.names.x, 'Proměnná X');
    await kor.locator('[data-show="ell"]').check();
    korS = await korState(); [500, 800, 950, 990].forEach((v, i) => assert(Math.abs(korS.counts[i] - v) < 60, `Share inside the ellipse ${i} near the model: ${korS.counts[i]}`));
    await kor.locator('[data-show="ell"]').uncheck();

    // Points by mouse only (no form): the pointer line, adding at (38; 31) as in exercise 2 (R: r −0,316436, rs −0,443080),
    // deleting with the marked point, adding by keyboard, moving by keyboard, dragging.
    await kor.locator('[data-preset="uzkost"]').click();
    assert.equal(await kor.locator('#viz-kor-ax, #viz-kor-ay, [data-add]').count(), 0, 'No form for new points');
    const korAdd = await korStats([...uzX, 38], [...uzY, 31]);
    korNear(korAdd.r, -0.316435666812, 'R: point (38; 31) added'); korNear(korAdd.rs, -0.443080206407, 'R: Spearman with the added point');
    await kor.locator('.viz-kor-svg').scrollIntoViewIfNeeded();
    const korPx = (vx, vy) => kor.evaluate((el, v) => el.vizCheck.pixel(v[0], v[1]), [vx, vy]);
    await page.mouse.move(...await korPx(30, 20));
    const korPointer = (await kor.locator('[data-pointer]').innerText()).match(/^Ukazatel: X = (\S+); Y = (\S+)$/);
    assert(korPointer && Math.abs(Number(korPointer[1].replace(',', '.')) - 30) <= 0.15 && Math.abs(Number(korPointer[2].replace(',', '.')) - 20) <= 0.15, `Pointer line: ${korPointer}`);
    await kor.locator('input[name="viz-kor-mode"][value="add"]').check();
    await page.mouse.click(...await korPx(38, 31));
    korS = await korState(); assert.equal(korS.xs.length, 41, 'Point added by a click');
    assert(Math.abs(korS.xs[40] - 38) < 0.15 && Math.abs(korS.ys[40] - 31) < 0.15, `Added point at the click: ${korS.xs[40]}, ${korS.ys[40]}`);
    korNear(korS.stats.r, -0.316435666812, 'r with the clicked point', 0.01); korNear(korS.stats.rs, -0.443080206407, 'Spearman with the clicked point', 1e-9);
    assert.match(await kor.locator('[data-live]').innerText(), /Vybraný bod č\. 41 \(bodů celkem 41\)/);
    const korCenter = async i => { await korPoints.nth(i).scrollIntoViewIfNeeded(); const b = await korPoints.nth(i).boundingBox(); return [b.x + b.width / 2, b.y + b.height / 2]; };
    await kor.locator('input[name="viz-kor-mode"][value="delete"]').check();
    await page.mouse.move(...await korCenter(40));
    assert.equal(await kor.locator('.viz-kor-svg circle.viz-kor-hover').count(), 1, 'Point to be deleted is marked');
    await page.mouse.click(...await korCenter(40));
    korS = await korState(); assert.equal(korS.xs.length, 40); korNear(korS.stats.r, -0.523320583278, 'Added point deleted by mouse');
    await kor.locator('input[name="viz-kor-mode"][value="add"]').check();
    await kor.locator('.viz-kor-svg').scrollIntoViewIfNeeded(); const korBox = await kor.locator('.viz-kor-svg').boundingBox();
    await page.mouse.click(korBox.x + korBox.width / 2, korBox.y + korBox.height / 2);
    assert.equal((await korState()).xs.length, 41, 'Point added by mouse');
    await kor.locator('.viz-kor-svg').focus(); await page.keyboard.press('Delete');
    assert.equal((await korState()).xs.length, 40, 'Point deleted by keyboard');
    await page.keyboard.press('Enter'); assert.equal((await korState()).xs.length, 41, 'Point added by Enter in the add mode');
    await page.keyboard.press('Delete');
    await kor.locator('input[name="viz-kor-mode"][value="move"]').check();
    await kor.locator('.viz-kor-svg').focus(); await page.keyboard.press('Space');
    korS = await korState(); assert.equal(korS.active, 0, 'Space selects the next point');
    await page.keyboard.press('ArrowUp');
    let korS2 = await korState(); korNear(korS2.ys[0], 16 + (korS.dom.y[1] - korS.dom.y[0]) / 50, 'Arrow moves the point up'); assert.equal(korS2.xs[0], 26);
    await page.keyboard.press('Shift+ArrowRight'); korNear((await korState()).xs[0], 26 + (korS.dom.x[1] - korS.dom.x[0]) / 10, 'Shift and arrow move further');
    assert.match(await kor.locator('[data-live]').innerText(), /Vybraný bod č\. 1 \(bodů celkem 40\)/);
    for (let i = 0; i < 3 * 40; i++) await page.keyboard.press('Delete');
    assert.equal((await korState()).xs.length, 3, 'At least three points stay');
    assert.match(await kor.locator('#viz-kor-error').innerText(), /V grafu musí zůstat alespoň 3 body/);
    await kor.locator('[data-preset="uzkost"]').click();
    const [dx, dy] = await korCenter(7);
    await page.mouse.move(dx, dy); await page.mouse.down(); await page.mouse.move(dx + 120, dy - 60, {steps: 6}); await page.mouse.up();
    korS = await korState(); assert(korS.xs[7] > 11 + 3 && korS.ys[7] > 21 + 1, `Point dragged: ${korS.xs[7]}, ${korS.ys[7]}`);
    assert.match(await kor.locator('[data-pointer]').innerText(), /^Tažený bod: X = /);
    assert(Math.abs(korS.stats.r + 0.523320583278) > 0.01, 'Dragging changes r'); assert.equal(korS.preset, null);
    korNear(Number((await kor.locator('#viz-kor-slider').inputValue())), Math.round(korS.stats.r * 100) / 100, 'Slider follows the dragged data', 1e-12);
    // Full screen widens the chart and Escape closes it.
    await kor.locator('[data-preset="uzkost"]').click();
    const korFull = kor.locator(':scope > .viz-fullscreen-bar > button.viz-fullscreen');
    assert.equal(await korFull.count(), 1, 'One full-screen button');
    const korInline = await kor.locator('.viz-kor-svg').evaluate(el => el.getBoundingClientRect().width);
    await kor.screenshot({path: 'tmp/verification/viz-korelace-desktop.png'});
    await korFull.click();
    await page.waitForFunction(w => document.querySelector('#viz-korelace .viz-kor-svg').getBoundingClientRect().width > w + 100, korInline);
    await page.screenshot({path: 'tmp/verification/viz-korelace-fullscreen.png'});
    await page.keyboard.press('Escape');
    if (await page.evaluate(() => !!document.fullscreenElement)) await page.evaluate(() => document.exitFullscreen());
    await page.waitForFunction(() => !document.fullscreenElement);
    await page.setViewportSize({width: 375, height: 812});
    await page.reload({waitUntil: 'networkidle'});
    await korPoints.first().waitFor();
    for (const k of ['quad', 'ell', 'axes', 'reg', 'res']) await kor.locator(`[data-show="${k}"]`).check();
    assert(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth + 1), 'Correlation visualization fits a phone');
    await kor.screenshot({path: 'tmp/verification/viz-korelace-mobile.png'});
    await page.setViewportSize({width: 1360, height: 1000});

    // Statistical app: test of one proportion (part "Statistické aplikace"). Calculations against R
    // (scripts/app-jeden-podil.R; the full grid is checked by node scripts/check-stat-lib.mjs), labels taken from the inputs,
    // escaping of user text, presets, rejected inputs, the interval choice for one-sided alternatives, large n and phone.
    await page.goto(base + 'quarto/kapitola_06.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#sec-binomicky-test .callout-tip a[href$="app_jeden_podil.html"]').count(), 1, 'Chapter 6 links to the one-proportion app');
    assert.equal(await page.locator('#quarto-sidebar .sidebar-item-section').nth(2).locator('ul.sidebar-section').isVisible(), false, 'Statistical apps collapsed on a chapter page');
    await page.goto(base + 'quarto/kapitola_09.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#sec-interval-a-test-podilu .callout-tip a[href$="app_jeden_podil.html"]').count(), 1, 'Chapter 9 links to the one-proportion app');
    await page.goto(base + 'quarto/app_jeden_podil.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#quarto-sidebar .sidebar-item-section').nth(2).locator('ul.sidebar-section').isVisible(), true, 'Statistical apps open on their own page');
    assert.equal(await page.locator('#quarto-sidebar .sidebar-item-section').nth(2).locator('a.sidebar-link.active').count(), 1, 'Current app marked in the sidebar');
    assert.equal(await page.locator('#quarto-sidebar .sidebar-item-section').nth(1).locator('ul.sidebar-section').isVisible(), false, 'Visualizations stay collapsed on an app page');
    const app = page.locator('#app-jeden-podil');
    const appPlots = app.locator('.viz-plots svg[aria-label]');
    await appPlots.first().waitFor();
    assert.equal(await appPlots.count(), 3, 'Three charts: counts, distribution under H0, interval');
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'App code, copy button or OJS error visible');
    assert.equal(await app.locator('.viz-fullscreen').count(), 1, 'App has the full-screen button');
    const appNear = (a, b, msg, tol = 1e-9) => assert(Number.isFinite(a) && Math.abs(a - b) <= tol * Math.max(1, Math.abs(b)), `${msg}: ${a} vs ${b}`);
    // R: [k, n, pi0, alt] -> [z, score p-value, exact p-value, Wilson 95 % lo, hi, Wilson 90 % lo, hi, one-sided 95 % lower, upper limit].
    const APP_REF = [
    [[10, 20, 0.25, "two"], [2.58198889747161, 0.00982327450751926, 0.0170356288826952, 0.299298008198212, 0.700701991801788, 0.327403767885156, 0.672596232114844, 0.327403767885156, 0.672596232114844]],
    [[10, 20, 0.25, "greater"], [2.58198889747161, 0.00491163725375962, 0.0138644169437612, 0.299298008198212, 0.700701991801788, 0.327403767885156, 0.672596232114844, 0.327403767885156, 0.672596232114844]],
    [[10, 20, 0.25, "less"], [2.58198889747161, 0.99508836274624, 0.996057858335917, 0.299298008198212, 0.700701991801788, 0.327403767885156, 0.672596232114844, 0.327403767885156, 0.672596232114844]],
    [[106, 329, 0.25, "greater"], [3.02388331687634, 0.00124776333716122, 0.00193221542288028, 0.273994657958207, 0.374486632760359, 0.281409195731402, 0.365868330047447, 0.281409195731402, 0.365868330047447]],
    [[3, 10, 0.333333333333333, "greater"], [-0.223606797749979, 0.588468363120939, 0.700858608951887, 0.107791267406301, 0.603221852538855, 0.126876583903198, 0.558300204130165, 0.126876583903198, 0.558300204130165]],
    [[0, 15, 0.1, "less"], [-1.29099444873581, 0.0983528012294734, 0.205891132094649, 0, 0.203883301035849, 0, 0.15280770461014, 0, 0.15280770461014]],
    [[25, 25, 0.9, "two"], [1.66666666666667, 0.0955807045456296, 0.16978341996465, 0.866807749060952, 1, 0.902346493993949, 1, 0.902346493993949, 1]],
    [[500, 1000, 0.52, "two"], [-1.26592420885458, 0.205540218222619, 0.20573578942774, 0.469069600368104, 0.530930399631896, 0.47402769147842, 0.52597230852158, 0.47402769147842, 0.52597230852158]],
    [[2, 40, 0.2, "two"], [-2.37170824512628, 0.0177060658073666, 0.0158579911483344, 0.0138206673861484, 0.16503877369141, 0.0166862822149395, 0.140331821565973, 0.0166862822149395, 0.140331821565973]]
    ];
    for (const [[k, n, pi0, alt], v] of APP_REF) {
      const g = await app.evaluate((el, a) => {
        const c = el.vizCheck, r = c.compute({counts: [a[0], a[1] - a[0]], success: 0, pi0: a[2], alt: a[3], alpha: 0.05});
        const w = c.wilson(a[0], a[1], 0.95), lo = c.wilson(a[0], a[1], 0.95, 'lower'), hi = c.wilson(a[0], a[1], 0.95, 'upper');
        return [r.score.z, r.score.pValue, r.exact.p, w.lo, w.hi, lo.lo, hi.hi];
      }, [k, n, pi0, alt]);
      [v[0], v[1], v[2], v[3], v[4], v[7], v[8]].forEach((w, i) => appNear(g[i], w, `${k} z ${n}, π0 = ${pi0}, ${alt}: value ${i}`));
    }
    // Default state on load: data of chapter 6, exercise 8 (7 of 8) with π0 = 0,50 and a two-sided H1; no preset pressed.
    const appState = () => app.evaluate(el => el.vizCheck.state());
    const appText = sel => app.locator(sel).innerText();
    let aS = await appState();
    assert.deepEqual([aS.n, aS.k, aS.pi0, aS.alt, aS.ci.side, aS.ci.conf, aS.score.reject, aS.exact.reject, aS.ciRejects, aS.expectedOk], [8, 7, 0.5, 'two', 'two', 0.95, true, false, true, false]);
    appNear(aS.exact.p, 0.0703125, 'Default two-sided exact p-value (2 · 9/256)');
    appNear(aS.score.pValue, 0.0338948535246893, 'Default two-sided score p-value');
    assert.equal(await app.locator('#viz-app-pi0').inputValue(), '0,50');
    assert.equal(await app.locator('[data-preset][aria-pressed="true"]').count(), 0, 'No preset pressed on load');
    assert(!(await app.locator('.viz-app-kind').isVisible()), 'No interval choice for the default two-sided alternative');
    for (const t of ['H0: π = 0,5', 'H1: π ≠ 0,5']) assert((await appText('[data-hyp]')).includes(t), `Default hypotheses show ${t}`);
    assert((await appText('[data-report]')).includes('se testy liší'), 'Default report explains that the tests disagree');
    assert(await app.locator('[data-cond-warning]').isVisible(), 'Default shows the expected-count warning');
    assert.equal(await app.locator('[data-excel], #viz-app-excel-title').count(), 0, 'Apps show no Excel section');
    // Results table: dark header with white text, lightly shaded group rows (R87 amendment).
    const appColors = await app.locator('[data-results] table').evaluate(t => ({head: getComputedStyle(t.querySelector('thead th')).backgroundColor, headText: getComputedStyle(t.querySelector('thead th')).color, group: getComputedStyle(t.querySelector('tr.viz-app-group th')).backgroundColor, body: getComputedStyle(t.querySelector('tbody td')).backgroundColor}));
    assert.deepEqual(appColors, {head: 'rgb(34, 55, 68)', headText: 'rgb(255, 255, 255)', group: 'rgb(240, 240, 240)', body: 'rgba(0, 0, 0, 0)'});
    // The guessing student of chapter 6 (10 correct of 20, π0 = 0,25, H1: π > π0, α = 0,05).
    await app.locator('[data-preset="tipovani"]').click();
    aS = await appState();
    assert.deepEqual([aS.n, aS.k, aS.alt, aS.ci.side, aS.ci.conf, aS.score.reject, aS.exact.reject, aS.pi0Inside, aS.ciRejects, aS.expectedOk], [20, 10, 'greater', 'two', 0.9, true, true, false, true, true]);
    appNear(aS.exact.p, 0.0138644169437612, 'Default exact p-value (chapter 6: 0,014)');
    for (const t of ['H0: π ≤ 0,25', 'H1: π > 0,25', '„správně“', '„Odpověď na otázku“']) assert((await appText('[data-hyp]')).includes(t), `Hypotheses show ${t}`);
    const appRes = await appText('[data-results]');
    for (const t of ['Četnost „správně“ (k)', '10/20', '0,0968', '2,582', '0,005', '0,014', 'binomické, n = 20, π = 0,25', 'Leží π0 pod dolní mezí?', 'zamítáme nulovou hypotézu', '90 %', '(0,327; 0,673)', '+25,0 procentního bodu']) assert(appRes.includes(t), `Results show ${t}`);
    const appRep = await appText('[data-report]');
    for (const t of ['Proměnná „Odpověď na otázku“', 'oba testy zamítají', 'statisticky významný', 'od 0,327 do 0,673', '90% oboustranný Wilsonův interval']) assert(appRep.includes(t), `Report shows ${t}`);
    assert((await app.locator('[data-chart=null] svg').getAttribute('aria-label')).includes('„správně“'), 'Chart label uses the category name');
    assert(!(await app.locator('[data-cond-warning]').isVisible()), 'No expected-count warning for 10 z 20 at 0,25');
    // One-sided alternative: the one-sided 95 % interval has the same lower limit as the two-sided 90 % interval.
    const appKind = app.locator('.viz-app-kind');
    assert(await appKind.isVisible(), 'Interval choice shown for a one-sided alternative');
    await app.locator('input[name="viz-app-kind"][value="one"]').check();
    aS = await appState();
    assert.deepEqual([aS.ci.side, aS.ci.conf, aS.ci.hi], ['lower', 0.95, 1]);
    appNear(aS.ci.lo, 0.327403767885156, 'One-sided lower limit');
    assert((await appText('[data-results]')).includes('[0,327; 1]'), 'One-sided interval written with its bound 1');
    // Two-sided alternative: no interval choice, the two-sided 95 % interval and the exact p-value by the rule of R.
    await app.locator('input[name="viz-app-alt"][value="two"]').check();
    assert(!(await appKind.isVisible()), 'No interval choice for a two-sided alternative');
    aS = await appState();
    appNear(aS.exact.p, 0.0170356288826952, 'Two-sided exact p-value as R binom.test');
    assert.deepEqual([aS.exact.regions, aS.ci.side, aS.ci.conf], [[[0, 0], [10, 20]], 'two', 0.95]);
    assert((await appText('[data-exact-note]')).includes('0,028'), 'Note shows the doubled one-sided p-value');
    assert((await appText('[data-results]')).includes('Statistika chí-kvadrát'), 'Chi-square row for a two-sided alternative');
    // Radios work from the keyboard.
    await app.locator('input[name="viz-app-alt"][value="two"]').focus();
    await page.keyboard.press('ArrowDown');
    assert.equal((await appState()).alt, 'greater', 'Alternative changes from the keyboard');
    // Labels come from the inputs and user text is escaped; an empty name falls back.
    await app.locator('#viz-app-n0').fill('<b>ano</b>');
    await app.locator('#viz-app-var').fill('Souhlas');
    assert.equal(await app.locator('[data-report] b, [data-results] b, [data-hyp] b').count(), 0, 'User text is escaped');
    assert((await appText('[data-report]')).includes('„<b>ano</b>“') && (await appText('[data-report]')).includes('„Souhlas“'), 'Labels shown as text in the report');
    assert.equal(await app.locator('[data-success-label="0"]').innerText(), '<b>ano</b>');
    await app.locator('#viz-app-n0').fill('');
    assert.equal(await app.locator('[data-success-label="0"]').innerText(), 'Kategorie 1', 'Empty name falls back');
    await app.locator('#viz-app-c1').fill('15');
    await app.locator('input[name="viz-app-success"][value="1"]').check();
    aS = await appState();
    assert.deepEqual([aS.n, aS.k, aS.names[1]], [25, 15, 'špatně'], 'Second category as success');
    assert.equal(await app.locator('[data-count-label="1"]').innerText(), 'Četnost „špatně“');
    // Rejected inputs keep the last valid value.
    await app.locator('#viz-app-pi0').fill('1,2');
    assert.equal(await app.locator('#viz-app-pi0').getAttribute('aria-invalid'), 'true');
    assert(await app.locator('#viz-app-pi0-error').isVisible(), 'Error for π0 outside 0–1');
    assert.equal((await appState()).pi0, 0.25, 'Invalid π0 keeps the last valid value');
    await app.locator('#viz-app-pi0').fill('1/3');
    aS = await appState();
    appNear(aS.pi0, 1 / 3, 'π0 as a fraction'); assert.equal(aS.pi0Label, '1/3');
    await app.locator('#viz-app-alpha').fill('0,5');
    assert.equal(await app.locator('#viz-app-alpha').getAttribute('aria-invalid'), 'true');
    await app.locator('#viz-app-alpha').fill('0.01');
    assert.equal((await appState()).alpha, 0.01, 'α with a decimal point');
    await app.locator('#viz-app-c0').fill('-1');
    assert.equal(await app.locator('#viz-app-c0').getAttribute('aria-invalid'), 'true');
    await app.locator('#viz-app-c0').fill('0'); await app.locator('#viz-app-c1').fill('0');
    assert(await app.locator('[data-sum-error]').isVisible(), 'Total of zero rejected');
    // The valid 0 in the first field applied (0 + 15); the total of zero is rejected and 15 stays.
    assert.equal((await appState()).n, 15, 'Zero total keeps the last valid counts');
    // Presets from the chapters.
    await app.locator('[data-preset="cislice"]').click();
    aS = await appState();
    assert.deepEqual([aS.n, aS.k, aS.expectedOk, aS.alt], [8, 7, false, 'greater']);
    appNear(aS.exact.p, 0.03515625, 'Digits: exact p-value 9/256 (chapter 6, exercise 8)');
    assert(await app.locator('[data-cond-warning]').isVisible(), 'Warning for expected counts below 5');
    assert.equal(await app.locator('[data-preset="cislice"]').getAttribute('aria-pressed'), 'true');
    assert.equal(await app.locator('#viz-app-c0').inputValue(), '7');
    assert(!(await app.locator('[data-sum-error]').isVisible()), 'Preset clears the total error');
    await app.locator('[data-preset="telepatie"]').click();
    aS = await appState();
    assert.deepEqual([aS.n, aS.k, aS.names], [329, 106, ['zásah', 'nezásah']]);
    appNear(aS.exact.p, 0.00193221542288028, 'Telepathy: exact p-value (chapter 9: 0,002)');
    // Large n: the chart shows a window and explains a count far outside it.
    await app.locator('#viz-app-c0').fill('0'); await app.locator('#viz-app-c1').fill('100000');
    await app.locator('#viz-app-pi0').fill('0,5');
    aS = await appState();
    assert.deepEqual([aS.n, aS.k], [100000, 0]);
    assert((await appText('[data-null-note]')).includes('daleko mimo výřez'), 'Count far outside the window explained');
    assert.equal(await page.locator('.observablehq--error').count(), 0, 'No OJS error at n = 100 000');
    // Phone.
    await page.setViewportSize({width: 375, height: 812});
    await page.reload({ waitUntil: 'networkidle' });
    await appPlots.nth(2).waitFor();
    assert(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth + 1), 'One-proportion app fits a phone');
    await app.screenshot({path: 'tmp/verification/app-jeden-podil-mobile.png'});
    await page.setViewportSize({width: 1360, height: 1000});

    // Statistical app: test of two proportions (R87 amendment 2026-11-26). Calculations against R
    // (scripts/reference/app-dva-podily.json from scripts/app-dva-podily.R; the full grid is checked by
    // node scripts/check-stat-lib.mjs), the chapter 9 link, default state, tested difference δ0, Fisher only for δ0 = 0,
    // the exact procedure of Agresti and Min, labels and escaping, swapping groups, rejected inputs, presets and phone.
    await page.goto(base + 'quarto/kapitola_09.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#sec-test-dvou-podilu .callout-tip a[href$="app_dva_podily.html"]').count(), 1, 'Chapter 9 links to the two-proportion app');
    await page.goto(base + 'quarto/app_dva_podily.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#quarto-sidebar .sidebar-item-section').nth(2).locator('a.sidebar-link.active').count(), 1, 'Two-proportion app marked in the sidebar');
    const app2 = page.locator('#app-dva-podily');
    const app2Plots = app2.locator('.viz-plots svg[aria-label]');
    await app2Plots.first().waitFor();
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'Two-proportion app: no code, copy button or OJS error');
    assert.equal(await app2.locator('.viz-fullscreen').count(), 1, 'Two-proportion app has the full-screen button');
    const s2 = () => app2.evaluate(el => el.vizCheck.state());
    const t2 = sel => app2.locator(sel).innerText();
    const exactDone = () => page.waitForFunction(() => ['done', 'unavailable'].includes(document.querySelector('#app-dva-podily').vizCheck.state().exactStatus), null, {timeout: 30000});
    const REF2 = JSON.parse(fs.readFileSync('scripts/reference/app-dva-podily.json', 'utf8'));
    for (const name of ['stres', 'daniels', 'pilot', 'noninf', 'nula1', 'male']) {
      const c = REF2.cases[name];
      for (const sc of c.score.filter(x => [0, -0.1, 0.25].includes(x.delta))) {
        const g = await app2.evaluate((el, a) => { const r = el.vizCheck.compute({cells: a.cells, delta0: a.delta, alt: a.alt, alpha: 0.05}); return [r.score.z, r.score.pValue, r.fisher ? r.fisher.p : null]; }, {cells: c.cells, delta: sc.delta, alt: sc.alt});
        if (sc.z !== null) { appNear(g[0], sc.z, `${name}, δ0 = ${sc.delta}, ${sc.alt}: z`); appNear(g[1], sc.p, `${name}, δ0 = ${sc.delta}, ${sc.alt}: p-value`); }
        if (sc.delta === 0 && c.fisher) appNear(g[2], c.fisher[sc.alt], `${name}, ${sc.alt}: Fisher p-value`);
        if (sc.delta !== 0) assert.equal(g[2], null, 'No Fisher test for δ0 ≠ 0');
      }
      const nc = await app2.evaluate((el, cells) => { const r = el.vizCheck.compute({cells, alpha: 0.05}); return [r.ci.lo, r.ci.hi, r.phi]; }, c.cells);
      appNear(nc[0], c.newcombe.two95[0], `${name}: Newcombe lo`, 1e-7); appNear(nc[1], c.newcombe.two95[1], `${name}: Newcombe hi`, 1e-7);
      if (c.phi !== null) appNear(nc[2], c.phi, `${name}: φ`);
    }
    // Agresti & Min (2001), table 3: 5 and 0 of 10 → (0,132; 0,778).
    const am = await app2.evaluate(el => el.vizCheck.exactInterval(5, 10, 0, 10, 0.05));
    assert.deepEqual([am.lo.toFixed(3), am.hi.toFixed(3)], ['0.132', '0.778'], 'Exact interval as in Agresti & Min, table 3');
    // Default state: stress data of chapter 9, δ0 = 0, two-sided H1, the stress preset pressed.
    await exactDone();
    let b2 = await s2();
    assert.deepEqual([b2.n1, b2.n2, b2.delta0, b2.alt, b2.ci.side, b2.ci.conf, b2.score.reject, b2.fisher.reject, b2.ciRejects, b2.expectedOk, b2.exactStatus, b2.exact.reject], [100, 100, 0, 'two', 'two', 0.95, false, false, false, true, 'done', false]);
    assert.equal(await app2.locator('[data-preset="stres"]').getAttribute('aria-pressed'), 'true');
    assert(!(await app2.locator('.viz-app-kind').isVisible()), 'No interval choice for the default two-sided alternative');
    for (const t of ['H0: π1 − π2 = 0', 'H1: π1 − π2 ≠ 0', '„Zvýšený stres“', '„Ženy“']) assert((await t2('[data-hyp]')).includes(t), `Default hypotheses show ${t}`);
    const res2 = await t2('[data-results]');
    for (const t of ['40 z 100', '+10,0 procentního bodu', '(−0,032; 0,227)', 'Společný podíl p', '0,350', '0,0675', '1,482', '0,138', '0,182', 'hypergeometrické', '(−0,038; 0,230)', '0,147', 'referenční skupina „Muži“', '1,33', '1,56', '0,105']) assert(res2.includes(t), `Two-proportion results show ${t}`);
    assert((await t2('[data-report]')).includes('žádný test nezamítá'), 'Default report: no test rejects');
    assert.equal(await app2Plots.count(), 3, 'Three charts with δ0 = 0: proportions, difference, Fisher');
    const app2Colors = await app2.locator('[data-results] table').evaluate(t => ({head: getComputedStyle(t.querySelector('thead th')).backgroundColor, group: getComputedStyle(t.querySelector('tr.viz-app-group th')).backgroundColor}));
    assert.deepEqual(app2Colors, {head: 'rgb(34, 55, 68)', group: 'rgb(240, 240, 240)'});
    assert.deepEqual(await app2.locator('[data-rowsum], [data-colsum], [data-total]').allInnerTexts(), ['100', '100', '70', '130', '200'], 'Margins of the input table');
    assert.deepEqual(await app2.locator('[data-expected] tbody td').allInnerTexts(), ['40 (35)', '60 (65)', '100', '30 (35)', '70 (65)', '100', '70', '130', '200'], 'Observed and expected counts table');
    assert.equal(await app2.locator('[data-chart=diff] svg [stroke]').evaluateAll(els => els.some(e => e.getAttribute('stroke').toUpperCase() === '#3B7D3A')), true, 'Exact interval drawn in green');
    // Tested difference δ0 ≠ 0: score test with restricted estimates, no Fisher test and no Fisher chart.
    await app2.locator('#viz-app-delta').fill('0,1');
    b2 = await s2();
    appNear(b2.score.z, REF2.cases.stres.score.find(x => x.delta === 0.1 && x.alt === 'two').z, 'Stress, δ0 = 0,1: z');
    assert.equal(b2.fisher, null, 'No Fisher result for δ0 ≠ 0');
    assert.equal(await app2Plots.count(), 2, 'No Fisher chart for δ0 ≠ 0');
    assert((await t2('[data-results]')).includes('Podíly odhadnuté za platnosti H0'), 'Restricted estimates shown for δ0 ≠ 0');
    assert((await t2('[data-fisher-note]')).includes('δ0 = 0'), 'Fisher note for δ0 ≠ 0');
    await app2.locator('#viz-app-delta').fill('1');
    assert.equal(await app2.locator('#viz-app-delta').getAttribute('aria-invalid'), 'true', 'δ0 = 1 rejected');
    assert.equal((await s2()).delta0, 0.1, 'Invalid δ0 keeps the last valid value');
    await app2.locator('#viz-app-delta').fill('-1/10');
    b2 = await s2();
    assert.deepEqual([b2.delta0, b2.delta0Label], [-0.1, '−1/10'], 'δ0 as a negative fraction');
    // Noninferiority preset: one-sided H1 with the interval choice; the exact procedure runs too.
    await app2.locator('[data-preset="noninf"]').click();
    await exactDone();
    b2 = await s2();
    assert.deepEqual([b2.delta0, b2.delta0Label, b2.alt, b2.ci.side, b2.ci.conf, b2.score.reject, b2.ciRejects, b2.exact.reject], [-0.1, '−0,10', 'greater', 'two', 0.9, false, false, false]);
    appNear(b2.score.pValue, REF2.cases.noninf.score.find(x => x.delta === -0.1 && x.alt === 'greater').p, 'Noninferiority p-value');
    for (const t of ['H0: π1 − π2 ≤ −0,10', 'H1: π1 − π2 > −0,10']) assert((await t2('[data-hyp]')).includes(t), `Noninferiority hypotheses show ${t}`);
    assert(await app2.locator('.viz-app-kind').isVisible(), 'Interval choice shown for a one-sided alternative');
    await app2.locator('input[name="viz-app-kind"][value="one"]').check();
    await exactDone();
    b2 = await s2();
    assert.deepEqual([b2.ci.side, b2.ci.conf, b2.ci.hi, b2.exact.ci.side, b2.exact.ci.hi], ['lower', 0.95, 1, 'lower', 1]);
    assert((await t2('[data-results]')).includes('[−0,147; 1]'), 'One-sided Newcombe interval written with its bound 1');
    // Swapping groups keeps the hypotheses: δ0 changes sign, the alternative its direction, the p-value stays.
    const pBefore = b2.score.pValue;
    await app2.locator('[data-swap]').click();
    b2 = await s2();
    assert.deepEqual([b2.groups, b2.delta0, b2.delta0Label, b2.alt], [['prezenční', 'online'], 0.1, '0,10', 'less']);
    appNear(b2.score.pValue, pBefore, 'Swapping groups keeps the p-value');
    assert.equal(await app2.locator('[data-preset][aria-pressed="true"]').count(), 0, 'Swap ends the pressed preset');
    // Pilot study: small counts, warning, Fisher 0,070 (chapter 9) and the exact test between the two.
    await app2.locator('[data-preset="pilot"]').click();
    await exactDone();
    b2 = await s2();
    appNear(b2.fisher.p, REF2.cases.pilot.fisher.two, 'Pilot: Fisher p-value (chapter 9: 0,070)');
    assert.deepEqual([b2.expectedOk, b2.score.reject, b2.fisher.reject], [false, true, false]);
    assert(await app2.locator('[data-cond-warning]').isVisible(), 'Expected-count warning for the pilot study');
    assert((await t2('[data-report]')).includes('se testy liší'), 'Pilot report explains that the tests disagree');
    // Daniels: ratios and φ of chapter 9; aspirin: no exact procedure for groups over 200.
    await app2.locator('[data-preset="daniels"]').click();
    const resD = await t2('[data-results]');
    for (const t of ['2,34', '(1,50; 3,66)', '3,23', '(1,80; 5,82)', '0,250', '(0,119; 0,330)']) assert(resD.includes(t), `Daniels results show ${t}`);
    await app2.locator('[data-preset="aspirin"]').click();
    await exactDone();
    assert.equal((await s2()).exactStatus, 'unavailable', 'No exact procedure for groups over 200');
    assert((await t2('[data-results]')).includes('nejvýše 200 případů'), 'Exact procedure limit explained');
    assert.equal(await page.locator('.observablehq--error').count(), 0, 'No OJS error for the aspirin data');
    // Labels from the inputs, escaping, the outcome category and rejected cells.
    await app2.locator('#viz-app-g0').fill('<b>A</b>');
    await app2.locator('#viz-app-ovar').fill('Infarkt myokardu');
    assert.equal(await app2.locator('[data-report] b, [data-results] b, [data-hyp] b').count(), 0, 'User text is escaped');
    assert((await t2('[data-report]')).includes('„<b>A</b>“') && (await t2('[data-report]')).includes('„Infarkt myokardu“'), 'Labels shown as text in the report');
    await app2.locator('#viz-app-g0').fill('');
    assert((await t2('[data-hyp]')).includes('„Skupina 1“'), 'Empty group name falls back');
    await app2.locator('input[name="viz-app-success"][value="1"]').check();
    b2 = await s2();
    assert.deepEqual([b2.cells[0][0], b2.success], [10845, 1], 'Second outcome category as the chosen one');
    await app2.locator('#viz-app-c00').fill('0'); await app2.locator('#viz-app-c01').fill('0');
    assert(await app2.locator('#viz-app-cells-error').isVisible(), 'Empty group rejected');
    assert.equal((await s2()).n1, 10845, 'Empty group keeps the last valid counts');
    await app2.locator('#viz-app-c00').fill('-3');
    assert.equal(await app2.locator('#viz-app-c00').getAttribute('aria-invalid'), 'true');
    // Phone.
    await page.setViewportSize({width: 375, height: 812});
    await page.reload({ waitUntil: 'networkidle' });
    await app2Plots.nth(2).waitFor();
    assert(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth + 1), 'Two-proportion app fits a phone');
    await app2.screenshot({path: 'tmp/verification/app-dva-podily-mobile.png'});
    await page.setViewportSize({width: 1360, height: 1000});

    // Statistical app: test of one mean (R87 amendment 2026-11-27). Calculations against R
    // (scripts/reference/app-jeden-prumer.json from scripts/app-jeden-prumer.R; the full grid is checked by
    // node scripts/check-stat-lib.mjs), links from chapters 6–8, default state, presets (z-test, equivalence, paired data
    // with an incomplete pair, summaries), diagnostics toggles, labels and escaping, swapping, rejected inputs and phone.
    for (const [ch, sec] of [['06', 'sec-z-test'], ['07', 'sec-t-test'], ['08', 'sec-parova-data']]) {
      await page.goto(base + `quarto/kapitola_${ch}.html`, { waitUntil: 'networkidle' });
      assert.equal(await page.locator(`#${sec} .callout-tip a[href$="app_jeden_prumer.html"]`).count(), 1, `Chapter ${ch} links to the one-mean app`);
    }
    await page.goto(base + 'quarto/app_jeden_prumer.html', { waitUntil: 'networkidle' });
    assert.equal(await page.locator('#quarto-sidebar .sidebar-item-section').nth(2).locator('a.sidebar-link.active').count(), 1, 'One-mean app marked in the sidebar');
    const app3 = page.locator('#app-jeden-prumer');
    const app3Plots = app3.locator('.viz-plots svg[aria-label]');
    await app3Plots.nth(5).waitFor();
    assert.equal(await page.locator('pre.sourceCode:visible, .code-copy-button:visible, .observablehq--error').count(), 0, 'One-mean app: no code, copy button or OJS error');
    assert.equal(await app3.locator('.viz-fullscreen').count(), 1, 'One-mean app has the full-screen button');
    assert.equal(await page.locator('text=Výpočet v českém Excelu').count(), 0, 'One-mean app has no Excel section');
    const s3 = () => app3.evaluate(el => el.vizCheck.state());
    const t3 = sel => app3.locator(sel).innerText();
    const REF3 = JSON.parse(fs.readFileSync('scripts/reference/app-jeden-prumer.json', 'utf8'));
    const close = (a, b, tol = 1e-9) => Math.abs(a - b) <= tol * Math.max(1, Math.abs(b));
    let c3 = await s3();
    const u0 = REF3.means.find(c => c.case === 'uzkost' && c.input.alt === 'two' && c.input.alpha === 0.05);
    assert(close(c3.stat, u0.stat) && close(c3.p, u0.p) && close(c3.ci.lo, u0.lo) && close(c3.ci.hi, u0.hi) && close(c3.d.lo, u0.dlo, 1e-7), 'Default anxiety data against R');
    assert.deepEqual([c3.design, c3.source, c3.alt, c3.mu0, c3.n], ['one', 'raw', 'two', 20, 20], 'Default state: anxiety data, μ0 = 20, two-sided');
    assert.equal(await app3.locator('[data-preset][aria-pressed="true"]').count(), 0, 'No preset pressed at load');
    assert(close(c3.diag.w, REF3.diag.uzkost.W) && close(c3.diag.pw, REF3.diag.uzkost.pW, 1e-7), 'Shapiro–Wilk of the default data against R');
    assert((await t3('[data-results]')).includes('(20,74; 23,66)'), 'Chapter 7 interval in the results table');
    assert.equal(await app3.locator('.viz-app-table thead th').first().evaluate(el => getComputedStyle(el).color), 'rgb(255, 255, 255)', 'Results table header in white');
    assert.equal(await app3.locator('[data-chart=rain]').getAttribute('data-mode'), 'dot', 'Up to 50 values: dot plot');
    // Diagnostics toggles.
    await app3.locator('#viz-app-hist-kde').check();
    assert.equal(await app3.locator('[data-chart=hist]').getAttribute('data-curves'), 'normal kde', 'Histogram with both curves');
    await app3.locator('#viz-app-hist-normal').uncheck();
    assert.equal(await app3.locator('[data-chart=hist]').getAttribute('data-curves'), 'kde', 'Histogram with the density estimate only');
    await app3.locator('input[name="viz-app-qq"][value="detrended"]').check();
    await app3.locator('input[name="viz-app-band"][value="ks"]').check();
    assert.equal(await app3.locator('[data-chart=qq]').getAttribute('data-mode'), 'detrended ks', 'Detrended Q–Q plot with the KS band');
    assert((await app3.locator('[data-chart=qq] svg').getAttribute('aria-label')).startsWith('Detrendovaný'), 'Q–Q plot label follows the choice');
    // One-sided alternative and the interval kind.
    await app3.locator('input[name="viz-app-alt"][value="greater"]').check();
    assert(await app3.locator('.viz-app-kind').isVisible(), 'Interval choice shown for a one-sided alternative');
    c3 = await s3();
    const u1 = REF3.means.find(c => c.case === 'uzkost' && c.input.alt === 'greater' && c.input.kind === 'two' && c.input.alpha === 0.05);
    assert(close(c3.p, u1.p) && close(c3.ci.lo, u1.lo) && c3.ci.conf.toFixed(2) === '0.90', 'One-sided p-value and 90 % interval');
    await app3.locator('input[name="viz-app-kind"][value="one"]').check();
    c3 = await s3();
    assert(c3.ci.hi === 'Inf' && c3.ci.side === 'lower', 'One-sided 95 % interval with a lower limit');
    // Presets: z-test, equivalence, PDI, paired data, summaries, skewed data.
    await app3.locator('[data-preset="poz-z"]').click();
    c3 = await s3();
    assert.deepEqual([c3.test, Number(c3.stat.toFixed(3)), Number(c3.p.toFixed(3))], ['z', -2, 0.023], 'Attention z-test of chapter 6');
    await app3.locator('[data-preset="online"]').click();
    c3 = await s3();
    const on = REF3.tost.online;
    assert(c3.eq && c3.eq.equivalent && close(c3.eq.pL, on.pL) && close(c3.eq.lo, on.lo), 'Online version: equivalence shown');
    await app3.locator('#viz-app-n').fill('40');
    c3 = await s3();
    assert(c3.eq && !c3.eq.equivalent, 'n = 40: equivalence not shown');
    await app3.locator('[data-preset="spanek"]').click();
    c3 = await s3();
    const sp = REF3.paired.find(c => c.case === 'spanek' && c.side === 'two');
    assert.deepEqual([c3.design, c3.n, c3.dropped, c3.header], ['paired', 12, 1, true], 'Paired preset: 12 complete pairs, one dropped, header skipped');
    assert(close(c3.m, sp.mD) && close(c3.pe.avg.lo, sp.avg[1]) && close(c3.pe.ref.hi, sp.ref[2]) && close(c3.pe.dz.lo, sp.dz[1], 1e-7), 'Paired effect sizes against R');
    assert.equal(await app3.locator('input[name="viz-app-test"][value="z"]').isVisible(), false, 'No z-test for paired data');
    const p3Before = c3.p;
    await app3.locator('[data-swap]').click();
    c3 = await s3();
    assert(close(c3.m, -sp.mD) && c3.order === 1 && close(c3.p, p3Before), 'Swapping the measurements changes the sign of the mean difference, not the p-value');
    assert((await t3('[data-direction]')).includes('„po krátkém spánku“ − „po běžném spánku“'), 'Direction of the difference shown');
    await app3.locator('[data-preset="anorexie"]').click();
    c3 = await s3();
    assert.deepEqual([c3.source, Number(c3.pe.ref.value.toFixed(2)), Number(c3.pe.dz.value.toFixed(2)), c3.pe.avg, c3.diag], ['summary', 1.45, 1.01, null, null], 'Anorexia summaries: d 1,45 and dz 1,01, no diagnostics');
    assert(await app3.locator('[data-diag-body]').isHidden(), 'Diagnostics hidden for summaries');
    await app3.locator('[data-preset="doby"]').click();
    c3 = await s3();
    assert.equal(await app3.locator('[data-chart=rain]').getAttribute('data-mode'), 'jitter', 'More than 50 values: jitter');
    assert(c3.diag.pw < 1e-8 && c3.diag.outliers === 2, 'Skewed data: Shapiro–Wilk rejects, two values beyond the fences');
    // Labels, escaping and rejected inputs.
    await app3.locator('#viz-app-var').fill('<b>X</b>');
    assert.equal(await app3.locator('[data-report] b, [data-results] b, [data-hyp] b').count(), 0, 'User text is escaped');
    assert((await t3('[data-report]')).includes('„<b>X</b>“'), 'Label shown as text in the report');
    await app3.locator('#viz-app-alpha').fill('0,7');
    assert(await app3.locator('#viz-app-alpha-error').isVisible(), 'α = 0,7 rejected');
    assert.equal((await s3()).alpha, 0.05, 'Rejected α keeps the last valid value');
    await app3.locator('#viz-app-raw').fill('12\nabc\n14');
    assert(await app3.locator('#viz-app-raw-error').isVisible(), 'Unreadable value rejected');
    assert.equal((await s3()).n, 80, 'Rejected data keep the last valid values');
    await app3.locator('#viz-app-raw').fill('5\n5\n5');
    assert(await app3.locator('#viz-app-raw-error').isVisible(), 'Zero SD rejected');
    // Keyboard: the preset buttons and radio buttons are reachable and operable.
    await app3.locator('[data-preset="uzkost"]').focus();
    await page.keyboard.press('Enter');
    assert.equal((await s3()).n, 20, 'Preset operable by keyboard');
    // Phone.
    await page.setViewportSize({width: 375, height: 812});
    await page.reload({ waitUntil: 'networkidle' });
    await app3Plots.nth(5).waitFor();
    assert(await page.evaluate(() => document.documentElement.scrollWidth <= innerWidth + 1), 'One-mean app fits a phone');
    await app3.screenshot({path: 'tmp/verification/app-jeden-prumer-mobile.png'});
    await page.setViewportSize({width: 1360, height: 1000});

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
      for (const [query, id] of [['visual analogue scale', 'pojem-vizualni-analogova-skala'], ['slider', 'pojem-posuvnik'], ['verbal anchor', 'pojem-verbalni-kotva'], ['measurement model', 'pojem-model-mereni']]) {
        await page.locator('.ref-controls input').fill(query);
        assert.equal(await visible(), 1, `Search for ${query} across all pages`);
        assert(await page.locator(`#${id}`).isVisible());
      }
      for (const [query, id] of [
        ['independent variable', 'pojem-nezavisla-promenna'],
        ['dependent variable', 'pojem-zavisla-promenna'],
        ['explanatory variable', 'pojem-explanacni-promenna'],
        ['predictor variable', 'pojem-prediktor'],
        ['outcome variable', 'pojem-vysledna-promenna'],
        ['criterion variable', 'pojem-kriterium'],
        ['predictand', 'pojem-odhadovana-promenna'],
        // Adjacent entries need different ids: an unchanged hash fires no hashchange.
        ['vysvetlujici promenna', 'pojem-explanacni-promenna'],
        ['regresor', 'pojem-prediktor'],
        ['exposure', 'pojem-explanacni-promenna'],
        ['endpoint', 'pojem-vysledna-promenna'],
        ['explanacni', 'pojem-explanacni-promenna'],
        ['regresand', 'pojem-odhadovana-promenna'],
        ['probability sampling', 'pojem-pravdepodobnostni-vyber'],
        ['random assignment', 'pojem-nahodne-prideleni']
      ]) {
        await page.locator('.ref-controls input').fill(query);
        assert(await page.locator(`#${id}`).isVisible(), `Variable role search: ${query}`);
        await page.locator('.ref-controls input').fill('nenalezitelnypojem');
        await page.evaluate(id => { location.hash = id; }, id);
        await page.locator(`#${id}`).waitFor({ state: 'visible' });
        assert.equal(await page.locator('.ref-controls input').inputValue(), '', 'Variable role link clears filter');
      }
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
    for (const [query,id] of [['kolacovy','pojem-vysecovy-graf'],['stem-and-leaf','pojem-stonek-list'],['uniform distribution','pojem-rovnomerne'],['multimodal','pojem-vicevrcholove'],['closed endpoint','pojem-uzavrena-hranice'],['class midpoint','pojem-stred-intervalu'],['extremni hodnota','pojem-odlehle-pozorovani']]) {
      await page.locator('.ref-controls input').fill(query);
      assert(await page.locator(`#${id}`).isVisible());
    }
    for (const file of ['znaceni', 'excel']) {
      await page.goto(base + `quarto/${file}.html`, { waitUntil: 'networkidle' });
      const rows=page.locator('tbody tr');
      const count=await rows.count();
      assert.equal(await page.locator('tbody tr:visible').count(), Math.min(10,count));
      for (const size of ['25','50','all','10']) {
        await page.locator('.ref-controls select').selectOption(size);
        assert.equal(await page.locator('tbody tr:visible').count(), Math.min(count,size==='all'?count:+size));
      }
      const lastId=await rows.last().getAttribute('id');
      await page.locator('.ref-controls input').fill('nenalezitelnypojem');
      assert.equal(await page.locator('tbody tr:visible').count(),0);
      await page.evaluate(id=>location.hash=id,lastId);
      await page.locator(`#${lastId}`).waitFor({state:'visible'});
      assert.equal(await page.locator('.ref-controls input').inputValue(),'');
      await page.goto(base+`quarto/${file}.html#${lastId}`,{waitUntil:'networkidle'});
      assert(await page.locator(`#${lastId}`).isVisible());
      await page.locator('.ref-controls input').fill(file==='znaceni'?'summation':'COUNTIFS');
      assert.equal(await page.locator('tbody tr:visible').count(),1);
      await page.locator('.ref-controls input').focus();await page.keyboard.press('Tab');
      assert.equal(await page.evaluate(()=>document.activeElement.tagName),'SELECT');
      if(file==='znaceni') {
        await page.waitForFunction(()=>document.querySelector('#znak-sumace math'));
        assert.equal(await page.locator('merror').count(),0);
        await page.locator('#znak-sumace').screenshot({path:'tmp/verification/ch02-notation.png'});
      }
      await page.setViewportSize({width:390,height:844});
      assert(await page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1));
      await page.screenshot({path:`tmp/verification/ch02-reference-${file}-mobile.png`});
      await page.setViewportSize({width:1360,height:1000});
    }
    // New reference rows must be searchable across pages and reachable through an unrelated filter.
    for(const [file,query,id] of [['slovnicek','standard normal distribution','pojem-normovane-normalni'],['slovnicek','vážený skór','pojem-subtestovy-skor'],['slovnicek','normal Q','pojem-normalni-qq'],['znaceni','sigma','znak-sigma'],['znaceni','Polohy pro Q','znak-qq-polohy'],['excel','NORM.S.INV','excel-norm-s-inv']]) {
      await page.goto(base+`quarto/${file}.html`,{waitUntil:'networkidle'});
      await page.locator('.ref-controls input').fill(query);
      assert(await page.locator('#'+id).isVisible());
      await page.locator('.ref-controls input').fill('nenalezitelnypojem');
      await page.evaluate(id=>location.hash=id,id);
      await page.locator('#'+id).waitFor({state:'visible'});
    }
    for(const [file,query,id] of [['slovnicek','nonlinear transformation','pojem-nelinearni-transformace'],['slovnicek','affine transformation','pojem-linearni-transformace'],['znaceni','afinní','vztah-linearni-transformace'],['znaceni','Značky APA','znak-apa-reportovani'],['slovnicek','normalized entropy','pojem-normalizovana-entropie'],['znaceni','Normalizovaná entropie','znak-normalizovana-entropie'],['slovnicek','median absolute deviation','pojem-mad'],['slovnicek','MeanAD','pojem-prumerna-absolutni'],['slovnicek','MedAD','pojem-mad'],['slovnicek','degrees of freedom','pojem-stupne-volnosti'],['znaceni','stupňů volnosti','vztah-stupne-volnosti'],['znaceni','počet hodnot při ořezání','vztah-pocet-orezani'],['slovnicek','winsorization','pojem-winsorizace'],['slovnicek','kurtosis','pojem-kurtoza'],['slovnicek','linear interpolation','pojem-interpolace'],['znaceni','úroveň kvantilu přiřazená','vztah-uroven-kvantilu'],['znaceni','lineární interpolace','vztah-interpolace'],['znaceni','percentilové pořadí','vztah-percentilove-poradi'],['slovnicek','kompromisní','pojem-percentilove-poradi'],['znaceni','logaritmus','znak-log2'],['znaceni','exces','znak-g2'],['excel','LOGZ','excel-log'],['excel','STDEV.S','excel-sd']]) {
      await page.goto(base+`quarto/${file}.html`,{waitUntil:'networkidle'});
      await page.locator('.ref-controls input').fill(query);
      assert(await page.locator('#'+id).isVisible());
      await page.locator('.ref-controls input').fill('nenalezitelnypojem');
      await page.evaluate(id=>location.hash=id,id);
      await page.locator('#'+id).waitFor({state:'visible'});
    }
    // Chapter 5 rows: Czech, English and alternative names; reachable through an unrelated filter.
    for(const [file,query,id] of [['slovnicek','sample space','pojem-vyberovy-prostor'],['slovnicek','náhodná veličina','pojem-nahodna-promenna'],['slovnicek','base rate','pojem-zakladni-cetnost'],['slovnicek','opačný jev','pojem-doplnkovy-jev'],['slovnicek','conjunction fallacy','pojem-konjunkcni-klam'],['znaceni','Bayesova','vztah-bayes'],['znaceni','n nad k','znak-kombinacni-cislo'],['znaceni','3,14','znak-pi'],['excel','BINOM.DIST.RANGE','excel-binom-dist-range'],['excel','COMBIN','excel-kombinace'],['excel','PERMUT','excel-permutace']]) {
      await page.goto(base+`quarto/${file}.html`,{waitUntil:'networkidle'});
      await page.locator('.ref-controls input').fill(query);
      assert(await page.locator('#'+id).isVisible(),`Searchable: ${id}`);
      await page.locator('.ref-controls input').fill('nenalezitelnypojem');
      await page.evaluate(id=>location.hash=id,id);
      await page.locator('#'+id).waitFor({state:'visible'});
    }
    assert(!fs.existsSync(path.join(root, 'sources')), 'Private sources copied to web');
    assert(!fs.existsSync(path.join(root, 'quarto/README.md')), 'Author documentation copied to web');
    const noScript = await browser.newContext({ javaScriptEnabled: false });
    const plain = await noScript.newPage();
    await plain.goto(base + 'quarto/slovnicek.html');
    assert.equal(await plain.locator('tbody tr:visible').count(), total, 'All glossary rows readable without JavaScript');
    if (solutionCount) {
      await plain.goto(base + 'quarto/kapitola_01.html');
      assert.equal(await plain.locator('.callout[title="Ukázat řešení"] .callout-collapse:visible').count(), solutionsByPage['quarto/kapitola_01.html'], 'Solutions readable without JavaScript');
      assert(await plain.locator('#chyba-mereni-podrobne .callout-collapse').isVisible(), 'Optional explanation readable without JavaScript');
      await plain.setViewportSize({ width: 1360, height: 1000 });
      assert(await plain.locator('#toc-sec-datova-matice').isVisible(), 'TOC readable without JavaScript');
    }
    await plain.goto(base + 'quarto/kapitola_02.html');
    assert.equal(await plain.locator('.callout[title="Ukázat řešení"] .callout-collapse:visible').count(), 10);
    await plain.goto(base + 'quarto/kapitola_03.html');
    assert.equal(await plain.locator('.callout[title="Ukázat řešení"] .callout-collapse:visible').count(),16);
    assert(await plain.locator('#rozsireni-momenty .callout-collapse').isVisible());
    await plain.goto(base + 'quarto/kapitola_04.html');
    assert.equal(await plain.locator('.callout[title="Ukázat řešení"] .callout-collapse:visible').count(),10);
    await plain.goto(base + 'quarto/kapitola_05.html');
    assert.equal(await plain.locator('.callout[title="Ukázat řešení"] .callout-collapse:visible').count(),12);
    assert(await plain.locator('#rozsireni-sance .callout-collapse').isVisible());
    await plain.goto(base + 'quarto/kapitola_06.html');
    assert.equal(await plain.locator('.callout[title="Ukázat řešení"] .callout-collapse:visible').count(),16);
    assert(await plain.locator('#rozsireni-test-screening .callout-collapse').isVisible());
    await plain.goto(base + 'quarto/kapitola_07.html');
    assert.equal(await plain.locator('.callout[title="Ukázat řešení"] .callout-collapse:visible').count(),14);
    assert(await plain.locator('#rozsireni-tost-vypocet .callout-collapse').isVisible());
    await plain.goto(base + 'quarto/kapitola_08.html');
    assert.equal(await plain.locator('.callout[title="Ukázat řešení"] .callout-collapse:visible').count(),14);
    assert(await plain.locator('#rozsireni-welch-stupne .callout-collapse').isVisible());
    for (const file of ['znaceni','excel']) {
      await plain.goto(base + `quarto/${file}.html`);
      assert.equal(await plain.locator('tbody tr:visible').count(), await plain.locator('tbody tr').count());
    }
    await plain.goto(base+'quarto/literatura.html');
    assert.equal(await plain.locator('#refs .csl-entry:visible').count(),expectedReferences);
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
