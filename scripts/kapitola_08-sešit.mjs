// Native Excel workbook for chapter 8. No simulated inputs; all data are declared in sesity-data.mjs.
import {inputs, populateStudentInputs} from './sesity-data.mjs';
import fs from 'node:fs/promises';
import {ExcelWorkbook} from './excel-workbook.mjs';
const out='tmp/chapter-08-build';await fs.mkdir(out,{recursive:true});
const specs=[...inputs[8]];
// Calculation sheets: [cell, kind, value or Czech formula, number format].
// Kinds: head, label, input, calc, note. Formulas use Czech names and semicolons.
const L=(a,v)=>[a,'label',v],I=(a,v,f='General')=>[a,'input',v,f],C=(a,v,f='0.000')=>[a,'calc',v,f],N=(a,v)=>[a,'note',v],H=(a,v)=>[a,'head',v];
// Complete pairs of Spanek_par in F2:I14; the incomplete pair stays empty in the same row.
const pairRows=[];
for(let r=2;r<=14;r++){
 pairRows.push(C(`F${r}`,`=Spanek_par!A${r}`,'0'));
 pairRows.push(C(`G${r}`,`=KDYŽ(A(JE.ČISLO(Spanek_par!B${r});JE.ČISLO(Spanek_par!C${r}));Spanek_par!B${r};"")`,'0'));
 pairRows.push(C(`H${r}`,`=KDYŽ(A(JE.ČISLO(Spanek_par!B${r});JE.ČISLO(Spanek_par!C${r}));Spanek_par!C${r};"")`,'0'));
 pairRows.push(C(`I${r}`,`=KDYŽ(G${r}="";"";G${r}-H${r})`,'0'));
}
// Change of each student in F2:F33 and the group label in G2:G33.
const changeRows=[];
for(let r=2;r<=33;r++){
 changeRows.push(C(`F${r}`,`=Trenink!D${r}-Trenink!C${r}`,'0'));
 changeRows.push(C(`G${r}`,`=Trenink!B${r}`,'General'));
}
const sheets=[
 {name:'Parovy_test',widths:{A:46,B:14,C:3,D:44,E:3,F:10,G:16,H:16,I:16},cells:[
  H('A1','Párový t-test'),H('B1','Hodnota'),
  H('F1','Student (ID)'),H('G1','Běžný spánek, úplná dvojice'),H('H1','Krátký spánek, úplná dvojice'),H('I1','Rozdíl běžný − krátký'),
  ...pairRows,
  L('A2','Počet úplných dvojic n'),C('B2','=POČET(I2:I14)','0'),
  L('A3','Průměrný rozdíl m_D'),C('B3','=PRŮMĚR(I2:I14)','0.000'),
  L('A4','Směrodatná odchylka rozdílů s_D'),C('B4','=SMODCH.VÝBĚR.S(I2:I14)','0.0000'),
  L('A5','Hladina spolehlivosti'),I('B5',.95,'0.00'),
  L('A7','Odhad směrodatné chyby'),C('B7','=B4/ODMOCNINA(B2)','0.0000'),
  L('A8','Stupně volnosti'),C('B8','=B2-1','0'),
  L('A9','Testová statistika t'),C('B9','=B3/B7','0.0000'),
  L('A10','P-hodnota oboustranně'),C('B10','=T.DIST.2T(ABS(B9);B8)','0.0000'),
  L('A11','Kvantil t-rozdělení'),C('B11','=T.INV(1-(1-B5)/2;B8)','0.0000'),
  L('A12','Dolní mez'),C('B12','=B3-B11*B7','0.00'),L('A13','Horní mez'),C('B13','=B3+B11*B7','0.00'),
  L('A14','Kontrola: párový T.TEST'),C('B14','=T.TEST(G2:G14;H2:H14;2;1)','0.0000'),
  N('D2','Data jsou na listu Spanek_par.'),N('D3','Neúplná dvojice zůstává prázdná ve svém řádku.'),N('D5','Žlutě: vstupy. Modře: výpočty.'),
  N('D9','Párový t-test = jednovýběrový t-test rozdílů.'),N('D14','T.TEST typu 1 vrací jen p-hodnotu.')]},
 {name:'Klasicky_test',widths:{A:50,B:14,C:3,D:56},cells:[
  H('A1','Klasický t-test pro dva nezávislé výběry'),H('B1','Hodnota'),
  L('A2','Průměr první skupiny m₁'),I('B2',39.03,'0.00'),L('A3','Výběrová směrodatná odchylka s₁'),I('B3',14.6,'0.00'),L('A4','Velikost první skupiny n₁'),I('B4',100,'0'),
  L('A5','Průměr druhé skupiny m₂'),I('B5',32.15,'0.00'),L('A6','Výběrová směrodatná odchylka s₂'),I('B6',14.6,'0.00'),L('A7','Velikost druhé skupiny n₂'),I('B7',100,'0'),
  L('A8','Hladina spolehlivosti'),I('B8',.95,'0.00'),
  L('A10','Rozdíl průměrů m₁ − m₂'),C('B10','=B2-B5','0.00'),
  L('A11','Společný odhad rozptylu'),C('B11','=((B4-1)*B3^2+(B7-1)*B6^2)/(B4+B7-2)','0.00'),
  L('A12','Společná směrodatná odchylka'),C('B12','=ODMOCNINA(B11)','0.000'),
  L('A13','Odhad směrodatné chyby rozdílu'),C('B13','=B12*ODMOCNINA(1/B4+1/B7)','0.0000'),
  L('A14','Stupně volnosti'),C('B14','=B4+B7-2','0'),
  L('A15','Testová statistika t'),C('B15','=B10/B13','0.0000'),
  L('A16','P-hodnota oboustranně'),C('B16','=T.DIST.2T(ABS(B15);B14)','0.0000'),
  L('A17','Kvantil t-rozdělení'),C('B17','=T.INV(1-(1-B8)/2;B14)','0.0000'),
  L('A18','Dolní mez intervalu pro rozdíl'),C('B18','=B10-B17*B13','0.00'),L('A19','Horní mez intervalu pro rozdíl'),C('B19','=B10+B17*B13','0.00'),
  L('A20','Cohenovo d'),C('B20','=B10/B12','0.0000'),
  N('D2','Výchozí vstupy: parkovací studie (list Parkovani).'),N('D8','Žlutě: vstupy. Modře: výpočty.'),
  N('D11','Předpokládá shodné rozptyly obou populací.'),N('D20','Ve jmenovateli je společná směrodatná odchylka, ne chyba.')]},
 {name:'Welch',widths:{A:52,B:14,C:3,D:58},cells:[
  H('A1','Welchův t-test pro dva nezávislé výběry'),H('B1','Hodnota'),
  L('A2','Průměr skupiny po běžném spánku m₁'),C('B2','=PRŮMĚR(Spanek_skupiny!A2:A31)','0.000'),
  L('A3','Výběrová směrodatná odchylka s₁'),C('B3','=SMODCH.VÝBĚR.S(Spanek_skupiny!A2:A31)','0.0000'),
  L('A4','Velikost skupiny n₁'),C('B4','=POČET(Spanek_skupiny!A2:A31)','0'),
  L('A5','Průměr skupiny po krátkém spánku m₂'),C('B5','=PRŮMĚR(Spanek_skupiny!B2:B13)','0.000'),
  L('A6','Výběrová směrodatná odchylka s₂'),C('B6','=SMODCH.VÝBĚR.S(Spanek_skupiny!B2:B13)','0.0000'),
  L('A7','Velikost skupiny n₂'),C('B7','=POČET(Spanek_skupiny!B2:B13)','0'),
  L('A8','Hladina spolehlivosti'),I('B8',.95,'0.00'),
  L('A10','Rozdíl průměrů m₁ − m₂'),C('B10','=B2-B5','0.000'),
  L('A11','Odhad směrodatné chyby rozdílu'),C('B11','=ODMOCNINA(B3^2/B4+B6^2/B7)','0.0000'),
  L('A12','Welchovy stupně volnosti'),C('B12','=(B3^2/B4+B6^2/B7)^2/((B3^2/B4)^2/(B4-1)+(B6^2/B7)^2/(B7-1))','0.000'),
  L('A13','Testová statistika t'),C('B13','=B10/B11','0.0000'),
  L('A14','P-hodnota oboustranně (T.TEST typu 3)'),C('B14','=T.TEST(Spanek_skupiny!A2:A31;Spanek_skupiny!B2:B13;2;3)','0.0000'),
  L('A15','Kvantil t-rozdělení bez zkrácení stupňů volnosti'),C('B15','=ODMOCNINA(B12*(1-BETA.INV(1-B8;B12/2;0,5))/BETA.INV(1-B8;B12/2;0,5))','0.0000'),
  L('A16','Dolní mez intervalu pro rozdíl'),C('B16','=B10-B15*B11','0.00'),L('A17','Horní mez intervalu pro rozdíl'),C('B17','=B10+B15*B11','0.00'),
  L('A19','Pro srovnání: p-hodnota klasického testu'),C('B19','=T.TEST(Spanek_skupiny!A2:A31;Spanek_skupiny!B2:B13;2;2)','0.0000'),
  L('A20','Pro srovnání: T.INV.2T se zkrácenými stupni volnosti'),C('B20','=T.INV.2T(1-B8;B12)','0.0000'),
  N('D2','Data jsou na listu Spanek_skupiny.'),N('D8','Žlutě: vstupy. Modře: výpočty.'),
  N('D12','Stupně volnosti nejsou celé číslo; nezaokrouhlují se.'),
  N('D15','T.INV a T.INV.2T by stupně volnosti zkrátily na celé číslo; tento vzorec vrací přesný kvantil.'),
  N('D20','Neodpovídá p-hodnotě v B14; jen pro ukázku zkrácení.')]},
 {name:'Zmeny',widths:{A:52,B:14,C:3,D:44,E:3,F:18,G:14},cells:[
  H('A1','Změna ve dvou skupinách'),H('B1','Hodnota'),H('F1','Změna po − před (body)'),H('G1','Skupina'),
  ...changeRows,
  L('A2','Trénink: počet studentů'),C('B2','=POČET(F2:F17)','0'),L('A3','Trénink: průměrná změna'),C('B3','=PRŮMĚR(F2:F17)','0.000'),
  L('A4','Trénink: směrodatná odchylka změn'),C('B4','=SMODCH.VÝBĚR.S(F2:F17)','0.0000'),
  L('A5','Kontrola: počet studentů'),C('B5','=POČET(F18:F33)','0'),L('A6','Kontrola: průměrná změna'),C('B6','=PRŮMĚR(F18:F33)','0.000'),
  L('A7','Kontrola: směrodatná odchylka změn'),C('B7','=SMODCH.VÝBĚR.S(F18:F33)','0.0000'),
  L('A8','Hladina spolehlivosti'),I('B8',.95,'0.00'),
  L('A10','Trénink: t změny (párový t-test)'),C('B10','=B3/(B4/ODMOCNINA(B2))','0.0000'),
  L('A11','Trénink: p-hodnota oboustranně'),C('B11','=T.DIST.2T(ABS(B10);B2-1)','0.0000'),
  L('A12','Kontrola: t změny (párový t-test)'),C('B12','=B6/(B7/ODMOCNINA(B5))','0.0000'),
  L('A13','Kontrola: p-hodnota oboustranně'),C('B13','=T.DIST.2T(ABS(B12);B5-1)','0.0000'),
  L('A15','Rozdíl průměrných změn trénink − kontrola'),C('B15','=B3-B6','0.000'),
  L('A16','Společná směrodatná odchylka změn'),C('B16','=ODMOCNINA(((B2-1)*B4^2+(B5-1)*B7^2)/(B2+B5-2))','0.0000'),
  L('A17','Odhad směrodatné chyby rozdílu změn'),C('B17','=B16*ODMOCNINA(1/B2+1/B5)','0.0000'),
  L('A18','Stupně volnosti'),C('B18','=B2+B5-2','0'),
  L('A19','Testová statistika t rozdílu změn'),C('B19','=B15/B17','0.0000'),
  L('A20','P-hodnota rozdílu změn oboustranně'),C('B20','=T.DIST.2T(ABS(B19);B18)','0.0000'),
  L('A21','Dolní mez intervalu pro rozdíl změn'),C('B21','=B15-T.INV(1-(1-B8)/2;B18)*B17','0.00'),
  L('A22','Horní mez intervalu pro rozdíl změn'),C('B22','=B15+T.INV(1-(1-B8)/2;B18)*B17','0.00'),
  N('D2','Data jsou na listu Trenink; řádky 2–17 trénink, 18–33 kontrola.'),N('D8','Žlutě: vstupy. Modře: výpočty.'),
  N('D10','Testy uvnitř skupin samy rozdíl mezi skupinami nedokládají.'),N('D19','O účinku tréninku rozhoduje rozdíl změn.')]},
 {name:'Ekvivalence_skupin',widths:{A:56,B:24,C:3,D:58},cells:[
  H('A1','Test rozdílu a test ekvivalence dvou skupin'),H('B1','Hodnota'),
  L('A2','Hranice ekvivalence Δ, zvolená předem'),I('B2',3,'0.00'),
  L('A3','Průměr první skupiny m₁ (online)'),I('B3',49.2,'0.00'),L('A4','Výběrová směrodatná odchylka s₁'),I('B4',10,'0.00'),L('A5','Velikost první skupiny n₁'),I('B5',200,'0'),
  L('A6','Průměr druhé skupiny m₂ (papír)'),I('B6',50.1,'0.00'),L('A7','Výběrová směrodatná odchylka s₂'),I('B7',10,'0.00'),L('A8','Velikost druhé skupiny n₂'),I('B8',200,'0'),
  L('A9','Hladina významnosti'),I('B9',.05,'0.00'),
  L('A11','Rozdíl průměrů m₁ − m₂'),C('B11','=B3-B6','0.00'),
  L('A12','Společná směrodatná odchylka'),C('B12','=ODMOCNINA(((B5-1)*B4^2+(B8-1)*B7^2)/(B5+B8-2))','0.000'),
  L('A13','Odhad směrodatné chyby rozdílu'),C('B13','=B12*ODMOCNINA(1/B5+1/B8)','0.0000'),
  L('A14','Stupně volnosti'),C('B14','=B5+B8-2','0'),
  L('A15','="Test rozdílu: dolní mez "&(100*(1-B9))&"% intervalu"'),C('B15','=B11-T.INV(1-B9/2;B14)*B13','0.00'),
  L('A16','="Test rozdílu: horní mez "&(100*(1-B9))&"% intervalu"'),C('B16','=B11+T.INV(1-B9/2;B14)*B13','0.00'),
  L('A17','Test rozdílu: oboustranná p-hodnota'),C('B17','=T.DIST.2T(ABS(B11/B13);B14)','0.0000'),
  L('A18','Test rozdílu: rozhodnutí'),C('B18','=KDYŽ(B17<=B9;"zamítáme nulovou hypotézu";"nulovou hypotézu nezamítáme")','General'),
  L('A19','="Test ekvivalence: dolní mez "&(100*(1-2*B9))&"% intervalu"'),C('B19','=B11-T.INV(1-B9;B14)*B13','0.00'),
  L('A20','="Test ekvivalence: horní mez "&(100*(1-2*B9))&"% intervalu"'),C('B20','=B11+T.INV(1-B9;B14)*B13','0.00'),
  L('A21','Test ekvivalence: závěr'),C('B21','=KDYŽ(A(B19>=-B2;B20<=B2);"ekvivalence doložena";"ekvivalence nedoložena")','General'),
  L('A23','Nepovinně: t vůči dolní hranici'),C('B23','=(B11+B2)/B13','0.000'),
  L('A24','Nepovinně: p-hodnota vůči dolní hranici'),C('B24','=1-T.DIST(B23;B14;PRAVDA)','0.0000'),
  L('A25','Nepovinně: t vůči horní hranici'),C('B25','=(B11-B2)/B13','0.000'),
  L('A26','Nepovinně: p-hodnota vůči horní hranici'),C('B26','=T.DIST(B25;B14;PRAVDA)','0.0000'),
  L('A27','Nepovinně: výsledná p-hodnota TOST'),C('B27','=MAX(B24;B26)','0.0000'),
  N('D2','Hranice stanovte před analýzou, ne podle výsledku.'),N('D3','Výchozí vstupy: velká studie z listu Ekv_studie.'),N('D9','Žlutě: vstupy. Modře: výpočty.'),
  N('D15','=(100*(1-B9))&"% interval slouží testu rozdílu."'),N('D19','=(100*(1-2*B9))&"% interval slouží testu ekvivalence:"'),N('D20','dva jednostranné testy, každý na hladině B9.'),
  N('D21','Interval nesmí přesáhnout hranice −Δ a Δ; přesný dotyk připouštíme.'),N('D27','Větší z obou p-hodnot; nejvýše B9 znamená ekvivalenci.')]}
];
const wb=new ExcelWorkbook();wb.worksheets.add('Prehled');
for(const spec of sheets){
 const sh=wb.worksheets.add(spec.name);sh.showGridLines=true;
 sh.getRange('A1:I33').format={font:{name:'Arial',size:11,color:'#223744'},verticalAlignment:'center'};
 for(const [col,width] of Object.entries(spec.widths))sh.getRange(`${col}1`).format.columnWidth=width;
 for(const [address,kind,value,format] of spec.cells){
  const r=sh.getRange(address);
  if(typeof value==='string'&&value.startsWith('='))r.formulasLocal=[[value]];else r.values=[[value]];
  if(kind==='head')r.format={fill:'#234F62',font:{color:'#FFFFFF',bold:true},wrapText:true,rowHeight:34};
  if(kind==='input'||kind==='calc'){r.format.fill=kind==='input'?'#FFF1CB':'#EAF4F8';r.setNumberFormat(format);}
  if(kind==='note')r.format={font:{color:'#526775'},wrapText:true,rowHeight:32};
 }
 sh.freezePanes.freezeRows(1);
}
await populateStudentInputs(wb,8,out,specs);
const overview=wb.worksheets.getItem('Prehled');
overview.getRange('A5').values=[['Slovní úlohy 1, 4, 8, 11 a 12 nevyžadují vlastní datový list.']];
overview.getRange('A6').values=[['Prázdná buňka ve vstupech znamená chybějící hodnotu; hodnoty ve stejném řádku k sobě patří jen u párových dat.']];
overview.getRange('C1').format.columnWidth=78;
await wb.build(8,out);
