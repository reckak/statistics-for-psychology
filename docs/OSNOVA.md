# Osnova a návaznosti učebnice

Tento dokument je autorský přehled dohodnutého rozsahu a návazností.
Výchozí stav byl sestaven 2026-10-10 z aktuálních kapitol a jejich
[autorské historie](../quarto/README.md). Uvedení kapitoly zde není
prohlášením o jejím definitivním dokončení nebo veřejném nasazení.
Pravidla přípravy a schvalování určuje [AGENTS.md](../AGENTS.md).

Po schválené změně rozsahu, cílů nebo návazností aktualizuj příslušný oddíl.
U budoucích témat rozlišuj návrh od schváleného obsahu; z pouhé zmínky
„probereme později“ neodvozuj schválení nové kapitoly. Nenahrazuj zdejším
přehledem úplný seznam termínů, značek a funkcí v závěrečných přehledech.

## Současné uspořádání

Pořadí webových stránek určuje [_quarto.yml](../_quarto.yml).
Úvod předchází třem dosavadním výkladovým kapitolám. Za nimi je společná
literatura a tři závěrečné přehledy: slovníček, značení a vzorce, funkce
Excelu. Nové výkladové kapitoly se zařazují před literaturu a přehledy.
Čísla níže slouží k orientaci v autorské dokumentaci; studentské odkazy
se nadále zapisují podle pravidel pro stabilní odkazy v `AGENTS.md`.

## 1. Od psychologické otázky k datům

**Stav:** dohodnutý obsah, existující [kapitola](../quarto/kapitola_01.qmd#sec-kapitola-01).
**Vstupní znalosti:** matematika na úrovni základní školy; bez předchozí
statistiky, R či programování.

**Cíle:** student odliší popis, zobecnění a kauzální závěr; vymezí populaci,
výběr, případ a proměnnou; zdůvodní roli proměnné a úroveň měření;
rozliší konstrukt a ukazatel i základní zdroje nejistoty. Sestaví
a zkontroluje datovou matici a přehled proměnných.

**Hlavní obsah:** účel statistiky, proměnné a hodnoty, populace a výběr,
náhodný výběr versus náhodné rozdělení, souvislost a příčina, role proměnných,
interní a externí validita, měření a operacionalizace, čtyři úrovně měření,
diskrétnost a spojitost, chyba a nejistota, organizace a kódování dat,
chybění a kontrola v Excelu.

**Nepovinné rozšíření:** podrobnější modelový pohled na chybu měření.
**Procvičování:** osm úloh zaměřených na pojmy, argumentaci a opravu datové
matice. Četnosti a grafy patří do kapitoly 2, číselné charakteristiky
do kapitoly 3; formální inference zde není zaváděna.

**Návaznost:** poskytuje význam proměnných a dat pro další dvě kapitoly.
Modelový příklad spánku a paměti pokračuje v kapitole 2.
**Doklad:** oddíl „Kapitola Od psychologické otázky k datům“ (dohodnutý
obsah) a záznam „Kapitola 1: role proměnných“ (2026-10-05) v autorské historii;
aktuální cíle v úvodu kapitoly.

## 2. Četnosti, rozdělení dat a jejich zobrazení

**Stav:** dohodnutý obsah, existující [kapitola](../quarto/kapitola_02.qmd#sec-kapitola-02).
**Vstupní znalosti:** případy, proměnné, úrovně měření, datová matice
a chybějící údaje z kapitoly 1.

**Cíle:** student sestaví četnostní tabulku, určí základ procent,
přečte jednoduchou sumaci, vytvoří jednoznačné intervaly, vybere a přečte
graf, popíše tvar rozdělení a rozpozná zavádějící zobrazení. V Excelu
vypočítá četnosti a vytvoří sloupcový graf a histogram.

**Hlavní obsah:** absolutní, relativní a kumulativní četnosti,
podíly a procenta, jmenovatele a chybění, zaokrouhlování a sumace,
intervalové třídění, zahrnutí mezí a ztráta podrobností, sloupcový,
tečkový a kumulativní graf, histogram, polygon, výsečový graf,
stonek a list, tvar rozdělení, efekt podlahy a stropu a kritické čtení grafů.

**Nepovinné rozšíření:** nestejně široké intervaly a rozlišení výšky
a plochy histogramu bez zavádění formálního pojmu hustoty.
**Procvičování:** deset úloh včetně práce v Excelu. Kontingenční tabulky
jsou odloženy k případnému výkladu vztahů dvou kategoriálních proměnných;
percentily a číselné charakteristiky zavádí kapitola 3.

**Návaznost:** rozšiřuje modelová data z kapitoly 1 a poskytuje grafické
a četnostní předporozumění pro souhrnné charakteristiky kapitoly 3.
**Doklad:** „Kapitola 2: četnosti a grafy“ (2026-09-28) a navazující
redakční záznamy z 2026-10-04 a 2026-10-05 v autorské historii;
aktuální cíle v úvodu kapitoly. Konvence jsou v [přehledu rozhodnutí](ROZHODNUTI.md).

## 3. Ukazatele polohy a variability

**Stav:** dohodnutý obsah, existující [kapitola](../quarto/kapitola_03.qmd#sec-kapitola-03).
**Vstupní znalosti:** význam měření z kapitoly 1, četnosti, procenta,
sumace a grafické zobrazení rozdělení z kapitoly 2.

**Cíle:** student zvolí a interpretuje ukazatele středu a variability;
na malých datech vysvětlí a provede jejich výpočet; přečte a sestaví
krabicový graf; rozpozná vliv vzdálených hodnot a rozdíl mezi ořezáním
a winsorizací. Předpoví důsledky změny jednotek a sdělí výsledky slovně
i v ukázce odborného reportování.

**Hlavní obsah:** modus, medián a průměr, vztah středu a tvaru rozdělení,
spojování skupinových průměrů, kvartily a kvantily, interpolovaný
a kumulativní postup, percentilové pořadí, rozpětí, absolutní odchylky,
rozptyl a směrodatná odchylka, princip korekce a stupňů volnosti,
robustní shrnutí, krabicový graf, základní význam entropie, posun
a změna jednotek, kontrast s nelineární transformací, volba statistik,
reportování a konceptuální odlišení popisu dat od modelu rozdělení.

**Nepovinná rozšíření:** logaritmus a výpočet entropie včetně normalizace,
momentová šikmost a špičatost, jejich výpočty a odpovídající Excel.
Jejich vzorce nejsou povinnou dovedností.
**Procvičování:** dvanáct základních a dvě nepovinné úlohy.
**Návaznost:** využívá známá modelová data a malé autorské příklady;
připravuje rozlišení empirického popisu a předpokládaného modelu.

**Doklad:** „Kapitola 3: ukazatele polohy a variability“ (2026-10-05)
a navazující redakční záznamy z 2026-10-09 a 2026-10-10 v autorské historii;
aktuální cíle a označená rozšíření kapitoly. Výpočetní konvence jsou
v [přehledu rozhodnutí](ROZHODNUTI.md).

## Dosud neschválené pokračování

**Stav: náměty k projednání, nikoli schválené nové kapitoly.**
Dosavadní dokumentace odkládá formální normální model, z-skóry,
pravděpodobnosti intervalů a přibližné podíly kolem průměru na později.
Odloženy jsou také kontingenční tabulky a formální inferenční postupy.
Tento seznam neurčuje budoucí počet, pořadí ani názvy kapitol a neukládá
povinnost probrat všechny náměty během semestru.

Před další kapitolou je nutné dohodnout konkrétní rozsah, cíle, vstupní
znalosti, termíny a značky, příklady a očekávané dovednosti. Součástí
přípravy je aktuální posouzení souborů v `sources/` včetně podsložek podle
`AGENTS.md`; samotné pořadí Howellových kapitol tuto dohodu nenahrazuje.
