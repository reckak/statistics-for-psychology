// Independent conversion cases: decimal commas, separators and inline boundaries.
const assert = require('node:assert/strict');
const {spawnSync} = require('node:child_process');
const quarto = process.argv[2] || 'C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe';
const source = String.raw`::: {.table-note}
*Poznámka.* Text pod tabulkou.
:::

$p=0{,}025; N(50,10); z_{0{,}975}; \frac{-1{,}25}{2{,}5}$

$z=-1{,}5; t\approx -2{,}064; 46-3{,}92$

$$x=49{,}92.$$

A **v** textu a *i jinak*; k [odkazu](https://example.org). $a$ je proměnná. ` + '`a v kodu`' + '\n';
const result = spawnSync(quarto, ['pandoc','--from=markdown','--to=typst','--lua-filter=scripts/pdf/typography.lua'], {input:source,encoding:'utf8'});
assert.equal(result.status,0,result.stderr);
assert(result.stdout.includes('#set text(size: 1em - 1pt)'), 'table notes are 1pt smaller');
for (const value of ['0,025','0,975','−1,25','2,5','−1,5','−2,064','49,92.']) assert(result.stdout.includes(`upright("${value}")`),value);
assert(result.stdout.includes('46 - upright("3,92")'),'binary minus stays an operator');
assert(result.stdout.includes(String.raw`N \( 50 \, 10 \)`),'distribution separator');
assert(result.stdout.includes('A~#strong[v]~textu a~#emph[i~jinak]'),'inline boundaries');
assert(result.stdout.includes('k~#link'),'link boundary');
assert(result.stdout.includes('$a$ je'),'math variable is not a conjunction');
assert(result.stdout.includes('a v kodu'),'code unchanged');
console.log('PDF typography conversion: decimal literals, separator commas, emphasis, links, math and code passed.');
