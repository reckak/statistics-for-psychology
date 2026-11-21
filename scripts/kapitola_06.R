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
# Data and descriptions of the figures for the AI tutor (tmp/tutor-figures/kapitola_06/); see scripts/tutor/figure-data.R.
source('scripts/tutor/figure-data.R',encoding='UTF-8')
ch6_fig <- function(...) tf_figure('kapitola_06',...)
# Histogram bins with the breaks of ch6_hist(), limited to the plotted range of the x axis (xlim plus the 4 % margin).
ch6_fig_bins <- function(v,by,xlim,scale='podil') {
  b <- tf_bins(v,seq(floor(min(v,xlim[1])/by)*by,ceiling(max(v,xlim[2])/by)*by,by=by),scale); pad <- .04*diff(xlim)
  b[b$od<xlim[2]+pad&b$do>xlim[1]-pad,]
}
# Upper limit of the y axis that ch6_curve() chooses when ylim is not given.
ch6_fig_ymax <- function(mean,sd,xlim) round(max(dnorm(seq(xlim[1],xlim[2],length.out=500),mean,sd))*1.2,3)
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
# Probability that the two-sided p-value is at most c; it equals the power of the test at level c.
ch6_p_le <- function(c,d,se=ch6_se_diff) { z <- qnorm(1-c/2); pnorm(-z*se,d,se)+pnorm(z*se,d,se,lower.tail=FALSE) }
# Probabilities of p-value bands (lower bound excluded, upper included) for a true difference d.
ch6_p_bands <- function(d,se=ch6_se_diff,cuts=c(0,.001,.01,.04,.05,1)) diff(vapply(cuts,function(c) ch6_p_le(c,d,se),numeric(1)))
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
tf_schema('kapitola_06','tri-vrstvy')
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
ch6_fig('podil-rozdeleni','sloupce',note='Dva panely vedle sebe se stejnými osami. Úzké modré svislé sloupce, oranžová přerušovaná čára v π = 0,25; vpravo nahoře je v každém panelu popisek se směrodatnou chybou podílu. Sloupce za pravým okrajem osy (podíly nad 0,6, pravděpodobnost prakticky nulová) nejsou uvedeny.',panels=lapply(c(20,80),function(n) { k <- 0:n; k <- k[k/n<=.624]
  tf_panel(paste0('Test s ',n,' otázkami'),'sloupcový graf','Podíl správných odpovědí ve výběru','Pravděpodobnost',xlim=c(0,.6),ylim=c(0,.22),guides=list(tf_guide('x',.25,'π = 0,25')),
    note=paste0('Popisek: směrodatná chyba podílu ',ch6_num(sqrt(.25*.75/n)),'. Pravděpodobnosti jsou z binomického rozdělení s n = ',n,' a π = 0,25.'),
    series=list(tf_series('Pravděpodobnosti podílů',data.frame(x=k/n,y=dbinom(k,n,.25),pocet_spravnych=k),'sloupce',digits=4))) }))
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
ch6_fig('devet-vyberu','sloupce',note='Dva panely vedle sebe. Vlevo mřížka 3 × 3: řádky jsou první vylosovaná doba (shora 20, 35 a 50 s), sloupce druhá vylosovaná doba (zleva 20, 35 a 50 s). V každém poli je dvojice dob a tučně její průměr; tři pole s průměrem 35 (úhlopříčka z pravého horního do levého dolního rohu) jsou světle modrá. Vpravo modré sloupce, nad nimi pravděpodobnosti 1/9 až 3/9.',panels=list(
  tf_panel('Devět stejně pravděpodobných výběrů','tabulka',
    series=list(tf_series('Pole mřížky po řádcích',data.frame(prvni_doba=ch6_pairs$prvni,druha_doba=ch6_pairs$druha,prumer=ch6_pairs$prumer,zvyrazneno=ifelse(ch6_pairs$prumer==35,'ano','ne')),'tabulka'))),
  tf_panel('Výběrové rozdělení průměru','sloupcový graf','Průměr dvou dob (s)','Pravděpodobnost',xlim=c(15,55),ylim=c(0,.4),
    series=list(tf_series('Pravděpodobnosti průměrů',data.frame(x=ch6_exact$prumer,y=ch6_exact$p,popisek=c('1/9','2/9','3/9','2/9','1/9')),'sloupce',digits=4)))))
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
ch6_fig('tri-urovne','simulace',note='Tři panely pod sebou se společnou vodorovnou osou 0–100 s. Nahoře modrá křivka hustoty se světle šedou plochou pod ní a oranžovou přerušovanou úsečkou v populačním průměru; uprostřed 30 světle modrých bodů a oranžový trojúhelník v průměru výběru; dole modrý histogram. Popisky vpravo: „jedna hodnota na ose = doba jednoho řidiče“, „jeden bod = jeden řidič“, „jedna hodnota na ose = průměr jednoho celého výběru“.',panels=list(
  tf_panel('Populace ve výukovém modelu','čárový graf','Doba v sekundách','Hustota',xlim=c(0,100),ylim=c(0,.034),guides=list(tf_guide('x',ch6_mu,'populační průměr 35 s')),
    series=list(tf_curve(paste0('Hustota populace: rozdělení gama s průměrem 35 s a směrodatnou odchylkou 15 s (tvar ',ch6_num(ch6_shape,2),', měřítko ',ch6_num(ch6_scale,2),')'),ch6_dpop,0,100,81))),
  tf_panel('Jeden výběr: 30 řidičů','bodový graf','Doba v sekundách','Bez měřítka (svislá poloha bodů nemá význam)',xlim=c(0,100),ylim=c(0,1),
    series=list(tf_series('Doby 30 řidičů',data.frame(x=ch6_one_sample,y=.56+((seq_along(ch6_one_sample)*7)%%11-5)/26),note='Svislá poloha jen rozmísťuje body, aby se nepřekrývaly.'),
      tf_series('Průměr výběru (oranžový trojúhelník)',data.frame(x=mean(ch6_one_sample),y=.1,popisek=paste0('průměr tohoto výběru ',ch6_num(mean(ch6_one_sample),1),' s'))))),
  tf_panel('Výběrové rozdělení průměru: 10 000 výběrů po 30 řidičích','histogram','Doba v sekundách','Podíl výběrů',xlim=c(0,100),ylim=c(0,.17),
    series=list(tf_series('Průměry 10 000 výběrů',ch6_fig_bins(ch6_means[,'n30'],1,c(0,100)),'histogram',digits=4)))))
ch6_draw('prumery-simulace', {
  par(mfrow=c(3,1),mar=c(2.3,5,2.4,.8),cex=.82)
  for(j in 2:4) {
    n <- ch6_sizes[j]; if(j==4) par(mar=c(4.4,5,2.4,.8))
    ch6_hist(ch6_means[,j],1,c(10,65),paste0('Průměry 10 000 výběrů po ',n,' řidičích'),xlab=if(j==4) 'Průměr výběru (s)' else '',ylim=c(0,.3))
    abline(v=ch6_mu,lty=2,lwd=1.5,col=ch6_orange)
    text(64.5,.22,paste0('průměr těchto průměrů ',ch6_num(mean(ch6_means[,j]),2),' s\njejich směrodatná odchylka ',ch6_num(sd(ch6_means[,j]),2),' s'),adj=1,cex=.92)
  }
},width=8.6,height=7.2)
ch6_fig('prumery-simulace','simulace',note='Tři panely pod sebou se společnou vodorovnou osou 10–65 s; modré histogramy, oranžová přerušovaná čára v populačním průměru 35 s. Vpravo nahoře je v každém panelu popisek s průměrem a směrodatnou odchylkou simulovaných průměrů.',panels=lapply(2:4,function(j)
  tf_panel(paste0('Průměry 10 000 výběrů po ',ch6_sizes[j],' řidičích'),'histogram','Průměr výběru (s)','Podíl výběrů',xlim=c(10,65),ylim=c(0,.3),guides=list(tf_guide('x',ch6_mu,'populační průměr 35 s')),
    note=paste0('Popisek: průměr těchto průměrů ',ch6_num(mean(ch6_means[,j]),2),' s, jejich směrodatná odchylka ',ch6_num(sd(ch6_means[,j]),2),' s.'),
    series=list(tf_series('Průměry 10 000 výběrů',ch6_fig_bins(ch6_means[,j],1,c(10,65)),'histogram',digits=4)))))
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
ch6_fig('smerodatna-chyba','krivka',note='Dva panely vedle sebe. Vlevo šedá křivka se světle šedou plochou pod ní (doby jednotlivých řidičů) a modrá úzká křivka (průměry sta řidičů) s popisky „jednotliví řidiči: směrodatná odchylka 15 s“ a „průměry sta řidičů: směrodatná chyba 1,5 s“. Vpravo modrá klesající křivka se třemi oranžovými body a jejich popisky.',panels=list(
  tf_panel('Řidiči a průměry sta řidičů','čárový graf','Doba (s)','Hustota',xlim=c(0,90),ylim=c(0,.29),
    series=list(tf_curve(paste0('Jednotliví řidiči: rozdělení gama s průměrem 35 s a směrodatnou odchylkou 15 s (tvar ',ch6_num(ch6_shape,2),', měřítko ',ch6_num(ch6_scale,2),')'),ch6_dpop,0,90,61),
      tf_curve('Průměry sta řidičů: normální rozdělení s průměrem 35 s a směrodatnou chybou 1,5 s',function(x) dnorm(x,ch6_mu,ch6_se(100)),29,41,49,note='Mimo rozsah 29–41 s je hustota prakticky nulová.'))),
  tf_panel('Čtyřnásobný výběr, poloviční chyba','čárový graf','Velikost výběru n','Směrodatná chyba průměru (s)',xlim=c(1,400),ylim=c(0,15.5),
    series=list(local({ n <- c(1:20,seq(25,100,5),seq(120,400,20)); tf_series('Směrodatná chyba průměru 15/√n',data.frame(x=n,y=ch6_se(n)),'cara',digits=3,note='Křivka je vykreslena pro n = 1 až 400; uvedena jsou vybraná n.') }),
      tf_series('Zvýrazněné velikosti výběru',data.frame(x=c(25,100,400),y=ch6_se(c(25,100,400)),popisek=c('n = 25: 3,0 s','n = 100: 1,5 s','n = 400: 0,75 s')))))))
ch6_draw('trychtyr', {
  par(mar=c(4.6,4.7,2.7,.8))
  plot(NA,xlim=c(0,410),ylim=c(41,59),xlab='Počet lidí ve skupině',ylab='Průměr skupiny (body)',main='150 simulovaných skupin z jediné populace s průměrem 50 bodů',bty='l',xaxs='i')
  n <- seq(8,410,length.out=300)
  lines(n,50+2*10/sqrt(n),lty=2,col=ch6_gray); lines(n,50-2*10/sqrt(n),lty=2,col=ch6_gray); abline(h=50,col=ch6_gray)
  points(ch6_group_n[!ch6_group_extreme],ch6_group_m[!ch6_group_extreme],pch=21,bg=ch6_fill,col=ch6_ink,cex=1.1)
  points(ch6_group_n[ch6_group_extreme],ch6_group_m[ch6_group_extreme],pch=21,bg=ch6_orange,col=ch6_ink,cex=1.3)
  legend('topright',c('20 skupin s průměrem nejdále od 50','ostatní skupiny','50 ± 2 směrodatné chyby'),pch=c(21,21,NA),pt.bg=c(ch6_orange,ch6_fill,NA),lty=c(NA,NA,2),col=c(ch6_ink,ch6_ink,ch6_gray),bty='n',cex=.84)
},width=8.6,height=4.8)
ch6_fig('trychtyr','simulace',note='Každý bod je jedna skupina. Dvacet skupin s průměrem nejdále od 50 je oranžových, ostatní světle modré. Plná šedá vodorovná čára leží v 50 bodech, dvě přerušované šedé křivky vyznačují 50 ± 2 směrodatné chyby. Legenda vpravo nahoře: „20 skupin s průměrem nejdále od 50“, „ostatní skupiny“, „50 ± 2 směrodatné chyby“.',panels=list(local({
  n <- exp(seq(log(8),log(410),length.out=41))
  tf_panel('150 simulovaných skupin z jediné populace s průměrem 50 bodů','bodový graf','Počet lidí ve skupině','Průměr skupiny (body)',xlim=c(0,410),ylim=c(41,59),guides=list(tf_guide('y',50,'populační průměr 50 bodů')),
    series=list(tf_series('Skupiny',data.frame(x=ch6_group_n,y=ch6_group_m,zvyrazneno=ifelse(ch6_group_extreme,'ano','ne'))),
      tf_series('Horní křivka: 50 + 2 · 10/√n',data.frame(x=n,y=50+2*10/sqrt(n)),'cara'),tf_series('Dolní křivka: 50 − 2 · 10/√n',data.frame(x=n,y=50-2*10/sqrt(n)),'cara'))) })))
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
ch6_fig('zvc-clv','simulace',note='Osm panelů ve dvou řadách po čtyřech (n = 2, 5, 30 a 100); v obrázku má každý panel titulek jen „n = …“. Nad horní řadou je nadpis „Průměry v sekundách: rozptýlenost klesá“, nad dolní „Tytéž průměry po standardizaci: tvar se blíží normální křivce (přerušovaně)“. Histogramy jsou modré; v dolní řadě je přes ně oranžová přerušovaná křivka normovaného normálního rozdělení.',panels=c(
  lapply(1:4,function(j) tf_panel(paste0('Průměry v sekundách: n = ',ch6_sizes[j]),'histogram','Průměr výběru (s)','Podíl výběrů',xlim=c(0,90),ylim=c(0,.29),
    series=list(tf_series('Průměry 10 000 výběrů',ch6_fig_bins(ch6_means[,j],1,c(0,90)),'histogram',digits=4)))),
  lapply(1:4,function(j) tf_panel(paste0('Po standardizaci: n = ',ch6_sizes[j]),'histogram','Standardizovaný průměr','Hustota',xlim=c(-4,5),ylim=c(0,.52),
    series=list(tf_series('Standardizované průměry 10 000 výběrů',ch6_fig_bins((ch6_means[,j]-ch6_mu)/ch6_se(ch6_sizes[j]),.25,c(-4,5),'hustota'),'histogram',digits=4),
      tf_curve('Normované normální rozdělení',dnorm,-4,5,41))))))
ch6_draw('clv-qq', {
  par(mfrow=c(1,4),mar=c(4.4,4.2,2.6,.5),mgp=c(2.5,.6,0),cex=.78)
  p <- (1:199)/200
  for(j in 1:4) {
    z <- (ch6_means[,j]-ch6_mu)/ch6_se(ch6_sizes[j])
    plot(qnorm(p),quantile(z,p,names=FALSE),pch=16,cex=.55,col=ch6_blue,xlim=c(-3,3),ylim=c(-3,4.6),xlab='Teoretický normální kvantil',ylab='Kvantil standardizovaných průměrů',main=paste0('n = ',ch6_sizes[j]),bty='l')
    abline(0,1,lty=2,lwd=1.5,col=ch6_orange)
  }
},width=10.4,height=3.6)
ch6_fig('clv-qq','simulace',note='Čtyři panely vedle sebe se stejnými osami; modré body, oranžová přerušovaná přímka y = x. V obrázku je v každém panelu 199 bodů (kvantily úrovní 0,005 až 0,995 po 0,005); zde je kvůli rozsahu uveden každý druhý (úrovně po 0,01).',panels=lapply(1:4,function(j) {
  p <- ((1:199)/200)[seq(1,199,by=2)]; z <- (ch6_means[,j]-ch6_mu)/ch6_se(ch6_sizes[j])
  tf_panel(paste0('n = ',ch6_sizes[j]),'bodový graf','Teoretický normální kvantil','Kvantil standardizovaných průměrů',xlim=c(-3,3),ylim=c(-3,4.6),guides=list(tf_guide('primka',c(0,1),'shoda s normálním rozdělením')),
    series=list(tf_series('Kvantily',data.frame(x=qnorm(p),y=quantile(z,p,names=FALSE),uroven=p),digits=3))) }))
ch6_draw('jine-statistiky', {
  par(mfrow=c(1,3),mar=c(4.5,4.3,2.7,.5),mgp=c(2.5,.6,0),cex=.82)
  ch6_hist(ch6_means[,'n30'],1,c(18,52),'Průměr',xlab='Průměr výběru (s)',ylim=c(0,.2))
  abline(v=ch6_mu,lty=2,lwd=1.5,col=ch6_orange)
  ch6_hist(ch6_medians30,1,c(18,52),'Medián',xlab='Medián výběru (s)',ylim=c(0,.2))
  abline(v=qgamma(.5,shape=ch6_shape,scale=ch6_scale),lty=2,lwd=1.5,col=ch6_orange)
  ch6_hist(ch6_sds30,1,c(4,30),'Směrodatná odchylka',xlab='Směrodatná odchylka výběru (s)',ylim=c(0,.2))
  abline(v=ch6_sigma,lty=2,lwd=1.5,col=ch6_orange)
},width=10,height=3.9)
ch6_fig('jine-statistiky','simulace',note='Tři panely vedle sebe: modré histogramy tří statistik z týchž 10 000 výběrů po 30 řidičích; oranžová přerušovaná čára leží v příslušné hodnotě populace.',panels=local({
  med <- qgamma(.5,shape=ch6_shape,scale=ch6_scale)
  list(tf_panel('Průměr','histogram','Průměr výběru (s)','Podíl výběrů',xlim=c(18,52),ylim=c(0,.2),guides=list(tf_guide('x',ch6_mu,'populační průměr 35 s')),
      series=list(tf_series('Průměry 10 000 výběrů',ch6_fig_bins(ch6_means[,'n30'],1,c(18,52)),'histogram',digits=4))),
    tf_panel('Medián','histogram','Medián výběru (s)','Podíl výběrů',xlim=c(18,52),ylim=c(0,.2),guides=list(tf_guide('x',med,paste0('populační medián ',ch6_num(med,1),' s'))),
      series=list(tf_series('Mediány 10 000 výběrů',ch6_fig_bins(ch6_medians30,1,c(18,52)),'histogram',digits=4))),
    tf_panel('Směrodatná odchylka','histogram','Směrodatná odchylka výběru (s)','Podíl výběrů',xlim=c(4,30),ylim=c(0,.2),guides=list(tf_guide('x',ch6_sigma,'populační směrodatná odchylka 15 s')),
      series=list(tf_series('Směrodatné odchylky 10 000 výběrů',ch6_fig_bins(ch6_sds30,1,c(4,30)),'histogram',digits=4)))) }))
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
ch6_fig('plocha-prumeru','simulace',note='Dva panely vedle sebe. Vlevo modrá normální křivka s oranžově vybarvenou plochou nad 38 s a šedými přerušovanými úsečkami v 35 a 38 s. Vpravo šedomodrý histogram („sloupce: 10 000 simulovaných rozdílů“), modrá křivka („křivka: normální model se směrodatnou chybou 2,12 s“) a oranžově vybarvené chvosty pod −3 s a nad 3 s.',panels=local({
  se <- ch6_se(100); f <- function(x) dnorm(x,ch6_mu,se); g <- function(x) dnorm(x,0,ch6_se_diff)
  list(tf_panel('Průměr sta řidičů ve výukovém modelu','čárový graf','Průměr výběru (s)','Hustota',xlim=c(29,41),ylim=c(0,ch6_fig_ymax(ch6_mu,se,c(29,41))),
      guides=list(tf_guide('x',35,'populační průměr 35 s'),tf_guide('x',38,'38 s')),note=paste0('Popisek u vybarvené plochy: nad 38 s: ',ch6_num(pnorm(38,ch6_mu,se,lower.tail=FALSE)),'.'),
      series=list(tf_curve(paste0('Normální rozdělení s průměrem 35 s a směrodatnou chybou ',ch6_num(se,1),' s'),f,29,41,61),tf_curve('Plocha nad 38 s',f,38,41,16,mark='plocha'))),
    tf_panel('Rozdíl průměrů dvou výběrů po 100 řidičích','histogram','Rozdíl průměrů (s)','Hustota',xlim=c(-9,9),ylim=c(0,.3),
      note=paste0('Popisek u vybarvených chvostů: rozdíl větší než 3 s v kterémkoli směru: ',ch6_num(2*pnorm(-3,0,ch6_se_diff)),'.'),
      series=list(tf_series('10 000 simulovaných rozdílů průměrů',ch6_fig_bins(ch6_diffs,.5,c(-9,9),'hustota'),'histogram',digits=4),
        tf_curve(paste0('Normální model: průměr 0 s, směrodatná chyba ',ch6_num(ch6_se_diff,2),' s'),g,-9,9,61),
        tf_curve('Chvost pod −3 s',g,-9,-3,21,mark='plocha'),tf_curve('Chvost nad 3 s',g,3,9,21,mark='plocha')))) }))
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
ch6_fig('extremnejsi','krivka',note=paste0('Tři panely vedle sebe se stejnou modrou křivkou: normální rozdělení s průměrem 0 s a směrodatnou chybou ',ch6_num(ch6_se_diff,2),' s. Oranžově je vybarvena plocha výsledků stejně extrémních nebo extrémnějších než rozdíl průměrů 4 s, který vyznačuje černá přerušovaná úsečka s popiskem „pozorováno 4 s“. Vlevo nahoře je v každém panelu popisek „vybarveno:“ s velikostí plochy.'),panels=local({
  f <- function(x) dnorm(x,0,ch6_se_diff); probs <- c(2*pnorm(-4,0,ch6_se_diff),pnorm(4,0,ch6_se_diff,lower.tail=FALSE),pnorm(4,0,ch6_se_diff))
  mains <- c('Alternativa: průměry se liší','Alternativa: s čekajícím trvá odjezd déle','Alternativa: s čekajícím trvá odjezd kratší dobu')
  areas <- list(list(tf_curve('Chvost pod −4 s',f,-9,-4,21,mark='plocha'),tf_curve('Chvost nad 4 s',f,4,9,21,mark='plocha')),list(tf_curve('Chvost nad 4 s',f,4,9,21,mark='plocha')),list(tf_curve('Plocha pod 4 s',f,-9,4,53,mark='plocha')))
  lapply(1:3,function(k) tf_panel(mains[k],'čárový graf','Rozdíl průměrů (s)','Hustota',xlim=c(-9,9),ylim=c(0,.25),guides=list(tf_guide('x',4,'pozorováno 4 s')),
    note=paste0('Popisek: vybarveno: ',ch6_num(probs[k]),'.'),series=c(list(tf_curve('Rozdělení rozdílu průměrů za platnosti nulové hypotézy',f,-9,9,61)),areas[[k]]))) }))
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
  text(0,.222,expression(italic(p)*'-hodnota = plocha za oběma šipkami dohromady, přibližně 0,001'),cex=.86,col=ch6_orange)
},width=8.6,height=4.6)
ch6_fig('p-hodnota','krivka',note='Modrá normální křivka se středem v nule. Světle oranžově jsou vybarveny chvosty za kritickými hodnotami (šedé přerušované úsečky) s popisky „kritický obor: vlevo 2,5 %“ a „kritický obor: vpravo 2,5 %“. Dvě oranžové šipky míří shora na vodorovnou osu v pozorovaném rozdílu a ve stejně velkém rozdílu opačným směrem; sytě oranžová plocha za nimi je sotva viditelná.',panels=list(local({
  f <- function(x) dnorm(x,0,ch6_se_diff)
  tf_panel('Rozdělení rozdílu průměrů, kdyby se populační průměry nelišily','čárový graf','Rozdíl průměrů (s)','Hustota',xlim=c(-11.5,11.5),ylim=c(0,.235),
    guides=list(tf_guide('x',-ch6_crit,paste0('kritická hodnota −',ch6_num(ch6_crit,2),' s')),tf_guide('x',ch6_crit,paste0('kritická hodnota ',ch6_num(ch6_crit,2),' s'))),
    note=paste0('Popisek nahoře: p-hodnota = plocha za oběma šipkami dohromady, přibližně ',ch6_num(2*pnorm(-ch6_diff,0,ch6_se_diff)),'.'),
    series=list(tf_curve(paste0('Normální rozdělení s průměrem 0 s a směrodatnou chybou ',ch6_num(ch6_se_diff,2),' s'),f,-11.5,11.5,81),
      tf_curve('Kritický obor vlevo (2,5 %)',f,-11.5,-ch6_crit,21,mark='plocha'),tf_curve('Kritický obor vpravo (2,5 %)',f,ch6_crit,11.5,21,mark='plocha'),
      tf_curve('Plocha za stejně velkým rozdílem opačným směrem',f,-11.5,-ch6_diff,11,mark='plocha'),tf_curve('Plocha za pozorovaným rozdílem',f,ch6_diff,11.5,11,mark='plocha'),
      tf_series('Šipky',data.frame(x0=c(-ch6_diff,ch6_diff),y0=.03,x1=c(-ch6_diff,ch6_diff),y1=.004,popisek=c('stejně velký rozdíl opačným směrem',paste0('pozorovaný rozdíl ',ch6_num(ch6_diff,2),' s'))),'usecky',digits=3))) })))
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
ch6_fig('sila','krivka',note=paste0('Čtyři panely ve dvou řadách po dvou se stejnými osami. Modrá křivka je normální rozdělení se středem ve skutečném rozdílu a se směrodatnou chybou ',ch6_num(ch6_se_diff,2),' s. Oranžově je vybarvena plocha za kritickými hodnotami (černé svislé přerušované čáry); její velikost uvádí popisek vpravo nahoře. Pod panely je text „Oboustranný test, α = 0,05; kritické hodnoty −',ch6_num(ch6_crit,2),' s a ',ch6_num(ch6_crit,2),' s (přerušovaně) jsou ve všech panelech stejné“.'),panels=lapply(c(0,3,5,8),function(d) {
  f <- function(x) dnorm(x,d,ch6_se_diff)
  tf_panel(if(d==0) 'Skutečný rozdíl 0 s: platí nulová hypotéza' else paste0('Skutečný rozdíl ',d,' s'),'čárový graf','Rozdíl výběrových průměrů (s)','Hustota',xlim=c(-9,15),ylim=c(0,.25),
    guides=list(tf_guide('x',-ch6_crit,paste0('kritická hodnota −',ch6_num(ch6_crit,2),' s')),tf_guide('x',ch6_crit,paste0('kritická hodnota ',ch6_num(ch6_crit,2),' s'))),
    note=paste0('Popisek: pravděpodobnost zamítnutí ',ch6_num(ch6_power(d),2),'.'),
    series=list(tf_curve(paste0('Normální rozdělení s průměrem ',d,' s'),f,-9,15,49),tf_curve('Plocha pod dolní kritickou hodnotou',f,-9,-ch6_crit,11,mark='plocha'),tf_curve('Plocha nad horní kritickou hodnotou',f,ch6_crit,15,23,mark='plocha'))) }))
ch6_draw('rozdeleni-p', {
  par(mfrow=c(2,2),mar=c(4.3,4.5,3,.6),oma=c(1.7,0,0,0),mgp=c(2.6,.6,0),cex=.8)
  cuts <- seq(0,1,.05)
  for(d in c(0,3,5,8)) {
    pr <- diff(vapply(cuts,function(c) ch6_p_le(c,d),numeric(1)))
    plot(NA,xlim=c(0,1),ylim=c(0,1),xaxs='i',yaxs='i',bty='l',xlab=expression(italic(p)*'-hodnota jedné studie'),ylab='Pravděpodobnost',
      main=if(d==0) 'Skutečný rozdíl 0 s: platí nulová hypotéza' else paste0('Skutečný rozdíl ',d,' s'),font.main=1,cex.main=1)
    rect(head(cuts,-1),0,cuts[-1],pr,col=c(ch6_orange,rep(ch6_fill,19)),border=c(ch6_orange,rep(ch6_blue,19)),lwd=.6)
    abline(h=.05,lty=2,lwd=1.3,col=ch6_ink)
    text(.07,min(pr[1]+.06,.93),bquote(italic(p)*.(paste0(' ≤ 0,05: ',ch6_num(pr[1],3),if(d==0) ' (α)' else ' (síla)'))),adj=0,cex=.9,col=ch6_orange)
  }
  mtext('Sto řidičů v každé skupině, oboustranný test. Sloupce po 0,05; přerušovaná čára 0,05 = rovnoměrné rozdělení za platnosti nulové hypotézy',1,line=.4,outer=TRUE,cex=.78)
},width=10,height=6.9)
ch6_fig('rozdeleni-p','sloupce',note='Čtyři panely ve dvou řadách po dvou se stejnými osami. Dvacet sloupců po 0,05; výška sloupce je pravděpodobnost, že p-hodnota jedné studie padne do daného intervalu. První sloupec (p-hodnota nejvýše 0,05) je oranžový a má popisek své výšky, ostatní jsou světle modré; černá přerušovaná vodorovná čára leží ve výši 0,05. Pod panely je text „Sto řidičů v každé skupině, oboustranný test. Sloupce po 0,05; přerušovaná čára 0,05 = rovnoměrné rozdělení za platnosti nulové hypotézy“.',panels=lapply(c(0,3,5,8),function(d) {
  cuts <- seq(0,1,.05); pr <- diff(vapply(cuts,function(c) ch6_p_le(c,d),numeric(1)))
  tf_panel(if(d==0) 'Skutečný rozdíl 0 s: platí nulová hypotéza' else paste0('Skutečný rozdíl ',d,' s'),'histogram','p-hodnota jedné studie','Pravděpodobnost',xlim=c(0,1),ylim=c(0,1),
    guides=list(tf_guide('y',.05,'0,05: rovnoměrné rozdělení za platnosti nulové hypotézy')),note=paste0('Popisek prvního sloupce: p ≤ 0,05: ',ch6_num(pr[1],3),if(d==0) ' (α)' else ' (síla)','.'),
    series=list(tf_series('Pravděpodobnosti intervalů p-hodnoty',data.frame(od=head(cuts,-1),do=cuts[-1],podil=pr,zvyrazneno=c('ano',rep('ne',19))),'histogram',digits=4,note='Pole „podil“ je pravděpodobnost intervalu.'))) }))
ch6_draw('stejny-rozdil', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.9,.8))
  for(n in c(25,2500)) {
    se <- 10/sqrt(n)
    cv <- ch6_curve(50,se,c(44,56),paste0('Výběr ',format(n,big.mark=' '),' studentů'),'Průměr výběru (body)')
    ch6_area(44,49,50,se,ch6_orange); ch6_area(51,56,50,se,ch6_orange)
    lines(cv$x,cv$y,lwd=2.2,col=ch6_blue); segments(51,0,51,max(cv$y)*1.04,lty=2,lwd=1.5,col=ch6_ink)
    text(51.15,max(cv$y)*1.06,'pozorováno 51',adj=c(0,0),cex=.82)
    text(44.2,max(cv$y)*1.145,paste0('směrodatná chyba ',format(se),' bodu'),adj=0,cex=.84)
    text(44.2,max(cv$y)*1.075,bquote(italic(p)*.(paste0('-hodnota ',if(n==25) ch6_num(2*pnorm(-1/se),2) else 'menší než 0,001'))),adj=0,cex=.84)
  }
},width=10,height=4.3)
ch6_fig('stejny-rozdil','krivka',note='Dva panely vedle sebe se stejnou vodorovnou osou; svislé osy mají různý rozsah. Modrá křivka je normální rozdělení s průměrem 50 bodů a směrodatnou chybou 10/√n. Oranžově jsou vybarveny chvosty pod 49 a nad 51 bodů; černá přerušovaná úsečka s popiskem „pozorováno 51“ leží v 51 bodech. Vlevo nahoře jsou popisky se směrodatnou chybou a p-hodnotou.',panels=lapply(c(25,2500),function(n) {
  se <- 10/sqrt(n); f <- function(x) dnorm(x,50,se); big <- n==2500
  tf_panel(paste0('Výběr ',format(n,big.mark=' '),' studentů'),'čárový graf','Průměr výběru (body)','Hustota',xlim=c(44,56),ylim=c(0,ch6_fig_ymax(50,se,c(44,56))),guides=list(tf_guide('x',51,'pozorováno 51')),
    note=paste0('Popisky: směrodatná chyba ',ch6_num(se,if(big) 1 else 0),' bodu; p-hodnota ',if(big) 'menší než 0,001. Vybarvené chvosty pod 49 a nad 51 bodů mají dohromady plochu menší než 0,001, nejsou vidět a nejsou uvedeny.' else paste0(ch6_num(2*pnorm(-1/se),2),'.')),
    series=if(big) list(tf_curve(paste0('Normální rozdělení s průměrem 50 bodů a směrodatnou chybou ',ch6_num(se,1),' bodu'),f,49,51,41,note='Mimo rozsah 49–51 bodů je hustota prakticky nulová.'))
      else list(tf_curve(paste0('Normální rozdělení s průměrem 50 bodů a směrodatnou chybou ',ch6_num(se,0),' body'),f,44,56,61),tf_curve('Chvost pod 49 bodů',f,44,49,21,mark='plocha'),tf_curve('Chvost nad 51 bodů',f,51,56,21,mark='plocha'))) }))
ch6_draw('dva-testy', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.9,.8))
  k <- 0:20; p <- dbinom(k,20,.25)
  plot(k,p,type='h',lwd=8,lend=1,col=ifelse(k>=10,ch6_orange,ifelse(k==9,'#E3A77E',ch6_mute)),xlim=c(0,20),ylim=c(0,.23),xlab='Počet správných odpovědí z 20',ylab='Pravděpodobnost při tipování',main='Binomický test',bty='l',yaxs='i')
  legend('topright',c(expression('10 a více: '*italic(p)*'-hodnota 0,014'),'9: patří do kritického oboru','8 a méně'),fill=c(ch6_orange,'#E3A77E',ch6_mute),bty='n',cex=.82)
  cv <- ch6_curve(50,2,c(42,58),expression(bolditalic(z)*bold('-test průměru')),'Průměr 25 studentů (body)',ylim=c(0,.24))
  ch6_area(42,46,50,2,ch6_orange); lines(cv$x,cv$y,lwd=2.2,col=ch6_blue)
  abline(v=qnorm(.05,50,2),lty=2,lwd=1.5,col=ch6_ink)
  text(42.2,.091,'46 a méně:',adj=0,cex=.82,col=ch6_orange)
  text(42.2,.077,expression(italic(p)*'-hodnota'),adj=0,cex=.82,col=ch6_orange)
  text(42.2,.063,'0,023',adj=0,cex=.82,col=ch6_orange)
  text(qnorm(.05,50,2)+.25,.225,'kritická hodnota 46,7',adj=0,cex=.82)
},width=10,height=4.3)
ch6_fig('dva-testy','sloupce',note='Dva panely vedle sebe. Vlevo sloupce binomického rozdělení (n = 20, π = 0,25) ve třech barvách podle legendy: oranžová „10 a více: p-hodnota 0,014“, světle oranžová „9: patří do kritického oboru“, šedá „8 a méně“. Vpravo modrá normální křivka s oranžově vybarvenou plochou pod 46 body a černou svislou přerušovanou čarou v kritické hodnotě.',panels=list(
  local({ k <- 0:20
    tf_panel('Binomický test','sloupcový graf','Počet správných odpovědí z 20','Pravděpodobnost při tipování',xlim=c(0,20),ylim=c(0,.23),
      note=paste0('Úrovně zvýraznění: „10 a více“ (oranžově) jsou výsledky, jejichž pravděpodobnosti dávají p-hodnotu ',ch6_num(pbinom(9,20,.25,lower.tail=FALSE)),'; „9“ (světle oranžově) patří spolu s nimi do kritického oboru; „ne“ (šedě) je 8 a méně.'),
      series=list(tf_series('Pravděpodobnosti počtu správných odpovědí',data.frame(x=k,y=dbinom(k,20,.25),zvyrazneno=ifelse(k>=10,'10 a více',ifelse(k==9,'9','ne'))),'sloupce',digits=4))) }),
  tf_panel('z-test průměru','čárový graf','Průměr 25 studentů (body)','Hustota',xlim=c(42,58),ylim=c(0,.24),guides=list(tf_guide('x',qnorm(.05,50,2),paste0('kritická hodnota ',ch6_num(qnorm(.05,50,2),1)))),
    note=paste0('Popisek u vybarvené plochy: 46 a méně: p-hodnota ',ch6_num(pnorm(46,50,2)),'.'),
    series=list(tf_curve('Normální rozdělení s průměrem 50 bodů a směrodatnou chybou 2 body',function(x) dnorm(x,50,2),42,58,65),tf_curve('Plocha pod 46 body',function(x) dnorm(x,50,2),42,46,17,mark='plocha')))))
options(ch6_old_options)
