# Pracovní postupy a autorská dokumentace

[Registr rozhodnutí a aktuální platnost](../ROZHODNUTI.md) · [Pravidla evidence](../../AGENTS.md#evidence-rozhodnuti)

Níže jsou zachovány původní záznamy schválených voleb, jejich důvody a doklady. Data, rozsah a formulace se vztahují k uvedeným dohodám; záznamy mohou obsahovat později nahrazené části nebo již provedené úkoly. Aktuální platnost a hlavní místo údržby určuje řádek v registru. Staré seznamy se při běžné aktualizaci slovníku, obsahu či pracovního postupu znovu nesynchronizují; nová schválená změna dostane vlastní datovaný doklad.

<a id="r11-pracovni-vetve"></a>

## R11 — Jedna aktivní větev na kapitolu

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r11-pracovni-vetve). Původní záznam dohody:*

**Stav:** schváleno. **Rozsah:** celý repozitář a budoucí práce s Gitem.

Používáme nejvýše jednu aktivní větev `codex/chapter-NN` pro každou
kapitolu a `codex/other` pro společné změny. Související aktualizace
přehledů patří ke kapitole. Dílčí úpravy rozlišují commity a PR.
Po sloučení a ověření zachování změn se pracovní větev odstraní;
při další práci se stejný název znovu založí z aktuálního `origin/main`.
Úplná pravidla bezpečného úklidu stanoví [AGENTS.md](../../AGENTS.md#git-a-dokončení-práce).

**Důvod:** přehledný seznam aktivní práce bez hromadění větví pro každou
redakční úpravu. Nahrazuje dosavadní pravidlo nových tematických názvů
po každém sloučení a samostatných tematických větví pro infrastrukturu.

**Doklad:** uživatelův návrh jedné větve na kapitolu a větve „other“
a výslovné zadání ze dne 2026-10-11 upravit instrukce a uklidit staré
větve po prověření výjimek; podrobnosti v autorském záznamu níže
v [historii](../../quarto/README.md).

<a id="r12-nazorne-vizualizace"></a>

## R12 — Názorné vizualizace ve výkladu

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r12-nazorne-vizualizace). Původní záznam dohody:*

**Stav:** schváleno. **Rozsah:** výkladové kapitoly učebnice.

Diagramy, schémata a grafy zařazujeme tam, kde pomáhají pochopit pojem,
vztah mezi pojmy nebo princip postupu. Vždy je propojujeme s výkladem;
jejich počet se řídí didaktickým přínosem. Podrobné pravidlo je v
[AGENTS.md](../../AGENTS.md#didaktika-a-jazyk).

**Důvod:** podpořit konceptuální porozumění názorným zobrazením.
**Doklad:** výslovné zadání autora ze dne 2026-10-11 doplnit toto pravidlo
s příkladem schématu výběru z populace a přidělení do podmínek v kapitole 1.

**Uplatnění v kapitolách 2–4 (2026-10-11):** autor schválil všech jedenáct
návrhů z následného posouzení: devět nových diagramů a rozšíření histogramů
o posun mezí a přehledu standardních škál o modelové percentilové pořadí.
Nejde o rozšíření terminologie ani změnu početních konvencí. Dokladem je
pokyn „Doplň všechny navržené vizualizace (prioritní i neprioritní)“;
provedení a kontroly zaznamenává [autorská historie](../../quarto/README.md).

<a id="r16-cile-kapitoly-odrazky"></a>

## R16 — Cíle kapitoly jako seznam s odrážkami

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r16-cile-kapitoly-odrazky). Původní záznam dohody:*

**Stav:** schváleno 2026-10-11. **Rozsah:** úvodní blok „Co budete po
prostudování umět“ ve všech výkladových kapitolách.

Cíle na začátku kapitoly formátujeme jako seznam s odrážkami, nikoli jako
souvislý odstavec. Doplňující poznámka patří pod seznam. Pravidlo je v
[AGENTS.md](../../AGENTS.md#příprava-každé-kapitoly). Záznam je zařazen zde,
mimo číselné pořadí, aby se souběžně připravované záznamy na konci
dokumentu nepřekrývaly.

**Důvod:** přehlednost. **Doklad:** pokyn autora ze dne 2026-10-11:
„do AGENTS.md bych přidal instrukci, že odstavec s cíli na začátku kapitoly
by měl být formátován jako seznam s odrážkami“. Kapitoly 1 a 2 pravidlo
splňovaly, kapitoly 3 a 4 byly upraveny ve svých větvích.

<a id="r17-mapa-ucebnice"></a>

## R17 — Mapa skutečného obsahu a oddělený plán pokračování

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r17-mapa-ucebnice). Původní záznam dohody:*

**Stav:** schváleno 2026-10-11. **Rozsah:** autorská dokumentace celé knihy
a údržba při obsahových změnách.

**Uspořádání souborů aktualizováno 2026-10-13 podle [R32](#r32-propojene-mapy):**
podrobné karty jsou v `kapitoly/`, společný rozcestník zůstává v OSNOVA.md.
Níže je zachován původní záznam; obsahové a evidenční požadavky nadále platí.

[OSNOVA.md](../OSNOVA.md) se rozšiřuje na podrobnou mapu existujících kapitol
s tematickým rozcestníkem. Karty zachycují skutečný výklad, příklady,
vizualizace, soubory, pokrytí cvičeními, vstupní znalosti a hranice učiva.
Rozlišují vysvětlení, samostatné procvičení, pouhou zmínku a nepovinné části.
Plán další kapitoly zůstává oddělený s rozlišením schváleného a otevřeného.
Pravidlo průběžné aktualizace je v úvodu [AGENTS.md](../../AGENTS.md).

**Důvod:** umožnit spolehlivé plánování návazností a kontrolu opakování,
aniž by se podrobný obsah udržoval ve dvou konkurenčních dokumentech.
Mapa nenahrazuje kapitoly, slovníček, značení ani zdrojové karty.

**Nahrazuje:** dosavadní stručnou osnovu kapitol 1–3 a plánovací popis
již vytvořené kapitoly 4. Nemění jejich schválený rozsah ani terminologii;
neschvaluje podrobný obsah kapitoly 5. Historické doklady dohod zůstávají.

**Doklad:** výslovný pokyn autora „rozšiř tedy docs/OSNOVA.md podle tohoto
návrhu“, „Podrobně zmapuj aktuální obsah všech čtyř kapitol a odděl jej od
plánu další kapitoly“ a „Doplň také do instrukcí pravidlo průběžné
aktualizace mapy“.

<a id="r18-autorsky-slovnik"></a>

## R18 — Autorský registr terminologie

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r18-autorsky-slovnik). Původní záznam dohody:*

**Stav:** schváleno 2026-10-11. **Rozsah:** učebnice a související materiály,
autorská dokumentace a další terminologické změny.

[SLOVNIK.md](../SLOVNIK.md) je hlavní autorský přehled preferovaných českých
termínů, anglických ekvivalentů, rozpoznávaných alternativ a významových
hranic. Studentský slovníček poskytuje definice a odkazy na první výklad;
tento dokument uchovává důvody a doklady dohod. Registr rozlišuje konkrétní
schválení od převzetí staršího dohodnutého celku a návrhy drží odděleně.
Samotný výskyt termínu není schválením. Při změně se společně aktualizují
registr, studentský slovníček a všechna dotčená místa podle
[AGENTS.md](../../AGENTS.md#terminologie-a-značení).

**Důvod:** umožnit jednotné používání názvů bez záměny souvisejících pojmů
a bez konkurenčních seznamů platných preferencí. Úplné definice se nekopírují
do autorského registru; historie schvalování se nenahrazuje slovníčkem.

**Doklad:** autor přijal návrh rozdělení rolí registru, studentského slovníčku
a rozhodnutí a zadal: „Vytvoř docs/SLOVNIK.md podle tohoto návrhu, naplň ho
dosud schválenou terminologií a uprav související dokumentaci a AGENTS.md,
aby bylo jasné, jak ho používat a udržovat.“ Tento souhlas nemění jednotlivé
statistické konvence a neschvaluje nové pojmy budoucích kapitol.

<a id="r19-sjednoceni-terminologie"></a>

## R19 — Sjednocení terminologie kapitol 1–4

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r19-sjednoceni-terminologie). Původní záznam dohody:*

**Stav:** schváleno 2026-10-11. **Rozsah:** čtyři kapitoly, studentský
slovníček a související popisky grafů.

Používat preference registru SLOVNIK.md také v navazujícím výkladu,
cvičeních, řešeních a popiscích. Autor výslovně potvrdil preferenci
„pravděpodobnostní výběr“ před „náhodný výběr“ a „kauzální závěr“ před
„příčinný závěr“. Zachovat prostý náhodný výběr, běžný popis náhodného
výběru jednoho případu, normativní soubor, orientační uvedení alternativ
a anglické ukázky reportování. Meze intervalů odlišovat od obecných hranic.

Ve slovníčku výslovně odlišit širší označení quantile–quantile plot
a rozdělení dat; platný údaj zde znamená nechybějící, nikoli ověřeně správný.

**Důvod:** odstranit střídání pojmenování a zpřesnit významové hranice
bez změny rozsahu učiva, výpočtů či předpokladů statistických tvrzení.

**Doklad:** autor po předložení auditu zadal „proveď navržené opravy
včetně zpřesnění slovníčku a souvisejících popisků“, výslovně potvrdil
obě preference a požadoval zachování uvedených výjimek.


<a id="r20-data-v-excelu"></a>

## R20 — Jeden studentský excelový sešit ke kapitole

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r20-data-v-excelu). Původní záznam dohody:*

**Stav:** schváleno 2026-10-11. **Rozsah:** kapitoly 1–4 i další kapitoly.

Všechna data k příkladům a cvičením zpřístupňovat v jediném sešitu,
rozdělená podle úloh do listů, s úvodním přehledem, popisy a přesnými
oblastmi buněk. Vstupy oddělit od hotových výpočtů; nesestavovat fiktivní
individuální data ze souhrnů. CSV zůstává případně interním vstupem,
ne studentským souborem ke stažení. Pravidlo rozšiřuje R14 na celou knihu.

**Důvod:** studenti mají pracovat se statistickým obsahem bez požadavku
na zvládnutí importu CSV; souběžné formáty zbytečně komplikují orientaci.

**Doklad:** autor přijal návrh a zadal: „Ano, sjednoť to takto ve všech
dosavadních kapitolách. Ověř, že sešity obsahují všechna data k příkladům
i cvičením, uprav odkazy a zapiš toto pravidlo i pro další kapitoly do AGENTS.md.“

## R24 — Tvorba sešitů v desktopovém Excelu

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r24--tvorba-sešitů-v-desktopovém-excelu). Původní záznam dohody:*

**Stav:** schváleno 2026-10-12. **Rozsah:** všechny studentské sešity
a jejich generátory; nemění obsah kapitol ani pravidla pro prezentace.

Sešity sestavovat reprodukovatelnými skripty ovládajícími desktopový Excel
pro Windows. Odstranit povinnou závislost na `@oai/artifact-tool` a runtime
konkrétního poskytovatele LLM. Zachovat data, význam a adresy buněk,
vzorce, nativní grafy i ověřování výsledků nezávislými výpočty.
Toto rozhodnutí nahrazuje dřívější technický postup obnovy sešitů
pomocí uvedené knihovny; historické záznamy o něm zůstávají zachovány.

**Důvod:** spolupráce více LLM nad jedním repozitářem; autor má lokálně
k dispozici Excel. Přístup ke skutečnému Excelu zajišťuje přepočet
a ověření chování v cílové aplikaci.

**Doklad:** pokyn autora: „Převeď tedy tvorbu všech sešitů na skripty
ovládající desktopový Excel, odstraň závislost na artifact-tool a uprav
příslušné instrukce. Zachovej obsah i funkčnost sešitů a ověř je.“
Provozní postup je v [provozním návodu](../PROVOZ.md#obnova-sešitů-a-podkladů-kapitol-16),
pravidla v [AGENTS.md](../../AGENTS.md#data-ke-kapitolám).

<a id="r31-pracovni-pdf"></a>

## R31 — Ručně vyžádané pracovní PDF kapitoly

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r31-pracovni-pdf). Původní záznam dohody:*

**Stav:** schváleno. **Rozsah:** sekundární pracovní PDF; první ověřenou
kapitolou je kapitola 3. Hlavním výstupem zůstává HTML.

PDF se sestavuje pouze na výslovné vyžádání, bez automatického spouštění
s webem a bez automatické publikace. Zahrnuje vybranou kapitolu; závěrečný
slovníček, značení a přehled Excelu se zatím vynechávají. Všechna zadání
cvičení předcházejí samostatnému oddílu řešení. Obsah se udržuje ve společném
zdroji kapitoly; přesun řešení probíhá při exportu. Propojení zadání a řešení
zachovává čísla cvičení. Web nadále používá sbalené řešení pod zadáním.

**Důvod:** umožnit čtení a tisk jednotlivé kapitoly bez nároků na finální
knižní sazbu a bez prodlužování běžného sestavení webu.

**Doklad:** zadání autora 2026-10-13: „Nechtěl bych, ať se render do pdf
spouští automaticky, ale pouze tehdy, když si o něj výslovně řeknu“,
„Závěrečné přehledy bych zatím vynechal“ a „Řešení cvičení by byly posunuty
do samostatné části umístěné za zadání cvičení“. Následná volba „Kapitolu 3“.
Postup a závislosti jsou v [provozním návodu](../PROVOZ.md#ruční-pdf-vybrané-kapitoly).

<a id="r32-propojene-mapy"></a>

## R32 — Propojené karty obsahu a zdrojů

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r32-propojene-mapy). Původní záznam dohody:*

**Stav:** schváleno 2026-10-13. **Rozsah:** organizace a údržba autorské
dokumentace celé knihy.

[OSNOVA.md](../OSNOVA.md) zachovává celkovou strukturu a tematické návaznosti;
podrobné karty jednotlivých kapitol a samostatný plán pokračování jsou
v `kapitoly/`. [ZDROJE.md](../ZDROJE.md) zachovává inventář a tematický
rozcestník; každý zdroj má jednu kartu v `zdroje/`. Kapitolové karty
odkazují na relevantní zdrojové karty, které obsahují zpětné odkazy.
Společné nálezy a datované souhrny kontrol více podkladů zůstávají pohromadě
v [historii ověřování](../zdroje/HISTORIE.md). Tematická vazba neznamená
skutečné použití, schválení obsahu ani nové prostudování zdroje.

Přesun zachovává veškerý obsah, stabilní ID a historii ověření. Příchozí
odkazy míří přímo na nové umístění; původní adresy obsahují kotvy s odkazy
na příslušné karty. Datum reorganizace nemění data obsahových kontrol.
Při práci se načítá rozcestník a vybrané karty, nikoli automaticky celá
složka. Podrobnosti se udržují v jediném příslušném souboru.

**Důvod:** snížit množství současně načítané dokumentace a usnadnit
dohledání návazností bez duplikování zdrojové evidence mezi kapitolami.

**Nahrazuje:** fyzické uložení podrobných karet v jediném souboru podle
[R17](#r17-mapa-ucebnice); jeho požadavky na obsah mapy a oddělení plánu
nadále platí. Původní rozhodnutí a záznamy zůstávají zachovány.

**Doklad:** výslovný pokyn autora z 2026-10-13: „proveď navržené rozdělení
zdrojů a osnovy do propojených Markdownových souborů. Zachovej veškerý
obsah, stabilní ID a historii ověření, aktualizuj odkazy i AGENTS.md
a zkontroluj, že se nic neztratilo.“

### Doplnění R32 — registr rozhodnutí a jedno hlavní místo informace (2026-10-13)

**Schválená volba:** stručný registr odkazuje na úplné doklady podle kapitol a společných témat. Hlavní místa jednotlivých typů informací a pravidla nových zápisů určuje [AGENTS.md](../../AGENTS.md#evidence-rozhodnuti).

**Důvod:** omezit souběžně udržované kopie pravidel a oddělit aktuální stav od historického schválení a provedení.

**Doklad:** autor dne 2026-10-13 přijal návrh a zadal: „zkrať ROZHODNUTI.md na registr, podrobné záznamy rozděl podle témat a kapitol, zachovej ID i historii a uprav AGENTS.md tak, aby se informace dál neduplikovaly. Aktualizuj odkazy a ověř, že se nic neztratilo.“ Původní text R32 výše je zachován.

### Doplnění R32 — odstranění původních kotev osnovy (2026-10-14)

**Schválené upřesnění:** v `docs/OSNOVA.md` se ruší sekce „Přesměrování
původních odkazů“ včetně jejích kotev. Požadavek zachování původních adres
se na tyto kotvy již nevztahuje; ostatní části R32 zůstávají platné.
Aktuální odkazy na samostatné karty musí zůstat funkční. Výjimku vymezují
[projektové instrukce](../../AGENTS.md#použití-projektové-dokumentace).

**Důvod:** autor staré odkazy nepoužívá a jejich zachování nepožaduje.

**Doklad:** výslovný pokyn autora z 2026-10-14: „Tak tu sekci smaž, staré
kotvy zachovávat nepotřebuji. Ověř, že aktuální odkazy zůstanou funkční.“
Původní doklad reorganizace výše zůstává zachován.

### Doplnění R32 — odstranění archivu obecných pokynů registru (2026-10-14)

**Schválené upřesnění:** ruší se sekce „Historické pokyny“ v `ROZHODNUTI.md`
včetně jejích kotev a soubor `historie-registru.md`. Výjimka z požadavku
zachovat celý text při reorganizaci se týká pouze původních obecných
pokynů k evidenci; doklady jednotlivých rozhodnutí zůstávají zachované.
Aktuální pravidla evidence jsou v [AGENTS.md](../../AGENTS.md#evidence-rozhodnuti),
původní znění odstraněných pokynů zůstává dohledatelné v Gitu.

**Důvod:** archiv již nemá samostatnou funkci pro tvorbu knihy; platná
pravidla mají jedno hlavní místo v projektových instrukcích.

**Doklad:** autor dne 2026-10-14 zadal: „Ano, smaž sekci Historické pokyny
i soubor historie-registru.md, uprav související odkazy a evidenci a ověř,
že aktuální odkazy zůstanou funkční. Změny odešli na GitHub a připrav PR.“

### Doplnění R32 — stručné README a samostatný provozní návod (2026-10-14)

**Schválené upřesnění:** kořenové README slouží jako vstupní rozcestník
s představením knihy, rychlým spuštěním a odkazy na dokumentaci. Hlavním
místem provozních příkazů, závislostí a technických postupů je
[PROVOZ.md](../PROVOZ.md). Podrobný obsah kapitol a pokrytí daty nadále
spravují osnova a přehled dat; pravidla tvorby a evidence zůstávají
v [AGENTS.md](../../AGENTS.md#evidence-rozhodnuti).

**Důvod:** zlepšit orientaci ve vstupním dokumentu a zachovat podrobné
návody na jednom místě bez opakování autorských pravidel.

**Doklad:** výslovný pokyn autora z 2026-10-14: „Ano, zkrať README.md
podle návrhu a provozní návody přesuň do docs/PROVOZ.md. Zachovej důležité
informace, aktualizuj AGENTS.md, odkazy a evidenci, ověř funkčnost odkazů
a změny odešli na GitHub s PR.“ Toto doplnění mění hlavní místo údržby
provozních návodů; původní doklady předchozího uspořádání zůstávají zachované.

<a id="r33-excelova-cviceni-prezentaci"></a>

## R33 — Excelová cvičení k prezentacím

**Stav:** schváleno 2026-10-13. **Rozsah:** závěrečná početní cvičení
vyžadující práci v Excelu u prezentací.

**Volba a důvod:** autor požaduje přesun těchto cvičení z prezentace
na místo jejich řešení: do samostatného sešitu se zadáním, vstupními daty
a řešením. Úkoly sdílející dataset mají být na stejném listu, různé
datasety na samostatných listech. Aktuální prováděcí pravidla jsou
v [PREZENTACE.md](../PREZENTACE.md#excelova-cviceni).

**Nahrazuje:** pro uvedený typ úloh dosavadní obecný požadavek v
`PREZENTACE.md` „Samostatné úlohy zařazuj na konec prezentace“ a umístění
jejich řešení do poznámek. Ostatní úlohy mohou zůstat v prezentaci.
[R20](#r20-data-v-excelu) o datových sešitech kapitol učebnice se nemění.

**Doklad:** zadání autora z 2026-10-13: „Chtěl bych cvičení na konci,
pokud jsou početní a vyžadují práci v excelu, nevkládat do samotné
prezentace ale, na samostatný excelovský sešit i se zadáním, vstupními
daty a řešením.“ Dále: „Pokud by se více úkolů týkalo stejného datasetu,
dal bych vše na tentýž sheet, v opačném případě na samostatné sheety.“

**Upřesnění 2026-10-13 (členění listů a podoba řešení):** při úpravě
sešitu k prezentaci kapitoly 3 autor zpřesnil pravidlo o společném listu:
„úkoly ke stejnému datasetu patří obvykle na tentýž list, pokud je jich
málo a nevyžadují rozsáhlejší výpočty; ale pokud ji je více nebo vyžadují
rozsáhlejší výpočty, a jejich umístění na stejný list by tudíž nebylo
přehledné, je určitě vhodnější je rozdělit na samostatné listy se stejnými
vstupními daty.“ Současně požádal, aby řešení ukazovalo jednotlivé kroky
výpočtu: „Řešení každé úlohy bych chtěl rozebrat i podrobněji, jen
s využitím základních aritmetických operací (+, -, *, /, suma, průměr
apod.), a použitím speciální funkce (např. var.s) pouze jako kontrolou“,
aby studenti „skutečně viděli všechny kroky výpočtu a pochopili jeho
princip“. Požadavek na řešení po krocích zazněl k uvedenému sešitu; jeho
zobecnění na další doprovodné sešity schválil autor s plánem úpravy téhož
dne. Původní znění výše zůstává dokladem první dohody; aktuální pravidla
jsou v [PREZENTACE.md](../PREZENTACE.md#excelova-cviceni).

**Upřesnění 2026-10-14 (obecné rovnice u úloh):** autor požádal: „Pro
ještě větší didaktickou přehlednost bych do toho Excelu se cvičeními vložil
ke každé úloze relevantní rovnice (v obecné formě), které je nutné znát
k výpočtu výsledku.“ Na doplňující dotazy zvolil podobu nativních rovnic
Excelu (nikoli text v buňkách) a potvrdil, že má jít o pravidlo i pro další
doprovodné sešity. Rovnice používají značení učebnice podle
[R01](spolecne-konvence.md#r01-znaceni-a-reportovani); upřesnění samo
nezavádí žádný nový symbol do přehledu značení.

<a id="r34-intuitivni-vysvetleni"></a>

## R34 — Prostředky intuitivního vysvětlení

**Stav:** schváleno 2026-10-13. **Rozsah:** didaktická pravidla knihy
a souvisejících materiálů.

**Volba:** intuitivní vysvětlení může využívat analogie, přirovnání nebo
metafory, pokud pomáhají pochopit podstatu pojmu či vztahu. Pravidlo je
zapracováno do [didaktiky](../../AGENTS.md#didaktika-a-jazyk); navazující
požadavek přesného uvažování a vysvětlení mezí analogie zůstává v platnosti.

**Důvod:** konkretizovat dostupné prostředky intuitivního vysvětlení.
**Doklad:** autor navrhl doplnění analogií, přirovnání a metafor a následně
přijal předložené znění slovy „Ok, souhlasím.“

<a id="r35-nekapitolove-vetve"></a>

## R35 — Nekapitolové větve podle typu práce

**Stav:** schválený směr 2026-10-13; konkrétní názvy a vymezení kategorií
jsou prováděcí volbou tohoto úkolu. **Rozsah:** práce s Gitem v repozitáři.

**Volba:** nahradit jedinou obecnou nekapitolovou větev větvemi podle typu
změny. Zachovat nejvýše jednu aktivní větev na kapitolu a používat nejvýše
jednu aktivní větev pro každý typ nekapitolové práce. Aktuální názvy,
hranice kategorií a zacházení se souvisejícími změnami určuje
[AGENTS.md](../../AGENTS.md#git-a-dokončení-práce).

**Důvod:** název `codex/other` nerozlišuje instrukce, prezentace a další
odlišné druhy práce; členění má zpřehlednit aktivní větve a rozsah PR.

**Nahrazuje:** pouze požadavek jediné větve `codex/other` v
[R11](#r11-pracovni-vetve). Pravidla kapitolových větví, zachování změn
a bezpečného úklidu po sloučení se nemění. Původní doklad R11 je zachován.

**Doklad:** autor dne 2026-10-13 uvedl: „přidal bych více
"nekapitolových" větví podle různých typů změny, např. instrukce,
prezentace apod.“ Prováděcí rozdělení používá kategorie instrukce
a autorská dokumentace, prezentace, infrastruktura a obsahové změny
napříč kapitolami; nejde o doslovný seznam názvů zadaný autorem.

<a id="r38-citelnost-textu"></a>

## R38 — Pravidla čitelnosti studentského textu

**Stav:** schváleno 2026-10-15. **Rozsah:** studentský text knihy;
úprava existujících kapitol proběhne v samostatných PR.

**Volba:** úvod hlavního oddílu uvádí jeho otázku a návaznost; nadpisy
jsou obsahové. Výkladová kapitola končí oddílem „Shrnutí“ s 5–8 myšlenkami
a odkazy na výklad. Odstavec má hlavní myšlenku v první větě, dlouhé věty
(orientačně nad 35 slov) se dělí, preferuje se slovesný styl a nový pojem
je při zavedení tučně. Pododdíl zavádí nejvýše dva až tři nové pojmy,
povinná část kapitoly má orientačně do 12 000 slov. Bloky: dosavadní podoba
nepovinného rozšíření (`.callout-note collapse="true"`, ID `#rozsireni-…`),
nově „Častý omyl“ (`.callout-warning`) a „Připomenutí“ (`.callout-tip`).
Popisky obrázků a tabulek sdělují hlavní zjištění. Didaktická revize
zahrnuje čtení očima začátečníka. Číselné hodnoty jsou orientační vodítka.
Aktuální znění je v [AGENTS.md](../../AGENTS.md#čitelnost-a-struktura-textu).

**Důvod:** kapitoly se prodlužují (kap. 6 přes 20 000 slov), závěrečné
shrnutí mají jen kapitoly 1 a 2 a typy bloků nejsou vizuálně odlišeny.
Pravidla mají zlepšit orientaci v textu a čitelnost vět a odstavců.

**Doklad:** na dotaz autora „Napadá tě ještě způsob, jak vylepšit
instrukce, aby učebnice byla čitelnější a srozumitelnější?“ byla
předložena čtyři skupiny pravidel; autor 2026-10-15 vybral všechny
(„Shrnutí + orientace, Jazyková čitelnost, Zátěž a typy bloků, Revize
očima studenta“), zvolil rozsah „Jen instrukce“ a schválil plán
s konkrétními třídami bloků a orientačními prahy.
