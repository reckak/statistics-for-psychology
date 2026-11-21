# AI tutoři

Tento dokument načti před prací na instrukcích, exportu, vydání nebo
testování AI tutora pro kteroukoli platformu. Platí společně
s [projektovými instrukcemi](../AGENTS.md); jejich odborná, didaktická
a terminologická pravidla platí i pro tutora. Dohodu o tomto uspořádání
dokládá [R64](rozhodnuti/ai-tutor.md#r64-pravidla-ai-tutoru).

## Hlavní místa informací

| Typ informace | Hlavní místo |
|---|---|
| Pedagogické chování tutora: zahájení, režimy, tempo výkladu, cvičení, obrázky a vizualizace, značení | [Instrukce tutora](../plugins/statistika-pro-psychology-ai-tutor/skills/statistika-tutor/SKILL.md) a jejich reference; dohody [R62](rozhodnuti/ai-tutor.md#r62-ai-tutor), [R63](rozhodnuti/ai-tutor.md#r63-plany-a-konvence-tutora) a [R85](rozhodnuti/ai-tutor.md#r85-tutor-kapitoly-obrazky-tempo). |
| Rady k interaktivním stránkám učebnice a pravidla kreslení grafů | [VIZUALIZACE.md](../plugins/statistika-pro-psychology-ai-tutor/skills/statistika-tutor/references/VIZUALIZACE.md); kontrola exportu vyžaduje záznam každé stránky `viz_*` z `_quarto.yml`. |
| Data a popis obrázku pro překreslení tutorem | Skript kapitoly `scripts/kapitola_NN.R` (volání `tf_figure()`); rejstřík v balíčku je odvozený. Postup v [provozním návodu](PROVOZ.md#data-ke-grafum-tutora). |
| Pravidla tvorby, vydání a ověřování pro všechny platformy | Tento dokument. |
| Příkazy exportu, kontroly, cesty výstupů a postupy nahrání | [Provozní návod](PROVOZ.md#export-ai-tutora). |
| Studentský návod ke stažení a instalaci na všech třech platformách | Stránka učebnice [AI tutor: stažení a instalace](../quarto/ai_tutor.qmd) (od 2026-11-14, [R79](rozhodnuti/ai-tutor.md#r79-vydani-tutora-na-githubu); nahradila `ai-tutor/navod.docx`). Aktualizuj ji při změně postupu nahrání, názvů souborů ve vydání nebo rozsahu tutora; na verzi nezávisí. |
| Testovací scénáře | [smoke-prompts.md](../scripts/tutor/smoke-prompts.md). |
| Provedené exporty, nahrání a výsledky testů | [Autorská historie](../quarto/README.md). |
| Učivo kapitol a jeho hloubka | Kapitoly a [kapitolové karty](OSNOVA.md); výukové plány tutora z nich generuje export. |

## Společná pravidla

### Jeden zdroj obsahu

- Instrukce a ručně psané reference jsou jen ve zdroji
  `plugins/statistika-pro-psychology-ai-tutor/skills/statistika-tutor/`.
  Kapitoly, plány, přehledy, index, registr, literatura a obrázky vytváří
  export ze zdrojů knihy. Neudržuj jejich ruční kopie ani samostatnou
  verzi obsahu pro jednu platformu.
- Balíčky platforem se liší jen obalem a úpravami, které export vkládá
  do kopie: hlavička SKILL.md, vynechané soubory, doplněk jedné varianty.
  Každou takovou odchylku hlídá kontrola exportu proti společnému zdroji.
- Změnu chování tutora zapisuj do sdílených instrukcí, aby platila na všech
  platformách. Doplněk jen pro jednu platformu použij, když jde o omezení
  nebo schopnost jejího klienta.
- Podrobnější popis obrázku doplňuj do `fig-alt` ve zdrojové kapitole.
  Prospěje webu i všem tutorům; samostatný ručně psaný popisný soubor nevytvářej.
- Obrázky jdou do balíčků jako PNG vykreslené z týchž SVG, která používá web;
  SVG se nepřibalují. Hodnoty pro překreslení obrázku zapisuje skript kapitoly
  z týchž objektů, ze kterých kreslí; ručně je do balíčku nedoplňuj. Data mají
  zatím jen kapitoly uvedené ve `figureDataChapters` (pilot: kapitola 10).
- Adresy na web učebnice vznikají při exportu a tutor je má opisovat doslova;
  do instrukcí nepiš adresy, které kontrola exportu neověřuje.

### Verze a vydání

- Verze v obou manifestech pluginu je společná pro všechny platformy
  a označuje obsah balíčků. Zvyš ji, když se mění obsah, který studenti
  dostanou. Nová platformní varianta ani změna generovaných metadat
  (revize zdroje, datum sestavení) verzi nemění.
- Hotové balíčky vznikají v ignorované složce `ai-tutor/` s podsložkami
  `chatgpt/`, `claude/` a `gemini/`; necommitují se.
- Studenti je stahují z veřejného vydání na GitHubu `tutor-v<verze>`
  ([R79](rozhodnuti/ai-tutor.md#r79-vydani-tutora-na-githubu)). Vydání
  obsahuje jen tři archivy pod stálými názvy `statistika-tutor-chatGPT.zip`,
  `statistika-tutor-claude.zip` a `statistika-tutor-gemini.zip`, na které
  odkazuje [stránka učebnice](../quarto/ai_tutor.qmd) přes
  `releases/latest/download/`. Bez záznamů testů a `overeni.json`.
- Vydání vzniká jen z exportu bez necommitovaných vstupů a na commitu,
  ze kterého export vznikl a který je na GitHubu. Nejprve jako koncept;
  zveřejnění je samostatný krok na výslovný pokyn autora. Zveřejněné
  vydání se nepřepisuje: oprava je nová verze.
- Nejprve sestav a zkontroluj kandidáta. Nahrání, publikování nebo sdílení
  je samostatný krok jen na výslovný pokyn autora. Novou verzi nahrávej
  na stejné místo (existující plugin či skill), nezakládej další kopii;
  zachovej identitu a přístup.
- Úspěšná kontrola archivu nedokládá, že klient soubory přijme a načte.

<a id="overovani"></a>

### Ověřování chování

- Chování tutora ověřuj v běžném konverzačním režimu, který mají studenti
  k dispozici, nikoli v agentním či programátorském režimu. Před prvním
  testovacím dotazem ověř skutečně zvolený režim.
- Běžné studium, čtení podkladů, procvičování, zkoušení a dostupné
  vizualizace mají v tomto režimu obstát. Agentní režim použij jen na
  výslovný pokyn autora; výsledek eviduj samostatně jako doplňkový test
  konkrétní schopnosti, nikoli jako doklad dostupnosti pro studenty.
- Testuj v novém chatu bez projektu, příloh a webového vyhledávání, aby
  odpověď vycházela z balíčku. Zaznamenej platformu, klienta (web, desktop),
  model a jeho intenzitu, tarif účtu, verzi balíčku a způsob zpřístupnění.
- Rozlišuj test kandidátních souborů přiložených k chatu a test skutečně
  instalovaného vydání. Test na jedné platformě nedokládá chování na jiné.
- Čtení podkladů dolož názvem souboru a existujícím ID oddílu; správná
  obecná odpověď je nedokládá. Konkrétní tvrzení porovnej se zdrojovou
  kapitolou.
- Výsledky a omezení zapisuj do autorské historie, scénáře udržuj
  v [smoke-prompts.md](../scripts/tutor/smoke-prompts.md). Interní test
  nevydávej za ověření na studentech.

<a id="podminky-vydani"></a>

### Podmínky vydání

Každá platforma se posuzuje zvlášť; bez splnění všech bodů se pro ni nová
verze nevydává ([R85](rozhodnuti/ai-tutor.md#r85-tutor-kapitoly-obrazky-tempo)).

1. Klient archiv přijme. Stav ověř v seznamu dovedností či pluginů a dotazem
   na verzi, nikoli podle hlášení při nahrání.
2. Tutor se aktivuje v novém chatu bez příloh v běžném konverzačním režimu.
3. Doložené použití nově přibalené kapitoly: název souboru, existující ID
   oddílu a shoda se zdrojem.
4. Vícekolový test tempa ve vedeném vysvětlování: cesta, jeden krok, jedna
   otázka, čekání; chybná odpověď vede k jinému podání téhož kroku.
5. Obrázek ukázaný bez vyžádání přímo v odpovědi a věcně shodný s učebnicí;
   zaznamenej, zda šlo o přibalený soubor, nebo překreslení z dat.
6. U oddílu s interaktivní stránkou tutor sám nabídne její funkční adresu,
   opsanou doslova.

Schopnost vytvořit vlastní funkční interaktivní výstup eviduj zvlášť podle
klienta; vydání nepodmiňuje.

## ChatGPT

- Balíček je plugin `ai-tutor/chatgpt/statistika-tutor-chatGPT-<verze>.zip`
  s manifesty `plugin.json` a `.codex-plugin/plugin.json`, logem a SKILL.md
  s hlavičkou zapsanou v JSON. Oba manifesty udržuj shodné.
- Zahajovací prompty: tři, každý nejvýše 100 znaků a začínající pokynem
  načíst SKILL.md tutora a katalog. Limit je autorská pojistka po chybě
  zobrazení na Desktopu, nikoli doložený limit klienta.
- Vydání nahrává novou verzi do existujícího soukromého pluginu podle
  [provozního návodu](PROVOZ.md#export-ai-tutora).
- Testuj v režimu **Chat**; režim Work jen na výslovný pokyn autora,
  také kvůli jeho limitům.

## Claude

- Balíček `ai-tutor/claude/statistika-tutor-claude-<verze>.zip` má v kořeni
  jedinou složku `statistika-tutor/`, jejíž název odpovídá poli `name`.
  Obsahuje stejné soubory jako skill pluginu; hlavička SKILL.md je v YAML,
  manifesty, logo a zahajovací prompty chybí.
- Pole `name` má nejvýše 64 znaků (malá písmena, číslice, pomlčky) bez slov
  „claude“ a „anthropic“; `description` nejvýše 1024 znaků bez znaků `<` a `>`.
  Spuštění skillu řídí jen `description`.
- Student nahrává archiv sám (Customize → Skills); vyžaduje zapnuté
  spouštění kódu. Sdílet skill lze jen v plánech Team a Enterprise.
  Každou novou verzi je třeba nahrát znovu. Číselné limity nahrání
  Anthropic nezveřejňuje; dne 2026-11-21 klient přijal archiv se 183 soubory
  a 4,7 MB (se SVG). Archiv s PNG má 192 souborů a 8,4 MB; jeho přijetí je
  třeba ověřit.
- Přibalený obrázek klient ukázal jako kartu souboru v postranním panelu,
  nikoli v textu odpovědi (pozorování autora 2026-11-21). V textu odpovědi
  lze zobrazit graf, který tutor nakreslí; proto se přibalují data ke grafům.
- Testuj v režimu **Chat**, nikoli v Code ani v agentních úlohách, a mimo
  projekt. Aktivaci zkoušej běžným dotazem a v rozhraní ověř, že byl skill
  použit a které soubory přečetl.

## Gemini

- Balíček `ai-tutor/gemini/statistika-tutor-gemini-<verze>.zip` vzniká
  z Claude složky bez souborů obrázků. Má `SKILL.md` a `references/` přímo
  v kořeni archivu a jen soubory `.md` a `.txt`: dialog nahrání uvádí typy
  CSV, PY, TXT a MD, proto se registr přibaluje jako `KAPITOLY.txt` a licence
  kódu jako `LICENSE.txt`. Zda by Gemini přijal i jiné uspořádání, doloženo
  není; jde o pojistku podle pokynu autora z 2026-11-21.
- Gemini dříve odmítl skill se 125 soubory. Přesný limit Google
  nezveřejňuje; kontrola exportu drží nejvýše 100 souborů jako projektovou
  pojistku. Dne 2026-11-21 klient přijal archiv s 36 soubory. Pokud by počet
  souborů narazil na limit, řeš to v exportu, nikoli vynecháním učiva.
- Při nahrání může Gemini ohlásit „Při nahrávání dovednosti došlo k chybě“,
  přestože se dovednost uložila a aktualizovala (pozorování autora
  2026-11-21). Stav ověřuj v seznamu dovedností a dotazem na verzi.
- Místo obrázku kapitola obsahuje číslovaný popisek, textový popis a odkaz
  na tentýž obrázek ve webové učebnici; rejstříky neuvádějí soubor obrázku
  a v SKILL.md je seznam možností zobrazení nahrazen zněním bez souborů. Obrázek
  s daty tutor překresluje, ostatní popisuje a uvádí adresu obrázku na webu.
- Gemini v testech posílal vymyšlené adresy učebnice obalené vyhledáváním
  Google (pozorování autora 2026-11-21). Instrukce proto ukládají opisovat
  adresy doslova jako prostý text; účinek je třeba ověřit testem.
- Tarif, model a režim testů doplň po prvním úplném testu vydání.
