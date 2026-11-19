# Reference values for the visualization quarto/viz_dva_intervaly.qmd (chapter 8).
# Base R only; run from the project root: Rscript --vanilla scripts/viz-dva-intervaly.R
# Prints the values used by quarto/_verification/check-html.cjs: intervals of both means,
# the interval of the difference (classical, Welch, paired), the band in which the intervals
# overlap although the difference is significant, and the Excel quantile via BETA.INV.
options(width = 200)

# Interval of one mean from summaries.
ci1 <- function(m, s, n, level) { q <- qt((1 + level) / 2, n - 1); me <- q * s / sqrt(n)
  c(m = m, q = q, se = s / sqrt(n), me = me, lo = m - me, hi = m + me) }
# Difference (second minus first) from summaries.
diff2 <- function(m1, s1, n1, m2, s2, n2, level, method = c('classical', 'welch')) {
  method <- match.arg(method)
  if (method == 'classical') {
    sp2 <- ((n1 - 1) * s1^2 + (n2 - 1) * s2^2) / (n1 + n2 - 2)
    se <- sqrt(sp2 * (1 / n1 + 1 / n2)); df <- n1 + n2 - 2
  } else {
    a <- s1^2 / n1; b <- s2^2 / n2
    se <- sqrt(a + b); df <- (a + b)^2 / (a^2 / (n1 - 1) + b^2 / (n2 - 1))
  }
  d <- m2 - m1; t <- d / se; q <- qt((1 + level) / 2, df); me <- q * se
  c(d = d, se = se, df = df, t = t, p = 2 * pt(-abs(t), df), q = q, me = me, lo = d - me, hi = d + me)
}
paired <- function(m1, m2, sD, n, level) {
  d <- m2 - m1; se <- sD / sqrt(n); df <- n - 1; t <- d / se; q <- qt((1 + level) / 2, df); me <- q * se
  c(d = d, se = se, df = df, t = t, p = 2 * pt(-abs(t), df), q = q, me = me, lo = d - me, hi = d + me)
}
# Band: the difference is significant from me_diff, the intervals stop overlapping from me1 + me2.
band <- function(g1, g2, dd) c(sig_from = unname(dd['me']), apart_from = unname(g1['me'] + g2['me']))

for (level in c(0.90, 0.95, 0.99)) {
  cat(sprintf('\n=== Example of chapter 8: 46 and 52, s = 10, n = 25, level %.2f ===\n', level))
  g1 <- ci1(46, 10, 25, level); g2 <- ci1(52, 10, 25, level)
  dc <- diff2(46, 10, 25, 52, 10, 25, level)
  print(rbind(short = g1, normal = g2), digits = 12)
  print(dc, digits = 12)
  b <- band(g1, g2, dc); print(b, digits = 12)
  # p-value of the classical test when the intervals just touch.
  print(c(p_at_touch = 2 * pt(-b['apart_from'] / dc['se'], dc['df'])), digits = 12)
}

cat('\n=== Unequal groups: short 46, s 15, n 10; normal 52, s 5, n 40; 95 % ===\n')
g1 <- ci1(46, 15, 10, .95); g2 <- ci1(52, 5, 40, .95)
print(rbind(short = g1, normal = g2), digits = 12)
dw <- diff2(46, 15, 10, 52, 5, 40, .95, 'welch'); dc <- diff2(46, 15, 10, 52, 5, 40, .95)
print(rbind(welch = dw, classical = dc), digits = 12)
print(rbind(welch = band(g1, g2, dw), classical = band(g1, g2, dc)), digits = 12)
# Welch through t.test on data with exactly these summaries.
mk <- function(m, s, n) { z <- scale(seq_len(n))[, 1]; m + s * z }
tt <- t.test(mk(52, 5, 40), mk(46, 15, 10), var.equal = FALSE)
print(c(t = unname(tt$statistic), df = unname(tt$parameter), p = tt$p.value, lo = tt$conf.int[1], hi = tt$conf.int[2]), digits = 12)
# Excel quantile for a non-integer df: =ODMOCNINA(v*(1-BETA.INV(a;v/2;0,5))/BETA.INV(a;v/2;0,5)).
v <- unname(dw['df']); x <- qbeta(0.05, v / 2, 0.5)
print(c(beta_inv_quantile = sqrt(v * (1 - x) / x), qt = qt(.975, v)), digits = 12)

cat('\n=== Paired data of variant A, 95 % ===\n')
normal <- c(58, 44, 51, 39, 62, 47, 55, 42, 49, 60, 45, 52)
short  <- c(53, 42, 45, 38, 55, 44, 51, 43, 44, 58, 39, 50)
print(c(m_short = mean(short), m_normal = mean(normal), s_short = sd(short), s_normal = sd(normal), sD = sd(normal - short)), digits = 12)
g1 <- ci1(mean(short), sd(short), 12, .95); g2 <- ci1(mean(normal), sd(normal), 12, .95)
print(rbind(short = g1, normal = g2), digits = 12)
dp <- paired(mean(short), mean(normal), sd(normal - short), 12, .95); print(dp, digits = 12)
print(band(g1, g2, dp), digits = 12)
tp <- t.test(normal, short, paired = TRUE); print(c(lo = tp$conf.int[1], hi = tp$conf.int[2], p = tp$p.value), digits = 12)
# Admissible range of sD and the paired interval at both ends.
lim <- c(lo = abs(sd(normal) - sd(short)), hi = sd(normal) + sd(short)); print(lim, digits = 12)
print(rbind(at_min = paired(mean(short), mean(normal), lim['lo'], 12, .95),
            at_max = paired(mean(short), mean(normal), lim['hi'], 12, .95)), digits = 12)

cat('\n=== Classical test, larger group more variable: short 46, s 5, n 10; normal 55, s 15, n 40; 95 % ===\n')
# The pooled variance overestimates the standard error here, so the intervals may be apart
# while the classical test is not significant; Welch is significant.
g1 <- ci1(46, 5, 10, .95); g2 <- ci1(55, 15, 40, .95)
print(rbind(short = g1, normal = g2), digits = 12)
dc <- diff2(46, 5, 10, 55, 15, 40, .95); dw <- diff2(46, 5, 10, 55, 15, 40, .95, 'welch')
print(rbind(classical = dc, welch = dw), digits = 12)
print(rbind(classical = band(g1, g2, dc), welch = band(g1, g2, dw)), digits = 12)
