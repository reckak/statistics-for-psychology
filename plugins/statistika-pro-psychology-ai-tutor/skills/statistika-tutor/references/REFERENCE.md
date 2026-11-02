# Stručný referenční balíček

Připraveno 2. 11. 2026. Jde o krátký výběr konvencí a připomenutí,
nikoli o kapitoly nebo úplný slovníček. Přibalené kapitoly 1–6 a celé aktuální přehledy jsou uvedeny v INDEX.md.
Při použití v chatu uváděj tento soubor jako zdroj; necituj nepřiložené kapitoly
jako přečtené. Konkrétní výklad a potřebné předpoklady doplňuje dostupná kapitola.

## Terminologie

| Český termín | Anglický ekvivalent | Rozlišení |
|---|---|---|
| Populace | population | Vymezený celek, o němž klademe otázku. |
| Výběr | sample | Zahrnutá část populace; vybírání případů (sampling) je proces. Pro tutora používej přednostně „výběr“. |
| Popisná statistika | descriptive statistics | Shrnuje pozorovaná data. |
| Inferenční statistika | inferential statistics | Poskytuje postupy usuzování z výběru s nejistotou a za předpokladů. |
| Statistika (číselný ukazatel) | statistic | Číslo vypočtené z dat; odlišuj je od oboru statistika a od populačního parametru. |
| Aritmetický průměr | arithmetic mean | Součet zahrnutých číselných hodnot dělený jejich počtem. Význam průměru závisí na tom, co čísla představují. |
| Rozptyl | variance | Rozlišuj popis s dělením n a výběrový rozptyl s dělením n − 1. Variabilita je širší pojem. |
| Směrodatná odchylka | standard deviation | Charakterizuje variabilitu jednotlivých hodnot; má původní jednotky. |
| Směrodatná chyba | standard error | Směrodatná odchylka výběrového rozdělení statistiky. V tutorovi preferuj tuto podobu před „standardní chyba“. |
| Výběrová chyba | sampling error | Zde rozdíl jednoho výběrového odhadu od populačního parametru; odliš od směrodatné chyby i zkreslení. |
| *p*-hodnota | p-value | Za nulové hypotézy a ostatních předpokladů modelu pravděpodobnost stejně extrémního nebo extrémnějšího výsledku podle zvoleného testu. |

Nezaměňuj *p*-hodnotu s pravděpodobností pravdivosti nulové hypotézy,
pravděpodobností náhody ani s hladinou významnosti. Nezamítnutí nulové
hypotézy samo nedokládá rovnost ani praktickou ekvivalenci. Statisticky
významný rozdíl může být věcně malý; nevýznamný výsledek může být nepřesný.
Pozorovaná souvislost sama neurčuje kauzální mechanismus.

## Značení

Výpočetní výběrové charakteristiky piš malou kurzivní latinkou; populační
parametry řeckými písmeny ve stojatém řezu, například $\mathrm{μ}$ a $\mathrm{σ}$.
V LaTeXu používej zápis podporovaný hostitelem a zkontroluj jeho čitelnost.

| Symbol | Význam |
|---|---|
| $x_i$ | Hodnota i-tého pozorování. |
| $n$ | Počet platných pozorování zahrnutých v konkrétním výpočtu. |
| $m$ | Výběrový aritmetický průměr, nikoli automaticky M nebo x s pruhem. |
| $s^2$, $s$ | Výběrový rozptyl s dělením n − 1 a jeho odmocnina. |
| $\mathrm{μ}$, $\mathrm{σ}^2$, $\mathrm{σ}$ | Populační průměr, rozptyl a směrodatná odchylka. |
| $\mathrm{σ}_m$ | Směrodatná chyba průměru v modelu. |
| $s_m$ | Odhad směrodatné chyby průměru z dat. |
| $H_0$, $H_1$ | Nulová a alternativní hypotéza. |
| $\mathrm{α}$ | Předem zvolená hladina významnosti. |
| $\approx$ | Přibližná rovnost; přesnou rovnost zapisuj =. |

U aritmetického průměru platí
$$m=\frac{1}{n}\sum_{i=1}^{n}x_i.$$
Znak $\sum$ znamená sečtení uvedených hodnot pro všechna i od 1 do n.
Pro výběrový rozptyl a směrodatnou odchylku při n > 1 používáme
$$s^2=\frac{\sum_{i=1}^{n}(x_i-m)^2}{n-1},\qquad s=\sqrt{s^2}.$$
Dělení n pro popis pozorovaného souboru nezaměňuj s tímto odhadem a automaticky
je nepřejmenovávej na populační rozptyl.

Pro nezávislá stejně rozdělená pozorování s konečným populačním rozptylem je
$$\mathrm{σ}_m=\frac{\mathrm{σ}}{\sqrt n},\qquad s_m=\frac{s}{\sqrt n}.$$
První vztah popisuje modelovou variabilitu průměrů, druhý ji odhaduje z dat.
U závislých dat nebo výběru bez vracení z malé konečné populace je nutné
přihlédnout k uspořádání výběru; neuplatňuj vztah automaticky.
Normální rozdělení jednotlivých hodnot není nutné pro tento vztah rozptylů.

Při označené ukázce reportování podle APA lze použít *M*, *Mdn*, *SD*, *N*
a *n*. Tato výjimka nemění výpočetní značení m a s ve výkladu.
Piš „*p*-hodnota“; samotné *p* použij jen tam, kde nehrozí záměna s podílem.

## Přesnost a interpretace

Mezivýpočty ponechávej v plné dostupné přesnosti. Konečný výsledek
zaokrouhli podle zadání a účelu, připoj jednotku a použij přibližnou rovnost.
Český výklad používá desetinnou čárku. V nové početní úloze sděl přijatelnou
toleranci; počet desetinných míst nestanovuj jako univerzální statistické pravidlo.

U nového vzorce vysvětli všechny symboly a podmínky, ukaž dosazení
a interpretaci v kontextu. Odliš variabilitu osob, nejistotu odhadu,
systematické zkreslení a chybu měření. Větší výběr sám neodstraní zkreslení.

## Původ a rozsah

Zkráceně adaptováno z autorského registru SLOVNIK.md, projektových instrukcí,
studentského přehledu znaceni.qmd a přečtených pasáží kapitol 3 a 6 učebnice
Karla Rečky [Základy statistiky pro psychology](https://reckak.github.io/statistics-for-psychology/).
Zdrojový stav: revize 0fbf5da3e753d39b9c8aa2bd182d30389dc58615,
kontrola vybraných konvencí 2. 11. 2026. Zdrojové lokátory pro autora:
quarto/znaceni.qmd, řádky s ID znak-m, znak-s2, znak-s, znak-p-hodnota;
quarto/kapitola_03.qmd#sec-prumer a #sec-zaokrouhlovani-03;
quarto/kapitola_06.qmd#sec-smerodatna-chyba, #sec-odhad-chyby
a #sec-p-hodnota-vypocet. Rozlišení značení APA: R01; přibližná rovnost: R43;
směrodatná chyba: R30; zápis p-hodnoty: R56.

Text je zkrácený a upravený; nejde o tvrzení, že byl prověřen celý obsah
uvedených kapitol nebo každá jejich analýza. Katalog funkcí Excelu a úplný aktuální přehled značení jsou v přibalených přehledech; načítej potřebné heslo podle INDEX.md.
Licence převzatého a upraveného textu:
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.cs).
