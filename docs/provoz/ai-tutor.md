# Export a vydání AI tutora

[Zpět na provozní návody](../PROVOZ.md)

Příkazy spouštějte z kořene repozitáře.

<a id="export-ai-tutora"></a>

## Export kapitol a přehledů pro AI tutora

Pravidla tvorby, vydání a ověřování určuje [AITUTORS.md](../AITUTORS.md); zde jsou
příkazy, závislosti a popis výstupů. Zdroj pluginu je v
`plugins/statistika-pro-psychology-ai-tutor/`: obsahuje instrukce, metadata
a logo, nikoli ručně udržované kopie kapitol. Úplné balíčky sestavíte z kořene
projektu:

```powershell
node scripts/export-tutor.cjs
```

### Co export přibaluje

- **Všechny výkladové kapitoly knihy** podle `_quarto.yml` (nyní 1–10) včetně
  nepovinných částí, zadání a řešení, úvod, citovanou literaturu a celé tři
  přehledy. Další kapitola se přibalí sama; potřebuje kapitolovou kartu,
  skript `scripts/kapitola_NN.R` a údaj o počtu řešení v `check-tutor.cjs`.
- **Výukový plán každé kapitoly** (`scripts/tutor/plans.cjs`): hloubku výkladu,
  návaznosti a procvičení přebírá z kapitolové karty, cíle a strukturu z textu,
  rejstřík pojmů z přehledů. Uvádí **rozsahy řádků** oddílů a jejich úvodů,
  zvlášť zadání a řešení každého cvičení, nepovinných bloků a hesel přehledů,
  u oddílu jeho obrázky (s rozsahem řádků v rejstříku a údaji „s daty od
  řádku N“ nebo „schéma bez dat“ a „v nepovinné části“) a název a úplnou adresu interaktivní stránky, na
  kterou oddíl odkazuje. Plány se ručně neupravují.
- **Obrázky podle platformy.** Pracovní složka pluginu obsahuje původní
  SVG obrázky kapitol beze změny a slouží jako základ variant; archiv pro
  ChatGPT z ní vzniká bez složky obrázků, s textovými kapitolami a rejstříky
  shodnými s variantou pro Gemini a se zněním `SKILL.md` bez souborů
  (`textSkill` v `scripts/tutor/common.cjs`). Pro Claude export převede tatáž SVG na PNG
  (`scripts/tutor/svg-to-png.cjs`, Chromium z Playwrightu, 1,5násobek velikosti
  SVG) a přepíše přípony v kapitolách a rejstřících; Gemini soubory obrázků
  nemá. Web knihy zůstává u SVG. Text v SVG z R je uložen jako křivky.
- **Rejstřík obrázků každé kapitoly** `references/obrazky/kapitola_NN.md`:
  číslo, popisek, textový popis (`fig-alt` kapitoly), místo v kapitole, soubor
  obrázku a dvě webové adresy jako prostý text (stránka s kotvou a samotný obrázek).
  Ve variantě pro Gemini je místo adresy samotného obrázku řádek „Zobrazení“
  a kapitola místo odkazu na web odkazuje na záznam v rejstříku; počet řádků
  rejstříku se neliší, takže rozsahy v plánech platí pro všechny varianty.
- **Data pro překreslení** u kapitol uvedených ve `figureDataChapters`
  (`scripts/tutor/common.cjs`, od 0.4.1 všechny kapitoly): viz [níže](#data-ke-grafum-tutora).
- **Malý registr `KAPITOLY.json`** (schéma 3) s verzí, revizí a seznamem
  kapitol. Katalogem pro nabídku kapitol je `INDEX.md`. Nadpisy, pojmy, rozsahy
  a otisky pro kontrolu jsou v `kontrola.json` vedle rozbalených balíčků, mimo
  archivy.

Zdrojový `SKILL.md` obsahuje značku `tutor:chapter-menu`, kterou export nahradí
nabídkou kapitol; instalujte hotový archiv, nikoli zdrojovou složku. Odkazy na
přibalené materiály jsou místní, na sešity a interaktivní stránky vedou na web.

### Závislosti a průběh

Potřebujete Node.js 18 nebo novější s balíčkem Playwright a jeho Chromiem
(tytéž jako pro kontroly webu), Quarto s Pandocem 3.x, R se závislostmi
generátorů obrázků a Windows PowerShell s .NET kompresí. Ověřené místní verze:
Node.js 24.21.0, Quarto 1.9.38 / Pandoc 3.8.3 a R 4.5.1. Jiné cesty k programům
předáte parametry `--quarto` a `--rscript`. Žádné balíčky se během exportu
neinstalují. Export znovu vytvoří obrázky všech přibalených kapitol a data ke
grafům; přepínač `--skip-figures` použijte jen při opakovaném sestavení se
stejnými, již vytvořenými obrázky a daty.

Převod pracuje s dokumentovou strukturou Pandocu, zachovává vzorce v LaTeXu,
ID oddílů a údaje tabulek. HTML řádky přehledů převádí na samostatná hesla
s pojmenovanými poli. Citace vznikají jedním společným průchodem citeproc
s APA stylem; přibalený seznam literatury ponechá jen citované položky.

Sestavení vzniká v nové složce `tmp/tutor-export-*`. Po úspěšném exportu skript
smaže starší složky a ponechá tu, na kterou odkazuje `ai-tutor/overeni.json`.
Před nahrazením archivů proběhne `scripts/check-tutor.cjs` a nezávislé načtení
všech souborů ZIPu pomocí .NET. Samostatné opakování kontroly posledního exportu:

```powershell
node scripts/check-tutor.cjs
```

Kontrola mimo jiné ověřuje věrnost převodu každého odstavce, vzorce a tabulky,
začátek i konec každého rozsahu řádků, oddělení zadání od řešení, shodu SVG
v pluginu se zdrojem, jedno platné PNG ke každému obrázku ve variantě pro
Claude, shodu rejstříků a bloků dat s exportovanými daty, strukturu dat podle
značek a jejich rozsah (nejvýše 800 řádků na obrázek, 300 kB na rejstřík), přítomnost každé interaktivní stránky knihy ve
`VIZUALIZACE.md` a rozdíly variant proti společnému zdroji. Dne 2026-11-20 se
při jednom z běhů v exportované kapitole 8 tiše ztratila část odstavce; kontrola
věrnosti běh zastavila a chyba se v dalších bězích neopakovala. Dne 2026-11-21
se totéž stalo znovu, opět v kapitole 8 (ztracený vzorec); opakovaný export
prošel. Příčina známa
není: při hlášení „paragraph/cell lost or changed“ nejprve spusťte export znovu.

### Výstupy

- `ai-tutor/chatgpt/statistika-tutor-chatGPT-<verze>.zip` – plugin pro ChatGPT;
- `ai-tutor/claude/statistika-tutor-claude-<verze>.zip` – týž skill pro Claude,
  v kořeni jediná složka `statistika-tutor/`;
- `ai-tutor/gemini/statistika-tutor-gemini-<verze>.zip` – skill pro Gemini:
  `SKILL.md` a `references/` přímo v kořeni archivu, jen soubory `.md` a `.txt`,
  bez souborů obrázků;
- `ai-tutor/overeni.json` – verze zdroje, otisky vstupů a všech členů tří
  archivů, počty obsahu a cesty k rozbaleným podobám.

Složka `ai-tutor/` je ignorovaná Gitem. Archiv pro Claude se od pluginu liší jen
hlavičkou `SKILL.md` (YAML místo JSON) a chybějícími manifesty a logem. Varianta
pro Gemini vzniká z varianty pro Claude: odstraní `references/assets/`, v kapitolách
nahradí řádek obrázku odkazem na obrázek ve webové učebnici, v rejstřících vynechá
odkaz na soubor, přejmenuje `KAPITOLY.json` na `KAPITOLY.txt` a `LICENSE` na
`LICENSE.txt` (dialog nahrání uvádí jen typy CSV, PY, TXT a MD) a v `SKILL.md`
nahradí seznam možností zobrazení obrázku zněním bez přibalených souborů
(`geminiNote` v `scripts/tutor/common.cjs`). Kontrola hlídá nejvýše 100
souborů jako projektovou pojistku; doložený limit počtu souborů neznáme.

Nahrání: Claude – Customize → Skills → + → Upload a skill (vyžaduje zapnuté
spouštění kódu); Gemini – Přizpůsobit → Dovednosti → Vytvořit → Nahrát;
ChatGPT – u existujícího pluginu **Další akce → Nahrát novou verzi**, nikoli
přidání dalšího pluginu. Po nahrání ověřte verzi a čtení materiálů v novém chatu
bez příloh podle [testovací sady](../../scripts/tutor/smoke-prompts.md). Gemini
může při nahrání ohlásit chybu, i když se dovednost uložila: ověřte stav
v seznamu dovedností. Kontrola archivu nepotvrzuje, že klient soubory načte.

<a id="data-ke-grafum-tutora"></a>

### Data ke grafům pro tutora

Aby tutor mohl obrázek učebnice nakreslit znovu přímo v odpovědi, zapisuje
skript kapitoly ke každému obrázku popis a vykreslené hodnoty. Hlavním místem
těchto dat je skript kapitoly; rejstřík v balíčku je odvozený výstup.

- Pomocník `scripts/tutor/figure-data.R` (jen base R): `tf_figure()` zapíše
  `tmp/tutor-figures/<kapitola>/<obrázek>.json` s druhem obrázku (`data`,
  `simulace`, `krivka`, `sloupce`, `schema`), panely (`tf_panel()`: titulek, typ
  grafu, osy, vodicí čáry `tf_guide()` a vybarvená pásma `tf_band()`) a řadami
  (`tf_series()`: hodnoty tak, jak jsou vykresleny; `tf_bins()` pro histogram
  v četnostech, hustotě nebo podílech; `tf_curve()` pro křivku danou funkcí).
  Značky řad: `body`, `sloupce` (i skupinové a skládané), `histogram`, `cara`,
  `plocha`, `interval`, `usecky`, `krabice` a `tabulka`; místo číselné polohy
  lze uvést textový sloupec `kategorie`. Schéma bez dat zapíše `tf_schema()`.
  Význam značek pro tutora popisuje `references/VIZUALIZACE.md` v balíčku;
  při změně slovníku upravte obojí a kontrolu (`markColumns` v `common.cjs`).
- Rozsah: křivky zhruba 41–81 bodů, simulace jako intervaly histogramu, husté
  čáry a velká mračna bodů proředit a uvést to v poznámce.
- Volání patří hned za kreslicí blok obrázku a používá tytéž objekty. Hodnoty
  vznikající až při kreslení (jitter, losování uvnitř bloku) nejprve uložte do
  pojmenovaného objektu, aby data i obrázek vycházely z téhož.
- Po úpravě skriptu ověřte, že se obrázky nezměnily, a spusťte

  ```powershell
  node scripts/tutor/check-figure-data.cjs kapitola_10
  node scripts/tutor/render-figure-data.cjs kapitola_10
  ```

  První skript ověří, že každý obrázek kapitoly má záznam a že záznamy
  odpovídají slovníku značek a limitu řádků. Druhý vykreslí každý záznam obecným kreslítkem vedle originálu do
  `tmp/tutor-figures-check/`. Dokládá, že data k překreslení stačí; nedokládá,
  jak věrně kreslí tutor v klientu.
- Novou kapitolu přidáte doplněním volání do jejího skriptu a jejího ID do
  `figureDataChapters`; kontrola pak vyžaduje záznam u každého jejího obrázku,
  i u statického SVG, které R nekreslí (`tf_schema()`).

Generované kapitoly a archivy se necommitují. Při změně zdrojů proveďte nový
export; nahraný tutor je verzovaný snímek a s webem se nesynchronizuje. Běžné
sestavení webu export ani nahrání nespouští. Při vydání zvyšte verzi v obou
manifestech zdroje pluginu.

<a id="vydani-ai-tutora-na-githubu"></a>

### Vydání na GitHubu

Studenti stahují tutora z vydání `tutor-v<verze>` na GitHubu, na které vedou
odkazy `releases/latest/download/…` ze stránky
[AI tutor: stažení a instalace](../../quarto/ai_tutor.qmd). Pravidla stanoví
[AITUTORS.md](../AITUTORS.md#verze-a-vydání). Postup:

1. Zvyšte verzi v obou manifestech, commitněte všechny vstupy exportu
   a odešlete je na GitHub.
2. Spusťte `node scripts/export-tutor.cjs` z tohoto stavu; v `ai-tutor/overeni.json`
   musí být `"source_dirty": false`.
3. Suchý běh vypíše, co se nahraje, a připraví soubory do `tmp/tutor-release-<verze>/`:

   ```powershell
   node scripts/release-tutor.cjs
   ```

   Skript odmítne export z necommitovaných zdrojů, revizi, která není na
   GitHubu, existující štítek, neshodu verze s manifestem a archivy, jejichž
   SHA-256 se liší od `overeni.json`; pak spustí `check-tutor.cjs`.
   Archivy zkopíruje pod stálé názvy bez verze a vytvoří české poznámky
   k vydání.
4. Koncept vydání (potřebuje přihlášené `gh`):

   ```powershell
   node scripts/release-tutor.cjs --draft
   ```

5. Autor koncept na GitHubu zkontroluje a zveřejní. Po zveřejnění ověřte,
   že tři odkazy `releases/latest/download/` stahují soubory se shodným SHA-256.
6. Teprve potom nahrajte novou verzi do cloudového pluginu ChatGPT podle
   odstavce výše. Stránka učebnice se při nové verzi nemění, pokud se
   nezměnil postup instalace nebo rozsah tutora.

Přepínač `--report <soubor>` slouží jen k vyzkoušení pojistek nad upravenou
kopií `overeni.json`; s `--draft` jej nelze použít.

Registr `KAPITOLY.json` má od 0.3.0 `schema_version: 2`: `chapters` obsahuje
všechny kapitoly knihy, nyní deset (`number`, `availability`, `web_url`, `plan`), přibalené
záznamy mají místní `path` a otisk, nepřibalené mají `path` a `plan` rovné
`null`. Pole `plans` obsahuje šest plánů s otisky a vazbou na zdrojové karty.
Skript čtoucí plné texty musí filtrovat `availability: bundled`.
