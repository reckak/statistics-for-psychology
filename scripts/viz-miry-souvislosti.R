# Reference values for the visualization quarto/viz_miry_souvislosti.qmd (chapter 9).
# Base R only; run from the project root: Rscript --vanilla scripts/viz-miry-souvislosti.R
# Prints the values used by quarto/_verification/check-html.cjs and quoted in the page text:
# risks, their difference, risk ratio, odds, odds ratio, chi-square and phi for a 2 x 2 table
# (first row = compared group, second row = reference group; first column = event),
# the lines of equal difference, equal risk ratio and equal odds ratio, and the proportions
# in a retrospective sample that keeps only a share of the people without the event.
options(width = 200)

measures <- function(a, b, c, d) {
  n1 <- a + b; n0 <- c + d; n <- n1 + n0
  p1 <- a / n1; p0 <- c / n0
  chi2 <- n * (a * d - b * c)^2 / (n1 * n0 * (a + c) * (b + d))
  c(p1 = p1, p0 = p0, diff = p1 - p0, rr = p1 / p0, odds1 = a / b, odds0 = c / d, or = (a / b) / (c / d),
    n = n, chi2 = chi2, phi = (a * d - b * c) / sqrt(n1 * n0 * (a + c) * (b + d)),
    col1 = a / (a + c), col2 = b / (b + d), coldiff = a / (a + c) - b / (b + d))
}
show <- function(title, a, b, c, d) {
  m <- measures(a, b, c, d)
  cat(sprintf('\n=== %s: %g, %g / %g, %g ===\n', title, a, b, c, d)); print(m, digits = 12)
  # Independent checks: chi-square against chisq.test, phi squared as the product of two differences.
  ct <- suppressWarnings(chisq.test(matrix(c(a, c, b, d), 2), correct = FALSE))
  stopifnot(isTRUE(all.equal(unname(ct$statistic), unname(m['chi2']))),
    isTRUE(all.equal(unname(m['phi']^2), unname(m['diff'] * m['coldiff']))),
    isTRUE(all.equal(unname(m['phi']^2), unname(m['chi2'] / m['n']))))
  invisible(m)
}

d <- show('Daniels: sexualized (compared) vs sports performance (reference)', 56, 84, 20, 97)
show('Daniels with the groups swapped', 20, 97, 56, 84)
show('Aspirin study: placebo (compared) vs aspirin (reference)', 189, 10845, 104, 10933)
show('Exercise 10: symptoms vs no symptoms', 19, 74, 22, 187)
show('Two risks 40 % and 17 % in groups of 100', 40, 60, 17, 83)
show('Two risks 1,7 % and 0,9 % in groups of 1000', 17, 983, 9, 991)

# Lines through the current point: the risk in the compared group for another risk in the reference group.
same <- function(p0, p1, x) {
  rr <- p1 / p0; or <- (p1 / (1 - p1)) / (p0 / (1 - p0))
  cbind(x = x, same_diff = x + (p1 - p0), same_rr = rr * x, same_or = or * x / (1 - x + or * x))
}
cat('\n=== Lines of equal measures through the Daniels point (0,171; 0,400) ===\n')
print(same(20 / 117, 56 / 140, c(0.01, 0.05, 0.171, 0.3, 0.5, 0.7, 0.9)), digits = 10)
cat('\n=== Measures along the line of equal odds ratio 3,2333 ===\n')
or <- unname(d['or'])
for (x in c(0.01, 0.05, 0.3, 0.5, 0.7, 0.9)) { y <- or * x / (1 - x + or * x)
  cat(sprintf('reference %.2f: compared %.6f, difference %.6f, risk ratio %.6f\n', x, y, y - x, y / x)) }
cat('\n=== Lines through the point 0,30 and 0,50 (odds ratio 2,3333) ===\n')
print(same(0.3, 0.5, c(0.01, 0.1, 0.5, 0.8)), digits = 10)

# Retrospective sample: all people with the event, a share k of the people without it.
retro <- function(a, b, c, d, k) { s1 <- a / (a + k * b); s0 <- c / (c + k * d)
  c(k = k, share1 = s1, share0 = s0, ratio = s1 / s0, or = (a / (k * b)) / (c / (k * d))) }
cat('\n=== Retrospective sample from the Daniels table ===\n')
print(t(sapply(c(1, 0.5, 0.2, 0.1), function(k) retro(56, 84, 20, 97, k))), digits = 10)
cat('\n=== Retrospective sample from the aspirin table ===\n')
print(t(sapply(c(1, 0.5, 0.1), function(k) retro(189, 10845, 104, 10933, k))), digits = 10)
