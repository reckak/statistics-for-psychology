# AI tutor: pedagogické konvence

<a id="r62-ai-tutor"></a>

## R62 — Zahájení studia, cvičení a vizualizace

**Schváleno 2026-11-02:** autor výslovně zadal realizaci plánu
„AI tutor 0.2.1: srozumitelný začátek studia a aktivní učení“ včetně
úplného vydání do stejného soukromého pluginu. Předtím zvolil hlavní
výchozí prompt s průvodcem kapitolou, způsobem práce a rozsahem.

Platí pro AI tutora, nikoli pro změnu výkladu nebo rozsahu učebnice.
Doporučené zahájení přebírá známé údaje a nepřekáží přímé otázce.
Pomoc se cvičením nevyžaduje předchozí výpočet, řešení se zpřístupňuje
po pokusu nebo na výslovnou žádost. Vhodné interaktivní vizualizace mají
podporovat vlastní zkoumání vztahů a respektovat možnosti klienta.

Hlavním místem pravidel jsou [instrukce tutora](../../plugins/statistika-pro-psychology-ai-tutor/skills/statistika-tutor/SKILL.md)
a jejich odkazované reference. Testy a výsledky patří do autorské historie;
schválení není dokladem dokončení vydání ani účinnosti na studentech.

<a id="r63-plany-a-konvence-tutora"></a>

## R63 — Výukové plány, konvence a obecná metodika vizualizací

**Schváleno 2026-11-03:** autor v chatu „Úprava instrukcí pluginu“ po
upřesnění negativních/pozitivních formulací výslovně potvrdil nejnovější
plán slovy „Ano, nejnovější plán schvaluji.“ Předtím zvolil zachování
úplných kapitol 1–6 a omezení volby rozšíření na nepovinné části učebnice.

Rozsah: AI tutor a jeho export, nikoli změna studentského výkladu.
Rozvíjí [R62](#r62-ai-tutor); jeho pravidla pomoci a režimů zůstávají platná.
Hlavním místem provozních pravidel jsou [instrukce tutora](../../plugins/statistika-pro-psychology-ai-tutor/skills/statistika-tutor/SKILL.md)
a jejich reference. [Kapitolové karty](../OSNOVA.md) zůstávají hlavním
místem mapy skutečného učiva, generované plány jsou odvozeným výstupem.
Schválení nezahrnuje publikování kandidáta do cloudového pluginu;
kontroly a skutečný stav vydání patří do autorské historie.

### Původní schválený plán

# Revize AI tutora: přesné podklady, vymezené učivo a srozumitelné instrukce

## Záměr a výchozí volby

Připravit verzi **0.3.0**, která používá konvence učebnice, vede studium podle ověřených plánů a nabízí účelné vizualizace.

Zachovat úplné materiály kapitol **1–6**. Výchozí studium zahrnuje povinné učivo; volba „s nepovinnými rozšířeními“ přidává označené rozšiřující části učebnice. Témata mimo učebnici vysvětlovat na výslovný dotaz jako oddělený doplněk.

## 1. Zpřehlednění instrukcí

- Revidovat hlavní skill, reference, výukové plány a instrukční texty vytvářené exportem. Studentský text učebnice ponechat mimo tuto stylistickou revizi.
- Pravidla formulovat přednostně jako **situace → požadovaný postup → způsob ověření**. Například: „Při nabídce kapitol přebírej čísla a názvy doslovně z katalogu.“
- U chybějících podkladů určit náhradní postup: načíst menší část, vymezit dostupné informace nebo si vyžádat konkrétní chybějící vstup.
- Zachovat stručné výslovné hranice tam, kde pomáhají zabránit závažné chybě, zejména vymýšlení zdrojů, zadání a výsledků. Připojit k nim správný postup.
- Sloučit opakovaná pravidla, odstranit rozpory a konkrétní regresní případy přesunout do testů. Hlavní skill ponechat stručný; podrobnosti načítat z tematických referencí.
- Účinnost přeformulování posoudit podle chování tutora, nikoli podle počtu odstraněných záporů.

## 2. Katalog, zahájení studia a výukové plány

- Generovat přesná čísla, názvy a pořadí kapitol ze společného katalogu podle struktury knihy a skutečných nadpisů.
- Registr rozšířit na všech osm existujících kapitol s údajem o dostupnosti. Úvodní nabídka studia bude obsahovat přibalené kapitoly 1–6 a stručnou informaci o omezené dostupnosti 7–8.
- Do hlavních instrukcí zahrnout generovaný seznam kapitol, čtyři způsoby studia a možnosti rozsahu: celá kapitola, konkrétní téma či otázka, cvičení. Volbu nepovinných částí evidovat samostatně.
- Průvodce přebírá známé volby a zjišťuje pouze chybějící. Na konkrétní dotaz tutor rovnou odpovídá. Témata přiřazuje ke skutečným kapitolám.
- Připravit samostatné výukové plány kapitol 1–6 podle kapitolových karet a skutečného výkladu, zadání a řešení. Každý plán vymezí cíle, předpoklady, výukové úseky, pojmy, značení, příklady, cvičení a hranice učiva.
- Rozlišovat povinný výklad, vstupní znalosti, nepovinné části a pouhé zmínky. Tutor před další otázkou či úlohou kontroluje její předpoklady proti plánu.
- V delším rozhovoru udržovat stručný stav studia a další krok vztahovat k plánu. Pro úzký dotaz načítat jen potřebnou část.
- Nejednoznačná označení úloh řešit obecným pravidlem cíleného upřesnění; konkrétní příklad „4.3“ ponechat v testech.

## 3. Terminologie a značení

- Sjednotit hlavní instrukce, metodiku vizualizací, příklady a testovací očekávání s přehledy učebnice.
- Pro směrodatnou chybu průměru v modelu používat σₘ, pro její odhad z dat sₘ. Rozlišení uplatnit ve výkladu, výpočtech, grafech i ovladačích.
- Alternativní značky vysvětlovat jako alternativy; označené ukázky reportování řídí výjimky učebnice.
- Existující přehledy zachovat jako hlavní zdroj terminologie a značení. Výukové plány obsahují potřebné odkazy a stručné orientační údaje.

## 4. Obecná metodika vizualizací

- Metodiku založit na učební otázce a aktuální úloze. Tři dosavadní demonstrace přesunout mezi příklady; korelaci označit jako doplněk mimo přibalený výklad.
- Výchozí hodnoty, jednotky a předpoklady převzít ze zadání. Zpřístupnit parametry potřebné pro zkoumaný vztah, další možnosti odkrývat podle potřeby.
- Pro číselné parametry zpravidla použít posuvník a přesný číselný vstup; pro kategorie nabídku či přepínače. Rozsahy a kroky přizpůsobit významu veličiny.
- Ovladače, nápovědy, legendy a hlášení pojmenovat česky se značením učebnice. Nabídnout obnovení zadání a samostatné nové losování.
- Jednu vizualizaci využívat u souvisejících úloh opakovaně. Další vytvářet při novém výukovém přínosu, konkrétní obtíži nebo žádosti studenta.
- Velikost panelu oddělit od hodnot grafu. Osy nastavit pro povolené parametry včetně rezervy; při porovnávání zachovat společná měřítka a změny měřítka označit.
- Zachovat správné hustoty a plochy, čitelnost i dostupnost ovladačů v úzkém a nízkém panelu. Při nedostupné interaktivitě poskytnout označenou statickou náhradu.

## 5. Ověření a vydání

Rozšířit kontroly exportu i scénáře v cílovém klientu:

- Přesné názvy a pořadí kapitol, přiřazení tématu ke kapitole a oprava chybného názvu zadaného studentem.
- Shoda plánů s výkladem, dostupnost odkazovaných podkladů a respektování volby nepovinných částí.
- Správná notace ve všech výstupech, také při dotazu obsahujícím SE.
- Delší studium a zkoušení v dohodnutém rozsahu; oddělené zpracování výslovného dotazu mimo učebnici.
- Přímé odpovědi bez zbytečného průvodce a opakované využití existující vizualizace.
- Krajní kombinace parametrů, přesný vstup, reset, klávesnice, kontrast a přizpůsobení šířce i výšce.
- Načítání skutečných souborů v novém chatu a správný náhradní postup při nedostupnosti.

Aktualizovat dokumentaci a historii kontrol; návrhy odlišit od schválených voleb. Zachovat identitu a přístup pluginu. Nejprve sestavit a ověřit kandidátní balíček; publikování bude samostatným autorizovaným krokem. Výsledky kontroly archivu a ověření chování v ChatGPT uvádět odděleně.
