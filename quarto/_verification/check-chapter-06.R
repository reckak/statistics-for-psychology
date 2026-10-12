# Independent known-value checks for chapter 6: examples, tables, exercises and figures.
if (.Platform$OS.type=='windows') Sys.setlocale('LC_CTYPE','.UTF-8')
source('scripts/kapitola_06.R',encoding='UTF-8')
eq <- function(actual,expected,tol=1e-10) stopifnot(isTRUE(all.equal(as.numeric(actual),as.numeric(expected),tolerance=tol)))
# Rounded comparison: the text quotes the value rounded to `d` places (half-up ties tolerated).
rq <- function(actual,expected,d) stopifnot(all(abs(as.numeric(actual)-as.numeric(expected))<=.5*10^(-d)+1e-9))
up <- function(z) pnorm(z,lower.tail=FALSE)
# Binomial probabilities written out separately from pbinom.
bin <- function(k,n,p) factorial(n)/(factorial(k)*factorial(n-k))*p^k*(1-p)^(n-k)
atleast <- function(k,n,p) sum(bin(k:n,n,p))
# Study summaries quoted from Howell and the teaching model.
eq(ch6_diff,39.03-32.15);eq(round(ch6_diff,2),6.88);rq(ch6_diff/32.15,.21,2);eq(14.6/sqrt(100),1.46)
eq(c(ch6_mu,ch6_sigma,ch6_shape*ch6_scale,sqrt(ch6_shape)*ch6_scale),c(35,15,35,15))
rq(qgamma(.5,shape=ch6_shape,scale=ch6_scale),32.9,1);rq((ch6_shape-1)*ch6_scale,29,0)
rq(pgamma(38,shape=ch6_shape,scale=ch6_scale,lower.tail=FALSE),.37,2)
rq(qgamma(c(.025,.975),shape=ch6_shape,scale=ch6_scale),c(12,70),0)
# Sampling distribution of a proportion: guessing on 20 and on 80 items.
eq(c(20*.25,round(sqrt(20*.25*.75),2)),c(5,1.94));rq(sqrt(.25*.75/c(20,80)),c(.097,.048),3)
rq(sum(bin(3:7,20,.25)),.807,3);rq(sum(dbinom(12:28,80,.25)),.973,3);rq(max(dbinom(0:20,20,.25)),.20,2)
eq(sqrt(.25*.75/80),sqrt(.25*.75/20)/2)
# Exact example: nine ordered pairs of three equally likely times.
eq(mean(ch6_three),35);eq(mean((ch6_three-35)^2),150);rq(sqrt(150),12.25,2)
stopifnot(nrow(ch6_pairs)==9);eq(ch6_pairs$prumer,c(20,27.5,35,27.5,35,42.5,35,42.5,50))
eq(ch6_exact$prumer,c(20,27.5,35,42.5,50));eq(ch6_exact$p,c(1,2,3,2,1)/9)
eq(sum(ch6_pairs$prumer),315);eq(mean(ch6_pairs$prumer),35);eq(sum((ch6_pairs$prumer-35)^2),675)
eq(sqrt(675/9),sqrt(150)/sqrt(2));rq(sqrt(75),8.66,2)
sums <- ch6_pairs$prvni+ch6_pairs$druha;eq(c(mean(sums),mean((sums-70)^2)),c(70,300));rq(sqrt(300),17.32,2)
# Simulated sampling distributions of the mean.
stopifnot(dim(ch6_means)==c(10000,4),ch6_sizes==c(2,5,30,100))
rq(rowMeans(ch6_shown),c(39.0,32.7,36.5,32.8,40.0,31.5,37.6,36.8),1)
rq(max(round(rowMeans(ch6_shown),1))-min(round(rowMeans(ch6_shown),1)),8.5,1)
rq(mean(ch6_one_sample),36.5,1);stopifnot(length(ch6_one_sample)==30);rq(range(ch6_one_sample),c(10,66),0)
rq(colMeans(ch6_means)[2:4],c(34.97,35.04,34.96),2);rq(apply(ch6_means,2,sd)[2:4],c(6.77,2.74,1.51),2)
rq(range(ch6_means[,'n5']),c(16,68),0);rq(range(ch6_means[,'n30']),c(26,49),0);rq(range(ch6_means[,'n100']),c(29,41),0)
# Standard error: formula, law of large numbers, estimated standard error.
rq(ch6_se(c(5,30,100)),c(6.71,2.74,1.50),2);rq(12.25/sqrt(2),8.66,2);rq(1/sqrt(2),.71,2)
eq(ch6_se(c(25,100,400)),c(3,1.5,.75));eq((50-35)/ch6_se(100),10)
rq(colMeans(abs(ch6_means-35)<=3)[2:4],c(.34,.73,.95),2);stopifnot(1-2*pnorm(-3/ch6_se(400))>.9999)
rq(sd(ch6_one_sample),14.9,1);rq(14.9/sqrt(30),2.72,2)
rq(range(apply(ch6_shown,1,sd)),c(11.93,17.55),2);rq(range(apply(ch6_shown,1,sd))/sqrt(30),c(2.18,3.20),2)
rq(quantile(ch6_sds100,c(.025,.975))/sqrt(100),c(1.25,1.77),2)
rq(range(rowMeans(ch6_shown)),c(31.5,40.0),1);rq(mean(ch6_one_sample)-35,1.5,1)
# Groups of different sizes from one population.
stopifnot(length(ch6_group_n)==150,range(ch6_group_n)==c(10,397),sum(ch6_group_extreme)==20)
eq(sum(ch6_group_n[ch6_group_extreme]<=50),17);eq(sum(ch6_group_n<=50),56);rq(56/150,.37,2)
rq(range(ch6_group_m),c(44.6,53.4),1)
eq(sum(ch6_group_n[rank(-ch6_group_m)<=10]<=50),8);eq(sum(ch6_group_n[rank(ch6_group_m)<=10]<=50),9)
# Shape: standardized means beyond 2 and below -2; other statistics.
z <- sweep(ch6_means-35,2,ch6_se(ch6_sizes),'/')
rq(100*colMeans(z>2),c(3.6,3.3,2.8,2.4),1);rq(100*colMeans(z< -2),c(.5,1.3,1.8,2.2),1);rq(100*up(2),2.3,1)
rq(sd(ch6_medians30),3.24,2);rq(sd(ch6_sds30),2.37,2);rq(mean(ch6_medians30),33.0,1)
stopifnot(min(ch6_sds30)>7,max(ch6_sds30)<27,sd(ch6_medians30)>sd(ch6_means[,'n30']))
# Worked probability of a sample mean and of a difference between two means.
eq(ch6_se(100),1.5);eq((38-35)/1.5,2);rq(pnorm(38,35,1.5),.9772,4);rq(up(2),.0228,4);rq(1/up(2),44,0)
eq(sum(ch6_means[,'n100']>38),243);rq(qnorm(c(.025,.975),35,1.5),c(32.06,37.94),2)
rq(quantile(ch6_means[,'n100'],c(.025,.975)),c(32.08,37.98),2)
rq(mean(ch6_diffs),.02,2);rq(sd(ch6_diffs),2.12,2);rq(ch6_se_diff,2.1213,4);eq(ch6_se_diff,sqrt(15^2/100+15^2/100));eq(15^2/100+15^2/100,4.5)
rq(3/2.1213,1.41,2);rq(up(3/ch6_se_diff),.0786,4);rq(2*.0786,.157,3);rq(2*up(3/ch6_se_diff),.157,3);rq(100*mean(abs(ch6_diffs)>3),16.0,1)
# Direction: a hypothetical difference of 4 s under three alternatives.
rq(c(2*up(4/ch6_se_diff),up(4/ch6_se_diff),pnorm(4/ch6_se_diff)),c(.059,.030,.970),3)
# Test of the parking difference inside the teaching model.
rq(6.88/2.1213,3.24,2);rq(ch6_diff/ch6_se_diff,3.243,3);rq(up(ch6_diff/ch6_se_diff),.0006,4);rq(2*up(ch6_diff/ch6_se_diff),.0012,4)
stopifnot(abs(1/(2*up(ch6_diff/ch6_se_diff))-800)<60)
rq(qnorm(.975),1.960,3);rq(1.96*2.1213,4.16,2);rq(ch6_crit,4.158,3)
eq(sum(abs(ch6_diffs)>=ch6_crit),497);rq(100*mean(abs(ch6_diffs)>=ch6_crit),5.0,1)
eq(c(sum(ch6_diffs>=ch6_diff),sum(ch6_diffs<= -ch6_diff)),c(7,4));rq(10000*2*up(ch6_diff/ch6_se_diff),12,0)
# Errors and power for specific alternatives; the hypothetical non-rejection.
rq(ch6_power(c(0,3,5,8)),c(.05,.29,.65,.96),2);rq(1-ch6_power(c(3,5,8)),c(.71,.35,.04),2)
se400 <- 15*sqrt(2/400);rq(se400,1.06,2);rq(ch6_power(3,qnorm(.975)*se400,se400),.81,2)
rq(up((qnorm(.95)*ch6_se_diff-3)/ch6_se_diff),.41,2)
rq(2.9/2.1213,1.37,2);rq(2*up(2.9/ch6_se_diff),.17,2);rq(1/(2*up(2.9/ch6_se_diff)),6,0)
rq((4.158-5)/2.1213,-.397,3);rq(up((4.158-5)/2.1213),.654,3);rq((-4.158-5)/2.1213,-4.32,2);stopifnot(pnorm((-4.158-5)/2.1213)<1e-4)
rq(1-pnorm(4.158,5,2.1213),.6543,4);rq(ch6_power(5),.654,3)
# Same difference of one point with 25 and with 2 500 people; standardized difference.
eq(10/sqrt(c(25,2500)),c(2,.2));eq(1/c(2,.2),c(.5,5));rq(2*up(.5),.62,2);stopifnot(2*up(5)<.001);rq(6.88/14.6,.47,2)
# Binomial test and z-test.
rq(vapply(7:11,atleast,numeric(1),n=20,p=.25),c(.214,.102,.041,.014,.004),3)
eq(qbinom(.95,20,.25),8);rq(atleast(10,20,.25),.0139,4);rq(atleast(9,20,.25),.0409,4);stopifnot(which.max(dbinom(0:20,20,.5))-1==10)
eq(10/sqrt(25),2);eq((46-50)/2,-2);rq(pnorm(-2),.023,3);rq(pnorm(-2),.0228,4);rq(up(-2),.9772,4);rq(2*pnorm(-2),.0455,4);rq(2*pnorm(-2),.046,3)
rq(50+qnorm(.05)*2,46.71,2);rq(qnorm(.05),-1.645,3);rq(50+c(-1,1)*qnorm(.975)*2,c(46.08,53.92),2);rq(50-qnorm(.05)*2,53.29,2)
# Limits of testing: many tests; the optional screening table.
rq(.95^20,.36,2);rq(1-.95^20,.64,2);eq(20*.05,1)
eq(c(100*.8,100*.2,900*.05,900*.95),c(80,20,45,855));eq(45/125,.36);eq(c(500*.8,500*.05),c(400,25));rq(25/425,.06,2);eq(100*.3,30)
# Exercises 1 to 5.
rq(1.2/sqrt(50),.170,3);rq(1.2/sqrt(200),.085,3)
v <- c(1,2,6);eq(mean(v),3);eq(mean((v-3)^2),14/3);rq(sqrt(14/3),2.160,3)
g <- expand.grid(b=v,a=v);m <- (g$a+g$b)/2;eq(m,c(1,1.5,3.5,1.5,2,4,3.5,4,6));eq(sum(m),27);eq(sum((m-3)^2),21)
rq(sqrt(21/9),1.528,3);eq(sqrt(21/9),sqrt(14/3)/sqrt(2));eq(sum(m>=4),3);eq(as.numeric(table(m)),c(1,2,1,2,2,1))
rq(sqrt(.4*.6/c(25,100)),c(.098,.049),3);rq(atleast(13,25,.4),.154,3);rq(sum(dbinom(52:100,100,.4)),.010,3);eq(c(.52*25,.52*100),c(13,52))
a <- c(22,25,28,30,31,33,36,40,43);b <- c(20,26,29,33,35,38,41,47,55)
eq(c(sum(a),mean(a),sum((a-32)^2),var(a)),c(288,32,372,46.5));rq(c(sd(a),sd(a)/3),c(6.82,2.27),2)
eq(c(sum(b),mean(b),sum((b-36)^2),var(b)),c(324,36,926,115.75));rq(c(sd(b),sd(b)/3),c(10.76,3.59),2)
eq(9/sqrt(9),3);eq(c(32-34,36-34),c(-2,2))
rq(up(5/15),.369,3);rq(up(1),.159,3);rq(100+c(-1,1)*1.96*5,c(90.2,109.8),1);rq(100+c(-1,1)*1.96*15,c(70.6,129.4),1);rq(up(2),.023,3)
# Exercises 8 to 10.
eq(c(choose(8,7),choose(8,8),choose(8,6)),c(8,1,28));eq(atleast(7,8,.5),9/256);eq(atleast(6,8,.5),37/256);eq(atleast(8,8,.5),1/256)
rq(c(9/256,37/256,1/256),c(.035,.145,.004),3);eq(7/8,.875);rq(256/37,7,0)
eq(15/sqrt(36),2.5);eq((104.5-100)/2.5,1.8);rq(2*up(1.8),.072,3);rq(100+c(-1,1)*1.96*2.5,c(95.1,104.9),1);rq(up(1.8),.036,3);rq(100+1.645*2.5,104.1,1)
pw <- function(d,se) {cr <- qnorm(.975)*se;pnorm(-cr,d,se)+pnorm(cr,d,se,lower.tail=FALSE)}
rq(c(pw(2,2),pw(5,2),pw(2,1),pw(5,1)),c(.17,.71,.52,1.00),2);rq(1-c(pw(2,2),pw(5,2),pw(2,1)),c(.83,.29,.48),2);stopifnot(1-pw(5,1)<.005)
# Exercises 12 to 14.
rq(2*up(.5),.617,3);rq(.95^20,.358,3);rq(1-.95^20,.642,3)
rq(50-1.645*2,46.71,2);rq(pnorm(46.71,45,2),.804,3);rq(pnorm(46.71,47,2),.442,3);rq(50-1.645*1,48.355,3);rq(pnorm(48.355,47,1),.912,3)
eq(c(200*.6,200*.4,800*.05,800*.95),c(120,80,40,760));eq(40/160,.25);eq(200*.9,180);rq(40/220,.182,3)
# All generated figures exist and have nonempty SVG content.
files <- list.files(ch6_out,pattern='\\.svg$',full.names=TRUE)
stopifnot(length(files)==16,all(file.info(files)$size>1000))
cat('Chapter 6: values of the text, optional boxes, fourteen exercises and 16 figures passed.\n')
