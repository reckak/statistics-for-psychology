# Scénář k prezentaci kapitoly 8

Připraveno 2026-11-17. Pro syntézu použijte pouze
[mluvený text v UTF-8](kapitola_08_porovnani_dvou_prumeru_scenar.txt).
Tento dokument ani [manifest](kapitola_08_porovnani_dvou_prumeru_scenar_manifest.json)
se nepředčítají.

Scénář doprovází **snímky 1–31** aktuální
[prezentace](kapitola_08_porovnani_dvou_prumeru.pptx), včetně titulku,
obsahu, předělů a řešených příkladů. Vychází z podrobných
[poznámek v DOCX](kapitola_08_poznamky.docx). Vynechává závěrečné
procvičování na snímcích 32–39, otázky k zamyšlení a jejich odpovědi,
časové pokyny pro vyučujícího a bibliografické zápisy.
Nezařazuje výpočet nepovinných rozšíření kapitoly.

Text má **4 934 slov**. Při tempu 105–125 slov za minutu odpovídá
přibližně **39–47 minutám** bez dalších pauz. Jde o odhad z počtu slov,
nikoli o změřenou délku zvuku. Při přípravě scénáře nahrávka nevznikla;
následný úplný převod na výslovnou žádost autora je zaznamenán níže.

## Podklady a obsahová kontrola

Pořadí, texty, tabulky a vzorce byly načteny z místního PPTX, podrobný
výklad z aktuálního DOCX. Vizuálně bylo prohlédnuto všech sedm vložených
obrázků: schéma obou uspořádání, párové hodnoty a rozdíly, poměr velikostí
skupin, hodnoty varianty B, intervaly vedle sebe, změny ve skupinách
a ekvivalence. Ve scénáři je vysvětlen význam os, spojnic, bodů a intervalů.
PPTX ani DOCX nebyly měněny; prezentace nebyla znovu renderována
v PowerPointu a stránkování DOCX nebylo znovu ověřováno ve Wordu.

Výklad byl porovnán s relevantními pasážemi
[kapitoly 8](../quarto/kapitola_08.qmd), její
[karty](../docs/kapitoly/08-porovnani-dvou-prumeru.md),
[terminologického registru](../docs/SLOVNIK.md#kapitola-08)
a platnými konvencemi R53, R59–R61, R74, R76 a R77.
Scénář respektuje užší rozsah prezentace: ruční výpočet Welchových stupňů
volnosti ani intervalů pro Cohenovo *d* nevyučuje.
Původ dat anorexie a parkovací studie přebírá z kapitoly a poznámek;
původní odborné zdroje nebyly v tomto úkolu nově nezávisle ověřovány.

Mluvené znění zpřesňuje některé zkratky podkladů. U párování výslovně
rozlišuje variabilitu rozdílů od přesnosti odhadu. U anorexie zachovává
informaci, že celý výzkum měl také kontrolní skupinu; omezení se týká
samotné párové analýzy. U rozdílných rozptylů nepovažuje větší variabilitu
automaticky za doklad rozdílných individuálních účinků. Aktivní kontrola
pomáhá vyrovnávat očekávání, ale nezaručuje jejich shodu. U ekvivalence
vysvětluje vazbu 90% intervalu na dva jednostranné testy na hladině 0,05.
Nejde o změnu prezentace ani novou terminologickou konvenci.

Interní didaktická revize se zaměřila na jednotku analýzy, zachování
dvojic, směr odečítání, význam čitatele a jmenovatele, sčítání rozptylů,
volbu testu před výsledkem, přímé porovnání změn, ekvivalenci průměrů
a oddělení statistického a kauzálního závěru. Nenahrazuje ověření
porozumění na studentech.

## Číselná kontrola

Nezávislý přepočet v základním R 4.5.1 pomocí `stats::t.test`
ověřil párový příklad spánku, chybnou analýzu jako nezávislých skupin,
klasický a Welchův test varianty B, parkovací studii, změnu hmotnosti,
příklad překrývajících se intervalů, změny v obou skupinách i jejich
přímé porovnání a oba intervaly obou studií ekvivalence.
Ověřeny byly také použité standardizace a krajní hodnoty směrodatných
chyb v grafu poměru velikostí skupin. Výsledky odpovídají podkladům
v uvedeném zaokrouhlení. Ve výpočtech se používají přesnější vstupy,
ne již zaokrouhlené mezivýsledky.

Kontrola vycházela z pevných vstupů a zdrojových souhrnů v
[kapitolovém skriptu](../scripts/kapitola_08.R); nepoužívala jeho výpočetní
funkce. U souhrnných vstupů vytvořila deterministické pomocné vektory
se zadanými průměry a výběrovými směrodatnými odchylkami pro kontrolu
testu a intervalu. Nejde o rekonstrukci skutečných individuálních dat.
Přesné výsledky obsahuje manifest v části `numeric_verification`.
Pracovní kontrolní skript a tabulkové výsledky jsou v ignorovaném
`tmp/ch08-scenar/`. Desktopový Excel nebyl při přípravě scénáře spouštěn;
název funkce je převzat z aktuálních podkladů.

## Slovník výslovnosti

Při přípravě scénáře bylo zamýšlené pokračování dosavadních nahrávek podle
[projektových pravidel](../docs/TEXT2SPEECH.md) je Creative Claw,
model `speech/heygen-voice-1`, český hlas Adam, rychlost 1.
Dostupnost ani parametry služby nebyly při přípravě samotného textu
ověřovány. Před následným převodem bylo ověřeno aktuální rozhraní
a podle nového výslovného zadání použit jiný model a veřejný hlas níže.
Textové přepisy jsou již součástí scénáře.

| Odborný zápis | Zápis pro syntézu | Původ a stav |
|---|---|---|
| kvantil | kvantyl | Závazný požadavek autora podle R53; použit v celém textu. |
| statistika, statistický | statystyka, statystycký a tvary | Tvrdé ti podle R53; textově ověřeno. |
| studie | studyje, studyji, studyjí | Tvrdé di a přechod mezi samohláskami; návaznost na předchozí scénáře. |
| standardizace | standardyzace | Tvrdé di; textově ověřeno. |
| identifikační | identyfikační | Tvrdé di; jazykové posouzení. |
| aktivní, praktický | aktyvní, praktycký a tvary | Tvrdé ti; měkké koncovky zachovány. |
| Welchův | Velčův, Velčova a tvary | Český výslovnostní přepis příjmení; bez poslechového ověření. |
| Cohenovo d | Kouenovo dé | Výslovnostní přepis příjmení a názvu písmene; bez poslechového ověření. |
| Howell | Hauel a tvary | Návaznost na předchozí scénáře; bez poslechového ověření. |
| Everitt | Everitt | Ponechaný pravopis; přednes konkrétního hlasu neověřen. |
| online | onlajn | Český výslovnostní přepis. |
| t-test, t-rozdělení | té-test, té-rozdělení | Mluvené názvy se spojovníky podle R53. |
| p-hodnota, Q–Q graf | pé-hodnota, kvé-kvé-graf | Mluvené názvy se spojovníky podle R53. |
| m, s, μ, n, indexy D, p, 0 | em, es, mí, en; indexem dé, pé, nula | Názvy písmen a mluvené indexy. |
| T.DIST.2T | té-tečka-dyst-tečka-dva-té | Projektové čtení souvislých částí funkce. |
| M, SD, CI, APA | em, es-dé, sí-aj, á-pé-á | Mluvené zkratky v reportování. |

Zbývající výskyty di/ti/ni a dí/tí/ní byly posouzeny v kontextu.
Ponechány jsou české měkké skupiny například ve slovech rozdíl, hodina,
podíl, tisíc, pětina, rodinný, lidi, dělení a jejich odvozených
tvarech; také měkké koncovky normální, kontrolní, aktivní a číslovek.
Přepis `aktyvní` mění tvrdé ti, nikoli měkké ní. Nejde o plošnou
náhradu skupin písmen. Výpis ponechaných slov je v manifestu.

## Kontroly textu a následné použití

Ověřeno všech 31 oznámení snímků právě jednou a ve správném pořadí.
Text neobsahuje číslice, nezpracované matematické značky, URL, markdown,
režijní značky ani původní rizikové podoby vyžadující přepis.
Čísla, procenta, jednotky, indexy a operace jsou zapsány mluveně;
dlouhé tabulky a řady hodnot nejsou mechanicky předčítány.

Manifest obsahuje SHA-256 podkladů a scénáře, skutečné titulky snímků,
hranice úseků v textu, počty slov, slovník a výsledky kontrol.
Pro soubor scénáře je v `.gitattributes` zachováno LF, aby převod konců
řádků při práci s Gitem nezměnil jeho otisk a hranice úseků.
Po změně prezentace nebo podrobných poznámek je třeba před syntézou
ověřit soulad dotčených úseků. Textová kontrola **nepotvrzuje skutečnou
výslovnost konkrétního hlasu**. Při přípravě scénáře zvuk ani automatický
přepis nevznikly. Následná syntéza a technické ověření jsou uvedeny níže;
skutečný poslech nebyl proveden.

<a id="audio-kapitoly-8-20261117"></a>

## Úplná nahrávka — 2026-11-17

Na výslovnou žádost autora převeden celý nezměněný scénář snímků 1–31
přes Creative Claw. Původně zadaný hlas HeyGen nebyl službou přijat;
požadavek byl odmítnut před syntézou bez účtování kreditů.
Následně autor výslovně zvolil `speech/elevenlabs-v4`, veřejné
`voice_id` `uYFJyGaibp4N2VwYQshk`, hlas **Adam – Velvety and Conversational**
a češtinu (`extras.language_code: cs`). Podle aktuálně načteného
`get_model_params` byly použity podporované parametry časových značek
a výstupu MP3 44,1 kHz / 192 kb/s. Rychlost, expressiveness boost,
SSML ani jiné nepodporované ovladače nebyly posílány. Uložené náhrady
služby vypnuty, protože požadované přepisy již obsahuje scénář.

Limit 10 000 znaků vyžadoval čtyři části na hranicích snímků:
1–11, 12–18, 19–26 a 27–31. Jejich text po spojení přesně odpovídá
scénáři. Všechny části byly dokončeny a spojeny přes Creative Claw
do jednoho WAV, bez prolínání a bez změny hlasitosti jednotlivých částí.
Nevznikla pouze dílčí sestava: operace zahrnula všechny čtyři vstupy.
Z WAV bylo lokálně vytvořeno jediné MP3 se společnou úpravou hlasitosti
celé nahrávky a 31 značkami snímků. Značky vycházejí z časů slov
poskytovatele a skutečných délek dekódovaných částí, nikoli z počtu slov.

Výstup: `presentations/kapitola_08_porovnani_dvou_prumeru_Adam.mp3`.
Skutečná délka je přibližně **43:09**. MP3 zůstává místním souborem
ignorovaným Gitem; nebylo přidáno do prezentace ani publikováno na webu.
Scénář, slovník a veřejné údaje o výstupu uchovává manifest. Přesné
požadavky, identifikátory úloh, adresy médií, časované tokeny a pracovní
kontroly jsou v ignorovaném `tmp/ch08-audio-elevenlabs/`.

Technická kontrola ověřila dekódování bez chyb, všechny značky snímků,
shodu délky se součtem částí a nezkrácený začátek i konec časovaného textu.
Dekódovaný spojený WAV má přesně stejné vzorky jako čtyři vstupy
dekódované ve stejném formátu a seřazené za sebou. Tím je ověřeno pořadí,
úplnost i neexistence překrytí ve spoji. Slova vrácená v časových značkách
odpovídají celému scénáři po sjednocení mezer, interpunkce a velikosti
písmen. Nejde o nezávislou transkripci zvuku. Zkontrolována také hlasitost
a pauzy; přesné výsledky jsou v manifestu. **Poslech ani ověření
skutečné výslovnosti nebyly provedeny.**

Creative Claw vykázal 688 kreditů za čtyři převody a 2 kredity za spojení.
