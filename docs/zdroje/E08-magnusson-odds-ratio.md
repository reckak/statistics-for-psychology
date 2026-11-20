<a id="e08-magnusson-odds-ratio"></a>

# E08 — Magnusson: interaktivní článek o poměru šancí a poměru rizik

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

Externí webový zdroj; do `sources/` se nic nepřidává a inventář místních souborů se nemění.

**Identita:** Kristoffer Magnusson, *Understanding odds ratios and risk ratios: An interactive explanation*
(verze 1.0.0), R Psychologist, <https://rpsychologist.com/odds-ratio>, klíč `magnussonOddsRatio`.
Titul, verze, datum 2026-11-02 a doporučená citace podle APA 7 převzaty ze stránky (záhlaví a oddíl
„How to cite“) při přístupu 2026-11-20. Cesta ke zdrojovému souboru článku na GitHubu nese jiné datum
(`2026-10-19-odds-ratio`); bibliografie používá datum uvedené na stránce. Stránka uvádí licenci textu
CC BY 4.0; k licenci kódu vizualizací se nevyjadřuje.

**Mapa obsahu (oddíly stránky):** riziko a šance (100 teček, přepínač pohledu); poměr rizik, poměr
šancí a rozdíl rizik ve dvou skupinách po 100 pacientech (30 a 50 remisí); vliv výchozího rizika
(logistická křivka na stupnici logaritmu šancí, volba míry držené pevně); adjustace a nekolapsibilita
poměru šancí; studie případů a kontrol (podíl ponechaných osob bez jevu); kterou míru uvádět.

**Prostudováno:** 2026-11-20 text stránky, popisky obrázků a ovládacích prvků v textové podobě načtené
automaticky. Interaktivní obrázky nebyly prohlédnuty ani vyzkoušeny v prohlížeči a zdrojový kód nebyl
otevřen. Některé popisky obrázků v načteném textu neodpovídaly výchozímu stavu (například šance 0,010
místo 0,43); číselné hodnoty stránky proto nebyly použity.

**Použití:** jen inspirace členěním vizualizace
[Co říkají rozdíl podílů, poměr rizik a poměr šancí o téže tabulce](../../quarto/viz_miry_souvislosti.qmd):
pole osob s pohledem na riziko a na šance, vliv rizika v referenční skupině s mírou drženou pevně
a retrospektivní výběr. Nepřevzat žádný text, kód, obrázek ani příklad; příklady jsou z kapitoly 9
(Danielsová podle Fielda, aspirinová studie podle Howella). Záměrně nepřevzato: stupnice logaritmu
šancí, počet léčených (NNT), adjustace a nekolapsibilita, protože by zaváděly pojmy mimo učebnici
([upřesnění R65](../rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-20-miry)).

**Nezávislé ověření:** odborná tvrzení stránky nebyla samostatně ověřována; všechny hodnoty vizualizace
ověřuje vlastní výpočet v R (`scripts/viz-miry-souvislosti.R`).

## Související karta kapitoly

[Kap. 9: podíly a kategoriální data](../kapitoly/09-podily-kategorialni-data.md#interaktivni-vizualizace-09) — vizualizace měr souvislosti.
