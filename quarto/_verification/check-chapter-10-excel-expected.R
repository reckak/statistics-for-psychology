# Expected values for check-chapter-10-excel.ps1, computed in base R independently of Excel.
# Usage: Rscript --vanilla quarto/_verification/check-chapter-10-excel-expected.R
# Writes quarto/_verification/check-chapter-10-excel.json (UTF-8). Resampling scenarios use the same
# fixed indices as the workbook (scripts/kapitola_10.R).
if (.Platform$OS.type=='windows') Sys.setlocale('LC_CTYPE','.UTF-8')
Sys.setenv(CH10_NOFIG='1'); source('scripts/kapitola_10.R',encoding='UTF-8'); options(OutDec='.')
taub <- function(x,y) cor(x,y,method='kendall')            # base R, independent of ch10_tau
rs <- function(x,y) cor(rank(x),rank(y))
pt_ <- function(r,n) { t <- r*sqrt(n-2)/sqrt(1-r^2); c(t=t,p=2*pt(-abs(t),n-2)) }
fz <- function(r,n) tanh(atanh(r)+c(-1,1)*qnorm(.975)/sqrt(n-3))
x <- ch10_uz$uzkost; y <- ch10_uz$vykon; ru <- cor(x,y)
s <- ch10_ss; bt <- ch10_boot_idx[1:1999,]; pm <- ch10_perm_idx[1:1999,]
resamp <- function(x,y) {
  b <- t(apply(bt,1,function(i) c(rs(x[i],y[i]),taub(x[i],y[i])))); p <- t(apply(pm,1,function(i) c(rs(x,y[i]),taub(x,y[i]))))
  q <- function(v,a) quantile(v,a,type=7,names=FALSE,na.rm=TRUE)
  c(rs=rs(x,y),tb=taub(x,y),prs=(sum(abs(p[,1])>=abs(rs(x,y))-1e-12)+1)/2000,ptb=(sum(abs(p[,2])>=abs(taub(x,y))-1e-12)+1)/2000,
    rslo=q(b[,1],.025),rshi=q(b[,1],.975),tblo=q(b[,2],.025),tbhi=q(b[,2],.975))
}
exact6 <- function(x,y) { p <- ch10_perm6; v <- t(apply(p,1,function(i) c(rs(x,y[i]),taub(x,y[i]))))
  c(rs=rs(x,y),tb=taub(x,y),prs=mean(abs(v[,1])>=abs(rs(x,y))-1e-12),ptb=mean(abs(v[,2])>=abs(taub(x,y))-1e-12)) }
d0 <- resamp(s$stres,s$spanek); d12 <- resamp(ch10_u12$opora,ch10_u12$osamelost)
e0 <- exact6(ch10_t6$stres,ch10_t6$spanek); e8 <- exact6(ch10_u08$stres,ch10_u08$spanek)
k8 <- ch10_k8; dd <- k8$bezny-k8$kratky; rk <- cor(k8$bezny,k8$kratky)
g <- ch10_rpb_x; sc <- ch10_rpb_y; rp <- cor(g,sc); tt <- t.test(sc[g==0],sc[g==1],var.equal=TRUE)
jk <- sapply(1:30,function(i) taub(s$stres[-i],s$spanek[-i])); dj <- mean(jk)-jk; a <- sum(dj^3)/(6*sum(dj^2)^1.5)
bb <- apply(bt,1,function(i) taub(s$stres[i],s$spanek[i])); z0 <- qnorm(mean(bb<taub(s$stres,s$spanek)))
al <- pnorm(z0+(z0+qnorm(c(.025,.975)))/(1-a*(z0+qnorm(c(.025,.975)))))
u03 <- ch10_u03; u06 <- ch10_u06; u07 <- ch10_u07; u08 <- ch10_u08
c1 <- function(sheet,cell,value,tol=1e-9) list(sheet=sheet,cell=cell,value=unname(value),tol=tol)
stored <- list(
  c1('Kovariance','L6',cov(ch10_m6$uzkost,ch10_m6$vykon)),c1('Kovariance','L7',cov(ch10_m6$uzkost,ch10_m6$vykon)),
  c1('Kovariance','L10',cor(ch10_m6$uzkost,ch10_m6$vykon)),c1('Kovariance','L11',cor(ch10_m6$uzkost,ch10_m6$vykon)),c1('Kovariance','L12',cor(ch10_m6$uzkost,ch10_m6$vykon)),
  c1('Pearson','B5',ru),c1('Pearson','B7',pt_(ru,40)[['t']]),c1('Pearson','B9',cor.test(x,y)$p.value),
  c1('Pearson','B16',cor.test(x,y)$conf.int[1]),c1('Pearson','B17',cor.test(x,y)$conf.int[2]),
  c1('Spearman','H3',cor(s$stres,s$spanek,method='spearman')),c1('Spearman','H4',cor(s$stres,s$spanek)),
  c1('Kendall','N3',1),c1('Kendall','N4',11),c1('Kendall','N5',1),c1('Kendall','N6',2),c1('Kendall','N8',taub(ch10_t6$stres,ch10_t6$spanek)),
  c1('Permutace','B2',d0[['rs']]),c1('Permutace','B6',d0[['tb']]),c1('Permutace','B9',d0[['prs']]),c1('Permutace','B10',d0[['ptb']]),
  c1('Bootstrap','B6',d0[['rslo']]),c1('Bootstrap','B7',d0[['rshi']]),c1('Bootstrap','B8',d0[['tblo']]),c1('Bootstrap','B9',d0[['tbhi']]),c1('Bootstrap','B10',0),
  c1('Bootstrap','I2',ch10_ss_9999$rs_ci[1]),c1('Bootstrap','I5',ch10_ss_9999$tb_ci[2]),c1('Bootstrap','I7',ch10_ss_9999$tb_p),
  c1('Perm_presna','W2',e0[['rs']]),c1('Perm_presna','W6',e0[['tb']]),c1('Perm_presna','W9',e0[['prs']]),c1('Perm_presna','W10',e0[['ptb']]),
  c1('Parova_korelace','B2',rk),c1('Parova_korelace','B5',sd(dd)),c1('Parova_korelace','B6',sd(dd)),c1('Parova_korelace','B7',sqrt(var(k8$bezny)+var(k8$kratky))),
  c1('Rpb','B2',rp),c1('Rpb','B4',tt$statistic),c1('Rpb','B5',tt$p.value),
  c1('Rpb','B10',unname(diff(rev(tapply(sc,g,mean)))/sqrt(((29*var(sc[g==0])+11*var(sc[g==1]))/40)))),
  c1('BCa','I3',a),c1('BCa','I5',z0),c1('BCa','I8',quantile(bb,al[1],type=7,names=FALSE)),c1('BCa','I9',quantile(bb,al[2],type=7,names=FALSE)),
  c1('Dve_korelace','B11',2*pnorm(-abs((atanh(.41)-atanh(.53))/sqrt(1/56+1/44)))))
sc_ <- function(name,inputs,clear,checks) list(name=name,inputs=inputs,clear=clear,checks=checks)
inp <- function(sheet,cell,values) list(sheet=sheet,cell=cell,values=values)
scen <- list(
  sc_('Cviceni 3: Kovariance s U03',list(inp('Kovariance','B2',as.matrix(u03[,2:3]))),list('Kovariance!B7:C11'),
      list(c1('Kovariance','L6',cov(u03$spanek,u03$chyby)),c1('Kovariance','L12',cor(u03$spanek,u03$chyby)))),
  sc_('Cviceni 9: Pearson ze souhrnu',list(inp('Pearson','B2',matrix(c(60,.32),2))),list(),
      list(c1('Pearson','B7',pt_(.32,60)[['t']]),c1('Pearson','B9',pt_(.32,60)[['p']]),c1('Pearson','B16',fz(.32,60)[1]),c1('Pearson','B17',fz(.32,60)[2]))),
  sc_('Cviceni 6: Spearman s U06',list(inp('Spearman','B2',as.matrix(u06[,2:3]))),list('Spearman!B10:C41'),
      list(c1('Spearman','H3',cor(u06$zajem,u06$hodiny,method='spearman')),c1('Spearman','H4',cor(u06$zajem,u06$hodiny)))),
  sc_('Cviceni 7: Kendall s U07',list(inp('Kendall','B2',as.matrix(u07[,2:3]))),list('Kendall!B7:C7'),
      list(c1('Kendall','N2',10),c1('Kendall','N3',8),c1('Kendall','N4',2),c1('Kendall','N7',.6))),
  sc_('Cviceni 8: Kendall s U08',list(inp('Kendall','B2',as.matrix(u08[,2:3]))),list(),
      list(c1('Kendall','N3',1),c1('Kendall','N4',10),c1('Kendall','N5',2),c1('Kendall','N6',2),c1('Kendall','N7',-.6),c1('Kendall','N8',taub(u08$stres,u08$spanek)))),
  sc_('Cviceni 8: presna permutace s U08',list(inp('Perm_presna','B2',as.matrix(u08[,2:3]))),list(),
      list(c1('Perm_presna','W6',e8[['tb']]),c1('Perm_presna','W9',e8[['prs']]),c1('Perm_presna','W10',e8[['ptb']]))),
  sc_('Cviceni 12 a 13: prevzorkovani s U12',list(inp('Prevzorkovani_data','B2',as.matrix(ch10_u12[,2:3]))),list(),
      list(c1('Permutace','B2',d12[['rs']]),c1('Permutace','B6',d12[['tb']]),c1('Permutace','B9',d12[['prs']]),c1('Permutace','B10',d12[['ptb']]),
           c1('Bootstrap','B6',d12[['rslo']]),c1('Bootstrap','B7',d12[['rshi']]),c1('Bootstrap','B8',d12[['tblo']]),c1('Bootstrap','B9',d12[['tbhi']]),
           c1('Bootstrap','I2',ch10_ss_9999$rs_ci[1]))))
# Czech formulas quoted in the text and solutions, evaluated in a scratch cell of the given sheet.
f_ <- function(sheet,formula,value) list(sheet=sheet,formula=formula,value=unname(value),tol=1e-9)
formulas <- list(
  f_('Pearson','=CORREL(Uzkost!B2:B41;Uzkost!C2:C41)',ru),
  f_('Pearson','=T.DIST.2T(2,572;58)',2*pt(-2.572,58)),
  f_('Pearson','=FISHER(0,32)',atanh(.32)),
  f_('Spearman','=RANK.AVG(B2;$B$2:$B$41;1)',rank(s$stres)[1]),
  f_('Spearman','=CORREL(D2:D41;E2:E41)',cor(s$stres,s$spanek,method='spearman')),
  f_('Kendall','=SIGN(INDEX($B$2:$B$7;E2)-INDEX($B$2:$B$7;F2))',sign(ch10_t6$stres[1]-ch10_t6$stres[2])),
  f_('Bootstrap','=PERCENTIL.INC(F13:F2011;0,025)',d0[['tblo']]),
  f_('Bootstrap','=PERCENTIL.INC(F13:F2011;0,975)',d0[['tbhi']]),
  f_('U05','=CORREL(B2:B8;C2:C8)',cor(ch10_u05$A,ch10_u05$B)))
num <- function(v) if (is.character(v)) sprintf('"%s"',gsub('"','\\\\"',v)) else formatC(v,digits=17,format='g')
js <- function(o) {
  if (is.list(o)&&!is.null(names(o))) return(paste0('{',paste(sprintf('"%s":%s',names(o),sapply(o,js)),collapse=','),'}'))
  if (is.list(o)) return(paste0('[',paste(sapply(o,js),collapse=','),']'))
  if (is.matrix(o)) return(paste0('[',paste(apply(o,1,function(r) paste0('[',paste(sapply(r,num),collapse=','),']')),collapse=','),']'))
  if (length(o)>1) return(paste0('[',paste(sapply(o,num),collapse=','),']'))
  num(o)
}
writeLines(js(list(stored=stored,scenarios=scen,formulas=formulas)),'quarto/_verification/check-chapter-10-excel.json',useBytes=FALSE)
cat('Wrote',length(stored),'stored checks,',length(scen),'scenarios,',length(formulas),'formulas\n')
