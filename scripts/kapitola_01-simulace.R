# Shared, fixed simulations for figures, workbook and independent checks.
# All scores are fictional; the mechanisms are assumptions, not findings.
chapter01_simulation <- function() {
  set.seed(20261012)
  group <- rep(c('nízká', 'střední', 'vysoká'), each = 100)
  center <- rep(c(30, 50, 70), each = 100)
  support <- data.frame(podpora = group,
    motivace = round(center + rnorm(300, 0, 8), 2),
    uspesnost = round(center + rnorm(300, 0, 8), 2))
  # Independent causes; additional independent influences soften selection.
  intelligence <- rnorm(600)
  motivation <- rnorm(600)
  achievement <- intelligence + motivation + rnorm(600, 0, 0.6)
  selection <- data.frame(inteligence = round(100 + 15 * intelligence, 2),
    motivace = round(50 + 15 * motivation, 2),
    skupina = ifelse(achievement > 1.5, 'jedničkáři', 'ostatní'))
  list(support = support, selection = selection)
}

if (sys.nframe() == 0L) {
  dir.create('tmp/chapter-01-build', recursive = TRUE, showWarnings = FALSE)
  sim <- chapter01_simulation()
  for (name in names(sim)) write.table(sim[[name]],
    file.path('tmp/chapter-01-build', paste0(name, '.csv')),
    sep = ',', row.names = FALSE, quote = FALSE, fileEncoding = 'UTF-8')
}
