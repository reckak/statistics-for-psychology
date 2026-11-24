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

<a id="r33-doplneni-2026-11-24"></a>

**Upřesnění 2026-11-24 (pracovní oblast po malých krocích):** při úpravě
sešitu k prezentaci kapitoly 9 autor požádal: „bych u některých úloh více
rozdělil ty pracovní oblasti, např. aby nejprve studenti vypočetli
směrodatné chyby podílů, pak směrodatné chyby rozdílu podílů atd., aby byl
každý ‚krok‘ výpočtu co nejmenší, a tedy méně náchylný na chybu výpočtu.
Zavedl bych pak pravidlo do instrukcí.“ Podobu schválil s plánem úpravy
téhož dne: žluté řádky pracovní oblasti kopírují kroky řešení (číslo,
popisek, řádek), výpočty po kategoriích či buňkách mají prázdné žluté
tabulky stejného tvaru a hotové pomocné tabulky stojí v bloku řešení
(volba autora z nabídnutých možností: „Žluté tabulky, řešení dál“).
Současná volba Waldova intervalu místo Wilsonova a Newcombova v tomto
sešitu je realizací pro jednu úlohu, nikoli obecnou konvencí; popisuje ji
[historie práce](../../quarto/README.md#sesit-kapitoly-9-kroky). Aktuální
pravidlo je v [PREZENTACE.md](../PREZENTACE.md#excelova-cviceni).

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

**Upřesnění 2026-11-01 (podoba Shrnutí):** kapitoly 1 a 2 si ponechaly
starší shrnutí v souvislých odstavcích bez odkazů, zatímco kapitoly 3–7
používají úvodní větu „Hlavní myšlenky kapitoly s odkazy na jejich výklad:“
a odrážky zakončené odkazem na oddíl. Tato podoba se stává závaznou pro
všechny výkladové kapitoly; kapitoly 1 a 2 jsou upraveny. Aktuální znění
je v [AGENTS.md](../../AGENTS.md#čitelnost-a-struktura-textu). Doklad:
autor 2026-11-01: „všiml jsem si, že Shrnutí na konci kapitoly je
v kapitolách 1 a 2 jiné než ve zbývajících, má jinou strukturu. Je možné
to sladit a nastavit pro konzistenci správné instrukce?“ a schválení plánu.

<a id="r50-struktura-prezentaci"></a>

## R50 — Přehled obsahu, oddělovací slidy a nadpisy v poznámkách

**Stav:** schváleno 2026-10-20. **Rozsah:** nové prezentace, jejich další
úpravy a exporty poznámek do DOCX. Existující prezentace se zpětně
nepřepracovávají bez pokynu autora.

**Volba:** druhý slide prezentace je vždy krátký heslovitý přehled obsahu.
Tematicky odlišné oddíly oddělují slidy pouze s názvem oddílu podle jeho
tématu. Nadpis slidu v exportu poznámek obsahuje kromě čísla i titulek
slidu. Aktuální znění je v [PREZENTACE.md](../PREZENTACE.md#struktura-prezentace)
a v oddílu o exportu poznámek; přehled ani oddělovací slidy se nezapočítávají
do orientačního počtu obsahových slidů a nemají otázku k zamyšlení.

**Důvod:** zpřehlednit stavbu prezentace a usnadnit orientaci v poznámkách.
**Upřesňuje:** dosavadní tvar nadpisů exportu „Slide 1:“ v PREZENTACE.md;
[R33](#r33-excelova-cviceni-prezentaci) se nemění.

**Doklad:** zadání autora z 2026-10-20: „Chtěl bych, ať druhý slide
prezentace vždy ukázal krátký heslovitý přehled obsahu/témat prezentace.“
„Pokud má prezentace více tematicky odlišných oddílů, chtěl bych, ať je
oddělují slidy, kde bude jen název oddílu podle jeho tématu, aby prezentace
byla přehlednější.“ „V poznámkách k prezentaci bych chtěl uvádět nejen
číslo slidu, ale i nadpis slidu.“ Autor schválil plán úpravy téhož dne.

<a id="r51-licence"></a>

## R51 — Licence: CC BY 4.0 pro obsah, MIT pro kód

**Stav:** schváleno 2026-10-25. **Rozsah:** celý veřejný repozitář a web.
Nahrazuje dosavadní licenci MIT pro celý repozitář (soubor `LICENSE`
z počátku projektu), která byla určena pro software.

**Volba:** text učebnice, vlastní obrázky a grafy, datové sešity,
prezentace, poznámky, cvičení, bibliografické údaje a autorská dokumentace
jsou pod licencí CC BY 4.0; zdrojový kód, konfigurace, styly a skripty
webu pod licencí MIT. Uspořádání souborů podle vzoru R101-textbook:
`LICENSE` obsahuje text MIT, `LICENSE-TEXT.md` český text licence obsahu
s odkazy na české i anglické závazné znění CC BY 4.0. Materiály třetích
stran si ponechávají svou licenci a autorství. Aktuální vymezení částí
a seznam výjimek udržuje [LICENSE-TEXT.md](../../LICENSE-TEXT.md); README
a patička webu na licence jen odkazují.

**Důvod:** MIT je licence pro software; pro text učebnice je obvyklá
licence Creative Commons, v kombinaci s MIT pro kód.

**Důsledek pro další práci:** převzaté obrázky, data či jiný materiál
zařazuj jen s licencí slučitelnou se zveřejněním a s uvedením autora,
zdroje a licence u materiálu; novou výjimku doplň do seznamu
v LICENSE-TEXT.md.

**Doklad:** zadání autora z 2026-10-25: „MIT je licence na software.
Na text učebnic se častěji používá Creative Commons, například CC BY 4.0,
obvykle v kombinaci s MIT pro kód. Můžeš licence takto upravit?“
Téhož dne k uspořádání souborů: „Myslím, že soubor LICENCE by mohl vypadat
více jako u R101 s odkazy na české i anglické znění“ (odkaz na licenci
repozitáře reckak/R101-textbook). Autor schválil plán úpravy téhož dne.

<a id="r53-doprovodne-audio"></a>

## R53 — Scénáře a doprovodné audio pouze na vyžádání

**Stav:** schváleno 2026-10-27. **Rozsah:** příprava a úpravy scénářů
pro syntézu řeči a doprovodných nahrávek k prezentacím.

**Volba:** AGENTS.md obsahuje pravidlo výslovného vyžádání a odkaz;
podrobný postup se udržuje v [TEXT2SPEECH.md](../TEXT2SPEECH.md).
Nahrávka doprovází snímky a nahrazuje výklad. Před placeným převodem
se dokončí a zkontroluje scénář v mluveném zápisu se slovníkem
výslovnosti pro konkrétní hlas. Funkce Excelu se čtou stručně po částech,
výrazy tvořící celek se pro syntézu spojují spojovníky. Dílčí úseky
se před předáním spojí do jednoho MP3; opravuje se jen nezbytná část.

**Důvod:** omezit placené opakování, chybnou výslovnost a nežádoucí
pauzy; zachovat návaznost na prezentaci a jeden snadno použitelný výstup.
Pravopisné úpravy pro syntézu nemění odbornou terminologii učebnice.

**Doklad:** autor v této konverzaci požadoval čísla slovy, mluvené názvy
písmen, přípravu pro správnou nahrávku „na první dobrou“, ošetření chybného
změkčování slova „kvantily“, čtení NORM.S.DIST jako
„norm-tečka-es-tečka-dyst“ a zápis „kvé-kvé-graf“. Dne 2026-10-27 zadal:
„Můžeš tedy instrukce pro tvorbu zvukových nahrávek zapsat?“ a navrhl
stručný odkaz v AGENTS.md, podrobnosti v docs/TEXT2SPEECH.md a výslovně
vymezil, že nahrávky vznikají na vyžádání, nikoli automaticky při práci
na kapitole. Zápis „kvantyly“ byl navržen k ověření; autorův popis chyby
není dokladem úspěšného poslechu této opravy.

### Upřesnění 2026-10-28 — Závazné přepisy a proveditelná kontrola

Autor upřesnil, že cizí a odborné výrazy s tvrdě vyslovovanými skupinami
„di“, „ti“ a „ni“ mají být ve scénáři zapisovány jako „dy“, „ty“ a „ny“.
Přepis se uplatní také v příslušných tvarech slov. Měkce vyslovované
skupiny se nenahrazují. Výslovně požadovaný zápis „kvantyly“ je závazný,
nikoli jen kandidát čekající na poslechové potvrzení.

Nedostupná poslechová kontrola přestává být povinným krokem či podmínkou
použití přepisu a vytvoření nahrávky. Kontroluje se scénář a důslednost
přepisů, dále technické vlastnosti výsledku. Tyto kontroly nedokládají
správnou výslovnost zvuku. Aktuální pravidlo udržuje
[TEXT2SPEECH.md](../TEXT2SPEECH.md#slovník-výslovnosti); nahrazuje předchozí
podmínění použití přepisů jejich poslechovým ověřením. Původní záznam
z 2026-10-27 výše zůstává historickým dokladem tehdejšího zápisu.

**Doklad:** autor v návaznosti na nepoužití přepisu ve scénáři kapitoly 5
uvedl: „instrukce by podle mě měly rovnou uvádět, že cizí slova a odborné
výrazy, kde se vyskytují dvojice ‚di‘, ‚ti‘ a ‚ni‘, je potřeba zapisovat
jako ‚dy‘, ‚ty‘ a ‚ny‘, pokud se vyslovují s tvrdě.“ Dále požadoval odstranit
část o poslechovém ověření, pokud skutečný poslech nahrávky není možný.

<a id="r65-interaktivni-vizualizace"></a>

## R65 — Část „Interaktivní vizualizace“

**Stav:** schváleno 2026-11-05. **Rozsah:** webová učebnice; nová část knihy
a odkazy na ni z výkladových kapitol. Netýká se ruční PDF ani balíčku AI tutora,
kam se vizualizace nepřebírají.

**Volba:**

- Kniha má třetí část „Interaktivní vizualizace“, zařazenou v `_quarto.yml`
  mezi výkladové kapitoly a „Literaturu a přehledy“; tři přehledy zůstávají
  na konci.
- Část se člení **podle jednotlivých vizualizací, nikoli podle kapitol**
  (ke kapitole jich může být více). Každá vizualizace je samostatná
  nečíslovaná stránka `quarto/viz_<tema>.qmd` s obsahovým nadpisem
  a stabilním ID `#sec-viz-<tema>`; v menu má jednu položku, pořadí určuje
  první navazující kapitola.
- Stránka postupně uvádí, na jakou otázku odpovídá a ke kterým oddílům se váže,
  model a ovládání s textovým popisem grafu, samotnou vizualizaci, 2–4 úkoly
  „Vyzkoušejte si“, oddíl „Čeho si všimnout“ a odkazy zpět na výklad.
- Výklad kapitoly musí obstát bez vizualizace. Z kapitoly na ni vede krátký
  blok `.callout-tip` s titulkem „Vyzkoušejte si: …“; vizualizace se do kapitol
  nevkládají.
- Technika: Quarto OJS s Observable Plot a d3 ze standardní knihovny,
  bez serveru, bez zobrazeného kódu a bez Shinylive/webR. Terminologie
  a značení podle registru a přehledu značení; ovládání klávesnicí, mobil
  bez přetékání stránky, simulace ověřené nezávislým výpočtem.
- Pilotní vizualizace: výběrové rozdělení průměru ke kapitole 6 ve výukovém
  modelu kapitoly, s velikostí výběru zadávanou jako celé číslo 1–100
  v číselném poli se šipkami. Další vizualizace se schvalují samostatně;
  seznam námětů v [plánu pokračování](../kapitoly/plan-pokracovani.md#plan-vizualizace)
  není schválením.

**Důvod:** pojmy kapitol 6–8 se vykládají přes opakované výběry a změnu
parametrů; statický obrázek ukáže jen jeden výsledek, kdežto interaktivní
stránka nechá studenta pokus opakovat. Samostatná část zachovává samostatnou
srozumitelnost výkladu i PDF.

**Doklad:** autor 2026-11-05 navrhl: „Myslím, že učebnici by mohlo vylepšit,
kdyby kromě obsahovala kromě dvou hlavních částí (Výkladové a Literatura
a Přehledy) také sekci s interaktivními vizualizacemi pro názorné pochopení
a ilustraci vybraných statistických konceptů“. Na doporučení začít pilotem
odpověděl „Ano, připrav návrh“. K návrhu doplnil: „Nečlenil bych to na
kapitoly, protože k jedné kapitole může být více vizualizací; takže bych to
prostě členil podle jednotlivých vizualizací.“ a „Velikost výběru bych nechal
stanovit pomocí input boxu s celým číslem od 1 do 100 a případně šipkami.“
Upravený plán (umístění, členění, blok „Vyzkoušejte si“, technika, pravidla
a pilot) téhož dne schválil. Pilot je realizací tohoto rozhodnutí; jeho
ověření eviduje [autorská historie](../../quarto/README.md).

### Upřesnění 2026-11-05 — Podoba pilotní vizualizace

Po sloučení pilotu autor požadoval: odstranit tlačítko „Zkopírovat do
schránky“, zvětšit panely, otočit popisek osy y svisle na střed, zadávat
počet nových losů číslem 1–1000 jako velikost výběru, omezit celkový počet
opakování na 100 000 se zprávou po dosažení stropu, vyznačit u populace i σ,
doplnit nad body posledního výběru empirický odhad hustoty, nabídnout více
populací se stejnými μ a σ a různým zešikmením („od mírného (to už tam je),
po střední, až po extrémní“) a přidat poslední řádek se dvěma normálními
Q–Q grafy, pro poslední výběr a pro dosavadní průměry. Na doplňující otázky
zvolil popisné pojmenování odhadu hustoty bez nového termínu („Odhad hustoty
z výběru“, žádné heslo ve slovníčku) a čtyři populace včetně souměrné.
Upravený plán téhož dne schválil. Odhad hustoty tím není zaveden jako pojem
učebnice; jeho případné zavedení by vyžadovalo samostatnou dohodu.

<a id="r65-upresneni-2026-11-06"></a>

### Upřesnění 2026-11-06 — Vizualizace ploch pod normální křivkou

Druhá vizualizace podle R65, ke kapitole 4: stránka
`quarto/viz_normalni_rozdeleni.qmd` („Plochy pod normální křivkou“,
`#sec-viz-normalni-rozdeleni`), v menu před pilotem.

- Společné zadání μ a σ pro obě části, výchozí N(0, 1).
- Část „Od hranice k podílu“: podíl vlevo od hranice, vpravo od ní, mezi
  dvěma mezemi a mimo interval. Část „Od podílu k hranici“: dolní a horní
  část rozdělení a souměrně prostřední část a oba chvosty dohromady.
- Ve výsledcích a ovládání se plocha nazývá **podíl** jako v kapitole 4;
  jedna věta na stránce ji propojuje s pravděpodobností (kapitola 5).
  Podíl se zadává desetinným číslem mezi 0 a 1 bez krajních hodnot.
- Doplňky: druhá řada popisků osy v z-skórech s převodem hranic, vzorec
  českého Excelu s dosazenými hodnotami a pod hustotou graf distribuční funkce.

**Doklad:** autor 2026-11-06 zadal: „Jako další vizualizaci bych vytvořil
vizualizaci normálního rozdělení. Nechal bych uživatele vždy zadat mí a sigmu
(s defaultním 0 a 1). Pak mohl zadat, zda chci zjistit pravděpodobnost hodnot
nalevo/napravo/mezi/vně určitého skóru nebo skórů (v případě mezi a vně).
Inverzně by mohl v druhém grafu zadat pravděpodobnost hodnot nalevo nebo
napravo a souměrně mezi a vně, a ukázalo by mu to příslušné skóry.“
Na doplňující otázky zvolil termín „Podíl“, všechny tři doplňky („Osa
z-skórů a převod“, „Vzorec v Excelu“, „Distribuční funkce“), „Společné μ a σ“
a zadání podílu „Desetinné číslo 0–1“; plán téhož dne schválil. Realizaci
a ověření eviduje [autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-06-sila"></a>

### Upřesnění 2026-11-06 — Vizualizace statistické síly

Třetí vizualizace podle R65, ke kapitole 6: stránka
`quarto/viz_statisticka_sila.qmd` („Na čem závisí statistická síla“,
`#sec-viz-statisticka-sila`), v menu za vizualizací výběrového rozdělení
průměru.

- Model testu rozdílu dvou průměrů z kapitoly 6: stejně velké nezávislé
  skupiny, známá σ, směrodatná chyba rozdílu σ√(2/n). Grafy podle
  předlohy `presentations/kapitola_06_uloha_4_sila_grafy.pdf`: křivky H₀
  a H₁, kritické hodnoty, α šrafováním, β a síla barevně.
- Vstupy: skutečný rozdíl μ₁ − μ₂, *n* v každé skupině (celé číslo),
  hladina α jako desetinné číslo (0 < α ≤ 0,5) a směr testu. σ je jeden
  vstup společný pro obě situace, výchozí 15 s.
- Dvě souběžně nastavitelné situace A a B se společnými osami místo
  srovnání s pevným výchozím stavem nebo ukládání nastavení; navíc křivka
  síly a vzorce českého Excelu s dosazenými hodnotami.
- Směr testu bez nových termínů: „oboustranný“ a „jednostranný“ se zápisem
  alternativy; „levostranný/pravostranný test“ se nezavádí.

**Doklad:** autor 2026-11-06 zadal: „Jako další vizualizaci bych vytvořil
vizualizaci statistické síly. Nechal bych uživatele vždy zadat rozdíl mezi
populačními průměry, velikost výběrů (pro zjednodušení bych předpokládal
stejně velké skupiny), hladinu alfa a typ testu (oboustranný, levostranný,
pravostranný).“ a odkázal na uvedenou předlohu. Na doplňující otázky zvolil
σ jako vstup s výchozí hodnotou 15 s, pojmenování „Jednostranný + zápis H₁“
a zadání α „Desetinné číslo“; z doplňků vybral „Křivka síly“ a „Vzorec
v Excelu“ a místo srovnání s výchozím stavem či uložených nastavení
požadoval „možnost nastavit vstupní parametry dvou ‚duplicitních‘
vizualizací“. K prvnímu návrhu plánu doplnil: „Populační σ bych asi
nechal nastavovat společně pro oba grafy.“ Upravený plán téhož dne schválil.
Realizaci a ověření eviduje [autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-06-vrp"></a>

### Upřesnění 2026-11-06 — Rozšíření vizualizace výběrového rozdělení průměru

Autor požadoval: „Maximum velikosti výběru bych zvýšil ze 100 na 1000“,
„Maximum počtu nových výběrů bych zvýšil z 1000 na 10000“, aby bylo snadnější
posoudit tvar, ukázat pod výběrovým rozdělením průměrů na původní škále
„i jejich rozdělení po standardizaci směrodatnou chybou a populačním průměrem
na z-skór“ a nabídnout „i extrémně zešikmené rozdělení“. K návrhu plánu
doplnil, že i ve standardizovaném histogramu má jít normální model zapnout
a vypnout, „ale stačí společné tlačítko s grafem pro nestandardizované
průměry“. Upravený plán téhož dne schválil.

Volba: *n* 1–1000, počet nových výběrů 1–10 000 se stropem 100 000
opakování a s losováním velkých požadavků po dávkách. Přibyl histogram
standardizovaných průměrů $z=(m-\mathrm{μ})/\mathrm{σ}_m$ se společným
přepínačem normálního modelu a s podíly nad 2 a pod −2. Pátá populace
je extrémně zešikmená se šikmostí 8 a se stejnými μ a σ.
Standardizace průměru je vyložena v kapitole 6, nový pojem se nezavádí.
Realizaci a ověření eviduje [autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-06-binom"></a>

### Upřesnění 2026-11-06 — Vizualizace binomického rozdělení

Čtvrtá vizualizace podle R65, ke kapitole 5: stránka
`quarto/viz_binomicke_rozdeleni.qmd` („Pravděpodobnost počtu úspěchů“,
`#sec-viz-binomicke-rozdeleni`), v menu za vizualizací ploch pod normální
křivkou.

- Vstupy *n* (celé číslo 1–1000 se šipkami) a π (0–1 včetně), výchozí
  test s 20 otázkami a π = 0,25.
- Jedna hranice *k* se třemi **nezávislými** zaškrtávacími poli „méně než“,
  „právě“, „více než“ (kombinace dávají nejvýše, alespoň, jiný počet než *k*),
  nebo rozpětí od *k*₁ do *k*₂ včetně obou mezí s pravděpodobností v rozpětí
  i mimo ně.
- Dvojí osa x: řada *k* v počtech a řada *p* = *k*/*n* v podílech.
- Přepínač normální aproximace: křivka a dva přibližné výpočty, s hranicí
  uprostřed sloupce a s hranicí posunutou o 0,5 na okraj sloupců, oba
  s rozdílem od přesné hodnoty. Postup s posunem odpovídá výpočtu „od 134,5“
  v kapitole 5; termín „korekce na spojitost“ se nezavádí.
- Doplňky: vzorce českého Excelu s dosazenými hodnotami, výsledek podmínky
  aproximace, μ a σ počtu i podílu (v grafu úsečka μ ± σ) a pod sloupci
  schodovitý graf kumulativní pravděpodobnosti jako obdoba distribuční funkce.

**Doklad:** autor 2026-11-06 zadal: „Jako další vizualizaci bych chtěl
zakomponovat binomické rozdělení. Uživatel by mohl zvolit pravděpodobnost
úspěchu a počet pokusů a pak si nechat vypočíst pravděpodobnost pro určitý
počet úspěchů; umožnil bych zakliknout, jestli chce x přesně k zahrnout,
jestli chce zahrnout x menší než k a x větší než k (ale ať to nejsou vzájemně
výlučné volby); případně pro počet úspěchů pro rozpětí k s tím, že by se
vypočtla pravděpodobnost i v tomto rozpětí i mimo něj. Taky by tam měl být
přepínač pro vykreslení normální aproximace a osa X dvojitá jak pro počty,
tak pro podíly.“ Na doplňující otázky zvolil „Křivka + obě aproximace“,
rozsah *n* „1–1000“ a všechny čtyři doplňky („Vzorec v Excelu“, „Podmínka
aproximace“, „Střední hodnota a σ“, „Distribuční funkce“); plán téhož dne
schválil. Realizaci a ověření eviduje [autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-06-bayes"></a>

### Upřesnění 2026-11-06 — Vizualizace Bayesovy věty

Pátá vizualizace podle R65, ke kapitole 5: stránka
`quarto/viz_bayesova_veta.qmd` („Co znamená pozitivní výsledek testu“,
`#sec-viz-bayesova-veta`), v menu mezi plochami pod normální křivkou
a binomickým rozdělením, protože oddíl o Bayesově větě předchází v kapitole 5
binomickému rozdělení.

- Vstupy prevalence, senzitivita a specificita (desetinná čísla 0–1 včetně),
  výchozí příklad poradny z kapitoly 5 (0,10; 0,95; 0,90); volba 1 000 nebo
  10 000 osob a tlačítka obou příkladů kapitoly (poradna, plošné šetření
  s prevalencí 0,01).
- Hlavní obraz **mřížka osob**: jeden čtvereček na osobu ve čtyřech barvách
  podle kombinace stavu a výsledku, uspořádání podle skutečného stavu, podle
  výsledku dotazníku, jen pozitivní a jen negativní výsledky při stejné
  velikosti čtverečků. Necelé přirozené četnosti se zaokrouhlují na celé
  osoby s upozorněním „přibližně“; pravděpodobnosti se počítají přesně.
- Doplňky: strom a kontingenční tabulka se živými čísly a čtením po řádcích
  (senzitivita, specificita) a po sloupcích (prediktivní hodnoty); Bayesova
  věta s dosazenými hodnotami a vzorce českého Excelu podle listu `Bayes`;
  křivka prediktivní hodnoty pozitivního a negativního testu podle prevalence;
  druhé vyšetření, v němž se aposteriorní pravděpodobnost po prvním testu
  stává apriorní pro druhý, s výslovným předpokladem, že druhé vyšetření
  přináší novou informaci (bez termínu „podmíněná nezávislost“).
- Nové pojmy se nezavádějí (ani věrohodnost, poměr věrohodností či šance
  mimo nepovinné rozšíření kapitoly).

**Doklad:** autor 2026-11-06 se zeptal: „Jaká by byla nejvhodnější
interaktivní vizualizace pro Bayesovu větu?“ Na doplňující otázky zvolil
hlavní obraz „Mřížka osob“ (doporučená možnost, proti plošnému diagramu
a samotnému stromu s tabulkou) a všechny čtyři doplňky („Strom a tabulka
2×2“, „Křivka podle prevalence“, „Vzorec a Excel“, „Druhé vyšetření“);
plán téhož dne schválil. Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-07-posun"></a>

### Upřesnění 2026-11-07 — Vizualizace posunu a změny jednotek

Šestá vizualizace podle R65, ke kapitole 3: stránka
`quarto/viz_posun_a_jednotky.qmd` („Co s rozdělením udělá posun a změna
jednotek“, `#sec-viz-posun-a-jednotky`), v menu na prvním místě, protože
navazuje na kapitolu 3.

- Lineární transformace $y_i=a+b x_i$ se zadávaným posunem *a* a násobitelem
  *b* (libovolná čísla včetně záporných a nuly) na třech souborech kapitoly 3:
  pět časů 4, 5, 5, 6, 10 min, doby spánku (33 platných hodnot) a vybavená
  slova (36 hodnot). Předvolby z kapitoly: +2 minuty, minuty na sekundy,
  obojí ($a=120$, $b=60$), hodiny spánku na minuty, obrácení skórování
  slov $12-x$ a krajní případ $b=0$.
- Hlavní obraz **dvě osy se spojnicemi**: tečkový graf původních hodnot
  nad tečkovým grafem převedených, spojnice od každé různé původní hodnoty
  k nové, barva teček podle původní hodnoty, průměr, medián, úsečky
  $m\pm s$ a od 1. do 3. kvartilu; přepínač společné a vlastní osy.
- Tabulka ukazatelů polohy, variability a tvaru: hodnota z původních dat,
  hodnota spočtená znovu z převedených dat a předpověď pravidlem
  s dosazením (výměna kvartilů a změna znaménka šikmosti při $b<0$).
- Kontrast s nelineárním převodem $x^2$ a $\sqrt{x}$: místo pravidla převod
  původního ukazatele polohy se zjištěním, zda se shoduje.
- Vzorce českého Excelu pro pomocný sloupec (u spánku s KDYŽ kvůli chybějícím
  údajům) a pro ukazatele převedených hodnot. Nové pojmy se nezavádějí.

**Doklad:** autor 2026-11-07 se zeptal: „Jaká by byla nejvhodnější
vizualizace toho, co s ukazateli polohy, variability a tvaru a s grafem
rozdělením udělá posun a změna jednotek?“ Na doplňující otázky zvolil
hlavní obraz „Dvě osy se spojnicemi“ (doporučená možnost, proti grafům
před a po bez spojnic a jedinému grafu se dvěma řadami popisků), všechny
čtyři doplňky („Tabulka před/po/pravidlo“, „Přepínač osy: společná/vlastní“,
„Kontrast s nelineárním převodem“, „Vzorce českého Excelu“) a data „Data
z kapitoly + předvolby“; plán téhož dne schválil. Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-12-t"></a>

### Upřesnění 2026-11-12 — Vizualizace *t*-rozdělení a normovaného normálního

Sedmá vizualizace podle R65, ke kapitole 7: stránka
`quarto/viz_t_rozdeleni.qmd` („Jak se *t*-rozdělení liší od normovaného
normálního“, `#sec-viz-t-rozdeleni`), v menu za vizualizací statistické síly.
Realizuje námět „t a normální rozdělení podle stupňů volnosti“ z plánu
pokračování.

- Jediným vstupem stupňů volnosti je posuvník 1–100, výchozí 4 (výběr pěti
  lidí z kapitoly 7); číselné pole se nepoužívá.
- Čtyři grafy: hustoty obou rozdělení, normální Q–Q graf $t_{p\,(v)}$ proti
  $z_p$ v orientaci kapitoly 4, absolutní chyba normální aproximace
  (normální − *t*) a relativní chyba (absolutní chyba dělená hodnotou
  z *t*-rozdělení, v %). Grafy chyb mají přepínač veličiny: podíl ve chvostu
  za hranicí (výchozí), nebo výška hustoty.
- Stránka chyby vysvětluje vlastním oddílem se vzorcem, řešeným příkladem
  a zdůvodněním, proč relativní chyba ve chvostech roste. Absolutní
  a relativní chyba se popisují bez hesla ve slovníčku a nejsou zavedeny
  jako pojmy učebnice.
- Doplňky: zadávaná hranice s podíly za ní v obou rozděleních a s oběma
  chybami, vzorce českého Excelu (T.DIST, NORM.S.DIST, T.INV, NORM.S.INV)
  s dosazenými hodnotami. Tabulky: živá tabulka kvantilů úrovní 0,90; 0,95;
  0,975; 0,99; 0,995; 0,9995 pro zvolené stupně volnosti s použitím
  v kapitole 7 a pevná tabulka pro vybrané stupně volnosti se zvýrazněným
  řádkem.
- Předlohou námětu je stránka R. Magnussona „Student's t-distribution“
  (rpsychologist.com/d3/tdist/). Jde o vlastní inspiraci: text, kód ani
  grafika se nepřebírají a studentská stránka ji proto necituje.

**Doklad:** autor 2026-11-12 zadal: „Myslím, že další interaktivní
vizualizace by mohla zahrnovat srovnání Studentova t-rozdělení
a normovaného normálního rozdělení, něco jako:
https://rpsychologist.com/d3/tdist/ Se stupni volnosti 1 až 100, křivkami
hustoty, QQ grafem, grafem absolutní chyby s vysvětlením a grafem relativní
chyby s vysvětlením (myslím že právě to na rpsychologist není moc dobře
vysvětleno) a tabulkou se srovnání nejčastěji používaných kvantilů t-
a z-rozdělení“. Na doplňující otázky zvolil pro grafy chyb „Obojí
s přepínačem“ (podíl ve chvostu a výška hustoty), tabulku „Pro zvolené v
+ pevná“, doplňky „Hranice s podíly“, „Vzorce českého Excelu“ a „Posuvník
k číselnému poli“ a pojmenování chyb „Popisně, bez hesla“. Při schvalování
plánu upřesnil: „Pro stupně volnosti bych dal jako input posuvník od 1
do 100“; upravený plán téhož dne schválil. Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-12-interval"></a>

### Upřesnění 2026-11-12 — Vizualizace intervalu spolehlivosti a *p*-hodnoty

Osmá vizualizace podle R65, ke kapitole 7: stránka
`quarto/viz_interval_a_test.qmd` („Jak spolu souvisí interval spolehlivosti
a *p*-hodnota“, `#sec-viz-interval-a-test`), v menu za vizualizací
*t*-rozdělení. Spojuje obrázky kapitoly 7 `fig-p-funkce` a
`fig-zrcadlo-intervalu`; statické obrázky v kapitole zůstávají.

- Model jednovýběrového *t*-testu. Vstupy: testovaná hodnota μ₀ a výběrový
  průměr *m* (posuvník a číselné pole), *s* a *n* (výchozí 11 a 25), α jako
  desetinné číslo 0 < α ≤ 0,5 a směr testu (oboustranný, jednostranný
  s alternativou μ < μ₀ nebo μ > μ₀).
- Dva grafy pod sebou se společnou osou skóre, vždy s *m* i μ₀: pohled
  intervalu (*p*-hodnota podle μ₀, interval spolehlivosti kolem *m*) a pohled
  testu (*p*-hodnota podle *m*, oblast nezamítnutí kolem μ₀).
- U jednostranného testu jednostranný interval spolehlivosti
  ([R75](kapitola-07.md#r75-oboustranny-jednostranny-interval)) i oboustranný
  interval se spolehlivostí 1 − 2α; zrcadlově v pohledu testu jednostranná
  a souměrná oblast nezamítnutí.
- Doplňky: tabulka čtyř pohledů na totéž rozhodnutí s čísly, vzorce českého
  Excelu, předvolby příkladů kapitoly (pozornost oboustranně a jednostranně,
  PDI) a u jednostranného testu tenká křivka oboustranné *p*-hodnoty
  s hladinou 2α.

**Doklad:** autor 2026-11-12 zadal: „Myslím, že tyto dva obrázky by také bylo
možné spojit do jedné interaktivní vizualizace, např. zrcadlově vedle sebe
svisle ukázat interval spolehlivosti a oblast nezamítnutí, vždy zobrazit
výběrový průměr a průměr pod H0; v grafu pro CI ukázat, jak se p-hodnota mění
pro různé testované H0, a v grafu pro oblast zamítnutí ukázat, jak se
p-hodnota mění pro různé výběrové průměry. Jako input nechat nastavovat různé
hodnoty mí pod H0 a pozorovaného výběrového průměru, hladinu významnosti alfa
a typ testu (oboustranný, jednostranný s alternativou "menší" nebo "větší").
U jednostranných testů zobrazit jak noncentrální CI, tak odpovídají centrální
CI s hladinou spolehlivosti 1–2alfa.“ Na doplňující otázky zvolil uspořádání
„Pod sebou, společná osa“, *s* a *n* „Nastavitelné, výchozí 11 a 25“, zadání
*m* a μ₀ „Posuvník + číselné pole“, všechny čtyři doplňky („Tři cesty
s čísly“, „Vzorce českého Excelu“, „Předvolby příkladů kapitoly“, „Oboustranná
křivka i u jednostranného“), zrcadlení „Ano, obě varianty“ a α „Desetinné číslo
0 < α ≤ 0,5“. K pojmenování intervalů zavedl R75. Plán schválil 2026-11-13.
Realizaci a ověření eviduje [autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-13-pokryti"></a>

### Upřesnění 2026-11-13 — Vizualizace pokrytí intervalu spolehlivosti

Devátá vizualizace podle R65, ke kapitole 7: stránka
`quarto/viz_pokryti_intervalu.qmd` („Jak často interval spolehlivosti
zachytí populační průměr“, `#sec-viz-pokryti-intervalu`), v menu mezi
vizualizací *t*-rozdělení a vizualizací intervalu a *p*-hodnoty. Rozšiřuje
obrázek kapitoly 7 `fig-opakovane-intervaly`, který v kapitole zůstává.

- Vstupy: populace (normální a čtyři zešikmené doprava: tvary tabulky
  `tbl-k07-odolnost` se šikmostí 0,7, 2 a 6 a posunutá lognormální se
  šikmostí 8 jako ve vizualizaci výběrového rozdělení průměru, vše převedené
  na zadané μ a σ), μ, σ, *n* 2–1 000, hladina spolehlivosti v % (větší
  než 50, menší než 100), postup (známá σ s kvantilem *z*, *s* s kvantilem *t*,
  *s* s kvantilem *z* jako chybný postup), typ intervalu (oboustranný,
  jednostranný s horní nebo dolní mezí podle
  [R75](kapitola-07.md#r75-oboustranny-jednostranny-interval)) a počet nových
  výběrů 1–10 000 se stropem 100 000.
- Losování po dávkách; změna hladiny, postupu nebo typu přepočítá intervaly
  z týchž výběrů, změna populace, μ, σ nebo *n* začne znovu.
- Grafy: posledních 100 intervalů (zachytil modře, minul oranžově), vývoj
  pokrytí s pásem ± 1,96 směrodatné chyby podílu, histogramy průměrů, *s*
  a šířek intervalů rozdělené barvou podle výsledku.
- Pokrytí v simulaci proti očekávanému: u normální populace přesně
  (pro chybný postup z *t*-rozdělení), u zešikmených populací slovně směr
  očekávání u malých výběrů podle postupu a typu intervalu se zdůvodněním.
- Doplňky: detail vybraného intervalu (myš, klepnutí, šipky), výpočet
  vybraného intervalu se vzorci českého Excelu a tři předvolby.

**Doklad:** autor 2026-11-13 zadal: „Myslím, že další vizualizace by se mohla
týkat intervalů spolehlivosti podobně jako: https://rpsychologist.com/d3/CI/
Uživatel by měl možnost nastavit hladinu spolehlivosti, mí a sigma, to zda se
předpokládá známá sigma nebo se odhaduje na základě výběru, jestli chce
tradiční oboustranné CI nebo jednostranné (a s kterou hranicí), jaká má být
velikost výběru a počet simulovaných výběrů. Barevně bych odlišil, které
intervaly zachytily vs nezachytili mí. Ukázal bych také podíly: skutečné vs
očekávané pokrytí. vývoj pokrytí, rozdělení výběrových průměrů, směrodatných
odchylek a šířek CI.“ Na doplňující otázky zvolil „Tři postupy“, populace
„I zešikmená“, losování „Po dávkách“ a všechny čtyři doplňky („Barvy
i v histogramech“, „Pás náhodného kolísání“, „Detail intervalu“, „Vzorce
českého Excelu“). K plánu doplnil: „Ve vizualizaci výběrového rozdělení
průměru je i extrémně zešikmená (šikmost 8), takže by mohla být i tady.“
a „U zešikmených bych kromě ‚nelze spočítat přesně, odhaduje simulace‘ ale
uvedl, jaké je podle typu intervalu (oboustranný, jednostranný s horní vs
dolní mezí) naše očekávání, jestli bude vyšší, nebo nižší než nominální
u malých výběrů.“ Upravený plán téhož dne schválil. Realizaci a ověření
eviduje [autorská historie](../../quarto/README.md#vizualizace-pokryti-intervalu).

<a id="r65-upresneni-2026-11-13-cohen"></a>

### Upřesnění 2026-11-13 — Vizualizace Cohenova d

Desátá vizualizace podle R65, ke kapitole 8: stránka
`quarto/viz_cohenovo_d.qmd` („Co znamená rozdíl o *d* směrodatných
odchylek“, `#sec-viz-cohenovo-d`), v menu za vizualizací intervalu
a *p*-hodnoty. Kapitola 8 na ni odkazuje blokem „Vyzkoušejte si“ na konci
oddílu `sec-d-nezavisle`.

- Model: dvě normální populace se shodnou σ, skupina 1 s vyšším průměrem,
  $d=(\mathrm{μ}_1-\mathrm{μ}_2)/\mathrm{σ}$.
- Vstupy: posuvník *d* 0–2 po 0,01, výchozí 0,5, obecné „skupina 1“
  a „skupina 2“; pole σ v původních jednotkách (výchozí 10) jen pro převod
  na rozdíl průměrů $d\cdot\mathrm{σ}$; přepínač vybarvení (společná plocha,
  nebo skupina 1 nad průměrem skupiny 2).
- Tři ukazatele **jen českým opisem**, bez anglických názvů a bez hesel ve
  slovníčku: podíl skupiny 1 nad průměrem skupiny 2 $\mathrm{Φ}(d)$ (v literatuře
  Cohenovo U₃), společná plocha obou rozdělení $2\,\mathrm{Φ}(-d/2)$ (overlap;
  slovo „překryv“ se nepoužívá kvůli překryvu intervalů v kap. 8)
  a pravděpodobnost, že náhodně vybraný člověk ze skupiny 1 má vyšší
  hodnotu než náhodně vybraný člověk ze skupiny 2, $\mathrm{Φ}(d/\sqrt2)$
  (probability of superiority). Každý se vzorcem českého Excelu
  s dosazeným *d*.
- Grafy: rozdělení obou skupin a rozdělení rozdílu hodnot náhodné dvojice
  $N(d,\sqrt2)$ s vybarvenou plochou vpravo od nuly; σ√2 se opírá
  o sčítání rozptylů z oddílu kap. 8 `sec-rozdil-nezavislych`.
- Doplňky: pevná tabulka pro *d* = 0; 0,2; 0,5; 0,8; 1; 1,5; 2 se
  zvýrazněným (případně vloženým) zvoleným *d*; Cohenovy orientační hodnoty
  jako značky posuvníku a štítky tabulky s výhradou podle
  [R56](kapitola-06.md#r56-p-hodnota-cohen).
- Předlohou námětu je stránka R. Magnussona „Interpreting Cohen's d“
  (rpsychologist.com/cohend). Jde o vlastní inspiraci: text, kód ani
  grafika se nepřebírají a studentská stránka ji proto necituje.

**Doklad:** autor 2026-11-13 zadal: „Jako další vizualizaci bych doplnil
vizualizaci Cohenova d, podobně jako: https://rpsychologist.com/cohend
Myslím, že jako input by stačilo mít slider s Cohenovým d. A uvádět Cohen's
U₃, % Overlap a Probability of Superiority; nemusíme nutně zavádět nové
termíny, ale vyjádřit to opisem.“ Na doplňující otázky zvolil posuvník
„0 až 2, krok 0,01“, „d = 0,5, obecné skupiny“, všechny čtyři doplňky
(„Vzorce českého Excelu“, „Pevná tabulka pro vybraná d“, „Cohenova pásma
s výhradou“, „Převod na původní jednotky“) a „Jen český opis“. Plán téhož
dne schválil. Druhý graf (rozdíl hodnot náhodné dvojice) a přepínač
vybarvení přibyly při realizaci jako názorné doplnění třetího, resp.
prvního ukazatele. Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md#vizualizace-cohenovo-d).

<a id="r65-upresneni-2026-11-19-parovani"></a>

### Upřesnění 2026-11-19 — Vizualizace přínosu párování

Jedenáctá vizualizace podle R65, ke kapitole 8: stránka
`quarto/viz_prinos_parovani.qmd` („Kdy párování zpřesní odhad průměrného
rozdílu“, `#sec-viz-prinos-parovani`), v menu před vizualizací Cohenova *d*
podle pořadí oddílů kapitoly. Kapitola 8 na ni odkazuje blokem
„Vyzkoušejte si“ na konci oddílu `sec-proc-rozdily`, před nepovinným
rozšířením o korelaci.

- Data: po načtení dvanáct úplných dvojic varianty A (tab. 8.2), výsledky
  shodné s tab. 8.4; jinak výběr *n* = 3–200 studentů z normálního modelu,
  přepočítaný při změně nastavení ze stejných náhodných čísel, a tlačítko
  nového výběru. Populační průměr rozdílů $\mathrm{μ}_D$ (výchozí 3,5).
- Souvislost obou měření dvěma způsoby přepínačem: (1) výchozí „stabilní
  rozdíly mezi lidmi“ a „kolísání téhož člověka“ jako dvě směrodatné
  odchylky v bodech (6,7 a 1,7), slovy výkladu `sec-proc-rozdily`, bez
  nových symbolů; (2) σ₁, σ₂ a „korelace obou měření v populaci“ bez symbolu
  pro čtenáře nepovinného rozšíření, výběrové *r* se zobrazí jen zde.
- Párová analýza a chybná analýza jako dvou nezávislých skupin (klasický
  *t*-test, 2*n* − 2 st. v.) vedle sebe: tabulka jako tab. 8.4, spojnice
  jednotlivců, tečkový graf rozdílů s intervalem a oba intervaly na
  společné ose.
- Doplňky: křivka směrodatné chyby obou analýz v modelu podle podílu
  stabilních rozdílů na rozptylu měření (způsob 1) nebo korelace (způsob 2);
  opakované losování 100 / 1000 / 10 000 výběrů po dávkách se stropem
  100 000 (podíl zamítnutí H₀, pokrytí μ_D, průměrná šířka a histogram
  šířek intervalů); vzorce českého Excelu s dosazenými souhrny a u dat
  varianty A `T.TEST` typ 1 a 2 na listu `Parovy_test`.
- Studentský text nezavádí nové pojmy; „podíl stabilních rozdílů na rozptylu
  jednoho měření“ je opis osy grafu, ne nový termín.

**Doklad:** 2026-11-19 se autor zeptal, zda by se ke kapitole 8 hodila další
vizualizace. Z návrhu (přínos párování, dva intervaly vedle sebe a interval
rozdílu) vybral „Přínos párování“. Na doplňující otázky zvolil ovládání
„Obojí přepínačem“ (dvě směrodatné odchylky i korelace), data „Výběr +
varianta A“, všechny čtyři doplňky („Křivka směrodatné chyby“, „Opakované
losování“, „Vzorce českého Excelu“, „Graf rozdílů jednotlivců“) a odkaz na
konci „Proč rozdíly kolísají méně“. Plán téhož dne schválil. Realizaci
a ověření eviduje [autorská historie](../../quarto/README.md#vizualizace-prinos-parovani).

<a id="r65-upresneni-2026-11-19-intervaly"></a>

### Upřesnění 2026-11-19 — Vizualizace dvou intervalů a intervalu rozdílu

Dvanáctá vizualizace podle R65, ke kapitole 8: stránka
`quarto/viz_dva_intervaly.qmd` („Co prozradí dva intervaly vedle sebe
o rozdílu průměrů“, `#sec-viz-dva-intervaly`), v menu za vizualizací
Cohenova *d* podle pořadí oddílů kapitoly. Kapitola 8 na ni odkazuje
blokem „Vyzkoušejte si“ na konci oddílu `sec-dva-intervaly`.

- Uspořádání přepínačem: nezávislé skupiny (průměr, *s*, *n* 2–1000 pro
  každou; interval rozdílu klasickým *t*-testem, nebo Welchovým), nebo
  párová data (průměr a *s* obou podmínek, jedno *n*, posuvník $s_D$
  v mezích $|s_1-s_2|$ až $s_1+s_2$, vysvětlených bez korelace).
- Hladina spolehlivosti 90, 95 nebo 99 % pro intervaly průměrů i rozdílu.
- Grafy: chybové úsečky obou průměrů se společnou částí a interval rozdílu
  s nulou; *p*-hodnota podle rozdílu průměrů se třemi pásmy (hranice
  „rozdíl významný od“ a „intervaly se přestanou překrývat od“); sloupce
  mezních chyb a u nezávislých skupin pravoúhlý trojúhelník směrodatných
  chyb.
- Doplňky: slovní závěr ve čtyřech případech, předvolby (příklad kapitoly,
  právě se dotýkající intervaly, nestejné skupiny s Welchem, data varianty A
  párově), vzorce českého Excelu včetně kvantilu Welche přes `BETA.INV`
  jako na listu `Welch`.
- Bez nových pojmů a symbolů; bez pravidla pro čtení překryvu, které
  kapitola záměrně neuvádí.

**Doklad:** 2026-11-19 autor požádal: „můžeš vytvořit také vizualizaci
2. Dva intervaly vedle sebe a interval rozdílu?“ Na doplňující otázky
zvolil uspořádání „Nezávislé i párové“, postup „Klasický + přepínač
Welch“, všechny čtyři doplňky („Graf pásma podle rozdílu“, „Znázornění
mezních chyb“, „Vzorce českého Excelu“, „Předvolby příkladů“) a hladinu
„Volitelná (90/95/99 %)“. Plán téhož dne schválil. Realizaci a ověření
eviduje [autorská historie](../../quarto/README.md#vizualizace-dva-intervaly).

<a id="r65-upresneni-2026-11-20-chi"></a>

### Upřesnění 2026-11-20 — Vizualizace tabulky četností a testu chí-kvadrát

Třináctá vizualizace podle R65, první ke kapitole 9: stránka
`quarto/viz_chi_kvadrat.qmd` („Jak daleko je tabulka četností od
nezávislosti“, `#sec-viz-chi-kvadrat`), v menu za vizualizací dvou
intervalů. Kapitola 9 na ni odkazuje blokem „Vyzkoušejte si“ v pododdílu
`sec-pearson-upravena`, za nepovinným rozšířením o Holmově korekci.

- Východiskem je příklad kapitoly věk × strategie zvládání stresu
  (3 × 3, *n* = 190). Student přepisuje pozorované četnosti přímo
  v tabulce (celá čísla 0–100 000); součty se dopočítávají.
- Tlačítka „Zdvojnásobit četnosti“, „Původní data“ a „Nezávislost“
  (zaokrouhlené očekávané četnosti původní tabulky).
- Odvozené tabulky: očekávané četnosti, příspěvky buněk ke χ², Pearsonova
  rezidua a standardizovaná rezidua. Standardizovaná rezidua jsou
  podbarvená podle hodnoty (modře více, oranžově méně, než odpovídá
  nezávislosti), bez pevné hranice ±1,96 a s výhradou o více testech.
- Grafy: řádkové podíly jako na obrázku kapitoly, překreslované podle
  tabulky (bez tažení sloupců), a chí-kvadrát rozdělení se čtyřmi stupni
  volnosti s vybarvenou *p*-hodnotou a kritickou hodnotou pro hladinu 0,05.
- Doplňky: Cramérovo V, upozornění při očekávané četnosti pod 5 s odkazem
  na oddíl o předpokladech, slovní závěr testu, vzorec českého Excelu.
- Oddíl „Odkud se čísla berou“ opakuje všechny použité vzorce ve znění
  kapitoly s dosazením.
- Bez nových pojmů a symbolů; velikost tabulky je pevná.

**Doklad:** 2026-11-20 autor na nabídku čtyř námětů ke kapitole 9 odpověděl:
„zapracoval bych tedy nejprve vizualizaci 1. Od tabulky četností k testu
chí-kvadrát. Vyšel bych z příkladu věk × strategie zvládání stresu. Nechal
bych studenty upravovat pozorované četnosti a také bych tam dal tlačítko
pro jejich zdvojnásobení. V odvozených tabulkách bych ukázal např. očekávané
četnosti, Personova rezidua i standardizovaná rezidua. Výsledky bych
znázornil i graficky tak, jak to ukazuje kapitole s tím, že graf by byl
interaktivní […] Doplnil bych i chi-square rozdělení s odpovídajícím
vybarveným podílem reprezentujícím p-hodnotu.“ Na doplňující otázky zvolil
graf „Reaguje na tabulku“, rezidua „Podbarvení podle hodnoty“ a všechny
čtyři doplňky („Cramérovo V“, „Příspěvky buněk ke χ²“, „Upozornění na malé
očekávané četnosti“, „Tlačítko ‚Nezávislost‘“). K plánu doplnil: „Taky bych
zopakoval všechny relevantní vzorce.“ Plán téhož dne schválil. Realizaci
a ověření eviduje [autorská historie](../../quarto/README.md#vizualizace-chi-kvadrat).
Zbylé tři náměty ke kapitole 9 zůstávají otevřeným návrhem v
[plánu pokračování](../kapitoly/plan-pokracovani.md#plan-vizualizace).

<a id="r65-upresneni-2026-11-20-miry"></a>

### Upřesnění 2026-11-20 — Vizualizace rozdílu podílů, poměru rizik a poměru šancí

Čtrnáctá vizualizace podle R65, druhá ke kapitole 9: stránka
`quarto/viz_miry_souvislosti.qmd` („Co říkají rozdíl podílů, poměr rizik
a poměr šancí o téže tabulce“, `#sec-viz-miry-souvislosti`), v menu za
vizualizací chí-kvadrát. Kapitola 9 na ni odkazuje blokem „Vyzkoušejte si“
na konci pododdílu `sec-phi-v`, před nepovinným rozšířením o intervalech
poměrů.

- Zadání přepínačem: četnosti tabulky 2 × 2 (výchozí údaje Danielsové),
  nebo dvě rizika posuvníky ve stejně velkých skupinách po 100, 1 000
  nebo 10 000 osobách. Předvolby Danielsová a aspirinová studie, tlačítko
  záměny referenční skupiny.
- Dvě skupiny osob jako pole teček s pohledem na riziko a na šance;
  všechny míry s dosazením a větami o správném čtení.
- Vliv rizika v referenční skupině: graf tří čar (stejný rozdíl rizik,
  stejný poměr rizik, stejný poměr šancí) na běžné stupnici rizika 0–1,
  tabulka jejich hodnot a v zadání posuvníky volba míry držené pevně.
- Retrospektivní výběr: posuvník podílu zařazených osob bez jevu; poměr
  šancí se nemění, poměr podílů ano.
- Koeficient φ se znaménkem a jako součin rozdílu řádkových a sloupcových
  podílů.
- Bez nových pojmů a symbolů: bez počtu léčených (NNT), logaritmu šancí,
  intervalů poměrů a adjustace; poměr rizik a poměr šancí slovy (R69).
- Stránka uvádí citací článek, kterým je její členění inspirováno
  ([E08](../zdroje/E08-magnusson-odds-ratio.md#e08-magnusson-odds-ratio));
  text, příklady a kód jsou vlastní.

**Doklad:** 2026-11-20 autor zadal: „Nyní bych chtěl implementovat
vizualizaci k bodu 3. Rozdíl podílů, poměr rizik a poměr šancí. Myslím, že
se lze hodně inspirovat: https://rpsychologist.com/odds-ratio“. Na
doplňující otázky zvolil všechny čtyři části („Dvě skupiny osob“, „Vliv
výchozího rizika“, „Retrospektivní výběr“, „Koeficient φ“), zadání „Obojí
přepínačem“, nové pojmy „Žádné“ a citaci „Ano, citací“. Plán téhož dne
schválil. Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md#vizualizace-miry-souvislosti).

<a id="r65-upresneni-2026-11-20-nabidka"></a>

### Upřesnění 2026-11-20 — Část s vizualizacemi je v nabídce sbalená

V postranní nabídce webu je část „Interaktivní vizualizace“ ve výchozím
stavu sbalená; na stránce vizualizace zůstává rozbalená a šipkou ji lze
rozbalit kdekoli. Části „Výkladové kapitoly“ a „Literatura a přehledy“
zůstávají rozbalené. Pořadí částí ani stránek se nemění. Provedení
(`assets/sidebar-collapse.js`) popisuje
[provozní návod](../PROVOZ.md#interaktivni-vizualizace).

**Doklad:** 2026-11-20 autor při schvalování plánu vizualizace chí-kvadrát
uvedl: „protože vizualizací je už celkem dost, chtěl bych, ať je oddíl
s nimi (v osnově html verze) defaultně folded“.

<a id="r65-upresneni-2026-11-23-korelace"></a>

### Upřesnění 2026-11-23 — Vizualizace korelace v bodovém grafu

Patnáctá vizualizace podle R65, první ke kapitole 10: stránka
`quarto/viz_korelace.qmd` („Jak tvar mraku bodů souvisí s korelačním
koeficientem“, `#sec-viz-korelace`), v menu za vizualizací měr souvislosti.
Kapitola 10 na ni odkazuje dvěma bloky „Vyzkoušejte si“: na konci pododdílu
`sec-vydelime` (před rozšířením `#rozsireni-meze-r`) a na konci pododdílu
`sec-odlehle-korelace`. Částečně nahrazuje bod R71 o vizualizacích
([doplnění R71](kapitola-10.md#r71-doplneni-2026-11-23)).

- Data: úzkost a výkon 40 studentů z kapitoly 10 (výchozí), spánek
  a pozornost z kapitoly 8, Anscombův kvartet I–IV a nový náhodný výběr
  (4–1 000 bodů) z dvourozměrného normálního rozdělení.
- Posuvník a pole nastaví přesně výběrové *r* (Y se přepočítá, X, průměr
  a směrodatná odchylka Y zůstanou); pole pro $m_x$, $s_x$, $m_y$, $s_y$
  mění data posunem a změnou jednotek.
- Body lze v grafu přesouvat, přidávat a mazat myší, dotykem i klávesnicí
  (3–1 000 bodů); osy se mění jen tlačítkem nebo při změně dat.
- Přepínače: kvadranty se součiny odchylek, pravděpodobnostní elipsy 50, 80,
  95 a 99 % se skutečnými počty bodů uvnitř (výchozí vypnuto), regresní
  přímka a rezidua (výchozí vypnuto), Vennův diagram *r*² (výchozí zapnuto).
- Přehled s dosazením: průměry, směrodatné odchylky, kovariance, Pearsonovo
  *r*, Spearmanův korelační koeficient, test nulové korelace, Fisherův 95%
  interval, *r*², při zapnutí rovnice přímky a součet čtverců reziduí.
- Pod hlavním grafem trvale bodový graf pořadí a graf spojnic (bez
  přepínačů, jen ke čtení).
- Nové termíny jen ve vizualizaci: regresní přímka, reziduum, koeficient
  determinace, pravděpodobnostní elipsa; značky $\hat{y}$, $b_0$, $b_1$
  a $r^2$ ([slovník](../SLOVNIK.md#vizualizace-korelace)). Stránka je
  vysvětluje v oddílu „Pojmy, které kapitola 10 nevykládá“; kapitoly je
  nepředpokládají.
- Stránka cituje aplikaci, kterou je inspirována (Magnusson, 2026, verze 0.8.0,
  [E09](../zdroje/E09-magnusson-correlation.md#e09-magnusson-correlation));
  text, příklady a kód jsou vlastní.

**Doklad:** 2026-11-23 autor zadal: „Bylo by možné replikovat tuto
interaktivní vizualizaci korelací […] https://rpsychologist.com/correlation
Se sliderem pro hodnotu korelace, nastavením počtu bodů, možností interaktivně
přidat bod, vymazat bod nebo pohnout bodem. Také by mohl být jednoduchý
numerický input pro průměry a směrodatné odchylky obou proměnných. S možností
zapnout/vypnout zobrazení regresní přímky, reziduí a pravděpodobnostních elips
(50%, 80%, 95%, 99%)“. Na doplňující otázky zvolil u regrese „Zahrnout,
výchozí vypnuto“, u Vennova diagramu „Zařadit s vysvětlením“ a doplňky
„Spearmanův r_s vedle r“, „Kvadranty a součiny“, „Předvolby z kapitoly“
a „Fisherův interval pro r“. Během přípravy plánu doplnil: „Jako odvozené
grafy bych přidal i slope chart“ a „A bodový graf po pořadové transformaci“.
K plánu připomněl: „Bodový graf pořadí a Graf spojnic (slope chart) bych
nebral jako přepínače, ale zobrazil bych je někde pod hlavním bodovým.
Pravděpodobnostní elipsy bych defaultně vypnul.“ a určil citaci „Magnusson,
K. (2026). Interpreting correlations: An interactive visualization (Version
0.8.0) [Web App]. R Psychologist. https://rpsychologist.com/correlation/“.
Upravený plán včetně uvedených termínů a značení schválil téhož dne.
Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md#vizualizace-korelace).

<a id="r65-upresneni-2026-11-23-korelace-upravy"></a>

**Úpravy před sloučením (2026-11-23):** před sloučením PR autor požádal:
„grafy by měly být na celou šířku stránky, nikoli vedle sebe, takže vennův
diagram bych umístil až pod samotný bodový graf; podobně graf spojnic bych
umístil až pod bodový graf pořadí. Ideální by bylo, kdyby u bodových grafů
rozpětí osy X odpovídalo rozpětí osy Y (1 : 1). […] přidat bod a odebrat bod
by bylo nejlepší dělat jen kliknutím do grafu; nejlepší by byl přepínač toho,
co bude v grafu dělat myš […] U 95% CI bych nejprve ukázal i směrodatnou
chybu z_r a interval před transformací.“ Na doplňující otázky zvolil
„Čtvercový graf“ (rozsah každé osy podle jejích dat) a „Odstranit formulář“.
K plánu doplnil: „Ještě bych doplnil přepínač (stačí jeden společný) pro
zobrazení čar délky (zeleně) + šířky (oranžově) elipsy, které by odpovídaly
první a druhé hlavní komponentě; zatím není třeba ale tyto pojmy zavádět, ale
jen to nějak srozumitelně popsat opisem.“ Upravený plán schválil téhož dne.
Rozsah po úpravách:

- hlavní graf a graf pořadí jsou čtvercové a jdou přes celou šířku obsahu;
  Vennův diagram je pod hlavním grafem, graf spojnic pod grafem pořadí;
- osy hlavního grafu sahají od průměrů na obě strany o stejný počet
  směrodatných odchylek své proměnné, takže graf je čtvercový i v *z*-skórech;
- přepínač „Co dělá myš v grafu“ (přesune bod tažením / přidá bod kliknutím /
  odstraní bod kliknutím) přímo nad grafem; formulář pro nový bod odstraněn,
  pod grafem řádek se souřadnicemi ukazatele;
- přepínač „délka a šířka elipsy“ (výchozí vypnuto): zelená a oranžová úsečka
  podél hlavních os elipsy v *z*-skórech, konce na elipse 99 %, popsané opisem
  bez termínu hlavní komponenta;
- interval pro ρ uvádí $z_r$, směrodatnou chybu $1/\sqrt{n-3}$ a meze na
  stupnici $z_r$ před převodem zpět.

<a id="r74-heslovite-poznamky"></a>

## R74 — Heslovité poznámky v PPTX, podrobné v DOCX

**Stav:** schváleno 2026-11-11. **Rozsah:** nové prezentace a prezentace,
jejichž poznámky se upravují; první použití u prezentace kapitoly 7.
Starší prezentace s úplnými poznámkami v PPTX se převádějí jen na žádost.

**Volba:** poznámky v PPTX jsou krátké, heslovité a stále srozumitelné,
aby se v nich vyučující vyznal při prezentaci; ke každému výkladovému slidu
obsahují otázku k zamyšlení se stručnou odpovědí, u úloh výsledek
a klíčový argument. Čas pro vyučujícího a odkaz na oddíl kapitoly jsou jen
v DOCX. Podrobné poznámky v celých větách, samostatně srozumitelné
studentovi, nese `kapitola_NN_poznamky.docx`; ten je hlavním místem jejich
znění a podkladem scénáře zvukového doprovodu. Aktuální znění pravidel je
v [PREZENTACE.md](../PREZENTACE.md#dve-podoby-poznamek) a
[TEXT2SPEECH.md](../TEXT2SPEECH.md#podklady-rozsah-a-účel-výkladu).

**Nahrazuje:** v PREZENTACE.md pravidlo, že poznámky v PPTX nesmějí být
pouze hesly pro vyučujícího, a pojetí DOCX jako exportu poznámek z PPTX.
Tvar nadpisů DOCX podle [R50](#r50-struktura-prezentaci) zůstává;
[R33](#r33-excelova-cviceni-prezentaci) a [R53](#r53-doprovodne-audio)
se nemění.

**Důvod:** úplné poznámky (u kapitoly 7 asi 7 800 slov na 40 slidů) byly
pro orientaci během výkladu příliš rozsáhlé; podrobný výklad pro studenty
zůstává zachován v DOCX a ve zvukovém doprovodu.

**Doklad:** zadání autora z 2026-11-11: „myslím, že současné poznámky
k přednášce 7 jsou moc rozsáhlé, chtěl bych, aby byly co nejvíce concise
a heslovité, ale stále srozumitelné, tak, abych se v nich při prezentaci
vyznal.“ Na otázku, zda jde o obecné pravidlo, odpověděl: „Nastavil bych
to tak, ať v samotné prezentaci jsou poznámky (notes) krátké, heslovité,
concise, ale stále srozumitelné; a v docx s poznámkami podrobné celé věty.“
U úloh zvolil „Výsledek + klíčový argument“ a z doplňků v PPTX ponechal jen
„Otázka k zamyšlení“. Plán úpravy schválil téhož dne.

<a id="r80-pdf-cele-ucebnice"></a>

## R80 — PDF celé učebnice ke stažení z vydání na GitHubu

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r80-pdf-cele-ucebnice). Původní záznam dohody:*

**Stav:** schváleno 2026-11-14. **Rozsah:** souhrnné PDF knihy a odkaz na něj
z úvodní stránky „O učebnici“. PDF jednotlivých kapitol se nemění.

**Volba:** souhrnné PDF obsahuje úvod, všechny výkladové kapitoly uvedené
v `_quarto.yml` (nyní 1–10), literaturu a tři přehledy; řešení cvičení jsou
na konci každé kapitoly. Sestavuje se dál ručně, bez spouštění při renderu
webu a bez změny CI. Studentům se zpřístupňuje jako jediný soubor
`zaklady-statistiky-pro-psychology.pdf` ve vydání na GitHubu se stálým
štítkem `ucebnice-pdf`, na který odkazuje úvod knihy. Vydání se nikdy
neoznačuje jako „Latest“, aby odkazy tutora `releases/latest/download/…`
podle [R79](ai-tutor.md#r79-vydani-tutora-na-githubu) dál vedly na tutora.
Nahrání nové verze PDF je samostatný krok na výslovný pokyn autora.
Postup je v [provozním návodu](../PROVOZ.md#pdf-cele-ucebnice).

**Nahrazuje:** z [R31](#r31-pracovni-pdf) část „bez automatické publikace“
pro souhrnné PDF a dosavadní omezení souhrnného PDF na kapitoly 1–6.
Sestavení jen na výslovné vyžádání a umístění řešení za zadáními zůstávají.

**Důvod:** studenti mají mít možnost učebnici vytisknout nebo číst bez
připojení; stálá adresa vydání umožňuje aktualizovat PDF bez změny odkazu
a bez ukládání PDF do Gitu.

**Doklad:** zadání autora z 2026-11-14: „Myslím, že v úvodní sekci "O učebnici"
by mohl být odkaz na stažení PDF verze učebnice“. Na otázku, na jaké PDF má
odkaz vést, zvolil „Celá kniha“ a po upozornění na kapitolu 10 „Ano,
kapitoly 1–10“; na otázku, jak PDF zveřejnit, zvolil „Vydání na GitHubu“.
Plán úpravy schválil téhož dne.

<a id="r82-poznamky-bez-casu-a-odkazu"></a>

## R82 — Poznámky k prezentacím bez času a odkazu na oddíl kapitoly

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r82-poznamky-bez-casu-a-odkazu). Původní záznam dohody:*

**Stav:** schváleno 2026-11-17. **Rozsah:** heslovité poznámky v PPTX
i podrobné poznámky v DOCX všech prezentací, nových i upravovaných.

**Volba:** poznámky ke slidům neobsahují odrážku s časem pro vyučujícího
(„Čas pro vyučujícího: přibližně N min.“) ani odkaz na příslušný oddíl
kapitoly („Podklad: kapitola N, …, příslušný oddíl: https://…“). Jiné
organizační pokyny, například doporučený postup u cvičení, se nemění.
Aktuální znění je v [PREZENTACE.md](../PREZENTACE.md#dve-podoby-poznamek).

**Nahrazuje:** část [R74](#r74-heslovite-poznamky), podle níž čas pro
vyučujícího a odkaz na oddíl kapitoly patří do DOCX; ostatní části R74
platí.

**Doklad:** autor 2026-11-17 zadal: „Můžeš z poznámek k prezentacím vymazat
odrážky s ‚časem pro vyučujícího‘ a reference typu ‚Podklad: kapitola 8,
Porovnání dvou průměrů: párová data a nezávislé skupiny, příslušný oddíl:
https://…‘.“ Po odstranění z existujících poznámek (DOCX kapitol 2–8, PPTX
kapitol 2–6) odpověděl na otázku, zda upravit i pravidlo v PREZENTACE.md,
aby je budoucí poznámky neobsahovaly: „Ano, upravit pravidlo“. Odstranění
eviduje [autorská historie](../../quarto/README.md) v záznamu z téhož dne.
