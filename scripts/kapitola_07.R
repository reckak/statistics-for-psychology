# Teaching model, simulations and figures for chapter 7; base R, UTF-8, deterministic project-root paths.
# PDI summaries are quoted from Howell (2013, pp. 186-189). Every other value is an authored teaching model.
ch7_out <- 'assets/chapter-07/plots'
ch7_old_options <- options(OutDec=',')
dir.create(ch7_out,recursive=TRUE,showWarnings=FALSE)
ch7_blue <- '#245D78'; ch7_orange <- '#B54E24'; ch7_fill <- '#B8DDE8'; ch7_gray <- '#4D5A63'; ch7_pale <- '#E1E8EB'; ch7_sand <- '#FAECDD'; ch7_ink <- '#223744'; ch7_mute <- '#A9BAC3'; ch7_green <- '#3E7B4F'
ch7_num <- function(x,digits=2) formatC(x,format='f',digits=digits,decimal.mark=',')
ch7_draw <- function(name,code,width=8,height=4.5) {
  svg(file.path(ch7_out,paste0(name,'.svg')),width=width,height=height,family='sans',bg='white')
  par(mar=c(4.5,4.5,2.6,.8),mgp=c(2.7,.7,0),las=1,col.axis=ch7_ink,col.lab=ch7_ink,fg=ch7_ink,cex=.9)
  force(code); dev.off()
}
# Interval and tests for one mean from summaries ------------------------------------
# Known sigma uses the normal quantile; unknown sigma the t quantile with n - 1 degrees of freedom.
ch7_ci_z <- function(m,sigma,n,level=.95) m+c(-1,1)*qnorm(1-(1-level)/2)*sigma/sqrt(n)
ch7_ci_t <- function(m,s,n,level=.95) m+c(-1,1)*qt(1-(1-level)/2,n-1)*s/sqrt(n)
ch7_t <- function(m,s,n,mu0) (m-mu0)/(s/sqrt(n))
ch7_p2 <- function(m,s,n,mu0) 2*pt(-abs(ch7_t(m,s,n,mu0)),n-1)
# Two one-sided tests against mu0 - delta and mu0 + delta; returns both statistics and p-values.
ch7_tost <- function(m,s,n,mu0,delta) {
  se <- s/sqrt(n); tl <- (m-(mu0-delta))/se; tu <- (m-(mu0+delta))/se
  c(t_dolni=tl,p_dolni=pt(tl,n-1,lower.tail=FALSE),t_horni=tu,p_horni=pt(tu,n-1))
}
# Running example: attention score of 25 students after short sleep; reference value of the norm 50.
# sigma = 10 is a model assumption carried over from chapter 6; s = 10 is the new sample input.
ch7_att <- c(mu0=50,sigma=10,s=10,n=25,m=46)
ch7_ci_att_z <- ch7_ci_z(46,10,25)
ch7_ci_att_t <- ch7_ci_t(46,10,25)
ch7_q24 <- qt(.975,24)
# Howell's PDI example: low-birthweight infants against the norm 100.
ch7_pdi <- c(mu0=100,m=104.125,s=12.584,n=56)
# Equivalence: online version of the attention test against the fixed norm 50, bounds 47 and 53.
ch7_eq <- data.frame(studie=LETTERS[1:5],m=c(46,48.5,50.4,44,47),s=10,n=c(25,400,400,100,100))
ch7_mu0 <- 50; ch7_delta <- 3
ch7_eq$ci95_d <- with(ch7_eq,m-qt(.975,n-1)*s/sqrt(n)); ch7_eq$ci95_h <- with(ch7_eq,m+qt(.975,n-1)*s/sqrt(n))
ch7_eq$ci90_d <- with(ch7_eq,m-qt(.95,n-1)*s/sqrt(n)); ch7_eq$ci90_h <- with(ch7_eq,m+qt(.95,n-1)*s/sqrt(n))
ch7_eq$p_rozdil <- with(ch7_eq,ch7_p2(m,s,n,ch7_mu0))
ch7_eq_tost <- t(mapply(function(m,s,n) ch7_tost(m,s,n,ch7_mu0,ch7_delta),ch7_eq$m,ch7_eq$s,ch7_eq$n))
ch7_eq$p_tost <- pmax(ch7_eq_tost[,'p_dolni'],ch7_eq_tost[,'p_horni'])
# Consequence of a shifted population mean for the share below the referral cut-off 40 (normal model, sigma 10).
ch7_cut <- 40; ch7_share <- pnorm(ch7_cut,c(47,50,53),10)
# Theoretical coverage of the wrong procedure m +- 1.96 s/sqrt(n) for n = 10 under the normal model.
ch7_cov_wrong <- 2*pt(qnorm(.975),9)-1
# Simulations: seeds and the order of draws are fixed --------------------------------
# 100 samples of 25 students from a teaching population with mean 47 and SD 10.
ch7_mu_sim <- 47; ch7_reps <- 100
set.seed(20261017)
ch7_samples <- matrix(rnorm(ch7_reps*25,ch7_mu_sim,10),ch7_reps)
ch7_sim_m <- rowMeans(ch7_samples); ch7_sim_s <- apply(ch7_samples,1,sd)
ch7_sim_z <- cbind(ch7_sim_m-qnorm(.975)*2,ch7_sim_m+qnorm(.975)*2)
ch7_sim_t <- cbind(ch7_sim_m-ch7_q24*ch7_sim_s/5,ch7_sim_m+ch7_q24*ch7_sim_s/5)
ch7_hit_z <- ch7_sim_z[,1]<=ch7_mu_sim & ch7_mu_sim<=ch7_sim_z[,2]
ch7_hit_t <- ch7_sim_t[,1]<=ch7_mu_sim & ch7_mu_sim<=ch7_sim_t[,2]
# Statistic (m - mu)/(s/sqrt(n)) for 10 000 samples of five from a normal population.
set.seed(20261018)
ch7_small <- matrix(rnorm(5*10000,50,10),10000)
ch7_tstat5 <- (rowMeans(ch7_small)-50)/(apply(ch7_small,1,sd)/sqrt(5))
ch7_zstat5 <- (rowMeans(ch7_small)-50)/(10/sqrt(5))
rm(ch7_small)
# Exercise inputs (all authored) -----------------------------------------------------
ch7_u05 <- c(12,15,9,14,11,13,16,10,12,14)
ch7_u07 <- c(18,22,25,19,24,21,27,17,23,20,26,22,19,28,21,24,18,25,23,22)
# Figures ----------------------------------------------------------------------------
ch7_draw('opakovane-intervaly', {
  par(mfrow=c(1,2),mar=c(4.5,3.2,3.4,.6))
  for(k in 1:2) {
    ci <- if(k==1) ch7_sim_z else ch7_sim_t; hit <- if(k==1) ch7_hit_z else ch7_hit_t
    plot(NA,xlim=c(36,58),ylim=c(.5,ch7_reps+.5),yaxt='n',xlab='Populační průměr skóru (body)',ylab='',bty='l',
      main=if(k==1) 'Známá σ = 10: stejná šířka' else 'Výběrová s: šířka kolísá')
    abline(v=ch7_mu_sim,lty=2,lwd=1.6,col=ch7_ink)
    segments(ci[,1],1:ch7_reps,ci[,2],1:ch7_reps,col=ifelse(hit,ch7_blue,ch7_orange),lwd=ifelse(hit,1.5,2.6))
    points(ch7_sim_m,1:ch7_reps,pch=16,cex=.35,col=ifelse(hit,ch7_blue,ch7_orange))
    mtext(paste0('μ zachytilo ',sum(hit),' ze 100 intervalů'),side=3,line=.2,cex=.82,col=ch7_gray)
    mtext('výběr 1 až 100',side=2,line=.8,las=0,cex=.8,col=ch7_gray)
  }
},width=10,height=6.4)
ch7_draw('sirka-intervalu', {
  par(mar=c(4.6,4.7,2.7,.8))
  n <- 4:200; lev <- c(.90,.95,.99); cols <- c(ch7_mute,ch7_blue,ch7_orange)
  plot(NA,xlim=c(0,200),ylim=c(0,26),xlab='Velikost výběru n',ylab='Šířka intervalu (body)',main='Šířka intervalu při známé σ = 10',bty='l',yaxs='i')
  for(j in 1:3) lines(n,2*qnorm(1-(1-lev[j])/2)*10/sqrt(n),lwd=2.2,col=cols[j])
  k <- c(25,100); points(k,2*qnorm(.975)*10/sqrt(k),pch=21,bg=ch7_blue,col=ch7_ink,cex=1.3)
  text(k+3,2*qnorm(.975)*10/sqrt(k)-1.3,paste0('n = ',k,': ',ch7_num(2*qnorm(.975)*10/sqrt(k)),' bodu'),adj=c(0,1),cex=.84,col=ch7_blue)
  legend('topright',c('99% interval','95% interval','90% interval'),lwd=2.2,col=rev(cols),bty='n',cex=.86)
},width=8.6,height=4.4)
ch7_draw('t-rozdeleni', {
  par(mfrow=c(1,2),mar=c(4.6,4.5,3,.6))
  br <- seq(-12,12,by=.25)
  h <- hist(pmax(pmin(ch7_tstat5,11.99),-11.99),breaks=br,plot=FALSE)
  plot(NA,xlim=c(-5,5),ylim=c(0,.56),xlab='Standardizovaný průměr výběru pěti lidí',ylab='Hustota',main='Dosazení s místo σ: těžší chvosty',bty='l',yaxs='i')
  rect(br[-length(br)],0,br[-1],h$density,col=ch7_fill,border='white',lwd=.4)
  curve(dnorm(x),-5,5,add=TRUE,lwd=2,lty=2,col=ch7_orange,n=400)
  curve(dt(x,4),-5,5,add=TRUE,lwd=2,col=ch7_blue,n=400)
  legend('topleft',c('10 000 hodnot (m − μ)/(s/√5)','normované normální','t-rozdělení, 4 stupně volnosti'),fill=c(ch7_fill,NA,NA),border=c('white',NA,NA),lty=c(NA,2,1),lwd=c(NA,2,2),col=c(NA,ch7_orange,ch7_blue),bty='n',cex=.74,ncol=1)
  plot(NA,xlim=c(-4,4),ylim=c(0,.56),xlab='Hodnota statistiky',ylab='Hustota',main='Více stupňů volnosti: blíže normálnímu',bty='l',yaxs='i')
  df <- c(2,5,24); cols <- c(ch7_orange,ch7_mute,ch7_blue)
  for(j in 1:3) curve(dt(x,df[j]),-4,4,add=TRUE,lwd=2,col=cols[j],n=400)
  curve(dnorm(x),-4,4,add=TRUE,lwd=1.8,lty=2,col=ch7_ink,n=400)
  legend('topright',c('2 stupně volnosti','5 stupňů volnosti','24 stupňů volnosti','normované normální'),lty=c(1,1,1,2),lwd=2,col=c(cols,ch7_ink),bty='n',cex=.74)
},width=10,height=4.4)
ch7_draw('p-funkce', {
  par(mar=c(4.6,4.7,2.7,.8))
  mu <- seq(38,54,by=.02); p <- ch7_p2(46,10,25,mu)
  plot(mu,p,type='l',lwd=2.4,col=ch7_blue,ylim=c(0,1.04),xlab=expression('Testovaná hodnota '*mu[0]*' (body)'),ylab='Oboustranná p-hodnota',main='P-hodnota t-testu pro různé testované hodnoty',bty='l',yaxs='i')
  abline(h=.05,lty=2,col=ch7_gray)
  rect(ch7_ci_att_t[1],-.1,ch7_ci_att_t[2],.05,col=adjustcolor(ch7_fill,.8),border=NA)
  lines(mu,p,lwd=2.4,col=ch7_blue)
  segments(ch7_ci_att_t,0,ch7_ci_att_t,.05,lwd=1.6,col=ch7_ink)
  text(46,.025,'95% interval: hodnoty, které test nezamítá',cex=.8,col=ch7_ink)
  points(c(50,48),ch7_p2(46,10,25,c(50,48)),pch=21,bg=ch7_orange,col=ch7_ink,cex=1.3)
  text(50.3,ch7_p2(46,10,25,50)+.06,bquote(mu[0]*' = 50: '*.(ch7_num(ch7_p2(46,10,25,50),3))),adj=0,cex=.82)
  text(48.3,ch7_p2(46,10,25,48)+.05,bquote(mu[0]*' = 48: '*.(ch7_num(ch7_p2(46,10,25,48),2))),adj=0,cex=.82)
  text(53.8,.08,'hladina 0,05',adj=1,cex=.8,col=ch7_gray)
},width=8.6,height=4.6)
ch7_draw('pasmo-pouziti', {
  par(mar=c(4.6,4.7,2.7,.8))
  x <- seq(10,90,length.out=600); mus <- c(47,50,53); cols <- c(ch7_orange,ch7_ink,ch7_blue)
  plot(NA,xlim=c(15,85),ylim=c(0,.05),xlab='Skór pozornosti (body)',ylab='Hustota',main='Posun průměru o 3 body a podíl lidí pod hranicí 40',bty='l',yaxs='i')
  polygon(c(15,x[x<=40],40),c(0,dnorm(x[x<=40],47,10),0),col=adjustcolor(ch7_orange,.25),border=NA)
  for(j in 1:3) lines(x,dnorm(x,mus[j],10),lwd=if(j==2) 2.4 else 1.8,lty=if(j==2) 1 else 2,col=cols[j])
  abline(v=40,lwd=1.6,col=ch7_gray)
  text(39.3,.043,'hranice 40:\ndoporučení další diagnostiky',adj=c(1,1),cex=.8,col=ch7_gray)
  legend(64,.0505,paste0('průměr ',mus,': pod 40 je ',ch7_num(100*ch7_share,1),' %'),lty=c(2,1,2),lwd=c(1.8,2.4,1.8),col=cols,bty='n',cex=.82)
},width=8.6,height=4.4)
ch7_draw('hypotezy-ekvivalence', {
  par(mar=c(3.2,.8,2.6,.8))
  plot(NA,xlim=c(40,60),ylim=c(0,3),axes=FALSE,xlab='',ylab='',main='Hypotézy testu ekvivalence pro populační průměr μ')
  axis(1,at=seq(40,60,by=2),labels=seq(40,60,by=2)); mtext('μ (body)',side=1,line=2.1,cex=.86)
  rect(40,.4,47,1.6,col=ch7_sand,border=NA); rect(53,.4,60,1.6,col=ch7_sand,border=NA); rect(47,.4,53,1.6,col=ch7_fill,border=NA)
  segments(c(47,53),.2,c(47,53),2.2,lwd=1.8,col=ch7_ink); segments(50,.4,50,.58,lty=2,col=ch7_gray)
  text(43.5,1,expression(H[0]*': '*mu<=47),cex=1,col=ch7_orange,font=2); text(56.5,1,expression(H[0]*': '*mu>=53),cex=1,col=ch7_orange,font=2)
  text(50,1.15,expression(H[1]*': 47 < '*mu*' < 53'),cex=1,col=ch7_blue,font=2); text(50,.72,'norma 50',cex=.8,col=ch7_gray)
  text(47,2.5,expression(mu[0]-Delta*' = 47'),cex=.9); text(53,2.5,expression(mu[0]+Delta*' = 53'),cex=.9)
  text(c(43.5,56.5),2.0,c('první jednostranný test','druhý jednostranný test'),cex=.8,col=ch7_gray)
},width=8.6,height=3.4)
ch7_draw('ctyri-kombinace', {
  par(mar=c(4.6,10.5,2.7,.8))
  e <- ch7_eq; y <- 5:1
  lab <- paste0('Studie ',e$studie,' (n = ',e$n,')')
  plot(NA,xlim=c(40,60),ylim=c(.4,5.6),yaxt='n',xlab='Populační průměr skóru online verze (body)',ylab='',main='Intervaly pěti studií vůči pásmu ekvivalence 47–53',bty='l')
  rect(47,0,53,6,col=adjustcolor(ch7_fill,.55),border=NA)
  abline(v=c(47,53),lty=2,lwd=1.5,col=ch7_ink); abline(v=50,lty=3,lwd=1.5,col=ch7_gray)
  axis(2,at=y,labels=lab,tick=FALSE,cex.axis=.9)
  segments(e$ci95_d,y,e$ci95_h,y,lwd=1.4,col=ch7_ink)
  segments(e$ci95_d,y-.08,e$ci95_d,y+.08,lwd=1.4,col=ch7_ink); segments(e$ci95_h,y-.08,e$ci95_h,y+.08,lwd=1.4,col=ch7_ink)
  segments(e$ci90_d,y,e$ci90_h,y,lwd=6,col=ch7_blue,lend=1)
  points(e$m,y,pch=21,bg='white',col=ch7_ink,cex=1.2)
  legend(53.4,5.6,c('95% interval: test rozdílu od 50','90% interval: test ekvivalence','pásmo ekvivalence','norma 50'),lwd=c(1.4,6,NA,1.5),lty=c(1,1,NA,3),col=c(ch7_ink,ch7_blue,NA,ch7_gray),fill=c(NA,NA,adjustcolor(ch7_fill,.55),NA),border=NA,bty='n',cex=.78)
},width=9.4,height=4.8)
options(ch7_old_options)
