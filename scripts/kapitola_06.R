# Teaching model, simulations and figures for chapter 6; base R, UTF-8, deterministic project-root paths.
# Study summaries are quoted from Howell (2013, p. 86). Every distribution and simulated value is a teaching model.
ch6_out <- 'assets/chapter-06/plots'
ch6_old_options <- options(OutDec=',')
dir.create(ch6_out,recursive=TRUE,showWarnings=FALSE)
ch6_blue <- '#245D78'; ch6_orange <- '#B54E24'; ch6_fill <- '#B8DDE8'; ch6_gray <- '#4D5A63'; ch6_pale <- '#E1E8EB'; ch6_sand <- '#FAECDD'; ch6_ink <- '#223744'; ch6_mute <- '#A9BAC3'
ch6_num <- function(x,digits=3) formatC(x,format='f',digits=digits,decimal.mark=',')
ch6_draw <- function(name,code,width=8,height=4.5) {
  svg(file.path(ch6_out,paste0(name,'.svg')),width=width,height=height,family='sans',bg='white')
  par(mar=c(4.5,4.5,2.6,.8),mgp=c(2.7,.7,0),las=1,col.axis=ch6_ink,col.lab=ch6_ink,fg=ch6_ink,cex=.9)
  force(code); dev.off()
}
# Fixed inputs ------------------------------------------------------------------
# Parking study as reported by Howell: two groups of 100 drivers, means and a common standard deviation in seconds.
ch6_study <- c(n=100,bez=32.15,cekajici=39.03,s=14.6)
ch6_diff <- unname(ch6_study['cekajici']-ch6_study['bez'])
# Teaching population of leaving times: mean 35 s and SD 15 s are Howell's simulation values;
# the right-skewed (gamma) shape is our own assumption.
ch6_mu <- 35; ch6_sigma <- 15
ch6_shape <- (ch6_mu/ch6_sigma)^2; ch6_scale <- ch6_sigma^2/ch6_mu
ch6_dpop <- function(x) dgamma(x,shape=ch6_shape,scale=ch6_scale)
ch6_rpop <- function(n) rgamma(n,shape=ch6_shape,scale=ch6_scale)
ch6_se <- function(n,sigma=ch6_sigma) sigma/sqrt(n)
ch6_se_diff <- sqrt(2)*ch6_se(100)
ch6_crit <- qnorm(.975)*ch6_se_diff
# Probability that a two-sided test with fixed bounds rejects when the true difference is d.
ch6_power <- function(d,crit=ch6_crit,se=ch6_se_diff) pnorm(-crit,d,se)+pnorm(crit,d,se,lower.tail=FALSE)
# Exact example: all ordered pairs drawn with replacement from three equally likely times.
ch6_three <- c(20,35,50)
ch6_pairs <- expand.grid(druha=ch6_three,prvni=ch6_three)[,c('prvni','druha')]
ch6_pairs$prumer <- rowMeans(ch6_pairs)
ch6_exact <- data.frame(prumer=sort(unique(ch6_pairs$prumer)))
ch6_exact$p <- vapply(ch6_exact$prumer,function(v) mean(ch6_pairs$prumer==v),numeric(1))
# Worked tests: guessing on a 20-item test (chapter 5) and an attention score against the norm N(50, 10).
ch6_test <- c(n=20,pi=.25,k=10)
ch6_z <- c(mu0=50,sigma=10,n=25,m=46)
# Simulations: seeds and the order of draws are fixed ----------------------------
ch6_reps <- 10000; ch6_sizes <- c(2,5,30,100)
set.seed(20261013)
ch6_draws <- lapply(ch6_sizes,function(n) matrix(ch6_rpop(n*ch6_reps),ch6_reps,n))
names(ch6_draws) <- paste0('n',ch6_sizes)
ch6_means <- vapply(ch6_draws,rowMeans,numeric(ch6_reps))
ch6_shown <- ch6_draws$n30[1:8,]
ch6_one_sample <- ch6_shown[3,]
ch6_medians30 <- apply(ch6_draws$n30,1,median)
ch6_sds30 <- apply(ch6_draws$n30,1,sd)
ch6_sds100 <- apply(ch6_draws$n100,1,sd)
rm(ch6_draws)
# Differences between the means of two independent samples of 100 from the same population.
set.seed(20261014)
ch6_diffs <- rowMeans(matrix(ch6_rpop(100*ch6_reps),ch6_reps))-rowMeans(matrix(ch6_rpop(100*ch6_reps),ch6_reps))
# Groups of different sizes whose scores all come from one population N(50, 10).
set.seed(20261015)
ch6_group_n <- round(exp(runif(150,log(10),log(400))))
ch6_group_m <- rnorm(150,50,10/sqrt(ch6_group_n))
ch6_group_extreme <- rank(abs(ch6_group_m-50))>130
# Drawing helpers -----------------------------------------------------------------
# Relative-frequency histogram drawn with rectangles; returns the histogram object.
ch6_hist <- function(v,by,xlim,main,ylim=NULL,col=ch6_blue,xlab='',ylab='Podíl výběrů',density=FALSE,...) {
  br <- seq(floor(min(v,xlim[1])/by)*by,ceiling(max(v,xlim[2])/by)*by,by=by)
  h <- hist(v,breaks=br,plot=FALSE); y <- h$counts/length(v)/if(density) by else 1
  plot(NA,xlim=xlim,ylim=if(is.null(ylim)) c(0,max(y)*1.16) else ylim,xlab=xlab,ylab=ylab,main=main,bty='l',yaxs='i',...)
  rect(br[-length(br)],0,br[-1],y,col=col,border='white',lwd=.4)
  invisible(h)
}
# Area under a normal curve between two bounds.
ch6_area <- function(from,to,mean,sd,col) {
  x <- seq(from,to,length.out=200)
  polygon(c(from,x,to),c(0,dnorm(x,mean,sd),0),col=col,border=NA)
}
ch6_curve <- function(mean,sd,xlim,main,xlab,ylim=NULL,ylab='Hustota',...) {
  x <- seq(xlim[1],xlim[2],length.out=500); y <- dnorm(x,mean,sd)
  plot(NA,xlim=xlim,ylim=if(is.null(ylim)) c(0,max(y)*1.2) else ylim,xlab=xlab,ylab=ylab,main=main,bty='l',yaxs='i',...)
  invisible(list(x=x,y=y))
}
# Figures -------------------------------------------------------------------------
ch6_draw('tri-vrstvy', {
  par(mar=c(.3,.3,.3,.3))
  plot(NA,xlim=c(0,12),ylim=c(.6,4.9),axes=FALSE,xlab='',ylab='')
  xs <- c(2,6,10); fills <- c(ch6_sand,ch6_fill,ch6_pale)
  heads <- c('Skutečná studie','Výukový model','Simulovaná data')
  body <- c('dvě skupiny po 100 řidičích\nprůměry 32,15 s a 39,03 s\nrozdíl 6,88 s','populace dob opuštění místa\nprůměr 35 s, směrodatná\nodchylka 15 s, tvar zešikmený\ndoprava','10 000 opakovaných výběrů,\nkteré z modelu vylosoval\npočítač')
  src <- c('čísla podle Howella (2013)','naše předpoklady','náš výpočet')
  for(i in 1:3) {
    rect(xs[i]-1.75,1.2,xs[i]+1.75,4.7,col=fills[i],border=ch6_ink,lwd=1.4)
    text(xs[i],4.25,heads[i],font=2,cex=1.02); text(xs[i],3.05,body[i],cex=.84); text(xs[i],1.6,src[i],cex=.8,font=3,col=ch6_gray)
  }
  arrows(c(3.8,7.8),2.95,c(4.2,8.2),2.95,length=.08,lwd=1.8,col=ch6_orange)
  text(4,.85,'výsledek porovnáváme s modelem',cex=.8,col=ch6_orange); text(8,.85,'z modelu losujeme výběry',cex=.8,col=ch6_orange)
},width=9.4,height=3.5)
ch6_draw('podil-rozdeleni', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.7))
  for(n in c(20,80)) {
    k <- 0:n; p <- dbinom(k,n,.25)
    plot(k/n,p,type='h',lwd=if(n==20) 8 else 3.2,lend=1,col=ch6_blue,xlim=c(0,.6),ylim=c(0,.22),xlab='Podíl správných odpovědí ve výběru',ylab='Pravděpodobnost',main=paste0('Test s ',n,' otázkami'),bty='l',yaxs='i')
    abline(v=.25,lty=2,lwd=1.6,col=ch6_orange)
    text(.59,.2,paste0('směrodatná chyba\npodílu ',ch6_num(sqrt(.25*.75/n))),adj=1,cex=.84)
    text(.262,.212,'π = 0,25',adj=0,cex=.8,col=ch6_orange)
  }
},width=10,height=4.3)
ch6_draw('devet-vyberu', {
  layout(matrix(1:2,1),widths=c(1.08,1)); par(mar=c(.5,.5,2.6,.5))
  plot(NA,xlim=c(-1.25,3.05),ylim=c(-.1,3.75),axes=FALSE,xlab='',ylab='',asp=1,main='Devět stejně pravděpodobných výběrů')
  for(i in 1:3) for(j in 1:3) {
    m <- (ch6_three[i]+ch6_three[j])/2
    rect(j-1,3-i,j,4-i,col=if(m==35) ch6_fill else 'white',border=ch6_ink)
    text(j-.5,3.66-i,paste0(ch6_three[i],' a ',ch6_three[j]),cex=.82)
    text(j-.5,3.32-i,paste0('průměr ',format(m)),cex=.86,font=2)
  }
  text(1:3-.5,3.18,ch6_three,cex=.86,col=ch6_gray); text(1.5,3.52,'druhá vylosovaná doba (s)',cex=.84,col=ch6_gray)
  text(-.16,3:1-.5,ch6_three,cex=.86,col=ch6_gray); text(-.72,1.5,'první\nvylosovaná\ndoba (s)',cex=.84,col=ch6_gray)
  par(mar=c(4.6,4.7,2.6,.7))
  m <- ch6_exact$prumer; p <- ch6_exact$p
  plot(m,p,type='h',lwd=13,lend=1,col=ch6_blue,xlim=c(15,55),ylim=c(0,.4),xaxt='n',xlab='Průměr dvou dob (s)',ylab='Pravděpodobnost',main='Výběrové rozdělení průměru',bty='l',yaxs='i')
  axis(1,at=m,labels=c('20','27,5','35','42,5','50')); text(m,p+.024,c('1/9','2/9','3/9','2/9','1/9'),cex=.86)
},width=10,height=4.5)
ch6_draw('tri-urovne', {
  par(mfrow=c(3,1),mar=c(2.3,5.6,2.4,.8),mgp=c(3.6,.7,0),cex=.82)
  x <- seq(0,100,length.out=500)
  plot(NA,xlim=c(0,100),ylim=c(0,.034),xlab='',ylab='Hustota',main='Populace ve výukovém modelu',bty='l',yaxs='i')
  polygon(c(x,100,0),c(ch6_dpop(x),0,0),col=ch6_pale,border=NA); lines(x,ch6_dpop(x),lwd=2.2,col=ch6_blue)
  segments(ch6_mu,0,ch6_mu,ch6_dpop(ch6_mu),lty=2,lwd=1.6,col=ch6_orange)
  text(ch6_mu+1.5,.0045,'populační průměr 35 s',adj=0,cex=.92,col=ch6_orange)
  text(99,.027,'jedna hodnota na ose\n= doba jednoho řidiče',adj=1,cex=.92)
  plot(NA,xlim=c(0,100),ylim=c(0,1),yaxt='n',xlab='',ylab='',main='Jeden výběr: 30 řidičů',bty='l')
  y <- .56+((seq_along(ch6_one_sample)*7)%%11-5)/26
  points(ch6_one_sample,y,pch=21,bg=ch6_fill,col=ch6_ink,cex=1.5)
  points(mean(ch6_one_sample),.1,pch=17,col=ch6_orange,cex=1.9)
  text(mean(ch6_one_sample)+2,.1,paste0('průměr tohoto výběru ',ch6_num(mean(ch6_one_sample),1),' s'),adj=0,cex=.92,col=ch6_orange)
  text(99,.8,'jeden bod\n= jeden řidič',adj=1,cex=.92)
  par(mar=c(4.4,5.6,2.4,.8))
  ch6_hist(ch6_means[,'n30'],1,c(0,100),'Výběrové rozdělení průměru: 10 000 výběrů po 30 řidičích',xlab='',ylim=c(0,.17))
  title(xlab='Doba v sekundách',mgp=c(2.7,.7,0))
  text(99,.125,'jedna hodnota na ose\n= průměr jednoho celého výběru',adj=1,cex=.92)
},width=8.6,height=7.6)
ch6_draw('prumery-simulace', {
  par(mfrow=c(3,1),mar=c(2.3,5,2.4,.8),cex=.82)
  for(j in 2:4) {
    n <- ch6_sizes[j]; if(j==4) par(mar=c(4.4,5,2.4,.8))
    ch6_hist(ch6_means[,j],1,c(10,65),paste0('Průměry 10 000 výběrů po ',n,' řidičích'),xlab=if(j==4) 'Průměr výběru (s)' else '',ylim=c(0,.3))
    abline(v=ch6_mu,lty=2,lwd=1.5,col=ch6_orange)
    text(64.5,.22,paste0('průměr těchto průměrů ',ch6_num(mean(ch6_means[,j]),2),' s\njejich směrodatná odchylka ',ch6_num(sd(ch6_means[,j]),2),' s'),adj=1,cex=.92)
  }
},width=8.6,height=7.2)
ch6_draw('smerodatna-chyba', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.8))
  x <- seq(0,90,length.out=700)
  plot(NA,xlim=c(0,90),ylim=c(0,.29),xlab='Doba (s)',ylab='Hustota',main='Řidiči a průměry sta řidičů',bty='l',yaxs='i')
  polygon(c(x,90,0),c(ch6_dpop(x),0,0),col=ch6_pale,border=NA); lines(x,ch6_dpop(x),lwd=2,col=ch6_gray)
  lines(x,dnorm(x,ch6_mu,ch6_se(100)),lwd=2.2,col=ch6_blue)
  text(88,.045,'jednotliví řidiči:\nsměrodatná odchylka 15 s',adj=1,cex=.82,col=ch6_gray)
  text(40,.2,'průměry sta řidičů:\nsměrodatná chyba 1,5 s',adj=0,cex=.82,col=ch6_blue)
  n <- 1:400
  plot(n,ch6_se(n),type='l',lwd=2.2,col=ch6_blue,ylim=c(0,15.5),xlab='Velikost výběru n',ylab='Směrodatná chyba průměru (s)',main='Čtyřnásobný výběr, poloviční chyba',bty='l',yaxs='i')
  k <- c(25,100,400); points(k,ch6_se(k),pch=21,bg=ch6_orange,col=ch6_ink,cex=1.4)
  text(k[1:2]+12,ch6_se(k[1:2])+1.1,paste0('n = ',k[1:2],': ',c('3,0','1,5'),' s'),adj=0,cex=.84)
  text(k[3],ch6_se(k[3])+1.5,'n = 400: 0,75 s',adj=1,cex=.84)
},width=10,height=4.4)
ch6_draw('trychtyr', {
  par(mar=c(4.6,4.7,2.7,.8))
  plot(NA,xlim=c(0,410),ylim=c(41,59),xlab='Počet lidí ve skupině',ylab='Průměr skupiny (body)',main='150 simulovaných skupin z jediné populace s průměrem 50 bodů',bty='l',xaxs='i')
  n <- seq(8,410,length.out=300)
  lines(n,50+2*10/sqrt(n),lty=2,col=ch6_gray); lines(n,50-2*10/sqrt(n),lty=2,col=ch6_gray); abline(h=50,col=ch6_gray)
  points(ch6_group_n[!ch6_group_extreme],ch6_group_m[!ch6_group_extreme],pch=21,bg=ch6_fill,col=ch6_ink,cex=1.1)
  points(ch6_group_n[ch6_group_extreme],ch6_group_m[ch6_group_extreme],pch=21,bg=ch6_orange,col=ch6_ink,cex=1.3)
  legend('topright',c('20 skupin s průměrem nejdále od 50','ostatní skupiny','50 ± 2 směrodatné chyby'),pch=c(21,21,NA),pt.bg=c(ch6_orange,ch6_fill,NA),lty=c(NA,NA,2),col=c(ch6_ink,ch6_ink,ch6_gray),bty='n',cex=.84)
},width=8.6,height=4.8)
ch6_draw('zvc-clv', {
  # Two heading strips keep the row titles clear of the panel titles.
  layout(matrix(c(1,1,1,1,2:5,6,6,6,6,7:10),4,byrow=TRUE),heights=c(.13,1,.13,1))
  ch6_strip <- function(label) { par(mar=c(0,0,0,0)); plot.new(); text(.5,.45,label,font=2,cex=1.25) }
  ch6_strip('Průměry v sekundách: rozptýlenost klesá')
  par(mar=c(4.3,4.2,2.2,.5),mgp=c(2.5,.6,0),cex=.74)
  for(j in 1:4) ch6_hist(ch6_means[,j],1,c(0,90),paste0('n = ',ch6_sizes[j]),xlab='Průměr výběru (s)',ylim=c(0,.29))
  ch6_strip('Tytéž průměry po standardizaci: tvar se blíží normální křivce (přerušovaně)')
  par(mar=c(4.3,4.2,2.2,.5),mgp=c(2.5,.6,0),cex=.74)
  for(j in 1:4) {
    z <- (ch6_means[,j]-ch6_mu)/ch6_se(ch6_sizes[j])
    ch6_hist(z,.25,c(-4,5),paste0('n = ',ch6_sizes[j]),xlab='Standardizovaný průměr',ylab='Hustota',ylim=c(0,.52),density=TRUE)
    curve(dnorm(x),from=-4,to=5,add=TRUE,lwd=1.8,lty=2,col=ch6_orange,n=300)
  }
},width=10.4,height=6.6)
ch6_draw('clv-qq', {
  par(mfrow=c(1,4),mar=c(4.4,4.2,2.6,.5),mgp=c(2.5,.6,0),cex=.78)
  p <- (1:199)/200
  for(j in 1:4) {
    z <- (ch6_means[,j]-ch6_mu)/ch6_se(ch6_sizes[j])
    plot(qnorm(p),quantile(z,p,names=FALSE),pch=16,cex=.55,col=ch6_blue,xlim=c(-3,3),ylim=c(-3,4.6),xlab='Teoretický normální kvantil',ylab='Kvantil standardizovaných průměrů',main=paste0('n = ',ch6_sizes[j]),bty='l')
    abline(0,1,lty=2,lwd=1.5,col=ch6_orange)
  }
},width=10.4,height=3.6)
ch6_draw('jine-statistiky', {
  par(mfrow=c(1,3),mar=c(4.5,4.3,2.7,.5),mgp=c(2.5,.6,0),cex=.82)
  ch6_hist(ch6_means[,'n30'],1,c(18,52),'Průměr',xlab='Průměr výběru (s)',ylim=c(0,.2))
  abline(v=ch6_mu,lty=2,lwd=1.5,col=ch6_orange)
  ch6_hist(ch6_medians30,1,c(18,52),'Medián',xlab='Medián výběru (s)',ylim=c(0,.2))
  abline(v=qgamma(.5,shape=ch6_shape,scale=ch6_scale),lty=2,lwd=1.5,col=ch6_orange)
  ch6_hist(ch6_sds30,1,c(4,30),'Směrodatná odchylka',xlab='Směrodatná odchylka výběru (s)',ylim=c(0,.2))
  abline(v=ch6_sigma,lty=2,lwd=1.5,col=ch6_orange)
},width=10,height=3.9)
ch6_draw('plocha-prumeru', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.8))
  se <- ch6_se(100)
  cv <- ch6_curve(ch6_mu,se,c(29,41),'Průměr sta řidičů ve výukovém modelu','Průměr výběru (s)')
  ch6_area(38,41,ch6_mu,se,ch6_orange); lines(cv$x,cv$y,lwd=2.2,col=ch6_blue)
  segments(c(35,38),0,c(35,38),dnorm(c(35,38),ch6_mu,se),lty=2,col=ch6_gray)
  text(38.3,.085,paste0('nad 38 s:\n',ch6_num(pnorm(38,ch6_mu,se,lower.tail=FALSE))),adj=0,cex=.84,col=ch6_orange)
  ch6_hist(ch6_diffs,.5,c(-9,9),'Rozdíl průměrů dvou výběrů po 100 řidičích',xlab='Rozdíl průměrů (s)',ylab='Hustota',ylim=c(0,.3),col=ch6_mute,density=TRUE)
  ch6_area(-9,-3,0,ch6_se_diff,adjustcolor(ch6_orange,.75)); ch6_area(3,9,0,ch6_se_diff,adjustcolor(ch6_orange,.75))
  curve(dnorm(x,0,ch6_se_diff),from=-9,to=9,add=TRUE,lwd=2.2,col=ch6_blue,n=400)
  text(-8.8,.275,'sloupce: 10 000\nsimulovaných rozdílů',adj=0,cex=.8,col=ch6_gray)
  text(8.8,.275,'křivka: normální model\nse směrodatnou chybou 2,12 s',adj=1,cex=.8,col=ch6_blue)
  text(8.8,.15,paste0('rozdíl větší než 3 s\nv kterémkoli směru: ',ch6_num(2*pnorm(-3,0,ch6_se_diff))),adj=1,cex=.8,col=ch6_orange)
},width=10.4,height=4.4)
ch6_draw('extremnejsi', {
  par(mfrow=c(1,3),mar=c(4.5,4.2,3.4,.5),mgp=c(2.5,.6,0),cex=.8)
  obs <- 4; se <- ch6_se_diff
  mains <- c('Alternativa: průměry se liší','Alternativa: s čekajícím\ntrvá odjezd déle','Alternativa: s čekajícím\ntrvá odjezd kratší dobu')
  probs <- c(2*pnorm(-obs,0,se),pnorm(obs,0,se,lower.tail=FALSE),pnorm(obs,0,se))
  for(k in 1:3) {
    cv <- ch6_curve(0,se,c(-9,9),mains[k],'Rozdíl průměrů (s)',ylim=c(0,.25))
    if(k==1) { ch6_area(-9,-obs,0,se,ch6_orange); ch6_area(obs,9,0,se,ch6_orange) }
    if(k==2) ch6_area(obs,9,0,se,ch6_orange)
    if(k==3) ch6_area(-9,obs,0,se,ch6_orange)
    lines(cv$x,cv$y,lwd=2,col=ch6_blue); segments(obs,0,obs,.19,lty=2,lwd=1.5,col=ch6_ink)
    text(obs,.205,'pozorováno 4 s',cex=.86)
    text(-8.8,.235,paste0('vybarveno: ',ch6_num(probs[k])),adj=0,cex=.92,col=ch6_orange)
  }
},width=10.4,height=3.9)
ch6_draw('p-hodnota', {
  par(mar=c(4.6,4.7,2.7,.8))
  se <- ch6_se_diff
  cv <- ch6_curve(0,se,c(-11.5,11.5),'Rozdělení rozdílu průměrů, kdyby se populační průměry nelišily','Rozdíl průměrů (s)',ylim=c(0,.235))
  ch6_area(-11.5,-ch6_crit,0,se,ch6_sand); ch6_area(ch6_crit,11.5,0,se,ch6_sand)
  ch6_area(-11.5,-ch6_diff,0,se,ch6_orange); ch6_area(ch6_diff,11.5,0,se,ch6_orange)
  lines(cv$x,cv$y,lwd=2.2,col=ch6_blue)
  segments(c(-ch6_crit,ch6_crit),0,c(-ch6_crit,ch6_crit),.125,lty=2,col=ch6_gray)
  text(c(-ch6_crit,ch6_crit),.14,c('−4,16 s','4,16 s'),cex=.84,col=ch6_gray)
  text(c(-5.2,5.2),.092,c('kritický obor:\nvlevo 2,5 %','kritický obor:\nvpravo 2,5 %'),adj=c(1,.5),cex=.8,col=ch6_gray,pos=c(2,4),offset=0)
  arrows(c(-ch6_diff,ch6_diff),.03,c(-ch6_diff,ch6_diff),.004,length=.07,lwd=1.6,col=ch6_orange)
  text(ch6_diff+.3,.045,'pozorovaný\nrozdíl 6,88 s',adj=c(0,.5),cex=.82,col=ch6_orange)
  text(-ch6_diff-.3,.045,'stejně velký rozdíl\nopačným směrem',adj=c(1,.5),cex=.82,col=ch6_orange)
  text(0,.222,'p-hodnota = plocha za oběma šipkami dohromady, přibližně 0,001',cex=.86,col=ch6_orange)
},width=8.6,height=4.6)
ch6_draw('sila', {
  par(mfrow=c(2,2),mar=c(4.3,4.5,3,.6),oma=c(1.7,0,0,0),mgp=c(2.6,.6,0),cex=.8)
  se <- ch6_se_diff
  for(d in c(0,3,5,8)) {
    cv <- ch6_curve(d,se,c(-9,15),if(d==0) 'Skutečný rozdíl 0 s: platí nulová hypotéza' else paste0('Skutečný rozdíl ',d,' s'),'Rozdíl výběrových průměrů (s)',ylim=c(0,.25))
    ch6_area(-9,-ch6_crit,d,se,ch6_orange); ch6_area(ch6_crit,15,d,se,ch6_orange)
    lines(cv$x,cv$y,lwd=2,col=ch6_blue); abline(v=c(-ch6_crit,ch6_crit),lty=2,lwd=1.4,col=ch6_ink)
    text(14.8,.228,paste0('pravděpodobnost\nzamítnutí ',ch6_num(ch6_power(d),2)),adj=1,cex=.9,col=ch6_orange)
  }
  mtext('Oboustranný test, α = 0,05; kritické hodnoty −4,16 s a 4,16 s (přerušovaně) jsou ve všech panelech stejné',1,line=.4,outer=TRUE,cex=.78)
},width=10,height=6.9)
ch6_draw('stejny-rozdil', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.9,.8))
  for(n in c(25,2500)) {
    se <- 10/sqrt(n)
    cv <- ch6_curve(50,se,c(44,56),paste0('Výběr ',format(n,big.mark=' '),' studentů'),'Průměr výběru (body)')
    ch6_area(44,49,50,se,ch6_orange); ch6_area(51,56,50,se,ch6_orange)
    lines(cv$x,cv$y,lwd=2.2,col=ch6_blue); segments(51,0,51,max(cv$y)*.86,lty=2,lwd=1.5,col=ch6_ink)
    text(51,max(cv$y)*.93,'pozorováno 51',cex=.82)
    text(55.8,max(cv$y)*1.11,paste0('směrodatná chyba ',format(se),' bodu\np-hodnota ',if(n==25) ch6_num(2*pnorm(-1/se),2) else 'menší než 0,001'),adj=1,cex=.84)
  }
},width=10,height=4.3)
ch6_draw('dva-testy', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.9,.8))
  k <- 0:20; p <- dbinom(k,20,.25)
  plot(k,p,type='h',lwd=8,lend=1,col=ifelse(k>=10,ch6_orange,ifelse(k==9,'#E3A77E',ch6_mute)),xlim=c(0,20),ylim=c(0,.23),xlab='Počet správných odpovědí z 20',ylab='Pravděpodobnost při tipování',main='Binomický test',bty='l',yaxs='i')
  legend('topright',c('10 a více: p-hodnota 0,014','9: patří do kritického oboru','8 a méně'),fill=c(ch6_orange,'#E3A77E',ch6_mute),bty='n',cex=.82)
  cv <- ch6_curve(50,2,c(42,58),'z-test průměru','Průměr 25 studentů (body)',ylim=c(0,.24))
  ch6_area(42,46,50,2,ch6_orange); lines(cv$x,cv$y,lwd=2.2,col=ch6_blue)
  abline(v=qnorm(.05,50,2),lty=2,lwd=1.5,col=ch6_ink)
  text(42.2,.07,'46 a méně:\np-hodnota 0,023',adj=0,cex=.82,col=ch6_orange)
  text(qnorm(.05,50,2)+.25,.225,'kritická hodnota 46,7',adj=0,cex=.82)
},width=10,height=4.3)
options(ch6_old_options)
