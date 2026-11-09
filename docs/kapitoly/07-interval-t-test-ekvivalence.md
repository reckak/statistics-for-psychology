<a id="mapa-kapitola-07"></a>

# 7. Interval spolehlivosti pro populační průměr, jednovýběrový t-test a test ekvivalence

[Mapa celé knihy](../OSNOVA.md) · [Rozcestník zdrojů](../ZDROJE.md)

**Pracovní PDF 2026-11-01:** přidán a ověřen ruční export podle
[provozního návodu](../PROVOZ.md#ruční-pdf-vybrané-kapitoly), včetně všech
14 zadání a samostatného oddílu řešení s obousměrnými odkazy. Zkontrolována
sazba celé kapitoly v PDF; nejde o novou obsahovou revizi této mapy.

**Podklad a stav:** existující [kapitola 7](../../quarto/kapitola_07.qmd#sec-kapitola-07), karta
sestavena podle výkladu, zadání a řešení 2026-10-17. Dohodu dokládají
[R44](../rozhodnuti/kapitola-07.md#r44-rozsah-kapitoly-7),
[R45](../rozhodnuti/kapitola-07.md#r45-znaceni-kapitoly-7) a
[R46](../rozhodnuti/kapitola-07.md#r46-terminologie-kapitoly-7) s
[historií dohody](../../quarto/README.md#dohoda-kapitola-07). Vznik textu
a rozsah ověření eviduje [záznam o vytvoření](../../quarto/README.md#vytvoreni-kapitoly-7).
Soulad karty s textem zkontrolován 2026-10-18 po [cílené revizi](../../quarto/README.md#revize-kapitoly-7-20261018); schválený rozsah R44–R46 se nemění.

**Kontrola 2026-11-01:** po odborné a technické revizi zpřesněna závislost
kritického průměru na výběrové s, plynulost slučitelnosti u mezí intervalu,
relativní nejistota normy s odkazem na kapitolu 8, řešení 2b a hraniční
pravidlo 14c. Přehledy zachovávají podmínku μ = μ₀ pro t-rozdělení.
Sešit zobrazuje velmi malou kladnou p-hodnotu v `Ekvivalence!B25` jako
„< 0,001“; hodnoty a vzorce se nemění. Cíle, procvičení a povinný rozsah
zůstávají zachovány. [Záznam revize](../../quarto/README.md#revize-07-20261101).

**Revize 2026-11-09 ([R66](../rozhodnuti/spolecne-konvence.md#r66-kurziva-a-et-al), [R67](../rozhodnuti/kapitola-07.md#r67-revize-kapitoly-7)):**
zapracovány autorovy redakční úpravy a připomínky. Výběrová *s* průběžného příkladu je 11;
obecný kvantil $z_{1-\mathrm{α}/2}$ a volba hladiny spolehlivosti; opravené tvrzení o odolnosti
(souměrné těžké chvosty zvyšují pokrytí, šikmost je nesouměrná) a nové nepovinné rozšíření
s vlastní simulací podle Wilcoxe; pododdíl „Tři cesty k témuž rozhodnutí“ podle snímku 20 P08;
obrázky jednostranných intervalů a zrcadla intervalu; devět studií ve čtyřech kombinacích;
rozšíření o noninferioritě, superioritě a příbuzných otázkách na příkladu tréninku; úloha 14
v témže kontextu. Soulad karty s textem zkontrolován 2026-11-09.

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
volnosti). Povinná část měla při vytvoření přibližně 8 700 slov (počítáno bez rovnic, bez cvičení); revize 2026-11-09 přidala hlavně pododdíl o třech cestách k rozhodnutí a výklad jednostranné meze, nepovinná rozšíření nepočítaje.

### Skutečný obsah oddílů

Všechny části jsou **vysvětleny**, pokud není uvedeno „nepovinné“; poslední
sloupec určuje konkrétní **procvičení**.

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Co víme po z-testu](../../quarto/kapitola_07.qmd#sec-co-vime-po-z-testu) | Připomenutí z-testu kap. 6 (m = 46, n = 25). Otázka „o kolik“. Oddělení modelového předpokladu σ = 10 od výběrové s = 11. | 1d, 5d. |
| [Bodový a intervalový odhad](../../quarto/kapitola_07.qmd#sec-bodovy-intervalovy), [obrácení úvahy](../../quarto/kapitola_07.qmd#sec-obraceni-uvahy) | Bodový odhad, výběrová chyba, intervalový odhad; souměrnost vzdálenosti 3,92 bodu mezi m a μ. | 2. |
| [Výpočet intervalu](../../quarto/kapitola_07.qmd#sec-interval-z-vypocet) | m ± $z_{0{,}975}$ σ_m = (42,08; 49,92); volba hladiny spolehlivosti $1-\mathrm{α}$ a obecný kvantil $z_{1-\mathrm{α}/2}$ (jednostranná mez $z_{1-\mathrm{α}}$); mezní chyba odhadu, meze, hladina spolehlivosti odlišená od hladiny významnosti; věcné čtení. | 1, 3b. |
| [Co znamená „95 %“](../../quarto/kapitola_07.qmd#sec-co-znamena-95) | Výukový model μ = 47, σ = 10; 100 výběrů po 25: stejná šířka 7,84, mění se poloha; 94 ze 100 zachycených; pokrytí jako vlastnost postupu; omyl o 95% pravděpodobnosti. | 2. |
| [Předpoklady](../../quarto/kapitola_07.qmd#sec-interval-predpoklady) | Nezávislý náhodný výběr, normální populace, známá σ; CLV pro přibližnou platnost; interval nezachycuje zkreslení výběru ani systematickou chybu měření. | 2f, 3d. |
| [Šířka a přesnost](../../quarto/kapitola_07.qmd#sec-sirka-intervalu) | Šířky 6,58/7,84/10,30 pro 90/95/99 %; dvojnásobná σ; čtyřnásobný výběr. Přesnost versus správnost (velký výběr dobrovolníků). | 3. |
| [t-rozdělení](../../quarto/kapitola_07.qmd#sec-t-rozdeleni) | Proč nestačí dosadit s; simulace 10 000 výběrů po pěti: 4,8 % versus 12,4 % mimo ±1,96. Studentovo rozdělení statistiky (ne průměru), stupně volnosti n − 1, těžší chvosty, bez hranice n > 30. Značení $t_{p\,(v)}$, T.INV. | 4. |
| [Nepovinné: proč s zvětšuje chvosty](../../quarto/kapitola_07.qmd#rozsireni-tezsi-chvosty) | s menší než σ asi v 59 % výběrů po pěti; nezávislost m a s jen u normální populace. | Bez cvičení. |
| [Interval s t-kvantilem](../../quarto/kapitola_07.qmd#sec-interval-t) | Pět kroků: (41,46; 50,54); rozdíl šířky vůči z-intervalu rozložen na kvantil (0,42) a vyšší s (0,83); list `Interval_t`; pravý panel simulace (šířky 5,6–12,0, 96 ze 100); teoretické pokrytí chybného postupu 93,8/91,8/87,8 %; odolnost podle druhu odchylky (šikmost × chvosty), prohlídka dat (Howell, PDI), důležitost nezávislosti. | 4, 5, 7d. |
| [Nepovinné: odolnost *t*-testu](../../quarto/kapitola_07.qmd#rozsireni-odolnost-t) | Čtyři typy populací podle Wilcoxe (2017, s. 111–118, 162–166); vlastní simulace 7 tvarů × n = 10, 25, 50, 100 (pokrytí, skutečná hladina obou jednostranných testů, síla); nominální a skutečná hladina, liberální a konzervativní test; šikmost doprava: „menší“ liberální, „větší“ konzervativní; těžké souměrné chvosty: konzervativní, nízká síla; srovnání s Wilcoxovými čísly. | Bez cvičení. |
| [Jednovýběrový t-test](../../quarto/kapitola_07.qmd#sec-t-test) | Šest kroků s hypotézami z kap. 6 (směrová hypotéza předem, hranice μ = μ₀): t ≈ −1,818, p-hodnota 0,041 (jednostranně), 0,082 (oboustranně); kritická hodnota −1,711 a kritický průměr 46,24; věcná interpretace s 90% intervalem (42,24; 49,76); rozklad rozdílu p-hodnot vůči z-testu; list `T_test` s T.DIST, T.DIST.2T, T.INV.2T. PDI (Howell, Bayleyové škály): zdůvodnění oboustranného testu intervencí u poloviny matek a jinou normativní populací; t ≈ 2,45, p-hodnota 0,017, (100,75; 107,50), nečekaný směr. | 6, 7. |
| [Interval a p-hodnota](../../quarto/kapitola_07.qmd#sec-interval-a-p) | Funkce p-hodnoty a vnitřek intervalu jako množina nezamítnutých hodnot (striktně uvnitř); platí pro odpovídající test; hraniční případ p = 0,05 podle pravidla p ≤ α a odlišení přesné meze 50,541 od zaokrouhlení; tři cesty k rozhodnutí (oblast nezamítnutí kolem μ₀ jako zrcadlo intervalu kolem m, tabulka podle P08 sn. 20 pro oboustranný a oba jednostranné testy); co interval sděluje navíc; jednostranná mez 49,76 = horní mez 90% intervalu, obecně $1-2\mathrm{α}$; proč se místo jednostranné meze uvádí centrální interval. | 1c, 2e, 8. |
| [Pásmo ekvivalence](../../quarto/kapitola_07.qmd#sec-pasmo-ekvivalence) | Online verze testu; nejmenší věcně důležitý rozdíl; hranice μ₀ ± Δ; zdůvodnění podle Lakense et al. (2018); posun o 3 body mění podíl pod 40 z 15,9 % na 24,2 % / 9,7 % (nově uvedeno i v textu před obrázkem); volba předem; nesouměrné hranice možné. | 9. |
| [Test ekvivalence](../../quarto/kapitola_07.qmd#sec-test-ekvivalence) | Obrácené hypotézy, obrázek hypotéz; TOST (oba testy musí zamítnout); proč celý test na hladině 0,05; proč 90% interval (Lakens, 2017, pozn. 2); dva intervaly s odlišnou funkcí. | 10. |
| [Čtyři kombinace](../../quarto/kapitola_07.qmd#sec-ctyri-kombinace) | Studie A–I s odděleným testem rozdílu, testem ekvivalence a závěrem vůči hranicím; F přes všechna tři pásma (průměr 50, p = 1, ekvivalence nedoložena), G, H, I zrcadla B, D, E nad normou; statisticky, ale ne věcně významný výsledek (B, G); neprůkazné výsledky (A, F); omyl „nezamítli, tedy stejné“; neprokázaná ekvivalence nedokládá důležitý rozdíl. | 10c, 11, 12b. |
| [Nepovinné: p-hodnoty TOST](../../quarto/kapitola_07.qmd#rozsireni-tost-vypocet) | Studie B: t = 3 (0,0014) a t = −9; výsledná je větší; studie A 0,69; list `Ekvivalence` B22:B26. | 13. |
| [Co ekvivalence dokládá a sdělení](../../quarto/kapitola_07.qmd#sec-sdeleni-07) | Jen průměr vůči pevné normě; ne zaměnitelnost, individuální shodu ani reliabilitu; pevnost normy (Howell, s. 195); závislost na hranicích; hranice podle dat. Ukázka zprávy APA s 95% a 90% intervalem a hranicemi. | 12. |
| [Nepovinné: noninferiorita a superiorita](../../quarto/kapitola_07.qmd#rozsireni-noninferiorita) | Trénink pozornosti a relaxační program vůči normě 50, Δ = 3: superiorita, nonsuperiorita, noninferiorita, inferiorita v tabulce s hypotézami a rozhodující mezí 90% intervalu; ekvivalence = noninferiorita + nonsuperiorita; Lakens (kniha, kap. 9) a test minimálního účinku; směr škály; porovnání s normou není doklad účinku. Stará kotva `#rozsireni-neinferiorita` zachována. | 14. |
| [Shrnutí](../../quarto/kapitola_07.qmd#sec-shrnuti-07) | Osm odkazovaných myšlenek. | Souhrnně 1–12. |

### Příklady, vizualizace a soubory

**Doprovodný scénář (2026-11-09):** [mluvený text k prezentaci](../../presentations/kapitola_07_interval_t_test_a_ekvivalence_scenar.txt)
pokrývá snímky 1–32 místního PPTX, bez závěrečného procvičování a nepovinných rozšíření;
[podklady a kontroly](../../presentations/kapitola_07_interval_t_test_a_ekvivalence_scenar_podklady.md).
Jde o komentář k prezentaci, rozsah kapitoly se nemění. Na následnou žádost téhož dne
vytvořena místní nahrávka hlasem Adam (38:43, 32 značek snímků); technicky ověřena,
bez skutečného poslechu. Podrobnosti a omezení jsou v průvodním dokumentu.

[Sešit kapitoly 7](../../data/kapitola_07.xlsx) má 19 listů (stav 2026-11-09): `Prehled`, čtyři
výpočtové listy (`Interval_z`, `Interval_t`, `T_test`, `Ekvivalence`), tři
vstupní listy výkladu (`Pozornost`, `PDI`, `Studie_ekv`), simulovaný list
`Sim_intervaly` a deset vstupních listů cvičení. [Pokrytí cvičení](../DATA.md#kapitola-7).

Průběžný příklad pozornosti je autorský model z kapitol 4 a 6; výukový model
μ = 47 pro simulaci a devět studií online verze jsou autorské. Souhrny PDI
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
| [Zrcadlo intervalu](../../quarto/kapitola_07.qmd#fig-zrcadlo-intervalu) | Oblast nezamítnutí kolem μ₀ a interval kolem m sdílejí mezní chybu. |
| [Jednostranné intervaly](../../quarto/kapitola_07.qmd#fig-jednostranne-intervaly) | 95% a 90% centrální interval a horní jednostranná 95% mez vůči normě. |
| [Čtyři kombinace](../../quarto/kapitola_07.qmd#fig-ctyri-kombinace) | 90% a 95% intervaly devíti studií souběžně vůči pásmu; osa popsána jako skór, ne populační průměr. |
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
| 10. Test ekvivalence | 150 studentů: 90% (24,79; 26,41), ekvivalence doložena, test rozdílu nezamítá; 30 studentů: neprůkazné. |
| 11. Čtyři kombinace | Pět zadaných studií P–T zařadí a interpretuje. |
| 12. Chybné postupy | Hranice podle výsledku; nezamítnutí jako shoda; ekvivalence průměru jako zaměnitelnost verzí. |
| 13. Nepovinně: p-hodnoty TOST | 0,002 (150 studentů) a 0,106 (30 studentů); shoda s intervalem. |
| 14. Nepovinně: noninferiorita | Kratší trénink vůči referenční hodnotě 55: dolní mez 52,03 nad 52, p-hodnota 0,046; obrácený směr škály u počtu chyb. |

### Pojmy, konvence a hranice návaznosti

Nově je vysvětleno 15 pojmů [registru](../SLOVNIK.md#kapitola-07); od 2026-11-09 navíc v nepovinných rozšířeních noninferiorita (dříve neinferiorita), superiorita, nonsuperiorita, inferiorita, nominální a skutečná hladina významnosti a liberální a konzervativní test ([R67](../rozhodnuti/kapitola-07.md#r67-revize-kapitoly-7)). Značení podle
R45: $t_{p\,(v)}$, testová statistika *t*, Δ a μ₀ ± Δ; stupně volnosti ve výkladu
slovy. Nové funkce Excelu: T.INV, T.DIST, T.DIST.2T, T.INV.2T; dále ODMOCNINA,
ABS, KDYŽ, A, MAX, NORM.S.INV, NORM.DIST, PRŮMĚR, SMODCH.VÝBĚR.S z dřívějších kapitol.
Od 2026-10-31 se *p*-hodnota píše s kurzivním *p* podle
[R56](../rozhodnuti/kapitola-06.md#r56-p-hodnota-cohen) (text, tabulky a graf `p-funkce`);
jiný obsah kapitoly 7 se tím nezměnil.

**Nepovinné:** proč *s* zvětšuje chvosty, odolnost *t*-testu vůči nenormalitě, výpočet *p*-hodnot TOST, noninferiorita, superiorita a příbuzné otázky.
Další kapitola je nesmí předpokládat.

**Vysvětleno omezeně:** odolnost t-postupů vůči nenormalitě v povinné části jen slovně (simulace a tabulka v nepovinném rozšíření); funkce Excelu A je použita jen na listu `Ekvivalence`, bez řádku
v přehledu funkcí (MAX je vyložena již v kap. 3). **Pouze zmíněno:** jiné postupy testu ekvivalence než TOST,
nesouměrné hranice, porovnání dvou odhadů (norma z malého výběru), test shody
týchž lidí oběma verzemi. **Nevyloženo:** párový a dvouvýběrový t-test,
překrývání intervalů, interval pro podíl, bootstrap, bayesovské intervaly,
plánování velikosti výběru, standardizované hranice, robustní metody (ořezaný průměr, bootstrap). Test minimálního účinku je jen zmíněn v nepovinném rozšíření.

## Vazby na podklady

- [U01](../zdroje/U01-howell.md#u01) — kap. 7, s. 181–196 (t-rozdělení, PDI, interval, s. 195 normy); [rozpor komentáře o chvostech s tabulkou a Q–Q grafem](../zdroje/U01-howell.md#revize-07-20261018) se nepřebírá.
- [U03](../zdroje/U03-cumming.md#u03) — kap. 5 a s. 151–152.
- [E02](../zdroje/E02-lakens-2017.md#e02-lakens-2017) — TOST, pozn. 2, jednovýběrový test.
- [E03](../zdroje/E03-lakens-2018.md#e03-lakens-2018) — zdůvodnění hranic, čtyři kombinace, Discussion.
- [U16](../zdroje/U16-lakens-kniha.md#u16-lokatory) a [D13](../zdroje/D13-kline.md#d13) — tematické odkazy doplněné 2026-10-31 (interpretace jednoho intervalu, omyly o intervalech, kap. 9 o ekvivalenci). Od 2026-11-09 U16 kap. 9 (test noninferiority, oddíl Minimum Effect Tests) cituje rozšíření o noninferioritě.
- [U15](../zdroje/U15-wilcox.md#u15) — §4.6 (s. 111–118) a §5.5 (s. 162–166): typy populací, skutečná hladina a síla; podklad nepovinného rozšíření o odolnosti, čísla vlastní simulací.
- [P07](../zdroje/P07-usuzovani-intervaly.md#p07) a [P08](../zdroje/P08-prumery.md#p08) — dosavadní priority autora; nepřebírají se nálezy uvedené v kartách. P08 sn. 20 (vztah kritické hodnoty, p-hodnoty a intervalu) je od 2026-11-09 podkladem tabulky „Tři cesty k témuž rozhodnutí“, se zpřesněním hraniční rovnosti z karty.
- [C05](../zdroje/C05-ulohy-tyden-4.md#c05) a [C08](../zdroje/C08-ulohy-tyden-9.md#c08) — náměty cvičení (vlivy na šířku, interpretace, kvantily); úlohy nejsou převzaty.
- [Čtení pro návrh](../zdroje/HISTORIE.md#priprava-07-20261017) a [použití při tvorbě](../zdroje/HISTORIE.md#pouziti-kapitola-07).

**Typografická úprava 2026-10-30:** všechny tabulky kapitoly včetně zadání
a řešení mají automatické označení a název. Zachována existující ID,
vysvětlující části dlouhých popisků jsou v poznámkách pod tabulkami.
Kontrola souladu se zde popsaným obsahem byla omezena na tabulky a jejich
okolí; cíle, návaznosti, hodnoty, zadání a řešení se nemění. Společnou sazbu
určuje [R54](../rozhodnuti/spolecne-konvence.md#r54-sazba-tabulek-pdf).
