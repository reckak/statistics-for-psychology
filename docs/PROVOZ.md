# Provozní návody

[Zpět na přehled projektu](../README.md)

Tento dokument je hlavním místem pro provozní příkazy, závislosti a technické
postupy. Příkazy spouštějte z kořene repozitáře, nikoli ze složky `docs/`;
také cesty uvedené v kódu jsou relativní ke kořeni. Pravidla tvorby a volby
kontrol podle změny určuje [AGENTS.md](../AGENTS.md).

## Obsah

- [Sestavení a náhled webu](#práce-s-projektem)
- [Pracovní PDF kapitoly](#ruční-pdf-vybrané-kapitoly)
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

Renderování webu vyžaduje také Node.js pro úpravu popisků po sestavení.
Společný filtr `filters/table-style.lua` označuje souhrnné řádky a zarovnává
jednoznačně číselné sloupce, pokud autor neurčil zarovnání. Skript
`scripts/style-html-tables.cjs` po renderování vytvoří z automatických
popisků Quarta číslo a název na samostatných řádcích; tato sazba funguje
i bez JavaScriptu. Číslování a odkazy nadále spravuje Quarto. V nečíslovaných
referenčních kapitolách má každá tabulka místní číslo 1; rozlišují je
kapitoly a jedinečná ID. Styly tabulek jsou v `assets/styles.css` a
`scripts/pdf/layout.typ`; úplnou konvenci stanoví [projektová pravidla](../AGENTS.md#sazba-tabulek).

## Ruční PDF vybrané kapitoly

Pracovní PDF se sestavuje pouze na výslovné vyžádání. Aktuálně je připraven
a ověřen export kapitol 3, 4, 5, 6 a 7. Z kořene projektu v PowerShellu spusťte
příkaz pro požadovanou kapitolu, například:

```powershell
./scripts/render-chapter-pdf.ps1 -Chapter 4
```

Pro kapitoly 5, 6 a 7 použijte `-Chapter 5`, `-Chapter 6` či `-Chapter 7`
a stejné číslo v kontrole `--chapter`.
Pro kapitolu 3 použijte `-Chapter 3` (také výchozí volba).
Výstup skriptu nepřesměrovávejte pomocí `2>&1` ani `2>$null`: Windows
PowerShell 5.1 pak běžná hlášení Quarta na chybovém výstupu považuje za chybu
a export přeruší.
Výsledek je `output/pdf/kapitola_NN.pdf`, kde NN je 03 až 07. Skript používá aktuální
`quarto/kapitola_NN.qmd`, obnoví její grafy v R a sestaví PDF prostřednictvím
Typstu dodávaného s Quartem. Ověřeno s Quartem 1.9.38, Typstem 0.14.2,
R 4.5.1 a Windows PowerShellem 5.1. Není potřeba instalovat LaTeX.
Quarto a Rscript se hledají v PATH a poté v běžných místních umístěních;
jinde použijte parametry `-QuartoPath` a `-RscriptPath` s cestami k programům.

PDF obsahuje výklad, všechna zadání (15 v kapitole 3, 10 v kapitole 4, 12 v kapitole 5, 16 v kapitole 6, 14 v kapitole 7), samostatný oddíl řešení s obousměrnými
odkazy a literaturu citovanou v kapitole. Nepovinná rozšíření jsou rozepsaná.
Závěrečný slovníček, přehled značení ani přehled funkcí Excelu se nepřipojují.
Odkazy mimo kapitolu a na XLSX vedou na veřejný web a potřebují internet;
pro práci offline si sešit stáhněte samostatně.

Nastavení je v `scripts/pdf/`; izolované pomocné sestavení vzniká
v `tmp/pdf-chapter-NN/`. Pomocná kopie kapitoly není určena k editaci.
Cílové PDF se nahradí až po úspěšném sestavení. PDF i pomocné soubory jsou
ignorovány Gitem. Běžné `quarto render`, náhled a workflow GitHub Pages
PDF nespouštějí ani nepublikují.

Kontrolu zachování všech řešení, rovnic, tabulek, obrázků, kódu a citací
při přesunu lze spustit pomocí Node.js:

```powershell
node scripts/check-chapter-pdf.cjs --chapter 4
```

Volba `--chapter 3` kontroluje kapitolu 3; bez této volby je výchozí kapitola 3.
Další volitelný argument kontroly je cesta ke Quartu. Kontrola transformace
nenahrazuje prohlédnutí výsledného PDF, zejména po změně textu či grafů.

`node scripts/check-table-layout.cjs` prochází všechny tabulky i v otevřených
řešeních na šířkách 1024/1280/1360/1440/1920 a 390 px. Vyžaduje stejný
Playwright a prohlížeč jako kontrola HTML. Ověřuje poznámky menší o 1 pt,
nepřetékání stránky a odstranění drobných desktopových přesahů (2–32 px).
Podrobný výsledek ukládá do `tmp/verification/table-layout.json`.
Skutečné PDF po sestavení všech podporovaných kapitol prověří
`python scripts/check-rendered-pdf.py` (veřejný balíček `pypdf`): velikost
všech poznámek v PDF a přítomnost světle šedých tahů. Poznámky hledá podle
úvodního „*Poznámka.*“; poznámka bez něj kontrolu neprojde. Tato kontrola
nenahrazuje vizuální prohlédnutí tabulek a nového kapitolového exportu.

Typografické případy převodu (desetinná čísla včetně indexů a zlomků,
unární minus a koncová tečka u desetinného čísla, oddělovací čárky,
nezlomitelné vazby přes zvýraznění a odkazy, zachování
matematiky a kódu) ověří `node scripts/check-pdf-typography.cjs`.
Typst v matematice zachovává mezeru vedle textového čísla `upright(…)`.
Filtr proto spojuje unární minus i koncovou tečku s číslem a skript po převodu
odstraňuje mezeru u lomítka, spojuje popisek typu *p*-hodnota a zapisuje
|t| jako absolutní hodnotu. Šířky sloupců širokých tabulek jen pro PDF
nastavuje tabulka `$pdfColumnWidths` v `render-chapter-pdf.ps1`.
Při vizuální kontrole nespoléhejte na starší `pdftoppm` z MiKTeXu: poškozuje
text vektorových grafů, který je v PDF v pořádku.
Kontrola HTML nyní vyžaduje číslo a neprázdný název každé studentské tabulky
a ověřuje sazbu označení i linek záhlaví. Ruční PDF kontrolujte také vizuálně.
Pokud cílový PDF soubor blokuje prohlížeč, zavřete jej a export zopakujte;
úspěšně sestavené PDF zůstává také v pomocné složce uvedené výše.
Po renderování skript navíc váže jednopísmenné slovo před odkazem
v bibliografii vytvořené citeprocem a podle potřeby opakuje překlad Typstu
s místními balíčky a fonty dodanými s Quartem. Adresy odkazů se nemění.

## Kontroly a GitHub

Odkazy autorských map, registru rozhodnutí i tematických dokladů, kořenového
README a tohoto provozního návodu včetně příchozích odkazů z verzovaných dokumentů ověří
`node scripts/check-doc-maps.cjs`. V pracovní kopii s neveřejnými podklady
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
p-hodnoty. Skript `check-chapter-07-excel.ps1` kontroluje v samostatném
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

Všechny kapitoly používají společnou sadu záznamů `references.bib` i pro rozlišení stejně datovaných zdrojů téhož autora. Nastavení `nocite: '@*'` sjednocuje písmena za rokem mezi kapitolami, citačními náhledy a společnou literaturou. Do bibliografie proto ukládejte jen zdroje skutečně použité v knize; webová kontrola ověřuje shodu záznamů.

Změny připravujte v tematické větvi `codex/` a předložte je prostřednictvím pull requestu. Sloučení do `main` provádí autor projektu.

<a id="obnova-sešitů-a-podkladů-kapitol-16"></a>

## Obnova sešitů a podkladů kapitol 1–7

Všech sedm sešitů se vytváří **přímo v desktopovém Excelu pro Windows**.
Potřebujete nainstalovaný český Excel (ověřeno 16.0), Windows PowerShell
5.1, Node.js a pro simulované vstupy kapitol 1 a 4–7 také R. Příkazy `node`
a `Rscript` musí být dostupné v `PATH`. Generátory používají pouze
standardní moduly Node.js a rozhraní COM instalovaného Excelu; nepotřebují
žádný balíček npm, `@oai/artifact-tool` ani prostředí konkrétního LLM.
Spouštějte je lokálně v uživatelské relaci, kde lze spustit Excel.

Z kořene projektu obnovte všechny sešity a spusťte jejich kontroly:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/build-workbooks.ps1 -Verify
```

Jedinou kapitolu lze obnovit například takto (bez `-Verify` se pouze
sestaví a zkontrolují chyby vzorců; nespustí se kapitolové zkoušky):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/build-workbooks.ps1 -Chapter 4 -Verify
```

Přepínač `-Verify` spustí numerické kontroly a změny vstupů vybrané kapitoly
(pro kapitoly 2–7) a kontrolu chyb vzorců ve všech sedmi uložených sešitech.
Samotné kontroly sešity neukládají. Přepočet a konečnou podobu grafů zajišťuje
již generátor; dřívější dokončování pomocí `-Finalize` není k obnově potřeba.
Numerické kontroly v R a vizuální prohlídku proveďte také podle rozsahu změny.

### Zdroje a průběh sestavení

- `scripts/sesity-data.mjs`: společné vstupy, jejich původ a studentské přehledy.
- `scripts/kapitola_NN-sešit.mjs`: rozložení, vzorce a grafy dané kapitoly.
- `scripts/excel-workbook.mjs`: malá místní vrstva zapisující deklarace
  do JSON; sama nepočítá vzorce ani nevytváří XLSX.
- `scripts/build-workbook-excel.ps1`: společný zápis deklarací do skutečného
  Excelu, formátování, ověření vstupů, nativní grafy, přepočet a uložení.
- `scripts/sesity-simulace.R`: stejné pevně reprodukovatelné simulace jako
  v obrázcích; společný spouštěč jej pro kapitoly 4–7 zavolá automaticky.
- `scripts/kapitola_01-simulace.R`: společné simulace pedagogických příkladů
  pro grafy a sešit; generátor kapitoly 1 jej zavolá automaticky.

Každý sešit vzniká v samostatné skryté instanci Excelu. Skript se nepřipojuje
k otevřeným uživatelským sešitům. Nejprve uloží hotový přepočtený soubor
do `tmp/`, poté jej zkopíruje do `data/kapitola_NN.xlsx`; při chybě sestavení
zůstane předchozí studentský sešit zachován. Cílový sešit před obnovou zavřete.
Výstup se otevírá na listu `Prehled` a při ukládání se odstraňují osobní
údaje z vlastností dokumentu.

Generátory kapitol 1–4 zadávají vzorce prostřednictvím `Formula`
ve standardním anglickém zápisu. Kapitoly 5–7 používají české `FormulaLocal`.
České vzorce z učebnice navíc skutečně spouštějí kapitolové kontroly.
Číselné formáty buněk a os respektují místní oddělovače. Textové hodnoty
zůstávají textem i tehdy, když vypadají jako číslo; chybění zůstává prázdné.
Čistě číselné bloky od 1 000 řádků (zatím jen simulovaná data kapitoly 6)
zapisuje generátor jedním přiřazením celé oblasti; menší bloky zůstávají
u zápisu po buňkách se zachováním typů. Kontrola chyb vzorců přeskakuje listy,
které žádný vzorec neobsahují.
Nové soubory PowerShellu používají ASCII a české texty čtou z UTF-8 JSON;
skripty s českými literály musí mít pro Windows PowerShell 5.1 UTF-8 BOM.

### Ověření obsahu a vzhledu

Kontrola vstupů používá standardní Python bez dalších knihoven:

```powershell
python quarto/_verification/check-workbooks.py
```

Porovnává uložené vstupy, typy, chybění a odkazy na listy a buňky v kapitolách.
Deklarace vznikají při sestavení v `tmp/chapter-NN-build/inputs.json`
(kapitola 4: `tmp/chapter-04/inputs.json`). Jejich shoda nenahrazuje
redakční porovnání s textem; pokrytí eviduje [docs/DATA.md](DATA.md).
Kontrolu spusťte **po renderování knihy**, protože kontroluje také totožnost
sešitů v `data/` a `_book/data/`. Při renderování se sešity pouze kopírují;
Excel se nespouští a na GitHubu není k sestavení webu potřeba.

Kontrola kapitoly 5 navíc ověřuje přepočet popisků při změně hranic,
krajní pravděpodobnosti 0 a 1 a ochranu pevných počtů pokusů.
Na listu `Binom` lze upravit pouze B3; na `Binom_20` B3:B5. Ochrana listů
bez hesla chrání výukové vzorce před náhodným přepsáním.

Pro vizuální prohlídku všech listů vytvořte náhledy přímo z Excelu:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File quarto/_verification/preview-workbooks-excel.ps1
```

Kontrolní PDF a přehled oblastí vznikají v `tmp/workbook-previews/`.
U dlouhých vstupních listů náhled ukazuje prvních 15 řádků; kontrola hodnot
prochází všechna data. Výpočtové listy a přehledy se zobrazují celé.
Volitelné parametry `-Chapter 4 -Sheet QQ` omezí náhled na dotčený list.
Tisková nastavení náhledů se do studentských sešitů neukládají.

Při migraci generátoru nejprve odložte kontrolní kopie původních pěti
sešitů do ignorované složky. Nástroj `compare-workbooks.py` pak porovná
všechny vyplněné buňky, vzorce, uložené výsledky, pořadí listů, sloučení
buněk, ukotvení, ověření vstupů, číselné formáty, vazby a meze os grafů. Pouze tato doplňková
kontrola vyžaduje veřejnou knihovnu `openpyxl` (`python -m pip install openpyxl`):

```powershell
python quarto/_verification/compare-workbooks.py tmp/excel-migration/before
```

Grafy učebnice se obnovují při každém renderování; samostatně příkazem
`Rscript --vanilla scripts/render-figures.R`. Názorné rekonstrukce listů
jsou editovatelné SVG; obnovuje je `python scripts/kapitola_02-ukazky.py`
(standardní knihovna Pythonu). Při změně vstupů obnovte sešit, související
ilustrace a knihu a ověřte navazující výklad. Pomocné výstupy patří do `tmp/`.

## Publikování na GitHub Pages

Workflow **Ověřit a publikovat učebnici** v `.github/workflows/book.yml` při pull requestu sestaví celou knihu a spustí kontrolu HTML. Po změně `main` navíc publikuje ověřený obsah `_book/` na GitHub Pages. Workflow také vytváří grafy v R a spouští číselné kontroly kapitol 2–7. Desktopový Excel vyžaduje místní Windows a v CI se nespouští. Neúspěšné sestavení nebo kontrola HTML zabrání publikování.

Při prvním zprovoznění:

1. V repozitáři na GitHubu otevřete **Settings → Pages**.
2. V části **Build and deployment → Source** vyberte **GitHub Actions**. Projekt již vlastní workflow obsahuje.
3. Slučte připravený pull request do `main`.
4. Na kartě **Actions** zkontrolujte úspěšné dokončení sestavení i publikování.

Pokud jste Pages zapnuli až po sloučení, spusťte **Actions → Ověřit a publikovat učebnici → Run workflow** pro větev `main`. Ruční běh na jiné větvi web nepublikuje. Není potřeba větev `gh-pages` ani ukládání generovaného HTML do zdrojové větve.

Po nasazení ověřte [veřejnou učebnici](https://reckak.github.io/statistics-for-psychology/), přechody mezi kapitolami a načtení podpůrných souborů. Lokální render ani úspěšná kontrola pull requestu samy nepotvrzují zveřejnění změn.
