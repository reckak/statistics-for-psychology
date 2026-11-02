# Údržba podkladů pluginu

Tento návod je určen autorovi. Aktuální kapitoly a tři přehledy se exportují
z hlavních zdrojů učebnice, nikoli ručním přepisováním souborů v instalaci.
Verze 0.2.0 přibaluje kapitoly 1–6 a celé aktuální přehledy včetně hesel
z kapitol 7–8. Úplné kapitoly 7–8 v této verzi nejsou.

## Aktualizace

1. Aktualizuj hlavní zdroj učebnice a jeho kontroly. Při změně rozsahu uprav
   také export a instrukce tutora; nepovažuj existenci hesla za dostupnou kapitolu.
2. Zvyš verzi v obou manifestech zdroje pluginu. Zachovej název, logo,
   výchozí prompty, vazby a aktuální oprávnění.
3. Sestav a ověř instalační archiv podle
   [provozního návodu](https://github.com/reckak/statistics-for-psychology/blob/main/docs/PROVOZ.md#export-ai-tutora).
   Registr, index, otisky, literatura a kopie obrázků vznikají automaticky.
4. Ověř aktuální verzi a identitu existujícího cloudového pluginu, pak
   použij „Nahrát novou verzi“. Pokud je dostupný Plugin Creator update_plugin,
   načti aktuální zdroje a použij ověřené ID i expected_release_id.
5. Ověř uloženou verzi a skutečné čtení souborů v novém chatu bez příloh.
   Zkontroluj i příklady, matematiku, odkazy a hranici přehled/výklad 7–8.

Přibalené soubory jsou verzovaný snímek. Změna webu se do již uloženého
pluginu nepropíše sama; vyžaduje nový export a aktualizaci.

## Použití a distribuce

Student nainstaluje plugin, vybere jej v novém chatu a uvede téma a režim.
Nahrávání kapitol 1–6 a přehledů není potřeba. Další vlastní zadání může přiložit.

Soukromý plugin sdílej až po ověření dostupných oprávnění a pilotu na účtu
studenta. Ve školním workspace jsou sdílení, publikování do adresáře a instalace
oddělené kroky. Dostupnost mezi osobními účty a limity bezplatných účtů ověř
v aktuálním prostředí; neslibuj je podle samotného odkazu nebo tarifu.

Tento plugin nemá vlastní databázi ani společný záznam výkonu studentů;
soukromí chatu se řídí prostředím ChatGPT a nastavením organizace.
Oficiální postup: [Build plugins](https://learn.chatgpt.com/docs/build-plugins).
