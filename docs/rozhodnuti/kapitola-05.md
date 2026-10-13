# Dohody k pravděpodobnosti

[Registr rozhodnutí a aktuální platnost](../ROZHODNUTI.md) · [Pravidla evidence](../../AGENTS.md#evidence-rozhodnuti)

Níže jsou zachovány původní záznamy schválených voleb, jejich důvody a doklady. Data, rozsah a formulace se vztahují k uvedeným dohodám; záznamy mohou obsahovat později nahrazené části nebo již provedené úkoly. Aktuální platnost a hlavní místo údržby určuje řádek v registru. Staré seznamy se při běžné aktualizaci slovníku, obsahu či pracovního postupu znovu nesynchronizují; nová schválená změna dostane vlastní datovaný doklad.

<a id="r21-rozsah-kapitoly-5"></a>

## R21 — Rozsah a pořadí kapitoly 5 o pravděpodobnosti

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r21-rozsah-kapitoly-5). Původní záznam dohody:*

**Stav:** schváleno 2026-10-11. **Rozsah:** kapitola 5, její cvičení, sešit
a navazující přehledy. Podrobné pořadí oddílů eviduje
[mapa obsahu](../kapitoly/05-pravdepodobnost.md#mapa-kapitola-05).

- Celý rozsah autorovy přednášky `probability.pptx` tvoří **jednu kapitolu**
  ve dvou blocích: pravděpodobnost jevů (pojetí, výběrový prostor a jevy,
  součtové pravidlo, kontingenční tabulka, podmínění a nezávislost,
  úplná pravděpodobnost a Bayesova věta) a rozdělení pravděpodobnosti
  (náhodná proměnná, faktoriál a kombinace, binomické rozdělení, normální
  aproximace). Kombinace i normální aproximace jsou povinné.
- **Chyby pravděpodobnostního úsudku jsou povinné** a vykládají se u pravidla,
  které porušují: hráčský klam, konjunkční klam, záměna P(A | B) a P(B | A),
  zanedbání základních četností. Netvoří samostatný přehled heuristik.
- **Nepovinná rozšíření** bez povinných cvičení: šance a jejich vztah
  k pravděpodobnosti; obecná střední hodnota a rozptyl diskrétní náhodné
  proměnné; variace bez opakování.
- Výklad obrácení podmínky postupuje: přirozené četnosti a tabulka → strom
  → **úplná pravděpodobnost jako samostatně vysvětlený krok** (rozklad podle
  jevu a jeho doplňku, bez obecného indexovaného zápisu) → Bayesova věta.
  Součástí je **srovnání dvou prevalencí při stejné senzitivitě a specificitě**.
- **Věrohodnost** (*likelihood*) se zatím nezavádí; Bayesova věta se vykládá
  celá pomocí podmíněných pravděpodobností.
- Různá pojetí pravděpodobnosti představujeme jako různé interpretace, které
  používají společná matematická pravidla; nemusí vést ke stejnému číselnému
  hodnocení téže situace.
- Vztah „pravděpodobnost 0 = nenastane“ vykládáme na konečném modelu, v němž
  mají všechny možné výsledky kladnou pravděpodobnost, a připomínáme odlišnost
  spojitého modelu. Podmíněná pravděpodobnost a intuitivní tvar nezávislosti
  P(A | B) = P(A) vyžadují P(B) > 0; definicí nezávislosti je součinový tvar.
- Z pravděpodobnosti „právě k úspěchů“ se nevyvozuje totéž co z „k nebo více“:
  volba závisí na předem položené otázce. Ani jeden výpočet sám neprokazuje
  psychologický závěr; formální testování zůstává pozdější kapitole.
- **Mimo kapitolu:** binomický a znaménkový test, multinomické rozdělení,
  výběrové rozdělení průměru, centrální limitní věta, standardní chyba,
  intervaly spolehlivosti, testování hypotéz, Poissonovo rozdělení,
  bayesovská statistika.

**Důvod:** kapitola odpovídá jedné přednášce; pravidla pro jevy a binomický
model se navzájem potřebují a společně připravují pozdější inferenci.
Chyby úsudku jsou psychologickým obsahem i didaktickou oporou pravidel.

**Nahrazuje:** otevřené otázky oddílu „Plán další kapitoly“ v osnově
ve znění z 2026-10-11. Pořadí a rozsah kapitol následujících po páté
tím schváleny nejsou.

**Doklad:** autorova volba „Vše v jedné kapitole“; „Chyby pravděpodobnostního
úsudku povinně, ostatní zachovat také, ale jako nepovinné“; požadavek doplnit
„úplnou pravděpodobnost jako vysvětlený krok před Bayesovým vzorcem“
a „srovnání dvou prevalencí při stejné senzitivitě a specificitě“; souhlas
s nezavedením věrohodnosti; pět oprav formulací návrhu (pojetí, výsledek
a elementární jev, pravděpodobnost 0 a podmínka P(B) > 0, kurz a kombinační
číslo, otázka „právě“ versus „alespoň“) a konečné schválení návrhu.
Záznam „Kapitola 5: dohoda o obsahu“ v [historii](../../quarto/README.md).

<a id="r22-znaceni-pravdepodobnosti"></a>

## R22 — Značení pravděpodobnosti a binomického modelu

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r22-znaceni-pravdepodobnosti). Původní záznam dohody:*

**Stav:** schváleno 2026-10-11. **Rozsah:** kapitola 5, přehled značení
a další použití v učebnici a souvisejících materiálech.

- Pravděpodobnost jevu zapisujeme **velkým P**: P(A). Průnik P(A ∩ B) čteme
  „A a zároveň B“, sjednocení P(A ∪ B) „A nebo B“ (alespoň jeden z nich),
  podmíněnou pravděpodobnost P(A | B) „A za podmínky B“. Doplňkový jev
  značíme A′. Symboly zavádíme vždy se slovním čtením.
- Malé p zůstává relativní četností, podílem a úrovní kvantilu
  ([R02](kapitola-02.md#r02-indexy-a-cetnosti), [R09](kapitola-04.md#r09-kapitola-4-model-qq));
  pravděpodobnost jevu se jím neznačí.
- Pravděpodobnost úspěchu v jednom pokusu binomického modelu je parametr
  a značí se **stojatým π**; n je počet pokusů, k počet úspěchů. Text
  upozorňuje, že nejde o číslo 3,14 a že Excel i řada učebnic píší p.
- Navazující značky: X pro náhodnou proměnnou a P(X = k) pro pravděpodobnost
  její hodnoty; n! pro faktoriál; kombinační číslo zápisem „n nad k“;
  střední hodnota binomického rozdělení μ = nπ a směrodatná odchylka
  σ = √[nπ(1 − π)], obojí stojatě podle pravidla o parametrech.
  V nepovinné části O pro šance.

**Důvod:** velké P odliší pravděpodobnost jevu od podílu a od pozdější
p-hodnoty; řecké π dodržuje pravidlo o značení parametrů a oddělí modelovou
pravděpodobnost od pozorovaného podílu p při pozdější inferenci o podílech.

**Nahrazuje:** větu R09, že se nezavádí zápis náhodných veličin ani P(…),
v rozsahu kapitoly 5. Značky Φ a Φ⁻¹ se nadále nezavádějí.

**Doklad:** autorovy volby „P(A ∩ B), P(A ∪ B), P(A | B)“ a „π, počet
pokusů n, úspěchů k“ při projednání kapitoly; navazující značky byly součástí
schváleného návrhu. Záznam „Kapitola 5: dohoda o obsahu“
v [historii](../../quarto/README.md).

<a id="r23-terminologie-kapitoly-5"></a>

## R23 — Terminologie kapitoly 5

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r23-terminologie-kapitoly-5). Původní záznam dohody:*

**Stav:** schváleno 2026-10-11. **Rozsah:** kapitola 5, slovníček, přehledy
a další použití pojmů. Úplný seznam s anglickými ekvivalenty, alternativami
a pravidly použití je v [registru](../SLOVNIK.md#kapitola-05); zde jsou
rozhodující rozlišení a doklad.

- **Výběrový prostor** (*sample space*) je hlavní termín; při zavedení
  vysvětlit, že jde o množinu všech možných výsledků náhodného pokusu,
  a upozornit na rozdíl oproti výběru (výběrovému souboru). „Prostor
  výsledků“ je vysvětlující alternativa. „Pole jevů“ označuje jiný pojem
  a mezi alternativy nepatří.
- **Výsledek náhodného pokusu** (*outcome*) je prvek výběrového prostoru.
  „Elementární jev“ je jednoprvková množina, která jej obsahuje; není to
  prosté synonymum.
- **Klasické, četnostní a subjektivní pojetí pravděpodobnosti.** „Analytický“
  výpočet je širší označení, nikoli synonymum klasického pojetí.
- **Základní četnost** (*base rate*) je podíl výskytu jevu ve zvolené
  populaci či referenční skupině, nikoli absolutní počet. **Prevalence**
  vyjadřuje zastoupení osob s určitým onemocněním či stavem ve vymezené
  populaci a čase; v diagnostickém příkladu poskytuje základní četnost.
  **Apriorní pravděpodobnost** je pravděpodobnost před zohledněním nové
  informace; „před novou informací“ neznamená „bez podkladů“. V příkladu
  ji stanovíme podle základní četnosti, obecně může vycházet i z dalších
  informací. Tři pojmy spolu v diagnostickém příkladu souvisejí, ale
  nejsou obecnými synonymy.
- **Marginální pravděpodobnost** vykládáme jako součet přes možnosti druhé
  proměnné v kontingenční tabulce; „nepodmíněná pravděpodobnost“ není její
  obecné synonymum. „Čtyřpolní tabulka“ je zvláštní případ kontingenční
  tabulky 2 × 2.
- **Kombinace** je neuspořádaný výběr prvků; **kombinační číslo** udává
  počet takových výběrů. Uspořádaný výběr části prvků je **variace bez
  opakování**, odlišená od permutace všech prvků; funkce Excelu se přesto
  jmenuje PERMUTACE.
- **Šance** (*odds*) odlišujeme od pravděpodobnosti; „kurz“ mezi alternativy
  nepatří, sázkový kurz není obecně totéž co statistická šance.
- **Přirozené četnosti** jsou počty při postupném členění jedné společné
  výchozí skupiny. **Úspěch** v binomickém modelu je technické označení
  sledovaného výsledku, nikoli nutně žádoucího.
- Autor dále potvrdil: náhodný pokus, doplňkový jev, vzájemně výlučné jevy,
  společná pravděpodobnost, **náhodná proměnná** (alternativa náhodná
  veličina), rozdělení pravděpodobnosti a **střední hodnota** (alternativa
  očekávaná hodnota). Ostatní hesla registru byla schválena jako součást
  předloženého návrhu.

**Důvod:** jednoznačné názvy bez záměny souvisejících pojmů; návaznost
na „proměnná“, „doplněk“ a „vzájemná výlučnost“ z dřívějších kapitol.

**Doklad:** autorovy pokyny při projednání kapitoly: „Sample space překládej
primárně jako ‚výběrový prostor‘“; „Outcome překládej jako ‚výsledek
náhodného pokusu‘“; „Base rate ponech jako ‚základní četnost‘“; „Odděl
‚kombinaci‘ a ‚kombinační číslo‘“; „Pro uspořádaný výběr používej ‚variace
bez opakování‘“; „odstraň ‚kurz‘ ze synonym“; „Sjednoť názvy na ‚klasické,
četnostní a subjektivní pojetí pravděpodobnosti‘“; „‚Náhodnou veličinu‘
a ‚očekávanou hodnotu‘ uveď jako alternativy“; vymezení tří pojmů základní
četnost, prevalence a apriorní pravděpodobnost; následné schválení návrhu.
Záznam „Kapitola 5: dohoda o obsahu“ v [historii](../../quarto/README.md).


<a id="r25-revize-kapitoly-5"></a>

## R25 — Zapracování odborné revize kapitoly 5

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r25-revize-kapitoly-5). Původní záznam dohody:*

**Stav:** schváleno 2026-10-12. **Rozsah:** kapitola 5, její grafy, sešit,
slovníček, autorský registr a související kontroly. R21–R23 zůstávají platné;
upřesňuje se výklad, nikoli rozsah učiva nebo značky.

- Senzitivita a specificita jsou při srovnání prevalencí stejné z předpokladu;
  jejich přenos mezi skupinami není automatický. Doplněk specificity/senzitivity
  se výslovně vztahuje k příslušné skupině bez stavu / se stavem.
- Náhodný pokus vymezuje možné výsledky, nevyžaduje jejich vyjmenování
  ani vyloučení manipulace. Definice rozdělení zahrnuje i spojité modely.
- Doplněk vysokého stresu se nazývá „bez vysokého stresu“, nikoli „pohoda“.
  Opravují se příklady nezávislosti a podmíněných pravděpodobností při
  losování bez vracení. Modelové situace se nevydávají za empirické výzkumy.
- Na `Binom` zůstává n = 5; měnit lze pouze B3. `Binom_20` zachovává
  tabulku pro 20 pokusů a umožňuje změnit pravděpodobnost a hranice;
  výsledné popisky musí odpovídat aktuálním vstupům.

**Důvod:** zabránit záměně podmíněných a společných pravděpodobností,
modelového předpokladu a obecné vlastnosti, modelových a skutečných dat
nebo nesprávnému čtení výsledků po změně vstupů sešitu.

**Doklad:** autor po předložení dvanácti nálezů a tří doporučení zadal:
„Zapracuj všechny uvedené opravy i didaktická doporučení do kapitoly 5
a souvisejících souborů. Na listu Binom ponech n = 5 a umožni měnit jen B3.“
Rozsah ověření zaznamenává [autorská historie](../../quarto/README.md#revize-kapitoly-5-2026-10-12).
