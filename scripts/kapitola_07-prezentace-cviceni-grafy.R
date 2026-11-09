# Helper graphs for the Excel exercises of the chapter 7 presentation
# (presentations/kapitola_07_interval_t_test_a_ekvivalence_cviceni.xlsx, sheets U1 to U4).
# Inputs are read from the workbook, so the graphs follow its data. Needs the readxl package.
# Run from the project root: Rscript scripts/kapitola_07-prezentace-cviceni-grafy.R
# Output: presentations/kapitola_07_interval_t_test_a_ekvivalence_cviceni_grafy.pdf, one graph per page (16:9).
suppressPackageStartupMessages(library(readxl))
wb <- 'presentations/kapitola_07_interval_t_test_a_ekvivalence_cviceni.xlsx'
out_file <- 'presentations/kapitola_07_interval_t_test_a_ekvivalence_cviceni_grafy.pdf'
old_options <- options(OutDec=',')

cells <- function(sheet,range) {
  x <- read_excel(wb,sheet=sheet,range=range,col_names=FALSE,.name_repair='minimal')
  as.numeric(unlist(x,use.names=FALSE))
}
u1 <- list(x=cells('U1_Kruger_Dunning','C4:C14'),mu0=cells('U1_Kruger_Dunning','E4'),alpha=cells('U1_Kruger_Dunning','E5'))
u2 <- setNames(cells('U2_SAT_bez_textu','D4:D8'),c('n','m','s','mu0','alpha'))
u3 <- setNames(cells('U3_lez_skala','D4:D8'),c('mu0','n','m','s','alpha'))
u4 <- list(x=cells('U4_tablet_ekvivalence','C4:C63'),par=setNames(cells('U4_tablet_ekvivalence','E4:E6'),c('mu0','delta','alpha')))
stopifnot(length(u1$x)==11,length(u4$x)==60,!anyNA(c(u1$x,u1$mu0,u1$alpha,u2,u3,u4$x,u4$par)))

# Chapter 7 palette (scripts/kapitola_07.R) -------------------------------------
c_blue <- '#245D78'; c_orange <- '#B54E24'; c_fill <- '#B8DDE8'; c_gray <- '#4D5A63'; c_pale <- '#E1E8EB'
c_sand <- '#FAECDD'; c_ink <- '#223744'; c_mute <- '#A9BAC3'; c_green <- '#3E7B4F'
num <- function(x,digits=2) sub('^-','−',formatC(x,format='f',digits=digits,decimal.mark=','))
pval <- function(p) if(p<.001) '< 0,001' else num(p,3)

# One-sample summaries: estimated standard error, t, p-values and both intervals.
summ <- function(m,s,n,mu0) {
  se <- s/sqrt(n); v <- n-1; t <- (m-mu0)/se
  list(m=m,s=s,n=n,se=se,v=v,t=t,p_hi=pt(t,v,lower.tail=FALSE),p_lo=pt(t,v),p2=2*pt(-abs(t),v),
       ci95=m+c(-1,1)*qt(.975,v)*se,ci90=m+c(-1,1)*qt(.95,v)*se,tc=qt(.95,v))
}
r1 <- summ(mean(u1$x),sd(u1$x),length(u1$x),u1$mu0)
r2 <- summ(u2['m'],u2['s'],u2['n'],u2['mu0'])
r3 <- summ(u3['m'],u3['s'],u3['n'],u3['mu0'])
r4a <- summ(mean(u4$x),sd(u4$x),60,u4$par['mu0'])
r4b <- summ(mean(u4$x[1:15]),sd(u4$x[1:15]),15,u4$par['mu0'])

# Page frame: main graph on the left, explanatory panel on the right -------------
start_page <- function(title,subtitle,xlim,ylim,xlab,ylab='Hustota pravděpodobnosti',xat=NULL,yaxis=TRUE,top=4.4,digits=0) {
  layout(matrix(1:2,1),widths=c(2.6,1.4))
  par(mar=c(4.6,4.8,top,1),mgp=c(2.9,.7,0),las=1,col.axis=c_ink,col.lab=c_ink,fg=c_ink,cex=1.05)
  plot(NA,xlim=xlim,ylim=ylim,xaxs='i',yaxs='i',bty='l',xaxt='n',yaxt=if(yaxis) 's' else 'n',xlab=xlab,ylab=ylab)
  at <- if(is.null(xat)) pretty(xlim) else xat
  axis(1,at=at,labels=num(at,digits))
  title(title,line=top-2,adj=0,cex.main=1.18,col.main=c_ink)
  mtext(subtitle,side=3,line=top-3.5,adj=0,cex=.92,col=c_gray)
}
`%||%` <- function(a,b) if(is.null(a)) b else a
panel <- function(items) {
  par(mar=c(4.6,.4,4.4,.6)); plot.new(); plot.window(c(0,1),c(0,1))
  y <- .97
  for(it in items) {
    switch(it$type,
      head={ text(0,y,it$text,adj=0,font=2,cex=1,col=c_ink); y <- y-.06 },
      line={ segments(.02,y,.10,y,col=it$col,lwd=it$lwd %||% 2.4,lty=it$lty %||% 1)
             text(.13,y,it$text,adj=0,cex=.95,col=c_ink); y <- y-.055 },
      fill={ rect(.02,y-.022,.10,y+.022,col=it$col,border=NA)
             text(.13,y,it$text,adj=0,cex=.95,font=2,col=it$tcol %||% c_ink); y <- y-.06 },
      text={ nl <- if(is.character(it$text)) length(strsplit(it$text,'\n')[[1]]) else 1
             text(0,y,it$text,adj=c(0,1),cex=it$cex %||% .92,col=it$col %||% c_ink,font=it$font %||% 1)
             y <- y-.044*nl-.022 },
      gap={ y <- y-(it$h %||% .03) })
  }
}
area <- function(from,to,dens,...) {
  if(to<=from) return(invisible())
  x <- seq(from,to,length.out=400)
  polygon(c(from,x,to),c(0,dens(x),0),...)
}
curve_line <- function(dens,xlim,...) { x <- seq(xlim[1],xlim[2],length.out=800); lines(x,dens(x),...) }
vline <- function(x,top,label,ylab,col=c_ink,lty=2,cex=.92,font=2,pos=NULL) {
  segments(x,0,x,top,lty=lty,lwd=1.6,col=col)
  if(is.null(pos)) text(x,ylab,label,cex=cex,col=col,font=font) else text(x,ylab,label,pos=pos,offset=.25,cex=cex,col=col,font=font)
}
# Interval rows: thin line = 95% interval, thick bar = 90% interval, circle = sample mean.
ci_row <- function(y,r,label,col=c_blue) {
  segments(r$ci95[1],y,r$ci95[2],y,lwd=2,col=col)
  segments(r$ci95,y-.12,r$ci95,y+.12,lwd=2,col=col)
  segments(r$ci90[1],y,r$ci90[2],y,lwd=9,col=col,lend=1)
  points(r$m,y,pch=21,bg='white',col=c_ink,cex=1.6,lwd=1.5)
  text(par('usr')[1],y+.3,label,adj=c(-.03,0),cex=.95,font=2,col=c_ink)
}

pages <- list()
page <- function(f) pages[[length(pages)+1]] <<- f

# U1: Kruger and Dunning ---------------------------------------------------------
page(function() {
  x <- sort(u1$x); y <- ave(x,x,FUN=function(v) seq_along(v))*.12+.25
  start_page('Úkol 1 a): odhady vlastního percentilu u 11 nejslabších studentů',
             paste0('List U1_Kruger_Dunning, C4:C14;  m = ',num(r1$m,2),',  s = ',num(r1$s,2)),
             c(0,100),c(0,1),'Odhadovaný percentil',ylab='',yaxis=FALSE,xat=seq(0,100,10))
  rect(0,0,25,1,col=c_sand,border=NA)
  text(12.5,.93,'skutečný výkon:\nnejnižší čtvrtina',cex=.9,font=2,col=c_orange)
  vline(u1$mu0,.86,'průměrný student 50',.9,col=c_gray)
  points(x,y,pch=21,bg=c_fill,col=c_blue,cex=2.2,lwd=1.5)
  segments(r1$m,.15,r1$m,.75,lwd=3,col=c_blue)
  text(r1$m,.79,paste0('m = ',num(r1$m,1)),cex=.95,font=2,col=c_blue)
  panel(list(
    list(type='head',text='Co graf ukazuje'),
    list(type='fill',col=c_fill,text='odhad jednoho studenta'),
    list(type='fill',col=c_sand,text='kde ve skutečnosti skončili'),
    list(type='gap'),
    list(type='text',text='Všechny odhady kromě jednoho leží\nnad 50. percentilem, ačkoli skutečný\nvýkon všech patřil pod 25. percentil.'),
    list(type='gap'),
    list(type='text',text='Hodnota 40 leží daleko od ostatních:\nzvětšuje s. Z 11 hodnot tvar\nrozdělení spolehlivě posoudit nelze.',col=c_gray,font=3)))
})
page(function() {
  d <- function(x) dt(x,r1$v); xl <- c(-4.5,6)
  start_page(bquote('Úkol 1 b): jednostranný '*italic(t)*'-test, '*H[1]*': μ > 50'),
             bquote(italic(t)*'-rozdělení s '*.(r1$v)*' stupni volnosti;  '*italic(t)*' = ('*.(num(r1$m,2))*' − 50) / '*.(num(r1$se,3))*' = '*.(num(r1$t,2))),
             xl,c(0,.43),bquote('Hodnota statistiky '*italic(t)),xat=-4:6)
  area(r1$tc,xl[2],d,col=c_sand,border=NA)
  area(r1$t,xl[2],d,col=c_orange,border=NA)
  curve_line(d,xl,lwd=2.6,col=c_blue)
  vline(r1$tc,.25,paste0('kritická hodnota\n',num(r1$tc,3)),.29)
  arrows(r1$t,.12,r1$t,.004,length=.08,lwd=1.8,col=c_orange)
  text(r1$t,.125,paste0('t = ',num(r1$t,2)),adj=c(.5,0),cex=.95,font=2,col=c_orange)
  panel(list(
    list(type='head',text=bquote('Plochy za '*H[0]*' (μ = 50)')),
    list(type='fill',col=c_sand,text='kritický obor: 5 %'),
    list(type='fill',col=c_orange,text=paste0('p-hodnota: ',pval(r1$p_hi)),tcol=c_orange),
    list(type='gap'),
    list(type='text',text='Statistika leží hluboko v kritickém\noboru; plocha vpravo od ní je\ntak malá, že v grafu není vidět.'),
    list(type='gap'),
    list(type='text',text=bquote(bold('Rozhodnutí: zamítáme ')*bold(H[0])*bold(' (μ ≤ 50).')))))
})
page(function() {
  start_page('Úkol 1 c): 95% a 90% interval vůči hodnotě 50',
             paste0('95 %: (',num(r1$ci95[1],2),'; ',num(r1$ci95[2],2),'),  90 %: (',num(r1$ci90[1],2),'; ',num(r1$ci90[2],2),')'),
             c(40,85),c(0,2),'Průměrný odhadovaný percentil',ylab='',yaxis=FALSE,xat=seq(40,85,5))
  vline(u1$mu0,1.8,'50',1.88,col=c_gray)
  ci_row(1,r1,'11 nejslabších studentů')
  panel(list(
    list(type='head',text='Intervaly'),
    list(type='line',col=c_blue,lwd=2,text='95% interval (oboustranný test)'),
    list(type='line',col=c_blue,lwd=9,text='90% interval'),
    list(type='gap'),
    list(type='text',text=paste0('Jednostranný test „větší“ na hladině\n0,05 rozhoduje dolní mez 90%\nintervalu: ',num(r1$ci90[1],2),' > 50, zamítáme.')),
    list(type='gap'),
    list(type='text',text='I nejnižší s daty slučitelný průměrný\nodhad leží vysoko nad průměrem\na ještě výš nad skutečným výkonem.')))
})

# U2: answering without the passage ----------------------------------------------
page(function() {
  d <- function(x) dt((x-u2['mu0'])/r2$se,r2$v)/r2$se
  mc <- u2['mu0']+r2$tc*r2$se; xl <- c(10,55)
  start_page('Úkol 2: průměr při tipování a skutečný průměr',
             bquote('Model za '*H[0]*': průměry 28 studentů kolem 20 ('*italic(t)*'-rozdělení přeškálované o '*italic(s)[m]*' = '*.(num(r2$se,3))*')'),
             xl,c(0,.36),'Počet správných odpovědí ze 100',xat=seq(10,55,5))
  area(mc,xl[2],d,col=c_sand,border=NA)
  curve_line(d,xl,lwd=2.6,col=c_blue)
  vline(mc,.22,paste0('kritický průměr ',num(mc,2)),.2,pos=4)
  y <- .1
  segments(r2$ci95[1],y,r2$ci95[2],y,lwd=4,col=c_orange); segments(r2$ci95,y-.012,r2$ci95,y+.012,lwd=3,col=c_orange)
  points(r2$m,y,pch=21,bg='white',col=c_ink,cex=1.6,lwd=1.5)
  text(r2$m,y+.03,paste0('m = ',num(r2$m,1),'\n95% interval (',num(r2$ci95[1],2),'; ',num(r2$ci95[2],2),')'),adj=c(.5,0),cex=.92,font=2,col=c_orange)
  panel(list(
    list(type='head',text='Co graf ukazuje'),
    list(type='line',col=c_blue,text='průměry při čistém tipování'),
    list(type='fill',col=c_sand,text='kritický obor (5 %)'),
    list(type='line',col=c_orange,lwd=4,text='95% interval z dat'),
    list(type='gap'),
    list(type='text',text=paste0('t = ',num(r2$t,1),';  p-hodnota ',pval(r2$p_hi),'.')),
    list(type='gap'),
    list(type='text',text='Studenti odpovídali mnohem lépe než\npři tipování. O tom, zda test předpovídá\nstudijní úspěch, výsledek nevypovídá.',col=c_gray,font=3)))
})

# U3: lie scale -------------------------------------------------------------------
page(function() {
  d <- function(x) dt(x,r3$v); xl <- c(-4,4)
  start_page(bquote('Úkol 3 b): jednostranný '*italic(t)*'-test, '*H[1]*': μ > 3,87'),
             bquote(italic(t)*'-rozdělení s '*.(r3$v)*' stupni volnosti;  '*italic(t)*' = (4,39 − 3,87) / '*.(num(r3$se,3))*' = '*.(num(r3$t,3))),
             xl,c(0,.43),bquote('Hodnota statistiky '*italic(t)),xat=-4:4)
  area(r3$t,xl[2],d,col=c_orange,border=NA)
  curve_line(d,xl,lwd=2.6,col=c_blue)
  vline(r3$tc,.26,paste0('kritická hodnota\n',num(r3$tc,3)),.3)
  arrows(r3$t-.9,.22,r3$t,dt(r3$t,r3$v)+.004,length=.08,lwd=1.8,col=c_orange)
  text(r3$t-.95,.225,paste0('t = ',num(r3$t,2)),adj=c(1,.5),cex=.95,font=2,col=c_orange)
  panel(list(
    list(type='head',text=bquote('Plochy za '*H[0]*' (μ = 3,87)')),
    list(type='fill',col=c_orange,text=paste0('p-hodnota: ',num(r3$p_hi,3)),tcol=c_orange),
    list(type='text',text='Kritický obor tvoří 5 % plochy vpravo
od kritické hodnoty 1,690.',cex=.9),
    list(type='gap'),
    list(type='text',text='Statistika neleží v kritickém oboru:\nprůměr 4,39 by se při μ = 3,87 vyskytl\nv asi 12 % výběrů 36 dětí.'),
    list(type='gap'),
    list(type='text',text=bquote(bold('Rozhodnutí: nezamítáme ')*bold(H[0])*bold('.')))))
})
page(function() {
  start_page('Úkol 3 c): soulad intervalů s rozhodnutím testu',
             paste0('95 %: (',num(r3$ci95[1],2),'; ',num(r3$ci95[2],2),'),  90 %: (',num(r3$ci90[1],2),'; ',num(r3$ci90[2],2),')'),
             c(3,5.6),c(0,2),'Průměr škály lži',ylab='',yaxis=FALSE,xat=seq(3,5.6,.2),digits=1)
  vline(u3['mu0'],1.8,'populační průměr 3,87',1.88,col=c_gray)
  ci_row(1,r3,'36 dětí ve stresu')
  panel(list(
    list(type='head',text='Intervaly'),
    list(type='line',col=c_blue,lwd=2,text='95% interval: obsahuje 3,87'),
    list(type='line',col=c_blue,lwd=9,text=paste0('90% interval: dolní mez ',num(r3$ci90[1],2))),
    list(type='gap'),
    list(type='text',text='Oboustranný test by nezamítl, protože\n3,87 leží uvnitř 95% intervalu.'),
    list(type='text',text='Jednostranný test „větší“ nezamítá,\nprotože dolní mez 90% intervalu\nleží pod 3,87.'),
    list(type='gap'),
    list(type='text',text='S daty jsou slučitelné průměry mírně\npod populační hodnotou i o více než\n1 bod nad ní: výsledek je neprůkazný.',col=c_gray,font=3)))
})

# U4: tablet version ---------------------------------------------------------------
page(function() {
  br <- seq(77.5,132.5,5); h <- hist(u4$x,breaks=br,plot=FALSE)
  start_page('Úkol 4 a): skóre 60 dětí v tabletové verzi',
             paste0('List U4_tablet_ekvivalence, C4:C63;  m = ',num(r4a$m,2),',  s = ',num(r4a$s,2),' (modelová data)'),
             c(75,135),c(0,15),'Skóre v testu čtenářského porozumění',ylab='Počet dětí',xat=seq(75,135,5))
  vline(100,13,'norma 100',13.4,col=c_gray,pos=4)
  vline(85,13,'pod 85: doporučení',13.4,col=c_orange,pos=4)
  rect(br[-length(br)],0,br[-1],h$counts,col=c_fill,border='white')
  # Count labels on a background patch so the reference lines do not cross them.
  lab <- h$counts>0
  rect(h$mids[lab]-.9,h$counts[lab]+.15,h$mids[lab]+.9,h$counts[lab]+.85,col=par('bg'),border=NA)
  text(h$mids[lab],h$counts[lab]+.3,h$counts[lab],adj=c(.5,0),cex=.9,col=c_ink)
  panel(list(
    list(type='head',text='Co graf ukazuje'),
    list(type='fill',col=c_fill,text='počet dětí v intervalu 5 bodů'),
    list(type='gap'),
    list(type='text',text=paste0('Průměr ',num(r4a$m,2),' leží blízko normy 100;\nvariabilita (s = ',num(r4a$s,1),') je o něco menší\nnež SD 15 podle norem.')),
    list(type='gap'),
    list(type='text',text=paste0('Pod 85 bodů má skóre ',sum(u4$x<85),' dětí z 60.')),
    list(type='gap'),
    list(type='text',text='Data jsou simulovaná z normálního\nmodelu, nejde o skutečné výsledky.',col=c_gray,font=3)))
})
page(function() {
  lo <- u4$par['mu0']-u4$par['delta']; hi <- u4$par['mu0']+u4$par['delta']
  start_page('Úkol 4 b) až e): test rozdílu a test ekvivalence',
             paste0('Pásmo ekvivalence ',num(lo,0),'–',num(hi,0),' bodů stanovené předem; norma ',num(u4$par['mu0'],0)),
             c(92,110),c(0,3),'Skóre v testu čtenářského porozumění',ylab='',yaxis=FALSE,xat=seq(92,110,2))
  rect(lo,0,hi,2.75,col=c_pale,border=NA)
  segments(c(lo,hi),0,c(lo,hi),2.75,lty=2,lwd=1.6,col=c_ink)
  vline(u4$par['mu0'],2.75,'norma 100',2.86,col=c_gray,lty=3)
  ci_row(2,r4a,paste0('všech 60 dětí: ekvivalence doložena'))
  ci_row(1,r4b,paste0('prvních 15 dětí: neprůkazné'),col=c_orange)
  panel(list(
    list(type='head',text='Intervaly'),
    list(type='line',col=c_ink,lwd=2,text='95%: test rozdílu od 100'),
    list(type='line',col=c_ink,lwd=9,text='90%: test ekvivalence'),
    list(type='fill',col=c_pale,text='pásmo ekvivalence'),
    list(type='gap'),
    list(type='text',text=paste0('60 dětí: 95% interval obsahuje 100\n(p = ',num(r4a$p2,3),'), 90% interval (',num(r4a$ci90[1],2),';\n',num(r4a$ci90[2],2),') leží celý v pásmu.')),
    list(type='text',text=paste0('15 dětí: 95% interval obsahuje 100\n(p = ',num(r4b$p2,3),'), 90% interval přesahuje\nhorní hranici (',num(r4b$ci90[2],2),' > 105).')),
    list(type='gap'),
    list(type='text',text='Nezamítnutí rozdílu u 15 dětí\nneznamená shodu s normou.',font=2)))
})

cairo_pdf(out_file,width=13.33,height=7.5,onefile=TRUE,family='Arial')
for(f in pages) f()
invisible(dev.off())
options(old_options)
for(nm in c('r1','r2','r3','r4a','r4b')) { r <- get(nm)
  cat(sprintf('%s: m=%.4f s=%.4f t=%.4f p_hi=%.6f p2=%.6f ci95=(%.2f; %.2f) ci90=(%.2f; %.2f)\n',nm,r$m,r$s,r$t,r$p_hi,r$p2,r$ci95[1],r$ci95[2],r$ci90[1],r$ci90[2])) }
cat(sprintf('pages: %d\n',length(pages)))
