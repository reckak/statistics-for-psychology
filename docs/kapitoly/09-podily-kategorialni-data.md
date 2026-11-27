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
Autor kapitolu prošel a připomínkoval 2026-11-16; revizi podle jeho připomínek dokládá [R81](../rozhodnuti/kapitola-09.md#r81-revize-kapitoly-9) a [záznam o revizi](../../quarto/README.md#revize-kapitoly-9-2026-11-16). Nepovinné odvození Wilsonova intervalu přidáno 2026-11-17 ([doplnění R68](../rozhodnuti/kapitola-09.md#r68-doplneni-2026-11-17), [záznam](../../quarto/README.md#odvozeni-wilsonova-intervalu-20261117)). Soulad karty s textem zkontrolován 2026-11-16; 2026-11-17 jen pro pododdíl o Wilsonově intervalu a nové rozšíření.

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
buněk; předpoklady, Fisherův exaktní test a simulovaná *p*-hodnota; rozdíl podílů, poměr rizik, poměr
šancí, φ a Cramérovo V; McNemarův a znaménkový test a sdělení ve dvou krocích.

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
| [Jak přesně odhadneme podíl](../../quarto/kapitola_09.qmd#sec-interval-podilu) | 10 z 20 (test z kap. 6): Wald (0,28; 0,72) jen jako mezikrok, selhání u 0 z 15 a zešikmení u okrajů; Wilsonův interval vzorcem (střed, polovina šířky; 0,30–0,70; 0 z 15: 0–0,20; 40 z 80: 0,39–0,61); předpoklady a procenta; přesně spočítané pokrytí Waldova a Wilsonova intervalu pro *n* = 10, 20, 50 a 100 a podíl Waldových intervalů mimo 0–1 (obrázek). List `Interval_podilu`. Skórový test ($z=2{,}58$, *p*-hodnota 0,0098) a vztah k binomickému testu kap. 6 (0,014) formulací R68. | 2, 3. |
| [Nepovinné: odvození Wilsonova intervalu](../../quarto/kapitola_09.qmd#rozsireni-wilson-odvozeni) | Od podmínky $\lvert p-\mathrm{π}\rvert\le z\sqrt{\mathrm{π}(1-\mathrm{π})/n}$ přes umocnění ke kvadratické nerovnici; obrázek obou stran pro 10 z 20; připomenutý vzorec pro kořeny ($A$, $B$, $C$), úprava výrazu pod odmocninou, střed ± polovina šířky; kontrola na 10 z 20 (0,299; 0,701) a 0 z 15 (0; 0,204). Pojem kvadratická rovnice jen zde ([doplnění R68](../rozhodnuti/kapitola-09.md#r68-doplneni-2026-11-17)). | Bez cvičení. |
| [Nepovinné: souhrn studií o telepatii](../../quarto/kapitola_09.qmd#rozsireni-ganzfeld) | 106 z 329 (Cumming, Bem a Honorton), Wilson (0,274; 0,374), *p* 0,002; proč výpočet sám neprokazuje telepatii. | Bez cvičení. |
| [Dva nezávislé podíly](../../quarto/kapitola_09.qmd#sec-dva-podily) | Směrodatná chyba rozdílu podílů a její odhad $s_{p_1-p_2}=0{,}067$ sčítáním rozptylů (Wald −0,03; 0,23 jako princip); Newcombův interval z Wilsonových intervalů (−0,032; 0,227) s vysvětlením mezí a obrázkem konstrukce (poloviny intervalů, čtverce vzdáleností, Pythagorova věta); test se společným podílem 0,35, $z=1{,}48$, *p* 0,138; proč test používá společný podíl a interval ne; dvojnásobný výběr *p* 0,036. List `Dva_podily`. | 4, 12. |
| [Dobrá shoda](../../quarto/kapitola_09.qmd#sec-dobra-shoda) | Volba jednoho ze čtyř stejných vzorků čaje (80 lidí; 12, 16, 21, 31); $e_j=n\mathrm{π}_{0j}$; nerovnoměrné π₀ (poradna); „Častý omyl“ o profilu z jiného výběru; statistika $\mathrm{χ}^2=10{,}10$ s tabulkou příspěvků; dvě kategorie $\mathrm{χ}^2=z^2$ (6,667). | 5, 6. |
| [Chí-kvadrát rozdělení](../../quarto/kapitola_09.qmd#sec-chi-rozdeleni) | Simulace 10 000 výběrů (průměr 2,99; 1,6 % ≥ 10,10; 5,0 % nad 7,81); rozdělení a stupně volnosti $k-1$; aproximace diskrétní statistiky, opora v rozšíření CLT (Wilcox); *p*-hodnota 0,018 z pravého chvostu; závěr testu jako výrok o populaci; test nesměrový a nezávislý na pořadí (Howell, s. 156); proč pravý chvost zachytí oba směry ($z^2$ a chí-kvadrát s jedním stupněm volnosti, obrázek) a co by znamenal levý chvost; CHISQ.DIST.RT, CHISQ.INV.RT, CHISQ.TEST na listu `Dobra_shoda`; co test neříká (intervaly kategorií, více srovnání). | 5, 6. |
| [Nepovinné: proč chí-kvadrát](../../quarto/kapitola_09.qmd#rozsireni-proc-chi) | Součet normovaných čtverců, normální aproximace četností, $k-1$ podle Navarrové. | Bez cvičení. |
| [Nezávislost a homogenita](../../quarto/kapitola_09.qmd#sec-nezavislost) | Očekávané četnosti ze součinového pravidla (kap. 5); značení $f_{jl}$, $e_{jl}$, $f_{j+}$, $f_{+l}$, tabulka $R\times S$ (R69); dvojitá sumace; $(R-1)(S-1)$; tabulka stresu $\mathrm{χ}^2=2{,}198=z^2$; test nezávislosti vs. homogenity podle uspořádání; souvislost není příčina. | 7, 8. |
| [Řádkové podíly a rezidua](../../quarto/kapitola_09.qmd#sec-rezidua) | Věk × strategie zvládání (190; $\mathrm{χ}^2=11{,}78$, 4 st. v., *p* 0,019, V 0,18); řádkové podíly a obrázek; Pearsonova a standardizovaná rezidua s tabulkou obou a upozorněním na rozdílné názvy v programech; standardizovaná rezidua jen popisně, generační výklad průřezu; list `Tabulka` s ŘÁDKY a SLOUPCE. | 7. |
| [Nepovinné: Holmova korekce](../../quarto/kapitola_09.qmd#rozsireni-holm) | Postupné hranice α/m; tabulka devíti buněk s rezidui, *p*-hodnotami, hranicemi a rozhodnutími; průkazná jen buňka senioři × řešení problému. List `Tabulka` A36:D50. | 14. |
| [Předpoklady a Fisherův test](../../quarto/kapitola_09.qmd#sec-predpoklady-09) | Dva významy nezávislosti; absolutní četnosti; „Častý omyl“ s nevýskyty (letní čas, Howell s. 154); hierarchie pravidel očekávaných četností (≥ 5 jako konzervativní vodítko, další doporučení, ne samostatná záruka); Fisherův test povinně: otázka, podmínění okrajovými součty, čtení výsledku (pilot 8/10 vs. 3/10: χ² *p* 0,025, Fisher 0,070; stres 0,18 vs. 0,14), není jen pro malé výběry; obrázek deseti možných tabulek a jejich pravděpodobností; **simulovaná *p*-hodnota** (simulace Monte Carlo: 10 000 přeskupení pilotní tabulky, 0,068 proti Fisherovu 0,070; obrázek proti aproximaci) jako princip bez výpočtu v Excelu; „Častý omyl“ o neparametričnosti. | 9, 12. |
| [Nepovinné: Fisher v Excelu](../../quarto/kapitola_09.qmd#rozsireni-fisher) | Hypergeometrické rozdělení (schváleno doplněním R70), HYPGEOM.DIST, SUMIF; list `Fisher`. | Bez cvičení. |
| [Velikost souvislosti](../../quarto/kapitola_09.qmd#sec-velikost-souvislosti) | Daniels podle Fielda (56/140 vs. 20/117): (a) rozdíl 22,9 bodu, Newcombe (11,9; 33,0), přirozené četnosti, procenta vs. procentní body; (b) riziko, poměr rizik 2,34 a referenční skupina (0,43), šance a poměr šancí 3,23, proč OR existuje, aspirin jako vzácný jev (1,82 a 1,83; 0,77 bodu); (c) φ = 0,25: úvaha (dělení *n*, největší možná hodnota χ², odmocnina), φ² jako součin rozdílu řádkových a sloupcových podílů, vzorec z četností se znaménkem podle pořadí kategorií; Cramérovo V s $n(q-1)$; omezení (aspirin φ 0,034), bez slovních pásem; věcná interpretace s výhradou k náhodnému rozdělení. Tabulka četností s řádkovými procenty. List `Mira_souvislosti`. | 10, 15. |
| [Nepovinné: intervaly pro poměry](../../quarto/kapitola_09.qmd#rozsireni-intervaly-pomeru) | LN a EXP; RR (1,50; 3,66), OR (1,80; 5,82). | 15. |
| [Nepovinné: Simpsonův paradox](../../quarto/kapitola_09.qmd#rozsireni-simpson) | Berkeley 1973, obory B–F (Howell), tabulka podílů; odchylka Howellova 28,8 % od 27,1 % se ve studentském textu od 2026-11-16 neuvádí (zůstává v [kartě U01](../zdroje/U01-howell.md#revize-09-20261116) a v kontrole kapitoly). | Bez cvičení. |
| [McNemarův test](../../quarto/kapitola_09.qmd#sec-mcnemar) | Vyhledávání pomoci (Howell, smyšlená data, 72 dětí); tabulka párových dat (do 2026-11-16 „tabulka přechodů“); zdůvodnění podle R68; neshodné dvojice; rozdíl 0,111 všech úplných dvojic; přesně binomicky *p* 0,077, aproximace 0,046; neúplné dvojice; bez změn test nelze spočítat; chybějící kontrolní skupina. List `McNemar`. | 8, 11. |
| [Nepovinné: Cohenovo kappa](../../quarto/kapitola_09.qmd#rozsireni-kappa) | Dva posuzovatelé (Howell): obrázek tabulky 3 × 3 s vyznačenými shodami a neshodami a s očekávanými četnostmi; 21/30, očekávaná shoda 12,93, κ ≈ 0,47; vazba na reliabilitu. | 8f slovně. |
| [Znaménkový test](../../quarto/kapitola_09.qmd#sec-znamenkovy-test) | Dvanáct rozdílů skóru pozornosti z kap. 8 (11 kladných, 1 záporný): binomický test znamének, *p* 0,006 proti 0,0004 v párovém *t*-testu; nulové rozdíly do testu nevstupují; menší síla, vhodnost pro ordinální data (Howell, s. 677); přesný McNemarův test jako znaménkový test odpovědí ano–ne. Listy `Spanek_rozdily` a `Znamenkovy`. | 8g, 13. |
| [Volba postupu a zpráva](../../quarto/kapitola_09.qmd#sec-volba-postupu-09) | Rozhodovací tabulka včetně znaménkového testu a simulované *p*-hodnoty; dvě ukázky zprávy APA (Daniels, zvládání) se stojatým χ; ukázka kontingenční tabulky podle APA s četnostmi a řádkovými procenty. | 8, 12. |
| [Shrnutí](../../quarto/kapitola_09.qmd#sec-shrnuti-09) | Osm odkazovaných myšlenek. | Souhrnně 1–13. |

<a id="priklady-soubory-09"></a>

### Příklady, vizualizace a soubory

[Sešit kapitoly 9](../../data/kapitola_09.xlsx) má 26 listů: `Prehled`, osm
výpočtových listů (`Interval_podilu`, `Dva_podily`, `Dobra_shoda`, `Tabulka`,
`Mira_souvislosti`, `McNemar`, `Znamenkovy`, nepovinně `Fisher`) a sedmnáct vstupních listů
tabulek četností (devět k výkladu, osm ke cvičením; `Spanek_rozdily` a `U13_uzkost` obsahují jednotlivé dvojice). Žluté vstupy výpočtových listů
mají výchozí hodnoty výkladu; studenti do nich dosazují data cvičení. Simulace
k obrázkům (chí-kvadrát rozdělení, $z^2$, přeskupení pilotní tabulky) ani přesný výpočet pokrytí nejsou v sešitu. [Pokrytí cvičení](../DATA.md#kapitola-9).

Autorské modelové příklady: tabulka stresu (z kap. 5), volba čaje, věk × strategie
zvládání (podle autorovy přednášky P12), pilotní studie, poradna, učení ve
ročnících, názor na statistiku, cvičení 12, úzkost před programem a po něm (cvičení 13). Skóry pozornosti pro znaménkový test jsou převzaty z kapitoly 8. Skutečná data z literatury s uvedením
zdroje: Daniels (podle Fielda, s. 638), aspirinová studie, Prozac a anorexie
(Walsh a kol.), Berkeley (podle Howella), Howell a Huessy (cvičení 6.8), ganzfeld
(podle Cumminga). Smyšlená data jiných autorů: vyhledávání pomoci a kámen–nůžky–papír
(Howell), letní čas (Howellova ilustrace), posuzovatelé (Howell). Původní studie
čteny nebyly; v textu se citují zprostředkující učebnice bez samostatných záznamů.

| Obrázek | Didaktický účel |
|---|---|
| [Waldův a Wilsonův interval](../../quarto/kapitola_09.qmd#fig-wald-wilson) | Selhání Waldova intervalu u 0 z 15; podobnost u 10 z 20. |
| [Odvození Wilsonova intervalu](../../quarto/kapitola_09.qmd#fig-wilson-odvozeni) | Nepovinné rozšíření: čtverec vzdálenosti $(p-\mathrm{π})^2$ a mez $z^2\mathrm{π}(1-\mathrm{π})/n$ pro 10 z 20; interval leží tam, kde první křivka nepřesahuje druhou, průsečíky 0,30 a 0,70. |
| [Volba čaje](../../quarto/kapitola_09.qmd#fig-pozice) | Pozorované a očekávané četnosti. |
| [Chí-kvadrát rozdělení](../../quarto/kapitola_09.qmd#fig-chi-kvadrat) | Tvar podle stupňů volnosti; simulace statistiky odpovídá modelu; *p*-hodnota a kritická hodnota. |
| [Strategie zvládání podle věku](../../quarto/kapitola_09.qmd#fig-zvladani) | Řádkové podíly proti podílům celého souboru. |
| [Daniels](../../quarto/kapitola_09.qmd#fig-daniels) | Dva podíly s Wilsonovými intervaly a rozdíl s Newcombovým intervalem. |
| [Pokrytí Waldova a Wilsonova intervalu](../../quarto/kapitola_09.qmd#fig-pokryti) | Přesné pokrytí obou intervalů a podíl Waldových intervalů mimo 0–1 pro čtyři velikosti výběru; důvod volby Wilsonova intervalu. |
| [Konstrukce Newcombova intervalu](../../quarto/kapitola_09.qmd#fig-newcombe) | Které poloviny Wilsonových intervalů vstupují do které meze; čtverce vzdáleností a jejich součet. |
| [Od *z* k chí-kvadrát](../../quarto/kapitola_09.qmd#fig-z2-chi2) | Oba chvosty *z* se umocněním překlopí do pravého chvostu; shoda *z*² s chí-kvadrát rozdělením s jedním stupněm volnosti. |
| [Tabulky Fisherova testu](../../quarto/kapitola_09.qmd#fig-fisher) | Deset možných tabulek pilotní studie, jejich pravděpodobnosti a význam „stejně nebo méně pravděpodobné“. |
| [Simulovaná *p*-hodnota](../../quarto/kapitola_09.qmd#fig-monte-carlo) | Rozdělení χ² z 10 000 přeskupení proti hladké aproximaci. |
| [Shody dvou posuzovatelů](../../quarto/kapitola_09.qmd#fig-kappa) | Nepovinně: shody a neshody v tabulce 3 × 3 s očekávanými četnostmi. |

<a id="interaktivni-vizualizace-09"></a>

**Interaktivní vizualizace (2026-11-25, [upřesnění R65](../rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-25-interval-podilu)):**
na konci pododdílu [Wilsonův interval](../../quarto/kapitola_09.qmd#sec-wilson),
za věcnou interpretací a před rozšířením o odvození, odkazuje blok „Vyzkoušejte si:
Waldův a Wilsonův interval“ na stránku
[Proč odhadujeme podíl Wilsonovým intervalem](../../quarto/viz_interval_podilu.qmd).

- **Ovládání:** počet úspěchů *k* a počet pokusů *n* (1–200; výchozí 10 z 20), posuvník hladiny spolehlivosti 50–99 %; předvolby 10 z 20, 0 z 15, 1 z 25 (cvičení 3) a 40 z 80; vybrané π posuvníkem nebo klepnutím do grafu pokrytí (výchozí 0,05); přepínače meze Waldova intervalu a přiblížení okolí hladiny.
- **Grafy a výsledky:** oba intervaly nad sebou s *p* a středem Wilsonova intervalu, oblast nemožných hodnot a upozornění na nulovou šířku či meze mimo 0–1; interaktivní obdoba obrázku `fig-wilson-odvozeni` (obě strany nerovnice, průsečíky v mezích, volitelně vodorovná mez Waldova intervalu $z^2p(1-p)/n$); přesné pokrytí obou intervalů podle π s průměrem, nejnižší hodnotou a podílem hodnot π pod hladinou; pravděpodobnost Waldova intervalu mimo 0–1 nebo s nulovou šířkou; sloupce *P*(*X* = *k*) se zvýrazněnými počty, jejichž interval π obsahuje, a pokrytí jako jejich součet; vzorce listu `Interval_podilu`.
- **Vztah k výkladu:** nové pojmy nezavádí; *k* a *P*(*X* = *k*) jsou značení kapitoly 5. Výchozí stav navazuje na čísla kapitoly (64 % Waldových intervalů při *n* = 20 a π = 0,05). „Čeho si všimnout“ doplňuje oproti kapitole tato zjištění z modelu: pokrytí nezávisí na pozorovaném *k*; při *n* = 20 a π = 0,05 je pokrytí Wilsonova intervalu 92,5 % a výsledek *k* = 0 má pravděpodobnost 0,358; průměrné pokrytí Wilsonova intervalu při *n* = 20 je 95,3 %, při *n* = 200 je 95,1 % a Waldova 93,5 %; těsně pod dolní mezí intervalu pro *k* = 1 (a souměrně u 1) klesá pokrytí Wilsonova intervalu v úzkém pásmu na 83 až 84 % (pro *n* od 10 do 200), při *n* = 20 u π ≈ 0,0089 s vysvětlením, které sloupce chybějí. Kapitola v oddílu `sec-wilson` od 2026-11-25 uvádí totéž obecně (83 až 84 %, při *n* = 10 u π = 0,018, u větších výběrů mimo rozsah obrázku `fig-pokryti`); dříve uváděla „u *n* = 10 nejníže na 85 %“, což platilo jen pro mřížku π od 0,01 do 0,99 obrázku.
- **Rozsah:** opakuje pododdíly Známá konstrukce a kde selhává, Wilsonův interval (včetně nepovinného odvození) a Výpočet v Excelu. Nepočítá skórový ani binomický test, Newcombův interval ani jiné intervaly pro podíl. Není samostatným cvičením; doplňuje úlohy 2 a 3.

**Interaktivní vizualizace (2026-11-20, [upřesnění R65](../rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-20-chi)):**
v pododdílu [Pearsonova a standardizovaná rezidua](../../quarto/kapitola_09.qmd#sec-pearson-upravena),
za rozšířením o Holmově korekci, odkazuje blok „Vyzkoušejte si: od tabulky
četností k testu chí-kvadrát“ na stránku
[Jak daleko je tabulka četností od nezávislosti](../../quarto/viz_chi_kvadrat.qmd).

- **Ovládání:** editovatelná tabulka věk × strategie zvládání (celá čísla 0–100 000, výchozí data kapitoly); tlačítka zdvojnásobení četností, původních dat a „Nezávislost“ (19, 17, 19 / 27, 26, 27 / 19, 17, 19).
- **Grafy a výsledky:** řádkové podíly s podíly celého výběru; chí-kvadrát rozdělení se čtyřmi stupni volnosti, kritickou hodnotou 9,49 a *p*-hodnotou jako plochou; tabulky očekávaných četností, příspěvků, Pearsonových a standardizovaných reziduí (podbarvených podle hodnoty); slovní závěr na hladině 0,05, Cramérovo V, nejmenší očekávaná četnost s upozorněním pod 5, vzorec `CHISQ.DIST.RT`.
- **Vztah k výkladu:** nové pojmy nezavádí; oddíl „Odkud se čísla berou“ opakuje vzorce řádkového podílu, očekávané četnosti, příspěvku, χ², stupňů volnosti, obou reziduí a Cramérova V s dosazením pro buňku mladí × řešení problému. „Čeho si všimnout“ doplňuje oproti kapitole čtyři zjištění z modelu: po zdvojnásobení četností χ² 23,56 a *p* pod 0,001 při stejném V 0,18 a rezidua větší asi 1,4krát; téměř nezávislá tabulka má χ² 0,05; změna jedné četnosti (senioři × řešení problému na 20) změní všechny očekávané četnosti i reziduum nezměněné buňky (−2,30 na −1,99; χ² 4,82); pětkrát menší tabulka má V 0,20, ale *p* 0,567 a nejmenší očekávanou četnost 3,47.
- **Rozsah:** opakuje oddíly o očekávaných četnostech, řádkových podílech, reziduích, *p*-hodnotě z chí-kvadrát rozdělení, malých očekávaných četnostech a Cramérově V. Tabulka je pevně 3 × 3; test dobré shody, Fisherův test, simulovanou *p*-hodnotu ani Holmovu korekci nepočítá. Není samostatným cvičením; doplňuje úlohu 7.

**Interaktivní vizualizace (2026-11-20, [upřesnění R65](../rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-20-miry)):**
na konci pododdílu [Koeficient φ a Cramérovo V](../../quarto/kapitola_09.qmd#sec-phi-v),
před rozšířením o intervalech poměrů, odkazuje blok „Vyzkoušejte si: rozdíl podílů,
poměr rizik a poměr šancí“ na stránku
[Co říkají rozdíl podílů, poměr rizik a poměr šancí o téže tabulce](../../quarto/viz_miry_souvislosti.qmd).

- **Ovládání:** četnosti tabulky 2 × 2 (výchozí Danielsová 56, 84 / 20, 97), nebo dvě rizika posuvníky ve skupinách po 100, 1 000 či 10 000 osobách s volbou míry držené pevně; předvolby Danielsová a aspirin (189 z 11 034 a 104 z 11 037); záměna referenční skupiny.
- **Grafy a výsledky:** pole osob s pohledem na riziko a na šance; rizika, rozdíl v procentních bodech, „kolik osob ze 100“, poměr rizik, šance, poměr šancí s dosazením a slovním čtením; graf a tabulka čar stejného rozdílu, stejného poměru rizik a stejného poměru šancí; retrospektivní výběr (10–100 % osob bez jevu); χ², φ se znaménkem a jako součin dvou rozdílů.
- **Vztah k výkladu:** nové pojmy nezavádí. „Čeho si všimnout“ doplňuje oproti kapitole tři zjištění z modelu: při poměru šancí 3,23 je poměr rizik 3,16 u rizika 0,01 v referenční skupině, 1,53 u 0,5 a 1,07 u 0,9; stejný poměr rizik 2,34 není možný nad rizikem 0,43 a stejný rozdíl nad 0,771; ve výběru s desetinou žen bez tématu je poměr podílů 1,29 při nezměněném poměru šancí. Po záměně referenční skupiny uvádí poměr šancí 0,31, který kapitola nepočítá.
- **Rozsah:** opakuje pododdíly Rozdíl v procentních bodech, Poměr rizik a poměr šancí a část o φ. Nepočítá intervaly spolehlivosti (Newcombe, intervaly poměrů), Cramérovo V pro větší tabulky ani test. Členění je inspirováno článkem [E08](../zdroje/E08-magnusson-odds-ratio.md#e08-magnusson-odds-ratio). Není samostatným cvičením; doplňuje úlohy 9e a 10.

Kontrola souladu vizualizací chí-kvadrát a měr souvislosti s textem uvedených oddílů: 2026-11-20; vizualizace intervalu pro podíl: 2026-11-25. Zbývající námět vizualizace ke kapitole 9 je otevřeným návrhem v [plánu pokračování](plan-pokracovani.md#plan-vizualizace).

<a id="aplikace-09"></a>

**Statistická aplikace (2026-11-25, [R87](../rozhodnuti/vizualizace-a-aplikace.md#r87-statisticke-aplikace)):**
na konci pododdílu [Interval a test jednoho podílu](../../quarto/kapitola_09.qmd#sec-interval-a-test-podilu),
před rozšířením o studiích telepatie, odkazuje blok „Spočítejte si: test jednoho
podílu“ na stránku [Test jednoho podílu](../../quarto/app_jeden_podil.qmd)
(odkaz má i [kapitola 6](06-vyberove-rozdeleni-testovani.md#aplikace-06)).

- **Vstupy:** název proměnné, názvy a četnosti dvou kategorií (0–100 000, součet alespoň 1), kategorie počítaná jako úspěch, π₀ (desetinné číslo nebo zlomek), alternativní hypotéza (≠, >, <) a α (0 až 0,5); u jednostranné alternativy volba oboustranného intervalu 1 − 2α (výchozí) nebo jednostranného intervalu 1 − α. Stránka se otevírá s daty 7 z 8 (kap. 6, cvičení 8) při π₀ = 0,50 a oboustranné alternativě. Předvolby: tipující student (kap. 6), rozpoznávání číslic (kap. 6, cvičení 8), studie o telepatii (rozšíření kap. 9), každá se svou π₀ a alternativou.
- **Výsledky:** tabulka s dosazením (data, rozdíl *p* − π₀ v procentních bodech, skórový test se směrodatnou chybou z π₀, u oboustranné alternativy χ² = *z*², přesný binomický test, Wilsonův interval a rozdíl od π₀ s intervalem), slovní interpretace, očekávané četnosti s pravidlem alespoň 5 a upozorněním, grafy pozorovaných a očekávaných četností, rozdělení Bin(*n*; π₀) se sloupci *p*-hodnoty, pozorovaným *k* a normální aproximací a osa podílu s intervalem a π₀. Tabulka výsledků má tmavé záhlaví a šedé řádky skupin; výpočet v Excelu aplikace neuvádí ([upřesnění R87](../rozhodnuti/vizualizace-a-aplikace.md#r87-upresneni-2026-11-25)).
- **Vztah k výkladu:** opakuje pododdíly Wilsonův interval, Výpočet v Excelu, Interval a test jednoho podílu, Dvě kategorie: chí-kvadrát a *z*-test a Malé očekávané četnosti a binomický test kapitoly 6. Oboustrannou přesnou *p*-hodnotu počítá pravidlem Fisherova testu z této kapitoly (součet pravděpodobností výsledků stejně nebo méně pravděpodobných než pozorovaný, jako `binom.test` v R) a porovnává ji se zdvojením z McNemarova a znaménkového testu; to a jednostranný Wilsonův interval podle R75 jdou nad rámec výkladu jednoho podílu a schválil je R87. Nové termíny nezavádí.
- **Rozsah:** jen dvě kategorie; nepočítá jiné intervaly pro podíl, Cohenovo *h* ani sílu testu. Není samostatným cvičením.

Kontrola souladu aplikace s textem uvedených pododdílů: 2026-11-25.

<a id="aplikace-09-dva-podily"></a>

**Statistická aplikace Test dvou podílů (2026-11-26, [upřesnění R87](../rozhodnuti/vizualizace-a-aplikace.md#r87-upresneni-2026-11-26)):**
na konci pododdílu [Test se společným podílem](../../quarto/kapitola_09.qmd#sec-test-dvou-podilu),
před výpočtem v Excelu, odkazuje blok „Spočítejte si: test dvou podílů“ na
stránku [Test dvou podílů](../../quarto/app_dva_podily.qmd).

- **Vstupy:** názvy proměnné skupiny a výsledku, editovatelná tabulka 2 × 2 (názvy skupin a kategorií, četnosti 0–100 000, každá skupina alespoň 1, okraje se dopočítají), sledovaná kategorie, „Prohodit skupiny“ (změní i znaménko δ₀ a směr jednostranné alternativy), testovaný rozdíl δ₀ (−1 až 1, výchozí 0), alternativa a α, u jednostranné alternativy volba intervalů. Stránka se otevírá příkladem stresu (40/100 a 30/100). Předvolby: stres, sebeobjektivizace (Danielsová), pilotní studie, aspirin a noninferiorita online kurzu (66/100 a 70/100, δ₀ = −0,10, *H*₁: π₁ − π₂ > −0,10; vlastní data).
- **Výsledky:** tabulka s dosazením (data, rozdíl v procentních bodech, *s*<sub>*p*₁−*p*₂</sub> pro představu o přesnosti, Wilsonovy intervaly skupin, Newcombův interval a jeho rozhodnutí; test se společným podílem, pro δ₀ ≠ 0 skórový test s podíly odhadnutými za platnosti *H*₀; Fisherův test pro δ₀ = 0; přesný test a interval podle Agrestiho a Mina, pokud má každá skupina nejvýše 200 případů, u jednostranné alternativy vždy s jednostranným přesným intervalem 1 − α; poměr rizik a šancí s intervaly stejné spolehlivosti, φ se směrem slovy), slovní interpretace, tabulka pozorovaných a v závorkách očekávaných četností při *H*₀ s pravidlem alespoň 5 a grafy podílů s Wilsonovými intervaly, osy rozdílu s nulou a δ₀ a všech tabulek Fisherova testu.
- **Vztah k výkladu:** opakuje pododdíly Rozdíl podílů a jeho interval, Test se společným podílem, Fisherův exaktní test a Jak velká je souvislost? (včetně rozšíření o intervalech poměrů). Nad rámec výkladu jdou testovaný rozdíl δ₀ se skórovým testem, jednostranné Newcombovy intervaly a přesný nepodmíněný test s intervalem ([Agresti a Min, 2001](../zdroje/E10-agresti-min-2001.md#e10-agresti-min-2001)); stránka je stručně vysvětluje. Nové termíny nezavádí; nový symbol δ₀ je v přehledu značení.
- **Rozsah:** jen tabulka 2 × 2 nezávislých skupin; nepočítá Yatesovu korekci, Cohenovo *h*, sílu testu ani párová data. Není samostatným cvičením.

Kontrola souladu aplikace s textem uvedených pododdílů: 2026-11-26.

<a id="cviceni-09"></a>

### Cvičení a očekávané dovednosti

[Patnáct úloh](../../quarto/kapitola_09.qmd#sec-cviceni-09) má úplná sbalená řešení;
úlohy 14 a 15 jsou nepovinné. Kalkulačka: 1, 5, 8–12; Excel: 2, 3, 4, 6, 7, 13.
Tolerance 0,002 u podílů a mezí, 0,02 u statistik, 0,001 u *p*-hodnot.

| Úloha | Co student samostatně dělá |
|---|---|
| 1. Kategoriální data, kódy a podíl | Rozliší úrovně, odmítne průměr kódů oboru, vyloží průměr 0/1 jako podíl, zvolí interval a předpoklady. |
| 2. Interval pro podíl a velikost výběru | Wilson pro 18/60 a 72/240, vliv čtyřnásobku *n*, interpretace a oprava výroku o 95 %. |
| 3. Když jev nenastal | Wald a Wilson pro 0/25 a 1/25; nulová šířka a záporná mez; „0 z 25 neznamená bezpečnost“. |
| 4. Antidepresivum po léčbě anorexie | Newcombe a test (*p* 0,575), interpretace nezamítnutí s randomizací, χ² = z² a podmínky. |
| 5. Kámen, nůžky, papír | Dobrá shoda (1,68; 0,432), nezávislost tahů, nesměrovost. |
| 6. Klienti poradny | Nerovnoměrné π₀ (1,92; 0,589), kdy je evidence „známá“ a kdy test homogenity. |
| 7. Strategie učení podle ročníku | Homogenita 3 × 3 (13,17; 0,010; V 0,19), řádkové podíly, standardizovaná rezidua, proč ne devět testů, průřez vs. změna u lidí. |
| 8. Který postup? | Sedm situací včetně McNemara, Fishera, dobré shody, kappa a znaménkového testu. |
| 9. Kde je chyba? | Procenta místo četností, chybějící nevýskyty, opakovaná posouzení, rezidua bez korekce, šance vs. riziko. |
| 10. Pozornost a vyrovnávací angličtina | Rizika, přirozené četnosti, RR 1,94 a OR 2,18 s referenční skupinou, φ a znaménko, výklad pro rodiče. |
| 11. Názor na statistiku před a po kurzu | Úplné dvojice, McNemar přesně (0,057) a přibližně (0,033), proč ne nezávislé skupiny. |
| 12. Malá pilotní studie | Očekávané četnosti pod 5, volba Fisherova testu (0,057), vztah k Newcombovu intervalu, zpráva. |
| 13. Znaménkový test: úzkost před programem a po něm | Zdůvodní volbu u ordinálních hodnocení, určí znaménka a vyřadí shody (10, 2, 3), spočítá *p* 0,039, formuluje závěr bez kontrolní skupiny, vysvětlí menší sílu a vztah k McNemarovu testu. |
| 14. Nepovinně: Holmova korekce | Dvě průkazné buňky z úlohy 7. |
| 15. Nepovinně: intervaly pro poměry | RR (1,11; 3,41), OR (1,12; 4,27); nesouměrnost a hodnota 1. |

<a id="pojmy-hranice-09"></a>

### Pojmy, konvence a hranice návaznosti

Nově vysvětleno 34 pojmů [registru](../SLOVNIK.md#kapitola-09) včetně nepovinného hypergeometrického
rozdělení; „referenční skupina“ má od kapitoly 9 druhý schválený význam (doplnění R70, 2026-11-09). Revize 2026-11-16 (R81) přejmenovala upravené reziduum na standardizované a tabulku přechodů na tabulku párových dat a doplnila znaménkový test a simulaci Monte Carlo. Značení podle R69 a R81:
$f_j$, $e_j$, $\mathrm{π}_{0j}$, $f_{jl}$, $e_{jl}$, $f_{j+}$, $f_{+l}$, $R\times S$,
$\mathrm{χ}^2$, $\mathrm{φ}$, $V$, $s_{p_1-p_2}$, nepovinně $\mathrm{κ}$; RR a OR jen ve zprávách a v přehledu.
Nové funkce Excelu: CHISQ.DIST.RT, CHISQ.INV.RT, CHISQ.TEST, ŘÁDKY, SLOUPCE, nepovinně
HYPGEOM.DIST, SUMIF, SMALL, LN, EXP.

**Nepovinné:** souhrn studií o telepatii, proč chí-kvadrát, Holmova korekce, výpočet Fisherova
testu, intervaly pro poměry, Simpsonův paradox, Cohenovo kappa. Další kapitola je nesmí předpokládat.

**Vysvětleno omezeně:** interval pro párový rozdíl podílů jen zmínkou; Fisherův test jen pro 2 × 2;
Yatesova korekce jen jednou větou jako výchozí nastavení softwaru (1,78 místo 2,20); zobecnění
Fisherova testu jen zmínkou; simulovaná *p*-hodnota jen jako princip na tabulce 2 × 2, bez výpočtu v Excelu a bez vzorce (k + 1)/(B + 1), který zavádí kapitola 10; znaménkový test bez aproximace a bez intervalu pro medián. **Nevyloženo:** věrohodnostní
poměr, Mantelův–Haenszelův test, loglineární modely, logistická regrese, analýza síly pro χ²,
Cohenovo w a slovní pásma, testy trendu, pořadové testy (Wilcoxonův test).

### Prezentace a doprovodný scénář

Prezentace ke kapitole (2026-11-24) je v [presentations/kapitola_09/](../../presentations/kapitola_09/):
jedna výuka, 23 obsahových slidů v pěti oddílech, šest úloh bez Excelu a doprovodný sešit s pěti listy.
Vykládá povinnou část; Wilsonův a Newcombův interval bez vzorce a odvození, Fisherův test a simulovanou
*p*-hodnotu jako princip, nepovinná rozšíření vynechává. Úlohy a data sešitu jsou nová modelová, nejsou
součástí kapitoly ani `data/kapitola_09.xlsx`. Druhý sešit
[s daty a výpočty z výkladu](../../presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_vyklad.xlsx)
má list pro každou studii ze slidů 3–30. Jeho data se shodují s výkladem kapitoly a s `data/kapitola_09.xlsx`;
obsahuje hotové výpočty po krocích se sloupcem „Na slidu“, bez pracovní oblasti
([historie](../../quarto/README.md#sesit-kapitoly-9-vyklad)). Na výslovnou žádost autora připraven také
[scénář pro syntézu řeči](../../presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_scenar.txt)
ke snímkům 1–30 s [průvodním dokumentem](../../presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_scenar_podklady.md)
a [manifestem](../../presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_scenar_manifest.json); nahrávka nevznikla.
Rozsah kapitoly se nemění; postup a kontroly jsou v [autorské historii](../../quarto/README.md#prezentace-kapitoly-9).
Soulad tohoto doplnění s prezentací zkontrolován 2026-11-24; datum kontroly výkladu kapitoly výše se tím nemění.

## Vazby na podklady

Výběr karet pro dohledání podkladů k tématům této kapitoly vychází z tematického rozcestníku a záznamů čtení a použití. Samotný odkaz neznamená převzetí příkladu ani nové prostudování; přesné lokátory, použití, nálezy a rozsah ověření jsou v cílových kartách.

- [U01](../zdroje/U01-howell.md#priprava-09-20261109) — kap. 6, s. 137–171; při revizi 2026-11-16 znaménkový test (s. 130–131, 677–678) a tab. 6.13 ([záznam](../zdroje/U01-howell.md#revize-09-20261116)).
- [U03](../zdroje/U03-cumming.md#priprava-09-20261109) — kap. 13, s. 387–409.
- [U04](../zdroje/U04-openintro.md#priprava-09-20261109) — §6.1, s. 208–212.
- [U08](../zdroje/U08-navarro.md#priprava-09-20261109) — §12.1.3–12.1.5.
- [U14](../zdroje/U14-field.md#priprava-09-20261109) — kap. 16.
- [U15](../zdroje/U15-wilcox.md#priprava-09-20261109) — §15.1–15.4.
- [P12](../zdroje/P12-kategorialni-data.md#priprava-09-20261109), [P13](../zdroje/P13-chikvadrat-neparametricke.md#priprava-09-20261109), [C09](../zdroje/C09-ulohy-tyden-12.md#priprava-09-20261109) — priority a náměty.
- [E08](../zdroje/E08-magnusson-odds-ratio.md#e08-magnusson-odds-ratio) — inspirace členěním vizualizace měr souvislosti (2026-11-20).
- [Čtení pro návrh](../zdroje/HISTORIE.md#priprava-09-20261109) a [použití při tvorbě](../zdroje/HISTORIE.md#pouziti-kapitola-09).
