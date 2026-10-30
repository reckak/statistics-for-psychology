// Audit table widths, faint rules and note sizes independently of content checks.
const fs = require('node:fs'), path = require('node:path'), http = require('node:http');
const assert = require('node:assert/strict');
const {chromium} = require(process.env.PLAYWRIGHT_MODULE || 'playwright');
const root = path.resolve('_book');
fs.mkdirSync('tmp/verification', {recursive:true});
const widths = [1024,1280,1360,1440,1920,390];
const server = http.createServer((req,res) => {
  const route = decodeURIComponent(new URL(req.url,'http://localhost').pathname).replace(/^\/statistics-for-psychology\//,'/');
  const file = path.resolve(root,'.'+route);
  if (!file.startsWith(root+path.sep) || !fs.existsSync(file) || !fs.statSync(file).isFile()) { res.writeHead(404); return res.end(); }
  res.setHeader('Content-Type', {'.html':'text/html','.js':'text/javascript','.css':'text/css','.svg':'image/svg+xml'}[path.extname(file)] || 'application/octet-stream');
  fs.createReadStream(file).pipe(res);
});
(async()=>{
 await new Promise(r=>server.listen(0,'127.0.0.1',r));
 const browser=await chromium.launch({headless:true,...(process.env.CHROME_PATH?{executablePath:process.env.CHROME_PATH}:{})});
 const page=await browser.newPage(); const report=[];
 try {
  for(const file of fs.readdirSync(path.join(root,'quarto')).filter(f=>f.endsWith('.html'))){
   await page.goto(`http://127.0.0.1:${server.address().port}/statistics-for-psychology/quarto/${file}`,{waitUntil:'networkidle'});
   // Include tables in solutions and optional sections, not just the initial view.
   await page.evaluate(()=>document.querySelectorAll('.collapse').forEach(e=>e.classList.add('show')));
   for(const width of widths){
    await page.setViewportSize({width,height:1000});
    const data=await page.evaluate(()=>{
     const tables=[...document.querySelectorAll('main table')].map(t=>{
      const region=t.closest('.table-scroll') || t.parentElement;
      const cell=t.tBodies[0]?.rows[0]?.cells[0];
      const innerColors=[...t.tBodies].flatMap(b=>[...b.rows].slice(0,-1).filter(r=>!r.hidden&&!r.classList.contains('table-page-last')).flatMap(r=>[...r.cells].map(c=>getComputedStyle(c).borderBottomColor)));
      return {id:t.closest('[id^="tbl-"]')?.id || t.id,available:region.clientWidth,overflow:region.scrollWidth-region.clientWidth,color:cell?getComputedStyle(cell).borderBottomColor:null,innerColors};
     });
     const notes=[...document.querySelectorAll('.table-note')].map(n=>({size:parseFloat(getComputedStyle(n).fontSize),body:parseFloat(getComputedStyle(document.querySelector('main')).fontSize)}));
     const pageOverflow=document.documentElement.scrollWidth-innerWidth;
     const outside=pageOverflow>1?[...document.querySelectorAll('main *')].filter(e=>e.getBoundingClientRect().right>innerWidth+1&&!e.closest('.table-scroll, .teaching-figure, .chapter-04-figure')).map(e=>({tag:e.tagName,id:e.id,cls:e.className?.toString(),text:e.textContent.slice(0,80)})).slice(0,12):[];
     return {tables,notes,pageOverflow,outside};
    });
    if(!process.argv.includes('--audit')) assert(data.pageOverflow<=1,`${file}/${width}: whole-page overflow ${JSON.stringify(data.outside)}`);
    for(const note of data.notes) assert(Math.abs(note.body-note.size-4/3)<0.05,`${file}/${width}: note must be 1pt smaller`);
    for(const table of data.tables) assert(table.innerColors.every(c=>c==='rgb(200, 200, 200)'),`${file}/${table.id}: faint inner rules`);
    const small=data.tables.filter(t=>t.overflow>1&&t.overflow<=32);
    report.push({file,width,small,tables:data.tables.length,notes:data.notes.length,pageOverflow:data.pageOverflow,outside:data.outside});
    if(file==='kapitola_01.html'&&width===1360){
     const t=data.tables.find(t=>t.id==='tbl-urovne-shrnuti');assert(t&&t.overflow<=1,'Measurement-level table must fit desktop');
     await page.locator('#tbl-urovne-shrnuti').screenshot({path:'tmp/verification/table-levels-fitted.png'});
    }
   }
  }
  fs.writeFileSync('tmp/verification/table-layout.json',JSON.stringify(report,null,2));
  console.log(JSON.stringify({viewports:widths,nearOverflows:report.filter(r=>r.small.length||r.pageOverflow>1)},null,2));
  if(!process.argv.includes('--audit')) assert(!report.some(r=>r.width>=1024&&r.small.length),'Avoidable desktop table overflow; see report');
 } finally {await browser.close();server.close();}
})().catch(e=>{console.error(e);server.close();process.exitCode=1;});
