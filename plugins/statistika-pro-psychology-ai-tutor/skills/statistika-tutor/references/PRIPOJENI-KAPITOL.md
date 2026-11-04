# Údržba podkladů pluginu

Tento návod je určen autorovi. Aktuální kapitoly a tři přehledy se exportují
z hlavních zdrojů učebnice, nikoli ručním přepisováním souborů v instalaci.
Plugin přibaluje kapitoly 1–6 a celé aktuální přehledy včetně hesel
z kapitol 7–8. Úplné kapitoly 7–8 v této verzi nejsou.

## Aktualizace

1. Aktualizuj hlavní zdroj učebnice a jeho kontroly. Při změně rozsahu uprav
   také kapitolovou kartu, export a instrukce tutora. Dostupnost plného textu ověřuj samostatně od existence hesla.
2. Zvyš verzi v obou manifestech zdroje pluginu. Zachovej název, logo,
   výchozí prompty, vazby a aktuální oprávnění.
3. Sestav a ověř instalační archiv podle
   [provozního návodu](https://github.com/reckak/statistics-for-psychology/blob/main/docs/PROVOZ.md#export-ai-tutora).
   Registr osmi kapitol, index, šest výukových plánů, nabídka v hlavním skillu, otisky, literatura a kopie obrázků vznikají automaticky. Plány čerpají hloubku učiva a dovednosti z kapitolových karet a cíle, lokátory i nepovinné části z textu. Přehledy dodávají úplný rejstřík navázaných pojmů, značení a funkcí.
4. Ověř aktuální verzi a identitu existujícího cloudového pluginu, pak
   použij „Nahrát novou verzi“. Pokud je dostupný Plugin Creator update_plugin,
   načti aktuální zdroje a použij ověřené ID i expected_release_id.
5. Ověř uloženou verzi a skutečné čtení souborů v novém chatu bez příloh.
   Zkontroluj i příklady, matematiku, odkazy, dlouhý rozhovor podle plánu, volbu rozšíření, opětovné využití grafu, krajní parametry a výšku panelu. Odliš test kandidátní přílohy od skutečné instalace.

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
soukromí chatu se řídí prostředím klienta a nastavením organizace.
Oficiální postup pro ChatGPT: [Build plugins](https://learn.chatgpt.com/docs/build-plugins).

## Verze pro Claude

Tentýž export vytváří také samostatný ZIP skillu pro Claude se stejným
SKILL.md a stejnými podklady, bez manifestů pluginu a loga. Student jej
nahraje v claude.ai přes Customize → Skills → + → Upload a skill; musí mít
zapnuté spouštění kódu. Mimo plány Team a Enterprise nahrává každý student
ZIP sám a novou verzi musí nahrát znovu. Dostupnost v tarifech a limity
nahrávání ověř v aktuálním prostředí. Oficiální postup:
[Using skills in Claude](https://support.claude.com/en/articles/12512180-using-skills-in-claude).
