# Statistika pro psychology – AI tutor

Zdroj instrukcí a metadat pluginu; verzi uvádějí oba manifesty. Autor: Karel Rečka.

Tato složka je **vstup exportu**, nikoli hotový instalační balíček.
Kapitoly, výukové plány, nabídka kapitol, přehledy, obrázky, index, registr a literatura se sestavují z hlavních
zdrojů učebnice. Nevytvářej zde druhou ručně udržovanou kopii výkladu.

Instalační archiv vytváří node scripts/export-tutor.cjs spuštěný z repozitáře.
Výsledkem jsou archivy v ai-tutor/: chatgpt/statistika-tutor-chatGPT-<verze>.zip,
claude/statistika-tutor-claude-<verze>.zip a gemini/statistika-tutor-gemini-<verze>.zip.
Příkazy, závislosti, kontroly a aktualizace stejného cloudového pluginu jsou
v [provozním návodu](../../docs/PROVOZ.md#export-ai-tutora).

Hotový plugin obsahuje všechny výkladové kapitoly učebnice (nyní 1–10) včetně
cvičení a řešení, úvod, literaturu, bez souborů obrázků (ty má jen varianta pro Claude), rejstříky obrázků s daty pro
překreslení a celé aktuální přehledy
(slovníček, značení a vzorce, Excel). Ke každé kapitole vzniká z kapitolové
karty a struktury textu výukový plán s rozsahy řádků oddílů, zadání a řešení.
Zdrojový SKILL.md je šablona: export do značky tutor:chapter-menu vloží přesné
názvy a odkazy na plány. Katalogem pro nabídku kapitol je INDEX.md; malý registr
KAPITOLY.json (schéma 3) uvádí verzi, revizi a seznam kapitol. Údaje pro kontrolu
exportu zůstávají mimo balíček.

Student používá nainstalovaný plugin ve vlastním chatu bez nahrávání kapitol.

Čtyři režimy: vysvětlování, sokratovské vedení, procvičování a formativní
zkoušení. Instrukce vyžadují přečtení konkrétního podkladu, přesné citování
a přiznání nejistoty. Nenahrazují odbornou kontrolu ani skutečnou zkoušku.
Plugin nepotřebuje vlastní server ani studentský API klíč.

Text a vlastní obsah Karla Rečky: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.cs).
Původní obrázek Cmglee si ponechává CC BY-SA 3.0; podrobnosti a uvedení
původu obsahuje přibalená licence převzatá z hlavního souboru LICENSE-TEXT.md.
Ikona vznikla úpravou loga dodaného autorem (odstranění číslice 1 v ImageGen).
