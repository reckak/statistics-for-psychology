# Reproducible chapter figures. Base R only, run from the project root.
d <- read.csv('data/kapitola_02.csv', na.strings = '', fileEncoding = 'UTF-8')
out <- 'assets/chapter-02/plots'
dir.create(out, recursive = TRUE, showWarnings = FALSE)
ink <- '#223744'; blue <- '#267888'; orange <- '#B16A26'
draw <- function(name, code, width = 7, height = 4.5) {
  svg(file.path(out, paste0(name, '.svg')), width = width, height = height, family = 'sans', bg = 'white')
  par(mar = c(4.4, 4.5, 1.3, 1), las = 1, col.axis = ink, col.lab = ink, fg = ink, cex = 1)
  force(code)
  dev.off()
}
freq <- as.numeric(table(factor(d$odpocatost, levels = 1:4)))
draw('sloupce', {
  pos <- barplot(freq, names.arg = c('Vůbec', 'Trochu', 'Dost', 'Zcela'), col = blue,
    border = NA, ylim = c(0, 16), ylab = 'Počet účastníků', xlab = 'Odpočatost před úlohou')
  text(pos, freq + .65, freq)
})
draw('tecky', {
  v <- sort(d$slova); yy <- ave(v, v, FUN = seq_along)
  plot(v, yy, pch = 21, bg = blue, col = 'white', cex = 1.6, xlim = c(-.5, 12.5), ylim = c(0, 7),
    xaxt = 'n', yaxt = 'n', bty = 'n', xlab = 'Počet správně vybavených slov', ylab = '')
  axis(1, at = 0:12); mtext('Jedna tečka = jeden účastník', side = 3, adj = 0)
})
s <- d$spanek_h[!is.na(d$spanek_h)]
draw('histogram', {
  hist(s, breaks = 4:10, right = FALSE, col = blue, border = 'white', main = '',
    xlab = 'Uvedená doba spánku (hodiny)', ylab = 'Počet účastníků', xaxt = 'n', ylim = c(0, 12))
  axis(1, at = 4:10)
})
draw('intervaly', {
  par(mfrow = c(1, 2), mar = c(4.4, 4.2, 2, .8))
  for (w in c(.5, 2)) {
    hist(s, breaks = seq(4, 10, by = w), right = FALSE, col = blue, border = 'white',
      main = paste('Šířka', sub('.', ',', as.character(w), fixed = TRUE), 'h'),
      xlab = 'Doba spánku (h)', ylab = 'Počet účastníků', xlim = c(4, 10), ylim = c(0, 20))
  }
}, width = 8.2, height = 4)
draw('kumulativni', {
  plot(ecdf(d$slova), verticals = FALSE, do.points = FALSE, xlim = c(-.5, 12.5),
    ylim = c(0, 1), main = '', xlab = 'Hranice: počet vybavených slov', ylab = 'Kumulativní podíl',
    xaxt = 'n', yaxt = 'n', col = blue, lwd = 2, frame.plot = FALSE)
  axis(1, at = 0:12); axis(2, at = c(0, .25, .5, .75, 1), labels = c('0 %', '25 %', '50 %', '75 %', '100 %'))
  f <- table(factor(d$slova, levels = 0:12)); cum <- cumsum(f)/nrow(d)
  points(0:12, cum, pch = 16, col = blue)
  points((0:12)[f>0], c(0,head(cum,-1))[f>0], pch = 21, bg = 'white', col = blue)
})
draw('kumulativni-seskupene', {
  h <- hist(s, breaks = 4:10, right = FALSE, plot = FALSE)
  boundaries <- h$breaks
  cumulative <- c(0, cumsum(h$counts)) / length(s)
  par(mar = c(4.8, 5.5, 1.5, 1.2))
  plot(boundaries, cumulative, type = 'n', xlim = c(4, 10), ylim = c(0, 1),
    xlab = 'Hranice doby spánku (h)', ylab = 'Kumulativní relativní četnost',
    xaxt = 'n', yaxt = 'n', bty = 'l')
  axis(1, at = 4:10)
  axis(2, at = c(0, .25, .5, .75, 1), labels = c('0 %', '25 %', '50 %', '75 %', '100 %'))
  abline(h = c(.25, .5, .75, 1), col = '#E6EBED', lty = 1)
  lines(boundaries, cumulative, col = blue, lwd = 2, lty = 2)
  points(boundaries, cumulative, col = blue, pch = 16, cex = 1.15)
  text(7, cumulative[4] + .07, '13 z 33 (39,4 %)', col = ink, cex = .95)
  legend('topleft', legend = c('Body: známé podíly pod hranicí', 'Spojnice: uvnitř intervalu průběh neznáme'),
    col = blue, pch = c(16, NA), lty = c(NA, 2), lwd = c(NA, 2), bty = 'n', cex = .83)
}, width = 7.4, height = 4.6)

draw('polygon', {
  h <- hist(s, breaks = 4:10, right = FALSE, plot = FALSE)
  plot(h$mids, h$counts, type = 'o', pch = 16, col = blue, lwd = 2, ylim = c(0, 12),
    xlab = 'Střed třídního intervalu spánku (h)', ylab = 'Počet účastníků', bty = 'l', xaxt = 'n')
  axis(1, at = h$mids, labels = sub('.', ',', as.character(h$mids), fixed = TRUE))
})
draw('vysecovy', {
  par(mfrow = c(1, 2), mar = c(5.5, 1, 2, 1))
  vals <- c(14, 12, 10); labs <- c('Procvičování', 'Čtení', 'Vysvětlování')
  pie(vals, labels = c('38,9 %', '33,3 %', '27,8 %'), col = c(blue, orange, '#92ADB1'), main = 'Výsečový graf')
  legend('bottom', legend = labs, fill = c(blue, orange, '#92ADB1'), bty = 'n', cex = .85, inset = c(0,-.28), xpd = NA)
  par(mar = c(5.2, 3.8, 2, .5))
  bp <- barplot(vals, names.arg = c('Procvičo-\nvání', 'Čtení', 'Vysvětlo-\nvání'), col = blue,
    ylim = c(0, 16), border = NA, ylab = 'Počet účastníků', main = 'Sloupcový graf')
  text(bp, vals+.65, vals)
}, width = 8.2, height = 4.8)
draw('tvary', {
  par(mfrow = c(2, 3), mar = c(3.2, 3, 2.5, .4), cex = .9)
  sets <- list(c(1,2,4,7,10,7,4,2,1), c(1,3,10,8,5,3,2,1,1), c(1,1,2,3,5,8,10,3,1),
    c(1,6,10,4,1,4,10,6,1), c(4,4,4,4,4,4,4,4,4), c(1,3,8,9,4,1,0,0,1))
  titles <- c('Přibližná souměrnost', 'Zešikmení doprava', 'Zešikmení doleva', 'Dva výrazné vrcholy', 'Rovnoměrné rozdělení', 'Vzdálené pozorování')
  for (i in seq_along(sets)) {
    plot(1:9, sets[[i]], type='h', lwd=12, lend=1, col=blue, xlim=c(.5,9.5), ylim=c(0,11),
      main=titles[i], xlab='Hodnota', ylab='Četnost', bty='l', xaxt='n')
    axis(1, at=c(1,5,9))
  }
}, width=9, height=5.8)
draw('podlaha-strop', {
  par(mfrow=c(1,2), mar=c(4.3,4,2.2,.5))
  for (i in 1:2) {
    vals <- if(i==1) c(15,7,4,3,2,1,1,1,1,1,0,0,0) else rev(c(15,7,4,3,2,1,1,1,1,1,0,0,0))
    plot(0:12, vals, type='h', lwd=9, lend=1, col=blue, ylim=c(0,16),
      xlab='Počet správných odpovědí (0–12)', ylab='Počet účastníků', bty='l',
      main=if(i==1) 'Možný efekt podlahy' else 'Možný efekt stropu')
  }
}, width=8.2, height=4)
draw('osa', {
  par(mfrow=c(1,2), mar=c(4,4,2.2,.5))
  for(i in 1:2) {
    low <- if(i==1) 0 else 27
    plot(c(.4,2.6), c(low,33), type='n', xaxt='n', xlab='Soubor', ylab='Počet odpovědí ano',
      main=if(i==1) 'Osa od nuly' else 'Osa začíná na 27', bty='l')
    rect(c(.65,1.65), low, c(1.35,2.35), c(30,32), col=blue,border=NA)
    axis(1,at=1:2,labels=c('A','B'));text(1:2,c(30,32)+.3,c(30,32))
  }
}, width=8.2,height=4)
cat('Chapter 2: generated 11 figures from fixed data.\n')
