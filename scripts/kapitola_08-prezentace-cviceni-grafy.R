# Helper graphs for the Excel exercises of the chapter 8 presentation
# (presentations/kapitola_08_porovnani_dvou_prumeru_cviceni.xlsx, sheets U1 to U4).
# Inputs are read from the workbook, so the graphs follow its data. Needs the readxl package.
# Run from the project root: Rscript scripts/kapitola_08-prezentace-cviceni-grafy.R
# Output: presentations/kapitola_08_porovnani_dvou_prumeru_cviceni_grafy.pdf, one page per sheet (16:9).
suppressPackageStartupMessages(library(readxl))
wb <- 'presentations/kapitola_08_porovnani_dvou_prumeru_cviceni.xlsx'
out_file <- 'presentations/kapitola_08_porovnani_dvou_prumeru_cviceni_grafy.pdf'
old_options <- options(OutDec=',')

cells <- function(sheet,range) {
  x <- read_excel(wb,sheet=sheet,range=range,col_names=FALSE,.name_repair='minimal')
  as.numeric(unlist(x,use.names=FALSE))
}
u1 <- data.frame(ticho=cells('U1_parova_data','D4:D17'),hluk=cells('U1_parova_data','E4:E17'))
u2 <- list(a=cells('U2_dve_skupiny','C4:C19'),b=cells('U2_dve_skupiny','D4:D18'))
u3 <- data.frame(pred=cells('U3_zmeny_skupin','D4:D31'),po=cells('U3_zmeny_skupin','E4:E31'),int=rep(c(TRUE,FALSE),each=14))
u4 <- matrix(c(cells('U4_ekvivalence','D4:D10'),cells('U4_ekvivalence','E4:E10')),ncol=2,
             dimnames=list(c('n1','m1','s1','n2','m2','s2','delta'),c('velka','mala')))
stopifnot(nrow(u1)==14,sum(complete.cases(u1))==12,length(u2$a)==16,length(u2$b)==15,!anyNA(c(u2$a,u2$b,u3$pred,u3$po,u4)))

# Chapter palette (scripts/kapitola_08.R, graphs of chapter 7 exercises) ----------
c_blue <- '#245D78'; c_orange <- '#B54E24'; c_fill <- '#B8DDE8'; c_gray <- '#4D5A63'; c_pale <- '#E1E8EB'
c_ink <- '#223744'; c_mute <- '#A9BAC3'
num <- function(x,digits=2) sub('^-','−',formatC(x,format='f',digits=digits,decimal.mark=','))
pval <- function(p) if(p<.001) '< 0,001' else num(p,3)
ci_txt <- function(ci) paste0('(',num(ci[1]),'; ',num(ci[2]),')')

# One mean (or mean difference) and two independent means with a pooled variance.
one <- function(x) {
  n <- length(x); se <- sd(x)/sqrt(n); t <- mean(x)/se
  list(n=n,m=mean(x),s=sd(x),se=se,v=n-1,t=t,p=2*pt(-abs(t),n-1),ci=mean(x)+c(-1,1)*qt(.975,n-1)*se)
}
two <- function(m1,s1,n1,m2,s2,n2) {
  sp <- sqrt(((n1-1)*s1^2+(n2-1)*s2^2)/(n1+n2-2)); se <- sp*sqrt(1/n1+1/n2); v <- n1+n2-2; r <- m1-m2; t <- r/se
  list(diff=r,sp=sp,se=se,v=v,t=t,p=2*pt(-abs(t),v),ci95=r+c(-1,1)*qt(.975,v)*se,ci90=r+c(-1,1)*qt(.95,v)*se,d=r/sp)
}
ok <- complete.cases(u1); r1 <- one(u1$ticho[ok]-u1$hluk[ok])
r2 <- two(mean(u2$a),sd(u2$a),16,mean(u2$b),sd(u2$b),15)
zm <- u3$po-u3$pred; r3a <- one(zm[u3$int]); r3b <- one(zm[!u3$int])
r3 <- two(r3a$m,r3a$s,14,r3b$m,r3b$s,14)
r4 <- lapply(1:2,function(j) two(u4['m1',j],u4['s1',j],u4['n1',j],u4['m2',j],u4['s2',j],u4['n2',j]))

# Page frame: graphs on the left, explanatory panel on the right -------------------
frame <- function(widths) { layout(matrix(seq_along(widths),1),widths=widths); par(las=1,col.axis=c_ink,col.lab=c_ink,fg=c_ink,cex=1.05,mgp=c(2.9,.7,0)) }
heading <- function(title,subtitle=NULL) {
  title(title,line=2.4,adj=0,cex.main=1.12,col.main=c_ink)
  if(!is.null(subtitle)) mtext(subtitle,side=3,line=.9,adj=0,cex=.88,col=c_gray)
}
panel <- function(items) {
  par(mar=c(4.6,.6,4.6,.6)); plot.new(); plot.window(c(0,1),c(0,1)); y <- .98
  for(it in items) {
    if(is.null(it$text)) { y <- y-.035; next }
    nl <- length(strsplit(it$text,'\n')[[1]])
    text(0,y,it$text,adj=c(0,1),cex=if(isTRUE(it$head)) 1 else .92,font=if(isTRUE(it$head)) 2 else 1,col=if(is.null(it$col)) c_ink else it$col)
    y <- y-.047*nl-.02
  }
}
H <- function(text) list(text=text,head=TRUE); T <- function(text,col=NULL) list(text=text,col=col); G <- list()
ci_bar <- function(y,ci,m,col,lwd=4) { segments(ci[1],y,ci[2],y,col=col,lwd=lwd,lend=1); points(m,y,pch=21,bg='white',col=col,cex=1.5,lwd=2) }

page_u1 <- function() {
  frame(c(1.35,1.45,1.3))
  par(mar=c(4.6,4.8,4.6,1))
  rng <- range(u1,na.rm=TRUE)+c(-2,2)
  plot(NA,xlim=c(.6,2.4),ylim=rng,xaxt='n',bty='l',xlab='',ylab='Počet vybavených slov')
  axis(1,at=1:2,labels=c('ticho','hluk'))
  segments(1,u1$ticho[ok],2,u1$hluk[ok],col=c_blue,lwd=1.6)
  points(rep(1,sum(ok)),u1$ticho[ok],pch=21,bg='white',col=c_blue,cex=1.3); points(rep(2,sum(ok)),u1$hluk[ok],pch=21,bg='white',col=c_blue,cex=1.3)
  points(1,u1$ticho[!ok & !is.na(u1$ticho)],pch=4,col=c_orange,lwd=2.4,cex=1.4); points(2,u1$hluk[!ok & !is.na(u1$hluk)],pch=4,col=c_orange,lwd=2.4,cex=1.4)
  heading('U1: titíž studenti dvakrát','spojnice = jeden student; × = neúplná dvojice')
  D <- u1$ticho[ok]-u1$hluk[ok]
  par(mar=c(4.6,3,4.6,1))
  plot(NA,xlim=range(c(D,0))+c(-2,2),ylim=c(0,1),yaxt='n',bty='l',xlab='Rozdíl ticho − hluk (slova)',ylab='')
  abline(v=0,lty=2,col=c_gray)
  yy <- ave(D,D,FUN=function(z) .55+.07*(seq_along(z)-1))
  points(D,yy,pch=16,col=c_blue,cex=1.4)
  ci_bar(.3,r1$ci,r1$m,c_ink)
  text(r1$m,.2,paste0('průměr ',num(r1$m),'; 95% interval ',ci_txt(r1$ci)),cex=.85,col=c_ink)
  heading('Rozdíly úplných dvojic','každý bod = rozdíl jednoho studenta')
  panel(list(H('Párový t-test'),T(paste0('úplných dvojic n = ',r1$n)),T(paste0('průměr rozdílů ',num(r1$m),' slova')),
    T(paste0('směrodatná odchylka rozdílů ',num(r1$s))),T(paste0('směrodatná chyba ',num(r1$se,3))),
    T(paste0('t = ',num(r1$t),'; v = ',r1$v,'; p = ',pval(r1$p))),G,H('95% interval'),T(paste0(ci_txt(r1$ci),' slova')),G,
    H('Čeho si všimnout'),T('Studenti se mezi sebou liší\nmnohem víc než jejich rozdíly.\nSpojnice většinou klesají.',c_gray),
    T(paste0('Rozdíl průměrů sloupců ze všech\nvyplněných hodnot by byl ',num(mean(u1$ticho,na.rm=TRUE)-mean(u1$hluk,na.rm=TRUE)),':\nporovnával by různé skupiny lidí.'),c_gray)))
}

page_u2 <- function() {
  frame(c(1.5,1.3,1.3))
  par(mar=c(4.6,4.8,4.6,1))
  plot(NA,xlim=c(.5,2.5),ylim=range(c(u2$a,u2$b))+c(-2,2),xaxt='n',bty='l',xlab='',ylab='Body v závěrečném testu')
  axis(1,at=1:2,labels=c('zkoušení (n = 16)','čtení (n = 15)'))
  jit <- function(x) ave(x,x,FUN=function(z) (seq_along(z)-(length(z)+1)/2)*.07)
  points(1+jit(u2$a),u2$a,pch=16,col=c_blue,cex=1.3); points(2+jit(u2$b),u2$b,pch=16,col=c_orange,cex=1.3)
  segments(c(.75,1.75),c(mean(u2$a),mean(u2$b)),c(1.25,2.25),lwd=3,col=c_ink)
  text(c(1.3,2.3),c(mean(u2$a),mean(u2$b)),num(c(mean(u2$a),mean(u2$b))),adj=0,cex=.85,col=c_ink,xpd=NA)
  heading('U2: dvě nezávislé skupiny','body = studenti; úsečka = průměr skupiny')
  par(mar=c(4.6,3,4.6,1))
  plot(NA,xlim=range(c(r2$ci95,0))+c(-2,2),ylim=c(0,1),yaxt='n',bty='l',xlab='Rozdíl průměrů zkoušení − čtení (body)',ylab='')
  abline(v=0,lty=2,col=c_gray); ci_bar(.5,r2$ci95,r2$diff,c_ink)
  text(r2$diff,.38,paste0(num(r2$diff),'; 95% interval ',ci_txt(r2$ci95)),cex=.85,col=c_ink)
  heading('Interval pro rozdíl průměrů','klasický t-test, společný odhad rozptylu')
  panel(list(H('Souhrny skupin'),T(paste0('zkoušení: m = ',num(mean(u2$a)),'; s = ',num(sd(u2$a)))),T(paste0('čtení: m = ',num(mean(u2$b)),'; s = ',num(sd(u2$b)))),G,
    H('Klasický t-test'),T(paste0('společná směrodatná odchylka ',num(r2$sp))),T(paste0('směrodatná chyba rozdílu ',num(r2$se))),
    T(paste0('t = ',num(r2$t),'; v = ',r2$v,'; p = ',pval(r2$p))),G,H('Velikost rozdílu'),T(paste0('rozdíl ',num(r2$diff),' bodu ',ci_txt(r2$ci95))),
    T(paste0('Cohenovo d = ',num(r2$d),' (společná\nsměrodatná odchylka)')),G,H('Čeho si všimnout'),
    T('Skupiny se z velké části překrývají;\ninterval rozdílu je široký, ale nulu\nnezahrnuje.',c_gray)))
}

page_u3 <- function() {
  frame(c(2.7,1.3))
  par(mar=c(4.6,10.5,4.6,3))
  xl <- range(c(r3a$ci,r3b$ci,r3$ci95))+c(-1,1.5)
  plot(NA,xlim=xl,ylim=c(.4,3.6),yaxt='n',bty='l',xlab='Body',ylab='')
  axis(2,at=3:1,labels=c('změna: intervence','změna: kontrola','rozdíl změn'),tick=FALSE)
  abline(v=0,lty=2,col=c_gray)
  ci_bar(3,r3a$ci,r3a$m,c_blue); ci_bar(2,r3b$ci,r3b$m,c_mute); ci_bar(1,r3$ci95,r3$diff,c_ink)
  text(xl[2],3:1+.28,paste0('p = ',c(pval(r3a$p),pval(r3b$p),pval(r3$p))),adj=1,cex=.9,font=3,col=c_gray)
  text(c(r3a$m,r3b$m,r3$diff),3:1-.28,c(paste0(num(r3a$m),' ',ci_txt(r3a$ci)),paste0(num(r3b$m),' ',ci_txt(r3b$ci)),paste0(num(r3$diff),' ',ci_txt(r3$ci95))),cex=.85,col=c_ink)
  heading('U3: změna duševní pohody za čtyři týdny, 95% intervaly','změna = po − před; rozdíl změn = intervence − kontrola')
  panel(list(H('Uvnitř skupin (párové t-testy)'),T(paste0('intervence: t = ',num(r3a$t),'; v = 13; p = ',pval(r3a$p))),
    T(paste0('kontrola: t = ',num(r3b$t),'; v = 13; p = ',pval(r3b$p))),G,H('Mezi skupinami (klasický t-test)'),
    T(paste0('rozdíl změn ',num(r3$diff),' bodu')),T(paste0('směrodatná chyba ',num(r3$se))),T(paste0('t = ',num(r3$t),'; v = ',r3$v,'; p = ',pval(r3$p))),G,
    H('Čeho si všimnout'),T('Jeden interval změny nulu\nnezahrnuje, druhý ano. Přesto se\nz velké části překrývají.',c_gray),
    T('O účinku programu vypovídá\ninterval rozdílu změn, a ten nulu\nzahrnuje.',c_gray)))
}

page_u4 <- function() {
  frame(c(2.7,1.3))
  par(mar=c(4.6,10.5,4.6,3))
  dl <- u4['delta',1]; xl <- range(c(r4[[2]]$ci95,-dl,dl))+c(-1,1)
  plot(NA,xlim=xl,ylim=c(.4,2.6),yaxt='n',bty='l',xlab='Rozdíl průměrů prezenčně − online (body)',ylab='')
  rect(-dl,.4,dl,2.6,col=c_fill,border=NA); abline(v=c(-dl,dl),lty=2,col=c_blue); abline(v=0,lty=3,col=c_gray)
  lab <- paste0(u4['n1',],' + ',u4['n2',],' lidí')
  axis(2,at=2:1,labels=lab,tick=FALSE)
  for(j in 1:2) { y <- 3-j
    segments(r4[[j]]$ci95[1],y,r4[[j]]$ci95[2],y,col=c_ink,lwd=1.4); segments(r4[[j]]$ci95,y-.06,r4[[j]]$ci95,y+.06,col=c_ink,lwd=1.4)
    ci_bar(y,r4[[j]]$ci90,r4[[j]]$diff,c_blue,6)
    text(r4[[j]]$diff,y-.25,paste0('90% ',ci_txt(r4[[j]]$ci90),'   95% ',ci_txt(r4[[j]]$ci95)),cex=.85,col=c_ink) }
  heading(paste0('U4: dvě studie vůči pásmu ekvivalence ±',num(dl,0),' bodů'),'silná úsečka = 90% interval (test ekvivalence); tenká = 95% interval (test rozdílu)')
  panel(list(H(lab[1]),T(paste0('směrodatná chyba ',num(r4[[1]]$se),'; p rozdílu = ',pval(r4[[1]]$p))),T('90% interval uvnitř pásma:\nekvivalence doložena'),G,
    H(lab[2]),T(paste0('směrodatná chyba ',num(r4[[2]]$se),'; p rozdílu = ',pval(r4[[2]]$p))),T('90% interval přesahuje hranici:\nnerozhodný výsledek'),G,
    H('Čeho si všimnout'),T('Rozdíl průměrů je v obou studiích\nstejný a test rozdílu v obou\nnevýznamný.',c_gray),
    T('Liší se přesností: jen velká studie\nvylučuje rozdíly za hranicemi.',c_gray)))
}

cairo_pdf(out_file,width=13.33,height=7.5,onefile=TRUE,family='Arial')
page_u1(); page_u2(); page_u3(); page_u4()
invisible(dev.off())
options(old_options)
cat('Saved',out_file,'\n')
