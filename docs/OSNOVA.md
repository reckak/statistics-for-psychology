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

## 4. Normální rozdělení a standardní skóry

**Stav:** hlavní zaměření dohodnuto 2026-10-10; název, podrobná osnova,
cíle, příklady, termíny a nové značky níže jsou **návrhem k projednání**.
Studentská kapitola dosud nevznikla a nebyla přidána do navigace knihy.

**Dohodnutý rozsah:** poloha výsledku a z-skór; normální rozdělení jako
model; podíly jako plochy pod křivkou; převody od hodnoty k podílu a zpět;
různé standardní skóry včetně stenů a staninů. Podrobný výklad
pravděpodobnosti a souvisejících pojmů je odložen do následující kapitoly.
**Doklad:** autorův výslovný souhlas s tímto zaměřením a žádost o podrobnou
osnovu po posouzení všech učebnic a nově dodané `normal_distribution.pptx`.

**Vstupní znalosti:** populace a výběr, spojitost, histogram, relativní
a kumulativní četnosti, procenta, průměr, směrodatná odchylka, kvantily,
percentilové pořadí a lineární transformace z kapitol 1–3. Nepovinný
výklad ploch nestejně širokých sloupců histogramu ani momentů se
nepředpokládá jako zvládnuté učivo; potřebný vztah plochy a podílu se
vysvětlí přímo v této kapitole.

### Navržené cíle a uspořádání

Student má po kapitole umět:

- vyjádřit a interpretovat polohu jednotlivého výsledku v jednotkách
  směrodatné odchylky vzhledem k určené skupině;
- vysvětlit, proč standardizace sama nevytvoří normální rozdělení;
- rozlišit pozorovaná data a předpokládaný normální model, popsat vliv
  jeho průměru a směrodatné odchylky;
- spojit vyznačenou plochu pod křivkou s modelovým podílem a rozlišit ji
  od výšky křivky;
- určit podíl pod hranicí, nad hranicí a mezi dvěma hranicemi a opačně
  najít hodnotu zadaného percentilu nebo meze prostředního podílu;
- převést a interpretovat běžné standardní skóry, steny a staniny;
- rozpoznat neodůvodněný převod na percentil, nevhodnou referenční skupinu
  a záměnu statistické neobvyklosti za klinickou závažnost.

Pro výuku navrhujeme dva obsahové bloky: nejprve poloha výsledku, model
a plochy; poté převody, standardní škály a interpretace. Nejde o odhad,
že celý rozsah lze pohodlně probrat během jedné vyučovací hodiny.
Excel bude součástí příslušných řešených příkladů, nikoli druhým výkladem
téže látky v samostatné rozsáhlé sekci.

### 4.1 Poloha výsledku a z-skór

1. Výsledek potřebuje srovnávací rámec. Proč 70 bodů nebo 70 % maxima
   neříká, jak si člověk stojí vůči ostatním. Volba referenční skupiny.
2. Připomenutí odchylky od průměru; vydělení směrodatnou odchylkou
   jako změna jednotky. Význam nuly, znaménka a velikosti z-skóru.
3. Výpočet z-skóru z dat pomocí již používaného výběrového průměru
   a směrodatné odchylky; zpětný převod na původní hodnotu.
   Při nulové směrodatné odchylce tento převod není definován.
4. Standardizovaný soubor má při konzistentním výpočtu průměr 0
   a směrodatnou odchylku 1; zachovává tvar a pořadí hodnot. Ukázat
   i zešikmená data před standardizací a po ní.
5. Porovnání relativní polohy ve dvou testech: vyšší z-skór vyjadřuje
   větší vzdálenost nad příslušným průměrem v jednotkách příslušné
   směrodatné odchylky. Bez znalosti tvaru rozdělení nemusí znamenat
   vyšší percentilové pořadí; neurčuje ani absolutní převahu schopnosti.

**Příklad:** vlastní jednoduché modelové výsledky dvou úloh; doplňkový
kontrastní soubor se zešikmeným rozdělením. Inspirací mohou být úlohy
X3_04–X3_07 a seminární příklad se Zbyňkem, s přesnější otázkou na
relativní polohu vůči normám místo závěru o „větším talentu“.

### 4.2 Normální rozdělení jako model

1. Návaznost na odlišení dat a modelu na konci kapitoly 3. Empirický
   histogram není totožný s hladkou modelovou křivkou.
2. Normální rozdělení jako rodina spojitých, symetrických, jednovrcholových
   modelů. Samotná symetrie ani zvonovitý vzhled nestačí k jeho určení.
3. Populační průměr určuje polohu, populační směrodatná odchylka šířku;
   vysvětlit nové řecké značky a odlišit je od výběrových charakteristik.
4. Průměr, medián a modus modelu se shodují. Měnit v obrázku vždy jeden
   parametr; rozdíly výšky křivky dovysvětlit pomocí stejné celkové plochy
   v následujícím oddílu.
5. Standardní normální rozdělení s průměrem 0 a směrodatnou odchylkou 1.
   Standardizace normálního modelu; souvislost s již vysvětleným z-skórem.
6. Normalita jako věcně posuzovaný předpoklad: omezené skóry, podlaha,
   strop, šikmost a směsi skupin. „Normální“ není hodnocení zdraví
   nebo žádoucnosti. Větší počet osob sám nezmění tvar rozdělení skórů.

Vzorec hustoty s exponenciálou ani důkaz normality nejsou součástí
navrženého povinného výkladu. Není třeba zavádět centrální limitní větu
jen jako zdůvodnění, proč je normální rozdělení užitečné.

### 4.3 Podíly jako plochy pod křivkou

1. Přechod od podílů v intervalech histogramu k ploše pod hladkou křivkou.
   Připomenout, jak je při vhodném měřítku podíl reprezentován plochou.
2. Celková plocha 1 neboli 100 %, polovina na každé straně průměru.
   Výška křivky je hustota, nikoli podíl osob s přesně danou hodnotou.
   Zavést význam hustoty slovně a graficky bez integrálů.
3. U spojitého modelu odpovídá jediné přesné hodnotě nulová plocha;
   zaznamenané nebo zaokrouhlené výsledky mohou být stejné. Podrobnější
   práce s intervalem zaokrouhlení může být nepovinným příkladem.
4. Přibližně 68 %, 95 % a 99,7 % výsledků leží do jedné, dvou a tří
   směrodatných odchylek od průměru. Přesnější podíl pro dvě odchylky
   je asi 95,45 %; prostředních 95 % vymezují přibližně ±1,96 odchylky.
5. Odlišit podíl pozorovaný v datech od podílu podle modelu. Krátce
   propojit modelový podíl s pravděpodobností výsledku náhodně vybrané
   osoby z příslušné populace; formální teorii ponechat další kapitole.

Povinnou dovedností je interpretace vyznačené oblasti a hrubý odhad.
Memorování celé převodní tabulky nebo výpočet integrálů se nepožaduje.

### 4.4 Od hodnoty k podílu

1. Opakovaný postup: formulovat otázku → nakreslit a vyznačit oblast →
   přibližně odhadnout → vypočítat → interpretovat a zkontrolovat.
2. Podíl pod hodnotou; modelová obdoba kumulativní relativní četnosti.
   Vysvětlit distribuční funkci významem „plocha vlevo od hranice“.
3. Podíl nad hodnotou jako doplněk do 1. Podíl mezi dvěma hodnotami
   jako rozdíl dvou kumulativních podílů; ukázat i hranice na téže straně
   průměru, aby se studenti nespoléhali pouze na symetrii.
4. Převod původní hodnoty na z-skór a použití
   `NORM.S.DIST(z;PRAVDA)`. Výsledek je podíl, procenta jsou způsob
   jeho vyjádření. Argument `NEPRAVDA` vrací hustotu, ne hledaný podíl.
5. Přímý převod pomocí `NORM.DIST(hodnota;průměr;směrodatná_odchylka;PRAVDA)`
   jako stručná alternativa po pochopení standardizace.
6. Modelové percentilové pořadí versus empirické pořadí známé
   z kapitoly 3. Podíl pod výsledkem není procento správných odpovědí.

**Příklad:** vlastní ilustrační normální model skóru pozornosti
s populačním průměrem 50 a směrodatnou odchylkou 10. Dotazy na podíl
pod 60, nad 60, mezi 40 a 60 a mezi 60 a 70. Parametry jsou pro úlohu
předpokládány, nikoli vydávány za skutečnou normu existujícího testu.

### 4.5 Od podílu zpět k hodnotě

1. Obrácená otázka: známe podíl vlevo a hledáme hranici. Návaznost
   na kvantil a percentil z kapitoly 3; odlišit hodnotu od její úrovně.
2. `NORM.S.INV(p)` a následný převod do původní škály; přímá alternativa
   `NORM.INV(p;průměr;směrodatná_odchylka)`. Podíl zadávat mezi 0 a 1;
   pro krajní podíly 0 a 1 neexistuje konečný kvantil normálního modelu.
3. Dolních 10 % a horních 10 %; u druhého zadání hledáme hranici
   s kumulativním podílem 0,90. Před výpočtem předpovědět znaménko z-skóru.
4. Meze prostředních 95 %: rozdělit zbylých 5 % do obou chvostů,
   pracovat s úrovněmi 0,025 a 0,975. Odlišit od jednostranné hranice
   95. percentilu, která má z-skór přibližně 1,645.
5. Znovu odlišit interval obsahující určitý podíl jednotlivých výsledků
   od intervalu spolehlivosti pro populační průměr. Druhý postup
   se zde nezavádí; stačí zabránit chybné záměně.

**Příklad:** pokračování téhož modelu pozornosti; mez pro horních 10 %
a prostředních 95 %. Numerické mezikroky nezaokrouhlovat předčasně.

### 4.6 Standardní skóry v psychologii

1. Proč měníme měřítko; zopakovat princip „nový střed + z-skór × nová
   směrodatná odchylka“. Výsledný skór vyjadřuje tutéž standardizovanou
   polohu, ale jeho číslo závisí na zvolené škále a referenční skupině.
2. Společná přehledová tabulka a jeden řešený převod: z-skór (0; 1),
   T-skór (50; 10), škála typu IQ (100; 15), vážený subtestový skór
   používaný například ve Wechslerových škálách (10; 3). Poslední název
   a rozsah jeho použití je nutné terminologicky dohodnout.
3. Steny: deset kategorií 1–10; staniny: devět kategorií 1–9.
   Vysvětlit hranice na z-škále, šířku vnitřních kategorií a otevřené
   krajní kategorie. Stenová škála má střed 5,5, staninová 5;
   konvenční směrodatná odchylka se uvádí přibližně 2.
4. Rozlišit spojitý mezivýpočet `5,5 + 2z` nebo `5 + 2z` od konečného
   přiřazení do kategorie. U staninů ukázat přibližné podíly
   4–7–12–17–20–17–12–7–4 %. Kategorie nemají stejnou četnost:
   steny nejsou decily. U obou škál dochází ke ztrátě podrobností.
5. Percentilové pořadí není lineární standardní škála. Stejný rozdíl
   z-skórů odpovídá uprostřed a na okraji normálního rozdělení jinému
   rozdílu percentilových pořadí; navázat na převody v předchozích oddílech.
6. Krátce odlišit lineární standardizaci od normalizace přes pořadí
   a od širší standardizace psychodiagnostické metody. Podrobnou tvorbu
   normalizovaných norem ponechat stranou; při práci se skutečným testem
   rozhodují jeho normy a manuál.
7. Změna škály na průměr 100 a směrodatnou odchylku 15 nevytvoří měření
   inteligence. Neobvyklý výsledek sám není diagnóza; stejné standardní
   číslo v odlišných normách neznamená stejný původní výkon.

Navrženým cílem u stenů a staninů je správně číst škálu a přiřadit skór
pomocí dodané tabulky. Zapamatování všech hranic se nepožaduje. Konkrétní
tabulku hranic včetně zacházení s přesnou mezí ověřit před psaním
a sladit s již schválenou intervalovou konvencí.

### 4.7 Shrnutí a samostatná cvičení

Navrhujeme osm až deset odstupňovaných úloh na konci kapitoly:
interpretace z-skóru a zpětný převod; změna referenční skupiny;
standardizace zešikmených dat; četnost versus modelová plocha;
podíly pod/nad/mezi hranicemi; modelový percentil a centrální interval;
převody standardních skórů; čtení stenů a staninů; oprava chybných
tvrzení o normalitě, percentilech a klinickém významu. Řešení mají
zdůvodnit postup i význam výsledku, nikoli jen uvést číslo.

### Rozšíření a hranice kapitoly

**Navržené nepovinné rozšíření:** krátké čtení normálního Q–Q grafu,
teprve po výkladu kvantilů; přibližná přímka a systematické odchylky,
bez konstrukce grafu v Excelu, bez výpočtu pořadových pozic a bez testů
normality. Druhým možným krátkým příkladem je zaokrouhlený skór jako
interval hodnot spojitého modelu. Není nutné zařadit obě rozšíření.

**Odloženo:** formální jevy, množinové operace, nezávislost, podmíněná
pravděpodobnost a Bayesova věta; systematický výklad náhodné veličiny
a rozdělení pravděpodobnosti; binomické rozdělení a jeho aproximace;
centrální limitní věta, výběrová rozdělení, standardní chyba, intervaly
spolehlivosti a testování hypotéz; Shapirův–Wilkův a další testy normality.
Tím není schváleno zařazení všech těchto témat do jedné další kapitoly.

### Návrh termínů, značek a funkcí k dohodě

| Návrh českého termínu | Anglický ekvivalent | Doporučení a rozsah |
|---|---|---|
| hrubý skór | raw score | Původní výsledek před převodem; připomenout vztah ke slovu hodnota. |
| referenční skupina; normativní soubor | reference group; normative sample | Rozlišit skupinu, ke které vztahujeme interpretaci, a data použitá při tvorbě norem. |
| z-skór; standardizace | z score; standardization | Standardizací zde rozumět konkrétní lineární převod; širší význam v psychodiagnostice výslovně odlišit. |
| normální rozdělení | normal distribution | Gaussovo rozdělení jako alternativa ve slovníčku. |
| standardní normální rozdělení | standard normal distribution | Alternativa normované normální rozdělení; preferovat první název kvůli návaznosti na standardizaci. |
| hustota pravděpodobnosti | probability density | Stručný grafický význam; nezaměnit za pravděpodobnost jediné hodnoty. |
| distribuční funkce | cumulative distribution function | Vysvětlit jako kumulativní plochu; „kumulativní distribuční funkce“ uvést jako běžnou alternativu. |
| chvost rozdělení | distribution tail | Význam nejprve ukázat na obrázku. |
| standardní skór; T-skór | standard score; T score | Standardní skór jako širší rodina škál; z-skór jako její konkrétní případ. |
| vážený subtestový skór | scaled subtest score | Název k dohodě; neprezentovat 10 a 3 jako parametry každé škály nazývané scaled score. |
| sten; stanin | sten; stanine | České tvary k dohodě, včetně případné alternativy stanina ve slovníčku. |
| normalizace rozdělení | normalization / rank-based normal-score transformation | Krátké odlišení od lineární standardizace; nepřidávat algoritmus tvorby norem. |
| normální Q–Q graf | normal Q–Q plot | Pouze pokud se schválí nepovinné rozšíření. |

Navržené nové symboly jsou kurzivní `z` (případně `z_i`) a stojaté
řecké μ a σ pro populační/modelový průměr a směrodatnou odchylku.
Zachovat dosavadní výběrové `m` a `s`. Navrhované vztahy:
`z_i = (x_i − m) / s` pro popis souboru,
`z = (x − μ) / σ` a `x = μ + σz` pro modelové převody.
T označuje druh skóru, nikoli výběrovou statistiku; jeho zápis dohodnout
s ostatními novými symboly. Pro obecný nový skór lze využít již zavedené
`y` namísto nového písmene.

Písmeno `p` již slouží jako úroveň kvantilu; zde má znamenat podíl
vlevo od hranice, nikoli p-hodnotu testu. Nové `X`, `Z`, `P(…)`, `Φ`
a `Φ⁻¹` není nutné zavádět do povinného výkladu. Případný stručný zápis
`N(μ, σ²)` odložit, pokud nepřinese užitek; zdroje se liší, zda druhým
parametrem zapisují rozptyl, nebo směrodatnou odchylku.

Navržené funkce jsou `NORM.S.DIST` a `NORM.S.INV` jako základ,
`NORM.DIST` a `NORM.INV` jako přímá alternativa. Jejich české i anglické
názvy jsou shodné; české oddělovače a logickou hodnotu `PRAVDA` vysvětlit
v příkladech. Schválené zaokrouhlování ani konvence empirických kvantilů
se tímto návrhem nemění.

**Zdroje:** hlavním východiskem je Howell (2013), *Statistical Methods
for Psychology*, 8. vydání, kapitola 3, zejména oddíly 3.1–3.4 a 3.6;
3.5 je podkladem pouze navrženého rozšíření. Posouzení všech deseti
učebnic, nového souboru a dalších podkladů včetně rozporů a omezení
je zaznamenáno v [autorské historii](../quarto/README.md#priprava-kapitoly-4).

## Další pokračování

**Dohodnutý směr:** podrobnější pravděpodobnost a související pojmy mají
následovat po kapitole o normálním rozdělení. Konkrétní rozsah, cíle,
příklady, termíny a značky následující kapitoly ještě nebyly dohodnuty.
Kontingenční tabulky a inferenční postupy zůstávají náměty na později;
jejich pořadí ani rozsah není tímto přehledem určen.
