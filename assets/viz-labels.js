/* Statistical symbols in the charts of interactive visualizations and applications (R89).
   Symbols in SVG labels are set in the browser's math font, i.e. the font of the book's
   MathML equations on the same device; the rest of a label keeps the chart font.
   - Latin symbols are marked in OJS code with window.vizSym("n") (math italic); a subscript
     of letters or digits with window.vizSub("s"), e.g. `${sym("r")}${sub(sym("s"))}`.
   - Greek letters, √ and sub/superscript digits (₀, ², …) right after a symbol are set
     upright in the math font automatically, without any marking.
   The marks are private-use characters a reader cannot type, so labels taken from inputs
   are never formatted. In HTML (outside SVG) only marked symbols change: they become math
   italic letters in the math font, matching the MathML equations. A MutationObserver
   processes every chart of every .viz block, also after each redraw; marks are removed
   from <title> and aria attributes, which stay plain text. */
(() => {
  'use strict';
  const OPEN = '\uE000', CLOSE = '\uE001', SUB_OPEN = '\uE002', SUB_CLOSE = '\uE003';
  window.vizSym = s => OPEN + s + CLOSE;
  window.vizSub = s => SUB_OPEN + s + SUB_CLOSE;
  const MARKS = /[\uE000-\uE003]/g, HAS_MARK = /[\uE000-\uE003]/;
  const SVG_NS = 'http://www.w3.org/2000/svg';
  const FONT = 'math, "Cambria Math", "STIX Two Math", "Latin Modern Math", serif';
  const GREEK = 'Α-Ωα-ω√';
  const SCRIPT = '₀-₉²³';
  // Marked symbol | subscript | Greek letter or √ with directly following sub/superscript digits.
  const TOKEN = new RegExp(`\uE000([^\uE001]*)\uE001|\uE002([^\uE003]*)\uE003|[${GREEK}][${SCRIPT}]*`, 'g');
  const TRAILING = new RegExp(`^[${SCRIPT}]+`);

  const italic = s => Array.from(s, ch => {
    const c = ch.codePointAt(0);
    if (c === 0x68) return '\u210E';
    if (c >= 0x61 && c <= 0x7A) return String.fromCodePoint(0x1D44E + c - 0x61);
    if (c >= 0x41 && c <= 0x5A) return String.fromCodePoint(0x1D434 + c - 0x41);
    return ch;
  }).join('');
  // Content of a subscript: marked letters italic, the rest (digits, upright letters) as is.
  const inner = s => s.replace(new RegExp(`\uE000([^\uE001]*)\uE001`, 'g'), (m, x) => italic(x));

  // Splits a string into runs {text, math, sub}; inSvg also recognises Greek letters.
  function runs(text, inSvg) {
    const out = []; let last = 0;
    const push = (t, math = false, sub = false) => { if (t) out.push({t, math, sub}); };
    for (const m of text.matchAll(TOKEN)) {
      if (m[1] === undefined && m[2] === undefined && !inSvg) continue;
      push(text.slice(last, m.index));
      last = m.index + m[0].length;
      if (m[1] !== undefined) {
        push(italic(m[1]), true);
        const tail = text.slice(last).match(TRAILING);   // e.g. a marked symbol followed by ₀ or ²
        if (tail) { push(tail[0], true); last += tail[0].length; }
      } else if (m[2] !== undefined) push(inner(m[2]), true, true);
      else push(m[0], true);
    }
    push(text.slice(last));
    return out;
  }

  function processText(node) {
    const parent = node.parentElement;
    if (!parent || parent.closest('.viz-math') || parent.closest('title, style, script')) return;
    const text = node.data, inSvg = !!parent.closest('svg');
    const marked = HAS_MARK.test(text);
    if (!marked && !(inSvg && new RegExp(`[${GREEK}]`).test(text))) return;
    if (inSvg && !parent.closest('text')) { node.data = text.replace(MARKS, ''); return; }
    const parts = runs(text, inSvg);
    if (!parts.some(p => p.math)) { node.data = text.replace(MARKS, ''); return; }
    const frag = document.createDocumentFragment();
    for (const p of parts) {
      if (!p.math) { frag.appendChild(document.createTextNode(p.t)); continue; }
      const el = inSvg ? document.createElementNS(SVG_NS, 'tspan') : document.createElement(p.sub ? 'sub' : 'span');
      el.setAttribute('class', 'viz-math');
      el.style.fontFamily = FONT;
      el.style.fontStyle = 'normal';   // the letters are already math italic; no synthetic slant on top
      if (inSvg && p.sub) { el.setAttribute('baseline-shift', 'sub'); el.style.fontSize = '75%'; }
      el.textContent = p.t;
      frag.appendChild(el);
    }
    node.replaceWith(frag);
  }

  function clean(el) {
    for (const name of ['aria-label', 'aria-description']) {
      const v = el.getAttribute && el.getAttribute(name);
      if (v && HAS_MARK.test(v)) el.setAttribute(name, v.replace(MARKS, ''));
    }
  }

  function process(root) {
    if (root.nodeType === Node.TEXT_NODE) {
      if (root.parentElement && root.parentElement.closest('title')) root.data = root.data.replace(MARKS, '');
      else processText(root);
      return;
    }
    if (root.nodeType !== Node.ELEMENT_NODE) return;
    clean(root);
    root.querySelectorAll('[aria-label], [aria-description]').forEach(clean);
    root.querySelectorAll('title').forEach(t => { if (HAS_MARK.test(t.textContent)) t.textContent = t.textContent.replace(MARKS, ''); });
    const walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT);
    const nodes = []; while (walker.nextNode()) nodes.push(walker.currentNode);
    nodes.forEach(processText);
  }

  const inViz = node => { const el = node.nodeType === Node.ELEMENT_NODE ? node : node.parentElement; return el && el.closest('.viz'); };
  const observer = new MutationObserver(records => {
    for (const r of records) {
      if (r.type === 'childList') r.addedNodes.forEach(n => { if (inViz(n)) process(n); });
      else if (r.type === 'characterData' && inViz(r.target)) process(r.target);
      else if (r.type === 'attributes' && inViz(r.target)) clean(r.target);
    }
  });
  const start = () => {
    document.querySelectorAll('.viz').forEach(process);
    observer.observe(document.body, {childList: true, subtree: true, characterData: true, attributes: true, attributeFilter: ['aria-label', 'aria-description']});
  };
  if (document.body) start(); else document.addEventListener('DOMContentLoaded', start);
})();
