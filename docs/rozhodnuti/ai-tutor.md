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

### Doplnění R63 — Prostředí testů, 2026-11-03

Autor výslovně povolil nahrát kandidátní ZIP do testovacího chatu a určil:
„pro ověření chování tutora pak používej režim chat, nikoli work“.
Důvodem je dostupnost pro studenty a šetření limitů Work. Zároveň požádal
o zápis tohoto pravidla do AGENTS.md. Hlavním místem je
[Ověřování AI tutora](../../AGENTS.md#overovani-ai-tutora); testy a provozní
návod na něj odkazují. Souhlas s testovací přílohou není publikováním
nového vydání pluginu. Původní schválený plán výše zůstává zachován.

<a id="r64-pravidla-ai-tutoru"></a>

## R64 — Samostatná pravidla AI tutorů, výstupy a verze

**Schváleno 2026-11-04:** autor v chatu o verzi tutora pro Claude a Gemini
napsal: „asi bych v AGENTS.md uvedl jen obecné instrukce pro práci na
AI tutorovi s odkazem na podrobnější pravidla v samostatném
docs/AITUTORS.md, kde by byla pravidla pro všechny tutory (která platí
pro všechny + konkrétní spefifická pro chatGPT, CLaude a Gemini)“.
Ve stejném rozhovoru určil, že hotové balíčky mají být v hlavní složce
rozdělené podle platformy (zvolil `ai-tutor/` s `chatgpt/`, `claude/`,
`gemini/`), a o verzi: „nemá smysl zvyšovat verzi na 0.3.5 ale zatím
ponechat všude 0.3.4, protože se myslím v tutorech pro ChatGPT ani CLaude
nic nemění“. Plán s těmito body výslovně schválil.

Rozsah: pravidla tvorby, vydání a ověřování AI tutorů na všech platformách;
pedagogické chování tutora zůstává podle R62 a R63 v jeho instrukcích.
Hlavním místem je [AITUTORS.md](../AITUTORS.md); AGENTS.md obsahuje jen
obecný oddíl s odkazem a příkazy zůstávají v [provozním návodu](../PROVOZ.md#export-ai-tutora).
Pravidlo testování v režimu Chat z doplnění R63 bylo převzato
a zobecněno na běžný konverzační režim každé platformy; jeho tehdejší
znění výše zůstává dokladem. Verze zůstává společná pro všechny platformy
a nemění se, když se obsah balíčků pro studenty nemění.

<a id="r79-vydani-tutora-na-githubu"></a>

## R79 — Vydání tutora na GitHubu a stránka ke stažení v učebnici

**Schváleno 2026-11-14:** autor se zeptal, zda nevyřadit `ai-tutor/`
z `.gitignore`, aby se balíčky verzovaly. Na doporučení vydávat archivy
jako GitHub Releases odpověděl „Ano, připrav návrh“. V dotazníku zvolil,
že vydání slouží „I ke stažení studenty“. Návrh doplnil: „Nebylo by
nejlepší, aby návod na stažení a instalaci tutorů byl i součástí
učebnice jako kapitola před výkladovými částmi, která by obsahovala
odkazy přímo ke stažení nejnovějších verzí tutorů“. V dalším dotazníku
zvolil stránku „Za úvod, před výklad“, názvy archivů „Ve vydání bez
verze“, „Nahradit stránkou v knize“ pro `navod.docx` a „První vydání
před sloučením“. Plán s těmito body výslovně schválil.

Rozsah: archivy se dál necommitují; každá verze má veřejné vydání
`tutor-v<verze>` se třemi archivy pod stálými názvy, vzniklé jen
z čistého exportu na odeslaném commitu, nejprve jako koncept, zveřejněné
autorem a později nepřepisované. Studentský návod je nečíslovaná stránka
`quarto/ai_tutor.qmd` mezi úvodem a výkladovými kapitolami s odkazy
`releases/latest/download/`; nahrazuje `ai-tutor/navod.docx`. Stránka
není součástí PDF ani balíčku tutora. Upřesňuje [R64](#r64-pravidla-ai-tutoru)
(umístění výstupů a verze zůstávají). Hlavní místo pravidel je
[AITUTORS.md](../AITUTORS.md#verze-a-vydání), postup v
[provozním návodu](../PROVOZ.md#vydani-ai-tutora-na-githubu).

<a id="r85-tutor-kapitoly-obrazky-tempo"></a>

## R85 — Tutor 0.4.0: všechny kapitoly, tempo výkladu, obrázky v odpovědi a data ke grafům

**Schváleno 2026-11-20 a 2026-11-21:** autor požádal o doplnění nových
kapitol do tutorů, o podrobnější vedení k vizualizacím a o to, aby tutor při
vysvětlování postupoval „po menších krocích a ověřovat porozumění po každém
kroku, pokud si samozřejmě uživatel tutora nepožádá výslovně o jiný způsob
práce“. V dotaznících zvolil čtení kapitol po „Rozsazích řádků“, „Celkové
přepsání“ instrukcí a u dat ke grafům „Pilot, pak zbytek“. Plán zpřesnil
čtyřmi připomínkami (brzké ověření čtení v klientu a kontrakt INDEX.md /
KAPITOLY.json; krokové pravidlo jen pro vedené vysvětlování a rozlišení
jednorázové a trvalejší volby; předem dané podmínky vydání) a pokynem:
„Vedený výklad musí být srozumitelný přímo v chatu. Statický obrázek učebnice
zobraz přímo, pokud to klient umožňuje, a upozorni na jeho podstatný rys;
pokud to není možné, snaž se o jeho věrnou reprodukci. Na interaktivní stránku
odkaž ve chvíli, kdy student potřebuje změnit vstup nebo porovnat výsledky.“
Po testech v klientech 2026-11-21 rozhodl: „provedl bych tedy možnosti A, B
i C: vhodně upravit instrukce, pro tutory místo svg používat png, a přibalit
data a popis grafu“ a doplnil, že adresy interaktivních vizualizací má tutor
dávat „rovnou v rámci kapitol … jako návrhy“ u příslušné části. Pro Gemini
určil: „potřebuji zip obsahující jen povolené typy“ a „SKILL.md. Musí být
v první úrovni složky“. Plán s těmito body schválil.

Rozsah: AI tutor a jeho export; výklad ani rozsah učebnice se nemění.
Upřesňuje [R62](#r62-ai-tutor) a [R63](#r63-plany-a-konvence-tutora), jejichž
znění zůstává dokladem tehdejší dohody; kde se liší, platí toto rozhodnutí.

1. **Všechny výkladové kapitoly** knihy jsou v balíčku s plným textem
   a výukovým plánem (nyní 1–10); dřívější omezení na kapitoly 1–6 z R63 neplatí.
2. **Čtení po částech:** plány uvádějí rozsahy řádků oddílů, zadání, řešení
   a záznamů obrázků jako navigaci. Katalogem pro nabídku kapitol je
   `INDEX.md`; malý registr `KAPITOLY.json` slouží ke zjištění verze a revize.
3. **Tempo vedeného vysvětlování:** jedna uchopitelná myšlenka, jedna
   ověřovací otázka, čekání na odpověď; chybná odpověď vede k jinému podání
   téhož kroku. Pravidlo se nepřenáší na přímý dotaz, sokratovské vedení,
   procvičování ani zkoušení. Jednorázová žádost platí pro jednu odpověď,
   trvalejší volba do odvolání.
4. **Obrázky:** obrázek učebnice je výchozí součástí kroku a cílem je obrázek
   přímo v textu odpovědi: přibalený soubor, jinak překreslení z dat, jinak
   soubor či popis s adresou. Hodnoty se neodhadují z popisu.
5. **PNG místo SVG** v balíčcích tutora; web zůstává u SVG.
6. **Data ke grafům** zapisuje skript kapitoly a přibalují se v rejstříku
   obrázků kapitoly. Pilot ve vydání 0.4.0 je kapitola 10; ostatní kapitoly
   mají následovat po ověření v klientech (zamýšleno pro 0.4.1), což je
   dohodnutý směr, nikoli hotový stav.
7. **Interaktivní stránky učebnice** tutor nabízí jednou větou s úplnou
   adresou u oddílu, u něhož je plán uvádí; výklad na nich nestojí.
   Adresy opisuje doslova jako prostý text.
8. **Gemini:** archiv jen se soubory `.md` a `.txt` a se `SKILL.md` v kořeni.
9. **Podmínky vydání** pro každou platformu zvlášť.

Hlavní místa: [instrukce tutora](../../plugins/statistika-pro-psychology-ai-tutor/skills/statistika-tutor/SKILL.md)
a jejich reference (body 3, 4 a 7), [AITUTORS.md](../AITUTORS.md) (body 5, 6, 8
a [podmínky vydání](../AITUTORS.md#podminky-vydani)),
[provozní návod](../PROVOZ.md#export-ai-tutora) (postupy). Schválení nedokládá
dokončení vydání ani účinnost instrukcí v klientech; výsledky testů patří do
autorské historie.

<a id="r85-doplneni-2026-11-21"></a>

**Doplnění 2026-11-21 (po testu kandidáta 0.4.0):** autor sdělil, že archiv
přijaly všechny tři klienty a že „všechno je v pořádku“, a dodal: „ChatGPT
nedokáže přečíst png, takže jsou u něj zbytečné; využívá hlavně
references/kapitoly/kapitola_10.md, references/obrazky/kapitola_10.md nebo
CSV. Takže teď bych asi png soubory u ChatGPT odstranil a doplnil postup C.
Přibalit data a popis grafu i pro ostatní kapitoly.“ V dotazníku zvolil vydání
změn „až 0.4.1“ a „ponechat [PNG] v Claude“; k plánu připsal: „Pro ChatGPT bych
místo PNG použil SVG, ty by měl model být schopen přečíst.“ Plán schválil.

- Bod 5 se mění: formát obrázků se řídí platformou – **ChatGPT původní SVG,
  Claude PNG, Gemini bez souborů obrázků**. Web zůstává u SVG.
- Bod 6 se naplňuje: data ke grafům mají od 0.4.1 všechny přibalené kapitoly;
  zápis dat byl rozšířen o intervaly, úsečky, krabicový graf, plochy,
  kategorie, skupiny sloupců a tabulky. Schémata bez dat se nepřekreslují.
- Verze 0.4.0 zůstává v otestované podobě; změny vycházejí jako 0.4.1
  s vlastním testem v klientech.

<a id="r85-doplneni-2026-11-21b"></a>

**Druhé doplnění 2026-11-21 (po prvním testu kandidáta 0.4.1):** autor poslal
snímky a sdělil: „gemini odkazy spíš matou“ a „ChatGPT je také neumí vkládat
do chatu“. Na otázku, zda z balíčku pro ChatGPT odstranit soubory SVG,
odpověděl: „Odstranit SVG“.

- Bod 5 se mění podruhé: **Claude PNG, ChatGPT a Gemini bez souborů
  obrázků**. V obou variantách bez souborů tutor obrázek s daty překresluje
  a schéma popisuje s adresou stránky učebnice.
- Adresu samotného obrázku varianty bez souborů neuvádějí; adresa stránky se
  uvádí jednou, celá a v běžné větě.
