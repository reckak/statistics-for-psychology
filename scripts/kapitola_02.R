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
# Data and descriptions of the figures for the AI tutor (tmp/tutor-figures/kapitola_02/); see scripts/tutor/figure-data.R.
source('scripts/tutor/figure-data.R',encoding='UTF-8')
ch2_fig <- function(...) tf_figure('kapitola_02',...)
freq <- as.numeric(table(factor(d$odpocatost, levels = 1:4)))
draw('sloupce', {
  pos <- barplot(freq, names.arg = c('Vůbec', 'Trochu', 'Dost', 'Zcela'), col = blue,
    border = NA, ylim = c(0, 16), ylab = 'Počet účastníků', xlab = 'Odpočatost před úlohou')
  text(pos, freq + .65, freq)
})
ch2_fig('sloupce','sloupce',note='Čtyři modré sloupce oddělené mezerami; nad každým je jeho absolutní četnost. Graf je bez nadpisu.',panels=list(
  tf_panel('Odpočatost před úlohou: absolutní četnosti','sloupcový graf','Odpočatost před úlohou','Počet účastníků',ylim=c(0,16),
    series=list(tf_series('Absolutní četnosti',data.frame(kategorie=c('Vůbec','Trochu','Dost','Zcela'),y=freq),'sloupce')))))
draw('tecky', {
  v <- sort(d$slova); yy <- ave(v, v, FUN = seq_along)
  plot(v, yy, pch = 21, bg = blue, col = 'white', cex = 1.6, xlim = c(-.5, 12.5), ylim = c(0, 7),
    xaxt = 'n', yaxt = 'n', bty = 'n', xlab = 'Počet správně vybavených slov', ylab = '')
  axis(1, at = 0:12); mtext('Jedna tečka = jeden účastník', side = 3, adj = 0)
})
ch2_fig('tecky','data',note='Skládaný bodový graf: nad každou hodnotou stojí nad sebou tolik modrých teček, kolik účastníků ji dosáhlo. Svislá osa není vykreslena, vodorovná má značky 0 až 12; text „Jedna tečka = jeden účastník“ je vlevo nad grafem.',panels=list(local({
  v <- sort(d$slova)
  tf_panel('Jedna tečka = jeden účastník','bodový graf','Počet správně vybavených slov','Pořadí tečky nad hodnotou (výška sloupku teček = četnost)',xlim=c(-.5,12.5),ylim=c(0,7),
    series=list(tf_series('Účastníci',data.frame(x=v,y=ave(v,v,FUN=seq_along))))) })))
s <- d$spanek_h[!is.na(d$spanek_h)]
draw('histogram', {
  hist(s, breaks = 4:10, right = TRUE, include.lowest = FALSE, col = blue, border = 'white', main = '',
    xlab = 'Uvedená doba spánku (hodiny)', ylab = 'Počet účastníků', xaxt = 'n', ylim = c(0, 12))
  axis(1, at = 4:10)
})
ch2_fig('histogram','data',note=paste0('Modré sloupce s bílými okraji, bez mezer. Horní mez každého intervalu do něj patří, dolní nikoli. Platných údajů: ',length(s),'; chybějících údajů, které v grafu nejsou: ',sum(is.na(d$spanek_h)),'. Graf je bez nadpisu.'),panels=list(
  tf_panel('Uvedená doba spánku: intervaly šířky 1 h','histogram','Uvedená doba spánku (hodiny)','Počet účastníků',xlim=c(4,10),ylim=c(0,12),
    series=list(tf_series('Absolutní četnosti',tf_bins(s,4:10),'histogram')))))
draw('intervaly', {
  par(mfrow = c(2, 2), mar = c(4.4, 4.2, 2.5, .8))
  breaks_list <- list(seq(4,10,.5),seq(4,10,2),4:10,seq(3.5,10.5,1))
  titles <- c('Šířka 0,5 h','Šířka 2 h','Šířka 1 h; meze na celých hodinách',
    'Šířka 1 h; meze posunuté o 0,5 h')
  for (i in seq_along(breaks_list)) {
    hist(s, breaks = breaks_list[[i]], right = TRUE, include.lowest = FALSE, col = blue, border = 'white',
      main = titles[i], cex.main=.9,
      xlab = 'Doba spánku (h)', ylab = 'Počet účastníků', xlim = c(3.5, 10.5), ylim = c(0, 20))
  }
}, width = 8.2, height = 7.5)
ch2_fig('intervaly','data',note=paste0('Čtyři histogramy týchž ',length(s),' dob spánku ve dvou řadách po dvou, se shodnými rozsahy os. Nahoře se liší šířka intervalu (0,5 h a 2 h), dole je šířka vždy 1 h a liší se poloha mezí. Horní mez každého intervalu do něj patří; modré sloupce s bílými okraji.'),panels=local({
  breaks_list <- list(seq(4,10,.5),seq(4,10,2),4:10,seq(3.5,10.5,1))
  titles <- c('Šířka 0,5 h','Šířka 2 h','Šířka 1 h; meze na celých hodinách','Šířka 1 h; meze posunuté o 0,5 h')
  lapply(seq_along(breaks_list),function(i)
    tf_panel(titles[i],'histogram','Doba spánku (h)','Počet účastníků',xlim=c(3.5,10.5),ylim=c(0,20),
      series=list(tf_series('Absolutní četnosti',tf_bins(s,breaks_list[[i]]),'histogram')))) }))
draw('kumulativni', {
  plot(ecdf(d$slova), verticals = FALSE, do.points = FALSE, xlim = c(-.5, 12.5),
    ylim = c(0, 1), main = '', xlab = 'Mez: počet vybavených slov', ylab = 'Kumulativní podíl',
    xaxt = 'n', yaxt = 'n', col = blue, lwd = 2, frame.plot = FALSE)
  axis(1, at = 0:12); axis(2, at = c(0, .25, .5, .75, 1), labels = c('0 %', '25 %', '50 %', '75 %', '100 %'))
  f <- table(factor(d$slova, levels = 0:12)); cum <- cumsum(f)/nrow(d)
  points(0:12, cum, pch = 16, col = blue)
  points((0:12)[f>0], c(0,head(cum,-1))[f>0], pch = 21, bg = 'white', col = blue)
})
ch2_fig('kumulativni','data',note='Schodovitý graf z modrých vodorovných úseků bez svislých spojnic. Plný bod leží ve výšce kumulativního podílu až po mez včetně; prázdný bod na konci předchozího úseku ukazuje, že tato výška pro mez už neplatí. Svislá osa je popsána v procentech (0 %, 25 %, 50 %, 75 %, 100 %), hodnoty v datech jsou podíly od 0 do 1; graf je bez nadpisu.',panels=list(local({
  kn <- sort(unique(d$slova)); lo <- c(-.5,kn); hi <- c(kn,12.5); y <- ecdf(d$slova)((lo+hi)/2)
  f <- table(factor(d$slova, levels = 0:12)); cum <- as.numeric(cumsum(f))/nrow(d); is <- as.vector(f>0)
  tf_panel('Kumulativní podíl výsledků paměťové úlohy','čárový graf','Mez: počet vybavených slov','Kumulativní podíl',xlim=c(-.5,12.5),ylim=c(0,1),
    guides=list(tf_guide('y',0,'0 %'),tf_guide('y',1,'100 %')),
    series=list(tf_series('Vodorovné úseky schodů',data.frame(x0=lo,y0=y,x1=hi,y1=y),'usecky',digits=4,note='první a poslední úsek pokračují až k okraji grafu'),
      tf_series('Plné body: kumulativní podíl až po mez včetně',data.frame(x=0:12,y=cum,kumulativni_cetnost=as.numeric(cumsum(f))),'body',digits=4,note='u meze, které nikdo nedosáhl, leží plný bod uvnitř úseku'),
      tf_series('Prázdné body: podíl těsně pod mezí',data.frame(x=(0:12)[is],y=c(0,head(cum,-1))[is]),'body',digits=4))) })))
draw('kumulativni-seskupene', {
  h <- hist(s, breaks = 4:10, right = TRUE, include.lowest = FALSE, plot = FALSE)
  boundaries <- h$breaks
  cumulative <- c(0, cumsum(h$counts)) / length(s)
  par(mar = c(4.8, 5.5, 1.5, 1.2))
  plot(boundaries, cumulative, type = 'n', xlim = c(4, 10), ylim = c(0, 1),
    xlab = 'Mez doby spánku (h)', ylab = 'Kumulativní relativní četnost',
    xaxt = 'n', yaxt = 'n', bty = 'l')
  axis(1, at = 4:10)
  axis(2, at = c(0, .25, .5, .75, 1), labels = c('0 %', '25 %', '50 %', '75 %', '100 %'))
  abline(h = c(.25, .5, .75, 1), col = '#E6EBED', lty = 1)
  lines(boundaries, cumulative, col = blue, lwd = 2, lty = 2)
  points(boundaries, cumulative, col = blue, pch = 16, cex = 1.15)
  text(7.12, cumulative[4] - .025, '16 z 33 (48,5 %)', adj = c(0, 1), col = ink, cex = .95)
  legend('topleft', legend = c('Body: známé podíly až po mez včetně', 'Spojnice: uvnitř intervalu průběh neznáme'),
    col = blue, pch = c(16, NA), lty = c(NA, 2), lwd = c(NA, 2), bty = 'n', cex = .83)
}, width = 7.4, height = 4.6)
ch2_fig('kumulativni-seskupene','data',note='Modré plné body na mezích intervalů spojené přerušovanou modrou čárou; světle šedé vodorovné čáry mřížky ve výškách 25, 50, 75 a 100 %. Legenda vlevo nahoře: „Body: známé podíly až po mez včetně“ a „Spojnice: uvnitř intervalu průběh neznáme“. Svislá osa je popsána v procentech, hodnoty v datech jsou podíly od 0 do 1; graf je bez nadpisu.',panels=list(local({
  h <- hist(s, breaks = 4:10, right = TRUE, include.lowest = FALSE, plot = FALSE)
  pts <- data.frame(x=h$breaks,y=c(0, cumsum(h$counts))/length(s),kumulativni_cetnost=c(0,cumsum(h$counts)),popisek=ifelse(h$breaks==7,'16 z 33 (48,5 %)',''))
  tf_panel('Kumulativní relativní četnosti doby spánku z jednohodinových intervalů','čárový graf','Mez doby spánku (h)','Kumulativní relativní četnost',xlim=c(4,10),ylim=c(0,1),
    series=list(tf_series('Spojnice: uvnitř intervalu průběh neznáme',pts[c('x','y')],'cara',digits=4,note='přerušovaná čára'),
      tf_series('Body: známé podíly až po mez včetně',pts,'body',digits=4))) })))

draw('polygon', {
  h <- hist(s, breaks = 4:10, right = TRUE, include.lowest = FALSE, plot = FALSE)
  plot(h$mids, h$counts, type = 'o', pch = 16, col = blue, lwd = 2, ylim = c(0, 12),
    xlab = 'Střed třídního intervalu spánku (h)', ylab = 'Počet účastníků', bty = 'l', xaxt = 'n')
  axis(1, at = h$mids, labels = sub('.', ',', as.character(h$mids), fixed = TRUE))
})
ch2_fig('polygon','data',note='Modrá lomená čára s plným bodem nad středem každého jednohodinového intervalu; vodorovná osa má značky ve středech intervalů (4,5 až 9,5). Čára začíná u prvního a končí u posledního středu, k nule se nevrací. Graf je bez nadpisu.',panels=list(local({
  h <- hist(s, breaks = 4:10, right = TRUE, include.lowest = FALSE, plot = FALSE)
  pts <- data.frame(x=h$mids,y=h$counts)
  tf_panel('Polygon četností doby spánku','čárový graf','Střed třídního intervalu spánku (h)','Počet účastníků',ylim=c(0,12),
    series=list(tf_series('Spojnice četností',pts,'cara'),tf_series('Body nad středy intervalů',pts,'body'))) })))
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
ch2_fig('vysecovy','sloupce',note='Dva panely vedle sebe se stejnými četnostmi: vlevo výsečový, vpravo sloupcový graf.',panels=local({
  vals <- c(14, 12, 10); labs <- c('Procvičování', 'Čtení', 'Vysvětlování')
  list(tf_panel('Výsečový graf','výsečový graf',
      note='Výseče následují v uvedeném pořadí proti směru hodinových ručiček od polohy „tři hodiny“. U každé výseče je popisek s procentem; legenda s názvy kategorií je pod grafem.',
      series=list(tf_series('Výseče',data.frame(kategorie=labs,cetnost=vals,podil=vals/sum(vals),popisek=c('38,9 %', '33,3 %', '27,8 %'),barva=c('modrá','oranžová','šedomodrá')),'tabulka',digits=4))),
    tf_panel('Sloupcový graf','sloupcový graf','Hlavní způsob přípravy','Počet účastníků',ylim=c(0,16),note='Modré sloupce, nad každým je jeho četnost.',
      series=list(tf_series('Absolutní četnosti',data.frame(kategorie=labs,y=vals),'sloupce')))) }))
draw('tvary', {
  par(mfrow = c(2, 3), mar = c(3.2, 3, 2.5, .4), cex = .9)
  sets <- list(c(1,2,4,7,10,7,4,2,1), c(1,3,10,8,5,3,2,1,1), c(1,1,2,3,5,8,10,3,1),
    c(1,6,10,4,1,4,10,6,1), c(4,4,4,4,4,4,4,4,4), c(1,3,8,9,4,1,0,0,1))
  titles <- c('Přibližná souměrnost', 'Zešikmení doprava', 'Zešikmení doleva', 'Dva výrazné vrcholy', 'Rovnoměrné rozdělení', 'Odlehlé pozorování')
  for (i in seq_along(sets)) {
    plot(1:9, sets[[i]], type='h', lwd=12, lend=1, col=blue, xlim=c(.5,9.5), ylim=c(0,11),
      main=titles[i], xlab='Hodnota', ylab='Četnost', bty='l', xaxt='n')
    axis(1, at=c(1,5,9))
  }
}, width=9, height=5.8)
ch2_fig('tvary','sloupce',note='Šest panelů ve dvou řadách po třech se stejnými osami; záměrně sestavené četnosti hodnot 1 až 9 jako modré svislé sloupce. Vodorovná osa má značky jen u hodnot 1, 5 a 9.',panels=local({
  sets <- list(c(1,2,4,7,10,7,4,2,1), c(1,3,10,8,5,3,2,1,1), c(1,1,2,3,5,8,10,3,1),
    c(1,6,10,4,1,4,10,6,1), c(4,4,4,4,4,4,4,4,4), c(1,3,8,9,4,1,0,0,1))
  titles <- c('Přibližná souměrnost', 'Zešikmení doprava', 'Zešikmení doleva', 'Dva výrazné vrcholy', 'Rovnoměrné rozdělení', 'Odlehlé pozorování')
  lapply(seq_along(sets),function(i)
    tf_panel(titles[i],'sloupcový graf','Hodnota','Četnost',xlim=c(.5,9.5),ylim=c(0,11),
      series=list(tf_series('Četnosti',data.frame(x=1:9,y=sets[[i]]),'sloupce')))) }))
draw('podlaha-strop', {
  par(mfrow=c(1,2), mar=c(4.3,4,2.2,.5))
  for (i in 1:2) {
    vals <- if(i==1) c(15,7,4,3,2,1,1,1,1,1,0,0,0) else rev(c(15,7,4,3,2,1,1,1,1,1,0,0,0))
    plot(0:12, vals, type='h', lwd=9, lend=1, col=blue, ylim=c(0,16),
      xlab='Počet správných odpovědí (0–12)', ylab='Počet účastníků', bty='l',
      main=if(i==1) 'Možný efekt podlahy' else 'Možný efekt stropu')
  }
}, width=8.2, height=4)
ch2_fig('podlaha-strop','sloupce',note='Dva panely vedle sebe se stejnými osami; četnosti jako modré svislé sloupce nad hodnotami 0 až 12. Pravý panel je zrcadlovým obrazem levého.',panels=lapply(1:2,function(i) {
  vals <- if(i==1) c(15,7,4,3,2,1,1,1,1,1,0,0,0) else rev(c(15,7,4,3,2,1,1,1,1,1,0,0,0))
  tf_panel(if(i==1) 'Možný efekt podlahy' else 'Možný efekt stropu','sloupcový graf','Počet správných odpovědí (0–12)','Počet účastníků',ylim=c(0,16),
    series=list(tf_series('Četnosti',data.frame(x=0:12,y=vals),'sloupce'))) }))
draw('osa', {
  par(mfrow=c(1,2), mar=c(4,4,2.2,.5))
  for(i in 1:2) {
    low <- if(i==1) 0 else 27
    # Keep the complete label inside the panel even on the wider left scale.
    high <- if(i==1) 35 else 33
    plot(c(.4,2.6), c(low,high), type='n', xaxt='n', xlab='Soubor', ylab='Počet odpovědí ano',
      main=if(i==1) 'Osa od nuly' else 'Osa začíná na 27', bty='l')
    rect(c(.65,1.65), low, c(1.35,2.35), c(30,32), col=blue,border=NA)
    axis(1,at=1:2,labels=c('A','B'))
    text(1:2, c(30,32), c(30,32), pos = 3, offset = .4)
  }
}, width=8.2,height=4)
ch2_fig('osa','sloupce',note='Dva panely vedle sebe se stejnými četnostmi 30 a 32; modré sloupce, nad každým je jeho hodnota. Panely se liší jen začátkem a rozsahem svislé osy.',panels=lapply(1:2,function(i)
  tf_panel(if(i==1) 'Osa od nuly' else 'Osa začíná na 27','sloupcový graf','Soubor','Počet odpovědí ano',ylim=if(i==1) c(0,35) else c(27,33),
    note=if(i==1) 'Svislá osa začíná nulou; sloupce jsou vidět v celé výšce.' else 'Svislá osa je zkrácená: začíná na 27 a sloupce vyrůstají od této hodnoty, takže je z nich vidět jen horní část (3 a 5 jednotek).',
    series=list(tf_series('Četnosti',data.frame(kategorie=c('A','B'),y=c(30,32)),'sloupce')))))
draw('zaklad-procent', {
  par(mar=c(0,0,0,0))
  plot.new();plot.window(xlim=c(0,10),ylim=c(0,7),xaxs='i',yaxs='i')
  for (k in 1:2) {
    y <- if(k==1) 5.3 else 2.4
    text(.5,y+1.1,if(k==1) 'Všech šest účastníků' else 'Pět účastníků s platným údajem',adj=0,font=2)
    rect(.65,y-.65,if(k==1) 7.1 else 6,y+.65,border=ink,lwd=1.5)
    points(1:6+.2,rep(y,6),pch=c(21,21,21,21,21,22),cex=2.8,
      bg=c(blue,blue,blue,'white','white','#DFE3E5'),col=ink)
    text(6.2,y,'?',cex=.9)
    text(1:6+.2,y-.95,c('P02','P03','P06','P01','P04','P05'),cex=.8)
    text(8.5,y,if(k==1) '3 / 6\n50 %' else '3 / 5\n60 %',font=2,cex=1.15)
  }
  text(.5,.6,'Plný kruh: alespoň 7 h     Prázdný kruh: méně než 7 h\nČtverec s otazníkem: údaj chybí',adj=0,cex=.85)
},width=7.5,height=5.2)
tf_schema('kapitola_02','zaklad-procent')
draw('princip-kumulace', {
  par(mar=c(0,0,0,0));plot.new();plot.window(xlim=c(0,10),ylim=c(0,6),xaxs='i',yaxs='i')
  categories <- c(1,2,2,3,3,4)
  for(k in 1:2) {
    y<-if(k==1) 4.4 else 1.8
    selected<-if(k==1) categories==2 else categories<=2
    text(.5,y+1,if(k==1) 'Právě „trochu“' else 'Nejvýše „trochu“',adj=0,font=2)
    points(1:6,rep(y,6),pch=21,cex=2.8,bg=ifelse(selected,blue,'white'),col=ink)
    text(1:6,y-.6,c('vůbec','trochu','trochu','dost','dost','zcela'),cex=.85)
    text(8,y,paste(sum(selected),'ze 6'),font=2,cex=1.2)
  }
  text(.5,.3,'Jedna značka = jedna odpověď; plné značky započítáváme.',adj=0,cex=.85)
},width=7.5,height=4.5)
tf_schema('kapitola_02','princip-kumulace')
draw('meze-intervalu', {
  par(mar=c(0,0,0,0));plot.new();plot.window(xlim=c(5.7,8.9),ylim=c(0,6),xaxs='i',yaxs='i')
  for(k in 1:2) {
    y<-if(k==1) 4.4 else 1.9
    text(5.8,y+1.2,if(k==1) 'A: dolní mez patří, horní nepatří' else 'B: dolní mez nepatří, horní patří — používáme zde',adj=0,font=2,cex=.9)
    for(j in 1:2) {
      yy<-y-(j-1)*.55;lo<-5+j;hi<-lo+1;col<-c(blue,orange)[j]
      segments(lo,yy,hi,yy,col=col,lwd=3)
      points(c(lo,hi),c(yy,yy),pch=21,cex=1.5,col=col,
        bg=if(k==1)c(col,'white') else c('white',col))
    }
    text(6:8,y-.95,6:8)
    arrows(7,y+.8,7,if(k==1)y-.35 else y+.15,length=.09,col=ink)
    text(7.2,y+.7,'7,0 h',adj=0,cex=.85)
  }
  text(5.8,.2,'Plný krajní bod patří do intervalu; prázdný nepatří.',adj=0,cex=.85)
},width=8,height=4.8)
tf_schema('kapitola_02','meze-intervalu')
# Static illustrations of Excel sheets (assets/chapter-02/excel-*.svg) are not drawn by this script.
invisible(lapply(c('excel-absolutni','excel-kumulativni','excel-intervaly'),function(name) tf_schema('kapitola_02',name)))
cat('Chapter 2: generated 14 figures from fixed data.\n')
