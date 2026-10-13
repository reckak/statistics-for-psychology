<a id="p05"></a>

# P05 — Pravděpodobnost, STPS 2025

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md)

Odkazy na originály v `sources/` jsou místní a vyžadují neveřejné podklady. Stav prostudování a omezení určují záznamy níže.

**Soubor:** [probability.pptx](../../sources/star%C5%A1%C3%AD%20p%C5%99edn%C3%A1%C5%A1ky/probability.pptx) (místní neveřejný podklad); 36 snímků, žádný označený jako skrytý. Titul uvádí „Pravděpodobnost“ a „STPS 2025“. Metadata PPTX uvádějí autora Karla Rečku a poslední změnu 19. prosince 2025; nejde o nezávislé ověření autorství všech převzatých příkladů a obrázků.

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


## Související karty kapitol

Tematické vazby pro výběr podkladů: [kapitola 5](../kapitoly/05-pravdepodobnost.md#mapa-kapitola-05). Konkrétní použití a stav ověření určují záznamy výše.
