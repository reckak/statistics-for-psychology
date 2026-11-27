# Obnova sešitů v Excelu

[Zpět na provozní návody](../PROVOZ.md)

Příkazy spouštějte z kořene repozitáře. Pravidla tvorby sešitů určuje
[AGENTS.md](../../AGENTS.md#data-ke-kapitolám).

<a id="obnova-sešitů-a-podkladů-kapitol-16"></a>

## Obnova sešitů a podkladů kapitol 1–7

Všechny sešity (nyní kapitoly 1–10) se vytvářejí **přímo v desktopovém Excelu pro Windows**.
Potřebujete nainstalovaný český Excel (ověřeno 16.0), Windows PowerShell
5.1, Node.js a pro simulované vstupy kapitol 1 a 4–7 také R. Příkazy `node`
a `Rscript` musí být dostupné v `PATH`. Generátory používají pouze
standardní moduly Node.js a rozhraní COM instalovaného Excelu; nepotřebují
žádný balíček npm, `@oai/artifact-tool` ani prostředí konkrétního LLM.
Spouštějte je lokálně v uživatelské relaci, kde lze spustit Excel.

Z kořene projektu obnovte všechny sešity a spusťte jejich kontroly:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/build-workbooks.ps1 -Verify
```

Jedinou kapitolu lze obnovit například takto (bez `-Verify` se pouze
sestaví a zkontrolují chyby vzorců; nespustí se kapitolové zkoušky):

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/build-workbooks.ps1 -Chapter 4 -Verify
```

Přepínač `-Verify` spustí numerické kontroly a změny vstupů vybrané kapitoly
(pro kapitoly 2–7) a kontrolu chyb vzorců ve všech sedmi uložených sešitech.
Samotné kontroly sešity neukládají. Přepočet a konečnou podobu grafů zajišťuje
již generátor; dřívější dokončování pomocí `-Finalize` není k obnově potřeba.
Numerické kontroly v R a vizuální prohlídku proveďte také podle rozsahu změny.

### Zdroje a průběh sestavení

- `scripts/sesity-data.mjs`: společné vstupy, jejich původ a studentské přehledy.
- `scripts/kapitola_NN-sešit.mjs`: rozložení, vzorce a grafy dané kapitoly.
- `scripts/excel-workbook.mjs`: malá místní vrstva zapisující deklarace
  do JSON; sama nepočítá vzorce ani nevytváří XLSX.
- `scripts/build-workbook-excel.ps1`: společný zápis deklarací do skutečného
  Excelu, formátování, ověření vstupů, nativní grafy, přepočet a uložení.
- `scripts/sesity-simulace.R`: stejné pevně reprodukovatelné simulace jako
  v obrázcích; společný spouštěč jej pro kapitoly 4–7 zavolá automaticky.
- `scripts/kapitola_01-simulace.R`: společné simulace pedagogických příkladů
  pro grafy a sešit; generátor kapitoly 1 jej zavolá automaticky.

Každý sešit vzniká v samostatné skryté instanci Excelu. Skript se nepřipojuje
k otevřeným uživatelským sešitům. Nejprve uloží hotový přepočtený soubor
do `tmp/`, poté jej zkopíruje do `data/kapitola_NN.xlsx`; při chybě sestavení
zůstane předchozí studentský sešit zachován. Cílový sešit před obnovou zavřete.
Výstup se otevírá na listu `Prehled` a při ukládání se odstraňují osobní
údaje z vlastností dokumentu.

Generátory kapitol 1–4 zadávají vzorce prostřednictvím `Formula`
ve standardním anglickém zápisu. Kapitoly 5–7 používají české `FormulaLocal`.
České vzorce z učebnice navíc skutečně spouštějí kapitolové kontroly.
Číselné formáty buněk a os respektují místní oddělovače. Textové hodnoty
zůstávají textem i tehdy, když vypadají jako číslo; chybění zůstává prázdné.
Čistě číselné bloky od 1 000 řádků (zatím jen simulovaná data kapitoly 6)
zapisuje generátor jedním přiřazením celé oblasti; menší bloky zůstávají
u zápisu po buňkách se zachováním typů. Kontrola chyb vzorců přeskakuje listy,
které žádný vzorec neobsahují.
Nové soubory PowerShellu používají ASCII a české texty čtou z UTF-8 JSON;
skripty s českými literály musí mít pro Windows PowerShell 5.1 UTF-8 BOM.

### Ověření obsahu a vzhledu

Kontrola vstupů používá standardní Python bez dalších knihoven:

```powershell
python quarto/_verification/check-workbooks.py
```

Porovnává uložené vstupy, typy, chybění a odkazy na listy a buňky v kapitolách.
Deklarace vznikají při sestavení v `tmp/chapter-NN-build/inputs.json`
(kapitola 4: `tmp/chapter-04/inputs.json`). Jejich shoda nenahrazuje
redakční porovnání s textem; pokrytí eviduje [docs/DATA.md](../DATA.md).
Kontrolu spusťte **po renderování knihy**, protože kontroluje také totožnost
sešitů v `data/` a `_book/data/`. Při renderování se sešity pouze kopírují;
Excel se nespouští a na GitHubu není k sestavení webu potřeba.

Kontrola kapitoly 5 navíc ověřuje přepočet popisků při změně hranic,
krajní pravděpodobnosti 0 a 1 a ochranu pevných počtů pokusů.
Na listu `Binom` lze upravit pouze B3; na `Binom_20` B3:B5. Ochrana listů
bez hesla chrání výukové vzorce před náhodným přepsáním.

Pro vizuální prohlídku všech listů vytvořte náhledy přímo z Excelu:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File quarto/_verification/preview-workbooks-excel.ps1
```

Kontrolní PDF a přehled oblastí vznikají v `tmp/workbook-previews/`.
U dlouhých vstupních listů náhled ukazuje prvních 15 řádků; kontrola hodnot
prochází všechna data. Výpočtové listy a přehledy se zobrazují celé.
Volitelné parametry `-Chapter 4 -Sheet QQ` omezí náhled na dotčený list.
Tisková nastavení náhledů se do studentských sešitů neukládají.

Při migraci generátoru nejprve odložte kontrolní kopie původních pěti
sešitů do ignorované složky. Nástroj `compare-workbooks.py` pak porovná
všechny vyplněné buňky, vzorce, uložené výsledky, pořadí listů, sloučení
buněk, ukotvení, ověření vstupů, číselné formáty, vazby a meze os grafů. Pouze tato doplňková
kontrola vyžaduje veřejnou knihovnu `openpyxl` (`python -m pip install openpyxl`):

```powershell
python quarto/_verification/compare-workbooks.py tmp/excel-migration/before
```

Grafy učebnice se obnovují při každém renderování; samostatně příkazem
`Rscript --vanilla scripts/render-figures.R`. Názorné rekonstrukce listů
jsou editovatelné SVG; obnovuje je `python scripts/kapitola_02-ukazky.py`
(standardní knihovna Pythonu). Při změně vstupů obnovte sešit, související
ilustrace a knihu a ověřte navazující výklad. Pomocné výstupy patří do `tmp/`.
