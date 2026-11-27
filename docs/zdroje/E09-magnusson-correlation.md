<a id="e09-magnusson-correlation"></a>

# E09 — Magnusson: interaktivní vizualizace korelace

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

Externí webový zdroj; do `sources/` se nic nepřidává a inventář místních souborů se nemění.

**Identita:** Kristoffer Magnusson, *Interpreting correlations: An interactive visualization*
(verze 0.8.0), R Psychologist, <https://rpsychologist.com/correlation/>, klíč `magnussonCorrelation`.
Citaci podle APA 7 s označením „[Web App]“ zadal autor 2026-11-23; shoduje se s doporučenou citací
na stránce. Verze 0.8.0 je uvedena pod titulem a v oddílu FAQ, datum 2026-10-24 v doporučeném záznamu
BibTeX stránky (typ `@software`); bibliografie učebnice používá `@online` s polem `type = {Web App}`,
aby citace odpovídala zadanému znění. Přístup 2026-11-23. Stránka uvádí vizualizaci jako volné dílo
(CC0), zdrojový kód pod licencí MIT a text pod licencí CC BY 4.0.

**Mapa obsahu (prvky stránky):** posuvník a číselné pole korelace; úprava bodů (přesun, přidání,
smazání); nastavení s novým výběrem zvolené velikosti, průměry a směrodatnými odchylkami, přizpůsobením
os, načtením CSV a uložením stavu v prohlížeči; předvolby malá, střední a velká korelace, Anscombův
kvartet a „Anscombosaurus“; pravděpodobnostní elipsy 50, 80, 95 a 99 % pro dvourozměrné normální
rozdělení s výběrovými momenty; graf spojnic; Vennův diagram sdíleného rozptylu (*r*²); vzorce regresní
přímky; FAQ s popisem generování dat (*z*-skóry, odstranění korelace a Choleského rozklad, takže výběrová
korelace je přesně zvolená).

**Prostudováno:** 2026-11-23 text stránky načtený automaticky (titul, verze, citace, licence, popis
ovládání, elips, Vennova diagramu a generování dat) a dva snímky obrazovky, které autor připojil k zadání.
Aplikace nebyla vyzkoušena v prohlížeči a zdrojový kód nebyl otevřen.

**Použití:** jen inspirace ovládáním a výběrem prvků vizualizace
[Jak tvar mraku bodů souvisí s korelačním koeficientem](../../quarto/viz_korelace.qmd): posuvník přesné
výběrové korelace, úprava bodů v grafu, pole průměrů a směrodatných odchylek, regresní přímka, rezidua,
pravděpodobnostní elipsy, Vennův diagram a graf spojnic. Nepřevzat žádný text, kód, obrázek ani data;
příklady jsou z kapitol 8 a 10 a Anscombův kvartet podle [E07](E07-anscombe-1973.md#e07-anscombe-1973).
Vlastní doplňky: kvadranty se součiny odchylek, Spearmanův korelační koeficient, test a Fisherův
interval, bodový graf pořadí a počty bodů uvnitř elips. Nepřevzato: načtení CSV, uložení stavu
a předvolba „Anscombosaurus“ ([upřesnění R65](../rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-23-korelace)).

**Nezávislé ověření:** odborná tvrzení stránky nebyla samostatně ověřována; všechny hodnoty vizualizace
ověřuje vlastní výpočet v R (`scripts/viz-korelace.R`).

## Související karta kapitoly

[Kap. 10: korelace](../kapitoly/10-korelace.md#interaktivni-vizualizace-10) — vizualizace korelace v bodovém grafu.
