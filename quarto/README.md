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

Používáme n, f_i, p_i, k a jako první index i; kumulativní varianty mají slovní index kum. Sumace je nejprve rozepsána na malé tabulce. Podíly zobrazujeme na tři desetinná místa, procenta na jedno, mezivýpočty nezaokrouhlujeme. Primární termíny jsou „odlehlé pozorování“, „výsečový graf“, „graf stonek a list“ a „chvost“. Schválené alternativy jsou ve slovníčku; extrém není automaticky odlehlý. Nestejně široké intervaly jsou pouze sbalené rozšíření s vysvětlením výšky a plochy, bez zavedení nového formálního pojmu hustoty. Excelové ilustrace jsou přiznané rekonstrukce, nikoli vydávané za snímky aplikace.

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

Vizuálně prohlédnuto všech deset grafů a tři rekonstrukce listů, matematické vzorce na desktopu i mobilu, přehled značení a excelový přehled. Opravena oříznutá legenda výsečového grafu a nedostatek prostoru pod intervalovou tabulkou. Vykreslených 15 citačních výskytů a 11 záznamů použitých ve druhé kapitole bylo zkontrolováno; společný seznam knihy obsahuje 23 zdrojů. Quarto umísťuje společnou bibliografii do prvního výskytu bloku refs, nyní v kapitole 1, a v dalších kapitolách ponechává skryté podklady citací. Proto závěr kapitoly 2 obsahuje viditelný odkaz na společný seznam. Nejde o ručně sestavenou bibliografii.

Ověření Excelu se vztahuje na místní desktopový Excel 16.0, nikoli na všechny verze nebo živé klikání všemi nabídkami. Web byl vizuálně a funkčně ověřen v Chrome, nikoli ve všech prohlížečích a čtečkách obrazovky. Veřejné publikování nové kapitoly nebylo provedeno: následuje až po uživatelském sloučení a úspěšném nasazení. Původní necommitované redakční změny kapitoly 1 a místní Rproj zůstaly zachovány a nejsou součástí commitu této kapitoly.