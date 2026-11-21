# Provozní návody

[Zpět na přehled projektu](../README.md)

Tento dokument je hlavním místem pro provozní příkazy, závislosti a technické
postupy. Příkazy spouštějte z kořene repozitáře, nikoli ze složky `docs/`;
také cesty uvedené v kódu jsou relativní ke kořeni. Pravidla tvorby a volby
kontrol podle změny určuje [AGENTS.md](../AGENTS.md).

## Obsah

- [Sestavení a náhled webu](#práce-s-projektem)
- [Pracovní PDF kapitoly](#ruční-pdf-vybrané-kapitoly)
- [PDF celé učebnice a jeho vydání](#pdf-cele-ucebnice)
- [Export podkladů AI tutora](#export-ai-tutora)
- [Interaktivní vizualizace](#interaktivni-vizualizace)
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

Pracovní PDF se sestavuje pouze na výslovné vyžádání. Aktuálně je připraven
a ověřen export kapitol 3–10. Z kořene projektu v PowerShellu spusťte
příkaz pro požadovanou kapitolu, například:

```powershell
./scripts/render-chapter-pdf.ps1 -Chapter 4
```

Pro kapitoly 5 až 10 použijte `-Chapter 5` až `-Chapter 10`
a stejné číslo v kontrole `--chapter`.
Pro kapitolu 3 použijte `-Chapter 3` (také výchozí volba).
Výstup skriptu nepřesměrovávejte pomocí `2>&1` ani `2>$null`: Windows
PowerShell 5.1 pak běžná hlášení Quarta na chybovém výstupu považuje za chybu
a export přeruší.
Výsledek je `output/pdf/kapitola_NN.pdf`, kde NN je 03 až 10. Skript používá aktuální
`quarto/kapitola_NN.qmd`, obnoví její grafy v R a sestaví PDF prostřednictvím
Typstu dodávaného s Quartem. Ověřeno s Quartem 1.9.38 (Typst 0.14.2) a 1.10.19
(Typst 0.15.1), R 4.5.1 a Windows PowerShellem 5.1. Pandoc v Quartu 1.10 zapisuje
českou zavírací uvozovku (“) jako chytrou uvozovku Typstu, která by v PDF otevírala novou citaci;
`scripts/pdf/typography.lua` proto české uvozovky převádí na escape sekvence
Typstu a v titulcích bloků na uvozovky Markdownu. Zápornou mezeru `\!` převádí Pandoc na `#h(-1em)`, takže se znaky překrývají; `scripts/pdf/common.ps1` ji zkracuje na −1/6 em jako v TeXu. Náhledy stránek
vykreslené samostatně příkazem `quarto typst compile` potřebují
`--font-path` se složkou `share/formats/typst/fonts` Quarta, jinak místo
ikon bloků ukazují prázdné rámečky; samotné PDF je má správně. Není potřeba instalovat LaTeX.
Quarto a Rscript se hledají v PATH a poté v běžných místních umístěních;
jinde použijte parametry `-QuartoPath` a `-RscriptPath` s cestami k programům.

PDF obsahuje výklad, všechna zadání (15 v kapitole 3, 10 v kapitole 4, 12 v kapitole 5, 16 v kapitole 6, 14 v kapitole 7, 14 v kapitole 8, 15 v kapitole 9, 18 v kapitole 10), samostatný oddíl řešení s obousměrnými
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
všech poznámek v PDF (9 pt jako popisky obrázků) a přítomnost světle šedých tahů. Poznámky hledá podle
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

<a id="ruční-pdf-kapitol-16"></a>
<a id="pdf-cele-ucebnice"></a>

## PDF celé učebnice

Souhrnné PDF celé knihy se také sestavuje pouze na výslovné vyžádání
a studentům se zpřístupňuje vydáním na GitHubu
([R80](rozhodnuti/postupy-a-dokumentace.md#r80-pdf-cele-ucebnice)).
Z kořene projektu v PowerShellu spusťte:

```powershell
./scripts/render-book-pdf.ps1
```

Platí stejné závislosti, parametry `-QuartoPath` a `-RscriptPath` a zákaz
přesměrování výstupu jako u PDF jednotlivé kapitoly. Výsledek je
`output/pdf/zaklady-statistiky-pro-psychology.pdf` (při ověření 430 stran).
Obsahuje titulní stranu s datem sestavení, úvod, obsah, všechny kapitoly
uvedené v `book.chapters` v `_quarto.yml` (nyní 1–10; nová kapitola se
přidá sama), literaturu, slovníček, přehled značení a přehled funkcí Excelu.
Řešení cvičení jsou vždy v oddílu „Řešení cvičení“ na konci své kapitoly,
s obousměrnými odkazy. Obrázky a tabulky se číslují podle kapitol, odkazy
mezi kapitolami vedou uvnitř PDF.

Pokud by v PDF některá kapitola chyběla, přehledy vynechají řádky
a úvodní odstavce vysvětlené jen v ní a odkazy na ni vedou na veřejný web;
s celou knihou se nevynechá nic. Odkazy na interaktivní vizualizace a sešity
XLSX vedou na veřejný web. Několik vět popisujících ovládání webu (rozbalení
řešení, vyhledávání v přehledech) skript pro PDF přeformuluje a odstavec
úvodu s odkazem na stažení PDF vypustí; nenalezení očekávané věty export
zastaví. Při změně tohoto odstavce v `index.qmd` proto upravte i jeho kopii
v `render-book-pdf.ps1`. Identifikátor, který se na webu opakuje v různých
kapitolách (nyní `fig-sirka-intervalu` v kapitolách 2 a 7 a `sec-nezavislost`
v kapitolách 5 a 9), dostane v pozdější kapitole jen v PDF příponu `-kNN`;
skript upraví i odkazy na ni a přejmenování vypíše. Opakování mimo kapitoly
export zastaví. Šířky sloupců širokých tabulek jen pro PDF sdílí
s PDF kapitol tabulka `$PdfColumnWidths` v `scripts/pdf/common.ps1`.

Nastavení je v `scripts/pdf/book.yml`, `book.lua` (rozdělení na kapitoly,
přesun řešení, převod HTML přehledů na tabulky, odkazy) a `book-page.typ`
(zalomení a záhlaví stran). Společné jsou `layout.typ`, `typography.lua`
a `common.ps1`; PDF jednotlivé kapitoly navíc používá `chapter.lua`
a `chapter-page.typ`. Pomocné sestavení vzniká v `tmp/pdf-book/`, jehož
obsah se při každém spuštění nahradí; cílové PDF se nahradí až po úspěchu.

Po sestavení zkontrolujte převod:

```powershell
node scripts/check-book-pdf.cjs
```

Kontrola ověří počet a umístění řešení v každé kapitole (počty čte ze
zdrojových kapitol), zpětné odkazy, zachování rovnic, kódu, obrázků
a citací, existenci cílů vnitřních odkazů a omezení přehledů na kapitoly
obsažené v PDF. Skutečné PDF prověří také `py scripts/check-rendered-pdf.py`,
pokud soubor existuje. Prohlédnutí výsledného PDF nenahrazuje.

<a id="vydani-pdf-na-githubu"></a>

### Vydání PDF na GitHubu

Úvod knihy odkazuje na stálou adresu
`https://github.com/reckak/statistics-for-psychology/releases/download/ucebnice-pdf/zaklady-statistiky-pro-psychology.pdf`.
Vydání `ucebnice-pdf` nese jediný soubor; nová verze PDF jej nahradí,
štítek ani adresa se nemění. Nahrání je veřejný krok, proveďte jej jen na
výslovný pokyn autora:

1. Commitněte a odešlete na GitHub všechny změny, ze kterých PDF vzniká,
   sestavte PDF z tohoto stavu a projděte kontroly výše včetně prohlédnutí.
2. První zveřejnění vydání (jen jednou):

   ```powershell
   gh release create ucebnice-pdf output/pdf/zaklady-statistiky-pro-psychology.pdf --title "Učebnice v PDF" --notes-file <poznámky> --latest=false --target main
   ```

3. Každá další verze:

   ```powershell
   gh release upload ucebnice-pdf output/pdf/zaklady-statistiky-pro-psychology.pdf --clobber
   gh release edit ucebnice-pdf --notes-file <poznámky> --latest=false
   ```

Poznámky k vydání uvedou datum sestavení, krátký commit zdroje a obsah
(kapitoly 1–N, literatura, přehledy). `--latest=false` je nutné: odkazy
tutora `releases/latest/download/…` musí dál vést na vydání `tutor-v…`.
Po nahrání ověřte, že odkaz z úvodu stáhne nové PDF a že
`gh release view --json tagName` (bez štítku, tj. nejnovější vydání)
stále vrací štítek tutora. Vydání PDF založte dřív, než se odkaz z úvodu
dostane na veřejný web, jinak by vedl na chybu 404.

<a id="export-ai-tutora"></a>

## Export kapitol a přehledů pro AI tutora

Pravidla tvorby, vydání a ověřování určuje [AITUTORS.md](AITUTORS.md); zde jsou
příkazy, závislosti a popis výstupů. Zdroj pluginu je v
`plugins/statistika-pro-psychology-ai-tutor/`: obsahuje instrukce, metadata
a logo, nikoli ručně udržované kopie kapitol. Úplné balíčky sestavíte z kořene
projektu:

```powershell
node scripts/export-tutor.cjs
```

### Co export přibaluje

- **Všechny výkladové kapitoly knihy** podle `_quarto.yml` (nyní 1–10) včetně
  nepovinných částí, zadání a řešení, úvod, citovanou literaturu a celé tři
  přehledy. Další kapitola se přibalí sama; potřebuje kapitolovou kartu,
  skript `scripts/kapitola_NN.R` a údaj o počtu řešení v `check-tutor.cjs`.
- **Výukový plán každé kapitoly** (`scripts/tutor/plans.cjs`): hloubku výkladu,
  návaznosti a procvičení přebírá z kapitolové karty, cíle a strukturu z textu,
  rejstřík pojmů z přehledů. Uvádí **rozsahy řádků** oddílů a jejich úvodů,
  zvlášť zadání a řešení každého cvičení, nepovinných bloků a hesel přehledů,
  u oddílu jeho obrázky (s rozsahem řádků v rejstříku a údaji „s daty od
  řádku N“ nebo „schéma bez dat“ a „v nepovinné části“) a název a úplnou adresu interaktivní stránky, na
  kterou oddíl odkazuje. Plány se ručně neupravují.
- **Obrázky podle platformy.** Pracovní složka pluginu obsahuje původní
  SVG obrázky kapitol beze změny a slouží jako základ variant; archiv pro
  ChatGPT z ní vzniká bez složky obrázků, s textovými kapitolami a rejstříky
  shodnými s variantou pro Gemini a se zněním `SKILL.md` bez souborů
  (`textSkill` v `scripts/tutor/common.cjs`). Pro Claude export převede tatáž SVG na PNG
  (`scripts/tutor/svg-to-png.cjs`, Chromium z Playwrightu, 1,5násobek velikosti
  SVG) a přepíše přípony v kapitolách a rejstřících; Gemini soubory obrázků
  nemá. Web knihy zůstává u SVG. Text v SVG z R je uložen jako křivky.
- **Rejstřík obrázků každé kapitoly** `references/obrazky/kapitola_NN.md`:
  číslo, popisek, textový popis (`fig-alt` kapitoly), místo v kapitole, soubor
  obrázku a dvě webové adresy jako prostý text (stránka s kotvou a samotný obrázek).
  Ve variantě pro Gemini je místo adresy samotného obrázku řádek „Zobrazení“
  a kapitola místo odkazu na web odkazuje na záznam v rejstříku; počet řádků
  rejstříku se neliší, takže rozsahy v plánech platí pro všechny varianty.
- **Data pro překreslení** u kapitol uvedených ve `figureDataChapters`
  (`scripts/tutor/common.cjs`, od 0.4.1 všechny kapitoly): viz [níže](#data-ke-grafum-tutora).
- **Malý registr `KAPITOLY.json`** (schéma 3) s verzí, revizí a seznamem
  kapitol. Katalogem pro nabídku kapitol je `INDEX.md`. Nadpisy, pojmy, rozsahy
  a otisky pro kontrolu jsou v `kontrola.json` vedle rozbalených balíčků, mimo
  archivy.

Zdrojový `SKILL.md` obsahuje značku `tutor:chapter-menu`, kterou export nahradí
nabídkou kapitol; instalujte hotový archiv, nikoli zdrojovou složku. Odkazy na
přibalené materiály jsou místní, na sešity a interaktivní stránky vedou na web.

### Závislosti a průběh

Potřebujete Node.js 18 nebo novější s balíčkem Playwright a jeho Chromiem
(tytéž jako pro kontroly webu), Quarto s Pandocem 3.x, R se závislostmi
generátorů obrázků a Windows PowerShell s .NET kompresí. Ověřené místní verze:
Node.js 24.21.0, Quarto 1.9.38 / Pandoc 3.8.3 a R 4.5.1. Jiné cesty k programům
předáte parametry `--quarto` a `--rscript`. Žádné balíčky se během exportu
neinstalují. Export znovu vytvoří obrázky všech přibalených kapitol a data ke
grafům; přepínač `--skip-figures` použijte jen při opakovaném sestavení se
stejnými, již vytvořenými obrázky a daty.

Převod pracuje s dokumentovou strukturou Pandocu, zachovává vzorce v LaTeXu,
ID oddílů a údaje tabulek. HTML řádky přehledů převádí na samostatná hesla
s pojmenovanými poli. Citace vznikají jedním společným průchodem citeproc
s APA stylem; přibalený seznam literatury ponechá jen citované položky.

Sestavení vzniká v nové složce `tmp/tutor-export-*`. Po úspěšném exportu skript
smaže starší složky a ponechá tu, na kterou odkazuje `ai-tutor/overeni.json`.
Před nahrazením archivů proběhne `scripts/check-tutor.cjs` a nezávislé načtení
všech souborů ZIPu pomocí .NET. Samostatné opakování kontroly posledního exportu:

```powershell
node scripts/check-tutor.cjs
```

Kontrola mimo jiné ověřuje věrnost převodu každého odstavce, vzorce a tabulky,
začátek i konec každého rozsahu řádků, oddělení zadání od řešení, shodu SVG
v pluginu se zdrojem, jedno platné PNG ke každému obrázku ve variantě pro
Claude, shodu rejstříků a bloků dat s exportovanými daty, strukturu dat podle
značek a jejich rozsah (nejvýše 800 řádků na obrázek, 300 kB na rejstřík), přítomnost každé interaktivní stránky knihy ve
`VIZUALIZACE.md` a rozdíly variant proti společnému zdroji. Dne 2026-11-20 se
při jednom z běhů v exportované kapitole 8 tiše ztratila část odstavce; kontrola
věrnosti běh zastavila a chyba se v dalších bězích neopakovala. Dne 2026-11-21
se totéž stalo znovu, opět v kapitole 8 (ztracený vzorec); opakovaný export
prošel. Příčina známa
není: při hlášení „paragraph/cell lost or changed“ nejprve spusťte export znovu.

### Výstupy

- `ai-tutor/chatgpt/statistika-tutor-chatGPT-<verze>.zip` – plugin pro ChatGPT;
- `ai-tutor/claude/statistika-tutor-claude-<verze>.zip` – týž skill pro Claude,
  v kořeni jediná složka `statistika-tutor/`;
- `ai-tutor/gemini/statistika-tutor-gemini-<verze>.zip` – skill pro Gemini:
  `SKILL.md` a `references/` přímo v kořeni archivu, jen soubory `.md` a `.txt`,
  bez souborů obrázků;
- `ai-tutor/overeni.json` – verze zdroje, otisky vstupů a všech členů tří
  archivů, počty obsahu a cesty k rozbaleným podobám.

Složka `ai-tutor/` je ignorovaná Gitem. Archiv pro Claude se od pluginu liší jen
hlavičkou `SKILL.md` (YAML místo JSON) a chybějícími manifesty a logem. Varianta
pro Gemini vzniká z varianty pro Claude: odstraní `references/assets/`, v kapitolách
nahradí řádek obrázku odkazem na obrázek ve webové učebnici, v rejstřících vynechá
odkaz na soubor, přejmenuje `KAPITOLY.json` na `KAPITOLY.txt` a `LICENSE` na
`LICENSE.txt` (dialog nahrání uvádí jen typy CSV, PY, TXT a MD) a v `SKILL.md`
nahradí seznam možností zobrazení obrázku zněním bez přibalených souborů
(`geminiNote` v `scripts/tutor/common.cjs`). Kontrola hlídá nejvýše 100
souborů jako projektovou pojistku; doložený limit počtu souborů neznáme.

Nahrání: Claude – Customize → Skills → + → Upload a skill (vyžaduje zapnuté
spouštění kódu); Gemini – Přizpůsobit → Dovednosti → Vytvořit → Nahrát;
ChatGPT – u existujícího pluginu **Další akce → Nahrát novou verzi**, nikoli
přidání dalšího pluginu. Po nahrání ověřte verzi a čtení materiálů v novém chatu
bez příloh podle [testovací sady](../scripts/tutor/smoke-prompts.md). Gemini
může při nahrání ohlásit chybu, i když se dovednost uložila: ověřte stav
v seznamu dovedností. Kontrola archivu nepotvrzuje, že klient soubory načte.

<a id="data-ke-grafum-tutora"></a>

### Data ke grafům pro tutora

Aby tutor mohl obrázek učebnice nakreslit znovu přímo v odpovědi, zapisuje
skript kapitoly ke každému obrázku popis a vykreslené hodnoty. Hlavním místem
těchto dat je skript kapitoly; rejstřík v balíčku je odvozený výstup.

- Pomocník `scripts/tutor/figure-data.R` (jen base R): `tf_figure()` zapíše
  `tmp/tutor-figures/<kapitola>/<obrázek>.json` s druhem obrázku (`data`,
  `simulace`, `krivka`, `sloupce`, `schema`), panely (`tf_panel()`: titulek, typ
  grafu, osy, vodicí čáry `tf_guide()` a vybarvená pásma `tf_band()`) a řadami
  (`tf_series()`: hodnoty tak, jak jsou vykresleny; `tf_bins()` pro histogram
  v četnostech, hustotě nebo podílech; `tf_curve()` pro křivku danou funkcí).
  Značky řad: `body`, `sloupce` (i skupinové a skládané), `histogram`, `cara`,
  `plocha`, `interval`, `usecky`, `krabice` a `tabulka`; místo číselné polohy
  lze uvést textový sloupec `kategorie`. Schéma bez dat zapíše `tf_schema()`.
  Význam značek pro tutora popisuje `references/VIZUALIZACE.md` v balíčku;
  při změně slovníku upravte obojí a kontrolu (`markColumns` v `common.cjs`).
- Rozsah: křivky zhruba 41–81 bodů, simulace jako intervaly histogramu, husté
  čáry a velká mračna bodů proředit a uvést to v poznámce.
- Volání patří hned za kreslicí blok obrázku a používá tytéž objekty. Hodnoty
  vznikající až při kreslení (jitter, losování uvnitř bloku) nejprve uložte do
  pojmenovaného objektu, aby data i obrázek vycházely z téhož.
- Po úpravě skriptu ověřte, že se obrázky nezměnily, a spusťte

  ```powershell
  node scripts/tutor/check-figure-data.cjs kapitola_10
  node scripts/tutor/render-figure-data.cjs kapitola_10
  ```

  První skript ověří, že každý obrázek kapitoly má záznam a že záznamy
  odpovídají slovníku značek a limitu řádků. Druhý vykreslí každý záznam obecným kreslítkem vedle originálu do
  `tmp/tutor-figures-check/`. Dokládá, že data k překreslení stačí; nedokládá,
  jak věrně kreslí tutor v klientu.
- Novou kapitolu přidáte doplněním volání do jejího skriptu a jejího ID do
  `figureDataChapters`; kontrola pak vyžaduje záznam u každého jejího obrázku,
  i u statického SVG, které R nekreslí (`tf_schema()`).

Generované kapitoly a archivy se necommitují. Při změně zdrojů proveďte nový
export; nahraný tutor je verzovaný snímek a s webem se nesynchronizuje. Běžné
sestavení webu export ani nahrání nespouští. Při vydání zvyšte verzi v obou
manifestech zdroje pluginu.

<a id="vydani-ai-tutora-na-githubu"></a>

### Vydání na GitHubu

Studenti stahují tutora z vydání `tutor-v<verze>` na GitHubu, na které vedou
odkazy `releases/latest/download/…` ze stránky
[AI tutor: stažení a instalace](../quarto/ai_tutor.qmd). Pravidla stanoví
[AITUTORS.md](AITUTORS.md#verze-a-vydání). Postup:

1. Zvyšte verzi v obou manifestech, commitněte všechny vstupy exportu
   a odešlete je na GitHub.
2. Spusťte `node scripts/export-tutor.cjs` z tohoto stavu; v `ai-tutor/overeni.json`
   musí být `"source_dirty": false`.
3. Suchý běh vypíše, co se nahraje, a připraví soubory do `tmp/tutor-release-<verze>/`:

   ```powershell
   node scripts/release-tutor.cjs
   ```

   Skript odmítne export z necommitovaných zdrojů, revizi, která není na
   GitHubu, existující štítek, neshodu verze s manifestem a archivy, jejichž
   SHA-256 se liší od `overeni.json`; pak spustí `check-tutor.cjs`.
   Archivy zkopíruje pod stálé názvy bez verze a vytvoří české poznámky
   k vydání.
4. Koncept vydání (potřebuje přihlášené `gh`):

   ```powershell
   node scripts/release-tutor.cjs --draft
   ```

5. Autor koncept na GitHubu zkontroluje a zveřejní. Po zveřejnění ověřte,
   že tři odkazy `releases/latest/download/` stahují soubory se shodným SHA-256.
6. Teprve potom nahrajte novou verzi do cloudového pluginu ChatGPT podle
   odstavce výše. Stránka učebnice se při nové verzi nemění, pokud se
   nezměnil postup instalace nebo rozsah tutora.

Přepínač `--report <soubor>` slouží jen k vyzkoušení pojistek nad upravenou
kopií `overeni.json`; s `--draft` jej nelze použít.

Registr `KAPITOLY.json` má od 0.3.0 `schema_version: 2`: `chapters` obsahuje
všechny kapitoly knihy, nyní deset (`number`, `availability`, `web_url`, `plan`), přibalené
záznamy mají místní `path` a otisk, nepřibalené mají `path` a `plan` rovné
`null`. Pole `plans` obsahuje šest plánů s otisky a vazbou na zdrojové karty.
Skript čtoucí plné texty musí filtrovat `availability: bundled`.

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
používá `check-html.cjs`. U pilotu výběrového rozdělení průměru kontrola
ověřuje:

- šest grafů (čtyři panely a dva Q–Q grafy) a žádný viditelný kód
  ani tlačítko schránky;
- hustoty pěti populací proti `dnorm`, `dgamma` a posunutému `dlnorm` z R;
- šířku a hodnotu odhadu hustoty proti `bw.nrd0` a ručnímu součtu
  `dnorm` v R a normální kvantil proti `qnorm`;
- ztenčení Q–Q grafu se zachováním krajních bodů;
- odmítnutí neplatných hodnot obou číselných polí (0, 1001 nebo 10 001, 2,5),
  jejich meze a šipky;
- losování 10 000 výběrů po 1000 po dávkách se zablokovaným ovládáním
  a průběhem (stav `busy` v `vizCheck`);
- přepínání populací, strop 100 000 opakování se zprávou a jeho zrušení
  tlačítkem „Začít znovu“;
- normální křivku v obou histogramech průměrů po jednom zaškrtnutí,
  řádek s podíly standardizovaných průměrů za ±2, ovládání klávesnicí,
  šířku 375 px bez přetékání a odkaz z kapitoly 6.

U vizualizace ploch pod normální křivkou kontrola ověřuje:

- čtyři grafy (hustota a distribuční funkce v obou částech) a žádný
  viditelný kód ani tlačítko schránky;
- `pnorm` a `qnorm` stránky proti hodnotám z R včetně vzdálených chvostů;
- všech osm úloh v modelu N(50, 10) proti `pnorm`/`qnorm` z R a přesné
  znění vzorců `NORM.DIST`/`NORM.INV`, které stránka nabízí;
- odmítnutí neplatných vstupů (σ = 0, −1, text; podíl 0, 1 a 1,5; dolní
  mez nad horní) se zprávou a ponecháním poslední platné hodnoty;
- desetinnou čárku i tečku, typografické minus, volbu úlohy šipkami,
  poznámku u hranice mimo zobrazený rozsah, šířku 375 px bez přetékání
  a odkaz z kapitoly 4.

U vizualizace binomického rozdělení (pravděpodobnost počtu úspěchů)
kontrola ověřuje:

- dva grafy (pravděpodobnosti a kumulativní pravděpodobnost) a žádný
  viditelný kód ani tlačítko schránky;
- `dbinom` a `pbinom` stránky proti hodnotám z R pro *n* od 5 do 1000
  včetně π blízké 1 a velmi malých pravděpodobností;
- všech osm kombinací zaškrtávacích polí pro *k* = 5 (pravděpodobnost,
  doplněk do 1 a přesné znění vzorce `BINOM.DIST`), „alespoň“ a „více než“
  pro *k* = 10 a nemožné jevy „méně než 0“ a „více než *n*“;
- obě normální aproximace (hranice uprostřed a na okraji sloupců) proti
  `pnorm` z R pro příklad s 200 pokusy, pro „právě 5“, „méně než 5“
  a rozpětí 8 až 12 včetně znění vzorců `NORM.DIST` a `BINOM.DIST.RANGE`;
- zapnutí a vypnutí aproximace v grafu, nedostupnost při π = 0, snížení
  hranic při menším *n* se zprávou a chybu pořadí mezí rozpětí;
- odmítnutí neplatných vstupů (*n* 0, 1001, 2,5; π 1,2, −0,1 a text;
  mez nad *n*) se zprávou a ponecháním poslední platné hodnoty, šipky
  pole *n*, výřez osy pro *n* = 1000 a π = 0,01 s poznámkou, volbu typu
  otázky šipkami, šířku 375 px bez přetékání a odkaz z kapitoly 5.

U vizualizace Bayesovy věty (co znamená pozitivní výsledek testu) kontrola
ověřuje:

- pět grafů (mřížka osob, strom, křivka podle prevalence, řetěz
  pravděpodobností a mřížka druhého vyšetření) a žádný viditelný kód,
  tlačítko schránky ani chybu OJS;
- úplnou pravděpodobnost pozitivního výsledku, obě prediktivní hodnoty
  a pravděpodobnost poruchy po negativním výsledku pro sedm nastavení
  (oba příklady kapitoly 5, vliv specificity a senzitivity, necelé počty,
  výsledek, který nenastane) a šest dvoukrokových aktualizací proti R;
- přirozené četnosti se zaokrouhlením na celé osoby, výchozí výsledky,
  popis mřížky a dosazení do Bayesovy věty, přesné znění tří vzorců Excelu
  a dvou vzorců druhého vyšetření s odkazy na list `Bayes`;
- uspořádání mřížky včetně volby šipkami, menší mřížku jen pozitivních
  výsledků, zvýraznění počtů v tabulce, tlačítka obou příkladů, výřez grafu
  a poznámku u prevalence mimo něj, přepínač stejných vlastností druhého
  testu, upozornění „přibližně“ a text „nelze určit“;
- odmítnutí neplatných vstupů (1,2; −0,1; text; 2; prázdné pole) se zprávou
  a ponecháním poslední platné hodnoty, desetinnou čárku i tečku, šířku
  375 px bez přetékání stránky i tabulky a odkaz z kapitoly 5.

Živá kontingenční tabulka uvnitř vizualizace (prvek `.viz` s `aria-label`)
se mění se vstupy, a proto nemá číslo „Tabulka X“ ani titulek Quarta;
obecná kontrola tabulek u ní ověřuje jen linky záhlaví.

U vizualizace statistické síly kontrola ověřuje:

- tři grafy (situace A, situace B, křivka síly), vzor šrafování α v obou
  hlavních grafech a žádný viditelný kód ani tlačítko schránky;
- sílu pro 17 nastavení (scénáře předlohy ke kapitole 6, hodnoty z textu
  kapitoly 6 a okrajové případy: *n* = 1, α = 0,5, záporný rozdíl, opačný
  směr jednostranného testu, rozdíl 0) proti `pnorm`/`qnorm` z R;
- výchozí stav obou situací, kritickou hodnotu a směrodatnou chybu, přesné
  znění vzorců Excelu pro tři směry a shodu výsledku vzorce se zaokrouhlenými
  mezivýsledky s přesnou silou;
- společnou σ pro obě situace, volbu směru šipkami, text pro rozdíl 0
  a zápis „< 0,001“;
- odmítnutí neplatných vstupů (*n* 0, 1001, 2,5; σ 0 a text; α 0 a 0,6;
  rozdíl 1001) se zprávou a ponecháním poslední platné hodnoty, mez
  a šipky pole *n*, šířku 375 px bez přetékání a odkaz z kapitoly 6.

U vizualizace posunu a změny jednotek kontrola ověřuje:

- jeden graf se dvěma tečkovými grafy a žádný viditelný kód, tlačítko
  schránky ani chybu OJS;
- shodu dob spánku a vybavených slov na stránce se sdílenými daty
  `data/kapitola_02.csv` (bez tří chybějících dob spánku) a pět časů;
- průměr, medián, kvartily, rozpětí, *s*, *s*², šikmost a exces všech tří
  souborů proti `mean`, `median`, `quantile(type = 7)`, `sd`, `var`
  a vzorcům SKEW/KURT v R;
- výchozí převod na sekundy, všech šest předvoleb a zadání *a* = 3,
  *b* = −2,5 (desetinná čárka, typografické minus): ukazatele převedených
  dat proti R, shodu předpovědi pravidlem s nimi, výměnu kvartilů při
  záporném *b*, „nelze určit“ při *b* = 0 a přesné znění vzorců Excelu;
- druhou mocninu pěti časů a odmocninu spánku proti R, převod původního
  průměru (36 proti 40,4) se slovy „liší se“ a „shoduje se“;
- odmítnutí neplatných vstupů (text, 2 000 000, „1,2,3“) se zprávou
  a ponecháním poslední platné hodnoty, volbu osy šipkami, šířku 375 px
  bez přetékání stránky a odkaz z kapitoly 3.

U vizualizace *t*-rozdělení a normovaného normálního kontrola ověřuje:

- čtyři grafy (hustoty, normální Q–Q graf, absolutní a relativní chyba)
  a žádný viditelný kód, tlačítko schránky ani chybu OJS;
- hustotu, distribuční funkci a kvantil *t*-rozdělení stránky pro 1, 4, 30
  a 100 stupňů volnosti včetně vzdálených chvostů proti `dt`, `pt` a `qt`
  z R a `pnorm` proti R;
- výchozí stav (4 stupně volnosti, hranice −1,645), podíly za hranicí,
  relativní chybu, přesné znění vzorců `T.DIST`/`NORM.S.DIST`, počet bodů
  Q–Q grafu mimo osu a kvantily živé tabulky proti `qt` z R;
- posuvník (meze, krok, šipky, Home a End), vložení a zvýraznění řádku
  pro 7 stupňů volnosti v pevné tabulce, pravý chvost u kladné hranice,
  hranici 0, desetinnou čárku a typografické minus;
- odmítnutí neplatné hranice (text, 11, „1,2,3“) se zprávou a ponecháním
  poslední platné hodnoty, přepnutí na výšku hustoty s výškami proti `dt`
  a `dnorm` a vzorcem `T.DIST(…;NEPRAVDA)`, šířku 375 px bez přetékání
  a odkaz z kapitoly 7.

U vizualizace intervalu spolehlivosti a *p*-hodnoty kontrola ověřuje:

- dva grafy (pohled intervalu a pohled testu) a žádný viditelný kód,
  tlačítko schránky ani chybu OJS;
- *p*-hodnotu, kvantil, mezní chybu a meze intervalu pro sedm nastavení
  (všechny tři směry testu, příklady kapitoly 7, záporné μ₀, α = 0,5)
  proti R a shodu čtyř pohledů na rozhodnutí; na přesné mezi intervalu
  *p*-hodnotu rovnou α a zamítnutí všemi čtyřmi pohledy;
- výchozí stav (pozornost oboustranně), rozsah osy a posuvníků, krok
  posuvníku šipkou a souběh s polem, přesné znění vzorců `T.DIST.2T`,
  `T.INV.2T` a `T.DIST`;
- předvolby (jednostranný test „menší“ s jednostranným intervalem
  a 90% oboustranným intervalem, PDI), přepnutí na alternativu „větší“,
  rozšíření rozsahu po zápisu hodnoty mimo něj;
- odmítnutí neplatných vstupů (*s* = 0, *n* = 1 a 2,5, α = 0,6, text,
  „1,2,3“) se zprávou a ponecháním poslední platné hodnoty, šířku 375 px
  bez přetékání, pořadí v menu a odkaz z kapitoly 7.

U vizualizace pokrytí intervalu spolehlivosti kontrola ověřuje:

- čtyři grafy při známé σ (stejné šířky se nekreslí) a pět s výběrovou *s*,
  žádný viditelný kód, tlačítko schránky ani chybu OJS;
- kvantily *z* a *t*, meze všech devíti kombinací postupu a typu intervalu
  a přesné pokrytí chybného postupu (*s* s kvantilem *z*) pro *n* 5–100,
  hladiny 90, 95 a 99 % proti R; otevřené a uzavřené meze;
- pět populací (průměr 0, směrodatná odchylka 1, šikmost a přesný podíl
  hodnot do průměru proti `pnorm` a `pgamma` z R);
- výchozí stav s pevným seedem (94 ze 100 intervalů), nezávislé přepočítání
  zachycených intervalů z uložených *m* a *s*, tytéž výběry po změně
  postupu, typu i hladiny, vzorce Excelu a výběr intervalu klávesami;
- rozsah osy grafu intervalů, který u normální i extrémně zešikmené
  populace a všech tří typů intervalu obsahuje všechny konečné meze;
- normální populaci se 100 000 výběry ve čtyřech kombinacích (pokrytí do
  čtyř směrodatných chyb od přesné hodnoty), strop 100 000 se zprávou
  a „Začít znovu“;
- u výrazně a extrémně zešikmené populace pokrytí všech devíti kombinací
  proti simulaci v R (`scripts/viz-pokryti-intervalu.R`, odchylka do 0,008)
  a soulad slovního směru očekávání s výsledky R pro všechny zešikmené
  populace a *n* = 5, 10 a 25;
- odmítnutí neplatných vstupů (σ = 0 a −2, *n* = 1 a 1001, hladina 50
  a 100, text, počet výběrů 0 a 10 001), losování po dávkách se
  zablokovaným ovládáním, předvolbu chybného postupu, rozšíření grafů na
  celé obrazovce, šířku 375 px bez přetékání, pořadí v menu a odkaz
  z kapitoly 7.

U vizualizace Cohenova d kontrola ověřuje:

- dva grafy (rozdělení skupin a rozdíl hodnot náhodné dvojice) a žádný
  viditelný kód, tlačítko schránky ani chybu OJS;
- tři ukazatele pro devět hodnot *d* od 0 do 2 proti `pnorm` z R
  (`scripts/viz-cohenovo-d.R`, kde je společná plocha ověřena i numerickou
  integrací a pravděpodobnost u dvojice simulací);
- výchozí stav (*d* = 0,5, σ = 10), rozsah a krok posuvníku, vzorce Excelu,
  zaokrouhlené hodnoty ve výpisu a štítky Cohenových hodnot v tabulce;
- posuvník klávesnicí (šipky po 0,01 bez zbytků desetinné aritmetiky,
  Home a End s krajními hodnotami), vložení a zvýraznění *d* mimo tabulku;
- pole σ s desetinnou čárkou a odmítnutí hodnot 0, −1, textu a 2 000 000
  se zprávou a ponecháním poslední platné hodnoty, přepínač vybarvení;
- rozšíření grafů na celé obrazovce, šířku 375 px bez přetékání, pořadí
  v menu a odkaz z oddílu kapitoly 8 `sec-d-nezavisle`.

U vizualizace přínosu párování kontrola ověřuje:

- čtyři grafy (spojnice, rozdíly, oba intervaly, směrodatná chyba v modelu)
  a po losování histogram šířek intervalů; žádný viditelný kód, tlačítko
  schránky ani chybu OJS;
- kvantily `qt` a obě analýzy (párový a klasický *t*-test: směrodatná
  chyba, *t*, stupně volnosti, *p*, meze, *s*₁, *s*₂, *s_D*, *r*) pro data
  varianty A, kontrastní příklad 2, 4, 6 / 6, 12, 18 a testovací soubor
  osmi dvojic proti `t.test` z R (`scripts/viz-prinos-parovani.R`);
- směrodatné chyby v modelu pro šest nastavení obou způsobů zadání;
- výchozí stav s daty varianty A, tabulku jako tab. 8.4, znění vzorců
  Excelu včetně `T.TEST` typ 1 a 2, skrytí korelace v prvním způsobu zadání;
- posuvník klávesnicí s přepnutím na výběr z modelu, opakované použití
  týchž náhodných čísel (změna μ_D posune rozdíly přesně), nový výběr,
  pole *n* a μ_D s odmítnutím neplatných hodnot (2, 201, 2,5, text; −60);
- losování po dávkách se zablokovaným ovládáním a podíly zamítnutí
  a pokrytí z 10 000 výběrů pro tři nastavení proti R (párová analýza
  přesně z necentrálního *t*-rozdělení, chybná ze simulace R) s tolerancí
  asi čtyř směrodatných chyb simulace; vynulování po změně modelu a strop
  100 000 výběrů;
- návrat k datům varianty A, rozšíření grafů na celé obrazovce, šířku
  375 px bez přetékání a odkaz z oddílu kapitoly 8 `sec-proc-rozdily`.

U vizualizace dvou intervalů a intervalu rozdílu kontrola ověřuje:

- pět grafů u nezávislých skupin (intervaly průměrů, interval rozdílu,
  pásma podle rozdílu, mezní chyby, trojúhelník) a čtyři u párových dat;
  žádný viditelný kód, tlačítko schránky ani chybu OJS;
- meze obou intervalů, *t*, *p*, interval rozdílu a hranice pásma pro
  příklad kapitoly na hladinách 90, 95 a 99 %, Welchův a klasický postup
  pro nestejné skupiny, klasický postup s variabilnější větší skupinou
  (intervaly se nepřekrývají, rozdíl nevýznamný) a párová data varianty A
  včetně největšího $s_D$ proti R (`scripts/viz-dva-intervaly.R`);
- výchozí stav, slovní závěr, souhrny a znění vzorců Excelu (včetně
  kvantilu přes `BETA.INV` a Welchových stupňů volnosti), přepínače
  hladiny a postupu, předvolby včetně právě se dotýkajících intervalů;
- odmítnutí neplatných vstupů (*n* 1, 1001, 2,5; *s* 0, −1, text; průměr
  text) se zprávou a ponecháním poslední platné hodnoty;
- párové uspořádání: skrytá pole, posuvník $s_D$ klávesnicí s mezemi
  $|s_1-s_2|$ a $s_1+s_2$, nezávislost intervalů podmínek na $s_D$
  a přizpůsobení mezí při změně *s*;
- rozšíření grafů na celé obrazovce, šířku 375 px bez přetékání, pořadí
  v menu a odkaz z oddílu kapitoly 8 `sec-dva-intervaly`.

U vizualizace tabulky četností a testu chí-kvadrát kontrola ověřuje:

- dva grafy (řádkové podíly, chí-kvadrát rozdělení); žádný viditelný kód,
  tlačítko schránky ani chybu OJS;
- pravý chvost, hustotu a kritickou hodnotu chí-kvadrát rozdělení se
  čtyřmi stupni volnosti a pro šest tabulek (kapitola, zdvojená,
  „Nezávislost“ a tři tabulky z úkolů) χ², *p*, Cramérovo V, nejmenší
  očekávanou četnost, očekávanou četnost, příspěvek a obě rezidua proti R
  (`scripts/viz-chi-kvadrat.R`);
- výchozí stav, slovní závěr, souhrny, vzorec `CHISQ.DIST.RT`, obsah čtyř
  odvozených tabulek a podbarvení standardizovaných reziduí (barva podle
  znaménka, sytost podle velikosti);
- tlačítka zdvojnásobení (stejné V a řádkové podíly, *p* jako „< 0,001“),
  „Nezávislost“ a „Původní data“; změnu buňky z klávesnice včetně šipek;
- odmítnutí neplatných četností (prázdná, záporná, necelá, nad 100 000)
  a tabulky s prázdným řádkem nebo sloupcem se zprávou a ponecháním
  poslední platné tabulky;
- upozornění při očekávané četnosti pod 5 s odkazem na `sec-male-cetnosti`
  a vypnutí zdvojnásobení nad mezí;
- rozšíření grafů na celé obrazovce, šířku 375 px bez přetékání, pořadí
  v menu a odkaz z pododdílu kapitoly 9 `sec-pearson-upravena`.

U vizualizace rozdílu podílů, poměru rizik a poměru šancí kontrola ověřuje:

- jeden graf tří čar, dvě pole osob a dvě pole retrospektivního výběru;
  žádný viditelný kód, tlačítko schránky ani chybu OJS; odkaz na citovaný
  článek;
- rizika, rozdíl, poměr rizik, šance, poměr šancí, χ², φ a rozdíl
  sloupcových podílů pro pět tabulek (Danielsová, se zaměněnými skupinami,
  aspirin, úloha 10, dvě rizika 40 % a 17 %), hodnoty tří čar a podíly
  v retrospektivním výběru proti R (`scripts/viz-miry-souvislosti.R`);
  prázdnou hodnotu místo dělení nulou;
- výchozí stav, slovní čtení, míry s dosazením, část o φ, tabulku čar,
  popisek pole osob a rozdělení pole v pohledu na šance;
- předvolbu aspirinové studie (téměř shodné poměry, pole osoba po osobě)
  a záměnu referenční skupiny (převrácené poměry, záporné φ a rozdíl);
- odmítnutí neplatných četností a prázdné skupiny, nulovou buňku
  („nelze spočítat“), šipky v poli a přepočet polí na 10 000 osob u tabulky
  nad 25 000 osob;
- zadání dvěma riziky: posuvníky klávesnicí, držení poměru šancí,
  poměru rizik (včetně upozornění, když už není možný) a rozdílu rizik,
  krok 0,1 % u skupin po 1 000 osobách;
- posuvník retrospektivního výběru klávesnicí a srovnávací tabulku;
- rozšíření grafu na celé obrazovce, šířku 375 px bez přetékání i s poli
  aspirinové studie, pořadí v menu a odkaz z pododdílu kapitoly 9
  `sec-phi-v`.

**Sbalená část v postranní nabídce.** Quarto umí sbalit části nabídky jen
všechny najednou (`sidebar: collapse-level`). Samotnou část „Interaktivní
vizualizace“ proto sbaluje skript `assets/sidebar-collapse.js`, připojený
v `assets/after-body.html` bez `defer`, aby proběhl před prvním vykreslením.
Část najde podle názvu; při jejím přejmenování v `_quarto.yml` je třeba
upravit i konstantu `TITLE` ve skriptu. Na stránkách vizualizací zůstává
část rozbalená a bez JavaScriptu je rozbalená všude. `check-html.cjs`
ověřuje sbalený stav na stránce kapitoly, rozbalení klávesou Enter
a rozbalený stav na stránce vizualizace.

Referenční hodnoty z R jsou zapsané přímo v testu. Snímky mobilního
zobrazení se ukládají do `tmp/verification/`. Vzorce Excelu nabízené
stránkou kontrola porovnává jen jako text; jejich výsledky byly při
zavedení ověřeny v českém Excelu (viz [autorská historie](../quarto/README.md)).

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
a zápis jedenácti vzorců listů v češtině. Změny neukládá. Od revize 2026-11-16
`check-chapter-09.R` ověřuje také přesné pokrytí Waldova a Wilsonova intervalu
(nezávislým výpočtem s `prop.test`), tabulku Holmovy korekce proti `p.adjust`,
znaménkový test proti `binom.test`, φ se znaménkem proti korelaci kódů 0/1
a simulovanou *p*-hodnotu proti `chisq.test(simulate.p.value = TRUE)`
a `fisher.test`; simulace mají pevné seedy 20261116 a 20261117. Od 2026-11-17
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

Všechny sešity (nyní kapitoly 1–10) se vytvářejí **přímo v desktopovém Excelu pro Windows**.
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

Workflow **Ověřit a publikovat učebnici** v `.github/workflows/book.yml` při pull requestu sestaví celou knihu a spustí kontrolu HTML. Po změně `main` navíc publikuje ověřený obsah `_book/` na GitHub Pages. Workflow také vytváří grafy v R a spouští číselné kontroly kapitol 2–7. Desktopový Excel vyžaduje místní Windows a v CI se nespouští. Neúspěšné sestavení nebo kontrola HTML zabrání publikování. Sestavovací job běží na `ubuntu-24.04`, nikoli `ubuntu-latest`: od listopadu 2026 je `ubuntu-latest` Ubuntu 26.04, které Playwright 1.55 nepodporuje. Při povýšení systému je nutné současně povýšit Playwright na verzi s jeho podporou. Sestavovací job má časový limit 40 minut a kroky instalující systémové balíčky (`setup-r`, `playwright install --with-deps`) po 10 minutách; běžné sestavení trvá 7–15 minut, instalace R asi minutu. Limit ukončí běh, který visí kvůli nedostupnému balíčkovému serveru Ubuntu; takový běh stačí po obnovení služby spustit znovu (**Re-run failed jobs**).

Při prvním zprovoznění:

1. V repozitáři na GitHubu otevřete **Settings → Pages**.
2. V části **Build and deployment → Source** vyberte **GitHub Actions**. Projekt již vlastní workflow obsahuje.
3. Slučte připravený pull request do `main`.
4. Na kartě **Actions** zkontrolujte úspěšné dokončení sestavení i publikování.

Pokud jste Pages zapnuli až po sloučení, spusťte **Actions → Ověřit a publikovat učebnici → Run workflow** pro větev `main`. Ruční běh na jiné větvi web nepublikuje. Není potřeba větev `gh-pages` ani ukládání generovaného HTML do zdrojové větve.

Po nasazení ověřte [veřejnou učebnici](https://reckak.github.io/statistics-for-psychology/), přechody mezi kapitolami a načtení podpůrných souborů. Lokální render ani úspěšná kontrola pull requestu samy nepotvrzují zveřejnění změn.
