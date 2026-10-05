# Základy statistiky pro psychology 1

Česká učebnice pro jednosemestrální kurz statistiky ve druhém ročníku bakalářského studia psychologie. Předpokládá matematiku na úrovni základní školy a nevyžaduje znalost R ani programování. Výklad propojuje statistické uvažování s psychologickými příklady, komentovanými postupy a cvičeními se sbaleným řešením.

**[Otevřít webovou učebnici](https://reckak.github.io/statistics-for-psychology/)**

Projekt používá [Quarto Book](https://quarto.org/docs/books/). Aktuálně obsahuje úvod, kapitoly **Od psychologické otázky k datům**, **Četnosti, rozdělení dat a jejich zobrazení** a **Ukazatele polohy a variability** a tři průběžně doplňované přehledy: slovníček pojmů, značení a vzorce a funkce Excelu. Druhá a třetí kapitola obsahují modelová data a upravitelné excelové sešity. Navigace má dvě rozbalovací části: **Výkladové kapitoly** a **Literatura a přehledy**. Úvod stojí před nimi; druhá část začíná společnou nečíslovanou literaturou a pokračuje třemi přehledy.

## Práce s projektem

Pro sestavení webu potřebujete Quarto; projekt je ověřován s verzí **1.9.38**. V RStudiu otevřete kořenovou složku projektu. R slouží k interním kontrolám výpočtů, jeho kód se studentům nezobrazuje. Render nyní vyžaduje také **R** (ověřeno 4.5.1), dostupné jako `Rscript`. Před sestavením vytváří grafy z pevných dat; nejsou potřeba žádné další balíčky R. Spouštěcí skript zajišťuje načtení českých popisků v UTF-8 i ve Windows. Matematiku Quarto převádí do nativního MathML, takže její zobrazení nevyžaduje přístup k externímu serveru.

Z kořene projektu vykreslete celou učebnici:

```sh
quarto render
```

Pro prohlížení s průběžným obnovováním použijte:

```sh
quarto preview
```

Výstup vzniká ve složce `_book/`, úvodní stránka je `_book/index.html`. Pro přenos nebo publikování zachovejte celou složku `_book/` včetně podpůrných souborů. Generované HTML neupravujte ručně.

## Uspořádání

- `index.qmd`: úvod pro studenty.
- `quarto/kapitola_01.qmd`: od psychologické otázky k datům, včetně závěrečných cvičení.
- `quarto/kapitola_02.qmd`: četnosti, tabulky a grafy, Excel a deset cvičení.
- `quarto/kapitola_03.qmd`: poloha a variabilita, robustní shrnutí, modelový popis, Excel, dvanáct základních a dvě nepovinná cvičení.
- `data/kapitola_02.csv` a `.xlsx`: pevná modelová data a studentský sešit s výpočty a grafy.
- `data/kapitola_03.csv` a `.xlsx`: malé autorské příklady a sešit s komentovanými mezivýpočty, souhrnem původních dat a nepovinnými rozšířeními.
- `scripts/`: tvorba grafů, sešitu a názorných excelových ilustrací.
- `quarto/literatura.qmd`: společná automaticky generovaná bibliografie celé knihy.
- `quarto/slovnicek.qmd`: české a anglické pojmy s odkazy na výklad.
- `quarto/znaceni.qmd`: přehled matematického a statistického značení a vzorců.
- `quarto/excel.qmd`: přehled užitečných funkcí Excelu.
- `_quarto.yml`: pořadí kapitol a společné nastavení knihy.
- `assets/`: společné styly a ovládání přehledových tabulek.
- `references.bib`: bibliografické údaje citovaných zdrojů.
- `quarto/_verification/`: kontrolní skripty.
- `quarto/README.md`: autorská dokumentace, odborné zdroje, rozhodnutí a záznamy ověření.
- `.github/workflows/book.yml`: sestavení, kontrola webu a publikování na GitHub Pages.

Neveřejné autorské podklady ve složce `sources/` nejsou součástí repozitáře ani webu a nejsou potřebné pro čtení, cvičení nebo sestavení knihy. Generované výstupy a dočasné pracovní soubory se do Gitu neukládají.

Novou kapitolu přidejte jako `.qmd` do `quarto/` a zařaďte ji do části **Výkladové kapitoly** v `book.chapters` souboru `_quarto.yml`. Bibliografii udržujte jen ve společné kapitole `quarto/literatura.qmd`; v ostatních kapitolách používejte citační zápis Quarta. Přehledy doplňujte současně s kapitolou. Před psaním dohodněte obsah, terminologii a značení podle [projektových instrukcí](AGENTS.md).

## Kontroly a GitHub

Po změně společného vzhledu nebo navigace vykreslete celou knihu. Pro automatickou kontrolu HTML potřebujete Node.js, Playwright a Chromium. Závislosti nainstalujte jednorázově podle potřeby:

```sh
npm install --no-save --package-lock=false playwright@1.55.0
npx playwright install chromium
```

Po renderování spusťte:

```sh
node quarto/_verification/check-html.cjs
```

Alternativně lze cestu k modulu Playwright předat proměnnou `PLAYWRIGHT_MODULE` a cestu k existujícímu prohlížeči proměnnou `CHROME_PATH`.

Kontrola prochází všechny stránky knihy: ověřuje místní odkazy, jedinečné identifikátory, pravý obsah kapitoly, rozložení stránky, skrytí a rozbalení řešení, ovládání přehledových tabulek a mobilní zobrazení. Snímky pro vizuální kontrolu ukládá do `tmp/verification/`. Na úzkých obrazovkách se pravý obsah skrývá, aby zůstal prostor pro text. Stránky bez podnadpisů samostatný obsah nepotřebují.

Po obsahové změně spusťte také příslušnou kontrolu modelových dat a číselných odpovědí (vyžaduje R, bez dalších balíčků):

```sh
Rscript --vanilla quarto/_verification/check-chapter-01.R
Rscript --vanilla quarto/_verification/check-chapter-02.R
Rscript --vanilla quarto/_verification/check-chapter-03.R
```

Ověření chování chybějících hodnot v instalovaném desktopovém Excelu pro Windows zajišťuje samostatný skript `quarto/_verification/check-excel.ps1`. Sešit druhé kapitoly ověřuje `quarto/_verification/check-chapter-02-excel.ps1` v samostatné skryté instanci Excelu. Kontroluje české vzorce, přesnost výsledků, všech 180 vstupních buněk a přepočet grafů při změně dat; změny z kontrol neukládá. Rozsah a výsledky provedených kontrol jsou v [autorské dokumentaci](quarto/README.md). Automatické kontroly nenahrazují odbornou revizi textu a vizuální prohlídku webu.

Třetí kapitolu ověřuje `check-chapter-03-excel.ps1` stejným způsobem: české vzorce, původní vstupy a chybění, oba výpočty rozptylu, MAD, entropii, momentové koeficienty a přepočet při změně vstupu. Její R kontrola navíc porovnává simulaci korekce rozptylu s přesným výčtem všech výběrů velikosti pět z použité modelové populace.

Všechny kapitoly používají společnou sadu záznamů `references.bib` i pro rozlišení stejně datovaných zdrojů téhož autora. Nastavení `nocite: '@*'` sjednocuje písmena za rokem mezi kapitolami, citačními náhledy a společnou literaturou. Do bibliografie proto ukládejte jen zdroje skutečně použité v knize; webová kontrola ověřuje shodu záznamů.

Změny připravujte v tematické větvi `codex/` a předložte je prostřednictvím pull requestu. Sloučení do `main` provádí autor projektu.

## Obnova podkladů druhé a třetí kapitoly

Grafy se obnovují při každém renderování. Samostatně je lze vytvořit příkazem `Rscript --vanilla scripts/render-figures.R`. Názorné rekonstrukce listů jsou editovatelné SVG; obnovuje je `python scripts/kapitola_02-ukazky.py` (standardní knihovna Pythonu).

Studentský sešit je uložen v repozitáři a při renderování se nepřepočítává. Jeho obnova vyžaduje Node.js s dostupným `@oai/artifact-tool` a následnou kontrolu v desktopovém Excelu:

```sh
node scripts/kapitola_02-sešit.mjs
powershell -NoProfile -ExecutionPolicy Bypass -File quarto/_verification/check-chapter-02-excel.ps1 -Finalize
```

Při použití přibaleného runtime lze cestu k vstupnímu modulu `@oai/artifact-tool` předat proměnnou `ARTIFACT_TOOL_MODULE`; jinak se použije obvyklé vyhledání modulu v Node.js. První krok vytvoří data, vzorce, formátování a grafy. Druhý nastaví nulovou mezeru histogramu a začátky os, ověří skutečný přepočet a uloží sešit. Bez `-Finalize` tentýž skript pouze ověřuje existující výsledek. Při změně CSV obnovte také sešit, ilustrace a knihu a ověřte navazující výklad. Pomocné náhledy a kontrolní výpisy vznikají pouze v ignorované složce `tmp/`.

Sešit třetí kapitoly se obnovuje obdobně:

```sh
node scripts/kapitola_03-sešit.mjs
powershell -NoProfile -ExecutionPolicy Bypass -File quarto/_verification/check-chapter-03-excel.ps1 -Finalize
```

Závěrečný krok v Excelu normalizuje zápis novějších funkcí v exportu, ověří české vzorce a uloží přepočtené hodnoty. Samotný export prvním příkazem není hotový ověřený sešit. Grafy třetí kapitoly vznikají v základním R; simulace používá pevný seed 20261005 a nevyžaduje instalaci balíčků.

## Publikování na GitHub Pages

Workflow **Ověřit a publikovat učebnici** v `.github/workflows/book.yml` při pull requestu sestaví celou knihu a spustí kontrolu HTML. Po změně `main` navíc publikuje ověřený obsah `_book/` na GitHub Pages. Workflow také vytváří grafy v R a spouští číselné kontroly druhé a třetí kapitoly. Desktopový Excel vyžaduje místní Windows a v CI se nespouští. Neúspěšné sestavení nebo kontrola HTML zabrání publikování.

Při prvním zprovoznění:

1. V repozitáři na GitHubu otevřete **Settings → Pages**.
2. V části **Build and deployment → Source** vyberte **GitHub Actions**. Projekt již vlastní workflow obsahuje.
3. Slučte připravený pull request do `main`.
4. Na kartě **Actions** zkontrolujte úspěšné dokončení sestavení i publikování.

Pokud jste Pages zapnuli až po sloučení, spusťte **Actions → Ověřit a publikovat učebnici → Run workflow** pro větev `main`. Ruční běh na jiné větvi web nepublikuje. Není potřeba větev `gh-pages` ani ukládání generovaného HTML do zdrojové větve.

Po nasazení ověřte [veřejnou učebnici](https://reckak.github.io/statistics-for-psychology/), přechody mezi kapitolami a načtení podpůrných souborů. Lokální render ani úspěšná kontrola pull requestu samy nepotvrzují zveřejnění změn.
