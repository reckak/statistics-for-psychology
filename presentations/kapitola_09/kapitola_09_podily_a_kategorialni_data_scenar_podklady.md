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

Text má **4 860 slov**. Při tempu 105–125 slov za minutu odpovídá
přibližně **39–46 minutám** bez dalších pauz. Jde o odhad z počtu slov,
nikoli o změřenou délku zvuku. **Nahrávka nevznikla** a placená syntéza
nebyla spuštěna; vytvoří se jen na výslovnou žádost autora podle
[projektových pravidel](../../docs/TEXT2SPEECH.md).

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

Mluvené znění se od slidů liší jen zjednodušením zápisu pro poslech.
Názvy funkcí Excelu neuvádí a odkazuje na list sešitu kapitoly. U studie
Danielsové říká „hodnocení vlastního vzhledu“ místo termínu
sebeobjektivizace. Nejde o změnu prezentace ani o novou terminologickou konvenci.

## Číselná kontrola

Všechny hodnoty prezentace a poznámek, ze kterých scénář vychází, byly
nezávisle přepočítány v základním R 4.5.1 (pracovní skript `check.R`
v ignorované složce `tmp/chapter09-presentation/`): 43 skupin kontrol,
žádný rozdíl v uvedeném zaokrouhlení. Hodnoty ve scénáři zachovávají
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
| dramatičtěji | dramatyčtěji | Tvrdé ti; jazykové posouzení. |
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

Textová kontrola dokládá použití přepisů, nikoli skutečnou výslovnost.
Zvuk nebyl vytvořen, poslech neproběhl a dostupnost služby ani hlasu se
neověřovala. Přepisy příjmení Newcombe a Danielsová doporučuji před
syntézou potvrdit nebo opravit. Při změně prezentace nebo poznámek je třeba
scénář i manifest aktualizovat.
