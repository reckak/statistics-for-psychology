<a id="c08"></a>

# C08 — Úlohy, týden 9, 2025: porovnání průměrů

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

**Místní soubor:** [ulohy_tyden09_2025.docx](../../sources/p%C5%99%C3%ADklady%20k%20procvi%C4%8Dov%C3%A1n%C3%AD/ulohy_tyden09_2025.docx), SHA-256 `6c9a99a243a4cab7`. Metadata: tvůrce Andrea Staňková, poslední editor „Standa Ježek“, změna 2025-04-23; nikoli ověření autorství všech úloh. Kontrola 2026-10-17; původní prefix je **X11**.

| ID zadání / stejný lokátor v oddílu „SPRÁVNÁ ŘEŠENÍ“ | Obsah a možné využití |
|---|---|
| X11_02–10 | Tvar t-rozdělení, předpoklady testu, p-hodnoty a kvantily. |
| X11_12; X11_15–16 | SE rozdílu, předpoklady a kritické hodnoty. |
| X11_18 | Rozdíl osobní potřeby struktury mezi dvěma skupinami; souhrny n = 47 a 50. |
| X11_19 | Čtení a párování položek; rozhodnutí mezi závislými a nezávislými daty. |
| X11_20–21 | Příklady mateřské školy a hněvu, porovnávání skupin. |
| X11_23 | Porovnání jednoho výsledku GPT s lidským souborem a porovnání párovaných řad. |
| X11_24 | Zaměstnanost a používání mobilu; volba postupu a interpretace rozdílu skupin. |

**Úplnost:** chybějí zadání X11_01, X11_11, X11_13–14, X11_17 a X11_22. X11_17 se objevuje pouze v řešeních. Mezery v číslování nepřepisovat.

**Rozsah čtení:** zmapována zadání i místní řešení podle textu a tabulek z OOXML; podrobněji čteny konceptuální otázky X11_03–05 a vybrané pasáže k předpokladům. Pět mediálních položek nebylo úplně obrazově prověřeno; export ve Wordu se zablokoval, takže kompletní sazba a stránkování zůstávají neověřené.

**Rozpory k potvrzení v originálním vykreslení:** u X11_03 klíč vybírá pro t-rozdělení s malým počtem stupňů volnosti možnost „platykurtický“. T-rozdělení má těžší chvosty než normální rozdělení; žádná z uvedených možností nepopisuje jeho tvar správně. U X11_05 vysvětlení připisuje centrálnímu t-rozdělení SD = 1. Jeho rozptyl je však ν/(ν − 2) pro ν > 2; SD tedy přesahuje 1 a při malých ν nemusí být konečná. Vlastnost nezávisle ověřena v [R, `TDist`, Details](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/TDist.html) (R-devel, přístup 2026-10-17). Toto ověřuje matematickou vlastnost; vzhledem k chybějícímu vykreslení se zde neuzavírá vizuální kontrola zadání a klíče.

**Použití a neověřeno:** sada vhodná pro výběr testu podle designu a čtení souhrnných výsledků; srovnat [P08](P08-prumery.md#p08) a [P09](P09-nezavisly-ttest.md#p09). Početní řešení nebyla kompletně reprodukována a empirický původ dat ani validita porovnání jednoho systému s lidským vzorkem nejsou ověřeny. Před použitím přezkoumat předpoklady každého designu, zacházení s nestejnými rozptyly a dostupnost vstupních dat. Excel ani externí zdroje úloh nebyly testovány.


<a id="priprava-07-20261017"></a>

## Čtení pro návrh kapitoly 7 — 2026-10-17

Při výběru podkladů kapitoly 7 přečten úvod souboru z OOXML: X11_02–10, X11_12/15–16 a X11_18–19. Většina materiálu patří budoucímu porovnávání skupin. Pro kapitolu 7 jsou využitelné náměty symetrie t-rozdělení, vlivu stupňů volnosti a čtení kvantilů; nikoli automatické převzetí odpovědí. X11_19 pracuje s rozdíly a s úlohami jako jednotkami a zůstává mimo navržený základ. Řešení, vložený excelový objekt, úplné vykreslení a zbytek sady se v tomto průchodu neověřovaly.

[Společný rozsah kontroly](HISTORIE.md#priprava-07-20261017).
