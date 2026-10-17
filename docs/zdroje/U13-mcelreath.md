<a id="u13"></a>

# U13 — McElreath — Statistical Rethinking, 2. vydání

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

Odkazy na originál v `sources/` jsou místní a vyžadují neveřejný podklad.

**Identita:** McElreath, R. (2020). *Statistical Rethinking: A Bayesian Course with Examples in R and Stan* (2. vyd.). CRC Press. Titul a vydání ověřeny na PDF 4, nakladatelské údaje na PDF 5; ISBN 978-0-367-13991-9 (tištěná kniha), 978-0-429-02960-8 (elektronická kniha). **Soubor:** [mcelreath.pdf](../../sources/u%C4%8Debnice/mcelreath.pdf), 612 stran PDF, SHA-256 `14e2f9d07647e349`. Kontrola 2026-10-17.

## Mapa obsahu

Obsah knihy je na s. v–vii (PDF 6–8). Tabulka uvádí začátky všech kapitol; tištěné arabské stránce odpovídá **PDF = s. + 19**. Posun byl ověřen na všech 17 začátcích kapitol, nikoli odhadnut z titulní strany. Tematické popisy slouží k výběru pasáží, nejsou schválenou terminologií učebnice.

| Kapitola | Začátek: s. / PDF | Obsah a možné využití |
|---|---|---|
| 1. The Golem of Prague | [1 / 20](../../sources/u%C4%8Debnice/mcelreath.pdf#page=20) | Modelování, statistické uvažování, vztah modelu a výzkumné otázky. |
| 2. Small Worlds and Large Worlds | [19 / 38](../../sources/u%C4%8Debnice/mcelreath.pdf#page=38) | Konstrukce pravděpodobnostního modelu, prior, věrohodnost a posterior; příklad házení glóbem. |
| 3. Sampling the Imaginary | [49 / 68](../../sources/u%C4%8Debnice/mcelreath.pdf#page=68) | Simulované výběry z posterioru, jeho shrnutí a predikce. |
| 4. Geocentric Models | [71 / 90](../../sources/u%C4%8Debnice/mcelreath.pdf#page=90) | Normální model, výšky, lineární predikce a křivky. |
| 5. The Many Variables & The Spurious Waffles | [123 / 142](../../sources/u%C4%8Debnice/mcelreath.pdf#page=142) | Zdánlivé a maskované vztahy, více prediktorů, kategoriální proměnné. |
| 6. The Haunted DAG & The Causal Terror | [161 / 180](../../sources/u%C4%8Debnice/mcelreath.pdf#page=180) | Multikolinearita, výběr kontrolních proměnných a kauzální diagramy. |
| 7. Ulysses’ Compass | [191 / 210](../../sources/u%C4%8Debnice/mcelreath.pdf#page=210) | Přeučení, entropie, regularizace, predikční přesnost a porovnání modelů. |
| 8. Conditional Manatees | [237 / 256](../../sources/u%C4%8Debnice/mcelreath.pdf#page=256) | Interakce a jejich symetrie; spojité prediktory. |
| 9. Markov Chain Monte Carlo | [263 / 282](../../sources/u%C4%8Debnice/mcelreath.pdf#page=282) | Metropolisův algoritmus, Hamiltonovské Monte Carlo, Stan a diagnostika řetězců. |
| 10. Big Entropy and the Generalized Linear Model | [299 / 318](../../sources/u%C4%8Debnice/mcelreath.pdf#page=318) | Maximální entropie, zobecněné lineární modely a priory. |
| 11. God Spiked the Integers | [323 / 342](../../sources/u%C4%8Debnice/mcelreath.pdf#page=342) | Binomické, Poissonovy, multinomické a kategoriální modely. |
| 12. Monsters and Mixtures | [369 / 388](../../sources/u%C4%8Debnice/mcelreath.pdf#page=388) | Rozšíření diskrétních modelů, směsi a ordinální výsledky. |
| 13. Models With Memory | [399 / 418](../../sources/u%C4%8Debnice/mcelreath.pdf#page=418) | Víceúrovňové modely, částečné sdílení informace mezi skupinami. |
| 14. Adventures in Covariance | [435 / 454](../../sources/u%C4%8Debnice/mcelreath.pdf#page=454) | Kovarianční struktury, víceúrovňové modely a další závislosti. |
| 15. Missing Data and Other Opportunities | [489 / 508](../../sources/u%C4%8Debnice/mcelreath.pdf#page=508) | Chyba měření a chybějící data. |
| 16. Generalized Linear Madness | [525 / 544](../../sources/u%C4%8Debnice/mcelreath.pdf#page=544) | Modely vycházející z mechanismu; příklad skrytých procesů a pozorovaného chování. |
| 17. Horoscopes | [553 / 572](../../sources/u%C4%8Debnice/mcelreath.pdf#page=572) | Závěrečná reflexe statistického modelování. |

Poznámky začínají na s. 557 (PDF 576), bibliografie na s. 573 (PDF 592), citační rejstřík na s. 585 (PDF 604) a věcný rejstřík na s. 589 (PDF 608).

**Přesnější tematické lokátory podle obsahu:** konstrukce modelu §2.2 s. 28 (PDF 47), jeho složky §2.3 s. 32 (PDF 51), výpočet §2.4 s. 36 (PDF 55), procvičování §2.6 s. 46 (PDF 65); predikce §3.3 s. 61 (PDF 80); původ normálního rozdělení §4.1 s. 72 (PDF 91), model výšek §4.3 s. 78 (PDF 97); zdánlivé vztahy §5.1 s. 125 (PDF 144); zkreslení při kontrole proměnné ovlivněné intervencí §6.2 s. 170 (PDF 189), collider §6.3 s. 176 (PDF 195); binomické modely §11.1 s. 324 (PDF 343); chyba měření §15.1 s. 491 (PDF 510), chybění §15.2 s. 499 (PDF 518). Lokátory pododdílů jsou mapou, nikoli dokladem jejich podrobného čtení.

## Rozsah čtení, použití a omezení

**Prostudováno 2026-10-17:** titulní a nakladatelské údaje, celý obsah, předmluvy k vydání a k pojetí výuky (s. ix–xiii, PDF 10–14), vybrané úvodní pasáže a text s. 28 a 32 o konstrukci modelu a jeho vztahu ke skutečnosti. Obrazově ověřeny identifikační strany, obsah a přehledy začátků kapitol. Zbytek knihy je v této kartě **zmapován, nikoli podrobně prostudován**.

**Doporučené autorské využití:** srozumitelné propojení dat, předpokladů, modelu a predikce; inspirace pro vysvětlení pravděpodobnosti a simulací; později rozlišení asociace, predikce a kauzální otázky. Předmluva předpokládá základní zkušenost s regresí a R a výklad se opírá o programování. To se liší od vstupních znalostí studentů této učebnice. Příklady by vyžadovaly samostatnou adaptaci; kód R/Stan není studentským požadavkem. Howell zůstává hlavní oporou pořadí. Zápis knihy do mapy neschvaluje bayesovskou osnovu ani nahrazení četnostní interpretace intervalů.

**Neověřeno:** všechny důkazy, výpočty, cvičení a jejich řešení, empirické příklady, externí data, balíček `rethinking`, kód R/Stan a kompatibilita jeho verzí. Kód nebyl spuštěn. Významné odlišnosti v pojetí inference je nutné porovnat v konkrétních pasážích před převzetím; žádná plošná odborná validace knihy se touto kartou nedokládá.
