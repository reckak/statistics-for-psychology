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

<a id="r68-doplneni-2026-11-17"></a>

**Doplnění 2026-11-17 (nepovinné odvození Wilsonova intervalu):** autor schválil nepovinné rozšíření s celým odvozením vzorce Wilsonova intervalu z podmínky $|p-\mathrm{π}|\le z\sqrt{\mathrm{π}(1-\mathrm{π})/n}$. Kvadratický krok se podává připomenutím vzorce pro kořeny **kvadratické rovnice** (*quadratic equation*) se zápisem $Ax^2+Bx+C=0$ (malá $a$, $b$, $c$ kapitola používá jinde) a bez slova „diskriminant“; rozšíření doprovází obrázek obou stran nerovnice pro 10 z 20. Povinný výklad, vzorec, sešit ani přehled značení se nemění; termín se eviduje ve [slovníku](../SLOVNIK.md#pojem-kvadraticka-rovnice) a studentském slovníčku jako pojem nepovinného rozšíření. Doklad: autor k oddílu o Wilsonově intervalu napsal „Asi bych v nepovinném rozšíření ukázal celé odvození Wilsonova intervalu.“; ve výběru voleb zvolil „Připomenout vzorec pro kořeny“ (s popisem zápisu $Ax^2+Bx+C=0$ a jediného nového termínu „kvadratická rovnice“) a „S obrázkem dvou křivek“ a schválil předložený plán. Skutečný obsah zachycuje [karta kapitoly](../kapitoly/09-podily-kategorialni-data.md#skutecny-obsah-09).

<a id="r68-doplneni-2026-11-27"></a>

**Doplnění 2026-11-27 (jeden podíl třemi rozděleními):** autor schválil nový povinný pododdíl „Jeden podíl třemi způsoby: binomické, normální a chí-kvadrát rozdělení“ na konci oddílu o chí-kvadrát rozdělení. Na příkladu 10 z 20 proti $\mathrm{π}_0=0{,}25$ s oboustrannou alternativou ukazuje přesný binomický test, skórový test a test chí-kvadrát dvou kategorií vedle sebe; větou uvádí kontrast 30 z 80. Oboustranná přesná *p*-hodnota se počítá pravidlem „stejně nebo méně pravděpodobné výsledky“, shodným s [aplikací Test jednoho podílu](vizualizace-a-aplikace.md#r87-statisticke-aplikace), s výkladem Fisherova testu a s `binom.test`; Blakerovo pravidlo se nezavádí, aplikace se nemění a nevzniká nový termín ani zdroj. Nový obrázek (binomické rozdělení s normální křivkou nad osou počtu, podílu a *z*, zvětšené chvosty, *z*² a chí-kvadrát rozdělení s jedním stupněm volnosti) nahrazuje dosavadní obrázek „Od *z* k chí-kvadrát“ se simulací 10 000 hodnot *z*. List `Interval_podilu` se doplňuje o přesný binomický test a test chí-kvadrát dvou kategorií, funkce SUMIF tím přechází z nepovinného rozšíření do povinného textu a cvičení 5 dostává část e). Rozsah R68 se jinak nemění. Doklad: autor napsal „Myslím, že v kapitole 9 by měl byl u jednoho podílu být v rámci výkladové části aspoň jeden příklad, asi po vysvětlení všech druhů rozdělení, který ukazuje, proč lze testy ohledně rozdělení jedné proměnné řešit pomocí exaktně pomocí binomického rozdělení a přibližně pomocí normálního rozdělení či rozdělení chí-kvadrát s jedním stupněm volnosti. Ukázat binomické rozdělení, proložené příslušnou normální křivkou, a zároveň z umocněné na druhou, na osu X dát jak počet, tak podíl úspěchů. Možná by pak nebyl úplně nutný obrázek Obrázek 9.7.“ a „Nejlépe asi u nějakého oboustranného testu s Blakerovou metodou výpočtu p-hodnot.“ Po upozornění, že aplikace i výklad Fisherova testu používají jiné pravidlo než Blakerovo, zvolil ve výběru voleb „Pravidlo aplikace“, „10 z 20 proti 0,25“, „Nahradit novým“ a u doprovodných změn „Výpočet v sešitu“ a „Podotázka ve cvičení“; poté schválil předložený plán včetně umístění pododdílu a části e) cvičení 5. Skutečný obsah zachycuje [karta kapitoly](../kapitoly/09-podily-kategorialni-data.md#skutecny-obsah-09), provedení a kontroly [autorská historie](../../quarto/README.md#jeden-podil-tri-rozdeleni).

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

<a id="r70-schvaleni-navrhu-2026-11-09"></a>

**Doplnění 2026-11-09 (schválení návrhů K09-N1 a K09-N2):** autor schválil oba návrhy: **hypergeometrické rozdělení** (*hypergeometric distribution*) zůstává v nepovinném rozšíření o výpočtu Fisherova testu a doplňuje se do slovníčku i registru; **referenční skupina** nese pod jedním termínem dva související významy — skupinu pro posouzení polohy výsledku podle [R08](kapitola-04.md#r08-terminologie-kapitoly-4) a skupinu ve jmenovateli poměru rizik nebo šancí v kapitole 9. R08 se tím nenahrazuje, jen rozšiřuje rozsah použití. Doklad: na dotaz k oběma návrhům autor odpověděl „Ano, oba termíny můžeš nechat (případně přidat) v textu i ve slovníčku.“

<a id="r81-revize-kapitoly-9"></a>

## R81 — Revize kapitoly 9 podle autorových připomínek

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r81-revize-kapitoly-9). Původní záznam dohody:*

**Stav:** schváleno 2026-11-16. **Rozsah:** kapitola 9 včetně cvičení, sešitu, slovníčku, přehledu značení a přehledu Excelu; společná jazyková upřesnění platí pro celou knihu. Skutečný obsah po revizi zachycuje [karta kapitoly](../kapitoly/09-podily-kategorialni-data.md#mapa-kapitola-09).

**Volba a důvod:**

- **Standardizované reziduum** (*standardized residual*, také *adjusted residual*) je preferovaný termín místo „upraveného rezidua“. Částečně nahrazuje [R70](#r70-terminologie-kapitoly-9) a větu [R76](spolecne-konvence.md#r76-jazykove-konvence) „ustálený termín ‚upravené reziduum‘ se nemění“. „Upravené“ a „adjustované“ zůstávají jako alternativy v registru. Text upozorňuje, že některé programy (SPSS) označují slovem *standardized* Pearsonovo reziduum. ID `pojem-upravene-reziduum` a `#sec-pearson-upravena` se nemění.
- **Tabulka párových dat** (*matched-pairs table*) místo „tabulky přechodů“ z [doplnění R70](#r70-doplneni-2026-11-09). Důvod: „přechody“ se v české literatuře vážou spíše k Markovovým řetězcům; nový termín navazuje na „párová data“ kapitoly 8 a hodí se i pro tabulku dvou posuzovatelů. ID `pojem-tabulka-prechodu` a `#sec-tabulka-prechodu` se nemění.
- **Znaménkový test** (*sign test*) se zařazuje jako povinný pododdíl za McNemarův test s novým povinným cvičením 13; dosavadní nepovinná cvičení 13 a 14 mají čísla 14 a 15. Rozšiřuje rozsah [R68](#r68-rozsah-kapitoly-9) a mění [plán pokračování](../kapitoly/plan-pokracovani.md), kde byl znaménkový test dosud mimo kapitoly 6–10. Příklad: dvanáct rozdílů skóru pozornosti z kapitoly 8.
- **Simulace Monte Carlo** a **simulovaná *p*-hodnota** (*Monte Carlo simulation*) se zařazují jako povinný pododdíl za Fisherův test, jen jako princip bez výpočtu v Excelu. Termín „permutační test“ a vzorec (k + 1)/(B + 1) zůstávají zavedeny až v kapitole 10 ([R73](kapitola-10.md#r73-terminologie-kapitoly-10)).
- **Značka $s_{p_1-p_2}$** pro odhad směrodatné chyby rozdílu dvou nezávislých podílů, obdoba $s_{m_1-m_2}$. Pro směrodatnou chybu jednoho podílu se značka nezavádí, protože $s_p$ je společná směrodatná odchylka kapitoly 8. Rozvíjí [R69](#r69-znaceni-kapitoly-9).
- **Nové obrázky a tabulky:** pokrytí Waldova a Wilsonova intervalu (přesný výpočet; v souladu s R68 zůstává Waldův interval jen vysvětlujícím mezikrokem), konstrukce Newcombova intervalu se čtverci vzdáleností, vztah *z*² a chí-kvadrát rozdělení s jedním stupněm volnosti, deset možných tabulek Fisherova testu, simulované rozdělení statistiky, shody a neshody dvou posuzovatelů; tabulka Holmovy korekce; řádková procenta v tabulce fotografií; ukázka kontingenční tabulky podle APA.
- **Výklad:** zdůvodnění φ a Cramérova V (dělení *n* a největší možnou hodnotou χ², odmocnina), φ² jako součin rozdílu řádkových a sloupcových podílů a vzorec z četností, který může vyjít záporný; závěr testu jako výrok o populaci; význam levého chvostu chí-kvadrát rozdělení. Poznámka o Howellově údaji 28,8 % se ze studentského textu vypouští.
- **Řecké χ se ani v ukázkách zprávy podle APA nesází kurzivou.** Upřesňuje [R01](spolecne-konvence.md#r01-znaceni-a-reportovani) a R69; kurzivou zůstávají značky z latinky (*N*, *p*, *V*).
- ***z*-test s kurzivním *z*** platí už podle [R66](spolecne-konvence.md#r66-kurziva-a-et-al); v kapitole 9, slovníčku a registru byly opraveny tři nekurzivní výskyty. Nejde o novou volbu.
- Společná jazyková upřesnění („rozdělení“, nikoli „rozložení“; „četnost“ pro počet případů v kategorii) jsou zapsána jako [doplnění R76](spolecne-konvence.md#r76-doplneni-2026-11-16).

**Doklad:** autorovy připomínky ke kapitole 9 z 2026-11-16: „Asi bych jako hlavní termín používal ‚standardizvané reziduum‘, nikoli ‚upravené reziduum‘“; „Je ‚tabulka přechodů‘ skutečně vhodný český ekvivalent?“ (v následném dotazu zvolil možnost „Tabulka párových dat“); „Asi by bylo vhodné do kapitoly zahrnout kromě McNemarova testu i znaménkový test, který stojí na velmi podobných principech“ (zvolil možnost „Povinný pododdíl + nové cvičení 13“); „Představil bych srozumitelně i ten simulační postup na základě monte Carlo simulace testové statistky pod H0“; „Není vysvětleno, že se jedná o výpočet směrodatné chyby rozdílu mezi podíly a chybí její označení“; „χ je řecké písmeno, takže se kurzivou nepíše. Rovněž bych uvedl a ukázal, že pro více než dvě srovnávané kategorie je vhodné ukázat i kontingenční tabulku a jak by taková tabulka měla přesně podle APA vypadat“; „také u z-testu bych uváděl *z* kurzivou“. Termíny, značku $s_{p_1-p_2}$ a rozsah úprav autor schválil téhož dne schválením plánu revize. Provedení a kontroly eviduje [záznam o revizi](../../quarto/README.md#revize-kapitoly-9-2026-11-16).
