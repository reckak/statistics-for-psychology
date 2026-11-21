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
# Data and descriptions of the figures for the AI tutor (tmp/tutor-figures/kapitola_07/); see scripts/tutor/figure-data.R.
source('scripts/tutor/figure-data.R',encoding='UTF-8')
ch7_fig <- function(...) tf_figure('kapitola_07',...)
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
# sigma = 10 is a model assumption carried over from chapter 6; s = 11 is the new sample input.
ch7_att <- c(mu0=50,sigma=10,s=11,n=25,m=46)
ch7_ci_att_z <- ch7_ci_z(46,10,25)
ch7_ci_att_t <- ch7_ci_t(46,11,25)
ch7_ci_att_t90 <- ch7_ci_t(46,11,25,.90)
ch7_q24 <- qt(.975,24)
# Two-sided acceptance region for the sample mean around mu0 = 50 with the same estimated standard error.
ch7_accept <- 50+c(-1,1)*ch7_q24*11/5
# Howell's PDI example: low-birthweight infants against the norm 100.
ch7_pdi <- c(mu0=100,m=104.125,s=12.584,n=56)
# Equivalence: online version of the attention test against the fixed norm 50, bounds 47 and 53.
# F spans all three regions; G, H and I mirror B, D and E above the norm.
ch7_eq <- data.frame(studie=LETTERS[1:9],m=c(46,48.5,50.4,44,47,50,51.5,56,53),s=10,n=c(25,400,400,100,100,16,400,100,100))
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
    plot(NA,xlim=c(36,58),ylim=c(.5,ch7_reps+.5),yaxt='n',xlab='Skór v testu pozornosti (body)',ylab='',bty='l',
      main=if(k==1) 'Známá σ = 10: stejná šířka' else 'Výběrová s: šířka kolísá')
    abline(v=ch7_mu_sim,lty=2,lwd=1.6,col=ch7_ink)
    segments(ci[,1],1:ch7_reps,ci[,2],1:ch7_reps,col=ifelse(hit,ch7_blue,ch7_orange),lwd=ifelse(hit,1.5,2.6))
    points(ch7_sim_m,1:ch7_reps,pch=16,cex=.35,col=ifelse(hit,ch7_blue,ch7_orange))
    mtext(paste0('μ zachytilo ',sum(hit),' ze 100 intervalů'),side=3,line=.2,cex=.82,col=ch7_gray)
    mtext('výběr 1 až 100',side=2,line=.8,las=0,cex=.8,col=ch7_gray)
  }
},width=10,height=6.4)
ch7_fig('opakovane-intervaly','simulace',note='Dva panely vedle sebe pro týchž sto simulovaných výběrů po 25 studentech z populace s průměrem 47 a směrodatnou odchylkou 10; výběr 1 je dole, výběr 100 nahoře. Každý interval je vodorovná úsečka s tečkou ve výběrovém průměru. Intervaly, které μ zachytily, jsou modré; intervaly, které μ minuly, jsou oranžové a silnější (zvyrazneno = ano).',panels=lapply(1:2,function(k) {
  ci <- if(k==1) ch7_sim_z else ch7_sim_t; hit <- if(k==1) ch7_hit_z else ch7_hit_t
  tf_panel(if(k==1) 'Známá σ = 10: stejná šířka' else 'Výběrová s: šířka kolísá','intervalový graf','Skór v testu pozornosti (body)','Výběr 1 až 100',xlim=c(36,58),ylim=c(.5,ch7_reps+.5),
    guides=list(tf_guide('x',ch7_mu_sim,'populační průměr μ = 47')),note=paste0('μ zachytilo ',sum(hit),' ze 100 intervalů.'),
    series=list(tf_series(if(k==1) '95% intervaly se známou σ = 10 (kvantil normovaného normálního rozdělení)' else '95% intervaly s výběrovou s (kvantil t-rozdělení s 24 stupni volnosti)',
      data.frame(poloha=1:ch7_reps,od=ci[,1],do=ci[,2],stred=ch7_sim_m,zvyrazneno=ifelse(hit,'ne','ano')),'interval',direction='vodorovně'))) }))
ch7_draw('sirka-intervalu', {
  par(mar=c(4.6,4.7,2.7,.8))
  n <- 4:200; lev <- c(.90,.95,.99); cols <- c(ch7_mute,ch7_blue,ch7_orange)
  plot(NA,xlim=c(0,200),ylim=c(0,26),xlab='Velikost výběru n',ylab='Šířka intervalu (body)',main='Šířka intervalu při známé σ = 10',bty='l',yaxs='i')
  for(j in 1:3) lines(n,2*qnorm(1-(1-lev[j])/2)*10/sqrt(n),lwd=2.2,col=cols[j])
  k <- c(25,100); points(k,2*qnorm(.975)*10/sqrt(k),pch=21,bg=ch7_blue,col=ch7_ink,cex=1.3)
  text(k,2*qnorm(.975)*10/sqrt(k),paste0('n = ',k,': ',ch7_num(2*qnorm(.975)*10/sqrt(k)),' bodu'),pos=c(1,3),offset=2.1,cex=.84,col=ch7_blue)
  legend('topright',c('99% interval','95% interval','90% interval'),lwd=2.2,col=rev(cols),bty='n',cex=.86)
},width=8.6,height=4.4)
ch7_fig('sirka-intervalu','krivka',note='Tři klesající křivky šířky intervalu 2 · z · σ/√n pro σ = 10: 99% interval oranžově (nejvýše), 95% modře, 90% šedě (nejníže). Na křivce 95% intervalu jsou dva modré body s popisky. Křivky jsou nakresleny pro n od 4 do 200; v datech je výběr hodnot n, hustší u malých výběrů.',panels=list(local({
  n <- c(4:20,seq(22,50,by=2),seq(55,200,by=5)); lev <- c(.99,.95,.90); k <- c(25,100); w <- function(n,l) 2*qnorm(1-(1-l)/2)*10/sqrt(n)
  tf_panel('Šířka intervalu při známé σ = 10','čárový graf','Velikost výběru n','Šířka intervalu (body)',xlim=c(0,200),ylim=c(0,26),
    series=c(lapply(1:3,function(j) tf_series(c('99% interval','95% interval','90% interval')[j],data.frame(x=n,y=w(n,lev[j])),'cara',note=paste0('šířka = 2 · ',ch7_num(qnorm(1-(1-lev[j])/2),3),' · 10/√n'))),
      list(tf_series('Vyznačené body na křivce 95% intervalu',data.frame(x=k,y=w(k,.95),popisek=paste0('n = ',k,': ',ch7_num(w(k,.95)),' bodu')))))) })))
ch7_draw('t-rozdeleni', {
  par(mfrow=c(1,2),mar=c(4.6,4.5,3,.6))
  br <- seq(-12,12,by=.25)
  h <- hist(pmax(pmin(ch7_tstat5,11.99),-11.99),breaks=br,plot=FALSE)
  plot(NA,xlim=c(-5,5),ylim=c(0,.56),xlab='Standardizovaný průměr výběru pěti lidí',ylab='Hustota',main='Dosazení s místo σ: těžší chvosty',bty='l',yaxs='i')
  rect(br[-length(br)],0,br[-1],h$density,col=ch7_fill,border='white',lwd=.4)
  curve(dnorm(x),-5,5,add=TRUE,lwd=2,lty=2,col=ch7_orange,n=400)
  curve(dt(x,4),-5,5,add=TRUE,lwd=2,col=ch7_blue,n=400)
  legend('topleft',c(expression('10 000 hodnot '*(italic(m)-mu)/(italic(s)/sqrt(5))),expression('normované normální'),expression(italic(t)*'-rozdělení, 4 stupně volnosti')),fill=c(ch7_fill,NA,NA),border=c('white',NA,NA),lty=c(NA,2,1),lwd=c(NA,2,2),col=c(NA,ch7_orange,ch7_blue),bty='n',cex=.74,ncol=1)
  plot(NA,xlim=c(-4,4),ylim=c(0,.56),xlab='Hodnota statistiky',ylab='Hustota',main='Více stupňů volnosti: blíže normálnímu',bty='l',yaxs='i')
  df <- c(2,5,24); cols <- c(ch7_orange,ch7_mute,ch7_blue)
  for(j in 1:3) curve(dt(x,df[j]),-4,4,add=TRUE,lwd=2,col=cols[j],n=400)
  curve(dnorm(x),-4,4,add=TRUE,lwd=1.8,lty=2,col=ch7_ink,n=400)
  legend('topright',c('2 stupně volnosti','5 stupňů volnosti','24 stupňů volnosti','normované normální'),lty=c(1,1,1,2),lwd=2,col=c(cols,ch7_ink),bty='n',cex=.74)
},width=10,height=4.4)
ch7_fig('t-rozdeleni','simulace',note='Dva panely vedle sebe. Vlevo světle modrý histogram 10 000 simulovaných hodnot statistiky (m − μ)/(s/√5) z výběrů pěti lidí z normální populace, plná modrá křivka t-rozdělení se 4 stupni volnosti a přerušovaná oranžová křivka normovaného normálního rozdělení. Vpravo křivky t-rozdělení se 2 (oranžově), 5 (šedě) a 24 (modře) stupni volnosti a přerušovaná tmavá křivka normovaného normálního rozdělení.',panels=local({
  br <- seq(-12,12,by=.25); h <- tf_bins(pmax(pmin(ch7_tstat5,11.99),-11.99),br,'hustota'); h <- h[h$od>=-5-1e-9 & h$do<=5+1e-9,]
  df <- c(2,5,24); lab <- c('2 stupně volnosti','5 stupňů volnosti','24 stupňů volnosti')
  list(tf_panel('Dosazení s místo σ: těžší chvosty','histogram','Standardizovaný průměr výběru pěti lidí','Hustota',xlim=c(-5,5),ylim=c(0,.56),
      note=paste0('Intervaly histogramu mají šířku 0,25. Intervaly mimo rozsah −5 až 5 nejsou uvedeny; leží v nich ',ch7_num(100*mean(abs(ch7_tstat5)>5),1),' % hodnot.'),
      series=list(tf_series('10 000 hodnot (m − μ)/(s/√5)',h,'histogram',digits=4),tf_curve('normované normální rozdělení',dnorm,-5,5,51),tf_curve('t-rozdělení, 4 stupně volnosti',function(x) dt(x,4),-5,5,51))),
    tf_panel('Více stupňů volnosti: blíže normálnímu','čárový graf','Hodnota statistiky','Hustota',xlim=c(-4,4),ylim=c(0,.56),
      series=c(lapply(1:3,function(j) tf_curve(paste0('t-rozdělení, ',lab[j]),function(x) dt(x,df[j]),-4,4,41)),list(tf_curve('normované normální rozdělení',dnorm,-4,4,41))))) }))
ch7_draw('p-funkce', {
  par(mar=c(4.6,4.7,2.7,.8))
  mu <- seq(38,54,by=.02); p <- ch7_p2(46,11,25,mu)
  plot(mu,p,type='l',lwd=2.4,col=ch7_blue,ylim=c(0,1.04),xlab=expression('Testovaná hodnota '*mu[0]*' (body)'),ylab=expression('Oboustranná '*italic(p)*'-hodnota'),main=expression(bolditalic(p)*bold('-hodnota ')*bolditalic(t)*bold('-testu pro různé testované hodnoty')),bty='l',yaxs='i')
  abline(h=.05,lty=2,col=ch7_gray)
  rect(ch7_ci_att_t[1],-.1,ch7_ci_att_t[2],.05,col=adjustcolor(ch7_fill,.8),border=NA)
  lines(mu,p,lwd=2.4,col=ch7_blue)
  segments(ch7_ci_att_t,0,ch7_ci_att_t,.05,lwd=1.6,col=ch7_ink)
  text(46,.025,'Vnitřek 95% intervalu: nezamítnuté hodnoty',cex=.8,col=ch7_ink)
  points(c(50,48),ch7_p2(46,11,25,c(50,48)),pch=21,bg=ch7_orange,col=ch7_ink,cex=1.3)
  text(50.8,ch7_p2(46,11,25,50)+.06,bquote(mu[0]*' = 50: '*.(ch7_num(ch7_p2(46,11,25,50),3))),adj=0,cex=.82)
  text(48.3,ch7_p2(46,11,25,48)+.05,bquote(mu[0]*' = 48: '*.(ch7_num(ch7_p2(46,11,25,48),2))),adj=0,cex=.82)
  text(53.8,.08,'hladina 0,05',adj=1,cex=.8,col=ch7_gray)
},width=8.6,height=4.6)
ch7_fig('p-funkce','krivka',note='Modrá křivka je oboustranná p-hodnota t-testu pro m = 46, s = 11 a n = 25 podle testované hodnoty μ0; vrchol 1 má v μ0 = 46. Pod přerušovanou čarou hladiny 0,05 leží mezi mezemi 95% intervalu světle modrý pruh s popiskem „Vnitřek 95% intervalu: nezamítnuté hodnoty“. Dva oranžové body s popisky vyznačují testované hodnoty 50 a 48.',panels=list(local({
  f <- function(mu) ch7_p2(46,11,25,mu); k <- c(50,48)
  tf_panel('p-hodnota t-testu pro různé testované hodnoty','čárový graf','Testovaná hodnota μ0 (body)','Oboustranná p-hodnota',xlim=c(38,54),ylim=c(0,1.04),
    guides=list(tf_guide('y',.05,'hladina 0,05')),
    series=list(tf_curve('Oboustranná p-hodnota',f,38,54,81,note='p = 2 · P(T ≥ |46 − μ0|/(11/√25)) pro t-rozdělení s 24 stupni volnosti'),
      tf_series(paste0('Vnitřek 95% intervalu (',ch7_num(ch7_ci_att_t[1]),' až ',ch7_num(ch7_ci_att_t[2]),'): nezamítnuté hodnoty'),data.frame(x=ch7_ci_att_t,y=.05),'plocha',note='pruh mezi vodorovnou osou a hladinou 0,05'),
      tf_series('Vyznačené testované hodnoty',data.frame(x=k,y=f(k),popisek=paste0('μ0 = ',k,': ',c(ch7_num(f(50),3),ch7_num(f(48),2)))),digits=4))) })))
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
ch7_fig('pasmo-pouziti','krivka',note='Tři normální křivky hustoty se směrodatnou odchylkou 10: průměr 50 plnou tmavou čarou, průměr 47 přerušovanou oranžovou a průměr 53 přerušovanou modrou. Oranžově je vybarvena plocha pod křivkou s průměrem 47 nalevo od hranice 40. Legenda uvádí pro každý průměr podíl lidí pod hranicí 40.',panels=list(local({
  mus <- c(47,50,53)
  tf_panel('Posun průměru o 3 body a podíl lidí pod hranicí 40','čárový graf','Skór pozornosti (body)','Hustota',xlim=c(15,85),ylim=c(0,.05),
    guides=list(tf_guide('x',ch7_cut,'hranice 40: doporučení další diagnostiky')),
    series=c(lapply(1:3,function(j) tf_curve(paste0('průměr ',mus[j],': pod 40 je ',ch7_num(100*ch7_share[j],1),' %'),function(x) dnorm(x,mus[j],10),15,85,71,note=paste0('normální rozdělení, μ = ',mus[j],', σ = 10'))),
      list(tf_curve(paste0('Plocha pod křivkou s průměrem 47 nalevo od 40 (',ch7_num(100*ch7_share[1],1),' %)'),function(x) dnorm(x,47,10),15,ch7_cut,26,mark='plocha',note='plocha pokračuje i vlevo od okraje grafu')))) })))
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
ch7_fig('hypotezy-ekvivalence','schema',note='Číselná osa populačního průměru μ od 40 do 60 bodů. Obě části nulové hypotézy (μ ≤ 47 a μ ≥ 53) jsou podbarveny pískově a popsány oranžově, pásmo alternativní hypotézy 47 < μ < 53 je světle modré s modrým popiskem. Hranice 47 a 53 jsou svislé čáry, norma 50 je vyznačena krátkou přerušovanou čárkou.')
ch7_draw('ctyri-kombinace', {
  par(mar=c(4.6,10.5,2.7,.8))
  e <- ch7_eq; k <- nrow(e); y <- k:1
  lab <- paste0('Studie ',e$studie,' (n = ',e$n,')')
  plot(NA,xlim=c(40,60),ylim=c(.4,k+1.7),yaxt='n',xlab='Skór v testu pozornosti, online verze (body)',ylab='',main='Intervaly devíti studií vůči pásmu ekvivalence 47–53',bty='l')
  rect(47,0,53,k+.6,col=adjustcolor(ch7_fill,.55),border=NA)
  segments(c(47,53),0,c(47,53),k+.6,lty=2,lwd=1.5,col=ch7_ink); segments(50,0,50,k+.6,lty=3,lwd=1.5,col=ch7_gray)
  axis(2,at=y,labels=lab,tick=FALSE,cex.axis=.9)
  segments(e$ci95_d,y,e$ci95_h,y,lwd=1.4,col=ch7_ink)
  segments(e$ci95_d,y-.1,e$ci95_d,y+.1,lwd=1.4,col=ch7_ink); segments(e$ci95_h,y-.1,e$ci95_h,y+.1,lwd=1.4,col=ch7_ink)
  segments(e$ci90_d,y,e$ci90_h,y,lwd=6,col=ch7_blue,lend=1)
  points(e$m,y,pch=21,bg='white',col=ch7_ink,cex=1.2)
  legend('top',c('95% interval: test rozdílu od 50','90% interval: test ekvivalence','pásmo ekvivalence','norma 50'),lwd=c(1.4,6,NA,1.5),lty=c(1,1,NA,3),col=c(ch7_ink,ch7_blue,NA,ch7_gray),fill=c(NA,NA,adjustcolor(ch7_fill,.55),NA),border=NA,bty='n',cex=.78,ncol=2)
},width=9.4,height=6.4)
ch7_fig('ctyri-kombinace','data',note='Devět studií pod sebou v uvedeném pořadí shora dolů (studie A nahoře). U každé studie je tenká tmavá úsečka se zarážkami na koncích (95% interval), přes ni tlustá modrá úsečka (90% interval) a bílý bod ve výběrovém průměru. Pásmo ekvivalence 47–53 je vybarveno světle modře a ohraničeno přerušovanými čarami; tečkovaná čára leží u normy 50.',panels=list(local({
  e <- ch7_eq; lab <- paste0('Studie ',e$studie,' (n = ',e$n,')')
  tf_panel('Intervaly devíti studií vůči pásmu ekvivalence 47–53','intervalový graf','Skór v testu pozornosti, online verze (body)','Studie',xlim=c(40,60),
    guides=list(tf_band('x',ch7_mu0-ch7_delta,ch7_mu0+ch7_delta,'pásmo ekvivalence 47–53'),tf_guide('x',ch7_mu0,'norma 50')),
    series=list(tf_series('95% interval: test rozdílu od 50',data.frame(kategorie=lab,od=e$ci95_d,do=e$ci95_h,stred=e$m),'interval',direction='vodorovně',note='stred je výběrový průměr studie'),
      tf_series('90% interval: test ekvivalence',data.frame(kategorie=lab,od=e$ci90_d,do=e$ci90_h),'interval',direction='vodorovně'))) })))
# One-sided interval with an upper bound versus two-sided intervals for the one-sided test of the running example.
ch7_draw('jednostranne-intervaly', {
  par(mar=c(4.6,13.5,2.7,.8))
  up1 <- ch7_ci_att_t90[2]; y <- 3:1
  lab <- c('95% oboustranný interval','90% oboustranný interval','95% jednostranný interval\ns horní mezí')
  plot(NA,xlim=c(36,56),ylim=c(.4,3.8),yaxt='n',xlab='Skór v testu pozornosti (body)',ylab='',main='Jednostranný test „menší“ a odpovídající intervaly',bty='l')
  axis(2,at=y,labels=lab,tick=FALSE,cex.axis=.9)
  abline(v=50,lty=3,lwd=1.6,col=ch7_gray); text(50.2,3.65,'norma 50',adj=0,cex=.82,col=ch7_gray)
  segments(ch7_ci_att_t[1],3,ch7_ci_att_t[2],3,lwd=3,col=ch7_ink)
  segments(ch7_ci_att_t90[1],2,ch7_ci_att_t90[2],2,lwd=6,col=ch7_blue,lend=1)
  arrows(up1,1,36.2,1,lwd=3,col=ch7_orange,length=.12)
  segments(up1,.85,up1,1.15,lwd=3,col=ch7_orange)
  points(c(46,46),c(3,2),pch=21,bg='white',col=ch7_ink,cex=1.2)
  text(ch7_ci_att_t[1],3.18,ch7_num(ch7_ci_att_t[1]),adj=c(.5,0),cex=.8,col=ch7_ink)
  text(ch7_ci_att_t[2]+.2,3.18,ch7_num(ch7_ci_att_t[2]),adj=c(0,0),cex=.8,col=ch7_ink)
  text(ch7_ci_att_t90[1],2.22,ch7_num(ch7_ci_att_t90[1]),adj=c(.5,0),cex=.8,col=ch7_blue)
  text(ch7_ci_att_t90[2]-.15,2.22,ch7_num(ch7_ci_att_t90[2]),adj=c(1,0),cex=.8,col=ch7_blue)
  text(up1-.15,1.27,ch7_num(up1),adj=c(1,0),cex=.8,col=ch7_orange); text(37,1.27,'bez dolní meze',adj=c(0,0),cex=.8,col=ch7_orange)
},width=9,height=3.6)
ch7_fig('jednostranne-intervaly','data',note='Tři intervaly pod sebou v uvedeném pořadí shora dolů: 95% oboustranný tmavou úsečkou, 90% oboustranný tlustou modrou úsečkou a 95% jednostranný oranžově jako šipka doleva od horní meze s popiskem „bez dolní meze“ (prázdná hodnota od je otevřený konec). Bílé body u obou oboustranných intervalů leží ve výběrovém průměru 46; u mezí jsou popisky jejich hodnot. Tečkovaná svislá čára leží u normy 50.',panels=list(
  tf_panel('Jednostranný test „menší“ a odpovídající intervaly','intervalový graf','Skór v testu pozornosti (body)','Typ intervalu',xlim=c(36,56),
    guides=list(tf_guide('x',50,'norma 50')),
    series=list(tf_series('Oboustranné intervaly pro populační průměr (m = 46, s = 11, n = 25)',data.frame(kategorie=c('95% oboustranný interval','90% oboustranný interval'),
        od=c(ch7_ci_att_t[1],ch7_ci_att_t90[1]),do=c(ch7_ci_att_t[2],ch7_ci_att_t90[2]),stred=c(46,46)),'interval',direction='vodorovně',note='stred je výběrový průměr'),
      tf_series('Jednostranný interval',data.frame(kategorie='95% jednostranný interval s horní mezí',od=NA_real_,do=ch7_ci_att_t90[2]),'interval',direction='vodorovně',note='bez dolní meze: šipka doleva až k okraji grafu')))))
# Mirror: the sample mean lies in the acceptance region around mu0 exactly when mu0 lies in the interval around m.
ch7_draw('zrcadlo-intervalu', {
  par(mar=c(4.6,15,2.7,.8))
  me <- ch7_q24*11/5
  plot(NA,xlim=c(38,60),ylim=c(.4,2.9),yaxt='n',xlab='Skór v testu pozornosti (body)',ylab='',main='Stejná vzdálenost, dva pohledy',bty='l')
  axis(2,at=2,labels=expression('Oblast nezamítnutí kolem '*mu[0]*' = 50'),tick=FALSE,cex.axis=.9)
  axis(2,at=1,labels=expression('95% interval kolem '*italic(m)*' = 46'),tick=FALSE,cex.axis=.9)
  rect(ch7_accept[1],1.85,ch7_accept[2],2.15,col=ch7_sand,border=ch7_orange,lwd=1.4)
  segments(ch7_ci_att_t[1],1,ch7_ci_att_t[2],1,lwd=6,col=ch7_blue,lend=1)
  points(c(50,50),c(2,1),pch=23,bg=ch7_orange,col=ch7_ink,cex=1.25); points(c(46,46),c(2,1),pch=21,bg='white',col=ch7_ink,cex=1.25)
  text(ch7_accept,2.3,ch7_num(ch7_accept),cex=.8,col=ch7_orange); text(ch7_ci_att_t,1.22,ch7_num(ch7_ci_att_t),cex=.8,col=ch7_blue)
  arrows(46,1.55,50,1.55,code=3,length=.07,col=ch7_ink); text(48,1.7,expression('|'*italic(m)-mu[0]*'| = 4'),cex=.82)
  text(55.6,1.5,paste0('mezní chyba ',ch7_num(me),'\nna každou stranu'),adj=0,cex=.78,col=ch7_gray)
  legend('topleft',legend=c(expression('výběrový průměr '*italic(m)),expression('testovaná hodnota '*mu[0])),pch=c(21,23),pt.bg=c('white',ch7_orange),col=ch7_ink,bty='n',cex=.8,horiz=TRUE)
},width=9,height=3.4)
ch7_fig('zrcadlo-intervalu','data',note='Dva řádky nad společnou osou. Nahoře (poloha 2) je oblast nezamítnutí kolem μ0 = 50 jako pískový obdélník s oranžovým okrajem, dole (poloha 1) 95% interval kolem m = 46 jako tlustá modrá úsečka; u mezí jsou popisky jejich hodnot. V obou řádcích je výběrový průměr 46 bílým kolečkem a testovaná hodnota 50 oranžovým kosočtvercem. Mezi řádky vede oboustranná šipka od 46 k 50 s popiskem „|m − μ0| = 4“; vpravo je popisek mezní chyby.',panels=list(local({
  me <- ch7_q24*11/5
  tf_panel('Stejná vzdálenost, dva pohledy','intervalový graf','Skór v testu pozornosti (body)','Řádek (2 = oblast nezamítnutí kolem μ0, 1 = 95% interval kolem m)',xlim=c(38,60),ylim=c(.4,2.9),
    note=paste0('Mezní chyba ',ch7_num(me),' bodu na každou stranu.'),
    series=list(tf_series('Oblast nezamítnutí a 95% interval',data.frame(poloha=c(2,1),od=c(ch7_accept[1],ch7_ci_att_t[1]),do=c(ch7_accept[2],ch7_ci_att_t[2]),popisek=c('Oblast nezamítnutí kolem μ0 = 50','95% interval kolem m = 46')),'interval',direction='vodorovně'),
      tf_series('výběrový průměr m',data.frame(x=c(46,46),y=c(2,1))),
      tf_series('testovaná hodnota μ0',data.frame(x=c(50,50),y=c(2,1))),
      tf_series('Vzdálenost |m − μ0| = 4 (oboustranná šipka)',data.frame(x0=46,y0=1.55,x1=50,y1=1.55),'usecky'))) })))
# Exercise 7: the same plotting positions and reference line as chapter 4.
ch7_qq_y <- sort(ch7_u07)
ch7_qq_p <- (seq_along(ch7_qq_y)-.5)/length(ch7_qq_y)
ch7_qq_z <- qnorm(ch7_qq_p)
ch7_draw('qq-uzkost', {
  plot(ch7_qq_z,ch7_qq_y,xlab='Teoretický kvantil normovaného normálního rozdělení',
       ylab='Seřazený skór úzkosti (body)',main='Q–Q graf skórů zkouškové úzkosti',
       pch=21,bg=ch7_blue,col=ch7_ink,bty='l',cex=1.1)
  abline(a=mean(ch7_u07),b=sd(ch7_u07),col=ch7_orange,lwd=1.8)
  legend('topleft','Referenční přímka: m + s × z',col=ch7_orange,lwd=1.8,bty='n',cex=.85)
},width=8.6,height=4.6)
ch7_fig('qq-uzkost','data',note='Modré body jsou seřazené skóry 20 studentů proti teoretickým kvantilům pro podíly (i − 0,5)/20. Oranžová referenční přímka má úsek rovný výběrovému průměru m a směrnici rovnou výběrové směrodatné odchylce s.',panels=list(
  tf_panel('Q–Q graf skórů zkouškové úzkosti','bodový graf','Teoretický kvantil normovaného normálního rozdělení','Seřazený skór úzkosti (body)',
    guides=list(tf_guide('primka',c(mean(ch7_u07),sd(ch7_u07)),paste0('Referenční přímka: m + s × z (m = ',ch7_num(mean(ch7_u07),1),', s = ',ch7_num(sd(ch7_u07),3),')'))),
    series=list(tf_series('Seřazené skóry',data.frame(x=ch7_qq_z,y=ch7_qq_y),digits=3)))))
options(ch7_old_options)
