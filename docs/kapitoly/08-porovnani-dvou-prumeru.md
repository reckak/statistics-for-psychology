<a id="mapa-kapitola-08"></a>

# 8. Porovnání dvou průměrů: párová data a nezávislé skupiny

[Mapa celé knihy](../OSNOVA.md) · [Rozcestník zdrojů](../ZDROJE.md)

**Podklad a stav:** existující [kapitola 8](../../quarto/kapitola_08.qmd#sec-kapitola-08), karta
sestavena podle výkladu, zadání a řešení 2026-11-01. Dohodu dokládají
[R59](../rozhodnuti/kapitola-08.md#r59-rozsah-kapitoly-8),
[R60](../rozhodnuti/kapitola-08.md#r60-znaceni-kapitoly-8) a
[R61](../rozhodnuti/kapitola-08.md#r61-terminologie-kapitoly-8) s
[historií dohody](../../quarto/README.md#dohoda-kapitola-08). Vznik textu
a rozsah ověření eviduje [záznam o vytvoření](../../quarto/README.md#vytvoreni-kapitoly-8).
Soulad karty s textem zkontrolován 2026-11-01, včetně oprav po odborné revizi ([záznam](../../quarto/README.md#revize-kapitoly-8)). Revize podle autorových připomínek 2026-11-14 ([R76](../rozhodnuti/spolecne-konvence.md#r76-jazykove-konvence), [R77](../rozhodnuti/kapitola-08.md#r77-revize-kapitoly-8), [záznam](../../quarto/README.md#revize-kapitola-08-2026-11-14)); soulad celé karty s textem znovu zkontrolován 2026-11-14.

**Vstup:** datová matice a ID (kap. 1); krabicový graf a změna škály (kap. 3);
Q–Q graf (kap. 4); KDYŽ (kap. 5); parkovací studie, rozdíl dvou průměrů a jeho
simulace, dva kroky závěru, nezamítnutí, volby podle dat a velikost účinku
v původních jednotkách (kap. 6); t-rozdělení, $t_{p\,(v)}$, interval s t-kvantilem,
jednovýběrový t-test, předpoklady t-postupů, test ekvivalence pomocí 90%
intervalu a ukázka zprávy APA (kap. 7). Nepovinné části kapitol 3–7 se
nepředpokládají; nepovinný blok kap. 6 o standardizovaném rozdílu je jen připomenut.

**Cíle:** rozpoznat párová data a nezávislé skupiny podle uspořádání; připravit
párová data s neúplnými dvojicemi a provést párový t-test s intervalem;
vysvětlit podmíněný přínos párování; směrodatná chyba rozdílu, klasický
a Welchův t-test s intervalem; Cohenovo d a volba jmenovatele u párových dat;
čtení dvou intervalů vedle sebe; porovnání změn ve dvou skupinách; ekvivalence
dvou skupin; volba postupu a sdělení výsledků.

**Čitelnost ([R38](../rozhodnuti/postupy-a-dokumentace.md#r38-citelnost-textu)):** každý hlavní oddíl
začíná otázkou a návazností; závěrečné [Shrnutí](../../quarto/kapitola_08.qmd#sec-shrnuti-08)
má osm myšlenek s odkazy. Jeden blok „Častý omyl“ (překryv intervalů) a jedno
„Připomenutí“ (rozdíl dvou průměrů z kap. 6). Povinný výklad zůstává po
revizi pod orientační hranicí 12 000 slov; rozsah učiva se nerozšiřuje.

**Odchylka od členění v R59:** schválený oddíl 11 „Jsou dvě podmínky prakticky
rovnocenné? Volba postupu a sdělení výsledků“ je rozdělen na dva hlavní oddíly
([ekvivalence](../../quarto/kapitola_08.qmd#sec-ekvivalence-skupin)
a [volba postupu](../../quarto/kapitola_08.qmd#sec-volba-postupu)); oddíl o změnách
ve dvou skupinách předchází ekvivalenci, jak R59 připouští. Obsah se nemění.

### Skutečný obsah oddílů

Všechny části jsou **vysvětleny**, pokud není uvedeno „nepovinné“; poslední
sloupec určuje konkrétní **procvičení**.

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Od jedné skupiny ke dvěma](../../quarto/kapitola_08.qmd#sec-od-jedne-ke-dvema) | Varianty A (tíž studenti, vyvážené pořadí) a B (náhodně rozdělené skupiny). Párová data, opakované měření a dvojice různých osob jako užší případy; nezávislé skupiny; rozhoduje uspořádání; podoba v datové matici (tab. 8.1). | 1. |
| [Úplné a neúplné dvojice](../../quarto/kapitola_08.qmd#sec-neuplne-dvojice) | 13 studentů, student 9 bez druhého měření (tab. 8.2). Zachovat ID a řádky, vyřazovat celé dvojice, n = 12; průměry sloupců 50,54 a 46,83 (rozdíl 3,71) vs. průměrný rozdíl 3,50; vyřazení může změnit složení souboru. | 3a, 3d. |
| [Párový t-test](../../quarto/kapitola_08.qmd#sec-parovy-t-test) | Rozdílové skóre, směr odečítání; $m_D$, $s_D$, $\mathrm{μ}_D$; obecný tvar $t=(m_D-\mathrm{μ}_0)/(s_D/\sqrt n)$, nejčastěji $\mathrm{μ}_0=0$. Nenulová nulová hypotéza: známý efekt opakování +2 body, 16 studentů, 4 ± 6,82 → t ≈ 1,17; výhrada, že spolehlivější je kontrolní skupina; u dvou skupin odkaz na TOST. Test A: t ≈ 5,07, 11 st. v., *p* ≈ 0,0004, (1,98; 5,02). Rozhodnutí a věcná interpretace. | 2, 3. |
| [Výpočet v Excelu](../../quarto/kapitola_08.qmd#sec-parovy-excel) | List `Parovy_test` (tab. 8.3): JE.ČISLO, A, KDYŽ pro úplné dvojice; T.TEST typ 1 jako kontrola, sám vynechá neúplné dvojice. | 3. |
| [Chybná analýza](../../quarto/kapitola_08.qmd#sec-chybna-analyza), [proč rozdíly kolísají méně](../../quarto/kapitola_08.qmd#sec-proc-rozdily) | Tatáž data jako nezávislé skupiny: t ≈ 1,24, *p* = 0,227, (−2,34; 9,34) — výsledek konkrétního příkladu (tab. 8.4). Stabilní rozdíly mezi lidmi; SD 7,34 a 6,42 vs. 2,39. Přínos podmíněný; kontrastní příklad trojnásobných hodnot (SD 2 → rozdíly 4) vyvrací tvrzení o malé SD rozdílů, nikoli o přesnosti párové analýzy. Bez korelačního koeficientu. | 4. |
| [Nepovinné: variabilita rozdílů a korelace](../../quarto/kapitola_08.qmd#rozsireni-rozptyl-rozdilu-08) | Přesunuto z kap. 10 (R77). Pearsonovo *r* neformálně s odkazem na kap. 10; $s_D^2=s_1^2+s_2^2-2rs_1s_2$; spánek: r = 0,948, $s_D$ ≈ 2,40 se zaokrouhlenými vstupy (přesně 2,39), 9,75 při r = 0; 2, 4, 6 / 6, 12, 18 (r = 1, $s_D$ = 4). Obrázek se třemi simulovanými soubory (r = 0,9; 0; −0,5). Kontrastní věta k přesnosti přepsána: přesnost posuzujeme šířkou intervalu. | Bez cvičení. |
| [Co párování neřeší](../../quarto/kapitola_08.qmd#sec-co-parovani-neresi) | Efekt pořadí a učení; bez vyvážení by se podmínka kryla s pořadím, vyvážení je od sebe odděluje. Anorexie (Everitt podle Howella) v kg (1 lb ≈ 0,454 kg): 37,75 → 41,05, $m_D$ = 3,30, $s_D$ = 3,25, t ≈ 4,18, (1,63; 4,96); poučení podle R59, kontrolní skupina podle Howella s. 200. | 2d, 11. |
| [Rozdíl dvou průměrů](../../quarto/kapitola_08.qmd#sec-rozdil-nezavislych) | Připomenutí kap. 6; obrázek směrodatné chyby rozdílu pro 60 lidí v poměru 1:1, 2:1, 4:1 (σ 10/10: 2,58, 2,74, 3,23; menší skupina σ 20: 4,08, 4,74, 5,95, společný odhad 4,08, 3,86, 4,04; větší skupina σ 20: 4,08, 3,87, 4,08 vs. 4,08, 4,76, 5,98); $\mathrm{σ}_{m_1-m_2}$ povinně se sčítáním rozptylů; výběrové rozdělení rozdílu; odhad $s_{m_1-m_2}$; vzorec jen pro nezávislé skupiny. | 5, 6. |
| [Klasický t-test](../../quarto/kapitola_08.qmd#sec-klasicky-t-test) | Shoda rozptylů, společný odhad rozptylu a $s_p$, $n_1+n_2-2$ st. v.; parkování bez známé σ: t ≈ 3,33, *p* ≈ 0,001, (2,81; 10,95); srovnání se z = 3,24 z kap. 6. List `Klasicky_test` (tab. 8.5). | 5, 12b. |
| [Welchova varianta](../../quarto/kapitola_08.qmd#sec-welch) | Varianta B (tab. 8.6): klasický t ≈ 2,34, *p* = 0,024, (1,10; 14,90) vs. Welch t ≈ 1,86, 13,95 st. v., *p* ≈ 0,084, (−1,22; 17,22). List `Welch` (tab. 8.7): T.TEST typ 3, kvantil přes BETA.INV, T.INV.2T zkracuje. Volba předem, stejné *t* při stejných n, odlišné df/*p*/interval při různých rozptylech; Howell s. 219; předběžný test není „vrátný“; rozdílné rozptyly jako zjištění. | 5d, 6. |
| [Nepovinné: Welchovy stupně volnosti](../../quarto/kapitola_08.qmd#rozsireni-welch-stupne) | Vzorec a výpočet 13,95; obrázek stupňů volnosti pro poměry 1:1, 2:1, 4:1 (stejné σ 58, 38,1, 16,9; menší skupina dvakrát variabilnější 42,6, 23,9, 12,4; větší 42,6, 58,0, 35,7). | 13. |
| [Předpoklady](../../quarto/kapitola_08.qmd#sec-predpoklady-08) | Tab. 8.8 a tabulka robustnosti (`tbl-k08-odolnost`: kdy je postup vůči porušení nezávislosti, normality a shody rozptylů robustní; Howell s. 219, Wilcox s. 261–262); nezávislost nejdůležitější; normalita rozdílů u párového testu; opačná šikmost (Howell s. 219); volba testu nerozhoduje o příčině. | 3e, 11. |
| [Cohenovo *d*](../../quarto/kapitola_08.qmd#sec-cohenovo-d) | Původní jednotky; standardizace jako vztažení ke směrodatné odchylce jednotlivých hodnot; *d* se $s_p$ (parkování 0,47); *d* nezávisí na n jako t; interval pro *d* odkazem na nepovinné rozšíření; při rozdílných rozptylech jedna skupina (Howell s. 213), varianta B *d* = 8,00/7,97 ≈ 1,00 vůči skupině po běžném spánku. Párová data: 1,45 (SD před) vs. 1,01 (SD změn), vždy uvést jmenovatel. Vizualizace podle R65. | 5c, 7. |
| [Nepovinné: interval pro *d*](../../quarto/kapitola_08.qmd#rozsireni-interval-d) | Přesný interval z necentrálního t (Cumming s. 190) jen jako srovnání. Přibližně $s_d=\sqrt{(n_1+n_2)/(n_1n_2)+d^2/(2n_1)}$ pro *d* vůči SD kontrolní skupiny (Howell s. 632), $d\pm1{,}96\,s_d$: B (0,29; 1,72), parkování (0,19; 0,76), přesně (0,19; 0,75); omezení podle Alginy a Keselmana (2003, s. 540–541). Párové *d* vůči $\sqrt{(s_1^2+s_2^2)/2}=6{,}90$: 0,51, (0,22; 0,79) postupem Alginy a Keselmana (s. 544–545) bez Excelu. List `Klasicky_test` B21:B24. | 12b (hodnoty v zadání). |
| [Nepovinné: standardizace, Hedges, pásma](../../quarto/kapitola_08.qmd#rozsireni-standardizace-08) | Tři jmenovatele u párových dat, $d_z$; Hedgesova korekce s oporou v Lakensovi (2013, s. 3, rovnice 4); Cohenova pásma podle R56. | 14. |
| [Dva intervaly vedle sebe](../../quarto/kapitola_08.qmd#sec-dva-intervaly) | Skupiny po 25 (46 a 52, s = 10): intervaly (41,87; 50,13) a (47,87; 56,13) se překrývají, rozdíl (0,31; 11,69), *p* = 0,039; mezní chyby 4,13 + 4,13 vs. 5,69. Chybové úsečky a bodový odhad; důsledek $\sqrt{a^2+b^2}<a+b$: rozdíly průměrů mezi 5,69 a 8,26 bodu jsou významné, ač se intervaly překrývají. Párová data: intervaly podmínek nestačí. Bez pravidla překryvu; „Častý omyl“. | 8. |
| [Změna ve dvou skupinách](../../quarto/kapitola_08.qmd#sec-zmena-dvou-skupin) | Trénink pozornosti, 2 × 16, náhodné přiřazení, aktivní kontrolní skupina (cvičení bez tréninku pozornosti; zachytí i očekávání) (tab. 8.9): změny 4,0 (*p* = 0,033) a 2,0 (*p* = 0,183), rozdíl změn 2,0, t ≈ 0,90, *p* = 0,376, (−2,55; 6,55). Formulace podle R59 s Gelmanem a Sternem (2006) bez jejich číselného příkladu; ilustrace na vlastních datech (4 a 2 body, *p* 0,033 a 0,183, rozdíl 2 se směrodatnou chybou 2,23). | 9, 11d. |
| [Ekvivalence dvou skupin](../../quarto/kapitola_08.qmd#sec-ekvivalence-skupin) | Online vs. papír, 2 × 200, hranice ±3: 95% (−2,87; 1,07), 90% (−2,55; 0,75) → doložena; 2 × 30: 90% (−5,22; 3,42) → nerozhodné. √2krát větší chyba než vůči pevné normě; jen průměry. List `Ekvivalence_skupin`. | 10. |
| [Nepovinné: p-hodnoty TOST](../../quarto/kapitola_08.qmd#rozsireni-tost-skupiny) | t = 2,1 (*p* ≈ 0,018) a −3,9; výsledná 0,018. | Bez cvičení. |
| [Volba postupu a sdělení](../../quarto/kapitola_08.qmd#sec-volba-postupu) | Tab. 8.10 (pět situací včetně kap. 7); tři chybné postupy; ukázky zpráv APA pro variantu A (párový; *SD* rozdílů, *r* = 0,95, *d* = 0,51 s CI) a B (Welch; *d* = 1,00 vůči skupině po běžném spánku s CI). | 11, 12. |
| [Shrnutí](../../quarto/kapitola_08.qmd#sec-shrnuti-08) | Osm odkazovaných myšlenek. | Souhrnně 1–12. |

### Příklady, vizualizace a soubory

[Sešit kapitoly 8](../../data/kapitola_08.xlsx) má 20 listů: `Prehled`, pět
výpočtových listů (`Parovy_test`, `Klasicky_test`, `Welch`, `Zmeny`,
`Ekvivalence_skupin`), sedm vstupních listů výkladu (`Spanek_par`,
`Spanek_skupiny`, `Parkovani`, `Anorexie`, `Vedle_sebe`, `Trenink`, `Ekv_studie`)
a sedm vstupních listů cvičení. [Pokrytí cvičení](../DATA.md#kapitola-8).

Varianty A–D spánku a pozornosti jsou autorské modely navazující na kap. 4, 6
a 7; data varianty B byla jednou vylosována (seed 20261189, zaokrouhlení na
celé body) a dále se uchovávají jako pevné hodnoty. Parkování přebírá souhrny
Howella (s. 86), anorexie souhrny spočítané z Howellovy tab. 7.3 převedené
na kg (jednotlivé hodnoty se v sešitu ani dokumentaci neuvádějí), cvičení 5
Howellova konstruovaná data o hrozbě stereotypu (s. 215–217). Ostatní cvičení
jsou autorská.

| Obrázek | Didaktický účel |
|---|---|
| [Dvě uspořádání](../../quarto/kapitola_08.qmd#fig-dve-usporadani) | Schéma dvojic a dvou skupin. |
| [Párová data](../../quarto/kapitola_08.qmd#fig-parova-data) | Spojnice jednotlivců; rozdíly kolísají méně; interval rozdílu; chybějící student 9. |
| [Korelace a SD rozdílů](../../quarto/kapitola_08.qmd#fig-korelace-rozdily) | Nepovinně: SD rozdílů podle *r*; tři simulované soubory (seed 20261114 + i, přesné výběrové r a SD varianty A). |
| [Poměr velikostí skupin](../../quarto/kapitola_08.qmd#fig-pomer-skupin) | Směrodatná chyba rozdílu podle poměru skupin a shody σ; skutečná vs. společný odhad. |
| [Dvě skupiny](../../quarto/kapitola_08.qmd#fig-dve-skupiny) | Různá velikost a variabilita; klasický vs. Welchův interval. |
| [Welchovy stupně volnosti](../../quarto/kapitola_08.qmd#fig-welch-stupne) | Nepovinně: stupně volnosti podle poměru skupin a σ mezi stupni volnosti menší skupiny a 58. |
| [Intervaly vedle sebe](../../quarto/kapitola_08.qmd#fig-intervaly-vedle-sebe) | Překryv intervalů skupin vs. interval rozdílu; nezávislé i párové. |
| [Změny ve skupinách](../../quarto/kapitola_08.qmd#fig-zmeny-skupin) | Dva samostatné testy vs. rozdíl změn. |
| [Ekvivalence skupin](../../quarto/kapitola_08.qmd#fig-ekvivalence-skupin) | 90% a 95% intervaly rozdílu dvou studií vůči ±3. |
| [Q–Q graf rozdílů](../../quarto/kapitola_08.qmd#fig-qq-rozdily-08) | Vzorová konstrukce uvnitř sbaleného řešení 3e. |

<a id="interaktivni-vizualizace-08"></a>

**Interaktivní vizualizace (2026-11-13, [upřesnění R65](../rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-13-cohen)):**
na konci oddílu [Cohenovo d pro nezávislé skupiny](../../quarto/kapitola_08.qmd#sec-d-nezavisle)
odkazuje blok „Vyzkoušejte si: co znamená rozdíl o d směrodatných odchylek“
na stránku [Co znamená rozdíl o *d* směrodatných odchylek](../../quarto/viz_cohenovo_d.qmd).

- **Ovládání:** posuvník *d* 0–2 po 0,01 (výchozí 0,5) se značkami Cohenových orientačních hodnot, pole σ v původních jednotkách (výchozí 10) pro převod na rozdíl průměrů a přepínač vybarvení.
- **Grafy:** rozdělení obou skupin (osa v jednotkách σ, průměr skupiny 2 v nule) se společnou plochou, nebo částí skupiny 1 nad průměrem skupiny 2; rozdělení rozdílu hodnot náhodné dvojice se směrodatnou odchylkou σ√2.
- **Výpočet a tabulka:** tři ukazatele opisem, $\mathrm{Φ}(d)$, $2\,\mathrm{Φ}(-d/2)$ a $\mathrm{Φ}(d/\sqrt2)$, se vzorci NORM.S.DIST a ODMOCNINA; pevná tabulka pro sedm hodnot *d*.
- **Vztah k výkladu:** ukazatele nejsou zavedeny jako pojmy učebnice a nemají hesla. Úkoly „Vyzkoušejte si“ míří na *d* = 0,5, parkovací *d* ≈ 0,47 a σ = 14,6 s, hledání *d* pro pravděpodobnost 75 % (asi 0,95) a „malý“ účinek *d* = 0,2 při σ = 15.
- **Rozsah:** opakuje učivo oddílu [Cohenovo d pro nezávislé skupiny](../../quarto/kapitola_08.qmd#sec-d-nezavisle), ploch pod normální křivkou z kapitoly 4 a sčítání rozptylů z oddílu [Dvě nezávislé skupiny](../../quarto/kapitola_08.qmd#sec-rozdil-nezavislych). Není samostatným cvičením.

Kontrola souladu s textem uvedených oddílů: 2026-11-13; celá karta znovu 2026-11-14.

### Cvičení a očekávané dovednosti

[Čtrnáct úloh](../../quarto/kapitola_08.qmd#sec-cviceni-08) má úplná sbalená řešení.
Úlohy 1, 2, 4, 5, 7, 8, 9, 11 a 12 vyžadují kalkulačku, úlohy 3, 6 a 10 Excel;
meze na dvě desetinná místa, *p*-hodnoty na tři. Úlohy 13 a 14 jsou nepovinné.

| Úloha | Co student samostatně dělá |
|---|---|
| 1. Uspořádání | Šest studií: opakované měření, dvojice osob, nezávislé skupiny; studie bez ID. |
| 2. Párový test ze souhrnů | n = 20, 2,5 ± 4: t ≈ 2,80, *p* = 0,012, (0,63; 4,37); chybí kontrolní skupina. |
| 3. Párová data v Excelu | Stroop, 15 studentů, 2 neúplné dvojice: 13 dvojic, 70,38 ms, (63,89; 76,88); chybné průměry sloupců (65,1 ms); Q–Q graf rozdílů. |
| 4. Co ztratí nezávislá analýza | Porušení nezávislosti; trojnásobné hodnoty (SD 2, 6, 4); zachované pořadí nezaručuje SD rozdílů menší než SD každého měření. Přesnost analýz se posuzuje šířkou intervalů (řešení přepsáno 2026-11-14). |
| 5. Klasický test (Howell) | Hrozba stereotypu: $s_p$ ≈ 3,097, t ≈ 2,37, (0,37; 5,75), d ≈ 0,99; proč Welch téměř stejný. |
| 6. Klasický, nebo Welch v Excelu | Hudba vs. ticho (10 a 25): Welch *p* ≈ 0,080, (−1,76; 25,96), BETA.INV vs. T.INV.2T; klasický *p* = 0,006; volba až po výsledku. |
| 7. d a jmenovatel | 0,5 vs. 1,0; srovnatelnost s nezávislou studií. |
| 8. Intervaly vedle sebe | Čtyři výroky o překryvu a párových datech. |
| 9. Změna ve dvou skupinách | Senioři 2 × 20: *p* 0,012 a 0,315, rozdíl změn *p* = 0,246, (−1,37; 5,17); kritika závěru. |
| 10. Ekvivalence verzí | Tablet vs. papír, ±2: 2 × 250 doložena, 2 × 40 nerozhodné; co závěr neříká. |
| 11. Chybné argumenty | Pět výroků (párová data jako nezávislá, kauzalita, volba testu po výsledku, dva testy změny, nejasné d). |
| 12. Volba postupu a zpráva | Návrh studie mobil vs. kniha; zpráva APA o parkování včetně *d* = 0,47 s 95% CI [0,19; 0,76] (hodnoty v zadání). |
| 13. Nepovinně: Welchovy st. v. | 20,62 ručně. |
| 14. Nepovinně: Hedges a standardizace | Korekce 0,964 (g ≈ 0,95); průměr SD = SD před. |

### Pojmy, konvence a hranice návaznosti

Nově je vysvětleno 14 pojmů [registru](../SLOVNIK.md#kapitola-08); při revizi 2026-11-14 přibyly chybová úsečka a aktivní kontrolní skupina a terminologie podle R76 (variabilita, intervence, korigovaný počet stupňů volnosti, kurzivní *d*). Značení podle
R60: $m_D$, $s_D$, $\mathrm{μ}_D$, $n_1$, $n_2$, $s_1$, $s_2$, $s_{m_1-m_2}$,
$s_p$, *d*; nepovinně $s_d$ a Pearsonovo *r* (z kap. 10), μ₀ z kap. 6–7 u párového testu. Nové funkce Excelu: JE.ČISLO, A, T.TEST,
BETA.INV (jen pomocný vzorec kvantilu); dále PRŮMĚR, POČET, SMODCH.VÝBĚR.S,
ODMOCNINA, ABS, KDYŽ, MAX, T.INV, T.DIST, T.DIST.2T, T.INV.2T a NORM.S.INV (interval pro *d*) z dřívějších kapitol.
Při revizi přibyly citace Wilcoxe (2017) a Lakense (2013); Gelman a Stern
(2006) byli zařazeni při vzniku kapitoly; při revizi 2026-11-14 přibyli Algina a Keselman (2003) a Howell s. 219 a 632, Cumming s. 190.

**Nepovinné:** variabilita rozdílů a korelace obou měření, Welchovy stupně volnosti s grafem, interval spolehlivosti pro *d*, varianty standardizace s Hedgesovou
korekcí a Cohenovými pásmy, *p*-hodnoty TOST pro dvě skupiny. Další kapitola je
nesmí předpokládat.

**Vysvětleno omezeně:** korelační koeficient jen neformálně v nepovinném rozšíření a v ukázce zprávy (výklad v kap. 10); interval pro *d* jen přibližně v nepovinném rozšíření, přesný postup bez výpočtu; Hedgesova korekce bez odvození, s citací metodického článku Lakense (2013); původní Hedgesova práce nebyla čtena. **Pouze zmíněno:** předběžný test shody rozptylů
(bez názvu konkrétního testu a bez výpočtu). **Nevyloženo:** ANOVA
a více skupin, korekce pro více testů, neparametrické a robustní postupy,
bootstrap, výpočet síly a plánování velikosti výběru, částečně párovaná data,
výpočet a inference korelace.

## Vazby na podklady

- [U01](../zdroje/U01-howell.md#priprava-08-20261101) — §7.4–7.6, s. 197–220 (párová data, anorexie s. 198–201 a 200, d s. 203–204 a 213, Welch a doporučení s. 217–220, robustnost při stejných velikostech skupin s. 219, hrozba stereotypu s. 215–217, parkování s. 86); §17.2, s. 632 (přibližná směrodatná chyba *d*, [revize 2026-11-14](../zdroje/U01-howell.md#revize-08-20261114)).
- [U03](../zdroje/U03-cumming.md#priprava-08-20261101) — kontrolní opora pro rozlišení variability a přesnosti; s. 190 citována u přesného intervalu pro *d* ([revize 2026-11-14](../zdroje/U03-cumming.md#revize-08-20261114)).
- [D14](../zdroje/D14-algina-keselman.md#d14) — s. 540–541 (přesnost přibližného intervalu pro nezávislé skupiny) a s. 544–545 (přibližný interval pro párové *d*).
- [U15](../zdroje/U15-wilcox.md#revize-08-20261101) — s. 261–262 citovány u omezení Welchova testu při nenormalitě.
- [E06](../zdroje/E06-lakens-2013.md#e06-lakens-2013) — s. 3, rovnice 4, opora Hedgesovy korekce.
- [E05](../zdroje/E05-gelman-stern.md#e05-gelman-stern) — hlavní teze článku; příklad 25 ± 10 a 10 ± 10 (s. 328) byl při revizi 2026-11-14 z textu odstraněn.
- [P08](../zdroje/P08-prumery.md#priprava-08-20261101), [P09](../zdroje/P09-nezavisly-ttest.md#priprava-08-20261101) a [C08](../zdroje/C08-ulohy-tyden-9.md#priprava-08-20261101) — priority autora a náměty; úlohy ani čísla nepřevzaty, nálezy v kartách se do textu nedostaly.
- [Čtení pro návrh](../zdroje/HISTORIE.md#priprava-08-20261101) a [použití při tvorbě](../zdroje/HISTORIE.md#pouziti-kapitola-08).
