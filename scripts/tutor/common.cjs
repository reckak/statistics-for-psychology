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
// Gemini rejects skill folders with too many files, so its variant ships no SVG.
// Each figure keeps its numbered caption and text description; the image line
// becomes a link to the same figure in the web book.
const imageLine = /^!\[.*\]\(\.\.\/assets\/[^)\s]+\.svg\)(\{.*\})?$/;
const figureOpen = /^:{3,} \{#(fig-[^\s}]+)/;
function withoutImages(markdown, webPage) {
  const ids = [];
  let current = null;
  const lines = markdown.split('\n').map(line => {
    const open = line.match(figureOpen);
    if (open) current = open[1];
    if (!imageLine.test(line)) return line;
    if (!current) throw new Error(`Image outside a figure block: ${line.slice(0, 120)}`);
    ids.push(current);
    const replaced = `[Obrázek ve webové učebnici](${webPage}#${current})`;
    current = null;
    return replaced;
  });
  return {markdown: lines.join('\n'), ids};
}
const geminiNote = 'Soubory obrázků učebnice v této verzi přibalené nejsou: obrázek dohledej v [rejstříku obrázků](references/obrazky.md), vycházej z jeho textového popisu a studentovi nabídni odkaz na obrázek ve webové učebnici.';
const geminiAnchor = 'Stručná odpověď může zůstat slovní, případně využít obrázek učebnice.';
// Gemini accepts only CSV, PY, TXT and MD files in a skill, so its variant
// ships the registry and the code licence under a .txt name.
const geminiRenames = {'KAPITOLY.json': 'KAPITOLY.txt', LICENSE: 'LICENSE.txt'};
const geminiAllowed = /\.(csv|py|txt|md)$/i;
const geminiNames = s => s.split('KAPITOLY.json').join('KAPITOLY.txt').split('](LICENSE)').join('](LICENSE.txt)');
function geminiSkill(claudeText) {
  if (claudeText.split(geminiAnchor).length !== 2) throw new Error('Gemini note anchor not found exactly once in SKILL.md');
  return geminiNames(claudeText.replace(geminiAnchor, `${geminiAnchor} ${geminiNote}`));
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
// One register of all textbook figures; the Gemini variant has no image files.
function figureRegister(chapters, figures, withFiles) {
  const out = ['# Rejstřík obrázků učebnice', '',
    withFiles
      ? 'U každého obrázku je číslo, popisek, textový popis, místo v kapitole, přibalený soubor a odkaz na obrázek ve webové učebnici.'
      : 'Soubory obrázků nejsou v této verzi přibalené. U každého obrázku je číslo, popisek, textový popis, místo v kapitole a odkaz na obrázek ve webové učebnici.', ''];
  for (const d of chapters) {
    out.push(`## ${d.number}. ${d.title} {#obrazky-${d.id}}`, '');
    for (const f of figures.filter(f => f.chapter === d.id)) {
      out.push(`### Obrázek ${f.number} {#${f.anchor}}`, '',
        `Popisek: ${f.caption}`, '',
        `Textový popis: ${mdEscape(f.alt)}`, '',
        `[V kapitole](${d.output}#${f.id})${withFiles ? ` · [Soubor obrázku](${f.file})` : ''} · [Ve webové učebnici](${f.web})`, '');
    }
  }
  return out.join('\n');
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
  ? '[Rejstřík obrázků](obrazky.md) — číslo, popisek, textový popis, přibalený soubor a webový odkaz ke každému obrázku.'
  : '[Rejstřík obrázků](obrazky.md) — číslo, popisek, textový popis a webový odkaz ke každému obrázku; soubory obrázků nejsou přibalené.';

module.exports = {root, name, source, web, posix, read, hash, files, run, quarto, pandoc, parseSource, nodes, attr, text, str, para, link, documents,
  skillName, splitSkill, claudeSkill, imageLine, withoutImages, geminiSkill, geminiNote,
  geminiRenames, geminiAllowed, geminiNames, headingLines, divEnd, solutionOpen, figureRegister, figuresLine, inlineMd};
