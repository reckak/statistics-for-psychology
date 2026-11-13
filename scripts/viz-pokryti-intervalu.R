# Reference values for the visualization quarto/viz_pokryti_intervalu.qmd (chapter 7).
# Base R only; run from the project root: Rscript --vanilla scripts/viz-pokryti-intervalu.R
# Prints (1) exact quantities used by quarto/_verification/check-html.cjs and
# (2) simulated coverage for the skewed populations, which the page describes only by direction.
options(width = 200)

# --- 1. Exact values -------------------------------------------------------
cat('Quantiles\n')
print(c(z975 = qnorm(.975), z95 = qnorm(.95), z995 = qnorm(.995), z90 = qnorm(.90),
  t975_24 = qt(.975, 24), t95_24 = qt(.95, 24), t975_4 = qt(.975, 4), t995_9 = qt(.995, 9)), digits = 15)

# Coverage of the incorrect procedure: s in place of sigma with the z quantile, normal population.
wrong <- function(n, level = .95, side = 'two') {
  a <- 1 - level
  if (side == 'two') 2 * pt(qnorm(1 - a / 2), n - 1) - 1 else pt(qnorm(1 - a), n - 1)
}
cat('\nCoverage of s with z quantile, normal population\n')
print(sapply(c(5, 10, 25, 100), function(n) c(n = n, two = wrong(n), one = wrong(n, side = 'one'),
  two90 = wrong(n, .90), one99 = wrong(n, .99, 'one'))), digits = 15)

# Interval bounds for m = 46, s = 11, sigma = 10, n = 25 at 95 %.
cat('\nBounds for m = 46, s = 11, sigma = 10, n = 25, 95 %\n')
b <- function(q, se) c(lo = 46 - q * se, hi = 46 + q * se)
print(rbind(
  z_two = b(qnorm(.975), 2), z_one = b(qnorm(.95), 2),
  t_two = b(qt(.975, 24), 2.2), t_one = b(qt(.95, 24), 2.2),
  zs_two = b(qnorm(.975), 2.2), zs_one = b(qnorm(.95), 2.2)), digits = 15)

# --- 2. Skewed populations, standardized to mean 0 and SD 1 ----------------
# Same shapes as scripts/kapitola_07-odolnost.R (skewness 0.7, 2, 6) and the shifted lognormal
# with skewness 8 from quarto/viz_vyberove_rozdeleni_prumeru.qmd. A linear change to any mu and
# sigma changes neither skewness nor coverage.
w8 <- uniroot(function(w) (w + 2) * sqrt(w - 1) - 8, c(1 + 1e-9, 50), tol = 1e-14)$root
pops <- list(
  normalni = function(k) rnorm(k),
  mirne = function(k) (rgamma(k, shape = 8) - 8) / sqrt(8),
  zesikmena = function(k) rexp(k) - 1,
  vyrazne = function(k) (rlnorm(k) - exp(.5)) / sqrt((exp(1) - 1) * exp(1)),
  extremne = function(k) (exp(sqrt(log(w8)) * rnorm(k)) - sqrt(w8)) / sqrt(w8 * (w8 - 1))
)
cat('\nSkewness check (1e6 values):\n')
set.seed(1)
print(sapply(pops, function(r) { x <- r(1e6); c(mean = mean(x), sd = sd(x), skew = mean((x - mean(x))^3) / sd(x)^3) }), digits = 3)

reps <- 100000
ms <- function(r, n, chunk = 20000) {
  m <- s <- numeric(0)
  for (i in seq_len(ceiling(reps / chunk))) {
    k <- min(chunk, reps - (i - 1) * chunk)
    x <- matrix(r(k * n), k)
    m <- c(m, rowMeans(x)); s <- c(s, sqrt(rowSums((x - rowMeans(x))^2) / (n - 1)))
  }
  list(m = m, s = s)
}
set.seed(20261113)
res <- do.call(rbind, lapply(names(pops), function(id) do.call(rbind, lapply(c(5, 10, 25, 100), function(n) {
  d <- ms(pops[[id]], n)
  se <- list(z = rep(1 / sqrt(n), reps), t = d$s / sqrt(n), zs = d$s / sqrt(n))
  q2 <- c(z = qnorm(.975), t = qt(.975, n - 1), zs = qnorm(.975))
  q1 <- c(z = qnorm(.95), t = qt(.95, n - 1), zs = qnorm(.95))
  do.call(rbind, lapply(c('z', 't', 'zs'), function(p) data.frame(pop = id, n = n, postup = p,
    two = mean(abs(d$m) < q2[p] * se[[p]]),
    two_miss_below = mean(d$m + q2[p] * se[[p]] <= 0),
    upper = mean(0 <= d$m + q1[p] * se[[p]]),
    lower = mean(d$m - q1[p] * se[[p]] <= 0))))
}))))
cat('\nSimulated coverage at 95 % (', reps, 'samples per row; Monte Carlo SE about 0.0007)\n')
print(res, digits = 3, row.names = FALSE)
