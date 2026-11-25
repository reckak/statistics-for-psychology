# Reference values for the visualization quarto/viz_interval_podilu.qmd (chapter 9).
# Base R only; run from the project root: Rscript --vanilla scripts/viz-interval-podilu.R
# Prints the values used by quarto/_verification/check-html.cjs and quoted in the page text:
# Wald and Wilson limits, the roots of the quadratic from the derivation (they equal the Wilson limits),
# the exact coverage of both intervals as a function of pi (binomial sums, no simulation),
# the probability that the Wald interval reaches outside [0, 1] or has zero width,
# and the mean and minimum coverage over the grid of pi used by the page.
options(width = 200)

zq <- function(level) qnorm(1 - (1 - level) / 2)
wald <- function(x, n, z) { p <- x / n; se <- sqrt(p * (1 - p) / n); c(p = p, se = se, lo = p - z * se, hi = p + z * se) }
wilson <- function(x, n, z) {
  p <- x / n; mid <- (p + z^2 / (2 * n)) / (1 + z^2 / n); half <- z / (1 + z^2 / n) * sqrt(p * (1 - p) / n + z^2 / (4 * n^2))
  c(p = p, mid = mid, half = half, lo = mid - half, hi = mid + half)
}
roots <- function(x, n, z) {
  p <- x / n; A <- 1 + z^2 / n; B <- -(2 * p + z^2 / n); C <- p^2; D <- B^2 - 4 * A * C
  c(lo = (-B - sqrt(D)) / (2 * A), hi = (-B + sqrt(D)) / (2 * A))
}
# Coverage at pi: the same definitions as ch9_cover in scripts/kapitola_09.R (Wilson with a tolerance of 1e-12).
cover <- function(n, pi, level) {
  z <- zq(level); x <- 0:n
  wa <- t(sapply(x, wald, n = n, z = z)); wi <- t(sapply(x, wilson, n = n, z = z))
  bad <- wa[, 'lo'] < -1e-12 | wa[, 'hi'] > 1 + 1e-12 | x == 0 | x == n
  t(sapply(pi, function(p) { pr <- dbinom(x, n, p)
    c(pi = p, wald = sum(pr[wa[, 'lo'] <= p & p <= wa[, 'hi']]), wilson = sum(pr[wi[, 'lo'] - 1e-12 <= p & p <= wi[, 'hi'] + 1e-12]),
      outside = sum(pr[bad])) }))
}
# Summary over the grid of the page: pi from 0,001 to 0,999 by 0,001 (mean, minimum, share below the level).
grid <- seq(0.001, 0.999, by = 0.001)
summary_cover <- function(n, level) {
  cv <- cover(n, grid, level)
  c(n = n, level = level, mean_wald = mean(cv[, 'wald']), mean_wilson = mean(cv[, 'wilson']),
    min_wald = min(cv[, 'wald']), min_wilson = min(cv[, 'wilson']),
    below_wald = mean(cv[, 'wald'] < level - 1e-12), below_wilson = mean(cv[, 'wilson'] < level - 1e-12))
}

cat('=== Limits (x, n, level): Wald p, se, lo, hi | Wilson mid, half, lo, hi | roots lo, hi ===\n')
cases <- list(c(10, 20, .95), c(0, 15, .95), c(1, 25, .95), c(0, 25, .95), c(40, 80, .95), c(20, 20, .95),
  c(1, 1, .95), c(0, 1, .95), c(10, 20, .5), c(10, 20, .8), c(10, 20, .99), c(3, 200, .9), c(199, 200, .99))
for (k in cases) {
  z <- zq(k[3]); w <- wald(k[1], k[2], z); s <- wilson(k[1], k[2], z); r <- roots(k[1], k[2], z)
  stopifnot(isTRUE(all.equal(unname(r), unname(s[c('lo', 'hi')]))))
  cat(sprintf('%3d z %3d, %.2f: z = %.12f | Wald %.12f %.12f %.12f %.12f | Wilson %.12f %.12f %.12f %.12f\n',
    k[1], k[2], k[3], z, w['p'], w['se'], w['lo'], w['hi'], s['mid'], s['half'], s['lo'], s['hi']))
}

cat('\n=== Coverage at single pi (n, level, pi): Wald, Wilson, Wald outside [0, 1] or zero width ===\n')
pts <- list(c(20, .95, .05), c(20, .95, .10), c(20, .95, .25), c(20, .95, .5), c(10, .95, .2), c(50, .95, .02),
  c(100, .95, .5), c(200, .95, .01), c(15, .95, .1), c(25, .95, .04), c(20, .8, .3), c(20, .99, .3), c(1, .95, .5), c(10, .5, .37))
for (k in pts) { v <- cover(k[1], k[3], k[2]); cat(sprintf('n = %3d, %.2f, pi = %.3f: %.12f %.12f %.12f\n', k[1], k[2], k[3], v[1, 'wald'], v[1, 'wilson'], v[1, 'outside'])) }

cat('\n=== Summary over pi = 0,001 ... 0,999 (mean, minimum, share below the level) ===\n')
summ <- t(sapply(list(c(10, .95), c(15, .95), c(20, .95), c(25, .95), c(50, .95), c(80, .95), c(100, .95), c(200, .95),
  c(20, .8), c(20, .99), c(20, .5)), function(k) summary_cover(k[1], k[2])))
print(summ, digits = 10)

cat('\n=== Chapter figure grid (pi = 0,01 ... 0,99 by 0,002), for comparison with the chapter text ===\n')
cg <- seq(.01, .99, by = .002)
for (n in c(10, 20, 50, 100)) { cv <- cover(n, cg, .95)
  cat(sprintf('n = %3d: min Wilson %.4f at %.3f, mean Wilson %.4f, mean Wald %.4f\n', n, min(cv[, 'wilson']), cg[which.min(cv[, 'wilson'])], mean(cv[, 'wilson']), mean(cv[, 'wald']))) }
cv <- cover(10, grid, .95); cat(sprintf('n = 10, fine grid: min Wilson %.4f at %.3f\n', min(cv[, 'wilson']), grid[which.min(cv[, 'wilson'])]))

# The coverage jumps at the interval limits, so a grid can miss its narrow dips. The page also evaluates
# just below and above every limit inside (0, 1); the lowest of these values is the infimum over pi.
infimum <- function(n, level) {
  z <- zq(level); x <- 0:n
  lim <- c(t(sapply(x, wald, n = n, z = z))[, c('lo', 'hi')], t(sapply(x, wilson, n = n, z = z))[, c('lo', 'hi')])
  lim <- lim[lim > 1e-9 & lim < 1 - 1e-9]
  p <- sort(unique(c(grid, lim - 1e-9, lim + 1e-9)))
  cv <- cover(n, p, level)
  c(n = n, level = level, inf_wald = min(cv[, 'wald']), at_wald = p[which.min(cv[, 'wald'])],
    inf_wilson = min(cv[, 'wilson']), at_wilson = p[which.min(cv[, 'wilson'])])
}
cat('\n=== Infimum of the coverage including the points next to the limits ===\n')
print(t(sapply(list(c(10, .95), c(20, .95), c(50, .95), c(100, .95), c(200, .95), c(20, .8), c(1, .95)), function(k) infimum(k[1], k[2]))), digits = 10)

# Bars for pi = 0,05 and n = 20: which counts x have an interval containing pi.
cat('\n=== n = 20, pi = 0,05: counts whose interval contains pi ===\n')
z <- zq(.95); x <- 0:20
wa <- t(sapply(x, wald, n = 20, z = z)); wi <- t(sapply(x, wilson, n = 20, z = z))
cat('Wald:  ', x[wa[, 'lo'] <= .05 & .05 <= wa[, 'hi']], '\n')
cat('Wilson:', x[wi[, 'lo'] <= .05 & .05 <= wi[, 'hi']], '\n')
print(round(dbinom(0:4, 20, .05), 6))
