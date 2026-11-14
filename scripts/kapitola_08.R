# Teaching data, calculations and figures for chapter 8; base R, UTF-8, deterministic project-root paths.
# Parking summaries are quoted from Howell (2013, p. 86); anorexia summaries were computed from
# Howell's Table 7.3 (pp. 198-199) and converted to kilograms; every other value is an authored teaching model.
ch8_out <- 'assets/chapter-08/plots'
ch8_old_options <- options(OutDec=',')
dir.create(ch8_out,recursive=TRUE,showWarnings=FALSE)
ch8_blue <- '#245D78'; ch8_orange <- '#B54E24'; ch8_fill <- '#B8DDE8'; ch8_gray <- '#4D5A63'; ch8_pale <- '#E1E8EB'; ch8_sand <- '#FAECDD'; ch8_ink <- '#223744'; ch8_mute <- '#A9BAC3'; ch8_green <- '#3E7B4F'
ch8_num <- function(x,digits=2) sub('^-','−',formatC(x,format='f',digits=digits,decimal.mark=','))
ch8_draw <- function(name,code,width=8,height=4.5) {
  svg(file.path(ch8_out,paste0(name,'.svg')),width=width,height=height,family='sans',bg='white')
  par(mar=c(4.5,4.5,2.6,.8),mgp=c(2.7,.7,0),las=1,col.axis=ch8_ink,col.lab=ch8_ink,fg=ch8_ink,cex=.9)
  force(code); dev.off()
}
# Procedures from summaries --------------------------------------------------------------
# One sample of differences: the paired t-test is the one-sample t-test of chapter 7 applied to differences.
ch8_one <- function(m,s,n,level=.95) {
  m <- unname(m); s <- unname(s); n <- unname(n)
  se <- s/sqrt(n); q <- qt(1-(1-level)/2,n-1); t <- m/se
  c(m=m,s=s,n=n,se=se,df=n-1,t=t,p=2*pt(-abs(t),n-1),q=q,dolni=m-q*se,horni=m+q*se)
}
# Two independent samples: classic test with the pooled variance estimate.
ch8_pooled <- function(m1,s1,n1,m2,s2,n2,level=.95) {
  m1 <- unname(m1); s1 <- unname(s1); m2 <- unname(m2); s2 <- unname(s2)
  sp2 <- ((n1-1)*s1^2+(n2-1)*s2^2)/(n1+n2-2); se <- sqrt(sp2*(1/n1+1/n2)); df <- n1+n2-2
  q <- qt(1-(1-level)/2,df); t <- (m1-m2)/se
  c(rozdil=m1-m2,sp2=sp2,sp=sqrt(sp2),se=se,df=df,t=t,p=2*pt(-abs(t),df),q=q,dolni=m1-m2-q*se,horni=m1-m2+q*se,d=(m1-m2)/sqrt(sp2))
}
# Welch's test: separate variances and Welch-Satterthwaite degrees of freedom (not rounded).
ch8_welch <- function(m1,s1,n1,m2,s2,n2,level=.95) {
  m1 <- unname(m1); s1 <- unname(s1); m2 <- unname(m2); s2 <- unname(s2)
  a <- s1^2/n1; b <- s2^2/n2; se <- sqrt(a+b); df <- (a+b)^2/(a^2/(n1-1)+b^2/(n2-1))
  q <- qt(1-(1-level)/2,df); t <- (m1-m2)/se
  c(rozdil=m1-m2,se=se,df=df,t=t,p=2*pt(-abs(t),df),q=q,dolni=m1-m2-q*se,horni=m1-m2+q*se)
}
ch8_sum <- function(x) c(m=mean(x),s=sd(x),n=length(x))
# A. Running example, paired version: the same students after normal and after short sleep ------
# Thirteen students; student 9 has no score after short sleep. Difference = normal minus short sleep.
ch8_par <- data.frame(id=1:13,
  bezny=c(58,44,51,39,62,47,55,42,53,49,60,45,52),
  kratky=c(53,42,45,38,55,44,51,43,NA,44,58,39,50))
ch8_par_ok <- with(ch8_par,!is.na(bezny)&!is.na(kratky))
ch8_par_u <- ch8_par[ch8_par_ok,]
ch8_par_d <- ch8_par_u$bezny-ch8_par_u$kratky
ch8_par_res <- ch8_one(mean(ch8_par_d),sd(ch8_par_d),length(ch8_par_d))
ch8_par_b <- ch8_sum(ch8_par_u$bezny); ch8_par_k <- ch8_sum(ch8_par_u$kratky)
# The same complete pairs analysed (wrongly) as two independent groups.
ch8_par_wrong <- ch8_pooled(ch8_par_b['m'],ch8_par_b['s'],12,ch8_par_k['m'],ch8_par_k['s'],12)
# Column means taken without removing the incomplete pair: 13 versus 12 students.
ch8_par_cols <- c(bezny=mean(ch8_par$bezny),kratky=mean(ch8_par$kratky,na.rm=TRUE))
# Contrast: perfectly preserved order with tripled second values; SD of differences doubles.
ch8_troj_x <- c(2,4,6); ch8_troj_y <- 3*ch8_troj_x
# B. Independent version: two groups of different size and spread --------------------------
# Generated once (seed 20261189, rounded to whole points) and stored as fixed values.
ch8_sk_kratky <- c(52,55,23,59,36,51,24,56,28,34,56,30)
ch8_sk_bezny <- c(67,55,54,46,43,41,57,41,54,44,40,47,41,51,45,47,62,44,49,54,69,36,56,49,51,53,58,53,52,41)
ch8_sk_k <- ch8_sum(ch8_sk_kratky); ch8_sk_b <- ch8_sum(ch8_sk_bezny)
ch8_sk_pool <- ch8_pooled(ch8_sk_b['m'],ch8_sk_b['s'],30,ch8_sk_k['m'],ch8_sk_k['s'],12)
ch8_sk_welch <- ch8_welch(ch8_sk_b['m'],ch8_sk_b['s'],30,ch8_sk_k['m'],ch8_sk_k['s'],12)
# Parking study (Howell, p. 86) without known sigma: s = 14.6 s in both groups of 100 drivers.
ch8_park <- ch8_pooled(39.03,14.6,100,32.15,14.6,100)
ch8_park_welch <- ch8_welch(39.03,14.6,100,32.15,14.6,100)
# Anorexia (Everitt via Howell, Table 7.3): full-precision summaries in pounds, converted to kilograms.
ch8_lb <- 0.45359237
ch8_anor_lb <- c(m_pred=83.229412,m_po=90.494118,m_d=7.264706,s_d=7.157421,s_pred=5.016693,n=17)
ch8_anor <- ch8_anor_lb; ch8_anor[1:5] <- ch8_anor_lb[1:5]*ch8_lb
ch8_anor_res <- ch8_one(ch8_anor['m_d'],ch8_anor['s_d'],17)
ch8_anor_d_pred <- unname(ch8_anor['m_d']/ch8_anor['s_pred']); ch8_anor_d_z <- unname(ch8_anor['m_d']/ch8_anor['s_d'])
# Two groups side by side: 25 students per group, 46 versus 52 points, s = 10 in both.
ch8_vedle <- ch8_pooled(52,10,25,46,10,25)
ch8_vedle_ci <- rbind(kratky=46+c(-1,1)*qt(.975,24)*2,bezny=52+c(-1,1)*qt(.975,24)*2)
ch8_par_ci <- rbind(kratky=ch8_par_k['m']+c(-1,1)*qt(.975,11)*ch8_par_k['s']/sqrt(12),
                    bezny=ch8_par_b['m']+c(-1,1)*qt(.975,11)*ch8_par_b['s']/sqrt(12))
# D. Change in two groups: attention before and after a four-week training (authored) -------
ch8_tr <- data.frame(id=1:32,skupina=rep(c('trénink','kontrola'),each=16),
  pred=c(46,52,41,55,48,44,50,57,43,49,53,47,45,51,58,42, 47,50,44,53,49,41,55,46,52,48,43,56,45,51,50,47))
ch8_tr_zmena_i <- c(12,-3,8,-4,14,5,9,-2,3,10,-6,7,4,13,0,-6)
ch8_tr_zmena_k <- c(6,-7,9,-3,10,1,-6,5,2,11,-4,3,-1,8,0,-2)
ch8_tr$po <- ch8_tr$pred+c(ch8_tr_zmena_i,ch8_tr_zmena_k)
ch8_tr$zmena <- ch8_tr$po-ch8_tr$pred
ch8_tr_i <- ch8_one(mean(ch8_tr_zmena_i),sd(ch8_tr_zmena_i),16)
ch8_tr_k <- ch8_one(mean(ch8_tr_zmena_k),sd(ch8_tr_zmena_k),16)
ch8_tr_rozdil <- ch8_pooled(mean(ch8_tr_zmena_i),sd(ch8_tr_zmena_i),16,mean(ch8_tr_zmena_k),sd(ch8_tr_zmena_k),16)
# Equivalence of two test versions: online minus paper, bounds -3 and 3 set in advance.
ch8_ekv <- data.frame(studie=c('velká','malá'),m_online=49.2,m_papir=50.1,s=10,n=c(200,30))
ch8_ekv_res <- t(sapply(1:2,function(i) {
  e <- ch8_ekv[i,]; r95 <- ch8_pooled(e$m_online,e$s,e$n,e$m_papir,e$s,e$n,.95); r90 <- ch8_pooled(e$m_online,e$s,e$n,e$m_papir,e$s,e$n,.90)
  c(rozdil=r95[['rozdil']],se=r95[['se']],df=r95[['df']],p=r95[['p']],d95=r95[['dolni']],h95=r95[['horni']],d90=r90[['dolni']],h90=r90[['horni']])
}))
rownames(ch8_ekv_res) <- ch8_ekv$studie
# Exercise inputs (authored unless stated) --------------------------------------------------
ch8_u03 <- data.frame(id=1:15,
  kongr=c(612,685,590,731,648,577,702,659,NA,624,690,605,668,641,720),
  nekongr=c(689,742,671,790,702,660,NA,731,698,701,768,672,735,699,805))
ch8_u03_ok <- with(ch8_u03,!is.na(kongr)&!is.na(nekongr))
ch8_u03_d <- with(ch8_u03[ch8_u03_ok,],nekongr-kongr)
ch8_u06_a <- c(78,41,95,62,54,88,47,71,39,66)
ch8_u06_b <- c(52,48,61,44,57,50,46,55,49,63,51,45,58,53,47,60,50,54,42,56,49,52,59,48,51)
# Correlation of the two paired measurements and the SD of differences (optional extension) --
ch8_par_r <- cor(ch8_par_u$bezny,ch8_par_u$kratky)
ch8_sd_rozdilu <- function(r,s1=unname(ch8_par_b['s']),s2=unname(ch8_par_k['s'])) sqrt(s1^2+s2^2-2*r*s1*s2)
# Three simulated sets of 12 students with exactly the SDs and means of variant A and a chosen sample r
# (orthogonalised normal deviates, seed fixed); used only to illustrate the shape of paired data.
ch8_sim_par <- function(r,seed) {
  set.seed(seed); z <- scale(matrix(rnorm(24),12))
  z[,2] <- resid(lm(z[,2]~z[,1])); z <- scale(z)
  y <- r*z[,1]+sqrt(1-r^2)*z[,2]
  data.frame(bezny=ch8_par_b[['m']]+ch8_par_b[['s']]*z[,1],kratky=ch8_par_k[['m']]+ch8_par_k[['s']]*as.numeric(scale(y)))
}
ch8_sim_r <- c(.9,0,-.5)
ch8_sim <- lapply(seq_along(ch8_sim_r),function(i) ch8_sim_par(ch8_sim_r[i],20261114+i))
# Standard error of the difference and Welch df for 90 people split 1:1, 2:1, 4:1 and 8:1 (population values).
ch8_pomer <- data.frame(pomer=c('1:1','2:1','4:1','8:1'),n1=c(45,60,72,80),n2=c(45,30,18,10))
ch8_pomer_lab <- paste0(ch8_pomer$pomer,'
(',ch8_pomer$n1,' a ',ch8_pomer$n2,')')
ch8_se_dif <- function(s1,n1,s2,n2) sqrt(s1^2/n1+s2^2/n2)
ch8_se_pool <- function(s1,n1,s2,n2) sqrt(((n1-1)*s1^2+(n2-1)*s2^2)/(n1+n2-2)*(1/n1+1/n2))
ch8_welch_df <- function(s1,n1,s2,n2) { a <- s1^2/n1; b <- s2^2/n2; (a+b)^2/(a^2/(n1-1)+b^2/(n2-1)) }
ch8_pomer <- within(ch8_pomer, {
  se_shodne <- ch8_se_dif(10,n1,10,n2)
  se_mala_var <- ch8_se_dif(10,n1,20,n2); se_mala_var_pool <- ch8_se_pool(10,n1,20,n2)
  se_velka_var <- ch8_se_dif(20,n1,10,n2); se_velka_var_pool <- ch8_se_pool(20,n1,10,n2)
  df_shodne <- ch8_welch_df(10,n1,10,n2); df_mala_var <- ch8_welch_df(10,n1,20,n2); df_velka_var <- ch8_welch_df(20,n1,10,n2)
})
# Approximate CI for Cohen's d standardised by the control-group SD (Howell, 2013, p. 632) and the
# exact noncentral-t interval for the pooled d (comparison only); paired d after Algina & Keselman (2003, pp. 544-545).
ch8_d_ci <- function(d,n_kontrola,n_druha,level=.95) {
  se <- sqrt((n_kontrola+n_druha)/(n_kontrola*n_druha)+d^2/(2*n_kontrola)); z <- qnorm(1-(1-level)/2)
  c(d=d,se=se,dolni=d-z*se,horni=d+z*se)
}
ch8_nct_ci <- function(t,df,level=.95) {
  a <- (1-level)/2
  # pt() with a noncentrality parameter may warn about the last digits; the limits are checked against the text.
  suppressWarnings(c(uniroot(function(l) pt(t,df,ncp=l)-(1-a),c(t-20,t+20),tol=1e-10)$root,
    uniroot(function(l) pt(t,df,ncp=l)-a,c(t-20,t+20),tol=1e-10)$root))
}
ch8_park_dci <- ch8_d_ci(unname(ch8_park['d']),100,100)
ch8_park_dci_presne <- ch8_nct_ci(unname(ch8_park['t']),198)*sqrt(1/100+1/100)
ch8_sk_d <- unname(ch8_sk_pool['rozdil']/ch8_sk_b['s'])
ch8_sk_dci <- ch8_d_ci(ch8_sk_d,30,12)
ch8_par_stdz <- sqrt((ch8_par_b[['s']]^2+ch8_par_k[['s']]^2)/2)
ch8_par_dav <- unname(ch8_par_res['m'])/ch8_par_stdz
ch8_par_dci <- ch8_nct_ci(unname(ch8_par_res['t']),11)*sqrt(2*unname(ch8_par_res['s'])^2/(12*(ch8_par_b[['s']]^2+ch8_par_k[['s']]^2)))
# Figures ----------------------------------------------------------------------------------
ch8_draw('dve-usporadani', {
  par(mfrow=c(1,2),mar=c(1,1,3,1))
  for(k in 1:2) {
    plot(NA,xlim=c(0,10),ylim=c(0,10),axes=FALSE,xlab='',ylab='',
      main=if(k==1) 'Párová data: tíž lidé dvakrát' else 'Nezávislé skupiny: různí lidé')
    if(k==1) {
      y <- seq(8.6,1.4,length.out=6)
      text(2.6,9.5,'po běžném spánku',cex=.82,col=ch8_gray); text(7.4,9.5,'po krátkém spánku',cex=.82,col=ch8_gray)
      for(i in seq_along(y)) {
        segments(3.1,y[i],6.9,y[i],lwd=1.6,col=ch8_mute)
        symbols(c(2.6,7.4),c(y[i],y[i]),circles=c(.38,.38),inches=FALSE,add=TRUE,bg=c(ch8_fill,ch8_sand),fg=ch8_ink)
        text(c(2.6,7.4),y[i],paste0('S',i),cex=.72)
      }
      text(5,.4,'jedna dvojice hodnot = jeden člověk; počítáme rozdíl v každé dvojici',cex=.76,col=ch8_blue)
    } else {
      y1 <- seq(8.6,1.4,length.out=6); y2 <- seq(8.6,1.4,length.out=7)
      text(2.6,9.5,'skupina po běžném spánku',cex=.82,col=ch8_gray); text(7.4,9.5,'skupina po krátkém spánku',cex=.82,col=ch8_gray)
      symbols(rep(2.6,6),y1,circles=rep(.38,6),inches=FALSE,add=TRUE,bg=ch8_fill,fg=ch8_ink); text(2.6,y1,paste0('S',1:6),cex=.72)
      symbols(rep(7.4,7),y2,circles=rep(.38,7),inches=FALSE,add=TRUE,bg=ch8_sand,fg=ch8_ink); text(7.4,y2,paste0('S',7:13),cex=.72)
      text(5,.4,'skupiny mohou mít různou velikost; porovnáváme průměry skupin',cex=.76,col=ch8_orange)
    }
  }
},width=9.4,height=4.2)
ch8_draw('parova-data', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,3,.8))
  u <- ch8_par_u
  plot(NA,xlim=c(.6,2.4),ylim=c(35,65),xaxt='n',xlab='',ylab='Skór pozornosti (body)',main='Dvanáct studentů ve dvou podmínkách',bty='l')
  axis(1,at=1:2,labels=c('po běžném spánku','po krátkém spánku'))
  segments(1,u$bezny,2,u$kratky,col=adjustcolor(ch8_blue,.75),lwd=1.6)
  points(rep(1,12),u$bezny,pch=21,bg=ch8_fill,col=ch8_ink,cex=1.1); points(rep(2,12),u$kratky,pch=21,bg=ch8_sand,col=ch8_ink,cex=1.1)
  points(1,53,pch=4,col=ch8_orange,cex=1.3,lwd=2.2); text(.62,64.6,'× student 9: druhé měření chybí',adj=0,cex=.74,col=ch8_orange)
  set.seed(8); jit <- runif(12,-.12,.12)
  plot(NA,xlim=c(-4,9),ylim=c(.4,1.8),yaxt='n',xlab='Rozdíl běžný − krátký spánek (body)',ylab='',main='Rozdíly kolísají méně než skóry',bty='l')
  abline(v=0,lty=2,col=ch8_gray)
  points(ch8_par_d,1.3+jit,pch=21,bg=ch8_blue,col=ch8_ink,cex=1.1)
  r <- ch8_par_res
  segments(r['dolni'],.8,r['horni'],.8,lwd=3,col=ch8_ink); points(r['m'],.8,pch=21,bg='white',col=ch8_ink,cex=1.4)
  text(r['m'],.6,paste0('průměrný rozdíl ',ch8_num(r['m'],1),' bodu, 95% interval (',ch8_num(r['dolni']),'; ',ch8_num(r['horni']),')'),cex=.74)
},width=10,height=4.4)
ch8_draw('dve-skupiny', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,3,.8))
  plot(NA,xlim=c(.5,2.5),ylim=c(18,72),xaxt='n',xlab='',ylab='Skór pozornosti (body)',main='Dvě skupiny různé velikosti a variability',bty='l')
  axis(1,at=1:2,labels=c('běžný spánek (n = 30)','krátký spánek (n = 12)'))
  boxplot(list(ch8_sk_bezny,ch8_sk_kratky),at=1:2,add=TRUE,axes=FALSE,boxwex=.42,col=c(adjustcolor(ch8_fill,.6),adjustcolor(ch8_sand,.9)),border=ch8_gray,outline=FALSE)
  set.seed(9); points(1+runif(30,-.17,.17),ch8_sk_bezny,pch=21,bg=ch8_blue,col=ch8_ink,cex=.9); points(2+runif(12,-.17,.17),ch8_sk_kratky,pch=21,bg=ch8_orange,col=ch8_ink,cex=.9)
  plot(NA,xlim=c(-4,20),ylim=c(.4,2.6),yaxt='n',xlab='Rozdíl průměrů běžný − krátký spánek (body)',ylab='',main='95% interval pro rozdíl dvěma postupy',bty='l')
  abline(v=0,lty=2,col=ch8_gray)
  ints <- rbind(ch8_sk_pool[c('dolni','horni')],ch8_sk_welch[c('dolni','horni')]); y <- c(2,1); cols <- c(ch8_blue,ch8_orange)
  segments(ints[,1],y,ints[,2],y,lwd=3,col=cols); points(rep(ch8_sk_pool['rozdil'],2),y,pch=21,bg='white',col=ch8_ink,cex=1.3)
  text(ch8_sk_pool['rozdil'],y-.28,paste0('(',ch8_num(ints[,1]),'; ',ch8_num(ints[,2]),')'),cex=.78)
  text(ch8_sk_pool['rozdil'],y+.3,c('klasický test se společným rozptylem','Welchův test'),cex=.8,col=cols)
},width=10,height=4.4)
ch8_draw('intervaly-vedle-sebe', {
  # layout() with four columns shrinks cex to 0.66; restore readable labels.
  layout(matrix(1:4,1),widths=c(1.25,.8,1.25,.8)); par(mar=c(4.6,4.6,3.4,.6),cex=1,cex.axis=1,cex.lab=1.05,cex.main=1.1)
  draw_groups <- function(ci,m,main,lab) {
    plot(NA,xlim=c(.5,2.5),ylim=c(38,60),xaxt='n',xlab='',ylab='Skór pozornosti (body)',main=main,bty='l')
    axis(1,at=1:2,labels=lab)
    segments(1:2,ci[,1],1:2,ci[,2],lwd=3,col=c(ch8_orange,ch8_blue)); points(1:2,m,pch=21,bg='white',col=ch8_ink,cex=1.4)
    rect(.5,max(ci[,1]),2.5,min(ci[,2]),col=adjustcolor(ch8_mute,.25),border=NA)
  }
  draw_diff <- function(r,main) {
    plot(NA,xlim=c(.5,1.5),ylim=c(-4,14),xaxt='n',xlab='',ylab='Rozdíl průměrů (body)',main=main,bty='l')
    abline(h=0,lty=2,col=ch8_gray); segments(1,r[1],1,r[2],lwd=3,col=ch8_ink); points(1,r[3],pch=21,bg='white',col=ch8_ink,cex=1.4)
  }
  draw_groups(ch8_vedle_ci,c(46,52),'Nezávislé skupiny po 25',c('krátký','běžný'))
  draw_diff(c(ch8_vedle['dolni'],ch8_vedle['horni'],6),'Rozdíl')
  draw_groups(ch8_par_ci,c(ch8_par_k['m'],ch8_par_b['m']),'Tíž studenti (12 dvojic)',c('krátký','běžný'))
  draw_diff(c(ch8_par_res['dolni'],ch8_par_res['horni'],ch8_par_res['m']),'Párový rozdíl')
},width=10.4,height=4.6)
ch8_draw('zmeny-skupin', {
  par(mar=c(4.6,13,2.8,.8))
  rows <- rbind(ch8_tr_i[c('m','dolni','horni','p')],ch8_tr_k[c('m','dolni','horni','p')],c(ch8_tr_rozdil[c('rozdil','dolni','horni','p')]))
  y <- 3:1; cols <- c(ch8_blue,ch8_mute,ch8_ink)
  lab <- c('změna: trénink','změna: kontrola','rozdíl změn')
  plot(NA,xlim=c(-4,10),ylim=c(.5,3.5),yaxt='n',xlab='Body',ylab='',main='Změna pozornosti za čtyři týdny: 95% intervaly',bty='l')
  abline(v=0,lty=2,col=ch8_gray); axis(2,at=y,labels=lab,tick=FALSE,cex.axis=.9)
  segments(rows[,2],y,rows[,3],y,lwd=3.2,col=cols); points(rows[,1],y,pch=21,bg='white',col=ch8_ink,cex=1.4)
  text(9.9,y,paste0('p = ',ch8_num(rows[,4],3)),adj=1,cex=.8,font=3,col=ch8_gray)
},width=8.8,height=3.8)
ch8_draw('ekvivalence-skupin', {
  par(mar=c(4.6,10.5,2.8,.8))
  e <- ch8_ekv_res; y <- 2:1
  plot(NA,xlim=c(-7,6),ylim=c(.5,3),yaxt='n',xlab='Rozdíl průměrů online − papír (body)',ylab='',main='Dvě studie vůči pásmu ekvivalence ±3 body',bty='l')
  rect(-3,0,3,4,col=adjustcolor(ch8_fill,.55),border=NA); abline(v=c(-3,3),lty=2,lwd=1.5,col=ch8_ink); abline(v=0,lty=3,lwd=1.5,col=ch8_gray)
  axis(2,at=y,labels=c('200 + 200 studentů','30 + 30 studentů'),tick=FALSE,cex.axis=.9)
  segments(e[,'d95'],y,e[,'h95'],y,lwd=1.4,col=ch8_ink); segments(e[,'d95'],y-.07,e[,'d95'],y+.07,lwd=1.4,col=ch8_ink); segments(e[,'h95'],y-.07,e[,'h95'],y+.07,lwd=1.4,col=ch8_ink)
  segments(e[,'d90'],y,e[,'h90'],y,lwd=6,col=ch8_blue,lend=1); points(e[,'rozdil'],y,pch=21,bg='white',col=ch8_ink,cex=1.2)
  legend('topright',c('95% interval:\ntest rozdílu','90% interval:\ntest ekvivalence'),lwd=c(1.4,6),col=c(ch8_ink,ch8_blue),bty='n',cex=.78,y.intersp=1.6,inset=c(0,-.02))
},width=8.8,height=3.8)
ch8_draw('korelace-rozdily', {
  layout(matrix(1:4,1),widths=c(1.35,1,1,1)); par(mar=c(4.6,4.6,3.4,.6))
  rr <- seq(-1,1,by=.01)
  plot(rr,ch8_sd_rozdilu(rr),type='l',lwd=2.4,col=ch8_blue,xlab='Korelace obou měření r',ylab='Směrodatná odchylka rozdílů (body)',
       main='SD rozdílů podle korelace',bty='l',ylim=c(0,14.5))
  pts <- c(0,ch8_par_r); points(pts,ch8_sd_rozdilu(pts),pch=21,bg=c('white',ch8_orange),col=ch8_ink,cex=1.4)
  text(0,ch8_sd_rozdilu(0)+1.1,paste0('r = 0: ',ch8_num(ch8_sd_rozdilu(0))),cex=.8)
  text(ch8_par_r-.03,ch8_sd_rozdilu(ch8_par_r)+1.6,paste0('varianta A\nr = ',ch8_num(ch8_par_r,2),': ',ch8_num(ch8_sd_rozdilu(ch8_par_r))),adj=1,cex=.8,col=ch8_orange)
  for(i in seq_along(ch8_sim)) {
    u <- ch8_sim[[i]]; dd <- u$bezny-u$kratky
    plot(NA,xlim=c(.7,2.3),ylim=c(28,68),xaxt='n',xlab='',ylab=if(i==1) 'Skór pozornosti (body)' else '',
         main=paste0('r = ',ch8_num(cor(u$bezny,u$kratky),1),'; SD rozdílů ',ch8_num(sd(dd),1)),bty='l')
    axis(1,at=1:2,labels=c('běžný','krátký'))
    segments(1,u$bezny,2,u$kratky,col=adjustcolor(ch8_blue,.75),lwd=1.6)
    points(rep(1,12),u$bezny,pch=21,bg=ch8_fill,col=ch8_ink,cex=1.05); points(rep(2,12),u$kratky,pch=21,bg=ch8_sand,col=ch8_ink,cex=1.05)
  }
},width=11.4,height=4.4)
ch8_draw('pomer-skupin', {
  # Two panels per row at most: the equal-sigma panel centred on top, the unequal-sigma panels below.
  layout(matrix(c(0,1,1,0,2,2,3,3),2,byrow=TRUE)); par(mar=c(5.6,5,3.4,1),cex=1)
  x <- seq_len(nrow(ch8_pomer)); pm <- ch8_pomer
  panel <- function(main,se,se_pool=NULL) {
    plot(NA,xlim=c(.6,max(x)+.4),ylim=c(0,7.2),xaxt='n',xlab='',ylab='Směrodatná chyba rozdílu průměrů (body)',main=main,bty='l',cex.main=1.05)
    axis(1,at=x,labels=ch8_pomer_lab,padj=.5,cex.axis=.9,gap.axis=-1); mtext('Poměr velikostí skupin (celkem 90 lidí)',1,4.1,cex=.9)
    up <- if(is.null(se_pool)) rep(TRUE,length(x)) else se>=se_pool-1e-9  # label the higher point above, the lower below
    # Labels above a point sit closer than labels below it, which would otherwise touch the descending lines.
    off_above <- .48; off_below <- -.78
    if(!is.null(se_pool)) { lines(x,se_pool,lwd=2.2,lty=2,col=ch8_gray,type='b',pch=4,cex=1.2); text(x,se_pool+ifelse(up,off_below,off_above),ch8_num(se_pool),cex=.9,col=ch8_gray) }
    # The true standard error keeps one colour and line type in every panel.
    lines(x,se,lwd=2.6,col=ch8_orange,type='b',pch=21,bg='white',cex=1.4); text(x,se+ifelse(up,off_above,off_below),ch8_num(se),cex=.9,col=ch8_orange)
  }
  leg <- function() legend('bottomright',inset=c(0,.02),c('skutečná směrodatná chyba','podle společného odhadu rozptylu'),col=c(ch8_orange,ch8_gray),lty=c(1,2),pch=c(21,4),lwd=c(2.6,2.2),bty='n',cex=.9)
  panel('Stejné σ = 10 v obou populacích',pm$se_shodne)
  # With equal sigmas the pooled-variance value equals the true standard error.
  legend('topleft','skutečná směrodatná chyba\n(podle společného odhadu rozptylu)',col=ch8_orange,lty=1,pch=21,lwd=2.6,bty='n',cex=.9)
  panel('Menší skupina σ = 20, větší σ = 10',pm$se_mala_var,pm$se_mala_var_pool); leg()
  panel('Větší skupina σ = 20, menší σ = 10',pm$se_velka_var,pm$se_velka_var_pool); leg()
},width=9,height=8.4)
ch8_draw('welch-stupne', {
  par(mar=c(5.6,4.9,3,1))
  x <- seq_len(nrow(ch8_pomer)); pm <- ch8_pomer; dfmax <- sum(pm$n1[1],pm$n2[1])-2
  # Distinct hues and point shapes, so the three Welch lines do not rely on colour alone.
  cols <- c(ch8_green,ch8_orange,'#3A8FB7'); pchs <- c(21,22,24)
  plot(NA,xlim=c(.6,max(x)+.4),ylim=c(0,dfmax+6),xaxt='n',xlab='',ylab='Stupně volnosti',main='Welchovy stupně volnosti (celkem 90 lidí)',bty='l')
  axis(1,at=x,labels=ch8_pomer_lab,padj=.5,cex.axis=.9,gap.axis=-1); mtext('Poměr velikostí skupin',1,4.1,cex=.9)
  abline(h=dfmax,lty=2,col=ch8_gray); text(max(x)+.4,dfmax+3,bquote(n[1]+n[2]-2==.(dfmax)),adj=1,cex=.85,col=ch8_gray)
  lines(x,pmin(pm$n1,pm$n2)-1,lty=3,lwd=2,col=ch8_gray,type='b',pch=20)
  ys <- list(pm$df_shodne,pm$df_mala_var,pm$df_velka_var)
  for(k in 1:3) lines(x,ys[[k]],lwd=2.6,col=cols[k],type='b',pch=pchs[k],bg='white',cex=1.3)
  legend('bottomleft',c('stejné σ','menší skupina dvakrát variabilnější','větší skupina dvakrát variabilnější','stupně volnosti menší skupiny'),
         col=c(cols,ch8_gray),lty=c(1,1,1,3),pch=c(pchs,20),pt.bg='white',lwd=c(2.6,2.6,2.6,2),bty='n',cex=.85,inset=c(.01,.01))
},width=8.4,height=5)
# Exercise 3: Q-Q plot of the differences with the plotting positions of chapter 4.
ch8_qq_y <- sort(ch8_u03_d); ch8_qq_z <- qnorm((seq_along(ch8_qq_y)-.5)/length(ch8_qq_y))
ch8_draw('qq-rozdily', {
  plot(ch8_qq_z,ch8_qq_y,xlab='Teoretický kvantil normovaného normálního rozdělení',ylab='Seřazený rozdíl (ms)',
       main='Q–Q graf rozdílů reakčních dob',pch=21,bg=ch8_blue,col=ch8_ink,bty='l',cex=1.1)
  abline(a=mean(ch8_u03_d),b=sd(ch8_u03_d),col=ch8_orange,lwd=1.8)
  legend('topleft','Referenční přímka: m + s × z',col=ch8_orange,lwd=1.8,bty='n',cex=.85)
},width=8.6,height=4.6)
options(ch8_old_options)
