// Run from the repository root; dependencies come from the Codex bundled runtime.
import fs from 'node:fs/promises';
import { createRequire } from 'node:module';
import { pathToFileURL } from 'node:url';
const require = createRequire(import.meta.url);
const modulePath = process.env.ARTIFACT_TOOL_MODULE || require.resolve('@oai/artifact-tool');
const { Workbook, SpreadsheetFile } = await import(pathToFileURL(modulePath).href);
const csv = (await fs.readFile('data/kapitola_02.csv','utf8')).trim().split(/\r?\n/).slice(1);
const rows = csv.map(line => line.split(',').map((v,i)=>[1,2,4].includes(i) ? (v===''?null:Number(v)) : v));
const wb=Workbook.create();
const c=wb.worksheets.add('Cetnosti'), h=wb.worksheets.add('Histogram'), d=wb.worksheets.add('Data');
for(const sh of [c,h,d]){
  sh.showGridLines=true; // Teaching workbook: addresses and ordinary grid aid navigation.
  sh.getRange('A1:Q40').format.font={name:'Arial',size:11,color:'#223744'};
  sh.getRange('A1:Q40').format.rowHeight=22;
  sh.getRange('A1:Q40').format.columnWidth=13;
  sh.getRange('A1:Q40').format.verticalAlignment='center';
}
const header=(sh,range)=>{sh.getRange(range).format={fill:'#234F62',font:{bold:true,color:'#FFFFFF'},wrapText:true,rowHeight:36,horizontalAlignment:'center'};};
const note=(sh,address,text)=>{sh.getRange(address).values=[[text]];sh.getRange(address).format.font={italic:true,size:10,color:'#526775'};};
c.getRange('A1').values=[['Odpočatost před úlohou']];c.getRange('A1').format.font={bold:true,size:15};
c.getRange('B2').values=[['Platné odpovědi n']];c.getRange('C2').formulas=[["=COUNT('Data'!E2:E37)"]];
c.getRange('A4:H4').values=[['Kód','Odpočatost','Četnost','Podíl','Procenta','Kumul. počet','Kumul. podíl','Kumul. %']];header(c,'A4:H4');
c.getRange('A5:B8').values=[[1,'Vůbec'],[2,'Trochu'],[3,'Dost'],[4,'Zcela']];
c.getRange('C5:H5').formulas=[["=COUNTIFS('Data'!$E$2:$E$37,A5)",'=C5/$C$2','=D5','=SUM($C$5:C5)','=F5/$C$2','=G5']];c.getRange('C5:H8').fillDown();
c.getRange('B10').values=[['Celkem']];c.getRange('C10:E10').formulas=[['=SUM(C5:C8)','=SUM(D5:D8)','=D10']];
c.getRange('B4:B10').format.columnWidth=23;
c.getRange('D5:D10').setNumberFormat('0.000');c.getRange('G5:G8').setNumberFormat('0.000');
c.getRange('E5:E10').setNumberFormat('0.0%');c.getRange('H5:H8').setNumberFormat('0.0%');
c.getRange('C5:H8').format.fill='#EFF6FA';c.getRange('B10:E10').format.font={bold:true};
note(c,'A12','Počítáme 36 modelových účastníků. Odpočatost má čtyři uspořádané kategorie.');
note(c,'A13','Podíly se počítají z nezkrácených hodnot. Kumulativní sloupce už nesčítáme.');
note(c,'A15','Zkuste změnit Data!E2 z 2 na 3 a sledujte tabulku i graf. Potom obnovte 2.');
h.getRange('A1').values=[['Doba spánku: intervalové četnosti']];h.getRange('A1').format.font={bold:true,size:15};
h.getRange('B2').values=[['Platné údaje n']];h.getRange('C2').formulas=[["=COUNT('Data'!B2:B37)"]];
h.getRange('A4:F4').values=[['Dolní mez','Horní mez','Interval (h)','Četnost','Podíl','Procenta']];header(h,'A4:F4');
h.getRange('A5:C10').values=Array.from({length:6},(_,i)=>[i+4,i+5,`${i+4} až < ${i+5}`]);
h.getRange('D5:F5').formulas=[["=COUNTIFS('Data'!$B$2:$B$37,\">=\"&A5,'Data'!$B$2:$B$37,\"<\"&B5)",'=D5/$C$2','=E5']];h.getRange('D5:F10').fillDown();
h.getRange('C12').values=[['Celkem']];h.getRange('D12:F12').formulas=[['=SUM(D5:D10)','=SUM(E5:E10)','=E12']];
h.getRange('B2:B12').format.columnWidth=20;h.getRange('C2:C12').format.columnWidth=19;
h.getRange('E5:E12').setNumberFormat('0.000');h.getRange('F5:F12').setNumberFormat('0.0%');
h.getRange('D5:F10').format.fill='#EFF6FA';h.getRange('C12:F12').format.font={bold:true};
note(h,'A14','Dolní mez patří do intervalu, horní už ne. Intervaly mají šířku 1 hodina.');
note(h,'A15','Tři z 36 účastníků spánek neuvedli. Prázdná buňka neznamená 0 hodin.');
note(h,'A17','Zkuste změnit Data!B2 z 6 na 7. Po ověření přesunu obnovte hodnotu 6.');
note(h,'A18','Při rozšíření dat upravte oblasti ve vzorcích a pokrytí intervaly.');
d.getRange('A1:E1').values=[['id','spanek_h','slova','cast_dne','odpocatost']];header(d,'A1:E1');
d.getRange('A2:E37').values=rows;d.getRange('B2:B37').setNumberFormat('0.0');
d.getRange('B2:E37').format.fill='#FFF8E7';d.getRange('D1:D37').format.columnWidth=19;
d.freezePanes.freezeRows(1);
d.getRange('G1').values=[['Modelová data vytvořená pro výuku; nejde o skutečný výzkum.']];
const notes=[
 'Jeden řádek = jeden účastník při jedné návštěvě. Všichni plní úlohu v tichu.',
 'spanek_h: odhad skutečného spánku předchozí noci v hodinách (0 až 24).',
 'Prázdná buňka znamená neuvedený spánek (P05, P11, P24).',
 'slova: počet různých správně vybavených slov z 12; jedna minuta na čtení',
 'a jedna na vybavení. Nula je platný výsledek, nikoli chybějící údaj.',
 'cast_dne: dopoledne před 12:00, odpoledne od 12:00.',
 'odpocatost: Jak odpočatě se právě cítíte? Odpověď před úlohou.',
 '1 = vůbec, 2 = trochu, 3 = dost, 4 = zcela.',
 'Změny čísel v původních 36 řádcích se promítnou do tabulek a grafů.',
 'Při přidání dalších řádků je potřeba rozšířit oblasti ve vzorcích.'
];notes.forEach((v,i)=>note(d,`G${i+3}`,v));
d.getRange('E2:E37').dataValidation={rule:{type:'whole',operator:'between',formula1:1,formula2:4}};
d.getRange('C2:C37').dataValidation={rule:{type:'whole',operator:'between',formula1:0,formula2:12}};
function chart(sh,range,title,pos1,pos2,xlabel){
 const g=sh.charts.add('bar',sh.getRange(range));g.title=title;g.hasLegend=false;g.setPosition(pos1,pos2);
 g.titleTextStyle.typeface='Arial';g.titleTextStyle.fontSize=15;
 g.xAxis={axisType:'textAxis',textStyle:{typeface:'Arial',fontSize:11}};
 g.yAxis={numberFormatCode:'0',numberFormatSourceLinked:false,textStyle:{typeface:'Arial',fontSize:11}};
 g.xAxis.title.text=xlabel;g.yAxis.title.text='Počet účastníků';g.series.items[0].fill='#267888';return g;
}
chart(c,'B4:C8','Odpočatost','J3','R18','Odpočatost');
chart(h,'C4:D10','Doba spánku','H3','P18','Doba spánku (h)');
wb.recalculate();
console.log((await wb.inspect({kind:'table',range:'Cetnosti!A4:H10',include:'values,formulas',tableMaxRows:8,tableMaxCols:8,maxChars:2200})).ndjson);
console.log((await wb.inspect({kind:'match',searchTerm:'#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A|#NUM!|#NULL!',options:{useRegex:true,maxResults:20},summary:'Formula errors',maxChars:1000})).ndjson);
await fs.mkdir('tmp/chapter-02-build',{recursive:true});
for(const [name,range] of [['Cetnosti','A1:R18'],['Histogram','A1:P19'],['Data','A1:O38']]){
 const img=await wb.render({sheetName:name,range,scale:1.5,format:'png'});
 await fs.writeFile(`tmp/chapter-02-build/${name}.png`,new Uint8Array(await img.arrayBuffer()));
}
await (await SpreadsheetFile.exportXlsx(wb)).save('data/kapitola_02.xlsx');
await fs.rename('data/kapitola_02.xlsx.inspect.ndjson','tmp/chapter-02-build/workbook-inspect.ndjson');
console.log('Saved data/kapitola_02.xlsx. Native Excel validation follows.');
