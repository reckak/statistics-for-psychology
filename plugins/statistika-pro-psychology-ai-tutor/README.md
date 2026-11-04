# Statistika pro psychology – AI tutor

Zdroj instrukcí a metadat pluginu, verze 0.3.2. Autor: Karel Rečka.

Tato složka je **vstup exportu**, nikoli hotový instalační balíček.
Kapitoly, výukové plány, nabídka kapitol, přehledy, obrázky, index, registr a literatura se sestavují z hlavních
zdrojů učebnice. Nevytvářej zde druhou ručně udržovanou kopii výkladu.

Instalační archiv vytváří node scripts/export-tutor.cjs spuštěný z repozitáře.
Výsledkem je output/tutor/statistika-pro-psychology-ai-tutor-0.3.2.zip.
Příkazy, závislosti, kontroly a aktualizace stejného cloudového pluginu jsou
v [provozním návodu](../../docs/PROVOZ.md#export-ai-tutora).

Hotový plugin obsahuje úplné kapitoly 1–6, úvod, literaturu a celé aktuální
přehledy (slovníček, značení a vzorce, Excel). Hesla z kapitol 7–8 mají
k dispozici přehledový výklad; jejich celé kapitoly přibalené nejsou.
Šest výukových plánů vzniká z kapitolových karet a struktury textu. Zdrojový SKILL.md je šablona: export do značky tutor:chapter-menu vloží přesné názvy a odkazy na plány. Registr schématu 2 eviduje všech osm kapitol s dostupností; texty a plány přibaluje pro 1–6.

Student používá nainstalovaný plugin ve vlastním chatu bez nahrávání kapitol.

Čtyři režimy: vysvětlování, sokratovské vedení, procvičování a formativní
zkoušení. Instrukce vyžadují přečtení konkrétního podkladu, přesné citování
a přiznání nejistoty. Nenahrazují odbornou kontrolu ani skutečnou zkoušku.
Plugin nepotřebuje vlastní server ani studentský API klíč.

Text a vlastní obsah Karla Rečky: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.cs).
Původní obrázek Cmglee si ponechává CC BY-SA 3.0; podrobnosti a uvedení
původu obsahuje přibalená licence převzatá z hlavního souboru LICENSE-TEXT.md.
Ikona vznikla úpravou loga dodaného autorem (odstranění číslice 1 v ImageGen).
