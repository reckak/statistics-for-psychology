"""Check actual rendered PDFs with public pypdf, not just conversion settings."""
import json
import re
from pathlib import Path
from pypdf import PdfReader
from pypdf.generic import ContentStream

report = []
# Chapter PDFs and, when it has been built, the PDF of the whole book.
targets = [(f'kapitola_{c:02}', [c]) for c in (3, 4, 5, 6, 7, 8, 9)]
if Path('output/pdf/zaklady-statistiky-pro-psychology.pdf').exists():
    book = [int(n) for n in re.findall(r'quarto/kapitola_(\d\d)\.qmd', Path('_quarto.yml').read_text(encoding='utf8'))]
    targets.append(('zaklady-statistiky-pro-psychology', book))
for name, chapters in targets:
    chapter = name
    source = ''.join(Path(f'quarto/kapitola_{c:02}.qmd').read_text(encoding='utf8') for c in chapters)
    reader = PdfReader(f'output/pdf/{name}.pdf')
    notes = []
    gray_strokes = 0
    for page in reader.pages:
        def visit(text, cm, tm, font, size):
            if 'Poznámka.' in text:
                notes.append(float(size))
        page.extract_text(visitor_text=visit)
        for args, op in ContentStream(page.get_contents(), reader).operations:
            if op in (b'RG', b'SCN') and len(args) == 3 and all(abs(float(x)-200/255) < 0.0001 for x in args):
                gray_strokes += 1
    assert len(notes) == source.count('{.table-note}'), (chapter, notes)
    assert all(abs(size - 9) < 0.001 for size in notes), (chapter, notes)
    assert gray_strokes > 0, f'Chapter {chapter}: faint table lines missing'
    report.append(dict(chapter=chapter, pages=len(reader.pages), note_sizes=notes, gray_strokes=gray_strokes))
print(json.dumps(report, ensure_ascii=False, indent=2))
