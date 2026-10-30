// Build step: format Quarto's generated labels while preserving inline caption markup.
// Unlike a DOM script, this also works with JavaScript disabled.
const fs = require('node:fs');
const path = require('node:path');
function visit(dir) {
  for (const entry of fs.readdirSync(dir, {withFileTypes: true})) {
    const file = path.join(dir, entry.name);
    if (entry.isDirectory()) visit(file);
    else if (file.endsWith('.html')) {
      const before = fs.readFileSync(file, 'utf8');
      const after = before.replace(/(<figcaption\b[^>]*class="[^"]*quarto-float-tbl[^"]*"[^>]*>\s*)Tabulka(?:&nbsp;|\s|\u00a0)+(\d+(?:\.\d+)*):\s*/g,
        '$1<span class="quarto-float-caption-prefix">Tabulka&nbsp;$2</span>');
      if (after !== before) fs.writeFileSync(file, after);
    }
  }
}
visit('_book');
