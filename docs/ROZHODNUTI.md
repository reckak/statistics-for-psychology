# Platná autorská rozhodnutí

Tento přehled zachycuje doložené konvence, jejich důvody a rozsah platnosti.
Společná pravidla zůstávají v [AGENTS.md](../AGENTS.md), obsah a návaznosti
v [osnově](OSNOVA.md). Úplné definice a značení jsou ve studentských
[pojmech](../quarto/slovnicek.qmd) a [přehledu značení](../quarto/znaceni.qmd).
Tyto přehledy zde nekopíruj.

U každého nového záznamu uveď stav **návrh**, **schváleno** nebo **nahrazeno**,
rozsah, důvod a doklad dohody (autorský záznam, PR nebo konkrétní zadání).
Návrhy nepoužívej jako schválené konvence. Při změně označ nahrazovaný
záznam a odkaž na nový; samotné novější datum není dokladem schválení.
Historické záznamy v `quarto/README.md` zachovej. Zdejší výběr není úplný
slovníček ani soupis všech redakčních úprav.

<a id="r01-znaceni-a-reportovani"></a>

## R01 — Výpočetní značení a odborné reportování

**Stav:** schváleno. **Rozsah:** výklad a výpočty učebnice versus označené
ukázky odborného reportování podle APA 7.

Výpočetní značení zůstává beze změny, zejména kurzivní *m* pro průměr
a *s* pro směrodatnou odchylku. Ukázky reportování mohou používat kurzivní
*M*, *Mdn*, *SD*, *N* a *n* s vysvětlením jejich vztahu ke značení učebnice.
Značky APA nenahrazují výpočetní značení v okolním výkladu.
MeanAD a MedAD jsou schválené rozlišující zkratky pro průměrnou absolutní
odchylku od průměru a medián absolutních odchylek od mediánu; nejsou důvodem
k obecnému přejmenování výběrových charakteristik velkými písmeny.

**Důvod:** umožnit čtení a psaní odborné zprávy a zabránit nejednoznačnému
používání zkratky MAD, při zachování konzistentního výpočetního zápisu.
Toto vymezení nahrazuje dřívější větu instrukcí, že nejsou schválené výjimky.

**Doklad:** autorský záznam „Kapitola 3: reportování APA, transformace
a shodné momenty“ (2026-10-09) a „Kapitola 3: kumulativní kvantily,
stupně volnosti a robustní shrnutí“ (2026-10-09) v
[historii](../quarto/README.md); aktuální
[ukázky APA](../quarto/kapitola_03.qmd#sec-reportovani-apa)
a [rozlišení zkratek](../quarto/kapitola_03.qmd#sec-prumerna-absolutni).
Výslovné vymezení v instrukcích bylo dohodnuto při jejich revizi 2026-10-10.

<a id="r02-indexy-a-cetnosti"></a>

## R02 — Indexy a názvy četností

**Stav:** schváleno. **Rozsah:** četnosti, data a navazující výpočty.

Index *i* označuje jednotlivá pozorování; *j* kategorie, hodnoty,
intervaly či skupiny. Při pojmenování veličin používáme absolutní,
relativní, kumulativní absolutní a kumulativní relativní četnost.
Slovo „počet“ zůstává přirozenou součástí definic, interpretací a názvů
proměnných. Rozlišení indexů nahrazuje původní použití *i* pro kategorie
v prvním znění kapitoly 2.

**Důvod:** odlišit jednotlivé záznamy od souhrnů a sjednotit názvy veličin.
**Doklad:** záznamy „Kapitola 2: indexy, procenta a výlučnost kategorií“
a „Kapitola 2: sjednocení názvů četností“ (2026-10-04) v
[historii](../quarto/README.md); [výklad četností](../quarto/kapitola_02.qmd#sec-od-zaznamu-k-cetnostem).

<a id="r03-hranice-intervalu"></a>

## R03 — Hranice třídních intervalů

**Stav:** schváleno. **Rozsah:** hlavní příklady, grafy a sešit kapitoly 2.

Používáme intervaly s dolní mezí mimo interval a horní mezí včetně.
Opačná konvence zůstává vysvětlená jako srovnání, nikoli jako souběžná
výchozí volba. Při práci s jinými daty musí být pokrytí krajních hodnot
výslovně určeno: lze začít pod minimem nebo výslovně zahrnout dolní mez
prvního intervalu. Toto zahrnutí není automatické pravidlo všech příkladů.

**Důvod:** sjednotit příklady a reprodukovatelné zařazování hraničních hodnot.
Tato dohoda nahrazuje dřívější výchozí konvenci kapitoly 2.
**Doklad:** záznam „Kapitola 2: horní mez včetně v tabulkách a grafech“
(2026-10-05) v [historii](../quarto/README.md);
[aktuální výklad hranic](../quarto/kapitola_02.qmd#sec-hranice-intervalu).

<a id="r04-kvantily"></a>

## R04 — Kvantily a krabicový graf

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
[historii](../quarto/README.md); [kvantily](../quarto/kapitola_03.qmd#sec-kvantily)
a [boxplot](../quarto/kapitola_03.qmd#sec-boxplot).

<a id="r05-zaokrouhlovani"></a>

## R05 — Zaokrouhlování a jazyk reportování

**Stav:** schváleno. **Rozsah:** výpočetní příklady a výsledné zprávy,
s rozlišením jejich účelu.

Mezivýpočty nezaokrouhlujeme. V četnostních příkladech zobrazujeme podíly
na tři desetinná místa a procenta zpravidla na jedno. U ostatních výsledků
kapitoly 3 je výchozí přesnost zpravidla dvě desetinná místa; konkrétní
zadání a účel sdělení mohou vyžadovat jinou přesnost.
Pro odborné reportování se řídíme vysvětlenými pravidly příslušného oddílu,
nikoli mechanickým přenosem výpočetní přesnosti.

Český výklad používá desetinnou čárku. Označená anglická ukázka APA
zachovává anglickou typografii. Česká ukázka se značkami APA odděluje
statistiky středníky; jde o místní přizpůsobení, nikoli univerzální
požadavek APA. Také jedno desetinné místo u procent je místní konvence.

**Důvod:** rozlišit přesnost výpočtu, vhodnou prezentaci výsledku a jazykové
konvence bez rozporu mezi výkladem a odbornou ukázkou.
**Doklad:** „Kapitola 2: četnosti a grafy“ (2026-09-28), „Kapitola 3:
ukazatele polohy a variability“ (2026-10-05), „Kapitola 3: reportování APA,
transformace a shodné momenty“ a „Kapitola 3: české reportování a zpřesnění
výkladu“ (2026-10-09) v [historii](../quarto/README.md);
[četnosti](../quarto/kapitola_02.qmd#sec-zaokrouhlovani-02)
a [reportování](../quarto/kapitola_03.qmd#sec-reportovani-apa).

<a id="r06-robustni-shrnuti"></a>

## R06 — Konvence robustního shrnutí

**Stav:** schváleno. **Rozsah:** příklady kapitoly 3 a jejich další použití.

MedAD používáme bez škálovací konstanty (interně v R `constant = 1`).
U ořezání a winsorizace udáváme podíl pro každý konec zvlášť a počet
upravovaných hodnot zaokrouhlujeme dolů. U malého souboru proto skutečný
podíl upravených hodnot nemusí být roven nominálně zvolenému podílu.

**Důvod:** předejít nepozorované změně výsledku při použití jiných
programových výchozích nastavení a přesně popsat postup.
**Doklad:** „Kapitola 3: ukazatele polohy a variability“ (2026-10-05)
a „Kapitola 3: kumulativní kvantily, stupně volnosti a robustní shrnutí“
(2026-10-09) v [historii](../quarto/README.md);
[výklad](../quarto/kapitola_03.qmd#sec-odolne-shrnuti).

<a id="r07-normovane-normalni"></a>

## R07 — Normované normální rozdělení

**Stav:** schváleno 2026-10-10. **Rozsah:** návrh kapitoly 4, její budoucí
výklad a další použití pojmu v učebnici a souvisejících materiálech.

Pro *standard normal distribution* používáme **normované normální
rozdělení**. Alternativy „standardní normální rozdělení“ a „standardizované
normální rozdělení“ uvádíme ve slovníčku, nikoli jako střídající se
synonyma ve výkladu. Jde o normální rozdělení s průměrem 0 a směrodatnou
odchylkou 1; samotná standardizace nenormálních dat normalitu nevytváří.

**Důvod:** zavedené české užití a jazyková přirozenost. Do budoucího hesla
slovníčku patří vysvětlení, že „standardní normální rozdělení“ je
doslovnější překlad anglického názvu, ale kvůli blízkému běžnému významu
slov „standardní“ a „normální“ může spojení působit kostrbatě. Toto
hodnocení je redakčním zdůvodněním volby, nikoli tvrzením o odborné
nesprávnosti alternativy.

**Nahrazuje:** původní neschválené doporučení v návrhu osnovy preferovat
„standardní normální rozdělení“ kvůli návaznosti na standardizaci.
Ostatní navržené termíny ani podrobný rozsah kapitoly se tím neschvalují.

**Doklad:** výslovný pokyn autora „používejme tedy ‚normované normální
rozdělení‘“ a požadavek upravit osnovu, ponechat alternativy do slovníčku
a doplnit jazykové zdůvodnění; [osnova kapitoly](OSNOVA.md).

<a id="r08-terminologie-kapitoly-4"></a>

## R08 — Zbývající terminologie kapitoly 4

**Stav:** schváleno 2026-10-10. **Rozsah:** příprava a budoucí výklad
kapitoly 4 a navazující přehledy. Aktuální seznam názvů a anglických
ekvivalentů obsahuje [osnova](OSNOVA.md); tento záznam určuje rozhodující
rozlišení a doklad schválení, nenahrazuje studentský slovníček.

- Používat jednoduchý název **IQ-skór / IQ-skóry** pro zde probírané
  měřítko 100/15. Vysvětlit, že jej lze použít i mimo inteligenční testy,
  ale samotný převod nemění měřenou vlastnost. V neinteligenčním příkladu
  je vhodné „výsledek vyjádřený na škále IQ-skórů“.
- Používat **standardní subtestový skór** místo původně navrženého
  „vážený subtestový skór“. Při ukázce škály 10/3 uvést její parametry,
  nepovažovat je za obecnou definici anglického scaled score.
  **Vážený skór** zůstává alternativou ve slovníčku a vysvětlenou zmínkou
  při prvním výkladu: zde nejde o vážený součet nebo průměr položek
  či subškál, ale o převod hrubého výsledku podle norem na společnou škálu.
- Ostatní navržené názvy a rozlišení autor schválil: hrubý skór,
  referenční skupina versus normativní soubor, z-skór a standardizace,
  normální rozdělení, hustota pravděpodobnosti, distribuční funkce,
  standardní skór jako širší označení, T-skór, sten a stanin,
  normalizace rozdělení v přesně vymezeném významu a normální Q–Q graf.
  Chvost rozdělení byl již zaveden, nejde o nové rozhodnutí.

**Důvod:** srozumitelné názvy bez zavádějící představy vážení a bez
záměny měřítka skóru s měřeným konstruktem. Standardizaci na z-skóry
odlišit od normalizace přes pořadí i širší standardizace metody.

**Doklad:** autorův návrh názvu IQ-skóry s upozorněním na použití mimo
inteligenční testy, následné přijetí doporučení „standardní subtestové
skóry“ a výslovné „Ano, souhlasím. Zbytek terminologie je podle mě
v pořádku.“ Toto potvrzení se týká terminologie; neoznačuje za schválené
nové symboly ani konečný rozsah nepovinných témat. Nahrazuje příslušné
neschválené názvy v původním návrhu osnovy; R07 zůstává v platnosti.

<a id="r09-kapitola-4-model-qq"></a>

## R09 — Zápis normálního modelu a povinné Q–Q grafy

**Stav:** schváleno 2026-10-10. **Rozsah:** kapitola 4 a navazující přehledy.
Souhlas s posloupností, většinou předložených doporučení a výslovné
zahájení tvorby uzavírají přípravu kapitoly. Autor změnil dvě části návrhu:
zápis **N(μ, σ²)** se zařazuje nyní a normální **Q–Q graf je povinný**
včetně čtení i ukázky tvorby, společně s dalšími způsoby posouzení modelu.
Nahrazuje původní návrhy odložit zápis a zařadit Q–Q jen nepovinně.

Používáme kurzivní z, z_i a velké T pro T-skór, stojaté μ a σ pro
populační/modelové parametry. Druhý argument N je rozptyl σ²; Excel
NORM.DIST a NORM.INV naproti tomu přijímá směrodatnou odchylku.
Zachováváme výběrové m, s, již zavedené x_i, i, n a p pro podíl/úroveň
kvantilu. Nezavádíme zde zápis náhodných veličin ani P(…), Φ a Φ⁻¹.

**Provedení schválené konstrukce:** Q–Q graf má teoretické normální
kvantily vodorovně, seřazené skóry svisle. Používá středy pořadových dílků
p = (i − 0,5)/n a orientační přímku m + sz. Jde o autorskou volbu jedné
platné konstrukce v rámci schváleného rozsahu, nikoli o tvrzení, že autor
výslovně vybral tento algoritmus. Text vysvětluje alternativy a odlišení
od percentilového pořadí a PERCENTIL.INC. Steny/staniny v učebních tabulkách
navazují na R03 (dolní mez vyloučená, horní zahrnutá); reálné normy se
vyhodnocují podle konkrétního manuálu.

**Doklad:** „zápis N(μ, σ²) bych neodkládal, ale zařadil“;
„normální Q–Q graf, jeho čtení i ukázku tvorby bych zařadil jako povinnou
část kapitoly společně s jinými způsoby toho, jak posoudit, zda je normální
model přiměřený“; „S posloupností souhlasím“ a souhlas s tvorbou kapitoly 4.

<a id="r10-terminologie-kapitoly-1"></a>

## R10 — Terminologie výběru, přidělení a rolí proměnných

**Stav:** schváleno 2026-10-11. **Rozsah:** kapitola 1, slovníček a další
použití těchto pojmů v učebnici a souvisejících materiálech.

- **Pravděpodobnostní výběr** (*probability sampling*) je hlavní termín
  pro výběr, při němž má každý případ populace známou a nenulovou
  pravděpodobnost vybrání. „Náhodný výběr“ (*random sampling*) uvádíme
  jako alternativu. „Prostý náhodný výběr“ zůstává. Obecná spojení typu
  „při náhodném výběru jednoho případu“ v dalších kapitolách se nemění.
- **Náhodné přidělení do podmínek** (*random assignment*) nahrazuje
  dosavadní „náhodné rozdělení do podmínek“, aby se pojem nepletl
  s pravděpodobnostním rozdělením. Starší tvar zůstává mezi alternativami
  ve slovníčku.
- **Odhadovaná (predikovaná) proměnná** (*predictand*) nahrazuje chybný
  tvar „predikant“; „prediktand“ uvádíme jako alternativu. Kritérium
  i odhadovaná proměnná zůstávají v hlavním textu kapitoly 1.
- Pro část populace zahrnutou do studie používáme důsledně **výběr**.
  „Výzkumný soubor“ a „vzorek“ uvádíme jen při zavedení pojmu a ve
  slovníčku. Slovo „soubor“ zůstává pro datový soubor či vymezenou
  množinu případů.
- Model měření, posuvník s verbálními kotvami a spor o čísla na dresech
  jsou v kapitole 1 nepovinným rozšířením.

**Důvod:** přesnost názvu vůči definici, odlišení od rozdělení ve smyslu
*distribution*, jazyková správnost a jednotné označení bez střídání
synonym; snížení počtu povinných pojmů úvodní kapitoly.

**Nahrazuje:** termíny „náhodný výběr“ jako hlavní označení, „náhodné
rozdělení do podmínek“ a „predikant“ z původního znění kapitoly 1
a ze záznamu „Kapitola 1: role proměnných“ (2026-10-05).

**Doklad:** výslovné pokyny autora při revizi kapitoly 1 dne 2026-10-11:
hlavní překlad „odhadovaná (predikovaná) proměnná“ se správným tvarem
prediktand; „používal [bych] termín výběr“; „jako hlavní termín bych
používal pravděpodobnostní výběr a náhodný uvedl jako alternativu“;
„náhodné přidělení“ místo „náhodné rozdělení“ a volba doplňku
„do podmínek“; přesun tří témat do nepovinného rozšíření. Záznam
„Kapitola 1: revize po posouzení“ v [historii](../quarto/README.md).

## Návrhy a další rozhodnutí

Při založení tohoto dokumentu se nepřidávají nové statistické konvence.
Budoucí návrhy uváděj samostatně se stavem **návrh** a povyšuj je na
schválené až po dohodě s autorem. Koncepce nových kapitol patří do
[osnovy](OSNOVA.md); průběžné výsledky kontrol do autorské historie.

<a id="r11-pracovni-vetve"></a>

## R11 — Jedna aktivní větev na kapitolu

**Stav:** schváleno. **Rozsah:** celý repozitář a budoucí práce s Gitem.

Používáme nejvýše jednu aktivní větev `codex/chapter-NN` pro každou
kapitolu a `codex/other` pro společné změny. Související aktualizace
přehledů patří ke kapitole. Dílčí úpravy rozlišují commity a PR.
Po sloučení a ověření zachování změn se pracovní větev odstraní;
při další práci se stejný název znovu založí z aktuálního `origin/main`.
Úplná pravidla bezpečného úklidu stanoví [AGENTS.md](../AGENTS.md#git-a-dokončení-práce).

**Důvod:** přehledný seznam aktivní práce bez hromadění větví pro každou
redakční úpravu. Nahrazuje dosavadní pravidlo nových tematických názvů
po každém sloučení a samostatných tematických větví pro infrastrukturu.

**Doklad:** uživatelův návrh jedné větve na kapitolu a větve „other“
a výslovné zadání ze dne 2026-10-11 upravit instrukce a uklidit staré
větve po prověření výjimek; podrobnosti v autorském záznamu níže
v [historii](../quarto/README.md).

<a id="r12-nazorne-vizualizace"></a>

## R12 — Názorné vizualizace ve výkladu

**Stav:** schváleno. **Rozsah:** výkladové kapitoly učebnice.

Diagramy, schémata a grafy zařazujeme tam, kde pomáhají pochopit pojem,
vztah mezi pojmy nebo princip postupu. Vždy je propojujeme s výkladem;
jejich počet se řídí didaktickým přínosem. Podrobné pravidlo je v
[AGENTS.md](../AGENTS.md#didaktika-a-jazyk).

**Důvod:** podpořit konceptuální porozumění názorným zobrazením.
**Doklad:** výslovné zadání autora ze dne 2026-10-11 doplnit toto pravidlo
s příkladem schématu výběru z populace a přidělení do podmínek v kapitole 1.
