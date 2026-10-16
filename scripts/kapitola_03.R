# Chapter 3: reproducible calculations and figures; base R, project-root paths.
ch3_previous <- read.csv('data/kapitola_02.csv', na.strings = '', fileEncoding = 'UTF-8')
# Fixed author examples; students get the same values in data/kapitola_03.xlsx.
ch3_x <- c(4,5,5,6,10)
ch3_trim <- c(2,3,4,5,5,6,7,8,9,31)
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
ch3_shape_breaks <- seq(-4.1,6.1,by=.2)
ch3_shape_centers <- head(ch3_shape_breaks,-1)+.1
ch3_shape_prob <- list(
  as.numeric(abs(ch3_shape_centers+1)<1e-8 | abs(ch3_shape_centers-1)<1e-8)/2,
  diff(pnorm(ch3_shape_breaks)),
  diff(pgamma(ch3_shape_breaks+2,shape=4,rate=2)))
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
ch3_draw('percentil-a-poradi',{
  par(mar=c(0,0,0,0));plot.new();plot.window(xlim=c(0,10),ylim=c(0,7),xaxs='i',yaxs='i')
  for(k in 1:2) {
    y<-if(k==1) 5 else 2
    text(.5,y+1.4,if(k==1) 'Otázka: Jaký je 50. percentil?' else 'Otázka: Jaké pořadí má čas 5 minut?',adj=0,font=2)
    text(.5,y+.8,if(k==1) 'Hledáme hodnotu v minutách.' else 'Počítáme všechny časy nejvýše 5 minut.',adj=0,cex=.9)
    selected<-if(k==1) seq_along(ch3_x)==3 else ch3_x<=5
    points(1:5,rep(y,5),pch=21,cex=3,bg=ifelse(selected,'#267888','white'),col='#223744')
    text(1:5,y-.55,ch3_x)
    text(7.6,y,if(k==1) 'Medián = 5 minut' else '3 / 5 = 60 %\nPercentilové pořadí 60',font=2,cex=1)
  }
  text(.5,.3,'Stejných pět časů: 4, 5, 5, 6 a 10 minut. Každý kruh je jeden čas.',adj=0,cex=.85)
},width=8,height=5.3)
ch3_draw('orezani-winsorizace',{
  par(mar=c(0,0,0,0));plot.new();plot.window(xlim=c(0,12),ylim=c(0,8),xaxs='i',yaxs='i')
  ys<-c(6.6,4.2,1.8);xs<-seq(1,11,length.out=10)
  trimmed<-ch3_trim[2:9];wins<-c(ch3_trim[2],trimmed,ch3_trim[9])
  for(k in 1:3) {
    y<-ys[k]
    text(.5,y+.8,c('Původní časy (minuty)','Ořezání: krajní hodnoty vynecháme z výpočtu',
      'Winsorizace: krajní hodnoty nahradíme')[k],adj=0,font=2)
    vals<-if(k==3) wins else ch3_trim
    for(i in 1:10) {
      edge<-i %in% c(1,10)
      rect(xs[i]-.35,y-.32,xs[i]+.35,y+.32,
        col=if(edge)'#FAECDD' else '#E5F1F3',border=if(edge)'#B16A26' else '#267888')
      text(xs[i],y,vals[i],col=if(k==2 && edge)'#737373' else '#223744')
      if(k==2 && edge) segments(xs[i]-.32,y-.3,xs[i]+.32,y+.3,col='#B16A26',lwd=2)
    }
    text(.5,y-.8,c('10 hodnot; průměr 8 min','8 hodnot; průměr 5,875 min',
      '10 hodnot; průměr 5,9 min')[k],adj=0,cex=.9)
    if(k==3) text(xs[c(1,10)],y+.48,c('2 → 3','31 → 9'),col='#8A4D17',cex=.85)
  }
  text(.5,.2,'Upravujeme 10 % na každém konci. Původní záznamy uchováme.',adj=0,cex=.85)
},width=8.5,height=5.8)
ch3_draw('vazeny-prumer',{
  par(mar=c(0,0,0,0));plot.new();plot.window(xlim=c(0,10),ylim=c(0,7),xaxs='i',yaxs='i')
  rect(.5,4.8,4.4,6.6,col='#E5F1F3',border='#267888')
  rect(5.6,4.8,9.5,6.6,col='#FAECDD',border='#B16A26')
  text(2.45,5.7,'10 lidí × průměr 4 min\nCelkový čas 40 min',cex=1.05)
  text(7.55,5.7,'30 lidí × průměr 8 min\nCelkový čas 240 min',cex=1.05)
  arrows(c(2.45,7.55),4.7,c(4,6),3.9,length=.1)
  text(5,3.5,'(40 + 240) min / (10 + 30) lidí = 7 min na člověka',font=2,cex=.95)
  segments(1.5,1.7,8.5,1.7,col='#223744')
  points(c(1.5,8.5),c(1.7,1.7),pch=19,col=c('#267888','#B16A26'),cex=1.4)
  points(6.75,1.7,pch=18,cex=2,col='#223744')
  text(c(1.5,6.75,8.5),1.05,c('4 min','7 min\nSpolečný průměr','8 min'),cex=.9)
  text(5,.25,'Větší skupina má při průměrování všech lidí větší váhu.',cex=.9)
},width=8,height=5)
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
# Exact continuous models on a 0-100 scale: symmetric beta and mirrored betas.
ch3_centre_models <- data.frame(a=c(5,5,2),b=c(5,2,5))
ch3_centre_models$mean <- with(ch3_centre_models,100*a/(a+b))
ch3_centre_models$median <- with(ch3_centre_models,100*qbeta(.5,a,b))
ch3_centre_models$mode <- with(ch3_centre_models,100*(a-1)/(a+b-2))
ch3_draw('stred-a-tvar',{
  par(mfrow=c(3,1),mar=c(6.1,1.2,2.8,1.2),mgp=c(2,.5,0),cex=1.15)
  titles<-c('Souměrné rozdělení','Zešikmené doleva',
    'Zešikmené doprava')
  cols<-c('#B16A26','#267888','#72549B'); types<-c(1,2,3)
  grid<-seq(0,100,length.out=1001)
  for(j in 1:3) {
    model<-ch3_centre_models[j,]
    den<-dbeta(grid/100,model$a,model$b)/100
    plot(grid,den,type='n',xlim=c(0,100),ylim=c(0,.03),axes=FALSE,
      xlab='',ylab='',main=titles[j],cex.main=1.1,xaxs='i',yaxs='i')
    polygon(c(grid,100,0),c(den,0,0),col='#E7EFF4',border=NA)
    axis(1,at=seq(0,100,20),cex.axis=.95)
    lines(grid,den,col='#315D80',lwd=2.5)
    centres<-as.numeric(model[c('mean','median','mode')])
    if(j==1) {
      segments(50,0,50,dbeta(.5,5,5)/100,col='#223744',lwd=2)
      text(50,-.015,'Průměr = medián = modus = 50',xpd=NA,cex=1.02)
    } else {
      # Staggered leader labels keep close mean/median positions legible.
      order_x<-order(centres)
      label_x<-if(j==2) c(47,70,92) else c(8,30,53)
      for(k in 1:3) {
        i<-order_x[k]; at<-centres[i]
        segments(at,0,at,dbeta(at/100,model$a,model$b)/100,
          col=cols[i],lty=types[i],lwd=2)
        segments(at,-.006,label_x[k],-.010,xpd=NA,col=cols[i])
        label<-paste0(c('Průměr','Medián','Modus')[i],'\n',
          format(round(at,1),decimal.mark=',',trim=TRUE))
        text(label_x[k],-.014,label,xpd=NA,col=cols[i],cex=1.02)
      }
    }
    text(50,-.025,'Skór (body)',xpd=NA,cex=.95)
  }
},width=5.5,height=10.5)
# Own discrete counterexamples after von Hippel (2005, sections 2-3); both are
# unimodal with a longer right tail. Frequencies are printed in the chapter.
ch3_exceptions <- list(
  pokusy=list(values=1:5,freq=c(38,49,8,3,2)),
  chyby=list(values=0:4,freq=c(8,7,3,1,1)))
ch3_exception_stats <- do.call(rbind,lapply(ch3_exceptions,function(e) {
  x<-rep(e$values,e$freq)
  data.frame(n=length(x),mean=mean(x),median=median(x),
    mode=e$values[which.max(e$freq)],g1=unname(ch3_moments(x)['g1']))
}))
ch3_draw('stred-vyjimky',{
  par(mfrow=c(2,1),mar=c(6.2,4.4,2.8,1),mgp=c(2.4,.6,0))
  titles<-c('A: Počet pokusů do splnění úlohy (100 lidí)',
    'B: Počet chyb v krátkém testu pozornosti (20 lidí)')
  xlabs<-c('Počet pokusů','Počet chyb')
  for(j in 1:2) {
    e<-ch3_exceptions[[j]]; s<-ch3_exception_stats[j,]
    mids<-barplot(e$freq,names.arg=e$values,col='#E7EFF4',border='#315D80',
      ylim=c(0,max(e$freq)*1.15),main=titles[j],cex.main=1,ylab='Četnost',
      xlab=xlabs[j],space=.25)
    # Map values to bar centres so the lines sit on the value axis.
    at<-function(v) approx(e$values,mids,v)$y
    fmt<-function(v) format(round(v,2),decimal.mark=',',trim=TRUE)
    # Coinciding measures are spread symmetrically around their common value.
    pos<-c(s$mean,s$median,s$mode)
    dodge<-ave(pos,round(pos,9),FUN=function(z) (seq_along(z)-(length(z)+1)/2)*.08)
    cols<-c('#B16A26','#267888','#72549B')
    for(k in 1:3) segments(at(pos[k])+dodge[k],0,at(pos[k])+dodge[k],
      max(e$freq)*1.1,col=cols[k],lty=k,lwd=2.5)
    legend('topright',c('Průměr','Medián','Modus'),col=cols,lty=1:3,lwd=2.5,
      bty='n',cex=.85)
    label<-if(j==1) paste0('Průměr ',fmt(s$mean),' < medián ',fmt(s$median),
      ' = modus ',fmt(s$mode),'; delší chvost vpravo') else
      paste0('Modus ',fmt(s$mode),' < průměr ',fmt(s$mean),' = medián ',
        fmt(s$median),'; rozdělení není souměrné')
    mtext(label,side=1,line=4.6,cex=.9,font=2)
  }
},width=7,height=7.4)
# Same observations as the chapter table. Squares are geometric areas, not
# distances on the observation-number axis. Direction avoids overlapping areas.
ch3_deviations <- ch3_x-mean(ch3_x)
ch3_square_left <- c(-1,2,3,4,5)
ch3_square_width <- abs(ch3_deviations)
ch3_draw('odchylky-a-ctverce',{
  par(mfrow=c(2,1),mar=c(4.3,4.3,3.2,.8),mgp=c(2.5,.65,0),cex=1.05)
  cols<-c('#B35A18','#0072B2','#00836B','#667078','#8055A0')
  for(panel in 1:2) {
    plot(seq_along(ch3_x),ch3_x,type='n',xlim=c(-1.5,9.5),ylim=c(2.5,10.8),
      asp=1,axes=FALSE,xlab='Číslo pozorování',ylab='Doba dokončení (minuty)',
      main=if(panel==1) 'A. Odchylky od průměru\nDélka úsečky = absolutní odchylka' else
        'B. Čtverce odchylek\nPlocha čtverce = druhá mocnina odchylky',cex.main=.95)
    axis(1,at=1:5);axis(2,at=seq(2,10,2));box(bty='l')
    if(panel==2) for(i in seq_along(ch3_x)) {
      rect(ch3_square_left[i],min(ch3_x[i],mean(ch3_x)),
        ch3_square_left[i]+ch3_square_width[i],max(ch3_x[i],mean(ch3_x)),
        col=adjustcolor(cols[i],alpha.f=.20),border=cols[i],lwd=1.5)
      if(ch3_square_width[i]>0) text(ch3_square_left[i]+ch3_square_width[i]/2,
        (ch3_x[i]+mean(ch3_x))/2,paste0(ch3_deviations[i]^2,' min²'),
        cex=if(ch3_square_width[i]==1) .72 else .95,col=cols[i])
    }
    abline(h=mean(ch3_x),lty=2,col='#223744',lwd=1.5)
    text(9.3,6.3,'Průměr = 6 min',adj=1,cex=.9)
    segments(1:5,mean(ch3_x),1:5,ch3_x,col=cols,lwd=3)
    points(1:5,ch3_x,pch=21,bg=cols,col='white',cex=1.5)
    if(panel==1) {
      text((1:5)[-4]+.23,(ch3_x[-4]+mean(ch3_x))/2,
        c('−2','−1','−1','+4'),adj=0,col=cols[-4],cex=.95)
      text(4,5.5,'0',col=cols[4],cex=.95)
      text(7.2,3.6,'Součet délek\n8 min',cex=1)
    } else {
      text(4,6.55,'0 min²',col=cols[4],cex=.85)
      text(7.2,3.6,'Součet ploch\n22 min²',cex=1)
    }
  }
},width=6.5,height=11)
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
ch3_box_x <- c(2,5,15,25,30,32,34,36,38,40,40,42,44,44,46,46,48,48,49,50,50,
  50,51,52,52,54,54,56,56,58,60,60,62,64,66,68,70,75,85,95,98)
ch3_box_q <- ch3_quantile(ch3_box_x,c(.25,.5,.75))
ch3_box_iqr <- ch3_box_q[3]-ch3_box_q[1]
ch3_box_fences <- ch3_box_q[c(1,3)]+c(-1,1)*1.5*ch3_box_iqr
ch3_box_inside <- ch3_box_x[ch3_box_x>=ch3_box_fences[1]&ch3_box_x<=ch3_box_fences[2]]
ch3_box_out <- ch3_box_x[ch3_box_x<ch3_box_fences[1]|ch3_box_x>ch3_box_fences[2]]
ch3_draw('boxplot',{
  x<-ch3_box_x;q<-ch3_box_q;fences<-ch3_box_fences
  par(mar=c(2,4,3,1),mgp=c(2.2,.6,0),cex=1.05)
  plot(NA,xlim=c(0,5.8),ylim=c(-3,105),axes=FALSE,xlab='',ylab='Testový skór (body)')
  axis(2,at=seq(0,100,10));box(bty='l')
  text(.4,104,'Pozorování',cex=.9);text(1.65,104,'Krabicový graf',cex=.9)
  offset<-ave(x,x,FUN=function(z) (seq_along(z)-(length(z)+1)/2)*.13)
  points(.4+offset,x,pch=16,col='#70AABB',cex=1)
  rect(1.3,q[1],2,q[3],col='#DCEEF0',border='#267888',lwd=2)
  segments(1.3,q[2],2,q[2],lwd=4,col='#223744')
  segments(1.65,min(ch3_box_inside),1.65,q[1],lwd=2)
  segments(1.65,q[3],1.65,max(ch3_box_inside),lwd=2)
  segments(1.3,range(ch3_box_inside),2,range(ch3_box_inside),lwd=2)
  points(rep(1.65,length(ch3_box_out)),ch3_box_out,pch=21,bg='#B16A26',cex=1.25)
  segments(1.15,fences,2.35,fences,lty=3,col='#667078',lwd=1.5)
  bracket<-function(at,low,high,col) {
    segments(at,low,at,high,col=col,lwd=1.5)
    segments(at-.07,c(low,high),at+.07,c(low,high),col=col,lwd=1.5)
  }
  bracket(.98,q[1],q[3],'#267888')
  text(.79,50,'IQR = 20 bodů',srt=90,col='#267888',cex=.9)
  bracket(2.25,fences[1],q[1],'#8055A0');bracket(2.25,q[3],fences[2],'#8055A0')
  text(2.55,c(25,75),'1,5 × IQR = 30 bodů',adj=0,col='#8055A0',cex=.95)
  label<-function(y,txt,col='#223744',from=2.03,to=y) {
    arrows(2.48,y,from,to,length=.07,col=col)
    text(2.55,y,txt,adj=0,col=col,cex=.95)
  }
  label(60,'3. kvartil = 60');label(50,'Medián = 50');label(40,'1. kvartil = 40')
  label(84,'Horní vous: konec 85',to=85)
  label(16,'Dolní vous: konec 15',to=15)
  label(91,'Horní mez = 90',col='#667078',from=2.35,to=90)
  label(9,'Dolní mez = 10',col='#667078',from=2.35,to=10)
  label(98,'Podezřelá odlehlá\npozorování: 95 a 98',col='#B16A26',from=1.75,to=98)
  arrows(2.48,98,1.75,95,length=.07,col='#B16A26')
  label(1,'Podezřelá odlehlá\npozorování: 2 a 5',col='#B16A26',from=1.75,to=2)
  arrows(2.48,1,1.75,5,length=.07,col='#B16A26')
},width=6.8,height=9)
ch3_draw('korekce-rozptylu',{
  # Points: the first 400 replications of each size (jittered); crosses: means of all 20 000.
  z<-ch3_simulation_summary;cols<-c('#B16A26','#267888');xc<-c(1,4,7);off<-c(-.45,.45)
  plot(NA,xlim=c(-.4,8.4),ylim=c(0,23),xaxt='n',bty='l',xaxs='i',
    ylab='Rozptyl jednoho výběru (min²)',xlab='Velikost výběru')
  axis(1,at=xc,labels=paste0('n = ',z$n),tick=FALSE)
  abline(h=8,lty=2,lwd=2)
  set.seed(20261016)
  for(k in seq_along(ch3_simulations)) for(j in 1:2) {
    v<-head(ch3_simulations[[k]][[c('variance_n','variance_n1')[j]]],400)
    points(xc[k]+off[j]+runif(length(v),-.28,.28),v,pch=16,cex=.55,col=adjustcolor(cols[j],.3))
  }
  means<-rbind(z$variance_n,z$variance_n1)
  for(j in 1:2) {
    points(xc+off[j],means[j,],pch=4,cex=1.9,lwd=5,col='white')
    points(xc+off[j],means[j,],pch=4,cex=1.9,lwd=2.5,col='#223744')
    lab<-format(round(means[j,],2),decimal.mark=',')
    w<-strwidth(lab,cex=.85,font=2);h<-strheight(lab,cex=.85,font=2)
    lx<-xc+off[j]+c(-.42,.42)[j];l0<-if(j==1) lx-w else lx
    rect(l0-.05,means[j,]-.8*h,l0+w+.05,means[j,]+.8*h,col='white',border=NA)
    text(l0,means[j,],lab,adj=0,cex=.85,font=2,col=cols[j])
  }
  legend('topright',legend=c('Dělení n','Dělení n − 1','Průměr','Populační rozptyl 8'),
    col=c(cols,'#223744','#223744'),pch=c(16,16,4,NA),pt.cex=c(1,1,1.3,NA),
    lty=c(NA,NA,NA,2),lwd=c(NA,NA,2.5,2),bty='n',cex=.85,ncol=2)
},height=5.2)
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
  par(mfrow=c(3,1),mar=c(3.5,4.5,3,.7),cex=1)
  for(i in 1:3) {
    p<-ch3_shape_prob[[i]]
    ymax<-c(.53,.11,.12)[i]
    plot(NA,xlim=c(-4,6),ylim=c(0,ymax),xlab='Hodnota proměnné',ylab='Pravděpodobnost v intervalu',yaxt='n',
      main=c('Dvě stejně pravděpodobné hodnoty','Souměrné zvonovité rozdělení','Rozdělení zešikmené doprava')[i],bty='l')
    ticks<-if(i==1) seq(0,.5,.1) else seq(0,.1,.02)
    axis(2,at=ticks,labels=format(ticks,decimal.mark=','))
    rect(head(ch3_shape_breaks,-1),0,tail(ch3_shape_breaks,-1),p,col='#70AABB',border='white')
    abline(v=0,lty=2,col='#B16A26')
    text(5.8,ymax*.83,'Průměr = 0\nSměrodatná odchylka = 1',adj=1,cex=.9)
  }
},width=6.5,height=9)
ch3_draw('transformace',{
  par(mfrow=c(2,1),mar=c(4,4.5,3,.8))
  for(i in 1:2) {
    z<-seq(0,10,length.out=201);f<-if(i==1) function(x) 2+3*x else function(x) x^2
    plot(z,f(z),type='l',lwd=2,col='#267888',xlab='Původní skór x',ylab='Nový skór y',
      main=if(i==1) 'Lineární: y = 2 + 3x' else 'Nelineární: y = x²',bty='l')
    points(c(2,3,8,9),f(c(2,3,8,9)),pch=19,col='#B16A26')
    segments(c(2,8),f(c(2,8)),c(3,9),f(c(2,8)),lty=3)
    arrows(c(3,9),f(c(2,8)),c(3,9),f(c(3,9)),code=3,angle=90,length=.08)
    # Labels sit right of the increment bars, clear of the line and points.
    text(c(3,9)+.1,(f(c(2,8))+f(c(3,9)))/2,
      if(i==1) c('+3','+3') else c('+5','+17'),pos=4,cex=.9)
  }
},width=6,height=8)
