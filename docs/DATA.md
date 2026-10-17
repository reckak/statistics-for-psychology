# Pokrytí dat v sešitech

Kontrola proti zadáním a výkladu: 2026-10-11 (kapitoly 2–4), 2026-10-12 (kapitoly 1, 5 a 6) a 2026-10-17 (kapitola 7). Jednotlivé datové sady, popisy a původ eviduje reprodukovatelný generátor `scripts/sesity-data.mjs`; studentské přehledy jsou uvnitř sešitů.

Slovní situace bez individuálních pozorování nejsou doplňovány smyšlenými daty. Hladké křivky znázorňují modely, nikoli nezveřejněné výběry. U simulace korekce v kapitole 3 je vstupem známá populace a parametry opakování; interní miliony náhodných tahů nejsou studentským datovým souborem. Kapitola 4 obsahuje všech 800 simulovaných skórů ze čtyř porovnávaných obrázků.

## Kapitola 1

[Sešit](../data/kapitola_01.xlsx)

Výklad: `Data` obsahuje šest původních záznamů; `Promenne` jejich význam,
jednotky a chybění; `Chybeni` rozlišuje nulu a nezměřený výkon;
`Oprava_zaznamu` zachovává chybný přepis i údaj původního formuláře.
Ostatní základní příklady vysvětlují pojmy pomocí slovních situací, nikoli datových souborů.
Sedm schémat doplněných 2026-10-12 znázorňuje vztahy, převody jednotek
a schematické případy; nezadává nový datový soubor ani výpočetní úlohu.
Pevné polohy a počty značek jsou součástí generátoru `scripts/kapitola_01.R`;
vstupy a pokrytí cvičení se těmito schématy nemění.

Nepovinné pedagogické rozšíření přidává `Podpora_ucitele` A2:C301
(podpora, motivace, úspěšnost; 300 řádků) a `Jednickari` A2:C601
(inteligence, motivace, skupina; 600 řádků). Vlastní simulace s pevným seedem
20261012 pochází z `scripts/kapitola_01-simulace.R`, stejná data používá
generátor grafů a sešitu. Žádné chybění, ilustrační skóry bez vazby na
konkrétní test; skupina jedničkářů zohledňuje oba skóry i další náhodné vlivy.
Nejde o nová zadání početních cvičení. Původní listy a jejich adresy zůstávají.

| Cvičení | List a oblast / povaha zadání |
|---|---|
| 1 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 2 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 3 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 4 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 5 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 6 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 7 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 8 | `U08_podklady` A2:C4 a `U08_prepis` A2:C4 |

## Kapitola 2

[Sešit](../data/kapitola_02.xlsx)

Výklad: `Sest_osob` pokrývá úvodní četnosti a různé jmenovatele;
`Data` všech 36 záznamů pro tabulky, tečkový graf, histogram, kumulativní
grafy a polygon. `Strategie`, `Stonek` a `Podpora` doplňují samostatné
příklady; `Tvary` a `Podlaha_strop` zachovávají schematické četnosti obrázků.
`Stonek` A2:A9 pokrývá i obě ukázky dělení stonků: všechna tři zobrazení používají stejných osm časů.
`Cetnosti` a `Histogram` jsou oddělené hotové výpočty a grafy.

| Cvičení | List a oblast / povaha zadání |
|---|---|
| 1 | `U01_odpocatost` A2:A13 |
| 2 | `U01_odpocatost` A2:A13 |
| 3 | `U03_chybeni` A2:B4 a `U03_ruseni` A2:C4 |
| 4 | `U04_chyby` A2:A11 |
| 5 | `U05_spanek` A2:A9 |
| 6 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 7 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 8 | `U08_stonek` A2:B4 |
| 9 | `Podpora` A2:C3 |
| 10 | `Data` A2:E37 |

## Kapitola 3

[Sešit](../data/kapitola_03.xlsx)

Výklad: `Zaklad_data`, `Stejny_prumer`, `Dva_mody`, `Sudy_median`,
`Vazeny_prumer`, `Kvantily`, `Percentil_ctyri`, `Ordinalni_kvantily`,
`Vyjimky_stredu` (četnosti obrázku výjimek, A2:D6), `Orezani`, `Boxplot`, `Populace`, `Entropie_data`, `Spicatost`,
`Transformace` a `Data` pokrývají zadané soubory i souhrnné vstupy.
Varianty změny 10 na 30 a transformací jsou popsány u vstupů, původní
hodnoty se nepřepisují. Hotové výpočty jsou na `Priklad`, `Souhrn`,
`Rozsireni` a `Kontrola_prikladu`; poslední list čte hodnoty ze samostatných
listů `Kvantily`, `Orezani` a `Boxplot`.

| Cvičení | List a oblast / povaha zadání |
|---|---|
| 1 | `U01_stred` A2:A7 |
| 2 | `U02_skupiny` A2:C3 |
| 3 | `U03_kvantily` A2:A7; pro srovnání `Kvantily` A2:A12 |
| 4 | `U04_kategorie` A2:B5 |
| 5 | `U05_variabilita` A2:A4 |
| 6 | `U06_simulace` A2:C5 |
| 7 | `U07_MedAD` A2:A6 |
| 8 | `Orezani` A2:A11 |
| 9 | `U09_boxplot` A2:A9 |
| 10 | `U10_transformace` A2:C6 |
| 11 | `U11_strategie` A2:C5 |
| 12 | `Data` C2:C37 |
| 13 | `Entropie_data` A2:B5 |
| 14 | `U14_sikmost` A2:B5 a `Spicatost` A2:C6 |

## Kapitola 4

[Sešit](../data/kapitola_04.xlsx)

Výklad: `Z_skory`, `Standardizace`, `Normalizace`, `Modely`, `Skaly` a `QQ_data`
obsahují vstupy pro převody a konstrukci grafu; `Model` a `QQ` zachovávají
hotové výpočty (`QQ` od 2026-10-16 také sloupec F a graf pro nepovinný P–P graf). Listy `Sim_normalni`, `Sim_sikme`, `Sim_chvosty` a
`Sim_smes` přebírají po 200 skutečně vygenerovaných skórů z téhož běhu
a seedu jako čtyři porovnávané obrázky; `Sim_normalni` slouží také obrázku histogramu s četnostmi a hustotou proloženého normální křivkou. Nejsou to dodatečně vymyšlená
individuální data ke slovnímu cvičení 10.

| Cvičení | List a oblast / povaha zadání |
|---|---|
| 1 | `U01_reference` A2:E3 |
| 2 | `U02_standardizace` A2:A6 |
| 3 | `U03_model` A2:B6 |
| 4 | `U04_plochy` A2:B7 |
| 5 | `U05_percentily` A2:B6 |
| 6 | `U06_zaokrouhleni` A2:B5 |
| 7 | `U07_prevody` A2:A5 a `Skaly` A2:C5 |
| 8 | `U08_pasmo` A2:A4 |
| 9 | `QQ_data` A2:A13 |
| 10 | Slovní / konceptuální zadání; individuální data nejsou zadána. |

## Kapitola 5

[Sešit](../data/kapitola_05.xlsx). Kontrola proti výkladu a zadáním: 2026-10-12.

Výklad: `Karticky` (krabice 100 kartiček), `Tabulka_zavislost` a
`Tabulka_nezavislost` (dva modelové soubory 200 studentů), `Screening`
(senzitivita, specificita, dvě prevalence), `Test_hadani` (počty otázek
a pravděpodobnost správného tipu), `Sim_hadani` (všech 40 simulovaných hodnot
z obrázku modelu a dat), `Rozpoznavani` (normální aproximace) a `Losovani`
(nepovinné variace). Hotové výpočty jsou odděleně na listech `Bayes`,
`Binom`, `Binom_20` a `Aproximace`; jejich žluté buňky jsou vstupy.
Na listu `Binom` je n = 5 pevné, odemčená je pouze B3 (pravděpodobnost
od 0 do 1). Na `Binom_20` je n = 20 pevné, odemčené jsou B3:B5:
pravděpodobnost 0–1, hodnota pro právě/nejvýše 0–20 a hranice alespoň 1–20.
Popisky A7:A9 a A19 jsou vzorce navázané na B4:B5. Ochrana bez hesla
brání náhodným změnám pevného n, rozsahu hodnot a výpočtů.
Krajní π = 0 a π = 1 jsou podporovány: P(X = 0) používá přímý součin
neúspěchů; bodový dotaz a inverzní funkce na `Binom_20` mají ošetření
pomocí KDYŽ. Tyto případy se skutečně přepočítávají v kontrole Excelu.
V tabulkách stresu je druhá kategorie „Bez vysokého stresu“, nikoli „Pohoda“.
U screeningu je stálost senzitivity a specificity předpokladem srovnání;
u taxíků předpokládáme stejnou pravděpodobnost nehody pro každý taxík.
Cvičení 8 používá autorské ilustrační četnosti, nikoli skutečně vyšetřené osoby.

Pět simulovaných řad po 1 000 tipech z prvního obrázku není studentským
datovým souborem: vstupem je pravděpodobnost 0,25, počet řad a pevný seed
v `scripts/kapitola_05.R`. Kontingenční tabulky a přirozené četnosti jsou
četnosti kombinací, nikoli záznamy o jednotlivých lidech; z nich se žádná
individuální data nesestavují.

| Cvičení | List a oblast / povaha zadání |
|---|---|
| 1 | `U01_emoce` A2:B5 |
| 2 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 3 | `U03_tabulka` A2:C3 |
| 4 | `U04_vstupy` A2:B5 |
| 5 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 6 | `U06_screening` A2:B6 |
| 7 | `U07_taxi` A2:B4; čísla podle Howella, s. 122–123 |
| 8 | `U08_rozdeleni` A2:C5 |
| 9 | `U09_test` A2:B4 |
| 10 | `U10_test` A2:B5 |
| 11 | `U11_aproximace` A2:B4 |
| 12 | Slovní / konceptuální zadání; individuální data nejsou zadána. |

## Kapitola 6

[Sešit](../data/kapitola_06.xlsx). Kontrola proti výkladu a zadáním: 2026-10-12.

Výklad: `Parkovani` (souhrny studie podle Howella a parametry výukového
modelu), `Tipovani` (test s 20 a 80 otázkami), `Devet_vyberu` (všech devět
výběrů dvou dob) a `Pozornost` (z-test). Hotové výpočty jsou odděleně
na listech `Chyba`, `Test_rozdilu`, `Binom_test`, `Z_test` a `Sila`; žluté
buňky jsou vstupy, modré vzorce. Na `Binom_test` je vstup omezen ověřením
dat na nejvýše 20 pokusů a pozorovaný počet alespoň 1; list počítá jen
alternativu „více“. Směrodatná chyba na `Test_rozdilu` a `Sila` je zadána
jako hodnota výukového modelu (2,1213 s), nepočítá se z dat studie.

Simulovaná data z obrázků jsou v sešitu úplná a statická: `Sim_vyber`
A2:A31 (30 dob zobrazeného výběru), `Sim_prumery` A2:D10001 (10 000 průměrů
pro každou ze čtyř velikostí výběru; hodnoty v řádku spolu nesouvisejí),
`Sim_rozdily` A2:A10001 (10 000 rozdílů průměrů dvou výběrů po 100 řidičích
při platné nulové hypotéze) a `Skupiny` A2:B151 (150 skupin z jediné
populace). Hodnoty jsou zaokrouhleny na tři desetinná místa; vznikají
v `scripts/sesity-simulace.R` ze stejných seedů jako obrázky
(`scripts/kapitola_06.R`). Počty citované v textu (261, 236, 7 a 4) jsou
ověřeny funkcí COUNTIFS přímo na uložených hodnotách. Jednotlivé simulované
doby, ze kterých průměry vznikly, studentským datovým souborem nejsou.

Parkovací studie je v sešitu jen čtyřmi souhrnnými čísly z Howella (s. 86);
individuální doby řidičů nebyly zveřejněny a nesestavují se. Hladké křivky
obrázků jsou modely. Cvičení 10 zadává hotové hodnoty statistické síly
a cvičení 11 hotové p-hodnoty; nejde o jednotlivá pozorování.

| Cvičení | List a oblast / povaha zadání |
|---|---|
| 1 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 2 | `U02_body` A2:A4 |
| 3 | `U03_podil` A2:B5 |
| 4 | `U04_vybery` A2:B10; `U04_model` A2:B3 |
| 5 | `U05_IQ` A2:B6; upraveno podle starší úlohy kurzu |
| 6 | `Skupiny` A2:B151 (simulovaná data z výkladu) |
| 7 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 8 | `U08_pokus` A2:B6; čísla podle Howella, s. 129–130 |
| 9 | `U09_pamet` A2:B6; k výpočtu lze použít list `Z_test` |
| 10 | `U10_sila` A2:C3; zadané hodnoty síly z normálního modelu |
| 11 | `U11_vysledky` A2:D7; zadané výsledky testů |
| 12 | `U12_studie` A2:B8 |
| 13 (nepovinné) | `U13_sila` A2:B7 |
| 14 (nepovinné) | `U14_screening` A2:B6; smyšlené hodnoty |

## Kapitola 7

[Sešit](../data/kapitola_07.xlsx). Kontrola proti výkladu a zadáním: 2026-10-17.

Výklad: `Pozornost` (průběžný příklad: norma 50, modelový předpoklad σ = 10,
výběrová s = 10, n = 25, m = 46), `PDI` (souhrny podle Howella, s. 186–188,
ze studie Nurcomba et al., 1984) a `Studie_ekv` (pět smyšlených studií online
verze testu, hranice ekvivalence 47 a 53). Hotové výpočty jsou odděleně
na listech `Interval_z`, `Interval_t`, `T_test` a `Ekvivalence`; žluté buňky
jsou vstupy, modré vzorce. `Ekvivalence` je nastavena na studii B a počítá
test rozdílu (95% interval, oboustranná p-hodnota), test ekvivalence
(90% interval a slovní závěr) a nepovinně obě p-hodnoty TOST (B22:B26).

Simulovaná data obrázku opakovaných intervalů jsou v sešitu úplná a statická:
`Sim_intervaly` A2:H101 (100 výběrů po 25 z výukového modelu s průměrem 47
a σ = 10; pro každý výběr průměr, s, meze intervalu se známou σ a s výběrovou s
a ukazatel zachycení). Meze jsou počítány z nezaokrouhlených hodnot a uloženy
na tři desetinná místa; vznikají v `scripts/sesity-simulace.R` ze stejného
seedu jako obrázek (`scripts/kapitola_07.R`). Počty 94 a 96 citované v textu
jsou ověřeny funkcí SUMA i COUNTIFS přímo na uložených hodnotách. Jednotlivé
simulované skóry studentským datovým souborem nejsou; simulace 10 000 výběrů
po pěti lidech (obrázek t-rozdělení) v sešitu není, text z ní cituje jen
dva podíly.

PDI je v sešitu jen čtyřmi souhrnnými čísly; individuální hodnoty dětí se
nesestavují. Cvičení 8 a 11 zadávají hotové meze intervalů, cvičení 9 parametry
normálního modelu; nejde o jednotlivá pozorování.

| Cvičení | List a oblast / povaha zadání |
|---|---|
| 1 | `U01_IQ` A2:B4; čísla jako v úloze 9 kapitoly 6 |
| 2 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 3 | `U03_sirka` A2:B4 |
| 4 | Bez datového listu; kvantily funkcí T.INV. |
| 5 | `U05_slova` A2:A11 |
| 6 | `U06_pohoda` A2:B5; k výpočtu lze použít list `T_test` |
| 7 | `U07_uzkost` A2:A21 |
| 8 | `U08_intervaly` A2:D6; zadané meze intervalů |
| 9 | `U09_deprese` A2:B5; parametry normálního modelu |
| 10 | `U10_spokojenost` A2:B6; k výpočtu lze použít list `Ekvivalence` |
| 11 | `U11_studie` A2:E6; zadané meze intervalů |
| 12 | Slovní / konceptuální zadání; individuální data nejsou zadána. |
| 13 (nepovinné) | `U10_spokojenost` A2:B6; list `Ekvivalence` B22:B26 |
| 14 (nepovinné) | `U14_neinferiorita` A2:B6 |
