# Provozní návody

[Zpět na přehled projektu](../README.md)

Tento dokument je hlavním místem pro provozní příkazy, závislosti a technické
postupy. Příkazy spouštějte z kořene repozitáře, nikoli ze složky `docs/`;
také cesty uvedené v kódu jsou relativní ke kořeni. Pravidla tvorby a volby
kontrol podle změny určuje [AGENTS.md](../AGENTS.md).

## Obsah

- [Sestavení a náhled webu](#práce-s-projektem)
- [Pracovní PDF kapitoly](#ruční-pdf-vybrané-kapitoly)
- [Pracovní PDF kapitol 1–6](#ruční-pdf-kapitol-16)
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

## Ruční PDF kapitol 1–6

Souhrnné pracovní PDF kapitol 1–6 se také sestavuje pouze na výslovné
vyžádání. Z kořene projektu v PowerShellu spusťte:

```powershell
./scripts/render-book-pdf.ps1
```

Platí stejné závislosti, parametry `-QuartoPath` a `-RscriptPath` a zákaz
přesměrování výstupu jako u PDF jednotlivé kapitoly. Výsledek je
`output/pdf/ucebnice_01-06.pdf` (při ověření 277 stran). Obsahuje úvod,
obsah, kapitoly 1–6, literaturu citovanou v těchto kapitolách, slovníček,
přehled značení a přehled funkcí Excelu. Řešení cvičení jsou vždy v oddílu
„Řešení cvičení“ na konci své kapitoly, s obousměrnými odkazy. Obrázky
a tabulky se číslují podle kapitol, odkazy mezi kapitolami vedou uvnitř PDF.

Přehledy obsahují jen řádky, jejichž odkazy na výklad vedou do kapitol 1–6;
řádky vysvětlené pouze v kapitolách 7–8 a úvodní odstavce přehledu Excelu
o těchto kapitolách se vynechají. Odkazy na kapitoly 7–8, na vynechané řádky
a na sešity XLSX vedou na veřejný web. Několik vět popisujících ovládání webu
(rozbalení řešení, vyhledávání v přehledech) skript pro PDF přeformuluje;
nenalezení očekávané věty export zastaví.

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

Kontrola ověří počet a umístění řešení v každé kapitole (9/10/15/10/12/16),
zpětné odkazy, zachování rovnic, kódu, obrázků a citací, existenci cílů
vnitřních odkazů a omezení přehledů na kapitoly 1–6. Skutečné PDF prověří
také `python scripts/check-rendered-pdf.py`, pokud soubor existuje.
Prohlédnutí výsledného PDF nenahrazuje.

<a id="export-ai-tutora"></a>

## Export kapitol a přehledů pro AI tutora

Hlavní vstupní nabídka vede k volbě kapitoly, režimu a rozsahu; přímý dotaz
průvodce obchází. Metodika interaktivních vizualizací a podrobné bodování
jsou reference načítané podle potřeby. Interaktivita závisí na klientu,
nikoli na samotném balíčku instrukcí. Při vydání ji skutečně vyzkoušejte
v cílovém prostředí, včetně náhrady bez podpory interaktivity. Volbu režimu
Chat a evidenci prostředí určuje [pravidlo ověřování tutora](AITUTORS.md#overovani).

Zdroj pluginu je v `plugins/statistika-pro-psychology-ai-tutor/`; tato složka
obsahuje instrukce, metadata a logo, nikoli ručně udržované kopie kapitol.
Úplný instalační balíček sestavíte z kořene projektu:

```powershell
node scripts/export-tutor.cjs
```

Export obsahuje úvod, úplné kapitoly 1–6 včetně nepovinných částí,
zadání a řešení, celé aktuální přehledy (slovníček, značení a vzorce, Excel),
literaturu citovanou v těchto materiálech a obrázky s textovými popisy.
Od revize 0.3.0 přidává šest výukových plánů a katalog všech osmi kapitol
s výslovnou dostupností. Přesné názvy v nabídce hlavního skillu, indexu
a registru vznikají ze stejného katalogu podle `_quarto.yml` a nadpisů kapitol.
Zdrojový skill obsahuje značku `tutor:chapter-menu`, kterou export nahradí;
instalujte hotový archiv, nikoli samotnou zdrojovou složku.

Plány vznikají pomocí `scripts/tutor/plans.cjs`: hloubku výkladu, návaznosti
a procvičení přebírají z existujících kapitolových karet, cíle a strukturu
z kapitol a rejstřík pojmů, značek i funkcí z přehledů. Zachovávají rozdíl
mezi povinným učivem, nepovinnými částmi a pouhými zmínkami. Při obsahové
změně aktualizujte hlavní kapitolovou kartu a text a proveďte nový export;
generované plány se ručně nesynchronizují. Export kontroluje existenci
a návaznost odkazů, redakční kontrola posuzuje skutečnou hloubku učiva.
Přehledy se na rozdíl od souhrnného PDF **neomezují na kapitoly 1–6**;
obsahují i hesla z kapitol 7–8, jejichž úplný výklad v pluginu není.
Odkazy na přibalené materiály jsou místní, na kapitoly 7–8 a sešity vedou
na web knihy. Původ a licence zůstávají přibalené.

Potřebujete Node.js 18 nebo novější, Quarto s Pandocem 3.x, R se závislostmi
generátorů obrázků a Windows PowerShell s .NET kompresí. Ověřené místní verze:
Node.js 24.21.0, Quarto 1.9.38 / Pandoc 3.8.3 a R 4.5.1. Skript má výchozí
cesty k programům používaným také při exportu PDF; jiné cesty lze předat
parametry `--quarto` a `--rscript`. Žádné balíčky se během exportu neinstalují.
Znovu se vytvoří obrázky kapitol 1–6; přepínač `--skip-figures` použijte jen
při opakovaném sestavení se stejnými, již vytvořenými obrázky.

Převod pracuje s dokumentovou strukturou Pandocu, zachovává vzorce v LaTeXu,
ID oddílů a údaje tabulek. HTML řádky přehledů převádí na samostatná hesla
s pojmenovanými poli. Křížové odkazy se vyhodnocují s ohledem na zdrojovou
kapitolu. Citace vznikají jedním společným průchodem citeproc s APA stylem
a celou bibliografií kvůli shodě rozlišujících přípon roků; přibalený seznam
literatury pak ponechá pouze skutečně citované položky.

Sestavení vzniká v nové pomocné složce pod `tmp/`. Před nahrazením cílového
archivu proběhne `scripts/check-tutor.cjs` a nezávislé načtení všech souborů
ZIPu pomocí .NET, včetně skrytého kompatibilního manifestu. Výsledky:

- `ai-tutor/chatgpt/statistika-tutor-chatGPT-<verze>.zip` — plugin pro ChatGPT;
- `ai-tutor/claude/statistika-tutor-claude-<verze>.zip` — týž skill pro Claude;
- `ai-tutor/gemini/statistika-tutor-gemini-<verze>.zip` — skill pro Gemini bez souborů obrázků;
- `ai-tutor/overeni.json` — verze zdroje, otisky vstupů a všech členů tří
  archivů, počty obsahu a cesty k ověřeným rozbaleným podobám.

Složka `ai-tutor/` je ignorovaná Gitem; podsložky platforem uchovávají také
starší archivy a místní záznamy testů. Do 2026-11-04 byly tyto výstupy
v `output/tutor/`; starší záznamy historie uvádějí původní cesty.

Archiv pro Claude má v kořeni jedinou složku `statistika-tutor/` (název musí
odpovídat poli `name`) se stejnými soubory jako skill pluginu. Liší se jen
hlavička SKILL.md, převedená z JSON na prosté YAML (`name`, `description`);
manifesty, logo a zahajovací prompty pluginu vynechává. Kontrola ověřuje
název složky, pravidla pro `name` a `description`, shodu těla SKILL.md
a otisků všech referencí s pluginem a to, že žádný odkaz ze skillu nevede
mimo jeho složku. Nahrání: claude.ai → Customize → Skills → + → Upload a skill;
vyžaduje zapnuté spouštění kódu. Novou verzi skillu je třeba nahrát znovu;
mimo plány Team a Enterprise nahrává archiv každý student sám. Číselný limit
velikosti nápověda Claude neuvádí, ověřte jej skutečným nahráním.

Gemini odmítl skill se 125 soubory („Složka dovednosti obsahuje příliš mnoho
souborů“); přesný limit Google nezveřejňuje, komunitní zdroj uvádí 100.
Archiv pro Gemini proto vzniká z Claude složky bez `references/assets/`
(97 SVG, z nichž model nevyčte ani popisky, protože písmena jsou křivky).
V kapitolách nahradí řádek obrázku odkazem na tentýž obrázek ve webové
učebnici; číslovaný popisek a „Textový popis obrázku“ zůstávají. Navíc
obsahuje generovaný `references/obrazky.md` s číslem, popiskem, textovým
popisem a odkazy ke každému obrázku, odkaz z `INDEX.md`, upravené otisky
v `KAPITOLY.json` (`images: "web_only"`) a jednu větu v SKILL.md o práci
bez přibalených obrázků. Podrobnější popis obrázku patří do `fig-alt`
ve zdrojové kapitole, nikoli do ručně psaného souboru. Kontrola hlídá
nejvýše 100 souborů, žádné SVG, změny kapitol jen na řádcích obrázků,
zachování všech textových popisů, úplnost rejstříku a místní odkazy.
Nahrání do Gemini a jeho omezení zatím nejsou ověřeny.

Samostatné opakování kontroly posledního exportu:

```powershell
node scripts/check-tutor.cjs
```

Generované kapitoly a archivy se necommitují. Při změně zdrojů proveďte nový
export; uložený cloudový plugin je verzovaný snímek a s webem se nesynchronizuje
automaticky. Běžné sestavení webu export pluginu ani jeho nahrání nespouští.

Při vydání zvyšte verzi v obou manifestech zdroje pluginu. U existujícího
vlastního cloudového pluginu použijte **Další akce → Nahrát novou verzi**,
nikoli přidání dalšího pluginu. Zachovejte jeho identitu, vazby a přístup.
Je-li dostupný nástroj Plugin Creatoru `update_plugin`, nejprve načtěte
aktuální zdroje a použijte ověřené ID i `expected_release_id`.
Po uložení ověřte verzi a čtení materiálů v novém chatu bez příloh.
Kontrola archivu sama nepotvrzuje, že konkrétní klient ChatGPT soubory načte.
[Testovací sada](../scripts/tutor/smoke-prompts.md) odděluje načítání podkladů,
chování tutora a skutečné ovládání vizualizací. Test kandidátního archivu
jako přílohy nezaměňujte za test instalovaného vydání; do autorizovaného
publikování může cloudový plugin dál obsahovat předchozí verzi.

Registr `KAPITOLY.json` má od 0.3.0 `schema_version: 2`: `chapters` obsahuje
všech osm kapitol (`number`, `availability`, `web_url`, `plan`), přibalené
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

Workflow **Ověřit a publikovat učebnici** v `.github/workflows/book.yml` při pull requestu sestaví celou knihu a spustí kontrolu HTML. Po změně `main` navíc publikuje ověřený obsah `_book/` na GitHub Pages. Workflow také vytváří grafy v R a spouští číselné kontroly kapitol 2–7. Desktopový Excel vyžaduje místní Windows a v CI se nespouští. Neúspěšné sestavení nebo kontrola HTML zabrání publikování. Sestavovací job běží na `ubuntu-24.04`, nikoli `ubuntu-latest`: od listopadu 2026 je `ubuntu-latest` Ubuntu 26.04, které Playwright 1.55 nepodporuje. Při povýšení systému je nutné současně povýšit Playwright na verzi s jeho podporou.

Při prvním zprovoznění:

1. V repozitáři na GitHubu otevřete **Settings → Pages**.
2. V části **Build and deployment → Source** vyberte **GitHub Actions**. Projekt již vlastní workflow obsahuje.
3. Slučte připravený pull request do `main`.
4. Na kartě **Actions** zkontrolujte úspěšné dokončení sestavení i publikování.

Pokud jste Pages zapnuli až po sloučení, spusťte **Actions → Ověřit a publikovat učebnici → Run workflow** pro větev `main`. Ruční běh na jiné větvi web nepublikuje. Není potřeba větev `gh-pages` ani ukládání generovaného HTML do zdrojové větve.

Po nasazení ověřte [veřejnou učebnici](https://reckak.github.io/statistics-for-psychology/), přechody mezi kapitolami a načtení podpůrných souborů. Lokální render ani úspěšná kontrola pull requestu samy nepotvrzují zveřejnění změn.
