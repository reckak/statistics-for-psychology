# Chapter 3: reproducible calculations and figures; base R, project-root paths.
ch3_data <- read.csv('data/kapitola_03.csv', fileEncoding = 'UTF-8')
ch3_previous <- read.csv('data/kapitola_02.csv', na.strings = '', fileEncoding = 'UTF-8')
ch3_x <- ch3_data$doba_min[ch3_data$soubor == 'zaklad']
ch3_trim <- sort(ch3_data$doba_min[ch3_data$soubor == 'orezani'])
# Self-contained teaching example printed in the chapter's interpolation table.
ch3_interpolation <- c(4,5,7,8,9,10,12,13,15,18,22)
ch3_interpolation_levels <- (seq_along(ch3_interpolation)-1)/(length(ch3_interpolation)-1)
ch3_quantile <- function(x, p) unname(quantile(x, p, type = 7, na.rm = TRUE))
ch3_moments <- function(x) {
  z <- x - mean(x); v <- mean(z^2)
  c(g1 = mean(z^3)/v^1.5, g2 = mean(z^4)/v^2 - 3)
}
ch3_corrected <- function(x) {
  n <- length(x); g <- ch3_moments(x)
  c(skew = unname(sqrt(n*(n-1))/(n-2)*g[1]),
    kurt = unname((n-1)/((n-2)*(n-3))*((n+1)*g[2]+6)))
}
ch3_stats <- function(x) {
  x <- x[!is.na(x)]
  c(n=length(x), mean=mean(x), median=median(x), min=min(x), max=max(x),
    q1=ch3_quantile(x,.25), q3=ch3_quantile(x,.75),
    variance=var(x), sd=sd(x), mean_abs=mean(abs(x-mean(x))),
    median_abs=mad(x,constant=1), ch3_moments(x), ch3_corrected(x))
}
ch3_entropy <- function(p) -sum(p[p>0]*log2(p[p>0]))
ch3_results <- rbind(zaklad=ch3_stats(ch3_x),
  vzdaleny=ch3_stats(c(4,5,5,6,30)),
  spanek=ch3_stats(ch3_previous$spanek_h), slova=ch3_stats(ch3_previous$slova),
  orezani=ch3_stats(ch3_trim))
# An entirely specified finite population, independent draws WITH replacement.
# The population variance uses division by its size (5), and is exactly 8.
ch3_population <- c(2,4,6,8,10)
set.seed(20261005)
ch3_simulations <- lapply(c(5L,20L,100L), function(n) {
  x <- matrix(sample(ch3_population, n*20000L, replace=TRUE),nrow=n)
  ss <- colSums((x-rep(colMeans(x),each=n))^2)
  data.frame(n=n, variance_n=ss/n, variance_n1=ss/(n-1), sd_n1=sqrt(ss/(n-1)))
})
ch3_simulation_summary <- do.call(rbind,lapply(ch3_simulations,function(x)
  data.frame(n=x$n[1], variance_n=mean(x$variance_n), variance_n1=mean(x$variance_n1),
    sd_n1=mean(x$sd_n1))))
ch3_peak_a <- c(rep(-1,10),rep(0,80),rep(1,10))
ch3_peak_b <- c(-3,rep(-1,9),rep(0,80),rep(1,9),3)
# The two samples have the same mean and variance but different configurations.
ch3_shape_a <- c(4,4,4,8,8,8)
ch3_shape_b <- c(6-sqrt(12),6,6,6,6,6+sqrt(12))
ch3_out <- 'assets/chapter-03/plots'
dir.create(ch3_out,recursive=TRUE,showWarnings=FALSE)
dir.create('tmp/chapter-03-build',recursive=TRUE,showWarnings=FALSE)
write.csv(ch3_results,'tmp/chapter-03-build/results.csv',row.names=TRUE,fileEncoding='UTF-8')
write.csv(ch3_simulation_summary,'tmp/chapter-03-build/simulation.csv',row.names=FALSE)
ch3_draw <- function(name,code,width=7.5,height=4.6) {
  svg(file.path(ch3_out,paste0(name,'.svg')),width=width,height=height,family='sans',bg='white')
  par(mar=c(4.6,4.6,2.4,1),mgp=c(2.1,.7,0),las=1,col.axis='#223744',col.lab='#223744',fg='#223744')
  force(code);dev.off()
}
ch3_dots <- function(x,col='#267888',...) {
  yy <- ave(x,x,FUN=seq_along)
  plot(x,yy,pch=21,bg=col,col='white',cex=1.6,yaxt='n',ylab='',bty='n',...)
}
ch3_draw('stejny-prumer',{
  par(mfrow=c(2,1),mar=c(3.5,4,2,.8))
  for(x in list(c(5,6,6,6,7),c(2,4,6,8,10))) {
    ch3_dots(x,xlim=c(1,11),ylim=c(.5,3.8),xlab='Doba dokončení úlohy (minuty)',
      main=paste0('Průměr 6 min; směrodatná odchylka ',format(round(sd(x),2),decimal.mark=','),' min'))
    abline(v=6,col='#B16A26',lty=2)
  }
},height=5.4)
ch3_draw('odlehle-a-stred',{
  par(mfrow=c(2,1),mar=c(3.5,4,2,.8))
  for(x in list(ch3_x,c(4,5,5,6,30))) {
    ch3_dots(x,xlim=c(0,32),ylim=c(.5,2.8),xlab='Doba dokončení úlohy (minuty)',
      main=paste0('Průměr ',mean(x),' min; medián ',median(x),' min'))
    abline(v=mean(x),col='#B16A26',lwd=2);abline(v=median(x),col='#267888',lty=2,lwd=2)
  }
},height=5.4)
ch3_draw('kvantil-interpolace',{
  par(mfrow=c(2,1),mar=c(4.7,4.4,3.6,.6),cex=1)
  plot(100*ch3_interpolation_levels,ch3_interpolation,type='o',pch=21,
    bg='#267888',col='#267888',lwd=2,cex=1.15,xaxt='n',yaxt='n',bty='l',
    xlab='Přiřazená úroveň kvantilu (%)',ylab='Doba úlohy (minuty)',
    xlim=c(0,100),ylim=c(3,23),main='Jedenáct hodnot, deset kroků\npo 10 procentních bodech')
  axis(1,at=seq(0,100,10));axis(2,at=c(4,8,12,16,20,22))
  rect(10,5,20,7,border='#B16A26',lwd=2)
  arrows(31,5.5,21,6,length=.08,col='#B16A26')
  text(32,5.5,'Detail dole',adj=0,col='#8A4D17',cex=.95)
  plot(c(10,20),c(5,7),type='o',pch=21,bg='#267888',col='#267888',
    lwd=2,cex=1.3,xaxt='n',yaxt='n',bty='l',xlim=c(9,21),ylim=c(4.75,7.35),
    xlab='Přiřazená úroveň kvantilu (%)',ylab='Doba úlohy (minuty)',
    main='17. percentil: sedm desetin cesty\nod 5 k 7 minutám')
  axis(1,at=c(10,17,20));axis(2,at=c(5,6.4,7),labels=c('5','6,4','7'))
  segments(17,4.75,17,6.4,lty=2,col='#B16A26',lwd=2)
  segments(9,6.4,17,6.4,lty=2,col='#B16A26',lwd=2)
  points(17,6.4,pch=21,bg='#B16A26',col='white',cex=1.5)
  text(17,6.4,'6,4 min',pos=4,offset=.7,col='#8A4D17')
  text(10,5,'Druhý čas',pos=4,offset=.6,cex=.95)
  text(20,7,'Třetí čas',pos=2,offset=.7,cex=.95)
},width=5.5,height=7.8)
# Explicit type-7 box: never rely on R's default Tukey hinges.
ch3_draw('boxplot',{
  x<-ch3_x;q<-ch3_quantile(x,c(.25,.5,.75));iq<-q[3]-q[1]
  fences<-q[c(1,3)]+c(-1,1)*1.5*iq; inside<-x[x>=fences[1]&x<=fences[2]]
  plot(NA,xlim=c(2.8,10.7),ylim=c(.3,2.4),yaxt='n',xlab='Doba dokončení úlohy (minuty)',ylab='',bty='n')
  rect(q[1],.8,q[3],1.4,col='#DCEEF0',border='#267888',lwd=2)
  segments(q[2],.8,q[2],1.4,lwd=4,col='#223744')
  segments(min(inside),1.1,q[1],1.1,lwd=2);segments(q[3],1.1,max(inside),1.1,lwd=2)
  segments(range(inside),.95,range(inside),1.25,lwd=2)
  points(x[x<fences[1]|x>fences[2]],1.1,pch=21,bg='#B16A26',cex=1.4)
  abline(v=fences,lty=3,col='#999999')
  text(fences,2.15,c('Dolní mez 3,5','Horní mez 7,5'),cex=.85)
  text(c(4.7,6.35,10),c(1.75,1.75,1.75),c('Medián\n= dolní kvartil','Horní\nkvartil','Odlehlé\npozorování'),cex=.8)
  segments(c(4.7,6.35),1.58,c(5,6),1.42,col='#7A8C94')
  points(x,.38+.13*ave(x,x,FUN=seq_along),pch=16,col='#267888')
  title('Kvartily podle PERCENTIL.INC; vousy končí u pozorování')
},width=8,height=3.7)
ch3_draw('korekce-rozptylu',{
  z<-ch3_simulation_summary
  mat<-rbind(z$variance_n,z$variance_n1)
  pos<-barplot(mat,beside=TRUE,names.arg=paste0('n = ',z$n),ylim=c(0,11),
    col=c('#B16A26','#267888'),border=NA,ylab='Průměr vypočtených rozptylů (min²)',xlab='Rozsah jednoho výběru')
  abline(h=8,lty=2,lwd=2);text(pos,mat+.65,format(round(mat,2),decimal.mark=','),cex=.9)
  legend('top',legend=c('Dělení n','Dělení n − 1','Populační rozptyl 8'),
    col=c('#B16A26','#267888','#223744'),pch=c(15,15,NA),
    lty=c(NA,NA,2),lwd=2,bty='n',cex=.85,horiz=TRUE)
},height=5)
ch3_draw('entropie',{
  par(mfrow=c(1,3),mar=c(4,3.4,3,.4),cex=.9)
  entropies <- list(c(1,0,0,0),c(.5,.25,.25,0),rep(.25,4))
  for(i in seq_along(entropies)) {
    p <- entropies[[i]]
    barplot(p,names.arg=c('A','B','C','D'),ylim=c(0,1),col='#267888',border=NA,
      yaxt='n',ylab=if(i==1) 'Relativní četnost' else '',xlab='Strategie učení',
      main=c('Entropie 0 bitů','Entropie 1,5 bitu','Entropie 2 bity')[i])
    axis(2,at=c(0,.25,.5,.75,1),labels=c('0','0,25','0,50','0,75','1'))
  }
},width=8,height=3.7)
ch3_draw('spicatost',{
  par(mfrow=c(1,2),mar=c(4.3,4.3,3,.7))
  for(x in list(ch3_peak_a,ch3_peak_b)) {
    f<-table(factor(x,levels=-3:3))
    barplot(as.numeric(f),names.arg=-3:3,ylim=c(0,90),col='#267888',border=NA,
      ylab='Počet pozorování',xlab='Odchylka skóru od středu (body)',
      main=paste0('Stejný vrchol; exces ',format(round(ch3_moments(x)[2],2),decimal.mark=',')))
    text(4,84,'80 pozorování',cex=.85)
  }
},width=8,height=4.2)
ch3_draw('stejne-dve-statistiky',{
  par(mfrow=c(2,1),mar=c(3.7,4,2,.8))
  for(x in list(ch3_shape_a,ch3_shape_b)) {
    ch3_dots(x,xlim=c(2,10),ylim=c(.5,4.8),xlab='Skór v modelové úloze (body)',
      main='Průměr 6 bodů; výběrový rozptyl 4,8 bodu²')
  }
},height=5.5)
