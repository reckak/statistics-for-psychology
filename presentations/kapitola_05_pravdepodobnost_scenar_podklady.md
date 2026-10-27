# Scénář ke kapitole 5: podklady a použití

Datum přípravy: 2026-10-27.

Do služby pro syntézu se vkládá pouze
[mluvený text v UTF-8](kapitola_05_pravdepodobnost_scenar.txt).
Tento průvodní dokument ani manifest nejsou součástí předčítání.

Scénář provází **snímky 1–35** aktuální
[prezentace](kapitola_05_pravdepodobnost.pptx), včetně titulního snímku,
obsahu a tematických předělů. Snímky 36–43 (procvičování a doprovodný
sešit) jsou vynechány. Výkladové řešené příklady zůstávají; diskusní
otázky, organizační pokyny, bibliografické dovětky a časové pokyny
z poznámek nejsou předčítány.

Text má 5 708 slov včetně oznámení snímků. Při předpokládaném tempu
120–140 slov za minutu odpovídá přibližně **41–48 minutám** bez dalších
pauz. Jde o výpočet z počtu slov, nikoli o změřenou délku nahrávky.
Dlouhé číselné výrazy a konkrétní hlas mohou skutečné tempo změnit.

## Vazba na podklady a ověření

Pořadí, titulky, viditelný text, tabulky a poznámky byly načteny z PPTX.
Vizuálně bylo prohlédnuto všech 13 vložených výkladových obrázků
(grafy a diagramy). Podrobnosti byly porovnány s příslušnými pasážemi
[kapitoly](../quarto/kapitola_05.qmd), její
[karty](../docs/kapitoly/05-pravdepodobnost.md) a
[terminologického registru](../docs/SLOVNIK.md#kapitola-05).
Postup odpovídá [TEXT2SPEECH.md](../docs/TEXT2SPEECH.md).
Nové odborné téma ani terminologická konvence se nezavádí.

[Manifest](kapitola_05_pravdepodobnost_scenar_manifest.json) uchovává
SHA-256 podkladů a scénáře, mapu všech 35 úseků se skutečnými titulky,
počty slov a výsledky číselných kontrol. Otisk podkladů vymezuje verzi,
pro kterou byl text připraven. Před syntézou po změně prezentace je třeba
znovu porovnat dotčené snímky, jejich poznámky a scénář.

Kontrola pokrytí potvrdila všechna oznámení snímků právě jednou
a ve správném pořadí. Kontrola mluveného zápisu nenašla číslice,
nezpracované matematické značky, markdown, URL ani řídicí znaky.
Číselně byly nezávisle přepočteny podíly, součin a sjednocení,
prediktivní hodnoty, binomické pravděpodobnosti, normální aproximace
a směrodatná odchylka podílu. Binomické pravděpodobnosti byly počítány
součtem členů pomocí kombinačního čísla; normální chvost pomocí
komplementární chybové funkce, bez převzetí výsledků z Excelu.

Redakční a interní didaktická kontrola zahrnula určení celku při
podmínění, rozsah odmocnin a mocnin, předpoklady modelů, interpretaci
grafů a návaznosti. Nenahrazuje ověření porozumění na studentech.
PPTX, jeho poznámky, kapitola a datové sešity nebyly upraveny.

## Slovník výslovnosti pro tento scénář

Výchozí konfigurace případného budoucího převodu podle projektu:
Creative Claw, `speech/heygen-voice-1`, Adam, čeština, rychlost 1.
Nastavení je evidováno v manifestu; aktuální dostupnost služby,
limity ani podpora parametrů nebyly při přípravě samotného textu ověřovány.

**Žádný z níže uvedených zápisů nebyl v tomto úkolu ověřen poslechem.**
Jde o projektové konvence nebo kandidáty pro konkrétní konfiguraci,
nikoli o tvrzení o skutečné výslovnosti. Scénář nepoužívá SSML ani IPA.

| Odborný zápis | Zápis ve scénáři | Stav a co při budoucím převodu kontrolovat |
|---|---|---|
| P, p | velké/malé pé | Projektový mluvený zápis; zkontrolovat rozlišení velikosti a významu. |
| A, B, A′ | á, bé, á s čárkou | Projektový mluvený zápis; podmínku a opačný jev vysvětluje okolní věta. |
| X, k, n | iks, ká, en | Projektový mluvený zápis. |
| μ, σ, π | mí, sigma, pí | Slovní čtení řeckých značek; zkontrolovat zejména „mí“ a „pí“. |
| S, N v diagramu | es, en; posloupnosti vyjádřeny slovy | Význam „správně/nesprávně“ zazní před popisem diagramu. |
| z-skór | zed-skór | Projektový zápis se spojovníkem, bez poslechového ověření v tomto úkolu. |
| BINOM.DIST | binom-tečka-dyst | Použit kandidátní přepis podle pravidla pro souvislé části názvu. Ověřit název jako celek. |
| BINOM.DIST.RANGE | binom-tečka-dyst-tečka-rejndž | Kandidátní výslovnost zejména části RANGE, dosud neověřená poslechem. |
| NORM.S.DIST | norm-tečka-es-tečka-dyst | Zápis výslovně určený projektovými pravidly; ověřit konkrétní výstup hlasu. |
| KOMBINACE, FAKTORIÁL | kombinace, faktoriál | Ve scénáři běžná slova s vysvětlením argumentů. |
| Bayesova věta | Bayesova věta | Zachován odborný pravopis. Zkontrolovat čtení jména; automatická náhrada nebyla provedena. |
| kvantil, kvantilu | úroveň kvantilu | Zachován odborný pravopis; u Adama je známé riziko změkčení „t“. Kandidát „kvantylu“ nebyl použit ani ověřen. |
| senzitivita, specificita, prevalence | odborný pravopis | Při převodu zkontrolovat výslovnost přejatých slov. |
| apriorní, aposteriorní, binomické | odborný pravopis | Při převodu zkontrolovat srozumitelnost a přízvuk. |

## Stav předání

Připraven je celý textový scénář. Syntéza nebyla spuštěna a žádná
nahrávka nevznikla. Výslovnost ani tempo proto nejsou ověřeny poslechem.
Před případným placeným převodem je třeba dořešit skutečně problematické
výrazy v dané hlasové konfiguraci podle projektových pravidel.
