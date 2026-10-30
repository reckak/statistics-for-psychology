<a id="mapa-kapitola-06"></a>

# 6. Výběrové rozdělení a testování hypotéz

[Mapa celé knihy](../OSNOVA.md) · [Rozcestník zdrojů](../ZDROJE.md)

**Podklad a stav:** existující [kapitola 6](../../quarto/kapitola_06.qmd#sec-kapitola-06), karta
sestavena podle výkladu, zadání a řešení 2026-10-12. Schválený plán z téhož
dne byl nahrazen touto mapou skutečného textu; dohodu dokládají
[R28](../rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6),
[R29](../rozhodnuti/kapitola-06.md#r29-znaceni-kapitoly-6),
[R30](../rozhodnuti/kapitola-06.md#r30-terminologie-kapitoly-6) a
[historie](../../quarto/README.md#dohoda-kapitola-06). Vznik textu, odchylky
od plánu a rozsah ověření eviduje
[záznam o vytvoření](../../quarto/README.md#vytvoreni-kapitoly-6).
Dne 2026-10-17 byly tři zmínky o „další kapitole“ (odhad směrodatné chyby,
rozmezí průměrů versus interval spolehlivosti, z-test) převedeny na křížové
odkazy do [kapitoly 7](07-interval-t-test-ekvivalence.md#mapa-kapitola-07);
jiný obsah kapitoly 6 se nezměnil.

**Vstup:** populace, výběr, výběrová variabilita, systematické zkreslení,
souvislost a příčina (kap. 1); statistika a parametr, m a s, simulace
opakovaných výběrů (kap. 3); normální model, z-skór, plochy, kvantily
a Q–Q graf (kap. 4); podmíněná pravděpodobnost a obrácení podmínky, náhodná
proměnná, rozdělení pravděpodobnosti, střední hodnota, binomické rozdělení,
normální aproximace a směrodatná odchylka podílu (kap. 5). Nepovinné části
kapitol 3 a 5 se nepředpokládají.

**Cíle:** vysvětlit kolísání výsledků výběrů a rozlišit populaci, jeden výběr
a výběrové rozdělení statistiky; sestavit výběrové rozdělení průměru z malého
příkladu a popsat výběrové rozdělení podílu a průměru; vysvětlit směrodatnou
chybu, odlišit ji od směrodatné odchylky, výběrové chyby a systematického
zkreslení a odhadnout ji z dat; odlišit zákon velkých čísel od centrální
limitní věty a uvést její podmínky; spočítat pravděpodobnost výběrového
průměru ve známém modelu; před výpočtem stanovit hypotézy a směr testu
a určit extrémnější výsledky; vysvětlit p-hodnotu a odlišit ji od hladiny
významnosti a kritického oboru; rozlišit chyby I. a II. druhu a určit, na čem
závisí statistická síla; provést binomický test a z-test; zformulovat
rozhodnutí testu i věcnou interpretaci, vyjádřit velikost účinku v původních
jednotkách a odlišit statistickou, věcnou a praktickou významnost.

**Čitelnost ([R38](../rozhodnuti/postupy-a-dokumentace.md#r38-citelnost-textu)):** 2026-10-15 doplněny úvodní věty hlavních oddílů, závěrečné [Shrnutí](../../quarto/kapitola_06.qmd#sec-shrnuti-06) (osm myšlenek s odkazy na oddíly), dva bloky „Častý omyl“ (`.callout-warning`: větší výběr „neznormální“ data v [mezích věty](../../quarto/kapitola_06.qmd#sec-clv-meze), nezamítnutí není důkazem, že rozdíl není, v [nezamítnutí](../../quarto/kapitola_06.qmd#sec-nezamitnuti)) a jedno „Připomenutí“ (`.callout-tip`: co zákon velkých čísel neslibuje, se zpětným odkazem do kapitoly 5); rozděleny vybrané věty nad zhruba 35 slov. Oddíl cvičení se jmenuje „Cvičení“ místo „Samostatná cvičení“ (ID beze změny). Odborný obsah, terminologie, data ani zadání a řešení cvičení se nezměnily. Soulad karty s textem zkontrolován 2026-10-15.

<a id="skutečný-obsah-oddílů-5"></a>

### Skutečný obsah oddílů

Všechny části jsou **vysvětleny**, pokud není uvedeno „nepovinné“; poslední
sloupec určuje konkrétní **procvičení**. Dvanáct hlavních oddílů odpovídá
pořadí schválenému v R28; řádky tabulky sledují jejich pododdíly.

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Rozdíl necelých sedmi sekund](../../quarto/kapitola_06.qmd#sec-parkovaci-studie) | Parkovací studie: dvě skupiny po 100 řidičích, 32,15 s a 39,03 s, rozdíl 6,88 s, směrodatná odchylka 14,6 s (čísla podle Howella, s. 86). Dvě vysvětlení rozdílu; výběrová variabilita z kapitoly 1; tři kroky kapitoly: výběrové rozdělení → směrodatná chyba → test. | Průběžně. |
| [Studie, výukový model a simulovaná data](../../quarto/kapitola_06.qmd#sec-tri-vrstvy) | Tři vrstvy příkladu s původem každého údaje. Zásada: každá vypočtená pravděpodobnost je výsledkem výukového modelu, ne reprodukcí původní analýzy. Co lze říci popisem, co vyžaduje zobecnění a co uspořádání studie. | Průběžně. |
| [Binomické rozdělení jako rozdělení statistiky](../../quarto/kapitola_06.qmd#sec-statistika-jako-promenna) | Test s 20 otázkami a π = 0,25 z kapitoly 5: odpovědi studenta jako výběr, počet správných jako statistika. Definice výběrového rozdělení statistiky; statistika jako náhodná proměnná, dokud výběr nemáme. | 1, 3a. |
| [Od počtu k podílu a první směrodatná chyba](../../quarto/kapitola_06.qmd#sec-chyba-podilu) | Výběrové rozdělení podílu: střední hodnota π, směrodatná chyba 0,097 (n = 20) a 0,048 (n = 80). Definice směrodatné chyby s alternativními názvy. Co je jedna hodnota na ose; „mezi výběry“ versus „uvnitř výběru“. Podíl 0,15–0,35 s pravděpodobností 0,807 a 0,973. Závislost na binomických předpokladech. | 3. |
| [Všech devět výběrů](../../quarto/kapitola_06.qmd#sec-devet-vyberu) | Modelová populace 20, 35 a 50 s (μ = 35 s, σ = 12,25 s); devět uspořádaných dvojic při výběru s vracením; rozdělení průměru s pravděpodobnostmi 1/9 až 3/9. Řetězec výběr → statistika → rozdělení statistiky. Střed 35 s, směrodatná chyba 8,66 s; proč průměry kolísají méně než jednotlivé hodnoty. | 2. |
| [Populace, jeden výběr a výběrové rozdělení](../../quarto/kapitola_06.qmd#sec-tri-urovne) | Srovnávací tabulka tří rozdělení: co popisuje, co je jedna hodnota, čísla z příkladu. Ve výzkumu máme jen jeden výběr; výběrové rozdělení přímo nepozorujeme. | 1a. |
| [Když výběry nelze vypsat: simulace](../../quarto/kapitola_06.qmd#sec-simulace-prumeru) | Výukový model (μ = 35 s, σ = 15 s, zešikmený doprava). Osm vypsaných průměrů výběrů po 30 řidičích; 10 000 opakování. Tři úrovně na společné ose; velikost výběru versus počet opakování. Histogramy pro n = 5, 30 a 100 (směrodatné odchylky průměrů 6,77; 2,74; 1,51 s). Konečná přesnost simulace. | 1b–c. |
| [Směrodatná chyba průměru](../../quarto/kapitola_06.qmd#sec-chyba-prumeru) | σ s indexem m = σ/√n s vysvětlením symbolů; ověření na devíti výběrech (přesně) a simulacích (přibližně). Proč odmocnina: čtyřnásobný výběr půlí chybu (3,0; 1,5; 0,75 s). Podmínky: náhodné nezávislé výběry; na tvaru populace nezáleží. Směrodatná odchylka 15 s versus směrodatná chyba 1,5 s na řidiči a na výběru s hodnotou 50 s. | 1b, 2e, 5. |
| [Zákon velkých čísel](../../quarto/kapitola_06.qmd#sec-zakon-velkych-cisel) | Do 3 s od populačního průměru leží 34 %, 73 % a 95 % průměrů (n = 5, 30, 100). Pojmenování zákona a vazba na relativní četnost z kapitoly 5. Neslibuje „vyrovnání“; velký zkreslený výběr se blíží nesprávné hodnotě. | 6a. |
| [Směrodatnou chybu obvykle odhadujeme](../../quarto/kapitola_06.qmd#sec-odhad-chyby) | s s indexem m = s/√n; 2,72 s pro zobrazený výběr; odhady 2,18–3,20 s u osmi výběrů; 1,25–1,77 s u výběrů po 100. Omezení: normální model platí se známou směrodatnou chybou, s odhadem jde o jiný postup (odkaz do [kapitoly 7](07-interval-t-test-ekvivalence.md#mapa-kapitola-07)). Odhad 1,46 s ze studie. | 4a–b. |
| [Pět pojmů, které se pletou](../../quarto/kapitola_06.qmd#sec-pet-pojmu) | Tabulka: směrodatná odchylka, výběrová variabilita, směrodatná chyba, výběrová chyba, systematické zkreslení — otázka, příklad, vliv většího výběru. Různá šíře termínu výběrová chyba v literatuře. | 4c–e. |
| [Malé skupiny mívají extrémnější průměry](../../quarto/kapitola_06.qmd#sec-male-skupiny) | Simulace 150 skupin (10–397 lidí) z jediné populace: 17 z 20 nejvzdálenějších průměrů patří skupinám do 50 lidí, kterých je 56 ze 150. Wainerův příklad malých škol na obou koncích žebříčku. Výskyt mezi nejlepšími sám vliv velikosti nedokládá. | 6c. |
| [Dvě změny, které probíhají současně](../../quarto/kapitola_06.qmd#sec-dve-zmeny) | Standardizace průměrů odděluje šířku od tvaru. Histogramy pro n = 2, 5, 30 a 100 v sekundách a po standardizaci; podíly za hranicemi ±2 (od 3,6 % a 0,5 % po 2,4 % a 2,2 %); normální Q–Q grafy. | 6a–b. |
| [Co centrální limitní věta říká](../../quarto/kapitola_06.qmd#sec-clv-zneni) | Slovní znění; normální model průměru se směrodatnou chybou místo směrodatné odchylky, pro sto řidičů se střední hodnotou 35 s a směrodatnou odchylkou 1,5 s. Proč má normální model místo v inferenci. Podmínky: nezávislost a táž populace, konečná variabilita, žádná univerzální hranice (číslo 30 jako orientační zkušenost; Howell, s. 179). Normální aproximace binomického rozdělení jako zvláštní případ. | 5b, 6a–b. |
| [Obě zákonitosti vedle sebe](../../quarto/kapitola_06.qmd#sec-zvc-a-clv) a [co věta netvrdí](../../quarto/kapitola_06.qmd#sec-clv-meze) | Srovnávací tabulka: otázka, odpověď, řada obrázku, účel. Větší výběr nemění rozdělení jednotlivých hodnot na normální. Výběrová rozdělení mediánu (směrodatná chyba 3,24 s) a směrodatné odchylky (2,37 s, zešikmené) jedním odstavcem a obrázkem. | 6a. |
| [Průměr sta řidičů](../../quarto/kapitola_06.qmd#sec-pravdepodobnost-prumeru) | Řešený výpočet v pěti krocích: průměr nad 38 s s pravděpodobností 0,0228 (simulace 2,4 %); pro jednotlivce 37 %. List `Chyba`; NORM.DIST se směrodatnou chybou. Prostředních 95 % průměrů 32,06–37,94 s; odlišení od rozmezí jednotlivců (12–70 s) a od intervalu spolehlivosti. | 5. |
| [Rozdíl dvou průměrů](../../quarto/kapitola_06.qmd#sec-rozdil-dvou-prumeru) | Rozdíl výběrových průměrů jako statistika. Simulace 10 000 dvojic výběrů po 100 z téže populace: průměr 0,02 s, směrodatná odchylka 2,12 s. Rozdíl větší než 3 s kterýmkoli směrem: 0,157 (simulace 16,0 %). Model „žádného rozdílu“ předpokládá víc než rovnost průměrů. | Bez samostatné úlohy; východisko oddílů o testu. |
| [Nepovinné: odkud se bere odmocnina](../../quarto/kapitola_06.qmd#rozsireni-odvozeni-chyby) | Rozptyl součtu nezávislých proměnných; průměr jako součet dělený n; ověření na součtech devíti výběrů. Směrodatná chyba rozdílu dvou průměrů, 2,1213 s. Kontrola mincí (Wainer, s. 250). | Bez cvičení. |
| [Výzkumná a statistická hypotéza](../../quarto/kapitola_06.qmd#sec-vyzkumna-statisticka) | Pojmenování testování hypotéz. Výzkumná hypotéza (směrově podle Howella, s. 89), statistická hypotéza, nulová a alternativní hypotéza pro rozdíl populačních průměrů. Proč se data porovnávají s nulovou hypotézou. Hypotézy se týkají populací; test se týká statistické hypotézy. | 7a–b. |
| [Směr testu a extrémnější výsledky](../../quarto/kapitola_06.qmd#sec-smer-testu) | Extrémnější výsledky určuje alternativa. Oboustranný a jednostranný test; smyšlený rozdíl 4 s při třech alternativách (0,059; 0,030; 0,970). Celá nulová hypotéza versus hraniční hodnota, značka μ s indexem 0. Směr se volí před sběrem dat; pro parkování oboustranný test. | 7, 9d. |
| [Jak neobvyklý je náš výsledek](../../quarto/kapitola_06.qmd#sec-p-hodnota-vypocet) | Testová statistika 6,88 s, z = 3,24. Definice p-hodnoty; oboustranně 2 × 0,0006 = 0,0012. P-hodnota se vypisuje slovy. List `Test_rozdilu`. | 9b, 11. |
| [Hladina významnosti a kritický obor](../../quarto/kapitola_06.qmd#sec-hladina-kriticky-obor) | Hladina významnosti jako předem zvolená hranice pro p-hodnotu; obě rozhodovací formulace; statisticky významný výsledek. Kritický obor (oblast zamítnutí) a kritická hodnota: ±1,96, tedy ±4,16 s. Obě cesty vedou ke stejnému rozhodnutí. Tabulka „stanoveno předem / vypočteno z dat“. | 8c, 9c, 11. |
| [Co ukáže simulace a kde jsou její meze](../../quarto/kapitola_06.qmd#sec-simulace-presnost) | 497 z 10 000 rozdílů v kritickém oboru (261 + 236) při platné nulové hypotéze. Jedenáct rozdílů alespoň 6,88 s (7 + 4) proti dvanácti očekávaným; malou pravděpodobnost simulace neurčí (i Howellova hodnota 0,0006 je šest případů). Ověření funkcí COUNTIFS na listu `Sim_rozdily`. | Bez samostatné úlohy. |
| [Rozhodnutí testu a věcná interpretace](../../quarto/kapitola_06.qmd#sec-zaver-parkovani) | Dva kroky závěru na parkovacím příkladu: rozhodnutí; směr, velikost, nejistota a uspořádání studie (pozorování bez náhodného přiřazení). P-hodnota není pravděpodobnost hypotézy; obrácení podmínky z kapitoly 5. | 8d, 9e, 11. |
| [Chyba I. a II. druhu](../../quarto/kapitola_06.qmd#sec-dve-chyby) | Tabulka 2 × 2; značky α a β; obdoba falešně pozitivního a negativního výsledku screeningu. Hladina je podmíněná pravděpodobnost, ne podíl chybných zamítnutí. | 10a. |
| [Statistická síla pro konkrétní alternativy](../../quarto/kapitola_06.qmd#sec-statisticka-sila) | β závisí na skutečné velikosti rozdílu. Stejné kritické hodnoty ±4,16 s při skutečném rozdílu 0, 3, 5 a 8 s: 0,05; 0,29; 0,65; 0,96. Pět okolností: velikost rozdílu, velikost výběru (400 řidičů: 0,81), rozptýlenost, hladina, směr (jednostranně 0,41). | 10b–c, 10e. |
| [Když nulovou hypotézu nezamítneme](../../quarto/kapitola_06.qmd#sec-nezamitnuti) | Smyšlená varianta 2,9 s (z = 1,37, p-hodnota 0,17): oba kroky a vzorová formulace. Co závěr neříká (Uttsová, s. 75–76). Váha nezamítnutí závisí na síle. | 8e, 10d, 11. |
| [Nepovinné: výpočet statistické síly](../../quarto/kapitola_06.qmd#rozsireni-vypocet-sily) | Síla jako plocha pod křivkou alternativy; 0,654 pro rozdíl 5 s; list `Sila`. Využití při plánování, bez výkladu plánování velikosti výběru. | 13. |
| [Tři různé významnosti](../../quarto/kapitola_06.qmd#sec-tri-vyznamnosti) | Statistická, věcná a praktická významnost; upozornění na záměnu termínů v literatuře; parkovací příklad ve všech třech smyslech. | 12b. |
| [Velikost účinku v původních jednotkách](../../quarto/kapitola_06.qmd#sec-velikost-ucinku-jednotky) | 6,88 s, přibližně pětina doby. Slovo „účinek“ neznamená příčinu. Studie A (n = 25, p-hodnota 0,62) a B (n = 2 500, pod 0,001) se stejným rozdílem 1 bodu. Skutečný příklad branců a šesti milimetrů (Uttsová). | 12a–b. |
| [Nepovinné: standardizovaný rozdíl průměrů](../../quarto/kapitola_06.qmd#rozsireni-standardizovany-rozdil) | d = 6,88/14,6 ≈ 0,47 (Howell, s. 102); která směrodatná odchylka je ve jmenovateli; rozdíl od testové statistiky z. Slovní pásma se neuvádějí. | Bez cvičení. |
| [Od rozhodnutí testu k odpovědi](../../quarto/kapitola_06.qmd#sec-zaver-testu) | Dva kroky obecně; statisticky významný rozdíl v opačném směru výzkumnou hypotézu nepodporuje. Tabulka přiměřených formulací a toho, čemu se vyhnout. Příčinný výklad závisí na uspořádání studie. | 11. |
| [Binomický test](../../quarto/kapitola_06.qmd#sec-binomicky-test) | Šest kroků pro 10 z 20: nulová hypotéza π ≤ 0,25, p-hodnota 0,014, kritický obor 9–20 se skutečnou chybovostí 0,041. Věcná interpretace včetně modelu s vyloučením dvou možností. List `Binom_test`; BINOM.INV s přičtením jedničky. | 8. |
| [Z-test](../../quarto/kapitola_06.qmd#sec-z-test) | Ilustrační norma N(50, 10), n = 25, m = 46: nulová hypotéza μ ≥ 50, z = −2, p-hodnota 0,023, kritická hodnota 46,71. Věcná interpretace. List `Z_test` se třemi směry. Z-skór ještě není test; známá σ je předpoklad a s výběrovou s jde o jiný test (odkaz do [kapitoly 7](07-interval-t-test-ekvivalence.md#mapa-kapitola-07)). | 9, 13. |
| [Co mají testy společného](../../quarto/kapitola_06.qmd#sec-kroky-testu) | Tabulka tří testů: hypotéza, směr, statistika, její rozdělení, p-hodnota, spojitost. | 8–9. |
| [Na jakou otázku test odpovídá](../../quarto/kapitola_06.qmd#sec-otazka-testu) | Hladina 0,05 je zvyklost (0,049 versus 0,051); p-hodnota platí pro celý model včetně ostatních předpokladů; přesná nulová hypotéza může platit, ale nemusí. | 11a (situace 5–6), 12b. |
| [Více testů najednou](../../quarto/kapitola_06.qmd#sec-vice-testu) | Dvacet testů při platnosti všech nulových hypotéz a nezávislosti testů: 0,64. Význam obou podmínek; zpráva má uvádět všechny testy. Korekce se nevykládají. | 12c. |
| [Rozhodnutí učiněná až podle dat](../../quarto/kapitola_06.qmd#sec-volby-po-datech) | Dodatečný výběr analýzy a zastavování sběru podle průběžné p-hodnoty; čtyři zásady poctivého zacházení s testy. | 7c, 9d, 12d. |
| [Nepovinné: test jako screening](../../quarto/kapitola_06.qmd#rozsireni-test-screening) | Obdoba senzitivita–síla, falešně pozitivní výsledek–α, prevalence–podíl skutečných rozdílů. Tisíc výzkumů: 45 ze 125 zamítnutí při platné nulové hypotéze (0,36); závislost na základní četnosti a síle. | 14. |
| [Nepovinné: dvě tradice testování](../../quarto/kapitola_06.qmd#rozsireni-dve-tradice) | Fisher; Neyman a Pearson; co z které tradice zůstalo v dnešní praxi. Návrh Jonese a Tukeyho jen zmínkou s jeho předpokladem. | Bez cvičení. |
| [Shrnutí](../../quarto/kapitola_06.qmd#sec-shrnuti-06) | Osm odkazovaných myšlenek: kolísání statistiky, výběrové rozdělení a jeho odlišení, směrodatná chyba a zákon velkých čísel, centrální limitní věta, hypotézy, p-hodnota, dvě chyby a nezamítnutí, dva kroky závěru. | Souhrnně 1–12. |

<a id="příklady-vizualizace-a-soubory-4"></a>

### Příklady, vizualizace a soubory

[Sešit kapitoly 6](../../data/kapitola_06.xlsx) má 26 listů: `Prehled`, pět
výpočtových listů (`Chyba`, `Test_rozdilu`, `Binom_test`, `Z_test`, `Sila`),
čtyři vstupní listy výkladu (`Parkovani`, `Tipovani`, `Devet_vyberu`,
`Pozornost`), čtyři listy simulovaných dat (`Sim_vyber` s 30 dobami
zobrazeného výběru, `Sim_prumery` s 10 000 průměry pro čtyři velikosti
výběru, `Sim_rozdily` s 10 000 rozdíly průměrů a `Skupiny` se 150 skupinami)
a dvanáct vstupních listů cvičení (`U02_body`, `U03_podil`, `U04_vybery`,
`U04_model`, `U05_IQ`, `U08_pokus`, `U09_pamet`, `U10_sila`, `U11_vysledky`,
`U12_studie`, `U13_sila`, `U14_screening`). Úlohy 1 a 7 jsou slovní; úloha 6
používá list `Skupiny`. [Pokrytí cvičení](../DATA.md).

Průběžný příklad má tři vrstvy. Čísla parkovací studie jsou převzata
z Howella (s. 86), který je uvádí podle Rubacka a Juienga (1997); průměr 35 s
a směrodatná odchylka 15 s výukového modelu jsou Howellovy zvolené hodnoty
(s. 87). Zešikmený tvar modelové populace, shoda rozdělení obou skupin
za platnosti nulové hypotézy a všechna simulovaná data jsou autorské.
Autorské a modelové jsou také populace tří dob, ilustrační norma pozornosti
N(50, 10) z kapitoly 4, simulace 150 skupin a všechna cvičení kromě dvou:
úloha 5 je upravena podle starší úlohy kurzu a úloha 8 používá čísla
z Howella (s. 129–130). S uvedením zdroje jsou převzaty příklad malých škol
a kontroly mincí (Wainer) a příklad branců (Uttsová).

| Obrázek | Didaktický účel |
|---|---|
| [Tři vrstvy](../../quarto/kapitola_06.qmd#fig-tri-vrstvy) | Co je studie, co model a co simulace. |
| [Podíl pro 20 a 80 otázek](../../quarto/kapitola_06.qmd#fig-podil-rozdeleni) | Výběrové rozdělení podílu; čtyřnásobný výběr půlí směrodatnou chybu. |
| [Devět výběrů](../../quarto/kapitola_06.qmd#fig-devet-vyberu) | Výběr → statistika → rozdělení statistiky na vypsatelném příkladu. |
| [Tři úrovně](../../quarto/kapitola_06.qmd#fig-tri-urovne) | Populace, jeden výběr a 10 000 průměrů na společné ose; co je jedna hodnota. |
| [Průměry pro tři velikosti výběru](../../quarto/kapitola_06.qmd#fig-prumery-simulace) | Střed zůstává, šířka klesá, tvar se mění. |
| [Směrodatná odchylka a směrodatná chyba](../../quarto/kapitola_06.qmd#fig-smerodatna-chyba) | Jednotlivci versus průměry; chyba podle velikosti výběru. |
| [Trychtýř 150 skupin](../../quarto/kapitola_06.qmd#fig-trychtyr) | Malé skupiny na obou koncích bez skutečného rozdílu. |
| [Šířka a tvar](../../quarto/kapitola_06.qmd#fig-zvc-clv), [Q–Q grafy](../../quarto/kapitola_06.qmd#fig-clv-qq) | Oddělení zákona velkých čísel od centrální limitní věty. |
| [Jiné statistiky](../../quarto/kapitola_06.qmd#fig-jine-statistiky) | Medián a směrodatná odchylka mají vlastní výběrová rozdělení. |
| [Plocha průměru a rozdíl průměrů](../../quarto/kapitola_06.qmd#fig-plocha-prumeru) | Řešený výpočet; shoda simulace s normálním modelem. |
| [Extrémnější výsledky](../../quarto/kapitola_06.qmd#fig-extremnejsi) | Jak směr alternativy mění počítanou plochu. |
| [P-hodnota a kritický obor](../../quarto/kapitola_06.qmd#fig-p-hodnota) | Výsledek z dat a pravidlo stanovené předem na jedné křivce. |
| [Síla při čtyřech skutečných rozdílech](../../quarto/kapitola_06.qmd#fig-sila) | Kritické hodnoty zůstávají, posouvá se křivka. |
| [Stejný rozdíl při dvou velikostech výběru](../../quarto/kapitola_06.qmd#fig-stejny-rozdil) | Velikost účinku versus statistická významnost. |
| [Dva testy](../../quarto/kapitola_06.qmd#fig-dva-testy) | Diskrétní a spojitá testová statistika se stejnou logikou. |

<a id="cvičení-a-očekávané-dovednosti-5"></a>

### Cvičení a očekávané dovednosti

[Čtrnáct úloh](../../quarto/kapitola_06.qmd#sec-cviceni-06) má úplná sbalená řešení. Nadpisy úloh
nemají explicitní ID; lokátorem je oddíl cvičení, číslo a název. Úlohy 1, 2,
4, 7, 8, 10 a 11 vyžadují kalkulačku, úlohy 3, 5, 6, 9 a 12 Excel;
pravděpodobnosti na tři desetinná místa, tolerance 0,001. U každého testu
se zvlášť uvádí rozhodnutí testu a věcná interpretace. Úlohy 13 a 14 jsou
nepovinné.

| Úloha | Co student samostatně dělá |
|---|---|
| 1. Tři rozdělení a dvě velikosti | Určí, které ze tří rozdělení popis vystihuje a co je jedna hodnota na ose; pojmenuje směrodatnou odchylku a směrodatnou chybu; odliší velikost výběru od počtu opakování a popíše důsledek změny každého z nich. |
| 2. Všechny výběry z malé populace | Pro hodnoty 1, 2 a 6 vypíše devět výběrů, sestaví rozdělení průměru, ověří střed a σ/√2 a vysvětlí nesouměrnost rozdělení. |
| 3. Výběrové rozdělení podílu | Určí možné hodnoty podílu, směrodatnou chybu pro n = 25 a 100 a pravděpodobnost podílu alespoň 0,52 (0,154 a 0,010); posoudí, čí úvaha má lepší oporu. |
| 4. Pět pojmů na jednom příkladu | Ze dvou výběrů devíti dob spočítá průměr, s a odhad směrodatné chyby; porovná je se skutečnou hodnotou; určí výběrovou chybu; rozliší kolísání mezi lidmi a mezi výběry; posoudí systematické zkreslení. |
| 5. Pravděpodobnost průměru a jednotlivce | IQ-skóry N(100, 15): jednotlivec nad 105 (0,369) proti průměru devíti lidí (0,159); rozmezí 95 % průměrů a jednotlivců; vliv výběru 36 lidí; odliší rozmezí od intervalu spolehlivosti. |
| 6. Co říká který zákon a co říkají malé školy | Přiřadí čtyři výroky zákonu velkých čísel, centrální limitní větě nebo žádnému; posoudí použitelnost normálního modelu ve třech situacích; na listu `Skupiny` ověří, že malé skupiny obsazují oba konce. |
| 7. Od otázky k hypotézám | Pro tři výzkumné otázky zapíše hypotézy, směr, hraniční hodnotu a extrémnější výsledky; opraví hypotézu zapsanou o výběru; posoudí změnu směru po zhlédnutí dat. |
| 8. Binomický test ručně | 7 z 8 (čísla podle Howella): hypotézy, p-hodnota 9/256, kritický obor a skutečná chybovost 0,035, oba kroky závěru; varianta 6 z 8 s nezamítnutím. |
| 9. Z-test v Excelu a volba směru | n = 36, m = 104,5 proti normě N(100, 15): oboustranná p-hodnota 0,072, kritické hodnoty, nezamítnutí; proč nelze dodatečně přejít na jednostranný test; věcná interpretace a předpoklad známé σ. |
| 10. Dvě chyby a síla | Popíše obě chyby ve scénáři školního programu; čte zadanou tabulku síly pro dvě velikosti výběru a dva rozdíly; posoudí závěr „program nefunguje“; navrhne, jak sílu zvýšit a co to stojí. |
| 11. Rozhodnutí testu a věcná interpretace | K šesti výsledkům napíše oba kroky závěru, včetně statisticky významného rozdílu v opačném směru, jednostranného testu se stejnými daty a dvojice 0,049 a 0,051; opraví dva chybné výroky o p-hodnotě. |
| 12. Tři významnosti a mnoho testů | Zopakuje příklad stejného rozdílu při n = 25 a 2 500 a posoudí tři významnosti; uvede podmínky výpočtu 0,642 pro dvacet testů; vysvětlí, proč průběžné zastavování nedodržuje hladinu. |
| 13. Nepovinně: výpočet statistické síly | Pro z-test z výkladu určí kritickou hodnotu a sílu pro populační průměr 45 a 47 bodů (0,804 a 0,442) a pro výběr 100 studentů (0,912). |
| 14. Nepovinně: test jako screening | Sestaví přirozené četnosti pro 1 000 výzkumů (20 % skutečných rozdílů, síla 0,60), určí podíl chybných zamítnutí (0,25), vliv síly 0,90 a vysvětlí soulad s hladinou 0,05. |

<a id="pojmy-konvence-a-hranice-návaznosti-2"></a>

### Pojmy, konvence a hranice návaznosti

Nově je vysvětleno 29 pojmů [registru](../SLOVNIK.md#kapitola-06). Značení
podle R29: σ s indexem m a s s indexem m, μ₁, μ₂, m₁, m₂, H₀, H₁, μ₀,
testová statistika z, stojaté α a β; p-hodnota se vypisuje slovy; d jen
v nepovinné části. Zápis N(μ, σ) podle R15 se používá jen s celočíselnými
parametry; modely s desetinnou směrodatnou chybou jsou popsány slovy, aby
nevznikl nový oddělovač. Nové funkce Excelu kapitola nezavádí: používá
ODMOCNINA, ABS, KDYŽ, COUNTIFS, NORM.DIST, NORM.INV, NORM.S.DIST,
NORM.S.INV, BINOM.DIST a BINOM.INV z kapitol 2–5.

**Nepovinné:** odvození směrodatné chyby včetně chyby rozdílu dvou průměrů,
výpočet statistické síly, standardizovaný rozdíl průměrů, test jako screening
a dvě tradice testování. Další kapitola je nesmí předpokládat.

**Vysvětleno omezeně:** odhad směrodatné chyby bez postupu, který s jeho
nejistotou počítá; test rozdílu dvou průměrů jen ve výukovém modelu se známou
směrodatnou odchylkou, ne jako obecný postup pro dva výběry; výběrová
rozdělení mediánu a směrodatné odchylky jedním příkladem; více testů bez
korekcí; velikost účinku v původních jednotkách. **Pouze zmíněno:** interval
spolehlivosti (jen odlišen od rozmezí výběrových průměrů), „jiný test“
při neznámé směrodatné odchylce, plánování velikosti výběru, opakování
výzkumu, návrh Jonese a Tukeyho. **Nevyloženo:** intervaly spolehlivosti,
t-rozdělení a t-testy, bootstrap, znaménkový test, funkce Z.TEST, korekce
pro více testů, chí-kvadrát, korelace, bayesovské testování, výpočet potřebné
velikosti výběru a reportování výsledků testů podle APA.

**Odchylky od schváleného plánu:** statistická síla pro skutečný rozdíl 8 s
je 0,96; plán uváděl 0,97 chybným zaokrouhlením hodnoty 0,965. Úloha 11 má
šest situací a dva výroky k opravě; plán mluvil o osmi výsledcích. Ostatní
obsah, pořadí a rozšíření odpovídají R28.

Hlavní oporou pořadí a pojetí jsou Howell (kap. 4, §5.9 a §7.1–7.2)
a autorova přednáška `sampling_distribution.pptx`; rozsah čtení, zjištěné
rozpory a neověřené části jsou v kartách [mapy zdrojů](../ZDROJE.md).


## Vazby na podklady

Výběr karet pro dohledání podkladů k tématům této kapitoly vychází z tematického rozcestníku a existujících záznamů použití. Samotný odkaz neznamená převzetí příkladu ani nové prostudování; přesné lokátory, použití, nálezy a rozsah ověření jsou v cílových kartách.

- [U01](../zdroje/U01-howell.md#u01) — kap. 4, §5.9 a §7.1–7.2.
- [U03](../zdroje/U03-cumming.md#u03) — kap. 4–5.
- [U04](../zdroje/U04-openintro.md#u04) — s. 171.
- [U05](../zdroje/U05-dostal.md#u05) — §5.2.
- [U08](../zdroje/U08-navarro.md#u08) — kap. 10 a §11.1.
- [U11](../zdroje/U11-russo.md#u11) — §7.2–7.5.
- [P06](../zdroje/P06-vyberove-rozdeleni.md#p06) — výběrové rozdělení a testování.
- [P07](../zdroje/P07-usuzovani-intervaly.md#p07) — statistické usuzování.
- [C05](../zdroje/C05-ulohy-tyden-4.md#c05) — X5 a X6.
- [D07](../zdroje/D07-utts.md#d07) — statistická gramotnost.
- [D11](../zdroje/D11-wainer.md#d11) — velikost výběru.
- [Kontrola při přípravě](../zdroje/HISTORIE.md#kontrola-podkladů-při-přípravě-kapitoly-6--2026-10-12) a [použití při tvorbě](../zdroje/HISTORIE.md#pouziti-kapitola-06) — společné záznamy včetně tří externích citovaných zdrojů bez vlastní karty.

**Typografická úprava 2026-10-30:** všechny tabulky kapitoly včetně zadání
a řešení mají automatické označení a název. Zachována existující ID,
vysvětlující části dlouhých popisků jsou v poznámkách pod tabulkami.
Kontrola souladu se zde popsaným obsahem byla omezena na tabulky a jejich
okolí; cíle, návaznosti, hodnoty, zadání a řešení se nemění. Společnou sazbu
určuje [R54](../rozhodnuti/spolecne-konvence.md#r54-sazba-tabulek-pdf).
