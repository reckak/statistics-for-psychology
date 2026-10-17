<a id="c09"></a>

# C09 — Úlohy, týden 12, 2021: kategoriální data a chí-kvadrát

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

**Místní soubor:** [ulohy_tyden12_2021_v1.0.docx](../../sources/p%C5%99%C3%ADklady%20k%20procvi%C4%8Dov%C3%A1n%C3%AD/ulohy_tyden12_2021_v1.0.docx), SHA-256 `b3a012997108fc8c`. Metadata: Andrea Staňková, změna 2021-05-19; autorství jednotlivých převzatých částí není samostatně ověřeno. Kontrola 2026-10-17; úlohy mají prefix **X12**.

| ID zadání / stejný lokátor v oddílu „SPRÁVNÁ ŘEŠENÍ“ | Obsah a možné využití |
|---|---|
| X12_01 | Pojmy a volba testu podle typu otázky. |
| X12_02–05 | Dobrá shoda a nezávislost: dny v týdnu, volby, tužky a bonbony; formulace různých nulových hypotéz. |
| X12_06 | Potřeba kognice, kontext otázky a hraní her; individuální data i souhrnná kontingenční tabulka. |
| X12_07–08 | Reakce na terapii a preference učitelů; očekávané četnosti a kritická hodnota. |
| X12_09 | Souvislost diabetu a hojení v tabulce 2 × 2. |
| X12_10–11 | Volby s kritickou hodnotou a souvislost pohlaví se studiem. |
| X12_100 | Přehled terminologie. |

**Rozsah čtení:** zmapována zadání i klíč podle textu a tabulek z OOXML; podrobněji přečteny zejména X12_06 a X12_09. Šest vložených mediálních položek nebylo úplně obrazově ověřeno. Export Wordu se zablokoval; celé vykreslení a stránkování nejsou potvrzeny.

**Dílčí nezávislá kontrola, vizuální potvrzení tabulky zbývá:** u řešení X12_06 uvádí poslední buňka očekávanou četnost 30. Pro textově extrahovanou tabulku (10, 20, 30) a (20, 30, 10) jsou očekávané četnosti v obou řádcích **15, 25, 20**. Přepočet v R dává χ² = **15,3333**, df = 2, p = **0,0004682** a Cramerovo V = **0,357460**. Konečné χ² a V v klíči tedy souhlasí; problém je v jedné uvedené očekávané četnosti a zápis p = 0,000 by se při převzetí nahradil např. p < 0,001. Opravu originálu uzavřít až po kontrole jeho vykreslení.

**Použití a neověřeno:** návaznost na [P12](P12-kategorialni-data.md#p12) a [P13](P13-chikvadrat-neparametricke.md#p13), zejména rozlišení dobré shody a nezávislosti, formulace hypotéz a interpretace tabulky. Celý klíč nebyl přepočten; podmínky testů, grafická zadání a empirický původ příkladů nebyly úplně ověřeny. X12_09 vyžaduje před převzetím kontrolu volby chvostu a excelové funkce pro p-hodnotu; uvedený vzorec nebyl spuštěn v českém Excelu. Klinické příklady slouží jako podklad k metodické otázce, nikoli jako ověřené medicínské závěry.
