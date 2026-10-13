<a id="p06"></a>

# P06 — Výběrové rozdělení, STPS 2025

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

Odkazy na originály v `sources/` jsou místní a vyžadují neveřejné podklady. Stav prostudování a omezení určují záznamy níže.

**Soubor:** [sampling_distribution.pptx](../../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/sampling_distribution.pptx), 25 snímků; titul „Výběrové rozdělení“, STPS 2025. Metadata uvádějí Karla Rečku a poslední změnu 2025-12-19; kontrola aktuálního otisku 2026-10-12. Název souboru nevystihuje celý rozsah: většina prezentace rozvíjí testování hypotéz.

| Snímky | Obsah a využití |
|---|---|
| 1–4 | Populace, výběr, výběrová variabilita a rozdělení statistiky; parkovací příklad připisovaný Rubackovi a Juiengovi (1997). |
| 5–6 | Obrazové grafy dvou shodných zešikmených populací a rozdělení rozdílu průměrů pro n = 5, 30, 100 a 1 000. |
| 7–10 | Nulová a alternativní hypotéza, rozdíl 6,88 s, chyby rozhodnutí, kritická oblast a p-hodnota. |
| 11–15 | Hladina významnosti a síla; srovnání alternativních rozdílů 3, 5 a 8 s při stejné rozhodovací hranici. |
| 16–21 | Jednostranné a oboustranné testy, kritické hodnoty versus p-hodnoty a jejich interpretace. |
| 22–25 | Velikost účinku, shrnutí NHST, formulace závěrů a nezamítnutí nulové hypotézy. |

**Prostudováno:** text všech snímků a dostupných poznámek podle vazeb PPTX; všech 25 snímků vyexportováno PowerPointem a prohlédnuto na kontaktních listech. Obrazové sn. 5–6 byly zahrnuty. V R nezávisle ověřena aritmetika uvedená níže. Přednostní využití: vizualizace rozdílu populačního a výběrového rozdělení a vztahu účinku, rozhodovací hranice a síly. K návrhu kapitoly je nutné oddělit úvod do výběrových rozdělení od dosud neschváleného výkladu testování.

**Nálezy a podmínky použití:**

- **Sn. 8, poznámky; sn. 10 a 17–18:** 5/10 000 = **0,0005 = 0,05 %**, nikoli 0,00005 = 0,005 %. Obdobně 10/10 000 = **0,001 = 0,1 %**. Chybné desetinné hodnoty se objevují i v popiscích grafů. Pro normální model s SD = 2,13 uvedenou v poznámce dává pravý chvost od 6,88 přibližně 0,000619; tento modelový výpočet není reprodukcí původní simulace. Její data, seed a počty extrémů nebyly dostupné.
- **Sn. 9:** druhý řádek tabulky současně tvrdí nepravdivost H₀ i Hₐ. Při zamýšlených doplňujících se hypotézách má být v tomto řádku Hₐ pravdivá; potvrzeno v obraze.
- **Sn. 3–4 a 7:** konkrétní velikost rozdílu sama neurčuje jeho nepravděpodobnost; záleží na variabilitě, počtu pozorování a modelu. Výběrové rozdělení je obecný pojem, rozdělení za platnosti H₀ je jeho konkrétní použití. Nulové hypotézy obecně nemusejí být bodové.
- **Sn. 7, 19–21 a 23:** důsledně definovat p-hodnotu pomocí pozorovaného **nebo extrémnějšího** výsledku; zkratka „pravděpodobnost našeho výsledku“ je pro spojitou statistiku zavádějící. Pravidlo „statistika > kritická hodnota“ nepopisuje obecně levostranný či oboustranný test. Tvrzení sn. 20 o „přesné síle důkazu“ je příliš silné; srovnáno se šesti principy v [oficiálním shrnutí ASA, s. 2](https://www.amstat.org/asa/files/pdfs/p-valuestatement.pdf), zejména principem 6.
- **Sn. 22:** 6,88/14,6 = 0,4712 je početně správně; původ SD = 14,6 a volba standardizace nebyly ověřeny v původní studii. Obecné slovní kategorie velikosti účinku nenahrazují význam v kontextu.

**Neověřeno:** původní studie a kauzální vysvětlení parkovacího chování, zdrojové simulace a všechny hodnoty síly, živé animace a externí odkazy. Terminologie snímků není schválením nových hesel učebnice. Originál se neměnil.

**Doplnění při přípravě kapitoly 6 (2026-10-12):** z PPTX znovu přečten text všech 25 snímků a poznámky; obrazové sn. 5–6 a grafy nebyly nově prohlíženy. Podle [R28](../ROZHODNUTI.md#r28-rozsah-kapitoly-6) je prezentace kostrou bloku B a parkovací příklad průběžným příkladem celé kapitoly.

- **Převzaté pořadí:** hypotézy → rozdělení za platnosti nulové hypotézy → hladina a kritická hodnota → chyby a síla pro rozdíly 3, 5 a 8 s → směr testu → velikost účinku → formulace závěrů.
- **Odchylky schváleného pojetí:** hlavní test parkování je oboustranný a stejná hranice platí ve všech panelech síly, kdežto sn. 13–15 používají jednostrannou hranici 3,51 s. V normálním modelu se σ = 15 a n = 100 vychází síla pro 3, 5 a 8 s jednostranně 0,41; 0,76; 0,98 a oboustranně 0,29; 0,65; 0,96 (Python; přesně 0,965 — původní záznam z přípravy uváděl chybně zaokrouhlených 0,97, opraveno při tvorbě kapitoly 2026-10-12). Pravděpodobnosti se uvádějí jako výsledky výukového modelu, ne jako počty z 10 000 simulací.
- **Termíny podle [R30](../ROZHODNUTI.md#r30-terminologie-kapitoly-6):** směrodatná chyba místo „standardní chyba“ (sn. 4); kritický obor s alternativou oblast zamítnutí (sn. 10, 17–18); chyba I. a II. druhu (sn. 9 střídá „typu“ a „druhu“); H₁ (sn. 9 a 13–15 střídají Hₐ, H₁ a H1).
- **Další nálezy:** poznámka sn. 16 nadepisuje výhody jednostranného testu slovem „Nevýhody“. Sn. 22 definuje velikost účinku jako „měřítko těsnosti vztahu“, což nevystihuje rozdíl průměrů v původních jednotkách; slovní hodnocení „malý až středně silný efekt“ se nepřebírá. Formulace sn. 25 „výsledky umožňují přijmout alternativní hypotézu“ se nepřebírá. Sn. 24 uvádí, že bodová nulová hypotéza prakticky nemůže platit; R28 to formuluje opatrněji.
- **Původ čísel:** sn. 3 přebírá průměry 32,15 s a 39,03 s z U01 s. 86; původní článek ověřen nebyl. Bibliografický záznam a uspořádání studie byly 2026-10-12 ověřeny z metadat Crossref a shrnutí článku (karta [U01](U01-howell.md#u01)); plný text čten nebyl.
- **Použití v kapitole 6 (2026-10-12):** převzato pořadí bloku B a tři uvažované rozdíly 3, 5 a 8 s; panely síly mají oboustranné kritické hodnoty ±4,16 s. Text snímků ani obrázky se nepřebírají; obrazové sn. 5–6 nebyly prohlíženy.


## Související karty kapitol

Tematické vazby pro výběr podkladů: [kapitola 6](../kapitoly/06-vyberove-rozdeleni-testovani.md#mapa-kapitola-06). Konkrétní použití a stav ověření určují záznamy výše.
