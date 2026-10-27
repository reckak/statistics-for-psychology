# Original teaching examples for chapter 5; base R, UTF-8, deterministic project-root paths.
# Model values and simulations only; no empirical psychological data.
ch5_out <- 'assets/chapter-05/plots'
ch5_old_options <- options(OutDec=',')
dir.create(ch5_out,recursive=TRUE,showWarnings=FALSE)
ch5_blue <- '#245D78'; ch5_orange <- '#B54E24'; ch5_fill <- '#B8DDE8'; ch5_gray <- '#4D5A63'; ch5_pale <- '#E1E8EB'; ch5_sand <- '#FAECDD'
ch5_num <- function(x,digits=3) formatC(x,format='f',digits=digits,decimal.mark=',')
ch5_draw <- function(name,code,width=8,height=4.5) {
  svg(file.path(ch5_out,paste0(name,'.svg')),width=width,height=height,family='sans',bg='white')
  par(mar=c(4.5,4.5,2.6,.8),mgp=c(2.7,.7,0),las=1,col.axis='#223744',col.lab='#223744',fg='#223744',cex=.9)
  force(code); dev.off()
}
# Fixed teaching inputs -------------------------------------------------------
ch5_cards <- c(podstatna=40,slovesa=35,pridavna=25)
ch5_dependent <- matrix(c(40,60,30,70),2,byrow=TRUE,dimnames=list(c('Žena','Muž'),c('Zvýšený stres','Nízký stres')))
ch5_independent <- matrix(c(30,70,30,70),2,byrow=TRUE,dimnames=dimnames(ch5_dependent))
ch5_sens <- .95; ch5_spec <- .90
# Natural frequencies: state present/absent by positive/negative result.
ch5_screen <- function(total,prev,sens=ch5_sens,spec=ch5_spec) {
  present <- total*prev; absent <- total-present
  c(present=present,absent=absent,tp=present*sens,fn=present*(1-sens),fp=absent*(1-spec),tn=absent*spec)
}
ch5_ppv <- function(f) unname(f['tp']/(f['tp']+f['fp']))
ch5_npv <- function(f) unname(f['tn']/(f['tn']+f['fn']))
ch5_n <- 5; ch5_pi <- .25
# Simulations: guessing one of four options; seeds fixed for reproducible figures.
set.seed(5)
ch5_runs <- vapply(1:5,function(j) cumsum(rbinom(1000,1,ch5_pi))/(1:1000),numeric(1000))
set.seed(20261012)
ch5_sim_hadani <- rbinom(40,ch5_n,ch5_pi)
# Figures -----------------------------------------------------------------------
ch5_draw('relativni-cetnost', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,2.2))
  cols <- c(ch5_blue,'#6E9FB3','#8A6D3B',ch5_gray,'#7A4E8A')
  for(k in 1:2) {
    m <- c(50,1000)[k]
    plot(NA,xlim=c(1,m),ylim=c(0,if(k==1)1 else .5),xlab='Počet dosavadních pokusů',ylab='Relativní četnost správných tipů',main=c('Prvních 50 pokusů','Celých 1 000 pokusů')[k],bty='l')
    abline(h=ch5_pi,lty=2,lwd=1.8,col=ch5_orange)
    for(j in 1:5) lines(1:m,ch5_runs[1:m,j],col=cols[j],lwd=1.5,lty=j)
    axis(4,at=ch5_pi,labels='0,25',col.axis=ch5_orange,tick=FALSE,line=-.9)
  }
},width=10,height=4.4)
ch5_draw('karticky', {
  par(mar=c(.6,.6,2.4,.6))
  plot(NA,xlim=c(0,14.6),ylim=c(-.2,10.2),axes=FALSE,xlab='',ylab='',asp=1,main='Sto kartiček se slovy: 100 možných výsledků')
  kind <- rep(1:3,ch5_cards); fills <- c(ch5_fill,ch5_sand,ch5_pale); lab <- c('P','S','A')
  for(i in 0:99) {
    x <- i%%10; y <- 9-i%/%10
    rect(x+.06,y+.06,x+.94,y+.94,col=fills[kind[i+1]],border='#7F929C')
    text(x+.5,y+.5,lab[kind[i+1]],cex=.72)
  }
  rect(2.03,8.03,2.97,8.97,border=ch5_orange,lwd=3)
  arrows(10.6,9.2,3.1,8.6,length=.09,col=ch5_orange,lwd=1.6)
  text(10.7,9.2,'jedna kartička\n= jeden výsledek',adj=0,cex=.82,col=ch5_orange)
  rect(10.7,5.5+.06,11.4,6.2,col=fills[1],border='#7F929C'); text(11.6,5.87,'P: podstatné jméno, 40',adj=0,cex=.82)
  rect(10.7,4.5+.06,11.4,5.2,col=fills[2],border='#7F929C'); text(11.6,4.87,'S: sloveso, 35',adj=0,cex=.82)
  rect(10.7,3.5+.06,11.4,4.2,col=fills[3],border='#7F929C'); text(11.6,3.87,'A: přídavné jméno, 25',adj=0,cex=.82)
  text(10.7,2.2,'Jev „podstatné jméno“\nobsahuje 40 výsledků.',adj=0,cex=.82)
},width=8.6,height=5.6)
# Mosaic of a 2 x 2 table: rows have equal height, widths show row proportions.
ch5_mosaic <- function(tab,highlight,main,dim_row=integer(0)) {
  plot(NA,xlim=c(-.19,1),ylim=c(-.02,1.12),axes=FALSE,xlab='',ylab='',main=main)
  for(r in 1:2) {
    y1 <- 1-(r-1)*.5; y0 <- y1-.5; w <- tab[r,1]/sum(tab[r,])
    xs <- list(c(0,w),c(w,1))
    for(cc in 1:2) {
      on <- highlight[r,cc]; faded <- r %in% dim_row
      rect(xs[[cc]][1],y0+.01,xs[[cc]][2],y1-.01,col=if(on) ch5_fill else if(faded) 'white' else ch5_pale,border=if(faded) '#B5C1C8' else '#223744',lwd=if(on) 2.4 else 1,lty=if(faded) 3 else 1)
      text(mean(xs[[cc]]),(y0+y1)/2,tab[r,cc],cex=1.15,font=if(on) 2 else 1,col=if(faded) '#8A99A2' else '#223744')
    }
    text(-.03,(y0+y1)/2,rownames(tab)[r],adj=1,cex=.95,col=if(r %in% dim_row) '#8A99A2' else '#223744')
  }
  text(tab[1,1]/sum(tab[1,])/2,1.06,colnames(tab)[1],cex=.95); text((1+tab[1,1]/sum(tab[1,]))/2,1.06,colnames(tab)[2],cex=.95)
}
ch5_draw('prunik-sjednoceni', {
  par(mfrow=c(1,2),mar=c(2.6,.6,2.6,.6))
  ch5_mosaic(ch5_dependent,matrix(c(TRUE,FALSE,FALSE,FALSE),2,byrow=TRUE),'Průnik: žena a zároveň zvýšený stres')
  mtext('40 z 200, tedy 0,20',1,line=.6,cex=.9)
  ch5_mosaic(ch5_dependent,matrix(c(TRUE,TRUE,TRUE,FALSE),2,byrow=TRUE),'Sjednocení: žena nebo zvýšený stres')
  mtext('40 + 60 + 30 = 130 z 200, tedy 0,65',1,line=.6,cex=.9)
},width=10,height=4.2)
ch5_draw('podmineni', {
  par(mfrow=c(1,2),mar=c(2.6,.6,2.6,.6))
  ch5_mosaic(ch5_dependent,matrix(c(TRUE,FALSE,TRUE,FALSE),2,byrow=TRUE),'Celek: všech 200 studentů')
  mtext('P(zvýšený stres) = 70/200 = 0,35',1,line=.6,cex=.9)
  ch5_mosaic(ch5_dependent,matrix(c(TRUE,FALSE,FALSE,FALSE),2,byrow=TRUE),'Podmínka: jen 100 žen',dim_row=2)
  mtext('P(zvýšený stres | žena) = 40/100 = 0,40',1,line=.6,cex=.9)
},width=10,height=4.2)
ch5_draw('nezavislost', {
  par(mfrow=c(1,2),mar=c(3.6,.6,2.6,.6))
  ch5_mosaic(ch5_independent,matrix(c(TRUE,FALSE,TRUE,FALSE),2,byrow=TRUE),'Nezávislost: v obou řádcích 30 %')
  mtext('P(zvýšený stres | žena) = P(zvýšený stres | muž)',1,line=.6,cex=.9); mtext('= P(zvýšený stres) = 0,30',1,line=1.8,cex=.9)
  ch5_mosaic(ch5_dependent,matrix(c(TRUE,FALSE,TRUE,FALSE),2,byrow=TRUE),'Závislost: 40 % a 30 %')
  mtext('P(zvýšený stres | žena) = 0,40',1,line=.6,cex=.9); mtext('P(zvýšený stres | muž) = 0,30',1,line=1.8,cex=.9)
},width=10,height=4.2)
ch5_box <- function(x,y,w,h,label,fill='white',lwd=1,cex=.86) { rect(x-w/2,y-h/2,x+w/2,y+h/2,col=fill,border='#223744',lwd=lwd); text(x,y,label,cex=cex) }
ch5_draw('strom', {
  par(mar=c(.4,.4,.4,.4))
  f <- ch5_screen(1000,.10)
  plot(NA,xlim=c(0,10),ylim=c(0,7),axes=FALSE,xlab='',ylab='')
  ch5_box(5,6.3,2.6,.8,'1 000 studentů')
  ch5_box(2.5,4.2,3,.9,paste0(f['present'],'\nporucha přítomna')); ch5_box(7.5,4.2,3,.9,paste0(f['absent'],'\nporucha nepřítomna'))
  segments(5,5.9,2.5,4.65); segments(5,5.9,7.5,4.65)
  text(3.4,5.45,'0,10\n(prevalence)',cex=.8,adj=1); text(6.6,5.45,'0,90\n(1 − prevalence)',cex=.8,adj=0)
  xs <- c(1.15,3.85,6.15,8.85); labs <- c(paste0(f['tp'],'\npozitivní'),paste0(f['fn'],'\nnegativní'),paste0(f['fp'],'\npozitivní'),paste0(f['tn'],'\nnegativní'))
  for(i in 1:4) { ch5_box(xs[i],2,2.1,.9,labs[i],fill=if(i %in% c(1,3)) ch5_fill else 'white',lwd=if(i %in% c(1,3)) 2.2 else 1); segments(c(2.5,2.5,7.5,7.5)[i],3.75,xs[i],2.45) }
  text(c(1.65,6.65),3.12,c('0,95\n(senzitivita)','0,10\n(1 − specificita)'),cex=.76,adj=1)
  text(c(3.35,8.35),3.12,c('0,05\n(1 − senzitivita)','0,90\n(specificita)'),cex=.76,adj=0)
  text(5,.75,'Pozitivní výsledek má 95 + 90 = 185 studentů; poruchu z nich má 95.',cex=.9)
  text(5,.25,'Prediktivní hodnota pozitivního testu: 95/185 = 0,514',cex=.9,font=2)
},width=8.6,height=5.4)
ch5_draw('dve-prevalence', {
  par(mar=c(4.5,10.5,2.6,1))
  a <- ch5_screen(10000,.10); b <- ch5_screen(10000,.01)
  plot(NA,xlim=c(0,2600),ylim=c(.3,2.9),yaxt='n',xlab='Počet pozitivních výsledků z 10 000 testovaných',ylab='',bty='l',main='Stejný test, různá prevalence')
  axis(2,at=c(2.2,1),labels=c('Prevalence 10 %\n(poradna)','Prevalence 1 %\n(plošný screening)'),tick=FALSE)
  for(k in 1:2) {
    f <- list(a,b)[[k]]; y <- c(2.2,1)[k]
    rect(0,y-.28,f['tp'],y+.28,col=ch5_blue,border='white'); rect(f['tp'],y-.28,f['tp']+f['fp'],y+.28,col=ch5_sand,border='#223744')
    text(f['tp']/2,y+.45,f['tp'],cex=.9,col=ch5_blue); text(f['tp']+f['fp']/2,y,f['fp'],cex=.9)
    text(f['tp']+f['fp']+30,y,paste0('prediktivní hodnota\npozitivního testu ',ch5_num(ch5_ppv(f))),adj=0,cex=.9,font=2,xpd=NA)
  }
  legend('topright',c('správně pozitivní','falešně pozitivní'),fill=c(ch5_blue,ch5_sand),bty='n',cex=.85,inset=c(0,-.02))
},width=9,height=4.2)
ch5_draw('rozdeleni-model-data', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.7))
  k <- 0:ch5_n; p <- dbinom(k,ch5_n,ch5_pi); obs <- as.numeric(table(factor(ch5_sim_hadani,levels=k)))/length(ch5_sim_hadani)
  plot(k,p,type='h',lwd=9,lend=1,col=ch5_blue,xlim=c(-.4,5.4),ylim=c(0,.5),xlab='Počet správných tipů z pěti',ylab='Pravděpodobnost',main='Model: rozdělení pravděpodobnosti',bty='l')
  text(k,p+.03,ch5_num(p),cex=.74)
  plot(k,obs,type='h',lwd=9,lend=1,col=ch5_gray,xlim=c(-.4,5.4),ylim=c(0,.5),xlab='Počet správných tipů z pěti',ylab='Relativní četnost',main='Data: 40 simulovaných studentů',bty='l')
  text(k,obs+.03,ch5_num(obs),cex=.74)
},width=10,height=4.4)
ch5_draw('kombinace', {
  par(mar=c(.5,.5,2.4,.5))
  cmb <- combn(5,2)
  plot(NA,xlim=c(-.4,12.4),ylim=c(-.2,6.2),axes=FALSE,xlab='',ylab='',main='Deset způsobů, jak mít právě 2 z 5 tipů správně')
  for(j in 1:10) {
    x0 <- ((j-1)%/%5)*6.6; y <- 5-(j-1)%%5
    text(x0-.1,y,paste0(j,'.'),adj=1,cex=.85)
    for(q in 1:5) {
      hit <- q %in% cmb[,j]
      symbols(x0+q*.95,y,circles=.33,inches=FALSE,add=TRUE,bg=if(hit) ch5_blue else 'white',fg='#223744')
      text(x0+q*.95,y,if(hit) 'S' else 'N',cex=.74,col=if(hit) 'white' else '#223744')
    }
  }
  text(6,-.05,'S = správně, N = nesprávně; pořadí kroužků odpovídá otázkám 1 až 5.',cex=.82)
},width=8.6,height=4.8)
ch5_bars <- function(n,p,main,highlight=NULL,xlim=NULL,ylim=NULL,lwd=7) {
  k <- 0:n; pr <- dbinom(k,n,p)
  if(is.null(xlim)) xlim <- c(0,n)
  if(is.null(ylim)) ylim <- c(0,max(pr)*1.18)
  col <- rep(ch5_blue,length(k)); if(!is.null(highlight)) col <- ifelse(k %in% highlight,ch5_orange,'#A9BAC3')
  plot(k,pr,type='h',lwd=lwd,lend=1,col=col,xlim=xlim,ylim=ylim,xlab='Počet úspěchů k',ylab='Pravděpodobnost',main=main,bty='l')
}
ch5_draw('binomicke-tvar', {
  par(mfrow=c(2,2),mar=c(4.3,4.6,2.5,.6))
  ch5_bars(5,.25,'n = 5, π = 0,25',ylim=c(0,.45),lwd=10)
  ch5_bars(20,.25,'n = 20, π = 0,25',ylim=c(0,.45))
  ch5_bars(20,.5,'n = 20, π = 0,50',ylim=c(0,.45))
  ch5_bars(20,.9,'n = 20, π = 0,90',ylim=c(0,.45))
},width=9.4,height=6.6)
ch5_draw('binom-oblasti', {
  par(mfrow=c(1,3),mar=c(4.5,4.2,2.6,.5),mgp=c(2.5,.6,0),cex=.85)
  ch5_bars(20,.25,'Právě 5',highlight=5,ylim=c(0,.24),lwd=5); text(13,.2,ch5_num(dbinom(5,20,.25)),cex=1.05,col=ch5_orange)
  ch5_bars(20,.25,'Nejvýše 5',highlight=0:5,ylim=c(0,.24),lwd=5); text(13,.2,ch5_num(pbinom(5,20,.25)),cex=1.05,col=ch5_orange)
  ch5_bars(20,.25,'Alespoň 10',highlight=10:20,ylim=c(0,.24),lwd=5); text(13,.2,ch5_num(1-pbinom(9,20,.25)),cex=1.05,col=ch5_orange)
},width=10,height=3.9)
ch5_draw('aproximace', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.7))
  ch5_bars(20,.05,'n = 20, π = 0,05: podmínka nesplněna',xlim=c(-3,8),ylim=c(0,.45),lwd=9)
  curve(dnorm(x,20*.05,sqrt(20*.05*.95)),from=-3,to=8,add=TRUE,col=ch5_blue,lwd=2,lty=2,n=400)
  abline(v=0,lty=3,col=ch5_gray); text(-1.6,.3,'záporný počet
není možný',cex=.78,col=ch5_gray)
  ch5_bars(200,.6,'n = 200, π = 0,60: podmínka splněna',highlight=135:200,xlim=c(95,145),ylim=c(0,.066),lwd=3)
  curve(dnorm(x,200*.6,sqrt(200*.6*.4)),from=95,to=145,add=TRUE,col=ch5_blue,lwd=2,lty=2,n=400)
  text(139,.03,'135\na více',cex=.82,col=ch5_orange)
  legend('topleft',c('binomické pravděpodobnosti','normální křivka'),lty=c(1,2),lwd=c(4,2),col=c('#A9BAC3',ch5_blue),bty='n',cex=.74)
},width=10,height=4.4)
options(ch5_old_options)
