<a id="p08"></a>

# P08 — Testování hypotéz o průměrech, STPS 2025

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

**Místní soubor:** [prezentace_průměry.pptx](../../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/prezentace_pr%C5%AFm%C4%9Bry.pptx), 46 snímků; SHA-256 `9924a1284797f8e6`. Titul uvádí STPS 2025; metadata jméno Karel Rečka a změnu 2025-12-19. Metadata nedokládají původ všech příkladů. Kontrola 2026-10-17.

| Snímky | Obsah a možné využití |
|---|---|
| 1–10 | Výběrová rozdělení, SE a CLT včetně obrazů simulací. |
| 11–13 | Jednovýběrový z-test při známé populační SD; skóry s hypotetickým průměrem 50. |
| 14–21 | Interval, kritické hodnoty, jednostranná a oboustranná p-hodnota. |
| 22–28 | Neznámá SD, t-rozdělení a stupně volnosti; příklad PDI dětí s nízkou porodní hmotností podle Nurcombeho. |
| 29–33 | Párový t-test; hmotnost před terapií a po ní, variabilita rozdílů a kovariance. |
| 34–41 | Dva nezávislé výběry, společný odhad rozptylu a t-test; příklad odkazující na Adamse, Wrighta a Lohra. |
| 42–44 | Standardizované rozdíly průměrů, Cohenovy a Hedgesovy míry. |
| 45–46 | Předpoklady testů a souhrnný přehled. |

**Prostudováno:** text snímků a dostupné poznámky; vizuálně všechny snímky v přehledech exportovaných PowerPointem. Aritmetika níže přepočtena nezávisle v R.

**Ověřené nálezy:** sn. 32 kombinuje průměry 37,75 a 41,05 s jiným dosazením 38,87 − 37,51 = 1,364; rozdíl prvních dvou zobrazených průměrů je 3,30. Sn. 39 uvádí √9,11 = 2,48, ale správně je přibližně 3,018; následující snímek již pracuje s hodnotou kolem 3,02. Sn. 40–41 počítají stupně volnosti z 38 + 29 − 2, zatímco zadání uvádí n₁ = 35 a n₂ = 29, tedy 62 stupňů volnosti. Před převzetím sjednotit celý řešený příklad, nejen konečný výsledek.

**Použití a neověřeno:** vhodné pro porovnání návaznosti z-testu, jednovýběrového, párového a nezávislého t-testu; srovnat [P09](P09-nezavisly-ttest.md#p09) a [C08](C08-ulohy-tyden-9.md#c08). Celý soubor výpočtů, korekce velikostí účinku a původní empirické studie nebyly ověřeny. Animace, odkazy a externí simulace nebyly spuštěny; české excelové vzorce nebyly testovány v Excelu. Rozsah t-testů v budoucí kapitole není touto kartou schválen.


<a id="priprava-07-20261017"></a>

## Čtení pro návrh kapitoly 7 — 2026-10-17

Z originálu přečten text a poznámky relevantního bloku sn. 11–28, zejména známá/neznámá σ, interval a jednovýběrový test. Sn. 20 prohlédnut v dřívějším exportu shodného souboru. Využití pro návrh: propojení testu a intervalu a návaznost na Howella.

**Zpřesnění sn. 20:** vztah jednostranného testu na hladině α k příslušné mezi centrálního intervalu se spolehlivostí 1 − 2α vyžaduje kontrolu správného směru. Nejde o obecný požadavek reportovat pouze takový interval; alternativou je odpovídající jednostranná mez se spolehlivostí 1 − α. Rovnost p-hodnoty a α znamená, že testovaná hodnota leží přesně na mezi, nikoli vně uzavřeného intervalu. Obojí je důležité při formulaci obecného pravidla.

Výpočet PDI ze souhrnů znovu ověřen v R, viz [U01](U01-howell.md#priprava-07-20261017); jiné části prezentace nebyly v tomto průchodu kompletně přepočteny. Odborný závěr o rychlosti vývoje nebo původní empirická studie nebyly nezávisle ověřeny.

[Společný rozsah kontroly](HISTORIE.md#priprava-07-20261017).

## Související karty kapitol

Tematické vazby pro výběr podkladů: [kapitola 7](../kapitoly/07-interval-t-test-ekvivalence.md#mapa-kapitola-07). Konkrétní použití a stav ověření určují záznamy výše.
