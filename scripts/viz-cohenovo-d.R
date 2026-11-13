# Reference values for the visualization quarto/viz_cohenovo_d.qmd (chapter 8).
# Base R only; run from the project root: Rscript --vanilla scripts/viz-cohenovo-d.R
# Two normal populations with equal SD, means d SDs apart. Prints the three indicators
# used by quarto/_verification/check-html.cjs and checks them by independent routes:
# numerical integration of the shared area and simulation of random pairs.
options(width = 200)

d <- c(0, 0.2, 0.47, 0.5, 0.8, 0.95, 1, 1.5, 2)

# Closed forms shown on the page.
above    <- pnorm(d)              # share of group 1 above the mean of group 2
shared   <- 2 * pnorm(-d / 2)     # area shared by both densities
superior <- pnorm(d / sqrt(2))    # P(random member of group 1 > random member of group 2)

# Independent route 1: the shared area as the integral of the lower density.
shared_int <- sapply(d, function(dd)
  integrate(function(x) pmin(dnorm(x), dnorm(x, dd)), -Inf, Inf, rel.tol = 1e-12)$value)

# Independent route 2: simulated random pairs (not exact; agreement within simulation error).
set.seed(20261113)
n <- 1e6
superior_sim <- sapply(d, function(dd) mean(rnorm(n, dd) > rnorm(n)))

cat('Three indicators\n')
print(data.frame(d, above, shared, shared_int, superior, superior_sim), digits = 12)
stopifnot(abs(shared - shared_int) < 1e-9, abs(superior - superior_sim) < 0.003)

# Values used in the tasks and the "what to notice" section of the page.
cat('\nd for which the probability for a random pair is 0.75\n')
print(sqrt(2) * qnorm(0.75), digits = 12)
cat('\nDifference of means in original units\n')
print(c(d05_sd10 = 0.5 * 10, d047_sd146 = 0.47 * 14.6, d02_sd15 = 0.2 * 15), digits = 12)
