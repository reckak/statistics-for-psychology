<a id="e11-diagnostika-normality"></a>

# E11 — Externí podklady diagnostiky normality v aplikaci Test jednoho průměru

[Rozcestník zdrojů](../ZDROJE.md) · [Mapa kapitol](../OSNOVA.md) · [Společné nálezy a historie](HISTORIE.md#bonett-2026-11-27)

Čtyři externí publikace citované na stránce [Test jednoho průměru](../../quarto/app_jeden_prumer.qmd#sec-app-prumer-princip) (oddíl „Co aplikace počítá“). V `sources/` nejsou. **Žádná z nich nebyla čtena v plném znění**; citace slouží k přiřazení postupů, které aplikace přebírá podle kódu a dokumentace R.

| Klíč | Identita (ověřeno 2026-11-27) | Ověřeno | Použití |
|---|---|---|---|
| `almeida2018` | Almeida, A., Loy, A., & Hofmann, H. (2018). ggplot2 compatible quantile-quantile plots in R. *The R Journal, 10*(2), 248–261. DOI 10.32614/RJ-2018-051 | Crossref (ročník, číslo, začátek strany; Crossref uvádí rok vydání záznamu 2019) a `citation("qqplotr")` v R (rok 2018, strany 248–261). Webová stránka článku čtena jen částečně, tvrzení o šířce pásů tam nalezeno nebylo. | Algoritmus pásů KS a tail-sensitive převzat z kódu funkce `stat_qq_band` balíčku qqplotr 0.0.7 (`qqplotr:::StatQqBand$compute_group`) a z její dokumentace (výchozí odhad parametrů pásu „ts“ robustními odhady Qn). |
| `aldornoiman2013` | Aldor-Noiman, S., Brown, L. D., Buja, A., Rolke, W., & Stine, R. A. (2013). The power to see: A new graphical test of normality. *The American Statistician, 67*(4), 249–260. DOI 10.1080/00031305.2013.847865 | Crossref. Abstrakt ani text nedostupné (403). | Původ pásu tail-sensitive, jak jej uvádí dokumentace qqplotr. Stránka netvrdí nic o jeho síle podle článku; vlastnosti pásu (šířka na krajích, pokrytí) aplikace dokládá vlastním výpočtem (`scripts/qq-ts-gamma.R`, `scripts/app-jeden-prumer.R`). |
| `royston1995` | Royston, P. (1995). Remark AS R94: A remark on algorithm AS 181: The W-test for normality. *Applied Statistics, 44*(4), 547–551. DOI 10.2307/2986146 | Crossref (začátek strany) a reference v dokumentaci `shapiro.test` v R (strany 547–551). | Algoritmus Shapirova–Wilkova testu převzat z R (`swilk.c`) a ověřen proti `shapiro.test`. |
| `allen2021` | Allen, M., Poggiali, D., Whitaker, K., Marshall, T. R., van Langen, J., & Kievit, R. A. (2021). Raincloud plots: A multi-platform tool for robust data visualization. *Wellcome Open Research, 4*, 63. DOI 10.12688/wellcomeopenres.15191.2 (verze 2) | Crossref (verze 2 z 21. 1. 2021). | Název a obecná podoba raincloud grafu (odhad hustoty, krabicový graf, jednotlivé hodnoty). |

**Odchylka od qqplotr:** pás tail-sensitive aplikace simuluje stejně jako výchozí qqplotr (standardizované normální výběry), ale standardizuje průměrem a směrodatnou odchylkou místo robustních odhadů Qn, aby pás ležel kolem přímky $m+s z$ z kapitoly 4. Pás KS je spočítán přesně jako v qqplotr s `dparams = list(mean = m, sd = s)` a `identity = TRUE` (shoda ověřena na 10⁻⁹).

**Neověřeno:** obsah všech čtyř článků; Shapiro a Wilk (1965), Weine et al. (2021) a další literatura k testům normality nebyly čteny ani citovány.
