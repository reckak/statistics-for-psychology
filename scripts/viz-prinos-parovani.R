# Reference values for the visualization quarto/viz_prinos_parovani.qmd (chapter 8).
# Base R only; run from the project root: Rscript --vanilla scripts/viz-prinos-parovani.R
# Prints the values used by quarto/_verification/check-html.cjs:
# (1) both analyses of the twelve complete pairs of variant A (table 8.4 of chapter 8),
# (2) both analyses of two fixed test data sets passed to the page through vizCheck,
# (3) standard errors of both analyses in the model,
# (4) rejection rates of both analyses: exact (noncentral t) for the paired analysis,
#     simulated for the incorrect analysis as two independent groups.
options(width = 200)

# Both analyses of one data set: paired t-test and the classical t-test with a pooled variance.
both <- function(x1, x2) {
  p <- t.test(x1, x2, paired = TRUE)
  w <- t.test(x1, x2, var.equal = TRUE)
  n <- length(x1)
  rbind(
    paired = c(n = n, m = mean(x1 - x2), se = sd(x1 - x2) / sqrt(n), t = unname(p$statistic),
      df = unname(p$parameter), p = p$p.value, lo = p$conf.int[1], hi = p$conf.int[2]),
    independent = c(n = n, m = mean(x1) - mean(x2), se = unname(w$stderr), t = unname(w$statistic),
      df = unname(w$parameter), p = w$p.value, lo = w$conf.int[1], hi = w$conf.int[2]))
}
describe <- function(x1, x2) c(s1 = sd(x1), s2 = sd(x2), sD = sd(x1 - x2), r = cor(x1, x2))

# --- 1. Variant A: twelve complete pairs (student 9 has no second measurement) --------------
normal <- c(58, 44, 51, 39, 62, 47, 55, 42, 49, 60, 45, 52)
short  <- c(53, 42, 45, 38, 55, 44, 51, 43, 44, 58, 39, 50)
cat('Variant A\n')
print(both(normal, short), digits = 12)
print(describe(normal, short), digits = 12)
cat('Quantiles\n')
print(c(t975_11 = qt(.975, 11), t975_22 = qt(.975, 22)), digits = 12)

# --- 2. Fixed test data sets -------------------------------------------------------------------
cat('\nContrast example 2, 4, 6 and 6, 12, 18\n')
print(both(c(2, 4, 6), c(6, 12, 18)), digits = 12)
print(describe(c(2, 4, 6), c(6, 12, 18)), digits = 12)
a1 <- c(12.5, 9, 14, 7.5, 11, 10, 13.5, 8)
a2 <- c(11, 9.5, 10, 8.5, 12, 7, 15, 6.5)
cat('\nTest data set of eight pairs with a negative difference\n')
print(both(a1, a2), digits = 12)
print(describe(a1, a2), digits = 12)

# --- 3. Standard errors in the model -----------------------------------------------------------
# Mode 1: X = mu_k + P + E; SD of a measurement sqrt(sP^2 + sE^2), SD of differences sE * sqrt(2).
# Mode 2: SDs s1, s2 and correlation r; SD of differences sqrt(s1^2 + s2^2 - 2 r s1 s2).
se1 <- function(sP, sE, n) c(paired = sE * sqrt(2) / sqrt(n), independent = sqrt(2 * (sP^2 + sE^2) / n),
  sdMeasure = sqrt(sP^2 + sE^2), sdDiff = sE * sqrt(2), share = sP^2 / (sP^2 + sE^2))
se2 <- function(s1, s2, r, n) { sD <- sqrt(s1^2 + s2^2 - 2 * r * s1 * s2)
  c(paired = sD / sqrt(n), independent = sqrt((s1^2 + s2^2) / n), sdDiff = sD) }
cat('\nModel standard errors\n')
print(rbind(
  mode1_default = c(se1(6.7, 1.7, 12), NA)[1:5],
  mode1_task2   = se1(1, 7, 12),
  mode1_zero    = se1(0, 5, 12)), digits = 12)
print(rbind(
  mode2_default = se2(7.34, 6.42, 0.95, 12),
  mode2_task4   = se2(2, 6, 0.99, 12),
  mode2_negative = se2(7.34, 6.42, -0.5, 12),
  mode2_zero    = se2(7.34, 6.42, 0, 12)), digits = 12)

# --- 4. Rejection rates at alpha = 0.05, two-sided ---------------------------------------------
# Paired analysis: exact power from the noncentral t-distribution.
power_paired <- function(delta, sD, n) {
  q <- qt(.975, n - 1); ncp <- delta / (sD / sqrt(n))
  pt(-q, n - 1, ncp) + 1 - pt(q, n - 1, ncp)
}
# Incorrect analysis as two independent groups: simulation of bivariate normal pairs.
sim_independent <- function(delta, s1, s2, r, n, reps = 400000) {
  z1 <- matrix(rnorm(reps * n), reps); z2 <- matrix(rnorm(reps * n), reps)
  x1 <- delta + s1 * z1; x2 <- s2 * (r * z1 + sqrt(1 - r^2) * z2)
  m1 <- rowMeans(x1); m2 <- rowMeans(x2)
  v1 <- rowSums((x1 - m1)^2) / (n - 1); v2 <- rowSums((x2 - m2)^2) / (n - 1)
  t <- (m1 - m2) / sqrt((v1 + v2) / n)
  mean(abs(t) > qt(.975, 2 * n - 2))
}
scen <- data.frame(
  name  = c('mode1_default', 'mode1_delta0', 'mode2_r09_delta0', 'mode2_rneg05_delta0', 'mode2_r0_delta0'),
  delta = c(3.5, 0, 0, 0, 0),
  s1    = c(sqrt(6.7^2 + 1.7^2), sqrt(6.7^2 + 1.7^2), 7.34, 7.34, 7.34),
  s2    = c(sqrt(6.7^2 + 1.7^2), sqrt(6.7^2 + 1.7^2), 6.42, 6.42, 6.42),
  r     = c(6.7^2 / (6.7^2 + 1.7^2), 6.7^2 / (6.7^2 + 1.7^2), 0.9, -0.5, 0),
  n     = 12)
set.seed(20261119)
scen$sD <- sqrt(scen$s1^2 + scen$s2^2 - 2 * scen$r * scen$s1 * scen$s2)
scen$paired_exact <- mapply(power_paired, scen$delta, scen$sD, scen$n)
scen$independent_sim <- mapply(sim_independent, scen$delta, scen$s1, scen$s2, scen$r, scen$n)
cat('\nRejection rates (paired exact, independent simulated with 400 000 samples)\n')
print(scen, digits = 6)
