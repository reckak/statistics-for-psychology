// Renders SVG figures to PNG for the tutor packages (the web book keeps SVG).
// Usage: node scripts/tutor/svg-to-png.cjs <jobs.json>, jobs = [{input, output}, …].
// Prints a JSON list of {output, width, height} in PNG pixels.
const fs = require('node:fs');
const path = require('node:path');
const {pathToFileURL} = require('node:url');
const {chromium} = require(process.env.PLAYWRIGHT_MODULE || 'playwright');

// 1.5 × the SVG pixel size keeps axis labels legible in a chat; 2 × more than doubled the archives (PNG does not compress like SVG).
const SCALE = 1.5;

(async () => {
  const jobs = JSON.parse(fs.readFileSync(process.argv[2], 'utf8'));
  const browser = await chromium.launch({headless: true, ...(process.env.CHROME_PATH ? {executablePath: process.env.CHROME_PATH} : {})});
  const results = [];
  try {
    const context = await browser.newContext({deviceScaleFactor: SCALE, viewport: {width: 1200, height: 900}});
    const page = await context.newPage();
    for (const job of jobs) {
      await page.goto(pathToFileURL(path.resolve(job.input)).href);
      const box = await page.evaluate(() => {
        const svg = document.documentElement;
        if (svg.localName !== 'svg') return null;
        const absolute = name => /^\d+(\.\d+)?(px)?$/.test(svg.getAttribute(name) || '') ? parseFloat(svg.getAttribute(name)) : null;
        let width = absolute('width'), height = absolute('height');
        if (!width || !height) {
          // No fixed size: the figure fills the viewport, so size the viewport from the viewBox.
          const box = svg.viewBox.baseVal;
          if (!box || !box.width || !box.height) return null;
          const factor = Math.max(1, 600 / Math.max(box.width, box.height));
          width = box.width * factor; height = box.height * factor;
        }
        return {width: Math.ceil(width), height: Math.ceil(height)};
      });
      if (!box || box.width < 50 || box.height < 50) throw new Error(`Not a renderable SVG: ${job.input}`);
      await page.setViewportSize(box);
      fs.mkdirSync(path.dirname(job.output), {recursive: true});
      // A white page background keeps figures without their own background readable in dark themes.
      await page.screenshot({path: job.output, clip: {x: 0, y: 0, ...box}, omitBackground: false});
      results.push({output: job.output, width: Math.round(box.width * SCALE), height: Math.round(box.height * SCALE)});
    }
  } finally {
    await browser.close();
  }
  process.stdout.write(JSON.stringify(results));
})().catch(error => { console.error(error.stack || String(error)); process.exit(1); });
