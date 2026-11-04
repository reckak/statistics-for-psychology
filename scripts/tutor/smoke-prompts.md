# Ověření AI tutora v cílovém klientu

Prostředí testu určuje [AGENTS.md](../../AGENTS.md#overovani-ai-tutora):
ověř přepnutí do režimu **Chat** a zaznamenej klienta i model.
Instalované vydání zkoušej v novém chatu s vybraným pluginem, bez příloh
a bez webového vyhledávání. U kandidáta přilož schválený balíček a výslovně
odliš tento test od instalace.
Předpokladem je skutečně uložená verze podle manifestu. Při kontrole nejprve ověř,
že tutor čte přibalený soubor; správná obecná odpověď sama načtení nedokládá.
Požaduj název oddílu a jeho existující ID. Uveď, které úlohy a klient byly
skutečně vyzkoušeny; nevydávej tento interní test za ověření na studentech.

Scénáře platí i pro skill v claude.ai (archiv `statistika-tutor-claude-<verze>.zip`).
Tam místo vybraného pluginu ověř, že je skill zapnutý v Customize → Skills,
a test zaznamenej odděleně od ChatGPT. Zahajovací volby z manifestu Claude
nezobrazuje; aktivaci zkoušej běžným dotazem, např. „Chci studovat statistiku“.

V Gemini (archiv `statistika-tutor-gemini-<verze>.zip`) nejsou soubory obrázků.
Navíc ověř dotaz na konkrétní obrázek, např. „Co ukazuje obrázek 6.1?“:
tutor má vyjít z rejstříku `obrazky.md` a textového popisu, nevymýšlet
podrobnosti nad popis a nabídnout odkaz na obrázek ve webové učebnici.

## Začátek, střed a konec každé kapitoly

Každou trojici lze zadat jako jeden přehledně označený test načítání zdrojů.
Odpovědi porovnej s původními QMD; očekávané opory níže jsou kontrolním
vodítkem, nikoli náhradou kontroly celého smyslu odpovědi.

| Kapitola | Dotaz | Kontrolní opora |
|---|---|---|
| 1 A | Jaké konkrétní údaje máme o P01 v úvodním příkladu proměnných? | Šest hodin spánku, pět vybavených slov, dopoledne. |
| 1 B | Proč ordinální kódy 1, 2, 5, 10 nevypovídají o stejných rozestupech mezi kategoriemi? | Zachované pořadí; rozdíly kódů nejsou rozdíly konstruktu. |
| 1 C | Ve kterých dvou situacích se odehrává úloha 9 a proč stálost výsledků nestačí k validnímu měření paměti? | Test českých slov a dotazník odpočatosti; vliv znalosti češtiny a souhlasného odpovídání. |
| 2 A | Proč mohou tytéž tři osoby znamenat 50 % i 60 %? | Šest osob versus pět platných údajů. |
| 2 B | Jaké četnosti má šest jednohodinových intervalů histogramu spánku a kolik údajů chybí? | 3, 5, 8, 10, 5, 2; 33 platných, tři chybějící. |
| 2 C | Co se v úloze 10 změní po přepsání odpočatosti P01 z 2 na 3? | Četnosti 4, 9, 15, 8; kumulativně 4, 13, 28, 36; celkem stále 36. |
| 3 A | Co udělá změna posledního času z 10 na 30 s průměrem a mediánem pěti časů? | Průměr 6 → 10; medián zůstane 5. |
| 3 B | Jak se liší pomocné meze a konce vousů v příkladu krabicového grafu pro 41 skórů? | Meze 10 a 90; vousy 15 a 85. |
| 3 C | Jaká data používá nepovinná úloha 15 k vyvrácení tvrzení „nulová šikmost znamená souměrnost“? | Čtyřikrát −2, pětkrát −1, desetkrát 1, jednou 3; m = 0, g1 = 0, rozdělení nesouměrné. |
| 4 A | Porovnej výsledky 60 v testu A a 42 v testu B z úvodu kapitoly. | A: m = 50, s = 10, z = 1; B: m = 30, s = 6, z = 2. |
| 4 B | Do kterého stenu a staninu spadá z = 1,2 v příkladu pásem? | Sten 8, stanin 7. |
| 4 C | Proč v úloze 10 velký výběr a souměrný vrchol nestačí pro normální model vysokých skórů? | Těžší chvosty, SKEW asi 0,1 a KURT asi 4,2; počet lidí nenormalizuje původní data a z-skór sám neurčuje klinickou závažnost. |
| 5 A | Jak v kartičkovém příkladu rozlišíme jeden výsledek a jev „podstatné jméno“? | Sto kartiček; jev zahrnuje čtyřicet konkrétních výsledků. |
| 5 B | Jak se v příkladu změní prediktivní hodnota pozitivního testu při prevalenci 10 % a 1 %? | Přibližně 0,514 a 0,088 při stejných charakteristikách testu. |
| 5 C | Které pravidlo vyžaduje úloha 12f s losováním tří žen ze skupiny dvanácti lidí? | Součin podmíněných pravděpodobností bez vracení; 7/12 × 6/11 × 5/10. |
| 6 A | Jak se liší tři vrstvy průběžného parkovacího příkladu? | Skutečná studie 32,15 a 39,03 s; výukový model μ = 35, σ = 15 s; vlastní simulace. |
| 6 B | Jaké směrodatné chyby odpovídají výběrům po 25, 100 a 400 řidičích? | 3,0; 1,5; 0,75 s; odmocninový vztah. |
| 6 C | Jaké pravděpodobnosti požaduje část a) úlohy 16? | Za H0 u spojitého testu: p ≤ 0,05 má 0,05; p ≤ 0,04 má 0,04; mezi nimi 0,01. |

## Přehledy a hranice přibaleného rozsahu

- Slovníček: vyhledej heslo „Směrodatná chyba“, jeho anglický ekvivalent
  a alternativní české názvy; vysvětli odlišení od výběrové chyby.
- Značení: vyhledej t-kvantil, uveď jeho značení a příklad pro 24 stupňů
  volnosti; přiznej, že úplná kapitola 7 není přibalená.
- Excel: vyhledej konkrétní příklad COUNTIFS z přehledu a zachovej přesné
  absolutní odkazy, operátory, středníky i očekávaný výsledek.
- Požaduj přesný obsah konkrétního cvičení kapitoly 8. Tutor nesmí předstírat
  přístup k celé kapitole; může citovat dostupné heslo a nabídnout webový odkaz.

## Čtyři pedagogické režimy

1. Vysvětlení: přímá odpověď na rozdíl směrodatné odchylky a směrodatné chyby se značením učebnice, konkrétní psychologický
   příklad a podmínky vztahu. Nemá vyžadovat nahrání kapitoly 6.
2. Sokratovské vedení: „Veď mě při výpočtu průměru 4, 5, 5, 6, 10.
   Polož jen první otázku a čekej.“ Po první reakci zadej chybný jmenovatel 4;
   kontroluj cílenou nápovědu a zachování jednoho kroku v jednom tahu.
3. Procvičování: vyžádej jednu vlastní úlohu na průměr a medián, řešení až
   po pokusu. Ověř označení vlastní úlohy, řešitelnost a následnou zpětnou vazbu.
4. Zkoušení: vyžádej dvě otázky, bodování 0–2 a vyhodnocení až nakonec.
   Odpověz postupně a ověř, že tutor nezveřejní řešení předem, dodrží počet
   otázek a na konci správně sečte body. Nápovědu musí odlišit od samostatného výkonu.

## Ověřovací otázky bez nápovědy rozhraním

V režimu Chat zadej „Kapitola 3, vysvětlování, celá kapitola bez rozšíření.
Průběžně ověřuj moje porozumění.“ Zaznamenej skutečné otázky a výchozí
stav rozhraní před vlastní volbou; nevyvozuj předvýběr pouze z textu modelu.

- Otevřená otázka je přípustná. Odpověz a ověř věcnou zpětnou vazbu.
- Potom vyžádej postupně šest otázek s možnostmi A–C, vždy po jedné.
  Před odpovědí není vyznačen klíč ani doporučená či předvybraná odpověď.
  Správné pozice se mění; nejsou vždy B ani v pevném cyklu. Šest otázek
  je regresní vzorek, nikoli statistický důkaz náhodnosti či vyváženosti.
- Střídej věcně správné a chybné odpovědi s vlastním zdůvodněním.
  Klíč zpětné vazby musí odpovídat skutečně zobrazenému pořadí možností.
- Požádej o klikací možnosti. Pokud klient automaticky předvybírá,
  tutor použije běžný text nebo otevřenou otázku. Samotné „pokračuj“
  nevyhodnotí jako zvolenou odpověď.
- Zopakuj výběrovou otázku v procvičování a zkoušení. U zkoušení
  s hodnocením na konci zůstává klíč skrytý až do závěru.

## Zahájení studia a práce s cvičením

### Regrese aktivace nainstalované dovednosti

Před konverzačním testem na Desktopu i webu otevři detail instalovaného
pluginu, ověř číslo vydání a přítomnost všech tří úvodních voleb. Na každou
klikni a porovnej vložený text s manifestem. Ověření na webu nenahrazuje
Desktop. Preventivní autorský limit 100 znaků není doloženým limitem
platformy. Pokud volby chybějí i po zkrácení, prověř načtené vydání a
obnovení detailu; další zkracování bez nového důkazu neprováděj.

V novém chatu bez příloh vyber nainstalovaný plugin a samostatně spusť
každý ze tří aktuálních úvodních promptů z manifestu. Zaznamenej přesné
znění, verzi, klienta, model a pozorované čtení souborů. Správný název
kapitoly ani tvrzení modelu „načetl jsem“ samo aktivaci nedokládá.

- Zahájení studia: nejprve SKILL.md, REFERENCE.md a INDEX.md; nabídka
  zachová úplné názvy kapitol 4 a 6 a hranici přibalených kapitol 1–6.
- Sokratovské vedení: stejné úvodní načtení, potom jen otázka na chybějící
  zadání; po zadání konkrétního cvičení načte plán, výklad a kontrolní
  řešení, studentovi položí jednu otázku bez zveřejnění řešení.
- Zkoušení: stejné úvodní načtení; po výběru tématu plán, výklad,
  OTAZKY.md a ZKOUSENI.md, dohoda o podmínkách a skrytý klíč.
- Doplňkový běžný vstup „Chci začít studovat. Pomoz mi vybrat kapitolu,
  způsob práce a rozsah.“ prověří výběr dovednosti bez posíleného promptu.
- Následně zadej chybný název „6 – Statistická inference“: tutor jej
  opraví podle katalogu, nepřevezme ho z kontextu.
- Pokud katalog skutečně nelze číst, tutor omezení přizná a nevymýšlí
  nabídku. Tuto větev označ za neotestovanou, nebyla-li chyba čtení
  skutečně navozena; žádost uživatele „předstírej výpadek“ ji nedokládá.

Čtení přes správu pluginů nebo starší chat nenahrazuje načtení instalované
dovednosti. Test s přiloženým ZIPem ověřuje kandidátní instrukce, nikoli
aktivaci instalace. Několik úspěšných pokusů nedokládá spolehlivost ve všech
klientech ani statisticky vyčíslené zlepšení proti předchozímu vydání.

### Další zahajovací scénáře

V samostatných nových chatech ověř následující vstupy. Známé údaje tutor
nesmí zjišťovat znovu; při konkrétním dotazu má začít přímo.

| Vstup nebo návaznost | Očekávání |
|---|---|
| Chci studovat. | Seznam skutečně dostupných kapitol, první otázka jen na kapitolu. |
| Kapitola 6. | Nabídne čtyři režimy s významem, kapitolu již nezjišťuje. |
| Nevím číslo, chci pochopit pravděpodobnost. | Dohledá kapitolu 5, nabídne další potřebnou volbu. |
| Kapitola 6, režim vyber za mě, celou kapitolu. | Vysvětlování, krátké potvrzení, navazující úseky podle cílů. |
| Kapitola 6, procvičování, směrodatná chyba. | Potvrdí nastavení, začne vlastní úlohou bez řešení. |
| Teď kapitola 3, sokratovsky, průměr. | Změní nastavení a postup, bez opakovaného dotazníku. |
| Proč při čtyřnásobném n klesne SE na polovinu? | Přímé vysvětlení bez průvodce; značení σₘ místo převzetí SE z dotazu. |
| Pomoz mi s úlohou 1 kapitoly 3, zatím bez řešení. | Přečte zadání i vzor, navede nejmenším krokem. |
| Nerozumím ani tomu, co se v zadání chce. | Vysvětlí zadání, nevyžaduje předchozí výpočet. |
| Ukaž celé řešení úlohy 1 kapitoly 3. | Komentované řešení s existujícím ID bez vynuceného pokusu. |
| Pomoz mi s úlohou 4.3. | Bez kontextu upřesní kapitolu a číslo. |
| Ukaž úlohu 999 kapitoly 3. | Nenalezené zadání přizná, nevymyslí náhradu. |
| Nemám hodnoty ze sešitu, v zadání nejsou. | Doložený list/buňky nebo vyžádání vstupů, žádná smyšlená data. |
| Shrňme téma. / Pro dnešek končím, děkuji. | Shrnutí a další krok podle kontextu, žádné vynucené pokračování. |

Kontrolu správného alternativního postupu a chybného zdůvodnění proveď
na stejné skutečně přečtené úloze: hodnotit matematiku, nikoli shodu slov se vzorem.
Pomoc bez pokusu a výslovné řešení zopakuj ve dvou nezávislých chatech.

## Skutečné interaktivní vizualizace

V novém chatu bez příloh požaduj vytvoření, nikoli návrh nebo blok kódu.
Přes skutečné ovladače ověř graf, hodnoty, reset a klávesnici. V úzkém
zobrazení nesmějí překrývat popisky ani mizet body. Zaznamenej klienta,
model a skutečnou podporu; nepřisuzuj schopnost všem studentským účtům.

- Výběrové rozdělení: n = 25, 100, 400, σ = 15; σₘ = 3, 1,5, 0,75.
  Počet opakování a populační rozdělení se změnou n nesmějí změnit.
- Síla: oboustranný jednovýběrový z-test se známou σ = 15, n = 100,
  α = 0,05. Ověř pravděpodobnost zamítnutí při Δ = 0 i nenulových
  kladných/záporných účincích nezávisle v R, včetně pevné kritické oblasti.
- Korelace: ρ = −0,8; 0; 0,8; zachovat základní realizaci a osy.
  Porovnej zobrazené r se skutečným výpočtem z vykreslených dat,
  ne pouze s nastaveným ρ. Zvlášť ověř nové losování a reset.
- Bez podpory interaktivity: výslovně žádej statickou náhradu s vypočtenými
  srovnáními. Tutor ji nesmí nazvat interaktivním výstupem.

## Přejímací scénáře revize 0.3.0

Před vydáním spusť celý export a kontroly archivu. Potom ověř kandidáta v cílovém klientu. Pokud test používá přiložený kandidátní balíček místo instalovaného pluginu, zaznamenej tuto odlišnost; neoznačuj jej za ověření instalace. U každého scénáře eviduj verzi, model, klienta, skutečné načtené soubory, výsledek a omezení. Historické úspěšné běhy starší verze nejsou výsledky této revize.

### Katalog a zahájení

| Dotaz / postup | Přijetí |
|---|---|
| Chci začít studovat. | Přesné názvy kapitol 1–6 v pořadí, stručně hranice balíčku. Další volby postupně. |
| Vypiš všechny kapitoly učebnice a dostupnost. | Všech osm skutečných názvů; 7–8 web/přehledy, nikoli přibalený úplný text. |
| Chci studovat popisné statistiky. | Přiřazení zejména ke 2 a 3 pod jejich skutečnými názvy. |
| Začněme kapitolou 2 – Popisné statistiky. | Oprava názvu, převzetí záměru, žádná vymyšlená kapitola. |
| Kapitola 3, vysvětlování, celá kapitola, bez rozšíření. | Krátký plán a první úsek, bez opakovaného průvodce a bez výkladu celé kapitoly naráz. |
| Pomoz mi se 4.3. | Cílené upřesnění, pokud význam z kontextu není jasný. V rozhovoru o třetím cvičení kapitoly 4 znovu neupřesňuje. |

### Plány a dlouhý rozhovor

Pro každou kapitolu ověř načtení plánu, jednu povinnou dovednost, její vstupní znalost a hranici rozsahu. Požaduj přesný odkaz; porovnej se skutečným výkladem, ne jen s názvem hesla.

| Kapitola | Hranice k ověření |
|---|---|
| 1 | Reliabilita a validita pojmově; výpočet koeficientů není požadovanou dovedností. |
| 2 | Nestejné šířky histogramu pouze při volbě rozšíření; číselné ukazatele patří do 3. |
| 3 | Šikmost a exces v Excelu povinně; vzorce z momentů, logaritmus a výpočet entropie nepovinně. |
| 4 | Q–Q graf povinně, P–P nepovinně; formální test normality není předpoklad. |
| 5 | Binomický model a aproximace povinně; variace a obecný výpočet střední hodnoty nepovinně. |
| 6 | Důsledky více testů povinně; Bonferroniho korekce mimo výklad. Výpočet síly a rozdělení p-hodnot nepovinně. |

V kapitole 6 pokračuj nejméně deset obsahových tahů: výběrové rozdělení → směrodatná chyba → hypotézy → p-hodnota → rozhodnutí → síla → více testů. Střídej správné odpovědi, chybu a žádost „pokračuj“. Ověř zachování rozsahu, značení a přiměřeného dalšího kroku. Tutor sám nezařadí Bonferroniho korekci ani ji nevyžaduje ve zkoušení. Potom se na ni výslovně zeptej: odpoví jako na doplněk a při návratu pokračuje v původním plánu.

Zopakuj s volbou „s nepovinnými rozšířeními“: tutor zahrne doložené nepovinné části učebnice, nikoli automaticky externí metody. Změň volbu během studia. Ve zkoušení ověř, že otázky odpovídají aktuální volbě a již vysvětleným předpokladům; při vlastním chybném zadání tutor napraví otázku i hodnocení.

### Značení

- „σ = 15 s, n = 100: spočítej směrodatnou chybu.“ Očekává se σₘ = 1,5 s, modelová hodnota.
- „s = 14,9 s, n = 30: spočítej směrodatnou chybu.“ Očekává se sₘ ≈ 2,72 s, odhad z dat.
- „Proč čtyřnásobné n půlí SE?“ Tutor rozumí alternativě, výklad vede se σₘ či sₘ podle kontextu.
- Totéž ověř po více navazujících otázkách a ve vytvořeném grafu, jeho legendě a ovladačích. U označené ukázky reportování připusť doložené výjimky přehledu.

### Účelnost, ovladače a rozměry grafů

1. Požádej o stručné vysvětlení bez grafu. Potom o jednu interaktivní demonstraci. U dalších tří podobných úloh tutor využije stejnou demonstraci nebo slovní odkaz, nikoli další nabídky panelů.
2. Použij jiné zadání než demonstrační příklad: μ = 50 bodů, σ = 12 bodů, n = 36. Očekává se σₘ = 2 body a výchozí hodnoty zadání, nikoli parkovací model.
3. Vyžádej průběžně měnitelné n a σ: slider i číselné pole se synchronizují, n má celočíselný krok. Přesně zadej n = 81; při σ = 12 je σₘ = 4/3 bodu. Číselné předvolby samotné nestačí.
4. Vyzkoušej také jiný vhodný námět z učiva, například vliv vzdáleného pozorování na průměr a medián nebo změnu prevalence při screeningu. Hodnoty a předpoklady odpovídají otázce; typ rozdělení či jinou kategorii ovládá odpovídající nabídka.
5. Ověř české názvy, značky a jednotky ve všech ovladačích a hlášeních. Neplatný vstup dostane srozumitelné vysvětlení. Obnovit zadání vrátí původní hodnoty a data; nové losování je oddělené.
6. Pro povolený rozsah n a σ otestuj nejužší i nejširší rozdělení, posuny středů a kombinace krajů. Vrchol skutečné hustoty je celý v grafu s rezervou; výška panelu neroste. Společná měřítka a označené přiblížení zachovávají interpretaci.
7. Ověř skutečně úzký panel kolem 320 px i dostupnou výšku kolem 480 px, zvětšený text, oba motivy a klávesnici. Případné svislé posouvání ovladačů je přípustné; ořez křivky, nečitelná osa či nedostupný vstup nejsou.
8. Při nedostupné interaktivitě tutor poskytne označené statické srovnání. Při nedostupném indexu si seznam kapitol nevymyslí a vymezí ověřený dostupný obsah.

<a id="regrese-z-testovani-v-rezimu-chat"></a>

### Regrese z testování v režimu Chat

- V odpovědi na boxplot používej hlavní značení kvartilů z přehledu, tedy q s příslušnou úrovní; Q₁/Q₃ případně vysvětli jako alternativy. Totéž kontroluj v tabulkových přehledech více témat, nejen u samostatného výpočtu.
- U věty „Co udělá změna posledního času z 10 na 30 s průměrem a mediánem?“ čti „s“ jako předložku v kontextu české věty. Upozornění na nesoulad jednotek musí mít skutečnou oporu v zadání a zdroji.
- Zmínku o t-rozdělení při odlišení známé a odhadované směrodatné chyby spoj s hranicí kapitoly 6 a odkazem na pozdější výklad; samostatná znalost t-rozdělení se zde nevyžaduje.
- Pokud klient hlásí „Tuto odpověď se nepodařilo načíst“, zopakuj odpověď běžným textem bez složitých komponent. Ověř zobrazení, nikoli jen existenci uložené odpovědi v historii.
- U vlastního příkladu i souhrnné tabulky zkontroluj všechna citovaná ID proti načteným nadpisům. Například v kapitole 3 existuje `sec-volba-stredu`, nikoli `sec-odolnost-stredu`.
- Po změně varianty zadání ověř, co skutečně vrací **Obnovit zadání**. Původní 36 / 12 se při variantě 81 / 12 uchová jako původní zadání. Zkontroluj také skutečné české názvy tlačítek a přístupné názvy posuvníků.
- Zadej n = 0 do číselného vstupu: model zůstane věcně definovaný a student dostane konkrétní české vysvětlení opravy vstupu. Obecný popis povoleného rozsahu nenahrazuje reakci na chybu.
