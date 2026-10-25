# Základy statistiky pro psychology 1

Česká učebnice pro jednosemestrální kurz statistiky ve druhém ročníku
bakalářského studia psychologie. Předpokládá matematiku na úrovni základní
školy a nevyžaduje znalost R ani programování. Výklad propojuje statistické
uvažování s psychologickými příklady a cvičeními se sbaleným řešením.

**[Otevřít webovou učebnici](https://reckak.github.io/statistics-for-psychology/)**

Kniha obsahuje šest výkladových kapitol, společnou literaturu a tři
průběžně doplňované přehledy: slovníček, značení a vzorce a funkce Excelu.
Každá výkladová kapitola má jeden excelový sešit se vstupy k příkladům
a cvičením. Podrobný obsah a návaznosti zachycuje [mapa knihy](docs/OSNOVA.md),
pokrytí daty [přehled sešitů](docs/DATA.md).

## Práce s projektem

Projekt používá [Quarto Book](https://quarto.org/docs/books/). Pro sestavení
webu potřebujete Quarto a R dostupné jako `Rscript`; ověřené verze jsou
Quarto 1.9.38 a R 4.5.1. Další balíčky R nejsou potřeba. R vytváří grafy
a slouží k interním kontrolám; jeho kód se studentům nezobrazuje.

Otevřete kořenovou složku projektu (například v RStudiu). Pro náhled
s průběžným obnovováním spusťte:

```sh
quarto preview
```

Celou knihu sestavíte příkazem:

```sh
quarto render
```

Výstup je v `_book/`, vstupní stránka v `_book/index.html`. Při přenosu
zachovejte celou složku včetně podpůrných souborů. Generované HTML neupravujte
ručně. Podrobné postupy a další závislosti jsou v [provozním návodu](docs/PROVOZ.md).

## Uspořádání

| Umístění | Účel |
|---|---|
| `index.qmd`, `quarto/` | Úvod, výkladové kapitoly, literatura a studentské přehledy. |
| `data/` | Studentské sešity `kapitola_NN.xlsx`; CSV slouží pouze interně a do webu se nekopírují. |
| `scripts/`, `quarto/_verification/` | Generátory a kontrolní skripty. |
| `_quarto.yml`, `assets/`, `references.bib` | Konfigurace knihy, vzhled a bibliografické údaje. |
| `docs/`, `AGENTS.md` | Autorská dokumentace a pravidla práce. |
| `.github/workflows/book.yml` | Automatické sestavení, kontroly a publikování. |

Neveřejné podklady v `sources/` nejsou součástí repozitáře ani webu
a nejsou potřeba pro čtení, cvičení nebo sestavení knihy. Generované
výstupy a dočasné soubory se do Gitu neukládají.

## Dokumentace pro autory

| Dokument | Kdy jej použít |
|---|---|
| [AGENTS.md](AGENTS.md) | Pravidla tvorby, revizí, ověřování a práce s Gitem. |
| [PROVOZ.md](docs/PROVOZ.md) | Příkazy, závislosti, sestavení, kontroly a publikování. |
| [OSNOVA.md](docs/OSNOVA.md) | Obsah a návaznosti; karty kapitol a oddělený plán pokračování. |
| [DATA.md](docs/DATA.md) | Pokrytí příkladů a cvičení datovými sešity. |
| [SLOVNIK.md](docs/SLOVNIK.md) | Platné termíny, alternativy a významové hranice. |
| [ZDROJE.md](docs/ZDROJE.md) | Podklady, přesné lokátory a rozsah jejich ověření; odkazy do `sources/` jsou místní. |
| [ROZHODNUTI.md](docs/ROZHODNUTI.md) | Schválené volby, platnost a odkazy na doklady. |
| [PREZENTACE.md](docs/PREZENTACE.md) | Pravidla prezentací, poznámek a doprovodných cvičení. |
| [Autorská historie](quarto/README.md) | Provedené změny, výsledky kontrol a jejich omezení. |

## Provozní návody

- <a id="ruční-pdf-vybrané-kapitoly"></a>[Pracovní PDF kapitoly](docs/PROVOZ.md#ruční-pdf-vybrané-kapitoly) — pouze na vyžádání; ověřen export kapitoly 3.
- <a id="kontroly-a-github"></a>[Kontroly dokumentace, webu a výpočtů](docs/PROVOZ.md#kontroly-a-github).
- <a id="obnova-sešitů-a-podkladů-kapitol-16"></a>[Obnova sešitů](docs/PROVOZ.md#obnova-sešitů-a-podkladů-kapitol-17) — vyžaduje místní český desktopový Excel pro Windows.
- <a id="zdroje-a-průběh-sestavení"></a>[Generátory a průběh sestavení](docs/PROVOZ.md#zdroje-a-průběh-sestavení).
- <a id="ověření-obsahu-a-vzhledu"></a>[Kontrola dat a náhledy sešitů](docs/PROVOZ.md#ověření-obsahu-a-vzhledu).
- <a id="publikování-na-github-pages"></a>[Publikování na GitHub Pages](docs/PROVOZ.md#publikování-na-github-pages).

Změny se předkládají prostřednictvím PR z tematické větve `codex/`.
Sloučení do `main` provádí autor projektu.

## Licence

© 2026 Karel Rečka. Obsah a kód mají odlišné licence:

| Část | Licence |
|---|---|
| Text učebnice (`index.qmd`, kapitoly a přehledy v `quarto/`), vlastní obrázky a grafy, datové sešity v `data/`, prezentace, poznámky a cvičení v `presentations/`, bibliografické údaje a autorská dokumentace | [Creative Commons Uveďte původ 4.0 Mezinárodní (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/deed.cs), úplné znění v [LICENSE](LICENSE) |
| Zdrojový kód: skripty v `scripts/` a `quarto/_verification/`, filtry v `filters/`, konfigurace (`_quarto.yml`, `.github/`), styly a skripty webu v `assets/` | [MIT](LICENSE-CODE) |

Při dalším použití obsahu uveďte autora, název učebnice, odkaz na
[webovou učebnici](https://reckak.github.io/statistics-for-psychology/),
odkaz na licenci CC BY 4.0 a informaci, zda jste materiál upravili.

Licence se nevztahují na materiály třetích stran, které mají v knize
nebo v souboru uvedeného jiného autora a vlastní licenci. Jde zejména o:

- `styles/apa.csl` — citační styl APA 7 z repozitáře Citation Style
  Language (B. M. Wiernik, A. Dunning a další), licence
  [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/);
- `assets/chapter-03/plots/mode-median-mean.svg` — obrázek od CMG Lee
  (Cmglee) z Wikimedia Commons, licence
  [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/);
- citované práce a upravené příklady z literatury, jejichž práva zůstávají
  jejich autorům a vydavatelům; licence CC BY 4.0 se týká pouze vlastního
  zpracování.
