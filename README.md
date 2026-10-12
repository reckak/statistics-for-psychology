# Základy statistiky pro psychology 1

Česká učebnice pro jednosemestrální kurz statistiky ve druhém ročníku bakalářského studia psychologie. Předpokládá matematiku na úrovni základní školy a nevyžaduje znalost R ani programování. Výklad propojuje statistické uvažování s psychologickými příklady, komentovanými postupy a cvičeními se sbaleným řešením.

**[Otevřít webovou učebnici](https://reckak.github.io/statistics-for-psychology/)**

Projekt používá [Quarto Book](https://quarto.org/docs/books/). Aktuálně obsahuje úvod, kapitoly **Od psychologické otázky k datům**, **Četnosti, rozdělení dat a jejich zobrazení**, **Ukazatele polohy a variability**, **Normální rozdělení a standardní skóry** a **Pravděpodobnost** a tři průběžně doplňované přehledy: slovníček pojmů, značení a vzorce a funkce Excelu. Každá z kapitol 1–5 obsahuje jediný excelový sešit se vstupy k příkladům a cvičením a s úvodním přehledem listů. Navigace má dvě rozbalovací části: **Výkladové kapitoly** a **Literatura a přehledy**. Úvod stojí před nimi; druhá část začíná společnou nečíslovanou literaturou a pokračuje třemi přehledy.

## Práce s projektem

Pro sestavení webu potřebujete Quarto; projekt je ověřován s verzí **1.9.38**. V RStudiu otevřete kořenovou složku projektu. R slouží k interním kontrolám výpočtů, jeho kód se studentům nezobrazuje. Render nyní vyžaduje také **R** (ověřeno 4.5.1), dostupné jako `Rscript`. Před sestavením vytváří grafy z pevných dat; nejsou potřeba žádné další balíčky R. Spouštěcí skript zajišťuje načtení českých popisků v UTF-8 i ve Windows. Matematiku Quarto převádí do nativního MathML, takže její zobrazení nevyžaduje přístup k externímu serveru.

Z kořene projektu vykreslete celou učebnici:

```sh
quarto render
```

Pro prohlížení s průběžným obnovováním použijte:

```sh
quarto preview
```

Výstup vzniká ve složce `_book/`, úvodní stránka je `_book/index.html`. Pro přenos nebo publikování zachovejte celou složku `_book/` včetně podpůrných souborů. Generované HTML neupravujte ručně.

## Uspořádání

- `index.qmd`: úvod pro studenty.
- `quarto/kapitola_01.qmd`: od psychologické otázky k datům, včetně závěrečných cvičení.
- `quarto/kapitola_02.qmd`: četnosti, tabulky a grafy, Excel a deset cvičení.
- `quarto/kapitola_03.qmd`: poloha a variabilita, robustní shrnutí, modelový popis, Excel, dvanáct základních a dvě nepovinná cvičení.
- `quarto/kapitola_04.qmd`: normální model, plochy a kvantily, standardní skóry, posouzení modelu a povinné čtení i tvorba Q–Q grafu; deset cvičení.
- `quarto/kapitola_05.qmd`: pravděpodobnost jevů, podmínění a Bayesova věta, rozdělení pravděpodobnosti, binomický model a jeho normální aproximace; dvanáct cvičení a tři nepovinná rozšíření.
- `data/kapitola_01.xlsx`: matice, přehled proměnných, chybění a podklady cvičení 8.
- `data/kapitola_02.xlsx`: příklady a cvičení o četnostech, výpočty a grafy.
- `data/kapitola_03.xlsx`: sešit se všemi autorskými příklady kapitoly, komentovanými mezivýpočty, souhrnem původních dat a nepovinnými rozšířeními. Samostatné CSV kapitola nemá; pevné hodnoty příkladů jsou zapsány také ve skriptech.
- `data/kapitola_04.xlsx`: příklady a cvičení, samostatné skóry pro Q–Q, čtyři simulované soubory a oddělené modelové výpočty.
- `data/kapitola_05.xlsx`: tabulky četností, vstupy screeningu a testů, simulované počty správných tipů a oddělené výpočty Bayesovy věty, binomického rozdělení a aproximace.
- `data/*.csv`: interní vstupy generátorů a kontrol; do webu se nekopírují.
- [docs/DATA.md](docs/DATA.md): audit pokrytí příkladů a všech cvičení sešity.
- `scripts/`: tvorba grafů, sešitu a názorných excelových ilustrací.
- `quarto/literatura.qmd`: společná automaticky generovaná bibliografie celé knihy.
- `quarto/slovnicek.qmd`: české a anglické pojmy s odkazy na výklad.
- `quarto/znaceni.qmd`: přehled matematického a statistického značení a vzorců.
- `quarto/excel.qmd`: přehled užitečných funkcí Excelu.
- `_quarto.yml`: pořadí kapitol a společné nastavení knihy.
- `assets/`: společné styly a ovládání přehledových tabulek.
- `references.bib`: bibliografické údaje citovaných zdrojů.
- `quarto/_verification/`: kontrolní skripty.
- `AGENTS.md`: společná pravidla tvorby, didaktické revize, ověřování a práce s Gitem.
- [docs/PREZENTACE.md](docs/PREZENTACE.md): pravidla pro prezentace, poznámky a jejich exporty.
- [docs/ROZHODNUTI.md](docs/ROZHODNUTI.md): platná autorská rozhodnutí s rozsahem a doklady.
- [docs/SLOVNIK.md](docs/SLOVNIK.md): hlavní autorský registr preferovaných českých termínů, anglických ekvivalentů, alternativ a pravidel použití; rozlišuje doklady jednotlivých voleb a starších schválených celků. Studentské definice zůstávají ve slovníčku.
- [docs/OSNOVA.md](docs/OSNOVA.md): podrobná mapa aktuálního obsahu kapitol, příkladů, cvičení a návazností s tematickým rozcestníkem; plán další kapitoly a neschválené náměty jsou oddělené.
- [docs/ZDROJE.md](docs/ZDROJE.md): autorská mapa podkladů v `sources/`, tematický rozcestník, přesné lokátory, rozpory a rozsah ověření. Odkazy na podklady fungují pouze v místní kopii s neveřejnými zdroji.
- `quarto/README.md`: historická autorská dokumentace, odborné zdroje, rozhodnutí a záznamy ověření.
- `.github/workflows/book.yml`: sestavení, kontrola webu a publikování na GitHub Pages.

Neveřejné autorské podklady ve složce `sources/` nejsou součástí repozitáře ani webu a nejsou potřebné pro čtení, cvičení nebo sestavení knihy. Generované výstupy a dočasné pracovní soubory se do Gitu neukládají.

Novou kapitolu přidejte jako `.qmd` do `quarto/` a zařaďte ji do části **Výkladové kapitoly** v `book.chapters` souboru `_quarto.yml`. Bibliografii udržujte jen ve společné kapitole `quarto/literatura.qmd`; v ostatních kapitolách používejte citační zápis Quarta. Přehledy doplňujte současně s kapitolou. Před psaním dohodněte obsah, terminologii a značení podle [projektových instrukcí](AGENTS.md).

Před psaním a při revizi vyhledejte platné termíny v [autorském registru](docs/SLOVNIK.md), včetně významových hranic a dokladů. Novou schválenou volbu zaznamenejte do rozhodnutí a současně slaďte registr, studentský slovníček i všechny dotčené materiály. Návrhy zůstávají oddělené; postup údržby je v registru a [AGENTS.md](AGENTS.md#terminologie-a-značení).

## Kontroly a GitHub

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
```

Ověření chování chybějících hodnot v instalovaném desktopovém Excelu pro Windows zajišťuje samostatný skript `quarto/_verification/check-excel.ps1`. Sešit druhé kapitoly ověřuje `quarto/_verification/check-chapter-02-excel.ps1` v samostatné skryté instanci Excelu. Kontroluje české vzorce, přesnost výsledků, všech 180 vstupních buněk a přepočet grafů při změně dat; změny z kontrol neukládá. Rozsah a výsledky provedených kontrol jsou v [autorské dokumentaci](quarto/README.md). Automatické kontroly nenahrazují odbornou revizi textu a vizuální prohlídku webu.

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

Všechny kapitoly používají společnou sadu záznamů `references.bib` i pro rozlišení stejně datovaných zdrojů téhož autora. Nastavení `nocite: '@*'` sjednocuje písmena za rokem mezi kapitolami, citačními náhledy a společnou literaturou. Do bibliografie proto ukládejte jen zdroje skutečně použité v knize; webová kontrola ověřuje shodu záznamů.

Změny připravujte v tematické větvi `codex/` a předložte je prostřednictvím pull requestu. Sloučení do `main` provádí autor projektu.

## Obnova sešitů a podkladů kapitol 1–5

Všech pět sešitů se vytváří **přímo v desktopovém Excelu pro Windows**.
Potřebujete nainstalovaný český Excel (ověřeno 16.0), Windows PowerShell
5.1, Node.js a pro simulované vstupy kapitol 1 a 4–5 také R. Příkazy `node`
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
(pro kapitoly 2–5) a kontrolu chyb vzorců ve všech pěti uložených sešitech.
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
  v obrázcích; společný spouštěč jej pro kapitoly 4–5 zavolá automaticky.
- `scripts/kapitola_01-simulace.R`: společné simulace pedagogických příkladů
  pro grafy a sešit; generátor kapitoly 1 jej zavolá automaticky.

Každý sešit vzniká v samostatné skryté instanci Excelu. Skript se nepřipojuje
k otevřeným uživatelským sešitům. Nejprve uloží hotový přepočtený soubor
do `tmp/`, poté jej zkopíruje do `data/kapitola_NN.xlsx`; při chybě sestavení
zůstane předchozí studentský sešit zachován. Cílový sešit před obnovou zavřete.
Výstup se otevírá na listu `Prehled` a při ukládání se odstraňují osobní
údaje z vlastností dokumentu.

Generátory kapitol 1–4 zadávají vzorce prostřednictvím `Formula`
ve standardním anglickém zápisu. Kapitola 5 používá české `FormulaLocal`.
České vzorce z učebnice navíc skutečně spouštějí kapitolové kontroly.
Číselné formáty buněk a os respektují místní oddělovače. Textové hodnoty
zůstávají textem i tehdy, když vypadají jako číslo; chybění zůstává prázdné.
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
redakční porovnání s textem; pokrytí eviduje [docs/DATA.md](docs/DATA.md).
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

Workflow **Ověřit a publikovat učebnici** v `.github/workflows/book.yml` při pull requestu sestaví celou knihu a spustí kontrolu HTML. Po změně `main` navíc publikuje ověřený obsah `_book/` na GitHub Pages. Workflow také vytváří grafy v R a spouští číselné kontroly kapitol 2–5. Desktopový Excel vyžaduje místní Windows a v CI se nespouští. Neúspěšné sestavení nebo kontrola HTML zabrání publikování.

Při prvním zprovoznění:

1. V repozitáři na GitHubu otevřete **Settings → Pages**.
2. V části **Build and deployment → Source** vyberte **GitHub Actions**. Projekt již vlastní workflow obsahuje.
3. Slučte připravený pull request do `main`.
4. Na kartě **Actions** zkontrolujte úspěšné dokončení sestavení i publikování.

Pokud jste Pages zapnuli až po sloučení, spusťte **Actions → Ověřit a publikovat učebnici → Run workflow** pro větev `main`. Ruční běh na jiné větvi web nepublikuje. Není potřeba větev `gh-pages` ani ukládání generovaného HTML do zdrojové větve.

Po nasazení ověřte [veřejnou učebnici](https://reckak.github.io/statistics-for-psychology/), přechody mezi kapitolami a načtení podpůrných souborů. Lokální render ani úspěšná kontrola pull requestu samy nepotvrzují zveřejnění změn.
