<a id="c05"></a>

# C05 — Úlohy, týden 4, 2025: výběrová rozdělení a intervaly

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

Odkazy na originály v `sources/` jsou místní a vyžadují neveřejné podklady. Stav prostudování a omezení určují záznamy níže.

**Soubor:** [ulohy_tyden04_2025.docx](../../sources/p%C5%99%C3%ADklady%20k%20procvi%C4%8Dov%C3%A1n%C3%AD/ulohy_tyden04_2025.docx). Metadata uvádějí Andreu Staňkovou a posledního editora „Standa Ježek“, poslední změnu 2025-03-12; nejde o ověření autorství všech převzatých úloh. Kontrola 2026-10-12. Označení týdne se neshoduje s prefixy úloh: soubor obsahuje **X5, X6 a C5**. Zachovat jejich původní ID.

| Zadání a odpovídající položka v „SPRÁVNÁ ŘEŠENÍ“ | Obsah a použití |
|---|---|
| C5_01–09, C5_11 | Náhodný výběr, rozdělení průměrů, SE, CLT, simulace v ESCI; spokojenost s kolejemi a spojení dvou výběrů. C5_10 není uvedena. |
| X5_01–06 | Předpoklady výběru, IQ, simulace a teoretické rozdělení průměru a podílu; porovnání mediánu, SD, rozptylu, IQR a rozpětí. |
| X5_07–08 | Bolest u 25 horolezců a 20 odpovědí o vybavování událostí; odhady SE vzorcem a bootstrapem. |
| X5_09 | Historická motivace „trial of the pyx“, podle zadání inspirace 2. kapitolou Stiglerovy *The Seven Pillars of Statistical Wisdom*; součet versus průměr a odmocninový vztah. Téma souvisí také s D11, který zde není uveden jako přímý zdroj zadání. |
| X5_10–12; X5_100 | Empatie, opakované výkony jednoho dítěte, podíl snídajících a změna parametrů; tabulka pojmů. |
| X6_01–10 | Význam a šířka CI, známá/neznámá SD, CLT, různá centra intervalů a vztah SE k n. |
| X6_11–16 | CI pro průměr: hospitalizované děti, rychlost čtení, párové rozdíly Stroopových časů, objem piva, IQ a historické výšky chlapců. |
| X6_17–19 | Hodnota hypotézy v CI, vnoření intervalů a interpretace obrazu 50 opakovaných intervalů. |
| X6_20–22 | Potřebné n pro požadovanou šířku CI, podíl vybavených událostí a volební průzkum. |
| C5_14–23, C5_27–31 | Anglické konceptuální otázky: chyba odhadu, mezní chyba, hladina, t-rozdělení, replikace a chybové úsečky. Za C5_23 jsou dvě další věty bez samostatného ID; číslování 24–26 není úplné. |

**Prostudováno:** text a tabulky zadání i oddílu řešení z OOXML; čtyři vložené PNG prohlédnuty samostatně (symbol, obraz intervalů, vzorec SE, boxplot). Jedna vložená EMF nebyla vizuálně ověřena. Export pouze pro čtení ve Wordu se zablokoval; vlastní instanci bylo nutné ukončit, proto **stránkování a celé vykreslení DOCX nejsou ověřeny**. Lokátory jsou ID úloh, nikoli odhadnuté stránky dokumentu.

**Nezávislé ověření a nálezy:**

- **X5_01 a C5_02:** rozlišit prostý náhodný výběr bez vracení od nezávislých losování. Úplná nezávislost zařazení jednotek není obecnou podmínkou prostého náhodného výběru pevné velikosti bez vracení. Odpověď X5_01 navíc končí nedopsanou větou. **C5_01 a X6_08:** podmínky intervalu formulovat pro konkrétní postup; samotná znalost σ nestačí k přesnému normálnímu CI při libovolném n a rozdělení populace.
- **X5_06 a X5_12:** binomický model je v současné kapitole 5 již vysvětlen; původní poznámka, že je mimo kurikulum, se nepřenáší. U n = 5 není normální aproximace spolehlivým výchozím postupem. Pro otázky X5_12 jsou přesné binomické hodnoty P(X ≤ 11; n = 20, π = 0,6) = **0,40440** a P(X ≤ 18; n = 20, π = 0,95) = **0,26416**. Klíč uvádí aproximace 0,32 a 0,23; rozlišit modelovou π od pozorovaného p a diskrétní hranici.
- **X5_08, X5_10 a X5_11:** rozlišit pravděpodobnost budoucí výběrové chyby za předpokladů modelu od pravděpodobnostního tvrzení o parametru po získání dat. Deset výkonů téhož člověka nelze bez zdůvodnění považovat za nezávislá srovnatelná měření; úloha není validovaným diagnostickým postupem. V řešení X5_10 má konkrétní hodnota spojité veličiny pravděpodobnost **přesně 0**, nikoli jen „limitně blízkou 0“.
- **X5_09:** při daném nezávislém normálním modelu je SE průměru 0,0005 g a SD součtu 0,05 g; levý chvost od z = −20 je 2,7536 × 10⁻⁸⁹. Jednoprocentní hranici odpovídá průměr mince přibližně **9,991163 g**. Tím je ověřena modelová aritmetika, nikoli historické vyprávění ani ekonomické přepočty.
- **X6_11–13, klíč:** znaménka a pravděpodobnost argumentu T.INV nejsou důsledná. X6_12 píše kladný kvantil 2,571, ale `T.INV(0,025;5)` odpovídá zápornému −2,57058. X6_13 spojuje 2,26 s `T.INV(0,05;9)`; kladnému 2,26216 odpovídá p = **0,975**, zatímco p = 0,05 dává −1,83311. Samotné meze 95% intervalů X6_12 (209,929; 523,404) a X6_13 pro deset rozdílů (13,167; 28,233) souhlasí s nezávislým výpočtem v R.
- **X6_14:** neparametrický bootstrap na osmi hodnotách není obecnou náhradou všech předpokladů normálního modelu. Parametrický 95% interval z daných hodnot je přibližně (0,46852; 0,50048); hrubé zaokrouhlení horní meze na 0,50 nesmí zastřít její vztah k testované hodnotě.
- **X6_20–21:** při uvedeném modelu a cílové celkové šířce vychází potřebná n po zaokrouhlení vzhůru **210**, resp. **289**; klíč v těchto konečných hodnotách souhlasí. Druhá hodnota používá plánovací odhad p = 0,75, není zárukou pro každý populační podíl.

**Podmínky převzetí / neověřeno:** závislosti `Simulace výběrů.xlsx` a `bootstrap.xlsx` v aktuálním `sources/` chybějí; ESCI a externí simulace nebyly spuštěny. Funkce nebyly testovány v českém Excelu, bootstrapové číselné výsledky nebyly reprodukovány a celý klíč nebyl přepočten. Přesné vydání zdroje C5 a jeho stránkové odkazy nejsou ověřeny; odkazovaný web používá ISBN 9781138825529, nelze jej automaticky ztotožnit se současným místním druhým vydáním U03. Původ dat a historická či empirická tvrzení je třeba ověřit před převzetím. Originál se neměnil.

**Doplnění při přípravě kapitoly 6 (2026-10-12):** z OOXML znovu přečtena zadání C5_01–09, C5_11, X5_01–12 a X5_100; řešení a část X6 jen podle této karty. Náměty pro cvičení kapitoly 6, žádné se nepřebírá doslova:

- **Výběrové rozdělení průměru (X5_02, X5_05):** IQ při N = 9; směrodatná chyba 5, podíl průměrů nad 105 je 0,159, nad 110 je 0,023 a mezi 95 a 105 je 0,683 (Python).
- **Výběrové rozdělení podílu (X5_03, X5_06):** malé N a diskrétnost rozdělení.
- **Směrodatná chyba a velikost výběru (C5_11, X5_09):** spojení dvou výběrů; mincovní úloha jako motivace odmocninového vztahu.
- **Binomický test (X5_12):** 11 nebo méně z 20 při pravděpodobnosti 0,6, přesně 0,404.
- **Jiné statistiky (X5_04):** odpovídá krátké zmínce o výběrových rozděleních mediánu, směrodatné odchylky a rozptylu.
- **Nepoužije se:** úlohy závislé na chybějících sešitech `Simulace výběrů.xlsx` a `bootstrap.xlsx` ([R28](../rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6) předepisuje statická simulovaná data); bootstrap (X5_07–08); deset výkonů téhož dítěte (X5_11).



<a id="priprava-07-20261017"></a>

## Čtení pro návrh kapitoly 7 — 2026-10-17

Z originálního DOCX přečteny texty a tabulky zadání i místních řešení X6_01–22 (včetně ID rozdělených formátováním) a vybrané konceptuální položky C5. Doporučené náměty: pokrytí a replikace X6_01, vlivy na šířku X6_02/06/09, hospitalizované děti X6_11, čtení X6_12, známá/neznámá σ X6_15, vztah k testu a vnoření X6_17–18. Párové rozdíly X6_13 a podíly X6_21–22 se do navržené povinné části nezařazují; plánování X6_20 je pouze kandidát nepovinného rozšíření.

**Nový přepočet v R:** X6_11: 95% interval (93,89253250; 102,10746750). X6_12: m ≈ 366,666667, s ≈ 149,354165, kvantil t(5) ≈ 2,57058184 a interval (209,9290827; 523,4042506). Potvrzen číselný výsledek intervalu; z klíče nepřebírat kladný kvantil při argumentu T.INV(0,025;5), t-rozdělení samotného průměru ani jistotu přesně 95 pokrytých intervalů ve stovce opakování. Šest rychlostí čtení je vhodnější pro kritické posouzení podmínek než jako bezproblémový první příklad. Předstírání většího n nezvyšuje skutečnou přesnost.

Úplné vykreslení DOCX, vložené obrázky, externí klíče a empirický původ dat nebyly v tomto průchodu ověřeny. Nejde o kontrolu celé sady X5 ani všech výpočtů X6.

[Společný rozsah kontroly](HISTORIE.md#priprava-07-20261017).

## Související karty kapitol

Tematické vazby pro výběr podkladů: [kapitola 6](../kapitoly/06-vyberove-rozdeleni-testovani.md#mapa-kapitola-06). Konkrétní použití a stav ověření určují záznamy výše.
