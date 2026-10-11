# Pokrytí dat v sešitech

Kontrola proti zadáním a výkladu: 2026-10-11 (kapitoly 1–4) a 2026-10-12 (kapitola 5). Jednotlivé datové sady, popisy a původ eviduje reprodukovatelný generátor `scripts/sesity-data.mjs`; studentské přehledy jsou uvnitř sešitů.

Slovní situace bez individuálních pozorování nejsou doplňovány smyšlenými daty. Hladké křivky znázorňují modely, nikoli nezveřejněné výběry. U simulace korekce v kapitole 3 je vstupem známá populace a parametry opakování; interní miliony náhodných tahů nejsou studentským datovým souborem. Kapitola 4 obsahuje všech 800 simulovaných skórů ze čtyř porovnávaných obrázků.

## Kapitola 1

[Sešit](../data/kapitola_01.xlsx)

Výklad: `Data` obsahuje šest původních záznamů; `Promenne` jejich význam,
jednotky a chybění; `Chybeni` rozlišuje nulu a nezměřený výkon;
`Oprava_zaznamu` zachovává chybný přepis i údaj původního formuláře.
Ostatní příklady vysvětlují pojmy pomocí slovních situací, nikoli datových souborů.

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
`Orezani`, `Boxplot`, `Populace`, `Entropie_data`, `Spicatost`,
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

Výklad: `Z_skory`, `Standardizace`, `Modely`, `Skaly` a `QQ_data`
obsahují vstupy pro převody a konstrukci grafu; `Model` a `QQ` zachovávají
hotové výpočty. Listy `Sim_normalni`, `Sim_sikme`, `Sim_chvosty` a
`Sim_smes` přebírají po 200 skutečně vygenerovaných skórů z téhož běhu
a seedu jako čtyři porovnávané obrázky. Nejsou to dodatečně vymyšlená
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
