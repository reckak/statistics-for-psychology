# Společné nálezy a historie ověřování zdrojů

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md)

Přesun z původní mapy 2026-10-13 zachovává datované záznamy a jejich tehdejší omezení. Nové nálezy ke konkrétnímu zdroji patří do jeho karty; společné kontroly více podkladů sem. Odkazy na originály v `sources/` jsou místní.

## Rozpory, mezery a další práce

| Oblast | Co je třeba respektovat při přípravě kapitoly |
|---|---|
| Schválená koncepce | Pořadí a rozsah určuje OSNOVA; rozsáhlé kapitoly učebnic o ANOVA, regresi či bayesovských metodách nejsou automaticky součástí tohoto semestru. |
| Značení a kvantily | Přednost mají R01–R04, R14 a R15. Staré M/SD/MAD, pořadové algoritmy a N(μ, σ²) nepřebírat bez výslovného rozlišení konvencí. |
| Pojetí pravděpodobnosti | Dostál s. 13–14, Howell s. 108–110, Navarro s. 373–375, Russo s. 52–54 a Baron kap. 5 nepodávají totožný filozofický výklad. Dohodnuto v R21: tři pojetí jako různé interpretace se společnými pravidly, které nemusí vést ke stejnému číslu. |
| Podmínění a nezávislost | [U11](U11-russo.md#u11) s. 62 zaměňuje výsledek diagnostického testu za správnost klasifikace; při použití opravit podle zadání a stromu na s. 60. |
| Data a software | Číselné kódování a missing z SPSS nejsou univerzální požadavek; −99 nesmí vstupovat do běžného průměru. R z cizích knih zůstává interní. |
| Normální model | Rozlišit CDF a kvantil, percentil a pořadí, Q–Q a P–P, interval hodnot a interval spolehlivosti. Starší podklady obsahují konkrétní záměny. |
| Bibliografie | Baronova identita nyní ověřena v celé knize U12; zachovat doložený rozdíl copyrightu 2008 a prvního tisku 2007. Došetřit vydání de Vause a Morgana, rok/verzi Navarra, identitu mezinárodního Arona a přesný původ úloh C2/C3/C5. |
| Nedostupné návazné materiály | U [U11](U11-russo.md#u11) jsou kap. 13–14 a další označené oddíly pouze na webu, nikoli v místním PDF. Odkazované externí datasety, `Datíčka.xls`, videa, QR odkazy, online aplikace, originály studií a navazující části knih nejsou automaticky pokryty inventářem. |
| Nové inferenční podklady | P06: číselné p-hodnoty a zobecnění NHST; P07: rozdělení průměru versus t-statistiky, SE, bootstrap, interpretace intervalů a vzorce rozptylu; C05: modely, argumenty kvantilových funkcí a chybějící simulační sešity. Před použitím vyřešit konkrétní nálezy v kartách. Rozsah a pojetí kapitoly 6 určuje [R28](../rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6); U01 má v kap. 4 nesoulad kritických hodnot a β (karta U01). Kapitola 6 byla napsána 2026-10-12; nesouhlasné hodnoty se do ní nepřevzaly. |
| Parkovací studie | Souhrny Rubacka a Juienga (1997) jsou známy jen z U01 s. 86; původní článek není v `sources/`. Bibliografický záznam (Crossref) a uspořádání podle shrnutí článku byly ověřeny 2026-10-12; plný text čten nebyl. Kapitola 6 proto čísla uvádí „podle Howella“ a rozdíl z pozorovací části studie nevykládá jako prokázaný účinek čekajícího řidiče. |
| Odborné ověření | Před použitím konkrétního příkladu nezávisle ověřit všechny vstupy, výpočty a řešení; před převzetím empirického tvrzení ověřit původní zdroj a relevantní současné poznatky. |

### Aktualizace inventáře — 2026-10-12

Na žádost autora doplněno pět nových souborů, vyřazeny dva odstraněné výřezy a převedeny všechny jejich aktivní místní odkazy do celé knihy. Ověřeny aktuální cesty, rozsahy a SHA-256 proti inventáři, zachována ID D08/D09 a jejich historie. Záznam neznamená schválení dalších kapitol ani úplnou odbornou revizi podkladů. Původní soubory, studentské kapitoly a bibliografie se neměnily. Omezení neúspěšného exportu DOCX a neprovedených kontrol jsou u C05; web se při této dokumentační změně nerenderoval.

### Záznam prvního průzkumu a údržba

Inventura zahrnula všechny soubory ve všech aktuálních podsložkách. Ověřeny byly místní cesty, rozsahy souborů a otisky. Původní podklady nebyly upravovány. Pomocné textové extrakce, OCR, obrazy stran a exporty snímků zůstávají v ignorovaném `tmp/`, nejsou součástí mapy ani veřejného repozitáře.

Při aktualizaci karty zachovej ID; doplň datum, verzi souboru, přesné nově prostudované části, způsob ověření a zbývající mezery. Nový obsahový nález zapisuj k dotčenému zdroji; pouze schválenou změnu výkladu promítni také do osnovy či rozhodnutí. Při výměně vydání knihy zkontroluj všechny odkazované stránky, nikoli pouze první z nich.

### Doplnění kontroly podkladů kapitoly 5 — 2026-10-12

Při revizi znovu přečteny relevantní citované pasáže Howella (zejména
s. 108–112, 119, 121–128), Navarra (373–377), Sahua (64–69), Russa (64),
OpenIntro (95–96), Barona (121–123 a 149–152) a Uttsové (77–78).
V originálním obraze navíc prohlédnuty Howell s. 122 a 128, Sahu s. 64
a 69, OpenIntro s. 95, všechny uvedené strany Barona a Uttsové.
Výpočty kapitoly byly ověřeny nezávisle; u Howellova výsledku 0,513
(s. 122) kapitola správně zaokrouhluje 95/185 na 0,514.
Původní experimentální studie nebyly znovu ověřeny. Identita Baronova
vydání v této dřívější kontrole vycházela z externích údajů D08; pozdější
inventura téhož dne ji doplňuje přímo z monografie [U12](U12-baron.md#u12).
U C03 znovu ověřeno textové zadání X3_31 (100 otázek ano–ne, hranice 65);
kapitola na rozdíl od původního zadání rozlišuje přesný binomický model
a normální aproximaci. Nová typografická revize původního DOCX neproběhla.

### Kontrola podkladů při přípravě kapitoly 6 — 2026-10-12

Na žádost autora o projednání kapitoly o výběrovém rozdělení a principu testování hypotéz byl aktuální obsah `sources/` porovnán s inventářem: 33 souborů, žádný nový ani chybějící. U dvanácti relevantních souborů (U01–U06, U08, U11, P06, P07, C05 a D11) byl znovu ověřen prefix SHA-256, beze změny.

Rozsah nového čtení a nálezy jsou v kartách U01, U03, U04, U05, U08, U11, P06, P07 a C05. Čteno bylo v textové extrakci; v obraze jen U01 s. 95–96. Ve stavu mapy obsahu zůstávají U02 kap. 4–6, U06 kap. 7–8, U07 kap. 3–4, U09 kap. 7–8, U10 kap. 9 a 12, U03 kap. 6 a zbytek U08 kap. 10–11. D07 a D11 nebyly nově čteny; návrh se opírá o jejich karty. Vyhledání klíčových slov v U12 (PDF 150–175) nenašlo pasáž o vlivu velikosti výběru.

Schválený rozsah a pojetí kapitoly určují [R28](../rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6)–[R30](../rozhodnuti/kapitola-06.md#r30-terminologie-kapitoly-6) a [plán v osnově](../kapitoly/plan-pokracovani.md#plan-dalsi-kapitoly). Tento záznam není odbornou revizí podkladů. Originály v `sources/` se neměnily a do složky se nic nepřidalo.

<a id="pouziti-kapitola-06"></a>

### Použití podkladů při tvorbě kapitoly 6 — 2026-10-12

Kapitola 6 byla napsána podle [R28](../rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6)–[R30](../rozhodnuti/kapitola-06.md#r30-terminologie-kapitoly-6); skutečný obsah mapuje [karta v osnově](../kapitoly/06-vyberove-rozdeleni-testovani.md#mapa-kapitola-06). Použití konkrétních pasáží je zapsáno v kartách U01, P06, D07 a D11; u U11 je doplněno potvrzení nálezu v obraze. Ostatní podklady z přípravy sloužily jako opora pojetí, nikoli jako zdroj formulací nebo dat:

- **U04 (OpenIntro), s. 171:** citováno k tvrzení, že výběrové rozdělení ve skutečném výzkumu přímo nepozorujeme. Čteno v textové extrakci.
- **U08 (Navarro), oddíl 11.1:** citováno k rozlišení výzkumné a statistické hypotézy. Lokátorem je oddíl, protože přesné strany nebyly ověřeny.
- **C05, X5_02 a X5_05:** námět cvičení 5 (průměr devíti IQ-skórů nad 105); zadání i řešení jsou nově napsány a přepočteny. Mincovní úloha X5_09 se nepřebírá; příklad mincí cituje Wainera.
- **U03, U05, P07:** bez citace a bez převzatých příkladů.

Tři citované zdroje nejsou v `sources/` a nemají vlastní kartu:

| Zdroj | Co bylo ověřeno | Použití v kapitole a omezení |
|---|---|---|
| Ruback, R. B., a Juieng, D. (1997). *Territorial defense in parking lots: Retaliation against waiting drivers.* *Journal of Applied Social Psychology, 27*(9), 821–834. DOI 10.1111/j.1559-1816.1997.tb00661.x | Bibliografický záznam v metadatech Crossref; uspořádání tří studií podle shrnutí článku. | Původ průběžného příkladu, výklad chování jako hájení teritoria a zmínka o experimentu autorů. Plný text čten nebyl; čísla příkladu jsou z Howella (s. 86). |
| Wasserstein, R. L., a Lazar, N. A. (2016). *The ASA statement on p-values: Context, process, and purpose.* *The American Statistician, 70*(2), 129–133. DOI 10.1080/00031305.2016.1154108 | Bibliografický záznam v metadatech Crossref; znění šesti zásad v oficiálním PDF prohlášení. | Zásada 2 (p-hodnota není pravděpodobnost hypotézy ani toho, že výsledek vznikl náhodou), zásada 3 (závěr se nemá opírat jen o překročení hranice) a zásada 4 (úplné uvádění provedených analýz). Doprovodný komentář a diskusní příspěvky čteny nebyly. |
| Simmons, J. P., Nelson, L. D., a Simonsohn, U. (2011). *False-positive psychology: Undisclosed flexibility in data collection and analysis allows presenting anything as significant.* *Psychological Science, 22*(11), 1359–1366. DOI 10.1177/0956797611417632 | Jen bibliografický záznam v metadatech Crossref. | Jedna věta: rozhodnutí přizpůsobená výsledku zvyšují pravděpodobnost chyby I. druhu nad uvedenou hladinu. Plný text nebyl při tvorbě kapitoly čten; tvrzení odpovídá názvu a obecně známému obsahu článku a před případným rozšířením výkladu je třeba je ověřit v textu. Konkrétní čísla z článku se neuvádějí. |

Originály v `sources/` se neměnily a do složky se nic nepřidalo.

<a id="kontrola-dokumentace-2026-10-16"></a>

## 2026-10-16 — Bibliografická kontrola online dokumentace

Kontrola identifikace, dat a hranic dokumentačních celků pro [R42](../rozhodnuti/spolecne-konvence.md#r42-citace-dokumentace), nikoli nové odborné ověření celého jejich obsahu.

- [NIST e-Handbook](https://www.itl.nist.gov/div898/handbook/index2.htm):
  úvod uvádí významnou revizi duben 2012 a Last updated 04/27/2022;
  dle dohody citujeme celek datem 2022-04-27 a DOI 10.18434/M32189.
  Nejde o tvrzení, že všechny jednotlivé oddíly byly změněny v roce 2022.
- [Microsoft Excel](https://support.microsoft.com/cs-cz/excel/):
  ověřen název Nápověda a výuka pro Excel a vymezení celku. Datum
  obsahové revize není uvedeno; rok 2026 je autorem schválené označení
  používané průběžné dokumentace. Přesný den aktualizace se nedoplňuje.
- [R-devel](https://stat.ethz.ch/R-manual/R-devel/doc/html/index.html):
  ověřen dokumentační rozcestník Statistical Data Analysis; stávající
  odkazy míří do společné dokumentace base/stats. [Adresář](https://stat.ethz.ch/R-manual/R-devel/)
  uvádí změny v roce 2026. Rok 2026 dle dohody, verze označena R-devel;
  nejde o archivovanou stabilní verzi ani důkaz data změny každého hesla.
- [SciPy 1.18.0](https://docs.scipy.org/doc/scipy-1.18.0/):
  ověřeno Date: June 19, 2026, Version: 1.18.0. Bibliografie i konkrétní
  odkazy směřují na tuto verzi namísto proměnlivého rozcestníku. Stránky
  percentileofscore a winsorize této verze vracejí HTTP 200; ověřena
  jejich dostupnost a titulky, nikoli nově celý odborný obsah.
- [Shannon Diversity Index](https://www.itl.nist.gov/div898/software/dataplot/refman2/auxillar/shannon.htm):
  samostatná dokumentace Dataplot, mimo e-Handbook; Last updated 10/07/2016.
  Zachována položka nistShannon s datem 2016-10-07.

U průběžných celků datum přístupu 2026-10-16. Odkazy konkrétních částí
byly převzaty ze stávající bibliografie; změna jejich umístění nedokládá
nové prostudování všech stránek ani nezávislé ověření jejich tvrzení.
