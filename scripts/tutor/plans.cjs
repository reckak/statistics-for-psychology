// Derived tutor plans: chapter cards own depth/boundaries; chapters and overviews
// own learning goals, exact headings, optional blocks, terms and notation.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const c = require('./common.cjs');

function bookChapters(q) {
  const meta = JSON.parse(c.pandoc(q, ['--from=markdown', '--to=json', '--metadata-file=_quarto.yml'], '')).meta;
  const paths = [];
  function visit(value) {
    if (value.t === 'MetaList') value.c.forEach(visit);
    else if (value.t === 'MetaMap' && value.c.chapters) visit(value.c.chapters);
    else if (value.t === 'MetaInlines') paths.push(c.text(value.c));
    else if (value.t === 'MetaString') paths.push(value.c);
  }
  visit(meta.book.c.chapters);
  return paths.filter(p => /^quarto\/kapitola_\d+\.qmd$/.test(p)).map((source, i) => ({
    id: path.basename(source, '.qmd'), source, number: i + 1
  }));
}

function cardFor(number) {
  const matches = fs.readdirSync(path.join(c.root, 'docs/kapitoly')).filter(f => f.startsWith(String(number).padStart(2, '0') + '-'));
  assert.equal(matches.length, 1, `One chapter card required: ${number}`);
  return `docs/kapitoly/${matches[0]}`;
}

// Preserve inherited optional scope even when a nested heading has an ordinary
// title. Keep a solution/optional exercise from leaking into the next section.
function scopes(ast) {
  const ids = new Map();
  const headings = [], optionalBlocks = [];
  function visit(value, inherited = {optional: false, exercise: false}, levels = []) {
    if (Array.isArray(value)) {
      const local = [...levels];
      for (const item of value) visit(item, inherited, local);
      return;
    }
    if (!value || typeof value !== 'object') return;
    let state = {...inherited};
    const title = value.t === 'Header' ? c.text(value.c[2]) : '';
    if (value.t === 'Header') {
      const level = value.c[0];
      levels.length = level;
      state = {...(levels[level - 1] || inherited)};
      state.optional ||= /Nepovinn[ěé]/i.test(title);
      state.exercise ||= /^Cvičení$/.test(title);
      levels[level] = state;
    } else state = {...(levels.at(-1) || inherited)};
    const a = c.attr(value);
    if (value.t === 'Div') {
      const label = c.text(value.c[1][0]);
      if (/^Nepovinné rozšíření/.test(label)) {
        state.optional = true;
        assert(a[0], 'Optional block needs a stable identifier');
        optionalBlocks.push({id: a[0], title: label});
      }
    }
    if (a?.[0]) ids.set(a[0], {...state});
    if (value.t === 'Header') headings.push({id: a[0], title, level: value.c[0], ...state});
    if (value.t === 'Div') visit(value.c[1], state, []);
    else if (value.t !== 'Header') Object.values(value).forEach(x => visit(x, state, [...levels]));
  }
  visit(ast.blocks);
  return {ids, headings, optionalBlocks};
}

function cardSection(raw, prefix) {
  const parts = raw.split(/^### /m).slice(1);
  const section = parts.find(s => s.startsWith(prefix));
  assert(section, `Missing chapter-card section: ${prefix}`);
  return section.slice(section.indexOf('\n') + 1).split(/^## /m)[0].replace(/<a id="[^"]+"><\/a>/g, '').trim();
}

function createPlan({d, exported, pages, q, writer, version, stamp, sourceRevision}) {
  const card = cardFor(d.number);
  const raw = c.read(path.join(c.root, card));
  const chapterScope = scopes(d.out);
  const chapterUrl = `${c.web}quarto/${d.id}.html`;
  const local = id => `../${d.output}${id ? '#' + id : ''}`;
  const s = [
    `# ${d.number}. ${d.title}`, '',
    `Výukový plán · balíček ${version} · sestaveno ${stamp} · zdrojová revize ${sourceRevision}.`, '',
    `[Výklad](${local()}) · [Index](../INDEX.md) · [Zdrojová karta](https://github.com/reckak/statistics-for-psychology/blob/${sourceRevision}/${card})`, '',
    'Plán je odvozená navigace pro tutora. Rozsah a hloubku určuje kapitolová karta, cíle a přesné lokátory text kapitoly. U každé úlohy načti zadání i řešení. Označení „povinné“ se týká učiva, nikoli zvládnutí studentem; zmínky a alternativní názvy nejsou samostatné požadované znalosti.', '',
    '## Vstupní znalosti', ''
  ];
  let prereq = raw.match(/\*\*Vstup:\*\*\s*([\s\S]*?)(?=\n\s*\n)/)?.[1];
  assert(prereq, `${card}: missing prerequisites`);
  prereq = prereq.split(/\*\*Cíle:\*\*|Konvence (?:určují|upravují)/)[0].trim();
  prereq = prereq[0].toLocaleUpperCase('cs') + prereq.slice(1);

  // Convert only known textbook links to package links. Author evidence stays
  // online; the private sources directory never enters a plan or the package.
  function rewrite(value) {
    if (Array.isArray(value)) return value.map(rewrite);
    if (!value || typeof value !== 'object') return value;
    const copy = Object.fromEntries(Object.entries(value).map(([k, v]) => [k, rewrite(v)]));
    if (copy.t === 'Link') {
      const target = copy.c[2][0];
      if (!/^[a-z]+:/i.test(target)) {
        const [part, fragment = ''] = target.split('#');
        const absolute = path.resolve(c.root, path.dirname(card), part);
        const source = c.posix(path.relative(c.root, absolute));
        assert(!source.startsWith('sources/'), 'Private source link in plan');
        const page = [...pages.values()].find(p => p.source === source);
        if (page) {
          assert(!fragment || page.ids.has(fragment), `Missing plan target: ${target}`);
          copy.c[2][0] = page.external ? `${c.web}quarto/${page.id}.html${fragment ? '#' + fragment : ''}` :
            `../${page.output}${fragment ? '#' + fragment : ''}`;
        } else if (source.startsWith('data/')) copy.c[2][0] = c.web + source;
        else copy.c[2][0] = `https://github.com/reckak/statistics-for-psychology/blob/${sourceRevision}/${source}${fragment ? '#' + fragment : ''}`;
      }
    }
    return copy;
  }
  function renderCard(markdown) {
    const ast = JSON.parse(c.pandoc(q, ['--from=markdown-smart', '--to=json'], markdown));
    ast.blocks = rewrite(ast.blocks);
    return c.pandoc(q, writer, JSON.stringify(ast)).trim();
  }
  const render = blocks => c.pandoc(q, writer, JSON.stringify({...d.out, blocks})).trim();
  const inline = value => {
    if (Array.isArray(value)) return value.map(inline).join('');
    if (value.t === 'Math') return `$${value.c[1]}$`;
    if (value.t === 'Code') return '`' + value.c[1] + '`';
    if (value.t === 'Strong') return `**${inline(value.c)}**`;
    if (value.t === 'Emph') return `*${inline(value.c)}*`;
    return c.text(value).replace(/[\[\]]/g, '\\$&');
  };
  s.push(renderCard(prereq), '', '## Povinné cíle', '');
  const goal = c.nodes(d.out.blocks, 'Div').find(x => c.text(x.c[1][0]) === 'Co budete po prostudování umět');
  const bullets = goal && c.nodes(goal.c[1], 'BulletList')[0];
  assert(bullets, `${d.id}: missing learning goals`);
  s.push(render([bullets]), '', '## Doporučená posloupnost a lokátory', '',
    'Postupuj po níže uvedených úsecích. Před další otázkou ověř pojmy a předpoklady proti jejich hloubce v následující tabulce. Při volbě bez rozšíření používej povinné části; rozšíření připojuj k souvisejícímu úseku po jejich zvolení.', '');
  for (const h of chapterScope.headings.filter(h => h.level > 1 && !h.exercise && !/^sec-shrnuti/.test(h.id))) {
    s.push(`${'  '.repeat(Math.max(0, h.level - 2))}- [${h.title}](${local(h.id)})${h.optional ? ' — nepovinné' : ''}`);
  }
  s.push('', '## Hloubka výkladu, příklady a procvičení', '',
    renderCard(cardSection(raw, 'Skutečný obsah')), '', '## Pojmy, značení a funkce', '',
    'Následují odkazy na všechna hesla přehledů, která odkazují na tuto kapitolu. Jde o rejstřík k ověření názvů a symbolů, nikoli automaticky seznam nových povinných pojmů. Požadovanou hloubku určuje výklad a tabulka výše; alternativy vysvětluj jen podle potřeby.', '');
  const concepts = [];
  for (const overview of exported.filter(x => x.kind === 'overview')) {
    s.push(`### ${overview.title}`, '');
    const div = c.nodes(overview.out.blocks, 'Div').find(x => /^(glossary|notation|excel)-table$/.test(x.c[0][0]));
    const blocks = div.c[1];
    for (let i = 0; i < blocks.length; i++) {
      const h = blocks[i];
      if (h.t !== 'Header') continue;
      let end = blocks.findIndex((b, j) => j > i && b.t === 'Header');
      if (end < 0) end = blocks.length;
      const refs = c.nodes(blocks.slice(i + 1, end), 'Link').map(n => n.c[2][0])
        .filter(t => t.split('#')[0] === `../${d.output}` || t.split('#')[0] === chapterUrl);
      if (!refs.length) continue;
      const states = refs.map(t => chapterScope.ids.get(t.split('#')[1]));
      assert(states.every(Boolean), `Unknown concept target in ${d.id}`);
      const optional = states.every(x => x.optional);
      const title = inline(h.c[2]);
      s.push(`- [${title}](../${overview.output}#${h.c[1][0]})${optional ? ' — odkazuje do nepovinné části' : ''}`);
      concepts.push({overview: overview.id, id: h.c[1][0], optional});
    }
    s.push('');
  }
  s.push('## Nepovinné části', '');
  for (const o of chapterScope.optionalBlocks) s.push(`- [${o.title}](${local(o.id)})`);
  s.push('', '## Cvičení a cílové dovednosti', '', renderCard(cardSection(raw, 'Cvičení a očekávané')), '',
    '### Přesné lokátory zadání a řešení', '');
  for (const h of chapterScope.headings.filter(h => h.exercise && h.level === 3)) {
    s.push(`- [${h.title}](${local(h.id)}) — ${h.optional ? 'nepovinné' : 'základní'}`);
  }
  const boundary = cardSection(raw, 'Pojmy').split(/\n\s*\n/).filter(p =>
    !/^(?:Hlavní|\*\*Odchylky)/.test(p));
  s.push('', '## Hranice a návaznosti', '', renderCard(boundary.join('\n\n')), '',
    '## Použití vizualizací', '',
    'Vycházej z příkladů a grafů u odkazovaných oddílů a z aktuální úlohy. Zvolené zobrazení využij opakovaně u stejného principu. Rozsah plánu platí i pro grafy a ovladače; další modely přidávej podle [metodiky](../VIZUALIZACE.md) na výslovný dotaz jako označený doplněk.', '',
    '## Kontrola dalšího kroku', '',
    'Při pokračování drž stav: zvolený úsek a rozšíření, vysvětlené pojmy, vyřešené úlohy, obtíže a využité vizualizace. Další otázku spoj s konkrétní dovedností výše. Potřebný předpoklad připomeň z dřívější kapitoly nebo nejprve vysvětli. Na konci ověř dovednosti pomocí [shrnutí](' + local(`sec-shrnuti-${String(d.number).padStart(2, '0')}`) + ').', '');
  return {markdown: s.join('\n'), card, concepts, scope: chapterScope};
}

module.exports = {bookChapters, cardFor, scopes, createPlan};
