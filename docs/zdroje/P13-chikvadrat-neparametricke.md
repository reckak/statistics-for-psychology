<a id="p13"></a>

# P13 — Testy pro kategorické proměnné a neparametrické metody, PSYb1170, 2026

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

**Místní soubor:** [PSYb1170_P11_2026_-_chi-square_dvjyqruf.pptx](../../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/PSYb1170_P11_2026_-_chi-square_dvjyqruf.pptx), 44 snímků; SHA-256 `8d6b2e360be765fa`. Titul přednáška 11, rok 2026; metadata tvůrce Jan Širůček, editor Stanislav Ježek, změna 2026-05-06. Kontrola 2026-10-17; číslování včetně skrytých snímků.

| Snímky | Obsah a možné využití |
|---|---|
| 1–5 | Historická motivace testování, Arbuthnot a poměr narozených chlapců a dívek. |
| 6–8 | Jeden podíl, z-test a interval. |
| 9–23 | Dobrá shoda, očekávané četnosti, chí-kvadrát, df a p-hodnota; příklad „Mindgatherers“. |
| 24–27 | Porovnání dvou podílů; skryté snímky. |
| 28–37 | Nezávislost v tabulce 3 × 3, obuv; velikost účinku a rezidua. |
| 38–40 | McNemarův a Bowkerův test pro párová data; skryté snímky. |
| 41–44 | Znaménkový a mediánový test; zmínky o Wilcoxonově a Mannově–Whitneyově postupu. |

**Prostudováno:** text, poznámky a všechny obrazové přehledy exportované PowerPointem včetně skrytých snímků.

**Nálezy:** sn. 15 používá N = 77, přestože četnosti 2, 33 a 44 dávají **79**; další výpočet na sn. 20 již používá 79. Sn. 25 uvádí 63 % u skupiny s četností 44 z 79, tedy přibližně **55,7 %**; sn. 27 již pracuje s 56 %. Tyto vnitřní rozpory byly ověřeny aritmeticky a v obrazu. U sn. 36 je před použitím potřeba rozlišit Pearsonova rezidua od reziduí dělených odhadem jejich vlastní směrodatné odchylky; oba typy odlišuje [R, `chisq.test`, Value](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/chisq.test.html) (R-devel, přístup 2026-10-17). Samotné dělení odmocninou očekávané četnosti není obecně standardizací na jednotkový rozptyl v tabulce nezávislosti.

**Použití a neověřeno:** názorné návaznosti očekávaných četností a volby testu; doplněk [P12](P12-kategorialni-data.md#p12) a [C09](C09-ulohy-tyden-12.md#c09). Historické tvrzení o Arbuthnotovi a originální článek nebyly nezávisle prověřeny. Výpočty všech testů, podmínky párových testů a úplné předpoklady uvedených neparametrických metod nebyly ověřeny. Animace a odkazy nebyly spuštěny, vzorce v Excelu nebyly testovány. Rozsah posledního bloku nepředstavuje úplný výklad neparametrické statistiky.
