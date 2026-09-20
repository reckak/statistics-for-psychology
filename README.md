# Základy statistiky pro psychology 1

Česká učebnice pro jednosemestrální kurz statistiky ve druhém ročníku bakalářského studia psychologie. Předpokládá matematiku na úrovni základní školy a nevyžaduje znalost R ani programování. Výklad propojuje statistické uvažování s psychologickými příklady, komentovanými postupy a cvičeními se sbaleným řešením.

**[Otevřít webovou učebnici](https://reckak.github.io/statistics-for-psychology/)**

Projekt používá [Quarto Book](https://quarto.org/docs/books/). Aktuálně obsahuje úvod, kapitolu **Od psychologické otázky k datům** a tři průběžně doplňované přehledy: slovníček pojmů, značení a vzorce a funkce Excelu. Přehledy značení a funkcí zatím čekají na zavedení příslušné látky.

## Práce s projektem

Pro sestavení webu potřebujete Quarto; projekt je ověřován s verzí **1.9.38**. V RStudiu otevřete kořenovou složku projektu. R slouží k interním kontrolám výpočtů, jeho kód se studentům nezobrazuje. Současná podoba knihy při renderování R nevyžaduje.

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

Novou kapitolu přidejte jako `.qmd` do `quarto/` a zařaďte ji do `book.chapters` v `_quarto.yml` před tři závěrečné přehledy. Přehledy doplňujte současně s kapitolou. Před psaním dohodněte obsah, terminologii a značení podle [projektových instrukcí](AGENTS.md).

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

Po obsahové změně první kapitoly spusťte také kontrolu jejích modelových dat a vybraných odpovědí (vyžaduje R, bez dalších balíčků):

```sh
Rscript --vanilla quarto/_verification/check-chapter-01.R
```

Ověření chování chybějících hodnot v instalovaném desktopovém Excelu pro Windows zajišťuje samostatný skript `quarto/_verification/check-excel.ps1`. Rozsah a výsledky provedených kontrol jsou v [autorské dokumentaci](quarto/README.md). Automatické kontroly nenahrazují odbornou revizi textu a vizuální prohlídku webu.

Změny připravujte v tematické větvi `codex/` a předložte je prostřednictvím pull requestu. Sloučení do `main` provádí autor projektu.

## Publikování na GitHub Pages

Workflow **Ověřit a publikovat učebnici** v `.github/workflows/book.yml` při pull requestu sestaví celou knihu a spustí kontrolu HTML. Po změně `main` navíc publikuje ověřený obsah `_book/` na GitHub Pages. Kontroly R a desktopového Excelu se v tomto workflow nespouštějí. Neúspěšné sestavení nebo kontrola HTML zabrání publikování.

Při prvním zprovoznění:

1. V repozitáři na GitHubu otevřete **Settings → Pages**.
2. V části **Build and deployment → Source** vyberte **GitHub Actions**. Projekt již vlastní workflow obsahuje.
3. Slučte připravený pull request do `main`.
4. Na kartě **Actions** zkontrolujte úspěšné dokončení sestavení i publikování.

Pokud jste Pages zapnuli až po sloučení, spusťte **Actions → Ověřit a publikovat učebnici → Run workflow** pro větev `main`. Ruční běh na jiné větvi web nepublikuje. Není potřeba větev `gh-pages` ani ukládání generovaného HTML do zdrojové větve.

Po nasazení ověřte [veřejnou učebnici](https://reckak.github.io/statistics-for-psychology/), přechody mezi kapitolami a načtení podpůrných souborů. Lokální render ani úspěšná kontrola pull requestu samy nepotvrzují zveřejnění změn.
