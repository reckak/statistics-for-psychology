<a id="p07"></a>

# P07 — Statistické usuzování, PSYb1170, 2026

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

Odkazy na originály v `sources/` jsou místní a vyžadují neveřejné podklady. Stav prostudování a omezení určují záznamy níže.

**Soubor:** [PSYb1170_P04_2026_-_Indukce_a_CI.pptx](../../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/PSYb1170_P04_2026_-_Indukce_a_CI.pptx), 62 snímků. Titul uvádí PSYb1170, přednášku 4, 2026; metadata Stanislava Ježka, poslední změnu 2026-03-17. Kontrola 2026-10-12.

| Snímky | Obsah a využití |
|---|---|
| 1–11 | Od popisu k inferenci, statistiky a parametry, bodový odhad, náhodné a systematické chyby; potřeba struktury u 32 studentů (průměr 3,95; SD 0,91). |
| 12–21 | Simulace, výběrové rozdělení a rozdělení chyb, kvantily, směrodatná chyba; srovnání teorie a bootstrapu. |
| 22–31 | Odvození variability průměru, CLT, známá/neznámá populační SD, t-rozdělení a kvantily, velikost chyby odhadu. Sn. 22 je v poznámce označen jako rozšíření. |
| 32–37 | Bootstrap: výběr s vracením, medián, ukázka v R, odkaz na Excel a vztah k opakovaným výběrům. |
| 38–50 | Bodové a intervalové odhady, hladina spolehlivosti, mezní chyba, interval pro průměr a vlivy na jeho šířku. Sn. 40–41 mají místa k doplnění, sn. 46 číselné řešení. |
| 51–53 | Interval pro podíl normální aproximací, přehled přesnějších postupů (Clopper–Pearson, Wilson, Agresti–Coull), percentilový bootstrap. Poznámka sn. 52 vymezuje původní požadavek kurzu pouze na normální aproximaci. |
| 54–56 | Interpretace intervalů, srovnání s bayesovským pojetím a shrnutí. |
| 57–62 | Další statistiky: medián, rozptyl, korelace a Fisherova transformace; korekce rozptylu; bayesovský interval pro podíl. |

**Prostudováno:** text všech 62 snímků, matematických objektů a dostupných poznámek; všechny snímky vyexportovány PowerPointem a prohlédnuty na kontaktních listech, sn. 61 také samostatně. Důležitá didaktická priorita autora: společný příklad potřeby struktury, odlišení chyby výběru od systematické chyby, propojení simulace a teorie, porozumění intervalům. Rozšiřující snímky nejsou automaticky plánem učebnice.

**Nálezy a podmínky použití:**

- **Sn. 5 a 61:** ve vzorcích je třeba důsledně uvést čtverce odchylek od průměru. Sn. 61 má v obou součtech odchylky bez druhé mocniny a obrácený faktor zkreslení: pro rozptyl počítaný se jmenovatelem n je očekávání **(n − 1)σ²/n**, nikoli nσ²/(n − 1). Průměr konečného počtu simulovaných rozptylů se očekávání pouze přibližuje. Chyby sn. 61 potvrzeny v samostatném obrazu.
- **Sn. 18, 20, 31 a 56:** SE je SD výběrového rozdělení, nikoli obecně průměrná podepsaná ani absolutní chyba. U průměru při pevném n roste s populační SD; shrnutí „klesá … s variabilitou“ na sn. 31 a 56 obrací tento vztah.
- **Sn. 23–30, 40 a 46:** neznalost σ nezmění rozdělení samotného průměru na Studentovo. Za nezávislého normálního výběru má t-rozdělení statistika **(m − μ)/(s/√n)**. Odhad s/√n odlišit od skutečné SE. Pevné hranice n > 30 či n > 100 nejsou obecnou zárukou aproximace. Výpočet a rozlišení statistiky porovnány s [NIST, Confidence Limits for the Mean](https://www.itl.nist.gov/div898/handbook/eda/section3/eda352.htm).
- **Sn. 24 a 46:** 0,91/√32 = **0,16087**, tedy na dvě místa 0,16, nikoli 0,17. Pro 31 stupňů volnosti je horní 97,5% kvantil 2,03951 a interval (3,62191; 4,27809), tedy závěr sn. 46 (3,62; 4,28) souhlasí. Jeho mezikrok u horní meze však obsahuje **2,4** místo 2,04. Výpočty ověřeny v R, nikoli spuštěním Excelu.
- **Sn. 32–37, 53 a 58:** bootstrapové rozdělení je odhad, nemá zaručeně stejný tvar a SE jako skutečné výběrové rozdělení. Nelze jej představit jako postup bez předpokladů pro libovolnou statistiku. Samotné opakování malého vzorku neodstraňuje jeho zkreslení ani problémy závislých pozorování.
- **Sn. 42, 48, 51–54 a 59–60:** je-li α pravděpodobnost v intervalu 0–1, procentní zápis hladiny je **100(1 − α) %**. Frekventistické pokrytí se týká postupu při opakovaných výběrech za předpokladů modelu. Sn. 55 nedokládá obecnou shodu intervalů pro libovolnou charakteristiku polohy s bayesovskými intervaly; ta vyžaduje konkrétní model a prior.
- **Sn. 51–52:** pro pevné n je výběrový podíl diskrétní přepočet binomického počtu, nikoli spojitá náhodná veličina. Oříznutí normálního intervalu na 0 a 1 samo neřeší jeho pokrytí. Vzorce s BETA.INV vyžadují zvláštní zacházení s nulovým či úplným počtem úspěchů; všechny popsané intervalové postupy před použitím samostatně ověřit.
- **Sn. 58–62:** pořadové meze mediánu na sn. 58 mají ve slovním popisu prohozené označení horní/dolní meze. Tvrzení sn. 60, že rozdělení korelace „neznáme“, není vhodnou obecnou formulací. Na sn. 62 rozlišit věrohodnost a posterior: kvantily vyžadují normalizované posteriorní rozdělení při zvoleném prioru; interval s rovnými chvosty se obecně nerovná intervalu nejvyšší hustoty. Tato rozšíření nejsou kompletně odborně ověřena.

**Neověřeno:** všechny další výpočty, platnost a česká syntaxe funkcí ve skutečném Excelu, vložené a externí simulace, všechny animace, zdrojová data a empirický původ příkladu. R kód ze sn. 35 nebyl spuštěn. Originál se neměnil.

**Doplnění při přípravě kapitoly 6 (2026-10-12):** z PPTX znovu přečten text sn. 1–37 a poznámky; sn. 38–62 jen podle této karty.

- **Využití pro blok A ([R28](../rozhodnuti/kapitola-06.md#r28-rozsah-kapitoly-6)):** rozlišení náhodné výběrové chyby a systematického zkreslení (sn. 8–10); výběrové rozdělení jako rozdělení pravděpodobnosti hodnot statistiky a výstraha před záměnou s rozdělením proměnné (sn. 14); popis výběrového rozdělení polohou, rozptýleností a tvarem (sn. 17); termín směrodatná chyba (sn. 18); úvaha od N = 1 k většímu výběru jako podklad nepovinného odvození (sn. 22).
- **Šíře termínu:** sn. 10 dokládá, že „sampling error“ se užívá pro celkovou chybu odhadu i jen pro její náhodnou složku; na tuto různou šíři má výklad podle [R30](../rozhodnuti/kapitola-06.md#r30-terminologie-kapitoly-6) upozornit.
- **Nepřebírá se:** „SE vyjadřuje průměrnou, očekávanou chybu odhadu“ (sn. 18, 20, 31); hranice N > 30 a N > 100 (sn. 23, 25); tvrzení, že výběrové rozdělení průměru je při neznámém σ Studentovo (sn. 25, 29); hodnota 0,17 na sn. 24 (správně 0,16 podle nálezu výše).
- **Mimo schválený rozsah kapitoly 6:** bootstrap (sn. 32–37) a intervaly spolehlivosti (sn. 38–62).



<a id="priprava-07-20261017"></a>

## Čtení pro návrh kapitoly 7 — 2026-10-17

Z originálního PPTX znovu extrahován text a poznámky; podrobně přečteny sn. 23–31 a 38–50, orientačně návaznosti a rozšíření. Sn. 46 prohlédnut v dřívějším obrazovém exportu; aktuální soubor souhlasí s inventářem podle SHA-256. Potvrzeno, že označení t-rozdělení samotného průměru a koeficient 2,4 v horní mezi jsou skutečně na snímku, nikoli jen v extrakci.

Souhrny příkladu potřeby struktury znovu přepočteny v R: s/√n ≈ 0,16086679, kvantil ≈ 2,03951345, interval (3,62191001; 4,27808999). Příklad je kandidátem vedlejší aplikace; původ empirických dat zůstává neověřený a individuální pozorování se ze souhrnů nebudou rekonstruovat. Navržený rozsah nepřebírá bootstrap, interval podílu ani bayesovské rozšíření. Nebyly znovu prohlédnuty všechny snímky ani spuštěny animace, vložené aplikace a externí simulace.

[Společný rozsah kontroly](HISTORIE.md#priprava-07-20261017).

## Související karty kapitol

Tematické vazby pro výběr podkladů: [kapitola 6](../kapitoly/06-vyberove-rozdeleni-testovani.md#mapa-kapitola-06), [kapitola 7](../kapitoly/07-interval-t-test-ekvivalence.md#mapa-kapitola-07). Konkrétní použití a stav ověření určují záznamy výše.
