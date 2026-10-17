<a id="p12"></a>

# P12 — Práce s kategorickými daty, STPS 2025

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

**Místní soubor:** [categorical_data_prezentace.pptx](../../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/categorical_data_prezentace.pptx), 53 snímků; SHA-256 `0e96d488baee9428`. Titul STPS 2025; metadata Karel Rečka, změna 2025-12-19. Kontrola 2026-10-17. Název karty reprodukuje název přednášky; terminologickou preferenci učebnice určuje slovník.

| Snímky | Obsah a možné využití |
|---|---|
| 1–7 | Kategoriální proměnné, očekávané četnosti, chí-kvadrát a vztah k z². |
| 8–14 | Jeden podíl, binomický a z-test, intervaly včetně úpravy „plus four“. |
| 15–17 | Dva podíly; příklad 36/60 oproti 20/50. |
| 18–19 | Dobrá shoda: noční příjmy 30, 21 a 24. |
| 20–28 | Nezávislost v tabulce 3 × 3, stres a zvládání; rezidua. |
| 29–30 | Fisherův exaktní test a Monte Carlo. |
| 31–36 | Párová binární data a McNemarův test. |
| 37 | Cochranův–Mantelův–Haenszelův postup a Simpsonův paradox. |
| 38–46 | Rozdíl rizik, relativní riziko, poměr šancí, intervaly, fí a Cramerovo V. |
| 47–50 | Shoda hodnotitelů a Cohenovo kappa. |
| 51–53 | Předpoklady a souhrn metod. |

**Prostudováno:** text, poznámky a všechny obrazové přehledy z PowerPointu. Nezávisle v R přepočten součet párové tabulky a příklad kappa.

**Ověřené nálezy:** příklad McNemarova testu na sn. 31–36 uvádí 70 osob, ale čtyři četnosti 38, 4, 12 a 18 dávají **72**; počet nesouhlasných párů 16 se touto opravou nemění. Ve výpočtu kappa na sn. 48–49 je chybný mezikrok s počtem shod 26: diagonála tabulky je 15 + 3 + 3 = **21** z 30, očekávaný počet shod 12,9333. Kappa vychází **0,472656**, takže konečné zaokrouhlení 0,47 souhlasí; opravu potřebuje mezivýpočet a jeho zápis.

**Použití a neověřeno:** široký přehled pro výběr metod podle designu; porovnat [P13](P13-chikvadrat-neparametricke.md#p13) a [C09](C09-ulohy-tyden-12.md#c09). Neproběhl úplný přepočet testů a intervalů, kontrola aproximací při malých četnostech ani nezávislé ověření všech vzorců velikostí účinku. Fisherův test a Monte Carlo nebyly reprodukovány podle prezentace. Animace, externí demonstrace a excelové vzorce nebyly testovány; klinické či empirické kontexty nejsou ověřenými doporučeními.
