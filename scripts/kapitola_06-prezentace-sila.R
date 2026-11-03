# Helper graphs for slide 36 of the chapter 6 presentation (task 4: what changes the power).
# Normal model of the chapter: sigma = 15 s, 100 drivers per group, SE of the difference 2.12 s.
# Run from the project root: Rscript scripts/kapitola_06-prezentace-sila.R
# Output: presentations/kapitola_06_uloha_4_sila_grafy.pdf, one graph per page (16:9).
out_file <- 'presentations/kapitola_06_uloha_4_sila_grafy.pdf'
old_options <- options(OutDec=',')

# Chapter 6 palette (scripts/kapitola_06.R).
c_blue <- '#245D78'; c_orange <- '#B54E24'; c_fill <- '#B8DDE8'; c_gray <- '#4D5A63'; c_ink <- '#223744'; c_h0 <- '#7B868E'
num <- function(x,digits=2) formatC(x,format='f',digits=digits,decimal.mark=',')
fmt_p <- function(x) if(x<.001) 'méně než 0,001' else num(x)
# Value after a label: ' = 0,65', or ' < 0,001' / ' > 0,999' for extreme probabilities.
eq_p <- function(x) if(x<.001) ' < 0,001' else if(x>.999) ' > 0,999' else paste0(' = ',num(x))

# One scenario = one page. sides: 'two', 'right' (H1 "longer") or 'left' (H1 "shorter").
scenario <- function(label,title,alpha=.05,n=100,sigma=15,delta=5,sides='two',note=NULL) {
  se <- sigma*sqrt(2/n)
  z <- if(sides=='two') qnorm(1-alpha/2) else qnorm(1-alpha)
  crit <- switch(sides,two=c(-1,1)*z*se,right=z*se,left=-z*se)
  power <- switch(sides,
    two=pnorm(-z*se,delta,se)+pnorm(z*se,delta,se,lower.tail=FALSE),
    right=pnorm(z*se,delta,se,lower.tail=FALSE),
    left=pnorm(-z*se,delta,se))
  list(label=label,title=title,alpha=alpha,n=n,sigma=sigma,delta=delta,sides=sides,se=se,crit=crit,power=power,note=note)
}
base <- scenario('Výchozí stav','Výchozí stav: oboustranný test, α = 0,05, 100 řidičů ve skupině')
scenarios <- list(
  base,
  scenario('a) α = 0,01','a) Přísnější hladina: α = 0,01',alpha=.01),
  scenario('b) n = 200','b) Větší výběr: 200 řidičů v každé skupině',n=200),
  scenario('c) σ = 12 s','c) Přesnější měření: menší směrodatná odchylka dob',sigma=12,
    note='σ = 12 s je jen ilustrativní hodnota;\nsměr změn platí pro každé zmenšení σ.'),
  scenario('d) rozdíl 3 s','d) Menší skutečný rozdíl: jen 3 s',delta=3),
  scenario('e) jednostranný „déle“','e) Jednostranný test ve směru „déle“ (zvolený předem)',sides='right'),
  scenario('e) jednostranný „kratší“','e) Jednostranný test ve směru „kratší“ (zvolený předem)',sides='left',
    note='Skutečný rozdíl +5 s leží na opačné straně,\nnež kterou test sleduje: prakticky nikdy\nnezamítne.')
)

xlim <- c(-10,16); ylim <- c(0,.37)
area <- function(from,to,mean,sd,...) {
  if(to<=from) return(invisible())
  x <- seq(from,to,length.out=300)
  polygon(c(from,x,to),c(0,dnorm(x,mean,sd),0),...)
}
swatch <- function(y,col,density=NULL,border=NA) {
  rect(.02,y-.022,.10,y+.022,col=if(is.null(density)) col else 'white',border=border)
  if(!is.null(density)) rect(.02,y-.022,.10,y+.022,col=c_ink,density=density,angle=45,border=c_ink,lwd=.8)
}
change_text <- function(now,before,what) {
  if(abs(now-before)<.005) paste0(what,' beze změny (',num(now),')')
  else paste0(what,if(now>before) ' vzroste' else ' klesne',' z ',num(before),' na ',fmt_p(now))
}

draw_page <- function(s) {
  layout(matrix(1:2,1),widths=c(2.6,1.4))
  # Main graph ---------------------------------------------------------------
  par(mar=c(4.6,4.8,4.4,1),mgp=c(2.9,.7,0),las=1,col.axis=c_ink,col.lab=c_ink,fg=c_ink,cex=1.05)
  plot(NA,xlim=xlim,ylim=ylim,xaxs='i',yaxs='i',bty='l',xaxt='n',
       xlab=expression('Rozdíl výběrových průměrů '*italic(m)[1]-italic(m)[2]*' (s)'),ylab='Hustota pravděpodobnosti')
  axis(1,at=seq(-10,16,2),labels=sub('^-','−',seq(-10,16,2)))
  title(s$title,line=2.4,adj=0,cex.main=1.18,col.main=c_ink)
  mtext(paste0('σ = ',num(s$sigma,0),' s,  n = ',s$n,' v každé skupině,  směrodatná chyba rozdílu ',num(s$se),' s'),
        side=3,line=.9,adj=0,cex=.92,col=c_gray)
  lo <- xlim[1]; hi <- xlim[2]; d <- s$delta; se <- s$se
  # Under H1: power (rejection region) in orange, beta (no rejection) in light blue.
  if(s$sides=='two') {
    area(lo,s$crit[1],d,se,col=c_orange,border=NA); area(s$crit[2],hi,d,se,col=c_orange,border=NA)
    area(s$crit[1],s$crit[2],d,se,col=c_fill,border=NA)
  } else if(s$sides=='right') {
    area(s$crit,hi,d,se,col=c_orange,border=NA); area(lo,s$crit,d,se,col=c_fill,border=NA)
  } else {
    area(lo,s$crit,d,se,col=c_orange,border=NA); area(s$crit,hi,d,se,col=c_fill,border=NA)
  }
  # Under H0: alpha hatched on top, so the power area stays visible beneath it.
  for(k in seq_along(s$crit)) {
    if(s$crit[k]>0) area(s$crit[k],hi,0,se,col=c_ink,density=28,angle=45,border=NA,lwd=.9)
    else area(lo,s$crit[k],0,se,col=c_ink,density=28,angle=45,border=NA,lwd=.9)
  }
  x <- seq(lo,hi,length.out=800)
  lines(x,dnorm(x,0,se),lwd=2.4,col=c_h0)
  lines(x,dnorm(x,d,se),lwd=2.6,col=c_blue)
  # Curve labels above the peaks, nudged away from a nearby dashed line.
  peak <- dnorm(0,0,se)
  place <- function(x0) { for(cv in s$crit) if(abs(x0-cv)<.9) x0 <- cv+sign(x0-cv+1e-9)*.9; x0 }
  text(place(0),peak+.014,expression(H[0]),cex=1.1,col=c_h0,font=2)
  text(place(d),peak+.014,expression(H[1]),cex=1.1,col=c_blue,font=2)
  # Critical values: dashed lines with labels in the free top band.
  for(cv in s$crit) {
    segments(cv,0,cv,.322,lty=2,lwd=1.6,col=c_ink)
    text(cv,.338,paste0(sub('^-','−',num(cv)),' s'),cex=.92,col=c_ink,font=2)
    side <- if(cv>0) 4 else 2
    text(cv,.306,if(cv>0) 'kritický obor →' else '← kritický obor',pos=side,offset=.35,cex=.84,col=c_ink)
  }
  # Side panel -----------------------------------------------------------------
  par(mar=c(4.6,.4,4.4,.6)); plot.new(); plot.window(c(0,1),c(0,1))
  y <- .97; cx <- 1
  text(0,y,'Výběrové rozdělení',adj=0,font=2,cex=cx,col=c_ink); y <- y-.06
  segments(.02,y,.10,y,lwd=2.4,col=c_h0)
  text(.13,y,bquote(H[0]*': skutečný rozdíl 0 s'),adj=0,cex=cx,col=c_ink); y <- y-.055
  segments(.02,y,.10,y,lwd=2.6,col=c_blue)
  text(.13,y,bquote(H[1]*': skutečný rozdíl '*.(num(d,0))*' s'),adj=0,cex=cx,col=c_ink); y <- y-.05
  segments(.02,y,.10,y,lty=2,lwd=1.6,col=c_ink)
  text(.13,y,'kritická hodnota',adj=0,cex=cx,col=c_ink); y <- y-.085
  text(0,y,'Plochy = pravděpodobnosti',adj=0,font=2,cex=cx,col=c_ink); y <- y-.065
  swatch(y,NULL,density=28)
  text(.13,y+.012,paste0('α = ',num(s$alpha)),adj=0,cex=cx,font=2,col=c_ink)
  text(.13,y-.024,bquote('chyba I. druhu (pod '*H[0]*')'),adj=0,cex=.86,col=c_gray); y <- y-.085
  swatch(y,c_fill)
  text(.13,y+.012,paste0('β',eq_p(1-s$power)),adj=0,cex=cx,font=2,col=c_ink)
  text(.13,y-.024,bquote('chyba II. druhu (pod '*H[1]*')'),adj=0,cex=.86,col=c_gray); y <- y-.085
  swatch(y,c_orange)
  text(.13,y+.012,paste0('síla 1 − β',eq_p(s$power)),adj=0,cex=cx,font=2,col=c_orange)
  text(.13,y-.024,bquote('zamítnutí '*H[0]*', když platí '*H[1]),adj=0,cex=.86,col=c_gray); y <- y-.1
  if(!identical(s,base)) {
    text(0,y,'Oproti výchozímu stavu',adj=0,font=2,cex=cx,col=c_ink); y <- y-.06
    text(0,y,change_text(s$alpha,base$alpha,'α'),adj=0,cex=.92,col=c_ink); y <- y-.05
    text(0,y,change_text(s$power,base$power,'síla'),adj=0,cex=.92,col=c_ink); y <- y-.05
    text(0,y,if(s$power<.001) paste0('β vzroste z ',num(1-base$power),' téměř na 1') else change_text(1-s$power,1-base$power,'β'),adj=0,cex=.92,col=c_ink); y <- y-.075
  }
  if(!is.null(s$note)) text(0,y,s$note,adj=c(0,1),cex=.88,col=c_gray,font=3)
}

draw_summary <- function() {
  layout(1); par(mar=c(4.8,15.5,4.4,5.5),mgp=c(2.9,.7,0),las=1,col.axis=c_ink,col.lab=c_ink,fg=c_ink,cex=1.05)
  k <- length(scenarios); pw <- sapply(scenarios,`[[`,'power'); yy <- rev(seq_len(k))
  plot(NA,xlim=c(0,1),ylim=c(.4,k+.6),yaxt='n',xaxt='n',xaxs='i',bty='l',xlab=expression('Statistická síla při skutečném rozdílu podle '*H[1]),ylab='')
  axis(1,at=seq(0,1,.2),labels=num(seq(0,1,.2),1))
  abline(v=seq(.2,1,.2),col='#E1E8EB',lwd=1)
  rect(0,yy-.32,pw,yy+.32,col=c_orange,border=NA)
  rect(pw,yy-.32,1,yy+.32,col=c_fill,border=NA)
  abline(v=base$power,lty=2,lwd=1.5,col=c_ink)
  lab <- sapply(scenarios,`[[`,'label')
  axis(2,at=yy,labels=lab,tick=FALSE,cex.axis=.95)
  text(1.01,yy,paste0('α = ',sapply(scenarios,function(s) num(s$alpha))),adj=0,xpd=NA,cex=.85,col=c_ink)
  inside <- pw>.2; lab_pw <- ifelse(pw<.001,'< 0,001',num(pw))
  text(pw[inside]-.012,yy[inside],lab_pw[inside],adj=1,cex=.9,font=2,col='white')
  text(pw[!inside]+.012,yy[!inside],lab_pw[!inside],adj=0,cex=.9,font=2,col=c_ink)
  title('Přehled: síla a β ve všech situacích úlohy',line=2.4,adj=0,cex.main=1.18,col.main=c_ink)
  mtext('oranžově síla 1 − β, modře β; přerušovaná čára = síla výchozího stavu (0,65)',side=3,line=.9,adj=0,cex=.92,col=c_gray)
}

cairo_pdf(out_file,width=13.33,height=7.5,onefile=TRUE,family='Arial')
for(s in scenarios) draw_page(s)
draw_summary()
invisible(dev.off())
options(old_options)
for(s in scenarios) cat(sprintf('%-28s alpha=%.2f se=%.3f crit=%s power=%.4f\n',s$label,s$alpha,s$se,paste(round(s$crit,3),collapse='/'),s$power))
