# Dohody k podílům a kategoriálním datům

[Registr rozhodnutí a aktuální platnost](../ROZHODNUTI.md) · [Pravidla evidence](../../AGENTS.md#evidence-rozhodnuti)

Níže jsou zachovány původní záznamy schválených voleb, jejich důvody a doklady. Data, rozsah a formulace se vztahují k uvedeným dohodám; záznamy mohou obsahovat později nahrazené části nebo již provedené úkoly. Aktuální platnost a hlavní místo údržby určuje řádek v registru. Staré seznamy se při běžné aktualizaci slovníku, obsahu či pracovního postupu znovu nesynchronizují; nová schválená změna dostane vlastní datovaný doklad.

<a id="r68-rozsah-kapitoly-9"></a>

## R68 — Rozsah, pořadí a zásady výkladu kapitoly 9

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r68-rozsah-kapitoly-9). Původní záznam dohody:*

**Stav:** schváleno 2026-11-09. **Rozsah:** kapitola 9 „Podíly a kategoriální data: odhad, testy chí-kvadrát a velikost souvislosti“ (pracovní název), její cvičení, sešit a navazující přehledy. Kapitola dosud není napsána; skutečný obsah a odchylky bude evidovat karta kapitoly 9.

**Vymezení**

- **Povinně:** podíl jako statistika a parametr π; průměr proměnné kódované 0/1 jako podíl; interval pro podíl; rozdíl dvou nezávislých podílů s intervalem a test se společným podílem; test dobré shody; chí-kvadrát rozdělení a stupně volnosti; test nezávislosti a homogenity v tabulce o více řádcích a sloupcích; shoda χ² = z² u dvou kategorií a tabulky 2 × 2; řádkové podíly, Pearsonova a upravená rezidua; předpoklady včetně Fisherova exaktního testu; rozdíl podílů, poměr rizik, šance a poměr šancí, φ a Cramérovo V; McNemarův test; volba postupu a sdělení výsledku.
- **Nepovinná rozšíření:** výpočet Fisherova testu přes HYPGEOM.DIST; Holmova korekce u reziduí; intervaly pro poměr rizik a poměr šancí přes logaritmus; Simpsonův paradox (bez Mantelova–Haenszelova vzorce); Cohenovo kappa; kritický rozbor ganzfeldských studií; proč má součet (f − e)²/e přibližně rozdělení χ².
- **Mimo kapitolu:** věrohodnostní poměr G², loglineární modely, Mantelův–Haenszelův test, logistická regrese, Yatesova korekce (jen zmínka, že ji software může použít výchozím nastavením), Bowkerův test, analýza síly pro χ², Cohenovo w a slovní pásma (analogicky [R56](kapitola-06.md#r56-p-hodnota-cohen)), testy trendu pro uspořádané kategorie (jen upozornění, že χ² pořadí ignoruje).

**Členění (jedenáct oddílů):** od tabulky ve výběru k otázce o populaci; jak přesně odhadneme podíl v populaci; jak porovnat podíly ve dvou nezávislých skupinách; jak daleko jsou pozorované četnosti od očekávaných (dobrá shoda); kdy je hodnota χ² neobvykle velká (rozdělení, stupně volnosti, *p*-hodnota); souvisejí spolu dvě kategoriální proměnné (nezávislost a homogenita); kde se tabulka od nezávislosti odchyluje (řádkové podíly a rezidua); kdy se na test chí-kvadrát nelze spolehnout a co použít místo něj; jak velká je souvislost (tři pododdíly); co když jsou ve dvou měřeních tíž lidé (McNemarův test); který postup zvolit a jak výsledek sdělit. Pořadí „jeden podíl → dva podíly → dobrá shoda → obecné kontingenční tabulky“ navazuje na kapitoly 6–8 a zachovává se.

**Příklady**

- Hlavní příklady jsou omezeny: tabulka 200 studentů (pohlaví × zvýšený stres) z kapitoly 5, nyní chápaná jako náhodný výběr (40 % a 30 %; rozdíl 0,10, 95% Newcombův interval přibližně (−0,03; 0,23), χ² = 2,20, *p*-hodnota 0,138; dvojnásobný výběr se stejnými podíly *p*-hodnota 0,036); jeden autorský příklad dobré shody (konkrétní podoba se upřesní při psaní); věk × strategie zvládání stresu z autorovy přednášky P12 (χ² = 11,78 se čtyřmi stupni volnosti, *p*-hodnota 0,019); Daniels (2012) podle Fielda pro všechny míry účinku (56/140 a 20/117) s krátkým kontrastem vzácného jevu (aspirin podle Howella); vyhledávání pomoci před a po podle Howella (smyšlená data, 72 dětí, změny 12 a 4).
- Krátké modelové ilustrace intervalu: 10 správných z 20 (test z kapitoly 6) a 0 z 15.
- Do cvičení: Prozac a anorexie (Walsh a kol., 2006, podle Howella), terapeutický dotek (nezávislost pozorování), kámen–nůžky–papír. Ganzfeldské studie (Bem a Honorton, 1994, podle Cumminga) jen v nepovinném kritickém rozboru: souhrn několika studií otevírá otázky, které samotný binomický výpočet neřeší.

**Zásady výkladu**

- **Interval pro podíl:** Waldův interval jen jako krátký vysvětlující mezikrok se známou strukturou „odhad ± kvantil × směrodatná chyba“ a jeho selháním u 0 z 15; potom Wilsonův interval, kterým se počítá. Student nemá získat dojem, že má pro běžné použití rovnocenně ovládat několik intervalových metod.
- **Rozdíl dvou nezávislých podílů:** hlavním výpočtem je Newcombův interval založený na Wilsonových intervalech obou skupin. Waldův interval smí vysvětlit princip sčítání rozptylů.
- **Vztah intervalu a testu:** Wilsonův interval odpovídá obrácení skórového testu jednoho podílu; nelze jej bez dalšího ztotožnit s přesným binomickým testem. Newcombův interval nemusí přesně reprodukovat rozhodnutí každé varianty testu dvou podílů. Formulace: „Interval a test poskytují související informace; přesná shoda rozhodnutí závisí na použitých postupech.“
- **Fisherův exaktní test** patří do povinného oddílu o předpokladech: otázka, podmínění okrajovými součty a čtení výsledku. Není svou platností omezen jen na malé výběry. Výpočet přes HYPGEOM.DIST je rozšířením.
- **Očekávané četnosti hierarchicky:** v základních příkladech pravidlo „všechny očekávané četnosti alespoň 5“; poté vysvětlit, že jde o konzervativní vodítko a že existují další doporučení. Podmínku celkového *n* ani pravidlo „nejvýše 20 % buněk pod 5“ nepředstavovat jako samostatnou záruku správnosti aproximace.
- **Rezidua:** povinně rozdíl Pearsonova a upraveného rezidua a jejich význam v konkrétní tabulce. Pokud se některé buňky označí za statisticky významné, musí následovat řešení vícenásobného testování (nepovinný blok s Holmovou korekcí); samotné upozornění, že nejde o nezávislé testy, problém neřeší.
- **Míry účinku** ve třech pododdílech na jednom příkladu: (a) rozdíl podílů jako hlavní výsledek v procentních bodech s intervalem; (b) poměr rizik a poměr šancí — výpočet, referenční skupina a rozdílný význam; (c) φ a Cramérovo V jako souhrnná síla souvislosti a její omezení. Vztah √(χ²/n) dává absolutní hodnotu φ; znaménko φ počítaného z binárního kódování závisí na orientaci kategorií; Cramérovo V je nezáporné.
- **McNemarův test** se zdůvodňuje takto: „Pro porovnání podílů před a po použijeme McNemarův test. Pearsonův test nezávislosti na tabulce přechodů by zkoumal jinou otázku: zda odpověď před měřením souvisí s odpovědí po měření.“ Neshodné dvojice určují testovou statistiku, ale rozdíl podílů se vztahuje ke všem úplným dvojicím.
- **Konceptuální upozornění:** průměr libovolných kódů nominálních kategorií obvykle nemá význam, ale průměr binární proměnné kódované 0/1 je právě podíl jedniček. Očekávaný profil převzatý z jiného výběru není automaticky známým populačním rozdělením; má-li vlastní výběrovou nejistotu, může být vhodnější porovnání dvou výběrů.
- **Ověřování:** Wilsonův interval proti `prop.test(..., correct = FALSE)`, nekorigovaný Pearsonův test proti `chisq.test(..., correct = FALSE)` (výchozí nastavení u tabulky 2 × 2 používá korekci; u tabulky stresu 1,78 místo 2,20), upravená rezidua proti `chisq.test()$stdres`, Newcombův interval nezávisle vzorcem, přesný McNemarův postup binomickým testem neshodných dvojic; okrajové případy bez jediné změny a s neúplnými dvojicemi. Dílčí přepočet při přípravě nepotvrzuje celý seznam zdrojových nálezů ani všechny výpočty plánu.

**Zdroje:** Howell, 8. vyd. (2013), kap. 6, s. 137–171; Cumming a Calin-Jageman (2024), kap. 13, s. 387–410; Diez a kol. (OpenIntro), kap. 6, s. 206–252; Field a kol., kap. 16, s. 619–644; Wilcox (2017), §15.1–15.4, s. 609–622; Navarro, kap. 12, s. 471–505; autorova přednáška P12, přednáška P13 a úlohy C09; dokumentace R `prop.test`, `binom.test`, `chisq.test` a `fisher.test` jako kontrolní opora. Rozsah čtení a nálezy v [historii ověřování](../zdroje/HISTORIE.md#priprava-09-20261109).

**Důvod:** kapitola 5 neprovádí inferenci pro tabulky, kapitola 6 vykládá binomický test a směrodatnou chybu podílu, kapitoly 7–8 interval spolehlivosti, párové a nezávislé uspořádání a velikost účinku. Kapitola 9 tyto linie přenáší na četnosti a sleduje Howellovo pořadí doplněné Cummingovým důrazem na odhad.

**Nahrazuje:** stav „po kapitole 8 není schválen žádný plán“ v [plánu pokračování](../kapitoly/plan-pokracovani.md#plan-dalsi-kapitoly) ve znění z 2026-11-01.

**Doklad:** autor uvedl: „Myslím, že kapitola 9 by se měla týkat testů pro kategorická data“ a připomněl: „Nespoléhej se pouze na Howella“. Ve výběru voleb zvolil „Ano, odhad i testy“, „Wilsonův, logika přes Walda“ a „Rozdíl, poměr rizik, šance“. První předložený plán vrátil s dvanácti písemnými připomínkami, mimo jiné: „Zachoval bych jeho základní pořadí.“; „Student by neměl získat dojem, že má pro běžné použití rovnocenně ovládat několik intervalových metod.“; „Pro rozdíl dvou nezávislých podílů bych zvolil Newcombův interval založený na Wilsonových intervalech.“; „Fisherův test bych začlenil do povinného oddílu o předpokladech.“; „Pokud budeme některé buňky označovat za statisticky významné, musí následovat řešení vícenásobného testování“; „Omezil bych počet hlavních příkladů a některé přesunul do cvičení.“ Druhou verzi se všemi připomínkami schválil 2026-11-09. Záznam „Kapitola 9: dohoda o obsahu“ v [historii](../../quarto/README.md#dohoda-kapitola-09).

<a id="r69-znaceni-kapitoly-9"></a>

## R69 — Značení kapitoly 9

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r69-znaceni-kapitoly-9). Původní záznam dohody:*

**Stav:** schváleno 2026-11-09 jako součást plánu; jeden bod otevřen. **Rozsah:** kapitola 9, přehled značení a další použití.

- **Četnosti (rozvinutí [R02](kapitola-02.md#r02-indexy-a-cetnosti)):** pozorovaná četnost $f_j$ (zavedené značení kapitoly 2), očekávaná četnost $e_j$; *n* celkový počet, *k* počet kategorií, $p_j$ a $\mathrm{π}_j$ výběrový a populační podíl, $\mathrm{π}_{0j}$ podíl podle nulové hypotézy. Index *i* zůstává vyhrazen jednotlivým pozorováním, proto se pro řádky ani buňky tabulky nepoužije. Značky *O* a *E* z literatury jen jako alternativa v přehledu.
- **χ², φ a nepovinně κ:** výjimka z pravidla „řecké písmeno = populační parametr“; jde o ustálené symboly statistik (obdoba *t* a *z*). Rozdělení se popisuje jako chí-kvadrát rozdělení s daným počtem stupňů volnosti; kvantil s indexem stupňů volnosti podle [R45](kapitola-07.md#r45-znaceni-kapitoly-7). Stupně volnosti se ve výkladu vypisují slovy.
- Rozdíl podílů $p_1-p_2$ (populačně $\mathrm{π}_1-\mathrm{π}_2$); poměr rizik a poměr šancí ve výkladu slovy, zkratky RR a OR jen v přehledu a v ukázkách zpráv (obdoba [R01](spolecne-konvence.md#r01-znaceni-a-reportovani)). Cramérovo *V*.
- **Otevřeno:** indexy buněk tabulky. Návrh: řádek *j* = 1, …, *R* a sloupec *l* = 1, …, *S* (tabulka *R* × *S*), $f_{jl}$, $e_{jl}$ a okrajové součty $f_{j+}$, $f_{+l}$; alternativa okrajové součty jen slovy. Volba se předloží před psaním oddílu o tabulkách.

**Doklad:** autor k prvnímu plánu napsal: „Použití indexu i pro řádky kategorií by bylo v rozporu s dosavadní konvencí, kde označuje jednotlivá pozorování. Pro buňky bych navrhl jiné indexy; pro četnosti bych přednostně rozvinul zavedené f a doplnil e pro očekávané četnosti.“ Druhou verzi plánu s tímto značením schválil 2026-11-09.

<a id="r69-upresneni-2026-11-09"></a>

**Upřesnění 2026-11-09 (indexy buněk a příklad dobré shody):** před psaním kapitoly autor ve výběru voleb uzavřel oba otevřené body. Pro buňky platí řádek *j* = 1, …, *R* a sloupec *l* = 1, …, *S* (tabulka *R* × *S*), četnosti $f_{jl}$ a $e_{jl}$ a okrajové součty $f_{j+}$ a $f_{+l}$; vzorec $e_{jl}=f_{j+}f_{+l}/n$. Hlavním příkladem dobré shody (doplnění [R68](#r68-rozsah-kapitoly-9)) je autorský model poziční preference: 80 lidí volí jeden ze čtyř stejných vzorků čaje vystavených zleva doprava, nulová hypotéza rovnoměrné volby; varianta s nerovnoměrnými $\mathrm{π}_0$ je ve cvičení. Doklad: volby „j řádek, l sloupec (Recommended)“ a „Poziční preference (Recommended)“ na otázku před zahájením psaní.

<a id="r70-terminologie-kapitoly-9"></a>

## R70 — Terminologie kapitoly 9

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r70-terminologie-kapitoly-9). Původní záznam dohody:*

**Stav:** schváleno 2026-11-09 jako terminologický seznam plánu. **Rozsah:** kapitola 9, slovníček, přehledy a další použití. Hesla s anglickými ekvivalenty se do [registru](../SLOVNIK.md) zapíší při psaní kapitoly; před zápisem se ověří proti dříve schváleným heslům.

- **Kategoriální data, kategoriální proměnná** (*categorical*); jediná varianta, „kategorická“ se nepoužívá.
- **Podíl** (*proportion*); „proporce“ jen jako alternativa v registru.
- **Wilsonův interval** (*Wilson score interval*) a **Newcombův interval** (*Newcombe hybrid score interval*); **Waldův interval** jen jako vysvětlující pojem. **Společný podíl** (*pooled proportion*).
- **Pozorovaná a očekávaná četnost** (*observed / expected frequency*); **test dobré shody** (*goodness-of-fit test*); **statistika chí-kvadrát** (Pearsonova; *Pearson's chi-square*); **chí-kvadrát rozdělení** (*chi-square distribution*).
- **Test nezávislosti** a **test homogenity** (*test of independence / homogeneity*) jsou související, nikoli synonyma; **řádkový podíl**.
- **Pearsonovo reziduum** a **upravené reziduum** (*Pearson residual / adjusted (standardized) residual*); **nevýskyty** (*nonoccurrences*); **Fisherův exaktní test** (*Fisher's exact test*).
- **Riziko, rozdíl rizik, poměr rizik** (*risk, risk difference, risk ratio*; relativní riziko jako alternativa); **šance, poměr šancí** (*odds, odds ratio*); **referenční skupina**; **koeficient φ** (*phi coefficient*); **Cramérovo V** (*Cramér's V*).
- **McNemarův test** (*McNemar's test*); **neshodné dvojice** (*discordant pairs*; „páry“ jen jako alternativa v souladu s terminologií kapitoly 8).
- Nepovinně: **Holmova korekce**, **Simpsonův paradox**, **Cohenovo kappa**.

Poměr šancí, který [R23](kapitola-05.md#r23-terminologie-kapitoly-5) při přípravě kapitoly 5 nezavedlo, se tímto schvaluje pro kapitolu 9; šance zůstávají v kapitole 5 nepovinné a kapitola 9 je vysvětlí znovu.

**Doklad:** terminologický seznam byl součástí plánu schváleného 2026-11-09; autor k prvnímu plánu doplnil: „Ustálit jednu variantu, a to ‚kategoriální‘ podle slovníku a dohody, nikoli podle názvů zdrojových karet.“

<a id="r70-doplneni-2026-11-09"></a>

**Doplnění evidence 2026-11-09 (při psaní kapitoly, nejde o nové schválení):** termíny **skórový test** a **tabulka přechodů** seznam R70 výslovně neuvádí; v textu se používají, protože je autor sám užil ve schválených připomínkách k plánu („Wilsonův interval odpovídá obrácení skórového testu“; „Pearsonův test nezávislosti na tabulce přechodů“). Jako **návrhy k rozhodnutí** zůstávají v [registru](../SLOVNIK.md#návrhy-a-nejasně-doložené-volby--mimo-platný-registr) hypergeometrické rozdělení v nepovinném rozšíření (K09-N1) a střet termínu **referenční skupina** se starším heslem podle [R08](kapitola-04.md#r08-terminologie-kapitoly-4) (K09-N2).
