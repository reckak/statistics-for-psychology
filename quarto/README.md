# Autorská dokumentace

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
