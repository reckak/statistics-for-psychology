// Editable teaching workbook. Run from project root with the bundled artifact runtime.
import fs from 'node:fs/promises';
import {createRequire} from 'node:module';
import {pathToFileURL} from 'node:url';
const require=createRequire(import.meta.url);
const {Workbook,SpreadsheetFile}=await import(pathToFileURL(process.env.ARTIFACT_TOOL_MODULE||require.resolve('@oai/artifact-tool')).href);
const wb=Workbook.create();
const model=wb.worksheets.add('Model'),qq=wb.worksheets.add('QQ');
const out='tmp/chapter-04';await fs.mkdir(out,{recursive:true});
for(const sh of [model,qq]){
  sh.showGridLines=true;
  sh.getRange(sh===model?'A1:F29':'A1:N25').format={font:{name:'Arial',size:11,color:'#223744'},rowHeight:24,columnWidth:15,verticalAlignment:'center'};
}
const header=r=>{r.format={fill:'#234F62',font:{name:'Arial',size:11,color:'#FFFFFF',bold:true},wrapText:true,rowHeight:44};};
const input=r=>{r.format.fill='#FFF1CB';r.setNumberFormat('0.00');};
const calc=r=>{r.format.fill='#EAF4F8';r.setNumberFormat('0.000');};
model.getRange('A1:B1').values=[['Normální model','Hodnota']];header(model.getRange('A1:B1'));
model.getRange('A2:A25').values=[['Průměr (body)'],['Směrodatná odchylka (body)'],['Hranice (body)'],[null],['Z-skór hranice'],['Podíl nejvýše po hranici'],['Podíl nad hranicí'],['Přímý převod na podíl'],[null],['Dolní hranice (body)'],['Horní hranice (body)'],['Podíl mezi hranicemi'],[null],[null],['Podíl vlevo'],['Z-skór percentilu'],['Percentil (body)'],['Přímý převod na percentil (body)'],[null],[null],['Prostřední podíl'],['Podíl v jednom chvostu'],['Dolní mez (body)'],['Horní mez (body)']];
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
qq.getRange('A1:A13').format.columnWidth=9;qq.getRange('B1:C13').format.columnWidth=15;qq.getRange('D1:E13').format.columnWidth=20;
qq.getRange('F1:F25').format.columnWidth=3;qq.getRange('G1:G25').format.columnWidth=26;qq.getRange('H1:H25').format.columnWidth=12;
qq.getRange('A16').values=[['Autorská ilustrační data, již seřazená vzestupně.']];
qq.getRange('A18').values=[['Podíl: střed pořadového dílku (i − 0,5) / n.']];
qq.getRange('A19').values=[['Přímka používá průměr a odchylku těchto dat.']];
qq.getRange('A21').values=[['Měňte skóry ve žlutých buňkách a zachovejte pořadí.']];
qq.getRange('A22').values=[['Graf a vzorce se přepočítají. Data nemají být prázdná.']];
const chart=qq.charts.add('scatter',[qq.getRange('D1:D13'),qq.getRange('B1:B13'),qq.getRange('E1:E13')]);
chart.title='Normální Q–Q graf';chart.setPosition('G7','N24');chart.titleTextStyle.typeface='Arial';chart.titleTextStyle.fontSize=15;
chart.legend={position:'bottom',textStyle:{typeface:'Arial',fontSize:11}};
chart.xAxis={axisType:'valueAxis',numberFormatCode:'0.0',numberFormatSourceLinked:false,textStyle:{typeface:'Arial',fontSize:11}};
chart.yAxis={numberFormatCode:'0',numberFormatSourceLinked:false,textStyle:{typeface:'Arial',fontSize:11}};
chart.xAxis.title.text='Teoretický normální kvantil (z)';chart.yAxis.title.text='Pozorovaný skór (body)';
chart.series.items[0].fill='#245D78';chart.series.items[1].line={fill:'#B54E24',style:'dashed',width:2};
// Native Excel verification finalizes scatter marker/line types and checks range bindings.
wb.recalculate();
for(const [sh,range]of [['Model','A1:D25'],['QQ','A1:N24']]){
 const inspect=await wb.inspect({kind:'table',range:`${sh}!${sh==='Model'?'A2:B25':'A2:H13'}`,include:'values,formulas',tableMaxRows:24,tableMaxCols:8,maxChars:6000});
 await fs.writeFile(`${out}/${sh}-inspect.ndjson`,inspect.ndjson);
 const preview=await wb.render({sheetName:sh,range,scale:1.4,format:'png'});await fs.writeFile(`${out}/${sh}.png`,new Uint8Array(await preview.arrayBuffer()));
}
const errors=await wb.inspect({kind:'match',searchTerm:'#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A|#NUM!|#NULL!',options:{useRegex:true,maxResults:15},maxChars:2000});console.log(errors.ndjson);
const result=await SpreadsheetFile.exportXlsx(wb);await result.save('data/kapitola_04.xlsx');
await fs.rename('data/kapitola_04.xlsx.inspect.ndjson',`${out}/workbook-export.ndjson`).catch(e=>{if(e.code!=='ENOENT')throw e;});
console.log('Created data/kapitola_04.xlsx; two editable teaching sheets.');
