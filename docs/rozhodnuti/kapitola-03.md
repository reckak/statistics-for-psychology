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
