# Chapter 10: coverage of the percentile bootstrap interval for r_s and tau_b and the type I error
# rate of the permutation test of independence. Base R, fixed seed, about 5-10 minutes.
# Model: continuous bivariate normal populations, where the population Spearman and Kendall
# coefficients are known: rho_s = (6/pi) asin(rho/2), tau = (2/pi) asin(rho).
# Usage: Rscript --vanilla scripts/kapitola_10-pokryti.R  (writes tmp/chapter-10-pokryti.csv)
rs <- function(x,y) { rx <- rank(x); ry <- rank(y); if (sd(rx)==0||sd(ry)==0) NA_real_ else cor(rx,ry) }
tb <- function(x,y) { v <- suppressWarnings(cor(x,y,method='kendall')); if (is.na(v)) NA_real_ else v }
sim_cov <- function(n,rho,reps=1000,B=999) {
  par_rs <- 6/pi*asin(rho/2); par_tau <- 2/pi*asin(rho)
  hit <- matrix(NA,reps,2); width <- matrix(NA,reps,2)
  for (k in seq_len(reps)) {
    x <- rnorm(n); y <- rho*x+sqrt(1-rho^2)*rnorm(n)
    b <- replicate(B,{ i <- sample.int(n,n,replace=TRUE); c(rs(x[i],y[i]),tb(x[i],y[i])) })
    lim <- apply(b,1,quantile,c(.025,.975),type=7,na.rm=TRUE)
    hit[k,] <- c(lim[1,1]<=par_rs&par_rs<=lim[2,1],lim[1,2]<=par_tau&par_tau<=lim[2,2])
    width[k,] <- lim[2,]-lim[1,]
  }
  data.frame(ukol='pokryti',n=n,rho=rho,reps=reps,B=B,rs=mean(hit[,1]),tau_b=mean(hit[,2]),sirka_rs=mean(width[,1]),sirka_tau_b=mean(width[,2]))
}
sim_perm <- function(n,reps=1000,B=499) {
  rej <- matrix(NA,reps,2)
  for (k in seq_len(reps)) {
    x <- rnorm(n); y <- rnorm(n); o <- c(rs(x,y),tb(x,y))
    pm <- replicate(B,{ yy <- y[sample.int(n)]; c(rs(x,yy),tb(x,yy)) })
    p <- (rowSums(abs(pm)>=abs(o)-1e-12)+1)/(B+1)
    rej[k,] <- p<=.05
  }
  data.frame(ukol='chyba_I',n=n,rho=0,reps=reps,B=B,rs=mean(rej[,1]),tau_b=mean(rej[,2]),sirka_rs=NA,sirka_tau_b=NA)
}
set.seed(7010)
res <- rbind(sim_cov(10,-.5),sim_cov(30,-.5),sim_cov(10,-.8),sim_cov(30,-.8),sim_perm(10),sim_perm(30))
dir.create('tmp',showWarnings=FALSE)
write.csv(res,'tmp/chapter-10-pokryti.csv',row.names=FALSE)
print(res,digits=3)
