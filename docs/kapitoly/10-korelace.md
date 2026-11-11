<a id="mapa-kapitola-10"></a>

# 10. Korelace: souvislost dvou proměnných, její velikost a nejistota

[Mapa celé knihy](../OSNOVA.md) · [Rozcestník zdrojů](../ZDROJE.md)

**Podklad a stav:** existující [kapitola 10](../../quarto/kapitola_10.qmd#sec-kapitola-10), karta
sestavena podle výkladu, zadání a řešení 2026-11-11. Dohodu dokládají
[R71](../rozhodnuti/kapitola-10.md#r71-rozsah-kapitoly-10) (včetně
[upřesnění počtu opakování](../rozhodnuti/kapitola-10.md#r71-upresneni-2026-11-09)),
[R72](../rozhodnuti/kapitola-10.md#r72-znaceni-kapitoly-10) a
[R73](../rozhodnuti/kapitola-10.md#r73-terminologie-kapitoly-10) s
[historií dohody](../../quarto/README.md#dohoda-kapitola-10). Vznik textu
a rozsah ověření eviduje [záznam o vytvoření](../../quarto/README.md#vytvoreni-kapitoly-10).
Soulad karty s textem zkontrolován 2026-11-11. Autorská odborná revize zatím neproběhla;
otevřené jsou terminologické návrhy K10-N1 až K10-N4 ([registr](../SLOVNIK.md#navrhy)).

**Vstup:** souvislost a příčina, role proměnných, ordinální úroveň, reliabilita a validita
(kap. 1); tečkový graf a odlehlé pozorování (kap. 2); průměr, rozptyl, směrodatná odchylka,
změna škály, percentily a PERCENTIL.INC (kap. 3); *z*-skóry a NORM.S.INV (kap. 4);
nezávislost a permutace jako uspořádání (kap. 5); výběrové rozdělení, test, *p*-hodnota,
dva kroky závěru a mnoho testů (kap. 6); interval spolehlivosti, *t*-rozdělení, T.DIST.2T
(kap. 7); párová data a klasický *t*-test (kap. 8); koeficient φ a tabulka stresu (kap. 9).

**Cíle:** podle „Co budete po prostudování umět“: bodový graf a slovní popis souvislosti;
kovariance a Pearsonovo *r* ručně i v Excelu; pořadí, Spearmanův koeficient, Kendallovo
τ<sub>a</sub> a τ<sub>b</sub>; volba koeficientu; test a Fisherův interval pro *r*; permutační
test a percentilový bootstrapový interval pro pořadové koeficienty včetně testované hypotézy;
vlivy na korelaci; zpráva ve dvou krocích.

**Čitelnost ([R38](../rozhodnuti/postupy-a-dokumentace.md#r38-citelnost-textu)):** každý hlavní
oddíl začíná otázkou a návazností; Shrnutí má osm odkazovaných myšlenek. Povinný souvislý
text má asi 7 500 slov (bez tabulek, cvičení a nepovinných rozšíření). Strojová kontrola
délky vět našla po rozdělení úvodní věty jen artefakty spojených odrážek a citací.
Oddíl o Kendallově τ zavádí čtyři pojmy ve třech pododdílech (konkordantní a diskordantní
dvojice, τ<sub>a</sub>, τ<sub>b</sub>).

<a id="skutecny-obsah-10"></a>

### Skutečný obsah oddílů

Všechny části jsou **vysvětleny**, pokud není uvedeno „nepovinné“; poslední sloupec
určuje konkrétní **procvičení**. Třináct hlavních oddílů odpovídá členění v R71.

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Jakou otázku zodpovídá korelace](../../quarto/kapitola_10.qmd#sec-otazka-korelace) | Úzkost a výkon 40 studentů; směr a síla; symetrie; korelační studie (Aron s. 512); spánková data kap. 8: relativní postavení (*r* = 0,95) vs. průměrná změna 3,5 bodu; SD rozdílů 2,39 vs. 9,75 při *r* = 0; 2, 4, 6 a 6, 12, 18. | 2. |
| [Nepovinné: rozptyl rozdílů](../../quarto/kapitola_10.qmd#rozsireni-rozptyl-rozdilu) | $s_D^2=s_1^2+s_2^2-2rs_1s_2$ na datech kap. 8; list `Parova_korelace`. | Bez cvičení. |
| [Bodový graf](../../quarto/kapitola_10.qmd#sec-bodovy-graf) | Bod je člověk; lineární, monotónní a nelineární vztah; šest tvarů s *r* a *r*<sub>s</sub>; čtyři soubory se stejným *r* = 0,60; graf s velikostí bodu u pořadových dat. | 1, 16a. |
| [Kovariance](../../quarto/kapitola_10.qmd#sec-kovariance) | Šest studentů (tab. 10.1), kvadranty a součiny odchylek (Cumming s. 317–319); $s_{xy}=-27{,}6$; vztah k rozptylu; závislost na jednotkách (−92 v procentech). | 3, 4. |
| [Pearsonovo *r*](../../quarto/kapitola_10.qmd#sec-pearsonovo-r) | $r=s_{xy}/(s_xs_y)=-0{,}788$ a součet součinů *z*-skórů; ρ; vlastnosti (znaménko, ±1, posun, obrácení škály, bez variability); „Častý omyl“ *r* = 0; CORREL, COVARIANCE.S (tab. 10.2); velikost v kontextu bez slovních pásem: Cohen, kvartily podle Cumminga (s. 336–337), reliabilita a validita (částečné rozšíření R55). | 3, 4, 15. |
| [Spearmanův koeficient](../../quarto/kapitola_10.qmd#sec-spearman) | Stres a kvalita spánku 30 studentů; průměrná pořadí (tab. 10.3, Howell s. 314); $r_s=-0{,}851$ (6) a −0,48 (30); RANK.AVG; co převod zachová; trénink a reakční doba (*r* −0,85, *r*<sub>s</sub> −0,91); „Častý omyl“ o volbě podle normality. | 1, 5, 6. |
| [Kendallovo τ](../../quarto/kapitola_10.qmd#sec-kendall) | 15 dvojic šesti studentů (2 konkordantní, 13 diskordantních); τ<sub>a</sub> = −0,733 jako rozdíl pravděpodobností; hranice vůči neshodným dvojicím; dvojice nejsou pozorování; shody a τ<sub>b</sub> = −0,741 (tab. 10.4); 30 studentů τ<sub>b</sub> = −0,38; srovnání tří koeficientů. | 7, 8. |
| [Zobecnění](../../quarto/kapitola_10.qmd#sec-zobecneni) | Spočítat, popsat, zobecnit; nezávislé případy, cílová populace, data celé populace; dvourozměrné normální rozdělení, homo- a heteroskedasticita (Wilcox s. 223–224). | 8c. |
| [Test a interval pro *r*](../../quarto/kapitola_10.qmd#sec-test-interval-r) | Simulace 10 000 výběrů po 20 (ρ 0 a 0,8); *t* = −3,79, *p* 0,0005; Fisherova transformace a interval (−0,72; −0,25) (tab. 10.5); *n* = 400 a *r* = 0,15; nula jako nevhodná reference (reliabilita 0,82, Chan podle Cumminga). | 9, 10. |
| [Permutační test](../../quarto/kapitola_10.qmd#sec-permutacni-test) | Přeskupení; přesný test 6 studentů (48/720 = 0,067); 1 999 přeskupení pro 30 (*p* 0,005 a 0,007; tab. 10.6); hypotéza nezávislosti (Wilcox s. 224, 275). | 11, 12. |
| [Bootstrap](../../quarto/kapitola_10.qmd#sec-bootstrap) | Výběr celých dvojic s vracením (Howell s. 659–664); percentilový interval (−0,73; −0,13) a (−0,61; −0,10); 1 999 vs. 9 999 (tab. 10.7); omezení a vlastní simulace pokrytí (94–96 % pro 30, 96–97 % a široké pro 10; Wilcox s. 227–228); „Častý omyl“ interval vs. test. | 13, 14. |
| [Nepovinné: interval BCa](../../quarto/kapitola_10.qmd#rozsireni-bca) | $z_0=0{,}050$, $a=-0{,}005$, percentily 3,0 a 97,9; (−0,60; −0,09) a (−0,72; −0,11); list `BCa`. | 17. |
| [Co mění korelaci](../../quarto/kapitola_10.qmd#sec-co-meni-korelaci) | Odlehlé pozorování (překlep 300: *r* 0,01, *r*<sub>s</sub> −0,49) a analýza citlivosti; omezení rozsahu 0,56 → 0,37 a krajní skupiny 0,72; sloučené třídy 0,66 vs. −0,20 a 0,09; chyba měření slovně; hodnotitelé *r* 0,97 bez shody. | 1d, 15, 16. |
| [Volba a sdělení](../../quarto/kapitola_10.qmd#sec-volba-sdeleni-10) | Rozhodovací tabulka (tab. 10.8); tři zprávy; korelační matice s počty dvojic (tab. 10.9); mnoho testů; kauzalita a náhodné přiřazení (Aron). | 2c, 15, 16c. |
| [Dichotomická proměnná](../../quarto/kapitola_10.qmd#sec-dichotomicka) | *r*<sub>pb</sub> = −0,35 a *t* = 2,34 (data kap. 8); φ = 0,105 jako *r* kódů; tentýž výpočet, jiný výklad. | Bez samostatného cvičení. |
| [Nepovinné: *d* a *r*<sub>pb</sub>](../../quarto/kapitola_10.qmd#rozsireni-d-r) | Převod se členem *h* ($d=0{,}80$, $h=4{,}67$); nesprávnost $r=d/2$. | Bez cvičení. |
| [Shrnutí](../../quarto/kapitola_10.qmd#sec-shrnuti-10) | Osm odkazovaných myšlenek. | Souhrnně 1–16. |

<a id="priklady-soubory-10"></a>

### Příklady, vizualizace a soubory

[Sešit kapitoly 10](../../data/kapitola_10.xlsx) má 35 listů a asi 4,8 MB: `Prehled`,
14 vstupních listů, 12 výpočtových listů a 8 pomocných listů převzorkování
(`Perm_indexy`, `Perm_Y`, `Perm_poradi_Y`, `Boot_indexy`, `Boot_X`, `Boot_Y`,
`Boot_poradi_X`, `Boot_poradi_Y`). Vzorce s TRANSPOZICE uvnitř SOUČIN.SKALÁRNÍ jsou
vzorce dynamického pole a vyžadují Excel pro Microsoft 365 nebo Excel 2021 a novější;
text kapitoly to uvádí. [Pokrytí cvičení](../DATA.md#kapitola-10).

Všechna data jsou autorské modely (`scripts/kapitola_10.R`, pevné seedy). Převzaté
souhrny s uvedením zdroje: reliabilita a validita podle Cumminga (Chan, 2007), korelace
žen a mužů ve cvičení 18 (Cumming, s. 338–339), čísla z Howella a Cumminga v textu
o omezení rozsahu a odlehlém bodu. Data kapitoly 8 a tabulka kapitoly 9 se přebírají.

| Obrázek | Didaktický účel |
|---|---|
| [Úzkost a výkon](../../quarto/kapitola_10.qmd#fig-uzkost-vykon) | Široký záporný mrak s průměry. |
| [Tvary souvislosti](../../quarto/kapitola_10.qmd#fig-tvary) | Šest tvarů s *r* a *r*<sub>s</sub>. |
| [Stejné *r*](../../quarto/kapitola_10.qmd#fig-stejne-r) | Čtyři soubory s *r* = 0,60. |
| [Kvadranty](../../quarto/kapitola_10.qmd#fig-kvadranty) | Znaménka a velikost součinů odchylek. |
| [Stres a spánek](../../quarto/kapitola_10.qmd#fig-stres-spanek) | Pořadová data, velikost bodu podle počtu. |
| [Pořadí](../../quarto/kapitola_10.qmd#fig-poradi) | Převod na pořadí odstraní zakřivení. |
| [Dvourozměrné rozdělení](../../quarto/kapitola_10.qmd#fig-dvourozmerne) | Elipsa vs. heteroskedasticita. |
| [Výběrové *r*](../../quarto/kapitola_10.qmd#fig-vyberove-r) | Kolísání a šikmost *r*. |
| [Permutace](../../quarto/kapitola_10.qmd#fig-permutace) | Rozdělení τ<sub>b</sub> za nezávislosti. |
| [Bootstrap](../../quarto/kapitola_10.qmd#fig-bootstrap) | Bootstrapové rozdělení a percentilové meze. |
| [Faktory](../../quarto/kapitola_10.qmd#fig-faktory) | Omezení rozsahu, krajní skupiny, sloučení skupin. |
| [Shoda hodnot](../../quarto/kapitola_10.qmd#fig-shoda-hodnot) | Vysoké *r* bez shody hodnot. |

Interaktivní vizualizace ke kapitole 10 nejsou (R71).

<a id="cviceni-10"></a>

### Cvičení a očekávané dovednosti

[Osmnáct úloh](../../quarto/kapitola_10.qmd#sec-cviceni-10) má úplná sbalená řešení;
17 a 18 jsou nepovinné. Kalkulačka: 3, 4, 7, 8, 9, 10, 11, 18; Excel: 3, 5, 6, 9, 12, 13, 16, 17;
slovní: 1, 2, 4, 14, 15.

| Úloha | Co student samostatně dělá |
|---|---|
| 1. Graf a koeficient | Rozliší monotónní, obrácené U, pořadová data a odlehlý bod; zvolí koeficient nebo popis. |
| 2. Co korelace říká | Postavení vs. změna; vysoké *r* při poklesu všech; kauzální titulek a alternativní vysvětlení. |
| 3. Kovariance a *r* ručně | 5 dvojic: −4,25 a −0,922; list `Kovariance`. |
| 4. Jednotky a škála | Minuty, obrácení, posun, nulová variabilita. |
| 5. Hodnotitelky esejí | *r*<sub>s</sub> = 0,821 z pořadí. |
| 6. Spearman se shodami | Průměrná pořadí, *r*<sub>s</sub> 0,798 vs. *r* 0,705. |
| 7. τ<sub>a</sub> ručně | 8 a 2 dvojice, 0,6 a výklad pravděpodobností. |
| 8. τ<sub>b</sub> se shodami | −0,600 a −0,692; lidé vs. dvojice. |
| 9. Test a interval | *t* 2,57, *p* 0,013, (0,07; 0,53); dva kroky. |
| 10. Velikost výběru a nula | *r* 0,15 u 50 a 1 000; reliabilita (0,62; 0,88). |
| 11. Permutace pro 4 lidi | *p* 2/24 jako nejmenší možná, 8/24; hypotéza. |
| 12. Permutace v Excelu | `U12`: *p* 0,0205 a 0,0155. |
| 13. Bootstrap v Excelu | `U12`: (−0,71; −0,10) a (−0,59; −0,08); pevné výsledky 9 999 platí jen pro výchozí data. |
| 14. Proč celé dvojice | Rozbití souvislosti; permutace vs. bootstrap; *n* = 10. |
| 15. Kde je chyba | Omezení rozsahu, výběr koeficientu podle *p*, reliabilita, kauzální závěr. |
| 16. Úplná analýza | Odlehlý údaj 900 minut, analýza citlivosti (0,04 vs. 0,47), zpráva. |
| 17. Nepovinně: BCa | 1 039 z 1 999, $z_0$ 0,050, percentily 3,0 a 97,9. |
| 18. Nepovinně: dvě korelace | *z* −0,77, *p* 0,44 (Cumming). |

<a id="pojmy-hranice-10"></a>

### Pojmy, konvence a hranice návaznosti

Nově vysvětleno 19 hesel [registru](../SLOVNIK.md#kapitola-10). Značení podle R72:
$s_{xy}$, *r* a ρ, $r_s$ a ρ<sub>s</sub>, τ<sub>a</sub> a τ<sub>b</sub> (výběrově, populační hodnota
slovy), $n_c$, $n_d$, $t_x$, $t_y$, $n_0$, $z_r$, $r_{pb}$, *B*. Nové funkce Excelu: CORREL,
COVARIANCE.S, RANK.AVG, SIGN, SOUČIN.SKALÁRNÍ, TRANSPOZICE, FISHER, FISHERINV.
Otevřené terminologické návrhy K10-N1 až K10-N4: omezení rozsahu, korelační matice,
analýza citlivosti, interval BCa.

**Nepovinné:** rozptyl rozdílů přes *r*, interval BCa, převod *d* na *r*<sub>pb</sub>,
porovnání dvou nezávislých korelací (jen cvičení 18). Další kapitola je nesmí předpokládat.

**Vysvětleno omezeně:** chyba měření a oslabení korelace jen slovně; korelační matice
a mnoho testů jen krátce; bodově biseriální korelace a φ bez samostatného cvičení;
*r*² jen jako mimo kapitolu. **Nevyloženo:** regrese, *r*², parciální korelace, latentní
korelace, korekce na chybu měření, závislé korelace, síla a plánování *n*, Kendallovo W,
intervaly pro *r*<sub>s</sub> a τ ze vzorců směrodatných chyb, test ekvivalence pro *r*.

## Vazby na podklady

Výběr karet pro dohledání podkladů k tématům této kapitoly vychází z tematického rozcestníku a záznamů čtení a použití. Samotný odkaz neznamená převzetí příkladu ani nové prostudování; přesné lokátory, použití, nálezy a neověřené části jsou v kartách.

- [U01](../zdroje/U01-howell.md#priprava-10-20261109) — kap. 9 (s. 251–293), kap. 10 (s. 304–317), §18.1–18.3 (s. 657–665).
- [U03](../zdroje/U03-cumming.md#priprava-10-20261109) — kap. 11 (s. 311–339).
- [U02](../zdroje/U02-aron.md#priprava-10-20261109) — kap. 11 (s. 512, 522).
- [U15](../zdroje/U15-wilcox.md#priprava-10-20261109) — §5.9, §5.11, §6.5–6.6, §6.9, §7.7.
- [P10](../zdroje/P10-korelace-stps.md#priprava-10-20261109), [P11](../zdroje/P11-korelace-psyb1170.md#priprava-10-20261109), [C06](../zdroje/C06-ulohy-tyden-5.md#c06) — priority a náměty.
- [Čtení pro návrh](../zdroje/HISTORIE.md#priprava-10-20261109) a [použití při tvorbě](../zdroje/HISTORIE.md#pouziti-kapitola-10).
