# Mapa autorských zdrojů

Stav inventury a obsahového průzkumu: **11. října 2026**; záznamy o použití v kapitole 5 doplněny **12. října 2026**. Mapa zahrnuje všech **30 souborů** v aktuální složce `sources/` a jejích podsložkách: 11 učebnic, 5 starších přednáškových prezentací, 3 soubory úloh, 1 seminární prezentaci a 10 dalších podkladů.

Dokument slouží k výběru podkladů při plánování kapitol. Je autorskou dokumentací, není součástí studentského webu. Dohodnutý obsah a návaznosti určuje [OSNOVA.md](OSNOVA.md), platné konvence [ROZHODNUTI.md](ROZHODNUTI.md). Nabídka témat v této mapě **neznamená schválení jejich zařazení**. Howell zůstává hlavním odborným a didaktickým východiskem.

## Jak mapu číst a používat

1. V tematickém rozcestníku vyber zdroje a otevři jejich karty níže.
2. Zkontroluj aktuální soubory proti inventáři; nové a změněné podklady doplň před návrhem kapitoly.
3. Přečti konkrétní relevantní pasáže v originálech, včetně návazností, obrázků a podmínek použití. Mapa usnadňuje dohledání, nenahrazuje tento krok.
4. Při návrhu kapitoly uveď, který podklad slouží pro pořadí výkladu, vysvětlení, příklad, procvičování nebo odbornou kontrolu; připoj přesný lokátor a otevřené otázky.
5. Aktualizuj příslušnou kartu, pokud se prohloubí ověření, přibude nález nebo se změní soubor. Schválený rozsah kapitoly zapisuj do osnovy, schválené konvence do rozhodnutí; terminologické preference současně do [SLOVNIK.md](SLOVNIK.md). Překlad nalezený v podkladu není automaticky preferencí učebnice. Před převzetím ověř význam a platné heslo registru, novou volbu nejprve dohodni.

**Rozsah provedené práce.** Všechny soubory byly otevřeny a jejich obsah byl posouzen. U rozsáhlých učebnic byl zmapován obsah celé knihy a přečteny vybrané pasáže; nejde o přečtení všech několika tisíc stran ani o kontrolu všech důkazů a příkladů. Konkrétní rozsah je uveden v kartách. U kratších podkladů byly čteny texty, zadání a dostupná řešení; skeny vyžadovaly OCR. Textová extrakce ani OCR samy o sobě nejsou odborným ověřením. Obrázky prezentací byly kontrolovány z exportů PowerPointu, obrázky DOCX a XLSX také samostatně. Neproběhla úplná kontrola všech animací, vložených objektů a odkazovaného externího obsahu.

Použité označení:

- **Mapa obsahu:** ověřené názvy a umístění témat, především podle obsahu knihy; neznamená podrobné přečtení všech uvedených oddílů.
- **Prostudované pasáže:** skutečně přečtený výklad nebo zadání v uvedeném rozsahu.
- **Nález:** konkrétní rozpor či omezení zjištěné v podkladu; není to automatická oprava originálu ani nové schválené pravidlo.
- **Neověřeno:** chybějící bibliografický údaj, neprostudovaná část nebo kontrola, která nebyla provedena. Absence nálezu není potvrzení bezchybnosti.

**Lokátory.** `s.` označuje tištěnou stránku, `PDF` pořadí stránky v souboru od 1, včetně obálky a úvodu. Odkaz na rozsah otevírá jeho první stránku. Převod se ověřuje pro daný soubor; zejména u Sahuovy knihy není posun po celé knize konstantní. U prezentací se počítá fyzické pořadí snímků včetně skrytých a titulních. U DOCX používáme identifikátory úloh či názvy oddílů, protože stránkování závisí na vykreslení. U XLSX uvádíme list a buňky. Odkazy na PPTX/DOCX/XLSX otevírají soubor, nikoli spolehlivě konkrétní snímek, úlohu či buňku; rozhodující je uvedený textový lokátor.

Odkazy do `sources/` fungují pouze v místní pracovní kopii s těmito podklady. Na veřejném GitHubu cílové soubory nejsou. Originály, výřezy stran, OCR a pomocné exporty se touto mapou nezveřejňují. Bibliografické údaje níže identifikují konkrétní soubor; nenahrazují společnou bibliografii `references.bib` a citační postup podle APA 7.

## Tematický rozcestník

| Téma / plánovací otázka | Hlavní opora a srovnání | Starší výuka a úlohy | Využití a podmínky |
|---|---|---|---|
| Výzkumná otázka, populace, výběr, experiment, měření | [U01](#u01) kap. 1; [U03](#u03) kap. 2; [U04](#u04) kap. 1; [U08](#u08) kap. 2; [U11](#u11) kap. 1 | [P01](#p01) sn. 13–38; [C01](#c01) X1 | Navazuje na existující kapitolu 1; metodologii a kauzalitu nelze odvozovat pouze z typu statistiky. |
| Úrovně měření a oprávněnost interpretace | [U01](#u01) §1.3; dvojice [D05](#d05) + [D06](#d06) | [P01](#p01) sn. 27–30; [C01](#c01) X1_01–03, X1_06, X1_09 | Spor o měření představit jako argumentaci, nikoli mechanický seznam povolených testů. |
| Datová matice, kódování, chybějící hodnoty | [D01](#d01)/[D02](#d02), [D03](#d03), [D04](#d04) | [P01](#p01) sn. 32–38; [C01](#c01) X1_05, X1_07–08 | Rozlišovat obecné zásady a pravidla konkrétního programu či projektu. |
| Četnosti, histogram, hustota, klamavé grafy | [U01](#u01) kap. 2; [U03](#u03) kap. 3; [U04](#u04) kap. 2; [U11](#u11) §2.1–2.4 | [P01](#p01) sn. 39–68; [C01](#c01) X2; [C02](#c02) X2_04–10 | Návaznost na kapitolu 2; šířka intervalů, plocha sloupců, omezení rekonstrukce dat. |
| Poloha, variabilita, kvantily, boxplot | [U01](#u01) §2.6–2.12; [U06](#u06) kap. 3–4; [U05](#u05) kap. 3; [U11](#u11) §2.5–2.10 | [P02](#p02); [C02](#c02) | Existující kapitola 3; dodržet R04 a R14, nevracet starší algoritmy a značení. |
| Transformace, z/T/IQ, percentilové pořadí | [U01](#u01) §2.12, §3.2 a §3.6; [U02](#u02) kap. 3 | [P03](#p03) sn. 3–21; [P04](#p04); [C03](#c03) X3_01–07; [C04](#c04); [D10](#d10) | Rozlišit standardizaci, normalizaci a pořadí; pozor na chyby ve starých řešeních. |
| Normální model, plochy, kvantily, posouzení modelu | [U01](#u01) kap. 3; [U03](#u03) kap. 4; [U04](#u04) §4.1; [U11](#u11) §6.2–6.4 | [P03](#p03) sn. 45–59; [P04](#p04); [C03](#c03) X3_21–37; [D10](#d10) | Existující kapitola 4; konvence N(μ, σ) podle R15; rozlišit Q–Q a P–P graf. |
| Co znamená pravděpodobnost, jevy, pravidla | [U01](#u01) kap. 5; [U04](#u04) kap. 3; [U08](#u08) §9.2; [U10](#u10) kap. 3–4; [U11](#u11) kap. 3 | [P03](#p03) sn. 22–32; [P05](#p05) sn. 2–19; [C03](#c03) X3_08–20; [D08](#d08) | Existující kapitola 5 (R21–R23). Tři pojetí jsou představena jako interpretace se společnými pravidly; Dostálovo odmítnutí subjektivní pravděpodobnosti převzato nebylo. |
| Podmíněná pravděpodobnost, Bayes, základní četnosti | [U01](#u01) §5.7; [U04](#u04) §3.2; [U10](#u10) kap. 4; [D08](#d08) s. 121–129; [U11](#u11) §3.5–3.8 (s opravou s. 62) | [P05](#p05) sn. 6–13 a 24–28; [D09](#d09) s. 147–151; [D07](#d07) s. 77–78 | Vyloženo v kapitole 5: přirozené četnosti, tabulka, strom, úplná pravděpodobnost, Bayesova věta, dvě prevalence. |
| Pravděpodobnostní úsudky a statistická gramotnost | [D07](#d07), [D08](#d08), [D09](#d09) | [P01](#p01) sn. 18–21; příklady v [C03](#c03) | V kapitole 5 čtyři chyby úsudku u příslušných pravidel, citováno podle Barona a Uttsové; původní studie nebyly čteny ani aktualizovány. |
| Náhodná proměnná, diskrétní modely, očekávaná hodnota | [U01](#u01) §5.3–5.9; [U04](#u04) §3.4 a kap. 4; [U10](#u10) kap. 5–7; [U11](#u11) §5.1–5.8 | [P02](#p02) sn. 36, 45–48; [P03](#p03) sn. 33–44; [P05](#p05) sn. 14–18, 20–23 a 29–36; [C03](#c03) X3_31 | V kapitole 5: náhodná proměnná, kombinace, binomické rozdělení a normální aproximace povinně; obecná střední hodnota a variace nepovinně. Chyby P05 opraveny v textu kapitoly, originál beze změny. |
| Výběrová rozdělení, SE, CLT, intervaly | [U01](#u01) kap. 4 a 7; [U03](#u03) kap. 4–5; [U06](#u06) kap. 7; [U08](#u08) kap. 10; [U11](#u11) §7.2–7.5 | [P04](#p04) sn. 5–6 jen jako výchozí námět | Odlišit rozdělení dat a statistiky, SD a SE, interval hodnot a interval spolehlivosti. |
| Testování, velikost účinku, síla, plánování | [U01](#u01) kap. 4, 7–8; [U03](#u03) kap. 5–10; [U04](#u04) kap. 5–7; [U11](#u11) kap. 4 a 7–9 | [D07](#d07) s. 75–76 | Cumming doplňuje orientaci na odhad, přesnost a otevřenou vědu; nepřebírat bez dohody jeho pořadí místo Howella. |
| Kategoriální data, korelace a regrese | [U01](#u01) kap. 6, 9–10; [U04](#u04) kap. 6, 8–9; [U07](#u07); [U11](#u11) kap. 10–12 | Pozdější témata; v lokálních úlohách není systematická odpovídající sada | Rozsah a pořadí v tomto kurzu nejsou samotnou mapou stanoveny. |
| ANOVA, více prediktorů, meta-analýza, neparametrické a bayesovské metody | [U01](#u01) kap. 11–18; [U03](#u03) kap. 9, 14–15; [U07](#u07); [U08](#u08) kap. 14–17; [U10](#u10) části IV–V; [U11](#u11) kap. 9 (bayesovský t-test; kap. 14 pouze na webu) | Bez úplného pokrytí staršími podklady zde | Rezerva pro autora a případná další skripta; nepovažovat za povinnou náplň jednoho semestru. |

## Inventář souborů

Identifikátory karet zůstávají stabilní i při přejmenování souboru. Otisk je prvních 16 hexadecimálních znaků SHA-256 a slouží k rozpoznání změny lokální verze, nikoli jako bibliografický údaj. Po změně souboru je nutné znovu ověřit jeho lokátory.

| ID | Místní soubor | Rozsah | SHA-256, prefix |
|---|---|---|---|
| [U01](#u01) | [howell.pdf](../sources/u%C4%8Debnice/howell.pdf) | 796 stran PDF | `9cb60cbe267019d6` |
| [U02](#u02) | [aron.pdf](../sources/u%C4%8Debnice/aron.pdf) | 729 stran PDF | `97a124973c0dadaa` |
| [U03](#u03) | [cumming.pdf](../sources/u%C4%8Debnice/cumming.pdf) | 611 stran PDF | `f842db86cf20a2ed` |
| [U04](#u04) | [diez.pdf](../sources/u%C4%8Debnice/diez.pdf) | 422 stran PDF | `9fa1e268dc2ae9db` |
| [U05](#u05) | [dostal.pdf](../sources/u%C4%8Debnice/dostal.pdf) | 229 stran PDF | `1a33b5dd3f1d8374` |
| [U06](#u06) | [gravetter.pdf](../sources/u%C4%8Debnice/gravetter.pdf) | 755 stran PDF | `a6868a7af6668414` |
| [U07](#u07) | [judd.pdf](../sources/u%C4%8Debnice/judd.pdf) | 379 stran PDF | `df9f59da58078f7e` |
| [U08](#u08) | [navarro.pdf](../sources/u%C4%8Debnice/navarro.pdf) | 796 stran PDF | `a5314ddd00a2f1db` |
| [U09](#u09) | [privitera.pdf](../sources/u%C4%8Debnice/privitera.pdf) | 954 stran PDF | `c93dc75c07ef4c18` |
| [U10](#u10) | [sahu.pdf](../sources/u%C4%8Debnice/sahu.pdf) | 560 stran PDF | `6c0a39f1de739519` |
| [U11](#u11) | [russo.pdf](../sources/u%C4%8Debnice/russo.pdf) | 331 stran PDF | `8939c8698b119e74` |
| [P01](#p01) | [PSYb1170_P01_2025_-_Uvod__cetnosti.pptx](../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/PSYb1170_P01_2025_-_Uvod__cetnosti.pptx) | 69 snímků | `077197470a4b781d` |
| [P02](#p02) | [PSYb1170_P02_2026_-_Popisne_statistiky.pptx](../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/PSYb1170_P02_2026_-_Popisne_statistiky.pptx) | 53 snímků | `a241d36fb9152355` |
| [P03](#p03) | [PSYb1170_P03_2026_-_Transformace__rozdeleni_pravdedpodobnosti_.pptx](../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/PSYb1170_P03_2026_-_Transformace__rozdeleni_pravdedpodobnosti_.pptx) | 60 snímků | `c36178e0a58eb3d0` |
| [P04](#p04) | [normal_distribution.pptx](../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/normal_distribution.pptx) | 22 snímků | `e96b31993c914185` |
| [P05](#p05) | [probability.pptx](../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/probability.pptx) | 36 snímků | `3f65f85091f08242` |
| [C01](#c01) | [ulohy_tyden01_2025.docx](../sources/p%C5%99%C3%ADklady%20k%20procvi%C4%8Dov%C3%A1n%C3%AD/ulohy_tyden01_2025.docx) | DOCX | `748e3395728f4f81` |
| [C02](#c02) | [ulohy_tyden02_2026.docx](../sources/p%C5%99%C3%ADklady%20k%20procvi%C4%8Dov%C3%A1n%C3%AD/ulohy_tyden02_2026.docx) | DOCX | `eb503ae2273185eb` |
| [C03](#c03) | [ulohy_tyden03_2024.docx](../sources/p%C5%99%C3%ADklady%20k%20procvi%C4%8Dov%C3%A1n%C3%AD/ulohy_tyden03_2024.docx) | DOCX | `2dc558b65cba9540` |
| [C04](#c04) | [Seminar4_-_na_zed_-_2024.pptx](../sources/p%C5%99%C3%ADklady%20k%20procvi%C4%8Dov%C3%A1n%C3%AD/Seminar4_-_na_zed_-_2024.pptx) | 9 snímků | `007c056ae95ddd72` |
| [D01](#d01) | [1. Základy tvorby datové matice.docx](../sources/ostatn%C3%AD%20zdroje/1.%20Z%C3%A1klady%20tvorby%20datov%C3%A9%20matice.docx) | DOCX | `eb639ba5a54af039` |
| [D02](#d02) | [1. Základy tvorby datové matice.pdf](../sources/ostatn%C3%AD%20zdroje/1.%20Z%C3%A1klady%20tvorby%20datov%C3%A9%20matice.pdf) | 6 stran PDF | `3e2a6cec5170dd39` |
| [D03](#d03) | [de_Vaus_-_Variable_coding_rules.pdf](../sources/ostatn%C3%AD%20zdroje/de_Vaus_-_Variable_coding_rules.pdf) | 9 stran PDF | `d2dc9a9796ed557d` |
| [D04](#d04) | [Variable_coding_rules.pdf](../sources/ostatn%C3%AD%20zdroje/Variable_coding_rules.pdf) | 8 stran PDF | `4fef84bde26531da` |
| [D05](#d05) | [On_the_Statistical_Treatment_of_Football_Numbers.pdf](../sources/ostatn%C3%AD%20zdroje/On_the_Statistical_Treatment_of_Football_Numbers.pdf) | 2 stran PDF | `0d07d85b09228954` |
| [D06](#d06) | [A reanalysis of Lord’s statistical treatment of football numbers.pdf](../sources/ostatn%C3%AD%20zdroje/A%20reanalysis%20of%20Lord%E2%80%99s%20statistical%20treatment%20of%20football%20numbers.pdf) | 7 stran PDF | `206402da457efbfc` |
| [D07](#d07) | [What educated citizens should know about statistics and probability.pdf](../sources/ostatn%C3%AD%20zdroje/What%20educated%20citizens%20should%20know%20about%20statistics%20and%20probability.pdf) | 6 stran PDF | `4cc78dcce3c286ea` |
| [D08](#d08) | [Baron_-_kap5_-_probability_rkhanxjn.pdf](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap5_-_probability_rkhanxjn.pdf) | 34 stran PDF | `59dda8531fb552d4` |
| [D09](#d09) | [Baron_-_kap6_-_probability_desc.pdf](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap6_-_probability_desc.pdf) | 24 stran PDF | `9fdad8c6f9412d0b` |
| [D10](#d10) | [Normalni_rozdeleni_do_3_aveamian._prednasky.xlsx](../sources/ostatn%C3%AD%20zdroje/Normalni_rozdeleni_do_3_aveamian._prednasky.xlsx) | 4 listy | `0f1a5783380913ed` |

## Učebnice

V tabulkách jsou uvedeny začátky kapitol nebo konkrétních oddílů. Rozsah důkladněji přečteného výkladu je vypsán zvlášť; ostatní položky mají stav **mapa obsahu**. Bibliografická identita se opírá o titulní a nakladatelské strany příslušného PDF, nikoli pouze o název souboru.

<a id="u01"></a>

### U01 — Howell — hlavní východisko

**Soubor:** [howell.pdf](../sources/u%C4%8Debnice/howell.pdf).

**Identita:** David C. Howell: *Statistical Methods for Psychology*, 8. vydání, 2013, Wadsworth/Cengage Learning. Titul PDF 3, nakladatelské údaje PDF 6; ISBN 978-1-111-83548-4. Obsah PDF 9 a 11–17.

**Doporučené použití:** Pořadí a základní odborný rámec kapitol; psychologické příklady, podmínky metod a interpretace. Rozsah knihy výrazně převyšuje tento kurz.

| Lokátor | Mapa obsahu |
|---|---|
| [s. 1 (PDF 25)](../sources/u%C4%8Debnice/howell.pdf#page=25) | 1 Základní pojmy; §1.1 terminologie s. 2, §1.2 popis a inference s. 5, §1.3 měření s. 6 |
| [s. 15 (PDF 39)](../sources/u%C4%8Debnice/howell.pdf#page=39) | 2 Popis dat; grafy s. 16–27, značení s. 30, poloha s. 32, variabilita s. 35, boxplot s. 47, percentily s. 51, transformace s. 52 |
| [s. 63 (PDF 87)](../sources/u%C4%8Debnice/howell.pdf#page=87) | 3 Normální rozdělení; normální model s. 66, standardní model s. 69, práce s plochami s. 71, meze s. 74, posouzení normality s. 75, související skóry s. 78 |
| [s. 83 (PDF 107)](../sources/u%C4%8Debnice/howell.pdf#page=107) | 4 Výběrová rozdělení a testování; výběrové rozdělení s. 86, logika testu s. 88, nulová hypotéza s. 90, chyby s. 94, jednostranné/dvoustranné testy s. 97, účinek s. 101 |
| [s. 107 (PDF 131)](../sources/u%C4%8Debnice/howell.pdf#page=131) | 5 Pravděpodobnost; pojetí s. 108, pravidla s. 110, náhodné proměnné s. 114–115, kombinatorika s. 117, Bayes s. 120, binomické rozdělení s. 124, binomický test s. 128 |
| [s. 137 (PDF 161)](../sources/u%C4%8Debnice/howell.pdf#page=161) | 6 Kategoriální data; dobrá shoda s. 139, kontingenční tabulky s. 144, předpoklady s. 153, závislá data s. 154, velikost účinku s. 160, shoda posuzovatelů s. 166 |
| [s. 177 (PDF 201)](../sources/u%C4%8Debnice/howell.pdf#page=201) | 7 Průměry a t-testy; rozdělení průměru s. 178, známé σ s. 181, jeden průměr s. 183, párová data s. 197, nezávislé skupiny s. 206, nestejné rozptyly s. 217 |
| [s. 229 (PDF 253)](../sources/u%C4%8Debnice/howell.pdf#page=253) | 8 Síla testu; faktory s. 232, výpočty s. 234–243, retrospektivní síla s. 245 |
| [s. 251 (PDF 275)](../sources/u%C4%8Debnice/howell.pdf#page=275) | 9 Korelace a jednoduchá regrese; kovariance s. 258, r s. 260, přímka s. 261, predikce s. 266, předpoklady s. 272, inference s. 274–290 |
| [s. 303 (PDF 327)](../sources/u%C4%8Debnice/howell.pdf#page=327) | 10 Další korelační koeficienty; phi s. 304, biseriální a pořadové s. 313, Kendallovo W s. 320 |
| [s. 325 (PDF 349)](../sources/u%C4%8Debnice/howell.pdf#page=349) | 11 Jednofaktorová ANOVA; model s. 327, logika s. 329, předpoklady s. 343, účinek s. 353 |
| [s. 369 (PDF 393)](../sources/u%C4%8Debnice/howell.pdf#page=393) | 12 Vícenásobná porovnání; chyby s. 370, plánovaná s. 376, následná s. 391, Tukey s. 393, trendy s. 401 |
| [s. 411 (PDF 435)](../sources/u%C4%8Debnice/howell.pdf#page=435) | 13 Faktorová ANOVA; interakce s. 419, jednoduché efekty s. 420, design s. 430, vyšší řády s. 446 |
| [s. 457 (PDF 481)](../sources/u%C4%8Debnice/howell.pdf#page=481) | 14 Opakovaná měření; model s. 460, kovariance s. 461, smíšené designy s. 467, ICC s. 489, smíšené modely s. 492 |
| [s. 507 (PDF 531)](../sources/u%C4%8Debnice/howell.pdf#page=531) | 15 Vícenásobná regrese; diagnostika s. 532, mediace a moderace s. 546, logistická regrese s. 556 |
| [s. 573 (PDF 597)](../sources/u%C4%8Debnice/howell.pdf#page=597) | 16 Obecný lineární model; ANOVA jako regrese s. 577, ANCOVA s. 594, návrh výzkumu s. 616 |
| [s. 623 (PDF 647)](../sources/u%C4%8Debnice/howell.pdf#page=647) | 17 Meta-analýza a analýza jednotlivých případů; meta-analýza s. 624, případové analýzy s. 641 |
| [s. 657 (PDF 681)](../sources/u%C4%8Debnice/howell.pdf#page=681) | 18 Resampling a neparametrické testy; bootstrap s. 659, Wilcoxon s. 668, znaménkový test s. 677, Kruskal–Wallis s. 678, Friedman s. 679 |

**Prostudované pasáže:** Při tomto průzkumu obsah celé knihy; §5.1 a začátek §5.2, s. 108–110; začátek §5.7, s. 120–121. Pasáže ukazují různá pojetí pravděpodobnosti, pravidla a aktualizaci pravděpodobnosti při novém důkazu. Dřívější projektové záznamy o jiných stranách nejsou vydávány za nové úplné čtení.

**Nálezy a neověřené části:** Celý text všech kapitol, úlohy a výpočty nebyly znovu ověřeny. V §5.1 nepřebírat bez vysvětlení tvrzení, že různá pojetí pravděpodobnosti vedou v testování ke stejnému výsledku. V §5.2 je třeba odlišit elementární výsledek a jev; obecná tvrzení o nemožnosti při pravděpodobnosti 0 vyžadují při spojitých modelech zpřesnění.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** znovu ověřena identita na PDF 3 a 6; přečten souvislý výklad s. 108–127 (PDF 132–151), včetně tabulek a příkladů. V obrazech zvlášť zkontrolovány s. 109, 113, 120, 122, 125 a 127. Tabulka rodičovství/pásy (tab. 5.2, s. 113) a dopingový příklad (s. 121–122) jsou přímými podklady příkladů P05, nikoli dvěma nezávislými empirickými zdroji. Při převzetí uvést původ u Howella a modelové předpoklady. Binomický výklad s. 125–126 již přechází od přesné pravděpodobnosti konkrétního počtu k inferenčnímu závěru; pro zamýšlený úvod oddělit výpočet pravděpodobnosti od pozdějšího testování. Binomický test a úlohy od s. 128 nejsou tímto čtením kompletně prověřeny.

**Použití v kapitole 5 (2026-10-12):** pořadí výkladu a citace s. 108–110 (pojetí), 109 (podmínka stejně pravděpodobných výsledků), 112 (výběr s vracením), 119 (náhodná pořadí místo všech), 121–123 (Bayesova věta, taxíky), 124–128 (binomické rozdělení, parametry, orientační pravidlo „větší než asi 5“). S. 119 a 128 čteny v textové extrakci, nikoli v obraze. Kapitola nepřebírá Howellovy užší tvary součtového a součinového pravidla ani definici nezávislosti slovy „nemá vliv“. U příkladu devíti správných odpovědí z deseti (s. 125–126) text odlišuje otázku na právě devět od otázky na devět nebo více. Úloha o taxících je cvičením 7 s uvedením zdroje; tabulka pásů a dopingový příklad použity nebyly. Binomický test a cvičení od s. 128 zůstávají nečtené.

<a id="u02"></a>

### U02 — Aron, Aron a Coups — postupné psychologické příklady

**Soubor:** [aron.pdf](../sources/u%C4%8Debnice/aron.pdf).

**Identita:** *Statistics for Psychology*, 6. vydání, Pearson New International Edition, ©2014 Pearson Education Limited. Titul PDF 2 uvádí pořadí Arthur Aron, Elaine Aron, Elliot Coups; kapitoly uvádějí Arthur Aron, Elliot J. Coups, Elaine N. Aron a copyright 2013. Nakladatelská strana PDF 3 uvádí ISBN 978-1-292-04029-5 i 978-1-269-37450-7. Před formální citací sjednotit záznam s touto konkrétní mezinárodní verzí; rozdíl v pořadí autorů a letopočtech nezamlčet.

**Doporučené použití:** Srozumitelný přechod od konkrétního skóru k jeho relativní poloze a od popisu k inferenci; doplňkový didaktický zdroj.

| Lokátor | Mapa obsahu |
|---|---|
| [s. 1 (PDF 6)](../sources/u%C4%8Debnice/aron.pdf#page=6) | 1 Úvod, tabulky a grafy |
| [s. 37 (PDF 42)](../sources/u%C4%8Debnice/aron.pdf#page=42) | 2 Průměr, variabilita a další popisné charakteristiky |
| [s. 73 (PDF 78)](../sources/u%C4%8Debnice/aron.pdf#page=78) | 3 z-skóry, normální křivka, výběr a populace, pravděpodobnost; navazuje na polohu a variabilitu |
| [s. 121 (PDF 126)](../sources/u%C4%8Debnice/aron.pdf#page=126) | 4 Úvod do testování hypotéz |
| [s. 155 (PDF 160)](../sources/u%C4%8Debnice/aron.pdf#page=160) | 5 Rozdělení průměrů |
| [s. 195 (PDF 200)](../sources/u%C4%8Debnice/aron.pdf#page=200) | 6 Statistická významnost a související otázky |
| [s. 251 (PDF 256)](../sources/u%C4%8Debnice/aron.pdf#page=256) | 7 t-testy |
| [s. 305 (PDF 310)](../sources/u%C4%8Debnice/aron.pdf#page=310) | 8 Dvě nezávislé skupiny |
| [s. 349 (PDF 354)](../sources/u%C4%8Debnice/aron.pdf#page=354) | 9 ANOVA |
| [s. 419 (PDF 424)](../sources/u%C4%8Debnice/aron.pdf#page=424) | 10 Faktorová ANOVA |
| [s. 487 (PDF 492)](../sources/u%C4%8Debnice/aron.pdf#page=492) | 11 Korelace |
| [s. 545 (PDF 550)](../sources/u%C4%8Debnice/aron.pdf#page=550) | 12 Predikce |
| [s. 597 (PDF 602)](../sources/u%C4%8Debnice/aron.pdf#page=602) | 13 Chí-kvadrát |
| [s. 645 (PDF 650)](../sources/u%C4%8Debnice/aron.pdf#page=650) | 14 Logika výzkumu a interpretace |
| [s. 657 (PDF 662)](../sources/u%C4%8Debnice/aron.pdf#page=662) | 15 Vlastní výzkumný projekt |
| [s. 671 (PDF 676)](../sources/u%C4%8Debnice/aron.pdf#page=676) | 16 Opakovaná měření |
| [s. 683 (PDF 688)](../sources/u%C4%8Debnice/aron.pdf#page=688) | 17 Obecný lineární model |

**Prostudované pasáže:** Obsah PDF 4–5; úvodní výklad kap. 1; kap. 3 s. 74–75: z-skór na příkladu sebehodnocení ranního typu, nejprve rozdíl od průměru a potom jednotka směrodatné odchylky.

**Nálezy a neověřené části:** Podrobné postupy testů, všechna řešení a SPSS nebyly ověřeny. Označení M/SD a software nepřebírat jako výpočetní konvence projektu.

<a id="u03"></a>

### U03 — Cumming a Calin-Jageman — odhad, přesnost a otevřená věda

**Soubor:** [cumming.pdf](../sources/u%C4%8Debnice/cumming.pdf).

**Identita:** Geoff Cumming a Robert Calin-Jageman: *Introduction to the New Statistics: Estimation, Open Science, and Beyond*, 2. vydání, 2024, Routledge. Titul PDF 8, copyright PDF 9, obsah PDF 12 a 14–20. DOI 10.4324/9781032689470.

**Doporučené použití:** Alternativní výklad založený na odhadech, intervalech a simulacích; dobrá opora pro význam nejistoty, účinku a plánování. Pořadí se liší od Howella.

| Lokátor | Mapa obsahu |
|---|---|
| [s. 1 (PDF 36)](../sources/u%C4%8Debnice/cumming.pdf#page=36) | 1 Výzkumné otázky |
| [s. 17 (PDF 52)](../sources/u%C4%8Debnice/cumming.pdf#page=52) | 2 Výzkumné uspořádání: měření s. 25, úrovně s. 27, výběr s. 32, otevřená věda s. 35 |
| [s. 43 (PDF 78)](../sources/u%C4%8Debnice/cumming.pdf#page=78) | 3 Grafy, poloha s. 51, variabilita s. 56, dobré a špatné zobrazení s. 66 |
| [s. 74 (PDF 109)](../sources/u%C4%8Debnice/cumming.pdf#page=109) | 4 Normální rozdělení a výběrová variabilita: normální model s. 75, opakované výběry s. 83, SE s. 88, CLT s. 89 |
| [s. 101 (PDF 136)](../sources/u%C4%8Debnice/cumming.pdf#page=136) | 5 Intervaly spolehlivosti a velikost účinku: CI s. 105, t s. 109, účinek s. 117, interpretace s. 119 |
| [s. 134 (PDF 169)](../sources/u%C4%8Debnice/cumming.pdf#page=169) | 6 p-hodnoty a testování: vazba na CI s. 145, problematické interpretace s. 150, rozhodování s. 156 |
| [s. 171 (PDF 206)](../sources/u%C4%8Debnice/cumming.pdf#page=206) | 7 Dvě nezávislé skupiny, Cohenovo d s. 185 |
| [s. 210 (PDF 245)](../sources/u%C4%8Debnice/cumming.pdf#page=245) | 8 Párová data, účinek s. 218, volba uspořádání s. 227 |
| [s. 235 (PDF 270)](../sources/u%C4%8Debnice/cumming.pdf#page=270) | 9 Meta-analýza: forest plot s. 236, modely s. 240, publikační zkreslení s. 249 |
| [s. 270 (PDF 305)](../sources/u%C4%8Debnice/cumming.pdf#page=305) | 10 Otevřený výzkum a plánování: preregistrace s. 279, přesnost s. 282, síla s. 294 |
| [s. 309 (PDF 344)](../sources/u%C4%8Debnice/cumming.pdf#page=344) | 11 Korelace: bodový graf s. 311, r s. 316, inference s. 323, interpretace s. 333 |
| [s. 349 (PDF 384)](../sources/u%C4%8Debnice/cumming.pdf#page=384) | 12 Regrese: přímka s. 350, r² s. 361, předpoklady s. 366, regrese k průměru s. 375 |
| [s. 387 (PDF 422)](../sources/u%C4%8Debnice/cumming.pdf#page=422) | 13 Podíly a kategoriální data: CI s. 391, rozdíl podílů s. 396, chí-kvadrát s. 401 |
| [s. 414 (PDF 449)](../sources/u%C4%8Debnice/cumming.pdf#page=449) | 14 Jeden faktor: kontrasty s. 424, opakovaná měření s. 432, ANOVA s. 437 |
| [s. 447 (PDF 482)](../sources/u%C4%8Debnice/cumming.pdf#page=482) | 15 Dva faktory: interakce a vzorce s. 456, opakovaná měření s. 464 |
| [s. 487 (PDF 522)](../sources/u%C4%8Debnice/cumming.pdf#page=522) | 16 Další plánování a výzkumná praxe: archivní data s. 494, více výsledků s. 497 |

**Prostudované pasáže:** Obsah celé knihy; s. 75 (plocha a hustota, z-skóry nejsou omezeny na normální rozdělení), s. 107 (opakované intervaly a dlouhodobé pokrytí).

**Nálezy a neověřené části:** Nespouštěny aplikace a simulace dances/esci ani všechny příklady. Odkazy C2/C3 ve starých úlohách mají jiné stránkování a nemusí pocházet z tohoto vydání.

<a id="u04"></a>

### U04 — Diez, Çetinkaya-Rundel a Barr — OpenIntro Statistics

**Soubor:** [diez.pdf](../sources/u%C4%8Debnice/diez.pdf).

**Identita:** David Diez, Mine Çetinkaya-Rundel a Christopher D. Barr: *OpenIntro Statistics*, 4. vydání, 2019, verze aktualizovaná 12. 8. 2019. Identita PDF 1–2, obsah PDF 3–4.

**Doporučené použití:** Stručná kontrolní opora pro výzkumný design, pravděpodobnost, podmínění a inferenci; názorné tabulky a široký kontext příkladů.

| Lokátor | Mapa obsahu |
|---|---|
| [s. 7 (PDF 7)](../sources/u%C4%8Debnice/diez.pdf#page=7) | 1 Data: klinický příklad s. 9, typy dat s. 12, výběr s. 22, experiment s. 32 |
| [s. 39 (PDF 39)](../sources/u%C4%8Debnice/diez.pdf#page=39) | 2 Shrnutí: numerická data s. 41, kategoriální s. 61, výzkumný příklad s. 71 |
| [s. 79 (PDF 79)](../sources/u%C4%8Debnice/diez.pdf#page=79) | 3 Pravděpodobnost: pravidla s. 81, podmíněná s. 95, výběr bez vracení s. 112, náhodné proměnné s. 115, spojité s. 125 |
| [s. 131 (PDF 131)](../sources/u%C4%8Debnice/diez.pdf#page=131) | 4 Rozdělení: normální s. 133, geometrické s. 144, binomické s. 149, negativně binomické s. 158, Poissonovo s. 163 |
| [s. 168 (PDF 168)](../sources/u%C4%8Debnice/diez.pdf#page=168) | 5 Inference: odhad s. 170, CI podílu s. 181, testování s. 189 |
| [s. 206 (PDF 206)](../sources/u%C4%8Debnice/diez.pdf#page=206) | 6 Kategoriální data: jeden podíl s. 208, dva podíly s. 217, dobrá shoda s. 229, nezávislost s. 240 |
| [s. 249 (PDF 249)](../sources/u%C4%8Debnice/diez.pdf#page=249) | 7 Numerická data: jeden průměr s. 251, párová data s. 262, dvě skupiny s. 267, síla s. 278, ANOVA s. 285 |
| [s. 303 (PDF 303)](../sources/u%C4%8Debnice/diez.pdf#page=303) | 8 Jednoduchá regrese: nejmenší čtverce s. 317, odlehlé body s. 328, inference s. 331 |
| [s. 341 (PDF 341)](../sources/u%C4%8Debnice/diez.pdf#page=341) | 9 Vícenásobná a logistická regrese: výběr modelu s. 353, kontrola s. 358, logistická s. 371 |
| [s. 384 (PDF 384)](../sources/u%C4%8Debnice/diez.pdf#page=384) | Odpovědi na vybrané úlohy; přehled datasetů s. 403 |

**Prostudované pasáže:** Obsah a §3.2, s. 95: klasifikace fotografií, kontingenční tabulka a změna jmenovatele při podmínění.

**Nálezy a neověřené části:** Ostatní výpočty, datové soubory a řešení nebyly systematicky přepočítány; příklady nejsou převážně psychologické.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** z originálního PDF přečteny s. 95–96, příklady 3.26–3.27 a tabulky/obrázky 3.11–3.14 v textové extrakci. Využitelný je postup od otázky ke konkrétnímu jmenovateli při podmínění. Samostatná vizuální kontrola těchto stran ani ověření datasetu v tomto kroku neproběhly.

**Použití v kapitole 5 (2026-10-12):** jediná citace, s. 95–96, k volbě jmenovatele při čtení tabulky. Identita na PDF 1–2 znovu přečtena v extrakci (4. vydání, 2019, aktualizace 12. 8. 2019, openintro.org/os); do společné bibliografie zařazeno s vydavatelem OpenIntro. Vizuální kontrola stran 95–96 neproběhla.

<a id="u05"></a>

### U05 — Dostál — česká terminologie a matematické souvislosti

**Soubor:** [dostal.pdf](../sources/u%C4%8Debnice/dostal.pdf).

**Identita:** Daniel Dostál: *Statistické metody v psychologii. Studijní opora pro rok 2022/23*, kurzy BSMP1, DSMP1, BSMP2 a DSMP2. Titul PDF 1; rok kurzu není samostatně ověřeným nakladatelským rokem. Obsah PDF 2–6.

**Doporučené použití:** České pojmy, početní úlohy a formálnější kontrola vztahů; rozsah pokrývá více kurzů. Matematiku je třeba výrazně přizpůsobit vstupním znalostem našich studentů.

| Lokátor | Mapa obsahu |
|---|---|
| [s. 7 (PDF 7)](../sources/u%C4%8Debnice/dostal.pdf#page=7) | 1 Matematika: množiny a funkce |
| [s. 12 (PDF 12)](../sources/u%C4%8Debnice/dostal.pdf#page=12) | 2 Pravděpodobnost: jevy s. 12, pravděpodobnost s. 13, náhodná proměnná s. 16, rozdělení s. 18, střední hodnota a rozptyl s. 22, kvantily s. 25 |
| [s. 26 (PDF 26)](../sources/u%C4%8Debnice/dostal.pdf#page=26) | Diskrétní modely: Bernoulliho a binomické s. 28, Poissonovo s. 29 |
| [s. 31 (PDF 31)](../sources/u%C4%8Debnice/dostal.pdf#page=31) | Spojité modely: rovnoměrné s. 33, normální s. 34–35, chí-kvadrát s. 39, t s. 40, F s. 41 |
| [s. 43 (PDF 43)](../sources/u%C4%8Debnice/dostal.pdf#page=43) | 3 Popis dat: četnosti s. 44, grafy s. 45, poloha s. 48–53, variabilita s. 55–58, šikmost a špičatost s. 59, korelace s. 61–67 |
| [s. 69 (PDF 69)](../sources/u%C4%8Debnice/dostal.pdf#page=69) | 4 Odhad: bodový s. 71, CI s. 79, průměr s. 83, rozptyl s. 85, rozdíly s. 86, podíl s. 87, korelace s. 88, populace jako metafora s. 90 |
| [s. 92 (PDF 92)](../sources/u%C4%8Debnice/dostal.pdf#page=92) | 5 Testování: logika s. 94, kritický obor s. 101, účinek s. 103, t-testy s. 105–109, korelace s. 115, ANOVA s. 117, předpoklady s. 123, síla s. 128 |
| [s. 135 (PDF 135)](../sources/u%C4%8Debnice/dostal.pdf#page=135) | Kategoriální testy: dobrá shoda s. 138, kontingenční tabulky s. 139, Fisher s. 144, McNemar s. 146 |
| [s. 149 (PDF 149)](../sources/u%C4%8Debnice/dostal.pdf#page=149) | Neparametrické testy: znaménkový s. 150, Wilcoxon s. 153, Mann–Whitney s. 156, Spearman s. 161, Kruskal–Wallis s. 162, volba metody s. 165 |
| [s. 179 (PDF 179)](../sources/u%C4%8Debnice/dostal.pdf#page=179) | 6 Cvičení: sumace s. 179, kombinatorika s. 187, očekávaná hodnota s. 194, diskrétní modely s. 200, spojité s. 204, poloha/variabilita s. 210, korelace s. 213, grafy s. 217, CI s. 220 |

**Prostudované pasáže:** Obsah celé opory a §2.1–2.2.1, s. 12–14: jevy, pravidla, nezávislost a klasická pravděpodobnost.

**Nálezy a neověřené části:** Důležitá odchylka: s. 13–14 odmítají pravděpodobnost jako subjektivní míru jistoty pro již rozhodnutou neznámou skutečnost. Jde o určité pojetí, které se rozchází s Baronem a s pluralitou pojetí u Howella/Navarro; nepřebírat jako obecný zákaz. Neověřeny všechny výpočty a řešení.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** znovu přečteny s. 12–14; potvrzen rozpor v pojetí pravděpodobnosti uvedený výše. Terminologický podklad je užitečný, ale odmítnutí pravděpodobnosti již nastalé neznámé skutečnosti není společnou definicí všech pravděpodobnostních přístupů. Nová vizuální kontrola těchto stran neproběhla.

<a id="u06"></a>

### U06 — Gravetter a Wallnau — postupný početní výklad

**Soubor:** [gravetter.pdf](../sources/u%C4%8Debnice/gravetter.pdf).

**Identita:** Frederick J. Gravetter a Larry B. Wallnau: *Statistics for the Behavioral Sciences*, 10. vydání, ©2017 Cengage Learning. Titul PDF 2, copyright PDF 4; ISBN 978-1-305-50491-2. Obsah PDF 5 a 7–14.

**Doporučené použití:** Podrobná posloupnost dílčích dovedností, malé početní příklady a kontrolní otázky. Vhodné pro doplnění mezikroků, nikoli k automatickému rozšíření početního drilu.

| Lokátor | Mapa obsahu |
|---|---|
| [s. 1 (PDF 23)](../sources/u%C4%8Debnice/gravetter.pdf#page=23) | 1 Úvod: výzkumná uspořádání s. 10, měření s. 18, značení s. 25 |
| [s. 33 (PDF 55)](../sources/u%C4%8Debnice/gravetter.pdf#page=55) | 2 Četnosti: tabulky s. 35, intervaly s. 38, grafy s. 42, percentily s. 49 |
| [s. 67 (PDF 89)](../sources/u%C4%8Debnice/gravetter.pdf#page=89) | 3 Poloha: průměr s. 70, medián s. 79, modus s. 83, volba s. 86 |
| [s. 99 (PDF 121)](../sources/u%C4%8Debnice/gravetter.pdf#page=121) | 4 Variabilita: populační s. 108, výběrová s. 111, nezkreslenost s. 117 |
| [s. 131 (PDF 153)](../sources/u%C4%8Debnice/gravetter.pdf#page=153) | 5 z-skóry: význam s. 133, standardizace s. 141, jiné škály s. 145 |
| [s. 159 (PDF 181)](../sources/u%C4%8Debnice/gravetter.pdf#page=181) | 6 Pravděpodobnost: normální model s. 165, plochy s. 172, binomický model s. 179 |
| [s. 193 (PDF 215)](../sources/u%C4%8Debnice/gravetter.pdf#page=215) | 7 Rozdělení průměrů: CLT s. 199, pravděpodobnosti s. 206, SE s. 210 |
| [s. 223 (PDF 245)](../sources/u%C4%8Debnice/gravetter.pdf#page=245) | 8 Testování: logika s. 225, chyby s. 236, účinek s. 250, síla s. 254 |
| [s. 267 (PDF 289)](../sources/u%C4%8Debnice/gravetter.pdf#page=289) | 9 Jeden t-test |
| [s. 299 (PDF 321)](../sources/u%C4%8Debnice/gravetter.pdf#page=321) | 10 Nezávislé skupiny |
| [s. 335 (PDF 357)](../sources/u%C4%8Debnice/gravetter.pdf#page=357) | 11 Párová data a opakovaná měření |
| [s. 365 (PDF 387)](../sources/u%C4%8Debnice/gravetter.pdf#page=387) | 12 Jednofaktorová ANOVA |
| [s. 413 (PDF 435)](../sources/u%C4%8Debnice/gravetter.pdf#page=435) | 13 ANOVA opakovaných měření |
| [s. 447 (PDF 469)](../sources/u%C4%8Debnice/gravetter.pdf#page=469) | 14 Faktorová ANOVA |
| [s. 485 (PDF 507)](../sources/u%C4%8Debnice/gravetter.pdf#page=507) | 15 Korelace, alternativní koeficienty s. 510 |
| [s. 529 (PDF 551)](../sources/u%C4%8Debnice/gravetter.pdf#page=551) | 16 Regrese, více prediktorů s. 544 |
| [s. 559 (PDF 581)](../sources/u%C4%8Debnice/gravetter.pdf#page=581) | 17 Chí-kvadrát |
| [s. 603 (PDF 625)](../sources/u%C4%8Debnice/gravetter.pdf#page=625) | 18 Binomický test |
| [s. 625 (PDF 647)](../sources/u%C4%8Debnice/gravetter.pdf#page=647) | Dodatky: matematika s. 625, SPSS s. 683, neparametrické testy s. 687, výběr metody s. 701 |

**Prostudované pasáže:** Obsah celé knihy a §6.1, s. 160: spojení pravděpodobnosti s výběrem z populace a příklad podobnosti iniciál partnerů.

**Nálezy a neověřené části:** Historické empirické příklady a jejich kauzální interpretace nejsou aktuálně ověřeny. Výklad na s. 160 nabízí psychologické vysvětlení pozorované souvislosti; pro naši kapitolu by bylo nutné odlišit souvislost od prokázaného mechanismu. Nespouštěn SPSS a neřešeny všechny úlohy.

<a id="u07"></a>

### U07 — Judd, McClelland a Ryan — data, model a chyba

**Soubor:** [judd.pdf](../sources/u%C4%8Debnice/judd.pdf).

**Identita:** Charles M. Judd, Gary H. McClelland a Carey S. Ryan: *Data Analysis: A Model Comparison Approach to Regression, ANOVA, and Beyond*, 3. vydání, 2017, Routledge. Titul PDF 4, copyright PDF 5, obsah PDF 6; eISBN 978-1-315-74413-1.

**Doporučené použití:** Koncepční opora pro modelové uvažování a společnou logiku regrese a ANOVA. Formálnější a pokročilejší než základní kurz; vybírat vysvětlení, ne celé kapitoly.

| Lokátor | Mapa obsahu |
|---|---|
| [s. 1 (PDF 14)](../sources/u%C4%8Debnice/judd.pdf#page=14) | 1 Úvod do analýzy dat |
| [s. 10 (PDF 23)](../sources/u%C4%8Debnice/judd.pdf#page=23) | 2 Jednoduché modely, chyba a odhad |
| [s. 25 (PDF 38)](../sources/u%C4%8Debnice/judd.pdf#page=38) | 3 Chyba a výběrová rozdělení |
| [s. 43 (PDF 56)](../sources/u%C4%8Debnice/judd.pdf#page=56) | 4 Statistická inference |
| [s. 72 (PDF 85)](../sources/u%C4%8Debnice/judd.pdf#page=85) | 5 Jeden spojitý prediktor |
| [s. 103 (PDF 116)](../sources/u%C4%8Debnice/judd.pdf#page=116) | 6 Vícenásobná regrese |
| [s. 135 (PDF 148)](../sources/u%C4%8Debnice/judd.pdf#page=148) | 7 Moderace a nelineární vztahy |
| [s. 168 (PDF 181)](../sources/u%C4%8Debnice/judd.pdf#page=181) | 8 Jednofaktorová ANOVA |
| [s. 205 (PDF 218)](../sources/u%C4%8Debnice/judd.pdf#page=218) | 9 Faktorová ANOVA |
| [s. 229 (PDF 242)](../sources/u%C4%8Debnice/judd.pdf#page=242) | 10 ANCOVA |
| [s. 260 (PDF 273)](../sources/u%C4%8Debnice/judd.pdf#page=273) | 11 Opakovaná měření |
| [s. 292 (PDF 305)](../sources/u%C4%8Debnice/judd.pdf#page=305) | 12 Smíšené modely |
| [s. 314 (PDF 327)](../sources/u%C4%8Debnice/judd.pdf#page=327) | 13 Odlehlá a vlivná pozorování |
| [s. 339 (PDF 352)](../sources/u%C4%8Debnice/judd.pdf#page=352) | 14 Logistická regrese |

**Prostudované pasáže:** Obsah a úvod s. 1: data = model + chyba, model jako stručný popis i predikce, chyba jako reziduum. Příklad podílů domácností s internetem.

**Nálezy a neověřené části:** Výpočty porovnání modelů, odvození a diagnostické postupy nebyly kompletně ověřeny. Modelové uvažování není samostatná alternativa k popisu či inferenci; může sloužit oběma.

<a id="u08"></a>

### U08 — Navarro — koncepty propojené s R

**Soubor:** [navarro.pdf](../sources/u%C4%8Debnice/navarro.pdf).

**Identita:** Danielle Navarro: *Learning Statistics with R*. Titul PDF 1; předmluva PDF 17–18 popisuje přepracování původní verze do Quarta a dodatečné epilogy. Přesný rok a číslo vydání tohoto PDF nejsou doloženy. Nepřiřazovat automaticky rok 2015 starší verze. Obsah PDF 2–16.

**Doporučené použití:** Srozumitelná diskuse statistického uvažování, pojetí pravděpodobnosti a inferenčních předpokladů; R zůstává u nás interní, studentský výklad na něm nesmí záviset.

| Lokátor | Mapa obsahu |
|---|---|
| [s. 25 (PDF 25)](../sources/u%C4%8Debnice/navarro.pdf#page=25) | 1 Proč statistika |
| [s. 37 (PDF 37)](../sources/u%C4%8Debnice/navarro.pdf#page=37) | 2 Výzkumný design |
| [s. 68 (PDF 68)](../sources/u%C4%8Debnice/navarro.pdf#page=68) | 3 Úvod do R: prostředí, výpočty, objekty, vektory a indexování |
| [s. 111 (PDF 111)](../sources/u%C4%8Debnice/navarro.pdf#page=111) | 4 Mechanismy R: balíčky, pracovní prostředí, soubory a datové struktury |
| [s. 158 (PDF 158)](../sources/u%C4%8Debnice/navarro.pdf#page=158) | 5 Popisná statistika: poloha s. 159, variabilita s. 170, šikmost s. 182, z-skóry s. 191, korelace s. 193 |
| [s. 214 (PDF 214)](../sources/u%C4%8Debnice/navarro.pdf#page=214) | 6 Grafy: histogram s. 230, boxplot s. 236, bodový graf s. 249, sloupcový s. 255 |
| [s. 265 (PDF 265)](../sources/u%C4%8Debnice/navarro.pdf#page=265) | 7 Práce s daty v R: křížové tabulky, překódování, podmnožiny, spojování a změna uspořádání dat |
| [s. 344 (PDF 344)](../sources/u%C4%8Debnice/navarro.pdf#page=344) | 8 Programování v R |
| [s. 371 (PDF 371)](../sources/u%C4%8Debnice/navarro.pdf#page=371) | 9 Pravděpodobnost: významy s. 373, základní pravidla s. 379, binomické rozdělení s. 381, normální s. 387 |
| [s. 403 (PDF 403)](../sources/u%C4%8Debnice/navarro.pdf#page=403) | 10 Odhad: výběr s. 403, zákon velkých čísel s. 412, výběrová rozdělení a CLT s. 415, odhad parametrů s. 421, CI s. 428 |
| [s. 439 (PDF 439)](../sources/u%C4%8Debnice/navarro.pdf#page=439) | 11 Testování: chyby s. 443, p-hodnota s. 450, účinek a síla s. 457, problémy s. 464 |
| [s. 471 (PDF 471)](../sources/u%C4%8Debnice/navarro.pdf#page=471) | 12 Kategoriální data: dobrá shoda, nezávislost, Fisher s. 499, McNemar s. 502 |
| [s. 508 (PDF 508)](../sources/u%C4%8Debnice/navarro.pdf#page=508) | 13 t-testy: jeden výběr s. 516, Student s. 521, Welch s. 532, párový s. 536, účinek s. 551 |
| [s. 566 (PDF 566)](../sources/u%C4%8Debnice/navarro.pdf#page=566) | 14 Jednofaktorová ANOVA: účinek s. 586, vícenásobná porovnání s. 587, předpoklady s. 594 |
| [s. 609 (PDF 609)](../sources/u%C4%8Debnice/navarro.pdf#page=609) | 15 Regrese: více prediktorů s. 614, předpoklady s. 630, diagnostika s. 631 |
| [s. 660 (PDF 660)](../sources/u%C4%8Debnice/navarro.pdf#page=660) | 16 Faktorová ANOVA: interakce s. 673, GLM s. 691, kontrasty s. 705 |
| [s. 735 (PDF 735)](../sources/u%C4%8Debnice/navarro.pdf#page=735) | 17 Bayesovská statistika: princip s. 736, testy s. 741, kategoriální data s. 752, t-test s. 759, regrese s. 762, ANOVA s. 767 |

**Prostudované pasáže:** Obsah, předmluva a §9.2, s. 373–375: různé významy pravděpodobnosti, opakované hody, dlouhodobá četnost a její interpretace.

**Nálezy a neověřené části:** Kód R, závislosti a epilogy nejsou kompletně spuštěny ani revidovány. Pozdější bayesovské kapitoly jsou pouze zmapované.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** přečteny s. 373–377 včetně kontextu model → data versus data → model, četnostního výkladu a úvodu k subjektivnímu pojetí. Obr. 9.1 byl čten jen v extrakci, nová vizuální kontrola neproběhla. Návrh vlastní simulace má ukazovat kolísání relativních četností, nikoli slib monotónního přibližování nebo přesného vyrovnání krátké řady.

<a id="u09"></a>

### U09 — Privitera — široká učebnice behaviorálních věd

**Soubor:** [privitera.pdf](../sources/u%C4%8Debnice/privitera.pdf).

**Identita:** Gregory J. Privitera: *Statistics for the Behavioral Sciences*, 4. vydání, ©2024 SAGE. Titul PDF 4, copyright PDF 5, obsah PDF 6–18; ISBN 978-1-5443-6281-6.

**Doporučené použití:** Členění na dovednosti a výukové bloky, příklady z behaviorálních věd a spojení testování s účinkem, intervaly a silou.

| Lokátor | Mapa obsahu |
|---|---|
| [kap. 1, s. 2 (PDF 47)](../sources/u%C4%8Debnice/privitera.pdf#page=47) | 1 Úvod: popis a inference s. 5, metody výzkumu s. 9, měření s. 15, typy proměnných s. 21 |
| [s. 33 (PDF 78)](../sources/u%C4%8Debnice/privitera.pdf#page=78) | 2 Četnosti: tabulky, grafy, kumulativní a relativní četnosti, percentily a pořadí |
| [s. 79 (PDF 124)](../sources/u%C4%8Debnice/privitera.pdf#page=124) | 3 Poloha |
| [s. 114 (PDF 159)](../sources/u%C4%8Debnice/privitera.pdf#page=159) | 4 Variabilita |
| [s. 151 (PDF 196)](../sources/u%C4%8Debnice/privitera.pdf#page=196) | 5 Pravděpodobnost: pravidla, podmínění a Bayes, náhodná proměnná, očekávaná hodnota, binomický model |
| [s. 191 (PDF 236)](../sources/u%C4%8Debnice/privitera.pdf#page=236) | 6 Normální rozdělení a z-skóry |
| [s. 226 (PDF 271)](../sources/u%C4%8Debnice/privitera.pdf#page=271) | 7 Výběrová rozdělení |
| [s. 265 (PDF 310)](../sources/u%C4%8Debnice/privitera.pdf#page=310) | 8 Testování, významnost, účinek, odhad a síla |
| [s. 316 (PDF 361)](../sources/u%C4%8Debnice/privitera.pdf#page=361) | 9 Jednovýběrový t-test |
| [s. 351 (PDF 396)](../sources/u%C4%8Debnice/privitera.pdf#page=396) | 10 Nezávislé skupiny |
| [s. 388 (PDF 433)](../sources/u%C4%8Debnice/privitera.pdf#page=433) | 11 Párový t-test |
| [s. 426 (PDF 471)](../sources/u%C4%8Debnice/privitera.pdf#page=471) | 12 Jednofaktorová ANOVA |
| [s. 477 (PDF 522)](../sources/u%C4%8Debnice/privitera.pdf#page=522) | 13 Opakovaná měření |
| [s. 527 (PDF 572)](../sources/u%C4%8Debnice/privitera.pdf#page=572) | 14 Faktorová ANOVA |
| [s. 588 (PDF 633)](../sources/u%C4%8Debnice/privitera.pdf#page=633) | 15 Korelace |
| [s. 658 (PDF 703)](../sources/u%C4%8Debnice/privitera.pdf#page=703) | 16 Regrese |
| [s. 720 (PDF 765)](../sources/u%C4%8Debnice/privitera.pdf#page=765) | 17 Chí-kvadrát |
| [s. 763 (PDF 808)](../sources/u%C4%8Debnice/privitera.pdf#page=808) | 18 Pořadové a další neparametrické postupy |
| [s. 813 (PDF 858)](../sources/u%C4%8Debnice/privitera.pdf#page=858) | Dodatky: základní přehled, matematika s. 829, SPSS s. 844, tabulky s. 860, odpovědi s. 879 |

**Prostudované pasáže:** Obsah knihy; úvod k SPSS PDF 35–38; kap. 5 s. 152–153: cíle, motivace a počítání pravděpodobnosti na jednoduchém prostoru výsledků.

**Nálezy a neověřené části:** Obecná formulace výpočtu jako poměru počtů na s. 153 potřebuje při převodu do našeho textu výslovnou podmínku stejně pravděpodobných výsledků. Prostor výsledků není sám číslo, nýbrž množina. SPSS a zbylé postupy nejsou ověřeny.

<a id="u10"></a>

### U10 — Sahu — formální kontrola pravděpodobnosti a modelů

**Soubor:** [sahu.pdf](../sources/u%C4%8Debnice/sahu.pdf).

**Identita:** Sujit K. Sahu: *Introduction to Probability, Statistics & R: Foundations for Data-Based Sciences*, 2024, Springer; soubor uvádí opravenou publikaci 2024. Titul PDF 3, copyright PDF 4, obsah PDF 9–17. DOI 10.1007/978-3-031-37865-2.

**Doporučené použití:** Systematická odborná kontrola definic, vztahů a podmínek. Velká část vyžaduje derivace, integrály či maticovou algebru a není vhodná k přímému převzetí pro začátečníky.

| Lokátor | Mapa obsahu |
|---|---|
| [s. 3 (PDF 19)](../sources/u%C4%8Debnice/sahu.pdf#page=19) | 1 Základy dat: příklady s. 8, poloha s. 15, variabilita s. 19, boxplot s. 21 |
| [s. 25 (PDF 41)](../sources/u%C4%8Debnice/sahu.pdf#page=41) | 2 Úvod do R |
| [s. 47 (PDF 62)](../sources/u%C4%8Debnice/sahu.pdf#page=62) | 3 Pravděpodobnost: jevy s. 49, axiomy s. 51, kombinatorika s. 54 |
| [s. 63 (PDF 78)](../sources/u%C4%8Debnice/sahu.pdf#page=78) | 4 Podmíněná pravděpodobnost: násobení s. 66, úplná pravděpodobnost s. 67, Bayes s. 69, Monty Hall s. 70, nezávislost s. 72 |
| [s. 81 (PDF 96)](../sources/u%C4%8Debnice/sahu.pdf#page=96) | 5 Náhodné proměnné: rozdělení s. 83, spojité s. 85, CDF s. 86, očekávaná hodnota s. 91, rozptyl s. 93, kvantil s. 95 |
| [s. 99 (PDF 113)](../sources/u%C4%8Debnice/sahu.pdf#page=113) | 6 Diskrétní modely: Bernoulli s. 99, binomický s. 100, geometrický s. 103, hypergeometrický s. 108, negativně binomický s. 109, Poisson s. 111 |
| [s. 117 (PDF 131)](../sources/u%C4%8Debnice/sahu.pdf#page=131) | 7 Spojité modely: exponenciální s. 117, normální s. 125, standardní s. 131, lognormální s. 137, gama a beta s. 139 |
| [s. 147 (PDF 161)](../sources/u%C4%8Debnice/sahu.pdf#page=161) | 8 Sdružená rozdělení, kovariance s. 151, podmíněná s. 156, součty s. 162, CLT s. 167 |
| [s. 175 (PDF 188)](../sources/u%C4%8Debnice/sahu.pdf#page=188) | 9 Inference: modely s. 177, odhad s. 183, zkreslení s. 185, SD a SE s. 190 |
| [s. 195 (PDF 207)](../sources/u%C4%8Debnice/sahu.pdf#page=207) | 10 Bodový odhad: momenty s. 196, maximální věrohodnost s. 198, Bayes s. 207 |
| [s. 221 (PDF 233)](../sources/u%C4%8Debnice/sahu.pdf#page=233) | 11 Intervaly spolehlivosti: interpretace s. 224, CLT s. 226, normální model s. 232 |
| [s. 239 (PDF 250)](../sources/u%C4%8Debnice/sahu.pdf#page=250) | 12 Testování: postup s. 240, p-hodnota s. 248, síla s. 251, párový test s. 255, experiment s. 256 |
| [s. 269 (PDF 278)](../sources/u%C4%8Debnice/sahu.pdf#page=278) | 13 Vytvořující funkce; pokročilá matematika |
| [s. 287 (PDF 295)](../sources/u%C4%8Debnice/sahu.pdf#page=295) | 14 Transformace a odvozená rozdělení |
| [s. 309 (PDF 317)](../sources/u%C4%8Debnice/sahu.pdf#page=317) | 15 Vícerozměrná rozdělení |
| [s. 337 (PDF 344)](../sources/u%C4%8Debnice/sahu.pdf#page=344) | 16 Konvergence odhadů a asymptotika |
| [s. 361 (PDF 366)](../sources/u%C4%8Debnice/sahu.pdf#page=366) | 17 Jednoduchá regrese, predikce s. 389, diagnostika s. 393 |
| [s. 405 (PDF 410)](../sources/u%C4%8Debnice/sahu.pdf#page=410) | 18 Vícenásobná regrese, výběr modelu s. 428, multikolinearita s. 434 |
| [s. 441 (PDF 446)](../sources/u%C4%8Debnice/sahu.pdf#page=446) | 19 ANOVA a interakce |
| [s. 463 (PDF 468)](../sources/u%C4%8Debnice/sahu.pdf#page=468) | 20 Řešení vybraných cvičení |

**Prostudované pasáže:** Obsah celé knihy; kap. 4 s. 64–66: podmínění jako omezení prostoru, příklad kostky, obecný vzorec a pravidlo násobení.

**Nálezy a neověřené části:** Matematické důkazy, cvičení, kód R a obsah opravy nebyly kompletně ověřeny. Číslování PDF má vložené a vynechané stránky; nepoužívat jediný konstantní posun.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** přečteny s. 64–69 (PDF 79–84): definice podmínění včetně kladné pravděpodobnosti podmínky, obecné součinové pravidlo, úplná pravděpodobnost a Bayesova věta. Vizuálně zkontrolovány s. 64, 68–69 včetně obr. 4.1–4.2. Pro studentský text postačí úplná pravděpodobnost rozdělená podle jevu a jeho doplňku; obecný indexovaný zápis není tímto schválen.

**Použití v kapitole 5 (2026-10-12):** ověřeny tištěné strany jednotlivých vztahů v extrakci: podmíněná pravděpodobnost s požadavkem kladné pravděpodobnosti podmínky s. 64–65, součinové pravidlo s. 66, úplná pravděpodobnost s. 67–68, Bayesova věta s. 69 včetně důkazu ze tří předchozích vztahů. Posun PDF = tištěná strana + 15 platí pro tyto strany. DOI ověřeno v metadatech Crossref. Obecný indexovaný zápis úplné pravděpodobnosti kapitola nepoužívá.

<a id="u11"></a>

### U11 — Russo — úvod do četnostní a bayesovské statistiky

**Soubor:** [russo.pdf](../sources/u%C4%8Debnice/russo.pdf) (místní neveřejný podklad).

**Identita:** Riccardo Russo: *Statistics for the Behavioural Sciences: An Introduction to Frequentist and Bayesian Approaches*, 2. vydání, Routledge. Titul PDF 4, nakladatelské údaje PDF 5 uvádějí vydání a copyright **2021**; ISBN 978-1-138-71148-8 (vázané), 978-1-138-71150-1 (brožované), 978-1-315-20041-5 (elektronické). [Nakladatel](https://www.routledge.com/Statistics-for-the-Behavioural-Sciences-An-Introduction-to-Frequentist/Russo/p/book/9781138711501) potvrzuje autora, druhé vydání a copyright 2021. DOI [10.4324/9781315200415](https://doi.org/10.4324/9781315200415) ověřeno v [registračních metadatech Crossref](https://api.crossref.org/works/10.4324/9781315200415), která datují online publikaci na **29. listopadu 2020**. Rozlišovat rok konkrétního vydání v PDF a datum online publikace; při případném zařazení do společné bibliografie tento rozdíl zachovat v autorském záznamu.

**Datum a verze průzkumu:** 11. října 2026, 331 stran PDF, SHA-256 prefix `8939c8698b119e74`. Obsah s. vii–xiii (PDF 8–14); pro níže uvedené lokátory hlavního textu platí PDF = tištěná strana + 21, ověřeno na začátcích kapitol, příloh a v prostudované kapitole 3. Údaj nakladatele „330 stran“ není počet stran tohoto souboru.

**Doporučené použití:** doplňkový didaktický zdroj pro začátečníky, názorný výklad pravděpodobnosti pomocí množin, stromů a tabulek a srovnání četnostní a bayesovské inference. Kapitola 0 nabízí připomenutí potřebné matematiky. Předmluva druhého vydání zdůrazňuje porozumění důvodům postupů a opakování principů v různých kontextech. Howell zůstává hlavním východiskem pořadí; Russo probírá pravděpodobnost a binomický model před normálním rozdělením. Postupy v JASP nepřebírat jako nové softwarové požadavky kurzu a tabulky pravděpodobností nevyžadovat místo Excelu.

| Lokátor | Mapa obsahu |
|---|---|
| [s. 1 (PDF 22)](../sources/u%C4%8Debnice/russo.pdf#page=22) | 0 Matematika a algebra: operátory, pořadí operací a zlomky s. 1–2, proměnné a rovnice s. 3–4. |
| [s. 5 (PDF 26)](../sources/u%C4%8Debnice/russo.pdf#page=26) | 1 Základní pojmy: smysl statistiky a testování, škály s. 10, popis a inference s. 13, experiment s. 14, korelační studie s. 15. |
| [s. 18 (PDF 39)](../sources/u%C4%8Debnice/russo.pdf#page=39) | 2 Popis dat: četnosti a histogramy s. 18, intervaly s. 21, poloha s. 25, sumace s. 30, variabilita s. 31, vlastnosti odhadů s. 39, lineární transformace s. 42, JASP s. 45. |
| [s. 52 (PDF 73)](../sources/u%C4%8Debnice/russo.pdf#page=73) | 3 Pravděpodobnost: pojetí a prostor výsledků s. 52–54, Vennovy diagramy s. 55, součet a součin s. 57–58, stromy s. 59, podmínění s. 60, nezávislost s. 63, Bayes s. 64–67. |
| [s. 68 (PDF 89)](../sources/u%C4%8Debnice/russo.pdf#page=89) | 4 Inference: četnostní přístup s. 69, chyby s. 72–73, intervaly spolehlivosti s. 75, bayesovský přístup s. 76, šance s. 78, Bayesův faktor s. 82–89, credible intervals s. 90, srovnání přístupů s. 91. České názvy nových pojmů zde jsou orientační, nikoli schválená terminologie. |
| [s. 93 (PDF 114)](../sources/u%C4%8Debnice/russo.pdf#page=114) | 5 Pravděpodobnostní rozdělení: střední hodnota s. 96, rozptyl s. 98, uspořádání s. 99, kombinace a binomické rozdělení s. 102, testování s. 107, znaménkový test s. 111, bayesovský binomický test s. 117, volba prioru s. 122. |
| [s. 124 (PDF 145)](../sources/u%C4%8Debnice/russo.pdf#page=145) | 6 Spojité proměnné: hustota s. 124, normální rozdělení s. 127, standardní normální rozdělení s. 130, testování s. 133, chyby s. 135, jednostranné a dvoustranné testy s. 139, bayesovský přístup s. 141. |
| [s. 143 (PDF 164)](../sources/u%C4%8Debnice/russo.pdf#page=164) | 7 Výběrové rozdělení průměru a CLT, známá σ s. 145, jednovýběrový t-test s. 146, intervaly spolehlivosti s. 150, vztah testu, účinku a velikosti studie s. 156, síla s. 158–165, JASP s. 166. |
| [s. 168 (PDF 189)](../sources/u%C4%8Debnice/russo.pdf#page=189) | 8 Párový a nezávislý t-test: párový s. 168, vyvažování pořadí s. 172, nezávislé skupiny s. 173–178, robustnost s. 179, efekt stropu a podlahy s. 181, volba uspořádání s. 183, síla s. 186, JASP s. 189. |
| [s. 195 (PDF 216)](../sources/u%C4%8Debnice/russo.pdf#page=216) | 9 Bayesovský t-test: Bayesův faktor s. 196, credible intervals s. 200, volba prioru s. 205, JASP s. 210–218, Dienesův kalkulátor s. 219. |
| [s. 222 (PDF 243)](../sources/u%C4%8Debnice/russo.pdf#page=243) | 10 Korelace: kovariance s. 227, Pearsonovo r s. 228, testy a intervaly s. 229–234, parciální korelace s. 235, vlivy na r s. 237, bodově biseriální s. 240, Spearman s. 244, Kendallovo W s. 245, síla s. 246, JASP s. 248 a 250. |
| [s. 255 (PDF 276)](../sources/u%C4%8Debnice/russo.pdf#page=276) | 11 Jednoduchá regrese: přímka s. 255, vztah ke korelaci s. 259, test a interval sklonu s. 260–262, r² s. 262, chyba predikce s. 263, JASP s. 265 a 267. |
| [s. 270 (PDF 291)](../sources/u%C4%8Debnice/russo.pdf#page=291) | 12 Chí-kvadrát a kategoriální data: dobrá shoda s. 273, předpoklady s. 275, tabulky 2 × 2 s. 276 a R × C s. 280, síla asociace s. 282, poměr šancí s. 286, zahrnutí nevýskytů s. 288, JASP s. 289 a 291. |
| [s. 295 (PDF 316)](../sources/u%C4%8Debnice/russo.pdf#page=316) | Pouze odkazy na kapitolu 13 (testy podílů) a 14 (neparametrické testy); jejich výklad je označen jako **Web only content** a v tomto PDF není. |
| [s. 296 (PDF 317)](../sources/u%C4%8Debnice/russo.pdf#page=317) | Příloha: statistické tabulky a hlavní vzorce; literatura s. 303 (PDF 324), rejstřík s. 304 (PDF 325). |

**Prostudované pasáže:** titulní a nakladatelská strana, celý obsah, předmluvy prvního a druhého vydání (PDF 15–17 a 19) a celá kapitola 3, s. 52–67 (PDF 73–88), včetně příkladů, tabulky 3.1 a obrázků 3.1–3.7. Titul, nakladatelská strana, obsah a kapitola 3 byly prohlédnuty také v obrazech vykreslených Popplerem; s. 62 navíc samostatně kvůli podezření na věcnou chybu. U ostatních kapitol byly ověřeny názvy a lokátory, nikoli celý výklad. Starší předmluva popisuje strukturu prvního vydání; pro lokátory druhého vydání používat aktuální obsah.

**Nezávislé ověření:** přesnou racionální aritmetikou v Pythonu přepočítány čtyři větve diagnostického stromu obr. 3.6 (0,855; 0,095; 0,045; 0,005), jejich součet 1, celková pravděpodobnost pozitivního výsledku 0,14 a Bayesův výsledek s. 67: 0,045/0,14 = 0,321428…; odpovídají číslům knihy. Přepočítán také výsledek dvou komunit s. 65–66: 0,08/(0,08 + 0,04) = 2/3. Toto ověření modelových výpočtů nepotvrzuje empirickou platnost zadání.

**Nálezy a podmínky použití:**

- **S. 53–54 (PDF 74–75):** pojetí pravděpodobnosti je vhodné srovnat s Howellem, Navarrem a Baronem. Analytický poměr správně výslovně vyžaduje stejně pravděpodobné výsledky. Tvrzení, že pravděpodobnost 0 znamená nemožnost, však nepřenášet bez omezení na spojité modely; výklad četností nesmí vyvolat dojem, že každé prodloužení řady nutně zlepší přiblížení k pravděpodobnosti. Filozofické soudy o jedinečných událostech nejsou univerzální matematické definice.
- **S. 60–62 (PDF 81–83):** rozlišit výsledek testu (pozitivní/negativní) od správnosti testu (správně/chybně). Text na s. 62 označuje výsledek testu a zdravotní stav za nezávislé, což odporuje vlastnímu zadání: pravděpodobnost pozitivního výsledku u nemocných je 0,9 a u zdravých 0,1, zatímco celkově 0,14. Nezávislost v tomto konkrétním modelu platí pro **správnost** klasifikace a zdravotní stav, protože senzitivita i specificita jsou 0,9. Součiny pro větve stromu vyžadují podmíněné pravděpodobnosti výsledku testu. Nález potvrzen ve vykresleném originálu i výpočtem, nejde o chybu extrakce.
- **S. 63–64 (PDF 84–85):** didakticky užitečné je výslovné oddělení zjištěné závislosti ve výběrové tabulce od inference o populaci. Při využití lze zvolit psychologicky vhodný nový kontext se zachováním principu.
- **S. 64–67 (PDF 85–88):** názorný přechod od stromu k Bayesově větě a upozornění, že podmínění nevyžaduje časové pořadí. Příklad komunit mísí nelegální jednání a zatčení; číselný výsledek platí pro podmínku uvedenou v modelu (nelegální jednání), nikoli automaticky pro mechanismus zatýkání. Pro nový výklad je vhodnější diagnostický příklad s jasně vymezenými jevy a opraveným vysvětlením nezávislosti.

**Neověřeno a chybějící části:** podrobný výklad mimo uvedené pasáže, ostatní výpočty, důkazy, empirická tvrzení a odpovědi na cvičení; aktuální funkčnost JASP, Dienesova kalkulátoru a dalších programů. Webové úlohy, data a sešity nebyly staženy ani prověřeny. Kromě kapitol 13–14 jsou pouze na webu také §2.11, §5.11, §6.9, §8.10 a §12.5–12.6; stránka uvedená v obsahu je odkazem, nikoli dostupným výkladem. Bayesovské postupy jsou převážně zmapované, nikoli kompletně odborně revidované. Jejich zařazení do kurzu vyžaduje samostatnou dohodu.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** znovu přečteny s. 60–67 (PDF 81–88); vizuálně prohlédnuty s. 62 a 64–67. Potvrzena výše uvedená záměna nezávislosti výsledku testu a jeho správnosti. S. 64 je vhodná opora pro rozlišení tabulky výběru a populační nezávislosti a pro vysvětlení, že podmínění nemusí vyjadřovat časovou posloupnost.

**Použití v kapitole 5 (2026-10-12):** dvě citace s. 64: nezávislost v tabulce výběru není nezávislost v populaci; podmínění nevyjadřuje časové pořadí. Obojí ověřeno na s. 64 (PDF 85) v extrakci. Záměna nezávislosti výsledku testu a jeho správnosti ze s. 62 převzata nebyla.

## Starší přednáškové prezentace

U všech pěti prezentací byl přečten extrahovaný text snímků a byly dohledány poznámky podle skutečných vazeb v PPTX. Pro vizuální kontrolu byly všechny snímky vyexportovány v PowerPointu; prohlédnuty byly přehledové kontaktní listy (u P01–P04 vybrané, u P05 všechny). To nepotvrzuje správnost každého vzorce, všech odkazů ani animací. Názvy kurzů, ročníky, zkouškové podmínky a organizační údaje jsou historické.

<a id="p01"></a>

### P01 — Úvod a četnosti, PSYb1170, 2025

**Soubor:** [PSYb1170_P01_2025_-_Uvod__cetnosti.pptx](../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/PSYb1170_P01_2025_-_Uvod__cetnosti.pptx); 69 snímků. Prezentace uvádí Stanislava Ježka a Jana Širůčka. Slouží k pochopení dosavadních priorit autora, nikoli jako ověřená náhrada učebnice.

| Snímky | Obsah a využití |
|---|---|
| 1–12 | Představení kurzu, učení, podmínky a literatura; organizační historii nepřenášet do nových skript. |
| 13–21 | Smysl analýzy dat, validita závěrů, aplikace a statistická gramotnost; napojení na Utts. |
| 22–30 | Ukázková data, proměnné, úrovně měření a příklady jejich rozlišování. |
| 31–38 | Datová matice, názvy proměnných, kódování a chybějící hodnoty. |
| 39–44 | Absolutní, relativní a kumulativní četnosti, tabulka a značení. |
| 45–48 | Intervalové četnosti, četnostní hustota, volba intervalů a jejich hranice. |
| 49–52 | Postup sestavení tabulky; sn. 51 odkazuje na `Datíčka.xls`, list „Četnosti“. |
| 53–61 | Bodové zobrazení, sloupcový graf, histogram, polygon a stonek–list; obrázkové snímky 54, 58–59 doplňují text. |
| 62–69 | Poctivé zobrazení, tvar rozdělení, poloha a variabilita; závěrečné shrnutí. |

**Nálezy:** sn. 46 uvádí Sturgesovo pravidlo s `ln(N)` a koeficientem 3,3; pro tuto hodnotu koeficientu jde o dekadický logaritmus (ekvivalentně přibližně `1 + log₂(N)`). Před převzetím opravit a neprezentovat jako závazné pravidlo volby histogramu. Omezení názvů proměnných na méně než 9 znaků a požadavek výhradně číselných dat (sn. 37–38) nejsou univerzální zásady datové matice. Kód −99 se bez explicitního ošetření může stát běžnou hodnotou ve výpočtu. Indexy a názvy četností sjednotit s [R02](ROZHODNUTI.md#r02-indexy-a-cetnosti), hranice intervalů s [R03](ROZHODNUTI.md#r03-hranice-intervalu).

**Neověřeno:** funkčnost vloženého či odkazovaného sešitu, QR kódů a externích odkazů; `Datíčka.xls` nebyl jako samostatný soubor nalezen v inventáři `sources/`. Nebyla provedena úplná kontrola každé historické tabulky ani správnosti všech výukových zkratek o měření.

<a id="p02"></a>

### P02 — Popisné statistiky, PSYb1170, 2026

**Soubor:** [PSYb1170_P02_2026_-_Popisne_statistiky.pptx](../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/PSYb1170_P02_2026_-_Popisne_statistiky.pptx); 53 snímků.

| Snímky | Obsah a využití |
|---|---|
| 3–13 | Popis a tvary rozdělení; grafické porovnávání. |
| 14–21 | Modus, medián, průměr, vztah k tvaru; příklady k diskusi. |
| 22–30 | Variabilita: entropie (rozšíření), rozpětí, kvartily, rozptyl, SD a souvislost s tvarem. |
| 31–34 | Boxplot, konstrukce, odlehlé hodnoty a čtení grafu. |
| 35–39 | Účinky lineární transformace; poloha jako minimalizace různých ztrát; momentové a pořadové statistiky. |
| 40–44 | Percentily, významy „kvartilu“, algoritmy kvantilů a interpolace; medián z intervalových četností. |
| 45–48 | Popis pomocí empirického rozdělení a pomocí modelu, příklady parametrických modelů. |
| 49–53 | Volba a reportování popisných statistik, shrnutí a ilustrační závěrečný obrázek. |

**Nálezy:** sn. 27 má pro třetí kvartil `0,75(N + 1) + 1`, zatímco sn. 24 používá `0,75(N − 1) + 1`; před použitím srovnat s projektovým algoritmem R04. „Diskrétní“ postup na sn. 42 není obecně totožný s projektovým kvantilem pro ordinální data. Sn. 29 odvozuje označení špičatosti z porovnání IQR a 2 SD; není to obecná definice koeficientu špičatosti. Používat R14 a současnou kapitolu 3.

**Ověření obrázku:** sn. 43 skutečně obsahuje 11 hodnot, začíná číslem 3 a následně 7, 9, 9. V textové extrakci první číslo chybělo. Nejde tedy o doloženou chybu počtu hodnot ani čtvrté pořadové hodnoty. Tento případ ukazuje nutnost ověřovat podezřelé nálezy vizuálně.

**Neověřeno:** kompletní početní audit všech vzorců a modelových příkladů, externí příklady a odkazy. Starší označení `MAD`, `M`, `SD` převádět podle R01; nelze je bez rozlišení přepsat do výpočetního značení knihy.

<a id="p03"></a>

### P03 — Transformace a rozdělení pravděpodobnosti, PSYb1170, 2026

**Soubor:** [PSYb1170_P03_2026_-_Transformace__rozdeleni_pravdedpodobnosti_.pptx](../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/PSYb1170_P03_2026_-_Transformace__rozdeleni_pravdedpodobnosti_.pptx); 60 snímků.

| Snímky | Obsah a využití |
|---|---|
| 3–13 | Interpretace skóru, lineární transformace, centrování, standardizace, T a IQ. |
| 14–21 | Nelineární a pořadové transformace, percentilové pořadí, normalizace. |
| 22–26 | Pravděpodobnost a nejistota, převod na šance, příklad přecházení vozovky, různá pojetí pravděpodobnosti. |
| 27–32 | Jevy, náhodné pokusy a proměnné, sjednocení, průnik a nezávislost. |
| 33–44 | Diskrétní a spojitá rozdělení, hustota, CDF, empirický a teoretický popis. |
| 45–54 | Normální rozdělení, PDF a CDF, vlastnosti, různé parametry, plochy, Excel a historické tabulky. |
| 55–57 | Příklad délky ukazováčku, posouzení normálního modelu a Q–Q graf. |
| 58–60 | Normalizace, steny a staniny, shrnutí a statistické značení. |

**Doporučené použití:** kontinuita mezi již napsanou kapitolou 4 a plánovanou pravděpodobností; nabídka motivačních příkladů. Původní prezentace tato témata spojuje, současná osnova je rozděluje.

**Nálezy:** sn. 52 nazývá výsledek `NORM.S.DIST` kvantilem, ačkoli jde o hodnotu distribuční funkce; kvantil vrací inverzní funkce. Totéž rozlišení je nutné při čtení sn. 39 a 51. U sn. 27–28 zpřesnit rozdíl mezi prostorem výsledků, výsledkem a jevem. Sn. 56 nabízí obecné meze koeficientů jako vodítko k normalitě; samy neprokazují vhodnost normálního modelu. Sn. 38 vyžaduje při dalším použití podrobnou kontrolu výkladu hustoty: plocha intervalu se obecně nerovná výšce v jediném bodě krát délka intervalu.

**Neověřeno:** všechny koeficienty, historické údaje, odkazované video, externí kalkulátory a QR kódy. Příklad délky prstu je zadán s modelovým předpokladem; nedokládá empirickou normalitu této vlastnosti.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** z aktuálního PPTX znovu přečteny sn. 22–44 i dostupné poznámky; sn. 22–40 prohlédnuty v existujícím exportu. Doplňkové využití: nejistota, převod pravděpodobnosti na šance a přechod od dat k modelu. Sn. 28 vyžaduje opravu: nezávislost opakování není součástí obecné definice náhodného pokusu a náhodná proměnná nevzniká teprve opakováním ani není totožná se sloupcem pozorovaných dat. Na sn. 38 nepřebírat označení likelihood jako matematicky volného synonyma plauzibility; věrohodnost má přesný statistický význam. Šance, poměr šancí i další názvy zůstávají návrhy k dohodě.

<a id="p04"></a>

### P04 — Normální rozdělení, STPS 2025

**Soubor:** [normal_distribution.pptx](../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/normal_distribution.pptx); 22 snímků. Titul uvádí „STPS 2025“; autorství není na titulním snímku jednoznačně doloženo.

| Snímky | Obsah a využití |
|---|---|
| 2–8 | Smysl a vlastnosti normálního modelu, CLT, rozlišení populace, dat a výběrového rozdělení; plochy pod křivkou. |
| 9–12 | z-skór, lineární transformace, příklad YSR, interval prostředních 95 % hodnot. |
| 13–14 | Histogram, Q–Q graf, testy normality a obrazové příklady odchylek. |
| 15–17 | z, T, IQ, percentily, steny, staniny a jejich interpretace. |
| 18–20 | Shrnutí pojmů a funkcí Excelu. |
| 21–22 | Tabulka normálních kvantilů a konstrukční pozice pro graf. |

**Nálezy:** sn. 4 uvádí špičatost normálního modelu 0 bez rozlišení excessu; běžný čtvrtý standardizovaný moment je 3. Sn. 5 vynechává podmínky CLT a rozlišení toho, čeho se týká normalita v různých metodách. Tabulka na sn. 21 používá označení „interval spolehlivosti“ pro interval vymezený kvantily rozdělení hodnot; tyto pojmy nezaměňovat. Ve sn. 15–17 odlišit percentil od percentilového pořadí a interval z-skórů od jediné hodnoty pořadí.

**Neověřeno:** empirická opora tvrzení o normalitě psychologických rysů a skutečné normy testu YSR ve sn. 11. Parametry příkladu nepředstavovat jako ověřená diagnostická doporučení. Výpočty a konstrukční formule sn. 21–22 nebyly kompletně přepočítány.

<a id="p05"></a>

### P05 — Pravděpodobnost, STPS 2025

**Soubor:** [probability.pptx](../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/probability.pptx) (místní neveřejný podklad); 36 snímků, žádný označený jako skrytý. Titul uvádí „Pravděpodobnost“ a „STPS 2025“. Metadata PPTX uvádějí autora Karla Rečku a poslední změnu 19. prosince 2025; nejde o nezávislé ověření autorství všech převzatých příkladů a obrázků.

**Datum a verze průzkumu:** 11. října 2026, SHA-256 prefix `3f65f85091f08242`.

| Snímky | Obsah a využití |
|---|---|
| 1–3 | Úvod, analytické, četnostní a subjektivní pojetí; příklad populace 100 lentilek. |
| 4–7 | Náhodný pokus, jev a proměnná, nezávislost, výlučnost a doplněk; společná, podmíněná a marginální pravděpodobnost a sjednocení. Kontingenční tabulka rodičovství a používání pásů. |
| 8–13 | Součtové a součinové pravidlo, karty; srovnání nezávislosti a závislosti v tabulkách pohlaví a stresu. |
| 14–19 | Prostor výsledků, rozdělení, diskrétní a spojité proměnné, hustota a shrnutí. Sn. 17 zobrazuje odpovědi na položku kvality života, sn. 18 hustotu věku matky při narození prvního dítěte; obrázky nesou označení Cengage Learning 2013. |
| 20–23 | Faktoriál, uspořádaný a neuspořádaný výběr bez opakování; loterie se třemi různými nebo stejnými cenami pro 100 studentů. |
| 24–28 | Bayesova věta, prior, posterior a věrohodnost; dopingový test, senzitivita, specificita, prediktivní hodnoty a přepis do přirozených četností pro 1 000 osob. |
| 29–31 | Binomické rozdělení a jeho předpoklady; dvě šestky v pěti hodech, deset možných rozmístění úspěchů. |
| 32–35 | Normální aproximace binomického rozdělení; sn. 33 je obrazová tabule histogramů 10 000 výběrových podílů pro různá p a n. Převod počtu na podíl a příklad alespoň 135 úspěchů z 200 při p = 0,6. |
| 36 | Funkce Excelu: FAKTORIÁL, PERMUTACE, KOMBINACE, BINOM.DIST a BINOM.INV. |

**Doporučené použití:** podklad k dosavadním obsahovým prioritám autora pro další kapitolu o pravděpodobnosti; zejména srovnání typů pravděpodobností v jedné tabulce (sn. 7), dvojice tabulek nezávislosti a závislosti (sn. 12–13) a převod Bayesova výpočtu na přirozené četnosti (sn. 26–28). Kombinatorika, binomický model a aproximace jsou nabídkou navazujících témat, nikoli schváleným rozsahem kapitoly. Při použití porovnat s U01 kap. 5 a U10 kap. 3–7; Howell zůstává hlavním východiskem. Označení a symboly prezentace nejsou automaticky schválenou konvencí učebnice.

**Prostudováno:** text všech 36 snímků včetně matematických objektů a dostupných poznámek podle vazeb PPTX; všechny snímky vyexportovány PowerPointem a prohlédnuty na čtyřech kontaktních listech. Sn. 34 navíc prohlédnut samostatně kvůli spornému vzorci. Obrazový sn. 33 tedy není prázdný, přestože textová extrakce nevrací obsah.

**Nezávislé výpočty:** v Pythonu ověřeny počty 970 200 a 161 700 pro loterii (sn. 21–23), podíly 95/185 = 0,513513… a 810/815 = 0,993865… (sn. 26–28), binomická pravděpodobnost dvou šestek 0,160751… (sn. 30–31) a příklad sn. 35 součtem binomických pravděpodobností i normální aproximací. Nejde o ověření všech výpočtů ani funkcí Excelu.

**Nálezy a podmínky dalšího použití:**

- **Sn. 3:** u zelených lentilek je četnost 16, ale pravděpodobnost 13/100 = 13 %. Při rovnoměrném výběru jedné lentilky má být 16/100 = 16 %; nesoulad je i ve vykreslené tabulce.
- **Sn. 2, 4, 14–16 a 19:** před převzetím zpřesnit rozdíl mezi výsledkem a jevem a mezi diskrétním rozdělením a spojitou hustotou. „Malý počet hodnot“ není obecná definice diskrétnosti; může jít i o spočetně nekonečný soubor hodnot. Tvrzení, že pravděpodobnost 0 znamená nemožnost, nelze bez omezení přenést na spojité modely. Práce s výběry sama nezdůvodňuje výhradní volbu četnostního pojetí. U tabulek sn. 12–13 rozlišit popis dané tabulky od závěru o populaci.
- **Sn. 20–23:** pojmenování uspořádaného výběru „permutace“ je třeba před českým výkladem terminologicky dohodnout (běžné české rozlišení variací a permutací). Poznámka sn. 20 mylně opakuje „permutace“ i pro výběr bez ohledu na pořadí. Na sn. 22 v mezikroku 100!/97! chybí faktor 3! ve jmenovateli; konečný výsledek 161 700 je správný.
- **Sn. 25–28:** poznámku sn. 25 o Bayesově větě jako „váženém průměru“ nepřebírat jako obecné vysvětlení aktualizace. Na sn. 26 má druhý člen jmenovatele symbolického vzorce obsahovat pravděpodobnost pozitivního testu při **nedopování**; v originále je opět „dopuje“. Číselné dosazení používá správně 0,10. Podíl 95/185 se na tři desetinná místa zaokrouhluje na **0,514**, nikoli 0,513; doplněk na 0,486. Na sn. 27 je 0,994 správné zaokrouhlení, ale odpovídající procento je přibližně **99,4 %**, nikoli 99,6 %.
- **Sn. 30–31:** přesný výsledek je přibližně 0,160751; 0,16 je vhodná hrubá aproximace, ale mezikrok 0,016 je již zaokrouhlený a nemá se vydávat za přesnou rovnost.
- **Sn. 34:** vzorec směrodatné odchylky počtu je správný. Po převodu na podíl však N nezmizí: směrodatná odchylka je √[p(1 − p)/N], nikoli uvedené √[p(1 − p)]. Plyne to z dělení směrodatné odchylky počtu číslem N. Chyba potvrzena v samostatném exportu snímku.
- **Sn. 35:** zadání požaduje 135 a více úspěchů, ale čitatel z-skóru obsahuje 130 − 120. Hodnota přibližně 2,16 odpovídá 135, nikoli 130 (pro 130 vychází přibližně 1,44). Přesný binomický výsledek pro zadanou otázku je 0,017307…; normální aproximace bez korekce na spojitost 0,015191… a s hranicí 134,5 přibližně 0,018179…. Rozdíl popsat jako aproximaci, nikoli jako přesnou shodu.

**Neověřeno:** úplná odborná revize každého tvrzení, všech poznámek a výpočtů; původ a oprávnění k dalšímu použití převzatých obrázků a dat; živé animace a externí odkazy. Funkce, české názvy, syntaxe a výsledky sn. 36 nebyly spuštěny v Excelu ani nově ověřeny v jeho dokumentaci. Originál prezentace zůstal beze změny; tato karta není jeho opravenou verzí ani schválením nových termínů.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** z aktuálního PPTX znovu přečten všech 36 snímků a dostupné poznámky; všechny snímky prohlédnuty na čtyřech existujících kontaktních listech. Srovnání s U01 s. 113 a 121–122 doložilo původ tabulky rodičovství/pásy a dopingového příkladu. Přesnou racionální aritmetikou znovu ověřeno 95/185 a 810/815; při modelové změně prevalence na 1 % za stejné senzitivity 0,95 a specificity 0,90 je pozitivní prediktivní hodnota 95/1085 = 0,087558… (četnosti pro 10 000 osob). Jde o návrh doplnění vlivu základního výskytu, nikoli schválenou úlohu ani empirickou vlastnost testu. Ověřen také příklad dvou šestek z pěti hodů: 10 × (1/6)^2 × (5/6)^3 = 0,160751…; Excel nebyl spuštěn.

**Použití v kapitole 5 (2026-10-12):** kostra kapitoly odpovídá pořadí snímků; chyby uvedené v této kartě převzaty nebyly (lentilky, jmenovatel sn. 26, zaokrouhlení 0,514 a 99,4 %, směrodatná odchylka podílu, čitatel sn. 35). Dvojice tabulek pohlaví × stres (sn. 12–13) je průběžným příkladem; příklad 135 a více z 200 (sn. 35) je uveden s přesnou hodnotou 0,0173, aproximací 0,0152 a hodnotou od hranice 134,5. Uspořádaný výběr se v textu nazývá variace bez opakování (R23), loterie ze sn. 21–23 je v nepovinném rozšíření s jinými částkami. Pojem věrohodnosti ze sn. 24–25 se nezavádí (R21). Funkce ze sn. 36 byly skutečně spuštěny v českém Excelu.

## Procvičování a seminář

Identifikátor úlohy vyhledej v příslušném DOCX. Obvykle se vyskytuje jednou v zadání a podruhé v oddílu řešení. Mezery v číselné řadě jsou součástí originálu. Byly přečteny texty a tabulky všech tří souborů; vložené obrázky byly prohlédnuty samostatně. **Všechna řešení nebyla nezávisle přepočítána.** Zjištěné konkrétní chyby níže neznamenají, že zbytek klíče je ověřený.

<a id="c01"></a>

### C01 — Úlohy, týden 1, 2025

**Soubor:** [ulohy_tyden01_2025.docx](../sources/p%C5%99%C3%ADklady%20k%20procvi%C4%8Dov%C3%A1n%C3%AD/ulohy_tyden01_2025.docx). Hlavní přínos: převod slovního popisu do proměnných, rozhodování o kódování a čtení rozdělení. Bibliografické autorství a přesný původ jednotlivých úloh nejsou spolehlivě doloženy jen názvem souboru.

| Identifikátory | Obsah a použití |
|---|---|
| X1_01–03 | Úrovně měření, změna úrovně při úpravě dat, kódování příjmu. |
| X1_05–06 | Zásady matice, konstrukce a interpretace škál; vhodné k diskusi o tom, co čísla znamenají. |
| X1_07–08 | Vyplněné dotazníky jako obrázky → datová matice; více odpovědí oproti jediné volbě, nejednoznačné odpovědi. |
| X1_09–10 | Souhrnná klasifikace proměnných; externí data o přecházení vozovky. |
| X2_01–03 | Četnosti z malých dat, individuální a intervalové četnosti, histogramy, přiřazení grafů školním výsledkům. |
| X2_06–07 | Osy grafu a zpětné usuzování na původní hodnoty z histogramu. |
| X2_11, X2_20 | Sloupcový graf versus histogram; práce s externími daty o přednosti na přechodu. |
| X1_100; „SPRÁVNÁ ŘEŠENÍ“ | Terminologické opakování a klíč k předchozím úlohám. |

**Nálezy a podmínky:** v X1_06 počet bodů či jemnost posuvníku samy nezaručují intervalovou úroveň měření. U odpovědí 0/1 záleží na významu kódu. Při úpravě úloh o histogramu zachovat rozlišení četnosti a hustoty i pro nestejné šířky intervalů.

**Neověřeno / chybí:** samostatná data k X1_10 a X2_20 nebyla v inventáři nalezena; studenti proto tato zadání nemohou převzít beze změny. Původ a status skutečných či simulovaných dat, všechny numerické výsledky a autorská práva k obrázkům nebyly ověřeny.

<a id="c02"></a>

### C02 — Úlohy, týden 2, 2026

**Soubor:** [ulohy_tyden02_2026.docx](../sources/p%C5%99%C3%ADklady%20k%20procvi%C4%8Dov%C3%A1n%C3%AD/ulohy_tyden02_2026.docx). Hlavní přínos: porovnávání rozdělení, citlivost charakteristik, kvantily, transformace a argumentace o variabilitě.

| Identifikátory | Obsah a použití |
|---|---|
| X2_04–05, X2_08–10 | Tvar rozdělení a přiřazování histogramů; X2_04 navazuje na data X2_03 z C01. |
| X2_12–18 | Sumace, průměr, medián, modus, vliv změn hodnot, vážený průměr, součty a rozdíly. |
| X2_21–23 | Kvantily, decily a percentilové pořadí z dat a četností. |
| C2_02–06 | Anglická zadání o průměru, mediánu a kvantilech s odkazy na stránky zdroje označeného C. |
| X2_24–27 | Rozpětí, suma čtverců, rozptyl, SD, velikost výběru a lineární transformace. |
| X2_28–32 | IQR, vztah průměru a SD k pokrytí, transformace a minimalizace součtu čtverců. |
| X2_33–35 | Čtení a konstrukce boxplotu, optimismus a variabilita výkonu paměťových skupin. |
| C2_07–08; X2_100; „ŘEŠENÍ“ | SD, nezkreslenost, slovníček a klíč. |

**Potvrzený početní/notační rozpor:** X2_24 se ptá na součet druhých mocnin původních hodnot 40, 45, 50, tedy 6125; klíč uvádí 50, což je součet čtverců **odchylek od průměru 45**. Obě hodnoty byly nezávisle přepočítány. Oprava musí sladit zadání, značení a řešení, ne pouze nahradit číslo.

**Další místa k revizi:** X2_17 má v odpovědi opačné označení směru rozdílu oproti zadání; X2_21 zaměňuje označení pátého decilu za D1 a staré kvantilové postupy je třeba převést podle R04. Výukový příklad X2_29 je užitečný právě tím, že samotné m a s neurčují přesný podíl hodnot v intervalu.

**Neověřeno:** všechna řešení včetně grafických, přesné vydání a původ úloh C2. Jejich staré odkazy na strany se nesmějí automaticky připsat místnímu Cummingovi, 2. vydání. Údaje o původu použitých dat je třeba došetřit před převzetím.

<a id="c03"></a>

### C03 — Úlohy, týden 3, 2024

**Soubor:** [ulohy_tyden03_2024.docx](../sources/p%C5%99%C3%ADklady%20k%20procvi%C4%8Dov%C3%A1n%C3%AD/ulohy_tyden03_2024.docx). Hlavní přínos: převody skórů, slovní úlohy na pravděpodobnost a interpretace ploch normálního modelu.

| Identifikátory | Obsah a použití |
|---|---|
| X3_01–02 | Pořadí, percentilové pořadí, lineární a nelineární transformace, centrování a z-skóry. |
| X3_03–07 | z, T, IQ, zpětný výpočet původního skóru a porovnávání relativní pozice. |
| X3_08–20 | Jevy a možné výsledky, mince, kostky, nezávislost, hádání odpovědí a karty; zásobník pro kapitolu o pravděpodobnosti. |
| X3_21–27 | Normální model, IQ a čtení, populační podíly, plochy a nestejné změny percentilového pořadí při stejných rozdílech skóru. |
| X3_28–30 | Kvantily, odvození SD z percentilů, známkování podle modelu. |
| X3_31–33 | Počet úspěchů při hádání, normální aproximace, Excel a meze pro výběr osob. |
| X3_34–37 | Porovnání talentů, podíly mezi skóry a další interpretace normální křivky. |
| C3_01–03 | Flynnův efekt a návazné příklady; historické anglické úlohy s odkazy na strany zdroje C. |
| X3_100; oddíl řešení | Pojmy a odpovědi. |

**Potvrzené rozpory:** X3_01 uvádí v datech 500, zatímco tabulka řešení pracuje s 50; zamýšlenou vstupní hodnotu je nutné rozhodnout před použitím. V X3_28 jsou v klíči obrácená znaménka nenulových kvantilů. Nezávislý výpočet standardním normálním modelem dává přibližně: p = 0,16 → −0,994; 0,84 → +0,994; 0,05 → −1,645; 0,005 → −2,576; 0,995 → +2,576; 0,10 → −1,282.

**Odchylky od projektu:** X3_02 používá postup percentilového pořadí se jmenovatelem n + 1; není to současný empirický podíl hodnot menších nebo rovných podle R04. V X3_31 musí být odlišena přesná binomická pravděpodobnost od normální aproximace. Při převzetí převodů skórů určit, zda je SD populační parametr, nebo výběrová charakteristika.

**Neověřeno:** celý klíč, aktuálnost empirických tvrzení a právních souvislostí Flynnova efektu, přesné vydání úloh C3, původ dat a normy testů. Modelový výpočet četnosti IQ v Brně není zjištěný počet skutečných obyvatel s danou vlastností.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** znovu přečtena zadání X3_08–20. Pro návrh využitelné jsou doplněk, alespoň jeden výskyt, nezávislé hody a hádání odpovědí; u hádání je třeba výslovně zadat počet správných alternativ, způsob volby a nezávislost. Nejde o novou úplnou kontrolu řešení ani schválení převzetí celé sady.

**Použití v kapitole 5 (2026-10-12):** úlohy nebyly převzaty doslova. Náměty doplňku, „alespoň jednou“, nezávislých tipů a výběru bez vracení jsou v autorských cvičeních 2, 4 a 9; X3_31 je základem cvičení 11 s výslovně odlišenou přesnou binomickou hodnotou (0,0018), normální aproximací (0,0013) a hodnotou od hranice 64,5 (0,0019). Pojem „pole jevů“ z X3_09 se nepoužívá (R23).

<a id="c04"></a>

### C04 — Seminář 4, 2024

**Soubor:** [Seminar4_-_na_zed_-_2024.pptx](../sources/p%C5%99%C3%ADklady%20k%20procvi%C4%8Dov%C3%A1n%C3%AD/Seminar4_-_na_zed_-_2024.pptx); 9 snímků. Text všech snímků i celá obrazová přehledová sestava byly prohlédnuty.

| Snímky | Obsah a využití |
|---|---|
| 1–2 | Zbyněk: hudební a matematické nadání, porovnání původních bodů a z-skórů; sn. 2 obsahuje převodní obrázek. |
| 3–4 | Zbyšek: IQ 115 a 90. percentil kreativity, včetně nenormálního rozdělení druhé proměnné. |
| 5 | Zdeněk: T = 65 a 90. percentil jiné schopnosti; porovnání relativního postavení. |
| 6–8 | CDF a inverzní funkce v Excelu; předpověď výsledku před výpočtem, včetně otázky na `NORM.S.INV(0)`. |
| 9 | Zuzana a Zdena: stejné rozdíly T-skórů na různých místech rozdělení → rozdílné podíly mezi nimi. |

**Nálezy:** sn. 6 označuje výsledek CDF jako kvantil; zpřesnit podobně jako P03. Ve sn. 5 je v závěrečné otázce jiné jméno než v zadání. Inverzní normální funkce nemá pro p = 0 konečný kvantil; před případným zařazením ověřit přesné chování použitého Excelu.

**Neověřeno:** příklady nebyly spuštěny v Excelu; převodní obrázky a testové normy nejsou nezávisle validovány. Úlohy dovolují porovnat relativní umístění v daných rozděleních, nikoli bez dalšího psychometrickou hodnotu různých talentů.

## Další podklady

<a id="d01"></a>

### D01 — Základy tvorby datové matice, DOCX

**Soubor:** [1. Základy tvorby datové matice.docx](../sources/ostatn%C3%AD%20zdroje/1.%20Z%C3%A1klady%20tvorby%20datov%C3%A9%20matice.docx). Metadata uvádějí autora „Rečka Karel“ a poslední změnu 18. 2. 2026; jde o metadata souboru, nikoli důkaz autorství všech vložených částí. Dokument má také PDF protějšek [D02](#d02).

**Prostudováno:** text všech oddílů a dvě vložené ukázky matice a codebooku. Obsah: struktura matice → názvy proměnných a položek → identifikátor → kódování kategorií → chybějící hodnoty → codebook → reverzní položky → shrnutí. Přesnější stránkované lokátory nabízí D02; shodné názvy oddílů lze vyhledat v DOCX.

**Použití:** rozvinutí praktické dovednosti převést dotazník na datovou matici a popsat význam sloupců. Codebook obsahuje mimo jiné proměnnou, nástroj, popis, informaci o reverzním kódování a popisky hodnot.

**Nálezy / neověřeno:** pravidlo vyplňovat chybějící hodnoty −99 je místní konvence a vyžaduje ochranu před zahrnutím do výpočtů. Důvody pro reverzní položky nejsou samy dokladem validity škály. Nebyla provedena úplná znaková ani vizuální shoda DOCX s PDF; při úpravě jednoho formátu ověřit druhý, nepovažovat je automaticky za totožné verze. Neověřeno oprávnění zveřejnit konkrétní vložená data; mapa je nereprodukuje.

<a id="d02"></a>

### D02 — Základy tvorby datové matice, PDF

**Soubor:** [1. Základy tvorby datové matice.pdf](../sources/ostatn%C3%AD%20zdroje/1.%20Z%C3%A1klady%20tvorby%20datov%C3%A9%20matice.pdf); 6 stran. Prostudován text celého PDF, obsahově protějšek D01.

| Lokátor | Obsah a využití |
|---|---|
| [Oddíly 1–2 (PDF 1)](../sources/ostatn%C3%AD%20zdroje/1.%20Z%C3%A1klady%20tvorby%20datov%C3%A9%20matice.pdf#page=1) | Struktura matice, jednotka pozorování, názvy proměnných. |
| [Oddíly 3–6 (PDF 2)](../sources/ostatn%C3%AD%20zdroje/1.%20Z%C3%A1klady%20tvorby%20datov%C3%A9%20matice.pdf#page=2) | Názvy položek, identifikátory, kategorické kódy a chybějící hodnoty. |
| [Codebook (PDF 3)](../sources/ostatn%C3%AD%20zdroje/1.%20Z%C3%A1klady%20tvorby%20datov%C3%A9%20matice.pdf#page=3) | Popis sloupců a kódování; obrazová ukázka. |
| [Reverzní položky, začátek (PDF 4)](../sources/ostatn%C3%AD%20zdroje/1.%20Z%C3%A1klady%20tvorby%20datov%C3%A9%20matice.pdf#page=4) | Význam směru položky a převrácení pomocí minima + maxima − hodnoty. |
| [Reverzní položky, pokračování (PDF 5)](../sources/ostatn%C3%AD%20zdroje/1.%20Z%C3%A1klady%20tvorby%20datov%C3%A9%20matice.pdf#page=5) | Kontext interpretace a sjednocení směru. |
| [Shrnutí (PDF 6)](../sources/ostatn%C3%AD%20zdroje/1.%20Z%C3%A1klady%20tvorby%20datov%C3%A9%20matice.pdf#page=6) | Závěrečná doporučení. |

**Neověřeno:** úplná shoda s DOCX, empirická tvrzení o psychometrických účincích reverzních položek a původ ukázkových dat. Výpočet reverzního skóru není náhradou rozhodnutí, zda se položka pro daný konstrukt má skutečně obracet.

<a id="d03"></a>

### D03 — de Vaus: pravidla kódování a více odpovědí

**Soubor:** [de_Vaus_-_Variable_coding_rules.pdf](../sources/ostatn%C3%AD%20zdroje/de_Vaus_-_Variable_coding_rules.pdf); 9 stran PDF, převážně dvoustrany. Záhlaví uvádí *Analyzing Social Science Data*. Jméno de Vaus plyne z názvu souboru; v úryvku chybí úplná titulní a nakladatelská strana. **Přesné vydání, rok a úplné bibliografické údaje nejsou ověřeny.**

| Lokátor | Obsah a využití |
|---|---|
| [s. 1, kap. 1 „How to code data“ (PDF 1)](../sources/ostatn%C3%AD%20zdroje/de_Vaus_-_Variable_coding_rules.pdf#page=1) | Začátek kódování; první PDF strana obsahuje také předchozí stranu xxiv. |
| [s. 2–9, pokračování kap. 1 (PDF 2)](../sources/ostatn%C3%AD%20zdroje/de_Vaus_-_Variable_coding_rules.pdf#page=2) | Číselné a textové kódy, nezávislost významu a kódu, missing, codebook a kontrola chyb; kap. 1 pokračuje přes PDF 2–5. |
| [s. 10–16, kap. 2 „How to code questions with multiple answers“ (PDF 6)](../sources/ostatn%C3%AD%20zdroje/de_Vaus_-_Variable_coding_rules.pdf#page=6) | Vícenásobné odpovědi, více dichotomických proměnných a více sloupců odpovědí, pořadí, otevřené odpovědi; PDF 6–9. |
| [s. 17, začátek kap. 3 „Can respondents’ answers be relied on?“ (PDF 9)](../sources/ostatn%C3%AD%20zdroje/de_Vaus_-_Variable_coding_rules.pdf#page=9) | Pouze začátek tématu spolehlivosti odpovědí, zbytek kapitoly v souboru není. |

**Prostudováno:** struktura celého úryvku a text kódovacích pravidel a variant více odpovědí. **Použití:** doplněk D01/C01 pro vysvětlení, proč jedna otázka dotazníku nemusí znamenat jeden sloupec.

**Neověřeno:** úplný originál knihy, nepřítomné pokračování kap. 3, všechny softwarem podmíněné rady a početní příklady. Tento soubor není duplicitou D04.

<a id="d04"></a>

### D04 — Morgan a spoluautoři: kontrola dotazníků před vložením dat

**Soubor:** [Variable_coding_rules.pdf](../sources/ostatn%C3%AD%20zdroje/Variable_coding_rules.pdf); sken 8 stran, tištěné s. 15–22. Přidaná anotace na PDF 1 uvádí Morgan, Leech, Gloeckner, „Barret et al.“, *SPSS for Introductory Statistics: Use and Interpretation*, LEA, 2004, ISBN 0-8058-4789-8. **To je údaj z anotace, ne ověření titulní strany; úplný autorský seznam a vydání zůstávají k ověření.**

| Lokátor | Obsah a využití |
|---|---|
| [s. 15, kap. 2 „Data Coding, Entry, and Checking“ (PDF 1)](../sources/ostatn%C3%AD%20zdroje/Variable_coding_rules.pdf#page=1) | Plán, pilotáž a sběr dat. |
| [s. 16–17, obr. 2.1–2.2 (PDF 2)](../sources/ostatn%C3%AD%20zdroje/Variable_coding_rules.pdf#page=2) | Vyplněné dotazníky s nejednoznačnostmi; PDF 2–3. |
| [s. 17–19, „Rules for Data Coding“ (PDF 3)](../sources/ostatn%C3%AD%20zdroje/Variable_coding_rules.pdf#page=3) | Sedm pravidel, jednotné kódy, zachování informace, missing; PDF 3–5. |
| [s. 19, obr. 2.3 (PDF 5)](../sources/ostatn%C3%AD%20zdroje/Variable_coding_rules.pdf#page=5) | Vytvoření kódovacího formuláře. |
| [s. 20–22, „Problem 2.1“ a obr. 2.4 (PDF 6)](../sources/ostatn%C3%AD%20zdroje/Variable_coding_rules.pdf#page=6) | Kontrola problematických odpovědí a komentovaná rozhodnutí; PDF 6–8. |

**Prostudováno:** OCR všech osmi stran a obrazový přehled všech stran; především pravidla a příklady rozhodování. **Použití:** praktická úloha „najdi problém a zdůvodni kódování“.

**Nálezy:** požadavek číselných dat je doporučení v kontextu SPSS. Zdroj připouští prázdné hodnoty i explicitní kódy 98/99, takže se rozchází s bezvýhradným zákazem prázdných buněk v D01. Příklady průměrování dvou označených odpovědí nelze povýšit na obecné pravidlo či automatickou imputaci.

**Neověřeno:** pokračování kapitoly o samotném zadávání a kontrole dat v SPSS v souboru chybí. Ovládání programu nebylo zkoušeno; OCR není spolehlivé pro každý drobný údaj v ručně vyplněných formulářích.

<a id="d05"></a>

### D05 — Lord: statistické zacházení s čísly na dresech

**Soubor:** [On_the_Statistical_Treatment_of_Football_Numbers.pdf](../sources/ostatn%C3%AD%20zdroje/On_the_Statistical_Treatment_of_Football_Numbers.pdf); 2 strany. Frederic M. Lord (1953), *On the statistical treatment of football numbers*, *American Psychologist, 8*(12), 750–751. DOI evidované v projektové bibliografii: 10.1037/h0063675; funkčnost DOI nebyla při tomto průzkumu znovu testována.

**Prostudováno:** celý Lordův text, [s. 750–751 (PDF 1)](../sources/ostatn%C3%AD%20zdroje/On_the_Statistical_Treatment_of_Football_Numbers.pdf#page=1). Na první straně je před Lordovým názvem také závěr jiného textu Jane Loevinger; nepatří Lordovi.

**Obsah a použití:** myšlenkový příklad s náhodným vydáváním čísel, porovnáním výběru a původního souboru a otázkou vztahu statistického postupu k úrovni měření. Vhodný jako autorské pozadí k interpretaci čísel a povaze otázky. Číst společně s D06.

**Omezení:** příběh není oprávnění libovolně průměrovat nominální kódy a interpretovat průměr jako vlastnost osob. Nejde o samostatně dostačující současné shrnutí celé debaty; simulace příběhu nebyla provedena.

<a id="d06"></a>

### D06 — Zand Scholten a Borsboom: reanalýza Lordova argumentu

**Soubor:** [A reanalysis of Lord’s statistical treatment of football numbers.pdf](../sources/ostatn%C3%AD%20zdroje/A%20reanalysis%20of%20Lord%E2%80%99s%20statistical%20treatment%20of%20football%20numbers.pdf); 7 stran. Annemarie Zand Scholten a Denny Borsboom (2009), *A reanalysis of Lord’s statistical treatment of football numbers*, *Journal of Mathematical Psychology, 53*, 69–75. DOI 10.1016/j.jmp.2009.01.002 je vytištěno na PDF 1; číslo 2 je evidováno v `references.bib`, nebylo samostatně ověřeno na vydavatelském webu.

| Lokátor | Obsah a využití |
|---|---|
| [s. 69–70, §1 (PDF 1)](../sources/ostatn%C3%AD%20zdroje/A%20reanalysis%20of%20Lord%E2%80%99s%20statistical%20treatment%20of%20football%20numbers.pdf#page=1) | Přípustné transformace a přehled debaty měření–statistika. |
| [s. 70–71, §1.1–1.2 (PDF 2)](../sources/ostatn%C3%AD%20zdroje/A%20reanalysis%20of%20Lord%E2%80%99s%20statistical%20treatment%20of%20football%20numbers.pdf#page=2) | Rekonstrukce Lordova příkladu a jeho implicitních předpokladů. |
| [s. 71, §2 (PDF 3)](../sources/ostatn%C3%AD%20zdroje/A%20reanalysis%20of%20Lord%E2%80%99s%20statistical%20treatment%20of%20football%20numbers.pdf#page=3) | Co čísla v dané inferenční otázce vlastně reprezentují. |
| [s. 72–73 (PDF 4)](../sources/ostatn%C3%AD%20zdroje/A%20reanalysis%20of%20Lord%E2%80%99s%20statistical%20treatment%20of%20football%20numbers.pdf#page=4) | Zkreslení mechanismu vydávání čísel, obr. 1 a argument o struktuře měřené vlastnosti. |
| [s. 73–74, §4 (PDF 5)](../sources/ostatn%C3%AD%20zdroje/A%20reanalysis%20of%20Lord%E2%80%99s%20statistical%20treatment%20of%20football%20numbers.pdf#page=5) | Závěry pro interpretaci a volbu statistiky. |
| [s. 74–75, Appendix (PDF 6)](../sources/ostatn%C3%AD%20zdroje/A%20reanalysis%20of%20Lord%E2%80%99s%20statistical%20treatment%20of%20football%20numbers.pdf#page=6) | Formální argument s bisymetrickou strukturou; pokročilé autorské pozadí. |

**Prostudováno:** hlavní argument textu a závěr; dodatek byl identifikován a jeho předpoklady prohlédnuty. **Použití:** rozlišení identifikace hráče od inference o mechanismu, který čísla generuje; proč musí otázka, měření a závěr odpovídat sobě navzájem.

**Neověřeno:** úplná nezávislá kontrola formálního důkazu v dodatku a celé navazující literatury. Jde o konkrétní odborný argument v debatě, ne důkaz, že každou praktickou volbu metody jednoznačně určuje jedna položka v tabulce úrovní měření.

<a id="d07"></a>

### D07 — Utts: statistická a pravděpodobnostní gramotnost

**Soubor:** [What educated citizens should know about statistics and probability.pdf](../sources/ostatn%C3%AD%20zdroje/What%20educated%20citizens%20should%20know%20about%20statistics%20and%20probability.pdf); sken 6 stran, tištěné s. 74–79. Jessica Utts (2003), *What educated citizens should know about statistics and probability*, *The American Statistician, 57*(2), 74–79. Identita čtena z první strany; DOI zde není doplněno odhadem.

| Lokátor | Obsah a využití |
|---|---|
| [s. 74–75 (PDF 1)](../sources/ostatn%C3%AD%20zdroje/What%20educated%20citizens%20should%20know%20about%20statistics%20and%20probability.pdf#page=1) | Úvod a přehled sedmi okruhů statistické gramotnosti. |
| [s. 75 (PDF 2)](../sources/ostatn%C3%AD%20zdroje/What%20educated%20citizens%20should%20know%20about%20statistics%20and%20probability.pdf#page=2) | Kauzalita oproti souvislosti; statistická a praktická významnost. |
| [s. 76 (PDF 3)](../sources/ostatn%C3%AD%20zdroje/What%20educated%20citizens%20should%20know%20about%20statistics%20and%20probability.pdf#page=3) | Nevýznamný výsledek versus nepřítomnost účinku; zkreslení; náhodné shody. |
| [s. 77–78 (PDF 4)](../sources/ostatn%C3%AD%20zdroje/What%20educated%20citizens%20should%20know%20about%20statistics%20and%20probability.pdf#page=4) | Náhodné shody a obrácené podmíněné pravděpodobnosti. |
| [s. 78 (PDF 5)](../sources/ostatn%C3%AD%20zdroje/What%20educated%20citizens%20should%20know%20about%20statistics%20and%20probability.pdf#page=5) | Variabilita, běžné versus neobvyklé hodnoty a závěr. |
| [s. 78–79 (PDF 5)](../sources/ostatn%C3%AD%20zdroje/What%20educated%20citizens%20should%20know%20about%20statistics%20and%20probability.pdf#page=5) | Závěr a literatura, pokračování na PDF 6. |

**Prostudováno:** OCR celého článku; hlavní příklady a seznam témat. **Použití:** průřezová kontrola, zda cíle a cvičení rozvíjejí rozpoznání chybných závěrů, nejen výpočet.

**Neověřeno:** původní data a následný vývoj citovaných studií, všechny drobné údaje v obrazových částech skenu. Historické příklady nejsou automaticky současná medicínská či jiná odborná doporučení. Textová vrstva samotného PDF téměř nezachycuje článek; při přesné citaci použít obraz strany, nikoli nekontrolované OCR.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** přečteno OCR s. 77–78 (PDF 4–5), zejména oddíly 7–8 o náhodných shodách a záměně obrácených podmíněných pravděpodobností. Podnět pro rozlišení předem určené události a některé z mnoha možných shod. Bez nového vizuálního ověření OCR a bez aktualizace empirických či demografických údajů; tyto údaje se do návrhu nepřebírají.

**Použití v kapitole 5 (2026-10-12):** s. 77–78 prohlédnuty v obraze. Ověřeno: oddíl o záměně obrácených podmíněných pravděpodobností, studie se 100 lékaři (odpovědi kolem 75 % při správné hodnotě přibližně 7,5 %) a doporučení tabulky s počty pro pomyslnou skupinu lidí. DOI 10.1198/0003130031630, ročník 57, číslo 2, s. 74–79 ověřeny v metadatech Crossref a zapsány do společné bibliografie. Empirické údaje článku se do kapitoly nepřebírají.

<a id="d08"></a>

### D08 — Baron: normativní teorie pravděpodobnosti

**Soubor:** [Baron_-_kap5_-_probability_rkhanxjn.pdf](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap5_-_probability_rkhanxjn.pdf); 34 skenovaných stran. Kap. 5 má název *Normative theory of probability*, začíná tištěnou s. 103 a text končí na s. 135 (PDF 33); PDF 34 je prázdná. **Jméno Baron plyne z názvu souboru; titul celé knihy, vydání, rok a úplná bibliografická identita nejsou v úryvku ověřeny.**

| Lokátor | Obsah a využití |
|---|---|
| [s. 103–106 (PDF 1)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap5_-_probability_rkhanxjn.pdf#page=1) | Proč normativně hodnotit úsudky, číselné pravděpodobnosti a jejich komunikaci. |
| [s. 106–111, „What is probability?“ (PDF 4)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap5_-_probability_rkhanxjn.pdf#page=4) | Četnostní, logické a osobní pojetí pravděpodobnosti. |
| [s. 112–118 (PDF 10)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap5_-_probability_rkhanxjn.pdf#page=10) | Konstrukce úsudku, sázky, koherence a pravidla pravděpodobnosti. |
| [s. 118–121, „Evaluating probability judgments“ (PDF 16)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap5_-_probability_rkhanxjn.pdf#page=16) | Kalibrace, informační hodnota a skórovací pravidla; tab. 5.1 na s. 120. |
| [s. 121–126, „Bayes’s theorem“ (PDF 19)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap5_-_probability_rkhanxjn.pdf#page=19) | Diagnostický příklad, přirozené četnosti, strom, vzorce a poměr šancí; obr. 5.2 na s. 125. |
| [s. 126–129 (PDF 24)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap5_-_probability_rkhanxjn.pdf#page=24) | Proč mají četnosti význam, aktualizace a meze účelného použití Bayesovy věty. |
| [s. 130–132 (PDF 28)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap5_-_probability_rkhanxjn.pdf#page=28) | Náhodné shody, hledání vzorců po zhlédnutí dat a problém tří dveří. |
| [s. 133–135 (PDF 31)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap5_-_probability_rkhanxjn.pdf#page=31) | Více znaků, podmíněná nezávislost, diagnostické sítě, řešení příkladů a závěr. |

**Prostudováno:** členění celého úryvku pomocí OCR; podrobněji pasáže k pojetí pravděpodobnosti, koherenci a Bayesově větě, včetně vizuální kontroly s. 119–126. Zbylé části byly obsahově prohlédnuty, nikoli všechny řádek po řádku ověřeny.

**Použití:** psychologická motivace pro pravděpodobnost jako práci s nejistotou, přechod od četností k podmínění a ukázka rozdílu mezi koherentním a dobře kalibrovaným úsudkem. Vyžaduje nejprve zavést jevy, podmínění a základní pravidla.

**Odchylky / neověřeno:** autor obhajuje osobní pojetí; to je stanovisko zdroje, ne neutrální přepis všech interpretací. Diagnostické četnosti v příkladech jsou historická výuková zadání, nikoli ověřené současné parametry testů. OCR vzorců je místy porušené; všechny vzorce, skórovací pravidla, diagnostické sítě a bibliografická identita vyžadují před konkrétním použitím kontrolu originálu.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** přečteno OCR s. 121–123 (PDF 19–21), s. 122 navíc zkontrolována v obrazu. Využitelný je postup nejprve přirozené četnosti a tabulka, potom strom a symbolický vztah. Klinické hodnoty příkladu nejsou tímto ověřeny pro současnou praxi; neověřená bibliografická identita celého úryvku trvá.

**Použití v kapitole 5 (2026-10-12):** s. 121–123 prohlédnuty v obraze: příklad se 100 ženami, tabulka počtů, strom a teprve potom vzorec. Kapitola cituje jen tento postup, nikoli klinické hodnoty. **Bibliografická identita ověřena mimo úryvek:** Jonathan Baron, *Thinking and Deciding*, 4. vydání, Cambridge University Press; rok 2008 a označení vydání podle záznamu Kongresové knihovny pro ISBN 978-0-521-68043-1; DOI knihy 10.1017/CBO9780511840265; metadata Crossref uvádějí kapitolu „Normative theory of probability“ na s. 103–136 a „Descriptive theory of probability judgment“ na s. 137–160, což odpovídá stránkování úryvků. Metadata vydavatele uvádějí odlišné datum 2006; v bibliografii je rok 2008. Copyrightová strana knihy nebyla k dispozici.

<a id="d09"></a>

### D09 — Baron: deskriptivní teorie pravděpodobnostních úsudků

**Soubor:** [Baron_-_kap6_-_probability_desc.pdf](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap6_-_probability_desc.pdf); sken 24 stran, tištěné s. 137–160, kap. 6 *Descriptive theory of probability judgment*. Bibliografické omezení je stejné jako u D08; shoda tematické a stránkové návaznosti sama neověřuje vydání celé knihy.

| Lokátor | Obsah a využití |
|---|---|
| [s. 137–139 (PDF 1)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap6_-_probability_desc.pdf#page=1) | Odhady četností; srovnání odhadovaného a skutečného výskytu událostí. |
| [s. 139–146 (PDF 3)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap6_-_probability_desc.pdf#page=3) | Kalibrace, nepřiměřená jistota, obtížnost úloh, experti, důvody proti vlastnímu závěru a rozklad úsudku. |
| [s. 146–150 (PDF 10)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap6_-_probability_desc.pdf#page=10) | Reprezentativnost; Tom W. s. 147, základní četnosti a taxík s. 149–150. |
| [s. 150–152 (PDF 14)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap6_-_probability_desc.pdf#page=14) | Záměna podmíněných pravděpodobností, konjunkční klam a Linda. |
| [s. 152–153 (PDF 16)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap6_-_probability_desc.pdf#page=16) | Hráčský klam a přizpůsobování četnosti voleb pravděpodobnostem. |
| [s. 153–156 (PDF 17)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap6_-_probability_desc.pdf#page=17) | Dostupnost, stromy možných příčin a odhad vlastního příspěvku. |
| [s. 156–157 (PDF 20)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap6_-_probability_desc.pdf#page=20) | Subaditivita a vliv popisu kategorií. |
| [s. 157–159 (PDF 21)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap6_-_probability_desc.pdf#page=21) | Zpětné zkreslení, práce s alternativami a chybné průměrování pravděpodobností. |
| [s. 159–160 (PDF 23)](../sources/ostatn%C3%AD%20zdroje/Baron_-_kap6_-_probability_desc.pdf#page=23) | Závěr: interpretace chyb a možnosti vzdělávání. |

**Prostudováno:** struktura celého úryvku a hlavní výklady/příklady pomocí OCR; obrazově zejména s. 145–152. **Použití:** konceptuální otázky a psychologické příklady, které propojují formální pravidla s úsudkem.

**Nálezy / neověřeno:** výraz „confidence interval“ na s. 139 označuje zde subjektivní interval úsudku; nelze bez vysvětlení převzít jeho pravděpodobnostní interpretaci do frekventistického intervalu spolehlivosti. Neověřeny původní experimenty, replikace, současná empirická podpora jednotlivých vysvětlení, všechny číselné údaje a původní bibliografie. Zdrojem je historická kapitola, nikoli aktualizovaný systematický přehled.

**Doplnění při přípravě kapitoly 5 (2026-10-11):** přečteno OCR s. 150–152 (PDF 14–16): obrácené podmínění, konjunkční klam a hráčský klam. Vlastní didaktické příklady lze v návrhu připojit přímo k příslušným pravidlům pravděpodobnosti. Neproběhla nová vizuální kontrola těchto stran ani ověření původních studií; historická vysvětlení mechanismů nevydávat za nový přehled empirických poznatků.

**Použití v kapitole 5 (2026-10-12):** s. 149–152 prohlédnuty v obraze. Citováno: zanedbání základních četností a úloha o taxících s. 149–150, záměna podmíněných pravděpodobností s. 150, konjunkční klam s. 150–152, hráčský klam s. 152. Vinětka o Lindě převzata nebyla; kapitola používá vlastní příklady. Bibliografická identita viz D08.

<a id="d10"></a>

### D10 — Excel: normální rozdělení a porovnání pravděpodobností

**Soubor:** [Normalni_rozdeleni_do_3_aveamian._prednasky.xlsx](../sources/ostatn%C3%AD%20zdroje/Normalni_rozdeleni_do_3_aveamian._prednasky.xlsx); 4 listy. Metadata uvádějí Stanislava Ježka; rok vzniku v metadatech neurčuje rok současné didaktické verze.

| List a buňky | Obsah a využití |
|---|---|
| `zpaměti`, vložený obrázek a `B32:E37` | Převodní schéma a vysvětlení, co znát a co dopočítat; CDF a inverzní funkce. |
| `hustota!B39:R43` | z = −4 až 4, CDF, plocha od středu, hustota funkcí i vzorcem; řádky 40, 42 a 43 odlišují tři různé významy. |
| `hustota!B44:R45` | Lineární převody na IQ (100, 15) a T (50, 10). |
| `hustota!B47:P50` | Vybrané percentily, jejich hodnoty v z, IQ a T. |
| `cdf`, oblast `A1:R49` | Grafické a tabulkové zobrazení distribuční funkce; souvislost s listem `hustota`. |
| `Q-Q!B2:C3` | Populační parametry generování a průměr/SD konkrétního náhodného výběru. |
| `Q-Q!A6:C101` | 96 simulovaných normálních hodnot, `PERCENTRANK.EXC` a modelová CDF. |
| `Q-Q!O6:P101` | Ruční pořadový výpočet přes `COUNTIF`, dělení n + 1 a zkrácení na tři místa, porovnání s funkcí. |

**Prostudováno:** struktura všech listů, uložené vzorce a výsledky, definice datových řad grafů a vložený převodní obrázek. **Nezávislé ověření:** 66 uložených hodnot CDF/hustoty/kvantilů na listu `hustota` porovnáno s Python `statistics.NormalDist`; maximální absolutní rozdíl přibližně 3,4 × 10⁻¹⁶. Znovu spočítán průměr a výběrová SD 96 uložených hodnot z listu `Q-Q`; shodují se s uloženými výsledky do numerické přesnosti.

**Zásadní nález:** graf listu `Q-Q` má na osách hodnoty z `B6:B101` a `C6:C101`, tedy empirické pořadové pravděpodobnosti a modelové kumulativní pravděpodobnosti. Odpovídá principu **P–P grafu**, nikoli Q–Q grafu porovnávajícího kvantily. Také popisky „empirický/teoretický kvantil“ v `B5:C5` tyto veličiny nerozlišují. Nepřebírat jako návod pro Q–Q graf kapitoly 4.

**Další podmínky:** `PERCENTRANK.EXC` a dělení n + 1 nejsou současnou projektovou definicí empirického percentilového pořadí. Funkce `RAND()` mění hodnoty při přepočtu, uložený stav tedy není reprodukovatelná pevná datová sada.

**Neověřeno:** sešit nebyl nově spuštěn a přepočten v Excelu, neověřeno jeho živé chování, české názvy funkcí v dané instalaci, všechny vzorce ani výsledné rozložení grafů v Excelu. Shoda uložených výsledků s Pythonem neprokazuje funkčnost sešitu v aktuálním Excelu. Originál se neměnil.

## Rozpory, mezery a další práce

| Oblast | Co je třeba respektovat při přípravě kapitoly |
|---|---|
| Schválená koncepce | Pořadí a rozsah určuje OSNOVA; rozsáhlé kapitoly učebnic o ANOVA, regresi či bayesovských metodách nejsou automaticky součástí tohoto semestru. |
| Značení a kvantily | Přednost mají R01–R04, R14 a R15. Staré M/SD/MAD, pořadové algoritmy a N(μ, σ²) nepřebírat bez výslovného rozlišení konvencí. |
| Pojetí pravděpodobnosti | Dostál s. 13–14, Howell s. 108–110, Navarro s. 373–375, Russo s. 52–54 a Baron kap. 5 nepodávají totožný filozofický výklad. Dohodnuto v R21: tři pojetí jako různé interpretace se společnými pravidly, které nemusí vést ke stejnému číslu. |
| Podmínění a nezávislost | [U11](#u11) s. 62 zaměňuje výsledek diagnostického testu za správnost klasifikace; při použití opravit podle zadání a stromu na s. 60. |
| Data a software | Číselné kódování a missing z SPSS nejsou univerzální požadavek; −99 nesmí vstupovat do běžného průměru. R z cizích knih zůstává interní. |
| Normální model | Rozlišit CDF a kvantil, percentil a pořadí, Q–Q a P–P, interval hodnot a interval spolehlivosti. Starší podklady obsahují konkrétní záměny. |
| Bibliografie | Došetřit vydání obou Baronových úryvků, de Vause a Morgana; rok/verzi Navarro; rozdíly v identitě mezinárodního Arona; přesný původ úloh C2/C3. |
| Nedostupné návazné materiály | U [U11](#u11) jsou kap. 13–14 a další označené oddíly pouze na webu, nikoli v místním PDF. Odkazované externí datasety, `Datíčka.xls`, videa, QR odkazy, online aplikace, originály studií a navazující části knih nejsou automaticky pokryty inventářem. |
| Odborné ověření | Před použitím konkrétního příkladu nezávisle ověřit všechny vstupy, výpočty a řešení; před převzetím empirického tvrzení ověřit původní zdroj a relevantní současné poznatky. |

### Záznam prvního průzkumu a údržba

Inventura zahrnula všechny soubory ve všech aktuálních podsložkách. Ověřeny byly místní cesty, rozsahy souborů a otisky. Původní podklady nebyly upravovány. Pomocné textové extrakce, OCR, obrazy stran a exporty snímků zůstávají v ignorovaném `tmp/`, nejsou součástí mapy ani veřejného repozitáře.

Při aktualizaci karty zachovej ID; doplň datum, verzi souboru, přesné nově prostudované části, způsob ověření a zbývající mezery. Nový obsahový nález zapisuj k dotčenému zdroji; pouze schválenou změnu výkladu promítni také do osnovy či rozhodnutí. Při výměně vydání knihy zkontroluj všechny odkazované stránky, nikoli pouze první z nich.

<a id="e01-mulherin-miller"></a>

## E01 — Mulherin a Miller: přenos diagnostické přesnosti mezi skupinami

**Externí zdroj, doplněn při revizi 2026-10-12:** Mulherin, S. A., & Miller,
W. C. (2002). Spectrum bias or spectrum effect? Subgroup variation in
diagnostic test evaluation. *Annals of Internal Medicine, 137*(7), 598–602.
[DOI](https://doi.org/10.7326/0003-4819-137-7-200210010-00011),
[PubMed](https://pubmed.ncbi.nlm.nih.gov/12353947/). Klíč `mulherin2002`.

**Skutečně ověřeno:** bibliografická metadata a celý veřejný abstrakt
na PubMed; abstrakt výslovně uvádí rozdíly přesnosti mezi podskupinami
a nutnost posoudit přenos do cílové populace. Použití pouze pro toto
omezení u dvou prevalencí v kapitole 5, nikoli pro nové klinické hodnoty.
Plný článek nebyl prostudován; nepřebíráme jeho postupy analýzy ani odhady.
Soubor nebyl přidán do místní složky `sources/`; inventář jejích 30 souborů
se tím nemění.

### Doplnění kontroly podkladů kapitoly 5 — 2026-10-12

Při revizi znovu přečteny relevantní citované pasáže Howella (zejména
s. 108–112, 119, 121–128), Navarra (373–377), Sahua (64–69), Russa (64),
OpenIntro (95–96), Barona (121–123 a 149–152) a Uttsové (77–78).
V originálním obraze navíc prohlédnuty Howell s. 122 a 128, Sahu s. 64
a 69, OpenIntro s. 95, všechny uvedené strany Barona a Uttsové.
Výpočty kapitoly byly ověřeny nezávisle; u Howellova výsledku 0,513
(s. 122) kapitola správně zaokrouhluje 95/185 na 0,514.
Původní experimentální studie nebyly znovu ověřeny a identita Baronova
vydání zůstává v rozsahu a s omezením popsaným v kartě D08.
U C03 znovu ověřeno textové zadání X3_31 (100 otázek ano–ne, hranice 65);
kapitola na rozdíl od původního zadání rozlišuje přesný binomický model
a normální aproximaci. Nová typografická revize původního DOCX neproběhla.

### Externí doplněk kapitoly 1: Griffith et al. (2020) — 2026-10-12

**Identita:** *Collider bias undermines our understanding of COVID-19 disease
risk and severity*, Nature Communications, 11(1), článek 5749,
[DOI](https://doi.org/10.1038/s41467-020-19478-2), klíč `griffith2020`.
Metadata včetně 14 autorů ověřena proti záznamu vydavatele a
[PubMed](https://pubmed.ncbi.nlm.nih.gov/33184277/).

**Prostudováno:** veřejný text oddílu Introduction a pasáže Results and
discussion o rozdílu společné příčiny a společného následku, dostupné
prostřednictvím indexovaného textu vydavatele. Mechanismus podmiňování
a závislost směru zkreslení na modelu použity v nepovinném rozšíření.
Přímé načtení stránky vydavatele a obou zadaných obrazových URL selhalo;
původní obrázky nebyly vizuálně ověřeny. Grafy jsou vlastní simulace podle
autorova popisu; u druhého je přiznána inspirace principem obr. 1.
Neproběhla reanalýza COVID-19 ani kontrola celého článku či doplňků.
Do `sources/` se nic nepřidává a inventář místních souborů se nemění.

První graf navazuje na autorem popsaný vzor tří skupin z
[obrazového odkazu Medium](https://miro.medium.com/v2/resize:fit:2000/format:webp/1*fShYxVZ8n1FDVSFFftSCzw.png).
Autorství a okolní článek tohoto obrázku nebyly určeny; nepřebíráme jeho
data ani obraz. Schválený pedagogický kontext, osy a skupiny jsou od autora
učebnice. Platnost modelových tvrzení ověřují vlastní numerické kontroly.
