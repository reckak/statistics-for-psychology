# Metodika výukových vizualizací

## Účel a opětovné použití

Vycházej z právě probírané otázky, výukového plánu a přečteného výkladu či zadání. Vizualizace mohou pomoci u libovolného tématu v rozsahu studia: měření, četností, polohy, variability, transformací, pravděpodobnosti i inference. Typ grafu vybírej podle vztahu, který má student pochopit.

Nejprve zvaž existující obrázek učebnice nebo zobrazení již vytvořené v rozhovoru. U navazujících obdobných úloh zpravidla využij stejnou vizualizaci a její ovladače; samotná změna číselného zadání není důvodem k novému panelu. Nový výstup vytvoř pro jiný potřebný pohled, konkrétní neporozumění nebo na žádost studenta.

Interaktivitu zvol, když manipulace s daty či parametry pomůže odpovědět na studovanou otázku nebo ji student výslovně chce. Pro krátkou otázku může stačit výpočet, tabulka či slovní vysvětlení. Požadavek „bez grafu“ respektuj. Podle režimu propojuj předpověď → změnu → pozorování → vysvětlení; v přímém výkladu je předpověď dobrovolná. Ve zkoušení zachovej možnost samostatné odpovědi.

[Konkrétní demonstrace](PRIKLADY-VIZUALIZACI.md) jsou příklady a podklady pro ověření, nikoli seznam povolených grafů. Modely a hodnoty z nich používej, pokud odpovídají aktuální otázce. Téma mimo učebnici vysvětluj na výslovný dotaz a označ jako doplněk.

## Zadání, parametry a data

Výchozí hodnoty, data, jednotky a předpoklady přebírej z právě probírané úlohy. Pokud je neurčuje, zvol jednoduché smysluplné nastavení a popiš je jako vlastní model. Změnu vstupu označ jako variantu původního zadání; nabídni tlačítko **Obnovit zadání**, u vlastního modelu **Výchozí nastavení**. Výsledek varianty vztahuj k právě zobrazeným hodnotám.

Zpřístupni parametry potřebné pro učební otázku; méně podstatné možnosti odkrývej postupně. Jasně ukaž, co se mění a co zůstává pevné. Rozsahy a kroky nastav podle významu veličiny, jednotek a numerické stability. Při neplatné kombinaci ukaž české vysvětlení a možnost opravy; místo neexistujícího výsledku zobraz „nedefinováno“ s důvodem.

Rozlišuj pozorovaná data, teoretický model a simulaci. Při změně parametru zachovej základní náhodnou realizaci, pokud její změna není výslovnou součástí demonstrace. Použij pevný seed a samostatné tlačítko **Nové losování**. Počet opakování simulace odliš od velikosti výběru. Souhrnné vstupy zachovej jako souhrny; individuální data z nich nevymýšlej.

## Ovladače a jejich názvy

| Vstup | Vhodné ovládání |
|---|---|
| Číselný parametr | Zpravidla posuvník a synchronizované číselné pole s přesným zadáním a šipkami. |
| Počet osob či pokusů | Celočíselný krok a věcně přípustná dolní mez. |
| Spojitý parametr | Desetinný krok podle jednotek; u velmi širokého rozsahu označená nelineární stupnice. |
| Typ rozdělení, kategorie či směr testu | Nabídka, přepínače nebo tlačítka. |
| Jednotlivá data | Upravitelná tabulka či body s číselnou a klávesnicovou alternativou. |

Pevné číselné předvolby používej pro cílené srovnání, zpravidla jako doplněk průběžného ovládání. Počet ovladačů řiď otázkou a přehledností, nikoli univerzálním limitem jednoho parametru.

Všechny ovladače, nabídky, nápovědy, legendy, hodnoty i chybová hlášení piš česky se značením učebnice. Název spoj se značkou a jednotkou, například **Velikost výběru n**, **Populační směrodatná odchylka σ (s)**, **Hladina významnosti α**. Symboly musí mít vysvětlený význam. Pro směrodatnou chybu průměru používej σₘ, pro její odhad sₘ; alternativní označení řeší přehled značení.

## Měřítka a rozměry

Rozměry panelu odděl od hodnot grafu. Výchozí výška samotného grafu může být přibližně 280 px; přizpůsob ji dostupnému prostoru včetně os, legend a ovladačů. S rostoucí hustotou zachovej rozměry panelu a uprav převod datových souřadnic. V úzkém či nízkém panelu zjednoduš rozložení; delší ovládání může mít svislý posun, obsah grafu musí zůstat celý čitelný.

Při porovnávání rozdělení používej společná měřítka pro všechny křivky a srovnávané stavy. Pro normální hustotu má vrchol hodnotu 1/(σ√(2π)); u výběrového průměru dosaď σₘ. Rozsah y stanov podle nejvyššího vrcholu v celém povoleném rozsahu parametrů, například s rezervou 15 %. U jiných grafů zkontroluj odpovídající extrémy a rozsah x včetně posunů křivek. Automatické přiblížení použij jako výslovně označený režim se zobrazenými osami.

Hustoty zobrazuj ve skutečných hodnotách s celkovou plochou jedna. Normalizaci každé křivky na stejný vrchol použij pouze pro výslovně označené srovnání tvarů, nikoli jako zobrazení skutečné hustoty. U histogramu označ, zda ukazuje četnost, relativní četnost nebo hustotu. Na svislé ose hustoty uváděj příslušnou převrácenou jednotku; vodorovná osa nese jednotku proměnné.

## Funkčnost a ověření

Použij skutečně dostupné zobrazení klienta a jeho dokumentovaný postup. Poskytni funkční výstup; samotný kód nebo příslib označ jako návrh, nikoli hotovou vizualizaci. Při chybě jednou zkus jednoduchou opravu nebo podporovaný náhled souboru. Při dalším selhání poskytni označenou statickou náhradu s vypočtenými srovnáními.

Ověř výchozí hodnoty, krajní hodnoty a smysluplné kombinace vstupů, přesné číselné zadání, synchronizaci ovladačů, obnovu zadání a nové losování. Zkontroluj výpočty nezávisle na grafu a skutečnou reakci ovladačů. Značky a jednotky porovnej s textem a přehledy.

Prohlédni úzký panel přibližně 320 px a nízký panel přibližně 480 px, zvětšený text, světlý i tmavý vzhled a ovládání klávesnicí. Význam rozlišuj také jinak než barvou. Zaznamenej, co bylo skutečně zobrazeno a ovládáno v klientu; místní výpočet sám funkčnost v konkrétním klientu nepotvrzuje.
