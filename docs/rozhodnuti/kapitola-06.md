# Dohody k výběrovému rozdělení a testování

[Registr rozhodnutí a aktuální platnost](../ROZHODNUTI.md) · [Pravidla evidence](../../AGENTS.md#evidence-rozhodnuti)

Níže jsou zachovány původní záznamy schválených voleb, jejich důvody a doklady. Data, rozsah a formulace se vztahují k uvedeným dohodám; záznamy mohou obsahovat později nahrazené části nebo již provedené úkoly. Aktuální platnost a hlavní místo údržby určuje řádek v registru. Staré seznamy se při běžné aktualizaci slovníku, obsahu či pracovního postupu znovu nesynchronizují; nová schválená změna dostane vlastní datovaný doklad.

<a id="r28-rozsah-kapitoly-6"></a>

## R28 — Rozsah, pořadí a zásady výkladu kapitoly 6

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r28-rozsah-kapitoly-6). Původní záznam dohody:*

**Stav:** schváleno 2026-10-12. **Rozsah:** kapitola 6 „Výběrové rozdělení a testování hypotéz“, její cvičení, sešit a navazující přehledy. Výklad vznikl 2026-10-12; skutečný obsah dvanácti oddílů a dvě drobné odchylky od plánu eviduje [karta kapitoly 6](../kapitoly/06-vyberove-rozdeleni-testovani.md#mapa-kapitola-06).

**Členění a příklady**

- Jedna kapitola ve dvou blocích, deset až dvanáct větších oddílů. Blok A: výběrové rozdělení. Blok B: princip testování hypotéz.
- Každý oddíl rozvíjí jednu otázku od konkrétního příkladu přes vysvětlení k interpretaci. Nový pojem se zavádí s vysvětlením, čím přispívá k otázce kapitoly.
- Průběžným příkladem je parkovací studie podle autorovy přednášky `sampling_distribution.pptx` a Howella (s. 86–88).
- Binomický test a z-test průměru při známém σ jsou komentované řešené příklady ve výkladu; samostatná cvičení jsou na konci. U obou se ukazují společné kroky a to, co se mění.

**Pořadí výkladu**

- Kapitola začíná problémem: výsledky výběrů kolísají a je třeba posoudit, zda pozorovaný výsledek odpovídá určitému modelu.
- Nejdřív známý binomický příklad z kapitoly 5 (rozdělení počtu úspěchů a odvozené rozdělení podílu), potom výběrové rozdělení průměru.
- Před simulací přesný příklad: všech devět uspořádaných dvojic ze tří stejně pravděpodobných hodnot při výběru s vracením, s tabulkou výběrů, průměrů a rozdělení průměru a s řetězcem výběr → statistika → rozdělení statistiky.
- Před testováním úplný řešený výpočet pravděpodobnosti výběrového průměru ve známém modelu.
- Hypotézy a směr testu se stanovují před první p-hodnotou.

**Povinné, nepovinné a vynechané**

- **Povinně:** směrodatná chyba σ/√n a krátce její odhad s/√n; zákon velkých čísel a jeho odlišení od centrální limitní věty; centrální limitní věta slovně, simulací a s podmínkami; chyby I. a II. druhu a statistická síla pro konkrétní alternativy; velikost účinku v původních jednotkách; meze testování.
- **Nepovinná rozšíření:** odvození σ/√n; výpočet síly; standardizovaný rozdíl bez pásem malý–střední–velký; test jako screening; dvě tradice testování (stručně; přístup Jonese a Tukeyho jen zmínkou).
- **Mimo kapitolu:** intervaly spolehlivosti, t-rozdělení a t-testy, bootstrap, znaménkový test, funkce Z.TEST, korekce pro více testů, chí-kvadrát, korelace, bayesovské testování, plánování velikosti výběru. Pořadí dalších kapitol schváleno není.

**Zásady výkladu**

- **Tři úrovně:** důsledně oddělovat populaci, jeden výběr a výběrové rozdělení. U každého grafu říci, co představuje jedno pozorování nebo jedna hodnota na vodorovné ose. Velikost výběru odlišit od počtu opakování simulace.
- **Tři vrstvy příkladu:** skutečná parkovací studie, výukový model a simulovaná data. Označit původ naměřených souhrnů a vlastní modelové předpoklady. Vypočtené pravděpodobnosti jsou výsledky zvoleného modelu, ne reprodukce původní analýzy. Rovnost průměrů se nezaměňuje se shodou celých rozdělení.
- **Směrodatná chyba** se vykládá na stejném příkladu jako směrodatná odchylka: variabilita jednotlivých lidí versus kolísání výběrových průměrů. Odlišuje se od výběrové chyby jednoho odhadu a od systematického zkreslení.
- **Odhad s/√n:** σ obvykle neznáme a odhad směrodatné chyby mezi výběry kolísá. Nesmí vzniknout dojem, že nahrazením σ hodnotou s zůstává přesný z-test beze změny.
- **Zákon velkých čísel a centrální limitní věta:** první se týká přibližování průměru populační hodnotě, druhá tvaru vhodně standardizovaného rozdělení průměru. Zmenšování rozptýlenosti se odděluje od změny tvaru. Univerzální hranice n = 30 se nepoužívá. Větší výběr nemění rozdělení jednotlivých hodnot na normální.
- **Simulace** vysvětluje princip a má konečnou přesnost. Velmi malé pravděpodobnosti z normální aproximace se neprezentují jako přesné výsledky několika extrémních případů z 10 000 opakování.
- **Směr a extrémnost:** vysvětlit, které výsledky jsou extrémnější a proč. U jednostranných hypotéz odlišit celou nulovou hypotézu od hraniční hodnoty použité ve výpočtu.
- **Výsledek versus pravidlo:** p-hodnota, hladina významnosti a kritický obor se propojují na jednom příkladu; výsledek vypočtený z dat se odlišuje od předem stanoveného rozhodovacího pravidla. U diskrétního testu se ukáže, proč skutečná chybovost nemusí dosáhnout zvolené hladiny.
- **Síla:** β závisí na skutečné velikosti rozdílu, proto se vykládá pro konkrétní alternativní hodnoty. Porovnávací grafy zachovávají stejnou kritickou hranici a označují, zda jde o jednostranný, nebo oboustranný test.
- **Přesnost tvrzení:** přesná nulová hypotéza nemusí být vždy nepravdivá; samotný z-skór není test; výpočet chybovosti více testů vyžaduje uvedení podmínek. Stručně se připomene dodatečný výběr analýz a zastavování sběru podle průběžné významnosti.
- **Rozhodnutí testu a věcná interpretace:** u řešených příkladů vždy oba navazující kroky. Nejdřív „zamítáme nulovou hypotézu“ nebo „nulovou hypotézu nezamítáme“ na zvolené hladině. Potom návrat k výzkumné otázce se zřetelem ke směru a velikosti rozdílu, jeho nejistotě a uspořádání studie.
- **Podpora výzkumné hypotézy** se neodvozuje automaticky ze statistické významnosti: významný rozdíl v opačném než předpokládaném směru směrovou hypotézu nepodporuje. Při nezamítnutí není výzkumná hypotéza vyvrácena ani nulová potvrzena.
- **Vyváženost:** upozornění na omyly se vyvažují správnými interpretacemi. Student má umět formulovat přiměřený závěr a vysvětlit jeho oporu; totéž platí pro cvičení a jejich řešení.

**Menší volby schválené s návrhem:** hlavní test parkovacího příkladu je oboustranný, jednostranný slouží jako srovnání; přesný příklad používá doby 20, 35 a 50 s; vliv velikosti výběru na extrémní průměry se vyloží krátce u směrodatné chyby; výběrová rozdělení jiných statistik jedním odstavcem; funkce Excelu u řešených výpočtů bez samostatného oddílu; simulovaná data v sešitu jsou statická, ze skriptu se seedem.

**Důvod:** kapitola odpovídá jedné autorově přednášce a navazuje na dva otevřené konce kapitoly 5 (pravidla pro rozhodování a nepojmenovaná směrodatná odchylka podílu). Studenti mají binomický i normální aparát, proto mohou první testy sami spočítat.

**Odchylka od Howella:** σ/√n a centrální limitní věta se zařazují už sem; Howell je má až v kapitole 7 a kapitolu 4 vede bez výpočtů.

**Nahrazuje:** stav „žádný schválený plán“ v osnově ve znění z 2026-10-11. Výčet témat mimo kapitolu 5 v [R21](kapitola-05.md#r21-rozsah-kapitoly-5) zůstává historickým záznamem.

**Doklad:** autorovy volby při projednání 2026-10-12: „Jedna kapitola, dva bloky“, „Parkování jako páteř“, „Binomický test i z-test“, intervaly spolehlivosti „Odložit do další kapitoly“ a všechna čtyři nabídnutá rozšíření. Návrh potom čtyřikrát vrátil s pokyny, mimo jiné: „Původních 23 položek spoj přibližně do 10–12 větších výkladových oddílů. Každý oddíl má rozvíjet jednu otázku od konkrétního příkladu přes vysvětlení k interpretaci.“; „Nejdříve využij známý binomický příklad z kapitoly 5.“; „Před velkou simulaci vlož krátký přesný příklad: všechny uspořádané dvojice ze tří stejně pravděpodobných hodnot při výběru s vracením.“; „Důsledně rozliš skutečnou parkovací studii, výukový model a simulovaná data.“; „Povinně krátce vysvětli odhad směrodatné chyby pomocí s/√n.“; „Zákon velkých čísel krátce pojmenuj a vysvětli v hlavním textu.“; „Hypotézy a směr testu stanov před první p-hodnotou.“; „Sílu vysvětluj pro konkrétní alternativní hodnoty.“; „Standardizovaný rozdíl přesuň do krátkého nepovinného bloku.“; „Rozlišuj rozhodnutí statistického testu a interpretaci vzhledem k výzkumné hypotéze.“ Po zapracování návrh schválil. Záznam „Kapitola 6: dohoda o obsahu“ v [historii](../../quarto/README.md#dohoda-kapitola-06).

<a id="r29-znaceni-kapitoly-6"></a>

## R29 — Značení kapitoly 6

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r29-znaceni-kapitoly-6). Původní záznam dohody:*

**Stav:** schváleno 2026-10-12. **Rozsah:** kapitola 6, přehled značení a další použití v učebnici a souvisejících materiálech.

- Nulová hypotéza **H₀**, alternativní **H₁**; **μ₀** pro hraniční hodnotu podle nulové hypotézy.
- Dvě skupiny: populační průměry μ₁ a μ₂, výběrové průměry m₁ a m₂.
- Směrodatná chyba průměru: **σ s indexem m** (σ stojatě, m kurzivou), rovná σ/√n. Její odhad: **s s indexem m**, rovný s/√n. Zkratka SE jen v označených ukázkách reportování.
- Pravděpodobnosti chyb **α** a **β** stojatě jako ostatní řecké značky.
- **p-hodnota se ve výkladu vypisuje slovy.** Kurzivní p zůstává podílem a relativní četností ([R02](kapitola-02.md#r02-indexy-a-cetnosti), [R22](kapitola-05.md#r22-znaceni-pravdepodobnosti)). Kurzivní p pro p-hodnotu je přípustné jen v označených ukázkách reportování podle APA 7, obdobně jako výjimka [R01](spolecne-konvence.md#r01-znaceni-a-reportovani).
- Testová statistika z-testu kurzivním z; d pro standardizovaný rozdíl jen v nepovinném bloku.

**Důvod:** dodržet pravidlo o řeckých značkách pro parametry a latince pro výběrové charakteristiky a zabránit záměně p-hodnoty s podílem, kterou předjímalo už R22.

**Doklad:** značení bylo součástí návrhu, který autor po čtyřech úpravách schválil; ke značení samotnému připomínku neměl. Záznam „Kapitola 6: dohoda o obsahu“ v [historii](../../quarto/README.md#dohoda-kapitola-06).

<a id="r30-terminologie-kapitoly-6"></a>

## R30 — Terminologie kapitoly 6

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r30-terminologie-kapitoly-6). Původní záznam dohody:*

**Stav:** schváleno 2026-10-12. **Rozsah:** kapitola 6, slovníček, přehledy a další použití pojmů. Úplný seznam s anglickými ekvivalenty a alternativami je v [registru](../SLOVNIK.md#kapitola-06); zde jsou rozhodující rozlišení a doklad.

- **Výběrové rozdělení** (*sampling distribution*). Při zavedení úplněji „výběrové rozdělení statistiky“ a na konkrétních příkladech, například „výběrové rozdělení průměru“. Jasně odlišit od rozdělení hodnot v jednom výběru.
- **Výběrová variabilita, výběrová chyba, směrodatná chyba** jsou tři různé pojmy. Výběrová variabilita je proměnlivost výsledků mezi výběry. Výběrová chyba (*sampling error*) je v tomto výkladu rozdíl mezi výběrovým odhadem a populačním parametrem; text upozorní, že literatura termín užívá v různé šíři. Směrodatná chyba (*standard error*) je směrodatná odchylka výběrového rozdělení.
- **Směrodatná chyba** je hlavní termín; „standardní chyba“ a „střední chyba“ jsou alternativy ve slovníčku.
- **Statistická síla** (*statistical power*) je hlavní termín; „síla testu“ je alternativa. Jde o pravděpodobnost zamítnutí nulové hypotézy při konkrétní uvažované alternativě a daném uspořádání testu, nikoli o neměnnou vlastnost pojmenované metody.
- **Kritický obor** (*critical region, rejection region*) je hlavní termín. Uvádí se také „oblast zamítnutí“ jako doslovnější, méně zavedený překlad, který přímo vystihuje funkci. Jde o hodnoty testové statistiky, při nichž podle zvoleného pravidla zamítáme nulovou hypotézu. **Kritická hodnota** vymezuje jeho hranici.
- **Velikost účinku** (*effect size*) je hlavní termín; „velikost efektu“ je synonymum. Slovo „účinek“ samo neopravňuje ke kauzálnímu závěru a velikost účinku není totéž co jeho významnost.
- **Věcná významnost** (*substantive significance*) a **praktická významnost** (*practical significance*) se rozlišují. Věcná označuje důležitost výsledku pro zkoumanou otázku včetně teoretického významu, praktická důležitost jeho důsledků pro praxi. Text upozorní, že se oba termíny v literatuře někdy zaměňují. Obě se odlišují od statistické významnosti.
- **Formulace rozhodnutí:** „zamítáme nulovou hypotézu“ a „nulovou hypotézu nezamítáme“. Nezamítnutí se neformuluje jako potvrzení ani prokázání nulové hypotézy.
- Ostatní hesla registru byla schválena jako součást předloženého návrhu: odhad směrodatné chyby, zákon velkých čísel, centrální limitní věta, testování hypotéz, výzkumná a statistická hypotéza, nulová a alternativní hypotéza, testová statistika, p-hodnota, hladina významnosti, statisticky významný výsledek, chyba I. a II. druhu, jednostranný a oboustranný test, standardizovaný rozdíl průměrů, z-test a binomický test.

**Důvod:** jednoznačné názvy bez záměny souvisejících pojmů. „Směrodatná chyba“ jazykově ukazuje vztah ke směrodatné odchylce a neplete se se standardními skóry z kapitoly 4.

**Nahrazuje:** pracovní označení „standardní chyba“ v osnově a ve výčtu R21; R21 zůstává historickým záznamem. Zpřesňuje pravidlo hesla výběrová variabilita v registru.

**Doklad:** autorova volba „Směrodatná chyba“ a pokyny z 2026-10-12: „Sampling distribution → výběrové rozdělení. Při zavedení používej úplnější označení ‚výběrové rozdělení statistiky‘“; „Rozlišuj výběrovou variabilitu, výběrovou chybu a směrodatnou chybu.“; „Statistical power → statistická síla jako hlavní termín; síla testu jako alternativa.“; „Critical region / rejection region → kritický obor jako hlavní termín. Uveď také oblast zamítnutí“; „Effect size → velikost účinku jako hlavní termín; velikost efektu uveď jako synonymum.“; „Zachovej srozumitelné rozhodovací formulace ‚zamítáme nulovou hypotézu‘ a ‚nulovou hypotézu nezamítáme‘.“; „Substantive significance → věcná významnost a practical significance → praktická významnost v učebnici rozlišuj.“ Záznam „Kapitola 6: dohoda o obsahu“ v [historii](../../quarto/README.md#dohoda-kapitola-06).

<a id="r56-p-hodnota-cohen"></a>

## R56 — Kurzivní *p* pro p-hodnotu a Cohenova pásma

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r56-p-hodnota-cohen). Původní záznam dohody:*

**Stav:** schváleno 2026-10-31. **Rozsah:** celá učebnice (kapitoly 6 a 7, slovníček, přehled značení, přehled Excelu, popisky grafů); Cohenova pásma jen nepovinné rozšíření o standardizovaném rozdílu průměrů v kapitole 6.

- **p-hodnota se píše s kurzivním malým *p*:** „*p*-hodnota“, i na začátku věty a v nadpisu. Samotné *p* je přípustné tam, kde z kontextu nehrozí záměna s podílem nebo relativní četností; kde by záměna hrozila (např. u testu o podílu), píše se celé označení *p*-hodnota. Ve vzorcích $p\text{-hodnota}$. Částečně nahrazuje [R29](#r29-znaceni-kapitoly-6), bod o vypisování p-hodnoty slovy; kurzivní *p* jako podíl ([R02](kapitola-02.md#r02-indexy-a-cetnosti), [R22](kapitola-05.md#r22-znaceni-pravdepodobnosti)) zůstává.
- **Cohenova orientační pásma** d ≈ 0,2, 0,5 a 0,8 (malý, střední, velký účinek) se uvádějí v nepovinném rozšíření s výhradou, že je sám Cohen považoval za hrubé vodítko pro případ, kdy chybí lepší podklad ([Howell, s. 214 a 235](../zdroje/U01-howell.md)). Přednost má posouzení v kontextu a v původních jednotkách. Částečně nahrazuje [R30](#r30-terminologie-kapitoly-6) v pravidle hesla standardizovaný rozdíl průměrů („obecná pásma nezařazovat“).

**Důvod:** zápis odpovídá běžné odborné praxi a APA; záměnu s podílem řeší kontext a delší tvar. Cohenova pásma studenti v literatuře potkají a mají znát jejich omezení.

**Doklad:** autorovy připomínky ke kapitole 6 z 2026-10-31: „p-hodnotu bych psal s malým kurzivním p. Taky bych se nebál použít ji zapsat někdy jenom kurzivním p, i když tak označujeme i podíly; prostě bych uvedl, že kdyby mohlo dojít k záměně, použijeme delší označení ‚p-hodnota‘, nejen ‚p‘.“ a „Já bych Cohenova přibližná pravidla uvedl, ale s upozorněním, že sám Cohen je doporučoval používat spíš v případě nouze, pokud nemáme jiná vodítka.“ Při upřesnění autor zvolil platnost „Celá kniha“ a zápis „Vždy malé *p*“. Záznam „Kapitola 6: revize podle autorových připomínek“ v [historii](../../quarto/README.md#revize-kapitola-06-2026-10-31).

<a id="r57-rozdeleni-p-omyly"></a>

## R57 — Rozdělení *p*-hodnot a mylné představy jako nepovinná rozšíření kapitoly 6

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r57-rozdeleni-p-omyly). Původní záznam dohody:*

**Stav:** schváleno 2026-11-01. **Rozsah:** kapitola 6, její cvičení, sešit a bibliografie; rozšiřuje nepovinnou část schváleného plánu [R28](#r28-rozsah-kapitoly-6), povinná část se nemění.

- **Nepovinné rozšíření o rozdělení *p*-hodnot:** rovnoměrné rozdělení za platnosti nulové hypotézy, posun k malým hodnotám s rostoucí silou, jev, kdy je *p*-hodnota těsně pod 0,05 při vysoké síle pravděpodobnější za platnosti nulové hypotézy než za uvažované alternativy, a z toho plynoucí úvaha o přísnější hladině (např. 0,01), je-li síla vysoká pro všechny rozdíly, na kterých záleží. Výklad zůstává v jazyce pravděpodobností výsledků za dvou modelů; bayesovské testování a poměr věrohodností zůstávají mimo kapitolu podle R28.
- **Nepovinné rozšíření o nejčastějších mylných představách o *p*-hodnotě:** omyly se formulují popisně jako mylné výroky se správnou formulací; nové české názvy omylů se nezavádějí. Lindleyho paradox se jednou zmíní jménem s odkazem na Lakense a nezařazuje se do slovníčku.
- **Nepovinná cvičení 15 a 16** se vstupy v sešitu kapitoly.
- **Citace Lakensovy knihy:** rok 2026, verze 1.6.3, adresa webové knihy, bez DOI, protože DOI z autorovy doporučené citace identifikuje verzi 1.0.0 ([karta U16](../zdroje/U16-lakens-kniha.md#u16)). Jde o použití [R42](spolecne-konvence.md#r42-citace-dokumentace) na průběžně aktualizovanou online knihu.

**Důvod:** obě témata prohlubují porozumění *p*-hodnotě a síle bez nových povinných pojmů; nově zmapované zdroje [U16](../zdroje/U16-lakens-kniha.md#u16) a [D13](../zdroje/D13-kline.md#d13) je přímo podporují.

**Doklad:** autorův návrh z 2026-11-01: „Myslím, že kapitola 6 by mohla obsahovat nepovinné rozšíření týkající se vysvětlení nejčastějších mylných představ ohledně p-hodnot. A také nepovinné rozšíření ohledně toho, jak vypadá rozdělení p-hodnot samotných za různých podmínek, a že když disponujeme vysokou statistickou silou, jsou některé p-hodnoty pod 0,05 paradoxně pravděpodobnější, když nulová hypotéza platí, než když neplatí. Proto může dávat v takových případech smysl používat konzervativnější hladinu statistické významnosti, např. 0,01.“ Při upřesnění autor zvolil citaci „2026, verze 1.6.3“, „Ano, dvě cvičení“ a pojmenování „Popisně, paradox jménem“ a schválil předložený plán.
