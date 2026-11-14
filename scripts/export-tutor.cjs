// Windows authoring command; student use requires neither these tools nor local files.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const c = require('./tutor/common.cjs');
const {root, name, source, web, posix, read, hash, files, run, quarto, pandoc,
  parseSource, nodes, attr, text, str, para, link, documents, skillName, claudeSkill, withoutImages, geminiSkill} = c;
const {bookChapters, cardFor, createPlan} = require('./tutor/plans.cjs');
const args = process.argv.slice(2);
const option = flag => args.includes(flag) ? args[args.indexOf(flag) + 1] : undefined;
for (const arg of args.filter(x => x.startsWith('--'))) {
  assert(['--quarto', '--rscript', '--skip-figures'].includes(arg), `Unknown option: ${arg}`);
}
const q = quarto(option('--quarto'));
const book = bookChapters(q);
const bundled = book.filter(d => documents.some(x => x.kind === 'chapter' && x.id === d.id));
assert.deepEqual(bundled.map(d => d.id), documents.filter(d => d.kind === 'chapter').map(d => d.id), 'Export order must follow the book');
const manifest = JSON.parse(read(path.join(source, 'plugin.json')));
const version = manifest.version;
assert.equal(manifest.name, name);
assert.match(version, /^\d+\.\d+\.\d+$/);
assert(manifest.extensions['com.openai'].interface.shortDescription.length <= 30);
const workRoot = path.join(root, 'tmp');
fs.mkdirSync(workRoot, {recursive: true});
const work = fs.mkdtempSync(path.join(workRoot, 'tutor-export-'));
const stage = path.join(work, name);
fs.cpSync(source, stage, {recursive: true});
const refs = path.join(stage, 'skills/statistika-tutor/references');
const write = (relative, body) => {
  const target = path.join(refs, relative);
  fs.mkdirSync(path.dirname(target), {recursive: true});
  fs.writeFileSync(target, body, 'utf8');
};

if (!args.includes('--skip-figures')) {
  const r = option('--rscript') || (fs.existsSync('C:/Program Files/R/R-4.5.1/bin/Rscript.exe') ?
    'C:/Program Files/R/R-4.5.1/bin/Rscript.exe' : 'Rscript');
  for (let n = 1; n <= 6; n++) {
    const nn = String(n).padStart(2, '0');
    console.log(`Obrázky kapitoly ${n}/6`);
    run(r, ['--vanilla', '-e', `Sys.setlocale('LC_CTYPE', '.UTF-8'); source('scripts/kapitola_${nn}.R', encoding='UTF-8')`]);
  }
}

const sourceRevision = run('git', ['rev-parse', 'HEAD']).trim();
const inputPaths = [...new Set([...documents.map(d => d.source), ...book.map(d => d.source),
  '_quarto.yml', ...bundled.map(d => cardFor(d.number)),
  ...Array.from({length: 6}, (_, i) => `scripts/kapitola_0${i + 1}.R`),
  'references.bib', 'styles/apa.csl', 'LICENSE-TEXT.md',
  'LICENSE', 'scripts/export-tutor.cjs', 'scripts/check-tutor.cjs', 'scripts/tutor/common.cjs', 'scripts/tutor/prepare.lua', 'scripts/tutor/plans.cjs',
  ...files(source).map(f => posix(path.relative(root, f)))])];
const inputs = Object.fromEntries(inputPaths.map(f => [f, hash(path.join(root, f))]));
const sourceDirty = run('git', ['status', '--porcelain', '--', ...inputPaths]).trim() !== '';
const stamp = new Intl.DateTimeFormat('sv-SE', {timeZone: 'Europe/Prague', dateStyle: 'short'}).format(new Date());
const docs = documents.map(d => ({...d, ast: parseSource(q, d.source)}));
const idMap = new Map();
const pages = new Map(docs.map(d => [d.id, d]));

// A missing chapter may still be an authored cross-reference target, never bundled content.
for (const d of book.filter(d => !pages.has(d.id))) {
  pages.set(d.id, {...d, external: true, ast: parseSource(q, d.source)});
}
for (const d of pages.values()) {
  let figure = 0, table = 0;
  d.title = text(nodes(d.ast.blocks, 'Header')[0].c[2]);
  d.ids = new Set();
  for (const node of nodes(d.ast.blocks)) {
    const a = attr(node);
    if (!a?.[0]) continue;
    const id = a[0];
    assert(!d.ids.has(id), `${d.source}: duplicate identifier ${id}`);
    d.ids.add(id);
    const record = {doc: d, id};
    if (id.startsWith('fig-')) Object.assign(record, {label: 'Obrázek', number: `${d.number}.${++figure}`});
    if (id.startsWith('tbl-')) Object.assign(record, {label: 'Tabulka', number: d.number ? `${d.number}.${++table}` : ''});
    if (node.t === 'Header') record.title = text(node.c[2]);
    if (!idMap.has(id)) idMap.set(id, []);
    idMap.get(id).push(record);
  }
}

function targetFor(from, to, fragment = '') {
  if (to.external) return `${web}quarto/${to.id}.html${fragment ? '#' + fragment : ''}`;
  const relative = from.output === to.output ? '' : posix(path.relative(path.dirname(from.output), to.output));
  return `${relative}${fragment ? '#' + fragment : ''}` || path.basename(to.output);
}
function crossReferences(value, d) {
  if (Array.isArray(value)) {
    const result = [];
    for (const item of value) {
      const changed = crossReferences(item, d);
      if (item?.t === 'Cite' && Array.isArray(changed)) result.push(...changed);
      else result.push(changed);
    }
    return result;
  }
  if (!value || typeof value !== 'object') return value;
  if (value.t === 'Cite') {
    const flags = value.c[0].map(x => /^(fig|tbl|sec|eq|lst)-/.test(x.citationId));
    if (flags.some(Boolean)) {
      assert(flags.every(Boolean), `${d.source}: mixed bibliographic and cross-reference citation`);
      return value.c[0].flatMap((citation, i) => {
        const matches = idMap.get(citation.citationId) || [];
        const r = matches.find(m => m.doc.id === d.id) || (matches.length === 1 ? matches[0] : null);
        assert(r, `${d.source}: missing cross-reference ${citation.citationId}`);
        const label = r.number ? (citation.citationMode.t === 'SuppressAuthor' ? r.number : `${r.label} ${r.number}`) : r.title;
        assert(label, `Missing cross-reference label: ${r.id}`);
        return [...(i ? [str('; ')] : []), ...citation.citationPrefix,
          link(label, targetFor(d, r.doc, r.id)), ...citation.citationSuffix];
      });
    }
    return value;
  }
  return Object.fromEntries(Object.entries(value).map(([key, v]) => [key, crossReferences(v, d)]));
}

for (const d of docs) d.ast.blocks = crossReferences(d.ast.blocks, d);
const citedKeys = [...new Set(docs.flatMap(d => nodes(d.ast.blocks, 'Cite').flatMap(n => n.c[0].map(x => x.citationId))))].sort();
// One citeproc pass keeps name/year disambiguation identical across all files and the book.
const combined = {
  'pandoc-api-version': docs[0].ast['pandoc-api-version'],
  meta: {
    bibliography: {t: 'MetaString', c: 'references.bib'},
    csl: {t: 'MetaString', c: 'styles/apa.csl'},
    lang: {t: 'MetaString', c: 'cs'},
    'link-citations': {t: 'MetaBool', c: true},
    nocite: {t: 'MetaInlines', c: [{t: 'Cite', c: [[{citationId: '*', citationPrefix: [], citationSuffix: [],
      citationMode: {t: 'NormalCitation'}, citationNoteNum: 0, citationHash: 0}], [str('[@*]')]]}]}
  },
  blocks: docs.map(d => ({t: 'Div', c: [[`tutor-document-${d.id}`, [], []], d.ast.blocks]}))
};
const cited = JSON.parse(pandoc(q, ['--from=json', '--to=json', '--citeproc'], JSON.stringify(combined)));
const bibliography = cited.blocks.find(b => b.t === 'Div' && b.c[0][0] === 'refs');
assert(bibliography, 'Citation processor did not produce a bibliography');
bibliography.c[1] = bibliography.c[1].filter(b => citedKeys.includes(b.c?.[0]?.[0]?.replace(/^ref-/, '')));
assert.equal(bibliography.c[1].length, citedKeys.length, 'Incomplete bibliography');
// Pandoc's Markdown writer deliberately suppresses a generated Div named "refs".
// Keep the entry anchors, but serialize the already formatted bibliography as prose.
bibliography.c[0] = ['literatura-zdroje', [], []];
for (const item of bibliography.c[1]) item.c[0][1] = [];
const literature = {id: 'literatura', output: 'literatura.md', title: 'Literatura citovaná v přibalených materiálech', ids: new Set(['literatura-zdroje', ...citedKeys.map(k => `ref-${k}`)])};
pages.set(literature.id, literature);

function rewriteTarget(target, d) {
  if (/^[a-z][a-z0-9+.-]*:|^\/\//i.test(target)) return target;
  const [part, fragment = ''] = target.split('#');
  if (!part) {
    if (fragment.startsWith('ref-')) return targetFor(d, literature, fragment);
    assert(d.ids.has(fragment), `${d.id}: missing local anchor ${fragment}`);
    return target;
  }
  const page = path.basename(part).replace(/\.(qmd|html)$/, '');
  if (pages.has(page)) return targetFor(d, pages.get(page), fragment);
  // Interactive visualizations and the tutor download page are not bundled; they live only on the web.
  if ((/^viz_[a-z0-9_]+$/.test(page) || page === 'ai_tutor') &&fs.existsSync(path.join(root, 'quarto', `${page}.qmd`))) return `${web}quarto/${page}.html${fragment ? '#' + fragment : ''}`;
  if (/\.xlsx$/i.test(part) && /(?:^|\/)data\//.test(part)) return `${web}data/${path.basename(part)}`;
  if (/\.md$/.test(part)) return target; // Already rewritten cross-reference.
  throw new Error(`${d.source || d.id}: unhandled relative link ${target}`);
}

const assetFiles = new Map();
function finish(value, d) {
  if (Array.isArray(value)) return value.map(x => finish(x, d));
  if (!value || typeof value !== 'object') return value;
  if (value.t === 'Cite') {
    return {t: 'Span', c: [['', ['citation'], [['data-cites', value.c[0].map(x => x.citationId).join(' ')]]], finish(value.c[1], d)]};
  }
  const copy = Object.fromEntries(Object.entries(value).map(([k, v]) => [k, finish(v, d)]));
  if (copy.t === 'Link') copy.c[2][0] = rewriteTarget(copy.c[2][0], d);
  if (copy.t === 'Image') {
    const sourceFile = path.resolve(root, path.dirname(d.source), copy.c[2][0]);
    const relative = posix(path.relative(path.join(root, 'assets'), sourceFile));
    assert(relative && !relative.startsWith('../') && !path.isAbsolute(relative), `Image outside assets/: ${sourceFile}`);
    const output = `assets/${relative}`;
    assetFiles.set(output, sourceFile);
    copy.c[2][0] = posix(path.relative(path.dirname(d.output), output));
  }
  if (copy.t === 'Figure') {
    for (const image of nodes(copy.c[2], 'Image')) {
      const alt = image.c[0][2].find(([key]) => key === 'fig-alt')?.[1];
      assert(alt, `${d.source}: figure without a text description`);
      copy.c[2].push(para(`Textový popis obrázku: ${alt}`));
    }
    const record = idMap.get(copy.c[0][0])?.find(r => r.doc.id === d.id);
    const label = record?.number ? `${record.label} ${record.number}: ` : '';
    const captions = copy.c[1][1].map(block => ({t: 'Para', c: [str(label), ...block.c]}));
    // A multi-block Figure would be emitted as raw HTML, hiding math and anchors
    // from Markdown readers. A fenced Div keeps the original figure identifier.
    return {t: 'Div', c: [copy.c[0], [...copy.c[2], ...captions]]};
  }
  if (copy.t === 'Table') {
    const record = idMap.get(copy.c[0][0])?.find(r => r.doc.id === d.id);
    if (record?.number && copy.c[1][1][0]) {
      copy.c[1][1][0].c.unshift(str(`${record.label} ${record.number}: `));
    }
  }
  return copy;
}

const writer = ['--from=json', '--to=markdown-smart+pipe_tables-simple_tables-multiline_tables-grid_tables+tex_math_dollars+fenced_divs+bracketed_spans',
  '--wrap=none', '--columns=120'];
const exported = [];
for (const d of docs) {
  const wrapper = cited.blocks.find(b => b.t === 'Div' && b.c[0][0] === `tutor-document-${d.id}`);
  assert(wrapper, `Document lost during citation processing: ${d.id}`);
  const out = {...d.ast, meta: {}, blocks: finish(wrapper.c[1], d)};
  const markdown = pandoc(q, writer, JSON.stringify(out));
  write(d.output, markdown);
  exported.push({...d, markdown, out});
}
write(literature.output, pandoc(q, writer, JSON.stringify({
  'pandoc-api-version': cited['pandoc-api-version'], meta: {},
  blocks: [{t: 'Header', c: [1, ['literatura-tutora', [], []], [str(literature.title)]]}, finish(bibliography, literature)]
})));
for (const [output, input] of assetFiles) {
  const dest = path.join(refs, output);
  fs.mkdirSync(path.dirname(dest), {recursive: true});
  fs.copyFileSync(input, dest);
}
fs.copyFileSync(path.join(root, 'LICENSE-TEXT.md'), path.join(refs, 'LICENCE.md'));
fs.copyFileSync(path.join(root, 'LICENSE'), path.join(refs, 'LICENSE'));
fs.writeFileSync(path.join(stage, 'README.md'), `# Statistika pro psychology – AI tutor\n\n` +
  `Verze ${version}; autor Karel Rečka.\n\n` +
  'Vyber plugin v ChatGPT a uveď téma a režim: vysvětlení, sokratovské vedení, procvičování nebo zkoušení.\n\n' +
  'Kapitoly 1–6 a tři celé aktuální přehledy jsou přibalené; nemusíš je nahrávat. Úplné kapitoly 7–8 nejsou součástí této verze.\n\n' +
  '[Obsah podkladů](skills/statistika-tutor/references/INDEX.md) · ' +
  '[Údržba a distribuce](skills/statistika-tutor/references/PRIPOJENI-KAPITOL.md) · ' +
  '[Původ a licence](skills/statistika-tutor/references/LICENCE.md)\n\n' +
  'Instrukce usměrňují jazykový model, nezaručují bezchybnost odpovědí. Zkoušení je formativní nácvik.\n', 'utf8');

const entry = d => ({id: d.id, title: d.title, path: d.output, source: d.source,
  sha256: hash(path.join(refs, d.output)), bytes: Buffer.byteLength(d.markdown),
  headings: nodes(d.out.blocks, 'Header').map(h => ({id: h.c[1][0], title: text(h.c[2]), level: h.c[0]}))});
const plans = [];
for (const d of exported.filter(d => d.kind === 'chapter')) {
  const plan = createPlan({d, exported, pages, q, writer, version, stamp, sourceRevision});
  const output = `plany/${d.id}.md`;
  write(output, plan.markdown);
  plans.push({chapter: d.id, path: output, card: plan.card, sha256: hash(path.join(refs, output)),
    concepts: plan.concepts,
    optional_blocks: plan.scope.optionalBlocks.map(x => x.id),
    headings: plan.scope.headings});
}
const chapterEntries = book.map(b => {
  const d = exported.find(d => d.id === b.id);
  const page = pages.get(b.id);
  return {...(d ? entry(d) : {id: b.id, title: page.title, source: b.source, path: null}),
    number: b.number, availability: d ? 'bundled' : 'web_only',
    web_url: `${web}quarto/${b.id}.html`, plan: plans.find(p => p.chapter === b.id)?.path || null};
});
const chapterMenu = chapterEntries.filter(d => d.availability === 'bundled')
  .map(d => `${d.number}. **${d.title}** — [výukový plán](references/${d.plan})`).join('\n');
const skillPath = path.join(stage, 'skills/statistika-tutor/SKILL.md');
const template = read(skillPath);
assert.equal(template.split('<!-- tutor:chapter-menu -->').length, 2, 'One generated chapter-menu slot required');
fs.writeFileSync(skillPath, template.replace('<!-- tutor:chapter-menu -->', chapterMenu), 'utf8');
const catalog = {
  schema_version: 2, package_version: version, updated: stamp, status: 'chapters_available',
  source_revision: sourceRevision, source_dirty: sourceDirty, reference_package: 'REFERENCE.md', index: 'INDEX.md',
  notice: 'Úplný výklad kapitol 1–6; celé aktuální přehledy obsahují i hesla kapitol 7–8. Úplné kapitoly 7–8 nejsou přibalené.',
  chapters: chapterEntries, plans,
  overviews: exported.filter(d => d.kind === 'overview').map(entry),
  introduction: entry(exported.find(d => d.kind === 'introduction')),
  bibliography: {path: literature.output, citation_keys: citedKeys, sha256: hash(path.join(refs, literature.output))},
  source_hashes: inputs
};
write('KAPITOLY.json', JSON.stringify(catalog, null, 2) + '\n');
const index = [`# Obsah podkladů AI tutora`, '', `Verze ${version}; snímek učebnice z ${stamp}.`, '',
  'Student nemusí nahrávat kapitoly 1–6 ani tři přehledy. Načítej potřebný oddíl, nikoli všechny soubory najednou.', '',
  'Úplné kapitoly 7–8 nejsou přibalené. Hesla z těchto kapitol jsou dostupná ve třech přehledech; jejich odkazy na výklad vedou na web.', '',
  '[O učebnici a původu dat](uvod.md) · [Krátká reference](REFERENCE.md) · [Literatura](literatura.md) · [Licence](LICENCE.md)', '',
  '## Výkladové kapitoly', ''];
index.push('### Katalog celé učebnice', '', '| Kapitola | Dostupnost |', '|---|---|');
for (const d of chapterEntries) index.push(`| ${d.number}. ${d.title} | ${d.availability === 'bundled' ? `[Úplný text](${d.path}) · [výukový plán](${d.plan})` : `[Webový výklad](${d.web_url}); v balíčku pouze hesla přehledů`} |`);
index.push('', '### Oddíly přibalených kapitol', '');
for (const d of exported.filter(d => d.kind === 'chapter')) {
  index.push(`### ${d.number}. ${d.title}`, '', `[Celá kapitola](${d.output}) · [Výukový plán](plany/${d.id}.md)`, '');
  for (const h of nodes(d.out.blocks, 'Header').filter(h => h.c[0] === 2)) {
    index.push(`- [${text(h.c[2])}](${d.output}#${h.c[1][0]})`);
  }
  index.push('');
}
index.push('## Celé aktuální přehledy', '');
for (const d of exported.filter(d => d.kind === 'overview')) {
  const count = nodes(d.out.blocks, 'Header').filter(h => h.c[0] === 2).length;
  index.push(`- [${d.title}](${d.output}) — ${count} hesel; vyhledej název, značku nebo funkci a načti konkrétní heslo.`);
}
index.push('', 'Registr KAPITOLY.json rozlišuje katalog celé knihy, přibalené kapitoly a šest výukových plánů. Obsahuje přesná ID, zdrojovou verzi a otisky souborů; načítej potřebný záznam.', '');
write('INDEX.md', index.join('\n'));

// Claude skill upload: one folder named after the skill, the same references,
// YAML frontmatter and no plugin manifests or logo.
const claudeStage = path.join(work, 'claude');
const claudeDir = path.join(claudeStage, skillName);
fs.cpSync(path.join(stage, 'skills', skillName), claudeDir, {recursive: true});
fs.writeFileSync(path.join(claudeDir, 'SKILL.md'), claudeSkill(read(path.join(claudeDir, 'SKILL.md'))), 'utf8');

// Gemini skill upload: the Claude folder without SVG files (Gemini limits the
// file count), web links instead of images and a generated figure register.
const geminiStage = path.join(work, 'gemini');
const geminiDir = path.join(geminiStage, skillName);
const geminiRefs = path.join(geminiDir, 'references');
fs.cpSync(claudeDir, geminiDir, {recursive: true});
fs.rmSync(path.join(geminiRefs, 'assets'), {recursive: true});
fs.writeFileSync(path.join(geminiDir, 'SKILL.md'), geminiSkill(read(path.join(geminiDir, 'SKILL.md'))), 'utf8');
const figures = [];
for (const d of exported.filter(d => d.kind === 'chapter')) {
  const webPage = `${web}quarto/${d.id}.html`;
  const file = path.join(geminiRefs, d.output);
  const {markdown, ids} = withoutImages(read(file), webPage);
  fs.writeFileSync(file, markdown, 'utf8');
  const blocks = nodes(d.out.blocks, 'Div').filter(div => div.c[0][0].startsWith('fig-') && nodes(div.c[1], 'Image').length);
  assert.deepEqual(ids, blocks.map(div => div.c[0][0]), `${d.id}: figure blocks and replaced images`);
  for (const div of blocks) {
    const images = nodes(div.c[1], 'Image');
    assert.equal(images.length, 1, `${d.id}/${div.c[0][0]}: one image per figure`);
    const record = idMap.get(div.c[0][0]).find(r => r.doc.id === d.id);
    const alt = images[0].c[0][2].find(([key]) => key === 'fig-alt')?.[1];
    assert(record?.number && alt, `${d.id}/${div.c[0][0]}: number and text description`);
    figures.push({chapter: d, id: div.c[0][0], number: record.number, caption: text(images[0].c[1]), alt, web: `${webPage}#${div.c[0][0]}`});
  }
}
assert.equal(figures.length, nodes(exported.filter(d => d.kind === 'chapter').map(d => d.out.blocks), 'Image').length,
  'Every chapter image has a register entry');
const register = ['# Rejstřík obrázků učebnice', '',
  'Soubory obrázků nejsou v této verzi přibalené. U každého obrázku je číslo, popisek, textový popis, místo v kapitole a odkaz na obrázek ve webové učebnici.', ''];
for (const d of exported.filter(d => d.kind === 'chapter')) {
  register.push(`## ${d.number}. ${d.title} {#obrazky-${d.id}}`, '');
  for (const f of figures.filter(f => f.chapter === d)) {
    register.push(`### Obrázek ${f.number}: ${f.caption} {#${f.id}}`, '',
      `Textový popis: ${f.alt}`, '',
      `[V kapitole](${d.output}#${f.id}) · [Ve webové učebnici](${f.web})`, '');
  }
}
fs.writeFileSync(path.join(geminiRefs, 'obrazky.md'), register.join('\n'), 'utf8');
fs.appendFileSync(path.join(geminiRefs, 'INDEX.md'),
  '\n## Obrázky\n\n[Rejstřík obrázků](obrazky.md) — číslo, popisek, textový popis a webový odkaz ke každému obrázku; soubory obrázků nejsou přibalené.\n', 'utf8');
const geminiCatalog = JSON.parse(read(path.join(geminiRefs, 'KAPITOLY.json')));
geminiCatalog.images = 'web_only';
for (const chapter of geminiCatalog.chapters.filter(c => c.availability === 'bundled')) {
  chapter.sha256 = hash(path.join(geminiRefs, chapter.path));
}
geminiCatalog.figures = {path: 'obrazky.md', count: figures.length, sha256: hash(path.join(geminiRefs, 'obrazky.md'))};
fs.writeFileSync(path.join(geminiRefs, 'KAPITOLY.json'), JSON.stringify(geminiCatalog, null, 2) + '\n', 'utf8');

// Validate the complete staged packages before replacing a previous release artifact.
const validation = JSON.parse(run(process.execPath, ['scripts/check-tutor.cjs', '--package', stage, '--claude', claudeDir, '--gemini', geminiDir, '--quarto', q]));
console.log(JSON.stringify(validation));
for (const [file, digest] of Object.entries(inputs)) assert.equal(hash(path.join(root, file)), digest, `Input changed during export: ${file}`);
for (const [output, input] of assetFiles) assert.equal(hash(path.join(refs, output)), hash(input));

const psQuote = s => `'${s.replace(/'/g, "''")}'`;
const inventoryOf = base => files(base).map(f => ({path: posix(path.relative(base, f)), bytes: fs.statSync(f).size, sha256: hash(f)}));
function zipDirectory(base, zipPath) {
  const inventory = inventoryOf(base);
  // Windows PowerShell's older .NET writes backslashes with CreateFromDirectory.
  // Explicit POSIX entry names make the same archive portable to cloud clients.
  const createZip = `$ErrorActionPreference='Stop'; Add-Type -AssemblyName System.IO.Compression; Add-Type -AssemblyName System.IO.Compression.FileSystem; $base=${psQuote(base)}; $zip=[IO.Compression.ZipFile]::Open(${psQuote(zipPath)}, [IO.Compression.ZipArchiveMode]::Create); try { foreach($file in Get-ChildItem -LiteralPath $base -File -Recurse -Force) { $relative=$file.FullName.Substring($base.Length+1).Replace([char]92,[char]47); [IO.Compression.ZipFileExtensions]::CreateEntryFromFile($zip, $file.FullName, $relative, [IO.Compression.CompressionLevel]::Optimal) | Out-Null } } finally { $zip.Dispose() }`;
  run('powershell.exe', ['-NoProfile', '-Command', createZip]);
  // Read every archive member independently with .NET, including hidden compatibility files.
  const checkZip = `$ErrorActionPreference='Stop'; Add-Type -AssemblyName System.IO.Compression.FileSystem; $zip=[IO.Compression.ZipFile]::OpenRead(${psQuote(zipPath)}); try { $rows=@(foreach($entry in $zip.Entries) { $stream=$entry.Open(); try { $sha=[Security.Cryptography.SHA256]::Create(); $digest=([BitConverter]::ToString($sha.ComputeHash($stream))).Replace('-','').ToLowerInvariant(); [pscustomobject]@{path=$entry.FullName; bytes=$entry.Length; sha256=$digest} } finally { $stream.Dispose() } }); ConvertTo-Json -InputObject $rows -Compress } finally { $zip.Dispose() }`;
  const archiveMembers = JSON.parse(run('powershell.exe', ['-NoProfile', '-Command', checkZip]));
  archiveMembers.sort((a, b) => a.path.localeCompare(b.path));
  inventory.sort((a, b) => a.path.localeCompare(b.path));
  assert.equal(archiveMembers.length, inventory.length, `Archive member count: ${zipPath}`);
  for (let i = 0; i < inventory.length; i++) assert.deepEqual(archiveMembers[i], inventory[i], `Archive member ${inventory[i].path}`);
  return inventory;
}
// Student-facing names follow the pattern statistika-tutor-<platform>-<version>.zip;
// the plugin name inside the manifests stays unchanged.
const chatgptArchiveName = `${skillName}-chatGPT-${version}.zip`;
const stageArchive = path.join(work, chatgptArchiveName);
const inventory = zipDirectory(stage, stageArchive);
const claudeArchiveName = `${skillName}-claude-${version}.zip`;
const claudeStageArchive = path.join(work, claudeArchiveName);
const claudeInventory = zipDirectory(claudeStage, claudeStageArchive);
assert(claudeInventory.every(f => f.path.startsWith(`${skillName}/`)), 'Claude archive must have one skill folder at its root');
const geminiArchiveName = `${skillName}-gemini-${version}.zip`;
const geminiStageArchive = path.join(work, geminiArchiveName);
const geminiInventory = zipDirectory(geminiStage, geminiStageArchive);
assert(geminiInventory.every(f => f.path.startsWith(`${skillName}/`)), 'Gemini archive must have one skill folder at its root');
const report = {version, source_revision: sourceRevision, source_dirty: sourceDirty, date: stamp, package_directory: stage,
  files: inventory, chapters: bundled.length, catalog_chapters: catalog.chapters.length, plans: plans.length, overviews: catalog.overviews.length,
  overview_entries: catalog.overviews.map(d => ({id: d.id, entries: d.headings.filter(h => h.level === 2).length})),
  images: assetFiles.size, citations: citedKeys.length, validation, archive_sha256: hash(stageArchive),
  claude: {skill_directory: claudeDir, files: claudeInventory, archive_sha256: hash(claudeStageArchive)},
  gemini: {skill_directory: geminiDir, files: geminiInventory, figures: figures.length, archive_sha256: hash(geminiStageArchive)}};
fs.writeFileSync(path.join(work, 'inventory.json'), JSON.stringify(report, null, 2) + '\n');
// Finished packages live in ai-tutor/<platform>/; the shared report sits in ai-tutor/.
const output = path.join(root, 'ai-tutor');
const target = platform => {
  const dir = path.join(output, platform);
  fs.mkdirSync(dir, {recursive: true});
  return dir;
};
const archive = path.join(target('chatgpt'), chatgptArchiveName);
const claudeArchive = path.join(target('claude'), claudeArchiveName);
const geminiArchive = path.join(target('gemini'), geminiArchiveName);
fs.copyFileSync(stageArchive, archive);
fs.copyFileSync(claudeStageArchive, claudeArchive);
fs.copyFileSync(geminiStageArchive, geminiArchive);
report.claude.archive = claudeArchive;
report.gemini.archive = geminiArchive;
fs.writeFileSync(path.join(output, 'overeni.json'), JSON.stringify({...report, archive}, null, 2) + '\n');
// Only after success: earlier work folders are superseded; overeni.json points to this one.
for (const entry of fs.readdirSync(workRoot, {withFileTypes: true})) {
  if (entry.isDirectory() && entry.name.startsWith('tutor-export-') && entry.name !== path.basename(work)) {
    fs.rmSync(path.join(workRoot, entry.name), {recursive: true, force: true});
  }
}
console.log(JSON.stringify({archive, claudeArchive, geminiArchive, geminiFiles: geminiInventory.length, figures: figures.length,
  package: stage, version, chapters: report.chapters,
  overviews: report.overview_entries, images: report.images, citations: report.citations}, null, 2));
