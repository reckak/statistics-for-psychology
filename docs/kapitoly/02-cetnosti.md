<a id="mapa-kapitola-02"></a>

# 2. Četnosti, rozdělení dat a jejich zobrazení

[Mapa celé knihy](../OSNOVA.md) · [Rozcestník zdrojů](../ZDROJE.md)

**Podklad a stav:** existující [kapitola 2](../../quarto/kapitola_02.qmd#sec-kapitola-02),
karta zkontrolována 2026-10-11; dotčený výklad grafu stonek a list a jeho mapování zkontrolovány 2026-10-16. **Vstup:** případ, proměnná, úrovně měření,
matice, chybění a meze zobecnění z kapitoly 1. Konvence určují
[R02](../rozhodnuti/kapitola-02.md#r02-indexy-a-cetnosti), [R03](../rozhodnuti/kapitola-02.md#r03-hranice-intervalu),
[R05](../rozhodnuti/spolecne-konvence.md#r05-zaokrouhlovani) a [R13](../rozhodnuti/kapitola-02.md#r13-platny-udaj-velikost-vyberu).

**Cíle:** sestavit a interpretovat četnostní tabulku, určit základ procent,
přečíst sumaci, třídit do jednoznačných intervalů, volit a kriticky číst grafy,
popsat tvar rozdělení a vytvořit četnosti, sloupcový graf a histogram v Excelu.

<a id="skutečný-obsah-oddílů-1"></a>

### Skutečný obsah oddílů

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Od záznamů k četnostem](../../quarto/kapitola_02.qmd#sec-od-zaznamu-k-cetnostem) a [co počítáme](../../quarto/kapitola_02.qmd#sec-co-pocitame) | Absolutní četnost a tabulka na šesti odpovědích; rozdělení není obrázek ani rozdělování do skupin. Ztráta vazby na osobu, velikost výběru versus počet zahrnutých případů; nulová četnost versus chybění. | 1. |
| [Podíly a procenta](../../quarto/kapitola_02.qmd#sec-relativni-cetnost), [jmenovatel](../../quarto/kapitola_02.qmd#sec-jmenovatel), [zaokrouhlení](../../quarto/kapitola_02.qmd#sec-zaokrouhlovani-02) | Relativní četnost, index kategorií a převod na procenta. Stejný čitatel 3, základy 6 a 5; platný údaj znamená nechybějící, nikoli nutně správný údaj. Procento osob versus odpovědí při více volbách; vzájemná výlučnost i úplnost kategorií. Zobrazení podílů na 3 a procent na 1 místo, bez zkrácení mezivýpočtů. | 1, 3, 9. |
| [Součty a sumace](../../quarto/kapitola_02.qmd#sec-sumace) | Rozvinutý součet, operátor, index a meze; počet kategorií není počet osob. Součet četností a podílů vyžaduje úplné výlučné kategorie a společný základ; zaokrouhlené hodnoty se nemusí sečíst přesně. | 2. |
| [Kumulativní četnosti](../../quarto/kapitola_02.qmd#sec-kumulativni-cetnosti) | Vzestupné sčítání včetně hranice, absolutní i relativní varianta; neklesající průběh, konečný součet, proč nesčítat kumulativní sloupec. Arbitrární pořadí nominálních strategií; „méně než“, „nejvýše“ a „alespoň“ včetně doplňku. | 4, návazně 3. |
| [Větší soubor](../../quarto/kapitola_02.qmd#sec-modelova-data-02) | Rozšíření na 36 osob, 33 platných spánků; četnosti odpočatosti a počtů slov 0–12. Nejčetnější kategorie nemusí tvořit většinu; nulová četnost uchovává možnou hodnotu. | 1 a 10. |
| [Intervalové třídění](../../quarto/kapitola_02.qmd#sec-tridni-intervaly) a [zahrnutí mezí](../../quarto/kapitola_02.qmd#sec-hranice-intervalu) | Dolní/horní mez a šířka; dvě konvence na stejných datech včetně přepočtu četností. Používaná dolní vyloučená/horní zahrnutá mez, ošetření krajů a ztráta podrobností uvnitř intervalu. | 5 a 10. |
| [Sloupcový graf](../../quarto/kapitola_02.qmd#sec-sloupcovy-graf) a [tečkový graf](../../quarto/kapitola_02.qmd#sec-teckovy-graf) | Samostatné kategorie a pořadí odpočatosti versus každé jednotlivé pozorování na číselné ose. Skládání teček zachovává shody; svislá poloha není druhou proměnnou. | 6a–b. |
| [Histogram](../../quarto/kapitola_02.qmd#sec-histogram) a [volba intervalů](../../quarto/kapitola_02.qmd#sec-volba-intervalu) | Číselné intervaly, skutečné šířky a prázdné intervaly; histogram může seskupovat i diskrétní čísla. Srovnání změny šířky a posunu mezí, stabilita viditelného rysu a meze automatických nastavení. | 5–7 a 10. |
| [Graf kumulativních četností](../../quarto/kapitola_02.qmd#sec-kumulativni-graf) | Schody pro jednotlivé hodnoty versus body na horních mezích seskupených dat. Přesný význam bodů včetně hranice; spojnice uvnitř intervalu není přesně zjištěný podíl. | 4 a 6d; samostatná tvorba tohoto grafu není zadána. |
| [Polygon](../../quarto/kapitola_02.qmd#sec-polygon-cetnosti) | Výpočet středu intervalu po krocích; bod zastupuje všechny hodnoty intervalu. Spojnice nevyjadřuje časový průběh ani přesné hodnoty jednotlivců. | 5: střed intervalu; bez samostatné tvorby polygonu. |
| [Výsečový graf](../../quarto/kapitola_02.qmd#sec-vysecovy-graf) | Části jediného celku, omezení vícečetných odpovědí; přímé srovnání tří strategií se sloupci a omezení vnímání výsečí/3D efektů. | 3b a 6a. |
| [Stonek a list](../../quarto/kapitola_02.qmd#sec-stonek-list) | Rozklad osmi časů na desítky a jednotky, klíč a opakované hodnoty; rekonstrukce zachovaných čísel, nikoli pořadí nebo identity osob. Stejných osm časů také s dělením stonků po pěticích a dvojicích; význam opakovaných stonků, prázdných řádků a volba podrobnosti. | 8; dělení stonků vysvětleno na řešené ukázce, samostatně neprocvičeno. |
| [Tvar rozdělení](../../quarto/kapitola_02.qmd#sec-tvar-rozdeleni) a [podlaha/strop](../../quarto/kapitola_02.qmd#sec-podlaha-strop) | Souměrnost, chvost a směr šikmosti, jeden/dva/více vrcholů, rovnoměrnost a odlehlost. Dva sousední nejvyšší sloupce nejsou automaticky dvě skupiny. Meze nástroje a nahromadění nejsou samy vysvětlením tvaru. | 7. |
| [Zavádějící zobrazení](../../quarto/kapitola_02.qmd#sec-zavadejici-grafy) | Čtení os, základu a velikosti výběru; nula u délky sloupců, srovnatelná měřítka histogramů, plochy zvětšovaných ikon. Graf není sám důkazem o populaci či příčině. | 9 a argumentace v 6–7. |
| [Excel: absolutní četnosti](../../quarto/kapitola_02.qmd#sec-excel-pocet-countifs) | POČET, COUNTIFS a SUMA; oblast, název listu, pevné a posuvné odkazy. Počet čísel nekontroluje jejich přípustnost. | 10. |
| [Excel: relativní a kumulativní](../../quarto/kapitola_02.qmd#sec-excel-relativni-kumulativni) | Podíl s pevným jmenovatelem, procentní formát bez násobení stem, rozšiřující se oblast kumulativního součtu a kontroly. | 10. |
| [Excel: intervaly a grafy](../../quarto/kapitola_02.qmd#sec-excel-histogram) | COUNTIFS se dvěma mezemi a spojením podmínky pomocí `&`; tvorba sloupcového grafu a histogramu z stejně širokých intervalů. Nulová mezera, zachované prázdné intervaly, kontrola alternativního automatického histogramu. | 10: předpověď a kontrola změny. |
| [Shrnutí](../../quarto/kapitola_02.qmd#sec-shrnuti-02) | Spojuje otázku, jmenovatel, pořadí a meze s volbou zobrazení; připomíná rozdíl popisu a vysvětlení. | Souhrnně 1–10. |

### Příklady, vizualizace a soubory

[Grafy četností](../../quarto/kapitola_02.qmd#sec-grafy-cetnosti) sdružují
výklad sedmi typů zobrazení; navazující [četnosti a grafy v Excelu](../../quarto/kapitola_02.qmd#sec-excel-cetnosti)
propojují tabulky a tvorbu vybraných grafů s konkrétním sešitem.

[Sešit kapitoly 2](../../data/kapitola_02.xlsx) obsahuje podle výkladu listy
`Data`, `Cetnosti`, `Histogram`; 36 záznamů je v řádcích 2–37 a popis
proměnných vpravo od dat. Navazuje prvních šest osob z kapitoly 1;
spánek chybí u P05, P11 a P24. Všechna data jsou sestavená pro výuku.
Samostatné listy doplňují strategie učení, časy dokončení, srovnání skupin
a vstupy cvičení 1–5, 8–9. Cvičení 10 používá `Data`; 6–7 jsou slovní
zadání bez konkrétních jednotlivých pozorování. První list `Prehled` uvádí
návaznosti a oblasti. [Pokrytí všech cvičení](../DATA.md).

Grafy nejsou jen ukázkami typů: [základy procent](../../quarto/kapitola_02.qmd#fig-zaklad-procent),
[princip kumulace](../../quarto/kapitola_02.qmd#fig-princip-kumulace) a
[meze intervalů](../../quarto/kapitola_02.qmd#fig-meze-intervalu) vysvětlují
konkrétní rozhodnutí ve výpočtu. Srovnání histogramů mění šířku a polohu
mezí při stejných datech; dvojice kumulativních grafů odděluje jednotlivé
hodnoty od seskupení. Přehled tvarů, podlahy/stropu a dvojice os 30 versus
32 učí kritické interpretaci. Tři rekonstrukce listů doprovázejí excelové
odkazy a vzorce; nejsou vydávány za snímky spuštěné aplikace.

<a id="cvičení-a-očekávané-dovednosti-1"></a>

### Cvičení a očekávané dovednosti

[Deset úloh se sbalenými řešeními](../../quarto/kapitola_02.qmd#sec-cviceni-02)
používá kalkulačku, závěrečná Excel. Text vymezuje toleranci pro podíly
a procenta; celočíselné četnosti mají souhlasit přesně.

| Úloha | Co student samostatně dělá |
|---|---|
| [1. Od odpovědí k tabulce](../../quarto/kapitola_02.qmd#sec-uloha-02-1) | Z 12 odpovědí sestaví četnosti a procenta, určí n/k, kontroluje součty a rozliší nejčetnější od většinové odpovědi. |
| [2. Co říká sumace](../../quarto/kapitola_02.qmd#sec-uloha-02-2) | Rozepíše částečný součet kategorií 2–4 a vysvětlí, proč mez není počet osob. |
| [3. Chybění a jmenovatele](../../quarto/kapitola_02.qmd#sec-uloha-02-3) | Porovná základ 20 odpovídajících a 25 oslovených, odmítne záměnu chybění za „ne“; vysvětlí součet nad 100 % u více voleb. |
| [4. Kumulování a meze](../../quarto/kapitola_02.qmd#sec-uloha-02-4) | Sestaví kumulativní tabulku počtů chyb a správně použije méně než / nejvýše / alespoň a doplněk. |
| [5. Intervaly a podrobnosti](../../quarto/kapitola_02.qmd#sec-uloha-02-5) | Roztřídí osm dob, porovná pravidla mezí, určí střed a vysvětlí nedostupnost přesného podílu uvnitř intervalu. |
| [6. Volba grafu](../../quarto/kapitola_02.qmd#sec-uloha-02-6) | Zdůvodní zobrazení nominálních strategií, malého souboru skórů, mnoha časů a kumulativního podílu. |
| [7. Tvar](../../quarto/kapitola_02.qmd#sec-uloha-02-7) | Interpretuje chvost, dva/tři vrcholy, strop a rovnoměrnost; neodstraňuje data pro hezčí graf ani nedokazuje psychologické typy. |
| [8. Stonek a list](../../quarto/kapitola_02.qmd#sec-uloha-02-8) | Rekonstruuje sedm časů včetně opakování a vymezí ztracenou informaci. |
| [9. Procenta a optický dojem](../../quarto/kapitola_02.qmd#sec-uloha-02-9) | Porovná 30/40 a 32/80, opraví zkrácenou osu i závěr založený pouze na absolutních četnostech. |
| [10. Ověření v Excelu](../../quarto/kapitola_02.qmd#sec-uloha-02-10) | Předpoví a ověří přesun odpočatosti 2 → 3 a spánku 6 → 7; zkontroluje četnosti, kumulaci a neměnný počet platných údajů, pak vstupy obnoví. |

<a id="pojmy-hranice-a-návaznosti-1"></a>

### Pojmy, hranice a návaznosti

Nové jsou četnosti, rozdělení, platný údaj, velikost výběru, index, sumace,
intervalové třídění, typy grafů a pojmy tvaru. Výklad zavádí `n`, `k`,
`f_j`, `p_j`, kumulativní varianty a rozlišení indexů `i`/`j`; `x_i`
je konkrétně využito v kapitole 3. Novými vysvětlenými funkcemi jsou
POČET, COUNTIFS a SUMA s odkazy do [přehledu Excelu](../../quarto/excel.qmd).

**Nepovinné** je okénko o nestejně širokých intervalech v
[oddílu o jejich volbě](../../quarto/kapitola_02.qmd#sec-volba-intervalu):
četnost/podíl dělený šířkou a plocha obdélníku; formální pojem hustoty
se zde nezavádí. Kapitola 4 proto vztah plochy a podílu vysvětluje samostatně.
Číselné ukazatele, kvantily a koeficienty tvaru přebírá kapitola 3.
Kontingenční tabulky a vztahy dvou kategoriálních proměnných nejsou vyloženy.
Modelové a populační rozdělení jsou zatím jen odlišeny od pozorovaných dat.


## Vazby na podklady

Výběr karet pro dohledání podkladů k tématům této kapitoly vychází z tematického rozcestníku a existujících záznamů použití. Samotný odkaz neznamená převzetí příkladu ani nové prostudování; přesné lokátory, použití, nálezy a rozsah ověření jsou v cílových kartách.

- [U01](../zdroje/U01-howell.md#u01) — kap. 2.
- [U03](../zdroje/U03-cumming.md#u03) — kap. 3.
- [U04](../zdroje/U04-openintro.md#u04) — kap. 2.
- [U11](../zdroje/U11-russo.md#u11) — §2.1–2.4.
- [P01](../zdroje/P01-uvod-cetnosti.md#p01) — sn. 39–68.
- [C01](../zdroje/C01-ulohy-tyden-1.md#c01) — X2.
- [C02](../zdroje/C02-ulohy-tyden-2.md#c02) — X2_04–10.

**Typografická úprava 2026-10-30:** všechny tabulky kapitoly včetně zadání
a řešení mají automatické označení a název. Zachována existující ID,
vysvětlující části dlouhých popisků jsou v poznámkách pod tabulkami.
Kontrola souladu se zde popsaným obsahem byla omezena na tabulky a jejich
okolí; cíle, návaznosti, hodnoty, zadání a řešení se nemění. Společnou sazbu
určuje [R54](../rozhodnuti/spolecne-konvence.md#r54-sazba-tabulek-pdf).
