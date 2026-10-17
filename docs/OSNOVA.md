# Mapa obsahu a návazností učebnice

**Uspořádání dokumentace od 2026-10-13:** tento rozcestník obsahuje celkovou strukturu a tematické návaznosti. Podrobné karty sedmi kapitol a samostatný plán pokračování otevírej podle tabulky níže; každá karta propojuje obsah s relevantními zdrojovými kartami. Datum reorganizace není novou kontrolou obsahu kapitol.

**Poslední kontrola mapy: 2026-10-17** (karta kapitoly 7 a dotčené řádky rozcestníku;
karty 1, 5 a 6 naposledy 2026-10-12 a 2026-10-15, karty 2–4 2026-10-11). Dokument
popisuje aktuální zdrojové texty sedmi výkladových kapitol. Pro pokračování po
kapitole 7 není schválen žádný plán.
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
sedmi výkladovým kapitolám; za nimi je [literatura](../quarto/literatura.qmd)
a tři výše uvedené přehledy v pořadí slovníček → značení a vzorce → Excel.
Nové výkladové kapitoly patří před literaturu a přehledy. Čísla v této mapě
jsou autorské orientační údaje; studentské křížové odkazy nadále používají
stabilní identifikátory Quarta.

| Kapitola / karta | Úloha v návaznosti | Samostatná cvičení |
|---|---|---|
| [1. Od psychologické otázky k datům](kapitoly/01-otazka-data.md#mapa-kapitola-01) | Význam údajů, výzkumné závěry, měření a příprava matice. | 8 konceptuálních a praktických úloh. |
| [2. Četnosti, rozdělení dat a jejich zobrazení](kapitoly/02-cetnosti.md#mapa-kapitola-02) | Od jednotlivých záznamů k zastoupení hodnot a grafům. | 10 úloh, z toho závěrečná změna vstupů v Excelu. |
| [3. Ukazatele polohy a variability](kapitoly/03-poloha-variabilita.md#mapa-kapitola-03) | Číselná shrnutí, jejich volba, výpočet, omezení a reportování. | 12 základních a 2 nepovinné úlohy. |
| [4. Normální rozdělení a standardní skóry](kapitoly/04-normalni-rozdeleni.md#mapa-kapitola-04) | Relativní poloha, modelové podíly a kvantily, standardní škály a posouzení modelu. | 10 úloh včetně tvorby Q–Q grafu. |
| [5. Pravděpodobnost](kapitoly/05-pravdepodobnost.md#mapa-kapitola-05) | Pravidla pro jevy, podmínění a Bayesova věta; rozdělení pravděpodobnosti, binomický model a jeho normální aproximace. | 12 úloh, z toho dvě v Excelu. |
| [6. Výběrové rozdělení a testování hypotéz](kapitoly/06-vyberove-rozdeleni-testovani.md#mapa-kapitola-06) | Kolísání výsledků mezi výběry, směrodatná chyba, zákon velkých čísel a centrální limitní věta; princip testu, p-hodnota, chyby a síla, velikost účinku, binomický test a z-test. | 12 základních a 2 nepovinné úlohy; pět základních vyžaduje Excel. |
| [7. Interval spolehlivosti, t-test a test ekvivalence](kapitoly/07-interval-t-test-ekvivalence.md#mapa-kapitola-07) | Odhad populačního průměru s nejistotou při známé i neznámé σ, t-rozdělení, jednovýběrový t-test, vztah intervalu a p-hodnoty, test ekvivalence pomocí 90% intervalu a čtyři kombinace výsledků. | 12 základních a 2 nepovinné úlohy; pět základních vyžaduje Excel. |
| [Plán pokračování](kapitoly/plan-pokracovani.md#plan-dalsi-kapitoly) | Po kapitole 7 není schválen směr, rozsah ani pořadí dalších kapitol. | — |

<a id="tematicky-rozcestnik"></a>

## Tematický rozcestník napříč knihou

Číslo úlohy vždy patří kapitole uvedené před ním. Podrobné popisy úloh
jsou v odkazovaných kartách kapitol; jejich řešení zůstávají ve studentském textu.

| Téma | První vysvětlení a rozvoj | Procvičení a hranice návaznosti |
|---|---|---|
| Případ, proměnná, hodnota, konstanta | [1: proměnné](../quarto/kapitola_01.qmd#sec-promenne); [2: co počítáme](../quarto/kapitola_02.qmd#sec-co-pocitame). | 1/1, 1/8; počet řádků není automaticky počet různých lidí. |
| Populace, výběr a zobecnění | [1: populace a výběr](../quarto/kapitola_01.qmd#sec-populace-vyber); [4: referenční skupina](../quarto/kapitola_04.qmd#sec-referencni-skupina); [6: tři úrovně](../quarto/kapitola_06.qmd#sec-tri-urovne) a [hypotézy](../quarto/kapitola_06.qmd#sec-vyzkumna-statisticka). | 1/2–4, 4/1 a 10, 5/3; kapitola 5 odlišuje nezávislost v tabulce výběru od nezávislosti v populaci. Kapitola 6 odlišuje rozdělení v populaci, v jednom výběru a výběrové rozdělení (6/1) a vykládá princip testu. Kapitola 7 vykládá [intervalový odhad](../quarto/kapitola_07.qmd#sec-bodovy-intervalovy) a [pevnou normu jako referenci](../quarto/kapitola_07.qmd#sec-meze-ekvivalence) (7/1–3, 12c); dvouvýběrové postupy vyloženy nejsou. |
| Souvislost, příčina, role proměnných a validita | [1: souvislost a příčina](../quarto/kapitola_01.qmd#sec-souvislost-pricina); [nepovinné pedagogické příklady](../quarto/kapitola_01.qmd#souvislost-pedagogicka). | 1/3–4; společná příčina a výběr podle společného následku jsou názorně porovnány v nepovinném rozšíření, bez samostatného cvičení a bez formální kauzální analýzy. Kapitola 6 se k uspořádání studie vrací ve [věcné interpretaci testu](../quarto/kapitola_06.qmd#sec-zaver-testu) (6/9e, 6/11a). |
| Měření, konstrukt, škály a význam transformací | [1: měření](../quarto/kapitola_01.qmd#sec-mereni) a [úrovně](../quarto/kapitola_01.qmd#sec-urovne); [3: volba statistik](../quarto/kapitola_03.qmd#sec-komunikace-statistik); [4: standardní skóry](../quarto/kapitola_04.qmd#sec-standardni-skory). | 1/5–6, 3/4, 4/7; číselný převod nezmění měřený konstrukt. |
| Chyba, zkreslení a výběrová variabilita | [1: nejistota](../quarto/kapitola_01.qmd#sec-nejistota); [3: korekce rozptylu](../quarto/kapitola_03.qmd#sec-korekce-rozptylu); [4: Q–Q](../quarto/kapitola_04.qmd#sec-qq-graf); [6: směrodatná chyba](../quarto/kapitola_06.qmd#sec-smerodatna-chyba) a [pět pojmů](../quarto/kapitola_06.qmd#sec-pet-pojmu). | 1/7, 3/6, 4/4 a 10, 5/2, 8 a 11; kapitola 5 ukazuje kolísání relativní četnosti a směrodatnou odchylku podílu. Kapitola 6 vykládá výběrové rozdělení, směrodatnou chybu, její odhad a výběrovou chybu systematicky (6/1–6); viz samostatný řádek níže. |
| Datová matice, ID, chybění a platné údaje | [1: matice](../quarto/kapitola_01.qmd#sec-datova-matice); [2: jmenovatel](../quarto/kapitola_02.qmd#sec-jmenovatel); [3: Excel](../quarto/kapitola_03.qmd#sec-excel-poloha). | 1/8, 2/3 a 10, 3/12; bez výkladu imputace. |
| Četnosti, podíly a procenta | [2: četnosti](../quarto/kapitola_02.qmd#sec-od-zaznamu-k-cetnostem) a [podíly](../quarto/kapitola_02.qmd#sec-relativni-cetnost); [4: modelové plochy](../quarto/kapitola_04.qmd#sec-plochy-normalniho). | 2/1–4 a 9–10, 4/3–6; pozorované a modelové podíly mají odlišnou oporu. |
| Indexy, sumace a matematické mezikroky | [2: indexy](../quarto/kapitola_02.qmd#sec-relativni-cetnost) a [sumace](../quarto/kapitola_02.qmd#sec-sumace); [3: těsný zápis násobení](../quarto/kapitola_03.qmd#sec-prumer), [3: absolutní hodnota](../quarto/kapitola_03.qmd#sec-prumerna-absolutni), [mocniny](../quarto/kapitola_03.qmd#sec-rozptyl), [odmocnina](../quarto/kapitola_03.qmd#sec-smerodatna-odchylka). | 2/2, 3/5; logaritmus a vyšší momenty pouze nepovinně. |
| Kumulace, kvantil a percentilové pořadí | [2: kumulace](../quarto/kapitola_02.qmd#sec-kumulativni-cetnosti); [3: kvantily](../quarto/kapitola_03.qmd#sec-kvantily) a [pořadí](../quarto/kapitola_03.qmd#sec-percentilove-poradi); [4: distribuční funkce](../quarto/kapitola_04.qmd#sec-distribucni-funkce) a [modelový percentil](../quarto/kapitola_04.qmd#sec-normalni-kvantil). | 2/4, 3/3–4, 4/4–5; interpolace, inkluzivní pořadí a polohy Q–Q nejsou jeden algoritmus. |
| Intervaly, histogram a hustota | [2: intervaly](../quarto/kapitola_02.qmd#sec-tridni-intervaly) a [histogram](../quarto/kapitola_02.qmd#sec-histogram); [4: hustota](../quarto/kapitola_04.qmd#sec-hustota). | 2/5–6 a 10, 4/3 a 6; nestejné šířky jsou ve 2 nepovinné, plocha se ve 4 vysvětluje znovu. |
| Tvar, chvosty, vrcholy a odlehlá pozorování | [2: tvar](../quarto/kapitola_02.qmd#sec-tvar-rozdeleni); [3: střed a tvar](../quarto/kapitola_03.qmd#sec-stred-tvar), [boxplot](../quarto/kapitola_03.qmd#sec-boxplot); [4: diagnostické grafy](../quarto/kapitola_04.qmd#sec-qq-odchylky). | 2/7, 3/1 a 9, 4/9–10; momentová šikmost a špičatost pouze nepovinně (3/14). |
| Poloha, variabilita a robustní shrnutí | [3: střed](../quarto/kapitola_03.qmd#sec-stred-rozdeleni), [rozptyl](../quarto/kapitola_03.qmd#sec-odchylky-rozptyl), [odolnost](../quarto/kapitola_03.qmd#sec-odolne-shrnuti). | 3/1–2 a 5–9; 4 používá průměr a SD, nikoli nepovinné momenty jako předpoklad. |
| Pravděpodobnost, jevy a pravidla počítání | [4: plocha jako pravděpodobnost](../quarto/kapitola_04.qmd#sec-hustota); [5: pojetí](../quarto/kapitola_05.qmd#sec-pojeti-pravdepodobnosti), [jevy](../quarto/kapitola_05.qmd#sec-jevy), [součtové pravidlo](../quarto/kapitola_05.qmd#sec-souctove-pravidlo). | 5/1–2, 4 a 12; ve 4 jen propojení modelového podílu s pravděpodobností. Množinový formalismus a axiomy se nevykládají. |
| Podmínění, nezávislost a Bayesova věta | [5: tabulka](../quarto/kapitola_05.qmd#sec-kontingencni-tabulka), [podmínění](../quarto/kapitola_05.qmd#sec-podminena), [nezávislost](../quarto/kapitola_05.qmd#sec-nezavislost), [Bayes](../quarto/kapitola_05.qmd#sec-bayes). | 5/3–7 a 12; inference o závislosti v populaci a testy pro tabulky nejsou vyloženy. |
| Chyby pravděpodobnostního úsudku | [5: hráčský klam](../quarto/kapitola_05.qmd#sec-dlouha-rada), [konjunkční klam](../quarto/kapitola_05.qmd#sec-konjunkcni-klam), [zanedbání základních četností](../quarto/kapitola_05.qmd#sec-dve-prevalence). | 5/2, 5 a 7; vykládají se u pravidla, které porušují, ne jako přehled heuristik. Kapitola 6 přidává [záměnu p-hodnoty za pravděpodobnost hypotézy](../quarto/kapitola_06.qmd#sec-zaver-parkovani) a čtení nezamítnutí jako důkazu (6/11b). |
| Náhodná proměnná, binomický model a aproximace | [5: rozdělení pravděpodobnosti](../quarto/kapitola_05.qmd#sec-nahodna-promenna), [kombinace](../quarto/kapitola_05.qmd#sec-kombinace), [binomické rozdělení](../quarto/kapitola_05.qmd#sec-binomicke), [aproximace](../quarto/kapitola_05.qmd#sec-normalni-aproximace). | 5/8–12; obecná střední hodnota a variace jen nepovinně; binomický test je vyložen až v kapitole 6 ([řešený příklad](../quarto/kapitola_06.qmd#sec-binomicky-test), 6/8). |
| Výběrové rozdělení, směrodatná chyba, zákon velkých čísel a centrální limitní věta | [6: podíl](../quarto/kapitola_06.qmd#sec-rozdeleni-podilu), [devět výběrů a simulace](../quarto/kapitola_06.qmd#sec-vyberove-rozdeleni-prumeru), [směrodatná chyba](../quarto/kapitola_06.qmd#sec-chyba-prumeru) a [její odhad](../quarto/kapitola_06.qmd#sec-odhad-chyby), [zákon velkých čísel](../quarto/kapitola_06.qmd#sec-zakon-velkych-cisel), [centrální limitní věta](../quarto/kapitola_06.qmd#sec-clv-zneni), [řešený výpočet](../quarto/kapitola_06.qmd#sec-vypocet-prumeru). | 6/1–6; odvození σ/√n a chyba rozdílu dvou průměrů jen nepovinně. Bootstrap vyložen není; t-rozdělení a intervaly viz samostatný řádek kapitoly 7. |
| Interval spolehlivosti, t-rozdělení a test ekvivalence | [7: bodový a intervalový odhad](../quarto/kapitola_07.qmd#sec-bodovy-intervalovy), [interval při známé σ](../quarto/kapitola_07.qmd#sec-interval-zname-sigma), [šířka](../quarto/kapitola_07.qmd#sec-sirka-intervalu), [t-rozdělení](../quarto/kapitola_07.qmd#sec-t-rozdeleni), [interval a p-hodnota](../quarto/kapitola_07.qmd#sec-interval-a-p), [pásmo](../quarto/kapitola_07.qmd#sec-pasmo-ekvivalence) a [test ekvivalence](../quarto/kapitola_07.qmd#sec-test-ekvivalence). | 7/1–14; p-hodnoty TOST a neinferiorita nepovinně (7/13–14). Interval pro podíl, bootstrap, bayesovské intervaly a dvouvýběrové postupy vyloženy nejsou. |
| Testování hypotéz, chyby rozhodnutí a statistická síla | [6: hypotézy a směr](../quarto/kapitola_06.qmd#sec-hypotezy), [p-hodnota a pravidlo](../quarto/kapitola_06.qmd#sec-p-hodnota), [chyby a síla](../quarto/kapitola_06.qmd#sec-chyby-sila), [dva testy](../quarto/kapitola_06.qmd#sec-dva-testy), [meze](../quarto/kapitola_06.qmd#sec-meze-testovani). | 6/7–12; výpočet síly nepovinně (6/13), test jako screening nepovinně (6/14). Kapitola 7 přidává [jednovýběrový t-test](../quarto/kapitola_07.qmd#sec-t-test) a [test ekvivalence](../quarto/kapitola_07.qmd#sec-test-ekvivalence) (7/6–7, 7/10–13). Dvouvýběrové t-testy, korekce pro více testů a plánování velikosti výběru vyloženy nejsou. |
| Velikost účinku a tři významnosti | [6: významnosti](../quarto/kapitola_06.qmd#sec-tri-vyznamnosti), [velikost účinku](../quarto/kapitola_06.qmd#sec-velikost-ucinku-jednotky), [závěr testu](../quarto/kapitola_06.qmd#sec-zaver-testu). | 6/11–12; standardizovaný rozdíl průměrů jen nepovinně a bez slovních pásem. Kapitola 7 [odlišuje statisticky a věcně významný výsledek pomocí pásma ekvivalence](../quarto/kapitola_07.qmd#sec-ctyri-kombinace) (7/9–12); hranice v původních jednotkách, standardizované hranice vyloženy nejsou. |
| Rozmanitost kategorií a entropie | [3: entropie](../quarto/kapitola_03.qmd#sec-entropie). | 3/11 slovně; 3/13 nepovinný výpočet; nejde o úplný výklad teorie informace. |
| Lineární a nelineární transformace | [3: změna škály](../quarto/kapitola_03.qmd#sec-zmena-skaly); [4: standardizace](../quarto/kapitola_04.qmd#sec-standardizace) a [normalizace](../quarto/kapitola_04.qmd#sec-normalizace). | 3/10, 4/1–2 a 7–8; normalizace přes pořadí vysvětlena principem, bez algoritmu tvorby norem. |
| Statistika, parametr, data a model | [3: souhrnné ukazatele](../quarto/kapitola_03.qmd#sec-poloha-variabilita) a [popis/model](../quarto/kapitola_03.qmd#sec-popis-a-model); [4: normální model](../quarto/kapitola_04.qmd#sec-normalni-model). | 3/11, 4/3–5 a 10, 5/8; kapitola 5 přidává rozdělení pravděpodobnosti diskrétní proměnné a parametr π. Normální model nepředstavuje obecnou teorii rozdělení. Kapitola 6 vykládá [statistiku jako náhodnou proměnnou](../quarto/kapitola_06.qmd#sec-statistika-jako-promenna) s výběrovým rozdělením (6/1–2). |
| Kritické čtení grafu a sdělení výsledku | [2: zavádějící grafy](../quarto/kapitola_02.qmd#sec-zavadejici-grafy); [3: reportování](../quarto/kapitola_03.qmd#sec-reportovani-apa); [4: přiměřenost modelu](../quarto/kapitola_04.qmd#sec-primerenost-modelu). | 2/6–9, 3/12, 4/10; APA značky jsou vymezenou výjimkou, výpočetní značení se nemění. Kapitola 6 přidává [formulace závěrů testu](../quarto/kapitola_06.qmd#sec-zaver-testu) ve dvou krocích (6/11); reportování testů podle APA nezavádí. Kapitola 7 přidává [ukázku zprávy](../quarto/kapitola_07.qmd#sec-ukazka-sdeleni) s intervalem, t-testem a testem ekvivalence (bez samostatného cvičení). |
