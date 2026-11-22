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
Soulad karty s textem zkontrolován 2026-11-11 a po revizi podle [R84](../rozhodnuti/kapitola-10.md#r84-revize-kapitoly-10) znovu 2026-11-20; oddíl o vizualizaci a dva bloky „Vyzkoušejte si“ zkontrolovány 2026-11-23. Terminologické návrhy K10-N1 až K10-N4
autor schválil 2026-11-11 ([doplnění R73](../rozhodnuti/kapitola-10.md#r73-schvaleni-navrhu-2026-11-11)). Revize 2026-11-20 vychází z autorových připomínek ke konkrétním místům textu; průběh a kontroly eviduje [záznam o revizi](../../quarto/README.md#revize-kapitoly-10).

**Vstup:** souvislost a příčina, role proměnných, ordinální úroveň, reliabilita a validita
(kap. 1); tečkový graf a odlehlé pozorování (kap. 2); průměr, rozptyl, směrodatná odchylka,
změna škály, percentily a PERCENTIL.INC (kap. 3); *z*-skóry a NORM.S.INV (kap. 4);
nezávislost a permutace jako uspořádání (kap. 5); výběrové rozdělení, test, *p*-hodnota,
dva kroky závěru a mnoho testů (kap. 6); interval spolehlivosti, *t*-rozdělení, T.DIST.2T
(kap. 7); párová data a klasický *t*-test (kap. 8); koeficient φ a tabulka stresu (kap. 9).

**Cíle:** podle „Co budete po prostudování umět“: bodový graf a slovní popis souvislosti;
kovariance a Pearsonovo *r* ručně i v Excelu; pořadí, Spearmanův korelační koeficient, Kendallovo
τ<sub>a</sub> a τ<sub>b</sub>; volba koeficientu; test a Fisherův interval pro *r*; permutační
test a percentilový bootstrapový interval pro pořadové koeficienty včetně testované hypotézy;
vlivy na korelaci; zpráva ve dvou krocích.

**Čitelnost ([R38](../rozhodnuti/postupy-a-dokumentace.md#r38-citelnost-textu)):** každý hlavní
oddíl začíná otázkou a návazností; Shrnutí má osm odkazovaných myšlenek. Povinný souvislý
text má po revizi 2026-11-20 asi 9 000 slov (dříve asi 7 500) (bez tabulek, cvičení a nepovinných rozšíření). Strojová kontrola
délky vět našla po rozdělení úvodní věty jen artefakty spojených odrážek a citací.
Oddíl o Kendallově τ zavádí čtyři pojmy ve třech pododdílech (konkordantní a diskordantní
dvojice, τ<sub>a</sub>, τ<sub>b</sub>).

<a id="skutecny-obsah-10"></a>

### Skutečný obsah oddílů

Všechny části jsou **vysvětleny**, pokud není uvedeno „nepovinné“; poslední sloupec
určuje konkrétní **procvičení**. Třináct hlavních oddílů odpovídá členění v R71.

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Jakou otázku zodpovídá korelace](../../quarto/kapitola_10.qmd#sec-otazka-korelace) | Úzkost a výkon 40 studentů; směr a síla; dva významy „směru“ (znaménko vs. směr působení); symetrie; korelační studie, též observační (Aron s. 512); spánková data kap. 8: relativní postavení (*r* = 0,95) vs. průměrná změna 3,5 bodu; SD rozdílů 2,39 vs. 9,75 při *r* = 0; 2, 4, 6 a 6, 12, 18. | 2. |
| [Připomenutí: variabilita rozdílů](../../quarto/kapitola_10.qmd#rozsireni-rozptyl-rozdilu) | Od 2026-11-14 jen připomenutí ($s_D^2=s_1^2+s_2^2-2rs_1s_2$, r = 0,948, $s_D$ = 2,39) s odkazem na [nepovinné rozšíření kapitoly 8](../../quarto/kapitola_08.qmd#rozsireni-rozptyl-rozdilu-08), kam bylo rozšíření přesunuto podle [R77](../rozhodnuti/kapitola-08.md#r77-revize-kapitoly-8); ID zachováno; list `Parova_korelace` beze změny. Soulad řádku s textem zkontrolován 2026-11-14. | Bez cvičení. |
| [Bodový graf](../../quarto/kapitola_10.qmd#sec-bodovy-graf) | Bod je člověk; osa podle teoretické role proměnných; lineární, monotónní a nelineární vztah; šest tvarů s *r* a *r*<sub>s</sub>; Anscombův kvartet (*r* = 0,82, převzatá data, [E07](../zdroje/E07-anscombe-1973.md#e07-anscombe-1973)); graf s velikostí bodu u pořadových dat. | 1, 16a. |
| [Kovariance](../../quarto/kapitola_10.qmd#sec-kovariance) | Šest studentů (tab. 10.1), kvadranty a součiny odchylek (Cumming s. 317–319); $s_{xy}=-27{,}6$; vztah k rozptylu; závislost na jednotkách (−92 v procentech). | 3, 4. |
| [Pearsonovo *r*](../../quarto/kapitola_10.qmd#sec-pearsonovo-r) | $r=s_{xy}/(s_xs_y)=-0{,}788$ a součet součinů *z*-skórů; ρ; vlastnosti (znaménko, ±1, posun, obrácení škály, bez variability); „Častý omyl“ *r* = 0; CORREL, COVARIANCE.S (tab. 10.2); velikost v kontextu bez slovních pásem: Cohen, kvartily podle Cumminga (s. 336–337), reliabilita a validita (částečné rozšíření R55). Nepovinné rozšíření `#rozsireni-meze-r`: důkaz −1 ≤ *r* ≤ 1 přes součet druhých mocnin rozdílů *z*-skórů. | 3, 4, 15. |
| [Spearmanův korelační koeficient](../../quarto/kapitola_10.qmd#sec-spearman) | Stres a kvalita spánku 30 studentů; průměrná pořadí (tab. 10.3, Howell s. 314); $r_s=-0{,}851$ (6) a −0,48 (30); RANK.AVG; co převod zachová; trénink a reakční doba (*r* −0,85, *r*<sub>s</sub> −0,91); „Častý omyl“ o volbě podle normality. | 1, 5, 6. |
| [Kendallovo τ](../../quarto/kapitola_10.qmd#sec-kendall) | 15 dvojic šesti studentů (2 konkordantní, 13 diskordantních); τ<sub>a</sub> = −0,733 jako rozdíl pravděpodobností; hranice vůči neshodným dvojicím; dvojice nejsou pozorování; shody a τ<sub>b</sub> = −0,741 (tab. 10.4); 30 studentů τ<sub>b</sub> = −0,38; srovnání tří koeficientů (věcné vysvětlení místo přirovnání km/míle). | 7, 8. |
| [Zobecnění](../../quarto/kapitola_10.qmd#sec-zobecneni) | Spočítat, popsat, zobecnit; nezávislé případy, cílová populace, data celé populace; dvourozměrné normální rozdělení, homo- a heteroskedasticita i jiného tvaru než vějíř (Wilcox s. 223–224). | 8c. |
| [Test a interval pro *r*](../../quarto/kapitola_10.qmd#sec-test-interval-r) | Simulace 10 000 výběrů po 20 (ρ 0 a 0,8); *t* = −3,79, *p* 0,0005; společná příčina (příprava na test); Fisherova transformace s přirozeným logaritmem (ln, zmínka $\log_e$), obrázek převodu a rozdělení před a po něm, interval (−0,72; −0,25) (tab. 10.5); *n* = 400 a *r* = 0,15; nula jako nevhodná reference (reliabilita 0,82, Chan podle Cumminga). | 9, 10. |
| [Permutační test](../../quarto/kapitola_10.qmd#sec-permutacni-test) | Přeskupení; tabulka pozorovaného přiřazení a tří přeskupení (`tbl-k10-preskupeni`); přesný test 6 studentů (48/720 = 0,067) s obrázkem přesného permutačního rozdělení; tabulka přeskupení má číslo 10.6; 1 999 přeskupení pro 30 (*p* 0,005 a 0,007; tab. 10.7); hypotéza nezávislosti vs. nulová korelace, výklad zamítnutí a nezamítnutí (Wilcox s. 224, 275). | 11, 12. |
| [Bootstrap](../../quarto/kapitola_10.qmd#sec-bootstrap) | Převzorkování (*resampling*); výběr jako zástupce populace, proč s vracením; výběr celých dvojic (Howell s. 659–664), přepočet pořadí jen u pořadových koeficientů; percentilový interval (−0,73; −0,13) a (−0,61; −0,10); 1 999 vs. 9 999 (tab. 10.8); omezení a vlastní simulace pokrytí (94–96 % pro 30, 96–97 % a široké pro 10; Wilcox s. 227–228); „Častý omyl“ interval vs. test. | 13, 14. |
| [Nepovinné: interval BCa](../../quarto/kapitola_10.qmd#rozsireni-bca) | Od 2026-11-20 podrobněji: co percentilový interval předpokládá, význam $z_0$ (podíl 0,520) a zrychlení *a* z hodnot bez jednoho člověka (vzorec se značkami $\mathrm{τ}_{b(i)}$, $m_{\mathrm{τ}}$, $u_i$), jak opravy posunou meze; $z_0=0{,}050$, $a=-0{,}005$, percentily 3,0 a 97,9; (−0,60; −0,09) a (−0,72; −0,11); list `BCa`. Bez zdroje v podkladech, ověřeno proti balíčku `boot`. | 17. |
| [Co mění korelaci](../../quarto/kapitola_10.qmd#sec-co-meni-korelaci) | Odlehlé pozorování (překlep 300: *r* 0,01, *r*<sub>s</sub> −0,49), tři druhy odlehlého bodu opisem (*r* 0,67 → 0,76 / 0,50 / −0,03), cílem je porozumět vlivu, ne odstranit; analýza citlivosti; omezení rozsahu 0,56 → 0,37 a krajní skupiny 0,72; sloučené třídy 0,66 vs. −0,20 a 0,09; chyba měření: pravý skór, atenuace (Aron s. 514–515), simulace 0,62 → 0,35; hodnotitelé *r* 0,97, relativní vs. absolutní shoda. | 1d, 15, 16. |
| [Volba a sdělení](../../quarto/kapitola_10.qmd#sec-volba-sdeleni-10) | Rozhodovací tabulka (tab. 10.9); tři zprávy; korelační matice s hvězdičkami, 95% Fisherovými intervaly a počty dvojic (tab. 10.10); mnoho testů a meze hvězdiček; kauzalita a náhodné přiřazení (Aron). | 2c, 15, 16c. |
| [Dichotomická proměnná](../../quarto/kapitola_10.qmd#sec-dichotomicka) | *r*<sub>pb</sub> = −0,35 a *t* = 2,34 (data kap. 8); φ = 0,105 jako *r* kódů; tentýž výpočet, jiný výklad. | Bez samostatného cvičení. |
| [Nepovinné: *d* a *r*<sub>pb</sub>](../../quarto/kapitola_10.qmd#rozsireni-d-r) | Převod se členem *h* ($d=0{,}80$, $h=4{,}67$); obrázek pro rozdělení 21/21, 30/12 a 38/4 ($h$ 3,81, 4,67, 11,05); nesprávnost $r=d/2$. | Bez cvičení. |
| [Nepovinné: korekce na atenuaci](../../quarto/kapitola_10.qmd#rozsireni-korekce-reliabilita) | Od 2026-11-20 ([R84](../rozhodnuti/kapitola-10.md#r84-revize-kapitoly-10), částečně nahrazuje R71): původ oslabení, $r_{\mathrm{opr}}=r_{xy}/\sqrt{r_{xx}r_{yy}}$ (Muchinsky s. 64, 66; [D15](../zdroje/D15-muchinsky.md#d15)), příklad 0,35/0,6 = 0,58, omezení včetně hodnoty 1,03 (s. 67–73). | Bez cvičení. |
| [Shrnutí](../../quarto/kapitola_10.qmd#sec-shrnuti-10) | Osm odkazovaných myšlenek. | Souhrnně 1–16. |

<a id="priklady-soubory-10"></a>

### Příklady, vizualizace a soubory

[Sešit kapitoly 10](../../data/kapitola_10.xlsx) má 35 listů a asi 4,8 MB: `Prehled`,
14 vstupních listů, 12 výpočtových listů a 8 pomocných listů převzorkování
(`Perm_indexy`, `Perm_Y`, `Perm_poradi_Y`, `Boot_indexy`, `Boot_X`, `Boot_Y`,
`Boot_poradi_X`, `Boot_poradi_Y`). Vzorce s TRANSPOZICE uvnitř SOUČIN.SKALÁRNÍ jsou
vzorce dynamického pole a vyžadují Excel pro Microsoft 365 nebo Excel 2021 a novější;
text kapitoly to uvádí. [Pokrytí cvičení](../DATA.md#kapitola-10).

Všechna data kromě Anscombova kvartetu (`datasets::anscombe`, Anscombe 1973) jsou autorské modely (`scripts/kapitola_10.R`, pevné seedy). Převzaté
souhrny s uvedením zdroje: reliabilita a validita podle Cumminga (Chan, 2007), korelace
žen a mužů ve cvičení 18 (Cumming, s. 338–339), čísla z Howella a Cumminga v textu
o omezení rozsahu a odlehlém bodu. Data kapitoly 8 a tabulka kapitoly 9 se přebírají.

| Obrázek | Didaktický účel |
|---|---|
| [Úzkost a výkon](../../quarto/kapitola_10.qmd#fig-uzkost-vykon) | Široce rozptýlená záporná souvislost s průměry. |
| [Tvary souvislosti](../../quarto/kapitola_10.qmd#fig-tvary) | Šest tvarů s *r* a *r*<sub>s</sub>. |
| [Stejné *r*](../../quarto/kapitola_10.qmd#fig-stejne-r) | Anscombův kvartet, *r* = 0,82 (od 2026-11-20 místo čtyř modelových souborů s *r* = 0,60). |
| [Kvadranty](../../quarto/kapitola_10.qmd#fig-kvadranty) | Znaménka a velikost součinů odchylek. |
| [Stres a spánek](../../quarto/kapitola_10.qmd#fig-stres-spanek) | Pořadová data, velikost bodu podle počtu. |
| [Pořadí](../../quarto/kapitola_10.qmd#fig-poradi) | Převod na pořadí odstraní zakřivení. |
| [Dvourozměrné rozdělení](../../quarto/kapitola_10.qmd#fig-dvourozmerne) | Elipsa vs. heteroskedasticita. |
| [Výběrové *r*](../../quarto/kapitola_10.qmd#fig-vyberove-r) | Kolísání a šikmost *r*. |
| [Fisherova transformace](../../quarto/kapitola_10.qmd#fig-fisher-transformace) | Převodní křivka; rozdělení *r* pro ρ = 0,8 před a po převodu. |
| [Přesná permutace](../../quarto/kapitola_10.qmd#fig-permutace-presna) | 720 přiřazení šesti studentů, 48 krajních (*p*-hodnota). |
| [Permutace](../../quarto/kapitola_10.qmd#fig-permutace) | Rozdělení τ<sub>b</sub> za nezávislosti. |
| [Bootstrap](../../quarto/kapitola_10.qmd#fig-bootstrap) | Bootstrapové rozdělení a percentilové meze. |
| [Faktory](../../quarto/kapitola_10.qmd#fig-faktory) | Omezení rozsahu, krajní skupiny, sloučení skupin. |
| [Druhy odlehlého pozorování](../../quarto/kapitola_10.qmd#fig-odlehle-typy) | Krajní X ve směru vztahu, neobvyklá kombinace, krajní X i Y proti směru. |
| [Chyba měření](../../quarto/kapitola_10.qmd#fig-reliabilita) | Pravé a naměřené skóry, reliabilita 0,6. |
| [Shoda hodnot](../../quarto/kapitola_10.qmd#fig-shoda-hodnot) | Vysoké *r* bez absolutní shody hodnot. |
| [*d* a *r*<sub>pb</sub>](../../quarto/kapitola_10.qmd#fig-rpb-d) | Nepovinně: vztah podle rozdělení do skupin. |

Interaktivní vizualizace ke kapitole 10 původně nebyly (R71); od 2026-11-23 je jedna, viz níže.

<a id="interaktivni-vizualizace-10"></a>

**Interaktivní vizualizace (2026-11-23, [upřesnění R65](../rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-23-korelace), [doplnění R71](../rozhodnuti/kapitola-10.md#r71-doplneni-2026-11-23)):**
na stránku [Jak tvar mraku bodů souvisí s korelačním koeficientem](../../quarto/viz_korelace.qmd)
odkazují dva bloky „Vyzkoušejte si“: na konci pododdílu
[Vydělíme směrodatnými odchylkami](../../quarto/kapitola_10.qmd#sec-vydelime) (před rozšířením o mezích *r*)
a na konci pododdílu [Odlehlé pozorování](../../quarto/kapitola_10.qmd#sec-odlehle-korelace).

- **Ovládání:** data úzkosti a výkonu 40 studentů (výchozí), spánku z kapitoly 8 (12 dvojic) a Anscombův kvartet I–IV; posuvník a pole přesného výběrového *r* (mění Y, zachová X, průměr a SD Y); nový náhodný výběr 4–1 000 bodů; pole $m_x$, $s_x$, $m_y$, $s_y$; přesun, přidání a smazání bodů myší, dotykem, klávesnicí i formulářem (3–1 000 bodů); přizpůsobení os.
- **Grafy a výsledky:** bodový graf s přepínači kvadrantů, pravděpodobnostních elips 50–99 % (s počty bodů uvnitř), regresní přímky a reziduí (vše ve výchozím stavu vypnuto) a Vennův diagram *r*² (zapnut); přehled průměrů, SD, kovariance, *r*, $r_s$, testu, Fisherova intervalu a *r*² s dosazením; pod grafem trvale bodový graf pořadí a graf spojnic.
- **Vztah k výkladu:** oddíl „Odkud se čísla berou“ opakuje pro výchozí data $s_{xy}=-14{,}24$, *r* = −0,523, $r_s$ = −0,555, *t* = −3,79, *p* 0,0005 a interval (−0,72; −0,25). Oddíl „Pojmy, které kapitola 10 nevykládá“ krátce zavádí **jen pro vizualizaci** regresní přímku ($\hat{y}$, $b_0$, $b_1$), reziduum, koeficient determinace *r*² a pravděpodobnostní elipsu (výchozí data: $b_1=-0{,}450$, $b_0=29{,}76$, *r*² = 0,274, uvnitř elips 24, 33, 39 a 40 studentů). „Čeho si všimnout“ doplňuje oproti kapitole: přidaný student (40; 30) mění *r* na −0,308 a $r_s$ na −0,446, při X = 60 je *r* −0,105 a $r_s$ beze změny; Anscombovy soubory mají $r_s$ 0,818, 0,691, 0,991 a 0,500; u dat spánku zůstává při *r* = 0 průměrná změna 3,5 bodu.
- **Rozsah:** není samostatným cvičením; podporuje úlohy 1, 2, 15 a 16. Kendallovo τ, permutační test, bootstrap ani omezení rozsahu nepočítá. Ovládání je inspirováno aplikací [E09](../zdroje/E09-magnusson-correlation.md#e09-magnusson-correlation).

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

Nově vysvětleno 28 hesel [registru](../SLOVNIK.md#kapitola-10), z toho čtyři schválená doplněním R73 a pět revizí R84 (převzorkování, pravý skór, atenuace, nepovinně korekce na atenuaci, relativní a absolutní shoda; observační studie jako alternativa). Plné názvy „… korelační koeficient“ ve výkladu podle R84. Značení podle R72:
$s_{xy}$, *r* a ρ, $r_s$ a ρ<sub>s</sub>, τ<sub>a</sub> a τ<sub>b</sub> (výběrově, populační hodnota
slovy), $n_c$, $n_d$, $t_x$, $t_y$, $n_0$, $z_r$, $r_{pb}$, *B*; podle R84 nepovinně $r_{xx}$, $r_{yy}$, $r_{\mathrm{opr}}$ a pomocné značky rozšíření BCa. Nové funkce Excelu: CORREL,
COVARIANCE.S, RANK.AVG, SIGN, SOUČIN.SKALÁRNÍ, TRANSPOZICE, FISHER, FISHERINV.
Doplněním R73 schválena hesla omezení rozsahu, korelační matice, analýza citlivosti
a nepovinně interval BCa.

**Nepovinné:** rozptyl rozdílů přes *r*, meze *r* (důkaz), interval BCa, korekce na atenuaci, převod *d* na *r*<sub>pb</sub>,
porovnání dvou nezávislých korelací (jen cvičení 18). Další kapitola je nesmí předpokládat.

**Vysvětleno omezeně:** chyba měření a atenuace v povinné části slovně a simulací (vzorec jen nepovinně); korelační matice
a mnoho testů jen krátce; bodově biseriální korelace a φ bez samostatného cvičení;
*r*² jen jako mimo kapitolu. **Jen ve vizualizaci** (od 2026-11-23, kapitola je nevykládá a další kapitoly je nepředpokládají): regresní přímka, reziduum, koeficient determinace *r*², pravděpodobnostní elipsa a značky $\hat{y}$, $b_0$, $b_1$ ([slovník](../SLOVNIK.md#vizualizace-korelace)). **Nevyloženo:** regrese, *r*², parciální korelace, latentní
korelace, závislé korelace, síla a plánování *n*, Kendallovo W,
intervaly pro *r*<sub>s</sub> a τ ze vzorců směrodatných chyb, test ekvivalence pro *r*.

## Vazby na podklady

Výběr karet pro dohledání podkladů k tématům této kapitoly vychází z tematického rozcestníku a záznamů čtení a použití. Samotný odkaz neznamená převzetí příkladu ani nové prostudování; přesné lokátory, použití, nálezy a neověřené části jsou v kartách.

- [U01](../zdroje/U01-howell.md#priprava-10-20261109) — kap. 9 (s. 251–293), kap. 10 (s. 304–317), §18.1–18.3 (s. 657–665).
- [U03](../zdroje/U03-cumming.md#priprava-10-20261109) — kap. 11 (s. 311–339).
- [U02](../zdroje/U02-aron.md#priprava-10-20261109) — kap. 11 (s. 512, 514–515, 522; [revize](../zdroje/U02-aron.md#revize-10-20261120)).
- [D15](../zdroje/D15-muchinsky.md#d15) — korekce na atenuaci (s. 63–73); [E07](../zdroje/E07-anscombe-1973.md#e07-anscombe-1973) — data Anscombova kvartetu.
- [E09](../zdroje/E09-magnusson-correlation.md#e09-magnusson-correlation) — inspirace ovládáním vizualizace korelace (2026-11-23).
- [U15](../zdroje/U15-wilcox.md#priprava-10-20261109) — §5.9, §5.11, §6.5–6.6, §6.9, §7.7.
- [P10](../zdroje/P10-korelace-stps.md#priprava-10-20261109), [P11](../zdroje/P11-korelace-psyb1170.md#priprava-10-20261109), [C06](../zdroje/C06-ulohy-tyden-5.md#c06) — priority a náměty.
- [Čtení pro návrh](../zdroje/HISTORIE.md#priprava-10-20261109) a [použití při tvorbě](../zdroje/HISTORIE.md#pouziti-kapitola-10); [revize 2026-11-20](../zdroje/HISTORIE.md#muchinsky-2026-11-20).
