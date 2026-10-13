<a id="mapa-kapitola-03"></a>

# 3. Ukazatele polohy a variability

[Mapa celé knihy](../OSNOVA.md) · [Rozcestník zdrojů](../ZDROJE.md)

**Podklad a stav:** existující [kapitola 3](../../quarto/kapitola_03.qmd#sec-kapitola-03),
karta zkontrolována 2026-10-11. **Vstup:** význam měření z kapitoly 1;
četnosti, procenta, sumace a grafy z kapitoly 2. Konvence upravují
[R01](../rozhodnuti/spolecne-konvence.md#r01-znaceni-a-reportovani), [R04](../rozhodnuti/kapitola-03.md#r04-kvantily),
[R05](../rozhodnuti/spolecne-konvence.md#r05-zaokrouhlovani), [R06](../rozhodnuti/kapitola-03.md#r06-robustni-shrnuti)
a [R14](../rozhodnuti/kapitola-03.md#r14-kvartily-spicatost-chvost).

**Cíle:** volit ukazatele podle otázky a měření; vysvětlit a provést výpočet
středu, kvantilů a variability; sestavit boxplot; posoudit vzdálené hodnoty,
ořezání a winsorizaci; předpovědět změnu statistik při převodu jednotek
a srozumitelně popsat data. Výpočty entropie a momentových koeficientů
jsou nepovinné, základní význam entropie je součástí hlavního výkladu.

<a id="skutečný-obsah-oddílů-2"></a>

### Skutečný obsah oddílů

| Oddíl / lokátor | Obsah a hloubka výkladu | Procvičení |
|---|---|---|
| [Co souhrnné ukazatele zachycují](../../quarto/kapitola_03.qmd#sec-poloha-variabilita) | Poloha a variabilita na dvou souborech se stejným průměrem; statistika jako vypočtená charakteristika versus parametr populace/modelu. Význam měřicí škály a omezenost souhrnu. | 11, návazně 12. |
| [Modus](../../quarto/kapitola_03.qmd#sec-modus) | Nejčastější hodnota/kategorie, několik modů, rovnost všech četností; modus není jeho četnost. Přesný modus jemných časů versus nejčetnější interval, lokální vrcholy versus stejně četné hodnoty. | 1. |
| [Medián](../../quarto/kapitola_03.qmd#sec-median) | Seřazení, lichý/sudý počet, průměr prostředních čísel a „alespoň polovina“ při shodách. U ordinálních kategorií se kódy neprůměrují; lze uvést dvě prostřední kategorie. | 1, 3–4. |
| [Průměr](../../quarto/kapitola_03.qmd#sec-prumer) | Zavedení x_i, součtu a dělení počtem; průměr přidělených bodů versus silnější interpretace rysu. Změna jedné doby z 10 na 30 posune průměr, ne medián/modus. Normalita není podmínkou výpočtu průměru. | 1 a 5. |
| [Volba středu](../../quarto/kapitola_03.qmd#sec-volba-stredu) a [střed/tvar](../../quarto/kapitola_03.qmd#sec-stred-tvar) | Tři různé otázky, geometrický význam, výhody/omezení. Modely souměrného a dvou směrů šikmého tvaru; obvyklé pořadí středu není univerzální test šikmosti a shoda středu nedokazuje symetrii. | 1; pořadí tří středů vyloženo bez samostatné diagnostické úlohy. |
| [Průměr více skupin](../../quarto/kapitola_03.qmd#sec-vazeny-prumer) | Váhy velikostí skupin přes jejich celkové příspěvky; průměr skupinových průměrů odpovídá jiné otázce. Úplné četnosti versus aproximace středy intervalů; skupinové mediány nestačí. Průměr součtu vyložen slovně, variabilita součtu odložena. | 2. |
| [Kvantily a interpolace](../../quarto/kapitola_03.qmd#sec-kvantily), [výpočet](../../quarto/kapitola_03.qmd#sec-vypocet-kvantilu) | Percentily, 1./2./3. kvartil, q_p a úroveň p; seřazené x_(i). PERCENTIL.INC: n−1 mezer, přiřazené úrovně, pozice a lineární interpolace. Jedenáct časů a 17. percentil; shody, krajní úrovně, jediná hodnota. Výsledek nemusí být pozorován ani pokrýt přesně dané procento dat. | 3, 9 a 12. |
| [Kumulativní kvantil](../../quarto/kapitola_03.qmd#sec-kvantil-kumulativni) | První pozorovaná hodnota/kategorie, která dosáhne požadovaného podílu. Kontrast 90% časového limitu s interpolací; dosažení už u minima. Odpočatost a výběr nižší prostřední kategorie při 50 %; změna ordinálních kódů nemění kategorii. | 4; časový limit je řešeným příkladem. |
| [Percentilové pořadí](../../quarto/kapitola_03.qmd#sec-percentilove-poradi) | Inkluzivní konvence versus exkluzivní a kompromisní; stejný jmenovatel, odlišné započítání shod. Srovnání s úrovněmi PERCENTIL.INC, nevratnost převodů a interval úrovní pro shodnou hodnotu. Zápis pořadí bez tečky, směr „lepšího“ výsledku a rozdíl od procenta správných odpovědí. | 3, návazně 4/1 a 7. |
| [Rozpětí](../../quarto/kapitola_03.qmd#sec-rozpeti) | Pozorované minimum/maximum versus meze nástroje; variační a mezikvartilové rozpětí. Přidávání údajů nemůže zmenšit rozpětí, ale větší samostatný výběr nemusí mít vždy větší rozpětí. Kvartilový interval nemusí obsahovat přesně polovinu a rozdíl ordinálních kódů není vzdálenost. | 3, 7, 9 a 12. |
| [Odchylky](../../quarto/kapitola_03.qmd#sec-odchylky) a [MeanAD](../../quarto/kapitola_03.qmd#sec-prumerna-absolutni) | Podepsané odchylky se kolem přesného průměru vyruší; absolutní hodnota převádí odchylku na vzdálenost. Výpočet MeanAD a jeho citlivost; odlišení nejednoznačné zkratky MAD od zdejších MeanAD/MedAD. | 5. |
| [Čtverce a rozptyl](../../quarto/kapitola_03.qmd#sec-rozptyl) | Druhá mocnina, součet čtverců odchylek versus čtverce hodnot či součtu; geometrická plocha a čtvereční jednotky. Dělení n pro empirické rozdělení versus výběrové s² s n−1; nemožnost výpočtu s² z jediné hodnoty. | 5. |
| [Korekce a stupně volnosti](../../quarto/kapitola_03.qmd#sec-korekce-rozptylu) | Přizpůsobení průměru datům snižuje součet čtverců; podmínka nulového součtu váže poslední odchylku, žádná osoba se nevyřazuje. Nestrannost jako vlastnost opakovaného odhadování při uvedených předpokladech. Simulace 20 000 výběrů pro každé n = 5, 20, 100 z pětihodnotové populace. | 5–6; simulace není obecný důkaz. |
| [Směrodatná odchylka](../../quarto/kapitola_03.qmd#sec-smerodatna-odchylka) | Odmocnina vrací původní jednotky, přibližná rovnost a rozdíl od MeanAD. SD není stejná odchylka každého člověka ani bez modelu neurčuje podíl v m ± s. Nestrannost rozptylu se nepřenáší na jeho odmocninu. | 5–6 a 12. |
| [MedAD](../../quarto/kapitola_03.qmd#sec-median-absolutnich) | Tři kroky přes medián dat a medián absolutních vzdáleností. Robustnost/odolnost a její meze; nulové MedAD nemusí znamenat shodná data. Používá se nepřepočtená hodnota, zmíněna softwarová škálovací konstanta. | 7. |
| [Ořezání a winsorizace](../../quarto/kapitola_03.qmd#sec-orezani-winsorizace) | Vynechání versus nahrazení krajních hodnot pro výpočet, zachování originálů. Podíl na každém konci a zaokrouhlení počtu dolů; 10 dob a příklad 18 hodnot. Medián jako krajní případ ořezání; nevolit úpravu podle žádoucího výsledku a nezaměňovat odhadované charakteristiky. | 8. |
| [Krabicový graf](../../quarto/kapitola_03.qmd#sec-boxplot) | Úplná konstrukce z 41 skórů: interpolované kvartily, medián, IQR, pomocné meze 1,5 IQR, vousy na pozorováních a body za mezemi. Meze nejsou konce vousů; zvláštní případ nulového IQR, varianty boxplotů a skryté vrcholy. | 9: výpočet i ruční kresba; Excel ověřuje kvartily, nevykládá samostatný postup tvorby boxplotu. |
| [Entropie](../../quarto/kapitola_03.qmd#sec-entropie) | Základní slovní význam rozmanitosti kategorií: úplná koncentrace, maximum při rovnoměrnosti pro stejné k, jednotka bit a závislost na vymezení kategorií. Entropie není rozptyl kódů ani kvalita strategií. | 11 slovně; výpočet pouze nepovinně v 13. |
| [Posun a změna jednotek](../../quarto/kapitola_03.qmd#sec-zmena-skaly) a [vlastnosti ukazatelů](../../quarto/kapitola_03.qmd#sec-vlastnosti-ukazatelu) | Transformace y_i = a + b x_i, statistické označení lineární versus přesnější afinní. Posun, převod minut, b = 0 a obrácené skórování; změna polohy, SD o absolutní násobitel, rozptylu o jeho čtverec a výměna kvartilů při obrácení pořadí. | 10. |
| [Nelineární transformace](../../quarto/kapitola_03.qmd#sec-nelinearni-transformace) | Druhé mocniny různě mění stejné rozdíly. Průměr se musí přepočítat; zachování pořadí pomáhá přímo pozorovanému mediánu, ne automaticky interpolovanému kvantilu. Pořadová statistika versus širší ukazatel založený na uspořádání. | Řešené kontrasty; závěrečná 10 procvičuje lineární převod. |
| [Volba a komunikace statistik](../../quarto/kapitola_03.qmd#sec-komunikace-statistik) | Otázka → význam měření → graf → souhrn; tabulka doporučených popisů a omezení. Slovní zpráva o 33 spáncích a 36 paměťových výkonech bez tvrzení o populaci. | 1 a 12. |
| [APA 7](../../quarto/kapitola_03.qmd#sec-reportovani-apa), [zaokrouhlení](../../quarto/kapitola_03.qmd#sec-zaokrouhlovani-03), [nula v grafu](../../quarto/kapitola_03.qmd#sec-nula-graf) | Výpočetní m/s versus reportovací M/Mdn/SD/N/n; anglická a česká ukázka, přesnost podle účelu. Tvar se čte z grafu, ± SD není interval nejistoty průměru. Přirozená nula je jiná otázka než nulová základna délky sloupce. | 12; grafická zásada navazuje na 2/9. |
| [Od dat k modelu](../../quarto/kapitola_03.qmd#sec-popis-a-model) | Tři modely se stejným průměrem a SD, různým tvarem a počtem možných hodnot. Parametrická rodina přidává předpoklad; neparametrický popis není „bez čísel/předpokladů“. Normální rodina uvedena jako most ke 4. | 11. |
| [Nepovinné momenty](../../quarto/kapitola_03.qmd#sec-momenty) včetně [špičatosti](../../quarto/kapitola_03.qmd#sec-spicatost) | Řád a centrum momentu, třetí/čtvrtá mocnina, g₁ a g₂, rozlišení špičatosti a excesu. Nulová šikmost nedokazuje symetrii, výška vrcholu neurčuje špičatost; korekce SKEW/KURT, malá n a nulová variabilita. | Nepovinná 14. |
| [Excel: základní ukazatele](../../quarto/kapitola_03.qmd#sec-excel-zaklad-03) | POČET, PRŮMĚR, MEDIAN, MODE.SNGL, MIN/MAX, PERCENTIL.INC a rozpětí. Omezení MODE.SNGL a inkluzivní pořadí přes COUNTIFS/POČET, nikoli automaticky PERCENTRANK. | 12. |
| [Excel: odchylky](../../quarto/kapitola_03.qmd#sec-excel-odchylky-03) a [MedAD](../../quarto/kapitola_03.qmd#sec-excel-mad-03) | Pomocné sloupce odchylek, ABS a mocnin; SUMA, VAR.P/VAR.S, SMODCH.VÝBĚR.S/ODMOCNINA. MedAD přes medián a absolutní vzdálenosti; souhrn spánku/paměti s vlastními počty platných údajů. | 12 pro základní souhrn; mezikroky ručně v 5 a 7. |
| [Nepovinný Excel](../../quarto/kapitola_03.qmd#rozsireni-excel-03) | LOGZ se základem 2 a KDYŽ pro nulový podíl; sloupce mocnin a SKEW.P, SKEW, KURT. KURT vrací korigovaný exces, další trojka se neodečítá. | Rozšíření lze použít ke kontrole 13–14; úlohy jej výslovně nevyžadují. |

<a id="příklady-vizualizace-a-soubory-1"></a>

### Příklady, vizualizace a soubory

[Sešit kapitoly 3](../../data/kapitola_03.xlsx) je jediným studentským datovým
souborem této kapitoly. Podle výkladu obsahuje `Priklad` (pět časů v A2:A6),
`Data` a `Souhrn` (spánek/paměť), `Rozsireni` a oddělené vstupy
`Kvantily` A2:A12, `Orezani` A2:A11 a `Boxplot` A2:A42. Kontrolní výpočty
jsou na `Kontrola_prikladu`, pět časů bez výpočtů na `Zaklad_data`.
Další listy pokrývají menší příklady a všech 14 cvičení včetně zadaných
souhrnů. První list `Prehled` uvádí umístění. [Pokrytí cvičení](../DATA.md).

| Příklad / lokátor | Didaktický účel a původ |
|---|---|
| [4, 5, 5, 6, 10 minut](../../quarto/kapitola_03.qmd#sec-stred-rozdeleni) | Autorský soubor propojuje střed, kvantily, pořadí, odchylky, rozptyl, MedAD a Excel; varianta 10 → 30 ukazuje citlivost. |
| [Dvě skupiny 10 a 30 osob](../../quarto/kapitola_03.qmd#fig-vazeny-prumer) | Příspěvky k součtu zdůvodňují vážení průměrů, nikoli mechanický průměr dvou čísel. |
| [Jedenáct různých časů](../../quarto/kapitola_03.qmd#fig-kvantil-interpolace) a [percentil/pořadí](../../quarto/kapitola_03.qmd#fig-percentil-a-poradi) | Úrovně přiřazené pozicím, detail 17. percentilu a opačné otázky „podíl → hodnota“ / „hodnota → zastoupení“. |
| [Odchylky a čtverce](../../quarto/kapitola_03.qmd#fig-odchylky-ctverce) | Délky a plochy vysvětlují absolutní a kvadratické příspěvky; plocha nemění jednotku svislé osy. |
| [Simulace korekce](../../quarto/kapitola_03.qmd#fig-korekce-rozptylu) | Opakované náhodné výběry s vracením ze známé modelové populace ilustrují dlouhodobé podhodnocení při dělení n. |
| [Deset časů](../../quarto/kapitola_03.qmd#fig-orezani-winsorizace) | Stejné krajní hodnoty, ale jiný počet členů/jmenovatel při ořezání a winsorizaci. |
| [41 skórů](../../quarto/kapitola_03.qmd#fig-boxplot-03) | Vedle původních bodů ukazuje krabici, pomocné meze, skutečné konce vousů a samostatné body. |
| [Strategie učení](../../quarto/kapitola_03.qmd#fig-entropie) | Tři rozdělení mezi čtyři kategorie oddělují koncentraci a rovnoměrnost bez nutnosti výpočtu logaritmů. |
| [Transformace](../../quarto/kapitola_03.qmd#fig-transformace) a [stejné dvě statistiky](../../quarto/kapitola_03.qmd#fig-stejne-statistiky) | Lineární versus nelineární změna vzdáleností; přesně shodné parametry tří modelů nepředstavují shodné rozdělení. |
| [Geometrie středu](../../quarto/kapitola_03.qmd#fig-vyznam-stredu), [střed/tvar](../../quarto/kapitola_03.qmd#fig-stred-tvar), [špičatost](../../quarto/kapitola_03.qmd#fig-spicatost) | První obrázek je převzatý od Cmglee s licencí uvedenou v kapitole; ostatní jsou modelové ilustrace. Špičatost se vysvětluje na odlišných krajních hodnotách při stejné četnosti vrcholu. |

Data o spánku a paměti pokračují z kapitoly 2; ostatní pevné příklady jsou
sestavené pro výuku. Simulace je odlišena od pevných dat a obrázky populačních
modelů od náhodných výběrů. Tuto odlišnost je nutné zachovat i v pokračování.

<a id="cvičení-a-očekávané-dovednosti-2"></a>

### Cvičení a očekávané dovednosti

[Úlohy 1–14](../../quarto/kapitola_03.qmd#sec-cviceni-03) mají bezprostřední
sbalená řešení na webu. Ručně vyžádané pracovní PDF kapitoly 3 přesouvá
všechna řešení za všechna zadání, s obousměrnými odkazy; obsah úloh zachovává.
Závěrečné přehledy nepřipojuje. Export ověřen 2026-10-13, viz
[postup](../../README.md#ruční-pdf-vybrané-kapitoly) a
[R31](../rozhodnuti/postupy-a-dokumentace.md#r31-pracovni-pdf).
Jednotlivé nadpisy ve zdroji nemají explicitní ID, proto tato mapa
odkazuje na stabilní oddíl cvičení a používá číslo i název. Základem je
kalkulačka, u úlohy 12 Excel; kvantily podle PERCENTIL.INC, výsledky zpravidla
na dvě místa s tolerancí 0,01. Reportovací část 12 má vlastní přesnost.

| Úloha | Co student samostatně dělá |
|---|---|
| 1. Jaký střed hledáme | Spočítá tři středy šesti časů, volí podle otázky a odmítne automatické odstranění dlouhého času. |
| 2. Dvě různě velké skupiny | Spojí průměry vahami 8 a 12 osob; vysvětlí nedostatek skupinových mediánů pro společný medián. |
| 3. Kvantily a shodné hodnoty | Určí kvartily/IQR a inkluzivní pořadí při shodách; u 17. percentilu jedenácti různých časů odliší přiřazenou úroveň od skutečně zahrnutého podílu. |
| 4. Co je na ordinální škále přípustné | Zpochybní průměrování prostředních kódů a určí 50./75. percentil pravidlem první dosažené kumulativní úrovně. |
| 5. Výpočet variability | Provede všechny mezikroky od průměru k MeanAD, s² a s; vyloží nulový součet odchylek a stupně volnosti. |
| 6. Co dokládá simulace korekce | Odliší nestrannost od přesnosti každého odhadu a vysvětlí, proč se nepřenáší na odmocninu. |
| 7. Medián absolutních odchylek | Spočítá MedAD a předpoví změnu 16 → 100; rozliší odolnost ukazatele a změnu celkové variability. |
| 8. Ořezání a winsorizace | Provede 20 % z každého konce deseti časů; porovná jmenovatele a určí počty při 10 % z 18 hodnot včetně zaokrouhlení dolů. |
| 9. Krabicový graf | Spočítá kvartily, meze a konce vousů osmi časů, vyznačí samostatný bod a nakreslí vodorovný graf. |
| 10. Změna jednotek a obrácení škály | Převede polohu, SD a rozptyl po přičtení dvou minut a změně na sekundy; zdůvodní nezápornost SD. |
| 11. Rozmanitost kategorií a meze souhrnu | Slovně porovná entropii koncentrace/rovnoměrnosti a odmítne odvozování stejného či normálního rozdělení ze stejného průměru/SD. |
| 12. Samostatný popis dat v Excelu | Spočítá souhrn 36 paměťových výkonů, napíše přístupný popis a omezení, poté českou reportovací ukázku APA. |
| 13. Nepovinně: entropie od četností | Spočítá entropii i normalizovanou variantu; odliší přidání prázdné kategorie od změny zastoupení a interpretuje úplnou koncentraci. |
| 14. Nepovinně: nulová šikmost a stejný vrchol | Ověří nesouměrný protipříklad s g₁ = 0 a výpočtem vysvětlí různou špičatost při stejné četnosti vrcholu. |

<a id="pojmy-hranice-a-návaznosti-2"></a>

### Pojmy, hranice a návaznosti

Nové pojmy zahrnují statistiku/parametr, ukazatele středu a variability,
kvantily/interpolaci/percentilové pořadí, odchylky, stupně volnosti,
nestranný odhad, robustnost, boxplot, entropii a transformace. Značení
zahrnuje `x_i`, `x_(i)`, `m`, medián, `q_p`, `s²`, `s`, absolutní hodnotu,
odmocninu, `a`, `b`, `y_i` a `h` u entropie. Výpočet entropie,
logaritmus a koeficienty `g₁` a `g₂` patří do nepovinného rozšíření.
Úplné definice a varianty se nepřenášejí do této mapy.

**Vysvětleno pouze v omezeném rozsahu:** nestrannost a stupně volnosti
na konkrétním rozptylu; parametrický/neparametrický popis jako rozdíl
v předpokladu rodiny modelů. **Zmíněno/odloženo:** variabilita součtu závisí
na vztahu proměnných, ale kovariance ani korelace zde nejsou vyloženy;
interval nejistoty průměru se odlišuje od ± SD, nekonstruuje se.

**Nepovinné:** [logaritmus, entropie a její normalizace](../../quarto/kapitola_03.qmd#rozsireni-entropie),
[momenty a koeficienty](../../quarto/kapitola_03.qmd#rozsireni-momenty),
[odpovídající Excel](../../quarto/kapitola_03.qmd#rozsireni-excel-03) a úlohy 13–14.
Kapitola 4 může předpokládat průměr, SD, kvantily, lineární převod, grafy
a rozlišení dat/modelu; znalost logaritmů, entropického vzorce a momentů
předpokládat nesmí. Na konci výkladu již existuje most k normální rodině,
nikoli ještě výpočet jejích ploch.


## Vazby na podklady

Výběr karet pro dohledání podkladů k tématům této kapitoly vychází z tematického rozcestníku a existujících záznamů použití. Samotný odkaz neznamená převzetí příkladu ani nové prostudování; přesné lokátory, použití, nálezy a rozsah ověření jsou v cílových kartách.

- [U01](../zdroje/U01-howell.md#u01) — §2.6–2.12.
- [U06](../zdroje/U06-gravetter.md#u06) — kap. 3–4.
- [U05](../zdroje/U05-dostal.md#u05) — kap. 3.
- [U11](../zdroje/U11-russo.md#u11) — §2.5–2.10.
- [P02](../zdroje/P02-popisne-statistiky.md#p02) — popisné statistiky.
- [C02](../zdroje/C02-ulohy-tyden-2.md#c02) — poloha a variabilita.
