# Independent known-value checks for chapter 5: examples, tables, exercises and figures.
if (.Platform$OS.type=='windows') Sys.setlocale('LC_CTYPE','.UTF-8')
source('scripts/kapitola_05.R',encoding='UTF-8')
eq <- function(actual,expected,tol=1e-10) stopifnot(isTRUE(all.equal(as.numeric(actual),as.numeric(expected),tolerance=tol)))
# Direct binomial formula, written out separately from dbinom.
bin <- function(k,n,p) factorial(n)/(factorial(k)*factorial(n-k))*p^k*(1-p)^(n-k)
# Opening example and simulated runs quoted in the text.
ch2 <- read.csv('data/kapitola_02.csv',fileEncoding='UTF-8');eq(c(nrow(ch2),sum(ch2$odpocatost==3)),c(36,14));eq(round(14/36,3),.389)
stopifnot(dim(ch5_runs)==c(1000,5))
eq(range(ch5_runs[10,]),c(.2,.6));eq(range(ch5_runs[50,]),c(.2,.34));eq(round(range(ch5_runs[1000,]),3),c(.244,.267))
# The run with six hits in ten tips: 267 hits in total, 261 in the remaining 990.
j <- which(ch5_runs[10,]==.6);stopifnot(length(j)==1);eq(ch5_runs[1000,j]*1000,267);eq(round(261/990,3),.264)
# Cards: events, complement, mutually exclusive union, drawing two cards.
eq(ch5_cards/sum(ch5_cards),c(.40,.35,.25));eq(1-.40,60/100);eq(.40+.35,.75)
eq(40/100*39/99,1560/9900);eq(round(1560/9900,3),.158);eq(.4*.4,.16)
# Dependent table: joint, marginal, conditional, union, addition rule, product check.
d <- ch5_dependent;n <- sum(d)
eq(n,200);eq(d['Žena','Zvýšený stres']/n,.20);eq(sum(d['Žena',],d['Muž','Zvýšený stres'])/n,.65)
eq(sum(d['Žena',])/n+sum(d[,'Zvýšený stres'])/n-d['Žena','Zvýšený stres']/n,.65);eq(sum(d[,'Zvýšený stres'])/n,.35)
eq(d['Muž','Nízký stres']/n,.35);eq(d['Žena','Zvýšený stres']/n+d['Muž','Zvýšený stres']/n,.35)
eq(d['Žena','Zvýšený stres']/sum(d['Žena',]),.40);eq(round(d['Žena','Zvýšený stres']/sum(d[,'Zvýšený stres']),2),.57)
eq((d['Žena','Zvýšený stres']/n)/(sum(d['Žena',])/n),.40);eq(.50*.40,.20);eq(.35*(40/70),.20)
stopifnot(abs(d['Žena','Zvýšený stres']/n-.5*.35)>.02);eq(.5*.35,.175);eq(.5+.35,.85)
# Independent table: equal conditional proportions and the product rule.
i <- ch5_independent
eq(c(i['Žena','Zvýšený stres']/sum(i['Žena',]),i['Muž','Zvýšený stres']/sum(i['Muž',]),sum(i[,'Zvýšený stres'])/sum(i)),rep(.30,3))
eq(i['Žena','Zvýšený stres']/sum(i),.5*.3)
# Reverse direction: stress level does not change the probability of being a woman.
eq(c(i['Žena','Zvýšený stres']/sum(i[,'Zvýšený stres']),i['Žena','Nízký stres']/sum(i[,'Nízký stres']),sum(i['Žena',])/sum(i)),rep(.50,3))
eq(c(sum(i[,'Zvýšený stres']),sum(i[,'Nízký stres'])),c(60,140))
# Diagram from experiment to distribution: two tips, four outcomes, X = number correct.
eq(ch5_two,c(.5625,.1875,.1875,.0625));eq(sum(ch5_two),1)
eq(ch5_two_dist,dbinom(0:2,2,.25));eq(ch5_two['NS']+ch5_two['SN'],.375);eq(sum(ch5_two_dist),1)
# Two independent tips; at least one correct through the complement.
eq(.25^2,.0625);eq(1-.75^2,.4375)
# Screening: natural frequencies, predictive values, total probability, Bayes.
f <- ch5_screen(1000,.10)
eq(f,c(100,900,95,5,90,810));eq(f['tp']+f['fp'],185);eq(f['tn']+f['fn'],815)
eq(ch5_ppv(f),95/185);eq(round(ch5_ppv(f),3),.514);eq(ch5_npv(f),810/815);eq(round(ch5_npv(f),3),.994)
eq(.10*.95+.90*.10,.185);eq(.10*.95/(.10*.95+.90*.10),95/185);eq(round(5/815,3),.006)
g <- ch5_screen(10000,.01);eq(g,c(100,9900,95,5,990,8910));eq(ch5_ppv(g),95/1085);eq(round(ch5_ppv(g),3),.088)
h <- ch5_screen(10000,.10);eq(h[c('tp','fp')],c(950,900));eq(ch5_ppv(h),ch5_ppv(f))
# Optional odds box.
eq(.75/.25,3);eq(3/(1+3),.75);eq(round(.10/.90,2),.11);eq(round(.01/.99,4),.0101);eq(.90/.10,9);eq(round(95/90,2),1.06)
# Distribution of the number of correct tips, n = 5 and probability 0.25.
p5 <- dbinom(0:5,5,.25)
eq(p5,bin(0:5,5,.25));eq(sum(p5),1)
eq(round(p5,3),c(.237,.396,.264,.088,.015,.001));eq(sum(round(p5,3)),1.001)
eq(round(p5,4),c(.2373,.3955,.2637,.0879,.0146,.0010));eq(round(sum(p5[4:6]),3),.104);eq(.088+.015+.001,.104)
eq(choose(5,0:5),c(1,5,10,10,5,1));eq(sum(choose(5,0:5)),2^5)
eq(round(.25^(0:5)*.75^(5:0),4),c(.2373,.0791,.0264,.0088,.0029,.0010))
eq(.25^2*.75^3,.0263671875);eq(10*.0263671875,.263671875);eq(round(10*.0264,3),.264)
# Simulated 40 students used in the model-versus-data figure.
stopifnot(length(ch5_sim_hadani)==40);eq(as.numeric(table(factor(ch5_sim_hadani,levels=0:5))),c(13,15,10,2,0,0))
eq(13/40,.325);eq(mean(ch5_sim_hadani),41/40)
# Expected value and variance: formulas and the optional table.
mu <- sum(0:5*p5);v <- sum((0:5-mu)^2*p5)
eq(mu,1.25);eq(v,.9375);eq(c(mu,v),c(5*.25,5*.25*.75));eq(round(sqrt(v),3),.968)
eq(round(0:5*p5,4),c(0,.3955,.5273,.2637,.0586,.0049));eq((0:5-1.25)^2,c(1.5625,.0625,.5625,3.0625,7.5625,14.0625))
eq(round((0:5-1.25)^2*p5,4),c(.3708,.0247,.1483,.2692,.1108,.0137))
# Counting.
eq(factorial(c(3,4,5,10,0)),c(6,24,120,3628800,1));eq(5*4/2,choose(5,2));eq(factorial(5)/(factorial(2)*factorial(3)),10)
stopifnot(ncol(combn(5,2))==10);eq(100*99*98,970200);eq(970200/6,choose(100,3));eq(choose(100,3),161700)
# Longer test, n = 20.
eq(c(20*.25,round(sqrt(20*.25*.75),2)),c(5,1.94))
eq(round(c(dbinom(5,20,.25),pbinom(5,20,.25),1-pbinom(9,20,.25)),3),c(.202,.617,.014))
eq(1-pbinom(9,20,.25),sum(bin(10:20,20,.25)));eq(qbinom(.95,20,.25),8)
eq(round(pbinom(c(7,8),20,.25),2),c(.90,.96));eq(round(1/(1-pbinom(9,20,.25))),72);eq(round(500*(1-pbinom(9,20,.25))),7)
stopifnot(which.max(dbinom(0:20,20,.5))-1==10)
# Exactly nine versus nine or more out of ten; a single value becomes rare with many trials.
eq(dbinom(9,10,.5),10*.5^10);eq(round(c(dbinom(9,10,.5),dbinom(10,10,.5),1-pbinom(8,10,.5)),4),c(.0098,.0010,.0107))
stopifnot(which.max(dbinom(0:200,200,.6))-1==120);eq(round(dbinom(120,200,.6),3),.058)
# Normal approximation and proportions.
s <- sqrt(200*.6*.4)
eq(c(200*.6,200*.4),c(120,80));eq(round(s,3),6.928);eq(round(15/s,3),2.165);eq(round(14.5/s,3),2.093)
eq(round(c(pnorm(15/s,lower.tail=FALSE),1-pbinom(134,200,.6),pnorm(14.5/s,lower.tail=FALSE)),4),c(.0152,.0173,.0182))
eq(round(pnorm(2.165,lower.tail=FALSE),3),.015)
eq(round(100*((1-pbinom(134,200,.6))-pnorm(15/s,lower.tail=FALSE))/(1-pbinom(134,200,.6))),12)
eq(round(c(1-pbinom(9,20,.25),pnorm(5/sqrt(3.75),lower.tail=FALSE)),4),c(.0139,.0049));eq(round(5/1.94,2),2.58)
stopifnot((1-pbinom(9,20,.25))/pnorm(5/sqrt(3.75),lower.tail=FALSE)>2.8)
eq(135/200,.675);eq(round(sqrt(.6*.4/200),5),.03464);eq(.075/sqrt(.6*.4/200),15/s)
eq(round(sqrt(.6*.4/c(50,200,800)),3),c(.069,.035,.017));eq(sqrt(.24/800),sqrt(.24/200)/2)
# Exercises 1, 3 and 4.
eq(c(18/60,(24+12)/60,1-24/60,(18+12+6)/60,12/60),c(.3,.6,.6,.6,.2))
eq(c(81/150,54/150,54/80),c(.54,.36,.675));eq(round(c(54/81,107/150),3),c(.667,.713));eq(80/150+81/150-54/150,107/150);eq((80/150)*(81/150),.288)
# 0.0625 and 0.4375 are exact ties: the text rounds half up (0,063; 0,438) as Excel does, so compare unrounded.
eq(c(.25^2,1-.75^2),c(.0625,.4375));eq(round(4/10*3/9,3),.133);eq(.4*.4,.16)
# Exercises 6 and 7.
e <- ch5_screen(1000,.05,.80,.90);eq(e,c(50,950,40,10,95,855))
eq(round(c(ch5_ppv(e),ch5_npv(e),10/865),3),c(.296,.988,.012));eq(.05*.80+.95*.10,.135);eq(.040/.135,40/135)
e2 <- ch5_screen(1000,.20,.80,.90);eq(e2[c('tp','fp')],c(160,80));eq(round(ch5_ppv(e2),3),.667)
eq(c(15*.8,85*.2),c(12,17));eq(.15*.8/(.15*.8+.85*.2),12/29);eq(round(12/29,3),.414);eq(40/50,.8)
# Exercises 8 and 9.
eq(sum(c(.10,.40,.35,.15)),1);eq(c(.35+.15,.10+.40),c(.5,.5));eq(c(3,7,8,2)/20,c(.15,.35,.40,.10))
stopifnot(max(abs(c(3,7,8,2)/20-c(.10,.40,.35,.15)))<=.05+1e-12)
eq(choose(4,3),4);eq(dbinom(3,4,.5),.25);eq(1-pbinom(2,4,.5),.3125);eq(c(4*.5,sqrt(4*.5*.5)),c(2,1))
# Exercises 10 and 11.
eq(c(15*.2,round(sqrt(15*.2*.8),3)),c(3,1.549))
eq(round(c(dbinom(3,15,.2),pbinom(3,15,.2)),3),c(.250,.648));eq(round(1-pbinom(6,15,.2),4),.0181);eq(round(1/(1-pbinom(6,15,.2))),55)
eq(c(100*.5,sqrt(100*.5*.5),(65-50)/5,(64.5-50)/5),c(50,5,3,2.9))
eq(round(c(pnorm(3,lower.tail=FALSE),1-pbinom(64,100,.5),pnorm(2.9,lower.tail=FALSE)),4),c(.0013,.0018,.0019))
eq(c(sqrt(.5*.5/100),(.65-.5)/.05),c(.05,3))
# Exercise 12: complement of three independent failures; drawing without replacement.
eq(1-.3^3,1-dbinom(0,3,.7));eq(7/12*6/11*5/10,choose(7,3)/choose(12,3))
# All generated figures exist and have nonempty SVG content.
files <- list.files(ch5_out,pattern='\\.svg$',full.names=TRUE)
stopifnot(length(files)==13,all(file.info(files)$size>1000))
cat('Chapter 5: values of the text, optional boxes, twelve exercises and 13 figures passed.\n')
