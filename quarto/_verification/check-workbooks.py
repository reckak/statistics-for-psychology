"""Check saved XLSX inputs, types, chapter references and publication boundaries.

Run after rebuilding the workbooks. Standard Python library only.
The per-build input manifests check export integrity; transcription into the
generator is separately reviewed against the chapter, recorded in docs/DATA.md.
"""
from pathlib import Path
import json, re, zipfile, xml.etree.ElementTree as ET
ROOT=Path(__file__).resolve().parents[2]
NS={'s':'http://schemas.openxmlformats.org/spreadsheetml/2006/main'}
REL='{http://schemas.openxmlformats.org/officeDocument/2006/relationships}id'
def read_book(path):
 with zipfile.ZipFile(path) as z:
  strings=[]
  if 'xl/sharedStrings.xml' in z.namelist():
   strings=[''.join(n.itertext()) for n in ET.fromstring(z.read('xl/sharedStrings.xml'))]
  rels={r.attrib['Id']:r.attrib['Target'] for r in ET.fromstring(z.read('xl/_rels/workbook.xml.rels'))}
  sheets={}
  for sh in ET.fromstring(z.read('xl/workbook.xml')).find('s:sheets',NS):
   target=rels[sh.attrib[REL]];target=target.lstrip('/') if target.startswith('/') else 'xl/'+target
   cells={}
   for c in ET.fromstring(z.read(target)).findall('.//s:c',NS):
    v=c.find('s:v',NS);kind=c.attrib.get('t');value=None
    if kind=='inlineStr':value=''.join(c.find('s:is',NS).itertext())
    elif v is not None and v.text is not None:
     value=strings[int(v.text)] if kind=='s' else v.text if kind in ('str','e') else float(v.text)
    cells[c.attrib['r']]=(value,c.find('s:f',NS) is not None,kind)
   sheets[sh.attrib['name']]=cells
 return sheets

checked=0
for n in range(1,7):
 path=ROOT/f'data/kapitola_{n:02}.xlsx';sheets=read_book(path)
 assert next(iter(sheets))=='Prehled',(n,'First tab')
 folder=f'chapter-{n:02}-build' if n!=4 else 'chapter-04'
 specs=json.loads((ROOT/f'tmp/{folder}/inputs.json').read_text(encoding='utf-8'))
 for spec in specs:
  cells=sheets[spec['name']]
  for i,row in enumerate(spec['rows'],2):
   for j,expected in enumerate(row):
    addr=f'{chr(65+j)}{i}';actual,formula,kind=cells.get(addr,(None,False,None))
    assert not formula,(n,spec['name'],addr,'Input replaced by formula')
    if isinstance(expected,(int,float)):
     assert isinstance(actual,(int,float)) and abs(actual-expected)<1e-10*max(1,abs(expected)),(n,spec['name'],addr,expected,actual)
    else: assert actual==expected,(n,spec['name'],addr,expected,actual)
    checked+=1
 # Exact references introduced in each exercise must resolve to populated ranges.
 text=(ROOT/f'quarto/kapitola_{n:02}.qmd').read_text(encoding='utf-8')
 for name,a,b in re.findall(r'`([^`]+)` ([A-Z]+\d+):([A-Z]+\d+)',text):
  assert name in sheets,(n,name)
  assert a in sheets[name] and b in sheets[name],(n,name,a,b)
 assert '.csv)' not in text,(n,'Student CSV link')
 print(f'Chapter {n}: {len(sheets)} sheets; inputs and references passed')
 # Check the actual published copy if rendered.
 published=ROOT/f'_book/data/kapitola_{n:02}.xlsx'
 if published.exists():assert published.read_bytes()==path.read_bytes(),(n,'Stale web workbook')
for path in (ROOT/'_book/data').glob('*.csv'):raise AssertionError(f'CSV published: {path}')
print(f'{checked} saved input cells checked, including types and missing values.')
