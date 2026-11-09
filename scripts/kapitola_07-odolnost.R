# Robustness of the one-sample t procedures to non-normal populations (chapter 7, optional extension).
# Base R only; run from the project root: Rscript scripts/kapitola_07-odolnost.R
# Results are printed and written to tmp/kapitola_07-odolnost.csv (internal, not published).
# Population shapes follow the four types in Wilcox (2017, sec. 4.6 and 5.5); the numbers are our own simulation.
ch7r_reps <- 100000
ch7r_n <- c(10, 25, 50, 100)
# Each population: generator r(k), exact mean mu, standard deviation sigma and the SD of the
# population without the 10 % of extreme values (core; equal to sigma where there are no extremes).
ch7r_pop <- list(
  normalni = list(label = 'Normální', mu = 0, sigma = 1, core = 1, r = function(k) rnorm(k)),
  omezena = list(label = 'Souměrná, omezená (rovnoměrná)', mu = 0, sigma = 1, core = 1,
    r = function(k) runif(k, -sqrt(3), sqrt(3))),
  tezke = list(label = 'Souměrná s těžkými chvosty (10 % extrémů)', mu = 0, sigma = sqrt(.9 + .1 * 100), core = 1,
    r = function(k) rnorm(k, 0, ifelse(runif(k) < .1, 10, 1))),
  mirne = list(label = 'Mírně zešikmená (šikmost 0,7)', mu = 8, sigma = sqrt(8), core = sqrt(8),
    r = function(k) rgamma(k, shape = 8)),
  exponencialni = list(label = 'Zešikmená (šikmost 2)', mu = 1, sigma = 1, core = 1, r = function(k) rexp(k)),
  vyrazne = list(label = 'Výrazně zešikmená (šikmost 6)', mu = exp(.5), sigma = sqrt((exp(1) - 1) * exp(1)), core = sqrt((exp(1) - 1) * exp(1)),
    r = function(k) rlnorm(k)),
  sikma_tezke = list(label = 'Zešikmená s těžkými chvosty (10 % extrémů)',
    mu = exp(.5) * (.9 + .1 * 10),
    sigma = sqrt(exp(2) * (.9 + .1 * 100) - (exp(.5) * (.9 + .1 * 10))^2),
    core = sqrt((exp(1) - 1) * exp(1)),
    r = function(k) rlnorm(k) * ifelse(runif(k) < .1, 10, 1))
)
# Simulate m and s for many samples in chunks to limit memory.
ch7r_ms <- function(pop, n, reps, chunk = 20000) {
  m <- s <- numeric(0)
  for (i in seq_len(ceiling(reps / chunk))) {
    k <- min(chunk, reps - (i - 1) * chunk)
    x <- matrix(pop$r(k * n), k)
    m <- c(m, rowMeans(x)); s <- c(s, sqrt(rowSums((x - rowMeans(x))^2) / (n - 1)))
  }
  list(m = m, s = s)
}
set.seed(20261109)
ch7r_res <- do.call(rbind, lapply(names(ch7r_pop), function(id) {
  pop <- ch7r_pop[[id]]
  do.call(rbind, lapply(ch7r_n, function(n) {
    d <- ch7r_ms(pop, n, ch7r_reps); se <- d$s / sqrt(n)
    t0 <- (d$m - pop$mu) / se
    q2 <- qt(.975, n - 1); q1 <- qt(.95, n - 1)
    # Upward shift of half the SD of the population without extremes: the same effect for most people.
    t_shift <- (d$m + .5 * pop$core - pop$mu) / se
    data.frame(populace = id, popis = pop$label, n = n,
      pokryti95 = mean(abs(t0) < q2),
      minuly_nad = mean(t0 <= -q2), minuly_pod = mean(t0 >= q2),
      alfa_mensi = mean(t0 <= -q1), alfa_vetsi = mean(t0 >= q1),
      sila_05core = mean(abs(t_shift) >= q2),
      sirka_rel = mean(2 * q2 * se) / (2 * qnorm(.975) * pop$sigma / sqrt(n)))
  }))
}))
# Wilcox's power illustration (sec. 5.5): shift 0.8 on the raw scale, n = 20, two-sided alpha 0.05.
set.seed(20261110)
ch7r_power_raw <- sapply(c('normalni', 'tezke'), function(id) {
  d <- ch7r_ms(ch7r_pop[[id]], 20, ch7r_reps)
  mean(abs((d$m + .8) / (d$s / sqrt(20))) >= qt(.975, 19))
})
# Wilcox's actual Type I error rates for the mixed normal (n = 20 and 100) and lognormal (n = 20 and 160).
set.seed(20261111)
ch7r_check <- do.call(rbind, lapply(list(c('tezke', 20), c('tezke', 100), c('vyrazne', 20), c('vyrazne', 160)), function(a) {
  pop <- ch7r_pop[[a[1]]]; n <- as.integer(a[2]); d <- ch7r_ms(pop, n, ch7r_reps)
  t0 <- (d$m - pop$mu) / (d$s / sqrt(n))
  data.frame(populace = a[1], n = n, alfa2 = mean(abs(t0) >= qt(.975, n - 1)),
    alfa_mensi = mean(t0 <= qt(.05, n - 1)), alfa_vetsi = mean(t0 >= qt(.95, n - 1)))
}))
dir.create('tmp', showWarnings = FALSE)
write.csv(ch7r_res, 'tmp/kapitola_07-odolnost.csv', row.names = FALSE)
options(width = 200)
print(ch7r_res[, -2], digits = 3)
cat('\nWilcox power check (shift 0.8, n = 20): normal', round(ch7r_power_raw[1], 3),
    ' heavy tails', round(ch7r_power_raw[2], 3), '\n')
print(ch7r_check, digits = 3)
cat('Monte Carlo SE of a proportion near 0.05 with', ch7r_reps, 'replications:',
    round(sqrt(.05 * .95 / ch7r_reps), 4), '\n')
