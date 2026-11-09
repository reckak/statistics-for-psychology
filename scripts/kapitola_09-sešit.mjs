// Native Excel workbook for chapter 9. No simulated inputs; all data are declared in sesity-data.mjs.
import {inputs, populateStudentInputs} from './sesity-data.mjs';
import fs from 'node:fs/promises';
import {ExcelWorkbook} from './excel-workbook.mjs';
const out='tmp/chapter-09-build';await fs.mkdir(out,{recursive:true});
const specs=[...inputs[9]];
// Calculation sheets: [cell, kind, value or Czech formula, number format].
// Kinds: head, label, input, calc, note. Formulas use Czech names and semicolons.
const L=(a,v)=>[a,'label',v],I=(a,v,f='General')=>[a,'input',v,f],C=(a,v,f='0.000')=>[a,'calc',v,f],N=(a,v)=>[a,'note',v],H=(a,v)=>[a,'head',v];
const cols=['B','C','D'];
// Wilson limits for x in cell X, n in cell M, proportion in P and quantile in Z.
const wilson=(P,M,Z,sign)=>`=(${P}+${Z}^2/(2*${M}))/(1+${Z}^2/${M})${sign}${Z}/(1+${Z}^2/${M})*ODMOCNINA(${P}*(1-${P})/${M}+${Z}^2/(4*${M}^2))`;
// Contingency table of Zvladani: observed B3:D5, sums E3:E5 and B6:D6, n in E6.
const grid=[];
for(let r=0;r<3;r++){
 const R=3+r;
 grid.push(L(`A${R}`,['mladí (18–30)','dospělí (31–60)','senioři (60+)'][r]),C(`E${R}`,`=SUMA(B${R}:D${R})`,'0'));
 grid.push(L(`A${9+r}`,`=A${R}`),L(`A${14+r}`,`=A${R}`),L(`A${24+r}`,`=A${R}`),L(`A${28+r}`,`=A${R}`),L(`A${32+r}`,`=A${R}`),L(`A${37+r}`,`=A${R}`));
 cols.forEach((c,j)=>{
  grid.push(I(`${c}${R}`,[[25,18,12],[30,22,28],[10,20,25]][r][j],'0'));
  grid.push(C(`${c}${9+r}`,`=$E${R}*${c}$6/$E$6`,'0.00'));
  grid.push(C(`${c}${14+r}`,`=(${c}${R}-${c}${9+r})^2/${c}${9+r}`,'0.000'));
  grid.push(C(`${c}${24+r}`,`=${c}${R}/$E${R}`,'0.000'));
  grid.push(C(`${c}${28+r}`,`=(${c}${R}-${c}${9+r})/ODMOCNINA(${c}${9+r})`,'0.00'));
  grid.push(C(`${c}${32+r}`,`=(${c}${R}-${c}${9+r})/ODMOCNINA(${c}${9+r}*(1-$E${R}/$E$6)*(1-${c}$6/$E$6))`,'0.00'));
  grid.push(C(`${c}${37+r}`,`=2*(1-NORM.S.DIST(ABS(${c}${32+r});PRAVDA))`,'0.0000'));
 });
}
cols.forEach((c,j)=>{grid.push(L(`${c}2`,['Řešení problému','Vyhýbání','Sociální opora'][j]),C(`${c}6`,`=SUMA(${c}3:${c}5)`,'0'));
 for(const h of [8,13,23,27,31,36])grid.push(L(`${c}${h}`,`=${c}$2`));});
// Holm: ordered p-values of the nine cells, thresholds alpha/(m-k+1) and the step-down decision.
const holm=[];
for(let k=1;k<=9;k++){
 const R=41+k-1;
 holm.push(L(`A${R}`,k),C(`B${R}`,`=SMALL($B$37:$D$39;A${R})`,'0.0000'),C(`C${R}`,`=$B$50/(10-A${R})`,'0.0000'));
 holm.push(C(`D${R}`,k===1?`=KDYŽ(B${R}<=C${R};"zamítáme";"nezamítáme")`:`=KDYŽ(A(B${R}<=C${R};D${R-1}="zamítáme");"zamítáme";"nezamítáme")`,'General'));
}
// Fisher: probabilities of all tables with the observed margins, a = 0..20.
const fisherRows=[];
for(let a=0;a<=20;a++){
 const R=2+a;
 fisherRows.push(L(`D${R}`,a),C(`E${R}`,`=KDYŽ(A(D${R}>=$B$8;D${R}<=$B$9);HYPGEOM.DIST(D${R};$B$5;$B$6;$B$7;NEPRAVDA);"")`,'0.00000'));
}
const sheets=[
 {name:'Interval_podilu',widths:{A:50,B:14,C:3,D:58},cells:[
  H('A1','Interval pro podíl a skórový test'),H('B1','Hodnota'),
  L('A2','Počet úspěchů'),I('B2',10,'0'),L('A3','Počet pokusů n'),I('B3',20,'0'),
  L('A4','Hladina spolehlivosti'),I('B4',.95,'0.00'),L('A5','Testovaná hodnota π₀'),I('B5',.25,'0.00'),
  L('A7','Výběrový podíl p'),C('B7','=B2/B3','0.000'),
  L('A8','Kvantil z'),C('B8','=NORM.S.INV(1-(1-B4)/2)','0.0000'),
  L('A9','Waldův interval: odhad směrodatné chyby'),C('B9','=ODMOCNINA(B7*(1-B7)/B3)','0.0000'),
  L('A10','Waldův interval: dolní mez'),C('B10','=B7-B8*B9','0.000'),L('A11','Waldův interval: horní mez'),C('B11','=B7+B8*B9','0.000'),
  L('A13','Wilsonův interval: střed'),C('B13','=(B7+B8^2/(2*B3))/(1+B8^2/B3)','0.000'),
  L('A14','Wilsonův interval: polovina šířky'),C('B14','=B8/(1+B8^2/B3)*ODMOCNINA(B7*(1-B7)/B3+B8^2/(4*B3^2))','0.000'),
  L('A15','Wilsonův interval: dolní mez'),C('B15','=B13-B14','0.000'),L('A16','Wilsonův interval: horní mez'),C('B16','=B13+B14','0.000'),
  L('A18','Skórový test: testová statistika z'),C('B18','=(B7-B5)/ODMOCNINA(B5*(1-B5)/B3)','0.000'),
  L('A19','Skórový test: oboustranná p-hodnota'),C('B19','=2*(1-NORM.S.DIST(ABS(B18);PRAVDA))','0.0000'),
  N('D2','Výchozí vstupy: test s 20 otázkami (list Test_20).'),N('D4','Žlutě: vstupy. Modře: výpočty.'),
  N('D9','Waldův interval jen pro srovnání; u malých výběrů a krajních podílů selhává.'),
  N('D15','Pro výsledek používejte Wilsonův interval.'),N('D18','Směrodatná chyba se počítá z testované hodnoty π₀.')]},
 {name:'Dva_podily',widths:{A:56,B:14,C:3,D:60},cells:[
  H('A1','Rozdíl dvou nezávislých podílů'),H('B1','Hodnota'),
  L('A2','Počet úspěchů v první skupině'),I('B2',40,'0'),L('A3','Velikost první skupiny n₁'),I('B3',100,'0'),
  L('A4','Počet úspěchů ve druhé skupině'),I('B4',30,'0'),L('A5','Velikost druhé skupiny n₂'),I('B5',100,'0'),
  L('A6','Hladina spolehlivosti'),I('B6',.95,'0.00'),
  L('A8','Podíl p₁'),C('B8','=B2/B3'),L('A9','Podíl p₂'),C('B9','=B4/B5'),L('A10','Rozdíl p₁ − p₂'),C('B10','=B8-B9'),
  L('A11','Kvantil z'),C('B11','=NORM.S.INV(1-(1-B6)/2)','0.0000'),
  L('A12','Wilsonův interval první skupiny: dolní mez'),C('B12',wilson('B8','B3','B11','-')),
  L('A13','Wilsonův interval první skupiny: horní mez'),C('B13',wilson('B8','B3','B11','+')),
  L('A14','Wilsonův interval druhé skupiny: dolní mez'),C('B14',wilson('B9','B5','B11','-')),
  L('A15','Wilsonův interval druhé skupiny: horní mez'),C('B15',wilson('B9','B5','B11','+')),
  L('A16','Newcombův interval pro rozdíl: dolní mez'),C('B16','=B10-ODMOCNINA((B8-B12)^2+(B15-B9)^2)'),
  L('A17','Newcombův interval pro rozdíl: horní mez'),C('B17','=B10+ODMOCNINA((B13-B8)^2+(B9-B14)^2)'),
  L('A19','Společný podíl'),C('B19','=(B2+B4)/(B3+B5)'),
  L('A20','Směrodatná chyba rozdílu při H₀'),C('B20','=ODMOCNINA(B19*(1-B19)*(1/B3+1/B5))','0.0000'),
  L('A21','Testová statistika z'),C('B21','=B10/B20'),
  L('A22','Oboustranná p-hodnota'),C('B22','=2*(1-NORM.S.DIST(ABS(B21);PRAVDA))','0.0000'),
  L('A23','Statistika chí-kvadrát tabulky 2 × 2 (= z²)'),C('B23','=B21^2'),
  L('A24','Táž p-hodnota z chí-kvadrát rozdělení'),C('B24','=CHISQ.DIST.RT(B23;1)','0.0000'),
  N('D2','Výchozí vstupy: ženy a muži se zvýšeným stresem (list Stres).'),N('D6','Žlutě: vstupy. Modře: výpočty.'),
  N('D16','Newcombův interval vychází z Wilsonových intervalů obou skupin.'),
  N('D19','Test počítá v modelu nulové hypotézy, proto společný podíl; interval ne.')]},
 {name:'Dobra_shoda',widths:{A:44,B:16,C:16,D:16,E:16,F:3,G:50},cells:[
  H('A1','Kategorie'),H('B1','Pozorovaná četnost f'),H('C1','Podíl podle H₀ π₀'),H('D1','Očekávaná četnost e'),H('E1','Příspěvek (f − e)²/e'),
  ...[2,3,4,5].flatMap((r,i)=>[L(`A${r}`,['1. zleva','2. zleva','3. zleva','4. zleva (vpravo)'][i]),I(`B${r}`,[12,16,21,31][i],'0'),I(`C${r}`,.25,'0.000'),C(`D${r}`,`=$B$7*C${r}`,'0.00'),C(`E${r}`,`=(B${r}-D${r})^2/D${r}`,'0.000')]),
  L('A7','Počet pozorování n'),C('B7','=SUMA(B2:B5)','0'),
  L('A8','Statistika chí-kvadrát'),C('B8','=SUMA(E2:E5)','0.000'),
  L('A9','Stupně volnosti'),C('B9','=POČET(B2:B5)-1','0'),
  L('A10','P-hodnota'),C('B10','=CHISQ.DIST.RT(B8;B9)','0.0000'),
  L('A11','Kritická hodnota pro α = 0,05'),C('B11','=CHISQ.INV.RT(0,05;B9)','0.000'),
  L('A12','Kontrola: CHISQ.TEST'),C('B12','=CHISQ.TEST(B2:B5;D2:D5)','0.0000'),
  L('A13','Kontrola: součet podílů π₀ (musí být 1)'),C('B13','=SUMA(C2:C5)','0.000'),
  N('G2','Výchozí vstupy: volba pozice čaje (list Pozice).'),N('G3','Žlutě: četnosti a podíly podle nulové hypotézy; lze je změnit.'),
  N('G8','Všechny očekávané četnosti mají být alespoň 5.')]},
 {name:'Tabulka',widths:{A:36,B:16,C:16,D:16,E:14,F:3,G:56},cells:[
  H('A1','Test nezávislosti a rezidua'),H('B1','Pozorované četnosti'),H('E1','Součet'),
  L('A2','Kategorie'),L('A6','Součet'),C('E6','=SUMA(B3:D5)','0'),
  H('A8','Očekávané četnosti'),H('A13','Příspěvky ke statistice'),
  L('A17','Statistika chí-kvadrát'),C('B17','=SUMA(B14:D16)','0.000'),
  L('A18','Stupně volnosti'),C('B18','=(ŘÁDKY(B3:D5)-1)*(SLOUPCE(B3:D5)-1)','0'),
  L('A19','P-hodnota'),C('B19','=CHISQ.DIST.RT(B17;B18)','0.0000'),
  L('A20','Kontrola: CHISQ.TEST'),C('B20','=CHISQ.TEST(B3:D5;B9:D11)','0.0000'),
  L('A21','Cramérovo V'),C('B21','=ODMOCNINA(B17/(E6*(MIN(ŘÁDKY(B3:D5);SLOUPCE(B3:D5))-1)))','0.000'),
  H('A23','Řádkové podíly'),H('A27','Pearsonova rezidua'),H('A31','Upravená rezidua'),
  H('A36','Nepovinně: p-hodnoty upravených reziduí'),
  H('A40','Pořadí k'),H('B40','Seřazená p-hodnota'),H('C40','Holmova hranice'),H('D40','Rozhodnutí'),
  L('A50','Hladina α pro Holmovu korekci'),I('B50',.05,'0.00'),
  ...grid,...holm,
  N('G3','Výchozí vstupy: věk a strategie zvládání (list Zvladani); žluté buňky lze změnit.'),N('G9','e = řádkový součet × sloupcový součet / n.'),
  N('G17','Všechny očekávané četnosti mají být alespoň 5.'),N('G24','Řádkové podíly porovnávají skupiny různé velikosti.'),
  N('G32','Upravená rezidua: přibližně N(0, 1) při H₀.'),N('G33','Bez korekce jen popisují vzorec, nejsou to samostatné testy.'),
  N('G41','Holmova korekce: zamítáme postupně, dokud p-hodnota nepřekročí hranici α/(m − k + 1).')]},
 {name:'Mira_souvislosti',widths:{A:56,B:16,C:16,D:3,E:58},cells:[
  H('A1','Míry velikosti souvislosti v tabulce 2 × 2'),H('B1','Jev nastal'),H('C1','Jev nenastal'),
  L('A2','První skupina (sexualizované fotografie)'),I('B2',56,'0'),I('C2',84,'0'),
  L('A3','Referenční skupina (sportovní výkon)'),I('B3',20,'0'),I('C3',97,'0'),
  L('A5','Riziko v první skupině'),C('B5','=B2/(B2+C2)','0.0000'),
  L('A6','Riziko v referenční skupině'),C('B6','=B3/(B3+C3)','0.0000'),
  L('A7','Rozdíl rizik (podílů)'),C('B7','=B5-B6','0.0000'),
  L('A8','Poměr rizik'),C('B8','=B5/B6','0.000'),
  L('A9','Šance v první skupině'),C('B9','=B2/C2','0.0000'),
  L('A10','Šance v referenční skupině'),C('B10','=B3/C3','0.0000'),
  L('A11','Poměr šancí'),C('B11','=B9/B10','0.000'),
  L('A12','Počet pozorování n'),C('B12','=SUMA(B2:C3)','0'),
  L('A13','Statistika chí-kvadrát'),C('B13','=B12*(B2*C3-C2*B3)^2/((B2+C2)*(B3+C3)*(B2+B3)*(C2+C3))','0.000'),
  L('A14','P-hodnota (1 stupeň volnosti)'),C('B14','=CHISQ.DIST.RT(B13;1)','0.000000'),
  L('A15','Koeficient φ (absolutní hodnota)'),C('B15','=ODMOCNINA(B13/B12)','0.000'),
  L('A16','Koeficient φ se znaménkem podle orientace tabulky'),C('B16','=(B2*C3-C2*B3)/ODMOCNINA((B2+C2)*(B3+C3)*(B2+B3)*(C2+C3))','0.000'),
  L('A18','Nepovinně: hladina spolehlivosti'),I('B18',.95,'0.00'),
  L('A19','Nepovinně: kvantil z'),C('B19','=NORM.S.INV(1-(1-B18)/2)','0.0000'),
  L('A20','Nepovinně: odhad směrodatné chyby ln poměru rizik'),C('B20','=ODMOCNINA(1/B2-1/(B2+C2)+1/B3-1/(B3+C3))','0.0000'),
  L('A21','Nepovinně: poměr rizik, dolní mez'),C('B21','=EXP(LN(B8)-B19*B20)','0.000'),
  L('A22','Nepovinně: poměr rizik, horní mez'),C('B22','=EXP(LN(B8)+B19*B20)','0.000'),
  L('A23','Nepovinně: odhad směrodatné chyby ln poměru šancí'),C('B23','=ODMOCNINA(1/B2+1/C2+1/B3+1/C3)','0.0000'),
  L('A24','Nepovinně: poměr šancí, dolní mez'),C('B24','=EXP(LN(B11)-B19*B23)','0.000'),
  L('A25','Nepovinně: poměr šancí, horní mez'),C('B25','=EXP(LN(B11)+B19*B23)','0.000'),
  N('E2','Výchozí vstupy: údaje Danielsové (list Daniels).'),N('E3','Druhý řádek je referenční skupina ve jmenovateli poměrů.'),
  N('E8','Poměr rizik a poměr šancí nejsou totéž.'),N('E16','Znaménko φ závisí jen na pořadí řádků a sloupců.'),
  N('E7','Interval pro rozdíl spočítáte na listu Dva_podily.')]},
 {name:'McNemar',widths:{A:56,B:16,C:16,D:3,E:58},cells:[
  H('A1','Tabulka přechodů: podzim (řádky) × jaro (sloupce)'),H('B1','Jaro: ano'),H('C1','Jaro: ne'),
  L('A2','Podzim: ano'),I('B2',38,'0'),I('C2',4,'0'),L('A3','Podzim: ne'),I('B3',12,'0'),I('C3',18,'0'),
  L('A5','Počet úplných dvojic n'),C('B5','=SUMA(B2:C3)','0'),
  L('A6','Podíl „ano“ v prvním měření'),C('B6','=(B2+C2)/B5','0.000'),
  L('A7','Podíl „ano“ ve druhém měření'),C('B7','=(B2+B3)/B5','0.000'),
  L('A8','Rozdíl podílů (druhé − první)'),C('B8','=B7-B6','0.000'),
  L('A9','Počet neshodných dvojic'),C('B9','=C2+B3','0'),
  L('A10','Přesná oboustranná p-hodnota (binomický test)'),C('B10','=KDYŽ(B9=0;"nelze: žádná neshodná dvojice";MIN(1;2*BINOM.DIST(MIN(C2;B3);B9;0,5;PRAVDA)))','0.0000'),
  L('A11','Statistika chí-kvadrát (aproximace)'),C('B11','=KDYŽ(B9=0;"nelze";(B3-C2)^2/B9)','0.000'),
  L('A12','P-hodnota aproximace (1 stupeň volnosti)'),C('B12','=KDYŽ(B9=0;"nelze";CHISQ.DIST.RT(B11;1))','0.0000'),
  N('E2','Výchozí vstupy: vyhledávání pomoci (list Pomoc).'),N('E3','Jen úplné dvojice; každá dvojice je v tabulce jednou.'),
  N('E8','Rozdíl podílů se vztahuje ke všem úplným dvojicím.'),N('E9','Testovou statistiku určují jen neshodné dvojice.'),
  N('E10','Při malém počtu neshodných dvojic používejte přesný výpočet.')]},
 {name:'Fisher',widths:{A:56,B:14,C:14,D:10,E:16,F:3,G:50},cells:[
  H('A1','Nepovinně: Fisherův exaktní test (2 × 2)'),H('B1','Zlepšení'),H('C1','Bez zlepšení'),H('D1','Hodnota a'),H('E1','P(a) při daných součtech'),
  L('A2','Intervence'),I('B2',8,'0'),I('C2',2,'0'),L('A3','Kontrola'),I('B3',3,'0'),I('C3',7,'0'),
  L('A5','Součet prvního řádku'),C('B5','=B2+C2','0'),L('A6','Součet prvního sloupce'),C('B6','=B2+B3','0'),
  L('A7','Počet pozorování n'),C('B7','=SUMA(B2:C3)','0'),
  L('A8','Nejmenší možné a'),C('B8','=MAX(0;B5+B6-B7)','0'),L('A9','Největší možné a'),C('B9','=MIN(B5;B6)','0'),
  L('A10','Pravděpodobnost pozorované tabulky'),C('B10','=HYPGEOM.DIST(B2;B5;B6;B7;NEPRAVDA)','0.00000'),
  L('A11','Oboustranná p-hodnota'),C('B11','=SUMIF(E2:E22;"<="&B10*(1+0,0000001))','0.0000'),
  ...fisherRows,
  N('G2','Výchozí vstupy: pilotní studie (list Pilot).'),N('G3','a = počet v levé horní buňce; okrajové součty jsou pevné.'),
  N('G11','Sečtou se tabulky stejně nebo méně pravděpodobné než pozorovaná.')]}
];
const wb=new ExcelWorkbook();wb.worksheets.add('Prehled');
for(const spec of sheets){
 const sh=wb.worksheets.add(spec.name);sh.showGridLines=true;
 sh.getRange('A1:I50').format={font:{name:'Arial',size:11,color:'#223744'},verticalAlignment:'center'};
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
await populateStudentInputs(wb,9,out,specs);
const overview=wb.worksheets.getItem('Prehled');
overview.getRange('A5').values=[['Slovní úlohy 1, 8, 9 a 12 nevyžadují vlastní datový list; úloha 3 používá list Interval_podilu se změněnými vstupy.']];
overview.getRange('A6').values=[['Tabulky četností: řádek je kategorie nebo skupina, ne jeden člověk. Do výpočtů patří absolutní četnosti.']];
overview.getRange('C1').format.columnWidth=78;
await wb.build(9,out);
