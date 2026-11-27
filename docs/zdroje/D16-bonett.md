<a id="d16"></a>

# D16 — Bonett: intervaly pro standardizovaný rozdíl průměrů u párových dat

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md#bonett-2026-11-27)

Odkazy na originál v `sources/` jsou místní a vyžadují neveřejné podklady. Stav prostudování a omezení určují záznamy níže.

**Soubor:** [bonett-2015.pdf](../../sources/ostatn%C3%AD%20zdroje/bonett-2015.pdf), 11 stran PDF: s. 366–376 na PDF 1–11 (převod PDF n = s. 365 + n), SHA-256 `9f83044d8cf4b6d9`. Soubor doplnil autor 2026-11-27 jako podklad k Cohenovu *d* párových dat v aplikaci Test jednoho průměru; kontrola týž den z textové vrstvy (`pdftotext -layout`) a vzorce a příklad z vykreslených stran PDF 3, 4 a 9 (textová vrstva vzorce poškozuje).

**Identita:** Bonett, D. G. (2015). Interval estimation of standardized mean differences in paired-samples designs. *Journal of Educational and Behavioral Statistics, 40*(4), 366–376. DOI [10.3102/1076998615583904](https://doi.org/10.3102/1076998615583904). Údaje v záhlaví první strany a v záznamu Crossref (ověřeno 2026-11-27); bibliografický záznam `bonett2015` v `references.bib`.

| Lokátor | Obsah a využití |
|---|---|
| [s. 366–367 (PDF 1–2)](../../sources/ostatn%C3%AD%20zdroje/bonett-2015.pdf#page=1) | Úvod; čtyři standardizované rozdíly párových dat (rovnice 1–4): δ₁ s rozptylem rozdílů upraveným korelací, δ₂ s $\sqrt{(\mathrm{σ}_1^2+\mathrm{σ}_2^2)/2}$, δ₃ se směrodatnou odchylkou kontrolního/výchozího měření, δ₄ se směrodatnou odchylkou rozdílů. Autor považuje δ₂ a δ₃ obvykle za nejsmysluplnější (s. 367). |
| [s. 368 (PDF 3)](../../sources/ostatn%C3%AD%20zdroje/bonett-2015.pdf#page=3) | Odhady (rovnice 5–7), korekce zkreslení: δ₂ násobit $\sqrt{(n-2)/df}$, δ₃ násobit $1-3/(4df-1)$; rozptyl odhadu δ₂ (rovnice 9) bez předpokladu shodných rozptylů. **Použito v aplikaci.** |
| [s. 369 (PDF 4)](../../sources/ostatn%C3%AD%20zdroje/bonett-2015.pdf#page=4) | Rozptyl odhadu δ₃ (rovnice 11) a intervaly 12–15; zmínka o přesném intervalu pro δ₄ z necentrálního *t*-rozdělení a o transformaci Alginy a Keselmana. **Rovnice 13 a 15 použity v aplikaci.** |
| [s. 370–373 (PDF 5–8)](../../sources/ostatn%C3%AD%20zdroje/bonett-2015.pdf#page=5) | Simulace (180 podmínek, 200 000 opakování): rovnice 13 a 15 mají pokrytí blízko 0,95 i při nestejných rozptylech; rovnice 12, 14, 19 a 20 mohou selhat, 19 a 20 (Algina a Keselman) při δ ≥ 1,2. Intervaly pro *d* nejsou odolné vůči nenormalitě a větší *n* to nezlepší (s. 372). |
| [s. 373–374 (PDF 8–9)](../../sources/ostatn%C3%AD%20zdroje/bonett-2015.pdf#page=8) | Příklad 10 studentů (data Coladarciho et al.); doporučení: rovnice 13 a 15, „nearly exact“ pro *n* > 10 při přibližné normalitě (s. 374). |

**Nálezy (2026-11-27):**

- V příkladu na s. 374 uvádí článek $\hat{\mathrm{σ}}_1^2=4{,}81$ a $\hat{\mathrm{σ}}_2^2=4{,}67$ jako „sample variances“; z uvedených dat jde o výběrové **směrodatné odchylky** (4,813 a 4,673). Ověřeno v R (`scripts/app-jeden-prumer.R`).
- Článek uvádí pro tentýž příklad 95% interval [−0,21; 0,63] „pro δ₂ i δ₃“. Rovnice 13 tento interval reprodukuje (−0,209; 0,631); rovnice 15, jak je vytištěna, dává (−0,208; 0,624), tedy [−0,21; 0,62]. Korigované odhady 0,20 a 0,19 souhlasí. Rozdíl je ve druhém desetinném místě; příčina (zaokrouhlení v článku, nebo odlišnost R funkce v online příloze) nezjištěna, příloha nebyla čtena.

**Použití:** [aplikace Test jednoho průměru](../../quarto/app_jeden_prumer.qmd#sec-app-prumer-princip) (oddíl „Co aplikace počítá“, rovnice 9, 11, 13 a 15, korekce zkreslení, s. 371–374 k pokrytí a odolnosti); doklad volby v [upřesnění R87](../rozhodnuti/postupy-a-dokumentace.md#r87-upresneni-2026-11-27). Kapitola 8 Bonetta necituje a podle rozhodnutí autora se nemění ([karta kapitoly 8](../kapitoly/08-porovnani-dvou-prumeru.md#mapa-kapitola-08); srov. [D14](D14-algina-keselman.md#d14)).

**Neověřeno:** online příloha s R funkcemi a podrobnými výsledky simulací; Bonett (2008, 2009) a další citovaná literatura nebyly čteny. Simulace autora nebyly opakovány.

## Související karty kapitol

[Kapitola 8](../kapitoly/08-porovnani-dvou-prumeru.md#mapa-kapitola-08) (aplikace navazující na kapitolu).
