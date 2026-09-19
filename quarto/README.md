# Autorská dokumentace

## Základ knihy

`_quarto.yml` vykresluje pouze `index.qmd` a studentské soubory `quarto/*.qmd`.
Adresář `sources/`, tato dokumentace a kontrolní skripty se nepublikují.
Tři závěrečné přehledy zatím mají připravenou tabulkovou strukturu;
jejich obsah přibývá s výkladovými kapitolami.

Tabulky používají malý místní skript bez externí knihovny. Vyhledávají
ve všech řádcích, také bez diakritiky. Odkaz na ID položky zruší filtr
a zobrazí správnou stránku. Bez JavaScriptu jsou všechny řádky dostupné.
Prázdné přehledy nemají fiktivní položky. Ovládání používá nativní
vstupy, tlačítka a výběrové pole, stav má atribut `aria-live`.

Před publikací je nutné zkontrolovat nejen render, ale i klávesnici,
mobilní zobrazení, skrytí řešení a odkazy přes filtr/stránkování.

## Ověření

Použito Quarto 1.9.38 z instalace RStudia, Node.js a Playwright z lokálního
balíku pracovních závislostí, prohlížeč Google Chrome.

Základ knihy: úplný render čtyř stránek úspěšný; kontrola všech místních
odkazů, jedinečných ID, ovládání prázdných tabulek a šířky 390 px prošla
bez JavaScriptových chyb. Mobilní podoba prázdného slovníčku prohlédnuta.
Základ zatím neobsahuje řešení ani matematiku; jejich ověření nebylo
předmětem této kontroly. Publikace na Pages čeká na sloučení a nastavení
zdroje GitHub Actions; živé nasazení dosud nebylo ověřeno.
