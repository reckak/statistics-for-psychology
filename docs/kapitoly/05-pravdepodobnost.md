<a id="mapa-kapitola-05"></a>

# 5. Pravděpodobnost

[Mapa celé knihy](../OSNOVA.md) · [Rozcestník zdrojů](../ZDROJE.md)

**Podklad a stav:** existující [kapitola 5](../../quarto/kapitola_05.qmd#sec-kapitola-05), karta
sestavena podle výkladu, zadání a řešení a zkontrolována po odborné revizi 2026-10-12 ([R25](../rozhodnuti/kapitola-05.md#r25-revize-kapitoly-5)).
Schválený plán z 2026-10-11 byl nahrazen touto mapou skutečného textu;
dohodu dokládají [R21](../rozhodnuti/kapitola-05.md#r21-rozsah-kapitoly-5),
[R22](../rozhodnuti/kapitola-05.md#r22-znaceni-pravdepodobnosti),
[R23](../rozhodnuti/kapitola-05.md#r23-terminologie-kapitoly-5) a
[historie](../../quarto/README.md#dohoda-kapitola-05).

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

<a id="skutečný-obsah-oddílů-4"></a>

### Skutečný obsah oddílů

Všechny části jsou **vysvětleny**, pokud není uvedeno „nepovinné“; poslední
sloupec určuje konkrétní **procvičení**.

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Od podílu k pravděpodobnosti](../../quarto/kapitola_05.qmd#sec-podil-pravdepodobnost) | Relativní četnost odpovědi „dost“ (14 z 36, data kapitoly 2) → losování lístku; škála 0–1, procenta, zápis velkým P a jeho odlišení od malého p. Návaznost na plochu v normálním modelu. | 1. |
| [Tři pojetí](../../quarto/kapitola_05.qmd#sec-pojeti-pravdepodobnosti) | Klasické, četnostní a subjektivní pojetí jako různé interpretace se společnými pravidly; u lístků se shodnou, u klienta v terapii nikoli. | 2a. |
| [Relativní četnost v dlouhé řadě](../../quarto/kapitola_05.qmd#sec-dlouha-rada) | Simulace pěti řad po 1 000 tipech (π = 0,25): rozsah po 10, 50 a 1 000 tipech; přibližování není pravidelné a počáteční odchylka se „nevyrovnává“, jen ztrácí váhu. Hráčský klam a jeho vazba na nezávislost. | 2b–c. |
| [Výsledek a výběrový prostor](../../quarto/kapitola_05.qmd#sec-vyberovy-prostor), [jev](../../quarto/kapitola_05.qmd#sec-jev) | Náhodný pokus odlišen od výzkumného experimentu, výběrový prostor od výběru. Sto kartiček se slovy; jev jako množina výsledků; klasický podíl jen pro stejně pravděpodobné výsledky (kartičky, ne slovní druhy). | 1. |
| [Doplňkový jev](../../quarto/kapitola_05.qmd#sec-doplnkovy-jev), [jistý a nemožný jev](../../quarto/kapitola_05.qmd#sec-jisty-nemozny) | A′ a P(A′) = 1 − P(A). Obrácení „pravděpodobnost 0 = nenastane“ platí v konečném modelu s kladnými pravděpodobnostmi výsledků; ve spojitém modelu nikoli. | 1d, 1f, 12a. |
| [Průnik a sjednocení](../../quarto/kapitola_05.qmd#sec-prunik-sjednoceni), [součtové pravidlo](../../quarto/kapitola_05.qmd#sec-souctove-pravidlo) | Modelový soubor 200 studentů (pohlaví × vysoký stres / bez vysokého stresu); pravděpodobnosti popisují soubor, ne populaci. Obecné součtové pravidlo zdůvodněné dvojím započtením; vzájemně výlučné jevy jako zvláštní případ. | 1c, 3d, 12b. |
| [Kontingenční tabulka](../../quarto/kapitola_05.qmd#sec-kontingencni-tabulka) | Společná pravděpodobnost z pole, marginální jako součet přes možnosti druhé proměnné; čtyřpolní tabulka jako zvláštní případ. | 3a–b. |
| [Konjunkční klam](../../quarto/kapitola_05.qmd#sec-konjunkcni-klam) | Průnik není pravděpodobnější než kterýkoli z jevů; autorská vinětka „Klára“; nahrazení otázky pravděpodobnosti otázkou shody s popisem. | 5a. |
| [Podmíněná pravděpodobnost](../../quarto/kapitola_05.qmd#sec-podminena) | Podmínka zužuje celek; vztah s průnikem a požadavek P(B) > 0; „z koho počítám?“; tři čísla o týchž 40 studentkách; P(A∣B) ≠ P(B∣A); podmínka není čas ani příčina. | 3c, 5b. |
| [Součinové pravidlo](../../quarto/kapitola_05.qmd#sec-soucinove-pravidlo) | Obecný tvar s podmíněnou pravděpodobností; dvě kartičky bez vracení a s vracením. | 4b, 12f. |
| [Nezávislé jevy](../../quarto/kapitola_05.qmd#sec-nezavislost) a [meze nezávislosti](../../quarto/kapitola_05.qmd#sec-nezavislost-meze) | Druhý modelový soubor se stejnými podíly; definice součinovým tvarem, intuitivní tvar přes podmíněnou pravděpodobnost; „alespoň jednou“ přes doplněk. Nezávislost není výlučnost, závislost není příčina, tabulka není populace, nezávislost je předpoklad. | 3e–f, 4a, 4c, 12c. |
| [Screening](../../quarto/kapitola_05.qmd#sec-screening) a [přirozené četnosti](../../quarto/kapitola_05.qmd#sec-prirozene-cetnosti) | Senzitivita, specificita, falešně pozitivní a negativní výsledek s výslovným vymezením podmínky; obrácená otázka psycholožky. 1 000 studentů, strom, tabulka; prediktivní hodnoty 95/185 a 810/815. | 6a–b, 7a. |
| [Úplná pravděpodobnost](../../quarto/kapitola_05.qmd#sec-uplna-pravdepodobnost) | Samostatný krok: jmenovatel jako součet dvou cest stromem; rozklad podle jevu a doplňku bez indexovaného zápisu; vztah k marginální pravděpodobnosti. | 6c. |
| [Bayesova věta](../../quarto/kapitola_05.qmd#sec-bayesova-veta) | Složena z definice podmíněné pravděpodobnosti, součinového pravidla a úplné pravděpodobnosti; čitatel jedna cesta, jmenovatel všechny. List `Bayes` bez zvláštních funkcí. Věrohodnost se nezavádí. | 6c, 7b, 12d. |
| [Dvě prevalence](../../quarto/kapitola_05.qmd#sec-dve-prevalence) | Týž dotazník při 10 % a 1 %, s výslovně předpokládanou stejnou senzitivitou a specificitou: 0,514 versus 0,088 (z 10 000 osob); prediktivní hodnota není vlastností testu. Zanedbání základních četností a záměna podmínky. | 6d, 7c–d. |
| [Základní četnost, prevalence, apriorní pravděpodobnost](../../quarto/kapitola_05.qmd#sec-zakladni-cetnost) | Tři související, ale různé pojmy; „před novou informací“ neznamená „bez podkladů“; aposteriorní pravděpodobnost jako východisko dalšího kroku a riziko dvojího použití téže informace. | 6e. |
| [Nepovinné: šance](../../quarto/kapitola_05.qmd#rozsireni-sance) | Poměr P(A) a 1 − P(A), převod oběma směry, rozdíl od pravděpodobnosti a od sázkového kurzu. Poměr šancí se nezavádí. | Bez cvičení. |
| [Náhodná proměnná a rozdělení](../../quarto/kapitola_05.qmd#sec-rozdeleni-pravdepodobnosti) | Počet správných tipů z pěti; X a k; náhodná proměnná není sloupec dat ani nevyžaduje opakování. Tabulka rozdělení, součet 1, sčítání hodnot. Model versus 40 simulovaných studentů; diskrétní rozdělení versus hustota. | 8. |
| [Střední hodnota](../../quarto/kapitola_05.qmd#sec-stredni-hodnota) | Dlouhodobý průměr jako parametr μ, nemusí být dosažitelnou hodnotou; m z dat versus μ; σ rozdělení. | 9d, 10a. |
| [Nepovinné: výpočet z tabulky](../../quarto/kapitola_05.qmd#rozsireni-stredni-hodnota) | Vážený součet hodnot a pravděpodobností, rozptyl a σ pro test s pěti otázkami. | Bez cvičení. |
| [Faktoriál](../../quarto/kapitola_05.qmd#sec-faktorial), [kombinace a kombinační číslo](../../quarto/kapitola_05.qmd#sec-kombinace) | Pořadí tří úloh; výběr dvou otázek z pěti vypsaný i odvozený; kombinace versus kombinační číslo; vzorec, krajní hodnoty a symetrie. FAKTORIÁL, KOMBINACE. | 9a. |
| [Nepovinné: variace bez opakování](../../quarto/kapitola_05.qmd#rozsireni-variace) | Losování tří různých a tří stejných cen; vztah ke kombinačnímu číslu; permutace všech prvků; funkce PERMUTACE. | Bez cvičení. |
| [Předpoklady binomického modelu](../../quarto/kapitola_05.qmd#sec-binomicke-predpoklady) | Čtyři podmínky; úspěch jako technické označení; π není 3,14 a liší se od p; čtyři způsoby porušení podmínek. | 9e, 12e–f. |
| [Odvození](../../quarto/kapitola_05.qmd#sec-binomicke-odvozeni), [vzorec](../../quarto/kapitola_05.qmd#sec-binomicky-vzorec) | Tři kroky: jedna posloupnost, stejná pravděpodobnost všech, jejich počet. Vzorec s vysvětlením prvků; celé rozdělení pro n = 5, π = 0,25; 32 pětic není stejně pravděpodobných. | 9b–c. |
| [Tvar, střední hodnota, směrodatná odchylka](../../quarto/kapitola_05.qmd#sec-binomicke-tvar) | μ = nπ, σ = √[nπ(1 − π)]; souměrnost při π = 0,5, šikmost jinak, vliv počtu pokusů. | 9d, 10a. |
| [Excel](../../quarto/kapitola_05.qmd#sec-excel-binom) | BINOM.DIST s NEPRAVDA a PRAVDA, pevné odkazy, list `Binom` s pevným n = 5 a jediným měnitelným vstupem B3, kontrola ručního výpočtu, přímý výpočet P(X = 0). | 10b. |
| [Právě, nejvýše, alespoň](../../quarto/kapitola_05.qmd#sec-binom-kumulace) | List `Binom_20` s pevným n = 20, měnitelnými B3:B5 a navázanými popisky; doplněk „alespoň 10“ je „nejvýše 9“; BINOM.DIST.RANGE a BINOM.INV; KDYŽ vysvětleno znovu pro ošetření krajních vstupů, bez předpokladu znalosti nepovinné části kapitoly 3. Co výsledek říká a co ne: nedokazuje znalost, neobrací podmínku, platí za předpokladů modelu. Právě devět versus alespoň devět z deseti (podle Howella). | 10c–d. |
| [Normální aproximace](../../quarto/kapitola_05.qmd#sec-aproximace-postup) a [její přesnost](../../quarto/kapitola_05.qmd#sec-aproximace-presnost) | Orientační podmínka deseti očekávaných úspěchů i neúspěchů (mírnější varianta zmíněna); čtyři kroky pro 135 a více z 200. Přesná hodnota 0,0173, aproximace 0,0152 (přibližně o 12 % nižší), od hranice 134,5 hodnota 0,0182; selhání při n = 20, π = 0,25. Úprava hranice je popsána bez pojmenování. | 11a–c. |
| [Od počtu k podílu](../../quarto/kapitola_05.qmd#sec-od-poctu-k-podilu) | p = k/n jako změna jednotky; střední hodnota π a směrodatná odchylka √[π(1 − π)/n]; stejný z-skór; čtyřnásobek pokusů půlí kolísání. | 11d. |
| [Shrnutí](../../quarto/kapitola_05.qmd#sec-shrnuti-05) | Pravidla, obrácení podmínky, model versus data; pravděpodobnost výsledku za modelu není pravděpodobnost modelu. | Souhrnně 1–12. |

<a id="příklady-vizualizace-a-soubory-3"></a>

### Příklady, vizualizace a soubory

[Sešit kapitoly 5](../../data/kapitola_05.xlsx) má 22 listů: `Prehled`, čtyři
výpočtové listy (`Bayes`, `Binom`, `Binom_20`, `Aproximace`) a sedmnáct
vstupních listů. Výklad pokrývají `Karticky`, `Tabulka_zavislost`,
`Tabulka_nezavislost`, `Screening`, `Test_hadani`, `Sim_hadani` (40 simulovaných
studentů), `Rozpoznavani` a `Losovani`; cvičení listy `U01_emoce`,
`U03_tabulka`, `U04_vstupy`, `U06_screening`, `U07_taxi`, `U08_rozdeleni`,
`U09_test`, `U10_test` a `U11_aproximace`. Úlohy 2, 5 a 12 jsou slovní.
[Pokrytí cvičení](../DATA.md).

Průběžné příklady jsou autorské a modelové: krabice 100 kartiček se slovy,
dva soubory 200 studentů (pohlaví × stres; podle autorovy přednášky),
screeningový dotazník se senzitivitou 0,95 a specificitou 0,90 a test
s výběrem odpovědí. Simulovaná jsou data dvou obrázků a jsou tak označena.
Z literatury jsou převzaty dva příklady s uvedením zdroje: pokus se dvěma
krátce promítnutými podněty (Howell, s. 125–126) a úloha o taxících
ve cvičení 7 (Howell, s. 122–123).

| Obrázek | Didaktický účel |
|---|---|
| [Pět simulovaných řad](../../quarto/kapitola_05.qmd#fig-relativni-cetnost) | Kolísání relativní četnosti; žádný slib pravidelného přibližování. |
| [Sto kartiček](../../quarto/kapitola_05.qmd#fig-karticky) | Výsledek versus jev; proč počítat kartičky, ne slovní druhy. |
| [Průnik a sjednocení](../../quarto/kapitola_05.qmd#fig-prunik-sjednoceni), [podmínění](../../quarto/kapitola_05.qmd#fig-podmineni), [nezávislost](../../quarto/kapitola_05.qmd#fig-nezavislost) | Tatáž tabulka jako plocha: která pole se počítají, jak podmínka mění celek a jak vypadá stejný podíl v obou řádcích. |
| [Strom](../../quarto/kapitola_05.qmd#fig-strom), [dvě prevalence](../../quarto/kapitola_05.qmd#fig-dve-prevalence) | Přirozené četnosti a složení pozitivních výsledků při 10 % a 1 %. |
| [Model a data](../../quarto/kapitola_05.qmd#fig-rozdeleni-model-data) | Rozdělení pravděpodobnosti versus relativní četnosti 40 simulovaných studentů. |
| [Deset kombinací](../../quarto/kapitola_05.qmd#fig-kombinace) | Kombinační číslo jako vypsatelný počet. |
| [Tvar](../../quarto/kapitola_05.qmd#fig-binomicke-tvar), [právě/nejvýše/alespoň](../../quarto/kapitola_05.qmd#fig-binom-oblasti), [aproximace](../../quarto/kapitola_05.qmd#fig-aproximace) | Vliv n a π; které sloupce se sčítají; kdy normální křivka sedí a kdy ne. |

<a id="cvičení-a-očekávané-dovednosti-4"></a>

### Cvičení a očekávané dovednosti

[Dvanáct úloh](../../quarto/kapitola_05.qmd#sec-cviceni-05) má úplná sbalená řešení. Nadpisy úloh
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

<a id="pojmy-konvence-a-hranice-návaznosti-1"></a>

### Pojmy, konvence a hranice návaznosti

Nově je vysvětleno padesát pojmů [registru](../SLOVNIK.md#kapitola-05).
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
změny jednotky, bez názvu směrodatná chyba; otázka „jak pravděpodobný je
výsledek při tipování“ bez rozhodovacího pravidla. **Pouze zmíněno:**
testování hypotéz, inferenční statistika jako oblast, bayesovské pokračování
(aposteriorní pravděpodobnost jako nová apriorní). **Nevyloženo:** věrohodnost,
poměr šancí, název úpravy hranice při aproximaci, binomický a znaménkový
test, multinomické a Poissonovo rozdělení, výběrová rozdělení, centrální
limitní věta, směrodatná chyba, intervaly spolehlivosti. Žádná z těchto
zmínek neschvaluje téma pro další kapitolu; rozsah kapitoly 6 určilo až
[R28](../rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6).

Hlavní oporou pořadí je Howell, kapitola 5, a autorova přednáška
`probability.pptx`; rozsah čtení a zjištěné rozpory jsou v kartách
[mapy zdrojů](../ZDROJE.md).


## Vazby na podklady

Výběr karet pro dohledání podkladů k tématům této kapitoly vychází z tematického rozcestníku a existujících záznamů použití. Samotný odkaz neznamená převzetí příkladu ani nové prostudování; přesné lokátory, použití, nálezy a rozsah ověření jsou v cílových kartách.

- [U01](../zdroje/U01-howell.md#u01) — kap. 5.
- [U04](../zdroje/U04-openintro.md#u04) — kap. 3–4.
- [U08](../zdroje/U08-navarro.md#u08) — §9.2.
- [U10](../zdroje/U10-sahu.md#u10) — kap. 3–7.
- [U11](../zdroje/U11-russo.md#u11) — kap. 3 a §5.1–5.8.
- [U12](../zdroje/U12-baron.md#u12) — pravděpodobnostní úsudky.
- [P03](../zdroje/P03-transformace-rozdeleni.md#p03) — sn. 22–44.
- [P05](../zdroje/P05-pravdepodobnost.md#p05) — pravděpodobnost.
- [C03](../zdroje/C03-ulohy-tyden-3.md#c03) — X3_08–20 a X3_31.
- [D07](../zdroje/D07-utts.md#d07) — s. 77–78.
- [D08](../zdroje/D08-baron-normativni.md#d08) — normativní pojetí.
- [D09](../zdroje/D09-baron-deskriptivni.md#d09) — deskriptivní pojetí.
- [E01-MULHERIN-MILLER](../zdroje/E01-mulherin-miller.md#e01-mulherin-miller) — přenos diagnostické přesnosti.
- [Doplnění kontroly podkladů kapitoly 5](../zdroje/HISTORIE.md#doplnění-kontroly-podkladů-kapitoly-5--2026-10-12) — společný datovaný záznam.
