# Reproduce all chapter calculations in a clean session; base R only.
source('scripts/kapitola_03.R', encoding='UTF-8')
eq <- function(actual,expected,tolerance=1e-10) stopifnot(isTRUE(all.equal(as.numeric(actual),as.numeric(expected),tolerance=tolerance)))
x <- ch3_x
eq(x,c(4,5,5,6,10)); eq(sum(x),30); eq(mean(x),6); eq(median(x),5)
eq(x-mean(x),c(-2,-1,-1,0,4)); eq(sum((x-mean(x))^2),22)
eq(sum(x^2),202); eq(sum(x)^2,900)
eq(mean(abs(x-mean(x))),1.6); eq(var(x),5.5); eq(mad(x,constant=1),1)
eq(ch3_quantile(x,c(0,.25,.5,.75,.9,1)),c(4,5,5,6,8.4,10))
eq(ch3_quantile(1:4,.3),1.9); eq(mean(x<=5),.6); eq(mean(x<=8.4),.8)
# All three percentile ranks, ties and the inverse of type-7 interpolation.
rank_values<-c(4,5,6,10)
eq(vapply(rank_values,function(score) 100*mean(x<=score),numeric(1)),c(20,60,80,100))
eq(vapply(rank_values,function(score) 100*mean(x<score),numeric(1)),c(0,20,60,80))
eq(vapply(rank_values,function(score) 100*(sum(x<score)+sum(x==score)/2)/length(x),numeric(1)),c(10,40,70,90))
eq(ch3_quantile(x,c(0,.25,.5,.75,1)),c(4,5,5,6,10))
eq(ch3_quantile(x,seq(.25,.5,length.out=101)),rep(5,101))
stopifnot(ch3_quantile(x,.249)<5,ch3_quantile(x,.501)>5)
eq(ch3_quantile(x,c(.4,.7)),c(5,5.8))
# Type-7 interpolation: knots, fractional positions, endpoints and ties.
# Independently integrate the densities used in the centre/shape illustration.
for(j in 1:nrow(ch3_centre_models)) {
  model<-ch3_centre_models[j,]
  density<-function(z) dbeta(z/100,model$a,model$b)/100
  eq(integrate(density,0,100)$value,1)
  eq(integrate(function(z) z*density(z),0,100)$value,model$mean)
  eq(integrate(density,0,model$median)$value,.5)
  stopifnot(abs(optimize(density,c(0,100),maximum=TRUE)$maximum-model$mode)<.001)
}
eq(as.numeric(ch3_centre_models[1,c('mean','median','mode')]),rep(50,3))
eq(as.numeric(ch3_centre_models[2,c('mean','median','mode')])+as.numeric(ch3_centre_models[3,c('mean','median','mode')]),rep(100,3))
stopifnot(with(ch3_centre_models,mean[2]<median[2] && median[2]<mode[2] && mode[3]<median[3] && median[3]<mean[3]))
eq(ch3_quantile(ch3_interpolation,ch3_interpolation_levels),ch3_interpolation)
eq(ch3_quantile(ch3_interpolation,.17),6.4)
eq(mean(ch3_interpolation<=6.4),2/11)
interpolate_by_position <- function(x,p) {
  x<-sort(x);n<-length(x)
  if(n==1L) return(x[1])
  position<-1+(n-1)*p;i<-floor(position)
  if(i==n || position==i) return(x[i])
  x[i]+(position-i)*(x[i+1]-x[i])
}
for(z in list(ch3_interpolation,c(1,1,1,3,4,8),c(4,5,5,6,10),7)) {
  probs<-c(0,.1,.17,.25,.3,.5,.75,.9,1)
  eq(vapply(probs,function(p) interpolate_by_position(z,p),numeric(1)),ch3_quantile(z,probs))
}
# Numerical entries in the printed table must agree with the figure's input.
chapter_lines<-readLines('quarto/kapitola_03.qmd',encoding='UTF-8')
table_start<-grep('Pozice v seřazené řadě',chapter_lines,fixed=TRUE)
table_rows<-chapter_lines[table_start+2:12]
table_numbers<-do.call(rbind,lapply(strsplit(table_rows,'|',fixed=TRUE),function(row)
  as.numeric(gsub('%','',trimws(row[2:4]),fixed=TRUE))))
eq(table_numbers[,1],1:11);eq(table_numbers[,2],ch3_interpolation)
eq(table_numbers[,3],100*ch3_interpolation_levels)
eq(ch3_moments(x),c(10.8/4.4^1.5,54.8/4.4^2-3))
eq(ch3_corrected(x),c(1.74436949745499,3.32231404958677))
eq(ch3_stats(c(4,5,5,6,30))[c('mean','median','variance','median_abs')],c(10,5,125.5,1))
# Weighted groups; affine transformations including reversal of quantile order.
eq((10*4+30*8)/40,7); eq((8*6+12*9)/20,7.8)
eq(sd(60*x),60*sd(x)); eq(var(60*x),19800)
eq(ch3_quantile(10-x,.25),10-ch3_quantile(x,.75)); eq(sd(10-x),sd(x))
# Known data from chapter 2: independent published numeric targets.
eq(ch3_results['spanek',c('n','mean','median','q1','q3','variance')],c(33,233.1/33,7.1,6.2,8,1.66051136363636))
eq(ch3_results['slova',c('n','mean','median','q1','q3','variance')],c(36,253/36,7,5.75,9,6.71349206349206))
# Every possible independent sample of size five: an exact check of unbiasedness,
# independent of the Monte Carlo generator used for the figure.
all_samples <- as.matrix(expand.grid(rep(list(c(2,4,6,8,10)),5)))
all_ss <- rowSums((all_samples-rowMeans(all_samples))^2)
eq(mean(all_ss/5),6.4); eq(mean(all_ss/4),8)
stopifnot(mean(sqrt(all_ss/4)) < sqrt(8), any(all_ss/4 < 8),any(all_ss/4 > 8))
eq(round(ch3_simulation_summary$variance_n,2),c(6.41,7.62,7.93))
eq(round(ch3_simulation_summary$variance_n1,2),c(8.01,8.02,8.01))
eq(round(ch3_simulation_summary$sd_n1[1],2),2.73)
eq(mean(ch3_trim),8); eq(median(ch3_trim),5.5)
eq(mean(ch3_trim,trim=.1),47/8)
eq(mean(pmin(pmax(ch3_trim,3),9)),5.9)
eq(mean(ch3_trim,trim=.2),35/6); eq(mean(pmin(pmax(ch3_trim,4),8)),5.9)
# Boxplots use type-7 quartiles, not Tukey hinges.
fences<-ch3_quantile(x,c(.25,.75))+c(-1,1)*1.5*diff(ch3_quantile(x,c(.25,.75)))
eq(fences,c(3.5,7.5)); eq(range(x[x>=fences[1]&x<=fences[2]]),c(4,6))
eq(ch3_entropy(c(1,0,0,0)),0); eq(ch3_entropy(c(.5,.25,.25,0)),1.5); eq(ch3_entropy(rep(.25,4)),2)
eq(ch3_moments(ch3_peak_a)[2],2); eq(ch3_moments(ch3_peak_b)[2],98/9)
eq(c(mean(ch3_shape_a),var(ch3_shape_a)),c(6,4.8)); eq(c(mean(ch3_shape_b),var(ch3_shape_b)),c(6,4.8))
# Quantitative exercise solutions.
z<-c(3,4,4,5,6,20);eq(c(mean(z),median(z)),c(7,4.5));stopifnot(names(which.max(table(z)))=='4')
z<-c(1,1,1,3,4,8);eq(ch3_quantile(z,c(.25,.5,.75)),c(1,2,3.75));eq(mean(z<=1),.5)
z<-c(2,4,6);eq(c(mean(z),mean(abs(z-mean(z))),sum((z-mean(z))^2),var(z),sd(z)),c(4,4/3,8,4,2))
eq(mad(c(2,3,4,5,16),constant=1),1);eq(mad(c(2,3,4,5,100),constant=1),1)
z<-c(1,2,2,3,4,5,6,15);eq(ch3_quantile(z,c(.25,.5,.75)),c(2,3.5,5.25));eq(5.25-2,3.25)
eq(c(2,5.25)+c(-1,1)*1.5*3.25,c(-2.875,10.125));eq(range(z[z<=10.125]),c(1,6))
eq((4+2)*60,360);eq((3.5+2)*60,330);eq(1.5*60,90);eq((1.5*60)^2,8100)
z<-c(rep(-2,4),rep(-1,5),rep(1,10),3);eq(c(sum(z),sum(z^3),mean(z^2)),c(0,0,2));eq(ch3_moments(z)[1],0)
stopifnot(sum(z==1)!=sum(z== -1))
# Definitions must explicitly include ties, unscaled MAD and n/n-1 distinctions.
text<-paste(readLines('quarto/kapitola_03.qmd',encoding='UTF-8'),collapse='\n')
stopifnot(length(gregexpr('title="Ukázat řešení"',text,fixed=TRUE)[[1]])==14,
  !grepl('=LOG(',text,fixed=TRUE),grepl('LOGZ',text,fixed=TRUE),
  !grepl('```{r',text,fixed=TRUE))
cat('Chapter 3: all numerical examples and 14 solutions checked; exact sampling enumeration and Monte Carlo targets agree.\n')
