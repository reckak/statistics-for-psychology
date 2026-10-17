// Native Excel workbook; run after scripts/sesity-simulace.R.
import {inputs, populateStudentInputs} from './sesity-data.mjs';
import fs from 'node:fs/promises';
import {ExcelWorkbook} from './excel-workbook.mjs';
const out='tmp/chapter-07-build';await fs.mkdir(out,{recursive:true});
const sim=JSON.parse(await fs.readFile('tmp/sesity-simulace-07.json','utf8'));
const specs=[...inputs[7]];
// Simulated intervals of the chapter figure follow the input sheets of the running example.
specs.splice(specs.findIndex(s=>s.name==='Studie_ekv')+1,0,
 {name:'Sim_intervaly',use:'Obrázek: sto intervalů spolehlivosti ze sta simulovaných výběrů',
  headers:['Průměr výběru (body)','Výběrová směrodatná odchylka (body)','Dolní mez, známá σ','Horní mez, známá σ','Zachytil μ, známá σ (1 = ano)','Dolní mez, výběrová s','Horní mez, výběrová s','Zachytil μ, výběrová s (1 = ano)'],
  rows:sim.prumer.map((m,i)=>[m,sim.sd[i],sim.z_dolni[i],sim.z_horni[i],sim.z_zachytil[i],sim.t_dolni[i],sim.t_horni[i],sim.t_zachytil[i]]),
  note:'Simulovaná data z výukového modelu: populační průměr 47 bodů, směrodatná odchylka 10 bodů, normální rozdělení, 100 výběrů po 25 studentech. Řádek je jeden celý výběr, nikoli student. Meze 95% intervalů jsou vypočteny z nezaokrouhlených hodnot a zaokrouhleny na tři desetinná místa.'});
// Calculation sheets: [cell, kind, value or Czech formula, number format].
// Kinds: head, label, input, calc, note. Formulas use Czech names and semicolons.
const L=(a,v)=>[a,'label',v],I=(a,v,f='General')=>[a,'input',v,f],C=(a,v,f='0.000')=>[a,'calc',v,f],N=(a,v)=>[a,'note',v],H=(a,v)=>[a,'head',v];
const sheets=[
 {name:'Interval_z',widths:{A:50,B:14,C:3,D:60},cells:[
  H('A1','Interval spolehlivosti při známé σ'),H('B1','Hodnota'),
  L('A2','Výběrový průměr m'),I('B2',46,'0.00'),L('A3','Populační směrodatná odchylka σ (modelový předpoklad)'),I('B3',10,'0.00'),
  L('A4','Velikost výběru n'),I('B4',25,'0'),L('A5','Hladina spolehlivosti'),I('B5',.95,'0.00'),
  L('A7','Směrodatná chyba průměru'),C('B7','=B3/ODMOCNINA(B4)','0.000'),
  L('A8','Kvantil normovaného normálního rozdělení'),C('B8','=NORM.S.INV(1-(1-B5)/2)','0.0000'),
  L('A9','Mezní chyba odhadu'),C('B9','=B8*B7','0.0000'),
  L('A10','Dolní mez'),C('B10','=B2-B9','0.00'),L('A11','Horní mez'),C('B11','=B2+B9','0.00'),
  N('D2','Autorský ilustrační model skóru pozornosti.'),N('D3','Platí jen za předpokladu, že σ známe.'),N('D5','Žlutě: vstupy. Modře: výpočty.'),
  N('D8','Pro 0,95 je úroveň kvantilu 0,975.'),N('D10','Interval zachytí μ v 95 % opakování postupu;'),N('D11','jeden interval μ buď obsahuje, nebo ne.')]},
 {name:'Interval_t',widths:{A:50,B:14,C:3,D:60},cells:[
  H('A1','Interval spolehlivosti s t-kvantilem'),H('B1','Hodnota'),
  L('A2','Výběrový průměr m'),I('B2',46,'0.00'),L('A3','Výběrová směrodatná odchylka s'),I('B3',10,'0.00'),
  L('A4','Velikost výběru n'),I('B4',25,'0'),L('A5','Hladina spolehlivosti'),I('B5',.95,'0.00'),
  L('A7','Odhad směrodatné chyby'),C('B7','=B3/ODMOCNINA(B4)','0.000'),L('A8','Stupně volnosti'),C('B8','=B4-1','0'),
  L('A9','Kvantil t-rozdělení'),C('B9','=T.INV(1-(1-B5)/2;B8)','0.0000'),
  L('A10','Mezní chyba odhadu'),C('B10','=B9*B7','0.0000'),
  L('A11','Dolní mez'),C('B11','=B2-B10','0.00'),L('A12','Horní mez'),C('B12','=B2+B10','0.00'),
  N('D2','Autorský ilustrační model skóru pozornosti.'),N('D3','σ neznáme, používáme výběrovou s.'),N('D5','Žlutě: vstupy. Modře: výpočty.'),
  N('D9','Kvantil je větší než u normovaného normálního rozdělení.'),N('D12','Předpoklady: nezávislý náhodný výběr, přibližně normální populace.')]},
 {name:'T_test',widths:{A:50,B:14,C:3,D:60},cells:[
  H('A1','Jednovýběrový t-test'),H('B1','Hodnota'),
  L('A2','Hraniční hodnota μ₀ podle nulové hypotézy'),I('B2',50,'0.00'),L('A3','Výběrový průměr m'),I('B3',46,'0.00'),
  L('A4','Výběrová směrodatná odchylka s'),I('B4',10,'0.00'),L('A5','Velikost výběru n'),I('B5',25,'0'),L('A6','Hladina významnosti'),I('B6',.05,'0.00'),
  L('A8','Odhad směrodatné chyby'),C('B8','=B4/ODMOCNINA(B5)','0.000'),L('A9','Stupně volnosti'),C('B9','=B5-1','0'),
  L('A10','Testová statistika t'),C('B10','=(B3-B2)/B8','0.000'),
  L('A11','P-hodnota pro alternativu „menší“'),C('B11','=T.DIST(B10;B9;PRAVDA)','0.0000'),
  L('A12','P-hodnota pro alternativu „větší“'),C('B12','=1-T.DIST(B10;B9;PRAVDA)','0.0000'),
  L('A13','P-hodnota oboustranně'),C('B13','=T.DIST.2T(ABS(B10);B9)','0.0000'),
  L('A14','Kritická hodnota t oboustranně'),C('B14','=T.INV.2T(B6;B9)','0.0000'),
  N('D2','Autorský ilustrační model skóru pozornosti.'),N('D6','Žlutě: vstupy. Modře: výpočty.'),
  N('D11','Použijte jen p-hodnotu pro směr zvolený předem.'),N('D13','T.DIST.2T vyžaduje nezáporný první argument.'),N('D14','Po rozhodnutí následuje věcná interpretace.')]},
 {name:'Ekvivalence',widths:{A:56,B:24,C:3,D:60},cells:[
  H('A1','Test rozdílu a test ekvivalence'),H('B1','Hodnota'),
  L('A2','Norma μ₀ (pevná referenční hodnota)'),I('B2',50,'0.00'),L('A3','Hranice ekvivalence Δ, zvolená předem'),I('B3',3,'0.00'),
  L('A4','Výběrový průměr m'),I('B4',48.5,'0.00'),L('A5','Výběrová směrodatná odchylka s'),I('B5',10,'0.00'),
  L('A6','Velikost výběru n'),I('B6',400,'0'),L('A7','Hladina významnosti'),I('B7',.05,'0.00'),
  L('A9','Odhad směrodatné chyby'),C('B9','=B5/ODMOCNINA(B6)','0.000'),L('A10','Stupně volnosti'),C('B10','=B6-1','0'),
  L('A11','Dolní hranice ekvivalence'),C('B11','=B2-B3','0.00'),L('A12','Horní hranice ekvivalence'),C('B12','=B2+B3','0.00'),
  L('A14','Test rozdílu: dolní mez 95% intervalu'),C('B14','=B4-T.INV(1-B7/2;B10)*B9','0.00'),
  L('A15','Test rozdílu: horní mez 95% intervalu'),C('B15','=B4+T.INV(1-B7/2;B10)*B9','0.00'),
  L('A16','Test rozdílu: oboustranná p-hodnota'),C('B16','=T.DIST.2T(ABS((B4-B2)/B9);B10)','0.0000'),
  L('A17','Test rozdílu: rozhodnutí'),C('B17','=KDYŽ(B16<=B7;"zamítáme nulovou hypotézu";"nulovou hypotézu nezamítáme")','General'),
  L('A18','Test ekvivalence: dolní mez 90% intervalu'),C('B18','=B4-T.INV(1-B7;B10)*B9','0.00'),
  L('A19','Test ekvivalence: horní mez 90% intervalu'),C('B19','=B4+T.INV(1-B7;B10)*B9','0.00'),
  L('A20','Test ekvivalence: závěr'),C('B20','=KDYŽ(A(B18>B11;B19<B12);"ekvivalence doložena";"ekvivalence nedoložena")','General'),
  L('A22','Nepovinně: t vůči dolní hranici'),C('B22','=(B4-B11)/B9','0.000'),
  L('A23','Nepovinně: p-hodnota vůči dolní hranici'),C('B23','=1-T.DIST(B22;B10;PRAVDA)','0.0000'),
  L('A24','Nepovinně: t vůči horní hranici'),C('B24','=(B4-B12)/B9','0.000'),
  L('A25','Nepovinně: p-hodnota vůči horní hranici'),C('B25','=T.DIST(B24;B10;PRAVDA)','0.0000'),
  L('A26','Nepovinně: výsledná p-hodnota TOST'),C('B26','=MAX(B23;B25)','0.0000'),
  N('D2','Výchozí vstupy jsou studie B z listu Studie_ekv.'),N('D3','Hranice stanovte před analýzou, ne podle výsledku.'),N('D7','Žlutě: vstupy. Modře: výpočty.'),
  N('D14','95% interval slouží testu rozdílu od normy.'),N('D18','90% interval slouží testu ekvivalence:'),N('D19','dva jednostranné testy, každý na hladině B7.'),
  N('D20','Ekvivalence jen tehdy, leží-li celý 90% interval v pásmu.'),N('D26','Větší z obou p-hodnot; menší než B7 znamená ekvivalenci.')]}
];
const wb=new ExcelWorkbook();wb.worksheets.add('Prehled');
for(const spec of sheets){
 const sh=wb.worksheets.add(spec.name);sh.showGridLines=true;
 sh.getRange('A1:F26').format={font:{name:'Arial',size:11,color:'#223744'},verticalAlignment:'center'};
 for(const [col,width] of Object.entries(spec.widths))sh.getRange(`${col}1`).format.columnWidth=width;
 for(const [address,kind,value,format] of spec.cells){
  const r=sh.getRange(address);
  if(typeof value==='string'&&value.startsWith('='))r.formulasLocal=[[value]];else r.values=[[value]];
  if(kind==='head')r.format={fill:'#234F62',font:{color:'#FFFFFF',bold:true},wrapText:true,rowHeight:34};
  if(kind==='input'||kind==='calc'){r.format.fill=kind==='input'?'#FFF1CB':'#EAF4F8';r.setNumberFormat(format);}
  if(kind==='note')r.format.font={color:'#526775'};
 }
}
await populateStudentInputs(wb,7,out,specs);
const overview=wb.worksheets.getItem('Prehled');
overview.getRange('A5').values=[['Slovní úlohy 2, 4 a 12 nevyžadují vlastní datový list.']];
overview.getRange('A6').values=[['List Sim_intervaly obsahuje simulovaná data z výukového modelu, nikoli pozorování lidí.']];
overview.getRange('C1').format.columnWidth=78;
// Simulated values are stored with three decimals; the hit indicators are whole numbers.
const si=wb.worksheets.getItem('Sim_intervaly');
si.getRange('A2:D101').setNumberFormat('0.000');si.getRange('F2:G101').setNumberFormat('0.000');
si.getRange('E2:E101').setNumberFormat('0');si.getRange('H2:H101').setNumberFormat('0');
await wb.build(7,out);
