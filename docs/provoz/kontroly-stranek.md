# Rozsah kontrol jednotlivých stránek (stav k 2026-11-27)

[Zpět na návod k vizualizacím a aplikacím](vizualizace-a-aplikace.md)

Historický výčet scénářů, které `quarto/_verification/check-html.cjs` ověřoval
u jednotlivých stránek vizualizací a aplikací ke dni 2026-11-27. Text je beze
změny převzat z provozního návodu při jeho rozdělení
([doplnění R32](../rozhodnuti/postupy-a-dokumentace.md#r32-doplneni-2026-11-27)).
Platný rozsah kontrol určuje kontrolní skript, u aplikací také
`scripts/check-stat-lib.mjs`; nové výčty se sem nepíší
([R88](../rozhodnuti/postupy-a-dokumentace.md#r88-bez-opakovani)).

## Interaktivní vizualizace

U pilotu výběrového rozdělení průměru kontrola ověřuje:

- šest grafů (čtyři panely a dva Q–Q grafy) a žádný viditelný kód
  ani tlačítko schránky;
- hustoty pěti populací proti `dnorm`, `dgamma` a posunutému `dlnorm` z R;
- šířku a hodnotu odhadu hustoty proti `bw.nrd0` a ručnímu součtu
  `dnorm` v R a normální kvantil proti `qnorm`;
- ztenčení Q–Q grafu se zachováním krajních bodů;
- odmítnutí neplatných hodnot obou číselných polí (0, 1001 nebo 10 001, 2,5),
  jejich meze a šipky;
- losování 10 000 výběrů po 1000 po dávkách se zablokovaným ovládáním
  a průběhem (stav `busy` v `vizCheck`);
- přepínání populací, strop 100 000 opakování se zprávou a jeho zrušení
  tlačítkem „Začít znovu“;
- normální křivku v obou histogramech průměrů po jednom zaškrtnutí,
  řádek s podíly standardizovaných průměrů za ±2, ovládání klávesnicí,
  šířku 375 px bez přetékání a odkaz z kapitoly 6.

U vizualizace ploch pod normální křivkou kontrola ověřuje:

- čtyři grafy (hustota a distribuční funkce v obou částech) a žádný
  viditelný kód ani tlačítko schránky;
- `pnorm` a `qnorm` stránky proti hodnotám z R včetně vzdálených chvostů;
- všech osm úloh v modelu N(50, 10) proti `pnorm`/`qnorm` z R a přesné
  znění vzorců `NORM.DIST`/`NORM.INV`, které stránka nabízí;
- odmítnutí neplatných vstupů (σ = 0, −1, text; podíl 0, 1 a 1,5; dolní
  mez nad horní) se zprávou a ponecháním poslední platné hodnoty;
- desetinnou čárku i tečku, typografické minus, volbu úlohy šipkami,
  poznámku u hranice mimo zobrazený rozsah, šířku 375 px bez přetékání
  a odkaz z kapitoly 4.

U vizualizace binomického rozdělení (pravděpodobnost počtu úspěchů)
kontrola ověřuje:

- dva grafy (pravděpodobnosti a kumulativní pravděpodobnost) a žádný
  viditelný kód ani tlačítko schránky;
- `dbinom` a `pbinom` stránky proti hodnotám z R pro *n* od 5 do 1000
  včetně π blízké 1 a velmi malých pravděpodobností;
- všech osm kombinací zaškrtávacích polí pro *k* = 5 (pravděpodobnost,
  doplněk do 1 a přesné znění vzorce `BINOM.DIST`), „alespoň“ a „více než“
  pro *k* = 10 a nemožné jevy „méně než 0“ a „více než *n*“;
- obě normální aproximace (hranice uprostřed a na okraji sloupců) proti
  `pnorm` z R pro příklad s 200 pokusy, pro „právě 5“, „méně než 5“
  a rozpětí 8 až 12 včetně znění vzorců `NORM.DIST` a `BINOM.DIST.RANGE`;
- zapnutí a vypnutí aproximace v grafu, nedostupnost při π = 0, snížení
  hranic při menším *n* se zprávou a chybu pořadí mezí rozpětí;
- odmítnutí neplatných vstupů (*n* 0, 1001, 2,5; π 1,2, −0,1 a text;
  mez nad *n*) se zprávou a ponecháním poslední platné hodnoty, šipky
  pole *n*, výřez osy pro *n* = 1000 a π = 0,01 s poznámkou, volbu typu
  otázky šipkami, šířku 375 px bez přetékání a odkaz z kapitoly 5.

U vizualizace Bayesovy věty (co znamená pozitivní výsledek testu) kontrola
ověřuje:

- pět grafů (mřížka osob, strom, křivka podle prevalence, řetěz
  pravděpodobností a mřížka druhého vyšetření) a žádný viditelný kód,
  tlačítko schránky ani chybu OJS;
- úplnou pravděpodobnost pozitivního výsledku, obě prediktivní hodnoty
  a pravděpodobnost poruchy po negativním výsledku pro sedm nastavení
  (oba příklady kapitoly 5, vliv specificity a senzitivity, necelé počty,
  výsledek, který nenastane) a šest dvoukrokových aktualizací proti R;
- přirozené četnosti se zaokrouhlením na celé osoby, výchozí výsledky,
  popis mřížky a dosazení do Bayesovy věty, přesné znění tří vzorců Excelu
  a dvou vzorců druhého vyšetření s odkazy na list `Bayes`;
- uspořádání mřížky včetně volby šipkami, menší mřížku jen pozitivních
  výsledků, zvýraznění počtů v tabulce, tlačítka obou příkladů, výřez grafu
  a poznámku u prevalence mimo něj, přepínač stejných vlastností druhého
  testu, upozornění „přibližně“ a text „nelze určit“;
- odmítnutí neplatných vstupů (1,2; −0,1; text; 2; prázdné pole) se zprávou
  a ponecháním poslední platné hodnoty, desetinnou čárku i tečku, šířku
  375 px bez přetékání stránky i tabulky a odkaz z kapitoly 5.
U vizualizace statistické síly kontrola ověřuje:

- tři grafy (situace A, situace B, křivka síly), vzor šrafování α v obou
  hlavních grafech a žádný viditelný kód ani tlačítko schránky;
- sílu pro 17 nastavení (scénáře předlohy ke kapitole 6, hodnoty z textu
  kapitoly 6 a okrajové případy: *n* = 1, α = 0,5, záporný rozdíl, opačný
  směr jednostranného testu, rozdíl 0) proti `pnorm`/`qnorm` z R;
- výchozí stav obou situací, kritickou hodnotu a směrodatnou chybu, přesné
  znění vzorců Excelu pro tři směry a shodu výsledku vzorce se zaokrouhlenými
  mezivýsledky s přesnou silou;
- společnou σ pro obě situace, volbu směru šipkami, text pro rozdíl 0
  a zápis „< 0,001“;
- odmítnutí neplatných vstupů (*n* 0, 1001, 2,5; σ 0 a text; α 0 a 0,6;
  rozdíl 1001) se zprávou a ponecháním poslední platné hodnoty, mez
  a šipky pole *n*, šířku 375 px bez přetékání a odkaz z kapitoly 6.

U vizualizace posunu a změny jednotek kontrola ověřuje:

- jeden graf se dvěma tečkovými grafy a žádný viditelný kód, tlačítko
  schránky ani chybu OJS;
- shodu dob spánku a vybavených slov na stránce se sdílenými daty
  `data/kapitola_02.csv` (bez tří chybějících dob spánku) a pět časů;
- průměr, medián, kvartily, rozpětí, *s*, *s*², šikmost a exces všech tří
  souborů proti `mean`, `median`, `quantile(type = 7)`, `sd`, `var`
  a vzorcům SKEW/KURT v R;
- výchozí převod na sekundy, všech šest předvoleb a zadání *a* = 3,
  *b* = −2,5 (desetinná čárka, typografické minus): ukazatele převedených
  dat proti R, shodu předpovědi pravidlem s nimi, výměnu kvartilů při
  záporném *b*, „nelze určit“ při *b* = 0 a přesné znění vzorců Excelu;
- druhou mocninu pěti časů a odmocninu spánku proti R, převod původního
  průměru (36 proti 40,4) se slovy „liší se“ a „shoduje se“;
- odmítnutí neplatných vstupů (text, 2 000 000, „1,2,3“) se zprávou
  a ponecháním poslední platné hodnoty, volbu osy šipkami, šířku 375 px
  bez přetékání stránky a odkaz z kapitoly 3.

U vizualizace *t*-rozdělení a normovaného normálního kontrola ověřuje:

- čtyři grafy (hustoty, normální Q–Q graf, absolutní a relativní chyba)
  a žádný viditelný kód, tlačítko schránky ani chybu OJS;
- hustotu, distribuční funkci a kvantil *t*-rozdělení stránky pro 1, 4, 30
  a 100 stupňů volnosti včetně vzdálených chvostů proti `dt`, `pt` a `qt`
  z R a `pnorm` proti R;
- výchozí stav (4 stupně volnosti, hranice −1,645), podíly za hranicí,
  relativní chybu, přesné znění vzorců `T.DIST`/`NORM.S.DIST`, počet bodů
  Q–Q grafu mimo osu a kvantily živé tabulky proti `qt` z R;
- posuvník (meze, krok, šipky, Home a End), vložení a zvýraznění řádku
  pro 7 stupňů volnosti v pevné tabulce, pravý chvost u kladné hranice,
  hranici 0, desetinnou čárku a typografické minus;
- odmítnutí neplatné hranice (text, 11, „1,2,3“) se zprávou a ponecháním
  poslední platné hodnoty, přepnutí na výšku hustoty s výškami proti `dt`
  a `dnorm` a vzorcem `T.DIST(…;NEPRAVDA)`, šířku 375 px bez přetékání
  a odkaz z kapitoly 7.

U vizualizace intervalu spolehlivosti a *p*-hodnoty kontrola ověřuje:

- dva grafy (pohled intervalu a pohled testu) a žádný viditelný kód,
  tlačítko schránky ani chybu OJS;
- *p*-hodnotu, kvantil, mezní chybu a meze intervalu pro sedm nastavení
  (všechny tři směry testu, příklady kapitoly 7, záporné μ₀, α = 0,5)
  proti R a shodu čtyř pohledů na rozhodnutí; na přesné mezi intervalu
  *p*-hodnotu rovnou α a zamítnutí všemi čtyřmi pohledy;
- výchozí stav (pozornost oboustranně), rozsah osy a posuvníků, krok
  posuvníku šipkou a souběh s polem, přesné znění vzorců `T.DIST.2T`,
  `T.INV.2T` a `T.DIST`;
- předvolby (jednostranný test „menší“ s jednostranným intervalem
  a 90% oboustranným intervalem, PDI), přepnutí na alternativu „větší“,
  rozšíření rozsahu po zápisu hodnoty mimo něj;
- odmítnutí neplatných vstupů (*s* = 0, *n* = 1 a 2,5, α = 0,6, text,
  „1,2,3“) se zprávou a ponecháním poslední platné hodnoty, šířku 375 px
  bez přetékání, pořadí v menu a odkaz z kapitoly 7.

U vizualizace pokrytí intervalu spolehlivosti kontrola ověřuje:

- čtyři grafy při známé σ (stejné šířky se nekreslí) a pět s výběrovou *s*,
  žádný viditelný kód, tlačítko schránky ani chybu OJS;
- kvantily *z* a *t*, meze všech devíti kombinací postupu a typu intervalu
  a přesné pokrytí chybného postupu (*s* s kvantilem *z*) pro *n* 5–100,
  hladiny 90, 95 a 99 % proti R; otevřené a uzavřené meze;
- pět populací (průměr 0, směrodatná odchylka 1, šikmost a přesný podíl
  hodnot do průměru proti `pnorm` a `pgamma` z R);
- výchozí stav s pevným seedem (94 ze 100 intervalů), nezávislé přepočítání
  zachycených intervalů z uložených *m* a *s*, tytéž výběry po změně
  postupu, typu i hladiny, vzorce Excelu a výběr intervalu klávesami;
- rozsah osy grafu intervalů, který u normální i extrémně zešikmené
  populace a všech tří typů intervalu obsahuje všechny konečné meze;
- normální populaci se 100 000 výběry ve čtyřech kombinacích (pokrytí do
  čtyř směrodatných chyb od přesné hodnoty), strop 100 000 se zprávou
  a „Začít znovu“;
- u výrazně a extrémně zešikmené populace pokrytí všech devíti kombinací
  proti simulaci v R (`scripts/viz-pokryti-intervalu.R`, odchylka do 0,008)
  a soulad slovního směru očekávání s výsledky R pro všechny zešikmené
  populace a *n* = 5, 10 a 25;
- odmítnutí neplatných vstupů (σ = 0 a −2, *n* = 1 a 1001, hladina 50
  a 100, text, počet výběrů 0 a 10 001), losování po dávkách se
  zablokovaným ovládáním, předvolbu chybného postupu, rozšíření grafů na
  celé obrazovce, šířku 375 px bez přetékání, pořadí v menu a odkaz
  z kapitoly 7.

U vizualizace Cohenova d kontrola ověřuje:

- dva grafy (rozdělení skupin a rozdíl hodnot náhodné dvojice) a žádný
  viditelný kód, tlačítko schránky ani chybu OJS;
- tři ukazatele pro devět hodnot *d* od 0 do 2 proti `pnorm` z R
  (`scripts/viz-cohenovo-d.R`, kde je společná plocha ověřena i numerickou
  integrací a pravděpodobnost u dvojice simulací);
- výchozí stav (*d* = 0,5, σ = 10), rozsah a krok posuvníku, vzorce Excelu,
  zaokrouhlené hodnoty ve výpisu a štítky Cohenových hodnot v tabulce;
- posuvník klávesnicí (šipky po 0,01 bez zbytků desetinné aritmetiky,
  Home a End s krajními hodnotami), vložení a zvýraznění *d* mimo tabulku;
- pole σ s desetinnou čárkou a odmítnutí hodnot 0, −1, textu a 2 000 000
  se zprávou a ponecháním poslední platné hodnoty, přepínač vybarvení;
- rozšíření grafů na celé obrazovce, šířku 375 px bez přetékání, pořadí
  v menu a odkaz z oddílu kapitoly 8 `sec-d-nezavisle`.

U vizualizace přínosu párování kontrola ověřuje:

- čtyři grafy (spojnice, rozdíly, oba intervaly, směrodatná chyba v modelu)
  a po losování histogram šířek intervalů; žádný viditelný kód, tlačítko
  schránky ani chybu OJS;
- kvantily `qt` a obě analýzy (párový a klasický *t*-test: směrodatná
  chyba, *t*, stupně volnosti, *p*, meze, *s*₁, *s*₂, *s_D*, *r*) pro data
  varianty A, kontrastní příklad 2, 4, 6 / 6, 12, 18 a testovací soubor
  osmi dvojic proti `t.test` z R (`scripts/viz-prinos-parovani.R`);
- směrodatné chyby v modelu pro šest nastavení obou způsobů zadání;
- výchozí stav s daty varianty A, tabulku jako tab. 8.4, znění vzorců
  Excelu včetně `T.TEST` typ 1 a 2, skrytí korelace v prvním způsobu zadání;
- posuvník klávesnicí s přepnutím na výběr z modelu, opakované použití
  týchž náhodných čísel (změna μ_D posune rozdíly přesně), nový výběr,
  pole *n* a μ_D s odmítnutím neplatných hodnot (2, 201, 2,5, text; −60);
- losování po dávkách se zablokovaným ovládáním a podíly zamítnutí
  a pokrytí z 10 000 výběrů pro tři nastavení proti R (párová analýza
  přesně z necentrálního *t*-rozdělení, chybná ze simulace R) s tolerancí
  asi čtyř směrodatných chyb simulace; vynulování po změně modelu a strop
  100 000 výběrů;
- návrat k datům varianty A, rozšíření grafů na celé obrazovce, šířku
  375 px bez přetékání a odkaz z oddílu kapitoly 8 `sec-proc-rozdily`.

U vizualizace dvou intervalů a intervalu rozdílu kontrola ověřuje:

- pět grafů u nezávislých skupin (intervaly průměrů, interval rozdílu,
  pásma podle rozdílu, mezní chyby, trojúhelník) a čtyři u párových dat;
  žádný viditelný kód, tlačítko schránky ani chybu OJS;
- meze obou intervalů, *t*, *p*, interval rozdílu a hranice pásma pro
  příklad kapitoly na hladinách 90, 95 a 99 %, Welchův a klasický postup
  pro nestejné skupiny, klasický postup s variabilnější větší skupinou
  (intervaly se nepřekrývají, rozdíl nevýznamný) a párová data varianty A
  včetně největšího $s_D$ proti R (`scripts/viz-dva-intervaly.R`);
- výchozí stav, slovní závěr, souhrny a znění vzorců Excelu (včetně
  kvantilu přes `BETA.INV` a Welchových stupňů volnosti), přepínače
  hladiny a postupu, předvolby včetně právě se dotýkajících intervalů;
- odmítnutí neplatných vstupů (*n* 1, 1001, 2,5; *s* 0, −1, text; průměr
  text) se zprávou a ponecháním poslední platné hodnoty;
- párové uspořádání: skrytá pole, posuvník $s_D$ klávesnicí s mezemi
  $|s_1-s_2|$ a $s_1+s_2$, nezávislost intervalů podmínek na $s_D$
  a přizpůsobení mezí při změně *s*;
- rozšíření grafů na celé obrazovce, šířku 375 px bez přetékání, pořadí
  v menu a odkaz z oddílu kapitoly 8 `sec-dva-intervaly`.

U vizualizace Waldova a Wilsonova intervalu pro podíl kontrola ověřuje:

- šest grafů (intervaly, nerovnice, pokrytí, Wald mimo 0–1, dva sloupcové
  grafy) a žádný viditelný kód, tlačítko schránky ani chybu OJS;
- kvantil, meze obou intervalů a kořeny kvadratické rovnice (shodné
  s mezemi Wilsonova intervalu) pro devět zadání včetně 0 z 15, 1 z 25,
  *k* = *n*, *n* = 1 a hladin 50, 90 a 99 %; přesné pokrytí obou intervalů
  a pravděpodobnost Waldova intervalu mimo 0–1 nebo s nulovou šířkou ve
  dvanácti bodech; průměrné a nejnižší pokrytí a podíl hodnot π pod
  hladinou pro čtyři kombinace *n* a hladiny proti R
  (`scripts/viz-interval-podilu.R`);
- výchozí stav, texty s dosazením, součty sloupců a znění vzorců Excelu,
  předvolby s upozorněním na nulovou šířku a zápornou mez a přepínač meze
  Waldova intervalu;
- odmítnutí neplatných vstupů (*n* 0, 201, 2,5, −1; *k* nad *n*) se zprávou
  a ponecháním poslední platné hodnoty, snížení *k* při snížení *n*,
  nezávislost pokrytí na *k*;
- posuvník hladiny a vybrané π klávesnicí (šipky, Shift, Page Up, Home,
  End), výběr π klepnutím do grafu, výřez sloupců při *n* = 200, rozšíření
  grafů na celé obrazovce, šířku 375 px bez přetékání a odkaz z pododdílu
  kapitoly 9 `sec-wilson`.

U vizualizace tabulky četností a testu chí-kvadrát kontrola ověřuje:

- dva grafy (řádkové podíly, chí-kvadrát rozdělení); žádný viditelný kód,
  tlačítko schránky ani chybu OJS;
- pravý chvost, hustotu a kritickou hodnotu chí-kvadrát rozdělení se
  čtyřmi stupni volnosti a pro šest tabulek (kapitola, zdvojená,
  „Nezávislost“ a tři tabulky z úkolů) χ², *p*, Cramérovo V, nejmenší
  očekávanou četnost, očekávanou četnost, příspěvek a obě rezidua proti R
  (`scripts/viz-chi-kvadrat.R`);
- výchozí stav, slovní závěr, souhrny, vzorec `CHISQ.DIST.RT`, obsah čtyř
  odvozených tabulek a podbarvení standardizovaných reziduí (barva podle
  znaménka, sytost podle velikosti);
- tlačítka zdvojnásobení (stejné V a řádkové podíly, *p* jako „< 0,001“),
  „Nezávislost“ a „Původní data“; změnu buňky z klávesnice včetně šipek;
- odmítnutí neplatných četností (prázdná, záporná, necelá, nad 100 000)
  a tabulky s prázdným řádkem nebo sloupcem se zprávou a ponecháním
  poslední platné tabulky;
- upozornění při očekávané četnosti pod 5 s odkazem na `sec-male-cetnosti`
  a vypnutí zdvojnásobení nad mezí;
- rozšíření grafů na celé obrazovce, šířku 375 px bez přetékání, pořadí
  v menu a odkaz z pododdílu kapitoly 9 `sec-pearson-upravena`.

U vizualizace rozdílu podílů, poměru rizik a poměru šancí kontrola ověřuje:

- jeden graf tří čar, dvě pole osob a dvě pole retrospektivního výběru;
  žádný viditelný kód, tlačítko schránky ani chybu OJS; odkaz na citovaný
  článek;
- rizika, rozdíl, poměr rizik, šance, poměr šancí, χ², φ a rozdíl
  sloupcových podílů pro pět tabulek (Danielsová, se zaměněnými skupinami,
  aspirin, úloha 10, dvě rizika 40 % a 17 %), hodnoty tří čar a podíly
  v retrospektivním výběru proti R (`scripts/viz-miry-souvislosti.R`);
  prázdnou hodnotu místo dělení nulou;
- výchozí stav, slovní čtení, míry s dosazením, část o φ, tabulku čar,
  popisek pole osob a rozdělení pole v pohledu na šance;
- předvolbu aspirinové studie (téměř shodné poměry, pole osoba po osobě)
  a záměnu referenční skupiny (převrácené poměry, záporné φ a rozdíl);
- odmítnutí neplatných četností a prázdné skupiny, nulovou buňku
  („nelze spočítat“), šipky v poli a přepočet polí na 10 000 osob u tabulky
  nad 25 000 osob;
- zadání dvěma riziky: posuvníky klávesnicí, držení poměru šancí,
  poměru rizik (včetně upozornění, když už není možný) a rozdílu rizik,
  krok 0,1 % u skupin po 1 000 osobách;
- posuvník retrospektivního výběru klávesnicí a srovnávací tabulku;
- rozšíření grafu na celé obrazovce, šířku 375 px bez přetékání i s poli
  aspirinové studie, pořadí v menu a odkaz z pododdílu kapitoly 9
  `sec-phi-v`.

U vizualizace korelace v bodovém grafu kontrola ověřuje:

- 40 bodů výchozích dat, Vennův diagram, bodový graf pořadí a graf spojnic;
  žádný viditelný kód, tlačítko schránky ani chybu OJS; odkaz na citovanou
  aplikaci; odkazy z pododdílů kapitoly 10 `sec-vydelime` (v oddílu
  `sec-pearsonovo-r`) a `sec-odlehle-korelace`;
- průměry, SD, kovarianci, *r*, $r_s$, *r*², přímku, součet čtverců reziduí,
  *t*, *p* a Fisherův interval pro pět souborů (úzkost a výkon, spánek,
  pevné body, Anscombe IV, překlep 300), poloměry elips, vzdálenost kruhů
  Vennova diagramu a transformaci na *r* = 0,3 a −0,8 proti R
  (`scripts/viz-korelace.R`); průměrná pořadí při shodách a „nelze spočítat“
  bez variability nebo při *r* = 1;
- výchozí přehled s dosazením včetně směrodatné chyby $z_r$ a mezí na
  stupnici $z_r$ (0,164; −0,903 a −0,259), kvadranty (25 záporných součinů),
  přímku a rezidua, počty bodů uvnitř elips (24, 33, 39, 40; Anscombe I 4, 9,
  11, 11) a rozšíření os pro elipsu 99 %;
- rozvržení: čtvercovou kreslicí plochu hlavního grafu přes celou šířku
  i grafu pořadí, Vennův diagram pod hlavním grafem, graf spojnic pod grafem
  pořadí a stejný počet směrodatných odchylek na obou osách (*K* = 2,7119);
- délku a šířku elipsy: zelenou a oranžovou úsečku, poloviční délky, poměr
  1,79 a koncové body na elipse 99 % proti `eigen(cor(x, y))` v R;
- předvolby Anscombe I a spánek (poznámka grafu spojnic s rozdílem
  průměrů −3,50);
- posuvník (přesné *r*, nezměněné X a SD Y, klávesnice), pole *r* s čárkou
  a odmítnutí 1,5, pole průměru a SD s odmítnutím záporné SD, nový výběr
  o 1 000 bodech (odmítnutí *n* = 2) s podíly uvnitř elips blízko modelu;
- chybějící formulář pro nový bod, řádek souřadnic ukazatele, přidání bodu
  kliknutím na (38; 31) (R: *r* −0,3164, $r_s$ −0,4431), zvýraznění
  a odstranění bodu kliknutím, smazání, přidání a posun klávesnicí,
  nejméně 3 body, tažení bodu myší s řádkem „Tažený bod“ a posuvník
  sledující nové *r*;
- rozšíření grafu na celé obrazovce a šířku 375 px bez přetékání se
  zapnutými přepínači.

## Statistické aplikace

U aplikace testu jednoho podílu kontrola webu ověřuje: odkazy z kapitol 6
a 9, sbalenou a otevřenou část v nabídce, tři grafy bez kódu a chyb OJS,
výsledky výpočtů proti R, výchozí stav (7 z 8, π₀ = 0,50, oboustranně)
bez oddílu Excelu, barvy záhlaví a řádků skupin tabulky výsledků, příklad
kapitoly 6 včetně textů tabulky a interpretace, volbu intervalu u jednostranné alternativy,
oboustrannou přesnou *p*-hodnotu podle pravidla R s poznámkou o zdvojení,
ovládání klávesnicí, popisky ze vstupů a escapování zadaného textu, odmítnutí
neplatných vstupů s ponecháním poslední platné hodnoty, předvolby, výřez
grafu při *n* = 100 000 a zobrazení na telefonu bez přetékání stránky.

U testu jednoho průměru kontrola webu ověřuje odkazy z kapitol 6–8, výchozí stav
(úzkost, μ₀ = 20, oboustranně) proti R, oboustranný test ekvivalence, párová data
s neúplnou dvojicí a prohozením měření, souhrny bez diagnostiky, přepínače histogramu
a Q–Q grafu, bodový graf do 50 hodnot a jitter nad 50, escapování popisků, odmítnutí
neplatných vstupů, ovládání předvoleb klávesnicí a zobrazení na telefonu.
