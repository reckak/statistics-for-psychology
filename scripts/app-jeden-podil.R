# Reference values for the app page quarto/app_jeden_podil.qmd (test of one proportion, chapters 6 and 9).
# Base R only; run from the project root: Rscript --vanilla scripts/app-jeden-podil.R
# Prints a JavaScript array literal pasted into scripts/check-stat-lib.mjs (module assets/stat/podil.js)
# and into quarto/_verification/check-html.cjs (the page). For each case (k, n, pi0) and each alternative
# it gives the score test (prop.test without continuity correction), the exact binomial test (binom.test)
# and the Wilson intervals: two-sided at 0.95 and 0.90 and one-sided at 0.95 (lower and upper limit).
options(digits = 15)

cases <- list(
  c(10, 20, 0.25), c(7, 8, 0.5), c(6, 8, 0.5), c(106, 329, 0.25), c(0, 15, 0.1), c(25, 25, 0.9),
  c(0, 25, 0.3), c(1, 25, 0.04), c(3, 10, 1 / 3), c(31, 80, 0.25), c(12, 80, 0.25), c(56, 140, 0.5),
  c(4, 16, 0.5), c(18, 60, 0.3), c(500, 1000, 0.52), c(2, 40, 0.2), c(5000, 10000, 0.49), c(13, 20, 0.6),
  c(1, 1, 0.5), c(0, 1, 0.2)
)
alts <- c(two = "two.sided", greater = "greater", less = "less")

pt <- function(x, n, p, alt, conf) suppressWarnings(prop.test(x, n, p = p, alternative = alt, conf.level = conf, correct = FALSE))
fmt <- function(v) trimws(formatC(v, digits = 15, format = "g"))

rows <- character(0)
for (cs in cases) {
  k <- cs[1]; n <- cs[2]; p0 <- cs[3]
  for (a in names(alts)) {
    s <- pt(k, n, p0, alts[[a]], 0.95)
    z <- (k / n - p0) / sqrt(p0 * (1 - p0) / n)
    b <- binom.test(k, n, p = p0, alternative = alts[[a]])
    w95 <- pt(k, n, p0, "two.sided", 0.95)$conf.int
    w90 <- pt(k, n, p0, "two.sided", 0.90)$conf.int
    lo95 <- pt(k, n, p0, "greater", 0.95)$conf.int[1]
    hi95 <- pt(k, n, p0, "less", 0.95)$conf.int[2]
    vals <- c(z, s$p.value, b$p.value, w95, w90, lo95, hi95)
    rows <- c(rows, sprintf("  [[%d, %d, %s, \"%s\"], [%s]]", k, n, fmt(p0), a, paste(fmt(vals), collapse = ", ")))
  }
}
cat("// R (scripts/app-jeden-podil.R): [k, n, pi0, alt] -> [z, score p-value, exact p-value,\n")
cat("//   Wilson 95 % lo, hi, Wilson 90 % lo, hi, one-sided 95 % lower limit, one-sided 95 % upper limit]\n")
cat("const REFERENCE = [\n", paste(rows, collapse = ",\n"), "\n];\n", sep = "")
