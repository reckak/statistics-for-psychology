<a id="p09"></a>

# P09 — Nezávislý t-test a velikost účinku, PSYb1170, 2026

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

**Místní soubor:** [PSYb1170_P09_2026_-_nezavisly_ttest_ES.pptx](../../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/PSYb1170_P09_2026_-_nezavisly_ttest_ES.pptx), 50 snímků; SHA-256 `9650a709387b3dbb`. Titul označuje přednášku 9, rok 2026; metadata Stanislav Ježek, změna 2026-04-14. Kontrola 2026-10-17.

| Snímky | Obsah a možné využití |
|---|---|
| 1–10 | Design porovnání skupin, otázka intervence/interference a paměti, rozdělení rozdílu průměrů. |
| 11–16 | Nulová hypotéza, SE rozdílu, oboustranný test; n = 39 a 42, průměry 16,7 a 15,9, SD 5,8 a 5,2. |
| 17–22 | Jednostranné alternativy a směr rozdílu. |
| 23–26 | Interval spolehlivosti rozdílu průměrů. |
| 27–34 | Cohenovo d, Glassovo delta a pravděpodobnostní vyjádření velikosti účinku. |
| 35–40 | Standardizace rozdílů, vztah k r a r². |
| 41–48 | Reportování, předpoklady, Welchův test a normalita. |
| 49–50 | Fisherova transformace při testování korelace a rozdílu korelací. |

**Rozsah čtení:** zmapován extrahovaný text snímků a dostupné poznámky, prohlédnuty všechny obrazové přehledy; podrobněji kontrolován příklad testu a intervalu, sn. 25 navíc v plné velikosti. Příklad intervalu nezávisle přepočten v R; porovnány vzorce a stupně volnosti s [NIST, Two-Sample t-Test for Equal Means](https://www.itl.nist.gov/div898/handbook/eda/section3/eda353.htm) (přístup 2026-10-17).

**Ověřené nálezy:** sn. 25 používá v intervalu 0,8 ± 0,65 × 1,99 hodnotu testové statistiky místo směrodatné chyby. Z uvedených souhrnů vychází Welchova SE = 1,22734, df = 76,4313 a 95% interval přibližně **(−1,644; 3,244)**; při společném odhadu rozptylu SE = 1,22235, df = 79 a interval **(−1,633; 3,233)**. Zobrazené meze (−0,50; 2,10) neodpovídají ani jedné variantě. Sn. 16 kombinuje SE bez společného odhadu rozptylu s df = n₁ + n₂ − 2; varianty testu je třeba držet pohromadě. Nejde jen o zaokrouhlení.

**Použití a neověřeno:** vhodné pro rozhodování podle designu, interpretaci rozdílu a velikosti účinku; souvisejí [P08](P08-prumery.md#p08) a [C08](C08-ulohy-tyden-9.md#c08). Ostatní početní příklady a všechny převody velikostí účinku nebyly kompletně přepočteny. U Fisherových testů sn. 49–50 je nutné před použitím ověřit směr testu, absolutní hodnotu u oboustranné p-hodnoty a předpoklady aproximace. Animace, živé odkazy a chování Excelu nebyly testovány.
