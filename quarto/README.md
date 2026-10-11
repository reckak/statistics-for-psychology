# Autorská dokumentace

Historické záznamy níže popisují stav v době vzniku a zůstávají zachovány.
Pro současné konvence používejte [přehled rozhodnutí](../docs/ROZHODNUTI.md),
pro preferované názvy, alternativy a významové hranice
[autorský registr terminologie](../docs/SLOVNIK.md),
pro aktuální obsah, návaznosti a oddělený plán pokračování
[mapu učebnice](../docs/OSNOVA.md).

<a id="terminologie-mereni-01"></a>

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

<a id="terminologie-validita-01"></a>

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

<a id="terminologie-rozsireni-01"></a>

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

<a id="terminologie-zaklad-01"></a>

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


<a id="terminologie-zaklad-02"></a>

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

<a id="terminologie-meze-02"></a>

## Kapitola 2: meze intervalů (2026-10-05)

Na schválení autora používáme dolní a horní mez intervalu namísto hranic. Otevřenost a uzavřenost vztahujeme k intervalu a vysvětlujeme, zda příslušná mez do intervalu patří. Sjednoceny jsou výklad, tabulky, popisky kumulativních grafů, alternativní texty, cvičení, slovníček a přehled výpočtu středu. Obecné hranice měření u efektu podlahy a stropu zůstávají zachovány. Původní identifikátory odkazů zůstávají stabilní; v aktuální autorské redakci byl navíc doplněn chybějící identifikátor srovnávací tabulky, na který text odkazuje. Úpravy zarovnání tabulek od autora byly zachovány.

Slovníček nově obsahuje Meze intervalu s anglickými ekvivalenty. Dřívější označení otevřená/uzavřená hranice je pouze mezi alternativami; preferované popisy uvádějí, zda mez do intervalu patří. Poznámka Histogram!A14 v přiloženém sešitu i její zdrojový generátor nyní používají „Dolní mez“. Artifact Tool upravil a vykreslil buňku; jeho úplný export však přepisoval nesouvisející části původního sešitu. Proto byl do původního balíčku přenesen pouze vytvořený text. Porovnání všech částí XLSX potvrdilo jedinou textovou náhradu ve sharedStrings; ostatní XML, vzorce, hodnoty, grafy a styly zůstaly beze změny. Poznámka byla vizuálně ověřena před úpravou i po ní. Nativní Excel nebyl znovu spuštěn.

Celá kniha byla vykreslena. Check-chapter-02.R prošel; porovnání s pracovním stavem před úpravou potvrdilo shodu všech matematických zápisů a doslovných výpočetních ukázek. Kopie sešitu v sestaveném webu odpovídá upravenému zdroji.

Check-html.cjs prošel na sedmi stránkách bez chyb: 88 hesel slovníčku, místní odkazy, přehledové tabulky, všech 18 řešení včetně klávesnice, desktop 1360/1920 px a mobil 390 px bez přetékání celé stránky. Vizuálně ověřeny změněné popisky grafů, tabulka a vysvětlení mezí na mobilu. git diff --check prošel. Kontroly neověřují všechny prohlížeče ani novou publikaci webu.


<a id="terminologie-role-01"></a>

## Kapitola 1: role proměnných (2026-10-05)

Na výslovné schválení autora vložen oddíl „Nezávislá a závislá proměnná: role ve výzkumné otázce“ mezi vysvětlení experimentu s rušivými zvuky a interní/externí validitu. Zachováno schválené znění včetně autorské úpravy závěrečné věty o roli rozlišení proměnných pro vysvětlení a psychologickou teorii. Doplněny pouze citační opory, stabilní identifikátor, obal tabulky a odkazy do slovníčku. Výklad rozlišuje experimentální a širší užití nezávislé/závislé proměnné a významové nuance označení explanační proměnná, prediktor, výsledná proměnná, kritérium a predikant. Obecná preferovaná dvojice je explanační/výsledná proměnná; v experimentu také nezávislá/závislá proměnná. Prediktor není omezen na odhad budoucnosti a pojmenování samo nedokazuje příčinu.

Slovníček obsahuje sedm nových hesel se stabilními odkazy, anglickými ekvivalenty a kontextovým rozlišením alternativ. Přehled značení a Excelu se nemění, protože nebyly zavedeny symboly, vzorce ani funkce. Cíle učení jsou doplněny o role proměnných; úloha 4 má novou část f) s úplným řešením uvnitř původního sbaleného bloku. Modelový příklad navazuje na původní autorský příklad kapitoly a nepřebírá data z učebnic.

Znovu ověřena titulní strana a tiráž Howella: Statistical methods for psychology, 8. vydání, 2013, Wadsworth/Cengage Learning, ISBN 9781111835484. Textově i obrazově ověřena tištěná s. 4 (PDF 28), která zahrnuje manipulovanou i pouze měřenou nezávislou proměnnou. Navarro, místní revidované Learning statistics with R, oddíl 2.4 na s. 43–44, vysvětluje role proměnných, prediktory a výsledky a upozorňuje na zavádějící konotace tradičních názvů; s. 44 ověřena také obrazově. Citace používají existující bibliografické záznamy a společný APA CSL. Bibliografické údaje ani nové zdroje nebyly přidávány. Přísné pravidlo o prediktoru pouze pro budoucí kritérium není součástí schváleného textu.

Ověření: celá kniha (sedm stránek) se úspěšně vykreslila. První pokus blokoval přístup k mezipaměti Quarta; opakování s potřebným přístupem prošlo. Check-chapter-01.R prošel v čisté relaci R; původní data a výpočty se nemění. Nová konceptuální odpověď byla zkontrolována proti zadání a výkladu. Rozšířený check-html.cjs prošel bez chyb: 95 hesel, místní odkazy, hledání všech sedmi nových anglických označení a zpřístupnění jejich řádků přes aktivní nesouvisející filtr, všech 18 řešení včetně klávesnice, desktop 1360/1920 px a mobil 390 px bez přetékání celé stránky. Nový oddíl a tabulka byly vizuálně prohlédnuty na desktopu i mobilu, včetně českých vykreslených citací. Dosavadní kontrola ověřila i společnou bibliografii. git diff --check prošel.

Excelové příklady ani sešit se nemění; desktopový Excel nebyl znovu spuštěn. Kontrola webu proběhla v Chrome, nikoli ve všech prohlížečích. Veřejné publikování následuje až po uživatelském sloučení a nasazení.

<a id="terminologie-zaklad-03"></a>

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

## Kapitola 2: horní mez včetně v tabulkách a grafech (2026-10-05)

Na výslovné schválení autora přecházejí navazující příklady na zleva otevřené a zprava uzavřené intervaly. Tento záznam nahrazuje dřívější rozhodnutí zachovat variantu A; srovnávací tabulka obou přípustných konvencí zůstává. Kumulativní četnost na horní mezi nyní jednotně znamená „nejvýše“ daná mez, stejně jako u jednotlivých hodnot. Sjednoceny jsou výklad, hlavní intervalová tabulka, histogramy s různými šířkami, polygon, kumulativní graf, alternativní texty, cvičení 5 a 10, slovníček, excelový přehled, sešit a jejich zdrojové generátory.

Zdrojová data se nemění. Pro 33 známých dob spánku jsou nové jednohodinové četnosti 3, 5, 8, 10, 5 a 2. Kumulativní počty na mezích 4 až 10 jsou 0, 3, 8, 16, 26, 31 a 33; nejvýše sedm hodin uvedlo 16/33, tedy 48,5 %. Excel používá dolní podmínku `>` a horní `<=`. Vysvětlení krajních hodnot požaduje pokrýt všechny údaje: je možné začít pod minimem nebo výslovně zahrnout i dolní mez prvního intervalu. Nulový počáteční bod kumulativního grafu je přípustný pouze na mezi, pod kterou ani na ní žádný údaj neleží. Spojnice seskupeného grafu neudává přesné rozložení uvnitř intervalů.

Aktualizována byla také aktuální místní prezentace `presentations/kapitola_02_cetnosti_a_rozdeleni.pptx` včetně uživatelovy redakce a její přesný export poznámek `presentations/kapitola_02_poznamky.docx`. V cvičném souboru se 72 účastníky zůstala data beze změny. Protože obsahují dvě doby spánku přesně 4,0, první interval zahrnuje 4 až 5 včetně, další zahrnují pouze horní mez. Četnosti pro 64 známých údajů jsou 5, 10, 17, 20, 11 a 1; v tichu 2, 5, 9, 14, 9 a 1 (n = 40), v hluku 3, 5, 8, 6, 2 a 0 (n = 24). Přepočtena jsou i řešení pro půlhodinové a dvouhodinové intervaly, relativní četnosti a kumulativní grafy. Graf z intervalové tabulky začíná na první horní mezi 5; bod u 4 lze doplnit z původních dat, nikoli předpokládat nulu. Prezentace a její exporty zůstávají podle `.gitignore` místními výstupy.

Ověření: čistá relace R prošla kontrolou obou konvencí, mezních hodnot, kumulativních bodů a číselných řešení. Nezávislý přepočet v Pythonu ověřil intervalové četnosti. Excel 16.0 skutečně přepočítal sešit ke kapitole, ověřil 180 původních vstupních buněk, vzorce, relativní četnosti, formáty i reakci grafu na změnu spánku z 6 na 7 a obnovení hodnoty. V samostatně otevřeném cvičném sešitu prošlo 12 dosavadních kontrol, všech 18 nových četností celkem a podle podmínek i tři případy zaokrouhlení; sešit se neukládal. Hodnoty 20/64 se zobrazují jako 0,313 a 31,3 %, hodnota 52/64 jako 81,3 %.

Celá kniha byla vykreslena a webová kontrola v Chrome prošla na sedmi stránkách: 88 hesel slovníčku, odkazy, přehledy, všech 18 řešení a ovládání klávesnicí, šířky 390/1360/1920 px bez přetékání celé stránky. Změněné grafy, excelová ilustrace a dotčené oddíly na mobilu byly prohlédnuty. Nativní PowerPoint vykreslil všech 32 slidů; osm změněných slidů bylo vizuálně zkontrolováno, zbývajících 24 je obrazově totožných s původní verzí. Kontrola balíčku a geometrie prezentace skončila bez nálezů. Všechny texty slidů, předloh a poznámek mají češtinu. DOCX přesně zachovává 239 odrážek poznámek i zvýraznění. Byl vykreslen ve Wordu na 15 stran a celý vizuálně zkontrolován; po opravě zaokrouhlení byly znovu ověřeny dvě dotčené strany. Běžný pomocný renderer DOCX nebyl dostupný kvůli chybějícímu LibreOffice, proto kontrolu zajistil Word. Ověření neznamená publikaci webu ani kontrolu všech prohlížečů.

Po začlenění souběžně sloučených změn kapitol 1 a 3 byla zachována obě doplnění autorské dokumentace a nové položky společných přehledů. Opakovaný úplný render osmi stránek i kontrola v Chrome prošly: 137 hesel slovníčku, 32 řešení, odkazy, navigace, klávesnice a mobilní zobrazení bez chyb. Číselná kontrola kapitoly 2 nadále prochází a sešit ve webu odpovídá zdrojovému souboru.

## Kapitola 3: modus, medián, volba středu a interpolace (2026-10-09)

Na základě pěti redakčních připomínek autora byl rozšířen začátek kapitoly přímo v hlavní pracovní složce. Dosavadní necommitované úpravy úvodu byly zachovány; opravena pouze diakritika ve slově „měřící“. Větev `codex/chapter-03-centre-quantiles` vychází z aktuálního `origin/main` po sloučení PR #22.

Definice modu nyní mluví o nejvyšší četnosti a vysvětluje shodný výsledek pro absolutní a relativní četnosti. Výklad propojuje modus s vrcholy a již zavedenými označeními unimodální, bimodální a multimodální. Zachovává rozdíl mezi několika přesnými hodnotami se stejnou nejvyšší četností a několika výraznými vrcholy různé výšky. Příklad jemně měřených reakčních časů vysvětluje málo informativní náhodnou shodu; histogram rozlišuje jednotlivou hodnotu od intervalu a připomíná vliv třídění. Medián je nejprve definován oběma podmínkami „alespoň polovina“; výpočet a konvence při sudém počtu následují až poté.

Nová podkapitola `sec-volba-stredu` srovnává účel, výhody a omezení modu, mediánu a průměru. Odbornou oporou je Howell, *Statistical methods for psychology*, 8. vydání, 2013, Wadsworth/Cengage Learning, ISBN 9781111835484. Titul a tiráž byly znovu ověřeny v `sources/učebnice/howell.pdf`, stejně jako tištěné s. 27 a 32; pasáž „Relative Advantages and Disadvantages of the Mode, the Median, and the Mean“ na tištěných s. 34–35 (PDF 58–59) byla přečtena i obrazově zkontrolována. Srovnání je vlastním českým výkladem s autorským časovým příkladem, nikoli překladem tabulky či převzatým zadáním. Nepřebírá obecná tvrzení, že shoda průměru a mediánu vyžaduje souměrnost nebo že výběrový průměr je bez dalších předpokladů vždy stabilnější. Tyto limity Howellova výkladu byly autorovi výslovně sděleny.

Nový autorský příklad obsahuje jedenáct časů 4, 5, 7, 8, 9, 10, 12, 13, 15, 18 a 22 minut. Všechny vstupy jsou přímo v tabulce kapitoly a generátoru grafu; studentský XLSX ani CSV se nemění. Pro konvenci PERCENTIL.INC jsou vysvětleny přiřazené úrovně `(i − 1)/(n − 1)`, pozice `1 + (n − 1)p` a přesný interpolační vztah s dosavadními symboly. Dvoučástový graf ukazuje celou řadu a zvětšený úsek pro 17. percentil: pozice 2,7, výsledek 6,4 minuty, skutečný podíl menších nebo rovných časů 2/11. Deset mezer neoznačuje skupiny po 10 % pozorování. Výklad ošetřuje krajní úrovně, jedinou hodnotu i shody a netvrdí rovnoměrné rozložení dat uvnitř mezer. Navazující otázka rozšiřuje třetí cvičení; celkem zůstává čtrnáct úloh.

Současně byly upraveny příslušné definice ve slovníčku, do přehledu značení přidány oba výpočetní vztahy a opraven neexistující odkaz `znak-kvantil` na platný `znak-qp`. Nové odborné termíny ani písmenné značky se nezavádějí. Konvence byla znovu ověřena proti oficiální dokumentaci Microsoftu (PERCENTIL.INC) a R (kvantily typu 7); v textu zůstávají existující citace Hyndmana a Fana a Microsoftu. Bibliografické údaje ani počet zdrojů se nemění.

Ověření výpočtů: `check-chapter-03.R` prošel v čisté relaci a nadále kontroluje všechny číselné příklady a čtrnáct řešení. Nově ověřuje všech jedenáct uzlů interpolace, shodu tabulky s daty grafu, 17. percentil, podíl 2/11 a samostatně rozepsaný algoritmus proti `quantile(type = 7)` pro necelé i celé pozice, shody, minimum, maximum a jediné pozorování. Nezávislý výpočet v Pythonu s přesnými zlomky potvrdil pozici 27/10 a kvantil 32/5. Názvy a chování Excelu byly pro tuto úpravu kontrolovány podle dokumentace; desktopový Excel ani nezměněný sešit nebyly znovu spouštěny.
Ověření webu: celá kniha (osm stránek) se úspěšně vykreslila. Závěrečný check-html.cjs prošel v místním Chrome bez chyb: 137 hesel, 32 řešení včetně klávesnice a skrytí/rozbalení, odkazy, navigace, shoda APA citací a bibliografie, MathML bez chyb, žádný viditelný R kód a šířky 1360/1920/390 px bez přetékání celé stránky. Nové řádky vzorců a heslo interpolace byly nalezeny vyhledáváním napříč tabulkou i zpřístupněny odkazem přes nesouvisející filtr. Vizuálně byly prohlédnuty upravené oddíly, citace, tabulka, nový graf a rovnice na desktopu i mobilu. Graf dostal větší popisky pro mobil; srovnávací tabulka používá minimální šířku uvnitř vlastního posuvného kontejneru. Samostatně ověřeno posunutí k poslednímu sloupci a prohlédnut výsledný interpolační vzorec v přehledu značení. git diff --check prošel.

První pokus o spuštění Quarta selhal kvůli mezerám v cestě jeho spouštěče; ověřený krátký tvar cesty fungoval. První webová kontrola neměla v omezeném prostředí přístup k místnímu serveru; po povolení tohoto přístupu prošla. Nejde o chyby studentského obsahu. Ověření platí pro místní Chrome; veřejné nasazení následuje až po uživatelském sloučení a úspěšném publikačním workflow.

## Kapitola 3: srovnání percentilových pořadí (2026-10-09)

Tabulka `tbl-percentilove-poradi` porovnává inkluzivní, exkluzivní a kompromisní pořadí pro původní časy 4, 5, 5, 6 a 10 minut. Obsahuje dosazení všech výpočtů; dvě shodné pětky sdílejí jeden řádek. Poslední sloupec uvádí úrovně kvantilů podle PERCENTIL.INC, nikoli jinou definici pořadí. Pro 5 minut jde o celý uzavřený interval úrovní 25–50 %. Protipříklad s 6 minutami odlišuje kompromisní pořadí 70 od 75. percentilu. Slovníček a přehled vzorců byly doplněny bez nových písmenných značek.

Definice tří pravidel ověřeny v oficiální dokumentaci SciPy `percentileofscore`: odpovídají volbám `weak`, `strict` a `mean`. Výchozí volba SciPy `rank` používá jiné zacházení s pořadími a není zde zaměňována za kompromisní konvenci. Kvantilové úrovně ověřeny proti dokumentaci R pro typ 7. Bibliografie obsahuje nový záznam dokumentace SciPy, celkem 49 zdrojů. Příklad je vlastní, navazuje na již používaná data.

Čistá relace R ověřila všechna pořadí, uzlové kvantily, interval konstantní hodnoty 5 i jeho okolí a kvantily na úrovních 40 a 70 %. Nadále prošly všechny příklady a 14 řešení kapitoly. První spuštění bez nastavení locale selhalo při čtení českého zdroje; po nastavení English_United States.utf8 prošlo. Celá kniha se vykreslila. Excelové vzorce ani sešit se nemění; desktopový Excel nebyl pro tuto úpravu znovu spouštěn. Rozpracované autorské změny kapitoly byly zachovány v hlavní pracovní složce.

Webová kontrola v místním Chrome prošla pro osm stránek, 137 hesel a 32 řešení: odkazy, skrytí a rozbalení řešení, matematika, bibliografie, vyhledávání i zpřístupnění nového řádku vzorců přes filtr. Šířky 1360/1920/390 px nemají přetékání celé stránky; široká tabulka se posouvá uvnitř vlastního kontejneru, ověřeno také šipkou doprava. První test nesprávně použil klávesu End pro vodorovný posun; opraven test, chování tabulky změnu nepotřebovalo. Vizuálně prohlédnut oddíl na desktopu i mobilu a poslední sloupec po posunutí. Vykreslený nový bibliografický záznam a citace byly zkontrolovány. `git diff --check` prošel. Kontrola se týká místního webu; veřejné nasazení nebylo součástí úpravy.

## Kapitola 3: ukazatele středu a tvar rozdělení (2026-10-09)

Nový oddíl `sec-stred-tvar` za srovnáním ukazatelů vysvětluje shodu průměru, mediánu a modu u přesně souměrného jednovrcholového rozdělení s existujícím průměrem a typické pořadí ve dvou zrcadlově zešikmených příkladech. Nezaměňuje toto vodítko za definici šikmosti ani za univerzální pravidlo. Souměrnost sama nezaručuje jediný modus; shoda průměru a mediánu sama nezaručuje souměrnost. Příklady náročného a lehkého testu jsou možnosti, nikoli tvrzení o nutném tvaru jejich výsledků.

Graf je vlastní implementace v base R, inspirovaná didaktickým záměrem uživatelova obrázku; původ obrázku nebyl znám a jeho grafické prvky se nepřebírají. Obsahuje tři přesně definované modely: beta(5,5), beta(5,2) a beta(2,5), všechny na škále 0–100. Nejde o empirická ani náhodně simulovaná data. Průměry jsou 50, 500/7 a 200/7, mediány určuje qbeta, mody jsou 50, 80 a 20. Kontrola nezávisle numericky integruje plochu a první moment, ověřuje polovinu plochy u mediánu a numerickou maximalizací kontroluje modus; ověřuje i zrcadlovost modelů. Typy čar doplňují barvy a odsunuté popisky zabraňují překrývání blízkých značek.

Omezení pravidla byla ověřena v původním článku von Hippela (2005), Journal of Statistics Education, 13(2), DOI 10.1080/10691898.2005.11910556, oddíly 2–3. Nový záznam zvýšil společnou bibliografii na 50 položek; příjmení je chráněno jako celek, aby APA výstup zachoval „von Hippel“. Slovníček má související doplnění a odkazy, nové symboly ani odborné pojmy se nezavádějí. Rozpracované autorské změny kapitoly zůstaly zachovány; u percentilové tabulky byl obnoven identifikátor a nastavení šířek sloupců, které chyběly v pracovním souboru a jsou potřebné pro její dosavadní formátování a kontrolu.

V čisté relaci R prošly všechny výpočty, devět obrázků bylo reprodukováno a nadále prošlo 14 řešení. Celá kniha byla vykreslena. Nový graf byl vizuálně zkontrolován na desktopu i mobilu (390 px); popisky byly upraveny pro čitelnost a odstranění kolizí s osou. Byla zkontrolována výsledná citace a nový bibliografický záznam. Excelový sešit ani vzorce se nemění, desktopový Excel nebyl znovu spuštěn.
Závěrečná webová kontrola v místním Chrome prošla: osm stránek, 137 hesel, 32 řešení, odkazy, klávesnice, skrytí a rozbalení, MathML, bibliografie a šířky 1360/1920/390 px bez přetékání celé stránky. git diff --check prošel. Veřejné nasazení následuje až po uživatelském sloučení; v této úpravě nebylo ověřováno.

## Začlenění úplné autorské redakce kapitoly 3 (2026-10-09)

Do navazujícího commitu byla začleněna veškerá zbývající redakce pracovního souboru kapitoly 3, včetně výkladu průměru bodových skórů a pořadí, ordinálních položek, dílčích terminologických upřesnění a formátování. Její dřívější ponechání mimo commity bylo chybným výkladem pravidla o změnách patřících k úkolu: tyto úpravy byly součástí stejné kapitoly a měly být zahrnuty do předávaného výsledku. Dřívější poznámky o ponechání redakce mimo commit popisují tehdejší stav, nikoli správný pracovní postup.

Obsah kapitoly se při tomto začlenění dále neměnil. Jde o stejný úplný pracovní soubor, na němž v předchozím kroku proběhl render a webová kontrola. Znovu prošla numerická kontrola kapitoly i 14 řešení a git diff --check. Proto nebyl opakován nezměněný render ani vizuální kontrola. Předchozí PR #25 již byl sloučen, oprava proto vychází z aktuálního main a je předána samostatným PR.

<a id="terminologie-robustni-03"></a>

## Kapitola 3: kumulativní kvantily, stupně volnosti a robustní shrnutí (2026-10-09)

Zapracováno šest redakčních připomínek spolu s úplnou souběžnou autorskou redakcí pracovního souboru. PR #26 byl již sloučen, proto větev vychází z aktuálního main. Rozpracované změny kapitoly patří do výsledného commitu. Opraveno také zjevně zdvojené slovo „prostřední“ v úvodu kvantilů a obnoveny identifikátory obou dříve doplněných tabulek, které pracovní redakce opět postrádala.

Nový oddíl ukazuje první dosaženou kumulativní úroveň na časech 4, 5, 5, 6, 10: pro 90 % vrací 10 minut, zatímco PERCENTIL.INC dává 8,4. Motivací je nejnižší limit pokrývající alespoň daný podíl konkrétního souboru; není slibováno pokrytí budoucích účastníků. Druhá tabulka používá již zavedených šest modelových odpovědí odpočatosti z kapitoly 2. Pro 75 % vybírá kategorii „dost“, pro 90 % „zcela“; pro 50 % výslovně volí dolní prostřední kategorii. Změna kódů 1, 2, 3, 4 na 1, 2, 10, 100 ukazuje, proč interpolované kódy 3,5 a 55 nemají doložený význam odpočatosti. Oporou pro rozdílné algoritmy zůstává Hyndman a Fan (1996), ověřeno také podle dokumentace R, quantile, typy 1 a 7.

Percentilové pořadí je vysvětleno jako číselná hodnota procentní stupnice (bez tečky), odlišně od řadového pojmenování „60. percentil“ či „2. pozice“. Na návrh autora jsou zavedeny rozlišující zkratky MeanAD a MedAD; MAD zůstává uvedeno pouze jako nejednoznačná zkratka jiných zdrojů. Robustní (robust) je vyloženo spolu s užší odolností vůči krajním hodnotám (resistance). Stupně volnosti (degrees of freedom) jsou vysvětleny jednou podmínkou nulového součtu odchylek, nikoli vyřazením účastníka nebo tvrzením statistické nezávislosti odchylek. Nové samostatné písmenné značení se nezavádí. Slovníček a přehled vztahů jsou aktualizovány včetně stabilních odkazů.

Pro ořezání a winsorizaci je výslovně zvolena úroveň pro každý konec zvlášť a zaokrouhlení počtu hodnot dolů. Příklad 18 hodnot a 10 % vynechá jednu z každého konce (celkem 11,1 %); u pěti hodnot nevynechá žádnou. Výklad neztotožňuje nominální procento se skutečně upraveným podílem po zaokrouhlení. Medián je krajní případ při úrovni blížící se 50 %; pro přesně 50 % u sudého počtu nejde o průměr prázdného souboru. Pravidla byla ověřena v dokumentaci R mean i jeho zdrojovém souboru mean.R (floor a zvláštní větev pro medián) a v dokumentaci SciPy winsorize (volitelné oříznutí či zaokrouhlení počtu). Nová bibliografie R mean, SciPy winsorize a StatsDirect Degrees of Freedom rozšiřuje seznam na 53 zdrojů. Definice variability a robustnosti ověřeny proti dosavadnímu zdroji NIST Measures of Scale. Výklad nepřebírá případná zjednodušení zdrojů o nutnosti normality pro samotnou korekci rozptylu.

Rozšířena řešení stávajících cvičení 4, 5 a 8; celkový počet zůstává 14. Čistá relace R ověřila kumulativní počty, volbu ordinálních kategorií, oba způsoby kódování, interpolované hodnoty, nulový součet odchylek, zaokrouhlení počtů ořezání a krajní případ mediánu pro sudý i lichý počet. Nadále prošly všechny původní numerické příklady a řešení. Celá kniha se vykreslila. Nové bibliografické záznamy a rozlišení letopočtů stejných autorů byly zkontrolovány. Excelové vzorce ani sešit se nemění; desktopový Excel nebyl znovu spouštěn.
Webová kontrola v místním Chrome prošla na osmi stránkách: 138 hesel, 32 řešení, odkazy, vyhledávání nových pojmů i vzorců, klávesnice, MathML a konzistentní APA bibliografie. Šířky 1360/1920/390 px nemají přetékání celé stránky. Vizuálně zkontrolovány nové tabulky, stupně volnosti, robustnost a ořezání na desktopu i mobilu. Po zkrácení záhlaví ordinální tabulky a doplnění klávesnicového zaměření znovu vykreslena kapitola a cíleně ověřeny obě kumulativní tabulky včetně vodorovného posouvání. git diff --check prošel. Veřejné nasazení nebylo součástí ověření.

## Kapitola 3: význam ukazatelů středu a geometrie odchylek (2026-10-09)

Do srovnání modu, mediánu a průměru byl vložen uživatelem dodaný soubor assets/chapter-03/plots/mode-median-mean.svg, beze změny. Jeho metadata uvádějí autora CMG Lee (Cmglee); původ a licence CC BY-SA 3.0 byly ověřeny na Wikimedia Commons, File:Visualisation mode median mean.svg. Popisek obsahuje citaci, odkaz na licenci i údaj o nezměněném převzetí. Český doprovod vysvětluje anglické popisky, vrchol, poloviny plochy a těžiště; připomíná omezení přesného dělení konkrétních dat se shodami. Bibliografie byla rozšířena na 54 položek. Pro tento jediný negenerovaný podklad je v .gitignore výjimka, aby obrázek existoval také v čistém klonu a veřejném sestavení; ostatní generované grafy se nadále necommitují.

Nový vlastní dvoupanelový graf odchylky-a-ctverce.svg vytváří scripts/kapitola_03.R z dosavadních časů 4, 5, 5, 6, 10. Oba panely mají na ose X číslo pozorování a na Y dobu v minutách; referenční čára je průměr 6 minut. V prvním panelu jsou úsečky a podepsané odchylky, v druhém geometrické čtverce s plochami 4, 1, 1, 0 a 16 min². Poměr měřítek zachovává skutečné čtverce; jejich umístění zabraňuje překryvům. Vodorovná strana je pouze konstrukční délka, nikoli počet pozorování. Text výslovně odlišuje svislou osu v minutách od plochy v min², součet délek 8 od součtu ploch 22 a propojuje graf s MeanAD a rozptylem.

Inspirací je uživatelem dodaná animace https://miro.medium.com/v2/resize:fit:786/format:webp/0*YAqygP_cDwKqEvtf.gif, prohlédnutá přímo v prohlížeči (textový webový nástroj ji neotevřel). Nepřebírá se animace ani její data; v textu je odkaz na vizuální předlohu, jejíž původní autor nebyl z přímého odkazu zjištěn. Dodané místní SVG bylo před použitím prohlédnuto. Generátor používá pouze base R a nepřidává instalace ani studentský kód.

V čisté relaci R prošly všechny výpočty a 14 řešení. Nová kontrola ověřuje odchylky, délky, plochy, jejich součty a napojení stran čtverců na správná pozorování. Celá kniha byla vykreslena; po odstranění kolize popisku nulové plochy byl znovu vykreslen dotčený výklad. Excelové vzorce ani sešit se nemění, desktopový Excel nebyl znovu spouštěn.

Webová kontrola v místním Chrome prošla na osmi stránkách: 138 hesel, 32 řešení, interní odkazy, klávesnice, skrytí a rozbalení řešení i bibliografie. Šířky 1360/1920/390 px nemají přetékání celé stránky. Oba doplněné obrázky byly vizuálně zkontrolovány na desktopu i mobilu. git diff --check prošel. Veřejné nasazení nebylo součástí ověření.

<a id="terminologie-entropie-03"></a>

## Kapitola 3: názorná konstrukce boxplotu a normalizovaná entropie (2026-10-09)

Po sloučení PR #28 vzniká nová větev z aktuálního main. Do výsledku je začleněna i souběžná autorská redakce kapitoly. Její záměr je zachován; opraveny drobné překlepy ve výkladu entropie a doplněna nulová hodnota logaritmu při podílu 1. Obnoveny identifikátory a šířky obou přehledových tabulek, které pracovní redakce odstranila.

Původní malý boxplot nahrazuje vlastní modelový soubor 41 testových skórů, kompletně vypsaný v kapitole a reprodukovaný v R. Uspořádání obrázku je inspirováno uživatelem dodaným schématem, nepřebírá jeho kresbu ani data. Kvartily podle typu 7 jsou na pozicích 11, 21 a 31 a mají hodnoty 40, 50 a 60. IQR je 20, pomocné meze 10 a 90, konce vousů 15 a 85 a samostatné body 2, 5, 95 a 98. Svislý obrázek zobrazuje všechna pozorování, kvartily, medián, IQR, oba úseky délky 1,5 IQR, meze, vousy a podezřelá odlehlá pozorování. Text odlišuje skutečné konce vousů od nejzazšího přípustného dosahu, doplňuje anglické ekvivalenty a zachovává upozornění, že označení není důkazem chyby. Konstrukce byla porovnána s NIST, Box Plot, oddílem Box plots with fences; zůstává zdejší konvence zahrnutí samotné meze mezi přípustné hodnoty.

Na výslovnou žádost autora doplněna normalizovaná entropie jako h/log2(k), bez nového písmenného symbolu. Předem vymezené k zahrnuje i prázdné kategorie; pro k = 1 podíl nedefinujeme. Výklad, slovníček, přehled vztahů a cvičení 13 rozlišují entropii v bitech od bezrozměrného poměru k teoretickému maximu. Příklad dává 0,75 pro čtyři kategorie a přibližně 0,946 pro tři. Citována dokumentace NIST Shannon diversity index (aktualizace 2016-10-07). Její vzorec a krajní hodnoty byly ověřeny výpočtem: stránka obsahuje rozpornou větu o směru změny rozmanitosti, kterou nepřebíráme. Rovnoměrné zastoupení dává hodnotu 1, koncentrace do jediné kategorie 0. Bibliografie nyní obsahuje 55 položek.

V čisté relaci R prošly všechny numerické kontroly i 14 řešení, včetně nových kvartilů, mezí, konců vousů, odlehlých hodnot a normalizace. Celá kniha byla vykreslena. Excelové příklady ani sešit nebyly změněny; desktopový Excel nebyl znovu spouštěn.

Nezávislý výpočet z dat vypsaných přímo v kapitole potvrdil počet 41, příslušné pořadové hodnoty, meze, vousy a odlehlá pozorování; zkontrolován i poměr pro tři kategorie. Webová kontrola v místním Chrome prošla na osmi stránkách (139 hesel, 32 řešení, 55 bibliografických položek), včetně vyhledávání a stabilních odkazů nového pojmu i vzorce, klávesnice, skrytých řešení a matematického zápisu. Boxplot a rozšíření o entropii byly prohlédnuty na desktopu a mobilu. Při šířkách 1360/1920/390 px stránka nepřetéká vodorovně. git diff --check prošel. Veřejné nasazení nebylo ověřováno.

<a id="terminologie-transformace-03"></a>

## Kapitola 3: reportování APA, transformace a shodné momenty (2026-10-09)

Na žádost autora doplněny lineární a nelineární transformace, rovnice y_i = a + b x_i s vysvětlením všech prvků, upozornění na přesnější matematický název afinní a dvoupanelový graf. Vlastnosti polohy nejsou vydávány za univerzální definici všech statistik; záporný násobitel obrací pořadí kvartilů. U variability je odlišeno násobení směrodatné odchylky absolutní hodnotou b od násobení rozptylu b². Druhá mocnina na nezáporných skórech mění stejné rozdíly nestejně; průměr čtverců 40,4 není čtvercem průměru 36. Doplněny přehledy pojmů a vztahů.

Výslovný požadavek na reportování APA je použit jako oprávnění ukázat M, Mdn, SD, N a n v odborné ukázce. Dosavadní výpočetní značení m, x s vlnovkou, s a n se nemění. Oficiální APA Style numbers and statistics guide (2024, s. 2) ověřuje jedno desetinné místo u průměrů a SD celočíselných dat a dvě u ostatních. Značky byly ověřeny v Publication Manual (2020), tabulka 6.5, a desetinný zápis v oddílu 6.36, v dostupné textové kopii https://studylib.net/doc/26191112/apa-2020-7th-ed; citován je vlastní manuál s DOI. Oficiální materiál APA je https://apastyle.apa.org/instructional-aids/numbers-statistics-guide.pdf. Jedno desetinné místo pro procenta je výslovně místní redakční konvence, nikoli údajně závazné univerzální pravidlo APA. Anglická ukázka zachovává desetinnou tečku, kurzivu a procentní znak bez mezery; český výklad českou typografii. Popis tvaru spánku a počtu slov byl ověřen z dat i z existujícího histogramu a tečkového grafu kapitoly 2. Přirozená nula je odlišena od grafické zásady nulové základny sloupců.

Nová vlastní ilustrace inspirovaná principem uživatelova obrázku používá tři přesné populační modely: hodnoty −1 a 1 s pravděpodobnostmi 1/2, standardní normální rozdělení a gama rozdělení se shape = 4 a rate = 2 posunuté o −2. Všechny mají průměr 0 a rozptyl 1. Sloupce představují přesné pravděpodobnosti intervalů šířky 0,2, nikoli simulované četnosti; integrační kontrola ověřuje momenty celých rozdělení. Vodorovné osy jsou shodné, svislé se pro čitelnost tvarů liší, což výslovně uvádí popisek. Chvosty pokračující mimo výřez jsou vysvětleny. Původní šestiprvkové příklady a navazující popis modelu byly nahrazeny společně.

Zahrnuta je úplná průběžná autorská redakce kapitoly, včetně přeformulování ordinálního mediánu. Opraveny její drobné překlepy a obnoveny stabilní identifikátory tabulek. Čistá relace R ověřila všechny výpočty a 14 řešení, nové transformace a integračně oba spojité modely. Celá kniha byla vykreslena; po úpravě měřítek grafu znovu dotčená kapitola. Bibliografie má 57 položek. Excelové vzorce ani sešit se nemění, desktopový Excel nebyl znovu spouštěn.

Webová kontrola v místním Chrome prošla na osmi stránkách: 142 hesel, 32 řešení, vyhledávání a odkazy nových pojmů a vztahů, klávesnice, matematický zápis a bibliografie. Vizuálně zkontrolovány oba nové grafy, výklad transformací a ukázka APA na desktopu i mobilu. Po spojení dvou sousedních závorek v anglické ukázce znovu vykreslena kapitola a cíleně zkontrolována konečná ukázka a oba grafy při 1360 a 390 px. Kontroly neodhalily vodorovné přetékání celé stránky. git diff --check prošel. Veřejné nasazení nebylo ověřováno.

<a id="terminologie-poradove-03"></a>

## Kapitola 3: české reportování a zpřesnění výkladu (2026-10-09)

Zapracováno šest připomínek spolu s úplnou průběžnou autorskou redakcí. Obrácené skórování výslovně dosazuje a = 10, b = −1. Pořadové statistiky v užším smyslu jsou odlišeny od interpolovaných kvantilů na již ověřeném příkladu 90. percentilu 8,4. Přidána významově shodná česká ukázka reportování s kurzivními značkami APA, desetinnými čárkami a středníky. Středník je vysvětlen jako přizpůsobení české typografii, nikoli univerzální příkaz anglického manuálu APA. Pro kontext byly ověřeny české redakční pokyny https://dl1.cuni.cz/pluginfile.php/1314842/mod_resource/content/1/APA_7_2021_11_18.pdf (verze listopad 2021), které výslovně rozlišují české úpravy od původní normy, a jazyková příručka https://prirucka.ujc.cas.cz/?id=173. Zvolený středník pro tuto ukázku je místní redakční rozhodnutí.

U tří populačních modelů výklad odlišuje počet různých hodnot od rozptýlenosti měřené rozptylem; dvoubodový model má průměr čtvercových odchylek 1. Závěr oddílu přirozeněji odlišuje to, co jsme vypočítali z dat, od předpokladů o tvaru rozdělení. Opraven překlep „tranformaci“ a obnoveny stabilní identifikátory dvou tabulek odstraněné pracovní redakcí. Nové pojmy ani značení nejsou zaváděny. Čistá relace R ověřila všechny příklady a 14 řešení, dotčená kapitola byla vykreslena. Grafy, Excelové vzorce ani sešit se nemění; desktopový Excel nebyl znovu spouštěn.

Webová kontrola osmi stránek v místním Chrome prošla: 142 hesel, 32 řešení, odkazy, klávesnice, skrytí a rozbalení řešení, matematika a šířky 1360/1920/390 px bez přetékání stránky. Česká ukázka byla vizuálně prohlédnuta na mobilu. git diff --check prošel. Veřejné nasazení nebylo ověřováno.

## Kapitola 3: jasné rozlišení konvencí kvantilů (2026-10-09)

Na základě dohodnuté formulace je PERCENTIL.INC označena jako hlavní konvence pro číselná data, přirozená zejména u spojitých proměnných, ale použitelná i u diskrétních číselných hodnot. Kvartil 5,75 slova nemusí být pozorovatelným výsledkem, aby sloužil jako číselná hranice. U čistě ordinálních kategorií chybí podklad pro interpolaci rozdílů mezi kódy; jako zdejší postup je výslovně zvolen první dosažený kumulativní podíl. Ten lze použít i pro spojitou proměnnou, pokud potřebujeme pozorovanou hodnotu. Oba oddíly mají výstižnější názvy a zachované identifikátory. Slovníček a přehled značení byly sjednoceny s tímto rozlišením; odstraněna příliš široká formulace o „všech výpočtech kvartilů“ v oddílu boxplotu.

Doplněn případ úrovně nižší nebo rovné kumulativnímu podílu minima: pro p = 0,1 a 0,2 vychází 4, pro p = 0,25 vychází 5. Nové výsledky i všechny dosavadní příklady a 14 řešení ověřila čistá relace R. Zahrnuta celá souběžná autorská redakce, opravena nadbytečná předložka u řazení a obnoveny stabilní identifikátory tabulek. Excelové příklady ani grafy se nemění; desktopový Excel nebyl znovu spouštěn.

Render celé knihy a webová kontrola osmi stránek prošly: 142 hesel, 32 řešení, odkazy, klávesnice, matematika i šířky 1360/1920/390 px bez přetékání celé stránky. Změněné oddíly byly prohlédnuty na mobilu. git diff --check prošel. Veřejné nasazení nebylo ověřováno.

## Kapitola 3: význam řádu momentu (2026-10-10)

Při zavedení momentů je nyní výslovně vysvětleno, že řád určuje mocninu. Příklady rozlišují první, druhý a třetí řád i druhý moment kolem nuly od druhého centrálního momentu. Stejné upřesnění je v dosavadním hesle slovníčku; nové značení se nezavádí.

Zahrnuta souběžná autorská redakce výkladu šikmosti a špičatosti. Opraven překlep „mocnic“ a poslední čtverec odchylky v rozepsaném příkladu: 4² = 16, takže součet čtverců zůstává 22. Obnoveny stabilní identifikátory a šířky dvou tabulek odstraněné pracovní redakcí. Čistá relace R ověřila všechny numerické příklady a 14 řešení; celá kniha byla vykreslena. Excelové příklady ani grafy se nemění; desktopový Excel nebyl znovu spouštěn.

Webová kontrola osmi stránek prošla: 142 hesel, 32 řešení, vnitřní odkazy, ovládání klávesnicí, skrytí a rozbalení řešení a šířky 1360/1920/390 px bez chyb. Upravené rozšíření bylo vizuálně prohlédnuto na desktopu i mobilu. git diff --check prošel. Veřejné nasazení nebylo ověřováno.

## Revize projektových instrukcí a rozdělení dokumentace (2026-10-10)

Po společném projednání a výslovném souhlasu autora jsou pravidla pro výklad a ověřování ponechána pohromadě v kořenovém AGENTS.md. Nevznikají samostatné VYKLAD.md, OVEROVANI.md, GOALS.md ani PLANS.md. Do docs/PREZENTACE.md se přesouvají veškerá dosavadní pravidla pro prezentace, poznámky a exporty; mění se pouze úroveň nadpisů a relativní odkaz na společná pravidla. Kořenové instrukce určují, kdy načíst další dokumenty, bez povinnosti číst všechny při každém úkolu.

Nový docs/ROZHODNUTI.md eviduje šest skupin doložených konvencí s rozsahem, důvodem a dokladem: značení/reportování, indexy/četnosti, hranice intervalů, kvantily/boxplot, zaokrouhlování a robustní shrnutí. Nejde o úplný slovníček. Nový docs/OSNOVA.md shrnuje obsah a cíle současných tří kapitol, návaznosti, základní a nepovinný rozsah; budoucí náměty výslovně nejsou vydávány za schválené kapitoly. Starší záznamy této historie zůstávají zachovány a jsou doplněny odkazem na současné přehledy.

Opraveny dva doložené nesoulady: cesta k hlavní učebnici nyní odpovídá existujícímu sources/učebnice/howell.pdf; větu o neexistenci výjimek ve značení nahrazuje vymezení schválených ukázek APA, bez změny výpočetního m a dalších dosavadních symbolů. Jsou připomenuty i rozlišující zkratky MeanAD a MedAD. Nové odborné značení se nezavádí.

Před návrhem nové kapitoly se musí posoudit aktuální soubory v sources/ včetně podsložek: další učebnice, autorovy starší prezentace, příklady k procvičování a ostatní podklady. U relevantních materiálů se mají prostudovat odpovídající části a při projednávání uvést využití, podstatné rozpory a případné mezery v přístupu. Howell zůstává hlavním východiskem. Tato revize instrukcí ověřila umístění souborů, není novou odbornou rešerší jejich obsahu.

Didaktická revize nově ukládá hledat chybějící myšlenkové kroky, nevysvětlené pojmy, nevyřčené předpoklady, záměny pojmů a chybějící interpretace. Zahrnuje návaznosti, účel příkladů a grafů, přípravu na cvičení a jazykovou čitelnost. Rozsah odpovídá změně; běžné opravy v dohodnutém rozsahu nepotřebují nové schvalování. Nové pojmy, změny značení a rozšíření nadále podléhají dohodě. Nevzniká povinnost vkládat samostatná cvičení do výkladu a interní revize není vydávána za ověření porozumění na studentech.

### Mapa zachování pravidel a kontrola

| Původní část AGENTS.md | Výsledek |
|---|---|
| Cíl a cílová skupina; příprava každé kapitoly; didaktika a jazyk; výpočty; cvičení; tři přehledy; ověřování Quarto Book; Git | Osm oddílů obsahově i textově zachováno. |
| Zdroje | Opravena cesta a rozšířen postup posouzení podkladů; ostatní požadavky zachovány. |
| Terminologie a značení | Nahrazena zastaralá věta o výjimkách; doplněn odkaz na vymezení reportování a zkratek. |
| Studentský text a autorská dokumentace | Zpřesněno rozdělení historie, platných rozhodnutí a osnovy. |
| Prezentace a poznámky | Úplný přesun do docs/PREZENTACE.md s výslovným načtením z kořenových instrukcí. |
| Nové oddíly | Použití projektové dokumentace a didaktická revize. |

Přímé porovnání proti výchozímu origin/main potvrdilo úplnost přesunu prezentací (po normalizaci úrovně nadpisů a odkazu na AGENTS.md) a nezměněný obsah osmi zachovaných oddílů. Kontrola 42 místních Markdown odkazů v šesti dotčených dokumentech potvrdila existenci cílů a explicitních kotev. Ověřeno UTF-8, cesta k Howellovi, odstranění obou zastaralých formulací a soulad osnovy a konvencí s aktuálními kapitolami a historickými doklady. git diff --check prošel.

Mění se pouze instrukce a autorská dokumentace; kapitoly, data, prezentace ani konfigurace webu se nemění. Podle pravidla pro tento druh změny nebyl spouštěn render, numerické ani excelové kontroly a vizuální kontrola webu. Veřejné nasazení nebylo ověřováno. Nejde o novou didaktickou revizi samotných kapitol.

<a id="priprava-kapitoly-4"></a>

## Příprava kapitoly 4: normální rozdělení a standardní skóry (2026-10-10)

Autor dohodl zaměření kapitoly 4 na polohu výsledku a z-skór, normální
model, podíly jako plochy, převody mezi hodnotami a podíly a další standardní
skóry včetně stenů a staninů. Podrobnou pravděpodobnost chce ponechat
následující kapitole. Současně požádal o posouzení všech učebnic a nově
přidané krátké přednášky `normal_distribution.pptx` a o podrobnou osnovu.
Tento dohodnutý rámec je zapsán do `docs/OSNOVA.md`; členění, cíle, příklady,
terminologie, značky, Excel a nepovinná rozšíření jsou výslovně návrhem,
nikoli dodatečně přisuzovaným schválením. Studentská kapitola ani zápisy
do závěrečných přehledů zatím nevznikají.

### Rozsah posouzení učebnic

Byl znovu zjištěn úplný obsah `sources/` včetně podsložek. Všech deset
PDF v `sources/učebnice/` bylo čitelných. Posouzení zahrnulo jejich
obsahy a relevantní výkladové pasáže uvedené níže, nikoli přečtení všech
knih od začátku do konce. Strany v tabulce jsou tištěné stránky knih;
u digitálního Navarra jde o číslování dodané PDF verze. Automatická
extrakce místy poškodila matematické znaky, zejména u Judda; přesný
matematický zápis proto není přebírán z poškozené extrakce.

| Podklad | Prostudované relevantní části | Navržené využití a hranice |
|---|---|---|
| Howell, *Statistical Methods for Psychology*, 8. vyd., 2013, Wadsworth Cengage Learning; `howell.pdf` | Kap. 3, zejména 3.1–3.6, s. 66–79. Titul a vydání ověřeny v titulních a vydavatelských údajích, ISBN 978-1-111-83548-4. | Hlavní opora: normální model, standardizace, plochy, centrální interval a jiné standardní skóry. Q–Q graf z 3.5 jen nepovinně. Howell výslovně odlišuje interval jednotlivých hodnot od intervalu spolehlivosti průměru. |
| Gravetter a Wallnau, *Statistics for the Behavioral Sciences*, 10. vyd., `gravetter.pdf` | Kap. 5, zejména s. 135, 141–148; normální plochy v oddílu 6.2, s. 165–166. | Podrobná intuitivní interpretace z-skóru, zachování tvaru, změna měřítka a odlišení výběrové a populační standardizace. Podporuje zařazení z-skóru před normální model. |
| Aron, Aron a Coups, *Statistics for Psychology*, 6. vyd., Pearson New International Edition, 2014; `aron.pdf` | Kap. 3, s. 75–81 a 84–87. | Relativní poloha osoby, převody tam a zpět, kresba a hrubý odhad před výpočtem, závěrečná kontrola smyslu výsledku. Statistické tabulky nahradit Excelem. |
| Cumming a Calin-Jageman, *Introduction to the New Statistics*, 2. vyd., 2024; `cumming.pdf` | Kap. 4, s. 74–81. | Přechod od spojitého modelu k plochám, vliv parametrů, rozdíl z-skóru a normality, meze modelu u ohraničených dat a v chvostech; zaokrouhlené skóry jako možné rozšíření. Následující výběrová rozdělení odložit. |
| Diez, Çetinkaya-Rundel a Barr, *OpenIntro Statistics*, 4. vyd., 2019; `diez.pdf` | Oddíl 4.1, s. 133–141. | Přehledná posloupnost otázek pod/nad/mezi a inverzní úlohy; kresba a kontrola výsledku. Nepřebírat časově specifické normy SAT jako aktuální empirický fakt. |
| Dostál, *Statistické metody v psychologii*; `dostal.pdf` | Oddíl 2.7, s. 31–37, zejména 2.7.2–2.7.3. | Česká terminologie, grafická interpretace hustoty a distribuční funkce. Matematickou formulaci i příliš široká zobecnění o normalitě přizpůsobit cíli; limitní větu nezařazovat. |
| Navarro, *Learning Statistics with R*; `navarro.pdf` | Oddíl 5.6, s. 191–193; oddíl 9.5, zejména s. 387–392. | Oddělení standardizace od normality, srozumitelné psychologické příklady a vliv parametrů. R kód ani delší matematické odbočky nepatří do studentského výkladu. Rok nové digitální verze nebyl odvozován z názvu souboru. |
| Privitera, *Statistics for the Behavioral Sciences*, 4. vyd., 2024; `privitera.pdf` | Kap. 6, s. 192–198 a 207–209; přehled návaznosti oddílů kapitoly. | Výslovné cíle a odstupňované převody hodnot a podílů. Nepřebírat obecná tvrzení o normalitě většiny chování ani hodnocení výsledků mimo dvě odchylky jako „nenormálních“ bez rozlišení významů. Binomická aproximace mimo rozsah. |
| Judd, McClelland a Ryan, *Data Analysis: A Model Comparison Approach to Regression, ANOVA, and Beyond*, 3. vyd.; `judd.pdf` | Kap. 3, úvod s. 25 a související výklad normálního modelu s. 29–32. | Autorská opora pro důsledné oddělení dat, modelu a předpokladů. Rozdělení chyb modelu, regrese a limitní argumentace jsou pro tuto kapitolu předčasné. |
| Sahu, *Introduction to Probability, Statistics & R: Foundations for Data-Based Sciences*, 2024; `sahu.pdf` | Oddíl 7.2: s. 125–126 a 130–135, zejména standardní normální model, převody a kvantily. | Technická kontrola vztahů, parametrů a rozdílu jednostranné a oboustranné hranice. Integrální odvození, programování a další rozdělení vynechat. |

Zdroje mají odlišné pořadí. Howell přechází od modelu ke standardizaci;
Gravetter a Navarro vykládají z-skóry odděleně dříve. Navržené pořadí
navazuje na transformace v naší kapitole 3 a zachovává Howellovo jádro
normálního modelu a jeho aplikací. Nejde o požadavek převzít součet témat
ze všech deseti knih.

Důležitý skutečný rozdíl je parametrizace zápisu normálního rozdělení:
OpenIntro užívá ve druhé pozici směrodatnou odchylku, zatímco Howell,
Dostál a Sahu rozptyl. Jde o různé konvence, nikoli různé modely.
Návrh proto ponechává kompaktní zápis mimo povinné minimum; pokud bude
zaveden, musí být jeho význam jednoznačně dohodnut. Slovo standard score
také může znamenat přímo z-skór nebo širší rodinu převedených skórů;
navrženo je druhé pojetí s jasným rozlišením konkrétních škál.

### Přednášky, procvičování a další podklady

Nová `sources/starší přednášky/normal_distribution.pptx` má 22 snímků.
Byl přečten jejich text a prohlédnuty vybrané vložené grafy normální
křivky, ploch, převodních škál a Q–Q grafů. Nebyl prováděn úplný render
a kontrola vzhledu prezentace v PowerPointu. Hlavní obsah dobře odpovídá
záměru: parametry, standardizace, plochy, jiné skóry a Excel. Následující
body se nesmějí automaticky převzít do nové kapitoly:

- Snímek 4 uvádí kurtosis = 0 bez odlišení excesu. Pro normální model
  je standardizovaný čtvrtý centrální moment 3, exces 0; navázat na již
  vysvětlené rozlišení v kapitole 3 a neopakovat celou momentovou odbočku.
- Snímek 21 označuje rozsah ±1,96 odchylky za „95% interval spolehlivosti“.
  Zde jde o prostředních přibližně 95 % jednotlivých výsledků modelu,
  nikoli o nejistotu odhadu populačního průměru.
- Snímky 15, 17 a 18 potřebují důsledné odlišení percentilu, jeho úrovně
  a percentilového pořadí. Rozmezí z-skórů nelze přiřadit jedinému
  percentilovému pořadí. Hodnoty ±2 odpovídají přibližně 2,28. a 97,72.
  percentilu, nikoli přesně 2,5. a 97,5.
- Steny a staniny potřebují hranice kategorií a ztrátu přesnosti,
  nikoli pouze uvedení středu a směrodatné odchylky. Spojitý lineární
  mezivýsledek není totožný s konečnou kategorií.
- Centrální limitní věta a výběrová rozdělení na snímcích 5–6 přesahují
  dohodnuté zaměření. Formální testy normality a mechanická pravidla
  typu absolutní šikmost pod 1 nebo 2 ze snímku 13 nejsou vhodným
  povinným rozhodovacím postupem pro tuto kapitolu. Pořadové vzorce
  pro konstrukci Q–Q grafu ze snímku 22 jsou zde nadbytečné.
- Příklad s pojmenovaným klinickým nástrojem a parametry 50 a 10
  není nezávisle ověřeným dokladem skutečných norem tohoto nástroje.
  Navržený výklad použije jasně označený vlastní modelový příklad.

Starší `PSYb1170_P03_2026_-_Transformace__rozdeleni_pravdedpodobnosti_.pptx`
spojuje standardizaci, normální model, pravděpodobnost a další návaznosti;
pro tuto kapitolu využít jen odpovídající části. Přednášky P01 a P02
slouží hlavně ke kontrole návaznosti na již probrané četnosti a popis.

Z `sources/příklady k procvičování/ulohy_tyden03_2024.docx` jsou relevantní
zvláště úlohy X3_04–X3_07 a blok normálního rozdělení a kvantilů od X3_21;
pravděpodobnostní část ponechat další kapitole. Starší listy týdnů 1–2
slouží k návaznostem, jejich obsah se nemá znovu přidávat. Příklady
ze `Seminar4_-_na_zed_-_2024.pptx` jsou vhodnou inspirací pro porovnání
relativní polohy, nelineární vztah percentilového pořadí a z-skóru a Excel.
Otázky na „větší talent“ přeformulovat podle toho, co z dat skutečně
plyne. `NORM.S.DIST` vrací kumulativní podíl, nikoli hodnotu kvantilu;
tuto terminologii ve starším semináři zpřesnit při případném převzetí.
Podklady nejsou vydávány za již opravené ani celé numericky přezkoušené.

V `sources/ostatní zdroje/Normalni_rozdeleni_do_3_aveamian._prednasky.xlsx`
byly přečteny listy, popisy a vzorce: plochy, hustota, převody z/T/IQ
a kvantily. Potvrzuje důraz autora na porozumění převodům a použití
kalkulátoru místo tištěných tabulek. Sešit nebyl přepočten v desktopovém
Excelu ani kompletně vizuálně kontrolován; má být inspirací pro nové
samostatně použitelné příklady, nikoli hotovým ověřeným studentským sešitem.

U zbývajících souborů bylo ověřeno zaměření. Podklady k datové matici,
kódování proměnných a Lordově příkladu fotbalových čísel nerozšiřují
jádro této kapitoly. Baronovy kapitoly o normativní a deskriptivní
pravděpodobnosti patří do budoucí přípravy pravděpodobnosti; jde
o skenované PDF, u nichž byly vizuálně posouzeny úvodní části, nikoli
přečten celý text. Obdobně byl výběrově prohlédnut Uttsové text o
statistické gramotnosti, včetně záměny podmíněných pravděpodobností;
pro tuto kapitolu je jen širším kontextem. Tyto omezené průchody nejsou
vydávány za úplnou rešerši uvedených článků či za chybějící kontrolu
některé z deseti učebnic.

### Doplňující primární zdroje a ověření návrhu

Základní vlastnosti a rozlišení kurtosis/exces byly porovnány s
[NIST: Normal Distribution](https://www.itl.nist.gov/div898/handbook/eda/section3/eda3661.htm).
Použití dalších škál bylo ověřeno v primárních materiálech vydavatelů:
[SHL, ukázková zpráva Verify Interactive](https://service.shl.com/docs/Verify%20Interactive%20Ability%20Report%20DNI%20UKE.pdf)
uvádí steny a T-skóry;
[GL Education, CAT4 Quick Data Guide](https://support.gl-education.com/knowledge-base/assessments/cat4-support/after-the-test/quick-data-guide)
vymezuje staninové kategorie;
[Pearson, výklad standardních a vážených skórů](https://www.pearsonclinical.co.uk/featured-topics/aa-and-the-dsa.html)
uvádí škály 100/15 a 10/3. Nejde o oprávnění zaměňovat normy různých
konkrétních testů nebo vydávat každý převod 100 + 15z za IQ.

České názvy a účel čtyř navržených funkcí byly ověřeny v dokumentaci
Microsoftu:
[NORM.S.DIST](https://support.microsoft.com/cs-cz/excel/functions/norm-s-dist-function),
[NORM.S.INV](https://support.microsoft.com/cs-cz/excel/functions/norm-s-inv-function),
[NORM.DIST](https://support.microsoft.com/cs-cz/excel/functions/norm-dist-function),
[NORM.INV](https://support.microsoft.com/cs-cz/excel/functions/norm-inv-function).
Dokumentační kontrola není vydávána za provedení budoucích příkladů
v českém Excelu.

Nezávislý výpočet normální distribuční a kvantilové funkce ověřil
číselné hodnoty použité při posouzení: prostřední podíly pro ±1, ±2
a ±3 jsou přibližně 0,6826895, 0,9544997 a 0,9973002; pro ±1,96
přibližně 0,9500042. Kvantily úrovní 0,90, 0,95 a 0,975 jsou
přibližně 1,281552, 1,644854 a 1,959964. Pro ideální staninové kategorie
s hranicemi ±0,25, ±0,75, ±1,25 a ±1,75 odpovídají zaokrouhlené
procentní podíly 4–7–12–17–20–17–12–7–4; jejich přesná směrodatná
odchylka je přibližně 1,944, proto se 2 nemá vydávat za přesnou
vlastnost každého kategorizovaného souboru. Výpočty nejsou nově
schválenými konvencemi studentského výkladu.

Didaktické posouzení návrhu hlídá vstupní znalosti a rozsah: nejprve
z-skór jako popis, poté model a plochy, až následně přesné převody
a jejich aplikace. Předpoklady normality jsou výslovně připojeny
k převodům na modelové podíly. Rozlišení standardizace a normalizace
má být krátké; Q–Q graf zůstává nepovinný. Jde o autorské posouzení
osnovy, nikoli o ověření porozumění na studentech.

Změny se týkají pouze osnovy a tohoto historického záznamu. Studentský
web, zdrojové prezentace a sešit ani konvence v `docs/ROZHODNUTI.md`
se nemění. Kontrola dokumentace ověřila UTF-8, místní odkazy včetně
explicitní kotvy tohoto záznamu, rozlišení dohodnutého a navrženého
obsahu a `git diff --check`. Render knihy, webové a mobilní kontroly
ani desktopový Excel nebyly pro tuto dokumentační změnu spouštěny;
veřejné nasazení nebylo ověřováno.

## Kapitola 4: schválení názvu normované normální rozdělení (2026-10-10)

Autor výslovně schválil „normované normální rozdělení“ jako používaný
český název pro standard normal distribution. V osnově byl nahrazen
původní návrh „standardní normální rozdělení“ a odlišena tato schválená
položka od dosud projednávaných termínů. Rozhodnutí R07 eviduje rozsah,
důvod a nahrazené doporučení; původní historický záznam přípravy zůstává
zachován.

Pro budoucí heslo studentského slovníčku jsou v osnově zaznamenány
alternativy „standardní normální rozdělení“ a „standardizované normální
rozdělení“ i dohodnuté jazykové vysvětlení: první varianta je doslovnější
překlad, ale blízký běžný význam obou přídavných jmen může působit
kostrbatě. Nejde o tvrzení, že je alternativní odborný název chybný.
Studentský slovníček se doplní současně s prvním výkladem v dosud
nevytvořené kapitole; nevzniká předčasný odkaz na neexistující kapitolu.

Změna se týká pouze tří autorských dokumentů. Ověřeny rozdíly, UTF-8,
místní odkazy a výskyty termínu v osnově; git diff --check prošel.
Render, numerické, excelové ani webové kontroly se pro tuto
terminologickou změnu autorské dokumentace nespouštěly.

## Kapitola 4: souhlas se zbývající terminologií (2026-10-10)

Po diskusi autor přijal jednoduché označení IQ-skóry s upozorněním,
že škála 100/15 může vyjadřovat i výsledky jiných než inteligenčních
testů; změna měřítka nemění měřenou vlastnost. U subtestových skórů
schválil označení standardní subtestové skóry. Alternativa vážené skóry
zůstává pro slovníček a vysvětlení při prvním výkladu, aby ji studenti
nezaměňovali za vážený součet či průměr položek nebo subškál.

Autorův souhlas se zbytkem terminologie je zaznamenán jako R08.
Osnova používá schválené názvy v tematickém oddílu i přehledu pojmů;
upozorňuje také, že chvost rozdělení byl již zaveden v kapitole 2.
Nové symboly, konečná podoba osnovy, příklady a rozsah nepovinných témat
nadále zůstávají k dohodě; souhlas s terminologií je nepotvrzuje.

Při předchozí diskusi byl doložen starší anglický termín weighted scores
v názvu článku A critique of the Wechsler-Bellevue system of weighted
scores (1949), https://pubmed.ncbi.nlm.nih.gov/18118257/. To umožňuje
uvažovat i o přímém překladu z angličtiny, ale neprokazuje skutečnou
cestu převzetí do češtiny. Německý či ruský původ není doložen a nebude
vydáván za fakt. Odkaz a omezení jsou zaznamenány v osnově.

Kontrola tří upravených autorských dokumentů ověřila UTF-8, místní
odkazy včetně kotev, soulad názvů a rozlišení schválených termínů
od návrhů značení a obsahu; git diff --check prošel. Studentské kapitoly,
slovníček ani web se nemění, render a numerické či webové kontroly
se proto nespouštěly. Přehledy se doplní spolu s prvním výkladem.

## Kapitola 4: vytvoření výkladu, 2026-10-10 {#vytvoreni-kapitoly-4}

Autor schválil tvorbu kapitoly a navrženou posloupnost s výslovnými
dodatky: zařadit N(μ, σ²) a povinné posouzení přiměřenosti modelu včetně
čtení i tvorby normálního Q–Q grafu. R09 v přehledu rozhodnutí nahrazuje
dřívější návrh obě témata odložit nebo ponechat nepovinná. R07 a R08
zůstávají v platnosti. Osnova nyní rozlišuje realizovanou kapitolu od
dosud nedohodnuté následující kapitoly o pravděpodobnosti.

Vznikl souvislý výklad v `kapitola_04.qmd`, dvanáct původních SVG obrázků
generovaných v základním R, deset samostatných úloh s úplnými sbalenými
řešeními a dvoulistový sešit `data/kapitola_04.xlsx`. List `Model` spojuje
převody ploch a kvantilů, list `QQ` ukazuje 12 pořadí, výpočet kvantilů
a upravitelný bodový graf. Malý soubor je také v CSV. Doplněny jsou všechny
tři přehledy, navigace, bibliografie, generátor a automatické kontroly.

### Odborná a didaktická rozhodnutí při psaní

Výklad vychází z předchozího posouzení všech deseti učebnic a autorských
podkladů, zaznamenaného výše v přípravě kapitoly. Howell (2013), kapitola 3,
s. 66–79, zůstává hlavní oporou; znovu byly přečteny s. 75–78 pro povinné
Q–Q grafy. Jeho výklad směrů os není jednotný, proto nová kapitola vždy
explicitně používá normální kvantily vodorovně, data svisle. Neopisuje
idealizovanou úvahu, že nejvyšší hodnota konečného souboru má konečný
100. normální percentil, ani nepředkládá 45° úhel jako obecnou podmínku.

Pořadové polohy (i − 0,5)/n jsou zvolenou jednoduchou konstrukcí pro
výuku (dokumentace R `ppoints`, parametr a = 0,5); přímka m + sz dává
přímou návaznost na již vysvětlený zpětný převod. Nejde o novou konvenci
empirických kvantilů nebo percentilových pořadí. Čtení průběhu doplňuje
NIST, oddíl Normal Probability Plot. Jiná poloha os, polohovací vzorec
nebo kvartilová přímka v programu nemusí znamenat chybu.

Ilustrační skór pozornosti s μ = 50 a σ = 10, všechny malé soubory,
úlohy i grafy jsou původní autorské konstrukce; nejsou vydávány za
Achenbachovy normy ani za reálná výzkumná data. Simulované diagnostické
obrázky používají seed 20261010 a po 200 hodnotách: normální rozdělení,
posunuté exponenciální rozdělení, symetrické t rozdělení se třemi stupni
volnosti a směs dvou normálních skupin. Názvy těchto dalších modelů se
studentům předčasně nezavádějí; obrázky slouží k interpretaci tvaru.

Plochy začínají vysvětlením výšky histogramu a plochy obdélníku, aby
nevyžadovaly nepovinné učivo kapitoly 2. Hustota a distribuční funkce
mají samostatně porovnané grafy. Odlišujeme výsledek spojitého modelu,
zaokrouhlený skór a diskrétní počet. Prostřední 95% interval se vztahuje
k jednotlivým hodnotám při zadaném modelu, nikoli k nejistotě průměru.
Zařazení mimo dvě odchylky není diagnostickým rozhodnutím. Standardizace
nemění šikmost a větší soubor nenormalizuje původní hodnoty.

Parametry 10/3 ověřuje Pearson Clinical Assessment's Scientific Council
(2023), s. 4; nepřebírá se tamní příliš široké tvrzení, že každé standardní
skórování vytváří normální křivku. SHL (2019), s. 6, dokládá měřítko stenů,
GL Assessment staniny. Podíly pásem byly vypočteny nezávisle z normálního
modelu, nikoli převzaty jako zaokrouhlená percentilová pásma konkrétního
testu. Přesné hraniční hodnoty používají dolní vyloučenou/horní zahrnutou
mez z R03, což je v textu uvedeno; skutečné testy se řídí svým manuálem.
Například přesné z = 0 zde dává sten 5, přestože jiné normy při zaokrouhlení
mohou dát 6. Původ výrazu „vážený skór“ se historicky nespekuluje.

České názvy čtyř normálních funkcí ověřila oficiální dokumentace Microsoftu
a skutečný Excel 16.0. U NORM.S.DIST s NEPRAVDA text uvádí hustotu,
nepřebírá chybný český popisek „hromadná pravděpodobnostní funkce“.
NORM.DIST a NORM.INV přijímají odchylku; N(μ, σ²) zapisuje rozptyl.

Didaktická revize sledovala návaznost referenční skupina → z-skór →
model → plocha → kvantil → škály → Q–Q graf. Vysvětlila význam μ a σ,
každého kroku inverzního převodu i rozdíl pořadové polohy pro graf od
empirického percentilového pořadí. Úlohy pokrývají výpočet, interpretaci,
práci s modelem i opravu argumentu; jejich řešení obsahují mezikroky.
Tato interní revize není ověřením porozumění na studentech.

### Ověření

Průběžně prošel plný render knihy v Quarto 1.9.38 / R 4.5.1, numerické
kontroly všech čtyř kapitol a skutečné české vzorce v Excelu 16.0.
Kontrola sešitu porovnala všechny pořadové polohy, inverzní převody,
krajní chybové argumenty, změny vstupů i datové vazby bodového grafu.
Oba listy byly prohlédnuty v náhledu i po nativním exportu Excelu.
Webová kontrola zachytila vodorovné přetékání nové tabulky a dlouhých
vzorců na mobilu; opravily se zdroje, nikoli generované HTML.
Závěrečná kontrola webu prošla na všech 9 stránkách: všechny místní odkazy,
159 hesel slovníčku, všech 42 řešení (včetně deseti nových), stránkování
a hledání v přehledech, odkazy přes aktivní filtr, klávesnice, mobilní
šířka 390 px, desktop 1360/1920 px a náhradní chování bez JavaScriptu
i při otevření souboru. Řecké μ a σ mají v renderovaném MathML stojatý
řez; matematika neobsahuje chyby a kód R není zobrazen. Prohlédnuty byly
všechny nové obrázky, nové citace, klíčové oddíly na desktopu a mobilu
i oba listy sešitu. Podrobné obrázky na mobilu ponechávají čitelné
měřítko a posouvají se uvnitř samostatné oblasti, stejně jako široké
tabulky. Webová kontrola zároveň ověřila jejich posun.

Finální sešit znovu prošel nativní kontrolou po zavření a otevření,
bez ukládání testovacích změn. Soubor ve vykresleném webu se shoduje
s finální verzí v `data/`. Kontrola UTF-8 a `git diff --check` prošla.
Vznikl samostatný kontrolní skript kapitoly a jeho zapojení do CI;
desktopový Excel se spouští místně, nikoli v linuxovém CI. Lokální
výsledek sám nepotvrzuje publikování na GitHub Pages; změna je připravena
v tematické větvi `codex/chapter-04` pro uživatelovu kontrolu a sloučení.

## Kapitola 1: revize po posouzení (2026-10-11)

Na žádost autora proběhlo posouzení kapitoly 1 z hlediska věcné správnosti,
didaktiky a jazyka. Hrubá věcná chyba nalezena nebyla. Autor rozhodl sporné
body; platné konvence shrnuje [R10](../docs/ROZHODNUTI.md#r10-terminologie-kapitoly-1).
Úpravy jsou ve větvi `codex/chapter-01-review` z `main` (d30bd98).

### Terminologie

- Hlavní termín je pravděpodobnostní výběr, náhodný výběr je alternativa.
  Náhodné rozdělení do podmínek nahrazeno náhodným přidělením do podmínek.
- Chybný tvar „predikant“ nahrazen označením odhadovaná (predikovaná)
  proměnná s alternativou prediktand. Kotva slovníčku je nově
  `pojem-odhadovana-promenna`; přejmenovány také `pojem-pravdepodobnostni-vyber`
  a `pojem-nahodne-prideleni`. Staré kotvy se v repozitáři nepoužívají.
- Pro část populace důsledně „výběr“. „Soubor“ zůstal jen pro datový soubor
  a vymezenou množinu případů.
- Kapitoly 3 a 4 používají „náhodný výběr“ v obecných spojeních a nemění se.

### Věcná zpřesnění

- Kódování: opraven obrácený směr definice (přiřazujeme kódy odpovědím).
- Alternativní vysvětlení souvislosti spánku a výkonu výslovně popisuje
  společnou příčinu; nový termín se nezavádí.
- Doplněn vztah chyby měření a systematického zkreslení; sladěno řešení
  úlohy 7b.
- Závěrečná věta oddílu o rolích proměnných zmírněna z „nelze se otázce
  jejich rolí zcela vyhnout“ na „vyplatí se o jejich rolích uvažovat“.
  Původní znění bylo autorovou formulací z 2026-10-05; jde o návrh
  předložený autorovi k posouzení v pull requestu.

### Struktura a didaktika

- Tři nová sbalená nepovinná rozšíření: model měření, spor o čísla na
  dresech, posuvník a verbální kotvy. Spor je nově převyprávěn podle
  Lorda (1953, s. 750–751) a Zand Scholten a Borsbooma (2009, s. 71–73);
  oba texty byly přečteny v `sources/ostatní zdroje/`.
- Přípustné změny číselného zápisu přesunuty za souhrnnou tabulku čtyř
  úrovní měření.
- Nové schéma populace → výběr → přidělení do podmínek
  (`scripts/kapitola_01.R`, generované SVG v ignorované složce
  `assets/chapter-01/plots/`). Jde o ilustraci s pevnými polohami teček,
  nikoli o zobrazení dat.
- Omezeno opakování vazby „samo (o sobě) nedokládá / nezaručuje“
  a odstraněny dvě duplicitní věty. Cíle učení jsou výčtem; ostatní
  kapitoly mají cíle dosud v odstavci.
- Úloha 7e má novou situaci (dotazník spokojenosti klientů poradny)
  s úplným řešením; řešení úloh 1–4 mají označené části.
- Opraveny jazykové chyby (překlep, předložka, interpunkce, nejasné odkazy).

### Ověření

Celá kniha se vykreslila v Quarto 1.9.38 / R 4.5.1. `check-chapter-01.R`
prošel. `check-html.cjs` po doplnění tří nových hledání prošel bez chyb:
9 stránek, 159 hesel slovníčku, místní odkazy, 42 řešení, desktop
1360/1920 px a mobil 390 px. Kontrola běžela s místním Chrome a modulem
Playwright z jiné instalace, nikoli s verzí 1.55.0 uvedenou v README.
Ručně v prohlížeči prohlédnuto schéma na desktopu i mobilu, rozbalení tří
nových rozšíření, vykreslené citace Lorda a Zand Scholten a Borsbooma
a zpřístupnění nových řádků slovníčku přes odkaz.

Neověřeno: stránky a lokátory ostatních citací kapitoly vůči zdrojům,
jiné prohlížeče než Chrome a veřejné publikování. Excelové příklady se
nemění a desktopový Excel nebyl spuštěn. Interní didaktická revize není
ověřením porozumění na studentech.

## Zjednodušení větví a bezpečný úklid (2026-10-11)

Na výslovnou žádost autora zavedeny názvy `codex/chapter-NN` a `codex/other`
s nejvýše jednou aktivní větví na kapitolu. Po sloučení a ověření se větev
odstraní a při další práci vznikne z aktuálního `origin/main` pod stejným
názvem. Pravidla jsou v `AGENTS.md`, schválené rozhodnutí v R11.

Před úklidem byl hlavní pracovní strom čistý. Aktualizace pomocí
`git fetch --prune origin` ukázala, že všech 39 starých pracovních větví
již na GitHubu neexistuje. Z lokálních větví bylo 38 obsaženo přímo
v historii `origin/main` (03e99de). Výjimka `codex/book-sections-bibliography`
obsahovala commit 8a5d840 převzatý do `main` jako 6f3e429: `git cherry`
potvrdil ekvivalenci a oba diffy mají shodný stabilní patch-id
86b6614a5ba635226b5126ea73e65226d4d8fd99. Žádné jedinečné změny nezůstaly.

Pracovní kopie `tmp/chapter-01-concepts` byla čistá bez nesledovaných
neignorovaných souborů; ignorované soubory tvoří výstup webu, cache Quarta
a snímky kontrol. Byla ponechána na původním commitu 99a31f9 v detached
HEAD, takže její soubory zůstaly zachované a starý název větve šlo odstranit.
Všech 39 starých lokálních pracovních větví bylo odstraněno. Lokální
`main` byl posunut na aktuální `origin/main`; nové instrukce vznikají
na `codex/other`. Sloučení tohoto PR zůstává na autorovi.

Ověření: stav obou pracovních stromů, historie a ekvivalence výjimečného
commitu, seznam větví, kontrola rozdílů a `git diff --check`. Změny se týkají
jen autorských instrukcí a dokumentace, render ani numerické a excelové
kontroly proto nebyly potřeba a nebyly spuštěny.

## Názorné diagramy a grafy ve výkladu (2026-10-11)

Na žádost autora doplněno do oddílu „Didaktika a jazyk“ v `AGENTS.md`
pravidlo zařazovat diagramy, schémata a grafy podle jejich přínosu
pro pochopení pojmů, jejich vztahů a principů postupů. Referenčním příkladem
je schéma výběru z populace a přidělení do podmínek v první kapitole.
Rozhodnutí zachycuje R12 v `docs/ROZHODNUTI.md`.

Ověření: kontrola formulace, návaznosti pravidel a rozdílů; `git diff --check`.
Jde pouze o autorské instrukce a dokumentaci, proto render ani výpočetní
a excelové kontroly nebyly potřeba a nebyly spuštěny.

## Názorné vizualizace v kapitolách 2–4 (2026-10-11)

Na výslovný pokyn autora uskutečněno všech jedenáct předložených návrhů,
prioritních i neprioritních. Jde o devět nových obrázků a rozšíření dvou
stávajících; všechny vycházejí z dosavadních autorských příkladů:

- Kapitola 2: dva základy procent při chybějícím údaji; „právě“ versus
  „nejvýše“; zařazení společné intervalové meze; rozšíření porovnání
  histogramů o posunuté meze při zachované šířce jedné hodiny.
- Kapitola 3: příspěvky různě velkých skupin ke společnému průměru;
  percentil versus inkluzivní percentilové pořadí; ořezání versus
  winsorizace včetně počtu hodnot vstupujících do výpočtu.
- Kapitola 4: z-skór jako počet jednotek směrodatné odchylky; rozšíření
  standardních škál o percentilové pořadí podle normálního modelu;
  stenová a staninová pásma včetně ztráty podrobností; vznik souřadnic
  jednoho bodu Q–Q grafu ze společného pořadí.

Generátory zůstávají v `scripts/kapitola_02.R` až `kapitola_04.R` a při
renderu vytvářejí SVG. Každý nový obrázek má stabilní identifikátor,
alternativní text a vysvětlení ve výkladu. Nová třída `teaching-figure`
umožňuje v kapitolách 2 a 3 místní posouvání širokých diagramů; kapitola 4
používá svůj existující kontejner. Oblasti jsou pojmenované a ovladatelné
klávesnicí. Rozsah učiva, terminologie, přehledy ani studentské sešity se
nemění; schválení realizace je doplněno k rozhodnutí R12.

Didaktická revize se zaměřila na návaznost příkladu, obrázku a interpretace.
Výslovně odlišuje chybění od nesplnění podmínky, pořadové rozestupy od
časových vzdáleností, změnu šířky od posunu mezí, kvantil od pořadí,
lineární převod od normálního modelu a teoretický kvantil Q–Q od
standardizace pozorovaného skóru. Interní revize není ověřením porozumění
na studentech.

Ověření: úplný render devíti stránek (Quarto 1.9.38, R 4.5.1), číselné
kontroly kapitol 2–4 a nezávislý přepočet všech nových číselných příkladů
v Pythonu (`statistics.NormalDist`, přímé počítání intervalů a podílů).
Webová kontrola v místním Chromu ověřila odkazy, 159 hesel slovníčku,
42 skrytých a rozbalitelných řešení, matematiku, načtení obrázků,
desktop 1360/1920 px a mobil 390 px bez přetékání celé stránky.
Rozšířené kontroly pokrývají všech jedenáct dotčených obrázků, odkazy
z výkladu, čitelné minimální šířky a místní posouvání klávesnicí.
Vizuálně prohlédnuty všechny dotčené obrázky na desktopu i obě krajní
polohy jejich mobilních výřezů. Snímky a nezávislý pomocný výpočet jsou
v ignorované složce `tmp/`; zdrojové R a HTML kontroly jsou v repozitáři.
Kontrola `git diff --check` prošla.

Omezení: jde o lokálně vykreslený web, nikoli o potvrzení veřejného
nasazení. Jiné prohlížeče než Chrome nebyly ověřeny. Desktopový Excel
nebyl znovu spuštěn, protože sešity ani excelové vzorce se nemění.

## Cíle kapitol jako seznam s odrážkami (2026-10-11)

Na pokyn autora doplněno do `AGENTS.md` pravidlo, že úvodní blok s cíli
kapitoly se formátuje jako seznam s odrážkami;
[R16](../docs/ROZHODNUTI.md#r16-cile-kapitoly-odrazky). Změna se týká jen
instrukcí a autorské dokumentace, render nebyl potřeba. Úpravy kapitol 3
a 4 jsou v jejich větvích.

## Kapitola 2: revize po posouzení (2026-10-11)

Na žádost autora proběhlo posouzení kapitoly 2 z hlediska věcné správnosti,
srozumitelnosti, návaznosti, didaktiky, jazyka a názvosloví. Hrubá věcná
ani početní chyba nalezena nebyla; všechna čísla výkladu a řešení byla
znovu přepočítána proti `data/kapitola_02.csv`. Autor rozhodl sporné body;
platné konvence shrnuje [R13](../docs/ROZHODNUTI.md#r13-platny-udaj-velikost-vyberu).
Úpravy jsou ve větvi `codex/chapter-02` z `origin/main` (259f5c7).

### Terminologie

- Hlavní termín pro *sample size* je velikost výběru (dříve rozsah souboru);
  změněno v kapitole 2, na jediném místě kapitoly 3, ve slovníčku
  (kotva `pojem-velikost-vyberu`; stará kotva se v repozitáři nepoužívala)
  a v přehledu značení. „Velikost skupin“ se nemění.
- Platný údaj (*valid value*) je zaveden v oddílu o jmenovateli a nahrazuje
  střídané „známý / dostupný / nechybějící údaj“ v textu, popiscích, alt
  textech, obrázku základů procent a cvičeních. Slovníček má nové heslo
  Platný údaj a heslo Chybějící údaj; každé uvádí, že je opakem druhého.
  Anglický ekvivalent *valid value* odpovídá běžnému označení ve
  statistických programech; nebyl dohledáván v Howellovi.
- Panel obrázku tvarů se jmenuje Odlehlé pozorování (dříve Vzdálené).
- „Vícečetné odpovědi“ nahrazeny opisem „otázky umožňující více odpovědí“;
  „kumulativní graf“ sjednocen na graf kumulativních četností,
  „procentuální formát“ na procentní. U sloupcového grafu „samostatné
  kategorie“ místo „kategorie diskrétní proměnné“. Kde šlo o zařazování
  případů, je „rozdělení“ nahrazeno slovy zařazení a roztřídění.

### Návaznost a didaktika

- Odstraněny dopředné odkazy na dosud nezavedené pojmy: populační parametr
  u znaku sumace, intervalové třídění u definice kumulativní četnosti
  (nahrazeno odkazem na pozdější oddíl) a střed intervalu u ztráty přesnosti.
- Odstavec o indexech nejprve zavádí značky f a p, pak index; výklad sumace
  nově jmenuje dolní a horní mez sčítání, které používá úloha 2 a přehled
  značení.
- Příklad otázky s více odpověďmi doplněn o procento odpovědí (6 z 11),
  které úvodní věta odstavce slibovala.
- Pořadí výkladu sladěno s obrázky: srovnání konvencí mezí odkazuje na
  obrázek i tabulku; odstavec o dolních panelech histogramů předchází
  obecným doporučením; rovnoměrné rozdělení následuje za vrcholy a je
  zkráceno o větu s nezavedeným pojmem pravděpodobnostního modelu.
- Cíle učení jsou výčtem. Zjednodušeno několik rozvleklých vět a opraveny
  jazykové chyby (překlep, uvozovky, tvar „7,5 hodiny“, nejednotný vid).

### Cvičení

Počet úloh zůstává deset. Úloha 3 má novou část b) o otázce s více
odpověďmi (60,0 %, 70,0 %, 30,0 %; součet 160,0 %; 32 označení od 20 lidí)
s úplným řešením. Úlohy 6 a 7 mají označené části v zadání i řešení.

### Ověření

`scripts/kapitola_02.R` znovu vytvořil 14 obrázků; `check-chapter-02.R`
(doplněný o novou část úlohy 3 a příklad 6 z 11) prošel. Celá kniha se
vykreslila v Quarto 1.9.38 / R 4.5.1. `check-html.cjs` prošel bez chyb:
9 stránek, 160 hesel slovníčku, místní odkazy, 42 řešení, desktop
1360/1920 px a mobil 390 px; běžel s místním Chrome a modulem Playwright
z jiné instalace. Na snímcích vykreslené stránky prohlédnuty cíle učení,
obrázek základů procent, obrázek tvarů a rozbalená řešení úloh 3 a 7;
nevyřešené křížové odkazy v kapitole nejsou.

Omezení: nové heslo slovníčku nebylo samostatně testováno hledáním
a přímým odkazem nad rámec obecné kontroly tabulky. Sešit XLSX se nemění
a Excel nebyl spuštěn. Citované stránky zdrojů nebyly znovu ověřovány,
protože se citace nemění. Interní revize není ověřením porozumění na studentech.

## Kapitola 3: revize po posouzení (2026-10-11)

Autor zadal kontrolu kapitoly 3 z hlediska věcné správnosti, srozumitelnosti,
návaznosti, didaktiky, jazyka a konzistence názvosloví. Kapitola byla přečtena
celá; všechny příklady, tabulky a řešení čtrnácti cvičení byly ručně
přepočítány. Početní chyba nalezena nebyla. Opravy jsou jazykové,
terminologické a didaktické; rozhodnutí autora zachycuje
[R14](../docs/ROZHODNUTI.md#r14-kvartily-spicatost-chvost).

### Rozhodnutí autora

- Hlavní označení **1. a 3. kvartil**; „dolní/horní“ jen při zavedení
  a ve slovníčku. Provedeno v kapitole, slovníčku, přehledu značení,
  popiscích sešitu a jeho generátoru.
- Hlavní termín **špičatost** (*kurtosis*), „kurtóza“ alternativa. Heslo
  slovníčku přejmenováno, kotva `pojem-kurtoza` zachována kvůli odkazům.
- Důsledně **chvost** místo „konec“ rozdělení (popis dat o spánku a paměti,
  česká ukázka APA, komentář k tvaru).
- Odkaz na obrázek z CDN Medium u grafu odchylek a čtverců odstraněn
  (křehká adresa bez bibliografického údaje).
- `data/kapitola_03.csv` zrušeno; všechny údaje příkladů jsou v sešitu.
  Nový list `Dalsi_priklady`: jedenáct dob (A2:A12), deset dob (C2:C11),
  41 skórů (E2:E42) a sedm kontrolních výsledků (H2:H8). `scripts/kapitola_03.R`
  má hodnoty zapsané přímo.

### Věcné a didaktické opravy výkladu

- **Střed a tvar:** odstavec o zešikmení doleva odkazoval na „zrcadlovou
  situaci“ před jejím popisem a tvrdil, že „většina hodnot je větších než
  průměr, ale nižších než modus“, což svádí k závěru, že většina leží mezi
  nimi. Nově: více než polovina nad průměrem a více než polovina pod modem,
  s výslovným vyloučením chybného čtení; opraven překlep.
- **Průměr více skupin:** zmínka o „rozptylech součtu“ před zavedením
  rozptylu nahrazena obecnou „variabilitou součtu“.
- **Kvantily:** $p_j$ z kapitoly 2 je relativní četnost, ne „index kategorie“;
  opravena návaznost příkladu 1, 2, 3, 4; u ordinálního příkladu zkráceno
  trojí opakování a doplněna vazba na dvě prostřední kategorie mediánu.
- **Korekce rozptylu:** zpřesněno, že součet čtverců kolem výběrového průměru
  nepřevýší součet kolem populačního v žádném výběru; „nestranný odhad“ se už
  nepoužívá před svou definicí; komentář k simulaci jmenuje dělení místo
  „druhého sloupce výpočtů“ a uvádí očekávané hodnoty 6,4; 7,6; 7,92.
- **Směrodatná odchylka:** závorka „(zde v min²)“ stála u původních jednotek.
- **Transformace:** odstavec o ukazatelích založených na uspořádání přesunut
  k nelineární transformaci, kde má vyústění: medián lichého souboru se při
  rostoucím převodu převádí přímo (25), interpolovaný 90. percentil nikoli
  (74,4 ≠ 70,56). Bez nového pojmu.
- **Reportování:** odstavec o přirozené nule a nulové základně sloupců měl
  nadpis „Zaokrouhlování“; má vlastní pododdíl.
- Terminologie podle R13: „rozsah“ → „velikost výběru“ (tabulka a alt text
  simulace, popisek osy grafu, tabulka volby statistik); „rozptýlenost“
  jako pouhé synonymum → „variabilita“; pomocné meze jednotně.
- Odkazy na pravidlo 68–95–99,7 a kapitolu 4; identifikátory pododdílů
  `sec-vlastnosti-ukazatelu`, `sec-nelinearni-transformace`,
  `sec-zaokrouhlovani-03`, `sec-nula-graf`, `sec-spicatost`.
- Jazyk: překlepy, zkrácení rozvleklých vět (odchylky, entropie nulové
  kategorie, anglické popisky boxplotu, momenty).

### Cvičení

Úloha 8 upozorňuje, že shoda 20% winsorizovaného průměru s hodnotou 5,9
z výkladu je náhodná. Úloha 12 nově žádá zápis se značkami APA 7
(*M* = 7,0; *SD* = 2,6; *Mdn* = 7); cíl reportování dosud neměl cvičení.

### Ověření

`check-chapter-03.R` prošel (R 4.5.1), včetně souhrnů spánku a paměti
a simulace. `check-chapter-03-excel.ps1 -Finalize` skutečně běžel
v Excelu 16.0: české vzorce, 247 vstupních buněk včetně nového listu,
výsledky H2:H8 (6,4; 8; 5,5; 40; 50; 60; 20) a přepočet při změně vstupů.
Skript dostal BOM UTF-8; bez něj Windows PowerShell 5.1 české názvy funkcí
nenačetl. Celá kniha se vykreslila v Quarto 1.9.38 bez varování. První
render odhalil, že buňka slovníčku začínající „3. kvartil…“ se četla jako
číslovaný seznam; formulace upravena. V prohlížeči ověřeno: kotvy v kapitole,
odkazy do kapitol 2 a 4, 17 sbalených bloků, žádný odkaz na CSV, řádky
slovníčku `pojem-kurtoza` a `pojem-kvartil`, šířka 375 px bez vodorovného
přetékání. Strany Howella citované v kapitole (27, 32, 34–35, 38–41, 45–50)
byly porovnány s textem PDF podle výskytu témat a odpovídají.

Dodatek z téhož dne: úvodní blok „Co budete po prostudování umět“ byl na
pokyn autora převeden z odstavce na seznam s odrážkami, beze změny obsahu;
poznámka o nepovinných rozšířeních zůstává jako věta pod seznamem. Kapitola
se znovu vykreslila bez varování.

`check-html.cjs` po doinstalování Playwright 1.55.0 a Chromia prošel bez chyb:
9 stránek, 160 hesel slovníčku, místní odkazy, 42 řešení, desktop
1360/1920 px a mobil 390 px.

Omezení: generátor `kapitola_03-sešit.mjs` byl upraven, ale nespuštěn
(chybí `@oai/artifact-tool`); list byl do uloženého sešitu doplněn přímo
v Excelu a zdroj prošel jen kontrolou syntaxe. `check-chapter-04-excel.ps1`
je rovněž bez BOM a nebyl měněn. Citace mimo Howella nebyly znovu ověřovány.
Interní revize není ověřením porozumění na studentech.

## Kapitola 4: revize po posouzení (2026-10-11)

Na žádost autora proběhlo posouzení kapitoly 4 z hlediska věcné správnosti,
srozumitelnosti, návaznosti, didaktiky, jazyka a názvosloví. Hrubá věcná
chyba nalezena nebyla; všechna čísla výkladu i řešení byla nezávisle
přepočítána (Python `statistics.NormalDist`) a souhlasí. Úpravy jsou ve
větvi `codex/chapter-04` z `origin/main` (c4de22e).

### Rozhodnutí autora

- Zápis normálního modelu je nově N(μ, σ) se směrodatnou odchylkou jako
  druhým parametrem ([R15](../docs/ROZHODNUTI.md#r15-zapis-normalniho-modelu),
  nahrazuje příslušnou část R09). Ilustrační model je N(50, 10); výklad
  upozorňuje na častou konvenci N(μ, σ²). Úloha 3 používá N(80, 5).
- Úvodní blok cílů je seznam s odrážkami. Věta o posouvání na úzké
  obrazovce byla odstraněna.
- „Výzkumný soubor“ v oddílu o výpočtu v Excelu zůstává jako přípustná
  alternativa; „normativní skupina“ → „normativní soubor“; v řešení úlohy 10
  „velikost výběru n = 200“ (R13).
- Cvičení zůstávají v počtu deseti; doplněny dílčí otázky v úlohách 3
  (konvence zápisu a argument `NORM.DIST`), 7 (nestejné přírůstky modelových
  percentilových pořadí) a 10 (Q–Q graf zešikmeného rozdělení).

### Další opravy

- Samotné „odchylka“ ve významu směrodatné odchylky nahrazeno plným
  termínem ve výkladu, řešeních, alt textu, slovníčku, značení a popiscích
  obrázků 4.1 a 4.3 (legendy nyní uvádějí N(50, 10) apod.). Důvod: v kapitole 3
  znamená „odchylka“ rozdíl hodnoty od průměru.
- Nezavedený zápis polouzavřených intervalů v řešení úlohy 8 nahrazen
  nerovnostmi; „model 50/10“ → N(50, 10); „na normované škále“ → „na škále
  z-skórů“; IQ-skór zaveden v jednotném čísle; vysvětleno slovo inverzní.
- Podíl mezi dvěma hranicemi je vyložen v pořadí z-skóry → levé plochy →
  rozdíl (vzorec se zaokrouhlením na pět míst) → Excel. Před výpočtem
  90. percentilu je předpověď znaménka. Odkaz „plochu nyní vysvětlíme“ míří
  na správný oddíl.
- Doplněno z osnovy: modelové percentilové pořadí není procento správných
  odpovědí (4.4.6); obvyklé zaokrouhlené podíly staninů (4.6.4).
- Zkráceno opakování přírůstků 34,1 a 13,6 v oddílu o normalizaci;
  zpřesněna věta o výšce a šířce křivky; jazykové opravy („Ve spojitém“,
  chybějící čárka, dvojznačné „bez dalšího údaje“, „rovnice přímky“).
- Popisek příkazu řazení opraven na „Seřadit od nejmenšího k největšímu“.

### Ověření a omezení

`check-chapter-04.R` prošel (R 4.5.1) včetně nových kontrol úlohy 3
a zaokrouhleného rozdílu ploch. Celá kniha se vykreslila v Quarto 1.9.38
bez varování; `check-html.cjs` prošel bez chyb (9 stránek, 160 hesel,
42 řešení, mobil 390 px). V prohlížeči ověřeno: 15 obrázků se načte, nové
popisky obrázků 4.1 a 4.3 se vejdou, deset sbalených řešení, stojaté μ a σ,
žádná chyba matematiky, žádný kód R, šířka 390 px bez vodorovného přetékání.
Strany Howella (66–68, 69–71, 74–75, 75–78, 78–79) byly porovnány s textem
PDF podle výskytu témat a odpovídají.

Omezení: sešit `data/kapitola_04.xlsx` se neměnil a Excel nebyl znovu
spuštěn; popisek příkazu řazení nebyl ověřen v běžícím českém Excelu.
Údaj o dostupnosti funkcí od Excelu 2016 zůstal beze změny, i když funkce
pravděpodobně existují už od verze 2010 (neověřeno v dokumentaci). Citace
mimo Howella nebyly znovu ověřovány. Ostatní obrázky byly prohlédnuty jen
v malém měřítku. Interní revize není ověřením porozumění na studentech.

## 2026-10-11: mapa autorských zdrojů

Na výslovnou žádost autora vytvořena [mapa zdrojů](../docs/ZDROJE.md)
pro přípravu dalších kapitol. Zahrnuje všech 28 souborů aktuálního `sources/`,
stabilní identifikátory, bibliografickou identitu v dostupném rozsahu,
tematický rozcestník, mapy obsahu, konkrétní lokátory a meze provedeného
ověření. Do `AGENTS.md` doplněn postup použití a údržby mapy; do kořenového
README přidán odkaz. Osnova, studentský text a původní podklady se nemění.

Všechny soubory byly otevřeny a obsahově posouzeny. U učebnic zmapován
obsah a prostudovány vybrané pasáže, zejména k pravděpodobnosti a návaznostem;
nejde o úplné přečtení všech knih. U prezentací extrahován text i poznámky
podle skutečných vazeb, všechny snímky vyexportovány PowerPointem a vybrané
kontaktní listy vizuálně prohlédnuty. Pro skeny použito OCR s vybranými
vizuálními kontrolami. Prostudovány texty a tabulky souborů úloh a prohlédnuty
vložené obrázky. U XLSX zkontrolovány listy, vzorce, uložené výsledky a
zdrojové rozsahy grafů.

Konkrétní nálezy jsou u zdrojů: například nesoulad kvartilového vzorce
v P02, záměna součtu čtverců hodnot a odchylek v C02/X2_24, opačná znaménka
normálních kvantilů v C03/X3_28 a P–P graf označený jako Q–Q v D10.
Vizuální kontrola vyvrátila podezření na chybný počet hodnot v P02/sn. 43:
textová extrakce vynechala první hodnotu. Nezávisle přepočítány uvedené
součty čtverců a kvantily; 66 uložených výsledků normálních funkcí v D10
souhlasí s Python `statistics.NormalDist` do přibližně 3,4 × 10⁻¹⁶.
Shodují se také průměr a výběrová SD 96 uložených simulovaných hodnot.

Omezení: nebyly kompletně ověřeny všechny výpočty, důkazy, klíče úloh,
animace, vložené objekty, externí data, aplikace a původní empirické studie.
Bibliografické mezery a nepřítomná pokračování úryvků jsou výslovně označeny.
Sešit nebyl nově spuštěn v Excelu; kontrola uložených výsledků není kontrolou
živého přepočtu. Originály a pomocné extrakce/exporty se nezahrnují do Gitu.
Kontrola změny se týká dokumentace, úplnosti inventáře, lokátorů, místních
odkazů, kódování a rozdílů; nový render webu pro tuto změnu není potřebný.
Kontrola prošla: 28 souborů má 28 karet, všech 377 místních odkazů má
dostupný cíl nebo vlastní kotvu a 205 odkazů na stránky PDF leží v rozsahu
příslušného souboru. U odkazů s tištěným číslem stránky byla zkontrolována
také vazba na číslování PDF; u Priviterovy úvodní kapitoly, jejíž elektronický
štítek je odlišný, podle textu titulní strany kapitoly. Otisky všech původních
zdrojů zůstaly stejné. Tabulky, UTF-8 a `git diff --check` jsou bez chyb.

## 2026-10-11: doplnění prezentace probability.pptx do mapy

Na žádost autora přidána karta [P05](../docs/ZDROJE.md#p05), inventární
řádek a odkazy v tematickém rozcestníku. Mapa nyní zahrnuje 29 podkladů,
z toho pět starších přednáškových prezentací. Přečten text všech 36 snímků
včetně matematických objektů a dostupných poznámek podle skutečných vazeb
PPTX. Všechny snímky vyexportovány PowerPointem a prohlédnuty na čtyřech
kontaktních listech; snímek 34 také samostatně. Původní prezentace se neměnila.

Karta uvádí obsah, přesné rozsahy snímků, doporučené využití, metadata,
otisk souboru a konkrétní nálezy: chybný podíl zelených lentilek, chybějící
faktoriál v mezikroku kombinací, chybnou podmínku v Bayesově vzorci,
zaokrouhlení a procentní převod, nesprávnou směrodatnou odchylku podílu
a nesoulad zadání a dosazení normální aproximace. Vybrané počty a
pravděpodobnosti byly nezávisle přepočítány Pythonem; podrobnosti jsou
v kartě. Zpřesnění definic a terminologie jsou podmínkami budoucího použití,
nikoli schválením rozsahu či značení nové kapitoly.

Kontrola prošla: 29 souborů odpovídá 29 inventárním řádkům a kartám,
všechny jejich otisky souhlasí, 383 místních odkazů v mapě má dostupný cíl
nebo vlastní kotvu. Kotvy jsou jedinečné, UTF-8 a `git diff --check` bez
chyb. Originál a pomocné exporty jsou ignorované Gitem. Jde pouze o
autorskou dokumentaci; nový render webu nebyl potřebný ani provedený.
Nebyla provedena úplná odborná revize všech tvrzení, kontrola animací,
původu převzatých obrázků ani ověření excelových funkcí snímku 36.

## 2026-10-11: doplnění Russovy učebnice do mapy zdrojů

Na žádost autora přidán místní `sources/učebnice/russo.pdf` jako
[U11](../docs/ZDROJE.md#u11). Inventář nyní zahrnuje 30 souborů, z toho
11 učebnic. Doplněna mapa kapitol a příslušné odkazy v tematickém
rozcestníku; Howell zůstává hlavním východiskem a osnova se nemění.

Ověřeny titulní a nakladatelské strany, obsah, začátky kapitol a dostupný
rozsah souboru (331 stran PDF). Jde o druhé vydání Riccarda Russa,
Routledge, s rokem 2021 uvedeným v PDF. DOI ověřeno v Crossrefu, který
uvádí online publikaci 29. listopadu 2020; oba údaje karta rozlišuje.
Přečteny obě předmluvy a celá kapitola 3, s. 52–67 (PDF 73–88), včetně
obrázků a tabulky. Titulní údaje, obsah a tato kapitola byly také
vizuálně prohlédnuty v exportech Poppleru. U ostatních kapitol je
zaznamenána mapa obsahu, nikoli úplné prostudování.

Nezávisle přepočítány diagnostický strom, jeho Bayesův výsledek a příklad
dvou komunit přesnou racionální aritmetikou v Pythonu. Na s. 62 byla
v originálu potvrzena záměna nezávislosti výsledku testu a nezávislosti
správnosti klasifikace vzhledem ke zdravotnímu stavu. Karta vysvětluje
rozdíl a vymezuje další podmínky použití. Označuje také chybějící webové
kapitoly 13–14 a jednotlivé oddíly, které obsah uvádí, ale PDF neobsahuje.
Externí úlohy, data a sešity ani aktuální běh JASP nebyly ověřeny;
nejde o úplnou odbornou revizi knihy.

Kontrola prošla: 30 souborů odpovídá 30 kartám a inventárním řádkům,
všechny otisky souhlasí, 414 místních odkazů má dostupný cíl nebo vlastní
kotvu a všech 220 odkazů na stránky PDF leží v rozsahu příslušného
souboru. U U11 zkontrolována vazba tištěných stran na pořadí PDF.
Tabulky, jedinečnost kotev, UTF-8 a `git diff --check` jsou bez chyb.
Původní PDF zůstalo nezměněné a neveřejné. Pro tuto změnu autorské
dokumentace nebyl render studentského webu potřebný ani provedený.

## 2026-10-11: podrobná mapa obsahu učebnice

Na výslovnou žádost autora rozšířena [OSNOVA.md](../docs/OSNOVA.md)
na mapu skutečného obsahu všech čtyř kapitol. Přečten celý aktuální
výklad, zadání i řešení. Karty zachycují cíle a předpoklady, obsah
jednotlivých oddílů, pojmy, příklady, účel vizualizací, studentské soubory,
všech 42 závěrečných úloh (včetně dvou nepovinných) a hranice návazností.
Tematický rozcestník propojuje 16 témat napříč knihou. Rozlišeno vysvětlení,
samostatné procvičení, pouhá zmínka, nepovinné rozšíření a odložené učivo.

Plán pokračování k pravděpodobnosti je oddělen od existujících kapitol;
otevřené volby nejsou vydávány za schválený rozsah kapitoly 5. Původní
plán kapitoly 4 nahradila mapa jejího skutečného textu s odkazy na platná
rozhodnutí. Úplné definice a anglické ekvivalenty zůstávají ve slovníčku,
značení v přehledu a zdrojové karty v mapě zdrojů. V AGENTS.md doplněna
průběžná údržba mapy při obsahových změnách, kontrola odkazů a datum karty;
aktualizován rozcestník README a zaznamenáno rozhodnutí R17.

Z původní osnovy se zde zachovává historická poznámka: anglické označení
*weighted scores* je zaznamenáno v názvu článku
[*A critique of the Wechsler-Bellevue system of weighted scores* (1949)](https://pubmed.ncbi.nlm.nih.gov/18118257/).
Přesná cesta převzetí označení „vážený skór“ do češtiny nebyla ověřena;
není podklad pro tvrzení o německém nebo ruském původu. Jde o přesun
staršího záznamu, nikoli o novou bibliografickou či historickou rešerši.

Kontrola dokumentace prošla: 318 místních odkazů v mapě, instrukcích,
kořenovém README a rozhodnutích má dostupný soubor a případnou kotvu;
mapa odkazuje na všech 139 nadpisů s výslovným identifikátorem ve čtyřech
kapitolách. Zkontrolována úplnost seznamů 8 + 10 + 14 + 10 úloh,
struktura tabulek, jedinečnost sedmi kotev mapy, UTF-8 a `git diff --check`.
Studentské kapitoly, data a konfigurace se nemění. Render, nová vizuální
kontrola grafů, přepočty a běh Excelu nebyly pro tuto dokumentační změnu
potřebné ani provedené. Mapa sama nepotvrzuje odbornou bezchybnost kapitol
ani porozumění na studentech; zdroje nebyly znovu odborně revidovány.

<a id="zalozeni-autorskeho-slovniku"></a>

## 2026-10-11: autorský registr terminologie

Na výslovné zadání autora vznikl `docs/SLOVNIK.md` jako hlavní autorský
registr preferovaných českých názvů, anglických ekvivalentů, rozpoznávaných
alternativ a významových hranic. Obsahuje všech 160 současných hesel
studentského slovníčku ve čtyřech tematických tabulkách; každý řádek má
stabilní ID, doklad, odkaz na studentské heslo a první výklad.

Při založení je 56 hesel označeno S (konkrétní doložená volba nebo schválený
seznam názvů) a 104 K (převzetí v rámci staršího dohodnutého výkladu).
Rozlišení nepředstírá samostatné schválení každého názvu či každé alternativy.
Pozdější rozhodnutí mají přednost před historickým zněním; návrhy a nejasně
doložené budoucí volby mají oddělené místo. Terminologie kapitoly 5 se
tímto úkolem neschvaluje. U 91 hesel je doplněno konkrétní pravidlo použití,
zejména pro role proměnných, protiklady, širší pojmy, zkratky, meze intervalů,
kvartily, špičatost, standardizaci a normalizaci.

AGENTS.md stanoví čtení registru před prací, doložení nových voleb a společnou
údržbu všech dotčených materiálů. Rozcestníky a návaznosti doplněny do
kořenového README, osnovy, mapy zdrojů, rozhodnutí a pravidel prezentací;
schválené rozdělení odpovědnosti eviduje R18. Do dvanácti starších záznamů
přidány pouze stabilní kotvy, jejich historický obsah je zachován.

Ověřena úplnost a shoda 160 ID i preferovaných českých názvů proti
studentskému slovníčku, struktura tabulek, jedinečnost kotev, UTF-8 a cíle
všech nových či upravených místních odkazů v osmi dotčených dokumentech.
Porovnání vůči výchozímu commitu potvrdilo zachování historického textu
a nezměněné studentské zdroje, data, skripty i konfiguraci. Kontrola
`git diff --check` prošla.

Jde o dokumentační změnu. Render, numerické a excelové kontroly ani
vizuální kontrola webu nebyly potřebné a nebyly spuštěny. Neproběhla nová
terminologická rešerše ani úplný audit užití v každé kapitole či místních
prezentacích; registr shrnuje doložené konvence a existující vysvětlení.
Veřejné nasazení nebylo ověřováno.

## 2026-10-11 — Sjednocení terminologie kapitol 1–4

Na základě schváleného auditu sjednoceny názvy v kapitolách, cvičeních,
řešeních, studentském slovníčku a českých popiscích grafů podle
`docs/SLOVNIK.md`: chybějící údaj, výběr, pravděpodobnostní výběr,
kauzální závěr, úroveň měření, četnostní tabulka, souměrnost, variabilita,
krabicový graf, rozdělení zešikmené doprava a meze intervalů.

Zachovány výslovné alternativy při zavedení, prostý náhodný výběr, běžný
popis náhodného výběru jednoho případu, normativní soubor, anglické
reportování a obecné hranice. U výběrového rozptylu zůstávají předpoklady
nestrannosti v navazujícím výkladu. Nové znění hesel odlišuje širší pojem
rozdělení dat a obecný Q–Q graf; platný údaj nezaručuje správnost hodnoty.
Preference potvrzuje R19, registr nyní konkrétně dokládá i kauzální závěr.
Mapa obsahu zachycuje zpřesnění platného údaje a názvu zešikmení; rozsah
učiva se nemění. Technická ID hesel a souborů zůstala zachována.

Ověřena shoda všech 160 názvů a ID registru a studentského slovníčku,
odstranění nalezených odchylek a zachování významových výjimek.
Revize dotčených formulací zachovala odborný význam a návaznosti.
Proběhl render celé knihy a všechny čtyři R kontroly včetně číselných
příkladů a řešení. Aktuální snímky krabicového grafu a histogramu s Q–Q
grafem byly vizuálně prohlédnuty: nové české popisky jsou celé a čitelné.

První pokusy narazily na místní konfiguraci (Windows locale R, spouštěč
Quarta a přístup prohlížeče k localhostu); ověření bylo zopakováno
s UTF-8 locale, přímo přes quarto.exe a v instalovaném Chrome.
Excel nebyl znovu spuštěn: data, sešity, vzorce ani výsledky se neměnily.
Prezentace ani veřejné nasazení nebyly součástí této kontroly.

Kontrola `check-html.cjs` prošla: 9 stránek, 160 hesel, místní odkazy,
42 sbalených/rozbalovaných řešení včetně klávesnice, přehledové tabulky,
obsah kapitol, zobrazení bez JavaScriptu a mobilní šířka 390 px; bez chyb.
Kontrola `git diff --check` také prošla.
