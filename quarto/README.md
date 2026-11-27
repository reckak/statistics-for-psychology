# Autorská dokumentace

Záznamy jsou řazeny zpravidla od nejnovějších. Tento soubor obsahuje aktuální
a předchozí měsíc; starší uzavřené měsíce jsou beze změny přesunuté do archivu
([doplnění R32](../docs/rozhodnuti/postupy-a-dokumentace.md#r32-doplneni-2026-11-27)):

- [září 2026](../docs/historie/2026-09.md)
- [říjen 2026](../docs/historie/2026-10.md)

Původní adresy přesunutých záznamů zachovává [rejstřík na konci souboru](#rejstrik-archivovanych-zaznamu).

<a id="lightbox-matematika-v-popiscich"></a>

## Lightbox: vykreslená matematika v popiscích obrázků (2026-11-27)

Na autorův dotaz, proč se popisek obrázku 10.11 v lightboxu zobrazuje
nesprávně, a jeho pokyn „Ano, oprav to“. Quarto předává popisek do GLightboxu
jen jako prostý text v atributu `title` odkazu, takže inline matematika
zůstala jako TeX (`\mathrm{τ}_b`) v lightboxu i v bublině po najetí myší;
týkalo se všech obrázků s matematikou v popisku. Nový skript
`assets/lightbox-captions.js` (připojený v `assets/after-body.html`) po
otevření snímku nahradí titulek lightboxu obsahem `figcaption` obrázku
s vykresleným MathML a u obrázků s matematikou přepíše `title` na čitelný
text bez TeXové anotace. Obrázky bez matematiky se nemění. Navazuje na
[zapnutí lightboxu](#lightbox-20261101);
nové rozhodnutí v registru nezaloženo (technická oprava webu).

**Kontroly:** celá kniha vykreslena (Quarto 1.9.38, R 4.5.1); skript je
připojen na všech stránkách. `check-html.cjs` rozšířen o obrázek 10.11
(bublina bez `\mathrm` a s „τb“, titulek lightboxu obsahuje MathML a ne TeX)
a prošel celý bez chyb; prošel také `scripts/check-doc-maps.cjs`. Snímek
lightboxu obrázku 10.11 na desktopu (1360 px) vizuálně prohlédnut:
τ<sub>b</sub> i kurzivní *p* vykresleny.

**Omezení:** ověřeno jen v Chromiu na desktopu; mobilní zobrazení lightboxu
s matematikou, Firefox, Safari a čtečka obrazovky nebyly vyzkoušeny.

<a id="reorganizace-dokumentace-2026-11-27"></a>

## Rozdělení rozsáhlých autorských dokumentů (2026-11-27, doplnění R32, R88)

Provedeno podle [doplnění R32](../docs/rozhodnuti/postupy-a-dokumentace.md#r32-doplneni-2026-11-27);
nové pravidlo zápisu stanoví [R88](../docs/rozhodnuti/postupy-a-dokumentace.md#r88-bez-opakovani).
Přesuny provedl jednorázový skript podle manifestu bloků (původní a cílový oddíl);
text se nezměnil, mění se jen cíle místních odkazů a v provozním návodu jeden
rozdělený odstavec (ř. 474–476 o `vizCheck`).

- **Provozní návod:** `docs/PROVOZ.md` 76 kB → 22 kB; podrobné návody v `docs/provoz/`
  (`pdf.md`, `ai-tutor.md`, `vizualizace-a-aplikace.md` 8 kB, `sesity.md`) a historický
  výčet scénářů kontrol 16 vizualizací a 2 aplikací v `kontroly-stranek.md`. Příkazy,
  závislosti R, tolerance a obnova referenčních hodnot aplikací zůstaly v živém návodu.
- **Doklady:** R65 a R87 v `docs/rozhodnuti/vizualizace-a-aplikace.md` (64 kB);
  `postupy-a-dokumentace.md` 103 kB → 51 kB včetně dvou odkazovacích oddílů s původními
  kotvami, doplnění R32 a R88.
- **Registr:** řádek R65 7 490 → 3 419 znaků (zbytek tvoří odkazy na 17 upřesnění
  a stránky), R87 2 228 → 1 670; zachovány platnost, rozsah, hlavní místa a údaje
  o upřesnění a výjimkách (sazba tabulek, test nad rámec kapitoly 9, hesla a termíny
  jen pro stránku). Každý vypuštěný popis obsahu stránky byl dohledán v dokladu.
- **Historie:** 121 záznamů ze září a října (včetně tří nedatovaných z 2026-09-20)
  v `docs/historie/2026-09.md` a `2026-10.md`; tento soubor 644 kB → asi 320 kB.
  Rejstřík na konci zachovává 38 skupin původních kotev.
- **Odkazy:** 272 přepsaných cílů ve 25 dalších dokumentech (karty, slovník,
  rozhodnutí, AGENTS.md, README) i v přesunutém textu.
- **Kontrola:** `check-doc-maps.cjs` nově úplně kontroluje také `quarto/README.md`,
  `docs/provoz/` a `docs/historie/`.

**Kontroly:** samostatný ověřovací skript porovnal 10 709 přesunutých či ponechaných
řádků se zdrojem ve stejném pořadí (mimo cíle odkazů shodně), ověřil, že každý
neprázdný řádek tří původních souborů je převzat právě jednou a že části rozděleného
odstavce dávají původní text. U 623 dvojic odkazů porovnal rozřešený cíl: 156 změněných
cílů vede na kotvu téhož nadpisu, ostatní se nezměnily; v 25 dalších dokumentech se
změnily jen cíle odkazů. Všech 86 zachovaných kotev na starých adresách vede na
odpovídající oddíl, doklad či záznam. Záměrně změněný cíl odkazu a změněné slovo
skript odhalil. `node scripts/check-doc-maps.cjs` prošel bez chyb (5 104 místních odkazů, i s volbou `--require-sources`).

**Omezení:** ověřovací skripty jsou jednorázové a nejsou v repozitáři. Kotvy pododdílů
provozního návodu (např. „Vydání PDF na GitHubu“) a neodkazované kotvy nadpisů
archivovaných záznamů se na původní adrese nezachovaly; deset neodkazovaných kotev
opakovaných nadpisů (např. „Ověření“) dostalo jiné pořadové číslo. Kotvy z nadpisů
počítá kontrola vlastním algoritmem, zobrazení na GitHubu nebylo zkoušeno. Web se
nemění, lokální render se nespouštěl; workflow GitHubu sestaví knihu u pull requestu.

<a id="aplikace-jeden-prumer"></a>

## Statistické aplikace: test jednoho průměru (2026-11-27, upřesnění R87)

Podle [upřesnění R87](../docs/rozhodnuti/vizualizace-a-aplikace.md#r87-upresneni-2026-11-27)
vznikla třetí aplikace [Test jednoho průměru](app_jeden_prumer.qmd). Kapitoly 6, 7 a 8 na ni
odkazují bloky „Spočítejte si“ na konci pododdílu *z*-test, oddílu Jednovýběrový *t*-test
a oddílu o párových datech; jinak se kapitoly nemění.

- **Stránka:** jeden výběr nebo párová data; jednotlivé hodnoty (textové pole, záhlaví se přeskočí, neúplné dvojice se vyřadí) nebo souhrny; popisky proměnné, jednotky a měření; *z*-test / *t*-test, μ₀, alternativa, α, volba intervalu u jednostranné alternativy; test ekvivalence se dvěma hranicemi; „Prohodit pořadí měření“ (mění znaménko μ₀, hranic a průměru rozdílů ze souhrnů a směr jednostranné alternativy). Výsledky: tabulka s dosazením, slovní interpretace s ukázkou zápisu podle APA, rozdělení statistiky při *H*₀, interval pro μ s pásmem ekvivalence, graf variant *d*; diagnostika normality (tabulka ukazatelů, histogram s přepínači, raincloud graf, Q–Q graf tradiční/detrendovaný s pásem tail-sensitive, KS nebo bez pásu). Osm předvoleb z kapitol 6–8 a smyšlená zešikmená data 80 dob řešení úlohy (vygenerována v R, seed 2711, vložena do stránky).
- **Výpočty** v modulech `assets/stat/prumer.js` (neúplná funkce beta, *t*-rozdělení a kvantily, necentrální *t* integrací přes rozdělení χ Gaussovou–Legendreovou kvadraturou, interval parametru necentrality obrácením, Bonettovy intervaly) a `assets/stat/normalita.js` (kvartily lineární interpolací, krabicový graf kapitoly 3, SKEW a KURT, Shapirův–Wilkův test podle `swilk.c`, jádrový odhad hustoty s `bw.nrd0`, Q–Q body a pásy). Úrovně γ(*n*) pásu tail-sensitive generuje `scripts/qq-ts-gamma.R` do `assets/stat/qq-ts-gamma.js` (B = 50 000, nad *n* = 1 000 20 000, vyhlazeno na log–log škále).
- **Odchylka při realizaci od schváleného plánu:** plán předpokládal pás tail-sensitive jako qqplotr se zadanými parametry (`mu = m`, `sigma = s`). Kontrola ukázala, že takový pás při *m* a *s* odhadnutých z týchž dat zachytí normální data celá s pravděpodobností 0,999–1, ne 0,95 (4 000 výběrů pro *n* = 10–100), a odchylky by tedy téměř neodhaloval. Simulace proto stejně jako výchozí qqplotr standardizuje simulované výběry, ale průměrem a směrodatnou odchylkou místo robustních odhadů Qn, aby pás ležel kolem přímky *m* + *s z* kapitoly 4; simultánní pokrytí je pak 0,94–0,96. Do *n* = 30 se používají nevyhlazené hodnoty γ (vyhlazení posunulo pokrytí při *n* = 3 na 0,966). Pás KS zůstává přesně jako v qqplotr; jeho pokrytí při odhadnutých parametrech je prakticky 1, což stránka uvádí. Autor volbu potvrdil týž den ([doplnění R87](../docs/rozhodnuti/vizualizace-a-aplikace.md#r87-doplneni-2026-11-27-pas)).
- **Zdroje:** nová karta [D16](../docs/zdroje/D16-bonett.md#d16) (Bonett, 2015; dva nálezy v příkladu článku) a [E11](../docs/zdroje/E11-diagnostika-normality.md#e11-diagnostika-normality) (qqplotr, Aldor-Noiman et al., Royston, Allen et al.; nečteny v plném znění, bibliografie ověřena v Crossref a citacích R); položky v `references.bib`. Tvrzení, že pás tail-sensitive je ve chvostech citlivější než KS, se v dostupných textech ověřit nepodařilo; stránka proto popisuje jen vlastnosti ověřené výpočtem.
- **Terminologie a značení:** sedm hesel jen pro aplikaci v registru ([oddíl](../docs/SLOVNIK.md#aplikace-jeden-prumer)) a ve slovníčku; v přehledu značení jednovýběrové *d*, $d_z$ a *W*; doplněno heslo Cohenovo *d*.
- **Didaktická revize** samostatným agentem v roli studenta po kapitole 8. Opraveno: tvrzení o 95% pravděpodobnosti platilo jen pro pás tail-sensitive; bod mimo pás popsán jako signál, ne důkaz (asi 5 % normálních výběrů); *W* srovnává seřazené hodnoty s hodnotami očekávanými na místech pořadí, ne s pořadími; odstavec o zešikmených datech přepsán (výběrová šikmost 2,8 a exces 13,6 pocházejí z velké části z hodnoty 181 s; bez ní šikmost 0,84, *p*-hodnota *t*-testu 0,110; odkaz na nepovinné rozšíření kapitoly 7); vztah intervalu a testu i u intervalu 1 − 2α; obecné vysvětlení mezí přesného intervalu pro *d* bez symbolu δ; „přibližně na polovinu“; mírnější formulace o intervalu Alginy a Keselmana (selhání až od populační hodnoty kolem 1,2); jádrový odhad dělený počtem hodnot; „referenční“ místo „výchozí“ měření; jednotné názvy korigovaných odhadů a vysvětlení dvou korekcí; poznámka o zaokrouhlení v zápisu APA; odkazy na nepovinná rozšíření u Cohenových pásem; jazykové opravy (interval *ji* nevylučuje, dvojitá závorka u jednostranného intervalu, popisky grafu *d*). Úkoly „Vyzkoušejte si“ upřesněny podle přepočtu recenzenta.
- **Připomínky autora po prohlídce** (týž den): v grafu rozdělení statistiky při *H*₀ vyznačeny kritické hodnoty (čárkovaně, s popiskem na straně odvrácené od statistiky) a kritický obor (červený pruh pod osou), s větou o kritickém oboru pod grafem a odkazem na kapitolu 6; v detrendovaném Q–Q grafu osa nově zobrazuje celý pás (dřív ji ořez na 25 % za body změnil v obdélník stejný pro oba pásy), konce pásu se ořezávají až 1,2 *s* za body; v grafu Cohenova *d* popisek s odhadem a intervalem pod každou variantou jako v ostatních grafech intervalů.
- **Chyby nalezené při kontrole:** znaménko koeficientů Shapirova–Wilkova testu (*W* i *p* se lišily od R; opraveno, shoda na 10⁻⁹); zamrznutí po přepnutí na souhrny s prázdnými poli (hledání mezí parametru necentrality s nedefinovanou statistikou; modul nyní vrací NaN a stránka doplní prázdná pole příkladem z kapitol); záměna dat po přepnutí uspořádání (poslední platná data se nyní drží pro každé uspořádání zvlášť).

**Nezávislá kontrola:**

- `Rscript --vanilla scripts/app-jeden-prumer.R` (R 4.5.1): `t.test`, `pt`/`qt`/`pnorm`, necentrální *t* integrací (`integrate`; `pt(…, ncp)` v R pro ncp > 37,62 jen aproximuje), shoda přesného intervalu pro *d* s `effectsize::cohens_d` a `MBESS::conf.limits.nct`, Bonettovy rovnice přepsané z článku, `shapiro.test`, `bw.nrd0`, pás KS z `qqplotr::stat_qq_band`. `node scripts/check-stat-lib.mjs`: 13 832 kontrol, 0 chyb (shoda na 10⁻⁹, u přesných intervalů pro *d* 10⁻⁷, Shapirův–Wilkův test *p* 10⁻⁷).
- Hodnoty kapitol souhlasí: cvičení 7 kapitoly 7 *t* = 3,15, *p* = 0,005, (20,74; 23,66); pozornost *z* = −2, *p* = 0,023 a *t* = −1,818, *p* = 0,041 s 90% intervalem (42,24; 49,76); PDI (100,75; 107,50); varianta A kapitoly 8 *t* = 5,07, (1,98; 5,02); anorexie *d* = 1,45 a $d_z$ = 1,01; online verze ekvivalentní při *n* = 400.
- Simultánní pokrytí pásu tail-sensitive ze 4 000 normálních výběrů s odhadnutými *m* a *s*: 0,944–0,955 pro *n* = 3–100; pás KS 0,9998–1.

**Kontroly:** `quarto render` celé knihy (Quarto 1.9.38) bez varování; `node quarto/_verification/check-html.cjs` s novým blokem aplikace prošel (35 stránek, mobil 390 px); `node scripts/check-table-layout.cjs` a `node scripts/check-doc-maps.cjs` bez chyb. Grafy prohlédnuty na snímcích z Playwright (Chromium) při šířce 1 360 px a 375 px.

**Omezení:** ověřeno v Chromiu; Firefox, Safari, skutečný telefon a čtečka obrazovky nebyly vyzkoušeny. Obsah článků citovaných k diagnostice normality nebyl čten ([E11](../docs/zdroje/E11-diagnostika-normality.md#e11-diagnostika-normality)). Didaktická revize je interní, ne ověření na studentech.

<a id="obrazek-3-3-popisky-50"></a>

## Kapitola 3: popisky „50 %“ v obrázku 3.3 (2026-11-26)

Na připomínku autora, že levý popisek „50 %“ v obrázku 3.3
(`assets/chapter-03/plots/mode-median-mean.svg`) přetéká přes levý okraj
tvaru: v prostředním panelu zmenšeno písmo obou popisků z 10 na 8 jednotek
a výchozí české popisky posunuty z x = 15 a 45 na 19 a 43. Mezera v „50 %“
zůstává; jazykové větve ostatních jazyků mají jen menší písmo. Ověřeno na
snímku samotného SVG a obrázku ve vykreslené kapitole 3 (po vynucení nového
načtení, prohlížeč držel starou verzi v mezipaměti): oba popisky jsou celé
uvnitř tvaru a nedotýkají se čáry mediánu.

<a id="aplikace-dva-podily"></a>

## Statistické aplikace: test dvou podílů (2026-11-26, upřesnění R87)

Podle [upřesnění R87](../docs/rozhodnuti/vizualizace-a-aplikace.md#r87-upresneni-2026-11-26)
vznikla druhá aplikace [Test dvou podílů](app_dva_podily.qmd) za testem jednoho
podílu. Kapitola 9 na ni odkazuje blokem „Spočítejte si: test dvou podílů“
na konci pododdílu Test se společným podílem.

- **Stránka:** editovatelná tabulka 2 × 2 s popisky a okraji, sledovaná kategorie, „Prohodit skupiny“ (mění i znaménko δ₀ a směr jednostranné alternativy), testovaný rozdíl δ₀ (desetinně nebo zlomkem), alternativa, α, u jednostranné alternativy volba intervalů; tabulka výsledků s dosazením ve skupinách Data, Rozdíl podílů, Test se společným podílem (pro δ₀ ≠ 0 Skórový test rozdílu), Fisherův exaktní test, Přesný test a interval podle Agrestiho a Mina, Další míry souvislosti; slovní interpretace, očekávané četnosti při *H*₀ a tři grafy (podíly s Wilsonovými intervaly, osa rozdílu s Newcombovým a přesným intervalem, nulou a δ₀, všechny tabulky Fisherova testu jen pro δ₀ = 0). Výchozí stav: stres 40/100 a 30/100, δ₀ = 0, oboustranně. Předvolby stres, Danielsová, pilotní studie, aspirin a noninferiorita online kurzu (vlastní data 66/100 a 70/100, δ₀ = −0,10).
- **Výpočty** v modulu `assets/stat/dva-podily.js` (importuje `podil.js`, kam přibyl export `logFactorials`): skórový test s podíly odhadnutými za platnosti *H*₀ (uzavřený vzorec, při δ₀ = 0 společný podíl), Fisherův test pravidlem R, Newcombův interval oboustranný i jednostranný, poměry s logaritmickými intervaly stejné spolehlivosti jako interval rozdílu, φ se znaménkem. Přesný nepodmíněný test podle Agrestiho a Mina (2001): výčet všech tabulek, maximum přes π₂ na mřížce 200 bodů se zjemněním zlatým řezem, interval bisekcí s hledáním vzdálenějších nezamítnutých úseků; běží se zpožděním 0,3 s jen pro skupiny nejvýše po 200 případech (200 a 200 v Node asi 0,35 s).
- **Redakční volby při realizaci:** očekávané četnosti při *H*₀ z podílů odhadnutých za platnosti *H*₀ (při δ₀ = 0 totožné s kapitolou 9); u jednostranné alternativy je přesný interval vždy jednostranný 1 − α (obrácení jednostranného testu podle oddílu 7 článku), protože oboustranný přesný interval 1 − 2α nemá tutéž mez jako jednostranný test; *s*<sub>*p*₁−*p*₂</sub> v tabulce jen pro představu o přesnosti; symbol δ₀ zapsán do [přehledu značení](znaceni.qmd) (řádek `znak-delta0-rozdil`).
- **Zdroj:** nová karta [E10](../docs/zdroje/E10-agresti-min-2001.md#e10-agresti-min-2001) a položka `agresti2001` v `references.bib` (údaje ověřeny v Crossref). Uzavřený vzorec omezených odhadů pochází z Farringtona a Manninga (1990), práce nebyla čtena ani citována; ověřen numericky.
- **Didaktická revize** samostatným agentem v roli studenta po kapitolách 1–9. Opraveno: nesprávná věta o shodné mezi i u přesného intervalu (vedla ke změně výpočtu výše), π ve vzorci pro odhady za platnosti *H*₀ a nezavedený pojem věrohodnost, chybějící zdůvodnění směrodatné chyby z *H*₀ a maxima přes dvojice podílů, „buňka vlevo nahoře“ po změně sledované kategorie, nejasné „pro skupiny do 200“, most od Δ z kapitoly 7 k δ₀ = −0,10, konzervativnost Fisherova testu s odkazem na pojem z kapitoly 7 a vysvětlení, proč se dva přesné testy v pilotní studii liší (0,070 a 0,041), rozdělení dlouhých vět.

- **Úprava grafů intervalů podle připomínek autora** (týž den, obě aplikace): pod každým intervalem dvouřádkový popisek vystředěný na bodový odhad (odhad, pod ním meze), na bílém poloprůhledném podkladu (neprůhlednost 0,8), aby čáry nulové hypotézy pod ním zůstaly vidět; popisek se drží uvnitř plochy grafu. Mezi Newcombovým a přesným intervalem je větší svislá mezera. Ověřeno na snímcích Playwright (desktop a 375 px) a opakovaným `check-html.cjs` a `check-table-layout.cjs`.
- **Další připomínky autora** (týž den): přesný interval v grafu rozdílu zeleně (`#3B7D3A` jako ve vizualizacích), aby se odlišil od Newcombova; v oddílu Očekávané četnosti a předpoklady tabulka pozorovaných četností s očekávanými v závorkách (hodnoty pod 5 tučně) místo výčtu ve větě.

**Nezávislá kontrola:**

- `Rscript --vanilla scripts/app-dva-podily.R` (R 4.5.1; `prop.test` bez korekce, `fisher.test`, `DescTools::BinomDiffCI(method = "score")`, omezené odhady řešením věrohodnostní rovnice `uniroot`, poměry podle vzorců kapitoly 9 s kontrolou `OddsRatio`, φ jako korelace kódů 0/1, balíček `Exact` 3.3) zapisuje `scripts/reference/app-dva-podily.json`; `node scripts/check-stat-lib.mjs`: 2 557 kontrol (oba moduly; nově 14 tabulek × 5 hodnot δ₀ × 3 alternativy, nulové buňky, *n* = 1, velké *n*, shoda jednostranného přesného intervalu s přesným testem), 0 chyb.
- Hodnoty kapitoly 9 souhlasí: stres *z* = 1,48, *p* = 0,138, Newcombe (−0,032; 0,227), Fisher 0,18; dvojnásobek 0,036 a (0,007; 0,191); pilot Fisher 0,070; Danielsová poměr rizik 2,34 (1,50; 3,66), poměr šancí 3,23 (1,80; 5,82), φ 0,25, Newcombe (0,119; 0,330). `DescTools::RelRisk(method = "wald")` dává jiný interval (1,50; 3,64), stránka drží vzorec kapitoly.
- Přesné intervaly: všech 11 řádků tabulky 3 Agrestiho a Mina na tři desetinná místa. *p*-hodnoty `Exact` (mřížka 1 000 bodů) jsou rovny nebo nepatrně nižší než v modulu (nejvýše o 10⁻³ u maxima na kraji rozsahu π₂, které mřížka balíčku nezachytí); shody *t*₀ = 0 vynechány. U dat stresu dává `Exact` dolní mez −0,0332, modul −0,0382: *p*-hodnota má u −0,0381 úzký úsek nad 0,05 (potvrzeno balíčkem) a modul jako článek bere nejnižší nezamítnutou hodnotu.

**Kontroly:** `quarto render` celé knihy (Quarto 1.9.38) bez varování; `node quarto/_verification/check-html.cjs` s novým blokem aplikace prošel (34 stránek); `node scripts/check-table-layout.cjs`, `node scripts/check-doc-maps.cjs` a `node scripts/export-tutor.cjs` (s `check-tutor.cjs`; odkazy na `app_dva_podily.html` v kapitole 9 a přehledu značení převedeny na web) prošly. Stránka prohlédnuta na snímcích Playwright (desktop, telefon 375 px: tabulka zadání se vejde, dlouhé názvy kategorií se v poli zkracují).

**Omezení:** ověřeno v Chromiu; Firefox, Safari, skutečný telefon a čtečka obrazovky nebyly vyzkoušeny. Rychlost přesného výpočtu měřena jen v Node a v Chromiu tohoto počítače. Didaktická revize je interní, ne ověření na studentech.

<a id="tutor-vizualizace-interval-podilu"></a>

## AI tutor: rada k vizualizaci intervalu pro podíl (2026-11-25)

Při sloučení [vizualizace Waldova a Wilsonova intervalu](#vizualizace-interval-podilu)
chyběl v `VIZUALIZACE.md` balíčku tutora řádek nové stránky, takže
`export-tutor.cjs` i `check-tutor.cjs` padaly na „Interactive page missing in
VIZUALIZACE.md: viz_interval_podilu“. Doplněno:

- **řádek tabulky interaktivních stránek** s plnou adresou
  `viz_interval_podilu.html`, za vizualizací dvou intervalů jako v menu knihy.
  Rada k nastavení vychází z úkolů „Vyzkoušejte si“ stránky; „Čeho si všimnout“
  z jejího stejnojmenného oddílu a z [karty kapitoly 9](../docs/kapitoly/09-podily-kategorialni-data.md#interaktivni-vizualizace-09)
  (64 % proti 92,5 % při *n* = 20 a π = 0,05, pokrytí jako součet sloupců,
  průměr 95,3 %, propady jen u 0 a 1). Graf nerovnice je označen jako součást
  nepovinného odvození;
- **oprava zastaralé věty** „Kapitoly 1, 2 a 10 interaktivní stránku nemají“
  na „Kapitoly 1 a 2“; kapitola 10 má od 2026-11-23 [vizualizaci korelace](#vizualizace-korelace).

**Verze tutora** se nezvyšuje (zůstává 0.4.1), stejně jako při doplnění
vizualizace korelace: verze označuje obsah balíčků při vydání a nic se
nevydává. Protože vydání `tutor-v0.4.1` je zveřejněné a obsah balíčků se od něj
změnil (vizualizace korelace a intervalu pro podíl), musí mít příští vydání
novou verzi.

**Kontroly:** `node scripts/export-tutor.cjs` (zahrnuje `check-tutor.cjs`)
prošel (16 interaktivních stránek, archivy 0.4.1) a prošel i samostatný
`node scripts/check-tutor.cjs`; výstup v ignorované složce `ai-tutor/` nebyl
nahrán ani vydán.
Chování tutora v klientech se neověřovalo.

<a id="aplikace-jeden-podil"></a>

## Statistické aplikace: pilotní test jednoho podílu (2026-11-25, R87)

Podle [R87](../docs/rozhodnuti/vizualizace-a-aplikace.md#r87-statisticke-aplikace)
vznikla v knize nová část „Statistické aplikace“ (za vizualizacemi, v nabídce
ve výchozím stavu sbalená) se stránkou [Test jednoho podílu](app_jeden_podil.qmd).
Kapitoly 6 (konec pododdílu o binomickém testu) a 9 (konec pododdílu Interval
a test jednoho podílu) na ni odkazují blokem „Spočítejte si: test jednoho podílu“.

- **Stránka:** vstupy (název proměnné, názvy a četnosti dvou kategorií, kategorie úspěchu, π₀ i zlomkem, alternativa, α, u jednostranné alternativy druh intervalu), tabulka výsledků s dosazením, slovní interpretace, očekávané četnosti s upozorněním, tři grafy s textovým popisem, předvolby z kapitol 6 a 9; oddíly „Co aplikace počítá“, „Vyzkoušejte si“ a „Čeho si všimnout“.
- **Technika:** výpočty ve sdíleném modulu `assets/stat/podil.js`, načítaném dynamickým importem; `assets/sidebar-collapse.js` sbaluje obě části; styly `.viz-app-`; PDF celé knihy a export tutora převádějí odkazy `app_…` na web.
- **Redakční volby při realizaci:** α na intervalu (0; 0,5), protože u jednostranné alternativy musí být 1 − 2α kladné; četnosti do 100 000; text uživatele se vkládá escapovaný; graf rozdělení při *H*₀ ukazuje u velkých *n* výřez a upozorní, leží-li pozorovaný počet daleko mimo; u jednostranné alternativy tabulka a interpretace hodnotí jen mez na straně alternativy (shoda se skórovým testem); pravidlo očekávaných četností alespoň 5 převzato z kapitoly 9 jako orientační.
- **Didaktická revize** samostatným agentem v roli studenta po kapitolách 1–9. Opraveno: chybné tvrzení o oboustranné přesné *p*-hodnotě v kapitolách (nově odkaz na stejné pravidlo Fisherova testu), nezavedená značka Bin(*n*; π), hodnocení „leží π₀ v intervalu“ u jednostranné alternativy, text při rozdílném rozhodnutí testů, popis zaokrouhlení, nedopočítané očekávané četnosti, výklad π u opakovaných pokusů, kalky „dává“, zadání úkolů 1, 2 a 4 a další formulace.

- **Úpravy podle připomínek autora** ([upřesnění R87](../docs/rozhodnuti/vizualizace-a-aplikace.md#r87-upresneni-2026-11-25)): odstraněn oddíl „Výpočet v českém Excelu“ a skript `scripts/check-app-jeden-podil-excel.ps1`; stránka se otevírá s daty 7 z 8, π₀ = 0,50 a oboustrannou alternativou (výchozí stav ukazuje i rozdílné rozhodnutí obou testů a upozornění na malé očekávané četnosti); tabulka výsledků má záhlaví v barvě textu s bílým písmem a slabě šedé řádky skupin; z odkazu v kapitole 9 vypuštěna zmínka o Excelu.

**Nezávislá kontrola:**

- `scripts/app-jeden-podil.R` (R 4.5.1, `prop.test` bez korekce, `binom.test`) a `node scripts/check-stat-lib.mjs`: 975 kontrol modulu na mřížce 20 případů × 3 alternativy včetně krajních *k* = 0, *k* = *n*, *n* = 1 a *n* = 10 000, shoda na relativní toleranci 10⁻⁹, včetně shody rozhodnutí intervalu se skórovým testem.
- Původně nabízené vzorce českého Excelu byly ověřeny v desktopovém Excelu (čtyři případy, odchylka od modulu nejvýše 1,8 × 10⁻¹⁵); po upřesnění R87 byl oddíl i jeho kontrolní skript odstraněn.
- Hodnoty stránky souhlasí s kapitolami: přesná jednostranná *p*-hodnota 0,014 (kap. 6), 9/256 ≈ 0,035 (kap. 6, cvičení 8), *z* = 2,582 a oboustranná *p*-hodnota 0,0098 (kap. 9), 95% Wilsonův interval (0,299; 0,701).

**Kontroly:** `quarto render` celé knihy (Quarto 1.9.38) bez varování; `node quarto/_verification/check-html.cjs` s novým blokem aplikace a se čtyřmi skupinami nabídky prošel (33 stránek); `node scripts/check-doc-maps.cjs` a `node scripts/check-table-layout.cjs` prošly (druhá odhalila tmavou vnitřní linku pod skupinovými řádky tabulky výsledků, opraveno na světle šedé linky podle pravidel sazby). Snímek telefonu `tmp/verification/app-jeden-podil-mobile.png` prohlédnut.

**Omezení:** ověřeno v Chromiu; Firefox, Safari, skutečný telefon a čtečka obrazovky nebyly vyzkoušeny. Export tutora (`node scripts/export-tutor.cjs`) nelze dokončit kvůli dřívější chybě mimo tuto úpravu: v `VIZUALIZACE.md` chybí řádek stránky `viz_interval_podilu`; převod odkazů `app_…` v exportu proto nebyl ověřen během exportu. PDF celé knihy nebylo sestaveno. Didaktická revize je interní, ne ověření na studentech.

<a id="prekryvani-bodu-10"></a>

## Kapitola 10: překrývání bodů a rozvržení tří obrázků (2026-11-25, R86)

Na pokyn autora a podle [R86](../docs/rozhodnuti/kapitola-10.md#r86-prekryvani-bodu):

- **Nový pododdíl** [Když se body překrývají](kapitola_10.qmd#sec-prekryvani-bodu) na konci oddílu o bodovém grafu. Dosavadní věta o velikosti bodu podle počtu se přesunula do něj. Obsah:
  - příklad 500 smyšlených studentů, kvalita spánku a únava během dne na škále 1–7 (*r* = −0,43; 45 viditelných bodů ze 49 kombinací, 36 studentů v bodě 3/5);
  - velikost bodu podle počtu, jitter s průhledností a mez příliš velkého jitteru;
  - doplnění, že obrázek 10.1 je také nepatrně posunutý (dvě dvojice shodných hodnot).
- **Navazující změny v kapitole:** obrázek `fig-prekryvani` (2 × 2) a úpravy cílů učení, shrnutí a řešení cvičení 1c. Data vytváří `scripts/kapitola_10.R` (seed 15010); sešit beze změny.
- **Rozvržení obrázků:** `fisher` ve dvou řadách (křivka nahoře uprostřed), `odlehle-typy` v mřížce 2 × 2, `faktory` ve dvou řadách (sloučené třídy dole uprostřed). Data a výpočty beze změny.
  - Kvůli `layout()` je písmo nastaveno na `cex = 0,75`; jinak by ho R zmenšil na 0,66.
  - Popisek bodu *r* = −0,523 u Fisherovy křivky je přesunut pod křivku s odkazovou čarou.
  - Upraveny popisky, `fig-alt`, odkazy na polohu panelů v textu a poznámky dat pro tutora.
- **Dokumentace:** hesla `pojem-prekryvani-bodu` a `pojem-jitter` v registru i studentském slovníčku. Aktualizovány také karta kapitoly, mapa obsahu, `docs/DATA.md` a registr rozhodnutí.

**Didaktická revize:** samostatný agent v roli studenta po kapitolách 1–9. Na jeho podnět byl opraven rozpor mezi pravidlem „menší než polovina vzdálenosti“ a panelem D (±0,45): nově „výrazně menší než polovina, zde nejvýš 0,2“. Upraveny byly také formulace k souvislosti v grafu A, zavedení termínu jitter a místa s jedním studentem.

**Kontroly:**

- `check-chapter-10.R` prošel, s novými kontrolami čísel pododdílu, šířek jitteru a duplicit obrázku 10.1.
- `check-figure-data.cjs` a `render-figure-data.cjs kapitola_10` prošly (18 obrázků).
- Celá kniha je vykreslená (Quarto 1.9.38, R 4.5.1); kapitola 10 a slovníček byly po revizi vykresleny znovu.
- `check-html.cjs` prošel; počet obrázků kapitoly 10 je zvýšen na 18 a přibyly nové ID.
- Prošly také `check-table-layout.cjs` a `check-doc-maps.cjs`.
- Všechny čtyři obrázky jsou vizuálně prohlédnuté jako PNG. Stránka je zkontrolovaná v panelu prohlížeče na desktopu a při šířce 375 px bez přetékání.

**Omezení:**

- SVG `prekryvani` má asi 600 kB (2 000 bodů v panelech B–D).
- Citace zdroje k překrývání bodů nebyla doplněna; výklad je vlastní.
- PDF kapitoly, export tutora, Firefox, Safari a skutečný telefon nebyly ověřeny.
- Didaktická revize je interní, ne ověření na studentech.

<a id="vizualizace-interval-podilu"></a>

## Vizualizace Waldova a Wilsonova intervalu pro podíl (2026-11-25, upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-25-interval-podilu)
přibyla šestnáctá stránka části „Interaktivní vizualizace“, třetí ke kapitole 9:
[Proč odhadujeme podíl Wilsonovým intervalem](viz_interval_podilu.qmd), v menu za
vizualizací dvou intervalů a před vizualizací chí-kvadrát. Kapitola 9 na ni odkazuje
blokem „Vyzkoušejte si: Waldův a Wilsonův interval“ na konci pododdílu `sec-wilson`,
před rozšířením o odvození; jinak se výklad kapitoly nemění. Obsahuje:

- **zadání:** počet úspěchů *k*, počet pokusů *n* (1–200), posuvník hladiny 50–99 % a předvolby 10 z 20, 0 z 15, 1 z 25, 40 z 80;
- **oba intervaly** nad sebou s výpočtem, oblastí nemožných hodnot a upozorněním na nulovou šířku nebo meze mimo 0–1;
- **graf nerovnice** jako interaktivní obdobu obrázku `fig-wilson-odvozeni` s přepínačem pravé strany pro Waldův interval (vodorovná čára $z^2p(1-p)/n$);
- **přesné pokrytí** obou intervalů podle π s přiblížením okolí hladiny, souhrny (průměr, nejnižší hodnota, podíl hodnot π pod hladinou) a pravděpodobnost Waldova intervalu mimo 0–1 nebo s nulovou šířkou;
- **rozbor „Proč pokrytí kolísá“:** sloupce *P*(*X* = *k*) pro vybrané π se zvýrazněnými počty, jejichž interval π obsahuje, a součet;
- **vzorce listu `Interval_podilu`** s výsledky.

Redakční volby při realizaci:

- **Značení *k* a *P*(*X* = *k*)** podle kapitoly 5; v kapitole 9 znamená *k* počet kategorií, na stránce se ale tento význam nevyskytuje. Nový pojem ani symbol nevznikl.
- **Křivka a meze:** na popud didaktické revize se křivky grafu nerovnice jmenují „levá strana“ a „pravá strana“ (obrázek kapitoly mluví o „mezi“), aby se nepletly s mezemi intervalu; terminologie kapitoly se nemění.
- **Osa π:** u intervalů a grafu nerovnice „populační podíl π“ (zvažované hodnoty), u pokrytí „skutečný populační podíl π“ (hodnota zvolená v modelu).
- **Nejnižší pokrytí** se hledá na mřížce po 0,001 a navíc těsně pod a nad každou mezí intervalu uvnitř (0; 1), kde křivka skáče; průměr a podíl pod hladinou jen na mřížce.
- **Barvy** podle obrázku `fig-pokryti` (Wald oranžově, Wilson modře).

Nezávislá kontrola:

- **R** (`scripts/viz-interval-podilu.R`, v repozitáři): meze obou intervalů, kořeny kvadratické rovnice (uvnitř skriptu porovnány s mezemi Wilsonova intervalu), přesné pokrytí podle stejné definice jako `ch9_cover` ve `scripts/kapitola_09.R`, souhrny a nejnižší pokrytí. Shoda s kapitolou: 64 % Waldových intervalů při *n* = 20 a π = 0,05, 87 % mimo 0–1 při π = 0,10, Wilson (0,30; 0,70), (0; 0,20), 1 z 25 (−0,037; 0,117) a (0,007; 0,195). Čísla v textu stránky pocházejí z tohoto výstupu; kontrola stránky porovnává hodnoty `vizCheck` s výstupem s tolerancí 1e−9 až 1e−10.
- **Zjištění k textu kapitoly:** přesné nejnižší pokrytí 95% Wilsonova intervalu je při každém zkoušeném *n* (10–200) asi 83,5–83,8 %, v úzkém pásmu těsně pod dolní mezí intervalu pro *k* = 1 (u *n* = 10 při π ≈ 0,018, u *n* = 20 při 0,0089) a souměrně u 1. Věta kapitoly „u *n* = 10 nejníže na 85 %“ platí pro mřížku π od 0,01 do 0,99 obrázku `fig-pokryti`, ne pro všechna π. Kapitola nebyla změněna; zjištění je předloženo autorovi.
- **Oprava kapitoly (doplněk 2026-11-25):** na pokyn autora („Yes, fix chapter 9“) nahrazena v pododdílu `sec-wilson` věta o 85 %: pokrytí Wilsonova intervalu výrazněji klesá, na 83 až 84 %, jen v úzkých pásmech velmi blízko 0 a 1; při *n* = 10 u π = 0,018, u větších výběrů blíže okrajům, mimo rozsah obrázku. `check-chapter-09.R` místo minima na mřížce ověřuje pro *n* = 10, 20, 50 a 100 pokrytí těsně pod dolní mezí intervalu pro jeden úspěch (z `prop.test`) proti (1 − π)^*n*, jeho rozmezí 0,83–0,84 a polohu pásma; text stránky sjednocen na „83 až 84 %“. Obrázek `fig-pokryti`, jeho popisek a alternativní text se nemění.
- **Excel:** vzorce na stránce jsou znění tabulky `tbl-k09-02` a listu `Interval_podilu`; v Excelu znovu spuštěny nebyly, list se nezměnil.
- **Prohlížeč:** stránka prohlédnuta v panelu prohlížeče aplikace (desktop a 375 px, předvolby 10 z 20, 0 z 15 a 1 z 25 s přepínačem Waldova intervalu) a na snímcích z Chromia z `check-html.cjs`.
- **Didaktická revize:** samostatný agent v roli studenta po kapitole 9. Zapracováno: rozlišení zvažovaného a skutečného π, pojmenování stran nerovnice, upozornění na návaznost na nepovinné odvození, oprava věty o pokrytí „nikdy přesně 95 %“ (pokrytí se mezi skoky mění plynule), vysvětlení souhrnů, zdůvodnění propadu Wilsonova pokrytí u okraje, formulace úkolů a jazykové drobnosti.

**Kontroly:** celá kniha vykreslena (Quarto 1.9.38, R 4.5.1), stránka po revizi znovu samostatně. `check-html.cjs` s novým blokem a novým pořadím menu prošel celý bez chyb; prošly také `check-table-layout.cjs` a `check-doc-maps.cjs`.

**Omezení:** ověřeno v Chromiu; Firefox, Safari, skutečný telefon a čtečka obrazovky nebyly vyzkoušeny. Didaktická revize je interní, ne ověření na studentech.

<a id="audio-kapitoly-9-judita-20261124"></a>

## 2026-11-24 — Druhá nahrávka kapitoly 9 hlasem Judita

Na výslovnou žádost autora převeden celý scénář snímků 1–30 ve stejném
znění jako u nahrávky hlasem Adam. Creative Claw použil
`speech/heygen-voice-1`, hlas Judita, `extras.language: cs` a rychlost 1.
Osm úseků bylo spojeno bez prolínání do jednoho místního MP3
`presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_Judita.mp3`
o délce 36:21 s 30 značkami snímků.

Ověřen shodný otisk scénáře, časovaný text všech úseků, dekódování
a délka odpovídající součtu úseků. Zvuk nebyl nezávisle přepsán ani
poslechnut. Nastavení a výsledek kontrol jsou v
[manifestu](../presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_scenar_manifest.json).

<a id="audio-kapitoly-9-20261124"></a>

## 2026-11-24 — Revize scénáře a nahrávka k prezentaci kapitoly 9

Na pokyn autora upraven [scénář pro syntézu](../presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_scenar.txt).
Revize zpřesnila mluvený zápis vzorců, předpoklad nezávislosti,
výklad Fisherova testu a simulace, srovnání skupin a znaménkový test.
Číselný přepočet v R prošel 48 skupinami kontrol. Projektový přepis
„kvantyl“ zůstal použitý ve všech tvarech.

Creative Claw převedl výklad snímků 1–30 do češtiny modelem
`speech/elevenlabs-v4` a hlasem Adam – Velvety and Conversational
s `extras.language_code: cs`. Čtyři úseky byly lokálně spojeny bez prolínání.
Místní nahrávka `presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_Adam.mp3`
trvá 43:03 a obsahuje 30 značek snímků. Je ignorovaná Gitem.

Ověřeno dekódování, délka proti součtu úseků, pokrytí scénáře časovanými
slovy služby a značky všech snímků. Poslech ani nezávislá transkripce
neproběhly. Nastavení, otisky aktuálních podkladů a výsledky kontrol
uchovává [manifest](../presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_scenar_manifest.json).

<a id="sesit-kapitoly-9-vyklad"></a>

## 2026-11-24 — Sešit s daty a výpočty z výkladu prezentace kapitoly 9

Na pokyn autora vytvořen nový doprovodný sešit
`presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_vyklad.xlsx` se všemi daty
z výkladové části prezentace (slidy 3–30) a s výpočty, které výklad uvádí na slidech nebo
v poznámkách. Podle autorovy volby jde o sešit jen pro prezentaci 9, ne o nové pravidlo
pro ostatní prezentace. Sešit cvičení `_cviceni.xlsx` se nemění.

- **Uspořádání:** list `Prehled` a deset listů, každý pro jednu studii či datový soubor: `Stres`,
  `Test_20`, `Pozice`, `Zvladani`, `Letni_cas`, `Pilot`, `Daniels`, `Aspirin`, `Pomoc`, `Spanek`.
  Sloupec A obsahuje otázku, čísla slidů, popis a původ dat a blok „Potřebné vztahy“ (51 nativních
  rovnic, převzatých z definic sešitu cvičení, nově jen φ, interval pro poměr rizik a pravděpodobnost
  tabulky ve Fisherově testu). V C–H jsou data a odvozené tabulky, od sloupce J výpočty po krocích
  základními operacemi s textovým vzorcem, sloupcem „Na slidu“ a kontrolami funkcemi Excelu.
  Sešit nemá pracovní oblast.
- **Data:** shodná s listy výkladu ve studentském sešitu `data/kapitola_09.xlsx`
  (`scripts/sesity-data.mjs`); příklad letního času podle textu kapitoly (Howell, 2013, s. 154).
  Simulovaná *p*-hodnota pilotní studie (6,8 %) je jen uvedena, v Excelu se nepočítá.
- **Navazující soubory:** heslovité poznámky ke slidu 38 v PPTX (jedna nová odrážka, doplněno
  na místě v PowerPointu; slidy beze změny, PowerPoint při uložení jen jinak zapsal deklaraci
  jmenného prostoru ve slidu 11) a podrobné poznámky v DOCX (nový odstavec u slidu 38,
  přegenerováno z `notes-detail.cjs`, jinak textově shodné s předchozí verzí).
- Generátor v ignorovaném `tmp/chapter09-presentation/`: `vyklad.mjs`, `equations-vyklad-spec.cjs`,
  `make-vyklad.sh`, `check-vyklad.ps1`, `check-vyklad.R`; `equations.cjs` nově přijímá cestu
  ke specifikaci rovnic a `equations-spec.cjs` exportuje své definice.

**Ověření:** sestaveno a přepočteno v českém Excelu 16: 0 chybových buněk, 17 kontrol „Shoda
s kroky“ = ano (jediné „ne“ je věcná odpověď kroku „Leží π₀ = 0,25 uvnitř Wilsonova intervalu?“),
51 rovnic. `check-vyklad.R`: 26 skupin nezávislého přepočtu v R bez rozdílu a 205 hodnot
zaokrouhlených jako ve výkladu se shoduje s čísly na slidech a v poznámkách. Listy prohlédnuty
v PDF exportu (rovnice, záhlaví tabulek, šířky sloupců). DOCX otevřen ve Wordu: 18 stran,
38 nadpisů slidů. Neověřeno: vzhled sešitu v jiné než české verzi Excelu.

<a id="sesit-kapitoly-9-kroky"></a>

## 2026-11-24 — Sešit cvičení k prezentaci kapitoly 9: Waldův interval a pracovní oblast po krocích

Na pokyn autora upraven `presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_cviceni.xlsx`
(generátor v ignorovaném `tmp/chapter09-presentation/`, soubory `wb-head.mjs`, `wb-body.mjs`,
`equations-spec.cjs`, `check.R`):

- **Waldův interval místo Wilsonova a Newcombova.** Wilsonův a Newcombův interval jsou na ruční
  výpočet náročné, proto studenti v U1 a U2 počítají 95% Waldovy intervaly: U1 (0,282; 0,607)
  a (0,363; 0,526), U2 (0,033; 0,367). Wilsonovy intervaly (0,295; 0,604) a (0,366; 0,526)
  a Newcombův interval (0,029; 0,355) jsou uvedeny jako hotové vstupy pro srovnání (U1 D7:E8,
  U2 D7:D8). Rovnice na listech nově ukazují Waldův interval; v U2 jde o značení učebnice
  $s_{p_1-p_2}$. Interpretace připomíná, že ve zprávě se podle kapitoly 9 uvádí Wilsonův,
  resp. Newcombův interval. Jde o volbu pro tento sešit, ne o obecnou konvenci.
- **Pracovní oblast po malých krocích** (nové pravidlo, upřesnění
  [R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-doplneni-2026-11-24) v
  [PREZENTACE.md](../docs/PREZENTACE.md#excelova-cviceni)). Žluté řádky se generují z kroků řešení,
  mají stejné číslo, popisek i řádek. Kroky jsou jemnější, například rozptyl a směrodatná chyba
  každého podílu, potom rozptyl a směrodatná chyba rozdílu, polovina šířky a meze.
  U3 a U4 mají prázdné žluté pracovní tabulky v K–O. Hotové pomocné tabulky se přesunuly
  do bloku řešení za sloupec „Shoda s kroky“ (V–Z). U5 má žlutou binomickou tabulku pro
  k = 0–4 a hotovou pro 0–19.
- **U5:** kategorie v pořadí ne, ano (tabulka 37, 15; 4, 24). Studenti nejprve vypíšou četnosti
  čtyř typů dvojic. Pomocné označení *b* = ne → ano, *c* = ano → ne odpovídá poloze v tabulce
  a rovnice jsou (b − c)/n a (b − c)²/(b + c). Výsledky U3–U5 se číselně nemění.
- Navazující soubory: přehled `Prehled`, slide 38 PPTX (texty U1 a U2 a heslovité poznámky, upraveno
  na místě v PowerPointu, ostatní autorovy úpravy prezentace zachovány), podrobné poznámky DOCX
  (slide 38, přegenerováno z `notes-detail.cjs`; obsah DOCX před změnou byl shodný s generátorem),
  `scripts/kapitola_09-prezentace-cviceni-grafy.R` a PDF grafů (U1 a U2 porovnávají Waldův
  interval s Wilsonovým, resp. Newcombovým; U5 čte nové pořadí kategorií). Generátor prezentace
  `content.cjs` srovnán se slidem 38.

Současně se commitují drobné úpravy prezentace kapitoly 9, které autor provedl ručně (rozvržení
obrázků a textů na slidech 7, 8, 10, 13, 15, 16, 18, 22 a 23 a doplnění textu na slidu 8).
Scénář a jeho manifest se neměnily. Manifest proto dál uvádí otisky PPTX a DOCX z doby vzniku
scénáře; slide 8 ze scénáře má nyní na slidu delší formulaci otázky.

**Ověření:** sešit sestaven a přepočten v českém Excelu 16: 0 chybových buněk, 5 kontrol „Shoda
s kroky“ = ano, 19 nativních rovnic, žádná vyplněná žlutá buňka. Hodnoty všech kroků vypsány
a porovnány s nezávislým přepočtem v R (`check.R`: 48 shod, 0 rozdílů, včetně Waldových mezí
a zaokrouhlených Wilsonových a Newcombových hodnot v zadání). Listy U1, U2, U4 a U5 prohlédnuty
z exportu do PDF ve zvětšení, U3 v náhledu. Všech 5 stran grafů prohlédnuto. Slide 38 vykreslen
v PowerPointu; text U5 se po rozšíření zalomil k popisku pod ním, proto zůstal beze změny
a čtyři typy dvojic uvádějí jen poznámky. DOCX otevřen ve Wordu: 18 stran, 38 nadpisů, čeština.

**Omezení:** sešit nebyl vyzkoušen se studenty ani ve starších verzích Excelu. Popisky dlouhých
kontrolních kroků mohou být při výšce řádku 18 bodů ve sloupci Q oříznuté jako dříve.

<a id="prezentace-kapitoly-9"></a>

## 2026-11-24 — Prezentace ke kapitole 9 a scénář zvukového doprovodu

Vytvořeny soubory v `presentations/kapitola_09/`: `kapitola_09_podily_a_kategorialni_data.pptx`
(38 slidů), `kapitola_09_poznamky.docx`, `kapitola_09_podily_a_kategorialni_data_cviceni.xlsx`,
`kapitola_09_podily_a_kategorialni_data_cviceni_grafy.pdf` a scénář pro syntézu řeči
(`_scenar.txt`, `_scenar_manifest.json`, `_scenar_podklady.md`). Rozsah dohodnut s autorem
2026-11-24: jedna výuka za celou kapitolu (45 minut výkladu, 45 minut procvičování), nepovinná
rozšíření vynechána; výstupy jako u kapitoly 8 a navíc scénář, **bez spuštění syntézy**.
Kapitola 9, slovník, osnova ani `data/kapitola_09.xlsx` se neměnily; věcný rozpor mezi kapitolou
a prezentací nebyl zjištěn.

Oprava téhož dne po připomínce autora: číslice a znaménka v dolních a horních indexech rovnic
(slidy 7, 9, 10, 11, 14, 17, 19 a 25; 18 rovnic sešitu cvičení) byly zapsány jako „normální
text“ uvnitř indexu, a proto se nezmenšovaly. Nově jsou to stojaté znaky v matematickém režimu
a index *s* s rozdílem podílů má vnořené indexy. Ověřeno vykreslením slidů v PowerPointu
(prohlédnuty slidy 9, 10, 14, 17 a 19), přepočtem sešitu v Excelu (0 chyb vzorců, 5 kontrol
„ano“) a kontrolou, že žádný index rovnic sešitu neobsahuje normální text; manifest scénáře má
nový otisk prezentace. Obsah, čísla, poznámky DOCX ani scénář se nezměnily. Pracovní generátor
prezentace kapitoly 8 má tutéž vadu; její soubory se neupravovaly, protože je autor právě
ručně rediguje.

Výklad má 23 obsahových slidů v pěti oddílech podle
[R50](../docs/rozhodnuti/postupy-a-dokumentace.md#r50-struktura-prezentaci): od tabulky k otázce
o populaci; odhad a porovnání podílů; testy chí-kvadrát; předpoklady a velikost souvislosti;
párová data, volba postupu a sdělení výsledků. Rozhodnutí o rozsahu této výuky: Waldův interval
jen jako mezikrok; vzorec Wilsonova intervalu na slidu není (počítá jej sešit); Newcombův interval
s obrázkem konstrukce, bez vzorce mezí; Fisherův test a simulovaná *p*-hodnota na jednom slidu jako
princip; Pearsonovo reziduum, Yatesova korekce, znaménko φ a přibližná verze McNemarova testu jen
v poznámkách; Holm, intervaly pro poměry, Simpson, kappa, telepatie a odvození vynechány.
Poznámky mají dvě podoby podle
[R74](../docs/rozhodnuti/postupy-a-dokumentace.md#r74-heslovite-poznamky): heslovité v PPTX
a podrobné v DOCX (asi 8 000 slov, 18 stran), bez času a odkazu na oddíl
([R82](../docs/rozhodnuti/postupy-a-dokumentace.md#r82-poznamky-bez-casu-a-odkazu)).

Šest úloh bez Excelu (vlastní, řešení jen v poznámkách): volba postupu, test dobré shody ručně,
pět chybných postupů, míry souvislosti v tabulce 2 × 2, výstup programu u malé studie, McNemarův
test. Doprovodný sešit podle
[R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-excelova-cviceni-prezentaci) má pět listů
s vlastními modelovými četnostmi (zadané hodnoty, bez simulace): U1_podil (16/36 a 64/144 proti
1/3), U2_dva_podily (45/60 a 33/60), U3_dobra_shoda (150 studentů proti podílům 35/30/20/15 %),
U4_tabulka (3 × 3, 200 studentů) a U5_parova_data (80 dvojic, neshodné 15 a 4). Řešení po
krocích, 5 kontrol funkcemi (CHISQ.DIST.RT, CHISQ.TEST, BINOM.DIST) a 18 nativních rovnic;
pomocná označení (*l*, *u* pro meze Wilsonových intervalů, *b*, *c* pro neshodné dvojice) jsou
na listech výslovně vysvětlena a nejsou novým značením učebnice. Pomocné grafy (5 stran, 16 : 9)
vytváří `scripts/kapitola_09-prezentace-cviceni-grafy.R` ze vstupů sešitu (balíček readxl).
Úlohy ze zdrojů převzaty nebyly; karty zdrojů se nemění. Devět obrázků kapitoly 9 (vlastní
tvorba) je převzato z `assets/chapter-09/plots/` v místním stavu, znovu se nevykreslovaly.
Na slidech jsou z kapitoly převzaté příklady se zdrojem: letní čas, vyhledání pomoci a aspirin
(Howell), studie Danielsové (podle Fielda et al.).

Postup: generátor v ignorovaném `tmp/chapter09-presentation/` navazuje na generátor kapitoly 8
(stejná předloha a vzhled); nové jsou vzorce kapitoly 9, čtyři vstupní sloupce v sešitu
a `notes-docx.cjs` bez řádků o čase a oddílu. Sešit sestavuje desktopový Excel přes
`scripts/excel-workbook.mjs`; sdílené skripty se neměnily. Do `.gitattributes` přidán scénář
kapitoly 9 (konce řádků LF kvůli SHA-256 v manifestu).

Scénář (4 860 slov, odhad 39–46 minut) pokrývá snímky 1–30; procvičování, otázky k zamyšlení
a organizační pokyny vynechává podle [TEXT2SPEECH.md](../docs/TEXT2SPEECH.md). Slovník výslovnosti,
kontroly a omezení jsou v
[průvodním dokumentu](../presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_scenar_podklady.md).

**Ověření:** všech 38 slidů vykresleno v PowerPointu a prohlédnuto v náhledech; každý slide má
poznámky, všech 24 výkladových slidů (včetně titulního) otázku v PPTX i DOCX; jazyk všech
textových polí a poznámek je čeština (objektový model PowerPointu); v textu PPTX ani DOCX
nezůstala značka formátování (kontrola odhalila a opravila čtyři místa); přehled obsahu se
shoduje s oddělovacími slidy; všech 24 odkazovaných oddílů v kapitole existuje. 43 skupin čísel
ze slidů, poznámek, úloh a sešitu přepočítáno nezávisle v R (`check.R` v tmp), bez rozdílu.
Sešit přepočítán v českém Excelu 16: 0 chybových buněk, všech 5 kontrol „Shoda s kroky“ = ano,
18 rovnic, prázdné pracovní buňky; listy prohlédnuty z exportu do PDF (dva listy ve zvětšení).
DOCX otevřen ve Wordu: 38 nadpisů „Slide N: titulek“, 18 stran, čeština. Všech 5 stran grafů
prohlédnuto. Scénář: 30 oznámení snímků v pořadí, žádné číslice, značky ani původní rizikové
podoby slov (strojová kontrola v `scenar-manifest.cjs`).

**Omezení:** 23 obsahových slidů za 45 minut je hodně a skutečná délka nebyla vyzkoušena.
Popisky uvnitř převzatých grafů, zejména konstrukce Newcombova intervalu a pokrytí, jsou při
projekci drobné; hlavní hodnoty opakuje text slidu a poznámky. Didaktická revize byla jen
vlastním čtením autora generátoru, bez samostatného čtenáře v roli studenta a bez ověření na
studentech. Heslovité poznámky v PPTX nebyly samostatně exportovány jako stránky s poznámkami.
Starší verze Excelu a PowerPointu, Excel pro Mac ani webový Excel nebyly zkoušeny. Zvuk
nevznikl; výslovnost přepisů (nejisté jsou Newcombe a Danielsová) není ověřena poslechem.
Studentský web se nemění, render knihy nebyl potřeba.

<a id="vizualizace-korelace"></a>

## 2026-11-23 — Vizualizace korelace v bodovém grafu (upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-23-korelace)
přibyla patnáctá stránka části „Interaktivní vizualizace“, první ke kapitole 10:
[Jak tvar mraku bodů souvisí s korelačním koeficientem](viz_korelace.qmd), v menu za
vizualizací měr souvislosti. Kapitola 10 na ni odkazuje dvěma bloky „Vyzkoušejte si“: na konci
pododdílu `sec-vydelime` (před rozšířením `#rozsireni-meze-r`) a na konci pododdílu
`sec-odlehle-korelace`; jinak se výklad kapitoly nemění. R71 je tím v bodě o vizualizacích
částečně nahrazeno ([doplnění R71](../docs/rozhodnuti/kapitola-10.md#r71-doplneni-2026-11-23)).
Obsahuje:

- **data:** úzkost a výkon 40 studentů (výchozí), spánek a pozornost z kapitoly 8, Anscombův kvartet I–IV, nový náhodný výběr 4–1 000 bodů;
- **ovládání:** posuvník a pole přesného výběrového *r*, pole $m_x$, $s_x$, $m_y$, $s_y$, přesun, přidání a smazání bodů myší, dotykem, klávesnicí a formulářem, přizpůsobení os;
- **zobrazení:** kvadranty, pravděpodobnostní elipsy s počty bodů uvnitř, regresní přímka a rezidua (vše ve výchozím stavu vypnuto), Vennův diagram *r*² (zapnut); přehled výpočtů s dosazením;
- **odvozené grafy** trvale pod hlavním grafem: bodový graf pořadí a graf spojnic;
- **oddíl „Pojmy, které kapitola 10 nevykládá“** se čtyřmi termíny jen pro vizualizaci (regresní přímka, reziduum, koeficient determinace, pravděpodobnostní elipsa) a značkami $\hat{y}$, $b_0$, $b_1$, $r^2$; doplněny do slovníku ([oddíl](../docs/SLOVNIK.md#vizualizace-korelace)), studentského slovníčku a přehledu značení s označením „Jen ve vizualizaci“.

Redakční volby při realizaci:

- **Přesná výběrová korelace.** Posuvník přepočítá Y vztahem $z_y'=r\,z_x+\sqrt{1-r^2}\,e$, kde *e* je normované reziduum $z_y$ vůči $z_x$; X, průměr a SD Y se nemění a opakovaný posun nehromadí chyby. Leží-li body na přímce, *e* se dolosuje (seed stránky). Text výslovně říká, že jde o výběrové *r*, ne o ρ.
- **Osy** se při úpravě bodů nemění (tažení je omezeno na osy); rozšíří se při zapnutí elips (elipsa 99 %), při změně průměrů a SD, při posuvníku, jen když body vyjdou mimo, a tlačítkem „Přizpůsobit osy“. Bod z formuláře smí ležet mimo osy.
- **Klávesnice:** graf je jedna zastávka klávesy Tab (`role="application"`); mezerník vybírá bod, šipky posouvají, Delete maže, Enter v režimu přidání přidá bod doprostřed; výsledek se čte z oblasti `aria-live`. Počty bodů v generovaném textu bez předložky („Vybraný bod č. 1 (bodů celkem 40)“), aby nevznikaly tvary „z 40“.
- **Graf spojnic** má poznámku, že polohy na obou osách lze porovnávat jen při stejné stupnici; uvádí „rozdíl průměrů Y − X“ místo „průměrné změny“, protože u nezávislých veličin nejde o změnu.
- **Elipsy** se počítají z výběrových průměrů, SD a *r* (poloměr $\sqrt{-2\ln(1-p)}$); u bodů na přímce se nekreslí.
- **Inspirace, ne převzetí** ([E09](../docs/zdroje/E09-magnusson-correlation.md#e09-magnusson-correlation)): kód, text ani data převzaty nejsou. Nepřevzato: načtení CSV, uložení stavu, „Anscombosaurus“. Vlastní doplňky: kvadranty, Spearmanův korelační koeficient, test, Fisherův interval, bodový graf pořadí, počty bodů uvnitř elips.
- **Balíček tutora:** do `VIZUALIZACE.md` přibyl řádek nové stránky (kontrola exportu vyžaduje záznam každé stránky `viz_*`). Verze tutora se nezvyšuje a nový export ani vydání neproběhly.

Nezávislá kontrola:

- **R** (`scripts/viz-korelace.R`, v repozitáři): data stránky porovnána se `scripts/kapitola_10.R`; pro úzkost a výkon, spánek, Anscombův kvartet, překlep 300 a pevné body průměry, SD, kovariance, *r*, $r_s$, *r*², přímka (`lm`), součet čtverců reziduí, test (`cor.test`), Fisherův interval a počty bodů uvnitř elips (`qchisq`); transformace na *r* = 0,3 a −0,8 a vzdálenost kruhů Vennova diagramu (`uniroot`). Čísla v textu stránky pocházejí z tohoto výstupu; shoda s kapitolou (−0,523, −0,555, −3,79, 0,0005, (−0,72; −0,25), překlep 300: 0,01 a −0,49). Vliv přidaného bodu (40; 30) a (60; 30) spočítán v R zvlášť.
- **Excel:** stránka vzorce Excelu nenabízí; výpočty korelací jsou na listech sešitu kapitoly 10.
- **Prohlížeč:** stránka prohlédnuta v panelu prohlížeče aplikace (desktop se všemi přepínači, odvozené grafy, 375 px bez přetékání) a na snímcích z `check-html.cjs`. Tažení bodu v panelu ověřeno událostmi ukazatele; skutečné tažení myší ověřuje `check-html.cjs`.
- **Citace:** podle znění zadaného autorem a doporučení stránky (verze 0.8.0, datum 2026-10-24 ze záznamu BibTeX stránky).

**Kontroly:** celá kniha vykreslena (Quarto 1.9.38, R 4.5.1). `check-html.cjs` s novým blokem a novým pořadím menu prošel celý bez chyb (první běhy odhalily jen chybějící stránku v očekávaném pořadí menu a bod mimo viditelnou část okna při tažení v samotné kontrole). Prošly `check-doc-maps.cjs`, `check-table-layout.cjs` a `check-chapter-10.R`. `check-tutor.cjs` hlásí změněný odstavec kapitoly 10 proti dříve exportovanému balíčku tutora; balíček se přegeneruje až při příštím exportu tutora.

**Omezení:** ověřeno v Chromiu; Firefox, Safari, skutečný telefon, dotykové tažení a čtečka obrazovky nebyly vyzkoušeny. Inspirační aplikace nebyla vyzkoušena v prohlížeči, jen přečten její text a prohlédnuty autorovy snímky. Didaktická revize je interní, ne ověření na studentech.

<a id="vizualizace-korelace-upravy"></a>

### Úpravy před sloučením (2026-11-23)

Podle [autorových připomínek k PR](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-23-korelace-upravy):

- **Rozvržení:** grafy pod sebou přes celou šířku: bodový graf, Vennův diagram, přehled, bodový graf pořadí, graf spojnic. Hlavní graf i graf pořadí mají čtvercovou kreslicí plochu; na celé obrazovce se strana čtverce omezí i výškou okna.
- **Osy:** symetricky kolem průměrů s týmž počtem směrodatných odchylek *K* na obou osách (nejvzdálenější *z*-skór obou proměnných, případně elipsa 99 %, krát 1,08). Čtvercový graf je tak čtvercový i v *z*-skórech; elipsy nejsou zkreslené a jejich délka a šířka jsou na obrazovce kolmé. Výchozí data: *K* = 2,712, osa X 8,32–38,83, osa Y 6,03–32,27 (shoda s R).
- **Myš:** přepínač „Co dělá myš v grafu“ přímo nad grafem; formulář pro nový bod odstraněn, pod grafem řádek „Ukazatel“ / „Tažený bod“ se souřadnicemi (bez `aria-live`). Kurzor podle režimu, v režimu odstranění se bod pod ukazatelem zvýrazní oranžovým kroužkem.
- **Délka a šířka elipsy:** nový přepínač (výchozí vypnuto); zelená a oranžová úsečka středem ve směrech stejných a opačných *z*-skórů, konce na elipse 99 %, poloviční délky $c\sqrt{1\pm|r|}$. Stránka je popisuje opisem bez termínu hlavní komponenta; přehled uvádí délky v *z*-skórech a poměr.
- **Interval:** přehled i text uvádějí $z_r$, směrodatnou chybu $1/\sqrt{n-3}$ a meze na stupnici $z_r$ před převodem zpět (výchozí data 0,164; −0,903 a −0,259).
- **Text:** úloha 2 a odstavec o odlehlém bodu pracují s kliknutím na (38; 31) a tažením do rohu (R: *r* −0,316, $r_s$ −0,443; (38,5; 32) *r* −0,295; (60; 31) *r* −0,082, $r_s$ beze změny); první odstavec „Čeho si všimnout“ doplňuje poměr délky a šířky 1,73 a 4,36.
- **Kontroly:** `scripts/viz-korelace.R` doplněn o meze na stupnici $z_r$, přidané body, rozsah os a délku a šířku elipsy přes `eigen(cor(x, y))` s ověřením, že konce leží na elipse 99 %. Blok v `check-html.cjs` ověřuje rozvržení, osy, délku a šířku elipsy, řádek ukazatele, přidání kliknutím a zvýraznění mazaného bodu. Celá kniha znovu vykreslena; `check-html.cjs` a `check-doc-maps.cjs` prošly bez chyb, snímky desktopu, celé obrazovky a 375 px prohlédnuty. Omezení jako výše (jen Chromium, bez skutečného dotykového zařízení a čtečky obrazovky).

<a id="tutor-041-20261121"></a>

## 2026-11-21 — AI tutor: výsledek testu 0.4.0 a kandidát 0.4.1 (SVG pro ChatGPT, data ke grafům všech kapitol)

**Test kandidáta 0.4.0.** Autor nahrál tři archivy 0.4.0 a sdělil, že je
přijaly všechny tři klienty a že kroky testu (`ai-tutor/test-0.4.0.md`,
[podmínky vydání](../docs/AITUTORS.md#podminky-vydani)) dopadly „v pořádku“.
Klient, model a tarif jednotlivých platforem sděleny nebyly a zůstávají
neupřesněné; podrobné záznamy kroků nejsou k dispozici. Zjištění z testu:
ChatGPT přibalené PNG nepřečetl a pracoval s texty kapitol, rejstříkem obrázků
a daty. Vydání `tutor-v0.4.0` zveřejněno není; čeká na pokyn autora.

**Archivy 0.4.0.** Při práci na 0.4.1 jsem zkušebním exportem omylem přepsal
místní archivy `…-0.4.0.zip` sestavením z rozpracovaného stavu. Odstraněny
a znovu sestaveny úplným exportem z čistého commitu `9e995a1` v oddělené
pracovní kopii (poté zrušené); zpráva exportu je v `ai-tutor/overeni-0.4.0.json`.
Obsah odpovídá otestovanému stavu zdrojů, soubory ZIP ale nejsou bajtově
tytéž, které autor nahrál (jiný čas sestavení a vykreslení PNG).

**Kandidát 0.4.1** podle [doplnění R85](../docs/rozhodnuti/ai-tutor.md#r85-doplneni-2026-11-21):

- *Formát obrázků podle platformy.* Plugin pro ChatGPT obsahuje původní SVG
  učebnice, varianta pro Claude PNG vykreslená z týchž SVG, Gemini žádné
  soubory obrázků. Instrukce mluví o „souboru obrázku“ bez přípony, takže
  tělo `SKILL.md` zůstává pro ChatGPT a Claude shodné.
- *Data ke grafům všech kapitol.* Skripty kapitol 1–9 nově zapisují ke každému
  obrázku záznam; zápis (`scripts/tutor/figure-data.R`) byl rozšířen o značky
  `plocha`, `interval`, `usecky`, `krabice` a `tabulka`, textový sloupec
  `kategorie`, skupiny sloupců, histogram v hustotě či podílech, vybarvená
  pásma a `tf_curve()`. Ze 147 obrázků má 121 data pro překreslení (16 092
  řádků) a 26 je schéma bez dat (u části s poznámkou o počtech prvků).
  Záznamy kapitol 1–8 zapsali pomocní agenti podle společného zadání, každý
  jednu kapitolu; kapitolu 9 jsem zapsal sám jako vzor.
- *Výukové plány* rozlišují u obrázku „s daty“ a „schéma bez dat“.
- Nový kontrolní skript `scripts/tutor/check-figure-data.cjs` (záznam ke
  každému obrázku kapitoly, sloupce podle značky, nejvýše 800 řádků na
  obrázek); tytéž kontroly opakuje `check-tutor.cjs` nad balíčkem.

**Kontroly.** Kreslicí kód se neměnil: všech 143 SVG z R je po úpravě skriptů
bajtově shodných se stavem před ní (otisky SHA-256 uložené před úpravou;
porovnáno po úplném exportu). `node scripts/export-tutor.cjs` včetně
`check-tutor.cjs` prošel: 10 kapitol, 147 obrázků, 121 s daty, největší
rejstřík 93,5 kB, `SKILL.md` 15 166 bajtů; ChatGPT 5,6 MB, Claude 8,5 MB,
Gemini 0,8 MB (45 souborů). `scripts/tutor/render-figure-data.cjs` vykreslil
všechny záznamy vedle originálů. Dvojice kapitol 1–8 prohlédli agenti, kteří
je zapisovali (podle jejich hlášení všechny); sám jsem prohlédl kapitolu 9
(tři dvojice) a po jedné až dvou dvojicích z kapitol 4, 6, 7 a 8: data
k překreslení stačí. U kapitol 3 a 8 agenti doložili shodu znovu spočteného
náhodného posunu bodů se souřadnicemi v SVG.

**Nezávislé čtení balíčku.** Agent v roli tutora prošel nad hotovým balíčkem
pro ChatGPT pět scénářů (krabicový graf s intervaly 8.5, plochy a skládané
sloupce 4.7, histogramy 6.4 a 6.8, schéma 1.5, mozaika a strom 5.4 a 5.6)
a skriptem zkontroloval všech 121 bloků dat: počty řádků, sloupce, pořadí
hodnot krabic, středy intervalů uvnitř mezí, součty podílů a plochy pod
histogramy; číselnou chybu nenašel. Podle jeho nálezů opraveno v pokynech:
soubor obrázku se nečte jako text; jednotné zacházení se schématem (soubor,
jinak popis a „Poznámka ke schématu“); vodicí čára nemusí být přerušovaná
a může být šikmá; pořadí panelů, skládání sloupců odspodu, směr u krabic,
tvar u značky `tabulka`, pomocné titulky a osy „bez měřítka“, barvy učebnice,
načítání velkých bloků kódem. Plány nově uvádějí, od kterého řádku záznamu
začínají data. Rozsahy os a polohy vodicích čar se zaokrouhlují na šest
platných číslic. U obrázku 8.5 doplněna poznámka, že okraje krabic jsou
panty, nikoli kvartily podle kapitoly 3. Neopraveno a předáno autorovi
k rozhodnutí, protože jde o obsah knihy, ne tutora: v převzatém obrázku 3.3
(`mode-median-mean.svg`) jsou popisky ve větvích podle jazyka prohlížeče
a čeština je jen výchozí; v obrázku 6.16 stojí „směrodatná chyba 2 bodu“;
textový popis obrázku 4.15 mluví o „červené“ křivce, která je oranžová;
krabicový graf 8.5 kreslí panty. Ponecháno: různé zařazení diagramů (část
jako schéma bez dat, v kapitole 5 jako tabulková data), vodorovné sloupce
obrázku 5.7 zapsané svisle s poznámkou a opakování téže křivky ve více řadách.

Při druhém úplném exportu kontrola věrnosti znovu zastavila běh na kapitole 8
(„Math: lost 10/\sqrt{25}=2“); opakovaný export se stejnými vstupy prošel.
Jde o tutéž nevysvětlenou občasnou chybu převodu jako 2026-11-20.

**Neověřeno.** Chování 0.4.1 v klientech: zda ChatGPT přibalené SVG zobrazí
nebo přečte (popisky jsou v SVG uloženy jako křivky), jak věrně klienti kreslí
z nových značek (intervaly, plochy, krabicový graf, tabulky) a zda rozsáhlejší
rejstříky (kapitola 4 má 4 400 řádků) nezhoršují čtení po rozsazích řádků.
Zbývajících deset dvojic kapitoly 10 jsem neprohlédl. Hlášení agentů
o prohlídce dvojic jsem přijal bez opakování celé prohlídky.

**První test 0.4.1 a oprava pokynů (týž den).** Autor poslal dva snímky.
Gemini u obrázku 10.1, který data má, graf nenakreslil: popsal jej a vypsal
adresu stránky i adresu samotného obrázku v blocích kódu jako zdvojený zápis
odkazu; podle autora jej odkazy „spíš matou“. ChatGPT u obrázku 10.2 napsal,
že původní soubor do chatu vložit nedokázal a že jej nenahradí „neověřeným
obrázkem“, a dal jen odkaz; z dat nekreslil. SVG tedy ChatGPT do odpovědi
nevkládá, stejně jako dříve PNG. Upraveno, verze kandidáta zůstává 0.4.1:

- `SKILL.md`: první možnost (přibalený soubor) platí jen tam, kde ji klient
  umí, a ChatGPT je výslovně poslán k překreslení z dat; při neúspěchu se
  přechází dál bez omluvy; graf z přibalených dat je označen za ověřený
  obrázek učebnice a adresa se k němu nepřidává; adresa se uvádí jednou, celá,
  v běžné větě, mimo blok kódu a závorky (dříve „jako prostý text“).
- Gemini: kapitola místo odkazu na web odkazuje na záznam v rejstříku;
  rejstřík místo adresy samotného obrázku nese řádek „Zobrazení“ (překreslit
  z dat bez adresy, nebo popsat a připojit adresu stránky). Počet řádků
  rejstříku se nezměnil, rozsahy v plánech platí dál. `check-tutor.cjs`
  ověřuje nové znění a že rejstřík pro Gemini neobsahuje adresu obrázku.

Autor poté rozhodl SVG z balíčku pro ChatGPT odstranit
([doplnění R85](../docs/rozhodnuti/ai-tutor.md#r85-doplneni-2026-11-21b)).
Export nově staví archiv pro ChatGPT z pracovní složky pluginu bez obrázků:
kapitoly a rejstříky jsou shodné s variantou pro Gemini, `SKILL.md` má znění
bez souborů (15 211 bajtů); 49 souborů, 1,6 MB. Z hlavního `SKILL.md` zmizela
zmínka o ChatGPT. `check-tutor.cjs` má novou část `--chatgpt` (seznam
souborů, shoda s Gemini a s pracovní složkou, místní odkazy)
a `release-tutor.cjs` ji předává. Při jednom běhu exportu se znovu projevil
občasný výpadek převodu, tentokrát v kapitole 7 (chybějící blok obrázku
`fig-ctyri-kombinace`); opakovaný běh prošel.
Neověřeno: účinek úprav v klientech; snímky byly z kapitoly 10, obrázky
ostatních kapitol (8.5, 6.14, 2.6, schéma 1.5) v klientech doloženy nejsou.
Příčinu, proč Gemini nekreslil, neznám (mohlo jít i o režim bez kreslení).

**Druhý test 0.4.1 a ověřovací otázky (týž den).** Po nahrání opravených
archivů autor sdělil: „grafy nyní fungují dobře ve všech tutorech“; klient,
model a tarif nejsou zaznamenány a které obrázky zkoušel, nevím. Zároveň
popsal občasnou chybu vedeného vysvětlování: tutor v kapitole 10 položil
otázku „Ve studii učitelky (úzkost a výkon u 40 studentů) jde o korelační,
nebo o experimentální uspořádání?“, aniž bylo zřejmé, že jde o příklad
z kroku 1, a po námitce studenta odkázal na „text učebnice“. Upraveno:
`SKILL.md` říká, že student učebnici nečetl a zná jen to, co zaznělo
v rozhovoru, a že otázka vracející se k dřívějšímu příkladu to má říci
a potřebné údaje zopakovat; `OTAZKY.md` má nové první pravidlo se stejným
obsahem a s postupem při námitce „údaje nemám“. Scénář je doplněn do
`scripts/tutor/smoke-prompts.md`. Účinek v klientech ověřen není.

**Koncept vydání 0.4.1 (týž den).** Autor sloučil PR #225 a dal pokyn
připravit vydání. Archivy jsou z čisté revize `d1b6d31` (obsahově shodné
s `main` po sloučení). `release-tutor.cjs` při suchém běhu selhal, protože
kontrole nepředával cestu ke kontrolním datům (`--data`); opraveno. Koncept
`tutor-v0.4.1` se třemi archivy je na GitHubu vytvořen, nezveřejněn;
zveřejnění a ověření odkazů `releases/latest/download/` je na autorovi.
Vydání `tutor-v0.4.0` nevzniklo. Dokončená větev `codex/infrastructure`
byla po ověření sloučení odstraněna a pro opravu skriptu založena znovu.

<a id="tutor-040-20261121"></a>

## 2026-11-21 — AI tutor 0.4.0 (kandidát): kapitoly 1–10, nové instrukce, PNG a data ke grafům

Podle [R85](../docs/rozhodnuti/ai-tutor.md#r85-tutor-kapitoly-obrazky-tempo)
připraven kandidát tutora 0.4.0 pro ChatGPT, Claude a Gemini. Vydání zveřejněno
není; stránka [AI tutor: stažení a instalace](ai_tutor.qmd) už popisuje stav
0.4.0, proto se tato větev slučuje až po zveřejnění vydání.

**Export.** Přibaluje všechny výkladové kapitoly podle `_quarto.yml` (1–10)
a deset výukových plánů s rozsahy řádků oddílů, zvlášť zadání a řešení cvičení
a nepovinných bloků. Obrázky jdou do balíčků jako PNG vykreslené z týchž SVG
(`scripts/tutor/svg-to-png.cjs`); rejstřík obrázků je po kapitolách
(`references/obrazky/`) a uvádí i přímou adresu obrázku na webu. Skript
kapitoly 10 zapisuje ke všem 17 obrázkům popis a vykreslené hodnoty
(`scripts/tutor/figure-data.R`), které rejstřík přibaluje jako blok „Data pro
překreslení“. `KAPITOLY.json` je malý katalog s verzí a revizí; údaje pro
kontrolu jsou mimo balíček. Archiv pro Gemini má jen soubory `.md` a `.txt`
a `SKILL.md` v kořeni. Z balíčku vyřazen autorský návod
`PRIPOJENI-KAPITOL.md`; jeho obsah je v [provozním návodu](../docs/PROVOZ.md#export-ai-tutora).

**Instrukce.** `SKILL.md` přepsán celý: blok „Vždy“, tabulka „Co kdy číst“,
vedené vysvětlování po krocích (jedna myšlenka, jedna otázka, čekání),
oddělená pravidla ostatních způsobů práce, obrázek učebnice jako součást
kroku přímo v odpovědi, doslovné opisování adres a nabídka interaktivní
stránky u příslušného oddílu. `VIZUALIZACE.md` nově obsahuje pravidla
překreslení z dat, rady ke všem 14 interaktivním stránkám a zkrácená pravidla
vlastního grafu; autorské testování grafů zůstává v testovacích scénářích.

**Kontroly.** `node scripts/export-tutor.cjs` a `node scripts/check-tutor.cjs`
prošly; počty jsou v `ai-tutor/overeni.json`. Kontrola nově ověřuje začátek
i konec každého rozsahu řádků, oddělení zadání od řešení, jedno platné PNG ke
každému obrázku a žádné SVG v balíčku, shodu rejstříků a bloků dat
s exportovanými daty a přítomnost všech interaktivních stránek ve
`VIZUALIZACE.md`. Obrázky kapitoly 10 se úpravou skriptu nezměnily (shoda
souborů před a po). `scripts/tutor/render-figure-data.cjs` vykreslil všech
17 záznamů; prohlédnuto sedm dvojic originál × překreslení (10.1, 10.2,
kvadranty, přesné permutační rozdělení, faktory, Fisherova transformace,
bodově biseriální korelace): data k překreslení stačí, zbylých deset dvojic
prohlédnuto nebylo. Instrukce přečetl nezávislý agent v roli tutora nad hotovým balíčkem (pět
scénářů, obě varianty). Podle jeho nálezů opraveno: odkaz na pravidla
překreslení a rady ke stránkám přímo v `SKILL.md`; označení obrázků
z nepovinných částí a nepovinných bloků uvnitř oddílů v plánech; rozsahy
řádků úvodů oddílů a hesel přehledů; spouštěč vlastního grafu; pravidlo
o adresách (adresu oddílu lze složit jen z kotvy v plánu); seznam možností
zobrazení pro variantu bez souborů obrázků; velikost kroku, pořadí obrázku
a otázky, tempo bez ověřování a návrat po přímém dotazu; uvozovky u textových
polí s čárkou v blocích dat; chybný údaj „kosočtverce“ v textovém popisu
obrázku 10.14 (zdroj `kapitola_10.qmd`, v obrázku jsou kolečka). Neopraveno
a ponecháno jako známé: zbytky značek `<sub>` z převodu v plánech a kapitolách
a autorské poznámky v tabulkách plánů převzaté z kapitolových karet.

**Zjištění z klientů (pozorování autora, ne systematický test).** Claude
i ChatGPT přijaly archiv se 183 a 187 soubory (se SVG). Gemini ohlásil chybu
nahrání, přestože se dovednost uložila. Claude ukázal přibalený obrázek jen
jako kartu souboru v postranním panelu a bez vyžádání jej nenabídl. Gemini
posílal vymyšlené adresy učebnice obalené vyhledáváním.

**Neověřeno.** Chování nových instrukcí v klientech: tempo, zobrazení
a překreslení obrázků, nabídka interaktivních stránek, adresy v Gemini,
využití rozsahů řádků; přijetí archivů s PNG (Claude 8,4 MB místo 4,7 MB);
[podmínky vydání](../docs/AITUTORS.md#podminky-vydani) zatím nesplnila žádná
platforma. Při jednom z běhů exportu 2026-11-20 se v kapitole 8 tiše ztratila
část odstavce; kontrola věrnosti běh zastavila, chyba se v dalších bězích ani
v 74 opakováních převodu neobjevila a příčina známa není. Data ke grafům
kapitol 1–9 nejsou hotová.

<a id="rozsireni-n-minus-1-20261117"></a>

## 2026-11-17 — Nepovinné rozšíření o dělení n − 1 v kapitole 3

Na žádost autora doplněno na konec oddílu
[Proč při odhadování používáme n − 1](kapitola_03.qmd#sec-korekce-rozptylu)
nepovinné rozšíření [Proč právě n − 1](kapitola_03.qmd#rozsireni-korekce-rozptylu)
([R83](../docs/rozhodnuti/kapitola-03.md#r83-rozsireni-proc-n-minus-1)):
dělení $n$ při známém μ; rozklad součtu čtverců kolem μ na součet kolem $m$
a „úbytek“ $n(m-\mathrm{μ})^2$, ověřený na pěti časech kapitoly a zdůvodněný
slovně; úplný výčet čtyř výběrů dvou hodnot z populace 4 a 8 minut
(tabulka `tbl-k03-12`); obecný závěr $(n-1)\,\mathrm{σ}^2$ s odkazem na
směrodatnou chybu průměru v kapitole 6. Nový obrázek
`rozklad-souctu-ctvercu.svg` (`scripts/kapitola_03.R`) a nepovinné cvičení 16
(populace 3 a 9 minut, tabulka `tbl-k03-13`). Povinný text získal jedinou
větu s odkazem; shrnutí, slovníček, značení ani přehled Excelu se neměnily.
Sešit kapitoly 3 má dva nové vstupní listy `Dve_hodnoty` a `U16_populace`
(34 listů). Aktualizována [karta kapitoly](../docs/kapitoly/03-poloha-variabilita.md#mapa-kapitola-03),
[pokrytí daty](../docs/DATA.md#kapitola-3), mapa knihy a
[karta Howella](../docs/zdroje/U01-howell.md#rozsireni-03-20261117).

**Kontroly:** `scripts/kapitola_03.R` nově úplným výčtem ověřuje pro obě
populace rozklad v každém výběru a průměry $n\,\mathrm{σ}^2$, $\mathrm{σ}^2$,
$\mathrm{σ}^2/n$, $(n-1)\,\mathrm{σ}^2$ i obou variant rozptylu, dále čísla
27 = 22 + 5 a 6,4 a obecnost pro $n=3$ z pětihodnotové populace;
`check-chapter-03.R` prošel (16 řešení). Sešit sestaven
`build-workbooks.ps1 -Chapter 3 -Verify` v desktopovém Excelu (247 vstupních
buněk, numerické kontroly a kontrola chyb vzorců bez chyb);
`check-workbooks.py` po renderu prošel. Celá kniha vykreslena;
`check-html.cjs` prošel s upraveným počtem řešení (16) a obrázků (18)
kapitoly 3 a s novým rozšířením v kontrole sbalení a mobilního přetékání;
`check-doc-maps.cjs` bez chyb. Rozbalené rozšíření a řešení cvičení 16
prohlédnuty na snímcích při šířce 1280 a 375 px: rovnice se stojatým μ a σ,
souhrnný řádek tabulek, obrázek i odkazy jsou v pořádku, stránka vodorovně
nepřetéká a široká tabulka se na mobilu posouvá místně. Didaktická revize:
rozšíření nezavádí nový termín ani symbol, každý krok navazuje na pojmy
oddílu a nejdelší věty zkontrolovány výpočtem.

**Neověřeno:** pracovní PDF kapitoly 3 ani PDF celé knihy nebyly sestaveny
(jen na vyžádání), takže sazba rozšíření a nové tabulky v PDF zkontrolována
není. Balíčky AI tutora nebyly znovu exportovány ani vydány;
`check-tutor.cjs` má upravený očekávaný počet řešení kapitoly 3 (16), ale
proti dosavadnímu exportu neprochází už kvůli dřívější změně úvodu knihy.
Howell byl čten jen v textové extrakci. Automatické číslo tabulek kapitoly 3
za novou tabulkou se posunulo o jednu (ID beze změny). Porozumění rozšíření
nebylo ověřeno na studentech.

<a id="poznamky-bez-casu-a-podkladu-20261117"></a>

## 2026-11-17 — Podrobné poznámky k prezentacím bez času a odkazu na oddíl

Na žádost autora odstraněny z poznámek k prezentacím všechny odrážky
„Čas pro vyučujícího: …“ a „Podklad: kapitola N, …, příslušný oddíl:
https://…“, včetně dovětku „Příklady jsou modelové výukové údaje…“, který
v kapitolách 2–7 byl součástí téže odrážky:

- `presentations/kapitola_02/` až `kapitola_08/` `*_poznamky.docx`:
  216 odrážek s časem a 170 s podkladem;
- poznámky řečníka v PPTX kapitol 2–6 (starší podoba před R74): 152 odrážek
  s časem a 122 s podkladem. PPTX kapitol 7 a 8 je už neobsahovaly.

Kapitola 1 takové odrážky neměla v DOCX ani PPTX. Ponechány jsou organizační
pokyny jiného typu, např. „Organizace výuky: …“ v DOCX kapitoly 2
a „Doporučený postup: přibližně N minut …“ u slidů s cvičeními.
Odstraňovány byly celé odstavce v `word/document.xml`, resp.
`ppt/notesSlides/*.xml`; ostatní členy balíčků zůstaly beze změny.

**Kontroly:** porovnání textu odstavců se stavem v Gitu ukázalo jen
odstranění uvedených odrážek, žádnou jinou změnu a žádný slide bez poznámek;
po úpravě v souborech nezůstal žádný výskyt „Čas pro vyučujícího“
ani „příslušný oddíl“. Desktopový Word otevřel všech osm DOCX a PowerPoint
pět upravených PPTX bez chyby; všechny slidy mají neprázdné poznámky.
PDF prezentací poznámky neobsahují a nebyly měněny.

**Omezení:** [pokyny k prezentacím](../docs/PREZENTACE.md#poznamky-v-docx)
nadále předepisují do DOCX čas pro vyučujícího i odkaz na oddíl kapitoly;
pravidlo zatím nebylo změněno. Otisky `sha256` DOCX v manifestech scénářů
kapitol 5–8 zachycují vstup v době tvorby scénáře a s upravenými soubory
se už neshodují; scénáře samotné tyto odrážky neobsahovaly.

<a id="odvozeni-wilsonova-intervalu-20261117"></a>

## 2026-11-17 — Nepovinné odvození Wilsonova intervalu v kapitole 9

Na žádost autora doplněno na konec pododdílu
[Wilsonův interval](kapitola_09.qmd#sec-wilson) nepovinné rozšíření
[Odvození Wilsonova intervalu](kapitola_09.qmd#rozsireni-wilson-odvozeni)
([doplnění R68](../docs/rozhodnuti/kapitola-09.md#r68-doplneni-2026-11-17)):
podmínka s absolutní hodnotou, umocnění, kvadratická nerovnice, připomenutý
vzorec pro kořeny se zápisem $Ax^2+Bx+C=0$, úprava výrazu pod odmocninou,
výsledný tvar střed ± polovina šířky a kontrola na příkladech 10 z 20
a 0 z 15. Nový obrázek `wilson-odvozeni.svg` (`scripts/kapitola_09.R`) ukazuje
obě strany nerovnice pro 10 z 20. Povinný text získal jedinou větu s odkazem
na rozšíření; vzorec, sešit, cvičení ani přehled značení se neměnily. Pojem
kvadratická rovnice doplněn do [slovníku](../docs/SLOVNIK.md#pojem-kvadraticka-rovnice)
a studentského slovníčku jako pojem nepovinného rozšíření; aktualizována
[karta kapitoly](../docs/kapitoly/09-podily-kategorialni-data.md#skutecny-obsah-09)
a [provozní návod](../docs/PROVOZ.md#kontroly-a-github).

**Kontroly:** `check-chapter-09.R` prošel; nově porovnává kořeny kvadratické
rovnice s uzavřeným vzorcem, s `prop.test(..., correct = FALSE)` a s `polyroot`
pro pět dvojic (včetně 10/20 a 0/15), ověřuje oba tvary výrazu pod odmocninou
a čísla citovaná v rozšíření (3,8415; 0,192; 1,192; 0,299; 0,701; 18,8415;
0,204; vrchol meze 0,048 v alternativním textu). Celá kniha vykreslena;
`check-html.cjs` prošel bez chyb (26 stránek, 343 hesel slovníčku, 133 řešení),
s upraveným počtem obrázků kapitoly 9 (12) a s novým rozšířením v kontrole
výchozího sbalení. `check-doc-maps.cjs` bez chyb. Rozbalené rozšíření
prohlédnuto na snímcích při šířce 1280 a 375 px: rovnice se vykreslují se
stojatým π a desetinnými čárkami bez mezery, nejdelší úprava je rozdělena
do tří řádků a stránka vodorovně nepřetéká; obrázek se na mobilu posouvá
místně jako ostatní obrázky kapitoly. Délka vět rozšíření ověřena výpočtem
(žádná nad 30 slov). Didaktická revize: každý krok úpravy je pojmenován,
absolutní hodnota, kořen a kvadratická rovnice jsou vysvětleny na místě,
rozšíření nepoužívá dosud nezavedený skórový test.

**Neověřeno:** pracovní PDF kapitoly 9 ani PDF celé knihy nebyly sestaveny
(jen na vyžádání), takže sazba rozšíření v PDF zkontrolována není. Balíčky
AI tutora nebyly znovu exportovány ani vydány. Odkaz z textu vede na záhlaví
sbaleného bloku; ten se stejně jako u ostatních rozšíření sám nerozbalí.
Porozumění odvození nebylo ověřeno na studentech.

## 2026-11-17 — Materiály k prezentacím ve složkách podle kapitol

Na žádost autora rozděleny soubory ve `presentations/` do podsložek
`presentations/kapitola_01/` až `presentations/kapitola_08/`; názvy souborů
se nezměnily. Přesunuty všechny PPTX, PDF, DOCX, sešity cvičení, PDF s grafy,
scénáře, manifesty a průvodní dokumenty, místně i Gitem ignorované MP3.
Pravidlo umístění aktualizováno v [pokynech k prezentacím](../docs/PREZENTACE.md)
a příklad cesty v [TEXT2SPEECH.md](../docs/TEXT2SPEECH.md); `.gitignore` nyní
ignoruje `presentations/**/*.mp3` a `.gitattributes` míří na novou cestu
scénáře kapitoly 8. Upraveny vstupní a výstupní cesty skriptů
`scripts/kapitola_0[678]-prezentace-*.R`, cesty v manifestech a průvodních
dokumentech, odkazy v kartách kapitol 5–8 a hypertextové odkazy v této
historii. Cesty uvedené v kódu ve starších záznamech zachycují tehdejší stav
a zůstávají beze změny. Obsah souborů kromě cest se neměnil; samotné MP3,
PPTX, DOCX ani XLSX nebyly otevírány ani upravovány.

Ověřeno, že všechny relativní odkazy na `presentations/` v dokumentaci vedou
na existující soubory (včetně odkazů `../../` z průvodních dokumentů,
upravených kvůli větší hloubce složky), cesty ve skriptech R na existující
soubory a ve složce nezůstal žádný soubor mimo podsložky.
Skripty R prošly syntaktickou kontrolou, ale nebyly znovu spuštěny.
Manifest kapitoly 5 nadále uvádí `kapitola_05_pravdepodobnost_Adam.mp3`,
místní soubor se však jmenuje `kapitola_05_pravdepodobnost.mp3`; tento
starší nesoulad nebyl opravován.


<a id="audio-kapitoly-8-20261117"></a>

## 2026-11-17 — Nahrávka k prezentaci kapitoly 8 hlasem Adam

Na výslovnou žádost autora převeden nezměněný scénář snímků 1–31
na úplnou nahrávku přes Creative Claw. Původní požadavek s HeyGen hlasem
byl odmítnut před syntézou bez účtování. Autor následně výslovně určil
model `speech/elevenlabs-v4`, veřejný hlas Adam – Velvety and Conversational
(`uYFJyGaibp4N2VwYQshk`) a `extras.language_code: cs`.
Aktuální parametry modelu ověřeny před převodem; použity časové značky
slov a MP3 44,1 kHz / 192 kb/s, bez nepodporovaných ovladačů a bez dalších
náhrad služby. Výslovnostní přepisy jsou již ve scénáři.

Limit 10 000 znaků vyžadoval čtyři části, snímky 1–11, 12–18, 19–26
a 27–31. Jejich úplné texty pokrývají původní scénář přesně jednou.
Všechny části dokončeny, přes Creative Claw spojeny bez prolínání
do jednoho WAV a lokálně převedeny do jediného MP3 s úpravou celkové
hlasitosti. Výstup `presentations/kapitola_08_porovnani_dvou_prumeru_Adam.mp3`
má přibližně 43:09 a 31 značek snímků podle časů slov a skutečných délek
částí. MP3 je ignorované Gitem, nebylo vloženo do prezentace ani publikováno.
Rozšířen [manifest](../presentations/kapitola_08/kapitola_08_porovnani_dvou_prumeru_scenar_manifest.json),
[průvodní dokument](../presentations/kapitola_08/kapitola_08_porovnani_dvou_prumeru_scenar_podklady.md#audio-kapitoly-8-20261117)
a karta kapitoly; výklad, scénář, PPTX a DOCX se nezměnily.

Ověřeno dekódování, délka, všech 31 značek a shoda celého textu časovaných
slov se scénářem po sjednocení interpunkce, mezer a velikosti písmen.
Dekódované vzorky spojeného WAV jsou přesně shodné se vstupy převedenými
do téhož formátu a seřazenými za sebou; ověřeno tím úplné spojení bez
vynechání, duplikací a překrytí. Zkontrolována hlasitost a pauzy.
Podrobné výsledky a otisk MP3 jsou v manifestu; požadavky, úlohy a média
pro cílené opravy v ignorovaném `tmp/ch08-audio-elevenlabs/`.
Služba vykázala 688 kreditů za řeč a 2 za spojení.
Nejde o poslech ani nezávislou transkripci; skutečná výslovnost nebyla ověřena.

<a id="scenar-kapitoly-8-20261117"></a>

## 2026-11-17 — Scénář zvukového doprovodu prezentace kapitoly 8

Na výslovnou žádost autora připraven
[mluvený scénář v UTF-8](../presentations/kapitola_08/kapitola_08_porovnani_dvou_prumeru_scenar.txt)
ke snímkům 1–31 aktuální prezentace a podrobným poznámkám v DOCX.
Vynechává procvičování na snímcích 32–39, diskusní otázky a organizační pokyny.
Text má 4 934 slov, odhad 39–47 minut při 105–125 slovech za minutu;
nejde o změřenou délku nahrávky. Čísla, značky a operace jsou rozepsány
pro poslech a výslovnostní přepisy podle R53 uplatněny v celém textu.
Připojen [průvodní dokument](../presentations/kapitola_08/kapitola_08_porovnani_dvou_prumeru_scenar_podklady.md)
a [manifest](../presentations/kapitola_08/kapitola_08_porovnani_dvou_prumeru_scenar_manifest.json)
s otisky podkladů, mapováním úseků, slovníkem a výsledky kontrol;
odkazy doplněny do karty kapitoly. PPTX, DOCX ani výklad kapitoly nebyly měněny.

Ověřeno pořadí 31 úseků, nepřítomnost číslic a nezpracovaných značek,
použití přepisů včetně `kvantyl`, shoda s textem snímků a podrobnými poznámkami.
Vizuálně prohlédnuto všech sedm vložených obrázků. Nezávislý přepočet
pomocí základního R 4.5.1 (`stats::t.test`) potvrdil použité příklady testů
a intervalů včetně Welchových neceločíselných stupňů volnosti,
porovnání změn, ekvivalence a standardizací. U souhrnných vstupů byly
pro kontrolní test vytvořeny pomocné vektory se stejnými průměry a SD,
nikoli rekonstruována původní individuální data. Provedena interní
didaktická revize návazností a významu vzorců, grafů a závěrů.

Omezení: původní odborné zdroje nebyly nově ověřovány, prezentace nebyla
znovu renderována v PowerPointu a desktopový Excel nebyl spuštěn.
Zvuk nevznikl, služba syntézy nebyla volána; textová kontrola nepotvrzuje
výslovnost konkrétního hlasu a nejde o poslechové ověření.

<a id="prezentace-kapitoly-8-20261117"></a>

## 2026-11-17 — Prezentace ke kapitole 8

Vytvořeny soubory v `presentations/`: `kapitola_08_porovnani_dvou_prumeru.pptx` (39 slidů),
`kapitola_08_poznamky.docx`, `kapitola_08_porovnani_dvou_prumeru_cviceni.xlsx` a
`kapitola_08_porovnani_dvou_prumeru_cviceni_grafy.pdf`. Rozsah dohodnut s autorem 2026-11-17:
jedna výuka za celou kapitolu (45 minut výkladu, 45 minut procvičování), všech pět nepovinných
rozšíření vynecháno; výstupy PPTX, DOCX, sešit a pomocné grafy k excelovým úlohám, bez PDF
prezentace, scénáře a audia. **Welchův *t*-test je podle pokynu autora z téhož dne vyložen jen
jako princip:** jeden slide ukazuje, že se oproti klasickému testu jinak počítá směrodatná chyba
(rozptyly skupin zvlášť) a počet stupňů volnosti (korigovaný), a porovnává hotové výsledky
varianty B; výpočet ručně ani v Excelu (vzorec stupňů volnosti, BETA.INV, T.TEST typu 3) se
v prezentaci, úlohách ani sešitu nepožaduje. Jde o rozsah této výuky, kapitola se nemění.

Výklad má 22 obsahových slidů v sedmi oddílech podle
[R50](../docs/rozhodnuti/postupy-a-dokumentace.md#r50-struktura-prezentaci): párová data, nebo
nezávislé skupiny; párový *t*-test; kdy párování zpřesňuje odhad; dvě nezávislé skupiny; jak
velký je rozdíl; rozdíl posuzujeme přímo (intervaly vedle sebe, změna ve dvou skupinách,
ekvivalence dvou skupin); volba postupu a sdělení výsledků. Nenulová testovaná hodnota
párového testu, tabulka odolnosti a ukázka zprávy pro variantu A jsou jen v poznámkách;
ukázka zprávy na slidu je zkrácena o interval pro *d* (nepovinné rozšíření). Poznámky mají dvě
podoby podle [R74](../docs/rozhodnuti/postupy-a-dokumentace.md#r74-heslovite-poznamky):
heslovité v PPTX a podrobné v DOCX (asi 8 800 slov, 20 stran).

Šest úloh bez Excelu (vlastní, řešení jen v poznámkách): rozpoznání uspořádání, párový *t*-test
ze souhrnů, výroky o přínosu párování, Cohenovo *d* a jeho jmenovatel, čtyři chybné závěry,
volba postupu a zpráva. Doprovodný sešit podle
[R33](../docs/rozhodnuti/postupy-a-dokumentace.md#r33-excelova-cviceni-prezentaci) má čtyři
listy s vlastními modelovými daty: U1_parova_data (14 studentů, dvě neúplné dvojice, simulace,
seed 801), U2_dve_skupiny (16 a 15 studentů; seed 842 vybrán z 805–860 tak, aby rozdíl byl
středně velký a statisticky významný), U3_zmeny_skupin (2 × 14 studentů před a po; seed 8312
vybrán tak, aby změna byla významná jen v intervenční skupině a rozdíl změn ne) a
U4_ekvivalence (zadané souhrny velké a malé studie, Δ = 5). Řešení po krocích, 17 kontrol
funkcemi (PRŮMĚR, SMODCH.VÝBĚR.S, T.TEST typu 1 a 2, CONFIDENCE.T, T.DIST.2T, T.INV.2T)
a 24 nativních rovnic. Pomocné grafy (4 strany, 16 : 9) vytváří
`scripts/kapitola_08-prezentace-cviceni-grafy.R` ze vstupů sešitu (balíček readxl). Howellovy
úlohy použity nebyly; karty zdrojů se nemění. Kapitola 8, slovník, osnova ani
`data/kapitola_08.xlsx` se neměnily; věcný rozpor mezi kapitolou a prezentací nebyl zjištěn.
Šest obrázků kapitoly 8 (sedm vložení; vlastní tvorba) je převzato z `assets/chapter-08/plots/`
ve stavu z 2026-11-16, novějším než `scripts/kapitola_08.R`, proto se znovu nevykreslovaly.

Postup: generátor v `tmp/chapter08-presentation/` navazuje na generátor kapitoly 7 (stejná
předloha a vzhled). Heslovité poznámky zapisuje přímo do PPTX z pole `short`, podrobné poznámky
jsou v samostatném souboru a DOCX se sestavuje z něj; nové jsou vzorce párového a klasického
testu, společného odhadu rozptylu a Cohenova *d* a dolní indexy v DOCX. Sešit sestavuje
desktopový Excel přes `scripts/excel-workbook.mjs`; sdílené skripty se neměnily.

**Ověření:** všech 39 slidů vykresleno v PowerPointu a prohlédnuto; každý slide má poznámky,
všech 23 výkladových slidů otázku v PPTX i DOCX; jazyk všech 217 textových polí a 39 poznámek
je čeština (objektový model PowerPointu); v textu PPTX ani DOCX nezůstala značka formátování;
přehled obsahu se shoduje s oddělovacími slidy; všech 22 odkazovaných oddílů v kapitole
existuje. 29 skupin čísel ze slidů, poznámek, úloh a sešitu přepočítáno nezávisle v R
(`check.R` v tmp); přepočet odhalil zaokrouhlení *p*-hodnoty úlohy 2 (0,025, ne 0,024),
opraveno. Sešit přepočítán v českém Excelu 16: 0 chybových buněk, všech 17 kontrol „Shoda
s kroky“ = ano, 24 rovnic, prázdné pracovní buňky; listy prohlédnuty z exportu do PDF. DOCX
otevřen ve Wordu: 39 nadpisů „Slide N: titulek“, 20 stran, čeština. Všechny 4 strany grafů
prohlédnuty. Didaktická revize samostatným čtením v roli studenta: zapracováno mimo jiné
doplnění, že i v protipříkladu 2, 4, 6 / 6, 12, 18 je párový odhad přesnější, omezení pravidla
o nepřekrývajících se intervalech na podobně velké a variabilní skupiny, doplnění kvantilů
a mezivýpočtů v poznámkách a směru rozdílu v úloze 6.

**Omezení:** výklad trvá podle součtu časů 45 minut; 22 slidů za tuto dobu je hodně a skutečná
délka nebyla vyzkoušena. Popisky uvnitř převzatých grafů jsou při projekci drobné; hlavní
hodnoty opakuje text slidu. Starší verze Excelu a PowerPointu, Excel pro Mac ani webový Excel
nebyly zkoušeny. Didaktická revize byla interní, bez ověření na studentech. Studentský web se
nemění, render knihy nebyl potřeba.

<a id="vizualizace-miry-souvislosti"></a>

## Vizualizace rozdílu podílů, poměru rizik a poměru šancí (2026-11-20, upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-20-miry)
přibyla čtrnáctá stránka části „Interaktivní vizualizace“, druhá ke kapitole 9:
[Co říkají rozdíl podílů, poměr rizik a poměr šancí o téže tabulce](viz_miry_souvislosti.qmd),
v menu za vizualizací chí-kvadrát. Kapitola 9 na ni odkazuje blokem „Vyzkoušejte si:
rozdíl podílů, poměr rizik a poměr šancí“ na konci pododdílu `sec-phi-v`, před
rozšířením o intervalech poměrů; jinak se výklad kapitoly nemění. Obsahuje:

- **zadání:** přepínač mezi tabulkou četností 2 × 2 (výchozí údaje Danielsové) a dvěma riziky posuvníky ve stejně velkých skupinách (100, 1 000 nebo 10 000 osob) s volbou míry držené pevně; předvolby Danielsová a aspirinová studie; záměna referenční skupiny;
- **dvě skupiny osob:** pole teček s pohledem na riziko a na šance, slovní čtení a všechny míry s dosazením;
- **vliv rizika v referenční skupině:** graf a tabulka čar stejného rozdílu rizik, stejného poměru rizik a stejného poměru šancí;
- **retrospektivní výběr:** posuvník podílu zařazených osob bez jevu, pole osob a srovnávací tabulka;
- **koeficient φ:** χ², φ se znaménkem a jako součin rozdílu řádkových a sloupcových podílů.

Redakční volby při realizaci:

- **Inspirace, ne převzetí.** Členění vychází z článku Magnussona ([E08](../docs/zdroje/E08-magnusson-odds-ratio.md#e08-magnusson-odds-ratio)), který stránka cituje; kód, text ani příklady převzaty nejsou. Místo logistické křivky na stupnici logaritmu šancí je graf na běžné stupnici rizika 0–1 (riziko ve srovnávané skupině proti riziku v referenční), aby nevznikl nový pojem. Část o adjustaci a počet léčených (NNT) chybějí záměrně.
- **Slovní čtení jako „násobek“** („riziko je 2,34násobkem“), aby věta platila i pro poměry menší než 1. Věta o vzácném jevu se zobrazí, když se oba poměry liší o méně než asi 5 %.
- **Počty osob bez předložky** v generovaných popiscích („téma přítomno 56, celá skupina 140 osob“), aby nevznikaly tvary „z 140“; výraz „kolik osob ze 100 / z 1 000 / z 10 000“ volí základ podle menšího rizika. Nenazývá se „přirozené četnosti“, protože slovník je vymezuje jako členění jedné společné skupiny.
- **Dělení nulou** dává „nelze spočítat“ s důvodem místo nekonečna; prázdnou skupinu vizualizace odmítne.
- **Pole osob** kreslí tabulku osobu po osobě do 25 000 osob (aspirinová studie má 22 071), větší tabulky přepočítá na 10 000 osob na skupinu s označením „přibližně“.
- **Držení míry** si pamatuje hodnotu z okamžiku volby nebo poslední změny rizika ve srovnávané skupině; když stejný rozdíl nebo poměr rizik vede mimo rozsah 0–1, riziko se nastaví na krajní hodnotu s upozorněním a po návratu se míra obnoví.
- **Barvy** skupin podle obrázku kapitoly (oranžová pro srovnávanou, modrá pro referenční skupinu); čáry se liší barvou i typem čáry.

Nezávislá kontrola:

- **R** (`scripts/viz-miry-souvislosti.R`, v repozitáři): Danielsová, zaměněné skupiny, aspirin, úloha 10 a dvě zadání riziky; χ² porovnáno uvnitř skriptu s `chisq.test` a φ² se součinem obou rozdílů; čáry stejné míry a retrospektivní výběr. Shoda s kapitolou: 0,400 a 0,171, 22,9 bodu, 2,34 (0,43), 0,667 a 0,206, 3,23, χ² 16,06, φ 0,25, 0,229 × 0,273; aspirin 1,82, 1,83, 0,77 bodu, φ 0,034. Čísla v textu stránky pocházejí z tohoto výstupu.
- **Excel:** stránka vzorce Excelu nenabízí; výpočty jsou na listu `Mira_souvislosti` sešitu kapitoly 9.
- **Prohlížeč:** výchozí stav prohlédnut na snímcích z Chromia (desktop, celá obrazovka a 375 px z `check-html.cjs`). Panel prohlížeče aplikace při této práci přestal buňky OJS spouštět (i u starších vizualizací), proto v něm druhá vizualizace prohlédnuta nebyla.
- **Citace:** vykreslený odkaz „Magnusson (2026)“ a položka v seznamu literatury zkontrolovány; titul, verze a datum jsou převzaty ze stránky článku (viz kartu E08), licence kódu článku zjišťována nebyla, protože se kód nepřebírá.

**Kontroly:** celá kniha vykreslena (Quarto 1.9.38, R 4.5.1). `check-html.cjs` s oběma novými bloky a novým pořadím menu prošel celý bez chyb; prošly také `check-table-layout.cjs` a `check-doc-maps.cjs`.

**Omezení:** ověřeno v Chromiu; Firefox, Safari, skutečný telefon a čtečka obrazovky nebyly vyzkoušeny. Interaktivní obrázky inspiračního článku nebyly vyzkoušeny v prohlížeči, jen přečten jeho text. Didaktická revize je interní, ne ověření na studentech.

<a id="vizualizace-chi-kvadrat"></a>

## Vizualizace tabulky četností a testu chí-kvadrát; sbalená část nabídky (2026-11-20, upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-20-chi)
přibyla třináctá stránka části „Interaktivní vizualizace“, první ke kapitole 9:
[Jak daleko je tabulka četností od nezávislosti](viz_chi_kvadrat.qmd), v menu za
vizualizací dvou intervalů. Kapitola 9 na ni odkazuje blokem „Vyzkoušejte si: od
tabulky četností k testu chí-kvadrát“ v pododdílu `sec-pearson-upravena`, za
rozšířením o Holmově korekci; jinak se výklad kapitoly nemění. Obsahuje:

- **ovládání:** editovatelnou tabulku věk × strategie zvládání (celá čísla 0–100 000) s dopočítanými součty a tlačítka „Zdvojnásobit četnosti“, „Původní data“ a „Nezávislost“;
- **grafy:** řádkové podíly s podíly celého výběru a chí-kvadrát rozdělení se čtyřmi stupni volnosti, kritickou hodnotou a *p*-hodnotou jako plochou;
- **výsledky:** slovní závěr testu na hladině 0,05, souhrn (χ², stupně volnosti, *p*, kritická hodnota, Cramérovo V, nejmenší očekávaná četnost, vzorec `CHISQ.DIST.RT`), upozornění při očekávané četnosti pod 5 a čtyři odvozené tabulky (očekávané četnosti, příspěvky, Pearsonova a standardizovaná rezidua);
- **text:** oddíl „Odkud se čísla berou“ se všemi vzorci kapitoly a dosazením pro buňku mladí × řešení problému, čtyři úkoly a „Čeho si všimnout“.

Redakční volby při realizaci:

- **Pevná tabulka 3 × 3** s popisky příkladu; stupně volnosti jsou proto vždy 4 a kritická hodnota 9,49.
- **Okamžité použití platné hodnoty** (událost `input`), aby fungovaly i šipky číselného pole; neplatná hodnota nebo prázdný řádek či sloupec se odmítne a platí poslední platná tabulka.
- **Podbarvení standardizovaných reziduí** roste plynule do |4| (nejvýše 40 % sytosti kvůli kontrastu textu), bez hranice ±1,96; pod tabulkou je výhrada o více testech. Společné pravidlo webu ruší pozadí buněk tabulek, proto má podbarvení vlastní pravidlo s proměnnou `--viz-chi-shade` (výjimka podle R54: barva vyjadřuje hodnotu buňky).
- **Předvolba „Nezávislost“** používá zaokrouhlené očekávané četnosti původní tabulky (19, 17, 19 / 27, 26, 27 / 19, 17, 19), protože přesné nejsou celá čísla; χ² je 0,05.
- ***p*-hodnota** pod 0,001 se uvádí jako „< 0,001“ a nad 0,999 jako „> 0,999“.
- **Osa grafu rozdělení** sahá do 20, nebo do 1,15násobku χ²; při velmi velkém χ² je plocha neviditelná a hodnotu nese popisek.
- **Numerika:** `lgamma` převzato z vizualizace *t*-rozdělení; neúplná funkce gama (řada a řetězový zlomek) přepsána z `quarto/_verification/check-chapter-09-excel-expected.py`.

**Sbalená část nabídky** ([upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-20-nabidka)): část „Interaktivní vizualizace“ je v postranní nabídce ve výchozím stavu sbalená, na stránkách vizualizací rozbalená. Quarto to pro jedinou část neumí nastavením, proto ji sbaluje `assets/sidebar-collapse.js` připojený bez `defer` (popis v [provozním návodu](../docs/PROVOZ.md#interaktivni-vizualizace)).

Nezávislá kontrola:

- **R** (`scripts/viz-chi-kvadrat.R`, v repozitáři): tabulka kapitoly, zdvojená a dvakrát zdvojená, „Nezávislost“ a tři tabulky z úkolů; vlastní výpočet porovnán uvnitř skriptu s `chisq.test` (statistika, *p*, obě rezidua). Shoda s kapitolou: χ² 11,78, *p* 0,0191, V 0,176, rezidua 1,43 / 2,09 a −2,03 / −2,97. Čísla v textu stránky pocházejí z tohoto výstupu.
- **Excel:** vzorec `CHISQ.DIST.RT` stránka jen vypisuje; funkce je spuštěna a ověřena v sešitu kapitoly 9 (list `Tabulka`), nově v Excelu spouštěna nebyla.
- **Prohlížeč:** výchozí stav, „Nezávislost“ a mobilní šířka prohlédnuty v prohlížeči aplikace a na snímcích z Chromia; při prohlídce opraveno nefunkční podbarvení, rozvržení odvozených tabulek (dva sloupce jen při dostatečné šířce), směr popisků kritické hodnoty a χ² a okraj svislé osy na mobilu.

**Kontroly:** celá kniha vykreslena (Quarto 1.9.38, R 4.5.1). `check-html.cjs` s novým blokem, s testem sbalené nabídky a s novým pořadím menu prošel celý bez chyb; prošly také `check-table-layout.cjs` a `check-doc-maps.cjs`.

**Omezení:** ověřeno v Chromiu; Firefox, Safari, skutečný telefon a čtečka obrazovky nebyly vyzkoušeny. Na šířce 375 px se vstupní tabulka o několik pixelů posouvá ve vlastní oblasti; stránka nepřetéká. Didaktická revize je interní, ne ověření na studentech.

<a id="revize-kapitoly-10"></a>

## Revize kapitoly 10 podle autorových připomínek (2026-11-20, R84)

Autor provedl v kapitole 10 vlastní redakční úpravy (66 řádků) a připojil 24 připomínek k místům textu a dva obecné pokyny (plné názvy koeficientů, bez „lineárního mraku“). Termíny, značky, rozsah a dílčí volby schválil v dotazech a plánem revize ([R84](../docs/rozhodnuti/kapitola-10.md#r84-revize-kapitoly-10)).

**Autorovy úpravy.** Věcně převzaty; opraveny překlepy a gramatika: „naprůměrná“, „popstatelný“, „pomocé“, „úrovn“, „vznike“, „přlibližně“, „Personově“ v nadpisu (nadpis nově „Model pro inferenci o Pearsonově korelačním koeficientu“, ID zachováno), chybějící „je“ v souvětí o heteroskedasticitě, „posuzujeme máme“, „velikost těsnost“, „úrovní úzkostí“, „jen v důsledku pouhé“, zdvojené „rozdělení je šikmé … zešikmené doleva“, slitá věta o reliabilitě dotazníku („souvisí sám se sebou víc než vůbec“), cvičení 1d bez slovesa. „Souvislosti bychom zamezili“ → „souvislost bychom zrušili“; „korelace v populaci může být i zanedbatelná (kolem 0,2)“ přeformulováno bez slovního hodnocení síly v souladu s R71.

**Kapitola 10 (`quarto/kapitola_10.qmd`).**

- Výklad: dva významy „směru vztahu“; observační studie jako alternativní název; volba osy podle role proměnné v otázce (bez tvrzení o směru působení); společná příčina u úzkosti a výkonu; heteroskedasticita nejen jako vějíř; přirozený logaritmus při Fisherově transformaci (ln, zmínka $\log_e$, odkaz na kap. 9); věcné vysvětlení rozdílu τ<sub>b</sub> a $r_s$ místo přirovnání km/míle; přepsaný pododdíl o hypotéze permutačního testu; převzorkování; proč bootstrap losuje s vracením a výběr zastupuje populaci; přepočet pořadí jen u pořadových koeficientů; cílem analýzy odlehlých pozorování je porozumět jejich vlivu; chyba měření s pravým skórem a atenuací; relativní a absolutní shoda.
- Nová nepovinná rozšíření `rozsireni-meze-r` (důkaz −1 ≤ *r* ≤ 1) a `rozsireni-korekce-reliabilita` (korekce na atenuaci podle Muchinského, 1996); rozšíření BCa podrobněji (předpoklady percentilového intervalu, význam $z_0$ a *a*, zápis $z_{\mathrm{α}/2}$, $z_{1-\mathrm{α}/2}$); rozšíření o *d* a *r*<sub>pb</sub> s obrázkem a upřesněním „*h* ≈ 4“ a převodu *d*/2.
- Obrázek `fig-stejne-r` nově Anscombův kvartet (převzatá data, `anscombe1973`); nové obrázky `fig-fisher-transformace` (ID odlišné od `fig-fisher` v kap. 9), `fig-permutace-presna`, `fig-odlehle-typy`, `fig-reliabilita`, `fig-rpb-d`; nová tabulka `tbl-k10-preskupeni`; korelační matice `tbl-k10-09` s hvězdičkami a 95% Fisherovými intervaly na samostatných řádcích.
- Plné názvy „Pearsonův / Spearmanův / Kendallův korelační koeficient“ v celé kapitole včetně nadpisu oddílu, odkazů ve Shrnutí, cvičení 6, titulku tabulky `tbl-k10-06` a tabulky u cvičení 11; „mrak“ jen jako „mrak bodů“ (text, alt texty, řešení cvičení 2c a 16a).

**Přehledy a dokumentace.** Slovníček: hesla Převzorkování, Pravý skór, Atenuace, Korekce na atenuaci, Relativní a absolutní shoda; alternativy observační studie a pořadová transformace; heteroskedasticita; logaritmus (zastaralé „zde používáme základ 2“). Značení: řádky $\ln x$ a $r_{xx}$, $r_{yy}$, $r_{\mathrm{opr}}$; plné názvy u $r_s$ a τ. Přehled Excelu: CORREL. Registr slovníku, R84 a registr rozhodnutí (R71 částečně nahrazeno, R72 a R73 doplněny), karta kapitoly 10, nová zdrojová karta [D15](../docs/zdroje/D15-muchinsky.md#d15) (Muchinsky 1996, sken doplněný autorem; inventář 51 souborů), externí karta [E07](../docs/zdroje/E07-anscombe-1973.md#e07-anscombe-1973), karta U02 (Aron s. 514–515), [historie ověřování](../docs/zdroje/HISTORIE.md#muchinsky-2026-11-20), `references.bib` (`anscombe1973`, `muchinsky1996`; DOI ověřeny službou Scite).

**Výpočty a kontroly (2026-11-20).** `scripts/kapitola_10.R`: blok 13 (vlastní seedy 13010 a 14010, za `ch10_write_exports()`) a šest nových obrázků; exportované CSV pro sešit jsou bajtově shodné s výstupem předchozí verze skriptu, sešit `data/kapitola_10.xlsx` se proto neměnil a Excel nebyl spouštěn. `check-chapter-10.R` prošel s novými kontrolami: Anscombův kvartet (průměry, SD, *r*, tvrzení o souborech II–IV), tabulka přeskupení proti `cor(..., method = "spearman"/"kendall")`, přesné rozdělení 720 přiřazení (8 + 16 + 16 + 8), tři druhy odlehlého bodu, simulace atenuace a korekce, *h* a křivky *r*<sub>pb</sub>, intervaly a *p*-hodnoty matice proti `cor.test`, BCa proti vzorci a interpolaci balíčku `boot` (zrychlení z `boot::empinf` se liší o 0,0002, meze o méně než 0,005). Celá kniha vykreslena (Quarto 1.9.38), `check-html.cjs` (17 obrázků kapitoly 10, nové prvky, zákaz zkrácených názvů koeficientů a „lineárního mraku“, sbalená rozšíření), `check-table-layout.cjs` a `check-doc-maps.cjs --require-sources` prošly. Nové obrázky prohlédnuty jako PNG; ve webu vizuálně korelační matice a obrázek Fisherovy transformace. Didaktická revize agentem v roli studenta: zapracovány mimo jiné věcné nepřesnosti (časové pořadí jako důvod směru působení, znaménko u atenuace a korekce, „*h* ≈ 4“, slovní hodnocení síly v intervalech), nejasnosti v rozšíření BCa a značení kvantilů. Povinná část má přibližně 9 000 slov (dříve asi 7 500). Sestavení na GitHubu (Linux) zachytilo přesah nové tabulky `tbl-k10-preskupeni` o 6 px při šířce 1024 px, lokálně neprojevený kvůli jiným písmům; záhlaví přeskupení byla zkrácena na A, B, C (nejmenší šířka tabulky lokálně 401 px při dostupných 541 px).

**Omezení a neprovedeno.** Výklad BCa se neopírá o prostudovaný zdroj v podkladech (Ruscio 2008 nepřečten); je ověřen jen číselně. Anscombův článek nebyl čten, použita jsou jen data. Didaktická revize byla interní, bez ověření na studentech. Pracovní PDF kapitoly ani souhrnné PDF nebyly znovu sestaveny; nové obrázky a tabulka v PDF nebyly ověřeny. Balíček AI tutora nebyl znovu exportován. Mobilní zobrazení bylo ověřeno jen automatickou kontrolou šířky 390 px. Zkrácené názvy koeficientů v ostatních kapitolách nebyly nalezeny; prezentace ke kapitole 10 neexistuje.

<a id="revize-kapitoly-9-2026-11-16"></a>

## Revize kapitoly 9 podle autorových připomínek (2026-11-16, R81)

Autor kapitolu 9 prošel, provedl v ní vlastní redakční úpravy a připojil 19 připomínek k místům textu a 5 obecných pokynů. Termíny, značku a rozsah schválil plánem revize ([R81](../docs/rozhodnuti/kapitola-09.md#r81-revize-kapitoly-9)).

**Autorovy úpravy.** Věcně převzaty beze změny; opraveny jazykové a formální chyby: „O čem tabulka četností řekne vypovídá?“, „se které vyžadují“, slitá věta o mezích Waldova intervalu, „ne četnost, který“, „co která vyjadřuje“ u ukazatelů, „pro celou tabulky“, „závísí“, „v jednotlivé buňky“; nezavedené „copingové strategie“ nahrazeny „strategiemi zvládání stresu“; „síla souvislosti je nízká“ a „souvislost je umírněná“ (řešení cvičení 7) sjednoceny na „souvislost je slabá“; „*p*-hodnotu reprezentuje pravý chvost“ → „*p*-hodnotě odpovídá plocha v pravém chvostu“.

**Kapitola 9 (`quarto/kapitola_09.qmd`).**

- Směrodatná chyba rozdílu podílů je pojmenována, vysvětlena a označena $s_{p_1-p_2}$; výklad Newcombova intervalu čte nový obrázek konstrukce (poloviny Wilsonových intervalů, čtverce vzdáleností, Pythagorova věta).
- Nový obrázek přesného pokrytí Waldova a Wilsonova intervalu (*n* = 10, 20, 50, 100) s odstavcem výkladu.
- Směr testu chí-kvadrát: obrázek *z* → *z*² → chí-kvadrát rozdělení s jedním stupněm volnosti, odstavec o významu levého chvostu; závěr testu dobré shody formulován jako výrok o populaci (místo „platí pro tyto lidi“).
- „Upravené reziduum“ → standardizované reziduum (text, tabulka, cvičení, Shrnutí) s upozorněním na názvy v programech; Holmova korekce doplněna tabulkou devíti buněk.
- Fisherův test: věta „nemáme o co opřít“ nahrazena vysvětlením nespolehlivé aproximace; obrázek deseti možných tabulek; nový povinný pododdíl „Simulovaná *p*-hodnota“ s obrázkem (10 000 přeskupení, seed 20261117); „Častý omyl“ o neparametričnosti přesunut na konec oddílu.
- Tabulka fotografií s řádkovými procenty; zdůvodnění φ a Cramérova V, φ² jako součin dvou rozdílů podílů, vzorec φ z četností se znaménkem; vypuštěna věta o Howellově údaji 28,8 %.
- „Tabulka přechodů“ → tabulka párových dat; nový povinný pododdíl „Znaménkový test“ (rozdíly skóru pozornosti z kapitoly 8); obrázek shod a neshod u Cohenova kappa.
- Tabulka volby postupu (znaménkový test, simulovaná *p*-hodnota, přesná verze McNemarova testu); ukázky APA se stojatým χ a nová ukázka kontingenční tabulky podle APA; Shrnutí má nadále osm bodů.
- Cvičení: nové povinné cvičení 13 (znaménkový test), situace 8g, doplněné řešení 10c; dosavadní nepovinná cvičení 13 a 14 mají čísla 14 a 15.
- „Rozložení“ → „rozdělení“ (18 míst), „počet“ → „četnost“ u počtu případů v kategorii, tři výskyty *z*-testu kurzivou.

**Ostatní studentské texty.** „Rozložení“ ve smyslu distribuce nahrazeno v kapitolách 2 (2×) a 4 (4×), ve slovníčku (3×) a ve vizualizaci normálního rozdělení (1×); slovesné tvary („hodnoty jsou rozloženy“) a „rozložení“ ve smyslu uspořádání listu zůstaly. Slovníček: hesla Standardizované reziduum a Tabulka párových dat (ID zachována), nová hesla Znaménkový test a Simulace Monte Carlo, kurzivní *z* u skórového testu. Značení: nový řádek $s_{p_1-p_2}$, doplněný řádek φ. Přehled Excelu: list `Znamenkovy`, „standardizovaných reziduí“. Kapitola 10: zpětný odkaz na simulovanou *p*-hodnotu u náhodného výběru přeskupení.

**Obrázky, sešit a kontroly.** `scripts/kapitola_09.R`: výpočty revize a šest nových obrázků (`pokryti-wald-wilson`, `newcombe-konstrukce`, `z2-chi2`, `fisher-tabulky`, `monte-carlo`, `kappa-shody`); popisek osy obrázku `pozice` a legenda obrázku `zvladani`. Sešit má 26 listů: nové vstupní listy `Spanek_rozdily` a `U13_uzkost`, nový výpočtový list `Znamenkovy` (COUNTIFS, BINOM.DIST; až 20 dvojic), přejmenované popisky na listech `Tabulka` a `McNemar`. `check-chapter-09-excel.ps1` nově vrací po dosazení dat cvičení původně prázdné buňky do prázdného stavu. `check-html.cjs`: 15 řešení, 11 obrázků, nové prvky revize, zákaz „rozložení“, „upraveného rezidua“ a „tabulky přechodů“ v kapitole 9, stojaté χ v ukázkách zpráv; skrytý obrázek v nepovinném rozšíření se před snímkem rozbalí. `check-chapter-pdf.cjs`: 15 řešení; `scripts/pdf/common.ps1`: šířky sloupců tabulky Holmovy korekce v PDF.

**Dokumentace.** R81 a doplnění R76 ([doklady](../docs/rozhodnuti/kapitola-09.md#r81-revize-kapitoly-9)), registr (R70 částečně nahrazeno), slovník, karta kapitoly 9, mapa a plán pokračování (znaménkový test už není mimo kapitoly 6–10), `docs/DATA.md`, `docs/PROVOZ.md`, `AGENTS.md` (pravidlo „rozdělení“ a „četnost“), karta U01 a historie ověřování podkladů.

**Kontroly (vše 2026-11-16).** `check-chapter-09.R` prošel: pokrytí proti nezávislému výpočtu s `prop.test`, Holmova tabulka proti `p.adjust`, Fisherovy pravděpodobnosti a *p*-hodnota proti `fisher.test`, simulovaná *p*-hodnota 0,068 proti `chisq.test(simulate.p.value = TRUE)` a proti přesné hodnotě 0,070, φ se znaménkem proti korelaci kódů 0/1, znaménkový test proti `binom.test`, očekávané četnosti tabulky posuzovatelů, všechna nová čísla v textu. Sešit sestaven `build-workbooks.ps1 -Chapter 9 -Verify` v českém Excelu 16 (26 listů, 252 vzorců; 188 uložených výsledků, 14 českých vzorců z textu, 340 přepočtů po dosazení dat cvičení, 11 zápisů vzorců); `check-workbooks.py` prošel. Celá kniha vykreslena (Quarto 1.10.19); `check-html.cjs`, `check-table-layout.cjs` a `check-doc-maps.cjs` prošly. Kontrola rozvržení tabulek nejprve zachytila přesah tabulky Holmovy korekce o 14 px při šířce 1024 px; záhlaví a jeden popisek byly zkráceny. Pracovní PDF kapitoly 9 sestaveno (42 stran), `check-chapter-pdf.cjs --chapter 9` a `check-pdf-typography.cjs` prošly; devět poznámek pod tabulkami má 9 pt. Všech šest nových obrázků bylo prohlédnuto jako PNG, ve vykresleném webu vizuálně oddíly o φ a o sdělení výsledků, v PDF strany s obrázkem konstrukce Newcombova intervalu, s tabulkou Holmovy korekce a s tabulkou podle APA. Povinná část má přibližně 10 700 slov; strojová kontrola našla dvě věty nad 35 slov (výčet nepovinných rozšíření a bod Shrnutí s odkazem).

**Omezení a neprovedeno.** Didaktická revize proběhla jen interně; porozumění nebylo ověřeno na studentech. V PDF je písmo uvnitř obrázku konstrukce Newcombova intervalu drobné (obrázek je vysoký a zmenšuje se na šířku strany). `check-rendered-pdf.py` byl spuštěn jen v části pro kapitolu 9: místní souhrnné PDF celé knihy pochází z 2026-11-14, revizi neobsahuje a jeho kontrola proto neprochází; souhrnné PDF ani vydání `ucebnice-pdf` se bez výslovného pokynu neobnovují. Balíček AI tutora nebyl znovu exportován. Mobilní zobrazení bylo ověřeno jen automatickou kontrolou šířky 390 px, nové obrázky na mobilu vizuálně prohlédnuty nebyly. Howellovy pasáže o znaménkovém testu a tab. 6.13 byly čteny jen v textové extrakci. „Četnost“ místo „počtu“ byla sjednocena jen v kapitole 9. V kapitolách 2–4 a 10 zůstávají slovesné tvary „rozloženy“.

<a id="pdf-cele-ucebnice-2026-11-14"></a>

## PDF celé učebnice a odkaz na jeho stažení z úvodu (2026-11-14, R80)

Autor chtěl v úvodu „O učebnici“ odkaz na stažení PDF verze; zvolil celou knihu (kapitoly 1–10) a zveřejnění vydáním na GitHubu ([R80](../docs/rozhodnuti/postupy-a-dokumentace.md#r80-pdf-cele-ucebnice)).

- `index.qmd`: nový odstavec s odkazem na `releases/download/ucebnice-pdf/zaklady-statistiky-pro-psychology.pdf` (co PDF obsahuje, že vizualizace a sešity jsou na webu a že datum verze je na titulní straně).
- `render-book-pdf.ps1`: kapitoly bere z `_quarto.yml` (nyní 1–10), výstup `output/pdf/zaklady-statistiky-pro-psychology.pdf`, titulní strana s datem sestavení (`book.yml`), odstavec o stažení PDF v PDF vypouští, náhrada věty o literatuře „kapitolách 1–6“ zrušena. Identifikátory opakované ve dvou kapitolách (`fig-sirka-intervalu` v kap. 2 a 7, `sec-nezavislost` v kap. 5 a 9) dostanou v pozdější kapitole příponu `-kNN` včetně odkazů; dřív by se v jednom dokumentu střetly.
- Šířky sloupců širokých tabulek kapitoly 7 přesunuty z `render-chapter-pdf.ps1` do `scripts/pdf/common.ps1` a používají je obě PDF.
- `book.lua`, `check-book-pdf.cjs`, `check-rendered-pdf.py`: rozsah kapitol a počty řešení se berou ze zdrojů místo pevných 1–6; vynechávání řádků přehledů platí obecně pro kapitoly mimo PDF.
- `kapitola_10.qmd`: šest poznámek pod tabulkami nově začíná „*Poznámka.*“ jako v ostatních kapitolách (kontrola PDF je podle toho hledá).
- Dokumentace: R80 a registr (R31 částečně nahrazeno), `docs/PROVOZ.md` (oddíl PDF celé učebnice a postup vydání; stará kotva zachována), `AGENTS.md`, `README.md`, `docs/OSNOVA.md`.

**Kontroly:** PDF celé knihy sestaveno (Quarto 1.10.19, 430 stran); `check-book-pdf.cjs` (132 řešení v kapitolách 1–10, 707 cílů odkazů), `check-rendered-pdf.py` (27 poznámek 9 pt) a `check-pdf-typography.cjs` prošly. Vizuálně prohlédnuty náhledy titulní strany, úvodu (bez odstavce o stažení), tabulek 7.2, 7.3, 10.1, 10.6, cvičení kapitol 7 a 10 a slovníčku; ostatní strany jen kontrolami. PDF kapitoly 7 po přesunu šířek sloupců znovu sestaveno a `check-chapter-pdf.cjs --chapter 7` prošla. `check-doc-maps.cjs` prošla.

**Vydání:** Na pokyn autora založeno vydání `ucebnice-pdf` („Učebnice v PDF“) z revize `fcd4018` s `--latest=false`. Odkaz z úvodu stáhne soubor se shodným SHA-256 jako místní PDF; nejnovějším vydáním zůstává `tutor-v0.3.5` a odkaz tutora `latest/download` funguje. Veřejný web odkaz zobrazí až po sloučení PR.

<a id="pdf-kapitola-09-2026-11-14"></a>

## PDF: export kapitoly 9 a české uvozovky v Quartu 1.10 (2026-11-14)

Autor požádal o pracovní PDF kapitoly 9 a o doplnění kapitoly mezi podporované exporty.

- `render-chapter-pdf.ps1`, `check-chapter-pdf.cjs` (14 řešení) a `check-rendered-pdf.py` podporují kapitolu 9.
- `kapitola_09.qmd`: šest poznámek pod tabulkami začíná „*Poznámka.*“ jako v ostatních kapitolách (kontrola PDF je podle toho hledá).
- RStudio nyní dodává Quarto 1.10.19 (Pandoc 3.10, Typst 0.15.1). Pandoc zapisuje českou zavírací uvozovku jako chytrou uvozovku Typstu, která v PDF otevírala novou citaci („…„). `scripts/pdf/typography.lua` převádí „ “ ‚ ‘ na escape sekvence Typstu; v titulcích bloků (atribut `title`) je mění na uvozovky Markdownu, které Typst sází česky. Kontrola `check-pdf-typography.cjs` má nový případ a test oddělovače v $N(50,10)$ toleruje mezery, které nová verze Pandocu nevypisuje.
- Dokumentace: `AGENTS.md` (export kapitol 3–9), `docs/PROVOZ.md`.

**Kontroly:** PDF kapitol 3–9 znovu sestavena Quartem 1.10.19 (50/38/43/56/38/38/35 stran); `check-chapter-pdf.cjs` pro kapitoly 3–9, `check-pdf-typography.cjs` a `check-rendered-pdf.py` prošly. Počet otevíracích a zavíracích uvozovek v textu PDF se shoduje ve všech kapitolách (kapitola 7 má 66/66 jako se starším Quartem). Kapitola 9 celá vizuálně prohlédnuta na náhledech stránek; drobnosti: poznámka tabulky 9.7 se oddělila na další stranu, na s. 7 a 14 zůstává volné místo před tabulkou či obrázkem. Kapitola 9 vykreslena i jako web.

**Oprava omylu (téhož dne):** Náhledy stránek pro vizuální kontrolu vznikly samostatným `quarto typst compile` bez složky písem Quarta, a proto místo ikon bloků ukazovaly prázdné rámečky. Ve skutečných PDF se ikony vykreslují správně (vloženo písmo Font Awesome; ověřeno autorem i náhledem s `--font-path`). Krátce zavedené `callout-icon: false` bylo vráceno, PDF kapitol 3–9 znovu sestavena s ikonami a uloženy do `output/pdf/`.

**Omezení:** Ostatní kapitoly 3–8 nebyly po změně vizuálně prohlédnuty, jen ověřeny kontrolami a počtem uvozovek.

<a id="ai-tutor-vydani-2026-11-14"></a>

## AI tutor 0.3.5: stránka ke stažení a vydání na GitHubu (2026-11-14, R79)

Autor chtěl mít verze tutora dohledatelné a návod přímo v učebnici ([R79](../docs/rozhodnuti/ai-tutor.md#r79-vydani-tutora-na-githubu)).

- Nová nečíslovaná stránka `quarto/ai_tutor.qmd` „AI tutor: stažení a instalace“ za úvodem. Text vychází z `ai-tutor/navod.docx` (verze 0.3.4), který nahrazuje. Údaje o verzi odstraněny. Názvy souborů jsou stálé a vedou přes `releases/latest/download/`. Rozsah opraven na „kapitoly 7–10 zatím nemá celé“ (dříve 7–8). Znak `@` je escapovaný, jinak ho Pandoc četl jako citaci. Odkaz na stránku je v úvodu knihy; export tutora jej převádí na webovou adresu (`export-tutor.cjs`, stejně jako u vizualizací).
- `scripts/release-tutor.cjs`: pojistky (export bez necommitovaných vstupů, revize na GitHubu, neexistující štítek i koncept vydání, shoda verze a SHA-256, `check-tutor.cjs`), kopie archivů pod stálými názvy do `tmp/tutor-release-<verze>/`, české poznámky; bez přepínače suchý běh, `--draft` vytvoří koncept.
- Verze tutora 0.3.5: zdroje kapitol 1–6 se od 0.3.4 změnily. Texty tutora (SKILL.md, PRIPOJENI-KAPITOL.md, manifesty, README pluginu, export, testovací scénář) uváděly nepřibalené kapitoly 7–8 a katalog osmi kapitol; opraveno na 7–10 a deset.
- Opravy kontroly `check-tutor.cjs`, které bránily exportu od přidání kapitol 9–10 a od R78: počet kapitol se bere z knihy místo pevných 8; vzorce s třídou `formula-line` se porovnávají a `&nbsp;` se dekóduje jako nezlomitelná mezera.
- Dokumentace: pravidla v `docs/AITUTORS.md`, postup v `docs/PROVOZ.md` (oddíl Vydání na GitHubu), uspořádání v `docs/OSNOVA.md`, R79 a řádek v registru.

**Kontroly:** celá kniha vykreslena (Quarto 1.10.19); `check-html.cjs`, `check-table-layout.cjs` a `check-doc-maps.cjs` prošly. Stránka nepřetéká při 375 px; styly jsem kvůli statickému náhledu vizuálně neověřil, jen kontrolními skripty. Export 0.3.5 z čisté revize `0a398e9` prošel včetně `check-tutor.cjs` a smazal starší pracovní složku exportu. Suchý běh vydání prošel. Pojistky jsem vyzkoušel na upravených kopiích `overeni.json`: neshoda SHA, neodeslaná revize, jiná verze a `--draft` s `--report`. Koncept vydání `tutor-v0.3.5` jsem vytvořil; odkazy `latest/download` začnou fungovat až po jeho zveřejnění autorem. Tutora 0.3.5 jsem na platformách netestoval.

<a id="zdroje-webu-tmp-2026-11-14"></a>

## Zdroje webu bez kopií z `tmp/` (2026-11-14)

Místní `_book/` měl 635 MB, z toho asi 600 MB v `_book/tmp/`. Quarto čte vzory `project.resources` podobně jako `.gitignore`, takže `assets/` a `data/*.xlsx` bez úvodního lomítka platily v libovolné hloubce. Do webu se tak kopírovaly složky `assets/` a `data/` z pracovních exportů tutora a starších kontrolních kopií webu v `tmp/`, a také z `plugins/` a `node_modules/`. Zveřejněný web se `tmp/` netýkal, protože workflow vykresluje z čisté kopie repozitáře. Logo z `plugins/…/assets/` se ale publikovalo zbytečně.

- `_quarto.yml`: vzory ukotveny ke kořeni (`/assets/`, `/data/*.xlsx`), vylučovací vzory beze změny.
- `scripts/export-tutor.cjs`: po úspěšném exportu smaže starší složky `tmp/tutor-export-*` a ponechá aktuální, na kterou odkazuje `ai-tutor/overeni.json`.
- `docs/PROVOZ.md`: popis ukotvení vzorů a úklidu exportu.
- Místně smazáno `_book/` (vykresleno znovu) a 27 starších složek `tmp/tutor-export-*` (asi 580 MB); ponechána `tmp/tutor-export-hz2bNL`.

**Kontroly:** celá kniha vykreslena místně Quartem 1.10.19 (projekt je jinak ověřován s 1.9.38). `_book/` má 34 MB a obsahuje jen `assets/`, `data/`, `quarto/`, `site_libs/` a soubory v kořeni. Seznam souborů `_book/assets/` se shoduje s `assets/`, v `_book/data/` je všech deset sešitů. Prošly `check-html.cjs`, `check-table-layout.cjs` a `check-doc-maps.cjs`. Úklidovou smyčku exportu jsem ověřil simulací na pomocných složkách; celý export tutora jsem nespouštěl.

<a id="zalamovani-vzorcu-2026-11-14"></a>

## Zalamování dlouhých vzorců Excelu v tabulkách (2026-11-14, R78)

Autor upozornil, že vzorec v G2 tabulky 8.3 rozšiřuje tabulku, a pro zalamování takových vzorců zvolil rozsah „Celá kniha“ ([R78](../docs/rozhodnuti/spolecne-konvence.md#r78-zalamovani-vzorcu)).

- `filters/table-style.lua` (web, PDF kapitoly i knihy) nově v buňkách tabulek zalamuje inline kód začínající „=“ a delší než 50 znaků. Vzorec rozdělí na úseky za středníkem mimo uvozovky, případně před binárním operátorem. Nejdřív zkusí zlomy na úrovni vnoření 0, pak hlubší, dokud řádky nemají nejvýše asi 45 znaků. Úseky skládá do řádků zhruba do 40 znaků a pokračování odsadí nezlomitelnými mezerami pod otevírací závorku. Pokud by tím řádek přesáhl limit (dlouhý název funkce, např. `SOUČIN.SKALÁRNÍ`), odsadí ho závěsně o dva znaky od začátku názvu. Krátký závěrečný zbytek do 6 znaků nový řádek nezačíná.
- Tabulky obsahující vzorec mají automatické šířky sloupců (`ColWidthDefault`). Pandoc jinak kvůli dlouhému řádku zdroje dával všem sloupcům stejný podíl a sloupec se vzorcem se mačkal; dřív se tak lámaly i kratší vzorce, např. v tabulkách 5.12 a 6.18. V `assets/styles.css` se od 601 px řádky vzorců v buňkách dál nelámou (`white-space: nowrap`); na mobilu zůstává lámání kdekoli a tabulky se posouvají.
- Tabulka 10.6: v adrese `Prevzorkovani_data!B2:C31` v prvním sloupci je za vykřičníkem nulová mezera (U+200B). Umožní zlom, aby se tabulka vešla do 1280 px. Výsledkem je několik prvků `Code` oddělených `LineBreak`, takže zdroj, tutor a vyhledávání vidí vzorec na jednom řádku.
- Dotčeno 13 vzorců v tabulkách kapitol 5, 6, 8, 9 a 10. Např. G2 v tabulce 8.3 má tři řádky: `=KDYŽ(A(JE.ČISLO(Spanek_par!B2);` / odsazené `JE.ČISLO(Spanek_par!C2));` / `Spanek_par!B2;"")`, stejně jako v autorově ukázce.
- `quarto/excel.qmd` (surové HTML, filtr ho nezpracuje): čtyři vzorce delší než 50 znaků (COUNTIFS, T.TEST, kvantil přes BETA.INV, SOUČIN.SKALÁRNÍ) zalomeny ručně `<br>` a `&nbsp;` podle výstupu filtru.
- Studentům: věta v kapitole 2 (oddíl o Excelu) a v úvodu přehledu Excelu, že zalomení slouží jen čitelnosti a do buňky se vzorec zapisuje jako jeden řádek.
- Pravidlo v `AGENTS.md` (Excel), postup v `docs/PROVOZ.md`, doklad R78 a řádek v registru.

**Kontroly:** výstup filtru jsem ověřil přes `quarto pandoc` na všech dotčených vzorcích. Kapitola 8 vykreslena: G2 v tabulce 8.3 má na webu tři řádky, stránka nepřetéká při 1280 ani 390 px a `check-html.cjs` prošel. Ruční PDF (Typst) jsem po této úpravě nevykresloval a neověřoval.

**Oprava po CI (2026-11-14):** po sloučení PR #200 a #201 selhal workflow „Ověřit a publikovat učebnici“ v `check-table-layout.cjs`. Při šířkách 1360–1920 px (749 px k dispozici) přetékal přehled Excelu o 7 px a tabulka 10.6 o 2 px; lokálně ve Windows se obě vešly. Příčinou bylo `white-space: nowrap` pro veškerý inline kód v tabulkách, včetně nezalomených vzorců (např. 45znakového vzorce v tabulce 10.6), spolu s širšími písmy na Linuxu.

- Filtr ve výstupu HTML označí řádky zalomeného vzorce třídou `formula-line` (v Typstu ne, protože by ji četl jako jazyk). Stejnou třídu mají ručně zalomené vzorce v `excel.qmd`. `nowrap` se týká jen těchto řádků; ostatní kód se lámat smí, jako před R78.
- Přehled Excelu má užší vodorovné odsazení buněk (0,4 rem). Jeho nejmenší šířku neurčuje nezalomený kód, ale zalomený řádek COUNTIFS a slova v prvních sloupcích.
- Nejmenší šířka (lokálně, 1360 px): přehled Excelu 721 → 670 px, tabulka 10.6 710 → 664 px; ostatní tabulky se vzorci 620 px (minimální šířka tabulky). `check-table-layout.cjs` a `check-html.cjs` po vykreslení celé knihy prošly. Výsledek na Linuxu potvrdí až běh workflow.

**Druhá oprava po CI (2026-11-14):** workflow po sloučení PR #202 selhal znovu, tentokrát při šířce 1280 px (678 px k dispozici). Přehled Excelu přetékal o 28 px a tabulka 10.6 o 23 px. Dříve přetékaly o víc než 32 px; kontrola to bere jako širokou tabulku s posouváním a nehlásí. Zúžením se dostaly do pásma malého, odstranitelného přesahu. Odsazení buněk je nyní 0,2 rem u přehledu Excelu a 0,3 rem u tabulky 10.6. Z hodnot v CI to vychází asi na 672 px a 647 px. Lokálně je nejmenší šířka 650 px (pevné minimum přehledových tabulek) a 637 px. Zkoušel jsem i `<wbr>` za tečkami v názvech funkcí přehledu. Prohlížeč pak ale dával prvnímu sloupci jen nejmenší šířku a lámal i krátké názvy („VAR.“ / „P“), proto jsem tuto úpravu nepoužil. Kontrola měří přehled Excelu ve výchozím zobrazení 10 řádků; při 25 řádcích je tabulka kvůli delším vzorcům v dalších řádcích posouvatelná. `check-table-layout.cjs` lokálně prošel.

<a id="kapitola-08-t-obecne-2026-11-14"></a>

## Kapitola 8: obecný tvar *t* pro dvě nezávislé skupiny a obrázek 2 × 2 (2026-11-14)

Úprava podle autorových připomínek.

- `kapitola_08.qmd`, oddíl o společném odhadu rozptylu: čitatel testové statistiky klasického testu je nejprve obecně $(m_1-m_2)-(\mathrm{μ}_1-\mathrm{μ}_2)$ a text pak vysvětluje, že nejčastěji nulová hypotéza tvrdí $\mathrm{μ}_1-\mathrm{μ}_2=0$, stejně jako u párového testu s $\mathrm{μ}_0$. Řešený příklad a výsledky se nemění.
- `znaceni.qmd`: řádky `vztah-klasicky-t` a pro soulad i `vztah-parovy-t` uvádějí obecný tvar s nejčastější nulovou hodnotou.
- `scripts/kapitola_08.R`, obrázek `korelace-rozdily`: místo čtyř panelů v řadě matice 2 × 2; podle autora nejprve tři simulované soubory (r = 0,9; 0; −0,5), vpravo dole křivka SD rozdílů podle korelace. Popisky osy x „po běžném/krátkém spánku“, popisky bodů na křivce posunuty pod křivku, aby ji nepřekrývaly. Data a seed beze změny. Popisek a `fig-alt` přepsány podle nového pořadí.

<a id="kapitola-08-obrazky-pomer-2026-11-14"></a>

## Kapitola 8: obrázky směrodatné chyby a Welchových stupňů volnosti pro 90 lidí (2026-11-14)

Úprava podle autorových připomínek po sloučení PR #198. Obrázek 8.4 (`fig-pomer-skupin`) měl tři panely v řadě a malé popisky. U obrázku 8.6 (`fig-welch-stupne`) se černá a tmavě modrá čára špatně rozlišovaly a dolní indexy v popisku `n₁ + n₂ − 2` se v SVG vykreslovaly jako čtverečky. Autor chtěl přidat i poměr 8:1. Ten nejde při 60 lidech rozdělit na celé osoby, proto autor zvolil celkem 90 lidí: 45 a 45, 60 a 30, 72 a 18, 80 a 10.

- `scripts/kapitola_08.R`: `ch8_pomer` má čtyři poměry. Obrázek 8.4 má podle autorovy preference nejvýše dva panely na řádek: panel se stejnými σ je samostatně nahoře a vycentrovaný, dva panely s rozdílnými σ jsou pod ním. Písmo je větší a skutečná směrodatná chyba je ve všech panelech oranžová plná čára, odhad podle společného rozptylu šedá přerušovaná. Obrázek 8.6 má zelenou, oranžovou a světlejší modrou čáru s různými tvary bodů a popisek je přepsán na plotmath (`bquote(n[1]+n[2]-2==88)`), takže se indexy zobrazují. V ostatních R skriptech se znaky indexů nevyskytují.
- `kapitola_08.qmd`: odstavce, popisky a alternativní texty obou obrázků a odkaz na přerušované čáry v oddílu o klasickém testu přepsány na nové hodnoty. Směrodatná chyba při stejných σ je 2,11–3,35. Při variabilnější menší skupině je 3,33–6,42, společný odhad 3,83 při poměru 8:1. Welchovy df: stejné σ 88 až 11,4; menší skupina variabilnější 9,6 při 8:1 proti 9 df menší skupiny; větší skupina variabilnější 88,0 při 2:1.
- `check-chapter-08.R` ověřuje všechny nové hodnoty a shodu `ch8_pomer` s kontrolou. Sešit kapitoly se nemění (modelové obrázky bez listu).

**Kontroly:** `check-chapter-08.R` prošel. Oba SVG jsem vizuálně prohlédl v prohlížeči (legenda Welchova grafu po první prohlídce přesunuta dolů vlevo, protože překrývala čáru 88). Kapitola 8 vykreslena bez varování; `check-html.cjs` (25 stran, mobil 390 px), `scripts/check-table-layout.cjs` a `check-doc-maps.cjs` prošly. PDF kapitoly 8 nebylo vyžádáno a neověřoval jsem ho.

<a id="kapitola-08-obrazky-doplnek-2026-11-14"></a>

**Doplněk po dalších připomínkách (2026-11-14):** úpravy obrázků 8.4, 8.7 a 8.9 v `scripts/kapitola_08.R`, hodnoty se nemění.

- Obrázek 8.4 (`pomer-skupin`): osa x má `gap.axis=-1` a menší písmo, takže se zobrazí popisky všech čtyř poměrů (R jinak vynechal 2:1 a 8:1). Popisky hodnot pod bodem jsou dál od bodu (−0,78 místo −0,5, nad bodem +0,48), aby se nedotýkaly klesajících čar. Legenda spodních panelů je vpravo dole, protože nahoře překrývala popisky 6,42 a 6,45. V horním panelu je legenda dvouřádková: „skutečná směrodatná chyba (podle společného odhadu rozptylu)“, protože při stejných σ vede společný odhad rozptylu ke stejné hodnotě. Totéž doplněno do `fig-alt`.
- Obrázek 8.7 (`intervaly-vedle-sebe`): `layout()` se čtyřmi sloupci zmenšoval písmo na 0,66; nyní `cex=1`, větší popisky os i hodnot.
- Obrázek 8.9 (`ekvivalence-skupin`): popisky legendy jsou na dvou řádcích a horní mez osy y je 3, aby legenda nezasahovala do grafu.

**Kontroly:** všechny tři SVG prohlédnuty jako PNG (Playwright). `check-chapter-08.R` prošel, kapitola 8 vykreslena bez varování a `check-html.cjs` prošel.

<a id="jazyk-r76-kapitoly-2026-11-14"></a>

## Jazykové konvence R76 v kapitolách 1–7, 9, 10 a ve vizualizacích (2026-11-14)

Po sloučení PR #197 byly jazykové konvence [R76](../docs/rozhodnuti/spolecne-konvence.md#r76-jazykove-konvence) uplatněny i mimo kapitolu 8: v `kapitola_01.qmd`–`kapitola_07.qmd`, `kapitola_09.qmd`, `kapitola_10.qmd` a na stránkách `viz_*.qmd`. Terminologii a kurzivní *d* řešil už PR #197. Žádná náhrada nebyla hromadná: každý výskyt byl posouzen v kontextu a nahrazen samostatně. Kapitola 1 změnu nepotřebovala; obsah, čísla, ID ani odkazy se nemění.

- **Úvody oddílů:** 24 úvodů „Oddíl ukazuje/zavádí/přenáší …“ v kapitolách 3, 9 a 10 → „Tento oddíl …“. Ostatní kapitoly a vizualizace holé „Oddíl …“ neobsahovaly (kapitoly 3–7 už používaly „Tento oddíl“).
- **Vazby „dát“:** ze 143 výskytů tvarů slovesa bylo přeformulováno přibližně 100 míst, kde metoda, test, model, výběr či vzorec „dává/dal“ výsledek: „vychází“, „vyšlo“, „vrátí“ (funkce Excelu), „vede k“, „udává“ (model, rozdělení), „poskytuje“, „přisuzuje“. Ponechány byly ustálené obraty („dát pozor“, „dávat smysl“, „dá se“, „dát přednost“), součty „dávají dohromady 1“, „dávat stejné výsledky“ ve smyslu vlastnosti měřicího nástroje (shodně s kapitolou 8), doslovné „dávat body“ či „dát kód“ a přímá řeč postav v cvičeních.
- **Rozdíl a pokles průměrů:** v kapitole 6 doplněno „rozdíl průměrů“ přibližně na 20 místech, kde holé „rozdíl“ otevírá oddíl, odstavec, odrážku, popisek nebo záhlaví tabulky (úvody oddílů, rozhodnutí a velikost v parkovací studii, *d* ≈ 0,47, malé školy); v kapitole 10, ve vizualizacích Cohenova *d* a statistické síly na pěti místech. Anaforické „rozdíl“ bezprostředně po uvedení průměrů zůstalo, stejně jako v kapitole 8; „rozdíl podílů“ v kapitole 9 a ustálený „test rozdílu“ v kapitole 7 se pravidla netýkají. U srovnání průměru s normou (kapitola 6, *z*-test a cvičení 13; kapitola 7, výklad intervalu, tabulka devíti studií a cvičení) nahrazeny „pokles“, „vzestup“ a „zrychlení“ obraty „průměr nižší/vyšší než norma“ nebo „rozdíl od normy“, protože jde o srovnání s jinou populací, nikoli o změnu v čase.

**Kontroly:** každá náhrada skriptem s přesnou dvojicí původního a nového textu, který zapisuje jen při právě jedné shodě; rozdíl po slovech pročten kvůli gramatice (opraveno „ke stejnému výsledku“ v kapitole 9). Celá kniha vykreslena bez varování; `check-html.cjs` prošel (25 stran, odkazy, 132 řešení, mobil 390 px), `check-doc-maps.cjs` prošel; vybrané nové formulace ověřeny ve vykresleném HTML (kap. 4, 7, 10, vizualizace). Kapitolové karty a mapa obsahu se nemění (jazykové úpravy bez změny významu). Neověřeno: PDF kapitol (nebylo vyžádáno), prezentace a balíčky AI tutora (sjednotí se podle R76 při své příští úpravě); samostatná didaktická revize celých kapitol neproběhla, posouzena byla jen dotčená místa a jejich bezprostřední kontext.

<a id="revize-kapitola-08-2026-11-14"></a>

## Kapitola 8: revize podle autorových připomínek (2026-11-14, R76, R77)

Autor kapitolu prošel, sám upravil 18 řádků (např. „vypočtete“ místo „provedete“ test, úvod prvního oddílu, interpretace nestejných rozptylů) a poslal 14 připomínek ke konkrétním místům a 15 obecných požadavků. Jeho úpravy jsou zachovány; opraveny v nich byly jen „stojí terapii“ → „stojí terapie“, „záporné by opak“ → „záporné by znamenalo opak“ a vazba „Jeho volba“ k množnému číslu „designů“. Nové konvence dokládají [R76](../docs/rozhodnuti/spolecne-konvence.md#r76-jazykove-konvence) (jazyk a terminologie) a [R77](../docs/rozhodnuti/kapitola-08.md#r77-revize-kapitoly-8) (obsah kapitoly 8, částečně nahrazuje R59); skutečný obsah eviduje [karta kapitoly 8](../docs/kapitoly/08-porovnani-dvou-prumeru.md#mapa-kapitola-08).

**Obsahové úpravy kapitoly 8:**

- párový *t*-test nejdřív v obecném tvaru s $\mathrm{μ}_0$; nenulová nulová hypotéza na příkladu efektu opakování (+2 body) s výhradou ve prospěch kontrolní skupiny; u dvou skupin odkaz na TOST;
- nepovinné rozšíření o variabilitě rozdílů a korelaci obou měření, přesunuté z kapitoly 10, s novým obrázkem `korelace-rozdily` (tři simulované soubory s přesným výběrovým *r* 0,9; 0; −0,5 a SD varianty A, seed 20261114 + i); kontrastní věta o přesnosti párové analýzy přepsána (i v řešení úlohy 4c); zaokrouhlené vstupy dávají 2,40, nezaokrouhlené 2,39 a text to vysvětluje;
- vyvážení pořadí vysvětleno jako oddělení podmínky od pořadí; převod liber přibližně (1 lb ≈ 0,454 kg);
- nový obrázek `pomer-skupin` (směrodatná chyba rozdílu průměrů pro 60 lidí v poměru 1:1, 2:1, 4:1, skutečná vs. společný odhad) a v nepovinném rozšíření `welch-stupne`;
- doporučení klasický/Welch podle Howella (s. 219): klasický u přibližně stejně velkých skupin nebo při předem zdůvodněné shodě rozptylů, jinak Welch; nová tabulka `tbl-k08-odolnost` o robustnosti vůči porušení předpokladů;
- standardizace odlišena od informace o variabilitě; *d* = 1,00 pro variantu B vůči skupině po běžném spánku; nepovinné rozšíření `rozsireni-interval-d` (Howell s. 632, Cumming s. 190, Algina a Keselman 2003) a list `Klasicky_test` B21:B24;
- chybové úsečky a vysvětlení, proč se intervaly mohou překrývat při významném rozdílu ($\sqrt{a^2+b^2}<a+b$, pásmo 5,69–8,26 bodu);
- aktivní kontrolní skupina v příkladu tréninku (data beze změny); Gelmanův a Sternův číselný příklad nahrazen ilustrací na vlastních datech;
- ukázky APA s *d* a 95% CI, *SD* rozdílů a *r*; úloha 12b doplněna o CI pro *d*; shrnutí mluví o párovém *t*-testu;
- jazyk: „Tento oddíl …“ v úvodech oddílů, bez vazeb „X dalo Y“, „rozdíl průměrů“ a „průměrná změna“ místo holých výrazů, kurzivní *d*, „variabilita“, „intervence“, „korigovaný“ počet stupňů volnosti.

**Mimo kapitolu 8:** kapitola 10 má místo rozšíření připomenutí se zachovaným ID; „rozptýlenost“ → „variabilita“ v kapitole 10 (popisné „rozptýlené body“ zůstaly), „zásah“ → „intervence“ v kapitole 1 a ve slovníčku („zásahy“ jako úspěšné pokusy v kap. 5 a 9 zůstaly); kurzivní *d* ve slovníčku, značení a vizualizaci; nová hesla chybová úsečka a aktivní kontrolní skupina, symbol $s_d$; pravidla v AGENTS.md (oddíl Didaktika a jazyk); nový zdroj [D14](../docs/zdroje/D14-algina-keselman.md#d14), záznam `algina2003` v `references.bib`. Úvody oddílů a vazby „dát“ v ostatních kapitolách zůstávají na samostatný PR; prezentace a balíčky AI tutora se sjednotí při příští úpravě.

**Kontroly:**

- `check-chapter-08.R` doplněn o všechna nová čísla (μ₀ = 2, *s_D* podle *r*, simulace, směrodatné chyby a Welchovy stupně volnosti podle poměrů, intervaly pro *d* přibližně i z necentrálního *t*, párové *d* podle Alginy a Keselmana); prošel. `check-chapter-10.R` prošel.
- Sešit: `build-workbooks.ps1 -Chapter 8 -Verify` v českém Excelu 16.0; 86 buněk, 32 vzorců a 9 změn vstupů souhlasí s nezávislými referencemi z `check-chapter-08-excel-expected.py` (nové B21:B24 ve čtyřech sadách vstupů, české vzorce B22 a B23 s NORM.S.INV); kontroly sešitů kapitol 1–10 prošly.
- Nové obrázky vizuálně prohlédnuty (PNG náhledy ze stejného kódu); u `pomer-skupin` po první prohlídce rozdělen pravý panel na dva, protože se čáry obou scénářů překrývaly.
- Celá kniha vykreslena bez varování; `check-html.cjs` prošel (25 stran, odkazy, řešení, mobil 390 px; test kapitoly 8 nově počítá s 10 obrázky a pěti sbalenými rozšířeními, obrázky ve sbalených rozšířeních kontroluje po rozbalení), `check-table-layout.cjs` a `check-doc-maps.cjs` prošly.
- Didaktická revize změněných pasáží samostatným agentem v roli studenta po kapitole 7. Opraveno: nesoulad 12/13 studentů v ukázce zprávy A (chyba už v předchozí verzi), nedefinované *a*, *b* u $\sqrt{a^2+b^2}<a+b$ (nyní se směrodatnými chybami 2 a 2,83 a s rozdílem kvantilů), popis Welchových stupňů volnosti, jasná závěrečná věta k volbě testu, odpověď k příkladu 2, 4, 6 / 6, 12, 18 (směrodatná chyba 2,31 vs. 3,65), zaokrouhlení *d* = 1,004, rozdíl mezi odmocninou průměru rozptylů a průměrem směrodatných odchylek, srozumitelnější záhlaví tabulky robustnosti, korelace vysvětlená v ukázce zprávy a další drobnosti. Nejde o ověření porozumění na skutečných studentech.
- Neověřeno: PDF kapitoly 8 (nebylo vyžádáno), prezentace a balíčky AI tutora (sjednotí se podle R76 při své příští úpravě).

<a id="vizualizace-dva-intervaly"></a>

## Vizualizace dvou intervalů a intervalu rozdílu (2026-11-19, upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-19-intervaly)
přibyla dvanáctá stránka části „Interaktivní vizualizace“,
[Co prozradí dva intervaly vedle sebe o rozdílu průměrů](viz_dva_intervaly.qmd),
v menu za vizualizací Cohenova *d*. Kapitola 8 na ni odkazuje blokem
„Vyzkoušejte si: dva intervaly a interval rozdílu“ na konci oddílu
`sec-dva-intervaly`; jinak se výklad kapitoly nemění. Obsahuje:

- **ovládání:** nezávislé skupiny (průměr, *s*, *n*; klasický nebo Welchův postup) a párová data s posuvníkem $s_D$; hladina 90/95/99 %; čtyři předvolby;
- **grafy:** chybové úsečky se společnou částí a interval rozdílu; *p*-hodnota podle rozdílu průměrů se třemi pásmy; sloupce mezních chyb a trojúhelník směrodatných chyb;
- **výsledky:** slovní závěr ve čtyřech případech, souhrny a vzorce českého Excelu.

Redakční volby při realizaci:

- **Meze posuvníku $s_D$** jsou vysvětleny slovně (dokonale zachované postavení a úměrně opačný skór), bez korelace; nejmenší hodnota je alespoň 0,01, aby *t* zůstalo konečné.
- **Předvolba „Intervaly se právě dotýkají“** posune průměr po běžném spánku o součet mezních chyb při aktuálním nastavení (zaokrouhleno na čtyři desetinná místa), takže funguje pro všechna uspořádání a hladiny.
- **Kontrastní případ** nepřekrývajících se intervalů s nevýznamným klasickým testem (*s* 5, *n* 10 proti *s* 15, *n* 40, rozdíl 9) je jen v úkolu a v „Čeho si všimnout“; nevznikla pro něj předvolba.
- **Welchova *p*-hodnota** nemá vzorec Excelu ze souhrnů: T.DIST.2T zkracuje stupně volnosti a jiná funkce by byla nová; stránka odkazuje na `T.TEST` typ 3 z dat.
- **Numerika** převzata z vizualizace přínosu párování.

Nezávislá kontrola:

- **R** (`scripts/viz-dva-intervaly.R`, v repozitáři): příklad kapitoly na třech hladinách včetně *p* při dotyku intervalů (0,0053 pro 95 %), nestejné skupiny Welchem (shoda s `t.test` na datech se stejnými souhrny) i klasicky, kvantil přes `qbeta` jako `BETA.INV`, variabilnější větší skupina, data varianty A s krajními $s_D$. Čísla v textu pocházejí z tohoto výstupu.
- **Excel:** v desktopovém českém Excelu (nový sešit ve skryté instanci, zavřen bez uložení) spuštěny vzorce stránky: `T.INV(0,975;24)` 2,0639, společný odhad 10, směrodatná chyba 2,8284, `T.DIST.2T(ABS(2,1213);48)` 0,0391, Welchova směrodatná chyba 4,8088 a stupně volnosti 9,5053, kvantil přes `BETA.INV` 2,2440, `T.INV(0,995;24)` 2,7969; vše shodně s R.
- **Prohlížeč:** výchozí stav, předvolby, Welch a párová data prohlédnuty v prohlížeči aplikace; při prohlídce změněna barva sloupce a přepony rozdílu na tmavou, aby se nepletla s oranžovou skupiny po krátkém spánku.

**Kontroly:** celá kniha vykreslena (Quarto 1.9.38, R 4.5.1). `check-html.cjs` s novým blokem (popis v [provozním návodu](../docs/PROVOZ.md#interaktivni-vizualizace)) a s novým pořadím menu prošel celý (28 stránek, bez chyb JavaScriptu); prošly také `check-table-layout.cjs` a `check-doc-maps.cjs`.

**Omezení:** ověřeno v Chromiu; Firefox, Safari, skutečný telefon a čtečka obrazovky nebyly vyzkoušeny. Didaktická revize je interní, ne ověření na studentech.

**Úpravy po sloučení (2026-11-19, podle připomínek autora):** mezní chyba rozdílu a přepona trojúhelníku jsou zelené (`#3B7D3A`) místo tmavě šedé, která splývala s modrou. Trojúhelník je zrcadlově obrácen: pravý úhel leží v počátku, odvěsny podél os a přepona z (*a*; 0) do (0; *b*). Popisky jsou natočeny podél svých stran; úhel přepony se počítá z pixelových měřítek obou os a její popisek je posunut kolmo ven, protože Plot posun `dx`/`dy` neotáčí. Ve vizualizaci přínosu párování jsou vyšší graf skórů obou měření (440 px, na mobilu 340 px) a graf směrodatné chyby v modelu (360 px, na mobilu 300 px). Ověřeno prohlídkou v prohlížeči aplikace (výchozí stav a nestejné skupiny) a novým během `check-html.cjs`.

<a id="vizualizace-prinos-parovani"></a>

## Vizualizace přínosu párování (2026-11-19, upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-19-parovani)
přibyla jedenáctá stránka části „Interaktivní vizualizace“,
[Kdy párování zpřesní odhad průměrného rozdílu](viz_prinos_parovani.qmd),
v menu před vizualizací Cohenova *d*. Kapitola 8 na ni odkazuje blokem
„Vyzkoušejte si: kdy párování zpřesní odhad“ na konci oddílu
`sec-proc-rozdily`, před nepovinným rozšířením; jinak se výklad kapitoly
nemění. Obsahuje:

- **data a ovládání:** přepínač dat varianty A a výběru z modelu, dva způsoby zadání souvislosti (stabilní rozdíly a kolísání; σ₁, σ₂ a korelace), μ_D a *n* 3–200, tlačítko nového výběru;
- **grafy a výsledky:** spojnice jednotlivců, tečkový graf rozdílů s intervalem, oba intervaly na společné ose, tabulka obou analýz, křivka směrodatné chyby v modelu, vzorce českého Excelu;
- **opakované losování:** 100, 1000 nebo 10 000 výběrů po dávkách se stropem 100 000, podíl zamítnutí H₀, pokrytí μ_D, průměrná šířka a histogram šířek intervalů.

Redakční volby při realizaci:

- **Bez nových symbolů.** Model prvního způsobu je popsán slovy výkladu („stabilní rozdíly mezi lidmi“, „kolísání téhož člověka“); korelace v populaci nemá symbol (ρ není schválen), výběrové *r* se zobrazuje jen ve druhém způsobu. σ₁ a σ₂ používá kapitola 8 v oddílu `sec-rozdil-nezavislych`.
- **Spánková studie místo obecných měření:** popisky „po běžném / po krátkém spánku“ navazují na variantu A; populační průměr po běžném spánku je v modelu pevně 50 bodů.
- **Stejná náhodná čísla** se při změně nastavení znovu používají, aby student viděl vliv parametru, ne nové losování.
- **Doplněné zjištění:** při prohlídce vyšlo, že při malém podílu stabilních rozdílů (1 a 7 bodů) je párový interval v průměru o něco širší než interval chybné analýzy (asi 12,4 proti 11,9 bodu z 1000 výběrů) kvůli *n* − 1 st. v. „Čeho si všimnout“ to proto uvádí, aby text nesliboval vždy přesnější párový odhad.
- **Numerika** (`pnorm`, `qnorm`, `lgamma`, `ibeta`, `pt`, `qt`) převzata z vizualizace pokrytí intervalu, formátování a `parseDecimal` z vizualizace Cohenova *d*.

Nezávislá kontrola:

- **R** (`scripts/viz-prinos-parovani.R`, v repozitáři): obě analýzy pro data varianty A (shoda s tab. 8.4), kontrastní příklad a testovací soubor přes `t.test`; směrodatné chyby modelu; podíly zamítnutí párové analýzy přesně z necentrálního *t*-rozdělení a chybné analýzy simulací 400 000 výběrů (seed 20261119). Čísla v „Odkud se čísla berou“ a „Čeho si všimnout“ pocházejí z tohoto výstupu.
- **Excel:** v desktopovém českém Excelu (skrytá instance, sešit otevřen jen pro čtení a zavřen bez uložení) vrací na listu `Parovy_test` vzorec `=T.TEST(G2:G14;H2:H14;2;2)` 0,2269 a typ 1 0,00036, `=T.DIST.2T(ABS(1,2431);22)` 0,2269 a `=ODMOCNINA(7,3402^2/12+6,422^2/12)` 2,8154, shodně s R.
- **Prohlížeč:** výchozí stav, výběr z modelu se stabilními rozdíly 1 a kolísáním 7, opakované losování a tabulky prohlédnuty v prohlížeči aplikace; při prohlídce doplněno nezalamování mezí intervalu v tabulce.

**Kontroly:** celá kniha vykreslena (Quarto 1.9.38, R 4.5.1). `check-html.cjs` s novým blokem (popis v [provozním návodu](../docs/PROVOZ.md#interaktivni-vizualizace)) a s novým pořadím menu prošel celý bez chyb JavaScriptu; prošly také `check-table-layout.cjs` a `check-doc-maps.cjs`. Při ladění testu bylo třeba zachytit zamčené ovládání při losování po dávkách v jednom kroku a s *n* = 200, jinak dávky doběhly dřív, než je test zachytil.

**Omezení:** ověřeno v Chromiu (Playwright a prohlížeč aplikace); Firefox, Safari, skutečný telefon a čtečka obrazovky nebyly vyzkoušeny. Na šířce 375 px se tabulka obou analýz posouvá uvnitř svého rámečku. Podíly z opakovaného losování test porovnává s R jen v toleranci simulace. Didaktická revize je interní (čtení autorem změny), ne ověření na studentech.

<a id="vizualizace-cohenovo-d"></a>

## Vizualizace Cohenova d (2026-11-13, upřesnění R65)

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-13-cohen)
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

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-13-pokryti)
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

**Vizualizace ([upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-12-interval)).**
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

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-12-t)
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

[Podklady a manifest](../presentations/kapitola_07/kapitola_07_interval_t_test_a_ekvivalence_scenar_podklady.md)
zachycují přesné nastavení, identitu výsledku a kontroly. Ověřeny shodné
texty, úplné pořadí, dekódování částí i celku, součet délek, počet kapitol,
hlasitost, pauzy a shoda zvukových úseků každé části s celkem.
Skutečný poslech ani nezávislý přepis neproběhly; technická kontrola
nepotvrzuje výslovnost. Scénář, PPTX ani studentský výklad se neměnily.

<a id="scenar-kapitoly-7-20261109"></a>

## 2026-11-09 — Scénář k prezentaci kapitoly 7

Na výslovnou žádost autora připraven
[scénář pro syntézu řeči](../presentations/kapitola_07/kapitola_07_interval_t_test_a_ekvivalence_scenar.txt)
ke snímkům 1–32 aktuálního místního PPTX. Zahrnuje výklad a řešené příklady,
vynechává samostatné procvičování, diskusní otázky a organizační pokyny.
Text má 4 774 slov; odhad při 105–125 slovech za minutu je 38–46 minut bez dalších pauz.
Scénář obsahuje mluvený zápis čísel, vzorců a funkcí a požadované výslovnostní přepisy.
[Průvodní dokument](../presentations/kapitola_07/kapitola_07_interval_t_test_a_ekvivalence_scenar_podklady.md)
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

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-07-posun)
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

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-06-bayes)
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

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-06-binom)
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

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-06-vrp)
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

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-06-sila)
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

Podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-upresneni-2026-11-06)
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
podle [upřesnění R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-interaktivni-vizualizace):

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

Podle schváleného plánu ([R65](../docs/rozhodnuti/vizualizace-a-aplikace.md#r65-interaktivni-vizualizace))
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

[Průvodní dokument](../presentations/kapitola_06/kapitola_06_vyberove_rozdeleni_a_testovani_scenar_podklady.md)
a [manifest](../presentations/kapitola_06/kapitola_06_vyberove_rozdeleni_a_testovani_scenar_manifest.json)
zachycují parametry, identitu výstupu, časové značky a ověření.
Všechny části i celý MP3 se úspěšně dekódují, délka odpovídá součtu
částí, pořadí ověřeno také porovnáním průběhu zvuku z každé části
s příslušným místem celku. Hlasitost částí je vyrovnaná, detektor
nenašel ticho delší než dvě sekundy při prahu −50 dB. Skutečný poslech
nebyl proveden; technické kontroly nepotvrzují výslovnost. Scénář,
prezentace, kapitola ani sešity se při převodu neměnily.

## 2026-11-02 — Scénář k prezentaci kapitoly 6

Připraven [souvislý scénář pro syntézu řeči](../presentations/kapitola_06/kapitola_06_vyberove_rozdeleni_a_testovani_scenar.txt)
pro výkladové snímky 1–31 aktuální prezentace. Má 5 714 slov; samostatné
procvičování na snímcích 32–38, diskusní otázky a organizační pokyny
neobsahuje. Vychází z aktuálního místního PPTX včetně autorových úprav,
které autor výslovně povolil zahrnout do společného commitu; PPTX nebylo
při tvorbě scénáře přepisováno. Výslovnostní přepisy podle R53 jsou přímo
v textu, například „statystycký“, „alternatyvní“, „medyán“ a „kvantyly“.
Kanonický odborný zápis kapitoly ani terminologický registr se nemění.

[Průvodní dokument](../presentations/kapitola_06/kapitola_06_vyberove_rozdeleni_a_testovani_scenar_podklady.md)
obsahuje slovník výslovnosti, podklady a omezení kontrol;
[manifest](../presentations/kapitola_06/kapitola_06_vyberove_rozdeleni_a_testovani_scenar_manifest.json)
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
(postup v [PROVOZ.md](../docs/provoz/pdf.md#ruční-pdf-kapitol-16)). Filtr nově
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

<a id="lightbox-20261101"></a>

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

## 2026-11-16 — Pracovní PDF kapitoly 10

Na vyžádání byl export pracovního PDF rozšířen na kapitolu 10
(`scripts/render-chapter-pdf.ps1 -Chapter 10`, kontrola
`scripts/check-chapter-pdf.cjs --chapter 10` s 18 řešeními). Při prohlídce
se ukázalo, že Pandoc převádí zápornou mezeru `\!` na `#h(-1em)`, takže
v „H₀: ρ = 0“ (oddíl 10.8.2) a ve vzorci intervalu BCa se znaky překrývaly.
`scripts/pdf/common.ps1` nyní mezeru zkracuje na −1/6 em jako v TeXu; web
se nemění, kapitoly 3–9 zápornou mezeru `\!` v PDF nepoužívají.

**Kontroly:** render proběhl bez chyby (36 stran), kontrola transformace
prošla (18 řešení přesunuto, obousměrné odkazy, matematika, kód, obrázky,
tabulky a citace beze změny). Všech 36 stran vizuálně prohlédnuto,
oba opravené vzorce znovu zkontrolovány. **Neověřeno:** kontrola
`scripts/check-rendered-pdf.py` (příkaz `python` není v PATH) a srovnání
v jiném prohlížeči PDF.
<a id="rejstrik-archivovanych-zaznamu"></a>

## Rejstřík archivovaných záznamů

Původní kotvy záznamů přesunutých do archivu vedou sem; každá položka vede na záznam v archivu
(v pořadí původního souboru).

- <a id="prezentace-kapitoly-5-20261027"></a>[2026-10-27 — Prezentace ke kapitole 5](../docs/historie/2026-10.md#prezentace-kapitoly-5-20261027)
- <a id="licence-20261025"></a>[2026-10-25 — Licence CC BY 4.0 pro obsah a MIT pro kód](../docs/historie/2026-10.md#licence-20261025)
- <a id="kapitola-05-kruh-20261024"></a>[2026-10-24 — Kapitola 5: nepovinné rozšíření o kruhovosti klasického pojetí](../docs/historie/2026-10.md#kapitola-05-kruh-20261024)
- <a id="audio-kapitoly-4-20261020"></a>[2026-10-20 — Zvukový doprovod výkladové části prezentace ke kapitole 4](../docs/historie/2026-10.md#audio-kapitoly-4-20261020)
- <a id="prezentace-kapitoly-4-qq-20261020"></a>[2026-10-20 — Prezentace ke kapitole 4: histogram a Q–Q graf na samostatných slidech](../docs/historie/2026-10.md#prezentace-kapitoly-4-qq-20261020)
- <a id="popisek-z-pasma-20261020"></a>[2026-10-20 — Popisek osy z-skórů v obrázku stenů a staninů](../docs/historie/2026-10.md#popisek-z-pasma-20261020)
- <a id="prezentace-kapitoly-4-20261020"></a>[2026-10-20 — Prezentace ke kapitole 4](../docs/historie/2026-10.md#prezentace-kapitoly-4-20261020)
- <a id="struktura-prezentaci-20261020"></a>[2026-10-20 — Přehled obsahu a oddělovací slidy v prezentacích](../docs/historie/2026-10.md#struktura-prezentaci-20261020)
- <a id="sklonovani-odkazu-20261020"></a>[2026-10-20 — Skloňování odkazů na obrázky a tabulky](../docs/historie/2026-10.md#sklonovani-odkazu-20261020)
- <a id="revize-kapitoly-4-20261020"></a>[2026-10-20 — Revize kapitoly 4 podle připomínek autora](../docs/historie/2026-10.md#revize-kapitoly-4-20261020)
- <a id="revize-kapitoly-7-20261018"></a>[2026-10-18 — Cílená revize kapitoly 7](../docs/historie/2026-10.md#revize-kapitoly-7-20261018)
- <a id="dohoda-kapitola-07"></a>[Kapitola 7: dohoda o obsahu (2026-10-17)](../docs/historie/2026-10.md#dohoda-kapitola-07)
- <a id="vytvoreni-kapitoly-7"></a>[Kapitola 7: vytvoření výkladu (2026-10-17)](../docs/historie/2026-10.md#vytvoreni-kapitoly-7)
- <a id="terminologie-mereni-01"></a>[Zpřesnění výkladu po společné redakci (2026-09-20)](../docs/historie/2026-09.md#terminologie-mereni-01)
- <a id="terminologie-validita-01"></a>[Sjednocení hlavní místní kapitoly a doplnění validity (2026-09-20)](../docs/historie/2026-09.md#terminologie-validita-01)
- <a id="terminologie-rozsireni-01"></a>[Rozšíření pojmů v kapitole 1 (2026-09-20)](../docs/historie/2026-09.md#terminologie-rozsireni-01)
- <a id="terminologie-zaklad-01"></a>[Kapitola Od psychologické otázky k datům](../docs/historie/2026-09.md#terminologie-zaklad-01)
- <a id="terminologie-zaklad-02"></a>[Kapitola 2: četnosti a grafy (2026-09-28)](../docs/historie/2026-09.md#terminologie-zaklad-02)
- <a id="terminologie-meze-02"></a>[Kapitola 2: meze intervalů (2026-10-05)](../docs/historie/2026-10.md#terminologie-meze-02)
- <a id="terminologie-role-01"></a>[Kapitola 1: role proměnných (2026-10-05)](../docs/historie/2026-10.md#terminologie-role-01)
- <a id="terminologie-zaklad-03"></a>[Kapitola 3: ukazatele polohy a variability (2026-10-05)](../docs/historie/2026-10.md#terminologie-zaklad-03)
- <a id="terminologie-robustni-03"></a>[Kapitola 3: kumulativní kvantily, stupně volnosti a robustní shrnutí (2026-10-09)](../docs/historie/2026-10.md#terminologie-robustni-03)
- <a id="terminologie-entropie-03"></a>[Kapitola 3: názorná konstrukce boxplotu a normalizovaná entropie (2026-10-09)](../docs/historie/2026-10.md#terminologie-entropie-03)
- <a id="terminologie-transformace-03"></a>[Kapitola 3: reportování APA, transformace a shodné momenty (2026-10-09)](../docs/historie/2026-10.md#terminologie-transformace-03)
- <a id="terminologie-poradove-03"></a>[Kapitola 3: české reportování a zpřesnění výkladu (2026-10-09)](../docs/historie/2026-10.md#terminologie-poradove-03)
- <a id="priprava-kapitoly-4"></a>[Příprava kapitoly 4: normální rozdělení a standardní skóry (2026-10-10)](../docs/historie/2026-10.md#priprava-kapitoly-4)
- <a id="vytvoreni-kapitoly-4"></a>[Kapitola 4: vytvoření výkladu, 2026-10-10 {#vytvoreni-kapitoly-4}](../docs/historie/2026-10.md#vytvoreni-kapitoly-4)
- <a id="zalozeni-autorskeho-slovniku"></a>[2026-10-11: autorský registr terminologie](../docs/historie/2026-10.md#zalozeni-autorskeho-slovniku)
- <a id="dohoda-kapitola-05"></a>[Kapitola 5: dohoda o obsahu (2026-10-11)](../docs/historie/2026-10.md#dohoda-kapitola-05)
- <a id="vytvoreni-kapitoly-5"></a>[Kapitola 5: vytvoření výkladu (2026-10-12)](../docs/historie/2026-10.md#vytvoreni-kapitoly-5)
- <a id="revize-kapitoly-5-2026-10-12"></a>[2026-10-12 — Zapracování odborné, didaktické a technické revize kapitoly 5](../docs/historie/2026-10.md#revize-kapitoly-5-2026-10-12)
- <a id="dohoda-kapitola-06"></a>[Kapitola 6: dohoda o obsahu (2026-10-12)](../docs/historie/2026-10.md#dohoda-kapitola-06)
- <a id="vytvoreni-kapitoly-6"></a>[Kapitola 6: vytvoření výkladu (2026-10-12)](../docs/historie/2026-10.md#vytvoreni-kapitoly-6)
- <a id="reorganizace-autorskych-map"></a>[Reorganizace autorských map — 2026-10-13](../docs/historie/2026-10.md#reorganizace-autorskych-map)
- <a id="registr-rozhodnuti-2026-10-13"></a>[Registr rozhodnutí a hlavní místa informací — 2026-10-13](../docs/historie/2026-10.md#registr-rozhodnuti-2026-10-13)
- <a id="revize-kapitoly-5-2026-10-27"></a>[2026-10-27: Kapitola 5 podle autorových připomínek](../docs/historie/2026-10.md#revize-kapitoly-5-2026-10-27)
- <a id="reliabilita-validita-01"></a>[2026-10-31 — Kapitola 1: rozsah konstruktu, reliabilita a validita měření](../docs/historie/2026-10.md#reliabilita-validita-01)
- <a id="revize-kapitola-06-2026-10-31"></a>[2026-10-31 — Kapitola 6: revize podle autorových připomínek](../docs/historie/2026-10.md#revize-kapitola-06-2026-10-31)
