# Interaktivní vizualizace a statistické aplikace

[Zpět na provozní návody](../PROVOZ.md)

Společný technický postup pro stránky `quarto/viz_<tema>.qmd` a `quarto/app_<tema>.qmd`.
Obsah a dohodu stránek určuje [AGENTS.md](../../AGENTS.md#interaktivni-vizualizace).
Co patří do dokladu, historie, tohoto návodu a kontrolních skriptů, stanoví
[pravidlo evidence](../../AGENTS.md#evidence-rozhodnuti) podle
[R88](../rozhodnuti/postupy-a-dokumentace.md#r88-bez-opakovani): scénáře kontrol
jednotlivých stránek se sem nepíší. Jejich výčet ke dni 2026-11-27 je
v [historickém přehledu](kontroly-stranek.md).

<a id="interaktivni-vizualizace"></a>

## Interaktivní vizualizace

Stránky `quarto/viz_<tema>.qmd` používají buňky Quarto OJS (`{ojs}` s `//| echo: false`).
Observable Plot a d3 jsou součástí standardní knihovny OJS; při zobrazení
stránky je prohlížeč načítá z CDN jsdelivr, takže vizualizace bez připojení
k internetu nefungují. Nic se neinstaluje a web nepotřebuje server.
Zdrojový kód buňky ponechává Quarto ve skrytém bloku `.cell-code`;
kontrola webu hlídá, aby se nikdy nezobrazil. Sdílené styly mají
předponu `.viz` v `assets/styles.css`.

Zobrazení na celou obrazovku zajišťuje sdílený skript
`assets/viz-fullscreen.js` (připojený v `assets/after-body.html`). Každý
blok `.viz` dostane tlačítko „Zobrazit na celou obrazovku“; celý blok
včetně ovládání se zobrazí přes Fullscreen API a Escape jej zavře.
V prohlížečích bez této funkce (Safari na iPhonu) se tlačítko nevloží.
Na celé obrazovce má kořen vizualizace třídu `viz-is-fullscreen`; nová
vizualizace má proto strop šířky grafů zapsat jako
`Math.min(<kontejner>.clientWidth || 640, root.classList.contains("viz-is-fullscreen") ? 1200 : 780)`
a překreslovat se vlastním `ResizeObserver` jako stávající stránky.

Stránka se vykreslí s celou knihou (`quarto render`) i samostatně
(`quarto render quarto/viz_<tema>.qmd`). Pro náhled ji otevřete přes
místní server, ne jako `file://`. Ruční PDF ani export tutora vizualizace
nepřebírají: `scripts/render-book-pdf.ps1` přepíše odkazy `viz_….qmd`
na webovou adresu a `scripts/export-tutor.cjs` dělá totéž v balíčku.

Kvůli skrytému bloku s kódem mají stránky vizualizací v hlavičce
`code-copy: false`; jinak by Quarto nad grafem zobrazilo tlačítko
„Zkopírovat do schránky“.

Každá vizualizace vystavuje na kořenovém prvku objekt `vizCheck`, který
používá `check-html.cjs`.
Scénáře kontroly jednotlivých stránek jsou přímo v tomto skriptu; referenční
hodnoty novějších vizualizací počítají skripty `scripts/viz-<tema>.R`.

Živá kontingenční tabulka uvnitř vizualizace (prvek `.viz` s `aria-label`)
se mění se vstupy, a proto nemá číslo „Tabulka X“ ani titulek Quarta;
obecná kontrola tabulek u ní ověřuje jen linky záhlaví.

**Sbalená část v postranní nabídce.** Quarto umí sbalit části nabídky jen
všechny najednou (`sidebar: collapse-level`). Části „Interaktivní
vizualizace“ a „Statistické aplikace“ proto sbaluje skript `assets/sidebar-collapse.js`, připojený
v `assets/after-body.html` bez `defer`, aby proběhl před prvním vykreslením.
Části najde podle názvu; při přejmenování v `_quarto.yml` je třeba
upravit i seznam `TITLES` ve skriptu. Na vlastních stránkách zůstává
část rozbalená a bez JavaScriptu je rozbalená všude. `check-html.cjs`
ověřuje sbalený stav na stránce kapitoly, rozbalení klávesou Enter
a rozbalený stav na stránce vizualizace.

Referenční hodnoty z R jsou zapsané přímo v testu. Snímky mobilního
zobrazení se ukládají do `tmp/verification/`. Vzorce Excelu nabízené
stránkou kontrola porovnává jen jako text; jejich výsledky byly při
zavedení ověřeny v českém Excelu (viz [autorská historie](../../quarto/README.md)).

<a id="statisticke-aplikace"></a>

## Statistické aplikace

Stránky `quarto/app_<tema>.qmd` jsou technicky stejné jako vizualizace:
jedna buňka Quarto OJS s `//| echo: false`, kořen s třídami `viz viz-app`
(tlačítko celé obrazovky, sdílené styly), vlastní `ResizeObserver`
a háček `root.vizCheck` pro automatickou kontrolu. Styly s předponou
`.viz-app-` jsou v `assets/styles.css`. Platí pro ně také pravidla
předchozího oddílu o renderu, náhledu a sbalené části v postranní nabídce.

Výpočty nejsou ve stránce, ale ve sdíleném ES modulu `assets/stat/<tema>.js`
bez závislostí. Stránka jej načítá dynamickým importem relativně k adrese
stránky (`import(new URL("../assets/stat/podil.js", document.baseURI).href)`);
Quarto jej kopíruje do `_book/assets/` jako součást `/assets/`. Týž modul
ověřuje Node bez prohlížeče. Pro test jednoho podílu:

```sh
Rscript --vanilla scripts/app-jeden-podil.R
node scripts/check-stat-lib.mjs
```

R skript vypíše pole referenčních hodnot (`prop.test` bez korekce na spojitost,
`binom.test`, Wilsonovy intervaly) pro mřížku případů; pole je vložené
do `scripts/check-stat-lib.mjs` a jeho výběr do `check-html.cjs`. Po změně
modulu nebo mřížky skript spusťte znovu a obě místa aktualizujte. Aplikace
výpočet v Excelu neuvádějí (upřesnění R87).

Test dvou podílů má modul `assets/stat/dva-podily.js` (importuje `podil.js`).
Referenční hodnoty zapisuje R skript do `scripts/reference/app-dva-podily.json`,
který čte `scripts/check-stat-lib.mjs` i `check-html.cjs`; potřebuje balíčky
`jsonlite`, `DescTools` (Newcombův interval) a `Exact` (přesný nepodmíněný test
podle Agrestiho a Mina; jeho hlášení o doplňkovém balíčku `ExactData` lze pominout, není
potřeba). Běh trvá asi 20 s:

```sh
Rscript --vanilla scripts/app-dva-podily.R
node scripts/check-stat-lib.mjs
```

Kontrola modulu porovnává test se společným podílem a skórový test pro
δ₀ ≠ 0, Fisherův test, Newcombovy intervaly, poměry s intervaly a φ s R
(tolerance 10⁻⁹), přesné *p*-hodnoty s balíčkem `Exact` (modul smí vyjít
nejvýše o 10⁻³ výš, protože maximum přes rušivý parametr hledá i na krajích
rozsahu; shody statistiky *t*₀ = 0 se přeskakují) a přesné intervaly s tabulkou 3
článku. Přesný výpočet běží v prohlížeči jen pro skupiny do 200 případů
(`EXACT_MAX`; 200 a 200 trvá v Node asi 0,35 s) se zpožděním 0,3 s po poslední změně.

Test jednoho průměru má moduly `assets/stat/prumer.js` (testy, intervaly, necentrální
*t*-rozdělení, Bonettovy intervaly) a `assets/stat/normalita.js` (ukazatele tvaru, krabicový
graf, Shapirův–Wilkův test, jádrový odhad hustoty, Q–Q pásy). Úrovně γ(*n*) pásu
tail-sensitive jsou předem spočítané v `assets/stat/qq-ts-gamma.js`; generuje je simulace
(asi 8 minut, pevný seed) a teprve potom referenční skript, který tabulku čte. Referenční
skript potřebuje balíčky `jsonlite`, `effectsize`, `MBESS`, `ggplot2` a `qqplotr`
(nepovinně `e1071`); běží asi 25 s:

```sh
Rscript --vanilla scripts/qq-ts-gamma.R
Rscript --vanilla scripts/app-jeden-prumer.R
node scripts/check-stat-lib.mjs
```

Kontrola modulu porovnává testy, intervaly, test ekvivalence a přesné intervaly pro *d*
(necentrální *t* integrací, protože `pt(…, ncp)` v R pro ncp > 37,62 jen aproximuje)
s R, Bonettovy intervaly s přepisem rovnic článku, Shapirův–Wilkův test se `shapiro.test`,
pás KS s `qqplotr::stat_qq_band` a pás tail-sensitive s výpočtem v R pro tutéž tabulku γ;
vypíše také simultánní pokrytí obou pásů z 4 000 normálních výběrů.
