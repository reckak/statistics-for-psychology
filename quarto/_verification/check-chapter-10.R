# Independent known-value checks for chapter 10: examples, figures, exercises and optional extensions.
# The chapter procedures are compared with base R (cor, cor.test, t.test, rank) and every number quoted
# in the text and solutions is checked at the precision shown. Bootstrap coverage and the permutation
# error rate are rerun only with CH10_COVERAGE=1 (scripts/kapitola_10-pokryti.R, about 8 minutes).
if (.Platform$OS.type=='windows') Sys.setlocale('LC_CTYPE','.UTF-8')
Sys.setenv(CH10_NOFIG='1'); source('scripts/kapitola_10.R',encoding='UTF-8')
eq <- function(actual,expected,tol=1e-10) stopifnot(isTRUE(all.equal(as.numeric(actual),as.numeric(expected),tolerance=tol)))
rq <- function(actual,expected,d) stopifnot(all(abs(as.numeric(actual)-as.numeric(expected))<=.5*10^(-d)+1e-9))
kt <- function(x,y) cor(x,y,method='kendall')
# Procedures against base R.
for (d in list(ch10_m6[,2:3],ch10_uz[,2:3],ch10_ss[,2:3],ch10_t6[,2:3],ch10_u12[,2:3],ch10_u16[,2:3],ch10_u06[,2:3],ch10_u08[,2:3])) {
  x <- d[[1]]; y <- d[[2]]
  eq(ch10_r(x,y),cor(x,y)); eq(ch10_cov(x,y),cov(x,y)); eq(ch10_rs(x,y),cor(x,y,method='spearman')); eq(ch10_taub(x,y),kt(x,y))
}
eq(ch10_uz_inf[c('t','p')],c(cor.test(ch10_uz$uzkost,ch10_uz$vykon)$statistic,cor.test(ch10_uz$uzkost,ch10_uz$vykon)$p.value))
eq(ch10_uz_inf[c('dolni','horni')],cor.test(ch10_uz$uzkost,ch10_uz$vykon)$conf.int)
eq(abs(ch10_rpb_t),abs(cor.test(ch10_rpb_x,ch10_rpb_y)$statistic)); eq(ch10_rpb,cor(ch10_rpb_x,ch10_rpb_y))
eq(ch10_phi,(40*70-60*30)/sqrt(100*100*70*130))
# 10.1 and the optional extension: paired sleep data of chapter 8.
rq(ch10_k8_r,.95,2); rq(ch10_k8_r,.948,3); rq(ch10_k8_sd,c(7.34,6.42,2.39),2); eq(ch10_k8_sd_vzorec,ch10_k8_sd[3]); rq(ch10_k8_sd_nez,9.75,2)
rq(mean(ch10_k8$bezny-ch10_k8$kratky),3.5,1); rq(sqrt(4+36-24),4,0)
# 10.2 figures.
rq(ch10_uz_r,-.52,2); rq(ch10_forms_r['r',],c(.85,-.84,.87,-.15,.54,.88),2); rq(ch10_forms_r['rs',],c(.87,-.87,.88,-.19,-.12,.71),2)
rq(ch10_same_r,rep(.6,4),3)
# 10.3-10.4 hand example.
stopifnot(mean(ch10_m6$uzkost)==23,mean(ch10_m6$vykon)==19,sum(ch10_m6_dx*ch10_m6_dy)==-138)
eq(ch10_m6_dx*ch10_m6_dy,c(-33,-30,6,2,-28,-55)); eq(ch10_m6_cov,-27.6); rq(c(sd(ch10_m6$uzkost),sd(ch10_m6$vykon)),c(8.075,4.336),3)
rq(ch10_m6_zx,c(-1.362,-.619,-.372,.124,.867,1.362),3); rq(ch10_m6_zy,c(.692,1.384,-.461,.461,-.923,-1.153),3)
rq(ch10_m6_zx*ch10_m6_zy,c(-.943,-.857,.171,.057,-.800,-1.571),3); rq(sum(ch10_m6_zx*ch10_m6_zy),-3.942,3)
rq(ch10_m6_r,-.788,3); eq(ch10_cov(ch10_m6$uzkost,ch10_m6$vykon*100/30),-92); eq(ch10_r(50-ch10_m6$uzkost,ch10_m6$vykon),-ch10_m6_r)
# 10.5 Spearman.
eq(rank(ch10_t6$stres),c(1,2.5,2.5,4,5,6)); eq(rank(ch10_t6$spanek),c(5.5,5.5,3,4,1.5,1.5)); rq(ch10_t6_rs,-.851,3)
rq(ch10_ss_rs,-.48,2); rq(ch10_ss_rs,-.480,3); eq(rank(ch10_ss$stres)[1],3)
rq(c(ch10_rt_r,ch10_rt_rs),c(-.85,-.91),2)
# 10.6 Kendall.
eq(ch10_m6_tau[c('par','nc','nd')],c(15,2,13)); rq(ch10_m6_tau['tau_a'],-.733,3); rq(13/15,.867,3); rq(2/15,.133,3)
eq(ch10_t6_tau[c('nc','nd','tx','ty')],c(1,11,1,2)); rq(ch10_t6_tau['tau_a'],-.667,3); rq(ch10_t6_tau['tau_b'],-.741,3); eq(-10/sqrt(182),ch10_t6_tau[['tau_b']])
eq(ch10_ss_tau[c('nc','nd','tx','ty','par')],c(93,239,27,80,435)); rq(ch10_ss_tau['tau_b'],-.38,2); eq(-146/sqrt(408*355),ch10_ss_tau[['tau_b']])
rq(c(ch10_ss_r,ch10_ss_rs,ch10_ss_tau[['tau_b']]),c(-.56,-.48,-.38),2); rq(c(ch10_uz_r,ch10_uz_rs,ch10_uz_tb),c(-.52,-.55,-.42),2)
# 10.8 Pearson inference.
rq(ch10_sim_sum[c('q025','q975'),'rho0'],c(-.45,.43),2); rq(ch10_sim_sum[c('q025','q975'),'rho08'],c(.57,.92),2)
rq(ch10_uz_r*sqrt(38),-3.226,3); rq(sqrt(1-ch10_uz_r^2),.852,3); rq(ch10_uz_inf['t'],-3.79,2); rq(ch10_uz_inf['t'],-3.786,3); rq(ch10_uz_inf['p'],.0005,4)
rq(ch10_uz_inf[c('zr','se','z_dolni','z_horni')],c(-.581,.164,-.903,-.259),3); rq(ch10_uz_inf[c('dolni','horni')],c(-.72,-.25),2); rq(ch10_uz_inf[c('dolni','horni')],c(-.718,-.253),3)
rq(ch10_uz_400['t'],-12.1,1); rq(ch10_u10['n50','p'],.30,2); stopifnot(ch10_u10['n1000','p']<.001)
rq(ch10_rel[c('dolni','horni')],c(.70,.89),2); rq(ch10_val[c('dolni','horni')],c(.19,.54),2)
# 10.9 permutation tests.
eq(ch10_t6_p,c(48,48)/720); rq(ch10_t6_p,.067,3)
stopifnot(sum(abs(ch10_ss_1999$pm[,2])>=abs(ch10_ss_tau[['tau_b']])-1e-12)==9,sum(abs(ch10_ss_1999$pm[,1])>=abs(ch10_ss_rs)-1e-12)==13)
eq(c(ch10_ss_1999$tb_p,ch10_ss_1999$rs_p),c(.005,.007)); eq(c(ch10_ss_9999$tb_p,ch10_ss_9999$rs_p),c(.0048,.006))
# 10.10 bootstrap and optional BCa.
rq(ch10_ss_1999$rs_ci,c(-.73,-.13),2); rq(ch10_ss_1999$tb_ci,c(-.61,-.10),2); rq(ch10_ss_1999$tb_ci,c(-.610,-.096),3)
rq(ch10_ss_9999$rs_ci,c(-.74,-.13),2); rq(ch10_ss_9999$tb_ci,c(-.63,-.10),2); stopifnot(all(ch10_ss_1999$na==0))
rq(ch10_bca_tb[c('z0','a')],c(.050,-.005),3); rq(100*ch10_bca_tb[c('alfa1','alfa2')],c(3.0,97.9),1)
rq(ch10_bca_tb[c('dolni','horni')],c(-.60,-.09),2); rq(ch10_bca_rs[c('dolni','horni')],c(-.72,-.11),2)
stopifnot(sum(ch10_ss_1999$bt[,2]<ch10_ss_tau[['tau_b']])==1039); rq(1039/1999,.520,3)
# 10.11 factors.
rq(ch10_out_r,c(.01,-.49),2); rq(ch10_rr_r,c(.56,.37,.72),2); stopifnot(sum(ch10_rr$test>=ch10_rr_cut)==62)
rq(ch10_cg_r,c(.66,-.20,.09),2); rq(ch10_rat_r,.97,2); eq(colMeans(ch10_rat[,2:3]),c(13.5,17.5)); stopifnot(all(ch10_rat$B-ch10_rat$A>=3),all(ch10_rat$B-ch10_rat$A<=5))
# 10.12 correlation matrix.
rq(ch10_mat_r[lower.tri(ch10_mat_r)],c(-.62,.57,-.34,-.41,.34,-.33),2)
eq(ch10_mat_n[upper.tri(ch10_mat_n)],c(107,116,111,103,99,106)); stopifnot(nrow(ch10_mat_data)==120)
# 10.13 dichotomous variables and optional d.
rq(ch10_rpb,-.35,2); rq(ch10_rpb,-.347,3); rq(ch10_rpb_t,2.34,2); stopifnot(ch10_rpb_df==40); rq(ch10_phi,.105,3)
rq(ch10_r_to_d(.347355822,30,12),.80,2); rq(40*(1/30+1/12),4.67,2); rq(.8/sqrt(.64+4.6667),.35,2)
# Exercises.
eq(ch10_u03_cov,-4.25); rq(ch10_u03_r,-.922,3); rq(c(sd(ch10_u03$spanek),sd(ch10_u03$chyby)),c(1.581,2.915),3)
eq(ch10_cov(ch10_u03$spanek*60,ch10_u03$chyby),-255); eq(ch10_r(ch10_u03$spanek,10-ch10_u03$chyby),-ch10_u03_r)
rq(ch10_u05_rs,.821,3); rq(ch10_u06_rs,.798,3); rq(ch10_u06_r,.705,3); eq(rank(ch10_u06$zajem),c(2,5,5,7.5,3,1,5,7.5))
eq(ch10_u07_tau[c('nc','nd','tau_a')],c(8,2,.6)); eq(ch10_u08_tau[c('nc','nd','tx','ty')],c(1,10,2,2)); eq(ch10_u08_tau[['tau_b']],-9/13); rq(ch10_u08_tau['tau_b'],-.692,3)
rq(ch10_u09[c('t','p')],c(2.57,.013),c(2,3)); rq(ch10_u09[c('zr','se','z_dolni','z_horni')],c(.332,.132,.072,.591),3); rq(ch10_u09[c('dolni','horni')],c(.07,.53),2)
rq(ch10_u10['n50',c('t','p','dolni','horni')],c(1.05,.30,-.13,.41),2); rq(ch10_u10['n1000',c('t','dolni','horni')],c(4.79,.09,.21),2)
rq(ch10_u10['retest',c('dolni','horni')],c(.62,.88),2)
eq(as.vector(ch10_u11_dist),c(1,3,5,6,5,3,1)); rq(2/24,.083,3); rq(8/24,.333,3)
rq(ch10_u12_rs,-.431,3); rq(ch10_u12_tau['tau_b'],-.339,3); eq(ch10_u12_tau[c('nc','nd','tx','ty')],c(120,257,23,39))
eq(c(ch10_u12_res$rs_p,ch10_u12_res$tb_p),c(41,31)/2000); rq(ch10_u12_res$rs_ci,c(-.71,-.10),2); rq(ch10_u12_res$tb_ci,c(-.59,-.08),2)
rq(c(ch10_u16_r,ch10_u16_bez[['r']]),c(.04,.47),2); rq(ch10_u16_inf[c('dolni','horni','p')],c(-.28,.34,.82),2)
rq(ch10_u16_inf_bez[c('dolni','horni')],c(.18,.68),2); rq(ch10_u16_inf_bez[c('t','p')],c(3.21,.003),c(2,3)); rq(c(ch10_u16_rs,ch10_u16_bez[['rs']]),c(.28,.34),2)
stopifnot((900-mean(ch10_u16$minuty))/sd(ch10_u16$minuty)>5)
rq(ch10_u18[c('z1','z2','se')],c(.436,.590,.201),3); rq(ch10_u18['z'],-.77,2); rq(ch10_u18['p'],.44,2)
# Bootstrap coverage and permutation error (text: n = 30 about 94-96 %, n = 10 96-97 % with widths 0.8-1.1).
if (nzchar(Sys.getenv('CH10_COVERAGE'))) source('scripts/kapitola_10-pokryti.R')
cov_file <- 'tmp/chapter-10-pokryti.csv'
if (file.exists(cov_file)) { v <- read.csv(cov_file); cv <- subset(v,ukol=='pokryti')
  stopifnot(all(cv$rs[cv$n==30]>=.94&cv$rs[cv$n==30]<=.96),all(cv$tau_b[cv$n==30]>=.94&cv$tau_b[cv$n==30]<=.96))
  stopifnot(all(c(cv$rs[cv$n==10],cv$tau_b[cv$n==10])>=.96&c(cv$rs[cv$n==10],cv$tau_b[cv$n==10])<=.975))
  stopifnot(all(c(cv$sirka_rs[cv$n==10],cv$sirka_tau_b[cv$n==10])>=.8&c(cv$sirka_rs[cv$n==10],cv$sirka_tau_b[cv$n==10])<=1.15))
} else message('Coverage table not found; run with CH10_COVERAGE=1 to check the simulation quoted in section 10.10.')
cat('Chapter 10 checks passed.\n')
