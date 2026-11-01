# Dohody k porovnání dvou průměrů

[Registr rozhodnutí a aktuální platnost](../ROZHODNUTI.md) · [Pravidla evidence](../../AGENTS.md#evidence-rozhodnuti)

Níže jsou zachovány původní záznamy schválených voleb, jejich důvody a doklady. Data, rozsah a formulace se vztahují k uvedeným dohodám; záznamy mohou obsahovat později nahrazené části nebo již provedené úkoly. Aktuální platnost a hlavní místo údržby určuje řádek v registru. Staré seznamy se při běžné aktualizaci slovníku, obsahu či pracovního postupu znovu nesynchronizují; nová schválená změna dostane vlastní datovaný doklad.

<a id="r59-rozsah-kapitoly-8"></a>

## R59 — Rozsah, pořadí a zásady výkladu kapitoly 8

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r59-rozsah-kapitoly-8). Původní záznam dohody:*

**Stav:** schváleno 2026-11-01. **Rozsah:** kapitola 8 „Porovnání dvou průměrů: párová data a nezávislé skupiny“ (pracovní název), její cvičení, sešit a navazující přehledy. Skutečný obsah a případné odchylky bude evidovat karta kapitoly 8.

**Vymezení**

- Párová data a dvě nezávislé skupiny v jedné kapitole; interval pro průměrný rozdíl a pro rozdíl dvou průměrů; Cohenovo d; ekvivalence dvou skupin; porovnání změn ve dvou skupinách.
- **Mimo kapitolu:** ANOVA a více skupin, korekce pro více testů, neparametrické a pořadové testy, bootstrap, ořezané průměry a další robustní alternativy, interval pro d, plánování velikosti výběru a výpočet síly, pokročilé postupy pro částečně párovaná data, korelační koeficient (vztah obou měření jen slovně).
- **Nepovinná rozšíření:** srovnání standardizací u párových dat a Hedgesova korekce; Cohenova pásma (podle [R56](kapitola-06.md#r56-p-hodnota-cohen)); odvození Welchových stupňů volnosti; *p*-hodnoty TOST pro dvě skupiny.

**Členění (jedenáct oddílů):** od jedné skupiny ke dvěma; párová data a rozdíl u každého člověka; kdy párování zpřesňuje odhad a co neřeší; jak kolísá rozdíl dvou nezávislých průměrů; klasický t-test se společným odhadem rozptylu; Welchova varianta a srovnání obou postupů; předpoklady a odolnost; velikost rozdílu v původních jednotkách a Cohenovo d; dva intervaly vedle sebe nejsou interval rozdílu; změna ve dvou skupinách; ekvivalence dvou podmínek, volba postupu a sdělení výsledků. Pořadí posledních dvou oddílů lze při psaní prohodit.

**Příklady**

- Průběžný příklad spánku a pozornosti (autorský model kapitol 4, 6 a 7) ve čtyřech verzích: tíž studenti po krátkém a běžném spánku; dvě skupiny studentů; online a papírová verze testu s náhodným přiřazením (ekvivalence, hranice ±3 body jako v kapitole 7); změna pozornosti v intervenční a kontrolní skupině.
- Návrat k parkovací studii (Howell, s. 86; kapitola 6) bez známé σ: při obou výběrových směrodatných odchylkách 14,6 s t ≈ 3,332 a 95% interval přibližně (2,81; 10,95) s.
- Anorexie (Everitt podle Howella, s. 198–201) jako krátký příklad se skutečnými daty, v kilogramech s uvedením převodu a výpočtem z nezaokrouhlených převedených hodnot.
- Hrozba stereotypu (Howellova konstruovaná data, s. 215–217) nejvýše ve cvičení.

**Zásady výkladu**

- Přínos párování závisí na vztahu obou měření. Formulace cíle: vysvětlit, za jakých okolností párování zpřesňuje odhad: jestliže se stabilní rozdíly mezi lidmi při odečtení měření z velké části odstraní, mohou individuální rozdíly kolísat podstatně méně než samotné hodnoty. Zachované pořadí osob to samo nezaručuje (kontrastní příklad trojnásobných druhých hodnot). Širší interval při chybné analýze párových dat jako nezávislých se prezentuje jako výsledek konkrétního příkladu.
- Párové uspořádání se dělí na opakované měření týchž lidí a dvojice různých osob.
- Chybějící párové údaje povinně v základní podobě: zachovat ID, vybírat úplné dvojice společně, správně určit jejich počet, neodstraňovat prázdné buňky ve dvou sloupcích samostatně a nespojovat je pak podle řádků; vyřazení neúplných dvojic může změnit složení analyzovaného souboru.
- Příklad anorexie: párový test těchto sedmnácti dívek posuzuje průměrnou změnu. Sám neporovnává změnu se změnou v kontrolní skupině a sám nestačí k připsání změny terapii. Celá Howellem popisovaná studie se neoznačuje za studii bez kontrolní skupiny (Howell, s. 200).
- U nezávislých skupin nejprve úplný klasický postup se společným odhadem rozptylu, potom Welchova varianta a porovnání. Pořadí výkladu neurčuje automaticky nejlepší praktickou volbu. Předběžný test shody rozptylů se nepoužívá jako „vrátný“. Při stejných velikostech skupin vychází oběma postupům stejné *t*, ale při rozdílných rozptylech se mohou lišit stupně volnosti, *p*-hodnoty a intervaly.
- Cohenovo d povinně pro nezávislé skupiny. U párových dat povinně jen to, že volba jmenovatele mění význam koeficientu a je nutné ji uvést; jediný neupřesněný „vzorec pro párové Cohenovo d“ se neuvádí (zdroje se liší: Howell výchozí směrodatnou odchylkou, Cumming kombinací variability obou měření).
- Intervaly: u nezávislých skupin se sčítají rozptyly odhadů, šířku intervalu však ovlivňují i kritické hodnoty a stupně volnosti, proto se neuvádí obecný jednoduchý vztah šířek. U párových dat samostatné intervaly obou podmínek nestačí k určení intervalu párového rozdílu, protože chybí informace o tom, jak spolu hodnoty uvnitř dvojic souvisejí. Orientační pravidlo překryvu se do povinného výkladu nezařazuje; stačí ukázat překryv při průkazném rozdílu a vysvětlit, proč počítáme interval rozdílu.
- Porovnání změn ve dvou skupinách jako řešený příklad: vytvořit změnu u každé osoby a potom porovnat změny mezi skupinami. Formulace místo hesla o „rozdílu významností“: statisticky významná změna v jedné skupině a nevýznamná změna ve druhé samy nedokládají, že se změny mezi skupinami liší; rozdíl změn musíme posoudit přímo (Gelman a Stern, 2006).
- Sešit musí zajistit soulad Welchova testu a intervalu s neceločíselnými stupni volnosti: T.INV, T.INV.2T a T.DIST.2T je zkracují, T.TEST typu 3 je využívá.

**Zdroje:** Howell, 8. vyd. (2013), §7.4–7.6, s. 197–220; Cumming a Calin-Jageman (2024), zejména s. 176–178 a 213–215; Wilcox (2017), §7.1, §7.3 a §8.1 jako kontrolní opora (robustní alternativy se nepřebírají); starší přednášky P08 (sn. 29–36, sn. 30 s opravou) a P09 (sn. 11–26 a 41–48, chybný interval sn. 25) a úlohy C08 (X11_18–21) jako priority autora a náměty. Podrobnosti v [zdrojových kartách](../ZDROJE.md) a [historii ověřování](../zdroje/HISTORIE.md#priprava-08-20261101).

**Důvod:** kapitola uzavírá témata, která [R44](kapitola-07.md#r44-rozsah-kapitoly-7) výslovně odložilo (párový t-test, t-test pro dva výběry, překrývání intervalů dvou skupin), a sleduje Howellovo pořadí.

**Nahrazuje:** stav „po kapitole 7 není schválen žádný plán“ v [plánu pokračování](../kapitoly/plan-pokracovani.md#plan-dalsi-kapitoly) ve znění z 2026-10-17.

**Doklad:** autor na otázku „Jaký by měl být obsah kapitoly 8?“ vrátil první návrh s písemnými připomínkami, mimo jiné: „Zmírnil bych tvrzení, že párování zpřesňuje odhad.“; „Nadpis bych změnil na ‚Kdy párování zpřesňuje odhad — a co neřeší‘.“; „Orientační pravidlo překryvu bych do povinného výkladu nezařazoval.“; „nejprve úplný klasický postup se společným rozptylem, potom Welchova varianta a jejich porovnání“; „Pokud příklad použijeme, doporučuji kilogramy“; „Hrozbu stereotypu bych ponechal spíše pro cvičení nebo vynechal.“; „Základní práci s chybějícími párovými údaji bych přesunul do povinné části.“; „Podle naší dohody bych povinně vyložil Cohenovo d pro nezávislé skupiny.“ Druhou verzi doplnil poznámkami ke zdrojům včetně věty „Proto zde nemá být jediný neupřesněný ‚vzorec pro párové Cohenovo d‘.“ a třetí verzi schválil 2026-11-01. Záznam „Kapitola 8: dohoda o obsahu“ v [historii](../../quarto/README.md#dohoda-kapitola-08).

<a id="r60-znaceni-kapitoly-8"></a>

## R60 — Značení kapitoly 8

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r60-znaceni-kapitoly-8). Původní záznam dohody:*

**Stav:** schváleno 2026-11-01. **Rozsah:** kapitola 8, přehled značení a další použití.

- Dvě skupiny: n₁, n₂, s₁, s₂ jako rozšíření [R29](kapitola-06.md#r29-znaceni-kapitoly-6) (μ₁, μ₂, m₁, m₂ již platí).
- Párová data: průměr a směrodatná odchylka rozdílů $m_D$ a $s_D$, populační průměr rozdílů $\mathrm{μ}_D$ (index D = rozdíl); rozdíl dvojice v tabulkách slovy. Malé *d* se pro rozdíly nepoužívá, aby nedošlo k záměně s Cohenovým d; nejde o matematický zákaz.
- Odhad směrodatné chyby rozdílu dvou průměrů $s_{m_1-m_2}$ (obdoba $s_m$ podle R29).
- Společná směrodatná odchylka $s_p$ (alternativa $s_{\text{spol}}$ jen v přehledu).
- *d* pro Cohenovo d (dosud jen v nepovinném bloku podle R29); stupně volnosti Welchova testu se ve výkladu vypisují slovy, *v* se používá v indexu kvantilu podle [R45](kapitola-07.md#r45-znaceni-kapitoly-7).

**Doklad:** značení bylo součástí schváleného plánu; autor k němu napsal: „Ve značení bych dal přednost tvému návrhu před svým. $m_D$, $s_D$ a $\mathrm{μ}_D$ jsou pro tento výklad vhodnější“ a „Jen bych nepoužíval kategorickou větu ‚malé d nelze použít‘. Nejde o matematický zákaz, ale o rozumné rozhodnutí zabránit záměně s Cohenovým d.“

<a id="r61-terminologie-kapitoly-8"></a>

## R61 — Terminologie kapitoly 8

*[Aktuální platnost a hlavní místo pravidla](../ROZHODNUTI.md#r61-terminologie-kapitoly-8). Původní záznam dohody:*

**Stav:** schváleno 2026-11-01 jako terminologická tabulka plánu. **Rozsah:** kapitola 8, slovníček, přehledy a další použití. Úplný seznam s anglickými ekvivalenty a alternativami bude v [registru](../SLOVNIK.md) po zapsání hesel kapitoly 8.

- **Párová data, párové uspořádání** (*paired data/design*); alternativa závislé výběry. *Opakované měření* (tíž lidé) a *dvojice různých osob* (spárované dvojice, partneři) jsou užší případy, ne synonyma.
- **Rozdílové skóre** (*difference score*); skóre změny (*gain score*) jen u měření před a po.
- **Párový t-test** (*paired-samples t-test*); alternativa t-test pro závislé výběry.
- **Nezávislé skupiny / výběry** (*independent samples*); **t-test pro dva nezávislé výběry** (*independent-samples t-test*), alternativa dvouvýběrový t-test.
- **Klasický (Studentův) t-test se společným odhadem rozptylu** (*Student's pooled t-test*); **Welchův t-test** (*Welch's t-test*).
- **Společný odhad rozptylu** (*pooled variance estimate*); **shoda rozptylů** (*homogeneity of variance*), alternativa homogenita rozptylů.
- **Výběrové rozdělení rozdílu průměrů** a **směrodatná chyba rozdílu průměrů** (*sampling distribution / standard error of the difference between means*).
- **Cohenovo d** (*Cohen's d*) povinně pro nezávislé skupiny; standardizovaný rozdíl průměrů ([R30](kapitola-06.md#r30-terminologie-kapitoly-6)) zůstává obecným pojmem.
- **Vyvážení pořadí** a **efekt pořadí** (*counterbalancing, order effect*); **úplná a neúplná dvojice** (*complete / incomplete pair*).

**Doklad:** terminologická tabulka byla součástí plánu schváleného 2026-11-01; autor k ní doplnil: „Zachoval bych také tvé širší rozlišení párových dat, opakovaných měření a dvojic různých osob.“ Před zápisem do registru se hesla ověří proti [SLOVNIK.md](../SLOVNIK.md), zda nekolidují s dříve schválenými.
