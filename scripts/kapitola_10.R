# Teaching data, calculations and figures for chapter 10 (correlation); base R, UTF-8, deterministic.
# All data are authored teaching models unless stated otherwise. Chapter 8 data are reused from
# scripts/sesity-data.mjs (paired sleep study and two independent groups); the chapter 9 table is reused.
# Resampling indices are generated here with fixed seeds and written to tmp/chapter-10-indices/
# for the workbook generator, so the book and the workbook use identical resamples.
ch10_out <- 'assets/chapter-10/plots'
ch10_old_options <- options(OutDec=',')
dir.create(ch10_out,recursive=TRUE,showWarnings=FALSE)
ch10_blue <- '#245D78'; ch10_orange <- '#B54E24'; ch10_fill <- '#B8DDE8'; ch10_gray <- '#4D5A63'; ch10_pale <- '#E1E8EB'
ch10_sand <- '#FAECDD'; ch10_ink <- '#223744'; ch10_mute <- '#A9BAC3'; ch10_green <- '#3E7B4F'
ch10_num <- function(x,digits=2) sub('^-','−',formatC(x,format='f',digits=digits,decimal.mark=','))
ch10_draw <- function(name,code,width=8,height=4.5) {
  # CH10_NOFIG=1 skips figures (workbook build); CH10_PNG=1 writes PNG copies to tmp/chapter-10-png/ for inspection only.
  if (nzchar(Sys.getenv('CH10_NOFIG'))) return(invisible(NULL))
  if (nzchar(Sys.getenv('CH10_PNG'))) { dir.create('tmp/chapter-10-png',recursive=TRUE,showWarnings=FALSE)
    png(file.path('tmp/chapter-10-png',paste0(name,'.png')),width=width,height=height,units='in',res=110,family='sans',bg='white') }
  else svg(file.path(ch10_out,paste0(name,'.svg')),width=width,height=height,family='sans',bg='white')
  par(mar=c(4.5,4.5,2.6,.8),mgp=c(2.7,.7,0),las=1,col.axis=ch10_ink,col.lab=ch10_ink,fg=ch10_ink,cex=.9)
  force(code); dev.off()
}
# Data and descriptions of the figures for the AI tutor (tmp/tutor-figures/kapitola_10/); see scripts/tutor/figure-data.R.
source('scripts/tutor/figure-data.R',encoding='UTF-8')
source('scripts/figure-labels.R',encoding='UTF-8')   # statistical symbols in the math font (R89)
ch10_fig <- function(...) tf_figure('kapitola_10',...)
# Procedures --------------------------------------------------------------------------------
ch10_cov <- function(x,y) sum((x-mean(x))*(y-mean(y)))/(length(x)-1)
ch10_r <- function(x,y) ch10_cov(x,y)/(sd(x)*sd(y))
ch10_rs <- function(x,y) { rx <- rank(x); ry <- rank(y); if (sd(rx)==0||sd(ry)==0) NA_real_ else ch10_r(rx,ry) }
# Kendall: concordant/discordant pairs, ties in x only, in y only and in both; tau_a and tau_b.
ch10_pairs <- function(x,y) {
  n <- length(x); i <- combn(n,2); sx <- sign(x[i[1,]]-x[i[2,]]); sy <- sign(y[i[1,]]-y[i[2,]])
  c(n=n,par=ncol(i),nc=sum(sx*sy>0),nd=sum(sx*sy<0),tx=sum(sx==0),ty=sum(sy==0),txy=sum(sx==0&sy==0))
}
ch10_tau <- function(x,y) { p <- ch10_pairs(x,y); n0 <- p[['par']]
  den <- sqrt((n0-p[['tx']])*(n0-p[['ty']]))
  c(p,S=p[['nc']]-p[['nd']],tau_a=(p[['nc']]-p[['nd']])/n0,tau_b=if (den==0) NA_real_ else (p[['nc']]-p[['nd']])/den) }
ch10_taub <- function(x,y) ch10_tau(x,y)[['tau_b']]
# Pearson inference: t test of rho = 0 and approximate Fisher interval.
ch10_pearson <- function(r,n,conf=.95) {
  t <- r*sqrt(n-2)/sqrt(1-r^2); z <- atanh(r); se <- 1/sqrt(n-3); q <- qnorm(1-(1-conf)/2)
  c(r=r,n=n,t=t,df=n-2,p=2*pt(-abs(t),n-2),zr=z,se=se,zq=q,z_dolni=z-q*se,z_horni=z+q*se,dolni=tanh(z-q*se),horni=tanh(z+q*se))
}
ch10_pctl <- function(v,a) quantile(v,a,type=7,na.rm=TRUE,names=FALSE)   # = PERCENTIL.INC
ch10_pperm <- function(v,obs) (sum(abs(v)>=abs(obs)-1e-12)+1)/(length(v)+1)
# 1. Hand example: six students, test anxiety (points) and test performance (points). -------------
ch10_m6 <- data.frame(id=1:6,uzkost=c(12,18,20,24,30,34),vykon=c(22,25,17,21,15,14))
ch10_m6_dx <- ch10_m6$uzkost-mean(ch10_m6$uzkost); ch10_m6_dy <- ch10_m6$vykon-mean(ch10_m6$vykon)
ch10_m6_cov <- ch10_cov(ch10_m6$uzkost,ch10_m6$vykon); ch10_m6_r <- ch10_r(ch10_m6$uzkost,ch10_m6$vykon)
ch10_m6_zx <- (ch10_m6$uzkost-mean(ch10_m6$uzkost))/sd(ch10_m6$uzkost); ch10_m6_zy <- (ch10_m6$vykon-mean(ch10_m6$vykon))/sd(ch10_m6$vykon)
ch10_m6_tau <- ch10_tau(ch10_m6$uzkost,ch10_m6$vykon); ch10_m6_rs <- ch10_rs(ch10_m6$uzkost,ch10_m6$vykon)
# 2. Main metric example: 40 students, anxiety 10-40 and performance 0-30 (authored model). --------
set.seed(1010)
ch10_n40 <- 40
local({
  z1 <- rnorm(ch10_n40); z2 <- -0.5*z1+sqrt(1-.25)*rnorm(ch10_n40)
  u <- pmin(40,pmax(10,round(25+6*z1))); v <- pmin(30,pmax(0,round(18+5*z2)))
  ch10_uz <<- data.frame(id=1:ch10_n40,uzkost=u,vykon=v)
})
ch10_uz_r <- ch10_r(ch10_uz$uzkost,ch10_uz$vykon); ch10_uz_inf <- ch10_pearson(ch10_uz_r,ch10_n40)
ch10_uz_rs <- ch10_rs(ch10_uz$uzkost,ch10_uz$vykon); ch10_uz_tb <- ch10_taub(ch10_uz$uzkost,ch10_uz$vykon)
ch10_uz_400 <- ch10_pearson(round(ch10_uz_r,2),400)
# 3. Ordinal example with many ties: 30 students, perceived stress 0-16 and sleep quality 1-7. -----
# Identical to the documented prototype (scripts/kapitola_10-prototyp-prevzorkovani.R).
set.seed(20261109)
local({
  n <- 30; latent <- rnorm(n)
  stress <- pmin(16,pmax(0,round(8+3*latent+rnorm(n,0,2))))
  sleep <- pmin(7,pmax(1,round(4-.9*latent+rnorm(n,0,1.1))))
  ch10_ss <<- data.frame(id=1:n,stres=stress,spanek=sleep)
  ch10_boot_idx <<- t(replicate(9999,sample.int(n,n,replace=TRUE)))
  ch10_perm_idx <<- t(replicate(9999,sample.int(n,n)))
})
ch10_ss_r <- ch10_r(ch10_ss$stres,ch10_ss$spanek); ch10_ss_rs <- ch10_rs(ch10_ss$stres,ch10_ss$spanek)
ch10_ss_tau <- ch10_tau(ch10_ss$stres,ch10_ss$spanek)
ch10_resample <- function(x,y,boot,perm,B) {
  bt <- t(apply(boot[1:B,,drop=FALSE],1,function(i) c(ch10_rs(x[i],y[i]),ch10_taub(x[i],y[i]))))
  pm <- t(apply(perm[1:B,,drop=FALSE],1,function(i) c(ch10_rs(x,y[i]),ch10_taub(x,y[i]))))
  list(bt=bt,pm=pm,B=B,
       rs_ci=c(ch10_pctl(bt[,1],.025),ch10_pctl(bt[,1],.975)),tb_ci=c(ch10_pctl(bt[,2],.025),ch10_pctl(bt[,2],.975)),
       na=colSums(is.na(bt)),rs_p=ch10_pperm(pm[,1],ch10_rs(x,y)),tb_p=ch10_pperm(pm[,2],ch10_taub(x,y)))
}
ch10_ss_1999 <- ch10_resample(ch10_ss$stres,ch10_ss$spanek,ch10_boot_idx,ch10_perm_idx,1999)
ch10_ss_9999 <- ch10_resample(ch10_ss$stres,ch10_ss$spanek,ch10_boot_idx,ch10_perm_idx,9999)
# 4. Small ordinal example with ties for the full tau_b calculation and an exact permutation test. ---
ch10_t6 <- data.frame(id=1:6,stres=c(3,5,5,8,10,12),spanek=c(6,6,4,5,3,3))
ch10_t6_tau <- ch10_tau(ch10_t6$stres,ch10_t6$spanek); ch10_t6_rs <- ch10_rs(ch10_t6$stres,ch10_t6$spanek)
ch10_perms <- function(v) if (length(v)==1) matrix(v,1) else do.call(rbind,lapply(seq_along(v),function(i) cbind(v[i],ch10_perms(v[-i]))))
ch10_perm6 <- ch10_perms(1:6)
ch10_t6_pm <- t(apply(ch10_perm6,1,function(i) c(ch10_rs(ch10_t6$stres,ch10_t6$spanek[i]),ch10_taub(ch10_t6$stres,ch10_t6$spanek[i]))))
ch10_t6_p <- c(rs=mean(abs(ch10_t6_pm[,1])>=abs(ch10_t6_rs)-1e-12),tb=mean(abs(ch10_t6_pm[,2])>=abs(ch10_t6_tau[['tau_b']])-1e-12))
# 5. Chapter 8: paired sleep study (12 complete pairs) and two independent groups (30 and 12). -------
ch10_k8 <- data.frame(id=c(1:8,10:13),bezny=c(58,44,51,39,62,47,55,42,49,60,45,52),kratky=c(53,42,45,38,55,44,51,43,44,58,39,50))
ch10_k8_r <- ch10_r(ch10_k8$bezny,ch10_k8$kratky); ch10_k8_sd <- c(sd(ch10_k8$bezny),sd(ch10_k8$kratky),sd(ch10_k8$bezny-ch10_k8$kratky))
ch10_k8_sd_vzorec <- sqrt(ch10_k8_sd[1]^2+ch10_k8_sd[2]^2-2*ch10_k8_r*ch10_k8_sd[1]*ch10_k8_sd[2])
ch10_k8_sd_nez <- sqrt(ch10_k8_sd[1]^2+ch10_k8_sd[2]^2)    # what the SD of differences would be with r = 0
ch10_g1 <- c(67,55,54,46,43,41,57,41,54,44,40,47,41,51,45,47,62,44,49,54,69,36,56,49,51,53,58,53,52,41)
ch10_g2 <- c(52,55,23,59,36,51,24,56,28,34,56,30)
ch10_rpb_x <- c(rep(0,length(ch10_g1)),rep(1,length(ch10_g2))); ch10_rpb_y <- c(ch10_g1,ch10_g2)
ch10_rpb <- ch10_r(ch10_rpb_x,ch10_rpb_y)
ch10_rpb_t <- t.test(ch10_g1,ch10_g2,var.equal=TRUE)$statistic[[1]]
ch10_rpb_df <- length(ch10_rpb_y)-2
ch10_phi_x <- c(rep(1,100),rep(0,100)); ch10_phi_y <- c(rep(1,40),rep(0,60),rep(1,30),rep(0,70)) # women = 1; elevated stress = 1
ch10_phi <- ch10_r(ch10_phi_x,ch10_phi_y)
ch10_r_to_d <- function(r,n1,n2) { h <- (n1+n2-2)*(1/n1+1/n2); r*sqrt(h)/sqrt(1-r^2) }
# 6. Reliability and validity contexts (summaries only). -------------------------------------
ch10_rel <- ch10_pearson(.82,50); ch10_val <- ch10_pearson(.38,92)
# Two raters: high correlation, systematic offset (no agreement in values).
ch10_rat <- data.frame(id=1:8,A=c(12,15,9,18,14,11,16,13)); ch10_rat$B <- ch10_rat$A+4+c(0,1,-1,0,1,0,-1,0)
ch10_rat_r <- ch10_r(ch10_rat$A,ch10_rat$B)
# 7. Forms of relationship, same r, factors (simulated teaching models for figures). -------------
set.seed(2010)
local({
  n <- 60; x <- runif(n,0,10)
  ch10_forms <<- list(
    kladny=data.frame(x=x,y=2+.6*x+rnorm(n,0,1.3)),
    zaporny=data.frame(x=x,y=9-.6*x+rnorm(n,0,1.3)),
    monotonni=data.frame(x=x,y=10-9*exp(-.45*x)+rnorm(n,0,.45)),
    obraceneU=data.frame(x=x,y=8-.3*(x-5)^2+rnorm(n,0,.9)),
    odlehly=rbind(data.frame(x=x[1:29],y=5+rnorm(29,0,1.5)),data.frame(x=25,y=16)),
    skupiny=rbind(data.frame(x=runif(30,1,4),y=rnorm(30,3,1)),data.frame(x=runif(30,6,9),y=rnorm(30,8,1))))
})
ch10_forms_r <- sapply(ch10_forms,function(d) c(r=ch10_r(d$x,d$y),rs=ch10_rs(d$x,d$y)))
# Monotone curved relationship: practice (hours) and reaction time (ms) for Pearson vs Spearman.
set.seed(3010)
ch10_rt <- local({ h <- sort(round(runif(25,0,20),1)); data.frame(hodiny=h,ms=round(320+260*exp(-.25*h)+rnorm(25,0,12))) })
ch10_rt_r <- ch10_r(ch10_rt$hodiny,ch10_rt$ms); ch10_rt_rs <- ch10_rs(ch10_rt$hodiny,ch10_rt$ms); ch10_rt_tb <- ch10_taub(ch10_rt$hodiny,ch10_rt$ms)
# Range restriction: admission test and first-year results, 200 applicants, top 30 % admitted.
set.seed(4010)
ch10_rr <- local({ z1 <- rnorm(200); z2 <- .6*z1+.8*rnorm(200); data.frame(test=round(100+15*z1),prospech=round(60+12*z2)) })
ch10_rr_cut <- quantile(ch10_rr$test,.7,type=7,names=FALSE)
ch10_rr_r <- c(vse=ch10_r(ch10_rr$test,ch10_rr$prospech),prijati=with(subset(ch10_rr,test>=ch10_rr_cut),ch10_r(test,prospech)),
  extremy=with(subset(ch10_rr,test<=quantile(ch10_rr$test,.15)|test>=quantile(ch10_rr$test,.85)),ch10_r(test,prospech)))
# Combined groups: vocabulary and reading speed in two classes (8- and 11-year-olds).
set.seed(5010)
ch10_cg <- local({ a <- data.frame(trida='mladší',slova=round(rnorm(25,40,6)),rychlost=round(rnorm(25,60,10)))
  b <- data.frame(trida='starší',slova=round(rnorm(25,62,6)),rychlost=round(rnorm(25,95,10))); rbind(a,b) })
ch10_cg_r <- c(vse=ch10_r(ch10_cg$slova,ch10_cg$rychlost),
  mladsi=with(subset(ch10_cg,trida=='mladší'),ch10_r(slova,rychlost)),starsi=with(subset(ch10_cg,trida=='starší'),ch10_r(slova,rychlost)))
# Outlier example on the hand data: one mistyped value.
ch10_out_r <- local({ d <- ch10_uz; d$vykon[1] <- 300; c(r=ch10_r(d$uzkost,d$vykon),rs=ch10_rs(d$uzkost,d$vykon)) })
# 8. Sampling distribution of r: 10 000 samples of n = 20 from bivariate normal populations. ---------
set.seed(6010)
ch10_sim_r <- sapply(c(0,.8),function(rho) replicate(10000,{ x <- rnorm(20); y <- rho*x+sqrt(1-rho^2)*rnorm(20); ch10_r(x,y) }))
colnames(ch10_sim_r) <- c('rho0','rho08')
ch10_sim_sum <- apply(ch10_sim_r,2,function(v) c(prumer=mean(v),q025=ch10_pctl(v,.025),q975=ch10_pctl(v,.975),podil_nad=mean(v>.5)))
ch10_write_exports <- function(dir='tmp/chapter-10-indices') {
  # Data sets, fixed resampling indices and the 9 999-repetition results for the workbook generator.
  dir.create(dir,recursive=TRUE,showWarnings=FALSE)
  w <- function(x,name,header=TRUE) write.table(x,file.path(dir,name),sep=',',row.names=FALSE,col.names=header,quote=FALSE,fileEncoding='UTF-8')
  w(ch10_boot_idx[1:1999,],'boot_idx.csv',FALSE); w(ch10_perm_idx[1:1999,],'perm_idx.csv',FALSE); w(ch10_perm6,'perm6_idx.csv',FALSE)
  w(ch10_m6,'m6.csv'); w(ch10_uz,'uz.csv'); w(ch10_ss,'ss.csv'); w(ch10_t6,'t6.csv'); w(ch10_k8,'k8.csv')
  w(data.frame(kod=ch10_rpb_x,skor=ch10_rpb_y),'rpb.csv'); w(ch10_rat,'rat.csv')
  w(ch10_u03,'u03.csv'); w(ch10_u05,'u05.csv'); w(ch10_u06,'u06.csv'); w(ch10_u07,'u07.csv'); w(ch10_u08,'u08.csv'); w(ch10_u12,'u12.csv'); w(ch10_u16,'u16.csv')
  r9 <- ch10_ss_9999
  w(data.frame(udaj=c('rs_dolni','rs_horni','tb_dolni','tb_horni','rs_p','tb_p','nedefinovane'),
               hodnota=c(r9$rs_ci,r9$tb_ci,r9$rs_p,r9$tb_p,sum(r9$na))),'vysledky_9999.csv')
}
# 10. Optional BCa interval for the example (B = 1 999): bias correction z0 and jackknife acceleration a.
ch10_bca <- function(x,y,stat,boot,obs) {
  n <- length(x); z0 <- qnorm(mean(boot<obs))
  jk <- sapply(seq_len(n),function(i) stat(x[-i],y[-i])); d <- mean(jk)-jk
  a <- sum(d^3)/(6*sum(d^2)^1.5)
  al <- sapply(qnorm(c(.025,.975)),function(zq) pnorm(z0+(z0+zq)/(1-a*(z0+zq))))
  c(z0=z0,a=a,alfa1=al[1],alfa2=al[2],dolni=ch10_pctl(boot,al[1]),horni=ch10_pctl(boot,al[2]))
}
ch10_bca_rs <- ch10_bca(ch10_ss$stres,ch10_ss$spanek,ch10_rs,ch10_ss_1999$bt[,1],ch10_ss_rs)
ch10_bca_tb <- ch10_bca(ch10_ss$stres,ch10_ss$spanek,ch10_taub,ch10_ss_1999$bt[,2],ch10_ss_tau[['tau_b']])
# 11. Exercises. -----------------------------------------------------------------------------------
ch10_u03 <- data.frame(id=1:5,spanek=c(5,6,7,8,9),chyby=c(9,7,8,4,2))
ch10_u03_cov <- ch10_cov(ch10_u03$spanek,ch10_u03$chyby); ch10_u03_r <- ch10_r(ch10_u03$spanek,ch10_u03$chyby)
ch10_u05 <- data.frame(esej=LETTERS[1:7],A=1:7,B=c(2,1,4,3,7,5,6)); ch10_u05_rs <- ch10_rs(ch10_u05$A,ch10_u05$B)
ch10_u06 <- data.frame(id=1:8,zajem=c(2,4,4,5,3,1,4,5),hodiny=c(3,6,4,9,5,2,12,7))
ch10_u06_rs <- ch10_rs(ch10_u06$zajem,ch10_u06$hodiny); ch10_u06_r <- ch10_r(ch10_u06$zajem,ch10_u06$hodiny)
ch10_u07 <- data.frame(id=1:5,X=1:5,Y=c(2,1,3,5,4)); ch10_u07_tau <- ch10_tau(ch10_u07$X,ch10_u07$Y)
ch10_u08 <- data.frame(id=1:6,stres=c(2,4,4,6,9,9),spanek=c(5,5,3,4,2,3)); ch10_u08_tau <- ch10_tau(ch10_u08$stres,ch10_u08$spanek)
ch10_u09 <- ch10_pearson(.32,60)
ch10_u10 <- rbind(n50=ch10_pearson(.15,50),n1000=ch10_pearson(.15,1000),retest=ch10_pearson(.78,40))
ch10_u11_dist <- table(apply(ch10_perms(1:4),1,function(i) round(ch10_tau(1:4,(1:4)[i])[['tau_a']],4)))
set.seed(11010)
ch10_u12 <- local({ n <- 30; z <- rnorm(n)
  opora <- pmin(25,pmax(5,round(16+3.5*z+rnorm(n,0,2.5)))); osam <- pmin(20,pmax(0,round(9-1.6*z+rnorm(n,0,3.2))))
  data.frame(id=1:n,opora=opora,osamelost=osam) })
ch10_u12_rs <- ch10_rs(ch10_u12$opora,ch10_u12$osamelost); ch10_u12_tau <- ch10_tau(ch10_u12$opora,ch10_u12$osamelost)
ch10_u12_res <- ch10_resample(ch10_u12$opora,ch10_u12$osamelost,ch10_boot_idx,ch10_perm_idx,1999)
set.seed(16010)
ch10_u16 <- local({ n <- 40; z <- rnorm(n)
  minuty <- pmax(10,round(120+45*z+rnorm(n,0,25))); osam <- pmin(20,pmax(0,round(8+2.2*z+rnorm(n,0,2.6))))
  minuty[17] <- 900; osam[17] <- 4
  data.frame(id=1:n,minuty=minuty,osamelost=osam) })
ch10_u16_r <- ch10_r(ch10_u16$minuty,ch10_u16$osamelost); ch10_u16_rs <- ch10_rs(ch10_u16$minuty,ch10_u16$osamelost)
ch10_u16_bez <- with(ch10_u16[-17,],c(r=ch10_r(minuty,osamelost),rs=ch10_rs(minuty,osamelost)))
ch10_u16_inf <- ch10_pearson(ch10_u16_r,40); ch10_u16_inf_bez <- ch10_pearson(ch10_u16_bez[['r']],39)
ch10_u16_tb <- ch10_taub(ch10_u16$minuty,ch10_u16$osamelost)
# Optional: two independent correlations (Cumming and Calin-Jageman 2024, s. 338-339).
ch10_u18 <- local({ z1 <- atanh(.41); z2 <- atanh(.53); se <- sqrt(1/(59-3)+1/(47-3)); z <- (z1-z2)/se
  c(z1=z1,z2=z2,se=se,z=z,p=2*pnorm(-abs(z))) })
# 12. Correlation matrix with pairwise complete cases (reporting section): 120 students, four measures.
set.seed(12010)
ch10_mat_data <- local({ n <- 120; s <- rnorm(n)
  d <- data.frame(stres=round(8+3*s+rnorm(n,0,2)),spanek=round(4-.8*s+rnorm(n,0,1.1),1),uzkost=round(23+4*s+rnorm(n,0,4)),vykon=round(19-1.5*s+rnorm(n,0,4)))
  d$spanek[sample(n,9)] <- NA; d$vykon[sample(n,14)] <- NA; d$stres[sample(n,4)] <- NA; d })
ch10_mat_r <- cor(ch10_mat_data,use='pairwise.complete.obs')
ch10_mat_n <- crossprod(!is.na(as.matrix(ch10_mat_data)))
ch10_write_exports()
# 9. Same r, different shapes: Anscombe's (1973) quartet, real published data (datasets::anscombe, n = 11 each).
# Replaces the authored four data sets tuned to r = 0.60 (revision 2026-11-20, R84).
ch10_same <- lapply(1:4,function(k) data.frame(x=datasets::anscombe[[paste0('x',k)]],y=datasets::anscombe[[paste0('y',k)]]))
names(ch10_same) <- c('linearni','zakriveny','odlehly_y','odlehly_x')
ch10_same_r <- sapply(ch10_same,function(d) ch10_r(d$x,d$y))
# 13. Revision 2026-11-20 (R84): further teaching models and summaries. Each block has its own seed and runs
# after ch10_write_exports(), so earlier values and the workbook exports stay unchanged.
# 13a. Fisher transformation of the simulated sampling distribution (rho = 0.8, n = 20) from section 8.
ch10_fisher_sim <- c(sd_z=sd(atanh(ch10_sim_r[,'rho08'])),prumer_z=mean(atanh(ch10_sim_r[,'rho08'])),se=1/sqrt(17),zrho=atanh(.8))
ch10_skew <- function(v) mean((v-mean(v))^3)/sd(v)^3
ch10_fisher_skew <- c(r=ch10_skew(ch10_sim_r[,'rho08']),z=ch10_skew(atanh(ch10_sim_r[,'rho08'])))
# 13b. Exact permutation test for six students: selected reassignments for the illustration table.
ch10_t6_ukazka_idx <- rbind(pozorovano=1:6,a=c(1,2,4,3,5,6),b=c(1,3,5,4,6,2),c=c(1,5,6,3,4,2))
ch10_t6_ukazka <- t(apply(ch10_t6_ukazka_idx,1,function(i) c(ch10_t6$spanek[i],rs=ch10_rs(ch10_t6$stres,ch10_t6$spanek[i]),tb=ch10_taub(ch10_t6$stres,ch10_t6$spanek[i]))))
ch10_t6_dist <- table(round(ch10_t6_pm[,2],3))
# 13c. Three kinds of outlying observation added to one base cloud of 20 points.
set.seed(13010)
ch10_otypes <- local({ n <- 20; x <- rnorm(n,50,10); y <- 50+.6*(x-50)+rnorm(n,0,8)
  base <- data.frame(x=round(x),y=round(y))
  list(zaklad=base,krajni_x=rbind(base,data.frame(x=100,y=80)),kombinace=rbind(base,data.frame(x=68,y=36)),
       obe=rbind(base,data.frame(x=100,y=20))) })
ch10_otypes_stat <- sapply(ch10_otypes,function(d) c(r=ch10_r(d$x,d$y),rs=ch10_rs(d$x,d$y),tb=ch10_taub(d$x,d$y)))
ch10_otypes_z <- sapply(ch10_otypes[-1],function(d) { b <- ch10_otypes$zaklad; k <- nrow(d)
  c(zx=(d$x[k]-mean(b$x))/sd(b$x),zy=(d$y[k]-mean(b$y))/sd(b$y)) })
# 13d. Measurement error: true scores (rho = 0.6) and observed scores with reliability 0.6 in both variables.
set.seed(14010)
ch10_rel_sim <- local({ n <- 200; tx <- rnorm(n); ty <- .6*tx+.8*rnorm(n); sde <- sqrt(.4/.6)
  data.frame(tx=tx,ty=ty,x=tx+sde*rnorm(n),y=ty+sde*rnorm(n)) })
ch10_rel_sim_r <- c(prave=ch10_r(ch10_rel_sim$tx,ch10_rel_sim$ty),namerene=ch10_r(ch10_rel_sim$x,ch10_rel_sim$y),
  rel_x=ch10_r(ch10_rel_sim$tx,ch10_rel_sim$x)^2,rel_y=ch10_r(ch10_rel_sim$ty,ch10_rel_sim$y)^2)
ch10_attenuace <- function(r,rxx,ryy) r/sqrt(rxx*ryy)
ch10_rel_opr <- ch10_attenuace(round(ch10_rel_sim_r[['namerene']],2),.6,.6)
ch10_rel_vic <- ch10_attenuace(.65,.81,.49)   # Muchinsky (1996, p. 68): corrected value above 1
# 13g. Overplotting (R86): 500 students, sleep quality and daytime fatigue, both on a 1-7 scale.
# The jitter (uniform, half-widths 0.2 and 0.45) is drawn here with its own seed so that the figure
# and the tutor data use identical positions; the coefficient is computed from the original values.
set.seed(15010)
ch10_ov <- local({ n <- 500; z <- rnorm(n)
  data.frame(spanek=pmin(7,pmax(1,round(4.3+1.2*z+rnorm(n,0,1)))),unava=pmin(7,pmax(1,round(3.9-.9*z+rnorm(n,0,1.3))))) })
ch10_ov_r <- ch10_r(ch10_ov$spanek,ch10_ov$unava)
ch10_ov_cells <- nrow(unique(ch10_ov))
ch10_ov_jit <- local({ n <- nrow(ch10_ov); ux <- runif(n,-1,1); uy <- runif(n,-1,1)
  list(maly=data.frame(x=ch10_ov$spanek+.2*ux,y=ch10_ov$unava+.2*uy),velky=data.frame(x=ch10_ov$spanek+.45*ux,y=ch10_ov$unava+.45*uy)) })
# 13e. Point-biserial correlation as a function of d for three splits of 42 people (optional extension).
ch10_rpb_d <- function(d,n1,n2) { h <- (n1+n2-2)*(1/n1+1/n2); d/sqrt(d^2+h) }
ch10_rpb_h <- c(stejne=40*(1/21+1/21),k8=40*(1/30+1/12),nerovne=40*(1/38+1/4))
# 13f. Correlation matrix: Fisher intervals and p-values for every pair (pairwise complete cases).
ch10_mat_inf <- local({ v <- colnames(ch10_mat_data); out <- NULL
  for (j in 1:3) for (i in (j+1):4) { n <- ch10_mat_n[i,j]; p <- ch10_pearson(ch10_mat_r[i,j],n)
    out <- rbind(out,data.frame(radek=v[i],sloupec=v[j],n=n,r=p[['r']],dolni=p[['dolni']],horni=p[['horni']],p=p[['p']])) }
  out })
ch10_stars <- function(p) ifelse(p<.001,'***',ifelse(p<.01,'**',ifelse(p<.05,'*','')))
# Figures -------------------------------------------------------------------------------------------
ch10_quadrants <- function(x,y,lab=TRUE) {
  abline(v=mean(x),h=mean(y),lty=2,col=ch10_gray)
  u <- par('usr'); if (lab) {
    text(u[2],u[4],'X i Y nad průměrem\nsoučin kladný',adj=c(1.05,1.25),cex=.72,col=ch10_blue)
    text(u[1],u[3],'X i Y pod průměrem\nsoučin kladný',adj=c(-.05,-.35),cex=.72,col=ch10_blue)
    text(u[2],u[3],'X nad, Y pod průměrem\nsoučin záporný',adj=c(1.05,-.35),cex=.72,col=ch10_orange)
    text(u[1],u[4],'X pod, Y nad průměrem\nsoučin záporný',adj=c(-.05,1.25),cex=.72,col=ch10_orange) }
}
ch10_draw('kvadranty', {
  par(mar=c(4.6,4.7,2.8,.8)); d <- ch10_m6
  plot(d$uzkost,d$vykon,xlim=c(8,38),ylim=c(11,28),pch=21,bg=ifelse(ch10_m6_dx*ch10_m6_dy>0,ch10_blue,ch10_orange),col=ch10_ink,cex=1.6,
       xlab='Úzkost před testem X (body)',ylab='Výkon v testu Y (body)',main='Šest studentů: součiny odchylek od průměrů',bty='l')
  ch10_quadrants(d$uzkost,d$vykon)
  text(d$uzkost,d$vykon,paste0('student ',d$id,': ',ch10_num(ch10_m6_dx*ch10_m6_dy,0)),pos=c(4,4,4,4,2,2),cex=.76)
  text(mean(d$uzkost),11.3,'průměr X = 23',pos=4,cex=.72,col=ch10_gray); text(37.5,mean(d$vykon),'průměr Y = 19',adj=c(1,-.4),cex=.72,col=ch10_gray)
},width=8.6,height=5)
ch10_fig('kvadranty','data',note='Body s kladným součinem odchylek jsou modré, se záporným oranžové; u každého bodu je popisek „student i: součin“. V rozích jsou popisky kvadrantů: vpravo nahoře a vlevo dole „součin kladný“, vpravo dole a vlevo nahoře „součin záporný“.',panels=list(
  tf_panel('Šest studentů: součiny odchylek od průměrů','bodový graf','Úzkost před testem X (body)','Výkon v testu Y (body)',xlim=c(8,38),ylim=c(11,28),
    guides=list(tf_guide('x',mean(ch10_m6$uzkost),'průměr X = 23'),tf_guide('y',mean(ch10_m6$vykon),'průměr Y = 19')),
    series=list(tf_series('Studenti',data.frame(student=ch10_m6$id,x=ch10_m6$uzkost,y=ch10_m6$vykon,soucin_odchylek=ch10_m6_dx*ch10_m6_dy))))))
ch10_uz_jit <- local({ set.seed(1); x <- jitter(ch10_uz$uzkost,.4); list(x=x,y=jitter(ch10_uz$vykon,.4)) })
ch10_draw('uzkost-vykon', {
  par(mar=c(4.6,4.7,2.8,.8)); d <- ch10_uz
  plot(ch10_uz_jit$x,ch10_uz_jit$y,pch=21,bg=ch10_fill,col=ch10_blue,cex=1.3,xlab='Úzkost před testem (body, 10–40)',ylab='Výkon v testu (body, 0–30)',
       main='',bty='l')
  fl_title(main=paste0('40 studentů: *r* = ',ch10_num(ch10_uz_r,2)))
  ch10_quadrants(d$uzkost,d$vykon,lab=FALSE)
},width=7.2,height=4.8)
ch10_fig('uzkost-vykon','data',note='Body jsou v obrázku nepatrně náhodně posunuty, aby se shodné dvojice nepřekrývaly; původní hodnoty jsou celé body. Přerušované čáry leží v průměrech obou proměnných.',panels=list(
  tf_panel(paste0('40 studentů: r = ',ch10_num(ch10_uz_r,2)),'bodový graf','Úzkost před testem (body, 10–40)','Výkon v testu (body, 0–30)',
    guides=list(tf_guide('x',mean(ch10_uz$uzkost),'průměr úzkosti'),tf_guide('y',mean(ch10_uz$vykon),'průměr výkonu')),
    series=list(tf_series('Studenti (vykreslené polohy)',data.frame(x=ch10_uz_jit$x,y=ch10_uz_jit$y),note='Původní celé hodnoty dostaneš zaokrouhlením.')))))
ch10_ov_titles <- c(puvodni=paste0('A: bez úpravy, *r* = ',ch10_num(ch10_ov_r),'\n500 studentů, ale jen ',ch10_ov_cells,' viditelných bodů'),
  jitter='B: jitter ±0,2\nhusté buňky splývají v plné skvrny',pruhlednost='C: jitter ±0,2 a průhlednost\nsytější barva = víc studentů',
  velky='D: jitter ±0,45 a průhlednost\nsousední hodnoty splývají')
ch10_draw('prekryvani', {
  par(mfrow=c(2,2),mar=c(4.2,4.4,3.6,.8),mgp=c(2.4,.6,0))
  pan <- function(x,y,k,...) { plot(x,y,xlim=c(.4,7.6),ylim=c(.4,7.6),xaxt='n',yaxt='n',bty='l',xlab='Kvalita spánku (1–7)',ylab='Únava během dne (1–7)',
    main='',...); fl_title(main=ch10_ov_titles[[k]],cex.main=.92,font.main=1); axis(1,at=1:7); axis(2,at=1:7) }
  u <- unique(ch10_ov)   # opaque identical points look the same once drawn; keeps the SVG smaller
  pan(u$spanek,u$unava,'puvodni',pch=21,bg=ch10_fill,col=ch10_blue,cex=1.1)
  pan(ch10_ov_jit$maly$x,ch10_ov_jit$maly$y,'jitter',pch=21,bg=ch10_fill,col=ch10_blue,cex=1.1)
  pan(ch10_ov_jit$maly$x,ch10_ov_jit$maly$y,'pruhlednost',pch=16,col=adjustcolor(ch10_blue,.25),cex=1.1)
  pan(ch10_ov_jit$velky$x,ch10_ov_jit$velky$y,'velky',pch=16,col=adjustcolor(ch10_blue,.25),cex=1.1)
},width=8.6,height=8)
ch10_fig('prekryvani','simulace',note=paste0('Mřížka 2 × 2 se stejnými osami: A vlevo nahoře, B vpravo nahoře, C vlevo dole, D vpravo dole. V A jsou původní celé hodnoty (',ch10_ov_cells,' různých dvojic z 49 možných), v B až D tytéž hodnoty náhodně posunuté; C a D mají poloprůhledné body.'),panels=local({
  tab <- as.data.frame(table(ch10_ov$spanek,ch10_ov$unava)); tab <- tab[tab$Freq>0,]
  list(
    tf_panel(sub('\n',', ',fl_plain(ch10_ov_titles[['puvodni']]),fixed=TRUE),'bodový graf','Kvalita spánku (1–7)','Únava během dne (1–7)',xlim=c(.4,7.6),ylim=c(.4,7.6),
      series=list(tf_series('Dvojice hodnot',data.frame(x=as.numeric(as.character(tab$Var1)),y=as.numeric(as.character(tab$Var2)),pocet_studentu=tab$Freq),
        note='V grafu je každá dvojice jedním bodem; počet studentů v grafu vidět není.'))),
    tf_panel(sub('\n',', ',ch10_ov_titles[['jitter']],fixed=TRUE),'bodový graf','Kvalita spánku (1–7)','Únava během dne (1–7)',xlim=c(.4,7.6),ylim=c(.4,7.6),
      note='Stejné hodnoty jako v panelu A, každý bod posunut nejvýš o 0,2 v obou směrech; počty studentů v jednotlivých dvojicích jsou v panelu A.',
      series=list(tf_series('Vykreslené polohy (prvních 60 z 500)',head(ch10_ov_jit$maly,60)))),
    tf_panel(sub('\n',', ',ch10_ov_titles[['pruhlednost']],fixed=TRUE),'bodový graf','Kvalita spánku (1–7)','Únava během dne (1–7)',xlim=c(.4,7.6),ylim=c(.4,7.6),
      note='Stejné polohy jako v panelu B, body poloprůhledné (krytí 25 %); nejsytější jsou buňky s nejvíce studenty.',
      series=list(tf_series('Vykreslené polohy (prvních 60 z 500)',head(ch10_ov_jit$maly,60)))),
    tf_panel(sub('\n',', ',ch10_ov_titles[['velky']],fixed=TRUE),'bodový graf','Kvalita spánku (1–7)','Únava během dne (1–7)',xlim=c(.4,7.6),ylim=c(.4,7.6),
      note='Posunutí nejvýš o 0,45, takže body sousedních hodnot na sebe téměř navazují a mřížka celých hodnot mizí.',
      series=list(tf_series('Vykreslené polohy (prvních 60 z 500)',head(ch10_ov_jit$velky,60))))) }))
ch10_form_titles <- c(kladny='Kladný lineární',zaporny='Záporný lineární',monotonni='Monotónní, zakřivený',obraceneU='Obrácené U',odlehly='Jedno odlehlé pozorování',skupiny='Dvě oddělené skupiny')
ch10_draw('tvary', {
  par(mfrow=c(2,3),mar=c(3,3,3.6,.6),mgp=c(1.6,.5,0))
  for (k in names(ch10_forms)) { d <- ch10_forms[[k]]
    plot(d$x,d$y,pch=21,bg=ch10_fill,col=ch10_blue,cex=1.05,xlab='X',ylab='Y',xaxt='n',yaxt='n',bty='l',main='')
    title(main=ch10_form_titles[[k]],line=2.2,cex.main=.98,font.main=2)
    fl_title(main=paste0('*r* = ',ch10_num(ch10_forms_r['r',k]),', *r*_{*s*} = ',ch10_num(ch10_forms_r['rs',k])),line=.8,cex.main=.92,font.main=1) }
},width=9,height=6.2)
ch10_fig('tvary','simulace',note='Šest panelů ve dvou řadách po třech; osy X a Y jsou bez číselných popisků.',panels=lapply(names(ch10_forms),function(k)
  tf_panel(paste0(ch10_form_titles[[k]],' (r = ',ch10_num(ch10_forms_r['r',k]),', r_s = ',ch10_num(ch10_forms_r['rs',k]),')'),'bodový graf','X','Y',
    series=list(tf_series('Body',data.frame(x=ch10_forms[[k]]$x,y=ch10_forms[[k]]$y))))))
ch10_draw('stejne-r', {
  par(mfrow=c(1,4),mar=c(3.4,3.2,3.4,.5),mgp=c(1.9,.5,0))
  tt <- c(linearni='I: přibližně lineární',zakriveny='II: zakřivený',odlehly_y='III: jeden bod mimo přímku',odlehly_x='IV: jeden vzdálený bod')
  for (k in names(ch10_same)) { d <- ch10_same[[k]]
    plot(d$x,d$y,pch=21,bg=ch10_fill,col=ch10_blue,cex=1.3,xlab='X',ylab='Y',xlim=c(3,20),ylim=c(3,13),bty='l',
         main='')
    fl_title(main=paste0(tt[[k]],'\n*r* = ',ch10_num(ch10_same_r[[k]])),cex.main=.95,font.main=1) }
},width=10,height=3.5)
ch10_fig('stejne-r','data',note='Anscombův kvartet: čtyři panely vedle sebe se stejnými osami.',panels=lapply(names(ch10_same),function(k)
  tf_panel(paste0(c(linearni='I: přibližně lineární',zakriveny='II: zakřivený',odlehly_y='III: jeden bod mimo přímku',odlehly_x='IV: jeden vzdálený bod')[[k]],' (r = ',ch10_num(ch10_same_r[[k]]),')'),
    'bodový graf','X','Y',xlim=c(3,20),ylim=c(3,13),series=list(tf_series('Body',data.frame(x=ch10_same[[k]]$x,y=ch10_same[[k]]$y))))))
ch10_draw('stres-spanek', {
  par(mar=c(4.6,4.7,3,.8)); tab <- as.data.frame(table(ch10_ss$stres,ch10_ss$spanek)); tab <- tab[tab$Freq>0,]
  x <- as.numeric(as.character(tab$Var1)); y <- as.numeric(as.character(tab$Var2))
  plot(x,y,cex=1.2+1.1*(tab$Freq-1),pch=21,bg=ch10_fill,col=ch10_blue,xlim=c(0,16),ylim=c(.6,7.4),xlab='Vnímaný stres (body, 0–16)',ylab='Kvalita spánku (1–7)',main='',bty='l',yaxt='n')
  fl_title(main=paste0('30 studentů: *r*_{*s*} = ',ch10_num(ch10_ss_rs),', τ_{*b*} = ',ch10_num(ch10_ss_tau[['tau_b']])),font.main=1)
  axis(2,at=1:7); text(x[tab$Freq>1],y[tab$Freq>1],tab$Freq[tab$Freq>1],cex=.72,col=ch10_ink)
  legend('topright',legend=c('1 student','2 studenti'),pt.cex=1.2+1.1*(0:1),pch=21,pt.bg=ch10_fill,col=ch10_blue,bty='n',cex=.8,y.intersp=1.6,x.intersp=1.6,inset=c(.01,.02))
},width=7.6,height=5)
ch10_fig('stres-spanek','data',note='Velikost bodu vyjadřuje počet studentů se stejnou dvojicí hodnot; u bodů se dvěma studenty je v bodě číslo 2.',panels=list(local({
  tab <- as.data.frame(table(ch10_ss$stres,ch10_ss$spanek)); tab <- tab[tab$Freq>0,]
  tf_panel(paste0('30 studentů: r_s = ',ch10_num(ch10_ss_rs),', τ_b = ',ch10_num(ch10_ss_tau[['tau_b']])),'bodový graf','Vnímaný stres (body, 0–16)','Kvalita spánku (1–7)',xlim=c(0,16),ylim=c(.6,7.4),
    series=list(tf_series('Dvojice hodnot',data.frame(x=as.numeric(as.character(tab$Var1)),y=as.numeric(as.character(tab$Var2)),pocet_studentu=tab$Freq)))) })))
ch10_draw('poradi', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,3.2,.8)); d <- ch10_rt
  plot(d$hodiny,d$ms,pch=21,bg=ch10_fill,col=ch10_blue,cex=1.2,xlab='Trénink (hodiny)',ylab='Reakční doba (ms)',main='',bty='l')
  fl_title(main=paste0('Původní hodnoty: *r* = ',ch10_num(ch10_rt_r)),font.main=1)
  plot(rank(d$hodiny),rank(d$ms),pch=21,bg=ch10_fill,col=ch10_blue,cex=1.2,xlab='Pořadí tréninku',ylab='Pořadí reakční doby',main='',bty='l')
  fl_title(main=paste0('Pořadí: *r*_{*s*} = ',ch10_num(ch10_rt_rs)),font.main=1)
},width=9,height=4.3)
ch10_fig('poradi','data',note='Dva panely vedle sebe: tytéž osoby v původních hodnotách a v pořadích.',panels=list(
  tf_panel(paste0('Původní hodnoty: r = ',ch10_num(ch10_rt_r)),'bodový graf','Trénink (hodiny)','Reakční doba (ms)',series=list(tf_series('Osoby',data.frame(x=ch10_rt$hodiny,y=ch10_rt$ms)))),
  tf_panel(paste0('Pořadí: r_s = ',ch10_num(ch10_rt_rs)),'bodový graf','Pořadí tréninku','Pořadí reakční doby',series=list(tf_series('Osoby',data.frame(x=rank(ch10_rt$hodiny),y=rank(ch10_rt$ms)))))))
ch10_bvn <- local({ set.seed(9010); x <- rnorm(400); y <- .6*x+.8*rnorm(400); x2 <- rnorm(400); y2 <- .6*x2+.2*(x2+3.3)*rnorm(400); list(x=x,y=y,x2=x2,y2=y2) })
ch10_draw('dvourozmerne', {
  par(mfrow=c(1,2),mar=c(4.4,4.4,3.4,.8)); x <- ch10_bvn$x; y <- ch10_bvn$y
  plot(x,y,pch=16,col=adjustcolor(ch10_blue,.45),cex=.7,xlab='',ylab='',main='Dvourozměrné normální rozdělení:\nstejná rozptýlenost v celém rozsahu X',bty='l',xlim=c(-3.2,3.2),ylim=c(-5,5),cex.main=.92,font.main=1)
  fl_title(xlab='X (*z*-skór)',ylab='Y (*z*-skór)')
  x2 <- ch10_bvn$x2; y2 <- ch10_bvn$y2
  plot(x2,y2,pch=16,col=adjustcolor(ch10_orange,.45),cex=.7,xlab='',ylab='Y',main='Heteroskedasticita:\nrozptýlenost Y roste s X',bty='l',xlim=c(-3.2,3.2),ylim=c(-5,5),cex.main=.92,font.main=1)
  fl_title(xlab='X (*z*-skór)')
},width=9,height=4.4)
ch10_fig('dvourozmerne','simulace',note='Dva panely se stejnými osami, v každém 400 poloprůhledných bodů.',panels=list(
  tf_panel('Dvourozměrné normální rozdělení: stejná rozptýlenost v celém rozsahu X','bodový graf','X (z-skór)','Y (z-skór)',xlim=c(-3.2,3.2),ylim=c(-5,5),series=list(tf_series('Body',data.frame(x=ch10_bvn$x,y=ch10_bvn$y)))),
  tf_panel('Heteroskedasticita: rozptýlenost Y roste s X','bodový graf','X (z-skór)','Y',xlim=c(-3.2,3.2),ylim=c(-5,5),series=list(tf_series('Body',data.frame(x=ch10_bvn$x2,y=ch10_bvn$y2))))))
ch10_draw('vyberove-r', {
  par(mfrow=c(1,2),mar=c(4.4,4.4,3.2,.8)); br <- seq(-1,1,.025)
  for (j in 1:2) { v <- ch10_sim_r[,j]; rho <- c(0,.8)[j]
    hist(v,breaks=br,col=ch10_fill,border='white',main='',xlab='',ylab='Počet výběrů z 10 000',xlim=c(-1,1))
    fl_title(main=paste0('ρ = ',ch10_num(rho,1),', *n* = 20'),xlab='Výběrové *r*',font.main=1)
    abline(v=rho,col=ch10_orange,lwd=2); abline(v=ch10_sim_sum[c('q025','q975'),j],lty=2,col=ch10_gray) }
},width=9,height=4.2)
ch10_fig('vyberove-r','simulace',note='Histogramy výběrových korelací z 10 000 výběrů; oranžová čára je populační korelace, přerušované čáry 2,5. a 97,5. percentil simulovaných hodnot.',panels=lapply(1:2,function(j)
  tf_panel(paste0('ρ = ',ch10_num(c(0,.8)[j],1),', n = 20'),'histogram','Výběrové r','Počet výběrů z 10 000',xlim=c(-1,1),
    guides=list(tf_guide('x',c(0,.8)[j],'populační korelace ρ'),tf_guide('x',ch10_sim_sum['q025',j],'2,5. percentil'),tf_guide('x',ch10_sim_sum['q975',j],'97,5. percentil')),
    series=list(tf_series('Četnosti',tf_bins(ch10_sim_r[,j],seq(-1,1,.025)),'histogram',digits=3)))))
ch10_draw('permutace', {
  par(mar=c(4.6,4.7,2.8,.8)); v <- ch10_ss_1999$pm[,2]; o <- ch10_ss_tau[['tau_b']]
  hist(v,breaks=seq(-.6,.6,.025),col=ch10_fill,border='white',xlab='',ylab='Počet permutací z 1 999',main='')
  fl_title(main='Permutační rozdělení τ_{*b*} za nezávislosti',xlab='τ_{*b*} po náhodném přeskupení hodnot kvality spánku',font.main=1)
  abline(v=c(o,-o),col=ch10_orange,lwd=2,lty=c(1,2)); text(o,par('usr')[4]*.9,paste0('pozorováno ',ch10_num(o)),pos=4,cex=.8,col=ch10_orange)
  text(-o,par('usr')[4]*.9,paste0('zrcadlově ',ch10_num(-o)),pos=2,cex=.8,col=ch10_orange)
},width=8,height=4.3)
ch10_fig('permutace','simulace',panels=list(
  tf_panel('Permutační rozdělení τ_b za nezávislosti','histogram','τ_b po náhodném přeskupení hodnot kvality spánku','Počet permutací z 1 999',
    guides=list(tf_guide('x',ch10_ss_tau[['tau_b']],paste0('pozorováno ',ch10_num(ch10_ss_tau[['tau_b']]))),tf_guide('x',-ch10_ss_tau[['tau_b']],paste0('zrcadlově ',ch10_num(-ch10_ss_tau[['tau_b']])))),
    series=list(tf_series('Četnosti',tf_bins(ch10_ss_1999$pm[,2],seq(-.6,.6,.025)),'histogram',digits=3)))))
ch10_draw('bootstrap', {
  par(mar=c(4.6,4.7,2.8,.8)); v <- ch10_ss_1999$bt[,2]; ci <- ch10_ss_1999$tb_ci
  hist(v,breaks=seq(-.9,.2,.025),col=ch10_fill,border='white',xlab='',ylab='Počet výběrů z 1 999',main='')
  fl_title(main='Bootstrapové rozdělení τ_{*b*} a percentilový interval',xlab='τ_{*b*} v bootstrapovém výběru',font.main=1)
  abline(v=ci,col=ch10_blue,lwd=2,lty=2); abline(v=ch10_ss_tau[['tau_b']],col=ch10_orange,lwd=2)
  text(ci,par('usr')[4]*.92,c(paste0('2,5. percentil\n',ch10_num(ci[1])),paste0('97,5. percentil\n',ch10_num(ci[2]))),pos=c(2,4),cex=.76,col=ch10_blue)
},width=8,height=4.3)
ch10_fig('bootstrap','simulace',panels=list(
  tf_panel('Bootstrapové rozdělení τ_b a percentilový interval','histogram','τ_b v bootstrapovém výběru','Počet výběrů z 1 999',
    guides=list(tf_guide('x',ch10_ss_1999$tb_ci[1],paste0('2,5. percentil ',ch10_num(ch10_ss_1999$tb_ci[1]))),tf_guide('x',ch10_ss_1999$tb_ci[2],paste0('97,5. percentil ',ch10_num(ch10_ss_1999$tb_ci[2]))),
                tf_guide('x',ch10_ss_tau[['tau_b']],'pozorované τ_b')),
    series=list(tf_series('Četnosti',tf_bins(ch10_ss_1999$bt[,2],seq(-.9,.2,.025)),'histogram',digits=3)))))
ch10_draw('faktory', {
  # Two rows (R86): both panels with the same applicants on top, the merged classes centred below.
  layout(matrix(c(1,1,2,2,0,3,3,0),2,byrow=TRUE)); par(mar=c(4.4,4.2,3.6,.8),mgp=c(2.4,.6,0),cex=.75)
  d <- ch10_rr; adm <- d$test>=ch10_rr_cut
  plot(d$test,d$prospech,pch=16,col=ifelse(adm,ch10_blue,adjustcolor(ch10_mute,.8)),cex=.8,xlab='Přijímací test (body)',ylab='Výsledky v 1. ročníku (body)',bty='l',
       main='')
  fl_title(main=paste0('Omezení rozsahu\nvšichni *r* = ',ch10_num(ch10_rr_r[['vse']]),', přijatí *r* = ',ch10_num(ch10_rr_r[['prijati']])),cex.main=.92,font.main=1)
  abline(v=ch10_rr_cut,lty=2,col=ch10_gray)
  ext <- d$test<=quantile(d$test,.15)|d$test>=quantile(d$test,.85)
  plot(d$test,d$prospech,pch=16,col=ifelse(ext,ch10_orange,adjustcolor(ch10_mute,.8)),cex=.8,xlab='Přijímací test (body)',ylab='Výsledky v 1. ročníku (body)',bty='l',
       main='')
  fl_title(main=paste0('Jen krajní skupiny\n*r* = ',ch10_num(ch10_rr_r[['extremy']])),cex.main=.92,font.main=1)
  g <- ch10_cg; m <- g$trida=='mladší'
  plot(g$slova,g$rychlost,pch=ifelse(m,21,24),bg=ifelse(m,ch10_fill,ch10_sand),col=ifelse(m,ch10_blue,ch10_orange),cex=1.05,xlab='Slovní zásoba (body)',ylab='Rychlost čtení (slov za minutu)',bty='l',
       main='')
  fl_title(main=paste0('Dvě sloučené třídy\ncelkem *r* = ',ch10_num(ch10_cg_r[['vse']]),'; uvnitř ',ch10_num(ch10_cg_r[['mladsi']]),' a ',ch10_num(ch10_cg_r[['starsi']])),cex.main=.92,font.main=1)
  legend('bottomright',legend=c('mladší třída','starší třída'),pch=c(21,24),pt.bg=c(ch10_fill,ch10_sand),col=c(ch10_blue,ch10_orange),bty='n',cex=.85)
},width=9,height=8)
ch10_fig('faktory','simulace',note='Dva řádky: nahoře dva panely s týmiž uchazeči a různým zvýrazněním (vlevo omezení rozsahu, vpravo krajní skupiny), dole uprostřed třetí panel s jinými daty (dvě sloučené třídy).',panels=local({
  d <- ch10_rr; adm <- d$test>=ch10_rr_cut; ext <- d$test<=quantile(d$test,.15)|d$test>=quantile(d$test,.85); g <- ch10_cg; m <- g$trida=='mladší'
  xy <- function(x,y,keep) data.frame(x=x[keep],y=y[keep])
  list(
    tf_panel(paste0('Omezení rozsahu: všichni r = ',ch10_num(ch10_rr_r[['vse']]),', přijatí r = ',ch10_num(ch10_rr_r[['prijati']])),'bodový graf','Přijímací test (body)','Výsledky v 1. ročníku (body)',
      guides=list(tf_guide('x',ch10_rr_cut,'hranice přijetí')),
      series=list(tf_series('Přijatí (modře)',xy(d$test,d$prospech,adm)),tf_series('Nepřijatí (šedě)',xy(d$test,d$prospech,!adm)))),
    tf_panel(paste0('Jen krajní skupiny: r = ',ch10_num(ch10_rr_r[['extremy']])),'bodový graf','Přijímací test (body)','Výsledky v 1. ročníku (body)',
      series=list(tf_series('Krajních 15 % z každé strany (oranžově)',xy(d$test,d$prospech,ext)),tf_series('Ostatní (šedě)',xy(d$test,d$prospech,!ext)))),
    tf_panel(paste0('Dvě sloučené třídy: celkem r = ',ch10_num(ch10_cg_r[['vse']]),'; uvnitř ',ch10_num(ch10_cg_r[['mladsi']]),' a ',ch10_num(ch10_cg_r[['starsi']])),'bodový graf','Slovní zásoba (body)','Rychlost čtení (slov za minutu)',
      series=list(tf_series('Mladší třída (kolečka)',xy(g$slova,g$rychlost,m)),tf_series('Starší třída (trojúhelníky)',xy(g$slova,g$rychlost,!m))))) }))
ch10_draw('shoda-hodnot', {
  par(mar=c(4.6,4.7,2.8,.8)); d <- ch10_rat
  plot(d$A,d$B,xlim=c(8,24),ylim=c(8,24),pch=21,bg=ch10_fill,col=ch10_blue,cex=1.4,xlab='Hodnotitelka A (body)',ylab='Hodnotitel B (body)',main='',bty='l',asp=1)
  fl_title(main=paste0('Vysoká korelace, ale ne shoda: *r* = ',ch10_num(ch10_rat_r)),font.main=1)
  abline(0,1,lty=2,col=ch10_gray); text(20.5,19.6,'shodné hodnoty',srt=45,cex=.78,col=ch10_gray)
},width=6.2,height=5)
ch10_fig('shoda-hodnot','data',note='Obě osy mají stejné měřítko; přerušovaná přímka y = x označuje shodné hodnoty.',panels=list(
  tf_panel(paste0('Vysoká korelace, ale ne shoda: r = ',ch10_num(ch10_rat_r)),'bodový graf','Hodnotitelka A (body)','Hodnotitel B (body)',xlim=c(8,24),ylim=c(8,24),
    guides=list(tf_guide('primka',c(0,1),'shodné hodnoty')),series=list(tf_series('Posuzované práce',data.frame(x=ch10_rat$A,y=ch10_rat$B))))))
# Revision 2026-11-20 (R84): Fisher transformation, exact permutation distribution, kinds of outliers,
# measurement error and the point-biserial correlation as a function of d.
ch10_draw('fisher', {
  # Two rows (R86): the transformation curve centred on top, both histograms below.
  layout(matrix(c(0,1,1,0,2,2,3,3),2,byrow=TRUE)); par(mar=c(4.4,4.4,3.4,.8),cex=.75)   # layout() would shrink text to 0.66
  r <- seq(-.995,.995,length.out=400)
  plot(r,atanh(r),type='l',lwd=2,col=ch10_blue,xlab='',ylab='',bty='l',ylim=c(-3,3),
       main='Fisherova transformace\nnatahuje okraje stupnice',cex.main=.95,font.main=1)
  fl_title(xlab='Korelace *r*',ylab='Převedená hodnota *z*_{*r*}')
  abline(0,1,lty=3,col=ch10_gray); abline(h=0,v=0,col=ch10_pale)
  points(c(ch10_uz_r,.8),atanh(c(ch10_uz_r,.8)),pch=21,bg=ch10_orange,col=ch10_ink,cex=1.3)
  # The label of r = -0.523 sits below-right of the curve and the dotted line, joined by a short segment.
  segments(ch10_uz_r+.03,atanh(ch10_uz_r)-.08,-.36,-.92,col=ch10_gray)
  fl_text(-.35,-1.08,paste0('*r* = ',ch10_num(ch10_uz_r,3),'\n*z* = ',ch10_num(atanh(ch10_uz_r),3)),adj=c(0,.5),cex=.85)
  fl_text(.8,atanh(.8),paste0('*r* = 0,8\n*z* = ',ch10_num(atanh(.8),3)),pos=2,offset=.8,cex=.85)
  v <- ch10_sim_r[,'rho08']
  hist(v,breaks=seq(-.2,1,.02),col=ch10_fill,border='white',xlab='',ylab='Počet výběrů z 10 000',main='')
  fl_title(main='ρ = 0,8, *n* = 20: hodnoty *r*\nšikmé rozdělení',xlab='Výběrové *r*',cex.main=.95,font.main=1)
  abline(v=.8,col=ch10_orange,lwd=2)
  zv <- atanh(v); h <- hist(zv,breaks=seq(-.4,2.8,.05),plot=FALSE)
  plot(h,col=ch10_fill,border='white',xlab='',ylab='Počet výběrů z 10 000',main='Tytéž výběry po transformaci\npřibližně normální rozdělení',cex.main=.95,font.main=1)
  fl_title(xlab='Převedené *z*_{*r*}')
  zz <- seq(-.4,2.8,length.out=300); lines(zz,10000*.05*dnorm(zz,atanh(.8),1/sqrt(17)),col=ch10_ink,lwd=1.6)
  abline(v=atanh(.8),col=ch10_orange,lwd=2)
},width=9,height=7.6)
ch10_fig('fisher','krivka',note='Dva řádky: nahoře uprostřed transformační křivka, dole vlevo histogram výběrových r a vpravo histogram týchž výběrů po transformaci.',panels=local({
  r <- seq(-.99,.99,by=.03); v <- ch10_sim_r[,'rho08']; zz <- seq(-.4,2.8,by=.1)
  list(
    tf_panel('Fisherova transformace natahuje okraje stupnice','čárový graf','Korelace r','Převedená hodnota z_r',xlim=c(-1,1),ylim=c(-3,3),
      guides=list(tf_guide('primka',c(0,1),'z = r (tečkovaně)')),note='Křivka je z_r = atanh(r) = 0,5·ln((1 + r)/(1 − r)).',
      series=list(tf_series('Křivka',data.frame(x=r,y=atanh(r)),'cara',digits=3),
        tf_series('Zvýrazněné body',data.frame(x=c(ch10_uz_r,.8),y=atanh(c(ch10_uz_r,.8)),popisek=c(paste0('r = ',ch10_num(ch10_uz_r,3),', z = ',ch10_num(atanh(ch10_uz_r),3)),paste0('r = 0,8, z = ',ch10_num(atanh(.8),3)))),digits=3))),
    tf_panel('ρ = 0,8, n = 20: hodnoty r, šikmé rozdělení','histogram','Výběrové r','Počet výběrů z 10 000',guides=list(tf_guide('x',.8,'ρ = 0,8')),
      series=list(tf_series('Četnosti',tf_bins(v,seq(-.2,1,.02)),'histogram',digits=3))),
    tf_panel('Tytéž výběry po transformaci, přibližně normální rozdělení','histogram','Převedené z_r','Počet výběrů z 10 000',guides=list(tf_guide('x',atanh(.8),'atanh(0,8)')),
      note='Křivka je normální rozdělení se středem atanh(0,8) a směrodatnou odchylkou 1/√17, přepočtené na četnosti (10 000 · 0,05 · hustota).',
      series=list(tf_series('Četnosti',tf_bins(atanh(v),seq(-.4,2.8,.05)),'histogram',digits=3),
        tf_series('Normální křivka',data.frame(x=zz,y=10000*.05*dnorm(zz,atanh(.8),1/sqrt(17))),'cara',digits=1)))) }))
ch10_draw('permutace-presna', {
  par(mar=c(4.8,4.7,2.8,.8)); tb <- as.numeric(sub(',','.',names(ch10_t6_dist),fixed=TRUE)); f <- as.vector(ch10_t6_dist)
  ext <- abs(tb)>=round(abs(ch10_t6_tau[['tau_b']]),3)-1e-9
  plot(tb,f,type='h',lwd=9,lend=1,col=ifelse(ext,ch10_orange,ch10_mute),xlim=c(-1,1),ylim=c(0,max(f)*1.25),bty='l',xaxt='n',
       xlab='',ylab='Počet přiřazení',main='')
  fl_title(xlab='τ_{*b*} pro jedno ze 720 přiřazení hodnot kvality spánku')
  axis(1,at=seq(-1,1,.25),labels=ch10_num(seq(-1,1,.25)))
  fl_title(main='Přesné permutační rozdělení τ_{*b*} pro šest studentů',font.main=1)
  text(tb[ext],f[ext],f[ext],pos=3,cex=.78,col=ch10_orange)
  legend('topright',legend=c('stejně nebo více vzdálené od nuly než pozorované −0,741: 48 ze 720','ostatní přiřazení'),
         col=c(ch10_orange,ch10_mute),lwd=8,bty='n',cex=.78)
},width=8.6,height=4.4)
ch10_fig('permutace-presna','sloupce',note='Úzké svislé sloupce; oranžové jsou hodnoty stejně nebo více vzdálené od nuly než pozorované −0,741 (48 ze 720 přiřazení), nad nimi je vypsán počet. Ostatní sloupce jsou šedé.',panels=list(local({
  tb <- as.numeric(sub(',','.',names(ch10_t6_dist),fixed=TRUE)); f <- as.vector(ch10_t6_dist); ext <- abs(tb)>=round(abs(ch10_t6_tau[['tau_b']]),3)-1e-9
  tf_panel('Přesné permutační rozdělení τ_b pro šest studentů','sloupcový graf','τ_b pro jedno ze 720 přiřazení hodnot kvality spánku','Počet přiřazení',xlim=c(-1,1),ylim=c(0,max(f)*1.25),
    series=list(tf_series('Počty přiřazení',data.frame(x=tb,y=f,zvyrazneno=ifelse(ext,'ano','ne')),'sloupce',digits=3))) })))
ch10_draw('odlehle-typy', {
  par(mfrow=c(2,2),mar=c(4.2,3.8,4.6,.8),mgp=c(2.2,.6,0))   # 2 x 2 grid (R86)
  tt <- c(zaklad='Bez odlehlého pozorování',krajni_x='A: krajní hodnota X,\nbod ve směru vztahu',
          kombinace='B: obvyklé X i Y,\nneobvyklá kombinace',obe='C: krajní X i Y,\nbod proti směru vztahu')
  for (k in names(ch10_otypes)) { d <- ch10_otypes[[k]]; n <- nrow(d); new <- k!='zaklad'&seq_len(n)==n; s <- ch10_otypes_stat[,k]
    plot(d$x,d$y,xlim=c(25,105),ylim=c(15,85),pch=21,bg=ifelse(new,ch10_orange,ch10_fill),col=ifelse(new,ch10_ink,ch10_blue),cex=ifelse(new,1.7,1.15),
         xlab='X',ylab='Y',bty='l',main='')
    title(main=tt[[k]],line=2.3,cex.main=.9,font.main=2)
    fl_title(main=paste0('*r* = ',ch10_num(s[['r']]),', *r*_{*s*} = ',ch10_num(s[['rs']]),', τ_{*b*} = ',ch10_num(s[['tb']])),line=.6,cex.main=.86,font.main=1) }
},width=8.6,height=7.6)
ch10_fig('odlehle-typy','simulace',note='Mřížka 2 × 2 se stejnými osami: vlevo nahoře bez odlehlého pozorování, vpravo nahoře bod A, vlevo dole bod B, vpravo dole bod C; přidaný bod je větší a oranžový.',panels=lapply(names(ch10_otypes),function(k) {
  d <- ch10_otypes[[k]]; n <- nrow(d); s <- ch10_otypes_stat[,k]; base <- if (k=='zaklad') seq_len(n) else seq_len(n-1)
  tt <- c(zaklad='Bez odlehlého pozorování',krajni_x='A: krajní hodnota X, bod ve směru vztahu',kombinace='B: obvyklé X i Y, neobvyklá kombinace',obe='C: krajní X i Y, bod proti směru vztahu')
  tf_panel(paste0(tt[[k]],' (r = ',ch10_num(s[['r']]),', r_s = ',ch10_num(s[['rs']]),', τ_b = ',ch10_num(s[['tb']]),')'),'bodový graf','X','Y',xlim=c(25,105),ylim=c(15,85),
    series=c(list(tf_series('Původní body',data.frame(x=d$x[base],y=d$y[base]))),if (k!='zaklad') list(tf_series('Přidaný bod (oranžově)',data.frame(x=d$x[n],y=d$y[n]))))) }))
ch10_draw('reliabilita', {
  par(mfrow=c(1,2),mar=c(4.4,4.4,3.4,.8)); d <- ch10_rel_sim; lim <- c(-4.2,4.2)
  plot(d$tx,d$ty,pch=16,col=adjustcolor(ch10_blue,.5),cex=.75,xlim=lim,ylim=lim,xlab='Pravý skór X',ylab='Pravý skór Y',bty='l',
       main='')
  fl_title(main=paste0('Hodnoty bez chyby měření\n*r* = ',ch10_num(ch10_rel_sim_r[['prave']])),cex.main=.95,font.main=1)
  plot(d$x,d$y,pch=16,col=adjustcolor(ch10_orange,.5),cex=.75,xlim=lim,ylim=lim,xlab='Naměřený skór X',ylab='Naměřený skór Y',bty='l',
       main='')
  fl_title(main=paste0('Naměřené hodnoty, reliabilita obou měření 0,6\n*r* = ',ch10_num(ch10_rel_sim_r[['namerene']])),cex.main=.95,font.main=1)
},width=9,height=4.5)
ch10_fig('reliabilita','simulace',note='Dva panely se stejnými osami: titíž lidé bez chyby měření a s chybou měření.',panels=list(
  tf_panel(paste0('Hodnoty bez chyby měření: r = ',ch10_num(ch10_rel_sim_r[['prave']])),'bodový graf','Pravý skór X','Pravý skór Y',xlim=c(-4.2,4.2),ylim=c(-4.2,4.2),series=list(tf_series('Osoby',data.frame(x=ch10_rel_sim$tx,y=ch10_rel_sim$ty)))),
  tf_panel(paste0('Naměřené hodnoty, reliabilita obou měření 0,6: r = ',ch10_num(ch10_rel_sim_r[['namerene']])),'bodový graf','Naměřený skór X','Naměřený skór Y',xlim=c(-4.2,4.2),ylim=c(-4.2,4.2),series=list(tf_series('Osoby',data.frame(x=ch10_rel_sim$x,y=ch10_rel_sim$y))))))
ch10_draw('rpb-d', {
  par(mar=c(4.6,4.7,2.8,.8)); d <- seq(0,3,.01)
  sp <- list(c(21,21),c(30,12),c(38,4)); cl <- c(ch10_blue,ch10_orange,ch10_green); lt <- c(1,2,4)
  plot(NA,xlim=c(0,3),ylim=c(0,1),xlab='',ylab='',bty='l',xaxt='n',yaxt='n',main='')
  axis(1,at=0:6/2,labels=ch10_num(0:6/2,1)); axis(2,at=0:5/5,labels=ch10_num(0:5/5,1))
  fl_title(xlab='Cohenovo *d*',ylab='|*r*_{*pb*}|')
  fl_title(main='Bodově biseriální korelace podle *d* a rozdělení 42 lidí do skupin',font.main=1)
  for (k in 1:3) lines(d,ch10_rpb_d(d,sp[[k]][1],sp[[k]][2]),col=cl[k],lwd=2,lty=lt[k])
  points(.8,ch10_rpb_d(.8,30,12),pch=21,bg=ch10_orange,col=ch10_ink,cex=1.4)
  segments(.45,.6,.78,ch10_rpb_d(.8,30,12)+.02,col=ch10_gray)
  fl_text(.45,.6,'příklad z kapitoly 8:\n*d* = 0,80, |*r*| = 0,35',pos=3,cex=.78)
  legend('bottomright',legend=c('21 a 21','30 a 12','38 a 4'),title='Velikosti skupin',col=cl,lty=lt,lwd=2,bty='n',cex=.82)
},width=8,height=4.6)
ch10_fig('rpb-d','krivka',note='Tři křivky pro různé rozdělení 42 lidí do dvou skupin (plná 21 a 21, čárkovaná 30 a 12, čerchovaná 38 a 4) a zvýrazněný příklad z kapitoly 8.',panels=list(local({
  d <- seq(0,3,by=.1); sp <- list(c(21,21),c(30,12),c(38,4))
  tf_panel('Bodově biseriální korelace podle d a rozdělení 42 lidí do skupin','čárový graf','Cohenovo d','|r_pb|',xlim=c(0,3),ylim=c(0,1),
    series=c(lapply(sp,function(s) tf_series(paste0('Skupiny ',s[1],' a ',s[2]),data.frame(x=d,y=ch10_rpb_d(d,s[1],s[2])),'cara',digits=3)),
      list(tf_series('Příklad z kapitoly 8',data.frame(x=.8,y=ch10_rpb_d(.8,30,12),popisek='d = 0,80, |r| = 0,35'),digits=3)))) })))
options(ch10_old_options)
