# Dohody k poloze a variabilitě

[Registr rozhodnutí a aktuální platnost](../ROZHODNUTI.md) · [Pravidla evidence](../../AGENTS.md#evidence-rozhodnuti)

Níže jsou zachovány původní záznamy schválených voleb, jejich důvody a doklady. Data, rozsah a formulace se vztahují k uvedeným dohodám; záznamy mohou obsahovat později nahrazené části nebo již provedené úkoly. Aktuální platnost a hlavní místo údržby určuje řádek v registru. Staré seznamy se při běžné aktualizaci slovníku, obsahu či pracovního postupu znovu nesynchronizují; nová schválená změna dostane vlastní datovaný doklad.

<a id="r04-kvantily"></a>

## R04 — Kvantily a krabicový graf

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r04-kvantily). Původní záznam dohody:*

**Stav:** schváleno. **Rozsah:** kapitola 3 a navazující použití jejích konvencí.

Hlavní konvence pro číselná data používá interpolaci odpovídající
`PERCENTIL.INC` (interně `quantile`, typ 7). Je použitelná i pro diskrétní
číselné hodnoty; kvantil nemusí být pozorovatelnou hodnotou proměnné.
Pro čistě ordinální kategorie používáme první dosažený kumulativní podíl,
bez interpolace číselných kódů. Stejný kumulativní postup lze zvolit
i pro číselná data, pokud otázka požaduje pozorovanou hodnotu.
Percentilové pořadí v učebnici zahrnuje hodnoty menší nebo rovné dané hodnotě.

Kvartily krabicového grafu počítáme hlavní interpolovanou konvencí;
nezaměňujeme je automaticky s výchozími Tukeyho závěsy v R. Vousy končí
na krajních pozorovaných hodnotách uvnitř pomocných mezí včetně samotné
meze. Samostatně označené body nejsou automaticky chybná data.

**Důvod:** konzistence Excelu, výpočtů a grafů a oddělení odlišných otázek,
které různé konvence zodpovídají. Zpřesnění nahrazuje dřívější příliš široké
tvrzení o jedné konvenci pro všechny výpočty kvartilů.
**Doklad:** záznamy „Kapitola 3: ukazatele polohy a variability“ (2026-10-05),
„Kapitola 3: názorná konstrukce boxplotu a normalizovaná entropie“
a „Kapitola 3: jasné rozlišení konvencí kvantilů“ (2026-10-09) v
[historii](../../quarto/README.md); [kvantily](../../quarto/kapitola_03.qmd#sec-kvantily)
a [boxplot](../../quarto/kapitola_03.qmd#sec-boxplot).

**Upřesnění 2026-10-14:** autor požádal, aby text formuloval lineární
interpolaci (typ 7) jako primární pojem a pravidlo učebnice a funkci
`PERCENTIL.INC` uváděl až jako její výpočet v Excelu. Spojení
„konvence PERCENTIL.INC“ se ve výkladu nahrazuje interpolační konvencí.
Pravidlo výpočtu, percentilové pořadí ani konstrukce boxplotu se nemění.
Autor také výslovně požádal, aby text u výčtu konvencí percentilového
pořadí uvedl, že učebnice používá inkluzivní konvenci; jde o realizaci
původního pravidla. **Doklad:** konverzace autora s Claudem 2026-10-14
(připomínky k řádkům 154 a 260 kapitoly 3); záznam „Kapitola 3: revize
opakování, výjimek středu a populačních značek“ v [historii](../../quarto/README.md).

<a id="r06-robustni-shrnuti"></a>

## R06 — Konvence robustního shrnutí

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r06-robustni-shrnuti). Původní záznam dohody:*

**Stav:** schváleno. **Rozsah:** příklady kapitoly 3 a jejich další použití.

MedAD používáme bez škálovací konstanty (interně v R `constant = 1`).
U ořezání a winsorizace udáváme podíl pro každý konec zvlášť a počet
upravovaných hodnot zaokrouhlujeme dolů. U malého souboru proto skutečný
podíl upravených hodnot nemusí být roven nominálně zvolenému podílu.

**Důvod:** předejít nepozorované změně výsledku při použití jiných
programových výchozích nastavení a přesně popsat postup.
**Doklad:** „Kapitola 3: ukazatele polohy a variability“ (2026-10-05)
a „Kapitola 3: kumulativní kvantily, stupně volnosti a robustní shrnutí“
(2026-10-09) v [historii](../../quarto/README.md);
[výklad](../../quarto/kapitola_03.qmd#sec-odolne-shrnuti).

<a id="r14-kvartily-spicatost-chvost"></a>

## R14 — Označení kvartilů, špičatost, chvost a data kapitoly 3

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r14-kvartily-spicatost-chvost). Původní záznam dohody:*

**Stav:** schváleno 2026-10-11. **Rozsah:** kapitola 3, slovníček, přehled
značení, sešit kapitoly a další použití těchto pojmů v učebnici.

- **1. a 3. kvartil** je hlavní označení kvantilů na úrovních 0,25 a 0,75;
  „dolní“ a „horní kvartil“ uvádíme jen při zavedení pojmu a ve slovníčku
  jako alternativu. Druhý kvartil je medián. Značení q s úrovní v indexu
  a výpočetní konvence podle [R04](#r04-kvantily) se nemění.
- **Špičatost** je hlavní český termín pro *kurtosis*; „kurtóza“ je
  alternativa ve slovníčku. Výklad dál výslovně upozorňuje, že koeficient
  neměří ostrost ani výšku vrcholu. Exces zůstává.
- Při popisu tvaru rozdělení používáme důsledně **chvost** (levý, pravý),
  nikoli „konec“ rozdělení. „Konec“ zůstává pro konce vousů a pro konce
  seřazené řady při ořezání a winsorizaci.
- Údaje všech příkladů kapitoly 3 dostávají studenti v jediném souboru,
  excelovém sešitu (list `Dalsi_priklady` doplňuje jedenáct dob, deset dob
  a 41 skórů). Samostatné CSV kapitoly 3 bylo zrušeno; skripty obsahují
  tytéž pevné hodnoty.

**Důvod:** jednotné označení bez střídání synonym; číselné označení kvartilů
odpovídá běžným značkám Q₁ a Q₃; jeden soubor místo dvou neúplných.

**Nahrazuje:** hlavní tvary „dolní/horní kvartil“ a „kurtóza“ z dosavadního
znění kapitoly 3 a slovníčku.

**Doklad:** pokyny autora při revizi kapitoly 3 dne 2026-10-11: „používal
bych konzistentně ‚chvost‘ místo ‚konec‘ distribuce“; „jako primární
používal označení 1./3. kvartil a uvedl označení ‚dolní‘ a ‚horní‘ pouze
jako možnou alternativu“; „pro kurtosis bych jako primární překlad/termín
volil ‚špičatost‘, kurtóza uvedl pouze jako možnou alternativu“; „vše dal
do jednoho souboru, a to toho excelovského“. Záznam „Kapitola 3: revize
po posouzení“ v [historii](../../quarto/README.md).

<a id="r36-populacni-znacky-v-kapitole-3"></a>

## R36 — Zavedení μ, σ² a σ v kapitole 3

**Stav:** schváleno 2026-10-14. **Rozsah:** kapitoly 3 a 4, přehled značení.

Populační průměr $\mathrm{μ}$, populační rozptyl $\mathrm{σ}^2$ a populační
směrodatná odchylka $\mathrm{σ}$ se zavádějí už v kapitole 3, v oddílu
o dělení $n-1$, kde se poprvé pracuje se skutečnou populací (simulace:
μ = 6 minut, σ² = 8 min²). Varianta rozptylu s dělením $n$ u pozorovaného
souboru se značkou σ² neoznačuje; text jen uvádí, že kdyby soubor tvořil
celou populaci, šlo by o σ². Kapitola 4 značky připomíná a odkazuje na
kapitolu 3. Typografie (stojaté řecké písmo) a význam značek se nemění.

**Důvod:** autor navrhl zavést σ u výpočtu s dělením $n$. Claude upozornil,
že pozorovaný soubor je výběr, a doporučil zavést značky u populace.
Spolu s σ² se hodí i μ, protože výklad potřebuje rozlišit $m$ od populačního průměru.
**Doklad:** konverzace 2026-10-14: autor odpověděl „Souhlasím s doporučeními
toho, jak zavést σ²; také s tím, že lze již zavést μ pro populační průměr.“
Hlavní místo: [výklad](../../quarto/kapitola_03.qmd#populacni-parametry)
a [přehled značení](../../quarto/znaceni.qmd).

<a id="r47-ukazatele-tvaru"></a>

## R47 — Šikmost a exces jako povinné ukazatele tvaru

*Číslo přiděleno při slučování s `main` 2026-10-17: návrh v PR #102 používal R44, které mezitím získal rozsah kapitoly 7 ([R44](kapitola-07.md#r44-rozsah-kapitoly-7)). Obsah ani doklad dohody se nezměnil.*

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r47-ukazatele-tvaru). Původní záznam dohody:*

**Stav:** schváleno 2026-10-17. **Rozsah:** kapitola 3 (povinný oddíl,
cvičení, sešit), kapitola 4 (oddíl o čtení Q–Q grafů, cvičení 10), slovníček,
přehled funkcí Excelu.

- Šikmost a exces se v kapitole 3 vysvětlují v povinné části pod názvem
  **Ukazatele tvaru**: význam znaménka a velikosti, srovnání s normálním
  modelem a grafy modelů s nulovou, střední a vysokou šikmostí a excesem.
  Výklad nesmí vytvářet miskoncepci „exces = výška či ostrost vrcholu“;
  řádek excesu proto zvýrazňuje chvosty a protipříklad se stejným vrcholem
  je součástí povinné části.
- Studenti povinně získávají a interpretují **SKEW** a **KURT** v Excelu.
  Přesný výpočet (momenty, g₁, g₂, korekce, SKEW.P) zůstává v nepovinném
  rozšíření. Ve výkladu a výsledcích se uvádí exces; špičatost = exces + 3
  se jen zmiňuje (terminologie podle [R14](#r14-kvartily-spicatost-chvost)).
- Kapitola 4 v oddílu o odchylkách od přímky ukazuje, že Q–Q grafy
  a koeficienty šikmosti a excesu poskytují konvergentní informaci, a uvádí
  meze koeficientů; cvičení 10 se o koeficienty rozšiřuje.

**Důvod:** studenti mají chápat, co koeficienty vyjadřují, protože je běžně
potkávají ve výstupech programů; interpretace bez výpočtu je pro semestr
přiměřená a navazuje na posouzení tvaru v kapitole 4.

**Nahrazuje:** zařazení šikmosti a špičatosti pouze do nepovinného rozšíření
(kapitola 3 před 2026-10-17); ostatní části H08 a R14 platí.

**Doklad:** pokyn autora 2026-10-17: „v kapitole 3 bych aspoň šikmost
a špičatost/exces … aspoň jednoduše, ale bez miskoncepcí vysvětlil
v ‚povinné‘ části (asi bych to nazval Ukazatele tvaru) a zobrazil pro
názornost grafy rozdělení s různou mírou šikmosti a špičatosti/excesu
(žádná, střední, vysoká) … Přesný výpočet bych ponechal v nepovinné
rozšiřující části“ a „těmito koeficienty ‚obohatil‘ kapitolu 4.7.4, aby
bylo jasné, že Q-Q grafy i koeficienty šikmosti a excesu poskytují
konvergentní informace“. Odpovědi na upřesňující otázky téhož dne:
„SKEW a KURT povinně“, „Zvýraznit chvosty“, „4.7.4 + rozšířit cvičení 10“.
Provedení: záznam „Kapitoly 3 a 4: povinné ukazatele tvaru“ v
[historii](../../quarto/README.md).
