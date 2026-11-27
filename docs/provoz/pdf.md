# Pracovní PDF kapitol a PDF celé učebnice

[Zpět na provozní návody](../PROVOZ.md)

Příkazy spouštějte z kořene repozitáře. Obě PDF se sestavují jen na výslovné
vyžádání; pravidla určuje [AGENTS.md](../../AGENTS.md).

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
([R80](../rozhodnuti/postupy-a-dokumentace.md#r80-pdf-cele-ucebnice)).
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
