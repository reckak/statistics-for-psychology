# Reference values for the visualization quarto/viz_korelace.qmd (chapter 10).
# Base R only; run from the project root: Rscript --vanilla scripts/viz-korelace.R
# Prints the data sets built into the page and the values used by quarto/_verification/check-html.cjs
# and quoted in the page text: means, standard deviations, covariance, Pearson r, Spearman r_s,
# r squared, regression line of Y on X, residual sum of squares, t test of zero correlation,
# Fisher 95% interval, shares of points inside the probability ellipses, the empirical
# transformation to an exact sample r and the distance of the two circles of the Venn diagram.
options(width = 200, digits = 12)

# Data built into the page. Anxiety and performance of 40 students: authored model of chapter 10
# (scripts/kapitola_10.R, seed 1010); paired sleep study of chapter 8 (12 complete pairs);
# Anscombe's quartet (datasets::anscombe).
uz_x <- c(26,20,33,28,23,33,37,11,21,22,24,20,16,25,29,20,20,26,19,19,26,29,19,28,21,29,23,19,23,14,19,37,24,27,19,27,23,23,22,19)
uz_y <- c(16,22,14,20,16,15,15,21,21,25,26,17,17,17,16,19,24,24,20,27,25,19,24,15,22,8,21,19,15,23,23,12,15,22,19,7,18,18,19,30)
k8_x <- c(58,44,51,39,62,47,55,42,49,60,45,52)
k8_y <- c(53,42,45,38,55,44,51,43,44,58,39,50)
# The page must hold the same data as the chapter scripts.
local({
  Sys.setenv(CH10_NOFIG = '1'); old <- options()
  # The chapter script assigns some data sets with <<-, so it is sourced into the global environment.
  source('scripts/kapitola_10.R', encoding = 'UTF-8')
  stopifnot(identical(as.numeric(ch10_uz$uzkost), uz_x), identical(as.numeric(ch10_uz$vykon), uz_y),
    identical(as.numeric(ch10_k8$bezny), k8_x), identical(as.numeric(ch10_k8$kratky), k8_y))
  options(old)
})

ellipse_c <- function(p) sqrt(qchisq(p, 2))   # radius in standardized, decorrelated units
stats <- function(x, y) {
  n <- length(x); mx <- mean(x); my <- mean(y); sx <- sd(x); sy <- sd(y)
  sxy <- sum((x - mx) * (y - my)) / (n - 1); r <- sxy / (sx * sy)
  rs <- cor(rank(x), rank(y)); b1 <- r * sy / sx; b0 <- my - b1 * mx
  ssres <- sum((y - b0 - b1 * x)^2); sstot <- sum((y - my)^2)
  ct <- cor.test(x, y); tt <- unname(ct$statistic)
  z <- atanh(r); se <- 1 / sqrt(n - 3); q <- qnorm(0.975)
  # Independent checks: lm, cor.test and cor(method = 'spearman').
  fit <- lm(y ~ x)
  stopifnot(isTRUE(all.equal(unname(coef(fit)), c(b0, b1))), isTRUE(all.equal(sum(resid(fit)^2), ssres)),
    isTRUE(all.equal(ssres, (1 - r^2) * sstot)), isTRUE(all.equal(rs, cor(x, y, method = 'spearman'))),
    isTRUE(all.equal(tanh(z + c(-1, 1) * q * se), unname(ct$conf.int[1:2]))))
  zx <- (x - mx) / sx; zy <- (y - my) / sy; d2 <- (zx^2 - 2 * r * zx * zy + zy^2) / (1 - r^2)
  inside <- sapply(c(0.5, 0.8, 0.95, 0.99), function(p) sum(d2 <= qchisq(p, 2)))
  c(n = n, mx = mx, my = my, sx = sx, sy = sy, sxy = sxy, sumprod = sxy * (n - 1), pos = sum((x - mx) * (y - my) > 0),
    neg = sum((x - mx) * (y - my) < 0), r = r, rs = rs, r2 = r^2, b0 = b0, b1 = b1, ssres = ssres, sstot = sstot,
    t = tt, df = n - 2, p = ct$p.value, zr = z, se = se, zlo = z - q * se, zhi = z + q * se, lo = tanh(z - q * se), hi = tanh(z + q * se),
    in50 = inside[1], in80 = inside[2], in95 = inside[3], in99 = inside[4])
}
show <- function(title, x, y) { cat(sprintf('\n=== %s ===\n', title)); s <- stats(x, y); print(s); invisible(s) }

show('Anxiety and performance, 40 students', uz_x, uz_y)
show('Sleep study of chapter 8: normal (X) and short (Y) sleep', k8_x, k8_y)
for (i in 1:4) show(sprintf('Anscombe %s', as.roman(i)), anscombe[[paste0('x', i)]], anscombe[[paste0('y', i)]])
cat('\nAnscombe x1..x4 and y1..y4:\n'); print(anscombe)
# Chapter 10, section on outliers: one typing error 300 in the performance of the first student.
o <- uz_y; o[1] <- 300; show('Anxiety and performance with performance 300 for the first student', uz_x, o)
show('Fixed test points', c(1, 2, 3, 4, 5, 6), c(2, 1, 4, 3, 7, 5))
# Exercise 2 of the page: one student added against the direction of the relationship, then moved further.
for (p in list(c(38, 31), c(38.5, 32), c(60, 31))) show(sprintf('Anxiety data with an added student (%g; %g)', p[1], p[2]), c(uz_x, p[1]), c(uz_y, p[2]))

# Axis ranges of the page: m +- K s with the same K on both axes (farthest z-score of both variables, times 1.08).
k_axes <- max(abs(scale(uz_x)), abs(scale(uz_y))) * 1.08
cat(sprintf('\nAxis ranges of the default data: K = %.6f, X %.6f to %.6f, Y %.6f to %.6f\n', k_axes,
  mean(uz_x) - k_axes * sd(uz_x), mean(uz_x) + k_axes * sd(uz_x), mean(uz_y) - k_axes * sd(uz_y), mean(uz_y) + k_axes * sd(uz_y)))

# Length and width of the ellipse: eigenvectors of the correlation matrix (directions in z-scores),
# half-lengths c * sqrt(eigenvalue) with the radius c of the 99% ellipse; end points in data units.
ellipse_axes <- function(x, y) {
  e <- eigen(cor(cbind(x, y)), symmetric = TRUE); c99 <- ellipse_c(0.99)
  ends <- lapply(1:2, function(j) { u <- e$vectors[, j] * c99 * sqrt(e$values[j])
    rbind(c(mean(x), mean(y)) - u * c(sd(x), sd(y)), c(mean(x), mean(y)) + u * c(sd(x), sd(y))) })
  # Every end point lies on the 99% ellipse (squared Mahalanobis distance = qchisq(0.99, 2)).
  for (m in ends) stopifnot(isTRUE(all.equal(unname(mahalanobis(m, c(mean(x), mean(y)), cov(cbind(x, y)))), rep(qchisq(0.99, 2), 2))))
  list(half = c99 * sqrt(e$values), ratio = sqrt(e$values[1] / e$values[2]), length = ends[[1]], width = ends[[2]])
}
cat('\n=== Length (first row pair) and width of the ellipse for the default data ===\n')
print(ellipse_axes(uz_x, uz_y), digits = 12)

cat('\n=== Radii of the probability ellipses sqrt(qchisq(p, 2)) = sqrt(-2 ln(1 - p)) ===\n')
print(sapply(c(0.5, 0.8, 0.95, 0.99), ellipse_c))
stopifnot(isTRUE(all.equal(sapply(c(0.5, 0.8, 0.95, 0.99), ellipse_c), sqrt(-2 * log(1 - c(0.5, 0.8, 0.95, 0.99))))))

# Empirical transformation: X stays, Y keeps its mean and SD and gets exactly the sample r.
to_r <- function(x, y, target) {
  zx <- (x - mean(x)) / sd(x); zy <- (y - mean(y)) / sd(y)
  e <- zy - cor(x, y) * zx; e <- e / sd(e)
  mean(y) + sd(y) * (target * zx + sqrt(1 - target^2) * e)
}
cat('\n=== Anxiety data transformed to r = 0,3 and r = -0,8 ===\n')
for (target in c(0.3, -0.8)) { y2 <- to_r(uz_x, uz_y, target)
  stopifnot(isTRUE(all.equal(cor(uz_x, y2), target)), isTRUE(all.equal(mean(y2), mean(uz_y))), isTRUE(all.equal(sd(y2), sd(uz_y))))
  cat(sprintf('target %.1f: first three y %s; rs %.10f\n', target, paste(sprintf('%.10f', y2[1:3]), collapse = ', '), cor(rank(uz_x), rank(y2)))) }

# Venn diagram: two circles of radius 1 whose overlap is the share f of the area of one circle.
lens <- function(d) 2 * acos(d / 2) - d / 2 * sqrt(4 - d^2)
venn_d <- function(f) if (f <= 0) 2 else if (f >= 1) 0 else uniroot(function(d) lens(d) / pi - f, c(0, 2), tol = 1e-13)$root
cat('\n=== Distance of the centres (radius 1) for overlap r^2 ===\n')
print(sapply(c(0.1, 0.2738645, 0.5, 0.9), venn_d))
