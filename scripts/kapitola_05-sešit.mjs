// Native Excel workbook; run after scripts/sesity-simulace.R.
import {inputs, populateStudentInputs} from './sesity-data.mjs';
import fs from 'node:fs/promises';
import {ExcelWorkbook} from './excel-workbook.mjs';
const out='tmp/chapter-05-build';await fs.mkdir(out,{recursive:true});
const sim=JSON.parse(await fs.readFile('tmp/sesity-simulace-05.json','utf8'));
const specs=[...inputs[5]];
// The simulated answers follow the fixed test inputs they belong to.
specs.splice(specs.findIndex(s=>s.name==='Test_hadani')+1,0,{name:'Sim_hadani',use:'Obrázek: model a data; počet správných tipů z pěti',headers:['Počet správných tipů'],rows:sim.hadani.map(v=>[v]),note:'Simulovaná data z obrázku kapitoly: 40 studentů, každý pět nezávislých tipů s pravděpodobností úspěchu 0,25. Nejde o odpovědi skutečných lidí.'});
// Calculation sheets: [cell, kind, value or Czech formula, number format].
// Kinds: head, label, input, calc, note. Formulas use Czech names and semicolons.
const L=(a,v)=>[a,'label',v],I=(a,v,f='General')=>[a,'input',v,f],C=(a,v,f='0.000')=>[a,'calc',v,f],N=(a,v)=>[a,'note',v],H=(a,v)=>[a,'head',v];
const range=(n,fn)=>Array.from({length:n},(_,i)=>fn(i)).flat();
const sheets=[
 {name:'Bayes',widths:{A:46,B:14,C:3,D:58},cells:[
  H('A1','Screening'),H('B1','Hodnota'),
  L('A2','Počet osob'),I('B2',1000,'#,##0'),L('A3','Prevalence'),I('B3',.1,'0.00'),L('A4','Senzitivita'),I('B4',.95,'0.00'),L('A5','Specificita'),I('B5',.9,'0.00'),
  L('A7','Porucha přítomna'),C('B7','=B2*B3','#,##0'),L('A8','Porucha nepřítomna'),C('B8','=B2-B7','#,##0'),
  L('A9','Správně pozitivní'),C('B9','=B7*B4','#,##0'),L('A10','Falešně negativní'),C('B10','=B7-B9','#,##0'),
  L('A11','Falešně pozitivní'),C('B11','=B8*(1-B5)','#,##0'),L('A12','Správně negativní'),C('B12','=B8-B11','#,##0'),
  L('A13','Pozitivní celkem'),C('B13','=B9+B11','#,##0'),L('A14','Negativní celkem'),C('B14','=B10+B12','#,##0'),
  L('A16','Pozitivní prediktivní hodnota'),C('B16','=B9/B13'),L('A17','Negativní prediktivní hodnota'),C('B17','=B12/B14'),
  L('A19','Úplná pravděpodobnost pozitivního výsledku'),C('B19','=B3*B4+(1-B3)*(1-B5)'),L('A20','Bayesova věta: porucha při pozitivním výsledku'),C('B20','=B3*B4/B19'),
  N('D2','Modelové hodnoty zvolené pro výklad.'),N('D3','Nejde o vlastnosti skutečného dotazníku.'),N('D5','Žlutě: vstupy. Modře: výpočty.'),
  N('D7','Přirozené četnosti: postupné členění téže skupiny.'),N('D9','Při prevalenci 0,01 zvolte 10 000 osob,'),N('D10','aby vycházely celé počty.'),
  N('D16','B16 a B20 se musí shodovat.'),N('D19','České vzorce a postup: kapitola 5 učebnice.')]},
 {name:'Binom',widths:{A:34,B:14,C:14,D:14,E:3,F:60},cells:[
  H('A1','Binomický model'),H('B1','Hodnota'),
  L('A2','Počet pokusů n (pevně)'),L('B2',5),L('A3','Pravděpodobnost úspěchu π'),I('B3',.25,'0.00'),
  H('A5','Počet úspěchů k'),H('B5','P(X = k)'),H('C5','P(X ≤ k)'),H('D5','P(X ≥ k)'),
  ...range(6,i=>[L(`A${6+i}`,i),C(`B${6+i}`,i===0?'=(1-$B$3)^$B$2':`=BINOM.DIST(A${6+i};$B$2;$B$3;NEPRAVDA)`,'0.0000'),C(`C${6+i}`,`=BINOM.DIST(A${6+i};$B$2;$B$3;PRAVDA)`,'0.0000'),C(`D${6+i}`,`=1-C${6+i}+B${6+i}`,'0.0000')]),
  L('A13','Součet pravděpodobností'),C('B13','=SUMA(B6:B11)','0.0000'),L('A14','Střední hodnota'),C('B14','=B2*B3','0.00'),L('A15','Směrodatná odchylka'),C('B15','=ODMOCNINA(B2*B3*(1-B3))'),
  L('A17','Faktoriál 5!'),C('B17','=FAKTORIÁL(5)','0'),L('A18','Kombinační číslo 5 nad 2'),C('B18','=KOMBINACE(5;2)','0'),L('A19','Ruční výpočet P(X = 2)'),C('B19','=B18*B3^2*(1-B3)^3','0.0000'),
  N('F2','Model náhodného a nezávislého tipování.'),N('F3','Počet pokusů je pevně 5 (k od 0 do 5).'),N('F5','Měnit lze pouze žlutou B3; ostatní buňky jsou uzamčené.'),
  N('F7','Změnou B3 zjistíte vliv pravděpodobnosti úspěchu.'),N('F13','Součet musí být 1.'),N('F19','B19 se musí shodovat s B8 i po změně B3.')]},
 {name:'Binom_20',widths:{A:46,B:14,C:3,D:10,E:14},cells:[
  H('A1','Delší test'),H('B1','Hodnota'),H('D1','k'),H('E1','P(X = k)'),
  L('A2','Počet pokusů n (pevně)'),L('B2',20),L('A3','Pravděpodobnost úspěchu π'),I('B3',.25,'0.00'),L('A4','Hodnota pro právě a nejvýše'),I('B4',5,'0'),L('A5','Hranice pro alespoň'),I('B5',10,'0'),
  L('A7','="Právě: P(X = "&B4&")"'),C('B7','=KDYŽ(B4=0;(1-B3)^B2;BINOM.DIST(B4;B2;B3;NEPRAVDA))','0.0000'),L('A8','="Nejvýše: P(X ≤ "&B4&")"'),C('B8','=BINOM.DIST(B4;B2;B3;PRAVDA)','0.0000'),
  L('A9','="Alespoň: P(X ≥ "&B5&")"'),C('B9','=1-BINOM.DIST(B5-1;B2;B3;PRAVDA)','0.0000'),L('A10','Totéž funkcí BINOM.DIST.RANGE'),C('B10','=BINOM.DIST.RANGE(B2;B3;B5;B2)','0.0000'),
  L('A11','Střední hodnota'),C('B11','=B2*B3','0.00'),L('A12','Směrodatná odchylka'),C('B12','=ODMOCNINA(B2*B3*(1-B3))'),
  L('A13','Nejmenší k s P(X ≤ k) alespoň 0,95'),C('B13','=KDYŽ(B3=0;0;KDYŽ(B3=1;B2;BINOM.INV(B2;B3;0,95)))','0'),
  ...range(21,i=>[L(`D${2+i}`,i),C(`E${2+i}`,i===0?'=(1-$B$3)^$B$2':`=BINOM.DIST(D${2+i};$B$2;$B$3;NEPRAVDA)`,'0.0000')]),
  N('A16','Měnit lze B3:B5; n = 20 je pevné.'),N('A17','Sloupce D a E: celé rozdělení pro n = 20.'),N('A19','="Alespoň "&B5&" = 1 − nejvýše "&(B5-1)&", proto B5 − 1."')]},
 {name:'Aproximace',widths:{A:46,B:14,C:3,D:56},cells:[
  H('A1','Normální aproximace'),H('B1','Hodnota'),
  L('A2','Počet pokusů n'),I('B2',200,'0'),L('A3','Pravděpodobnost úspěchu π'),I('B3',.6,'0.00'),L('A4','Hranice počtu úspěchů'),I('B4',135,'0'),
  L('A6','Očekávaný počet úspěchů'),C('B6','=B2*B3','0.00'),L('A7','Očekávaný počet neúspěchů'),C('B7','=B2*(1-B3)','0.00'),L('A8','Směrodatná odchylka'),C('B8','=ODMOCNINA(B2*B3*(1-B3))'),
  L('A9','Z-skór hranice'),C('B9','=(B4-B6)/B8'),L('A10','Normální aproximace: alespoň hranice'),C('B10','=1-NORM.S.DIST(B9;PRAVDA)','0.0000'),
  L('A11','Přesná binomická hodnota'),C('B11','=1-BINOM.DIST(B4-1;B2;B3;PRAVDA)','0.0000'),L('A12','Aproximace od hranice − 0,5'),C('B12','=1-NORM.DIST(B4-0,5;B6;B8;PRAVDA)','0.0000'),
  L('A14','Pozorovaný podíl'),C('B14','=B4/B2'),L('A15','Směrodatná odchylka podílu'),C('B15','=ODMOCNINA(B3*(1-B3)/B2)','0.00000'),L('A16','Z-skór podílu'),C('B16','=(B14-B3)/B15'),
  N('D2','Autorský model rozpoznávací úlohy.'),N('D4','Žlutě: vstupy. Modře: výpočty.'),N('D6','Orientační podmínka: B6 i B7 alespoň 10.'),
  N('D10','Aproximace není přesná hodnota.'),N('D11','Přesnou hodnotu vrací BINOM.DIST.'),N('D16','B16 se shoduje s B9: změnila se jen jednotka.')]}
];
const wb=new ExcelWorkbook();wb.worksheets.add('Prehled');
for(const spec of sheets){
 const sh=wb.worksheets.add(spec.name);sh.showGridLines=true;
 sh.getRange('A1:F22').format={font:{name:'Arial',size:11,color:'#223744'},verticalAlignment:'center'};
 for(const [col,width] of Object.entries(spec.widths))sh.getRange(`${col}1`).format.columnWidth=width;
 for(const [address,kind,value,format] of spec.cells){
  const r=sh.getRange(address);
  if(typeof value==='string'&&value.startsWith('='))r.formulasLocal=[[value]];else r.values=[[value]];
  if(kind==='head')r.format={fill:'#234F62',font:{color:'#FFFFFF',bold:true},wrapText:true,rowHeight:34};
  if(kind==='input'||kind==='calc'){r.format.fill=kind==='input'?'#FFF1CB':'#EAF4F8';r.setNumberFormat(format);}
  if(kind==='note')r.format.font={color:'#526775'};
 }
}
await populateStudentInputs(wb,5,out,specs);
const overview=wb.worksheets.getItem('Prehled');
overview.getRange('A5').values=[['Slovní úlohy bez konkrétních čísel nevyžadují vlastní datový list.']];
overview.getRange('A6').values=[['Pravděpodobnosti a modelové četnosti nejsou záznamy o jednotlivých lidech.']];
overview.getRange('C1').format.columnWidth=78;
// The simulation contains integer counts, as in the original workbook.
wb.worksheets.getItem('Sim_hadani').getRange('A2:A41').setNumberFormat('General');
// Only the supported controls can be edited on the two finite distribution sheets.
for(const [name,editable] of [['Binom',['B3']],['Binom_20',['B3:B5']]]){
 const sh=wb.worksheets.getItem(name);sh.editableRanges=editable;
 sh.getRange('B3').dataValidation={rule:{type:'decimal',operator:'between',formula1:0,formula2:1,showError:true}};
 if(name==='Binom_20'){
  sh.getRange('B4').dataValidation={rule:{type:'whole',operator:'between',formula1:0,formula2:20,showError:true}};
  sh.getRange('B5').dataValidation={rule:{type:'whole',operator:'between',formula1:1,formula2:20,showError:true}};
  sh.getRange('A18').values=[['B4: 0 až 20; B5: 1 až 20 (celá čísla).']];
 }
}
await wb.build(5,out);
