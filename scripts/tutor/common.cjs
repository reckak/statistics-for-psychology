const fs = require('node:fs');
const path = require('node:path');
const cp = require('node:child_process');
const crypto = require('node:crypto');

const root = path.resolve(__dirname, '../..');
const name = 'statistika-pro-psychology-ai-tutor';
const source = path.join(root, 'plugins', name);
const web = 'https://reckak.github.io/statistics-for-psychology/';
const posix = s => s.split(path.sep).join('/');
const read = p => fs.readFileSync(p, 'utf8').replace(/\r\n/g, '\n');
const hash = p => crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex');
const files = dir => fs.readdirSync(dir, {withFileTypes: true}).flatMap(e => {
  if (e.isSymbolicLink()) throw new Error(`Symlinks are not packaged: ${e.name}`);
  const p = path.join(dir, e.name);
  return e.isDirectory() ? files(p) : [p];
});
function run(command, args, options = {}) {
  const p = cp.spawnSync(command, args, {cwd: root, encoding: 'utf8', maxBuffer: 1 << 28, ...options});
  if (p.error || p.status !== 0) throw new Error(`${command}: ${p.error?.message || p.stderr || p.stdout}`);
  return p.stdout;
}
function executable(explicit, fallback, command) {
  if (explicit) return path.resolve(explicit);
  return fs.existsSync(fallback) ? fallback : command;
}
function quarto(explicit) {
  return executable(explicit, 'C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe', 'quarto');
}
function pandoc(q, args, input) {
  return run(q, ['pandoc', ...args], input === undefined ? {} : {input});
}
function parseSource(q, file, convert = true) {
  let text = read(path.join(root, file));
  if (/^`{3,}\{(?:r|python|julia|ojs)\b/m.test(text)) {
    throw new Error(`${file}: executable cells require an explicit export implementation`);
  }
  if (convert) {
    text = text.replace(/<!--\| quarto-html-table-processing: none -->\n/g, '');
    text = text.replace(/(<table [\s\S]*?<\/table>)/g, '```{=html}\n$1\n```');
  }
  const args = ['--from=markdown-smart', '--to=json'];
  if (convert) args.push('--lua-filter=scripts/tutor/prepare.lua');
  return JSON.parse(pandoc(q, args, text));
}
function nodes(value, type, out = []) {
  if (Array.isArray(value)) value.forEach(x => nodes(x, type, out));
  else if (value && typeof value === 'object') {
    if (!type || value.t === type) out.push(value);
    Object.values(value).forEach(x => nodes(x, type, out));
  }
  return out;
}
function attr(node) {
  if (node.t === 'Header') return node.c[1];
  if (['Div', 'Span', 'Image', 'Figure', 'Table', 'CodeBlock', 'Link'].includes(node.t)) return node.c[0];
  return null;
}
function text(value) {
  if (Array.isArray(value)) return value.map(text).join('');
  if (!value || typeof value !== 'object') return '';
  if (value.t === 'Str' || value.t === 'Code') return value.t === 'Str' ? value.c : value.c[1];
  if (['Space', 'SoftBreak', 'LineBreak'].includes(value.t)) return ' ';
  if (value.t === 'Math') return value.c[1];
  if (value.t === 'Header') return text(value.c[2]);
  if (['Link', 'Image', 'Span'].includes(value.t)) return text(value.c[1]);
  if (value.t === 'Cite') return text(value.c[1]);
  return text(value.c);
}
// The plugin skill keeps JSON-style frontmatter; Claude uploads get plain YAML keys.
const skillName = 'statistika-tutor';
const splitSkill = skill => {
  const m = skill.match(/^---\n([\s\S]*?)\n---\n/);
  if (!m) throw new Error('SKILL.md has no frontmatter');
  return {frontmatter: m[1], body: skill.slice(m[0].length)};
};
function claudeSkill(skill) {
  const {frontmatter, body} = splitSkill(skill);
  const meta = JSON.parse(frontmatter);
  // A JSON string is a valid YAML double-quoted scalar.
  return `---\nname: ${meta.name}\ndescription: ${JSON.stringify(meta.description)}\n---\n${body}`;
}
// Figure files differ by variant: the plugin (ChatGPT) ships the SVG sources, Claude PNG
// renderings and Gemini no image files. In the Gemini variant each figure keeps its numbered
// caption and text description; the image line becomes a pointer to the figure's register entry
// (web links in chapters made Gemini print addresses instead of drawing, test of 0.4.1).
const imageLine = /^!\[.*\]\(\.\.\/assets\/[^)\s]+\.(?:svg|png)\)(\{.*\})?$/;
// File name or image line of the PNG rendering of an SVG figure.
const pngName = s => s.replace(/\.svg(?=\)|$)/i, '.png');
const figureOpen = /^:{3,} \{#(fig-[^\s}]+)/;
function withoutImages(markdown) {
  const ids = [];
  let current = null;
  const lines = markdown.split('\n').map(line => {
    const open = line.match(figureOpen);
    if (open) current = open[1];
    if (!imageLine.test(line)) return line;
    if (!current) throw new Error(`Image outside a figure block: ${line.slice(0, 120)}`);
    ids.push(current);
    const replaced = `Obrázek: záznam ${current} v rejstříku obrázků kapitoly.`;
    current = null;
    return replaced;
  });
  return {markdown: lines.join('\n'), ids};
}
// The text-only variant has no image files, so its SKILL.md replaces the list of ways to show a figure.
const geminiStart = 'Cílem je obrázek **přímo v textu odpovědi**. Použij první možnost, kterou klient skutečně nabízí:\n';
const geminiEnd = '\nHodnoty obrázku neodhaduj z popisu.';
const geminiNote = [
  'Cílem je obrázek **přímo v textu odpovědi**. Soubory obrázků v této verzi přibalené nejsou:',
  '',
  '1. Má-li záznam obrázku blok „Data pro překreslení“, **překresli graf v odpovědi** podle oddílu o překreslení ve [VIZUALIZACE.md](references/VIZUALIZACE.md): stejné hodnoty, osy, popisky, vodicí čáry a značení. Uveď, že jde o překreslení obrázku učebnice s daným číslem. Graf z přibalených dat je ověřený obrázek učebnice, ne náhražka; popis ani adresa jej nenahrazují a adresu k němu nepřidávej.',
  '2. Je-li obrázek schéma bez dat nebo graf vykreslit nelze: popiš jej podle textového popisu a poznámky ke schématu, řekni, čeho si všimnout, a jednou připoj adresu „Stránka učebnice s obrázkem“ z rejstříku. U takového obrázku je popis s adresou úplným splněním pravidla o obrázku.',
  ''
].join('\n');
// Gemini accepts only CSV, PY, TXT and MD files in a skill, so its variant
// ships the registry and the code licence under a .txt name.
const geminiRenames = {'KAPITOLY.json': 'KAPITOLY.txt', LICENSE: 'LICENSE.txt'};
const geminiAllowed = /\.(csv|py|txt|md)$/i;
const geminiNames = s => s.split('KAPITOLY.json').join('KAPITOLY.txt').split('](LICENSE)').join('](LICENSE.txt)');
function geminiSkill(claudeText) {
  const from = claudeText.indexOf(geminiStart), to = claudeText.indexOf(geminiEnd);
  if (from < 0 || to < from || claudeText.indexOf(geminiStart, from + 1) >= 0) throw new Error('Figure options not found exactly once in SKILL.md');
  return geminiNames(claudeText.slice(0, from) + geminiNote + claudeText.slice(to));
}
const str = s => ({t: 'Str', c: s});
const para = s => ({t: 'Para', c: [str(s)]});
const link = (label, target) => ({t: 'Link', c: [['', [], []], [str(label)], [target, '']]});
// Every expository chapter of the book is bundled, in book order; the export
// asserts this list against the parsed _quarto.yml.
const chapterSources = [...read(path.join(root, '_quarto.yml'))
  .matchAll(/^\s*-\s*(quarto\/kapitola_\d+\.qmd)\s*$/gm)].map(m => m[1]);
if (!chapterSources.length) throw new Error('_quarto.yml lists no expository chapters');
const documents = [
  {id: 'index', source: 'index.qmd', output: 'uvod.md', kind: 'introduction'},
  ...chapterSources.map((source, i) => {
    const id = path.basename(source, '.qmd');
    return {id, source, output: `kapitoly/${id}.md`, kind: 'chapter', number: i + 1};
  }),
  ...['slovnicek', 'znaceni', 'excel'].map(id => ({id, source: `quarto/${id}.qmd`, output: `prehledy/${id}.md`, kind: 'overview'}))
];
// Line numbers of Markdown headings outside fenced code, in document order.
function headingLines(markdown) {
  const out = [];
  let fence = null;
  markdown.split('\n').forEach((line, i) => {
    const f = line.match(/^(`{3,}|~{3,})/);
    if (f) {
      if (!fence) fence = f[1][0];
      else if (f[1][0] === fence) fence = null;
      return;
    }
    const h = !fence && line.match(/^(#{1,6}) \S/);
    if (h) out.push({line: i + 1, level: h[1].length, text: line});
  });
  return out;
}
// A fenced Div ends at the next line made of exactly as many colons as its opener.
function divEnd(lines, start) {
  const fence = lines[start - 1].match(/^(:{3,})/)?.[1];
  if (!fence) throw new Error(`Line ${start} does not open a fenced div`);
  for (let i = start; i < lines.length; i++) if (lines[i] === fence) return i + 1;
  throw new Error(`Unclosed fenced div at line ${start}`);
}
const solutionOpen = (lines, i) => /^:{3,} callout-note$/.test(lines[i]) && lines[i + 1] === '**Ukázat řešení**';
// Chapters whose figures ship with data for redrawing (scripts/tutor/figure-data.R).
const figureDataChapters = documents.filter(d => d.kind === 'chapter').map(d => d.id);
const dataNumber = v => v === null ? '' : String(v);
// Columns every row of a mark must have; `kategorie` may stand for the position column.
const markColumns = {body: ['x|kategorie', 'y'], sloupce: ['x|kategorie', 'y'], histogram: ['od', 'do', 'cetnost|hustota|podil'], cara: ['x', 'y'],
  plocha: ['x', 'y'], interval: ['poloha|kategorie', 'od?', 'do?'], usecky: ['x0', 'y0', 'x1', 'y1'],
  krabice: ['poloha|kategorie', 'dolni_vous', 'q1', 'median', 'q3', 'horni_vous'], tabulka: []};
// Text fields follow CSV quoting, so that a comma inside a label does not split the row.
const dataText = v => /[",\n]/.test(v) ? `"${String(v).replace(/"/g, '""')}"` : String(v);
// The data of one figure as one plain-text block: no Markdown escaping, decimal points.
function figureDataBlock(fig) {
  const out = [`druh: ${fig.kind}`];
  if (fig.title) out.push(`titulek obrázku: ${fig.title}`);
  if (fig.note) out.push(`poznámka: ${fig.note}`);
  (fig.panels || []).forEach((p, i) => {
    out.push('', `panel ${i + 1} z ${fig.panels.length}: ${p.title}`, `typ: ${p.type}`);
    for (const axis of ['x', 'y']) {
      if (p[axis]) out.push(`osa ${axis}: ${p[axis].label}${p[axis].range ? `; rozsah ${dataNumber(p[axis].range[0])} až ${dataNumber(p[axis].range[1])}` : ''}`);
    }
    for (const g of p.guides || []) {
      const band = g.axis.match(/^pasmo ([xy])$/);
      if (band) { out.push(`vybarvené pásmo: ${band[1]} od ${dataNumber(g.value[0])} do ${dataNumber(g.value[1])}${g.label ? ` (${g.label})` : ''}`); continue; }
      const where = g.axis === 'x' ? `svislá v x = ${dataNumber(g.value)}` : g.axis === 'y' ? `vodorovná v y = ${dataNumber(g.value)}`
        : `přímka y = ${dataNumber(g.value[0])} + ${dataNumber(g.value[1])}·x`;
      out.push(`vodicí čára: ${where}${g.label ? ` (${g.label})` : ''}`);
    }
    if (p.note) out.push(`poznámka k panelu: ${p.note}`);
    for (const s of p.series) {
      out.push(`řada: ${s.name}; značka: ${s.mark}${s.direction ? `; směr: ${s.direction}` : ''}${s.arrangement ? `; uspořádání: ${s.arrangement}` : ''}; řádků: ${s.data.rows.length}${s.note ? `; ${s.note}` : ''}`,
        s.data.columns.join(','), ...s.data.rows.map(r => r.map(v => v === null ? '' : typeof v === 'number' ? dataNumber(v) : dataText(v)).join(',')));
    }
  });
  if (out.some(line => line.includes('```'))) throw new Error(`Fence inside figure data: ${fig.figure}`);
  return out;
}
const registerPath = id => `obrazky/${id}.md`;
// A diagram has a record but no values to redraw; the plan labels it 'schéma bez dat'.
const hasData = f => Boolean(f.data) && f.data.kind !== 'schema';
const dataLabel = f => hasData(f) ? `, s daty od řádku ${f.dataStart}` : f.data ? ', schéma bez dat' : '';
// One figure register per chapter; the Gemini variant has no image files.
function figureRegister(d, figures, withFiles) {
  const withData = figures.some(hasData);
  const out = [`# Obrázky kapitoly ${d.number}: ${d.title}`, '',
    withFiles
      ? 'U každého obrázku je číslo, popisek, textový popis, místo v kapitole, přibalený soubor obrázku a dvě webové adresy: stránka učebnice s obrázkem a samotný obrázek.'
      : 'Soubory obrázků nejsou v této verzi přibalené. U každého obrázku je číslo, popisek, textový popis, místo v kapitole, adresa stránky učebnice s obrázkem a řádek „Zobrazení“, který říká, jak obrázek ukázat.', '',
    withData
      ? 'Blok „Data pro překreslení“ obsahuje hodnoty, ze kterých je obrázek nakreslen (u rozsáhlých řad jejich výběr podle poznámky), a popis os, vodicích čar a zvýraznění. Čísla v bloku mají desetinnou tečku; v grafu i ve výkladu piš desetinnou čárku. Schéma bez dat má místo bloku nejvýše řádek „Poznámka ke schématu“ s počty a rozmístěním prvků.'
      : 'K obrázkům této kapitoly zatím nejsou přibalena data pro překreslení.', ''];
  for (const f of figures) {
    out.push(`## Obrázek ${f.number} {#${f.id}}`, '',
      `Popisek: ${f.caption}`, '',
      `Textový popis: ${mdEscape(f.alt)}`, '',
      `[V kapitole](../${d.output}#${f.id})${withFiles ? ` · [Soubor obrázku](../${f.file})` : ''}`, '',
      `Stránka učebnice s obrázkem: ${f.web}`, '',
      withFiles ? `Samotný obrázek na webu: ${f.image}`
        : hasData(f) ? 'Zobrazení: překresli graf z bloku dat níže; adresu nepřidávej.' : 'Zobrazení: popiš obrázek a připoj adresu stránky učebnice.', '');
    if (hasData(f)) out.push('Data pro překreslení:', '', '```text', ...figureDataBlock(f.data), '```', '');
    else if (f.data || withData) {
      out.push('Data pro překreslení: obrázek je schéma bez dat.', '');
      if (f.data?.note) out.push(`Poznámka ke schématu: ${mdEscape(f.data.note)}`, '');
    }
  }
  return out.join('\n');
}
// Line range of every figure entry in a chapter register (heading to the line before the next entry).
function registerRanges(markdown) {
  const lines = markdown.split('\n');
  const marks = headingLines(markdown).filter(h => h.level === 2);
  return new Map(marks.map((h, i) => {
    let end = (marks[i + 1] ? marks[i + 1].line : lines.length + 1) - 1;
    while (lines[end - 1].trim() === '') end--;
    return [h.text.match(/\{#([^}]+)\}/)[1], [h.line, end]];
  }));
}
// Line of 'Data pro překreslení:' in every figure entry that has a data block.
function registerDataStarts(markdown) {
  const lines = markdown.split('\n');
  return new Map([...registerRanges(markdown)].map(([id, [start, end]]) => {
    const at = lines.slice(start - 1, end).indexOf('Data pro překreslení:');
    return [id, at < 0 ? null : start + at];
  }));
}
// Plain text written into generated Markdown must not be read as markup.
const mdEscape = s => s.replace(/[\`*_[]<>$~^|]/g, '\$&');
// Inline Markdown of a caption: keeps math delimiters, emphasis and code.
function inlineMd(value) {
  if (Array.isArray(value)) return value.map(inlineMd).join('');
  if (!value || typeof value !== 'object') return '';
  if (value.t === 'Str') return mdEscape(value.c);
  if (['Space', 'SoftBreak', 'LineBreak'].includes(value.t)) return ' ';
  if (value.t === 'Math') return `$${value.c[1]}$`;
  if (value.t === 'Code') return '`' + value.c[1] + '`';
  if (value.t === 'Strong') return `**${inlineMd(value.c)}**`;
  if (value.t === 'Emph') return `*${inlineMd(value.c)}*`;
  if (['Link', 'Span', 'Image'].includes(value.t)) return inlineMd(value.c[1]);
  return inlineMd(value.c);
}
const figuresLine = withFiles => withFiles
  ? 'Rejstřík obrázků každé kapitoly uvádí číslo, popisek, textový popis, přibalený soubor obrázku, webové adresy a data pro překreslení.'
  : 'Rejstřík obrázků každé kapitoly uvádí číslo, popisek, textový popis, webové adresy a data pro překreslení. Soubory obrázků nejsou přibalené.';

module.exports = {root, name, source, web, posix, read, hash, files, run, quarto, pandoc, parseSource, nodes, attr, text, str, para, link, documents,
  skillName, splitSkill, claudeSkill, imageLine, pngName, withoutImages, geminiSkill, geminiNote,
  geminiRenames, geminiAllowed, geminiNames, headingLines, divEnd, solutionOpen, figureRegister, figuresLine, inlineMd,
  figureDataChapters, figureDataBlock, markColumns, hasData, dataLabel, registerPath, registerRanges, registerDataStarts};
