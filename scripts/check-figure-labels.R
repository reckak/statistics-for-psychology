# Calibration check of scripts/figure-labels.R (R89): the fl_* functions must place labels
# exactly where text(), title(), mtext(), axis() and legend() do. Each case is drawn twice on
# the svg() device, by the base function and by the fl_* function forced to draw segment by
# segment (options(fl.force = TRUE)); glyph origins in both SVG files must agree to 0.01 px,
# in a single plot and in a two-panel layout with cex 0.75.
# Run from the project root: Rscript --vanilla scripts/check-figure-labels.R
if (.Platform$OS.type == 'windows') invisible(Sys.setlocale('LC_CTYPE', '.UTF-8'))
source('scripts/figure-labels.R', encoding = 'UTF-8')
out <- tempfile('fl-check-'); dir.create(out)
glyphs <- function(f) {
  l <- readLines(f, warn = FALSE); l <- l[grepl('<use xlink:href="#glyph', l)]
  cbind(x = as.numeric(sub('.* x="([-0-9.]+)".*', '\\1', l)), y = as.numeric(sub('.* y="([-0-9.]+)".*', '\\1', l)))
}
setup <- function(cex = .9, mfrow = NULL) {
  par(mar = c(4.5, 4.5, 3.6, 3), mgp = c(2.7, .7, 0), las = 1, cex = cex)
  if (!is.null(mfrow)) par(mfrow = mfrow, mar = c(4.2, 4.4, 3.6, .8), mgp = c(2.4, .6, 0))
  plot(0:10, 0:10, type = 'n', axes = FALSE, xlab = '', ylab = '')
}
cases <- list(
  text_default = function(f) f$text(5, 5, 'Mgx'),
  text_adj00 = function(f) f$text(5, 5, 'Mgx', adj = c(0, 0)),
  text_adj1_05_cex8 = function(f) f$text(5, 5, 'Mgx', adj = c(1, .5), cex = .8),
  text_adj0 = function(f) f$text(5, 5, 'Mgx', adj = 0, cex = .76),
  text_pos1 = function(f) f$text(5, 5, 'Mgx', pos = 1, cex = .8),
  text_pos2 = function(f) f$text(5, 5, 'Mgx', pos = 2, cex = .8),
  text_pos3 = function(f) f$text(5, 5, 'Mgx', pos = 3, cex = .8, offset = 1),
  text_pos4 = function(f) f$text(5, 5, 'Mgx', pos = 4, cex = .72),
  text_2lines = function(f) f$text(5, 5, 'Mgx\nMgx', cex = .85),
  text_2lines_adj0 = function(f) f$text(5, 5, 'Mgx\nMgx', adj = c(0, 1)),
  text_pos2_2lines = function(f) f$text(5, 5, 'Mgx
Mgx', pos = 2, offset = .8, cex = .85),
  text_pos3_2lines = function(f) f$text(5, 5, 'Mgx
Mgx', pos = 3, cex = .78),
  text_adj05_2lines = function(f) f$text(5, 5, 'Mgx
Mgx', adj = c(0, .5), cex = .85),
  text_bold = function(f) f$text(5, 5, 'Mgx', font = 2, adj = c(.5, 0)),
  main_default = function(f) f$title(main = 'Mgx'),
  main_plain_font = function(f) f$title(main = 'Mgx', font.main = 1, cex.main = .92),
  main_2lines = function(f) f$title(main = 'Mgx\nMgx', cex.main = .95, font.main = 1),
  main_line = function(f) f$title(main = 'Mgx', line = 2.2, cex.main = .98),
  main_2lines_line = function(f) f$title(main = 'Mgx\nMgx', line = .6),
  xlab = function(f) f$title(xlab = 'Mgx'),
  ylab = function(f) f$title(ylab = 'Mgx'),
  xlab_line = function(f) f$title(xlab = 'Mgx', line = 2),
  mtext1 = function(f) f$mtext('Mgx', side = 1, line = 1, at = 3, cex = .8),
  mtext2 = function(f) f$mtext('Mgx', side = 2, line = 1, at = 3, las = 0),
  mtext3 = function(f) f$mtext('Mgx', side = 3, line = .5, adj = 0),
  mtext2_las1 = function(f) f$mtext('Mgx', side = 2, at = 3, line = .5, las = 1, cex = .85),
  mtext4_las1 = function(f) f$mtext('Mgx', side = 4, at = 6, line = 1, las = 1),
  mtext_outer = function(f) { par(oma = c(1.7, 0, 0, 0)); f$mtext('Mgx abc', side = 1, line = .4, outer = TRUE, cex = .78) },
  mtext4 = function(f) f$mtext('Mgx', side = 4, line = 1, las = 0, cex = .85),
  axis1 = function(f) f$axis(1, at = c(2, 5), labels = c('Mgx', 'abc')),
  axis2 = function(f) f$axis(2, at = c(2, 5), labels = c('Mgx', 'abc'), las = 1),
  legend1 = function(f) f$legend('topright', legend = c('Mgx', 'abc def'), fill = c('red', 'blue'), bty = 'n', cex = .8),
  legend_lines = function(f) f$legend('topleft', legend = c('Mgx', 'abc def'), col = 1:2, lwd = 2, lty = 1:2, bty = 'n', cex = .82, title = 'Tt'),
  legend_horiz = function(f) f$legend('topleft', legend = c('Mgx', 'abc def gh'), pch = c(21, 23), bty = 'n', cex = .8, horiz = TRUE),
  legend_ncol = function(f) f$legend('bottomright', legend = c('Mgx', 'abc', 'q', 'longer one'), pch = 16, ncol = 2, bty = 'n')
)
base <- list(text = text, title = title, mtext = mtext, axis = axis, legend = legend)
fl <- list(text = fl_text, title = fl_title, mtext = fl_mtext, axis = fl_axis, legend = fl_legend)
res <- NULL
for (lay in c('single', 'grid')) for (nm in names(cases)) {
  for (which in c('base', 'fl')) {
    f <- file.path(out, paste0('t4-', which, '.svg'))
    svg(f, width = 8, height = 4.5, family = 'sans', bg = 'white')
    if (lay == 'single') setup() else setup(cex = .75, mfrow = c(1, 2))
    options(fl.force = which == 'fl')
    cases[[nm]](if (which == 'base') base else fl)
    options(fl.force = FALSE)
    dev.off()
  }
  a <- glyphs(file.path(out, 't4-base.svg')); b <- glyphs(file.path(out, 't4-fl.svg'))
  d <- if (nrow(a) == nrow(b)) max(abs(a - b)) else NA
  res <- rbind(res, data.frame(layout = lay, case = nm, glyphs = nrow(a), glyphs_fl = nrow(b), max_px = round(d, 3)))
}
# Symbols in the math font: the font must be installed and a label with symbols must draw.
svg(file.path(out, 'symbols.svg'), width = 6, height = 3, family = 'sans'); setup()
fl_check_font()
fl_text(5, 5, '*r*_{*s*} = 0,52; τ_{*b*}; *H*_{0}: μ ≤ 47; *z*²', font = 2); fl_title(main = '*p*-hodnota *t*-testu', xlab = 'Velikost výběru *n*')
invisible(dev.off())
bad <- res[is.na(res$max_px) | res$max_px > .01, ]
if (nrow(bad)) { print(bad, row.names = FALSE); stop('fl_* labels differ from the base functions.') }
cat('Figure labels: ', nrow(res), ' comparisons with the base functions agree to 0.01 px; STIX Two Math available.\n', sep = '')
