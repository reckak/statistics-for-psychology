// Run from the project root. The optional ARTIFACT_TOOL_MODULE points to the bundled runtime.
import fs from 'node:fs/promises';
import { createRequire } from 'node:module';
import { pathToFileURL } from 'node:url';
const require=createRequire(import.meta.url);
const {Workbook,SpreadsheetFile}=await import(pathToFileURL(process.env.ARTIFACT_TOOL_MODULE||require.resolve('@oai/artifact-tool')).href);
const rows=(await fs.readFile('data/kapitola_02.csv','utf8')).trim().split(/\r?\n/).slice(1).map(line=>line.split(',').map((x,i)=>[1,2,4].includes(i)?(x===''?null:+x):x));
const wb=Workbook.create();
const p=wb.worksheets.add('Priklad'),s=wb.worksheets.add('Souhrn'),r=wb.worksheets.add('Rozsireni'),d=wb.worksheets.add('Data');
const header=(sh,range)=>{sh.getRange(range).format={fill:'#234F62',font:{bold:true,color:'#FFFFFF'},wrapText:true,rowHeight:44,verticalAlignment:'center'};};
const note=(sh,range,value)=>{sh.getRange(range).merge();sh.getRange(range).values=[[value]];sh.getRange(range).format={wrapText:true,rowHeight:36,font:{size:11,color:'#526775'}};};
for(const sh of [p,s,r,d]){
 sh.showGridLines=true;
 sh.getRange('A1:J40').format={font:{name:'Arial',size:11,color:'#223744'},columnWidth:14,rowHeight:23,verticalAlignment:'center'};
 sh.freezePanes.freezeRows(1);
}
p.getRange('A1:G1').values=[['Doba (min)','Odchylka od průměru','Absolutní odchylka','Čtverec odchylky','Absolutní odchylka od mediánu','Třetí mocnina','Čtvrtá mocnina']];header(p,'A1:G1');
p.getRange('A2:A6').values=[[4],[5],[5],[6],[10]];p.getRange('A2:A6').format.fill='#FFF1CB';
p.getRange('B2:G2').formulas=[['=A2-$J$3','=ABS(B2)','=B2^2','=ABS(A2-$J$4)','=B2^3','=B2^4']];p.getRange('B2:G6').fillDown();
p.getRange('B2:G6').format.fill='#EAF4F8';p.getRange('A2:J17').setNumberFormat('0.00');
p.getRange('H1:H22').format.columnWidth=3;
p.getRange('I1:J1').values=[['Ukazatel','Výsledek']];header(p,'I1:J1');p.getRange('I1:I22').format.columnWidth=30;p.getRange('J1:J22').format.columnWidth=14;
const stats=[['Počet platných údajů','=COUNT(A2:A6)'],['Průměr (min)','=AVERAGE(A2:A6)'],['Medián (min)','=MEDIAN(A2:A6)'],['Modus (min)','=MODE.SNGL(A2:A6)'],['Minimum (min)','=MIN(A2:A6)'],['Maximum (min)','=MAX(A2:A6)'],['Dolní kvartil (min)','=PERCENTILE.INC(A2:A6,0.25)'],['Horní kvartil (min)','=PERCENTILE.INC(A2:A6,0.75)'],['Variační rozpětí (min)','=J7-J6'],['Mezikvartilové rozpětí (min)','=J9-J8'],['Průměrná abs. odchylka (min)','=AVERAGE(C2:C6)'],['Součet čtverců (min²)','=SUM(D2:D6)'],['Rozptyl s dělením n (min²)','=J13/J2'],['Výběrový rozptyl (min²)','=VAR.S(A2:A6)'],['Výběrová směr. odchylka (min)','=STDEV.S(A2:A6)'],['Medián abs. odchylek (min)','=MEDIAN(E2:E6)']];
p.getRange('I2:I17').values=stats.map(x=>[x[0]]);p.getRange('J2:J17').formulas=stats.map(x=>[x[1]]);p.getRange('J2:J17').format.fill='#EAF4F8';p.getRange('J2').setNumberFormat('0');
note(p,'A9:G9','Autorský příklad: pět vyplněných číselných časů. Žluté buňky jsou vstupy, modré vzorce.');
note(p,'A11:G11','Změňte 10 na 30 minut a porovnejte průměr, medián a variabilitu. Potom obnovte 10.');
note(p,'A13:G13','Sloupce F a G patří k nepovinnému rozšíření. Výsledky jsou na listu Rozsireni.');
note(p,'A15:G15','Nemažte jednotlivé vstupy: pomocné odchylky v tomto malém příkladu předpokládají všech pět čísel.');
note(p,'A19:J19','Kvartily: PERCENTIL.INC. Medián absolutních odchylek je bez násobení korekční konstantou.');
note(p,'A21:J21','Výsledky se zobrazují na dvě desetinná místa; vzorce pracují s plnou přesností.');
s.getRange('A1:D1').values=[['Ukazatel','Spánek (hodiny)','Paměť (slova)','Význam']];header(s,'A1:D1');
s.getRange('A1:A16').format.columnWidth=27;s.getRange('B1:C16').format.columnWidth=19;s.getRange('D1:D16').format.columnWidth=42;
const summary=[['Počet','COUNT','Počet zaznamenaných čísel'],['Průměr','AVERAGE','Součet dělený platným počtem'],['Medián','MEDIAN','Prostřední poloha'],['Minimum','MIN','Nejnižší hodnota'],['Maximum','MAX','Nejvyšší hodnota'],['Dolní kvartil','PERCENTILE.INC','Interpolace při podílu 0,25'],['Horní kvartil','PERCENTILE.INC','Interpolace při podílu 0,75'],['Mezikvartilové rozpětí',null,'Horní minus dolní kvartil'],['Výběrový rozptyl','VAR.S','Ve čtvercích příslušných jednotek'],['Směrodatná odchylka','STDEV.S','V původních jednotkách']];
summary.forEach(([label,fn,desc],i)=>{
 const row=i+2;s.getRange(`A${row}`).values=[[label]];s.getRange(`D${row}`).values=[[desc]];
 s.getRange(`B${row}:C${row}`).formulas=[['B','C'].map(c=>fn?`=${fn}(Data!${c}2:${c}37${i===5?',0.25':i===6?',0.75':''})`:`=${c}8-${c}7`)];
});
s.getRange('B2:C11').format.fill='#EAF4F8';s.getRange('B2:C11').setNumberFormat('0.00');s.getRange('B2:C2').setNumberFormat('0');
note(s,'A14:D14','Spánek: tři údaje chybějí. Paměť: nula vybavených slov je platný výsledek.');
note(s,'A16:D16','Při přidávání řádků rozšiřte oblasti ve vzorcích. Každý sloupec má vlastní počet platných údajů.');
r.getRange('A1:D1').values=[['Strategie','Četnost','Podíl','Příspěvek k entropii']];header(r,'A1:D1');r.getRange('D1:D7').format.columnWidth=23;
r.getRange('A2:B5').values=[['A',4],['B',2],['C',2],['D',0]];r.getRange('B2:B5').format.fill='#FFF1CB';
r.getRange('C2:D2').formulas=[['=B2/SUM($B$2:$B$5)','=IF(C2=0,0,-C2*LOG(C2,2))']];r.getRange('C2:D5').fillDown();r.getRange('C2:D5').format.fill='#EAF4F8';r.getRange('C2:C5').setNumberFormat('0.000');r.getRange('D2:D7').setNumberFormat('0.00');
r.getRange('A7:C7').merge();r.getRange('A7').values=[['Entropie celkem (bity)']];r.getRange('D7').formulas=[['=SUM(D2:D5)']];r.getRange('D7').format.fill='#EAF4F8';
r.getRange('I1:J1').values=[['Tvar průběžného příkladu','Výsledek']];header(r,'I1:J1');r.getRange('I1:I7').format.columnWidth=33;r.getRange('J1:J7').format.columnWidth=15;
r.getRange('I2:I6').values=[['Základní šikmost: výpočet'],['Základní šikmost: SKEW.P'],['Korigovaná šikmost: SKEW'],['Základní exces: výpočet'],['Korigovaný exces: KURT']];
r.getRange('J2:J6').formulas=[['=AVERAGE(Priklad!F2:F6)/(SQRT(Priklad!J14)^3)'],['=SKEW.P(Priklad!A2:A6)'],['=SKEW(Priklad!A2:A6)'],['=AVERAGE(Priklad!G2:G6)/(Priklad!J14^2)-3'],['=KURT(Priklad!A2:A6)']];r.getRange('J2:J6').format.fill='#EAF4F8';r.getRange('J2:J6').setNumberFormat('0.00');
note(r,'A10:J10','Nepovinné rozšíření. Entropie vlevo popisuje strategie učení; koeficienty vpravo časy na listu Priklad.');
note(r,'A12:J12','Četnosti musí být nezáporné a celkový počet kladný. Nulová četnost má nulový příspěvek.');
note(r,'A14:J14','SKEW.P a SKEW používají různé konvence. KURT vrací korigovaný exces, nikoli kurtózu před odečtením tří.');
r.getRange('B2:B5').dataValidation={rule:{type:'whole',operator:'greaterThanOrEqual',formula1:0}};
d.getRange('A1:E1').values=[['id','spanek_h','slova','cast_dne','odpocatost']];header(d,'A1:E1');d.getRange('A2:E37').values=rows;d.getRange('B2:E37').format.fill='#FFF1CB';d.getRange('B2:B37').setNumberFormat('0.0');d.getRange('D1:D37').format.columnWidth=20;
note(d,'G1:J1','Modelová data z kapitoly o četnostech. Nejde o skutečný výzkum.');
note(d,'G3:J3','Jeden řádek = jeden účastník při jedné návštěvě.');
note(d,'G5:J5','spanek_h: spánek předchozí noci v hodinách. P05, P11 a P24 údaj neuvedli.');
note(d,'G7:J7','slova: počet správně vybavených slov z dvanácti. Platné hodnoty 0 až 12.');
note(d,'G9:J9','cast_dne: dopoledne před 12:00, odpoledne od 12:00.');
note(d,'G11:J11','odpocatost: 1 = vůbec, 2 = trochu, 3 = dost, 4 = zcela.');
note(d,'G13:J13','Úplné vymezení proměnných a postupu najdete v kapitole o četnostech.');
wb.recalculate();
await fs.mkdir('tmp/chapter-03-build',{recursive:true});
console.log((await wb.inspect({kind:'match',searchTerm:'#REF!|#DIV/0!|#VALUE!|#NAME\\?|#N/A|#NUM!|#NULL!',options:{useRegex:true,maxResults:20},summary:'Formula errors',maxChars:1200})).ndjson);
for(const [name,range] of [['Priklad','A1:J22'],['Souhrn','A1:D17'],['Rozsireni','A1:J15'],['Data','A1:J38']]){
 const img=await wb.render({sheetName:name,range,scale:1.5,format:'png'});
 await fs.writeFile(`tmp/chapter-03-build/${name}.png`,new Uint8Array(await img.arrayBuffer()));
}
await (await SpreadsheetFile.exportXlsx(wb)).save('data/kapitola_03.xlsx');
await fs.rename('data/kapitola_03.xlsx.inspect.ndjson','tmp/chapter-03-build/workbook-inspect.ndjson');
console.log('Saved data/kapitola_03.xlsx; verify formulas and Czech syntax in native Excel.');
