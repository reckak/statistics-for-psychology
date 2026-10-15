<a id="mapa-kapitola-04"></a>

# 4. Normální rozdělení a standardní skóry

[Mapa celé knihy](../OSNOVA.md) · [Rozcestník zdrojů](../ZDROJE.md)

**Podklad a stav:** existující [kapitola 4](../../quarto/kapitola_04.qmd#sec-kapitola-04),
karta zkontrolována 2026-10-11. Původní schválený plán byl nahrazen mapou
skutečného textu; dohody z 2026-10-10 a úpravy z 2026-10-11 zůstávají doloženy
v [historii přípravy](../../quarto/README.md#priprava-kapitoly-4) a rozhodnutích
[R07](../rozhodnuti/kapitola-04.md#r07-normovane-normalni), [R08](../rozhodnuti/kapitola-04.md#r08-terminologie-kapitoly-4),
[R09](../rozhodnuti/kapitola-04.md#r09-kapitola-4-model-qq) a [R15](../rozhodnuti/kapitola-04.md#r15-zapis-normalniho-modelu).

**Vstup:** populace/výběr, význam a meze měření, spojitost, histogram,
relativní a kumulativní četnosti, průměr, SD, kvantily, percentilové pořadí
a lineární transformace. Nepředpokládají se nepovinné nestejné šířky
histogramu ani momentové koeficienty. **Cíle:** vypočítat/interpretovat
z-skór; odlišit standardizaci od normality; číst zápis normálního modelu;
převádět hodnoty a modelové podíly oběma směry; používat standardní skóry,
steny/staniny; sestavit a interpretovat Q–Q graf a společně s kontextem
a histogramem posoudit přiměřenost modelu.

**Čitelnost ([R38](../rozhodnuti/postupy-a-dokumentace.md#r38-citelnost-textu)):** 2026-10-15 doplněny úvodní věty hlavních oddílů, závěrečné [Shrnutí](../../quarto/kapitola_04.qmd#sec-shrnuti-04) (sedm myšlenek s odkazy na oddíly), blok „Častý omyl“ (`.callout-warning`) o konvenci zápisu N(μ, σ²) v [parametrech](../../quarto/kapitola_04.qmd#sec-parametry-normalniho); rozděleny vybrané věty nad zhruba 35 slov. Oddíl cvičení se jmenuje „Cvičení“ místo „Samostatná cvičení“ (ID beze změny). Odborný obsah, terminologie, data ani zadání a řešení cvičení se nezměnily. Soulad karty s textem zkontrolován 2026-10-15.

<a id="skutečný-obsah-oddílů-3"></a>

### Skutečný obsah oddílů

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Poloha a z-skór](../../quarto/kapitola_04.qmd#sec-z-skor), [referenční skupina](../../quarto/kapitola_04.qmd#sec-referencni-skupina) | Hrubý skór, skupina a normativní soubor; odečtení průměru a dělení SD, znaménko, nula, jednotky a zpětný převod. Kladné s a nejméně dvě hodnoty; dva testy s různými měřítky, vyšší z není automaticky lepší výkon či více schopnosti. | 1. |
| [Standardizace](../../quarto/kapitola_04.qmd#sec-standardizace) | Vlastní m/s vytvoří průměr 0 a výběrovou SD 1, zachová tvar, shody a pořadí; jiné normy tuto vlastnost souboru nezaručí. Pět časů z kapitoly 3 před/po převodu. Širší standardizace testu odlišena. | 2; 1 požaduje vysvětlit nedostatek pro percentilové pořadí. |
| [Normální model](../../quarto/kapitola_04.qmd#sec-normalni-model) a [parametry](../../quarto/kapitola_04.qmd#sec-parametry-normalniho) | Spojitá symetrická jednovrcholová rodina, shoda středů a neomezené chvosty versus histogram a omezený skór. Parametry μ/σ (značky zavedeny v kapitole 3, zde připomenuty) versus výběrové m/s; N(μ, σ) a alternativní konvence s rozptylem. Samostatná změna polohy a šířky křivky. | 3 a 10. |
| [Normované normální rozdělení](../../quarto/kapitola_04.qmd#sec-normovane-normalni) | N(0, 1), modelový převod z = (x − μ)/σ a souvislost s datovým z-skórem. Normalita zde vychází z modelu, ne ze samotného přepočtu. | 3–5. |
| [Hustota a plocha](../../quarto/kapitola_04.qmd#sec-hustota) | Od plochy obdélníku s výškou podíl/šířka ke křivce; výška hustoty není podíl, změna jednotek zachová odpovídající plochu. Modelový podíl propojen s pravděpodobností výsledku náhodně vybraného člověka. | 3–4; bez obecné teorie pravděpodobnosti. |
| [Bod a zaokrouhlený interval](../../quarto/kapitola_04.qmd#sec-bod-a-interval) | Jediná přesná hodnota má v tomto spojitém modelu nulovou plochu; zaznamenaná 50 může znamenat 49,5–50,5. Odlišení původně diskrétního počtu; méně/nejvýše se v modelu shoduje, v datech nemusí. | 6; jde o základní učivo, nikoli nepovinné okénko. |
| [Pravidlo 68–95–99,7](../../quarto/kapitola_04.qmd#sec-pravidlo-normalni) | Intervaly ±1/2/3 SD a chvosty, přibližné podíly versus prostředních 95 % při ±1,96. Pravidlo nelze přenést na libovolná data jen ze znalosti m/s. | 3 a orientační část 7. |
| [Distribuční funkce](../../quarto/kapitola_04.qmd#sec-distribucni-funkce) | Kumulace plochy zleva a protějšek empirické kumulativní četnosti; na dvou grafech stejný podíl jako plocha hustoty versus výška distribuční funkce. | 4. |
| [Hodnota → podíl a Excel](../../quarto/kapitola_04.qmd#sec-excel-normalni) v [celém oddílu](../../quarto/kapitola_04.qmd#sec-hodnota-podil) | NORM.S.DIST s PRAVDA po standardizaci a přímá NORM.DIST. Podíl nad hranicí jako doplněk, mezi dvěma hranicemi jako rozdíl levých ploch; oblast, odhad a kontrola znaménka. NEPRAVDA vrací hustotu; modelové pořadí není procento správných úloh. | 4. |
| [Podíl → hodnota](../../quarto/kapitola_04.qmd#sec-podil-hodnota), [modelový percentil](../../quarto/kapitola_04.qmd#sec-normalni-kvantil) | NORM.S.INV pro podíl vlevo a návrat x = μ + σz; NORM.INV jako přímá varianta. Rozsah p bez 0/1, kladná SD, kontrola opačným převodem; PERCENTIL.INC potřebuje data a řeší jinou otázku. | 5. |
| [Prostřední podíl versus horní chvost](../../quarto/kapitola_04.qmd#sec-centralni-podil) | Rozdělení zbytku do dvou chvostů při prostředních 95 % versus jediná hranice horních 5 %. Interval jednotlivých výsledků není interval spolehlivosti parametru ani diagnostický práh. | 5. |
| [Lineární standardní škály](../../quarto/kapitola_04.qmd#sec-prepocty-skoru) | z, T, IQ 100/15 a subtest 10/3; obecný převod i obrácení. Vážený skór jako alternativní označení, nikoli vážený součet. Převod sám nepotřebuje normalitu a nemění konstrukt. Graf přidává percentilová pořadí až pod podmínkou normálního modelu. | 7. |
| [Steny a staniny](../../quarto/kapitola_04.qmd#sec-steny-staniny) | Deset/devět pásem, pomocný lineární převod versus kategorie, tabulky z-mezí a modelových podílů. Horní mez zahrnutá, krajní pásma neomezená, nestejné četnosti a ztráta jemnosti; u reálných testů rozhoduje manuál. | 8; tabulky jsou k dispozici, meze se nememorují. |
| [Normalizace a pořadí](../../quarto/kapitola_04.qmd#sec-normalizace) | Princip přiřazení normálního kvantilu podle pořadí, vliv shod a konečného souboru; mění se rozestupy. Odlišení od standardizace a nepřímé povahy důkazu o původních skórech. Percentilové pořadí není lineární škála. | Nelineárnost pořadí v 7; algoritmus normalizace ani tvorba norem se neprocvičují. |
| [Přiměřenost modelu](../../quarto/kapitola_04.qmd#sec-primerenost-modelu) | Otázka, skupina, proměnná, meze škály, chyby a možné směsi. Histogram při různých intervalech, body/boxplot; křivka na histogramu s hustotní osou. Dobrá shoda středu nestačí pro odhad chvostu. | 10. |
| [Princip Q–Q](../../quarto/kapitola_04.qmd#sec-qq-graf) | Teoretický normální kvantil na X, seřazený skór na Y; nikoli dvojice měření dvou vlastností. Přímka m + sz plyne ze změny měřítka, nemusí mít úhel 45°. Náhodné odchylky a slabá informace z malého souboru. | 9–10. |
| [Tvorba Q–Q v Excelu](../../quarto/kapitola_04.qmd#sec-excel-qq) | Dvanáct seřazených skórů; středy pořadových dílků p = (i − 0,5)/n, NORM.S.INV a přímka. Teoretický kvantil není standardizovaný pozorovaný skór; postup není PERCENTIL.INC ani percentilové pořadí. Bodový XY graf se dvěma řadami a přesně určenými osami. | 9; povinná dovednost. |
| [Čtení odchylek](../../quarto/kapitola_04.qmd#sec-qq-odchylky) a závěr oddílu o přiměřenosti | Čtyři dvojice histogram/Q–Q pro 200 simulovaných hodnot: normální tvar, rozdělení zešikmené doprava, těžší chvosty a směs. Uveden i opačný směr u kratších chvostů. Graf neověřuje reprezentativnost, měření ani nezávislost; větší n nenormalizuje hodnoty. | 10 výslovně těžší chvosty i rozdělení zešikmené doprava; směs je řešenou ilustrací. |
| [Shrnutí](../../quarto/kapitola_04.qmd#sec-shrnuti-04) | Sedm odkazovaných myšlenek: z-skór a standardizace, normální model jako předpoklad, plocha, oba převody v Excelu, standardní skóry a pásma, přiměřenost modelu; neobvyklost není sama klinická závažnost. | Souhrnně 1–10. |

<a id="příklady-vizualizace-a-soubory-2"></a>

### Příklady, vizualizace a soubory

[Sešit kapitoly 4](../../data/kapitola_04.xlsx) doprovází výpočty; text přesně
popisuje list `Model` (parametry, plochy a inverzní převody) a `QQ`
(A2:E13 a souhrn H2:H4). Samostatné vstupy Q–Q jsou na `QQ_data`
A2:A13, další listy pokrývají příklady, cvičení 1–9 a čtyři soubory
simulovaných skórů z obrázků. Cvičení 10 je slovním zadáním; individuální
skóry zadány nejsou. První list `Prehled` uvádí oblasti a návaznosti.
Studentům se poskytuje pouze XLSX. [Pokrytí cvičení](../DATA.md).

Průběžný model skóru pozornosti **N(50, 10)** je ilustrační, není normou
skutečného testu. Ukazuje podíl do/nad 60, mezi 60 a 70, 90. percentil,
prostředních 95 % a horních 5 %. Pět časů z kapitoly 3 propojuje standardizaci
s lineární transformací. Dvanáct skórů 35 až 65 má sloužit konstrukci Q–Q,
nikoli spolehlivému odhadu velmi vzdálených chvostů populace.

[Z-skór jako krok SD](../../quarto/kapitola_04.qmd#fig-z-jako-jednotka),
[standardizace](../../quarto/kapitola_04.qmd#fig-standardizace-04),
[parametry](../../quarto/kapitola_04.qmd#fig-parametry-04),
[hustota](../../quarto/kapitola_04.qmd#fig-hustota-04) a
[distribuční funkce](../../quarto/kapitola_04.qmd#fig-distribucni-04)
podporují postup od relativní polohy k modelové ploše.
[Oblasti](../../quarto/kapitola_04.qmd#fig-oblasti-04) a
[kvantily](../../quarto/kapitola_04.qmd#fig-kvantily-04) odlišují typy zadání;
[škály](../../quarto/kapitola_04.qmd#fig-skaly-04) a
[pásma](../../quarto/kapitola_04.qmd#fig-pasma-skoru) rozlišují lineární převod,
modelové pořadí a kategorizaci. [Konstrukce jednoho bodu](../../quarto/kapitola_04.qmd#fig-qq-konstrukce)
předchází [hotovému Q–Q](../../quarto/kapitola_04.qmd#fig-qq-priklad-04).
Čtyři simulované diagnostické dvojice v oddílu o odchylkách mají každá
200 hodnot a ukazují různé možnosti shody či nesouladu se stejným typem modelu.

<a id="cvičení-a-očekávané-dovednosti-3"></a>

### Cvičení a očekávané dovednosti

[Deset úloh](../../quarto/kapitola_04.qmd#sec-cviceni-04) má úplná sbalená řešení.
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
jsou ve [slovníčku](../../quarto/slovnicek.qmd), schválení v R07–R09.

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
**Odloženo:** výběrová rozdělení, centrální limitní věta, směrodatná chyba,
intervaly spolehlivosti a testování. Tato zmínka sama neschvaluje žádné
z těchto témat pro další kapitolu; rozsah kapitoly 6 určilo až
[R28](../rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6).

Hlavní odbornou a didaktickou oporou původní přípravy je Howell, kapitola 3;
podrobnosti pasáží a srovnání podkladů patří do [karty U01](../zdroje/U01-howell.md#u01)
a historie přípravy, nikoli do druhé mapy zdrojů.


## Vazby na podklady

Výběr karet pro dohledání podkladů k tématům této kapitoly vychází z tematického rozcestníku a existujících záznamů použití. Samotný odkaz neznamená převzetí příkladu ani nové prostudování; přesné lokátory, použití, nálezy a rozsah ověření jsou v cílových kartách.

- [U01](../zdroje/U01-howell.md#u01) — kap. 3 a §2.12.
- [U02](../zdroje/U02-aron.md#u02) — kap. 3.
- [U03](../zdroje/U03-cumming.md#u03) — kap. 4.
- [U04](../zdroje/U04-openintro.md#u04) — §4.1.
- [U11](../zdroje/U11-russo.md#u11) — §6.2–6.4.
- [P03](../zdroje/P03-transformace-rozdeleni.md#p03) — sn. 3–21 a 45–59.
- [P04](../zdroje/P04-normalni-rozdeleni.md#p04) — normální rozdělení.
- [C03](../zdroje/C03-ulohy-tyden-3.md#c03) — X3_01–07 a X3_21–37.
- [C04](../zdroje/C04-seminar-4.md#c04) — standardní skóry.
- [D10](../zdroje/D10-excel-normalni-rozdeleni.md#d10) — Excel.
