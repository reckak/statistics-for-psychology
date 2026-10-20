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
# Density above, distribution function below: the coloured area equals the coloured height.
ch4_hi <- '#F0B08C'; ch4_hi_text <- '#9A3F17'; ch4_lo <- ch4_fill; ch4_lo_text <- '#1D5670'
ch4_fmt <- function(v) format(round(v,3),nsmall=3)
ch4_F <- function(x) pnorm(x,50,10)
ch4_top_mar <- c(1.6,4.7,2.2,.8); ch4_bottom_mar <- c(4.5,4.7,1.4,.8)
ch4_density_panel <- function(title,ylab='Hustota (na bod)') {
  par(mar=ch4_top_mar)
  x <- seq(10,90,length.out=1001)
  plot(x,dnorm(x,50,10),type='n',xlab='',ylab=ylab,xlim=c(10,90),ylim=c(0,.044),bty='l',xaxt='n')
  axis(1,at=seq(10,90,20),labels=FALSE)
  title(main=title,adj=0,cex.main=1)
}
ch4_density_line <- function() curve(dnorm(x,50,10),from=10,to=90,add=TRUE,lwd=2.3,col=ch4_blue)
ch4_cdf_panel <- function(title,ylab='Podíl nejvýše po hranici') {
  par(mar=ch4_bottom_mar)
  plot(NA,xlim=c(10,90),ylim=c(0,1.04),yaxs='i',xlab='Skór pozornosti (body)',ylab=ylab,bty='l',yaxt='n')
  axis(2,at=seq(0,1,.25),labels=c('0','0,25','0,5','0,75','1'))
  abline(h=1,col='#C9D3D8',lty=3)
  title(main=title,adj=0,cex.main=1)
}
ch4_cdf_line <- function() curve(ch4_F(x),from=10,to=90,add=TRUE,lwd=2.5,col=ch4_blue)
# Column at the boundary: stacked pieces c(y0,y1,fill).
ch4_column <- function(x,pieces,w=2.6) for(p in pieces) rect(x-w/2,p[[1]],x+w/2,p[[2]],col=p[[3]],border=ch4_gray,lwd=.8)
# One dashed boundary line through both panels; call in the top panel, then link() in the bottom one.
ch4_link_start <- function(xs) { segments(xs,0,xs,.044,lty=2,lwd=1.4,col=ch4_orange); grconvertY(0,'user','ndc') }
ch4_link_end <- function(xs,ndc) { op <- par(xpd=NA); segments(xs,0,xs,grconvertY(ndc,'ndc','user'),lty=2,lwd=1.4,col=ch4_orange); par(op) }
ch4_draw('distribucni', {
  layout(matrix(1:2,2))
  ch4_density_panel('Hustota: podíl je plocha')
  ch4_area(-Inf,60,fill=ch4_hi); ch4_density_line()
  text(43,.014,ch4_fmt(ch4_F(60)),col=ch4_hi_text,font=2,cex=1.15)
  ndc <- ch4_link_start(60)
  ch4_cdf_panel('Distribuční funkce: podíl je výška')
  ch4_column(60,list(list(0,ch4_F(60),ch4_hi)))
  segments(10,ch4_F(60),60,ch4_F(60),lty=3,col=ch4_gray)
  ch4_cdf_line(); ch4_link_end(60,ndc)
  text(63,ch4_F(60)/2,ch4_fmt(ch4_F(60)),col=ch4_hi_text,font=2,cex=1.15,adj=0)
},width=7,height=6.6)
ch4_draw('oblasti', {
  layout(matrix(1:6,2))
  ttl <- c('Nejvýše 60','Nad 60','Nad 60 a nejvýše 70')
  for(k in 1:3) {
    yl <- if(k==1) 'Hustota (na bod)' else ''
    ch4_density_panel(ttl[k],ylab=yl)
    if(k==1) { ch4_area(-Inf,60,fill=ch4_hi); text(43,.014,ch4_fmt(ch4_F(60)),col=ch4_hi_text,font=2) }
    if(k==2) { ch4_area(-Inf,60,fill=ch4_lo); ch4_area(60,Inf,fill=ch4_hi)
      text(43,.014,ch4_fmt(ch4_F(60)),col=ch4_lo_text,font=2); text(76,.016,ch4_fmt(1-ch4_F(60)),col=ch4_hi_text,font=2) }
    if(k==3) { ch4_area(-Inf,60,fill=ch4_lo); ch4_area(60,70,fill=ch4_hi)
      text(43,.014,ch4_fmt(ch4_F(60)),col=ch4_lo_text,font=2); text(78,.02,ch4_fmt(ch4_F(70)-ch4_F(60)),col=ch4_hi_text,font=2) }
    ch4_density_line()
    xs <- if(k==3) c(60,70) else 60
    ndc <- ch4_link_start(xs)
    ch4_cdf_panel('',ylab=if(k==1) 'Podíl nejvýše po hranici' else '')
    if(k==1) { ch4_column(60,list(list(0,ch4_F(60),ch4_hi)))
      text(63,.42,ch4_fmt(ch4_F(60)),col=ch4_hi_text,font=2,adj=0) }
    if(k==2) { ch4_column(60,list(list(0,ch4_F(60),ch4_lo),list(ch4_F(60),1,ch4_hi)))
      text(63,.42,ch4_fmt(ch4_F(60)),col=ch4_lo_text,font=2,adj=0)
      text(12,.9,paste0('1 − ',ch4_fmt(ch4_F(60)),' = ',ch4_fmt(1-ch4_F(60))),col=ch4_hi_text,font=2,adj=0,cex=.9) }
    if(k==3) { segments(60,ch4_F(60),70,ch4_F(60),lty=3,col=ch4_gray)
      ch4_column(70,list(list(0,ch4_F(60),ch4_lo),list(ch4_F(60),ch4_F(70),ch4_hi)))
      text(73,.42,ch4_fmt(ch4_F(60)),col=ch4_lo_text,font=2,adj=0)
      text(12,.9,paste0(ch4_fmt(ch4_F(70)),' − ',ch4_fmt(ch4_F(60)),' = ',ch4_fmt(ch4_F(70)-ch4_F(60))),col=ch4_hi_text,font=2,adj=0,cex=.9) }
    ch4_cdf_line(); ch4_link_end(xs,ndc)
  }
},width=10.5,height=6.4)
ch4_draw('mezi', {
  layout(matrix(c(1,2,3,4,5,6,6,6,6,6),2,byrow=TRUE),widths=c(1,.22,1,.22,1),heights=c(1,1.25))
  mini <- function(parts,lab,labcol,ticks) {
    par(mar=c(2.2,.6,2,.6))
    plot(NA,xlim=c(15,85),ylim=c(0,.044),axes=FALSE,xlab='',ylab='')
    for(p in parts) ch4_area(p[[1]],p[[2]],fill=p[[3]])
    ch4_density_line(); axis(1,at=ticks,cex.axis=.9); abline(h=0,col=ch4_gray)
    title(main=lab,col.main=labcol,cex.main=1.05)
  }
  sym <- function(s) { par(mar=c(2.2,0,2,0)); plot.new(); text(.5,.45,s,cex=2.6,font=2,col='#223744') }
  mini(list(list(60,70,ch4_hi)),paste('Mezi 60 a 70:',ch4_fmt(ch4_F(70)-ch4_F(60))),ch4_hi_text,c(60,70))
  sym('=')
  mini(list(list(-Inf,60,ch4_lo),list(60,70,ch4_hi)),paste('Do 70:',ch4_fmt(ch4_F(70))),'#223744',70)
  sym('−')
  mini(list(list(-Inf,60,ch4_lo)),paste('Do 60:',ch4_fmt(ch4_F(60))),ch4_lo_text,60)
  par(mar=c(4.5,4.7,2.2,.8))
  plot(NA,xlim=c(10,90),ylim=c(0,1.04),yaxs='i',xlab='Skór pozornosti (body)',ylab='Podíl nejvýše po hranici',bty='l',yaxt='n')
  axis(2,at=seq(0,1,.25),labels=c('0','0,25','0,5','0,75','1'))
  title(main='Distribuční funkce: tentýž rozdíl jako rozdíl dvou výšek',adj=0,cex.main=1)
  abline(v=c(60,70),lty=2,lwd=1.4,col=ch4_orange)
  segments(10,c(ch4_F(60),ch4_F(70)),c(60,70),c(ch4_F(60),ch4_F(70)),lty=3,col=ch4_gray)
  ch4_column(60,list(list(0,ch4_F(60),ch4_lo)),w=3)
  ch4_column(70,list(list(0,ch4_F(60),ch4_lo),list(ch4_F(60),ch4_F(70),ch4_hi)),w=3)
  ch4_cdf_line()
  text(58,.1,paste('Výška v 60:',ch4_fmt(ch4_F(60))),col=ch4_lo_text,font=2,adj=1)
  text(72,.42,paste('Výška v 70:',ch4_fmt(ch4_F(70))),col='#223744',font=2,adj=0)
  arrows(73,ch4_F(60),73,ch4_F(70),code=3,length=.05,col=ch4_hi_text,lwd=1.5)
  text(74.5,(ch4_F(60)+ch4_F(70))/2-.07,paste0(ch4_fmt(ch4_F(70)),' − ',ch4_fmt(ch4_F(60)),' = ',ch4_fmt(ch4_F(70)-ch4_F(60))),col=ch4_hi_text,font=2,adj=0,cex=.95)
},width=10,height=6.6)
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
  zz<--3:3
  plot(NA,xlim=c(-3.2,3.2),ylim=c(-1.3,4.5),axes=FALSE,xlab='',ylab='')
  abline(v=zz,col='#D6E0E5',lty=3)
  for(k in 1:4) {
    y<-5-k;segments(-3,y,3,y,col=ch4_blue,lwd=1.5)
    points(zz,rep(y,7),pch=19,col=ch4_blue)
    text(zz,y+.23,list(zz,50+10*zz,100+15*zz,10+3*zz)[[k]])
    mtext(c('z-skór','T-skór','IQ-skór (100/15)','Subtestový skór (10/3)')[k],side=2,at=y,line=.5,las=1,cex=.85)
  }
  segments(-3,0,3,0,col=ch4_orange,lwd=1.5)
  points(zz,rep(0,7),pch=19,col=ch4_orange)
  text(zz,.23,format(round(100*pnorm(zz),1),decimal.mark=',',trim=TRUE),col=ch4_orange)
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
  par(mfrow=c(2,1),mar=c(5.7,4.4,4.6,1),cex=.95)
  pct<-function(v) paste0(format(round(100*v,1),nsmall=1,decimal.mark=',',trim=TRUE),' %')
  # Text on a white box so that it stays legible over the band boundaries.
  boxed<-function(x,y,label,adj=0,cex=.8,col='#223744') {
    w<-strwidth(label,cex=cex);h<-strheight(label,cex=cex)
    x0<-x-adj*w;rect(x0-.05,y-h/2-.012,x0+w+.05,y+h/2+.012,col='white',border=NA)
    text(x0,y,label,adj=c(0,.5),cex=cex,col=col)
  }
  for(k in 1:2) {
    breaks<-if(k==1) ch4_sten_breaks else ch4_stanine_breaks
    props<-if(k==1) ch4_sten_proportions else ch4_stanine_proportions
    inner<-breaks[is.finite(breaks)]
    finite_breaks<-pmax(-3.5,pmin(3.5,breaks));target<-if(k==1) ch4_sten(1.2) else ch4_stanine(1.2)
    plot(NA,xlim=c(-3.5,3.5),ylim=c(0,.48),xlab='Z-skór',ylab='Hustota',bty='l',xaxt='n',yaxs='i')
    title(main=if(k==1)'Deset stenových pásem' else 'Devět staninových pásem',line=3)
    for(j in seq_len(length(breaks)-1)) {
      v<-seq(finite_breaks[j],finite_breaks[j+1],length.out=150)
      polygon(c(v[1],v,tail(v,1)),c(0,dnorm(v),0),border=NA,
        col=if(j==target)'#F3C395' else c('#DAEBF1','#B8DDE8')[(j%%2)+1])
    }
    curve(dnorm(x),add=TRUE,col=ch4_blue,lwd=2)
    abline(v=inner,col='#667078',lty=3)
    mids<-(head(finite_breaks,-1)+tail(finite_breaks,-1))/2
    axis(1,at=inner,cex.axis=.78)
    mtext(if(k==1)'Sten:' else 'Stanin:',side=1,line=3.5,at=-3.3,cex=.8)
    mtext(seq_along(mids),side=1,line=3.5,at=mids,cex=.85)
    # Model share of every band just above the axis; cumulative share above each boundary.
    text(mids,ifelse(is.finite(head(breaks,-1))&is.finite(breaks[-1]),.016,.035),pct(props),cex=.6,col='#223744')
    mtext(pct(pnorm(inner)),side=3,line=.25,at=inner,cex=.62,col=ch4_hi_text)
    mtext('Kumulativně:',side=3,line=.25,at=-3.5,adj=0,cex=.62,col=ch4_hi_text)
    points(1.2,dnorm(1.2),pch=19,col=ch4_orange)
    arrows(1.2,.36,1.2,dnorm(1.2)+.02,length=.08,col=ch4_orange)
    boxed(1.25,.39,paste0('z = 1,2 → ',if(k==1)'sten ' else 'stanin ',target),cex=.85)
    arrows(c(-2.8,2.8),c(.07,.07),c(-3.4,3.4),c(.07,.07),length=.08)
    text(c(-2.8,2.8),c(.1,.1),'pokračuje',cex=.7)
    if(k==1) {
      points(c(1.1,1.4),c(.07,.07),pch=21,bg='white',col=ch4_orange,cex=.9)
      boxed(-3.35,.41,'Malé kroužky: z = 1,1 a 1,4',cex=.75)
      boxed(-3.35,.36,'Oba výsledky patří do stenu 8.',cex=.75)
    }
  }
},width=8.5,height=8.8)
ch4_norm_x <- c(11,12,12,13,14,14,14,16,17,19,22,26,31,39,52)
ch4_norm_z <- qnorm((rank(ch4_norm_x)-.5)/length(ch4_norm_x))
ch4_draw('normalizace', {
  par(mar=c(4.3,4.6,2.6,4.6))
  x <- ch4_norm_x; z <- ch4_norm_z; g <- 2.6; w <- 7.6
  ux <- function(v) (v-10)/45; uz <- function(v) (v+2.25)/4.5
  hx <- hist(x,breaks=seq(10,55,5),right=FALSE,plot=FALSE)
  hz <- hist(z,breaks=seq(-2,2,.5),right=FALSE,plot=FALSE)
  plot(NA,xlim=c(-g-w,g+w),ylim=c(0,1),xaxs='i',yaxs='i',axes=FALSE,xlab='',ylab='')
  abline(h=ux(seq(10,55,5)),col='#EEF2F4'); box(bty='l',col='#223744'); box(bty='7',col='#223744')
  rect(-g-hx$counts,ux(head(hx$breaks,-1)),-g,ux(hx$breaks[-1]),col=ch4_fill,border=ch4_blue,lwd=.8)
  rect(g,uz(head(hz$breaks,-1)),g+hz$counts,uz(hz$breaks[-1]),col=ch4_hi,border=ch4_hi_text,lwd=.8)
  # Tied values sit side by side; each pair of dots is joined by a translucent line.
  tie <- ave(x,x,FUN=function(v) seq_along(v)-(length(v)+1)/2)*.32
  xl <- -g+.75+tie; xr <- g-.75+tie
  segments(xl,ux(x),xr,uz(z),col=adjustcolor(ch4_gray,.5),lwd=1.3)
  points(xl,ux(x),pch=21,bg=ch4_blue,col='white',cex=1.25)
  points(xr,uz(z),pch=21,bg=ch4_hi_text,col='white',cex=1.25)
  axis(2,at=ux(seq(10,50,10)),labels=seq(10,50,10))
  axis(4,at=uz(-2:2),labels=c('−2','−1','0','1','2'))
  mtext('Doba řešení (s)',side=2,line=2.8,las=0); mtext('z-skór po normalizaci',side=4,line=2.8,las=0)
  cnt <- 0:7
  axis(1,at=c(-g-cnt,g+cnt),labels=c(cnt,cnt))
  mtext('Četnost',side=1,line=2.5)
  mtext('Původní doby',side=3,line=.6,at=-g-w/2,font=2)
  mtext('Po normalizaci',side=3,line=.6,at=g+w/2,font=2)
},width=8,height=5.6)
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
# New sets are appended so that the earlier draws keep their values.
ch4_simulations <- list(normalni=rnorm(200,50,10),sikme=30+rexp(200,rate=1/15),chvosty=50+8*rt(200,df=3),smes=c(rnorm(100,36,5),rnorm(100,64,5)),
  sikme_vlevo=70-rexp(200,rate=1/10),lehke=runif(200,30,70))
ch4_titles <- c(normalni='Normální model',sikme='Rozdělení zešikmené doprava',chvosty='Těžší chvosty',smes='Směs dvou skupin',
  sikme_vlevo='Rozdělení zešikmené doleva',lehke='Lehčí chvosty')
for(nm in names(ch4_simulations)) ch4_draw(paste0('diagnostika-',nm), {
  v<-ch4_simulations[[nm]]; z<-qnorm((seq_along(v)-.5)/length(v))
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.6))
  h<-hist(v,breaks='FD',plot=FALSE);xx<-seq(min(h$breaks),max(h$breaks),length.out=500)
  plot(h,freq=FALSE,col=ch4_fill,border='white',main=ch4_titles[nm],xlab='Simulovaný skór',ylab='Hustota',ylim=c(0,1.12*max(h$density,dnorm(xx,mean(v),sd(v)))));lines(xx,dnorm(xx,mean(v),sd(v)),col=ch4_orange,lwd=2)
  plot(z,sort(v),pch=19,cex=.55,col=ch4_blue,xlab='Teoretický normální kvantil (z)',ylab='Seřazený simulovaný skór',main='Normální Q–Q graf',bty='l')
  abline(a=mean(v),b=sd(v),lty=2,col=ch4_orange,lwd=2)
},width=9,height=4.4)
# Optional extension: the same right-skewed simulation as a Q-Q plot and a P-P plot.
ch4_draw('pp-qq', {
  v<-sort(ch4_simulations$sikme); n<-length(v); p<-(seq_len(n)-.5)/n; z<-qnorm(p)
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.8))
  plot(z,v,pch=19,cex=.55,col=ch4_blue,xlab='Teoretický normální kvantil (z)',ylab='Seřazený simulovaný skór',main='Q–Q graf: porovnává hodnoty',bty='l')
  abline(a=mean(v),b=sd(v),lty=2,col=ch4_orange,lwd=2)
  plot(p,pnorm((v-mean(v))/sd(v)),pch=19,cex=.55,col=ch4_blue,xlab='Empirický podíl (i − 0,5)/n',ylab='Modelový podíl podle normálního modelu',main='P–P graf: porovnává podíly',bty='l',xlim=c(0,1),ylim=c(0,1),xaxs='i',yaxs='i')
  abline(0,1,lty=2,col=ch4_orange,lwd=2)
},width=9,height=4.4)
# Same normal simulation: the curve matches bar heights only on the density scale.
ch4_draw('histogram-krivka', {
  v<-ch4_simulations$normalni; h<-hist(v,breaks='FD',plot=FALSE)
  xx<-seq(min(h$breaks),max(h$breaks),length.out=500); yy<-dnorm(xx,mean(v),sd(v))
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.6))
  plot(h,freq=TRUE,col=ch4_fill,border='white',main='Svislá osa: četnost',xlab='Simulovaný skór',ylab='Četnost',ylim=c(0,1.12*max(h$counts)))
  lines(xx,yy,col=ch4_orange,lwd=2)
  plot(h,freq=FALSE,col=ch4_fill,border='white',main='Svislá osa: hustota',xlab='Simulovaný skór',ylab='Hustota (na bod)',ylim=c(0,1.12*max(h$density,yy)))
  lines(xx,yy,col=ch4_orange,lwd=2)
},width=9,height=4.4)
options(ch4_old_options)
