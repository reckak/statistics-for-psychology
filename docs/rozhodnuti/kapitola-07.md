# Dohody k intervalu spolehlivosti, t-testu a testu ekvivalence

[Registr rozhodnutí a aktuální platnost](../ROZHODNUTI.md) · [Pravidla evidence](../../AGENTS.md#evidence-rozhodnuti)

Níže jsou zachovány původní záznamy schválených voleb, jejich důvody a doklady. Data, rozsah a formulace se vztahují k uvedeným dohodám; záznamy mohou obsahovat později nahrazené části nebo již provedené úkoly. Aktuální platnost a hlavní místo údržby určuje řádek v registru. Staré seznamy se při běžné aktualizaci slovníku, obsahu či pracovního postupu znovu nesynchronizují; nová schválená změna dostane vlastní datovaný doklad.

<a id="r44-rozsah-kapitoly-7"></a>

## R44 — Rozsah, pořadí a zásady výkladu kapitoly 7

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r44-rozsah-kapitoly-7). Původní záznam dohody:*

**Stav:** schváleno 2026-10-17. **Rozsah:** kapitola 7 „Interval spolehlivosti pro populační průměr, jednovýběrový t-test a test ekvivalence“, její cvičení, sešit a navazující přehledy. Skutečný obsah a případné odchylky eviduje [karta kapitoly 7](../kapitoly/07-interval-t-test-ekvivalence.md#mapa-kapitola-07).

**Vymezení**

- Z-test z kapitoly 6 jen jako připomenutí a východisko intervalového odhadu; jeho výklad se neopakuje.
- Podrobně interval spolehlivosti pro populační průměr při známé a neznámé σ a vztah intervalu k p-hodnotě.
- Jednovýběrový t-test.
- Test ekvivalence vyložený pomocí intervalů: výsledek může být statisticky, ale ne věcně významný; intervaly různé šířky zasahují do různých pásem. Logika dvou jednostranných testů (TOST) a 90% intervalu je povinná, výpočet dvou p-hodnot nepovinný.
- **Mimo kapitolu:** párový t-test a t-test pro dva výběry, překrývání intervalů dvou skupin, interval pro podíl, bootstrap, bayesovské intervaly, plánování velikosti výběru, test minimálního účinku, standardizované hranice ekvivalence a korekce pro více testů.
- **Nepovinná rozšíření:** výpočet obou jednostranných testů TOST; neinferiorita; intuice, proč dosazení s zvětšuje chvosty.

**Členění (jedenáct oddílů):** od jednoho čísla k intervalu; interval při známé σ a význam 95 %; šířka a přesnost odhadu; t-rozdělení; interval s t-kvantilem; jednovýběrový t-test; interval a p-hodnota; pásmo ekvivalence a jeho zdůvodnění; test ekvivalence; čtyři kombinace výsledků; co závěr o ekvivalenci říká a jak výsledky sdělit.

**Příklady**

- Průběžný příklad navazuje na z-test kapitoly 6: test pozornosti, 25 studentů po krátkém spánku, m = 46, pevná referenční hodnota normy 50. Model populace se popisuje slovně (normální model se střední hodnotou 50 a směrodatnou odchylkou 10), bez zápisu N(·,·). Modelový předpoklad σ = 10 se výslovně odděluje od nového vstupu, výběrové s = 10.
- Druhá aplikace: Howellův příklad PDI ze souhrnů (s. 186–189), bez vytváření individuálních dat.
- Ekvivalence: online verze testu pozornosti proti pevné normě 50 s hranicemi ±3 body zdůvodněnými zamýšleným použitím. Pět smyšlených studií A–E pokrývá čtyři kombinace výsledků testu rozdílu a testu ekvivalence.

**Zásady výkladu**

- Předpoklady (nezávislý náhodný výběr z normální populace) se uvádějí už u prvních intervalů; přibližná platnost a odolnost se rozebírají později.
- Při známé σ, stejném n a stejné spolehlivosti mají všechny intervaly stejnou šířku a mění se jejich poloha. Kolísání šířky se ukazuje až u intervalů s výběrovou s. Mluví se o opakovaném vytváření intervalů z různých výběrů, ne o nové úrovni „rozdělení intervalů“. 95 % je dlouhodobé pokrytí postupu; ze 100 intervalů jich nemusí přesně 95 obsahovat μ.
- Úzký interval zachycuje malou výběrovou nejistotu, ale neodstraňuje zkreslení výběru ani systematickou chybu měření.
- Pokrytí 91,8 % se označuje jako teoretické pokrytí chybného postupu (1,96 místo t-kvantilu, n = 10) za normálního modelu, ne jako očekávaný přesný výsledek jedné simulace.
- P-hodnota vyjadřuje, jak neobvyklá je pozorovaná nebo ještě extrémnější testová statistika za nulové hypotézy a předpokladů testu. Vztah intervalu a zamítnutí platí pro odpovídající test a interval se stejnými předpoklady. U přesné rovnosti p = α se pravidlo zamítání sjednotí se zahrnutím krajních bodů; zaokrouhlené hodnoty k rozhodnutí nestačí.
- Test ekvivalence: přesné hypotézy H₀: μ ≤ μ₀ − Δ nebo μ ≥ μ₀ + Δ; H₁: μ₀ − Δ < μ < μ₀ + Δ. Každý jednostranný test na hladině 0,05; o ekvivalenci rozhodneme, jen pokud zamítnou oba. Odpovídající centrální interval má proto spolehlivost 90 %, ale celý test ekvivalence je na hladině 0,05.
- Hranice ekvivalence se volí předem a nezávisle na výsledku a zdůvodňují se konkrétním zamýšleným použitím. Symetrie hranic je volba příkladu, ne nutná vlastnost testů ekvivalence.
- Jednovýběrové porovnání s pevnou normou může podpořit ekvivalenci populačního průměru vůči této referenci; samo nedokládá zaměnitelnost verzí testu, shodu individuálních výsledků ani stejnou reliabilitu. Odhad normy z jiného výběru by přinesl další nejistotu.
- V tabulce studií se odděleně uvádí výsledek testu rozdílu, testu ekvivalence a závěr vzhledem k hranicím. U studie s intervalem celým pod dolní hranicí se nepíše obecné „věcně významný rozdíl“, ale poloha intervalu vůči hranici. Neprokázaná ekvivalence sama neprokazuje důležitý rozdíl. V obrázku se 90% a 95% intervaly zobrazují souběžně s označením jejich odlišné funkce.
- Výsledek TOST se uvádí oběma p-hodnotami, nebo se větší z nich jasně označí jako výsledná p-hodnota testu. Ukázka reportování uvádí vedle 95% intervalu také hranice ekvivalence a 90% interval.
- Neinferiorita: otázka, zda výsledek není horší o více než předem určenou mez, včetně směru škály.

**Cíle učení:** viz blok „Co budete po prostudování umět“ v kapitole; pro ekvivalenci výslovně zdůvodnit hranice, rozhodnout o ekvivalenci pomocí 90% intervalu a rozlišit čtyři kombinace výsledků. Cvičení obsahují i chybný postup, kdy autor volí hranice až podle výsledku.

**Zdroje:** Howell (kap. 7, s. 181–196) pro pořadí a PDI; Cumming a Calin-Jageman (kap. 5; s. 151–152 k zanedbatelným účinkům); Lakens (2017) a Lakens, Scheel a Isager (2018) k testu ekvivalence. Lakensovy texty a Cummingovy pasáže byly prostudovány před konečným schválením rozsahu, jak autor požadoval.

**Důvod:** kapitola uzavírá tři odkazy kapitoly 6 na „další kapitolu“ a navazuje na její poučení, že nezamítnutí není důkazem nepřítomnosti rozdílu: test ekvivalence ukazuje, jak malý rozdíl doložit.

**Nahrazuje:** stav „žádný schválený plán“ po kapitole 6 v [plánu pokračování](../kapitoly/plan-pokracovani.md#plan-dalsi-kapitoly) ve znění z 2026-10-12.

**Doklad:** autorovy pokyny 2026-10-17. Na doporučení zaměřit kapitolu 7 na průměry odpověděl: „Ano, ale asi bych v kapitole představil jen jednovýběrový z-test a t-test a podrobněji představil intervaly spolehlivosti a ukázal, jak se pojí s p-hodnotami. Také bych vysvětlil pomocí CI testy ekvivalence“ (s vlastním schématem intervalů studií A–I vůči pásmu ekvivalence). Na otázky zvolil „Povinně 90% CI (TOST)“ a neinferioritu „Jen nepovinně“. První předložený plán vrátil s pokyny, mimo jiné: „Zpřesnil bych název na ‚Interval spolehlivosti pro populační průměr, jednovýběrový t-test a test ekvivalence‘“; „Při známé σ, stejném n a stejné hladině spolehlivosti mají všechny intervaly stejnou šířku; mění se jejich poloha.“; „Předpoklady bych uvedl už u prvních intervalů“; „U TOST bych doplnil přesné hypotézy a vysvětlení 90% intervalu.“; „Zúžil bych závěr příkladu s online verzí testu.“; „U tabulky studií bych oddělil výsledky dvou testů od věcné interpretace.“; „Do cvičení bych přidal chybný postup, při němž autor zvolí hranice až podle výsledku“; „Posunul bych prostudování nových zdrojů před konečné schválení podrobného rozsahu.“ Druhou verzi vrátil s pokynem ke značení kvantilu (viz [R45](#r45-znaceni-kapitoly-7)) a po jeho zapracování plán schválil. Záznam „Kapitola 7: dohoda o obsahu“ v [historii](../../quarto/README.md#dohoda-kapitola-07).

<a id="r45-znaceni-kapitoly-7"></a>

## R45 — Značení kapitoly 7

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r45-znaceni-kapitoly-7). Původní záznam dohody:*

**Stav:** schváleno 2026-10-17. **Rozsah:** kapitola 7, přehled značení a další použití.

- Testová statistika jednovýběrového t-testu kurzivním ***t***.
- **Kvantil t-rozdělení** obdobně jako normovaný kvantil $z_p$ ([R41](kapitola-04.md#r41-zp-a-pp-graf)): dolní index nese úroveň kvantilu (podíl vlevo) i stupně volnosti, celé „0,025 (*v* = 10)“ je v dolním indexu a *v* je kurzivou. Například $t_{0{,}025\,(v=10)}$ je 2,5% kvantil t-rozdělení s 10 stupni volnosti; v průběžném příkladu $t_{0{,}975\,(v=24)}\approx2{,}064$. Ve výkladu se stupně volnosti dál vypisují slovy ([H09](../SLOVNIK.md#doklad-h09)); *v* se používá v indexu kvantilu.
- **Hranice ekvivalence** μ₀ − Δ a μ₀ + Δ, kde **Δ** je předem zvolená kladná hranice velikosti rozdílu v bodech škály. Nejde o parametr populace; symetrie je volba příkladu.
- Směrodatná chyba a její odhad podle [R29](kapitola-06.md#r29-znaceni-kapitoly-6) beze změny; p-hodnota se vypisuje slovy.
- Interval spolehlivosti nemá vlastní symbol; píše se „95% interval spolehlivosti“ a meze se uvádějí v závorce se středníkem. Zkratka CI jen v označených ukázkách reportování ([R01](spolecne-konvence.md#r01-znaceni-a-reportovani)).
- Normální model se v této kapitole popisuje slovně, aby nebylo nejasné, zda druhý argument značí směrodatnou odchylku, nebo rozptyl; konvence [R15](kapitola-04.md#r15-zapis-normalniho-modelu) se tím nemění.

**Důvod:** jednotné značení kvantilů pro normované normální a t-rozdělení; Δ podle zavedené literatury o testech ekvivalence.

**Doklad:** autorův pokyn 2026-10-17 ke druhé verzi plánu: „určitý kvantil t-rozdělení lze zapsat podobně jako u z pomocí dolního indexu, např. t0,025 (v = 10) by byl 2,5% kvantil t-rozdělení s 10 stupni volnosti, přičemž celé "0,025 (v = 10)" by bylo dolním indexem "t" i "v" by bylo kurviou.“ K popisu Δ: „U Δ bych napsal ‚předem zvolená kladná hranice velikosti rozdílu v bodech škály‘.“ Ostatní značení bylo součástí schváleného plánu.

<a id="r46-terminologie-kapitoly-7"></a>

## R46 — Terminologie kapitoly 7

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r46-terminologie-kapitoly-7). Původní záznam dohody:*

**Stav:** schváleno 2026-10-17. **Rozsah:** kapitola 7, slovníček, přehledy a další použití pojmů. Úplný seznam s anglickými ekvivalenty a alternativami je v [registru](../SLOVNIK.md#kapitola-07).

- **Bodový odhad** a **intervalový odhad**; interval spolehlivosti je druh intervalového odhadu.
- **Interval spolehlivosti** (*confidence interval*); „konfidenční interval“ jako alternativa ve slovníčku.
- **Hladina spolehlivosti** (*confidence level*) se odlišuje od hladiny významnosti.
- **Dolní a horní mez intervalu** se odlišují od hranic ekvivalence.
- **Mezní chyba odhadu** (*margin of error*) v úplném znění; neplést s hranicí ekvivalence (*equivalence margin, equivalence bound*).
- **Přesnost odhadu** (*precision*) vyjadřuje šířku intervalu, ne nepřítomnost zkreslení.
- **Pokrytí** (*coverage*): dlouhodobý podíl intervalů obsahujících parametr.
- **t-rozdělení** (*t distribution*), alternativa Studentovo rozdělení; **jednovýběrový t-test** (*one-sample t-test*).
- **Test ekvivalence** (*equivalence test*) je obecný pojem; **TOST, dva jednostranné testy** (*two one-sided tests*) je konkrétní postup, ne synonymum jakéhokoli testu ekvivalence.
- **Hranice ekvivalence** a **pásmo ekvivalence** (*equivalence bounds, equivalence region*) se stanovují předem.
- **Nejmenší věcně důležitý rozdíl** (*smallest effect size of interest, SESOI*) jako překlad navržený touto učebnicí; odlišit od velikosti účinku.
- **Neinferiorita** (*non-inferiority*) jen v nepovinném rozšíření. *Doplněk 2026-11-09:* nahrazeno termínem noninferiorita podle [R67](#r67-revize-kapitoly-7).
- Výběrová chyba ([R30](kapitola-06.md#r30-terminologie-kapitoly-6)) a stupně volnosti ([H09](../SLOVNIK.md#doklad-h09)) jsou zavedeny dříve a nemění se.

**Doklad:** terminologická tabulka byla součástí schváleného plánu 2026-10-17. Autor ji upravil pokyny: „Doplnil bych ‚intervalový odhad‘, ‚přesnost odhadu‘ a ‚výběrová chyba‘, pokud poslední termín dosud není zaveden. Preferoval bych úplné označení mezní chyba odhadu. TOST bych neuváděl jako synonymum jakéhokoli testu ekvivalence, ale jako konkrétní postup dvou jednostranných testů.“ Záznam „Kapitola 7: dohoda o obsahu“ v [historii](../../quarto/README.md#dohoda-kapitola-07).

<a id="r67-revize-kapitoly-7"></a>

## R67 — Revize terminologie a příkladů kapitoly 7

**Stav:** schváleno 2026-11-09. **Rozsah:** kapitola 7, slovníček, značení a autorský slovník. Částečně nahrazuje [R46](#r46-terminologie-kapitoly-7) v bodě „Neinferiorita“; ostatní body R46 platí.

- **Noninferiorita** (*non-inferiority*) místo „neinferiorita“: když je už „inferiorita“ cizí slovo, předpona má být také latinská. V tomtéž nepovinném rozšíření nově **superiorita**, **nonsuperiorita** a **inferiorita** (*superiority, non-superiority, inferiority*) jako jednostranné otázky vůči hranicím $\mathrm{μ}_0\pm\mathrm{Δ}$. Příklad rozšíření i úlohy 14 je trénink pozornosti, nikoli „horší“ verze testu.
- Nepovinné rozšíření o odolnosti *t*-testu zavádí **nominální** a **skutečnou hladinu významnosti** (*nominal, actual significance level*) a **liberální** a **konzervativní test** (*liberal, conservative test*). Názvy rozdělení (lognormální, smíšené normální) se nezavádějí, tvary populací se popisují slovy.
- Výběrová směrodatná odchylka průběžného příkladu je $s=11$ místo 10, aby se nekryla s modelovou σ; příklad zachovává jednostranné zamítnutí při 95% intervalu obsahujícím normu.
- Obecný zápis kvantilu pro hladinu spolehlivosti $1-\mathrm{α}$: $z_{1-\mathrm{α}/2}$ pro oboustranný interval a $z_{1-\mathrm{α}}$ pro jednostrannou mez; obdobně pro *t* podle [R45](#r45-znaceni-kapitoly-7).
- Ve výkladu „variabilita“ místo „rozptýlenost“ a „reliabilita“ místo „spolehlivost“ měření, v souladu s [registrem](../SLOVNIK.md); „striktně uvnitř“ místo „přísně uvnitř“; „neprůkazný“ výsledek místo „nerozhodný“.

**Doklad:** autorovy připomínky 2026-11-09: „Místo neinferiority bych používal noninferiorita, když už samotná inferiority je cizí slovo“, „bylo by nejlepší v rámci příkladu s pozorností uvažovat … o tom, zda nějaká intervence zlepšuje pozornost; a pak vysvětlit jak inferioritu a noninferioritu, tak superioritu a nonsuperioritu“ a požadavek na nepovinné rozšíření o odolnosti podle Wilcoxe s dopady na sílu, skutečnou alfa a CI. Hodnotu $s=11$ zvolil v otázce 2026-11-09; následně schválil plán revize, který uváděl i nové termíny.

<a id="r75-oboustranny-jednostranny-interval"></a>

## R75 — Oboustranný a jednostranný interval spolehlivosti

**Stav:** schváleno 2026-11-13 (volba vyslovena 2026-11-12). **Rozsah:** kapitola 7, slovníček, přehled značení, interaktivní vizualizace intervalu a *p*-hodnoty, prezentace a scénář kapitoly 7 a další použití. Upřesňuje [R67](#r67-revize-kapitoly-7) v bodě „jednostranná mez“; ostatní body R46 a R67 platí.

- **Oboustranný interval spolehlivosti** (*two-sided confidence interval*): má konečnou dolní i horní mez. V učebnici leží v každém chvostu α/2; v literatuře se takovému intervalu říká také **centrální** (*central, equal-tailed*). „Centrální interval“ je alternativa ve slovníčku, ve výkladu se jednou vysvětlí a dál nepoužívá.
- **Jednostranný interval spolehlivosti s horní mezí** a **jednostranný interval spolehlivosti s dolní mezí** (*one-sided confidence interval with an upper/lower bound; upper/lower confidence bound*): mají jen jednu konečnou mez, například (−∞; 49,76] nebo [42,24; ∞). Nahrazují dosavadní „horní/dolní jednostranná mez“; slovo mez zůstává pro konečný krajní bod intervalu.
- Spolehlivost se uvádí před podstatným jménem: „95% oboustranný interval“, „95% jednostranný interval s horní mezí“. Samotné „95% interval spolehlivosti“ bez přívlastku nadále znamená oboustranný interval.

**Důvod:** dosavadní dvojice „centrální interval“ a „jednostranná mez“ stavěla vedle sebe interval a jeden jeho bod. Jednotné pojmenování podle počtu konečných mezí ukazuje, že jde o tři varianty téhož postupu, a umožňuje je souběžně zobrazit ve vizualizaci intervalu a *p*-hodnoty.

**Doklad:** autor 2026-11-12 při projednávání vizualizace intervalu a *p*-hodnoty ([upřesnění R65](postupy-a-dokumentace.md#r65-upresneni-2026-11-12-interval)) požadoval zobrazit u jednostranných testů „jak noncentrální CI, tak odpovídající centrální CI s hladinou spolehlivosti 1–2alfa“. Na otázku, jak interval pojmenovat, odpověděl: „Zavedl bych ve vizualizaci i v kapitole rozlišení intervalů: Oboustranný interval spolehlivosti – má konečnou dolní i horní mez. Jednostranný interval spolehlivosti s dolní mezí – má pouze konečnou dolní mez. Jednostranný interval spolehlivosti s horní mezí – má pouze konečnou horní mez.“ K termínu „centrální“ zvolil „Alternativa + jedna věta“ a sladění prezentace a scénáře kapitoly 7 „V tomto úkolu“. Plán, který tyto volby uváděl, schválil 2026-11-13.
