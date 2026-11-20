# Reference values for the visualization quarto/viz_chi_kvadrat.qmd (chapter 9).
# Base R only; run from the project root: Rscript --vanilla scripts/viz-chi-kvadrat.R
# Prints the values used by quarto/_verification/check-html.cjs and quoted in the page text:
# expected frequencies, cell contributions, Pearson and standardized residuals, the chi-square
# statistic, its p-value, Cramer's V and the smallest expected frequency for the table of
# chapter 9 (age group x coping strategy), the doubled table, the preset "Nezavislost"
# and two edited tables used in the tasks.
options(width = 200)

labels <- list(c('mladi', 'dospeli', 'seniori'), c('reseni problemu', 'vyhybani', 'socialni opora'))
tab <- function(x) matrix(x, nrow = 3, byrow = TRUE, dimnames = labels)

analyse <- function(f) {
  n <- sum(f); r <- rowSums(f); s <- colSums(f)
  e <- outer(r, s) / n
  contrib <- (f - e)^2 / e
  pearson <- (f - e) / sqrt(e)
  # Standardized (adjusted) residual: Pearson residual divided by its estimated standard deviation.
  std <- (f - e) / sqrt(e * outer(1 - r / n, 1 - s / n))
  chi2 <- sum(contrib); df <- (nrow(f) - 1) * (ncol(f) - 1)
  list(n = n, row_prop = f / r, overall = s / n, e = e, contrib = contrib, pearson = pearson, std = std,
    chi2 = chi2, df = df, p = pchisq(chi2, df, lower.tail = FALSE),
    V = sqrt(chi2 / (n * (min(dim(f)) - 1))), min_e = min(e))
}

show <- function(title, f) {
  a <- analyse(f)
  cat(sprintf('\n=== %s ===\n', title)); print(addmargins(f))
  cat(sprintf('n = %d, chi2 = %.10f, df = %d, p = %.10g, V = %.10f, min e = %.10f\n', a$n, a$chi2, a$df, a$p, a$V, a$min_e))
  cat('row proportions\n'); print(a$row_prop, digits = 10)
  cat('proportions in the whole sample\n'); print(a$overall, digits = 10)
  cat('expected\n'); print(a$e, digits = 10)
  cat('contributions\n'); print(a$contrib, digits = 10)
  cat('Pearson residuals\n'); print(a$pearson, digits = 10)
  cat('standardized residuals\n'); print(a$std, digits = 10)
  # Independent check of the statistic and the p-value.
  ct <- suppressWarnings(chisq.test(f, correct = FALSE))
  stopifnot(isTRUE(all.equal(unname(ct$statistic), a$chi2)), isTRUE(all.equal(ct$p.value, a$p)),
    isTRUE(all.equal(unname(ct$stdres), unname(a$std), check.attributes = FALSE)),
    isTRUE(all.equal(unname(ct$residuals), unname(a$pearson), check.attributes = FALSE)))
  invisible(a)
}

chapter <- tab(c(25, 18, 12, 30, 22, 28, 10, 20, 25))
show('Chapter 9: age group x coping strategy', chapter)
show('Doubled frequencies', 2 * chapter)
show('Doubled twice', 4 * chapter)
show('Preset "Nezavislost" (rounded expected frequencies)', tab(c(19, 17, 19, 27, 26, 27, 19, 17, 19)))
# Task 2: from the preset, five young people move from social support to problem solving.
show('Preset "Nezavislost", mladi 24, 17, 14', tab(c(24, 17, 14, 27, 26, 27, 19, 17, 19)))
# Task 3: one cell of the chapter table changed (seniori x reseni problemu from 10 to 20).
show('Chapter table with seniori x reseni problemu = 20', tab(c(25, 18, 12, 30, 22, 28, 20, 20, 25)))
# Task 4: a small table with expected frequencies below 5.
show('Small table', tab(c(5, 4, 2, 6, 4, 6, 2, 4, 5)))

cat(sprintf('\ncritical value for 0.05 and 4 df: %.10f\n', qchisq(0.95, 4)))
cat('right tail of chi-square with 4 df at 1, 5, 9.49, 11.78, 23.56, 60:\n')
print(pchisq(c(1, 5, 9.49, 11.78, 23.56, 60), 4, lower.tail = FALSE), digits = 12)
cat('density of chi-square with 4 df at 0.5, 2, 6, 12:\n'); print(dchisq(c(0.5, 2, 6, 12), 4), digits = 12)
