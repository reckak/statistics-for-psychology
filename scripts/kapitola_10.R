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
# 9. Same r, different shapes: four authored data sets of 20 points tuned to r = 0.60. ------------
set.seed(8010)
ch10_same <- local({
  target <- .6; n <- 20; x <- sort(runif(n,0,10)); e <- rnorm(n)
  tune <- function(f,lo,hi) f(uniroot(function(s) ch10_r(f(s)$x,f(s)$y)-target,c(lo,hi))$root)
  lin <- tune(function(s) data.frame(x=x,y=3+.5*x+s*e),.1,10)
  cur <- tune(function(s) data.frame(x=x,y=.12*(x-2)^2+s*e),.01,10)
  b <- rnorm(n-1); xo <- runif(n-1,0,4)
  out <- tune(function(s) data.frame(x=c(xo,12),y=c(5+b,5+s)),.5,30)
  g <- rnorm(n); xc <- c(runif(10,0,3),runif(10,6,9))
  clu <- tune(function(s) data.frame(x=xc,y=c(rep(0,10),rep(s,10))+1.4*g),.01,10)
  list(linearni=lin,zakriveny=cur,odlehly=out,shluky=clu)
})
ch10_same_r <- sapply(ch10_same,function(d) ch10_r(d$x,d$y))
# Figures -------------------------------------------------------------------------------------------
# Plotmath labels keep the subscripts of r_s and tau_b (no Unicode subscript b exists).
ch10_lab_rs <- function(v) bquote(r[s] == .(ch10_num(v)))
ch10_lab_tb <- function(v) bquote(tau[b] == .(ch10_num(v)))
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
ch10_draw('uzkost-vykon', {
  par(mar=c(4.6,4.7,2.8,.8)); d <- ch10_uz
  set.seed(1); plot(jitter(d$uzkost,.4),jitter(d$vykon,.4),pch=21,bg=ch10_fill,col=ch10_blue,cex=1.3,xlab='Úzkost před testem (body, 10–40)',ylab='Výkon v testu (body, 0–30)',
       main=paste0('40 studentů: r = ',ch10_num(ch10_uz_r,2)),bty='l')
  ch10_quadrants(d$uzkost,d$vykon,lab=FALSE)
},width=7.2,height=4.8)
ch10_form_titles <- c(kladny='Kladný lineární',zaporny='Záporný lineární',monotonni='Monotónní, zakřivený',obraceneU='Obrácené U',odlehly='Jedno odlehlé pozorování',skupiny='Dvě oddělené skupiny')
ch10_draw('tvary', {
  par(mfrow=c(2,3),mar=c(3,3,3.6,.6),mgp=c(1.6,.5,0))
  for (k in names(ch10_forms)) { d <- ch10_forms[[k]]
    plot(d$x,d$y,pch=21,bg=ch10_fill,col=ch10_blue,cex=1.05,xlab='X',ylab='Y',xaxt='n',yaxt='n',bty='l',main='')
    title(main=ch10_form_titles[[k]],line=2.2,cex.main=.98,font.main=2)
    title(main=bquote(list(r == .(ch10_num(ch10_forms_r['r',k])), r[s] == .(ch10_num(ch10_forms_r['rs',k])))),line=.8,cex.main=.92,font.main=1) }
},width=9,height=6.2)
ch10_draw('stejne-r', {
  par(mfrow=c(1,4),mar=c(3,3,3.2,.5),mgp=c(1.6,.5,0))
  tt <- c(linearni='Přibližně lineární',zakriveny='Zakřivený',odlehly='Jeden vzdálený bod',shluky='Dva shluky')
  for (k in names(ch10_same)) { d <- ch10_same[[k]]
    plot(d$x,d$y,pch=21,bg=ch10_fill,col=ch10_blue,cex=1.2,xlab='X',ylab='Y',xaxt='n',yaxt='n',bty='l',main=paste0(tt[[k]],'\nr = ',ch10_num(ch10_same_r[[k]])),cex.main=.95,font.main=1) }
},width=10,height=3.4)
ch10_draw('stres-spanek', {
  par(mar=c(4.6,4.7,3,.8)); tab <- as.data.frame(table(ch10_ss$stres,ch10_ss$spanek)); tab <- tab[tab$Freq>0,]
  x <- as.numeric(as.character(tab$Var1)); y <- as.numeric(as.character(tab$Var2))
  plot(x,y,cex=1.2+1.1*(tab$Freq-1),pch=21,bg=ch10_fill,col=ch10_blue,xlim=c(0,16),ylim=c(.6,7.4),xlab='Vnímaný stres (body, 0–16)',ylab='Kvalita spánku (1–7)',main='',bty='l',yaxt='n')
  title(main=bquote('30 studentů: ' ~ list(r[s] == .(ch10_num(ch10_ss_rs)), tau[b] == .(ch10_num(ch10_ss_tau[['tau_b']])))),font.main=1)
  axis(2,at=1:7); text(x[tab$Freq>1],y[tab$Freq>1],tab$Freq[tab$Freq>1],cex=.72,col=ch10_ink)
  legend('topright',legend=c('1 student','2 studenti'),pt.cex=1.2+1.1*(0:1),pch=21,pt.bg=ch10_fill,col=ch10_blue,bty='n',cex=.8,y.intersp=1.6,x.intersp=1.6,inset=c(.01,.02))
},width=7.6,height=5)
ch10_draw('poradi', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,3.2,.8)); d <- ch10_rt
  plot(d$hodiny,d$ms,pch=21,bg=ch10_fill,col=ch10_blue,cex=1.2,xlab='Trénink (hodiny)',ylab='Reakční doba (ms)',main=paste0('Původní hodnoty: r = ',ch10_num(ch10_rt_r)),bty='l',font.main=1)
  plot(rank(d$hodiny),rank(d$ms),pch=21,bg=ch10_fill,col=ch10_blue,cex=1.2,xlab='Pořadí tréninku',ylab='Pořadí reakční doby',main='',bty='l')
  title(main=bquote('Pořadí: ' * r[s] == .(ch10_num(ch10_rt_rs))),font.main=1)
},width=9,height=4.3)
ch10_draw('dvourozmerne', {
  par(mfrow=c(1,2),mar=c(4.4,4.4,3.4,.8)); set.seed(9010)
  x <- rnorm(400); y <- .6*x+.8*rnorm(400)
  plot(x,y,pch=16,col=adjustcolor(ch10_blue,.45),cex=.7,xlab='X (z-skór)',ylab='Y (z-skór)',main='Dvourozměrné normální rozdělení:\nstejná rozptýlenost v celém rozsahu X',bty='l',xlim=c(-3.2,3.2),ylim=c(-5,5),cex.main=.92,font.main=1)
  x2 <- rnorm(400); y2 <- .6*x2+.2*(x2+3.3)*rnorm(400)
  plot(x2,y2,pch=16,col=adjustcolor(ch10_orange,.45),cex=.7,xlab='X (z-skór)',ylab='Y',main='Heteroskedasticita:\nrozptýlenost Y roste s X',bty='l',xlim=c(-3.2,3.2),ylim=c(-5,5),cex.main=.92,font.main=1)
},width=9,height=4.4)
ch10_draw('vyberove-r', {
  par(mfrow=c(1,2),mar=c(4.4,4.4,3.2,.8)); br <- seq(-1,1,.025)
  for (j in 1:2) { v <- ch10_sim_r[,j]; rho <- c(0,.8)[j]
    hist(v,breaks=br,col=ch10_fill,border='white',main=paste0('ρ = ',ch10_num(rho,1),', n = 20'),xlab='Výběrové r',ylab='Počet výběrů z 10 000',xlim=c(-1,1),font.main=1)
    abline(v=rho,col=ch10_orange,lwd=2); abline(v=ch10_sim_sum[c('q025','q975'),j],lty=2,col=ch10_gray) }
},width=9,height=4.2)
ch10_draw('permutace', {
  par(mar=c(4.6,4.7,2.8,.8)); v <- ch10_ss_1999$pm[,2]; o <- ch10_ss_tau[['tau_b']]
  hist(v,breaks=seq(-.6,.6,.025),col=ch10_fill,border='white',xlab=expression(tau[b] ~ 'po náhodném přeskupení hodnot kvality spánku'),ylab='Počet permutací z 1 999',main='',font.main=1)
  title(main=expression('Permutační rozdělení ' * tau[b] * ' za nezávislosti'),font.main=1)
  abline(v=c(o,-o),col=ch10_orange,lwd=2,lty=c(1,2)); text(o,par('usr')[4]*.9,paste0('pozorováno ',ch10_num(o)),pos=4,cex=.8,col=ch10_orange)
  text(-o,par('usr')[4]*.9,paste0('zrcadlově ',ch10_num(-o)),pos=2,cex=.8,col=ch10_orange)
},width=8,height=4.3)
ch10_draw('bootstrap', {
  par(mar=c(4.6,4.7,2.8,.8)); v <- ch10_ss_1999$bt[,2]; ci <- ch10_ss_1999$tb_ci
  hist(v,breaks=seq(-.9,.2,.025),col=ch10_fill,border='white',xlab=expression(tau[b] ~ 'v bootstrapovém výběru'),ylab='Počet výběrů z 1 999',main='',font.main=1)
  title(main=expression('Bootstrapové rozdělení ' * tau[b] * ' a percentilový interval'),font.main=1)
  abline(v=ci,col=ch10_blue,lwd=2,lty=2); abline(v=ch10_ss_tau[['tau_b']],col=ch10_orange,lwd=2)
  text(ci,par('usr')[4]*.92,c(paste0('2,5. percentil\n',ch10_num(ci[1])),paste0('97,5. percentil\n',ch10_num(ci[2]))),pos=c(2,4),cex=.76,col=ch10_blue)
},width=8,height=4.3)
ch10_draw('faktory', {
  par(mfrow=c(1,3),mar=c(4.4,4.2,3.6,.6),mgp=c(2.4,.6,0))
  d <- ch10_rr; adm <- d$test>=ch10_rr_cut
  plot(d$test,d$prospech,pch=16,col=ifelse(adm,ch10_blue,adjustcolor(ch10_mute,.8)),cex=.8,xlab='Přijímací test (body)',ylab='Výsledky v 1. ročníku (body)',bty='l',
       main=paste0('Omezení rozsahu\nvšichni r = ',ch10_num(ch10_rr_r[['vse']]),', přijatí r = ',ch10_num(ch10_rr_r[['prijati']])),cex.main=.92,font.main=1)
  abline(v=ch10_rr_cut,lty=2,col=ch10_gray)
  ext <- d$test<=quantile(d$test,.15)|d$test>=quantile(d$test,.85)
  plot(d$test,d$prospech,pch=16,col=ifelse(ext,ch10_orange,adjustcolor(ch10_mute,.8)),cex=.8,xlab='Přijímací test (body)',ylab='',bty='l',
       main=paste0('Jen krajní skupiny\nr = ',ch10_num(ch10_rr_r[['extremy']])),cex.main=.92,font.main=1)
  g <- ch10_cg; m <- g$trida=='mladší'
  plot(g$slova,g$rychlost,pch=ifelse(m,21,24),bg=ifelse(m,ch10_fill,ch10_sand),col=ifelse(m,ch10_blue,ch10_orange),cex=1.05,xlab='Slovní zásoba (body)',ylab='Rychlost čtení (slov za minutu)',bty='l',
       main=paste0('Dvě sloučené třídy\ncelkem r = ',ch10_num(ch10_cg_r[['vse']]),'; uvnitř ',ch10_num(ch10_cg_r[['mladsi']]),' a ',ch10_num(ch10_cg_r[['starsi']])),cex.main=.92,font.main=1)
  legend('bottomright',legend=c('mladší třída','starší třída'),pch=c(21,24),pt.bg=c(ch10_fill,ch10_sand),col=c(ch10_blue,ch10_orange),bty='n',cex=.85)
},width=10,height=4.3)
ch10_draw('shoda-hodnot', {
  par(mar=c(4.6,4.7,2.8,.8)); d <- ch10_rat
  plot(d$A,d$B,xlim=c(8,24),ylim=c(8,24),pch=21,bg=ch10_fill,col=ch10_blue,cex=1.4,xlab='Hodnotitelka A (body)',ylab='Hodnotitel B (body)',main=paste0('Vysoká korelace, ale ne shoda: r = ',ch10_num(ch10_rat_r)),bty='l',asp=1,font.main=1)
  abline(0,1,lty=2,col=ch10_gray); text(20.5,19.6,'shodné hodnoty',srt=45,cex=.78,col=ch10_gray)
},width=6.2,height=5)
options(ch10_old_options)
