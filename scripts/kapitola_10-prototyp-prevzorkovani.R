# Prototype inputs and reference results for chapter 10 resampling in Excel.
# Fictitious data; fixed seed; no packages. Feasibility check only, not the
# student workbook generator. Usage (output directory must exist):
#   Rscript --vanilla scripts/kapitola_10-prototyp-prevzorkovani.R tmp/prototyp-10
# then build the Excel prototype with kapitola_10-prototyp-prevzorkovani.ps1.
args <- commandArgs(trailingOnly = TRUE)
out <- if (length(args)) args[1] else "."
set.seed(20261109)

# --- n = 30: perceived stress (0-16) and sleep quality (1-7), many ties
n <- 30
latent <- rnorm(n)
stress <- pmin(16, pmax(0, round(8 + 3 * latent + rnorm(n, 0, 2))))
sleep  <- pmin(7, pmax(1, round(4 - 0.9 * latent + rnorm(n, 0, 1.1))))
d30 <- data.frame(id = 1:n, stress = stress, sleep = sleep)

# --- n = 6: small hand example
d6 <- data.frame(id = 1:6, x = c(12, 15, 9, 20, 15, 7), y = c(5, 4, 6, 2, 3, 6))

tau_b <- function(x, y) {
  s <- sign(outer(x, x, "-")) * sign(outer(y, y, "-"))
  S <- sum(s) / 2
  n0 <- length(x) * (length(x) - 1) / 2
  tx <- (sum(outer(x, x, "==")) - length(x)) / 2
  ty <- (sum(outer(y, y, "==")) - length(y)) / 2
  den <- sqrt((n0 - tx) * (n0 - ty))
  if (den == 0) NA_real_ else S / den
}
r_s <- function(x, y) {
  rx <- rank(x); ry <- rank(y)
  if (sd(rx) == 0 || sd(ry) == 0) NA_real_ else cor(rx, ry)
}
stopifnot(abs(tau_b(d30$stress, d30$sleep) - cor(d30$stress, d30$sleep, method = "kendall")) < 1e-12)

make <- function(B) {
  boot <- t(replicate(B, sample.int(n, n, replace = TRUE)))
  perm <- t(replicate(B, sample.int(n, n)))
  list(boot = boot, perm = perm)
}
B <- 9999
ix <- make(B)
write.csv(d30, file.path(out, "data30.csv"), row.names = FALSE)
write.csv(d6, file.path(out, "data6.csv"), row.names = FALSE)
write.table(ix$boot, file.path(out, "boot_idx.csv"), sep = ",", row.names = FALSE, col.names = FALSE)
write.table(ix$perm, file.path(out, "perm_idx.csv"), sep = ",", row.names = FALSE, col.names = FALSE)

# all 720 permutations of 6
perms <- function(v) if (length(v) == 1) matrix(v, 1) else do.call(rbind, lapply(seq_along(v), function(i) cbind(v[i], perms(v[-i]))))
p6 <- perms(1:6)
write.table(p6, file.path(out, "perm6_idx.csv"), sep = ",", row.names = FALSE, col.names = FALSE)

x <- d30$stress; y <- d30$sleep
obs <- c(rs = r_s(x, y), tb = tau_b(x, y))
res <- function(Buse) {
  bt <- t(apply(ix$boot[1:Buse, , drop = FALSE], 1, function(i) c(r_s(x[i], y[i]), tau_b(x[i], y[i]))))
  pm <- t(apply(ix$perm[1:Buse, , drop = FALSE], 1, function(i) c(r_s(x, y[i]), tau_b(x, y[i]))))
  q <- function(v) quantile(v, c(0.025, 0.975), type = 7, na.rm = TRUE)  # = PERCENTIL.INC
  pp <- function(v, o) (sum(abs(v) >= abs(o) - 1e-12) + 1) / (length(v) + 1)
  c(B = Buse,
    rs_lo = q(bt[, 1])[[1]], rs_hi = q(bt[, 1])[[2]], rs_na = sum(is.na(bt[, 1])),
    tb_lo = q(bt[, 2])[[1]], tb_hi = q(bt[, 2])[[2]], tb_na = sum(is.na(bt[, 2])),
    rs_p = pp(pm[, 1], obs[["rs"]]), tb_p = pp(pm[, 2], obs[["tb"]]))
}
cat("observed: r_s =", obs[["rs"]], " tau_b =", obs[["tb"]], " pearson =", cor(x, y), "\n")
cat("ties: stress distinct =", length(unique(x)), " sleep distinct =", length(unique(y)), "\n")
print(rbind(res(1999), res(9999)), digits = 7)
cat("cor.test kendall p (normal approx):", suppressWarnings(cor.test(x, y, method = "kendall", exact = FALSE)$p.value), "\n")

x6 <- d6$x; y6 <- d6$y
o6 <- c(rs = r_s(x6, y6), tb = tau_b(x6, y6))
pm6 <- t(apply(p6, 1, function(i) c(r_s(x6, y6[i]), tau_b(x6, y6[i]))))
cat("n=6 observed: r_s =", o6[["rs"]], " tau_b =", o6[["tb"]], "\n")
cat("n=6 exact p: r_s =", mean(abs(pm6[, 1]) >= abs(o6[["rs"]]) - 1e-12),
    " tau_b =", mean(abs(pm6[, 2]) >= abs(o6[["tb"]]) - 1e-12), "\n")
