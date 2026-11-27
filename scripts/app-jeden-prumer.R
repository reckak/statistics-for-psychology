# Reference values for the app page quarto/app_jeden_prumer.qmd (one mean: z-test, one-sample and paired t-test,
# equivalence test, Cohen's d with intervals, normality diagnostics).
# Run from the project root: Rscript --vanilla scripts/app-jeden-prumer.R
# Writes scripts/reference/app-jeden-prumer.json, read by scripts/check-stat-lib.mjs (modules assets/stat/prumer.js
# and assets/stat/normalita.js) and quarto/_verification/check-html.cjs (the page).
# Packages: jsonlite, effectsize and MBESS (independent checks of the exact interval for d), qqplotr and ggplot2
# (KS band of the Q–Q plot), e1071 if installed (skewness and kurtosis of type 2 = Excel SKEW and KURT).
# Independence from the JS module: tests and intervals with t.test() on data or with base pt/qt/pnorm on summaries;
# the noncentral t distribution by stats::integrate (R's own pt(…, ncp) switches to an approximation for
# ncp > 37,62); Bonett's (2015) intervals written out from the article; Shapiro–Wilk by shapiro.test().
suppressPackageStartupMessages({ library(jsonlite); library(ggplot2); library(qqplotr) })
options(digits = 15)
set.seed(20261127)

# Noncentral t by integration over the chi distribution and the interval for the noncentrality parameter.
pnct <- function(t, df, ncp) {
  md <- sqrt(max(df - 1, 0))
  integrate(function(x) pnorm(t * x / sqrt(df) - ncp) * exp((df - 1) * log(x) - x^2 / 2 - (df / 2 - 1) * log(2) - lgamma(df / 2)),
            max(0, md - 10), md + 10, rel.tol = 1e-13, abs.tol = 0, subdivisions = 5000L)$value
}
ncpLimit <- function(t, df, target) {
  w <- 2 + abs(t) / 2
  lo <- t - w; while (pnct(t, df, lo) < target) lo <- lo - w
  hi <- t + w; while (pnct(t, df, hi) > target) hi <- hi + w
  uniroot(function(d) pnct(t, df, d) - target, c(lo, hi), tol = 1e-13)$root
}
side_of <- function(alt, kind) if (alt == "two" || kind == "two") "two" else if (alt == "greater") "lower" else "upper"
conf_of <- function(alt, kind, alpha) if (alt == "two") 1 - alpha else if (kind == "two") 1 - 2 * alpha else 1 - alpha
num <- function(v) if (is.null(v) || length(v) == 0 || is.na(v)) NA else if (is.infinite(v)) (if (v > 0) "Inf" else "-Inf") else v

# One mean from summaries: test t (s) or z (sigma).
mean_case <- function(test, m, sd, n, mu0, alt, kind, alpha) {
  se <- sd / sqrt(n); st <- (m - mu0) / se; df <- n - 1
  cdf <- if (test == "z") function(x) pnorm(x) else function(x) pt(x, df)
  p <- switch(alt, two = 2 * cdf(-abs(st)), greater = 1 - cdf(st), less = cdf(st))
  if (test == "t" && alt == "greater") p <- pt(st, df, lower.tail = FALSE)
  if (test == "z" && alt == "greater") p <- pnorm(st, lower.tail = FALSE)
  side <- side_of(alt, kind); conf <- conf_of(alt, kind, alpha)
  prob <- if (side == "two") 1 - (1 - conf) / 2 else conf
  q <- if (test == "z") qnorm(prob) else qt(prob, df)
  lo <- if (side == "upper") -Inf else m - q * se; hi <- if (side == "lower") Inf else m + q * se
  d <- (m - mu0) / sd
  if (test == "z") { dlo <- (lo - mu0) / sd; dhi <- (hi - mu0) / sd; J <- NA }
  else {
    a <- if (side == "two") (1 - conf) / 2 else 1 - conf
    dlo <- if (side == "upper") -Inf else ncpLimit(st, df, 1 - a) / sqrt(n)
    dhi <- if (side == "lower") Inf else ncpLimit(st, df, a) / sqrt(n)
    J <- if (df >= 2) 1 - 3 / (4 * df - 1) else NA
  }
  list(input = list(test = test, m = m, sd = sd, n = n, mu0 = mu0, alt = alt, kind = kind, alpha = alpha),
       se = se, stat = st, p = p, q = q, lo = num(lo), hi = num(hi), d = d, dlo = num(dlo), dhi = num(dhi), J = num(J))
}

uzkost <- c(18, 22, 25, 19, 24, 21, 27, 17, 23, 20, 26, 22, 19, 28, 21, 24, 18, 25, 23, 22)
summ <- list(
  uzkost = list("t", mean(uzkost), sd(uzkost), 20, 20),
  pozornost_t = list("t", 46, 11, 25, 50), pozornost_z = list("z", 46, 10, 25, 50),
  pdi = list("t", 104.125, 12.584, 56, 100), iq_z = list("z", 104.5, 15, 36, 100),
  pohoda = list("t", 32.4, 4.8, 16, 30), online = list("t", 48.5, 10, 400, 50),
  dvojice = list("t", 5, 1, 2, 0), velke_d = list("t", 30, 2, 5, 0), zaporne = list("t", -3.2, 4.1, 9, 1.5),
  velke_n = list("t", 100.3, 15, 10000, 100), velke_n_d = list("t", 130, 10, 10000, 100), nula = list("t", 50, 10, 30, 50)
)
means <- list()
for (nm in names(summ)) {
  a <- summ[[nm]]
  for (alt in c("two", "greater", "less")) for (kind in c("two", "one")) {
    if (alt == "two" && kind == "one") next
    for (alpha in c(0.05, 0.1)) {
      if (alpha == 0.1 && !(nm %in% c("uzkost", "pozornost_z"))) next
      means[[length(means) + 1]] <- c(list(case = nm), mean_case(a[[1]], a[[2]], a[[3]], a[[4]], a[[5]], alt, kind, alpha))
    }
  }
}
# Independent checks with packages and t.test on the data (printed; the JSON holds the values above).
tt <- t.test(uzkost, mu = 20)
stopifnot(abs(tt$statistic - means[[1]]$stat) < 1e-12, abs(tt$p.value - means[[1]]$p) < 1e-12, abs(tt$conf.int[1] - means[[1]]$lo) < 1e-10)
es <- effectsize::cohens_d(uzkost, mu = 20)
stopifnot(abs(es$CI_low - means[[1]]$dlo) < 1e-6, abs(es$CI_high - means[[1]]$dhi) < 1e-6)
mb <- MBESS::conf.limits.nct(ncp = means[[1]]$stat, df = 19, conf.level = 0.95)
stopifnot(abs(mb$Lower.Limit / sqrt(20) - means[[1]]$dlo) < 1e-5)

# Equivalence test (TOST) via t.test against each bound; online example of chapter 7 from summaries.
tost_sum <- function(m, s, n, lower, upper, alpha) {
  se <- s / sqrt(n); df <- n - 1
  tl <- (m - lower) / se; tu <- (m - upper) / se
  list(m = m, s = s, n = n, lower = lower, upper = upper, alpha = alpha, tL = tl, tU = tu,
       pL = pt(tl, df, lower.tail = FALSE), pU = pt(tu, df), lo = m - qt(1 - alpha, df) * se, hi = m + qt(1 - alpha, df) * se)
}
tost <- list(online = tost_sum(48.5, 10, 400, 47, 53, 0.05), mala = tost_sum(48.5, 10, 40, 47, 53, 0.05),
             nesoum = tost_sum(48.5, 10, 400, 46, 52, 0.05))
tl <- t.test(uzkost, mu = 19, alternative = "greater"); tu <- t.test(uzkost, mu = 23, alternative = "less")
tost$uzkost <- list(data = "uzkost", lower = 19, upper = 23, alpha = 0.05, tL = unname(tl$statistic), tU = unname(tu$statistic),
                    pL = tl$p.value, pU = tu$p.value, lo = t.test(uzkost, conf.level = 0.9)$conf.int[1], hi = t.test(uzkost, conf.level = 0.9)$conf.int[2])

# Paired data: chapter 8, variant A (student 9 has no second measurement and is dropped).
bezny <- c(58, 44, 51, 39, 62, 47, 55, 42, 53, 49, 60, 45, 52); kratky <- c(53, 42, 45, 38, 55, 44, 51, 43, NA, 44, 58, 39, 50)
ok <- complete.cases(bezny, kratky); x1 <- bezny[ok]; x2 <- kratky[ok]
pt8 <- t.test(x1, x2, paired = TRUE)
bonett <- function(x1, x2, conf = 0.95, side = "two", mu0 = 0) {
  n <- length(x1); df <- n - 1; s1 <- sd(x1); s2 <- sd(x2); r <- cor(x1, x2); sd_ <- sd(x1 - x2); md <- mean(x1 - x2) - mu0
  z <- if (side == "two") qnorm(1 - (1 - conf) / 2) else qnorm(conf)
  d3 <- md / s1; v3 <- d3^2 / (2 * df) + sd_^2 / (s1^2 * df)                                   # eq. 7 and 11
  s2bar <- (s1^2 + s2^2) / 2; d2 <- md / sqrt(s2bar)
  v2 <- d2^2 * (s1^4 + s2^4 + 2 * r^2 * s1^2 * s2^2) / (8 * df * s2bar^2) + sd_^2 / (s2bar * df)  # eq. 6 and 9
  lim <- function(d, v) c(if (side == "upper") -Inf else d - z * sqrt(v), if (side == "lower") Inf else d + z * sqrt(v))
  list(n = n, s1 = s1, s2 = s2, r = r, mD = md + mu0, sD = sd_, ref = c(d3, lim(d3, v3), (1 - 3 / (4 * df - 1)) * d3),
       avg = c(d2, lim(d2, v2), sqrt((n - 2) / df) * d2))
}
# Bonett's example (p. 373–374): CI [−0,21; 0,63] for d₂ and d₃, adjusted estimates 0,20 and 0,19.
# The article calls 4,81 and 4,67 "sample variances"; they are the standard deviations of these data.
pre <- c(11, 4, 19, 7, 9, 3, 13, 5, 8, 6); post <- c(8, 5, 15, 7, 11, 0, 9, 4, 13, 3)
bx <- bonett(pre, post)
stopifnot(abs(sd(pre) - 4.81) < 0.005, abs(sd(post) - 4.67) < 0.005, abs(round(cor(pre, post), 2) - 0.80) < 1e-9)
# Equation 13 (d₂) reproduces [−0,21; 0,63] exactly. Equation 15 (d₃) as printed gives [−0,21; 0,62] (upper limit
# 0,624); the article reports [−0,21; 0,63] "for both" (finding recorded in docs/zdroje/D16-bonett.md).
stopifnot(all(abs(round(bx$avg[2:3], 2) - c(-0.21, 0.63)) < 1e-9), abs(round(bx$ref[2], 2) + 0.21) < 1e-9, abs(bx$ref[3] - 0.6237) < 5e-4)
stopifnot(abs(round(bx$avg[4], 2) - 0.20) < 1e-9, abs(round(bx$ref[4], 2) - 0.19) < 1e-9)
paired <- list()
for (cs in list(list("spanek", x1, x2), list("bonett", pre, post))) for (side in c("two", "lower", "upper")) {
  conf <- if (side == "two") 0.95 else 0.95
  b <- bonett(cs[[2]], cs[[3]], conf, side)
  n <- b$n; tst <- mean(cs[[2]] - cs[[3]]) / (b$sD / sqrt(n)); a <- if (side == "two") 0.025 else 0.05
  dz <- c(b$mD / b$sD, if (side == "upper") -Inf else ncpLimit(tst, n - 1, 1 - a) / sqrt(n), if (side == "lower") Inf else ncpLimit(tst, n - 1, a) / sqrt(n))
  paired[[length(paired) + 1]] <- list(case = cs[[1]], side = side, conf = conf, x1 = cs[[2]], x2 = cs[[3]], n = n, s1 = b$s1, s2 = b$s2, r = b$r,
    mD = b$mD, sD = b$sD, ref = lapply(b$ref, num), avg = lapply(b$avg, num), dz = lapply(dz, num))
}
stopifnot(abs(pt8$statistic - mean(x1 - x2) / (sd(x1 - x2) / sqrt(12))) < 1e-12)

# Normality diagnostics: samples from several shapes and sizes.
samples <- list(uzkost = uzkost, kratke = c(4, 5, 5, 6, 10), tri = c(1, 2, 4), ctyri = c(2.5, 3.1, 3.1, 7.2),
                sesikmene = round(rexp(40, 1 / 30), 1), normalni = round(rnorm(150, 100, 15), 2),
                tezke = round(rt(300, 3) * 5 + 50, 2), velke = round(rnorm(1500), 4), jedenact = c(3, 8, 1, 9, 4, 4, 6, 2, 7, 5, 30),
                dvanact = c(35, 39, 42, 45, 47, 49, 51, 53, 55, 58, 61, 65))
skew2 <- function(x) { n <- length(x); m <- mean(x); s <- sd(x); n / ((n - 1) * (n - 2)) * sum(((x - m) / s)^3) }
kurt2 <- function(x) { n <- length(x); m <- mean(x); s <- sd(x); n * (n + 1) / ((n - 1) * (n - 2) * (n - 3)) * sum(((x - m) / s)^4) - 3 * (n - 1)^2 / ((n - 2) * (n - 3)) }
if (requireNamespace("e1071", quietly = TRUE)) {
  for (x in samples) if (length(x) >= 4) stopifnot(abs(skew2(x) - e1071::skewness(x, type = 2)) < 1e-10, abs(kurt2(x) - e1071::kurtosis(x, type = 2)) < 1e-10)
}
stopifnot(abs(round(skew2(c(4, 5, 5, 6, 10)), 2) - 1.74) < 1e-9, abs(round(kurt2(c(4, 5, 5, 6, 10)), 2) - 3.32) < 1e-9)   # chapter 3
diag <- list()
for (nm in names(samples)) {
  x <- samples[[nm]]; n <- length(x); xs <- sort(x); q <- unname(quantile(x, c(0.25, 0.5, 0.75), type = 7)); iqr <- q[3] - q[1]
  lf <- q[1] - 1.5 * iqr; uf <- q[3] + 1.5 * iqr
  sw <- shapiro.test(x)
  bw <- bw.nrd0(x); grid <- seq(min(x) - 3 * bw, max(x) + 3 * bw, length.out = 7)
  dens <- sapply(grid, function(g) mean(dnorm((g - x) / bw)) / bw)
  dd <- density(x)   # binned FFT estimate of R, compared loosely
  out <- list(x = x, n = n, m = mean(x), s = sd(x), q = q, lowerFence = lf, upperFence = uf,
              whiskerLo = min(xs[xs >= lf]), whiskerHi = max(xs[xs <= uf]), nOut = sum(x < lf | x > uf),
              skew = num(if (n >= 3) skew2(x) else NA), kurt = num(if (n >= 4) kurt2(x) else NA),
              W = unname(sw$statistic), pW = sw$p.value, bw = bw, grid = grid, dens = dens,
              densR = approx(dd$x, dd$y, xout = grid[2:6])$y)
  # Q–Q bands from qqplotr with the normal model N(m, s) as in chapter 4 (identity line = m + s·z).
  df_ <- data.frame(v = x)
  ks <- layer_data(ggplot(df_, aes(sample = v)) + stat_qq_band(distribution = "norm", dparams = list(mean = mean(x), sd = sd(x)), identity = TRUE, bandType = "ks"))
  out$ksLo <- lapply(ks$lower, num); out$ksHi <- lapply(ks$upper, num)
  diag[[nm]] <- out
}
# Shapiro–Wilk across sizes (W and p-value), with a fixed seed.
sw <- list()
for (n in c(3, 4, 5, 6, 7, 11, 12, 20, 50, 100, 500, 1000, 5000)) for (k in if (n >= 1000) 1 else 1:3) {
  x <- round(if (k == 1) rnorm(n) else if (k == 2) rexp(n) else runif(n), 6)
  if (length(unique(x)) < 2) next
  s <- shapiro.test(x); sw[[length(sw) + 1]] <- list(x = x, W = unname(s$statistic), p = s$p.value)
}
# Tail-sensitive band for given n from the table (qbeta in R) and its simultaneous coverage for normal samples
# drawn with the line m + s·z from each sample (should be about 0,95); for comparison the coverage of the KS band
# of qqplotr with m and s (conservative: parameters estimated from the same data).
src <- readLines("assets/stat/qq-ts-gamma.js")
tsN <- as.numeric(strsplit(sub(".*\\[(.*)\\];", "\\1", grep("TS_N =", src, value = TRUE)), ", ")[[1]])
tsG <- as.numeric(strsplit(sub(".*\\[(.*)\\];", "\\1", grep("TS_GAMMA =", src, value = TRUE)), ", ")[[1]])
gam <- function(n) { if (n %in% tsN) return(tsG[match(n, tsN)]); k <- which(tsN > n)[1]; f <- (log(n) - log(tsN[k - 1])) / (log(tsN[k]) - log(tsN[k - 1])); exp(log(tsG[k - 1]) + f * (log(tsG[k]) - log(tsG[k - 1]))) }
bands <- list(); coverage <- list()
for (n in c(3, 5, 10, 13, 20, 45, 100, 777, 2000)) {
  g <- gam(n); lo <- qnorm(qbeta(g, 1:n, n:1)); hi <- qnorm(qbeta(1 - g, 1:n, n:1))
  bands[[as.character(n)]] <- list(n = n, gamma = g, lo = lo, hi = hi)
  if (n <= 100) {
    B <- 4000
    eps <- sqrt(log(2 / 0.05) / (2 * n)); pp <- ((1:n) - 0.5) / n
    kLo <- qnorm(pmax(pp - eps, 0)); kHi <- qnorm(pmin(pp + eps, 1))
    hitTs <- 0; hitKs <- 0
    for (b in 1:B) {
      z <- sort(rnorm(n)); zs <- (z - mean(z)) / sd(z)
      hitTs <- hitTs + all(zs >= lo & zs <= hi); hitKs <- hitKs + all(zs >= kLo & zs <= kHi)
    }
    coverage[[as.character(n)]] <- list(n = n, ts = hitTs / B, ks = hitKs / B)
  }
}
print(coverage)

dir.create("scripts/reference", showWarnings = FALSE)
writeLines(toJSON(list(means = means, tost = tost, paired = paired, diag = diag, sw = sw, bands = bands, coverage = coverage),
                  digits = NA, auto_unbox = TRUE, null = "null", na = "null"), "scripts/reference/app-jeden-prumer.json")
cat("written scripts/reference/app-jeden-prumer.json\n")
