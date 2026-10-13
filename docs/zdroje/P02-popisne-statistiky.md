<a id="p02"></a>

# P02 — Popisné statistiky, PSYb1170, 2026

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

Odkazy na originály v `sources/` jsou místní a vyžadují neveřejné podklady. Stav prostudování a omezení určují záznamy níže.

**Soubor:** [PSYb1170_P02_2026_-_Popisne_statistiky.pptx](../../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/PSYb1170_P02_2026_-_Popisne_statistiky.pptx); 53 snímků.

| Snímky | Obsah a využití |
|---|---|
| 3–13 | Popis a tvary rozdělení; grafické porovnávání. |
| 14–21 | Modus, medián, průměr, vztah k tvaru; příklady k diskusi. |
| 22–30 | Variabilita: entropie (rozšíření), rozpětí, kvartily, rozptyl, SD a souvislost s tvarem. |
| 31–34 | Boxplot, konstrukce, odlehlé hodnoty a čtení grafu. |
| 35–39 | Účinky lineární transformace; poloha jako minimalizace různých ztrát; momentové a pořadové statistiky. |
| 40–44 | Percentily, významy „kvartilu“, algoritmy kvantilů a interpolace; medián z intervalových četností. |
| 45–48 | Popis pomocí empirického rozdělení a pomocí modelu, příklady parametrických modelů. |
| 49–53 | Volba a reportování popisných statistik, shrnutí a ilustrační závěrečný obrázek. |

**Nálezy:** sn. 27 má pro třetí kvartil `0,75(N + 1) + 1`, zatímco sn. 24 používá `0,75(N − 1) + 1`; před použitím srovnat s projektovým algoritmem R04. „Diskrétní“ postup na sn. 42 není obecně totožný s projektovým kvantilem pro ordinální data. Sn. 29 odvozuje označení špičatosti z porovnání IQR a 2 SD; není to obecná definice koeficientu špičatosti. Používat R14 a současnou kapitolu 3.

**Ověření obrázku:** sn. 43 skutečně obsahuje 11 hodnot, začíná číslem 3 a následně 7, 9, 9. V textové extrakci první číslo chybělo. Nejde tedy o doloženou chybu počtu hodnot ani čtvrté pořadové hodnoty. Tento případ ukazuje nutnost ověřovat podezřelé nálezy vizuálně.

**Neověřeno:** kompletní početní audit všech vzorců a modelových příkladů, externí příklady a odkazy. Starší označení `MAD`, `M`, `SD` převádět podle R01; nelze je bez rozlišení přepsat do výpočetního značení knihy.


## Související karty kapitol

Tematické vazby pro výběr podkladů: [kapitola 3](../kapitoly/03-poloha-variabilita.md#mapa-kapitola-03). Konkrétní použití a stav ověření určují záznamy výše.
