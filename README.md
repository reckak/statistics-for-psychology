# Základy statistiky pro psychology 1

Česká webová učebnice v Quarto Book. Autorská pravidla jsou v `AGENTS.md`.

## Práce s knihou

Nainstalujte Quarto (ověřovaná verze je uvedena v autorské dokumentaci).
Z kořene projektu spusťte `quarto render`; web vznikne v `_book/`.
Pro průběžný náhled slouží `quarto preview`.

Na tomto počítači je Quarto také v RStudiu:
`C:/Program Files/RStudio/resources/app/bin/quarto/bin/quarto.exe`.

Zdrojové kapitoly jsou v `quarto/`, navigace v `_quarto.yml`, společný vzhled
a přehledové tabulky v `assets/`. Podrobnosti o zdrojích a kontrolách patří
do `quarto/README.md`. Původní učebnice v `sources/` zůstávají neveřejné.
Generované HTML, pomocné soubory a původní učebnice nepatří do Gitu.

## Kontrola a publikování

Po renderu spusťte `node quarto/_verification/check-html.cjs`.
Kontrola potřebuje Playwright a prohlížeč Chromium; cestu k modulu lze
nastavit přes `PLAYWRIGHT_MODULE`, cestu k prohlížeči přes `CHROME_PATH`.
Výchozí modul je `playwright`; bez `CHROME_PATH` se použije jeho Chromium.

Workflow na GitHubu ověří render a odkazy v PR. Po uživatelském sloučení
do `main` publikuje `_book/` na GitHub Pages. V nastavení repozitáře
**Settings → Pages → Source** musí být vybráno **GitHub Actions**.
Živá publikace se ověřuje až po sloučení; pracovní větve web nepřepisují.
