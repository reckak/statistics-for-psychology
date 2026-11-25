# Vizualizace: překreslení obrázku, interaktivní stránky a vlastní grafy

Kdy obrázek ukázat a kdy nabídnout interaktivní stránku, určuje hlavní SKILL.md. Tento soubor říká, jak graf nakreslit a co k interaktivním stránkám učebnice poradit.

## Překreslení obrázku učebnice z dat

Blok „Data pro překreslení“ v rejstříku obrázků kapitoly obsahuje druh obrázku, panely, typ grafu, popisky a rozsahy os, vodicí čáry a vybarvená pásma, poznámky ke zvýraznění a řady hodnot. Barvy a legendu, které blok neuvádí, vezmi z textového popisu obrázku; učebnice používá modrou #245D78, oranžovou #B54E24, světle modrou výplň #B8DDE8, zelenou #3E7B4F a šedou #4D5A63.

Obrázek označený „schéma bez dat“ z hodnot nepřekresluj: ukaž jeho přibalený soubor, má-li jej balíček a klient jej zobrazí; jinak jej popiš podle textového popisu a řádku „Poznámka ke schématu“ (počty a rozmístění prvků) a připoj adresu stránky učebnice.

Druh říká, odkud hodnoty pocházejí: `data` jsou data příkladu, `simulace` hodnoty vylosované pro obrázek, `sloupce` zadané nebo přesně spočtené četnosti a `krivka` obrázek, jehož hlavní částí je křivka daná vzorcem. Ve všech případech kresli z uvedených řádků; nic nelosuj znovu.

- Nakresli všechny panely se stejnými titulky, popisky os a vodicími čarami. Panely jsou uvedeny po řádcích zleva doprava, pokud poznámka neříká jinak. Titulek nebo popisek osy, o kterém poznámka říká, že v obrázku není (pomocný název panelu, osa „bez měřítka“), nekresli. Rozsah osy je jen údaj za slovem „rozsah“; závorka v popisku osy, například „(body, 0–30)“, patří k popisku. Není-li rozsah uveden, zvol jej podle hodnot s malou rezervou.
- Použij všechny řádky každé řady. První řádek řady jsou názvy polí, další řádky hodnoty oddělené čárkou; text s čárkou je v uvozovkách, prázdná hodnota znamená „neuvedeno“. Údaj „značka“ určuje podobu:
  - **body**: bod v (x, y);
  - **sloupce**: svislý sloupec v x o výšce y (vodorovné sloupce jen tehdy, říká-li to poznámka); pole `skupina` s údajem „uspořádání“ říká, zda sloupce téže polohy stojí vedle sebe, nebo jsou skládané na sebe, a to zdola nahoru v pořadí řádků;
  - **histogram**: sloupec od `od` do `do` o výšce `cetnost`, `hustota` nebo `podil` (popisek svislé osy říká, o které měřítko jde); chybějící interval má výšku nula;
  - **cara**: lomená čára spojující body v uvedeném pořadí;
  - **plocha**: vybarvená plocha mezi křivkou y a osou, případně mezi y a `y0`;
  - **interval**: úsečka od `od` do `do` v poloze `poloha`, bod ve `stred`; údaj „směr“ říká, zda leží vodorovně, nebo svisle; prázdná mez je otevřený konec;
  - **usecky**: samostatné úsečky z (x0, y0) do (x1, y1);
  - **krabice**: krabicový graf z hodnot `dolni_vous`, `q1`, `median`, `q3`, `horni_vous` v poloze `poloha`; „směr“ jako u intervalu;
  - **tabulka**: buňky tabulky nebo jiný přehled hodnot. Popisuje-li poznámka tvar (mozaika, strom, mřížka, výseče), nakresli ten; prostou tabulku použij jako náhradu.
- Pole `kategorie` nahrazuje číselnou polohu: řádky jsou kategorie v pořadí na ose a jejich text je popisek osy. Na vodorovné ose jdou zleva doprava, na svislé ose (vodorovné intervaly a sloupce) shora dolů. Má-li řada vedle číselného `x` i pole `kategorie`, je kategorie popiskem osy v poloze x.
- Řádek „vybarvené pásmo“ je podbarvený pruh mezi dvěma hodnotami osy. Řádek „vodicí čára“ je pomocná čára přes celý panel: svislá, vodorovná, nebo šikmá „přímka y = a + b·x“; kresli ji přerušovaně, pokud poznámka neuvádí jiný styl.
- Další datové pole čti podle názvu: `popisek` je text u bodu, `zvyrazneno` odliš barvou (hodnota „ne“ znamená běžnou barvu, jiné hodnoty jsou úrovně zvýraznění popsané v poznámce), `pocet_studentu` vyjádři velikostí bodu a číslem. Ostatní pole (například `student`) jsou doplňující údaje.
- Řadu se značkou `cara` smíš podle vzorce z poznámky dopočítat hustěji, aby křivka nebyla hranatá.
- Blok se stovkami řádků zpracuj nástrojem pro spuštění kódu, máš-li jej: načti v něm soubor rejstříku a řádky bloku rozděl programem, neopisuj je. Některé rozsáhlé řady jsou proředěné; říká to jejich poznámka. Bez něj dej u tak velkého obrázku přednost přibalenému souboru, případně popisu s adresou; hodnoty ručně neopisuj po částech.
- Čísla v bloku mají desetinnou tečku. V grafu i ve výkladu piš desetinnou čárku a znaménko minus −.
- U grafu uveď „Překresleno podle obrázku N.M učebnice“. Graf má říkat totéž co originál: po nakreslení porovnej s popiskem a textovým popisem, zda je vidět to, na co výklad upozorňuje.
- Když klient graf vykreslit neumí, použij další dostupnou možnost ze SKILL.md, nakonec popis s adresou; kód ani slib grafu nevydávej za hotový obrázek.

## Interaktivní stránky učebnice

Stránku nabídni jednou větou s názvem a adresou u oddílu, u něhož ji uvádí výukový plán. Teprve když ji student otevře nebo se na ni zeptá, poraď mu nastavení a po návratu se zeptej, co pozoroval. Stránku znovu neprogramuj.

| Stránka a adresa | Co zkusit nastavit | Čeho si všimnout |
|---|---|---|
| **Co s rozdělením udělá posun a změna jednotek** (kap. 3) https://reckak.github.io/statistics-for-psychology/quarto/viz_posun_a_jednotky.html | Tlačítka „Minuty na sekundy“, „Přičíst 2 minuty“ a „Nevybavená slova: 12 − x“; předem předpovědět průměr, směrodatnou odchylku a rozptyl. | Posun mění polohu, ne variabilitu; násobení mění obojí, rozptyl druhou mocninou násobitele; tvar se při kladném násobiteli nemění. |
| **Plochy pod normální křivkou** (kap. 4) https://reckak.github.io/statistics-for-psychology/quarto/viz_normalni_rozdeleni.html | Model μ = 50, σ = 10: podíl vlevo a vpravo od 60, mezi 60 a 70; potom N(100, 15) a hranice 115. | Každý podíl je plocha vlevo nebo rozdíl dvou ploch; stejný z-skór dává stejný podíl v každém normálním modelu. |
| **Co znamená pozitivní výsledek testu** (kap. 5) https://reckak.github.io/statistics-for-psychology/quarto/viz_bayesova_veta.html | Výchozí příklad kapitoly; přepnout uspořádání mřížky; plošné šetření s nízkou prevalencí; zvýšit specificitu. | Senzitivita a prediktivní hodnota se vztahují k jiným celkům; prediktivní hodnota závisí na prevalenci. |
| **Pravděpodobnost počtu úspěchů** (kap. 5) https://reckak.github.io/statistics-for-psychology/quarto/viz_binomicke_rozdeleni.html | n = 5, π = 0,25 a právě 2 úspěchy; n = 20, π = 0,25, „alespoň 10“ proti „více než 10“; zapnout normální aproximaci. | Otázka na počet úspěchů je součet sloupců; záleží na tom, zda hranici zahrnujeme. |
| **Výběrové rozdělení průměru** (kap. 6) https://reckak.github.io/statistics-for-psychology/quarto/viz_vyberove_rozdeleni_prumeru.html | Vylosovat 1 000 výběrů pro n = 5 a pro n = 100; porovnat n = 25 a 100; změnit tvar populace. | Střed zůstává u populačního průměru, šířku určuje n (čtyřnásobné n, poloviční směrodatná chyba); počet opakování šířku nemění. |
| **Na čem závisí statistická síla** (kap. 6) https://reckak.github.io/statistics-for-psychology/quarto/viz_statisticka_sila.html | Dvě situace vedle sebe: změnit α z 0,05 na 0,01; skutečný rozdíl 3 s při 100 a 400 řidičích; jednostranný test. | Kritické hodnoty určuje nulová hypotéza a α, sílu skutečný rozdíl a směrodatná chyba; při rozdílu 0 jde o chybu I. druhu. |
| **Jak se *t*-rozdělení liší od normovaného normálního** (kap. 7) https://reckak.github.io/statistics-for-psychology/quarto/viz_t_rozdeleni.html | 4 stupně volnosti: porovnat chvosty a kvantil úrovně 0,975 s 1,960; hranice −3 při 29, 30 a 100 stupních volnosti. | Rozdíl leží ve chvostech a s rostoucími stupni volnosti slábne, ale nezmizí; interval s kvantilem z by byl příliš úzký. |
| **Jak často interval spolehlivosti zachytí populační průměr** (kap. 7) https://reckak.github.io/statistics-for-psychology/quarto/viz_pokryti_intervalu.html | Prohlédnout 100 intervalů, potom vylosovat 10 000 výběrů; přepnout na výběrovou s s kvantilem t. | Pokrytí je vlastnost postupu, ne jednoho intervalu; podíl se ustálí blízko 95 %. |
| **Jak spolu souvisí interval spolehlivosti a *p*-hodnota** (kap. 7) https://reckak.github.io/statistics-for-psychology/quarto/viz_interval_a_test.html | Posouvat testovanou hodnotu od 50 k 46 a níž; najít hodnoty s p-hodnotou právě 0,05. | Test zamítá právě ty hodnoty, které leží mimo odpovídající interval. |
| **Kdy párování zpřesní odhad průměrného rozdílu** (kap. 8) https://reckak.github.io/statistics-for-psychology/quarto/viz_prinos_parovani.html | Data varianty A: porovnat oba intervaly; v modelu snížit stabilní rozdíly mezi lidmi a zvýšit kolísání téhož člověka. | Odhad je stejný, liší se nejistota; párování pomáhá, když se lidé mezi sebou stabilně liší. |
| **Co znamená rozdíl o *d* směrodatných odchylek** (kap. 8) https://reckak.github.io/statistics-for-psychology/quarto/viz_cohenovo_d.html | d = 0,5 a d = 0,8; přepnout vybarvení společné plochy. | I „velký“ rozdíl průměrů ponechává skupiny z velké části společné; neopravňuje k výroku o každém jednotlivci. |
| **Co prozradí dva intervaly vedle sebe o rozdílu průměrů** (kap. 8) https://reckak.github.io/statistics-for-psychology/quarto/viz_dva_intervaly.html | Příklad kapitoly; zvyšovat jeden průměr, dokud se intervaly nepřestanou překrývat; tlačítko „Intervaly se právě dotýkají“. | Překryv intervalů nerozhoduje o významnosti rozdílu; rozhoduje interval rozdílu. |
| **Proč odhadujeme podíl Wilsonovým intervalem** (kap. 9) https://reckak.github.io/statistics-for-psychology/quarto/viz_interval_podilu.html | Předvolba 0 z 15 se zapnutým Waldovým intervalem v grafu nerovnice, potom 1 z 25; n = 20, hladina 95 %, vybrané π = 0,05: které počty úspěchů interval zachytí; zvýšit n na 50 a 200; hladina 80 a 99 %. | Waldův interval má při k = 0 nulovou šířku a při n = 20, π = 0,05 zachytí π jen v 64 % případů, Wilsonův v 92,5 %; pokrytí je součet sloupců binomického rozdělení a závisí na n, hladině a π, ne na pozorovaném k; Wilsonovo pokrytí kolísá kolem hladiny (průměr 95,3 %) s úzkými propady jen u 0 a 1. Graf nerovnice patří k nepovinnému odvození. |
| **Jak daleko je tabulka četností od nezávislosti** (kap. 9) https://reckak.github.io/statistics-for-psychology/quarto/viz_chi_kvadrat.html | Tabulka kapitoly; „Zdvojnásobit četnosti“; „Nezávislost“ a potom přesunout několik osob. | Větší soubor zvyšuje statistiku χ² a snižuje p-hodnotu, ale Cramérovo V ani podíly nemění. |
| **Co říkají rozdíl podílů, poměr rizik a poměr šancí o téže tabulce** (kap. 9) https://reckak.github.io/statistics-for-psychology/quarto/viz_miry_souvislosti.html | Údaje z kapitoly; přepnout pohled z rizika na šance; „Aspirinová studie“. | Tři míry dávají z téže tabulky různá čísla; poměr šancí se blíží poměru rizik jen u vzácného jevu. |
| **Jak tvar mraku bodů souvisí s korelačním koeficientem** (kap. 10) https://reckak.github.io/statistics-for-psychology/quarto/viz_korelace.html | Posuvníkem r = 0, 0,5 a 0,9 se zapnutými kvadranty a délkou a šířkou elipsy; v režimu „přidá bod“ kliknout na studenta (38; 31) a táhnout ho dál do rohu; data spánku a graf spojnic. | Znaménko r určují převažující součiny odchylek; jeden bod změní r víc než Spearmanův koeficient; korelace popisuje relativní postavení, ne průměrnou změnu. Regresi a r² stránka jen krátce vysvětluje; nevykládej je jako učivo kapitoly. |

Kapitoly 1 a 2 interaktivní stránku nemají. U korelace lze na žádost vytvořit vlastní interaktivní graf podle [příkladů](PRIKLADY-VIZUALIZACI.md).

## Vlastní graf

Vlastní graf vytvoř na žádost, při změně zadání, nebo když otázku studenta nezodpovídá žádný obrázek ani interaktivní stránka učebnice. Typ vyber podle vztahu, který má student pochopit. Interaktivitu přidej, když změna vstupu pomůže odpovědět na studovanou otázku nebo ji student chce; u navazujících úloh použij tentýž graf znovu.

**Zadání a data.** Hodnoty, jednotky a předpoklady přebírej z probírané úlohy. Pokud je neurčuje, zvol jednoduché smysluplné nastavení a označ je jako vlastní model. Rozlišuj pozorovaná data, teoretický model a simulaci. U simulace drž pevné losování při změně parametru a nové losování nabídni zvlášť; počet opakování nepleť s velikostí výběru. Ze souhrnů nevymýšlej individuální data.

**Ovladače.** Číselný parametr: posuvník a číselné pole se stejnou hodnotou; počet osob či pokusů celočíselně s věcnou dolní mezí; kategorie nabídkou nebo přepínači. Nabídni **Obnovit zadání**, u simulace **Nové losování**. Neplatný vstup vysvětli česky; neexistující výsledek označ „nedefinováno“ s důvodem.

**Popisky a značení.** Vše česky se značením učebnice a jednotkami, například **Velikost výběru n**, **Populační směrodatná odchylka σ (s)**, **Hladina významnosti α**. Význam rozlišuj i jinak než barvou.

**Měřítka.** Při porovnávání používej společná měřítka. Hustoty kresli ve skutečných hodnotách; vrchol normální hustoty je 1/(σ√(2π)), u výběrového průměru dosaď σₘ, a rozsah svislé osy nastav podle nejvyššího vrcholu v celém povoleném rozsahu parametrů. U histogramu uveď, zda ukazuje četnost, relativní četnost, nebo hustotu. Graf musí zůstat čitelný i v úzkém panelu.

**Poctivost.** Hodnoty v grafu ověř nezávislým výpočtem. Hotový je jen graf, který klient skutečně vykreslil; při selhání zkus jednou jednodušší podobu a potom dej označenou statickou náhradu s vypočtenými hodnotami.
