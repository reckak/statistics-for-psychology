<a id="u16"></a>

# U16 — Lakens — Improving Your Statistical Inferences

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md#lakens-kline-2026-10-31)

Odkazy na originál v `sources/` jsou místní a vyžadují neveřejný podklad.

**Identita:** Daniël Lakens, *Improving Your Statistical Inferences*, podtitul na obálce „A guide to designing better experiments, drawing sound conclusions, and reporting research transparently“ (PDF 1, ověřeno v obraze strany). Otevřený vzdělávací zdroj s průběžně aktualizovanou webovou verzí (https://lakens.github.io/statistical_inferences/), licence CC BY-NC-SA (předmluva, s. 1, PDF 11). Autor působí na Eindhoven University of Technology (s. 2, PDF 12). Místní PDF je podle Change Logu (s. 551, PDF 561) **verze 1.6.3, sestavená 13. června 2026** z Git commitu `8036d4bb`; metadata PDF uvádějí vytvoření souboru 2. září 2026 (pravděpodobně okamžik stažení či exportu, nikoli novou verzi).

**Citace — nevyřešeno:** předmluva doporučuje citaci „Lakens, D. (2022). Improving Your Statistical Inferences. Retrieved from https://lakens.github.io/statistical_inferences/. https://doi.org/10.5281/zenodo.6409077“. Záznam [Zenodo](https://zenodo.org/records/6409077) (přístup 2026-10-31) však toto DOI přiřazuje **verzi v1.0.0 z 3. dubna 2022**; souhrnné DOI všech verzí je 10.5281/zenodo.6409076 a novější verze v Zenodu nalezena nebyla. DOI tedy neidentifikuje místní verzi 1.6.3. Rok a podobu bibliografické položky určí autor při prvním použití ve studentském textu podle [R42](../rozhodnuti/spolecne-konvence.md#r42-citace-dokumentace) (rok podle poslední doložené aktualizace citovaného celku, přesná verze a datum přístupu v bibliografii). **Doplněk 2026-11-01:** autor zvolil citaci „2026, verze 1.6.3“ bez DOI ([R57](../rozhodnuti/kapitola-06.md#r57-rozdeleni-p-omyly)); klíč `lakens2026` v `references.bib` (datum verze 2026-06-13, přístup 2026-11-01).

**Soubor:** [lakens.pdf](../../sources/u%C4%8Debnice/lakens.pdf), **564 stran PDF** (A4), SHA-256 `b47ec61033faaaed`. Kontrola 2026-10-31. PDF vzniklo z webové knihy (LaTeX přes pandoc); interaktivní simulace a výpočty webové verze nahrazuje větou o jejich dostupnosti online (např. s. 168–169, PDF 178–179), testové otázky „Test Yourself“ pocházejí z balíčku webexercises.

<a id="u16-mapa"></a>

## Mapa obsahu

Obsah je na s. iii–ix (PDF 3–9), předmluva na s. 1–2 (PDF 11–12). Pro arabské číslování platí **PDF = s. + 10**: ověřeno na začátcích všech 17 kapitol, seznamu literatury, Change Logu a všech oddílů uvedených níže. Tematické popisy jsou plánovací pomůckou, nikoli schválením nových pojmů či osnovy.

| Kapitola | Začátek: s. / PDF | Obsah a možné využití |
|---|---|---|
| 1. Using p-values to test a hypothesis | [3 / 13](../../sources/u%C4%8Debnice/lakens.pdf#page=13) | Ordinální tvrzení, Fisherovo a Neyman-Pearsonovo pojetí, nulový model, výpočet p, rozdělení p-hodnot, Lindleyho paradox, správné reportování a pět častých omylů o p-hodnotách. |
| 2. Error control | [43 / 53](../../sources/u%C4%8Debnice/lakens.pdf#page=53) | Možné výsledky studie, prediktivní hodnota pozitivního výsledku (PPV), inflace chyby I. druhu, průběžné nahlížení do dat (optional stopping), zdůvodnění hladiny α, síla. |
| 3. Likelihoods | [71 / 81](../../sources/u%C4%8Debnice/lakens.pdf#page=81) | Poměr věrohodností, smíšené výsledky v sadách studií, věrohodnosti pro t-test. |
| 4. Bayesian statistics | [89 / 99](../../sources/u%C4%8Debnice/lakens.pdf#page=99) | Bayesův faktor, aktualizace přesvědčení, pět omylů o Bayesově faktoru, bayesovský odhad. |
| 5. Asking Statistical Questions | [107 / 117](../../sources/u%C4%8Debnice/lakens.pdf#page=117) | Popis, predikce, vysvětlení; tři statistické filozofie, falzifikace, přísné testy, jednostranné a oboustranné testy, „crud factor“. |
| 6. Effect Sizes | [135 / 145](../../sources/u%C4%8Debnice/lakens.pdf#page=145) | Velikost účinku, standardizovaný rozdíl průměrů, interpretace, korelace a vysvětlený rozptyl, korekce zkreslení, nadhodnocení účinků vybraných podle významnosti. |
| 7. Confidence Intervals | [167 / 177](../../sources/u%C4%8Debnice/lakens.pdf#page=177) | Populace a výběr, co je interval spolehlivosti, interpretace jednoho intervalu, vztah k p-hodnotě, SE a 95% interval, překrývání, predikční interval, capture percentage, intervaly pro SD a velikost účinku. |
| 8. Sample Size Justification | [191 / 201](../../sources/u%C4%8Debnice/lakens.pdf#page=201) | Šest přístupů ke zdůvodnění velikosti výběru, apriorní analýza síly, plánování přesnosti, citlivostní analýza, post-hoc síla, sekvenční plány. |
| 9. Equivalence Testing and Interval Hypotheses | [241 / 251](../../sources/u%C4%8Debnice/lakens.pdf#page=251) | Test ekvivalence, reportování, test minimálního účinku, síla, bayesovský ROPE, volba šířky intervalu, nejmenší zajímavý účinek (SESOI). |
| 10. Sequential Analysis | [285 / 295](../../sources/u%C4%8Debnice/lakens.pdf#page=295) | Hladiny α v sekvenčních analýzách, Pocockova korekce, funkce utrácení α, zastavení pro marnost. |
| 11. Meta-analysis | [321 / 331](../../sources/u%C4%8Debnice/lakens.pdf#page=331) | Náhodná variabilita, simulace metaanalýz, pevný a náhodný efekt, heterogenita, podskupiny. |
| 12. Bias detection | [355 / 365](../../sources/u%C4%8Debnice/lakens.pdf#page=365) | Publikační zkreslení, funnel plot, trim and fill, PET-PEESE, metaanalýza p-hodnot. |
| 13. Preregistration and Transparency | [387 / 397](../../sources/u%C4%8Debnice/lakens.pdf#page=397) | Preregistrace plánu analýzy, standardy reportování (JARS), odchylky od preregistrace, praktické postupy. |
| 14. Computational Reproducibility | [415 / 425](../../sources/u%C4%8Debnice/lakens.pdf#page=425) | GitHub, RStudio, R Markdown, archivace dat a kódu. |
| 15. Research Integrity | [457 / 467](../../sources/u%C4%8Debnice/lakens.pdf#page=467) | Sporné výzkumné praktiky, fabrikace, falzifikace a plagiátorství, informovaný souhlas, střet zájmů. |
| 16. Confirmation Bias and Organized Skepticism | [471 / 481](../../sources/u%C4%8Debnice/lakens.pdf#page=481) | Konfirmační zkreslení ve vědě, organizovaný skepticismus. |
| 17. Replication Studies | [491 / 501](../../sources/u%C4%8Debnice/lakens.pdf#page=501) | Význam replikací, přímé a koncepční replikace, analýza replikačních studií, rozporné výsledky. |

Seznam literatury začíná na s. 517 (PDF 527), Change Log na s. 551 (PDF 561). Začátky ověřeny v textu příslušných stran.

<a id="u16-lokatory"></a>

## Přesnější tematické lokátory

Začátky oddílů jsou ověřeny v obsahu i na stranách textu. Odkaz otevírá první uvedenou stranu. **Zmapování oddílu nedokládá jeho podrobné přečtení**; přečtené pasáže uvádí oddíl o ověření.

| Otázka pro přípravu výkladu | Oddíly a začátky: s. / PDF |
|---|---|
| Co p-hodnota znamená a jak ji reportovat | §1.6 [12 / 22](../../sources/u%C4%8Debnice/lakens.pdf#page=22); nulová hypotéza × nulový model a pět omylů §1.7 [15 / 25](../../sources/u%C4%8Debnice/lakens.pdf#page=25), omyly §1.7.1–1.7.5 na s. 20–27. |
| Proč významný výsledek nemusí být pravdivý | PPV §2.2 [46 / 56](../../sources/u%C4%8Debnice/lakens.pdf#page=56); inflace chyby I. druhu §2.3 [49 / 59](../../sources/u%C4%8Debnice/lakens.pdf#page=59); optional stopping §2.4 [51 / 61](../../sources/u%C4%8Debnice/lakens.pdf#page=61). |
| Volba hladiny α a síla | §2.5 [54 / 64](../../sources/u%C4%8Debnice/lakens.pdf#page=64); §2.7 [60 / 70](../../sources/u%C4%8Debnice/lakens.pdf#page=70). |
| Jednostranný a oboustranný test | §5.10 [121 / 131](../../sources/u%C4%8Debnice/lakens.pdf#page=131). |
| Velikost účinku | Standardizovaný rozdíl průměrů §6.4 [140 / 150](../../sources/u%C4%8Debnice/lakens.pdf#page=150); interpretace §6.5 [145 / 155](../../sources/u%C4%8Debnice/lakens.pdf#page=155); nadhodnocení vybraných účinků §6.9 [154 / 164](../../sources/u%C4%8Debnice/lakens.pdf#page=164). |
| Interval spolehlivosti | Co je interval §7.2 [168 / 178](../../sources/u%C4%8Debnice/lakens.pdf#page=178); interpretace jednoho intervalu §7.3 [169 / 179](../../sources/u%C4%8Debnice/lakens.pdf#page=179); vztah k p §7.4 [170 / 180](../../sources/u%C4%8Debnice/lakens.pdf#page=180); SE a 95% interval §7.5 [173 / 183](../../sources/u%C4%8Debnice/lakens.pdf#page=183); capture percentage §7.8 [175 / 185](../../sources/u%C4%8Debnice/lakens.pdf#page=185). |
| Plánování velikosti výběru | Apriorní síla §8.6 [198 / 208](../../sources/u%C4%8Debnice/lakens.pdf#page=208); plánování přesnosti §8.7 [204 / 214](../../sources/u%C4%8Debnice/lakens.pdf#page=214). |
| Test ekvivalence a SESOI | §9.1 [245 / 255](../../sources/u%C4%8Debnice/lakens.pdf#page=255); reportování §9.2 [252 / 262](../../sources/u%C4%8Debnice/lakens.pdf#page=262); nastavení SESOI §9.7 [261 / 271](../../sources/u%C4%8Debnice/lakens.pdf#page=271). |
| Publikační zkreslení a sporné praktiky | §12.1 [359 / 369](../../sources/u%C4%8Debnice/lakens.pdf#page=369); §15.1 [459 / 469](../../sources/u%C4%8Debnice/lakens.pdf#page=469). |

<a id="u16-overeni"></a>

## Rozsah čtení, nálezy a podmínky použití

**Skutečně prostudováno 2026-10-31:** obálka (v obraze), obsah, předmluva, Change Log (s. 551–552), úvod kap. 1 (s. 3–4), §1.7 úvod (s. 15–16), §1.7.4 a začátek §1.7.5 (s. 26–27), §7.2–7.3 (s. 168–170). Ostatní kapitoly jsou jen zmapovány.

- **Vztah k E02 a E03:** předmluva uvádí, že kniha přebírá a upravuje autorovy open access články bez uvozovek. Kapitola 9 proto pravděpodobně vychází z [E02](E02-lakens-2017.md#e02-lakens-2017) a [E03](E03-lakens-2018.md#e03-lakens-2018); shoda pasáží nebyla porovnána. Kapitola 7 učebnice cituje články, nikoli knihu.
- **Interpretace intervalu (§7.3, s. 169):** Lakens označuje Cummingovu formulaci „95% jistota, že interval obsahuje μ“ za nesprávnou s odkazem na Moreyho et al. (2016) a interval vykládá jako vlastnost postupu v dlouhém běhu. To je v souladu s výkladem [kapitoly 7](../kapitoly/07-interval-t-test-ekvivalence.md#mapa-kapitola-07) a odlišuje se od formulací v [U03](U03-cumming.md#u03). Interval zároveň popisuje jako „rozlišení“, s nímž je účinek odhadnut (s. 170), zatímco [D13](D13-kline.md#d13) podle Moreyho et al. uvádí „precision fallacy“; při případném použití obě tvrzení sladit.
- **Postoj k p-hodnotám:** Lakens hájí testování jako ochranu proti sebeklamu a cituje zjištění o zákazu p-hodnot v časopise *Basic and Applied Social Psychology* (s. 4). Jde o kontrast se skeptičtějším stanoviskem [D13](D13-kline.md#d13); oba podklady se shodují v popisu omylů.
- **Výpočty v R:** kniha pracuje s R a simulacemi; nepoužívá Excel. Příklady nelze převzít bez vlastního postupu.
- **Vady extrakce:** řecká písmena v matematickém zápisu nemají v textové vrstvě platné mapování Unicode (např. μ na s. 168–169). Při citování vzorců ověřit znění v obraze strany.

**Neověřeno:** odborná správnost výpočtů a simulací, odpovědi otázek „Test Yourself“, shoda PDF s aktuální webovou verzí, přesné znění převzatých pasáží z E02 a E03, citovaná primární literatura. Licence CC BY-NC-SA dovoluje úpravy s uvedením autora a pod stejnou licencí; slučitelnost s licencí učebnice nebyla posouzena, proto se texty ani obrázky nepřebírají.

<a id="u16-pouziti-kapitola-06"></a>

## Použití v kapitole 6 (2026-11-01)

Podle [R57](../rozhodnuti/kapitola-06.md#r57-rozdeleni-p-omyly) nově přečteny §1.4–1.5 (s. 9–12, PDF 19–22) a §2.5 (s. 54–58, PDF 64–68); §1.7 byla čtena dříve jen v úvodu a §1.7.4–1.7.5, ostatní pododdíly §1.7 jsou zmapovány podle nadpisů. Kotvy webové verze `01-pvalue.html#sec-lindley`, `#sec-misconceptions` a `02-errorcontrol.html#sec-justifyerrorrate` ověřeny 2026-11-01.

- [Rozšíření o rozdělení *p*-hodnot](../../quarto/kapitola_06.qmd#rozsireni-rozdeleni-p): myšlenka rovnoměrného rozdělení za H0, závislosti tvaru na síle, jevu těsně významných *p*-hodnot při vysoké síle (citováno jako Lindleyho paradox podle §1.5) a volby hladiny podle síly, velikosti výběru a důsledků obou chyb (§2.5, včetně Lakensovy výhrady k mírnější hladině). Příklady, čísla, obrázek a tabulka jsou vlastní na parkovacím modelu kapitoly; Lakensovy simulace t-testů, obr. 1.2 a 2.8 ani interaktivní aplikace se nepřebírají. Bayesův faktor a věrohodnosti, o které Lakens doporučení opírá, se podle R28 nevykládají.
- [Rozšíření o mylných představách](../../quarto/kapitola_06.qmd#rozsireni-omyly-p): výběr omylů vychází z pěti Lakensových „misconceptions“ (§1.7) a z [D13](D13-kline.md#d13); formulace, příklady i správná znění jsou vlastní.
- **Výhrada k pojmenování:** Lakens nazývá Lindleyho paradoxem srovnání hustoty *p*-hodnot za H0 a za alternativy s vysokou silou; v užším smyslu jde o rozpor bayesovského a četnostního závěru při rostoucím výběru. Kapitola proto název jen připisuje Lakensovi a nezavádí jej jako pojem.

## Související karty kapitol

Tematické vazby pro výběr podkladů: [kapitola 6](../kapitoly/06-vyberove-rozdeleni-testovani.md#mapa-kapitola-06) (použití výše) a [kapitola 7](../kapitoly/07-interval-t-test-ekvivalence.md#mapa-kapitola-07). Konkrétní použití a stav ověření určují záznamy výše.
