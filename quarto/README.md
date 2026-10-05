# Autorská dokumentace

## Zpřesnění výkladu po společné redakci (2026-09-20)

Na žádost autora zapracovány projednané úpravy přímo do hlavního souboru
`quarto/kapitola_01.qmd`, na větvi `codex/chapter-01-clarifications`
z aktuálního `origin/main` (440298b). Zachována dosavadní místní redakce
i formátování z editoru; nesledovaný soubor Rproj nebyl upraven ani přidán.

- Konkrétně popsáno omezené zastoupení společností v Henrichově přehledu.
  Oddíl 2 znovu ověřen v autorském PDF uvedeném níže; nevydáváme jeho
  historická procenta za současný stav celé psychologie.
- Argument pro zobecnění rozveden na vlastním hypotetickém příkladu
  rušivých zvuků, starších dospělých a porozumění jazyku nahrávky.
  Nejde o výsledek skutečně provedené studie. Zachován odkaz na Simonse.
- Oddělen účel náhodného rozdělení, záměrného rozdílu podmínek a kontroly
  provedení. Sjednoceno také řešení úlohy 4.
- Výroky „Jsem odpočatý“ a „Jsem unavený“ označeny jako tvrzení;
  uveden úplný význam pěti možností odpovědi. Věk vysvětlen jako doba
  od narození, jejíž poměr nelze přenášet na psychickou zralost.
- Intervalová interpretace doplněna příkladem modelu měření únavy.
  Odlišeny původní body od odhadů modelu; závislost na předpokladech
  výslovně zachována. Konkrétní psychometrické modely se nezavádějí.
- Tabulka v `sec-uroven-a-spojitost` nahrazena souvislým výkladem
  možných hodnot, významu vztahů a přesnosti záznamu. Zachováno ID oddílu.
  Doplněny VAS, posuvník a verbální kotvy, změny číselného zápisu a příklad
  zaokrouhlené teploty. Nezavádí se topologie, absolutní škála ani SEM.

Slovníček doplněn o čtyři schválené pojmy (celkem 50): model měření,
vizuální analogová škála, posuvník a verbální kotva. Přehledy značení
a Excelu se nemění; nové symboly, vzorce ani funkce nepřibyly.

Odborná opora nového textu:

- Stevens (1946), s. 677–679: přípustné změny číselného zápisu;
  ověřeno v úplném článku, DOI 10.1126/science.103.2684.677.
- Salzberger (2010), s. 1273–1275: rozdíl mezi součtem bodů a modelovým
  měřením; ověřeno na https://www.rasch.org/rmt/rmt242a.htm.
  Nepřebíráme obecný závěr, že shoda s modelem sama definitivně dokazuje
  kvantitativní povahu konstruktu. U článku není uvedeno DOI.
- Weigl a Forstner (2021), úvodní část před oddílem „The Present Study“:
  podoba VAS a popisy bodů; text ověřen v indexovaném plném znění
  https://pmc.ncbi.nlm.nih.gov/articles/PMC8072950/.
  Metadata ověřena přes Crossref a univerzitní záznam JKU. Rok 2021
  odpovídá zařazení do ročníku 81(3), s. 595–611; online vydání je 2020.
  DOI 10.1177/0013164420952118. Přímé načítání PMC vracelo ochrannou
  stránku a rozhraní Europe PMC chybu 500, dostupný byl indexovaný text.

Ověření: úplný render všech pěti stránek prošel. Kontrola R potvrdila
modelovou matici, chybějící hodnoty, odpověď 8 a elementární výpočty.
Všech osm vzorových řešení zkontrolováno obsahově vůči zadání a výkladu.
Kontrola HTML prošla pro 50 hesel, včetně vyhledání všech čtyř nových
anglických termínů, odkazy, stránkování, klávesnici, skrytí a rozbalení
osmi řešení i nepovinného rámečku a zobrazení bez JavaScriptu.
Šířky 1360, 1920 a 390 px bez přetékání celé stránky a bez chyb JavaScriptu.
Nové pasáže a bibliografie prohlédnuty na snímcích; ověřeno vykreslení
nových citací, autorů, let, kurzivy, lokátorů a cílových DOI/URL.
Nové číselné příklady (rozdíly 5 bodů, převod hodin na minuty a poměry)
zkontrolovány nezávisle. Excel se neměnil a nebyl znovu spouštěn.
Kontrola rozdílů bez chyb. Toto ověření se týká místního webu;
publikování na Pages následuje až po autorově sloučení PR.

## Sjednocení hlavní místní kapitoly a doplnění validity (2026-09-20)

Na výslovnou žádost autora je výsledná kapitola přímo v hlavní pracovní
složce `D:\R Projects\github\statistics-for-psychology\quarto\kapitola_01.qmd`.
Hlavní pracovní kopie přešla na tematickou větev z aktuálního `main`
(1b92cfd, sloučený PR #8). Předchozí místní redakce byla zálohována
v ignorovaném `tmp/local-integration-20260920/kapitola_01.before.qmd`
a spojena s rozšířením kapitoly. Zachováno všech 17 bloků místní redakce;
u společně změněného cíle učení spojeno „Rozlišíte“ s novými pojmy.
Opraveny dva zjevné překlepy („jí stačí“, „Tím jsme otázku upřesnili“)
a sjednocena autorem zvolená odpověď „dost“ i v nové přehledové tabulce.
Nesledovaný soubor Rproj nebyl změněn ani zahrnut do commitu.

Zapracovány další tři předem schválené body:

- Kód chybění musí být nepřípustnou, snadno rozpoznatelnou hodnotou;
  vzácná, ale možná hodnota nestačí. Zůstává nutnost nastavit zacházení
  s kódem v programu a odlišit jej od skutečné nuly.
- U online sběru odlišeno ID odpovědi od ID účastníka a od časového
  pořadí. Čas zahájení, dokončení a uložení nemusí být shodný;
  při řazení záleží na časovém pásmu a přesnosti. Obecný příklad
  odpovídá rozlišení polí v dokumentaci Qualtrics ověřené při přípravě:
  https://www.qualtrics.com/support/survey-platform/data-and-analysis-module/data/download-data/understanding-your-dataset/.
- Nová podkapitola interní/externí validity navazuje na náhodné rozdělení
  a náhodný výběr, s oporou v Howellovi (2013, s. 3) a Simonsovi a kol.
  (2017, s. 1123). Externí validita zahrnuje i situace a podmínky;
  není ztotožněna s náhodným výběrem. Vysvětlení nepředpokládá nutný
  konflikt obou validit. Doplněna otázka 4e s úplným řešením.

Slovníček má 46 hesel, nově interní a externí validitu s anglickými
ekvivalenty a českými alternativami. Přehledy značení a Excelu se nemění,
protože nové symboly, vzorce ani funkce nezavádíme.

Ověření z hlavní pracovní složky: úplný render pěti stránek úspěšný;
kontrola R prošla (pouze obvyklá varování o nedostupné lokalizaci C.UTF-8).
Kontrola HTML prošla pro 46 hesel, osm skrytých a rozbalitelných řešení,
nepovinný rámeček, místní odkazy, klávesnici, stránkování, hledání,
zobrazení bez JavaScriptu a šířky 1360, 1920 a 390 px. Bez chyb
JavaScriptu a bez přetékání celé stránky. Nové části prohlédnuty na
snímcích; citace Howella a Simonse vykresleny se správnými lokátory.
Porovnání se zálohou potvrdilo zachování všech změněných uživatelských
řádků po uvedených opravách a spojení cíle učení. Nová odpověď 4e
zkontrolována věcně; žádné nové číselné výpočty ani excelové funkce
nevznikly a Excel nebyl znovu spouštěn. `git diff --check` bez chyb.
Toto ověření se týká místního webu, nikoli zveřejnění změn na Pages.

## Rozšíření pojmů v kapitole 1 (2026-09-20)

Rozsah byl před psaním projednán a schválen: konstanta a závislost
proměnlivosti na souboru; relativní vymezení populace a výběru;
příležitostný výběr a argumenty pro zobecnění; účel náhodného rozdělení;
konkrétní operacionalizace; různé úrovně zachycení věku; počet správně
napsaných slov jako výkon versus schopnost; kvaziintervalové zacházení;
úrovně měření versus diskrétnost a spojitost; výběrová variabilita,
výběrové zkreslení a odmítání účasti.

Podrobnější vysvětlení chyby měření je po dohodě nepovinný, výchozím
stavem sbalený rámeček `chyba-mereni-podrobne`. Používá modelový pohled
na lidi se stejnou úrovní rysu, ale netvrdí, že jejich průměr je automaticky
nezkreslenou hodnotou konstruktu. Stabilní vliv znalosti jazyka může
přetrvat při opakování; formální teorii pravého skóru nezavádíme.
Na rámečku nezávisí povinná cvičení.

Nové příklady jsou vlastní modelové situace, které vycházejí z dohody
s autorem. Příklad teploty a pohodlí výslovně rozvíjí Howella (s. 7–8).
Jeho bibliografické údaje byly znovu potvrzeny na titulní a copyrightové
straně místního PDF: *Statistical Methods for Psychology*, 8. vydání,
2013, Wadsworth/Cengage, ISBN 978-1-111-83548-4. Oddíl 1.3 (s. 6–8)
zůstává oporou rozlišení významu čísel a měřené vlastnosti. Po dohodě
nepřebíráme obecný závěr, že úroveň měření není pro volbu postupu důležitá;
rozlišujeme interpretaci měření od přiměřenosti konkrétní analýzy.

Odborné doplnění a ověřené lokátory:

- Henrich, Heine a Norenzayan (2010), oddíl 2: úzké zastoupení populací;
  nejde o doklad univerzálního procenta příležitostných výběrů v psychologii.
- Simons, Shoda a Lindsay (2017), s. 1123: požadavek vymezit a zdůvodnit
  populaci, na kterou závěr vztahujeme.
- Michell (1997), s. 355: odlišení doložení kvantitativnosti vlastnosti
  od konstrukce číselného měřicího postupu.
- Liddell a Kruschke (2018), oddíl 1: rizika metrické analýzy ordinálních
  výsledků; necitujeme je jako zákaz všech přibližných postupů.
- Borsboom a Mellenbergh (2002), s. 507–510: rozdíl mezi pravým skórem
  testu a konstruktem; vlastní jazykový příklad není převzatou studií.

Metadata všech pěti článků (autoři, roky, ročníky, čísla, strany a DOI)
ověřena přes `https://api.crossref.org/works/{DOI}` a vydavatelské záznamy;
úplný podtitul Borsboomova článku ověřen v autorském PDF
https://dennyborsboom.com/wp-content/uploads/2017/11/borsboomtruescores2002.pdf.
Henrichův oddíl 2 ověřen v autorském PDF
https://www2.psych.ubc.ca/~henrich/pdfs/WeirdPeople.pdf.
Liddellův článek v ročníku 79 nemá v ověřených metadatech číslo časopisu;
žádné není domýšleno. DOI jsou ve společné bibliografii, citace zpracovává
dosavadní APA 7 CSL. Počáteční slova podtitulů jsou chráněna před
nežádoucím převedením na malá písmena citačním procesorem.

Slovníček doplněn o osm hesel (celkem 44); testový skór a reprezentativnost
zachycují pojmy použité ve schváleném výkladu. Nové symboly, vzorce ani
excelové funkce se nezavádějí, proto zůstávají příslušné přehledy beze změny.
Rozšířeny úlohy 1, 2, 4, 6 a 7, včetně úplných řešení. Původních osm
identifikátorů úloh zůstává zachováno.

Práce probíhá v oddělené pracovní kopii z `origin/main` (93c7614).
Původní místní úpravy kapitoly a nesledovaný soubor Rproj zůstaly v původní
pracovní kopii nedotčené a nejsou součástí tohoto pull requestu.

Ověření konečného znění:

- Celá kniha (pět stránek) úspěšně vykreslena v Quarto 1.9.38.
- `check-chapter-01.R` prošel v R 4.5.1: původní datová matice,
  chybějící údaje, elementární výpočty a řešení úlohy 8. R při startu
  hlásilo nedostupnou lokalizaci C.UTF-8; kontroly skončily úspěšně.
  Nové jednoduché vztahy (40/20 = 2, shodné pětibodové rozdíly IQ)
  a všechna doplněná konceptuální řešení zkontrolovány věcně, bez simulací.
- `check-html.cjs` prošel v Chrome: pět stránek, 44 hesel slovníčku,
  všech osm sbalených řešení, klávesnice, přechody osnovou, místní odkazy,
  jedinečné identifikátory, vyhledávání včetně nových anglických názvů
  a českých alternativ, stránkování a odkazy přes aktivní filtr.
- Nepovinný rámeček ověřen sbalený, otevřený klávesnicí a čitelný bez
  JavaScriptu; otevřený nepřetéká na mobilu. Zůstalo ověření řešení
  bez JavaScriptu a navigace přes `file://`.
- Desktop při 1360 a 1920 px i mobil při 390 px bez přetékání celé stránky;
  žádné chyby JavaScriptu ani únik interního R kódu či soukromých zdrojů.
- Nové tabulky, kvaziintervalový výklad, rámeček a literatura prohlédnuty
  vizuálně na kontrolních snímcích. Prověřeno všech 18 citačních výskytů
  a všech pět nových bibliografických záznamů v HTML včetně iniciál,
  pořadí autorů, let, kurzivy, podtitulů a odkazů DOI. DOI byly ověřeny
  proti veřejným registrům a vydavatelským/autorským záznamům; přístup
  k plnému textu na webu vydavatele může vyžadovat předplatné.
- `git diff --check` bez chyb. Nové rovnice ani grafy nevznikly;
  desktopový Excel se znovu nespouštěl, protože jeho příklady se neměnily.
- Veřejné nasazení této změny není lokálními kontrolami potvrzeno;
  následuje až po uživatelském sloučení a úspěšném publikačním workflow.

## Základ knihy

`_quarto.yml` vykresluje pouze `index.qmd` a studentské soubory `quarto/*.qmd`.
Adresář `sources/`, tato dokumentace a kontrolní skripty se nepublikují.
Tři závěrečné přehledy zatím mají připravenou tabulkovou strukturu;
jejich obsah přibývá s výkladovými kapitolami.

Tabulky používají malý místní skript bez externí knihovny. Vyhledávají
ve všech řádcích, také bez diakritiky. Odkaz na ID položky zruší filtr
a zobrazí správnou stránku. Bez JavaScriptu jsou všechny řádky dostupné.
Prázdné přehledy nemají fiktivní položky. Ovládání používá nativní
vstupy, tlačítka a výběrové pole, stav má atribut `aria-live`.

Před publikací je nutné zkontrolovat nejen render, ale i klávesnici,
mobilní zobrazení, skrytí řešení a odkazy přes filtr/stránkování.

## Ověření

Použito Quarto 1.9.38 z instalace RStudia, Node.js a Playwright z lokálního
balíku pracovních závislostí, prohlížeč Google Chrome.

Základ knihy: úplný render čtyř stránek úspěšný; kontrola všech místních
odkazů, jedinečných ID, ovládání prázdných tabulek a šířky 390 px prošla
bez JavaScriptových chyb. Mobilní podoba prázdného slovníčku prohlédnuta.
Základ zatím neobsahuje řešení ani matematiku; jejich ověření nebylo
předmětem této kontroly. Publikace na Pages čeká na sloučení a nastavení
zdroje GitHub Actions; živé nasazení dosud nebylo ověřeno.

## Kapitola Od psychologické otázky k datům

### Dohodnutý obsah a původ příkladů

Kapitola sleduje schválenou osnovu od otázky přes proměnné, populaci a výběr,
kauzalitu, operacionalizaci, úrovně měření a nejistotu k datové matici.
Četnosti, grafy, rozdělení dat, charakteristiky polohy a variability,
výpočty skórů, testy a intervaly spolehlivosti jsou záměrně odloženy.

Všechny studie a úlohy jsou vlastní modelové příklady. Údaje P01–P06
a K01–K03 jsou ručně vytvořená smyšlená výuková data, ne výzkumné výsledky
ani výstup náhodné simulace. Nevyžadují seed a netvrdíme na jejich základě
existenci vztahu spánku a paměti. Ukázka zvuku při učení vysvětluje
experimentální srovnání; nenabízí skutečný odhad účinku.

### Zdroje a rozhodnutí při jejich využití

| Zdroj | Využití a kontrola |
|---|---|
| Howell, Statistical Methods for Psychology, 8. vydání, 2013 | Základní rámec kapitoly; titul ověřen v PDF na straně 3, copyright a ISBN na straně 6. |
| Navarro, Learning Statistics with R, kap. 1–2 | Motivace, operacionalizace a interpretace výzkumu. Lokální PDF má novou předmluvu k převodu do Quarta; nepřiřazujeme mu automaticky rok původní verze 2015. Přesné datum vydání revidované kopie není uvedeno, proto je záznam bez data. |
| Cumming a Calin-Jageman, Introduction to the New Statistics, 2. vydání, 2024, kap. 1–2 | Nejistota a transparentnost jako průběžné téma. Rok a DOI ověřeny na PDF straně 9. Formální inferenční aparát zatím nepřebíráme. |
| Aron, Aron a Coups, Statistics for Psychology, 6. vydání, Pearson New International Edition, 2014 | Rozlišení proměnné, hodnot a konkrétního záznamu; diskrétnost a spojitost (tištěné strany 3–5). Četnosti a grafy odloženy. |
| Privitera, Statistics for the Behavioral Sciences, 4. vydání, 2024, kap. 1 | Populace/výběr, základní logika uspořádání výzkumu. Nepřebíráme širokou klasifikaci kvaziexperimentů ani tvrzení, že běžná praxe sama zdůvodňuje intervalovost. |
| Dostál, Statistické metody v psychologii, studijní opora 2022/23 | Datová matice a druhy proměnných, oddíl 5.1. Rok 2022 v bibliografii označuje začátek akademického roku uvedeného na titulu. Oddíly 3.1–3.2 budou využity při četnostech a grafech. |
| Lord (1953); Zand Scholten a Borsboom (2009) | Rozlišení číselného označení a reprezentované vlastnosti; nikoli argument pro libovolnou analýzu nominálních kódů. Jméno první autorky: Annemarie Zand Scholten. |
| Broman a Woo (2018), Data Organization in Spreadsheets | Pravidla konzistentní organizace a dokumentování údajů. Jejich preferenci nenumerického označení chybění nepřebíráme jako univerzální zákaz jiných postupů. |
| Podklady v sources/kapitola 1: prezentace, oba PDF ke kódování a Základy tvorby datové matice.docx | Autorské podněty k organizaci dat a příkladům. Nepřebíráme jejich konkrétní tabulky, obrázky ani dotazníkové položky. Vlastní český výklad a malé modelové matice. |

### Podstatná zpřesnění oproti některým podkladům

- `sec-urovne` až `sec-pomerova`: úroveň měření je zdůvodněna vztahy mezi
  hodnotami a měřenou vlastností. Počet správných odpovědí se poměrově
  interpretuje jako počet, ne automaticky jako obecná paměťová schopnost.
- `sec-souvislost-pricina`: náhodný výběr není náhodné rozdělení. Losování
  nezaručuje identické skupiny a nenahrazuje kontrolu dalších rozdílů.
- `sec-kodovani`: názvy jsou konvencí; numerické kódování není povinné;
  identifikátor není pořadím řádku a při opakovaném měření se může opakovat.
- `sec-chybejici`: −99 je přípustné pro přepis s následným ošetřením ve
  statistickém programu. Pro přímé výpočty v Excelu používáme prázdnou
  buňku a podle potřeby samostatný důvod chybění. Výpočet nenahrazuje
  kontrolu úplnosti; nula není totéž co nepozorovaný výkon.
- `sec-codebook`: kromě názvů jsou nutné význam, časový rámec, jednotky,
  přípustné hodnoty a chybění. Hodnota uvnitř rozsahu nezaručuje správnost.

### Terminologie a značení

Slovníček obsahuje 36 zavedených položek s českými a anglickými názvy,
alternativami a odkazy na první výklad. Preferujeme případ, úroveň měření
(alternativa škála měření), popisná a inferenční statistika (alternativa
induktivní statistika). Pozorování má kontextově vysvětlený význam.
Kapitola nezavádí vzorce ani matematické symboly; ID je zkratka
identifikátoru a je ve slovníčku. Nezavádí ani konkrétní funkci Excelu:
součet se zmiňuje jen jako příklad interpretačního rizika. Přehledy
značení a funkcí proto zůstávají přístupné prázdné tabulky s vysvětlením.

### Pokrytí cvičení

| Úloha | Co ověřuje |
|---|---|
| 1 | Případ, proměnná, hodnota, rozlišení účastníků a opakovaných záznamů |
| 2 | Účel statistiky, populace/výběr, omezení zobecnění |
| 3 | Rozlišení popisu, inference a kauzálního tvrzení |
| 4 | Náhodné rozdělení, nejistota složení skupin a další rozdíly podmínek |
| 5 | Konstrukt a operacionalizace, nesrovnatelnost odlišných ukazatelů |
| 6 | Argumentace o všech čtyřech úrovních měření, diskrétnost/spojitost |
| 7 | Chyba měření, zkreslení, nejistota z výběru, skutečné rozdíly a opravy |
| 8 | Oprava matice, ID, jednotky, přehled proměnných a chybění v Excelu/exportu |

Návraty k měření, výběru a chybění jsou záměrné: úlohy postupují od
rozlišení pojmů k posouzení argumentu a opravě konkrétního záznamu.
Žádná úloha nevyžaduje neveřejný podklad ani dosud nevyloženou metodu.

### Ověření kapitoly

- Úplný render pěti stránek v Quarto 1.9.38 prošel.
- `check-html.cjs`: 36 položek slovníčku; hledání v celém obsahu i bez
  diakritiky, velikosti stránek 10/25/50/všechny, přímý odkaz na položku
  za první stránkou a zrušení aktivního filtru, místní odkazy a jedinečná ID.
- Všech osm řešení je zpočátku skrytých a lze je otevřít klávesnicí
  a znovu zavřít. Mobilní šířka 390 px prošla i s otevřenou tabulkou řešení.
- Bez JavaScriptu jsou všechny položky slovníčku i všech osm řešení
  čitelné. Ověřeno také hledání poslední položky mimo první stránku.
- Opraveno přetékání dlouhého DOI na mobilu. Doplněny fokus a klávesnice
  pro rozbalovací hlavičky Quarta a posouvatelné tabulky.
- Vizuálně prohlédnuty úvod kapitoly na mobilu, ukázky měření a matice,
  codebook, naplněný slovníček a celé otevřené řešení poslední úlohy.
- `Rscript --vanilla quarto/_verification/check-chapter-01.R`: matice,
  přípustné hodnoty, chybění, opravená matice úlohy 8 a elementární
  výpočty prošly v R 4.5.1. Relace nepoužívá balíčky ani předchozí objekty.
  Systém hlásil nedostupné locale C.UTF-8, kontroly však úspěšně dokončil.
- `check-excel.ps1`: skutečně spuštěn samostatný skrytý Excel 16.0.
  SUMA(A1:C1) pro prázdné buňky vrací 0; součet 3, prázdné buňky a 4
  vrací 7. Dočasný sešit zavřen bez uložení. Tím je ověřeno konkrétní
  chování, které text zmiňuje; nejde jen o kontrolu jiným výpočetním nástrojem.
  Dokumentace funkce: https://support.microsoft.com/en-us/excel/functions/sum-function.
- Odpovědi na konceptuální úlohy byly obsahově zkontrolovány proti zadání
  a výkladu; automatické kontroly nehodnotí správnost celé argumentace.
- Žádný R kód, původní učebnice ani autorská dokumentace nejsou ve webu.
  Kapitola neobsahuje grafy ani matematické rovnice; jejich vizuální
  ověření se na tuto kapitolu nevztahuje.
- Přímý přenos do SPSS/JASP/R a živé nasazení na GitHub Pages nebyly
  provedeny. Text neobsahuje návod na konkrétní import; publikování
  čeká na uživatelské sloučení a konfiguraci Pages.

## Vycentrování, pravý obsah a README (2026-09-20)

Rozložení bylo porovnáno s místním projektem R101-textbook. Levý panel
používá `style: floating`; stejně široké boční sloupce ponechávají hlavní
text uprostřed okna. Pravá osnova má nadpis „Obsah kapitoly“ a zachovává
dosavadní hloubku dvou úrovní nadpisů.

Prázdná osnova byla reprodukována při přímém otevření vykresleného HTML
přes `file://`: prohlížeč blokuje modulový skript Quarta a kořenový seznam
obsahu zůstává ve výchozím stavu sbalený. Pravidlo `#TOC > ul` ve společném
CSS udržuje hlavní odkazy viditelné i bez tohoto skriptu. Oprava nenahrazuje
plnou funkčnost webu při přímém otevírání souborů; pro běžnou práci slouží
`quarto preview`. Na mobilu zůstává pravý panel skrytý. Stránky bez
podnadpisů samostatnou osnovu nevytvářejí.

README nyní po vzoru R101 popisuje cílovou skupinu, aktuální obsah,
strukturu projektu, sestavení, kontroly a publikování. Rozlišuje kontroly
spouštěné v GitHub Actions od místních kontrol R a desktopového Excelu.

Ověření:

- Úplný render pěti stránek v Quarto 1.9.38 úspěšně dokončen.
- `check-html.cjs` prošel v Google Chrome: vycentrování všech pěti stránek
  při 1360 a 1920 px, zobrazení celé hlavní osnovy, přechod na oddíl
  klávesnicí, viditelnost osnovy bez JavaScriptu i při otevření přes `file://`.
- Zachováno ověření 36 položek slovníčku, hledání a stránkování, všech osmi
  sbalených řešení, místních odkazů a absence chyb JavaScriptu přes HTTP.
- Šířka 390 px bez přetékání celé stránky, včetně otevřeného řešení;
  pravý panel na mobilu skrytý. Vizuálně prohlédnut úvod kapitoly
  na desktopu a mobilu a slovníček na mobilu.
- Obsah kapitoly ani data se neměnily; kontroly R a Excelu nebyly opakovány.
  Kapitola neobsahuje matematické rovnice ani grafy.
- Nová podoba veřejného webu není tímto lokálním ověřením potvrzena;
  bude publikována až po uživatelském sloučení a úspěšném nasazení.

## Citování podle APA 7 (2026-09-20)

Celá kniha používá `csl: styles/apa.csl` a společnou bibliografii
`references.bib`. Jde o nezměněný styl **APA Style 7th edition** z projektu
Citation Style Language, stažený 2026-09-20:
https://raw.githubusercontent.com/citation-style-language/styles/master/apa.csl.
Verze uvnitř souboru je datována 2026-02-07; SHA-256:
`1ECE4FB3C295E66D04B4394E295AA58A87741CEEEF1658192437EB9953C2F13E`.
Autoři a licence CC BY-SA 3.0 jsou zachováni v hlavičce souboru. Místní kopie
umožňuje reprodukovatelné sestavení bez stahování stylu při renderování.
Použití CSL v Quartu: https://quarto.org/docs/authoring/citations.html.

V kapitole byly upraveny čtyři narativní citace: rok následuje přímo
za autorem a jméno se znovu neopakuje v závorce. U Arona a spoluautorů
se používá automatický zápis `Aron et al. (2014, s. 3–5)`. České lokátory
zpracovává citační procesor; standardní CSL ponechává v bibliografii
anglické označení vydání a chybějícího data (`ed.`, `n.d.`), zatímco
v českých citacích v textu používá `b.r.`. Styl nebyl lokálně přepisován.

Názvy v bibliografii byly převedeny na větnou velikost písmen se zachováním
vlastních jmen a názvu R. Doplněny ověřené údaje:

- Lord (1953): číslo 12 a DOI https://doi.org/10.1037/h0063675;
  ročník 8 a strany 750–751 potvrzeny v metadatech Crossrefu
  https://api.crossref.org/works/10.1037/h0063675.
- Zand Scholten a Borsboom (2009): číslo 2, ověřeno u vydavatele
  https://www.sciencedirect.com/science/article/pii/S0022249609000054.

U revidované učebnice Navarro zůstává datum neuvedené, protože pro
použitou verzi není doložené. Ostatní zdrojové údaje navazují na ověření
při přípravě kapitoly popsané výše; nešlo o nové úplné bibliografické šetření.

Ověření: úspěšný render všech pěti stránek v Quarto 1.9.38, kontrola HTML
v Chrome včetně devíti bibliografických záznamů, reprezentativních citací
APA, kurzivy názvu knihy, DOI, dosavadních odkazů, řešení, slovníčku
a mobilního rozložení. Všech 12 citačních výskytů bylo prohlédnuto ve
vykreslené podobě; seznam literatury také vizuálně na desktopu a mobilu.
Číselné příklady ani řešení se neměnily, kontroly R a Excelu se neopakovaly.
Publikace této změny bude následovat až po uživatelském sloučení a nasazení.


## Kapitola 2: četnosti a grafy (2026-09-28)

### Dohodnutý obsah a návaznost

Kapitola vznikla po výslovném schválení rozsahu, značení, příkladů a terminologie. Označení „kapitola 3“ v závěru přípravy uživatel opravil na kapitolu 2. Výklad zahrnuje absolutní, relativní a kumulativní četnosti, jmenovatele a chybění, procenta a zaokrouhlování, sumaci, intervalové třídění a ztrátu podrobností, hlavní druhy grafů, popis tvaru a limity interpretace. Kontingenční tabulky zůstávají pro vztah dvou kategoriálních proměnných. Číselné charakteristiky polohy a variability ani percentily se zde nezavádějí.

Původně bylo schváleno n, f_i, p_i, k a jako první index i; od revize 2026-10-04 používáme pro kategorie j (viz níže). Kumulativní varianty mají slovní index kum. Sumace je nejprve rozepsána na malé tabulce. Podíly zobrazujeme na tři desetinná místa, procenta na jedno, mezivýpočty nezaokrouhlujeme. Primární termíny jsou „odlehlé pozorování“, „výsečový graf“, „graf stonek a list“ a „chvost“. Schválené alternativy jsou ve slovníčku; extrém není automaticky odlehlý. Nestejně široké intervaly jsou pouze sbalené rozšíření s vysvětlením výšky a plochy, bez zavedení nového formálního pojmu hustoty. Excelové ilustrace jsou přiznané rekonstrukce, nikoli vydávané za snímky aplikace.

Přidáno 28 položek slovníčku, 13 řádků značení a 3 funkce Excelu. Výklad nezobrazuje interní kód R. Deset cvičení pokrývá výpočet, volbu grafu, čtení hranic, ztrátu informace, kritiku argumentů a práci v Excelu.

### Data a původ příkladů

`data/kapitola_02.csv` obsahuje 36 záměrně sestavených modelových účastníků; nejde o skutečný výzkum ani náhodný výběr simulátoru. Prvních šest záznamů přesně navazuje na kapitolu 1 včetně čtyř kategorií odpočatosti, chybějícího spánku P05 a skutečné nuly vybavených slov P06. Spánek dále chybí u P11 a P24. Odpočatost má četnosti 4, 10, 14, 8; intervaly spánku od 4 do méně než 10 hodin mají četnosti 2, 4, 7, 11, 6, 3. Grafy tvarů, podlahy a stropu, hlavní způsob přípravy a rozdíl 30 versus 32 jsou oddělené pevné didaktické příklady. Veškerá data, úlohy a obrázky jsou vlastní; z učebnic nebyly převzaty tabulky ani ilustrace. Náhodné postupy se nepoužívají, seed tedy není potřeba.

### Posouzení zdrojů

Prohlédnuty relevantní části všech sedmi místních PDF. Základem je ověřený Howell: *Statistical methods for psychology*, 8. vydání, 2013, Wadsworth/Cengage Learning, ISBN 9781111835484. Hlavní opora: kapitola 2, tištěné s. 16–29 (PDF 40–53), zejména volba intervalů s. 20–21 a tvary s. 27–29. Privitera, 4. vydání (2024), kapitola 2, s. 35–64: relativní a kumulativní četnosti s. 41–44, histogram a polygon s. 57–59, stonek a list s. 60–61. Dostál (2022/23), oddíl 3.2.1, tištěné s. 44–46, slouží jako česká terminologická opora. Cumming a Calin-Jageman, 2. vydání (2024), s. 43–47 a 67, podporují práci s jednotlivými pozorováními a kritické čtení grafů. Aron et al., mezinárodní 6. vydání (2014), s. 7–8 a 16–19, poskytují základní didaktické srovnání. Navarro (revidovaná nedatovaná verze), kapitola 6, a Sahu (2024), kapitola 2, byly posouzeny; programátorský výklad se do studentského textu nepřenáší.

Nepřebíráme omezení histogramu pouze na spojité proměnné ani univerzální pravidlo počtu intervalů. Hranice určujeme výslovně jako dolní včetně, horní mimo interval. NIST, oddíl Definition na https://www.itl.nist.gov/div898/handbook/eda/section3/eda33e.htm, podporuje rozlišení četnosti a výšky přepočtené na šířku intervalu. Doporučení sloupců pro přesné porovnání podílů opíráme o Cleveland a McGill (1984), JASA 79(387), 531–554, DOI 10.1080/01621459.1984.10478080, zvláště experimenty na s. 536–541; netvrdíme, že každý výsečový graf je nepřípustný nebo že člověk využívá jen úhly.

Funkce POČET/COUNT, SUMA/SUM a COUNTIFS/COUNTIFS i rozdíl mezi původními daty a tabulkou četností u nativního histogramu byly ověřeny v české dokumentaci Microsoftu (odkazy v `references.bib`, přístup 2026-09-28). Názvy nebyly překládány odhadem. Všechny citace používají společnou APA 7 CSL a bibliografii, bez ručního formátování. Neveřejné PDF nejsou součástí webu.

### Sestavení a ověřené výpočty

Celá kniha se sestavila v Quarto 1.9.38. Grafy vznikají v základním R 4.5.1; nový `scripts/render-figures.R` nastavuje ve Windows UTF-8 pro správnou českou diakritiku. Původní nastavení systému hlásí nedostupné locale C.UTF-8; samotný kontrolní výpočet tím není ovlivněn. Vizuální kontrola odhalila chybné popisky při původním načítání skriptu, které explicitní UTF-8 opravilo.

`check-chapter-02.R` ověřil původních šest záznamů, úplnost nových dat, tabulky, zaokrouhlení, intervalové hranice, kumulativní podíly a všechna číselná řešení. Nezávisle byly četnosti sestaveny v Pythonu při tvorbě ilustrací. Konceptuální řešení byla redakčně porovnána s výkladem a zadáním; jejich správnost nenahrazuje automatický test.

Sešit byl vytvořen pomocí @oai/artifact-tool, všechny tři listy prohlédnuty ve vykreslených náhledech. Následný `check-chapter-02-excel.ps1 -Finalize` skutečně běžel v samostatném skrytém Excelu 16.0: ověřil 180 vstupních buněk proti CSV, českou syntaxi z výkladu, četnosti, plné podíly, součty a obě změny z posledního cvičení včetně přepočtu dat grafů. Změny vstupů vrátil do původního stavu. Excel zobrazuje 0,111 a 11,1 %, nikoli předem zaokrouhlené mezivýpočty. V nativním Excelu byla doplněna nulová mezera histogramu a nulové minimum os; tyto vlastnosti nepokrývalo použité rozhraní pro tvorbu sešitu. Oba grafy byly z Excelu exportovány a vizuálně prohlédnuty.

Matematika používá nativní MathML, protože externí MathJax CDN se při kontrole nenačetlo. Jde o přístupný matematický zápis v HTML, nikoli obrázky. Podpora nastavení je popsána v oficiální dokumentaci https://quarto.org/docs/output-formats/html-basics.html#latex-equations. Tím se odstraňuje síťová závislost a umožňuje vykreslení i bez JavaScriptu v moderním prohlížeči. Dolarové znaky excelových vzorců v HTML přehledu jsou zapsány entitou, aby nebyly nesprávně rozpoznány jako oddělovače matematiky.

### Webová kontrola a meze ověření

Závěrečný `check-html.cjs` prošel v Chrome: všech šest stránek, 78 položek slovníčku, 13 položek značení a tři funkce Excelu; interní odkazy a jedinečné identifikátory; všech 18 řešení v knize (deset nových) skrytých při načtení, otevření klávesnicí a opětovné sbalení. Ověřeno vyhledávání přes všechny řádky včetně anglických názvů a českých alternativ, velikosti stránek 10/25/50/všechny, přímé odkazy na řádky přes stránkování i aktivní filtr a čitelnost matematického zápisu. Šířky 1360 a 1920 px i mobilních 390 px bez přetékání celé stránky; posouvají se jen široké tabulky. Navigace funguje také při otevření přes file://; bez JavaScriptu jsou přehledové řádky a řešení dostupné. Kontrola nenašla chyby JavaScriptu ani chybějící místní soubory.

Vizuálně prohlédnuto všech deset grafů a tři rekonstrukce listů, matematické vzorce na desktopu i mobilu, přehled značení a excelový přehled. Opravena oříznutá legenda výsečového grafu a nedostatek prostoru pod intervalovou tabulkou. Vykreslených 15 citačních výskytů a 11 záznamů použitých ve druhé kapitole bylo zkontrolováno; společný seznam knihy obsahuje 23 zdrojů. Při původním dokončení kapitoly Quarto umísťovalo společnou bibliografii do prvního výskytu bloku refs v kapitole 1 a v dalších kapitolách ponechávalo skryté podklady citací. Závěr kapitoly 2 proto tehdy obsahoval viditelný odkaz na společný seznam. Toto umístění nahrazuje níže popsaná samostatná kapitola Literatura. Nejde o ručně sestavenou bibliografii.

Ověření Excelu se vztahuje na místní desktopový Excel 16.0, nikoli na všechny verze nebo živé klikání všemi nabídkami. Web byl vizuálně a funkčně ověřen v Chrome, nikoli ve všech prohlížečích a čtečkách obrazovky. Veřejné publikování nové kapitoly nebylo provedeno: následuje až po uživatelském sloučení a úspěšném nasazení. Původní necommitované redakční změny kapitoly 1 a místní Rproj zůstaly zachovány a nejsou součástí commitu této kapitoly.

## Členění knihy a samostatná literatura (2026-09-28)

Po schválení uživatelem má navigace dvě části Quarto Book (`part`): **Výkladové kapitoly** s dosavadními kapitolami 1 a 2 a **Literatura a přehledy** se samostatnou nečíslovanou literaturou a třemi závěrečnými přehledy v původním pořadí. Úvod „O učebnici“ stojí před oběma částmi. Skupiny lze rozbalovat a sbalovat; textová hlavička i šipka mají doplněnou roli tlačítka, vazbu aria-controls, možnost zaměření a reakci na Enter a mezerník. Tematické dělení výkladu zůstává pro budoucí dohodu o osnově.

`quarto/literatura.qmd` obsahuje jediný zdrojový blok refs. Z konců výkladových kapitol byly odstraněny původní bibliografické oddíly. Citační databáze, APA 7 CSL a zápisy citací se nemění; Quarto směruje citace na společnou stránku a generuje tam 23 použitých zdrojů. Skryté podklady pro citační náhledy na jednotlivých stránkách jsou běžnou součástí výstupu Quarta, nikoli další viditelné seznamy. Upraven byl také úvod a provozní README.

Oba výkladové texty před odstraněným bibliografickým oddílem byly porovnány kontrolním součtem s jejich stavem na začátku práce: jsou shodné včetně rozpracovaných uživatelských úprav první kapitoly. Do commitu se z prvního souboru zahrnuje pouze odstranění bibliografického oddílu. Číselné příklady, grafy ani excelový sešit se nemění, jejich obsahové kontroly proto nebyly opakovány.

Ověření: úplný render sedmi stránek v Quarto 1.9.38 a rozšířený check-html.cjs v Chrome prošly. Test ověřuje samostatně viditelnou bibliografii s 23 zdroji, cíle citací z obou kapitol, průběžné číslování 1 a 2, pořadí dvou skupin a jejich položek, sbalení myší a otevření i sbalení klávesnicí. Na mobilu ověřuje otevření navigace, rozbalení skupiny a přechod na literaturu. Zachovány jsou kontroly místních odkazů, matematiky, přehledových tabulek a všech 18 řešení. Rozložení při 390, 1360 a 1920 px nevyvolává přetékání celé stránky; bibliografie je čitelná také bez JavaScriptu. Navigace i nová stránka literatury byly vizuálně prohlédnuty na desktopu a mobilu. Ověření není testem všech prohlížečů; veřejný web se aktualizuje až po uživatelském sloučení a nasazení.

## Kapitola 2: indexy, procenta a výlučnost kategorií (2026-10-04)

Na výslovné schválení uživatele je index j vyhrazen kategoriím, hodnotám, intervalům či skupinám; index i jednotlivým pozorováním. Změna zahrnuje f_j, p_j, kumulativní četnosti, meze a slovní čtení sumací, tabulky i cvičení. Číselné indexy (např. f_2) se nezměnily. Přehled značení eviduje oba indexy, slovníček vysvětluje novou konvenci. Značení x_i a x_ij se zatím do výkladu nezavádí.

Relativní četnost 0 a 1 je výslovně propojena s 0,0 % a 100,0 %. Nový vlastní modelový příklad odlišuje vzájemně výlučné odpovědi na odpočatost od souběžně používaných strategií učení. Deset studentů označí jedenáct odpovědí: podíly lidí jsou 60,0 % a 50,0 %, podíly odpovědí 54,5 % a 45,5 %. Výklad odlišuje výlučnost od pokrytí všech případů. Pojem je doplněn do slovníčku s anglickým ekvivalentem a odkazem. Zachována a zahrnuta je již rozpracovaná uživatelská redakce druhé kapitoly; v dotčeném odstavci opraveno gramatické „zaznamenán dobu“ na „zaznamenánu dobu“.

Ověření: check-chapter-02.R prošel v čisté relaci R. Nový příklad byl nezávisle přepočten v Pythonu z deseti jednotlivých souborů odpovědí, včetně přesných zlomků a zaokrouhlení. Zkontrolována vzorová řešení a zachování číselných indexů. Celá kniha (sedm stránek) byla úspěšně vykreslena; první pokus blokovala přístupová práva k mezipaměti Quarta, opakovaný render s potřebným přístupem prošel.

check-html.cjs v Chrome prošel: 79 hesel slovníčku, místní odkazy, všech 18 řešení skrytých/otevřených/opět sbalených i klávesnicí, přehledové tabulky a mobilní šířka 390 px bez přetékání stránky. Doplňkově ověřeno hledání „mutually exclusive“, zobrazení řádku znak-j při aktivním nesouvisejícím filtru a matematika bez merror. Vizuálně prohlédnut nový text na desktopu i mobilu, procentní vyjádření, indexy a sumace. Data, grafy a excelové vzorce se nemění; desktopový Excel se znovu nespouštěl. Kontrola není ověřením všech prohlížečů. Publikování následuje až po uživatelském sloučení a nasazení.


## Kapitola 2: sjednocení názvů četností (2026-10-04)

Po schválení uživatelem používá kapitola při pojmenování veličin absolutní četnost a kumulativní absolutní četnost místo střídání s „počty“ a „kumulativními počty“. Úprava zahrnuje cíle učení, zaokrouhlování, kumulativní tabulku, výklad os histogramu, excelový postup, alternativní popisky obrázků a vzorová řešení. V související větě je sjednoceno i označení kumulativní relativní četnosti. Slovo počet zůstává v definicích a interpretacích, u hodnot proměnných (počet slov/chyb), rozsahu souboru, počtu kategorií a v názvu funkce POČET. Věcné popisky os „Počet účastníků“ zůstávají zachovány.

Zachována a zahrnuta je aktuální uživatelská redakce kapitoly, včetně zkrácení příkladu vícečetných odpovědí. Nová terminologická úprava nemění čísla, data ani výpočty; číselné zápisy byly porovnány s pracovním stavem bezprostředně před úpravou. Check-chapter-02.R prošel, dotčená kapitola se vykreslila a sekce kumulativních četností byla vizuálně prohlédnuta na desktopu a mobilu. Vzorce a číselná řešení byly zkontrolovány v rozdílech. Excelový sešit a vzorce se nemění a desktopový Excel nebyl znovu spuštěn. Publikování následuje po uživatelském sloučení.

Webová kontrola check-html.cjs prošla na všech sedmi stránkách: místní odkazy, 79 hesel, všech 18 řešení a jejich ovládání klávesnicí, přehledové tabulky, desktop i mobilních 390 px bez přetékání celé stránky; bez hlášených chyb. git diff --check prošel.


## Kapitola 2: revize podle jedenácti připomínek (2026-10-05)

### Výklad a příklady

Zapracováno všech jedenáct připomínek autora. Obecný pojem rozdělení je vysvětlen před popisem rozdělení četností, s odlišením pozorovaných dat, populace a modelu. Kumulování nominálních kategorií ukazuje vlastní příklad stejných četností 12, 14 a 10 ve dvou pořadích: průběžná kumulativní četnost u čtení je 12, nebo 26. Nejde o změnu dat.

Nová srovnávací tabulka přiřazuje stejné doby spánku do intervalů zleva uzavřených/zprava otevřených a naopak. V první variantě jsou četnosti 2, 4, 7, 11, 6, 3; ve druhé 3, 5, 8, 10, 5, 2. Oba součty jsou 33. Vysvětleno zařazení 7,0 a zacházení s případnými novými krajními hodnotami 4,0 a 10,0. Navazující příklady i excelový sešit zachovávají původní variantu. Tabulka má vlastní minimální šířku a posuvnou oblast přístupnou klávesnicí; její šířka nemění ostatní tabulky.

Volba šířky intervalů je spojena s otázkou, jednotkami, přesností dat, rozsahem a počtem pozorování; kontrolujeme několik blízkých nastavení. Nový vlastní graf seskupených kumulativních četností vychází z týchž 33 dob spánku. Na hranicích 4 až 10 hodin používá kumulativní absolutní četnosti 0, 2, 6, 13, 24, 30, 33 a zobrazuje jejich procentní vyjádření. Výslovně čte „méně než“, nikoli „nejvýše“. Plné body představují hodnoty známé z tabulky, přerušované spojnice neudávají přesné rozložení uvnitř intervalů. Střed intervalu je vysvětlen výpočtem 7 − 6 = 1, 1 / 2 = 0,5, 6 + 0,5 = 6,5.

Doplněno rovnoměrné rozdělení, nesouměrnost zešikmeného rozdělení a vícevrcholové/multimodální rozdělení. Panel se stejnými četnostmi nově nese název Rovnoměrné rozdělení. Termín multimodální má v literatuře i širší význam zahrnující bimodalitu; tato varianta je uvedena v textu i slovníčku. Odlehlá pozorování vždy nejprve zkoumáme, samotná odlehlost nedokazuje neplatnost a nestačí k vyřazení. Nejasné „obrázkové symboly“ nahrazuje vysvětlení siluet osob a čtyřnásobné plochy při dvojnásobné výšce i šířce. Rozšířeny odpovídající části úloh 5 a 7 i jejich úplná řešení, počet úloh zůstává deset.

Do slovníčku přibylo osm hesel (rozdělení, otevřená/uzavřená hranice, oba druhy polouzavřených intervalů, střed intervalu, rovnoměrné a vícevrcholové rozdělení); přehled značení obsahuje výpočet středu. Excelový přehled se nemění, nová funkce se nezavádí. Žádná nová symbolická proměnná ani intervalové závorkové značení nebyly zavedeny.

### Zdroje a věcné opravy

Znovu ověřen titul a tiráž Howella: Statistical methods for psychology, 8. vydání, 2013, Wadsworth/Cengage Learning, ISBN 9781111835484. Výklad navazuje na tištěné s. 17 (četnosti), 20–21 (hranice, středy a volba šířky), 27–29 (tvary a interpretace). Tištěné s. 20 byly prohlédnuty i obrazově. Howellovo doporučení zacházet s hraničními případy volně nepřebíráme; používáme explicitní jednotné pravidlo vhodné k reprodukování v Excelu.

Privitera (2024), tištěná s. 59 (PDF 104), ověřena textově i obrazově jako opora grafu kumulativních četností na horních hranicích; do našeho grafu nejsou přebírána jeho data ani obrázek. Aron et al. (2014), tištěná s. 16 (PDF 21), ověřena také obrazově jako doklad širšího významu multimodality (dva či více vrcholů). Howell na s. 27 výslovně připouští různě vysoké výrazné vrcholy; grafický popis zde nezaměňujeme s definicí modu jako číselné charakteristiky, která se dosud neprobírá.

Doplněny dva zdroje NIST, přístup 2026-10-05: Detection of outliers, oddíl Introduction (https://www.itl.nist.gov/div898/handbook/eda/section3/eda35h.htm), a Uniform distribution, oddíl Probability Density Function (https://www.itl.nist.gov/div898/handbook/eda/section3/eda3662.htm). Datum vydání není na použitých stránkách doloženo, nevymýšlí se. Studentům se nezavádí vzorec hustoty; zdroj podpírá vymezený rozsah a stejné zastoupení stejně širokých intervalů. Citace vznikají společným APA CSL ze záznamů v references.bib.

Kontrola nových citací odhalila anglické popisky ve společné bibliografii. Výchozí česká lokalizace je proto výslovně nastavena i v APA CSL; datum přístupu nových zdrojů používá český tvar „5. října 2026“. Skript zpřístupňující posuvné tabulky nově zachovává výslovně zadaný název oblasti; jinak jej přebírá z popisku tabulky včetně značky figcaption používané Quartem.

Zachována a zahrnuta aktuální uživatelská redakce. Související věcná oprava rozlišuje jednoho účastníka s nulou vybavených slov od nulové četnosti přesně jednoho slova; původní závorka je zaměňovala. Formulace „pouhou náhodou“ u dvou četností 14 byla nahrazena popisem shody dvou různých skupin odpovědí, protože modelová data byla záměrně sestavena. Opraveny zjevné překlepy a neúplná věta o posunu sousedních intervalů.

### Ověření

Rozšířený check-chapter-02.R prošel v čisté relaci: obě konvence hranic včetně hraničních hodnot, pokrytí všech 33 záznamů, kumulativní body proti původním datům, procenta, příklad nominálních kategorií, střed intervalu a všechna dosavadní číselná řešení. Dvě datové varianty se stejnými intervalovými četnostmi navíc ověřují, že uvnitř intervalu mohou mít různé kumulativní četnosti. Nezávislý Python výpočet s přesnými zlomky ověřil údaje v nové tabulce, nový graf, zaokrouhlení a vlastní příklady. Konceptuální řešení zkontrolována proti výkladu.

Celá kniha se vykreslila (sedm stránek, jedenáct grafů a tři excelové ilustrace). Webové kontroly prošly v Chrome: 87 hesel slovníčku, 25 zdrojů společné bibliografie, odkazy, hledání nových pojmů, přehledové tabulky a všech 18 řešení včetně klávesnice; desktop 1360/1920 px a mobil 390 px bez přetékání stránky. Vizuálně prohlédnut nový kumulativní graf, srovnávací tabulka, označení rovnoměrného rozdělení, výklad středu, společná bibliografie a mobilní zobrazení. Na mobilu tabulka zachovává čitelné šířky sloupců; ověřeno její vodorovné posouvání šipkou na klávesnici v samostatné oblasti. Kontrola také ověřuje české citační popisky a datum přístupu obou nových zdrojů.

V jednom opakovaném běhu se objevily chyby načtení citačních náhledů (applyStyles, window.tippy). Po doplnění adresy stránky a zásobníku chyby do diagnostiky prošla stejná kontrola bez další změny vykresleného webu. Příčinu jednorázového výskytu se nepodařilo reprodukovat; nelze jej vydávat za opravenou chybu. git diff --check prošel.

Data, původní výpočty a excelový sešit se nemění. Nativní Excel nebyl znovu spuštěn; ověření webu není testem všech prohlížečů. Veřejná publikace následuje až po uživatelském sloučení a nasazení.

## Kapitola 2: meze intervalů (2026-10-05)

Na schválení autora používáme dolní a horní mez intervalu namísto hranic. Otevřenost a uzavřenost vztahujeme k intervalu a vysvětlujeme, zda příslušná mez do intervalu patří. Sjednoceny jsou výklad, tabulky, popisky kumulativních grafů, alternativní texty, cvičení, slovníček a přehled výpočtu středu. Obecné hranice měření u efektu podlahy a stropu zůstávají zachovány. Původní identifikátory odkazů zůstávají stabilní; v aktuální autorské redakci byl navíc doplněn chybějící identifikátor srovnávací tabulky, na který text odkazuje. Úpravy zarovnání tabulek od autora byly zachovány.

Slovníček nově obsahuje Meze intervalu s anglickými ekvivalenty. Dřívější označení otevřená/uzavřená hranice je pouze mezi alternativami; preferované popisy uvádějí, zda mez do intervalu patří. Poznámka Histogram!A14 v přiloženém sešitu i její zdrojový generátor nyní používají „Dolní mez“. Artifact Tool upravil a vykreslil buňku; jeho úplný export však přepisoval nesouvisející části původního sešitu. Proto byl do původního balíčku přenesen pouze vytvořený text. Porovnání všech částí XLSX potvrdilo jedinou textovou náhradu ve sharedStrings; ostatní XML, vzorce, hodnoty, grafy a styly zůstaly beze změny. Poznámka byla vizuálně ověřena před úpravou i po ní. Nativní Excel nebyl znovu spuštěn.

Celá kniha byla vykreslena. Check-chapter-02.R prošel; porovnání s pracovním stavem před úpravou potvrdilo shodu všech matematických zápisů a doslovných výpočetních ukázek. Kopie sešitu v sestaveném webu odpovídá upravenému zdroji.

Check-html.cjs prošel na sedmi stránkách bez chyb: 88 hesel slovníčku, místní odkazy, přehledové tabulky, všech 18 řešení včetně klávesnice, desktop 1360/1920 px a mobil 390 px bez přetékání celé stránky. Vizuálně ověřeny změněné popisky grafů, tabulka a vysvětlení mezí na mobilu. git diff --check prošel. Kontroly neověřují všechny prohlížeče ani novou publikaci webu.


## Kapitola 1: role proměnných (2026-10-05)

Na výslovné schválení autora vložen oddíl „Nezávislá a závislá proměnná: role ve výzkumné otázce“ mezi vysvětlení experimentu s rušivými zvuky a interní/externí validitu. Zachováno schválené znění včetně autorské úpravy závěrečné věty o roli rozlišení proměnných pro vysvětlení a psychologickou teorii. Doplněny pouze citační opory, stabilní identifikátor, obal tabulky a odkazy do slovníčku. Výklad rozlišuje experimentální a širší užití nezávislé/závislé proměnné a významové nuance označení explanační proměnná, prediktor, výsledná proměnná, kritérium a predikant. Obecná preferovaná dvojice je explanační/výsledná proměnná; v experimentu také nezávislá/závislá proměnná. Prediktor není omezen na odhad budoucnosti a pojmenování samo nedokazuje příčinu.

Slovníček obsahuje sedm nových hesel se stabilními odkazy, anglickými ekvivalenty a kontextovým rozlišením alternativ. Přehled značení a Excelu se nemění, protože nebyly zavedeny symboly, vzorce ani funkce. Cíle učení jsou doplněny o role proměnných; úloha 4 má novou část f) s úplným řešením uvnitř původního sbaleného bloku. Modelový příklad navazuje na původní autorský příklad kapitoly a nepřebírá data z učebnic.

Znovu ověřena titulní strana a tiráž Howella: Statistical methods for psychology, 8. vydání, 2013, Wadsworth/Cengage Learning, ISBN 9781111835484. Textově i obrazově ověřena tištěná s. 4 (PDF 28), která zahrnuje manipulovanou i pouze měřenou nezávislou proměnnou. Navarro, místní revidované Learning statistics with R, oddíl 2.4 na s. 43–44, vysvětluje role proměnných, prediktory a výsledky a upozorňuje na zavádějící konotace tradičních názvů; s. 44 ověřena také obrazově. Citace používají existující bibliografické záznamy a společný APA CSL. Bibliografické údaje ani nové zdroje nebyly přidávány. Přísné pravidlo o prediktoru pouze pro budoucí kritérium není součástí schváleného textu.

Ověření: celá kniha (sedm stránek) se úspěšně vykreslila. První pokus blokoval přístup k mezipaměti Quarta; opakování s potřebným přístupem prošlo. Check-chapter-01.R prošel v čisté relaci R; původní data a výpočty se nemění. Nová konceptuální odpověď byla zkontrolována proti zadání a výkladu. Rozšířený check-html.cjs prošel bez chyb: 95 hesel, místní odkazy, hledání všech sedmi nových anglických označení a zpřístupnění jejich řádků přes aktivní nesouvisející filtr, všech 18 řešení včetně klávesnice, desktop 1360/1920 px a mobil 390 px bez přetékání celé stránky. Nový oddíl a tabulka byly vizuálně prohlédnuty na desktopu i mobilu, včetně českých vykreslených citací. Dosavadní kontrola ověřila i společnou bibliografii. git diff --check prošel.

Excelové příklady ani sešit se nemění; desktopový Excel nebyl znovu spuštěn. Kontrola webu proběhla v Chrome, nikoli ve všech prohlížečích. Veřejné publikování následuje až po uživatelském sloučení a nasazení.

## Kapitola 3: ukazatele polohy a variability (2026-10-05)

### Schválený rozsah a návaznost

Po diskusi a výslovném schválení autora vznikla kapitola o poloze a variabilitě. Navazuje na data o spánku a paměti z druhé kapitoly. Základ zahrnuje modus, medián, průměr a spojování skupinových průměrů; kvantily a percentilové pořadí; variační a mezikvartilové rozpětí; odchylky, rozptyl a směrodatnou odchylku; medián absolutních odchylek od mediánu, ořezání a winsorizaci; krabicový graf; krátké vysvětlení entropie; změnu jednotek, volbu a komunikaci statistik a konceptuální odlišení popisu dat od parametrického modelu.

Výpočet entropie včetně logaritmu o základu 2, momentová šikmost a kurtóza/exces včetně výpočtů a odpovídající Excel jsou ve třech výchozím stavem sbalených nepovinných blocích. Formální normální model, z-skóry, pravděpodobnosti intervalů a pravidlo přibližných podílů kolem průměru zůstávají pro následující výklad. Kapitola obsahuje dvanáct základních a dvě nepovinná cvičení. Všechna řešení jsou úplná a sbalená.

Použité značení: malé kurzivní m, x_i pro původní hodnoty, x_(i) pro uspořádané hodnoty, medián jako x s vlnovkou, q_p pro kvantil s úrovní p, s² a s pro výběrový rozptyl a směrodatnou odchylku, h pro entropii a g₁/g₂ pro základní momentovou šikmost a exces. Nové řecké populační značky se nezavádějí. Symboly, operátory a korekční vztahy jsou doplněny do přehledu, nové pojmy do slovníčku a všechny použité excelové funkce do třetího přehledu. Konečné výsledky zpravidla na dvě desetinná místa; mezivýpočty bez zaokrouhlení. U podílů a procent nadále platí konvence druhé kapitoly; přesné jednoduché podíly ve výkladu vzorců nejsou prezentovány jako zaokrouhlené odhady.

### Zdroje, konvence a opravy podkladů

Zdroje jsou nově uspořádány v podsložkách `sources/`. Hlavní učebnice je `sources/učebnice/howell.pdf`: Statistical methods for psychology, 8. vydání, 2013, Wadsworth/Cengage Learning, ISBN 9781111835484. Pro tuto kapitolu je relevantní Howellova kapitola 2: poloha na tištěných s. 32–35, variabilita 35–47, boxploty 47–50, percentily 51–52 a transformace v oddílu 2.12. Cumming a Calin-Jageman, 2. vydání 2024, slouží zejména pro s. 51–58, 62–68; Dostál (studijní opora 2022/23) pro oddíly 3.3–3.5. Titulní údaje a citované pasáže byly ověřeny v místních PDF; vybrané pasáže také obrazově.

Posouzeny byly také `sources/starší přednášky/PSYb1170_P02_2026_-_Popisne_statistiky.pptx` a `sources/příklady k procvičování/ulohy_tyden02_2026.docx`. Slouží jako orientace v obsahu kurzu a typech úloh. Data, příklady, zadání a grafy nové kapitoly jsou autorské; nepřebírají jejich tabulky ani obrázky. Průběžný příklad 4, 5, 5, 6, 10 minut i deset časů pro ořezání jsou uloženy v novém CSV. Data o spánku a paměti jsou beze změny převzata z vlastního výukového souboru druhé kapitoly. Simulace je výslovně označena a její populace je úplně zadána.

Podstatná rozhodnutí a věcné opravy:

- Kvantily používají interpolaci typu 7, shodnou s PERCENTIL.INC a výchozím R quantile. Odborná opora Hyndman a Fan (1996), oficiální dokumentace R a Microsoftu. Kvartily grafů se počítají výslovně, nikoli pomocí výchozích Tukeyho závěsů v R. Pozice 1 + (n − 1)p nahrazuje jiné algoritmy podkladů; vzorec pro pozici horního kvartilu na snímku 27 přednášky je chybný.
- Interpolovaný výběrový percentil nelze definovat příslibem přesně daného podílu menších či menších nebo rovných pozorování. Konkrétní protipříklady 90. percentilu pěti hodnot a 30. percentilu čtyř hodnot ukazují problém i bez shod. Percentilové pořadí je samostatně definováno inkluzivně (≤); alternativní zacházení se shodami je vysvětleno. U mediánu jsou podíly na obou stranách vyjádřeny pomocí „alespoň“.
- Rozlišujeme součet čtverců původních hodnot a součet čtverců odchylek. V původní úloze X2_24 pro 40, 45, 50 je první součet 6125, druhý 50 a výběrový rozptyl 25. Čísla ze snímku 43 přednášky s nesouladem deklarovaného n = 11 a deseti zobrazených hodnot nejsou přebírána.
- Dělení n je platný popis empirického rozdělení; s² zde označuje dělení n − 1. Simulace používá nezávislé tahy s vracením, populaci 2, 4, 6, 8, 10 a rozptyl 8 min². Pro n = 5, 20 a 100 vzniká vždy 20 000 výběrů, seed 20261005. Nestrannost není přesnost jednotlivého odhadu a nepřenáší se automaticky na odmocninu.
- Medián absolutních odchylek je bez škálovací konstanty; v interním R se zadává `constant=1`. Přepočet přibližně 1,4826 v jiných programech je vysvětlen jako jiná varianta. Odolnost není přisuzována všem pořadovým statistikám a odečítání kódů ordinálních kategorií není automaticky přípustné.
- Výklad kurtózy nepřebírá interpretaci pouhé ostrosti vrcholu. Opírá se o Westfallův článek (2014), The American Statistician 68(3), 191–195, DOI 10.1080/00031305.2014.917055. Autorský diskrétní protipříklad drží 80 ze 100 hodnot ve středu, ale mění exces z 2 na 10,89. Rozlišuje kurtózu, základní exces a korigovaný výsledek KURT; SKEW se liší od SKEW.P.
- Krátké vysvětlení entropie a jejího výpočtu navazuje na Shannonův oddíl 6; ověřen opravený přetisk původního článku (1948), The Bell System Technical Journal 27(3), 379–423, DOI 10.1002/j.1538-7305.1948.tb01338.x. Jednotka bit souvisí se základem 2. Nulový podíl má nulový příspěvek, nepočítá se logaritmus nuly. Entropie není ukazatelem kvality strategií ani vzdáleností jejich kódů.
- Nulová základna sloupcového grafu souvisí s kódováním velikosti délkou sloupce, nikoli pouze se smysluplností nuly dané škály. Pro IQ lze použít bodový graf s vhodným jasně označeným měřítkem. Opora: oficiální doporučení ONS pro sloupcové grafy.
- Česká funkce pro logaritmus s volitelným základem je LOGZ, anglicky LOG. Názvy a argumenty nových funkcí byly ověřeny v české dokumentaci Microsoftu a skutečném Excelu, nikoli odhadnuty překladem.

Nové zdroje v `references.bib` zahrnují tři články, dokumentaci NIST/R, doporučení ONS a šestnáct funkcí Microsoftu. Citace i bibliografie vznikají společným APA CSL. Kontrola odhalila rozdílná písmena u nedatovaných zdrojů stejného autora mezi samostatně zpracovanými kapitolami a společnou literaturou. Společné `nocite: '@*'` nyní zajišťuje stejnou sadu podkladů pro citeproc. Nejde o ruční úpravu citací či letopočtů; bibliografie obsahuje pouze použité zdroje. Kontrola HTML porovnává záznamy v kapitolách se společným seznamem.

### Sešit a dosavadní ověření

Sešit `data/kapitola_03.xlsx` má listy Priklad, Souhrn, Rozsireni a Data. Priklad ukazuje odchylky a jejich mocniny v pomocných sloupcích, Souhrn rozlišuje 33 platných údajů o spánku a 36 paměťových výkonů, Rozsireni obsahuje entropii a koeficienty tvaru, Data původních 36 případů. Po exportu pomocí Artifact Tool je potřeba normalizace novějších funkcí v nativním Excelu: bez ní Excel některé exportované vzorce nevyhodnotil, přestože náhled nástroje hodnoty vypočetl. Finalizační krok znovu zadává vzorce Excelu, provádí kontroly a ukládá jeho přepočtené hodnoty. To je součást reprodukovatelného postupu, nikoli nutný zásah studenta.

Všechny čtyři listy byly vykresleny a obrazově prohlédnuty. `check-chapter-03-excel.ps1 -Finalize` prošel v samostatné skryté instanci Excelu 16.0. Následně prošlo i opětovné otevření uloženého sešitu bez ukládání kontrolních změn. Ověřeny byly české vzorce, 185 datových vstupů včetně chybění, výsledky na všech výpočetních listech a přepočet po změně času 10 → 30, četnosti 0 → 8 a doby spánku 6 → 7; původní vstupy byly vždy obnoveny. Nezávislá kontrola uloženého XLSX potvrdila 80 vzorců s uloženými výsledky a žádné chybové buňky.

`check-chapter-03.R` prošel v čisté relaci. Ověřuje číselné příklady a řešení, transformace, kvantily a vousy, oba výpočty absolutních odchylek, ořezání a winsorizaci, entropii i momentové koeficienty. Přesný výčet všech 3125 stejně pravděpodobných výběrů velikosti 5 z pětičlenné populace potvrzuje průměr rozptylů 6,4 při dělení n a 8 při dělení n − 1 nezávisle na Monte Carlo simulaci. Python s přesnými zlomky nezávisle ověřil průběžný příklad, kvartilové meze a příklad dvou kurtóz. Zkontrolována byla také konceptuální řešení; například tvrzení o ploše vrcholu, neinterpretovatelném průměru kódů a automatickém vyřazování vzdálených pozorování nejsou přebírána. Dosavadní číselná kontrola druhé kapitoly nadále prochází.

Celá kniha se úspěšně vykreslila (osm stránek). Závěrečná kontrola HTML prošla v Chrome bez chyb: 137 hesel slovníčku, 40 řádků značení a 19 funkcí, 48 zdrojů, místní odkazy, číslování, hledání i zpřístupnění nových položek přes aktivní filtr a stránkování. Ověřeno všech 32 řešení knihy, z toho 14 nových, pomocí klávesnice a rozbalení/sbalení; tři nepovinné bloky jsou výchozím stavem zavřené. Kontrola pokryla desktop 1360/1920 px a mobil 390 px včetně otevřených rozšíření, bez přetékání celé stránky. Matematika je textové MathML bez chyb parseru, interní R kód není zobrazen. Bibliografické záznamy a rozlišovací písmena souhlasí mezi kapitolami a společnou literaturou; všechny záznamy v bibliografii jsou skutečně citovány. Nový sešit ve vykreslené knize je shodný se zdrojovým souborem.

Vizuální prohlídka zahrnula všech sedm grafů, výklad a vzorce entropie a momentů, tabulky a mobilní zobrazení. Opraveno překrytí popisků boxplotu, ořezávání osových popisků v panelových grafech a kolize čísel s referenční čarou simulace. Po posledním posunu číselného popisku byla znovu vykreslena dotčená kapitola a cíleně prohlédnut graf i mobilní rovnice. `git diff --check` prošel. První spuštění browserové kontroly blokoval přístup k místnímu serveru v omezeném procesu; s odpovídajícím přístupem kontrola prošla. Ověření se vztahuje k místnímu Chrome a Excelu 16.0, nikoli ke všem prohlížečům či starším verzím Excelu. Veřejné publikování následuje až po uživatelském sloučení a nasazení.
