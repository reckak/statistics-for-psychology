# Ověření AI tutora v cílovém klientu

Prostředí testu, evidenci a doložení čtení podkladů určuje
[ověřování chování v AITUTORS.md](../../docs/AITUTORS.md#overovani).
Zde jsou jen scénáře. Instalované vydání zkoušej s vybraným pluginem
či zapnutým skillem; předpokladem je skutečně uložená verze podle manifestu.

Scénáře platí i pro skill v claude.ai (archiv `statistika-tutor-claude-<verze>.zip`).
Tam místo vybraného pluginu ověř, že je skill zapnutý v Customize → Skills,
a test zaznamenej odděleně od ChatGPT. Zahajovací volby z manifestu Claude
nezobrazuje; aktivaci zkoušej běžným dotazem, např. „Chci studovat statistiku“.

V Gemini (archiv `statistika-tutor-gemini-<verze>.zip`) nejsou soubory obrázků.
Po nahrání ověř stav v seznamu dovedností a dotazem na verzi: Gemini může
ohlásit chybu, i když se dovednost uložila. Navíc ověř dotaz na konkrétní
obrázek bez dat, např. „Co ukazuje obrázek 6.1?“: tutor má vyjít z rejstříku
obrázků kapitoly a textového popisu, nevymýšlet podrobnosti nad popis a uvést
adresu obrázku opsanou doslova.

Před vydáním musí každá platforma splnit
[podmínky vydání](../../docs/AITUTORS.md#podminky-vydani); scénáře k nim jsou
v oddílech [Tempo vedeného vysvětlování](#tempo) a [Obrázky a odkazy](#obrazky-a-odkazy).

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
| 7 A | Jaký *z*-test připomíná úvod kapitoly 7? | 25 studentů, m = 46, norma 50 a σ = 10; σₘ = 2, z = −2, jednostranná p-hodnota 0,023. |
| 7 B | Kterou funkcí Excelu získám kvantil t pro 95% interval při 24 stupních volnosti? | `=T.INV(0,975;24)`, přibližně 2,064. |
| 7 C | Jaké údaje zadává nepovinná úloha 14 o noninferioritě? | Referenční hodnota 55 bodů, hranice 3 body, 200 studentů, průměr 53,2 a s = 10. |
| 8 A | Proč kapitola 8 přechází od normy ke kontrolní podmínce? | Norma vznikla na jiných lidech a v jiné době; přesvědčivější je srovnání se studenty po běžném spánku. |
| 8 B | Proč se dva 95% intervaly mohou překrývat, i když je rozdíl významný? | Rozdíl je významný od 5,69 bodu, intervaly se přestanou překrývat až od 8,26 bodu; interval rozdílu (0,31; 11,69). |
| 8 C | Které listy sešitu používá nepovinná úloha 14? | `U05_hrozba` B2:C4 a `U07_standardizace` B2:B6; Hedgesova korekce a varianty standardizace. |
| 9 A | Na jaký soubor z kapitoly 5 navazuje začátek kapitoly 9? | 200 studentů, pohlaví a zvýšený nebo nízký stres. |
| 9 B | Jak vyšel test chí-kvadrát u věku a strategie zvládání? | χ² = 11,78, 4 stupně volnosti, p-hodnota 0,019, kritická hodnota 9,49; nulovou hypotézu zamítáme. |
| 9 C | Na co navazuje nepovinná úloha 15? | Na úlohu 10 a nepovinné rozšíření o intervalech pro poměr rizik a poměr šancí; list `U10_add` B2:C3. |
| 10 A | Co ukazuje obrázek 10.1? | 40 studentů, úzkost a výkon, r = −0,52; přerušované čáry v průměrech obou proměnných. |
| 10 B | Co mají společného čtyři soubory na obrázku 10.3? | Anscombův kvartet: stejné r = 0,82, zcela odlišné tvary. |
| 10 C | Ukaž zadání a řešení úlohy 18. | 0,41 u 59 žen a 0,53 u 47 mužů; z_r 0,436 a 0,590; směrodatná chyba 0,201; z = −0,77; p-hodnota 0,44. |

## Přehledy

- Slovníček: vyhledej heslo „Směrodatná chyba“, jeho anglický ekvivalent
  a alternativní české názvy; vysvětli odlišení od výběrové chyby.
- Značení: vyhledej t-kvantil, uveď jeho značení a příklad pro 24 stupňů
  volnosti s odkazem na oddíl kapitoly 7.
- Excel: vyhledej konkrétní příklad COUNTIFS z přehledu a zachovej přesné
  absolutní odkazy, operátory, středníky i očekávaný výsledek.
- Požaduj cvičení, které neexistuje (úloha 999 kapitoly 8): tutor je přizná
  a nevymyslí náhradu.

<a id="tempo"></a>

## Tempo vedeného vysvětlování

V novém chatu zadej „Kapitola 8, vysvětlování, celá kapitola, bez rozšíření.“
Zaznamenej délku odpovědí a počet otázek v každé z nich.

| Tah studenta | Očekávání |
|---|---|
| Kapitola 10, vysvětlování, až ke kroku o korelační studii; sleduj každou ověřovací otázku. | Otázku lze zodpovědět jen z textu chatu. Vrací-li se k dřívějšímu příkladu (studie učitelky), říká to a opakuje potřebné údaje. Na „nemám o studii informace“ tutor údaje doplní a neodkazuje na učebnici. |
| Zahájení (výše) | Krátká cesta studiem jen z názvů oddílů, věta o postupu po krocích, první krok a právě jedna ověřovací otázka na konci. Žádný výklad dalších oddílů. |
| Správná odpověď | Krátké potvrzení a další jeden krok s jednou otázkou. |
| Chybná odpověď se zdůvodněním | Konkrétní rozpor a tentýž krok jinak; výklad nepokračuje dalším oddílem. |
| „pokračuj“ | Pokračuje, ale neoznačí krok za pochopený. |
| „Jen mi to shrň.“ | Jedno shrnutí; v dalším tahu opět krok s otázkou. |
| „Dnes bez ověřování.“ | Dál vykládá bez otázek, stále po krocích; volbu drží i v dalších tazích. |
| „Vysvětli mi celou kapitolu 8 najednou.“ | Vyhoví a řekne, že jde o jiný způsob, než je výchozí. |
| Nesouvisející přímá otázka („Co je medián?“) | Stručná přímá odpověď bez průvodce; odpověď nemusí končit otázkou. |

Totéž zopakuj v sokratovském vedení (jedna otázka, stupňovaná nápověda)
a ve zkoušení se třemi otázkami: po chybné odpovědi tutor jen potvrdí
zaznamenání a správné řešení sdělí až v závěrečném hodnocení.

<a id="obrazky-a-odkazy"></a>

## Obrázky a odkazy

U každého scénáře zaznamenej, co se skutečně zobrazilo: přibalený obrázek
v odpovědi, karta souboru, graf nakreslený tutorem, nebo jen text.

| Dotaz / postup | Přijetí |
|---|---|
| Vedené vysvětlování kapitoly 10 až k oddílu „Bod je člověk“. | Obrázek 10.1 se objeví bez vyžádání přímo v odpovědi. Při překreslení z dat: 40 bodů, titulek s r = −0,52, obě přerušované čáry (23,575 a 19,15), označení „překresleno podle obrázku 10.1“. |
| Pokračování k oddílu „Tvary souvislosti“. | Šest panelů obrázku 10.2 se správnými titulky; hodnoty nejsou nově losované. |
| „Ukaž mi obrázek 10.10.“ | Sloupce přesného permutačního rozdělení; oranžově 8, 16, 16 a 8 přiřazení, dohromady 48 ze 720. |
| Výklad oddílu kapitoly 1 se schématem (obrázek 1.5, výběr a přiřazení). | Schéma se zobrazí jako přibalený soubor, nebo je popsáno podle textového popisu a poznámky ke schématu (48 teček, 12 vybraných, 6 + 6) s adresou stránky; tutor nevymýšlí hodnoty ani nový diagram nevydává za originál. |
| Výklad oddílu kapitoly 2 s histogramem (obrázek 2.6). | Histogram nakreslený z dat: četnosti 3, 5, 8, 10, 5 a 2 v intervalech šířky 1; hodnoty nejsou odhadnuté. |
| Výklad oddílu kapitoly 8 „Když se rozptyly skupin liší“ (obrázek 8.5). | Dva panely: krabicové grafy s body (30 a 12 hodnot) a dva vodorovné intervaly, shora klasický test (1,10; 14,90), pod ním Welchův (−1,22; 17,22), svislá čára v nule. |
| Výklad oddílu kapitoly 6 „Statistická síla pro konkrétní alternativy“ (obrázek 6.14). | Čtyři panely s normální křivkou, kritickými hodnotami ±4,16 a vybarvenou plochou; pravděpodobnosti zamítnutí 0,05; 0,29; 0,65; 0,96. |
| Výklad oddílu kapitoly 5 s mozaikou nebo stromem (tabulková data). | Tabulka nebo schéma s hodnotami z bloku dat; tutor uvede, že jde o překreslení. |
| ChatGPT a Gemini: „Ukaž mi obrázek 10.2.“ | Graf nakreslený z dat přímo v odpovědi, bez omluvy za chybějící soubor a bez adresy; žádná adresa v bloku kódu. |
| Výklad oddílu kapitoly 3 „Co od ukazatelů polohy a variability očekáváme“. | Tutor sám jednou nabídne interaktivní stránku s adresou `https://reckak.github.io/statistics-for-psychology/quarto/viz_posun_a_jednotky.html`; výklad pokračuje i bez jejího otevření. |
| „Otevřel jsem ji, co mám zkusit?“ | Poradí nastavení podle VIZUALIZACE.md a po návratu se zeptá na pozorování. |
| Kterýkoli odkaz od tutora (zvlášť v Gemini). | Adresa začíná `https://reckak.github.io/statistics-for-psychology/`, je shodná s rejstříkem či plánem a není obalená vyhledáváním. Klikni na ni a ověř, že se otevře učebnice. |
| Zkoušení z kapitoly 10. | Tutor neukáže obrázek, který prozrazuje odpověď. |
| „Bez grafů, prosím.“ | Dál vykládá slovně. |

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
  zachová úplné názvy všech deseti kapitol.
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
| Chci začít studovat. | Přesné názvy kapitol 1–10 v pořadí. Další volby postupně. |
| Vypiš všechny kapitoly učebnice a dostupnost. | Všech deset skutečných názvů, všechny s úplným textem. |
| Jakou verzi tutora používáš? | Verze a revize z registru, nikoli odhad. |
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
| 7 | Interval s kvantilem t a test ekvivalence povinně; noninferiorita a superiorita, odolnost t-testu a výpočet obou p-hodnot dvou jednostranných testů nepovinně. |
| 8 | Párová data a nezávislé skupiny povinně; Hedgesova korekce a varianty standardizace nepovinně. |
| 9 | Intervaly a testy pro podíly a míry souvislosti povinně; intervaly pro poměr rizik a poměr šancí nepovinně. |
| 10 | Tři koeficienty, test a interval povinně; důkaz mezí r, interval BCa, korekce na atenuaci a převod d na bodově biseriální korelaci nepovinně. |

Hranice kapitol 7–10 ověř proti nepovinným blokům ve výukovém plánu; řádky výše jsou vodítko, nikoli náhrada plánu.

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
