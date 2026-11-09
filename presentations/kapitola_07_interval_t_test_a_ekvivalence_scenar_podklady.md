# Scénář k prezentaci kapitoly 7

Připraveno 2026-11-09. Pro syntézu použijte pouze
[mluvený text v UTF-8](kapitola_07_interval_t_test_a_ekvivalence_scenar.txt).
Tento průvodní dokument ani manifest se nepředčítají.

Scénář doprovází **snímky 1–32** aktuální místní
[prezentace](kapitola_07_interval_t_test_a_ekvivalence.pptx), včetně titulku,
obsahu, předělů a řešených příkladů. Vynechává procvičování na snímcích
33–40, otázky k zamyšlení a organizační pokyny z poznámek. Nepřidává
nepovinná rozšíření kapitoly.

Text má **4 774 slov**. Při tempu 105–125 slov za minutu odpovídá přibližně
**38–46 minutám** bez dalších pauz. Jde o odhad z počtu slov, nikoli
o změřenou délku zvuku. Nahrávka nebyla vytvořena a placená syntéza nebyla spuštěna.

## Podklady a rozsah ověření

Pořadí, texty, tabulky, vzorce a poznámky byly načteny přímo z aktuálního
místního PPTX, které již obsahovalo necommitované úpravy autora. Ty se
týkají zejména zápisu vzorců Excelu na snímcích 12, 16 a 19; scénář z nich
vychází. PPTX nebylo při této práci měněno ani obnovováno z generátoru.
Rozhodující jsou poznámky v PPTX, nikoli případně starší export DOCX.

Všech deset vložených rastrových grafů bylo vizuálně prohlédnuto:
opakované intervaly, šířka intervalu, t-rozdělení, funkce p-hodnoty,
zrcadlo intervalu, jednostranné intervaly, posun průměru, hypotézy
ekvivalence a devět studií. Kontrola není novým ověřením celé sazby
prezentace v PowerPointu.

Obsah je porovnán s relevantními pasážemi
[kapitoly 7](../quarto/kapitola_07.qmd), její
[karty](../docs/kapitoly/07-interval-t-test-ekvivalence.md),
[terminologického registru](../docs/SLOVNIK.md#kapitola-07)
a rozhodnutími R44–R46, R53, R66 a R67. Původ skutečných dat
psychomotorického vývoje se přebírá z kapitoly a prezentace. Původní studie
ani Howellova učebnice nebyly v tomto úkolu nově nezávisle ověřovány.

Nezávislý přepočet v základním R 4.5.1 zahrnul směrodatné chyby,
normální a t-kvantily, intervaly a p-hodnoty příkladů pozornosti a PDI,
rozklad rozšíření intervalu, teoretické pokrytí chybného postupu s 1,96,
podíly pod 40 body a všech devět studií včetně obou p-hodnot TOST.
Zařazení studií do kombinací je shodné s prezentací.
Čísla simulací (94 a 96 intervalů ze sta, 4,8 % a 12,4 %, rozsah šířek)
jsou převzata z existujících grafů a porovnána s kapitolou; simulace nebyly
znovu spouštěny. Funkce Excelu jsou vysvětleny podle podkladů;
desktopový Excel nebyl v tomto úkolu spouštěn.

Interní didaktická revize se zaměřila na obrácení úvahy o vzdálenosti,
dlouhodobé pokrytí, rozdíl mezi σ a výběrovou s, význam os grafů,
směr testu, hraniční rovnost a dvojí funkci 95% a 90% intervalu.
U TOST je argument chybovosti formulován přes nutnost zamítnout pravdivou
dílčí nulovou hypotézu. U zrcadla intervalu je výslovně připomenuta závislost
oblasti nezamítnutí na pozorované s. Revize nenahrazuje ověření porozumění
na studentech.

[Manifest](kapitola_07_interval_t_test_a_ekvivalence_scenar_manifest.json)
obsahuje otisky SHA-256 podkladů, přiřazení všech úseků ke skutečným snímkům,
počty slov, číselné kontrolní výsledky a slovník výslovnosti. Po změně PPTX
je třeba před syntézou porovnat dotčené úseky s novou verzí.

## Slovník výslovnosti

Výchozí zamýšlené pokračování dosavadních nahrávek podle
[projektových pravidel](../docs/TEXT2SPEECH.md) je Creative Claw, model
`speech/heygen-voice-1`, český hlas Adam, rychlost 1. Protože nyní vzniká
pouze scénář, dostupnost modelu ani parametry služby nebyly nově ověřovány.
Před případnou syntézou je nutné ověřit aktuální rozhraní. Níže uvedené
přepisy jsou použity v celém scénáři a nejsou závislé na provedení poslechu.

| Odborný zápis | Zápis pro syntézu | Původ a textová kontrola |
|---|---|---|
| kvantil a jeho tvary | kvantyl, kvantyly, kvantylu, kvantylem | Výslovný požadavek autora podle R53; původní základ nezůstal. |
| statistika, statistický | statystyka, statystycký a příslušné tvary | Tvrdé skupiny podle R53; zkontrolovány všechny tvary. |
| kritický | kritycký | Jazykové posouzení podle R53. |
| alternativní, alternativa | alternatyvní, alternatyva | Tvrdé ti; měkká koncovka ní zachována. |
| standardizovaný | standardyzovaný | Tvrdé di. |
| automaticky, systematický, teoretický, normativní | automatycky, systematycký, teoretycký, normatyvní | Tvrdé ti; zkontrolovány odvozené tvary. |
| individuální | indyviduální | Tvrdé di; další části slova zachovány. |
| studie a její tvary | studyje, studyji, studyjí | Tvrdé di a přechod mezi samohláskami; návaznost na předchozí scénáře. |
| Howell, Howellův | Hauel, Hauelův a příslušné tvary | Český výslovnostní zápis příjmení. |
| t-test, t-rozdělení, z-test | té-test, té-rozdělení, zed-test | Projektový mluvený zápis se spojovníky. |
| p-hodnota, Q–Q graf | pé-hodnota, kvé-kvé-graf | Projektový mluvený zápis se spojovníky. |
| m, s, μ, σ, Δ, α | em, es, mí, sigma, delta, alfa | Mluvené názvy značek nebo významové nahrazení. |
| H₀, H₁ | há s indexem nula, há s indexem jedna | Mluvené indexy. |
| T.INV, T.DIST | té-tečka-inv, té-tečka-dyst | Pravidlo pro čtení souvislých částí funkcí. |
| T.INV.2T, T.DIST.2T | té-tečka-inv-tečka-dva-té, té-tečka-dyst-tečka-dva-té | Tečky a číslo vysloveny. |
| PDI, TOST, APA, SD, CI | pé-dé-í, tost, á-pé-á, es-dé, sí-aj | Mluvené zkratky; CI v ukázce reportování anglicky. |
| A–I u studií | Á, Bé, Cé, Dé, É, Ef, Gé, Há, Í | Jednotlivé názvy písmen, nikoli neoznačené značky. |

Všechny zbývající výskyty di/ti/ni a dí/tí/ní byly vypsány a posouzeny.
Ponechány jsou české měkké skupiny například v hladina, hodina, podíl,
tisíc, pětina a dělení; měkké skupiny číslovek v devadesátipětiprocentní
a měkké koncovky v normální, centrální, konkrétní či alternativní.
Nejde o plošnou náhradu. Manifest zachycuje skutečně ponechaná slova.

Textová kontrola ověřila 32 úseků právě jednou ve správném pořadí,
nepřítomnost číslic, nezpracovaných matematických značek, URL, markdownu
a původních rizikových základů. **Textová kontrola nepotvrzuje skutečnou
výslovnost hlasu.** Zvuk ani poslechové ověření v tomto úkolu nevznikly.
