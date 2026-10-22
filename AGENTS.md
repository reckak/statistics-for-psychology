# Projektové instrukce: Základy statistiky pro psychology 1

## Použití projektové dokumentace

- Tento soubor obsahuje společná pravidla tvorby i ověřování. Další
  dokumenty načítej podle úkolu: rozcestník či registr, dotčené karty nebo
  doklady a relevantní pasáže; nečti automaticky celé složky dokumentace.
- Před obsahovou prací otevři [mapu obsahu učebnice](docs/OSNOVA.md),
  relevantní návaznosti a kartu dotčené kapitoly v `docs/kapitoly/`, potom
  příslušné pasáže kapitoly. Mapa zachycuje skutečný obsah existujících
  kapitol a odděleně plán další; nenahrazuje čtení textu ani dohodu o rozsahu.
  Vyhledej také relevantní řádky [registru rozhodnutí](docs/ROZHODNUTI.md),
  jejich platnost, hlavní místo pravidla a podle potřeby doklad
  v `docs/rozhodnuti/`. Termíny vybírej a reviduj podle
  [SLOVNIK.md](docs/SLOVNIK.md) a podklady podle [ZDROJE.md](docs/ZDROJE.md);
  postup určují oddíly „Terminologie a značení“ a „Zdroje a jejich použití“.
- Při každé obsahové změně průběžně aktualizuj dotčenou část mapy: obsah
  oddílů, cíle a vstupní znalosti, pojmy a postupy, příklady a vizualizace,
  soubory, pokrytí cvičeními, povinný/nepovinný rozsah a hranice učiva.
  Rozlišuj, co je vysvětleno, samostatně procvičeno, pouze zmíněno nebo
  odloženo. Podrobnosti udržuj v jediné kartě kapitoly. Při změně návazností
  uprav také tematický rozcestník a [plán pokračování](docs/kapitoly/plan-pokracovani.md);
  ověř odkazy a u karty uveď datum kontroly souladu s textem.
  Drobné jazykové opravy bez změny významu aktualizaci mapy nevyžadují.
- Plánovaná témata nevydávej za vytvořený ani schválený obsah. V plánu
  rozlišuj dohodnutý směr, schválený rozsah a otevřené návrhy; po vytvoření
  kapitoly zmapuj skutečný výklad včetně zadání a řešení, nikoli jen původní
  osnovu. Definice, úplné značení a zdrojové karty v mapě neduplikuj.
- Karta kapitoly odkazuje na zdrojové karty a jejich konkrétní části,
  nekopíruje jejich evidenci; při novém propojení doplň i zpětný odkaz ze
  zdrojové karty. Tematický odkaz sám nedokládá použití ani prostudování zdroje.
- Zachovávej stabilní ID i datované záznamy; při přesunu uprav příchozí
  a relativní odkazy a na původní adrese ponech odkaz na nové umístění.
  Podle doplnění [R32](docs/rozhodnuti/postupy-a-dokumentace.md#r32-propojene-mapy)
  z 2026-10-14 se již nezachovávají původní kotvy přesunutých karet
  v `docs/OSNOVA.md` ani archiv obecných pokynů `docs/rozhodnuti/historie-registru.md`
  s odkazovací sekcí v registru (původní znění je v Gitu); výjimka se netýká
  dokladů jednotlivých rozhodnutí. Aktuální odkazy musí zůstat funkční.
  Datum reorganizace nesmí nahrazovat datum skutečné obsahové kontroly.
- Vstupní rozcestník projektu je [README.md](README.md); provozní postupy
  a závislosti jsou v [docs/PROVOZ.md](docs/PROVOZ.md), historické autorské
  záznamy v [quarto/README.md](quarto/README.md).
- Výslovný pokyn uživatele pro aktuální úkol má přednost před těmito
  projektovými dokumenty. Při skutečně nejasném obsahovém rozporu se ptej
  a pokračuj na nezávislých částech. Již schválený postup znovu neschvaluj.

<a id="evidence-rozhodnuti"></a>

## Evidence rozhodnutí a hlavní místa informací

Každý typ informace má jedno hlavní místo údržby. Ostatní dokumenty na ně
odkazují; jejich stručné shrnutí nesmí vzniknout jako druhý úplný seznam
pravidel. Studentský výklad musí zůstat samostatně srozumitelný: vysvětlení
ve výkladu a referenční přehled pro studenty mají odlišnou didaktickou funkci.

| Typ informace | Hlavní místo údržby |
|---|---|
| Postup přípravy, psaní, revizí, ověřování a práce s Gitem | Tento `AGENTS.md`; zvláštní pravidla prezentací v [PREZENTACE.md](docs/PREZENTACE.md). |
| Příkazy, závislosti a provozní návody | [PROVOZ.md](docs/PROVOZ.md); kořenové README obsahuje jen rychlé spuštění a rozcestník. |
| Preferovaný termín, alternativy, významové hranice a výjimky | [SLOVNIK.md](docs/SLOVNIK.md); jeho doklad odkazuje na rozhodnutí. |
| Studentský výklad, definice, značky a vzorce | Příslušná kapitola a její studentské referenční přehledy; autorská evidence je plně nekopíruje. |
| Mapa skutečného obsahu, procvičení, návazností a otevřeného plánu | [OSNOVA.md](docs/OSNOVA.md) a odkazované kapitolové karty. |
| Pokrytí příkladů a cvičení datovými sešity | [DATA.md](docs/DATA.md). |
| Obsah zdroje, lokátory, nálezy, rozsah čtení a nezávislého ověření | [ZDROJE.md](docs/ZDROJE.md), odkazované zdrojové karty a společná historie kontrol podkladů. |
| Stručný přehled schválených voleb a jejich aktuální platnost | [ROZHODNUTI.md](docs/ROZHODNUTI.md); řádek odkazuje na hlavní místo pravidla a podrobný doklad. |
| Důvod, rozsah a doklad schválení včetně původního schváleného plánu | Tematický soubor v `docs/rozhodnuti/`, přístupný přes ID v registru. |
| Provedené úpravy, výsledky kontrol a jejich omezení | [quarto/README.md](quarto/README.md); podrobné nálezy ke zdroji nebo datům odkazuje na příslušnou evidenci. |

- Nové rozhodnutí eviduj při autorem schválené volbě, která omezuje budoucí
  obsah, terminologii, značení nebo pracovní postup. Běžné opravy, realizace
  již schváleného postupu a výsledky kontrol patří do historie práce.
  Žádost o posouzení, návrh nebo dokončení úpravy není schválením nové konvence.
- Před založením ID ověř, zda jde o novou volbu, upřesnění, nebo nahrazení.
  Upřesnění připoj jako datovaný doklad ke stávajícímu ID; novou či
  nahrazující volbu zapiš pod novým ID. Starší záznamy nepřečísluj.
  Eviduj stručný závěr, rozsah, důvod a konkrétní doklad souhlasu; místo
  kopií slovníku, kapitol či návodů připoj přesné odkazy.
- V registru udržuj stručné shrnutí, rozsah, platnost a odkazy. U změny
  označ původní rozhodnutí jako částečně nebo úplně nahrazené a uveď,
  které části a jakým rozhodnutím. Návrhy drž odděleně od schválených voleb.
  „Platné“ nedokládá dokončení práce ani odborné ověření materiálů.
- Původní schválené znění, doklady i historické záznamy zachovej, i když
  jsou nahrazeny; jejich tehdejší stav není automaticky současným pravidlem.
  Aktuální pravidlo aktualizuj v jeho hlavním místě; historické seznamy
  ani návody zpětně nesynchronizuj. Datovaný doplněk může vysvětlit změnu
  či opravit evidenci, nesmí předstírat jiné původní schválení.
- Schválený plán je dokladem dohody. Skutečný obsah a odchylky zachycuje
  kapitolová karta; změna kapitoly nepřepisuje zpětně schválený plán.
- Při dokončení dokumentační změny ověř hlavní místo každé nové informace,
  funkčnost odkazů a ID a jednoznačnost aktuální platnosti. Obsahově posuď,
  zda nevznikly dvě souběžně udržované kopie téhož pravidla. Automatická
  kontrola odkazů podle [provozního návodu](docs/PROVOZ.md#kontroly-a-github)
  tuto redakční kontrolu nenahrazuje.

## Cíl a cílová skupina

Vytvářej a udržuj odborně správná, samostatně srozumitelná česká skripta
pro jednosemestrální kurz Základy statistiky pro psychology 1, určený
studentům druhého ročníku bakalářského studia psychologie. Výstupem je
Quarto Book průběžně publikovaný na GitHubu jako web.

- Předpokládej pouze matematiku dokončené základní školy, žádnou
  předchozí znalost statistiky, R ani programování.
- Piš pro samostudium: text nesmí vyžadovat ústní dovysvětlení ani přístup
  k autorským podkladům. Pozdější kapitoly mohou navazovat na předchozí;
  potřebné znalosti připomeň a odkaž na jejich výklad.
- Rozsah přizpůsob jednomu semestru. Pokročilá rozšíření zařazuj jen
  s didaktickým důvodem a zřetelně je označ jako nepovinná.
- Hlavní výstup je web. Pracovní PDF vybrané kapitoly vytvářej pouze na
  výslovné vyžádání, bez automatického spouštění nebo publikování s webem.
  V PDF soustřeď řešení do samostatné části za všechna zadání; závěrečné
  přehledy zatím vynech. Ověřen je export kapitol 3, 4 a 5
  (viz [provozní návod](docs/PROVOZ.md#ruční-pdf-vybrané-kapitoly)).
  Finální knižní sazbu budeme řešit při finalizaci knihy; neomezuj kvůli
  ní současnou podobu webových materiálů.

## Příprava každé kapitoly

- Pracuj vždy na jedné výkladové kapitole. Před jejím napsáním s uživatelem
  dohodni rozsah, cíle učení, návaznosti, zdroje, příklady a očekávané
  dovednosti. Howell je východiskem osnovy, nikoli požadavkem probrat celou
  knihu během jednoho semestru.
- Součástí přípravy je seznam nových pojmů a symbolů s českými překlady,
  anglickými ekvivalenty, případnými alternativami a zdůvodněným doporučením.
  Nové termíny a značení používej ve studentském textu až po dohodě.
  Vyvstane-li potřeba během psaní, předlož ji k dohodě a pokračuj na
  nezávislých částech.
- Již schválené termíny a symboly znovu neotevírej bez věcného důvodu.
  Při změně aktualizuj všechna dotčená místa i přehledové kapitoly.
- Před zavedením referenční kapitoly nevydávej žádnou kapitolu za závaznou
  šablonu. Strukturu a délku přizpůsob tématu.
- Úvodní blok „Co budete po prostudování umět“ formátuj jako seznam
  s odrážkami (jedna dovednost či úzce související skupina na odrážku),
  nikoli jako odstavec. Doplňující poznámku, například o nepovinných
  rozšířeních, uveď jako větu pod seznamem.

## Zdroje a jejich použití

- U ucelených online příruček a dokumentace používej jednu bibliografickou
  položku pro celé dílo či dokumentační celek, nikoli pro jednotlivé stránky
  ani automaticky pro všechny publikace jedné organizace. V citaci v textu
  připoj název konkrétního oddílu či funkce jako přímý hypertextový odkaz;
  zachovej i potřebný podrobnější lokátor. Více částí téhož díla v jedné
  citaci sdruž pod jediného autora a rok. Rok odvozuj od poslední doložené
  aktualizace citovaného celku/verze, ne automaticky od data přístupu;
  přesné datum, dostupnou verzi a datum přístupu eviduj v bibliografii.
  Nedoložený rok nevymýšlej: výslovně schválenou redakční volbu odliš
  v autorské evidenci od ověřeného data. Schválené roky a výjimky uvádí
  [R42](docs/rozhodnuti/spolecne-konvence.md#r42-citace-dokumentace).
  V textu lze použít zavedenou zkratku NIST, v bibliografii celý název.
  Použij citační prefix `NIST, -@nistHandbook` a odkaz v příponě citace;
  rok i bibliografii nadále vytváří citeproc. Jde o schválenou redakční
  konvenci pro dokumentaci; ostatní publikace nadále cituj podle APA 7.
- Citace v textu i seznam literatury formátuj podle APA 7 společným stylem
  `styles/apa.csl` nastaveným v `_quarto.yml`, údaji v `references.bib`
  a citačním zápisem Quarta; citace ani bibliografii nesestavuj ručně.
  Zachovej českou lokalizaci citačních popisků. Je-li autor součástí věty,
  rok připoj přímo za jeho jméno a neopakuj jméno v závorce. U konkrétní
  pasáže uveď ověřenou stránku, kapitolu či oddíl, u doslovné citace vždy
  dostupný lokátor. Ověřuj úplnost záznamů včetně vydání, ročníku, čísla
  časopisu a DOI, pokud existuje; chybějící údaje nevymýšlej. Po změně
  citací zkontroluj vykreslené odkazy i seznam literatury včetně iniciál,
  pořadí autorů, letopočtů, kurzivy, velikosti písmen a funkčních DOI/URL.
- Hlavní odbornou a didaktickou oporou i východiskem pořadí témat je Howellova
  učebnice v `sources/učebnice/howell.pdf`. Před použitím ověř její přesný titul,
  vydání a bibliografické údaje; nevymýšlej čísla stran ani odkazy.
  Ani Howell či jiné podklady nejsou nezpochybnitelnou autoritou: sporná
  tvrzení ověřuj v odborné literatuře a oficiální dokumentaci, věcné rozpory
  a významné odchylky projednej s uživatelem.
- [ZDROJE.md](docs/ZDROJE.md) je inventář a tematický rozcestník; každý zdroj
  má kartu v `docs/zdroje/` s identitou, obsahovou mapou, přesnými lokátory,
  zjištěnými rozpory a rozsahem ověření. Společné nálezy a datované kontroly
  více podkladů jsou v [historii ověřování](docs/zdroje/HISTORIE.md).
  Rozcestník a karty slouží k dohledání pasáží, nikoli místo jejich čtení;
  nabídka témat není schválenou osnovou.
- Před návrhem nové kapitoly projdi aktuální obsah `sources/` včetně
  podsložek a porovnej jej s inventářem. U nových, změněných či nahrazených
  souborů ověř identitu, obsah a lokátory a aktualizuj kartu; u téhož zdroje
  zachovej její ID. Přejmenování či nové vydání nesmí ponechat neplatné
  odkazy. Posuď relevanci všech podkladů (učebnic, starších prezentací,
  příkladů i dalších souborů); nejasný název není důvodem k vyřazení bez
  nahlédnutí. U relevantních zdrojů prostuduj skutečný výklad, příklady,
  obrázky a podmínky použití. Obsah knihy, textová extrakce ani starší
  záznam neprokazují podrobné prostudování či odbornou správnost pasáže.
- V kartě rozlišuj identifikaci zdroje, mapu obsahu, skutečně prostudované
  části a nezávislé ověření. Uváděj datum a verzi souboru, konkrétní použití,
  zjištěné rozpory a přesně vymezené neověřené části. U PDF rozlišuj tištěnou
  stranu a pořadí stránky souboru; u prezentace číslo snímku, u úloh ID
  zadání i řešení a u sešitu list a buňky. Podezření z OCR či extrakce ověř
  v originálu, než je zapíšeš jako chybu zdroje. Čísla stran ani bibliografické
  údaje nedoplňuj odhadem. Nová zjištění zapisuj ke zdroji průběžně;
  schválené změny rozsahu či konvencí patří také do osnovy či rozhodnutí.
- Při projednávání kapitoly uveď, které podklady navrhuješ využít, k čemu
  a zda se v důležitých bodech rozcházejí. Starší prezentace a úlohy využij
  také k pochopení dosavadních priorit autora a způsobu procvičování; jejich
  věcnou správnost ověřuj jako u ostatních zdrojů. Relevantní soubor, který
  nelze přečíst, uveď jako mezeru a nevydávej jej za prostudovaný.
- Piš vlastní český výklad. U převzatých nebo upravených příkladů a zadání
  uveď konkrétní zdroj a rozlišuj převzetí, úpravu a vlastní inspiraci.
  Nepřebírej automaticky celé pasáže, tabulky či obrázky.
- Původní podklady zachovej. Složku `sources/` nezahrnuj do veřejného
  repozitáře ani webu; studentská cvičení na ní nesmějí záviset. Do veřejně
  verzované autorské mapy nevkládej kopie podkladů, celé extrahované texty,
  skeny ani neveřejná data. Odkazy mapy do `sources/` označ jako místní;
  mapa není studentská kapitola.

## Didaktika a jazyk

- Upřednostňuj konceptuální porozumění a přesné uvažování. Výpočty používej
  k objasnění principů a k získání výsledků, které student dokáže
  interpretovat; nezahlcuj text samoúčelným početním nácvikem. Odvození
  zařazuj, kde podporuje porozumění; náročnější může být nepovinné.
- Preferuj posloupnost: intuice → psychologický příklad → formální zápis
  → výpočet → interpretace a omezení, smysluplně, nikoli jako povinné nadpisy.
  Intuice může využívat analogie, přirovnání či metafory, pokud pomáhají
  pochopit podstatu; propoj je s přesným uvažováním, nenahrazuj jimi
  zdůvodnění závěru a upozorni na jejich meze, kde by mohly mást.
- Přizpůsobuj podrobnost začátečníkům, ale zachovej význam pojmů a logiku
  argumentace. Nepoužívej zjednodušení vytvářející mylné představy, které
  by se studenti museli odnaučovat; podstatné omezení platnosti vysvětli.
- Nový statistický i matematický pojem vysvětli před použitím, pokud možno
  na konkrétním, přednostně psychologickém příkladu, a výslovně ukaž, jak
  příklad ilustruje obecný význam. Přehledové kapitoly nenahrazují
  vysvětlení ve výkladu.
- Matematickou notaci používej střídmě: každý vzorec má objasnit vztah
  veličin, princip výpočtu nebo strukturu a předpoklady modelu. U nového
  vzorce vysvětli všechny symboly, co vztah říká, proč jej zavádíme,
  dosazení a podstatné mezikroky.
- Výklad nestav převážně na tom, co pojem neznamená nebo co z výsledku
  nelze vyvodit. Nejprve vysvětli, co pojem znamená, k čemu slouží a jaké
  závěry za daných podmínek umožňuje. Upozornění na časté omyly zařazuj
  účelně a vyvažuj je ukázkami správného použití a interpretace.
- Alternativní interpretace a odborné spory uváděj, když ovlivňují význam
  pojmu, volbu postupu nebo interpretaci. Pokročilé podrobnosti nepotřebné
  pro cíl učení přesuň do nepovinného rozšíření.
- Piš odbornou, přirozenou češtinou v souvislém výkladu, soustředěně
  a podpůrně: vysvětluj obtížná místa a běžné omyly, nenahrazuj výklad
  motivační řečí. Výčty, tabulky a zvýrazněné bloky používej, když pomáhají.
- Kde to usnadní pochopení pojmu, vztahu nebo principu postupu, zařazuj
  diagramy, schémata či grafy (např. schéma odlišující výběr z populace
  od přiřazení k podmínkám v první kapitole). Propoj je s výkladem
  a vysvětli, co znázorňují a čeho si všimnout. Volbu a počet řiď
  didaktickým přínosem; nejsou povinnou součástí každého oddílu.
- Preferuj příklady z psychologie a jasně popiš proměnné, jednotky a kontext.
  Úvod knihy jednou uvádí, že data jsou smyšlená, pokud není uvedeno jinak;
  v kapitolách to neopakuj. Výslovně označ skutečná, převzatá a upravená
  data se zdrojem a simulaci tam, kde je součástí výkladu.
- Rozvíjej porozumění principům, volbu metody, výpočet, interpretaci
  a rozpoznání chybných závěrů. Rozsah neomezuj na metody pohodlně
  vypočitatelné ručně.
- U výsledků vysvětli jejich význam v kontextu otázky; u grafů a tabulek
  komentuj podstatné vzorce, rozdíly či nejistotu, nejen čísla.
- Rozlišuj popis dat, statistickou inferenci a kauzální závěry. Vysvětluj
  relevantní předpoklady a omezení metod; nezaměňuj statistickou významnost
  za praktickou důležitost. Nevymýšlej výsledky ani citace.
- U modelů rozlišuj pozorovaná data, model a jeho předpoklady a vysvětluj,
  které závěry na předpokladech závisejí; modelové uvažování nepředstavuj
  jako oblast oddělenou od popisné a inferenční statistiky.

## Čitelnost a struktura textu

Číselné hodnoty níže jsou orientační vodítka; přednost má srozumitelnost
konkrétního místa.

- Úvod každého hlavního oddílu jednou až dvěma větami řekne, na jakou
  otázku oddíl odpovídá a jak navazuje na předchozí. Nadpisy formuluj
  obsahově, aby z nich bylo poznat, co se student dozví, nikoli jen téma.
- Každá výkladová kapitola končí před cvičeními oddílem „Shrnutí“
  s 5–8 klíčovými myšlenkami, z nichž každá odkazuje na oddíl s výkladem.
  Shrnutí nezavádí nové pojmy.
- Odstavec nese jednu hlavní myšlenku, kterou vyjadřuje jeho první věta.
  Věty delší než zhruba 35 slov rozděl, pokud tím neutrpí souvislost.
  Preferuj slovesné vyjádření před řetězci podstatných jmen („porovnáme
  průměry“, ne „provedení porovnání průměrů“). Nový odborný pojem při
  zavedení zvýrazni tučně.
- V jednom pododdílu zaváděj nejvýše dva až tři nové pojmy. Povinná část
  kapitoly má orientačně do 12 000 slov; odbočky, které cíle učení
  nevyžadují, přesuň do nepovinného rozšíření.
- Bloky používej jednotně a střídmě:
  - nepovinné rozšíření: `.callout-note collapse="true"` s titulkem
    „Nepovinné rozšíření: …“ a ID `#rozsireni-…`;
  - častý omyl: krátký `.callout-warning` s titulkem „Častý omyl: …“
    a ukázkou správné interpretace;
  - připomenutí dřívějšího učiva: krátký `.callout-tip` s titulkem
    „Připomenutí: …“ a odkazem na původní výklad;
  - řešení cvičení podle oddílu „Cvičení a řešení“.
- Popisek obrázku či tabulky sdělí hlavní zjištění nebo to, čeho si má
  student všimnout, nejen co je zobrazeno.

## Didaktická revize

- Po vytvoření nebo podstatné obsahové úpravě proveď didaktickou revizi
  dotčeného výkladu z hlediska vstupních znalostí studentů a cílů kapitoly.
  Nenahrazuje ji kontrola výpočtů a vykreslení, ani ona nenahrazuje odborné
  a technické ověřování. Rozsah přizpůsob změně: u drobné opravy dotčené
  místo a návaznosti, celou kapitolu při změně struktury či hlavního výkladu.
- Ověř, že student pozná, na jakou otázku pojem či postup odpovídá. Hledej
  nevysvětlené pojmy, nevyřčené předpoklady, příliš mnoho nových pojmů
  najednou a myšlenkové kroky samozřejmé jen odborníkovi. Posuď návaznost
  příkladu, obecného tvrzení, vzorce, dosazení a interpretace; u důležitých
  vztahů i vysvětlení, proč platí a za jakých podmínek.
- Hledej místa umožňující podstatnou chybnou interpretaci či záměnu
  souvisejících pojmů; podle potřeby doplň srovnání nebo kontrastní příklad
  (co zůstává stejné a co se mění), aniž bys předbíhal rozsah či zaváděl
  dosud nevysvětlené pojmy.
- Ověř, že příklady, vzorce, tabulky a grafy mají vysvětlený význam,
  podporují zamýšlenou dovednost a dávají podklady pro řešení cvičení
  včetně zdůvodnění a interpretace. Hledej chybějící odpovědi na „proč tento
  krok?“, „co výsledek znamená?“ a „jak to navazuje?“; nedělej z nich
  povinné bloky otázek ani cvičení uvnitř výkladu.
- Posuď hlavní myšlenku a návaznost odstavců, zbytečnou abstrakci
  a opakování bez nové funkce. Nedostatky oprav v rámci schváleného rozsahu
  bez nového schvalování a bez prodlužování textu bez didaktického přínosu;
  nový pojem, změna značení či rozšíření obsahu vyžadují dohodu.
- Součástí revize je čtení očima začátečníka se vstupními znalostmi podle
  kapitoly, případně samostatným agentem v roli studenta: vypiš místa, kde
  by se čtenář zasekl, a ověř vodítka oddílu „Čitelnost a struktura textu“.
  Délku vět a hustotu nových pojmů lze doplňkově zkontrolovat výpočtem.
- Interní didaktickou revizi nevydávej za ověření porozumění na studentech.

## Terminologie a značení

- [Autorský registr](docs/SLOVNIK.md) určuje platné terminologické preference
  pro učebnici i související materiály; před psaním i při revizi čti také
  pravidlo použití a doklad hesla, samotný seznam synonym nestačí.
  [Studentský slovníček](quarto/slovnicek.qmd) poskytuje vysvětlení a odkazy
  na výklad. Důvody, rozsah a doklady nových dohod zapisuj do dokladu
  v `docs/rozhodnuti/` a stručně do [registru rozhodnutí](docs/ROZHODNUTI.md);
  heslo odkazuje na doklad.
- Při prvním zavedení odborného pojmu uveď schválený český termín a v závorce
  anglický ekvivalent. Dále důsledně používej jednu schválenou českou
  variantu v kontextu určeném registrem. Alternativy eviduj v registru
  a slovníčku; při zavedení na ně případně upozorni, ve výkladu je
  nestřídej. Rozlišuj skutečná synonyma, související či širší/užší pojmy,
  protiklady a chybné podoby i v angličtině.
- Nové heslo nebo změnu preference zařaď mezi platná až po dohodě s autorem;
  připoj stav, doklad, rozsah použití, stabilní ID a odkazy na studentské
  heslo a první výklad. Návrhy a nejasně doložené volby drž odděleně.
  Výskyt termínu v kapitole, zdroji či slovníčku není jeho schválení.
  Registr rozlišuje konkrétní schválení od převzetí staršího dohodnutého celku.
- Při terminologické změně v témže úkolu aktualizuj registr, slovníček
  a všechna dotčená místa včetně cvičení, popisků a alternativních textů
  grafů, generátorů, sešitů, prezentací a poznámek; podle dopadu také
  značení, přehled Excelu a osnovu. Zkontroluj shodu názvů, významové výjimky
  a odkazy; rozsah kontroly, datum a omezení zapiš do autorské historie.
  Neprováděj slepé hromadné náhrady ani neoznačuj nezkontrolované materiály
  za sjednocené. Při přejmenování zachovej ID hesla.
- Aktuální výslovná dohoda má přednost před starším záznamem. Při rozporu
  ověř doklad a rozsah, slaď dokumenty a postupuj podle oddílu
  [Evidence rozhodnutí](#evidence-rozhodnuti). Skutečně nejasnou volbu
  projednej s autorem, doloženou platnou konvenci znovu neschvaluj.
- Výběrové charakteristiky označuj malými písmeny latinky v kurzivě;
  populační parametry řeckými písmeny ve stojatém řezu. Výběrový průměr
  označuj konzistentně kurzivním *m*.
- Výjimky ze značení jsou možné jen po předchozím schválení uživatelem.
  Schválené ukázky reportování podle APA 7 používají *M*, *Mdn*, *SD*, *N*
  a *n*; výpočetní značení učebnice tím neměň. Rozsah výjimky a zkratky
  MeanAD a MedAD eviduje
  [přehled rozhodnutí](docs/rozhodnuti/spolecne-konvence.md#r01-znaceni-a-reportovani).
- Předem dohodni i další značení, například dat, indexů, počtů a operátorů.
  Každý schválený symbol zaznamenej do přehledu značení, případně
  s běžnými alternativami a jasným označením používané varianty.
- Řecký znak sám nezaručuje stojatý řez: typografii ověř ve vykreslených
  rovnicích. Matematiku zapisuj přístupným textovým zápisem, ne obrázky.

## Výpočty, kalkulačka, Excel a interní R

- Preferuj ruční výpočty s kalkulačkou, pokud pomáhají pochopit postup,
  s přiměřeně malými daty a komentovanými mezikroky.
- Excel využívej pro obtížné či opakované výpočty, rozsáhlejší data
  a ke kontrole či usnadnění po zvládnutí ručního postupu; každý příklad
  nemusí být řešen oběma způsoby. Statistické tabulky nevyžaduj; potřebné
  hodnoty zpřístupni pomocí Excelu. Výjimkou je krátký seznam hodnot
  normovaného normálního rozdělení k zapamatování podle
  [R40](docs/rozhodnuti/kapitola-04.md#r40-hodnoty-zpameti).
- Používej české názvy funkcí a českou syntaxi Excelu; při zavedení funkce
  připoj její anglický název. Název, argumenty a chování ověřuj, nepřekládej
  odhadem.
- U excelového příkladu uveď vstupy a jejich buňky, vzorec, význam argumentů,
  vracený výsledek a interpretaci, případně nároky na verzi Excelu. Student
  musí mít vše potřebné k zopakování postupu.
- Dohodni a jednotně používej pravidla zaokrouhlování. Rozlišuj přesnost
  mezivýpočtů a prezentaci výsledku; u úloh uveď potřebnou toleranci.
- R používej interně pro ověřování výsledků, simulace a grafy. R kód ani
  technické výpisy nezobrazuj ve studentském webu; výsledky, grafy a tabulky
  zobraz s českými popisky a interpretací.
- Interní výpočty musí být reprodukovatelné bez objektů z předchozí
  interaktivní relace. Uveď závislosti a vstupy, používej relativní cesty
  a u náhodných postupů nastav seed. Neinstaluj balíčky během renderování.

## Data ke kapitolám

- Sešity sestavuj reprodukovatelnými skripty ovládajícími desktopový Excel
  pro Windows, společným generátorem `scripts/build-workbooks.ps1`
  a místními deklaracemi listů; tvorba ani ověřování nesmějí vyžadovat
  `@oai/artifact-tool`, runtime konkrétního LLM ani jinou neveřejnou knihovnu.
  Provozní příkazy a závislosti udržuj v [docs/PROVOZ.md](docs/PROVOZ.md).
- Excel spouštěj v samostatné skryté instanci, bez zásahu do otevřených
  uživatelských sešitů. Výsledek sestav a přepočítej v `tmp/`, teprve po
  úspěchu nahraď cílový sešit. Při chybě ukonči vlastní instanci a zachovej
  předchozí výstup. Běžné kontrolní skripty změny neukládají.
- Rozlišuj anglický zápis vzorců pro `Formula` od českého pro `FormulaLocal`;
  české vzorce z učebnice skutečně ověřuj v českém Excelu. Číselné formáty
  přizpůsob místním oddělovačům a zachovej datové typy včetně číselně
  vypadajícího textu a prázdných buněk.
- Při změně generátoru porovnej obsah a výsledky s předchozími sešity,
  ověř zachování listů, adres, vzorců, grafů a ověření vstupů. Spusť
  kapitolové kontroly Excelu a nezávislé číselné kontroly a vizuálně
  prohlédni dotčené listy a grafy. Zachovej obsah i oddělení vstupů od
  řešení; úspěšný zápis XLSX není ověřením funkčnosti.
- Ke každé výkladové kapitole poskytuj studentům jediný sešit
  `data/kapitola_NN.xlsx` se všemi zadanými datovými soubory i souhrnnými
  vstupy potřebnými k zopakování příkladů a vyřešení cvičení. Souběžné CSV
  studentům nenabízej; interní CSV pro generátory a kontroly nesmějí být
  součástí publikovaných studentských dat.
- Data rozděluj do výstižně pojmenovaných listů podle příkladů a cvičení;
  sdílená data mohou mít jeden list. Na prvním listu `Prehled` uveď
  návaznost na text, přesné oblasti buněk a vysvětli proměnné, jednotky,
  kódování, chybění a původ dat.
- Vstupy pro procvičení odděl od hotových výpočtů a řešení. Zachovej
  záměrně chybná data, jsou-li předmětem úlohy. Ze zadaných souhrnů
  nevymýšlej individuální pozorování; u čistě slovních úloh a modelových
  křivek bez datového souboru to v přehledu vysvětli.
- V kapitole odkazuj na jediný sešit a u konkrétní práce uveď list a buňky.
  Při každé změně příkladu či cvičení ověř úplnost, hodnoty, datové typy
  a chybění proti textu, uprav generátor i kontrolu sešitu a ověř dostupnost
  sešitu ve vykresleném webu. Pokrytí příkladů a cvičení udržuj v autorské
  dokumentaci.

## Cvičení a řešení

- Samostatná cvičení soustřeď na konec každé výkladové kapitoly, nikoli
  povinně za každý postup jako v R101; ve výkladu používej komentované
  řešené příklady.
- Soubor cvičení má pokrýt celý obsah a cíle kapitoly s přiměřeně
  odstupňovanou obtížností a bez zbytečného opakování obdobných úloh
  (opakování jen s jasným didaktickým účelem). Střídej výpočty, konceptuální
  otázky, volbu metody, interpretaci výsledků a rozpoznávání chybných argumentů.
- Cvičení mají ověřovat především porozumění: vysvětlit princip, zdůvodnit
  postup, použít poznatky v nové situaci a rozpoznat chybnou interpretaci,
  nikoli jen memorovat definice či mechanicky dosazovat.
- Zadání uvádí všechny potřebné vstupy a očekávané pomůcky a vychází
  z již vysvětlených pojmů a postupů.
- Ke každému cvičení připoj úplné vzorové nebo možné řešení s vysvětlením,
  mezikroky a relevantní interpretací; samotný výsledek nestačí.
- Zadání je vždy viditelné. Celé řešení včetně výsledků, tabulek, grafů
  a vysvětlení umísti bezprostředně pod něj do výchozím stavem sbaleného
  bloku `.callout-note collapse="true" title="Ukázat řešení"`.

## Tři závěrečné přehledové kapitoly

Za všemi výkladovými kapitolami udržuj vždy tyto tři kapitoly v uvedeném
pořadí; nové výkladové kapitoly zařazuj před ně. Přehledy doplňuj současně
s každou kapitolou, ne až při dokončení knihy.

1. **Slovníček pojmů:** preferovaný český termín, anglický ekvivalent,
   alternativní české překlady, vysvětlení a odkaz na první výklad.
   Jednoznačně označ překlad používaný v této učebnici.
2. **Matematické a statistické značení a vzorce:** používaný symbol či zápis,
   význam, vysvětlení jednotlivých prvků, výpočetní vztah tam, kde existuje,
   běžné alternativy značení a odkaz na výklad. Zahrň také potřebné
   matematické operátory a funkce, například sumaci a logaritmus.
3. **Užitečné funkce Excelu:** český název, anglický název, účel, argumenty,
   vracený výsledek, konkrétní příklad použití s výsledkem a odkaz na výklad.

- Všechny tři mají tabelární podobu; členění do více tematických tabulek
  je možné při zachování dobré dohledatelnosti.
- Vyhledávání prochází všechny řádky, nejen aktuální stránku, včetně
  českých a anglických názvů, alternativ a vysvětlení.
- Výchozí stránka má 10 řádků; nabídni také 25, 50 a všechny řádky.
  Ovládací prvky jsou srozumitelně česky.
- Jednotlivé položky mají stabilní odkazy; odkaz z výkladu zpřístupní
  cílový řádek i přes stránkování nebo aktivní filtr.
- Při zavádění tabulek ověř filtrování, stránkování, odkazy, čitelnost
  matematiky, ovládání klávesnicí a zobrazení na mobilu. Knihovnu zvol
  podle těchto požadavků; její připojení není ověřením funkčnosti.

## Studentský text a autorská dokumentace

- Studentský text musí obstát bez znalosti historie jeho vzniku.
  Neuváděj v něm zprávy o převodu podkladů, opravách původních materiálů,
  interním R kódu ani konfiguraci a renderování Quarta. Zachovej odborné
  citace, původ dat a vysvětlení analytických rozhodnutí potřebná
  k porozumění příkladu.
- Autorskou informaci udržuj v hlavním místě podle oddílu
  [Evidence rozhodnutí](#evidence-rozhodnuti). Nevydávej neexistující
  dokumenty či kontroly za zavedené a neduplikuj zde provozní návody.

## Uspořádání a ověřování Quarto Book

- Kniha používá `index.qmd` pro úvod, `quarto/` pro kapitoly a `_quarto.yml`
  pro společnou konfiguraci a pořadí `book.chapters`. Sdílené styly drž
  samostatně; lokální nastavení přepisuj jen z důvodu.
- Používej stabilní jedinečné identifikátory a křížové odkazy; čísla
  kapitol, obrázků a tabulek nevpisuj do odkazů ručně.
- Odkazy na obrázky a tabulky skloňuj. Holý `@fig-…` či `@tbl-…` se
  vykresluje v 1. pádě („Obrázek 4.1“); použij jej jen jako podmět věty
  nebo v závorce. V ostatních pádech napiš skloňované slovo malým písmenem
  a odkaz jen na číslo: `Na obrázku [-@fig-x]`, `v tabulce [-@tbl-x]`,
  `levá část obrázku [-@fig-x]` (viz [R49](docs/rozhodnuti/spolecne-konvence.md#r49-sklonovani-odkazu)).
- Upravuj zdroje, nikoli generované HTML v `_book/`. Generované výstupy
  a dočasné soubory neukládej do Gitu; zdrojové kontrolní skripty do něj patří.
- Po obsahové změně ověř výpočty, všechny vzorové odpovědi a render dotčené
  kapitoly. Po přidání kapitoly či změně společné konfigurace, stylů nebo
  navigace vykresli celou knihu a zkontroluj dotčené stránky a odkazy.
  Při změně pouze instrukcí či autorské dokumentace bez dopadu na web
  stačí kontrola obsahu a rozdílů.
- Ruční postupy i excelové příklady ověř proti nezávislému výpočtu.
  Shoda s interním R nepotvrzuje funkčnost vzorce v Excelu; ověř i správnost
  funkce a syntaxe a rozlišuj skutečně spuštěný excelový příklad od kontroly
  podle dokumentace či jiným nástrojem.
- Interpretace opírej o skutečně ověřené výsledky; grafy prohlédni
  i vizuálně. Po změně dat či výpočtu zkontroluj navazující text a řešení.
- Ve webu ověř úplné skrytí a rozbalení řešení, nezobrazení R kódu,
  typografii symbolů, obrázky, přehledové tabulky a mobilní zobrazení
  bez nechtěného vodorovného přetékání celé stránky.
- Kontrolu, kterou nelze provést, přesně uveď (co a proč zůstalo
  neověřené) v autorské dokumentaci i ve zprávě uživateli; nedeklaruj
  úplné ověření.

## Prezentace a poznámky pro vyučujícího

Před tvorbou nebo úpravou prezentace, poznámek či jejich exportu načti
a dodržuj [docs/PREZENTACE.md](docs/PREZENTACE.md). Společná odborná,
didaktická a terminologická pravidla tohoto souboru platí i pro ně;
konkrétní formát slidů a poznámek určuje specializovaný dokument.

## Git a dokončení práce

- Před prací ověř stav repozitáře. Soubory upravuj přímo v hlavní pracovní
  složce, i když obsahují necommitované změny; ty nejsou překážkou ani
  důvodem k další žádosti o souhlas. Přečti aktuální obsah a rozdíly vůči
  Gitu, navazuj na uživatelovu redakci a začleň změny do téhož souboru —
  zachovat rozpracované změny znamená zachovat jejich obsah a záměr.
- Kvůli necommitovaným změnám nevytvářej paralelní pracovní kopie,
  worktrees ani dočasné verze, které by se staly druhým místem úprav;
  oddělenou kopii použij jen na výslovnou žádost nebo při předem
  vysvětlené potřebě izolace. Záloha či pomocný soubor nesmí nahrazovat
  úpravu cílového souboru ani zanechat soupeřící verze výsledku.
- Při změně větve rozpracované změny bezpečně zachovej; neodstraňuj je
  ani neobnovuj starší obsah kvůli čistému stromu. Překrývající se změny
  spoj podle dohodnutého záměru, ptej se jen při skutečně nejasném konfliktu.
  Po dokončení ověř, že úplný výsledek je v souboru na očekávané cestě,
  nikoli jen v jiné kopii či na GitHubu.
- Větve: pro každou kapitolu nejvýše jedna `codex/chapter-01`,
  `codex/chapter-02` atd.; mimo výklad jedné kapitoly `codex/instructions`
  (autorská pravidla a samostatná údržba autorské dokumentace),
  `codex/presentations` (prezentace, poznámky a jejich sešity),
  `codex/infrastructure` (sestavení, publikování, společné styly, nástroje)
  a `codex/cross-chapter` (obsah napříč kapitolami). `codex/other` nově
  nepoužívej. Pro každý typ nejvýše jedna aktivní větev bez přípon dílčích
  úprav; změny rozlišuj commity a PR, nesouvisející úkoly dokončuj
  postupně v samostatných PR, další úpravy před sloučením patří do téže větve.
- Větev vybírej podle hlavního účelu úkolu, ne mechanicky podle typu
  souboru: přehledy, dokumentace, data a kontroly vyvolané změnou jedné
  kapitoly patří do její větve; samostatná práce na prezentaci do
  `codex/presentations`, i pro jedinou kapitolu; pravidla prezentací do
  `codex/instructions`. Nezakládej prázdné větve.
- Po uživatelově sloučení PR ověř zachování všech změn v aktuálním `main`
  a odstraň dokončenou větev lokálně i na GitHubu; další práci začni
  stejně pojmenovanou větví z aktuálního `origin/main`. Před odstraněním
  aktualizuj stav z GitHubu, prověř neodeslané commity a připojené pracovní
  kopie včetně nesledovaných a ignorovaných souborů; u změn převzatých pod
  jinými commity ověř obsahovou shodu. Jedinečné či rozpracované změny
  zachovej; uzavření PR ani smazání vzdálené větve nedokládá sloučení.
- Do commitu zahrň jen změny patřící k úkolu. Po kontrole commit odešli
  na GitHub a připrav pull request. Sloučení do `main` provádí uživatel:
  neposílej změny přímo do `main`, neslučuj za uživatele a nepřepisuj
  vzdálenou historii. Publikování webu navaž na schválené změny.
- V závěrečné zprávě shrň změny, podstatné opravy s místem a důvodem,
  výsledky kontrol a jejich omezení; uveď commit a odkaz na větev nebo PR.
  Pokud commit či odeslání selže, popiš skutečný stav a překážku.
