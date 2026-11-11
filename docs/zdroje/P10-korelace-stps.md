<a id="p10"></a>

# P10 — Korelace, STPS 2025

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

**Místní soubor:** [korelace_prezentace.pptx](../../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/korelace_prezentace.pptx), 55 snímků; SHA-256 `7c541491dcbd617c`. Titul STPS 2025; metadata Karel Rečka, změna 2025-12-19. Kontrola 2026-10-17.

| Snímky | Obsah a možné využití |
|---|---|
| 1–10 | Kovariance a Pearsonovo r; výpočet na pěti dvojicích reklamy a prodejů. |
| 11–18 | Interpretace velikosti a znaménka, bodové grafy, nelinearita a Anscombův příklad. |
| 19–29 | Předpoklady, omezení variability, reliabilita měření a marginální rozdělení. |
| 30–37 | Fisherova transformace, CI, korekce odhadu a r². |
| 38–42 | Spearmanova pořadová korelace, výpočet a interval. |
| 43–50 | Kendallovo tau-a a tau-b, konkordance, interval a porovnání koeficientů. |
| 51–55 | Binární a latentní proměnné, bodově biseriální a další korelace, převod d na r. |

**Prostudováno:** text a poznámky; všechny snímky obrazově v přehledech exportovaných PowerPointem, sn. 52 také v plné velikosti.

**Ověřený nález:** sn. 52 uvádí obecný převod r = d√(pq), pro stejně velké skupiny r = d/2; sn. 53 z něj vytváří lineární graf. Tento vztah není obecným převodem Cohenova d se společnou vnitroskupinovou SD na bodově biseriální r: pro d = 3 by vracel nepřípustné r = 1,5. Příslušný převod je r = d/√(d² + h), kde h = (n₁ + n₂ − 2)(1/n₁ + 1/n₂); pro velké stejně velké skupiny h ≈ 4. Pro d = 1 pak r ≈ 0,447, nikoli 0,5. Ověřeno aritmeticky v R a v [dokumentaci effectsize, `d_to_r`, oddíl Details](https://easystats.github.io/effectsize/reference/d_to_r.html) (verze stránky 1.0.3, přístup 2026-10-17). Před převodem je nutné určit definici d a kódování skupin.

**Použití a neověřeno:** názorné porovnání koeficientů a vlivu tvaru dat; souvisejí [P11](P11-korelace-psyb1170.md#p11) a [C06](C06-ulohy-tyden-5.md#c06). Nezávisle nebyly přepočteny všechny tabulky ani intervaly pro pořadové korelace (sn. 40–41 a 48). Tvrzení o obecném nadhodnocení korelace a korekce na sn. 34–36 vyžadují před použitím samostatné posouzení; nelze automaticky zaměňovat korekci r² za opravu podepsaného r. Empirické zdroje, animace, externí odkazy a excelové postupy nebyly úplně ověřeny.

<a id="priprava-10-20261109"></a>

**Čtení pro návrh kapitoly 10 (2026-11-09):** znovu text všech 55 snímků z XML (pořadí souborů ověřeno proti `presentation.xml`); poznámky ani obrazy snímků znovu prohlédnuty nebyly. Příklady přepočteny v R: Kendallovo τ u stáří vozu a věku (sn. 45–46: 4 konkordantní, 6 diskordantních dvojic, τ = −0,2) a délka učení a body (sn. 42: *r* = 0,725, *r*<sub>S</sub> = 0,677, τ<sub>b</sub> = 0,549). **Nové nálezy:** sn. 11 uvádí slovní pásma síly *r*; učebnice slovní pásma u *d* ani φ nepoužívá ([R56](../rozhodnuti/kapitola-06.md#r56-p-hodnota-cohen), [R68](../rozhodnuti/kapitola-09.md#r68-rozsah-kapitoly-9)), proto je bez nové dohody nepřebírat. Tvrzení sn. 24, že největší relativní oslabení restrikcí vzniká u středně silných vztahů, a vzorce směrodatných chyb *r*<sub>S</sub> a τ ve sn. 40–41 a 48 nebyly ověřeny. Sn. 28 (maximální |*r*| < 1 při odlišném tvaru rozdělení) je využitelný bez výpočtu. [Společný záznam](HISTORIE.md#priprava-10-20261109).

## Související karty kapitol

Tematické vazby pro výběr podkladů: [kapitola 10](../kapitoly/10-korelace.md#mapa-kapitola-10). Konkrétní použití a stav ověření určují záznamy výše.
