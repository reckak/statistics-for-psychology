# Interaktivní vizualizace a statistické aplikace

[Registr rozhodnutí a aktuální platnost](../ROZHODNUTI.md) · [Pravidla evidence](../../AGENTS.md#evidence-rozhodnuti)

Níže jsou zachovány původní záznamy R65 a R87 včetně všech upřesnění a doplnění,
2026-11-27 beze změny přesunuté ze souboru [Pracovní postupy a autorská dokumentace](postupy-a-dokumentace.md)
([doplnění R32](postupy-a-dokumentace.md#r32-doplneni-2026-11-27)). Data, rozsah a formulace se
vztahují k uvedeným dohodám; aktuální platnost a hlavní místo údržby určuje řádek v registru.
Nové upřesnění vizualizace či aplikace se připojuje sem k příslušnému rozhodnutí.

<a id="r65-interaktivni-vizualizace"></a>

## R65 — Část „Interaktivní vizualizace“

**Stav:** schváleno 2026-11-05. **Rozsah:** webová učebnice; nová část knihy
a odkazy na ni z výkladových kapitol. Netýká se ruční PDF ani balíčku AI tutora,
kam se vizualizace nepřebírají.

**Volba:**

- Kniha má třetí část „Interaktivní vizualizace“, zařazenou v `_quarto.yml`
  mezi výkladové kapitoly a „Literaturu a přehledy“; tři přehledy zůstávají
  na konci.
- Část se člení **podle jednotlivých vizualizací, nikoli podle kapitol**
  (ke kapitole jich může být více). Každá vizualizace je samostatná
  nečíslovaná stránka `quarto/viz_<tema>.qmd` s obsahovým nadpisem
  a stabilním ID `#sec-viz-<tema>`; v menu má jednu položku, pořadí určuje
  první navazující kapitola.
- Stránka postupně uvádí, na jakou otázku odpovídá a ke kterým oddílům se váže,
  model a ovládání s textovým popisem grafu, samotnou vizualizaci, 2–4 úkoly
  „Vyzkoušejte si“, oddíl „Čeho si všimnout“ a odkazy zpět na výklad.
- Výklad kapitoly musí obstát bez vizualizace. Z kapitoly na ni vede krátký
  blok `.callout-tip` s titulkem „Vyzkoušejte si: …“; vizualizace se do kapitol
  nevkládají.
- Technika: Quarto OJS s Observable Plot a d3 ze standardní knihovny,
  bez serveru, bez zobrazeného kódu a bez Shinylive/webR. Terminologie
  a značení podle registru a přehledu značení; ovládání klávesnicí, mobil
  bez přetékání stránky, simulace ověřené nezávislým výpočtem.
- Pilotní vizualizace: výběrové rozdělení průměru ke kapitole 6 ve výukovém
  modelu kapitoly, s velikostí výběru zadávanou jako celé číslo 1–100
  v číselném poli se šipkami. Další vizualizace se schvalují samostatně;
  seznam námětů v [plánu pokračování](../kapitoly/plan-pokracovani.md#plan-vizualizace)
  není schválením.

**Důvod:** pojmy kapitol 6–8 se vykládají přes opakované výběry a změnu
parametrů; statický obrázek ukáže jen jeden výsledek, kdežto interaktivní
stránka nechá studenta pokus opakovat. Samostatná část zachovává samostatnou
srozumitelnost výkladu i PDF.

**Doklad:** autor 2026-11-05 navrhl: „Myslím, že učebnici by mohlo vylepšit,
kdyby kromě obsahovala kromě dvou hlavních částí (Výkladové a Literatura
a Přehledy) také sekci s interaktivními vizualizacemi pro názorné pochopení
a ilustraci vybraných statistických konceptů“. Na doporučení začít pilotem
odpověděl „Ano, připrav návrh“. K návrhu doplnil: „Nečlenil bych to na
kapitoly, protože k jedné kapitole může být více vizualizací; takže bych to
prostě členil podle jednotlivých vizualizací.“ a „Velikost výběru bych nechal
stanovit pomocí input boxu s celým číslem od 1 do 100 a případně šipkami.“
Upravený plán (umístění, členění, blok „Vyzkoušejte si“, technika, pravidla
a pilot) téhož dne schválil. Pilot je realizací tohoto rozhodnutí; jeho
ověření eviduje [autorská historie](../../quarto/README.md).

### Upřesnění 2026-11-05 — Podoba pilotní vizualizace

Po sloučení pilotu autor požadoval: odstranit tlačítko „Zkopírovat do
schránky“, zvětšit panely, otočit popisek osy y svisle na střed, zadávat
počet nových losů číslem 1–1000 jako velikost výběru, omezit celkový počet
opakování na 100 000 se zprávou po dosažení stropu, vyznačit u populace i σ,
doplnit nad body posledního výběru empirický odhad hustoty, nabídnout více
populací se stejnými μ a σ a různým zešikmením („od mírného (to už tam je),
po střední, až po extrémní“) a přidat poslední řádek se dvěma normálními
Q–Q grafy, pro poslední výběr a pro dosavadní průměry. Na doplňující otázky
zvolil popisné pojmenování odhadu hustoty bez nového termínu („Odhad hustoty
z výběru“, žádné heslo ve slovníčku) a čtyři populace včetně souměrné.
Upravený plán téhož dne schválil. Odhad hustoty tím není zaveden jako pojem
učebnice; jeho případné zavedení by vyžadovalo samostatnou dohodu.

<a id="r65-upresneni-2026-11-06"></a>

### Upřesnění 2026-11-06 — Vizualizace ploch pod normální křivkou

Druhá vizualizace podle R65, ke kapitole 4: stránka
`quarto/viz_normalni_rozdeleni.qmd` („Plochy pod normální křivkou“,
`#sec-viz-normalni-rozdeleni`), v menu před pilotem.

- Společné zadání μ a σ pro obě části, výchozí N(0, 1).
- Část „Od hranice k podílu“: podíl vlevo od hranice, vpravo od ní, mezi
  dvěma mezemi a mimo interval. Část „Od podílu k hranici“: dolní a horní
  část rozdělení a souměrně prostřední část a oba chvosty dohromady.
- Ve výsledcích a ovládání se plocha nazývá **podíl** jako v kapitole 4;
  jedna věta na stránce ji propojuje s pravděpodobností (kapitola 5).
  Podíl se zadává desetinným číslem mezi 0 a 1 bez krajních hodnot.
- Doplňky: druhá řada popisků osy v z-skórech s převodem hranic, vzorec
  českého Excelu s dosazenými hodnotami a pod hustotou graf distribuční funkce.

**Doklad:** autor 2026-11-06 zadal: „Jako další vizualizaci bych vytvořil
vizualizaci normálního rozdělení. Nechal bych uživatele vždy zadat mí a sigmu
(s defaultním 0 a 1). Pak mohl zadat, zda chci zjistit pravděpodobnost hodnot
nalevo/napravo/mezi/vně určitého skóru nebo skórů (v případě mezi a vně).
Inverzně by mohl v druhém grafu zadat pravděpodobnost hodnot nalevo nebo
napravo a souměrně mezi a vně, a ukázalo by mu to příslušné skóry.“
Na doplňující otázky zvolil termín „Podíl“, všechny tři doplňky („Osa
z-skórů a převod“, „Vzorec v Excelu“, „Distribuční funkce“), „Společné μ a σ“
a zadání podílu „Desetinné číslo 0–1“; plán téhož dne schválil. Realizaci
a ověření eviduje [autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-06-sila"></a>

### Upřesnění 2026-11-06 — Vizualizace statistické síly

Třetí vizualizace podle R65, ke kapitole 6: stránka
`quarto/viz_statisticka_sila.qmd` („Na čem závisí statistická síla“,
`#sec-viz-statisticka-sila`), v menu za vizualizací výběrového rozdělení
průměru.

- Model testu rozdílu dvou průměrů z kapitoly 6: stejně velké nezávislé
  skupiny, známá σ, směrodatná chyba rozdílu σ√(2/n). Grafy podle
  předlohy `presentations/kapitola_06_uloha_4_sila_grafy.pdf`: křivky H₀
  a H₁, kritické hodnoty, α šrafováním, β a síla barevně.
- Vstupy: skutečný rozdíl μ₁ − μ₂, *n* v každé skupině (celé číslo),
  hladina α jako desetinné číslo (0 < α ≤ 0,5) a směr testu. σ je jeden
  vstup společný pro obě situace, výchozí 15 s.
- Dvě souběžně nastavitelné situace A a B se společnými osami místo
  srovnání s pevným výchozím stavem nebo ukládání nastavení; navíc křivka
  síly a vzorce českého Excelu s dosazenými hodnotami.
- Směr testu bez nových termínů: „oboustranný“ a „jednostranný“ se zápisem
  alternativy; „levostranný/pravostranný test“ se nezavádí.

**Doklad:** autor 2026-11-06 zadal: „Jako další vizualizaci bych vytvořil
vizualizaci statistické síly. Nechal bych uživatele vždy zadat rozdíl mezi
populačními průměry, velikost výběrů (pro zjednodušení bych předpokládal
stejně velké skupiny), hladinu alfa a typ testu (oboustranný, levostranný,
pravostranný).“ a odkázal na uvedenou předlohu. Na doplňující otázky zvolil
σ jako vstup s výchozí hodnotou 15 s, pojmenování „Jednostranný + zápis H₁“
a zadání α „Desetinné číslo“; z doplňků vybral „Křivka síly“ a „Vzorec
v Excelu“ a místo srovnání s výchozím stavem či uložených nastavení
požadoval „možnost nastavit vstupní parametry dvou ‚duplicitních‘
vizualizací“. K prvnímu návrhu plánu doplnil: „Populační σ bych asi
nechal nastavovat společně pro oba grafy.“ Upravený plán téhož dne schválil.
Realizaci a ověření eviduje [autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-06-vrp"></a>

### Upřesnění 2026-11-06 — Rozšíření vizualizace výběrového rozdělení průměru

Autor požadoval: „Maximum velikosti výběru bych zvýšil ze 100 na 1000“,
„Maximum počtu nových výběrů bych zvýšil z 1000 na 10000“, aby bylo snadnější
posoudit tvar, ukázat pod výběrovým rozdělením průměrů na původní škále
„i jejich rozdělení po standardizaci směrodatnou chybou a populačním průměrem
na z-skór“ a nabídnout „i extrémně zešikmené rozdělení“. K návrhu plánu
doplnil, že i ve standardizovaném histogramu má jít normální model zapnout
a vypnout, „ale stačí společné tlačítko s grafem pro nestandardizované
průměry“. Upravený plán téhož dne schválil.

Volba: *n* 1–1000, počet nových výběrů 1–10 000 se stropem 100 000
opakování a s losováním velkých požadavků po dávkách. Přibyl histogram
standardizovaných průměrů $z=(m-\mathrm{μ})/\mathrm{σ}_m$ se společným
přepínačem normálního modelu a s podíly nad 2 a pod −2. Pátá populace
je extrémně zešikmená se šikmostí 8 a se stejnými μ a σ.
Standardizace průměru je vyložena v kapitole 6, nový pojem se nezavádí.
Realizaci a ověření eviduje [autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-06-binom"></a>

### Upřesnění 2026-11-06 — Vizualizace binomického rozdělení

Čtvrtá vizualizace podle R65, ke kapitole 5: stránka
`quarto/viz_binomicke_rozdeleni.qmd` („Pravděpodobnost počtu úspěchů“,
`#sec-viz-binomicke-rozdeleni`), v menu za vizualizací ploch pod normální
křivkou.

- Vstupy *n* (celé číslo 1–1000 se šipkami) a π (0–1 včetně), výchozí
  test s 20 otázkami a π = 0,25.
- Jedna hranice *k* se třemi **nezávislými** zaškrtávacími poli „méně než“,
  „právě“, „více než“ (kombinace dávají nejvýše, alespoň, jiný počet než *k*),
  nebo rozpětí od *k*₁ do *k*₂ včetně obou mezí s pravděpodobností v rozpětí
  i mimo ně.
- Dvojí osa x: řada *k* v počtech a řada *p* = *k*/*n* v podílech.
- Přepínač normální aproximace: křivka a dva přibližné výpočty, s hranicí
  uprostřed sloupce a s hranicí posunutou o 0,5 na okraj sloupců, oba
  s rozdílem od přesné hodnoty. Postup s posunem odpovídá výpočtu „od 134,5“
  v kapitole 5; termín „korekce na spojitost“ se nezavádí.
- Doplňky: vzorce českého Excelu s dosazenými hodnotami, výsledek podmínky
  aproximace, μ a σ počtu i podílu (v grafu úsečka μ ± σ) a pod sloupci
  schodovitý graf kumulativní pravděpodobnosti jako obdoba distribuční funkce.

**Doklad:** autor 2026-11-06 zadal: „Jako další vizualizaci bych chtěl
zakomponovat binomické rozdělení. Uživatel by mohl zvolit pravděpodobnost
úspěchu a počet pokusů a pak si nechat vypočíst pravděpodobnost pro určitý
počet úspěchů; umožnil bych zakliknout, jestli chce x přesně k zahrnout,
jestli chce zahrnout x menší než k a x větší než k (ale ať to nejsou vzájemně
výlučné volby); případně pro počet úspěchů pro rozpětí k s tím, že by se
vypočtla pravděpodobnost i v tomto rozpětí i mimo něj. Taky by tam měl být
přepínač pro vykreslení normální aproximace a osa X dvojitá jak pro počty,
tak pro podíly.“ Na doplňující otázky zvolil „Křivka + obě aproximace“,
rozsah *n* „1–1000“ a všechny čtyři doplňky („Vzorec v Excelu“, „Podmínka
aproximace“, „Střední hodnota a σ“, „Distribuční funkce“); plán téhož dne
schválil. Realizaci a ověření eviduje [autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-06-bayes"></a>

### Upřesnění 2026-11-06 — Vizualizace Bayesovy věty

Pátá vizualizace podle R65, ke kapitole 5: stránka
`quarto/viz_bayesova_veta.qmd` („Co znamená pozitivní výsledek testu“,
`#sec-viz-bayesova-veta`), v menu mezi plochami pod normální křivkou
a binomickým rozdělením, protože oddíl o Bayesově větě předchází v kapitole 5
binomickému rozdělení.

- Vstupy prevalence, senzitivita a specificita (desetinná čísla 0–1 včetně),
  výchozí příklad poradny z kapitoly 5 (0,10; 0,95; 0,90); volba 1 000 nebo
  10 000 osob a tlačítka obou příkladů kapitoly (poradna, plošné šetření
  s prevalencí 0,01).
- Hlavní obraz **mřížka osob**: jeden čtvereček na osobu ve čtyřech barvách
  podle kombinace stavu a výsledku, uspořádání podle skutečného stavu, podle
  výsledku dotazníku, jen pozitivní a jen negativní výsledky při stejné
  velikosti čtverečků. Necelé přirozené četnosti se zaokrouhlují na celé
  osoby s upozorněním „přibližně“; pravděpodobnosti se počítají přesně.
- Doplňky: strom a kontingenční tabulka se živými čísly a čtením po řádcích
  (senzitivita, specificita) a po sloupcích (prediktivní hodnoty); Bayesova
  věta s dosazenými hodnotami a vzorce českého Excelu podle listu `Bayes`;
  křivka prediktivní hodnoty pozitivního a negativního testu podle prevalence;
  druhé vyšetření, v němž se aposteriorní pravděpodobnost po prvním testu
  stává apriorní pro druhý, s výslovným předpokladem, že druhé vyšetření
  přináší novou informaci (bez termínu „podmíněná nezávislost“).
- Nové pojmy se nezavádějí (ani věrohodnost, poměr věrohodností či šance
  mimo nepovinné rozšíření kapitoly).

**Doklad:** autor 2026-11-06 se zeptal: „Jaká by byla nejvhodnější
interaktivní vizualizace pro Bayesovu větu?“ Na doplňující otázky zvolil
hlavní obraz „Mřížka osob“ (doporučená možnost, proti plošnému diagramu
a samotnému stromu s tabulkou) a všechny čtyři doplňky („Strom a tabulka
2×2“, „Křivka podle prevalence“, „Vzorec a Excel“, „Druhé vyšetření“);
plán téhož dne schválil. Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-07-posun"></a>

### Upřesnění 2026-11-07 — Vizualizace posunu a změny jednotek

Šestá vizualizace podle R65, ke kapitole 3: stránka
`quarto/viz_posun_a_jednotky.qmd` („Co s rozdělením udělá posun a změna
jednotek“, `#sec-viz-posun-a-jednotky`), v menu na prvním místě, protože
navazuje na kapitolu 3.

- Lineární transformace $y_i=a+b x_i$ se zadávaným posunem *a* a násobitelem
  *b* (libovolná čísla včetně záporných a nuly) na třech souborech kapitoly 3:
  pět časů 4, 5, 5, 6, 10 min, doby spánku (33 platných hodnot) a vybavená
  slova (36 hodnot). Předvolby z kapitoly: +2 minuty, minuty na sekundy,
  obojí ($a=120$, $b=60$), hodiny spánku na minuty, obrácení skórování
  slov $12-x$ a krajní případ $b=0$.
- Hlavní obraz **dvě osy se spojnicemi**: tečkový graf původních hodnot
  nad tečkovým grafem převedených, spojnice od každé různé původní hodnoty
  k nové, barva teček podle původní hodnoty, průměr, medián, úsečky
  $m\pm s$ a od 1. do 3. kvartilu; přepínač společné a vlastní osy.
- Tabulka ukazatelů polohy, variability a tvaru: hodnota z původních dat,
  hodnota spočtená znovu z převedených dat a předpověď pravidlem
  s dosazením (výměna kvartilů a změna znaménka šikmosti při $b<0$).
- Kontrast s nelineárním převodem $x^2$ a $\sqrt{x}$: místo pravidla převod
  původního ukazatele polohy se zjištěním, zda se shoduje.
- Vzorce českého Excelu pro pomocný sloupec (u spánku s KDYŽ kvůli chybějícím
  údajům) a pro ukazatele převedených hodnot. Nové pojmy se nezavádějí.

**Doklad:** autor 2026-11-07 se zeptal: „Jaká by byla nejvhodnější
vizualizace toho, co s ukazateli polohy, variability a tvaru a s grafem
rozdělením udělá posun a změna jednotek?“ Na doplňující otázky zvolil
hlavní obraz „Dvě osy se spojnicemi“ (doporučená možnost, proti grafům
před a po bez spojnic a jedinému grafu se dvěma řadami popisků), všechny
čtyři doplňky („Tabulka před/po/pravidlo“, „Přepínač osy: společná/vlastní“,
„Kontrast s nelineárním převodem“, „Vzorce českého Excelu“) a data „Data
z kapitoly + předvolby“; plán téhož dne schválil. Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-12-t"></a>

### Upřesnění 2026-11-12 — Vizualizace *t*-rozdělení a normovaného normálního

Sedmá vizualizace podle R65, ke kapitole 7: stránka
`quarto/viz_t_rozdeleni.qmd` („Jak se *t*-rozdělení liší od normovaného
normálního“, `#sec-viz-t-rozdeleni`), v menu za vizualizací statistické síly.
Realizuje námět „t a normální rozdělení podle stupňů volnosti“ z plánu
pokračování.

- Jediným vstupem stupňů volnosti je posuvník 1–100, výchozí 4 (výběr pěti
  lidí z kapitoly 7); číselné pole se nepoužívá.
- Čtyři grafy: hustoty obou rozdělení, normální Q–Q graf $t_{p\,(v)}$ proti
  $z_p$ v orientaci kapitoly 4, absolutní chyba normální aproximace
  (normální − *t*) a relativní chyba (absolutní chyba dělená hodnotou
  z *t*-rozdělení, v %). Grafy chyb mají přepínač veličiny: podíl ve chvostu
  za hranicí (výchozí), nebo výška hustoty.
- Stránka chyby vysvětluje vlastním oddílem se vzorcem, řešeným příkladem
  a zdůvodněním, proč relativní chyba ve chvostech roste. Absolutní
  a relativní chyba se popisují bez hesla ve slovníčku a nejsou zavedeny
  jako pojmy učebnice.
- Doplňky: zadávaná hranice s podíly za ní v obou rozděleních a s oběma
  chybami, vzorce českého Excelu (T.DIST, NORM.S.DIST, T.INV, NORM.S.INV)
  s dosazenými hodnotami. Tabulky: živá tabulka kvantilů úrovní 0,90; 0,95;
  0,975; 0,99; 0,995; 0,9995 pro zvolené stupně volnosti s použitím
  v kapitole 7 a pevná tabulka pro vybrané stupně volnosti se zvýrazněným
  řádkem.
- Předlohou námětu je stránka R. Magnussona „Student's t-distribution“
  (rpsychologist.com/d3/tdist/). Jde o vlastní inspiraci: text, kód ani
  grafika se nepřebírají a studentská stránka ji proto necituje.

**Doklad:** autor 2026-11-12 zadal: „Myslím, že další interaktivní
vizualizace by mohla zahrnovat srovnání Studentova t-rozdělení
a normovaného normálního rozdělení, něco jako:
https://rpsychologist.com/d3/tdist/ Se stupni volnosti 1 až 100, křivkami
hustoty, QQ grafem, grafem absolutní chyby s vysvětlením a grafem relativní
chyby s vysvětlením (myslím že právě to na rpsychologist není moc dobře
vysvětleno) a tabulkou se srovnání nejčastěji používaných kvantilů t-
a z-rozdělení“. Na doplňující otázky zvolil pro grafy chyb „Obojí
s přepínačem“ (podíl ve chvostu a výška hustoty), tabulku „Pro zvolené v
+ pevná“, doplňky „Hranice s podíly“, „Vzorce českého Excelu“ a „Posuvník
k číselnému poli“ a pojmenování chyb „Popisně, bez hesla“. Při schvalování
plánu upřesnil: „Pro stupně volnosti bych dal jako input posuvník od 1
do 100“; upravený plán téhož dne schválil. Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-12-interval"></a>

### Upřesnění 2026-11-12 — Vizualizace intervalu spolehlivosti a *p*-hodnoty

Osmá vizualizace podle R65, ke kapitole 7: stránka
`quarto/viz_interval_a_test.qmd` („Jak spolu souvisí interval spolehlivosti
a *p*-hodnota“, `#sec-viz-interval-a-test`), v menu za vizualizací
*t*-rozdělení. Spojuje obrázky kapitoly 7 `fig-p-funkce` a
`fig-zrcadlo-intervalu`; statické obrázky v kapitole zůstávají.

- Model jednovýběrového *t*-testu. Vstupy: testovaná hodnota μ₀ a výběrový
  průměr *m* (posuvník a číselné pole), *s* a *n* (výchozí 11 a 25), α jako
  desetinné číslo 0 < α ≤ 0,5 a směr testu (oboustranný, jednostranný
  s alternativou μ < μ₀ nebo μ > μ₀).
- Dva grafy pod sebou se společnou osou skóre, vždy s *m* i μ₀: pohled
  intervalu (*p*-hodnota podle μ₀, interval spolehlivosti kolem *m*) a pohled
  testu (*p*-hodnota podle *m*, oblast nezamítnutí kolem μ₀).
- U jednostranného testu jednostranný interval spolehlivosti
  ([R75](kapitola-07.md#r75-oboustranny-jednostranny-interval)) i oboustranný
  interval se spolehlivostí 1 − 2α; zrcadlově v pohledu testu jednostranná
  a souměrná oblast nezamítnutí.
- Doplňky: tabulka čtyř pohledů na totéž rozhodnutí s čísly, vzorce českého
  Excelu, předvolby příkladů kapitoly (pozornost oboustranně a jednostranně,
  PDI) a u jednostranného testu tenká křivka oboustranné *p*-hodnoty
  s hladinou 2α.

**Doklad:** autor 2026-11-12 zadal: „Myslím, že tyto dva obrázky by také bylo
možné spojit do jedné interaktivní vizualizace, např. zrcadlově vedle sebe
svisle ukázat interval spolehlivosti a oblast nezamítnutí, vždy zobrazit
výběrový průměr a průměr pod H0; v grafu pro CI ukázat, jak se p-hodnota mění
pro různé testované H0, a v grafu pro oblast zamítnutí ukázat, jak se
p-hodnota mění pro různé výběrové průměry. Jako input nechat nastavovat různé
hodnoty mí pod H0 a pozorovaného výběrového průměru, hladinu významnosti alfa
a typ testu (oboustranný, jednostranný s alternativou "menší" nebo "větší").
U jednostranných testů zobrazit jak noncentrální CI, tak odpovídají centrální
CI s hladinou spolehlivosti 1–2alfa.“ Na doplňující otázky zvolil uspořádání
„Pod sebou, společná osa“, *s* a *n* „Nastavitelné, výchozí 11 a 25“, zadání
*m* a μ₀ „Posuvník + číselné pole“, všechny čtyři doplňky („Tři cesty
s čísly“, „Vzorce českého Excelu“, „Předvolby příkladů kapitoly“, „Oboustranná
křivka i u jednostranného“), zrcadlení „Ano, obě varianty“ a α „Desetinné číslo
0 < α ≤ 0,5“. K pojmenování intervalů zavedl R75. Plán schválil 2026-11-13.
Realizaci a ověření eviduje [autorská historie](../../quarto/README.md).

<a id="r65-upresneni-2026-11-13-pokryti"></a>

### Upřesnění 2026-11-13 — Vizualizace pokrytí intervalu spolehlivosti

Devátá vizualizace podle R65, ke kapitole 7: stránka
`quarto/viz_pokryti_intervalu.qmd` („Jak často interval spolehlivosti
zachytí populační průměr“, `#sec-viz-pokryti-intervalu`), v menu mezi
vizualizací *t*-rozdělení a vizualizací intervalu a *p*-hodnoty. Rozšiřuje
obrázek kapitoly 7 `fig-opakovane-intervaly`, který v kapitole zůstává.

- Vstupy: populace (normální a čtyři zešikmené doprava: tvary tabulky
  `tbl-k07-odolnost` se šikmostí 0,7, 2 a 6 a posunutá lognormální se
  šikmostí 8 jako ve vizualizaci výběrového rozdělení průměru, vše převedené
  na zadané μ a σ), μ, σ, *n* 2–1 000, hladina spolehlivosti v % (větší
  než 50, menší než 100), postup (známá σ s kvantilem *z*, *s* s kvantilem *t*,
  *s* s kvantilem *z* jako chybný postup), typ intervalu (oboustranný,
  jednostranný s horní nebo dolní mezí podle
  [R75](kapitola-07.md#r75-oboustranny-jednostranny-interval)) a počet nových
  výběrů 1–10 000 se stropem 100 000.
- Losování po dávkách; změna hladiny, postupu nebo typu přepočítá intervaly
  z týchž výběrů, změna populace, μ, σ nebo *n* začne znovu.
- Grafy: posledních 100 intervalů (zachytil modře, minul oranžově), vývoj
  pokrytí s pásem ± 1,96 směrodatné chyby podílu, histogramy průměrů, *s*
  a šířek intervalů rozdělené barvou podle výsledku.
- Pokrytí v simulaci proti očekávanému: u normální populace přesně
  (pro chybný postup z *t*-rozdělení), u zešikmených populací slovně směr
  očekávání u malých výběrů podle postupu a typu intervalu se zdůvodněním.
- Doplňky: detail vybraného intervalu (myš, klepnutí, šipky), výpočet
  vybraného intervalu se vzorci českého Excelu a tři předvolby.

**Doklad:** autor 2026-11-13 zadal: „Myslím, že další vizualizace by se mohla
týkat intervalů spolehlivosti podobně jako: https://rpsychologist.com/d3/CI/
Uživatel by měl možnost nastavit hladinu spolehlivosti, mí a sigma, to zda se
předpokládá známá sigma nebo se odhaduje na základě výběru, jestli chce
tradiční oboustranné CI nebo jednostranné (a s kterou hranicí), jaká má být
velikost výběru a počet simulovaných výběrů. Barevně bych odlišil, které
intervaly zachytily vs nezachytili mí. Ukázal bych také podíly: skutečné vs
očekávané pokrytí. vývoj pokrytí, rozdělení výběrových průměrů, směrodatných
odchylek a šířek CI.“ Na doplňující otázky zvolil „Tři postupy“, populace
„I zešikmená“, losování „Po dávkách“ a všechny čtyři doplňky („Barvy
i v histogramech“, „Pás náhodného kolísání“, „Detail intervalu“, „Vzorce
českého Excelu“). K plánu doplnil: „Ve vizualizaci výběrového rozdělení
průměru je i extrémně zešikmená (šikmost 8), takže by mohla být i tady.“
a „U zešikmených bych kromě ‚nelze spočítat přesně, odhaduje simulace‘ ale
uvedl, jaké je podle typu intervalu (oboustranný, jednostranný s horní vs
dolní mezí) naše očekávání, jestli bude vyšší, nebo nižší než nominální
u malých výběrů.“ Upravený plán téhož dne schválil. Realizaci a ověření
eviduje [autorská historie](../../quarto/README.md#vizualizace-pokryti-intervalu).

<a id="r65-upresneni-2026-11-13-cohen"></a>

### Upřesnění 2026-11-13 — Vizualizace Cohenova d

Desátá vizualizace podle R65, ke kapitole 8: stránka
`quarto/viz_cohenovo_d.qmd` („Co znamená rozdíl o *d* směrodatných
odchylek“, `#sec-viz-cohenovo-d`), v menu za vizualizací intervalu
a *p*-hodnoty. Kapitola 8 na ni odkazuje blokem „Vyzkoušejte si“ na konci
oddílu `sec-d-nezavisle`.

- Model: dvě normální populace se shodnou σ, skupina 1 s vyšším průměrem,
  $d=(\mathrm{μ}_1-\mathrm{μ}_2)/\mathrm{σ}$.
- Vstupy: posuvník *d* 0–2 po 0,01, výchozí 0,5, obecné „skupina 1“
  a „skupina 2“; pole σ v původních jednotkách (výchozí 10) jen pro převod
  na rozdíl průměrů $d\cdot\mathrm{σ}$; přepínač vybarvení (společná plocha,
  nebo skupina 1 nad průměrem skupiny 2).
- Tři ukazatele **jen českým opisem**, bez anglických názvů a bez hesel ve
  slovníčku: podíl skupiny 1 nad průměrem skupiny 2 $\mathrm{Φ}(d)$ (v literatuře
  Cohenovo U₃), společná plocha obou rozdělení $2\,\mathrm{Φ}(-d/2)$ (overlap;
  slovo „překryv“ se nepoužívá kvůli překryvu intervalů v kap. 8)
  a pravděpodobnost, že náhodně vybraný člověk ze skupiny 1 má vyšší
  hodnotu než náhodně vybraný člověk ze skupiny 2, $\mathrm{Φ}(d/\sqrt2)$
  (probability of superiority). Každý se vzorcem českého Excelu
  s dosazeným *d*.
- Grafy: rozdělení obou skupin a rozdělení rozdílu hodnot náhodné dvojice
  $N(d,\sqrt2)$ s vybarvenou plochou vpravo od nuly; σ√2 se opírá
  o sčítání rozptylů z oddílu kap. 8 `sec-rozdil-nezavislych`.
- Doplňky: pevná tabulka pro *d* = 0; 0,2; 0,5; 0,8; 1; 1,5; 2 se
  zvýrazněným (případně vloženým) zvoleným *d*; Cohenovy orientační hodnoty
  jako značky posuvníku a štítky tabulky s výhradou podle
  [R56](kapitola-06.md#r56-p-hodnota-cohen).
- Předlohou námětu je stránka R. Magnussona „Interpreting Cohen's d“
  (rpsychologist.com/cohend). Jde o vlastní inspiraci: text, kód ani
  grafika se nepřebírají a studentská stránka ji proto necituje.

**Doklad:** autor 2026-11-13 zadal: „Jako další vizualizaci bych doplnil
vizualizaci Cohenova d, podobně jako: https://rpsychologist.com/cohend
Myslím, že jako input by stačilo mít slider s Cohenovým d. A uvádět Cohen's
U₃, % Overlap a Probability of Superiority; nemusíme nutně zavádět nové
termíny, ale vyjádřit to opisem.“ Na doplňující otázky zvolil posuvník
„0 až 2, krok 0,01“, „d = 0,5, obecné skupiny“, všechny čtyři doplňky
(„Vzorce českého Excelu“, „Pevná tabulka pro vybraná d“, „Cohenova pásma
s výhradou“, „Převod na původní jednotky“) a „Jen český opis“. Plán téhož
dne schválil. Druhý graf (rozdíl hodnot náhodné dvojice) a přepínač
vybarvení přibyly při realizaci jako názorné doplnění třetího, resp.
prvního ukazatele. Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md#vizualizace-cohenovo-d).

<a id="r65-upresneni-2026-11-19-parovani"></a>

### Upřesnění 2026-11-19 — Vizualizace přínosu párování

Jedenáctá vizualizace podle R65, ke kapitole 8: stránka
`quarto/viz_prinos_parovani.qmd` („Kdy párování zpřesní odhad průměrného
rozdílu“, `#sec-viz-prinos-parovani`), v menu před vizualizací Cohenova *d*
podle pořadí oddílů kapitoly. Kapitola 8 na ni odkazuje blokem
„Vyzkoušejte si“ na konci oddílu `sec-proc-rozdily`, před nepovinným
rozšířením o korelaci.

- Data: po načtení dvanáct úplných dvojic varianty A (tab. 8.2), výsledky
  shodné s tab. 8.4; jinak výběr *n* = 3–200 studentů z normálního modelu,
  přepočítaný při změně nastavení ze stejných náhodných čísel, a tlačítko
  nového výběru. Populační průměr rozdílů $\mathrm{μ}_D$ (výchozí 3,5).
- Souvislost obou měření dvěma způsoby přepínačem: (1) výchozí „stabilní
  rozdíly mezi lidmi“ a „kolísání téhož člověka“ jako dvě směrodatné
  odchylky v bodech (6,7 a 1,7), slovy výkladu `sec-proc-rozdily`, bez
  nových symbolů; (2) σ₁, σ₂ a „korelace obou měření v populaci“ bez symbolu
  pro čtenáře nepovinného rozšíření, výběrové *r* se zobrazí jen zde.
- Párová analýza a chybná analýza jako dvou nezávislých skupin (klasický
  *t*-test, 2*n* − 2 st. v.) vedle sebe: tabulka jako tab. 8.4, spojnice
  jednotlivců, tečkový graf rozdílů s intervalem a oba intervaly na
  společné ose.
- Doplňky: křivka směrodatné chyby obou analýz v modelu podle podílu
  stabilních rozdílů na rozptylu měření (způsob 1) nebo korelace (způsob 2);
  opakované losování 100 / 1000 / 10 000 výběrů po dávkách se stropem
  100 000 (podíl zamítnutí H₀, pokrytí μ_D, průměrná šířka a histogram
  šířek intervalů); vzorce českého Excelu s dosazenými souhrny a u dat
  varianty A `T.TEST` typ 1 a 2 na listu `Parovy_test`.
- Studentský text nezavádí nové pojmy; „podíl stabilních rozdílů na rozptylu
  jednoho měření“ je opis osy grafu, ne nový termín.

**Doklad:** 2026-11-19 se autor zeptal, zda by se ke kapitole 8 hodila další
vizualizace. Z návrhu (přínos párování, dva intervaly vedle sebe a interval
rozdílu) vybral „Přínos párování“. Na doplňující otázky zvolil ovládání
„Obojí přepínačem“ (dvě směrodatné odchylky i korelace), data „Výběr +
varianta A“, všechny čtyři doplňky („Křivka směrodatné chyby“, „Opakované
losování“, „Vzorce českého Excelu“, „Graf rozdílů jednotlivců“) a odkaz na
konci „Proč rozdíly kolísají méně“. Plán téhož dne schválil. Realizaci
a ověření eviduje [autorská historie](../../quarto/README.md#vizualizace-prinos-parovani).

<a id="r65-upresneni-2026-11-19-intervaly"></a>

### Upřesnění 2026-11-19 — Vizualizace dvou intervalů a intervalu rozdílu

Dvanáctá vizualizace podle R65, ke kapitole 8: stránka
`quarto/viz_dva_intervaly.qmd` („Co prozradí dva intervaly vedle sebe
o rozdílu průměrů“, `#sec-viz-dva-intervaly`), v menu za vizualizací
Cohenova *d* podle pořadí oddílů kapitoly. Kapitola 8 na ni odkazuje
blokem „Vyzkoušejte si“ na konci oddílu `sec-dva-intervaly`.

- Uspořádání přepínačem: nezávislé skupiny (průměr, *s*, *n* 2–1000 pro
  každou; interval rozdílu klasickým *t*-testem, nebo Welchovým), nebo
  párová data (průměr a *s* obou podmínek, jedno *n*, posuvník $s_D$
  v mezích $|s_1-s_2|$ až $s_1+s_2$, vysvětlených bez korelace).
- Hladina spolehlivosti 90, 95 nebo 99 % pro intervaly průměrů i rozdílu.
- Grafy: chybové úsečky obou průměrů se společnou částí a interval rozdílu
  s nulou; *p*-hodnota podle rozdílu průměrů se třemi pásmy (hranice
  „rozdíl významný od“ a „intervaly se přestanou překrývat od“); sloupce
  mezních chyb a u nezávislých skupin pravoúhlý trojúhelník směrodatných
  chyb.
- Doplňky: slovní závěr ve čtyřech případech, předvolby (příklad kapitoly,
  právě se dotýkající intervaly, nestejné skupiny s Welchem, data varianty A
  párově), vzorce českého Excelu včetně kvantilu Welche přes `BETA.INV`
  jako na listu `Welch`.
- Bez nových pojmů a symbolů; bez pravidla pro čtení překryvu, které
  kapitola záměrně neuvádí.

**Doklad:** 2026-11-19 autor požádal: „můžeš vytvořit také vizualizaci
2. Dva intervaly vedle sebe a interval rozdílu?“ Na doplňující otázky
zvolil uspořádání „Nezávislé i párové“, postup „Klasický + přepínač
Welch“, všechny čtyři doplňky („Graf pásma podle rozdílu“, „Znázornění
mezních chyb“, „Vzorce českého Excelu“, „Předvolby příkladů“) a hladinu
„Volitelná (90/95/99 %)“. Plán téhož dne schválil. Realizaci a ověření
eviduje [autorská historie](../../quarto/README.md#vizualizace-dva-intervaly).

<a id="r65-upresneni-2026-11-20-chi"></a>

### Upřesnění 2026-11-20 — Vizualizace tabulky četností a testu chí-kvadrát

Třináctá vizualizace podle R65, první ke kapitole 9: stránka
`quarto/viz_chi_kvadrat.qmd` („Jak daleko je tabulka četností od
nezávislosti“, `#sec-viz-chi-kvadrat`), v menu za vizualizací dvou
intervalů. Kapitola 9 na ni odkazuje blokem „Vyzkoušejte si“ v pododdílu
`sec-pearson-upravena`, za nepovinným rozšířením o Holmově korekci.

- Východiskem je příklad kapitoly věk × strategie zvládání stresu
  (3 × 3, *n* = 190). Student přepisuje pozorované četnosti přímo
  v tabulce (celá čísla 0–100 000); součty se dopočítávají.
- Tlačítka „Zdvojnásobit četnosti“, „Původní data“ a „Nezávislost“
  (zaokrouhlené očekávané četnosti původní tabulky).
- Odvozené tabulky: očekávané četnosti, příspěvky buněk ke χ², Pearsonova
  rezidua a standardizovaná rezidua. Standardizovaná rezidua jsou
  podbarvená podle hodnoty (modře více, oranžově méně, než odpovídá
  nezávislosti), bez pevné hranice ±1,96 a s výhradou o více testech.
- Grafy: řádkové podíly jako na obrázku kapitoly, překreslované podle
  tabulky (bez tažení sloupců), a chí-kvadrát rozdělení se čtyřmi stupni
  volnosti s vybarvenou *p*-hodnotou a kritickou hodnotou pro hladinu 0,05.
- Doplňky: Cramérovo V, upozornění při očekávané četnosti pod 5 s odkazem
  na oddíl o předpokladech, slovní závěr testu, vzorec českého Excelu.
- Oddíl „Odkud se čísla berou“ opakuje všechny použité vzorce ve znění
  kapitoly s dosazením.
- Bez nových pojmů a symbolů; velikost tabulky je pevná.

**Doklad:** 2026-11-20 autor na nabídku čtyř námětů ke kapitole 9 odpověděl:
„zapracoval bych tedy nejprve vizualizaci 1. Od tabulky četností k testu
chí-kvadrát. Vyšel bych z příkladu věk × strategie zvládání stresu. Nechal
bych studenty upravovat pozorované četnosti a také bych tam dal tlačítko
pro jejich zdvojnásobení. V odvozených tabulkách bych ukázal např. očekávané
četnosti, Personova rezidua i standardizovaná rezidua. Výsledky bych
znázornil i graficky tak, jak to ukazuje kapitole s tím, že graf by byl
interaktivní […] Doplnil bych i chi-square rozdělení s odpovídajícím
vybarveným podílem reprezentujícím p-hodnotu.“ Na doplňující otázky zvolil
graf „Reaguje na tabulku“, rezidua „Podbarvení podle hodnoty“ a všechny
čtyři doplňky („Cramérovo V“, „Příspěvky buněk ke χ²“, „Upozornění na malé
očekávané četnosti“, „Tlačítko ‚Nezávislost‘“). K plánu doplnil: „Taky bych
zopakoval všechny relevantní vzorce.“ Plán téhož dne schválil. Realizaci
a ověření eviduje [autorská historie](../../quarto/README.md#vizualizace-chi-kvadrat).
Zbylé tři náměty ke kapitole 9 zůstávají otevřeným návrhem v
[plánu pokračování](../kapitoly/plan-pokracovani.md#plan-vizualizace).

<a id="r65-upresneni-2026-11-20-miry"></a>

### Upřesnění 2026-11-20 — Vizualizace rozdílu podílů, poměru rizik a poměru šancí

Čtrnáctá vizualizace podle R65, druhá ke kapitole 9: stránka
`quarto/viz_miry_souvislosti.qmd` („Co říkají rozdíl podílů, poměr rizik
a poměr šancí o téže tabulce“, `#sec-viz-miry-souvislosti`), v menu za
vizualizací chí-kvadrát. Kapitola 9 na ni odkazuje blokem „Vyzkoušejte si“
na konci pododdílu `sec-phi-v`, před nepovinným rozšířením o intervalech
poměrů.

- Zadání přepínačem: četnosti tabulky 2 × 2 (výchozí údaje Danielsové),
  nebo dvě rizika posuvníky ve stejně velkých skupinách po 100, 1 000
  nebo 10 000 osobách. Předvolby Danielsová a aspirinová studie, tlačítko
  záměny referenční skupiny.
- Dvě skupiny osob jako pole teček s pohledem na riziko a na šance;
  všechny míry s dosazením a větami o správném čtení.
- Vliv rizika v referenční skupině: graf tří čar (stejný rozdíl rizik,
  stejný poměr rizik, stejný poměr šancí) na běžné stupnici rizika 0–1,
  tabulka jejich hodnot a v zadání posuvníky volba míry držené pevně.
- Retrospektivní výběr: posuvník podílu zařazených osob bez jevu; poměr
  šancí se nemění, poměr podílů ano.
- Koeficient φ se znaménkem a jako součin rozdílu řádkových a sloupcových
  podílů.
- Bez nových pojmů a symbolů: bez počtu léčených (NNT), logaritmu šancí,
  intervalů poměrů a adjustace; poměr rizik a poměr šancí slovy (R69).
- Stránka uvádí citací článek, kterým je její členění inspirováno
  ([E08](../zdroje/E08-magnusson-odds-ratio.md#e08-magnusson-odds-ratio));
  text, příklady a kód jsou vlastní.

**Doklad:** 2026-11-20 autor zadal: „Nyní bych chtěl implementovat
vizualizaci k bodu 3. Rozdíl podílů, poměr rizik a poměr šancí. Myslím, že
se lze hodně inspirovat: https://rpsychologist.com/odds-ratio“. Na
doplňující otázky zvolil všechny čtyři části („Dvě skupiny osob“, „Vliv
výchozího rizika“, „Retrospektivní výběr“, „Koeficient φ“), zadání „Obojí
přepínačem“, nové pojmy „Žádné“ a citaci „Ano, citací“. Plán téhož dne
schválil. Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md#vizualizace-miry-souvislosti).

<a id="r65-upresneni-2026-11-20-nabidka"></a>

### Upřesnění 2026-11-20 — Část s vizualizacemi je v nabídce sbalená

V postranní nabídce webu je část „Interaktivní vizualizace“ ve výchozím
stavu sbalená; na stránce vizualizace zůstává rozbalená a šipkou ji lze
rozbalit kdekoli. Části „Výkladové kapitoly“ a „Literatura a přehledy“
zůstávají rozbalené. Pořadí částí ani stránek se nemění. Provedení
(`assets/sidebar-collapse.js`) popisuje
[provozní návod](../PROVOZ.md#interaktivni-vizualizace).

**Doklad:** 2026-11-20 autor při schvalování plánu vizualizace chí-kvadrát
uvedl: „protože vizualizací je už celkem dost, chtěl bych, ať je oddíl
s nimi (v osnově html verze) defaultně folded“.

<a id="r65-upresneni-2026-11-23-korelace"></a>

### Upřesnění 2026-11-23 — Vizualizace korelace v bodovém grafu

Patnáctá vizualizace podle R65, první ke kapitole 10: stránka
`quarto/viz_korelace.qmd` („Jak tvar mraku bodů souvisí s korelačním
koeficientem“, `#sec-viz-korelace`), v menu za vizualizací měr souvislosti.
Kapitola 10 na ni odkazuje dvěma bloky „Vyzkoušejte si“: na konci pododdílu
`sec-vydelime` (před rozšířením `#rozsireni-meze-r`) a na konci pododdílu
`sec-odlehle-korelace`. Částečně nahrazuje bod R71 o vizualizacích
([doplnění R71](kapitola-10.md#r71-doplneni-2026-11-23)).

- Data: úzkost a výkon 40 studentů z kapitoly 10 (výchozí), spánek
  a pozornost z kapitoly 8, Anscombův kvartet I–IV a nový náhodný výběr
  (4–1 000 bodů) z dvourozměrného normálního rozdělení.
- Posuvník a pole nastaví přesně výběrové *r* (Y se přepočítá, X, průměr
  a směrodatná odchylka Y zůstanou); pole pro $m_x$, $s_x$, $m_y$, $s_y$
  mění data posunem a změnou jednotek.
- Body lze v grafu přesouvat, přidávat a mazat myší, dotykem i klávesnicí
  (3–1 000 bodů); osy se mění jen tlačítkem nebo při změně dat.
- Přepínače: kvadranty se součiny odchylek, pravděpodobnostní elipsy 50, 80,
  95 a 99 % se skutečnými počty bodů uvnitř (výchozí vypnuto), regresní
  přímka a rezidua (výchozí vypnuto), Vennův diagram *r*² (výchozí zapnuto).
- Přehled s dosazením: průměry, směrodatné odchylky, kovariance, Pearsonovo
  *r*, Spearmanův korelační koeficient, test nulové korelace, Fisherův 95%
  interval, *r*², při zapnutí rovnice přímky a součet čtverců reziduí.
- Pod hlavním grafem trvale bodový graf pořadí a graf spojnic (bez
  přepínačů, jen ke čtení).
- Nové termíny jen ve vizualizaci: regresní přímka, reziduum, koeficient
  determinace, pravděpodobnostní elipsa; značky $\hat{y}$, $b_0$, $b_1$
  a $r^2$ ([slovník](../SLOVNIK.md#vizualizace-korelace)). Stránka je
  vysvětluje v oddílu „Pojmy, které kapitola 10 nevykládá“; kapitoly je
  nepředpokládají.
- Stránka cituje aplikaci, kterou je inspirována (Magnusson, 2026, verze 0.8.0,
  [E09](../zdroje/E09-magnusson-correlation.md#e09-magnusson-correlation));
  text, příklady a kód jsou vlastní.

**Doklad:** 2026-11-23 autor zadal: „Bylo by možné replikovat tuto
interaktivní vizualizaci korelací […] https://rpsychologist.com/correlation
Se sliderem pro hodnotu korelace, nastavením počtu bodů, možností interaktivně
přidat bod, vymazat bod nebo pohnout bodem. Také by mohl být jednoduchý
numerický input pro průměry a směrodatné odchylky obou proměnných. S možností
zapnout/vypnout zobrazení regresní přímky, reziduí a pravděpodobnostních elips
(50%, 80%, 95%, 99%)“. Na doplňující otázky zvolil u regrese „Zahrnout,
výchozí vypnuto“, u Vennova diagramu „Zařadit s vysvětlením“ a doplňky
„Spearmanův r_s vedle r“, „Kvadranty a součiny“, „Předvolby z kapitoly“
a „Fisherův interval pro r“. Během přípravy plánu doplnil: „Jako odvozené
grafy bych přidal i slope chart“ a „A bodový graf po pořadové transformaci“.
K plánu připomněl: „Bodový graf pořadí a Graf spojnic (slope chart) bych
nebral jako přepínače, ale zobrazil bych je někde pod hlavním bodovým.
Pravděpodobnostní elipsy bych defaultně vypnul.“ a určil citaci „Magnusson,
K. (2026). Interpreting correlations: An interactive visualization (Version
0.8.0) [Web App]. R Psychologist. https://rpsychologist.com/correlation/“.
Upravený plán včetně uvedených termínů a značení schválil téhož dne.
Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md#vizualizace-korelace).

<a id="r65-upresneni-2026-11-23-korelace-upravy"></a>

**Úpravy před sloučením (2026-11-23):** před sloučením PR autor požádal:
„grafy by měly být na celou šířku stránky, nikoli vedle sebe, takže vennův
diagram bych umístil až pod samotný bodový graf; podobně graf spojnic bych
umístil až pod bodový graf pořadí. Ideální by bylo, kdyby u bodových grafů
rozpětí osy X odpovídalo rozpětí osy Y (1 : 1). […] přidat bod a odebrat bod
by bylo nejlepší dělat jen kliknutím do grafu; nejlepší by byl přepínač toho,
co bude v grafu dělat myš […] U 95% CI bych nejprve ukázal i směrodatnou
chybu z_r a interval před transformací.“ Na doplňující otázky zvolil
„Čtvercový graf“ (rozsah každé osy podle jejích dat) a „Odstranit formulář“.
K plánu doplnil: „Ještě bych doplnil přepínač (stačí jeden společný) pro
zobrazení čar délky (zeleně) + šířky (oranžově) elipsy, které by odpovídaly
první a druhé hlavní komponentě; zatím není třeba ale tyto pojmy zavádět, ale
jen to nějak srozumitelně popsat opisem.“ Upravený plán schválil téhož dne.
Rozsah po úpravách:

- hlavní graf a graf pořadí jsou čtvercové a jdou přes celou šířku obsahu;
  Vennův diagram je pod hlavním grafem, graf spojnic pod grafem pořadí;
- osy hlavního grafu sahají od průměrů na obě strany o stejný počet
  směrodatných odchylek své proměnné, takže graf je čtvercový i v *z*-skórech;
- přepínač „Co dělá myš v grafu“ (přesune bod tažením / přidá bod kliknutím /
  odstraní bod kliknutím) přímo nad grafem; formulář pro nový bod odstraněn,
  pod grafem řádek se souřadnicemi ukazatele;
- přepínač „délka a šířka elipsy“ (výchozí vypnuto): zelená a oranžová úsečka
  podél hlavních os elipsy v *z*-skórech, konce na elipse 99 %, popsané opisem
  bez termínu hlavní komponenta;
- interval pro ρ uvádí $z_r$, směrodatnou chybu $1/\sqrt{n-3}$ a meze na
  stupnici $z_r$ před převodem zpět.

<a id="r65-upresneni-2026-11-25-interval-podilu"></a>

### Upřesnění 2026-11-25 — Vizualizace Waldova a Wilsonova intervalu pro podíl

Šestnáctá vizualizace podle R65, třetí ke kapitole 9: stránka
`quarto/viz_interval_podilu.qmd` („Proč odhadujeme podíl Wilsonovým
intervalem“, `#sec-viz-interval-podilu`), v menu za vizualizací dvou
intervalů a před vizualizací chí-kvadrát (pořadí podle výkladu kapitoly 9).
Kapitola 9 na ni odkazuje blokem „Vyzkoušejte si“ na konci pododdílu
`sec-wilson`, za věcnou interpretací a před rozšířením
`#rozsireni-wilson-odvozeni`. Realizuje námět z návrhu 2026-11-20, který byl
do té doby v [plánu pokračování](../kapitoly/plan-pokracovani.md#plan-vizualizace)
veden jako neschválený.

- Ovládání: počet úspěchů *k* (0 až *n*), počet pokusů *n* (1–200), posuvník
  hladiny spolehlivosti 50–99 % po 1 %; předvolby 10 z 20, 0 z 15, 1 z 25
  a 40 z 80.
- Oba intervaly nad sebou na ose π s výpočtem a upozorněním na nulovou šířku
  a meze mimo 0–1.
- Interaktivní obdoba obrázku `fig-wilson-odvozeni`: obě strany nerovnice
  s průsečíky v mezích Wilsonova intervalu; přepínač vodorovné meze Waldova
  intervalu $z^2p(1-p)/n$.
- Přesné pokrytí obou intervalů jako funkce π (binomické součty, bez
  simulace) se slibovanou hladinou, přiblížením, průměrným a nejnižším
  pokrytím a podílem hodnot π pod hladinou; pravděpodobnost, že Waldův
  interval zasáhne mimo 0–1 nebo má nulovou šířku.
- Rozbor „Proč pokrytí kolísá“: pro vybrané π sloupce *P*(*X* = *k*) se
  zvýrazněnými počty, jejichž interval π obsahuje, a pokrytí jako jejich součet.
- Vzorce listu `Interval_podilu` s výsledky.
- Bez nových pojmů a symbolů; *k* a *P*(*X* = *k*) podle kapitoly 5.

**Doklad:** 2026-11-25 autor zadal: „Myslím, že ke kapitole 9 bych přidal
ještě jednu vizualizaci: Waldův a Wilsonův interval pro podíl
(`viz_interval_podilu`) […] Ovládání: počet úspěchů, n a hladina
spolehlivosti. Zobrazení: oba intervaly nad sebou a pod nimi přesně spočítané
pokrytí jako funkce π pro zvolené n.“ Na doplňující otázky odpověděl u hladiny
„Myslím, že by nejlepší byl slider s kroky po 1 % a rozmezím 50–99%“, zvolil
všechny čtyři doplňky („Proč pokrytí kmitá“, „Wald mimo 0–1 / nulová šířka“,
„Vzorce českého Excelu“, „Předvolby příkladů“) a rozsah *n* „1–200“.
K plánu doplnil: „Do vizualizace bych zahrnul i graf podobný Obrázek 9.3,
akorát interaktivní samozřejmě.“ Upravený plán včetně přepínače meze Waldova
intervalu schválil téhož dne. Realizaci a ověření eviduje
[autorská historie](../../quarto/README.md#vizualizace-interval-podilu).

<a id="r87-statisticke-aplikace"></a>

## R87 — Část „Statistické aplikace“ a pilotní test jednoho podílu

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r87-statisticke-aplikace). Původní záznam dohody:*

**Stav:** schváleno 2026-11-25. **Rozsah:** webová učebnice; nová část knihy,
stránka `quarto/app_jeden_podil.qmd` a odkazy na ni z kapitol 6 a 9. Netýká se
PDF ani balíčku tutora; odkazy na aplikace tam vedou na web.

**Volba:**

- Kniha má část „Statistické aplikace“ mezi „Interaktivními vizualizacemi“
  a „Literaturou a přehledy“. V postranní nabídce webu je ve výchozím stavu
  sbalená stejně jako vizualizace a otevřená na vlastních stránkách.
- Aplikace je samostatná nečíslovaná stránka `quarto/app_<tema>.qmd` s ID
  `#sec-app-<tema>`. Počítá probrané postupy pro data zadaná studentem
  a stručně shrnuje jejich princip, předpoklady a vzorce s odkazy do kapitol.
  Výstupem jsou tabulky s dosazením, grafy, interval spolehlivosti, velikost
  účinku v původních jednotkách, kontrola předpokladů, slovní interpretace
  a vzorce českého Excelu. Výklad kapitol obstojí bez ní; kapitola na ni
  odkazuje blokem „Spočítejte si: …“.
- Výpočty jsou ve sdíleném modulu v `assets/stat/`, ověřeném proti R;
  technika, ovládání a kontroly jako u vizualizací ([R65](#r65-interaktivni-vizualizace)).
  Každá další aplikace se schvaluje samostatně.
- **Pilot: test jednoho podílu.** Vstupy jsou jen: název proměnné, názvy
  a četnosti dvou kategorií, volba kategorie počítané jako úspěch,
  testovaná hodnota π₀, typ alternativní hypotézy a hladina významnosti α.
  *n* a *k* aplikace odvozuje; nulovou hypotézu vypíše jako negaci zvolené
  alternativy. Popisky proměnné a obou kategorií se propisují do tabulek,
  grafů, hypotéz i interpretace.
- Aplikace počítá vedle sebe skórový test a přesný binomický test. Oboustranná
  přesná *p*-hodnota se počítá pravidlem funkce `binom.test` v R (součet
  pravděpodobností výsledků nejvýše tak pravděpodobných jako pozorovaný);
  stránka vysvětlí rozdíl od zdvojení menší jednostranné *p*-hodnoty, kterým
  kapitola 9 počítá McNemarův a znaménkový test při 0,5.
- Interval je Wilsonův. U oboustranné alternativy oboustranný se spolehlivostí
  1 − α; u jednostranné si student vybere oboustranný interval se spolehlivostí
  1 − 2α (výchozí), nebo jednostranný interval se spolehlivostí 1 − α
  ([R75](kapitola-07.md#r75-oboustranny-jednostranny-interval)).
- Mimo rozsah pilotu: více než dvě kategorie, jiné intervaly pro podíl,
  Cohenovo *h* a vkládání hrubých dat po řádcích.

**Důvod:** studenti mají mít možnost spočítat probrané testy pro vlastní data
včetně postupů, které Excel nezvládne jednoduše, a vidět u výsledku jeho
výpočet, předpoklady a interpretaci. Pilot na jednom testu ověří podobu
stránky před dalšími aplikacemi.

**Doklad:** autor 2026-11-18 navrhl doplnit „základní statistické testy, které
by se chovaly jako aplikace“, se vstupem z hrubých dat nebo deskriptivních
statistik a výstupy s tabulkami, grafy, velikostí účinku s intervalem
a diagnostickými grafy. 2026-11-25 zadal: „Ok, nejprve by jako zkoušku vytvořil
stránku s testem jednoho podílu.“ Ke vstupům postupně uvedl: „Asi bych po
zvážení dal jako input počty jednotlivých kategorií a to, která z nich se má
považovat za "úspěch"“; „Smysluplnější bude vybírat typ alternativní hypotézy,
protože H0 je jednoduše jejich negací.“; „Dal bych jako input i název (popisek)
proměnné, aby se zobrazovalo ve výstupech včetně grafů“; „Taky popisky úrovní
bych přebíral ze vstupů“. Na otázky zvolil „Vždy přesně 2“ kategorie, pro
oboustranný přesný test „Pravidlo jako v R“, k intervalu odpověděl „Při
jednostranné bych dal na výběr i druh intervalu, buďto jednostranný a úrovní
spolehlivosti 1 - alfa, nebo oboustranný s úrovní spolehlivosti 1 - 2alfa
(defaultně)“ a k umístění „Do nové části "Statistické aplikace", která bude
defaultně folded“. Plán s hladinou významnosti α jako vstupem (místo původně
zmíněné hladiny spolehlivosti) a s odkazem „Spočítejte si: …“ schválil
téhož dne. Realizaci eviduje
[autorská historie](../../quarto/README.md#aplikace-jeden-podil).

<a id="r87-upresneni-2026-11-25"></a>

### Upřesnění 2026-11-25: bez Excelu, výchozí stav a barvy tabulky výsledků

**Stav:** schváleno 2026-11-25 po prohlídce pilotu. **Rozsah:** všechny
statistické aplikace; výchozí stav se týká testu jednoho podílu.

- Statistické aplikace **neuvádějí výpočet v českém Excelu**; nahrazuje
  odpovídající část původní volby (výstupy a pilot). Excel zůstává
  v kapitolách a vizualizacích podle dosavadních pravidel.
- Test jednoho podílu se otevírá s testovanou hodnotou **π₀ = 0,50**
  a **oboustrannou alternativou** *H*₁: π ≠ π₀, s daty z cvičení 8 kapitoly 6
  (7 správných a 1 špatná odpověď), hladinou 0,05 a bez stisknuté předvolby.
  Předvolby z kapitol nastavují své vlastní hodnoty.
- V tabulce výsledků aplikace mají řádky s nadpisy skupin (například Data,
  Skórový test) slabě šedé podbarvení a záhlaví tabulky tmavé pozadí v barvě
  textu s bílým písmem. Jde o výjimku z pravidla tabulek bez podbarvení
  ([sazba tabulek](../../AGENTS.md#sazba-tabulek)) jen pro tabulky výsledků
  aplikací; linky se nemění.

**Doklad:** autor po prohlídce stránky napsal: „Myslím, že sekce "Výpočet
v českém Excelu" není u Statistických aplikací nutná. Defaultní testovaná
hodnota pí0 by měla být 0,50, protože ta je nejčastěji používaná. Podobně by
defaultní alternativní hypotéza měla být oboustranná, H1: π ≠ π0. Pro lepší
orientaci v tabulce s výsledky bych podsekce tabulky, tedy řádky s nadpisem
Data, Skórový test, Přesný binomický test a Odhad populačního podílu
vybarvil (dal bych jim slabě šedý background). U samotného záhlaví tabulky
(Ukazatel Výsledek Výpočet s dosazením) bych nastavil backgroud stejnou
barvou, jako je nyní text, a barvu textu bych dal bílou.“ Na otázku
po výchozích datech zvolil „Rozpoznávání číslic 7 z 8“.

<a id="r87-upresneni-2026-11-26"></a>

### Upřesnění 2026-11-26: aplikace Test dvou podílů

**Stav:** schváleno 2026-11-26 (plán aplikace). **Rozsah:** stránka
`quarto/app_dva_podily.qmd`, modul `assets/stat/dva-podily.js` a odkaz
z kapitoly 9; obecná pravidla R87 a jeho upřesnění z 2026-11-25 platí beze změny.

- **Vstup:** tabulka 2 × 2 s popisky (název proměnné skupiny a výsledku, názvy
  dvou skupin a dvou kategorií, čtyři četnosti), volba sledované kategorie,
  prohození skupin (druhá skupina je referenční skupinou poměrů), alternativa
  ≠ / > / < a α; u jednostranné alternativy volba intervalu jako u pilotu.
- **Testovaný rozdíl δ₀ v nulové hypotéze** (*H*₀: π₁ − π₂ = δ₀, výchozí 0),
  se symbolem δ₀ ve stojatém řezu (nový řádek přehledu značení). Pro δ₀ ≠ 0
  aplikace počítá skórový test se směrodatnou chybou z podílů odhadnutých
  za platnosti *H*₀ (maximální věrohodnost), který pro δ₀ = 0 splývá s testem
  se společným podílem z kapitoly 9; jde o postup nad rámec výkladu se stručným
  vysvětlením na stránce. Fisherův test se počítá jen pro δ₀ = 0. Součástí je
  předvolba noninferiority s odkazem na rozšíření kapitoly 7.
- **Míry:** rozdíl podílů s Newcombovým intervalem, poměr rizik a poměr šancí
  s logaritmickými intervaly (nepovinné rozšíření kapitoly 9) a φ.
- **Přesný test a interval podle Agrestiho a Mina (2001)** jako nepovinný
  doplněk pro malé výběry: přesný nepodmíněný test se skórovou statistikou
  a interval z jeho obrácení (u jednostranné alternativy obrácením jednostranného testu), počítané, pokud má každá skupina nejvýše 200 případů. Hlavními
  výsledky zůstávají postupy kapitoly 9.

**Doklad:** autor 2026-11-25 zadal „Teď udělej aplikaci pro test dvou podílů“
a na otázky zvolil „Tabulka 2 × 2 s popisky“, jednostranné alternativy „Ano,
jako u pilotu“ a míry „Rozdíl, poměry s intervaly, φ“. 2026-11-26 se zeptal:
„Co kdybychom přidali i test rozdílu mezi podíly?“ a upřesnil volbou
„Nenulový rozdíl δ₀ v H₀“; pro značení zvolil „δ₀“ a k předvolbě „Ano,
noninferiorita“. K plánu doplnil: „Ve zdrojích je i agresti_min_2001.pdf,
který ukazuje asi nejpřesnější CI pro rozdíl mezi dvěma podíly při malých
výběrech.“ a na otázku po roli intervalu zvolil „Doplněk pro malé výběry“.
Upravený plán schválil téhož dne. Realizaci eviduje
[autorská historie](../../quarto/README.md#aplikace-dva-podily).

<a id="r87-upresneni-2026-11-27"></a>

### Upřesnění 2026-11-27: aplikace Test jednoho průměru

**Stav:** schváleno 2026-11-27 (plán aplikace). **Rozsah:** stránka
`quarto/app_jeden_prumer.qmd`, moduly `assets/stat/prumer.js`, `assets/stat/normalita.js`
a `assets/stat/qq-ts-gamma.js`, odkazy „Spočítejte si“ z kapitol 6, 7 a 8, hesla a značky
uvedené níže. Obecná pravidla R87 a jeho upřesnění z 2026-11-25 platí beze změny; kapitoly
se kromě odkazů nemění.

- **Uspořádání a vstup:** jeden výběr nebo párová data; jednotlivé hodnoty (textové pole,
  u párových dat dvojice na řádku, neúplné dvojice se vyřadí) nebo souhrny ($m$, $s$ nebo σ, $n$;
  u párových dat $m_D$, $s_D$, $n$ a nepovinně $s_1$, $s_2$). Popisky proměnné, jednotky a měření
  se propisují do výstupů. U párových dat volba výchozího měření a prohození pořadí měření.
- **Testy a intervaly:** *z*-test (σ známá, jen jeden výběr) a jednovýběrový či párový *t*-test,
  μ₀, alternativa ≠ / > / <, α; u jednostranné alternativy volba intervalu jako u pilotu.
  Volitelný test ekvivalence (TOST) se dvěma samostatně zadanými hranicemi a intervalem 1 − 2α.
- **Velikost účinku:** rozdíl v původních jednotkách s intervalem; jednovýběrové Cohenovo
  $d=(m-\mathrm{μ}_0)/s$ (u *z*-testu $/\mathrm{σ}$) s **přesným** intervalem z necentrálního
  *t*-rozdělení (u *z*-testu přepočtený interval průměru) a Hedgesovo *g* podle kapitoly 8.
  U párových dat tři varianty: *d* se směrodatnou odchylkou výchozího měření a *d*
  s $\sqrt{(s_1^2+s_2^2)/2}$, obě s přibližným intervalem a korekcí zkreslení podle Bonetta
  (2015, rovnice 9, 11, 13 a 15), a $d_z$ s přesným intervalem. Kapitola 8 se kvůli Bonettovi
  nemění; stránka uvede rozdíl proti intervalu podle Algina a Keselmana.
- **Diagnostika normality** (jen z jednotlivých hodnot, u párových dat z rozdílů): histogram
  s přepínači křivky normálního rozdělení a jádrového odhadu hustoty; raincloud graf
  s odhadem hustoty, krabicovým grafem, body a průměrem s intervalem (do 50 hodnot vystředěný
  bodový graf, nad 50 jitter s průhledností bodů); normální Q–Q graf podle kapitoly 4
  s volbou tradiční / detrendovaný a se simultánním 95% pásem podle qqplotr (tail-sensitive,
  výchozí, nebo KS; parametry $m$ a $s$); korigovaná šikmost a exces jako SKEW a KURT;
  Shapirův–Wilkův test jako `shapiro.test` v R.
- **Výchozí stav:** data zkouškové úzkosti ze cvičení 7 kapitoly 7, μ₀ = 20, oboustranně,
  α = 0,05, bez stisknuté předvolby.
- **Nová hesla jen pro aplikaci:** necentrální *t*-rozdělení, parametr necentrality, jádrový
  odhad hustoty, raincloud graf, detrendovaný Q–Q graf, simultánní pás spolehlivosti,
  Shapirův–Wilkův test ([registr](../SLOVNIK.md#aplikace-jeden-prumer)). **Značky:** jednovýběrové
  *d* v řádku [*d*](../../quarto/znaceni.qmd), $d_z$ a *W*; populační standardizovaný rozdíl
  bez nové značky (δ zůstává pro δ₀).

**Doklad:** autor 2026-11-27 zadal: „Jako další test bych do učebnice zařadil test jednoho
průměru (jednovýběrový t-test a z-test) společně s výpočtem intervalu spolehlivosti
a Cohenovým d + CI.“ Na otázky zvolil vstup „Hodnoty i souhrny“, interval pro *d* „Jen
přesný“, rozsah „Test ekvivalence (TOST), Párová data, Hedgesova korekce g“, hranice „Dvě
hranice“ a výchozí data „Úzkost (kap. 7, cv. 7)“. K párovému *d* se zeptal: „A co zdroj
"bonett-2015.pdf"?“ a po shrnutí zdroje zvolil „Tři varianty“ a kapitolu 8 „Ne, jen
aplikace“. Doplnil: „Taky bych přidal diagnostiku normality“ a k jejímu obsahu: „Všechno:
grafy, míry tvaru i Shapiro-Wilkův test. Myslím, že v histogramu by měl být přepínač pro
zapnutí křivky normálního rozdělení i křivky empirické hustoty. Pro znázornění rozdělení
bych přidal i raincloud plot s body a bodovým odhadem průměru + CI a také s boxplotem
a křivkou hustoty. U malých souborů by body mohly být obyčejný dotplot vycentrovaný na
střed a větších souborů jitter.“, dále „jitter s transparencí bodů“ a „Je možné u Q-Q grafů
replikovat simlutánní confidence bands, které produkuje qqplotr? a dát jako volbu, jestli
uživatel chce tradiční Q-Q graf, nebo detrendovaný?“ Plán s těmito volbami a s novými hesly
schválil téhož dne. Realizaci eviduje
[autorská historie](../../quarto/README.md#aplikace-jeden-prumer).

<a id="r87-doplneni-2026-11-27-pas"></a>

#### Doplnění 2026-11-27: výpočet pásu tail-sensitive

**Stav:** schváleno 2026-11-27 po realizaci. Schválený plán počítal pás tail-sensitive jako
qqplotr se zadanými parametry (`mu = m`, `sigma = s`). Při parametrech odhadnutých z týchž dat
by takový pás zachytil normální data s pravděpodobností téměř 1, ne 0,95. Pás se proto počítá
simulací standardizovaných normálních výběrů jako ve výchozím nastavení qqplotr, ale s průměrem
a směrodatnou odchylkou místo robustních odhadů Qn, aby ležel kolem přímky $m+s z$
z kapitoly 4; simultánní pokrytí je 0,944–0,955. Pás KS zůstává přesně podle qqplotr.

**Doklad:** autor na otázku „Ponechat pás tail-sensitive se simulací zohledňující odhad m a s?“
odpověděl „Ano, ponechat“. Realizaci eviduje
[autorská historie](../../quarto/README.md#aplikace-jeden-prumer).
