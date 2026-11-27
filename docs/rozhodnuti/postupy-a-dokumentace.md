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

<a id="r32-doplneni-2026-11-27"></a>

### Doplnění R32 — rozdělení rozsáhlých autorských dokumentů (2026-11-27)

**Schválené upřesnění:**

- [PROVOZ.md](../PROVOZ.md) zůstává hlavním místem provozních návodů jako
  rozcestník se společnými příkazy, kontrolami a publikováním. Podrobné
  návody jsou v [pdf.md](../provoz/pdf.md), [ai-tutor.md](../provoz/ai-tutor.md),
  [vizualizace-a-aplikace.md](../provoz/vizualizace-a-aplikace.md)
  a [sesity.md](../provoz/sesity.md) ve složce `docs/provoz/`; dosavadní výčty
  kontrol jednotlivých stránek jsou jako stav k 2026-11-27 v
  [kontroly-stranek.md](../provoz/kontroly-stranek.md).
- Záznamy R65 a R87 včetně všech upřesnění jsou v tematickém souboru
  [Interaktivní vizualizace a statistické aplikace](vizualizace-a-aplikace.md);
  nová upřesnění obou rozhodnutí se připojují tam.
- [Autorská historie](../../quarto/README.md) obsahuje aktuální a předchozí
  měsíc. Při prvním záznamu nového měsíce se měsíc o dva zpět beze změny
  přesune do `docs/historie/RRRR-MM.md`; první archiv obsahuje září
  a říjen 2026.
- Řádky registru shrnují upřesnění odkazy pojmenovanými tématem; popis obsahu
  jednotlivých stránek zůstává v dokladech.

Přesuny jsou doslovné a příchozí odkazy vedou přímo na nové umístění.
Rozcestníkové oddíly PROVOZ.md ponechávají kotvy hlavních oddílů, původní
kotvy R65 a R87 zachovává odkazovací oddíl v tomto souboru a kotvy
archivovaných záznamů rejstřík na konci autorské historie. Kotvy pododdílů
provozního návodu a neodkazované kotvy nadpisů archivovaných záznamů se na
původní adrese nezachovávají; původní znění je v Gitu.

**Důvod:** dokumenty se čtou cíleně podle úkolu, ale rostly s každou
vizualizací a aplikací; menší soubory snižují množství současně načítaného textu.

**Doklad:** autor dne 2026-11-27 na otázku, které rozsáhlé dokumenty do úpravy
zahrnout, zvolil „PROVOZ.md rozdělit“, „Vyčlenit R65 a R87“, „Archiv historie
README“ a „Zkrátit řádky registru“; u AGENTS.md zvolil „Nechat beze změny“.
K plánu připomněl mimo jiné „Vymezit hranici mezi živým návodem a historickým
výčtem kontrol“ a „doplnil bych, kdy se archivují další uzavřené měsíce“;
upravený plán schválil téhož dne. Provedení a kontroly eviduje
[autorská historie](../../quarto/README.md#reorganizace-dokumentace-2026-11-27).

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

## Přesunutý záznam R65 (část „Interaktivní vizualizace“)

Záznam R65 včetně všech upřesnění je od 2026-11-27 v souboru [Interaktivní vizualizace
a statistické aplikace](vizualizace-a-aplikace.md#r65-interaktivni-vizualizace)
([doplnění R32](#r32-doplneni-2026-11-27)). Původní kotvy vedou sem; položky vedou na tutéž část záznamu:

- <a id="r65-interaktivni-vizualizace"></a><a id="r65--část-interaktivní-vizualizace"></a>[R65 — Část „Interaktivní vizualizace“](vizualizace-a-aplikace.md#r65-interaktivni-vizualizace)
- <a id="upřesnění-2026-11-05--podoba-pilotní-vizualizace"></a>[Upřesnění 2026-11-05 — Podoba pilotní vizualizace](vizualizace-a-aplikace.md#upřesnění-2026-11-05--podoba-pilotní-vizualizace)
- <a id="r65-upresneni-2026-11-06"></a><a id="upřesnění-2026-11-06--vizualizace-ploch-pod-normální-křivkou"></a>[Upřesnění 2026-11-06 — Vizualizace ploch pod normální křivkou](vizualizace-a-aplikace.md#r65-upresneni-2026-11-06)
- <a id="r65-upresneni-2026-11-06-sila"></a><a id="upřesnění-2026-11-06--vizualizace-statistické-síly"></a>[Upřesnění 2026-11-06 — Vizualizace statistické síly](vizualizace-a-aplikace.md#r65-upresneni-2026-11-06-sila)
- <a id="r65-upresneni-2026-11-06-vrp"></a><a id="upřesnění-2026-11-06--rozšíření-vizualizace-výběrového-rozdělení-průměru"></a>[Upřesnění 2026-11-06 — Rozšíření vizualizace výběrového rozdělení průměru](vizualizace-a-aplikace.md#r65-upresneni-2026-11-06-vrp)
- <a id="r65-upresneni-2026-11-06-binom"></a><a id="upřesnění-2026-11-06--vizualizace-binomického-rozdělení"></a>[Upřesnění 2026-11-06 — Vizualizace binomického rozdělení](vizualizace-a-aplikace.md#r65-upresneni-2026-11-06-binom)
- <a id="r65-upresneni-2026-11-06-bayes"></a><a id="upřesnění-2026-11-06--vizualizace-bayesovy-věty"></a>[Upřesnění 2026-11-06 — Vizualizace Bayesovy věty](vizualizace-a-aplikace.md#r65-upresneni-2026-11-06-bayes)
- <a id="r65-upresneni-2026-11-07-posun"></a><a id="upřesnění-2026-11-07--vizualizace-posunu-a-změny-jednotek"></a>[Upřesnění 2026-11-07 — Vizualizace posunu a změny jednotek](vizualizace-a-aplikace.md#r65-upresneni-2026-11-07-posun)
- <a id="r65-upresneni-2026-11-12-t"></a><a id="upřesnění-2026-11-12--vizualizace-t-rozdělení-a-normovaného-normálního"></a>[Upřesnění 2026-11-12 — Vizualizace *t*-rozdělení a normovaného normálního](vizualizace-a-aplikace.md#r65-upresneni-2026-11-12-t)
- <a id="r65-upresneni-2026-11-12-interval"></a><a id="upřesnění-2026-11-12--vizualizace-intervalu-spolehlivosti-a-p-hodnoty"></a>[Upřesnění 2026-11-12 — Vizualizace intervalu spolehlivosti a *p*-hodnoty](vizualizace-a-aplikace.md#r65-upresneni-2026-11-12-interval)
- <a id="r65-upresneni-2026-11-13-pokryti"></a><a id="upřesnění-2026-11-13--vizualizace-pokrytí-intervalu-spolehlivosti"></a>[Upřesnění 2026-11-13 — Vizualizace pokrytí intervalu spolehlivosti](vizualizace-a-aplikace.md#r65-upresneni-2026-11-13-pokryti)
- <a id="r65-upresneni-2026-11-13-cohen"></a><a id="upřesnění-2026-11-13--vizualizace-cohenova-d"></a>[Upřesnění 2026-11-13 — Vizualizace Cohenova d](vizualizace-a-aplikace.md#r65-upresneni-2026-11-13-cohen)
- <a id="r65-upresneni-2026-11-19-parovani"></a><a id="upřesnění-2026-11-19--vizualizace-přínosu-párování"></a>[Upřesnění 2026-11-19 — Vizualizace přínosu párování](vizualizace-a-aplikace.md#r65-upresneni-2026-11-19-parovani)
- <a id="r65-upresneni-2026-11-19-intervaly"></a><a id="upřesnění-2026-11-19--vizualizace-dvou-intervalů-a-intervalu-rozdílu"></a>[Upřesnění 2026-11-19 — Vizualizace dvou intervalů a intervalu rozdílu](vizualizace-a-aplikace.md#r65-upresneni-2026-11-19-intervaly)
- <a id="r65-upresneni-2026-11-20-chi"></a><a id="upřesnění-2026-11-20--vizualizace-tabulky-četností-a-testu-chí-kvadrát"></a>[Upřesnění 2026-11-20 — Vizualizace tabulky četností a testu chí-kvadrát](vizualizace-a-aplikace.md#r65-upresneni-2026-11-20-chi)
- <a id="r65-upresneni-2026-11-20-miry"></a><a id="upřesnění-2026-11-20--vizualizace-rozdílu-podílů-poměru-rizik-a-poměru-šancí"></a>[Upřesnění 2026-11-20 — Vizualizace rozdílu podílů, poměru rizik a poměru šancí](vizualizace-a-aplikace.md#r65-upresneni-2026-11-20-miry)
- <a id="r65-upresneni-2026-11-20-nabidka"></a><a id="upřesnění-2026-11-20--část-s-vizualizacemi-je-v-nabídce-sbalená"></a>[Upřesnění 2026-11-20 — Část s vizualizacemi je v nabídce sbalená](vizualizace-a-aplikace.md#r65-upresneni-2026-11-20-nabidka)
- <a id="r65-upresneni-2026-11-23-korelace"></a><a id="upřesnění-2026-11-23--vizualizace-korelace-v-bodovém-grafu"></a>[Upřesnění 2026-11-23 — Vizualizace korelace v bodovém grafu](vizualizace-a-aplikace.md#r65-upresneni-2026-11-23-korelace)
- <a id="r65-upresneni-2026-11-23-korelace-upravy"></a>[Úpravy vizualizace korelace před sloučením (2026-11-23)](vizualizace-a-aplikace.md#r65-upresneni-2026-11-23-korelace-upravy)
- <a id="r65-upresneni-2026-11-25-interval-podilu"></a><a id="upřesnění-2026-11-25--vizualizace-waldova-a-wilsonova-intervalu-pro-podíl"></a>[Upřesnění 2026-11-25 — Vizualizace Waldova a Wilsonova intervalu pro podíl](vizualizace-a-aplikace.md#r65-upresneni-2026-11-25-interval-podilu)

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

## Přesunutý záznam R87 (část „Statistické aplikace“)

Záznam R87 včetně všech upřesnění a doplnění je od 2026-11-27 v souboru [Interaktivní vizualizace
a statistické aplikace](vizualizace-a-aplikace.md#r87-statisticke-aplikace)
([doplnění R32](#r32-doplneni-2026-11-27)). Původní kotvy vedou sem; položky vedou na tutéž část záznamu:

- <a id="r87-statisticke-aplikace"></a><a id="r87--část-statistické-aplikace-a-pilotní-test-jednoho-podílu"></a>[R87 — Část „Statistické aplikace“ a pilotní test jednoho podílu](vizualizace-a-aplikace.md#r87-statisticke-aplikace)
- <a id="r87-upresneni-2026-11-25"></a><a id="upřesnění-2026-11-25-bez-excelu-výchozí-stav-a-barvy-tabulky-výsledků"></a>[Upřesnění 2026-11-25: bez Excelu, výchozí stav a barvy tabulky výsledků](vizualizace-a-aplikace.md#r87-upresneni-2026-11-25)
- <a id="r87-upresneni-2026-11-26"></a><a id="upřesnění-2026-11-26-aplikace-test-dvou-podílů"></a>[Upřesnění 2026-11-26: aplikace Test dvou podílů](vizualizace-a-aplikace.md#r87-upresneni-2026-11-26)
- <a id="r87-upresneni-2026-11-27"></a><a id="upřesnění-2026-11-27-aplikace-test-jednoho-průměru"></a>[Upřesnění 2026-11-27: aplikace Test jednoho průměru](vizualizace-a-aplikace.md#r87-upresneni-2026-11-27)
- <a id="r87-doplneni-2026-11-27-pas"></a><a id="doplnění-2026-11-27-výpočet-pásu-tail-sensitive"></a>[Doplnění 2026-11-27: výpočet pásu tail-sensitive](vizualizace-a-aplikace.md#r87-doplneni-2026-11-27-pas)

<a id="r88-bez-opakovani"></a>

## R88 — Doklad, historie, návod a kontroly bez opakování

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r88-bez-opakovani). Původní záznam dohody:*

**Stav:** schváleno 2026-11-27. **Rozsah:** nové záznamy o interaktivních
vizualizacích a statistických aplikacích; starší záznamy se nemění.

**Volba:** doklad zachycuje schválený rozsah a důvody podstatných voleb.
Historie odkazuje na doklad a uvádí provedení, odchylky a výsledky skutečně
provedených kontrol. Provozní návod uvádí společný postup a příkazy.
Automatizované scénáře jsou v příslušných kontrolních skriptech
(`quarto/_verification/check-html.cjs`, u aplikací také
`scripts/check-stat-lib.mjs` a referenční výpočty `scripts/app-<tema>.R`).
Aktuální znění pravidla je v [AGENTS.md](../../AGENTS.md#evidence-rozhodnuti).

**Důvod:** popis každé nové stránky se dosud opakoval v dokladu, v autorské
historii a jako výčet kontrol v provozním návodu; tři souběžné popisy
zvětšovaly dokumenty a mohly se rozcházet.

**Doklad:** autor dne 2026-11-27 na otázku, zda u budoucích vizualizací
a aplikací zapisovat stručněji, zvolil „Ano, bez opakování“. Znění pravidla
navrhl v připomínkách k plánu: „Doklad zachycuje schválený rozsah a důvody
podstatných voleb. Historie odkazuje na doklad a uvádí provedení, odchylky
a výsledky skutečně provedených kontrol. Provozní návod uvádí společný postup
a příkazy. Automatizované scénáře jsou v příslušných kontrolních skriptech.“
Upravený plán schválil téhož dne.
