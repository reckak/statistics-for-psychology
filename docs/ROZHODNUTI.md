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

## Návrhy a další rozhodnutí

Při založení tohoto dokumentu se nepřidávají nové statistické konvence.
Budoucí návrhy uváděj samostatně se stavem **návrh** a povyšuj je na
schválené až po dohodě s autorem. Koncepce nových kapitol patří do
[osnovy](OSNOVA.md); průběžné výsledky kontrol do autorské historie.
