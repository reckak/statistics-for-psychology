<a id="d10"></a>

# D10 — Excel: normální rozdělení a porovnání pravděpodobností

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

Odkazy na originály v `sources/` jsou místní a vyžadují neveřejné podklady. Stav prostudování a omezení určují záznamy níže.

**Soubor:** [Normalni_rozdeleni_do_3_aveamian._prednasky.xlsx](../../sources/ostatn%C3%AD%20zdroje/Normalni_rozdeleni_do_3_aveamian._prednasky.xlsx); 4 listy. Metadata uvádějí Stanislava Ježka; rok vzniku v metadatech neurčuje rok současné didaktické verze.

| List a buňky | Obsah a využití |
|---|---|
| `zpaměti`, vložený obrázek a `B32:E37` | Převodní schéma a vysvětlení, co znát a co dopočítat; CDF a inverzní funkce. |
| `hustota!B39:R43` | z = −4 až 4, CDF, plocha od středu, hustota funkcí i vzorcem; řádky 40, 42 a 43 odlišují tři různé významy. |
| `hustota!B44:R45` | Lineární převody na IQ (100, 15) a T (50, 10). |
| `hustota!B47:P50` | Vybrané percentily, jejich hodnoty v z, IQ a T. |
| `cdf`, oblast `A1:R49` | Grafické a tabulkové zobrazení distribuční funkce; souvislost s listem `hustota`. |
| `Q-Q!B2:C3` | Populační parametry generování a průměr/SD konkrétního náhodného výběru. |
| `Q-Q!A6:C101` | 96 simulovaných normálních hodnot, `PERCENTRANK.EXC` a modelová CDF. |
| `Q-Q!O6:P101` | Ruční pořadový výpočet přes `COUNTIF`, dělení n + 1 a zkrácení na tři místa, porovnání s funkcí. |

**Prostudováno:** struktura všech listů, uložené vzorce a výsledky, definice datových řad grafů a vložený převodní obrázek. **Nezávislé ověření:** 66 uložených hodnot CDF/hustoty/kvantilů na listu `hustota` porovnáno s Python `statistics.NormalDist`; maximální absolutní rozdíl přibližně 3,4 × 10⁻¹⁶. Znovu spočítán průměr a výběrová SD 96 uložených hodnot z listu `Q-Q`; shodují se s uloženými výsledky do numerické přesnosti.

**Zásadní nález:** graf listu `Q-Q` má na osách hodnoty z `B6:B101` a `C6:C101`, tedy empirické pořadové pravděpodobnosti a modelové kumulativní pravděpodobnosti. Odpovídá principu **P–P grafu**, nikoli Q–Q grafu porovnávajícího kvantily. Také popisky „empirický/teoretický kvantil“ v `B5:C5` tyto veličiny nerozlišují. Nepřebírat jako návod pro Q–Q graf kapitoly 4.

**Další podmínky:** `PERCENTRANK.EXC` a dělení n + 1 nejsou současnou projektovou definicí empirického percentilového pořadí. Funkce `RAND()` mění hodnoty při přepočtu, uložený stav tedy není reprodukovatelná pevná datová sada.

**Neověřeno:** sešit nebyl nově spuštěn a přepočten v Excelu, neověřeno jeho živé chování, české názvy funkcí v dané instalaci, všechny vzorce ani výsledné rozložení grafů v Excelu. Shoda uložených výsledků s Pythonem neprokazuje funkčnost sešitu v aktuálním Excelu. Originál se neměnil.


## Související karty kapitol

Tematické vazby pro výběr podkladů: [kapitola 4](../kapitoly/04-normalni-rozdeleni.md#mapa-kapitola-04). Konkrétní použití a stav ověření určují záznamy výše.
