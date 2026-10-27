# Doprovodné zvukové nahrávky k prezentacím

Tento dokument načti před tvorbou nebo úpravou scénáře pro syntézu řeči
a před generováním doprovodného audia. Platí společně s
[AGENTS.md](../AGENTS.md); podobu prezentací a poznámek určuje
[PREZENTACE.md](PREZENTACE.md). Doklad schválení postupu je v
[R53](rozhodnuti/postupy-a-dokumentace.md#r53-doprovodne-audio).

## Kdy audio připravovat

- Scénář i audio připravuj a aktualizuj pouze na výslovnou žádost uživatele.
  Běžná tvorba nebo revize kapitoly, prezentace či poznámek tuto práci
  automaticky nespouští. Ani změna podkladů sama neopravňuje k nové syntéze.
- Rozlišuj žádost o plán, scénář, krátkou ukázku a úplnou nahrávku.
  Požadavek na text neopravňuje k placenému převodu. Výslovný pokyn
  vytvořit nahrávku naopak není důvodem k dalšímu rutinnímu schvalování
  již zadaného rozsahu a vybraného hlasu.

## Podklady, rozsah a účel výkladu

- Použij aktuální prezentaci a její poznámky, případně příslušnou kapitolu.
  Prezentace určuje pořadí a vazbu na obrázky; poznámky dodávají vysvětlení.
  Přečti skutečné podklady, včetně relevantních grafů, tabulek a vzorců.
  Při věcném rozporu jej pojmenuj a vyřeš před syntézou dotčeného úseku;
  kvůli přípravě audia svévolně neměň kapitolu ani prezentaci.
- Respektuj zadaný rozsah snímků. Není-li určeno jinak, připrav pouze
  výkladovou část; samostatná cvičení, jejich řešení, organizační pokyny
  a otázky určené k diskusi vynech. Řešené příklady, které vysvětlují
  probíraný postup, do výkladu patří.
- Nahrávka má studentovi při prohlížení snímků nahradit výklad chybějící
  přednášky. Nepředčítej jen odrážky: vysvětli pojmy, souvislosti, důvody
  kroků výpočtu, předpoklady a interpretaci. Zachovej přiměřenou náročnost
  a hranice učiva; nepřidávej nesouvisející témata ani zbytečné opakování.
- Na začátku krátce vysvětli způsob použití a možnost pozastavit přehrávání.
  Každý úsek uveď číslem skutečného snímku, například „Snímek dvacet tři.“
  Číslování musí odpovídat prezentaci i při vynechání některých snímků.
- U grafů a tabulek pojmenuj osy, důležitou oblast nebo řádek a vysvětli,
  co má student sledovat a jaký závěr z toho plyne. Nečti mechanicky
  všechny buňky či popisky. U vzorců vysvětli význam značek a pořadí operací.
- Piš přirozeně pro poslech: přiměřeně krátké věty, jasné návaznosti,
  jednotlivé kroky a prostor pro orientaci ve snímku. Výklad nezahlcuj
  URL, bibliografickými zápisy ani technickými údaji o syntéze.

## Úplný mluvený zápis

- Text odesílaný syntéze obsahuje přesně to, co má zaznít, bez markdownu,
  interních poznámek, nevyslovených režijních pokynů a nezpracovaných rovnic.
  Čísla piš slovy, včetně čísel snímků, desetinných a záporných hodnot,
  procent, pořadových čísel, intervalů, letopočtů a jednotek.
- Přepisuj podle významu a gramatického kontextu, nikoli jen mechanickým
  nahrazením znaků. Například „šedesát bodů“, „mezi čtyřiceti a šedesáti
  body“, „devadesátý devátý percentil“, „minus jedna celá pět desetin“.
  Desetinné hodnoty musí zachovat všechny významné číslice a nuly:
  `0,025` lze zapsat „nula celých dvacet pět tisícin“. Nepřidávej nuly
  ani neměň přesnost proti podkladům; dlouhý zápis zkrať jen bez změny významu.
- Znaménka, operátory, jednotky, indexy a zkratky převeď na skutečně
  vyslovované výrazy. U vzorců zachovej závorky a rozsah operací slovním
  vyjádřením, například „celý rozdíl vydělíme směrodatnou odchylkou“.
- Samostatná písmena označující testy, proměnné nebo indexy piš jejich
  mluveným názvem: „verze testu Á a Bé“, „iks s indexem í“, „písmeno es“.
  Hláskování používej tam, kde jde o název písmene; velká písmena sama
  nejsou důvodem hláskovat celý výraz.
- Výrazy tvořící jeden mluvený celek spojuj v podkladu pro syntézu
  spojovníky, aby mezi částmi nevznikaly nežádoucí dlouhé pauzy:
  „zed-skór“, „té-skór“, „í-kvé-skór“, „kvé-kvé-graf“ a
  „v kvé-kvé-grafu“. Zápis zachovej i v dalších skloňovaných tvarech.
  Spojovník není univerzální záruka správného přednesu.

## Názvy funkcí Excelu

- Názvy funkcí nehláskuj celé po jednotlivých písmenech. Souvislé části
  čti jako slova, samostatné písmeno jeho názvem a oddělující tečky vyslov.
  Používej stručný výslovnostní zápis se spojovníky.
- Pro `NORM.S.DIST` použij „norm-tečka-es-tečka-dyst“, například:
  „Funkce na snímku se zapisuje norm-tečka-es-tečka-dyst.“ Nepoužívej
  rozvláčné „en ó er em, tečka, es, tečka, dé í es té“.
- U dalších funkcí postupuj obdobně a jednotně; výslovnostní přepis
  nesmí měnit skutečný název funkce. Podrobnosti zadání, význam argumentů
  a vracený výsledek vysvětli přirozenou řečí. Logické hodnoty jako
  „pravda“ čti jako slova. Dlouhé vzorce nerozepisuj do nepřehledného
  řetězce názvů znaků, pokud stačí popsat postup a odkázat na snímek.

## Slovník výslovnosti

- Rozlišuj odborný pravopis od účelového zápisu pro syntézu. Cizí slova
  a odborné výrazy se skupinami „di“, „ti“ a „ni“ zapisuj ve scénáři jako
  „dy“, „ty“ a „ny“, **pokud se daná skupina vyslovuje tvrdě**. Zachovej
  délku samohlásky také u „dí“, „tí“ a „ní“. Měkce vyslovované skupiny
  neměň; neprováděj plošnou náhradu bez posouzení konkrétního slova.
  Prověř také vlastní jména, zkratky a názvy funkcí.
- Pro projekt nahrávky udržuj jeden slovník: odborný výraz, zápis pro
  syntézu, poskytovatel/model/hlas, původ přepisu (požadavek autora nebo
  jazykové posouzení), stav textové kontroly a případná nejistota.
  Autorem požadovaný přepis je závazný; jeho použití nepodmiňuj
  poslechovým ověřením a kvůli chybějícímu poslechu jej nevracej
  k odbornému pravopisu.
- Pro „kvantil“ používej v podkladu pro syntézu „kvantyl“, například
  „kvantyly“, „kvantylu“, „kvantylů“ a „kvantylový“. Jde o požadovaný
  zápis, nikoli pouze kandidátní návrh. Uplatni jej ve všech příslušných
  tvarech; zkontroluj, že ve scénáři nezůstal původní základ „kvantil“.
- Přepisy uplatni důsledně ve všech odpovídajících výskytech. Kontroluj
  konkrétní slova a jejich skloňované či odvozené tvary tak, aby náhrada
  nezasáhla jiné výrazy. Textovou kontrolu doplň vyhledáním původních
  rizikových podob; každý zbývající výskyt posuď a případnou výjimku zdůvodni.
  Výslovnostní přepisy patří pouze do scénáře pro syntézu a jeho slovníku,
  nikoli do prezentace, učebnice ani obecného registru odborné terminologie.
- Používej jen značky a možnosti výslovnosti podporované vybraným modelem.
  Nevkládej neověřené SSML, IPA ani režijní značky, které by hlas mohl
  předčítat. Textová kontrola dokládá použití požadovaných přepisů,
  nikoli skutečnou výslovnost vytvořeného zvuku.

## Příprava před placenou syntézou

- Creative Claw je placený. Cílem je použitelná nahrávka při prvním úplném
  převodu; důsledná příprava má omezit další placené pokusy, nemůže však
  zaručit bezchybnou generaci. Nejprve dokonči a zkontroluj celý scénář.
  Nesyntetizuj průběžně rozepsané části, které ještě čekají obsahové úpravy.
- Před úplným převodem ověř pokrytí snímků, odbornou správnost, hodnoty
  a výpočty proti podkladům, srozumitelnost textu pro poslech, mluvený zápis,
  konzistenci termínů a použití výslovnostních přepisů podle slovníku.
  Vyhledej zbylé číslice, matematické značky, zkratky, nerozepsaná písmena
  a původní rizikové podoby slov; nálezy posuď v kontextu. Kontrola čísel
  a značek sama nenahrazuje kontrolu požadovaných výslovnostních přepisů.
- Použij hlas a nastavení zadané uživatelem. Aktuálně dohodnutá volba
  pro pokračování dosavadních nahrávek je Creative Claw, hlas Adam,
  model `speech/heygen-voice-1`, veřejné `voice_id`
  `32bb79c6f93241b7b956c219aa9bcf75`, čeština a rychlost jedna.
  Jiný výslovný požadavek má přednost. Dostupnost, limity a podporované
  parametry vždy ověř v aktuálním rozhraní; neposílej nastavení jiného modelu.
- Využij dříve určené přepisy a autorovy připomínky k danému hlasu.
  Poslechovou kontrolu neukládej jako povinný krok, pokud ji dostupné
  prostředí neumí provést. Její nedostupnost nebrání použití závazných
  přepisů ani dokončení zadaného převodu. Krátké zvukové ukázky
  a placené porovnávání hlasů či modelů vytvářej jen na výslovnou žádost;
  nevyžaduj je automaticky jako podmínku další práce.
- Zkontroluj dostupnost služby a případné omezení kredity, pokud je lze
  zjistit. Cenu ani zůstatek neodhaduj ze staré nahrávky. Respektuj zadaný
  rozpočet a pravidla nástroje; při blokaci ji vysvětli a neopakuj stejné
  odmítnuté požadavky. Neměň kvůli ní bez dohody hlas ani model.

## Syntéza, spojení a opravy

- Výchozím výstupem je jeden souvislý MP3 soubor za celý zadaný rozsah.
  Nahrávky jednotlivých snímků jsou pracovní mezikroky, nikoli náhrada
  požadovaného celku. Sadu oddělených souborů předávej jen na žádost.
- Rozděl text jen podle skutečných limitů služby nebo pro cílené opravy.
  Upřednostni hranice snímků; dlouhý snímek děl na odstavcích, nikdy
  uprostřed věty nebo výpočtu. Zachovej všechna slova, pořadí a jednoznačné
  mapování snímků na úseky. Krátké části lze seskupit při zachování
  oznámení snímků. Předem stručně vysvětli nutnost dílčích převodů a jejich
  následného spojení; nezahltívej uživatele dílčími přehrávači či odkazy,
  pokud jejich zobrazení můžeš ovlivnit.
- Pro všechny úseky zachovej stejný model, hlas, jazyk a rychlost.
  Nezkracuj scénář ani nezrychluj řeč jen kvůli limitům požadavku.
- Uchovej přesný text, identifikátory úloh, nastavení, dokončené výstupy
  a jejich pořadí. Po přerušení nejprve zjisti stav existujících úloh;
  prodleva nebo timeout neznamenají neúspěch a neopravňují k placené duplicitě.
- Spojuj až dokončené úseky, bez vynechání, duplikací a překrytí řeči.
  Neaplikuj prolínání, které by překrývalo mluvená slova. Omez opakované
  ztrátové kódování, zkontroluj hlasitost a příliš dlouhé nebo useknuté
  pauzy na spojích. Pokud nástroj vyžaduje postupné spojování, dokonči
  všechny kroky; hotový první dílčí spoj není celá přednáška.
- Pokud je to spolehlivě možné, vlož do jediného MP3 značky kapitol podle
  skutečných časů začátků snímků. Neodvozuj časy jen z počtu slov;
  ovládání kapitol závisí na přehrávači.
- Při chybě urči dotčený úsek, oprav scénář nebo zápis výslovnosti
  a podle oprávnění v zadání přegeneruj pouze nezbytnou část. Samotná
  stížnost není automatickým souhlasem s další placenou syntézou.
  Zachovej ostatní použitelné úseky, znovu sestav jeden MP3 a přepočítej
  časové značky. Nevytvářej znovu celou přednášku kvůli jediné opravě.

## Ověření, uložení a předání

- Před předáním ověř zahrnutí všech požadovaných snímků právě jednou,
  správné pořadí, úplnost začátku a konce, přehratelnost, přítomnost zvuku
  a délku odpovídající součtu skutečně spojených úseků. Zkontroluj také
  časové značky kapitol a vazbu na snímky. Úspěšný zápis souboru nestačí.
- Rozlišuj textovou kontrolu přepisů, technickou kontrolu souboru
  a automatický přepis zvuku. Žádnou z nich nevydávej za skutečný poslech
  ani za potvrzení správné výslovnosti. Uveď skutečně provedené kontroly
  a jejich omezení; automatický přepis nemusí odhalit chybné změkčení
  souhlásek ani všechny jiné zvukové chyby. Poslechové ověření deklaruj
  pouze tehdy, pokud skutečně proběhlo.
- Scénář ulož jako samostatný text v UTF-8. U každé dokončené nahrávky
  uchovej identitu/verzi podkladů, rozsah snímků, scénář, slovník,
  nastavení hlasu, mapování úseků a výsledky kontrol pro cílené opravy.
  Identifikátory ani přístupové údaje účtu nepatří do veřejné dokumentace.
- Pracovní úseky a pomocné výstupy drž v `tmp/`; výsledné audio pojmenuj
  podle kapitoly a hlasu, například
  `presentations/kapitola_04_normalni_rozdeleni_Adam.mp3`. Respektuj
  pravidla repozitáře: generované MP3 se necommitují. Uložení a předání
  přizpůsob prostředí a zadání; scénář a manifest musí zůstat dohledatelné
  pro pozdější opravu. Webovou publikaci ani vložení do prezentace
  neprováděj automaticky.
- Uživatel dostane hlavně jeden odkaz ke stažení finálního MP3, skutečnou
  délku, rozsah snímků a podstatná omezení ověření. Scénář přilož podle
  zadání. Dílčí soubory nepředkládej jako hlavní výsledek. Dokončení
  deklaruj až po sestavení a ověření celého požadovaného výstupu.
