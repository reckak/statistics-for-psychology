// Author-map integrity checks. No packages or Quarto render are required.
const fs = require('node:fs');
const path = require('node:path');
const cp = require('node:child_process');
const root = path.resolve(__dirname, '..');
const read = file => fs.readFileSync(path.join(root, file), 'utf8').replace(/\r\n/g, '\n');
const exists = file => fs.existsSync(path.join(root, file));
const posix = file => file.split(path.sep).join('/');
const args = process.argv.slice(2);
const baseline = args.includes('--baseline') ? args[args.indexOf('--baseline') + 1] : null;
const requireSources = args.includes('--require-sources');
const mapRoots = ['docs/OSNOVA.md', 'docs/ZDROJE.md', 'docs/ROZHODNUTI.md'];
const mapDirs = ['docs/kapitoly/', 'docs/zdroje/', 'docs/rozhodnuti/'];
const isMap = file => mapRoots.includes(file) || mapDirs.some(dir => file.startsWith(dir));
const entryDocs = ['README.md', 'docs/PROVOZ.md'];
const isLinkTarget = file => isMap(file) || entryDocs.includes(file);
const fullCheck = file => isMap(file) || entryDocs.includes(file) || ['AGENTS.md','docs/ROZHODNUTI.md','docs/SLOVNIK.md'].includes(file);
function walk(dir) {
 return fs.readdirSync(path.join(root, dir), {withFileTypes:true}).flatMap(e =>
  e.isDirectory() ? walk(`${dir}/${e.name}`) : [`${dir}/${e.name}`]);
}
const maps = [...mapRoots, ...mapDirs.flatMap(dir=>walk(dir.slice(0,-1)))].filter(f=>f.endsWith('.md'));
const tracked = cp.execFileSync('git', ['ls-files', '-z'], {cwd:root, encoding:'utf8'})
 .split('\0').filter(f=>/\.(md|qmd)$/.test(f));
function slug(text) {
 return text.toLowerCase().replace(/<[^>]*>/g, '').replace(/[^\p{L}\p{N}\p{M}_\-\s]/gu, '').replace(/ /g,'-');
}
function anchors(text) {
 const ids = new Set(); const explicit = []; const counts = new Set();
 for (const m of text.matchAll(/\bid=["']([^"']+)["']|\{[^}\n]*#[\w-]+[^}\n]*\}/g)) {
  const id=m[1] ?? m[0].match(/#([\w-]+)/)?.[1];
  if(id) { explicit.push(id); ids.add(id); }
 }
 for (const m of text.matchAll(/^#{1,6} (.+)$/gm)) {
  const base=slug(m[1].replace(/\s*\{[^}]*\}\s*$/, '')); let id=base, i=0;
  while(counts.has(id)) id=`${base}-${++i}`;
  counts.add(id); ids.add(id);
 }
 return {ids, explicit};
}
// Balanced destinations support PDF names and URLs containing parentheses.
function links(text) {
 const result=[];
 for(let i=0;i<text.length-1;i++) {
  if(text[i]!==']' || text[i+1]!=='(') continue;
  let end=i+2, depth=1;
  for(;end<text.length;end++) {
   if(text[end]==='\\') { end++; continue; }
   if(text[end]==='(') depth++;
   if(text[end]===')') { depth--; if(depth===0) break; }
  }
  if(depth===0) result.push({url:text.slice(i+2,end), start:i+2, end});
 }
 return result;
}
function resolveLink(file, url) {
 if(/^[a-z][a-z0-9+.-]*:|^\/\//i.test(url)) return null;
 const [part,fragment] = url.split('#');
 const target = posix(path.relative(root, path.resolve(root, path.dirname(file), decodeURIComponent(part || path.basename(file)))));
 return {target, fragment:fragment ? decodeURIComponent(fragment) : null};
}
const errors=[]; const cached=new Map();
let checked=0, sourceLinks=0, omittedSources=0, incoming=0;
for(const file of [...new Set([...maps, ...entryDocs, ...tracked])]) {
 const text=read(file);
 if(isMap(file)) {
  const {explicit}=anchors(text);
  if(new Set(explicit).size!==explicit.length) errors.push(`${file}: duplicate explicit ID`);
 }
 for(const {url} of links(text)) {
  let link;
  try { link=resolveLink(file,url); } catch(e) { errors.push(`${file}: invalid link ${url}`); continue; }
  if(!link || (!fullCheck(file) && !isLinkTarget(link.target))) continue;
  checked++;
  if(!isMap(file) && isMap(link.target)) incoming++;
  if(link.target.startsWith('sources/')) {
   sourceLinks++;
   if(!exists(link.target) && !requireSources) { omittedSources++; continue; }
  }
  if(!exists(link.target)) { errors.push(`${file}: missing file ${url}`); continue; }
  if(link.fragment && /\.(md|qmd)$/.test(link.target)) {
   if(!cached.has(link.target)) cached.set(link.target,anchors(read(link.target)).ids);
   if(!cached.get(link.target).has(link.fragment)) errors.push(`${file}: missing anchor ${url}`);
  }
 }
}

// Migration audit: compare every nonblank original line, including numbers,
// external URLs, decision evidence and verification history. Only local link destinations, heading
// levels, explicit alias anchors and four documented positional phrases differ.
function normalize(text) {
 const replacements = [
  ['jsou v kartách níže;', 'jsou v odkazovaných kartách kapitol;'],
  ['otevři jejich karty níže.', 'otevři jejich samostatné karty.'],
  ['Bibliografické údaje níže identifikují', 'Bibliografické údaje v kartách identifikují'],
  ['Zjištěné konkrétní chyby níže neznamenají', 'Zjištěné konkrétní chyby v kartách neznamenají']
 ];
 for(const [a,b] of replacements) text=text.replaceAll(a,b);
 for(const l of links(text).reverse()) if(!/^[a-z][a-z0-9+.-]*:|^\/\//i.test(l.url)) {
  text=text.slice(0,l.start)+'LOCAL-LINK'+text.slice(l.end);
 }
 return text.split('\n').map(line=>line.replace(/^#+ /,'').trim())
  .filter(line=>line && !/^<a id="[^"]+"><\/a>$/.test(line));
}
function counter(lines) {
 const counts=new Map();
 for(const line of lines) counts.set(line,(counts.get(line)||0)+1);
 return counts;
}
// Each registered decision must have one complete record and one registry row.
// IDs are retained even for superseded decisions; ordinary historical headings
// and dated supplements are not separate decisions.
const decisionRows=[...read('docs/ROZHODNUTI.md').matchAll(/^\| .*?\[(R\d{2,})\]\(([^)]+)\)/gm)];
const decisionRecords=new Map();
for(const file of maps.filter(f=>f.startsWith('docs/rozhodnuti/'))) {
 for(const m of read(file).matchAll(/^## (R\d{2,}) — /gm)) {
  if(decisionRecords.has(m[1])) errors.push(`Duplicate decision record: ${m[1]}`);
  decisionRecords.set(m[1],file);
 }
}
const rowIds=new Set();
for(const [,id,url] of decisionRows) {
 if(rowIds.has(id)) errors.push(`Duplicate registry row: ${id}`);
 rowIds.add(id);
 const link=resolveLink('docs/ROZHODNUTI.md',url);
 if(!link || link.target!==decisionRecords.get(id)) errors.push(`Registry row has no matching record: ${id}`);
}
for(const id of decisionRecords.keys()) if(!rowIds.has(id)) errors.push(`Decision missing from registry: ${id}`);
if(!decisionRows.length) errors.push('Decision registry is empty');
let preservation=null;
if(baseline) {
 cp.execFileSync('git',['rev-parse','--verify',`${baseline}^{commit}`],{cwd:root});
 const oldMaps = mapRoots.map(f=>[f, cp.execFileSync('git',['show',`${baseline}:${f}`],{cwd:root,encoding:'utf8'}).replace(/\r\n/g,'\n')]);
 const oldLines = oldMaps.flatMap(([,t])=>normalize(t));
 const oldCounts=counter(oldLines), currentCounts=counter(maps.flatMap(f=>normalize(read(f))));
 for(const [line,n] of oldCounts) if((currentCounts.get(line)||0)<n) errors.push(`Lost original content (${n} occurrences): ${line}`);
 let legacyIds=0;
 for(const [f,t] of oldMaps) {
  const before=anchors(t).ids, after=anchors(read(f)).ids;
  for(const id of before) {
   legacyIds++;
   if(!after.has(id)) errors.push(`Lost legacy anchor: ${f}#${id}`);
  }
 }
 // When the baseline predates the split, additionally require every original
 // decision to survive in order in its own thematic file, rather than only
 // somewhere in the combined documentation.
 let preservedDecisions=0;
 const oldDecisionText=oldMaps.find(([f])=>f==='docs/ROZHODNUTI.md')[1];
 const sections=[...oldDecisionText.matchAll(/^## .+$/gm)];
 for(let i=0;i<sections.length;i++) {
  const match=sections[i][0].match(/^## (R\d{2,}) — /);
  if(!match) continue;
  const id=match[1], file=decisionRecords.get(id);
  if(!file) { errors.push(`Lost original decision: ${id}`); continue; }
  const expected=normalize(oldDecisionText.slice(sections[i].index,sections[i+1]?.index??oldDecisionText.length));
  const actual=normalize(read(file)); let cursor=0;
  for(const line of expected) {
   const at=actual.indexOf(line,cursor);
   if(at<0) { errors.push(`Changed/lost original line in ${id}: ${line}`); break; }
   cursor=at+1;
  }
  preservedDecisions++;
 }
 preservation={baseline,originalNonblankLines:oldLines.length,legacyIds,preservedDecisions};
}
const summary={mapFiles:maps.length,decisionRecords:decisionRecords.size,localLinks:checked,incomingLinks:incoming,sourceLinks,omittedSourceLinks:omittedSources,preservation,errors};
console.log(JSON.stringify(summary,null,2));
process.exitCode=errors.length ? 1 : 0;
