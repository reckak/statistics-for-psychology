# Reproducible chapter figure. Base R only, run from the project root.
# Schematic illustration: dot positions are fixed, no data are analysed.
out <- 'assets/chapter-01/plots'
dir.create(out, recursive = TRUE, showWarnings = FALSE)
ink <- '#223744'; blue <- '#267888'; orange <- '#B16A26'; grey <- '#B9C4CA'
svg(file.path(out, 'vyber-prideleni.svg'), width = 7.6, height = 4.6, family = 'sans', bg = 'white')
par(mar = c(0, 0, 0, 0), xaxs = 'i', yaxs = 'i', fg = ink)
plot.new(); plot.window(xlim = c(0, 100), ylim = c(0, 62))
box_at <- function(x0, y0, x1, y1, label) {
  rect(x0, y0, x1, y1, border = ink, col = '#F4F8F8', lwd = 1.4)
  text((x0 + x1) / 2, y1 + 3, label, col = ink, font = 2, cex = 1.05)
}
step <- function(x, y, number) {
  symbols(x, y, circles = 2.1, inches = FALSE, add = TRUE, bg = 'white', fg = ink, lwd = 1.4)
  text(x, y, number, col = ink, font = 2, cex = .95)
}
# Population: 6 x 8 people, 12 of them end up in the sample.
box_at(2, 18, 30, 54, 'Populace')
pop <- expand.grid(x = seq(5.5, 26.5, length.out = 6), y = seq(21.5, 50.5, length.out = 8))
chosen <- c(3, 8, 11, 16, 20, 23, 27, 30, 34, 39, 43, 46)
points(pop$x, pop$y, pch = 21, cex = 1.35, col = 'white',
  bg = ifelse(seq_len(nrow(pop)) %in% chosen, ink, grey))
# Sample: the 12 selected people.
box_at(43, 26, 59, 46, 'Výběr')
smp <- expand.grid(x = seq(46.5, 55.5, length.out = 3), y = seq(29.5, 42.5, length.out = 4))
points(smp$x, smp$y, pch = 21, cex = 1.35, col = 'white', bg = ink)
# Conditions: six people each.
box_at(74, 40, 98, 54, 'Ticho')
box_at(74, 18, 98, 32, 'Rušivé zvuky')
cond <- expand.grid(x = seq(79, 93, length.out = 3), y = c(-3, 3))
points(cond$x, 47 + cond$y, pch = 21, cex = 1.35, col = 'white', bg = blue)
points(cond$x, 25 + cond$y, pch = 21, cex = 1.35, col = 'white', bg = orange)
arrows(31, 36, 42, 36, length = .1, lwd = 2, col = ink)
arrows(60, 38, 73, 46, length = .1, lwd = 2, col = ink)
arrows(60, 34, 73, 26, length = .1, lwd = 2, col = ink)
step(36.5, 40.5, '1'); step(66.5, 36, '2')
# Questions answered by each step.
step(4.5, 10.5, '1'); step(52.5, 10.5, '2')
text(8, 10.5, 'Výběr z populace', adj = 0, col = ink, font = 2)
text(56, 10.5, 'Přidělení do podmínek', adj = 0, col = ink, font = 2)
text(2.4, 5.6, 'Na koho lze závěr zobecnit?', adj = 0, col = ink)
text(50.4, 5.6, 'Lze rozdíl připsat podmínce?', adj = 0, col = ink)
text(2.4, 1.6, '(externí validita)', adj = 0, col = ink)
text(50.4, 1.6, '(interní validita)', adj = 0, col = ink)
dev.off()
