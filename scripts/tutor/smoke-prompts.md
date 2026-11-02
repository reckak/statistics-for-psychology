# Ověření AI tutora v cílovém klientu

Použij nový chat s vybraným pluginem, bez příloh a bez webového vyhledávání.
Předpokladem je skutečně uložená verze podle manifestu. Při kontrole nejprve ověř,
že tutor čte přibalený soubor; správná obecná odpověď sama načtení nedokládá.
Požaduj název oddílu a jeho existující ID. Uveď, které úlohy a klient byly
skutečně vyzkoušeny; nevydávej tento interní test za ověření na studentech.

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

1. Vysvětlení: přímá odpověď na rozdíl SD a SE, konkrétní psychologický
   příklad a podmínky vztahu. Nemá vyžadovat nahrání kapitoly 6.
2. Sokratovské vedení: „Veď mě při výpočtu průměru 4, 5, 5, 6, 10.
   Polož jen první otázku a čekej.“ Po první reakci zadej chybný jmenovatel 4;
   kontroluj cílenou nápovědu a zachování jednoho kroku v jednom tahu.
3. Procvičování: vyžádej jednu vlastní úlohu na průměr a medián, řešení až
   po pokusu. Ověř označení vlastní úlohy, řešitelnost a následnou zpětnou vazbu.
4. Zkoušení: vyžádej dvě otázky, bodování 0–2 a vyhodnocení až nakonec.
   Odpověz postupně a ověř, že tutor nezveřejní řešení předem, dodrží počet
   otázek a na konci správně sečte body. Nápovědu musí odlišit od samostatného výkonu.

## Zahájení studia a práce s cvičením

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
| Proč při čtyřnásobném n klesne SE na polovinu? | Přímé vysvětlení bez průvodce. |
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

- Výběrové rozdělení: n = 25, 100, 400, σ = 15; SE = 3, 1,5, 0,75.
  Počet opakování a populační rozdělení se změnou n nesmějí změnit.
- Síla: oboustranný jednovýběrový z-test se známou σ = 15, n = 100,
  α = 0,05. Ověř pravděpodobnost zamítnutí při Δ = 0 i nenulových
  kladných/záporných účincích nezávisle v R, včetně pevné kritické oblasti.
- Korelace: ρ = −0,8; 0; 0,8; zachovat základní realizaci a osy.
  Porovnej zobrazené r se skutečným výpočtem z vykreslených dat,
  ne pouze s nastaveným ρ. Zvlášť ověř nové losování a reset.
- Bez podpory interaktivity: výslovně žádej statickou náhradu s vypočtenými
  srovnáními. Tutor ji nesmí nazvat interaktivním výstupem.
