// Native Excel workbook for chapter 10 (correlation). Data sets and fixed resampling indices come from
// scripts/kapitola_10.R (written to tmp/chapter-10-indices/), so the book and the workbook use the same numbers.
// Resampling sheets use whole-range Czech formulas; Kendall sums over all pairs use dynamic-array formulas
// (Formula2Local), which need Excel for Microsoft 365 or Excel 2021 and later.
import fs from 'node:fs/promises';
import {populateStudentInputs} from './sesity-data.mjs';
import {ExcelWorkbook} from './excel-workbook.mjs';
const out='tmp/chapter-10-build';await fs.mkdir(out,{recursive:true});
const src='tmp/chapter-10-indices';
const csv=async(name,header=true)=>{
  const lines=(await fs.readFile(`${src}/${name}`,'utf8')).replace(/^﻿/,'').trim().split(/\r?\n/);
  return lines.slice(header?1:0).map(l=>l.split(',').map(v=>v===''||v==='NA'?null:(Number.isNaN(Number(v))?v:Number(v))));
};
const [m6,uz,ss,t6,k8,rpb,rat,u03,u05,u06,u07,u08,u12,u16]=await Promise.all(
  ['m6','uz','ss','t6','k8','rpb','rat','u03','u05','u06','u07','u08','u12','u16'].map(n=>csv(`${n}.csv`)));
const bootIdx=await csv('boot_idx.csv',false), permIdx=await csv('perm_idx.csv',false), perm6=await csv('perm6_idx.csv',false);
const res9999=Object.fromEntries((await csv('vysledky_9999.csv')).map(([k,v])=>[k,v]));
if(bootIdx.length!==1999||permIdx.length!==1999||perm6.length!==720)throw new Error('Unexpected resampling index size');
const own='Autorský ilustrační model; nejde o skutečný výzkum.';
const spec=(name,use,headers,rows,note=own)=>({name,use,headers,rows,note});
const hAnx=['Student (ID)','Úzkost před testem (body)','Výkon v testu (body)'];
const hSS=['Student (ID)','Vnímaný stres (body, 0–16)','Kvalita spánku (1 = velmi špatná, 7 = velmi dobrá)'];
const specs=[
  spec('Mala_ukazka','Výklad: kovariance, Pearsonovo r, Kendallovo τa (tab. 10.1)',hAnx,m6,'Autorský ilustrační model šesti studentů; tytéž hodnoty jsou předvyplněny na listu Kovariance.'),
  spec('Uzkost','Výklad: bodový graf, Pearsonovo r, test a interval (40 studentů)',hAnx,uz,'Autorský ilustrační model; úzkost 10–40 bodů (vyšší = větší úzkost), výkon 0–30 bodů. Hotový test je na listu Pearson.'),
  spec('Stres_spanek','Výklad: pořadová data, Spearman, Kendall, permutace, bootstrap (30 studentů)',hSS,ss,'Autorský ilustrační model; kvalita spánku je pořadová škála. Tytéž hodnoty jsou předvyplněny na listech Spearman a Prevzorkovani_data.'),
  spec('Male_poradi','Výklad: průměrná pořadí, τb se shodami a přesný permutační test (tab. 10.3 a 10.4)',hSS,t6,'Autorský ilustrační model šesti studentů se shodnými hodnotami; předvyplněno na listech Kendall a Perm_presna.'),
  spec('Spanek_k8','Výklad: relativní postavení a průměrná změna (data kapitoly 8)',['Student (ID)','Skór po běžném spánku (body)','Skór po krátkém spánku (body)'],k8,'Dvanáct úplných dvojic z listu Spanek_par sešitu kapitoly 8 (student 9 bez druhého měření vynechán). Hotový výpočet je na listu Parova_korelace.'),
  spec('Skupiny_k8','Výklad: bodově biseriální korelace (data kapitoly 8)',['Skupina (0 = běžný spánek, 1 = krátký spánek)','Skór pozornosti (body)'],rpb,'Dvě nezávislé skupiny z listu Spanek_skupiny sešitu kapitoly 8 (30 a 12 studentů), zapsané jako kód skupiny a skór. Hotový výpočet je na listu Rpb.'),
  spec('Hodnotitele','Výklad: vysoká korelace bez shody hodnot',['Esej (ID)','Hodnotitelka A (body)','Hodnotitel B (body)'],rat),
  spec('U03','Cvičení 3 a 4',['Student (ID)','Spánek (hodiny)','Počet chyb'],u03),
  spec('U05','Cvičení 5',['Esej','Pořadí podle hodnotitelky 1','Pořadí podle hodnotitelky 2'],u05,'Autorský příklad; hodnotitelky zaznamenaly jen pořadí (1 = nejlepší).'),
  spec('U06','Cvičení 6',['Student (ID)','Zájem o předmět (1–5)','Příprava (hodiny týdně)'],u06),
  spec('U07','Cvičení 7',['Student (ID)','Pořadí X','Pořadí Y'],u07),
  spec('U08','Cvičení 8',hSS,u08),
  spec('U12','Cvičení 12 a 13',['Student (ID)','Sociální opora (body, 5–25)','Osamělost (body, 0–20)'],u12,'Autorský ilustrační model. Pro převzorkování zkopírujte B2:C31 na list Prevzorkovani_data (B2:C31).'),
  spec('U16','Cvičení 16',['Student (ID)','Sociální sítě (minut denně)','Osamělost (body, 0–20)'],u16,'Autorský ilustrační model. Student 17 má záměrně nevěrohodný údaj 900 minut; úloha s ním počítá.')
];
// Calculation sheets: [cell, kind, value or Czech formula, number format]. Kinds: head, label, input, calc, note.
// calc2 marks dynamic-array formulas (Formula2Local).
const L=(a,v)=>[a,'label',v],I=(a,v,f='General')=>[a,'input',v,f],C=(a,v,f='0.000')=>[a,'calc',v,f],C2=(a,v,f='0.000')=>[a,'calc2',v,f],N=(a,v)=>[a,'note',v],H=(a,v)=>[a,'head',v];
const kovRows=[];
for(let i=0;i<10;i++){const R=i+2,row=m6[i];
  kovRows.push(L(`A${R}`,i+1),I(`B${R}`,row?row[1]:null,'0'),I(`C${R}`,row?row[2]:null,'0'),
    C(`D${R}`,`=KDYŽ(B${R}="";"";B${R}-$L$3)`,'0.00'),C(`E${R}`,`=KDYŽ(C${R}="";"";C${R}-$L$4)`,'0.00'),
    C(`F${R}`,`=KDYŽ(B${R}="";"";D${R}*E${R})`,'0.00'),C(`G${R}`,`=KDYŽ(B${R}="";"";D${R}/$L$8)`,'0.000'),
    C(`H${R}`,`=KDYŽ(C${R}="";"";E${R}/$L$9)`,'0.000'),C(`I${R}`,`=KDYŽ(B${R}="";"";G${R}*H${R})`,'0.000'));}
const spRows=[];
for(let i=0;i<40;i++){const R=i+2,row=ss[i];
  spRows.push(L(`A${R}`,i+1),I(`B${R}`,row?row[1]:null,'0'),I(`C${R}`,row?row[2]:null,'0'),
    C(`D${R}`,`=KDYŽ(B${R}="";"";RANK.AVG(B${R};$B$2:$B$41;1))`,'0.0'),C(`E${R}`,`=KDYŽ(C${R}="";"";RANK.AVG(C${R};$C$2:$C$41;1))`,'0.0'));}
const pairs=[];for(let i=1;i<=6;i++)for(let j=i+1;j<=6;j++)pairs.push([i,j]);
const kenRows=[];
t6.forEach((row,i)=>kenRows.push(L(`A${i+2}`,i+1),I(`B${i+2}`,row[1],'0'),I(`C${i+2}`,row[2],'0')));
pairs.forEach(([i,j],k)=>{const R=k+2;
  kenRows.push(L(`E${R}`,i),L(`F${R}`,j),
    C(`G${R}`,`=KDYŽ(NEBO(INDEX($B$2:$B$7;E${R})="";INDEX($B$2:$B$7;F${R})="");"";SIGN(INDEX($B$2:$B$7;E${R})-INDEX($B$2:$B$7;F${R})))`,'0'),
    C(`H${R}`,`=KDYŽ(NEBO(INDEX($C$2:$C$7;E${R})="";INDEX($C$2:$C$7;F${R})="");"";SIGN(INDEX($C$2:$C$7;E${R})-INDEX($C$2:$C$7;F${R})))`,'0'),
    C(`I${R}`,`=KDYŽ(NEBO(G${R}="";H${R}="");"";G${R}*H${R})`,'0'),
    C(`J${R}`,`=KDYŽ(I${R}="";"";KDYŽ(I${R}=1;"konkordantní";KDYŽ(I${R}=-1;"diskordantní";"shoda")))`,'General'));});
const X='Prevzorkovani_data!B2:B31',Y='Prevzorkovani_data!C2:C31';
const sumSign=(a,b)=>`SOUČIN.SKALÁRNÍ(SIGN(${a}-TRANSPOZICE(${a}))*SIGN(${b}-TRANSPOZICE(${b})))`;
const ties=a=>`(SOUČIN.SKALÁRNÍ(--(${a}=TRANSPOZICE(${a})))-30)/2`;
const sheets=[
 {name:'Kovariance',widths:{A:10,B:14,C:14,D:14,E:14,F:14,G:12,H:12,I:14,J:3,K:50,L:14},cells:[
  H('A1','Student'),H('B1','X: úzkost (body)'),H('C1','Y: výkon (body)'),H('D1','x − průměr x'),H('E1','y − průměr y'),H('F1','Součin odchylek'),
  H('G1','z-skór x'),H('H1','z-skór y'),H('I1','Součin z-skórů'),H('K1','Výsledek'),H('L1','Hodnota'),...kovRows,
  L('K2','Počet úplných dvojic n'),C('L2','=POČET(B2:B11)','0'),L('K3','Průměr X'),C('L3','=PRŮMĚR(B2:B11)'),L('K4','Průměr Y'),C('L4','=PRŮMĚR(C2:C11)'),
  L('K5','Součet součinů odchylek'),C('L5','=SUMA(F2:F11)','0.00'),L('K6','Kovariance s_xy'),C('L6','=L5/(L2-1)'),
  L('K7','Kovariance funkcí COVARIANCE.S'),C('L7','=COVARIANCE.S(B2:B11;C2:C11)'),
  L('K8','Směrodatná odchylka s_x'),C('L8','=SMODCH.VÝBĚR.S(B2:B11)'),L('K9','Směrodatná odchylka s_y'),C('L9','=SMODCH.VÝBĚR.S(C2:C11)'),
  L('K10','Pearsonovo r = s_xy / (s_x s_y)'),C('L10','=L6/(L8*L9)'),L('K11','r = součet součinů z-skórů / (n − 1)'),C('L11','=SUMA(I2:I11)/(L2-1)'),
  L('K12','r funkcí CORREL'),C('L12','=CORREL(B2:B11;C2:C11)'),
  N('K14','Výchozí vstupy: šest studentů (list Mala_ukazka). Žlutě: vstupy. Modře: výpočty.'),
  N('K15','Pro jiná data přepište B2:C11; nepoužité řádky nechte prázdné.')]},
 {name:'Pearson',widths:{A:52,B:14,C:3,D:60},cells:[
  H('A1','Test nulové korelace a Fisherův interval'),H('B1','Hodnota'),
  L('A2','Počet úplných dvojic n'),I('B2',uz.length,'0'),L('A3','Pearsonovo r'),I('B3',null,'0.000'),L('A4','Hladina spolehlivosti'),I('B4',.95,'0.00'),
  L('A5','Kontrola: r z dat listu Uzkost'),C('B5','=CORREL(Uzkost!B2:B41;Uzkost!C2:C41)'),
  L('A7','Testová statistika t'),C('B7','=B3*ODMOCNINA(B2-2)/ODMOCNINA(1-B3^2)'),L('A8','Stupně volnosti'),C('B8','=B2-2','0'),
  L('A9','Oboustranná p-hodnota'),C('B9','=T.DIST.2T(ABS(B7);B8)','0.0000'),
  L('A11','Fisherova transformace z_r'),C('B11','=FISHER(B3)'),L('A12','Směrodatná chyba 1/√(n − 3)'),C('B12','=1/ODMOCNINA(B2-3)'),
  L('A13','Kvantil z'),C('B13','=NORM.S.INV(1-(1-B4)/2)'),L('A14','Dolní mez na stupnici z_r'),C('B14','=B11-B13*B12'),L('A15','Horní mez na stupnici z_r'),C('B15','=B11+B13*B12'),
  L('A16','Dolní mez intervalu pro ρ'),C('B16','=FISHERINV(B14)'),L('A17','Horní mez intervalu pro ρ'),C('B17','=FISHERINV(B15)'),
  N('D2','Výchozí vstupy: 40 studentů (list Uzkost); r je zapsáno s plnou přesností z B5.'),N('D4','Žlutě: vstupy. Modře: výpočty.'),
  N('D9','Test předpokládá nezávislé případy a dvourozměrné normální rozdělení.'),N('D16','Fisherův interval je přibližný a není souměrný kolem r.')]},
 {name:'Spearman',widths:{A:10,B:16,C:16,D:14,E:14,F:3,G:40,H:14},cells:[
  H('A1','Student'),H('B1','X: vnímaný stres'),H('C1','Y: kvalita spánku'),H('D1','Pořadí X'),H('E1','Pořadí Y'),H('G1','Výsledek'),H('H1','Hodnota'),...spRows,
  L('G2','Počet hodnot X'),C('H2','=POČET(B2:B41)','0'),L('G3','Spearmanův koeficient r_s'),C('H3','=CORREL(D2:D41;E2:E41)'),
  L('G4','Pro srovnání: Pearsonovo r z původních hodnot'),C('H4','=CORREL(B2:B41;C2:C41)'),
  N('G6','Výchozí vstupy: 30 studentů (list Stres_spanek). Pro jiná data přepište B2:C41 (až 40 lidí), nepoužité řádky nechte prázdné.'),
  N('G7','RANK.AVG(...;1): nejmenší hodnota má pořadí 1; shodné hodnoty dostanou průměrné pořadí.')]},
 {name:'Kendall',widths:{A:10,B:14,C:14,D:3,E:8,F:8,G:12,H:12,I:12,J:16,K:3,L:3,M:46,N:14},cells:[
  H('A1','Student'),H('B1','X'),H('C1','Y'),H('E1','Člen i'),H('F1','Člen j'),H('G1','Znaménko X'),H('H1','Znaménko Y'),H('I1','Součin'),H('J1','Druh dvojice'),
  H('M1','Výsledek'),H('N1','Hodnota'),...kenRows,
  L('M2','Počet dvojic n(n − 1)/2'),C('N2','=POČET(B2:B7)*(POČET(B2:B7)-1)/2','0'),
  L('M3','Konkordantní dvojice n_c'),C('N3','=COUNTIF(I2:I16;1)','0'),L('M4','Diskordantní dvojice n_d'),C('N4','=COUNTIF(I2:I16;-1)','0'),
  L('M5','Dvojice se shodou v X (t_x)'),C('N5','=COUNTIF(G2:G16;0)','0'),L('M6','Dvojice se shodou v Y (t_y)'),C('N6','=COUNTIF(H2:H16;0)','0'),
  L('M7','Kendallovo τa'),C('N7','=(N3-N4)/N2'),L('M8','Kendallovo τb'),C('N8','=(N3-N4)/ODMOCNINA((N2-N5)*(N2-N6))'),
  N('M10','Výchozí vstupy: šest studentů se shodami (list Male_poradi). Pro jiná data (až 6 lidí) přepište B2:C7; nepoužité řádky nechte prázdné.'),
  N('M11','Znaménko 1: první člen dvojice má vyšší hodnotu; −1 nižší; 0 shoda.')]},
 {name:'Prevzorkovani_data',widths:{A:10,B:16,C:16,D:12,E:12,F:3,G:24},cells:[
  H('A1','Student'),H('B1','X'),H('C1','Y'),H('D1','Pořadí X'),H('E1','Pořadí Y'),
  ...ss.flatMap((row,i)=>[L(`A${i+2}`,i+1),I(`B${i+2}`,row[1],'0'),I(`C${i+2}`,row[2],'0'),
    C(`D${i+2}`,`=RANK.AVG(B${i+2};$B$2:$B$31;1)`,'0.0'),C(`E${i+2}`,`=RANK.AVG(C${i+2};$C$2:$C$31;1)`,'0.0')]),
  L('G1','Pomocné řádky (X a pořadí X vodorovně):'),L('G2','X'),L('G3','Pořadí X'),
  N('G5','Výchozí vstupy: stres a kvalita spánku 30 studentů. Pro cvičení 12 a 13 přepište B2:C31; vždy právě 30 úplných dvojic.')]},
 {name:'Permutace',widths:{A:52,B:14,C:14,D:3,E:58},cells:[
  H('A1','Permutační test nezávislosti'),H('B1','Hodnota'),
  L('A2','Pozorované r_s'),C('B2','=CORREL(Prevzorkovani_data!D2:D31;Prevzorkovani_data!E2:E31)'),
  L('A3','Pozorované n_c − n_d'),C2('B3',`=${sumSign(X,Y)}/2`,'0'),
  L('A4','Dvojice se shodou v X'),C2('B4',`=${ties(X)}`,'0'),L('A5','Dvojice se shodou v Y'),C2('B5',`=${ties(Y)}`,'0'),
  L('A6','Pozorované τb'),C('B6','=B3/ODMOCNINA((435-B4)*(435-B5))'),
  L('A8','Počet přeskupení B'),C('B8','=POČET(B13:B2011)','0'),
  L('A9','p-hodnota pro r_s'),C2('B9','=(SOUČIN.SKALÁRNÍ(--(ABS(B13:B2011)>=ABS(B2)-0,000000000001))+1)/(B8+1)','0.0000'),
  L('A10','p-hodnota pro τb'),C2('B10','=(SOUČIN.SKALÁRNÍ(--(ABS(C13:C2011)>=ABS(B6)-0,000000000001))+1)/(B8+1)','0.0000'),
  H('A12','Přeskupení'),H('B12','r_s'),H('C12','τb'),
  N('E2','Data: list Prevzorkovani_data. Každý řádek listu Perm_indexy je jedno přeskupení hodnot Y.'),
  N('E3','Vzorce se SOUČIN.SKALÁRNÍ a TRANSPOZICE vyžadují Excel s dynamickými poli (Microsoft 365, Excel 2021 a novější).'),
  N('E9','Nulová hypotéza: X a Y jsou nezávislé.')]},
 {name:'Bootstrap',widths:{A:44,B:14,C:12,D:10,E:10,F:12,G:3,H:44,I:14},cells:[
  H('A1','Percentilový bootstrapový interval'),H('B1','Hodnota'),
  L('A2','Pozorované r_s'),C('B2','=Permutace!B2'),L('A3','Pozorované τb'),C('B3','=Permutace!B6'),
  L('A5','Počet bootstrapových výběrů B'),C('B5','=ŘÁDKY(A13:A2011)','0'),
  L('A6','r_s: dolní mez (2,5. percentil)'),C('B6','=PERCENTIL.INC(B13:B2011;0,025)'),L('A7','r_s: horní mez (97,5. percentil)'),C('B7','=PERCENTIL.INC(B13:B2011;0,975)'),
  L('A8','τb: dolní mez (2,5. percentil)'),C('B8','=PERCENTIL.INC(F13:F2011;0,025)'),L('A9','τb: horní mez (97,5. percentil)'),C('B9','=PERCENTIL.INC(F13:F2011;0,975)'),
  L('A10','Výběry, v nichž koeficient nelze spočítat'),C('B10','=MAX(B5-POČET(B13:B2011);B5-POČET(F13:F2011))','0'),
  H('A12','Výběr'),H('B12','r_s'),H('C12','n_c − n_d'),H('D12','Shody X'),H('E12','Shody Y'),H('F12','τb'),
  H('H1','Hotové výsledky 9 999 opakování (jen výchozí data)'),H('I1','Hodnota'),
  L('H2','r_s: dolní mez'),C('I2',res9999.rs_dolni),L('H3','r_s: horní mez'),C('I3',res9999.rs_horni),
  L('H4','τb: dolní mez'),C('I4',res9999.tb_dolni),L('H5','τb: horní mez'),C('I5',res9999.tb_horni),
  L('H6','p-hodnota permutačního testu pro r_s'),C('I6',res9999.rs_p,'0.0000'),L('H7','p-hodnota permutačního testu pro τb'),C('I7',res9999.tb_p,'0.0000'),
  L('H8','Výběry, v nichž koeficient nelze spočítat'),C('I8',res9999.nedefinovane,'0'),
  N('H10','Pevné hodnoty spočítané stejným postupem v R a ověřené; po změně dat se nemění.')]},
 {name:'Perm_presna',widths:{A:6,B:6,C:6,D:6,E:6,F:6,G:6,H:6,I:6,J:6,K:6,L:6,M:6,N:6,O:6,P:6,Q:6,R:6,S:10,T:10,U:3,V:44,W:14},cells:[
  H('A1','Student'),H('B1','X'),H('C1','Y'),H('D1','Pořadí X'),H('E1','Pořadí Y'),H('G1','X a pořadí X vodorovně'),
  ...t6.flatMap((row,i)=>[L(`A${i+2}`,i+1),I(`B${i+2}`,row[1],'0'),I(`C${i+2}`,row[2],'0'),
    C(`D${i+2}`,`=RANK.AVG(B${i+2};$B$2:$B$7;1)`,'0.0'),C(`E${i+2}`,`=RANK.AVG(C${i+2};$C$2:$C$7;1)`,'0.0')]),
  H('V1','Výsledek'),H('W1','Hodnota'),
  L('V2','Pozorované r_s'),C('W2','=CORREL(D2:D7;E2:E7)'),
  L('V3','Pozorované n_c − n_d'),C2('W3','=SOUČIN.SKALÁRNÍ(SIGN(B2:B7-TRANSPOZICE(B2:B7))*SIGN(C2:C7-TRANSPOZICE(C2:C7)))/2','0'),
  L('V4','Dvojice se shodou v X'),C2('W4','=(SOUČIN.SKALÁRNÍ(--(B2:B7=TRANSPOZICE(B2:B7)))-6)/2','0'),
  L('V5','Dvojice se shodou v Y'),C2('W5','=(SOUČIN.SKALÁRNÍ(--(C2:C7=TRANSPOZICE(C2:C7)))-6)/2','0'),
  L('V6','Pozorované τb'),C('W6','=W3/ODMOCNINA((15-W4)*(15-W5))'),
  L('V8','Počet všech přiřazení'),C('W8','=ŘÁDKY(A11:A730)','0'),
  L('V9','Přesná p-hodnota pro r_s'),C2('W9','=SOUČIN.SKALÁRNÍ(--(ABS(S11:S730)>=ABS(W2)-0,000000000001))/W8','0.0000'),
  L('V10','Přesná p-hodnota pro τb'),C2('W10','=SOUČIN.SKALÁRNÍ(--(ABS(T11:T730)>=ABS(W6)-0,000000000001))/W8','0.0000'),
  H('A10','Přiřazení (čísla studentů)'),H('G10','Přeskupené Y'),H('M10','Pořadí přeskupeného Y'),H('S10','r_s'),H('T10','τb'),
  N('V12','Výchozí vstupy: šest studentů (list Male_poradi). Řádky 11–730 obsahují všech 720 přiřazení hodnot Y.')]},
 {name:'Parova_korelace',widths:{A:56,B:14,C:3,D:16},cells:[
  H('A1','Korelace dvou měření a rozptyl rozdílů'),H('B1','Hodnota'),H('D1','Rozdíl běžný − krátký'),
  L('A2','Pearsonovo r obou měření'),C('B2','=CORREL(Spanek_k8!B2:B13;Spanek_k8!C2:C13)'),
  L('A3','Směrodatná odchylka po běžném spánku s₁'),C('B3','=SMODCH.VÝBĚR.S(Spanek_k8!B2:B13)'),
  L('A4','Směrodatná odchylka po krátkém spánku s₂'),C('B4','=SMODCH.VÝBĚR.S(Spanek_k8!C2:C13)'),
  L('A5','Směrodatná odchylka rozdílů (přímo)'),C('B5','=SMODCH.VÝBĚR.S(D2:D13)'),
  L('A6','Táž ze vzorce √(s₁² + s₂² − 2 r s₁ s₂)'),C('B6','=ODMOCNINA(B3^2+B4^2-2*B2*B3*B4)'),
  L('A7','Směrodatná odchylka rozdílů, kdyby r = 0'),C('B7','=ODMOCNINA(B3^2+B4^2)'),
  L('A8','Průměrný rozdíl'),C('B8','=PRŮMĚR(D2:D13)','0.00'),
  ...Array.from({length:12},(_,i)=>C(`D${i+2}`,`=Spanek_k8!B${i+2}-Spanek_k8!C${i+2}`,'0'))]},
 {name:'Rpb',widths:{A:56,B:14,C:3,D:56},cells:[
  H('A1','Bodově biseriální korelace'),H('B1','Hodnota'),
  L('A2','r_pb (kód skupiny a skór)'),C('B2','=CORREL(Skupiny_k8!A2:A43;Skupiny_k8!B2:B43)'),
  L('A3','Počet studentů n'),C('B3','=POČET(Skupiny_k8!B2:B43)','0'),
  L('A4','t = |r_pb|·√(n − 2)/√(1 − r_pb²)'),C('B4','=ABS(B2)*ODMOCNINA(B3-2)/ODMOCNINA(1-B2^2)'),
  L('A5','Oboustranná p-hodnota'),C('B5','=T.DIST.2T(B4;B3-2)','0.0000'),
  L('A7','Nepovinně: velikost skupiny s kódem 0'),C('B7','=COUNTIF(Skupiny_k8!A2:A43;0)','0'),
  L('A8','Nepovinně: velikost skupiny s kódem 1'),C('B8','=COUNTIF(Skupiny_k8!A2:A43;1)','0'),
  L('A9','Nepovinně: h = (n₁ + n₂ − 2)(1/n₁ + 1/n₂)'),C('B9','=(B3-2)*(1/B7+1/B8)'),
  L('A10','Nepovinně: Cohenovo d z r_pb'),C('B10','=ABS(B2)*ODMOCNINA(B9)/ODMOCNINA(1-B2^2)'),
  N('D2','Znaménko r_pb závisí jen na kódování skupin.'),N('D4','Totéž t dává klasický t-test dvou nezávislých skupin (kapitola 8).')]},
 {name:'BCa',widths:{A:8,B:14,C:12,D:12,E:14,F:14,G:3,H:52,I:14},cells:[
  H('A1','Vynechaný i'),H('B1','Příspěvek i k n_c − n_d'),H('C1','Shody v X bez i'),H('D1','Shody v Y bez i'),H('E1','τb bez i'),H('F1','Průměr − τb bez i'),
  ...Array.from({length:30},(_,k)=>{const R=k+2;return [L(`A${R}`,k+1),
    C2(`B${R}`,`=SOUČIN.SKALÁRNÍ(SIGN(INDEX(${X};A${R})-${X})*SIGN(INDEX(${Y};A${R})-${Y}))`,'0'),
    C(`C${R}`,`=Permutace!$B$4-(COUNTIF(${X};INDEX(${X};A${R}))-1)`,'0'),
    C(`D${R}`,`=Permutace!$B$5-(COUNTIF(${Y};INDEX(${Y};A${R}))-1)`,'0'),
    C(`E${R}`,`=(Permutace!$B$3-B${R})/ODMOCNINA((406-C${R})*(406-D${R}))`,'0.0000'),
    C(`F${R}`,`=$I$2-E${R}`,'0.0000')];}).flat(),
  H('H1','Nepovinně: interval BCa pro τb'),H('I1','Hodnota'),
  L('H2','Průměr τb bez jednoho studenta'),C('I2','=PRŮMĚR(E2:E31)','0.0000'),
  L('H3','Zrychlení a'),C('I3','=SOUČIN.SKALÁRNÍ(F2:F31;F2:F31;F2:F31)/(6*SOUČIN.SKALÁRNÍ(F2:F31;F2:F31)^1,5)','0.0000'),
  L('H4','Podíl bootstrapových τb menších než pozorované'),C('I4','=COUNTIF(Bootstrap!F13:F2011;"<"&Bootstrap!B3)/POČET(Bootstrap!F13:F2011)','0.0000'),
  L('H5','Korekce zkreslení z₀'),C('I5','=NORM.S.INV(I4)','0.0000'),
  L('H6','Dolní percentil α₁'),C('I6','=NORM.S.DIST(I5+(I5+NORM.S.INV(0,025))/(1-I3*(I5+NORM.S.INV(0,025)));PRAVDA)','0.0000'),
  L('H7','Horní percentil α₂'),C('I7','=NORM.S.DIST(I5+(I5+NORM.S.INV(0,975))/(1-I3*(I5+NORM.S.INV(0,975)));PRAVDA)','0.0000'),
  L('H8','Interval BCa: dolní mez'),C('I8','=PERCENTIL.INC(Bootstrap!F13:F2011;I6)'),
  L('H9','Interval BCa: horní mez'),C('I9','=PERCENTIL.INC(Bootstrap!F13:F2011;I7)'),
  N('H11','Vychází z dat listu Prevzorkovani_data a výběrů listu Bootstrap. Dvojic bez jednoho studenta je 29 · 28 / 2 = 406.')]},
 {name:'Dve_korelace',widths:{A:56,B:14,C:3,D:56},cells:[
  H('A1','Nepovinně: porovnání dvou nezávislých korelací'),H('B1','Hodnota'),
  L('A2','Korelace v první skupině r₁'),I('B2',.41,'0.00'),L('A3','Velikost první skupiny n₁'),I('B3',59,'0'),
  L('A4','Korelace ve druhé skupině r₂'),I('B4',.53,'0.00'),L('A5','Velikost druhé skupiny n₂'),I('B5',47,'0'),
  L('A7','z_r první skupiny'),C('B7','=FISHER(B2)'),L('A8','z_r druhé skupiny'),C('B8','=FISHER(B4)'),
  L('A9','Směrodatná chyba rozdílu'),C('B9','=ODMOCNINA(1/(B3-3)+1/(B5-3))'),
  L('A10','Testová statistika z'),C('B10','=(B7-B8)/B9'),L('A11','Oboustranná p-hodnota'),C('B11','=2*(1-NORM.S.DIST(ABS(B10);PRAVDA))','0.0000'),
  N('D2','Výchozí vstupy: ženy a muži podle Cumminga a Calin-Jagemana (2024, s. 338–339).')]}
];
// Pearson r input with full precision (the value students obtain with CORREL in B5).
const rUz=(()=>{const x=uz.map(r=>r[1]),y=uz.map(r=>r[2]),mx=x.reduce((a,b)=>a+b)/x.length,my=y.reduce((a,b)=>a+b)/y.length;
  let sxy=0,sxx=0,syy=0;for(let i=0;i<x.length;i++){sxy+=(x[i]-mx)*(y[i]-my);sxx+=(x[i]-mx)**2;syy+=(y[i]-my)**2;}return sxy/Math.sqrt(sxx*syy);})();
sheets.find(s=>s.name==='Pearson').cells.find(c=>c[0]==='B3')[2]=rUz;

const wb=new ExcelWorkbook();wb.worksheets.add('Prehled');
for(const s of sheets){
 const sh=wb.worksheets.add(s.name);sh.showGridLines=true;
 sh.getRange('A1:W40').format={font:{name:'Arial',size:11,color:'#223744'},verticalAlignment:'center'};
 for(const [col,width] of Object.entries(s.widths))sh.getRange(`${col}1`).format.columnWidth=width;
 for(const [address,kind,value,format] of s.cells){
  const r=sh.getRange(address);
  if(kind==='calc2')r.fillFormula2Local(value);
  else if(typeof value==='string'&&value.startsWith('='))r.formulasLocal=[[value]];else r.values=[[value]];
  if(kind==='head')r.format={fill:'#234F62',font:{color:'#FFFFFF',bold:true},wrapText:true,rowHeight:34};
  if(kind==='input'||kind==='calc'||kind==='calc2'){r.format.fill=kind==='input'?'#FFF1CB':'#EAF4F8';r.setNumberFormat(format);}
  if(kind==='note')r.format={font:{color:'#526775'},wrapText:true,rowHeight:32};
 }
 sh.freezePanes.freezeRows(1);
}
// Horizontal helper rows for resampling.
const pd=wb.worksheets.getItem('Prevzorkovani_data');
pd.getRange('H2:AK2').fillFormulaLocal('=INDEX($B$2:$B$31;SLOUPEC()-7)');
pd.getRange('H3:AK3').fillFormulaLocal('=INDEX($D$2:$D$31;SLOUPEC()-7)');
const pp=wb.worksheets.getItem('Perm_presna');
pp.getRange('G2:L2').fillFormulaLocal('=INDEX($B$2:$B$7;SLOUPEC()-6)');
pp.getRange('G3:L3').fillFormulaLocal('=INDEX($D$2:$D$7;SLOUPEC()-6)');
// Exact permutations of six students: indices, permuted Y, permuted ranks, r_s and tau_b.
pp.getRange('A11:F730').values=perm6;
pp.getRange('G11:L730').fillFormulaLocal('=INDEX($C$2:$C$7;A11)');
pp.getRange('M11:R730').fillFormulaLocal('=INDEX($E$2:$E$7;A11)');
pp.getRange('S11:S730').fillFormulaLocal('=CORREL($G$3:$L$3;M11:R11)');
pp.getRange('T11:T730').fillFormula2Local('=SOUČIN.SKALÁRNÍ(SIGN($G$2:$L$2-TRANSPOZICE($G$2:$L$2))*SIGN(G11:L11-TRANSPOZICE(G11:L11)))/2/ODMOCNINA((15-$W$4)*(15-$W$5))');
pp.getRange('S11:T730').setNumberFormat('0.000');
// Index, value and rank sheets for 1 999 permutations and 1 999 bootstrap samples.
const helper=(name,note)=>{const sh=wb.worksheets.add(name);sh.showGridLines=true;
  sh.getRange('A1:AD1').values=[Array.from({length:30},(_,j)=>`Pozice ${j+1}`)];
  sh.getRange('A1:AD1').format={fill:'#234F62',font:{bold:true,color:'#FFFFFF'},wrapText:true,rowHeight:34};
  sh.getRange('AF1').values=[[note]];sh.getRange('AF1').format={font:{color:'#526775'},wrapText:false};
  sh.freezePanes.freezeRows(1);return sh;};
helper('Perm_indexy','Pevná přeskupení: řádek = jedno přeskupení; číslo říká, hodnota Y kterého studenta se přiřadí studentovi na dané pozici.').getRange('A2:AD2000').values=permIdx;
helper('Perm_Y','Přeskupené hodnoty Y (INDEX podle Perm_indexy).').getRange('A2:AD2000').fillFormulaLocal('=INDEX(Prevzorkovani_data!$C$2:$C$31;Perm_indexy!A2)');
helper('Perm_poradi_Y','Pořadí přeskupených hodnot Y.').getRange('A2:AD2000').fillFormulaLocal('=INDEX(Prevzorkovani_data!$E$2:$E$31;Perm_indexy!A2)');
helper('Boot_indexy','Pevné bootstrapové výběry: řádek = jeden výběr 30 studentů s vracením.').getRange('A2:AD2000').values=bootIdx;
helper('Boot_X','Hodnoty X vybraných studentů.').getRange('A2:AD2000').fillFormulaLocal('=INDEX(Prevzorkovani_data!$B$2:$B$31;Boot_indexy!A2)');
helper('Boot_Y','Hodnoty Y vybraných studentů.').getRange('A2:AD2000').fillFormulaLocal('=INDEX(Prevzorkovani_data!$C$2:$C$31;Boot_indexy!A2)');
helper('Boot_poradi_X','Pořadí X uvnitř každého bootstrapového výběru.').getRange('A2:AD2000').fillFormulaLocal('=RANK.AVG(Boot_X!A2;Boot_X!$A2:$AD2;1)');
helper('Boot_poradi_Y','Pořadí Y uvnitř každého bootstrapového výběru.').getRange('A2:AD2000').fillFormulaLocal('=RANK.AVG(Boot_Y!A2;Boot_Y!$A2:$AD2;1)');
const perm=wb.worksheets.getItem('Permutace');
perm.getRange('A13:A2011').values=Array.from({length:1999},(_,i)=>[i+1]);
perm.getRange('B13:B2011').fillFormulaLocal('=CORREL(Prevzorkovani_data!$H$3:$AK$3;Perm_poradi_Y!A2:AD2)');
perm.getRange('C13:C2011').fillFormula2Local('=SOUČIN.SKALÁRNÍ(SIGN(Prevzorkovani_data!$H$2:$AK$2-TRANSPOZICE(Prevzorkovani_data!$H$2:$AK$2))*SIGN(Perm_Y!A2:AD2-TRANSPOZICE(Perm_Y!A2:AD2)))/2/ODMOCNINA((435-$B$4)*(435-$B$5))');
perm.getRange('B13:C2011').setNumberFormat('0.000');
const boot=wb.worksheets.getItem('Bootstrap');
boot.getRange('A13:A2011').values=Array.from({length:1999},(_,i)=>[i+1]);
boot.getRange('B13:B2011').fillFormulaLocal('=IFERROR(CORREL(Boot_poradi_X!A2:AD2;Boot_poradi_Y!A2:AD2);"")');
boot.getRange('C13:C2011').fillFormula2Local('=SOUČIN.SKALÁRNÍ(SIGN(Boot_X!A2:AD2-TRANSPOZICE(Boot_X!A2:AD2))*SIGN(Boot_Y!A2:AD2-TRANSPOZICE(Boot_Y!A2:AD2)))/2');
boot.getRange('D13:D2011').fillFormula2Local('=(SOUČIN.SKALÁRNÍ(--(Boot_X!A2:AD2=TRANSPOZICE(Boot_X!A2:AD2)))-30)/2');
boot.getRange('E13:E2011').fillFormula2Local('=(SOUČIN.SKALÁRNÍ(--(Boot_Y!A2:AD2=TRANSPOZICE(Boot_Y!A2:AD2)))-30)/2');
boot.getRange('F13:F2011').fillFormulaLocal('=IFERROR(C13/ODMOCNINA((435-D13)*(435-E13));"")');
boot.getRange('B13:B2011').setNumberFormat('0.000');boot.getRange('F13:F2011').setNumberFormat('0.000');
await populateStudentInputs(wb,10,out,specs);
const overview=wb.worksheets.getItem('Prehled');
overview.getRange('A5').values=[['Slovní cvičení 1, 2, 4, 11, 14 a 15 nevyžadují vlastní datový list; cvičení 9, 10, 17 a 18 zadávají souhrny na listech Pearson, BCa a Dve_korelace.']];
overview.getRange('A6').values=[['Listy Perm_*, Boot_* a vzorce s TRANSPOZICE vyžadují Excel s dynamickými poli (Microsoft 365, Excel 2021 a novější).']];
overview.getRange('C1').format.columnWidth=78;
await wb.build(10,out);
