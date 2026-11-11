<a id="p11"></a>

# P11 — Souvislosti mezi proměnnými a korelační koeficient, PSYb1170, 2026

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

**Místní soubor:** [PSYb1170_P05_2026_-_Korelace.pptx](../../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/PSYb1170_P05_2026_-_Korelace.pptx), 58 snímků; SHA-256 `3b3e954d7d84e9be`. Titul přednáška 5, rok 2026; metadata tvůrce Jan Širůček, poslední editor „Standa Ježek“, změna 2026-03-17. Nejde o potvrzení autorství všech převzatých částí. Kontrola 2026-10-17; číslování zahrnuje skryté snímky.

| Snímky | Obsah a možné využití |
|---|---|
| 1–14 | Grafy pro různé typy proměnných, podmíněné rozdělení, asociace a kauzalita; sn. 12–13 skryté. |
| 15–20 | Kontingenční tabulky, podmíněné četnosti, poměr šancí a skupinové charakteristiky. |
| 21–29 | Bodový graf, linearita a těsnost vztahu. |
| 30–42 | Kovariance, Pearsonovo r a r², odlehlé hodnoty a omezení variability; sn. 33–38 skryté. |
| 43–49 | Fisherova transformace, interval a korekce odhadu; sn. 48–49 skryté. |
| 50–58 | Kendallova a Spearmanova korelace, další koeficienty a přehled volby podle proměnných. |

**Prostudováno:** text a poznámky včetně skrytých snímků; všechny obrazové přehledy exportu PowerPointu.

**Nálezy a podmínky převzetí:** sn. 40 označuje r = 0 za nepřítomnost vztahu a r = ±1 za identitu proměnných. Následující sn. 41 již připomíná nelinearitu: přesná formulace musí rozlišit lineární vztah od obecné závislosti a dokonalý lineární vztah od totožných hodnot či měřeného konstruktu. Sn. 48–49 prezentují odmocninu z upraveného r² jako obecnou opravu r; vzorec ztrácí záporné znaménko a například pro r = 0, n = 10 vede k odmocnině ze záporného čísla. Nelze jej takto obecně použít jako odhad podepsané korelace. Sn. 46 je potřeba číst jako aproximaci: Fisherův interval je asymptotický, viz [R, `cor.test`, Details](https://stat.ethz.ch/R-manual/R-devel/library/stats/html/cor.test.html) (R-devel, přístup 2026-10-17).

**Použití a neověřeno:** propojení grafu, podmíněných rozdělení a číselné míry; souvisejí [P10](P10-korelace-stps.md#p10) a [C06](C06-ulohy-tyden-5.md#c06). Neproběhl úplný přepočet intervalů ani odborná kontrola všech podmínek jednotlivých koeficientů. Před použitím odlišit definici popisného koeficientu od předpokladů testu či intervalu. Animace a externí demonstrace nebyly spuštěny; původní empirické studie a všechny vložené obrázky nebyly samostatně dohledávány.

<a id="priprava-10-20261109"></a>

**Čtení pro návrh kapitoly 10 (2026-11-09):** znovu text všech 58 snímků z XML (pořadí souborů ověřeno proti `presentation.xml`); poznámky ani obrazy snímků znovu prohlédnuty nebyly. Příklad známky z matematiky a obvodu hlavy (sn. 51 a 55) přepočten v R: τ = −0,4 (3 konkordantní, 7 diskordantních dvojic), *r*<sub>S</sub> = −0,6, Pearsonovo *r* = −0,515. **Nové nálezy:** sn. 41 vykládá *r*² jako podíl rozdílů v *X*, které by „se daly připsat na vrub“ rozdílům v *Y*; formulace svádí ke kauzálnímu čtení a bez regresního výkladu ji nepřebírat. Sn. 35 uvádí, že *r* lineární transformace neovlivňují; přesně: absolutní hodnotu nemění, záporný násobek obrátí znaménko. Pojetí souvislosti jako podmíněnosti rozdělení (sn. 10–11) a přehled koeficientů podle typu proměnných (sn. 14, 58) jsou využitelné pro úvod a pro propojení s kapitolami 8–9. [Společný záznam](HISTORIE.md#priprava-10-20261109).

## Související karty kapitol

Tematické vazby pro výběr podkladů: [kapitola 10](../kapitoly/10-korelace.md#mapa-kapitola-10). Konkrétní použití a stav ověření určují záznamy výše.
