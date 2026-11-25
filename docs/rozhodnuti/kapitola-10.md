# Dohody ke korelaci

[Registr rozhodnutí a aktuální platnost](../ROZHODNUTI.md) · [Pravidla evidence](../../AGENTS.md#evidence-rozhodnuti)

Níže jsou zachovány původní záznamy schválených voleb, jejich důvody a doklady. Data, rozsah a formulace se vztahují k uvedeným dohodám; záznamy mohou obsahovat později nahrazené části nebo již provedené úkoly. Aktuální platnost a hlavní místo údržby určuje řádek v registru. Staré seznamy se při běžné aktualizaci slovníku, obsahu či pracovního postupu znovu nesynchronizují; nová schválená změna dostane vlastní datovaný doklad.

<a id="r71-rozsah-kapitoly-10"></a>

## R71 — Rozsah, pořadí a zásady výkladu kapitoly 10

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r71-rozsah-kapitoly-10). Původní záznam dohody:*

**Stav:** schváleno 2026-11-09. **Rozsah:** kapitola 10 „Korelace — souvislost dvou proměnných, její velikost a nejistota“ (pracovní název), její cvičení, sešit a navazující přehledy. Kapitola dosud není napsána; skutečný obsah a odchylky bude evidovat karta kapitoly.

**Vymezení**

- **Směr:** kapitola je jen o korelaci. Jednoduchá regrese (přímka, predikce, rezidua) a výklad koeficientu determinace patří do případné následující kapitoly, jejíž rozsah schválen není.
- **Povinně:** Pearsonovo *r*, Spearmanův koeficient a Kendallovo τ (hlavní varianta τ<sub>b</sub>, τ<sub>a</sub> k vysvětlení principu), u všech tří výpočet, test a interval spolehlivosti. Pro Pearsonovo *r* klasický test s *n* − 2 stupni volnosti a přibližný interval přes Fisherovu transformaci; pro pořadové koeficienty permutační test nezávislosti a percentilový bootstrapový interval z výběru celých dvojic s vracením.
- **Nepovinná rozšíření:** interval BCa; porovnání dvou nezávislých Pearsonových korelací; vzorec rozptylu rozdílů párových dat přes *r*; převod Cohenova *d* na bodově biseriální *r* správným vzorcem. Test ekvivalence pro *r* jen po přečtení příslušného oddílu Lakense (2017) a nové dohodě.
- **Mimo kapitolu:** regrese a *r*²; parciální a semiparciální korelace; latentní (biseriální, tetrachorické, polychorické) korelace jen zmínkou; korekce na chybu měření; porovnání závislých korelací; analýza síly a plánování velikosti výběru; Kendallovo W; slovní pásma síly korelace (obdobně [R56](kapitola-06.md#r56-p-hodnota-cohen)); další samostatná interaktivní vizualizace.

**Členění (třináct oddílů ve třech blocích: porozumění koeficientům → inference → interpretace a volba postupu):** jakou otázku korelace zodpovídá (kontrast relativního postavení a průměrné změny, návaznost na párová data kapitoly 8); co poznáme z bodového grafu; kovariance; Pearsonovo *r* jako standardizovaná kovariance a jeho čtení v kontextu; Spearmanův koeficient; Kendallovo τ; co potřebujeme pro zobecnění; test a interval pro Pearsonovo *r*; permutační test pro pořadové koeficienty; bootstrapový interval pro pořadové koeficienty; co může změnit pozorovanou korelaci; jak zvolit postup a sdělit výsledek; korelace s dichotomickou proměnnou (bodově biseriální *r* a φ; při blížícím se limitu slov se připojí k předchozímu oddílu). Dále shrnutí s osmi myšlenkami a cvičení.

**Příklady, sešit a cvičení**

- Kontexty: úzkost před testem a výkon (metrická data; šest osob pro ruční výpočty, větší soubor pro inferenci), vnímaný stres a kvalita spánku (ordinální data se shodnými hodnotami), spánková data kapitoly 8 a kontrastní příklady, které vždy mění jednu vlastnost dat.
- Sešit `data/kapitola_10.xlsx`: oddělené vstupy a komentované výpočty, klasifikace dvojic pro Kendallovo τ, průměrná pořadí, Pearsonova inference; u permutací a bootstrapu jeden úplný krok a soubor výsledků opakování. Pevné reprodukovatelné indexy, oboustranné testy, hladina 0,05, 95% intervaly; bez R, maker a doplňků.
- **Počet opakování a proveditelnost:** cílem je 9 999 opakování. Před psaním kapitoly se ověří prototypem sešitu; neunese-li jej sešit, obsahuje menší počet (např. 1 999) a vedle hotové výsledky 9 999 opakování.
- 16 základních a 2 nepovinná cvičení: grafy a volba koeficientu; kovariance a *r*; Spearman bez shod a se shodami; τ<sub>a</sub> a τ<sub>b</sub>; Pearsonova inference a vliv velikosti výběru; permutační testy; bootstrapové intervaly; kritické posouzení analýzy a úplná zpráva; nepovinně BCa a porovnání dvou nezávislých *r*.

**Zásady výkladu**

- ***r* a jeho čtení:** povinně znaménko a absolutní velikost, dokonalý lineární vztah bez totožných hodnot, neměnnost při posunu a kladné změně jednotek, obrácení znaménka při obrácení škály, nedefinovaný koeficient bez variability. *r* není procento vztahu; interpretace v kontextu oboru a účelu bez univerzálních slovních pásem.
- **Reliabilita a validita (částečné rozšíření [R55](kapitola-01.md#r55-reliabilita-validita)):** korelace jako koeficient reliability při opakovaném měření a jako doklad validity (korelace s kritériem) krátce povinně, včetně nuly jako nevhodné referenční hodnoty. Další koeficienty reliability a podrobné druhy reliability a validity zůstávají mimo.
- **Spearmanův koeficient** jako Pearsonova korelace průměrných pořadí; ne jako automatická volba po zamítnutí normality ani nástroj na libovolnou nelinearitu.
- **Kendallovo τ:** rozlišit počet lidí a počet dvojic *n*(*n* − 1)/2; dvojice nejsou nezávislá pozorování. Pravděpodobnostní výklad τ<sub>a</sub> nepřenášet bez vysvětlení na τ<sub>b</sub>; nižší hodnota oproti *r*<sub>s</sub> neznamená horší metodu.
- **Inference:** oddělit výpočet, popis dat a zobecnění; nezávislost lidí, cílová populace, data celé populace bez intervalu. Pearsonova klasická inference předpokládá dvourozměrné normální rozdělení, odlišené od normality každé proměnné; heteroskedasticita jako důvod k obezřetnosti; žádné mechanické schéma podle testu normality. Fisherův interval je přibližný.
- **Permutační test:** nulovou hypotézou je nezávislost proměnných, nikoli nulový korelační parametr; nezamítnutí nedokládá nepřítomnost všech forem závislosti.
- **Bootstrap:** výběr celých dvojic s vracením a nový výpočet pořadí; povinná je percentilová konstrukce. Výklad uvede, že bootstrap není postup bez předpokladů a že pokrytí základního percentilového intervalu nemusí být 95 %, zvlášť u malých výběrů (Wilcox §6.9 pro Pearsonovo *r*); konkrétní omezení doloží vlastní simulace. Interval bez nuly není totéž co permutační test nezávislosti. Nevydávat percentilový interval za univerzálně nejlepší.
- **Faktory ovlivňující korelaci:** odlehlé pozorování (kontrola původu a analýza citlivosti), omezení rozsahu (může *r* snížit i zvýšit a mění populaci závěru), výběr extrémních skupin, sloučení skupin, chyba měření (slovně), vysoká korelace bez shody hodnot. Pořadové metody nejsou úplnou ochranou.
- **Sdělení:** rozhodovací tabulka otázka → úroveň měření → graf → koeficient → inference; volba se neřídí nejvyšším koeficientem ani nejnižší *p*-hodnotou. Tři komentované zprávy (počet úplných dvojic, koeficient, interval a metoda, test a věcná interpretace, u permutace testovaná hypotéza); korelační matice, chybějící hodnoty a mnoho testů krátce; závěrem kauzalita.
- **Nepřebírat ze zdrojů:** slovní pásma (P10 sn. 11), lineární převod *d* na *r* (P10 sn. 52–53), kauzální výklad *r*² (P11 sn. 41), opravu *r* odmocninou z upraveného *r*² (P10, P11), Howellův interval pro τ s nulovou směrodatnou chybou (s. 316), Aronovo srovnání korelací přes *r*².
- **Ověřování:** koeficienty, shody, změny kódování, Pearsonova inference a přesné permutace proti R; zachování dvojic, přepočet pořadí, reprodukovatelnost a nedefinované výběry; simulace chybovosti permutačních testů a pokrytí percentilového intervalu pro *r*<sub>s</sub> a τ<sub>b</sub> při velikostech výběru z kapitoly; české vzorce v desktopovém Excelu a výkon sešitu.

**Zdroje:** Howell, 8. vyd. (2013), kap. 9 (s. 251–265, 272–274, 280–281, 285–287, 290–293), kap. 10 (s. 304–317) a §18.1–18.3 (s. 657–665); Cumming a Calin-Jageman (2024), kap. 11; Wilcox, §5.9, §5.11, §6.5–6.6, §6.9 a §7.7; Aron et al., kap. 11 výběrově; přednášky P10 a P11 a úlohy C06 a C07 jako vodítko priorit. Před použitím přečíst: Ruscio (2008) k intervalům pořadových korelací (týká se BCa) a srovnávací studii citlivosti korelačních metod ve *Frontiers in Psychology* (2012). Čtení a přepočty eviduje [historie ověřování](../zdroje/HISTORIE.md#priprava-10-20261109).

**Důvod:** korelace navazuje na nezávislost, testování, intervaly, párová data a φ z kapitol 5–9 a v Howellově pořadí následuje po porovnání průměrů. Povinná inference pro pořadové koeficienty převzorkováním obchází neověřené vzorce směrodatných chyb *r*<sub>s</sub> a τ i chybný interval pro τ u Howella. Kapitola tím poprvé zavádí bootstrap a permutační test, které dosud nebyly umístěny.

**Nahrazuje:** stav „po kapitole 9 není schválen žádný plán“ v [plánu pokračování](../kapitoly/plan-pokracovani.md#plan-dalsi-kapitoly) ve znění z 2026-11-09 a umístění bootstrapu a korelace mezi tématy bez schváleného umístění.

**Doklad:** autor se zeptal, zda se má kapitola 10 věnovat Pearsonovu *r*, alternativním koeficientům, jednoduché regresi nebo jejich kombinaci, a ve výběru voleb zvolil „Jen korelace“. K prvnímu plánu doplnil: „I Kendallovo tau bych zařadil povinně“. Poté předložil vlastní plán (permutační test a percentilový bootstrapový interval pro pořadové koeficienty povinně, τ<sub>b</sub> jako hlavní varianta, 16 + 2 cvičení) a požádal o porovnání. Na srovnání odpověděl „Ano, sepiš ho“ a sloučený návrh schválil volbou „Schvaluji s doporučeními“, tedy včetně doporučení ke čtyřem otevřeným volbám: korelace jako koeficient reliability a validity krátce povinně, populační Kendallův koeficient slovy, prototyp sešitu před psaním a termín „dvourozměrné normální rozdělení“.

<a id="r71-upresneni-2026-11-09"></a>

**Upřesnění 2026-11-09 (počet opakování v sešitu):** po [prototypu převzorkování](../../quarto/README.md#prototyp-prevzorkovani-10) autor rozhodl, že studentský sešit `data/kapitola_10.xlsx` počítá bootstrap i permutace vzorci pro **1 999 opakování**. Vedle nich uvede pevné výsledky téhož postupu pro **9 999 opakování** (meze intervalů a *p*-hodnoty), zřetelně označené jako hotové hodnoty a ověřené proti R. Výchozí cíl 9 999 opakování ve vzorcích sešitu se tím nahrazuje. Důvodem je velikost souboru: prototyp s 9 999 opakováními měl asi 22 MB a otevíral se asi 21 s, s 1 999 opakováními 4,4 MB a asi 4 s; výpočet byl v obou případech rychlý. Rozdíl výsledků obou počtů opakování může výklad využít k ukázce simulačního kolísání. **Doklad:** na otázku „Kolik opakování má mít studentský sešit?“ autor odpověděl „1 999 + výsledky 9 999“.

<a id="r71-doplneni-2026-11-23"></a>

**Doplnění 2026-11-23 (vizualizace korelace):** bod „Mimo kapitolu“ vylučoval mimo jiné regresi a *r*² a další samostatnou interaktivní vizualizaci. Autor 2026-11-23 zadal a schválil vizualizaci [Jak tvar mraku bodů souvisí s korelačním koeficientem](../../quarto/viz_korelace.qmd), která na ni navazuje; tím je R71 v bodě o vizualizaci částečně nahrazeno. Regresní přímka, rezidua, koeficient determinace a pravděpodobnostní elipsy jsou jen součástí vizualizace s krátkým vysvětlením na její stránce; výklad kapitoly 10 regresi a *r*² dál nezahrnuje. Rozsah a doklad eviduje [upřesnění R65](postupy-a-dokumentace.md#r65-upresneni-2026-11-23-korelace).

<a id="r72-znaceni-kapitoly-10"></a>

## R72 — Značení kapitoly 10

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r72-znaceni-kapitoly-10). Původní záznam dohody:*

**Stav:** schváleno 2026-11-09 jako součást plánu. **Rozsah:** kapitola 10, přehled značení a další použití.

- Kovariance $s_{xy}$; Pearsonovo *r*, populačně stojaté $\mathrm{ρ}$; Spearmanův koeficient $r_s$, populačně $\mathrm{ρ}_s$; bodově biseriální $r_{pb}$.
- **Kendallovo τ, τ<sub>a</sub>, τ<sub>b</sub>:** výjimka z pravidla „řecké písmeno = populační parametr“ podle precedentu φ a χ² ([R69](kapitola-09.md#r69-znaceni-kapitoly-9)). Značka τ označuje jen výběrový koeficient; populační hodnota se píše slovy („Kendallův koeficient v populaci“), aby interval pro ni nebyl dvojznačný.
- Počty konkordantních a diskordantních dvojic $n_c$ a $n_d$; ne *C* a *D*, protože *D* označuje rozdíly párových dat ([R60](kapitola-08.md#r60-znaceni-kapitoly-8)). Počet dvojic $n(n-1)/2$.
- Fisherova transformace $z_r$; při zavedení upozornit na odlišnost od *z*-skóru a testové statistiky *z*.
- Testová statistika *t* s *n* − 2 stupni volnosti podle [R45](kapitola-07.md#r45-znaceni-kapitoly-7); počet bootstrapových či permutačních opakování *B*.

**Doklad:** návrh značení byl součástí sloučeného plánu, který autor 2026-11-09 schválil volbou „Schvaluji s doporučeními“; původní autorův plán navrhoval $r_s$, $\mathrm{ρ}_s$, $z_r$ a τ jako výslovnou výjimku, doporučení k populační hodnotě τ je součástí schválených doporučení.

<a id="r73-terminologie-kapitoly-10"></a>

## R73 — Terminologie kapitoly 10

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r73-terminologie-kapitoly-10). Původní záznam dohody:*

**Stav:** schváleno 2026-11-09 jako terminologický seznam plánu. **Rozsah:** kapitola 10, slovníček, přehledy a další použití. Hesla s anglickými ekvivalenty se do [registru](../SLOVNIK.md) zapíší při psaní kapitoly; před zápisem se ověří proti dříve schváleným heslům.

- **Korelace; korelační koeficient** (*correlation; correlation coefficient*): souvislost vs. její číselné shrnutí; odlišit od **korelační studie** (*correlational design*).
- **Lineární, monotónní a nelineární vztah** (*linear, monotonic, nonlinear relationship*); monotónní vztah nemusí být lineární. **Bodový graf** (*scatterplot*), již odlišený od tečkového grafu jednotlivých pozorování.
- **Kovariance** (*covariance*); **Pearsonův korelační koeficient**, **Pearsonovo *r*** (*Pearson product-moment correlation coefficient*).
- **Pořadová korelace** (*rank correlation*); **pořadí, průměrné pořadí, shodné hodnoty** (*rank, average rank, ties*), odlišené od pořadové statistiky (H12); **Spearmanův korelační koeficient** (*Spearman rank correlation coefficient*); **Kendallův korelační koeficient, Kendallovo τ** (*Kendall rank correlation coefficient*).
- **Konkordantní a diskordantní dvojice** (*concordant and discordant pairs*), při zavedení také „souhlasně a opačně seřazené dvojice“. **Hranice:** jde o dvojice případů seřazených podle dvou proměnných; nezaměňovat s **neshodnými dvojicemi** McNemarova testu ([R70](kapitola-09.md#r70-terminologie-kapitoly-9)), které mají stejný anglický název (*discordant pairs*), ale označují dvojice odpovědí jednoho člověka, které se liší.
- **Dvourozměrné normální rozdělení** (*bivariate normal distribution*), alternativa „bivariační“; **homoskedasticita a heteroskedasticita** (*homoscedasticity, heteroscedasticity*), nejdříve vysvětlené jako stejná a proměnlivá rozptýlenost v grafu.
- **Fisherova transformace** (*Fisher transformation*).
- **Permutační test** (*permutation test*): přeskupování přiřazení hodnot; navazuje na permutaci jako uspořádání všech prvků z kapitoly 5. **Bootstrap; bootstrapový výběr** (*bootstrap; bootstrap sample*): výběr celých dvojic s vracením. **Percentilový bootstrapový interval** (*percentile bootstrap confidence interval*).
- **Bodově biseriální korelace** (*point-biserial correlation*).

**Doklad:** terminologický seznam byl součástí sloučeného plánu schváleného 2026-11-09 volbou „Schvaluji s doporučeními“; doporučení „dvourozměrné normální rozdělení“ s alternativou „bivariační“ bylo jednou z otevřených voleb. Hranice vůči neshodným dvojicím McNemarova testu byla doplněna při zápisu dohody po kontrole proti R70.

<a id="r73-doplneni-2026-11-11"></a>

**Doplnění evidence 2026-11-11 (při psaní kapitoly, nejde o nové schválení):** kapitola zavádí tučně s anglickým ekvivalentem čtyři výrazy, které seznam R73 neuvádí: **omezení rozsahu** (*range restriction*), **korelační matice** (*correlation matrix*), **analýza citlivosti** (*sensitivity analysis*) a v nepovinném rozšíření **interval BCa**. Jsou evidovány jako otevřené návrhy K10-N1 až K10-N4 v [registru](../SLOVNIK.md#navrhy) a do studentského slovníčku zatím zapsány nejsou. Pomocné výrazy „korekce zkreslení“, „zrychlení“, „přeskupení“ a „výběr krajních skupin“ se v textu nezavádějí jako termíny.

<a id="r73-schvaleni-navrhu-2026-11-11"></a>

**Doplnění 2026-11-11 (schválení návrhů K10-N1 až K10-N4):** autor schválil všechny čtyři návrhy z [doplnění evidence](#r73-doplneni-2026-11-11): **omezení rozsahu** (*range restriction*; alternativy restrikce rozsahu, omezené variační rozpětí), **korelační matice** (*correlation matrix*), **analýza citlivosti** (*sensitivity analysis*) a v nepovinném rozšíření **interval BCa** (*bias-corrected and accelerated interval*). Doplňují se do registru a studentského slovníčku; text kapitoly se nemění. **Doklad:** na otázku „Schválíte návrhy termínů K10-N1 až N4?“ autor odpověděl „Schvaluji všechny“.


<a id="r84-revize-kapitoly-10"></a>

## R84 — Revize kapitoly 10 podle autorových připomínek

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r84-revize-kapitoly-10). Původní záznam dohody:*

**Stav:** schváleno 2026-11-20 (připomínky a schválený plán). **Rozsah:** kapitola 10 včetně cvičení, slovníčku, přehledu značení a přehledu Excelu. Sešit `data/kapitola_10.xlsx` se nemění. Skutečný obsah po revizi zachycuje [karta kapitoly](../kapitoly/10-korelace.md#mapa-kapitola-10).

**Volba a důvod:**

- **Plné názvy koeficientů:** ve výkladu „Pearsonův / Spearmanův / Kendallův korelační koeficient“ ve všech pádech, ne zkrácené „… koeficient“; tvary se značkou („Pearsonovo *r*“, „Spearmanovo $r_s$“, „Kendallovo τ“) zůstávají. Populační hodnotu Kendallova koeficientu píšeme „Kendallův korelační koeficient v populaci“ (formulace z [R72](#r72-znaceni-kapitoly-10) se tím jen prodlužuje). Odpovídá preferovaným heslům [R73](#r73-terminologie-kapitoly-10). Platí pro kapitolu 10 a přehledy; ostatní kapitoly zkrácené tvary neobsahovaly.
- **„Mrak“ jen ve spojení „mrak bodů“** jako popis vzhledu grafu; tvar souvislosti se pojmenuje „lineární vztah / souvislost“, ne „lineární mrak“ apod.
- **Nové termíny:** alternativa **observační studie** (*observational study*) u korelační studie; **převzorkování** (*resampling*) jako souhrnné označení permutačního testu a bootstrapu; **pravý skór** (*true score*) a **atenuace** (*attenuation*) v povinném výkladu o chybě měření; **korekce na atenuaci** (*correction for attenuation*) v nepovinném rozšíření; **relativní a absolutní shoda** (*relative and absolute agreement*). „Pořadová transformace“ jen jako vysvětlující alternativa převodu na pořadí. Tři druhy odlehlých pozorování se popisují opisem, bez termínů „jednorozměrně/dvourozměrně odlehlé“.
- **Značení:** $r_{xx}$, $r_{yy}$ pro koeficienty reliability a $r_{\mathrm{opr}}$ pro korelaci opravenou na atenuaci (jen v nepovinném rozšíření); v rozšíření BCa hodnoty $\mathrm{τ}_{b(i)}$ bez *i*-tého člověka, jejich průměr $m_{\mathrm{τ}}$ a rozdíly $u_i$ (písmeno *d* je obsazeno Cohenovým *d*). Přirozený logaritmus zůstává zapsán $\ln$ jako v kapitole 9; při zavedení v kapitole 10 se uvádí základ *e* a alternativní zápis $\log_e$. Rozvíjí [R72](#r72-znaceni-kapitoly-10).
- **Korekce na atenuaci jako nepovinné rozšíření** (vzorec, příklad, omezení podle Muchinského, 1996). **Částečně nahrazuje [R71](#r71-rozsah-kapitoly-10)** v bodě „korekce na chybu měření mimo kapitolu“; ostatní vymezení R71 platí. Nové nepovinné rozšíření „Proč Pearsonovo *r* nepřekročí ±1“ (důkaz přes součet druhých mocnin rozdílů *z*-skórů) a podrobnější výklad intervalu BCa nemění povinný rozsah.
- **Anscombův kvartet** (Anscombe, 1973; data `datasets::anscombe`, převzatá skutečná data) nahrazuje autorské modelové soubory se stejným *r* = 0,60 v obrázku `fig-stejne-r`.
- **Korelační matice s intervaly a hvězdičkami:** pod úhlopříčkou *r* s hvězdičkami (\* *p* < 0,05, \*\* *p* < 0,01, \*\*\* *p* < 0,001, bez úpravy na počet testů) a pod ním 95% Fisherův interval na samostatném řádku; nad úhlopříčkou počty dvojic. Výklad upozorňuje, že hvězdičky problém mnoha testů neřeší a intervaly nesou víc informace.
- **Nové obrázky a tabulka:** Fisherova transformace (křivka a výběrové rozdělení před a po převodu), přesné permutační rozdělení τ<sub>b</sub> pro šest studentů, tři druhy odlehlého pozorování s *r*, $r_s$ a τ<sub>b</sub>, simulace atenuace (reliabilita 0,6), $\lvert r_{pb}\rvert$ v závislosti na *d* pro tři rozdělení 42 lidí; tabulka pozorovaného přiřazení a tří přeskupení kvality spánku.
- **Výklad:** dva významy „směru vztahu“ (znaménko vs. směr působení); volba osy podle teoretické role proměnných; společná příčina u úzkosti a výkonu; heteroskedasticita nejen jako vějíř; přepsaný oddíl o hypotéze permutačního testu (nezávislost vs. nulová korelace, výklad zamítnutí a nezamítnutí); proč bootstrap losuje s vracením a že výběr zastupuje populaci; přepočet pořadí jen u pořadových koeficientů; cílem analýzy odlehlých pozorování je porozumět jejich vlivu, ne je odstranit; korelace a relativní, nikoli absolutní shoda; přirovnání km/míle u Kendallova a Spearmanova koeficientu nahrazeno věcným vysvětlením.

**Doklad:** autorovy připomínky ke kapitole 10 z 2026-11-20, mimo jiné: „V kapitole se často objevuje pouze ‚Personův koeficient‘ nebo ‚Spearmanův koeficient‘, asi by správně bylo lepší psát ‚Personův korelační koeficient‘…“; „‚lineární mrak‘ apod. zní divně“; „Myslím, že někdy se říká korelační studii také říká observační“; „Tady bych možná pužil Askombeho 4 datasety“; „Doplnil bych také jako nepovinné rozšíření výpočet korekce nedokonalé reliability a obrázek…“; „je vhodné v tabulce pod bodovými odhady uvádět i intervaly spolehlivosti a za bodovými odhady hvězdičkami označit p-hodnoty“; „‚převzorkováním dat.‘ Myslím, že je vhodné doplnit anglický ekvivalent“. V dotazech autor zvolil „Nahradit Anscombem“, „r* a pod ním [CI], n nahoře“, „Opisem bez nových termínů“ a „Kapitola 10 a přehledy“; jako zdroj korekce na atenuaci doplnil do podkladů článek Muchinského (1996). Plán revize se seznamem termínů a značení (oddíl 5) schválil 2026-11-20 a upřesnil znění věty o čarách průměrů v grafu kovariance.

<a id="r86-prekryvani-bodu"></a>

## R86 — Překrývání bodů a rozvržení obrázků kapitoly 10

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r86-prekryvani-bodu). Původní záznam dohody:*

**Stav:** schváleno 2026-11-25 (pokyn autora a odpovědi na otázky k plánu). **Rozsah:** kapitola 10 včetně cvičení 1c a slovníčku. Sešit `data/kapitola_10.xlsx` se nemění. Skutečný obsah zachycuje [karta kapitoly](../kapitoly/10-korelace.md#mapa-kapitola-10).

**Volba a důvod:**

- **Nový pododdíl o překrývání bodů** v oddílu o bodovém grafu: proč graf s mnoha lidmi nebo s málo možnými hodnotami skrývá, kde je lidí nejvíc, a dvě řešení, velikost bodu podle počtu lidí a častější jitter s průhledností bodů. Výklad ukazuje i mez: příliš velký jitter slévá sousední hodnoty; jitter mění jen obrázek, výpočty vycházejí z původních hodnot. Rozšiřuje povinný rozsah [R71](#r71-rozsah-kapitoly-10) o krátký výklad zobrazení dat.
- **Ilustrace:** obrázek 2 × 2 (bez úpravy, jitter, jitter s průhledností, větší jitter s průhledností) na nových smyšlených datech 500 studentů, kvalita spánku a únava během dne na škále 1–7. Data vznikají jen v interním skriptu; postup v Excelu se neuvádí a sešit nedostává nový list.
- **Termíny:** **překrývání bodů** (*overplotting*), **jitter** (*jitter*) jako zavedený cizí termín vysvětlený opisem „malé náhodné posunutí bodů“ a **průhlednost bodů** (*transparency*). Rozšiřuje [R73](#r73-terminologie-kapitoly-10); volba cizího termínu odpovídá [R76](spolecne-konvence.md#r76-jazykove-konvence).
- **Rozvržení obrázků:** Fisherova transformace ve dvou řadách (převodní křivka nahoře uprostřed, oba histogramy pod ní), tři druhy odlehlého pozorování v mřížce 2 × 2 a obrázek omezení rozsahu, krajních skupin a sloučení skupin ve dvou řadách (oba grafy uchazečů nahoře, sloučené třídy dole uprostřed). Data a výpočty se nemění; důvodem je čitelnost malých panelů v jedné řadě.

**Doklad:** pokyn autora z 2026-11-25: „U kapitoly 10 bych Obrázek 10.9 rozdělil na dva řádky, na prvním řádku bych ukázal Fisherovu transformaci (graf bych vycentroval na střed), pod tím ta dvě výběrová rozdělení“; „Obrázek 10.13 bych také dal na dva řádky do mřížky 2X2“; „Obrázek 10.14 bych také dal na dva řádky“; „V kapitole by bylo vhodné někde dát krátkou sekci o ‚overplottingu‘ … častěji jitterem bodů + semitransparentností bodů; což bych ilustroval na grafech“. V dotazech autor zvolil „Překrývání + jitter“, „500 studentů, škály 1–7“ a „Jen koncepčně“ a schválil plán.
