# Společné nálezy a historie ověřování zdrojů

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md)

Přesun z původní mapy 2026-10-13 zachovává datované záznamy a jejich tehdejší omezení. Nové nálezy ke konkrétnímu zdroji patří do jeho karty; společné kontroly více podkladů sem. Odkazy na originály v `sources/` jsou místní.

## Rozpory, mezery a další práce

| Oblast | Co je třeba respektovat při přípravě kapitoly |
|---|---|
| Schválená koncepce | Pořadí a rozsah určuje OSNOVA; rozsáhlé kapitoly učebnic o ANOVA, regresi či bayesovských metodách nejsou automaticky součástí tohoto semestru. |
| Značení a kvantily | Přednost mají R01–R04, R14 a R15. Staré M/SD/MAD, pořadové algoritmy a N(μ, σ²) nepřebírat bez výslovného rozlišení konvencí. |
| Pojetí pravděpodobnosti | Dostál s. 13–14, Howell s. 108–110, Navarro s. 373–375, Russo s. 52–54 a Baron kap. 5 nepodávají totožný filozofický výklad. Dohodnuto v R21: tři pojetí jako různé interpretace se společnými pravidly, které nemusí vést ke stejnému číslu. |
| Podmínění a nezávislost | [U11](U11-russo.md#u11) s. 62 zaměňuje výsledek diagnostického testu za správnost klasifikace; při použití opravit podle zadání a stromu na s. 60. |
| Data a software | Číselné kódování a missing z SPSS nejsou univerzální požadavek; −99 nesmí vstupovat do běžného průměru. R z cizích knih zůstává interní. |
| Normální model | Rozlišit CDF a kvantil, percentil a pořadí, Q–Q a P–P, interval hodnot a interval spolehlivosti. Starší podklady obsahují konkrétní záměny. |
| Bibliografie | Baronova identita nyní ověřena v celé knize U12; zachovat doložený rozdíl copyrightu 2008 a prvního tisku 2007. Došetřit vydání de Vause a Morgana, rok/verzi Navarra, identitu mezinárodního Arona a přesný původ úloh C2/C3/C5. |
| Nedostupné návazné materiály | U [U11](U11-russo.md#u11) jsou kap. 13–14 a další označené oddíly pouze na webu, nikoli v místním PDF. Odkazované externí datasety, `Datíčka.xls`, videa, QR odkazy, online aplikace, originály studií a navazující části knih nejsou automaticky pokryty inventářem. |
| Nové inferenční podklady | P06: číselné p-hodnoty a zobecnění NHST; P07: rozdělení průměru versus t-statistiky, SE, bootstrap, interpretace intervalů a vzorce rozptylu; C05: modely, argumenty kvantilových funkcí a chybějící simulační sešity. Před použitím vyřešit konkrétní nálezy v kartách. Rozsah a pojetí kapitoly 6 určuje [R28](../rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6); U01 má v kap. 4 nesoulad kritických hodnot a β (karta U01). Kapitola 6 byla napsána 2026-10-12; nesouhlasné hodnoty se do ní nepřevzaly. |
| Parkovací studie | Souhrny Rubacka a Juienga (1997) jsou známy jen z U01 s. 86; původní článek není v `sources/`. Bibliografický záznam (Crossref) a uspořádání podle shrnutí článku byly ověřeny 2026-10-12; plný text čten nebyl. Kapitola 6 proto čísla uvádí „podle Howella“ a rozdíl z pozorovací části studie nevykládá jako prokázaný účinek čekajícího řidiče. |
| Odborné ověření | Před použitím konkrétního příkladu nezávisle ověřit všechny vstupy, výpočty a řešení; před převzetím empirického tvrzení ověřit původní zdroj a relevantní současné poznatky. |

### Aktualizace inventáře — 2026-10-12

Na žádost autora doplněno pět nových souborů, vyřazeny dva odstraněné výřezy a převedeny všechny jejich aktivní místní odkazy do celé knihy. Ověřeny aktuální cesty, rozsahy a SHA-256 proti inventáři, zachována ID D08/D09 a jejich historie. Záznam neznamená schválení dalších kapitol ani úplnou odbornou revizi podkladů. Původní soubory, studentské kapitoly a bibliografie se neměnily. Omezení neúspěšného exportu DOCX a neprovedených kontrol jsou u C05; web se při této dokumentační změně nerenderoval.

### Záznam prvního průzkumu a údržba

Inventura zahrnula všechny soubory ve všech aktuálních podsložkách. Ověřeny byly místní cesty, rozsahy souborů a otisky. Původní podklady nebyly upravovány. Pomocné textové extrakce, OCR, obrazy stran a exporty snímků zůstávají v ignorovaném `tmp/`, nejsou součástí mapy ani veřejného repozitáře.

Při aktualizaci karty zachovej ID; doplň datum, verzi souboru, přesné nově prostudované části, způsob ověření a zbývající mezery. Nový obsahový nález zapisuj k dotčenému zdroji; pouze schválenou změnu výkladu promítni také do osnovy či rozhodnutí. Při výměně vydání knihy zkontroluj všechny odkazované stránky, nikoli pouze první z nich.

### Doplnění kontroly podkladů kapitoly 5 — 2026-10-12

Při revizi znovu přečteny relevantní citované pasáže Howella (zejména
s. 108–112, 119, 121–128), Navarra (373–377), Sahua (64–69), Russa (64),
OpenIntro (95–96), Barona (121–123 a 149–152) a Uttsové (77–78).
V originálním obraze navíc prohlédnuty Howell s. 122 a 128, Sahu s. 64
a 69, OpenIntro s. 95, všechny uvedené strany Barona a Uttsové.
Výpočty kapitoly byly ověřeny nezávisle; u Howellova výsledku 0,513
(s. 122) kapitola správně zaokrouhluje 95/185 na 0,514.
Původní experimentální studie nebyly znovu ověřeny. Identita Baronova
vydání v této dřívější kontrole vycházela z externích údajů D08; pozdější
inventura téhož dne ji doplňuje přímo z monografie [U12](U12-baron.md#u12).
U C03 znovu ověřeno textové zadání X3_31 (100 otázek ano–ne, hranice 65);
kapitola na rozdíl od původního zadání rozlišuje přesný binomický model
a normální aproximaci. Nová typografická revize původního DOCX neproběhla.

### Kontrola podkladů při přípravě kapitoly 6 — 2026-10-12

Na žádost autora o projednání kapitoly o výběrovém rozdělení a principu testování hypotéz byl aktuální obsah `sources/` porovnán s inventářem: 33 souborů, žádný nový ani chybějící. U dvanácti relevantních souborů (U01–U06, U08, U11, P06, P07, C05 a D11) byl znovu ověřen prefix SHA-256, beze změny.

Rozsah nového čtení a nálezy jsou v kartách U01, U03, U04, U05, U08, U11, P06, P07 a C05. Čteno bylo v textové extrakci; v obraze jen U01 s. 95–96. Ve stavu mapy obsahu zůstávají U02 kap. 4–6, U06 kap. 7–8, U07 kap. 3–4, U09 kap. 7–8, U10 kap. 9 a 12, U03 kap. 6 a zbytek U08 kap. 10–11. D07 a D11 nebyly nově čteny; návrh se opírá o jejich karty. Vyhledání klíčových slov v U12 (PDF 150–175) nenašlo pasáž o vlivu velikosti výběru.

Schválený rozsah a pojetí kapitoly určují [R28](../rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6)–[R30](../rozhodnuti/kapitola-06.md#r30-terminologie-kapitoly-6) a [plán v osnově](../kapitoly/plan-pokracovani.md#plan-dalsi-kapitoly). Tento záznam není odbornou revizí podkladů. Originály v `sources/` se neměnily a do složky se nic nepřidalo.

<a id="pouziti-kapitola-06"></a>

### Použití podkladů při tvorbě kapitoly 6 — 2026-10-12

Kapitola 6 byla napsána podle [R28](../rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6)–[R30](../rozhodnuti/kapitola-06.md#r30-terminologie-kapitoly-6); skutečný obsah mapuje [karta v osnově](../kapitoly/06-vyberove-rozdeleni-testovani.md#mapa-kapitola-06). Použití konkrétních pasáží je zapsáno v kartách U01, P06, D07 a D11; u U11 je doplněno potvrzení nálezu v obraze. Ostatní podklady z přípravy sloužily jako opora pojetí, nikoli jako zdroj formulací nebo dat:

- **U04 (OpenIntro), s. 171:** citováno k tvrzení, že výběrové rozdělení ve skutečném výzkumu přímo nepozorujeme. Čteno v textové extrakci.
- **U08 (Navarro), oddíl 11.1:** citováno k rozlišení výzkumné a statistické hypotézy. Lokátorem je oddíl, protože přesné strany nebyly ověřeny.
- **C05, X5_02 a X5_05:** námět cvičení 5 (průměr devíti IQ-skórů nad 105); zadání i řešení jsou nově napsány a přepočteny. Mincovní úloha X5_09 se nepřebírá; příklad mincí cituje Wainera.
- **U03, U05, P07:** bez citace a bez převzatých příkladů.

Tři citované zdroje nejsou v `sources/` a nemají vlastní kartu:

| Zdroj | Co bylo ověřeno | Použití v kapitole a omezení |
|---|---|---|
| Ruback, R. B., a Juieng, D. (1997). *Territorial defense in parking lots: Retaliation against waiting drivers.* *Journal of Applied Social Psychology, 27*(9), 821–834. DOI 10.1111/j.1559-1816.1997.tb00661.x | Bibliografický záznam v metadatech Crossref; uspořádání tří studií podle shrnutí článku. | Původ průběžného příkladu, výklad chování jako hájení teritoria a zmínka o experimentu autorů. Plný text čten nebyl; čísla příkladu jsou z Howella (s. 86). |
| Wasserstein, R. L., a Lazar, N. A. (2016). *The ASA statement on p-values: Context, process, and purpose.* *The American Statistician, 70*(2), 129–133. DOI 10.1080/00031305.2016.1154108 | Bibliografický záznam v metadatech Crossref; znění šesti zásad v oficiálním PDF prohlášení. | Zásada 2 (p-hodnota není pravděpodobnost hypotézy ani toho, že výsledek vznikl náhodou), zásada 3 (závěr se nemá opírat jen o překročení hranice) a zásada 4 (úplné uvádění provedených analýz). Doprovodný komentář a diskusní příspěvky čteny nebyly. |
| Simmons, J. P., Nelson, L. D., a Simonsohn, U. (2011). *False-positive psychology: Undisclosed flexibility in data collection and analysis allows presenting anything as significant.* *Psychological Science, 22*(11), 1359–1366. DOI 10.1177/0956797611417632 | Jen bibliografický záznam v metadatech Crossref. | Jedna věta: rozhodnutí přizpůsobená výsledku zvyšují pravděpodobnost chyby I. druhu nad uvedenou hladinu. Plný text nebyl při tvorbě kapitoly čten; tvrzení odpovídá názvu a obecně známému obsahu článku a před případným rozšířením výkladu je třeba je ověřit v textu. Konkrétní čísla z článku se neuvádějí. |

Originály v `sources/` se neměnily a do složky se nic nepřidalo.

<a id="kontrola-dokumentace-2026-10-16"></a>

## 2026-10-16 — Bibliografická kontrola online dokumentace

Kontrola identifikace, dat a hranic dokumentačních celků pro [R42](../rozhodnuti/spolecne-konvence.md#r42-citace-dokumentace), nikoli nové odborné ověření celého jejich obsahu.

- [NIST e-Handbook](https://www.itl.nist.gov/div898/handbook/index2.htm):
  úvod uvádí významnou revizi duben 2012 a Last updated 04/27/2022;
  dle dohody citujeme celek datem 2022-04-27 a DOI 10.18434/M32189.
  Nejde o tvrzení, že všechny jednotlivé oddíly byly změněny v roce 2022.
- [Microsoft Excel](https://support.microsoft.com/cs-cz/excel/):
  ověřen název Nápověda a výuka pro Excel a vymezení celku. Datum
  obsahové revize není uvedeno; rok 2026 je autorem schválené označení
  používané průběžné dokumentace. Přesný den aktualizace se nedoplňuje.
- [R-devel](https://stat.ethz.ch/R-manual/R-devel/doc/html/index.html):
  ověřen dokumentační rozcestník Statistical Data Analysis; stávající
  odkazy míří do společné dokumentace base/stats. [Adresář](https://stat.ethz.ch/R-manual/R-devel/)
  uvádí změny v roce 2026. Rok 2026 dle dohody, verze označena R-devel;
  nejde o archivovanou stabilní verzi ani důkaz data změny každého hesla.
- [SciPy 1.18.0](https://docs.scipy.org/doc/scipy-1.18.0/):
  ověřeno Date: June 19, 2026, Version: 1.18.0. Bibliografie i konkrétní
  odkazy směřují na tuto verzi namísto proměnlivého rozcestníku. Stránky
  percentileofscore a winsorize této verze vracejí HTTP 200; ověřena
  jejich dostupnost a titulky, nikoli nově celý odborný obsah.
- [Shannon Diversity Index](https://www.itl.nist.gov/div898/software/dataplot/refman2/auxillar/shannon.htm):
  samostatná dokumentace Dataplot, mimo e-Handbook; Last updated 10/07/2016.
  Zachována položka nistShannon s datem 2016-10-07.

U průběžných celků datum přístupu 2026-10-16. Odkazy konkrétních částí
byly převzaty ze stávající bibliografie; změna jejich umístění nedokládá
nové prostudování všech stránek ani nezávislé ověření jejich tvrzení.

<a id="inventura-2026-10-17"></a>

## 2026-10-17 — McElreath, nové přednášky a soubory procvičování

Na žádost autora doplněna mapa nových podkladů. Inventura zahrnula všech
**44 souborů** v `sources/` včetně podsložek a porovnání SHA-256 se starším
inventářem: **11 nových souborů**, **1 obsahově změněný soubor** (P04)
a **1 přesunutý soubor se stejným otiskem** (C04). Z původních 33 souborů
má 32 nezměněný obsah; žádný z nich nechybí. Starší odstraněné výřezy D08/D09
zůstávají mimo inventář podle záznamu z 2026-10-12.

Nové karty:

- [U13 — McElreath](U13-mcelreath.md#u13): druhé vydání z roku 2020,
  identita podle titulní a nakladatelské strany, mapa všech 17 kapitol
  a vybrané pododdíly. Ověřeny začátky kapitol a převod tištěné/PDF stránky;
  čteny předmluvy a vybrané pasáže o konstrukci modelu, nikoli celá kniha.
- [P08](P08-prumery.md#p08) a [P09](P09-nezavisly-ttest.md#p09): porovnávání
  průměrů, intervaly a velikosti účinku.
- [P10](P10-korelace-stps.md#p10) a [P11](P11-korelace-psyb1170.md#p11):
  kovariance, korelace, grafická interpretace a různé koeficienty.
- [P12](P12-kategorialni-data.md#p12) a [P13](P13-chikvadrat-neparametricke.md#p13):
  kategoriální data, chí-kvadrát, párová data a dílčí neparametrické metody.
- [C06](C06-ulohy-tyden-5.md#c06), [C07](C07-ulohy-tyden-8.md#c07),
  [C08](C08-ulohy-tyden-9.md#c08), [C09](C09-ulohy-tyden-12.md#c09):
  soubory týdnů 5, 8, 9 a 12, mapované podle původních ID zadání a řešení,
  nikoli podle stránkování nebo přečíslovaných úloh.

**Rozsah kontroly prezentací:** extrahován text a dostupné poznámky;
v PowerPointu exportovány všechny snímky P08–P13 a nové verze P04,
prohlédnuty všechny jejich obrazové přehledy včetně skrytých snímků.
Vybrané problematické vzorce zkontrolovány ve větší velikosti.
Nejde o otestování animací, vložených interaktivních objektů ani všech
externích odkazů. Konkrétní lokátory nálezů a rozsah nezávislého přepočtu
jsou pouze v příslušných kartách.

**Rozsah kontroly DOCX:** zmapována zadání i místní řešení podle textu
a tabulek z OOXML, podrobněji přečteny vybrané pasáže uvedené v kartách.
Export pouze pro čtení ve Wordu se zablokoval; vlastní automatizační
instance byla ukončena bez změny originálů. Úplné vykreslení, stránkování
a kontrola všech vložených grafů a obrázků **nejsou dokončeny**. Rozpory
z textu jsou proto označeny k potvrzení v originálním vykreslení; tam,
kde proběhl nezávislý přepočet, je oddělen od tohoto vizuálního omezení.
Externí řešení C7/C10 a jejich původní vydání nejsou ověřena.

**Nezávislé kontroly:** vybrané mezikroky, interval rozdílu průměrů,
kappa, korelace a kontingenční tabulka přepočteny v čisté relaci R 4.5.1.
Karty odkazují také na přečtené příslušné oddíly NIST a dokumentace
R a effectsize. Nebyl přepočten celý soubor řešení ani vyzkoušeny české
vzorce v Excelu. Původní empirické studie, historická tvrzení a úplný
kód McElreathovy knihy nebyly nezávisle ověřeny.

**Údržba stávajících karet:** [P04](P04-normalni-rozdeleni.md#p04) zachovává
historický nález, ale odděluje autorovu částečnou opravu sn. 21 od
přetrvávajících problémů. [C04](C04-seminar-4.md#c04) má opravenou cestu
do `sources/starší přednášky/`; stejné ID a původní historie zůstávají.
Tematický rozcestník nově rozlišuje korelace, kategoriální data, porovnávání
průměrů a bayesovské modelování. Nejde o schválení nových kapitol,
terminologie či změny hlavního didaktického zdroje. Originály, extrakce
a obrazové exporty nebyly přidány do veřejné dokumentace.


<a id="priprava-07-20261017"></a>

## Čtení pro návrh kapitoly 7 — 2026-10-17

Úkol: po souhlasu autora se zaměřením na odhad průměru, intervaly spolehlivosti a jednovýběrový t-test připravit podrobný návrh k projednání. Studentská kapitola nevznikla; níže se eviduje čtení a ověřování, nikoli schválení podrobného rozsahu, nových termínů nebo značení.

Inventář ověřen proti všem 44 místním souborům: cesty, počty a všechny 16místné prefixy SHA-256 souhlasí. Žádný nový nebo změněný soubor. Při výběru byly zohledněny všechny skupiny podkladů v tematickém rozcestníku; ostatní učebnice a mimotematické zdroje nebyly nově podrobně přečteny.

Nové čtení a přesné hranice: [Howell](U01-howell.md#priprava-07-20261017), [Cumming](U03-cumming.md#priprava-07-20261017), [OpenIntro](U04-openintro.md#priprava-07-20261017), [Dostál](U05-dostal.md#priprava-07-20261017), [intervalová prezentace](P07-usuzovani-intervaly.md#priprava-07-20261017), [prezentace průměrů](P08-prumery.md#priprava-07-20261017), [úlohy týdne 4](C05-ulohy-tyden-4.md#priprava-07-20261017) a [výběr úloh týdne 9](C08-ulohy-tyden-9.md#priprava-07-20261017). P09 byl pro hranici vůči porovnávání skupin posouzen podle aktuální karty, nikoli novým úplným čtením.

Nezávislá odborná kontrola vztahů a četnostního pokrytí: [NIST, Confidence Limits for the Mean](https://www.itl.nist.gov/div898/handbook/eda/section3/eda352.htm), přístup 2026-10-17. České názvy a argumenty ověřeny také v dokumentaci Microsoftu: [T.INV](https://support.microsoft.com/cs-cz/excel/functions/t-inv-function), [T.DIST](https://support.microsoft.com/cs-cz/excel/functions/t-dist-function), [T.DIST.2T](https://support.microsoft.com/cs-cz/excel/functions/t-dist-2t-function), [T.INV.2T](https://support.microsoft.com/cs-cz/excel/functions/t-inv-2t-function).

V čisté relaci R 4.5.1 přepočteny vybrané souhrny a příklady vymezené v kartách. U vlastní návrhové varianty pozornosti m = 46, s = 10, n = 25 vychází s_m = 2, t = −2, 24 stupňů volnosti, 95% interval (41,87220288; 50,12779712), oboustranná p-hodnota 0,05693985 a levostranná 0,02846992. Varianta s výběrovou s = 10 je nově navržený modelový vstup, nikoli údaj dodatečně nalezený v kapitole 6. Při použití násobku 1,96 místo t-kvantilu má interval m ± 1,96 s_m za nezávislého normálního modelu a n = 10 pokrytí přibližně 91,835 %, nikoli 95 % (kontrola přes t-rozdělení, nikoli simulací).

Šest vzorců pro návrhový příklad skutečně spuštěno přes FormulaLocal v samostatné skryté instanci českého desktopového Excelu: T.INV(0,975;24), T.DIST(-2;24;PRAVDA), T.DIST.2T(ABS(-2);24), T.INV.2T(0,05;24) a obě meze 46 ± T.INV(0,975;24)*10/ODMOCNINA(25). Výsledky souhlasí s R. Pomocný sešit uzavřen bez uložení; studentský sešit nebyl vytvořen. Nejde o validaci budoucího generátoru nebo všech funkcí.

Původní soubory, studentský text a terminologické registry se nezměnily. Úplná obrazová kontrola všech zdrojů, originální empirické studie, externí simulace a zbývající výpočty nejsou doloženy tímto záznamem. Výřezy a extrakce zůstávají pouze v ignorovaném tmp/, nejsou určeny k publikaci.

<a id="pouziti-kapitola-07"></a>

## Použití podkladů při tvorbě kapitoly 7 — 2026-10-17

Kapitola 7 vznikla podle [R44](../rozhodnuti/kapitola-07.md#r44-rozsah-kapitoly-7)–[R46](../rozhodnuti/kapitola-07.md#r46-terminologie-kapitoly-7). Použití podkladů:

- [U01](U01-howell.md#u01): Gosset a t-rozdělení (s. 185), prohlídka dat PDI (s. 186–188), souhrny PDI a výklad nečekaného směru (s. 188), normy jako pevná hodnota jen u velkých normativních výběrů (s. 195). Howellova bayesovsky znějící formulace konkrétního intervalu (s. 194) a kvantily podle horního chvostu převzaty nebyly. Pasáže s. 188 a 195 ověřeny v textu PDF při psaní.
- [U03](U03-cumming.md#u03): myšlenka pásma zanedbatelných hodnot (s. 151–152) a opakovaných intervalů (kap. 5); bez převzetí obrázků a metafor.
- [E02](E02-lakens-2017.md#e02-lakens-2017) a [E03](E03-lakens-2018.md#e03-lakens-2018): hypotézy testu ekvivalence, TOST, 90% interval (pozn. 2), reportování větší p-hodnoty, zdůvodnění hranic, volba hranic předem, čtyři kombinace výsledků. Plný text z Europe PMC (E02) a indexu scite (E03), přístup 2026-10-17.
- Nově citovaná původní studie Nurcomba et al. (1984) se uvádí jen jako původ souhrnů převzatých od Howella; metadata ověřena v Crossref (DOI 10.1016/S0002-7138(09)60511-2), článek nebyl čten.
- [P07](P07-usuzovani-intervaly.md#p07), [P08](P08-prumery.md#p08), [C05](C05-ulohy-tyden-4.md#c05) a [C08](C08-ulohy-tyden-9.md#c08) sloužily k pochopení priorit autora a jako náměty cvičení (vlivy na šířku, výklad 95 %, kvantily, známá a neznámá σ). Žádná úloha ani číselný příklad z nich převzat nebyl; nálezy evidované v kartách (t-rozdělení průměru, koeficient 2,4, hranice n > 30) se do textu nedostaly.

<a id="field-2026-10-18"></a>

## Doplnění Fielda, van Doorna a Wagenmakerse — 2026-10-18

Na žádost autora doplněn nový soubor `sources/učebnice/field.pdf` jako
[U14](U14-field.md#u14). Aktuální inventář má 45 souborů; cesty a všech
44 dosavadních prefixů SHA-256 ověřeny proti místním originálům, bez změny.
Jediný přírůstek je nová učebnice. Starší ID a datované záznamy zachovány.

Karta U14 obsahuje ověřenou bibliografickou identitu, místní rozsah a otisk,
mapu všech 17 kapitol, vybrané tematické lokátory a přesně vymezené čtení,
obrazovou kontrolu a neověřené části. Podrobnosti a upozornění pro použití
jsou pouze [v kartě](U14-field.md#u14-overeni). Tematický rozcestník doplněn
u metodologie, popisu dat, grafů, inference, předpokladů a navazujících metod.
Jde o nabídku podkladu, nikoli o doklad použití ve studentských kapitolách,
změnu hlavního zdroje nebo schválení výuky JASP.

Originál a pomocné textové i obrazové výstupy zůstávají neveřejné;
studentům se nic nového nepublikuje. Kontrola ostatních 44 souborů byla
inventární, nikoli novým odborným čtením.

<a id="wilcox-2026-10-30"></a>

## Doplnění Wilcoxe — 2026-10-30

Na žádost autora doplněn nový soubor `sources/učebnice/wilcox.pdf` jako
[U15](U15-wilcox.md#u15). Aktuální inventář má 46 souborů; cesty a všech
45 dosavadních prefixů SHA-256 ověřeny proti místním originálům, bez změny.
Jediný přírůstek je nová učebnice. Starší ID a datované záznamy zachovány.

Karta U15 obsahuje bibliografickou identitu ověřenou na titulní straně,
tiráži a stránce nakladatele, místní rozsah a otisk, mapu všech 15 kapitol
a příloh, tematické lokátory ověřené v textu a přesně vymezené čtení.
Upozornění pro použití (R místo Excelu, Wilcoxovo MAD vs. projektové MedAD
a MeanAD, meze CLT a t při nenormalitě, vyhraněné stanovisko k robustním
metodám) jsou pouze [v kartě](U15-wilcox.md#u15-overeni). Tematický
rozcestník doplněn u popisných statistik, normálního modelu, výběrových
rozdělení, testování, intervalů, bootstrapu, porovnání průměrů, korelace,
kategoriálních dat a navazujících metod. Jde o nabídku podkladu, nikoli
o doklad použití ve studentských kapitolách, změnu hlavního zdroje nebo
schválení robustních metod jako učiva.

Originál a pomocné textové i obrazové výstupy zůstávají neveřejné;
studentům se nic nového nepublikuje. Kontrola ostatních 45 souborů byla
inventární, nikoli novým odborným čtením.

<a id="billiet-2026-10-31"></a>

## Doplnění Billieta — 2026-10-31

Na žádost autora doplněn nový soubor `sources/ostatní zdroje/measurement.pdf`
jako [D12](D12-billiet.md#d12) (Billiet, 2016, kapitola 14 sborníku
*The SAGE Handbook of Survey Methodology*). Aktuální inventář má 47 souborů;
cesty a všech 46 dosavadních prefixů SHA-256 ověřeny proti místním
originálům, bez změny. Jediný přírůstek je tato kapitola. Starší ID
a datované záznamy zachovány.

Karta D12 obsahuje identitu ověřenou v PDF a záznamu Crossref (DOI), místní
rozsah, otisk, převod tištěných stran na stránky PDF, mapu všech oddílů
a nálezy (rozpor N a roku ESS mezi textem a tab. 14.1 ověřen v obraze strany,
chybné údaje v literatuře). Celý text přečten z textové vrstvy; citovaná
primární literatura a data ESS nebyla ověřována. Tematický rozcestník doplněn
u řádku o výzkumné otázce a měření, karta kapitoly 1 získala tematický
odkaz. Jde o nabídku podkladu, nikoli o doklad použití ve studentské kapitole
ani o schválení latentních proměnných, CFA či invariance měření jako učiva.

Originál a pomocné textové i obrazové výstupy zůstávají neveřejné;
studentům se nic nového nepublikuje. Kontrola ostatních 46 souborů byla
inventární, nikoli novým odborným čtením.
