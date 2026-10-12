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
text(56, 10.5, 'Přiřazení k podmínkám', adj = 0, col = ink, font = 2)
text(2.4, 5.6, 'Na koho lze závěr zobecnit?', adj = 0, col = ink)
text(50.4, 5.6, 'Lze rozdíl připsat podmínce?', adj = 0, col = ink)
text(2.4, 1.6, '(externí validita)', adj = 0, col = ink)
text(50.4, 1.6, '(interní validita)', adj = 0, col = ink)
dev.off()

# Conceptual diagrams: fixed illustrative positions, not empirical observations.
diagram <- function(name, height, code) {
  svg(file.path(out, paste0(name, '.svg')), width = 8.8, height = height,
      family = 'sans', bg = 'white', pointsize = 13)
  par(mar = c(0, 0, 0, 0), xaxs = 'i', yaxs = 'i', fg = ink)
  plot.new(); plot.window(xlim = c(0, 100), ylim = c(0, 100))
  force(code); dev.off()
}
label <- function(x, y, s, bold = FALSE, cex = 1, col = ink) {
  text(x, y, s, font = if (bold) 2 else 1, cex = cex, col = col)
}
panel <- function(x0, y0, x1, y1, s, col = '#F4F8F8') {
  rect(x0, y0, x1, y1, col = col, border = grey)
  label((x0+x1)/2, (y0+y1)/2, s)
}
link <- function(x0,y0,x1,y1,col=blue) arrows(x0,y0,x1,y1,length=.12,lwd=2,col=col)

diagram('populace-vyber-inference', 6.4, {
  label(50,95,'Od populace k datům, od dat k závěru',TRUE,1.15)
  panel(3,40,32,76,''); panel(68,50,97,76,'')
  label(17.5,81,'Populace',TRUE); label(82.5,81,'Výběr (sample)',TRUE)
  p <- expand.grid(x=seq(7,28,length.out=5),y=seq(46,70,length.out=4))
  points(p$x,p$y,pch=21,bg=grey,col=ink,cex=1.3)
  s <- c(2,8,11,19)
  points(p$x[s],p$y[s],pch=21,bg=blue,col=ink,cex=1.3)
  points(c(75,89,75,89),c(69,69,57,57),pch=21,bg=blue,col=ink,cex=1.3)
  link(34,67,66,67)
  label(50,77,'Vybírání případů\n(sampling)',TRUE,.95)
  label(50,58,'Proces získávání\npřípadů do studie',cex=.9)
  label(17.5,32,'O kom chceme\nněco zjistit',cex=.92)
  label(82.5,45,'Výsledek: zahrnuté případy',cex=.8)
  label(82.5,35,'Popisná statistika',TRUE,.9)
  label(82.5,28,'Shrnuje získaná data\n(zde data výběru).',cex=.85)
  link(66,16,34,16,orange)
  label(50,23,'Inferenční statistika',TRUE,.95)
  label(50,7,'Z dat výběru usuzujeme na populaci:\ns předpoklady a nejistotou.',cex=.9)
})

diagram('souvislost-pricina', 5.5, {
  label(50,95,'Dvě uvažovaná vysvětlení stejné souvislosti',TRUE,1.1)
  label(50,85,'1. Spánek ovlivňuje výkon',TRUE)
  panel(5,63,37,76,'Kratší spánek'); panel(63,63,95,76,'Horší výkon')
  link(39,69.5,61,69.5)
  label(50,52,'2. Společná příčina ovlivňuje obojí',TRUE)
  panel(30,33,70,44,'Náročné zkouškové období')
  panel(3,10,30,23,'Kratší spánek'); panel(38,10,62,23,'Vyšší úzkost')
  panel(72,10,97,23,'Horší výkon')
  link(35,32,17,25); link(50,32,50,25); link(64,16.5,70,16.5)
  label(50,3,'Šipky vyjadřují hypotézy. Oba mechanismy mohou působit současně.',cex=.85)
})

diagram('od-konstruktu-k-zaznamu', 6, {
  label(50,95,'Co chceme poznat a co skutečně zaznamenáme',TRUE,1.1)
  ys <- c(80,59,38,17)
  titles <- c('Konstrukt','Operacionalizace','Zaznamenaná proměnná','Hodnota u P01')
  bodies <- c('Určitá stránka paměti',
    '12 slov; 1 minuta na čtení, 1 minuta na vybavení\nKaždé správné slovo započítáme jednou',
    'Počet různých správně vybavených slov\nMožné hodnoty: celá čísla od 0 do 12',
    '5 správně vybavených slov')
  for (i in seq_along(ys)) {
    label(19,ys[i],titles[i],TRUE,.9)
    panel(38,ys[i]-7,96,ys[i]+7,bodies[i])
    if (i < 4) link(67,ys[i]-8,67,ys[i+1]+8)
  }
  label(50,3,'Šipky ukazují postup vymezení a záznamu, nikoli příčinné účinky.',cex=.85)
})

diagram('zmena-zapisu', 7, {
  label(50,96,'Změna zápisu: co zůstává stejné?',TRUE,1.15)
  for (y in c(73,51,29)) segments(3,y,97,y,col=grey)
  label(19,86,'Nominální',TRUE)
  label(65,89,'Ticho: 1 → 7     Rušivé zvuky: 2 → 9')
  label(65,80,'Stejné kategorie, jiné kódy.',cex=.95,col=blue)
  label(19,64,'Ordinální',TRUE)
  label(65,67,'vůbec   <   trochu   <   dost   <   zcela\n1, 2, 3, 4    →    1, 2, 5, 10')
  label(65,56,'Stejné pořadí, jiné rozestupy kódů.',cex=.95,col=blue)
  label(19,42,'Intervalová',TRUE)
  label(65,45,'10 °C → 50 °F       20 °C → 68 °F\n15 °C → 59 °F       25 °C → 77 °F')
  label(65,34,'Oba rozdíly 5 °C odpovídají 9 °F.',cex=.95,col=blue)
  label(19,20,'Poměrová',TRUE)
  label(65,23,'4 h → 240 min       8 h → 480 min')
  label(65,14,'Stejný poměr 2 : 1; nula zůstává nulou.',cex=.95,col=blue)
  label(50,4,'U teploty se poměr hodnot mění: 20 / 10 = 2, ale 68 / 50 = 1,36.',cex=.9)
})

diagram('diskretnost-a-zaznam', 6, {
  label(50,95,'Možné hodnoty a přesnost záznamu',TRUE,1.15)
  label(50,84,'Počet slov: pouze celá čísla od 0 do 12',TRUE)
  xs <- seq(8,92,length.out=13)
  segments(8,73,92,73,col=grey)
  points(xs,rep(73,13),pch=19,col=blue,cex=1.1)
  text(xs,rep(66,13),0:12,cex=.9,col=ink)
  label(50,57,'Mezi 5 a 6 slovy není přípustný počet 5,5.',cex=.95)
  label(50,45,'Doba: spojitá veličina, zaokrouhlený záznam',TRUE)
  segments(8,34,92,34,col=blue,lwd=2)
  tx <- c(8,29,50,71,92)
  segments(tx,32,tx,36,col=blue)
  text(tx,rep(27,5),c('6,6 h','6,8 h','7,0 h','7,2 h','7,4 h'),cex=.9)
  link(29,23,44,13); link(71,23,56,13)
  label(50,9,'Záznam na celé hodiny: 7 h',TRUE)
  label(50,2,'Také 0; 0,5; 1 bod jsou diskrétní možnosti. Desetinná čárka nerozhoduje.',cex=.82)
})

diagram('variabilita-a-neucast', 6.2, {
  label(50,95,'Kolísání výběrů a mechanismus neúčasti',TRUE,1.1)
  label(50,85,'A. Stejná populace, stejný postup vybírání',TRUE)
  # Schematic membership, no numeric estimates or random simulation.
  groups <- list(c(1,1,0,0,0,0),c(1,1,1,0,0,0),c(1,1,1,1,0,0))
  for (i in 1:3) {
    xx <- (i-1)*32 + c(11,18,25,11,18,25)
    yy <- c(72,72,72,65,65,65)
    points(xx,yy,pch=ifelse(groups[[i]]==1,16,17),
           col=ifelse(groups[[i]]==1,blue,orange),cex=1.6)
    label((i-1)*32+18,57,paste('Výběr',i),cex=.95)
  }
  label(50,48,'Složení jednotlivých výběrů se může náhodně lišit.',cex=.95)
  segments(3,42,97,42,col=grey)
  label(50,35,'B. Po oslovení častěji chybějí odpovědi jedné skupiny',TRUE,.95)
  label(20,24,'● Podporovatelé',col=blue)
  label(20,14,'▲ Ostatní',col=orange)
  link(39,24,56,24); link(39,14,56,14)
  label(77,24,'Častěji odmítají rozhovor',cex=.95)
  label(77,14,'Častěji odpovídají',cex=.95)
  label(50,4,'Mezi odpovídajícími pak může být podpora strany podhodnocena.',cex=.9)
})

diagram('ucastnik-navsteva-radek', 5, {
  label(50,94,'Dva účastníci, čtyři záznamy',TRUE,1.15)
  panel(4,56,28,74,'Účastník A'); panel(4,22,28,40,'Účastník B')
  label(51,84,'Případ',TRUE); label(83,84,'Řádek matice',TRUE)
  yy <- c(72,54,36,18)
  for(i in 1:4) {
    person <- if(i<=2) 'A' else 'B'
    visit <- if(i %% 2 == 1) 1 else 2
    panel(38,yy[i]-6,64,yy[i]+6,paste('Návštěva',visit))
    panel(73,yy[i]-6,97,yy[i]+6,paste(person,'|',visit))
    link(30,if(i<=2) 65 else 31,36,yy[i]); link(66,yy[i],71,yy[i])
  }
  label(50,4,'ID člověka se opakuje; konkrétní záznam určuje ID spolu s návštěvou.',cex=.9)
})
