<a id="mapa-kapitola-07"></a>

# 7. Interval spolehlivosti pro populační průměr, jednovýběrový t-test a test ekvivalence

[Mapa celé knihy](../OSNOVA.md) · [Rozcestník zdrojů](../ZDROJE.md)

**Podklad a stav:** existující [kapitola 7](../../quarto/kapitola_07.qmd#sec-kapitola-07), karta
sestavena podle výkladu, zadání a řešení 2026-10-17. Dohodu dokládají
[R44](../rozhodnuti/kapitola-07.md#r44-rozsah-kapitoly-7),
[R45](../rozhodnuti/kapitola-07.md#r45-znaceni-kapitoly-7) a
[R46](../rozhodnuti/kapitola-07.md#r46-terminologie-kapitoly-7) s
[historií dohody](../../quarto/README.md#dohoda-kapitola-07). Vznik textu
a rozsah ověření eviduje [záznam o vytvoření](../../quarto/README.md#vytvoreni-kapitoly-7).
Soulad karty s textem zkontrolován 2026-10-18 po [cílené revizi](../../quarto/README.md#revize-kapitoly-7-20261018); schválený rozsah R44–R46 se nemění.

**Vstup:** výběrová variabilita a zkreslení (kap. 1); stupně volnosti a dělení
n − 1, krabicový graf (kap. 3); normovaný kvantil $z_p$, hodnoty zpaměti,
Q–Q graf (kap. 4); směrodatná chyba a její odhad, centrální limitní věta,
z-test, hypotézy a směr testu, p-hodnota, nezamítnutí, tři významnosti
a velikost účinku v původních jednotkách (kap. 6). Nepovinné části kapitol 3,
5 a 6 se nepředpokládají.

**Cíle:** bodový a intervalový odhad, 95 % jako dlouhodobé pokrytí postupu;
interval při známé i neznámé σ ručně a v Excelu s předpoklady; vlivy na šířku
a odlišení přesnosti od nepřítomnosti zkreslení; jednovýběrový t-test se
dvěma kroky závěru; vztah 95% intervalu a oboustranného testu; zdůvodnění
hranic ekvivalence a rozhodnutí pomocí 90% intervalu; čtyři kombinace výsledků
testu rozdílu a testu ekvivalence.

**Čitelnost ([R38](../rozhodnuti/postupy-a-dokumentace.md#r38-citelnost-textu)):** každý hlavní oddíl
začíná otázkou a návazností; závěrečné [Shrnutí](../../quarto/kapitola_07.qmd#sec-shrnuti-07)
má osm myšlenek s odkazy. Dva bloky „Častý omyl“ (95% pravděpodobnost pro μ;
„nezamítli jsme, tedy je to stejné“) a dvě „Připomenutí“ (z-test, stupně
volnosti). Povinná část má přibližně 8 700 slov (počítáno bez rovnic, bez cvičení).

### Skutečný obsah oddílů

Všechny části jsou **vysvětleny**, pokud není uvedeno „nepovinné“; poslední
sloupec určuje konkrétní **procvičení**.

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Co víme po z-testu](../../quarto/kapitola_07.qmd#sec-co-vime-po-z-testu) | Připomenutí z-testu kap. 6 (m = 46, n = 25). Otázka „o kolik“. Oddělení modelového předpokladu σ = 10 od výběrové s = 10. | 1d, 5d. |
| [Bodový a intervalový odhad](../../quarto/kapitola_07.qmd#sec-bodovy-intervalovy), [obrácení úvahy](../../quarto/kapitola_07.qmd#sec-obraceni-uvahy) | Bodový odhad, výběrová chyba, intervalový odhad; souměrnost vzdálenosti 3,92 bodu mezi m a μ. | 2. |
| [Výpočet intervalu](../../quarto/kapitola_07.qmd#sec-interval-z-vypocet) | m ± $z_{0{,}975}$ σ_m = (42,08; 49,92); mezní chyba odhadu, meze, hladina spolehlivosti odlišená od hladiny významnosti; věcné čtení. | 1. |
| [Co znamená „95 %“](../../quarto/kapitola_07.qmd#sec-co-znamena-95) | Výukový model μ = 47, σ = 10; 100 výběrů po 25: stejná šířka 7,84, mění se poloha; 94 ze 100 zachycených; pokrytí jako vlastnost postupu; omyl o 95% pravděpodobnosti. | 2. |
| [Předpoklady](../../quarto/kapitola_07.qmd#sec-interval-predpoklady) | Nezávislý náhodný výběr, normální populace, známá σ; CLV pro přibližnou platnost; interval nezachycuje zkreslení výběru ani systematickou chybu měření. | 2f, 3d. |
| [Šířka a přesnost](../../quarto/kapitola_07.qmd#sec-sirka-intervalu) | Šířky 6,58/7,84/10,30 pro 90/95/99 %; dvojnásobná σ; čtyřnásobný výběr. Přesnost versus správnost (velký výběr dobrovolníků). | 3. |
| [t-rozdělení](../../quarto/kapitola_07.qmd#sec-t-rozdeleni) | Proč nestačí dosadit s; simulace 10 000 výběrů po pěti: 4,8 % versus 12,4 % mimo ±1,96. Studentovo rozdělení statistiky (ne průměru), stupně volnosti n − 1, těžší chvosty, bez hranice n > 30. Značení $t_{p\,(v)}$, T.INV. | 4. |
| [Nepovinné: proč s zvětšuje chvosty](../../quarto/kapitola_07.qmd#rozsireni-tezsi-chvosty) | s menší než σ asi v 59 % výběrů po pěti; nezávislost m a s jen u normální populace. | Bez cvičení. |
| [Interval s t-kvantilem](../../quarto/kapitola_07.qmd#sec-interval-t) | Pět kroků: (41,87; 50,13); list `Interval_t`; pravý panel simulace (šířky 5,6–12,0, 96 ze 100); teoretické pokrytí chybného postupu 93,8/91,8/87,8 %; odolnost, prohlídka dat (Howell, PDI), důležitost nezávislosti. | 4, 5, 7d. |
| [Jednovýběrový t-test](../../quarto/kapitola_07.qmd#sec-t-test) | Šest kroků s hypotézami z kap. 6: t = −2, p-hodnota 0,028 (jednostranně), 0,057 (oboustranně); kritická hodnota −1,711; list `T_test` s T.DIST, T.DIST.2T, T.INV.2T. PDI (Howell): t ≈ 2,45, p-hodnota 0,017, (100,75; 107,50), nečekaný směr, výhoda oboustranného testu. | 6, 7. |
| [Interval a p-hodnota](../../quarto/kapitola_07.qmd#sec-interval-a-p) | Funkce p-hodnoty a vnitřek intervalu jako množina nezamítnutých hodnot; platí pro odpovídající test; hraniční případ p = 0,05 podle pravidla p ≤ α a odlišení přesné meze od zaokrouhlení; co interval sděluje navíc; jednostranná mez 49,42 = horní mez 90% intervalu. | 1c, 2e, 8. |
| [Pásmo ekvivalence](../../quarto/kapitola_07.qmd#sec-pasmo-ekvivalence) | Online verze testu; nejmenší věcně důležitý rozdíl; hranice μ₀ ± Δ; zdůvodnění podle Lakense et al. (2018); posun o 3 body mění podíl pod 40 z 15,9 % na 24,2 % / 9,7 %; volba předem; nesouměrné hranice možné. | 9. |
| [Test ekvivalence](../../quarto/kapitola_07.qmd#sec-test-ekvivalence) | Obrácené hypotézy, obrázek hypotéz; TOST (oba testy musí zamítnout); proč celý test na hladině 0,05; proč 90% interval (Lakens, 2017, pozn. 2); dva intervaly s odlišnou funkcí. | 10. |
| [Čtyři kombinace](../../quarto/kapitola_07.qmd#sec-ctyri-kombinace) | Studie A–E s odděleným testem rozdílu, testem ekvivalence a závěrem vůči hranicím; statisticky, ale ne věcně významný výsledek (B); omyl „nezamítli, tedy stejné“; neprokázaná ekvivalence nedokládá důležitý rozdíl. | 10c, 11, 12b. |
| [Nepovinné: p-hodnoty TOST](../../quarto/kapitola_07.qmd#rozsireni-tost-vypocet) | Studie B: t = 3 (0,0014) a t = −9; výsledná je větší; studie A 0,69; list `Ekvivalence` B22:B26. | 13. |
| [Co ekvivalence dokládá a sdělení](../../quarto/kapitola_07.qmd#sec-sdeleni-07) | Jen průměr vůči pevné normě; ne zaměnitelnost, individuální shodu ani reliabilitu; pevnost normy (Howell, s. 195); závislost na hranicích; hranice podle dat. Ukázka zprávy APA s 95% a 90% intervalem a hranicemi. | 12. |
| [Nepovinné: neinferiorita](../../quarto/kapitola_07.qmd#rozsireni-neinferiorita) | Jednostranný test vůči jedné hranici; směr škály. | 14. |
| [Shrnutí](../../quarto/kapitola_07.qmd#sec-shrnuti-07) | Osm odkazovaných myšlenek. | Souhrnně 1–12. |

### Příklady, vizualizace a soubory

[Sešit kapitoly 7](../../data/kapitola_07.xlsx) má 19 listů: `Prehled`, čtyři
výpočtové listy (`Interval_z`, `Interval_t`, `T_test`, `Ekvivalence`), tři
vstupní listy výkladu (`Pozornost`, `PDI`, `Studie_ekv`), simulovaný list
`Sim_intervaly` a deset vstupních listů cvičení. [Pokrytí cvičení](../DATA.md#kapitola-7).

Průběžný příklad pozornosti je autorský model z kapitol 4 a 6; výukový model
μ = 47 pro simulaci a pět studií online verze jsou autorské. Souhrny PDI
přebírá Howell (s. 186–188) ze studie Nurcomba et al. (1984). Zdůvodnění
hranic, TOST a čtyři kombinace vycházejí z Lakense (2017) a Lakense,
Scheela a Isagera (2018), obrázek čtyř kombinací je vlastní, inspirovaný
autorovým schématem a jejich obr. 2. Všechna cvičení jsou autorská; úloha 1
používá čísla úlohy 9 kapitoly 6.

| Obrázek | Didaktický účel |
|---|---|
| [Opakované intervaly](../../quarto/kapitola_07.qmd#fig-opakovane-intervaly) | Stejná šířka při známé σ, kolísající šířka s výběrovou s; pokrytí jako vlastnost postupu. |
| [Šířka intervalu](../../quarto/kapitola_07.qmd#fig-sirka-intervalu) | Hladina spolehlivosti a velikost výběru; cena přesnosti. |
| [t-rozdělení](../../quarto/kapitola_07.qmd#fig-t-rozdeleni) | Těžší chvosty po dosazení s; blížení normálnímu modelu. |
| [Funkce p-hodnoty](../../quarto/kapitola_07.qmd#fig-p-funkce) | Vnitřek intervalu jako množina nezamítnutých hodnot; na mezích p = α a zamítáme. |
| [Posun a podíl pod 40](../../quarto/kapitola_07.qmd#fig-pasmo-pouziti) | Zdůvodnění hranic zamýšleným použitím. |
| [Hypotézy ekvivalence](../../quarto/kapitola_07.qmd#fig-hypotezy-ekvivalence) | Dvoudílná nulová hypotéza a dva jednostranné testy. |
| [Čtyři kombinace](../../quarto/kapitola_07.qmd#fig-ctyri-kombinace) | 90% a 95% intervaly souběžně vůči pásmu. |
| [Q–Q graf úzkosti](../../quarto/kapitola_07.qmd#fig-qq-uzkost-07) | Vzorová konstrukce podle kap. 4 uvnitř sbaleného řešení 7d; omezení posouzení normality z 20 hodnot. |

### Cvičení a očekávané dovednosti

[Čtrnáct úloh](../../quarto/kapitola_07.qmd#sec-cviceni-07) má úplná sbalená řešení.
Úlohy 1–3, 6, 8, 11 a 12 vyžadují kalkulačku, úlohy 4, 5, 7, 9 a 10 Excel;
meze na dvě desetinná místa, p-hodnoty na tři. Úlohy 13 a 14 jsou nepovinné.

| Úloha | Co student samostatně dělá |
|---|---|
| 1. Interval při známé σ | 95% (99,60; 109,40) a 99% (98,06; 110,94) interval; soulad s p-hodnotou 0,072 z kap. 6; předpoklad σ. |
| 2. Co znamená „95 %“ | Posoudí šest výroků (pravděpodobnost pro μ, jednotlivci, pokrytí, replikace, nezamítnuté hodnoty, úzký interval a zkreslení). |
| 3. Šířka a přesnost | Šířky 7,84/3,92, 6,58/10,30; 400 studentů pro poloviční šířku; velký výběr dobrovolníků. |
| 4. Kvantily t | T.INV pro 4–99 stupňů volnosti; souměrnost; omyl „od 30 je to normální“. |
| 5. Interval z dat | Deset hodnot: m = 12,6, s = 2,221, (11,01; 14,19); srovnání s 1,96; populace a předpoklady. |
| 6. t-test ze souhrnů | t = 2, 15 stupňů volnosti, p-hodnota 0,064; (29,84; 34,96); rozdíl vůči normě není změna způsobená kurzem; dodatečná změna směru. |
| 7. t-test v Excelu | Dvacet hodnot: t ≈ 3,15, p-hodnota 0,005, (20,74; 23,66); Q–Q graf s obrázkem v řešení, omezení posouzení normality a nezávislost. |
| 8. Interval a p-hodnota | Rozhodnutí z intervalů; hraniční případ; jednostranný test a 90% interval; přesnost. |
| 9. Hranice ekvivalence | Podíly nad 25 bodů při posunech; volba ±1 podle požadavku; kritika benchmarku (posun o 3 body: podíl 4,8 % → 12,2 %), hranic přizpůsobených týmž datům a zdůvodnění očekávaným směrem; oddělená pilotáž pro budoucí studii. |
| 10. Test ekvivalence | 150 studentů: 90% (24,79; 26,41), ekvivalence doložena, test rozdílu nezamítá; 30 studentů: nerozhodné. |
| 11. Čtyři kombinace | Pět zadaných studií P–T zařadí a interpretuje. |
| 12. Chybné postupy | Hranice podle výsledku; nezamítnutí jako shoda; ekvivalence průměru jako zaměnitelnost verzí. |
| 13. Nepovinně: p-hodnoty TOST | 0,002 (150 studentů) a 0,106 (30 studentů); shoda s intervalem. |
| 14. Nepovinně: neinferiorita | Dolní mez 47,03 nad 47; obrácený směr škály. |

### Pojmy, konvence a hranice návaznosti

Nově je vysvětleno 15 pojmů [registru](../SLOVNIK.md#kapitola-07). Značení podle
R45: $t_{p\,(v)}$, testová statistika *t*, Δ a μ₀ ± Δ; stupně volnosti ve výkladu
slovy. Nové funkce Excelu: T.INV, T.DIST, T.DIST.2T, T.INV.2T; dále ODMOCNINA,
ABS, KDYŽ, A, MAX, NORM.S.INV, NORM.DIST, PRŮMĚR, SMODCH.VÝBĚR.S z dřívějších kapitol.
Od 2026-10-31 se *p*-hodnota píše s kurzivním *p* podle
[R56](../rozhodnuti/kapitola-06.md#r56-p-hodnota-cohen) (text, tabulky a graf `p-funkce`);
jiný obsah kapitoly 7 se tím nezměnil.

**Nepovinné:** proč s zvětšuje chvosty, výpočet *p*-hodnot TOST, neinferiorita.
Další kapitola je nesmí předpokládat.

**Vysvětleno omezeně:** odolnost t-postupů vůči nenormalitě (bez simulace pro
zešikmené populace); funkce Excelu A je použita jen na listu `Ekvivalence`, bez řádku
v přehledu funkcí (MAX je vyložena již v kap. 3). **Pouze zmíněno:** jiné postupy testu ekvivalence než TOST,
nesouměrné hranice, porovnání dvou odhadů (norma z malého výběru), test shody
týchž lidí oběma verzemi. **Nevyloženo:** párový a dvouvýběrový t-test,
překrývání intervalů, interval pro podíl, bootstrap, bayesovské intervaly,
plánování velikosti výběru, test minimálního účinku, standardizované hranice.

## Vazby na podklady

- [U01](../zdroje/U01-howell.md#u01) — kap. 7, s. 181–196 (t-rozdělení, PDI, interval, s. 195 normy); [rozpor komentáře o chvostech s tabulkou a Q–Q grafem](../zdroje/U01-howell.md#revize-07-20261018) se nepřebírá.
- [U03](../zdroje/U03-cumming.md#u03) — kap. 5 a s. 151–152.
- [E02](../zdroje/E02-lakens-2017.md#e02-lakens-2017) — TOST, pozn. 2, jednovýběrový test.
- [E03](../zdroje/E03-lakens-2018.md#e03-lakens-2018) — zdůvodnění hranic, čtyři kombinace, Discussion.
- [P07](../zdroje/P07-usuzovani-intervaly.md#p07) a [P08](../zdroje/P08-prumery.md#p08) — dosavadní priority autora; nepřebírají se nálezy uvedené v kartách.
- [C05](../zdroje/C05-ulohy-tyden-4.md#c05) a [C08](../zdroje/C08-ulohy-tyden-9.md#c08) — náměty cvičení (vlivy na šířku, interpretace, kvantily); úlohy nejsou převzaty.
- [Čtení pro návrh](../zdroje/HISTORIE.md#priprava-07-20261017) a [použití při tvorbě](../zdroje/HISTORIE.md#pouziti-kapitola-07).

**Typografická úprava 2026-10-30:** všechny tabulky kapitoly včetně zadání
a řešení mají automatické označení a název. Zachována existující ID,
vysvětlující části dlouhých popisků jsou v poznámkách pod tabulkami.
Kontrola souladu se zde popsaným obsahem byla omezena na tabulky a jejich
okolí; cíle, návaznosti, hodnoty, zadání a řešení se nemění. Společnou sazbu
určuje [R54](../rozhodnuti/spolecne-konvence.md#r54-sazba-tabulek-pdf).
