# Metodika interaktivních vizualizací

Jde o autorské vodítko k vlastnímu výukovému doplňku, nikoli další kapitolu.
Nejprve přečti relevantní výklad. Pro výběrové rozdělení použij kapitolu 6,
oddíly sec-chyba-prumeru a sec-chyby-sila; z-test je zjednodušený modelový
doplněk. Korelace je obecné rozšíření mimo úplné přibalené kapitoly.

## Společný postup

Použij skutečně dostupné interaktivní zobrazení klienta, jeho dokumentaci
a příslušný postup tvorby, pokud jej nabízí. Vytvoř fungující výstup;
neskonči příslibem ani samotným kódem. Nevyžaduj další plugin nebo server.
Bez podpory nabídni vypočtené statické srovnání a jasně je tak označ.

Podle režimu: předpověď → manipulace → pozorování → vysvětlení. U přímého
výkladu nečekej povinně na předpověď. Jedna hlavní otázka a jeden hlavní
ovladač; další ovladače přidávej jen pro konkrétní učební cíl. Neprozrazuj
odpovědi zkoušky předem. Výklad a otázky patří do rozhovoru kolem grafu.

České popisky, jednotky, legenda, rozlišení modelu a dat, ovládání klávesnicí,
čitelný úzký displej a tlačítko návratu k výchozím hodnotám. Graf nesmí
využívat pouze barvu k rozlišení významu. Ověř, že ovladač skutečně mění graf
i správně vypočtené hodnoty. Náhodné realizace reprodukuj pevným seedem;
nové losování odděl od změny hlavního parametru. Zachovej porovnatelné osy,
nebo změnu měřítka výslovně označ. Nevydávej simulaci za pozorovanou studii.

## Velikost výběru a výběrové rozdělení

Výchozí model: nezávislé výběry ze stejné populace s průměrem 35 s a
směrodatnou odchylkou 15 s. První demonstrace může použít normální populaci;
uveď, že normalita průměru je pak přesná pro každé n, nikoli důkaz CLV.
Při vysvětlování CLV použij samostatně výslovně popsanou nenormální populaci.

Hlavním ovladačem je počet osob n, například 25, 100 a 400. Odděleně ukaž
rozdělení jednotlivých hodnot a rozdělení průměrů, obě osy v sekundách.
Směrodatná chyba je σ/√n: 3; 1,5; 0,75 s. Střed populace i její variabilita
zůstávají stejné. Velikost výběru nezaměňuj za počet opakování simulace M;
ten drž pevný a uveď jej. Empirický rozptyl simulovaných průměrů se může
od teoretického vztahu mírně lišit. Větší n nenormalizuje jednotlivé hodnoty.

## Skutečný účinek a statistická síla

Použij oboustranný jednovýběrový z-test, známé σ = 15 s, n = 100,
α = 0,05 a nulový průměr μ₀ = 35 s; SE = 1,5 s. Hlavním ovladačem je
skutečný rozdíl Δ = μ − μ₀ v sekundách, výchozí Δ = 3 s.
Ukaž rozdělení průměru za H₀ a za zvolenou alternativou. Kritické hranice
μ₀ ± z₀,₉₇₅ SE zůstávají při změně Δ stejné. Vyznač obě kritické oblasti,
plochu zamítnutí pod alternativou a zbývající plochu β.

Pro a = Δ/SE a c = z₀,₉₇₅ je pravděpodobnost zamítnutí
Φ(−c−a) + 1−Φ(c−a). V nulovém bodě je rovna α; tam jde o chybu I. druhu,
nikoli pravděpodobnost odhalení existujícího účinku. U nenulové alternativy
jde o sílu, β je její doplněk. Při těchto pevných podmínkách roste s |Δ|.
Nejde o pravděpodobnost pravdivosti hypotézy ani o sílu vypočtenou
dosazením pozorovaného účinku jako důkazu kvality hotové studie.
Numerický výpočet ověř nezávislým nástrojem; aproximaci Φ neprezentuj
s větší přesností, než jakou skutečně poskytuje.

## Populační korelace a bodový graf

Modeluj dvojice X = U a Y = ρU + √(1−ρ²)V, kde U a V jsou nezávislé
standardní normální proměnné. Je to model standardizovaných skórů bez
jednotek, nikoli data konkrétní studie. Výchozí n = 100, ρ = 0,5.
Pro změny ρ ponech tytéž základní dvojice U,V; nové losování nabídni
samostatným tlačítkem. Osy drž stejné a dostatečné pro celý rozsah ρ,
včetně −1 a 1; neodřezávej krajní body.

Z dat skutečně spočítej Pearsonovo výběrové r pomocí centrovaných součtů.
Neopisuj do něj nastavené ρ: konečný výběr se zpravidla liší a při ρ = 0
nemusí mít přesně r = 0. Pokud je rozptyl některé proměnné nulový,
r je nedefinované, nikoli nula. Znaménko určuje směr, absolutní velikost
sílu lineárního vztahu. Nulové r nevylučuje nelineární závislost;
korelace sama neprokazuje kauzalitu. Připomeň omezení zvoleného modelu.
