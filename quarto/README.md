# Autorská dokumentace

<a id="vizualizace-cohenovo-d"></a>

## Vizualizace Cohenova d (2026-11-13, upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-13-cohen)
přibyla desátá stránka části „Interaktivní vizualizace“,
[Co znamená rozdíl o *d* směrodatných odchylek](viz_cohenovo_d.qmd),
v menu za intervalem a *p*-hodnotou. Kapitola 8 na ni odkazuje blokem
„Vyzkoušejte si: co znamená rozdíl o d směrodatných odchylek“ na konci
oddílu `sec-d-nezavisle`; jinak se výklad kapitoly nemění. Obsahuje:

- **ovládání:** posuvník *d* 0–2 po 0,01 (výchozí 0,5) se značkami 0,2, 0,5 a 0,8, pole σ v původních jednotkách (výchozí 10) a přepínač vybarvení;
- **grafy:** rozdělení obou skupin na ose v jednotkách σ s průměrem skupiny 2 v nule (společná plocha, nebo skupina 1 nad průměrem skupiny 2) a rozdělení rozdílu hodnot náhodné dvojice $N(d,\sqrt2)$ s plochou vpravo od nuly;
- **výpočet a tabulka:** rozdíl průměrů $d\cdot\mathrm{σ}$, tři ukazatele opisem se vzorci českého Excelu a pevná tabulka pro *d* = 0; 0,2; 0,5; 0,8; 1; 1,5; 2.

Redakční volby při realizaci:

- **Jen český opis** podle volby autora: Cohenovo U₃, overlap a probability of superiority nejsou na stránce pojmenovány a nemají hesla ve slovníčku. Pro společnou plochu se nepoužívá slovo „překryv“, které kapitola 8 používá pro překryv intervalů spolehlivosti.
- **Druhý graf a přepínač vybarvení** nebyly v plánu výslovně uvedeny. Graf rozdílu dvojice vysvětluje, proč třetí ukazatel dělí *d* odmocninou ze dvou (opora: sčítání rozptylů v `sec-rozdil-nezavislych`); přepínač ukazuje první ukazatel v témže grafu jako společnou plochu.
- **Cohenovy hodnoty** jsou jen značkami posuvníku a štítky řádků tabulky s výhradou podle R56; stránka nepřiřazuje zvolenému *d* slovní kategorii.
- **Numerika** (`pnorm`, `parseDecimal`) a formátování čísel jsou převzaty z vizualizace *t*-rozdělení. Plot 0.6.11 ze standardní knihovny OJS nezná značku `tick`; šipka vzdálenosti průměrů proto používá `arrow`.
- **Úkol 2** používá parkovací *d* ≈ 0,47 a σ = 14,6 s; rozdíl 6,86 s se od 6,88 s kapitoly liší jen zaokrouhlením *d*.

Nezávislá kontrola:

- **R** (`scripts/viz-cohenovo-d.R`, v repozitáři): tři ukazatele pro devět hodnot *d*, společná plocha i numerickou integrací nižší z hustot (shoda na 1e-9), pravděpodobnost u dvojice simulací milionu dvojic (odchylka pod 0,003), *d* ≈ 0,954 pro pravděpodobnost 0,75 a převody na původní jednotky. Čísla v textu, úkolech a „Čeho si všimnout“ pocházejí z tohoto výstupu.
- **Prohlížeč:** výchozí stav, *d* = 0 a 2, oba režimy vybarvení, celá obrazovka a šířka 375 px prohlédnuty na snímcích.

**Kontroly:** celá kniha vykreslena bez varování (Quarto 1.9.38, R 4.5.1). `check-html.cjs` s novým blokem (popis v [provozním návodu](../docs/PROVOZ.md#interaktivni-vizualizace)) a s novým pořadím menu prošel celý (25 stránek, bez chyb JavaScriptu); prošly také `check-table-layout.cjs` a `check-doc-maps.cjs`.

**Omezení:** ověřeno v Chromiu (Playwright a prohlížeč aplikace); Firefox, Safari, skutečný telefon a čtečka obrazovky nebyly vyzkoušeny. Vzorce Excelu jsou kontrolovány jen jako text a v českém Excelu je nikdo nezadal; jde o funkce NORM.S.DIST a ODMOCNINA, které učebnice používá i jinde.

**Oprava po CI (2026-11-13):** workflow „Ověřit a publikovat učebnici“ po sloučení selhal v `check-table-layout.cjs`: pevná tabulka ukazatelů přetékala při šířce 1024 px o 2 px (541 px k dispozici). Lokálně v systému Windows se vešla; rozdíl je v písmech na Linuxu. Příčinou bylo `white-space: nowrap` záhlaví převzaté z tabulky *t*-rozdělení. V `assets/styles.css` smí záhlaví tabulky `.viz-cd-table` zalomit i mimo ruční zlomy; minimální šířka tabulky klesla na 305 px, při dostatku místa se vzhled nemění. Lokálně ověřeno měřením v Chromiu (1024 a 390 px); výsledek na CI potvrdí až nový běh workflow.

<a id="vizualizace-pokryti-intervalu"></a>

## Vizualizace pokrytí intervalu spolehlivosti (2026-11-13, upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-13-pokryti)
přibyla devátá stránka části „Interaktivní vizualizace“,
[Jak často interval spolehlivosti zachytí populační průměr](viz_pokryti_intervalu.qmd),
v menu mezi *t*-rozdělením a intervalem a *p*-hodnotou. Kapitola 7 na ni
odkazuje blokem „Vyzkoušejte si: pokrytí intervalu spolehlivosti“ na konci
oddílu `sec-interval-t-simulace`. Obsahuje:

- **ovládání:** pět populací (normální; zešikmené se šikmostí 0,7, 2 a 6 ve tvarech `tbl-k07-odolnost` a 8 jako u výběrového rozdělení průměru), μ, σ, *n* 2–1 000, hladinu v %, tři postupy (σ a *z*, *s* a *t*, chybně *s* a *z*), tři typy intervalu (R75), počet nových výběrů 1–10 000 se stropem 100 000 a tři předvolby;
- **grafy:** posledních 100 intervalů s výběrem jednoho z nich, vývoj pokrytí s pásem ± 1,96 směrodatné chyby podílu a histogramy průměrů, *s* a šířek (u jednostranného intervalu mezní chyby) rozdělené barvou podle výsledku;
- **tabulky:** pokrytí a minutí pod a nad μ v simulaci a podle očekávání, souhrny rozdělení a výpočet vybraného intervalu se vzorci českého Excelu.

Redakční volby při realizaci:

- **Ukládají se jen *m* a *s*** každého výběru (Welfordův postup). Proto lze po změně hladiny, postupu nebo typu přepočítat tytéž výběry; změna populace, μ, σ nebo *n* začne znovu se 100 výběry.
- **Seed** 20261110 byl vybrán tak, aby prvních 100 výběrů výchozího modelu dalo 94 zachycených intervalů se známou σ (jako obrázek kapitoly) a 97 s *t*-kvantilem; s původně zvoleným seedem jich bylo 99, což by při prvním pohledu mátlo.
- **Očekávání u zešikmených populací** je uvedeno slovně podle tabulky v plánu a výsledků `scripts/viz-pokryti-intervalu.R` (100 000 výběrů na řádek, *n* = 5, 10, 25 a 100). Oproti plánu: oboustranný interval se známou σ má pokrytí „o málo vyšší než slibované“ (95,1–95,8 %), ne „přibližně slibované“; u chybného postupu s dolní mezí text uvádí, že při mírné šikmosti a *n* = 5 převážil příliš malý kvantil (93,9 %), jinak šikmost (95–99 %). Řádek *s* a *t* pro *n* = 25 odpovídá tabulce kapitoly 7 (94,6 / 92,3 / 87,4 % proti 94,7 / 92,4 / 87,7 %, rozdíly v mezích náhodné chyby simulace).
- **Osa grafu intervalů** se po připomínce autora z téhož dne přizpůsobuje všem konečným mezím a průměrům zobrazených intervalů (nejméně μ ± 4,5 směrodatné chyby, „hezké“ meze osy). Trojúhelník na okraji zůstal jen pro nekonečnou mez jednostranného intervalu; dřívější pevný rozsah osy kreslil šipku i u konečných mezí mimo osu. Na stejnou připomínku je graf vyšší: 7 px na řádek (na mobilu 6 px), při méně než 51 intervalech 11 px (9 px).
- **Histogram šířek** se při známé σ nekreslí (všechny šířky stejné); místo něj věta s šířkou a odkazem na hranice μ ± mezní chyba v histogramu průměrů. Rozsah histogramů pokrývá od 1 000 výběrů prostředních 99,8 % hodnot; počet hodnot mimo rozsah je uveden pod grafem.
- **Pás kolísání** u zešikmených populací leží kolem slibovaného pokrytí, protože očekávané přesně neznáme.
- **Souhrn průměru *s*** obsahuje krátkou poznámku, že výběrová *s* σ v průměru mírně podhodnocuje; nejde o nový pojem učebnice a nemá heslo.
- **Numerika** (`pnorm`, `qnorm`, `pt`, `qt`) a formátování čísel jsou převzaty z vizualizace intervalu a *p*-hodnoty, dávkové losování z vizualizace výběrového rozdělení průměru.

Nezávislá kontrola:

- **R** (`scripts/viz-pokryti-intervalu.R`, v repozitáři): kvantily, přesné pokrytí chybného postupu, meze pro *m* = 46, *s* = 11, simulace pokrytí pro pět populací, tři postupy, tři typy a čtyři velikosti výběru; hodnoty jsou v kontrole webu. Text úkolů a „Čeho si všimnout“ používá jen čísla z R (87,8 / 93,8 / 94,7 %, asi 92 % při *n* = 100) a deterministický výchozí stav (94 ze 100).
- **Excel:** kvantily, směrodatná chyba a meze ve tvaru, který stránka nabízí (`NORM.S.INV`, `T.INV`, `ODMOCNINA`, záporné *m* v závorce), zadány přes `FormulaLocal` do skryté samostatné instance českého Excelu v novém sešitu bez uložení; výsledky se shodují s R.
- **Prohlížeč:** výchozí stav, postup *t* na týchž výběrech, výrazně zešikmená populace, 10 000 výběrů po 1 000 (dávky, asi 0,7 s), šířka 375 px bez přetékání; grafy prohlédnuty na snímcích. Na 10 100 výběrech normální populace s *t*-kvantilem minulo μ 7,6 % intervalů s *s* < σ a 2,3 % ostatních, což podkládá větu o častějším minutí úzkých intervalů.

**Kontroly:** celá kniha vykreslena bez varování (Quarto 1.9.38, R 4.5.1). `check-html.cjs` s novým blokem (popis v [provozním návodu](../docs/PROVOZ.md#interaktivni-vizualizace)) a s novým pořadím menu prošel celý (24 stránek, bez chyb JavaScriptu); prošly také `check-table-layout.cjs` a `check-doc-maps.cjs`. Snímky celé obrazovky a mobilu z kontroly prohlédnuty. Po posledním vykreslení se změnila jen jedna věta úvodu stránky (histogram šířek při známé σ); stránka byla znovu vykreslena samostatně.

**Omezení:** ověřeno v Chromiu (Playwright a prohlížeč aplikace); Firefox, Safari, skutečný telefon a čtečka obrazovky nebyly vyzkoušeny. Výběr intervalu myší je ověřen ručně, automaticky jen klávesami. Losování v prohlížeči používá generátor d3, simulace v R generátor R; shoda pokrytí je proto jen v mezích náhodné chyby (kontrola připouští 0,008, resp. čtyři směrodatné chyby). Didaktická revize textu proběhla interně čtením očima studenta, ne na studentech.

## Interaktivní vizualizace na celou obrazovku (2026-11-13)

Na autorův dotaz, zda lze lightbox použít i pro vizualizace: GLightbox
zvětšuje jen obrázky `<img>`, kdežto grafy vizualizací jsou živá SVG, která
OJS překresluje při každé změně vstupu. Autor zvolil místo lightboxu
zobrazení celého bloku na celou obrazovku. Nový sdílený skript
`assets/viz-fullscreen.js` (připojen v `assets/after-body.html`) vloží do
každého `.viz` tlačítko „Zobrazit na celou obrazovku“ / „Zavřít celou
obrazovku (Esc)“ s `aria-pressed`; celý blok včetně ovládání, výsledků
a tabulek zůstává funkční. V prohlížečích bez Fullscreen API pro prvky
(Safari na iPhonu) se tlačítko nevloží. Všech osm stránek `viz_*.qmd` zvedá
na celé obrazovce strop šířky grafů ze 780 na 1200 px (třída
`viz-is-fullscreen`), překreslení zajišťuje stávající `ResizeObserver`.
Styly v `assets/styles.css`: bílé neprůhledné pozadí, posouvání,
obsah vystředěný do 1240 px, lišta s tlačítkem přilepená nahoře. Výklad,
data ani PDF se nemění. Pravidlo pro nové vizualizace doplněno do
`AGENTS.md` a [provozního návodu](../docs/PROVOZ.md#interaktivni-vizualizace).
Nové rozhodnutí v registru nezaloženo (technická úprava webu jako lightbox
2026-11-01).

**Kontroly:** celá kniha vykreslena; `check-html.cjs` s novým testem
u vizualizace *t*-rozdělení (jedno tlačítko, celá obrazovka je blok `.viz`,
grafy širší o víc než 100 px, posuvník dál mění stav, neprůhledné pozadí,
po zavření původní šířka a stav tlačítka) prošel celý. Pomocným průchodem
všech osmi stránek ověřeno: jedno tlačítko na stránce, šířka grafů 749 px →
1200 px → 749 px, mobil 375 px bez vodorovného přetékání s viditelným
tlačítkem. Snímky celé obrazovky prohlédnuty u *t*-rozdělení, statistické
síly a Bayesovy věty; nalezený překryv prvního řádku přilepenou lištou
opraven (`top: -1rem` podle odsazení bloku).

**Omezení:** ověřeno jen v Chromiu (Playwright, bez zobrazení); v něm
Escape celou obrazovku nezavírá, test proto zavírá přes
`document.exitFullscreen()`. Firefox, Safari, skutečný telefon a čtečka
obrazovky nebyly vyzkoušeny. Mřížka osob Bayesovy věty a některé tabulky
mají vlastní šířku a na celé obrazovce se nezvětšují.

<a id="vizualizace-interval-a-test"></a>

## Interval spolehlivosti a *p*-hodnota: vizualizace a terminologie intervalů (2026-11-13, R75, upřesnění R65)

**Terminologie ([R75](../docs/rozhodnuti/kapitola-07.md#r75-oboustranny-jednostranny-interval)).**
„Centrální interval“ a „horní/dolní jednostranná mez“ nahradily termíny
oboustranný interval spolehlivosti a jednostranný interval spolehlivosti
s horní, nebo dolní mezí. Upraveno:

- kapitola 7: nadpis a výklad oddílu `sec-jednostranny-a-interval` (ID beze změny; tři termíny tučně s anglickými ekvivalenty, jedna věta o „centrálním“ intervalu, nově i interval s dolní mezí [42,24; ∞)), věta o kvantilu $z_{1-\mathrm{α}}$, odkazy v řešeném *t*-testu, tabulce tří cest, oddílu TOST a rozšíření o noninferioritě, Shrnutí a řešení 8c, popisek a alternativní text obrázku `fig-jednostranne-intervaly`;
- `scripts/kapitola_07.R`: popisky řádků obrázku (třetí řádek dvouřádkově, aby se vešel do okraje);
- slovníček (dvě nová hesla), autorský slovník, přehled značení (`vztah-kvantil-hladina`);
- prezentace: slide 23 v PPTX (text a vložený obrázek znovu vykreslený týmž kódem jako PNG 1980 × 792 px), heslovité poznámky slidu 23, podrobné poznámky v DOCX u slidů 23 a 27, strana 23 v PDF slidů;
- scénář: výklad snímku 23; manifest dostal záznam `post_audio_script_edits`, podklady scénáře datovaný oddíl.

Grep po repozitáři (mimo `_book`, `sources`, `tmp`) po úpravě nenašel „centrální interval“ ani „jednostranná mez“ v kapitole, přehledech a prezentaci kromě záměrných míst: alternativa ve slovníčku a slovníku, věta o označení „centrální“, historické záznamy a doklady. Grafy cvičení prezentace a sešit kapitoly 7 staré termíny nepoužívaly.

**Vizualizace ([upřesnění R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-12-interval)).**
Osmá stránka části „Interaktivní vizualizace“,
[Jak spolu souvisí interval spolehlivosti a *p*-hodnota](viz_interval_a_test.qmd),
v menu za vizualizací *t*-rozdělení. Obsahuje:

- **ovládání:** μ₀ a *m* posuvníkem i polem, *s*, *n*, α, směr testu a tři předvolby kapitoly 7;
- **dva grafy pod sebou** se společnou osou skóre: pohled intervalu (*p*-hodnota podle μ₀, interval kolem *m*) a pohled testu (*p*-hodnota podle *m*, oblast nezamítnutí kolem μ₀), v obou *m*, μ₀ a vzdálenost |*m* − μ₀| s mezní chybou;
- **jednostranný test:** jednostranný interval a oboustranný interval 1 − 2α, zrcadlově jednostranná a souměrná oblast, tenká křivka oboustranné *p*-hodnoty s hladinou 2α;
- **výpočet** se vzorci českého Excelu a tabulku čtyř pohledů na rozhodnutí.

Kapitola 7 odkazuje blokem „Vyzkoušejte si: interval spolehlivosti a *p*-hodnota“ na konci oddílu o jednostranném intervalu. Upravené soubory pro vizualizaci: `_quarto.yml`, styly (`.viz-ia-…`), `check-html.cjs` (pořadí v menu, nová kontrola), karta kapitoly 7, OSNOVA.md, plán pokračování, registr, doklad R65 a PROVOZ.md.

Redakční volby při realizaci:

- **Rozsah osy** se mění jen při změně *s*, *n*, α, směru, předvolby nebo zápisu hodnoty mimo rozsah, nikdy při tažení posuvníku; krok posuvníku je řád *s<sub>m</sub>*/10 (výchozí 0,1 bodu). Pole přijímá libovolně přesné číslo.
- **Pohled testu** drží *s* pevnou; stránka výslovně upozorňuje, že jiný výběr by měl i jinou *s*, jak uvádí kapitola 7.
- **Rozhodnutí na mezi** zamítá (p ≤ α); čtyři pohledy počítá stránka zvlášť s tolerancí 10⁻⁹, aby se přesně na mezi nerozcházely.
- **Mobil:** popisky řádků se zalamují, popisek *p*-hodnoty u bodu je zkrácený na „p = …“, popisky α a 2α stojí na opačných okrajích.
- **Numerika** (distribuční funkce a kvantil *t*-rozdělení) je převzata z vizualizace *t*-rozdělení.
- **Odchylka od plánu:** v obou grafech je jen jedna šipka |*m* − μ₀| s textem mezní chyby; mezní chyba sama se nekreslí jako další úsečka, odpovídá polovině šířky pruhu.

Nezávislá kontrola (skripty ve `scratchpad`, mimo repozitář):

- **R:** pro sedm nastavení (tři směry, pozornost, PDI, záporné μ₀ s α = 0,01, *n* = 200 s α = 0,1, *n* = 2 s α = 0,5) *p*-hodnota, kvantil, mezní chyba a meze podle vzorců a navíc `t.test` na datech s přesně zadaným *m* a *s*. Stránka se shoduje na 10⁻⁹ relativně; hodnoty jsou v kontrole webu.
- **Excel:** dvanáct vzorců stránky (`ODMOCNINA`, `T.DIST.2T`, `T.DIST`, `1-T.DIST`, `T.INV`, `T.INV.2T`) zadáno přes `FormulaLocal` do skryté samostatné instance českého Excelu v novém sešitu bez uložení; výsledky se shodují s R.

Celá kniha byla vykreslena. Prošly `check-html.cjs` (nová kontrola podle PROVOZ.md), `check-table-layout.cjs` a `check-doc-maps.cjs`. Prohlédnuty snímky výchozího stavu, jednostranného testu a PDI při šířce 1280 a 375 px; podle nich byly upraveny rozestupy řádků, zalamování popisků a umístění popisků α. Prohlédnut oddíl kapitoly 7 s novým obrázkem a slide 23 v exportu PowerPointu (strana 23 nahrazena v původním PDF z Acrobat PDFMaker, ostatní strany beze změny).

Neověřeno: rozvržení DOCX ve Wordu (export do PDF přes COM se opakovaně zasekl a instance byla ukončena; DOCX ověřen jen extrakcí textu, Word jej otevřel); MP3 nahrávka nebyla znovu syntetizována a u snímku 23 zůstává ve starší terminologii; ovládání čtečkou obrazovky. Didaktická revize stránky a změněného oddílu proběhla interně čtením očima studenta; není ověřením na studentech.

<a id="vizualizace-t-rozdeleni"></a>

## Vizualizace *t*-rozdělení a normovaného normálního (2026-11-12, upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-12-t)
přibyla sedmá stránka části „Interaktivní vizualizace“,
[Jak se *t*-rozdělení liší od normovaného normálního](viz_t_rozdeleni.qmd),
v menu za statistickou silou. Obsahuje:

- **ovládání:** posuvník 1–100 stupňů volnosti (výchozí 4), hranici *x* (−10 až 10, výchozí −1,645) a přepínač veličiny chyb (podíl ve chvostu, nebo výška hustoty);
- **výsledky:** podíly za hranicí v obou rozděleních, obě chyby s dosazením a vzorce českého Excelu;
- **čtyři grafy:** hustoty s vybarveným chvostem, normální Q–Q graf, absolutní chyba a relativní chyba;
- **dvě tabulky:** živou tabulku kvantilů pro úrovně 0,90–0,9995 a pevnou tabulku pro 13 vybraných stupňů volnosti se zvýrazněným, případně vloženým řádkem;
- **výklad chyb:** oddíl „Co ukazují grafy chyb“ se vzorcem, řešeným příkladem (30 stupňů volnosti, hranice −1,645 a −3) a zdůvodněním růstu relativní chyby ve chvostech.

Kapitola 7 odkazuje blokem „Vyzkoušejte si: *t*-rozdělení a normované normální rozdělení“ v oddílu Studentovo *t*-rozdělení; jiný text kapitoly se nemění.

Upravené soubory: `_quarto.yml`, styly (`.viz-t-…`), `check-html.cjs` (pořadí v menu, nová kontrola), karta kapitoly 7, OSNOVA.md, plán pokračování, registr, doklad R65 a PROVOZ.md. Nové pojmy, značení ani funkce Excelu nepřibyly: absolutní a relativní chyba jsou popsány bez hesla, funkce jsou v přehledu Excelu. Slovníček a přehledy se nemění.

Redakční volby při realizaci:

- **Osy:** vodorovná osa je pevná od −5 do 5. Osa absolutní chyby se přizpůsobuje stupňům volnosti (chyba se mezi 1 a 100 stupni volnosti zmenší asi osmdesátkrát).
- **Odchylka od schváleného plánu:** osa relativní chyby vede od −100 % do +30 %. Výjimkou je výška hustoty při 1–3 stupních volnosti, kde relativní chyba kolem středu dosahuje až +52 % (R) a horní mez se zvýší. Pevná osa podle plánu by křivku ořízla; stránka to uvádí.
- **Q–Q graf** zobrazuje úrovně 0,0005–0,9995 se svislou osou ±8. Body mimo ni jsou oříznuté a poznámka uvede úroveň, od které leží mimo graf.
- **Tabulky** se při šířce okna 1024 px vejdou díky užšímu odsazení buněk a zalomeným záhlavím; na mobilu se posouvají jen uvnitř rámečku.
- **Numerika:** distribuční funkce *t*-rozdělení se počítá z regularizované neúplné beta funkce, kvantil Newtonovou metodou s bisekční pojistkou (pro 1 a 2 stupně volnosti uzavřeným tvarem).

Nezávislá kontrola (skripty ve `scratchpad`, mimo repozitář):

- **R:** `dt`, `pt` a `qt` pro 1, 2, 4, 29, 30 a 100 stupňů volnosti, `pnorm` a `qnorm`, čísla řešeného příkladu, úkolů a oddílu „Čeho si všimnout“ (maximum absolutní chyby, relativní chyba v *x* = 5) a obě tabulky. Stránka se shoduje na 10⁻⁹ relativně a hodnoty jsou zapsány v kontrole webu.
- **Excel:** deset vzorců stránky (`T.DIST` s PRAVDA i NEPRAVDA, `1-T.DIST`, `NORM.S.DIST`, `T.INV`, `NORM.S.INV`) bylo zadáno přes `FormulaLocal` do skryté samostatné instance českého Excelu v novém sešitu bez uložení. Výsledky se shodují s R a se stránkou.

Celá kniha byla vykreslena. Prošly `check-html.cjs` (nová kontrola podle PROVOZ.md), `check-table-layout.cjs` a `check-doc-maps.cjs`.

Prohlédnuty snímky při 1, 4, 30 a 100 stupních volnosti, výška hustoty při 1 stupni volnosti a šířka 375 px. Podle nich byly upraveny:

- horní mez osy relativní chyby;
- okraj a počet desetinných míst osy absolutní chyby;
- zalamování záhlaví tabulek;
- dílky osy *x* na mobilu.

Didaktická revize stránky proběhla interně čtením očima studenta po kapitole 7. Upřesnila „v absolutní hodnotě menší“ a nulovou chybu u hranice 0; nové pojmy nepřibyly. Není ověřením na studentech. Neověřeno: ovládání čtečkou obrazovky; klávesy Page Up a Page Down posuvníku (nativní chování prohlížeče, krok závisí na prohlížeči).

<a id="prezentace-kapitoly-7-autorske-upravy"></a>

## Prezentace kapitoly 7: autorské úpravy poznámek a PDF slidů (2026-11-11)

Autor upravil heslovité poznámky v `presentations/kapitola_07_interval_t_test_a_ekvivalence.pptx`
po sloučení PR 187: zpřesnil formulace (slidy 2, 4–7, 9, 13, 14, 18–21), rozdělil
víceřádkové postupy na samostatné odrážky (slidy 6, 12, 16) a vypustil odkazy na listy
sešitu a na nepovinné rozšíření (slidy 12, 14, 19). U slidů 1, 3, 10, 17 a 22 a v textu
slidů 7, 9, 10, 13, 21–23, 25, 26 a 29 se změnilo jen formátování (kurzíva značek),
nikoli text. Nově je v repozitáři export slidů
`presentations/kapitola_07_interval_t_test_a_ekvivalence.pdf` (40 stran, Acrobat PDFMaker),
stejně jako u předchozích kapitol.

Následně byly opraveny dva překlepy v poznámkách (slide 9 „Hladina spolehlivosti“,
slide 18 „matky v intervenčním programu“), na slidu 2 sjednocena terminologie („hladina spolehlivosti“ místo „úroveň spolehlivosti“, „interval“ místo zkratky „CI“; zkratka CI zůstává jen v ukázce reportování podle APA 7 na slidu 32) a podle R74 sladěny podrobné poznámky
v `kapitola_07_poznamky.docx` s věcnými doplňky autora: u slidu 4 důvody změny
variability (citlivost vůči spánkové deprivaci, potřeba spánku), u slidu 14 směr
liberálního jednostranného testu (opačný vůči zešikmení, při šikmosti doprava test
„menší“; shodně s oddílem kapitoly o předpokladech) a označení „těžké chvosty“.
Ostatní autorské úpravy už podrobné poznámky obsahovaly; podrobnosti, které autor
z heslovitých poznámek vypustil (Howellova kontrola 56 hodnot PDI, odkaz na nepovinné
rozšíření, listy sešitu), v DOCX zůstávají.

**Ověření:** porovnání textu slidů a poznámek s verzí ze sloučeného PR 187; počet
stran PDF odpovídá počtu slidů. Opravy provedeny přes PowerPoint a Word na kopiích;
porovnání textu potvrdilo změnu jen na zamýšlených místech, formátování okolních
úseků zůstalo. DOCX ve Wordu: 19 stran. PDF slidů se opravy netýkají (jen poznámky).

<a id="ci-casove-limity"></a>

## CI: časové limity sestavení (2026-11-11)

Dne 2026-11-11 mezi 15:00 a 16:55 se běhy workflow **Ověřit a publikovat učebnici**
nedokázaly připojit k balíčkovému serveru Ubuntu (`Temporary failure resolving
'azure.archive.ubuntu.com'`). Krok `setup-r` při instalaci R přes `apt` visel asi
1,5 hodiny a skončil chybou `Failed to install R … exit code 100`. Šlo o výpadek
mimo repozitář; po opakovaném spuštění instalace R prošla a sestavení po sloučení
#187 bylo úspěšně publikováno.

Aby další výpadek neblokoval běh hodiny, má `.github/workflows/book.yml` nově časové
limity: sestavovací job 40 minut, kroky `setup-r` a `npx playwright install --with-deps`
po 10 minutách, publikační job 15 minut. Běžné úspěšné běhy trvaly 7–15 minut
(`setup-r` asi 30 s). Popis je v [provozním návodu](../docs/PROVOZ.md#kontroly-a-github).

**Ověření:** úspěšný běh workflow v tomto PR. Chování limitu při skutečném výpadku
ověřeno nebylo.

<a id="poznamky-kapitoly-7-heslovite"></a>

## Prezentace kapitoly 7: heslovité poznámky v PPTX, podrobné v DOCX (2026-11-11)

Podle pokynu autora (konvence [R74](../docs/rozhodnuti/postupy-a-dokumentace.md#r74-heslovite-poznamky))
mají poznámky v `presentations/kapitola_07_interval_t_test_a_ekvivalence.pptx` nově
heslovitou podobu pro vyučujícího: 224 odrážek, asi 3 300 slov místo 7 800. Výchozím
podkladem byly dosavadní poznámky a scénář zvukového doprovodu. Na každém slidu zůstala
otázka k zamyšlení se stručnou odpovědí; čas pro vyučujícího a odkaz na oddíl kapitoly
jsou jen v DOCX. U úloh 34–39 je uveden výsledek a klíčový argument, u otevřených úloh
jedno heslo k přijatelným odpovědím. Text slidů včetně autorových úprav z téhož dne
(znak `=` před T.INV a T.DIST na slidech 12 a 16) se nezměnil.

`presentations/kapitola_07_poznamky.docx` nese podrobné poznámky v celých větách.
Slidy 5–40 mají původní znění z commitu aba1568 (shodné s dosavadním DOCX). Slidy 1–4
přebírají autorovo zkrácené znění z 2026-11-11, doplněné o otázku k zamyšlení, čas
a odkaz na oddíl z původní verze. Opraveny byly překlepy na slidu 4: norma μ = 50
(ne 10), směrodatná chyba 10 / √25 = 2 (ne 10/√5), mínus místo pomlčky a značky
σ = 10 a s = 11 místo mluveného „Sigma deset“ a „es jedenáct“.

Postup (v gitignorovaném `tmp/chapter07-presentation/`): zdroj `notes-short.md`
převádí `notes-short-json.cjs` na text a tučné úseky; `write-notes.ps1` je přes
PowerPoint zapíše do kopie (Arial 12 b., odrážky, jazyk čeština) a teprve po kontrole
nahradí cílový soubor. DOCX sestavuje `notes-docx-detail.cjs` ze stejné předlohy jako
dosud.

**Ověření:** text všech slidů je shodný s autorovou verzí ze dne 2026-11-11; v PowerPointu
má každý ze 40 slidů poznámky shodné se zdrojem. Všech 224 odstavců má odrážku
a češtinu, všech 126 tučných úseků je na místě (`check-notes.ps1`). Každé číslo
v heslovitých poznámkách bylo porovnáno s podrobnými poznámkami a textem slidu.
21 neshod tvoří čísla psaná slovy, √25 = 5 a krátké odpovědi doplněné k otázkám, které
dosud odpověď neměly (slidy 19, 23, 30 a 32); interval u slidu 30 přepočítán v R. Stránky s poznámkami byly vytištěny do PDF
a prohlédnuty (slidy 6, 30, 34). DOCX otevřen ve Wordu: 40 nadpisů „Slide N: titulek“,
19 stran, čeština; první strana prohlédnuta.

**Omezení:** zástupné symboly obrázku slidu a poznámek mají na stránkách poznámek
nulovou velikost, a to už v předchozí verzi (generátor z 2026-11-09). Zobrazení
řečníka a podokno poznámek to neovlivňuje, tisk stránek poznámek ano. Pro vizuální
kontrolu byla proto pole zvětšena jen v pomocné kopii; v prezentaci se to neopravovalo.
Zobrazení řečníka během skutečné projekce vyzkoušeno nebylo. Dolní indexy v Unicode
(z₀,₉₇₅) PowerPoint vykresluje náhradním písmem.

<a id="terminy-kapitoly-10-schvaleni"></a>

## Kapitola 10: schválení termínů K10-N1 až K10-N4 (2026-11-11)

Autor schválil všechny čtyři návrhy ([doplnění R73](../docs/rozhodnuti/kapitola-10.md#r73-schvaleni-navrhu-2026-11-11)).
Do slovníčku a registru přibyla hesla **omezení rozsahu**, **korelační matice**, **analýza citlivosti**
a nepovinné **interval BCa**; text kapitoly se nezměnil. Kontrola: render kapitoly a slovníčku,
`check-html.cjs` a `check-doc-maps.cjs`.

<a id="vytvoreni-kapitoly-10"></a>

## Kapitola 10: vytvoření kapitoly o korelaci (2026-11-11)

Podle [R71](../docs/rozhodnuti/kapitola-10.md#r71-rozsah-kapitoly-10)–[R73](../docs/rozhodnuti/kapitola-10.md#r73-terminologie-kapitoly-10)
a [upřesnění R71](../docs/rozhodnuti/kapitola-10.md#r71-upresneni-2026-11-09) vznikla
kapitola `quarto/kapitola_10.qmd` (13 oddílů, tři nepovinná rozšíření, 16 + 2 cvičení
s úplnými řešeními), skript `scripts/kapitola_10.R` (data, výpočty, 12 obrázků, export
vstupů a pevných indexů převzorkování), simulace `scripts/kapitola_10-pokryti.R`,
sešit `data/kapitola_10.xlsx` (35 listů) s generátorem `scripts/kapitola_10-sešit.mjs`,
kontroly `check-chapter-10.R`, `check-chapter-10-excel.ps1` a jejich očekávané hodnoty
z `check-chapter-10-excel-expected.R`, hesla ve slovníčku, značení a přehledu Excelu,
karta kapitoly, oddíl `DATA.md` a záznam použití podkladů.

**Společná infrastruktura:** zapisovač sešitů nově zná hromadný zápis jednoho českého
vzorce do celé oblasti (`fillFormulaLocal`) a vzorce dynamického pole (`fillFormula2Local`);
kontrola chyb vzorců u listů nad 20 000 buněk používá `SpecialCells` místo procházení
buněk. Ostatní kapitoly se chovají jako dosud. Spouštěč sešitů a kontroly přijímají
kapitolu 10; před sestavením kapitoly 10 se spustí `scripts/kapitola_10.R`
s `CH10_NOFIG=1` (bez obrázků).

**Ověření:** `check-chapter-10.R` porovnal postupy se základním R (`cor`, `cor.test`,
`t.test`, `rank`) a všechna čísla citovaná v textu a řešeních včetně výsledků simulace
pokrytí. `check-chapter-10-excel.ps1` v samostatném skrytém Excelu 16.0 (český) prošel
131 kontrol: uložené výsledky všech výpočtových listů, devět českých vzorců z textu,
sedm scénářů s daty cvičení 3, 6, 7, 8, 9, 12 a 13 a ověření, že součty přes dvojice
jsou vzorci dynamického pole (zadání postaru dává jiný výsledek). Kontrola chyb všech
deseti sešitů a `check-workbooks.py` prošly. Celá kniha vykreslena; `check-html.cjs`
prošel včetně nového bloku pro kapitolu 10 (18 řešení, 12 obrázků, stojaté řecké
symboly, sbalená rozšíření, mobilní šířka 390 px). Při kontrole byly opraveny tři
přetékající rovnice či vzorce na mobilu a ručně psaná čísla oddílů v odkazech.
Obrázky prohlédnuty v PNG kopiích (`CH10_PNG=1`) a ve snímcích kontroly webu.

**Omezení:** sešit nebyl otevřen ve starší verzi Excelu, v Excelu pro Mac ani ve
webovém Excelu. Simulace pokrytí platí jen pro spojité dvourozměrné normální populace
bez shod. Ruscio (2008) a srovnávací studie ve *Frontiers in Psychology* nebyly čteny.
Didaktická revize proběhla vlastním čtením; samostatný agent v roli studenta ani
autorská odborná revize zatím neproběhly. Otevřené jsou terminologické návrhy
K10-N1 až K10-N4 (omezení rozsahu, korelační matice, analýza citlivosti, interval BCa).
Necommitované úpravy kapitol 1 a 2 (formátování vizuálním editorem RStudia, které
odstranilo identifikátory tabulek) byly na pokyn autora zahozeny.

<a id="prototyp-prevzorkovani-10"></a>

## Kapitola 10: prototyp převzorkování v Excelu (2026-11-09)

Podle [R71](../docs/rozhodnuti/kapitola-10.md#r71-rozsah-kapitoly-10) se před
psaním ověřilo, zda desktopový Excel bez maker zvládne percentilový bootstrap
a permutační test pro *r*<sub>s</sub> a τ<sub>b</sub>. Smyšlená data: 30 dvojic
(vnímaný stres 0–16 se 14 různými hodnotami, kvalita spánku 1–7 se 7 hodnotami),
pevné indexy výběrů s vracením a permutací ze seedu. Skripty
`scripts/kapitola_10-prototyp-prevzorkovani.R` (data, indexy a referenční
výsledky) a `scripts/kapitola_10-prototyp-prevzorkovani.ps1` (sestavení
v samostatné skryté instanci Excelu, výstup do `tmp/`); nejde o generátor
studentského sešitu.

**Konstrukce:** listy indexů, převzorkovaných hodnot (INDEX), pořadí
(RANK.AVG v řádku) a výsledků; *r*<sub>s</sub> jako CORREL pořadí, τ<sub>b</sub>
jako SOUČIN.SKALÁRNÍ(SIGN(…−TRANSPOZICE(…))·SIGN(…)) s počty shod v obou
proměnných; meze PERCENTIL.INC; *p*-hodnota (počet |statistik| ≥ |pozorované|
+ 1)/(*B* + 1). U permutací se pořadí neopakují (permutují se pořadí druhé
proměnné) a jmenovatel τ<sub>b</sub> je pevný.

**Výsledky (Excel 16.0, build 20430, český):**

| *B* | Meze *r*<sub>s</sub> | Meze τ<sub>b</sub> | *p* (*r*<sub>s</sub>; τ<sub>b</sub>) | Soubor | Otevření | Přepočet po změně vstupu |
|---|---|---|---|---|---|---|
| 1 999 | −0,7299; −0,1251 | −0,6100; −0,0962 | 0,0070; 0,0050 | 4,4 MB | asi 4 s | 0,1 s |
| 9 999 | −0,7440; −0,1266 | −0,6313; −0,1000 | 0,0060; 0,0048 | 22,2 MB | asi 21 s | 0,8 s |

Pozorované hodnoty *r*<sub>s</sub> = −0,4798 a τ<sub>b</sub> = −0,3836 i všechny meze
a *p*-hodnoty se shodují s nezávislým výpočtem v R (`rank`, vlastní τ<sub>b</sub>
ověřené proti `cor(..., method = "kendall")`, `quantile(type = 7)`) na všech
vypsaných místech; nedefinovaný bootstrapový výběr se nevyskytl. Opakování
z repozitářových skriptů dalo pro *B* = 1 999 stejné výsledky.

**Nálezy:**

- Výpočet je rychlý i pro 9 999 opakování; omezením je velikost souboru,
  doba otevření a uložení (asi 14 s), nikoli přepočet.
- Vzorec pro τ<sub>b</sub> s TRANSPOZICE uvnitř SOUČIN.SKALÁRNÍ funguje jen jako
  vzorec dynamického pole (Excel 365 / 2021 a novější). Týž vzorec zadaný
  klasicky (`Formula`, obdoba starší verze Excelu bez Ctrl+Shift+Enter) vrátil
  bez chybového hlášení nesprávný součet 0,5 místo −146. Výklad i zadání musí
  uvádět požadavek na verzi; chování sešitu otevřeného ve starší verzi
  ověřeno nebylo.
- Rozdíl mezí mezi 1 999 a 9 999 opakováními je ve druhém desetinném místě
  (např. dolní mez τ<sub>b</sub> −0,610 vs. −0,631): simulační kolísání
  bootstrapu je ve výkladu vidět a stojí za vysvětlení.
- Načtení CSV v českém Excelu používá středník; vstupy prototyp čte přes
  OpenText s výslovnou čárkou. Pro generátor sešitu jde jen o technickou poznámku.

**Neověřeno:** přesná permutace pro šest osob v Excelu (jen v R:
*p* = 0,0056 pro *r*<sub>s</sub> a 0,0111 pro τ<sub>b</sub>), pokrytí percentilového
intervalu simulací, starší verze Excelu, Excel pro Mac a webový Excel, vzhled
listů.

**Rozhodnutí autora týž den:** sešit počítá vzorci 1 999 opakování a vedle
uvede ověřené hotové výsledky 9 999 opakování
([upřesnění R71](../docs/rozhodnuti/kapitola-10.md#r71-upresneni-2026-11-09)).

<a id="dohoda-kapitola-10"></a>

## Kapitola 10: dohoda o obsahu (2026-11-09)

Autor se zeptal, zda má kapitola 10 vykládat Pearsonovo *r*, alternativní
koeficienty, jednoduchou regresi nebo jejich kombinaci. Doporučená kombinace
korelace a regrese nebyla zvolena; autor vybral „Jen korelace“ a požadoval
povinné Kendallovo τ. Poté předložil vlastní plán s povinným permutačním
testem a percentilovým bootstrapovým intervalem pro pořadové koeficienty,
τ<sub>b</sub> jako hlavní variantou a 16 + 2 cvičeními a požádal o porovnání
s mým návrhem. Sloučený plán (jeho struktura doplněná o čtení *r* v kontextu,
návaznost na párová data, Cummingův souboj kvadrantů, příklady omezení
rozsahu a sloučených skupin a hranice ze zdrojů) schválil s doporučeními ke
čtyřem otevřeným volbám: korelace jako koeficient reliability a validity
krátce povinně (částečně rozšiřuje R55), populační Kendallův koeficient slovy,
prototyp sešitu před psaním a termín „dvourozměrné normální rozdělení“.
Dohodu eviduje [R71](../docs/rozhodnuti/kapitola-10.md#r71-rozsah-kapitoly-10)–[R73](../docs/rozhodnuti/kapitola-10.md#r73-terminologie-kapitoly-10);
čtení zdrojů, přepočty v R a ověření českých názvů funkcí v Excelu
[záznam z 2026-11-09](../docs/zdroje/HISTORIE.md#priprava-10-20261109).
Při zápisu doplněna hranice mezi diskordantními dvojicemi Kendallova τ
a neshodnými dvojicemi McNemarova testu (R70) a opraven rozcestník zdrojů,
který u regrese chybně odkazoval na Howellovu kap. 10. Neověřeno: proveditelnost
převzorkování v Excelu bez maker, pokrytí percentilového intervalu pro
pořadové koeficienty a články Ruscio (2008) a srovnávací studie ve
*Frontiers in Psychology* (2012). Kapitola zatím napsána není; změněna jen
autorská dokumentace, web se nevykresloval.

<a id="terminy-kapitoly-9-schvaleni"></a>

## Kapitola 9: schválení termínů K09-N1 a K09-N2 (2026-11-09)

Autor schválil oba otevřené návrhy ([doplnění R70](../docs/rozhodnuti/kapitola-09.md#r70-schvaleni-navrhu-2026-11-09)).
Do slovníčku a registru přibylo heslo **hypergeometrické rozdělení** (jen nepovinné
rozšíření o výpočtu Fisherova testu); heslo **referenční skupina** v registru nese od kapitoly 9
druhý související význam a studentské heslo jej už obsahovalo. Text kapitoly se nemění.
Kontrola: vykreslení slovníčku, `check-doc-maps.cjs --require-sources` a `check-html.cjs`.

<a id="vytvoreni-kapitoly-9"></a>

## Kapitola 9: vytvoření výkladu (2026-11-09)

Podle [R68](../docs/rozhodnuti/kapitola-09.md#r68-rozsah-kapitoly-9)–[R70](../docs/rozhodnuti/kapitola-09.md#r70-terminologie-kapitoly-9)
a [upřesnění R69](../docs/rozhodnuti/kapitola-09.md#r69-upresneni-2026-11-09) vznikla kapitola
[Podíly a kategoriální data](kapitola_09.qmd) (jedenáct oddílů, sedm nepovinných rozšíření,
čtrnáct cvičení, pět obrázků), skript `scripts/kapitola_09.R`, sešit `data/kapitola_09.xlsx`
(generátor `scripts/kapitola_09-sešit.mjs`, vstupy v `scripts/sesity-data.mjs`), kontroly
`check-chapter-09.R`, `check-chapter-09-excel.ps1` s generátorem očekávaných hodnot
a doplnění kontroly webu. Přehledy: 31 nových hesel slovníčku, rozšířená hesla
„Šance“ a „Referenční skupina“, 12 řádků značení a 10 funkcí Excelu; registr
[SLOVNIK](../docs/SLOVNIK.md#kapitola-09), [karta kapitoly](../docs/kapitoly/09-podily-kategorialni-data.md#mapa-kapitola-09),
[DATA](../docs/DATA.md#kapitola-9), osnova, plán pokračování, provozní návod a záznam
[použití podkladů](../docs/zdroje/HISTORIE.md#pouziti-kapitola-09). Build skripty sešitů
a jejich kontroly nově připouštějí kapitolu 9.

**Kontroly provedené 2026-11-09:** `check-chapter-09.R` prošel (Wilson proti
`prop.test(..., correct = FALSE)` u dvanácti podílů, Pearsonův test proti
`chisq.test(..., correct = FALSE)`, rezidua proti `$stdres` a `$residuals`, Fisher,
přesný McNemar, Newcombe nezávislým vzorcem, okrajový případ bez neshodných dvojic,
všechna citovaná čísla). `build-workbooks.ps1 -Chapter 9 -Verify` prošel: sešit
v Excelu 16.0 má 23 listů a 226 vzorců; kontrola kapitoly porovnala 170 uložených
výsledků, 12 českých vzorců zadaných jako student, 3 chybové případy, 315 výsledků
po dosazení dat cvičení a 9 zápisů vzorců; kontrola všech devíti sešitů bez chyb.
`check-workbooks.py` prošel. Celá kniha vykreslena bez varování; `check-html.cjs`
prošel (odkazy, kotvy, řešení, přehledové tabulky, mobilní šířka 390 px), snímky
oddílů a obrázků kapitoly 9 v `tmp/verification/` prohlédnuty, čtyři listy sešitu
prohlédnuty v PDF exportu. České názvy CHISQ.*, HYPGEOM.DIST, SUMIF, SMALL, ŘÁDKY
a SLOUPCE ověřeny v českém Excelu. Didaktická revize: vlastní čtení vůči cílům
a vodítkům čitelnosti a strojová kontrola délky vět; samostatné čtení v roli studenta
ani autorská odborná revize zatím neproběhly.

**Nálezy a otevřené body:** Howell (tab. 6.9) uvádí 28,8 % přijatých žen, z četností
vychází 27,1 % (v nepovinném rozšíření zmíněno). Excel u HYPGEOM.DIST s nemožnou
kombinací argumentů nevrací chybu. K rozhodnutí autora zůstávají návrhy K09-N1
(hypergeometrické rozdělení v nepovinném rozšíření) a K09-N2 (referenční skupina ve
druhém významu). Pododdíl o poměru rizik a šancí zavádí šest pojmů najednou kvůli
předepsaným třem pododdílům. **Neověřeno a nezahrnuto:** původní studie citované podle
učebnic; dokumentace R k použitým funkcím; export AI tutora (kapitola 9 v balíčku
není, katalog dál uvádí osm kapitol), pracovní PDF, prezentace a interaktivní
vizualizace ke kapitole 9; nasazení webu.

<a id="dohoda-kapitola-09"></a>

## Kapitola 9: dohoda o obsahu (2026-11-09)

Autor navrhl, aby kapitola 9 vykládala testy pro kategoriální data, a požádal,
aby se návrh neopíral jen o Howella. Podkladem byly Howell kap. 6, Cumming
kap. 13, OpenIntro kap. 6, Field kap. 16, Wilcox §15.1–15.4, Navarro kap. 12,
přednášky P12 a P13 a úlohy C09. Ve výběru voleb autor zvolil odhad i testy,
Wilsonův interval s Waldovým jako mezikrokem a povinné míry rozdíl podílů,
poměr rizik, poměr šancí, φ a Cramérovo V. První plán vrátil s dvanácti
písemnými připomínkami: zachovat pořadí jeden podíl → dva podíly → dobrá
shoda → tabulky; Wald jen krátce a bez dojmu rovnocenných metod; Newcombův
interval pro rozdíl podílů; zpřesnit vztah intervalu a testu (Wilson jako
obrácený skórový test, ne binomický test); Fisherův test povinně v oddílu
o předpokladech; hierarchicky uspořádat pravidla očekávaných četností;
u reziduí při označování významných buněk řešit vícenásobné testování
(nepovinně Holm); míry účinku ve třech pododdílech na jednom příkladu;
ošetřit znaménko φ; přesnější zdůvodnění McNemarova testu a jmenovatel
rozdílu podílů; upozornění k průměru kódů a k očekávanému profilu z jiného
výběru; méně hlavních příkladů. K ověřování požadoval kontrolu proti
`prop.test` a `chisq.test` s `correct = FALSE`, přesný McNemarův postup
binomickým testem a okrajové případy; ke značení nepoužít index *i* pro
buňky, rozvinout f a doplnit e a ustálit „kategoriální“. Druhou verzi
schválil. Dohodu eviduje
[R68](../docs/rozhodnuti/kapitola-09.md#r68-rozsah-kapitoly-9)–[R70](../docs/rozhodnuti/kapitola-09.md#r70-terminologie-kapitoly-9);
čtení zdrojů a přepočty [záznam z 2026-11-09](../docs/zdroje/HISTORIE.md#priprava-09-20261109).
Při zápisu se upřesnil jeden nález z plánu: Wilcoxova poznámka k `chisq.test`
(s. 614) je pro výchozí nastavení oprávněná (Yatesova korekce), nejde o chybu.
Otevřené zůstávají indexy buněk tabulky a konkrétní příklad dobré shody.
Kapitola zatím napsána není; změněna jen autorská dokumentace, web se nevykresloval.

<a id="audio-kapitoly-7-20261109"></a>

## 2026-11-09 — Nahrávka k prezentaci kapitoly 7 hlasem Adam

Na následnou výslovnou žádost autora převeden nezměněný scénář snímků 1–32
přes Creative Claw (`speech/heygen-voice-1`, veřejný český hlas Adam,
jazyk cs, rychlost 1). Předem načten aktuální `get_model_params`, použity
pouze podporované parametry stock hlasu. Osm částí kvůli limitu 5 000 znaků
spojeno ve dvou krocích přes WAV, bez prolínání a normalizace.
Místní MP3 `presentations/kapitola_07_interval_t_test_a_ekvivalence_Adam.mp3`
má 38:43 a 32 značek snímků podle časového zarovnání poskytovatele.
Gitem je ignorován a automaticky se nepublikuje.

[Podklady a manifest](../presentations/kapitola_07_interval_t_test_a_ekvivalence_scenar_podklady.md)
zachycují přesné nastavení, identitu výsledku a kontroly. Ověřeny shodné
texty, úplné pořadí, dekódování částí i celku, součet délek, počet kapitol,
hlasitost, pauzy a shoda zvukových úseků každé části s celkem.
Skutečný poslech ani nezávislý přepis neproběhly; technická kontrola
nepotvrzuje výslovnost. Scénář, PPTX ani studentský výklad se neměnily.

<a id="scenar-kapitoly-7-20261109"></a>

## 2026-11-09 — Scénář k prezentaci kapitoly 7

Na výslovnou žádost autora připraven
[scénář pro syntézu řeči](../presentations/kapitola_07_interval_t_test_a_ekvivalence_scenar.txt)
ke snímkům 1–32 aktuálního místního PPTX. Zahrnuje výklad a řešené příklady,
vynechává samostatné procvičování, diskusní otázky a organizační pokyny.
Text má 4 774 slov; odhad při 105–125 slovech za minutu je 38–46 minut bez dalších pauz.
Scénář obsahuje mluvený zápis čísel, vzorců a funkcí a požadované výslovnostní přepisy.
[Průvodní dokument](../presentations/kapitola_07_interval_t_test_a_ekvivalence_scenar_podklady.md)
a manifest zachycují podklady, jejich SHA-256, mapování snímků a slovník výslovnosti.

Načteny texty, poznámky, tabulky a vzorce z PPTX; vizuálně prohlédnuto deset
vložených grafů. Číselné příklady, kvantily, intervaly, p-hodnoty, teoretické
pokrytí a devět studií nezávisle přepočteny v základním R 4.5.1.
Po interní didaktické revizi ověřeno pořadí všech úseků, mluvený zápis a přepisy.
Kontrola `node scripts/check-doc-maps.cjs` prošla bez chyb, stejně jako `git diff --check`.
Simulace nebyly opakovány, původní studie ani Howell nově ověřovány,
desktopový Excel ani kontrola celé sazby v PowerPointu nebyly spuštěny.
PPTX již obsahovalo necommitované úpravy autora a při této práci se nezměnilo.
Kapitola ani studentský web se nemění. Placená syntéza ani poslech neproběhly.

<a id="prezentace-kapitoly-7-20261109"></a>

## 2026-11-09 — Prezentace ke kapitole 7

Vytvořeny soubory v `presentations/`: `kapitola_07_interval_t_test_a_ekvivalence.pptx`
(40 slidů), `kapitola_07_poznamky.docx`,
`kapitola_07_interval_t_test_a_ekvivalence_cviceni.xlsx` a
`kapitola_07_interval_t_test_a_ekvivalence_cviceni_grafy.pdf`. Rozsah dohodnut s autorem
2026-11-09: jedna výuka za celou kapitolu (45 minut výkladu, 45 minut procvičování),
všechna čtyři nepovinná rozšíření vynechána; výstupy PPTX, DOCX, sešit a pomocné
grafy k excelovým úlohám, bez PDF prezentace. Výklad má 24 obsahových slidů v šesti
oddílech podle [R50](../docs/rozhodnuti/postupy-a-dokumentace.md#r50-struktura-prezentaci)
(od rozhodnutí testu k odhadu; šířka intervalu a *t*-rozdělení; jednovýběrový *t*-test;
interval a *p*-hodnota; test ekvivalence; čtyři kombinace a sdělení výsledků).
Bodový odhad a obrácení úvahy jsou na jednom slidu, předpoklady intervalu a jeho meze
(zkreslení, chyba měření) jsou shrnuty u šířky intervalu, odolnost *t*-postupů jen slovně
podle povinné části; *p*-hodnoty TOST se objevují jen v ukázce zprávy.

Šest úloh bez Excelu (řešení jen v poznámkách): vlastní úlohy na interval při známé σ,
výroky o intervalu, rozhodnutí z 95% a 90% intervalů, zdůvodnění hranic ekvivalence
a čtyři kombinace; úloha 3 adaptuje Howella (7.6, 7.7 a 7.9). Doprovodný sešit podle
[R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-excelova-cviceni-prezentaci)
má čtyři listy: U1_Kruger_Dunning (7.6–7.7, 11 hodnot), U2_SAT_bez_textu (7.13 ze
souhrnů), U3_lez_skala (7.14–7.15 ze souhrnů) a U4_tablet_ekvivalence (vlastní modelová
data 60 dětí, simulace z normálního modelu se středem 100,8 a SD 12,5, zaokrouhleno,
seed 6; test rozdílu a test ekvivalence pro všech 60 a prvních 15 dětí). Řešení po
krocích, 13 kontrol funkcemi (včetně T.DIST.RT, T.DIST.2T a CONFIDENCE.T) a 20 nativních
rovnic. U U2 je *p*-hodnota v řádu 10⁻¹⁸, a proto ji krok počítá ze souměrnosti jako
T.DIST(−*t*; *v*; PRAVDA); 1 − T.DIST by se zaokrouhlilo na 0. Pomocné grafy (8 stran,
16 : 9) vytváří `scripts/kapitola_07-prezentace-cviceni-grafy.R` ze vstupů sešitu
(balíček readxl), vzhledem navazuje na grafy kapitoly 6. Rozsah čtení Howella eviduje
[karta U01](../docs/zdroje/U01-howell.md#u01). Kapitola 7, slovník, osnova ani
`data/kapitola_07.xlsx` se neměnily; věcný rozpor mezi kapitolou a prezentací nebyl
zjištěn. Všech 10 obrázků jsou obrázky kapitoly 7 (vlastní tvorba), před převodem znovu
vykreslené `scripts/kapitola_07.R`; obrázek opakovaných intervalů je rozdělen na dva slidy.

Postup: generátor v `tmp/chapter07-presentation/` navazuje na generátor kapitoly 6
(stejná předloha a vzhled). Nově zpracuje kurzívu uvnitř tučného textu (tučný úsek se
parsuje rekurzivně), má vzorce intervalů se *z* a *t* a statistiky *t* a před znakem %
používá nezlomitelnou mezeru. Sdílené skripty v `scripts/` se neměnily.

**Ověření:** všech 40 slidů vykresleno v PowerPointu a prohlédnuto (po rozšíření
textových sloupců u čtyř slidů s obrázkem, opravě zalamování „95 %“ a „94 ze 100“
a vnořené kurzívy v poznámkách); každý slide má poznámky, u výkladových slidů s otázkou
k zamyšlení; jazyk všech 235 textových polí a 40 poznámek je čeština (objektový model
PowerPointu); v textu PPTX ani DOCX nezůstala značka `*`; všech 23 různých oddílů, na které
poznámky odkazují, v kapitole existuje. 64 čísel ze slidů, poznámek a sešitu přepočítáno nezávisle v R
(`check.R` v tmp), včetně shody dat U4 se simulací. Sešit přepočítán v českém Excelu 16:
0 chybových buněk, všech 13 kontrol „Shoda s kroky“ = ano, 20 rovnic, prázdné pracovní
buňky; listy prohlédnuty z exportu do PDF. DOCX otevřen ve Wordu: 40 nadpisů
„Slide N: titulek“, 19 stran, čeština. Data úlohy 7.6 a zadání 7.13–7.15 ověřena
v obrazu s. 222–223. Všech 8 stran grafů prohlédnuto (pdftoppm) po opravě dolního
indexu H₀ a překryvů popisků.

**Omezení:** výklad trvá podle součtu časů 45 minut, skutečná délka nebyla vyzkoušena.
Popisky uvnitř převzatých grafů (zejména devět studií a opakované intervaly) jsou při
projekci drobné; hlavní hodnoty opakuje text slidu. Hodnoty úlohy 7.6 jsou podle Howella
sestaveny tak, aby měly téměř stejný průměr a směrodatnou odchylku jako studie Krugera
a Dunninga, nejde o původní data. Starší verze Excelu a PowerPointu, Excel pro Mac ani
webový Excel nebyly zkoušeny. Didaktická revize byla interní, bez ověření na studentech.
Studentský web se nemění, render knihy nebyl potřeba.

## 2026-11-09 — Oprava CI: runner ubuntu-24.04 kvůli Playwrightu

Běhy workflow „Ověřit a publikovat učebnici“ pro PR #175 a #176 i po jejich
sloučení selhaly v kroku `npx playwright install --with-deps chromium`:
`ubuntu-latest` je nově Ubuntu 26.04 a Playwright 1.55 jej nepodporuje.
Render knihy a číselné kontroly kapitol před tímto krokem prošly. Job
`build` je proto připnut na `ubuntu-24.04`; job `deploy` Playwright
nepotřebuje a zůstává na `ubuntu-latest`. Web se od sloučení PR #174
nepublikoval; publikuje se znovu po sloučení této opravy.

## 2026-11-09 — Kurzivní t/z v prezentacích kapitol 4–6 (R66)

Podle [R66](../docs/rozhodnuti/spolecne-konvence.md#r66-kurziva-a-et-al) je
písmeno ve složeninách *z*-skór, *z*-test a *t*-test kurzivou i v prezentacích:
kapitola 4 (41 výskytů ve snímcích a poznámkách, 35 v DOCX poznámek, 41 buněk
sešitu), kapitola 5 (2 + 2 + 2) a kapitola 6 (9 + 8 + 7). Na začátku věty
a v nadpisech je malé písmeno, T-skór zůstává stojatě. Úpravy proběhly přímo
v souborech přes PowerPoint a Excel (kurziva jen u písmene, ostatní formát
beze změny); DOCX poznámek byly upraveny v XML, protože Word se při
automatizaci opakovaně zasekl. Ve slidech 6, 20, 21 a 22 kapitoly 4 jsou
obrázky grafů nahrazeny aktuálními rendery (`scripts/kapitola_04.R`)
se stejnou polohou, šířkou a alternativním textem. PDF kapitol 4–6 jsou
znovu exportována z PowerPointu.

Kontroly: počty změn odpovídají předchozímu vyhledání ve všech souborech;
XML upravených DOCX je platné a obsahuje 45 kurzivních písmen; změněné
snímky (kap. 4: 2, 3, 5, 6, 12, 20, 21, 22, 41; kap. 6: 30) prohlédnuty
v exportu PowerPointu. Neověřeno: otevření upravených DOCX ve Wordu
(automatizace Wordu se zasekla již při práci s původními soubory) a vizuální
prohlídka změněných buněk sešitů. Scénáře pro syntézu řeči se nemění,
kurziva v nich nemá význam.

## 2026-11-09 — Revize kapitoly 7 podle autorových připomínek (R66, R67)

<a id="revize-07-20261109"></a>

Zkontrolovány a začleněny autorovy redakční úpravy kapitoly 7. Opraveny
jazykové chyby v nich („by mít“, „o tematiku pozornost“, chybějící sloveso
u věty o *p*-hodnotě, „nezohleňuje“ s chybnou příčinnou vazbou, dvojí
„proto“ u TOST); „plauzibilní rozmezí“ nahrazeno rozmezím hodnot slučitelných
s daty, „mnohačetné opakování“ opakovaným použitím. „Nerozhodný“ výsledek
sjednocen na „neprůkazný“ i v tabulce, řešeních 10d a 11 a v kartě.

Obsahové změny podle připomínek:

- Výběrová *s* průběžného příkladu je 11 (dosud 10, shodně s modelovou σ):
  interval (41,46; 50,54), *t* ≈ −1,818, *p*-hodnota 0,041 jednostranně
  a 0,082 oboustranně, 90% interval (42,24; 49,76); rozdíl vůči z-intervalu
  rozložen na vliv kvantilu a vliv *s*. Studie A ve čtyřech kombinacích
  (jiná studie, *s* = 10) se nemění; kapitola 8 má vlastní data.
- Volba hladiny spolehlivosti a obecný kvantil $z_{1-\mathrm{α}/2}$
  (jednostranná mez $z_{1-\mathrm{α}}$) v oddílu o výpočtu intervalu.
- Opraveno tvrzení o odolnosti (souměrné těžké chvosty pokrytí zvyšují)
  a přidáno nepovinné rozšíření „kdy je *t*-test odolný a kdy ne“ podle
  Wilcoxe (2017, §4.6 a 5.5) s tabulkou z vlastní simulace
  (`scripts/kapitola_07-odolnost.R`, 7 tvarů populace × *n* 10, 25, 50, 100).
- *t*-test: směrová hypotéza stanovená předem, vysvětlená hranice
  μ = μ₀, věcná interpretace s 90% intervalem. PDI: Bayleyové škály,
  „Nurcombe et al.“, oboustranný test zdůvodněn podle Howella (intervence
  u matek poloviny dětí, jiná normativní populace); autorovo tvrzení
  o motorických podnětech nemělo doložený zdroj a převzato nebylo.
- Nový pododdíl „Tři cesty k témuž rozhodnutí“ s obrázkem zrcadla intervalu
  a tabulkou podle snímku 20 prezentace průměrů; nový obrázek jednostranných
  intervalů a výklad, proč se místo jednostranné meze uvádí 90% centrální
  interval. Autorův návrh popsat bodový odhad jako „nejpravděpodobnější
  hodnotu“ upraven: hodnoty u středu jsou s daty nejlépe slučitelné, nejde
  o pravděpodobnost pro μ.
- Dopad posunu o 3 body na podíl doporučených doplněn do textu před
  obrázkem; čtyři kombinace rozšířeny na devět studií (F přes všechna pásma,
  G–I zrcadla B, D, E); osa grafů popsána jako skór, ne populační průměr.
- Rozšíření o noninferioritě přepsáno na trénink pozornosti a relaxační
  program se superioritou, nonsuperioritou, noninferioritou a inferioritou;
  úloha 14 převedena na kratší trénink vůči referenční hodnotě 55.
- Obecné pokyny v kapitole 7: obměněno „Oddíl ukazuje…“, „variabilita“
  místo „rozptýlenost“, reliabilita u přesnosti měření, kurzivní *s*,
  „striktně uvnitř“, „kvantil vzdálenější od nuly“, citace „et al.“.

Celoknižně podle R66: kurzivní *t*/*z* ve složeninách v kapitolách 4–8,
přehledech, dvou vizualizacích, autorském slovníku a grafech kapitol 4, 6 a 7
(skript nahrazoval jen prózu mimo matematiku, kód, odkazy, ID a alternativní
texty; T-skór stojatě). V kapitole 8 „Aronson et al.“. Prezentace a balíčky
AI tutora tímto nejsou upraveny.

Upraveny také sešit kapitoly 7 (`Pozornost`, `Interval_t`, `T_test`,
`Studie_ekv`, list `U14_noninferiorita`), generátory, nezávislé kontroly
(`check-chapter-07.R` nově porovnává i tabulku odolnosti se simulací,
`check-chapter-07-excel-expected.py`, `check-html.cjs`), slovníček, značení,
registr, karta kapitoly, DATA.md, OSNOVA.md, PROVOZ.md, karty U15, U16, P08
a historie ověřování zdrojů.

## 2026-11-07 — Vizualizace posunu a změny jednotek (upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-07-posun)
přibyla šestá stránka části „Interaktivní vizualizace“,
[Co s rozdělením udělá posun a změna jednotek](viz_posun_a_jednotky.qmd),
v menu na prvním místě (navazuje na kapitolu 3). Tři soubory kapitoly 3
(pět časů, 33 dob spánku, 36 počtů vybavených slov), lineární transformace
s posunem *a* a násobitelem *b*, druhá mocnina a druhá odmocnina, šest
předvoleb kapitoly (výchozí převod pěti časů na sekundy). Části: dva tečkové
grafy se spojnicemi, barvou podle původní hodnoty, průměrem, mediánem,
úsečkami *m* ± *s* a kvartilů a přepínačem společné a vlastní osy; živý
slovní popis; tabulka ukazatelů (původní, převedená data, předpověď pravidlem
nebo převod původního ukazatele); vzorce českého Excelu pro pomocný sloupec
na listu `Zaklad_data` (B2:B6) nebo `Data` (F2:F37) a pro deset ukazatelů.
Kapitola 3 odkazuje blokem „Vyzkoušejte si: posun a změna jednotek“ na konci
oddílu Co od ukazatelů polohy a variability očekáváme; jiný text kapitoly se
nemění. Upraveny `_quarto.yml`, styly (`.viz-pj-…`), `check-html.cjs`
(pořadí v menu, nová kontrola), karta kapitoly 3, OSNOVA.md, plán
pokračování, registr, doklad R65 a PROVOZ.md. Nové pojmy, značení ani funkce
Excelu nepřibyly (KDYŽ, ODMOCNINA, SKEW a KURT jsou v přehledu Excelu);
slovníček a přehledy beze změny.

Redakční volby při realizaci: ukazatele zaokrouhlené na dvě desetinná místa,
čísla menší než 1 na tři platné číslice; v dosazení do pravidla původní
ukazatele o dvě místa přesněji, aby např. 60 · 2,3452 ≈ 140,71 odpovídalo
přesnému výsledku. Živá tabulka nemá číslo „Tabulka X“ ze stejného důvodu
jako u vizualizace Bayesovy věty; na úzkém displeji se posouvá jen uvnitř
svého rámečku. Vlastní osa dolního grafu je u lineárního převodu s *b* ≠ 0
obrazem horní osy, aby oba grafy vypadaly stejně (při *b* < 0 zrcadlově);
u nelineárního převodu a při *b* = 0 má dolní graf vlastní zaokrouhlený
rozsah. U spánku pomocný sloupec používá
`KDYŽ(B2="";"";…)`, aby chybějící údaje nepřešly v hodnotu.

Nezávislá kontrola (skripty ve `scratchpad`, mimo repozitář):

- R (`mean`, `median`, `quantile(type = 7)`, `sd`, `var`, SKEW/KURT podle
  vzorců Excelu): ukazatele tří souborů a převodů (*b* = 60, *a* = 120
  s *b* = 60, *a* = 12 s *b* = −1, *a* = 3 s *b* = −2,5, druhá mocnina časů
  a odmocnina spánku) se shodují se stránkou na 10⁻⁹; hodnoty jsou zapsány
  v kontrole webu;
- 90 vzorců z devíti nastavení stránky (převody, předvolby, *b* = 0,
  odmocnina spánku, druhá mocnina časů) bylo zadáno přes `FormulaLocal`
  do skryté samostatné instance českého Excelu na kopii sešitu kapitoly 3
  v `tmp/` bez uložení; výsledky se shodují se stránkou na 10⁻⁹, při *b* = 0
  vracejí SKEW a KURT chybu #DIV/0!, jak stránka uvádí; statistické funkce
  přeskočily prázdný text z KDYŽ. Data listu `Data` tím odpovídají stránce.

Celá kniha vykreslena; `check-html.cjs` (19 stránek, nová kontrola podle
PROVOZ.md) a `check-doc-maps.cjs` prošly. Prohlédnuty snímky: výchozí stav
na společné ose, obrácení skórování slov na vlastní ose, odmocnina slov
a šířka 375 px; podle nich upraveno skloňování jednotky v popisu („do 12 slov“)
a zarovnání záhlaví tabulky. Didaktická revize stránky proběhla interně
čtením očima studenta po kapitole 3 (bez nových pojmů, odkazy na výklad,
úkoly pokrývají posun, změnu jednotek, obrácení a nelineární převod);
není ověřením na studentech. Neověřeno: ovládání čtečkou obrazovky.

Oprava po neúspěšném CI (PR #174): před odesláním nebyla lokálně spuštěna
`scripts/check-table-layout.cjs`. Ta v CI zjistila, že tabulka ukazatelů
přetéká při šířce okna 1024 px o 15 px (lokálně o 6 px, při obrácení
skórování slov o 32 px). Příčinou byla minimální šířka sloupce pravidla
14rem. Snížena na 11rem, kterou stránka dosud používala jen na mobilu, a
zvláštní pravidlo pro úzké displeje odstraněno. Lokálně ověřeno sedm
nastavení (výchozí, předvolby, *b* = 0, záporné a dlouhé desetinné *a*, *b*,
nelineární převody) při 1024, 1100 a 1280 px bez přetečení. Nejmenší šířka
tabulky je 496 px, při obrácení skórování 522 px, k dispozici je 541 px.
Pravidla se v úzkém sloupci zalamují do dvou řádků; snímky prohlédnuty.
`check-table-layout.cjs` (přísný režim) i `check-html.cjs` znovu prošly.

## 2026-11-06 — Vizualizace Bayesovy věty (upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-06-bayes)
přibyla pátá stránka části „Interaktivní vizualizace“,
[Co znamená pozitivní výsledek testu](viz_bayesova_veta.qmd), v menu mezi
plochami pod normální křivkou a binomickým rozdělením. Vstupy prevalence,
senzitivita a specificita (0–1), výchozí příklad poradny, volba 1 000 nebo
10 000 osob a tlačítka obou příkladů kapitoly 5. Části: mřížka osob ve
čtyřech uspořádáních, strom a kontingenční tabulka se čtením po řádcích
a sloupcích, Bayesova věta s dosazením a vzorci Excelu, křivka prediktivní
hodnoty podle prevalence a druhé vyšetření. Kapitola 5 odkazuje blokem
„Vyzkoušejte si: Bayesova věta“ na konci oddílu Obrácení podmínky a Bayesova
věta (za rozšířením o šancích); plán uváděl místo za oddílem o dvou
prevalencích, ale stránka pokrývá i apriorní a aposteriorní pravděpodobnost
a druhé vyšetření. Jiný text kapitoly se nemění. Upraveny `_quarto.yml`,
styly (`.viz-bay-…`, vzhled vypnutého pole), `check-html.cjs` (pořadí v menu,
nová kontrola, výjimka živé tabulky z číslování), karta kapitoly 5, OSNOVA.md,
plán pokračování, registr, doklad R65 a PROVOZ.md. Nové pojmy, značení
ani funkce Excelu nepřibyly; slovníček a přehledy beze změny.

Živá kontingenční tabulka ve vizualizaci nemá číslo „Tabulka X“: mění se
se vstupy a Quarto ji nemůže číslovat. Má panelový titulek, `aria-label`
a linky podle APA. Jde o redakční řešení při realizaci schváleného doplňku
„Strom a tabulka 2×2“, nikoli o samostatnou dohodu o výjimce z pravidla
[sazby tabulek](../AGENTS.md#sazba-tabulek).

Nezávislá kontrola (skripty ve `scratchpad`, mimo repozitář):

- úplná pravděpodobnost, obě prediktivní hodnoty a pravděpodobnost po
  negativním výsledku pro sedm nastavení a šest dvoukrokových aktualizací
  odpovídají výpočtu v R na 10⁻¹²; přirozené četnosti se zaokrouhlením
  na celé osoby odpovídají R s pravidlem zaokrouhlení JavaScriptu
  (`floor(x + 0,5)`), například 123/877, 108, 185 pro prevalenci 0,123;
- sedm vzorců ve tvaru, který stránka nabízí (tři pro poradnu, plošné
  šetření, tři pro druhé vyšetření s odkazy na B17 a B20), bylo zadáno přes
  `FormulaLocal` do skryté samostatné instance českého Excelu bez uložení;
  výsledky se shodují s R na 10⁻¹².

Celá kniha vykreslena; `check-html.cjs` (18 stránek, nová kontrola podle
PROVOZ.md) a `check-doc-maps.cjs` prošly. Prohlédnuty snímky desktopu
(výchozí stav, uspořádání podle výsledku a jen pozitivní, plošné šetření
s výřezem grafu) a šířky 375 px; podle nich opraveny popisky větví stromu
(překrývaly čáry), popisky bodů v grafu (posun nelze v Plotu určit funkcí)
a odsazení tabulky na mobilu. Dlouhé věty textu stránky zkontrolovány
výpočtem (žádná nad 35 slov). Didaktická revize stránky proběhla jen čtením
při tvorbě (bez samostatného agenta v roli studenta).

Dodatek téhož dne podle autora: správně negativní výsledky mají místo šedé
světle oranžovou barvu (`#F2C9AB`), takže odstín důsledně kóduje stav
(modrá porucha, oranžová bez poruchy) a sytost výsledek (sytá pozitivní,
světlá negativní); popis barev v oddílu „Model a ovládání“ a „Čeho si
všimnout“ upraven. Stránka znovu vykreslena, `check-html.cjs` prošel,
mřížka při 1 000 i 10 000 osobách a strom prohlédnuty.

Neověřeno: čtečka obrazovky (ověřeny jen nativní prvky, popisky a
`aria-live`), provoz na GitHub Pages a bez CDN, porozumění studentů.
Ruční PDF ani export tutora nebyly spuštěny; oba přepisují odkazy
`viz_….qmd` obecným pravidlem. Lokální kontrola běžela s nainstalovaným
Chromem (`CHROME_PATH`), protože stažený Chromium Playwrightu Windows
nespustil.

## 2026-11-06 — Vizualizace binomického rozdělení (upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-06-binom)
přibyla čtvrtá stránka části „Interaktivní vizualizace“,
[Pravděpodobnost počtu úspěchů](viz_binomicke_rozdeleni.qmd), v menu za
plochami pod normální křivkou. Vstupy *n* (1–1000) a π (0–1), výchozí
*n* = 20 a π = 0,25. Otázka s jednou hranicí *k* a třemi nezávislými
zaškrtávacími poli (méně než, právě, více než *k*) nebo rozpětí od *k*₁
do *k*₂ včetně mezí. Sloupcový graf s úsečkou μ ± σ a dvěma řadami popisků
osy (*k* a *p* = *k*/*n*), od *n* > 60 výřez kolem μ s pravděpodobností
zbytku; pod ním schodovitá kumulativní pravděpodobnost se sloupcem
rozděleným na části méně než/právě/více než *k*. Výsledky: μ a σ počtu
i podílu, podmínka aproximace, rozepsaný součet, opačný jev, vzorec
`BINOM.DIST`/`BINOM.DIST.RANGE`. Přepínač normální aproximace přidá křivku,
plochu a výpočty s hranicí uprostřed sloupce a na okraji sloupců (± 0,5)
s rozdílem od přesné hodnoty a vzorci `NORM.DIST`. Kapitola 5 odkazuje
blokem „Vyzkoušejte si“ na konci oddílu Právě, nejvýše, alespoň; jiný text
kapitoly se nemění. Upraveny `_quarto.yml`, styly `.viz` (skrytá skupina
voleb, sdílená legenda `.viz-legend`), `check-html.cjs` (pořadí v menu
a nová kontrola podle PROVOZ.md), karta kapitoly 5, OSNOVA.md, plán
pokračování, registr, doklad R65 a PROVOZ.md. Nové pojmy, značení ani
funkce Excelu nepřibyly; slovníček a přehledy beze změny.

Nezávislá kontrola (skripty ve `scratchpad`, mimo repozitář):

- `dbinom`/`pbinom` stránky (logaritmy faktoriálů s kompenzovaným součtem)
  pro 15 případů s *n* 5–1000 se shodují s R relativně do 10⁻¹⁰;
- všech osm kombinací zaškrtávacích polí, „alespoň“ a „více než 10“,
  rozpětí 8–12 a obě aproximace (příklad s 200 pokusy 0,0152 a 0,0182 proti
  přesné 0,0173; „právě 5“ 0,2037; rozpětí 0,6289 a 0,7364 proti 0,7368)
  odpovídají `dbinom`, `pbinom` a `pnorm` z R;
- 14 vzorců ve tvaru, který stránka nabízí (`BINOM.DIST` včetně argumentu
  `k-1`, `BINOM.DIST.RANGE`, `NORM.DIST` s `ODMOCNINA`), bylo zadáno přes
  `FormulaLocal` do skryté samostatné instance českého Excelu bez uložení;
  výsledky se shodují s R na 13 a více platných míst.

Celá kniha vykreslena bez varování; `check-html.cjs` a `check-doc-maps.cjs`
prošly. Prohlédnuty snímky desktopu (výchozí stav, 200 pokusů s aproximací,
rozpětí 8–12 s aproximací) a šířky 375 px; podle nich opraveny barvy sloupců
(zastíněné barevné konstanty) a u „právě *k*“ místo vzorce `=0` věta, že
vzorec není potřeba. Didaktická revize stránky proběhla jen čtením při tvorbě
(bez samostatného agenta v roli studenta).

Neověřeno: čtečka obrazovky (ověřeny jen nativní prvky, popisky a `aria-live`),
provoz na GitHub Pages a bez CDN, porozumění studentů. Ruční PDF ani export
tutora nebyly spuštěny; oba přepisují odkazy `viz_….qmd` obecným pravidlem.

## 2026-11-06 — Drobné úpravy tří vizualizací podle autora

Podle připomínek autora upraveno rozvržení a popisky; výpočty, modely
a text výkladu se nemění:

- [plochy pod normální křivkou](viz_normalni_rozdeleni.qmd): panel hustoty
  je vyšší (320 px, na mobilu 280 px), panel distribuční funkce také
  (290 px, na mobilu 260 px);
- [statistická síla](viz_statisticka_sila.qmd): část „Křivka síly“ stojí
  před částí „Výpočet v obou situacích“, popis částí v oddílu „Model
  a ovládání“ má stejné pořadí;
- [výběrové rozdělení průměru](viz_vyberove_rozdeleni_prumeru.qmd): osy x
  mají popisky „Doby řidičů v populaci (s)“, „Doby řidičů v posledním
  výběru (s)“ a „Průměry výběrů (s)“, protože každý graf zobrazuje více
  hodnot; stejné popisky dostaly pro jednotnost i osy Q–Q grafů.

Ověřeno: `quarto render` tří dotčených stránek a `check-html.cjs` bez chyb
(včetně mobilní šířky 390 px bez přetékání). V prohlížeči prohlédnuty
výšky panelů a popisky u normální křivky, pořadí částí u síly a nové
popisky os výběrového rozdělení průměru na desktopu. Celá kniha znovu
vykreslena nebyla, protože se nemění společná konfigurace ani navigace.

## 2026-11-06 — Rozšíření vizualizace výběrového rozdělení průměru (upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-06-vrp)
upravena [vizualizace výběrového rozdělení průměru](viz_vyberove_rozdeleni_prumeru.qmd):

- *n* je 1–1000 a počet nových výběrů 1–10 000; velké požadavky se losují
  po dávkách (400 000 hodnot) s průběhem a zablokovaným ovládáním;
- ukládá se jen poslední výběr, z ostatních se počítá rovnou průměr;
- strop 100 000 opakování zůstává;
- přibyl histogram standardizovaných průměrů (osa −4 až 5, svislé čáry u ±2)
  s normovaným normálním rozdělením a podíly nad 2 a pod −2 v přehledu;
  normální model v obou histogramech ovládá jedno zaškrtávací políčko;
- přibyla extrémně zešikmená populace (posunuté lognormální, šikmost 8,
  nejkratší doba 25,08 s);
- při velkém *n* jsou body menší, Q–Q graf výběru je ztenčen na 500 bodů
  a histogram v sekundách má jemnější sloupce (od 0,05 s);
- text stránky popisuje pátou populaci, nové meze, standardizovaný histogram,
  upravené úkoly 4 a 5 a čtení tvaru po standardizaci.

Ověřeno:

- `quarto render` celé knihy a `check-html.cjs` bez chyb (rozšířený test
  podle PROVOZ.md).
- Proti R (`uniroot`, `dlnorm`, `plnorm`, mimo repozitář):
  - parametry extrémní populace se shodují na 12 platných míst a hustota
    v bodech 30, 40 a 70 s na 10 desetinných míst;
  - podíly 400 000 simulovaných hodnot pod 27, 30, 35, 50 a 100 s se od
    `plnorm` liší nejvýše o 0,001;
  - průměr simulace je 35,00 s a směrodatná odchylka 14,81 s (těžký chvost).
- Podíly standardizovaných průměrů nad 2 a pod −2 při *n* = 1000
  u extrémní populace: na stránce 2,8 % a 1,6 %, v nezávislé simulaci R
  2,8 % a 1,8 % (10 000 výběrů). To podporuje větu, že nerovnováhu
  chvostů lze poznat ještě při *n* = 1000. Při *n* = 30 a 100 u výrazně
  zešikmené populace dala simulace R 3,9/0,5 % a 3,2/1,2 %.
- Losování 10 000 výběrů po 1000 trvalo v bezhlavém Chromiu 0,7 s.
- Prohlédnuty snímky všech pěti populací při *n* = 30, extrémní při
  *n* = 1000 a mobil 375 px; stránka nepřetéká.

Neověřeno: rychlost na pomalých zařízeních a mobilech, čtečka obrazovky,
provoz na GitHub Pages a porozumění studentů.

## 2026-11-06 — Vizualizace statistické síly (upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-06-sila)
přibyla třetí stránka části „Interaktivní vizualizace“,
[Na čem závisí statistická síla](viz_statisticka_sila.qmd), v menu za
vizualizací výběrového rozdělení průměru. Společná σ (výchozí 15 s) a dvě
situace A a B (skutečný rozdíl, *n*, α, směr testu); dva hlavní grafy se
společnými osami podle předlohy `presentations/kapitola_06_uloha_4_sila_grafy.pdf`
(H₀ šedě, H₁ modře, α šrafováním vzorem SVG, β světle modře, síla oranžově,
barvy ze `scripts/kapitola_06-prezentace-sila.R`), výpočet krok za krokem
pro obě situace, vzorce `ODMOCNINA`/`NORM.S.INV`/`NORM.DIST` s dosazenými
hodnotami a křivka síly. Výpočet je zobrazen jako seznam kroků (`dl`)
ve třech sloupcích, ne jako tabulka: dynamický výstup nelze číslovat
„Tabulka X“, jak vyžaduje kontrola tabulek. Kapitola 6 odkazuje na stránku
blokem „Vyzkoušejte si“ na konci oddílu o statistické síle; jiný text
kapitoly se nemění. Upraveny `_quarto.yml`, styly `.viz-ss-…`,
`check-html.cjs` (pořadí v menu a nová kontrola podle PROVOZ.md), karta
kapitoly 6, OSNOVA.md, plán pokračování, registr a PROVOZ.md. Nové pojmy,
značení ani funkce Excelu nepřibyly; slovníček a přehledy beze změny.

Před prací byla opravena místní větev `codex/cross-chapter`: její ref
a reflog byly přepsány nulovými bajty (HEAD nešla načíst). Podle reflogu
HEAD a `packed-refs` ukazovala na `dbb13e3`, který je sloučen v PR #166;
větev proto začala znovu z `origin/main` (`git fsck` bez chyb).

Nezávislá kontrola (skripty ve `scratchpad`, mimo repozitář):

- síla, kritické hodnoty a směrodatná chyba pro 18 nastavení v R
  (`pnorm`/`qnorm`): scénáře předlohy 0,654 / 0,413 / 0,915 / 0,838 / 0,293 /
  0,762 / < 0,001, hodnoty textu kapitoly 6 (3 s: 0,293; 8 s: 0,965;
  400 řidičů: 0,807; jednostranně 3 s: 0,409) a okrajové případy; stránka
  se shoduje s relativní přesností 10⁻⁹;
- osm vzorců ve tvaru, který stránka nabízí (směrodatná chyba, kritické
  hodnoty pro tři směry a α 0,01, síla pro tři směry), bylo zadáno přes
  `FormulaLocal` do skryté samostatné instance českého Excelu bez uložení;
  výsledky se od přesné síly liší nejvýše o 4·10⁻⁷ (mezivýsledky na šest
  platných číslic).

Ověřeno: `quarto render` celé knihy a `check-html.cjs` bez chyb. Prohlédnuty
snímky desktopu (výchozí stav; rozdíl 0 v A a opačný jednostranný test v B)
a šířky 375 px. Podle nich opraveny chybějící popisky směru v situaci A,
mezery v legendě, překryv popisků kritických hodnot s popiskem H₁, svislé
pruhy z výchozího stohování ploch v Observable Plot a zápis krajních
pravděpodobností („β > 0,999“ místo „β = > 0,999“).

Neověřeno: čtečka obrazovky (ověřeny jen nativní prvky, popisky a `aria-live`),
provoz na GitHub Pages a bez CDN, porozumění studentů. Ruční PDF ani export
tutora nebyly spuštěny; oba přepisují odkazy `viz_….qmd` obecným pravidlem.

## 2026-11-06 — Vizualizace ploch pod normální křivkou (upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-upresneni-2026-11-06)
přibyla druhá stránka části „Interaktivní vizualizace“,
[Plochy pod normální křivkou](viz_normalni_rozdeleni.qmd), v menu před
pilotem. Společný model N(μ, σ) (výchozí N(0, 1)); část „Od hranice
k podílu“ (vlevo, vpravo, mezi, mimo interval) a část „Od podílu k hranici“
(dolní, horní, prostřední část, oba chvosty). Každá část má hustotu
s vybarvenou plochou a řadou z-skórů pod osou a distribuční funkci se sloupci
výšek, ve druhé části se šipkami opačného čtení. Výsledky uvádějí převod
na z, výpočet z ploch vlevo, podíl na 3 desetinná místa, procento na 1
a vzorec `NORM.DIST`/`NORM.INV` s dosazenými hodnotami. Barvy odpovídají
`scripts/kapitola_04.R`. Kapitola 4 na stránku odkazuje blokem „Vyzkoušejte
si“ na konci oddílu hodnot k zapamatování; jiný text kapitoly se nemění.
Upraveny `_quarto.yml`, styly `.viz` (skrytá pole, části, model, široké
položky výsledků), `check-html.cjs` (pořadí v menu a nová kontrola podle
PROVOZ.md), karta kapitoly 4, OSNOVA.md, plán pokračování, registr a PROVOZ.md.
Nové pojmy, značení ani funkce Excelu nepřibyly; slovníček a přehledy beze změny.

Nezávislá kontrola (skripty ve `scratchpad`, mimo repozitář):

- `pnorm` stránky (Hartův algoritmus 5666 podle Westa) se na mřížce
  z = −12 až 12 po 0,01 liší od `pnorm` v R nejvýše o 7·10⁻¹⁶ (relativně
  nejvýše 9·10⁻⁹ v chvostu); `qnorm` (Acklam s jedním Halleyho krokem)
  se pro 34 podílů od 10⁻¹⁵ do 1 − 10⁻¹⁰ liší nejvýše o 1,1·10⁻⁹;
- všech osm úloh v modelu N(50, 10) dává 0,841 / 0,159 / 0,136 / 0,317
  a meze 62,82; 66,45; 30,40–69,60 shodně s R;
- jedenáct vzorců ve tvaru, který stránka nabízí (`NORM.DIST`, `NORM.INV`,
  doplňky, rozdíly, desetinné parametry), bylo zadáno přes `FormulaLocal`
  do skryté samostatné instance českého Excelu bez uložení; výsledky
  se shodují s R na 15 platných míst.

Prohlédnuty snímky desktopu (mezi, mimo s velmi blízkými mezemi, horní část,
oba chvosty, hranice 4σ od průměru, chybová hláška) a šířky 375 px. Podle nich
opraveny popisek řady *x*, seskupení výsledků podle mezí, šířka sloupců
u blízkých mezí a zobrazení podílů blízkých 0 a 1 ve výpočtu a popiscích.

Neověřeno: čtečka obrazovky (ověřeny jen nativní prvky, popisky a `aria-live`),
provoz na GitHub Pages a bez CDN, porozumění studentů. Ruční PDF ani export
tutora nebyly spuštěny; oba přepisují odkazy `viz_….qmd` obecným pravidlem.

## 2026-11-06 — Rozvržení panelů vizualizace výběrového rozdělení průměru

Podle připomínek autora k PR #164 upraveno jen rozvržení
[vizualizace](viz_vyberove_rozdeleni_prumeru.qmd); text a výpočty se nemění:

- panel posledního výběru je vyšší (270 px, na mobilu 250 px) a má větší
  pásmo pod nulou; body leží těsně pod nulovou čárou a trojúhelník průměru
  s popiskem je níž, s volným místem k bodům i ke značkám osy x;
- šipka σ je nad vrcholem křivky populace a popisek „σ = 15 s“ je na úrovni
  popisku μ;
- pro *n* = 1 je poznámka o odhadu hustoty nad vrcholem čárkované hustoty
  populace.

Ověřeno: `quarto render` celé knihy a `check-html.cjs` bez chyb. Prohlédnuty
snímky všech čtyř populací při *n* = 1, 2 a 30 na desktopu a výrazně
zešikmené populace při *n* = 1 a 30 na šířce 375 px: popisky ani trojúhelník
se nepřekrývají s křivkami, body ani osou a stránka nepřetéká.

## 2026-11-05 — Úpravy pilotní vizualizace podle autora (upřesnění R65)

Po sloučení pilotu (PR #163) upravena [stránka vizualizace](viz_vyberove_rozdeleni_prumeru.qmd)
podle [upřesnění R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-interaktivni-vizualizace):

- odstraněno tlačítko schránky (`code-copy: false` v hlavičce stránky);
- panely jsou vyšší a popisky os y svislé a vycentrované;
- počet nových výběrů se zadává v poli 1–1000 s jedním tlačítkem
  „Vylosovat“, celkový počet opakování má strop 100 000 se zprávou;
- u populace je šipka σ;
- nad body posledního výběru je odhad hustoty z výběru (gaussovské vyhlazení,
  šířka podle `bw.nrd0`) s čárkovanou hustotou populace;
- lze volit čtyři populace se stejnými μ = 35 s a σ = 15 s: souměrnou
  (normální), mírně (gama z kapitoly 6), středně a výrazně zešikmenou
  (posunuté lognormální, šikmost 2 a 4, nejmenší doby 9,84 a 20 s);
- přibyl řádek se dvěma normálními Q–Q grafy (poslední výběr a průměry,
  nad 500 průměrů ztenčeno se zachováním krajních bodů).

Text stránky popisuje nové prvky a přidává pátý úkol
k závislosti potřebného *n* na tvaru populace. Nové pojmy nezavádí.
Upraveny styly `.viz`, `check-html.cjs`, PROVOZ.md, karta kapitoly 6
a registr.

Ověřeno: `quarto render` celé knihy; `check-html.cjs` (rozšířená kontrola
podle PROVOZ.md), `check-chapter-06.R` a `check-doc-maps.cjs` bez chyb.

Nezávislé srovnání s R (`scratchpad`, mimo repozitář):

- parametry lognormálních populací vyřešené v R pomocí `uniroot` se shodují
  na 12 platných míst;
- hustoty všech populací v bodech 12, 25, 40 a 70 s a odhad hustoty
  (šířka 7,5440895384, hodnoty ve čtyřech bodech) se shodují na 10 desetinných
  míst; numerické integrály hustot jsou 1,000000 (výrazně zešikmená populace
  0,999991 kvůli kroku integrace u ostrého náběhu);
- normální kvantil se od `qnorm` liší nejvýše o 2·10⁻⁹.

Simulace z 200 000 hodnot na populaci:

- průměry 34,97–35,09 s, směrodatné odchylky 14,97–15,30 s;
- šikmosti −0,006; 0,858; 1,985 a 4,292 proti 0; 0,857; 2 a 4. Odhad šikmosti
  u výrazně zešikmené populace je kvůli těžkému chvostu nepřesný;
- směrodatné odchylky 10 000 průměrů výběrů po 30 jsou 2,71–2,76 s proti 2,74 s.

Prohlédnuty snímky všech čtyř populací při *n* = 2 a 30 na desktopu
a výrazně zešikmené populace na šířce 375 px; stránka nepřetéká.

Neověřeno: čtečka obrazovky, provoz na GitHub Pages a bez CDN, porozumění
studentů. Ruční PDF se netýká (stránka v něm není).

## 2026-11-05 — Část „Interaktivní vizualizace“ a pilot (R65)

Podle schváleného plánu ([R65](../docs/rozhodnuti/postupy-a-dokumentace.md#r65-interaktivni-vizualizace))
přibyla mezi výkladové kapitoly a přehledy část „Interaktivní vizualizace“
s první stránkou [Výběrové rozdělení průměru](viz_vyberove_rozdeleni_prumeru.qmd)
(Quarto OJS, Observable Plot, d3). Výukový model a barvy odpovídají
`scripts/kapitola_06.R`. Kapitola 6 na ni odkazuje blokem „Vyzkoušejte si“
na konci oddílu o simulaci; jiný text kapitoly se nemění. Rozšířeny
`check-html.cjs` (tři části menu, kontrola vizualizace), styly `.viz`
v `assets/styles.css`, převod odkazů `viz_….qmd` na web v
`scripts/render-book-pdf.ps1` a `scripts/export-tutor.cjs`. Aktualizovány
AGENTS.md, PROVOZ.md, OSNOVA.md, karta kapitoly 6 a plán pokračování.

Ověřeno: `quarto render` celé knihy; `check-html.cjs` bez chyb (včetně nové
kontroly vizualizace); `check-chapter-06.R` prošel; `check-doc-maps.cjs`
bez chyb. Nezávislá kontrola v prohlížeči: hustota modelu se v bodech 5, 10,
29, 35, 60 a 90 s shoduje s `dgamma` v R na deset desetinných míst, numerický
integrál na intervalu 0–100 s je 0,99901 jako v R. 10 000 simulovaných průměrů
dalo pro *n* = 1, 5, 25, 30 a 100 směrodatné odchylky 14,845; 6,746; 3,015;
2,713 a 1,495 s proti σ/√*n* 15; 6,71; 3; 2,74 a 1,5 s a průměry 34,78–35,04 s;
podíly standardizovaných průměrů nad 2 a pod −2 odpovídají tabulce
`tbl-k06-07` v mezích simulace. Snímky desktopu a šířky 375 px prohlédnuty
(po opravě překryvu popisků os, indexu σ_m a skloňování „1 řidič“); stránka
nepřetéká. Export tutora (`--skip-figures`) proběhl a v kapitole 6 převedl
odkaz na webovou adresu; poté byla obnovena předchozí složka `ai-tutor/`,
takže vydané archivy 0.3.4 se nezměnily.

Neověřeno: ruční PDF nebylo spuštěno (přepis odkazu v `render-book-pdf.ps1`
ověřen jen na textu kapitoly 6 a syntaxí skriptu); čtečka obrazovky
nevyzkoušena (ověřeny jen nativní prvky, popisky a `aria-live`); web na
GitHub Pages a chování bez připojení k CDN nezkoušeny; porozumění studentů
neověřeno (jen interní didaktická revize).

## 2026-11-04 — Studentský návod k instalaci AI tutora

Na žádost autora vznikl `ai-tutor/navod.docx` (4 strany A4, mimo Git):
návod pro studenty, kteří si z MS Teams stáhli archiv tutora 0.3.4. Pokrývá
volbu platformy a souboru, nahrání a spuštění v ChatGPT, Claude a Gemini,
první rozhovor, přechod na novou verzi, řešení potíží a soukromí. Odkaz ke
stažení záměrně neobsahuje (rozesílá autor). Odkaz na návod doplněn do
[AITUTORS.md](../docs/AITUTORS.md#hlavní-místa-informací).

Zdroje postupů: Claude podle nápovědy Anthropic „Using skills in Claude“
(Settings → Capabilities, Customize → Skills → + → Create skill → Upload
a skill) a autorova testu níže; ChatGPT (Pluginy → Přidat → Nahrát archiv
pluginu) a Gemini (Přizpůsobit nebo Nastavení → Dovednosti → Vytvořit →
Nahrát) podle sdělení autora v tomto úkolu, spuštění přes @ v ChatGPT
a lomítkem v Gemini podle nápovědy OpenAI a Google. Generátor (docx v Node.js)
zůstal mimo repozitář. Dokument převeden přes Word do PDF a všechny
strany prohlédnuty; názvy archivů ověřeny proti `ai-tutor/*/`.

Neověřeno: celý studentský postup na studentském či bezplatném účtu kterékoli
platformy, české popisky menu Claude a nahrání do Gemini (viz níže).

Úprava podle autora: archiv pro ChatGPT se pro studenty jmenuje
`statistika-tutor-chatGPT-0.3.4.zip` (autor jej přejmenoval kvůli jednotným
názvům). Na pokyn autora jej tak nově pojmenovává i export
(`scripts/export-tutor.cjs`, vzor `statistika-tutor-<platforma>-<verze>.zip`);
identita a název pluginu v manifestech se nemění. Aktuální cesty upraveny
v AITUTORS.md, PROVOZ.md a README pluginu; starší záznamy historie uvádějí
původní název. Export `--skip-figures` a `check-tutor.cjs` prošly se stejnými
počty jako 2026-11-04; nový archiv ChatGPT (129 členů) se od ručně
přejmenovaného liší jen v registru a šesti plánech, kde je uvedena revize
zdroje (porovnány otisky všech členů). Verze zůstává 0.3.4.
Návod už nedoporučuje jedinou platformu: povzbuzuje k vyzkoušení více
platforem kvůli spolehlivosti, limitům a stylu a k pokračování na jiné
platformě po vyčerpání limitu.

## 2026-11-04 — Samostatná pravidla AI tutorů (R64)

Na pokyn autora vznikl [docs/AITUTORS.md](../docs/AITUTORS.md) jako hlavní
místo pravidel tvorby, vydání a ověřování AI tutorů: hlavní místa informací,
společná pravidla (jeden zdroj, verze a vydání, ověřování chování) a oddíly
ChatGPT, Claude a Gemini. Oddíl AGENTS.md „Ověřování AI tutora“ nahrazen
krátkým obecným oddílem „AI tutor“ s odkazem; kotva `overovani-ai-tutora`
zůstala, takže historické odkazy fungují. Pravidlo testů v režimu Chat
převzato a zobecněno na běžný konverzační režim každé platformy.
Aktuální odkazy v PROVOZ.md a smoke-prompts.md vedou na AITUTORS.md;
úvod testovací sady zkrácen, aby pravidla nebyla na dvou místech.
Doplněn rozcestník v README.md, tabulka hlavních míst v AGENTS.md,
doklad [R64](../docs/rozhodnuti/ai-tutor.md#r64-pravidla-ai-tutoru)
a řádek registru. Oddíly o složce `ai-tutor/` a variantě Gemini popisují
stav po sloučení PR #159; postup nahrání do Gemini zatím ověřen není.

## 2026-11-04 — AI tutor 0.3.4: skill pro Gemini a složka ai-tutor/

Autor hlásil, že Gemini odmítá skill: „Složka dovednosti obsahuje příliš
mnoho souborů.“ Skill měl 125 souborů, z toho 97 SVG. Podle schváleného
plánu export nově vytváří třetí archiv
`ai-tutor/gemini/statistika-tutor-gemini-0.3.4.zip` (29 souborů, 448 kB):
Claude složka bez SVG, v kapitolách odkaz na obrázek ve webové učebnici
místo řádku obrázku, generovaný rejstřík `references/obrazky.md`
(97 obrázků s číslem, popiskem, textovým popisem a odkazy) a jedna věta
v SKILL.md jen této varianty. Verze zůstává 0.3.4: archivy pro ChatGPT
a Claude se od předchozího exportu 0.3.4 liší pouze revizí zdroje
v plánech a registru (porovnány otisky všech členů).

Hotové balíčky jsou nově v hlavní ignorované složce `ai-tutor/`
s podsložkami `chatgpt/`, `claude/`, `gemini/` a společným `overeni.json`.
Celý dosavadní obsah `output/tutor/` (32 souborů včetně archivů 0.2.0–0.3.4,
záznamů rozhovorů a snímků) přesunut beze změny: ChatGPT do `chatgpt/`,
Claude archivy do `claude/`, `overeni.json` do kořene; počet souborů
i bajtů ověřen, prázdná `output/tutor/` odstraněna. Starší záznamy této
historie uvádějí původní cesty `output/tutor/`. Nový export přepsal
přesunuté archivy 0.3.4 a `overeni.json` týmž obsahem s novou revizí.

Export `--skip-figures` a kontrola prošly pro všechny tři varianty;
Gemini kontrola: 29 souborů, 97 obrázků, 1 904 místních odkazů.
Negativní kontroly odmítly kopii s ponechaným SVG, se 101 soubory
a s odstraněným textovým popisem. Všech 97 webových kotev `fig-…`
existuje ve vykresleném `_book/` (render z 2026-11-01).

Neověřeno: nahrání do Gemini a chování tutora tam; skutečný limit Gemini.

## 2026-11-04 — AI tutor 0.3.4: skill pro Claude

Na žádost autora a podle schváleného plánu přidán do exportu druhý archiv
`output/tutor/statistika-tutor-claude-0.3.4.zip` pro nahrání do claude.ai.
Vzniká z téže sestavené složky skillu jako plugin pro ChatGPT; jedinou
odchylkou je hlavička SKILL.md převedená z JSON na YAML. Ve dvou referencích
nahrazena zmínka o ChatGPT obecným „klientem“ (`VIZUALIZACE.md`)
a do `PRIPOJENI-KAPITOL.md` doplněn oddíl o verzi pro Claude. Kvůli této
změně obsahu zvýšena verze obou manifestů na 0.3.4; místní archiv 0.3.3
byl při prvním zkušebním běhu přepsán obsahem s těmito dvěma změnami,
nahrané cloudové vydání 0.3.3 se nemění.

Plný export (s obrázky) a následný export 0.3.4 `--skip-figures` prošly:
šest kapitol, šest plánů, osm položek katalogu, 417 hesel, 1 426 matematických
zápisů, 97 obrázků, 72 řešení, 53 bibliografických položek a 2 189 odkazů.
Nová kontrola Claude skillu prošla (125 souborů, popis 363 znaků); negativní
kontroly zachytily chybný název složky i změněnou referenci. Archiv Claude
má 3,0 MB, plugin 3,8 MB.

Test v claude.ai (týž den, na žádost autora): archiv nahrán agentem přes
Customize → Skills → Upload a skill v prohlížeči Brave s rozšířením
Claude in Chrome do autorova osobního účtu (plán Max). Náhled správně
přečetl `name` i `description` z YAML, bezpečnostní kontrola nahrání
prošla, skill má 125 souborů a je zapnutý. Testy proběhly v režimu Chat
(nikoli Code), model Sonnet 5.5 s intenzitou Medium, bez projektu
a bez příloh, každý scénář v novém chatu:

- „Chci studovat statistiku pro psychology.“ — skill se aktivoval sám
  (rozhraní ukazuje „Skills: statistika-tutor“), přečetl předepsané
  `REFERENCE.md` a `INDEX.md`, nabídl přesné názvy kapitol 1–6, hranici
  kapitol 7–8, způsoby studia a rozsah.
- Navazující dotaz na směrodatné chyby pro 25, 100 a 400 řidičů
  (smoke 6 B) — správně 3,0; 1,5; 0,75 s s dosazením; citoval
  `references/kapitoly/kapitola_06.md` a ID `sec-chyba-prumeru`,
  `sec-tri-vrstvy`, `sec-odhad-chyby`, `sec-pravdepodobnost-prumeru`.
  ID i hodnoty 1,51 a 1,46 s ověřeny proti `quarto/kapitola_06.qmd`.
- Úloha 16 a) kapitoly 6 sokratovsky (smoke 6 C) — zadání odpovídá
  zdroji včetně označení nepovinnosti, tutor položil jednu otázku,
  řešení neprozradil; na částečně chybnou odpověď potvrdil správnou
  část, pojmenoval chybu a dal další vodítko.
- Interaktivní vizualizace výběrového rozdělení (n = 25, 100, 400,
  σ = 15 s) — vznikl funkční artifact se značením σₘ, zešikmenou
  populací podle kapitoly a simulací 10 000 výběrů; agent ručně přepnul
  n = 400 a ověřil nadpis σₘ = 0,75 s a pásmo 34,25–35,75 s. Tvorba
  trvala přibližně 8 minut. Klávesnici, úzké zobrazení, reset a další
  ovladače agent sám nezkoušel.

Omezení: jeden účet s plánem Max, jeden model a po jednom pokusu na
scénář; nejde o test bezplatného účtu ani studentů. Režim zkoušení,
procvičování a dlouhý rozhovor podle plánu nebyly zkoušeny. Číselný
limit velikosti uploadu zůstává neznámý (archiv 3,0 MB prošel).
Nové vydání ChatGPT pluginu 0.3.4 nebylo nahráno.

## 2026-11-04 — AI tutor 0.3.3: krátké zahajovací prompty pro Desktop

Po autorově hlášení, že Desktop u verze 0.3.2 nezobrazuje zahajovací
volby, realizován schválený plán jejich zkrácení. Oba manifesty obsahují
ve stejném pořadí tři nové prompty o 82, 85 a 88 znacích. Každý zachovává
pokyn načíst SKILL.md tutora a katalog; podrobnosti načítání zůstávají
v nezměněném skillu. Aktivační popis, identita a ostatní funkce zachovány.
Kontrola nově vyžaduje nejvýše 100 znaků na prompt; jde o preventivní
autorské pravidlo, nikoli doložený limit Desktopu. Rozšířena
[testovací sada](../scripts/tutor/smoke-prompts.md#regrese-aktivace-nainstalované-dovednosti)
o zobrazení voleb a kontrolu vloženého textu zvlášť na Desktopu a webu.

Export `node scripts/export-tutor.cjs --skip-figures` prošel: šest kapitol,
šest plánů, osm položek katalogu, 417 hesel, 1 426 matematických zápisů,
97 obrázků, 72 řešení, 53 bibliografických položek a 2 189 odkazů.
Porovnání s archivem 0.3.2 potvrdilo zachování SKILL.md, ostatních
referencí, výkladu a obrázků po bajtech mimo generovaný index, registr
a plány s metadaty vydání. Zdroj při exportu obsahoval necommitované
úpravy; revizi a otisky zachycuje místní `output/tutor/overeni.json`.

Archiv `output/tutor/statistika-pro-psychology-ai-tutor-0.3.3.zip` nahrán
do původního osobního soukromého pluginu
`Plugin_f0a6ddcaadfc8191a5009ff162276308` s kontrolou předchozího vydání.
Nové vydání: `pluginrel_6aeb37efc56c8191ae69087ee1b3e675`.
Zpětně načtené oba manifesty a nezměněný skill odpovídají kandidátovi.

Agent na Windows Desktopu ověřil detail verze 0.3.3 se všemi třemi
viditelnými volbami. První volba vložila přesný text s označeným pluginem
a zahájila nový chat; odpověď uvedla aktuální verzi a správné úplné názvy
kapitol 4 a 6 i hranici přibalených kapitol 1–6. Rozhraní ukazovalo
„Zeptat se ChatGPT“ a intenzitu „Střední“; přesný model nebyl zjištěn.
Jednotlivé operace čtení referencí ani panel dokazující aktivaci dovednosti
v tomto pokusu nezávisle ověřeny nebyly. Další ovládání autor zastavil.
Následně výslovně sdělil: „Druhou i třetí volbu jsem už ověřil sám.“
Toto je autorem provedené ověření, nikoli dokončený agentní test těchto
dvou scénářů; konkrétní odpovědi a načtení podkladů agent nepozoroval.

Na webu v Brave agent po obnovení detailu ověřil všechny tři krátké
volby, verzi 0.3.3 a správný text vložený první volbou. Webový průvodce
otevřel Work; prompt nebyl odeslán a nejde o konverzační test Work.
Desktopové zobrazení po zkrácení podporuje hypotézu o vlivu délky,
neurčuje však přesný limit ani nevylučuje další vliv obnovení klienta.
Nejde o test všech klientů, studentských účtů ani statistický důkaz
spolehlivosti aktivace. Navazuje na již sloučený PR #155.

## 2026-11-04 — AI tutor 0.3.2: aktivace a zahajovací prompty

Na výslovnou žádost autora upraven existující plugin, v návaznosti na
hlášené selhání aktivace při prvním spuštění.
Popis dovednosti nyní začíná situacemi použití: zahájení studia, výběr
kapitoly, režimu a rozsahu i výslovné oslovení tutora. Všechny tři úvodní
prompty žádají načtení nainstalovaného SKILL.md, katalogu a referencí;
zachovávají původní účel studia, sokratovského vedení a zkoušení.
V hlavním skillu zpřesněno čtení instalovaných souborů a postup při výpadku:
správa pluginů ani starší chat nenahrazují čtení dovednosti, bez katalogu
se nabídka kapitol neodhaduje. Způsob výuky, cvičení, zkoušení, značení
a vizualizace od oddílu „Způsoby studia“ dále obsahově nezměněny.

Postup vychází také z [oficiálního popisu aktivace dovedností](https://learn.chatgpt.com/docs/build-skills#how-chatgpt-and-codex-use-skills):
stručná metadata slouží k výběru, úplné instrukce se čtou následně.
Jde o opatření pro spolehlivější výběr, nikoli záruku aktivace.
[Regresní sada](../scripts/tutor/smoke-prompts.md#regrese-aktivace-nainstalované-dovednosti)
rozlišuje důkaz použití dovednosti, věcnou shodu odpovědi a chyby klienta.

Export `node scripts/export-tutor.cjs --skip-figures` úspěšný: šest kapitol,
šest plánů, osm položek katalogu, 417 hesel přehledů, 1 426 matematických
zápisů, 97 obrázků, 72 řešení, 53 bibliografických položek a 2 189 odkazů.
Kontrola dokumentačních map prošla. Limit velikosti hlavního skillu
v kontrole zvýšen ze 14 na 16 kB pro cílené doplnění načítání.
Porovnání archivů potvrdilo zachování textů kapitol a obrázků; změny plánů
a indexu jsou omezené na verzi, datum a revizi zdroje. Další reference se
liší pouze konci řádků. Registry zachovávají obsahové otisky podkladů.

Archiv `output/tutor/statistika-pro-psychology-ai-tutor-0.3.2.zip` nahrán
do původního osobního soukromého pluginu
`Plugin_f0a6ddcaadfc8191a5009ff162276308` s kontrolou předchozího vydání
`pluginrel_6aea16af96fc81918f8ac71b742140da`. Nové vydání:
`pluginrel_6aeb3322790881919270be138090136a`. Zpětně načtené oba manifesty
a SKILL.md odpovídají kandidátovi. Identita, přístup, ostatní metadata
i tři účely promptů zachovány; nové prompty a verze ověřeny také v UI
po obnovení stránky. Zdroj při exportu obsahoval necommitované úpravy;
otisky zachycuje místní `output/tutor/overeni.json`.

Testováno v ChatGPT na webu v Brave, režim Chat, bez příloh. Rozhraní
ukazovalo intenzitu přemýšlení „Střední“, přesný název modelu nezobrazilo;
nebyl odhadován. Kliknutí na úvodní prompt nejprve otevřelo Work;
před testováním použito přepnutí do Chat. Pro tento klientský výchozí režim
balíček nezavádí novou konfiguraci.

- Zahájení studia:
  správné úplné názvy kapitol 4 a 6, verze 0.3.2 a dostupnost kapitol 1–6
  oproti 7–8. Panel Zdroje → Skilly ukázal použitý `statistika-tutor`
  s novým popisem a instrukcemi, což dokládá aktivaci nezávisle na tvrzení
  v odpovědi. Samotné operace čtení jednotlivých referencí rozhraní neukázalo.
  Tutor nabídl více voleb současně; dodržení postupného průvodce tedy není
  tímto pokusem prokázáno.
- Sokratovské vedení:
  uložená první odpověď uvádí aktuální verzi a žádá jen téma či zadání.
  Po volbě cvičení 3.1 následovala jediná otázka na modus, bez řešení,
  s přesnými daty 3, 4, 4, 5, 6, 20 minut; nezávisle porovnáno s QMD.
  Webový klient však zobrazil „Tuto odpověď se nepodařilo načíst“, také
  po obnovení stránky. Obsah ověřen čtením uloženého chatu, nikoli vydáván
  za bezchybné vykreslení. Přímé čtení jednotlivých referencí nepozorováno.
- Zkoušení:
  uložená první odpověď zachovala zvolený režim, aktuální verzi, hranici
  přibalených kapitol, výběr rozsahu a dohodu o počtu otázek a zpětné vazbě.
  Také zde nastala chyba zobrazení; kontrola uloženého textu není kontrolou
  fungování všech ovladačů. Opakované načtení odpovědi testováno samostatně.

Neproveden experiment s opakovanými nezávislými pokusy ani srovnání
úspěšnosti proti 0.3.1. Neotestována skutečně nedostupná reference,
automatický výběr bez označení pluginu ani ostatní klienti či studentské účty.
Chyba vykreslení není důkazem selhání aktivace ani důkazem chyby balíčku;
její příčina zůstává neověřená. Interní test není ověřením na studentech.

## 2026-11-03 — Nahrání AI tutora 0.3.1 do existujícího pluginu

Na výslovný pokyn autora aktualizován původní soukromý osobní plugin
`Plugin_f0a6ddcaadfc8191a5009ff162276308` pomocí Plugin Creatoru.
Použit ověřený archiv `output/tutor/statistika-pro-psychology-ai-tutor-0.3.1.zip`
s SHA-256 `626cdcaf7b3d3059b5160620a852ace8b0b614405fb192b2cf09833789f99c94`.
Před aktualizací načten inventář, oba manifesty a hlavní skill vydání
0.3.0; kořenová metadata kandidáta se kromě verze shodovala s cloudem.

Aktualizace byla chráněna očekávaným vydáním
`pluginrel_6aea058888508191b5f56798b02ccbae`; nové vydání je
`pluginrel_6aea16af96fc81918f8ac71b742140da`. Zpětné načtení potvrdilo
verzi 0.3.1 v metadatech i obou manifestech, odkaz z hlavního skillu
na `OTAZKY.md` a přítomnost nové metodiky bez předvýběru odpovědi.
Identita, osobní rozsah a soukromá dostupnost zůstaly zachovány.

Jde o ověření uloženého vydání. Chování nových otázek v režimu Chat
zatím nebylo vyzkoušeno; místní kontrola balíčku ani zpětné načtení
souborů tento test nenahrazují. Historický stav kandidáta níže zachován.

## 2026-11-03 — Kandidát AI tutora 0.3.1: samostatné odpovědi na otázky

Autor nahlásil, že průběžné ověřovací otázky ve vysvětlování mají vždy
správnou možnost B a tato možnost je předvybraná. Dosavadní instrukce
neurčovaly pořadí možností ani výchozí stav odpovědi; konkrétní mechanismus
předvýběru v hlášeném klientu nebyl nezávisle reprodukován.

Do [hlavního skillu](../plugins/statistika-pro-psychology-ai-tutor/skills/statistika-tutor/SKILL.md)
doplněn odkaz na společnou metodiku
[otázek](../plugins/statistika-pro-psychology-ai-tutor/skills/statistika-tutor/references/OTAZKY.md).
Platí také pro procvičování a zkoušení: otevřené ověření porozumění,
proměnlivé pořadí možností bez pevného cyklu, kontrola klíče po promíchání,
stejná prezentace odpovědí a zpětná vazba podle režimu. Při automatickém
předvýběru klienta se použije běžný text nebo otevřená otázka. Výchozí
volba ani pouhé pokračování nejsou samostatným výkonem studenta.

Oba manifesty zvýšeny na 0.3.1; kontrola exportu vyžaduje přibalení nové
reference. [Testovací sada](../scripts/tutor/smoke-prompts.md#ověřovací-otázky-bez-nápovědy-rozhraním)
přidává kontrolu šesti postupných výběrových otázek, jejich klíčů,
skutečného výchozího stavu rozhraní a náhrady bez předvýběru.

Místní kontrola: export se zachovanými obrázky (`--skip-figures`), kontrola
struktury a odkazů balíčku i nezávislé načtení archivu. Tato kontrola
neprokazuje chování modelu ani rozhraní. Nový kandidát zatím nebyl
vyzkoušen v režimu Chat ani nahrán do cloudového pluginu; instalovaná
verze 0.3.0 zůstává posledním doloženým vydáním. Studentský výklad
a data učebnice se nemění.

## 2026-11-03 — Nahrání AI tutora 0.3.0 do existujícího pluginu

Po autorově upozornění, že aplikace i web stále ukazují 0.2.1, napraveno
předchozí příliš úzké provedení pokynu k nahrání (pouze přílohy testovacích
chatů). Ověřený archiv 0.3.0 z revize `4e1a9211`, s otiskem uvedeným
v následujícím záznamu, nahrán přes Plugin Creator do původního soukromého
osobního pluginu `Plugin_f0a6ddcaadfc8191a5009ff162276308`. Před aktualizací
načten inventář i oba manifesty a instrukce; kořenová metadata se kromě
verze shodovala s kandidátem. Identita a přístup zůstaly zachovány.

Předchozí vydání `pluginrel_6ae8edaa399c81919057a23708d5685b` nahrazeno
vydáním `pluginrel_6aea058888508191b5f56798b02ccbae`. Zpětné načtení
potvrdilo aktuální verzi 0.3.0 a nové instrukce, index a registr. Po obnovení
existující stránky pluginu také webové rozhraní zobrazilo verzi 0.3.0.
Otevřené nedostatky z testování tím nejsou prohlášeny za odstraněné;
testování příloh níže se nezaměňuje za úplný test instalovaného vydání.

## 2026-11-03 — Ověření kandidáta tutora v režimu Chat

Po výslovném souhlasu autora byl kandidátní ZIP nahrán jako příloha
testovacích chatů. Toto ověření navazuje na níže zachovaný záznam
odmítnutého prvního pokusu. Všechny nové rozhovory proběhly v **režimu
Chat**, před prvním dotazem ověřeném v přepínači (Chat zvolen, Work
nezvolen). Prostředí: web ChatGPT v Brave, účet Plus, intenzita Střední /
Medium; konkrétní označení modelu rozhraní neukázalo, proto není doplněno
odhadem. Kandidát byl zpřístupněn přílohou a výslovnou žádostí řídit se
jeho SKILL.md, nikoli aktualizací instalovaného cloudového pluginu.
Hlavní pravidlo prostředí je nově v
[AGENTS.md](../AGENTS.md#overovani-ai-tutora), provozní návod a testy na něj
odkazují. Souhlas a jeho rozsah dokládá doplněk
[R63](../docs/rozhodnuti/ai-tutor.md#r63-plany-a-konvence-tutora).

Ověření rozlišuje tři sestavení stejného kandidátního čísla 0.3.0:

| Zdrojová revize | Rozhovor | Skutečně prověřené chování |
|---|---|---|
| `620fe8b2` | [Výběr kapitoly studia](https://chatgpt.com/c/6ae9faa1-ecc8-83ed-8b0a-c7baa2591ff2) | Přesná nabídka 1–6 a dostupnost 7–8; oprava názvu „Kapitola 2 – Popisné statistiky“; nejméně deset obsahových tahů kapitoly 6; směrodatná chyba, hypotézy, p-hodnota, síla a více testů; přechod k sedmi nepovinným částem učebnice. |
| `620fe8b2` | [Ověření statistického tutora](https://chatgpt.com/c/6ae9fc2f-1278-83eb-8db0-fbc03d4d5d1e) | Osmnáct otázek na začátek, prostředek a konec šesti kapitol, t-kvantil, český COUNTIFS a nedostupné cvičení 8; sokratovská pomoc s konkrétním cvičením 3, řešení na výslovnou žádost, vlastní úloha a zkoušení. |
| `32dccb7` | [Výpočet statistických ukazatelů](https://chatgpt.com/c/6ae9feb2-5388-83ed-9894-4e5add9a5c70) | Regrese značení a hranice kapitoly 6; skutečně ovládaný interaktivní graf, číselné vstupy po vyžádané úpravě, krajní hodnoty, obnova, úzké zobrazení prvního grafu a statická náhrada. |
| `4e1a9211` | [Závěrečné ověření](https://chatgpt.com/c/6aea0243-16e8-83eb-a0a6-73bb48abbd4e) | Správné m, medián a q s úrovní, mezikvartilové rozpětí jako rozdíl; označená vlastní modelová úloha bez prozrazení řešení; více testů a další krok v základním plánu kapitoly 6. |

Číselné a obsahové odpovědi na osmnáct zdrojových otázek odpovídaly
přibaleným textům. COUNTIFS zachoval české oddělovače a podmínky; t-kvantil
pro 24 stupňů volnosti a úroveň 0,975 byl přibližně 2,064. Tutor přiznal,
že konkrétní cvičení kapitoly 8 nemá přibalené. Ve zkoušení dodržel odklad
zpětné vazby a uzavřel dvě otázky výsledkem 4/4 s odůvodněním a výslovným
omezením hodnocení na tyto otázky. Nejde o měření porozumění na studentech.

Dlouhý rozhovor zachoval σₘ pro známou modelovou chybu a sₘ pro její
odhad i při studentově označení SE. Bez vyžádání grafy opakovaně
nenabízel. U více testů správně vypočetl očekávaný počet 1 a pravděpodobnost
alespoň jednoho falešného zamítnutí přibližně 0,642. Původní sestavení
spontánně zmínilo obecně korekce, aniž je označilo za přesah; Bonferroniho
korekci pojmenovalo až na výslovný dotaz a označilo jako doplněk mimo
kapitolu. Po návratu pokračovalo v původním učivu. Ve finální cílené
regresi zvolilo jako další krok doložené rozhodování až podle dat.
Tato krátká regrese nenahrazuje nový dlouhý běh finálního sestavení.

Na základě nálezů byly zpřesněny pokyny k přebírání hlavního pole Značení
místo alternativ, q a vyjádření mezikvartilového rozpětí, označování
vlastních modelových úloh, doložení tvrzené chyby studenta a výběru dalších
kroků z plánu. Finální cílená kontrola potvrdila hlavní značení a označení
úlohy. Nadbytečné upozornění na sekundy však přetrvalo i ve větě s českou
předložkou „s“; tutor rovněž jednou citoval neexistující kotvu
`sec-odolnost-stredu`. Výpočty byly správné, úplné dodržení citačních a
jazykových instrukcí proto doloženo není. Regrese zůstávají v
[testovací sadě](../scripts/tutor/smoke-prompts.md#regrese-z-testovani-v-rezimu-chat).

Interaktivní graf v Chatu převzal aktuální zadání μ = 50 bodů, σ = 12 bodů,
n = 36 a správně zobrazil σₘ = 2 body. Klávesnicí ověřeno n = 81 se
σₘ ≈ 1,33, kombinace n = 100 / σ = 8 se σₘ = 0,80 a n = 9 / σ = 24 se
σₘ = 8; první tlačítko Obnovit zadání vrátilo 36 / 12. Křivka měnila tvar
a její panel při zúžení nerostl. Po žádosti o opravu přidal tutor dva
číselné vstupy; zadání 100 / 8 synchronizovalo posuvníky i výpočet.
Další dvě obdobné otázky využily slovní odkaz na existující graf.
Vyžádaná **statická náhrada** byla řádně označená tabulka pro n = 25,
36, 81, 100 s chybami 2,40; 2,00; 1,33; 1,20 bodu.

**Otevřené nedostatky grafu:** první verze měla pouze posuvníky bez
číselných polí. Její svislá mez 0,5 téměř splývala s nejvyšším povoleným
vrcholem 0,4987, tedy bez požadované rezervy. V reálně změřeném úzkém
panelu 291 × 436 px (nastavení 320 × 480) stránka vodorovně nepřetékala,
ale osy se zmenšily k nečitelnosti. Druhá verze se na této šířce spolehlivě
znovu ověřit nepodařila; širší snímek není mobilním testem. Ve druhé verzi
zůstalo anglické tlačítko Reset a obecný přístupný název Slider; neplatné
n = 0 ponechalo předchozí model bez konkrétního chybového vysvětlení.
Reset vrátil nový výchozí stav 81 / 12, nikoli původní zadání 36 / 12.
Doklad zobrazení a místní exporty rozhovorů jsou v `output/tutor/`;
exporty historie jsou omezeným výřezem, nikoli úplným záznamem ovládání.

Ve dvou rozhovorech klient nejprve hlásil „Tuto odpověď se nepodařilo
načíst“. Vyžádané zopakování prostým textem bylo zobrazeno; existence
odpovědi v uložené historii se nepovažovala za úspěšné zobrazení.
Světlý motiv, zvětšený text, všechny hranice plánů v samostatných
rozhovorech, další témata grafů a studentské účty zůstávají neověřené.
Vygenerované vizualizace tímto během nesplnily všechna přejímací kritéria.

Finální archiv z `4e1a9211da3f4f7d2bcfc281094a76d396614ed3` byl sestaven
s `source_dirty: false`. SHA-256
`39099f1f5006bc721e3a5f79f6cc3764df7bf737920c03b65f934058aeb2c2ca`
se shoduje s přílohou závěrečného chatu. Prostřední sestavení mělo SHA-256
`9429ceba62e1f847e735b051c3da57a8be043abecc2166a8ab63313bd8e064b7`.
Kontroly finálního archivu prošly se stejnými počty jako v předchozím
záznamu (128 souborů, šest plánů, osm kapitol katalogu, 2 188 odkazů).
Cloudové vydání zůstává nezměněné; jeho instalace ani distribuce studentům
nebyly tímto testem ověřeny.

## 2026-11-03 — Kandidát AI tutora 0.3.0: plány, konvence a vizualizace

Realizace schváleného [R63](../docs/rozhodnuti/ai-tutor.md#r63-plany-a-konvence-tutora).
Hlavní instrukce a reference přednostně popisují požadované kroky,
zachovávají podstatné hranice a postup při chybějících podkladech.
Výběr studia rozlišuje kapitolu, čtyři způsoby práce, rozsah a nepovinné
části učebnice; výchozí je povinné učivo. Externí témata jsou doplňkem
na výslovný dotaz. Konkrétní nejednoznačné označení úlohy je v testech,
ve skillu zůstává obecné pravidlo cíleného upřesnění.

Export vytváří šest samostatných výukových plánů z kapitolových karet,
cílů a struktury kapitol a vazeb přehledů. Plány mají předpoklady,
posloupnost, hloubku výkladu a procvičení, rejstřík pojmů, značek a funkcí,
nepovinné bloky i hranice. Kontrola rozlišuje nepovinný blok, vnořené
nadpisy a nepovinné úlohy. Rejstřík sám neurčuje povinné nové pojmy.
Přesné názvy v nabídce skillu, indexu a registru vznikají ze stejného
katalogu osmi kapitol; úplné texty a plány zůstávají pro 1–6. Schéma
registru je 2; dostupnost a kompatibilitu popisuje [provozní návod](../docs/PROVOZ.md#export-ai-tutora).

Značení σₘ/sₘ sjednoceno v instrukcích, metodice, demonstračních příkladech
a očekávání testů. Metodika vychází z aktuální úlohy a připouští další
vhodná témata a ovladače; modelové demonstrace jsou samostatnou referencí,
korelace výslovně doplňkem mimo přibalené učivo. Pravidla pokrývají české
ovládání, přesný vstup, opětovné použití grafu, obnovu zadání, oddělení
losování, společná měřítka, skutečnou hustotu a rozměry panelu.

Obsahová a didaktická kontrola se soustředila na návaznost cílů a úloh,
rozlišení povinného výkladu a rozšíření, předpoklady začátečníka a hranice
plánů. V kartě 6 byla opravena starší formulace o vypisování p-hodnoty
podle R56. Datum celé původní revize karet se neposouvalo. Studentské QMD,
data, výpočty a obrázky se v tomto úkolu neměnily; nejde o nové nezávislé
odborné či numerické ověření celé učebnice ani o ověření na studentech.

Kandidát sestaven z commitu `620fe8b2c62dac047665ef929aa70cd52ca5317f`
s `source_dirty: false` pomocí `node scripts/export-tutor.cjs --skip-figures`.
Použity nezměněné existující obrázky; porovnání SHA-256 proti archivu 0.2.1
potvrdilo shodu všech **111 původních materiálů** (šest kapitol, tři přehledy,
97 obrázků, úvod, literatura, dvě licence a logo). Zachována identita,
výchozí prompty a metadata pluginu kromě verze.

Kontroly archivu: **128 souborů**, šest plánů, osm katalogových kapitol,
417 přehledových hesel, 1 426 matematických zápisů, 97 obrázků,
72 řešení, **2 188 místních odkazů**, 53 bibliografických položek.
Ověřeny názvy a pořadí proti knize, cíle, úplnost rejstříku a tabulek
dovedností, označení nepovinných úseků v samotných plánech a otisky všech
členů ZIPu nezávislým čtením .NET. Kontrola autorských map prošla:
82 souborů, 63 rozhodnutí, 3 522 místních a 327 příchozích odkazů,
bez chyby. Dvě negativní zkoušky správně odmítly název „Popisné statistiky“
u kapitoly 2 a ztracené označení vnořeného nepovinného oddílu kapitoly 3.

Archiv: `output/tutor/statistika-pro-psychology-ai-tutor-0.3.0.zip`.
SHA-256: `30a66ed96771f732f15df74f6a54c28214d8c3c2246398718e15342095788834`.
Podrobný inventář, porovnání a negativní kontroly jsou místně
v ignorované složce `output/tutor/`.

**Stav vydání a omezení:** kandidát není publikován do cloudového pluginu.
Pokus nahrát kandidátní ZIP jako přílohu nového testovacího chatu
(ChatGPT Work v Brave) odmítla automatická kontrola oprávnění: schválený
plán nepovažovala za výslovné oprávnění odeslat tento balíček do ChatGPT.
Test chování kandidáta proto neproběhl. Dlouhý rozhovor, skutečné ovládání
grafů a čtení instalované 0.3.0 zůstávají k ověření podle
[rozšířené sady](../scripts/tutor/smoke-prompts.md). Místní kontroly
archivu nepotvrzují chování modelu ani podporu vizualizací v klientu;
výsledky staršího vydání se na kandidáta nepřenášejí.

## 2026-11-02 — AI tutor 0.2.1: zahájení a aktivní učení

Realizace schváleného [R62](../docs/rozhodnuti/ai-tutor.md#r62-ai-tutor):
průvodce kapitolou, režimem a rozsahem, cílená pomoc se cvičením, řešení
na žádost a proaktivní interaktivní vizualizace. První výchozí prompt změněn,
další dva, identita, logo a přístup zachovány. Podrobnosti zkoušení a
vizualizací přesunuty do referencí; hlavní instrukce nepřesahují původní
rozsah. Zdrojový text knihy a rozsah přibalených kapitol se nemění.

Export zdrojové revize `27fd890672e792b7e5aa3bde76d665d571aa7c8c`
prošel kontrolou šesti kapitol, 417 přehledových položek, 1 426 matematických
zápisů, 97 obrázků, 72 řešení, 1 220 místních odkazů a 53 citací. Archiv
`output/tutor/statistika-pro-psychology-ai-tutor-0.2.1.zip` obsahuje 121 souborů;
SHA-256 je `bb8092feff7400e1d0e6bde0e2f3b36742b9649d100aec938c558fc14e3bcd71`.
Export použil nezměněné již vytvořené obrázky (`--skip-figures`), kontroloval
jejich skutečné soubory i návaznost na zdroje. Hlavní instrukce mají 12 256
bajtů normalizovaného UTF-8 proti původním 12 268. Kontrola autorských map
prošla bez chyby; GitHub CI revize `27fd890` rovněž uspěla.

Plugin Creator uložil verzi 0.2.1 do stejného soukromého osobního pluginu
`Plugin_f0a6ddcaadfc8191a5009ff162276308`, vydání
`pluginrel_6ae8edaa399c81919057a23708d5685b`. Následný inventář vrátil
121 souborů a zpětné čtení manifestu, hlavních instrukcí a čtyř změněných
referencí potvrdilo shodu s balíčkem. Logo a soukromý přístup se neměnily.

V nových chatech bez příloh a webu (ChatGPT Work v Brave, GPT-6.1 Sol,
střední uvažování) prošel postupný výběr kapitoly, všech čtyř režimů
a rozsahu, volba kapitoly podle tématu, režim „vyber za mě“, rozdělení celé
kapitoly na úseky, změna nastavení během chatu i přímý dotaz bez průvodce.
Zkoušení dodrželo dvě otázky a odložené hodnocení 3/4; sokratovská pomoc
rozpoznala chybný jmenovatel bez předčasného zveřejnění výsledku. Tutor
uzavřel téma shrnutím a po rozloučení pokračování nevynucoval.

Pomoc bez předchozího pokusu, vysvětlení zadání a úplné řešení na výslovnou
žádost ověřeny ve dvou nezávislých chatech na úloze 1 kapitoly 3. Správně
přijal alternativní výpočet a odlišil správnou aritmetiku od neodůvodněného
vyřazení hodnoty. Nejednoznačnou úlohu 4.3 upřesnil, neexistující úlohu 999
nevymyslel. U chybějících individuálních dat správně uvedl `Data!B2:B37`,
33 platných a tři chybějící údaje, vyžádal sešit nebo skutečný výpis
a nabídl doložený odkaz. Regresní sada 18 otázek ze začátku, středu a konce
šesti kapitol, všech tří přehledů a nepřibalené kapitoly 8 prošla proti
zdrojům. Statická náhrada byla výslovně označena a správně vysvětlila
odmocninový vztah SE.

Skutečné ovladače výběrového rozdělení v ChatGPT zobrazily pro n = 25,
100 a 400 hodnoty SE = 3; 1,5; 0,75 s; reset vrátil n = 100. Nezměnila
se populace ani osy. U síly oboustranného z-testu (σ = 15, n = 100,
α = 0,05) byly přes skutečný posuvník ověřeny Δ = 0 a ±6 a reset na 3.
Nezávislý R přepočet dává pravděpodobnost zamítnutí 0,05 při nule,
0,516005273976 při |Δ| = 3 a 0,979326631903 při |Δ| = 6. Zobrazené
hodnoty odpovídaly zaokrouhlení; kritické meze zůstaly 32,060 a 37,940 s.
Při nulovém účinku výstup správně použil α, nikoli chybu druhého druhu.

Korelační model fungoval v náhledu souboru vytvořeného tutorem přímo
v ChatGPT. Nezávislý Pearsonův výpočet ze souřadnic všech 100 vykreslených
SVG bodů (korelace je při těchto kladných lineárních změnách měřítek
nezměněna; směr svislé obrazovkové osy byl obrácen) potvrdil zobrazené r:
pro ρ = −0,8 vyšlo −0,8705265433, pro 0 vyšlo −0,1059123698 a pro 0,8
vyšlo 0,8412334476. Souřadnice X se při změně ρ zachovaly, samostatné
losování je změnilo a reset obnovil přesně původní body i ρ = 0,5.
Klávesnice ovládala posuvník, nové losování a reset. Výběrové rozdělení
šlo ovládat také přechodem Tab a potvrzením Enter. U obou náhledů byla
vizuálně i měřením šířek ověřena čitelnost panelu přibližně 320 px
bez vodorovného přetečení. Schopnost nastavit viewport v tomto spojení
Brave skutečnou šířku nezměnila; test se proto provedl klávesnicovým
zmenšením panelu přes dostupný oddělovač, nikoli domnělou emulací telefonu.

Omezení klienta: vložené vizualizace opakovaně selhávaly při inicializaci
sandboxu. První funkční výstupy výběrového rozdělení a síly měly slabý
kontrast v tmavém motivu. Tutor na žádost vytvořil samostatné HTML soubory
s výslovným bílým pozadím a tmavým textem; náhledy výběrového rozdělení
a korelace byly potom funkční a čitelné. První soubor síly zůstal při
načítání prázdný; nově vytvořený `sila-kontrola.html` se v náhledu ChatGPT
načetl a prošel všemi výše uvedenými numerickými stavy, resetem, ovládáním
klávesami Home/End a čitelností při šířce přibližně 320 px bez vodorovného
přetečení. Všechny tři scénáře tedy byly skutečně ovládány v cílovém klientu,
jejich první vygenerování však nebylo spolehlivé. Funkční náhled souboru
je ověřenou alternativou k problematickému vložení přímo mezi zprávy;
statická náhrada zůstává nutná v klientu bez vykonávání interaktivního obsahu.
Otevření staženého HTML přes místní URL odmítla bezpečnostní politika
prohlížečového nástroje; žádné obcházení tohoto omezení nebylo použito.
Nelze přisuzovat podporu interaktivity všem klientům či studentským účtům.

Cílové scénáře jsou v [testovací sadě](../scripts/tutor/smoke-prompts.md).
Místní přepisy testovacích chatů a výpočetní doklad korelace jsou
v ignorované složce `output/tutor/`. Jde o interní kontrolu chování,
nikoli pilot výukového přínosu na studentech.


## 2026-11-02 — Nahrávka k prezentaci kapitoly 6 hlasem Adam

Na následnou výslovnou žádost autora převeden hotový scénář snímků 1–31
pomocí Creative Claw, modelu `speech/heygen-voice-1`, veřejného českého
hlasu Adam, jazyka cs a rychlosti 1. Před převodem ověřeny aktuální
parametry služby. Limit 5 000 znaků vyžadoval deset částí; jejich text
je shodný se scénářem včetně výslovnostních přepisů. Části spojeny
bez prolínání přes mezivýstupy WAV, finální MP3 má 46:07 a 31 značek
kapitol podle skutečných časů. Soubor
`presentations/kapitola_06_vyberove_rozdeleni_a_testovani_Adam.mp3`
zůstává místní a ignorovaný Gitem.

[Průvodní dokument](../presentations/kapitola_06_vyberove_rozdeleni_a_testovani_scenar_podklady.md)
a [manifest](../presentations/kapitola_06_vyberove_rozdeleni_a_testovani_scenar_manifest.json)
zachycují parametry, identitu výstupu, časové značky a ověření.
Všechny části i celý MP3 se úspěšně dekódují, délka odpovídá součtu
částí, pořadí ověřeno také porovnáním průběhu zvuku z každé části
s příslušným místem celku. Hlasitost částí je vyrovnaná, detektor
nenašel ticho delší než dvě sekundy při prahu −50 dB. Skutečný poslech
nebyl proveden; technické kontroly nepotvrzují výslovnost. Scénář,
prezentace, kapitola ani sešity se při převodu neměnily.

## 2026-11-02 — Scénář k prezentaci kapitoly 6

Připraven [souvislý scénář pro syntézu řeči](../presentations/kapitola_06_vyberove_rozdeleni_a_testovani_scenar.txt)
pro výkladové snímky 1–31 aktuální prezentace. Má 5 714 slov; samostatné
procvičování na snímcích 32–38, diskusní otázky a organizační pokyny
neobsahuje. Vychází z aktuálního místního PPTX včetně autorových úprav,
které autor výslovně povolil zahrnout do společného commitu; PPTX nebylo
při tvorbě scénáře přepisováno. Výslovnostní přepisy podle R53 jsou přímo
v textu, například „statystycký“, „alternatyvní“, „medyán“ a „kvantyly“.
Kanonický odborný zápis kapitoly ani terminologický registr se nemění.

[Průvodní dokument](../presentations/kapitola_06_vyberove_rozdeleni_a_testovani_scenar_podklady.md)
obsahuje slovník výslovnosti, podklady a omezení kontrol;
[manifest](../presentations/kapitola_06_vyberove_rozdeleni_a_testovani_scenar_manifest.json)
eviduje SHA-256, přiřazení úseků ke snímkům a číselné kontroly.
Ověřeno pořadí a pokrytí 31 snímků, slovní zápis čísel a značek,
nepřítomnost původních rizikových základů a zbývající měkké skupiny
di/ti/ni v kontextu. Nezávisle přepočteny směrodatné chyby, normální
a binomické pravděpodobnosti, kritické hodnoty, statistická síla
a souběh dvaceti nezávislých testů. Prohlédnuto všech 12 vložených grafů
a diagramů; simulace nebyly znovu spuštěny. Interní didaktická revize
se soustředila na rozlišení studie, modelu a simulace a na interpretaci
testu. Celá sazba v PowerPointu, desktopový Excel ani porozumění
na studentech se znovu neověřovaly. Nahrávka se nevytvářela.

<a id="prezentace-kapitoly-6-20261102"></a>

## 2026-11-02 — Prezentace ke kapitole 6

Vytvořeny soubory v `presentations/`: `kapitola_06_vyberove_rozdeleni_a_testovani.pptx`
(38 slidů), `kapitola_06_poznamky.docx` a
`kapitola_06_vyberove_rozdeleni_a_testovani_cviceni.xlsx`. Rozsah dohodnut s autorem
2026-11-02: jedna výuka za celou kapitolu (45 minut výkladu, 45 minut procvičování),
výběr toho podstatného pro porozumění výběrovému rozdělení a principu testování
hypotéz, všechna nepovinná rozšíření vynechána; výstupy PPTX, DOCX a sešit, bez PDF.
Výklad má 23 obsahových slidů v šesti oddílech podle
[R50](../docs/rozhodnuti/postupy-a-dokumentace.md#r50-struktura-prezentaci).
Vynechány byly také oddíly o malých skupinách (trychtýř), o výběrových rozděleních
mediánu a směrodatné odchylky a o mezích simulace; binomický test a z-test jsou
shrnuty na jednom srovnávacím slidu. Pět úloh bez Excelu (řešení jen v poznámkách):
adaptace Howella (4.2–4.6; 4.10–4.11, 4.15 a 7.4–7.5; 4.17 a 4.23; 4.16 s doplněním)
a vlastní úloha na chybné výroky. Doprovodný sešit podle
[R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-excelova-cviceni-prezentaci)
má čtyři listy (U1_cislice: úlohy 7.1–7.3 s grafem rozdělení průměrů; U2_prumer:
4.7–4.9 s doplněným průměrem skupiny; U3_binom_test: 4.27 přesným binomickým
výpočtem; U4_z_test: vlastní modelový z-test pro dvě velikosti výběru), řešení po
krocích, 11 kontrol funkcemi a 14 nativních rovnic. Rozsah čtení Howella eviduje
[karta U01](../docs/zdroje/U01-howell.md#u01). Kapitola 6, slovník, osnova ani
`data/kapitola_06.xlsx` se neměnily; věcný rozpor mezi kapitolou a prezentací nebyl
zjištěn. Všech 12 obrázků jsou obrázky kapitoly 6 z `assets/chapter-06/plots/`
(vlastní tvorba), jeden rozdělený na dva slidy.

Při přípravě zjištěny dvě drobnosti v kapitole 6 (neopraveno, mimo rozsah úkolu):
úvodní blok uvádí „Pět nepovinných rozšíření“, kapitola jich má sedm; ve čtvrté
odrážce Shrnutí stojí „s využitím normálního modelem“.

Postup: generátor v `tmp/chapter06-presentation/` navazuje na generátor kapitoly 5
(stejná předloha a vzhled; nové vzorce σ_m a standardizace průměru, ořez jednoho
dvoudílného obrázku). Sdílené skripty v `scripts/` se neměnily.

**Ověření:** všech 38 slidů vykresleno v PowerPointu a prohlédnuto (po opravě
dolního indexu uvnitř tučného textu, zalomení tabulky a sjednocení kurzivy *n*,
*m*, *s*, *z*, *X*); každý slide má poznámky, u výkladových slidů s otázkou
k zamyšlení, a jazyk textů i poznámek je čeština (objektový model PowerPointu).
83 čísel ze slidů, poznámek a sešitu přepočítáno nezávisle v R (`check.R` v tmp).
Sešit přepočítán v českém Excelu 16: 0 chybových buněk, všech 11 kontrol „Shoda
s kroky“ = ano, 14 rovnic, jeden graf, prázdné pracovní buňky; listy prohlédnuty
z exportu do PDF. DOCX otevřen ve Wordu: 38 nadpisů „Slide N: titulek“, 20 stran.
Data úloh 7.1–7.2 a zadání 4.27 ověřena v obraze stran 221–222 a 106.

**Omezení:** výklad trvá podle součtu časů 45 minut, skutečná délka nebyla
vyzkoušena; látka je rozsáhlá, a proto je řada slidů počítána na 1–2 minuty.
Popisky uvnitř převzatých grafů (zejména síla a standardizované průměry) jsou při
projekci drobné; hlavní hodnoty opakuje text slidu. Starší verze Excelu
a PowerPointu, Excel pro Mac ani webový Excel nebyly zkoušeny. Didaktická revize
byla interní, bez ověření na studentech. Studentský web se nemění, render knihy
nebyl potřeba.

## 2026-11-02 — Podklady kapitol 1–6 v AI tutorovi

Na výslovně schválený plán navazuje zdroj soukromého pluginu ve verzi 0.2.0
v plugins/statistika-pro-psychology-ai-tutor/ a samostatný opakovatelný export.
[Příkazy a postup](../docs/PROVOZ.md#export-ai-tutora) jsou v provozní dokumentaci.
Balíček přebírá úvod, úplné kapitoly 1–6 se zadáními, řešeními i nepovinnými
rozšířeními, celé aktuální přehledy (včetně hesel kapitol 7–8), citovanou
literaturu, obrázky a jejich textové popisy. Úplný výklad kapitol 7–8 nepřibaluje;
sešity a odkazy na tyto kapitoly vedou na web. Zdrojové kapitoly se nemění.
Instrukce, metadata a logo mají hlavní zdroj v repozitáři; generované kopie
textů, registr, index a ZIP zůstávají v ignorovaném výstupu.

**Kontroly převodu:** všech 417 hesel (278 slovníčku, 102 značení, 37 Excelu),
1 426 původních matematických výrazů v kapitolách, 97 obrázků s viditelným
textovým popisem a zachovanými soubory, všech 72 řešení a 53 citovaných
bibliografických položek. Ověřeno 1 218 místních odkazů; obsah všech 119
souborů archivu byl nezávisle přečten přes .NET a porovnán otisky s ověřeným
sestavením. Zachovány odstavce a buňky tabulek, inline kód včetně dolarových
znaků Excelu, ID a původ obrázku Cmglee. Kontrola při vývoji zachytila
opakovaná ID mezi různými stránkami, změny českých uvozovek v Markdown writeru,
potlačenou bibliografii a obrázky převáděné na raw HTML; převod je nyní řeší.
Obrázky 1–6 byly znovu vytvořeny jejich existujícími generátory; textové
popisy a popisky byly přečteny z hlediska zachování informace při exportu.
Nejde o novou odbornou nebo číselnou revizi knihy, spuštění Excelu ani
ověření porozumění na studentech.

**Cloud a cílový klient:** do stejného soukromého cloudového pluginu
`Plugin_f0a6ddcaadfc8191a5009ff162276308` byla nahrána a v seznamu i nastavení
ověřena verze 0.2.0. Archiv je snímkem revize
`a0eb8540a38f4ad1ca30054bfc5757b49869374d` s čistými vstupy; SHA-256 ZIPu
je `379a35c6e1f544855012e38f24df2fd081ad2c1ba70a73049a952d19de128ef2`.
Přístup, identita a výchozí prompty se neměnily.

V novém chatu ChatGPT na webu v Brave, v režimu Work s GPT-6.1 Sol
(střední uvažování), bez příloh a bez webového vyhledávání, tutor načetl
index i registr a správně uvedl revizi. Prošlo všech 18 obsahových kontrol
ze začátku, středu a konce kapitol podle
[scénářů](../scripts/tutor/smoke-prompts.md), včetně konkrétních hodnot,
zadání, řešení a existujících ID oddílů. Prošly také tři přehledy:
`pojem-smerodatna-chyba`, `znak-t-kvantil` a přesný příklad `excel-countifs`
včetně absolutních odkazů a výsledku. Na požadavek přesného zadání úlohy 5
z kapitoly 8 tutor přiznal chybějící úplnou kapitolu a obsah nevymyslel.
Prošly všechny čtyři pedagogické režimy. Vysvětlování rozdílu SD a SE
zachovalo podmínky vztahu i odkaz na oddíl. Sokratovské vedení položilo
jedinou otázku a při chybném dělení čtyřmi navedlo na počet pěti hodnot,
aniž předem sdělilo průměr. Procvičování označilo vlastní úlohu, počkalo
na pokus a poté oddělilo správný postup od chyby `30/5 = 5`; oprava
byla 6 slov, medián zůstal 6. Zkoušení předem vymezilo dvě otázky
a kritéria 0–2, po první odpovědi ještě nehodnotilo, teprve po druhé
přidělilo 2 a 1 bod, správně celkem 3/4. Zachytilo chybný pokles SE
na 0,25 a opravilo jej na 0,5 při čtyřnásobném výběru. Záznam tohoto
interního testu je místně v ignorovaném `output/tutor/chatgpt-overeni.txt`.

**Pozorovaná omezení klienta:** nahrání přes rozšíření Brave vyžadovalo
uživatelovo povolení přístupu k místním souborům. Webový seznam zobrazuje
obecnou ikonu pluginu, přestože vlastní PNG a oba odkazy na něj zůstaly
v balíčku beze změny. Stažení uloženého ZIPu přes ovládání prohlížeče
nevrátilo soubor; uložení a čtení se proto dokládá potvrzením nahrání,
verzí 0.2.0 v rozhraní a skutečným načtením konkrétních podkladů v chatu.
Jde o interní zkoušku jednoho klienta a účtu, nikoli studentský pilot nebo
ověření dostupnosti na jiných tarifech.

## 2026-11-02 — Souhrnné pracovní PDF kapitol 1–6

Na žádost autora přibyl ruční export jednoho PDF: úvod, kapitoly 1–6,
literatura a tři přehledy. Podle autorovy volby přehledy obsahují jen řádky
vysvětlené v kapitolách 1–6 (vynecháno 29 řádků slovníčku, 12 značení
a 8 funkcí Excelu) a literatura jen zdroje citované v těchto kapitolách.
Nový skript `scripts/render-book-pdf.ps1` s filtrem `scripts/pdf/book.lua`
(postup v [PROVOZ.md](../docs/PROVOZ.md#ruční-pdf-kapitol-16)). Filtr nově
rozpoznává i cvičení ve tvaru „Úloha N:“ (kapitoly 1–2) a převádí HTML
tabulky přehledů na tabulky Typstu. Hledání programů a dodatečné
typografické úpravy Typstu jsou nově ve sdíleném `scripts/pdf/common.ps1`;
z `layout.typ` se oddělila kapitolová část `chapter-page.typ`. Studentský
text, web, data ani sešity se neměnily; PDF přeformuluje jen několik vět
o ovládání webu.

**Kontroly:** PDF sestaveno (277 stran). `check-book-pdf.cjs` prošel
(72 řešení na správných místech, 428 cílů odkazů, přehledy jen pro kapitoly
1–6). Kontrola při vývoji odhalila, že filtr vypouštěl i dva odstavce
kapitoly 6 odkazující na kapitolu 7; opraveno a kontrola to nyní hlídá.
V PDF je 1 243 vnitřních odkazů a žádný nefunkční; webové odkazy vedou jen
na kapitoly 7–8, vynechané řádky, sešity a vnější zdroje. Obrázky
i tabulky jsou číslované souvisle po kapitolách a jejich počty odpovídají
zdrojům. `check-rendered-pdf.py` (nově i pro souhrnné PDF: 8 poznámek
10 pt, šedé linky) a `check-pdf-typography.cjs` prošly. Regrese: PDF
kapitoly 4 po refaktoringu znovu sestaveno, `check-chapter-pdf.cjs --chapter 4`
prošel a text všech 38 stran je shodný s předchozím exportem.
**Omezení:** vizuálně prohlédnuto jen 14 vybraných stran (titul a obsah,
úvod, začátky kapitol 1, 4 a 6, grafy, tabulky, řešení kapitol 1 a 6,
literatura a po jedné straně tří přehledů); ostatní strany pouze kontrolou textu
a odkazů. PDF ostatních kapitol nebylo znovu exportováno. V řešeních
kapitoly 6 se vnořené seznamy sázejí jako „a) a)“ stejně jako v PDF
samotné kapitoly; nebylo řešeno. Typst hlásí 57 varování o zastaralém
symbolu `sect` (stejně jako v dosavadních PDF).

## 2026-11-01 — PDF kapitoly 7 a oprava matematické sazby v PDF

Ruční export a kontroly rozšířeny na kapitolu 7. PDF má 29 stran: zadání
na stranách 19–23, řešení od strany 24 a literaturu na straně 29. Všech
29 stran prohlédnuto. Kontrola transformace nově čeká v kapitole 6 správně
16 řešení (nepovinná cvičení 15 a 16 podle R57).

Při prohlídce se ukázalo, že Typst zachovává mezeru vedle textových čísel
`upright(…)`, která Pandoc vkládá. Ve všech PDF se tak sázelo „= − 1,5“,
„49,92 .“, „(48,5 − 47)/ 0,5“, „*p* -hodnota“ a „| t |“. Opraveno pouze
v PDF převodu (`scripts/pdf/typography.lua`, `render-chapter-pdf.ps1`):
unární minus a koncová tečka se spojují s číslem, mezera u lomítka se
odstraňuje, popisek *p*-hodnota se spojuje a |t| se zapisuje jako absolutní
hodnota. Binární minus zůstává operátorem. Titulky rozbalovacích bloků se
v PDF nově čtou jako Markdown (dříve doslovné „\*p\*“). Tabulky 7.2 a 7.3
mají v PDF šířky sloupců podle obsahu místo stejných; web se nemění.

**Kontroly:** PDF kapitol 3–7 znovu sestavena (50/38/43/57/29 stran).
`check-chapter-pdf.cjs` prošel pro 3–7 (15/10/12/16/14 řešení),
`check-pdf-typography.cjs` s novými případy (unární a binární minus,
koncová tečka). `check-rendered-pdf.py` nejprve selhal u kapitoly 6:
poznámka pod tabulkou `tbl-k06-25` nezačínala „*Poznámka.*“ jako ostatní
poznámky. Na pokyn autora úvod doplněn; po novém sestavení PDF a webové
stránky kapitoly 6 kontrola prošla pro všech pět kapitol a úvod se
zobrazuje i ve vykresleném HTML.
Vizuálně prohlédnuta celá kapitola 7 a namátkou dotčené strany kapitol 3
a 4. Text grafů je v PDF v pořádku: ověřeno vykreslením SVG Typstem, starší
`pdftoppm` z MiKTeXu jej zobrazuje poškozeně. Kromě úvodu jedné poznámky
v kapitole 6 se text kapitol, výpočty, data ani sešity neměnily; vykreslena
byla jen webová stránka kapitoly 6, ne celá kniha.

<a id="revize-07-20261101"></a>

## 2026-11-01 — Kapitola 7: opravy po komplexní revizi

Po autorově schválení osmi nálezů zpřesněno pokrytí jako podíl intervalů,
závislost kritického průměru na výběrové s, plynulá slučitelnost hodnot
u mezí intervalu a podmínka zanedbání nejistoty normy vzhledem k nejistotě
nového odhadu. Doplněn odkaz na dva nezávislé výběry v kapitole 8.
Řešení 2b již neodvozuje šířku rozmezí jednotlivců ze samotného intervalu
průměru; řešení 14c připouští přesný dotyk podle platného p ≤ α.
Slovníček a přehled značení výslovně podmiňují t-rozdělení hodnotou μ = μ₀
a nezávislým výběrem z normální populace. Rozsah R44–R46 se nemění.

Generátor sešitu upravuje pouze formát `Ekvivalence!B25`: malá kladná
p-hodnota se zobrazuje jako „< 0,001“. Číselná hodnota zůstává zachována
pro MAX. Doplněna skutečná kontrola zobrazení i kladné číselné hodnoty
v českém Excelu. Po reprodukovatelném sestavení porovnány všechny listy,
hodnoty, vzorce, datové typy a chybění s předchozím sešitem: shodují se.
Prošla kontrola R, 53 českých vzorců, přepočet a devět hraničních rozhodnutí
v Excelu 16.0 i společná kontrola vzorců sešitů 1–8. Nativní náhled
opraveného listu byl vizuálně zkontrolován.

Při předchozí revizi přečtena celá kapitola včetně všech čtrnácti řešení,
prohlédnuto osm obrázků, pět tabulek a nativní náhledy devatenácti listů
(u simulace začátek, všech 800 čísel přitom porovnáno s novým výpočtem).
Citované pasáže ověřeny v Howellovi a článcích Lakense (2017) a Lakense
et al. (2018); vybrané pasáže Cumminga a Calin-Jagemana použity ke srovnání
didaktiky. Přepočet 56 hodnot Howellovy tabulky 7.1 potvrdil výsledek PDI;
nejde o reprodukci původní studie Nurcomba et al., jejíž úplný článek
a původní výzkumná dokumentace nebyly ověřeny. Interní didaktická revize
nenahrazuje ověření porozumění na studentech. Jiné verze Excelu, skutečný
telefon, veřejné nasazení a pracovní PDF kapitoly nebyly kontrolovány.

Následně prošel úplný render v Quartu 1.9.38 a kontrola HTML všech třinácti
stránek (odkazy, přehledy, sto řešení v celé knize, klávesnice, skrytí
a rozbalení, mobilní šířka 390 px). Po závěrečném zpřesnění formulace
kritické meze znovu vykreslena kapitola 7. Jejích pět tabulek je bez
přetékání a drobných přesahů při šířkách 390, 1024, 1280, 1360, 1440
a 1920 px. Vizuálně zkontrolována dotčená část výkladu a opravený list.
Audit tabulek celé knihy nadále zaznamenává dřívější místní přesahy
v kapitolách 6 a 8, včetně 19 px u `tbl-k08-07` při 1280 px; nejde o nález
v kapitole 7. Prošla kontrola odkazů autorské dokumentace včetně místních
podkladů. Veřejné nasazení ani GitHub CI nejsou těmito lokálními kontrolami
ověřeny.

## 2026-10-31 — Kvantily v Q–Q grafech kapitoly 4

Na žádost autora v oddílu [Jak číst odchylky od přímky](kapitola_04.qmd#sec-qq-odchylky)
zvýrazněna v šesti Q–Q grafech (`scripts/kapitola_04.R`, smyčka `diagnostika-*`)
pozorování u 1. a 99. (fialově), 25. a 75. (zeleně) a 50. percentilu (žlutě).
Při n = 200 leží každý percentil mezi dvěma sousedními pořadími; tytéž dvojice
ohraničují i `PERCENTIL.INC`, proto jsou zvýrazněny obě. Ostatní body jsou
tlumeně modré, legenda je u zešikmení doleva vpravo dole. Text vysvětluje dvojice
bodů, `fig-alt` popisují polohu barevných bodů. Na konec oddílu přidána
[tabulka](kapitola_04.qmd#tbl-qq-kvantily-04) empirických a modelových kvantilů
s řádkem rozdílu data − model; buňky rozdílu jsou podbarveny modře (kladný)
a červeně (záporný) se sytostí 0,55 · |rozdíl| / 17,78 (styl `.qq-rozdil`
v `assets/styles.css`), evidováno jako upřesnění
[R54](../docs/rozhodnuti/spolecne-konvence.md#r54-sazba-tabulek-pdf).

Ověření: kvantily, rozdíly a sytosti spočítány v R (`quantile(type = 7)`,
`qnorm`) nezávisle na textu; čísla v odstavcích se shodují. Vizuálně
prohlédnuto všech šest SVG a tabulka ve webu na šířce 1280 a 375 px (barva
vyplňuje buňky, stránka nepřetéká, tabulka se posouvá místně). Render kapitoly
bez varování. Neověřeno: pracovní PDF (barvy rozdílů se v něm zatím
nepřenášejí) a výpočet kvantilů v Excelu (vzorce jsou beze změny; změnu listu `Sim_chvosty` popisuje doplněk).

Doplněk téhož dne: soubor s těžšími chvosty ukazoval v tabulce kvantilů
těžký chvost jen nahoře (rozdíl u 1. percentilu +0,4). Na pokyn autora nahrazen
jiným výběrem z téhož modelu, 50 + 8·t se 3 stupni volnosti, seed 20263319
(vybráno prohledáním 3 000 semínek podle souměrnosti a záporného rozdílu u 1.
a kladného u 99. percentilu). Ostatní simulace se nemění, nový výběr se tvoří
až po nich. Nové hodnoty: 1. percentil 15,1 vs. model 22,0, 99. percentil 87,8
vs. 79,9, kvartily 45,4 a 56,6 vs. 42,5 a 59,3; SKEW 0,01, KURT 3,23.
Upraven odstavec, `fig-alt`, obě tabulky a věta o nestálosti excesu (pro t3
a n = 200 je 10. percentil excesu ≈ 2,2, 90. percentil ≈ 26,6, proto
„znatelně nižší, ale také několikanásobně vyšší“). Kontroly
`check-chapter-04.R` a `check-chapter-04-excel.ps1` aktualizovány a prošly;
sešit přestavěn `build-workbooks.ps1 -Chapter 4 -Verify`. Prezentace viz další odstavec.

Na pokyn autora následně upravena prezentace kapitoly 4: ve snímku 30 vyměněn
obrázek (původní styl bez barevných kvantilů jako u ostatních diagnostických
snímků; převod SVG → PNG týmž postupem: sharp, 220 dpi, pozadí #FAFAF7)
a v jeho poznámkách exces 3,23 a nové percentily. Ostatní obsah PPTX beze změny.
DOCX poznámek (dříve uložený ve Wordu) upraven jen v týchž dvou větách,
nepřegenerován. PDF exportováno PowerPointem (dříve Acrobat PDFMaker):
41 stran, text shodný až na čitelný text rovnic, vizuálně porovnána stránka
s rovnicí. Snímky 29–31 vykresleny a prohlédnuty v PowerPointu. Neaktualizováno:
místní nahrávka `kapitola_04_normalni_rozdeleni_Adam.mp3` stále uvádí původní
čísla (exces 5,01; 99. percentil 79,9 vs. 88,6); syntéza nebyla spuštěna.

## 2026-10-28 — Výslovnostní přepisy bez podmínky nedostupného poslechu

Na autorovo upřesnění upraven [TEXT2SPEECH.md](../docs/TEXT2SPEECH.md):
tvrdě vyslovované skupiny di/ti/ni v cizích a odborných výrazech se
ve scénáři přepisují dy/ty/ny, při zachování délky samohlásek a příslušných
tvarů slov. Autorem požadované přepisy jsou závazné; „kvantyly“ již není
pouhým kandidátem. Před syntézou se kontroluje slovník a zbylé původní
rizikové podoby, vedle čísel a matematických značek.

Odstraněn postup vyžadující poslechovou kontrolu a reprezentativní ukázku
jako předpoklad dlouhého převodu, když takovou kontrolu prostředí neumí.
Zůstává rozlišení textové a technické kontroly od skutečně doloženého
poslechu; ukázky se nevytvářejí automaticky. Upřesnění připojeno
k [R53](../docs/rozhodnuti/postupy-a-dokumentace.md#r53-doprovodne-audio),
původní datovaný doklad zachován a v registru aktualizována platnost.
Tento krok upravuje pouze pravidla a jejich evidenci; existující scénář
ani nahrávka se nepřepisovaly a syntéza nebyla spuštěna.

Ověření: redakční kontrola všech navazujících pokynů pro výslovnost,
ukázky a předání, `git diff --check` a `node scripts/check-doc-maps.cjs`
bez chyb (73 mapových souborů, 53 rozhodnutí).

## 2026-10-27 — Nahrávka prezentace kapitoly 5 hlasem Adam

Na následnou výslovnou žádost autora převeden celý připravený scénář
pro snímky 1–35 pomocí Creative Claw, model `speech/heygen-voice-1`,
český hlas Adam, rychlost 1. Předem načteny aktuální parametry a ověřeno
ID hlasu v rozšířeném katalogu. Limit 5 000 znaků vyžadoval deset úseků
na hranicích snímků; každý byl vytvořen jednou, bez krácení textu.
Služba vykázala 806 kreditů za syntézu.

Místní výstup `presentations/kapitola_05_pravdepodobnost_Adam.mp3`
má 51:15,63 a 35 značek snímků ID3 CHAP/CTOC. Části byly spojeny
FFmpeg bez dalšího ztrátového kódování nebo překryvu řeči. Soubor zůstává
ignorovaný Gitem, není publikován na webu. Přesné délky, mapování časů,
otisk výsledku a kontroly jsou v
[manifestu](../presentations/kapitola_05_pravdepodobnost_scenar_manifest.json),
postup a omezení v
[průvodním dokumentu](../presentations/kapitola_05_pravdepodobnost_scenar_podklady.md).
Identifikátory úloh a pracovní zvukové soubory jsou uchovány v `tmp/`.

Ověření: původní podklady i scénář mají shodné otisky; poskytovatelem
vrácené časované tokeny pokrývají scénář a všech 35 oznámení; součet délek
částí souhlasí s výsledkem; celé MP3 prošlo dekódováním bez chyby,
průměrná úroveň −17,7 dB, bez tich delších než 3 s při prahu −45 dB.
Neproběhl skutečný poslech ani nezávislý automatický přepis; správnost
výslovnosti se tím nedokládá. Učebnice a PPTX se neupravovaly.

## 2026-10-27 — Scénář k výkladové části prezentace kapitoly 5

Na výslovnou žádost autora připraven
[mluvený scénář v UTF-8](../presentations/kapitola_05_pravdepodobnost_scenar.txt)
pro snímky 1–35 aktuálního PPTX, včetně předělů a řešených příkladů.
Samostatné procvičování na snímcích 36–43 a diskusní otázky v poznámkách
nejsou zahrnuty, podle [pravidel scénářů](../docs/TEXT2SPEECH.md).
Text má 5 708 slov; čísla, značky a vzorce jsou přepsány pro poslech.
Průběžně pojmenovává osy a relevantní části grafů, vysvětluje celek
při podmínění, předpoklady modelů a význam výsledků.

[Průvodní dokument](../presentations/kapitola_05_pravdepodobnost_scenar_podklady.md)
obsahuje rozsah, omezení kontroly a jediný slovník výslovnosti projektu
této nahrávky; [manifest](../presentations/kapitola_05_pravdepodobnost_scenar_manifest.json)
uchovává otisky podkladů a scénáře, přiřazení 35 úseků k titulům snímků,
počty slov a nezávisle přepočtené hodnoty.

Ověření: načtení textu, tabulek a poznámek PPTX, vizuální prohlídka
13 vložených obrázků, porovnání relevantního výkladu s kapitolou,
kontrola číslování a mluveného zápisu, nezávislé číselné přepočty
a interní didaktická revize. `git diff --check` a kontrola map
`node scripts/check-doc-maps.cjs` bez chyb (73 mapových souborů,
53 rozhodnutí). Syntéza nebyla spuštěna; výslovnost a tempo
nejsou poslechem ověřeny. Původní prezentace, kapitola a sešity beze změny.

## 2026-10-27 — Instrukce pro scénáře a doprovodné audio

Přidán [TEXT2SPEECH.md](../docs/TEXT2SPEECH.md) jako hlavní místo postupu
pro výklad k prezentacím: mluvený zápis čísel a značek, stručné čtení
funkcí Excelu, spojovníky, slovník výslovnosti s rozlišením kandidátních
a poslechem ověřených přepisů, kontrola před placenou syntézou, obnova
úloh bez duplicit, cílené opravy a jeden výsledný MP3. AGENTS.md obsahuje
stručný odkaz a výslovné vyžádání scénáře i audia; požadavek na samotný
text nespouští placený převod. Doplněn autorský rozcestník a doklad
[R53](../docs/rozhodnuti/postupy-a-dokumentace.md#r53-doprovodne-audio).
Kapitoly, prezentace, scénáře ani nahrávky se při této změně neupravovaly.

Ověření: redakční kontrola obsahu a rozdílů, návaznosti a relativních
odkazů nových instrukcí; `git diff --check` a `node scripts/check-doc-maps.cjs`
bez chyb (53 rozhodnutí). Neproběhla syntéza ani poslech; „kvantyly“
zůstává kandidátní zápis.

<a id="prezentace-kapitoly-5-20261027"></a>

## 2026-10-27 — Prezentace ke kapitole 5

Vytvořeny soubory v `presentations/`: `kapitola_05_pravdepodobnost.pptx`
(43 slidů), `kapitola_05_poznamky.docx` a
`kapitola_05_pravdepodobnost_cviceni.xlsx`. Rozsah dohodnut s autorem:
jedna výuka za celou kapitolu, 27 výkladových slidů (45 minut) v šesti
tematických oddílech a procvičování (45 minut); výstupy PPTX, sešit a DOCX,
bez PDF. Nepovinná rozšíření kapitoly (kruhovost klasického pojetí, šance,
výpočet μ a σ z tabulky, variace) vynechána. Podle
[R50](../docs/rozhodnuti/postupy-a-dokumentace.md#r50-struktura-prezentaci)
je 2. slide přehled obsahu, oddíly oddělují slidy s jejich názvy a nadpisy
v DOCX mají tvar „Slide N: titulek“. Šest úloh bez Excelu (řešení jen
v poznámkách): adaptace Howella (5.1 a 5.35; 5.2–5.5; 5.8–5.9; 5.26, 5.27
a 5.30, u 5.27 bez pořadí; s. 132–135) a vlastní úlohy na chyby úsudku
a předpoklady binomického modelu. Doprovodný sešit podle
[R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-excelova-cviceni-prezentaci)
má pět listů (U1 modelová kontingenční tabulka; U2 úlohy 5.36–5.38; U3
5.21–5.23 se sloupcovým grafem; U4 5.31; U5 5.33 bez rozhodování
o hypotéze), řešení po krocích s pomocnou binomickou tabulkou, kontroly
funkcemi BINOM.DIST, BINOM.DIST.RANGE, BINOM.INV a NORM.DIST a 17 nativních
rovnic. Rozsah čtení Howella eviduje
[karta U01](../docs/zdroje/U01-howell.md#u01). Kapitola 5, slovník, osnova
ani `data/kapitola_05.xlsx` se neměnily; věcný rozpor mezi kapitolou
a prezentací nebyl zjištěn. Všech 13 obrázků prezentace jsou obrázky
kapitoly 5 z `assets/chapter-05/plots/` (vlastní tvorba).

Postup: generátor v `tmp/chapter05-presentation/` navazuje na generátor
kapitoly 4 (stejná předloha a vzhled). Nově umí rovnice pravděpodobnosti
s kombinačním číslem, menší písmo a mezery na slidech s obrázkem pod textem
(větší obrázky), horní indexy v poznámkách jako znaky Unicode a v sešitu
osu sloupcového grafu s desetinnými čísly. Sdílené skripty v `scripts/`
se neměnily.

**Ověření:** všech 43 slidů vykresleno v PowerPointu a prohlédnuto (po
opravě dvou zalomených titulků, kurzívy uvnitř tučného textu a zvětšení
obrázků); každý slide má poznámky, u výkladových slidů s otázkou k zamyšlení,
a jazyk textů i poznámek je čeština (objektový model PowerPointu). 62 čísel
ze slidů, poznámek a sešitu přepočítáno nezávisle v R (`check.R` v tmp).
Sešit přepočítán v českém Excelu 16: 0 chybových buněk, všech 17 kontrol
„Shoda s kroky“ = ano, 17 rovnic se zónou rovnice, jeden graf, prázdné
pracovní buňky; listy prohlédnuty z exportu do PDF. DOCX otevřen ve Wordu:
43 nadpisů „Slide N: titulek“, 20 stran. Zadání 5.35–5.38 ověřeno v obraze
strany 135.

**Omezení:** výklad trvá podle součtu časů 45 minut, skutečná délka nebyla
vyzkoušena; látka kapitoly je rozsáhlá, proto jsou některé slidy počítány
na 1 minutu. Čísla úlohy 5.36 (mamografie) jsou Howellova učebnicová
ilustrace, ne současné údaje. Starší verze Excelu a PowerPointu, Excel pro
Mac ani webový Excel nebyly zkoušeny. Didaktická revize byla interní, bez
ověření na studentech. Studentský web se nemění, render knihy nebyl potřeba.

<a id="licence-20261025"></a>

## 2026-10-25 — Licence CC BY 4.0 pro obsah a MIT pro kód

Na žádost autora nahrazena dosavadní licence MIT pro celý repozitář
rozdělenou licencí podle [R51](../docs/rozhodnuti/postupy-a-dokumentace.md#r51-licence).
Uspořádání podle vzoru R101-textbook: `LICENSE` ponechává původní text
MIT pro kód, nový [LICENSE-TEXT.md](../LICENSE-TEXT.md) je český text
licence CC BY 4.0 pro obsah se vzorem uvedení původu a odkazy na české
i anglické závazné znění. Proti R101 spadají pod CC BY 4.0 i datové
sešity (data jsou vlastní). LICENSE-TEXT.md udržuje také seznam výjimek
(citační styl `styles/apa.csl` a obrázek Cmglee, obojí CC BY-SA 3.0;
citovaná literatura). Oddíl [Licence](../README.md#licence) kořenového
README na něj odkazuje; patička každé stránky webu uvádí autora a odkazy
na `LICENSE-TEXT.md` a `LICENSE`. Dočasná podoba v PR (plné anglické
znění v `LICENSE`, MIT v `LICENSE-CODE`) byla před sloučením nahrazena.

**Ověření:** celá kniha se vykreslila bez chyb; `check-html.cjs`
bez chyb; patička vizuálně zkontrolována na šířce 1280 a 375 px bez
vodorovného přetékání; `check-doc-maps.cjs` bez chyb; odkazy na znění
licencí na creativecommons.org vracejí HTTP 200. Rozpoznání licence MIT
GitHubem lze ověřit až po sloučení do `main`. **Neověřeno:**
původ obrázků vložených v prezentacích kapitol 2–4 (16, 13 a 19 médií)
nebyl jednotlivě prověřen; snímky neuvádějí cizí zdroj ani licenci, proto
se předpokládá vlastní tvorba. Případné cizí obrázky by spadaly pod
obecnou výjimku pro materiály třetích stran a bylo by třeba je doplnit
do seznamu výjimek. Nejde o právní posouzení.

<a id="kapitola-05-kruh-20261024"></a>

## 2026-10-24 — Kapitola 5: nepovinné rozšíření o kruhovosti klasického pojetí

Na žádost autora doplněno sbalené rozšíření `#rozsireni-klasicke-pojeti`
na konec oddílu [Jev a jeho pravděpodobnost](kapitola_05.qmd#sec-jev).
Odpovídá na otázku, zda klasické pojetí nedefinuje pravděpodobnost kruhem:
klasický podíl je výpočet uvnitř modelu se stejně pravděpodobnými výsledky,
stejnou pravděpodobnost zdůvodňuje souměrnost postupu (ověřitelná četnostmi)
nebo nedostatek důvodů (závislý na členění výsledků). Úvodní blok kapitoly
nově uvádí čtyři nepovinná rozšíření; karta kapitoly doplněna. Nezavedeny
nové termíny ani značky (axiomy a princip indiference se nejmenují);
text je vlastní úvaha bez citace, nový zdroj nepřidán. Bez cvičení.

**Ověření:** kapitola 5 se vykreslila bez chyb. Ve webu (Chromium, místní
server) je blok výchozím stavem sbalený a jde rozbalit; matematika se
vykresluje, odkazy na součtové pravidlo a na kapitolu 1 vedou na existující
kotvy; při šířce 375 px bez vodorovného přetékání stránky. Didaktická
kontrola dotčeného místa: pojem „vzájemně výlučné“ je zaveden až později,
proto je v rozšíření odkazem dopředu. Celá kniha nebyla znovu vykreslena
(beze změny konfigurace a navigace). Neproběhlo ověření porozumění
na studentech ani nezávislé odborné ověření v literatuře.

<a id="audio-kapitoly-4-20261020"></a>

## 2026-10-20 — Zvukový doprovod výkladové části prezentace ke kapitole 4

Na výslovnou žádost autora vytvořena samostatná nahrávka
`kapitola_04_normalni_rozdeleni_vyklad.mp3` pro snímky 1–33 aktuálních
`presentations/kapitola_04_normalni_rozdeleni.pptx` a
`presentations/kapitola_04_poznamky.docx`. Závěrečné procvičování není
součástí nahrávky. Poznámky upraveny pro poslech: slovní výklad rovnic,
čtení značek a názvů funkcí, popis obrázků, oznámení čísel snímků,
vynechání organizačních pokynů a podkladových URL. Původní PPTX a DOCX
nebyly tímto úkolem upravovány. Rozsah učiva ani schválené konvence
se nemění.

Český syntetický hlas Microsoft Jakub; délka 55:29, MP3 mono 22 050 Hz,
80 kb/s, 33 navigačních kapitol podle snímků. Soubor předán samostatně;
není připojen k webu ani zařazen do verzovaných výstupů. Pracovní scénář,
časování, syntéza a záznam kontroly jsou v ignorovaném `tmp/audio04/`.

**Ověření:** shoda pořadí a témat 33 snímků s poznámkami, vizuální
prohlídka všech 19 použitých rastrových obrázků, redakce scénáře pro
začátečníka. Technicky zkontrolovány všechny zvukové úseky (nenulový
signál, bez ořezu na krajní hodnotu PCM), všech 127 444 MPEG rámců
souboru a shoda délky MP3 se spojenými vstupy s rozdílem pod 0,15 s.
Souvislý poslech nahrávky a poslechové ověření výslovnosti čísel
neproběhly; technická kontrola je nenahrazuje. Neproběhlo nové odborné
ověření původních podkladů ani ověření porozumění na studentech.


<a id="prezentace-kapitoly-4-qq-20261020"></a>

## 2026-10-20 — Prezentace ke kapitole 4: histogram a Q–Q graf na samostatných slidech

Podle připomínek autora nahrazeny dva slidy se třemi Q–Q grafy (dosavadní
27–28) šesti slidy 27–32, na nichž je vždy histogram s normální křivkou
a Q–Q graf téhož simulovaného souboru (normální model, zešikmení doprava
a doleva, těžší a lehčí chvosty, směs) s krátkými poznámkami. Na slidu 21
je obrázek pásem s opraveným umístěním popisku „Z-skór“ (oprava
v `scripts/kapitola_04.R`, samostatný PR do větve kapitoly 4). Prezentace má 41 slidů;
časy slidů 24 a 33 v poznámkách zkráceny na 1 min, výklad trvá podle součtu
nadále 45 minut. DOCX s poznámkami exportován znovu.

Úpravy byly provedeny přímo v autorem uloženém PPTX, ne novým generováním:
autor mezitím zvětšil obrázky na slidech 6, 9, 15, 17, 20–22 a 24, přeskládal
slide 21, upravil tabulku na slidu 20 a doplnil znak × na slidech 5 a 25.
Nové slidy vytvořil generátor v `tmp/chapter04-presentation/` a skript
`transplant.cjs` je vložil, vyměnil obrázek na slidu 21 a přečísloval slidy.
PPTX je od této chvíle hlavní verzí; generátor jeho ruční úpravy neobsahuje.

**Ověření:** u všech 35 ponechaných slidů se text i rozmístění shodují
s autorovou verzí (kromě čísla slidu); soubor otevřen a uložen v PowerPointu,
všech 41 slidů vykresleno a nové slidy prohlédnuty; každý slide má poznámky
v češtině. DOCX otevřen ve Wordu: 41 nadpisů „Slide N: titulek“, 18 stran.

<a id="popisek-z-pasma-20261020"></a>

## 2026-10-20 — Popisek osy z-skórů v obrázku stenů a staninů

Podle připomínky autora byl popisek „Z-skór“ v obrázku
[pásem](kapitola_04.qmd#sec-steny-staniny) (`pasma-skoru`) i po předchozí
úpravě opticky blíže číslům pásem než hodnotám z. V `scripts/kapitola_04.R`
posunut popisek výš (řádek okraje 1,75 místo 1,9) a řádek s čísly stenů
a staninů níž (4,4 místo 4,1). Obsah obrázku se nemění.

**Ověření:** obrázek vykreslen znovu a obě části prohlédnuty v rastru
(popisek těsně pod hodnotami z bez překryvu, čísla pásem odděleně níže);
render kapitoly 4 a `check-html.cjs` bez chyb. Stejný obrázek používá
prezentace ke kapitole 4; ta se upravuje samostatně.

<a id="prezentace-kapitoly-4-20261020"></a>

## 2026-10-20 — Prezentace ke kapitole 4

Vytvořeny soubory v `presentations/`: `kapitola_04_normalni_rozdeleni.pptx`
(37 slidů), `kapitola_04_poznamky.docx` a
`kapitola_04_normalni_rozdeleni_cviceni.xlsx`. Rozsah dohodnut s autorem:
jedna výuka za celou kapitolu, 22 výkladových slidů (45 minut) v pěti
tematických oddílech a procvičování (45 minut). Podle
[R50](../docs/rozhodnuti/postupy-a-dokumentace.md#r50-struktura-prezentaci)
je 2. slide přehled obsahu, oddíly oddělují slidy s jejich názvy a nadpisy
v DOCX mají tvar „Slide N: titulek“. Normalizace je jen stručně, P–P graf
(nepovinný) vynechán. Šest úloh bez Excelu je adaptováno z Howella
(3.3 a 3.5, 3.6–3.7, 3.10, 3.11–3.12, 3.19, 3.24; s. 79–81), řešení jsou jen
v poznámkách. Doprovodný sešit podle
[R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-excelova-cviceni-prezentaci)
má osm listů s jedním úkolem (U1–U8; úlohy 3.1–3.4, 3.6, 3.8, 3.13–3.15,
3.18 a postup 3.20–3.21), řešení po krocích, kontroly přímými funkcemi
a 24 nativních rovnic; U8 obsahuje Q–Q graf. Rozsah čtení Howella eviduje
[karta U01](../docs/zdroje/U01-howell.md#u01). Kapitola 4, slovník, osnova
ani `data/kapitola_04.xlsx` se neměnily; věcný rozpor mezi kapitolou
a prezentací nebyl zjištěn.

Postup: generátor v `tmp/chapter04-presentation/` navazuje na generátor
kapitoly 3 (OOXML s předlohou kapitoly 2, obrázky převedené z
`assets/chapter-04/plots/`, Q–Q grafy simulací oříznuté na pravou polovinu).
Nově umí přehledový a oddělovací slide, mřížku obrázků s popisky a titulek
pojmenovaný „Nadpis“, z něhož export DOCX čte nadpis slidu. Vkládání rovnic
do sešitu nově připojí rovnice i k výkresu listu, který už má graf. Plochu
a kvantil normálního modelu dávají v řešení NORM.S.DIST a NORM.S.INV
(základními operacemi je spočítat nelze); NORM.DIST a NORM.INV slouží jako
kontrola. Sdílené skripty v `scripts/` se neměnily.

**Ověření:** všech 37 slidů vykresleno v PowerPointu a prohlédnuto;
každý slide má poznámky a jazyk textů i poznámek je čeština (objektový model
PowerPointu). Čísla slidů, poznámek a sešitu přepočítána nezávisle v R
(`check.R` v tmp). Sešit přepočítán v českém Excelu 16: 0 chybových buněk,
všech 20 kontrol „Shoda s kroky“ = ano, 24 rovnic se zónou rovnice, jeden
graf, prázdné pracovní buňky; listy prohlédnuty z exportu do PDF. DOCX otevřen
ve Wordu: 37 nadpisů „Slide N: titulek“ shodných s titulky slidů, 17 stran.
Zadání 3.1 (μ = 4, σ = 1,63) ověřeno v obraze strany 79.

**Omezení:** popisky uvnitř převzatých grafů jsou při projekci drobné;
hlavní hodnoty opakuje text slidu. Výklad trvá podle součtu časů 45 minut,
skutečná délka nebyla vyzkoušena. Starší verze Excelu a PowerPointu, Excel
pro Mac ani webový Excel nebyly zkoušeny. Didaktická revize byla interní,
bez ověření na studentech. Studentský web se nemění, render knihy nebyl
potřeba.

<a id="struktura-prezentaci-20261020"></a>

## 2026-10-20 — Přehled obsahu a oddělovací slidy v prezentacích

Podle nového pravidla [R50](../docs/rozhodnuti/postupy-a-dokumentace.md#r50-struktura-prezentaci)
doplněn `docs/PREZENTACE.md`: druhý slide je heslovitý přehled obsahu,
tematické oddíly oddělují slidy jen s názvem oddílu, nadpisy exportu
poznámek do DOCX mají tvar „Slide N: titulek slidu“. Upřesněno, že přehled
a oddělovací slidy se nepočítají mezi obsahové slidy, nemají otázku
k zamyšlení a stačí jim krátké poznámky; doplněny kontroly před předáním.
Existující prezentace kapitol 1–3 a jejich exporty se touto změnou neupravují.

**Ověření:** kontrola odkazů a ID (`check-doc-maps.cjs`), `git diff --check`
a redakční kontrola, že pravidla jsou udržována jen v `PREZENTACE.md`.

<a id="sklonovani-odkazu-20261020"></a>

## 2026-10-20 — Skloňování odkazů na obrázky a tabulky

Podle nového pravidla [R49](../docs/rozhodnuti/spolecne-konvence.md#r49-sklonovani-odkazu)
opraveno 55 negramatických vazeb v kapitolách 1–4 („V @fig-…“, „Na @fig-…“,
„z @tbl-…“, „Levá část @fig-…“, „odpovídá @fig-…“) na skloňované slovo
a odkaz jen na číslo (`v obrázku [-@fig-…]`). Každý výskyt byl posouzen
podle vazby; holé odkazy zůstaly jen jako podmět nebo v závorce, což
odpovídá dosavadní praxi kapitol 5–7. Pravidlo je v `AGENTS.md`
(Uspořádání a ověřování Quarto Book) a registru rozhodnutí. Mapy kapitol se
nemění, jde o jazykovou opravu bez změny významu.

**Ověření:** render celé knihy bez varování; `check-html.cjs` s novou
kontrolou předložek a řídicích slov před „Obrázek/Tabulka N.N“ na všech
stránkách prošel (kontrolní výraz otestován i na původních vazbách);
ruční procházka všech vykreslených výskytů „Obrázek/Tabulka N.N“
v kapitolách 1–7. Kontrola pokrývá typické vazby, nikoli všechny možné
pády (např. dativ po jiných slovesech); ty hlídá redakční pravidlo.

<a id="revize-kapitoly-4-20261020"></a>

## 2026-10-20 — Revize kapitoly 4 podle připomínek autora

Zapracováno patnáct připomínek k jednotlivým místům a čtyři obecné poznámky
autora podle schváleného plánu. Nová rozhodnutí a upřesnění: širší definice
standardizace (doklad k R08), doplnění $z_{0{,}75}=0{,}674$ do hodnot zpaměti
(doklad k R40), termíny leptokurtické, mezokurtické a platykurtické rozdělení
([R48](../docs/rozhodnuti/kapitola-04.md#r48-typy-podle-excesu)) a výklad H07
pro kap. 4: „mez“ u intervalů se dvěma konci, „hranice“ u jediné dělicí hodnoty
([slovník](../docs/SLOVNIK.md#pojem-meze-intervalu)).

- Výklad: kontrast 60 bodů pod průměrem jiné skupiny; chvosty vysvětleny jako
  oblasti stále vzácnějších hodnot; nezávislá volba μ a σ oproti rozdělením
  se stropem či podlahou; „NEPRAVDA“ jako výška křivky (0,242 pro z = 1);
  rozdíl funkcí s písmenem S a bez něj; steny a staniny jako pomocná hodnota,
  zaokrouhlení a sloučení krajů (pravidlo ověřeno v R proti tabulkám);
  „Tento oddíl…“ v úvodech; omezeno opakování o manuálu testu a neměnnosti
  tvaru; obraty „nenormální / není normální“ nahrazeny opisem; opraven
  překlep „povůdní“.
- Q–Q: hotový graf dvanácti skórů přesunut do oddílu o principu; úvod
  diagnostik vysvětluje, že jen první soubor je z normálního modelu. Přidány
  simulace `sikme_vlevo` (70 − Exp, průměr 10) a `lehke` (rovnoměrné 30–70),
  připojené na konec téhož náhodného běhu, takže dosavadní čtyři soubory,
  jejich koeficienty i listy zůstaly beze změny (ověřeno kontrolou
  koeficientů). U každého typu uvedena zkreslení empirických versus modelových
  percentilů; tvrzení i čísla ověřuje `check-chapter-04.R`. Z kontroly vyplynulo,
  že u těžších chvostů tohoto souboru je výrazně podhodnocen hlavně horní konec
  (1. percentil se shoduje), což text výslovně uvádí. P–P rozšíření doplněno
  o rozlišení otázek: kvantily (Q–Q) versus percentilové pořadí (P–P).
- Grafy: `skaly` na z −3 až 3; `pasma-skoru` s podíly pásem nad osou a
  kumulativními podíly nad mezemi; dvě nové diagnostiky. Sešit má nové listy
  `Sim_sikme_vlevo` a `Sim_lehke`; popisky `Model!A11:A13` používají „mez“.
- Přehledy: slovníček (standardizace, tři nová hesla), značení ($z_{0{,}75}$),
  funkce Excelu (N(0, 1) versus libovolné μ, σ; hustota jako výška křivky).

**Ověření:** `Rscript quarto/_verification/check-chapter-04.R` (včetně nových
koeficientů, percentilů, pravidla stenů/staninů a 21 SVG);
`scripts/build-workbooks.ps1 -Chapter 4 -Verify` v českém Excelu 16.0
(23 listů; české SKEW/KURT pro šest listů, PERCENTIL.INC a NORM.INV
z textu, hustota pro z = 1; kontrola chyb všech sedmi sešitů); render
kapitoly 4, slovníčku, značení a přehledu Excelu bez varování;
`check-html.cjs` (21 obrázků, Q–Q graf v oddílu o principu, odkazy,
řešení, slovníček, mobilní šířka) prošel. Vizuálně prohlédnuty nové a
upravené obrázky a oddíl stenů a staninů. **Omezení:** celá kniha nebyla
znovu vykreslena (změna se netýká společné konfigurace); didaktická revize
byla interní, bez ověření na studentech.

**Doplnění (po sloučení PR #107):** v obrázku pásem stenů a staninů leží
popisek osy „Z-skór“ těsně pod hodnotami z; řada čísel pásem je posunuta níž
a oddělena mezerou (připomínka autora, že popisek byl blíže číslům pásem).
Ověřeno vizuálně, kontrolou `check-chapter-04.R` a renderem kapitoly 4.

<a id="revize-kapitoly-7-20261018"></a>

## 2026-10-18 — Cílená revize kapitoly 7

Proveden autorem schválený plán patnácti oprav po komplexním auditu celého
výkladu, čtrnácti zadání a řešení, grafů, tabulek, přehledů a datového
sešitu. Rozsah, základní struktura a konvence R44–R46 zůstávají zachovány;
nejde o nová obsahová rozhodnutí.

- Ekvivalence umožňuje závěr o zanedbatelnosti také při statisticky
  významném rozdílu. Řešení 12c nevyvozuje použitelnost norem z pouhé
  ekvivalence průměru. Řešení 6d interpretuje rozdíl vůči normě, nikoli
  změnu způsobenou kurzem.
- Vztah intervalu a testu v textu, shrnutí, grafu, slovníčku a sešitu
  respektuje zavedené p ≤ α. Přesná rovnost je oddělena od zaokrouhlení;
  řešení 8 respektuje výslovně přesnou mez v zadání.
- Opraven screeningový poměr v 9c (4,8 % → 12,2 %, asi 2,5násobek),
  nepodložené tvrzení o budoucím výběrovém průměru v 2d a příliš silné
  zdůvodnění normality v 5d. Pilotáž pro budoucí studii je odlišena od
  hranic přizpůsobených týmž testovaným datům.
- Před prvním odvozením jsou připomenuty předpoklady; shrnutí zpřesňuje
  podmínku širšího t-intervalu. Řešení 7d obsahuje nový Q–Q graf podle
  konstrukce kapitoly 4, včetně omezení posouzení z dvaceti hodnot.
- Upraven popisek grafu šířky intervalu, zalamování poznámek sešitu a
  modelového předpokladu v `Interval_z!A3`. Procenta v popiscích se mění
  podle zadané hladiny. Struktura 19 listů, vstupní data a oddělení
  zadání od řešení jsou zachovány.
- Kapitolová numerická kontrola je zapojena do GitHub Actions; doplněny
  provozní příkazy a aktualizovány mapa kapitoly a evidence dat.

Rozpor Howellova komentáře o chvostech s tabulkou a Q–Q grafem je doložen
v [U01](../docs/zdroje/U01-howell.md#revize-07-20261018), včetně lokátorů,
verze souboru, nezávislého přepočtu a omezení. Historické záznamy ani
schválený plán se zpětně nemění. Další podklady auditu: Cumming s. 151–152,
Lakens (2017: čtyři výsledky, jednovýběrový TOST, pozn. 2) a Lakens et al.
(2018: zdůvodnění hranic, Discussion); nové termíny se nezavádějí.

**Didaktická revize:** znovu přečtena upravená místa a návaznosti očima
začátečníka. Kontrola se soustředila na oddělení parametru, odhadu a
výsledku testu, přesných a zaokrouhlených mezí, rozdílu a změny, ekvivalence
průměru a individuální shody. Q–Q úloha má nyní vizuální vzor uvnitř řešení;
cíle a vstupní znalosti se nemění. Nejde o test porozumění na studentech.

**Provedené kontroly realizace:** R kontrola včetně hranic a Q–Q
souřadnic prošla. Nezávislé reference obnoveny v Pythonu. Obnova sešitu
v Excelu 16.0 a kontroly: 32 uložených hodnot, 53 českých vzorců,
3 očekávané chyby, 79 výsledků po změnách vstupů, 33 popisků,
9 hraničních rozhodnutí a 9 kontrol uložených českých formulí; žádná
neočekávaná chyba. Read-only kontroly sešity neukládají. Porovnání před/po
potvrdilo pořadí listů, vstupy, formáty čísel, sloučené oblasti, validace
a počet grafů; obsah se změnil jen v deseti plánovaných buňkách výpočtových
listů. Původní číselné výsledky jsou shodné.

Úplné sestavení knihy prošlo; po konečném doladění grafu a hraničního
pravidla neinferiority byla znovu vykreslena kapitola 7. Následná úplná
HTML kontrola prošla: 12 stránek, 257 hesel, 83 řešení v celé knize,
místní odkazy, klávesnice, obsah i bez JavaScriptu a přes `file://`,
šířky 1360/1920 a mobilní šířka 390 px. Kapitola 7 má 14 řešení a osm
obrázků; nový Q–Q graf je skrytý spolu s řešením a po otevření na mobilu
posuvný klávesnicí bez přetékání stránky. Vizuálně ověřeny upravené grafy
šířky a p-hodnoty, Q–Q graf na desktopu i mobilu a nativní náhledy
výpočtových listů. Kontrola studentských sešitů včetně zveřejňované kopie
prošla; kontrola map s místními zdroji prošla pro 72 dokumentů, 47 rozhodnutí,
2 881 místních odkazů a 409 odkazů do zdrojů. `git diff --check` bez chyb.

**Omezení auditu:** nebyl přečten plný původní článek Nurcomba et al.
(ověřena metadata a abstrakt) ani celé podkladové knihy. Ověření se týká
místního Excelu 16.0 a místního webu; jiné verze Excelu, všechny prohlížeče
a aktuální veřejné nasazení nejsou tímto záznamem ověřeny.

## 2026-10-18 — Discovering Statistics Using JASP v mapě zdrojů

Doplněna [karta U14](../docs/zdroje/U14-field.md#u14), inventář a tematický
rozcestník. Bibliografická identita ověřena v PDF a u Sage; zmapováno všech
17 kapitol s tištěnými/PDF lokátory. Rozsah skutečného čtení, obrazové
kontroly a omezení je v kartě, inventární kontrola 45 místních souborů
v [historii zdrojů](../docs/zdroje/HISTORIE.md#field-2026-10-18).
Studentský text, bibliografie citovaných děl a osnovy se neměnily.

Ověření: `node scripts/check-doc-maps.cjs --require-sources`, inventární
kontrola cest a SHA-256, kontrola rozsahu nových PDF odkazů a
`git diff --check`. Render knihy se pro tuto čistě autorskou dokumentační
změnu nespouští. Příklady nebyly nezávisle přepočítány a JASP nebyl spuštěn.

## 2026-10-17 — Kapitoly 3 a 4: povinné ukazatele tvaru

Podle [R47](../docs/rozhodnuti/kapitola-03.md#r47-ukazatele-tvaru):

- Kapitola 3: nový povinný oddíl `sec-ukazatele-tvaru` za `sec-popis-a-model`
  s pododdíly `sec-koeficient-sikmosti`, `sec-spicatost` (ID zachováno, nyní
  povinný výklad excesu) a `sec-excel-tvar`. Nový obrázek
  `fig-ukazatele-tvaru` (gama modely se šikmostí 0/1/2; t s 10 a 5 st. v.
  s excesem 0/1/6; podíly mimo ±3 SD 0,27/0,73/1,17 %; zvětšené pravé
  chvosty; skript `scripts/kapitola_03.R`). Obrázek `fig-spicatost`
  a nový blok „Častý omyl: exces jako výška vrcholu“ přesunuty do povinné
  části (Westfall, 2014, s. 191–195). SKEW/KURT na době spánku
  (−0,13; −0,55) a tři meze koeficientů. Původní nepovinné rozšíření
  (`sec-momenty`, `rozsireni-momenty`) zachovává momenty, g₁, g₂ a korekce,
  doplněno sbližování variant u 33 dob spánku.
- Úvodní cíle doplněny o odrážku; Shrnutí ponechává osm bodů (poslední bod
  spojuje shodné m/s, ukazatele tvaru a popis dat). Nové povinné cvičení 13
  (SKEW/KURT počtu slov −0,47/0,48; kopie bez platné nuly −0,09/−0,25);
  nepovinná cvičení přečíslována na 14–15, list `U14_sikmost` přejmenován
  na `U15_sikmost`; `Souhrn` B12:C13 obsahuje SKEW a KURT.
- Kapitola 4: odkaz v úvodu přiměřenosti vede na povinný oddíl; v
  `sec-qq-odchylky` tabulka `tbl-qq-koeficienty-04` (SKEW/KURT čtyř
  simulací z listů `Sim_*`) a výklad konvergentní informace i mezí;
  cvičení 10 a poslední bod Shrnutí rozšířeny.
- Slovníček (nové heslo Ukazatele tvaru; šikmost, špičatost, exces),
  přehled Excelu, registr SLOVNIK, kapitolové karty, OSNOVA a DATA.

Ověření: `check-chapter-03.R` (integrace momentů a podílů chvostů modelů,
hodnoty SKEW/KURT, 15 řešení) a `check-chapter-04.R` (koeficienty
simulací; nestálost excesu u t se 3 st. v. ověřena 1000 výběry se seedem
20261017: 10. percentil pod 2,5, 90. nad 10); `build-workbooks.ps1
-Chapter 3 -Verify` a `-Chapter 4 -Verify` včetně skutečně spuštěných
českých vzorců SKEW/KURT v Excelu 16; `check-workbooks.py`; render celé
knihy; `check-html.cjs` (včetně mobilu a stavu bez JavaScriptu);
`check-doc-maps.cjs`; vizuální prohlídka nového obrázku a oddílů.
PDF kapitoly 4 ověřeno. **Neověřeno:** PDF kapitoly 3 se nevykreslí kvůli
staršímu problému nezávislému na této změně (prázdný span
`populacni-parametry` na začátku odstavce za nadpisem `sec-korekce-rozptylu`
vede v Typstu ke dvojímu štítku; zavedeno v ad5d17b); kontrolní skript
PDF je připraven na 15 řešení. Didaktická revize provedena autorsky
(čtení očima začátečníka, délka vět), nikoli na studentech ani
samostatným agentem. Westfall (2014) nemá zdrojovou kartu v `docs/zdroje/`;
použitý lokátor je převzat z dosavadního textu kapitoly.
## 2026-10-17 — P-hodnota v české ukázce APA

Autor rozhodl otevřenou otázku z [vytvoření kapitoly 7](#vytvoreni-kapitoly-7): v české ukázce APA zůstává p-hodnota s nulou před desetinnou čárkou (*p* = 0,003). Zapsáno jako datované upřesnění [R05](../docs/rozhodnuti/spolecne-konvence.md#r05-zaokrouhlovani) a řádku registru; v kapitole 7 doplněna jedna věta u [ukázky sdělení](kapitola_07.qmd#sec-ukazka-sdeleni). Ostatní kapitoly českou ukázku s p-hodnotou neobsahují (prohledány kapitoly 1–7), takže jinde se nic neměnilo. Ověření: render kapitoly 7, kontrola HTML, kontrola dokumentačních map a git diff --check.

<a id="dohoda-kapitola-07"></a>

## Kapitola 7: dohoda o obsahu (2026-10-17)

Na doporučení zaměřit další kapitolu na průměry autor odpověděl, že kapitola
má představit jen jednovýběrový z-test a t-test, podrobněji intervaly
spolehlivosti a jejich vztah k p-hodnotám a pomocí intervalů test ekvivalence
(výsledek může být statisticky, ale ne věcně významný; intervaly různé šířky
zasahují do různých pásem), a připojil vlastní schéma intervalů studií A–I.
Na otázky zvolil povinný výklad TOST přes 90% interval (výpočet p-hodnot
nepovinně) a neinferioritu jen nepovinně.

**Průběh.** První plán autor vrátil se čtrnácti připomínkami: zpřesnit název;
z-test jen připomenout; v simulaci se známou σ mají intervaly stejnou šířku
a ze 100 jich nemusí přesně 95 zachytit μ; oddělit modelový předpoklad σ = 10
od výběrové s = 10 a model popsat slovně; předpoklady uvést u prvních
intervalů a zmínit zkreslení a chybu měření; 91,8 % označit jako teoretické
pokrytí chybného postupu; přesně formulovat vztah intervalu a p-hodnoty včetně
hraničního případu; doplnit přesné hypotézy TOST a vysvětlení 90% intervalu;
zúžit závěr o online verzi; v tabulce studií oddělit oba testy od věcného
závěru; doplnit cíle a cvičení k ekvivalenci včetně volby hranic podle
výsledku; upravit terminologii (intervalový odhad, přesnost odhadu, mezní
chyba odhadu, TOST jako konkrétní postup, popis Δ); zpřesnit nepovinná
rozšíření a reportování; prostudovat Lakense a Cumminga před schválením
a zkrátit opakování z-testu. Druhou verzi vrátil s pokynem zapisovat kvantil
t-rozdělení jako $t_{0{,}025\,(v=10)}$ a poté plán schválil. Dohodu
eviduje [R44](../docs/rozhodnuti/kapitola-07.md#r44-rozsah-kapitoly-7)–[R46](../docs/rozhodnuti/kapitola-07.md#r46-terminologie-kapitoly-7).

<a id="vytvoreni-kapitoly-7"></a>

## Kapitola 7: vytvoření výkladu (2026-10-17)

Podle dohody vznikla kapitola `quarto/kapitola_07.qmd` s jedenácti
výkladovými oddíly, sedmi obrázky, třemi nepovinnými rozšířeními a čtrnácti
cvičeními (dvanáct základních, dvě nepovinná), sešit `data/kapitola_07.xlsx`
(19 listů), skript `scripts/kapitola_07.R`, 15 hesel slovníčku, pět řádků
přehledu značení a čtyři funkce Excelu (T.INV, T.DIST, T.DIST.2T, T.INV.2T).
Tři odkazy kapitoly 6 na „další kapitolu“ vedou nově do kapitoly 7. Do
bibliografie přibyly Lakens (2017), Lakens, Scheel a Isager (2018)
a Nurcombe et al. (1984); zdroje mají karty E02 a E03 a doplněk U03.

### Odborná a didaktická rozhodnutí při psaní

- **Simulace opakovaných intervalů** (seed 20261017, výukový model μ = 47,
  σ = 10, 100 výběrů po 25) dala 94 zachycení při známé σ a 96 s výběrovou s.
  Seed nebyl vybírán podle výsledku; text oba počty využívá k ukázce, že
  95 % je dlouhodobé pokrytí. Simulace výběrů po pěti (seed 20261018) dává
  4,8 % a 12,4 % statistik mimo ±1,96.
- **Hypotézy t-testu** zůstaly jednostranné jako u z-testu v kapitole 6,
  protože směr výzkumnice zvolila předem. Vztah k 95% intervalu, který normu
  50 obsahuje, vysvětluje oddíl o jednostranné mezi (49,42 = horní mez 90%
  intervalu); tento most vede přímo k TOST.
- **PDI.** Interpretace se drží Howella (s. 188): nečekaně vyšší průměr,
  výhoda oboustranného testu, kontrola skórování a podobné průměry jiných
  studií. První koncept přisuzoval Howellovi nedoložené vysvětlení o původu
  norem a tvrdil, že výzkumníci nečekali směr; obojí opraveno po kontrole
  v PDF.
- **Zdůvodnění hranic ±3** je vlastní modelová úvaha (podíl lidí pod
  hranicí 40 se mění z 15,9 % na 24,2 % nebo 9,7 %), rozhodnutí je výslovně
  přisouzeno vydavateli a označeno jako hodnotová volba předem.
- **Ukázka reportování** odděluje statistiky středníky podle R05 a uvádí
  *p* s nulou před desetinnou čárkou (*p* = 0,003). APA 7 v angličtině nulu
  před desetinnou tečkou u p-hodnot vynechává; česká podoba tohoto detailu
  dosud nebyla dohodnuta a je ponechána k rozhodnutí autora.
- **Funkce A a MAX** se používají jen na listu `Ekvivalence` (slovní závěr
  a výsledná p-hodnota TOST); do přehledu funkcí Excelu nebyly zařazeny,
  protože je student v úlohách nepotřebuje.

**Didaktická revize** proběhla po dokončení konceptu čtením očima
začátečníka se vstupy kapitol 1–6. Opraveny: věta o „náhodě zvolené pro
jednoduchost“ u s = 10 (protimluv), formulace o shodě odhadu směrodatné
chyby s modelem, dva výpočty zapsané jako excelový vzorec uvnitř matematiky
(nyní kód v textu) a odkaz na rozsahy listů `U07_uzkost`, `U08_intervaly`,
`U11_studie` a `U14_neinferiorita`. Povinná část má asi 8 700 slov; jedna
věta má mírně přes 35 slov a byla ponechána kvůli souvislosti. Interní
revize není ověřením porozumění na studentech.

### Ověření

- `quarto/_verification/check-chapter-07.R`: všechna čísla výkladu, tabulky
  studií, simulací a řešení všech 14 úloh nezávisle přepočtena (t-rozdělení
  přes neúplnou beta funkci); prošlo.
- Sešit sestaven `scripts/build-workbooks.ps1 -Chapter 7` v českém Excelu
  a ověřen `quarto/_verification/check-chapter-07-excel.ps1`: 32 uložených
  výsledků, 52 vzorců z textu a řešení zadaných přes FormulaLocal, 3 chybové
  argumenty, 58 výsledků a 12 popisků po změně vstupů, 9 českých vzorců.
  Očekávané hodnoty počítá `check-chapter-07-excel-expected.py` nezávisle
  na Excelu i R. Kontrola vstupů (`check-workbooks.py`) prošla pro kapitoly
  4–7; běh pro všechny kapitoly se zastavil na kapitole 3, protože
  `tmp/chapter-03-build/inputs.json` je zastaralý pracovní manifest
  (sešit kapitoly 3 se neměnil a nebyl znovu sestaven).
- Render celé knihy a `check-html.cjs` (12 stránek, 82 řešení, 256 hesel,
  odkazy, klávesnice, bez JavaScriptu, file://, mobilní šířka 390 px): prošlo;
  kontrola nově hlídá řešení, obrázky, stojaté řecké symboly, zápis kvantilů
  t a sbalená rozšíření kapitoly 7.
- Vizuálně zkontrolovány všechny obrázky kapitoly (PNG náhledy i snímky
  vykreslené stránky) a oddíly s tabulkami Excelu, testem a čtyřmi
  kombinacemi.
- Neověřeno: porozumění na studentech; úvodní oddíly Lakense, Scheela
  a Isagera (2018) a čísla stran obou Lakensových článků; původní studie
  Nurcomba et al.; odolnost t-postupů simulací zešikmených populací.

## 2026-10-17 — Jednotná přibližná rovnost a první výklad těsného násobení

Podle schváleného [R43](../docs/rozhodnuti/spolecne-konvence.md#r43-priblizna-rovnost)
nahrazeno 106 výskytů původního symbolu přibližné rovnosti: 22 v kapitole 3,
37 v kapitole 5, 37 v kapitole 6 a 10 v přehledu značení. Kapitola 4
a generátor jejího grafu konstrukce Q–Q již používaly ≈. Ve studentských
QMD nezůstal původní znak ani příkaz; prohledány i zdroje grafů a XML
šesti datových sešitů, kde další výskyty nebyly. Historické doklady
nejsou zpětně přepisovány. Prezentace a poznámky mimo webovou učebnici
nebyly předmětem této kontroly.

Význam ≈ vysvětlen před prvním použitím v tabulce kumulativních podílů
kapitoly 3; přehled značení odkazuje na toto místo. Těsné násobení
vysvětleno při prvním výskytu, ve vzorci pro průměr (1/n krát součet),
a jednou připomenuto u zpětného převodu z-skóru v kapitole 4 s odkazem.
Doplněn přehled násobení a mapy návazností. Didaktická revize ověřila,
že čtenář zná oba činitele a vazbu násobení 1/n na dělení počtem hodnot.

Ověření: render celé knihy, číselné kontroly kapitol 3–6 včetně řešení,
kontrola dokumentačních map (43 rozhodnutí, bez chyb) a git diff --check.
U kapitol 5 a 6 navíc přesné porovnání proti předchozímu obsahu po
normalizaci jediného změněného symbolu. Vizuálně zkontrolován první
výklad násobení, jeho připomenutí, tabulka s ≈, řádek přehledu značení
a graf konstrukce Q–Q; oba dotčené odstavce také na mobilní šířce 390 px.
Kontrola HTML nově hlídá nepřítomnost původního znaku a správný operátor
≈ v MathML pro vzorce s příkazem approx.
Celková kontrola HTML prošla na 11 stránkách včetně 68 řešení, místních
odkazů, přehledů, klávesnice, mobilní šířky 390 px a navigace bez
JavaScriptu i přes file://; bez chyb.
Kontrola kapitoly 3 vyžadovala výslovné nastavení LC_CTYPE na .UTF-8;
po něm prošla. Render doběhl i přes úvodní upozornění R na LC_*.
Excel nebyl znovu spuštěn; vstupy ani vzorce sešitů se neměnily.

## 2026-10-17 — Zpřesnění polohy popisků kapitoly 2

Na základě následné vizuální připomínky autora přiblížen popisek
16 z 33 (48,5 %) mírně doleva a nahoru k bodu. V levém panelu srovnání
os zvýšena horní mez z 33 na 35, aby se popisek 32 vešel celý do
vykreslovacího pole. Odstup popisků od sloupců zůstává v obou panelech
shodný. Předchozí vizuální kontrola ořezání čísla 32 nezachytila.

Ověření: nový render kapitoly 2 a zvětšené snímky obou grafů při šířce
stránky 1360 a 390 px; žádné překrytí spojnic ani ořezání popisků.
Kontrola rozdílů `git diff --check`. Data, výpočty a studentský výklad
se neměnily; numerické kontroly a celková kontrola HTML se neopakovaly.
Render dokončen i přes stejné upozornění R na LC_* jako při minulé kontrole.

## 2026-10-16 — Popisky grafů kapitoly 2 a dělení stonků

V generátoru kapitoly 2 přesunut popisek 16 z 33 (48,5 %) v kumulativním
grafu doprava a dolů. U srovnání os mají popisky 30 a 32 v obou panelech
stejný odstup od vrcholu sloupce v jednotkách velikosti písma.
Na výslovnou žádost autora doplněn výklad dělení stonků po pěticích
a dvojicích na stejných osmi původních časech, včetně opakovaných stonků,
prázdných řádků a volby přiměřené podrobnosti. Aktualizována kapitolová
karta a pokrytí daty; vstupy a generátor sešitu se nemění.

Ověření: render kapitoly 2, číselná kontrola kapitoly v R včetně řešení,
nezávislá rekonstrukce všech tří zápisů v Node.js a přímá kontrola uložených
hodnot listu Stonek A2:A9 v XLSX. Vizuálně zkontrolovány oba upravené grafy
a výklad stonků na desktopu i při šířce 390 px; popisky se nepřekrývají.
Didaktická revize doplnění ověřila význam klíče, zachování opakování
a rozdíl mezi dvojicí možných číslic a počtem pozorování.
Kontrola dokumentačních map prošla (42 rozhodnutí, bez chyb).
Celková kontrola HTML prošla na všech 11 stránkách: místní odkazy,
68 řešení včetně klávesnice a skrytí, přehledy, navigace bez JavaScriptu
i přes file:// a mobilní šířka 390 px; bez chyb.
R při renderu hlásilo nastavení LC_*; české popisky se vykreslily správně.
Excel nebyl znovu spuštěn, protože data ani vzorce sešitu se neměnily.

## 2026-10-16 — Sjednocení citací online dokumentace

Podle [R42](../docs/rozhodnuti/spolecne-konvence.md#r42-citace-dokumentace)
nahrazeno 41 samostatných bibliografických položek čtyřmi dokumentačními
celky (NIST e-Handbook 2022, Excel 2026, R-devel 2026 a SciPy 1.18.0 z roku
2026). Celkový seznam má 48 místo 85 položek. Ve všech studentských QMD
vyhledány dotčené klíče; 49 výskytů v kapitolách 2–5 nyní odkazuje na
společný záznam a přímo na konkrétní část. Vícenásobné odkazy na Excel
v jedné citaci sdílejí autora a rok. Zbývajících 44 bibliografických
záznamů zachováno, včetně samostatné dokumentace Dataplot k Shannonovu
indexu (2016). Výklad, data, vzorce a rozsah učiva se nemění; kapitolové
mapy proto nebyly obsahově revidovány ani přeznačeny novým datem kontroly.

Ověření: render všech 11 stránek; kontrola dokumentačních map (42 rozhodnutí,
bez chyb); porovnání všech 49 přímých odkazů proti původním citacím;
kontrola roků a 48 záznamů v HTML; vizuální prohlídka seznamu literatury
a citace NIST u Q–Q grafu. Kontroly HTML byly přizpůsobeny novým společným
záznamům a ověřují i přímé odkazy na jednotlivé části.
Celková kontrola HTML prošla na všech 11 stránkách: místní odkazy,
68 řešení, klávesnice, společné přehledy, mobilní šířka 390 px a zobrazení
bez JavaScriptu i přes file://.
Podklady dat a jejich omezení jsou v [historii zdrojů](../docs/zdroje/HISTORIE.md#kontrola-dokumentace-2026-10-16).
R při sestavení ohlásilo neúspěšné nastavení LC_* na C.UTF-8; render
doběhl a český text byl vizuálně ověřen. Neproběhla nová odborná revize
všech odkazovaných stránek ani nové přepočítání nezměněných úloh v Excelu.

Historické záznamy níže popisují stav v době vzniku a zůstávají zachovány.
Pro současné konvence používejte [přehled rozhodnutí](../docs/ROZHODNUTI.md),
pro preferované názvy, alternativy a významové hranice
[autorský registr terminologie](../docs/SLOVNIK.md),
pro aktuální obsah, návaznosti a oddělený plán pokračování
[mapu učebnice](../docs/OSNOVA.md).

<a id="terminologie-mereni-01"></a>

## Zpřesnění výkladu po společné redakci (2026-09-20)

Na žádost autora zapracovány projednané úpravy přímo do hlavního souboru
`quarto/kapitola_01.qmd`, na větvi `codex/chapter-01-clarifications`
z aktuálního `origin/main` (440298b). Zachována dosavadní místní redakce
i formátování z editoru; nesledovaný soubor Rproj nebyl upraven ani přidán.

- Konkrétně popsáno omezené zastoupení společností v Henrichově přehledu.
  Oddíl 2 znovu ověřen v autorském PDF uvedeném níže; nevydáváme jeho
  historická procenta za současný stav celé psychologie.
- Argument pro zobecnění rozveden na vlastním hypotetickém příkladu
  rušivých zvuků, starších dospělých a porozumění jazyku nahrávky.
  Nejde o výsledek skutečně provedené studie. Zachován odkaz na Simonse.
- Oddělen účel náhodného rozdělení, záměrného rozdílu podmínek a kontroly
  provedení. Sjednoceno také řešení úlohy 4.
- Výroky „Jsem odpočatý“ a „Jsem unavený“ označeny jako tvrzení;
  uveden úplný význam pěti možností odpovědi. Věk vysvětlen jako doba
  od narození, jejíž poměr nelze přenášet na psychickou zralost.
- Intervalová interpretace doplněna příkladem modelu měření únavy.
  Odlišeny původní body od odhadů modelu; závislost na předpokladech
  výslovně zachována. Konkrétní psychometrické modely se nezavádějí.
- Tabulka v `sec-uroven-a-spojitost` nahrazena souvislým výkladem
  možných hodnot, významu vztahů a přesnosti záznamu. Zachováno ID oddílu.
  Doplněny VAS, posuvník a verbální kotvy, změny číselného zápisu a příklad
  zaokrouhlené teploty. Nezavádí se topologie, absolutní škála ani SEM.

Slovníček doplněn o čtyři schválené pojmy (celkem 50): model měření,
vizuální analogová škála, posuvník a verbální kotva. Přehledy značení
a Excelu se nemění; nové symboly, vzorce ani funkce nepřibyly.

Odborná opora nového textu:

- Stevens (1946), s. 677–679: přípustné změny číselného zápisu;
  ověřeno v úplném článku, DOI 10.1126/science.103.2684.677.
- Salzberger (2010), s. 1273–1275: rozdíl mezi součtem bodů a modelovým
  měřením; ověřeno na https://www.rasch.org/rmt/rmt242a.htm.
  Nepřebíráme obecný závěr, že shoda s modelem sama definitivně dokazuje
  kvantitativní povahu konstruktu. U článku není uvedeno DOI.
- Weigl a Forstner (2021), úvodní část před oddílem „The Present Study“:
  podoba VAS a popisy bodů; text ověřen v indexovaném plném znění
  https://pmc.ncbi.nlm.nih.gov/articles/PMC8072950/.
  Metadata ověřena přes Crossref a univerzitní záznam JKU. Rok 2021
  odpovídá zařazení do ročníku 81(3), s. 595–611; online vydání je 2020.
  DOI 10.1177/0013164420952118. Přímé načítání PMC vracelo ochrannou
  stránku a rozhraní Europe PMC chybu 500, dostupný byl indexovaný text.

Ověření: úplný render všech pěti stránek prošel. Kontrola R potvrdila
modelovou matici, chybějící hodnoty, odpověď 8 a elementární výpočty.
Všech osm vzorových řešení zkontrolováno obsahově vůči zadání a výkladu.
Kontrola HTML prošla pro 50 hesel, včetně vyhledání všech čtyř nových
anglických termínů, odkazy, stránkování, klávesnici, skrytí a rozbalení
osmi řešení i nepovinného rámečku a zobrazení bez JavaScriptu.
Šířky 1360, 1920 a 390 px bez přetékání celé stránky a bez chyb JavaScriptu.
Nové pasáže a bibliografie prohlédnuty na snímcích; ověřeno vykreslení
nových citací, autorů, let, kurzivy, lokátorů a cílových DOI/URL.
Nové číselné příklady (rozdíly 5 bodů, převod hodin na minuty a poměry)
zkontrolovány nezávisle. Excel se neměnil a nebyl znovu spouštěn.
Kontrola rozdílů bez chyb. Toto ověření se týká místního webu;
publikování na Pages následuje až po autorově sloučení PR.

<a id="terminologie-validita-01"></a>

## Sjednocení hlavní místní kapitoly a doplnění validity (2026-09-20)

Na výslovnou žádost autora je výsledná kapitola přímo v hlavní pracovní
složce `D:\R Projects\github\statistics-for-psychology\quarto\kapitola_01.qmd`.
Hlavní pracovní kopie přešla na tematickou větev z aktuálního `main`
(1b92cfd, sloučený PR #8). Předchozí místní redakce byla zálohována
v ignorovaném `tmp/local-integration-20260920/kapitola_01.before.qmd`
a spojena s rozšířením kapitoly. Zachováno všech 17 bloků místní redakce;
u společně změněného cíle učení spojeno „Rozlišíte“ s novými pojmy.
Opraveny dva zjevné překlepy („jí stačí“, „Tím jsme otázku upřesnili“)
a sjednocena autorem zvolená odpověď „dost“ i v nové přehledové tabulce.
Nesledovaný soubor Rproj nebyl změněn ani zahrnut do commitu.

Zapracovány další tři předem schválené body:

- Kód chybění musí být nepřípustnou, snadno rozpoznatelnou hodnotou;
  vzácná, ale možná hodnota nestačí. Zůstává nutnost nastavit zacházení
  s kódem v programu a odlišit jej od skutečné nuly.
- U online sběru odlišeno ID odpovědi od ID účastníka a od časového
  pořadí. Čas zahájení, dokončení a uložení nemusí být shodný;
  při řazení záleží na časovém pásmu a přesnosti. Obecný příklad
  odpovídá rozlišení polí v dokumentaci Qualtrics ověřené při přípravě:
  https://www.qualtrics.com/support/survey-platform/data-and-analysis-module/data/download-data/understanding-your-dataset/.
- Nová podkapitola interní/externí validity navazuje na náhodné rozdělení
  a náhodný výběr, s oporou v Howellovi (2013, s. 3) a Simonsovi a kol.
  (2017, s. 1123). Externí validita zahrnuje i situace a podmínky;
  není ztotožněna s náhodným výběrem. Vysvětlení nepředpokládá nutný
  konflikt obou validit. Doplněna otázka 4e s úplným řešením.

Slovníček má 46 hesel, nově interní a externí validitu s anglickými
ekvivalenty a českými alternativami. Přehledy značení a Excelu se nemění,
protože nové symboly, vzorce ani funkce nezavádíme.

Ověření z hlavní pracovní složky: úplný render pěti stránek úspěšný;
kontrola R prošla (pouze obvyklá varování o nedostupné lokalizaci C.UTF-8).
Kontrola HTML prošla pro 46 hesel, osm skrytých a rozbalitelných řešení,
nepovinný rámeček, místní odkazy, klávesnici, stránkování, hledání,
zobrazení bez JavaScriptu a šířky 1360, 1920 a 390 px. Bez chyb
JavaScriptu a bez přetékání celé stránky. Nové části prohlédnuty na
snímcích; citace Howella a Simonse vykresleny se správnými lokátory.
Porovnání se zálohou potvrdilo zachování všech změněných uživatelských
řádků po uvedených opravách a spojení cíle učení. Nová odpověď 4e
zkontrolována věcně; žádné nové číselné výpočty ani excelové funkce
nevznikly a Excel nebyl znovu spouštěn. `git diff --check` bez chyb.
Toto ověření se týká místního webu, nikoli zveřejnění změn na Pages.

<a id="terminologie-rozsireni-01"></a>

## Rozšíření pojmů v kapitole 1 (2026-09-20)

Rozsah byl před psaním projednán a schválen: konstanta a závislost
proměnlivosti na souboru; relativní vymezení populace a výběru;
příležitostný výběr a argumenty pro zobecnění; účel náhodného rozdělení;
konkrétní operacionalizace; různé úrovně zachycení věku; počet správně
napsaných slov jako výkon versus schopnost; kvaziintervalové zacházení;
úrovně měření versus diskrétnost a spojitost; výběrová variabilita,
výběrové zkreslení a odmítání účasti.

Podrobnější vysvětlení chyby měření je po dohodě nepovinný, výchozím
stavem sbalený rámeček `chyba-mereni-podrobne`. Používá modelový pohled
na lidi se stejnou úrovní rysu, ale netvrdí, že jejich průměr je automaticky
nezkreslenou hodnotou konstruktu. Stabilní vliv znalosti jazyka může
přetrvat při opakování; formální teorii pravého skóru nezavádíme.
Na rámečku nezávisí povinná cvičení.

Nové příklady jsou vlastní modelové situace, které vycházejí z dohody
s autorem. Příklad teploty a pohodlí výslovně rozvíjí Howella (s. 7–8).
Jeho bibliografické údaje byly znovu potvrzeny na titulní a copyrightové
straně místního PDF: *Statistical Methods for Psychology*, 8. vydání,
2013, Wadsworth/Cengage, ISBN 978-1-111-83548-4. Oddíl 1.3 (s. 6–8)
zůstává oporou rozlišení významu čísel a měřené vlastnosti. Po dohodě
nepřebíráme obecný závěr, že úroveň měření není pro volbu postupu důležitá;
rozlišujeme interpretaci měření od přiměřenosti konkrétní analýzy.

Odborné doplnění a ověřené lokátory:

- Henrich, Heine a Norenzayan (2010), oddíl 2: úzké zastoupení populací;
  nejde o doklad univerzálního procenta příležitostných výběrů v psychologii.
- Simons, Shoda a Lindsay (2017), s. 1123: požadavek vymezit a zdůvodnit
  populaci, na kterou závěr vztahujeme.
- Michell (1997), s. 355: odlišení doložení kvantitativnosti vlastnosti
  od konstrukce číselného měřicího postupu.
- Liddell a Kruschke (2018), oddíl 1: rizika metrické analýzy ordinálních
  výsledků; necitujeme je jako zákaz všech přibližných postupů.
- Borsboom a Mellenbergh (2002), s. 507–510: rozdíl mezi pravým skórem
  testu a konstruktem; vlastní jazykový příklad není převzatou studií.

Metadata všech pěti článků (autoři, roky, ročníky, čísla, strany a DOI)
ověřena přes `https://api.crossref.org/works/{DOI}` a vydavatelské záznamy;
úplný podtitul Borsboomova článku ověřen v autorském PDF
https://dennyborsboom.com/wp-content/uploads/2017/11/borsboomtruescores2002.pdf.
Henrichův oddíl 2 ověřen v autorském PDF
https://www2.psych.ubc.ca/~henrich/pdfs/WeirdPeople.pdf.
Liddellův článek v ročníku 79 nemá v ověřených metadatech číslo časopisu;
žádné není domýšleno. DOI jsou ve společné bibliografii, citace zpracovává
dosavadní APA 7 CSL. Počáteční slova podtitulů jsou chráněna před
nežádoucím převedením na malá písmena citačním procesorem.

Slovníček doplněn o osm hesel (celkem 44); testový skór a reprezentativnost
zachycují pojmy použité ve schváleném výkladu. Nové symboly, vzorce ani
excelové funkce se nezavádějí, proto zůstávají příslušné přehledy beze změny.
Rozšířeny úlohy 1, 2, 4, 6 a 7, včetně úplných řešení. Původních osm
identifikátorů úloh zůstává zachováno.

Práce probíhá v oddělené pracovní kopii z `origin/main` (93c7614).
Původní místní úpravy kapitoly a nesledovaný soubor Rproj zůstaly v původní
pracovní kopii nedotčené a nejsou součástí tohoto pull requestu.

Ověření konečného znění:

- Celá kniha (pět stránek) úspěšně vykreslena v Quarto 1.9.38.
- `check-chapter-01.R` prošel v R 4.5.1: původní datová matice,
  chybějící údaje, elementární výpočty a řešení úlohy 8. R při startu
  hlásilo nedostupnou lokalizaci C.UTF-8; kontroly skončily úspěšně.
  Nové jednoduché vztahy (40/20 = 2, shodné pětibodové rozdíly IQ)
  a všechna doplněná konceptuální řešení zkontrolovány věcně, bez simulací.
- `check-html.cjs` prošel v Chrome: pět stránek, 44 hesel slovníčku,
  všech osm sbalených řešení, klávesnice, přechody osnovou, místní odkazy,
  jedinečné identifikátory, vyhledávání včetně nových anglických názvů
  a českých alternativ, stránkování a odkazy přes aktivní filtr.
- Nepovinný rámeček ověřen sbalený, otevřený klávesnicí a čitelný bez
  JavaScriptu; otevřený nepřetéká na mobilu. Zůstalo ověření řešení
  bez JavaScriptu a navigace přes `file://`.
- Desktop při 1360 a 1920 px i mobil při 390 px bez přetékání celé stránky;
  žádné chyby JavaScriptu ani únik interního R kódu či soukromých zdrojů.
- Nové tabulky, kvaziintervalový výklad, rámeček a literatura prohlédnuty
  vizuálně na kontrolních snímcích. Prověřeno všech 18 citačních výskytů
  a všech pět nových bibliografických záznamů v HTML včetně iniciál,
  pořadí autorů, let, kurzivy, podtitulů a odkazů DOI. DOI byly ověřeny
  proti veřejným registrům a vydavatelským/autorským záznamům; přístup
  k plnému textu na webu vydavatele může vyžadovat předplatné.
- `git diff --check` bez chyb. Nové rovnice ani grafy nevznikly;
  desktopový Excel se znovu nespouštěl, protože jeho příklady se neměnily.
- Veřejné nasazení této změny není lokálními kontrolami potvrzeno;
  následuje až po uživatelském sloučení a úspěšném publikačním workflow.

## Základ knihy

`_quarto.yml` vykresluje pouze `index.qmd` a studentské soubory `quarto/*.qmd`.
Adresář `sources/`, tato dokumentace a kontrolní skripty se nepublikují.
Tři závěrečné přehledy zatím mají připravenou tabulkovou strukturu;
jejich obsah přibývá s výkladovými kapitolami.

Tabulky používají malý místní skript bez externí knihovny. Vyhledávají
ve všech řádcích, také bez diakritiky. Odkaz na ID položky zruší filtr
a zobrazí správnou stránku. Bez JavaScriptu jsou všechny řádky dostupné.
Prázdné přehledy nemají fiktivní položky. Ovládání používá nativní
vstupy, tlačítka a výběrové pole, stav má atribut `aria-live`.

Před publikací je nutné zkontrolovat nejen render, ale i klávesnici,
mobilní zobrazení, skrytí řešení a odkazy přes filtr/stránkování.

## Ověření

Použito Quarto 1.9.38 z instalace RStudia, Node.js a Playwright z lokálního
balíku pracovních závislostí, prohlížeč Google Chrome.

Základ knihy: úplný render čtyř stránek úspěšný; kontrola všech místních
odkazů, jedinečných ID, ovládání prázdných tabulek a šířky 390 px prošla
bez JavaScriptových chyb. Mobilní podoba prázdného slovníčku prohlédnuta.
Základ zatím neobsahuje řešení ani matematiku; jejich ověření nebylo
předmětem této kontroly. Publikace na Pages čeká na sloučení a nastavení
zdroje GitHub Actions; živé nasazení dosud nebylo ověřeno.

<a id="terminologie-zaklad-01"></a>

## Kapitola Od psychologické otázky k datům

### Dohodnutý obsah a původ příkladů

Kapitola sleduje schválenou osnovu od otázky přes proměnné, populaci a výběr,
kauzalitu, operacionalizaci, úrovně měření a nejistotu k datové matici.
Četnosti, grafy, rozdělení dat, charakteristiky polohy a variability,
výpočty skórů, testy a intervaly spolehlivosti jsou záměrně odloženy.

Všechny studie a úlohy jsou vlastní modelové příklady. Údaje P01–P06
a K01–K03 jsou ručně vytvořená smyšlená výuková data, ne výzkumné výsledky
ani výstup náhodné simulace. Nevyžadují seed a netvrdíme na jejich základě
existenci vztahu spánku a paměti. Ukázka zvuku při učení vysvětluje
experimentální srovnání; nenabízí skutečný odhad účinku.

### Zdroje a rozhodnutí při jejich využití

| Zdroj | Využití a kontrola |
|---|---|
| Howell, Statistical Methods for Psychology, 8. vydání, 2013 | Základní rámec kapitoly; titul ověřen v PDF na straně 3, copyright a ISBN na straně 6. |
| Navarro, Learning Statistics with R, kap. 1–2 | Motivace, operacionalizace a interpretace výzkumu. Lokální PDF má novou předmluvu k převodu do Quarta; nepřiřazujeme mu automaticky rok původní verze 2015. Přesné datum vydání revidované kopie není uvedeno, proto je záznam bez data. |
| Cumming a Calin-Jageman, Introduction to the New Statistics, 2. vydání, 2024, kap. 1–2 | Nejistota a transparentnost jako průběžné téma. Rok a DOI ověřeny na PDF straně 9. Formální inferenční aparát zatím nepřebíráme. |
| Aron, Aron a Coups, Statistics for Psychology, 6. vydání, Pearson New International Edition, 2014 | Rozlišení proměnné, hodnot a konkrétního záznamu; diskrétnost a spojitost (tištěné strany 3–5). Četnosti a grafy odloženy. |
| Privitera, Statistics for the Behavioral Sciences, 4. vydání, 2024, kap. 1 | Populace/výběr, základní logika uspořádání výzkumu. Nepřebíráme širokou klasifikaci kvaziexperimentů ani tvrzení, že běžná praxe sama zdůvodňuje intervalovost. |
| Dostál, Statistické metody v psychologii, studijní opora 2022/23 | Datová matice a druhy proměnných, oddíl 5.1. Rok 2022 v bibliografii označuje začátek akademického roku uvedeného na titulu. Oddíly 3.1–3.2 budou využity při četnostech a grafech. |
| Lord (1953); Zand Scholten a Borsboom (2009) | Rozlišení číselného označení a reprezentované vlastnosti; nikoli argument pro libovolnou analýzu nominálních kódů. Jméno první autorky: Annemarie Zand Scholten. |
| Broman a Woo (2018), Data Organization in Spreadsheets | Pravidla konzistentní organizace a dokumentování údajů. Jejich preferenci nenumerického označení chybění nepřebíráme jako univerzální zákaz jiných postupů. |
| Podklady v sources/kapitola 1: prezentace, oba PDF ke kódování a Základy tvorby datové matice.docx | Autorské podněty k organizaci dat a příkladům. Nepřebíráme jejich konkrétní tabulky, obrázky ani dotazníkové položky. Vlastní český výklad a malé modelové matice. |

### Podstatná zpřesnění oproti některým podkladům

- `sec-urovne` až `sec-pomerova`: úroveň měření je zdůvodněna vztahy mezi
  hodnotami a měřenou vlastností. Počet správných odpovědí se poměrově
  interpretuje jako počet, ne automaticky jako obecná paměťová schopnost.
- `sec-souvislost-pricina`: náhodný výběr není náhodné rozdělení. Losování
  nezaručuje identické skupiny a nenahrazuje kontrolu dalších rozdílů.
- `sec-kodovani`: názvy jsou konvencí; numerické kódování není povinné;
  identifikátor není pořadím řádku a při opakovaném měření se může opakovat.
- `sec-chybejici`: −99 je přípustné pro přepis s následným ošetřením ve
  statistickém programu. Pro přímé výpočty v Excelu používáme prázdnou
  buňku a podle potřeby samostatný důvod chybění. Výpočet nenahrazuje
  kontrolu úplnosti; nula není totéž co nepozorovaný výkon.
- `sec-codebook`: kromě názvů jsou nutné význam, časový rámec, jednotky,
  přípustné hodnoty a chybění. Hodnota uvnitř rozsahu nezaručuje správnost.

### Terminologie a značení

Slovníček obsahuje 36 zavedených položek s českými a anglickými názvy,
alternativami a odkazy na první výklad. Preferujeme případ, úroveň měření
(alternativa škála měření), popisná a inferenční statistika (alternativa
induktivní statistika). Pozorování má kontextově vysvětlený význam.
Kapitola nezavádí vzorce ani matematické symboly; ID je zkratka
identifikátoru a je ve slovníčku. Nezavádí ani konkrétní funkci Excelu:
součet se zmiňuje jen jako příklad interpretačního rizika. Přehledy
značení a funkcí proto zůstávají přístupné prázdné tabulky s vysvětlením.

### Pokrytí cvičení

| Úloha | Co ověřuje |
|---|---|
| 1 | Případ, proměnná, hodnota, rozlišení účastníků a opakovaných záznamů |
| 2 | Účel statistiky, populace/výběr, omezení zobecnění |
| 3 | Rozlišení popisu, inference a kauzálního tvrzení |
| 4 | Náhodné rozdělení, nejistota složení skupin a další rozdíly podmínek |
| 5 | Konstrukt a operacionalizace, nesrovnatelnost odlišných ukazatelů |
| 6 | Argumentace o všech čtyřech úrovních měření, diskrétnost/spojitost |
| 7 | Chyba měření, zkreslení, nejistota z výběru, skutečné rozdíly a opravy |
| 8 | Oprava matice, ID, jednotky, přehled proměnných a chybění v Excelu/exportu |

Návraty k měření, výběru a chybění jsou záměrné: úlohy postupují od
rozlišení pojmů k posouzení argumentu a opravě konkrétního záznamu.
Žádná úloha nevyžaduje neveřejný podklad ani dosud nevyloženou metodu.

### Ověření kapitoly

- Úplný render pěti stránek v Quarto 1.9.38 prošel.
- `check-html.cjs`: 36 položek slovníčku; hledání v celém obsahu i bez
  diakritiky, velikosti stránek 10/25/50/všechny, přímý odkaz na položku
  za první stránkou a zrušení aktivního filtru, místní odkazy a jedinečná ID.
- Všech osm řešení je zpočátku skrytých a lze je otevřít klávesnicí
  a znovu zavřít. Mobilní šířka 390 px prošla i s otevřenou tabulkou řešení.
- Bez JavaScriptu jsou všechny položky slovníčku i všech osm řešení
  čitelné. Ověřeno také hledání poslední položky mimo první stránku.
- Opraveno přetékání dlouhého DOI na mobilu. Doplněny fokus a klávesnice
  pro rozbalovací hlavičky Quarta a posouvatelné tabulky.
- Vizuálně prohlédnuty úvod kapitoly na mobilu, ukázky měření a matice,
  codebook, naplněný slovníček a celé otevřené řešení poslední úlohy.
- `Rscript --vanilla quarto/_verification/check-chapter-01.R`: matice,
  přípustné hodnoty, chybění, opravená matice úlohy 8 a elementární
  výpočty prošly v R 4.5.1. Relace nepoužívá balíčky ani předchozí objekty.
  Systém hlásil nedostupné locale C.UTF-8, kontroly však úspěšně dokončil.
- `check-excel.ps1`: skutečně spuštěn samostatný skrytý Excel 16.0.
  SUMA(A1:C1) pro prázdné buňky vrací 0; součet 3, prázdné buňky a 4
  vrací 7. Dočasný sešit zavřen bez uložení. Tím je ověřeno konkrétní
  chování, které text zmiňuje; nejde jen o kontrolu jiným výpočetním nástrojem.
  Dokumentace funkce: https://support.microsoft.com/en-us/excel/functions/sum-function.
- Odpovědi na konceptuální úlohy byly obsahově zkontrolovány proti zadání
  a výkladu; automatické kontroly nehodnotí správnost celé argumentace.
- Žádný R kód, původní učebnice ani autorská dokumentace nejsou ve webu.
  Kapitola neobsahuje grafy ani matematické rovnice; jejich vizuální
  ověření se na tuto kapitolu nevztahuje.
- Přímý přenos do SPSS/JASP/R a živé nasazení na GitHub Pages nebyly
  provedeny. Text neobsahuje návod na konkrétní import; publikování
  čeká na uživatelské sloučení a konfiguraci Pages.

## Vycentrování, pravý obsah a README (2026-09-20)

Rozložení bylo porovnáno s místním projektem R101-textbook. Levý panel
používá `style: floating`; stejně široké boční sloupce ponechávají hlavní
text uprostřed okna. Pravá osnova má nadpis „Obsah kapitoly“ a zachovává
dosavadní hloubku dvou úrovní nadpisů.

Prázdná osnova byla reprodukována při přímém otevření vykresleného HTML
přes `file://`: prohlížeč blokuje modulový skript Quarta a kořenový seznam
obsahu zůstává ve výchozím stavu sbalený. Pravidlo `#TOC > ul` ve společném
CSS udržuje hlavní odkazy viditelné i bez tohoto skriptu. Oprava nenahrazuje
plnou funkčnost webu při přímém otevírání souborů; pro běžnou práci slouží
`quarto preview`. Na mobilu zůstává pravý panel skrytý. Stránky bez
podnadpisů samostatnou osnovu nevytvářejí.

README nyní po vzoru R101 popisuje cílovou skupinu, aktuální obsah,
strukturu projektu, sestavení, kontroly a publikování. Rozlišuje kontroly
spouštěné v GitHub Actions od místních kontrol R a desktopového Excelu.

Ověření:

- Úplný render pěti stránek v Quarto 1.9.38 úspěšně dokončen.
- `check-html.cjs` prošel v Google Chrome: vycentrování všech pěti stránek
  při 1360 a 1920 px, zobrazení celé hlavní osnovy, přechod na oddíl
  klávesnicí, viditelnost osnovy bez JavaScriptu i při otevření přes `file://`.
- Zachováno ověření 36 položek slovníčku, hledání a stránkování, všech osmi
  sbalených řešení, místních odkazů a absence chyb JavaScriptu přes HTTP.
- Šířka 390 px bez přetékání celé stránky, včetně otevřeného řešení;
  pravý panel na mobilu skrytý. Vizuálně prohlédnut úvod kapitoly
  na desktopu a mobilu a slovníček na mobilu.
- Obsah kapitoly ani data se neměnily; kontroly R a Excelu nebyly opakovány.
  Kapitola neobsahuje matematické rovnice ani grafy.
- Nová podoba veřejného webu není tímto lokálním ověřením potvrzena;
  bude publikována až po uživatelském sloučení a úspěšném nasazení.

## Citování podle APA 7 (2026-09-20)

Celá kniha používá `csl: styles/apa.csl` a společnou bibliografii
`references.bib`. Jde o nezměněný styl **APA Style 7th edition** z projektu
Citation Style Language, stažený 2026-09-20:
https://raw.githubusercontent.com/citation-style-language/styles/master/apa.csl.
Verze uvnitř souboru je datována 2026-02-07; SHA-256:
`1ECE4FB3C295E66D04B4394E295AA58A87741CEEEF1658192437EB9953C2F13E`.
Autoři a licence CC BY-SA 3.0 jsou zachováni v hlavičce souboru. Místní kopie
umožňuje reprodukovatelné sestavení bez stahování stylu při renderování.
Použití CSL v Quartu: https://quarto.org/docs/authoring/citations.html.

V kapitole byly upraveny čtyři narativní citace: rok následuje přímo
za autorem a jméno se znovu neopakuje v závorce. U Arona a spoluautorů
se používá automatický zápis `Aron et al. (2014, s. 3–5)`. České lokátory
zpracovává citační procesor; standardní CSL ponechává v bibliografii
anglické označení vydání a chybějícího data (`ed.`, `n.d.`), zatímco
v českých citacích v textu používá `b.r.`. Styl nebyl lokálně přepisován.

Názvy v bibliografii byly převedeny na větnou velikost písmen se zachováním
vlastních jmen a názvu R. Doplněny ověřené údaje:

- Lord (1953): číslo 12 a DOI https://doi.org/10.1037/h0063675;
  ročník 8 a strany 750–751 potvrzeny v metadatech Crossrefu
  https://api.crossref.org/works/10.1037/h0063675.
- Zand Scholten a Borsboom (2009): číslo 2, ověřeno u vydavatele
  https://www.sciencedirect.com/science/article/pii/S0022249609000054.

U revidované učebnice Navarro zůstává datum neuvedené, protože pro
použitou verzi není doložené. Ostatní zdrojové údaje navazují na ověření
při přípravě kapitoly popsané výše; nešlo o nové úplné bibliografické šetření.

Ověření: úspěšný render všech pěti stránek v Quarto 1.9.38, kontrola HTML
v Chrome včetně devíti bibliografických záznamů, reprezentativních citací
APA, kurzivy názvu knihy, DOI, dosavadních odkazů, řešení, slovníčku
a mobilního rozložení. Všech 12 citačních výskytů bylo prohlédnuto ve
vykreslené podobě; seznam literatury také vizuálně na desktopu a mobilu.
Číselné příklady ani řešení se neměnily, kontroly R a Excelu se neopakovaly.
Publikace této změny bude následovat až po uživatelském sloučení a nasazení.


<a id="terminologie-zaklad-02"></a>

## Kapitola 2: četnosti a grafy (2026-09-28)

### Dohodnutý obsah a návaznost

Kapitola vznikla po výslovném schválení rozsahu, značení, příkladů a terminologie. Označení „kapitola 3“ v závěru přípravy uživatel opravil na kapitolu 2. Výklad zahrnuje absolutní, relativní a kumulativní četnosti, jmenovatele a chybění, procenta a zaokrouhlování, sumaci, intervalové třídění a ztrátu podrobností, hlavní druhy grafů, popis tvaru a limity interpretace. Kontingenční tabulky zůstávají pro vztah dvou kategoriálních proměnných. Číselné charakteristiky polohy a variability ani percentily se zde nezavádějí.

Původně bylo schváleno n, f_i, p_i, k a jako první index i; od revize 2026-10-04 používáme pro kategorie j (viz níže). Kumulativní varianty mají slovní index kum. Sumace je nejprve rozepsána na malé tabulce. Podíly zobrazujeme na tři desetinná místa, procenta na jedno, mezivýpočty nezaokrouhlujeme. Primární termíny jsou „odlehlé pozorování“, „výsečový graf“, „graf stonek a list“ a „chvost“. Schválené alternativy jsou ve slovníčku; extrém není automaticky odlehlý. Nestejně široké intervaly jsou pouze sbalené rozšíření s vysvětlením výšky a plochy, bez zavedení nového formálního pojmu hustoty. Excelové ilustrace jsou přiznané rekonstrukce, nikoli vydávané za snímky aplikace.

Přidáno 28 položek slovníčku, 13 řádků značení a 3 funkce Excelu. Výklad nezobrazuje interní kód R. Deset cvičení pokrývá výpočet, volbu grafu, čtení hranic, ztrátu informace, kritiku argumentů a práci v Excelu.

### Data a původ příkladů

`data/kapitola_02.csv` obsahuje 36 záměrně sestavených modelových účastníků; nejde o skutečný výzkum ani náhodný výběr simulátoru. Prvních šest záznamů přesně navazuje na kapitolu 1 včetně čtyř kategorií odpočatosti, chybějícího spánku P05 a skutečné nuly vybavených slov P06. Spánek dále chybí u P11 a P24. Odpočatost má četnosti 4, 10, 14, 8; intervaly spánku od 4 do méně než 10 hodin mají četnosti 2, 4, 7, 11, 6, 3. Grafy tvarů, podlahy a stropu, hlavní způsob přípravy a rozdíl 30 versus 32 jsou oddělené pevné didaktické příklady. Veškerá data, úlohy a obrázky jsou vlastní; z učebnic nebyly převzaty tabulky ani ilustrace. Náhodné postupy se nepoužívají, seed tedy není potřeba.

### Posouzení zdrojů

Prohlédnuty relevantní části všech sedmi místních PDF. Základem je ověřený Howell: *Statistical methods for psychology*, 8. vydání, 2013, Wadsworth/Cengage Learning, ISBN 9781111835484. Hlavní opora: kapitola 2, tištěné s. 16–29 (PDF 40–53), zejména volba intervalů s. 20–21 a tvary s. 27–29. Privitera, 4. vydání (2024), kapitola 2, s. 35–64: relativní a kumulativní četnosti s. 41–44, histogram a polygon s. 57–59, stonek a list s. 60–61. Dostál (2022/23), oddíl 3.2.1, tištěné s. 44–46, slouží jako česká terminologická opora. Cumming a Calin-Jageman, 2. vydání (2024), s. 43–47 a 67, podporují práci s jednotlivými pozorováními a kritické čtení grafů. Aron et al., mezinárodní 6. vydání (2014), s. 7–8 a 16–19, poskytují základní didaktické srovnání. Navarro (revidovaná nedatovaná verze), kapitola 6, a Sahu (2024), kapitola 2, byly posouzeny; programátorský výklad se do studentského textu nepřenáší.

Nepřebíráme omezení histogramu pouze na spojité proměnné ani univerzální pravidlo počtu intervalů. Hranice určujeme výslovně jako dolní včetně, horní mimo interval. NIST, oddíl Definition na https://www.itl.nist.gov/div898/handbook/eda/section3/eda33e.htm, podporuje rozlišení četnosti a výšky přepočtené na šířku intervalu. Doporučení sloupců pro přesné porovnání podílů opíráme o Cleveland a McGill (1984), JASA 79(387), 531–554, DOI 10.1080/01621459.1984.10478080, zvláště experimenty na s. 536–541; netvrdíme, že každý výsečový graf je nepřípustný nebo že člověk využívá jen úhly.

Funkce POČET/COUNT, SUMA/SUM a COUNTIFS/COUNTIFS i rozdíl mezi původními daty a tabulkou četností u nativního histogramu byly ověřeny v české dokumentaci Microsoftu (odkazy v `references.bib`, přístup 2026-09-28). Názvy nebyly překládány odhadem. Všechny citace používají společnou APA 7 CSL a bibliografii, bez ručního formátování. Neveřejné PDF nejsou součástí webu.

### Sestavení a ověřené výpočty

Celá kniha se sestavila v Quarto 1.9.38. Grafy vznikají v základním R 4.5.1; nový `scripts/render-figures.R` nastavuje ve Windows UTF-8 pro správnou českou diakritiku. Původní nastavení systému hlásí nedostupné locale C.UTF-8; samotný kontrolní výpočet tím není ovlivněn. Vizuální kontrola odhalila chybné popisky při původním načítání skriptu, které explicitní UTF-8 opravilo.

`check-chapter-02.R` ověřil původních šest záznamů, úplnost nových dat, tabulky, zaokrouhlení, intervalové hranice, kumulativní podíly a všechna číselná řešení. Nezávisle byly četnosti sestaveny v Pythonu při tvorbě ilustrací. Konceptuální řešení byla redakčně porovnána s výkladem a zadáním; jejich správnost nenahrazuje automatický test.

Sešit byl vytvořen pomocí @oai/artifact-tool, všechny tři listy prohlédnuty ve vykreslených náhledech. Následný `check-chapter-02-excel.ps1 -Finalize` skutečně běžel v samostatném skrytém Excelu 16.0: ověřil 180 vstupních buněk proti CSV, českou syntaxi z výkladu, četnosti, plné podíly, součty a obě změny z posledního cvičení včetně přepočtu dat grafů. Změny vstupů vrátil do původního stavu. Excel zobrazuje 0,111 a 11,1 %, nikoli předem zaokrouhlené mezivýpočty. V nativním Excelu byla doplněna nulová mezera histogramu a nulové minimum os; tyto vlastnosti nepokrývalo použité rozhraní pro tvorbu sešitu. Oba grafy byly z Excelu exportovány a vizuálně prohlédnuty.

Matematika používá nativní MathML, protože externí MathJax CDN se při kontrole nenačetlo. Jde o přístupný matematický zápis v HTML, nikoli obrázky. Podpora nastavení je popsána v oficiální dokumentaci https://quarto.org/docs/output-formats/html-basics.html#latex-equations. Tím se odstraňuje síťová závislost a umožňuje vykreslení i bez JavaScriptu v moderním prohlížeči. Dolarové znaky excelových vzorců v HTML přehledu jsou zapsány entitou, aby nebyly nesprávně rozpoznány jako oddělovače matematiky.

### Webová kontrola a meze ověření

Závěrečný `check-html.cjs` prošel v Chrome: všech šest stránek, 78 položek slovníčku, 13 položek značení a tři funkce Excelu; interní odkazy a jedinečné identifikátory; všech 18 řešení v knize (deset nových) skrytých při načtení, otevření klávesnicí a opětovné sbalení. Ověřeno vyhledávání přes všechny řádky včetně anglických názvů a českých alternativ, velikosti stránek 10/25/50/všechny, přímé odkazy na řádky přes stránkování i aktivní filtr a čitelnost matematického zápisu. Šířky 1360 a 1920 px i mobilních 390 px bez přetékání celé stránky; posouvají se jen široké tabulky. Navigace funguje také při otevření přes file://; bez JavaScriptu jsou přehledové řádky a řešení dostupné. Kontrola nenašla chyby JavaScriptu ani chybějící místní soubory.

Vizuálně prohlédnuto všech deset grafů a tři rekonstrukce listů, matematické vzorce na desktopu i mobilu, přehled značení a excelový přehled. Opravena oříznutá legenda výsečového grafu a nedostatek prostoru pod intervalovou tabulkou. Vykreslených 15 citačních výskytů a 11 záznamů použitých ve druhé kapitole bylo zkontrolováno; společný seznam knihy obsahuje 23 zdrojů. Při původním dokončení kapitoly Quarto umísťovalo společnou bibliografii do prvního výskytu bloku refs v kapitole 1 a v dalších kapitolách ponechávalo skryté podklady citací. Závěr kapitoly 2 proto tehdy obsahoval viditelný odkaz na společný seznam. Toto umístění nahrazuje níže popsaná samostatná kapitola Literatura. Nejde o ručně sestavenou bibliografii.

Ověření Excelu se vztahuje na místní desktopový Excel 16.0, nikoli na všechny verze nebo živé klikání všemi nabídkami. Web byl vizuálně a funkčně ověřen v Chrome, nikoli ve všech prohlížečích a čtečkách obrazovky. Veřejné publikování nové kapitoly nebylo provedeno: následuje až po uživatelském sloučení a úspěšném nasazení. Původní necommitované redakční změny kapitoly 1 a místní Rproj zůstaly zachovány a nejsou součástí commitu této kapitoly.

## Členění knihy a samostatná literatura (2026-09-28)

Po schválení uživatelem má navigace dvě části Quarto Book (`part`): **Výkladové kapitoly** s dosavadními kapitolami 1 a 2 a **Literatura a přehledy** se samostatnou nečíslovanou literaturou a třemi závěrečnými přehledy v původním pořadí. Úvod „O učebnici“ stojí před oběma částmi. Skupiny lze rozbalovat a sbalovat; textová hlavička i šipka mají doplněnou roli tlačítka, vazbu aria-controls, možnost zaměření a reakci na Enter a mezerník. Tematické dělení výkladu zůstává pro budoucí dohodu o osnově.

`quarto/literatura.qmd` obsahuje jediný zdrojový blok refs. Z konců výkladových kapitol byly odstraněny původní bibliografické oddíly. Citační databáze, APA 7 CSL a zápisy citací se nemění; Quarto směruje citace na společnou stránku a generuje tam 23 použitých zdrojů. Skryté podklady pro citační náhledy na jednotlivých stránkách jsou běžnou součástí výstupu Quarta, nikoli další viditelné seznamy. Upraven byl také úvod a provozní README.

Oba výkladové texty před odstraněným bibliografickým oddílem byly porovnány kontrolním součtem s jejich stavem na začátku práce: jsou shodné včetně rozpracovaných uživatelských úprav první kapitoly. Do commitu se z prvního souboru zahrnuje pouze odstranění bibliografického oddílu. Číselné příklady, grafy ani excelový sešit se nemění, jejich obsahové kontroly proto nebyly opakovány.

Ověření: úplný render sedmi stránek v Quarto 1.9.38 a rozšířený check-html.cjs v Chrome prošly. Test ověřuje samostatně viditelnou bibliografii s 23 zdroji, cíle citací z obou kapitol, průběžné číslování 1 a 2, pořadí dvou skupin a jejich položek, sbalení myší a otevření i sbalení klávesnicí. Na mobilu ověřuje otevření navigace, rozbalení skupiny a přechod na literaturu. Zachovány jsou kontroly místních odkazů, matematiky, přehledových tabulek a všech 18 řešení. Rozložení při 390, 1360 a 1920 px nevyvolává přetékání celé stránky; bibliografie je čitelná také bez JavaScriptu. Navigace i nová stránka literatury byly vizuálně prohlédnuty na desktopu a mobilu. Ověření není testem všech prohlížečů; veřejný web se aktualizuje až po uživatelském sloučení a nasazení.

## Kapitola 2: indexy, procenta a výlučnost kategorií (2026-10-04)

Na výslovné schválení uživatele je index j vyhrazen kategoriím, hodnotám, intervalům či skupinám; index i jednotlivým pozorováním. Změna zahrnuje f_j, p_j, kumulativní četnosti, meze a slovní čtení sumací, tabulky i cvičení. Číselné indexy (např. f_2) se nezměnily. Přehled značení eviduje oba indexy, slovníček vysvětluje novou konvenci. Značení x_i a x_ij se zatím do výkladu nezavádí.

Relativní četnost 0 a 1 je výslovně propojena s 0,0 % a 100,0 %. Nový vlastní modelový příklad odlišuje vzájemně výlučné odpovědi na odpočatost od souběžně používaných strategií učení. Deset studentů označí jedenáct odpovědí: podíly lidí jsou 60,0 % a 50,0 %, podíly odpovědí 54,5 % a 45,5 %. Výklad odlišuje výlučnost od pokrytí všech případů. Pojem je doplněn do slovníčku s anglickým ekvivalentem a odkazem. Zachována a zahrnuta je již rozpracovaná uživatelská redakce druhé kapitoly; v dotčeném odstavci opraveno gramatické „zaznamenán dobu“ na „zaznamenánu dobu“.

Ověření: check-chapter-02.R prošel v čisté relaci R. Nový příklad byl nezávisle přepočten v Pythonu z deseti jednotlivých souborů odpovědí, včetně přesných zlomků a zaokrouhlení. Zkontrolována vzorová řešení a zachování číselných indexů. Celá kniha (sedm stránek) byla úspěšně vykreslena; první pokus blokovala přístupová práva k mezipaměti Quarta, opakovaný render s potřebným přístupem prošel.

check-html.cjs v Chrome prošel: 79 hesel slovníčku, místní odkazy, všech 18 řešení skrytých/otevřených/opět sbalených i klávesnicí, přehledové tabulky a mobilní šířka 390 px bez přetékání stránky. Doplňkově ověřeno hledání „mutually exclusive“, zobrazení řádku znak-j při aktivním nesouvisejícím filtru a matematika bez merror. Vizuálně prohlédnut nový text na desktopu i mobilu, procentní vyjádření, indexy a sumace. Data, grafy a excelové vzorce se nemění; desktopový Excel se znovu nespouštěl. Kontrola není ověřením všech prohlížečů. Publikování následuje až po uživatelském sloučení a nasazení.


## Kapitola 2: sjednocení názvů četností (2026-10-04)

Po schválení uživatelem používá kapitola při pojmenování veličin absolutní četnost a kumulativní absolutní četnost místo střídání s „počty“ a „kumulativními počty“. Úprava zahrnuje cíle učení, zaokrouhlování, kumulativní tabulku, výklad os histogramu, excelový postup, alternativní popisky obrázků a vzorová řešení. V související větě je sjednoceno i označení kumulativní relativní četnosti. Slovo počet zůstává v definicích a interpretacích, u hodnot proměnných (počet slov/chyb), rozsahu souboru, počtu kategorií a v názvu funkce POČET. Věcné popisky os „Počet účastníků“ zůstávají zachovány.

Zachována a zahrnuta je aktuální uživatelská redakce kapitoly, včetně zkrácení příkladu vícečetných odpovědí. Nová terminologická úprava nemění čísla, data ani výpočty; číselné zápisy byly porovnány s pracovním stavem bezprostředně před úpravou. Check-chapter-02.R prošel, dotčená kapitola se vykreslila a sekce kumulativních četností byla vizuálně prohlédnuta na desktopu a mobilu. Vzorce a číselná řešení byly zkontrolovány v rozdílech. Excelový sešit a vzorce se nemění a desktopový Excel nebyl znovu spuštěn. Publikování následuje po uživatelském sloučení.

Webová kontrola check-html.cjs prošla na všech sedmi stránkách: místní odkazy, 79 hesel, všech 18 řešení a jejich ovládání klávesnicí, přehledové tabulky, desktop i mobilních 390 px bez přetékání celé stránky; bez hlášených chyb. git diff --check prošel.


## Kapitola 2: revize podle jedenácti připomínek (2026-10-05)

### Výklad a příklady

Zapracováno všech jedenáct připomínek autora. Obecný pojem rozdělení je vysvětlen před popisem rozdělení četností, s odlišením pozorovaných dat, populace a modelu. Kumulování nominálních kategorií ukazuje vlastní příklad stejných četností 12, 14 a 10 ve dvou pořadích: průběžná kumulativní četnost u čtení je 12, nebo 26. Nejde o změnu dat.

Nová srovnávací tabulka přiřazuje stejné doby spánku do intervalů zleva uzavřených/zprava otevřených a naopak. V první variantě jsou četnosti 2, 4, 7, 11, 6, 3; ve druhé 3, 5, 8, 10, 5, 2. Oba součty jsou 33. Vysvětleno zařazení 7,0 a zacházení s případnými novými krajními hodnotami 4,0 a 10,0. Navazující příklady i excelový sešit zachovávají původní variantu. Tabulka má vlastní minimální šířku a posuvnou oblast přístupnou klávesnicí; její šířka nemění ostatní tabulky.

Volba šířky intervalů je spojena s otázkou, jednotkami, přesností dat, rozsahem a počtem pozorování; kontrolujeme několik blízkých nastavení. Nový vlastní graf seskupených kumulativních četností vychází z týchž 33 dob spánku. Na hranicích 4 až 10 hodin používá kumulativní absolutní četnosti 0, 2, 6, 13, 24, 30, 33 a zobrazuje jejich procentní vyjádření. Výslovně čte „méně než“, nikoli „nejvýše“. Plné body představují hodnoty známé z tabulky, přerušované spojnice neudávají přesné rozložení uvnitř intervalů. Střed intervalu je vysvětlen výpočtem 7 − 6 = 1, 1 / 2 = 0,5, 6 + 0,5 = 6,5.

Doplněno rovnoměrné rozdělení, nesouměrnost zešikmeného rozdělení a vícevrcholové/multimodální rozdělení. Panel se stejnými četnostmi nově nese název Rovnoměrné rozdělení. Termín multimodální má v literatuře i širší význam zahrnující bimodalitu; tato varianta je uvedena v textu i slovníčku. Odlehlá pozorování vždy nejprve zkoumáme, samotná odlehlost nedokazuje neplatnost a nestačí k vyřazení. Nejasné „obrázkové symboly“ nahrazuje vysvětlení siluet osob a čtyřnásobné plochy při dvojnásobné výšce i šířce. Rozšířeny odpovídající části úloh 5 a 7 i jejich úplná řešení, počet úloh zůstává deset.

Do slovníčku přibylo osm hesel (rozdělení, otevřená/uzavřená hranice, oba druhy polouzavřených intervalů, střed intervalu, rovnoměrné a vícevrcholové rozdělení); přehled značení obsahuje výpočet středu. Excelový přehled se nemění, nová funkce se nezavádí. Žádná nová symbolická proměnná ani intervalové závorkové značení nebyly zavedeny.

### Zdroje a věcné opravy

Znovu ověřen titul a tiráž Howella: Statistical methods for psychology, 8. vydání, 2013, Wadsworth/Cengage Learning, ISBN 9781111835484. Výklad navazuje na tištěné s. 17 (četnosti), 20–21 (hranice, středy a volba šířky), 27–29 (tvary a interpretace). Tištěné s. 20 byly prohlédnuty i obrazově. Howellovo doporučení zacházet s hraničními případy volně nepřebíráme; používáme explicitní jednotné pravidlo vhodné k reprodukování v Excelu.

Privitera (2024), tištěná s. 59 (PDF 104), ověřena textově i obrazově jako opora grafu kumulativních četností na horních hranicích; do našeho grafu nejsou přebírána jeho data ani obrázek. Aron et al. (2014), tištěná s. 16 (PDF 21), ověřena také obrazově jako doklad širšího významu multimodality (dva či více vrcholů). Howell na s. 27 výslovně připouští různě vysoké výrazné vrcholy; grafický popis zde nezaměňujeme s definicí modu jako číselné charakteristiky, která se dosud neprobírá.

Doplněny dva zdroje NIST, přístup 2026-10-05: Detection of outliers, oddíl Introduction (https://www.itl.nist.gov/div898/handbook/eda/section3/eda35h.htm), a Uniform distribution, oddíl Probability Density Function (https://www.itl.nist.gov/div898/handbook/eda/section3/eda3662.htm). Datum vydání není na použitých stránkách doloženo, nevymýšlí se. Studentům se nezavádí vzorec hustoty; zdroj podpírá vymezený rozsah a stejné zastoupení stejně širokých intervalů. Citace vznikají společným APA CSL ze záznamů v references.bib.

Kontrola nových citací odhalila anglické popisky ve společné bibliografii. Výchozí česká lokalizace je proto výslovně nastavena i v APA CSL; datum přístupu nových zdrojů používá český tvar „5. října 2026“. Skript zpřístupňující posuvné tabulky nově zachovává výslovně zadaný název oblasti; jinak jej přebírá z popisku tabulky včetně značky figcaption používané Quartem.

Zachována a zahrnuta aktuální uživatelská redakce. Související věcná oprava rozlišuje jednoho účastníka s nulou vybavených slov od nulové četnosti přesně jednoho slova; původní závorka je zaměňovala. Formulace „pouhou náhodou“ u dvou četností 14 byla nahrazena popisem shody dvou různých skupin odpovědí, protože modelová data byla záměrně sestavena. Opraveny zjevné překlepy a neúplná věta o posunu sousedních intervalů.

### Ověření

Rozšířený check-chapter-02.R prošel v čisté relaci: obě konvence hranic včetně hraničních hodnot, pokrytí všech 33 záznamů, kumulativní body proti původním datům, procenta, příklad nominálních kategorií, střed intervalu a všechna dosavadní číselná řešení. Dvě datové varianty se stejnými intervalovými četnostmi navíc ověřují, že uvnitř intervalu mohou mít různé kumulativní četnosti. Nezávislý Python výpočet s přesnými zlomky ověřil údaje v nové tabulce, nový graf, zaokrouhlení a vlastní příklady. Konceptuální řešení zkontrolována proti výkladu.

Celá kniha se vykreslila (sedm stránek, jedenáct grafů a tři excelové ilustrace). Webové kontroly prošly v Chrome: 87 hesel slovníčku, 25 zdrojů společné bibliografie, odkazy, hledání nových pojmů, přehledové tabulky a všech 18 řešení včetně klávesnice; desktop 1360/1920 px a mobil 390 px bez přetékání stránky. Vizuálně prohlédnut nový kumulativní graf, srovnávací tabulka, označení rovnoměrného rozdělení, výklad středu, společná bibliografie a mobilní zobrazení. Na mobilu tabulka zachovává čitelné šířky sloupců; ověřeno její vodorovné posouvání šipkou na klávesnici v samostatné oblasti. Kontrola také ověřuje české citační popisky a datum přístupu obou nových zdrojů.

V jednom opakovaném běhu se objevily chyby načtení citačních náhledů (applyStyles, window.tippy). Po doplnění adresy stránky a zásobníku chyby do diagnostiky prošla stejná kontrola bez další změny vykresleného webu. Příčinu jednorázového výskytu se nepodařilo reprodukovat; nelze jej vydávat za opravenou chybu. git diff --check prošel.

Data, původní výpočty a excelový sešit se nemění. Nativní Excel nebyl znovu spuštěn; ověření webu není testem všech prohlížečů. Veřejná publikace následuje až po uživatelském sloučení a nasazení.

<a id="terminologie-meze-02"></a>

## Kapitola 2: meze intervalů (2026-10-05)

Na schválení autora používáme dolní a horní mez intervalu namísto hranic. Otevřenost a uzavřenost vztahujeme k intervalu a vysvětlujeme, zda příslušná mez do intervalu patří. Sjednoceny jsou výklad, tabulky, popisky kumulativních grafů, alternativní texty, cvičení, slovníček a přehled výpočtu středu. Obecné hranice měření u efektu podlahy a stropu zůstávají zachovány. Původní identifikátory odkazů zůstávají stabilní; v aktuální autorské redakci byl navíc doplněn chybějící identifikátor srovnávací tabulky, na který text odkazuje. Úpravy zarovnání tabulek od autora byly zachovány.

Slovníček nově obsahuje Meze intervalu s anglickými ekvivalenty. Dřívější označení otevřená/uzavřená hranice je pouze mezi alternativami; preferované popisy uvádějí, zda mez do intervalu patří. Poznámka Histogram!A14 v přiloženém sešitu i její zdrojový generátor nyní používají „Dolní mez“. Artifact Tool upravil a vykreslil buňku; jeho úplný export však přepisoval nesouvisející části původního sešitu. Proto byl do původního balíčku přenesen pouze vytvořený text. Porovnání všech částí XLSX potvrdilo jedinou textovou náhradu ve sharedStrings; ostatní XML, vzorce, hodnoty, grafy a styly zůstaly beze změny. Poznámka byla vizuálně ověřena před úpravou i po ní. Nativní Excel nebyl znovu spuštěn.

Celá kniha byla vykreslena. Check-chapter-02.R prošel; porovnání s pracovním stavem před úpravou potvrdilo shodu všech matematických zápisů a doslovných výpočetních ukázek. Kopie sešitu v sestaveném webu odpovídá upravenému zdroji.

Check-html.cjs prošel na sedmi stránkách bez chyb: 88 hesel slovníčku, místní odkazy, přehledové tabulky, všech 18 řešení včetně klávesnice, desktop 1360/1920 px a mobil 390 px bez přetékání celé stránky. Vizuálně ověřeny změněné popisky grafů, tabulka a vysvětlení mezí na mobilu. git diff --check prošel. Kontroly neověřují všechny prohlížeče ani novou publikaci webu.


<a id="terminologie-role-01"></a>

## Kapitola 1: role proměnných (2026-10-05)

Na výslovné schválení autora vložen oddíl „Nezávislá a závislá proměnná: role ve výzkumné otázce“ mezi vysvětlení experimentu s rušivými zvuky a interní/externí validitu. Zachováno schválené znění včetně autorské úpravy závěrečné věty o roli rozlišení proměnných pro vysvětlení a psychologickou teorii. Doplněny pouze citační opory, stabilní identifikátor, obal tabulky a odkazy do slovníčku. Výklad rozlišuje experimentální a širší užití nezávislé/závislé proměnné a významové nuance označení explanační proměnná, prediktor, výsledná proměnná, kritérium a predikant. Obecná preferovaná dvojice je explanační/výsledná proměnná; v experimentu také nezávislá/závislá proměnná. Prediktor není omezen na odhad budoucnosti a pojmenování samo nedokazuje příčinu.

Slovníček obsahuje sedm nových hesel se stabilními odkazy, anglickými ekvivalenty a kontextovým rozlišením alternativ. Přehled značení a Excelu se nemění, protože nebyly zavedeny symboly, vzorce ani funkce. Cíle učení jsou doplněny o role proměnných; úloha 4 má novou část f) s úplným řešením uvnitř původního sbaleného bloku. Modelový příklad navazuje na původní autorský příklad kapitoly a nepřebírá data z učebnic.

Znovu ověřena titulní strana a tiráž Howella: Statistical methods for psychology, 8. vydání, 2013, Wadsworth/Cengage Learning, ISBN 9781111835484. Textově i obrazově ověřena tištěná s. 4 (PDF 28), která zahrnuje manipulovanou i pouze měřenou nezávislou proměnnou. Navarro, místní revidované Learning statistics with R, oddíl 2.4 na s. 43–44, vysvětluje role proměnných, prediktory a výsledky a upozorňuje na zavádějící konotace tradičních názvů; s. 44 ověřena také obrazově. Citace používají existující bibliografické záznamy a společný APA CSL. Bibliografické údaje ani nové zdroje nebyly přidávány. Přísné pravidlo o prediktoru pouze pro budoucí kritérium není součástí schváleného textu.

Ověření: celá kniha (sedm stránek) se úspěšně vykreslila. První pokus blokoval přístup k mezipaměti Quarta; opakování s potřebným přístupem prošlo. Check-chapter-01.R prošel v čisté relaci R; původní data a výpočty se nemění. Nová konceptuální odpověď byla zkontrolována proti zadání a výkladu. Rozšířený check-html.cjs prošel bez chyb: 95 hesel, místní odkazy, hledání všech sedmi nových anglických označení a zpřístupnění jejich řádků přes aktivní nesouvisející filtr, všech 18 řešení včetně klávesnice, desktop 1360/1920 px a mobil 390 px bez přetékání celé stránky. Nový oddíl a tabulka byly vizuálně prohlédnuty na desktopu i mobilu, včetně českých vykreslených citací. Dosavadní kontrola ověřila i společnou bibliografii. git diff --check prošel.

Excelové příklady ani sešit se nemění; desktopový Excel nebyl znovu spuštěn. Kontrola webu proběhla v Chrome, nikoli ve všech prohlížečích. Veřejné publikování následuje až po uživatelském sloučení a nasazení.

<a id="terminologie-zaklad-03"></a>

## Kapitola 3: ukazatele polohy a variability (2026-10-05)

### Schválený rozsah a návaznost

Po diskusi a výslovném schválení autora vznikla kapitola o poloze a variabilitě. Navazuje na data o spánku a paměti z druhé kapitoly. Základ zahrnuje modus, medián, průměr a spojování skupinových průměrů; kvantily a percentilové pořadí; variační a mezikvartilové rozpětí; odchylky, rozptyl a směrodatnou odchylku; medián absolutních odchylek od mediánu, ořezání a winsorizaci; krabicový graf; krátké vysvětlení entropie; změnu jednotek, volbu a komunikaci statistik a konceptuální odlišení popisu dat od parametrického modelu.

Výpočet entropie včetně logaritmu o základu 2, momentová šikmost a kurtóza/exces včetně výpočtů a odpovídající Excel jsou ve třech výchozím stavem sbalených nepovinných blocích. Formální normální model, z-skóry, pravděpodobnosti intervalů a pravidlo přibližných podílů kolem průměru zůstávají pro následující výklad. Kapitola obsahuje dvanáct základních a dvě nepovinná cvičení. Všechna řešení jsou úplná a sbalená.

Použité značení: malé kurzivní m, x_i pro původní hodnoty, x_(i) pro uspořádané hodnoty, medián jako x s vlnovkou, q_p pro kvantil s úrovní p, s² a s pro výběrový rozptyl a směrodatnou odchylku, h pro entropii a g₁/g₂ pro základní momentovou šikmost a exces. Nové řecké populační značky se nezavádějí. Symboly, operátory a korekční vztahy jsou doplněny do přehledu, nové pojmy do slovníčku a všechny použité excelové funkce do třetího přehledu. Konečné výsledky zpravidla na dvě desetinná místa; mezivýpočty bez zaokrouhlení. U podílů a procent nadále platí konvence druhé kapitoly; přesné jednoduché podíly ve výkladu vzorců nejsou prezentovány jako zaokrouhlené odhady.

### Zdroje, konvence a opravy podkladů

Zdroje jsou nově uspořádány v podsložkách `sources/`. Hlavní učebnice je `sources/učebnice/howell.pdf`: Statistical methods for psychology, 8. vydání, 2013, Wadsworth/Cengage Learning, ISBN 9781111835484. Pro tuto kapitolu je relevantní Howellova kapitola 2: poloha na tištěných s. 32–35, variabilita 35–47, boxploty 47–50, percentily 51–52 a transformace v oddílu 2.12. Cumming a Calin-Jageman, 2. vydání 2024, slouží zejména pro s. 51–58, 62–68; Dostál (studijní opora 2022/23) pro oddíly 3.3–3.5. Titulní údaje a citované pasáže byly ověřeny v místních PDF; vybrané pasáže také obrazově.

Posouzeny byly také `sources/starší přednášky/PSYb1170_P02_2026_-_Popisne_statistiky.pptx` a `sources/příklady k procvičování/ulohy_tyden02_2026.docx`. Slouží jako orientace v obsahu kurzu a typech úloh. Data, příklady, zadání a grafy nové kapitoly jsou autorské; nepřebírají jejich tabulky ani obrázky. Průběžný příklad 4, 5, 5, 6, 10 minut i deset časů pro ořezání jsou uloženy v novém CSV. Data o spánku a paměti jsou beze změny převzata z vlastního výukového souboru druhé kapitoly. Simulace je výslovně označena a její populace je úplně zadána.

Podstatná rozhodnutí a věcné opravy:

- Kvantily používají interpolaci typu 7, shodnou s PERCENTIL.INC a výchozím R quantile. Odborná opora Hyndman a Fan (1996), oficiální dokumentace R a Microsoftu. Kvartily grafů se počítají výslovně, nikoli pomocí výchozích Tukeyho závěsů v R. Pozice 1 + (n − 1)p nahrazuje jiné algoritmy podkladů; vzorec pro pozici horního kvartilu na snímku 27 přednášky je chybný.
- Interpolovaný výběrový percentil nelze definovat příslibem přesně daného podílu menších či menších nebo rovných pozorování. Konkrétní protipříklady 90. percentilu pěti hodnot a 30. percentilu čtyř hodnot ukazují problém i bez shod. Percentilové pořadí je samostatně definováno inkluzivně (≤); alternativní zacházení se shodami je vysvětleno. U mediánu jsou podíly na obou stranách vyjádřeny pomocí „alespoň“.
- Rozlišujeme součet čtverců původních hodnot a součet čtverců odchylek. V původní úloze X2_24 pro 40, 45, 50 je první součet 6125, druhý 50 a výběrový rozptyl 25. Čísla ze snímku 43 přednášky s nesouladem deklarovaného n = 11 a deseti zobrazených hodnot nejsou přebírána.
- Dělení n je platný popis empirického rozdělení; s² zde označuje dělení n − 1. Simulace používá nezávislé tahy s vracením, populaci 2, 4, 6, 8, 10 a rozptyl 8 min². Pro n = 5, 20 a 100 vzniká vždy 20 000 výběrů, seed 20261005. Nestrannost není přesnost jednotlivého odhadu a nepřenáší se automaticky na odmocninu.
- Medián absolutních odchylek je bez škálovací konstanty; v interním R se zadává `constant=1`. Přepočet přibližně 1,4826 v jiných programech je vysvětlen jako jiná varianta. Odolnost není přisuzována všem pořadovým statistikám a odečítání kódů ordinálních kategorií není automaticky přípustné.
- Výklad kurtózy nepřebírá interpretaci pouhé ostrosti vrcholu. Opírá se o Westfallův článek (2014), The American Statistician 68(3), 191–195, DOI 10.1080/00031305.2014.917055. Autorský diskrétní protipříklad drží 80 ze 100 hodnot ve středu, ale mění exces z 2 na 10,89. Rozlišuje kurtózu, základní exces a korigovaný výsledek KURT; SKEW se liší od SKEW.P.
- Krátké vysvětlení entropie a jejího výpočtu navazuje na Shannonův oddíl 6; ověřen opravený přetisk původního článku (1948), The Bell System Technical Journal 27(3), 379–423, DOI 10.1002/j.1538-7305.1948.tb01338.x. Jednotka bit souvisí se základem 2. Nulový podíl má nulový příspěvek, nepočítá se logaritmus nuly. Entropie není ukazatelem kvality strategií ani vzdáleností jejich kódů.
- Nulová základna sloupcového grafu souvisí s kódováním velikosti délkou sloupce, nikoli pouze se smysluplností nuly dané škály. Pro IQ lze použít bodový graf s vhodným jasně označeným měřítkem. Opora: oficiální doporučení ONS pro sloupcové grafy.
- Česká funkce pro logaritmus s volitelným základem je LOGZ, anglicky LOG. Názvy a argumenty nových funkcí byly ověřeny v české dokumentaci Microsoftu a skutečném Excelu, nikoli odhadnuty překladem.

Nové zdroje v `references.bib` zahrnují tři články, dokumentaci NIST/R, doporučení ONS a šestnáct funkcí Microsoftu. Citace i bibliografie vznikají společným APA CSL. Kontrola odhalila rozdílná písmena u nedatovaných zdrojů stejného autora mezi samostatně zpracovanými kapitolami a společnou literaturou. Společné `nocite: '@*'` nyní zajišťuje stejnou sadu podkladů pro citeproc. Nejde o ruční úpravu citací či letopočtů; bibliografie obsahuje pouze použité zdroje. Kontrola HTML porovnává záznamy v kapitolách se společným seznamem.

### Sešit a dosavadní ověření

Sešit `data/kapitola_03.xlsx` má listy Priklad, Souhrn, Rozsireni a Data. Priklad ukazuje odchylky a jejich mocniny v pomocných sloupcích, Souhrn rozlišuje 33 platných údajů o spánku a 36 paměťových výkonů, Rozsireni obsahuje entropii a koeficienty tvaru, Data původních 36 případů. Po exportu pomocí Artifact Tool je potřeba normalizace novějších funkcí v nativním Excelu: bez ní Excel některé exportované vzorce nevyhodnotil, přestože náhled nástroje hodnoty vypočetl. Finalizační krok znovu zadává vzorce Excelu, provádí kontroly a ukládá jeho přepočtené hodnoty. To je součást reprodukovatelného postupu, nikoli nutný zásah studenta.

Všechny čtyři listy byly vykresleny a obrazově prohlédnuty. `check-chapter-03-excel.ps1 -Finalize` prošel v samostatné skryté instanci Excelu 16.0. Následně prošlo i opětovné otevření uloženého sešitu bez ukládání kontrolních změn. Ověřeny byly české vzorce, 185 datových vstupů včetně chybění, výsledky na všech výpočetních listech a přepočet po změně času 10 → 30, četnosti 0 → 8 a doby spánku 6 → 7; původní vstupy byly vždy obnoveny. Nezávislá kontrola uloženého XLSX potvrdila 80 vzorců s uloženými výsledky a žádné chybové buňky.

`check-chapter-03.R` prošel v čisté relaci. Ověřuje číselné příklady a řešení, transformace, kvantily a vousy, oba výpočty absolutních odchylek, ořezání a winsorizaci, entropii i momentové koeficienty. Přesný výčet všech 3125 stejně pravděpodobných výběrů velikosti 5 z pětičlenné populace potvrzuje průměr rozptylů 6,4 při dělení n a 8 při dělení n − 1 nezávisle na Monte Carlo simulaci. Python s přesnými zlomky nezávisle ověřil průběžný příklad, kvartilové meze a příklad dvou kurtóz. Zkontrolována byla také konceptuální řešení; například tvrzení o ploše vrcholu, neinterpretovatelném průměru kódů a automatickém vyřazování vzdálených pozorování nejsou přebírána. Dosavadní číselná kontrola druhé kapitoly nadále prochází.

Celá kniha se úspěšně vykreslila (osm stránek). Závěrečná kontrola HTML prošla v Chrome bez chyb: 137 hesel slovníčku, 40 řádků značení a 19 funkcí, 48 zdrojů, místní odkazy, číslování, hledání i zpřístupnění nových položek přes aktivní filtr a stránkování. Ověřeno všech 32 řešení knihy, z toho 14 nových, pomocí klávesnice a rozbalení/sbalení; tři nepovinné bloky jsou výchozím stavem zavřené. Kontrola pokryla desktop 1360/1920 px a mobil 390 px včetně otevřených rozšíření, bez přetékání celé stránky. Matematika je textové MathML bez chyb parseru, interní R kód není zobrazen. Bibliografické záznamy a rozlišovací písmena souhlasí mezi kapitolami a společnou literaturou; všechny záznamy v bibliografii jsou skutečně citovány. Nový sešit ve vykreslené knize je shodný se zdrojovým souborem.

Vizuální prohlídka zahrnula všech sedm grafů, výklad a vzorce entropie a momentů, tabulky a mobilní zobrazení. Opraveno překrytí popisků boxplotu, ořezávání osových popisků v panelových grafech a kolize čísel s referenční čarou simulace. Po posledním posunu číselného popisku byla znovu vykreslena dotčená kapitola a cíleně prohlédnut graf i mobilní rovnice. `git diff --check` prošel. První spuštění browserové kontroly blokoval přístup k místnímu serveru v omezeném procesu; s odpovídajícím přístupem kontrola prošla. Ověření se vztahuje k místnímu Chrome a Excelu 16.0, nikoli ke všem prohlížečům či starším verzím Excelu. Veřejné publikování následuje až po uživatelském sloučení a nasazení.

## Kapitola 2: horní mez včetně v tabulkách a grafech (2026-10-05)

Na výslovné schválení autora přecházejí navazující příklady na zleva otevřené a zprava uzavřené intervaly. Tento záznam nahrazuje dřívější rozhodnutí zachovat variantu A; srovnávací tabulka obou přípustných konvencí zůstává. Kumulativní četnost na horní mezi nyní jednotně znamená „nejvýše“ daná mez, stejně jako u jednotlivých hodnot. Sjednoceny jsou výklad, hlavní intervalová tabulka, histogramy s různými šířkami, polygon, kumulativní graf, alternativní texty, cvičení 5 a 10, slovníček, excelový přehled, sešit a jejich zdrojové generátory.

Zdrojová data se nemění. Pro 33 známých dob spánku jsou nové jednohodinové četnosti 3, 5, 8, 10, 5 a 2. Kumulativní počty na mezích 4 až 10 jsou 0, 3, 8, 16, 26, 31 a 33; nejvýše sedm hodin uvedlo 16/33, tedy 48,5 %. Excel používá dolní podmínku `>` a horní `<=`. Vysvětlení krajních hodnot požaduje pokrýt všechny údaje: je možné začít pod minimem nebo výslovně zahrnout i dolní mez prvního intervalu. Nulový počáteční bod kumulativního grafu je přípustný pouze na mezi, pod kterou ani na ní žádný údaj neleží. Spojnice seskupeného grafu neudává přesné rozložení uvnitř intervalů.

Aktualizována byla také aktuální místní prezentace `presentations/kapitola_02_cetnosti_a_rozdeleni.pptx` včetně uživatelovy redakce a její přesný export poznámek `presentations/kapitola_02_poznamky.docx`. V cvičném souboru se 72 účastníky zůstala data beze změny. Protože obsahují dvě doby spánku přesně 4,0, první interval zahrnuje 4 až 5 včetně, další zahrnují pouze horní mez. Četnosti pro 64 známých údajů jsou 5, 10, 17, 20, 11 a 1; v tichu 2, 5, 9, 14, 9 a 1 (n = 40), v hluku 3, 5, 8, 6, 2 a 0 (n = 24). Přepočtena jsou i řešení pro půlhodinové a dvouhodinové intervaly, relativní četnosti a kumulativní grafy. Graf z intervalové tabulky začíná na první horní mezi 5; bod u 4 lze doplnit z původních dat, nikoli předpokládat nulu. Prezentace a její exporty zůstávají podle `.gitignore` místními výstupy.

Ověření: čistá relace R prošla kontrolou obou konvencí, mezních hodnot, kumulativních bodů a číselných řešení. Nezávislý přepočet v Pythonu ověřil intervalové četnosti. Excel 16.0 skutečně přepočítal sešit ke kapitole, ověřil 180 původních vstupních buněk, vzorce, relativní četnosti, formáty i reakci grafu na změnu spánku z 6 na 7 a obnovení hodnoty. V samostatně otevřeném cvičném sešitu prošlo 12 dosavadních kontrol, všech 18 nových četností celkem a podle podmínek i tři případy zaokrouhlení; sešit se neukládal. Hodnoty 20/64 se zobrazují jako 0,313 a 31,3 %, hodnota 52/64 jako 81,3 %.

Celá kniha byla vykreslena a webová kontrola v Chrome prošla na sedmi stránkách: 88 hesel slovníčku, odkazy, přehledy, všech 18 řešení a ovládání klávesnicí, šířky 390/1360/1920 px bez přetékání celé stránky. Změněné grafy, excelová ilustrace a dotčené oddíly na mobilu byly prohlédnuty. Nativní PowerPoint vykreslil všech 32 slidů; osm změněných slidů bylo vizuálně zkontrolováno, zbývajících 24 je obrazově totožných s původní verzí. Kontrola balíčku a geometrie prezentace skončila bez nálezů. Všechny texty slidů, předloh a poznámek mají češtinu. DOCX přesně zachovává 239 odrážek poznámek i zvýraznění. Byl vykreslen ve Wordu na 15 stran a celý vizuálně zkontrolován; po opravě zaokrouhlení byly znovu ověřeny dvě dotčené strany. Běžný pomocný renderer DOCX nebyl dostupný kvůli chybějícímu LibreOffice, proto kontrolu zajistil Word. Ověření neznamená publikaci webu ani kontrolu všech prohlížečů.

Po začlenění souběžně sloučených změn kapitol 1 a 3 byla zachována obě doplnění autorské dokumentace a nové položky společných přehledů. Opakovaný úplný render osmi stránek i kontrola v Chrome prošly: 137 hesel slovníčku, 32 řešení, odkazy, navigace, klávesnice a mobilní zobrazení bez chyb. Číselná kontrola kapitoly 2 nadále prochází a sešit ve webu odpovídá zdrojovému souboru.

## Kapitola 3: modus, medián, volba středu a interpolace (2026-10-09)

Na základě pěti redakčních připomínek autora byl rozšířen začátek kapitoly přímo v hlavní pracovní složce. Dosavadní necommitované úpravy úvodu byly zachovány; opravena pouze diakritika ve slově „měřící“. Větev `codex/chapter-03-centre-quantiles` vychází z aktuálního `origin/main` po sloučení PR #22.

Definice modu nyní mluví o nejvyšší četnosti a vysvětluje shodný výsledek pro absolutní a relativní četnosti. Výklad propojuje modus s vrcholy a již zavedenými označeními unimodální, bimodální a multimodální. Zachovává rozdíl mezi několika přesnými hodnotami se stejnou nejvyšší četností a několika výraznými vrcholy různé výšky. Příklad jemně měřených reakčních časů vysvětluje málo informativní náhodnou shodu; histogram rozlišuje jednotlivou hodnotu od intervalu a připomíná vliv třídění. Medián je nejprve definován oběma podmínkami „alespoň polovina“; výpočet a konvence při sudém počtu následují až poté.

Nová podkapitola `sec-volba-stredu` srovnává účel, výhody a omezení modu, mediánu a průměru. Odbornou oporou je Howell, *Statistical methods for psychology*, 8. vydání, 2013, Wadsworth/Cengage Learning, ISBN 9781111835484. Titul a tiráž byly znovu ověřeny v `sources/učebnice/howell.pdf`, stejně jako tištěné s. 27 a 32; pasáž „Relative Advantages and Disadvantages of the Mode, the Median, and the Mean“ na tištěných s. 34–35 (PDF 58–59) byla přečtena i obrazově zkontrolována. Srovnání je vlastním českým výkladem s autorským časovým příkladem, nikoli překladem tabulky či převzatým zadáním. Nepřebírá obecná tvrzení, že shoda průměru a mediánu vyžaduje souměrnost nebo že výběrový průměr je bez dalších předpokladů vždy stabilnější. Tyto limity Howellova výkladu byly autorovi výslovně sděleny.

Nový autorský příklad obsahuje jedenáct časů 4, 5, 7, 8, 9, 10, 12, 13, 15, 18 a 22 minut. Všechny vstupy jsou přímo v tabulce kapitoly a generátoru grafu; studentský XLSX ani CSV se nemění. Pro konvenci PERCENTIL.INC jsou vysvětleny přiřazené úrovně `(i − 1)/(n − 1)`, pozice `1 + (n − 1)p` a přesný interpolační vztah s dosavadními symboly. Dvoučástový graf ukazuje celou řadu a zvětšený úsek pro 17. percentil: pozice 2,7, výsledek 6,4 minuty, skutečný podíl menších nebo rovných časů 2/11. Deset mezer neoznačuje skupiny po 10 % pozorování. Výklad ošetřuje krajní úrovně, jedinou hodnotu i shody a netvrdí rovnoměrné rozložení dat uvnitř mezer. Navazující otázka rozšiřuje třetí cvičení; celkem zůstává čtrnáct úloh.

Současně byly upraveny příslušné definice ve slovníčku, do přehledu značení přidány oba výpočetní vztahy a opraven neexistující odkaz `znak-kvantil` na platný `znak-qp`. Nové odborné termíny ani písmenné značky se nezavádějí. Konvence byla znovu ověřena proti oficiální dokumentaci Microsoftu (PERCENTIL.INC) a R (kvantily typu 7); v textu zůstávají existující citace Hyndmana a Fana a Microsoftu. Bibliografické údaje ani počet zdrojů se nemění.

Ověření výpočtů: `check-chapter-03.R` prošel v čisté relaci a nadále kontroluje všechny číselné příklady a čtrnáct řešení. Nově ověřuje všech jedenáct uzlů interpolace, shodu tabulky s daty grafu, 17. percentil, podíl 2/11 a samostatně rozepsaný algoritmus proti `quantile(type = 7)` pro necelé i celé pozice, shody, minimum, maximum a jediné pozorování. Nezávislý výpočet v Pythonu s přesnými zlomky potvrdil pozici 27/10 a kvantil 32/5. Názvy a chování Excelu byly pro tuto úpravu kontrolovány podle dokumentace; desktopový Excel ani nezměněný sešit nebyly znovu spouštěny.
Ověření webu: celá kniha (osm stránek) se úspěšně vykreslila. Závěrečný check-html.cjs prošel v místním Chrome bez chyb: 137 hesel, 32 řešení včetně klávesnice a skrytí/rozbalení, odkazy, navigace, shoda APA citací a bibliografie, MathML bez chyb, žádný viditelný R kód a šířky 1360/1920/390 px bez přetékání celé stránky. Nové řádky vzorců a heslo interpolace byly nalezeny vyhledáváním napříč tabulkou i zpřístupněny odkazem přes nesouvisející filtr. Vizuálně byly prohlédnuty upravené oddíly, citace, tabulka, nový graf a rovnice na desktopu i mobilu. Graf dostal větší popisky pro mobil; srovnávací tabulka používá minimální šířku uvnitř vlastního posuvného kontejneru. Samostatně ověřeno posunutí k poslednímu sloupci a prohlédnut výsledný interpolační vzorec v přehledu značení. git diff --check prošel.

První pokus o spuštění Quarta selhal kvůli mezerám v cestě jeho spouštěče; ověřený krátký tvar cesty fungoval. První webová kontrola neměla v omezeném prostředí přístup k místnímu serveru; po povolení tohoto přístupu prošla. Nejde o chyby studentského obsahu. Ověření platí pro místní Chrome; veřejné nasazení následuje až po uživatelském sloučení a úspěšném publikačním workflow.

## Kapitola 3: srovnání percentilových pořadí (2026-10-09)

Tabulka `tbl-percentilove-poradi` porovnává inkluzivní, exkluzivní a kompromisní pořadí pro původní časy 4, 5, 5, 6 a 10 minut. Obsahuje dosazení všech výpočtů; dvě shodné pětky sdílejí jeden řádek. Poslední sloupec uvádí úrovně kvantilů podle PERCENTIL.INC, nikoli jinou definici pořadí. Pro 5 minut jde o celý uzavřený interval úrovní 25–50 %. Protipříklad s 6 minutami odlišuje kompromisní pořadí 70 od 75. percentilu. Slovníček a přehled vzorců byly doplněny bez nových písmenných značek.

Definice tří pravidel ověřeny v oficiální dokumentaci SciPy `percentileofscore`: odpovídají volbám `weak`, `strict` a `mean`. Výchozí volba SciPy `rank` používá jiné zacházení s pořadími a není zde zaměňována za kompromisní konvenci. Kvantilové úrovně ověřeny proti dokumentaci R pro typ 7. Bibliografie obsahuje nový záznam dokumentace SciPy, celkem 49 zdrojů. Příklad je vlastní, navazuje na již používaná data.

Čistá relace R ověřila všechna pořadí, uzlové kvantily, interval konstantní hodnoty 5 i jeho okolí a kvantily na úrovních 40 a 70 %. Nadále prošly všechny příklady a 14 řešení kapitoly. První spuštění bez nastavení locale selhalo při čtení českého zdroje; po nastavení English_United States.utf8 prošlo. Celá kniha se vykreslila. Excelové vzorce ani sešit se nemění; desktopový Excel nebyl pro tuto úpravu znovu spouštěn. Rozpracované autorské změny kapitoly byly zachovány v hlavní pracovní složce.

Webová kontrola v místním Chrome prošla pro osm stránek, 137 hesel a 32 řešení: odkazy, skrytí a rozbalení řešení, matematika, bibliografie, vyhledávání i zpřístupnění nového řádku vzorců přes filtr. Šířky 1360/1920/390 px nemají přetékání celé stránky; široká tabulka se posouvá uvnitř vlastního kontejneru, ověřeno také šipkou doprava. První test nesprávně použil klávesu End pro vodorovný posun; opraven test, chování tabulky změnu nepotřebovalo. Vizuálně prohlédnut oddíl na desktopu i mobilu a poslední sloupec po posunutí. Vykreslený nový bibliografický záznam a citace byly zkontrolovány. `git diff --check` prošel. Kontrola se týká místního webu; veřejné nasazení nebylo součástí úpravy.

## Kapitola 3: ukazatele středu a tvar rozdělení (2026-10-09)

Nový oddíl `sec-stred-tvar` za srovnáním ukazatelů vysvětluje shodu průměru, mediánu a modu u přesně souměrného jednovrcholového rozdělení s existujícím průměrem a typické pořadí ve dvou zrcadlově zešikmených příkladech. Nezaměňuje toto vodítko za definici šikmosti ani za univerzální pravidlo. Souměrnost sama nezaručuje jediný modus; shoda průměru a mediánu sama nezaručuje souměrnost. Příklady náročného a lehkého testu jsou možnosti, nikoli tvrzení o nutném tvaru jejich výsledků.

Graf je vlastní implementace v base R, inspirovaná didaktickým záměrem uživatelova obrázku; původ obrázku nebyl znám a jeho grafické prvky se nepřebírají. Obsahuje tři přesně definované modely: beta(5,5), beta(5,2) a beta(2,5), všechny na škále 0–100. Nejde o empirická ani náhodně simulovaná data. Průměry jsou 50, 500/7 a 200/7, mediány určuje qbeta, mody jsou 50, 80 a 20. Kontrola nezávisle numericky integruje plochu a první moment, ověřuje polovinu plochy u mediánu a numerickou maximalizací kontroluje modus; ověřuje i zrcadlovost modelů. Typy čar doplňují barvy a odsunuté popisky zabraňují překrývání blízkých značek.

Omezení pravidla byla ověřena v původním článku von Hippela (2005), Journal of Statistics Education, 13(2), DOI 10.1080/10691898.2005.11910556, oddíly 2–3. Nový záznam zvýšil společnou bibliografii na 50 položek; příjmení je chráněno jako celek, aby APA výstup zachoval „von Hippel“. Slovníček má související doplnění a odkazy, nové symboly ani odborné pojmy se nezavádějí. Rozpracované autorské změny kapitoly zůstaly zachovány; u percentilové tabulky byl obnoven identifikátor a nastavení šířek sloupců, které chyběly v pracovním souboru a jsou potřebné pro její dosavadní formátování a kontrolu.

V čisté relaci R prošly všechny výpočty, devět obrázků bylo reprodukováno a nadále prošlo 14 řešení. Celá kniha byla vykreslena. Nový graf byl vizuálně zkontrolován na desktopu i mobilu (390 px); popisky byly upraveny pro čitelnost a odstranění kolizí s osou. Byla zkontrolována výsledná citace a nový bibliografický záznam. Excelový sešit ani vzorce se nemění, desktopový Excel nebyl znovu spuštěn.
Závěrečná webová kontrola v místním Chrome prošla: osm stránek, 137 hesel, 32 řešení, odkazy, klávesnice, skrytí a rozbalení, MathML, bibliografie a šířky 1360/1920/390 px bez přetékání celé stránky. git diff --check prošel. Veřejné nasazení následuje až po uživatelském sloučení; v této úpravě nebylo ověřováno.

## Začlenění úplné autorské redakce kapitoly 3 (2026-10-09)

Do navazujícího commitu byla začleněna veškerá zbývající redakce pracovního souboru kapitoly 3, včetně výkladu průměru bodových skórů a pořadí, ordinálních položek, dílčích terminologických upřesnění a formátování. Její dřívější ponechání mimo commity bylo chybným výkladem pravidla o změnách patřících k úkolu: tyto úpravy byly součástí stejné kapitoly a měly být zahrnuty do předávaného výsledku. Dřívější poznámky o ponechání redakce mimo commit popisují tehdejší stav, nikoli správný pracovní postup.

Obsah kapitoly se při tomto začlenění dále neměnil. Jde o stejný úplný pracovní soubor, na němž v předchozím kroku proběhl render a webová kontrola. Znovu prošla numerická kontrola kapitoly i 14 řešení a git diff --check. Proto nebyl opakován nezměněný render ani vizuální kontrola. Předchozí PR #25 již byl sloučen, oprava proto vychází z aktuálního main a je předána samostatným PR.

<a id="terminologie-robustni-03"></a>

## Kapitola 3: kumulativní kvantily, stupně volnosti a robustní shrnutí (2026-10-09)

Zapracováno šest redakčních připomínek spolu s úplnou souběžnou autorskou redakcí pracovního souboru. PR #26 byl již sloučen, proto větev vychází z aktuálního main. Rozpracované změny kapitoly patří do výsledného commitu. Opraveno také zjevně zdvojené slovo „prostřední“ v úvodu kvantilů a obnoveny identifikátory obou dříve doplněných tabulek, které pracovní redakce opět postrádala.

Nový oddíl ukazuje první dosaženou kumulativní úroveň na časech 4, 5, 5, 6, 10: pro 90 % vrací 10 minut, zatímco PERCENTIL.INC dává 8,4. Motivací je nejnižší limit pokrývající alespoň daný podíl konkrétního souboru; není slibováno pokrytí budoucích účastníků. Druhá tabulka používá již zavedených šest modelových odpovědí odpočatosti z kapitoly 2. Pro 75 % vybírá kategorii „dost“, pro 90 % „zcela“; pro 50 % výslovně volí dolní prostřední kategorii. Změna kódů 1, 2, 3, 4 na 1, 2, 10, 100 ukazuje, proč interpolované kódy 3,5 a 55 nemají doložený význam odpočatosti. Oporou pro rozdílné algoritmy zůstává Hyndman a Fan (1996), ověřeno také podle dokumentace R, quantile, typy 1 a 7.

Percentilové pořadí je vysvětleno jako číselná hodnota procentní stupnice (bez tečky), odlišně od řadového pojmenování „60. percentil“ či „2. pozice“. Na návrh autora jsou zavedeny rozlišující zkratky MeanAD a MedAD; MAD zůstává uvedeno pouze jako nejednoznačná zkratka jiných zdrojů. Robustní (robust) je vyloženo spolu s užší odolností vůči krajním hodnotám (resistance). Stupně volnosti (degrees of freedom) jsou vysvětleny jednou podmínkou nulového součtu odchylek, nikoli vyřazením účastníka nebo tvrzením statistické nezávislosti odchylek. Nové samostatné písmenné značení se nezavádí. Slovníček a přehled vztahů jsou aktualizovány včetně stabilních odkazů.

Pro ořezání a winsorizaci je výslovně zvolena úroveň pro každý konec zvlášť a zaokrouhlení počtu hodnot dolů. Příklad 18 hodnot a 10 % vynechá jednu z každého konce (celkem 11,1 %); u pěti hodnot nevynechá žádnou. Výklad neztotožňuje nominální procento se skutečně upraveným podílem po zaokrouhlení. Medián je krajní případ při úrovni blížící se 50 %; pro přesně 50 % u sudého počtu nejde o průměr prázdného souboru. Pravidla byla ověřena v dokumentaci R mean i jeho zdrojovém souboru mean.R (floor a zvláštní větev pro medián) a v dokumentaci SciPy winsorize (volitelné oříznutí či zaokrouhlení počtu). Nová bibliografie R mean, SciPy winsorize a StatsDirect Degrees of Freedom rozšiřuje seznam na 53 zdrojů. Definice variability a robustnosti ověřeny proti dosavadnímu zdroji NIST Measures of Scale. Výklad nepřebírá případná zjednodušení zdrojů o nutnosti normality pro samotnou korekci rozptylu.

Rozšířena řešení stávajících cvičení 4, 5 a 8; celkový počet zůstává 14. Čistá relace R ověřila kumulativní počty, volbu ordinálních kategorií, oba způsoby kódování, interpolované hodnoty, nulový součet odchylek, zaokrouhlení počtů ořezání a krajní případ mediánu pro sudý i lichý počet. Nadále prošly všechny původní numerické příklady a řešení. Celá kniha se vykreslila. Nové bibliografické záznamy a rozlišení letopočtů stejných autorů byly zkontrolovány. Excelové vzorce ani sešit se nemění; desktopový Excel nebyl znovu spouštěn.
Webová kontrola v místním Chrome prošla na osmi stránkách: 138 hesel, 32 řešení, odkazy, vyhledávání nových pojmů i vzorců, klávesnice, MathML a konzistentní APA bibliografie. Šířky 1360/1920/390 px nemají přetékání celé stránky. Vizuálně zkontrolovány nové tabulky, stupně volnosti, robustnost a ořezání na desktopu i mobilu. Po zkrácení záhlaví ordinální tabulky a doplnění klávesnicového zaměření znovu vykreslena kapitola a cíleně ověřeny obě kumulativní tabulky včetně vodorovného posouvání. git diff --check prošel. Veřejné nasazení nebylo součástí ověření.

## Kapitola 3: význam ukazatelů středu a geometrie odchylek (2026-10-09)

Do srovnání modu, mediánu a průměru byl vložen uživatelem dodaný soubor assets/chapter-03/plots/mode-median-mean.svg, beze změny. Jeho metadata uvádějí autora CMG Lee (Cmglee); původ a licence CC BY-SA 3.0 byly ověřeny na Wikimedia Commons, File:Visualisation mode median mean.svg. Popisek obsahuje citaci, odkaz na licenci i údaj o nezměněném převzetí. Český doprovod vysvětluje anglické popisky, vrchol, poloviny plochy a těžiště; připomíná omezení přesného dělení konkrétních dat se shodami. Bibliografie byla rozšířena na 54 položek. Pro tento jediný negenerovaný podklad je v .gitignore výjimka, aby obrázek existoval také v čistém klonu a veřejném sestavení; ostatní generované grafy se nadále necommitují.

Nový vlastní dvoupanelový graf odchylky-a-ctverce.svg vytváří scripts/kapitola_03.R z dosavadních časů 4, 5, 5, 6, 10. Oba panely mají na ose X číslo pozorování a na Y dobu v minutách; referenční čára je průměr 6 minut. V prvním panelu jsou úsečky a podepsané odchylky, v druhém geometrické čtverce s plochami 4, 1, 1, 0 a 16 min². Poměr měřítek zachovává skutečné čtverce; jejich umístění zabraňuje překryvům. Vodorovná strana je pouze konstrukční délka, nikoli počet pozorování. Text výslovně odlišuje svislou osu v minutách od plochy v min², součet délek 8 od součtu ploch 22 a propojuje graf s MeanAD a rozptylem.

Inspirací je uživatelem dodaná animace https://miro.medium.com/v2/resize:fit:786/format:webp/0*YAqygP_cDwKqEvtf.gif, prohlédnutá přímo v prohlížeči (textový webový nástroj ji neotevřel). Nepřebírá se animace ani její data; v textu je odkaz na vizuální předlohu, jejíž původní autor nebyl z přímého odkazu zjištěn. Dodané místní SVG bylo před použitím prohlédnuto. Generátor používá pouze base R a nepřidává instalace ani studentský kód.

V čisté relaci R prošly všechny výpočty a 14 řešení. Nová kontrola ověřuje odchylky, délky, plochy, jejich součty a napojení stran čtverců na správná pozorování. Celá kniha byla vykreslena; po odstranění kolize popisku nulové plochy byl znovu vykreslen dotčený výklad. Excelové vzorce ani sešit se nemění, desktopový Excel nebyl znovu spouštěn.

Webová kontrola v místním Chrome prošla na osmi stránkách: 138 hesel, 32 řešení, interní odkazy, klávesnice, skrytí a rozbalení řešení i bibliografie. Šířky 1360/1920/390 px nemají přetékání celé stránky. Oba doplněné obrázky byly vizuálně zkontrolovány na desktopu i mobilu. git diff --check prošel. Veřejné nasazení nebylo součástí ověření.

<a id="terminologie-entropie-03"></a>

## Kapitola 3: názorná konstrukce boxplotu a normalizovaná entropie (2026-10-09)

Po sloučení PR #28 vzniká nová větev z aktuálního main. Do výsledku je začleněna i souběžná autorská redakce kapitoly. Její záměr je zachován; opraveny drobné překlepy ve výkladu entropie a doplněna nulová hodnota logaritmu při podílu 1. Obnoveny identifikátory a šířky obou přehledových tabulek, které pracovní redakce odstranila.

Původní malý boxplot nahrazuje vlastní modelový soubor 41 testových skórů, kompletně vypsaný v kapitole a reprodukovaný v R. Uspořádání obrázku je inspirováno uživatelem dodaným schématem, nepřebírá jeho kresbu ani data. Kvartily podle typu 7 jsou na pozicích 11, 21 a 31 a mají hodnoty 40, 50 a 60. IQR je 20, pomocné meze 10 a 90, konce vousů 15 a 85 a samostatné body 2, 5, 95 a 98. Svislý obrázek zobrazuje všechna pozorování, kvartily, medián, IQR, oba úseky délky 1,5 IQR, meze, vousy a podezřelá odlehlá pozorování. Text odlišuje skutečné konce vousů od nejzazšího přípustného dosahu, doplňuje anglické ekvivalenty a zachovává upozornění, že označení není důkazem chyby. Konstrukce byla porovnána s NIST, Box Plot, oddílem Box plots with fences; zůstává zdejší konvence zahrnutí samotné meze mezi přípustné hodnoty.

Na výslovnou žádost autora doplněna normalizovaná entropie jako h/log2(k), bez nového písmenného symbolu. Předem vymezené k zahrnuje i prázdné kategorie; pro k = 1 podíl nedefinujeme. Výklad, slovníček, přehled vztahů a cvičení 13 rozlišují entropii v bitech od bezrozměrného poměru k teoretickému maximu. Příklad dává 0,75 pro čtyři kategorie a přibližně 0,946 pro tři. Citována dokumentace NIST Shannon diversity index (aktualizace 2016-10-07). Její vzorec a krajní hodnoty byly ověřeny výpočtem: stránka obsahuje rozpornou větu o směru změny rozmanitosti, kterou nepřebíráme. Rovnoměrné zastoupení dává hodnotu 1, koncentrace do jediné kategorie 0. Bibliografie nyní obsahuje 55 položek.

V čisté relaci R prošly všechny numerické kontroly i 14 řešení, včetně nových kvartilů, mezí, konců vousů, odlehlých hodnot a normalizace. Celá kniha byla vykreslena. Excelové příklady ani sešit nebyly změněny; desktopový Excel nebyl znovu spouštěn.

Nezávislý výpočet z dat vypsaných přímo v kapitole potvrdil počet 41, příslušné pořadové hodnoty, meze, vousy a odlehlá pozorování; zkontrolován i poměr pro tři kategorie. Webová kontrola v místním Chrome prošla na osmi stránkách (139 hesel, 32 řešení, 55 bibliografických položek), včetně vyhledávání a stabilních odkazů nového pojmu i vzorce, klávesnice, skrytých řešení a matematického zápisu. Boxplot a rozšíření o entropii byly prohlédnuty na desktopu a mobilu. Při šířkách 1360/1920/390 px stránka nepřetéká vodorovně. git diff --check prošel. Veřejné nasazení nebylo ověřováno.

<a id="terminologie-transformace-03"></a>

## Kapitola 3: reportování APA, transformace a shodné momenty (2026-10-09)

Na žádost autora doplněny lineární a nelineární transformace, rovnice y_i = a + b x_i s vysvětlením všech prvků, upozornění na přesnější matematický název afinní a dvoupanelový graf. Vlastnosti polohy nejsou vydávány za univerzální definici všech statistik; záporný násobitel obrací pořadí kvartilů. U variability je odlišeno násobení směrodatné odchylky absolutní hodnotou b od násobení rozptylu b². Druhá mocnina na nezáporných skórech mění stejné rozdíly nestejně; průměr čtverců 40,4 není čtvercem průměru 36. Doplněny přehledy pojmů a vztahů.

Výslovný požadavek na reportování APA je použit jako oprávnění ukázat M, Mdn, SD, N a n v odborné ukázce. Dosavadní výpočetní značení m, x s vlnovkou, s a n se nemění. Oficiální APA Style numbers and statistics guide (2024, s. 2) ověřuje jedno desetinné místo u průměrů a SD celočíselných dat a dvě u ostatních. Značky byly ověřeny v Publication Manual (2020), tabulka 6.5, a desetinný zápis v oddílu 6.36, v dostupné textové kopii https://studylib.net/doc/26191112/apa-2020-7th-ed; citován je vlastní manuál s DOI. Oficiální materiál APA je https://apastyle.apa.org/instructional-aids/numbers-statistics-guide.pdf. Jedno desetinné místo pro procenta je výslovně místní redakční konvence, nikoli údajně závazné univerzální pravidlo APA. Anglická ukázka zachovává desetinnou tečku, kurzivu a procentní znak bez mezery; český výklad českou typografii. Popis tvaru spánku a počtu slov byl ověřen z dat i z existujícího histogramu a tečkového grafu kapitoly 2. Přirozená nula je odlišena od grafické zásady nulové základny sloupců.

Nová vlastní ilustrace inspirovaná principem uživatelova obrázku používá tři přesné populační modely: hodnoty −1 a 1 s pravděpodobnostmi 1/2, standardní normální rozdělení a gama rozdělení se shape = 4 a rate = 2 posunuté o −2. Všechny mají průměr 0 a rozptyl 1. Sloupce představují přesné pravděpodobnosti intervalů šířky 0,2, nikoli simulované četnosti; integrační kontrola ověřuje momenty celých rozdělení. Vodorovné osy jsou shodné, svislé se pro čitelnost tvarů liší, což výslovně uvádí popisek. Chvosty pokračující mimo výřez jsou vysvětleny. Původní šestiprvkové příklady a navazující popis modelu byly nahrazeny společně.

Zahrnuta je úplná průběžná autorská redakce kapitoly, včetně přeformulování ordinálního mediánu. Opraveny její drobné překlepy a obnoveny stabilní identifikátory tabulek. Čistá relace R ověřila všechny výpočty a 14 řešení, nové transformace a integračně oba spojité modely. Celá kniha byla vykreslena; po úpravě měřítek grafu znovu dotčená kapitola. Bibliografie má 57 položek. Excelové vzorce ani sešit se nemění, desktopový Excel nebyl znovu spouštěn.

Webová kontrola v místním Chrome prošla na osmi stránkách: 142 hesel, 32 řešení, vyhledávání a odkazy nových pojmů a vztahů, klávesnice, matematický zápis a bibliografie. Vizuálně zkontrolovány oba nové grafy, výklad transformací a ukázka APA na desktopu i mobilu. Po spojení dvou sousedních závorek v anglické ukázce znovu vykreslena kapitola a cíleně zkontrolována konečná ukázka a oba grafy při 1360 a 390 px. Kontroly neodhalily vodorovné přetékání celé stránky. git diff --check prošel. Veřejné nasazení nebylo ověřováno.

<a id="terminologie-poradove-03"></a>

## Kapitola 3: české reportování a zpřesnění výkladu (2026-10-09)

Zapracováno šest připomínek spolu s úplnou průběžnou autorskou redakcí. Obrácené skórování výslovně dosazuje a = 10, b = −1. Pořadové statistiky v užším smyslu jsou odlišeny od interpolovaných kvantilů na již ověřeném příkladu 90. percentilu 8,4. Přidána významově shodná česká ukázka reportování s kurzivními značkami APA, desetinnými čárkami a středníky. Středník je vysvětlen jako přizpůsobení české typografii, nikoli univerzální příkaz anglického manuálu APA. Pro kontext byly ověřeny české redakční pokyny https://dl1.cuni.cz/pluginfile.php/1314842/mod_resource/content/1/APA_7_2021_11_18.pdf (verze listopad 2021), které výslovně rozlišují české úpravy od původní normy, a jazyková příručka https://prirucka.ujc.cas.cz/?id=173. Zvolený středník pro tuto ukázku je místní redakční rozhodnutí.

U tří populačních modelů výklad odlišuje počet různých hodnot od rozptýlenosti měřené rozptylem; dvoubodový model má průměr čtvercových odchylek 1. Závěr oddílu přirozeněji odlišuje to, co jsme vypočítali z dat, od předpokladů o tvaru rozdělení. Opraven překlep „tranformaci“ a obnoveny stabilní identifikátory dvou tabulek odstraněné pracovní redakcí. Nové pojmy ani značení nejsou zaváděny. Čistá relace R ověřila všechny příklady a 14 řešení, dotčená kapitola byla vykreslena. Grafy, Excelové vzorce ani sešit se nemění; desktopový Excel nebyl znovu spouštěn.

Webová kontrola osmi stránek v místním Chrome prošla: 142 hesel, 32 řešení, odkazy, klávesnice, skrytí a rozbalení řešení, matematika a šířky 1360/1920/390 px bez přetékání stránky. Česká ukázka byla vizuálně prohlédnuta na mobilu. git diff --check prošel. Veřejné nasazení nebylo ověřováno.

## Kapitola 3: jasné rozlišení konvencí kvantilů (2026-10-09)

Na základě dohodnuté formulace je PERCENTIL.INC označena jako hlavní konvence pro číselná data, přirozená zejména u spojitých proměnných, ale použitelná i u diskrétních číselných hodnot. Kvartil 5,75 slova nemusí být pozorovatelným výsledkem, aby sloužil jako číselná hranice. U čistě ordinálních kategorií chybí podklad pro interpolaci rozdílů mezi kódy; jako zdejší postup je výslovně zvolen první dosažený kumulativní podíl. Ten lze použít i pro spojitou proměnnou, pokud potřebujeme pozorovanou hodnotu. Oba oddíly mají výstižnější názvy a zachované identifikátory. Slovníček a přehled značení byly sjednoceny s tímto rozlišením; odstraněna příliš široká formulace o „všech výpočtech kvartilů“ v oddílu boxplotu.

Doplněn případ úrovně nižší nebo rovné kumulativnímu podílu minima: pro p = 0,1 a 0,2 vychází 4, pro p = 0,25 vychází 5. Nové výsledky i všechny dosavadní příklady a 14 řešení ověřila čistá relace R. Zahrnuta celá souběžná autorská redakce, opravena nadbytečná předložka u řazení a obnoveny stabilní identifikátory tabulek. Excelové příklady ani grafy se nemění; desktopový Excel nebyl znovu spouštěn.

Render celé knihy a webová kontrola osmi stránek prošly: 142 hesel, 32 řešení, odkazy, klávesnice, matematika i šířky 1360/1920/390 px bez přetékání celé stránky. Změněné oddíly byly prohlédnuty na mobilu. git diff --check prošel. Veřejné nasazení nebylo ověřováno.

## Kapitola 3: význam řádu momentu (2026-10-10)

Při zavedení momentů je nyní výslovně vysvětleno, že řád určuje mocninu. Příklady rozlišují první, druhý a třetí řád i druhý moment kolem nuly od druhého centrálního momentu. Stejné upřesnění je v dosavadním hesle slovníčku; nové značení se nezavádí.

Zahrnuta souběžná autorská redakce výkladu šikmosti a špičatosti. Opraven překlep „mocnic“ a poslední čtverec odchylky v rozepsaném příkladu: 4² = 16, takže součet čtverců zůstává 22. Obnoveny stabilní identifikátory a šířky dvou tabulek odstraněné pracovní redakcí. Čistá relace R ověřila všechny numerické příklady a 14 řešení; celá kniha byla vykreslena. Excelové příklady ani grafy se nemění; desktopový Excel nebyl znovu spouštěn.

Webová kontrola osmi stránek prošla: 142 hesel, 32 řešení, vnitřní odkazy, ovládání klávesnicí, skrytí a rozbalení řešení a šířky 1360/1920/390 px bez chyb. Upravené rozšíření bylo vizuálně prohlédnuto na desktopu i mobilu. git diff --check prošel. Veřejné nasazení nebylo ověřováno.

## Revize projektových instrukcí a rozdělení dokumentace (2026-10-10)

Po společném projednání a výslovném souhlasu autora jsou pravidla pro výklad a ověřování ponechána pohromadě v kořenovém AGENTS.md. Nevznikají samostatné VYKLAD.md, OVEROVANI.md, GOALS.md ani PLANS.md. Do docs/PREZENTACE.md se přesouvají veškerá dosavadní pravidla pro prezentace, poznámky a exporty; mění se pouze úroveň nadpisů a relativní odkaz na společná pravidla. Kořenové instrukce určují, kdy načíst další dokumenty, bez povinnosti číst všechny při každém úkolu.

Nový docs/ROZHODNUTI.md eviduje šest skupin doložených konvencí s rozsahem, důvodem a dokladem: značení/reportování, indexy/četnosti, hranice intervalů, kvantily/boxplot, zaokrouhlování a robustní shrnutí. Nejde o úplný slovníček. Nový docs/OSNOVA.md shrnuje obsah a cíle současných tří kapitol, návaznosti, základní a nepovinný rozsah; budoucí náměty výslovně nejsou vydávány za schválené kapitoly. Starší záznamy této historie zůstávají zachovány a jsou doplněny odkazem na současné přehledy.

Opraveny dva doložené nesoulady: cesta k hlavní učebnici nyní odpovídá existujícímu sources/učebnice/howell.pdf; větu o neexistenci výjimek ve značení nahrazuje vymezení schválených ukázek APA, bez změny výpočetního m a dalších dosavadních symbolů. Jsou připomenuty i rozlišující zkratky MeanAD a MedAD. Nové odborné značení se nezavádí.

Před návrhem nové kapitoly se musí posoudit aktuální soubory v sources/ včetně podsložek: další učebnice, autorovy starší prezentace, příklady k procvičování a ostatní podklady. U relevantních materiálů se mají prostudovat odpovídající části a při projednávání uvést využití, podstatné rozpory a případné mezery v přístupu. Howell zůstává hlavním východiskem. Tato revize instrukcí ověřila umístění souborů, není novou odbornou rešerší jejich obsahu.

Didaktická revize nově ukládá hledat chybějící myšlenkové kroky, nevysvětlené pojmy, nevyřčené předpoklady, záměny pojmů a chybějící interpretace. Zahrnuje návaznosti, účel příkladů a grafů, přípravu na cvičení a jazykovou čitelnost. Rozsah odpovídá změně; běžné opravy v dohodnutém rozsahu nepotřebují nové schvalování. Nové pojmy, změny značení a rozšíření nadále podléhají dohodě. Nevzniká povinnost vkládat samostatná cvičení do výkladu a interní revize není vydávána za ověření porozumění na studentech.

### Mapa zachování pravidel a kontrola

| Původní část AGENTS.md | Výsledek |
|---|---|
| Cíl a cílová skupina; příprava každé kapitoly; didaktika a jazyk; výpočty; cvičení; tři přehledy; ověřování Quarto Book; Git | Osm oddílů obsahově i textově zachováno. |
| Zdroje | Opravena cesta a rozšířen postup posouzení podkladů; ostatní požadavky zachovány. |
| Terminologie a značení | Nahrazena zastaralá věta o výjimkách; doplněn odkaz na vymezení reportování a zkratek. |
| Studentský text a autorská dokumentace | Zpřesněno rozdělení historie, platných rozhodnutí a osnovy. |
| Prezentace a poznámky | Úplný přesun do docs/PREZENTACE.md s výslovným načtením z kořenových instrukcí. |
| Nové oddíly | Použití projektové dokumentace a didaktická revize. |

Přímé porovnání proti výchozímu origin/main potvrdilo úplnost přesunu prezentací (po normalizaci úrovně nadpisů a odkazu na AGENTS.md) a nezměněný obsah osmi zachovaných oddílů. Kontrola 42 místních Markdown odkazů v šesti dotčených dokumentech potvrdila existenci cílů a explicitních kotev. Ověřeno UTF-8, cesta k Howellovi, odstranění obou zastaralých formulací a soulad osnovy a konvencí s aktuálními kapitolami a historickými doklady. git diff --check prošel.

Mění se pouze instrukce a autorská dokumentace; kapitoly, data, prezentace ani konfigurace webu se nemění. Podle pravidla pro tento druh změny nebyl spouštěn render, numerické ani excelové kontroly a vizuální kontrola webu. Veřejné nasazení nebylo ověřováno. Nejde o novou didaktickou revizi samotných kapitol.

<a id="priprava-kapitoly-4"></a>

## Příprava kapitoly 4: normální rozdělení a standardní skóry (2026-10-10)

Autor dohodl zaměření kapitoly 4 na polohu výsledku a z-skór, normální
model, podíly jako plochy, převody mezi hodnotami a podíly a další standardní
skóry včetně stenů a staninů. Podrobnou pravděpodobnost chce ponechat
následující kapitole. Současně požádal o posouzení všech učebnic a nově
přidané krátké přednášky `normal_distribution.pptx` a o podrobnou osnovu.
Tento dohodnutý rámec je zapsán do `docs/OSNOVA.md`; členění, cíle, příklady,
terminologie, značky, Excel a nepovinná rozšíření jsou výslovně návrhem,
nikoli dodatečně přisuzovaným schválením. Studentská kapitola ani zápisy
do závěrečných přehledů zatím nevznikají.

### Rozsah posouzení učebnic

Byl znovu zjištěn úplný obsah `sources/` včetně podsložek. Všech deset
PDF v `sources/učebnice/` bylo čitelných. Posouzení zahrnulo jejich
obsahy a relevantní výkladové pasáže uvedené níže, nikoli přečtení všech
knih od začátku do konce. Strany v tabulce jsou tištěné stránky knih;
u digitálního Navarra jde o číslování dodané PDF verze. Automatická
extrakce místy poškodila matematické znaky, zejména u Judda; přesný
matematický zápis proto není přebírán z poškozené extrakce.

| Podklad | Prostudované relevantní části | Navržené využití a hranice |
|---|---|---|
| Howell, *Statistical Methods for Psychology*, 8. vyd., 2013, Wadsworth Cengage Learning; `howell.pdf` | Kap. 3, zejména 3.1–3.6, s. 66–79. Titul a vydání ověřeny v titulních a vydavatelských údajích, ISBN 978-1-111-83548-4. | Hlavní opora: normální model, standardizace, plochy, centrální interval a jiné standardní skóry. Q–Q graf z 3.5 jen nepovinně. Howell výslovně odlišuje interval jednotlivých hodnot od intervalu spolehlivosti průměru. |
| Gravetter a Wallnau, *Statistics for the Behavioral Sciences*, 10. vyd., `gravetter.pdf` | Kap. 5, zejména s. 135, 141–148; normální plochy v oddílu 6.2, s. 165–166. | Podrobná intuitivní interpretace z-skóru, zachování tvaru, změna měřítka a odlišení výběrové a populační standardizace. Podporuje zařazení z-skóru před normální model. |
| Aron, Aron a Coups, *Statistics for Psychology*, 6. vyd., Pearson New International Edition, 2014; `aron.pdf` | Kap. 3, s. 75–81 a 84–87. | Relativní poloha osoby, převody tam a zpět, kresba a hrubý odhad před výpočtem, závěrečná kontrola smyslu výsledku. Statistické tabulky nahradit Excelem. |
| Cumming a Calin-Jageman, *Introduction to the New Statistics*, 2. vyd., 2024; `cumming.pdf` | Kap. 4, s. 74–81. | Přechod od spojitého modelu k plochám, vliv parametrů, rozdíl z-skóru a normality, meze modelu u ohraničených dat a v chvostech; zaokrouhlené skóry jako možné rozšíření. Následující výběrová rozdělení odložit. |
| Diez, Çetinkaya-Rundel a Barr, *OpenIntro Statistics*, 4. vyd., 2019; `diez.pdf` | Oddíl 4.1, s. 133–141. | Přehledná posloupnost otázek pod/nad/mezi a inverzní úlohy; kresba a kontrola výsledku. Nepřebírat časově specifické normy SAT jako aktuální empirický fakt. |
| Dostál, *Statistické metody v psychologii*; `dostal.pdf` | Oddíl 2.7, s. 31–37, zejména 2.7.2–2.7.3. | Česká terminologie, grafická interpretace hustoty a distribuční funkce. Matematickou formulaci i příliš široká zobecnění o normalitě přizpůsobit cíli; limitní větu nezařazovat. |
| Navarro, *Learning Statistics with R*; `navarro.pdf` | Oddíl 5.6, s. 191–193; oddíl 9.5, zejména s. 387–392. | Oddělení standardizace od normality, srozumitelné psychologické příklady a vliv parametrů. R kód ani delší matematické odbočky nepatří do studentského výkladu. Rok nové digitální verze nebyl odvozován z názvu souboru. |
| Privitera, *Statistics for the Behavioral Sciences*, 4. vyd., 2024; `privitera.pdf` | Kap. 6, s. 192–198 a 207–209; přehled návaznosti oddílů kapitoly. | Výslovné cíle a odstupňované převody hodnot a podílů. Nepřebírat obecná tvrzení o normalitě většiny chování ani hodnocení výsledků mimo dvě odchylky jako „nenormálních“ bez rozlišení významů. Binomická aproximace mimo rozsah. |
| Judd, McClelland a Ryan, *Data Analysis: A Model Comparison Approach to Regression, ANOVA, and Beyond*, 3. vyd.; `judd.pdf` | Kap. 3, úvod s. 25 a související výklad normálního modelu s. 29–32. | Autorská opora pro důsledné oddělení dat, modelu a předpokladů. Rozdělení chyb modelu, regrese a limitní argumentace jsou pro tuto kapitolu předčasné. |
| Sahu, *Introduction to Probability, Statistics & R: Foundations for Data-Based Sciences*, 2024; `sahu.pdf` | Oddíl 7.2: s. 125–126 a 130–135, zejména standardní normální model, převody a kvantily. | Technická kontrola vztahů, parametrů a rozdílu jednostranné a oboustranné hranice. Integrální odvození, programování a další rozdělení vynechat. |

Zdroje mají odlišné pořadí. Howell přechází od modelu ke standardizaci;
Gravetter a Navarro vykládají z-skóry odděleně dříve. Navržené pořadí
navazuje na transformace v naší kapitole 3 a zachovává Howellovo jádro
normálního modelu a jeho aplikací. Nejde o požadavek převzít součet témat
ze všech deseti knih.

Důležitý skutečný rozdíl je parametrizace zápisu normálního rozdělení:
OpenIntro užívá ve druhé pozici směrodatnou odchylku, zatímco Howell,
Dostál a Sahu rozptyl. Jde o různé konvence, nikoli různé modely.
Návrh proto ponechává kompaktní zápis mimo povinné minimum; pokud bude
zaveden, musí být jeho význam jednoznačně dohodnut. Slovo standard score
také může znamenat přímo z-skór nebo širší rodinu převedených skórů;
navrženo je druhé pojetí s jasným rozlišením konkrétních škál.

### Přednášky, procvičování a další podklady

Nová `sources/starší přednášky/normal_distribution.pptx` má 22 snímků.
Byl přečten jejich text a prohlédnuty vybrané vložené grafy normální
křivky, ploch, převodních škál a Q–Q grafů. Nebyl prováděn úplný render
a kontrola vzhledu prezentace v PowerPointu. Hlavní obsah dobře odpovídá
záměru: parametry, standardizace, plochy, jiné skóry a Excel. Následující
body se nesmějí automaticky převzít do nové kapitoly:

- Snímek 4 uvádí kurtosis = 0 bez odlišení excesu. Pro normální model
  je standardizovaný čtvrtý centrální moment 3, exces 0; navázat na již
  vysvětlené rozlišení v kapitole 3 a neopakovat celou momentovou odbočku.
- Snímek 21 označuje rozsah ±1,96 odchylky za „95% interval spolehlivosti“.
  Zde jde o prostředních přibližně 95 % jednotlivých výsledků modelu,
  nikoli o nejistotu odhadu populačního průměru.
- Snímky 15, 17 a 18 potřebují důsledné odlišení percentilu, jeho úrovně
  a percentilového pořadí. Rozmezí z-skórů nelze přiřadit jedinému
  percentilovému pořadí. Hodnoty ±2 odpovídají přibližně 2,28. a 97,72.
  percentilu, nikoli přesně 2,5. a 97,5.
- Steny a staniny potřebují hranice kategorií a ztrátu přesnosti,
  nikoli pouze uvedení středu a směrodatné odchylky. Spojitý lineární
  mezivýsledek není totožný s konečnou kategorií.
- Centrální limitní věta a výběrová rozdělení na snímcích 5–6 přesahují
  dohodnuté zaměření. Formální testy normality a mechanická pravidla
  typu absolutní šikmost pod 1 nebo 2 ze snímku 13 nejsou vhodným
  povinným rozhodovacím postupem pro tuto kapitolu. Pořadové vzorce
  pro konstrukci Q–Q grafu ze snímku 22 jsou zde nadbytečné.
- Příklad s pojmenovaným klinickým nástrojem a parametry 50 a 10
  není nezávisle ověřeným dokladem skutečných norem tohoto nástroje.
  Navržený výklad použije jasně označený vlastní modelový příklad.

Starší `PSYb1170_P03_2026_-_Transformace__rozdeleni_pravdedpodobnosti_.pptx`
spojuje standardizaci, normální model, pravděpodobnost a další návaznosti;
pro tuto kapitolu využít jen odpovídající části. Přednášky P01 a P02
slouží hlavně ke kontrole návaznosti na již probrané četnosti a popis.

Z `sources/příklady k procvičování/ulohy_tyden03_2024.docx` jsou relevantní
zvláště úlohy X3_04–X3_07 a blok normálního rozdělení a kvantilů od X3_21;
pravděpodobnostní část ponechat další kapitole. Starší listy týdnů 1–2
slouží k návaznostem, jejich obsah se nemá znovu přidávat. Příklady
ze `Seminar4_-_na_zed_-_2024.pptx` jsou vhodnou inspirací pro porovnání
relativní polohy, nelineární vztah percentilového pořadí a z-skóru a Excel.
Otázky na „větší talent“ přeformulovat podle toho, co z dat skutečně
plyne. `NORM.S.DIST` vrací kumulativní podíl, nikoli hodnotu kvantilu;
tuto terminologii ve starším semináři zpřesnit při případném převzetí.
Podklady nejsou vydávány za již opravené ani celé numericky přezkoušené.

V `sources/ostatní zdroje/Normalni_rozdeleni_do_3_aveamian._prednasky.xlsx`
byly přečteny listy, popisy a vzorce: plochy, hustota, převody z/T/IQ
a kvantily. Potvrzuje důraz autora na porozumění převodům a použití
kalkulátoru místo tištěných tabulek. Sešit nebyl přepočten v desktopovém
Excelu ani kompletně vizuálně kontrolován; má být inspirací pro nové
samostatně použitelné příklady, nikoli hotovým ověřeným studentským sešitem.

U zbývajících souborů bylo ověřeno zaměření. Podklady k datové matici,
kódování proměnných a Lordově příkladu fotbalových čísel nerozšiřují
jádro této kapitoly. Baronovy kapitoly o normativní a deskriptivní
pravděpodobnosti patří do budoucí přípravy pravděpodobnosti; jde
o skenované PDF, u nichž byly vizuálně posouzeny úvodní části, nikoli
přečten celý text. Obdobně byl výběrově prohlédnut Uttsové text o
statistické gramotnosti, včetně záměny podmíněných pravděpodobností;
pro tuto kapitolu je jen širším kontextem. Tyto omezené průchody nejsou
vydávány za úplnou rešerši uvedených článků či za chybějící kontrolu
některé z deseti učebnic.

### Doplňující primární zdroje a ověření návrhu

Základní vlastnosti a rozlišení kurtosis/exces byly porovnány s
[NIST: Normal Distribution](https://www.itl.nist.gov/div898/handbook/eda/section3/eda3661.htm).
Použití dalších škál bylo ověřeno v primárních materiálech vydavatelů:
[SHL, ukázková zpráva Verify Interactive](https://service.shl.com/docs/Verify%20Interactive%20Ability%20Report%20DNI%20UKE.pdf)
uvádí steny a T-skóry;
[GL Education, CAT4 Quick Data Guide](https://support.gl-education.com/knowledge-base/assessments/cat4-support/after-the-test/quick-data-guide)
vymezuje staninové kategorie;
[Pearson, výklad standardních a vážených skórů](https://www.pearsonclinical.co.uk/featured-topics/aa-and-the-dsa.html)
uvádí škály 100/15 a 10/3. Nejde o oprávnění zaměňovat normy různých
konkrétních testů nebo vydávat každý převod 100 + 15z za IQ.

České názvy a účel čtyř navržených funkcí byly ověřeny v dokumentaci
Microsoftu:
[NORM.S.DIST](https://support.microsoft.com/cs-cz/excel/functions/norm-s-dist-function),
[NORM.S.INV](https://support.microsoft.com/cs-cz/excel/functions/norm-s-inv-function),
[NORM.DIST](https://support.microsoft.com/cs-cz/excel/functions/norm-dist-function),
[NORM.INV](https://support.microsoft.com/cs-cz/excel/functions/norm-inv-function).
Dokumentační kontrola není vydávána za provedení budoucích příkladů
v českém Excelu.

Nezávislý výpočet normální distribuční a kvantilové funkce ověřil
číselné hodnoty použité při posouzení: prostřední podíly pro ±1, ±2
a ±3 jsou přibližně 0,6826895, 0,9544997 a 0,9973002; pro ±1,96
přibližně 0,9500042. Kvantily úrovní 0,90, 0,95 a 0,975 jsou
přibližně 1,281552, 1,644854 a 1,959964. Pro ideální staninové kategorie
s hranicemi ±0,25, ±0,75, ±1,25 a ±1,75 odpovídají zaokrouhlené
procentní podíly 4–7–12–17–20–17–12–7–4; jejich přesná směrodatná
odchylka je přibližně 1,944, proto se 2 nemá vydávat za přesnou
vlastnost každého kategorizovaného souboru. Výpočty nejsou nově
schválenými konvencemi studentského výkladu.

Didaktické posouzení návrhu hlídá vstupní znalosti a rozsah: nejprve
z-skór jako popis, poté model a plochy, až následně přesné převody
a jejich aplikace. Předpoklady normality jsou výslovně připojeny
k převodům na modelové podíly. Rozlišení standardizace a normalizace
má být krátké; Q–Q graf zůstává nepovinný. Jde o autorské posouzení
osnovy, nikoli o ověření porozumění na studentech.

Změny se týkají pouze osnovy a tohoto historického záznamu. Studentský
web, zdrojové prezentace a sešit ani konvence v `docs/ROZHODNUTI.md`
se nemění. Kontrola dokumentace ověřila UTF-8, místní odkazy včetně
explicitní kotvy tohoto záznamu, rozlišení dohodnutého a navrženého
obsahu a `git diff --check`. Render knihy, webové a mobilní kontroly
ani desktopový Excel nebyly pro tuto dokumentační změnu spouštěny;
veřejné nasazení nebylo ověřováno.

## Kapitola 4: schválení názvu normované normální rozdělení (2026-10-10)

Autor výslovně schválil „normované normální rozdělení“ jako používaný
český název pro standard normal distribution. V osnově byl nahrazen
původní návrh „standardní normální rozdělení“ a odlišena tato schválená
položka od dosud projednávaných termínů. Rozhodnutí R07 eviduje rozsah,
důvod a nahrazené doporučení; původní historický záznam přípravy zůstává
zachován.

Pro budoucí heslo studentského slovníčku jsou v osnově zaznamenány
alternativy „standardní normální rozdělení“ a „standardizované normální
rozdělení“ i dohodnuté jazykové vysvětlení: první varianta je doslovnější
překlad, ale blízký běžný význam obou přídavných jmen může působit
kostrbatě. Nejde o tvrzení, že je alternativní odborný název chybný.
Studentský slovníček se doplní současně s prvním výkladem v dosud
nevytvořené kapitole; nevzniká předčasný odkaz na neexistující kapitolu.

Změna se týká pouze tří autorských dokumentů. Ověřeny rozdíly, UTF-8,
místní odkazy a výskyty termínu v osnově; git diff --check prošel.
Render, numerické, excelové ani webové kontroly se pro tuto
terminologickou změnu autorské dokumentace nespouštěly.

## Kapitola 4: souhlas se zbývající terminologií (2026-10-10)

Po diskusi autor přijal jednoduché označení IQ-skóry s upozorněním,
že škála 100/15 může vyjadřovat i výsledky jiných než inteligenčních
testů; změna měřítka nemění měřenou vlastnost. U subtestových skórů
schválil označení standardní subtestové skóry. Alternativa vážené skóry
zůstává pro slovníček a vysvětlení při prvním výkladu, aby ji studenti
nezaměňovali za vážený součet či průměr položek nebo subškál.

Autorův souhlas se zbytkem terminologie je zaznamenán jako R08.
Osnova používá schválené názvy v tematickém oddílu i přehledu pojmů;
upozorňuje také, že chvost rozdělení byl již zaveden v kapitole 2.
Nové symboly, konečná podoba osnovy, příklady a rozsah nepovinných témat
nadále zůstávají k dohodě; souhlas s terminologií je nepotvrzuje.

Při předchozí diskusi byl doložen starší anglický termín weighted scores
v názvu článku A critique of the Wechsler-Bellevue system of weighted
scores (1949), https://pubmed.ncbi.nlm.nih.gov/18118257/. To umožňuje
uvažovat i o přímém překladu z angličtiny, ale neprokazuje skutečnou
cestu převzetí do češtiny. Německý či ruský původ není doložen a nebude
vydáván za fakt. Odkaz a omezení jsou zaznamenány v osnově.

Kontrola tří upravených autorských dokumentů ověřila UTF-8, místní
odkazy včetně kotev, soulad názvů a rozlišení schválených termínů
od návrhů značení a obsahu; git diff --check prošel. Studentské kapitoly,
slovníček ani web se nemění, render a numerické či webové kontroly
se proto nespouštěly. Přehledy se doplní spolu s prvním výkladem.

## Kapitola 4: vytvoření výkladu, 2026-10-10 {#vytvoreni-kapitoly-4}

Autor schválil tvorbu kapitoly a navrženou posloupnost s výslovnými
dodatky: zařadit N(μ, σ²) a povinné posouzení přiměřenosti modelu včetně
čtení i tvorby normálního Q–Q grafu. R09 v přehledu rozhodnutí nahrazuje
dřívější návrh obě témata odložit nebo ponechat nepovinná. R07 a R08
zůstávají v platnosti. Osnova nyní rozlišuje realizovanou kapitolu od
dosud nedohodnuté následující kapitoly o pravděpodobnosti.

Vznikl souvislý výklad v `kapitola_04.qmd`, dvanáct původních SVG obrázků
generovaných v základním R, deset samostatných úloh s úplnými sbalenými
řešeními a dvoulistový sešit `data/kapitola_04.xlsx`. List `Model` spojuje
převody ploch a kvantilů, list `QQ` ukazuje 12 pořadí, výpočet kvantilů
a upravitelný bodový graf. Malý soubor je také v CSV. Doplněny jsou všechny
tři přehledy, navigace, bibliografie, generátor a automatické kontroly.

### Odborná a didaktická rozhodnutí při psaní

Výklad vychází z předchozího posouzení všech deseti učebnic a autorských
podkladů, zaznamenaného výše v přípravě kapitoly. Howell (2013), kapitola 3,
s. 66–79, zůstává hlavní oporou; znovu byly přečteny s. 75–78 pro povinné
Q–Q grafy. Jeho výklad směrů os není jednotný, proto nová kapitola vždy
explicitně používá normální kvantily vodorovně, data svisle. Neopisuje
idealizovanou úvahu, že nejvyšší hodnota konečného souboru má konečný
100. normální percentil, ani nepředkládá 45° úhel jako obecnou podmínku.

Pořadové polohy (i − 0,5)/n jsou zvolenou jednoduchou konstrukcí pro
výuku (dokumentace R `ppoints`, parametr a = 0,5); přímka m + sz dává
přímou návaznost na již vysvětlený zpětný převod. Nejde o novou konvenci
empirických kvantilů nebo percentilových pořadí. Čtení průběhu doplňuje
NIST, oddíl Normal Probability Plot. Jiná poloha os, polohovací vzorec
nebo kvartilová přímka v programu nemusí znamenat chybu.

Ilustrační skór pozornosti s μ = 50 a σ = 10, všechny malé soubory,
úlohy i grafy jsou původní autorské konstrukce; nejsou vydávány za
Achenbachovy normy ani za reálná výzkumná data. Simulované diagnostické
obrázky používají seed 20261010 a po 200 hodnotách: normální rozdělení,
posunuté exponenciální rozdělení, symetrické t rozdělení se třemi stupni
volnosti a směs dvou normálních skupin. Názvy těchto dalších modelů se
studentům předčasně nezavádějí; obrázky slouží k interpretaci tvaru.

Plochy začínají vysvětlením výšky histogramu a plochy obdélníku, aby
nevyžadovaly nepovinné učivo kapitoly 2. Hustota a distribuční funkce
mají samostatně porovnané grafy. Odlišujeme výsledek spojitého modelu,
zaokrouhlený skór a diskrétní počet. Prostřední 95% interval se vztahuje
k jednotlivým hodnotám při zadaném modelu, nikoli k nejistotě průměru.
Zařazení mimo dvě odchylky není diagnostickým rozhodnutím. Standardizace
nemění šikmost a větší soubor nenormalizuje původní hodnoty.

Parametry 10/3 ověřuje Pearson Clinical Assessment's Scientific Council
(2023), s. 4; nepřebírá se tamní příliš široké tvrzení, že každé standardní
skórování vytváří normální křivku. SHL (2019), s. 6, dokládá měřítko stenů,
GL Assessment staniny. Podíly pásem byly vypočteny nezávisle z normálního
modelu, nikoli převzaty jako zaokrouhlená percentilová pásma konkrétního
testu. Přesné hraniční hodnoty používají dolní vyloučenou/horní zahrnutou
mez z R03, což je v textu uvedeno; skutečné testy se řídí svým manuálem.
Například přesné z = 0 zde dává sten 5, přestože jiné normy při zaokrouhlení
mohou dát 6. Původ výrazu „vážený skór“ se historicky nespekuluje.

České názvy čtyř normálních funkcí ověřila oficiální dokumentace Microsoftu
a skutečný Excel 16.0. U NORM.S.DIST s NEPRAVDA text uvádí hustotu,
nepřebírá chybný český popisek „hromadná pravděpodobnostní funkce“.
NORM.DIST a NORM.INV přijímají odchylku; N(μ, σ²) zapisuje rozptyl.

Didaktická revize sledovala návaznost referenční skupina → z-skór →
model → plocha → kvantil → škály → Q–Q graf. Vysvětlila význam μ a σ,
každého kroku inverzního převodu i rozdíl pořadové polohy pro graf od
empirického percentilového pořadí. Úlohy pokrývají výpočet, interpretaci,
práci s modelem i opravu argumentu; jejich řešení obsahují mezikroky.
Tato interní revize není ověřením porozumění na studentech.

### Ověření

Průběžně prošel plný render knihy v Quarto 1.9.38 / R 4.5.1, numerické
kontroly všech čtyř kapitol a skutečné české vzorce v Excelu 16.0.
Kontrola sešitu porovnala všechny pořadové polohy, inverzní převody,
krajní chybové argumenty, změny vstupů i datové vazby bodového grafu.
Oba listy byly prohlédnuty v náhledu i po nativním exportu Excelu.
Webová kontrola zachytila vodorovné přetékání nové tabulky a dlouhých
vzorců na mobilu; opravily se zdroje, nikoli generované HTML.
Závěrečná kontrola webu prošla na všech 9 stránkách: všechny místní odkazy,
159 hesel slovníčku, všech 42 řešení (včetně deseti nových), stránkování
a hledání v přehledech, odkazy přes aktivní filtr, klávesnice, mobilní
šířka 390 px, desktop 1360/1920 px a náhradní chování bez JavaScriptu
i při otevření souboru. Řecké μ a σ mají v renderovaném MathML stojatý
řez; matematika neobsahuje chyby a kód R není zobrazen. Prohlédnuty byly
všechny nové obrázky, nové citace, klíčové oddíly na desktopu a mobilu
i oba listy sešitu. Podrobné obrázky na mobilu ponechávají čitelné
měřítko a posouvají se uvnitř samostatné oblasti, stejně jako široké
tabulky. Webová kontrola zároveň ověřila jejich posun.

Finální sešit znovu prošel nativní kontrolou po zavření a otevření,
bez ukládání testovacích změn. Soubor ve vykresleném webu se shoduje
s finální verzí v `data/`. Kontrola UTF-8 a `git diff --check` prošla.
Vznikl samostatný kontrolní skript kapitoly a jeho zapojení do CI;
desktopový Excel se spouští místně, nikoli v linuxovém CI. Lokální
výsledek sám nepotvrzuje publikování na GitHub Pages; změna je připravena
v tematické větvi `codex/chapter-04` pro uživatelovu kontrolu a sloučení.

## Kapitola 1: revize po posouzení (2026-10-11)

Na žádost autora proběhlo posouzení kapitoly 1 z hlediska věcné správnosti,
didaktiky a jazyka. Hrubá věcná chyba nalezena nebyla. Autor rozhodl sporné
body; platné konvence shrnuje [R10](../docs/rozhodnuti/kapitola-01.md#r10-terminologie-kapitoly-1).
Úpravy jsou ve větvi `codex/chapter-01-review` z `main` (d30bd98).

### Terminologie

- Hlavní termín je pravděpodobnostní výběr, náhodný výběr je alternativa.
  Náhodné rozdělení do podmínek nahrazeno náhodným přidělením do podmínek.
- Chybný tvar „predikant“ nahrazen označením odhadovaná (predikovaná)
  proměnná s alternativou prediktand. Kotva slovníčku je nově
  `pojem-odhadovana-promenna`; přejmenovány také `pojem-pravdepodobnostni-vyber`
  a `pojem-nahodne-prideleni`. Staré kotvy se v repozitáři nepoužívají.
- Pro část populace důsledně „výběr“. „Soubor“ zůstal jen pro datový soubor
  a vymezenou množinu případů.
- Kapitoly 3 a 4 používají „náhodný výběr“ v obecných spojeních a nemění se.

### Věcná zpřesnění

- Kódování: opraven obrácený směr definice (přiřazujeme kódy odpovědím).
- Alternativní vysvětlení souvislosti spánku a výkonu výslovně popisuje
  společnou příčinu; nový termín se nezavádí.
- Doplněn vztah chyby měření a systematického zkreslení; sladěno řešení
  úlohy 7b.
- Závěrečná věta oddílu o rolích proměnných zmírněna z „nelze se otázce
  jejich rolí zcela vyhnout“ na „vyplatí se o jejich rolích uvažovat“.
  Původní znění bylo autorovou formulací z 2026-10-05; jde o návrh
  předložený autorovi k posouzení v pull requestu.

### Struktura a didaktika

- Tři nová sbalená nepovinná rozšíření: model měření, spor o čísla na
  dresech, posuvník a verbální kotvy. Spor je nově převyprávěn podle
  Lorda (1953, s. 750–751) a Zand Scholten a Borsbooma (2009, s. 71–73);
  oba texty byly přečteny v `sources/ostatní zdroje/`.
- Přípustné změny číselného zápisu přesunuty za souhrnnou tabulku čtyř
  úrovní měření.
- Nové schéma populace → výběr → přidělení do podmínek
  (`scripts/kapitola_01.R`, generované SVG v ignorované složce
  `assets/chapter-01/plots/`). Jde o ilustraci s pevnými polohami teček,
  nikoli o zobrazení dat.
- Omezeno opakování vazby „samo (o sobě) nedokládá / nezaručuje“
  a odstraněny dvě duplicitní věty. Cíle učení jsou výčtem; ostatní
  kapitoly mají cíle dosud v odstavci.
- Úloha 7e má novou situaci (dotazník spokojenosti klientů poradny)
  s úplným řešením; řešení úloh 1–4 mají označené části.
- Opraveny jazykové chyby (překlep, předložka, interpunkce, nejasné odkazy).

### Ověření

Celá kniha se vykreslila v Quarto 1.9.38 / R 4.5.1. `check-chapter-01.R`
prošel. `check-html.cjs` po doplnění tří nových hledání prošel bez chyb:
9 stránek, 159 hesel slovníčku, místní odkazy, 42 řešení, desktop
1360/1920 px a mobil 390 px. Kontrola běžela s místním Chrome a modulem
Playwright z jiné instalace, nikoli s verzí 1.55.0 uvedenou v README.
Ručně v prohlížeči prohlédnuto schéma na desktopu i mobilu, rozbalení tří
nových rozšíření, vykreslené citace Lorda a Zand Scholten a Borsbooma
a zpřístupnění nových řádků slovníčku přes odkaz.

Neověřeno: stránky a lokátory ostatních citací kapitoly vůči zdrojům,
jiné prohlížeče než Chrome a veřejné publikování. Excelové příklady se
nemění a desktopový Excel nebyl spuštěn. Interní didaktická revize není
ověřením porozumění na studentech.

## Zjednodušení větví a bezpečný úklid (2026-10-11)

Na výslovnou žádost autora zavedeny názvy `codex/chapter-NN` a `codex/other`
s nejvýše jednou aktivní větví na kapitolu. Po sloučení a ověření se větev
odstraní a při další práci vznikne z aktuálního `origin/main` pod stejným
názvem. Pravidla jsou v `AGENTS.md`, schválené rozhodnutí v R11.

Před úklidem byl hlavní pracovní strom čistý. Aktualizace pomocí
`git fetch --prune origin` ukázala, že všech 39 starých pracovních větví
již na GitHubu neexistuje. Z lokálních větví bylo 38 obsaženo přímo
v historii `origin/main` (03e99de). Výjimka `codex/book-sections-bibliography`
obsahovala commit 8a5d840 převzatý do `main` jako 6f3e429: `git cherry`
potvrdil ekvivalenci a oba diffy mají shodný stabilní patch-id
86b6614a5ba635226b5126ea73e65226d4d8fd99. Žádné jedinečné změny nezůstaly.

Pracovní kopie `tmp/chapter-01-concepts` byla čistá bez nesledovaných
neignorovaných souborů; ignorované soubory tvoří výstup webu, cache Quarta
a snímky kontrol. Byla ponechána na původním commitu 99a31f9 v detached
HEAD, takže její soubory zůstaly zachované a starý název větve šlo odstranit.
Všech 39 starých lokálních pracovních větví bylo odstraněno. Lokální
`main` byl posunut na aktuální `origin/main`; nové instrukce vznikají
na `codex/other`. Sloučení tohoto PR zůstává na autorovi.

Ověření: stav obou pracovních stromů, historie a ekvivalence výjimečného
commitu, seznam větví, kontrola rozdílů a `git diff --check`. Změny se týkají
jen autorských instrukcí a dokumentace, render ani numerické a excelové
kontroly proto nebyly potřeba a nebyly spuštěny.

## Názorné diagramy a grafy ve výkladu (2026-10-11)

Na žádost autora doplněno do oddílu „Didaktika a jazyk“ v `AGENTS.md`
pravidlo zařazovat diagramy, schémata a grafy podle jejich přínosu
pro pochopení pojmů, jejich vztahů a principů postupů. Referenčním příkladem
je schéma výběru z populace a přidělení do podmínek v první kapitole.
Rozhodnutí zachycuje R12 v `docs/ROZHODNUTI.md`.

Ověření: kontrola formulace, návaznosti pravidel a rozdílů; `git diff --check`.
Jde pouze o autorské instrukce a dokumentaci, proto render ani výpočetní
a excelové kontroly nebyly potřeba a nebyly spuštěny.

## Názorné vizualizace v kapitolách 2–4 (2026-10-11)

Na výslovný pokyn autora uskutečněno všech jedenáct předložených návrhů,
prioritních i neprioritních. Jde o devět nových obrázků a rozšíření dvou
stávajících; všechny vycházejí z dosavadních autorských příkladů:

- Kapitola 2: dva základy procent při chybějícím údaji; „právě“ versus
  „nejvýše“; zařazení společné intervalové meze; rozšíření porovnání
  histogramů o posunuté meze při zachované šířce jedné hodiny.
- Kapitola 3: příspěvky různě velkých skupin ke společnému průměru;
  percentil versus inkluzivní percentilové pořadí; ořezání versus
  winsorizace včetně počtu hodnot vstupujících do výpočtu.
- Kapitola 4: z-skór jako počet jednotek směrodatné odchylky; rozšíření
  standardních škál o percentilové pořadí podle normálního modelu;
  stenová a staninová pásma včetně ztráty podrobností; vznik souřadnic
  jednoho bodu Q–Q grafu ze společného pořadí.

Generátory zůstávají v `scripts/kapitola_02.R` až `kapitola_04.R` a při
renderu vytvářejí SVG. Každý nový obrázek má stabilní identifikátor,
alternativní text a vysvětlení ve výkladu. Nová třída `teaching-figure`
umožňuje v kapitolách 2 a 3 místní posouvání širokých diagramů; kapitola 4
používá svůj existující kontejner. Oblasti jsou pojmenované a ovladatelné
klávesnicí. Rozsah učiva, terminologie, přehledy ani studentské sešity se
nemění; schválení realizace je doplněno k rozhodnutí R12.

Didaktická revize se zaměřila na návaznost příkladu, obrázku a interpretace.
Výslovně odlišuje chybění od nesplnění podmínky, pořadové rozestupy od
časových vzdáleností, změnu šířky od posunu mezí, kvantil od pořadí,
lineární převod od normálního modelu a teoretický kvantil Q–Q od
standardizace pozorovaného skóru. Interní revize není ověřením porozumění
na studentech.

Ověření: úplný render devíti stránek (Quarto 1.9.38, R 4.5.1), číselné
kontroly kapitol 2–4 a nezávislý přepočet všech nových číselných příkladů
v Pythonu (`statistics.NormalDist`, přímé počítání intervalů a podílů).
Webová kontrola v místním Chromu ověřila odkazy, 159 hesel slovníčku,
42 skrytých a rozbalitelných řešení, matematiku, načtení obrázků,
desktop 1360/1920 px a mobil 390 px bez přetékání celé stránky.
Rozšířené kontroly pokrývají všech jedenáct dotčených obrázků, odkazy
z výkladu, čitelné minimální šířky a místní posouvání klávesnicí.
Vizuálně prohlédnuty všechny dotčené obrázky na desktopu i obě krajní
polohy jejich mobilních výřezů. Snímky a nezávislý pomocný výpočet jsou
v ignorované složce `tmp/`; zdrojové R a HTML kontroly jsou v repozitáři.
Kontrola `git diff --check` prošla.

Omezení: jde o lokálně vykreslený web, nikoli o potvrzení veřejného
nasazení. Jiné prohlížeče než Chrome nebyly ověřeny. Desktopový Excel
nebyl znovu spuštěn, protože sešity ani excelové vzorce se nemění.

## Cíle kapitol jako seznam s odrážkami (2026-10-11)

Na pokyn autora doplněno do `AGENTS.md` pravidlo, že úvodní blok s cíli
kapitoly se formátuje jako seznam s odrážkami;
[R16](../docs/rozhodnuti/postupy-a-dokumentace.md#r16-cile-kapitoly-odrazky). Změna se týká jen
instrukcí a autorské dokumentace, render nebyl potřeba. Úpravy kapitol 3
a 4 jsou v jejich větvích.

## Kapitola 2: revize po posouzení (2026-10-11)

Na žádost autora proběhlo posouzení kapitoly 2 z hlediska věcné správnosti,
srozumitelnosti, návaznosti, didaktiky, jazyka a názvosloví. Hrubá věcná
ani početní chyba nalezena nebyla; všechna čísla výkladu a řešení byla
znovu přepočítána proti `data/kapitola_02.csv`. Autor rozhodl sporné body;
platné konvence shrnuje [R13](../docs/rozhodnuti/kapitola-02.md#r13-platny-udaj-velikost-vyberu).
Úpravy jsou ve větvi `codex/chapter-02` z `origin/main` (259f5c7).

### Terminologie

- Hlavní termín pro *sample size* je velikost výběru (dříve rozsah souboru);
  změněno v kapitole 2, na jediném místě kapitoly 3, ve slovníčku
  (kotva `pojem-velikost-vyberu`; stará kotva se v repozitáři nepoužívala)
  a v přehledu značení. „Velikost skupin“ se nemění.
- Platný údaj (*valid value*) je zaveden v oddílu o jmenovateli a nahrazuje
  střídané „známý / dostupný / nechybějící údaj“ v textu, popiscích, alt
  textech, obrázku základů procent a cvičeních. Slovníček má nové heslo
  Platný údaj a heslo Chybějící údaj; každé uvádí, že je opakem druhého.
  Anglický ekvivalent *valid value* odpovídá běžnému označení ve
  statistických programech; nebyl dohledáván v Howellovi.
- Panel obrázku tvarů se jmenuje Odlehlé pozorování (dříve Vzdálené).
- „Vícečetné odpovědi“ nahrazeny opisem „otázky umožňující více odpovědí“;
  „kumulativní graf“ sjednocen na graf kumulativních četností,
  „procentuální formát“ na procentní. U sloupcového grafu „samostatné
  kategorie“ místo „kategorie diskrétní proměnné“. Kde šlo o zařazování
  případů, je „rozdělení“ nahrazeno slovy zařazení a roztřídění.

### Návaznost a didaktika

- Odstraněny dopředné odkazy na dosud nezavedené pojmy: populační parametr
  u znaku sumace, intervalové třídění u definice kumulativní četnosti
  (nahrazeno odkazem na pozdější oddíl) a střed intervalu u ztráty přesnosti.
- Odstavec o indexech nejprve zavádí značky f a p, pak index; výklad sumace
  nově jmenuje dolní a horní mez sčítání, které používá úloha 2 a přehled
  značení.
- Příklad otázky s více odpověďmi doplněn o procento odpovědí (6 z 11),
  které úvodní věta odstavce slibovala.
- Pořadí výkladu sladěno s obrázky: srovnání konvencí mezí odkazuje na
  obrázek i tabulku; odstavec o dolních panelech histogramů předchází
  obecným doporučením; rovnoměrné rozdělení následuje za vrcholy a je
  zkráceno o větu s nezavedeným pojmem pravděpodobnostního modelu.
- Cíle učení jsou výčtem. Zjednodušeno několik rozvleklých vět a opraveny
  jazykové chyby (překlep, uvozovky, tvar „7,5 hodiny“, nejednotný vid).

### Cvičení

Počet úloh zůstává deset. Úloha 3 má novou část b) o otázce s více
odpověďmi (60,0 %, 70,0 %, 30,0 %; součet 160,0 %; 32 označení od 20 lidí)
s úplným řešením. Úlohy 6 a 7 mají označené části v zadání i řešení.

### Ověření

`scripts/kapitola_02.R` znovu vytvořil 14 obrázků; `check-chapter-02.R`
(doplněný o novou část úlohy 3 a příklad 6 z 11) prošel. Celá kniha se
vykreslila v Quarto 1.9.38 / R 4.5.1. `check-html.cjs` prošel bez chyb:
9 stránek, 160 hesel slovníčku, místní odkazy, 42 řešení, desktop
1360/1920 px a mobil 390 px; běžel s místním Chrome a modulem Playwright
z jiné instalace. Na snímcích vykreslené stránky prohlédnuty cíle učení,
obrázek základů procent, obrázek tvarů a rozbalená řešení úloh 3 a 7;
nevyřešené křížové odkazy v kapitole nejsou.

Omezení: nové heslo slovníčku nebylo samostatně testováno hledáním
a přímým odkazem nad rámec obecné kontroly tabulky. Sešit XLSX se nemění
a Excel nebyl spuštěn. Citované stránky zdrojů nebyly znovu ověřovány,
protože se citace nemění. Interní revize není ověřením porozumění na studentech.

## Kapitola 3: revize po posouzení (2026-10-11)

Autor zadal kontrolu kapitoly 3 z hlediska věcné správnosti, srozumitelnosti,
návaznosti, didaktiky, jazyka a konzistence názvosloví. Kapitola byla přečtena
celá; všechny příklady, tabulky a řešení čtrnácti cvičení byly ručně
přepočítány. Početní chyba nalezena nebyla. Opravy jsou jazykové,
terminologické a didaktické; rozhodnutí autora zachycuje
[R14](../docs/rozhodnuti/kapitola-03.md#r14-kvartily-spicatost-chvost).

### Rozhodnutí autora

- Hlavní označení **1. a 3. kvartil**; „dolní/horní“ jen při zavedení
  a ve slovníčku. Provedeno v kapitole, slovníčku, přehledu značení,
  popiscích sešitu a jeho generátoru.
- Hlavní termín **špičatost** (*kurtosis*), „kurtóza“ alternativa. Heslo
  slovníčku přejmenováno, kotva `pojem-kurtoza` zachována kvůli odkazům.
- Důsledně **chvost** místo „konec“ rozdělení (popis dat o spánku a paměti,
  česká ukázka APA, komentář k tvaru).
- Odkaz na obrázek z CDN Medium u grafu odchylek a čtverců odstraněn
  (křehká adresa bez bibliografického údaje).
- `data/kapitola_03.csv` zrušeno; všechny údaje příkladů jsou v sešitu.
  Nový list `Dalsi_priklady`: jedenáct dob (A2:A12), deset dob (C2:C11),
  41 skórů (E2:E42) a sedm kontrolních výsledků (H2:H8). `scripts/kapitola_03.R`
  má hodnoty zapsané přímo.

### Věcné a didaktické opravy výkladu

- **Střed a tvar:** odstavec o zešikmení doleva odkazoval na „zrcadlovou
  situaci“ před jejím popisem a tvrdil, že „většina hodnot je větších než
  průměr, ale nižších než modus“, což svádí k závěru, že většina leží mezi
  nimi. Nově: více než polovina nad průměrem a více než polovina pod modem,
  s výslovným vyloučením chybného čtení; opraven překlep.
- **Průměr více skupin:** zmínka o „rozptylech součtu“ před zavedením
  rozptylu nahrazena obecnou „variabilitou součtu“.
- **Kvantily:** $p_j$ z kapitoly 2 je relativní četnost, ne „index kategorie“;
  opravena návaznost příkladu 1, 2, 3, 4; u ordinálního příkladu zkráceno
  trojí opakování a doplněna vazba na dvě prostřední kategorie mediánu.
- **Korekce rozptylu:** zpřesněno, že součet čtverců kolem výběrového průměru
  nepřevýší součet kolem populačního v žádném výběru; „nestranný odhad“ se už
  nepoužívá před svou definicí; komentář k simulaci jmenuje dělení místo
  „druhého sloupce výpočtů“ a uvádí očekávané hodnoty 6,4; 7,6; 7,92.
- **Směrodatná odchylka:** závorka „(zde v min²)“ stála u původních jednotek.
- **Transformace:** odstavec o ukazatelích založených na uspořádání přesunut
  k nelineární transformaci, kde má vyústění: medián lichého souboru se při
  rostoucím převodu převádí přímo (25), interpolovaný 90. percentil nikoli
  (74,4 ≠ 70,56). Bez nového pojmu.
- **Reportování:** odstavec o přirozené nule a nulové základně sloupců měl
  nadpis „Zaokrouhlování“; má vlastní pododdíl.
- Terminologie podle R13: „rozsah“ → „velikost výběru“ (tabulka a alt text
  simulace, popisek osy grafu, tabulka volby statistik); „rozptýlenost“
  jako pouhé synonymum → „variabilita“; pomocné meze jednotně.
- Odkazy na pravidlo 68–95–99,7 a kapitolu 4; identifikátory pododdílů
  `sec-vlastnosti-ukazatelu`, `sec-nelinearni-transformace`,
  `sec-zaokrouhlovani-03`, `sec-nula-graf`, `sec-spicatost`.
- Jazyk: překlepy, zkrácení rozvleklých vět (odchylky, entropie nulové
  kategorie, anglické popisky boxplotu, momenty).

### Cvičení

Úloha 8 upozorňuje, že shoda 20% winsorizovaného průměru s hodnotou 5,9
z výkladu je náhodná. Úloha 12 nově žádá zápis se značkami APA 7
(*M* = 7,0; *SD* = 2,6; *Mdn* = 7); cíl reportování dosud neměl cvičení.

### Ověření

`check-chapter-03.R` prošel (R 4.5.1), včetně souhrnů spánku a paměti
a simulace. `check-chapter-03-excel.ps1 -Finalize` skutečně běžel
v Excelu 16.0: české vzorce, 247 vstupních buněk včetně nového listu,
výsledky H2:H8 (6,4; 8; 5,5; 40; 50; 60; 20) a přepočet při změně vstupů.
Skript dostal BOM UTF-8; bez něj Windows PowerShell 5.1 české názvy funkcí
nenačetl. Celá kniha se vykreslila v Quarto 1.9.38 bez varování. První
render odhalil, že buňka slovníčku začínající „3. kvartil…“ se četla jako
číslovaný seznam; formulace upravena. V prohlížeči ověřeno: kotvy v kapitole,
odkazy do kapitol 2 a 4, 17 sbalených bloků, žádný odkaz na CSV, řádky
slovníčku `pojem-kurtoza` a `pojem-kvartil`, šířka 375 px bez vodorovného
přetékání. Strany Howella citované v kapitole (27, 32, 34–35, 38–41, 45–50)
byly porovnány s textem PDF podle výskytu témat a odpovídají.

Dodatek z téhož dne: úvodní blok „Co budete po prostudování umět“ byl na
pokyn autora převeden z odstavce na seznam s odrážkami, beze změny obsahu;
poznámka o nepovinných rozšířeních zůstává jako věta pod seznamem. Kapitola
se znovu vykreslila bez varování.

`check-html.cjs` po doinstalování Playwright 1.55.0 a Chromia prošel bez chyb:
9 stránek, 160 hesel slovníčku, místní odkazy, 42 řešení, desktop
1360/1920 px a mobil 390 px.

Omezení: generátor `kapitola_03-sešit.mjs` byl upraven, ale nespuštěn
(chybí `@oai/artifact-tool`); list byl do uloženého sešitu doplněn přímo
v Excelu a zdroj prošel jen kontrolou syntaxe. `check-chapter-04-excel.ps1`
je rovněž bez BOM a nebyl měněn. Citace mimo Howella nebyly znovu ověřovány.
Interní revize není ověřením porozumění na studentech.

## Kapitola 4: revize po posouzení (2026-10-11)

Na žádost autora proběhlo posouzení kapitoly 4 z hlediska věcné správnosti,
srozumitelnosti, návaznosti, didaktiky, jazyka a názvosloví. Hrubá věcná
chyba nalezena nebyla; všechna čísla výkladu i řešení byla nezávisle
přepočítána (Python `statistics.NormalDist`) a souhlasí. Úpravy jsou ve
větvi `codex/chapter-04` z `origin/main` (c4de22e).

### Rozhodnutí autora

- Zápis normálního modelu je nově N(μ, σ) se směrodatnou odchylkou jako
  druhým parametrem ([R15](../docs/rozhodnuti/kapitola-04.md#r15-zapis-normalniho-modelu),
  nahrazuje příslušnou část R09). Ilustrační model je N(50, 10); výklad
  upozorňuje na častou konvenci N(μ, σ²). Úloha 3 používá N(80, 5).
- Úvodní blok cílů je seznam s odrážkami. Věta o posouvání na úzké
  obrazovce byla odstraněna.
- „Výzkumný soubor“ v oddílu o výpočtu v Excelu zůstává jako přípustná
  alternativa; „normativní skupina“ → „normativní soubor“; v řešení úlohy 10
  „velikost výběru n = 200“ (R13).
- Cvičení zůstávají v počtu deseti; doplněny dílčí otázky v úlohách 3
  (konvence zápisu a argument `NORM.DIST`), 7 (nestejné přírůstky modelových
  percentilových pořadí) a 10 (Q–Q graf zešikmeného rozdělení).

### Další opravy

- Samotné „odchylka“ ve významu směrodatné odchylky nahrazeno plným
  termínem ve výkladu, řešeních, alt textu, slovníčku, značení a popiscích
  obrázků 4.1 a 4.3 (legendy nyní uvádějí N(50, 10) apod.). Důvod: v kapitole 3
  znamená „odchylka“ rozdíl hodnoty od průměru.
- Nezavedený zápis polouzavřených intervalů v řešení úlohy 8 nahrazen
  nerovnostmi; „model 50/10“ → N(50, 10); „na normované škále“ → „na škále
  z-skórů“; IQ-skór zaveden v jednotném čísle; vysvětleno slovo inverzní.
- Podíl mezi dvěma hranicemi je vyložen v pořadí z-skóry → levé plochy →
  rozdíl (vzorec se zaokrouhlením na pět míst) → Excel. Před výpočtem
  90. percentilu je předpověď znaménka. Odkaz „plochu nyní vysvětlíme“ míří
  na správný oddíl.
- Doplněno z osnovy: modelové percentilové pořadí není procento správných
  odpovědí (4.4.6); obvyklé zaokrouhlené podíly staninů (4.6.4).
- Zkráceno opakování přírůstků 34,1 a 13,6 v oddílu o normalizaci;
  zpřesněna věta o výšce a šířce křivky; jazykové opravy („Ve spojitém“,
  chybějící čárka, dvojznačné „bez dalšího údaje“, „rovnice přímky“).
- Popisek příkazu řazení opraven na „Seřadit od nejmenšího k největšímu“.

### Ověření a omezení

`check-chapter-04.R` prošel (R 4.5.1) včetně nových kontrol úlohy 3
a zaokrouhleného rozdílu ploch. Celá kniha se vykreslila v Quarto 1.9.38
bez varování; `check-html.cjs` prošel bez chyb (9 stránek, 160 hesel,
42 řešení, mobil 390 px). V prohlížeči ověřeno: 15 obrázků se načte, nové
popisky obrázků 4.1 a 4.3 se vejdou, deset sbalených řešení, stojaté μ a σ,
žádná chyba matematiky, žádný kód R, šířka 390 px bez vodorovného přetékání.
Strany Howella (66–68, 69–71, 74–75, 75–78, 78–79) byly porovnány s textem
PDF podle výskytu témat a odpovídají.

Omezení: sešit `data/kapitola_04.xlsx` se neměnil a Excel nebyl znovu
spuštěn; popisek příkazu řazení nebyl ověřen v běžícím českém Excelu.
Údaj o dostupnosti funkcí od Excelu 2016 zůstal beze změny, i když funkce
pravděpodobně existují už od verze 2010 (neověřeno v dokumentaci). Citace
mimo Howella nebyly znovu ověřovány. Ostatní obrázky byly prohlédnuty jen
v malém měřítku. Interní revize není ověřením porozumění na studentech.

## 2026-10-11: mapa autorských zdrojů

Na výslovnou žádost autora vytvořena [mapa zdrojů](../docs/ZDROJE.md)
pro přípravu dalších kapitol. Zahrnuje všech 28 souborů aktuálního `sources/`,
stabilní identifikátory, bibliografickou identitu v dostupném rozsahu,
tematický rozcestník, mapy obsahu, konkrétní lokátory a meze provedeného
ověření. Do `AGENTS.md` doplněn postup použití a údržby mapy; do kořenového
README přidán odkaz. Osnova, studentský text a původní podklady se nemění.

Všechny soubory byly otevřeny a obsahově posouzeny. U učebnic zmapován
obsah a prostudovány vybrané pasáže, zejména k pravděpodobnosti a návaznostem;
nejde o úplné přečtení všech knih. U prezentací extrahován text i poznámky
podle skutečných vazeb, všechny snímky vyexportovány PowerPointem a vybrané
kontaktní listy vizuálně prohlédnuty. Pro skeny použito OCR s vybranými
vizuálními kontrolami. Prostudovány texty a tabulky souborů úloh a prohlédnuty
vložené obrázky. U XLSX zkontrolovány listy, vzorce, uložené výsledky a
zdrojové rozsahy grafů.

Konkrétní nálezy jsou u zdrojů: například nesoulad kvartilového vzorce
v P02, záměna součtu čtverců hodnot a odchylek v C02/X2_24, opačná znaménka
normálních kvantilů v C03/X3_28 a P–P graf označený jako Q–Q v D10.
Vizuální kontrola vyvrátila podezření na chybný počet hodnot v P02/sn. 43:
textová extrakce vynechala první hodnotu. Nezávisle přepočítány uvedené
součty čtverců a kvantily; 66 uložených výsledků normálních funkcí v D10
souhlasí s Python `statistics.NormalDist` do přibližně 3,4 × 10⁻¹⁶.
Shodují se také průměr a výběrová SD 96 uložených simulovaných hodnot.

Omezení: nebyly kompletně ověřeny všechny výpočty, důkazy, klíče úloh,
animace, vložené objekty, externí data, aplikace a původní empirické studie.
Bibliografické mezery a nepřítomná pokračování úryvků jsou výslovně označeny.
Sešit nebyl nově spuštěn v Excelu; kontrola uložených výsledků není kontrolou
živého přepočtu. Originály a pomocné extrakce/exporty se nezahrnují do Gitu.
Kontrola změny se týká dokumentace, úplnosti inventáře, lokátorů, místních
odkazů, kódování a rozdílů; nový render webu pro tuto změnu není potřebný.
Kontrola prošla: 28 souborů má 28 karet, všech 377 místních odkazů má
dostupný cíl nebo vlastní kotvu a 205 odkazů na stránky PDF leží v rozsahu
příslušného souboru. U odkazů s tištěným číslem stránky byla zkontrolována
také vazba na číslování PDF; u Priviterovy úvodní kapitoly, jejíž elektronický
štítek je odlišný, podle textu titulní strany kapitoly. Otisky všech původních
zdrojů zůstaly stejné. Tabulky, UTF-8 a `git diff --check` jsou bez chyb.

## 2026-10-11: doplnění prezentace probability.pptx do mapy

Na žádost autora přidána karta [P05](../docs/zdroje/P05-pravdepodobnost.md#p05), inventární
řádek a odkazy v tematickém rozcestníku. Mapa nyní zahrnuje 29 podkladů,
z toho pět starších přednáškových prezentací. Přečten text všech 36 snímků
včetně matematických objektů a dostupných poznámek podle skutečných vazeb
PPTX. Všechny snímky vyexportovány PowerPointem a prohlédnuty na čtyřech
kontaktních listech; snímek 34 také samostatně. Původní prezentace se neměnila.

Karta uvádí obsah, přesné rozsahy snímků, doporučené využití, metadata,
otisk souboru a konkrétní nálezy: chybný podíl zelených lentilek, chybějící
faktoriál v mezikroku kombinací, chybnou podmínku v Bayesově vzorci,
zaokrouhlení a procentní převod, nesprávnou směrodatnou odchylku podílu
a nesoulad zadání a dosazení normální aproximace. Vybrané počty a
pravděpodobnosti byly nezávisle přepočítány Pythonem; podrobnosti jsou
v kartě. Zpřesnění definic a terminologie jsou podmínkami budoucího použití,
nikoli schválením rozsahu či značení nové kapitoly.

Kontrola prošla: 29 souborů odpovídá 29 inventárním řádkům a kartám,
všechny jejich otisky souhlasí, 383 místních odkazů v mapě má dostupný cíl
nebo vlastní kotvu. Kotvy jsou jedinečné, UTF-8 a `git diff --check` bez
chyb. Originál a pomocné exporty jsou ignorované Gitem. Jde pouze o
autorskou dokumentaci; nový render webu nebyl potřebný ani provedený.
Nebyla provedena úplná odborná revize všech tvrzení, kontrola animací,
původu převzatých obrázků ani ověření excelových funkcí snímku 36.

## 2026-10-11: doplnění Russovy učebnice do mapy zdrojů

Na žádost autora přidán místní `sources/učebnice/russo.pdf` jako
[U11](../docs/zdroje/U11-russo.md#u11). Inventář nyní zahrnuje 30 souborů, z toho
11 učebnic. Doplněna mapa kapitol a příslušné odkazy v tematickém
rozcestníku; Howell zůstává hlavním východiskem a osnova se nemění.

Ověřeny titulní a nakladatelské strany, obsah, začátky kapitol a dostupný
rozsah souboru (331 stran PDF). Jde o druhé vydání Riccarda Russa,
Routledge, s rokem 2021 uvedeným v PDF. DOI ověřeno v Crossrefu, který
uvádí online publikaci 29. listopadu 2020; oba údaje karta rozlišuje.
Přečteny obě předmluvy a celá kapitola 3, s. 52–67 (PDF 73–88), včetně
obrázků a tabulky. Titulní údaje, obsah a tato kapitola byly také
vizuálně prohlédnuty v exportech Poppleru. U ostatních kapitol je
zaznamenána mapa obsahu, nikoli úplné prostudování.

Nezávisle přepočítány diagnostický strom, jeho Bayesův výsledek a příklad
dvou komunit přesnou racionální aritmetikou v Pythonu. Na s. 62 byla
v originálu potvrzena záměna nezávislosti výsledku testu a nezávislosti
správnosti klasifikace vzhledem ke zdravotnímu stavu. Karta vysvětluje
rozdíl a vymezuje další podmínky použití. Označuje také chybějící webové
kapitoly 13–14 a jednotlivé oddíly, které obsah uvádí, ale PDF neobsahuje.
Externí úlohy, data a sešity ani aktuální běh JASP nebyly ověřeny;
nejde o úplnou odbornou revizi knihy.

Kontrola prošla: 30 souborů odpovídá 30 kartám a inventárním řádkům,
všechny otisky souhlasí, 414 místních odkazů má dostupný cíl nebo vlastní
kotvu a všech 220 odkazů na stránky PDF leží v rozsahu příslušného
souboru. U U11 zkontrolována vazba tištěných stran na pořadí PDF.
Tabulky, jedinečnost kotev, UTF-8 a `git diff --check` jsou bez chyb.
Původní PDF zůstalo nezměněné a neveřejné. Pro tuto změnu autorské
dokumentace nebyl render studentského webu potřebný ani provedený.

## 2026-10-11: podrobná mapa obsahu učebnice

Na výslovnou žádost autora rozšířena [OSNOVA.md](../docs/OSNOVA.md)
na mapu skutečného obsahu všech čtyř kapitol. Přečten celý aktuální
výklad, zadání i řešení. Karty zachycují cíle a předpoklady, obsah
jednotlivých oddílů, pojmy, příklady, účel vizualizací, studentské soubory,
všech 42 závěrečných úloh (včetně dvou nepovinných) a hranice návazností.
Tematický rozcestník propojuje 16 témat napříč knihou. Rozlišeno vysvětlení,
samostatné procvičení, pouhá zmínka, nepovinné rozšíření a odložené učivo.

Plán pokračování k pravděpodobnosti je oddělen od existujících kapitol;
otevřené volby nejsou vydávány za schválený rozsah kapitoly 5. Původní
plán kapitoly 4 nahradila mapa jejího skutečného textu s odkazy na platná
rozhodnutí. Úplné definice a anglické ekvivalenty zůstávají ve slovníčku,
značení v přehledu a zdrojové karty v mapě zdrojů. V AGENTS.md doplněna
průběžná údržba mapy při obsahových změnách, kontrola odkazů a datum karty;
aktualizován rozcestník README a zaznamenáno rozhodnutí R17.

Z původní osnovy se zde zachovává historická poznámka: anglické označení
*weighted scores* je zaznamenáno v názvu článku
[*A critique of the Wechsler-Bellevue system of weighted scores* (1949)](https://pubmed.ncbi.nlm.nih.gov/18118257/).
Přesná cesta převzetí označení „vážený skór“ do češtiny nebyla ověřena;
není podklad pro tvrzení o německém nebo ruském původu. Jde o přesun
staršího záznamu, nikoli o novou bibliografickou či historickou rešerši.

Kontrola dokumentace prošla: 318 místních odkazů v mapě, instrukcích,
kořenovém README a rozhodnutích má dostupný soubor a případnou kotvu;
mapa odkazuje na všech 139 nadpisů s výslovným identifikátorem ve čtyřech
kapitolách. Zkontrolována úplnost seznamů 8 + 10 + 14 + 10 úloh,
struktura tabulek, jedinečnost sedmi kotev mapy, UTF-8 a `git diff --check`.
Studentské kapitoly, data a konfigurace se nemění. Render, nová vizuální
kontrola grafů, přepočty a běh Excelu nebyly pro tuto dokumentační změnu
potřebné ani provedené. Mapa sama nepotvrzuje odbornou bezchybnost kapitol
ani porozumění na studentech; zdroje nebyly znovu odborně revidovány.

<a id="zalozeni-autorskeho-slovniku"></a>

## 2026-10-11: autorský registr terminologie

Na výslovné zadání autora vznikl `docs/SLOVNIK.md` jako hlavní autorský
registr preferovaných českých názvů, anglických ekvivalentů, rozpoznávaných
alternativ a významových hranic. Obsahuje všech 160 současných hesel
studentského slovníčku ve čtyřech tematických tabulkách; každý řádek má
stabilní ID, doklad, odkaz na studentské heslo a první výklad.

Při založení je 56 hesel označeno S (konkrétní doložená volba nebo schválený
seznam názvů) a 104 K (převzetí v rámci staršího dohodnutého výkladu).
Rozlišení nepředstírá samostatné schválení každého názvu či každé alternativy.
Pozdější rozhodnutí mají přednost před historickým zněním; návrhy a nejasně
doložené budoucí volby mají oddělené místo. Terminologie kapitoly 5 se
tímto úkolem neschvaluje. U 91 hesel je doplněno konkrétní pravidlo použití,
zejména pro role proměnných, protiklady, širší pojmy, zkratky, meze intervalů,
kvartily, špičatost, standardizaci a normalizaci.

AGENTS.md stanoví čtení registru před prací, doložení nových voleb a společnou
údržbu všech dotčených materiálů. Rozcestníky a návaznosti doplněny do
kořenového README, osnovy, mapy zdrojů, rozhodnutí a pravidel prezentací;
schválené rozdělení odpovědnosti eviduje R18. Do dvanácti starších záznamů
přidány pouze stabilní kotvy, jejich historický obsah je zachován.

Ověřena úplnost a shoda 160 ID i preferovaných českých názvů proti
studentskému slovníčku, struktura tabulek, jedinečnost kotev, UTF-8 a cíle
všech nových či upravených místních odkazů v osmi dotčených dokumentech.
Porovnání vůči výchozímu commitu potvrdilo zachování historického textu
a nezměněné studentské zdroje, data, skripty i konfiguraci. Kontrola
`git diff --check` prošla.

Jde o dokumentační změnu. Render, numerické a excelové kontroly ani
vizuální kontrola webu nebyly potřebné a nebyly spuštěny. Neproběhla nová
terminologická rešerše ani úplný audit užití v každé kapitole či místních
prezentacích; registr shrnuje doložené konvence a existující vysvětlení.
Veřejné nasazení nebylo ověřováno.

## 2026-10-11 — Sjednocení terminologie kapitol 1–4

Na základě schváleného auditu sjednoceny názvy v kapitolách, cvičeních,
řešeních, studentském slovníčku a českých popiscích grafů podle
`docs/SLOVNIK.md`: chybějící údaj, výběr, pravděpodobnostní výběr,
kauzální závěr, úroveň měření, četnostní tabulka, souměrnost, variabilita,
krabicový graf, rozdělení zešikmené doprava a meze intervalů.

Zachovány výslovné alternativy při zavedení, prostý náhodný výběr, běžný
popis náhodného výběru jednoho případu, normativní soubor, anglické
reportování a obecné hranice. U výběrového rozptylu zůstávají předpoklady
nestrannosti v navazujícím výkladu. Nové znění hesel odlišuje širší pojem
rozdělení dat a obecný Q–Q graf; platný údaj nezaručuje správnost hodnoty.
Preference potvrzuje R19, registr nyní konkrétně dokládá i kauzální závěr.
Mapa obsahu zachycuje zpřesnění platného údaje a názvu zešikmení; rozsah
učiva se nemění. Technická ID hesel a souborů zůstala zachována.

Ověřena shoda všech 160 názvů a ID registru a studentského slovníčku,
odstranění nalezených odchylek a zachování významových výjimek.
Revize dotčených formulací zachovala odborný význam a návaznosti.
Proběhl render celé knihy a všechny čtyři R kontroly včetně číselných
příkladů a řešení. Aktuální snímky krabicového grafu a histogramu s Q–Q
grafem byly vizuálně prohlédnuty: nové české popisky jsou celé a čitelné.

První pokusy narazily na místní konfiguraci (Windows locale R, spouštěč
Quarta a přístup prohlížeče k localhostu); ověření bylo zopakováno
s UTF-8 locale, přímo přes quarto.exe a v instalovaném Chrome.
Excel nebyl znovu spuštěn: data, sešity, vzorce ani výsledky se neměnily.
Prezentace ani veřejné nasazení nebyly součástí této kontroly.

Kontrola `check-html.cjs` prošla: 9 stránek, 160 hesel, místní odkazy,
42 sbalených/rozbalovaných řešení včetně klávesnice, přehledové tabulky,
obsah kapitol, zobrazení bez JavaScriptu a mobilní šířka 390 px; bez chyb.
Kontrola `git diff --check` také prošla.

## 2026-10-11 — Jeden excelový sešit pro každou kapitolu

Na výslovnou žádost autora sjednoceny studentské podklady kapitol 1–4.
Nové pravidlo je v AGENTS.md a rozhodnutí R20; aktuální mapa souborů
v OSNOVA.md a audit příkladů a všech 42 cvičení v docs/DATA.md.
Vstupy se člení do samostatných listů, první list Prehled uvádí jejich
umístění a účel. Hotové výpočty zůstávají oddělené a označené.

- Kapitola 1 nově má sešit s maticí, přehledem proměnných a podklady
  opravy chybného přepisu. Chybění a platné nuly zůstávají rozlišeny.
- Kapitola 2 doplňuje menší příklady, schematické četnosti obrázků
  a vstupy cvičení; dosavadní výpočty a grafy zachovány.
- Kapitola 3 rozděluje další příklady do listů Kvantily, Orezani a
  Boxplot. Kontrola_prikladu je na ně navázána vzorci. Doplněny všechny
  datové úlohy včetně souhrnů a nepovinných příkladů.
- Kapitola 4 má samostatné vstupy k převodům a Q–Q grafu, úlohy a všech
  800 simulovaných skórů ze čtyř obrázků. Export používá existující
  generátor, jeho seed a pořadí tahů; simulace nejsou nově vymyšlenými daty.
- CSV zůstávají interními vstupy R a kontrol, ale nejsou odkázány ani
  kopírovány do webu. Čtyři kapitoly odkazují na XLSX a konkrétní buňky.

Ověření: redakční porovnání vstupů s příklady a zadáními, kontrola 1 421
uložených vstupních buněk (hodnoty, typy a chybění), existence odkazovaných
listů a oblastí. Vykreslené náhledy všech 74 listů vizuálně prohlédnuty;
u dlouhých datových sloupců byly vizuálně kontrolovány horní oblasti,
úplné hodnoty pokrývá automatická kontrola. Excel 16.0 otevřel, přepočetl
a uložil všechny čtyři sešity. Kapitolové kontroly ověřily české vzorce,
změny vstupů a vazby grafů; nově také změnu listu Kvantily a navazující
výpočet percentilu. Kontrola všech listů nenašla chyby ve 249 vzorcích.

Prošly číselné R kontroly všech čtyř kapitol, celý devítistránkový render,
HTML kontrola odkazů, 42 sbalených řešení, klávesnice, přehledových tabulek
(160 hesel), desktopu 1360/1920 a mobilu 390 px. Ověřena binární shoda
všech čtyř studentských sešitů s kopiemi v `_book/data/` a nepřítomnost CSV.
`git diff --check` bez chyb. R kontroly kapitol 3–4 byly spuštěny s explicitním
Windows locale `.UTF-8`; výchozí nastavení prostředí jinak odmítalo české
řetězce při načtení zdrojů. Excel a lokální Chrome vyžadovaly běh mimo
omezený sandbox. Veřejné nasazení ani porozumění na studentech tím nejsou
ověřeny; sloučení a publikování navazuje na autorovu kontrolu PR.

## 2026-10-11 — Akce GitHub Actions s podporou Node.js 24

Workflow `.github/workflows/book.yml` aktualizuje `actions/checkout` na v7,
`actions/setup-node` na v7, `actions/upload-pages-artifact` na v5 a
`actions/deploy-pages` na v5. Původní verze deklarovaly Node.js 20;
`upload-artifact@v4` byl nepřímou závislostí upload-pages-artifact@v3.
Ověřeny manifesty vydaných verzí na GitHubu včetně upload-artifact v7,
na který odkazuje upload-pages-artifact v5: JavaScriptové akce používají
`node24`. Nastavení `node-version: '22'` zůstává pro kontrolní skripty;
neřídí runtime samotných akcí. Oprava nepoužívá potlačení varování.

Lokálně zkontrolovány rozdíly a `git diff --check`. Render a kontroly
knihy ověří běh PR na GitHubu. Nahrání Pages artefaktu a nasazení jsou
podmíněny větví main a lze je ověřit až po autorově sloučení; tato změna
sama veřejné nasazení nepotvrzuje.


## Příprava kapitoly 5: čtení podkladů (2026-10-11)

Na žádost autora o projednání kapitoly o pravděpodobnosti byly porovnány
všechny soubory `sources/` s inventářem: 30 souborů, všechny prefixy SHA-256
odpovídají mapě. Rozšířené čtení obou relevantních prezentací, Howellovy
kapitoly 5 a vybraných dalších zdrojů je přesně zaznamenáno v kartách
U01, U04, U05, U08, U10, U11, P03, P05, C03 a D07–D09 v
[mapě zdrojů](../docs/ZDROJE.md). Karty oddělují textovou a vizuální kontrolu,
nezávislé výpočty i zbývající bibliografická a empirická omezení.

V této fázi není schválen podrobný rozsah kapitoly ani nové pojmy a symboly.
Studentské kapitoly, zdrojové prezentace a ostatní originály se neměnily.
Ověřeny číselné podíly dopingového příkladu, navržená změna prevalence
za zachování podmíněných pravděpodobností a příklad dvou šestek z pěti hodů
přesnou racionální aritmetikou v Pythonu. Excel nebyl spuštěn. Zkontrolován
diff a umístění doplnění u zdrojových karet; `git diff --check` bez chyb.
Změna autorské dokumentace nevyžaduje render knihy ani kontrolu webu.

<a id="dohoda-kapitola-05"></a>

## Kapitola 5: dohoda o obsahu (2026-10-11)

Autor požádal o projednání kapitoly o pravděpodobnosti s využitím svých
prezentací, především `probability.pptx`, a s doplněním chybějícího
z ostatních zdrojů. Návrh vycházel ze záznamů čtení v
[mapě zdrojů](../docs/ZDROJE.md) (karty U01, U04, U05, U08, U10, U11, P03,
P05, C03, D07–D09) a z nového čtení textu všech 36 snímků P05, snímků 22–44
P03, úloh X3_08–20 a X3_31 a Howellových s. 108–128 v textové extrakci.

**Schváleno** (doklady a plné znění v
[R21](../docs/rozhodnuti/kapitola-05.md#r21-rozsah-kapitoly-5),
[R22](../docs/rozhodnuti/kapitola-05.md#r22-znaceni-pravdepodobnosti) a
[R23](../docs/rozhodnuti/kapitola-05.md#r23-terminologie-kapitoly-5)):

- jedna kapitola ve dvou blocích, od pojetí pravděpodobnosti po normální
  aproximaci binomického rozdělení; chyby pravděpodobnostního úsudku povinně,
  šance, obecná střední hodnota a variace bez opakování nepovinně;
- úplná pravděpodobnost jako samostatný krok před Bayesovou větou a srovnání
  dvou prevalencí při stejné senzitivitě a specificitě; věrohodnost se nezavádí;
- zápis P(A), P(A ∩ B), P(A ∪ B), P(A | B), A′; stojaté π, n a k v binomickém modelu;
- padesát hesel [registru](../docs/SLOVNIK.md#kapitola-05) včetně významových hranic.

Autor návrh dvakrát vrátil. Nejprve opravil pět formulací: pojetí jako
různé interpretace se společnými pravidly, nikoli „téhož počtu“; výsledek
a elementární jev nejsou synonyma a „pole jevů“ není výběrový prostor;
vztah nulové pravděpodobnosti a nemožnosti vyložit na konečném modelu
a u podmínění uvádět kladnou pravděpodobnost podmínky; „kurz“ není šance
a kombinační číslo není kombinace; Howellův výpočet pro přesně devět
správných odpovědí je správný a volba „devět nebo více“ závisí na otázce.
Podruhé upravil terminologii: výběrový prostor jako hlavní termín, výsledek
náhodného pokusu, základní četnost odlišená od prevalence a apriorní
pravděpodobnosti, variace bez opakování, marginální pravděpodobnost bez
synonyma „nepodmíněná“ a jednotné „pojetí“.

**Rozpory podkladů, jejichž řešení je součástí schváleného návrhu:** chyby
v P05 uvedené v její kartě se nepřebírají; součtové a součinové pravidlo
se uvádí v obecném tvaru (Howell je formuluje jen pro výlučné, resp.
nezávislé jevy); nezávislost se nedefinuje Howellovým „nemá vliv“;
Russova záměna nezávislosti výsledku testu a jeho správnosti (s. 62)
se nepřebírá; diskrétnost není „malý počet hodnot“; náhodná proměnná není
sloupec dat; podmínka normální aproximace se uvádí jako orientační pravidlo
deseti očekávaných úspěchů i neúspěchů s poznámkou o mírnější variantě.

**Stav větve:** `codex/chapter-05` byla po sloučení PR #58 posunuta
rychlým převinutím na aktuální `origin/main`; neobsahovala žádné
neodeslané změny. Tento záznam, rozhodnutí, registr a plán v
[osnově](../docs/kapitoly/05-pravdepodobnost.md#mapa-kapitola-05) jsou dokumentační změny;
studentský text ani sešit jimi nevznikají a render není potřeba.

**Neověřeno v okamžiku dohody:** Howell od s. 128; Gravetter, Privitera
a Aron; bibliografická identita Baronovy knihy a DOI článku Uttsové;
původní studie Tverského a Kahnemana; funkce Excelu nebyly spuštěny.

<a id="vytvoreni-kapitoly-5"></a>

## Kapitola 5: vytvoření výkladu (2026-10-12)

Podle [dohody z 2026-10-11](#dohoda-kapitola-05) a rozhodnutí R21–R23 vznikla
kapitola `quarto/kapitola_05.qmd` (Pravděpodobnost) s dvanácti obrázky,
dvanácti cvičeními a třemi nepovinnými rozšířeními, sešit
`data/kapitola_05.xlsx`, padesát hesel slovníčku, dvacet řádků přehledu
značení a šest funkcí v přehledu Excelu. Plán v osnově byl nahrazen
[kartou skutečného obsahu](../docs/kapitoly/05-pravdepodobnost.md#mapa-kapitola-05).

### Odborná a didaktická rozhodnutí při psaní

- **Úvodní příklad** používá skutečnou četnost z dat kapitoly 2: odpověď
  „dost“ uvedlo 14 z 36 účastníků. První koncept pracoval s vymyšlenými
  9 z 36; didaktická revize rozpor s kapitolou 2 odhalila a kontrola
  `check-chapter-05.R` nyní čte hodnotu přímo z `data/kapitola_02.csv`.
- **Simulace pěti řad** (obrázek relativní četnosti) má seed 5, číslo
  kapitoly. Nejde o první zkoušený seed: při původním 20261011 skončily
  dvě z pěti řad po 1 000 tipech asi 2,5–3 směrodatné odchylky od 0,25
  (0,221 a 0,289), což by zkreslilo představu o obvyklém kolísání.
  Výklad uvádí rozsahy po 10, 50 a 1 000 tipech a výslovně neslibuje
  pravidelné přibližování. Čtyřicet simulovaných studentů má seed 20261012
  a nebylo vybíráno.
- **Bayesova věta** je složena ze tří dříve vyložených vztahů; úplná
  pravděpodobnost je samostatný oddíl. Srovnání prevalencí 10 % a 1 %
  používá pro obě skupinu 10 000 osob, aby vycházely celé počty.
- **Úprava hranice o 0,5** při normální aproximaci je vysvětlena
  návazností na zaokrouhlený skór z kapitoly 4, bez pojmenování; název
  *continuity correction* nebyl schválen. Stejně se nezavádí věrohodnost
  ani poměr šancí.
- **Dvojí význam písmen:** k je v kapitole 2 počet kategorií, zde počet
  úspěchů; n je počet pokusů. Výklad i přehled značení na to upozorňují.
  Znaky ≤ a ≥, dosud užité bez vysvětlení v tabulkách kapitoly 4, jsou
  vysvětleny a mají řádek v přehledu značení.
- **Jednotné sloveso** „tipovat“ místo střídání s „hádat“; listy sešitu
  si ponechávají identifikátory `Test_hadani` a `Sim_hadani`.
- **Bez slibů o dalších kapitolách:** text odkazuje na inferenční statistiku
  a testování hypotéz jako na oblasti, ne na konkrétní budoucí kapitoly,
  jejichž plán není schválen.
- Kapitola 4 dostala jediný dopředný odkaz na kapitolu 5 (věta o pravidlech
  počítání s pravděpodobnostmi); její význam se nezměnil.

### Zdroje a citace

Rozsah čtení a použití je v kartách U01, U04, U10, U11, P05, C03 a D07–D09
[mapy zdrojů](../docs/ZDROJE.md). V obraze byly při psaní prohlédnuty
Baronovy s. 121–123 a 149–152 a s. 77–78 článku Uttsové; jedna věta
o „literatuře o usuzování“ byla po této kontrole přeformulována, protože
ji citované strany nepodporovaly. Do `references.bib` přibylo jedenáct
záznamů: Sahu, Russo, Diez et al., Baron, Utts a šest stránek české
dokumentace Microsoftu (stav 2026-10-11). DOI Uttsové, Sahua a identita
Baronovy knihy byly ověřeny v metadatech Crossref, rok 2008 Baronova
čtvrtého vydání v záznamu Kongresové knihovny.

### Sešit a Excel

Generátory sešitů kapitol 1–4 vyžadují modul `@oai/artifact-tool`, který
v tomto prostředí nebyl dostupný. Sešit kapitoly 5 proto sestavuje
`scripts/kapitola_05-sešit.mjs` spolu s `scripts/kapitola_05-sesit-excel.ps1`
přímo v desktopovém Excelu (16.0, české rozhraní); deklarace vstupů
zůstávají v `scripts/sesity-data.mjs`. Při tvorbě se projevily a byly
ošetřeny dvě vlastnosti automatizace: jedno místo skriptu nesmí přiřazovat
buňce střídavě text a číslo a vlastnost `NumberFormat` se v PowerShellu
čte s místními oddělovači. Sešit má 22 listů a 74 vzorců, neobsahuje grafy
a ve vlastnostech dokumentu nemá jméno autora.

### Ověření

- `check-chapter-05.R`: všechna čísla výkladu, tabulek, nepovinných
  rozšíření a řešení dvanácti cvičení, obě simulace a dvanáct obrázků;
  binomické hodnoty navíc přímým vzorcem nezávisle na `dbinom`. Kontrola
  odhalila, že 0,0625 a 0,4375 jsou přesné poloviny: text zaokrouhluje
  nahoru jako Excel (0,063 a 0,438).
- `check-chapter-05-excel.ps1` ve skutečném Excelu: 74 uložených výsledků,
  28 českých vzorců z textu a řešení, 5 chybových případů a 23 výsledků
  po změně vstupů; očekávané hodnoty z přesné racionální aritmetiky
  v Pythonu. Funkce FAKTORIÁL, KOMBINACE, PERMUTACE, BINOM.DIST,
  BINOM.DIST.RANGE a BINOM.INV byly tedy spuštěny, nejen ověřeny dokumentací.
- `check-workbooks.py`: 1 583 vstupních buněk pěti sešitů, odkazy na listy
  a oblasti v textu a shoda sešitu s kopií ve webu.
- Render celé knihy (10 stránek) a `check-html.cjs`: odkazy, 210 hesel,
  54 sbalených řešení, klávesnice, tři sbalená nepovinná rozšíření,
  stojaté π, μ a σ, velké P, vyhledávání nových řádků přehledů, mobil 390 px.
- R kontroly kapitol 2–4 po změně společných souborů prošly.
- Vizuálně prohlédnuto: všech dvanáct obrázků, snímky úvodu, Bayesovy věty,
  binomického vzorce a aproximace na desktopu, Bayesova věta na mobilu
  a PDF exporty listů `Prehled`, `Binom` a `Screening`.

**Nalezeno a opraveno kontrolou webu:** kapitola na mobilu vodorovně
přetékala. Dlouhé rovnice jsou rozděleny do řádků, dlouhé řádkové vzorce
v řešeních rozděleny, všechny tabulky mají posuvný obal a excelové tabulky
minimální šířku. Do společných stylů přibylo pravidlo, podle kterého se
odstavec s příliš širokou rovnicí posouvá sám a nerozšiřuje stránku; platí
pro všechny kapitoly a kapitoly 2–4 byly po změně zkontrolovány i na šířce
360 px. Zlomky ve víceřádkových rovnicích mají výslovně velikost
samostatné rovnice.

### Omezení a neověřené části

- Excelové kontroly sešitů kapitol 1–4 (`check-workbooks-excel.ps1`
  a kapitolové skripty) nebyly znovu spuštěny; tyto sešity se neměnily.
- Howellův text od s. 128 (binomický test) a cvičení jeho kapitoly 5
  nebyly čteny; s. 119 a 128 jen v textové extrakci. Diezovy s. 95–96
  nebyly prohlédnuty v obraze. Původní studie Tverského a Kahnemana
  a Eddyho jsou zmíněny jen prostřednictvím Barona, Uttsové a Howella.
- Copyrightová strana Baronovy knihy nebyla k dispozici; rok 2008 se opírá
  o katalogový záznam, metadata vydavatele uvádějí 2006.
- Sešit kapitoly 5 lze obnovit jen na Windows s českým Excelem.
- Interní didaktická revize není ověřením porozumění na studentech.
  Veřejné nasazení webu navazuje na autorovo sloučení pull requestu.

## 2026-10-12 — Generátory všech sešitů v desktopovém Excelu

Na výslovný pokyn autora (rozhodnutí R24) byla tvorba sešitů kapitol 1–5
sjednocena na místní skripty ovládající desktopový Excel. Historické
záznamy výše popisují tehdejší použití `@oai/artifact-tool`; nejsou již
platným postupem obnovy. Aktuální příkazy a závislosti jsou v kořenovém
README, závazná pravidla v AGENTS.md.

Kapitolové generátory a společné vstupy zachovávají původní texty, data,
adresy, vzorce a oddělení vstupů od hotových výpočtů. Místní modul
`excel-workbook.mjs` vytváří pouze seznam operací v JSON; jejich provedení,
grafy, výpočet a XLSX zajišťuje `build-workbook-excel.ps1` prostřednictvím
COM. Samostatný generátor Excelu pro kapitolu 5 byl nahrazen společným.
Nevyžaduje se balíček npm ani neveřejný runtime. Společný spouštěč
`build-workbooks.ps1 -Verify` obnovuje i simulované vstupy a volá kontroly.

Výsledek vzniká nejprve v `tmp/` a po přepočtu a kontrole chyb se kopíruje
na původní cestu `data/kapitola_NN.xlsx`. Každý běh používá vlastní skrytou
instanci Excelu. Při záměrně vyvolané chybě neznámou operací skript skončil
neúspěchem a hash dosavadního sešitu zůstal totožný.

### Ověření převodu

- Proti kopiím před migrací prošlo porovnání všech **3 342 vyplněných
  buněk v 96 listech**: texty, čísla, typy, vzorce a jejich uložené výsledky,
  pořadí listů, sloučené buňky, ukotvení, ověření vstupů, číselné formáty
  i datové vazby, formáty a pevné meze os všech tří nativních grafů.
  Numerické porovnání používá toleranci 1e-12, texty a typy přesnou shodu.
- V Excelu 16.0 byly skutečně spuštěny všechny kapitolové excelové
  kontroly 2–5 i společná kontrola všech listů: **323 vzorců bez chyb**.
  Kontroly ověřily české funkce, mezní argumenty, změny vstupů, přepočet
  výsledků a grafů. Kapitola 5 navíc ověřila 74 uložených výsledků,
  28 českých vzorců, 5 očekávaných chyb argumentů a 23 změněných výsledků.
- Stejné kontroly prošly při spuštění společného příkazu z README,
  tedy po novém úplném sestavení všech pěti sešitů běžným Node.js 24.21.0
  a Windows PowerShellem 5.1. Nebyl použit původní balíček.
- Prošly nezávislé R kontroly kapitol 1–5. Pro R 4.5.1 bylo v této relaci
  nutné nahradit zděděné unixové locale `C.UTF-8` windowsovým UTF-8 locale;
  vstupní soubory ani výpočty se kvůli tomu neměnily.
- Prohlédnuty nativní PDF náhledy všech 96 listů. U dlouhých samostatných
  vstupů ukazují prvních 15 řádků; všechny hodnoty kontrolují skripty.
  Výpočtové listy a grafy byly prohlédnuty celé. Náhledy jsou pouze
  pomocné výstupy v `tmp/`, tisková nastavení se do XLSX neukládala.
- Kontrola zachytila převod textového listu „2“ na číslo a lokální formát
  osy Q–Q grafu. Oba problémy byly opraveny v generátoru a následné
  porovnání prošlo. Skript kontroly kapitoly 4 dostal UTF-8 BOM, aby české
  literály správně četl Windows PowerShell 5.1.
- Prošel plný render deseti stránek a HTML kontrola: 210 hesel,
  54 sbalených řešení, odkazy, klávesnice, režim bez JavaScriptu,
  `file://`, šířky 1360/1920 px a mobilní zobrazení 390 px, bez chyb.
- Po posledním sestavení prošla kontrola 1 583 uložených vstupních buněk,
  datových typů, chybění a odkazů z kapitol. Nový render zahrnul totožné
  kopie všech pěti sešitů do `_book/data/`; tuto shodu potvrdila kontrola.
  Prošel také `git diff --check`.

Obsah výkladových kapitol a datové pokrytí se neměnily; rozsah učiva
ani terminologie nebyly znovu otevírány. Ověření se týká místního
českého Excelu ve Windows; jiné kancelářské aplikace a cloudová prostředí
nebyly testovány. Veřejné nasazení bude následovat až po autorově sloučení
PR a úspěšném publikačním workflow.


<a id="revize-kapitoly-5-2026-10-12"></a>

## 2026-10-12 — Zapracování odborné, didaktické a technické revize kapitoly 5

Na výslovný pokyn autora zapracováno všech 12 nálezů a 3 didaktická
doporučení z předchozí revize; rozsah kapitoly a schválené značky zůstaly
zachovány. Dohodu zachycuje R25. Součástí společného commitu je autorem
přidané ignorování složky `prompts/`; její obsah se neodesílá.

### Obsah a didaktika

- Stejná senzitivita a specificita při různých prevalencích jsou výslovným
  předpokladem; doplněna opora Mulherin a Miller (2002), v rozsahu veřejného
  abstraktu. Falešná pozitivita/negativita mají vymezenou příslušnou skupinu.
- Opraveny příklady nezávislosti, podmíněné versus nepodmíněné pravděpodobnosti
  při losování, výklad P(B) > 0 a předpoklad stejné pravděpodobnosti nehody
  taxíků. U dalšího vyšetření se připomíná překrytí informací.
- Definice náhodného pokusu a rozdělení nepředpokládají vyjmenovatelnost
  výsledků; experimentální manipulace není vyloučena. Modelové situace
  v úlohách 5 a 8 se nevydávají za skutečné výzkumy. Použití p připomíná
  i úroveň kvantilu.
- Kategorie „bez vysokého stresu“ nahrazuje nepřesnou „pohodu“ v kapitole,
  alternativních textech, třech schématech, generátoru dat i sešitu.
  Úprava nezavádí nový odborný termín. Prezentace nebyly součástí revize;
  původní soukromé zdroje zůstaly beze změny.
- Přesnost aproximace je vyjádřena i relativně (přibližně 12 %); řešení
  úlohy 11 odlišuje vliv hranice a rozdílu tvarů rozdělení.
- Opraveno skloňování křížových odkazů s automatickým číslem; ID zachována.
  Souběžně upraven slovníček, registr, mapa obsahu, data, zdroje a přehled Excelu.

Interní didaktická revize dotčených míst posoudila vysvětlení podmínek,
celku v pravděpodobnostních otázkách, návaznost zadání a řešení a hranice
povinného učiva. KDYŽ je u nového použití vysvětleno přímo, takže není
nutná znalost nepovinné excelové části kapitoly 3. Nejde o ověření
porozumění na studentech.

### Sešit a reprodukovatelnost

`Binom` má pevné n = 5 a jedinou odemčenou buňku B3. `Binom_20` má pevné
n = 20, vstupy B3:B5 a popisky A7:A9/A19 propojené s hranicemi. Ochrana
listů bez hesla brání přepsání vzorců a pevného rozsahu tabulky.
Generátor dostal volitelnou deklaraci odemčených oblastí a desetinné
ověření vstupu; existující celočíselná pravidla zachovávají výchozí chování.

Rozšířený test odhalil v místním Excelu 16.0 chyby BINOM.DIST pro k = 0,
π = 1 a BINOM.INV pro krajní π = 0/1. P(X = 0) proto počítá přímo
(1 − π)^n; na `Binom_20` ošetřuje krajní bodový dotaz a inverzi KDYŽ.
České vzorce a význam větví odpovídají textu. Nejde o změnu matematického
modelu ani jeho výchozích výsledků.

### Provedené kontroly a omezení

- R kontrola kapitoly prošla pro všechny příklady, nepovinné části,
  dvanáct řešení a 12 generovaných obrázků, včetně nového relativního rozdílu.
- Nezávislé očekávané hodnoty z Pythonu používají racionální binomické
  součty a erfc. Nativní Excel ověřil 74 uložených výsledků, 28 českých
  vzorců, 5 očekávaných chyb, 50 výsledků po změně vstupů, čtyři změněné
  popisky a ochranu dvou listů včetně odmítnutí zápisu do pevného n.
  Testy mění také π = 0/1 a krajní povolené hodnoty počtu úspěchů.
- Samostatná společná kontrola přepočítala všech pět sešitů: 327 vzorců
  v 96 listech bez chyb. Ostatní čtyři sešity nebyly znovu sestavovány.
- Porovnání kapitoly 5 před/po obnově potvrdilo stejné pořadí 22 listů,
  sloučené oblasti a všech 224 číselných buněk v toleranci 1e-12.
  Dvacet obsahových změn tvoří pouze schválené popisky, poznámky a vzorce;
  přidána ochrana a ověření podporovaných vstupů. Kontrola všech 1 583
  studentských vstupních buněk kapitol 1–5 prošla včetně datových typů,
  chybění, odkazovaných adres a shody s kopiemi sešitů na webu.
- Vizuálně zkontrolovány nativní náhledy změněných listů Binom, Binom_20,
  Tabulka_zavislost, Screening, U06_screening a U07_taxi; doplněné texty
  jsou čitelné. Náhledy jsou pouze dočasné, tisková nastavení se neukládají.
- Prošel plný render deseti stránek a HTML kontrola: 210 hesel, 54 řešení
  (v kapitole 5 všech 12), odkazy, klávesnice, zobrazení bez JavaScriptu,
  navigace přes file://, šířky 1360/1920 px a mobilní šířka 390 px.
  Upravené tři grafy, tabulka stresu a oddíl binomického Excelu byly
  znovu vizuálně prohlédnuty bez překryvů či ořezaných popisků.
  Nový bibliografický záznam a gramatika odkazů byly zkontrolovány
  ve výsledném HTML. Po doplnění odkazu u KDYŽ se přehled Excelu
  vykreslil znovu. Cílená kontrola oddílů o prevalenci, binomickém Excelu
  a kumulaci i nového odkazu KDYŽ prošla při 1360 a 390 px bez přetékání.
  Prošel také závěrečný git diff --check.

Ověřování probíhá místně v českém desktopovém Excelu a Chromu ve Windows;
cloudové kanceláře, jiné prohlížeče, fyzický telefon a veřejné nasazení
nejsou tímto ověřeny. U zdrojů zůstávají omezení původní revize popsaná
v ZDROJE.md, včetně neověřených původních experimentů a copyrightové
strany Baronova vydání. Uživatel provede sloučení PR.

## Kapitola 1: sedm schémat, srovnávací tabulka a přiřazení (2026-10-12)

Na výslovný pokyn autora byly doplněny všechny projednané návrhy: dvě
alternativní příčinná vysvětlení, konstrukt → operacionalizace → záznam,
změny zápisu u čtyř úrovní měření, diskrétnost versus zaokrouhlení,
výběrová variabilita versus neúčast, účastník/návštěva/řádek a schéma
populace → výběr s usuzováním v opačném směru. V posledním schématu
sampling označuje proces, sample výsledek; popisná statistika shrnuje
získaná data a inference z výběru na populaci vyžaduje předpoklady.
Jde o vlastní schematické ilustrace navazující na výklad; uživatelem
poskytnuté obrázky sloužily jako koncepční reference, nebyly kopírovány.
Všech osm SVG včetně původního schématu obnovuje scripts/kapitola_01.R.

Tabulka úrovní měření a možných hodnot obsahuje příklady a podstatné
výjimky: spojitá poloha odpovědi nedokazuje spojitost psychologického
rysu ani intervalové měření; u nominálních kategorií spojitost neuvažujeme.
Schéma operacionalizace nahrazuje původní tabulku, aby se výklad
zbytečně neopakoval. Každý obrázek má stabilní ID, alternativní text,
křížový odkaz a vysvětlení. Nové diagramy a srovnávací tabulka se na
mobilu posouvají místně a lze je ovládat klávesnicí.

Random assignment používá preferovaný překlad „náhodné přiřazení
k podmínkám“ podle R26. Sjednocena kapitola 1 včetně úloh, řešení,
popisků a generátoru, jeden výskyt v kapitole 5, studentský slovníček,
autorský registr, osnova a příklad v AGENTS.md. ID hesla i obrázku
zůstala stabilní; předchozí překlad je pouze mezi alternativami a
v zachované historii. R10 je označeno jako částečně nahrazené.
Obecné přidělení kódu nebo bodů není terminologickým výskytem assignment.

Místně byla sjednocena také aktuální presentations/kapitola_01_od_otazky_k_datum.pptx
(snímky 8, 10, 25 a relevantní poznámky), odpovídající PDF export a
kapitola_01_poznamky.docx. Výskyt na snímcích i v poznámkách byl přečten
před úpravou; změny zachovávají formátování a ostatní obsah. Snímky
8, 10 a 25 byly vykresleny v PowerPointu a vizuálně prohlédnuty.
Aktuální prezentace a poznámky kapitoly 2 neobsahovaly měněný termín;
číselné sešity ani jejich generátory nevyžadovaly změnu. Soubory s „kopie“
v názvu jsou historické zálohy, nebyly aktualizovány. Prezentace a exporty
jsou dle .gitignore místní, nejsou součástí commitu ani PR.

Omezení místních poznámek: všechny XML části DOCX i PPTX byly úspěšně
načteny a balíčky zachovaly původní seznam souborů. Vizuální kontrola
DOCX nebyla dokončena: balený render_docx.py nemá k dispozici LibreOffice;
Word se při otevírání původní kontrolní kopie pro PDF export zasekl.
Vlastní exportovací proces byl ukončen. Sazba upraveného DOCX proto není
ověřena, ačkoli terminologická úprava v něm je uložená.

Odborná a didaktická kontrola dotčeného textu: šipky jsou vysvětleny
podle účelu (hypotéza, postup měření, inference); schémata neprokazují
empirické účinky ani nezavádějí kauzální formalismus či rozdělení odhadů.
Srovnávací tabulka odlišuje vlastnost, odpověď a záznam. Rozsah úloh
1–8 a jejich řešení zůstává zachován; nové početní učivo se nezavádí.
Sešit nepřidává nová individuální data: obrázky jsou pojmová schémata
nebo převody jednotek, nikoli nové datové úlohy. Pokrytí shrnuje DATA.md.
Nejde o testování porozumění na studentech.

Ověření: plný Quarto render deseti stránek; R kontrola kapitoly 1 včetně
matice, chybění, řešení úlohy 8, převodů °C/°F, hodin/minut, ordinálního
překódování, zaokrouhlení a opakovaných návštěv. Převody a zaokrouhlení
byly nezávisle přepočteny v Pythonu. Kontrola všech sešitů prošla pro
1 583 vstupních buněk včetně typů, chybění a totožnosti kopií na webu.
Desktopový Excel nebyl znovu spouštěn, protože sešity ani vzorce se neměnily.
Všechny osm obrázků byly vizuálně prohlédnuty; webová kontrola prošla
pro 10 stránek, 210 hesel a 54 řešení, odkazy, klávesnici, JavaScript
vypnutý/zapnutý, file://, šířky 1360/1920 px a mobilní šířku 390 px.
Sedm nových diagramů má ověřené lokální posouvání a načtené obrázky
s alternativním textem. Po vizuální kontrole byla nová tabulka rozšířena
na čitelnou minimální šířku s místním posouváním. Fyzický telefon,
jiné prohlížeče a veřejné nasazení se tímto neověřují.
Po doplnění názvu tabulky a rozlišení sampling/sample do existujícího
hesla slovníčku byl znovu vykreslen celý web. Cílená kontrola konečné
verze při 1360 a 390 px ověřila osm načtených obrázků, popisek tabulky,
její posouvání klávesnicí, nepřetékání stránky a přímý odkaz na upravené
heslo. Konečná tabulka byla vizuálně prohlédnuta. Git diff --check prošel.

## Pedagogické příklady souvislosti — 2026-10-12

Podle [R27](../docs/rozhodnuti/kapitola-01.md#r27-souvislost-pedagogicka) je v kapitole 1
nové sbalené nepovinné rozšíření `souvislost-pedagogicka`. Tři mechanismy
se týkají motivace a úspěšnosti, čtvrtý výslovně mění dvojici na inteligenci
a motivaci. Text rozlišuje časovou posloupnost obou směrů, společnou příčinu
a výběr podle společného následku; šipky nejsou důkazem účinku a záporný
směr vyvolané souvislosti není obecné pravidlo. Doplněn schválený termín
do registru a slovníčku, šipka do značení, mapa obsahu a data. Nové funkce
Excelu ani povinné výpočty se nezavádějí; osm cvičení a jejich řešení se nemění.

Vlastní simulace `scripts/kapitola_01-simulace.R` se seedem 20261012
sdílí grafy a sešit. První má 300 případů, po 100 v každé skupině podpory;
druhý 600 případů. Jedničkáře vymezuje součet dvou nezávislých standardních
normálních veličin a dalšího normálního vlivu se SD 0,6 nad hranicí 1,5.
Skóry pro zobrazení jsou převedeny a zaokrouhleny na dvě desetinná místa.
Jde o vlastní modelové údaje, nikoli empirické závěry o psychologii.

R kontrola ověřila celkovou souvislost prvního grafu 0,8273 a vnitroskupinové
hodnoty 0,1007, −0,1167 a 0,1580; druhý graf −0,0641 pro všechny a −0,5470
pro jedničkáře. Ověřena opakovatelnost a překryv skupin vzhledem k oběma
příčinám. Nezávislý výpočet v Pythonu potvrdil směry a velikosti souvislostí.
Koeficienty jsou pouze autorská kontrola, studentský text je nevyžaduje.
Prošla také původní R kontrola kapitoly, čísel a řešení.

Sešit byl sestaven a přepočten ve skryté instanci Excelu 16.0; má devět
listů, bez vzorců. `Podpora_ucitele` a `Jednickari` přidávají 2 700 buněk.
Kontrola všech sešitů potvrdila 4 283 vstupních buněk, typy, chybění a
totožnost publikovaných kopií. Porovnání proti předchozímu sešitu ověřilo
původní hodnoty, datové typy, číselné formáty, sloučené buňky, ukotvení,
validace a počty grafů; v přehledu pouze přibyly dva řádky. Prohlédnuty
náhledy nových listů a přehledu exportované skutečným Excelem. Kontrola
chyb vzorců ostatních čtyř sešitů byla jen pro čtení, bez ukládání.

Celá kniha byla vykreslena. Kontrola webu prošla pro deset stránek,
211 hesel a 54 řešení, odkazy, klávesnici, JavaScript zapnutý/vypnutý,
file:// a šířky 1360/1920/390 px. Nové rozšíření je výchozím stavem sbalené
a otevřitelné klávesnicí; grafy mají alternativní text a lokální posouvání.
Oba byly vizuálně prohlédnuty na desktopu i na mobilní šířce včetně pravé
části posunutého grafu. Bibliografie obsahuje 14 autorů, 11(1), Article 5749
a ověřený DOI; citace generuje Quarto. Git diff --check prošel.

Didaktická revize ověřila vysvětlení bodu a os před interpretací, změnu
dvojice proměnných, rozdíl mezi modelem a daty, možnost současného působení
a meze kauzálního závěru. Nejde o ověření porozumění na studentech.
Původní obrazové odkazy nebyly dostupné pro vizuální srovnání; rozsah čtení
článku a omezení zaznamenává [mapa zdrojů](../docs/ZDROJE.md).
Fyzický telefon, další prohlížeče ani veřejné nasazení se neověřovaly.


## Aktualizace mapy zdrojů — 2026-10-12

Na žádost autora doplněny karty U12 (celý Baron), P06/P07 (výběrová
rozdělení a statistické usuzování), C05 (úlohy týdne 4) a D11 (Wainer).
Inventář nyní pokrývá 33 místních souborů. Odstraněné Baronovy výřezy
se nepočítají jako dostupné soubory; ID D08/D09 a historické záznamy
zůstaly, aktuální odkazy vedou na tištěné strany celé knihy (PDF = s. + 16).
Titul, čtvrté vydání a copyright 2008 ověřeny přímo v PDF; současný údaj
o prvním tisku 2007 je zaznamenán jako bibliografická odlišnost.

Obě nové prezentace byly přečteny včetně poznámek a všech 87 snímků
prohlédnuto z exportů PowerPointu. Wainerův článek byl přečten včetně
obrazů stran. U Barona zmapován obsah celé knihy a ověřeny lokátory,
nikoli celý výklad. U C05 přečtena zadání i klíč z OOXML a prohlédnuty
čtyři PNG; jedna EMF a celé vykreslení zůstávají neověřeny. Export ve
Wordu se zablokoval, vlastní skrytá instance byla ukončena bez uložení
zdroje. R nezávisle ověřilo vybrané hodnoty P06/P07 a C05; přesný rozsah,
nálezy a neprovedené kontroly uvádějí příslušné karty mapy. Excel,
bootstrapové simulace a externí výukové aplikace nebyly spuštěny.

Zkontrolovány místní odkazy, jedinečnost ID, pokrytí inventáře, otisky
a git diff --check. Změna se týká autorské dokumentace, proto nebyl
nutný nový render knihy. Studentský obsah, schválená osnova, terminologie,
bibliografie a originály v sources/ se neměnily; nové zdroje nejsou
schválením rozsahu další kapitoly. Pomocné extrakce a náhledy jsou pouze
v ignorovaném tmp/.

## Příprava kapitoly 6: čtení podkladů (2026-10-12)

Na žádost autora o projednání kapitoly o výběrovém rozdělení a principu
testování hypotéz byl obsah `sources/` porovnán s inventářem: 33 souborů,
žádný nový ani chybějící. U dvanácti relevantních souborů (U01–U06, U08,
U11, P06, P07, C05, D11) odpovídá prefix SHA-256 mapě. Rozsah čtení a nálezy
jsou v kartách U01, U03, U04, U05, U08, U11, P06, P07 a C05
v [mapě zdrojů](../docs/ZDROJE.md).

- **Čteno v textové extrakci:** Howell, kap. 4 (s. 83–106), s. 128–132
  s §5.9 a s. 177–183 s §7.1–7.2; všech 25 snímků P06 s poznámkami; P07
  sn. 1–37 s poznámkami; zadání C5_01–11, X5_01–12 a X5_100 z C05; Dostál
  s. 92–101; Cumming s. 83–94; Navarro §11.1–11.2 a začátek §11.3; Russo
  s. 107–111; OpenIntro s. 170–172.
- **V obraze:** jen Howell s. 95–96 (obr. 4.2 a 4.3).
- **Nezávisle přepočteno v Pythonu** (standardní knihovna): směrodatná chyba
  rozdílu, kritické hodnoty a β u Howella; binomické chvosty u Howella
  a Russa; příklad devíti výběrů (střední hodnota 35, rozptyl 75); síla
  pro rozdíly 3, 5 a 8 s jednostranně i oboustranně; čísla navržených
  řešených příkladů a cvičení.
- **Nečteno:** Gravetter, Aron, Privitera, Judd a Sahu v relevantních
  kapitolách; Cumming kap. 6; Navarro kap. 10 a §11.4–11.9; Howell kap. 8.
  Wainer a Utts nebyli čteni nově. Původní studie Rubacka a Juienga (1997)
  není v `sources/`.
- **Nespuštěno:** R ani Excel. Obrázky prezentací nebyly nově prohlíženy.

<a id="dohoda-kapitola-06"></a>

## Kapitola 6: dohoda o obsahu (2026-10-12)

Autor navrhl, aby se kapitola 6 věnovala výběrovému rozdělení a principu
testování hypotéz, a požádal o podrobný plán obsahu včetně rozhodnutí
o zařazení a vynechání.

**Průběh.** Autor nejprve zodpověděl sedm otázek: jedna kapitola ve dvou
blocích; parkovací studie jako páteř výkladu; studenti počítají binomický
test i z-test; termín směrodatná chyba; intervaly spolehlivosti odložit;
všechna čtyři nabídnutá nepovinná rozšíření; po schválení jen zapsat dohodu
a výklad psát zvlášť. Předložený návrh potom čtyřikrát vrátil:

1. **Pojetí výkladu.** Původních 23 položek spojit do 10–12 větších oddílů,
   z nichž každý rozvíjí jednu otázku od příkladu přes vysvětlení
   k interpretaci. Začít problémem kolísání výsledků, pokračovat binomickým
   příkladem z kapitoly 5 a přesným příkladem devíti výběrů před simulací.
   Oddělovat studii, výukový model a simulovaná data. Povinně krátce odhad
   s/√n a zákon velkých čísel. Hypotézy a směr před první p-hodnotou. Síla
   pro konkrétní alternativy. Standardizovaný rozdíl do nepovinného bloku.
   Opravit tři příliš obecná tvrzení návrhu: že přesná nulová hypotéza
   sotva platí, že z-skór z kapitoly 4 je test s n = 1, a výpočet
   chybovosti více testů bez podmínek.
2. **Terminologie.** Výběrové rozdělení statistiky při zavedení; rozlišení
   výběrové variability, výběrové chyby a směrodatné chyby; statistická
   síla; kritický obor s alternativou oblast zamítnutí; velikost účinku;
   formulace zamítáme a nezamítáme.
3. **Dva kroky závěru.** Rozhodnutí testu oddělit od věcné interpretace
   vzhledem k výzkumné hypotéze.
4. **Významnosti.** Věcnou a praktickou významnost rozlišovat jako dva
   pojmy; návrh původně vedl „věcná“ jen jako alternativu „praktické“.

Po zapracování autor návrh schválil.

**Schváleno** (plné znění a doklady v
[R28](../docs/rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6),
[R29](../docs/rozhodnuti/kapitola-06.md#r29-znaceni-kapitoly-6) a
[R30](../docs/rozhodnuti/kapitola-06.md#r30-terminologie-kapitoly-6)):

- dvanáct oddílů ve dvou blocích, tři vrstvy průběžného příkladu, pět
  nepovinných rozšíření a návrh čtrnácti cvičení podle
  [plánu v osnově](../docs/kapitoly/plan-pokracovani.md#plan-dalsi-kapitoly);
- zásady výkladu včetně dvou kroků závěru u každého řešeného příkladu;
- značení H₀, H₁, μ₀, směrodatná chyba jako σ s indexem m a její odhad
  jako s s indexem m, p-hodnota vypisovaná slovy;
- 29 hesel [registru](../docs/SLOVNIK.md#kapitola-06).

**Rozpory podkladů, jejichž řešení je součástí dohody:** σ/√n a centrální
limitní věta se zařazují už do kapitoly 6, kdežto Howell je má až
v kapitole 7. Hlavní test parkovacího příkladu je oboustranný se stejnou
hranicí ve všech panelech síly; přednáška používá jednostrannou hranici.
Pravděpodobnosti se uvádějí jako výsledky výukového modelu, ne jako počty
extrémních případů z 10 000 simulací (Howell, s. 88, a poznámky P06).
Nepřebírají se nesouhlasné kritické hodnoty a β z Howellových s. 94–96,
chyby P06 uvedené v její kartě ani formulace „přijímáme alternativní
hypotézu“.

**Změněné soubory:** `docs/ZDROJE.md`, `docs/ROZHODNUTI.md`,
`docs/SLOVNIK.md`, `docs/OSNOVA.md` a tento záznam. V osnově a mapě zdrojů
bylo pracovní označení „standardní chyba“ nahrazeno schváleným termínem;
R21 zůstává jako historický záznam beze změny. Studentské kapitoly,
slovníček, přehled značení, přehled Excelu, sešity, bibliografie
a `sources/` se neměnily. Kapitola 6 zatím neexistuje.

**Stav větve:** `codex/chapter-06` vytvořena z `origin/main` po sloučení
PR #64; pracovní strom byl čistý.

**Kontroly:** `git diff --check` bez nálezu; skriptem ověřeny místní odkazy
a kotvy pěti upravených dokumentů a jedinečnost ID; zkontrolován rozdíl
proti `main`. Jde o dokumentační změnu, render knihy nebyl potřeba.

**Neověřeno v okamžiku dohody:** uspořádání a bibliografický záznam studie
Rubacka a Juienga (1997); Russova tabulka 5.2 v obraze; podklady vedené
jen jako mapa obsahu; přesné strany tvrzení u Navarra. Čísla v plánu jsou
výsledky normálního a binomického modelu přepočtené v Pythonu; R ani Excel
nebyly spuštěny a simulace zatím neexistují.

<a id="vytvoreni-kapitoly-6"></a>

## Kapitola 6: vytvoření výkladu (2026-10-12)

Podle [dohody z 2026-10-12](#dohoda-kapitola-06) a rozhodnutí R28–R30 vznikla
kapitola `quarto/kapitola_06.qmd` (Výběrové rozdělení a testování hypotéz)
s dvanácti výkladovými oddíly, šestnácti obrázky, pěti nepovinnými
rozšířeními a čtrnácti cvičeními (dvanáct základních, dvě nepovinná), sešit
`data/kapitola_06.xlsx`, 29 hesel slovníčku (celkem 240) a dvanáct řádků
přehledu značení (celkem 89). Přehled funkcí Excelu se nezměnil: kapitola
nezavádí žádnou novou funkci. Plán v osnově byl nahrazen
[kartou skutečného obsahu](../docs/kapitoly/06-vyberove-rozdeleni-testovani.md#mapa-kapitola-06).

Před psaním byly na autorův pokyn odstraněny sloučené pracovní větve
`codex/chapter-01`, `codex/chapter-05` a `codex/other` lokálně i na GitHubu
poté, co bylo ověřeno, že jejich commity jsou obsaženy v `origin/main`. Větev `codex/chapter-06`
byla po sloučení PR #66 posunuta na `origin/main` a pokračuje pod stejným
názvem; vzdálená větev se neodstraňovala a nové commity na ni navazují.

### Odborná a didaktická rozhodnutí při psaní

- **Výukový model** má gama rozdělení s průměrem 35 s a směrodatnou
  odchylkou 15 s (medián 32,9 s). Průměr a odchylka jsou Howellovy hodnoty,
  tvar je vlastní volba a text ji tak označuje. Simulace mají pevné seedy
  20261013 (průměry), 20261014 (rozdíly průměrů) a 20261015 (150 skupin);
  seedy nebyly vybírány podle výsledku.
- **Zobrazený výběr** 30 řidičů je třetí z osmi vypsaných výběrů (průměr
  36,5 s). První výběr má shodou okolností průměr 39,03 s, stejný jako
  jedna ze skupin studie, a mohl by svádět k záměně simulace se studií.
- **Síla pro skutečný rozdíl 8 s** je 0,96 (přesně 0,965). Plán a karta P06
  uváděly 0,97 chybným zaokrouhlením; opraveno v textu i v dokumentaci.
- **Aritmetika v textu** dělí směrodatnou chybou 2,1213 s, ne zaokrouhlenou
  hodnotou 2,12 s, aby uvedené mezivýsledky (1,41; 3,24; 0,0786) navazovaly.
- **P-hodnota parkovacího příkladu** se uvádí jako „přibližně jedna tisícina“
  z normálního modelu. Počet jedenácti simulovaných rozdílů alespoň 6,88 s
  slouží jen k vysvětlení konečné přesnosti simulace.
- **Cvičení 11** má šest situací a dva výroky k opravě; plán mluvil o osmi
  výsledcích. Dvojice p-hodnot 0,049 a 0,051 a jednostranný test se stejnými
  daty jako v situaci 3 pokrývají zásady R28 lépe než dvě další obdobné situace.
- **Zápis normálního modelu.** Modely s desetinnou směrodatnou chybou jsou
  popsány slovy; zápis N(μ, σ) podle R15 se používá jen s celými čísly.
  První koncept odděloval parametry středníkem; to by bylo nedohodnuté značení.
- **Odkazy na další kapitolu.** Tři věty slibují interval spolehlivosti
  a test s odhadem směrodatné chyby „v další kapitole“ podle autorových
  pokynů v R28. Rozsah další kapitoly schválen není; plán pokračování
  v osnově tato místa vyjmenovává pro případ jiné dohody.

**Didaktická revize** celého textu proběhla po dokončení konceptu. Opraveno:
chybějící zavedení termínu testování hypotéz s anglickým ekvivalentem;
definice hladiny významnosti jako „pravděpodobnosti, pod kterou…“, z níž
nebylo zřejmé, čeho pravděpodobnost má být pod hranicí (nyní hranice
pro p-hodnotu; upraveno i heslo slovníčku); nepřesná věta, že u souměrné
populace stačí malé výběry (doplněno „a nemá těžké chvosty“); volná
formulace o „nesouladu s daty“ u p-hodnoty a modelu; rozdělený odstavec
u směrodatné chyby podílu; na pěti místech samotné „významný“ místo
„statisticky významný“ a na dvou „síla testu“ místo „statistická síla“.
Interní revize není ověřením porozumění na studentech.

### Zdroje a citace

Rozsah čtení a použití je v kartách U01, U04, U08, U11, P06, C05, D07 a D11
a v [záznamu o použití](../docs/zdroje/HISTORIE.md#pouziti-kapitola-06). Do
`references.bib` přibyly čtyři záznamy (celkem 83): Ruback a Juieng (1997),
Wainer (2007), Wasserstein a Lazar (2016) a Simmons et al. (2011); údaje
všech čtyř byly ověřeny v metadatech Crossref. Body otevřené při dohodě
byly vyřešeny takto: bibliografický záznam a uspořádání parkovací studie
ověřeny z Crossref a ze shrnutí článku; Russova tabulka 5.2 potvrzena
v obraze; Wainer s. 249–253 a Uttsová s. 75–76 přečteny.

Při psaní byly po kontrole proti zdroji opraveny čtyři formulace: věta
o dvojnásobné chybovosti při dodatečné volbě směru je citována jako
„srov.“, protože je vlastním shrnutím Howellovy s. 98; výzkumná hypotéza
je uvedena Howellovou formulací (s. 89) místo tvrzení o očekávání autorů
studie; věta o Uttsové odpovídá s. 75–76; Fisherovo pojetí je popsáno
podle Howella. Z nálezů k Howellovi byl vyřazen údaj „16,88 s“: jde
o hypotetický příklad, ne o chybu.

### Sešit a Excel

Sešit vytváří `scripts/kapitola_06-sešit.mjs` společným generátorem
v desktopovém Excelu (16.0, české rozhraní) z deklarací
v `scripts/sesity-data.mjs` a ze simulací v `scripts/sesity-simulace.R`.
Má 26 listů a 49 vzorců, neobsahuje grafy. Simulovaná data (přes 50 000 čísel)
jsou statická a zaokrouhlená na tři desetinná místa.

Společné soubory se změnily ve třech bodech. `build-workbook-excel.ps1`
zapisuje čistě číselné bloky od 1 000 řádků jedním přiřazením oblasti;
bez toho trvalo sestavení neúměrně dlouho (nyní asi dvě minuty).
`check-workbooks-excel.ps1` přeskakuje listy bez vzorců. Rozsahy kapitol
ve spouštěči, náhledech a kontrolách byly rozšířeny na 1–6. Sešity kapitol
1–5 nebyly znovu sestaveny a v Gitu se nezměnily; jejich největší blok má
600 řádků, takže nová větev zápisu se jich netýká.

### Ověření

- `check-chapter-06.R`: přesný příklad, modelové hodnoty, všechny údaje
  ze simulací citované v textu, nepovinná rozšíření, čtrnáct cvičení
  a existence šestnácti obrázků. R kontroly kapitol 1–5 po změně společných
  skriptů prošly.
- `check-chapter-06-excel.ps1` ve skutečném Excelu: 47 uložených výsledků,
  33 českých vzorců z textu a řešení včetně čtyř počtů COUNTIFS (261, 236,
  7 a 4), tři chybové případy, deset změn vstupů a český zápis osmi vzorců
  listů. Použité funkce byly tedy spuštěny, nejen ověřeny dokumentací.
- `check-workbooks-excel.ps1`: žádná chyba vzorce v šesti sešitech.
  `check-workbooks.py`: 54 803 vstupních buněk šesti sešitů, odkazy na listy
  a oblasti v textu a shoda sešitů s kopií ve webu.
- Render celé knihy (11 stránek) bez varování a `check-html.cjs`: odkazy,
  240 hesel, 68 sbalených řešení, čtrnáct řešení a pět sbalených
  nepovinných rozšíření kapitoly 6, stojatá řecká písmena, žádná formulace
  o přijetí nulové hypotézy mimo citované protipříklady, klávesnice, režim
  bez JavaScriptu a mobil 390 px.
- Vizuálně prohlédnuto: všech šestnáct obrázků (náhledy PNG), snímky šesti
  oddílů kapitoly z kontroly webu a PDF náhledy listů `Prehled`, `Chyba`,
  `Test_rozdilu`, `Binom_test`, `Z_test`, `Sila` a `Sim_prumery`.
- Místní odkazy a kotvy upravených dokumentů ověřeny skriptem.

**Nalezeno a opraveno kontrolami:** rozbalená řešení na mobilu vodorovně
přetékala (tabulky uvnitř řešení dostaly posuvný obal, tři dlouhé rovnice
jsou rozděleny do řádků); u šesti obrázků se překrývaly nebo ořezávaly
popisky; pod desetinnou čárkou R selhal převod názvů tabulky na čísla
v přesném příkladu.

### Omezení a neověřené části

- Plný text studie Rubacka a Juienga (1997) čten nebyl; průměry
  a směrodatná odchylka jsou jen z Howella a uspořádání ze shrnutí článku.
  U Simmonse et al. (2011) byl ověřen jen bibliografický záznam.
- Howellovy citované strany byly čteny v textové extrakci, v obraze jen
  s. 95–96; u Navarra je lokátorem oddíl, ne strana. Práce, na které Howell
  odkazuje (Jones a Tukey, Fisher, Neyman a Pearson), čteny nebyly.
- Kapitolové excelové kontroly kapitol 2–5 nebyly znovu spuštěny; jejich
  sešity se neměnily. Vstupní listy cvičení a listy `Sim_vyber`,
  `Sim_rozdily` a `Skupiny` byly zkontrolovány číselně, vizuálně nikoli.
- Všechny pravděpodobnosti parkovacího příkladu platí ve výukovém modelu
  se známou směrodatnou odchylkou; nejsou reprodukcí analýzy autorů studie.
- Sešit lze obnovit jen na Windows s českým Excelem.
- Interní didaktická revize není ověřením porozumění na studentech.
  Veřejné nasazení webu navazuje na autorovo sloučení pull requestu.

## 2026-10-13 — Pracovní PDF kapitoly 3 na vyžádání

Na výslovné zadání autora vznikl samostatný export kapitoly 3 do PDF,
bez automatického spouštění s HTML. Dohodu eviduje
[R31](../docs/rozhodnuti/postupy-a-dokumentace.md#r31-pracovni-pdf), provozní postup je
v [provozním návodu](../docs/PROVOZ.md#ruční-pdf-vybrané-kapitoly).

- Zdrojový studentský text se neměnil. Skript čte aktuální kapitolu,
  obnoví její grafy a v ignorovaném `tmp/` sestaví pracovní PDF.
  Lua filtr přesune všech 14 řešení za všechna zadání, doplní obousměrné
  odkazy a rozepíše nepovinné bloky. Pouze v pomocné kopii se pokyn
  „Řešení otevírejte“ přizpůsobí četbě závěrečné části.
- Výstup `output/pdf/kapitola_03.pdf` má 42 stran A4: obsah na s. 1,
  výklad od s. 2, cvičení s. 35–37, řešení s. 38–40, citovanou literaturu
  s. 41–42. Závěrečné přehledové kapitoly se nepřipojují.
- Sazbu zajišťuje Quarto 1.9.38 / Typst 0.14.2. Číslování kapitoly,
  oddílů, obrázků a tabulek zachovává předponu 3; použity jsou SVG grafy
  a textová matematika. Citace zpracovává citeproc se společným APA CSL.
  Bibliografie zahrnuje jen citované zdroje; rozlišující přípony stejných
  let se proto mohou od celoknižní bibliografie lišit.

### Provedené ověření

- Opakovaný export včetně běhu z Windows PowerShellu 5.1; české znaky
  chrání UTF-8 BOM skriptu a česká UTF-8 locale R.
- `node scripts/check-chapter-pdf.cjs`: všech 14 řešení zachováno beze
  změny obsahu, umístěno až za zadání a obousměrně propojeno; shoda
  matematických výrazů, kódu, obrázků, tabulek a citačních uzlů před/po přesunu.
- `check-chapter-03.R`: všechny číselné příklady a 14 řešení prošly,
  včetně úplné enumerace výběrů a simulace. První běh narazil na výchozí
  `C.UTF-8` ve Windows; s `Czech_Czechia.utf8` prošel.
- Všech 42 stran vykresleno Popplerem a vizuálně prohlédnuto; po opravě
  zalomení a bibliografie znovu prohlédnuty změněné s. 35–42, s. 1–34
  byly obrazově totožné. Opraveno výchozí číslování od 1, duplicitní
  nadpis bibliografie, odsazení literatury a oddělování nadpisů cvičení
  či řešení od jejich textu.
- Ve výsledném PDF ověřeno 65 vnitřních a 101 vnějších odkazových anotací,
  včetně všech 14 odkazů na řešení a 14 návratů ke správnému zadání.
  Textová kontrola nezjistila náhradní znak ani znaky mimo plochu stránek.

### Hranice ověření

Výstup je pracovní sazba, nikoli finální knižní vydání. Vnější odkazy jsou
absolutní HTTPS adresy; dostupnost všech vzdálených zdrojů se znovu
neověřovala. Nový HTML render a desktopové excelové kontroly se nespouštěly:
zdroj kapitoly, sešit, konfigurace HTML a publikační workflow se neměnily.
PDF se automaticky nepublikuje a do Gitu se neukládá. Export jiných kapitol
zatím není implementován ani ověřen.
<a id="reorganizace-autorskych-map"></a>

## Reorganizace autorských map — 2026-10-13

Na výslovný pokyn autora rozděleny [mapa obsahu](../docs/OSNOVA.md)
a [mapa zdrojů](../docs/ZDROJE.md) do propojených Markdownových souborů
podle [R32](../docs/rozhodnuti/postupy-a-dokumentace.md#r32-propojene-mapy). Celkový přehled
a tematické rozcestníky zůstávají na původních cestách. V `docs/kapitoly/`
je šest karet existujících kapitol a oddělený plán pokračování;
v `docs/zdroje/` je 37 karet (U01–U12, P01–P07, C01–C05, D01–D11,
E01 a dosavadní externí doplněk Griffith et al.) a
[společná historie ověřování](../docs/zdroje/HISTORIE.md).

Karty kapitol obsahují výběr odkazů na relevantní zdrojové karty; zpětné
odkazy ve zdrojových kartách vyjadřují tematickou vazbu, nikoli nové použití
či prostudování. Původní záznamy o skutečném použití, neověřených částech,
nálezech a odstraněných Baronových výřezech zůstávají v úplnosti zachovány.
Aktualizovány relativní a příchozí odkazy, provozní README a AGENTS.md.
R17 zachovává původní text a odkazuje na R32 jako změnu organizace souborů.

**Kontrola zachování:** výchozí commit
`ba3b862f74c0d4dc0bf8eb8815e902b96eeaf84d`, čistý pracovní strom.
Před přesunem pořízen pomocný snímek obou map v ignorovaném `tmp/`.
Rozdělení pokrylo všech 53 souvislých bloků bez mezer a překryvů;
jejich opětovné spojení je po sjednocení konců řádků na LF totožné
s původními soubory a jejich SHA-256.
V každém cílovém souboru byla ověřena úplnost a pořadí příslušných řádků
včetně očekávaných nových adres. Dodatečná kontrola vůči Gitu nalezla
všech 1 662 původních neprázdných obsahových řádků a všech 132 původních
kotev (výslovných ID i kotev nadpisů). Porovnání zohledňuje nové cíle
místních odkazů, úroveň nadpisů a čtyři navigační formulace typu „karty
níže“ → „samostatné karty“; externí URL, čísla a historie ověřování
se při obsahovém porovnání zachovávají. Staré adresy mají odkazy na nové
umístění, aktuální příchozí odkazy vedou přímo do karet.

**Reprodukovatelná kontrola:**
`node scripts/check-doc-maps.cjs --baseline ba3b862 --require-sources`.
Ověřeny místní cílové soubory a kotvy v mapách a jejich příchozí odkazy;
také odkazy v AGENTS.md, README.md, ROZHODNUTI.md a SLOVNIK.md.
Všech 314 odkazů do neveřejných `sources/` má v této pracovní kopii
existující cíl. Běžná kontrola bez `--baseline` slouží další údržbě;
postup je v [provozním návodu](../docs/PROVOZ.md#kontroly-a-github).

Rozcestník osnovy se zkrátil o 83,9 % a zdrojů o 81,9 % znaků při
srovnání s jednotným LF; obsah je přesunut do karet, nikoli odstraněn.
Jde o reorganizaci dokumentace: nebyl nově posuzován odborný obsah,
otevírány originály, ověřována dostupnost externích webů ani spouštěn
Excel či render studentského webu. Data dosavadních obsahových kontrol
zůstávají zachována. Kontrola `git diff --check` prošla.

<a id="registr-rozhodnuti-2026-10-13"></a>

## Registr rozhodnutí a hlavní místa informací — 2026-10-13

[ROZHODNUTI.md](../docs/ROZHODNUTI.md) nyní obsahuje stručný registr
32 rozhodnutí s rozsahem, aktuální platností a odkazy na doklad a hlavní
místo údržby. Podrobné původní záznamy jsou rozděleny do osmi souborů
podle společných témat a kapitol; původní úvod a pokyny k návrhům jsou
tehdy zachovány v souboru `docs/rozhodnuti/historie-registru.md`.
**Doplnění 2026-10-14:** tento archiv obecných pokynů a jeho odkazovací
sekce byly později na pokyn autora odstraněny; původní znění je v Gitu.
Doklady jednotlivých rozhodnutí zůstávají zachované (doplnění
[R32](../docs/rozhodnuti/postupy-a-dokumentace.md#r32-propojene-mapy)).
Registr se při porovnání s jednotným LF zkrátil z 58 561 na 12 239 znaků
(o 79,1 %). Původní znění dohod, jejich ID, data a historie zůstávají
zachovány; nové odkazy vedou přímo k dokladům a staré kotvy registru
zůstávají funkční.

U R09, R10, R17 a R21 registr výslovně rozlišuje dosud platné části
od částí nahrazených pozdější dohodou. Schválená reorganizace je datovaným
doplněním [R32](../docs/rozhodnuti/postupy-a-dokumentace.md#r32-propojene-mapy),
nikoli novým rozhodnutím. [AGENTS.md](../AGENTS.md#evidence-rozhodnuti)
určuje jedno hlavní místo údržby každého typu informace, podmínky vzniku
nového rozhodnutí a rozdíl mezi současným pravidlem, původní dohodou
a záznamem provedené práce. Historické schválené plány se nadále
nepřepisují podle pozdějšího skutečného obsahu kapitol.

**Kontrola zachování:** výchozím stavem je commit
`467fef02f22af5f2615faa3d06ea27816a412afc`. Původní soubor byl rozdělen
na 34 souvislých bloků (32 rozhodnutí a dva úvodní bloky); jejich složení
přesně obnovilo původní obsah s jednotným LF. Jeho SHA-256 je
`ac28d93dbc75e442f3a222abc4934ab2bd3376e326759711620c3cf8de871f1c`.
V cílových souborech bylo ověřeno všech 749 původních neprázdných řádků
v původním pořadí včetně očekávaných nových adres místních odkazů.

**Reprodukovatelná kontrola:**
`node scripts/check-doc-maps.cjs --baseline 467fef0 --require-sources`
prošla bez chyb. Kontrola zahrnuje místní odkazy a kotvy, zachování
původního obsahu map, shodu 32 záznamů s registrem, jedinečnost ID
a pořadí obsahu každého původního rozhodnutí v cílovém souboru.
Všech 314 odkazů do místních podkladů má existující cíl. Běžný režim
bez `--baseline` nově hlídá také chybějící a duplicitní rozhodnutí
a nesprávné cíle registru. Kontrola `git diff --check` prošla.

Jde pouze o reorganizaci autorské dokumentace. Nebyl nově ověřován
odborný obsah podkladů ani dostupnost externích URL; historická data
a omezení ověření zůstávají zachována. Excel ani render studentského
webu nebyly pro tuto změnu spouštěny.

## Excelová cvičení k prezentacím (2026-10-13)

Podle [R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-excelova-cviceni-prezentaci)
upravena pravidla v [PREZENTACE.md](../docs/PREZENTACE.md#excelova-cviceni):
závěrečné početní úlohy vyžadující Excel patří do doprovodného sešitu,
členěného podle datasetů. Doplněny požadavky na zadání, data, řešení,
oddělení pracovní oblasti, odkaz z prezentace a kontrolu sešitu.

Jde pouze o změnu instrukcí; existující PPTX ani XLSX se v tomto úkolu
neměnily. Provedena obsahová kontrola rozdílů, `git diff --check`
a `node scripts/check-doc-maps.cjs` bez chyb. Render knihy není pro tuto
změnu potřeba; kontrola konkrétních prezentací či sešitů nebyla součástí úkolu.

## Intuitivní vysvětlení a nekapitolové větve (2026-10-13)

V `AGENTS.md` doplněno schválené využití analogií, přirovnání a metafor
v intuitivním vysvětlení. Na žádost autora nahrazena jediná nekapitolová
větev členěním podle hlavního účelu práce; vymezen vztah ke kapitolovým
větvím a související dokumentaci. Doklady jsou v
[R34](../docs/rozhodnuti/postupy-a-dokumentace.md#r34-intuitivni-vysvetleni)
a [R35](../docs/rozhodnuti/postupy-a-dokumentace.md#r35-nekapitolove-vetve);
registr označuje příslušnou část R11 za nahrazenou.

Obsahová kontrola rozdílů, `git diff --check` a
`node scripts/check-doc-maps.cjs` prošly bez chyb. Změna se týká pouze
instrukcí a jejich evidence; studentský obsah ani prezentace se neměnily,
render knihy proto nebyl potřeba.

## Prezentace ke kapitole 3 (2026-10-13)

Vytvořeny místní, Gitem ignorované soubory v `presentations/`:
`kapitola_03_poloha_a_variabilita.pptx` (29 slidů),
`kapitola_03_poloha_a_variabilita_cviceni.xlsx` a `kapitola_03_poznamky.docx`.
Rozsah dohodnut s autorem: jedna výuka, jádro kapitoly ve 22 výkladových
slidech (45 minut); MedAD, ořezání, winsorizace, entropie a vztah dat a modelu
jen stručně, nepovinné momenty vynechány. Procvičení tvoří šest úloh bez
Excelu adaptovaných z Howella (úlohy 2.30–2.36 a 2.54, s. 60–62) a podle
[R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-excelova-cviceni-prezentaci)
doprovodný sešit s listy `Prehled`, `Vypraveni` (data úloh 2.1 a 2.4,
úkoly 1–5) a `Transformace` (úloha 2.45, úkol 6). Řešení úloh z prezentace
jsou pouze v poznámkách. Rozsah čtení Howella eviduje
[karta U01](../docs/zdroje/U01-howell.md#u01). Kapitola 3, slovník, osnova
ani studentský sešit `data/kapitola_03.xlsx` se neměnily; při přípravě nebyl
zjištěn věcný rozpor mezi kapitolou a prezentací.

Postup: slidy a poznámky zapisuje dočasný generátor v `tmp/` přímo v OOXML
do balíčku předlohy z prezentace kapitoly 2 (editovatelný text a tabulky,
vzorce jako nativní rovnice, čeština u všech textů); výsledný soubor uložil
PowerPoint. Grafy jsou rastrové převody existujících obrázků kapitoly 3,
bez změny publikovaných souborů. Sešit sestavila skrytá instance Excelu
z deklarací přes `scripts/excel-workbook.mjs` a místní kopii sestavovacího
skriptu s jiným cílovým souborem; sdílené skripty se neměnily.

Kontroly: všech 29 slidů vykresleno v PowerPointu a prohlédnuto (diakritika,
zalamování, překryvy, tabulky, vzorce); každý slide má poznámky a jazyk
textů i poznámek je čeština (ověřeno přes objektový model PowerPointu).
Čísla na slidech, v poznámkách a v řešeních přepočítána nezávisle v R
a shodují se s kapitolou. Sešit přepočítán v českém Excelu 16 bez chybových
buněk; 59 vzorců zapsaných českou syntaxí vrací hodnoty shodné s R, pracovní
buňky jsou prázdné a listy byly prohlédnuty z exportu. DOCX otevřen ve Wordu:
29 nadpisů „Slide N:“, 231 odrážek shodných s PPTX, 15 stran.

Omezení: popisky uvnitř převzatých grafů jsou při projekci drobné, hlavní
hodnoty proto opakuje text slidu. Funkce MINIFS, MAXIFS a TRIMMEAN v řešení
sešitu nejsou vyloženy v kapitole; sešit je vysvětluje a u prvních dvou
uvádí požadavek na Excel 2019 nebo Microsoft 365. Starší verze Excelu ani
PowerPointu nebyly zkoušeny. Didaktická revize byla interní, bez ověření
na studentech. Render knihy nebyl potřeba, studentský web se nemění.

## Upřesnění pravidel doprovodných sešitů k prezentacím (2026-10-13)

K [R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-excelova-cviceni-prezentaci)
připojen datovaný doklad upřesnění a upravena pravidla v
[PREZENTACE.md](../docs/PREZENTACE.md#excelova-cviceni): úkoly ke stejnému
datasetu zůstávají obvykle na jednom listu, ale při větším počtu úkolů nebo
rozsáhlejších výpočtech se dělí na samostatné listy se stejnými vstupními
daty; řešení se rozepisuje po krocích základními operacemi a speciální
funkce Excelu slouží jen jako kontrola. Do kontrol před předáním doplněna
shoda krokového řešení s kontrolní funkcí. Nevzniklo nové ID rozhodnutí,
původní znění R33 je zachováno a registr uvádí upřesnění.

Jde pouze o změnu instrukcí a jejich evidence. Provedena obsahová kontrola
rozdílů, `git diff --check` a `node scripts/check-doc-maps.cjs` bez chyb;
render knihy není potřeba. Podle nového znění byl téhož dne upraven sešit
k prezentaci kapitoly 3, starší sešit k prezentaci kapitoly 2 upravován nebyl.

## Doprovodný sešit k prezentaci kapitoly 3: řešení po krocích (2026-10-13)

Na žádost autora přestavěn místní sešit
`presentations/kapitola_03_poloha_a_variabilita_cviceni.xlsx`. Pět úkolů
k datům o vyprávění je nově na samostatných listech `U1_stred`,
`U2_variabilita`, `U3_interval`, `U4_boxplot` a `U5_orezani` se stejnými
daty na stejných adresách (C4:E53); hodnoty dětí i dospělých jsou seřazeny
vzestupně, každá skupina zvlášť, a doplněny sloupcem pořadí. Úkol 6 je na
listu `U6_transformace`, list `Prehled` byl aktualizován. Řešení každého
úkolu je rozepsáno po krocích základními operacemi s pomocnými sloupci
(odchylky, čtverce, příznaky 1/0, tabulka četností, pozice a interpolace
kvartilů); speciální funkce (`VAR.S`, `SMODCH.VÝBĚR.S`, `PERCENTIL.INC`,
`MEDIAN`, `MODE.SNGL`, `COUNTIFS`, `MINIFS`, `MAXIFS`, `TRIMMEAN`) slouží
jen jako kontrola se sloupcem „Shoda s kroky“. Uspořádání odpovídá upřesnění
[R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-excelova-cviceni-prezentaci).

V prezentaci byl beze změny ostatních částí souboru nahrazen pouze slide 29
a jeho poznámky (nové názvy listů, popis řešení po krocích); autorem mezitím
uložený soubor se textově nelišil od vytvořené verze. `kapitola_03_poznamky.docx`
byl znovu vyexportován z aktuálního PPTX. Kapitola 3 ani studentská data se
neměnily.

Kontroly: sešit sestaven a přepočítán v českém Excelu 16, 1 360 vzorců bez
chybových buněk; všech 19 kontrolních funkcí se shoduje s výpočtem po krocích
a mezivýsledky i výsledky odpovídají nezávislému výpočtu v R z první verze
sešitu. Ověřeno seřazení dat, pořadí 1–50, shodné součty dat na listech U1–U5
a prázdné pracovní buňky; listy prohlédnuty z exportu. PowerPoint soubor
otevřel (29 slidů, 29 poznámek), slide 29 byl vykreslen a prohlédnut; ve
Wordu má DOCX 29 nadpisů a 15 stran.

Omezení: krokové řešení odkazuje na konkrétní řádky pořadí (například 13 a 14
pro 1. kvartil), platí tedy pro dané n = 50 a po změně počtu údajů by se muselo
upravit. Pomocné příznaky používají `KDYŽ` a `A`, zaokrouhlení dolů
`CELÁ.ČÁST`; sešit je vysvětluje. Na slidu 29 se nahrazením ztratily případné
ruční úpravy formátu tohoto jediného slidu. Ostatní slidy nebyly znovu
vykreslovány, protože se jejich části souboru nezměnily.

## Obecné rovnice v sešitu k prezentaci kapitoly 3 (2026-10-14)

Na žádost autora doplněn do `presentations/kapitola_03_poloha_a_variabilita_cviceni.xlsx`
na každý list s úkolem (U1–U6) blok „Potřebné vztahy“: pod zadáním jsou
obecné rovnice potřebné k výpočtu, zapsané ve značení učebnice, a pod každou
legenda symbolů. Celkem jde o 15 objektů: průměr a medián; variační rozpětí,
rozptyl a směrodatná odchylka; meze intervalu *m* ± 2*s* a podíl; pozice
a interpolace kvantilu, mezikvartilové rozpětí a pomocné meze; ořezaný průměr;
lineární transformace a její vliv na průměr a směrodatnou odchylku. Podle
volby autora jsou rovnice nativní objekty editoru rovnic Excelu (editovatelné,
s alternativním textem), nikoli obrázky ani text v buňkách. List `Prehled`
blok vysvětluje. Data, pracovní oblast ani řešení po krocích se nezměnily;
prezentace a DOCX zůstaly beze změny.

Postup: Excel nenabízí spolehlivé automatizační rozhraní pro vložení rovnice.
Dočasný generátor v `tmp/` proto po sestavení sešitu zapíše rovnice (OMML
v textovém poli výkresu) přímo do souboru a skrytá instance Excelu jej otevře,
ověří a uloží jako běžný sešit. Před přegenerováním bylo buňku po buňce
ověřeno, že verzovaný sešit odpovídal výstupu generátoru, takže se nepřepsaly
žádné ruční úpravy. Sdílené skripty v `scripts/` se neměnily.

Kontroly v českém Excelu 16: soubor se otevírá bez opravy; všech 15 objektů
Excel hlásí jako rovnice; žádné chybové buňky; 19 kontrolních funkcí se nadále
shoduje s výpočtem po krocích; data jsou seřazená a pracovní buňky prázdné.
Všechny bloky rovnic byly prohlédnuty z exportu listů (zlomky, sumace, indexy,
odmocniny, překryvy). Rovnice odpovídají vztahům v kapitole 3 a krokům řešení
na témže listu.

Omezení: u ořezaného průměru je použito pomocné označení *k* (počet
vynechaných hodnot na každém konci), které učebnice nezavádí; legenda to uvádí
a do přehledu značení se nezapisuje. V legendách je pořadový index psán
na řádku jako x(i), protože písmo buněk nezobrazuje dolní závorky spolehlivě.
Zobrazení rovnic nebylo zkoušeno ve starších verzích Excelu, v Excelu pro Mac,
ve webovém Excelu ani v jiných tabulkových programech; ty mohou místo rovnice
ukázat náhradní text nebo obrázek.

## Rovnice u úloh v doprovodných sešitech: pravidlo (2026-10-14)

K [R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-excelova-cviceni-prezentaci)
připojeno druhé datované upřesnění a v
[PREZENTACE.md](../docs/PREZENTACE.md#excelova-cviceni) doplněno, že se
u každé úlohy v doprovodném sešitu uvádějí obecné rovnice potřebné k výpočtu,
ve značení učebnice, s vysvětlením symbolů a jako editovatelné rovnice Excelu.
Do kontrol před předáním přibyla úplnost, značení a vykreslení rovnic.
Nevzniklo nové ID rozhodnutí; registr upřesnění uvádí.

Jde pouze o změnu instrukcí a jejich evidence. Obsahová kontrola rozdílů,
`git diff --check` a `node scripts/check-doc-maps.cjs` bez chyb; render knihy
není potřeba. Pravidlo bylo téhož dne uplatněno v sešitu k prezentaci
kapitoly 3; sešit k prezentaci kapitoly 2 upravován nebyl.

## Kapitola 3: revize opakování, výjimek středu a populačních značek (2026-10-14)

Na základě autorovy revize kapitoly 3 a navazující dohody (konverzace
2026-10-14) byly provedeny tyto úpravy. Navazují na autorovy rozpracované
redakční změny, které byly převzaty beze změny kromě oprav níže.

- **Obrázek 3.3** (`assets/chapter-03/plots/mode-median-mean.svg`): výchozí
  popisky vícejazyčného SVG přepsány na modus, medián, průměr a „50 %“
  (s mezerou; obě značky mírně odsunuty, aby se nepřekrývaly). Popisek
  uvádí „upraveno (české popisky)“ podle CC BY-SA 3.0; alternativní text
  a vysvětlující odstavec už nepoužívají anglická slova.
- **Výjimky z pořadí středů:** nový obrázek `stred-vyjimky.svg`
  (`scripts/kapitola_03.R`, `ch3_exceptions`) se dvěma autorskými
  diskrétními modely. A: 100 lidí, 1–5 pokusů, četnosti 38, 49, 8, 3, 2;
  delší pravý chvost, průměr 1,82 < medián = modus 2. B: 20 lidí, 0–4 chyby,
  četnosti 8, 7, 3, 1, 1; nesouměrné, průměr = medián = 1, modus 0.
  Text vysvětluje vyvážení odchylek vůči mediánu. Opora: von Hippel (2005),
  oddíly 2–3 (ověřeno v plném textu JSE 2026-10-14: výjimky jsou nejčastější
  u diskrétních proměnných, u jednovrcholových spojitých rozdělení vzácnější
  a mírnější). Četnosti jsou v sešitu na novém listu `Vyjimky_stredu` A2:D6.
- **Opakování:** vypuštěna nebo zkrácena opakovaná upozornění (souměrnost
  ze shody průměru a mediánu, pořadí středů jako pravidlo, nepozorovatelné
  výsledky, krajní hodnoty, ordinální kódy, transformace, pokrytí podílu
  interpolovaným kvantilem, vratnost percentilu a pořadí). Hlavní výklad
  každého tématu zůstal na jednom místě.
- **Kvantily:** lineární interpolace (typ 7) je formulována jako pravidlo
  učebnice a PERCENTIL.INC jako její výpočet v Excelu. Totéž ve značení,
  zadání cvičení a u krabicového grafu; upřesnění k R04.
- **Doplnění:** inkluzivní pořadí výslovně jako konvence učebnice; proč
  přidání hodnoty nezmenší rozpětí; čím winsorizace nahrazuje; proč jsou
  vousy modelového boxplotu stejně dlouhé; že b = 0 je krajní nevratná
  afinní transformace; proč je podhodnocení s dělením n výrazné u malých n.
- **Značky μ, σ² a σ** zavedeny v kapitole 3 (nové rozhodnutí R36). Upraven
  autorův zápis vzorce na (n − 1)/n · σ² (předtím σ místo σ²). Kapitola 4
  značky připomíná; přehled značení a slovníček odkazují na kapitolu 3.
- **Technické opravy autorových změn:** překlep „slob“; obnoveny atributy
  `tbl-colwidths` a ID obou tabulek, které nechtěně zmizely; obnoveny prázdné
  řádky kolem bloků obrázků a před nadpisem percentilového pořadí. Bez prázdného
  řádku se nadpis nevykreslil a odkazy na `#sec-percentilove-poradi` nefungovaly.
- Nepotřebná anglická označení částí krabicového grafu (*fence*, *suspected
  outliers*) z textu vypuštěna; *whiskers* zůstává u zavedení vousů.

Kontroly: `check-chapter-03.R` (rozšířen o oba protipříklady: unimodalita,
polohy středů, vyvážení odchylek, kladná šikmost) a `check-chapter-04.R`
prošly. `build-workbooks.ps1 -Chapter 3 -Verify` sestavil sešit v českém
Excelu 16 (32 listů, 149 vzorců, 247 vstupních buněk) a kontroly všech
sešitů prošly. Celá kniha vykreslena; `check-html.cjs` prošel (počet obrázků
kapitoly 3 zvýšen na 16). Vizuálně zkontrolovány obr. 3.3 a nový obrázek
výjimek a oddíl o korekci rozptylu (stojaté μ a σ). `check-doc-maps.cjs`
a `git diff --check` bez chyb.

Omezení: prezentace a poznámky ke kapitole 3 (`presentations/`) nebyly
upravovány; terminologie kvantilů v nich nebyla sjednocena (samostatná práce
pro `codex/presentations`). Didaktická revize je interní, neověřená na studentech.
## Jednorázové upozornění na smyšlená data (2026-10-14)

Na pokyn autora (nové rozhodnutí
[R37](../docs/rozhodnuti/spolecne-konvence.md#r37-smyslena-data)) uvádí
[úvod knihy](../index.qmd) jednou, že studie, účastníci a čísla jsou smyšlené
a sestavené pro výuku, pokud není uvedeno jinak. Opakovaná upozornění byla
z kapitol 1–6 odstraněna:

- Úvodní odstavce kapitol 2, 3, 4 a 5 a pokyny ke cvičením kapitoly 5 už
  obecně neopakují, že data jsou modelová či autorská. Kapitola 1 si ponechává
  věcnou mez, že průběžný příklad nedokládá vztah spánku a paměti; kapitola 4,
  že model skóru pozornosti není skutečný test s normami.
- Štítky „modelový“, „autorský“ a věty typu „Údaje jsou smyšlené“ či „Jde
  o vlastní didaktická data“ vypuštěny z textu, popisků obrázků a tabulek,
  `aria-label` a zadání (kap. 1–6). Ve vzorovém popisu souboru (kap. 3,
  cvičení) nahrazuje větu o datech sestavených pro výuku mez zobecnění.
  V kap. 5, cvičení 8, jsou „modelové četnosti“ přejmenovány na četnosti
  pozorované, aby se nepletly s modelem.
- Ponecháno: statistické užití „model“, „modelový podíl“, „modelová
  populace“; simulace tam, kde je rozdíl model–simulace–pozorování obsahem
  (kap. 1 obrázky společné příčiny a výběru, kap. 3 korekce, kap. 4 Q–Q, kap. 5
  a 6); v kap. 6 „smyšlený rozdíl“ a „smyšlená varianta“, protože průběžný
  příklad je skutečná studie; Lordův „smyšlený příběh“ (citace).
- `AGENTS.md` (didaktika) a karta kapitoly 6 upraveny podle nové konvence.

Kontroly: celá kniha vykreslena bez varování; `check-html.cjs`,
`check-doc-maps.cjs` a `git diff --check` bez chyb. Každý výskyt posouzen
v kontextu (grep `smyšlen|modelov|autorsk|skutečného výzkumu`), bez hromadné
náhrady.

Omezení: poznámky v excelových sešitech (`scripts/sesity-data.mjs`,
`scripts/kapitola_0N-sešit.mjs`, listy `Prehled`) a prezentace dál uvádějí
původ dat; dohoda R37 je zatím neupravuje. Interní didaktická revize,
neověřená na studentech.

## Odstranění původních kotev osnovy (2026-10-14)

Na výslovný pokyn autora odstraněna sekce „Přesměrování původních odkazů“
z `docs/OSNOVA.md` včetně starých kotev. Samostatné karty kapitol a aktuální
rozcestník zůstávají zachované. Výjimka je doložena v doplnění
[R32](../docs/rozhodnuti/postupy-a-dokumentace.md#r32-propojene-mapy)
a promítnuta do instrukcí a registru rozhodnutí.

Kontroly: `node scripts/check-doc-maps.cjs --require-sources` a
`git diff --check` prošly bez chyb. Kontrola zahrnuje aktuální místní odkazy
a kotvy, nikoli dostupnost externích webů. Historické kotvy záměrně
nejsou zachovány; migrační porovnání se starým commitem nebylo použito.
Studentský web ani data se nemění, proto nebyl potřeba nový render.

## Odstranění archivu obecných pokynů registru (2026-10-14)

Na pokyn autora odstraněna sekce „Historické pokyny“ v `docs/ROZHODNUTI.md`
a soubor `docs/rozhodnuti/historie-registru.md`. Odstraněn také odkaz v úvodu
registru; záznam reorganizace z 2026-10-13 dostal datované vysvětlení
pozdějšího odstranění místo nefunkčního odkazu. Výjimka je doložena
v doplnění R32, registru a projektových instrukcích. Všech 37 dokladů
rozhodnutí zůstává zachovaných.

Kontroly: `node scripts/check-doc-maps.cjs --require-sources` prošel bez
chyb (2 309 místních odkazů, z toho 314 na zdroje); `git diff --check`
prošel. Odstranění bylo před kontrolou zařazeno do indexu, protože skript
načítá seznam verzovaných souborů pomocí `git ls-files`. Zbývající zmínky
názvu archivního souboru jsou historickou evidencí, nikoli aktivními odkazy.
Kontrola nezahrnuje dostupnost externích webů. Studentský web ani data
se nemění; nový render nebyl potřeba.

## Stručné README a provozní návod (2026-10-14)

Na pokyn autora zkráceno kořenové README z 313 na 79 řádků. Obsahuje
představení knihy, rychlé spuštění, hlavní složky a rozcestník dokumentace.
Pět provozních oddílů (práce s projektem, PDF, kontroly, obnova sešitů,
publikování) bylo přesunuto do [PROVOZ.md](../docs/PROVOZ.md). Detailní
výčty obsahu kapitol a sešitů nahrazují odkazy na osnovu a přehled dat;
pravidla tvorby a evidence odkazy na AGENTS.md.

Hlavní místo provozních postupů aktualizováno v AGENTS.md a doplnění R32.
Příchozí odkazy vedou přímo na nový návod. Původní kotvy README zůstávají
u odpovídajících položek rozcestníku, bez samostatné historické sekce.
Kontrolní skript nyní zahrnuje také celý PROVOZ.md a příchozí odkazy
na něj a README ze všech verzovaných dokumentů Markdown a Quarto.

Ověření: strojové porovnání potvrdilo zachování všech pěti provozních
oddílů; změnily se pouze relativní odkazy a popis rozšířeného rozsahu
kontroly odkazů. Všech 12 bloků příkazů je shodných s původním README.
Kontrola všech původních kotev README prošla. Dvě zkoušky s neexistující
kotvou vloženou pouze do paměťové kopie dokumentu potvrdily, že kontrola
odhalí chybný odkaz z PROVOZ.md i odkaz na něj z autorské historie.
`node scripts/check-doc-maps.cjs --require-sources` a `git diff --check`
prošly bez chyb.

Rozsah: reorganizace autorské dokumentace; nové spuštění popsaných
provozních příkazů ani kontrola dostupnosti externích webů neproběhly.
Studentský výklad, data a konfigurace publikování se nemění, nový render
knihy nebyl potřeba.

## Zhuštění AGENTS.md (2026-10-15)

Na pokyn autora redakčně zhuštěny projektové instrukce z 570 řádků
a 4 951 slov na 516 řádků a 4 396 slov (přibližně −11 %), bez věcné změny
pravidel. Sloučena opakovaná pravidla: popis SLOVNIK.md a ZDROJE.md
z úvodního oddílu přesunut do oddílů „Terminologie a značení“ a „Zdroje
a jejich použití“, odkaz na pravidla prezentací ponechán jen v jejich oddílu,
zachování historických záznamů jen v evidenci rozhodnutí, duplicitní
pokyny didaktiky, revize, cvičení a Gitu sloučeny. Výjimky podle doplnění
R32 z 2026-10-14 zůstávají vymezeny v úvodním oddílu. Nové rozhodnutí
nevzniklo.

Ověření: všechny nadpisy oddílů a kotva `evidence-rozhodnuti` zachovány,
takže příchozí odkazy zůstávají funkční; ruční porovnání se starým zněním
oddíl po oddílu a kontrola výskytu klíčových pojmů, cest a odkazů.
`node scripts/check-doc-maps.cjs --require-sources` a `git diff --check`
prošly bez chyb. Studentský výklad se nemění, nový render nebyl potřeba.

## Pravidla čitelnosti studentského textu (2026-10-15)

Podle [R38](../docs/rozhodnuti/postupy-a-dokumentace.md#r38-citelnost-textu)
doplněn do AGENTS.md oddíl „Čitelnost a struktura textu“ a krok čtení
očima začátečníka v didaktické revizi. Výchozí průzkum: kapitoly mají
8–20 tisíc slov, „Shrnutí“ mají jen kapitoly 1 a 2, jediným typem bloku
je `callout-note`; v kapitole 6 má přibližně 8 % vět přes 40 slov
(hrubý odhad dělením podle interpunkce).

Kapitoly zatím upraveny nebyly; doplnění shrnutí do kapitol 3–6 a sjednocení
bloků proběhne v samostatných PR. Ověření: kontrola odkazů skriptem
`check-doc-maps.cjs` a `git diff --check`; render nebyl potřeba.

## Kapitoly 3–6: provedení pravidel čitelnosti (2026-10-15)

Provedení [R38](../docs/rozhodnuti/postupy-a-dokumentace.md#r38-citelnost-textu)
v kapitolách 3–6 beze změny odborného obsahu, terminologie, dat a cvičení;
nové rozhodnutí nevzniklo. Autor v témže úkolu zvolil převést vybrané
existující odstavce na nové typy bloků a v kap. 4–6 sjednotit názvy
závěrečných oddílů.

- **Úvody hlavních oddílů:** doplněno 35 úvodů o jedné až dvou větách
  (otázka oddílu a návaznost) tam, kde oddíl začínal rovnou pododdílem,
  definicí nebo příkladem (kap. 3: 9, kap. 4: 7, kap. 5: 8, kap. 6: 11).
- **Shrnutí:** kap. 3 má nový oddíl `sec-shrnuti-03`; v kap. 4–6 je
  „Co si z kapitoly odnést“ přejmenováno na „Shrnutí“ a souvislý text převeden
  na 7–8 odrážek s odkazy na oddíly (ID zachována). Věcně přebírá dřívější
  shrnutí, v kap. 3 výklad kapitoly.
- **Bloky:** „Častý omyl“ (`.callout-warning`) kap. 3 ×2, kap. 4, kap. 5,
  kap. 6 ×2; „Připomenutí“ (`.callout-tip`) kap. 3 a kap. 6. Vznikly
  z existujících odstavců; první věty byly upraveny, aby blok obstál
  samostatně. Nepovinná rozšíření beze změny.
- **Dlouhé věty:** rozděleno 7 vět nad 35 slov (kap. 3: 1, kap. 4: 1,
  kap. 5: 1, kap. 6: 4). Zbylé nálezy kontrolního výpočtu jsou výčty dat,
  ukázka zápisu APA nebo chybné dělení vět skriptem.
- **Cvičení:** „Samostatná cvičení“ → „Cvičení“ v kap. 4–6 (ID zachována).
- Karty kapitol 3–6 doplněny o datovaný záznam a řádek Shrnutí.

Didaktická revize: čtení očima začátečníka samostatným agentem nad všemi
změnami. Opraveny jeho nálezy: tři bloky závislé na okolním textu (kap. 5
obrácení podmínky, kap. 6 nezamítnutí a připomenutí zákona velkých čísel,
kde nové tvrzení o zkresleném výběru zůstalo mimo blok připomenutí),
zdvojený text v kap. 3, chybějící entropie ve shrnutí kap. 3 a předčasně
použitý pojem v úvodu oddílu kap. 4. Ponecháno: titulek „Častý omyl“
u konvence N(μ, σ²) v kap. 4 (studenti ji při čtení jiných zdrojů zaměňují).

Kontroly: celá kniha vykreslena; `check-html.cjs`,
`check-doc-maps.cjs --require-sources` a `git diff --check`. Kontrola
odstraněných řádků potvrdila, že ubyly jen přeformulované či přesunuté věty.

Omezení: povinná část kap. 3 a 6 přesahuje orientačních 12 000 slov
(soubory mají přibližně 18 000 a 22 000 slov včetně cvičení a rozšíření);
zkrácení by měnilo obsah, a proto se v tomto úkolu neprovádí. Hustota nových
pojmů v pododdílech nebyla systematicky přepočítána. Shrnutí kap. 1–2 zůstávají
souvislým textem. Interní revize, neověřená na studentech.

## Kapitola 1: souhrnná tabulka úrovní měření (2026-10-15)

Na podnět autora (návrh vycházel ze dvou anglických přehledových tabulek)
byla tabulka na konci oddílu [Poměrová úroveň](kapitola_01.qmd#sec-pomerova)
rozšířena o sloupce „Které výroky mají smysl“ (kumulativně =/≠, </>,
o kolik, kolikrát) a „Příklady“. Dostala popisek a ID `tbl-urovne-shrnuti`,
přístupný posuvný obal a v `assets/styles.css` minimální šířku 760 px.

Odchylky od předlohy: sloupec „přípustné matematické operace“ formulován
jako interpretovatelné výroky, nikoli jako seznam povolených výpočtů
(v souladu s výkladem sporu Lord / Zand Scholten a Borsboom a se zápisem
v `docs/ZDROJE.md`); u nominální úrovně uvedeny počty v kategoriích místo
„žádné operace“; modus nepoužit (zaveden až v kap. 2–3); IQ a stupnice
souhlasu nezařazeny k žádné úrovni, věta pod tabulkou odkazuje na oddíl
o kvaziintervalovosti. Příklady převzaty z výkladu kapitoly, doplněny
obor studia, pořadí v soutěži a doba reakce. Nové pojmy ani značení nevznikly.

Kontroly: celá kniha vykreslena; `check-html.cjs`,
`check-doc-maps.cjs --require-sources`, `git diff --check`; vykreslená
tabulka prohlédnuta při šířce 1360 a 390 px (bez přetečení stránky,
odkaz na tabulku vykreslen jako „Tabulka 1.1“). Následující tabulka
`tbl-urovne-hodnoty` se přečíslovala na 1.2; ručně vepsaná čísla nikde nejsou.
Omezení: interní didaktická kontrola dotčeného místa, neověřená na studentech.

## Kapitola 1: označení rolí proměnných podle oboru (2026-10-16)

Podle [R39](../docs/rozhodnuti/kapitola-01.md#r39-role-podle-oboru) byla
tabulka označení rolí v oddílu [Role proměnných](kapitola_01.qmd#sec-role-promennych)
přestavěna podle kontextu: experiment, obecný popis vztahů, predikce a regrese,
psychologické testování, epidemiologie a klinický výzkum, strojové učení.
Dostala popisek, ID `tbl-role-promennych`, přístupný posuvný obal a minimální
šířku 720 px (na počítači se vejde do sloupce textu, na mobilu se posouvá).
Tabulky kapitoly 1 se přečíslovaly: role proměnných 1.1, souhrn úrovní měření 1.2,
možné hodnoty 1.3; ručně vepsaná čísla nikde nejsou. Úvodní odstavec doplněn o částečnou synonymii označení a o osy
bodového grafu. Zachovány nuance původní tabulky (vysvětlení není příčina,
predikce nemusí mířit do budoucnosti, kritérium v testování, odhadovaná
proměnná není vypočtená předpověď). Oborová označení jsou pouze zmíněna.
Exogenní/endogenní vynecháno (viz R39).

Preferovaný termín změněn z „explanační proměnná“ na „vysvětlující proměnná“
(explanační je alternativou). Ručně upraveno: kapitola 1 (odstavec o preferenci,
odkaz do slovníčku, úloha 4f zadání i řešení), slovníček (heslo, nezávislá
proměnná, prediktor; doplněna oborová označení u souvisejících hesel kvůli
vyhledávání), registr SLOVNIK.md (včetně poznámky u H05), karta kapitoly 1,
poznámky ke slidu 9 v `presentations/kapitola_01_od_otazky_k_datum.pptx`
a `kapitola_01_poznamky.docx` (jediný výskyt, nahrazen v XML a ověřen otevřením
v PowerPointu a Wordu). PDF prezentace termín neobsahuje, a proto nebyl znovu
exportován. ID hesla `pojem-explanacni-promenna` zachováno. Historické záznamy
výše se nemění.

Kontroly: celá kniha vykreslena; `check-html.cjs`, `check-doc-maps.cjs
--require-sources`, `git diff --check`; vyhledávání vysvětlující/explanační, exposure, regresor, endpoint
a regresand ve slovníčku nově ověřuje `check-html.cjs`;
tabulka prohlédnuta při 1360 a 390 px. Omezení: věta poznámek ke slidu 9
nadále označuje prediktor a vysvětlující proměnnou jako „synonyma“ nezávislé
proměnné; rozbor nuancí v prezentaci nebyl součástí úkolu. Interní didaktická
kontrola, neověřená na studentech.


## 2026-10-16: Ruční PDF kapitoly 4

Rozšířen stávající ruční export podle R31 na kapitoly 3 a 4. Číslo kapitoly,
číslování obrázků a záhlaví se doplňují do izolované konfigurace; krátké
tabulky kapitoly 4 zůstávají na jedné stránce. Příkazy a závislosti jsou
v [provozním návodu](../docs/PROVOZ.md#ruční-pdf-vybrané-kapitoly).
Studentský zdroj, HTML konfigurace a publikační workflow se neměnily.

Výsledek kapitoly 4: 26 stran, deset zadání na stranách 20–22, úplná řešení
na stranách 23–25, citovaná literatura na straně 26. Bez závěrečných přehledů.
Vizuálně prohlédnuto všech 26 stran; po úpravě tabulek znovu strany 9, 10,
12 a 13, ostatní náhledy zůstaly pixelově shodné. Ověřeny interní cíle odkazů,
deset zpětných odkazů a absence textu mimo stránku. Kontrola transformace
pro kapitoly 3 i 4 potvrdila úplnost řešení, matematiky, tabulek, obrázků,
kódu a citací. Číselná kontrola kapitoly 4 v čisté relaci R prošla včetně
deseti řešení a 15 SVG. Prošla kontrola dokumentačních odkazů a git diff --check.

Šablony po dosazení kapitoly 3 jsou obsahově shodné s předchozí verzí;
kapitola 3 nebyla znovu renderována. HTML ani Excel nebyly nově ověřovány,
protože se jejich obsah a nastavení neměnily. Dostupnost externích URL nebyla
nově kontrolována. PDF zůstává místní ignorovaný výstup, vytvářený pouze na žádost.

## Kapitola 3: grafy korekce rozptylu a transformace (2026-10-16)

Na žádost autora upraveny dva obrázky v `scripts/kapitola_03.R`:

- `fig-transformace`: popisky přírůstků (+3, +3, +5, +17) přesunuty vpravo
  vedle svislých úseček, aby nepřekrývaly křivku, body ani úsečky.
- `fig-korekce-rozptylu`: sloupcový graf průměrů nahrazen bodovým grafem
  s vodorovným jitterem. Body jsou rozptyly prvních 400 z 20 000 simulovaných
  výběrů pro každé n (kvůli velikosti SVG, asi 0,7 MB), křížky průměry ze všech
  20 000; barvy pro dělení n a n − 1 zachovány. Jitter má vlastní seed
  20261016, simulace a její seed se nezměnily.

V kapitole nový popisek, alternativní text a odstavec za obrázkem: korekce
zvětší každý výsledek v poměru n/(n − 1), rozptýlenost jednotlivých výsledků
zůstává (nestrannost postupu vs. přesnost jednoho výsledku). Bez nových pojmů.
Karta kapitoly 3 aktualizována.

Ověření: `simulation.csv` se po přegenerování shoduje s předchozí verzí;
`check-chapter-03.R` prošel (14 řešení); render kapitoly 3 a `check-html.cjs`
bez chyb; obě SVG vizuálně prohlédnuty samostatně i ve webu na šířce 1360
a 390 px, bez vodorovného přetečení. Celá kniha nebyla znovu renderována
(změna se týká jen kapitoly 3).

## Kapitola 4: redakce podle připomínek autora (2026-10-16)

Navazuje na autorovy necommitované redakční úpravy kapitoly 4, které zůstaly
zachovány. Na základě připomínek k pěti místům:

- `sec-standardizace`: nejasná věta o normách jiné skupiny nahrazena
  vysvětlením, že z-skóry pak popisují polohu vůči této skupině a průměr 0
  a SD 1 mají v našem souboru jen při shodě s normami.
- `sec-normalni-model`: „meze“ upřesněny jako nejnižší a nejvyšší možný skór;
  doplněn původ názvu „normální“ podle Howella (s. 68).
- `sec-parametry-normalniho`: konvence N(μ, σ²) převedena z bloku „Častý
  omyl“ do běžného odstavce, protože popisuje konvenci, ne omyl.
- `sec-bod-a-interval`: doplněno, kdy je normální aproximace počtu přesná;
  opravena poškozená věta o četnostech „nejvýše 60“ a „méně než 60“.

Aktualizována karta kapitoly 4 a karta U01. Ověření: render kapitoly 4
a kontrola dotčených míst ve vykresleném HTML.

## Kapitola 4: grafy hustoty a distribuční funkce (2026-10-16)

Druhé kolo připomínek autora. Text: škála 10/3 se uvádí hlavně
u inteligenčních a neuropsychologických baterií, s doloženým příkladem WISC-V
(nový zdroj `pearsonWiscV`, vzorová zpráva Pearsonu, s. 2: subtesty 10/3,
rozsah 1–19; pro WAIS oficiální veřejný doklad nalezen nebyl, proto není
uveden). V komentáři k obrázku škál je výslovně řečeno, že jde o krok
z-skóru. Autorovy rozpracované úpravy ř. 306 a 318 zachovány.

Grafy (`scripts/kapitola_04.R`): `distribucni` a `oblasti` mají nově hustotu
nahoře a distribuční funkci dole se společnou osou x a jednou čárkovanou
čarou hranice přes oba panely. Plocha se do distribuční funkce přenáší jako
sloupec téže barvy a hodnoty; hledaný podíl je oranžový, odečítaná část
modrá. Nový obrázek `mezi` (`fig-mezi-04`) ukazuje plochu 60–70 jako
rozdíl ploch do 70 a do 60 a totéž jako rozdíl výšek 0,977 − 0,841 = 0,136.
Nové popisky, alternativní texty a odstavce; obrázky jsou doplněny do
kontroly `check-html.cjs`. Hodnoty z `pnorm`: 0,841345; 0,977250; 0,135905.

Ověření: render kapitoly 4, `check-html.cjs`, vizuální kontrola tří SVG
a stránky na šířce 1360 a 390 px. Celá kniha nebyla renderována.

## Kapitola 4: názorná normalizace rozdělení (2026-10-16)

Na žádost autora oddíl `sec-normalizace` nově ukazuje postup na patnácti
vlastních ilustračních dobách řešení (11–52 s, pravý chvost, shody): tabulka
`tbl-normalizace-04` převádí každou různou hodnotu přes kompromisní
percentilové pořadí z kapitoly 3 na z-skór funkcí `NORM.S.INV`. Text
zdůvodňuje kompromisní konvenci (inkluzivní by dala 100 % a NORM.S.INV(1)
není definováno) a navazuje na podíly (i − 0,5)/n u Q–Q grafu. Původní věta
„konkrétní provedení zde neprobíráme“ byla nahrazena; tvorba norem ani
samostatné cvičení se nepřidávají.

Obrázek `fig-normalizace-04` (`scripts/kapitola_04.R`, `normalizace`) je
zrcadlový histogram podle autorova vzoru: hodnoty na svislých osách,
původní doby se sloupci doleva, z-skóry doprava, uprostřed mezera s body
jednotlivých hodnot spojenými poloprůhlednými čarami. Nový vstupní list
`Normalizace` v `data/kapitola_04.xlsx`.

Ověření: `check-chapter-04.R` nezávisle přepočítává tabulku (pořadí, z,
průměr ≈ 0, SD 0,99, kroky 0,55 a 0,72) a nově čeká 17 SVG; při této
příležitosti opravena očekávaná hodnota, kterou předchozí přidání obrázku
`mezi` nechalo na 15. Sešit přestavěn a ověřen `build-workbooks.ps1
-Chapter 4 -Verify`; render celé knihy a `check-html.cjs` (17 obrázků
kapitoly 4, nový obrázek v kontrole mobilního zobrazení).

## Kapitola 4: přiměřenost modelu a Q–Q graf (2026-10-16)

Připomínky autora k oddílům o normalizaci a přiměřenosti modelu:

- Věta o „normálně vypadajících standardních skórech“ nyní platí výslovně
  pro normalizované skóry; u lineárně převedených skórů je tvar stejný jako
  u hrubých, ani to však nedokládá rozdělení měřené vlastnosti.
- Upřesněno „shoda modelu s daty ve středu rozdělení“.
- Nový obrázek `fig-histogram-krivka-04` (`histogram-krivka`): táž simulace
  `normalni` s četnostní a hustotní osou a normální křivkou; zjednodušena
  věta o hustotě a ploše 1.
- Neutrální popis konvencí programů (osy, přímka prvním a třetím kvartilem
  dat podle dokumentace R `qqline`); doplněno, že populační rozdělení
  známe jen v simulaci; opraveno zdvojené „body“.
- Q–Q graf vysvětlen jako otázka „jakou hodnotu by mělo pozorování s tímto
  pořadím v normálním modelu“, včetně významu sloupce E v Excelu.
- Doplněno, že větší náhodný výběr věrněji odráží rozdělení populace.

Kontroly: `check-chapter-04.R` čeká 18 SVG, `check-html.cjs` 18 obrázků
kapitoly 4 a nový obrázek v kontrole mobilního zobrazení.

## Kapitola 4: komplexní revize (2026-10-16)

Odborná, didaktická, jazyková a technická revize celé kapitoly 4 a následné
opravy schválené autorem (s jeho úpravami nálezů):

- Chyby: porušená věta o tvaru rozdělení; „percentil 90/45“ nahrazeno
  percentilovým pořadím (R04); princip normalizovaných norem už není
  zobecněn na všechny normy; podmínky normální aproximace počtu; model jako
  jedna z cest k podílu; platnost výpočtů jen pro podíly a kvantily
  z normální křivky; porovnání histogramu s křivkou hustoty (popisek
  `fig-histogram-krivka-04`); gramatické a překlepové opravy (ř. 27, 115,
  167, 314, 373, 537, alt text diagnostika-sikme).
- Citace: Cumming zpřesněn na s. 80 (zaokrouhlený IQ-skór jako interval
  99,5–100,5, ověřil autor vizuálně); Howell s. 74–75 přesunut k rozlišení
  intervalu jednotlivých výsledků a intervalu spolehlivosti; Pearson primer
  přesunut k větě o škále 10/3; vypuštěna věta o autorských příkladech
  u cvičení (smyšlenost dat uvádí úvod knihy).
- Didaktika: Q–Q graf popsán modelovou srovnávací hodnotou (nikoli
  očekávanou hodnotou pořadové statistiky); nezaokrouhlený mezivýpočet
  `NORM.S.INV((4+3/2)/15)` a odkaz na list `Normalizace`; vazba poloh
  (i − 0,5)/n na kompromisní pořadí; normalizace v cílech kapitoly; spojení
  odkazů na sešit; drobné přeformulování (validita, záporný výsledek,
  devadesátý percentil, pořadí vět o velikosti souboru).

Revizí ověřeno: nezávislý přepočet všech čísel výkladu a řešení v R (vše
souhlasí), sešit otevřený jen pro čtení v českém Excelu (vzorce a hodnoty
listů Model a QQ odpovídají textu), Howell s. 66–79 a Dostál 2.7 v textové
extrakci, odkazy a mapy dokumentace, vykreslená stránka (obrázky, řešení,
mobil 390 px). Neověřeno: dokumentace Microsoftu, NIST, R ppoints, SHL
a GL Assessment nebyly znovu otevřeny; Firefox/Safari. Sešit se nemění.
Zjištěná mezera za desetinnou čárkou v MathML (celá kniha) se řeší
samostatně v `codex/infrastructure`.

## Desetinná čárka v MathML (2026-10-16)

Revize kapitoly 4 ukázala, že MathML převádí `0{,}841` na
`<mn>0</mn><mo>,</mo><mn>841</mn>` a Chromium za čárkou zobrazuje mezeru
(„0, 841344746…“); týkalo se všech 766 desetinných čárek v matematice knihy.
Podle postupu navrženého autorem byl přidán filtr
`filters/desetinna-carka.lua` (jen HTML): výraz s `{,}` mezi číslicemi se
převede s dočasnou desetinnou tečkou, takže Pandoc vytvoří jediné `<mn>`,
tečka se uvnitř `<mn>` vrátí na čárku a anotace zachová původní TeX.
Obyčejné čárky (`N(50,10)`, výčty `35,\ 39`, `0,1,\ldots,n`) se nemění;
prohledáním všech `.qmd` nebyla nalezena desetinná čárka v matematice bez
`{,}` ani desetinná tečka.

Ověření: testovací dokument (samostatné, záporné číslo, procento, mocnina,
zlomek, `N(50,10)`, `N(0{,}5,1)`, výčet, nerovnost, blok rovnice) –
struktura MathML zkontrolována; celý render; ve vykreslených stránkách
odpovídá všech 766 `{,}` čárkám uvnitř `<mn>`; `check-html.cjs` rozšířen
o tuto kontrolu a prošel; vizuálně ověřeno v Chromiu (mobil 390 px).
Neověřeno: Firefox a Safari; ruční PDF se nemění (vlastní konfigurace bez
filtru). Zjištěno mimo rozsah: úvodní minus se v MathML vykresluje jako
`<mi>−</mi>` (stav i před filtrem).

## Kapitola 4: hodnoty zpaměti, steny u nenormálních dat, P–P graf (2026-10-16)

Doplňky na žádost autora po revizi kapitoly:

- Nový oddíl `sec-hodnoty-zpameti` s tabulkou osmi hodnot z (1; 1,645;
  1,960; 2; 2,326; 2,576; 3; 3,291), podíly v jednom chvostu a uprostřed
  a zápisem kvantilu. Výchozí podklad dodal autor; opraveno 99,74 % na
  99,73 %, sloupec „Kvantil“ přejmenován na podíl (kvantil je hodnota),
  zrušeny zdvojené záporné řádky a hodnotící popisy. Studenti se hodnoty
  učí zpaměti (R40, výjimka v AGENTS.md).
- Zápis $z_p$ (podíl vlevo) v `sec-normalni-kvantil` s upozorněním na
  konvenci podílu vpravo v cizích textech a na $z_i$; nový řádek v přehledu
  značení (R41).
- Steny a staniny: tabulky mají kumulativní meze percentilového pořadí;
  nový pododdíl `sec-steny-nenormalni` porovnává lineární zařazení podle z
  se zařazením přes percentilové pořadí na 15 dobách z normalizace
  (podklady: autorova přednáška P03 sn. 58, GL Assessment).
- Nepovinné rozšíření `rozsireni-pp-graf`: konstrukce P–P grafu na 12
  skórech (list QQ, sloupec F a nový graf), srovnání s Q–Q na simulaci
  `sikme` (obrázek `fig-pp-qq-04`), shody, rozdíly, výhody a nevýhody;
  citace Nolan (2001), oddíl Diagnostics for assessing stability (ověřeno
  v plném textu přes scite). Wilk a Gnanadesikan (1968) nebyli citováni:
  plný text nebyl dostupný. Nový termín P–P graf ve slovníku a slovníčku.
- Generátor sešitů: bodové grafy mohou mít vlastní meze os (`xMin` atd.);
  výchozí osa −2 až 2 pro Q–Q se nemění (jiné kapitoly bodové grafy
  nepoužívají). Kontrola Excelu ověřuje sloupec F, vazby a osy P–P grafu.

Ověření: hodnoty v R (`check-chapter-04.R`, nově i tabulka hodnot,
kumulativní meze, staniny pro 15 dob a souřadnice P–P; 19 SVG); sešit
`build-workbooks.ps1 -Chapter 4 -Verify` a vizuální kontrola obou grafů
exportovaných z Excelu; render celé knihy a webové kontroly.

## Doplnění mapy zdrojů (2026-10-17)

Na žádost autora přidány zdrojové karty U13 (McElreath, druhé vydání),
P08–P13 (šest přednášek) a C06–C09 (čtyři soubory úloh). Inventář nyní
odpovídá všem 44 souborům v `sources/`; tematický rozcestník rozlišuje
porovnávání průměrů, korelace, kategoriální data a bayesovské modelování.
Aktualizována změněná P04 a cesta k nezměněnému C04 se zachováním ID
a starších nálezů. Kapitoly, osnovu kurzu ani původní podklady tato práce
nemění. Přesné lokátory, rozsah čtení, početní nálezy a omezení jsou
v jednotlivých kartách a v [historii kontroly](../docs/zdroje/HISTORIE.md#inventura-2026-10-17).

Ověření: `node scripts/check-doc-maps.cjs --require-sources` bez chyb;
samostatná kontrola pokrytí inventáře a všech 44 otisků SHA-256, rozsahů
snímků šesti nových prezentací a 17 kapitolových lokátorů U13; vybrané
výpočty v R 4.5.1; `git diff --check`. Vizuálně prohlédnuty obrazové
přehledy všech snímků P08–P13 a P04 a identifikační strany, obsah
a začátky kapitol U13. Úplné vykreslení čtyř DOCX a kontrola všech jejich
vložených obrázků zůstávají neověřené kvůli zablokovanému exportu Wordu.
Neproběhla úplná revize knihy ani všech řešení, animací a externích
demonstrací; Excel nebyl spuštěn. Změna je pouze autorská dokumentace,
proto se studentský web znovu nerenderoval. Do Gitu nepatří originály,
extrahované texty, obrazové exporty ani pomocné pracovní skripty v `tmp/`.


## 2026-10-23: Ruční PDF kapitoly 5

Stávající export rozšířen o explicitní volbu kapitoly 5 podle R31.
Krátké tabulky zůstávají na jedné straně; vzorce Excelu v tabulkách této
kapitoly mají menší písmo, aby nezasahovaly do výsledků. Zdroj kapitoly,
HTML konfigurace ani publikační workflow se nemění. Příkazy jsou
v [provozním návodu](../docs/PROVOZ.md#ruční-pdf-vybrané-kapitoly).

Výsledek má 40 stran: zadání na stranách 30–34, všech dvanáct úplných
řešení od strany 35, citovaná literatura na straně 40. Závěrečné přehledy
se nepřipojují. Prohlédnuto všech 40 stran, po úpravách znovu dotčené
strany; ověřeny interní cíle odkazů, dvanáct zpětných odkazů a absence
textu mimo stránku. Kontroly transformace pro kapitoly 3, 4 a 5 potvrdily
zachování řešení, rovnic, kódu, tabulek, obrázků a citací. Číselná kontrola
kapitoly 5 v čisté relaci R prošla včetně dvanácti úloh a dvanácti grafů.
Prošla kontrola dokumentačních odkazů a git diff --check.

Kapitoly 3 a 4 nebyly nově renderovány. HTML, Excel a dostupnost externích
URL nebyly znovu ověřovány. Typst úspěšně zkompiloval průniky množin,
ale u jejich automatického převodu vypisuje upozornění na zastaralý
alias `sect`; symboly byly ve výsledku zkontrolovány. PDF je pouze místní
ignorovaný výstup. Rozpracované změny prezentace kapitoly 4 a související
záznam historie byly zachovány a nejsou součástí této úpravy.

<a id="revize-kapitoly-5-2026-10-27"></a>

## 2026-10-27: Kapitola 5 podle autorových připomínek

Zapracováno 25 autorových připomínek a zachovány jeho redakční úpravy
kapitoly (dvě z nich jazykově dokončeny: věta o přímém výpočtu
„alespoň jednou“ a vymezení kombinace). Terminologii mění
[R52](../docs/rozhodnuti/kapitola-05.md#r52-terminologie-revize-kapitoly-5):
opačný jev (číslo 1 − P zůstává doplněk do jedné), prediktivní hodnota
pozitivního/negativního testu, úrovně „zvýšený“ a „nízký stres“ i ve
vzorcích. Navarro se cituje s rokem 2026 (doplněk
[R42](../docs/rozhodnuti/spolecne-konvence.md#r42-citace-dokumentace)).

Obsahové změny: úvody oddílů „Tento oddíl…“; četnostní pojetí jako hodnota,
k níž se relativní četnost ustaluje v nekonečné řadě; odstraněna předbíhající
věta o kartičkách; poznámka k okrajům čtyřpolní tabulky; odvození součinového
pravidla s krácením; obrácený směr nezávislosti (P(žena | úroveň stresu) = 0,50)
a odvození součinového tvaru ve třech krocích; přiřazení obou tabulek
k panelům obrázku nezávislosti; význam pozitivního a negativního výsledku;
nová tabulka čtyř kombinací stavu a výsledku (`tbl-ctyri-vysledky`) s hesly
správně pozitivní/negativní výsledek; přesnější vymezení přirozených četností
s kontrastem k normalizovaným četnostem a novým zdrojem
[E04](../docs/zdroje/E04-gigerenzer-hoffrage.md#e04-gigerenzer-hoffrage);
odstraněny metakomentáře o Baronovi a Uttsové; vysvětlení blízkosti šancí
a pravděpodobnosti u vzácných jevů; náhodná proměnná odlišena od rozdělení
a rozdělení navázáno na výběrový prostor; 2⁵ u počtu pětic; „nízká/vysoká“
místo „malá/velká“ pravděpodobnost. Strom má u větví popisky (prevalence,
senzitivita, specificita a jejich doplňky do jedné), graf kombinací řadí
způsoby po sloupcích. Upraveny sešit (záhlaví tabulek stresu, popisky
A16:A17 listu `Bayes`, popis listu `Karticky`), kontrola kapitoly, slovníček,
přehled značení, autorský registr, karta kapitoly, DATA.md a karty U08,
D07 a D08.

Ověření: `check-chapter-05.R` prošel včetně nové kontroly obráceného směru
nezávislosti. Upravených šest grafů bylo znovu vykresleno a prohlédnuto
(strom bez překryvů popisků). `build-workbooks.ps1 -Chapter 5 -Verify`
prošel v Excelu 16.0 (78 vzorců, pět záměrných chybových případů, kontrola
chyb vzorců všech sedmi sešitů); nové popisky ověřeny v uloženém XLSX.
Celá kniha vykreslena; `check-html.cjs` prošel bez chyb (12 stránek, 262
řádků přehledů, 83 řešení, šířky 1360/1920/390 px). Vizuálně prohlédnuty
oddíly o součinovém pravidle a screeningu na šířce 390 px a oddíl
o nezávislosti na desktopu; ověřeny citace Navarro (2026) a Gigerenzer
a Hoffrage (1995) i v seznamu literatury. Prošla `check-doc-maps.cjs`
a `git diff --check`.

Omezení: tištěné číslo strany citovaného oddílu Gigerenzera a Hoffrage
neověřeno (citace používá název oddílu). Rok Navarro 2026 je redakční volba,
ne doložené datum vydání. PDF export kapitoly nebyl znovu vytvořen.
Didaktická revize proběhla interně jen u dotčených míst, nikoli na studentech.

### Doplnění 2026-10-27: diagram od pokusu k rozdělení

Na podnět autora (vlastní návrh diagramu se dvěma otázkami) přidán obrázek
`fig-od-pokusu-k-rozdeleni` do oddílu Od jevů k číslům. Proti návrhu je
použita pravděpodobnost úspěchu 0,25, aby výsledky nebyly stejně
pravděpodobné a navazovaly na čtyři možnosti v celé kapitole. Podle autora
doplněna pravděpodobnost jevu A a rovnost P(A) = P(X = 1), popisek hodnot
náhodné proměnné odlišený od pravidla X a součty 1 u výběrového prostoru
(jistý jev) i u rozdělení. Průvodní text čte obrázek shora dolů; nové pojmy
ani značky se nezavádějí. Kontrola kapitoly ověřuje čtyři pravděpodobnosti
výsledků, rozdělení podle dbinom a počet 13 grafů. Obrázek byl vykreslen
a vizuálně prohlédnut (bez křížení šipek a překryvů popisků); render a
kontrola webu: kapitola 5 vykreslena, check-html.cjs prošel bez chyb
(očekávaný počet obrázků kapitoly zvýšen na 13); obrázek prohlédnut na
šířce 390 px (vodorovný posun uvnitř obrázku jako u ostatních, stránka
nepřetéká).

## 2026-10-30 — Jednotná sazba tabulek a česká typografie PDF

Podle [R54](../docs/rozhodnuti/spolecne-konvence.md#r54-sazba-tabulek-pdf)
doplněny popisky všech 86 tabulek kapitol 1–7, včetně čtyř odsazených
tabulek v řešeních, a číslování tří referenčních přehledů (celkem 89 tabulek).
Existující ID zachována; vysvětlující části dlouhých popisků přesunuty pod
tabulky. Nové názvy zkontrolovány podle buněk a okolního textu. Čísla
a názvy jsou nad tabulkou, vlevo, na samostatných řádcích, tučně a kurzivou.
Silnější krajní a slabší vnitřní linky nahrazují podbarvení; souhrny mají
silnější horní linku. Číselné sloupce bez výslovného zarovnání filtr
rozpoznává konzervativně podle všech nesouhrnných hodnot.

PDF filtr převádí desetinné literály na atomická čísla (i ve zlomcích
a indexech), zachovává oddělovací čárky a váže jednopísmenná česká slova
i přes změnu řezu. Tabulky nejsou zarovnány do bloku a nedělí slova.
Opravena také kolize prázdné kotvy `populacni-parametry` s předcházejícím
nadpisem v PDF kapitoly 3; obě cílové kotvy zůstávají dostupné. Po citeprocu
se zvlášť váže slovo před odkazem v bibliografii. PDF export používá
balíčky a fonty z Quarta i při závěrečném překladu.

**Provedené kontroly:** celá HTML kniha sestavena; konečný
`quarto/_verification/check-html.cjs` prošel na všech 12 stránkách bez chyb
(89 tabulek s popisky, 262 hesel slovníčku, odkazy, 83 řešení včetně
ovládání klávesnicí, přehledy, šířky 1360/1920 a mobil 390 px, bez JS
a file://). Vizuálně zkontrolovány výsledné webové tabulky a přehledy na
desktopu i mobilu; popisky vlevo. Porovnání Pandoc AST s výchozím commitem
potvrdilo stejné buňky a záhlaví všech 86 tabulek, stejná zdrojová zarovnání
a všechny původní matematické výrazy (přesun vysvětlení změnil pouze pořadí).
`check-pdf-typography.cjs` prošel; `check-chapter-pdf.cjs` pro 3/4/5
potvrdil zachování 15/10/12 řešení, matematiky, tabulek, obrázků a citací.
Kontrola dokumentace: 73 mapových souborů, 54 rozhodnutí, 2 985 místních
odkazů, bez chyb (po doplnění této historie 2 986); `git diff --check` bez chyb.

**PDF a vizuální rozsah:** aktuální kapitoly 3/4/5 mají 50/37/43 stran.
Prohlédnuty kontaktní náhledy všech stran s tabulkami a vybrané stránky
ve větším rozlišení (souhrny, široké tabulky, kvantily, desetinné zápisy
a závěrečná bibliografie kapitoly 3). Textová kontrola všech stran nenašla
osamocenou českou jednopísmennou předložku či spojku; zůstal anglický člen
„A“ v názvu bibliografické položky kapitoly 4, mimo české pravidlo.
Nešlo o novou odbornou revizi kapitol ani nové spuštění výpočtů v Excelu.
Typst u kapitoly 5 nadále hlásí upozornění na zastaralý alias `sect`
generovaný Pandocem; kompilace uspěla a znak průniku se vykresluje.
PDF se nepublikují s webem; veřejné nasazení této úpravy nebylo ověřováno.

## 2026-10-30 — Jemnější linky, menší poznámky a PDF kapitoly 6

Podle doplnění [R54](../docs/rozhodnuti/spolecne-konvence.md#r54-sazba-tabulek-pdf)
mají vnitřní linky společnou šedou `#c8c8c8`, při původní tloušťce.
Šest poznámek pod tabulkami dostalo třídu `table-note`; jsou o 1 pt menší
než běžný text (v PDF 10 místo 11 pt). Obsah, matematika a tabulkové buňky
zůstaly zachované, což potvrdilo nezávislé porovnání AST všech 86 tabulek.

Tabulka úrovní měření má minimum 700 px, které na desktopu může ustoupit
dostupné šířce (při šířce okna 1280 px má sloupec jen 678 px). U sedmi
dalších tabulek s malým mobilním přesahem zmenšeno pouze vodorovné odsazení
buněk, bez zásahu do písma. Výslovně rozbalené řešení kapitoly 6 odhalilo
také přetékající řádkový výpočet; vodorovné posouvání jeho odstavce nyní
zachovává stránku v šířce obrazovky, bez přepsání vzorce.

Ruční export a kontrola rozšířeny na kapitolu 6. PDF má 50 stran, zadání
na stranách 37–42, řešení od strany 43 a literaturu na straně 50.
Prohlédnuty kontaktní náhledy všech 50 stran i detail široké excelové
tabulky; PDF kapitol 3–5 také obnovena (50/37/43 stran) a dotčená sazba
prohlédnuta. Původní varování Pandocu/Typstu na alias `sect` v kapitole 5
nebrání kompilaci; tato změna je neopravuje.

**Kontroly:** celá kniha vykreslena. `check-table-layout.cjs` provedl
66 měření na 11 stránkách v šířkách 1024/1280/1360/1440/1920/390 px,
včetně rozbalených řešení: žádné drobné přesahy 2–32 px ani přetékání
stránky, správná barva linek a poznámky menší o 1 pt. Vizuálně zkontrolována
tabulka 1.3 bez posuvníku. Následný `check-html.cjs` prošel na všech
12 stránkách: odkazy, 262 hesel, 83 řešení, klávesnice, přehledy, mobil,
varianta bez JavaScriptu a file://. Nová kontrola šířek je také v CI.
`check-chapter-pdf.cjs` prošel pro 3/4/5/6 (15/10/12/14 řešení),
`check-pdf-typography.cjs` ověřil také nastavení poznámek.
`check-rendered-pdf.py` přímo v hotových PDF ověřil velikost všech čtyř
exportovaných poznámek na 10 pt a šedé tahy ve všech čtyřech PDF.
Kontrola dokumentace (73 souborů, 54 rozhodnutí, 2 989 odkazů) a
`git diff --check` prošly. Výpočty, data ani sešity se neměnily;
nejde o novou odbornou revizi kapitol. Nasazení na veřejný web neověřováno.

<a id="reliabilita-validita-01"></a>

## 2026-10-31 — Kapitola 1: rozsah konstruktu, reliabilita a validita měření

Podle [R55](../docs/rozhodnuti/kapitola-01.md#r55-reliabilita-validita)
přibyl v oddílu o měření pododdíl „Co ukazatel zachytí a co ne“ s vlastním
schématem vnořených oblastí (inspirace Billiet 2016, obr. 14.1) a v oddílu
o chybě a nejistotě pododdíl „Reliabilita a validita měření“ se čtyřmi
vlastními terči, častým omylem a nepovinným rozšířením o druzích reliability
a dokladech validity. Nová úloha 9 s úplným řešením; doplněn cíl kapitoly
a věta shrnutí. Kapitola 7 (oddíl o mezích ekvivalence) nyní odkazuje na
výklad reliability. Dvě hesla slovníčku a registru, bibliografie Billiet
a Field. Odchylka od plánu: pododdíl o reliabilitě je na konci oddílu
o nejistotě, ne hned za systematickým zkreslením, aby nepohltil navazující
výklad výběrové variability.

Opory čteny v textové extrakci: Cumming s. 25–26, Field s. 13–15 (nález
v kartě U14), Navarro §2.3, Billiet s. 197–206, Borsboom a Mellenbergh
(2002) s. 507–508 v autorském PDF. Obrázek 14.1 viděn jen na výřezu od autora.

**Kontroly:** oba diagramy vygenerovány `scripts/kapitola_01.R` a vizuálně
prohlédnuty; celá kniha vykreslena; `check-html.cjs` prošel na 12 stránkách
(264 hesel, 84 řešení, mobil, bez JavaScriptu, file://), očekávané počty
obrázků, oblastí a řešení kapitoly 1 v něm aktualizovány.
`check-chapter-01.R` a `check-doc-maps.cjs --require-sources` prošly.
Žádná věta nových pasáží nepřesahuje 30 slov; povinná část kapitoly má
přibližně 10 400 slov. Didaktická revize provedena autorsky, nikoli
samostatným agentem v roli studenta ani na studentech. Sešit kapitoly
se nemění (úloha 9 je slovní). Excel ani PDF neověřovány.

<a id="revize-kapitola-06-2026-10-31"></a>

## 2026-10-31 — Kapitola 6: revize podle autorových připomínek

Zachovány a zkontrolovány autorovy stylistické úpravy kapitoly 6; opraveny
v nich zdvojené slovo, nedokončená věta u obrázku trychtýře, překlepy
(„pupulační“, „významosti“), pády a shoda („samo o sobě“, „při u“,
„výzkumném designu“), čárka ve vylučovacím poměru, chybějící zvratné „se“,
nepravopisné „NEzávisí“ a slovo „důkaz“ (podle autorovy volby). Zpřesněno
doplněné zdůvodnění odmocniny (klesá poměr 1/√n) a odpověď u rozdílu
o více než 3 s kterýmkoli směrem. Opraven popisek tabulky výpočtu síly
(`tbl-k06-14`).

Nově vysvětleno podle připomínek: proč stačí 10 000 opakování simulace,
platnost hodnocení 15 s / 1,5 s jen pro výukový model, odhad (ne znalost)
směrodatné chyby, proč má medián větší směrodatnou chybu a proč je
rozdělení výběrové směrodatné odchylky zešikmené, obě hypotézy jako
statistické hypotézy, oboustranný test i při směrové hypotéze (intervence,
která by mohla škodit), důvod slabé výpovědi nezamítnutí při síle 0,29,
na čem závisejí kritické hodnoty, *p*-hodnota jako nejnižší hladina
významnosti a Cohenova pásma s jeho výhradou (Howell, s. 214 a 235).
Zákon velkých čísel v dřívějších kapitolách jménem nezazní; tvrzení textu
ověřeno vyhledáním ve všech kapitolách.

Podle [R56](../docs/rozhodnuti/kapitola-06.md#r56-p-hodnota-cohen) se
*p*-hodnota píše s kurzivním *p* v kapitolách 6 a 7, ve slovníčku,
v přehledu značení a Excelu a v popiscích grafů `p-hodnota`, `stejny-rozdil`,
`dva-testy` (kap. 6) a `p-funkce` (kap. 7). Převod provedl skript
s vynecháním kódu, matematiky, identifikátorů a cest; atributy alternativních
textů jen převedeny na malé p (markdown v nich nefunguje). Stylistické
náhrady jen v kapitole 6: „Oddíl …“ → „Tento oddíl …“ v deseti úvodech,
rozptýlenost → variabilita, matematický „vzorec“ → „rovnice“ (excelový
vzorec ponechán), na šesti místech „kolísat“ → „různit se“; podstatné jméno
„kolísání“ a časové kolísání *p*-hodnoty ponechány. Ostatní kapitoly
těmito náhradami neprocházely. Popisek „pozorováno 51“ na obrázku
`stejny-rozdil` přesunut, aby nepřekrýval křivku ani údaje o *p*-hodnotě.

**Kontroly:** Monte Carlo přesnost při 10 000 opakováních ověřena v R
(typická odchylka středu i šířky 0,02–0,03 s; v nezávislé simulaci směrodatné chyby mediánu
3,24 s a směrodatné odchylky 2,38 s, šikmost jejího rozdělení 0,42).
Celá kniha vykreslena; `check-chapter-06.R`, `check-chapter-07.R`,
`check-html.cjs` (12 stránek, 264 hesel, 84 řešení, mobil 390 px)
a `check-doc-maps.cjs --require-sources` prošly. V prohlížeči prohlédnuty
upravené grafy, nadpis a obsah s kurzivním *p* a rozbalené rozšíření
s Cohenovými pásmy; ve vykreslených stránkách nezůstalo neformátované
`*p*` ani „P-hodnota“. Didaktická revize nových pasáží provedena autorsky
(délka vět, návaznost, žádné nové nevysvětlené pojmy), nikoli samostatným
agentem v roli studenta ani na studentech.

**Omezení:** popisky buněk v sešitech `kapitola_06.xlsx` a `kapitola_07.xlsx`
zůstávají prostým textem („P-hodnota …“); kurziva části buňky by vyžadovala
úpravu generátoru. Excel ani PDF nebyly ověřovány; zadání a řešení cvičení
se obsahově nezměnila. Cohenovy původní práce nebyly čteny, pásma se opírají
o Howellův výklad.

<a id="rozsireni-p-hodnoty-kapitola-06-2026-11-01"></a>

## 2026-11-01 — Kapitola 6: rozdělení *p*-hodnot a mylné představy

Podle [R57](../docs/rozhodnuti/kapitola-06.md#r57-rozdeleni-p-omyly) přidána
dvě nepovinná rozšíření: `#rozsireni-rozdeleni-p` za výpočtem síly
(rovnoměrné rozdělení *p*-hodnot za H0, P(*p* ≤ *c*) jako síla na hladině *c*,
obrázek `rozdeleni-p` pro 0, 3, 5 a 8 s, tabulka pásem `tbl-k06-25`,
jev těsně významných *p*-hodnot při vysoké síle, varianta se 400 řidiči
a úvaha o hladině 0,01) a `#rozsireni-omyly-p` v mezích testování (tabulka
sedmi mylných výroků `tbl-k06-26`). Nová nepovinná cvičení 15 a 16 (tabulka
řešení `tbl-k06-27`), vstupní listy `U15_vyroky` a `U16_rozdeleni_p`,
bibliografické položky `lakens2026` (verze 1.6.3, bez DOI) a `kline2023`.
Oporou jsou [U16](../docs/zdroje/U16-lakens-kniha.md#u16-pouziti-kapitola-06)
a [D13](../docs/zdroje/D13-kline.md#d13-pouziti-kapitola-06); příklady
a čísla jsou vlastní na modelech kapitoly. Povinný text, starší cvičení
a ostatní listy sešitu se nezměnily.

**Kontroly:** všechna nová čísla ověřena v `check-chapter-06.R` nezávislým
výpočtem (pásma, síla na hladinách 0,04 a 0,01, zvrat kolem síly 0,95,
řešení cvičení 15 a 16); text cvičení 16 opraven z „asi 25krát“ na „více než
dvacetkrát“ podle přesného poměru 23,5. Sešit přestavěn
`build-workbooks.ps1 -Chapter 6 -Verify`: 28 listů; kontrola Excelu porovnala
47 uložených výsledků, 34 českých vzorců (nově vzorec *p*-hodnoty z cvičení 15)
a 15 změn vstupů (nově hladina v B5 listu `Sila` a směrodatné chyby 1; 1,0607;
1,25). Porovnání XML buněk s předchozí verzí sešitu: změněny jen nové listy
a posunuté řádky listu `Prehled`. Celá kniha vykreslena; `check-html.cjs`
(upravené počty: 16 řešení a 17 obrázků kapitoly 6, nový obrázek ve sbaleném
rozšíření rozbalen klávesnicí, mobil 390 px) a `check-doc-maps.cjs
--require-sources` prošly. Vizuálně prohlédnut nový graf a rozbalené
rozšíření; kotvy oddílů webové verze Lakense ověřeny. Didaktická revize
autorsky (délka vět, návaznost, žádné nové povinné pojmy; tři formulace
zpřesněny), nikoli samostatným agentem v roli studenta ani na studentech.

**Omezení:** nové listy sešitu nebyly prohlédnuty v Excelu vizuálně,
ověřen jen obsah buněk. Pracovní PDF kapitoly 6 nebylo znovu exportováno.
Primární literatura citovaná Lakensem a Klinem (Lindley, Haller a Krauss,
Morey et al.) nebyla čtena.

## 2026-11-01 — Zvětšení obrázků kliknutím (lightbox) na webu

Na autorův dotaz zapnut vestavěný lightbox Quarta (GLightbox) v `_quarto.yml`
pro HTML: `match: auto` (všechny obrázky bez úprav kapitol), efekt `zoom`,
titulek obrázku pod zvětšeninou, bez procházení dalších obrázků. Všech
105 obrázků kapitol 1–7 je SVG s vlastní šířkou jen 396–756 px, takže je
lightbox zobrazoval menší než na stránce; `assets/styles.css` proto SVG
v lightboxu roztáhne na šířku okna (nejvýše 1100 px, výšku dál omezuje
GLightbox, proporce drží `viewBox`) a skryje neaktivní šipky galerie
(každý obrázek je samostatná galerie). PDF se nemění; výjimku lze vytvořit
třídou `.nolightbox`. Nové rozhodnutí v registru nezaloženo (technické
nastavení webu bez dopadu na obsah či značení).

**Kontroly:** celá kniha vykreslena; `check-html.cjs` s novým testem
v kapitole 4 (každý obrázek má odkaz lightboxu, kliknutí otevře týž soubor
s titulkem, zvětšenina je větší než obrázek na stránce, žádné viditelné
šipky, Escape lightbox zavře) prošel celý. Vizuálně prohlédnut obrázek 4.5
v lightboxu na desktopu (1360 px) a mobilu (375 px): celý graf čitelně
na šířku obrazovky, titulek pod ním. Počet odkazů lightboxu ověřen
proti počtu obrázků na každé stránce.

**Omezení:** přiblížení prsty a zavření klepnutím mimo obrázek na skutečném
telefonu ani čtečkou obrazovky nebyly vyzkoušeny; ovládací prvky GLightboxu
mají anglické popisky pro čtečky.

## 2026-11-01 — Název učebnice a kapitoly 3, odstup popisků os v grafech kapitoly 3

Podle [R58](../docs/rozhodnuti/spolecne-konvence.md#r58-nazvy-knihy-a-kapitol)
nese učebnice název „Základy statistiky pro psychology“ (`_quarto.yml`,
kořenové README, LICENSE-TEXT včetně doporučené citace, záhlaví pracovních
PDF v `scripts/pdf/layout.typ`, nadpis AGENTS.md). Popis kurzu „… 1“ zůstal.
Kapitola 3 se jmenuje „Ukazatele polohy, variability a tvaru“ (nadpis,
textový odkaz z kapitoly 4, mapa obsahu a karta kapitoly); ID
`#sec-kapitola-03` beze změny.

V grafech `entropie` a `stejne-dve-statistiky` se svislý popisek osy y
překrýval s vodorovnými hodnotami („0,10“, „0,25“): společné `mgp` 2,1 řádku
nestačilo. Popisek osy y se nyní kreslí samostatně (`title(..., line=)`)
a levý okraj je širší; osa x a ostatní grafy beze změny.

**Kontroly:** `check-chapter-03.R` prošel (výpočty beze změny). Všech
16 vlastních SVG kapitoly 3 převedeno do PNG a vizuálně prohlédnuto; překryv
odstraněn, jinde žádný nenalezen. Celá kniha vykreslena; ověřen titul
webu, nadpis kapitoly 3, odkaz z kapitoly 4 a shoda publikovaných SVG.
`check-html.cjs` (včetně mobilu 390 px) a `check-doc-maps.cjs
--require-sources` prošly.

**Omezení:** pracovní PDF kapitol nebyla znovu exportována (změna záhlaví
se projeví při dalším ručním exportu). Grafy ostatních kapitol nebyly
na obdobný překryv procházeny.

<a id="dohoda-kapitola-08"></a>

## Kapitola 8: dohoda o obsahu (2026-11-01)

Na otázku, jaký má být obsah kapitoly 8, byl navržen výklad porovnání dvou
průměrů (párová data a dvě nezávislé skupiny) podle Howella, §7.4–7.6.
První verzi autor vrátil s připomínkami: přínos párování formulovat
podmíněně (zachované pořadí osob nestačí, kontrastní příklad trojnásobných
hodnot) a změnit nadpis na „Kdy párování zpřesňuje odhad — a co neřeší“;
v oddílu o intervalech neuvádět obecný vztah šířek ani tvrzení, že intervaly
podmínek o párovém rozdílu „nevypovídají vůbec“, a nezařazovat pravidlo
překryvu; vyložit nejprve klasický test se společným rozptylem a potom
Welchovu variantu; u anorexie odlišit párovou analýzu sedmnácti dívek od
kontrolní skupiny zmíněné Howellem (s. 200) a použít kilogramy; omezit plně
rozpracované příklady (hrozba stereotypu jen do cvičení); přidat řešený
příklad porovnání změn ve dvou skupinách s přesnější formulací místo hesla
o rozdílu významností; povinně základní práci s chybějícími párovými údaji;
Cohenovo d povinně pro nezávislé skupiny, u párových dat jen význam volby
jmenovatele; ověřit neceločíselné Welchovy stupně volnosti v Excelu
(T.INV a T.DIST.2T je zkracují, T.TEST typu 3 ne). Druhou verzi doplnil
poznámkami ke zdrojům (Howell, Cumming, Wilcox, P08 sn. 30, P09 sn. 25,
C08) a k odlišné standardizaci párového rozdílu ve zdrojích; třetí verzi
schválil. Dohodu eviduje
[R59](../docs/rozhodnuti/kapitola-08.md#r59-rozsah-kapitoly-8)–[R61](../docs/rozhodnuti/kapitola-08.md#r61-terminologie-kapitoly-8);
čtení zdrojů [záznam z 2026-11-01](../docs/zdroje/HISTORIE.md#priprava-08-20261101).
Kapitola zatím napsána není.

<a id="vytvoreni-kapitoly-8"></a>

## Kapitola 8: vytvoření výkladu (2026-11-01)

Podle dohody [R59](../docs/rozhodnuti/kapitola-08.md#r59-rozsah-kapitoly-8)–[R61](../docs/rozhodnuti/kapitola-08.md#r61-terminologie-kapitoly-8)
vznikla kapitola `quarto/kapitola_08.qmd` s dvanácti hlavními oddíly, sedmi
obrázky, třemi nepovinnými rozšířeními a čtrnácti cvičeními (dvanáct
základních, dvě nepovinná), sešit `data/kapitola_08.xlsx` (20 listů,
generátor `scripts/kapitola_08-sešit.mjs`), skript `scripts/kapitola_08.R`,
14 hesel slovníčku a registru, sedm řádků přehledu značení (upraveny řádky
směrodatné chyby rozdílu a *d*) a čtyři funkce Excelu (JE.ČISLO, A, T.TEST,
BETA.INV; u T.INV a T.DIST.2T doplněna poznámka o zkracování stupňů volnosti).
Do bibliografie přibyl Gelman a Stern (2006), zdrojová karta E05.

### Odborná a didaktická rozhodnutí při psaní

- **Členění.** Schválený oddíl 11 je rozdělen na ekvivalenci dvou skupin
  a volbu postupu se sdělením; oddíl o změnách ve dvou skupinách je před
  ekvivalencí. Odchylka je zapsána v kartě kapitoly.
- **Data.** Varianta A (13 studentů, student 9 bez druhého měření) je
  autorsky zvolena tak, aby párová a chybná nezávislá analýza vedly
  k odlišným závěrům; text to uvádí jako výsledek konkrétního příkladu.
  Data varianty B byla jednou vylosována (seed 20261189) ze seedů 20261101
  až 20261200 podle kritéria: klasický test *p* < 0,04, Welchův *p* > 0,06,
  kulaté souhrny. Výběr podle výsledku je záměrný, data ilustrují rozdíl
  postupů; uložena jsou jako pevné hodnoty.
- **Excel a Welch.** V českém Excelu 16 ověřeno, že T.INV.2T(0,05;13,97)
  i T.DIST.2T(2;13,97) dávají totéž co se 13 stupni volnosti, kdežto
  vzorec s BETA.INV a T.TEST typu 3 počítají s neceločíselnými stupni
  volnosti (shoda s R: kvantil 2,145219, *p*-hodnota 0,3160032 na testovacích
  datech). T.TEST typu 1 vynechává neúplné dvojice sám; text na to
  upozorňuje, ale výpočet staví na explicitním výběru úplných dvojic
  (JE.ČISLO, A, KDYŽ). Funkce PRŮMĚRKDYŽ v českém Excelu s tímto názvem
  nefungovala, proto se nepoužívá.
- **Intervaly vedle sebe.** Obecný vztah šířek se neuvádí; text ukazuje
  mezní chyby konkrétního příkladu (4,13 + 4,13 vs. 5,69). Zjištěno při
  revizi, že tvrzení „mezní chyba rozdílu je vždy menší než součet“ obecně
  neplatí (u velmi malé skupiny může kvantil rozdílu převážit); ve cvičení 8
  je proto podmíněno podobnými skupinami.
- **Hedgesova korekce** je v nepovinném bloku uvedena aproximací
  $1-3/(4v-1)$ bez citace původní práce.

### Ověření

`check-chapter-08.R` (všechna citovaná čísla, porovnání s `t.test`,
pravděpodobnosti přes neúplnou funkci beta); `check-chapter-08-excel.ps1`
v samostatném skrytém Excelu (82 uložených výsledků, 32 vzorců z textu,
3 chybové vstupy, 59 výsledků po změně vstupů, 12 popisků, přesná hranice
ekvivalence, prázdné buňky neúplné dvojice); `check-workbooks.py` (vstupy
a odkazy všech osmi sešitů); render celé knihy bez varování;
`check-html.cjs` (včetně nové kontroly kapitoly 8, mobilu a stavu bez
JavaScriptu); `check-doc-maps.cjs`. Vizuálně prohlédnuto všech sedm SVG
a snímky oddílů s excelovými tabulkami. **Neověřeno:** pracovní PDF
kapitoly 8 (nebylo vyžádáno); didaktická revize provedena autorsky čtením
očima začátečníka, ne samostatným agentem ani na studentech; Cumminga
a Wilcoxe četl autor, při psaní nebyli znovu čteni ani citováni; obrazy
Howellových tabulek 7.6 a 7.7 nebyly prohlédnuty (čteno v textové extrakci).
Tab. 7.3 a s. 200 byly ověřeny v obrazu originálu (s. 199–200, PDF 223–224).

<a id="revize-kapitoly-8"></a>

## Kapitola 8: opravy po odborné revizi (2026-11-01)

Na výslovný souhlas autora s implementací nálezů opraveny: otázka a řešení 4c (trojnásobné hodnoty dokládají vztah SD, nikoli nižší přesnost párového odhadu); interpretace chybné nezávislé analýzy; popis náhodného přiřazení ve variantě B; chybění a jeho možné zkreslení; vyvážení pořadí; sčítání rozptylů a definice jejich shody; výběr účastníků a omezení odolnosti testů; kauzální interpretace odhadu i při nevýznamném výsledku; meze závěru ekvivalence; výklad Welchových stupňů volnosti. Zachovány číselné vstupy, schválené značení a hranice povinného/nepovinného učiva. Doplněno vysvětlení A/AND, jazykové opravy a zdroje Wilcox (2017) a Lakens (2013); evidence čtení je ve zdrojových kartách.

V přehledu značení odstraněno chybné s s indexem průměru jako alternativa k SD rozdílů. Popis anorexie v generátoru a sešitu odlišuje párovou analýzu od celé studie s kontrolní skupinou. Malé místní přesahy tabulek 8.7 a mobilních 8.1/8.8 řeší cíleně menší odsazení buněk. Aktualizována karta kapitoly, datová mapa a zdrojové vazby. Nová konvence ani nové ID rozhodnutí nevznikly.

**Ověření po implementaci:** `check-chapter-08.R` prošel v R 4.5.1, včetně doplněného rozlišení SD a SE u trojnásobných hodnot a kontrastu 31,9 proti 40 Welchovým stupňům volnosti. Generátor obnovil všech 20 listů v českém Excelu 16; kapitolová kontrola prošla (82 výsledků, 32 českých vzorců, 3 chybové vstupy, 59 přepočtených výsledků, 12 popisků, 3 rozhodnutí na hranici, 8 místních vzorců). Kontrola chyb vzorců všech osmi sešitů prošla. Porovnání všech buněk s verzí v Gitu potvrdilo zachování pořadí listů, čísel, typů, vzorců i stylů; liší se pouze dva schválené popisy (`Prehled!C11`, `Anorexie!D2`). Vizuálně ověřeny oba celé popisy v náhledu z Excelu; první delší verze byla zkrácena kvůli ořezu v přehledu.

Celá kniha vykreslena bez varování; `check-html.cjs` prošel na 13 stránkách (100 řešení, z toho 14 v kapitole 8; klávesnice, odkazy, přehledy, mobil, stav bez JavaScriptu). Po závěrečném doladění odsazení znovu vykreslena celá kniha; rozložení tabulek zkontrolováno na šířkách 1024/1280/1360/1440/1920 a 390 px. U kapitoly 8 nejsou malé místní přesahy ani přetékání stránky; ověřeno také otevření tabulky 8.7 přes file:// po načtení písma. Dva dřívější malé místní mobilní přesahy tabulek kapitoly 6 zůstávají mimo rozsah této opravy. Prošly `check-workbooks.py` (včetně shody publikovaných XLSX) a `check-doc-maps.cjs --require-sources`. Nové citace a literatura byly zkontrolovány ve vykresleném HTML, dotčené tabulky a listy i vizuálně. Didaktická kontrola dotčených pasáží a řešení proběhla autorským čtením z hlediska začátečníka.

**Meze:** nejde o test porozumění na studentech ani o reprodukci původních výzkumů. Jiné verze Excelu, veřejné nasazení a pracovní PDF kapitoly 8 nebyly ověřovány; PDF kapitoly nebylo vyžádáno. Původní Hedgesova práce nebyla čtena; rovnice korekce byla ověřena v metodickém článku Lakense (2013), viz zdrojová karta E06.

## 2026-11-01 — Jednotná podoba Shrnutí v kapitolách 1 a 2

Kapitoly 1 a 2 měly shrnutí v souvislých odstavcích bez odkazů (kap. 1
s jediným odkazem a přechodovou větou ke kap. 2), kapitoly 3–7 úvodní větu
a odrážky s odkazy. Podle upřesnění
[R38](../docs/rozhodnuti/postupy-a-dokumentace.md#r38-citelnost-textu)
převedeny `#sec-shrnuti-01` a `#sec-shrnuti-02` na úvodní větu a sedm
odrážek s odkazy na oddíly. Obsah převzat ze stávajících shrnutí; doplněny
jen myšlenky odkazovaných oddílů, které ve starém shrnutí chyběly (u kap. 2
sumace, intervalové třídění a kontrola grafů), formulované podle výkladu.
Přechodová věta ke kap. 2 vypuštěna. Forma Shrnutí doplněna do AGENTS.md
(oddíl Čitelnost); karty kapitol 1 a 2 aktualizovány.

**Kontroly:** každá odrážka porovnána s úvodem odkazovaného oddílu; nejdelší
věta 24 slov, žádný nový pojem. Celá kniha vykreslena; ve vykreslených
kapitolách 1 a 2 ověřeno sedm odrážek, úvodní věta, existence všech cílů
odkazů a MathML znaku sumace. `check-html.cjs` a `check-doc-maps.cjs
--require-sources` prošly. Didaktická revize autorsky, ne samostatným
agentem v roli studenta. Vzhled se styly webu prohlédnut nebyl (náhled
souboru se vykreslil bez CSS); podoba odpovídá kapitolám 3–7.

## 2026-11-04 — Pomocné grafy statistické síly k úloze 4 prezentace kapitoly 6

K úloze 4 na slidu 36 prezentace kapitoly 6 („Co se stane se silou?“)
vytvořen samostatný soubor `presentations/kapitola_06_uloha_4_sila_grafy.pdf`
(formát 16 : 9, jedna strana = jeden graf). Prezentace ani poznámky
upravovány nebyly. Generátor `scripts/kapitola_06-prezentace-sila.R` (základní
R, bez balíčků) používá normální model kapitoly: σ = 15 s, 100 řidičů ve
skupině, směrodatná chyba rozdílu 2,12 s, skutečný rozdíl 5 s.

Strany: výchozí stav a varianty a)–e) (e) zvlášť pro směr „déle“ a „kratší“)
s výběrovým rozdělením rozdílu průměrů pod H₀ a pod konkrétní alternativou
H₁. Pod H₁ je síla vybarvena oranžově a β světle modře, α pod H₀ šrafováním
(aby nezakrývalo sílu). Kritické hodnoty jsou vyznačeny přerušovanou čarou;
pravý panel uvádí α, β, sílu a změnu oproti výchozímu stavu. Poslední strana
srovnává sílu a β ve všech situacích. Značení H₀/H₁ a kurzivní *m* podle
učebnice; barvy podle grafů kapitoly 6.

V poznámkách ke slidu chybí číselná hodnota pro variantu c); graf proto
používá ilustrativní σ = 12 s a na straně to výslovně uvádí.

**Kontroly:** síla 0,654 / 0,413 / 0,915 / 0,838 / 0,293 / 0,762 / < 0,001
souhlasí s hodnotami v poznámkách ke slidu (0,65; 0,41; 0,92; 0,29; 0,76;
téměř 0) i v kapitole. Všech osm stran vizuálně prohlédnuto (pdftoppm
a PDF prohlížeč Chromia): bez překryvů popisků navzájem i s křivkami
a čarami, diakritika a dolní indexy v pořádku. Starý `pdftoppm` vykresluje
čárkované čáry jako duté obrysy, v Chromiu jsou plné. Vložení grafů do PPTX
nebylo součástí úkolu a nebylo ověřeno v PowerPointu.

## 2026-11-04 — Pomocné grafy k excelovým cvičením prezentace kapitoly 6

K sešitu `presentations/kapitola_06_vyberove_rozdeleni_a_testovani_cviceni.xlsx`
vytvořen soubor `presentations/kapitola_06_vyberove_rozdeleni_a_testovani_cviceni_grafy.pdf`
(16 : 9, jedna strana = jeden graf, 13 stran). Sešit ani prezentace upravovány
nebyly. Generátor `scripts/kapitola_06-prezentace-cviceni-grafy.R` čte vstupy
přímo ze sešitu (balíček readxl), takže grafy sledují jeho data; vzhled
navazuje na grafy statistické síly k úloze 4 na slidu 36.

Grafy jsou jen u částí, kde ukazují, na co se úloha ptá:

- U1 c): četnosti 100 číslic proti očekávaným 10; histogram 50 průměrů
  (intervaly jako v M57:N63) s normální křivkou podle centrální limitní věty.
  U1 d): normální modely průměrů po 5 a po 15 číslicích nad populací číslic.
- U2 a): plocha pod normální křivkou do 490 bodů s osou z-skórů. U2 b):
  useknuté rozdělení přijatých v **ilustrativním modelu uchazečů** (průměr 590,
  SD 80, přijetí od 580; dává přijaté s průměrem ≈ 648 a SD ≈ 50). Model
  není v zadání a graf to výslovně uvádí. U2 c): plocha do průměru 630 pod
  výběrovým rozdělením průměru proti rozdělení jednotlivců. U2 d): prostředních
  95 % jednotlivců a průměrů.
- U3 b), c): binomické rozdělení při π = 0,5 s kritickým oborem 0–39 a 61–100
  a p-hodnotou. U3 e): menší chvost při π = 0,75 a srovnání rozdělení pro
  π = 0,5; 2/3; 0,75 s pozorovanými 61 ženami.
- U4 b), c) a e): výběrové rozdělení průměru pod H₀ pro n = 48 a n = 12
  se stejnou osou; α šrafovaně, p-hodnota oranžově, kritické hodnoty
  přerušovaně. U4 f): proč volba směru až podle výsledku dává α = 0,10.

Bez grafu zůstaly výpočetní části (U1 a), U3 a), d), f), U4 a), d)), kde by
graf otázce nepomohl.

**Kontroly:** hodnoty v grafech souhlasí s řešením v sešitu (četnosti průměrů
1, 1, 8, 14, 18, 6, 2; P = 0,0007 a 0,023; meze 552,0–748,0 a 630,4–669,6;
p = 0,0352, skutečná α 0,0352, p = 0,0028; U4 p = 0,038 a 0,299, kritické
hodnoty 28,30/31,70 a 26,61/33,39). Oboustranná p-hodnota pro π = 2/3 (0,27)
odpovídá řešení U3 e). Všech 13 stran vizuálně prohlédnuto v pdftoppm a v PDF
prohlížeči Chromia; překryvy popisků s křivkami, čarami a osou z-skórů opraveny
a znovu zkontrolovány. Čárkované čáry a okraje ploch vykresluje starý pdftoppm
jako duté obrysy, v Chromiu jsou v pořádku. Necommitovaná změna sešitu
(stejný obsah buněk, jiná metadata) zůstala mimo tento commit.
