// Student inputs, transcribed from the chapter sources. No exercise solutions.
// A row in a frequency/parameter table is not an invented participant.
import fs from 'node:fs/promises';
const col = v => v.map(x=>[x]);
const item = (name, use, headers, rows, note='Autorské ilustrační údaje. Nejde o skutečný výzkum.') => ({name,use,headers,rows,note});
const vector = (name,use,label,v,note) => item(name,use,[label],col(v),note);
const shared = (await fs.readFile('data/kapitola_02.csv','utf8')).trim().split(/\r?\n/).slice(1).map(l=>l.split(',').map((v,i)=>[1,2,4].includes(i)?(v===''?null:+v):v));
export const inputs = {
  1: [
    item('Data','Datová matice; kontrola v Excelu',['id','spanek_h','slova','cast_dne','odpocatost'],shared.slice(0,6),'Autorská matice. Jeden řádek = jedna návštěva účastníka. P05 spánek neuvedl; nula u P06 je platný výkon.'),
    item('Promenne','Přehled proměnných',['Název','Význam','Hodnoty a jednotky','Chybění'],[
      ['id','Stálý identifikátor účastníka','P01 až P06; jedinečný','Nepřípustné'],
      ['spanek_h','Skutečný spánek před návštěvou bez bdění','0 až 24 hodin','Prázdná buňka'],
      ['slova','Různá správně vybavená slova; minuta čtení a minuta vybavování','Celá čísla 0 až 12','Prázdná buňka'],
      ['cast_dne','Začátek měření','dopoledne před 12:00, odpoledne od 12:00','Prázdná buňka'],
      ['odpocatost','Jak odpočatě se právě cítíte?','1 vůbec, 2 trochu, 3 dost, 4 zcela','Prázdná buňka']]),
    item('Chybeni','Nula a chybějící údaj',['Účastník','slova','Okolnost'],[['A',0,'Úloha dokončena, žádné správné slovo'],['B',null,'Úloha neproběhla, selhal počítač']]),
    item('Oprava_zaznamu','Oprava s oporou v podkladu',['id','Přepis spánku (h)','Původní formulář (h)'],[['P04',50,5]]),
    item('U08_podklady','Cvičení 8: původní formuláře',['id','Záznam o spánku','Záznam o paměťové úloze'],[['K01','6 hodin','Dokončena, 0 správných slov'],['K02','Neuvedeno','8 správných slov'],['K03','7 hodin','Neproběhla pro poruchu počítače']]),
    item('U08_prepis','Cvičení 8: chybná tabulka k opravě',['id','spanek','slova'],[['K01','6 hodin',0],['K01',-99,8],['K03',7,0]],'Záměrně chybný přepis ze zadání. Opravujte podle listu U08_podklady, původní tabulku zachovejte.')
  ],
  2: [
    item('Sest_osob','Úvodní příklad, jmenovatel procent',['id','spanek_h','slova','cast_dne','odpocatost'],shared.slice(0,6)),
    item('Strategie','Výsečový a sloupcový graf',['Strategie','Četnost'],[['Procvičování',14],['Čtení',12],['Vysvětlování',10]]),
    item('Tvary','Obrázek: šest tvarů rozdělení',['Hodnota','Souměrnost','Šikmost doprava','Šikmost doleva','Dva vrcholy','Rovnoměrnost','Odlehlost'],Array.from({length:9},(_,i)=>[i+1,...[[1,2,4,7,10,7,4,2,1],[1,3,10,8,5,3,2,1,1],[1,1,2,3,5,8,10,3,1],[1,6,10,4,1,4,10,6,1],[4,4,4,4,4,4,4,4,4],[1,3,8,9,4,1,0,0,1]].map(v=>v[i])]),'Autorské schematické četnosti. Sloupce představují šest různých rozdělení, nikoli spárovaná měření lidí.'),
    item('Podlaha_strop','Obrázek: meze nástroje',['Počet správných odpovědí','Podlaha: četnost','Strop: četnost'],Array.from({length:13},(_,i)=>[i,[15,7,4,3,2,1,1,1,1,1,0,0,0][i],[0,0,0,1,1,1,1,1,2,3,4,7,15][i]])),
    vector('Stonek','Výklad: stonek a list','Doba (s)',[12,14,14,18,21,23,27,31]),
    vector('U01_odpocatost','Cvičení 1 a 2','Odpočatost (kód 1–4)',[2,3,2,1,4,3,2,3,4,2,3,2],'Autorské údaje. 1 vůbec, 2 trochu, 3 dost, 4 zcela.'),
    item('U03_chybeni','Cvičení 3a',['Odpověď','Četnost'],[['Ano',9],['Ne',11],['Chybí',5]],'Zadáno 25 oslovených; 20 odpovědělo. Četnosti, nikoli jednotliví lidé.'),
    item('U03_ruseni','Cvičení 3b',['Možnost','Počet označení','Počet odpovídajících'],[['Hluk',12,20],['Telefon',14,20],['Únava',6,20]],'Bylo možné označit více možností. Překryvy mezi lidmi nejsou zadány.'),
    vector('U04_chyby','Cvičení 4','Počet chyb',[0,1,1,2,2,2,3,4,4,5]),
    vector('U05_spanek','Cvičení 5','Spánek (h)',[5,5.5,6,6,6.5,7,7.5,8],'Intervaly: více než 4 až 5 včetně, více než 5 až 6 včetně, více než 6 až 7 včetně, více než 7 až 8 včetně.'),
    item('U08_stonek','Cvičení 8: zadání k rekonstrukci',['Stonek','Listy'],[[2,'1 3 3 8'],[3,'0 5'],[4,'2']],'Klíč: 2 | 3 znamená 23 sekund. Sloupec Listy je záměrně textový zápis zadání, nikoli hotové řešení.'),
    item('Podpora','Zavádějící graf; cvičení 9',['Skupina','Ano','Celkem'],[['A',30,40],['B',32,80]])
  ],
  3: [
    vector('Zaklad_data','Střed, odchylky, percentilové pořadí','Doba (min)',[4,5,5,6,10],'Samostatné vstupy k procvičení. Hotové výpočty jsou na listu Priklad. Varianta: nahraďte 10 hodnotou 30.'),
    item('Stejny_prumer','Obrázek: stejný průměr, různá variabilita',['Soubor A (min)','Soubor B (min)'],[5,6,6,6,7].map((v,i)=>[v,[2,4,6,8,10][i]])),
    vector('Dva_mody','Výklad modu','Hodnota',[4,4,6,6,9]),
    vector('Sudy_median','Výklad mediánu','Doba (min)',[4,5,6,10]),
    vector('Percentil_ctyri','Výklad: 30. percentil a podíl pozorování','Hodnota',[1,2,3,4]),
    vector('Transformace','Výklad a obrázek: lineární a nelineární převod','Původní skór',[2,3,8,9],'Porovnejte pravidla y = 2 + 3x a y = x². Další příklad obrácení škály 0–10 používá y = 10 − x.'),
    item('Ordinalni_kvantily','Výklad: kvantil odpočatosti',['Kategorie','Četnost','Běžný kód','Alternativní kód'],[['Vůbec',1,1,1],['Trochu',2,2,2],['Dost',2,3,10],['Zcela',1,4,100]],'Stejných šest odpovědí při dvou kódováních. Kódy zachovávají pořadí, nikoli měřené vzdálenosti.'),
    item('Vazeny_prumer','Výklad: spojení skupin',['Skupina','Počet lidí','Průměrná doba (min)'],[['A',10,4],['B',30,8]],'Zadány jsou pouze velikosti skupin a průměry. Jednotlivé časy nejsou známy.'),
    item('Vyjimky_stredu','Obrázek: výjimky z pořadí ukazatelů středu',['Počet pokusů (A)','Četnost A','Počet chyb (B)','Četnost B'],[[1,38,0,8],[2,49,1,7],[3,8,2,3],[4,3,3,1],[5,2,4,1]],'Autorské modelové četnosti: A 100 lidí, B 20 lidí. Řádek je hodnota s četností, nikoli jeden účastník.'),
    vector('Kvantily','Výklad interpolace; cvičení 3 (druhá část)','Doba (min)',[4,5,7,8,9,10,12,13,15,18,22]),
    vector('Orezani','Výklad: 10 %; cvičení 8: 20 % na každém konci','Doba (min)',[2,3,4,5,5,6,7,8,9,31]),
    vector('Boxplot','Výklad: krabicový graf','Skór (body)',[2,5,15,25,30,32,34,36,38,40,40,42,44,44,46,46,48,48,49,50,50,50,51,52,52,54,54,56,56,58,60,60,62,64,66,68,70,75,85,95,98]),
    vector('Populace','Simulace korekce rozptylu','Doba (min)',[2,4,6,8,10],'Známá modelová populace. Nezávislé výběry s vracením: velikosti 5, 20 a 100; po 20 000 opakováních. Graf shrnuje simulaci, nikoli další měření lidí.'),
    item('Spicatost','Obrázek: stejný vrchol; cvičení 14',['Skór','Četnost vlevo','Četnost vpravo'],[[-3,0,1],[-1,10,9],[0,80,80],[1,10,9],[3,0,1]]),
    vector('U01_stred','Cvičení 1','Doba (min)',[3,4,4,5,6,20]),
    item('U02_skupiny','Cvičení 2',['Skupina','Počet lidí','Průměr (slova)'],[['A',8,6],['B',12,9]],'Alternativní otázka: co kdyby údaje 6 a 9 byly pouze mediány? Individuální výkony nejsou zadány.'),
    vector('U03_kvantily','Cvičení 3 (první část)','Skór (body)',[1,1,1,3,4,8]),
    item('U04_kategorie','Cvičení 4',['Odpočatost','Kód'],[['Vůbec',1],['Trochu',2],['Dost',3],['Zcela',4]]),
    vector('U05_variabilita','Cvičení 5','Doba (min)',[2,4,6]),
    item('U06_simulace','Cvičení 6: zadané souhrny',['Veličina','Hodnota','Jednotka'],[['Rozptyl populace',8,'min²'],['Velikost výběru',5,'pozorování'],['Průměr rozptylů s dělením n',6.41,'min²'],['Průměr rozptylů s dělením n−1',8.01,'min²']], 'Zaokrouhlené souhrny simulace ze zadání. Nejde o jednotlivá pozorování.'),
    vector('U07_MedAD','Cvičení 7','Doba (min)',[2,3,4,5,16],'Autorské údaje. Ve druhé části nahraďte poslední hodnotu 100 minutami.'),
    vector('U09_boxplot','Cvičení 9','Doba (min)',[1,2,2,3,4,5,6,15]),
    item('U10_transformace','Cvičení 10',['Vstup','Hodnota','Jednotka'],[['Průměr',4,'min'],['Směrodatná odchylka',1.5,'min'],['Medián',3.5,'min'],['Přičítaný čas',2,'min'],['Sekund za minutu',60,'s/min']], 'Zadány jsou souhrny, nikoli jednotlivé doby.'),
    item('U11_strategie','Cvičení 11',['Strategie','Skupina A','Skupina B'],[['A',20,5],['B',0,5],['C',0,5],['D',0,5]]),
    item('Entropie_data','Výklad; nepovinné cvičení 13',['Kategorie','Četnost'],[['A',4],['B',2],['C',2],['D',0]],'Výchozí tři kategorie A–C; D je rozšíření s nulovou četností. Další varianta: 8, 0, 0, 0.'),
    item('U14_sikmost','Nepovinné cvičení 14',['Skór (body)','Četnost'],[[-2,4],[-1,5],[1,10],[3,1]])
  ],
  4: [
    item('Z_skory','Výklad: dvě různé referenční skupiny',['Test','Skór (body)','Průměr (body)','Směrodatná odchylka (body)'],[['A',60,50,10],['B',42,30,6]]),
    vector('Standardizace','Výklad: standardizace pěti časů','Doba (min)',[4,5,5,6,10]),
    item('Modely','Výklad: poloha a šířka normálního modelu',['Model','Průměr (body)','Směrodatná odchylka (body)'],[['Základní',50,10],['Posunutý',65,10],['Širší',50,15]]),
    item('Skaly','Výklad a cvičení 7: lineární převody',['Škála','Průměr','Směrodatná odchylka'],[['z',0,1],['T',50,10],['IQ',100,15],['Subtest',10,3]]),
    item('U01_reference','Cvičení 1',['Skupina','Skór (body)','Průměr (body)','Směrodatná odchylka (body)','Z pro zpětný převod'],[['A',62,50,8,-.75],['B',62,65,6,null]]),
    vector('U02_standardizace','Cvičení 2','Doba (min)',[2,2,2,2,12]),
    item('U03_model','Cvičení 3',['Vstup','Hodnota'],[['Průměr (body)',80],['Směrodatná odchylka (body)',5],['Posuzovaná hustota (na bod)',.08],['Hranice (body)',85],['Druhý údaj v alternativním zápisu',25]]),
    item('U04_plochy','Cvičení 4',['Vstup','Hodnota'],[['Průměr (body)',50],['Směrodatná odchylka (body)',10],['Dolní mez (body)',45],['Horní mez (body)',65],['Počet lidí ve skutečné skupině',20],['Nejvýše 45 bodů ve skutečné skupině',8]]),
    item('U05_percentily','Cvičení 5',['Vstup','Hodnota'],[['Průměr (body)',50],['Směrodatná odchylka (body)',10],['Podíl vlevo',.2],['Podíl vpravo',.1],['Prostřední podíl',.9]]),
    item('U06_zaokrouhleni','Cvičení 6',['Vstup','Hodnota'],[['Průměr (body)',50],['Směrodatná odchylka (body)',10],['Zaznamenaný skór (body)',50],['Krok zaokrouhlení (body)',1]]),
    vector('U07_prevody','Cvičení 7','T-skór',[38,50,60,70],'První skór slouží k lineárnímu převodu; ostatní tři k porovnání modelových percentilových pořadí. Parametry škál jsou na listu Skaly.'),
    vector('U08_pasmo','Cvičení 8','Z-skór',[1.2,-.6,0]),
  ],
  5: [
    item('Karticky','Výklad: výsledek, jev, doplněk, výběr bez vracení',['Slovní druh','Počet kartiček'],[['Podstatné jméno',40],['Sloveso',35],['Přídavné jméno',25]],'Autorská modelová krabice 100 kartiček. Četnosti, nikoli záznamy o lidech.'),
    item('Tabulka_zavislost','Výklad: průnik, sjednocení, podmíněná pravděpodobnost, závislost',['Pohlaví','Stres','Bez vysokého stresu'],[['Žena',40,60],['Muž',30,70]],'Autorský modelový soubor 200 studentů. Četnosti kombinací, nikoli jednotliví lidé ani skutečný výzkum.'),
    item('Tabulka_nezavislost','Výklad: nezávislé jevy',['Pohlaví','Stres','Bez vysokého stresu'],[['Žena',30,70],['Muž',30,70]],'Druhý autorský modelový soubor 200 studentů se stejným podílem stresu v obou řádcích.'),
    item('Screening','Výklad: přirozené četnosti, úplná pravděpodobnost, Bayesova věta, dvě prevalence',['Vstup','Hodnota'],[['Počet osob',1000],['Prevalence v poradně',.1],['Senzitivita',.95],['Specificita',.9],['Prevalence při plošném použití',.01],['Počet osob pro srovnání prevalencí',10000]],'Modelové hodnoty zvolené pro výklad. Nejde o vlastnosti skutečného dotazníku ani o skutečný výskyt poruchy. Při srovnání skupin předpokládáme stejnou senzitivitu a specificitu. Hotový výpočet je na listu Bayes.'),
    item('Test_hadani','Výklad: rozdělení pravděpodobnosti, kombinace, binomické rozdělení',['Vstup','Hodnota'],[['Počet otázek krátkého testu',5],['Počet možností u otázky',4],['Pravděpodobnost správného tipu',.25],['Počet otázek delšího testu',20],['Hodnota pro právě a nejvýše',5],['Hranice pro alespoň',10]],'Model zcela náhodného a nezávislého tipování; každá otázka má jedinou správnou možnost. Hotové výpočty jsou na listech Binom a Binom_20.'),
    item('Rozpoznavani','Výklad: normální aproximace a převod na podíl',['Vstup','Hodnota'],[['Počet pokusů',200],['Pravděpodobnost správné odpovědi',.6],['Hranice počtu správných odpovědí',135]],'Autorský model rozpoznávací úlohy s nezávislými pokusy. Hotový výpočet je na listu Aproximace.'),
    item('Losovani','Nepovinné rozšíření: variace bez opakování',['Vstup','Hodnota'],[['Počet studentů',100],['Počet cen',3]],'Autorský příklad losování; při různých cenách záleží na pořadí, při stejných nikoli.'),
    item('U01_emoce','Cvičení 1',['Emoce','Počet fotografií'],[['Radost',24],['Smutek',18],['Strach',12],['Překvapení',6]],'Autorská modelová sada 60 fotografií. Četnosti, nikoli odpovědi lidí.'),
    item('U03_tabulka','Cvičení 3',['Sport','Dobrý spánek','Špatný spánek'],[['Sportuje',54,26],['Nesportuje',27,43]],'Autorský modelový soubor 150 studentů. Četnosti kombinací, nikoli jednotliví lidé.'),
    item('U04_vstupy','Cvičení 4',['Vstup','Hodnota'],[['Počet možností u otázky',4],['Počet tipovaných otázek',2],['Počet kartiček v sadě',10],['Počet cílových slov v sadě',4]]),
    item('U06_screening','Cvičení 6',['Vstup','Hodnota'],[['Počet osob',1000],['Senzitivita',.8],['Specificita',.9],['Prevalence v první skupině',.05],['Prevalence ve druhé skupině',.2]],'Modelové hodnoty. Nejde o vlastnosti skutečného dotazníku. Při obou prevalencích předpokládáme stejnou senzitivitu a specificitu.'),
    item('U07_taxi','Cvičení 7',['Vstup','Hodnota'],[['Podíl zelených taxíků',.85],['Podíl modrých taxíků',.15],['Pravděpodobnost správného určení barvy',.8]],'Čísla podle Howella (2013, s. 122–123), který uvádí úlohu Tverského a Kahnemana; znění zadání je upraveno. Předpokládáme stejnou pravděpodobnost účasti na nehodě pro každý taxík.'),
    item('U08_rozdeleni','Cvičení 8',['Počet vybavených slov','Pravděpodobnost v modelu','Četnost ve výběru 20 lidí'],[[0,.1,3],[1,.4,7],[2,.35,8],[3,.15,2]],'Autorský model a autorské ilustrační četnosti. Řádek je hodnota proměnné, nikoli účastník.'),
    item('U09_test','Cvičení 9',['Vstup','Hodnota'],[['Počet otázek',4],['Pravděpodobnost správného tipu',.5],['Počet správných odpovědí v části a) a b)',3]]),
    item('U10_test','Cvičení 10',['Vstup','Hodnota'],[['Počet otázek',15],['Počet možností u otázky',5],['Hodnota pro právě a nejvýše',3],['Hranice pro alespoň',7]]),
    item('U11_aproximace','Cvičení 11',['Vstup','Hodnota'],[['Počet otázek',100],['Pravděpodobnost správného tipu',.5],['Hranice počtu správných odpovědí',65]],'Upraveno podle starší autorovy úlohy k normálnímu rozdělení.'),
  ],
  6: [
    item('Parkovani','Výklad: průběžný příklad; studie a výukový model',['Vstup','Hodnota'],[['Studie: počet řidičů v každé skupině',100],['Studie: průměrná doba bez čekajícího auta (s)',32.15],['Studie: průměrná doba s čekajícím autem (s)',39.03],['Studie: směrodatná odchylka v každé skupině (s)',14.6],['Výukový model: populační průměr (s)',35],['Výukový model: populační směrodatná odchylka (s)',15],['Výukový model: směrodatná chyba rozdílu průměrů (s)',2.1213]],'Souhrny studie uvádí Howell (2013, s. 86) podle Rubacka a Juienga (1997); jednotlivé doby řidičů nejsou známy. Průměr 35 a směrodatnou odchylku 15 zvolil pro simulaci Howell (s. 87). Tvar populace zešikmený doprava a shodné rozdělení obou skupin jsou autorské předpoklady výukového modelu.'),
    item('Tipovani','Výklad: výběrové rozdělení podílu a binomický test',['Vstup','Hodnota'],[['Počet otázek',20],['Počet možností u otázky',4],['Pravděpodobnost správného tipu',.25],['Počet správných odpovědí studenta',10],['Počet otázek delšího testu',80]],'Model zcela náhodného a nezávislého tipování z kapitoly 5. Hotový test je na listu Binom_test.'),
    item('Devet_vyberu','Výklad: všech devět výběrů dvou dob',['Výběr','První doba (s)','Druhá doba (s)'],[[1,20,20],[2,20,35],[3,20,50],[4,35,20],[5,35,35],[6,35,50],[7,50,20],[8,50,35],[9,50,50]],'Autorská modelová populace tří stejně pravděpodobných dob 20, 35 a 50 s; výběr dvou dob s vracením. Řádek je možný výběr, nikoli pozorovaný řidič. Průměry a jejich rozdělení dopočítejte sami.'),
    item('Pozornost','Výklad: z-test průměru',['Vstup','Hodnota'],[['Průměr podle norem (body)',50],['Směrodatná odchylka podle norem (body)',10],['Velikost výběru',25],['Výběrový průměr (body)',46],['Hladina významnosti',.05]],'Autorský ilustrační model skóru pozornosti z kapitoly 4; nejde o normy skutečného testu ani o skutečný výzkum. Hotový test je na listu Z_test.'),
    vector('U02_body','Cvičení 2','Výsledek úlohy (body)',[1,2,6],'Autorská modelová populace tří stejně pravděpodobných výsledků. Řádek je možná hodnota, nikoli účastník.'),
    item('U03_podil','Cvičení 3',['Vstup','Hodnota'],[['Podíl v populaci',.4],['Velikost menšího výběru',25],['Velikost většího výběru',100],['Hranice výběrového podílu',.52]]),
    item('U04_vybery','Cvičení 4: dva výběry z téže populace',['Výběr A (s)','Výběr B (s)'],[22,25,28,30,31,33,36,40,43].map((v,i)=>[v,[20,26,29,33,35,38,41,47,55][i]]),'Autorské ilustrační doby řešení. Sloupce jsou dva různé výběry devíti studentů, nikoli spárovaná měření týchž lidí.'),
    item('U04_model','Cvičení 4: modelová populace',['Vstup','Hodnota'],[['Populační průměr (s)',34],['Populační směrodatná odchylka (s)',9]]),
    item('U05_IQ','Cvičení 5',['Vstup','Hodnota'],[['Populační průměr',100],['Populační směrodatná odchylka',15],['Velikost výběru',9],['Hranice',105],['Druhá velikost výběru',36]],'Upraveno podle starší úlohy kurzu k výběrovému rozdělení průměru.'),
    item('U08_pokus','Cvičení 8',['Vstup','Hodnota'],[['Počet pokusů',8],['Hraniční pravděpodobnost správné odpovědi',.5],['Pozorovaný počet správných odpovědí',7],['Počet správných odpovědí v části e)',6],['Hladina významnosti',.05]],'Čísla podle Howella (2013, s. 129–130); znění zadání je upraveno.'),
    item('U09_pamet','Cvičení 9',['Vstup','Hodnota'],[['Hodnota podle nulové hypotézy (body)',100],['Populační směrodatná odchylka (body)',15],['Velikost výběru',36],['Výběrový průměr (body)',104.5],['Hladina významnosti',.05]]),
    item('U10_sila','Cvičení 10: zadaná statistická síla',['Velikost výběru','Síla při skutečném rozdílu 2 body','Síla při skutečném rozdílu 5 bodů'],[[25,.17,.71],[100,.52,1]],'Zaokrouhlené hodnoty z normálního modelu: oboustranný test, hladina 0,05, směrodatná odchylka 10 bodů. Nejde o jednotlivá pozorování.'),
    item('U11_vysledky','Cvičení 11: výsledky k interpretaci',['Situace','Test','P-hodnota','Pozorovaný rozdíl: trénink minus kontrola (body)'],[[1,'oboustranný',.003,4],[2,'oboustranný',.21,3],[3,'oboustranný',.01,-5],[4,'jednostranný, alternativa „trénink více“',.98,-5],[5,'oboustranný',.049,2],[6,'oboustranný',.051,2]],'Autorské modelové výsledky šesti smyšlených studií; hladina významnosti 0,05. V situaci 1 jde o padesátibodovou škálu, v situaci 2 je ve skupině 12 lidí.'),
    item('U12_studie','Cvičení 12',['Vstup','Hodnota'],[['Populační směrodatná odchylka (body)',10],['Hodnota podle nulové hypotézy (body)',50],['Výběrový průměr v obou studiích (body)',51],['Velikost výběru první studie',25],['Velikost výběru druhé studie',2500],['Počet testů v části c)',20],['Hladina významnosti',.05]]),
    item('U13_sila','Nepovinné cvičení 13',['Vstup','Hodnota'],[['Hraniční hodnota podle nulové hypotézy (body)',50],['Populační směrodatná odchylka (body)',10],['Velikost výběru',25],['Hladina významnosti',.05],['První uvažovaný populační průměr (body)',45],['Druhý uvažovaný populační průměr (body)',47]],'V části c) zvětšete výběr na 100 studentů.'),
    item('U14_screening','Nepovinné cvičení 14',['Vstup','Hodnota'],[['Počet výzkumů',1000],['Podíl výzkumů se skutečným rozdílem',.2],['Statistická síla',.6],['Hladina významnosti',.05],['Síla v části c)',.9]],'Smyšlené hodnoty. Podíl výzkumů se skutečným rozdílem v praxi neznáme.'),
  ]
};

export const existing = {
  1: [],
  2: [['Data','A2:E37','36 osob; výklad a cvičení 10'],['Cetnosti','A4:H8','Hotové výpočty a graf odpočatosti'],['Histogram','A4:E10','Hotové intervalové četnosti a histogram']],
  3: [['Data','A2:E37','Spánek a paměť; cvičení 12'],['Priklad','A1:J21','Hotové výpočty pro pět časů'],['Souhrn','A1:D16','Hotový souhrn spánku a paměti'],['Rozsireni','A1:J14','Hotové nepovinné výpočty'],['Kontrola_prikladu','A1:H42','Kontrolní výpočty; vstupy na Kvantily, Orezani, Boxplot']],
  4: [['Model','A1:D25','Hotové převody modelu N(50, 10)'],['QQ','A1:N24','Hotový Q–Q graf a mezivýpočty']],
  5: [['Bayes','A1:B20','Hotové přirozené četnosti, úplná pravděpodobnost a Bayesova věta'],['Binom','A1:D19','Hotové binomické rozdělení pro pět otázek'],['Binom_20','A1:E22','Hotové výpočty právě, nejvýše a alespoň pro dvacet otázek'],['Aproximace','A1:B16','Hotová normální aproximace, přesná hodnota a převod na podíl']],
  6: [['Chyba','A1:B13','Hotový výpočet pravděpodobnosti výběrového průměru'],['Test_rozdilu','A1:B11','Hotový test rozdílu dvou průměrů ve výukovém modelu'],['Binom_test','A1:E22','Hotový binomický test a pravděpodobnosti alespoň k úspěchů'],['Z_test','A1:B16','Hotový z-test průměru při známé směrodatné odchylce'],['Sila','A1:B8','Hotový výpočet statistické síly; nepovinné rozšíření']]
};

export async function addStudentInputs(wb,chapter,out) {
  if(chapter===1){
    const readSim=async name=>(await fs.readFile(`tmp/chapter-01-build/${name}.csv`,'utf8')).trim().split(/\r?\n/).slice(1).map(line=>line.split(','));
    inputs[1]=inputs[1].filter(s=>!['Podpora_ucitele','Jednickari'].includes(s.name));
    inputs[1].push(
      item('Podpora_ucitele','Nepovinné rozšíření: společná příčina',['Podpora vyučujícího','Studijní motivace (body)','Školní úspěšnost (body)'],(await readSim('support')).map(r=>[r[0],+r[1],+r[2]]),'Vlastní simulace, 300 studentů, bez chybění. Podpora: nízká, střední, vysoká. Vyšší body = více motivace či úspěšnosti. Nejde o skutečné testy ani známky.'),
      item('Jednickari','Nepovinné rozšíření: společný následek',['Inteligence (ilustrační skór)','Studijní motivace (body)','Skupina'],(await readSim('selection')).map(r=>[+r[0],+r[1],r[2]]),'Vlastní simulace, 600 studentů, bez chybění; inspirace: Griffith et al. (2020), obr. 1, doi:10.1038/s41467-020-19478-2. Skór inteligence podobný IQ, motivace v bodech. Jedničkáři = výborný výsledek ovlivněný oběma vlastnostmi a dalšími vlivy.'));
  }
  const specs=[...inputs[chapter]];
  if(chapter===4){
    const q=(await fs.readFile('data/kapitola_04.csv','utf8')).trim().split(/\r?\n/).slice(1).map(l=>+l.split(',')[1]);
    specs.push(vector('QQ_data','Výklad Q–Q; cvičení 9','Skór (body)',q,'Seřazené autorské skóry. Sestavte vlastní graf; hotová kontrola je na listu QQ. V úloze 9 změňte 65 na 90 a poté obnovte 65.'));
    const sim=JSON.parse(await fs.readFile('tmp/sesity-simulace.json','utf8'));
    for(const [key,values] of Object.entries(sim))specs.push(vector(`Sim_${key}`,'Obrázky histogramů a Q–Q grafů','Simulovaný skór (body)',values,'Simulovaná data z obrázků kapitoly, 200 hodnot. Nejde o skutečný test ani o nezadaná individuální data cvičení 10.'));
  }
  await populateStudentInputs(wb,chapter,out,specs);
}

export async function populateStudentInputs(wb,chapter,out,specs) {
  const overview=wb.worksheets.getItem('Prehled');
  const catalog=[];
  for(const spec of specs){
    const sh=wb.worksheets.add(spec.name),end=String.fromCharCode(64+spec.headers.length),last=spec.rows.length+1;
    sh.showGridLines=true;
    sh.getRange(`A1:${end}${last}`).format={font:{name:'Arial',size:11,color:'#223744'},columnWidth:22,rowHeight:25,verticalAlignment:'center'};
    sh.getRange(`A1:${end}1`).values=[spec.headers];
    sh.getRange(`A1:${end}1`).format={fill:'#234F62',font:{bold:true,color:'#FFFFFF'},wrapText:true,rowHeight:46};
    sh.getRange(`A2:${end}${last}`).values=spec.rows;
    sh.getRange(`A2:${end}${last}`).format.fill='#FFF1CB';
    for(let j=0;j<spec.headers.length;j++){
      const c=String.fromCharCode(65+j);
      const width=Math.min(48,Math.max(22,...spec.rows.map(r=>typeof r[j]==='string'?r[j].length+2:0)));
      sh.getRange(`${c}1:${c}${last}`).format.columnWidth=width;
      sh.getRange(`${c}2:${c}${last}`).format.wrapText=true;
    }
    sh.getRange(`A2:${end}${last}`).setNumberFormat('General');
    if(spec.name.startsWith('Sim_'))sh.getRange(`A2:A${last}`).setNumberFormat('0.000000');
    if(spec.name==='Promenne'){
      sh.getRange('A1:A6').format.columnWidth=18;sh.getRange('B1:C6').format.columnWidth=48;sh.getRange('D1:D6').format.columnWidth=22;
      sh.getRange('A2:D6').format.wrapText=true;sh.getRange('A2:D6').format.rowHeight=40;
    }
    if(spec.name==='U08_podklady'){sh.getRange('B1:B4').format.columnWidth=26;sh.getRange('C1:C4').format.columnWidth=48;}
    const noteCol=String.fromCharCode(66+spec.headers.length);
    sh.getRange(`${noteCol}1`).values=[['Použití a původ']];
    sh.getRange(`${noteCol}1:${noteCol}7`).format={font:{name:'Arial',size:11,color:'#526775'},columnWidth:60,wrapText:true,verticalAlignment:'top'};
    sh.getRange(`${noteCol}2:${noteCol}3`).merge();sh.getRange(`${noteCol}2`).values=[[spec.use]];
    sh.getRange(`${noteCol}4:${noteCol}7`).merge();sh.getRange(`${noteCol}4`).values=[[spec.note]];
    sh.freezePanes.freezeRows(1);
    catalog.push([spec.name,`A2:${end}${last}`,spec.use]);
  }
  const list=[...catalog,...existing[chapter]];
  overview.showGridLines=false;
  overview.getRange(`A1:C${list.length+10}`).format={font:{name:'Arial',size:11,color:'#223744'},rowHeight:30,verticalAlignment:'center'};
  overview.getRange('A1:C1').merge();overview.getRange('A1').values=[[`Data ke kapitole ${chapter}`]];overview.getRange('A1').format.font={bold:true,size:16};
  overview.getRange('A3:C3').merge();overview.getRange('A3').values=[['Začněte vstupy. Žluté buňky obsahují data; modré buňky na výpočtových listech vzorce.']];
  overview.getRange('A4:C4').merge();overview.getRange('A4').values=[['Zadání a vysvětlení jsou v kapitole. Řešení otevírejte až po vlastním pokusu.']];
  overview.getRange('A5:C5').merge();overview.getRange('A5').values=[['Slovní úlohy bez konkrétních pozorování nevyžadují vlastní datový list.']];
  overview.getRange('A6:C6').merge();overview.getRange('A6').values=[['Hladké modelové křivky jsou modely, nikoli další soubory naměřených hodnot.']];
  overview.getRange('A7:C7').values=[['List','Oblast vstupů / tabulky','Příklad nebo cvičení']];
  overview.getRange('A7:C7').format={fill:'#234F62',font:{bold:true,color:'#FFFFFF'}};
  overview.getRange(`A8:C${list.length+7}`).values=list;
  overview.getRange(`A1:A${list.length+7}`).format.columnWidth=25;
  overview.getRange(`B1:B${list.length+7}`).format.columnWidth=25;
  overview.getRange(`C1:C${list.length+7}`).format.columnWidth=70;
  overview.freezePanes.freezeRows(7);
  await fs.writeFile(`${out}/inputs.json`,JSON.stringify(specs,null,2));
}
