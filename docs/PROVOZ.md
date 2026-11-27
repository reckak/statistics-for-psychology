# Provozní návody

[Zpět na přehled projektu](../README.md)

Tento dokument je hlavním místem pro provozní příkazy, závislosti a technické
postupy. Příkazy spouštějte z kořene repozitáře, nikoli ze složky `docs/`;
také cesty uvedené v kódu jsou relativní ke kořeni. Pravidla tvorby a volby
kontrol podle změny určuje [AGENTS.md](../AGENTS.md).

Oddíly o PDF, AI tutorovi, vizualizacích a aplikacích a o obnově sešitů zde
mají jen stručné shrnutí s odkazem; podrobné návody jsou v samostatných
souborech složky `docs/provoz/`.

## Obsah

- [Sestavení a náhled webu](#práce-s-projektem)
- [Pracovní PDF kapitoly](#ruční-pdf-vybrané-kapitoly)
- [PDF celé učebnice a jeho vydání](#pdf-cele-ucebnice)
- [Export podkladů AI tutora](#export-ai-tutora)
- [Interaktivní vizualizace](#interaktivni-vizualizace)
- [Statistické aplikace](#statisticke-aplikace)
- [Kontroly dokumentace, HTML a výpočtů](#kontroly-a-github)
- [Obnova sešitů v Excelu](#obnova-sešitů-a-podkladů-kapitol-17)
- [Publikování na GitHub Pages](#publikování-na-github-pages)

## Práce s projektem

Pro sestavení webu potřebujete Quarto; projekt je ověřován s verzí **1.9.38**. V RStudiu otevřete kořenovou složku projektu. R slouží k interním kontrolám výpočtů, jeho kód se studentům nezobrazuje. Render nyní vyžaduje také **R** (ověřeno 4.5.1), dostupné jako `Rscript`. Před sestavením vytváří grafy z pevných dat; nejsou potřeba žádné další balíčky R. Spouštěcí skript zajišťuje načtení českých popisků v UTF-8 i ve Windows. Matematiku Quarto převádí do nativního MathML, takže její zobrazení nevyžaduje přístup k externímu serveru.

Desetinná čísla v matematice zapisujte s čárkou ve složených závorkách, například `$0{,}841$`. Filtr `filters/desetinna-carka.lua` (zapnutý jen pro HTML v `_quarto.yml`) z takového zápisu vytvoří jediný číselný prvek `<mn>0,841</mn>`; bez něj by MathML čárku zobrazil jako oddělovač s mezerou („0, 841“). Obyčejná čárka bez závorek, například v `N(50,10)`, zůstává oddělovačem. Výraz, který už obsahuje desetinnou tečku, filtr ponechá beze změny a vypíše varování. Ruční PDF kapitol tento HTML filtr nepoužívá; samostatný filtr `scripts/pdf/typography.lua` převádí desetinné literály na atomická čísla v Typstu a váže česká jednopísmenná slova nezlomitelnou mezerou. Zdrojový zápis matematiky se nemění. `check-html.cjs` ověřuje, že počet čárek `{,}` v TeXu každého vzorce odpovídá počtu čárek uvnitř `<mn>`.

Z kořene projektu vykreslete celou učebnici:

```sh
quarto render
```

Pro prohlížení s průběžným obnovováním použijte:

```sh
quarto preview
```

Výstup vzniká ve složce `_book/`, úvodní stránka je `_book/index.html`. Pro přenos nebo publikování zachovejte celou složku `_book/` včetně podpůrných souborů. Generované HTML neupravujte ručně.

Vzory v `project.resources` v `_quarto.yml` začínají lomítkem (`/assets/`, `/data/*.xlsx`). Quarto je čte podobně jako `.gitignore`: vzor bez úvodního lomítka by platil v libovolné hloubce a do `_book/` by zkopíroval i složky `assets/` a `data/` z `tmp/`, `plugins/` či `node_modules/`. Obsahuje-li `_book/` po renderu jiné složky než `assets/`, `data/`, `quarto/` a `site_libs/`, zkontrolujte nové zdroje.

Renderování webu vyžaduje také Node.js pro úpravu popisků po sestavení.
Společný filtr `filters/table-style.lua` označuje souhrnné řádky a zarovnává
jednoznačně číselné sloupce, pokud autor neurčil zarovnání. Podle
[R78](rozhodnuti/spolecne-konvence.md#r78-zalamovani-vzorcu) také zalamuje
vzorce Excelu delší než 50 znaků v buňkách tabulek: za středníkem nebo před
operátorem na co nejmělčí úrovni vnoření, řádky zhruba do 40 znaků, pokračování
odsazené nezlomitelnými mezerami pod otevírací závorku (u dlouhého názvu funkce,
který by řádek přetáhl, závěsně o dva znaky od začátku názvu). Zdroj ponechává
vzorec na jednom řádku. Tabulky se vzorci mají automatické šířky sloupců (Pandoc by
jinak kvůli dlouhému řádku zdroje dal všem sloupcům stejný podíl) a od šířky 601 px
se řádky vzorců v buňkách dál nelámou (`assets/styles.css`). Filtr používá web i ruční PDF; surové HTML přehledu
`quarto/excel.qmd` zalamujeme ručně (`<br>`, `&nbsp;`) stejným rozvržením. Skript
`scripts/style-html-tables.cjs` po renderování vytvoří z automatických
popisků Quarta číslo a název na samostatných řádcích; tato sazba funguje
i bez JavaScriptu. Číslování a odkazy nadále spravuje Quarto. V nečíslovaných
referenčních kapitolách má každá tabulka místní číslo 1; rozlišují je
kapitoly a jedinečná ID. Styly tabulek jsou v `assets/styles.css` a
`scripts/pdf/layout.typ` (v PDF centruje tabulky užší než text); úplnou konvenci stanoví [projektová pravidla](../AGENTS.md#sazba-tabulek).

## Ruční PDF vybrané kapitoly

Pracovní PDF kapitol 3–10 se sestavuje jen na výslovné vyžádání příkazem
`./scripts/render-chapter-pdf.ps1 -Chapter N`; převod ověřuje
`node scripts/check-chapter-pdf.cjs --chapter N`. Závislosti, typografické
kontroly a vizuální prohlídku popisuje [návod k PDF](provoz/pdf.md#ruční-pdf-vybrané-kapitoly).

<a id="pdf-cele-ucebnice"></a>

## PDF celé učebnice

Souhrnné PDF celé knihy sestavuje na výslovné vyžádání
`./scripts/render-book-pdf.ps1` a převod ověřuje `node scripts/check-book-pdf.cjs`;
novou verzi do vydání `ucebnice-pdf` nahrávejte jen na pokyn autora
([R80](rozhodnuti/postupy-a-dokumentace.md#r80-pdf-cele-ucebnice)). Sestavení
i vydání popisuje [návod k PDF](provoz/pdf.md#pdf-cele-ucebnice).

<a id="export-ai-tutora"></a>

## Export kapitol a přehledů pro AI tutora

Balíčky AI tutora pro ChatGPT, Claude a Gemini sestavuje
`node scripts/export-tutor.cjs` a kontroluje `node scripts/check-tutor.cjs`;
pravidla určuje [AITUTORS.md](AITUTORS.md). Obsah balíčků, závislosti, data
ke grafům a vydání na GitHubu popisuje [návod k exportu tutora](provoz/ai-tutor.md#export-ai-tutora).

<a id="interaktivni-vizualizace"></a>

## Interaktivní vizualizace

Stránky `quarto/viz_<tema>.qmd` používají Quarto OJS bez zobrazeného kódu
a kontroluje je `node quarto/_verification/check-html.cjs`. Techniku, celou
obrazovku, render, náhled a sbalenou část nabídky popisuje [návod
k vizualizacím a aplikacím](provoz/vizualizace-a-aplikace.md#interaktivni-vizualizace);
výčet kontrol jednotlivých stránek ke dni 2026-11-27 je v [historickém
přehledu](provoz/kontroly-stranek.md).

<a id="statisticke-aplikace"></a>

## Statistické aplikace

Stránky `quarto/app_<tema>.qmd` počítají ve sdílených modulech `assets/stat/`,
které proti R ověřují skripty `scripts/app-<tema>.R` a `node scripts/check-stat-lib.mjs`.
Moduly, závislosti R a obnovu referenčních hodnot popisuje [návod
k vizualizacím a aplikacím](provoz/vizualizace-a-aplikace.md#statisticke-aplikace).

## Kontroly a GitHub

Odkazy autorských map, registru rozhodnutí i tematických dokladů, kořenového
README, tohoto provozního návodu a podrobných návodů v `docs/provoz/`,
autorské historie `quarto/README.md` a jejího archivu v `docs/historie/`
včetně příchozích odkazů z verzovaných dokumentů ověří
`node scripts/check-doc-maps.cjs`. Kontrola není součástí workflow GitHubu;
spouštějte ji lokálně. V pracovní kopii s neveřejnými podklady
přidejte `--require-sources`, aby kontrola vyžadovala také všechny místní
cíle v `sources/`. Kontrola řeší cesty a kotvy; neověřuje obsah podkladů
ani dostupnost externích webů. Při přesunu map lze jednorázově přidat
`--baseline <commit-před-přesunem>` pro porovnání obsahu a starých kotev
s předchozím stavem. U původního úplného přehledu rozhodnutí ověřuje také
zachování každého záznamu v pořadí v jeho tematickém souboru. Běžná kontrola
hlídá jedinečnost rozhodnutí a shodu registru s podrobnými záznamy.
Režim s výchozím commitem není určen pro pozdější obsahové změny.

Po změně společného vzhledu nebo navigace vykreslete celou knihu. Pro automatickou kontrolu HTML potřebujete Node.js, Playwright a Chromium. Závislosti nainstalujte jednorázově podle potřeby:

```sh
npm install --no-save --package-lock=false playwright@1.55.0
npx playwright install chromium
```

Po renderování spusťte:

```sh
node quarto/_verification/check-html.cjs
```

Alternativně lze cestu k modulu Playwright předat proměnnou `PLAYWRIGHT_MODULE` a cestu k existujícímu prohlížeči proměnnou `CHROME_PATH`.

Kontrola prochází všechny stránky knihy: ověřuje místní odkazy, jedinečné identifikátory, pravý obsah kapitoly, rozložení stránky, skrytí a rozbalení řešení, ovládání přehledových tabulek a mobilní zobrazení. Snímky pro vizuální kontrolu ukládá do `tmp/verification/`. Na úzkých obrazovkách se pravý obsah skrývá, aby zůstal prostor pro text. Stránky bez podnadpisů samostatný obsah nepotřebují.

Po obsahové změně spusťte také příslušnou kontrolu modelových dat a číselných odpovědí (vyžaduje R, bez dalších balíčků):

```sh
Rscript --vanilla quarto/_verification/check-chapter-01.R
Rscript --vanilla quarto/_verification/check-chapter-02.R
Rscript --vanilla quarto/_verification/check-chapter-03.R
Rscript --vanilla quarto/_verification/check-chapter-04.R
Rscript --vanilla quarto/_verification/check-chapter-05.R
Rscript --vanilla quarto/_verification/check-chapter-06.R
Rscript --vanilla quarto/_verification/check-chapter-07.R
Rscript --vanilla quarto/_verification/check-chapter-08.R
Rscript --vanilla quarto/_verification/check-chapter-09.R
Rscript --vanilla quarto/_verification/check-chapter-10.R
```

Ověření chování chybějících hodnot v instalovaném desktopovém Excelu pro Windows zajišťuje samostatný skript `quarto/_verification/check-excel.ps1`. Sešit druhé kapitoly ověřuje `quarto/_verification/check-chapter-02-excel.ps1` v samostatné skryté instanci Excelu. Kontroluje české vzorce, přesnost výsledků, všech 180 vstupních buněk a přepočet grafů při změně dat; změny z kontrol neukládá. Rozsah a výsledky provedených kontrol jsou v [autorské dokumentaci](../quarto/README.md). Automatické kontroly nenahrazují odbornou revizi textu a vizuální prohlídku webu.

Třetí kapitolu ověřuje `check-chapter-03-excel.ps1` stejným způsobem: české vzorce, původní vstupy včetně listu `Kontrola_prikladu` a samostatných vstupů a chybění, oba výpočty rozptylu, MAD, entropii, momentové koeficienty a přepočet při změně vstupu. Její R kontrola navíc porovnává simulaci korekce rozptylu s přesným výčtem všech výběrů velikosti pět z použité modelové populace.

Čtvrtou kapitolu ověřuje `check-chapter-04.R`: plochy, kvantily, řešení,
mezní hodnoty stenů a staninů a souřadnice Q–Q grafu. Skript
`check-chapter-04-excel.ps1` skutečně spouští české vzorce, kontroluje
inverzní převody, nepřípustné krajní argumenty, změny vstupů a vazby
dvou řad bodového grafu. Přepínač `-Finalize` také nastaví jeho nativní
značky a referenční přímku, uloží sešit a vytvoří kontrolní PDF
sešitu do `tmp/chapter-04/`. Běžný běh změny neukládá.

Pátou kapitolu ověřuje `check-chapter-05.R`: hodnoty citované ve výkladu
(včetně pěti simulovaných řad a 40 simulovaných studentů), tabulky, nepovinná
rozšíření, řešení všech dvanácti cvičení a dvanáct obrázků. Skript
`check-chapter-05-excel.ps1` otevře sešit pouze pro čtení v samostatné skryté
instanci Excelu a nic neukládá: porovná 74 uložených výsledků, zadá 28 českých
vzorců citovaných v textu a řešeních, ověří chybové hodnoty u nepřípustných
argumentů a přepočet při změně žlutých vstupů. Očekávané hodnoty jsou
v `check-chapter-05-excel.json`; vytváří je
`python quarto/_verification/check-chapter-05-excel-expected.py quarto/_verification/check-chapter-05-excel.json`
přesnou racionální aritmetikou nezávisle na Excelu i R.

Šestou kapitolu ověřuje `check-chapter-06.R`: přesný příklad devíti výběrů,
hodnoty normálního a binomického modelu, všechny údaje ze tří simulací
citované ve výkladu, nepovinná rozšíření včetně rozdělení *p*-hodnot,
řešení šestnácti cvičení a sedmnáct obrázků. Skript `check-chapter-06-excel.ps1` otevře sešit pouze
pro čtení v samostatné skryté instanci Excelu a nic neukládá: porovná
47 uložených výsledků, zadá 34 českých vzorců citovaných v textu a řešeních
(včetně počtů COUNTIFS nad 10 000 simulovanými rozdíly), ověří chybové
hodnoty u nepřípustných argumentů, přepočet při patnácti změnách žlutých vstupů
(včetně hladiny v B5 listu `Sila` pro rozdělení *p*-hodnot)
a zápis osmi vzorců listů v češtině. Očekávané hodnoty jsou
v `check-chapter-06-excel.json`; vytváří je
`python quarto/_verification/check-chapter-06-excel-expected.py quarto/_verification/check-chapter-06-excel.json`
standardní knihovnou Pythonu nezávisle na Excelu i R. Počty nad uloženými
simulovanými daty jsou v něm konstanty; ze stejných seedů je nezávisle
ověřuje `check-chapter-06.R`.

Sedmou kapitolu ověřuje `check-chapter-07.R`: intervaly, t-testy, TOST,
řešení, obě simulace, screeningové podíly, Q–Q souřadnice a hraniční
p-hodnoty. Spouští také `scripts/kapitola_07-odolnost.R` (asi 15 s,
100 000 výběrů na podmínku) a porovná jeho výsledky s tabulkou odolnosti
v nepovinném rozšíření. Skript `check-chapter-07-excel.ps1` kontroluje v samostatném
skrytém Excelu uložené výsledky, české vzorce, přepočet při změně vstupů,
popisky pro hladiny 0,01/0,05/0,10 a spolehlivosti 0,90/0,95/0,99,
přesný dotyk obou hranic ekvivalence a pravidlo p ≤ α. Změny neukládá.
Nezávislé reference jsou v `check-chapter-07-excel.json`; obnoví je
`python quarto/_verification/check-chapter-07-excel-expected.py quarto/_verification/check-chapter-07-excel.json`.
K obnově sešitu včetně kontrol použijte
`powershell -NoProfile -ExecutionPolicy Bypass -File scripts/build-workbooks.ps1 -Chapter 7 -Verify`.

Osmou kapitolu ověřuje `check-chapter-08.R`: párový, klasický a Welchův test
proti `t.test`, pravděpodobnosti t-rozdělení přes neúplnou funkci beta,
všechna čísla citovaná v textu a v řešeních. Skript `check-chapter-08-excel.ps1`
kontroluje v samostatném skrytém Excelu uložené výsledky, prázdné buňky
neúplné dvojice, české vzorce z textu (včetně T.TEST typů 1–3 a kvantilu
Welchova testu přes BETA.INV s neceločíselnými stupni volnosti), přepočet při
změně vstupů a přesný dotyk hranice ekvivalence. Změny neukládá. Nezávislé
reference jsou v `check-chapter-08-excel.json`; obnoví je
`python quarto/_verification/check-chapter-08-excel-expected.py quarto/_verification/check-chapter-08-excel.json`.
Sešit kapitoly 8 nepoužívá simulace z `scripts/sesity-simulace.R`.

Devátou kapitolu ověřuje `check-chapter-09.R`: Wilsonův interval proti
`prop.test(..., correct = FALSE)`, nekorigovaný Pearsonův test proti
`chisq.test(..., correct = FALSE)` (výchozí `chisq.test` u tabulky 2 × 2
používá Yatesovu korekci a dává jinou hodnotu), standardizovaná a Pearsonova rezidua
proti `chisq.test()$stdres` a `$residuals`, Fisherův test proti `fisher.test`,
přesný McNemarův postup binomickým testem neshodných dvojic, Newcombův interval
nezávisle vypsaným vzorcem, okrajový případ bez neshodných dvojic a všechna
čísla citovaná v textu a v řešeních. Simulace 10 000 výběrů v `scripts/kapitola_09.R`
má pevný seed. Skript `check-chapter-09-excel.ps1` kontroluje v samostatném
skrytém Excelu uložené výsledky všech osmi výpočtových listů včetně Holmových
rozhodnutí, prázdné buňky nemožných hodnot listu `Fisher`, české vzorce z textu
a řešení, chybové hodnoty u nepřípustných argumentů, přepočet při dosazení dat
ze cvičení (včetně případu bez neshodných dvojic s textovým výsledkem „nelze“)
a zápis patnácti vzorců listů v češtině. Změny neukládá. Od revize 2026-11-16
`check-chapter-09.R` ověřuje také přesné pokrytí Waldova a Wilsonova intervalu
(nezávislým výpočtem s `prop.test`), tabulku Holmovy korekce proti `p.adjust`,
znaménkový test proti `binom.test`, φ se znaménkem proti korelaci kódů 0/1
a simulovanou *p*-hodnotu proti `chisq.test(simulate.p.value = TRUE)`
a `fisher.test`; simulace má pevný seed 20261117 (simulace druhých mocnin *z*
se seedem 20261116 zanikla 2026-11-27). Od 2026-11-27 ověřuje také přesný
oboustranný binomický test proti `binom.test` a všechna čísla pododdílu
o testu jednoho podílu ze tří rozdělení, jeho obrázku a části e) cvičení 5;
kontrola Excelu zahrnuje řádky B21:B27 a sloupce F:G listu `Interval_podilu`
včetně textového výsledku „n nad 400“. Od 2026-11-17
ověřuje také nepovinné odvození Wilsonova intervalu: kořeny kvadratické rovnice
proti uzavřenému vzorci, `prop.test` a `polyroot`, zjednodušený výraz pod
odmocninou a čísla citovaná v rozšíření. Nezávislé reference
jsou v `check-chapter-09-excel.json`; obnoví je
`python quarto/_verification/check-chapter-09-excel-expected.py quarto/_verification/check-chapter-09-excel.json`.
Funkce HYPGEOM.DIST u nemožné kombinace argumentů nemusí vracet chybu, proto
ji list `Fisher` volá jen pro přípustné hodnoty.

Desátou kapitolu ověřuje `check-chapter-10.R`: koeficienty proti `cor`
(Pearson, Spearman, Kendall τ<sub>b</sub>), test a Fisherův interval proti `cor.test`,
bodově biseriální korelaci proti `t.test`, přesné permutace šesti lidí a všechna
čísla citovaná v textu a v řešeních. Data, pevné indexy převzorkování a výsledky
9 999 opakování vytváří `scripts/kapitola_10.R` (seedy 20261109 a další) do
`tmp/chapter-10-indices/`; s `CH10_NOFIG=1` vynechá obrázky, s `CH10_PNG=1` je zapíše
jako PNG do `tmp/chapter-10-png/` pro prohlídku. Simulaci pokrytí percentilového
intervalu a chybovosti permutačního testu citovanou v textu obnoví
`Rscript --vanilla scripts/kapitola_10-pokryti.R` (asi 8 minut, výsledek
`tmp/chapter-10-pokryti.csv`, který kontrola porovná, pokud existuje). Skript
`check-chapter-10-excel.ps1` kontroluje v samostatném skrytém Excelu uložené
výsledky, české vzorce z textu, sedm scénářů s daty cvičení a to, že součty přes
dvojice jsou vzorci dynamického pole; změny neukládá. Očekávané hodnoty obnoví
`Rscript --vanilla quarto/_verification/check-chapter-10-excel-expected.R`.
Sešit kapitoly 10 vyžaduje pro výpočty převzorkování Excel pro Microsoft 365
nebo Excel 2021 a novější (vzorce `Formula2Local`).

Všechny kapitoly používají společnou sadu záznamů `references.bib` i pro rozlišení stejně datovaných zdrojů téhož autora. Nastavení `nocite: '@*'` sjednocuje písmena za rokem mezi kapitolami, citačními náhledy a společnou literaturou. Do bibliografie proto ukládejte jen zdroje skutečně použité v knize; webová kontrola ověřuje shodu záznamů.

Změny připravujte v tematické větvi `codex/` a předložte je prostřednictvím pull requestu. Sloučení do `main` provádí autor projektu.

<a id="obnova-sešitů-a-podkladů-kapitol-16"></a>

## Obnova sešitů a podkladů kapitol 1–7

Všechny sešity `data/kapitola_NN.xlsx` vytváří v desktopovém Excelu pro Windows
`scripts/build-workbooks.ps1` (s přepínačem `-Verify` včetně kontrol). Zdroje
generátoru, průběh sestavení a ověření obsahu a vzhledu popisuje [návod
k sešitům](provoz/sesity.md#obnova-sešitů-a-podkladů-kapitol-17).

## Publikování na GitHub Pages

Workflow **Ověřit a publikovat učebnici** v `.github/workflows/book.yml` při pull requestu sestaví celou knihu a spustí kontrolu HTML. Po změně `main` navíc publikuje ověřený obsah `_book/` na GitHub Pages. Workflow také vytváří grafy v R a spouští číselné kontroly kapitol 2–7. Desktopový Excel vyžaduje místní Windows a v CI se nespouští. Neúspěšné sestavení nebo kontrola HTML zabrání publikování. Sestavovací job běží na `ubuntu-24.04`, nikoli `ubuntu-latest`: od listopadu 2026 je `ubuntu-latest` Ubuntu 26.04, které Playwright 1.55 nepodporuje. Při povýšení systému je nutné současně povýšit Playwright na verzi s jeho podporou. Sestavovací job má časový limit 40 minut a kroky instalující systémové balíčky (`setup-r`, `playwright install --with-deps`) po 10 minutách; běžné sestavení trvá 7–15 minut, instalace R asi minutu. Limit ukončí běh, který visí kvůli nedostupnému balíčkovému serveru Ubuntu; takový běh stačí po obnovení služby spustit znovu (**Re-run failed jobs**).

Při prvním zprovoznění:

1. V repozitáři na GitHubu otevřete **Settings → Pages**.
2. V části **Build and deployment → Source** vyberte **GitHub Actions**. Projekt již vlastní workflow obsahuje.
3. Slučte připravený pull request do `main`.
4. Na kartě **Actions** zkontrolujte úspěšné dokončení sestavení i publikování.

Pokud jste Pages zapnuli až po sloučení, spusťte **Actions → Ověřit a publikovat učebnici → Run workflow** pro větev `main`. Ruční běh na jiné větvi web nepublikuje. Není potřeba větev `gh-pages` ani ukládání generovaného HTML do zdrojové větve.

Po nasazení ověřte [veřejnou učebnici](https://reckak.github.io/statistics-for-psychology/), přechody mezi kapitolami a načtení podpůrných souborů. Lokální render ani úspěšná kontrola pull requestu samy nepotvrzují zveřejnění změn.
