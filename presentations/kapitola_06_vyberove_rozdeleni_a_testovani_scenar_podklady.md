# Scénář k prezentaci kapitoly 6

Připraveno 2026-11-02. Pro syntézu použijte pouze
[souvislý mluvený text v UTF-8](kapitola_06_vyberove_rozdeleni_a_testovani_scenar.txt).
Tento průvodní dokument a manifest se nepředčítají.

Scénář doprovází **snímky 1–31** aktuální
[prezentace](kapitola_06_vyberove_rozdeleni_a_testovani.pptx), včetně
titulního snímku, přehledu obsahu, tematických předělů a výkladových
řešených příkladů. Samostatné procvičování na snímcích 32–38,
diskusní otázky a organizační pokyny v poznámkách jsou vynechány.

Text má **5 714 slov**. Orientační délka při tempu 105–125 slov za minutu
je přibližně 46–55 minut bez dalších pauz. Je to odhad z počtu slov;
skutečná délka vznikne až převodem. Dlouhé číselné zápisy mohou tempo
ovlivnit. Při přípravě scénáře nahrávka nevznikla. Úplný převod na následnou
výslovnou žádost autora je zaznamenán níže; placená ukázka se nevytvářela.

## Podklady a obsahové ověření

Pořadí, texty, tabulky, rovnice a poznámky byly načteny z aktuálního
místního PPTX, které obsahovalo autorovy necommitované úpravy.
Tyto úpravy jsou na autorův následný výslovný pokyn součástí stejného
commitu. Prezentace nebyla při přípravě scénáře přepisována ani obnovována
z generátoru. Bylo prohlédnuto všech 12 vložených grafů a diagramů;
nejde o novou kontrolu celé sazby prezentace v PowerPointu.

Obsah je porovnán s relevantními pasážemi
[kapitoly](../quarto/kapitola_06.qmd), její
[karty](../docs/kapitoly/06-vyberove-rozdeleni-testovani.md),
[terminologického registru](../docs/SLOVNIK.md#kapitola-06)
a platnými rozhodnutími R28–R30 a R56. Scénář nerozšiřuje prezentaci
o nová nepovinná rozšíření kapitoly. Původ čísel parkovací studie a modelu
se přebírá z kapitoly; původní článek ani Howellova učebnice nebyly
v tomto úkolu nově nezávisle ověřovány.

Výklad výslovně rozlišuje údaje skutečné studie, výukový model a simulaci.
Připomíná také, že rovnost populačních průměrů sama neurčuje celé
výběrové rozdělení: potřebujeme i další předpoklady modelu. Výsledky
výpočtů nejsou vydávány za reprodukci původní analýzy parkovací studie.

[Manifest](kapitola_06_vyberove_rozdeleni_a_testovani_scenar_manifest.json)
obsahuje SHA-256 podkladů a scénáře, skutečné titulky a přiřazení všech
31 úseků ke snímkům, počty slov, výsledky číselných kontrol a evidenci
výslovnostních přepisů. Před převodem po změně PPTX je třeba porovnat
dotčené úseky s novou verzí podkladů.

Nezávisle přepočteny byly směrodatné chyby, rozdělení devíti průměrů,
normální chvosty, kritické hodnoty, síla pro konkrétní alternativy,
binomické pravděpodobnosti a riziko alespoň jednoho zamítnutí ve dvaceti
nezávislých testech. Výpočet používá základní matematické funkce Pythonu,
binomické součty a komplementární chybovou funkci. Simulovaná čísla
z grafů byla porovnána s popisy a kapitolou, simulace se znovu nespouštěla.

U velmi malé p-hodnoty parkovacího modelu se pracuje s přibližným údajem
0,0012; přesný normální výpočet s nezaokrouhlenou směrodatnou chybou
dává přibližně 0,001182. Scénář vysvětluje zaokrouhlení i to, že nejde
o pravděpodobnost hypotézy. NORM.DIST a NORM.S.DIST jsou pouze slovně
popsány podle podkladů; desktopový Excel nebyl v tomto úkolu spouštěn.

Interní didaktická revize zahrnula význam jedné hodnoty v každém
rozdělení, přechod od známého modelu k testu, rozdíl mezi pravidlem
a výsledkem, podmíněnost chyb a síly, rozsah operací ve vzorcích
a kauzální omezení závěrů. Nenahrazuje ověření porozumění na studentech.

## Slovník výslovnosti pro tento scénář

Přepisy jsou závazně použity v samotném textu podle
[TEXT2SPEECH.md](../docs/TEXT2SPEECH.md#slovník-výslovnosti)
a upřesnění R53. Výchozí konfigurace případného převodu je Creative Claw,
model `speech/heygen-voice-1`, český hlas Adam, rychlost 1. Její aktuální
dostupnost a podporované parametry byly ověřeny před následným převodem.

Slovník zachycuje účelový zápis pro syntézu. Nejde o nový odborný pravopis
učebnice ani o poslechem ověřený výkon konkrétního hlasu. Přepisy tvrdých
skupin jsou použity i v příslušných skloňovaných a odvozených tvarech.

| Odborný zápis | Zápis použitý pro syntézu | Původ / kontrola |
|---|---|---|
| statistika, statistický, statisticky | statystyka, statystycký, statystycky | Tvrdé skupiny podle R53; původní základ `statisti` v textu nezůstal. |
| kritický | kritycký | Jazykové posouzení podle R53; kontrola všech tvarů. |
| alternativní, alternativa | alternatyvní, alternatyva | Tvrdé `ti`; koncovka `ní` zůstává měkká. |
| standardizace, standardizovaný | standardyzace, standardyzovaný | Tvrdé `di`; ve scénáři jsou skloňované tvary standardizovaný. |
| systematicky, systematické | systematycky, systematycké | Tvrdé `ti`; textová kontrola. |
| automaticky | automatycky | Tvrdé `ti`; textová kontrola. |
| praktická, praktický | praktycká, praktycký | Tvrdé `ti`; textová kontrola. |
| relativní | relatyvní | Tvrdé `ti`; koncovka `ní` zůstává měkká. |
| problematické | problematycké | Tvrdé `ti`; textová kontrola. |
| pozitivnímu, negativnímu | pozityvnímu, negatyvnímu | Tvrdé `ti`; koncovka `nímu` zůstává měkká. |
| medián | medyán | Tvrdé `di`; textová kontrola. |
| kvantily | kvantyly | Výslovný požadavek autora; základ `kvantil` v textu nezůstal. |
| tipování, tipoval, tipů | typování, typoval, typů | Účelový přepis tvrdého `ti`, význam tipování se nemění. |
| studie, studii, studiích | studyje, studyji, studyjích | Tvrdé `di`, s vyjádřením přechodu mezi samohláskami. |
| screening, screeningu | skrínyng, skrínyngu | Účelový český zápis anglického výrazu a tvrdého `ni`. |
| Howellovy | Hauelovy | Český výslovnostní zápis příjmení. |
| P, p | velké/malé pé; pé-hodnota | Projektový mluvený zápis; označení výsledku testu se neplete s podílem. |
| H₀, H₁ | há s indexem nula, há s indexem jedna | Projektový mluvený zápis. |
| μ, σ, π, α, β | mí, sigma, pí, alfa, beta | Slovní čtení značek; indexy jsou vysvětleny v textu. |
| m, n, s | em, en, es | Mluvené názvy písmen; příslušné indexy zaznívají výslovně. |
| z-skór, z-test, t-test | zed-skór, zed-test, té-test | Projektový zápis se spojovníkem. |
| NORM.DIST, NORM.S.DIST | norm-tečka-dyst, norm-tečka-es-tečka-dyst | Projektové pravidlo pro čtení názvů funkcí. |

Všechny zbývající výskyty `di/ti/ni` a `dí/tí/ní` byly vypsány a posouzeny
v kontextu. Ponechány jsou české měkké skupiny, například v řidič,
hodina, hladina, tisíc, desetina, podíl či třetí, a měkké koncovky
v normální, centrální, limitní, konkrétní či alternativní. Seznam
ponechaných slov je v manifestu. Nešlo o plošnou náhradu všech `i`.

Jazykové rozlišení tvrdých a měkkých skupin vychází také z oddílu
[Skupiny di, ti, ni u přejatých slov v Internetové jazykové příručce ÚJČ](https://prirucka.ujc.cas.cz/?id=914#b3),
načteného 2026-11-02. Obecný výklad není důkazem účinnosti konkrétního
zápisu v syntetickém hlasu. Samostatná hesla studie a tip se přes webové
rozhraní nepodařilo načíst; jejich zápisy jsou evidovány jako jazykové
posouzení, nikoli jako jednotlivě slovníkově ověřené transkripce.

## Stav předání

Ověřeno je pořadí a úplnost všech úseků, slovní přepis čísel a značek,
shoda s podklady a použití výslovnostních náhrad. Kontrola nenašla
číslice, nezpracované matematické značky, markdown, URL ani původní
rizikové slovní základy. Toto textové ověření samo nedokládá výslovnost výsledného zvuku.


## Úplná nahrávka — 2026-11-02

Na výslovnou následnou žádost autora vytvořeno audio ke snímkům 1–31
přes Creative Claw: `speech/heygen-voice-1`, veřejný český hlas Adam
(`32bb79c6f93241b7b956c219aa9bcf75`), jazyk `cs`, rychlost 1.
Před převodem načten aktuální `get_model_params`. Kvůli limitu 5 000
znaků rozdělen nezměněný scénář na deset částí na hranicích snímků;
uložené náhrady služby vypnuty, protože požadované přepisy již obsahuje
samotný scénář. Ověřena shoda všech odeslaných textů s tímto scénářem.

Části spojeny ve správném pořadí bez prolínání a bez normalizace,
s mezivýstupy WAV. Z úplného WAV jednou vytvořen finální MP3 (192 kb/s,
44,1 kHz, mono) se 31 značkami kapitol. Délka je **46:07**.
Značky vycházejí z časů slov vrácených poskytovatelem a skutečných délek
dekódovaných částí, nikoli z počtu slov.

Místní výstup: `presentations/kapitola_06_vyberove_rozdeleni_a_testovani_Adam.mp3`.
MP3 se podle pravidel projektu necommituje ani automaticky nepublikuje.
Manifest obsahuje SHA-256, délku, nastavení, časy všech 31 snímků
a technické kontroly; přesné úlohy, výstupní URL a pracovní úseky
zůstávají v místní složce `tmp/ch06-audio/`.

Všechny části i celý MP3 byly úspěšně dekódovány. Délka celku odpovídá
součtu částí, vložených kapitol je 31 a pořadí bylo dále ověřeno
porovnáním zvukových úseků každé části s příslušným místem celku.
Průměrná úroveň jednotlivých částí je −19,7 až −19,5 dB; detektor
nenašel pauzy delší než dvě sekundy při prahu −50 dB. Finální MP3 má
průměrnou úroveň −22,9 dB a maximum −3,2 dB; služba při spojování
převedla zdroje na stereofonní WAV 48 kHz, výsledný MP3 je opět mono
44,1 kHz. Korelace odpovídajících pětisekundových úseků všech deseti
částí s celkem je nejméně 0,995 po vyrovnání posunu menšího než
0,1 milisekundy vzniklého převzorkováním. Jde o technické
kontroly a časové zarovnání poskytovatele, nikoli o poslechové potvrzení
výslovnosti. Skutečný poslech nebyl proveden.
