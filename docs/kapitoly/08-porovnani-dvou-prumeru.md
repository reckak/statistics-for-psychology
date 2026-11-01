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
Soulad karty s textem zkontrolován 2026-11-01.

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
„Připomenutí“ (rozdíl dvou průměrů z kap. 6). Povinná část má přibližně
8 250 slov (počítáno bez rovnic, obrázků, nepovinných bloků a cvičení).

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
| [Párový t-test](../../quarto/kapitola_08.qmd#sec-parovy-t-test) | Rozdílové skóre, směr odečítání; $m_D$, $s_D$, $\mathrm{μ}_D$; jednovýběrový t-test rozdílů: t ≈ 5,07, 11 st. v., *p* ≈ 0,0004, (1,98; 5,02). Rozhodnutí a věcná interpretace. | 2, 3. |
| [Výpočet v Excelu](../../quarto/kapitola_08.qmd#sec-parovy-excel) | List `Parovy_test` (tab. 8.3): JE.ČISLO, A, KDYŽ pro úplné dvojice; T.TEST typ 1 jako kontrola, sám vynechá neúplné dvojice. | 3. |
| [Chybná analýza](../../quarto/kapitola_08.qmd#sec-chybna-analyza), [proč rozdíly kolísají méně](../../quarto/kapitola_08.qmd#sec-proc-rozdily) | Tatáž data jako nezávislé skupiny: t ≈ 1,24, *p* = 0,227, (−2,34; 9,34) — výsledek konkrétního příkladu (tab. 8.4). Stabilní rozdíly mezi lidmi; SD 7,34 a 6,42 vs. 2,39. Přínos podmíněný; kontrastní příklad trojnásobných hodnot (SD 2 → rozdíly 4). Bez korelačního koeficientu. | 4. |
| [Co párování neřeší](../../quarto/kapitola_08.qmd#sec-co-parovani-neresi) | Efekt pořadí a učení, vyvážení pořadí. Anorexie (Everitt podle Howella) v kg: 37,75 → 41,05, $m_D$ = 3,30, $s_D$ = 3,25, t ≈ 4,18, (1,63; 4,96); poučení podle R59, kontrolní skupina podle Howella s. 200. | 2d, 11. |
| [Rozdíl dvou průměrů](../../quarto/kapitola_08.qmd#sec-rozdil-nezavislych) | Připomenutí kap. 6; $\mathrm{σ}_{m_1-m_2}$ povinně se sčítáním rozptylů; výběrové rozdělení rozdílu; odhad $s_{m_1-m_2}$; vzorec jen pro nezávislé skupiny. | 5, 6. |
| [Klasický t-test](../../quarto/kapitola_08.qmd#sec-klasicky-t-test) | Shoda rozptylů, společný odhad rozptylu a $s_p$, $n_1+n_2-2$ st. v.; parkování bez známé σ: t ≈ 3,33, *p* ≈ 0,001, (2,81; 10,95); srovnání se z = 3,24 z kap. 6. List `Klasicky_test` (tab. 8.5). | 5, 12b. |
| [Welchova varianta](../../quarto/kapitola_08.qmd#sec-welch) | Varianta B (tab. 8.6): klasický t ≈ 2,34, *p* = 0,024, (1,10; 14,90) vs. Welch t ≈ 1,86, 13,95 st. v., *p* ≈ 0,084, (−1,22; 17,22). List `Welch` (tab. 8.7): T.TEST typ 3, kvantil přes BETA.INV, T.INV.2T zkracuje. Volba předem, stejné *t* při stejných n, odlišné df/*p*/interval při různých rozptylech; Howell s. 219; předběžný test není „vrátný“; rozdílné rozptyly jako zjištění. | 5d, 6. |
| [Nepovinné: Welchovy stupně volnosti](../../quarto/kapitola_08.qmd#rozsireni-welch-stupne) | Vzorec a výpočet 13,95. | 13. |
| [Předpoklady](../../quarto/kapitola_08.qmd#sec-predpoklady-08) | Tab. 8.8; nezávislost nejdůležitější; normalita rozdílů u párového testu; opačná šikmost (Howell s. 219); volba testu nerozhoduje o příčině. | 3e, 11. |
| [Cohenovo d](../../quarto/kapitola_08.qmd#sec-cohenovo-d) | Původní jednotky; d se $s_p$ (parkování 0,47); d nezávisí na n jako t; interval pro d jen zmínka; při rozdílných rozptylech jedna skupina (Howell s. 213). Párová data: 1,45 (SD před) vs. 1,01 (SD změn), vždy uvést jmenovatel. | 5c, 7. |
| [Nepovinné: standardizace, Hedges, pásma](../../quarto/kapitola_08.qmd#rozsireni-standardizace-08) | Tři jmenovatele u párových dat, $d_z$; Hedgesova korekce; Cohenova pásma podle R56. | 14. |
| [Dva intervaly vedle sebe](../../quarto/kapitola_08.qmd#sec-dva-intervaly) | Skupiny po 25 (46 a 52, s = 10): intervaly (41,87; 50,13) a (47,87; 56,13) se překrývají, rozdíl (0,31; 11,69), *p* = 0,039; mezní chyby 4,13 + 4,13 vs. 5,69. Párová data: intervaly podmínek nestačí. Bez pravidla překryvu; „Častý omyl“. | 8. |
| [Změna ve dvou skupinách](../../quarto/kapitola_08.qmd#sec-zmena-dvou-skupin) | Trénink pozornosti, 2 × 16, náhodné přiřazení (tab. 8.9): změny 4,0 (*p* = 0,033) a 2,0 (*p* = 0,183), rozdíl změn 2,0, t ≈ 0,90, *p* = 0,376, (−2,55; 6,55). Formulace podle R59, Gelman a Stern (2006, s. 328). List `Zmeny`. | 9, 11d. |
| [Ekvivalence dvou skupin](../../quarto/kapitola_08.qmd#sec-ekvivalence-skupin) | Online vs. papír, 2 × 200, hranice ±3: 95% (−2,87; 1,07), 90% (−2,55; 0,75) → doložena; 2 × 30: 90% (−5,22; 3,42) → nerozhodné. √2krát větší chyba než vůči pevné normě; jen průměry. List `Ekvivalence_skupin`. | 10. |
| [Nepovinné: p-hodnoty TOST](../../quarto/kapitola_08.qmd#rozsireni-tost-skupiny) | t = 2,1 (*p* ≈ 0,018) a −3,9; výsledná 0,018. | Bez cvičení. |
| [Volba postupu a sdělení](../../quarto/kapitola_08.qmd#sec-volba-postupu) | Tab. 8.10 (pět situací včetně kap. 7); tři chybné postupy; ukázky zpráv APA pro variantu A (párový) a B (Welch). | 11, 12. |
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
| [Dvě skupiny](../../quarto/kapitola_08.qmd#fig-dve-skupiny) | Různá velikost a rozptýlenost; klasický vs. Welchův interval. |
| [Intervaly vedle sebe](../../quarto/kapitola_08.qmd#fig-intervaly-vedle-sebe) | Překryv intervalů skupin vs. interval rozdílu; nezávislé i párové. |
| [Změny ve skupinách](../../quarto/kapitola_08.qmd#fig-zmeny-skupin) | Dva samostatné testy vs. rozdíl změn. |
| [Ekvivalence skupin](../../quarto/kapitola_08.qmd#fig-ekvivalence-skupin) | 90% a 95% intervaly rozdílu dvou studií vůči ±3. |
| [Q–Q graf rozdílů](../../quarto/kapitola_08.qmd#fig-qq-rozdily-08) | Vzorová konstrukce uvnitř sbaleného řešení 3e. |

### Cvičení a očekávané dovednosti

[Čtrnáct úloh](../../quarto/kapitola_08.qmd#sec-cviceni-08) má úplná sbalená řešení.
Úlohy 1, 2, 4, 5, 7, 8, 9, 11 a 12 vyžadují kalkulačku, úlohy 3, 6 a 10 Excel;
meze na dvě desetinná místa, *p*-hodnoty na tři. Úlohy 13 a 14 jsou nepovinné.

| Úloha | Co student samostatně dělá |
|---|---|
| 1. Uspořádání | Šest studií: opakované měření, dvojice osob, nezávislé skupiny; studie bez ID. |
| 2. Párový test ze souhrnů | n = 20, 2,5 ± 4: t ≈ 2,80, *p* = 0,012, (0,63; 4,37); chybí kontrolní skupina. |
| 3. Párová data v Excelu | Stroop, 15 studentů, 2 neúplné dvojice: 13 dvojic, 70,38 ms, (63,89; 76,88); chybné průměry sloupců (65,1 ms); Q–Q graf rozdílů. |
| 4. Co ztratí nezávislá analýza | Porušení nezávislosti; trojnásobné hodnoty (SD 2, 6, 4); kritika „zachované pořadí stačí“. |
| 5. Klasický test (Howell) | Hrozba stereotypu: $s_p$ ≈ 3,097, t ≈ 2,37, (0,37; 5,75), d ≈ 0,99; proč Welch téměř stejný. |
| 6. Klasický, nebo Welch v Excelu | Hudba vs. ticho (10 a 25): Welch *p* ≈ 0,080, (−1,76; 25,96), BETA.INV vs. T.INV.2T; klasický *p* = 0,006; volba až po výsledku. |
| 7. d a jmenovatel | 0,5 vs. 1,0; srovnatelnost s nezávislou studií. |
| 8. Intervaly vedle sebe | Čtyři výroky o překryvu a párových datech. |
| 9. Změna ve dvou skupinách | Senioři 2 × 20: *p* 0,012 a 0,315, rozdíl změn *p* = 0,246, (−1,37; 5,17); kritika závěru. |
| 10. Ekvivalence verzí | Tablet vs. papír, ±2: 2 × 250 doložena, 2 × 40 nerozhodné; co závěr neříká. |
| 11. Chybné argumenty | Pět výroků (párová data jako nezávislá, kauzalita, volba testu po výsledku, dva testy změny, nejasné d). |
| 12. Volba postupu a zpráva | Návrh studie mobil vs. kniha; zpráva APA o parkování. |
| 13. Nepovinně: Welchovy st. v. | 20,62 ručně. |
| 14. Nepovinně: Hedges a standardizace | Korekce 0,964 (g ≈ 0,95); průměr SD = SD před. |

### Pojmy, konvence a hranice návaznosti

Nově je vysvětleno 14 pojmů [registru](../SLOVNIK.md#kapitola-08). Značení podle
R60: $m_D$, $s_D$, $\mathrm{μ}_D$, $n_1$, $n_2$, $s_1$, $s_2$, $s_{m_1-m_2}$,
$s_p$, *d*. Nové funkce Excelu: JE.ČISLO, A (dosud bez řádku přehledu), T.TEST,
BETA.INV (jen pomocný vzorec kvantilu); dále PRŮMĚR, POČET, SMODCH.VÝBĚR.S,
ODMOCNINA, ABS, KDYŽ, MAX, T.INV, T.DIST, T.DIST.2T, T.INV.2T z dřívějších kapitol.
Do bibliografie přibyl Gelman a Stern (2006).

**Nepovinné:** Welchovy stupně volnosti, varianty standardizace s Hedgesovou
korekcí a Cohenovými pásmy, *p*-hodnoty TOST pro dvě skupiny. Další kapitola je
nesmí předpokládat.

**Vysvětleno omezeně:** přínos párování bez korelačního koeficientu (vztah obou
měření jen slovně); interval pro d jen zmínka; Hedgesova korekce bez odvození
a bez citace původní práce. **Pouze zmíněno:** předběžný test shody rozptylů
(bez názvu konkrétního testu a bez výpočtu). **Nevyloženo:** ANOVA
a více skupin, korekce pro více testů, neparametrické a robustní postupy,
bootstrap, výpočet síly a plánování velikosti výběru, částečně párovaná data,
korelace.

## Vazby na podklady

- [U01](../zdroje/U01-howell.md#priprava-08-20261101) — §7.4–7.6, s. 197–220 (párová data, anorexie s. 198–201 a 200, d s. 203–204 a 213, Welch a doporučení s. 217–220, hrozba stereotypu s. 215–217, parkování s. 86).
- [U03](../zdroje/U03-cumming.md#priprava-08-20261101) a [U15](../zdroje/U15-wilcox.md#priprava-08-20261101) — kontrolní opora podle autorova čtení; při psaní necitovány.
- [E05](../zdroje/E05-gelman-stern.md#e05-gelman-stern) — s. 328, příklad 25 ± 10 a 10 ± 10.
- [P08](../zdroje/P08-prumery.md#priprava-08-20261101), [P09](../zdroje/P09-nezavisly-ttest.md#priprava-08-20261101) a [C08](../zdroje/C08-ulohy-tyden-9.md#priprava-08-20261101) — priority autora a náměty; úlohy ani čísla nepřevzaty, nálezy v kartách se do textu nedostaly.
- [Čtení pro návrh](../zdroje/HISTORIE.md#priprava-08-20261101) a [použití při tvorbě](../zdroje/HISTORIE.md#pouziti-kapitola-08).
