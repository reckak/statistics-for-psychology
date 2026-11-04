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
const str = s => ({t: 'Str', c: s});
const para = s => ({t: 'Para', c: [str(s)]});
const link = (label, target) => ({t: 'Link', c: [['', [], []], [str(label)], [target, '']]});
const documents = [
  {id: 'index', source: 'index.qmd', output: 'uvod.md', kind: 'introduction'},
  ...Array.from({length: 6}, (_, i) => {
    const nn = String(i + 1).padStart(2, '0');
    return {id: `kapitola_${nn}`, source: `quarto/kapitola_${nn}.qmd`, output: `kapitoly/kapitola_${nn}.md`, kind: 'chapter', number: i + 1};
  }),
  ...['slovnicek', 'znaceni', 'excel'].map(id => ({id, source: `quarto/${id}.qmd`, output: `prehledy/${id}.md`, kind: 'overview'}))
];

module.exports = {root, name, source, web, posix, read, hash, files, run, quarto, pandoc, parseSource, nodes, attr, text, str, para, link, documents,
  skillName, splitSkill, claudeSkill};
