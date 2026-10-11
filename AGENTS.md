# Projektové instrukce: Základy statistiky pro psychology 1

## Použití projektové dokumentace

- Tento soubor obsahuje společná pravidla tvorby i ověřování. Další
  dokumenty načítej podle úkolu, nikoli všechny při každé drobné úpravě.
- Před obsahovou prací prostuduj dotčenou kartu a relevantní návaznosti v
  [mapě obsahu učebnice](docs/OSNOVA.md), potom příslušné pasáže kapitoly.
  Mapa zachycuje skutečný obsah existujících kapitol a odděleně plán další
  kapitoly; nenahrazuje čtení textu ani dohodu o novém rozsahu.
- Při každé obsahové změně průběžně aktualizuj dotčenou část mapy: obsah
  oddílů, cíle a vstupní znalosti, pojmy a postupy, příklady a vizualizace,
  soubory, pokrytí cvičeními, povinný/nepovinný rozsah a hranice učiva.
  Rozlišuj, co je vysvětleno, samostatně procvičeno, pouze zmíněno nebo
  odloženo. Při změně návazností uprav také tematický rozcestník a plán
  pokračování; ověř odkazy a u karty uveď datum kontroly souladu s textem.
  Drobné jazykové opravy bez změny významu aktualizaci mapy nevyžadují.
- Plánovaná témata nevydávej za vytvořený ani schválený obsah. V plánu
  rozlišuj dohodnutý směr, schválený rozsah a otevřené návrhy; po vytvoření
  kapitoly zmapuj skutečný výklad včetně zadání a řešení, nikoli jen původní
  osnovu. Definice, úplné značení a zdrojové karty v mapě neduplikuj.
- Před obsahovou prací vyhledej relevantní platná rozhodnutí v
  [docs/ROZHODNUTI.md](docs/ROZHODNUTI.md). Nová schválená rozhodnutí zde
  průběžně eviduj s rozsahem platnosti, důvodem a dokladem; nenahrazuj tím
  studentský slovníček ani přehled značení. Samotný návrh není schválení.
- Pro volbu termínů před psaním i při revizi používej
  [docs/SLOVNIK.md](docs/SLOVNIK.md), hlavní autorský registr platných
  českých preferencí, anglických ekvivalentů, alternativ a významových hranic.
  Čti také pravidlo použití a doklad hesla; samotný seznam synonym nestačí.
  Rozdělení odpovědnosti a údržbu určuje oddíl „Terminologie a značení“ níže.
- Pro výběr podkladů používej [docs/ZDROJE.md](docs/ZDROJE.md): inventář,
  obsahové mapy, přesné lokátory, zjištěné rozpory a rozsah ověření zdrojů.
  Nabídka témat v mapě není schválenou osnovou; postup její údržby je níže
  v oddílu „Zdroje a jejich použití“.
- Pravidla pro prezentace načítej při práci na prezentacích, poznámkách
  a jejich exportech podle odkazu v příslušném oddílu níže.
- Provozní postupy jsou v [README.md](README.md), historické autorské
  záznamy v [quarto/README.md](quarto/README.md). Historický záznam zachovej
  i po nahrazení rozhodnutí; jeho tehdejší stav není automaticky současným
  pravidlem. V přehledu rozhodnutí označ, co novější dohoda nahrazuje.
- Výslovný pokyn uživatele pro aktuální úkol má přednost před těmito
  projektovými dokumenty. Při skutečně nejasném obsahovém rozporu se ptej
  a pokračuj na nezávislých částech. Již schválený postup znovu neschvaluj.

## Cíl a cílová skupina

Vytvářej a udržuj odborně správná, samostatně srozumitelná česká skripta
pro jednosemestrální kurz Základy statistiky pro psychology 1, určený
studentům druhého ročníku bakalářského studia psychologie. Výstupem je
Quarto Book průběžně publikovaný na GitHubu jako web.

- Předpokládej pouze matematické znalosti na úrovni dokončené základní školy.
  Nepředpokládej předchozí znalost statistiky, R ani programování.
- Piš pro samostudium: text nesmí vyžadovat ústní dovysvětlení ani přístup
  k autorským podkladům. Pozdější kapitoly mohou navazovat na předchozí;
  potřebné znalosti připomeň a odkaž na jejich výklad.
- Rozsah přizpůsob jednomu semestru. Pokročilá rozšíření zařazuj jen
  s didaktickým důvodem a zřetelně je označ jako nepovinná.
- Nyní připravuj web. PDF a jeho sazbu budeme řešit samostatně při finalizaci
  knihy; neomezuj kvůli tomu současnou podobu webových materiálů.

## Příprava každé kapitoly

- Pracuj vždy na jedné výkladové kapitole. Před jejím napsáním s uživatelem
  prodiskutuj a dohodni rozsah, cíle učení, návaznosti, zdroje, příklady
  a očekávané dovednosti. Howell je východiskem osnovy, nikoli požadavkem
  probrat celou knihu během jednoho semestru.
- Součástí této přípravy je seznam nových pojmů a symbolů: nabídni české
  překlady, anglické ekvivalenty, případné alternativy a zdůvodněné doporučení.
  Nové odborné termíny a značení ve studentském textu používej až po dohodě.
- Pokud potřeba nového pojmu nebo symbolu vyvstane během psaní, předlož ji
  k dohodě; pokračuj v práci na částech, které na rozhodnutí nezávisí.
- Již schválené termíny a symboly znovu neotevírej bez věcného důvodu.
  Při změně aktualizuj všechna dotčená místa i přehledové kapitoly.
- Před zavedením referenční kapitoly nevydávej žádnou kapitolu za závaznou
  šablonu. Strukturu a délku přizpůsob tématu.
- Úvodní blok s cíli kapitoly („Co budete po prostudování umět“) formátuj
  jako seznam s odrážkami, jedna dovednost nebo úzce související skupina
  dovedností na odrážku, nikoli jako souvislý odstavec. Doplňující poznámku,
  například o nepovinných rozšířeních, uveď jako větu pod seznamem.

## Zdroje a jejich použití

- Citace v textu i seznam literatury ve všech kapitolách formátuj podle
  APA 7. Používej společný styl `styles/apa.csl` nastavený v `_quarto.yml`,
  bibliografické údaje v `references.bib` a citační zápis Quarta; výsledné
  citace ani bibliografii nesestavuj ručně. Zachovej českou lokalizaci
  citačních popisků. Je-li autor součástí věty, rok připoj přímo za jeho
  jméno a neopakuj jméno v závorce. U konkrétní pasáže uveď ověřenou
  stránku, kapitolu či oddíl, u doslovné citace vždy dostupný lokátor.
  Ověřuj úplnost záznamů včetně vydání, ročníku, čísla časopisu a DOI,
  pokud existuje; chybějící údaje nevymýšlej. Po změně citací zkontroluj
  vykreslené odkazy i seznam literatury, včetně iniciál, pořadí autorů,
  letopočtů, kurzivy, velikosti písmen v názvech a funkčních DOI/URL.
- Hlavní odbornou a didaktickou oporou i východiskem pořadí témat je Howellova
  učebnice v `sources/učebnice/howell.pdf`. Před použitím ověř její přesný titul,
  vydání a bibliografické údaje; nevymýšlej čísla stran ani odkazy.
- Před návrhem obsahu nové kapitoly projdi aktuální obsah `sources/`
  včetně všech podsložek a porovnej jej s inventářem v `docs/ZDROJE.md`.
  U nových, změněných či nahrazených souborů ověř identitu, obsah a lokátory
  a aktualizuj příslušnou kartu; zachovej její stabilní ID, pokud jde
  o tentýž zdroj. Přejmenování či nové vydání nesmí ponechat neplatné odkazy.
  Posuď relevanci všech podkladů: učebnic, starších prezentací, příkladů
  i dalších souborů. Nejasný název není důvodem zdroj bez nahlédnutí vyřadit.
- Tematický rozcestník a karty v `docs/ZDROJE.md` používej k dohledání
  pasáží, nikoli místo jejich čtení. U relevantních zdrojů před návrhem
  kapitoly prostuduj skutečný výklad, příklady, obrázky a podmínky použití.
  Samotný obsah knihy, textová extrakce ani starší záznam neprokazují
  podrobné prostudování či odbornou správnost dané pasáže.
- V mapě rozlišuj identifikaci zdroje, mapu obsahu, skutečně prostudované
  části a nezávislé ověření. Uváděj datum a verzi souboru, konkrétní použití,
  zjištěné rozpory a přesně vymezené neověřené části. U PDF rozlišuj tištěnou
  stranu a pořadí stránky souboru; u prezentace číslo snímku, u úloh ID
  zadání i řešení a u sešitu list a buňky. Podezření z OCR či extrakce ověř
  v originálu, než je zapíšeš jako chybu zdroje. Čísla stran ani bibliografické
  údaje nedoplňuj odhadem. Nová zjištění zapisuj ke zdroji průběžně;
  schválené změny rozsahu či konvencí patří také do osnovy či rozhodnutí.
- Při projednávání kapitoly uveď, které podklady navrhuješ využít, k čemu
  a zda se v důležitých bodech rozcházejí. Starší prezentace a úlohy využij
  také k pochopení dosavadních obsahových priorit autora a způsobu
  procvičování; jejich věcnou správnost ověřuj stejně jako u ostatních
  zdrojů. Howell zůstává hlavním odborným a didaktickým východiskem.
  Pokud relevantní soubor nelze přečíst, uveď tuto mezeru při projednávání
  a nevydávej jej za prostudovaný.
- Piš vlastní český výklad. U převzatých nebo upravených příkladů a zadání
  uveď konkrétní zdroj a rozlišuj převzetí, úpravu a vlastní inspiraci.
  Nepřebírej automaticky celé pasáže, tabulky či obrázky.
- Howell ani jiné podklady nejsou nezpochybnitelnou autoritou. Sporná tvrzení
  ověřuj v odborných zdrojích; věcné rozpory a významné odchylky projednej
  s uživatelem. Upřednostňuj odbornou literaturu a oficiální dokumentaci.
- Původní podklady zachovej. Složku `sources/` nezahrnuj do veřejného
  repozitáře ani publikovaného webu. Studentská cvičení nesmějí záviset
  na přístupu k této neveřejné složce. Do veřejně verzované autorské mapy
  nevkládej kopie podkladů, celé extrahované texty, skeny ani neveřejná data.
  Odkazy mapy do `sources/` označ jako místní; mapa není studentská kapitola.

## Didaktika a jazyk

- Upřednostňuj konceptuální porozumění a přesné uvažování. Výpočetní postupy
  používej k objasnění principů a k získání výsledků, které student dokáže
  interpretovat; nezahlcuj text samoúčelným početním nácvikem.
- Preferuj posloupnost: intuice → psychologický příklad → formální zápis
  → výpočet → interpretace a omezení. Používej ji smysluplně, nikoli jako
  povinné nadpisy každého oddílu.
- Intuitivní vysvětlení a analogie propojuj s přesným uvažováním. Nesmějí
  nahrazovat zdůvodnění závěru; upozorni na jejich meze tam, kde by mohly
  vést k chybnému pochopení.
- Přizpůsobuj podrobnost výkladu začátečníkům, ale zachovej význam pojmů
  a logiku argumentace. Nepoužívej zjednodušení, která vytvářejí mylné
  představy nebo by se studenti později museli odnaučovat. Pokud zjednodušení
  podstatně omezuje platnost tvrzení, toto omezení vysvětli.
- Nový statistický i matematický pojem vysvětli před použitím. U nového
  vzorce vysvětli všechny symboly, význam vztahu, dosazení a podstatné mezikroky.
  Přehledové kapitoly nenahrazují vysvětlení přímo ve výkladu.
- Každý nově zaváděný abstraktní pojem nebo vztah pokud možno objasni
  konkrétním, přednostně psychologickým příkladem. Výslovně vysvětli, jak
  příklad ilustruje obecný význam pojmu či vztahu; samotné uvedení příkladu
  nestačí.
- Výklad nestav převážně na tom, co pojem neznamená nebo co z výsledku
  nelze vyvodit. Nejprve vysvětli, co pojem znamená, k čemu slouží a jaké
  závěry umožňuje za uvedených podmínek. Upozornění na časté omyly a neplatné
  závěry zařazuj účelně a vyvažuj je konkrétními ukázkami správného použití
  a interpretace.
- Matematickou notaci používej střídmě a účelně. Každý vzorec má pomoci
  pochopit vztah mezi veličinami, princip výpočtu nebo strukturu a předpoklady
  modelu. Vedle vysvětlení symbolů vždy objasni, co vztah říká a proč jej
  zavádíme.
- Odvození zařazuj tam, kde podporuje porozumění; náročnější odvození může
  být nepovinným rozšířením. Nezahlcuj studenty mechanickými výpočty.
- Alternativní interpretace a odborné spory uváděj tehdy, když ovlivňují
  význam pojmu, volbu postupu nebo interpretaci výsledku. Pokročilé
  podrobnosti, které pro daný cíl učení nejsou potřebné, přesuň do nepovinného
  rozšíření.
- Piš odbornou, přirozenou češtinou v souvislém výkladu. Výčty, tabulky
  a zvýrazněné bloky používej, když pomáhají porozumění.
- Tam, kde usnadní pochopení pojmu, vztahu mezi pojmy nebo principu postupu,
  zařazuj do kapitoly názorné diagramy, schémata či grafy. Propoj je
  s výkladem a vysvětli, co znázorňují a čeho si má student všimnout.
  Příkladem je schéma odlišující výběr z populace od přidělení do podmínek
  v první kapitole. Volbu a počet vizualizací řiď jejich didaktickým přínosem;
  nejsou samoúčelnou ilustrací ani povinnou součástí každého oddílu.
- Piš soustředěně a podpůrně. Pomáhej studentům vysvětlením obtížných míst
  a běžných omylů; nenahrazuj odborný výklad obecnou motivační řečí.
- Preferuj příklady z psychologie a jasně popiš proměnné, jednotky a kontext.
  U dat rozlišuj skutečná, upravená a simulovaná data.
- Rozvíjej porozumění principům, volbu metody, výpočet, interpretaci
  a rozpoznání chybných závěrů. Rozsah obsahu neomezuj pouze na metody,
  které lze celé pohodlně vypočítat ručně.
- U výsledků vysvětli jejich význam v kontextu otázky. U grafů a tabulek
  komentuj podstatné vzorce, rozdíly či nejistotu; pouhý výpis čísel nestačí.
- Rozlišuj popis dat, statistickou inferenci a kauzální závěry. Vysvětluj
  relevantní předpoklady a omezení metod; nezaměňuj statistickou významnost
  za praktickou důležitost. Nevymýšlej výsledky ani citace.
- Při práci s modely rozlišuj pozorovaná data, model a jeho předpoklady.
  Vysvětluj, které závěry závisejí na přijatých předpokladech; nepředstavuj
  modelové uvažování jako oblast oddělenou od popisné a inferenční statistiky.

## Didaktická revize

- Po vytvoření nebo podstatné obsahové úpravě proveď didaktickou revizi
  dotčeného výkladu z hlediska vstupních znalostí studentů a cílů kapitoly.
  Kontrola výpočtů a vykreslení ji nenahrazuje; sama zase nenahrazuje
  odborné a technické ověřování popsané níže.
- Ověř, že student pozná, jakou otázku pojem či postup pomáhá zodpovědět.
  Hledej nevysvětlené pojmy, nevyřčené předpoklady, příliš mnoho nových
  pojmů současně a chybějící myšlenkové kroky, které mohou odborníkovi
  připadat samozřejmé. Posuď návaznost příkladu, obecného tvrzení, vzorce,
  dosazení a interpretace; u důležitých vztahů také vysvětlení toho,
  proč platí a za jakých podmínek.
- Hledej místa umožňující podstatnou chybnou interpretaci nebo záměnu
  souvisejících pojmů. Podle potřeby doplň srovnání či kontrastní příklad
  a vysvětli, co zůstává stejné a co se mění. Nepředbíhej dohodnutý rozsah
  ani nezaváděj dosud nevysvětlené pojmy jen kvůli takovému srovnání.
- Ověř, že příklady, vzorce, tabulky a grafy mají vysvětlený význam
  a podporují zamýšlenou dovednost. Posuď, zda výklad poskytuje podklady
  pro řešení navazujících cvičení, včetně zdůvodnění a interpretace.
  Hledej chybějící odpovědi na otázky „proč tento krok?“, „co výsledek
  znamená?“ a „jak to navazuje na předchozí učivo?“; nevytvářej z nich
  povinné bloky otázek ani další samostatná cvičení uvnitř výkladu.
- Posuď hlavní myšlenku a návaznost odstavců, zbytečnou abstrakci
  a opakování bez nové vysvětlující funkce. Zjištěné nedostatky oprav
  v rámci schváleného rozsahu, bez nového schvalování běžných oprav
  a bez prodlužování textu bez jasného didaktického přínosu.
- Vyžaduje-li oprava nový odborný pojem, změnu značení nebo rozšíření
  obsahu, postupuj podle pravidel pro jejich dohodnutí. Rozsah revize
  přizpůsob změně: u drobné opravy posuď dotčené místo a návaznosti,
  celou kapitolu při změně její struktury nebo hlavního výkladu.
- Interní didaktickou revizi nevydávej za ověření porozumění na studentech.

## Terminologie a značení

- [Autorský registr](docs/SLOVNIK.md) určuje platné terminologické preference
  pro učebnici i související materiály; [studentský slovníček](quarto/slovnicek.qmd)
  poskytuje vysvětlení a odkazy na výklad. Důvody, rozsah a doklady nových
  dohod zapisuj do [ROZHODNUTI.md](docs/ROZHODNUTI.md), v registru na ně odkazuj.
- Při prvním zavedení odborného pojmu uveď schválený český termín a v závorce
  anglický ekvivalent. V dalším výkladu důsledně používej jednu schválenou
  českou variantu v kontextu určeném registrem. Alternativy eviduj v registru
  a studentském slovníčku; upozorni na ně při zavedení, je-li to užitečné,
  ale systematicky je nestřídej ve výkladu. Rozlišuj skutečná synonyma,
  související či širší/užší pojmy, protiklady a chybné podoby i v angličtině.
- Nové heslo nebo změnu preference zařaď mezi platná až po dohodě s autorem;
  připoj stav, doklad, rozsah použití, stabilní ID a odkazy na studentské
  heslo a první výklad. Návrhy a nejasně doložené volby drž odděleně.
  Samotný výskyt termínu v kapitole, zdroji či slovníčku není jeho schválení.
  Registr rozlišuje konkrétní schválení od převzetí staršího dohodnutého celku.
- Při terminologické změně v témže úkolu aktualizuj registr, studentský
  slovníček a všechna dotčená místa včetně cvičení, popisků a alternativních
  textů grafů, generátorů, sešitů, prezentací a poznámek; podle dopadu také
  značení, přehled Excelu a osnovu. Zkontroluj shodu názvů, významové výjimky
  a odkazy; rozsah kontroly, datum a omezení zapiš do autorské historie.
  Neprováděj slepé hromadné náhrady ani neoznačuj nezkontrolované materiály
  za sjednocené. Při přejmenování zachovej ID hesla.
- Aktuální výslovná dohoda má přednost před starším záznamem. Při rozporu
  ověř doklad a rozsah, slaď dokumenty a označ nahrazené rozhodnutí;
  historické záznamy zachovej. Skutečně nejasnou volbu projednej s autorem,
  již doloženou platnou konvenci znovu neschvaluj.
- Výběrové charakteristiky označuj malými písmeny latinky v kurzivě;
  populační parametry řeckými písmeny ve stojatém řezu, bez kurzivy.
- Výběrový průměr označuj konzistentně kurzivním *m*.
- Výjimky z pravidla značení jsou možné pouze po předchozím schválení
  uživatelem. Schválené ukázky odborného reportování podle APA 7 používají
  značky *M*, *Mdn*, *SD*, *N* a *n*; výpočetní značení učebnice tím
  neměň. Rozsah této výjimky a rozlišující zkratky MeanAD a MedAD eviduje
  [přehled rozhodnutí](docs/ROZHODNUTI.md#r01-znaceni-a-reportovani).
- Předem dohodni i další nové značení, například dat, indexů, počtů
  a operátorů. Každý schválený symbol zaznamenej do přehledu značení,
  případně s běžnými alternativami a jasným označením používané varianty.
- Řecký znak sám o sobě nezaručuje stojatý řez: výslednou typografii ověř
  ve vykreslených rovnicích. Matematiku zapisuj jako přístupný textový
  matematický zápis, nikoli jako obrázky vzorců.

## Výpočty, kalkulačka, Excel a interní R

- Preferuj ruční výpočty s kalkulačkou, pokud pomáhají pochopit postup.
  Používej k nim přiměřeně malá data a komentované mezikroky.
- Excel využívej pro obtížné výpočty, rozsáhlejší data, opakované výpočty
  a jako možnost kontroly či usnadnění práce po zvládnutí ručního postupu.
  Není nutné každý příklad řešit oběma způsoby.
- Statistické tabulky nevyžaduj; potřebné hodnoty zpřístupni pomocí Excelu.
- Používej české názvy funkcí a českou syntaxi Excelu. Při zavedení funkce
  vždy připoj poznámku s jejím anglickým názvem. Název, argumenty a chování
  ověřuj; názvy funkcí nepřekládej odhadem.
- U excelového příkladu uveď vstupy, jejich umístění v buňkách, vzorec,
  význam argumentů, vracený výsledek a interpretaci. Upozorni na relevantní
  nároky na verzi Excelu. Student musí mít vše potřebné k zopakování postupu.
- Dohodni a jednotně používej pravidla zaokrouhlování. Rozlišuj přesnost
  mezivýpočtů a prezentaci výsledku; u úloh uveď potřebnou toleranci.
- R používej interně pro ověřování výsledků, simulace a tvorbu grafů.
  R kód ani technické výpisy nezobrazuj ve studentském webu. Smysluplné
  výsledky, grafy a tabulky zobraz s českými popisky a interpretací.
- Interní výpočty musí být reprodukovatelné bez objektů z předchozí
  interaktivní relace. Uveď závislosti a vstupy, používej relativní cesty
  a u náhodných postupů nastav seed. Neinstaluj balíčky během renderování.

## Data ke kapitolám

- Sešity sestavuj reprodukovatelnými skripty ovládajícími desktopový Excel
  pro Windows. Používej společný generátor `scripts/build-workbooks.ps1`
  a místní deklarace listů; tvorba ani ověřování nesmějí vyžadovat
  `@oai/artifact-tool`, runtime konkrétního LLM ani jinou neveřejnou knihovnu.
  Provozní příkazy a závislosti udržuj v kořenovém README.
- Excel spouštěj v samostatné skryté instanci, bez zásahu do otevřených
  uživatelských sešitů. Výsledek nejprve sestav a přepočítej v `tmp/`,
  teprve po úspěchu nahraď cílový sešit. Při chybě ukonči vlastní instanci
  a zachovej předchozí výstup. Běžné kontrolní skripty změny neukládají.
- Rozlišuj standardní anglický zápis vzorců pro `Formula` od českého
  zápisu pro `FormulaLocal`; české vzorce z učebnice skutečně ověřuj
  v českém Excelu. Číselné formáty přizpůsob místním oddělovačům a zachovej
  datové typy včetně číselně vypadajícího textu a prázdných buněk.
- Při změně generátoru porovnej obsah a výsledky s předchozími sešity,
  ověř zachování listů, adres, vzorců, grafů a ověření vstupů. Spusť
  kapitolové kontroly Excelu, nezávislé číselné kontroly a vizuálně
  prohlédni dotčené listy a grafy. Zachovej obsah i didaktické oddělení
  vstupů od řešení; samotný úspěšný zápis XLSX není ověřením funkčnosti.
- Ke každé výkladové kapitole poskytuj studentům jediný excelový sešit
  `data/kapitola_NN.xlsx`. Obsahuje všechny zadané datové soubory i souhrnné
  číselné vstupy potřebné k zopakování příkladů a vyřešení cvičení.
  Souběžné CSV studentům nenabízej; interní CSV mohou zůstat pro generátory
  a kontroly, ale nesmějí být součástí publikovaných studentských dat.
- Datové soubory rozděluj do výstižně pojmenovaných listů podle příkladů
  a cvičení. Stejná data sdílená více úlohami mohou používat jeden list.
  Na prvním listu `Prehled` uveď návaznost na text a přesné oblasti buněk.
  Vysvětli proměnné, jednotky, kódování, chybění a původ dat.
- Vstupy pro vlastní procvičení odděl od hotových výpočtů a řešení.
  Zachovej záměrně chybná data, pokud jsou předmětem úlohy. Ze zadaných
  souhrnů nevymýšlej individuální pozorování; u čistě slovních úloh a
  modelových křivek bez datového souboru tuto skutečnost v přehledu vysvětli.
- V kapitole odkazuj na jediný sešit a u konkrétní práce uveď list a buňky.
  Při každé změně příkladu či cvičení ověř úplnost, hodnoty, datové typy
  a chybění proti textu, uprav reprodukovatelný generátor i kontrolu sešitu.
  Ověř rovněž dostupnost sešitu ve vykresleném webu. Přehled pokrytí
  příkladů a všech cvičení udržuj v autorské dokumentaci.

## Cvičení a řešení

- Samostatná cvičení soustřeď na konec každé výkladové kapitoly.
  Nevkládej je povinně za každý nový postup jako v R101. Ve výkladu používej
  komentované řešené příklady.
- Střídej výpočty, konceptuální otázky, volbu metody, interpretaci výsledků
  a rozpoznávání chybných argumentů. Obtížnost přiměřeně odstupňuj.
- Soubor cvičení má pokrýt celý obsah kapitoly a její cíle učení bez
  zbytečného opakování obdobných úloh. Opakování zařazuj jen tehdy, má-li
  jasný didaktický účel.
- Cvičení mají ověřovat především skutečné porozumění: schopnost vysvětlit
  princip, zdůvodnit postup, použít poznatky v nové situaci a rozpoznat
  chybnou interpretaci. Neomezuj je na memorování definic ani mechanické
  dosazování do vzorců.
- Zadání musí uvádět všechny potřebné vstupy a očekávané pomůcky a vycházet
  z již vysvětlených pojmů a postupů.
- Ke každému cvičení připoj úplné vzorové nebo možné řešení, včetně
  vysvětlení, mezikroků a relevantní interpretace. Samotný výsledek nestačí.
- Zadání je vždy viditelné. Celé řešení umísti bezprostředně pod něj do
  výchozím stavem sbaleného bloku Quarto
  `.callout-note collapse="true" title="Ukázat řešení"`.
  Skryté musí být i výsledky, tabulky, grafy a vysvětlení řešení.

## Tři závěrečné přehledové kapitoly

Za všemi výkladovými kapitolami udržuj vždy tyto tři kapitoly v uvedeném
pořadí. Nové výkladové kapitoly zařazuj před ně. Přehledy doplňuj současně
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

- Všechny tři kapitoly musí mít tabelární podobu; tematické členění
  do několika tabulek je možné, pokud zachová dobrou dohledatelnost.
- Tabulky opatři vyhledáváním napříč všemi řádky, nejen aktuální stránkou.
  Vyhledávání musí zahrnout české a anglické názvy, alternativy a vysvětlení.
- Výchozí stránka má 10 řádků; nabídni také 25, 50 a všechny řádky.
  Používej srozumitelné české ovládací prvky.
- Zajisti stabilní odkazy na jednotlivé položky. Odkaz z výkladu musí
  zpřístupnit cílový řádek i přes stránkování nebo aktivní filtr.
- Při zavádění tabulek ověř filtrování, stránkování, odkazy, čitelnost
  matematiky, ovládání klávesnicí a zobrazení na mobilu. Konkrétní knihovnu
  zvol podle těchto požadavků; její pouhé připojení není ověřením funkčnosti.

## Studentský text a autorská dokumentace

- Studentský text musí obstát bez znalosti historie jeho vzniku.
  Neuváděj v něm zprávy o převodu podkladů, opravách původních materiálů,
  interním R kódu ani konfiguraci a renderování Quarta.
- Zachovej odborné citace, původ dat a vysvětlení analytických rozhodnutí,
  která student potřebuje pro porozumění příkladu.
- Provozní postupy udržuj v kořenovém `README.md`; podrobnosti o zdrojích,
  opravách, schválených rozhodnutích a provedeném ověření v historické
  autorské dokumentaci `quarto/README.md`. Platné terminologické preference
  udržuj v `docs/SLOVNIK.md`, rozhodnutí s důvody a doklady v
  `docs/ROZHODNUTI.md`, aktuální obsah, návaznosti a oddělený plán pokračování
  v `docs/OSNOVA.md`; pravidlo průběžné údržby mapy je v úvodním oddílu
  „Použití projektové dokumentace“.
  Nevydávej neexistující dokumenty či kontroly za již zavedené
  a neduplikuj provozní návody v těchto instrukcích.

## Uspořádání a ověřování Quarto Book

- Při založení knihy použij `index.qmd` pro úvod, `quarto/` pro kapitoly
  a `_quarto.yml` pro společnou konfiguraci a pořadí `book.chapters`.
  Sdílené styly drž samostatně; lokální nastavení přepisuj jen z důvodu.
- Používej stabilní jedinečné identifikátory a křížové odkazy.
  Čísla kapitol, obrázků a tabulek nevpisuj do odkazů ručně.
- Upravuj zdroje, nikoli generované HTML v `_book/`. Generované výstupy
  a dočasné soubory neukládej do Gitu; zdrojové kontrolní skripty do něj patří.
- Po obsahové změně ověř výpočty, všechny vzorové odpovědi a render dotčené
  kapitoly. Po přidání kapitoly či změně společné konfigurace, stylů nebo
  navigace vykresli celou knihu a zkontroluj dotčené stránky a odkazy.
- Ruční postupy i excelové příklady ověř proti nezávislému výpočtu.
  Shoda s interním R výpočtem sama nepotvrzuje funkčnost vzorce v Excelu;
  ověř i správnost použité funkce a syntaxe. Rozlišuj skutečně spuštěný
  excelový příklad od kontroly pomocí dokumentace a jiného nástroje.
- Konkrétní interpretace opírej o skutečně ověřené výsledky; grafy prohlédni
  i vizuálně. Po změně dat či výpočtu zkontroluj navazující text a řešení.
- Ve webu ověř úplné skrytí a rozbalení řešení, nezobrazení R kódu,
  typografii symbolů, obrázky, přehledové tabulky a mobilní zobrazení
  bez nechtěného vodorovného přetékání celé stránky.
- Pokud kontrolu nelze provést, přesně uveď co a proč zůstalo neověřené,
  v autorské dokumentaci i ve zprávě uživateli. Nedeklaruj úplné ověření.
- Při změně pouze instrukcí či autorské dokumentace bez dopadu na web
  zkontroluj obsah a rozdíly; nový render není nutný.

## Prezentace a poznámky pro vyučujícího

Před tvorbou nebo úpravou prezentace, poznámek či jejich exportu načti
a dodržuj [docs/PREZENTACE.md](docs/PREZENTACE.md). Společná odborná,
didaktická a terminologická pravidla tohoto souboru platí i pro ně;
konkrétní formát slidů a poznámek určuje specializovaný dokument.

## Git a dokončení práce

- Před prací ověř stav repozitáře a zachovej rozpracované uživatelské změny.
- Výchozím postupem je upravovat soubory přímo v hlavní pracovní složce
  projektu, také když již obsahují necommitované změny. Ty nejsou překážkou
  práce ani samy o sobě důvodem k další žádosti o souhlas. Před úpravou
  přečti aktuální obsah a rozdíly vůči Gitu, navazuj na uživatelovu redakci
  a začleň nové změny do téhož souboru. Zachování rozpracovaných změn
  znamená zachovat jejich obsah a záměr, nikoli se úpravě souboru vyhnout.
- Kvůli samotným necommitovaným změnám nevytvářej paralelní pracovní kopie,
  worktrees ani dočasné verze kapitoly, které by se staly druhým místem
  pro úpravy. Oddělenou pracovní kopii použij jen na výslovnou žádost
  uživatele nebo při konkrétní potřebě izolace, kterou předem vysvětlíš.
  Případná záloha či pomocný soubor pro kontrolu nesmí nahrazovat úpravu
  cílového souboru ani zanechat více soupeřících verzí výsledku.
- Tematická větev nevyžaduje jinou pracovní složku. Při změně větve
  bezpečně zachovej rozpracované změny; neodstraňuj je ani neobnovuj starší
  obsah jen pro získání čistého pracovního stromu. Pokud se změny překrývají,
  spoj je podle dohodnutého záměru; ptej se pouze při skutečně nejasném
  obsahovém konfliktu. Po dokončení ověř, že úplný aktuální výsledek je
  v souboru na uživatelem očekávané cestě, nikoli jen v jiné kopii či na GitHubu.
- Pro každou kapitolu používej nejvýše jednu aktivní pracovní větev
  `codex/chapter-01`, `codex/chapter-02` atd. Nevytvářej další větve
  s příponami podle dílčích úprav. Jednotlivé změny rozlišuj commity a PR;
  další úpravy před sloučením patří do stejné větve.
- Pro instrukce, společnou infrastrukturu a změny napříč knihou používej
  jedinou pracovní větev `codex/other`. Aktualizace přehledů související
  s konkrétní kapitolou patří do větve této kapitoly. Nesouvisející úkoly
  v `codex/other` dokončuj postupně, aby se nemíchaly v jednom PR.
- Po uživatelově sloučení PR ověř zachování všech změn v aktuálním `main`
  a odstraň dokončenou pracovní větev lokálně i na GitHubu, pokud ještě
  existuje. Při další práci ji vytvoř z aktuálního `origin/main` pod stejným
  názvem. Nezakládej prázdné větve pro kapitoly, na kterých se nepracuje.
- Před odstraněním větve aktualizuj stav z GitHubu a prověř neodeslané
  commity i připojené pracovní kopie včetně nesledovaných a ignorovaných
  souborů. Pokud změny přešly do `main` pod jinými identifikátory commitů,
  ověř jejich obsahovou shodu. Jedinečné nebo rozpracované změny zachovej;
  samotné uzavření PR ani odstranění vzdálené větve není dokladem sloučení.
- Do commitu zahrň pouze změny patřící k úkolu. Po kontrole vytvoř commit
  a odešli pracovní větev na GitHub; připrav změny k uživatelské kontrole
  a sloučení prostřednictvím pull requestu.
- Sloučení do `main` provádí uživatel. Neposílej pracovní změny přímo
  do `main`, neslučuj je za uživatele a nepřepisuj vzdálenou historii.
  Publikování webu navaž na schválené změny.
- V závěrečné zprávě shrň změny, podstatné opravy s místem a důvodem,
  výsledky kontrol a jejich omezení. Uveď commit a odkaz na větev nebo PR.
  Pokud commit či odeslání selže, popiš skutečný stav a překážku.
