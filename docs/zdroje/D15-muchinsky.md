<a id="d15"></a>

# D15 — Muchinsky: korekce na atenuaci

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md#muchinsky-2026-11-20)

Odkazy na originál v `sources/` jsou místní a vyžadují neveřejné podklady. Stav prostudování a omezení určují záznamy níže.

**Soubor:** [muchinsky1996.pdf](../../sources/ostatn%C3%AD%20zdroje/muchinsky1996.pdf), 14 stran PDF: titulní list vydavatele (PDF 1) a s. 63–75 na PDF 2–14 (převod PDF n = s. 61 + n), SHA-256 `2fd28e579f5866bc`. Soubor doplnil autor 2026-11-20 jako podklad ke korekci na atenuaci v kapitole 10. Jde o sken bez textové vrstvy (`pdftotext` vrací jen záhlaví vydavatele); text byl čten v obrazu stran.

**Identita:** Muchinsky, P. M. (1996). The correction for attenuation. *Educational and Psychological Measurement, 56*(1), 63–75. DOI [10.1177/0013164496056001004](https://doi.org/10.1177/0013164496056001004). Ročník, číslo a strany jsou uvedeny v zápatí s. 63; DOI na titulním listu vydavatele, existence a název ověřeny službou Scite 2026-11-20. Bibliografický záznam `muchinsky1996` v `references.bib`.

| Lokátor | Obsah a využití |
|---|---|
| [s. 63–64 (PDF 2–3)](../../sources/ostatn%C3%AD%20zdroje/muchinsky1996.pdf#page=2) | Abstrakt a historický přehled: korekci navrhl Spearman (1904); chyba měření snižuje pozorovanou korelaci oproti vztahu „pravých“ hodnot. |
| [s. 64–66 (PDF 3–5)](../../sources/ostatn%C3%AD%20zdroje/muchinsky1996.pdf#page=3) | Spory o volbu druhu reliability (opakované měření, vnitřní konzistence, paralelní formy). |
| [s. 66, rovnice 1 (PDF 5)](../../sources/ostatn%C3%AD%20zdroje/muchinsky1996.pdf#page=5) | Dvojitá korekce $\mathrm{ρ}_{xy}=r_{xy}/(\sqrt{r_{xx}}\sqrt{r_{yy}})$; korekce zvětšuje korelaci tím víc, čím nižší je reliabilita. |
| [s. 67–68, rovnice 2–5 (PDF 6–7)](../../sources/ostatn%C3%AD%20zdroje/muchinsky1996.pdf#page=6) | Jednoduchá korekce jen jedné proměnné; opravená hodnota nad 1, příklad $0{,}65/(\sqrt{0{,}81}\sqrt{0{,}49})=1{,}03$. |
| [s. 68–71 (PDF 7–10)](../../sources/ostatn%C3%AD%20zdroje/muchinsky1996.pdf#page=7) | Chybná použití: zvýšení prediktivní přesnosti, slučování různých druhů reliability v metaanalýzách, dosazování odhadnuté reliability. |
| [s. 71–73 (PDF 10–12)](../../sources/ostatn%C3%AD%20zdroje/muchinsky1996.pdf#page=10) | Závěry: korekce nezlepší predikci, opravené koeficienty nelze testovat obvyklým testem ani přímo srovnávat s neopravenými, nenahrazuje kvalitní měření; uvádět i neopravenou hodnotu; korekce je odhad stavu bez chyby měření. |

**Použití v kapitole 10 (2026-11-20):** [nepovinné rozšíření o korekci na atenuaci](../../quarto/kapitola_10.qmd#rozsireni-korekce-reliabilita) cituje s. 64 a 66 (původ a vzorec), s. 67–72 (omezení, příklad 1,03) a s. 73 (korekce jako odhad). Výklad atenuace v povinném textu cituje Arona (s. 514–515, [U02](U02-aron.md#u02)), který jev popisuje bez vzorce. Příklad korekce 0,35/0,6 = 0,58 je vlastní simulace (`scripts/kapitola_10.R`, blok 13d), ověřená v `quarto/_verification/check-chapter-10.R`. Karta kapitoly: [kapitola 10](../kapitoly/10-korelace.md#mapa-kapitola-10).

**Neověřeno:** původní Spearmanův článek (1904) ani další citovaná literatura nebyly čteny; tvrzení článku o metaanalýzách a teorii užitku se v učebnici nepoužívají. Rozklad reliability jako podílu rozptylu pravých skórů v rozšíření vychází z klasického modelu měření, který článek předpokládá, ale výslovně neodvozuje.

## Související karty kapitol

[Kapitola 10](../kapitoly/10-korelace.md#mapa-kapitola-10).
