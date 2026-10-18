# Independent known-value checks for chapter 7: examples, tables, exercises and figures.
if (.Platform$OS.type=='windows') Sys.setlocale('LC_CTYPE','.UTF-8')
source('scripts/kapitola_07.R',encoding='UTF-8')
eq <- function(actual,expected,tol=1e-10) stopifnot(isTRUE(all.equal(as.numeric(actual),as.numeric(expected),tolerance=tol)))
# Rounded comparison: the text quotes the value rounded to `d` places (half-up ties tolerated).
rq <- function(actual,expected,d) stopifnot(all(abs(as.numeric(actual)-as.numeric(expected))<=.5*10^(-d)+1e-9))
# t probabilities written out through the incomplete beta function, separately from pt().
tl <- function(t,v) { x <- v/(v+t^2); tail <- .5*pbeta(x,v/2,.5); ifelse(t>0,1-tail,tail) }
eq(tl(c(-2,1.3,2.45),c(24,7,55)),pt(c(-2,1.3,2.45),c(24,7,55)),1e-12)
# Running example: known sigma interval and margin of error.
eq(ch7_att[c('mu0','sigma','s','n','m')],c(50,10,10,25,46))
rq(qnorm(.975),1.960,3);rq(1.96*2,3.92,2);rq(ch7_ci_att_z,c(42.08,49.92),2);rq(2*qnorm(.975)*2,7.84,2)
# Widths: confidence level, sigma and sample size.
rq(2*qnorm(c(.95,.975,.995))*2,c(6.58,7.84,10.30),2);rq(2*qnorm(.975)*20/5,15.68,2);rq(2*qnorm(.975)*10/10,3.92,2)
# Repeated intervals of the simulation figure.
stopifnot(sum(ch7_hit_z)==94,sum(ch7_hit_t)==96,nrow(ch7_samples)==100,ncol(ch7_samples)==25)
eq(ch7_sim_z[,2]-ch7_sim_z[,1],rep(2*qnorm(.975)*2,100));rq(range(ch7_sim_t[,2]-ch7_sim_t[,1]),c(5.6,12.0),1)
# Statistic with s instead of sigma for samples of five.
rq(100*mean(abs(ch7_zstat5)>qnorm(.975)),4.8,1);rq(100*mean(abs(ch7_tstat5)>qnorm(.975)),12.4,1)
rq(2*tl(qnorm(.975),4)-1,.88,2);rq(pchisq(4,4),.59,2)
# t quantiles quoted in the text and exercises.
rq(qt(.975,c(4,9,24,99)),c(2.776,2.262,2.064,1.984),3);rq(qt(.025,24),-2.064,3);rq(qt(.025,10),-2.228,3)
rq(qt(.975,c(10,15,19,29,55,149)),c(2.228,2.131,2.093,2.045,2.004,1.976),3);rq(qt(.95,c(24,29,149,199)),c(1.711,1.699,1.655,1.653),3)
rq(qt(.975,4)/qnorm(.975)-1,.42,2)
# Interval with the t quantile.
rq(qt(.975,24)*2,4.13,2);rq(ch7_ci_att_t,c(41.87,50.13),2);rq(diff(ch7_ci_att_t)-diff(ch7_ci_att_z),.42,2);rq(diff(ch7_ci_att_t),8.26,2)
# Coverage of the wrong procedure with 1.96 and s.
rq(c(2*tl(qnorm(.975),24)-1,ch7_cov_wrong,2*tl(qnorm(.975),4)-1),c(.938,.918,.878),3)
# One-sample t-test on attention.
eq(ch7_t(46,10,25,50),-2);rq(tl(-2,24),.028,3);rq(tl(-2,24),.0285,4);rq(1-tl(-2,24),.9715,4);rq(2*tl(-2,24),.057,3);rq(2*tl(-2,24),.0569,4)
rq(qt(.05,24),-1.711,3);rq(50+qt(.05,24)*2,46.58,2);rq(46+qt(.95,24)*2,49.42,2);rq(46+c(-1,1)*qt(.95,24)*2,c(42.58,49.42),2)
# PDI (Howell, 2013, pp. 186-189).
se <- 12.584/sqrt(56);rq(se,1.682,3);rq(4.125/se,2.45,2);rq(2*tl(-4.125/se,55),.017,3);rq(104.125+c(-1,1)*qt(.975,55)*se,c(100.75,107.50),2)
# Interior of the interval as the set of non-rejected values (reject at p <= alpha).
u <- ch7_ci_att_t[2];eq(ch7_p2(46,10,25,u),.05,1e-12);rq(u,50.128,3);rq(ch7_p2(46,10,25,48),.33,2);rq(ch7_p2(46,10,25,50),.057,3)
mu <- seq(38,54,by=.001);inside <- mu[ch7_p2(46,10,25,mu)>.05];rq(range(inside),ch7_ci_att_t,2)
# Independent tail probabilities at and on both sides of both exact limits.
for (side in c(-1,1)) {
  boundary <- 46+side*qt(.975,24)*2
  probs <- 2*tl(-abs((46-(boundary+side*c(-1e-5,0,1e-5)))/2),24)
  stopifnot(probs[1]>.05,probs[3]<.05);eq(probs[2],.05,1e-12)
}
stopifnot(ch7_p2(46,10,25,50.128)<.05)
# Equivalence: consequences of shifts and the five studies.
rq(100*ch7_share,c(24.2,15.9,9.7),1)
e <- ch7_eq
rq(cbind(e$ci95_d,e$ci95_h),cbind(c(41.87,47.52,49.42,42.02,45.02),c(50.13,49.48,51.38,45.98,48.98)),2)
rq(cbind(e$ci90_d,e$ci90_h),cbind(c(42.58,47.68,49.58,42.34,45.34),c(49.42,49.32,51.22,45.66,48.66)),2)
rq(e$p_rozdil[c(1,2,3,5)],c(.057,.003,.42,.003),c(3,3,2,3));stopifnot(e$p_rozdil[4]<.001)
equiv <- e$ci90_d>=47 & e$ci90_h<=53;stopifnot(identical(equiv,c(FALSE,TRUE,TRUE,FALSE,FALSE)))
stopifnot(identical(equiv,e$p_tost<=.05));stopifnot(identical(e$p_rozdil<=.05,c(FALSE,TRUE,FALSE,TRUE,TRUE)))
# Touching either equivalence bound: p = alpha; nearby positions on opposite sides.
for (side in c(-1,1)) {
  q <- qt(.95,399);boundary_m <- 50+side*(3-q*.5)
  ps <- sapply(boundary_m+side*c(-1e-5,0,1e-5),function(m) max(ch7_tost(m,10,400,50,3)[c('p_dolni','p_horni')]))
  stopifnot(ps[1]<.05,ps[3]>.05);eq(ps[2],.05,1e-12)
}
stopifnot(e$ci95_h[4]<47,e$ci90_h[4]<47,e$ci90_d[5]<47,e$ci90_h[5]>47)
# Optional TOST p-values for studies B and A.
eq(ch7_eq_tost[2,c('t_dolni','t_horni')],c(3,-9));rq(ch7_eq_tost[2,'p_dolni'],.0014,4);stopifnot(ch7_eq_tost[2,'p_horni']<.001)
rq(ch7_eq_tost[1,'p_dolni'],.69,2);stopifnot(ch7_eq_tost[1,'p_horni']<.001);rq(qt(.95,399),1.649,3)
# Reporting example for study B.
rq(ch7_t(48.5,10,400,50),-3.00,2);rq(e$p_rozdil[2],.003,3);rq(e$p_tost[2],.001,3)
# Exercise 1.
rq(104.5+c(-1,1)*1.96*2.5,c(99.60,109.40),2);rq(qnorm(.995)*2.5,6.44,2);rq(104.5+c(-1,1)*qnorm(.995)*2.5,c(98.06,110.94),2);rq(2*pnorm(-1.8),.072,3)
# Exercise 3.
rq(2*1.96*10/sqrt(2000),.88,2)
# Exercise 5.
x <- ch7_u05;eq(c(sum(x),mean(x)),c(126,12.6));rq(sd(x),2.221,3);rq(sd(x)/sqrt(10),.702,3);rq(qt(.975,9)*sd(x)/sqrt(10),1.589,3)
rq(mean(x)+c(-1,1)*qt(.975,9)*sd(x)/sqrt(10),c(11.01,14.19),2);rq(mean(x)+c(-1,1)*1.96*sd(x)/sqrt(10),c(11.22,13.98),2)
rq((qt(.975,9)-1.96)*sd(x)/sqrt(10)*2,.42,2)
# Exercise 6.
eq(c(4.8/4,(32.4-30)/1.2),c(1.2,2));rq(2*tl(-2,15),.064,3);rq(tl(-2,15),.032,3);rq(32.4+c(-1,1)*qt(.975,15)*1.2,c(29.84,34.96),2)
# Exercise 7.
y <- ch7_u07;stopifnot(length(y)==20,range(y)==c(17,28));rq(mean(y),22.2,1);rq(sd(y),3.122,3);rq(sd(y)/sqrt(20),.698,3)
ty <- (mean(y)-20)/(sd(y)/sqrt(20));rq(ty,3.15,2);rq(2*tl(-ty,19),.005,3);rq(qt(.975,19)*sd(y)/sqrt(20),1.461,3)
rq(mean(y)+c(-1,1)*qt(.975,19)*sd(y)/sqrt(20),c(20.74,23.66),2)
# Q-Q solution uses the chapter-4 midpoint positions, not qqnorm's default.
eq(ch7_qq_p,(1:20-.5)/20);eq(ch7_qq_y,sort(y))
eq(pnorm(ch7_qq_z),ch7_qq_p);rq(range(ch7_qq_z),c(-1.959964,1.959964),6)
# Exercise 9.
rq(100*(1-pnorm(25,c(15,16,17,14,13),6)),c(4.8,6.7,9.1,3.3,2.3),1)
d <- 100*(1-pnorm(25,c(16,14,17),6))-100*(1-pnorm(25,15,6));rq(abs(d),c(1.9,1.4,4.3),1)
screen18 <- pnorm(25,18,6,lower.tail=FALSE);screen15 <- pnorm(25,15,6,lower.tail=FALSE)
rq(100*screen18,12.2,1);rq(screen18/screen15,2.546,3)
# Exercise 10 and 13.
for (n in c(150,30)) {
  se <- 6/sqrt(n);t1 <- (25.6-23)/se;t2 <- (25.6-27)/se;p1 <- 1-tl(t1,n-1);p2 <- tl(t2,n-1)
  if (n==150) {rq(se,.490,3);rq(25.6+c(-1,1)*qt(.95,149)*se,c(24.79,26.41),2);rq(25.6+c(-1,1)*qt(.975,149)*se,c(24.63,26.57),2)
    rq(2*tl(-.6/se,149),.22,2);rq(c(t1,t2),c(5.31,-2.86),2);stopifnot(p1<.001);rq(p2,.002,3);rq(max(p1,p2),.002,3)}
  if (n==30) {rq(se,1.095,3);rq(25.6+c(-1,1)*qt(.95,29)*se,c(23.74,27.46),2);rq(25.6+c(-1,1)*qt(.975,29)*se,c(23.36,27.84),2)
    rq(2*tl(-.6/se,29),.59,2);rq(c(t1,t2),c(2.37,-1.28),2);rq(c(p1,p2),c(.012,.106),3)}
}
# Exercise 11: 90 % limits follow from the 95 % limits for large samples.
c95 <- rbind(c(473.6,511.4),c(503,512),c(488,506),c(525,560),c(505,535))
c90 <- rbind(c(476.6,508.4),c(503.7,511.3),c(489.4,504.6),c(527.8,557.2),c(507.4,532.6))
mid <- rowMeans(c95);half <- (c95[,2]-c95[,1])/2*qnorm(.95)/qnorm(.975);rq(cbind(mid-half,mid+half),c90,1)
stopifnot(identical(c95[,1]>500|c95[,2]<500,c(FALSE,TRUE,FALSE,TRUE,TRUE)),identical(c90[,1]>480&c90[,2]<520,c(FALSE,TRUE,TRUE,FALSE,FALSE)))
rq(c90[2,2]-500,11,0);stopifnot(c90[4,1]>520)
# Exercise 12: the post-hoc bound.
rq(50-46.1,3.9,1)
# Exercise 14.
se <- 10/sqrt(200);rq(se,.707,3);rq(48.2-qt(.95,199)*se,47.03,2);rq(1-tl((48.2-47)/se,199),.046,3)
cat('Chapter 7 checks passed\n')
