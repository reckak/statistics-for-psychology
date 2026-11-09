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
