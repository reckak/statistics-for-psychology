// Native Excel workbook; run after scripts/sesity-simulace.R.
import {inputs, populateStudentInputs} from './sesity-data.mjs';
import fs from 'node:fs/promises';
import {ExcelWorkbook} from './excel-workbook.mjs';
const out='tmp/chapter-06-build';await fs.mkdir(out,{recursive:true});
const sim=JSON.parse(await fs.readFile('tmp/sesity-simulace-06.json','utf8'));
const specs=[...inputs[6]];
// Simulated data of the chapter figures follow the fixed inputs of the running example.
const simNote='Simulovaná data z výukového modelu (populační průměr 35 s, směrodatná odchylka 15 s, tvar zešikmený doprava), zaokrouhlená na tři desetinná místa. Nejde o pozorování skutečných řidičů.';
const sizes=Object.keys(sim.prumery);
specs.splice(specs.findIndex(s=>s.name==='Pozornost')+1,0,
 {name:'Sim_vyber',use:'Obrázek: jeden výběr 30 řidičů; odhad směrodatné chyby',headers:['Doba (s)'],rows:sim.vyber.map(v=>[v]),note:simNote+' Jeden z 10 000 simulovaných výběrů po 30 řidičích.'},
 {name:'Sim_prumery',use:'Obrázky: výběrové rozdělení průměru pro čtyři velikosti výběru',headers:sizes.map(k=>`Průměr výběru ${k.slice(1)} řidičů (s)`),rows:sim.prumery[sizes[0]].map((_,i)=>sizes.map(k=>sim.prumery[k][i])),note:simNote+' Řádek je jedno opakování simulace, nikoli řidič; sloupce jsou čtyři samostatné simulace po 10 000 opakováních a hodnoty v jednom řádku spolu nesouvisejí.'},
 {name:'Sim_rozdily',use:'Obrázky a výklad: rozdíl průměrů dvou výběrů po 100 řidičích',headers:['Rozdíl průměrů (s)'],rows:sim.rozdily.map(v=>[v]),note:simNote+' Oba výběry pocházejí z téže populace, takže nulová hypotéza platí. Řádek je jedna dvojice výběrů.'},
 {name:'Skupiny',use:'Obrázek: průměry skupin podle velikosti; cvičení 6',headers:['Počet lidí ve skupině','Průměr skupiny (body)'],rows:sim.skupiny_n.map((n,i)=>[n,sim.skupiny_m[i]]),note:'Simulovaná data: 150 skupin, všechny z jediné populace s průměrem 50 bodů a směrodatnou odchylkou 10 bodů. Řádek je skupina, nikoli člověk. Průměry jsou zaokrouhleny na tři desetinná místa.'});
// Calculation sheets: [cell, kind, value or Czech formula, number format].
// Kinds: head, label, input, calc, note. Formulas use Czech names and semicolons.
const L=(a,v)=>[a,'label',v],I=(a,v,f='General')=>[a,'input',v,f],C=(a,v,f='0.000')=>[a,'calc',v,f],N=(a,v)=>[a,'note',v],H=(a,v)=>[a,'head',v];
const range=(n,fn)=>Array.from({length:n},(_,i)=>fn(i)).flat();
const decision='=KDYŽ(#<=$;"zamítáme nulovou hypotézu";"nulovou hypotézu nezamítáme")';
const sheets=[
 {name:'Chyba',widths:{A:46,B:14,C:3,D:60},cells:[
  H('A1','Průměr výběru'),H('B1','Hodnota'),
  L('A2','Populační průměr μ'),I('B2',35,'0.00'),L('A3','Populační směrodatná odchylka σ'),I('B3',15,'0.00'),L('A4','Velikost výběru n'),I('B4',100,'0'),L('A5','Hranice pro průměr'),I('B5',38,'0.00'),
  L('A7','Směrodatná chyba průměru'),C('B7','=B3/ODMOCNINA(B4)','0.000'),L('A8','Z-skór hranice'),C('B8','=(B5-B2)/B7','0.000'),
  L('A9','Průměr nejvýše roven hranici'),C('B9','=NORM.DIST(B5;B2;B7;PRAVDA)','0.0000'),L('A10','Průměr větší než hranice'),C('B10','=1-B9','0.0000'),
  L('A12','Dolní mez prostředních 95 % průměrů'),C('B12','=NORM.INV(0,025;B2;B7)','0.00'),L('A13','Horní mez prostředních 95 % průměrů'),C('B13','=NORM.INV(0,975;B2;B7)','0.00'),
  N('D2','Výukový model dob opuštění parkovacího místa.'),N('D3','Žlutě: vstupy. Modře: výpočty.'),
  N('D7','Do NORM.DIST patří směrodatná chyba z B7, ne σ z B3.'),N('D9','Normální model průměru se opírá o centrální limitní větu.'),
  N('D12','Rozmezí pro průměry výběrů, ne pro jednotlivce'),N('D13','a ne interval spolehlivosti.')]},
 {name:'Test_rozdilu',widths:{A:50,B:30,C:3,D:60},cells:[
  H('A1','Test rozdílu dvou průměrů'),H('B1','Hodnota'),
  L('A2','Pozorovaný rozdíl průměrů (s)'),I('B2',6.88,'0.00'),L('A3','Rozdíl podle nulové hypotézy (s)'),I('B3',0,'0.00'),
  L('A4','Směrodatná chyba rozdílu ve výukovém modelu (s)'),I('B4',2.1213,'0.0000'),L('A5','Hladina významnosti'),I('B5',.05,'0.00'),
  L('A7','Testová statistika z'),C('B7','=(B2-B3)/B4','0.000'),L('A8','P-hodnota, oboustranně'),C('B8','=2*(1-NORM.S.DIST(ABS(B7);PRAVDA))','0.0000'),
  L('A9','Kritická hodnota z'),C('B9','=NORM.S.INV(1-B5/2)','0.000'),L('A10','Kritická hodnota rozdílu (s)'),C('B10','=B3+B9*B4','0.000'),
  L('A11','Rozhodnutí testu'),C('B11',decision.replace('#','B8').replace('$','B5'),'General'),
  N('D2','Rozdíl podle Howella (2013, s. 86).'),N('D4','Hodnota z výukového modelu, ne odhad z dat studie.'),N('D5','Žlutě: vstupy. Modře: výpočty.'),
  N('D8','Výsledek výukového modelu, ne původní analýzy studie.'),N('D10','Kritický obor: pod −B10 a nad B10.'),N('D11','Po rozhodnutí následuje věcná interpretace.')]},
 {name:'Binom_test',widths:{A:50,B:30,C:3,D:8,E:14},cells:[
  H('A1','Binomický test, alternativa „více“'),H('B1','Hodnota'),H('D1','k'),H('E1','P(X ≥ k)'),
  L('A2','Počet pokusů n (nejvýše 20)'),I('B2',20,'0'),L('A3','Hraniční hodnota π podle nulové hypotézy'),I('B3',.25,'0.00'),
  L('A4','Pozorovaný počet úspěchů (alespoň 1)'),I('B4',10,'0'),L('A5','Hladina významnosti'),I('B5',.05,'0.00'),
  L('A7','P-hodnota: pozorovaný počet nebo více'),C('B7','=1-BINOM.DIST(B4-1;B2;B3;PRAVDA)','0.0000'),
  L('A8','Kritická hodnota'),C('B8','=BINOM.INV(B2;B3;1-B5)+1','0'),
  L('A9','Pravděpodobnost kritického oboru'),C('B9','=1-BINOM.DIST(B8-1;B2;B3;PRAVDA)','0.0000'),
  L('A10','Rozhodnutí testu'),C('B10',decision.replace('#','B7').replace('$','B5'),'General'),
  ...range(21,i=>[L(`D${2+i}`,i),C(`E${2+i}`,i===0?'=1':`=KDYŽ(D${2+i}>$B$2;"";1-BINOM.DIST(D${2+i}-1;$B$2;$B$3;PRAVDA))`,'0.0000')]),
  N('A12','Kritický obor: počty od B8 do B2.'),N('A13','B9 nepřekročí hladinu, ale nemusí jí dosáhnout: rozdělení je diskrétní.'),
  N('A14','Sloupce D a E: pravděpodobnost alespoň k úspěchů na hranici nulové hypotézy.'),N('A15','Po rozhodnutí následuje věcná interpretace.')]},
 {name:'Z_test',widths:{A:54,B:14,C:3,D:60},cells:[
  H('A1','Z-test průměru'),H('B1','Hodnota'),
  L('A2','Hraniční hodnota μ₀ podle nulové hypotézy'),I('B2',50,'0.00'),L('A3','Populační směrodatná odchylka σ'),I('B3',10,'0.00'),
  L('A4','Velikost výběru n'),I('B4',25,'0'),L('A5','Výběrový průměr m'),I('B5',46,'0.00'),L('A6','Hladina významnosti'),I('B6',.05,'0.00'),
  L('A8','Směrodatná chyba průměru'),C('B8','=B3/ODMOCNINA(B4)','0.000'),L('A9','Testová statistika z'),C('B9','=(B5-B2)/B8','0.000'),
  L('A10','P-hodnota pro alternativu „menší“'),C('B10','=NORM.S.DIST(B9;PRAVDA)','0.0000'),
  L('A11','P-hodnota pro alternativu „větší“'),C('B11','=1-NORM.S.DIST(B9;PRAVDA)','0.0000'),
  L('A12','P-hodnota oboustranně'),C('B12','=2*(1-NORM.S.DIST(ABS(B9);PRAVDA))','0.0000'),
  L('A13','Kritická hodnota průměru pro alternativu „menší“'),C('B13','=B2+NORM.S.INV(B6)*B8','0.00'),
  L('A14','Dolní kritická hodnota průměru oboustranně'),C('B14','=B2-NORM.S.INV(1-B6/2)*B8','0.00'),
  L('A15','Horní kritická hodnota průměru oboustranně'),C('B15','=B2+NORM.S.INV(1-B6/2)*B8','0.00'),
  L('A16','Kritická hodnota průměru pro alternativu „větší“'),C('B16','=B2-NORM.S.INV(B6)*B8','0.00'),
  N('D2','Autorský ilustrační model skóru pozornosti.'),N('D3','Známá σ je předpoklad; s výběrovou s jde o jiný test.'),N('D6','Žlutě: vstupy. Modře: výpočty.'),
  N('D10','Použijte jen p-hodnotu pro směr zvolený předem.'),N('D12','Dvojnásobek menší z obou jednostranných hodnot.'),N('D13','Po rozhodnutí následuje věcná interpretace.')]},
 {name:'Sila',widths:{A:46,B:14,C:3,D:60},cells:[
  H('A1','Statistická síla'),H('B1','Hodnota'),
  L('A2','Uvažovaný skutečný rozdíl (s)'),I('B2',5,'0.00'),L('A3','Směrodatná chyba rozdílu (s)'),I('B3',2.1213,'0.0000'),
  L('A4','Kritická hodnota rozdílu (s)'),C('B4','=NORM.S.INV(1-B5/2)*B3','0.000'),L('A5','Hladina významnosti'),I('B5',.05,'0.00'),
  L('A6','Plocha nad horní kritickou hodnotou'),C('B6','=1-NORM.DIST(B4;B2;B3;PRAVDA)','0.0000'),
  L('A7','Plocha pod dolní kritickou hodnotou'),C('B7','=NORM.DIST(-B4;B2;B3;PRAVDA)','0.0000'),
  L('A8','Statistická síla'),C('B8','=B6+B7','0.000'),
  N('D2','Nepovinné rozšíření; oboustranný test.'),N('D3','Žlutě: vstupy. Modře: výpočty.'),N('D4','Kritickou hodnotu určuje nulová hypotéza.'),
  N('D6','Plochy se měří pod křivkou alternativy.'),N('D8','Při B2 = 0 vyjde hladina významnosti.')]}
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
await populateStudentInputs(wb,6,out,specs);
const overview=wb.worksheets.getItem('Prehled');
overview.getRange('A5').values=[['Slovní úlohy 1 a 7 nevyžadují vlastní datový list.']];
overview.getRange('A6').values=[['Listy Sim_ a Skupiny obsahují simulovaná data z výukového modelu, nikoli pozorování lidí.']];
overview.getRange('C1').format.columnWidth=78;
// Simulated values are stored with three decimals in every column.
wb.worksheets.getItem('Sim_vyber').getRange('A2:A31').setNumberFormat('0.000');
wb.worksheets.getItem('Sim_prumery').getRange('A2:D10001').setNumberFormat('0.000');
wb.worksheets.getItem('Sim_rozdily').getRange('A2:A10001').setNumberFormat('0.000');
wb.worksheets.getItem('Skupiny').getRange('A2:A151').setNumberFormat('0');
wb.worksheets.getItem('Skupiny').getRange('B2:B151').setNumberFormat('0.000');
// Inputs of the binomial sheet stay within the range covered by its table.
const bt=wb.worksheets.getItem('Binom_test');
bt.getRange('B2').dataValidation={rule:{type:'whole',operator:'between',formula1:1,formula2:20,showError:true}};
bt.getRange('B3').dataValidation={rule:{type:'decimal',operator:'between',formula1:0,formula2:1,showError:true}};
bt.getRange('B4').dataValidation={rule:{type:'whole',operator:'between',formula1:1,formula2:20,showError:true}};
await wb.build(6,out);
