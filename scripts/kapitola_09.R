# Teaching data, calculations and figures for chapter 9; base R, UTF-8, deterministic project-root paths.
# Real data quoted from sources: Daniels (2012) via Field et al. (p. 638); aspirin study, Prozac and anorexia,
# help-seeking (fictitious per Howell), daylight saving time (Howell's illustration) and Berkeley admissions
# via Howell (2013, ch. 6); ganzfeld studies via Cumming and Calin-Jageman (Table 13.1).
# Everything else is an authored teaching model.
ch9_out <- 'assets/chapter-09/plots'
ch9_old_options <- options(OutDec=',')
dir.create(ch9_out,recursive=TRUE,showWarnings=FALSE)
ch9_blue <- '#245D78'; ch9_orange <- '#B54E24'; ch9_fill <- '#B8DDE8'; ch9_gray <- '#4D5A63'; ch9_pale <- '#E1E8EB'; ch9_sand <- '#FAECDD'; ch9_ink <- '#223744'; ch9_mute <- '#A9BAC3'; ch9_green <- '#3E7B4F'
ch9_num <- function(x,digits=2) sub('^-','−',formatC(x,format='f',digits=digits,decimal.mark=','))
ch9_draw <- function(name,code,width=8,height=4.5) {
  svg(file.path(ch9_out,paste0(name,'.svg')),width=width,height=height,family='sans',bg='white')
  par(mar=c(4.5,4.5,2.6,.8),mgp=c(2.7,.7,0),las=1,col.axis=ch9_ink,col.lab=ch9_ink,fg=ch9_ink,cex=.9)
  force(code); dev.off()
}
# Data and descriptions of the figures for the AI tutor (tmp/tutor-figures/kapitola_09/); see scripts/tutor/figure-data.R.
source('scripts/tutor/figure-data.R',encoding='UTF-8')
source('scripts/figure-labels.R',encoding='UTF-8')   # statistical symbols in the math font (R89)
ch9_fig <- function(...) tf_figure('kapitola_09',...)
ch9_z <- qnorm(.975)
# Procedures -------------------------------------------------------------------------------
# Wald interval: explanatory step only. Wilson score interval: the interval the chapter computes.
ch9_wald <- function(x,n,z=ch9_z) { p <- x/n; se <- sqrt(p*(1-p)/n); c(p=p,se=se,dolni=p-z*se,horni=p+z*se) }
ch9_wilson <- function(x,n,z=ch9_z) {
  p <- x/n; stred <- (p+z^2/(2*n))/(1+z^2/n); pul <- z/(1+z^2/n)*sqrt(p*(1-p)/n+z^2/(4*n^2))
  c(p=p,stred=stred,pul=pul,dolni=stred-pul,horni=stred+pul)
}
# Derivation of the Wilson interval (optional extension): the limits are the roots of the quadratic
# A*pi^2 + B*pi + C = 0 that follows from (p - pi)^2 <= z^2 * pi * (1 - pi) / n.
ch9_wilson_koreny <- function(x,n,z=ch9_z) {
  p <- x/n; A <- 1+z^2/n; B <- -(2*p+z^2/n); C <- p^2; D <- B^2-4*A*C
  c(A=A,B=B,C=C,D=D,dolni=(-B-sqrt(D))/(2*A),horni=(-B+sqrt(D))/(2*A))
}
# Score test of one proportion (standard error from the null value); its inversion gives the Wilson interval.
ch9_score1 <- function(x,n,p0) { z <- (x/n-p0)/sqrt(p0*(1-p0)/n); c(z=z,p=2*pnorm(-abs(z))) }
# Exact binomial test of one proportion, two-sided: counts at most as probable under H0 as the observed one
# (the rule of binom.test and of Fisher's test below). Also both one-sided tails and the doubled smaller tail.
ch9_binom2 <- function(k,n,p0) { x <- 0:n; pr <- dbinom(x,n,p0); pobs <- dbinom(k,n,p0); less <- pr<=pobs*(1+1e-7)
  list(x=x,pr=pr,pobs=pobs,less=less,horni=sum(pr[x>=k]),dolni=sum(pr[x<=k]),p=sum(pr[less]),dvojnasobek=min(1,2*min(sum(pr[x>=k]),sum(pr[x<=k])))) }
# Two independent proportions: Newcombe hybrid score interval from the two Wilson intervals,
# Wald interval only to show the summing of variances, and the test with the pooled proportion.
ch9_two <- function(x1,n1,x2,n2,z=ch9_z) {
  w1 <- ch9_wilson(x1,n1,z); w2 <- ch9_wilson(x2,n2,z); p1 <- x1/n1; p2 <- x2/n2; d <- p1-p2
  pp <- (x1+x2)/(n1+n2); se0 <- sqrt(pp*(1-pp)*(1/n1+1/n2)); se <- sqrt(p1*(1-p1)/n1+p2*(1-p2)/n2); zz <- d/se0
  c(p1=p1,p2=p2,rozdil=d,spolecny=pp,se0=se0,z=zz,chi2=zz^2,p=2*pnorm(-abs(zz)),
    se_wald=se,wald_dolni=d-z*se,wald_horni=d+z*se,
    dolni=d-sqrt((p1-w1[['dolni']])^2+(w2[['horni']]-p2)^2),horni=d+sqrt((w1[['horni']]-p1)^2+(p2-w2[['dolni']])^2))
}
# Pearson chi-square for a table of counts; expected counts from the margins (product rule).
ch9_table <- function(f) {
  n <- sum(f); r <- rowSums(f); s <- colSums(f); e <- outer(r,s)/n
  chi2 <- sum((f-e)^2/e); df <- (nrow(f)-1)*(ncol(f)-1)
  pear <- (f-e)/sqrt(e); adj <- (f-e)/sqrt(e*outer(1-r/n,1-s/n))
  list(n=n,e=e,chi2=chi2,df=df,p=pchisq(chi2,df,lower.tail=FALSE),prispevky=(f-e)^2/e,pearson=pear,upravena=adj,
       radkove=f/r,V=sqrt(chi2/(n*(min(dim(f))-1))))
}
ch9_gof <- function(f,p0) { n <- sum(f); e <- n*p0; chi2 <- sum((f-e)^2/e); df <- length(f)-1
  list(n=n,e=e,prispevky=(f-e)^2/e,chi2=chi2,df=df,p=pchisq(chi2,df,lower.tail=FALSE)) }
# Effect measures for a 2 x 2 table: rows = groups (first row compared with the reference second row),
# first column = the event. Log intervals for the ratios are optional in the text.
ch9_effects <- function(f,z=ch9_z) {
  r1 <- f[1,1]/sum(f[1,]); r2 <- f[2,1]/sum(f[2,]); o1 <- f[1,1]/f[1,2]; o2 <- f[2,1]/f[2,2]
  rr <- r1/r2; or <- o1/o2
  se_lrr <- sqrt(1/f[1,1]-1/sum(f[1,])+1/f[2,1]-1/sum(f[2,])); se_lor <- sqrt(sum(1/f))
  tb <- ch9_table(f)
  c(riziko1=r1,riziko2=r2,rozdil=r1-r2,rr=rr,sance1=o1,sance2=o2,or=or,
    rr_dolni=exp(log(rr)-z*se_lrr),rr_horni=exp(log(rr)+z*se_lrr),or_dolni=exp(log(or)-z*se_lor),or_horni=exp(log(or)+z*se_lor),
    se_lrr=se_lrr,se_lor=se_lor,chi2=tb$chi2,p=tb$p,phi=sqrt(tb$chi2/tb$n))
}
# Fisher's exact test, two-sided: tables with the observed margins at most as probable as the observed one.
ch9_fisher <- function(f) {
  r1 <- sum(f[1,]); s1 <- sum(f[,1]); n <- sum(f); a <- max(0,s1-(n-r1)):min(r1,s1)
  pr <- dhyper(a,s1,n-s1,r1); pobs <- dhyper(f[1,1],s1,n-s1,r1)
  list(a=a,pr=pr,pobs=pobs,p=sum(pr[pr<=pobs*(1+1e-7)]))
}
# McNemar: exact binomial test of the discordant pairs (two-sided) and the chi-square approximation.
ch9_mcnemar <- function(b,c) { m <- b+c
  c(neshodne=m,presne=min(1,2*pbinom(min(b,c),m,.5)),chi2=(b-c)^2/m,priblizne=pchisq((b-c)^2/m,1,lower.tail=FALSE)) }
# 1. Running example: chapter 5 table, now a random sample. Rows women, men; columns elevated, low stress.
ch9_stres <- matrix(c(40,60,30,70),2,byrow=TRUE,dimnames=list(c('ženy','muži'),c('zvýšený','nízký')))
ch9_stres_two <- ch9_two(40,100,30,100); ch9_stres_tab <- ch9_table(ch9_stres)
ch9_stres_w <- rbind(zeny=ch9_wilson(40,100),muzi=ch9_wilson(30,100))
ch9_stres_dvoj <- ch9_two(80,200,60,200)
ch9_stres_fisher <- ch9_fisher(ch9_stres)
ch9_stres_eff <- ch9_effects(ch9_stres)
# 2. One proportion: 10 correct of 20 (chapter 6 test with guessing probability 0.25) and 0 of 15.
ch9_t20_wald <- ch9_wald(10,20); ch9_t20_wil <- ch9_wilson(10,20); ch9_t20_score <- ch9_score1(10,20,.25)
ch9_t20_binom <- pbinom(9,20,.25,lower.tail=FALSE)
# The same data two-sided, three ways: exact binomial, normal (score z) and chi-square with one degree of freedom.
# Contrast with the same z in a sample four times larger: 30 of 80.
ch9_t20_ex <- ch9_binom2(10,20,.25); ch9_t20_chvost <- pnorm(-abs(ch9_t20_score[['z']]))
ch9_t80_ex <- ch9_binom2(30,80,.25); ch9_t80_score <- ch9_score1(30,80,.25)
ch9_n15_wald <- ch9_wald(0,15); ch9_n15_wil <- ch9_wilson(0,15)
ch9_t80_wil <- ch9_wilson(40,80)
ch9_t20_kor <- ch9_wilson_koreny(10,20); ch9_n15_kor <- ch9_wilson_koreny(0,15)
# 3. Goodness of fit: 80 people choose one of four identical tea samples placed left to right (authored).
ch9_pozice <- c(12,16,21,31); names(ch9_pozice) <- c('1. zleva','2. zleva','3. zleva','4. zleva (vpravo)')
ch9_poz <- ch9_gof(ch9_pozice,rep(.25,4))
ch9_poz_w <- t(sapply(ch9_pozice,ch9_wilson,n=80))
# Simulated sampling distribution of the statistic under H0 (seed fixed, 10 000 samples of 80 choices).
set.seed(20261109)
ch9_sim <- replicate(10000,{ f <- tabulate(sample.int(4,80,replace=TRUE),4); sum((f-20)^2/20) })
# Two categories: chi-square equals z squared of the score test (10 of 20 against 0.25).
ch9_t20_gof <- ch9_gof(c(10,10),c(.25,.75))
# 4. Age group x preferred coping strategy (authored teaching example), n = 190.
ch9_zvl <- matrix(c(25,18,12, 30,22,28, 10,20,25),3,byrow=TRUE,
  dimnames=list(c('mladí (18–30)','dospělí (31–60)','senioři (60+)'),c('řešení problému','vyhýbání','sociální opora')))
ch9_zvl_tab <- ch9_table(ch9_zvl)
ch9_zvl_padj <- 2*pnorm(-abs(as.vector(ch9_zvl_tab$upravena)))
ch9_zvl_holm <- matrix(p.adjust(ch9_zvl_padj,'holm'),3)
# 5. Assumptions: daylight saving time (Howell, p. 154): yes only versus yes and no.
ch9_dst_bad <- ch9_gof(c(17,11),c(.5,.5)); ch9_dst <- ch9_table(matrix(c(17,3,11,9),2,byrow=TRUE))
# Small pilot study (authored): improvement in 8 of 10 with the intervention and 3 of 10 in the control group.
ch9_pilot <- matrix(c(8,2,3,7),2,byrow=TRUE); ch9_pilot_tab <- ch9_table(ch9_pilot); ch9_pilot_fisher <- ch9_fisher(ch9_pilot)
# 6. Effect sizes: Daniels (2012) via Field et al. (p. 638). Rows: sexualized, performance athletes; col 1 = theme present.
ch9_dan <- matrix(c(56,84,20,97),2,byrow=TRUE,dimnames=list(c('sexualizované','sportovní'),c('ano','ne')))
ch9_dan_eff <- ch9_effects(ch9_dan); ch9_dan_two <- ch9_two(56,140,20,117); ch9_dan_w <- rbind(ch9_wilson(56,140),ch9_wilson(20,117))
ch9_dan_phi01 <- cor(c(rep(1,140),rep(0,117)),c(rep(1,56),rep(0,84),rep(1,20),rep(0,97)))
# Rare event contrast: aspirin study via Howell (pp. 160-163). Rows: placebo, aspirin; col 1 = heart attack.
ch9_asp <- matrix(c(189,10845,104,10933),2,byrow=TRUE); ch9_asp_eff <- ch9_effects(ch9_asp)
# 7. Paired binary data: help seeking in fall and spring (Howell, Table 6.7; fictitious data).
ch9_pomoc <- matrix(c(38,4,12,18),2,byrow=TRUE,dimnames=list(podzim=c('ano','ne'),jaro=c('ano','ne')))
ch9_pomoc_mc <- ch9_mcnemar(b=12,c=4)
ch9_pomoc_p <- c(podzim=42/72,jaro=50/72,rozdil=(12-4)/72)
# Optional: Berkeley departments B-F via Howell (Table 6.9); department A omitted as in Howell.
ch9_berk <- data.frame(obor=c('B','C','D','E','F'),m_prijati=c(353,120,138,53,22),m_odmitnuti=c(207,205,279,138,351),
  z_prijate=c(17,202,131,94,24),z_odmitnute=c(8,391,244,299,317))
ch9_berk_m <- with(ch9_berk,sum(m_prijati)/sum(m_prijati+m_odmitnuti)); ch9_berk_z <- with(ch9_berk,sum(z_prijate)/sum(z_prijate+z_odmitnute))
# Optional: Cohen's kappa (Howell, Table 6.13).
ch9_kappa_t <- matrix(c(15,2,3, 1,3,2, 0,1,3),3,byrow=TRUE)
ch9_kappa <- with(list(f=ch9_kappa_t,n=30),{ po <- sum(diag(f)); pe <- sum(rowSums(f)*colSums(f))/n; c(shody=po,ocekavane=pe,kappa=(po-pe)/(n-pe)) })
# Optional: ganzfeld studies combined (Cumming and Calin-Jageman, Table 13.1): 106 hits of 329, chance 0.25.
ch9_ganz <- c(ch9_wilson(106,329),p_binom=pbinom(105,329,.25,lower.tail=FALSE))
# Exercise inputs (authored unless stated) -----------------------------------------------------
ch9_u02 <- c(x=18,n=60); ch9_u02b <- c(x=72,n=240)
ch9_u03 <- c(x=0,n=25)
ch9_u04 <- matrix(c(13,36,14,30),2,byrow=TRUE) # Prozac and relapse (Walsh et al., 2006, via Howell, Table 6.5); col 1 = weight maintained
ch9_u05 <- c(kamen=30,papir=21,nuzky=24) # Howell (p. 143), hypothetical
ch9_u06 <- c(52,50,31,17); ch9_u06_p0 <- c(.40,.30,.20,.10) # reasons for contacting a counselling centre
ch9_u07 <- matrix(c(28,14,18, 22,25,13, 12,30,18),3,byrow=TRUE,
  dimnames=list(c('1. ročník','2. ročník','3. ročník'),c('opakované čtení','procvičování úloh','vysvětlování druhým')))
ch9_u10 <- matrix(c(19,74,22,187),2,byrow=TRUE) # Howell and Huessy (1981) via Howell, exercise 6.8; col 1 = remedial English
ch9_u11 <- matrix(c(25,3,11,21),2,byrow=TRUE) # opinion before and after a course; 4 more students only before
ch9_u12 <- matrix(c(6,2,2,7),2,byrow=TRUE) # small pilot: recovery in 6 of 8 versus 2 of 9
# Results used in solutions
ch9_u02_w <- ch9_wilson(18,60); ch9_u02b_w <- ch9_wilson(72,240)
ch9_u03_wald <- ch9_wald(1,25); ch9_u03_wil0 <- ch9_wilson(0,25); ch9_u03_wil1 <- ch9_wilson(1,25)
ch9_u04_two <- ch9_two(13,49,14,44); ch9_u04_fisher <- ch9_fisher(ch9_u04)
ch9_u05_gof <- ch9_gof(ch9_u05,rep(1/3,3))
# Exercise 5e: rock (30 of 75) against 1/3, two-sided: score test, chi-square of two categories, exact binomial test.
ch9_u05_score <- ch9_score1(30,75,1/3); ch9_u05_gof2 <- ch9_gof(c(30,45),c(1/3,2/3)); ch9_u05_ex <- ch9_binom2(30,75,1/3)
ch9_u06_gof <- ch9_gof(ch9_u06,ch9_u06_p0)
ch9_u07_tab <- ch9_table(ch9_u07)
ch9_u07_holm <- matrix(p.adjust(2*pnorm(-abs(as.vector(ch9_u07_tab$upravena))),'holm'),3)
ch9_u10_eff <- ch9_effects(ch9_u10); ch9_u10_two <- ch9_two(19,93,22,209)
ch9_u11_mc <- ch9_mcnemar(b=11,c=3)
ch9_u12_tab <- ch9_table(ch9_u12); ch9_u12_fisher <- ch9_fisher(ch9_u12); ch9_u12_two <- ch9_two(6,8,2,9)
# Revision 2026-11-16 (R81) ----------------------------------------------------------------
# Exact coverage of the 95% Wald and Wilson intervals (binomial sums, no simulation) and the probability
# that the Wald interval reaches outside [0, 1] or has zero width (x = 0 or x = n).
ch9_cover_pi <- seq(.01,.99,by=.002); ch9_cover_n <- c(10,20,50,100)
ch9_cover <- function(n,pi=ch9_cover_pi,z=ch9_z) {
  x <- 0:n; wa <- t(sapply(x,ch9_wald,n=n,z=z)); wi <- t(sapply(x,ch9_wilson,n=n,z=z))
  bad <- wa[,'dolni'] < -1e-12 | wa[,'horni'] > 1+1e-12 | x==0 | x==n
  t(sapply(pi,function(p) { pr <- dbinom(x,n,p)
    c(wald=sum(pr[wa[,'dolni']<=p & p<=wa[,'horni']]),wilson=sum(pr[wi[,'dolni']-1e-12<=p & p<=wi[,'horni']+1e-12]),mimo=sum(pr[bad])) }))
}
ch9_cover_res <- lapply(ch9_cover_n,ch9_cover); names(ch9_cover_res) <- ch9_cover_n
ch9_cover_at <- function(n,p) ch9_cover(n,pi=p)[1,]
# Holm table for the nine cells of the coping table, ordered by the p-value.
ch9_zvl_holm_tab <- with(list(o=order(ch9_zvl_padj)), data.frame(poradi=1:9,
  radek=rownames(ch9_zvl)[row(ch9_zvl)[o]],sloupec=colnames(ch9_zvl)[col(ch9_zvl)[o]],
  reziduum=as.vector(ch9_zvl_tab$upravena)[o],p=ch9_zvl_padj[o],hranice=.05/(9:1)))
ch9_zvl_holm_tab$zamitame <- cumprod(ch9_zvl_holm_tab$p<=ch9_zvl_holm_tab$hranice)==1
# Monte Carlo p-value: reshuffle the outcomes among the groups (margins fixed), recompute chi-square.
ch9_mc <- function(f,B=10000) {
  grp <- rep(seq_len(nrow(f)),rowSums(f)); out <- rep(seq_len(ncol(f)),colSums(f)); e <- outer(rowSums(f),colSums(f))/sum(f)
  replicate(B,{ g <- table(factor(grp,seq_len(nrow(f))),factor(sample(out),seq_len(ncol(f)))); sum((g-e)^2/e) })
}
set.seed(20261117); ch9_pilot_mc <- ch9_mc(ch9_pilot); ch9_pilot_mc_p <- mean(ch9_pilot_mc>=ch9_pilot_tab$chi2-1e-9)
# Signed phi of a 2 x 2 table; its square is chi-square / n. Product of the two differences of proportions.
ch9_phi_signed <- function(f) (f[1,1]*f[2,2]-f[1,2]*f[2,1])/sqrt(prod(rowSums(f))*prod(colSums(f)))
ch9_dan_phi_s <- ch9_phi_signed(ch9_dan); ch9_dan_phi_swap <- ch9_phi_signed(ch9_dan[2:1,])
ch9_dan_coldiff <- 56/76-84/181
# Sign test: two-sided exact binomial test of the signs of the non-zero differences.
ch9_sign <- function(d) { d <- d[!is.na(d) & d!=0]; k <- sum(d>0); n <- length(d); c(kladne=k,zaporne=n-k,n=n,p=min(1,2*pbinom(min(k,n-k),n,.5))) }
ch9_spanek_d <- c(5,2,6,1,7,3,4,-1,5,2,6,2) # twelve complete pairs of chapter 8 (normal minus short sleep)
ch9_spanek_sign <- ch9_sign(ch9_spanek_d)
# Exercise 13 (authored): anxiety rated 1-5 before and after a relaxation programme, 15 clients.
ch9_u13 <- data.frame(pred=c(4,5,3,4,2,5,4,3,4,5,3,4,2,5,3),po=c(3,3,3,2,3,4,4,2,3,2,4,3,2,3,2))
ch9_u13_sign <- ch9_sign(ch9_u13$pred-ch9_u13$po)
# Kappa: expected counts of all cells (rows Judge II, columns Judge I as in Howell, Table 6.13).
ch9_kappa_e <- outer(rowSums(ch9_kappa_t),colSums(ch9_kappa_t))/sum(ch9_kappa_t)
# Figures -----------------------------------------------------------------------------------
ch9_draw('wald-wilson', {
  par(mar=c(4.6,12.5,2.8,.8))
  rows <- rbind(ch9_t20_wald[c('p','dolni','horni')],ch9_t20_wil[c('p','dolni','horni')],
                ch9_n15_wald[c('p','dolni','horni')],ch9_n15_wil[c('p','dolni','horni')])
  y <- c(4.2,3.4,1.8,1); cols <- c(ch9_mute,ch9_blue,ch9_mute,ch9_blue)
  plot(NA,xlim=c(-.02,1),ylim=c(.4,4.9),yaxt='n',xlab='',ylab='',main='95% intervaly pro podíl: Waldův a Wilsonův',bty='l')
  fl_title(xlab='Podíl správných odpovědí, populační hodnota π')
  abline(v=.25,lty=2,col=ch9_gray); fl_text(.25,4.85,'π = 0,25 (hádání)',cex=.75,col=ch9_gray,adj=c(-.05,.5))
  axis(2,at=y,labels=c('10 z 20: Wald','10 z 20: Wilson','0 z 15: Wald','0 z 15: Wilson'),tick=FALSE,cex.axis=.88)
  segments(pmax(rows[,2],0),y,rows[,3],y,lwd=4,col=cols,lend=1); points(rows[,1],y,pch=21,bg='white',col=ch9_ink,cex=1.3)
  lab <- paste0('(',ch9_num(pmax(rows[,2],0)),'; ',ch9_num(rows[,3]),')')
  text(c(rows[1:2,3]+.02,.28,.28),y,lab,adj=0,cex=.78)
  text(.48,1.8,'← Waldův interval má nulovou šířku',adj=0,cex=.76,col=ch9_orange)
},width=9,height=4.2)
ch9_fig('wald-wilson','data',note='Čtyři vodorovné intervaly pod sebou v uvedeném pořadí shora dolů; Waldovy šedě, Wilsonovy modře, bodový odhad jako bílý bod. U každého intervalu je popisek mezí. Waldův interval pro 0 z 15 má nulovou šířku (0; 0), na což upozorňuje oranžový popisek.',panels=list(local({
  r <- rbind(ch9_t20_wald[c('p','dolni','horni')],ch9_t20_wil[c('p','dolni','horni')],ch9_n15_wald[c('p','dolni','horni')],ch9_n15_wil[c('p','dolni','horni')])
  tf_panel('95% intervaly pro podíl: Waldův a Wilsonův','intervalový graf','Podíl správných odpovědí, populační hodnota π','Výsledek a typ intervalu',xlim=c(-.02,1),
    guides=list(tf_guide('x',.25,'π = 0,25 (hádání)')),
    series=list(tf_series('Intervaly',data.frame(kategorie=c('10 z 20: Wald','10 z 20: Wilson','0 z 15: Wald','0 z 15: Wilson'),od=pmax(r[,2],0),do=r[,3],stred=r[,1]),'interval',digits=3,direction='vodorovně'))) })))
ch9_draw('wilson-odvozeni', {
  par(mar=c(4.6,4.8,2.8,.8))
  x <- seq(0,1,length.out=501); lo <- ch9_t20_kor['dolni']; hi <- ch9_t20_kor['horni']
  left <- (.5-x)^2; right <- ch9_z^2*x*(1-x)/20; inside <- x>=lo & x<=hi
  plot(NA,xlim=c(0,1),ylim=c(0,.105),xaxs='i',yaxs='i',xlab='',ylab='Hodnota obou stran nerovnice',main='',bty='l')
  fl_title(main='10 z 20: pro která π platí nerovnice?',xlab='Populační podíl π')
  polygon(c(x[inside],rev(x[inside])),c(left[inside],rev(right[inside])),col=ch9_fill,border=NA)
  lines(x[left<=.105],left[left<=.105],col=ch9_orange,lwd=2); lines(x,right,col=ch9_blue,lwd=2)
  segments(c(lo,hi),0,c(lo,hi),(.5-lo)^2,lty=2,col=ch9_gray)
  points(c(lo,hi),rep((.5-lo)^2,2),pch=21,bg='white',col=ch9_ink,cex=1.3)
  segments(lo,.003,hi,.003,lwd=5,col=ch9_blue,lend=1)
  text(c(lo,hi),rep(.011,2),ch9_num(c(lo,hi)),adj=c(1.25,.5),cex=.8); text(.5,.011,'Wilsonův interval',cex=.8,col=ch9_blue)
  text(.5,.03,'nerovnice platí',cex=.8,col=ch9_ink)
  fl_text(.2,.098,'čtverec vzdálenosti (*p* − π)²',adj=0,cex=.82,col=ch9_orange)
  fl_text(.5,.054,'mez *z*²π(1 − π)/*n*',cex=.82,col=ch9_blue)
},width=8,height=4.4)
ch9_fig('wilson-odvozeni','krivka',note='Oranžová parabola je čtverec vzdálenosti (p − π)² pro p = 0,5, modrá křivka mez z²π(1 − π)/n pro n = 20 a z = 1,96. Světle modře je vybarvena oblast mezi křivkami, kde nerovnice platí; její krajní body jsou meze Wilsonova intervalu, který je vyznačen tlustou modrou úsečkou u vodorovné osy.',panels=list(local({
  lo <- ch9_t20_kor[['dolni']]; hi <- ch9_t20_kor[['horni']]; x <- seq(lo,hi,length.out=31); xl <- seq(.5-sqrt(.105),.5+sqrt(.105),length.out=41)
  tf_panel('10 z 20: pro která π platí nerovnice?','čárový graf','Populační podíl π','Hodnota obou stran nerovnice',xlim=c(0,1),ylim=c(0,.105),
    guides=list(tf_guide('x',lo,paste0('dolní mez ',ch9_num(lo))),tf_guide('x',hi,paste0('horní mez ',ch9_num(hi)))),
    series=list(tf_series('Čtverec vzdálenosti (p − π)²',data.frame(x=xl,y=(.5-xl)^2),'cara',digits=4,note='parabola pokračuje nad horní okraj grafu'),
      tf_curve('Mez z²π(1 − π)/n',function(x) ch9_z^2*x*(1-x)/20,0,1,41),
      tf_series('Oblast, kde nerovnice platí',data.frame(x=x,y=ch9_z^2*x*(1-x)/20,y0=(.5-x)^2),'plocha',digits=4),
      tf_series('Wilsonův interval',data.frame(poloha=.003,od=lo,do=hi),'interval',digits=3,direction='vodorovně'))) })))
ch9_draw('pozice', {
  par(mar=c(4.6,4.7,2.8,.8))
  b <- barplot(ch9_pozice,ylim=c(0,36),col=ch9_fill,border=ch9_ink,names.arg=c('1. zleva','2.','3.','4. (vpravo)'),
    ylab='Četnost volby (počet lidí)',xlab='Pozice vzorku na stole',main='Volba jednoho ze čtyř stejných vzorků čaje (80 lidí)')
  abline(h=20,lty=2,lwd=1.8,col=ch9_orange); text(b[1]-.3,21.6,'očekávaná četnost 20 při rovnoměrné volbě',adj=0,cex=.78,col=ch9_orange)
  text(b,ch9_pozice+1.6,ch9_pozice,cex=.9)
},width=8.4,height=4.4)
ch9_fig('pozice','sloupce',note='Nad každým sloupcem je jeho četnost.',panels=list(
  tf_panel('Volba jednoho ze čtyř stejných vzorků čaje (80 lidí)','sloupcový graf','Pozice vzorku na stole','Četnost volby (počet lidí)',ylim=c(0,36),
    guides=list(tf_guide('y',20,'očekávaná četnost 20 při rovnoměrné volbě')),
    series=list(tf_series('Četnosti voleb',data.frame(kategorie=c('1. zleva','2.','3.','4. (vpravo)'),y=as.numeric(ch9_pozice)),'sloupce')))))
ch9_draw('chi-kvadrat', {
  par(mfrow=c(1,2),mar=c(4.6,4.5,3,.8))
  x <- seq(.01,20,length.out=600); dfs <- c(1,2,4,8); cols <- c(ch9_orange,ch9_green,ch9_blue,ch9_ink)
  plot(NA,xlim=c(0,20),ylim=c(0,.5),xlab='',ylab='Hustota',main='Chí-kvadrát rozdělení',bty='l')
  fl_title(xlab='Hodnota χ²')
  for(i in seq_along(dfs)) { lines(x,dchisq(x,dfs[i]),lwd=2,col=cols[i]); q <- qchisq(.95,dfs[i]); segments(q,0,q,dchisq(q,dfs[i])+.03,lty=3,col=cols[i]) }
  legend('topright',paste0(dfs,' st. volnosti: 5 % nad ',ch9_num(qchisq(.95,dfs))),col=cols,lwd=2,bty='n',cex=.78)
  h <- hist(ch9_sim,breaks=seq(0,max(ch9_sim)+1,by=1),plot=FALSE)
  plot(h,freq=FALSE,col=ch9_pale,border='white',xlim=c(0,20),ylim=c(0,.27),xlab='',ylab='Hustota',main='',bty='l')
  fl_title(main='Rozdělení statistiky při platnosti *H*_{0}',xlab='Hodnota χ² ve výběru 80 lidí')
  xx <- seq(ch9_poz$chi2,20,length.out=200); polygon(c(xx,rev(xx)),c(dchisq(xx,3),rep(0,200)),col=adjustcolor(ch9_orange,.45),border=NA)
  lines(x,dchisq(x,3),lwd=2,col=ch9_blue); abline(v=qchisq(.95,3),lty=2,col=ch9_ink)
  arrows(ch9_poz$chi2,.12,ch9_poz$chi2,.03,length=.08,col=ch9_orange,lwd=1.6); fl_text(ch9_poz$chi2,.135,paste0('naše χ² = ',ch9_num(ch9_poz$chi2,1)),cex=.78,col=ch9_orange)
  text(qchisq(.95,3),.2,paste0('kritická hodnota ',ch9_num(qchisq(.95,3))),adj=-.05,cex=.75)
  fl_legend('topright',c('10 000 simulovaných výběrů','χ² se 3 st. volnosti'),fill=c(ch9_pale,NA),border=c('white',NA),lwd=c(NA,2),col=c(NA,ch9_blue),bty='n',cex=.75)
},width=10,height=4.4)
ch9_fig('chi-kvadrat','simulace',note='Vlevo čtyři křivky hustoty chí-kvadrát rozdělení; u každé tečkovaná svislá čára v kritické hodnotě, nad níž leží 5 % plochy. Vpravo histogram 10 000 simulovaných hodnot statistiky pro 80 voleb ze čtyř vzorků při platnosti nulové hypotézy, proložený křivkou se 3 stupni volnosti; oranžově je vybarvena plocha napravo od pozorované hodnoty.',panels=list(
  tf_panel('Chí-kvadrát rozdělení','čárový graf','Hodnota χ²','Hustota',xlim=c(0,20),ylim=c(0,.5),
    note=paste0('Kritické hodnoty (5 % plochy napravo): ',paste0(c(1,2,4,8),' st. volnosti ',ch9_num(qchisq(.95,c(1,2,4,8))),collapse='; '),'.'),
    series=lapply(c(1,2,4,8),function(k) tf_curve(paste0(k,' st. volnosti'),function(x) dchisq(x,k),if(k==1) .1 else .01,20,if(k<3) 81 else 51,note=if(k==1) 'u nuly roste nad horní okraj grafu'))),
  tf_panel('Rozdělení statistiky při platnosti H0','histogram','Hodnota χ² ve výběru 80 lidí','Hustota',xlim=c(0,20),ylim=c(0,.27),
    guides=list(tf_guide('x',qchisq(.95,3),paste0('kritická hodnota ',ch9_num(qchisq(.95,3)))),tf_guide('x',ch9_poz$chi2,paste0('naše χ² = ',ch9_num(ch9_poz$chi2,1)))),
    series=list(tf_series('10 000 simulovaných výběrů',tf_bins(ch9_sim,seq(0,max(ch9_sim)+1,by=1),'hustota'),'histogram',digits=4),
      tf_curve('χ² se 3 st. volnosti',function(x) dchisq(x,3),.01,20,61),
      tf_curve('Plocha napravo od pozorované hodnoty',function(x) dchisq(x,3),ch9_poz$chi2,20,21,mark='plocha')))))
ch9_draw('zvladani', {
  par(mar=c(4.6,4.7,2.8,.8))
  m <- t(ch9_zvl_tab$radkove); celkem <- colSums(ch9_zvl)/sum(ch9_zvl)
  b <- barplot(m,beside=TRUE,ylim=c(0,.6),col=c(ch9_blue,ch9_mute,ch9_orange),border=ch9_ink,ylab='Podíl v rámci věkové skupiny (řádkový podíl)',
    names.arg=rep('',3),main='Preferovaná strategie zvládání stresu podle věku')
  fl_axis(1,at=colMeans(b),labels=c('mladí (*n* = 55)','dospělí (*n* = 80)','senioři (*n* = 55)'),tick=FALSE)
  for(j in 1:3) segments(b[j,]-.45,celkem[j],b[j,]+.45,celkem[j],lty=2,lwd=1.6,col=ch9_ink)
  text(b,m+.025,ch9_num(m,2),cex=.72)
  legend('topright',c(colnames(ch9_zvl),'podíl z celého výběru 190 osob'),fill=c(ch9_blue,ch9_mute,ch9_orange,NA),border=c(ch9_ink,ch9_ink,ch9_ink,NA),lty=c(NA,NA,NA,2),lwd=c(NA,NA,NA,1.6),bty='n',cex=.75)
},width=9,height=4.6)
ch9_fig('zvladani','sloupce',note='Tři skupiny sloupců (věkové skupiny), v každé tři sloupce strategií: řešení problému modře, vyhýbání šedě, sociální opora oranžově; nad sloupci jsou hodnoty podílů. Přes sloupce každé strategie vede přerušovaná vodorovná úsečka ve výši podílu této strategie v celém výběru.',panels=list(local({
  m <- ch9_zvl_tab$radkove
  tf_panel('Preferovaná strategie zvládání stresu podle věku','sloupcový graf','Věková skupina','Podíl v rámci věkové skupiny (řádkový podíl)',ylim=c(0,.6),
    series=list(tf_series('Řádkové podíly',data.frame(kategorie=rep(c('mladí (n = 55)','dospělí (n = 80)','senioři (n = 55)'),each=3),skupina=rep(colnames(ch9_zvl),3),y=as.vector(t(m))),'sloupce',digits=3,arrangement='vedle sebe'),
      tf_series('Podíl strategie v celém výběru 190 osob (přerušované úsečky)',data.frame(strategie=colnames(ch9_zvl),podil=colSums(ch9_zvl)/sum(ch9_zvl)),'tabulka',digits=3))) })))
ch9_draw('daniels', {
  layout(matrix(1:2,1),widths=c(1.35,1)); par(mar=c(4.6,4.7,3,.8))
  w <- ch9_dan_w
  plot(NA,xlim=c(.5,2.5),ylim=c(0,.55),xaxt='n',xlab='',ylab='Podíl žen s tématem sebeobjektivizace',main='Dva podíly (95% Wilsonovy intervaly)',bty='l')
  fl_axis(1,at=1:2,labels=c('sexualizované fotografie (*n* = 140)','sportovní fotografie (*n* = 117)'),cex.axis=.8)
  segments(1:2,w[,'dolni'],1:2,w[,'horni'],lwd=3,col=c(ch9_orange,ch9_blue)); points(1:2,w[,'p'],pch=21,bg='white',col=ch9_ink,cex=1.4)
  text(1:2+.2,w[,'p'],paste0(ch9_num(w[,'p'],3)),adj=0,cex=.8)
  r <- ch9_dan_two
  plot(NA,xlim=c(.5,1.5),ylim=c(-.05,.4),xaxt='n',xlab='',ylab='Rozdíl podílů',main='Rozdíl (95% Newcombův interval)',bty='l')
  abline(h=0,lty=2,col=ch9_gray); segments(1,r['dolni'],1,r['horni'],lwd=3,col=ch9_ink); points(1,r['rozdil'],pch=21,bg='white',col=ch9_ink,cex=1.4)
  text(1.08,r['rozdil'],paste0(ch9_num(r['rozdil'],3),'\n(',ch9_num(r['dolni'],3),'; ',ch9_num(r['horni'],3),')'),adj=0,cex=.78)
},width=9.6,height=4.4)
ch9_fig('daniels','data',note='Skutečná data: Daniels (2012). Svislé intervaly s bodovým odhadem jako bílým bodem a popiskem hodnoty; sexualizované fotografie oranžově, sportovní modře, rozdíl černě.',panels=list(
  tf_panel('Dva podíly (95% Wilsonovy intervaly)','intervalový graf','Typ fotografií','Podíl žen s tématem sebeobjektivizace',ylim=c(0,.55),
    series=list(tf_series('Podíly',data.frame(kategorie=c('sexualizované fotografie (n = 140)','sportovní fotografie (n = 117)'),od=ch9_dan_w[,'dolni'],do=ch9_dan_w[,'horni'],stred=ch9_dan_w[,'p']),'interval',digits=3,direction='svisle'))),
  tf_panel('Rozdíl (95% Newcombův interval)','intervalový graf','Rozdíl podílů (sexualizované − sportovní)','Rozdíl podílů',ylim=c(-.05,.4),guides=list(tf_guide('y',0,'žádný rozdíl')),
    series=list(tf_series('Rozdíl podílů',data.frame(kategorie='rozdíl',od=ch9_dan_two[['dolni']],do=ch9_dan_two[['horni']],stred=ch9_dan_two[['rozdil']]),'interval',digits=3,direction='svisle')))))
ch9_draw('pokryti-wald-wilson', {
  par(mfrow=c(2,4),mar=c(4.2,5.4,2.6,.6))
  for(n in ch9_cover_n) { m <- ch9_cover_res[[as.character(n)]]
    plot(NA,xlim=c(0,1),ylim=c(.4,1),xlab='',ylab=if(n==10) 'Skutečné pokrytí 95% intervalu' else '',main='',bty='l')
    fl_title(main=paste0('*n* = ',n),xlab='Populační podíl π')
    lines(ch9_cover_pi,m[,'wald'],col=ch9_orange,lwd=1.2); lines(ch9_cover_pi,m[,'wilson'],col=ch9_blue,lwd=1.2); abline(h=.95,lty=2,col=ch9_ink)
    if(n==10) legend('bottom',c('Waldův interval','Wilsonův interval','slibovaných 95 %'),col=c(ch9_orange,ch9_blue,ch9_ink),lty=c(1,1,2),lwd=c(1.8,1.8,1),bty='n',cex=.82) }
  for(n in ch9_cover_n) { m <- ch9_cover_res[[as.character(n)]]
    plot(NA,xlim=c(0,1),ylim=c(0,1),xlab='',ylab=if(n==10) 'Pravděpodobnost intervalu mimo 0–1\nnebo s nulovou šířkou' else '',bty='l')
    fl_title(xlab='Populační podíl π')
    lines(ch9_cover_pi,m[,'mimo'],col=ch9_orange,lwd=1.8); segments(0,0,1,0,col=ch9_blue,lwd=1.8)
    if(n==10) legend('top',c('Waldův interval','Wilsonův interval (vždy 0)'),col=c(ch9_orange,ch9_blue),lwd=1.8,bty='n',cex=.82) }
},width=11,height=6)
ch9_fig('pokryti-wald-wilson','krivka',note='Osm panelů ve dvou řadách po čtyřech (n = 10, 20, 50, 100). Horní řada: skutečné pokrytí 95% intervalu, Waldův oranžově, Wilsonův modře, přerušovaná čára ve výši 0,95. Dolní řada: pravděpodobnost, že Waldův interval přesáhne rozsah 0–1 nebo má nulovou šířku (oranžově); u Wilsonova intervalu je vždy 0 (modrá čára na ose). Křivky jsou přesné a zubaté; kvůli rozsahu je uvedena každá osmá hodnota (krok π = 0,016).',panels=local({
  k <- seq(1,length(ch9_cover_pi),by=8); pi <- ch9_cover_pi[k]
  c(lapply(ch9_cover_n,function(n) { m <- ch9_cover_res[[as.character(n)]][k,]
      tf_panel(paste0('n = ',n,': pokrytí'),'čárový graf','Populační podíl π','Skutečné pokrytí 95% intervalu',xlim=c(0,1),ylim=c(.4,1),guides=list(tf_guide('y',.95,'slibovaných 95 %')),
        series=list(tf_series('Waldův interval',data.frame(x=pi,y=m[,'wald']),'cara',digits=3,note='hodnoty pod 0,4 leží pod dolním okrajem grafu'),tf_series('Wilsonův interval',data.frame(x=pi,y=m[,'wilson']),'cara',digits=3))) }),
    lapply(ch9_cover_n,function(n) { m <- ch9_cover_res[[as.character(n)]][k,]
      tf_panel(paste0('n = ',n,': interval mimo 0–1 nebo s nulovou šířkou'),'čárový graf','Populační podíl π','Pravděpodobnost intervalu mimo 0–1 nebo s nulovou šířkou',xlim=c(0,1),ylim=c(0,1),
        guides=list(tf_guide('y',0,'Wilsonův interval: vždy 0')),series=list(tf_series('Waldův interval',data.frame(x=pi,y=m[,'mimo']),'cara',digits=3))) })) }))
ch9_draw('newcombe-konstrukce', {
  w <- ch9_stres_w; r <- ch9_stres_two; p1 <- .40; p2 <- .30
  dl <- c(p1-w[['zeny','dolni']],w[['muzi','horni']]-p2); du <- c(w[['zeny','horni']]-p1,p2-w[['muzi','dolni']])
  layout(matrix(c(1,1,2,3,4,4),3,byrow=TRUE),heights=c(1.1,1.7,.95))
  par(mar=c(4,9,2.8,.8))
  plot(NA,xlim=c(.18,.56),ylim=c(.45,2.8),yaxt='n',xlab='Podíl studentů se zvýšeným stresem',ylab='',bty='l',main='1. Wilsonovy intervaly obou skupin: z každého se použije jedna polovina')
  fl_axis(2,at=2:1,labels=c('ženy (*n* = 100)','muži (*n* = 100)'),tick=FALSE)
  segments(w[['zeny','dolni']],2,p1,2,lwd=8,col=ch9_orange,lend=1); segments(p1,2,w[['zeny','horni']],2,lwd=8,col=ch9_blue,lend=1)
  segments(w[['muzi','dolni']],1,p2,1,lwd=8,col=ch9_blue,lend=1); segments(p2,1,w[['muzi','horni']],1,lwd=8,col=ch9_orange,lend=1)
  points(c(p1,p2),2:1,pch=21,bg='white',col=ch9_ink,cex=1.7)
  text(c((w[['zeny','dolni']]+p1)/2,(p2+w[['muzi','horni']])/2),c(2.32,1.32),ch9_num(dl,3),col=ch9_orange,font=2)
  text(c((p1+w[['zeny','horni']])/2,(w[['muzi','dolni']]+p2)/2),c(2.32,1.32),ch9_num(du,3),col=ch9_blue,font=2)
  text(c(w[['zeny','dolni']],p1,w[['zeny','horni']]),1.7,ch9_num(c(w[['zeny','dolni']],p1,w[['zeny','horni']]),3),cex=.8,col=ch9_gray)
  text(c(w[['muzi','dolni']],p2,w[['muzi','horni']]),.7,ch9_num(c(w[['muzi','dolni']],p2,w[['muzi','horni']]),3),cex=.8,col=ch9_gray)
  legend('topleft',c('vzdálenosti pro dolní mez rozdílu','vzdálenosti pro horní mez rozdílu'),fill=c(ch9_orange,ch9_blue),border=NA,bty='n',cex=.9)
  pyth <- function(a,b,col,main,la,lb) { cc <- sqrt(a^2+b^2); par(mar=c(.4,.6,2.6,.6))
    plot(NA,xlim=c(-b-.035,a+b+.035),ylim=c(-a-.005,a+b+.005),asp=1,axes=FALSE,xlab='',ylab='',main=main)
    polygon(c(0,a,a,0),c(0,0,-a,-a),col=adjustcolor(col,.22),border=col)
    polygon(c(0,0,-b,-b),c(0,b,b,0),col=adjustcolor(col,.22),border=col)
    polygon(c(a,0,b,a+b),c(0,b,a+b,a),col=adjustcolor(col,.5),border=col)
    polygon(c(0,a,0),c(0,0,b),col='white',border=ch9_ink,lwd=1.6)
    text(a/2,-a/2,paste0(la,'\n',ch9_num(a,4),'² = ',ch9_num(a^2,4)),cex=.9)
    text(-b/2,b/2,paste0(lb,'\n',ch9_num(b,4),'² = ',ch9_num(b^2,4)),cex=.9)
    fl_text((a+b)/2,(a+b)/2,paste0('součet čtverců\n',ch9_num(a^2,4),' + ',ch9_num(b^2,4),'\n= ',ch9_num(a^2+b^2,4),'\nstrana: √',ch9_num(a^2+b^2,4),' = ',ch9_num(cc,3)),cex=.9,font=2) }
  pyth(dl[1],dl[2],ch9_orange,'2a. Dolní mez: čtverce oranžových vzdáleností','ženy','muži')
  pyth(du[1],du[2],ch9_blue,'2b. Horní mez: čtverce modrých vzdáleností','ženy','muži')
  par(mar=c(4.2,9,2.8,.8))
  plot(NA,xlim=c(-.08,.3),ylim=c(.6,1.7),yaxt='n',xlab='Rozdíl podílů (ženy − muži)',ylab='',bty='l',main='3. Interval pro rozdíl: strany velkých čtverců odečteme od rozdílu 0,10 a přičteme k němu')
  axis(2,at=1,labels='rozdíl podílů',tick=FALSE); abline(v=0,lty=2,col=ch9_gray)
  segments(r[['dolni']],1,r[['rozdil']],1,lwd=8,col=ch9_orange,lend=1); segments(r[['rozdil']],1,r[['horni']],1,lwd=8,col=ch9_blue,lend=1)
  points(r[['rozdil']],1,pch=21,bg='white',col=ch9_ink,cex=1.7)
  text((r[['dolni']]+r[['rozdil']])/2,1.38,paste0('0,10 − ',ch9_num(sqrt(sum(dl^2)),3),' = ',ch9_num(r[['dolni']],3)),col=ch9_orange,font=2)
  text((r[['rozdil']]+r[['horni']])/2,1.38,paste0('0,10 + ',ch9_num(sqrt(sum(du^2)),3),' = ',ch9_num(r[['horni']],3)),col=ch9_blue,font=2)
},width=9.6,height=9)
ch9_fig('newcombe-konstrukce','data',note='Obrázek má tři části pod sebou. 1: Wilsonovy intervaly obou skupin; od podílu doleva a doprava jsou barevně odlišené poloviny s popisky vzdáleností. 2a a 2b: dva pravoúhlé trojúhelníky se čtverci nad stranami (Pythagorova věta): odvěsnami jsou vzdálenosti jedné barvy z části 1, přepona dává vzdálenost meze rozdílu od rozdílu 0,10. 3: interval pro rozdíl podílů. Části 2a a 2b nejsou v datech jako graf; hodnoty uvádí poznámka k panelu 1.',panels=local({
  w <- ch9_stres_w; r <- ch9_stres_two; dl <- c(.40-w[['zeny','dolni']],w[['muzi','horni']]-.30); du <- c(w[['zeny','horni']]-.40,.30-w[['muzi','dolni']])
  list(tf_panel('1. Wilsonovy intervaly obou skupin: z každého se použije jedna polovina','intervalový graf','Podíl studentů se zvýšeným stresem','Skupina',xlim=c(.18,.56),
      note=paste0('Pro dolní mez rozdílu (oranžově): vzdálenost dolní meze žen od 0,40 je ',ch9_num(dl[1],4),', vzdálenost horní meze mužů od 0,30 je ',ch9_num(dl[2],4),'; odmocnina ze součtu čtverců je ',ch9_num(sqrt(sum(dl^2)),3),
        '. Pro horní mez rozdílu (modře): ',ch9_num(du[1],4),' a ',ch9_num(du[2],4),'; odmocnina ze součtu čtverců je ',ch9_num(sqrt(sum(du^2)),3),'.'),
      series=list(tf_series('Wilsonovy intervaly',data.frame(kategorie=c('ženy (n = 100)','muži (n = 100)'),od=w[,'dolni'],do=w[,'horni'],stred=c(.40,.30)),'interval',digits=3,direction='vodorovně'))),
    tf_panel('3. Interval pro rozdíl: strany velkých čtverců odečteme od rozdílu 0,10 a přičteme k němu','intervalový graf','Rozdíl podílů (ženy − muži)','Rozdíl',xlim=c(-.08,.3),guides=list(tf_guide('x',0,'žádný rozdíl')),
      series=list(tf_series('Newcombův interval',data.frame(kategorie='rozdíl podílů',od=r[['dolni']],do=r[['horni']],stred=r[['rozdil']]),'interval',digits=3,direction='vodorovně')))) }))
ch9_draw('podil-tri-rozdeleni', {
  ex <- ch9_t20_ex; n <- 20; mu <- 5; sdv <- sqrt(3.75); k <- 10; q <- ch9_t20_score[['z']]^2; crit <- qchisq(.95,1)
  layout(matrix(c(1,1,2,2,3,4),3,byrow=TRUE),heights=c(1.42,.84,1.06)); par(cex=.8)
  x <- 0:15; pr <- ex$pr[x+1]; less <- ex$less[x+1]; xl <- c(-2.9,15.6); xx <- seq(xl[1],xl[2],length.out=500)
  cols <- ifelse(x==k,ch9_orange,ifelse(less,adjustcolor(ch9_orange,.4),ch9_pale))
  sloupce <- function() { rect(x-.4,0,x+.4,pr,col=cols,border=ch9_ink)
    for(s in list(seq(xl[1],2*mu-k,length.out=80),seq(k,xl[2],length.out=120))) polygon(c(s,rev(s)),c(dnorm(s,mu,sdv),rep(0,length(s))),col=adjustcolor(ch9_blue,.5),border=NA)
    lines(xx,dnorm(xx,mu,sdv),lwd=2,col=ch9_blue) }
  # 1. Exact binomial distribution with the normal curve; one horizontal axis in three units.
  par(mar=c(9.2,5.4,2.6,.8))
  plot(NA,xlim=xl,ylim=c(0,.238),xaxs='i',xaxt='n',xlab='',ylab='',main='1. Přesně binomické rozdělení (sloupce), přibližně normální křivka',bty='l')
  sloupce(); at <- c(0,5,10,15); title(ylab='Pravděpodobnost',line=3.9)
  axis(1,at=0:15,labels=FALSE,tcl=-.25); axis(1,at=at); mtext('Počet správných odpovědí',side=1,line=1.8,cex=.8)
  axis(1,at=at,labels=ch9_num(at/n),line=3.1); fl_mtext('Podíl správných odpovědí *p*',side=1,line=4.9,cex=.8)
  axis(1,at=at,labels=ch9_num((at-mu)/sdv),line=6.2); fl_mtext('Statistika *z*',side=1,line=8,cex=.8)
  fl_legend('topright',c('pozorovaný výsledek: 10 správných odpovědí z 20','stejně nebo méně pravděpodobné výsledky','pravděpodobnější výsledky',
      'normální křivka (střední hodnota 5, směrodatná odchylka 1,94)','chvosty normální křivky za *z* = −2,58 a *z* = 2,58'),
    fill=c(ch9_orange,adjustcolor(ch9_orange,.4),ch9_pale,NA,adjustcolor(ch9_blue,.5)),border=c(ch9_ink,ch9_ink,ch9_ink,NA,NA),lwd=c(NA,NA,NA,2,NA),col=c(NA,NA,NA,ch9_blue,NA),bty='n',cex=.9)
  fl_text(xl[2]-.15,.118,paste0('součet oranžových sloupců = ',ch9_num(ex$p,3),' (přesná *p*-hodnota)'),adj=1,cex=.92,font=2,col=ch9_orange)
  fl_text(xl[2]-.15,.1,paste0('plocha obou modrých chvostů = ',ch9_num(ch9_t20_score[['p']],4),' (přibližná *p*-hodnota)'),adj=1,cex=.92,font=2,col=ch9_blue)
  # 2. The same bars and curve with a magnified vertical axis: the two tails.
  par(mar=c(3.6,5.4,2.6,.8))
  plot(NA,xlim=xl,ylim=c(0,.034),xaxs='i',yaxs='i',xaxt='n',xlab='',ylab='',main='2. Oba chvosty zvětšeně (sloupce pro 2 až 8 správných odpovědí přesahují okraj grafu)',bty='l')
  sloupce(); axis(1,at=0:15); mtext('Počet správných odpovědí',side=1,line=2.1,cex=.8); title(ylab='Pravděpodobnost',line=3.9)
  text(-1.55,.0235,paste0('levý chvost\nsloupec 0: ',ch9_num(ex$pr[1],4),'\npod křivkou: ',ch9_num(ch9_t20_chvost,4)),cex=.88)
  text(13.2,.0235,paste0('pravý chvost\nsloupce 10 až 20: ',ch9_num(ex$horni,4),'\npod křivkou: ',ch9_num(ch9_t20_chvost,4)),cex=.88)
  # 3. Right tail of the same probabilities after squaring z: counts equally far from 5 fall on the same value.
  par(mar=c(4.4,5.4,2.6,.8)); xr <- c(3,14.6); yr <- c(0,.058)
  z2 <- (ex$x-mu)^2/sdv^2; v <- sort(unique(round(z2[z2>xr[1] & z2<xr[2]],6))); lo <- sapply(v,function(u) sum(ex$pr[ex$x<mu & abs(z2-u)<1e-6])); hi <- sapply(v,function(u) sum(ex$pr[ex$x>mu & abs(z2-u)<1e-6]))
  lab <- sapply(v,function(u) paste(ex$x[abs(z2-u)<1e-6],collapse=' a ')); ext <- v>=q-1e-6; tot <- lo+hi
  plot(NA,xlim=xr,ylim=yr,xaxs='i',yaxs='i',xlab='',ylab='',main='',bty='l'); fl_title(main='3. Po umocnění: pravý chvost hodnot *z*²',xlab='Hodnota *z*²'); title(ylab='Pravděpodobnost',line=3.9)
  rect(v-.3,0,v+.3,lo,col=ifelse(ext,adjustcolor(ch9_orange,.4),ch9_pale),border=ch9_ink); rect(v-.3,lo,v+.3,tot,col=ifelse(ext,ch9_orange,ch9_mute),border=ch9_ink)
  text(v,tot+.0056,paste0('počet ',lab,'\n',ch9_num(tot,4)),cex=.86)
  fl_text(11,.036,paste0('*z*² alespoň ',ch9_num(q),':\noba chvosty dohromady\n',ch9_num(ex$p,3),' (přesně)'),col=ch9_orange,font=2,cex=.92)
  legend('topright',c('počet menší než 5','počet větší než 5'),fill=c(ch9_pale,ch9_mute),border=ch9_ink,bty='n',cex=.88)
  # 4. Right tail of the chi-square distribution with one degree of freedom as the approximation.
  xc <- seq(xr[1],xr[2],length.out=500)
  plot(NA,xlim=xr,ylim=yr,xaxs='i',yaxs='i',xlab='',ylab='',main='4. Přibližně: pravý chvost chí-kvadrát rozdělení',bty='l'); fl_title(xlab='Hodnota χ²'); title(ylab='Hustota',line=3.9)
  s <- seq(crit,xr[2],length.out=200); polygon(c(s,rev(s)),c(dchisq(s,1),rep(0,200)),col=adjustcolor(ch9_orange,.3),border=NA)
  s <- seq(q,xr[2],length.out=200); polygon(c(s,rev(s)),c(dchisq(s,1),rep(0,200)),col=ch9_orange,border=NA)
  lines(xc,dchisq(xc,1),lwd=2,col=ch9_blue)
  segments(crit,0,crit,.044,lty=3,col=ch9_ink); text(crit+.12,.0465,'kritická hodnota 1,96² = 3,84',cex=.86,adj=c(0,.5))
  arrows(q,.02,q,.0075,length=.08,col=ch9_orange,lwd=1.6); fl_text(q,.0235,paste0('naše χ² = ',ch9_num(q)),cex=.86,col=ch9_orange)
  text(11.2,.021,paste0('plocha napravo od ',ch9_num(q),':\n',ch9_num(ch9_t20_score[['p']],4),' (přibližně)'),col=ch9_orange,font=2,cex=.92)
  legend(x=8.4,y=.041,c('5 % napravo od 3,84','křivka pro 1 stupeň volnosti'),fill=c(adjustcolor(ch9_orange,.3),NA),border=NA,lwd=c(NA,2),col=c(NA,ch9_blue),bty='n',cex=.88)
},width=9.6,height=9.6)
ch9_fig('podil-tri-rozdeleni','sloupce',note='Čtyři části. 1 (nahoře přes celou šířku): binomické rozdělení počtu správných odpovědí pro n = 20 a π = 0,25 se třemi vodorovnými osami pod sebou (počet, podíl, statistika z) a s normální křivkou; pozorovaný počet 10 je sytě oranžový, stejně nebo méně pravděpodobné počty světle oranžové, modře jsou vybarveny chvosty normální křivky za z = −2,58 a z = 2,58. 2 (pod ní): tytéž sloupce a křivka se zvětšenou svislou osou, takže jsou vidět oba chvosty; sloupce pro 2 až 8 přesahují okraj. 3 (vlevo dole): pravděpodobnosti nad hodnotami z² od 3 výše; počty stejně vzdálené od 5 leží na stejné hodnotě a jejich sloupce stojí na sobě. 4 (vpravo dole): pravý chvost křivky chí-kvadrát rozdělení s 1 stupněm volnosti s plochou napravo od 6,67.',panels=local({
  ex <- ch9_t20_ex; mu <- 5; sdv <- sqrt(3.75); q <- ch9_t20_score[['z']]^2; x <- 0:15
  z2 <- (ex$x-mu)^2/sdv^2; v <- sort(unique(round(z2[ex$x<=12],6)))
  list(tf_panel('1. Přesně binomické rozdělení (sloupce), přibližně normální křivka','sloupcový graf','Počet správných odpovědí (pod ním podíl správných odpovědí p a statistika z)','Pravděpodobnost',xlim=c(-2.9,15.6),ylim=c(0,.238),
      note=paste0('Součet oranžových sloupců (počty 0 a 10 až 20) = ',ch9_num(ex$p,3),' (přesná p-hodnota); z toho počty 10 až 20 dohromady ',ch9_num(ex$horni,4),' a počet 0 ',ch9_num(ex$pr[1],4),'. Plocha obou chvostů normální křivky = ',ch9_num(ch9_t20_score[['p']],4),' (přibližná p-hodnota), každý chvost ',ch9_num(ch9_t20_chvost,4),'. Počty nad 15 mají pravděpodobnost menší než 0,00001 a nejsou zobrazeny. Část 2 obrázku ukazuje tatáž data se svislou osou od 0 do 0,034.'),
      series=list(tf_series('Binomické rozdělení',data.frame(x=x,y=ex$pr[x+1],podil=x/20,z=(x-mu)/sdv,zvyrazneno=ifelse(x==10,'pozorovaný',ifelse(ex$less[x+1],'stejně nebo méně pravděpodobný','ne'))),'sloupce',digits=4),
        tf_curve('Normální křivka (střední hodnota 5, směrodatná odchylka 1,94)',function(u) dnorm(u,mu,sdv),-2.9,15.6,75),
        tf_curve('Levý chvost normální křivky (z nejvýše −2,58)',function(u) dnorm(u,mu,sdv),-2.9,0,13,mark='plocha'),tf_curve('Pravý chvost normální křivky (z alespoň 2,58)',function(u) dnorm(u,mu,sdv),10,15.6,21,mark='plocha'))),
    tf_panel('3. Po umocnění: pravý chvost hodnot z²','sloupcový graf','Hodnota z²','Pravděpodobnost',xlim=c(3,14.6),ylim=c(0,.058),
      note=paste0('Graf zobrazuje jen hodnoty z² od 3 výše; data uvádějí všechny hodnoty pro počty 0 až 12. Sloupce s hodnotou z² alespoň ',ch9_num(q),' jsou oranžové; jejich součet je ',ch9_num(ex$p,3),' (přesně). Každý sloupec se skládá z části pro počet menší než 5 a z části pro počet větší než 5.'),
      series=list(tf_series('Pravděpodobnosti hodnot z²',data.frame(x=v,y=sapply(v,function(u) sum(ex$pr[abs(z2-u)<1e-6])),pocty=sapply(v,function(u) paste(ex$x[abs(z2-u)<1e-6],collapse=' a ')),
        pocet_pod_5=sapply(v,function(u) sum(ex$pr[ex$x<mu & abs(z2-u)<1e-6])),pocet_nad_5=sapply(v,function(u) sum(ex$pr[ex$x>mu & abs(z2-u)<1e-6])),zvyrazneno=ifelse(v>=q-1e-6,'ano','ne')),'sloupce',digits=4))),
    tf_panel('4. Přibližně: pravý chvost chí-kvadrát rozdělení','čárový graf','Hodnota χ²','Hustota',xlim=c(3,14.6),ylim=c(0,.058),guides=list(tf_guide('x',qchisq(.95,1),'kritická hodnota 1,96² = 3,84'),tf_guide('x',q,paste0('naše χ² = ',ch9_num(q)))),
      note=paste0('Chí-kvadrát rozdělení s 1 stupněm volnosti. Plocha napravo od ',ch9_num(q),': ',ch9_num(ch9_t20_score[['p']],4),' (přibližně). Světle oranžová plocha napravo od 3,84 má velikost 5 %.'),
      series=list(tf_curve('Chí-kvadrát rozdělení',function(u) dchisq(u,1),3,14.6,59),tf_curve('Plocha napravo od 3,84 (5 %)',function(u) dchisq(u,1),qchisq(.95,1),14.6,21,mark='plocha'),
        tf_curve('Plocha napravo od pozorované hodnoty',function(u) dchisq(u,1),q,14.6,21,mark='plocha')))) }))
ch9_draw('fisher-tabulky', {
  par(mar=c(.6,7.2,2.8,.6)); fi <- ch9_pilot_fisher; a <- fi$a; pr <- fi$pr
  plot(NA,xlim=c(.5,10.5),ylim=c(-.19,.4),axes=FALSE,xlab='',ylab='',main='Deset možných tabulek se stejnými okrajovými součty a jejich pravděpodobnost')
  axis(2,at=seq(0,.3,by=.1),labels=ch9_num(seq(0,.3,by=.1),1)); mtext('Pravděpodobnost tabulky',side=2,line=3.4,at=.17,las=0,cex=.85)
  less <- pr<=fi$pobs*(1+1e-7)
  rect(a-.38,0,a+.38,pr,col=ifelse(a==ch9_pilot[1,1],ch9_orange,ifelse(less,adjustcolor(ch9_orange,.4),ch9_pale)),border=ch9_ink)
  segments(.55,fi$pobs,10.45,fi$pobs,lty=2,col=ch9_orange); text(a,pr+.014,ifelse(pr<.0005,'< 0,001',ch9_num(pr,3)),cex=.8)
  for(k in a) { ob <- k==ch9_pilot[1,1]
    rect(k-.38,-.15,k+.38,-.03,col=if(ob) ch9_sand else 'white',border=if(ob) ch9_orange else ch9_gray,lwd=if(ob) 2 else 1)
    segments(k,-.15,k,-.03,col=ch9_mute); segments(k-.38,-.09,k+.38,-.09,col=ch9_mute)
    text(c(k-.19,k+.19,k-.19,k+.19),c(-.06,-.06,-.12,-.12),c(k,10-k,11-k,k-1),cex=.9,font=if(ob) 2 else 1) }
  mtext(c('intervence','kontrola'),side=2,at=c(-.06,-.12),las=1,line=.4,cex=.75)
  text(a,-.172,'zlepšení | bez',cex=.6,col=ch9_gray)
  text(8,.115,'pozorovaná\ntabulka',cex=.8,col=ch9_orange,font=2)
  legend(x=.5,y=.4,c('pozorovaná tabulka','stejně nebo méně pravděpodobná než pozorovaná','pravděpodobnější než pozorovaná'),fill=c(ch9_orange,adjustcolor(ch9_orange,.4),ch9_pale),border=ch9_ink,bty='n',cex=.8)
  fl_text(10.45,.36,paste0('*p*-hodnota = součet oranžových sloupců = ',ch9_num(fi$p,3)),adj=1,cex=.85,font=2)
},width=10,height=5.2)
ch9_fig('fisher-tabulky','sloupce',note='Deset sloupců, pod každým malá tabulka 2 × 2 s četnostmi (řádky intervence a kontrola, sloupce zlepšení a bez zlepšení). Pozorovaná tabulka je sytě oranžová, tabulky stejně nebo méně pravděpodobné světle oranžové, pravděpodobnější šedé. Nad sloupci jsou pravděpodobnosti. p-hodnota je součet oranžových sloupců.',panels=list(local({
  fi <- ch9_pilot_fisher; a <- fi$a; less <- fi$pr<=fi$pobs*(1+1e-7)
  tf_panel('Deset možných tabulek se stejnými okrajovými součty a jejich pravděpodobnost','sloupcový graf','Tabulka (počet zlepšených v intervenční skupině)','Pravděpodobnost tabulky',ylim=c(0,.4),
    guides=list(tf_guide('y',fi$pobs,'pravděpodobnost pozorované tabulky')),note=paste0('p-hodnota = součet oranžových sloupců = ',ch9_num(fi$p,3),'.'),
    series=list(tf_series('Možné tabulky',data.frame(x=a,y=fi$pr,intervence_zlepseni=a,intervence_bez=10-a,kontrola_zlepseni=11-a,kontrola_bez=a-1,
      zvyrazneno=ifelse(a==ch9_pilot[1,1],'pozorovaná',ifelse(less,'stejně nebo méně pravděpodobná','ne'))),'sloupce',digits=4))) })))
ch9_draw('monte-carlo', {
  par(mfrow=c(1,2),mar=c(4.6,4.6,3,.8)); obs <- ch9_pilot_tab$chi2
  tb <- table(round(ch9_pilot_mc,2))/length(ch9_pilot_mc); v <- as.numeric(sub(',','.',names(tb)))
  plot(NA,xlim=c(0,18),ylim=c(0,.78),xlab='',ylab='Podíl z 10 000 přeskupení',main='Simulace: 10 000 přeskupení tabulky',bty='l')
  fl_title(xlab='Hodnota χ² po přeskupení')
  segments(v,0,v,tb,lwd=10,lend=1,col=ifelse(v>=obs-.01,ch9_orange,ch9_mute)); text(v,as.numeric(tb)+.035,ifelse(tb<.0005,'< 0,001',ch9_num(as.numeric(tb),3)),cex=.78)
  arrows(obs,.3,obs,.12,length=.08,col=ch9_orange,lwd=1.6); fl_text(obs,.34,paste0('naše χ² = ',ch9_num(obs)),cex=.8,col=ch9_orange)
  fl_text(12,.56,paste0('podíl hodnot alespoň ',ch9_num(obs),':\n',ch9_num(ch9_pilot_mc_p,3),' (simulovaná *p*-hodnota)'),col=ch9_orange,font=2,cex=.82)
  x <- seq(.04,18,length.out=600)
  plot(x,dchisq(x,1),type='n',ylim=c(0,.78),xlab='',ylab='Hustota',main='Aproximace: chí-kvadrát rozdělení (1 st. volnosti)',bty='l')
  fl_title(xlab='Hodnota χ²')
  xx <- seq(obs,18,length.out=200); polygon(c(xx,rev(xx)),c(dchisq(xx,1),rep(0,200)),col=adjustcolor(ch9_orange,.6),border=NA)
  lines(x,dchisq(x,1),lwd=2,col=ch9_blue); arrows(obs,.3,obs,.06,length=.08,col=ch9_orange,lwd=1.6); fl_text(obs,.34,paste0('naše χ² = ',ch9_num(obs)),cex=.8,col=ch9_orange)
  text(12,.56,paste0('plocha napravo od ',ch9_num(obs),':\n',ch9_num(ch9_pilot_tab$p,3)),col=ch9_orange,font=2,cex=.82)
},width=10.4,height=4.4)
ch9_fig('monte-carlo','simulace',note='Vlevo podíly hodnot statistiky χ² z 10 000 náhodných přeskupení tabulky; sloupce s hodnotou alespoň rovnou pozorované jsou oranžové a nad sloupci jsou podíly. Vpravo křivka chí-kvadrát rozdělení s 1 stupněm volnosti s oranžovou plochou napravo od pozorované hodnoty.',panels=local({
  obs <- ch9_pilot_tab$chi2; tb <- table(round(ch9_pilot_mc,2))/length(ch9_pilot_mc); v <- as.numeric(sub(',','.',names(tb)))
  list(tf_panel('Simulace: 10 000 přeskupení tabulky','sloupcový graf','Hodnota χ² po přeskupení','Podíl z 10 000 přeskupení',xlim=c(0,18),ylim=c(0,.78),guides=list(tf_guide('x',obs,paste0('naše χ² = ',ch9_num(obs)))),
      note=paste0('Podíl hodnot alespoň ',ch9_num(obs),': ',ch9_num(ch9_pilot_mc_p,3),' (simulovaná p-hodnota).'),
      series=list(tf_series('Podíly hodnot',data.frame(x=v,y=as.numeric(tb),zvyrazneno=ifelse(v>=obs-.01,'ano','ne')),'sloupce',digits=4))),
    tf_panel('Aproximace: chí-kvadrát rozdělení (1 st. volnosti)','čárový graf','Hodnota χ²','Hustota',xlim=c(0,18),ylim=c(0,.78),guides=list(tf_guide('x',obs,paste0('naše χ² = ',ch9_num(obs)))),
      note=paste0('Plocha napravo od ',ch9_num(obs),': ',ch9_num(ch9_pilot_tab$p,3),'.'),
      series=list(tf_curve('Chí-kvadrát rozdělení',function(x) dchisq(x,1),.04,18,91,note='u nuly roste nad horní okraj grafu'),tf_curve('Plocha napravo od pozorované hodnoty',function(x) dchisq(x,1),obs,18,21,mark='plocha')))) }))
ch9_draw('kappa-shody', {
  par(mar=c(.4,.4,2.6,.4)); f <- ch9_kappa_t; e <- ch9_kappa_e; lab <- c('bez problémů','internalizační\nproblémy','externalizační\nproblémy')
  plot(NA,xlim=c(-2.1,4.1),ylim=c(-1.25,4),axes=FALSE,xlab='',ylab='',main='Zařazení 30 dospívajících dvěma posuzovateli')
  for(i in 1:3) for(j in 1:3) { d <- i==j
    rect(j-1,3-i,j,4-i,col=if(d) adjustcolor(ch9_green,.4) else ch9_sand,border='white',lwd=4)
    text(j-.5,3.6-i,f[i,j],cex=1.6,font=if(d) 2 else 1); text(j-.5,3.25-i,paste0('(',ch9_num(e[i,j]),')'),cex=.85,col=ch9_gray) }
  text((1:3)-.5,3.28,lab,cex=.82); text(1.5,3.78,'První posuzovatel',font=2,cex=.95)
  text(-.08,(3:1)-.5,lab,adj=1,cex=.82); text(-1.95,1.5,'Druhý posuzovatel',font=2,cex=.95,srt=90)
  text(3.5,(3:1)-.5,rowSums(f)); text((1:3)-.5,-.25,colSums(f)); text(3.5,-.25,sum(f),font=2)
  text(3.5,3.28,'Celkem',cex=.82); text(-.08,-.25,'Celkem',adj=1,cex=.82)
  legend(x=-1.2,y=-.55,c(paste0('shoda: ',sum(diag(f)),' pozorovaných, ',ch9_num(sum(diag(e))),' očekávaných při náhodném zařazování'),'neshoda; v závorce očekávaná četnost'),
    fill=c(adjustcolor(ch9_green,.4),ch9_sand),border=NA,bty='n',cex=.85)
},width=8,height=5.2)
ch9_fig('kappa-shody','data',note='Tabulka 3 × 3: řádky druhý posuzovatel, sloupce první posuzovatel. V každé buňce je pozorovaná četnost a v závorce očekávaná četnost; buňky shody na úhlopříčce jsou zelené, ostatní světlé. Vpravo a dole jsou okrajové součty, celkem 30.',panels=list(local({
  lab <- c('bez problémů','internalizační problémy','externalizační problémy')
  tf_panel('Zařazení 30 dospívajících dvěma posuzovateli','tabulka',
    note=paste0('Shoda: ',sum(diag(ch9_kappa_t)),' pozorovaných, ',ch9_num(sum(diag(ch9_kappa_e))),' očekávaných při náhodném zařazování.'),
    series=list(tf_series('Buňky tabulky',data.frame(druhy_posuzovatel=rep(lab,each=3),prvni_posuzovatel=rep(lab,3),pozorovana_cetnost=as.vector(t(ch9_kappa_t)),ocekavana_cetnost=as.vector(t(ch9_kappa_e)),
      shoda=ifelse(rep(1:3,each=3)==rep(1:3,3),'ano','ne')),'tabulka'))) })))
options(ch9_old_options)
