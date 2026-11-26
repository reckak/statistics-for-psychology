# Reference values for the app page quarto/app_dva_podily.qmd (two independent proportions, chapter 9).
# Run from the project root: Rscript --vanilla scripts/app-dva-podily.R
# Writes scripts/reference/app-dva-podily.json, read by scripts/check-stat-lib.mjs (module assets/stat/dva-podily.js)
# and quarto/_verification/check-html.cjs (the page).
# Packages: jsonlite, DescTools (Newcombe interval: BinomDiffCI(method = "score")) and Exact (exact unconditional
# z-pooled test of Agresti & Min, 2001). Base R: prop.test, fisher.test, cor; the score test for δ₀ ≠ 0
# (Farrington–Manning) is computed here independently of the module by solving the likelihood equation with
# uniroot; the log intervals of the ratios follow the formulas of chapter 9 (DescTools::RelRisk uses another SE).
suppressPackageStartupMessages({ library(jsonlite); library(DescTools); library(Exact) })
options(digits = 15)

# Tables: a and c = counts of the chosen category in groups 1 and 2 of sizes n1 and n2.
cases <- list(
  stres = c(40, 100, 30, 100), daniels = c(56, 140, 20, 117), pilot = c(8, 10, 3, 10),
  aspirin = c(189, 11034, 104, 11037), noninf = c(66, 100, 70, 100), dvojnasobek = c(80, 200, 60, 200),
  nula1 = c(0, 10, 5, 10), plna1 = c(10, 10, 0, 12), nuly = c(0, 15, 0, 20), plne = c(15, 15, 20, 20),
  male = c(3, 5, 1, 7), jedna = c(1, 1, 0, 1), cv = c(12, 24, 5, 30), velke = c(5000, 10000, 4900, 10000)
)
deltas <- c(0, -0.3, -0.1, 0.1, 0.25)
alts <- c(two = "two.sided", greater = "greater", less = "less")

# Farrington–Manning restricted estimates: maximise the binomial likelihood under pi1 - pi2 = d.
fm <- function(a, n1, c, n2, d) {
  if (d == 0) { p <- (a + c) / (n1 + n2); return(c(p, p)) }
  lo <- max(0, d); hi <- min(1, 1 + d)
  g <- function(t) (if (a) a / t else 0) - (if (n1 - a) (n1 - a) / (1 - t) else 0) +
    (if (c) c / (t - d) else 0) - (if (n2 - c) (n2 - c) / (1 - t + d) else 0)
  e <- 1e-14
  t <- if (g(lo + e) <= 0) lo else if (g(hi - e) >= 0) hi else uniroot(g, c(lo + e, hi - e), tol = 1e-15)$root
  c(t, t - d)
}
pz <- function(z, alt) switch(alt, two = 2 * pnorm(-abs(z)), greater = pnorm(-z), less = pnorm(z))
num <- function(v) if (is.null(v) || length(v) == 0 || !is.finite(v)) NA else v

out <- list()
for (nm in names(cases)) {
  x <- cases[[nm]]; a <- x[1]; n1 <- x[2]; c <- x[3]; n2 <- x[4]; b <- n1 - a; dd <- n2 - c
  m <- matrix(c(a, b, c, dd), 2, byrow = TRUE)
  score <- list()
  for (d in deltas) for (al in names(alts)) {
    r <- fm(a, n1, c, n2, d)
    se <- sqrt(r[1] * (1 - r[1]) / n1 + r[2] * (1 - r[2]) / n2)
    z <- if (se > 0) (a / n1 - c / n2 - d) / se else NA
    p <- if (is.na(z)) NA else pz(z, al)
    if (d == 0 && !is.na(z)) {   # cross-check with prop.test (chi-square without continuity correction)
      pt <- suppressWarnings(prop.test(c(a, c), c(n1, n2), alternative = alts[[al]], correct = FALSE))
      stopifnot(abs(pt$p.value - p) < 1e-12, abs(pt$statistic - z^2) < 1e-9)
    }
    score[[length(score) + 1]] <- list(delta = d, alt = al, p1t = r[1], p2t = r[2], se0 = se, z = num(z), p = num(p))
  }
  fisher <- if (n1 + n2 <= 1000) lapply(alts, function(al) fisher.test(m, alternative = al)$p.value) else NULL
  nc <- function(conf, sides) unname(BinomDiffCI(a, n1, c, n2, conf.level = conf, sides = sides, method = "score")[1, 2:3])
  newcombe <- list(two95 = nc(0.95, "two.sided"), two90 = nc(0.90, "two.sided"), lower95 = nc(0.95, "left"), upper95 = nc(0.95, "right"))
  z95 <- qnorm(0.975)
  rr <- if (c > 0) (a / n1) / (c / n2) else NA
  rrCi <- if (a > 0 && c > 0) exp(log(rr) + c(-1, 1) * z95 * sqrt(1 / a - 1 / n1 + 1 / c - 1 / n2)) else c(NA, NA)
  or <- if (b > 0 && c > 0) (a * dd) / (b * c) else NA
  orCi <- if (min(a, b, c, dd) > 0) exp(log(or) + c(-1, 1) * z95 * sqrt(1 / a + 1 / b + 1 / c + 1 / dd)) else c(NA, NA)
  if (!is.na(or) && min(a, b, c, dd) > 0) stopifnot(max(abs(OddsRatio(m, method = "wald", conf.level = 0.95)[2:3] - orCi)) < 1e-9)
  # Signed φ = Pearson correlation of the 0/1 codes of group (1 = group 1) and outcome (1 = chosen category).
  phi <- if (min(n1, n2, a + c, b + dd) > 0) cor(rep(c(1, 1, 0, 0), c(a, b, c, dd)), rep(c(1, 0, 1, 0), c(a, b, c, dd))) else NA
  out[[nm]] <- list(cells = list(c(a, b), c(c, dd)), score = score, fisher = fisher, newcombe = newcombe,
                    rr = num(rr), rrCi = rrCi, or = num(or), orCi = orCi, phi = num(phi))
}

# Exact unconditional z-pooled test (Agresti & Min, 2001): p-values from the package Exact with a fine nuisance grid.
exactCases <- c("stres", "daniels", "pilot", "noninf", "nula1", "male", "cv")
exact <- list()
for (nm in exactCases) {
  x <- cases[[nm]]; m <- matrix(c(x[1], x[2] - x[1], x[3], x[4] - x[3]), 2, byrow = TRUE)
  for (d in c(0, -0.1, 0.1, -0.0381, -0.035)) for (al in names(alts)) {
    r <- exact.test(m, method = "z-pooled", model = "Binomial", alternative = alts[[al]], delta = d, npNumbers = 1000, to.plot = FALSE)
    exact[[length(exact) + 1]] <- list(case = nm, delta = d, alt = al, t = unname(r$statistic), p = r$p.value)
  }
}
# Intervals of the package (it reports one accepted piece; the module, like Agresti & Min, takes the outermost
# accepted values, so its limits may lie further out where the p-value has narrow peaks above α).
exactCi <- list()
for (nm in c("pilot", "male", "nula1", "stres")) {
  x <- cases[[nm]]; m <- matrix(c(x[1], x[2] - x[1], x[3], x[4] - x[3]), 2, byrow = TRUE)
  r <- exact.test(m, method = "z-pooled", model = "Binomial", conf.int = TRUE, conf.level = 0.95, to.plot = FALSE)
  exactCi[[nm]] <- unname(as.numeric(r$conf.int))
}

dir.create("scripts/reference", showWarnings = FALSE)
writeLines(toJSON(list(source = "scripts/app-dva-podily.R", cases = out, exact = exact, exactCi = exactCi),
                  auto_unbox = TRUE, digits = NA, na = "null", null = "null", pretty = TRUE),
           "scripts/reference/app-dva-podily.json")
cat("Written scripts/reference/app-dva-podily.json:", length(out), "tables,", length(exact), "exact p-values\n")
