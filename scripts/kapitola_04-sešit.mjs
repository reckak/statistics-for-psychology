import { ExcelWorkbook } from './excel-workbook.mjs';
import { addStudentInputs } from './sesity-data.mjs';
import fs from 'node:fs/promises';
const wb=new ExcelWorkbook();
wb.worksheets.add('Prehled');
const model=wb.worksheets.add('Model'),qq=wb.worksheets.add('QQ');
const out='tmp/chapter-04';await fs.mkdir(out,{recursive:true});
for(const sh of [model,qq]){
  sh.showGridLines=true;
  sh.getRange(sh===model?'A1:F29':'A1:N44').format={font:{name:'Arial',size:11,color:'#223744'},rowHeight:24,columnWidth:15,verticalAlignment:'center'};
}
const header=r=>{r.format={fill:'#234F62',font:{name:'Arial',size:11,color:'#FFFFFF',bold:true},wrapText:true,rowHeight:44};};
const input=r=>{r.format.fill='#FFF1CB';r.setNumberFormat('0.00');};
const calc=r=>{r.format.fill='#EAF4F8';r.setNumberFormat('0.000');};
model.getRange('A1:B1').values=[['Normální model','Hodnota']];header(model.getRange('A1:B1'));
model.getRange('A2:A25').values=[['Průměr (body)'],['Směrodatná odchylka (body)'],['Hranice (body)'],[null],['Z-skór hranice'],['Podíl nejvýše po hranici'],['Podíl nad hranicí'],['Přímý převod na podíl'],[null],['Dolní mez (body)'],['Horní mez (body)'],['Podíl mezi mezemi'],[null],[null],['Podíl vlevo'],['Z-skór percentilu'],['Percentil (body)'],['Přímý převod na percentil (body)'],[null],[null],['Prostřední podíl'],['Podíl v jednom chvostu'],['Dolní mez (body)'],['Horní mez (body)']];
for(const [a,v] of Object.entries({B2:50,B3:10,B4:60,B11:60,B12:70,B16:.9,B22:.95})){model.getRange(a).values=[[v]];input(model.getRange(a));}
const formulas={B6:'=(B4-B2)/B3',B7:'=NORM.S.DIST(B6,TRUE)',B8:'=1-B7',B9:'=NORM.DIST(B4,B2,B3,TRUE)',B13:'=NORM.S.DIST((B12-B2)/B3,TRUE)-NORM.S.DIST((B11-B2)/B3,TRUE)',B17:'=NORM.S.INV(B16)',B18:'=B2+B3*B17',B19:'=NORM.INV(B16,B2,B3)',B23:'=(1-B22)/2',B24:'=NORM.INV(B23,B2,B3)',B25:'=NORM.INV(1-B23,B2,B3)'};
for(const [a,f]of Object.entries(formulas)){model.getRange(a).formulas=[[f]];calc(model.getRange(a));}
for(const a of ['B7:B9','B13','B16','B22:B23'])model.getRange(a).setNumberFormat('0.0%');
for(const a of ['B18:B19','B24:B25'])model.getRange(a).setNumberFormat('0.00');
model.getRange('A1:A25').format.columnWidth=37;model.getRange('B1:B25').format.columnWidth=17;
model.getRange('D2').values=[['Autorský ilustrační model skóru pozornosti.']];
model.getRange('D3').values=[['Nejde o skutečný test ani jeho normy.']];
model.getRange('D5').values=[['Žlutě: vstupy. Modře: výpočty.']];
model.getRange('D7').values=[['Odchylka musí být kladná.']];
model.getRange('D8').values=[['Podíly v B16 a B22: větší než 0, menší než 1.']];
model.getRange('D10').values=[['Pro další výpočty ponechte plnou přesnost.']];
model.getRange('D11').values=[['Procentní formát nenásobte znovu stem.']];
model.getRange('D14').values=[['České vzorce a postup: kapitola 4 učebnice.']];
model.getRange('D1:D25').format.columnWidth=52;
qq.getRange('A1:E1').values=[['Pořadí','Skór (body)','Podíl','Normální kvantil z','Referenční hodnota (body)']];header(qq.getRange('A1:E1'));
const raw=await fs.readFile('data/kapitola_04.csv','utf8');
const rows=raw.trim().split(/\r?\n/).slice(1).map(row=>row.split(',').map(Number));
qq.getRange('A2:B13').values=rows;input(qq.getRange('B2:B13'));qq.getRange('A2:B13').setNumberFormat('0');
qq.getRange('G2:G4').values=[['Počet'],['Průměr'],['Směrodatná odchylka']];
qq.getRange('H2:H4').formulas=[['=COUNT(B2:B13)'],['=AVERAGE(B2:B13)'],['=STDEV.S(B2:B13)']];calc(qq.getRange('H2:H4'));qq.getRange('H2').setNumberFormat('0');
qq.getRange('C2:E2').formulas=[['=(A2-0.5)/$H$2','=NORM.S.INV(C2)','=$H$3+$H$4*D2']];
qq.getRange('C2:E13').fillDown();calc(qq.getRange('C2:E13'));qq.getRange('C2:C13').setNumberFormat('0.000000');
// Optional P-P plot: model proportion for each observed score.
qq.getRange('F1').values=[['Modelový podíl (P–P)']];header(qq.getRange('F1'));
qq.getRange('F2').formulas=[['=NORM.S.DIST((B2-$H$3)/$H$4,TRUE)']];qq.getRange('F2:F13').fillDown();calc(qq.getRange('F2:F13'));qq.getRange('F2:F13').setNumberFormat('0.000000');
qq.getRange('A1:A13').format.columnWidth=9;qq.getRange('B1:C13').format.columnWidth=15;qq.getRange('D1:E13').format.columnWidth=20;
qq.getRange('F1:F44').format.columnWidth=16;qq.getRange('G1:G25').format.columnWidth=26;qq.getRange('H1:H25').format.columnWidth=12;
qq.getRange('A16').values=[['Autorská ilustrační data, již seřazená vzestupně.']];
qq.getRange('A18').values=[['Podíl: střed pořadového dílku (i − 0,5) / n.']];
qq.getRange('A19').values=[['Přímka používá průměr a odchylku těchto dat.']];
qq.getRange('A21').values=[['Měňte skóry ve žlutých buňkách a zachovejte pořadí.']];
qq.getRange('A22').values=[['Graf a vzorce se přepočítají. Data nemají být prázdná.']];
qq.getRange('A24').values=[['Sloupec F a druhý graf: nepovinný P–P graf (podíl C proti F).']];
wb.addChart({sheet:'QQ',type:'scatter',title:'Normální Q–Q graf',start:'G7',end:'N24',
 xTitle:'Teoretický normální kvantil (z)',yTitle:'Pozorovaný skór (body)',legend:true,
 series:[{name:'Pozorované skóry',x:'D2:D13',y:'B2:B13',color:'#245D78'},
 {name:'Referenční přímka',x:'D2:D13',y:'E2:E13',color:'#B54E24',line:true}]});
wb.addChart({sheet:'QQ',type:'scatter',title:'P–P graf (nepovinné)',start:'G26',end:'N43',
 xTitle:'Empirický podíl (i − 0,5)/n',yTitle:'Modelový podíl',legend:true,xMin:0,xMax:1,xMajor:.2,yMin:0,yMax:1,yMajor:.2,
 series:[{name:'Pozorované skóry',x:'C2:C13',y:'F2:F13',color:'#245D78'},
 {name:'Úhlopříčka',x:'C2:C13',y:'C2:C13',color:'#B54E24',line:true}]});
await fs.mkdir('tmp/chapter-04',{recursive:true});
await addStudentInputs(wb,4,'tmp/chapter-04');
await wb.build(4, 'tmp/chapter-04');
