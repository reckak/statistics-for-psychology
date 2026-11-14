<a id="d14"></a>

# D14 — Algina a Keselman: přibližné intervaly spolehlivosti pro velikost účinku

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md#algina-keselman-2026-11-14)

Odkazy na originál v `sources/` jsou místní a vyžadují neveřejné podklady. Stav prostudování a omezení určují záznamy níže.

**Soubor:** [algina-keselman-2003-approximate-confidence-intervals-for-effect-sizes.pdf](../../sources/ostatn%C3%AD%20zdroje/algina-keselman-2003-approximate-confidence-intervals-for-effect-sizes.pdf), 17 stran PDF: s. 537–553 na PDF 1–17 (převod PDF n = s. 536 + n), SHA-256 `93809c9f911b42d9`. Soubor doplnil autor 2026-11-14 jako podklad k intervalu pro párové Cohenovo *d*; kontrola týž den z textové vrstvy (`pdftotext -layout`).

**Identita:** Algina, J., & Keselman, H. J. (2003). Approximate confidence intervals for effect sizes. *Educational and Psychological Measurement, 63*(4), 537–553. DOI [10.1177/0013164403256358](https://doi.org/10.1177/0013164403256358). Ročník, číslo, strany a DOI jsou uvedeny v záhlaví a zápatí první strany PDF; bibliografický záznam `algina2003` v `references.bib`.

| Lokátor | Obsah a využití |
|---|---|
| [s. 537–538 (PDF 1–2)](../../sources/ostatn%C3%AD%20zdroje/algina-keselman-2003-approximate-confidence-intervals-for-effect-sizes.pdf#page=1) | Abstrakt a úvod: hodnocení Birdových (2002) přibližných intervalů pro velikost účinku v nezávislém a opakovaném uspořádání. |
| [s. 538–539 (PDF 2–3)](../../sources/ostatn%C3%AD%20zdroje/algina-keselman-2003-approximate-confidence-intervals-for-effect-sizes.pdf#page=2) | Rovnice 1–5: Birdův souměrný interval pro nezávislé skupiny ($d\pm t\sqrt{1/n_1+1/n_2}$) a pro závislé skupiny se standardizací odmocninou průměru obou rozptylů; přesný interval pro nezávislé skupiny vychází z necentrálního *t*-rozdělení. |
| [s. 540–541, tab. 1 (PDF 4–5)](../../sources/ostatn%C3%AD%20zdroje/algina-keselman-2003-approximate-confidence-intervals-for-effect-sizes.pdf#page=4) | Simulace pro nezávislé skupiny (n 10–80 na skupinu): pokrytí přibližného intervalu klesá s populační velikostí účinku z 0,950 (δ = 0) na 0,911 (δ = 1,6); interval leží častěji celý nad populační hodnotou. |
| [s. 541–544, tab. 2–3 (PDF 5–8)](../../sources/ostatn%C3%AD%20zdroje/algina-keselman-2003-approximate-confidence-intervals-for-effect-sizes.pdf#page=5) | Birdův interval pro opakované měření selhává s rostoucí velikostí účinku a korelací (pokrytí až 0,703). |
| [s. 544–545, rovnice 7–9 (PDF 8–9)](../../sources/ostatn%C3%AD%20zdroje/algina-keselman-2003-approximate-confidence-intervals-for-effect-sizes.pdf#page=8) | Nový přibližný postup pro dvě závislé skupiny: interval pro parametr necentrality párového *t* z necentrálního *t*-rozdělení, meze vynásobené $\sqrt{2(s_1^2+s_2^2-2s_{12})/(n(s_1^2+s_2^2))}$. |
| [s. 545–547, tab. 4–5 (PDF 9–11)](../../sources/ostatn%C3%AD%20zdroje/algina-keselman-2003-approximate-confidence-intervals-for-effect-sizes.pdf#page=9) | Pokrytí nového postupu 0,951–0,972, chyby spíše směrem k podhodnocení účinku. |

**Použití v kapitole 8 (2026-11-14):** [nepovinné rozšíření o intervalu pro *d*](../../quarto/kapitola_08.qmd#rozsireni-interval-d) cituje s. 540–541 (omezení přibližného intervalu pro nezávislé skupiny; v textu uvedeno jako „obdobný přibližný interval“, protože kapitola používá Howellův vzorec se členem $d^2$, nikoli Birdův interval) a s. 544–545 (postup pro párové *d* vztažené k $\sqrt{(s_1^2+s_2^2)/2}$). Výsledek pro variantu A, *d* = 0,51 a (0,22; 0,79), byl spočítán v R funkcí `pt()` s parametrem necentrality a ověřen v `quarto/_verification/check-chapter-08.R`; shodu násobku z rovnice 9 s převodem $t\to d$ kontroluje tentýž skript. Karta kapitoly: [kapitola 8](../kapitoly/08-porovnani-dvou-prumeru.md#mapa-kapitola-08).

**Neověřeno:** příklady na s. 547–549 (tab. 6–7) a dodatek se SAS programem; Birdův článek (2002) ani další citovaná literatura nebyly čteny. Simulace autorů nebyly opakovány.

## Související karty kapitol

[Kapitola 8](../kapitoly/08-porovnani-dvou-prumeru.md#mapa-kapitola-08).
