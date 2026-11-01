# Independent known-value checks for chapter 8: examples, tables, exercises and figures.
if (.Platform$OS.type=='windows') Sys.setlocale('LC_CTYPE','.UTF-8')
source('scripts/kapitola_08.R',encoding='UTF-8')
eq <- function(actual,expected,tol=1e-10) stopifnot(isTRUE(all.equal(as.numeric(actual),as.numeric(expected),tolerance=tol)))
# Rounded comparison: the text quotes the value rounded to `d` places (half-up ties tolerated).
rq <- function(actual,expected,d) stopifnot(all(abs(as.numeric(actual)-as.numeric(expected))<=.5*10^(-d)+1e-9))
# t probabilities through the incomplete beta function and quantiles by root finding, separately from pt()/qt().
tl <- function(t,v) { x <- v/(v+t^2); tail <- .5*pbeta(x,v/2,.5); ifelse(t>0,1-tail,tail) }
p2 <- function(t,v) 2*tl(-abs(t),v)
tq <- function(p,v) uniroot(function(x) tl(x,v)-p,c(-50,50),tol=1e-12)$root
eq(tl(c(-2,1.3,5.07),c(11,13.95,198)),pt(c(-2,1.3,5.07),c(11,13.95,198)),1e-12)
# The R procedures agree with stats::t.test on raw data.
tt <- t.test(ch8_par_u$bezny,ch8_par_u$kratky,paired=TRUE)
eq(ch8_par_res[c('t','p')],c(tt$statistic,tt$p.value),1e-12);eq(ch8_par_res[c('dolni','horni')],tt$conf.int,1e-12)
tw <- t.test(ch8_sk_bezny,ch8_sk_kratky);tp <- t.test(ch8_sk_bezny,ch8_sk_kratky,var.equal=TRUE)
eq(ch8_sk_welch[c('t','df','p')],c(tw$statistic,tw$parameter,tw$p.value),1e-12);eq(ch8_sk_welch[c('dolni','horni')],tw$conf.int,1e-12)
eq(ch8_sk_pool[c('t','p')],c(tp$statistic,tp$p.value),1e-12);eq(ch8_sk_pool[c('dolni','horni')],tp$conf.int,1e-12)
# Paired version A: complete pairs, column means, test and interval (table and text).
stopifnot(sum(ch8_par_ok)==12,!ch8_par_ok[9]);eq(ch8_par_d,c(5,2,6,1,7,3,4,-1,5,2,6,2))
rq(ch8_par_cols,c(50.54,46.83),2);rq(diff(rev(ch8_par_cols)),3.71,2)
d <- ch8_par_d;m <- mean(d);s <- sd(d);se <- s/sqrt(12);t <- m/se
eq(m,3.5);rq(s,2.393,3);rq(se,.691,3);rq(t,5.07,2);rq(t,5.066,3);rq(p2(t,11),.0004,4);rq(tq(.975,11),2.201,3)
rq(tq(.975,11)*se,1.52,2);rq(m+c(-1,1)*tq(.975,11)*se,c(1.98,5.02),2)
rq(c(mean(ch8_par_u$bezny),sd(ch8_par_u$bezny),mean(ch8_par_u$kratky),sd(ch8_par_u$kratky)),c(50.33,7.34,46.83,6.42),2)
# Wrong analysis as two independent groups (table 4).
w <- ch8_par_wrong;rq(w['se'],2.82,2);rq(w['t'],1.24,2);eq(w['df'],22);rq(w['p'],.227,3);rq(c(w['dolni'],w['horni']),c(-2.34,9.34),2)
rq((w['horni']-w['dolni'])/(ch8_par_res['horni']-ch8_par_res['dolni']),3.8,1)
# Tripled values: order preserved, SD of differences doubles.
eq(c(sd(ch8_troj_x),sd(ch8_troj_y),sd(ch8_troj_y-ch8_troj_x)),c(2,6,4))
# SD of differences and precision of the mean difference are distinct comparisons.
troj_paired_se <- sd(ch8_troj_y-ch8_troj_x)/sqrt(3)
troj_independent_se <- sqrt((var(ch8_troj_x)+var(ch8_troj_y))/3)
stopifnot(troj_paired_se<troj_independent_se)
eq(4/(1/29+1/11),31.9) # Equal variance contributions alone do not give 40 Welch df.
# Anorexia in kilograms: conversion keeps t; summaries quoted in the text and workbook.
a <- ch8_anor;rq(a[c('m_pred','m_po')],c(37.75,41.05),2);rq(a[c('m_d','s_d')],c(3.30,3.25),2);rq(a[c('m_d','s_d','s_pred')],c(3.295,3.247,2.276),3)
r <- ch8_anor_res;rq(r['se'],.787,3);rq(r['t'],4.18,2);rq(r['p'],.0007,4);rq(c(r['dolni'],r['horni']),c(1.63,4.96),2)
eq(ch8_anor_lb['m_d']/(ch8_anor_lb['s_d']/sqrt(17)),r['t'],1e-12);rq(ch8_anor_d_pred,1.45,2);rq(ch8_anor_d_z,1.01,2)
# Parking without known sigma (Howell, p. 86).
pk <- ch8_park;rq(pk['se'],2.065,3);rq(pk['t'],3.33,2);rq(pk['t'],3.332,3);eq(pk['df'],198);rq(pk['p'],.001,3);rq(tq(.975,198),1.972,3)
rq(c(pk['dolni'],pk['horni']),c(2.81,10.95),2);rq(pk['d'],.47,2);rq(pk['d'],.4712,4);eq(ch8_park_welch[c('t','df')],pk[c('t','df')],1e-12)
rq(6.88/(15*sqrt(2/100)),3.24,2)
# Version B: summaries, classic and Welch (table 6 and text).
rq(c(mean(ch8_sk_bezny),sd(ch8_sk_bezny),mean(ch8_sk_kratky),sd(ch8_sk_kratky)),c(50,7.97,42,14),2)
stopifnot(length(ch8_sk_bezny)==30,length(ch8_sk_kratky)==12,min(ch8_sk_kratky)==23,max(ch8_sk_kratky)==59)
b <- ch8_sk_pool;rq(b['sp'],10.00,2);rq(b['se'],3.415,3);rq(b['t'],2.34,2);eq(b['df'],40);rq(b['p'],.024,3);rq(c(b['dolni'],b['horni']),c(1.10,14.90),2);rq(b['d'],.80,2)
v <- ch8_sk_welch;rq(var(ch8_sk_bezny)/30,2.117,3);rq(var(ch8_sk_kratky)/12,16.333,3);rq(v['se'],4.295,3);rq(v['t'],1.86,2);rq(v['t'],1.8625,4)
rq(v['df'],13.95,2);rq(v['df'],13.948,3);rq(v['p'],.084,3);rq(v['p'],.0837,4);rq(tq(.975,v['df']),2.146,3);rq(tq(.975,v['df']),2.1455,4)
rq(v['q']*v['se'],9.22,2);rq(c(v['dolni'],v['horni']),c(-1.22,17.22),2);rq(qt(.975,13),2.1604,4);rq(qt(.975,13),2.160,3)
# Welch df worked in the optional block: numerator and denominator.
aa <- var(ch8_sk_bezny)/30;bb <- var(ch8_sk_kratky)/12;rq((aa+bb)^2,340.4,1);rq(aa^2/29,.155,3);rq(bb^2/11,24.25,2)
# Two groups side by side: overlap and interval of the difference.
rq(ch8_vedle_ci,c(41.87,47.87,50.13,56.13),2);rq(ch8_vedle_ci['kratky',2]-ch8_vedle_ci['bezny',1],2.26,2)
x <- ch8_vedle;rq(x['t'],2.12,2);eq(x['df'],48);rq(x['p'],.039,3);rq(c(x['dolni'],x['horni']),c(.31,11.69),2)
rq(tq(.975,24)*2,4.13,2);rq(2*tq(.975,24)*2,8.26,2);rq(tq(.975,48),2.011,3);rq(x['se'],2.828,3);rq(x['q']*x['se'],5.69,2)
rq(ch8_par_ci,c(42.75,45.67,50.91,55.00),2)
# Change in two groups (table 9) and the Gelman-Stern example.
i <- ch8_tr_i;k <- ch8_tr_k;dz <- ch8_tr_rozdil
rq(c(i['m'],i['s'],i['t'],i['p'],i['dolni'],i['horni']),c(4,6.82,2.35,.033,.37,7.63),2)
rq(i['p'],.033,3);rq(k['p'],.183,3);rq(dz['p'],.376,3)
rq(c(k['m'],k['s'],k['t'],k['dolni'],k['horni']),c(2,5.73,1.40,-1.05,5.05),2)
rq(c(dz['rozdil'],dz['sp'],dz['se'],dz['t'],dz['dolni'],dz['horni']),c(2,6.30,2.23,.90,-2.55,6.55),2);eq(dz['df'],30)
stopifnot(all(ch8_tr$zmena==c(ch8_tr_zmena_i,ch8_tr_zmena_k)),nrow(ch8_tr)==32)
eq(t.test(ch8_tr_zmena_i,ch8_tr_zmena_k)$p.value,t.test(ch8_tr_zmena_i,ch8_tr_zmena_k,var.equal=TRUE)$p.value,1e-2)
rq(sqrt(10^2+10^2),14,0)
# Equivalence of two test versions (text, figure, optional block).
e <- ch8_ekv_res
rq(e['velká',c('se','d95','h95','p','d90','h90')],c(1,-2.87,1.07,.369,-2.55,.75),2);rq(e['velká','p'],.369,3)
rq(tq(.975,398),1.966,3);rq(tq(.95,398),1.649,3)
rq(e['malá',c('se','d95','h95','d90','h90')],c(2.58,-6.07,4.27,-5.22,3.42),2);rq(e['malá','p'],.729,3)
stopifnot(e['velká','d90']>=-3,e['velká','h90']<=3,e['malá','d90']< -3,e['malá','h90']>3)
rq(1-tl(2.1,398),.018,3);rq(tl(-3.9,398),.0001,4)
# Exercises.
rq(c(4/sqrt(20),2.5/(4/sqrt(20))),c(.894,2.80),c(3,2));rq(p2(2.5/(4/sqrt(20)),19),.012,3);rq(tq(.975,19),2.093,3)
rq(2.5+c(-1,1)*tq(.975,19)*4/sqrt(20),c(.63,4.37),2);rq(tq(.975,19)*4/sqrt(20),1.87,2)
u3 <- ch8_u03;stopifnot(sum(ch8_u03_ok)==13,is.na(u3$nekongr[7]),is.na(u3$kongr[9]))
eq(ch8_u03_d,c(77,57,81,59,54,83,72,77,78,67,67,58,85))
m3 <- mean(ch8_u03_d);s3 <- sd(ch8_u03_d);se3 <- s3/sqrt(13)
rq(c(m3,s3,se3),c(70.38,10.75,2.98),2);rq(m3/se3,23.6,1);stopifnot(p2(m3/se3,12)<.001);rq(tq(.975,12),2.179,3)
rq(m3+c(-1,1)*tq(.975,12)*se3,c(63.89,76.88),2)
rq(c(mean(u3$kongr,na.rm=TRUE),mean(u3$nekongr,na.rm=TRUE)),c(653.7,718.8),1);rq(mean(u3$nekongr,na.rm=TRUE)-mean(u3$kongr,na.rm=TRUE),65.1,1)
eq(t.test(u3$nekongr,u3$kongr,paired=TRUE)$p.value,p2(m3/se3,12),1e-10)
sp2 <- (10*3.17^2+11*3.03^2)/21;rq(c(10*3.17^2,11*3.03^2),c(100.49,100.99),2);rq(sp2,9.594,3);rq(sqrt(sp2),3.097,3)
se5 <- sqrt(sp2*(1/11+1/12));rq(se5,1.293,3);rq(3.06/se5,2.37,2);rq(p2(3.06/se5,21),.028,3);rq(tq(.975,21),2.080,3)
rq(3.06+c(-1,1)*tq(.975,21)*se5,c(.37,5.75),2);rq(tq(.975,21)*se5,2.69,2);rq(3.06/sqrt(sp2),.99,2)
w5 <- ch8_welch(9.64,3.17,11,6.58,3.03,12);rq(w5['t'],2.36,2);rq(w5['df'],20.62,2);rq(w5['p'],.028,3)
rq(c(3.17^2/11,3.03^2/12),c(.9135,.7651),4);rq((3.17^2/11+3.03^2/12)^2,2.818,3);rq(c((3.17^2/11)^2/10,(3.03^2/12)^2/11),c(.0835,.0532),4)
rq(c(mean(ch8_u06_a),sd(ch8_u06_a),mean(ch8_u06_b),sd(ch8_u06_b)),c(64.1,19.24,52.0,5.55),2)
w6 <- ch8_welch(mean(ch8_u06_a),sd(ch8_u06_a),10,mean(ch8_u06_b),sd(ch8_u06_b),25);p6 <- ch8_pooled(mean(ch8_u06_a),sd(ch8_u06_a),10,mean(ch8_u06_b),sd(ch8_u06_b),25)
rq(c(w6['se'],w6['df'],w6['t']),c(6.19,9.61,1.96),2);rq(t.test(ch8_u06_a,ch8_u06_b)$p.value,.080,3);rq(tq(.975,w6['df']),2.241,3);rq(qt(.975,9),2.262,3)
rq(c(w6['dolni'],w6['horni']),c(-1.76,25.96),2);rq(c(p6['sp'],p6['se'],p6['t']),c(11.11,4.16,2.91),2);eq(p6['df'],33);rq(p6['p'],.006,3);rq(c(p6['dolni'],p6['horni']),c(3.64,20.56),2)
rq(c(1.118,1.163),c(5/sqrt(20),5.2/sqrt(20)),3);rq(c(3.1/(5/sqrt(20)),1.2/(5.2/sqrt(20))),c(2.773,1.032),3);rq(c(p2(2.773,19),p2(1.032,19)),c(.012,.315),3)
p9 <- ch8_pooled(3.1,5,20,1.2,5.2,20);rq(p9['sp2'],26.02,2);rq(p9['sp'],5.101,3);rq(p9['se'],1.613,3);rq(p9['t'],1.178,3);rq(p9['p'],.246,3);rq(tq(.975,38),2.024,3)
rq(c(p9['dolni'],p9['horni']),c(-1.37,5.17),2)
for (n in c(250,40)) { r95 <- ch8_pooled(30.6,8,n,30,8,n,.95);r90 <- ch8_pooled(30.6,8,n,30,8,n,.90)
  if (n==250) {rq(r95['se'],.716,3);rq(c(r95['dolni'],r95['horni'],r90['dolni'],r90['horni']),c(-.81,2.01,-.58,1.78),2)}
  else {rq(r95['se'],1.789,3);rq(c(r95['dolni'],r95['horni'],r90['dolni'],r90['horni']),c(-2.96,4.16,-2.38,3.58),2)} }
rq(c(1-3/(4*21-1),.9879*(1-3/83)),c(.964,.95),c(3,2));rq(100*3/83,3.6,1);rq(c(1-3/(4*198-1),1-3/(4*18-1)),c(.996,.958),3)
cat('Chapter 8 checks passed.\n')
