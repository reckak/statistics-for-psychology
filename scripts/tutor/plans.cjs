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

// Line ranges in the exported chapter: navigation for reading one step at a time.
// Sections run to the line before the next heading of the same or a higher level;
// exercise statements and solutions, and optional blocks, get ranges of their own.
function locate(d, chapterScope, figures) {
  // Pandoc on Windows writes CRLF; line numbers are the same either way.
  const markdown = d.markdown.replace(/\r\n/g, '\n');
  const lines = markdown.split('\n');
  const marks = c.headingLines(markdown);
  assert.equal(marks.length, chapterScope.headings.length, `${d.id}: heading lines in the exported chapter`);
  const lastContent = n => { while (n > 1 && lines[n - 1].trim() === '') n--; return n; };
  const trimmed = (a, b) => {
    while (a <= b && lines[a - 1].trim() === '') a++;
    while (b >= a && lines[b - 1].trim() === '') b--;
    return a <= b ? [a, b] : null;
  };
  const sections = chapterScope.headings.map((h, i) => {
    assert.equal(marks[i].level, h.level, `${d.id}: heading level at line ${marks[i].line}`);
    return {...h, start: marks[i].line, figures: [], viz: []};
  });
  sections.forEach((h, i) => {
    const next = sections.slice(i + 1).find(x => x.level <= h.level);
    h.end = lastContent((next ? next.start : lines.length + 1) - 1);
  });
  const innermost = line => sections.filter(h => h.start <= line).at(-1);
  const opener = id => {
    const pattern = new RegExp(`^:{3,} \\{#${id.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}[ }]`);
    const hits = lines.flatMap((l, i) => pattern.test(l) ? [i + 1] : []);
    assert.equal(hits.length, 1, `${d.id}: one block opener for ${id}`);
    return hits[0];
  };
  const optional = chapterScope.optionalBlocks.map(o => {
    const start = opener(o.id);
    return {...o, start, end: c.divEnd(lines, start)};
  });
  const inOptional = line => optional.some(o => line >= o.start && line <= o.end);
  for (const f of figures) {
    const line = opener(f.id);
    // A figure inside an optional block is shown only when the student chose the optional parts.
    innermost(line).figures.push({...f, optional: inOptional(line) || innermost(line).optional});
  }
  // Text between a section heading and its first subsection has no plan item of its own.
  sections.forEach((h, i) => {
    const child = sections[i + 1];
    if (!child || child.level <= h.level) return;
    const intro = trimmed(h.start + 1, child.start - 1);
    if (intro) h.intro = [h.start, intro[1]];
  });
  for (const o of optional) { const h = innermost(o.start); if (!h.optional) (h.optionalBlocks ||= []).push([o.start, o.end]); }
  const vizLink = new RegExp(`${c.web.replace(/[.]/g, '\\.')}quarto/(viz_[a-z0-9_]+)\\.html`, 'g');
  lines.forEach((l, i) => {
    for (const m of l.matchAll(vizLink)) {
      const h = innermost(i + 1);
      if (!h.viz.includes(m[1])) h.viz.push(m[1]);
    }
  });
  const exercises = sections.filter(h => h.exercise && h.level === 3).map(h => {
    const solutions = [];
    for (let n = h.start; n <= h.end; n++) {
      if (c.solutionOpen(lines, n - 1)) { solutions.push([n, c.divEnd(lines, n)]); n = solutions.at(-1)[1]; }
    }
    assert(solutions.length, `${d.id}: exercise without a solution block: ${h.title}`);
    const statement = [];
    let from = h.start;
    for (const [a, b] of [...solutions, [h.end + 1, h.end + 1]]) {
      const part = trimmed(from, a - 1);
      if (part) statement.push(part);
      from = b + 1;
    }
    return {id: h.id, title: h.title, optional: h.optional, statement, solutions, figures: h.figures};
  });
  return {sections, exercises, optional};
}
const {registerPath} = c;
const span = ([a, b]) => a === b ? `${a}` : `${a}–${b}`;
const spans = list => list.map(span).join(' a ');
// Line range of every entry of an overview (level-2 headings with explicit identifiers).
const entryCache = new Map();
function entryLines(overview) {
  if (!entryCache.has(overview.id)) {
    const markdown = overview.markdown.replace(/\r\n/g, '\n');
    const lines = markdown.split('\n');
    const marks = c.headingLines(markdown).filter(h => h.level === 2);
    entryCache.set(overview.id, new Map(marks.map((h, i) => {
      let end = (marks[i + 1] ? marks[i + 1].line : lines.length + 1) - 1;
      while (end > h.line && !/\S/.test(lines[end - 1].replace(/^:+$/, ''))) end--;
      return [h.text.match(/\{#([^ }]+)/)?.[1], [h.line, end]];
    })));
  }
  return entryCache.get(overview.id);
}
const vizTitles = new Map();
function vizTitle(page) {
  if (!vizTitles.has(page)) {
    const title = c.read(path.join(c.root, 'quarto', `${page}.qmd`)).match(/^# (.+?)\s*\{#/m)?.[1];
    assert(title, `Missing title of ${page}`);
    vizTitles.set(page, title);
  }
  return vizTitles.get(page);
}

function createPlan({d, exported, pages, q, writer, version, stamp, sourceRevision, figures = []}) {
  const card = cardFor(d.number);
  const raw = c.read(path.join(c.root, card));
  const chapterScope = scopes(d.out);
  const located = locate(d, chapterScope, figures);
  const chapterUrl = `${c.web}quarto/${d.id}.html`;
  const local = id => `../${d.output}${id ? '#' + id : ''}`;
  const s = [
    `# ${d.number}. ${d.title}`, '',
    `Výukový plán · balíček ${version} · sestaveno ${stamp} · zdrojová revize ${sourceRevision}.`, '',
    `[Výklad](${local()}) · [Index](../INDEX.md) · [Zdrojová karta](https://github.com/reckak/statistics-for-psychology/blob/${sourceRevision}/${card})`, '',
    'Plán je odvozená navigace pro tutora. Rozsah a hloubku určuje kapitolová karta, cíle a přesné lokátory text kapitoly. U každé úlohy načti zadání i řešení. Označení „povinné“ se týká učiva, nikoli zvládnutí studentem; zmínky a alternativní názvy nejsou samostatné požadované znalosti.', '',
    `Rozsahy řádků se vztahují k souboru [výkladu](${local()}) v tomto balíčku. Pro aktuální krok načti jen uvedený rozsah, nikoli celou kapitolu; zadání a řešení cvičení i nepovinné bloky mají vlastní rozsahy.`, '',
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
  s.push('U oddílu s pododdíly platí rozsah pro celý oddíl včetně pododdílů. U oddílů s uvedenými obrázky je při výkladu ukaž: odkaz vede do rejstříku obrázků kapitoly, rozsah řádků vymezuje záznam obrázku; „s daty od řádku N“ znamená, že od řádku N do konce záznamu je blok dat pro překreslení (popisek a textový popis jsou před ním; data čti, až když kreslíš), a „schéma bez dat“ označuje diagram, který se z hodnot nepřekresluje: ukaž jeho soubor, nebo jej popiš. Interaktivní stránku učebnice nabídni při výkladu oddílu, u něhož je uvedena: jednou větou s jejím názvem a úplnou adresou opsanou odtud.', '');
  const figureLinks = list => `obrázky: ${list.map(f => { listedFigures.add(f.id); return `[${f.number}](../${f.register}#${f.id}) (řádky ${span(f.range)}${c.dataLabel(f)}${f.optional ? ', v nepovinné části' : ''})`; }).join(', ')}`;
  const vizOffer = p => `${vizTitle(p)} — <${c.web}quarto/${p}.html>`;
  const listedFigures = new Set();
  for (const h of located.sections.filter(h => h.level > 1 && !h.exercise && !/^sec-shrnuti/.test(h.id))) {
    const extras = [];
    if (h.intro) extras.push(`úvod oddílu řádky ${span(h.intro)}`);
    if (h.optionalBlocks) extras.push(`uvnitř nepovinný blok na řádcích ${spans(h.optionalBlocks)}`);
    if (h.figures.length) extras.push(figureLinks(h.figures));
    if (h.viz.length) extras.push(`interaktivní stránka k nabídnutí: ${h.viz.map(vizOffer).join('; ')}`);
    s.push(`${'  '.repeat(Math.max(0, h.level - 2))}- [${h.title}](${local(h.id)}) — řádky ${span([h.start, h.end])}${h.optional ? ' — nepovinné' : ''}${extras.map(x => ' · ' + x).join('')}`);
  }
  s.push('', '## Hloubka výkladu, příklady a procvičení', '',
    renderCard(cardSection(raw, 'Skutečný obsah')), '', '## Pojmy, značení a funkce', '',
    'Následují odkazy na všechna hesla přehledů, která odkazují na tuto kapitolu, s rozsahem řádků hesla v přehledu. Jde o rejstřík k ověření názvů a symbolů, nikoli automaticky seznam nových povinných pojmů. Požadovanou hloubku určuje výklad a tabulka výše; alternativy vysvětluj jen podle potřeby.', '');
  const concepts = [];
  for (const overview of exported.filter(x => x.kind === 'overview')) {
    s.push(`### ${overview.title}`, '');
    const entryRanges = entryLines(overview);
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
      const lines = entryRanges.get(h.c[1][0]);
      assert(lines, `Overview entry lines: ${overview.id}/${h.c[1][0]}`);
      s.push(`- [${title}](../${overview.output}#${h.c[1][0]}) — řádky ${span(lines)}${optional ? ' — odkazuje do nepovinné části' : ''}`);
      concepts.push({overview: overview.id, id: h.c[1][0], optional, lines});
    }
    s.push('');
  }
  s.push('## Nepovinné části', '');
  for (const o of located.optional) s.push(`- [${o.title}](${local(o.id)}) — řádky ${span([o.start, o.end])}`);
  s.push('', '## Cvičení a cílové dovednosti', '', renderCard(cardSection(raw, 'Cvičení a očekávané')), '',
    '### Přesné lokátory zadání a řešení', '',
    'Při pomoci bez prozrazení výsledku načti zadání; řešení načti jako kontrolní klíč.', '');
  for (const h of located.exercises) {
    s.push(`- [${h.title}](${local(h.id)}) — ${h.optional ? 'nepovinné' : 'základní'} — zadání řádky ${spans(h.statement)}; řešení řádky ${spans(h.solutions)}${h.figures.length ? ' · ' + figureLinks(h.figures) : ''}`);
  }
  const boundary = cardSection(raw, 'Pojmy').split(/\n\s*\n/).filter(p =>
    !/^(?:Hlavní|\*\*Odchylky)/.test(p));
  s.push('', '## Hranice a návaznosti', '', renderCard(boundary.join('\n\n')), '',
    '## Použití vizualizací', '',
    `U oddílů s uvedenými obrázky je při výkladu ukaž. Obrázky kapitoly (${figures.length}) jsou v [rejstříku obrázků kapitoly](../${registerPath(d.id)})${figures.some(c.hasData) ? `; ${figures.filter(c.hasData).length} z nich má data pro překreslení` : '; data pro překreslení zatím nemají'}. U oddílů a cvičení výše je uvedeno, které k nim patří. Nový graf nad rámec obrázků učebnice se řídí [metodikou](../VIZUALIZACE.md); rozsah plánu platí i pro něj.`, '');
  const otherFigures = figures.filter(f => !listedFigures.has(f.id));
  if (otherFigures.length) s.push(`Mimo uvedené oddíly a cvičení: ${figureLinks(otherFigures)}.`, '');
  const vizPages = [...new Set(located.sections.flatMap(h => h.viz))];
  if (vizPages.length) {
    s.push('Interaktivní stránky učebnice navazující na tuto kapitolu. Každou nabídni jednou, při výkladu uvedeného oddílu; adresu opiš doslova:', '');
    for (const p of vizPages) {
      const at = located.sections.filter(h => h.viz.includes(p)).map(h => `[${h.title}](${local(h.id)})`).join(', ');
      s.push(`- ${vizOffer(p)} — při oddílu ${at}`);
    }
    s.push('');
  } else s.push('Na tuto kapitolu nenavazuje žádná interaktivní stránka učebnice.', '');
  const summary = located.sections.find(h => h.id === `sec-shrnuti-${String(d.number).padStart(2, '0')}`);
  assert(summary, `${d.id}: missing summary section`);
  s.push('## Kontrola dalšího kroku', '',
    'Při pokračování drž stav: zvolený úsek a rozšíření, vysvětlené pojmy, vyřešené úlohy, obtíže a využité vizualizace. Další otázku spoj s konkrétní dovedností výše. Potřebný předpoklad připomeň z dřívější kapitoly nebo nejprve vysvětli. Na konci ověř dovednosti pomocí [shrnutí](' + local(summary.id) + `) (řádky ${span([summary.start, summary.end])}).`, '');
  const ranges = {
    sections: located.sections.map(h => ({id: h.id, level: h.level, start: h.start, end: h.end, intro: h.intro || null,
      figures: h.figures.map(f => f.id), optionalFigures: h.figures.filter(f => f.optional).map(f => f.id), viz: h.viz})),
    exercises: located.exercises.map(({id, statement, solutions}) => ({id, statement, solutions})),
    optional: located.optional.map(({id, start, end}) => ({id, start, end}))
  };
  return {markdown: s.join('\n'), card, concepts, scope: chapterScope, ranges};
}

module.exports = {bookChapters, cardFor, scopes, createPlan};
