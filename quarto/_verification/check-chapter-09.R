# Independent known-value checks for chapter 9: examples, tables, exercises and figures.
# The chapter procedures are compared with base R (prop.test, chisq.test, fisher.test, binom.test, mcnemar.test, p.adjust)
# and every number quoted in the text and solutions is checked at the precision shown.
if (.Platform$OS.type=='windows') Sys.setlocale('LC_CTYPE','.UTF-8')
source('scripts/kapitola_09.R',encoding='UTF-8')
eq <- function(actual,expected,tol=1e-10) stopifnot(isTRUE(all.equal(as.numeric(actual),as.numeric(expected),tolerance=tol)))
rq <- function(actual,expected,d) stopifnot(all(abs(as.numeric(actual)-as.numeric(expected))<=.5*10^(-d)+1e-9))
pt2 <- function(x,n) prop.test(x,n,correct=FALSE)
# Wilson interval = prop.test without continuity correction; the uncorrected Pearson test equals the pooled z test.
for (xn in list(c(10,20),c(0,15),c(40,80),c(40,100),c(30,100),c(18,60),c(72,240),c(0,25),c(1,25),c(56,140),c(20,117),c(106,329)))
  eq(ch9_wilson(xn[1],xn[2])[c('dolni','horni')],pt2(xn[1],xn[2])$conf.int,1e-10)
eq(ch9_stres_two['chi2'],chisq.test(ch9_stres,correct=FALSE)$statistic,1e-12)
stopifnot(abs(chisq.test(ch9_stres)$statistic-1.78022)<1e-5) # default Yates correction differs (stated in docs)
eq(ch9_stres_tab$upravena,unname(chisq.test(ch9_stres,correct=FALSE)$stdres),1e-12)
eq(unname(ch9_zvl_tab$upravena),unname(chisq.test(ch9_zvl)$stdres),1e-12); eq(unname(ch9_zvl_tab$pearson),unname(chisq.test(ch9_zvl)$residuals),1e-12)
eq(ch9_zvl_tab$chi2,chisq.test(ch9_zvl)$statistic,1e-12); eq(ch9_poz$chi2,chisq.test(ch9_pozice)$statistic,1e-12)
for (m in list(ch9_stres,ch9_pilot,ch9_u04,ch9_u12)) eq(ch9_fisher(m)$p,fisher.test(m)$p.value,1e-9)
eq(ch9_pomoc_mc['presne'],binom.test(12,16)$p.value,1e-12); eq(ch9_pomoc_mc['priblizne'],mcnemar.test(ch9_pomoc,correct=FALSE)$p.value,1e-12)
eq(ch9_u11_mc['presne'],binom.test(11,14)$p.value,1e-12)
# Newcombe hybrid score interval checked against an independent written-out formula (Newcombe, method 10).
nc <- function(x1,n1,x2,n2){ w1 <- pt2(x1,n1)$conf.int; w2 <- pt2(x2,n2)$conf.int; p1 <- x1/n1; p2 <- x2/n2
  c(p1-p2-sqrt((p1-w1[1])^2+(w2[2]-p2)^2),p1-p2+sqrt((w1[2]-p1)^2+(p2-w2[1])^2)) }
eq(ch9_stres_two[c('dolni','horni')],nc(40,100,30,100)); eq(ch9_dan_two[c('dolni','horni')],nc(56,140,20,117))
eq(ch9_u04_two[c('dolni','horni')],nc(13,49,14,44)); eq(ch9_u12_two[c('dolni','horni')],nc(6,8,2,9)); eq(ch9_stres_dvoj[c('dolni','horni')],nc(80,200,60,200))
# Section 1-3: stress table, one proportion, two proportions.
rq(ch9_stres_w[,'dolni'],c(.309,.219),3); rq(ch9_stres_w[,'horni'],c(.498,.396),3)
s <- ch9_stres_two; rq(s['se_wald'],.067,3); rq(c(s['wald_dolni'],s['wald_horni']),c(-.03,.23),2); rq(c(s['dolni'],s['horni']),c(-.032,.227),3)
rq(s['se0'],.0675,4); rq(s['z'],1.482,3); rq(s['z'],1.48,2); rq(s['chi2'],2.198,3); rq(s['p'],.138,3)
rq(sqrt((.40-.309)^2+(.396-.30)^2),.132,3); rq(sqrt((.498-.40)^2+(.30-.219)^2),.127,3)
rq(c(ch9_stres_dvoj['p'],ch9_stres_dvoj['dolni'],ch9_stres_dvoj['horni']),c(.036,.007,.191),3)
rq(ch9_t20_wald[c('se','dolni','horni')],c(.112,.28,.72),c(3,2,2)); rq(ch9_t20_wald[c('dolni','horni')],c(.281,.719),3)
rq(ch9_t20_wil[c('stred','pul','dolni','horni')],c(.500,.201,.299,.701),3); rq(ch9_t20_wil[c('dolni','horni')],c(.30,.70),2)
rq(ch9_n15_wil[c('stred','horni')],c(.102,.20),c(3,2)); rq(ch9_t80_wil[c('dolni','horni')],c(.39,.61),2)
rq(ch9_t20_score,c(2.58,.0098),c(2,4)); rq(sqrt(.25*.75/20),.0968,4); rq(ch9_t20_binom,.014,3)
rq(c(ch9_ganz['p'],ch9_ganz['dolni'],ch9_ganz['horni'],ch9_ganz['p_binom']),c(.322,.274,.374,.002),3)
# Sections 4-5: goodness of fit and the simulated distribution.
p <- ch9_poz; eq(p$e,rep(20,4)); eq(p$prispevky,c(3.2,.8,.05,6.05)); eq(p$chi2,10.1); rq(p$p,.018,3); rq(p$p,.0177,4); rq(qchisq(.95,3),7.81,2); rq(qchisq(.95,3),7.815,3)
rq(mean(ch9_sim),2.99,2); rq(mean(ch9_sim>=10.1),.016,3); rq(mean(ch9_sim>qchisq(.95,3)),.050,3)
rq(ch9_poz_w[,'p'],c(.15,.20,.2625,.3875),4); rq(ch9_poz_w[c(1,4),'dolni'],c(.09,.29),2); rq(ch9_poz_w[c(1,4),'horni'],c(.24,.50),2)
eq(ch9_t20_gof$chi2,ch9_t20_score[['z']]^2,1e-12); rq(ch9_t20_gof$chi2,6.667,3); stopifnot(chisq.test(c(31,21,16,12))$statistic==10.1)
rq(qchisq(.95,c(1,2,4,8)),c(3.84,5.99,9.49,15.51),2)
# Sections 6-7: independence, expected counts, residuals, Holm.
eq(ch9_stres_tab$e,matrix(c(35,35,65,65),2)); rq(ch9_stres_tab$chi2,2.198,3)
z <- ch9_zvl_tab; rq(z$e,matrix(c(18.82,27.37,18.82,17.37,25.26,17.37,18.82,27.37,18.82),3),2); rq(z$chi2,11.78,2); rq(z$p,.019,3); rq(z$V,.18,2); rq(z$V,.176,3); rq(qchisq(.95,4),9.49,2)
rq(z$radkove,matrix(c(.45,.38,.18,.33,.28,.36,.22,.35,.45),3),2); rq(z$radkove[,1],c(.455,.375,.182),3)
rq(z$pearson,matrix(c(1.43,.50,-2.03,.15,-.65,.63,-1.57,.12,1.43),3),2); rq(z$upravena,matrix(c(2.09,.82,-2.97,.22,-1.03,.91,-2.30,.20,2.09),3),2)
stopifnot(all(abs(z$upravena)>abs(z$pearson))); rq(colSums(ch9_zvl)/190,c(.34,.32,.34),2)
pz <- sort(ch9_zvl_padj); rq(pz[1:2],c(.0030,.0216),4); rq(.05/9,.0056,4); rq(.05/8,.0063,4)
stopifnot(sum(ch9_zvl_holm<.05)==1, ch9_zvl_holm[3,1]<.05); rq(ch9_zvl_holm[3,1],.027,3)
# Section 8: assumptions, Fisher.
rq(c(ch9_dst_bad$chi2,ch9_dst_bad$p),c(1.29,.26),2); rq(c(ch9_dst$chi2,ch9_dst$p),c(4.29,.038),c(2,3))
eq(ch9_pilot_tab$e,matrix(c(5.5,5.5,4.5,4.5),2)); rq(c(ch9_pilot_tab$chi2,ch9_pilot_tab$p,ch9_pilot_fisher$p),c(5.05,.025,.070),c(2,3,3))
rq(ch9_pilot_fisher$pobs,.0322,4); eq(ch9_pilot_fisher$a,1:10); eq(which(ch9_pilot_fisher$pr<=ch9_pilot_fisher$pobs*(1+1e-7)),c(1:3,8:10))
rq(ch9_stres_fisher$p,.18,2); rq(min(z$e),17.37,2)
# Section 9: effect sizes (Daniels via Field; aspirin via Howell).
d <- ch9_dan_eff; rq(d[c('riziko1','riziko2','rozdil')],c(.400,.171,.229),3); rq(ch9_dan_two[c('dolni','horni')]*100,c(11.9,33.0),1)
rq(d[c('rr','sance1','sance2','or')],c(2.34,.667,.206,3.23),c(2,3,3,2)); rq(1/d[c('rr','or')],c(.43,.31),2)
rq(c(d['chi2'],d['phi']),c(16.06,.25),2); stopifnot(d['p']<.001); eq(abs(ch9_dan_phi01),d['phi'],1e-12)
rq(ch9_dan_w[,'dolni'],c(.32,.11),2); rq(ch9_dan_w[,'horni'],c(.48,.25),2); rq(.400/.171,2.34,2); rq(100*(.400/.171-1),134,0)
rq(c(d['se_lrr'],d['rr_dolni'],d['rr_horni'],d['se_lor'],d['or_dolni'],d['or_horni']),c(.228,1.50,3.66,.300,1.80,5.82),c(3,2,2,3,2,2))
a <- ch9_asp_eff; rq(100*a[c('riziko1','riziko2','rozdil')],c(1.71,.94,.77),2); rq(a[c('rr','or','phi')],c(1.82,1.83,.034),c(2,2,3))
rq(1000*a[c('riziko1','riziko2')],c(17,9),0)
rq(sqrt(11.78/(190*2)),.18,2)
# Optional: Simpson (Howell's printed 28.8 % for women differs from 468/1727 = 27.1 %), kappa.
rq(c(ch9_berk_m,ch9_berk_z),c(.368,.271),3); eq(with(ch9_berk,sum(m_prijati+m_odmitnuti)),1866); eq(with(ch9_berk,sum(z_prijate+z_odmitnute)),1727)
rq(with(ch9_berk,m_prijati/(m_prijati+m_odmitnuti)),c(.63,.37,.33,.28,.06),2); rq(with(ch9_berk,z_prijate/(z_prijate+z_odmitnute)),c(.68,.34,.35,.24,.07),2)
rq(ch9_kappa,c(21,12.93,.47),c(0,2,2))
# Section 10: McNemar.
rq(ch9_pomoc_p,c(.583,.694,.111),3); rq(ch9_pomoc_mc['presne'],.077,3); eq(ch9_pomoc_mc['chi2'],4); rq(ch9_pomoc_mc['priblizne'],.046,3)
stopifnot(is.nan(suppressWarnings(mcnemar.test(matrix(c(40,0,0,32),2),correct=FALSE)$p.value)))
# Reporting example and summary values.
rq(100*c(.400,.171),c(40.0,17.1),1)
# Exercises.
rq(ch9_u02_w[c('dolni','horni')],c(.199,.425),3); rq(ch9_u02b_w[c('dolni','horni')],c(.246,.361),3)
rq(c(ch9_u02_w['horni']-ch9_u02_w['dolni'],ch9_u02b_w['horni']-ch9_u02b_w['dolni']),c(.226,.115),3)
rq(ch9_u03_wil0['horni'],.133,3); rq(ch9_u03_wald[c('dolni','horni')],c(-.037,.117),3); rq(ch9_u03_wil1[c('dolni','horni')],c(.007,.195),3)
u4 <- ch9_u04_two; rq(u4[c('p1','p2','rozdil','dolni','horni','spolecny','se0','z','p','chi2')],c(.265,.318,-.053,-.233,.128,.290,.094,-.56,.575,.315),c(3,3,3,3,3,3,3,2,3,3))
rq(ch9_table(ch9_u04)$e,matrix(c(14.23,12.77,34.77,31.23),2),2)
rq(c(ch9_u05_gof$chi2,ch9_u05_gof$p),c(1.68,.432),c(2,3))
u6 <- ch9_u06_gof; eq(u6$e,c(60,45,30,15)); rq(u6$prispevky,c(1.07,.56,.03,.27),2); rq(c(u6$chi2,u6$p),c(1.92,.589),c(2,3))
u7 <- ch9_u07_tab; rq(u7$e[1,],c(20.67,23,16.33),2); rq(c(u7$chi2,u7$p,u7$V),c(13.17,.010,.19),c(2,3,2))
rq(u7$radkove,matrix(c(.467,.367,.200,.233,.417,.500,.300,.217,.300),3),3); rq(u7$upravena,matrix(c(2.44,.44,-2.88,-2.93,.65,2.28,.59,-1.18,.59),3),2)
pu7 <- sort(2*pnorm(-abs(as.vector(u7$upravena)))); rq(pu7[1:4],c(.0034,.0039,.0147,.0228),4); rq(pu7[5:9],c(.236,.515,.554,.554,.657),3)
stopifnot(sum(ch9_u07_holm<.05)==2); rq(.05/7,.0071,4)
u10 <- ch9_u10_eff; rq(u10[c('riziko1','riziko2','rozdil')],c(.204,.105,.099),3); rq(u10[c('rr','sance1','sance2','or')],c(1.94,.257,.118,2.18),c(2,3,3,2))
rq(1/u10[c('rr','or')],c(.52,.46),2); rq(c(u10['chi2'],u10['p'],u10['phi']),c(5.38,.020,.13),c(2,3,2)); rq(ch9_table(ch9_u10)$e,matrix(c(12.63,28.37,80.37,180.63),2),2)
rq(u10[c('se_lrr','rr_dolni','rr_horni','se_lor','or_dolni','or_horni')],c(.287,1.11,3.41,.342,1.12,4.27),c(3,2,2,3,2,2))
rq(c(28/60,36/60,8/60),c(.467,.600,.133),3); rq(c(ch9_u11_mc['presne'],ch9_u11_mc['chi2'],ch9_u11_mc['priblizne']),c(.057,4.57,.033),c(3,2,3))
u12 <- ch9_u12_tab; rq(u12$e,matrix(c(3.76,4.24,4.24,4.76),2),2); rq(c(u12$chi2,u12$p,ch9_u12_fisher$p),c(4.74,.030,.057),c(2,3,3)); rq(ch9_u12_two[c('rozdil','dolni','horni')],c(.528,.057,.767),3)
# Exercise 9a: counts instead of percentages.
rq(chisq.test(matrix(c(80,20,60,40),2,byrow=TRUE),correct=FALSE)$statistic/chisq.test(matrix(c(8,2,9,6),2,byrow=TRUE),correct=FALSE)$statistic,8.6,1)
rq(min(suppressWarnings(chisq.test(matrix(c(8,2,9,6),2,byrow=TRUE)))$expected),3.2,1)
# Revision 2026-11-16 (R81): standard error of the difference, coverage, Holm table, signed phi, simulation, sign test, kappa figure.
rq(ch9_stres_two['se_wald'],.067,3); rq(c(.40-.309,.396-.30,.498-.40,.30-.219),c(.091,.096,.098,.081),3)
w <- ch9_stres_w; rq(c(.4-w['zeny','dolni'],w['muzi','horni']-.3,w['zeny','horni']-.4,.3-w['muzi','dolni']),c(.0906,.0958,.0980,.0811),4)
rq(c(sqrt((.4-w['zeny','dolni'])^2+(w['muzi','horni']-.3)^2),sqrt((w['zeny','horni']-.4)^2+(.3-w['muzi','dolni'])^2)),c(.132,.127),3)
# Exact coverage against an independent computation (prop.test intervals for Wilson, direct formula for Wald).
cov_ind <- function(n,p) { x <- 0:n; pr <- dbinom(x,n,p); ph <- x/n; se <- sqrt(ph*(1-ph)/n); z <- qnorm(.975)
  wl <- suppressWarnings(t(sapply(x,function(k) prop.test(k,n,correct=FALSE)$conf.int)))
  c(sum(pr[ph-z*se<=p & p<=ph+z*se]),sum(pr[wl[,1]-1e-12<=p & p<=wl[,2]+1e-12]),sum(pr[ph-z*se< -1e-12 | ph+z*se>1+1e-12 | x==0 | x==n])) }
for (n in c(10,20,50,100)) for (p in c(.05,.1,.25,.5)) eq(ch9_cover_at(n,p),cov_ind(n,p),1e-9)
rq(ch9_cover_at(20,.05)['wald'],.64,2); rq(ch9_cover_at(20,.10)['mimo'],.87,2); rq(min(ch9_cover_res[['10']][,'wilson']),.85,2)
rq(ch9_cover_at(10,.5)['mimo'],.11,2)
stopifnot(all(sapply(ch9_cover_res,function(m) abs(mean(m[,'wilson'])-.95)<.005)), all(sapply(ch9_cover_res,function(m) mean(m[,'wald'])<.94)))
# Holm table (text table 9.13): order, residuals, p-values, thresholds, decisions; p.adjust agrees.
h <- ch9_zvl_holm_tab; rq(h$reziduum,c(-2.97,-2.30,2.09,2.09,-1.03,.91,.82,.22,.20),2)
rq(h$p,c(.0030,.0216,.0370,.0370,.3023,.3651,.4150,.8279,.8449),4); rq(h$hranice,c(.0056,.0063,.0071,.0083,.0100,.0125,.0167,.0250,.0500),4)
stopifnot(identical(h$zamitame,c(TRUE,rep(FALSE,8))), sum(p.adjust(ch9_zvl_padj,'holm')<.05)==1, sum(abs(h$reziduum)>1.96)==4)
stopifnot(h$radek[1]=='senioři (60+)', h$sloupec[1]=='řešení problému', h$radek[2]=='mladí (18–30)', h$sloupec[2]=='sociální opora')
# z squared and chi-square with one degree of freedom.
rq(qchisq(.95,1),3.84,2); eq(qchisq(.95,1),qnorm(.975)^2,1e-12); rq(100*mean(ch9_z2_sim>qchisq(.95,1)),5.4,1)
stopifnot(ks.test(ch9_z2_sim,'pchisq',1)$p.value>.01)
# Fisher figure: ten tables, probabilities and the tables at most as probable as the observed one.
f <- ch9_pilot_fisher; stopifnot(identical(f$a,1:10)); rq(f$pr,c(.0001,.0027,.0322,.1500,.3151,.3151,.1500,.0322,.0027,.0001),4)
stopifnot(identical(which(f$pr<=f$pobs*(1+1e-7)),c(1L,2L,3L,8L,9L,10L))); rq(2*(.0322+.0027+.0001),.070,3)
eq(f$p,fisher.test(ch9_pilot)$p.value,1e-12)
# Monte Carlo p-value: share quoted in the text; possible values; agreement with R's own simulation and with the exact test.
rq(100*ch9_pilot_mc_p,6.8,1); rq(sort(unique(round(ch9_pilot_mc,2))),c(.20,1.82,5.05,9.90),2)
rq(sapply(1:5,function(a) ch9_table(matrix(c(a,10-a,11-a,a-1),2,byrow=TRUE))$chi2),c(16.36,9.90,5.05,1.82,.20),2)
rq(as.numeric(table(round(ch9_pilot_mc,2)))/1e4,c(.633,.299,.063,.005),3)
set.seed(1); stopifnot(abs(chisq.test(ch9_pilot,simulate.p.value=TRUE,B=20000)$p.value-ch9_pilot_fisher$p)<.01, abs(ch9_pilot_mc_p-ch9_pilot_fisher$p)<.01)
# Signed phi: formula from the counts, its square, swapped rows, the product of the two differences of proportions, cor of 0/1 codes.
eq(ch9_dan_phi_s,ch9_dan_phi01,1e-12); eq(ch9_dan_phi_s^2,ch9_dan_eff['chi2']/257,1e-12); eq(ch9_dan_phi_swap,-ch9_dan_phi_s,1e-12)
eq(56*97-84*20,3752); rq(sqrt(140*117*76*181),15011,0); rq(c(56/76,84/181,ch9_dan_coldiff),c(.737,.464,.273),3)
rq(.229*.273,.0625,4); eq(ch9_dan_eff['rozdil']*ch9_dan_coldiff,ch9_dan_phi_s^2,1e-12); rq(ch9_phi_signed(ch9_u10[2:1,]),-.13,2)
stopifnot(abs(chisq.test(diag(c(30,40)),correct=FALSE)$statistic-70)<1e-9) # the maximum of chi-square in a 2 x 2 table is n
rq(100*c(56,84)/140,c(40.0,60.0),1); rq(100*c(20,97)/117,c(17.1,82.9),1); rq(100*c(76,181)/257,c(29.6,70.4),1)
# APA table (text table 9.14): row percentages.
rq(100*ch9_zvl_tab$radkove,matrix(c(45.5,37.5,18.2,32.7,27.5,36.4,21.8,35.0,45.5),3),1); rq(100*colSums(ch9_zvl)/190,c(34.2,31.6,34.2),1)
# Sign test: chapter 8 differences and exercise 13, against binom.test.
stopifnot(all(ch9_spanek_sign[c('kladne','zaporne','n')]==c(11,1,12))); eq(ch9_spanek_sign['p'],binom.test(11,12,.5)$p.value,1e-12); rq(ch9_spanek_sign['p'],.006,3)
eq(mean(ch9_spanek_d),3.5); rq(t.test(ch9_spanek_d)$p.value,.0004,4)
stopifnot(all(ch9_u13_sign[c('kladne','zaporne','n')]==c(10,2,12)), identical(which(ch9_u13$pred<ch9_u13$po),c(5L,11L)), identical(which(ch9_u13$pred==ch9_u13$po),c(3L,7L,13L)))
eq(ch9_u13_sign['p'],binom.test(10,12,.5)$p.value,1e-12); rq(ch9_u13_sign['p'],.039,3); eq(ch9_u13$pred[c(10,1)]-ch9_u13$po[c(10,1)],c(3,1))
eq(ch9_pomoc_mc['presne'],binom.test(4,16,.5)$p.value,1e-12) # the exact McNemar test is the sign test of the discordant pairs
# Kappa figure: expected counts of all nine cells and the margins (rows Judge II, columns Judge I).
rq(ch9_kappa_e,matrix(c(10.67,3.20,2.13,4.00,1.20,.80,5.33,1.60,1.07),3),2); eq(rowSums(ch9_kappa_t),c(20,6,4)); eq(colSums(ch9_kappa_t),c(16,6,8))
eq(ch9_kappa_e,suppressWarnings(chisq.test(ch9_kappa_t))$expected,1e-12)
stopifnot(all(file.exists(file.path('assets/chapter-09/plots',paste0(c('pokryti-wald-wilson','newcombe-konstrukce','z2-chi2','fisher-tabulky','monte-carlo','kappa-shody'),'.svg')))))
cat('Chapter 9 checks passed.\n')
