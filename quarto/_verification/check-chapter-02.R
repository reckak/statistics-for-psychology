# Independent base-R verification of data, calculations and quantitative solutions.
d <- read.csv('data/kapitola_02.csv', na.strings='', fileEncoding='UTF-8')
eq <- function(actual, expected) stopifnot(isTRUE(all.equal(as.numeric(actual), as.numeric(expected))))
freq <- function(x, levels) as.numeric(table(factor(x,levels=levels)))
bins <- function(x,lower) vapply(lower,function(lo) sum(x > lo & x <= lo+1,na.rm=TRUE),integer(1))
stopifnot(nrow(d)==36, !anyDuplicated(d$id), identical(d$id,sprintf('P%02d',1:36)),
          all(d$odpocatost %in% 1:4), all(d$slova %in% 0:12),
          identical(d$id[is.na(d$spanek_h)],c('P05','P11','P24')))
eq(d$spanek_h[1:6],c(6,8,7,5,NA,7));eq(d$slova[1:6],c(5,9,8,6,7,0));eq(d$odpocatost[1:6],c(2,4,3,2,3,1))
f <- freq(d$odpocatost,1:4)
eq(f,c(4,10,14,8));eq(cumsum(f),c(4,14,28,36));eq(round(f/36,3),c(.111,.278,.389,.222))
eq(round(cumsum(f)/36,3),c(.111,.389,.778,1));eq(round(100*f/36,1),c(11.1,27.8,38.9,22.2))
eq(sum(f/36),1);eq(round(rep(1/3,3),3),rep(.333,3));eq(sum(round(rep(1/3,3),3)),.999)
s <- d$spanek_h[!is.na(d$spanek_h)]
eq(length(s),33);eq(bins(s,4:9),c(3,5,8,10,5,2));eq(sum(s<7),13)
eq(hist(s,breaks=4:10,right=TRUE,include.lowest=FALSE,plot=FALSE)$counts,bins(s,4:9))
eq(round(bins(s,4:9)/33,3),c(.091,.152,.242,.303,.152,.061))
eq(freq(d$slova,0:12),c(1,0,1,1,2,4,5,6,6,4,3,2,1));eq(sum(d$slova<=6),14);eq(sum(d$slova<=8),26)
# Boundary conventions: verify all cases are assigned exactly once, including exact boundaries.
left_bins <- function(x, lower) vapply(lower, function(lo) sum(x >= lo & x < lo + 1), integer(1))
eq(left_bins(s, 4:9), c(2,4,7,11,6,3));eq(sum(left_bins(s,4:9)),33)
eq(hist(s, breaks=4:10, right=FALSE, include.lowest=FALSE, plot=FALSE)$counts,left_bins(s,4:9))
eq(bins(c(6,6.5,7),5:7),c(1,2,0));eq(left_bins(c(6,6.5,7),5:7),c(0,2,1))
# Grouped cumulative points must agree with inclusive thresholds in the original data.
threshold_counts <- vapply(4:10,function(hi) sum(s<=hi),integer(1))
eq(threshold_counts,c(0,3,8,16,26,31,33));eq(c(0,cumsum(bins(s,4:9))),threshold_counts)
eq(round(100*threshold_counts[c(4,5)]/33,1),c(48.5,78.8))
# Identical grouped counts need not determine the cumulative count inside a bin.
alternative <- s;alternative[s>6 & s<=7] <- 6.8
eq(bins(alternative,4:9),bins(s,4:9));stopifnot(sum(alternative<6.5)!=sum(s<6.5))
# Nominal cumulative example, midpoint and pictorial area example.
eq(cumsum(c(12,14,10))[1],12);eq(cumsum(c(14,12,10))[2],26)
eq(6+(7-6)/2,6.5);eq((6+7)/2,6.5);eq(2*2,4)
# Exercises 1 and 2.
x <- c(2,3,2,1,4,3,2,3,4,2,3,2);fx <- freq(x,1:4)
eq(fx,c(1,5,4,2));eq(sum(fx[2:4]),11);eq(round(fx/12,3),c(.083,.417,.333,.167))
eq(round(100*fx/12,1),c(8.3,41.7,33.3,16.7));stopifnot(max(fx)<length(x)/2)
# Exercise 3: distinct denominators and missingness.
eq(c(9/20,9/25,11/25,5/25),c(.45,.36,.44,.20));eq(1-9/25,.64)
# Exercise 4: strict versus inclusive thresholds.
x <- c(0,1,1,2,2,2,3,4,4,5)
eq(freq(x,0:5),c(1,2,3,1,2,1));eq(cumsum(freq(x,0:5)),c(1,3,6,7,9,10))
eq(c(sum(x<3),sum(x<=3),sum(x>=3)),c(6,7,4))
# Exercise 5: grouping loses the position inside a bin.
x <- c(5,5.5,6,6,6.5,7,7.5,8)
eq(bins(x,4:7),c(1,3,2,2));eq(bins(x,4:7)/8,c(.125,.375,.25,.25));eq(sum(x>=6.5),4)
# Exercise 8 reconstructs seven values and repeated 23.
eq(c(rep(2,4),rep(3,2),4)*10+c(1,3,3,8,0,5,2),c(21,23,23,28,30,35,42))
# Exercise 9 and the cropped-axis graphic.
eq(c(30/40,32/80),c(.75,.4));eq(c(30,32)-27,c(3,5))
# Exercise 10: n is unchanged and graphs use these same counts.
d$odpocatost[1] <- 3;eq(freq(d$odpocatost,1:4),c(4,9,15,8));eq(cumsum(freq(d$odpocatost,1:4)),c(4,13,28,36))
d$spanek_h[1] <- 7;eq(bins(d$spanek_h,4:9),c(3,4,9,10,5,2));eq(sum(!is.na(d$spanek_h)),33)
# Integrity of exported workbook/Excel formulas is checked separately in native Excel.
cat('Chapter 2: fixed data, frequency tables, rounding, bin edges, cumulative graph and quantitative solutions passed.\n')
