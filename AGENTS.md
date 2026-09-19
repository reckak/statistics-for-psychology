# Projektové instrukce: Základy statistiky pro psychology 1

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

## Zdroje a jejich použití

- Hlavní odbornou a didaktickou oporou i východiskem pořadí témat je Howellova
  učebnice v `sources/howell.pdf`. Před použitím ověř její přesný titul,
  vydání a bibliografické údaje; nevymýšlej čísla stran ani odkazy.
- Ve složce `sources/` mohou být další podklady. Před přípravou kapitoly
  posuď relevantní zdroje a podle potřeby navrhni jejich využití.
- Piš vlastní český výklad. U převzatých nebo upravených příkladů a zadání
  uveď konkrétní zdroj a rozlišuj převzetí, úpravu a vlastní inspiraci.
  Nepřebírej automaticky celé pasáže, tabulky či obrázky.
- Howell ani jiné podklady nejsou nezpochybnitelnou autoritou. Sporná tvrzení
  ověřuj v odborných zdrojích; věcné rozpory a významné odchylky projednej
  s uživatelem. Upřednostňuj odbornou literaturu a oficiální dokumentaci.
- Původní podklady zachovej. Složku `sources/` nezahrnuj do veřejného
  repozitáře ani publikovaného webu. Studentská cvičení nesmějí záviset
  na přístupu k této neveřejné složce.

## Didaktika a jazyk

- Preferuj posloupnost: intuice → psychologický příklad → formální zápis
  → výpočet → interpretace a omezení. Používej ji smysluplně, nikoli jako
  povinné nadpisy každého oddílu.
- Nový statistický i matematický pojem vysvětli před použitím. U nového
  vzorce vysvětli všechny symboly, význam vztahu, dosazení a podstatné mezikroky.
  Přehledové kapitoly nenahrazují vysvětlení přímo ve výkladu.
- Odvození zařazuj tam, kde podporuje porozumění; náročnější odvození může
  být nepovinným rozšířením. Nezahlcuj studenty mechanickými výpočty.
- Piš odbornou, přirozenou češtinou v souvislém výkladu. Výčty, tabulky
  a zvýrazněné bloky používej, když pomáhají porozumění.
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

## Terminologie a značení

- Při prvním zavedení odborného pojmu uveď schválený český termín a v závorce
  anglický ekvivalent. V dalším výkladu důsledně používej jednu schválenou
  českou variantu. Alternativy eviduj ve slovníčku, nikoli jako střídající
  se synonyma ve výkladu.
- Výběrové charakteristiky označuj malými písmeny latinky v kurzivě;
  populační parametry řeckými písmeny ve stojatém řezu, bez kurzivy.
- Výběrový průměr označuj konzistentně kurzivním *m*.
- Výjimky z pravidla značení jsou možné pouze po předchozím schválení
  uživatelem. Zatím žádné schválené výjimky nejsou.
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
  opravách, schválených rozhodnutích a ověření v autorské dokumentaci,
  například `quarto/README.md`. Nevydávej neexistující dokumenty či kontroly
  za již zavedené a neduplikuj provozní návody v těchto instrukcích.

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

## Git a dokončení práce

- Před prací ověř stav repozitáře a zachovej rozpracované uživatelské změny.
- Každou kapitolu připravuj v samostatné tematické větvi s prefixem `codex/`.
  Další úpravy nesloučené kapitoly patří do stejné větve; po sloučení založ
  pro nový úkol novou větev z aktuálního `main`.
- Instrukce a společnou infrastrukturu upravuj ve vlastních tematických
  větvích. Aktualizace přehledů související s kapitolou patří do její větve.
- Do commitu zahrň pouze změny patřící k úkolu. Po kontrole vytvoř commit
  a odešli pracovní větev na GitHub; připrav změny k uživatelské kontrole
  a sloučení prostřednictvím pull requestu.
- Sloučení do `main` provádí uživatel. Neposílej pracovní změny přímo
  do `main`, neslučuj je za uživatele a nepřepisuj vzdálenou historii.
  Publikování webu navaž na schválené změny.
- V závěrečné zprávě shrň změny, podstatné opravy s místem a důvodem,
  výsledky kontrol a jejich omezení. Uveď commit a odkaz na větev nebo PR.
  Pokud commit či odeslání selže, popiš skutečný stav a překážku.
