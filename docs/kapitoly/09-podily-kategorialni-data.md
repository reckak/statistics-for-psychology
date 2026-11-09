<a id="mapa-kapitola-09"></a>

# 9. Podíly a kategoriální data: odhad, testy chí-kvadrát a velikost souvislosti

[Mapa celé knihy](../OSNOVA.md) · [Rozcestník zdrojů](../ZDROJE.md)

**Podklad a stav:** existující [kapitola 9](../../quarto/kapitola_09.qmd#sec-kapitola-09), karta
sestavena podle výkladu, zadání a řešení 2026-11-09. Dohodu dokládají
[R68](../rozhodnuti/kapitola-09.md#r68-rozsah-kapitoly-9),
[R69](../rozhodnuti/kapitola-09.md#r69-znaceni-kapitoly-9) a
[R70](../rozhodnuti/kapitola-09.md#r70-terminologie-kapitoly-9) s
[historií dohody](../../quarto/README.md#dohoda-kapitola-09). Vznik textu
a rozsah ověření eviduje [záznam o vytvoření](../../quarto/README.md#vytvoreni-kapitoly-9).
Soulad karty s textem zkontrolován 2026-11-09. Autorská odborná revize zatím neproběhla.

**Vstup:** nominální a ordinální úroveň měření, souvislost a příčina (kap. 1);
absolutní a relativní četnost, značka $f_j$ a sumace (kap. 2); stupně volnosti
(kap. 3); normovaný normální model, NORM.S.DIST a NORM.S.INV (kap. 4); kontingenční
tabulka, podmíněná pravděpodobnost, nezávislé jevy, přirozené četnosti, binomický
model a normální aproximace (kap. 5); výběrové rozdělení a směrodatná chyba podílu,
binomický test, z-test, dva kroky závěru, nezamítnutí a více testů (kap. 6);
interval spolehlivosti a pokrytí (kap. 7); párová data, neúplné dvojice a rozdíl
dvou nezávislých odhadů (kap. 8). Šance z nepovinné části kap. 5 se nepředpokládají
a vysvětlují znovu; logaritmus jen v nepovinném rozšíření.

**Cíle:** podle „Co budete po prostudování umět“: kategoriální data a průměr 0/1;
Wilsonův interval a jeho vztah k testu; rozdíl dvou nezávislých podílů
s Newcombovým intervalem a testem se společným podílem; test dobré shody a test
nezávislosti ručně i v Excelu; řádkové podíly a rezidua bez nadměrného výkladu
buněk; předpoklady a Fisherův exaktní test; rozdíl podílů, poměr rizik, poměr
šancí, φ a Cramérovo V; McNemarův test a sdělení ve dvou krocích.

**Čitelnost ([R38](../rozhodnuti/postupy-a-dokumentace.md#r38-citelnost-textu)):** každý hlavní
oddíl začíná otázkou a návazností; Shrnutí má osm odkazovaných myšlenek. Strojová
kontrola po úpravách našla tři věty nad 35 slov jen v nepovinných rozšířeních a ve
výčtu nepovinných částí. Pododdíl „Poměr rizik a poměr šancí“ zavádí šest pojmů
(riziko, rozdíl rizik, poměr rizik, referenční skupina, šance, poměr šancí);
překračuje vodítko 2–3 pojmů, protože R68 předepisuje tři pododdíly měr účinku.

<a id="skutecny-obsah-09"></a>

### Skutečný obsah oddílů

Všechny části jsou **vysvětleny**, pokud není uvedeno „nepovinné“; poslední
sloupec určuje konkrétní **procvičení**. Jedenáct hlavních oddílů odpovídá
členění v R68.

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Od tabulky ve výběru k populaci](../../quarto/kapitola_09.qmd#sec-od-tabulky-k-populaci) | Tabulka 200 studentů z kap. 5 jako náhodný výběr (40 % a 30 %); kategoriální data, podíl $p$ a parametr $\mathrm{π}$; průměr kódů nominálních kategorií bez smyslu, průměr 0/1 je podíl; tři typy otázek. | 1. |
| [Jak přesně odhadneme podíl](../../quarto/kapitola_09.qmd#sec-interval-podilu) | 10 z 20 (test z kap. 6): Wald (0,28; 0,72) jen jako mezikrok, selhání u 0 z 15 a zešikmení u okrajů; Wilsonův interval vzorcem (střed, polovina šířky; 0,30–0,70; 0 z 15: 0–0,20; 40 z 80: 0,39–0,61); předpoklady a procenta. List `Interval_podilu`. Skórový test ($z=2{,}58$, *p*-hodnota 0,0098) a vztah k binomickému testu kap. 6 (0,014) formulací R68. | 2, 3. |
| [Nepovinné: souhrn studií o telepatii](../../quarto/kapitola_09.qmd#rozsireni-ganzfeld) | 106 z 329 (Cumming, Bem a Honorton), Wilson (0,274; 0,374), *p* 0,002; proč výpočet sám neprokazuje telepatii. | Bez cvičení. |
| [Dva nezávislé podíly](../../quarto/kapitola_09.qmd#sec-dva-podily) | Sčítání rozptylů (Wald −0,03; 0,23 jako princip); Newcombův interval z Wilsonových intervalů (−0,032; 0,227) s vysvětlením mezí; test se společným podílem 0,35, $z=1{,}48$, *p* 0,138; proč test používá společný podíl a interval ne; dvojnásobný výběr *p* 0,036. List `Dva_podily`. | 4, 12. |
| [Dobrá shoda](../../quarto/kapitola_09.qmd#sec-dobra-shoda) | Volba jednoho ze čtyř stejných vzorků čaje (80 lidí; 12, 16, 21, 31); $e_j=n\mathrm{π}_{0j}$; nerovnoměrné π₀ (poradna); „Častý omyl“ o profilu z jiného výběru; statistika $\mathrm{χ}^2=10{,}10$ s tabulkou příspěvků; dvě kategorie $\mathrm{χ}^2=z^2$ (6,667). | 5, 6. |
| [Chí-kvadrát rozdělení](../../quarto/kapitola_09.qmd#sec-chi-rozdeleni) | Simulace 10 000 výběrů (průměr 2,99; 1,6 % ≥ 10,10; 5,0 % nad 7,81); rozdělení a stupně volnosti $k-1$; aproximace diskrétní statistiky, opora v rozšíření CLT (Wilcox); *p*-hodnota 0,018 z pravého chvostu; test nesměrový a nezávislý na pořadí (Howell, s. 156); CHISQ.DIST.RT, CHISQ.INV.RT, CHISQ.TEST na listu `Dobra_shoda`; co test neříká (intervaly kategorií, více srovnání). | 5, 6. |
| [Nepovinné: proč chí-kvadrát](../../quarto/kapitola_09.qmd#rozsireni-proc-chi) | Součet normovaných čtverců, normální aproximace četností, $k-1$ podle Navarrové. | Bez cvičení. |
| [Nezávislost a homogenita](../../quarto/kapitola_09.qmd#sec-nezavislost) | Očekávané četnosti ze součinového pravidla (kap. 5); značení $f_{jl}$, $e_{jl}$, $f_{j+}$, $f_{+l}$, tabulka $R\times S$ (R69); dvojitá sumace; $(R-1)(S-1)$; tabulka stresu $\mathrm{χ}^2=2{,}198=z^2$; test nezávislosti vs. homogenity podle uspořádání; souvislost není příčina. | 7, 8. |
| [Řádkové podíly a rezidua](../../quarto/kapitola_09.qmd#sec-rezidua) | Věk × strategie zvládání (190; $\mathrm{χ}^2=11{,}78$, 4 st. v., *p* 0,019, V 0,18); řádkové podíly a obrázek; Pearsonova a upravená rezidua s tabulkou obou; upravená rezidua jen popisně, generační výklad průřezu; list `Tabulka` s ŘÁDKY a SLOUPCE. | 7. |
| [Nepovinné: Holmova korekce](../../quarto/kapitola_09.qmd#rozsireni-holm) | Postupné hranice α/m; v tabulce zvládání průkazná jen buňka senioři × řešení problému. List `Tabulka` A36:D50. | 13. |
| [Předpoklady a Fisherův test](../../quarto/kapitola_09.qmd#sec-predpoklady-09) | Dva významy nezávislosti; absolutní četnosti; „Častý omyl“ s nevýskyty (letní čas, Howell s. 154); hierarchie pravidel očekávaných četností (≥ 5 jako konzervativní vodítko, další doporučení, ne samostatná záruka); Fisherův test povinně: otázka, podmínění okrajovými součty, čtení výsledku (pilot 8/10 vs. 3/10: χ² *p* 0,025, Fisher 0,070; stres 0,18 vs. 0,14), není jen pro malé výběry; „Častý omyl“ o neparametričnosti. | 9, 12. |
| [Nepovinné: Fisher v Excelu](../../quarto/kapitola_09.qmd#rozsireni-fisher) | Hypergeometrické rozdělení (schváleno doplněním R70), HYPGEOM.DIST, SUMIF; list `Fisher`. | Bez cvičení. |
| [Velikost souvislosti](../../quarto/kapitola_09.qmd#sec-velikost-souvislosti) | Daniels podle Fielda (56/140 vs. 20/117): (a) rozdíl 22,9 bodu, Newcombe (11,9; 33,0), přirozené četnosti, procenta vs. procentní body; (b) riziko, poměr rizik 2,34 a referenční skupina (0,43), šance a poměr šancí 3,23, proč OR existuje, aspirin jako vzácný jev (1,82 a 1,83; 0,77 bodu); (c) φ = 0,25 se znaménkem podle kódování, Cramérovo V, omezení (aspirin φ 0,034), bez slovních pásem; věcná interpretace s výhradou k náhodnému rozdělení. List `Mira_souvislosti`. | 10, 14. |
| [Nepovinné: intervaly pro poměry](../../quarto/kapitola_09.qmd#rozsireni-intervaly-pomeru) | LN a EXP; RR (1,50; 3,66), OR (1,80; 5,82). | 14. |
| [Nepovinné: Simpsonův paradox](../../quarto/kapitola_09.qmd#rozsireni-simpson) | Berkeley 1973, obory B–F (Howell), tabulka podílů; odchylka Howellova 28,8 % od 27,1 % uvedena. | Bez cvičení. |
| [McNemarův test](../../quarto/kapitola_09.qmd#sec-mcnemar) | Vyhledávání pomoci (Howell, smyšlená data, 72 dětí); tabulka přechodů; zdůvodnění podle R68; neshodné dvojice; rozdíl 0,111 všech úplných dvojic; přesně binomicky *p* 0,077, aproximace 0,046; neúplné dvojice; bez změn test nelze spočítat; chybějící kontrolní skupina. List `McNemar`. | 8, 11. |
| [Nepovinné: Cohenovo kappa](../../quarto/kapitola_09.qmd#rozsireni-kappa) | Dva posuzovatelé (Howell): 21/30, očekávaná shoda 12,93, κ ≈ 0,47; vazba na reliabilitu. | 8f slovně. |
| [Volba postupu a zpráva](../../quarto/kapitola_09.qmd#sec-volba-postupu-09) | Rozhodovací tabulka; dvě ukázky zprávy APA (Daniels, zvládání). | 8, 12. |
| [Shrnutí](../../quarto/kapitola_09.qmd#sec-shrnuti-09) | Osm odkazovaných myšlenek. | Souhrnně 1–12. |

<a id="priklady-soubory-09"></a>

### Příklady, vizualizace a soubory

[Sešit kapitoly 9](../../data/kapitola_09.xlsx) má 23 listů: `Prehled`, sedm
výpočtových listů (`Interval_podilu`, `Dva_podily`, `Dobra_shoda`, `Tabulka`,
`Mira_souvislosti`, `McNemar`, nepovinně `Fisher`) a patnáct vstupních listů
tabulek četností (osm k výkladu, sedm ke cvičením). Žluté vstupy výpočtových listů
mají výchozí hodnoty výkladu; studenti do nich dosazují data cvičení. Simulace
k obrázku chí-kvadrát rozdělení není v sešitu. [Pokrytí cvičení](../DATA.md#kapitola-9).

Autorské modelové příklady: tabulka stresu (z kap. 5), volba čaje, věk × strategie
zvládání (podle autorovy přednášky P12), pilotní studie, poradna, učení ve
ročnících, názor na statistiku, cvičení 12. Skutečná data z literatury s uvedením
zdroje: Daniels (podle Fielda, s. 638), aspirinová studie, Prozac a anorexie
(Walsh a kol.), Berkeley (podle Howella), Howell a Huessy (cvičení 6.8), ganzfeld
(podle Cumminga). Smyšlená data jiných autorů: vyhledávání pomoci a kámen–nůžky–papír
(Howell), letní čas (Howellova ilustrace), posuzovatelé (Howell). Původní studie
čteny nebyly; v textu se citují zprostředkující učebnice bez samostatných záznamů.

| Obrázek | Didaktický účel |
|---|---|
| [Waldův a Wilsonův interval](../../quarto/kapitola_09.qmd#fig-wald-wilson) | Selhání Waldova intervalu u 0 z 15; podobnost u 10 z 20. |
| [Volba čaje](../../quarto/kapitola_09.qmd#fig-pozice) | Pozorované a očekávané četnosti. |
| [Chí-kvadrát rozdělení](../../quarto/kapitola_09.qmd#fig-chi-kvadrat) | Tvar podle stupňů volnosti; simulace statistiky odpovídá modelu; *p*-hodnota a kritická hodnota. |
| [Strategie zvládání podle věku](../../quarto/kapitola_09.qmd#fig-zvladani) | Řádkové podíly proti podílům celého souboru. |
| [Daniels](../../quarto/kapitola_09.qmd#fig-daniels) | Dva podíly s Wilsonovými intervaly a rozdíl s Newcombovým intervalem. |

Interaktivní vizualizace ke kapitole 9 nejsou; každou by bylo nutné schválit podle R65.

<a id="cviceni-09"></a>

### Cvičení a očekávané dovednosti

[Čtrnáct úloh](../../quarto/kapitola_09.qmd#sec-cviceni-09) má úplná sbalená řešení;
úlohy 13 a 14 jsou nepovinné. Kalkulačka: 1, 5, 8–12; Excel: 2, 3, 4, 6, 7.
Tolerance 0,002 u podílů a mezí, 0,02 u statistik, 0,001 u *p*-hodnot.

| Úloha | Co student samostatně dělá |
|---|---|
| 1. Kategoriální data, kódy a podíl | Rozliší úrovně, odmítne průměr kódů oboru, vyloží průměr 0/1 jako podíl, zvolí interval a předpoklady. |
| 2. Interval pro podíl a velikost výběru | Wilson pro 18/60 a 72/240, vliv čtyřnásobku *n*, interpretace a oprava výroku o 95 %. |
| 3. Když jev nenastal | Wald a Wilson pro 0/25 a 1/25; nulová šířka a záporná mez; „0 z 25 neznamená bezpečnost“. |
| 4. Antidepresivum po léčbě anorexie | Newcombe a test (*p* 0,575), interpretace nezamítnutí s randomizací, χ² = z² a podmínky. |
| 5. Kámen, nůžky, papír | Dobrá shoda (1,68; 0,432), nezávislost tahů, nesměrovost. |
| 6. Klienti poradny | Nerovnoměrné π₀ (1,92; 0,589), kdy je evidence „známá“ a kdy test homogenity. |
| 7. Strategie učení podle ročníku | Homogenita 3 × 3 (13,17; 0,010; V 0,19), řádkové podíly, upravená rezidua, proč ne devět testů, průřez vs. změna u lidí. |
| 8. Který postup? | Šest situací včetně McNemara, Fishera, dobré shody a kappa. |
| 9. Kde je chyba? | Procenta místo četností, chybějící nevýskyty, opakovaná posouzení, rezidua bez korekce, šance vs. riziko. |
| 10. Pozornost a vyrovnávací angličtina | Rizika, přirozené četnosti, RR 1,94 a OR 2,18 s referenční skupinou, φ a znaménko, výklad pro rodiče. |
| 11. Názor na statistiku před a po kurzu | Úplné dvojice, McNemar přesně (0,057) a přibližně (0,033), proč ne nezávislé skupiny. |
| 12. Malá pilotní studie | Očekávané četnosti pod 5, volba Fisherova testu (0,057), vztah k Newcombovu intervalu, zpráva. |
| 13. Nepovinně: Holmova korekce | Dvě průkazné buňky z úlohy 7. |
| 14. Nepovinně: intervaly pro poměry | RR (1,11; 3,41), OR (1,12; 4,27); nesouměrnost a hodnota 1. |

<a id="pojmy-hranice-09"></a>

### Pojmy, konvence a hranice návaznosti

Nově vysvětleno 32 pojmů [registru](../SLOVNIK.md#kapitola-09) včetně nepovinného hypergeometrického
rozdělení; „referenční skupina“ má od kapitoly 9 druhý schválený význam (doplnění R70, 2026-11-09). Značení podle R69:
$f_j$, $e_j$, $\mathrm{π}_{0j}$, $f_{jl}$, $e_{jl}$, $f_{j+}$, $f_{+l}$, $R\times S$,
$\mathrm{χ}^2$, $\mathrm{φ}$, $V$, nepovinně $\mathrm{κ}$; RR a OR jen ve zprávách a v přehledu.
Nové funkce Excelu: CHISQ.DIST.RT, CHISQ.INV.RT, CHISQ.TEST, ŘÁDKY, SLOUPCE, nepovinně
HYPGEOM.DIST, SUMIF, SMALL, LN, EXP.

**Nepovinné:** souhrn studií o telepatii, proč chí-kvadrát, Holmova korekce, výpočet Fisherova
testu, intervaly pro poměry, Simpsonův paradox, Cohenovo kappa. Další kapitola je nesmí předpokládat.

**Vysvětleno omezeně:** interval pro párový rozdíl podílů jen zmínkou; Fisherův test jen pro 2 × 2;
Yatesova korekce jen jednou větou jako výchozí nastavení softwaru (1,78 místo 2,20); zobecnění
Fisherova testu a simulační postupy pro větší tabulky jen zmínkou. **Nevyloženo:** věrohodnostní
poměr, Mantelův–Haenszelův test, loglineární modely, logistická regrese, analýza síly pro χ²,
Cohenovo w a slovní pásma, testy trendu.

## Vazby na podklady

Výběr karet pro dohledání podkladů k tématům této kapitoly vychází z tematického rozcestníku a záznamů čtení a použití. Samotný odkaz neznamená převzetí příkladu ani nové prostudování; přesné lokátory, použití, nálezy a rozsah ověření jsou v cílových kartách.

- [U01](../zdroje/U01-howell.md#priprava-09-20261109) — kap. 6, s. 137–171.
- [U03](../zdroje/U03-cumming.md#priprava-09-20261109) — kap. 13, s. 387–409.
- [U04](../zdroje/U04-openintro.md#priprava-09-20261109) — §6.1, s. 208–212.
- [U08](../zdroje/U08-navarro.md#priprava-09-20261109) — §12.1.3–12.1.5.
- [U14](../zdroje/U14-field.md#priprava-09-20261109) — kap. 16.
- [U15](../zdroje/U15-wilcox.md#priprava-09-20261109) — §15.1–15.4.
- [P12](../zdroje/P12-kategorialni-data.md#priprava-09-20261109), [P13](../zdroje/P13-chikvadrat-neparametricke.md#priprava-09-20261109), [C09](../zdroje/C09-ulohy-tyden-12.md#priprava-09-20261109) — priority a náměty.
- [Čtení pro návrh](../zdroje/HISTORIE.md#priprava-09-20261109) a [použití při tvorbě](../zdroje/HISTORIE.md#pouziti-kapitola-09).
