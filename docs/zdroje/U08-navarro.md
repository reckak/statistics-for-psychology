<a id="u08"></a>

# U08 — Navarro — koncepty propojené s R

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

Odkazy na originály v `sources/` jsou místní a vyžadují neveřejné podklady. Stav prostudování a omezení určují záznamy níže.

**Soubor:** [navarro.pdf](../../sources/u%C4%8Debnice/navarro.pdf).

**Identita:** Danielle Navarro: *Learning Statistics with R*. Titul PDF 1; předmluva PDF 17–18 popisuje přepracování původní verze do Quarta a dodatečné epilogy. Přesný rok a číslo vydání tohoto PDF nejsou doloženy. Nepřiřazovat automaticky rok 2015 starší verze. Obsah PDF 2–16.

**Doporučené použití:** Srozumitelná diskuse statistického uvažování, pojetí pravděpodobnosti a inferenčních předpokladů; R zůstává u nás interní, studentský výklad na něm nesmí záviset.

| Lokátor | Mapa obsahu |
|---|---|
| [s. 25 (PDF 25)](../../sources/u%C4%8Debnice/navarro.pdf#page=25) | 1 Proč statistika |
| [s. 37 (PDF 37)](../../sources/u%C4%8Debnice/navarro.pdf#page=37) | 2 Výzkumný design |
| [s. 68 (PDF 68)](../../sources/u%C4%8Debnice/navarro.pdf#page=68) | 3 Úvod do R: prostředí, výpočty, objekty, vektory a indexování |
| [s. 111 (PDF 111)](../../sources/u%C4%8Debnice/navarro.pdf#page=111) | 4 Mechanismy R: balíčky, pracovní prostředí, soubory a datové struktury |
| [s. 158 (PDF 158)](../../sources/u%C4%8Debnice/navarro.pdf#page=158) | 5 Popisná statistika: poloha s. 159, variabilita s. 170, šikmost s. 182, z-skóry s. 191, korelace s. 193 |
| [s. 214 (PDF 214)](../../sources/u%C4%8Debnice/navarro.pdf#page=214) | 6 Grafy: histogram s. 230, boxplot s. 236, bodový graf s. 249, sloupcový s. 255 |
| [s. 265 (PDF 265)](../../sources/u%C4%8Debnice/navarro.pdf#page=265) | 7 Práce s daty v R: křížové tabulky, překódování, podmnožiny, spojování a změna uspořádání dat |
| [s. 344 (PDF 344)](../../sources/u%C4%8Debnice/navarro.pdf#page=344) | 8 Programování v R |
| [s. 371 (PDF 371)](../../sources/u%C4%8Debnice/navarro.pdf#page=371) | 9 Pravděpodobnost: významy s. 373, základní pravidla s. 379, binomické rozdělení s. 381, normální s. 387 |
| [s. 403 (PDF 403)](../../sources/u%C4%8Debnice/navarro.pdf#page=403) | 10 Odhad: výběr s. 403, zákon velkých čísel s. 412, výběrová rozdělení a CLT s. 415, odhad parametrů s. 421, CI s. 428 |
| [s. 439 (PDF 439)](../../sources/u%C4%8Debnice/navarro.pdf#page=439) | 11 Testování: chyby s. 443, p-hodnota s. 450, účinek a síla s. 457, problémy s. 464 |
| [s. 471 (PDF 471)](../../sources/u%C4%8Debnice/navarro.pdf#page=471) | 12 Kategoriální data: dobrá shoda, nezávislost, Fisher s. 499, McNemar s. 502 |
| [s. 508 (PDF 508)](../../sources/u%C4%8Debnice/navarro.pdf#page=508) | 13 t-testy: jeden výběr s. 516, Student s. 521, Welch s. 532, párový s. 536, účinek s. 551 |
| [s. 566 (PDF 566)](../../sources/u%C4%8Debnice/navarro.pdf#page=566) | 14 Jednofaktorová ANOVA: účinek s. 586, vícenásobná porovnání s. 587, předpoklady s. 594 |
| [s. 609 (PDF 609)](../../sources/u%C4%8Debnice/navarro.pdf#page=609) | 15 Regrese: více prediktorů s. 614, předpoklady s. 630, diagnostika s. 631 |
| [s. 660 (PDF 660)](../../sources/u%C4%8Debnice/navarro.pdf#page=660) | 16 Faktorová ANOVA: interakce s. 673, GLM s. 691, kontrasty s. 705 |
| [s. 735 (PDF 735)](../../sources/u%C4%8Debnice/navarro.pdf#page=735) | 17 Bayesovská statistika: princip s. 736, testy s. 741, kategoriální data s. 752, t-test s. 759, regrese s. 762, ANOVA s. 767 |

**Prostudované pasáže:** Obsah, předmluva a §9.2, s. 373–375: různé významy pravděpodobnosti, opakované hody, dlouhodobá četnost a její interpretace.

**Nálezy a neověřené části:** Kód R, závislosti a epilogy nejsou kompletně spuštěny ani revidovány. Pozdější bayesovské kapitoly jsou pouze zmapované.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** přečteny s. 373–377 včetně kontextu model → data versus data → model, četnostního výkladu a úvodu k subjektivnímu pojetí. Obr. 9.1 byl čten jen v extrakci, nová vizuální kontrola neproběhla. Návrh vlastní simulace má ukazovat kolísání relativních četností, nikoli slib monotónního přibližování nebo přesného vyrovnání krátké řady.

**Doplnění při přípravě kapitoly 6 (2026-10-12):** v textové extrakci přečteny §11.1–11.2 a začátek §11.3 (podle obsahu knihy s. 440–446): výzkumná versus statistická hypotéza na příkladu 62 správných odpovědí ze 100, nulová a alternativní hypotéza, dva druhy chyb, hladina významnosti a síla, testová statistika a její výběrové rozdělení za platnosti nulové hypotézy. Využitelné pro blok B: test se týká statistické hypotézy a její vazbu na výzkumnou hypotézu zajišťuje uspořádání studie (§11.1.1); poznámka o sporném jazyku závěrů (§11.2, pozn. 4). Formulace, že cílem testu je ukázat, že nulová hypotéza je „(probably) false“ (§11.1.2), se nepřebírá: p-hodnota není pravděpodobnost hypotézy. Přesné strany jednotlivých tvrzení nebyly v extrakci ověřeny; vizuální kontrola neproběhla. §11.4–11.9 a kap. 10 zůstávají ve stavu mapy obsahu.


## Související karty kapitol

Tematické vazby pro výběr podkladů: [kapitola 1](../kapitoly/01-otazka-data.md#mapa-kapitola-01), [kapitola 5](../kapitoly/05-pravdepodobnost.md#mapa-kapitola-05), [kapitola 6](../kapitoly/06-vyberove-rozdeleni-testovani.md#mapa-kapitola-06). Konkrétní použití a stav ověření určují záznamy výše.
