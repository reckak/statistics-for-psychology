# Original teaching examples; base R, UTF-8, deterministic project-root paths.
ch4_data <- read.csv('data/kapitola_04.csv', fileEncoding='UTF-8')
ch4_x <- ch4_data$skor_body
ch4_p <- (seq_along(ch4_x)-.5)/length(ch4_x)
ch4_z <- qnorm(ch4_p)
ch4_reference <- mean(ch4_x)+sd(ch4_x)*ch4_z
ch4_sten_breaks <- c(-Inf,seq(-2,2,.5),Inf)
ch4_stanine_breaks <- c(-Inf,seq(-1.75,1.75,.5),Inf)
ch4_sten <- function(z) as.integer(cut(z,ch4_sten_breaks,right=TRUE))
ch4_stanine <- function(z) as.integer(cut(z,ch4_stanine_breaks,right=TRUE))
ch4_sten_proportions <- diff(pnorm(ch4_sten_breaks))
ch4_stanine_proportions <- diff(pnorm(ch4_stanine_breaks))
ch4_out <- 'assets/chapter-04/plots'
ch4_old_options <- options(OutDec=',')
dir.create(ch4_out,recursive=TRUE,showWarnings=FALSE)
ch4_blue <- '#245D78'; ch4_orange <- '#B54E24'; ch4_fill <- '#B8DDE8'; ch4_gray <- '#4D5A63'
ch4_draw <- function(name,code,width=8,height=4.5) {
  svg(file.path(ch4_out,paste0(name,'.svg')),width=width,height=height,family='sans',bg='white')
  par(mar=c(4.5,4.5,2.6,.8),mgp=c(2.7,.7,0),las=1,col.axis='#223744',col.lab='#223744',fg='#223744',cex=.9)
  force(code); dev.off()
}
ch4_curve <- function(mu=50,sigma=10,main='',xlim=c(10,90),ylim=c(0,.044)) {
  x <- seq(xlim[1],xlim[2],length.out=1001)
  plot(x,dnorm(x,mu,sigma),type='l',lwd=2.3,col=ch4_blue,xlab='Skór pozornosti (body)',ylab='Hustota (na bod)',main=main,xlim=xlim,ylim=ylim,bty='l')
}
ch4_area <- function(lower,upper,mu=50,sigma=10,fill=ch4_fill) {
  v <- seq(max(lower,mu-4*sigma),min(upper,mu+4*sigma),length.out=400)
  polygon(c(v[1],v,tail(v,1)),c(0,dnorm(v,mu,sigma),0),col=fill,border=NA)
  curve(dnorm(x,mu,sigma),add=TRUE,lwd=2.3,col=ch4_blue)
}
ch4_draw('standardizace', {
  par(mfrow=c(2,1),mar=c(3.5,3.5,2.1,1))
  v <- c(4,5,5,6,10); z <- (v-mean(v))/sd(v); h <- c(1,1,1.25,1,1)
  for(k in 1:2) {
    a <- if(k==1) v else z
    plot(a,h,pch=19,cex=1.35,col=ch4_blue,yaxt='n',ylab='',ylim=c(.6,1.6),xlim=range(a)+c(-.15,.15)*diff(range(a)),bty='n',xlab=if(k==1)'Doba dokončení úlohy (minuty)' else 'Z-skór',main=if(k==1)'Původní hodnoty' else 'Po standardizaci')
    abline(v=if(k==1)mean(v) else 0,lty=2,col=ch4_orange)
  }
},height=5)
ch4_draw('parametry', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.6,.6))
  ch4_curve(main='Mění se průměr',xlim=c(10,110))
  curve(dnorm(x,65,10),add=TRUE,col=ch4_orange,lwd=2.3,lty=2)
  legend('topright',c('N(50, 10)','N(65, 10)'),col=c(ch4_blue,ch4_orange),lty=1:2,lwd=2,bty='n',cex=.74)
  ch4_curve(main='Mění se směrodatná odchylka',xlim=c(0,100))
  curve(dnorm(x,50,15),add=TRUE,col=ch4_orange,lwd=2.3,lty=2)
  legend('topright',c('N(50, 10)','N(50, 15)'),col=c(ch4_blue,ch4_orange),lty=1:2,lwd=2,bty='n',cex=.74)
},width=10)
ch4_draw('hustota', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,3,.7))
  plot(NA,xlim=c(20,80),ylim=c(0,.048),xlab='Skór (body)',ylab='Hustota (na bod)',main='Schéma histogramu',bty='l')
  b <- seq(20,80,10); heights <- c(.005,.015,.03,.03,.015,.005)
  rect(b[-7],0,b[-1],heights,col=c(rep('#E1E8EB',3),ch4_fill,rep('#E1E8EB',2)),border='white')
  text(55,.037,'0,03 × 10 = 0,30',cex=.82)
  ch4_curve(main='Normální model')
  ch4_area(50,60)
  text(68,.025,'Plocha\n0,341',cex=.95)
},width=9)
ch4_draw('distribucni', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.7))
  ch4_curve(main='Hustota: podíl jako plocha');ch4_area(-Inf,60)
  abline(v=60,lty=2,col=ch4_orange);text(47,.019,'84,1 %')
  curve(pnorm(x,50,10),from=10,to=90,col=ch4_blue,lwd=2.5,xlab='Skór pozornosti (body)',ylab='Podíl vlevo od hranice',main='Distribuční funkce: podíl jako výška',bty='l',ylim=c(0,1),yaxs='i')
  segments(60,0,60,pnorm(60,50,10),lty=2,col=ch4_orange)
  segments(10,pnorm(60,50,10),60,pnorm(60,50,10),lty=2,col=ch4_orange)
  points(60,pnorm(60,50,10),pch=19,col=ch4_orange);text(32,.9,'0,841',col=ch4_orange)
},width=10)
ch4_draw('oblasti', {
  par(mfrow=c(1,3),mar=c(4.5,3.7,2.5,.6),mgp=c(2.3,.6,0),cex=.85)
  for(k in 1:3) {
    ch4_curve(main=c('Nejvýše 60','Nad 60','Nad 60 a nejvýše 70')[k]);
    ch4_area(c(-Inf,60,60)[k],c(60,Inf,70)[k])
    text(50,.043,c('84,1 %','15,9 %','13,6 %')[k],cex=1)
    abline(v=c(60,70)[seq_len(if(k==3)2 else 1)],lty=3,col=ch4_gray)
  }
},width=10,height=3.8)
ch4_draw('kvantily', {
  par(mfrow=c(1,2),mar=c(4.7,4.7,2.7,.7))
  ch4_curve(main='Horních 5 %');a<-qnorm(.95,50,10);ch4_area(a,Inf)
  abline(v=a,lty=2,col=ch4_orange);text(74,.014,'5 %');axis(1,at=a,labels='66,45',line=1.3,tick=FALSE,cex.axis=.8)
  ch4_curve(main='Prostředních 95 %');a<-qnorm(c(.025,.975),50,10);ch4_area(a[1],a[2])
  abline(v=a,lty=2,col=ch4_orange);text(50,.018,'95 %');text(c(19,81),.007,'2,5 %',cex=.8)
  axis(1,at=a,labels=c('30,40','69,60'),line=1.3,tick=FALSE,cex.axis=.8)
},width=9)
ch4_draw('skaly', {
  par(mar=c(1,9,1,1))
  plot(NA,xlim=c(-2.15,2.15),ylim=c(-1.3,4.5),axes=FALSE,xlab='',ylab='')
  abline(v=-2:2,col='#D6E0E5',lty=3)
  for(k in 1:4) {
    y<-5-k;segments(-2,y,2,y,col=ch4_blue,lwd=1.5)
    points(-2:2,rep(y,5),pch=19,col=ch4_blue)
    text(-2:2,y+.23,list(-2:2,50+10*(-2:2),100+15*(-2:2),10+3*(-2:2))[[k]])
    mtext(c('z-skór','T-skór','IQ-skór (100/15)','Subtestový skór (10/3)')[k],side=2,at=y,line=.5,las=1,cex=.85)
  }
  segments(-2,0,2,0,col=ch4_orange,lwd=1.5)
  points(-2:2,rep(0,5),pch=19,col=ch4_orange)
  text(-2:2,.23,format(round(100*pnorm(-2:2),1),decimal.mark=','),col=ch4_orange)
  mtext('Percentilové pořadí\nJEN normální model',side=2,at=0,line=.5,las=1,cex=.8,col=ch4_orange)
  text(0,-.85,'Krok z = 0 → 1: +34,1     Krok z = 1 → 2: +13,6\nRozdíly na stupnici percentilového pořadí',cex=.82)
},height=5.8)
ch4_draw('z-jako-jednotka', {
  par(mar=c(0,0,0,0));plot.new();plot.window(xlim=c(0,10),ylim=c(0,7),xaxs='i',yaxs='i')
  for(k in 1:2) {
    y<-if(k==1) 5 else 2
    text(.5,y+1.3,if(k==1) 'Test A: průměr 50 bodů; směrodatná odchylka 10 bodů' else 'Test B: průměr 30 bodů; směrodatná odchylka 6 bodů',adj=0,font=2)
    xx<-c(2,4,6);segments(1,y,7,y,col=ch4_blue)
    points(xx,rep(y,3),pch=19,col=ch4_blue)
    text(xx,y-.5,if(k==1)c('50','60','70') else c('30','36','42'))
    for(j in seq_len(k)) {
      arrows(xx[j],y+.5,xx[j+1],y+.5,length=.08,code=3,col=ch4_orange)
      text(mean(xx[j:(j+1)]),y+.8,if(k==1)'10 bodů' else '6 bodů',cex=.85)
    }
    points(xx[k+1],y,pch=21,cex=2.7,col=ch4_orange,bg='white',lwd=2)
    text(8.5,y,paste0('z = ',k),font=2,cex=1.25)
    text(2,y-.95,'průměr',cex=.85)
  }
  text(.5,.25,'Porovnáváme počet kroků od průměru, nikoli počty hrubých bodů.',adj=0,cex=.85)
},width=8,height=5.4)
ch4_draw('pasma-skoru', {
  par(mfrow=c(2,1),mar=c(5.7,4.4,3,1),cex=.95)
  for(k in 1:2) {
    breaks<-if(k==1) ch4_sten_breaks else ch4_stanine_breaks
    finite_breaks<-pmax(-3.5,pmin(3.5,breaks));target<-if(k==1) ch4_sten(1.2) else ch4_stanine(1.2)
    plot(NA,xlim=c(-3.5,3.5),ylim=c(0,.48),xlab='Z-skór',ylab='Hustota',bty='l',
      main=if(k==1)'Deset stenových pásem' else 'Devět staninových pásem',xaxt='n',yaxs='i')
    for(j in seq_len(length(breaks)-1)) {
      v<-seq(finite_breaks[j],finite_breaks[j+1],length.out=150)
      polygon(c(v[1],v,tail(v,1)),c(0,dnorm(v),0),border=NA,
        col=if(j==target)'#F3C395' else c('#DAEBF1','#B8DDE8')[(j%%2)+1])
    }
    curve(dnorm(x),add=TRUE,col=ch4_blue,lwd=2)
    abline(v=breaks[is.finite(breaks)],col='#667078',lty=3)
    mids<-(head(finite_breaks,-1)+tail(finite_breaks,-1))/2
    axis(1,at=breaks[is.finite(breaks)],cex.axis=.78)
    mtext(if(k==1)'Sten:' else 'Stanin:',side=1,line=3.5,at=-3.3,cex=.8)
    mtext(seq_along(mids),side=1,line=3.5,at=mids,cex=.85)
    points(1.2,dnorm(1.2),pch=19,col=ch4_orange)
    arrows(1.2,.4,1.2,dnorm(1.2)+.02,length=.08,col=ch4_orange)
    text(1.35,.43,paste0('z = 1,2 → ',if(k==1)'sten ' else 'stanin ',target),adj=0,cex=.9)
    arrows(c(-2.8,2.8),c(.06,.06),c(-3.4,3.4),c(.06,.06),length=.08)
    text(c(-2.8,2.8),c(.1,.1),'pokračuje',cex=.7)
    if(k==1) {
      points(c(1.1,1.4),c(.025,.025),pch=21,bg='white',col=ch4_orange,cex=.9)
      text(-3.2,.4,'Malé kroužky: z = 1,1 a 1,4\nOba výsledky patří do stenu 8.',adj=0,cex=.8)
    }
  }
},width=8.5,height=8.4)
ch4_draw('qq-konstrukce', {
  par(mar=c(0,0,0,0));plot.new();plot.window(xlim=c(0,10),ylim=c(0,9),xaxs='i',yaxs='i')
  box_label<-function(x,y,w,h,label,fill=ch4_fill) {
    rect(x-w/2,y-h/2,x+w/2,y+h/2,col=fill,border=ch4_blue)
    text(x,y,label,cex=.93)
  }
  box_label(5,8.1,7,1,'První pořadí z 12 seřazených skórů: i = 1')
  arrows(c(4,6),7.5,c(2.5,7.5),6.8,length=.1)
  box_label(2.5,6,4,1.4,'DATA\nPrvní pozorovaný skór: 35 bodů')
  box_label(7.5,6,4,1.4,'MODEL\nPodíl p = (1 − 0,5) / 12\n≈ 0,041667')
  arrows(7.5,5.2,7.5,4.7,length=.1)
  box_label(7.5,3.9,4,1.4,'Normální kvantil pro tento podíl\nz ≈ −1,731664')
  arrows(2.5,5.2,3.6,2,length=.1)
  arrows(7.5,3.1,6.4,2,length=.1)
  text(1.65,3.65,'Svislá osa\npozorovaný skór',cex=.85)
  text(8.05,2.5,'Vodorovná osa\nteoretický kvantil',cex=.85)
  box_label(5,1.3,5.5,1.2,'Bod Q–Q grafu: (−1,73; 35)',fill='#FAECDD')
  text(5,.25,'Pořadí propojí data s modelem; nejde o dvě měření jednoho člověka.',cex=.85)
},width=8,height=6.7)
ch4_draw('qq-priklad', {
  plot(ch4_z,ch4_x,pch=19,col=ch4_blue,cex=1.15,xlab='Teoretický normální kvantil (z)',ylab='Pozorovaný skór pozornosti (body)',bty='l',xlim=c(-2,2),ylim=c(30,70))
  abline(a=mean(ch4_x),b=sd(ch4_x),col=ch4_orange,lwd=2,lty=2)
  legend('topleft',c('Pozorované skóry','Referenční přímka m + s z'),col=c(ch4_blue,ch4_orange),pch=c(19,NA),lty=c(NA,2),bty='n',cex=.85)
},width=7)
# Distinct simulations for graphical diagnosis; not empirical psychological data.
set.seed(20261010)
ch4_simulations <- list(normalni=rnorm(200,50,10),sikme=30+rexp(200,rate=1/15),chvosty=50+8*rt(200,df=3),smes=c(rnorm(100,36,5),rnorm(100,64,5)))
ch4_titles <- c(normalni='Normální model',sikme='Pravostranná šikmost',chvosty='Těžší chvosty',smes='Směs dvou skupin')
for(nm in names(ch4_simulations)) ch4_draw(paste0('diagnostika-',nm), {
  v<-ch4_simulations[[nm]]; z<-qnorm((seq_along(v)-.5)/length(v))
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.6))
  h<-hist(v,breaks='FD',plot=FALSE);xx<-seq(min(h$breaks),max(h$breaks),length.out=500)
  plot(h,freq=FALSE,col=ch4_fill,border='white',main=ch4_titles[nm],xlab='Simulovaný skór',ylab='Hustota',ylim=c(0,1.12*max(h$density,dnorm(xx,mean(v),sd(v)))));lines(xx,dnorm(xx,mean(v),sd(v)),col=ch4_orange,lwd=2)
  plot(z,sort(v),pch=19,cex=.55,col=ch4_blue,xlab='Teoretický normální kvantil (z)',ylab='Seřazený simulovaný skór',main='Normální Q–Q graf',bty='l')
  abline(a=mean(v),b=sd(v),lty=2,col=ch4_orange,lwd=2)
},width=9,height=4.4)
options(ch4_old_options)
