# Scénář k prezentaci kapitoly 9

Připraveno 2026-11-24. Pro syntézu použijte pouze
[mluvený text v UTF-8](kapitola_09_podily_a_kategorialni_data_scenar.txt).
Tento dokument ani [manifest](kapitola_09_podily_a_kategorialni_data_scenar_manifest.json)
se nepředčítají.

Scénář doprovází **snímky 1–30** aktuální
[prezentace](kapitola_09_podily_a_kategorialni_data.pptx), včetně titulku,
obsahu, předělů a řešených příkladů. Vychází z podrobných
[poznámek v DOCX](kapitola_09_poznamky.docx). Vynechává závěrečné
procvičování na snímcích 31–38, otázky k zamyšlení a jejich odpovědi,
organizační pokyny a bibliografické zápisy. Nezařazuje nepovinná
rozšíření kapitoly.

Revidovaný text má **5 002 slov**. Při tempu 105–125 slov za minutu
odpovídá přibližně **40–48 minutám** bez dalších pauz. Na výslovný pokyn
autora byl pro tuto nahrávku zvolen Creative Claw, ElevenLabs v4 a český
hlas Adam – Velvety and Conversational. Kvůli limitu 10 000 znaků na
požadavek je syntéza rozdělena na snímky 1–8, 9–16, 17–23 a 24–30.

## Výsledná nahrávka hlasem Adam

Místní soubor `kapitola_09_podily_a_kategorialni_data_Adam.mp3` trvá
**43:03**. Čtyři úseky byly spojeny v pořadí bez prolínání a zakódovány
do jednoho mono MP3 (44,1 kHz, 192 kb/s). Obsahuje 30 značek snímků
odvozených z časování slov a naměřených délek úseků. Soubor je
ignorovaný Gitem.

Dekódování proběhlo bez chyb. Délka odpovídá součtu úseků, časovaná slova
služby odpovídají scénáři a přehrávací soubor obsahuje všech 30 značek.
Technická kontrola nezjistila pauzy dlouhé alespoň tři sekundy pod
hranicí −50 dB. Podrobnosti a otisk výsledného souboru jsou v manifestu.
Nahrávka spotřebovala 673 kreditů Creative Claw.

## Nahrávka hlasem Judita

Stejný scénář snímků 1–30 byl na pokyn autora převeden také hlasem
Judita v Creative Claw, modelem `speech/heygen-voice-1`, v češtině
s rychlostí 1. Limit 5 000 znaků vyžadoval osm úseků na hranicích snímků.
Po spojení bez prolínání vznikl soubor
`kapitola_09_podily_a_kategorialni_data_Judita.mp3` o délce **36:21**
s 30 značkami snímků. Syntéza spotřebovala 673 kreditů.

Dekódování proběhlo bez chyb. Délka odpovídá součtu úseků a slova
v časování služby pokrývají celý scénář. Nastavení, otisk souboru
a výsledky kontrol jsou v manifestu. Zvuk se samostatně neposlouchal
ani nepřepisoval.

## Podklady a obsahová kontrola

Scénář vznikl společně s prezentací ze stejných zdrojových textů slidů
a podrobných poznámek. Všech devět vložených obrázků bylo prohlédnuto ve
vykreslených slidech: Waldův a Wilsonův interval, pokrytí intervalů,
konstrukce Newcombova intervalu, volby pozic, chí-kvadrát rozdělení,
překlopení chvostů *z* do chí-kvadrát, řádkové podíly, tabulky Fisherova
testu a podíly ve studii Danielsové. Scénář u každého vysvětluje osy, barvy
a to, čeho si má posluchač všimnout; tabulky nečte buňku po buňce.

Výklad odpovídá [kapitole 9](../../quarto/kapitola_09.qmd), její
[kartě](../../docs/kapitoly/09-podily-kategorialni-data.md),
[terminologickému registru](../../docs/SLOVNIK.md) a konvencím R53, R68–R70,
R74, R76, R81 a R82. Respektuje užší rozsah prezentace: vzorec Wilsonova
intervalu, ruční výpočet Fisherova testu, Holmovu korekci, intervaly pro
poměry, Simpsonův paradox ani Cohenovo kappa nevyučuje.

Revize zpřesnila mluvený postup výpočtu intervalů a stupňů volnosti,
interpretaci nezávislosti a srovnání skupin, vysvětlení Fisherova testu
a simulace i zacházení s nulovými rozdíly ve znaménkovém testu.
Otisky v manifestu odpovídají aktuálním souborům prezentace a poznámek.
Názvy funkcí Excelu neuvádí a odkazuje na list sešitu kapitoly. U studie
Danielsové říká „hodnocení vlastního vzhledu“ místo termínu
sebeobjektivizace. Nejde o změnu prezentace ani o novou terminologickou konvenci.

## Číselná kontrola

Všechny hodnoty prezentace a poznámek, ze kterých scénář vychází, byly
nezávisle přepočítány v základním R 4.5.1 (pracovní skript `check.R`
v ignorované složce `tmp/chapter09-presentation/`): 48 skupin kontrol
včetně cvičení, žádný zjištěný rozdíl. Hodnoty ve scénáři zachovávají
přesnost slidů. Desktopový Excel se pro scénář nespouštěl.

## Slovník výslovnosti

| Odborný zápis | Zápis pro syntézu | Původ a stav |
|---|---|---|
| kvantil | kvantyl | Závazný požadavek autora podle R53; použit v celém textu. |
| statistika, statisticky | statystyka, statystycky a tvary | Tvrdé ti podle R53; textově ověřeno. |
| studie | studyje, studyji | Tvrdé di; návaznost na předchozí scénáře. |
| standardizované | standardyzované | Tvrdé di; textově ověřeno. |
| alternativní | alternatyvní | Tvrdé ti; návaznost na předchozí scénáře. |
| kritická | kritycká a tvary | Tvrdé ti. |
| homogenita | homogenyta a tvary | Tvrdé ni; jazykové posouzení. |
| senioři | senyjoři, senyjorů | Tvrdé ni a přechod mezi samohláskami; jazykové posouzení. |
| Waldův, Wilsonův | Valdův, Vilsonův a tvary | Český výslovnostní přepis příjmení; bez poslechového ověření. |
| Newcombův | Ňúkomův a tvary | Výslovnostní přepis příjmení; bez poslechového ověření, **nejistý**. |
| Fisherův | Fišerův a tvary | Český výslovnostní přepis příjmení; bez poslechového ověření. |
| McNemarův | Meknemarův a tvary | Výslovnostní přepis příjmení; bez poslechového ověření. |
| Cramérovo V | Kramérovo vé | Přepis příjmení a názvu písmene; bez poslechového ověření. |
| Howell, Field | Hauel, Fíld a tvary | Hauel podle předchozích scénářů; Fíld nově; bez poslechového ověření. |
| Danielsová | Denjelsová a tvary | Výslovnostní přepis příjmení; bez poslechového ověření, **nejistý**. |
| p-hodnota, z-test, t-test | pé-hodnota, zed-test, té-test | Mluvené názvy se spojovníky podle R53. |
| p, π, π₀, z, n, N, f, e, q, V, φ, χ² | pé, pí, pí nula, zed, en, velké en, ef, é, kvé, vé, fí, chí-kvadrát | Názvy písmen a mluvené značky. |
| indexy j+ a +l | „s indexem jé plus“, „s indexem plus el“ | Mluvené indexy. |
| APA | á-pé-á | Návaznost na předchozí scénáře. |

Zbývající výskyty di/ti/ni a dí/tí/ní byly posouzeny v kontextu. Ponechány
jsou české měkké skupiny, například ve slovech rozdíl, podíl, tisícin, lidi,
děti, hladině, nikoli a jejich tvarech, a měkké koncovky slov kontrolní,
pilotní, sociální, referenční, exaktní, absolutní a kategoriální. Nejde
o plošnou náhradu skupin písmen. Výpis ponechaných slov je v manifestu.

## Kontroly textu

Ověřeno všech 30 oznámení snímků právě jednou a ve správném pořadí.
Text neobsahuje číslice, nezpracované matematické značky, URL, markdown,
režijní značky ani původní rizikové podoby vyžadující přepis; konce řádků
jsou LF (`.gitattributes`). Čísla, procenta, indexy a operace jsou zapsány
mluveně. Manifest uchovává SHA-256 scénáře a podkladů, přiřazení úseků ke
snímkům a slovník.

## Omezení

Textová kontrola ověřila znění předané syntéze i text časovaných slov
vrácený službou. Poslech a nezávislý přepis audia neproběhly.
Výslovnost včetně přepisů příjmení Newcombe a Danielsová zůstává
neověřená.
