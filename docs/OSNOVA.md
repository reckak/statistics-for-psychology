# Mapa obsahu a návazností učebnice

**Poslední kontrola mapy: 2026-10-12** (karta kapitoly 5; karty 1–4 naposledy
2026-10-11). Dokument popisuje aktuální zdrojové texty pěti výkladových
kapitol a odděleně eviduje stav dalšího pokračování.
Je autorskou pomůckou pro psaní, revize a plánování; není studentskou
kapitolou ani potvrzením dokončení, odborné bezchybnosti nebo nasazení webu.

Mapa byla sestavena čtením výkladu, zadání i řešení v aktuálních `.qmd`,
nejen z nadpisů nebo původních plánů. U grafů zachycuje jejich účel podle
zařazení, popisků a komentáře v textu; neoznačuje tím novou vizuální kontrolu.
U sešitů mapuje postupy a umístění popsané v kapitolách, nikoli nový běh Excelu.

## Jak mapu používat a udržovat

- **Vysvětleno** znamená, že text objasňuje význam, postup nebo jeho omezení.
  Samotný řešený příklad ještě není samostatným procvičením.
- **Procvičeno** znamená, že dovednost vyžaduje konkrétní závěrečné cvičení;
  jeho číslo je uvedeno v kartě. Neznamená to ověření porozumění na studentech.
- **Zmíněno** označuje orientační odkaz či upozornění bez dostatečného výkladu
  pro samostatné použití. Další kapitola jej nesmí považovat za zvládnuté učivo.
- **Nepovinné** části nejsou předpokladem povinného pokračování. **Odloženo**
  neznamená schváleno pro příští kapitolu. U budoucího obsahu rozlišujeme
  dohodnutý směr, schválený plán a návrhy či otevřené otázky.

Před obsahovou prací přečti kartu dotčené kapitoly i relevantní návaznosti
v rozcestníku, potom příslušné pasáže skutečného textu. Při každé obsahové
změně aktualizuj dotčené oddíly mapy, stav vysvětlení/procvičení, příklady,
hranice učiva a odkazy; při změně návazností také rozcestník a plán pokračování.
Datum karty měň po kontrole jejího souladu s aktuálním textem, nikoli pouze
po změně data v záhlaví. Drobné jazykové opravy bez změny významu aktualizaci
mapy nevyžadují. Pravidlo je součástí [projektových instrukcí](../AGENTS.md).

Mapa zachycuje **existující obsah**, sama jej dodatečně neschvaluje a nenahrazuje
přípravu nové kapitoly. Pokud se skutečný výklad a dohoda rozcházejí, popiš
rozdíl a vyřeš jej podle instrukcí; nepřepisuj plán jako hotový text.
Úplné studentské definice, anglické ekvivalenty a vzorce patří do [slovníčku](../quarto/slovnicek.qmd),
[přehledu značení](../quarto/znaceni.qmd) a [funkcí Excelu](../quarto/excel.qmd).
[SLOVNIK.md](SLOVNIK.md) je hlavní autorský registr terminologických preferencí,
alternativ a významových hranic; čti jej před psaním i při revizi. Nové
schválené názvy a jejich změny aktualizuj současně v registru, studentském
slovníčku a dotčeném výkladu. Tato mapa eviduje jejich zařazení a návaznosti,
nikoli druhý úplný seznam překladů. [ROZHODNUTI.md](ROZHODNUTI.md) eviduje
platné konvence, důvody a doklady dohod,
[ZDROJE.md](ZDROJE.md) podklady a rozsah jejich prostudování,
[quarto/README.md](../quarto/README.md) historii tvorby a ověřování.

<a id="usporadani"></a>

## Současné uspořádání

Pořadí určuje [_quarto.yml](../_quarto.yml). [Úvod](../index.qmd) předchází
pěti výkladovým kapitolám; za nimi je [literatura](../quarto/literatura.qmd)
a tři výše uvedené přehledy v pořadí slovníček → značení a vzorce → Excel.
Nové výkladové kapitoly patří před literaturu a přehledy. Čísla v této mapě
jsou autorské orientační údaje; studentské křížové odkazy nadále používají
stabilní identifikátory Quarta.

| Kapitola / karta | Úloha v návaznosti | Samostatná cvičení |
|---|---|---|
| [1. Od psychologické otázky k datům](#mapa-kapitola-01) | Význam údajů, výzkumné závěry, měření a příprava matice. | 8 konceptuálních a praktických úloh. |
| [2. Četnosti, rozdělení dat a jejich zobrazení](#mapa-kapitola-02) | Od jednotlivých záznamů k zastoupení hodnot a grafům. | 10 úloh, z toho závěrečná změna vstupů v Excelu. |
| [3. Ukazatele polohy a variability](#mapa-kapitola-03) | Číselná shrnutí, jejich volba, výpočet, omezení a reportování. | 12 základních a 2 nepovinné úlohy. |
| [4. Normální rozdělení a standardní skóry](#mapa-kapitola-04) | Relativní poloha, modelové podíly a kvantily, standardní škály a posouzení modelu. | 10 úloh včetně tvorby Q–Q grafu. |
| [5. Pravděpodobnost](#mapa-kapitola-05) | Pravidla pro jevy, podmínění a Bayesova věta; rozdělení pravděpodobnosti, binomický model a jeho normální aproximace. | 12 úloh, z toho dvě v Excelu. |
| [Plán pokračování](#plan-dalsi-kapitoly) | Po kapitole 5 není nic schváleno. | Není vytvořenou kapitolou ani schválenou sadou úloh. |

<a id="tematicky-rozcestnik"></a>

## Tematický rozcestník napříč knihou

Číslo úlohy vždy patří kapitole uvedené před ním. Podrobné popisy úloh
jsou v kartách níže; jejich řešení zůstávají ve studentském textu.

| Téma | První vysvětlení a rozvoj | Procvičení a hranice návaznosti |
|---|---|---|
| Případ, proměnná, hodnota, konstanta | [1: proměnné](../quarto/kapitola_01.qmd#sec-promenne); [2: co počítáme](../quarto/kapitola_02.qmd#sec-co-pocitame). | 1/1, 1/8; počet řádků není automaticky počet různých lidí. |
| Populace, výběr a zobecnění | [1: populace a výběr](../quarto/kapitola_01.qmd#sec-populace-vyber); [4: referenční skupina](../quarto/kapitola_04.qmd#sec-referencni-skupina). | 1/2–4, 4/1 a 10, 5/3; kapitola 5 odlišuje nezávislost v tabulce výběru od nezávislosti v populaci. Formální inferenční postupy zatím nejsou vyloženy. |
| Souvislost, příčina, role proměnných a validita | [1: souvislost a příčina](../quarto/kapitola_01.qmd#sec-souvislost-pricina). | 1/3–4; pozdější popisy rozdílů na toto omezení navazují, nevyučují kauzální analýzu. |
| Měření, konstrukt, škály a význam transformací | [1: měření](../quarto/kapitola_01.qmd#sec-mereni) a [úrovně](../quarto/kapitola_01.qmd#sec-urovne); [3: volba statistik](../quarto/kapitola_03.qmd#sec-komunikace-statistik); [4: standardní skóry](../quarto/kapitola_04.qmd#sec-standardni-skory). | 1/5–6, 3/4, 4/7; číselný převod nezmění měřený konstrukt. |
| Chyba, zkreslení a výběrová variabilita | [1: nejistota](../quarto/kapitola_01.qmd#sec-nejistota); [3: korekce rozptylu](../quarto/kapitola_03.qmd#sec-korekce-rozptylu); [4: Q–Q](../quarto/kapitola_04.qmd#sec-qq-graf). | 1/7, 3/6, 4/4 a 10, 5/2, 8 a 11; kapitola 5 ukazuje kolísání relativní četnosti a směrodatnou odchylku podílu. Výběrová rozdělení a standardní chyba nejsou systematicky vysvětleny. |
| Datová matice, ID, chybění a platné údaje | [1: matice](../quarto/kapitola_01.qmd#sec-datova-matice); [2: jmenovatel](../quarto/kapitola_02.qmd#sec-jmenovatel); [3: Excel](../quarto/kapitola_03.qmd#sec-excel-poloha). | 1/8, 2/3 a 10, 3/12; bez výkladu imputace. |
| Četnosti, podíly a procenta | [2: četnosti](../quarto/kapitola_02.qmd#sec-od-zaznamu-k-cetnostem) a [podíly](../quarto/kapitola_02.qmd#sec-relativni-cetnost); [4: modelové plochy](../quarto/kapitola_04.qmd#sec-plochy-normalniho). | 2/1–4 a 9–10, 4/3–6; pozorované a modelové podíly mají odlišnou oporu. |
| Indexy, sumace a matematické mezikroky | [2: indexy](../quarto/kapitola_02.qmd#sec-relativni-cetnost) a [sumace](../quarto/kapitola_02.qmd#sec-sumace); [3: absolutní hodnota](../quarto/kapitola_03.qmd#sec-prumerna-absolutni), [mocniny](../quarto/kapitola_03.qmd#sec-rozptyl), [odmocnina](../quarto/kapitola_03.qmd#sec-smerodatna-odchylka). | 2/2, 3/5; logaritmus a vyšší momenty pouze nepovinně. |
| Kumulace, kvantil a percentilové pořadí | [2: kumulace](../quarto/kapitola_02.qmd#sec-kumulativni-cetnosti); [3: kvantily](../quarto/kapitola_03.qmd#sec-kvantily) a [pořadí](../quarto/kapitola_03.qmd#sec-percentilove-poradi); [4: distribuční funkce](../quarto/kapitola_04.qmd#sec-distribucni-funkce) a [modelový percentil](../quarto/kapitola_04.qmd#sec-normalni-kvantil). | 2/4, 3/3–4, 4/4–5; interpolace, inkluzivní pořadí a polohy Q–Q nejsou jeden algoritmus. |
| Intervaly, histogram a hustota | [2: intervaly](../quarto/kapitola_02.qmd#sec-tridni-intervaly) a [histogram](../quarto/kapitola_02.qmd#sec-histogram); [4: hustota](../quarto/kapitola_04.qmd#sec-hustota). | 2/5–6 a 10, 4/3 a 6; nestejné šířky jsou ve 2 nepovinné, plocha se ve 4 vysvětluje znovu. |
| Tvar, chvosty, vrcholy a odlehlá pozorování | [2: tvar](../quarto/kapitola_02.qmd#sec-tvar-rozdeleni); [3: střed a tvar](../quarto/kapitola_03.qmd#sec-stred-tvar), [boxplot](../quarto/kapitola_03.qmd#sec-boxplot); [4: diagnostické grafy](../quarto/kapitola_04.qmd#sec-qq-odchylky). | 2/7, 3/1 a 9, 4/9–10; momentová šikmost a špičatost pouze nepovinně (3/14). |
| Poloha, variabilita a robustní shrnutí | [3: střed](../quarto/kapitola_03.qmd#sec-stred-rozdeleni), [rozptyl](../quarto/kapitola_03.qmd#sec-odchylky-rozptyl), [odolnost](../quarto/kapitola_03.qmd#sec-odolne-shrnuti). | 3/1–2 a 5–9; 4 používá průměr a SD, nikoli nepovinné momenty jako předpoklad. |
| Pravděpodobnost, jevy a pravidla počítání | [4: plocha jako pravděpodobnost](../quarto/kapitola_04.qmd#sec-hustota); [5: pojetí](../quarto/kapitola_05.qmd#sec-pojeti-pravdepodobnosti), [jevy](../quarto/kapitola_05.qmd#sec-jevy), [součtové pravidlo](../quarto/kapitola_05.qmd#sec-souctove-pravidlo). | 5/1–2, 4 a 12; ve 4 jen propojení modelového podílu s pravděpodobností. Množinový formalismus a axiomy se nevykládají. |
| Podmínění, nezávislost a Bayesova věta | [5: tabulka](../quarto/kapitola_05.qmd#sec-kontingencni-tabulka), [podmínění](../quarto/kapitola_05.qmd#sec-podminena), [nezávislost](../quarto/kapitola_05.qmd#sec-nezavislost), [Bayes](../quarto/kapitola_05.qmd#sec-bayes). | 5/3–7 a 12; inference o závislosti v populaci a testy pro tabulky nejsou vyloženy. |
| Chyby pravděpodobnostního úsudku | [5: hráčský klam](../quarto/kapitola_05.qmd#sec-dlouha-rada), [konjunkční klam](../quarto/kapitola_05.qmd#sec-konjunkcni-klam), [zanedbání základních četností](../quarto/kapitola_05.qmd#sec-dve-prevalence). | 5/2, 5 a 7; vykládají se u pravidla, které porušují, ne jako přehled heuristik. |
| Náhodná proměnná, binomický model a aproximace | [5: rozdělení pravděpodobnosti](../quarto/kapitola_05.qmd#sec-nahodna-promenna), [kombinace](../quarto/kapitola_05.qmd#sec-kombinace), [binomické rozdělení](../quarto/kapitola_05.qmd#sec-binomicke), [aproximace](../quarto/kapitola_05.qmd#sec-normalni-aproximace). | 5/8–12; obecná střední hodnota a variace jen nepovinně; binomický test není vyložen. |
| Rozmanitost kategorií a entropie | [3: entropie](../quarto/kapitola_03.qmd#sec-entropie). | 3/11 slovně; 3/13 nepovinný výpočet; nejde o úplný výklad teorie informace. |
| Lineární a nelineární transformace | [3: změna škály](../quarto/kapitola_03.qmd#sec-zmena-skaly); [4: standardizace](../quarto/kapitola_04.qmd#sec-standardizace) a [normalizace](../quarto/kapitola_04.qmd#sec-normalizace). | 3/10, 4/1–2 a 7–8; normalizace přes pořadí vysvětlena principem, bez algoritmu tvorby norem. |
| Statistika, parametr, data a model | [3: souhrnné ukazatele](../quarto/kapitola_03.qmd#sec-poloha-variabilita) a [popis/model](../quarto/kapitola_03.qmd#sec-popis-a-model); [4: normální model](../quarto/kapitola_04.qmd#sec-normalni-model). | 3/11, 4/3–5 a 10, 5/8; kapitola 5 přidává rozdělení pravděpodobnosti diskrétní proměnné a parametr π. Normální model nepředstavuje obecnou teorii rozdělení. |
| Kritické čtení grafu a sdělení výsledku | [2: zavádějící grafy](../quarto/kapitola_02.qmd#sec-zavadejici-grafy); [3: reportování](../quarto/kapitola_03.qmd#sec-reportovani-apa); [4: přiměřenost modelu](../quarto/kapitola_04.qmd#sec-primerenost-modelu). | 2/6–9, 3/12, 4/10; APA značky jsou vymezenou výjimkou, výpočetní značení se nemění. |

<a id="mapa-kapitola-01"></a>

## 1. Od psychologické otázky k datům

**Podklad a stav:** existující [kapitola 1](../quarto/kapitola_01.qmd#sec-kapitola-01),
obsah karty zkontrolován 2026-10-11. Dohodnutý obsah a pozdější rozšíření
rolí proměnných dokládá autorská historie; terminologii výběru, přidělení
a rolí shrnuje [R10](ROZHODNUTI.md#r10-terminologie-kapitoly-1).
**Vstup:** matematika základní školy, bez předchozí statistiky či programování.

**Cíle:** odlišit popis, zobecnění a příčinu; určit populaci, výběr, případ,
proměnnou, hodnotu a konstantu; zdůvodnit role proměnných a význam měření;
rozpoznat zdroje nejistoty; sestavit a kontrolovat matici s přehledem proměnných.

### Skutečný obsah oddílů

Všechny níže popsané základní části jsou **vysvětleny**; poslední sloupec
určuje konkrétní **procvičení**. Nepovinná okénka jsou označena samostatně.

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Proč psychologie potřebuje statistiku](../quarto/kapitola_01.qmd#sec-proc-statistika) | Přechod od osobní zkušenosti se spánkem k vymezené otázce; selektivnost zkušeností, souběh okolností, statistika při plánování, popisu a usuzování. Nejistota není odstranitelná pouhým výpočtem. | 2–3: meze výpočtu a druhy závěrů. |
| [Proměnné a hodnoty](../quarto/kapitola_01.qmd#sec-promenne) | Případ, proměnná, hodnota, konstanta, data a nejednoznačné užití slova pozorování. Možné versus zaznamenané hodnoty; konstantnost vzhledem k souboru; jedno číslo jako doba, počet nebo ID. | 1: student × den, 4 lidé a 28 záznamů. |
| [Populace a výběr](../quarto/kapitola_01.qmd#sec-populace-vyber) | Vymezení populace otázkou; stejný ročník jako populace i výběr. Popisná a inferenční statistika. Pravděpodobnostní, prostý náhodný a příležitostný výběr, dobrovolnost a neúčast; reprezentativnost není synonymem náhodnosti. Kulturní a situační meze zobecnění, argumentace mechanismem a potřeba dalšího ověření. | 2–3; bez výpočtu inferenčních statistik. |
| [Souvislost a příčina](../quarto/kapitola_01.qmd#sec-souvislost-pricina) | Pozorovaný spánek a paměť versus možná společná příčina; experiment s tichem a nahrávkou. Náhodné přidělení doplňuje stejné provedení úlohy, nezaručuje shodné skupiny ani příčinu každého rozdílu. | 3–4. |
| [Role proměnných](../quarto/kapitola_01.qmd#sec-role-promennych) | Nezávislá a závislá proměnná v experimentu i širším užití; explanační proměnná, prediktor a výsledná proměnná. Role závisí na otázce; predikce nemusí mířit do budoucnosti a názvosloví neprokazuje příčinu. | 4f. |
| [Interní a externí validita](../quarto/kapitola_01.qmd#sec-interni-externi-validita) | Opora pro příčinu versus přenos závěru; dva kroky náhodnosti ve schématu populace → výběr → podmínky. Dobrovolníci mohou být náhodně přiděleni; interní a externí validita nejsou automaticky ve vztahu kompromisu. | 4a–e. |
| [Co vlastně měříme](../quarto/kapitola_01.qmd#sec-mereni) | Konstrukt, měření, operacionalizace, operacionální definice a ukazatel. Úloha s 12 slovy má přesné časy a skórování; doba spánku vylučuje bdění; stejný kód souhlasu mění význam se zněním položky. | 5–6. |
| [Úrovně měření](../quarto/kapitola_01.qmd#sec-urovne): [nominální](../quarto/kapitola_01.qmd#sec-nominalni), [ordinální](../quarto/kapitola_01.qmd#sec-ordinalni), [intervalová](../quarto/kapitola_01.qmd#sec-intervalova), [poměrová](../quarto/kapitola_01.qmd#sec-pomerova) | Odlišnost, pořadí, rovnost rozdílů a poměry; role nuly a přípustné změny kódů/jednotek. Podmínky experimentu, odpočatost, teplota, únava, doba a počet slov. Poměr počtů není poměrem paměťové schopnosti; úroveň není pouhá nálepka pro volbu metody. | 6a–c, e a g. |
| [Stejná vlastnost, různé údaje](../quarto/kapitola_01.qmd#sec-stejna-vlastnost) | Přesný věk, pásma, odpověď ano/ne pro prostřední pásmo a rok narození uchovávají různé vztahy. Přepis slov odlišuje počet/tempo od schopnosti; fyzikální teplota není teplotní pohodlí. | 6f–g. |
| [Psychologické skóry a kvaziintervalovost](../quarto/kapitola_01.qmd#sec-kvaziintervalove) | Rozdíl bodů versus rozdíl rysu; kvaziintervalovost jako zdůvodňované přiblížení. Počet položek, jemnost škály ani tvar rozdělení rovnost rozdílů nedokládají. Citlivost analýzy je samostatná otázka. | 6h. |
| [Diskrétnost a spojitost](../quarto/kapitola_01.qmd#sec-diskretni-spojite) a [jejich vztah k úrovni měření](../quarto/kapitola_01.qmd#sec-uroven-a-spojitost) | Možné hodnoty versus přesnost záznamu a význam jejich vztahů; půlbody mohou být diskrétní, celočíselný čas může být zaokrouhlený. VAS je vysvětlena jako nečleněná úsečka, nikoli doklad intervalovosti rysu. | 6d a i; VAS bez samostatné konstrukční úlohy. |
| [Rozdíly, chyba a nejistota](../quarto/kapitola_01.qmd#sec-nejistota) | Skutečná změna versus chyba měření; systematické zkreslení, výběrová variabilita, výběrové zkreslení, zkreslení neúčastí a chyba záznamu. Příklady odhadu spánku, politické podpory a překlepu; různé problémy vyžadují různé nápravy. | 7. |
| [Datová matice](../quarto/kapitola_01.qmd#sec-datova-matice) a [kódování](../quarto/kapitola_01.qmd#sec-kodovani) | Řádek/případ, sloupec/proměnná a buňka/hodnota; šest modelových záznamů. ID účastníka versus odpovědi a pořadí, opakované návštěvy, časové značky; pravidla názvů sloupců a dokumentovaných kódů. | 1 a 8; časové značky vysvětleny bez samostatné úlohy. |
| [Chybění](../quarto/kapitola_01.qmd#sec-chybejici) | Skutečná nula versus neměřený výkon. Kód −99 mimo přípustný rozsah pro přenos do programu versus prázdná buňka v místním Excelu; nutnost převodu kódu, záznam důvodu chybění a riziko součtu prázdných buněk. | 8. |
| [Přehled proměnných](../quarto/kapitola_01.qmd#sec-codebook) a [kontrola v Excelu](../quarto/kapitola_01.qmd#sec-kontrola-matice) | Konkrétní codebook s jednotkami, rozsahy a chyběním. Přepis do A1:E7, oddělený přehled; jedna hodnota v buňce, kontrola původních formulářů, dohledatelné opravy a zachování originálů. | 8; Excel je možnost, nikoli nutná pomůcka. |
| [Shrnutí](../quarto/kapitola_01.qmd#sec-shrnuti-01) | Spojuje význam měření, vznik dat, druhy závěrů a dokumentaci; připravuje otázku zastoupení hodnot pro kapitolu 2. | Souhrnně 1–8. |

### Příklady, vizualizace a nepovinné části

[Sešit kapitoly 1](../data/kapitola_01.xlsx) obsahuje `Prehled`, matici
`Data` A2:E7, `Promenne`, rozdíl nuly a chybění, podklad opravy a oddělené
listy `U08_podklady` a `U08_prepis` pro závěrečnou úlohu. Chybný přepis
zůstává zadáním, hotové řešení sešitem nepředkládáme.

Průběžným příkladem je autorská studie spánku a vybavování 12 slov.
Šest osob P01–P06 tvoří konkrétní matici; u P05 chybí spánek, P06 má
skutečný nulový výkon. Kapitola z těchto čísel nevyvozuje vztah spánku a paměti.
Experiment s tichem/nahrávkou slouží k odlišení manipulace a pozorování;
[diagram výběru a přidělení](../quarto/kapitola_01.qmd#fig-vyber-prideleni)
odděluje oporu pro zobecnění a kauzální závěr. Tabulky měření, věku a codebooku
umožňují porovnat význam stejných čísel a způsobů záznamu.

Nepovinná jsou čtyři rozšíření: [model měření](../quarto/kapitola_01.qmd#model-mereni-podrobne)
pro zdůvodnění intervalovosti; [spor o čísla na dresech](../quarto/kapitola_01.qmd#cisla-na-dresech)
a závislost interpretace na otázce; [posuvník a verbální kotvy](../quarto/kapitola_01.qmd#posuvnik-podrobne);
[modelové pojetí chyby měření](../quarto/kapitola_01.qmd#chyba-mereni-podrobne)
a rozdíl mezi opakovatelností a zachycením rysu. Nevyžadují se v závěrečných
úlohách jako samostatně osvojené modelové postupy.

### Cvičení a očekávané dovednosti

[Zadání i úplná sbalená řešení](../quarto/kapitola_01.qmd#sec-cviceni-01)
jsou na konci kapitoly; kalkulačka není potřeba.

| Úloha | Co student samostatně dělá |
|---|---|
| [1. Co tvoří jeden záznam](../quarto/kapitola_01.qmd#sec-uloha-01-1) | Rozliší 4 účastníky a 28 denních případů, proměnnou/hodnotu a konstantu; zachová spojení záznamů ID. |
| [2. Co nám řeknou dobrovolníci](../quarto/kapitola_01.qmd#sec-uloha-01-2) | Vymezí populaci a výběr, kritizuje zobecnění z 300 dobrovolníků, pojmenuje nábor a změní interpretaci téže skupiny při jiné otázce. |
| [3. Tři různé závěry](../quarto/kapitola_01.qmd#sec-uloha-01-3) | Oddělí popis, zobecnění a příčinný zásah a doplní potřebnou oporu. |
| [4. Co zajistilo losování](../quarto/kapitola_01.qmd#sec-uloha-01-4) | Rozliší výběr/přidělení, náhodné složení/provedení úlohy, interní/externí validitu a role proměnných. |
| [5. Co je „dobrá paměť“](../quarto/kapitola_01.qmd#sec-uloha-01-5) | Odhalí nesrovnatelnou operacionalizaci před a po programu a navrhne srovnatelné měření bez předčasné volby metody. |
| [6. Co hodnoty opravňují tvrdit](../quarto/kapitola_01.qmd#sec-uloha-01-6) | Posoudí devět tvrzení o škálách, kódech, konstruktech, přesnosti a spojitosti; zdůvodní chybějící předpoklady. |
| [7. Více údajů nevyřeší všechno](../quarto/kapitola_01.qmd#sec-uloha-01-7) | Rozezná překlep, zkreslení měření, výběrové kolísání, skutečný rozdíl a neúčast; navrhne odpovídající opatření. |
| [8. Opravte matici a zachovejte význam](../quarto/kapitola_01.qmd#sec-uloha-01-8) | Opraví ID podle podkladu, odliší nulu/chybění, sestaví matici a codebook a popíše převod do statistického programu. |

### Pojmy, hranice a návaznosti

Nově se vysvětlují metodologické a datové pojmy uvedené v tabulce; soustavné
statistické výpočetní značení se zde ještě nezavádí. **Inference je vysvětlena
jako druh usuzování, nikoli jako výpočetní postup.** Výběrová variabilita má
slovní výklad, ne rozdělení odhadů či standardní chybu. Průměr a IQ jsou
v příkladech zmíněny před jejich pozdějším systematickým výkladem. Reliabilita
ani modely měření zde netvoří samostatný výpočetní celek.

Kapitola 2 přebírá význam proměnných, chybění, případu a prvních šest záznamů.
Kapitola 3 využívá zdůvodnění škál při volbě statistik. Kapitola 4 rozvíjí
referenční skupinu, měřicí omezení a rozdíl neobvyklosti od klinického významu.
Četnosti a grafy se učí až ve 2, číselné charakteristiky ve 3.

<a id="mapa-kapitola-02"></a>

## 2. Četnosti, rozdělení dat a jejich zobrazení

**Podklad a stav:** existující [kapitola 2](../quarto/kapitola_02.qmd#sec-kapitola-02),
karta zkontrolována 2026-10-11. **Vstup:** případ, proměnná, úrovně měření,
matice, chybění a meze zobecnění z kapitoly 1. Konvence určují
[R02](ROZHODNUTI.md#r02-indexy-a-cetnosti), [R03](ROZHODNUTI.md#r03-hranice-intervalu),
[R05](ROZHODNUTI.md#r05-zaokrouhlovani) a [R13](ROZHODNUTI.md#r13-platny-udaj-velikost-vyberu).

**Cíle:** sestavit a interpretovat četnostní tabulku, určit základ procent,
přečíst sumaci, třídit do jednoznačných intervalů, volit a kriticky číst grafy,
popsat tvar rozdělení a vytvořit četnosti, sloupcový graf a histogram v Excelu.

### Skutečný obsah oddílů

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Od záznamů k četnostem](../quarto/kapitola_02.qmd#sec-od-zaznamu-k-cetnostem) a [co počítáme](../quarto/kapitola_02.qmd#sec-co-pocitame) | Absolutní četnost a tabulka na šesti odpovědích; rozdělení není obrázek ani rozdělování do skupin. Ztráta vazby na osobu, velikost výběru versus počet zahrnutých případů; nulová četnost versus chybění. | 1. |
| [Podíly a procenta](../quarto/kapitola_02.qmd#sec-relativni-cetnost), [jmenovatel](../quarto/kapitola_02.qmd#sec-jmenovatel), [zaokrouhlení](../quarto/kapitola_02.qmd#sec-zaokrouhlovani-02) | Relativní četnost, index kategorií a převod na procenta. Stejný čitatel 3, základy 6 a 5; platný údaj znamená nechybějící, nikoli nutně správný údaj. Procento osob versus odpovědí při více volbách; vzájemná výlučnost i úplnost kategorií. Zobrazení podílů na 3 a procent na 1 místo, bez zkrácení mezivýpočtů. | 1, 3, 9. |
| [Součty a sumace](../quarto/kapitola_02.qmd#sec-sumace) | Rozvinutý součet, operátor, index a meze; počet kategorií není počet osob. Součet četností a podílů vyžaduje úplné výlučné kategorie a společný základ; zaokrouhlené hodnoty se nemusí sečíst přesně. | 2. |
| [Kumulativní četnosti](../quarto/kapitola_02.qmd#sec-kumulativni-cetnosti) | Vzestupné sčítání včetně hranice, absolutní i relativní varianta; neklesající průběh, konečný součet, proč nesčítat kumulativní sloupec. Arbitrární pořadí nominálních strategií; „méně než“, „nejvýše“ a „alespoň“ včetně doplňku. | 4, návazně 3. |
| [Větší soubor](../quarto/kapitola_02.qmd#sec-modelova-data-02) | Rozšíření na 36 osob, 33 platných spánků; četnosti odpočatosti a počtů slov 0–12. Nejčetnější kategorie nemusí tvořit většinu; nulová četnost uchovává možnou hodnotu. | 1 a 10. |
| [Intervalové třídění](../quarto/kapitola_02.qmd#sec-tridni-intervaly) a [zahrnutí mezí](../quarto/kapitola_02.qmd#sec-hranice-intervalu) | Dolní/horní mez a šířka; dvě konvence na stejných datech včetně přepočtu četností. Používaná dolní vyloučená/horní zahrnutá mez, ošetření krajů a ztráta podrobností uvnitř intervalu. | 5 a 10. |
| [Sloupcový graf](../quarto/kapitola_02.qmd#sec-sloupcovy-graf) a [tečkový graf](../quarto/kapitola_02.qmd#sec-teckovy-graf) | Samostatné kategorie a pořadí odpočatosti versus každé jednotlivé pozorování na číselné ose. Skládání teček zachovává shody; svislá poloha není druhou proměnnou. | 6a–b. |
| [Histogram](../quarto/kapitola_02.qmd#sec-histogram) a [volba intervalů](../quarto/kapitola_02.qmd#sec-volba-intervalu) | Číselné intervaly, skutečné šířky a prázdné intervaly; histogram může seskupovat i diskrétní čísla. Srovnání změny šířky a posunu mezí, stabilita viditelného rysu a meze automatických nastavení. | 5–7 a 10. |
| [Graf kumulativních četností](../quarto/kapitola_02.qmd#sec-kumulativni-graf) | Schody pro jednotlivé hodnoty versus body na horních mezích seskupených dat. Přesný význam bodů včetně hranice; spojnice uvnitř intervalu není přesně zjištěný podíl. | 4 a 6d; samostatná tvorba tohoto grafu není zadána. |
| [Polygon](../quarto/kapitola_02.qmd#sec-polygon-cetnosti) | Výpočet středu intervalu po krocích; bod zastupuje všechny hodnoty intervalu. Spojnice nevyjadřuje časový průběh ani přesné hodnoty jednotlivců. | 5: střed intervalu; bez samostatné tvorby polygonu. |
| [Výsečový graf](../quarto/kapitola_02.qmd#sec-vysecovy-graf) | Části jediného celku, omezení vícečetných odpovědí; přímé srovnání tří strategií se sloupci a omezení vnímání výsečí/3D efektů. | 3b a 6a. |
| [Stonek a list](../quarto/kapitola_02.qmd#sec-stonek-list) | Rozklad osmi časů na desítky a jednotky, klíč a opakované hodnoty; rekonstrukce zachovaných čísel, nikoli pořadí nebo identity osob. | 8. |
| [Tvar rozdělení](../quarto/kapitola_02.qmd#sec-tvar-rozdeleni) a [podlaha/strop](../quarto/kapitola_02.qmd#sec-podlaha-strop) | Souměrnost, chvost a směr šikmosti, jeden/dva/více vrcholů, rovnoměrnost a odlehlost. Dva sousední nejvyšší sloupce nejsou automaticky dvě skupiny. Meze nástroje a nahromadění nejsou samy vysvětlením tvaru. | 7. |
| [Zavádějící zobrazení](../quarto/kapitola_02.qmd#sec-zavadejici-grafy) | Čtení os, základu a velikosti výběru; nula u délky sloupců, srovnatelná měřítka histogramů, plochy zvětšovaných ikon. Graf není sám důkazem o populaci či příčině. | 9 a argumentace v 6–7. |
| [Excel: absolutní četnosti](../quarto/kapitola_02.qmd#sec-excel-pocet-countifs) | POČET, COUNTIFS a SUMA; oblast, název listu, pevné a posuvné odkazy. Počet čísel nekontroluje jejich přípustnost. | 10. |
| [Excel: relativní a kumulativní](../quarto/kapitola_02.qmd#sec-excel-relativni-kumulativni) | Podíl s pevným jmenovatelem, procentní formát bez násobení stem, rozšiřující se oblast kumulativního součtu a kontroly. | 10. |
| [Excel: intervaly a grafy](../quarto/kapitola_02.qmd#sec-excel-histogram) | COUNTIFS se dvěma mezemi a spojením podmínky pomocí `&`; tvorba sloupcového grafu a histogramu z stejně širokých intervalů. Nulová mezera, zachované prázdné intervaly, kontrola alternativního automatického histogramu. | 10: předpověď a kontrola změny. |
| [Shrnutí](../quarto/kapitola_02.qmd#sec-shrnuti-02) | Spojuje otázku, jmenovatel, pořadí a meze s volbou zobrazení; připomíná rozdíl popisu a vysvětlení. | Souhrnně 1–10. |

### Příklady, vizualizace a soubory

[Grafy četností](../quarto/kapitola_02.qmd#sec-grafy-cetnosti) sdružují
výklad sedmi typů zobrazení; navazující [četnosti a grafy v Excelu](../quarto/kapitola_02.qmd#sec-excel-cetnosti)
propojují tabulky a tvorbu vybraných grafů s konkrétním sešitem.

[Sešit kapitoly 2](../data/kapitola_02.xlsx) obsahuje podle výkladu listy
`Data`, `Cetnosti`, `Histogram`; 36 záznamů je v řádcích 2–37 a popis
proměnných vpravo od dat. Navazuje prvních šest osob z kapitoly 1;
spánek chybí u P05, P11 a P24. Všechna data jsou sestavená pro výuku.
Samostatné listy doplňují strategie učení, časy dokončení, srovnání skupin
a vstupy cvičení 1–5, 8–9. Cvičení 10 používá `Data`; 6–7 jsou slovní
zadání bez konkrétních jednotlivých pozorování. První list `Prehled` uvádí
návaznosti a oblasti. [Pokrytí všech cvičení](DATA.md).

Grafy nejsou jen ukázkami typů: [základy procent](../quarto/kapitola_02.qmd#fig-zaklad-procent),
[princip kumulace](../quarto/kapitola_02.qmd#fig-princip-kumulace) a
[meze intervalů](../quarto/kapitola_02.qmd#fig-meze-intervalu) vysvětlují
konkrétní rozhodnutí ve výpočtu. Srovnání histogramů mění šířku a polohu
mezí při stejných datech; dvojice kumulativních grafů odděluje jednotlivé
hodnoty od seskupení. Přehled tvarů, podlahy/stropu a dvojice os 30 versus
32 učí kritické interpretaci. Tři rekonstrukce listů doprovázejí excelové
odkazy a vzorce; nejsou vydávány za snímky spuštěné aplikace.

### Cvičení a očekávané dovednosti

[Deset úloh se sbalenými řešeními](../quarto/kapitola_02.qmd#sec-cviceni-02)
používá kalkulačku, závěrečná Excel. Text vymezuje toleranci pro podíly
a procenta; celočíselné četnosti mají souhlasit přesně.

| Úloha | Co student samostatně dělá |
|---|---|
| [1. Od odpovědí k tabulce](../quarto/kapitola_02.qmd#sec-uloha-02-1) | Z 12 odpovědí sestaví četnosti a procenta, určí n/k, kontroluje součty a rozliší nejčetnější od většinové odpovědi. |
| [2. Co říká sumace](../quarto/kapitola_02.qmd#sec-uloha-02-2) | Rozepíše částečný součet kategorií 2–4 a vysvětlí, proč mez není počet osob. |
| [3. Chybění a jmenovatele](../quarto/kapitola_02.qmd#sec-uloha-02-3) | Porovná základ 20 odpovídajících a 25 oslovených, odmítne záměnu chybění za „ne“; vysvětlí součet nad 100 % u více voleb. |
| [4. Kumulování a meze](../quarto/kapitola_02.qmd#sec-uloha-02-4) | Sestaví kumulativní tabulku počtů chyb a správně použije méně než / nejvýše / alespoň a doplněk. |
| [5. Intervaly a podrobnosti](../quarto/kapitola_02.qmd#sec-uloha-02-5) | Roztřídí osm dob, porovná pravidla mezí, určí střed a vysvětlí nedostupnost přesného podílu uvnitř intervalu. |
| [6. Volba grafu](../quarto/kapitola_02.qmd#sec-uloha-02-6) | Zdůvodní zobrazení nominálních strategií, malého souboru skórů, mnoha časů a kumulativního podílu. |
| [7. Tvar](../quarto/kapitola_02.qmd#sec-uloha-02-7) | Interpretuje chvost, dva/tři vrcholy, strop a rovnoměrnost; neodstraňuje data pro hezčí graf ani nedokazuje psychologické typy. |
| [8. Stonek a list](../quarto/kapitola_02.qmd#sec-uloha-02-8) | Rekonstruuje sedm časů včetně opakování a vymezí ztracenou informaci. |
| [9. Procenta a optický dojem](../quarto/kapitola_02.qmd#sec-uloha-02-9) | Porovná 30/40 a 32/80, opraví zkrácenou osu i závěr založený pouze na absolutních četnostech. |
| [10. Ověření v Excelu](../quarto/kapitola_02.qmd#sec-uloha-02-10) | Předpoví a ověří přesun odpočatosti 2 → 3 a spánku 6 → 7; zkontroluje četnosti, kumulaci a neměnný počet platných údajů, pak vstupy obnoví. |

### Pojmy, hranice a návaznosti

Nové jsou četnosti, rozdělení, platný údaj, velikost výběru, index, sumace,
intervalové třídění, typy grafů a pojmy tvaru. Výklad zavádí `n`, `k`,
`f_j`, `p_j`, kumulativní varianty a rozlišení indexů `i`/`j`; `x_i`
je konkrétně využito v kapitole 3. Novými vysvětlenými funkcemi jsou
POČET, COUNTIFS a SUMA s odkazy do [přehledu Excelu](../quarto/excel.qmd).

**Nepovinné** je okénko o nestejně širokých intervalech v
[oddílu o jejich volbě](../quarto/kapitola_02.qmd#sec-volba-intervalu):
četnost/podíl dělený šířkou a plocha obdélníku; formální pojem hustoty
se zde nezavádí. Kapitola 4 proto vztah plochy a podílu vysvětluje samostatně.
Číselné ukazatele, kvantily a koeficienty tvaru přebírá kapitola 3.
Kontingenční tabulky a vztahy dvou kategoriálních proměnných nejsou vyloženy.
Modelové a populační rozdělení jsou zatím jen odlišeny od pozorovaných dat.

<a id="mapa-kapitola-03"></a>

## 3. Ukazatele polohy a variability

**Podklad a stav:** existující [kapitola 3](../quarto/kapitola_03.qmd#sec-kapitola-03),
karta zkontrolována 2026-10-11. **Vstup:** význam měření z kapitoly 1;
četnosti, procenta, sumace a grafy z kapitoly 2. Konvence upravují
[R01](ROZHODNUTI.md#r01-znaceni-a-reportovani), [R04](ROZHODNUTI.md#r04-kvantily),
[R05](ROZHODNUTI.md#r05-zaokrouhlovani), [R06](ROZHODNUTI.md#r06-robustni-shrnuti)
a [R14](ROZHODNUTI.md#r14-kvartily-spicatost-chvost).

**Cíle:** volit ukazatele podle otázky a měření; vysvětlit a provést výpočet
středu, kvantilů a variability; sestavit boxplot; posoudit vzdálené hodnoty,
ořezání a winsorizaci; předpovědět změnu statistik při převodu jednotek
a srozumitelně popsat data. Výpočty entropie a momentových koeficientů
jsou nepovinné, základní význam entropie je součástí hlavního výkladu.

### Skutečný obsah oddílů

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Co souhrnné ukazatele zachycují](../quarto/kapitola_03.qmd#sec-poloha-variabilita) | Poloha a variabilita na dvou souborech se stejným průměrem; statistika jako vypočtená charakteristika versus parametr populace/modelu. Význam měřicí škály a omezenost souhrnu. | 11, návazně 12. |
| [Modus](../quarto/kapitola_03.qmd#sec-modus) | Nejčastější hodnota/kategorie, několik modů, rovnost všech četností; modus není jeho četnost. Přesný modus jemných časů versus nejčetnější interval, lokální vrcholy versus stejně četné hodnoty. | 1. |
| [Medián](../quarto/kapitola_03.qmd#sec-median) | Seřazení, lichý/sudý počet, průměr prostředních čísel a „alespoň polovina“ při shodách. U ordinálních kategorií se kódy neprůměrují; lze uvést dvě prostřední kategorie. | 1, 3–4. |
| [Průměr](../quarto/kapitola_03.qmd#sec-prumer) | Zavedení x_i, součtu a dělení počtem; průměr přidělených bodů versus silnější interpretace rysu. Změna jedné doby z 10 na 30 posune průměr, ne medián/modus. Normalita není podmínkou výpočtu průměru. | 1 a 5. |
| [Volba středu](../quarto/kapitola_03.qmd#sec-volba-stredu) a [střed/tvar](../quarto/kapitola_03.qmd#sec-stred-tvar) | Tři různé otázky, geometrický význam, výhody/omezení. Modely souměrného a dvou směrů šikmého tvaru; obvyklé pořadí středu není univerzální test šikmosti a shoda středu nedokazuje symetrii. | 1; pořadí tří středů vyloženo bez samostatné diagnostické úlohy. |
| [Průměr více skupin](../quarto/kapitola_03.qmd#sec-vazeny-prumer) | Váhy velikostí skupin přes jejich celkové příspěvky; průměr skupinových průměrů odpovídá jiné otázce. Úplné četnosti versus aproximace středy intervalů; skupinové mediány nestačí. Průměr součtu vyložen slovně, variabilita součtu odložena. | 2. |
| [Kvantily a interpolace](../quarto/kapitola_03.qmd#sec-kvantily), [výpočet](../quarto/kapitola_03.qmd#sec-vypocet-kvantilu) | Percentily, 1./2./3. kvartil, q_p a úroveň p; seřazené x_(i). PERCENTIL.INC: n−1 mezer, přiřazené úrovně, pozice a lineární interpolace. Jedenáct časů a 17. percentil; shody, krajní úrovně, jediná hodnota. Výsledek nemusí být pozorován ani pokrýt přesně dané procento dat. | 3, 9 a 12. |
| [Kumulativní kvantil](../quarto/kapitola_03.qmd#sec-kvantil-kumulativni) | První pozorovaná hodnota/kategorie, která dosáhne požadovaného podílu. Kontrast 90% časového limitu s interpolací; dosažení už u minima. Odpočatost a výběr nižší prostřední kategorie při 50 %; změna ordinálních kódů nemění kategorii. | 4; časový limit je řešeným příkladem. |
| [Percentilové pořadí](../quarto/kapitola_03.qmd#sec-percentilove-poradi) | Inkluzivní konvence versus exkluzivní a kompromisní; stejný jmenovatel, odlišné započítání shod. Srovnání s úrovněmi PERCENTIL.INC, nevratnost převodů a interval úrovní pro shodnou hodnotu. Zápis pořadí bez tečky, směr „lepšího“ výsledku a rozdíl od procenta správných odpovědí. | 3, návazně 4/1 a 7. |
| [Rozpětí](../quarto/kapitola_03.qmd#sec-rozpeti) | Pozorované minimum/maximum versus meze nástroje; variační a mezikvartilové rozpětí. Přidávání údajů nemůže zmenšit rozpětí, ale větší samostatný výběr nemusí mít vždy větší rozpětí. Kvartilový interval nemusí obsahovat přesně polovinu a rozdíl ordinálních kódů není vzdálenost. | 3, 7, 9 a 12. |
| [Odchylky](../quarto/kapitola_03.qmd#sec-odchylky) a [MeanAD](../quarto/kapitola_03.qmd#sec-prumerna-absolutni) | Podepsané odchylky se kolem přesného průměru vyruší; absolutní hodnota převádí odchylku na vzdálenost. Výpočet MeanAD a jeho citlivost; odlišení nejednoznačné zkratky MAD od zdejších MeanAD/MedAD. | 5. |
| [Čtverce a rozptyl](../quarto/kapitola_03.qmd#sec-rozptyl) | Druhá mocnina, součet čtverců odchylek versus čtverce hodnot či součtu; geometrická plocha a čtvereční jednotky. Dělení n pro empirické rozdělení versus výběrové s² s n−1; nemožnost výpočtu s² z jediné hodnoty. | 5. |
| [Korekce a stupně volnosti](../quarto/kapitola_03.qmd#sec-korekce-rozptylu) | Přizpůsobení průměru datům snižuje součet čtverců; podmínka nulového součtu váže poslední odchylku, žádná osoba se nevyřazuje. Nestrannost jako vlastnost opakovaného odhadování při uvedených předpokladech. Simulace 20 000 výběrů pro každé n = 5, 20, 100 z pětihodnotové populace. | 5–6; simulace není obecný důkaz. |
| [Směrodatná odchylka](../quarto/kapitola_03.qmd#sec-smerodatna-odchylka) | Odmocnina vrací původní jednotky, přibližná rovnost a rozdíl od MeanAD. SD není stejná odchylka každého člověka ani bez modelu neurčuje podíl v m ± s. Nestrannost rozptylu se nepřenáší na jeho odmocninu. | 5–6 a 12. |
| [MedAD](../quarto/kapitola_03.qmd#sec-median-absolutnich) | Tři kroky přes medián dat a medián absolutních vzdáleností. Robustnost/odolnost a její meze; nulové MedAD nemusí znamenat shodná data. Používá se nepřepočtená hodnota, zmíněna softwarová škálovací konstanta. | 7. |
| [Ořezání a winsorizace](../quarto/kapitola_03.qmd#sec-orezani-winsorizace) | Vynechání versus nahrazení krajních hodnot pro výpočet, zachování originálů. Podíl na každém konci a zaokrouhlení počtu dolů; 10 dob a příklad 18 hodnot. Medián jako krajní případ ořezání; nevolit úpravu podle žádoucího výsledku a nezaměňovat odhadované charakteristiky. | 8. |
| [Krabicový graf](../quarto/kapitola_03.qmd#sec-boxplot) | Úplná konstrukce z 41 skórů: interpolované kvartily, medián, IQR, pomocné meze 1,5 IQR, vousy na pozorováních a body za mezemi. Meze nejsou konce vousů; zvláštní případ nulového IQR, varianty boxplotů a skryté vrcholy. | 9: výpočet i ruční kresba; Excel ověřuje kvartily, nevykládá samostatný postup tvorby boxplotu. |
| [Entropie](../quarto/kapitola_03.qmd#sec-entropie) | Základní slovní význam rozmanitosti kategorií: úplná koncentrace, maximum při rovnoměrnosti pro stejné k, jednotka bit a závislost na vymezení kategorií. Entropie není rozptyl kódů ani kvalita strategií. | 11 slovně; výpočet pouze nepovinně v 13. |
| [Posun a změna jednotek](../quarto/kapitola_03.qmd#sec-zmena-skaly) a [vlastnosti ukazatelů](../quarto/kapitola_03.qmd#sec-vlastnosti-ukazatelu) | Transformace y_i = a + b x_i, statistické označení lineární versus přesnější afinní. Posun, převod minut, b = 0 a obrácené skórování; změna polohy, SD o absolutní násobitel, rozptylu o jeho čtverec a výměna kvartilů při obrácení pořadí. | 10. |
| [Nelineární transformace](../quarto/kapitola_03.qmd#sec-nelinearni-transformace) | Druhé mocniny různě mění stejné rozdíly. Průměr se musí přepočítat; zachování pořadí pomáhá přímo pozorovanému mediánu, ne automaticky interpolovanému kvantilu. Pořadová statistika versus širší ukazatel založený na uspořádání. | Řešené kontrasty; závěrečná 10 procvičuje lineární převod. |
| [Volba a komunikace statistik](../quarto/kapitola_03.qmd#sec-komunikace-statistik) | Otázka → význam měření → graf → souhrn; tabulka doporučených popisů a omezení. Slovní zpráva o 33 spáncích a 36 paměťových výkonech bez tvrzení o populaci. | 1 a 12. |
| [APA 7](../quarto/kapitola_03.qmd#sec-reportovani-apa), [zaokrouhlení](../quarto/kapitola_03.qmd#sec-zaokrouhlovani-03), [nula v grafu](../quarto/kapitola_03.qmd#sec-nula-graf) | Výpočetní m/s versus reportovací M/Mdn/SD/N/n; anglická a česká ukázka, přesnost podle účelu. Tvar se čte z grafu, ± SD není interval nejistoty průměru. Přirozená nula je jiná otázka než nulová základna délky sloupce. | 12; grafická zásada navazuje na 2/9. |
| [Od dat k modelu](../quarto/kapitola_03.qmd#sec-popis-a-model) | Tři modely se stejným průměrem a SD, různým tvarem a počtem možných hodnot. Parametrická rodina přidává předpoklad; neparametrický popis není „bez čísel/předpokladů“. Normální rodina uvedena jako most ke 4. | 11. |
| [Nepovinné momenty](../quarto/kapitola_03.qmd#sec-momenty) včetně [špičatosti](../quarto/kapitola_03.qmd#sec-spicatost) | Řád a centrum momentu, třetí/čtvrtá mocnina, g₁ a g₂, rozlišení špičatosti a excesu. Nulová šikmost nedokazuje symetrii, výška vrcholu neurčuje špičatost; korekce SKEW/KURT, malá n a nulová variabilita. | Nepovinná 14. |
| [Excel: základní ukazatele](../quarto/kapitola_03.qmd#sec-excel-zaklad-03) | POČET, PRŮMĚR, MEDIAN, MODE.SNGL, MIN/MAX, PERCENTIL.INC a rozpětí. Omezení MODE.SNGL a inkluzivní pořadí přes COUNTIFS/POČET, nikoli automaticky PERCENTRANK. | 12. |
| [Excel: odchylky](../quarto/kapitola_03.qmd#sec-excel-odchylky-03) a [MedAD](../quarto/kapitola_03.qmd#sec-excel-mad-03) | Pomocné sloupce odchylek, ABS a mocnin; SUMA, VAR.P/VAR.S, SMODCH.VÝBĚR.S/ODMOCNINA. MedAD přes medián a absolutní vzdálenosti; souhrn spánku/paměti s vlastními počty platných údajů. | 12 pro základní souhrn; mezikroky ručně v 5 a 7. |
| [Nepovinný Excel](../quarto/kapitola_03.qmd#rozsireni-excel-03) | LOGZ se základem 2 a KDYŽ pro nulový podíl; sloupce mocnin a SKEW.P, SKEW, KURT. KURT vrací korigovaný exces, další trojka se neodečítá. | Rozšíření lze použít ke kontrole 13–14; úlohy jej výslovně nevyžadují. |

### Příklady, vizualizace a soubory

[Sešit kapitoly 3](../data/kapitola_03.xlsx) je jediným studentským datovým
souborem této kapitoly. Podle výkladu obsahuje `Priklad` (pět časů v A2:A6),
`Data` a `Souhrn` (spánek/paměť), `Rozsireni` a oddělené vstupy
`Kvantily` A2:A12, `Orezani` A2:A11 a `Boxplot` A2:A42. Kontrolní výpočty
jsou na `Kontrola_prikladu`, pět časů bez výpočtů na `Zaklad_data`.
Další listy pokrývají menší příklady a všech 14 cvičení včetně zadaných
souhrnů. První list `Prehled` uvádí umístění. [Pokrytí cvičení](DATA.md).

| Příklad / lokátor | Didaktický účel a původ |
|---|---|
| [4, 5, 5, 6, 10 minut](../quarto/kapitola_03.qmd#sec-stred-rozdeleni) | Autorský soubor propojuje střed, kvantily, pořadí, odchylky, rozptyl, MedAD a Excel; varianta 10 → 30 ukazuje citlivost. |
| [Dvě skupiny 10 a 30 osob](../quarto/kapitola_03.qmd#fig-vazeny-prumer) | Příspěvky k součtu zdůvodňují vážení průměrů, nikoli mechanický průměr dvou čísel. |
| [Jedenáct různých časů](../quarto/kapitola_03.qmd#fig-kvantil-interpolace) a [percentil/pořadí](../quarto/kapitola_03.qmd#fig-percentil-a-poradi) | Úrovně přiřazené pozicím, detail 17. percentilu a opačné otázky „podíl → hodnota“ / „hodnota → zastoupení“. |
| [Odchylky a čtverce](../quarto/kapitola_03.qmd#fig-odchylky-ctverce) | Délky a plochy vysvětlují absolutní a kvadratické příspěvky; plocha nemění jednotku svislé osy. |
| [Simulace korekce](../quarto/kapitola_03.qmd#fig-korekce-rozptylu) | Opakované náhodné výběry s vracením ze známé modelové populace ilustrují dlouhodobé podhodnocení při dělení n. |
| [Deset časů](../quarto/kapitola_03.qmd#fig-orezani-winsorizace) | Stejné krajní hodnoty, ale jiný počet členů/jmenovatel při ořezání a winsorizaci. |
| [41 skórů](../quarto/kapitola_03.qmd#fig-boxplot-03) | Vedle původních bodů ukazuje krabici, pomocné meze, skutečné konce vousů a samostatné body. |
| [Strategie učení](../quarto/kapitola_03.qmd#fig-entropie) | Tři rozdělení mezi čtyři kategorie oddělují koncentraci a rovnoměrnost bez nutnosti výpočtu logaritmů. |
| [Transformace](../quarto/kapitola_03.qmd#fig-transformace) a [stejné dvě statistiky](../quarto/kapitola_03.qmd#fig-stejne-statistiky) | Lineární versus nelineární změna vzdáleností; přesně shodné parametry tří modelů nepředstavují shodné rozdělení. |
| [Geometrie středu](../quarto/kapitola_03.qmd#fig-vyznam-stredu), [střed/tvar](../quarto/kapitola_03.qmd#fig-stred-tvar), [špičatost](../quarto/kapitola_03.qmd#fig-spicatost) | První obrázek je převzatý od Cmglee s licencí uvedenou v kapitole; ostatní jsou modelové ilustrace. Špičatost se vysvětluje na odlišných krajních hodnotách při stejné četnosti vrcholu. |

Data o spánku a paměti pokračují z kapitoly 2; ostatní pevné příklady jsou
sestavené pro výuku. Simulace je odlišena od pevných dat a obrázky populačních
modelů od náhodných výběrů. Tuto odlišnost je nutné zachovat i v pokračování.

### Cvičení a očekávané dovednosti

[Úlohy 1–14](../quarto/kapitola_03.qmd#sec-cviceni-03) mají bezprostřední
sbalená řešení. Jednotlivé nadpisy nemají explicitní ID, proto tato mapa
odkazuje na stabilní oddíl cvičení a používá číslo i název. Základem je
kalkulačka, u úlohy 12 Excel; kvantily podle PERCENTIL.INC, výsledky zpravidla
na dvě místa s tolerancí 0,01. Reportovací část 12 má vlastní přesnost.

| Úloha | Co student samostatně dělá |
|---|---|
| 1. Jaký střed hledáme | Spočítá tři středy šesti časů, volí podle otázky a odmítne automatické odstranění dlouhého času. |
| 2. Dvě různě velké skupiny | Spojí průměry vahami 8 a 12 osob; vysvětlí nedostatek skupinových mediánů pro společný medián. |
| 3. Kvantily a shodné hodnoty | Určí kvartily/IQR a inkluzivní pořadí při shodách; u 17. percentilu jedenácti různých časů odliší přiřazenou úroveň od skutečně zahrnutého podílu. |
| 4. Co je na ordinální škále přípustné | Zpochybní průměrování prostředních kódů a určí 50./75. percentil pravidlem první dosažené kumulativní úrovně. |
| 5. Výpočet variability | Provede všechny mezikroky od průměru k MeanAD, s² a s; vyloží nulový součet odchylek a stupně volnosti. |
| 6. Co dokládá simulace korekce | Odliší nestrannost od přesnosti každého odhadu a vysvětlí, proč se nepřenáší na odmocninu. |
| 7. Medián absolutních odchylek | Spočítá MedAD a předpoví změnu 16 → 100; rozliší odolnost ukazatele a změnu celkové variability. |
| 8. Ořezání a winsorizace | Provede 20 % z každého konce deseti časů; porovná jmenovatele a určí počty při 10 % z 18 hodnot včetně zaokrouhlení dolů. |
| 9. Krabicový graf | Spočítá kvartily, meze a konce vousů osmi časů, vyznačí samostatný bod a nakreslí vodorovný graf. |
| 10. Změna jednotek a obrácení škály | Převede polohu, SD a rozptyl po přičtení dvou minut a změně na sekundy; zdůvodní nezápornost SD. |
| 11. Rozmanitost kategorií a meze souhrnu | Slovně porovná entropii koncentrace/rovnoměrnosti a odmítne odvozování stejného či normálního rozdělení ze stejného průměru/SD. |
| 12. Samostatný popis dat v Excelu | Spočítá souhrn 36 paměťových výkonů, napíše přístupný popis a omezení, poté českou reportovací ukázku APA. |
| 13. Nepovinně: entropie od četností | Spočítá entropii i normalizovanou variantu; odliší přidání prázdné kategorie od změny zastoupení a interpretuje úplnou koncentraci. |
| 14. Nepovinně: nulová šikmost a stejný vrchol | Ověří nesouměrný protipříklad s g₁ = 0 a výpočtem vysvětlí různou špičatost při stejné četnosti vrcholu. |

### Pojmy, hranice a návaznosti

Nové pojmy zahrnují statistiku/parametr, ukazatele středu a variability,
kvantily/interpolaci/percentilové pořadí, odchylky, stupně volnosti,
nestranný odhad, robustnost, boxplot, entropii a transformace. Značení
zahrnuje `x_i`, `x_(i)`, `m`, medián, `q_p`, `s²`, `s`, absolutní hodnotu,
odmocninu, `a`, `b`, `y_i` a `h` u entropie. Výpočet entropie,
logaritmus a koeficienty `g₁` a `g₂` patří do nepovinného rozšíření.
Úplné definice a varianty se nepřenášejí do této mapy.

**Vysvětleno pouze v omezeném rozsahu:** nestrannost a stupně volnosti
na konkrétním rozptylu; parametrický/neparametrický popis jako rozdíl
v předpokladu rodiny modelů. **Zmíněno/odloženo:** variabilita součtu závisí
na vztahu proměnných, ale kovariance ani korelace zde nejsou vyloženy;
interval nejistoty průměru se odlišuje od ± SD, nekonstruuje se.

**Nepovinné:** [logaritmus, entropie a její normalizace](../quarto/kapitola_03.qmd#rozsireni-entropie),
[momenty a koeficienty](../quarto/kapitola_03.qmd#rozsireni-momenty),
[odpovídající Excel](../quarto/kapitola_03.qmd#rozsireni-excel-03) a úlohy 13–14.
Kapitola 4 může předpokládat průměr, SD, kvantily, lineární převod, grafy
a rozlišení dat/modelu; znalost logaritmů, entropického vzorce a momentů
předpokládat nesmí. Na konci výkladu již existuje most k normální rodině,
nikoli ještě výpočet jejích ploch.

<a id="mapa-kapitola-04"></a>

## 4. Normální rozdělení a standardní skóry

**Podklad a stav:** existující [kapitola 4](../quarto/kapitola_04.qmd#sec-kapitola-04),
karta zkontrolována 2026-10-11. Původní schválený plán byl nahrazen mapou
skutečného textu; dohody z 2026-10-10 a úpravy z 2026-10-11 zůstávají doloženy
v [historii přípravy](../quarto/README.md#priprava-kapitoly-4) a rozhodnutích
[R07](ROZHODNUTI.md#r07-normovane-normalni), [R08](ROZHODNUTI.md#r08-terminologie-kapitoly-4),
[R09](ROZHODNUTI.md#r09-kapitola-4-model-qq) a [R15](ROZHODNUTI.md#r15-zapis-normalniho-modelu).

**Vstup:** populace/výběr, význam a meze měření, spojitost, histogram,
relativní a kumulativní četnosti, průměr, SD, kvantily, percentilové pořadí
a lineární transformace. Nepředpokládají se nepovinné nestejné šířky
histogramu ani momentové koeficienty. **Cíle:** vypočítat/interpretovat
z-skór; odlišit standardizaci od normality; číst zápis normálního modelu;
převádět hodnoty a modelové podíly oběma směry; používat standardní skóry,
steny/staniny; sestavit a interpretovat Q–Q graf a společně s kontextem
a histogramem posoudit přiměřenost modelu.

### Skutečný obsah oddílů

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Poloha a z-skór](../quarto/kapitola_04.qmd#sec-z-skor), [referenční skupina](../quarto/kapitola_04.qmd#sec-referencni-skupina) | Hrubý skór, skupina a normativní soubor; odečtení průměru a dělení SD, znaménko, nula, jednotky a zpětný převod. Kladné s a nejméně dvě hodnoty; dva testy s různými měřítky, vyšší z není automaticky lepší výkon či více schopnosti. | 1. |
| [Standardizace](../quarto/kapitola_04.qmd#sec-standardizace) | Vlastní m/s vytvoří průměr 0 a výběrovou SD 1, zachová tvar, shody a pořadí; jiné normy tuto vlastnost souboru nezaručí. Pět časů z kapitoly 3 před/po převodu. Širší standardizace testu odlišena. | 2; 1 požaduje vysvětlit nedostatek pro percentilové pořadí. |
| [Normální model](../quarto/kapitola_04.qmd#sec-normalni-model) a [parametry](../quarto/kapitola_04.qmd#sec-parametry-normalniho) | Spojitá symetrická jednovrcholová rodina, shoda středů a neomezené chvosty versus histogram a omezený skór. Parametry μ/σ versus výběrové m/s; N(μ, σ) a alternativní konvence s rozptylem. Samostatná změna polohy a šířky křivky. | 3 a 10. |
| [Normované normální rozdělení](../quarto/kapitola_04.qmd#sec-normovane-normalni) | N(0, 1), modelový převod z = (x − μ)/σ a souvislost s datovým z-skórem. Normalita zde vychází z modelu, ne ze samotného přepočtu. | 3–5. |
| [Hustota a plocha](../quarto/kapitola_04.qmd#sec-hustota) | Od plochy obdélníku s výškou podíl/šířka ke křivce; výška hustoty není podíl, změna jednotek zachová odpovídající plochu. Modelový podíl propojen s pravděpodobností výsledku náhodně vybraného člověka. | 3–4; bez obecné teorie pravděpodobnosti. |
| [Bod a zaokrouhlený interval](../quarto/kapitola_04.qmd#sec-bod-a-interval) | Jediná přesná hodnota má v tomto spojitém modelu nulovou plochu; zaznamenaná 50 může znamenat 49,5–50,5. Odlišení původně diskrétního počtu; méně/nejvýše se v modelu shoduje, v datech nemusí. | 6; jde o základní učivo, nikoli nepovinné okénko. |
| [Pravidlo 68–95–99,7](../quarto/kapitola_04.qmd#sec-pravidlo-normalni) | Intervaly ±1/2/3 SD a chvosty, přibližné podíly versus prostředních 95 % při ±1,96. Pravidlo nelze přenést na libovolná data jen ze znalosti m/s. | 3 a orientační část 7. |
| [Distribuční funkce](../quarto/kapitola_04.qmd#sec-distribucni-funkce) | Kumulace plochy zleva a protějšek empirické kumulativní četnosti; na dvou grafech stejný podíl jako plocha hustoty versus výška distribuční funkce. | 4. |
| [Hodnota → podíl a Excel](../quarto/kapitola_04.qmd#sec-excel-normalni) v [celém oddílu](../quarto/kapitola_04.qmd#sec-hodnota-podil) | NORM.S.DIST s PRAVDA po standardizaci a přímá NORM.DIST. Podíl nad hranicí jako doplněk, mezi dvěma hranicemi jako rozdíl levých ploch; oblast, odhad a kontrola znaménka. NEPRAVDA vrací hustotu; modelové pořadí není procento správných úloh. | 4. |
| [Podíl → hodnota](../quarto/kapitola_04.qmd#sec-podil-hodnota), [modelový percentil](../quarto/kapitola_04.qmd#sec-normalni-kvantil) | NORM.S.INV pro podíl vlevo a návrat x = μ + σz; NORM.INV jako přímá varianta. Rozsah p bez 0/1, kladná SD, kontrola opačným převodem; PERCENTIL.INC potřebuje data a řeší jinou otázku. | 5. |
| [Prostřední podíl versus horní chvost](../quarto/kapitola_04.qmd#sec-centralni-podil) | Rozdělení zbytku do dvou chvostů při prostředních 95 % versus jediná hranice horních 5 %. Interval jednotlivých výsledků není interval spolehlivosti parametru ani diagnostický práh. | 5. |
| [Lineární standardní škály](../quarto/kapitola_04.qmd#sec-prepocty-skoru) | z, T, IQ 100/15 a subtest 10/3; obecný převod i obrácení. Vážený skór jako alternativní označení, nikoli vážený součet. Převod sám nepotřebuje normalitu a nemění konstrukt. Graf přidává percentilová pořadí až pod podmínkou normálního modelu. | 7. |
| [Steny a staniny](../quarto/kapitola_04.qmd#sec-steny-staniny) | Deset/devět pásem, pomocný lineární převod versus kategorie, tabulky z-mezí a modelových podílů. Horní mez zahrnutá, krajní pásma neomezená, nestejné četnosti a ztráta jemnosti; u reálných testů rozhoduje manuál. | 8; tabulky jsou k dispozici, meze se nememorují. |
| [Normalizace a pořadí](../quarto/kapitola_04.qmd#sec-normalizace) | Princip přiřazení normálního kvantilu podle pořadí, vliv shod a konečného souboru; mění se rozestupy. Odlišení od standardizace a nepřímé povahy důkazu o původních skórech. Percentilové pořadí není lineární škála. | Nelineárnost pořadí v 7; algoritmus normalizace ani tvorba norem se neprocvičují. |
| [Přiměřenost modelu](../quarto/kapitola_04.qmd#sec-primerenost-modelu) | Otázka, skupina, proměnná, meze škály, chyby a možné směsi. Histogram při různých intervalech, body/boxplot; křivka na histogramu s hustotní osou. Dobrá shoda středu nestačí pro odhad chvostu. | 10. |
| [Princip Q–Q](../quarto/kapitola_04.qmd#sec-qq-graf) | Teoretický normální kvantil na X, seřazený skór na Y; nikoli dvojice měření dvou vlastností. Přímka m + sz plyne ze změny měřítka, nemusí mít úhel 45°. Náhodné odchylky a slabá informace z malého souboru. | 9–10. |
| [Tvorba Q–Q v Excelu](../quarto/kapitola_04.qmd#sec-excel-qq) | Dvanáct seřazených skórů; středy pořadových dílků p = (i − 0,5)/n, NORM.S.INV a přímka. Teoretický kvantil není standardizovaný pozorovaný skór; postup není PERCENTIL.INC ani percentilové pořadí. Bodový XY graf se dvěma řadami a přesně určenými osami. | 9; povinná dovednost. |
| [Čtení odchylek](../quarto/kapitola_04.qmd#sec-qq-odchylky) a závěr oddílu o přiměřenosti | Čtyři dvojice histogram/Q–Q pro 200 simulovaných hodnot: normální tvar, rozdělení zešikmené doprava, těžší chvosty a směs. Uveden i opačný směr u kratších chvostů. Graf neověřuje reprezentativnost, měření ani nezávislost; větší n nenormalizuje hodnoty. | 10 výslovně těžší chvosty i rozdělení zešikmené doprava; směs je řešenou ilustrací. |
| [Shrnutí](../quarto/kapitola_04.qmd#sec-shrnuti-04) | Relativní poloha, dodatečný modelový předpoklad a meze interpretace; neobvyklost není sama klinická závažnost. | Souhrnně 1–10. |

### Příklady, vizualizace a soubory

[Sešit kapitoly 4](../data/kapitola_04.xlsx) doprovází výpočty; text přesně
popisuje list `Model` (parametry, plochy a inverzní převody) a `QQ`
(A2:E13 a souhrn H2:H4). Samostatné vstupy Q–Q jsou na `QQ_data`
A2:A13, další listy pokrývají příklady, cvičení 1–9 a čtyři soubory
simulovaných skórů z obrázků. Cvičení 10 je slovním zadáním; individuální
skóry zadány nejsou. První list `Prehled` uvádí oblasti a návaznosti.
Studentům se poskytuje pouze XLSX. [Pokrytí cvičení](DATA.md).

Průběžný model skóru pozornosti **N(50, 10)** je ilustrační, není normou
skutečného testu. Ukazuje podíl do/nad 60, mezi 60 a 70, 90. percentil,
prostředních 95 % a horních 5 %. Pět časů z kapitoly 3 propojuje standardizaci
s lineární transformací. Dvanáct skórů 35 až 65 má sloužit konstrukci Q–Q,
nikoli spolehlivému odhadu velmi vzdálených chvostů populace.

[Z-skór jako krok SD](../quarto/kapitola_04.qmd#fig-z-jako-jednotka),
[standardizace](../quarto/kapitola_04.qmd#fig-standardizace-04),
[parametry](../quarto/kapitola_04.qmd#fig-parametry-04),
[hustota](../quarto/kapitola_04.qmd#fig-hustota-04) a
[distribuční funkce](../quarto/kapitola_04.qmd#fig-distribucni-04)
podporují postup od relativní polohy k modelové ploše.
[Oblasti](../quarto/kapitola_04.qmd#fig-oblasti-04) a
[kvantily](../quarto/kapitola_04.qmd#fig-kvantily-04) odlišují typy zadání;
[škály](../quarto/kapitola_04.qmd#fig-skaly-04) a
[pásma](../quarto/kapitola_04.qmd#fig-pasma-skoru) rozlišují lineární převod,
modelové pořadí a kategorizaci. [Konstrukce jednoho bodu](../quarto/kapitola_04.qmd#fig-qq-konstrukce)
předchází [hotovému Q–Q](../quarto/kapitola_04.qmd#fig-qq-priklad-04).
Čtyři simulované diagnostické dvojice v oddílu o odchylkách mají každá
200 hodnot a ukazují různé možnosti shody či nesouladu se stejným typem modelu.

### Cvičení a očekávané dovednosti

[Deset úloh](../quarto/kapitola_04.qmd#sec-cviceni-04) má úplná sbalená řešení.
Nadpisy jednotlivých úloh nemají explicitní ID; lokátorem je tento stabilní
oddíl, číslo a název. Kalkulačka/tabulky stačí v 1–3 a 7–8; normální funkce
a Q–Q používají Excel. Tolerance je 0,01 bodu nebo 0,1 procentního bodu
při závěrečném zaokrouhlení.

| Úloha | Co student samostatně dělá |
|---|---|
| 1. Skór a referenční skupina | Pro jeden hrubý výsledek porovná dvě skupiny, obrátí převod a vysvětlí, proč samotné z nestačí k percentilovému pořadí. |
| 2. Standardizace zešikmených dat | Spočítá m, s a z pěti dob; zachování čtyř shod a jedné vysoké hodnoty použije jako argument proti normalizaci standardizací. |
| 3. Zápis modelu a význam plochy | Přečte N(80, 5), určí rozptyl a interval ±1 SD, opraví záměnu hustoty za procento; přeloží konvenci N(80, 25) a zvolí správný argument Excelu. |
| 4. Pod, nad a mezi hranicemi | Nakreslí a vypočítá tři oblasti pro hranice 45/65; porovná modelový podíl s empirickými 8/20 bez předčasného rozhodnutí o příčině neshody. |
| 5. Od podílu k hranici | Zdůvodní levé podíly pro 20. percentil, horních 10 % a prostředních 90 % a vypočítá hranice. |
| 6. Zaokrouhlený skór | Převede zaznamenanou 50 na interval 49,5–50,5 a vysvětlí jeho nenulovou plochu. |
| 7. Převody standardních skórů | Obrátí T-skór na z, IQ a subtestovou škálu; zachová význam úzkosti. Porovná nestejné přírůstky normálních percentilových pořadí při stejných krocích T. |
| 8. Co se ztratí zařazením do pásma | Určí sten/stanin tří z-skórů včetně přesné nuly a vysvětlí nemožnost obnovit přesný skór z pásma. |
| 9. Sestavení a kontrola Q–Q grafu | Vytvoří XY graf, kontroluje krajní souřadnice, změní 65 → 90 a popíše posun bodu i přímky; zdůvodní vyloučení p = 1. |
| 10. Posouzení modelu a oprava závěru | Interpretuje těžší chvosty i pravou šikmost, odmítne argument velkým n a automatickou klinickou hranici; navrhne kontrolu dat a vhodnější popis. |

### Pojmy, konvence a hranice návaznosti

Nově vysvětlené názvy: hrubý skór, referenční skupina/normativní soubor,
z-skór/standardizace, normální a normované normální rozdělení, hustota,
distribuční funkce, standardní/T/IQ/subtestový skór, sten/stanin,
normalizace přes pořadí a normální Q–Q graf. Chvost, kvantil a percentilové
pořadí se rozvíjejí ze starších kapitol. Anglické ekvivalenty a alternativy
jsou ve [slovníčku](../quarto/slovnicek.qmd), schválení v R07–R09.

Výklad používá kurzivní `z`, `z_i` a `T`, stojaté μ/σ, datové m/s;
N(μ, σ) uvádí SD, nikoli rozptyl. `p` znamená podíl/úroveň, ne p-hodnotu.
Nově jsou vysvětleny NORM.S.DIST, NORM.DIST, NORM.S.INV a NORM.INV;
POČET, PRŮMĚR a SMODCH.VÝBĚR.S se již využívají jako známé.
Algoritmus poloh Q–Q a přímka m + sz jsou místní konstrukční volbou,
ne definicí empirických percentilů. Zůstává konvence horní zahrnuté meze
pro stenová/staninová pásma a přednost manuálu při skutečném vyhodnocení testu.

**Povinné** jsou posouzení modelu i tvorba Q–Q a zaokrouhlený skór jako
interval. Kapitola nemá samostatné nepovinné rozšíření; koeficienty tvaru
jen připomíná odkazem na nepovinné rozšíření kapitoly 3. Historické doporučení členit
výuku na dva bloky (poloha/model/plochy a převody/interpretace) není odhadem,
že celý rozsah lze zvládnout v jedné hodině, ani novým dělením kapitol.

**Vysvětleno omezeně:** pravděpodobnost jako modelový podíl při náhodném
výběru jedné osoby; normalizace jako princip bez algoritmu. **Pouze zmíněno
pro odlišení:** interval spolehlivosti parametru, obecná nezávislost pozorování,
formální testy normality. **Vyloženo až v kapitole 5:** jevy a jejich operace,
podmíněná pravděpodobnost, nezávislost a Bayesova věta, náhodná proměnná
a rozdělení pravděpodobnosti, binomický model a jeho normální aproximace.
**Odloženo:** výběrová rozdělení, centrální limitní věta, standardní chyba,
intervaly spolehlivosti a testování. Tato zmínka sama neschvaluje žádné
z těchto témat pro další kapitolu.

Hlavní odbornou a didaktickou oporou původní přípravy je Howell, kapitola 3;
podrobnosti pasáží a srovnání podkladů patří do [karty U01](ZDROJE.md#u01)
a historie přípravy, nikoli do druhé mapy zdrojů.

<a id="mapa-kapitola-05"></a>

## 5. Pravděpodobnost

**Podklad a stav:** existující [kapitola 5](../quarto/kapitola_05.qmd#sec-kapitola-05), karta
sestavena podle výkladu, zadání a řešení a zkontrolována po odborné revizi 2026-10-12 ([R25](ROZHODNUTI.md#r25-revize-kapitoly-5)).
Schválený plán z 2026-10-11 byl nahrazen touto mapou skutečného textu;
dohodu dokládají [R21](ROZHODNUTI.md#r21-rozsah-kapitoly-5),
[R22](ROZHODNUTI.md#r22-znaceni-pravdepodobnosti),
[R23](ROZHODNUTI.md#r23-terminologie-kapitoly-5) a
[historie](../quarto/README.md#dohoda-kapitola-05).

**Vstup:** relativní a kumulativní četnosti, určení celku, doplněk a sumace
(kap. 2); průměr, směrodatná odchylka, vážený průměr, kumulativní kvantil
a změna jednotky (kap. 3); modelový podíl jako plocha, z-skór, NORM.S.DIST
a NORM.DIST, nulová plocha bodu a zaokrouhlený skór jako interval (kap. 4);
výběr, výběrová variabilita a rozdíl souvislosti a příčiny (kap. 1).
Logaritmy, entropie ani momentové koeficienty se nepředpokládají.

**Cíle:** vysvětlit, co pravděpodobnost vyjadřuje, a rozlišit tři pojetí;
vymezit výsledek, výběrový prostor a jev a použít doplněk, součtové
a součinové pravidlo; z kontingenční tabulky určit marginální, společnou
a podmíněnou pravděpodobnost a posoudit nezávislost; obrátit podmínku
přirozenými četnostmi, úplnou pravděpodobností a Bayesovou větou a vysvětlit
závislost prediktivní hodnoty na prevalenci; rozpoznat čtyři chyby úsudku;
popsat diskrétní rozdělení pravděpodobnosti a odlišit je od dat a hustoty;
použít binomický model ručně i v Excelu a posoudit jeho předpoklady;
použít normální aproximaci a posoudit její přesnost.

### Skutečný obsah oddílů

Všechny části jsou **vysvětleny**, pokud není uvedeno „nepovinné“; poslední
sloupec určuje konkrétní **procvičení**.

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Od podílu k pravděpodobnosti](../quarto/kapitola_05.qmd#sec-podil-pravdepodobnost) | Relativní četnost odpovědi „dost“ (14 z 36, data kapitoly 2) → losování lístku; škála 0–1, procenta, zápis velkým P a jeho odlišení od malého p. Návaznost na plochu v normálním modelu. | 1. |
| [Tři pojetí](../quarto/kapitola_05.qmd#sec-pojeti-pravdepodobnosti) | Klasické, četnostní a subjektivní pojetí jako různé interpretace se společnými pravidly; u lístků se shodnou, u klienta v terapii nikoli. | 2a. |
| [Relativní četnost v dlouhé řadě](../quarto/kapitola_05.qmd#sec-dlouha-rada) | Simulace pěti řad po 1 000 tipech (π = 0,25): rozsah po 10, 50 a 1 000 tipech; přibližování není pravidelné a počáteční odchylka se „nevyrovnává“, jen ztrácí váhu. Hráčský klam a jeho vazba na nezávislost. | 2b–c. |
| [Výsledek a výběrový prostor](../quarto/kapitola_05.qmd#sec-vyberovy-prostor), [jev](../quarto/kapitola_05.qmd#sec-jev) | Náhodný pokus odlišen od výzkumného experimentu, výběrový prostor od výběru. Sto kartiček se slovy; jev jako množina výsledků; klasický podíl jen pro stejně pravděpodobné výsledky (kartičky, ne slovní druhy). | 1. |
| [Doplňkový jev](../quarto/kapitola_05.qmd#sec-doplnkovy-jev), [jistý a nemožný jev](../quarto/kapitola_05.qmd#sec-jisty-nemozny) | A′ a P(A′) = 1 − P(A). Obrácení „pravděpodobnost 0 = nenastane“ platí v konečném modelu s kladnými pravděpodobnostmi výsledků; ve spojitém modelu nikoli. | 1d, 1f, 12a. |
| [Průnik a sjednocení](../quarto/kapitola_05.qmd#sec-prunik-sjednoceni), [součtové pravidlo](../quarto/kapitola_05.qmd#sec-souctove-pravidlo) | Modelový soubor 200 studentů (pohlaví × vysoký stres / bez vysokého stresu); pravděpodobnosti popisují soubor, ne populaci. Obecné součtové pravidlo zdůvodněné dvojím započtením; vzájemně výlučné jevy jako zvláštní případ. | 1c, 3d, 12b. |
| [Kontingenční tabulka](../quarto/kapitola_05.qmd#sec-kontingencni-tabulka) | Společná pravděpodobnost z pole, marginální jako součet přes možnosti druhé proměnné; čtyřpolní tabulka jako zvláštní případ. | 3a–b. |
| [Konjunkční klam](../quarto/kapitola_05.qmd#sec-konjunkcni-klam) | Průnik není pravděpodobnější než kterýkoli z jevů; autorská vinětka „Klára“; nahrazení otázky pravděpodobnosti otázkou shody s popisem. | 5a. |
| [Podmíněná pravděpodobnost](../quarto/kapitola_05.qmd#sec-podminena) | Podmínka zužuje celek; vztah s průnikem a požadavek P(B) > 0; „z koho počítám?“; tři čísla o týchž 40 studentkách; P(A∣B) ≠ P(B∣A); podmínka není čas ani příčina. | 3c, 5b. |
| [Součinové pravidlo](../quarto/kapitola_05.qmd#sec-soucinove-pravidlo) | Obecný tvar s podmíněnou pravděpodobností; dvě kartičky bez vracení a s vracením. | 4b, 12f. |
| [Nezávislé jevy](../quarto/kapitola_05.qmd#sec-nezavislost) a [meze nezávislosti](../quarto/kapitola_05.qmd#sec-nezavislost-meze) | Druhý modelový soubor se stejnými podíly; definice součinovým tvarem, intuitivní tvar přes podmíněnou pravděpodobnost; „alespoň jednou“ přes doplněk. Nezávislost není výlučnost, závislost není příčina, tabulka není populace, nezávislost je předpoklad. | 3e–f, 4a, 4c, 12c. |
| [Screening](../quarto/kapitola_05.qmd#sec-screening) a [přirozené četnosti](../quarto/kapitola_05.qmd#sec-prirozene-cetnosti) | Senzitivita, specificita, falešně pozitivní a negativní výsledek s výslovným vymezením podmínky; obrácená otázka psycholožky. 1 000 studentů, strom, tabulka; prediktivní hodnoty 95/185 a 810/815. | 6a–b, 7a. |
| [Úplná pravděpodobnost](../quarto/kapitola_05.qmd#sec-uplna-pravdepodobnost) | Samostatný krok: jmenovatel jako součet dvou cest stromem; rozklad podle jevu a doplňku bez indexovaného zápisu; vztah k marginální pravděpodobnosti. | 6c. |
| [Bayesova věta](../quarto/kapitola_05.qmd#sec-bayesova-veta) | Složena z definice podmíněné pravděpodobnosti, součinového pravidla a úplné pravděpodobnosti; čitatel jedna cesta, jmenovatel všechny. List `Bayes` bez zvláštních funkcí. Věrohodnost se nezavádí. | 6c, 7b, 12d. |
| [Dvě prevalence](../quarto/kapitola_05.qmd#sec-dve-prevalence) | Týž dotazník při 10 % a 1 %, s výslovně předpokládanou stejnou senzitivitou a specificitou: 0,514 versus 0,088 (z 10 000 osob); prediktivní hodnota není vlastností testu. Zanedbání základních četností a záměna podmínky. | 6d, 7c–d. |
| [Základní četnost, prevalence, apriorní pravděpodobnost](../quarto/kapitola_05.qmd#sec-zakladni-cetnost) | Tři související, ale různé pojmy; „před novou informací“ neznamená „bez podkladů“; aposteriorní pravděpodobnost jako východisko dalšího kroku a riziko dvojího použití téže informace. | 6e. |
| [Nepovinné: šance](../quarto/kapitola_05.qmd#rozsireni-sance) | Poměr P(A) a 1 − P(A), převod oběma směry, rozdíl od pravděpodobnosti a od sázkového kurzu. Poměr šancí se nezavádí. | Bez cvičení. |
| [Náhodná proměnná a rozdělení](../quarto/kapitola_05.qmd#sec-rozdeleni-pravdepodobnosti) | Počet správných tipů z pěti; X a k; náhodná proměnná není sloupec dat ani nevyžaduje opakování. Tabulka rozdělení, součet 1, sčítání hodnot. Model versus 40 simulovaných studentů; diskrétní rozdělení versus hustota. | 8. |
| [Střední hodnota](../quarto/kapitola_05.qmd#sec-stredni-hodnota) | Dlouhodobý průměr jako parametr μ, nemusí být dosažitelnou hodnotou; m z dat versus μ; σ rozdělení. | 9d, 10a. |
| [Nepovinné: výpočet z tabulky](../quarto/kapitola_05.qmd#rozsireni-stredni-hodnota) | Vážený součet hodnot a pravděpodobností, rozptyl a σ pro test s pěti otázkami. | Bez cvičení. |
| [Faktoriál](../quarto/kapitola_05.qmd#sec-faktorial), [kombinace a kombinační číslo](../quarto/kapitola_05.qmd#sec-kombinace) | Pořadí tří úloh; výběr dvou otázek z pěti vypsaný i odvozený; kombinace versus kombinační číslo; vzorec, krajní hodnoty a symetrie. FAKTORIÁL, KOMBINACE. | 9a. |
| [Nepovinné: variace bez opakování](../quarto/kapitola_05.qmd#rozsireni-variace) | Losování tří různých a tří stejných cen; vztah ke kombinačnímu číslu; permutace všech prvků; funkce PERMUTACE. | Bez cvičení. |
| [Předpoklady binomického modelu](../quarto/kapitola_05.qmd#sec-binomicke-predpoklady) | Čtyři podmínky; úspěch jako technické označení; π není 3,14 a liší se od p; čtyři způsoby porušení podmínek. | 9e, 12e–f. |
| [Odvození](../quarto/kapitola_05.qmd#sec-binomicke-odvozeni), [vzorec](../quarto/kapitola_05.qmd#sec-binomicky-vzorec) | Tři kroky: jedna posloupnost, stejná pravděpodobnost všech, jejich počet. Vzorec s vysvětlením prvků; celé rozdělení pro n = 5, π = 0,25; 32 pětic není stejně pravděpodobných. | 9b–c. |
| [Tvar, střední hodnota, směrodatná odchylka](../quarto/kapitola_05.qmd#sec-binomicke-tvar) | μ = nπ, σ = √[nπ(1 − π)]; souměrnost při π = 0,5, šikmost jinak, vliv počtu pokusů. | 9d, 10a. |
| [Excel](../quarto/kapitola_05.qmd#sec-excel-binom) | BINOM.DIST s NEPRAVDA a PRAVDA, pevné odkazy, list `Binom` s pevným n = 5 a jediným měnitelným vstupem B3, kontrola ručního výpočtu, přímý výpočet P(X = 0). | 10b. |
| [Právě, nejvýše, alespoň](../quarto/kapitola_05.qmd#sec-binom-kumulace) | List `Binom_20` s pevným n = 20, měnitelnými B3:B5 a navázanými popisky; doplněk „alespoň 10“ je „nejvýše 9“; BINOM.DIST.RANGE a BINOM.INV; KDYŽ vysvětleno znovu pro ošetření krajních vstupů, bez předpokladu znalosti nepovinné části kapitoly 3. Co výsledek říká a co ne: nedokazuje znalost, neobrací podmínku, platí za předpokladů modelu. Právě devět versus alespoň devět z deseti (podle Howella). | 10c–d. |
| [Normální aproximace](../quarto/kapitola_05.qmd#sec-aproximace-postup) a [její přesnost](../quarto/kapitola_05.qmd#sec-aproximace-presnost) | Orientační podmínka deseti očekávaných úspěchů i neúspěchů (mírnější varianta zmíněna); čtyři kroky pro 135 a více z 200. Přesná hodnota 0,0173, aproximace 0,0152 (přibližně o 12 % nižší), od hranice 134,5 hodnota 0,0182; selhání při n = 20, π = 0,25. Úprava hranice je popsána bez pojmenování. | 11a–c. |
| [Od počtu k podílu](../quarto/kapitola_05.qmd#sec-od-poctu-k-podilu) | p = k/n jako změna jednotky; střední hodnota π a směrodatná odchylka √[π(1 − π)/n]; stejný z-skór; čtyřnásobek pokusů půlí kolísání. | 11d. |
| [Shrnutí](../quarto/kapitola_05.qmd#sec-shrnuti-05) | Pravidla, obrácení podmínky, model versus data; pravděpodobnost výsledku za modelu není pravděpodobnost modelu. | Souhrnně 1–12. |

### Příklady, vizualizace a soubory

[Sešit kapitoly 5](../data/kapitola_05.xlsx) má 22 listů: `Prehled`, čtyři
výpočtové listy (`Bayes`, `Binom`, `Binom_20`, `Aproximace`) a sedmnáct
vstupních listů. Výklad pokrývají `Karticky`, `Tabulka_zavislost`,
`Tabulka_nezavislost`, `Screening`, `Test_hadani`, `Sim_hadani` (40 simulovaných
studentů), `Rozpoznavani` a `Losovani`; cvičení listy `U01_emoce`,
`U03_tabulka`, `U04_vstupy`, `U06_screening`, `U07_taxi`, `U08_rozdeleni`,
`U09_test`, `U10_test` a `U11_aproximace`. Úlohy 2, 5 a 12 jsou slovní.
[Pokrytí cvičení](DATA.md).

Průběžné příklady jsou autorské a modelové: krabice 100 kartiček se slovy,
dva soubory 200 studentů (pohlaví × stres; podle autorovy přednášky),
screeningový dotazník se senzitivitou 0,95 a specificitou 0,90 a test
s výběrem odpovědí. Simulovaná jsou data dvou obrázků a jsou tak označena.
Z literatury jsou převzaty dva příklady s uvedením zdroje: pokus se dvěma
krátce promítnutými podněty (Howell, s. 125–126) a úloha o taxících
ve cvičení 7 (Howell, s. 122–123).

| Obrázek | Didaktický účel |
|---|---|
| [Pět simulovaných řad](../quarto/kapitola_05.qmd#fig-relativni-cetnost) | Kolísání relativní četnosti; žádný slib pravidelného přibližování. |
| [Sto kartiček](../quarto/kapitola_05.qmd#fig-karticky) | Výsledek versus jev; proč počítat kartičky, ne slovní druhy. |
| [Průnik a sjednocení](../quarto/kapitola_05.qmd#fig-prunik-sjednoceni), [podmínění](../quarto/kapitola_05.qmd#fig-podmineni), [nezávislost](../quarto/kapitola_05.qmd#fig-nezavislost) | Tatáž tabulka jako plocha: která pole se počítají, jak podmínka mění celek a jak vypadá stejný podíl v obou řádcích. |
| [Strom](../quarto/kapitola_05.qmd#fig-strom), [dvě prevalence](../quarto/kapitola_05.qmd#fig-dve-prevalence) | Přirozené četnosti a složení pozitivních výsledků při 10 % a 1 %. |
| [Model a data](../quarto/kapitola_05.qmd#fig-rozdeleni-model-data) | Rozdělení pravděpodobnosti versus relativní četnosti 40 simulovaných studentů. |
| [Deset kombinací](../quarto/kapitola_05.qmd#fig-kombinace) | Kombinační číslo jako vypsatelný počet. |
| [Tvar](../quarto/kapitola_05.qmd#fig-binomicke-tvar), [právě/nejvýše/alespoň](../quarto/kapitola_05.qmd#fig-binom-oblasti), [aproximace](../quarto/kapitola_05.qmd#fig-aproximace) | Vliv n a π; které sloupce se sčítají; kdy normální křivka sedí a kdy ne. |

### Cvičení a očekávané dovednosti

[Dvanáct úloh](../quarto/kapitola_05.qmd#sec-cviceni-05) má úplná sbalená řešení. Nadpisy úloh
nemají explicitní ID; lokátorem je oddíl cvičení, číslo a název. Úlohy 1–9
vyžadují kalkulačku, 10–11 Excel; pravděpodobnosti na tři desetinná místa,
tolerance 0,001, počty osob přesně.

| Úloha | Co student samostatně dělá |
|---|---|
| 1. Výsledek, jev a doplněk | Určí výběrový prostor 60 fotografií, pravděpodobnosti jevů, sjednocení výlučných jevů a doplněk; vyvrátí „čtyři emoce, tedy 1/4“. |
| 2. Co číslo znamená | Přiřadí tři výroky třem pojetím, posoudí hráčský klam a odchylku relativní četnosti po 1 000 pokusech. |
| 3. Čtení kontingenční tabulky | Z tabulky sport × spánek určí marginální, společnou a obě podmíněné pravděpodobnosti, sjednocení dvěma způsoby, nezávislost dvěma způsoby a meze závěru. |
| 4. Součinové pravidlo, doplněk a výběr bez vracení | Dva nezávislé tipy, „alespoň jeden“, dvě kartičky bez vracení a s vracením; vyvrátí „výlučné, tedy nezávislé“. |
| 5. Kde je chyba v úsudku | V modelovém zadání rozpozná konjunkční klam a záměnu podmíněných pravděpodobností; určí chybějící údaj. |
| 6. Screening přirozenými četnostmi | Sestaví tabulku pro 1 000 lidí, určí prediktivní hodnoty, úplnou pravděpodobnost a Bayesovu větu; porovná prevalenci 5 % a 20 %; určí apriorní a aposteriorní pravděpodobnost. |
| 7. Svědek a taxíky | Přirozené četnosti a Bayesova věta v nediagnostické situaci s výslovným předpokladem stejné pravděpodobnosti nehody pro každý taxík; základní četnost; případ stejných četností. |
| 8. Rozdělení pravděpodobnosti a data | Ověří rozdělení, sčítá hodnoty, porovná rozdělení s ilustračními četnostmi představujícími 20 lidí a vysvětlí, proč to nejde u spojité proměnné. |
| 9. Kombinace a ruční výpočet | Vypíše kombinace, spočítá P(X = 3) a P(X ≥ 3) pro čtyři otázky ano–ne, μ a σ; uvede porušení předpokladů. |
| 10. Binomické rozdělení v Excelu | Právě, nejvýše a alespoň pro 15 otázek s pěti možnostmi; interpretuje výsledek bez obrácení podmínky. |
| 11. Normální aproximace | Ověří podmínku, porovná aproximaci, přesnou hodnotu a aproximaci od hranice 64,5; převede na podíl. |
| 12. Které pravidlo použít | U šesti situací zvolí nástroj a zdůvodní volbu, včetně případu losování bez vracení: mění se podmíněné pravděpodobnosti při známých předchozích tazích, nikoli nepodmíněná pravděpodobnost ženy na jednotlivých pozicích. |

### Pojmy, konvence a hranice návaznosti

Nově je vysvětleno padesát pojmů [registru](SLOVNIK.md#kapitola-05).
Značení: velké P, A′, ∩, ∪, svislá čára podmínky, X a P(X = k), n!,
kombinační číslo „n nad k“, stojaté π, μ a σ rozdělení, znaky ≤ a ≥;
v nepovinné části O. Písmeno k zde znamená počet úspěchů (v kapitole 2
počet kategorií) a n počet pokusů; výklad na obojí upozorňuje. Nové funkce:
FAKTORIÁL, KOMBINACE, BINOM.DIST, BINOM.DIST.RANGE, BINOM.INV a nepovinně
PERMUTACE.

**Nepovinné:** šance, výpočet střední hodnoty a rozptylu z tabulky, variace
bez opakování. Další kapitola je nesmí předpokládat.

**Vysvětleno omezeně:** střední hodnota a směrodatná odchylka rozdělení
slovně a vzorci pro binomický model; směrodatná odchylka podílu jako důsledek
změny jednotky, bez názvu standardní chyba; otázka „jak pravděpodobný je
výsledek při tipování“ bez rozhodovacího pravidla. **Pouze zmíněno:**
testování hypotéz, inferenční statistika jako oblast, bayesovské pokračování
(aposteriorní pravděpodobnost jako nová apriorní). **Nevyloženo:** věrohodnost,
poměr šancí, název úpravy hranice při aproximaci, binomický a znaménkový
test, multinomické a Poissonovo rozdělení, výběrová rozdělení, centrální
limitní věta, standardní chyba, intervaly spolehlivosti. Žádná z těchto
zmínek neschvaluje téma pro další kapitolu.

Hlavní oporou pořadí je Howell, kapitola 5, a autorova přednáška
`probability.pptx`; rozsah čtení a zjištěné rozpory jsou v kartách
[mapy zdrojů](ZDROJE.md).

<a id="plan-dalsi-kapitoly"></a>

## Plán pokračování po kapitole 5 — odděleně od existujícího obsahu

**Stav k 2026-10-11: žádný schválený plán.** Směr, rozsah ani pořadí kapitol
následujících po pravděpodobnosti nebyly dohodnuty. Jako možná návaznost
se v dosavadních kapitolách a v R21 pouze zmiňují výběrová rozdělení,
standardní chyba, centrální limitní věta, intervaly spolehlivosti
a testování hypotéz; žádná z těchto zmínek není schválením tématu ani
jeho umístění. Rozcestník [mapy zdrojů](ZDROJE.md) nabízí podklady,
nikoli osnovu. Před předložením návrhu další kapitoly platí postup
z AGENTS.md: kontrola `sources/` proti inventáři, čtení relevantních pasáží
v originálech a dohoda o rozsahu, cílech, termínech a značkách.
