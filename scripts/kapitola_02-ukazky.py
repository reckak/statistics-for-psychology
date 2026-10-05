"""Create editable SVG reconstructions of the verified Excel examples (stdlib only)."""
from pathlib import Path
from html import escape
import csv

data=list(csv.DictReader(Path('data/kapitola_02.csv').open(encoding='utf-8')))
freq=[sum(int(r['odpocatost'])==i for r in data) for i in range(1,5)]
sleep=[float(r['spanek_h']) for r in data if r['spanek_h']]
bins=[sum(lo<v<=lo+1 for v in sleep) for lo in range(4,10)]
assert freq==[4,10,14,8] and bins==[3,5,8,10,5,2]
def fmt(v,d=3): return f'{v:.{d}f}'.replace('.',',')
def make(name,title,selected,formula,headers,widths,rows,highlight,notes,sheet):
    w=sum(widths)+48; h=465 if len(rows)<5 else 535
    parts=[f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}" role="img" aria-labelledby="title desc">',f'<title id="title">{escape(title)}</title>',f'<desc id="desc">Názorná rekonstrukce excelového listu. {escape(formula)}. {escape(" ".join(notes))}</desc>', '<style>text{font-family:Arial,sans-serif;fill:#223744;font-size:18px}.small{font-size:16px}.label{font-weight:700}.white{fill:white}.mono{font-family:Consolas,monospace;font-size:16px}</style>']
    def box(x,y,bw,bh,fill,stroke='#cad5da',sw=1): parts.append(f'<rect x="{x}" y="{y}" width="{bw}" height="{bh}" fill="{fill}" stroke="{stroke}" stroke-width="{sw}"/>')
    def txt(x,y,s,cls='',anchor='start'): parts.append(f'<text x="{x}" y="{y}" class="{cls}" text-anchor="{anchor}">{escape(str(s))}</text>')
    box(0,0,w,h,'#fff');box(0,0,w,42,'#234f62');txt(18,28,title,'label white')
    box(12,54,64,34,'#edf5f1');txt(44,77,selected,'label','middle');txt(93,77,'fx','small')
    box(120,54,w-132,34,'#fff');txt(130,77,formula,'mono')
    txt(17,119,f'{sheet}!C2 = {len(data) if sheet=="Cetnosti" else len(sleep)} platných údajů', 'small')
    y0=136; rowh=34
    box(0,y0,48,rowh,'#edf1f3')
    x=48
    for i,width in enumerate(widths):
        box(x,y0,width,rowh,'#edf1f3');txt(x+width/2,y0+23,chr(65+i),'small','middle');x+=width
    for j,(rn,vals) in enumerate([(4,headers)]+rows):
        y=y0+(j+1)*rowh
        box(0,y,48,rowh,'#edf1f3');txt(24,y+23,rn,'small','middle');x=48
        for c,(v,width) in enumerate(zip(vals,widths)):
            box(x,y,width,rowh,'#234f62' if j==0 else '#fff')
            isnum=c>1 or (c==0 and sheet=='Cetnosti') or (c<2 and sheet=='Histogram')
            txt(x+width/2 if j==0 else (x+width-10 if isnum else x+10),y+23,v,'small white label' if j==0 else '', 'middle' if j==0 else ('end' if isnum else 'start'));x+=width
    # Outline the selected cell and its referenced cells, without covering values.
    for col,rn,color in highlight:
        x=48+sum(widths[:col]); pos=[r[0] for r in rows].index(rn)+2
        box(x+1,y0+pos*rowh+1,widths[col]-2,rowh-2,'none',color,3)
    y=y0+(len(rows)+2)*rowh+31
    for line in notes: txt(16,y,line,'small');y+=25
    box(0,h-32,w,32,'#edf1f3');txt(20,h-10,f'Data     |     Cetnosti     |     Histogram          Zobrazený list: {sheet}','small')
    parts.append('</svg>'); out=Path('assets/chapter-02');out.mkdir(exist_ok=True,parents=True)
    (out/f'{name}.svg').write_text('\n'.join(parts),encoding='utf-8')

labels=['Vůbec','Trochu','Dost','Zcela']; cumulative=[sum(freq[:i+1]) for i in range(4)]
make('excel-absolutni','Absolutní četnosti · vybraná buňka C5','C5','=COUNTIFS(Data!$E$2:$E$37;A5)',
     ['Kód','Odpočatost','Četnost'],[150,330,380],[(i+5,[i+1,labels[i],freq[i]]) for i in range(4)],[(2,5,'#168154'),(0,5,'#267888')],
     ['C5 vrací 4: tolik odpovědí ve sloupci Data!E2:E37 má kód 1.', 'Při kopírování dolů se mění A5 → A6 → A7 → A8. Oblast s dolary zůstává pevná.'],'Cetnosti')
make('excel-kumulativni','Kumulativní četnosti · vybraná buňka F6','F6','=SUMA($C$5:C6)',
     ['Kód','Odpočatost','Četnost','Podíl','Procenta','Kumul. počet','Kumul. podíl','Kumul. %'],[55,145,90,100,100,120,120,115],
     [(i+5,[i+1,labels[i],freq[i],fmt(freq[i]/36),fmt(100*freq[i]/36,1)+' %',cumulative[i],fmt(cumulative[i]/36),fmt(100*cumulative[i]/36,1)+' %']) for i in range(4)],
     [(5,6,'#168154'),(2,5,'#267888'),(2,6,'#267888')],
     ['F6 sčítá C5 a C6: 4 + 10 = 14 účastníků s odpovědí nejvýše „trochu“.','G6 = F6/$C$2 → 14/36. Zobrazeno 0,389; výpočet používá celý podíl.'],'Cetnosti')
make('excel-intervaly','Intervalové četnosti · vybraná buňka D5','D5','=COUNTIFS(Data!$B$2:$B$37;">"&A5;Data!$B$2:$B$37;"<="&B5)',
     ['Dolní mez','Horní mez','Interval (h)','Četnost','Podíl','Procenta'],[132,132,194,134,134,134],
     [(i+5,[i+4,i+5,f'> {i+4} až {i+5}',bins[i],fmt(bins[i]/33),fmt(100*bins[i]/33,1)+' %']) for i in range(6)],
     [(3,5,'#168154'),(0,5,'#267888'),(1,5,'#b16a26')],
     ['Obě podmínky současně: více než dolní mez a nejvýše horní mez.', 'Hodnota přesně 5 patří do prvního intervalu. Tři prázdné buňky nejsou započítány.'],'Histogram')
print('Created three labelled SVG worksheet reconstructions.')
