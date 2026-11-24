# Helper graphs for the Excel exercises of the chapter 9 presentation
# (presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_cviceni.xlsx, sheets U1 to U5).
# Inputs are read from the workbook, so the graphs follow its data. Needs the readxl package.
# Run from the project root: Rscript scripts/kapitola_09-prezentace-cviceni-grafy.R
# Output: presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_cviceni_grafy.pdf, one page per sheet (16:9).
suppressPackageStartupMessages(library(readxl))
wb <- 'presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_cviceni.xlsx'
out_file <- 'presentations/kapitola_09/kapitola_09_podily_a_kategorialni_data_cviceni_grafy.pdf'
old_options <- options(OutDec=',')

cells <- function(sheet,range) {
  x <- read_excel(wb,sheet=sheet,range=range,col_names=FALSE,.name_repair='minimal')
  as.numeric(unlist(t(as.matrix(x)),use.names=FALSE))
}
u1 <- matrix(cells('U1_podil','D4:E6'),ncol=2,byrow=TRUE,dimnames=list(c('x','n','pi0'),c('maly','velky')))
u2 <- matrix(cells('U2_dva_podily','D4:E5'),ncol=2,byrow=TRUE,dimnames=list(c('s','bez'),c('x','n')))
u3 <- matrix(cells('U3_dobra_shoda','D4:E7'),ncol=2,byrow=TRUE,dimnames=list(paste0(1:4,'. ročník'),c('f','pi0')))
u4 <- matrix(cells('U4_tabulka','D4:F6'),ncol=3,byrow=TRUE,dimnames=list(c('1. ročník','3. ročník','5. ročník'),c('studium','finance','vztahy')))
u5 <- matrix(cells('U5_parova_data','D4:E5'),ncol=2,byrow=TRUE,dimnames=list(c('pred_ne','pred_ano'),c('po_ne','po_ano')))
stopifnot(!anyNA(c(u1,u2,u3,u4,u5)),abs(sum(u3[,'pi0'])-1)<1e-9,sum(u4)==200,sum(u5)==80)

# Chapter palette (scripts/kapitola_09.R) ------------------------------------------
c_blue <- '#245D78'; c_orange <- '#B54E24'; c_fill <- '#B8DDE8'; c_gray <- '#4D5A63'; c_pale <- '#E1E8EB'
c_ink <- '#223744'; c_mute <- '#A9BAC3'
num <- function(x,digits=2) sub('^-','−',formatC(x+sign(x)*1e-9,format='f',digits=digits,decimal.mark=','))
pval <- function(p) if(p<.001) '< 0,001' else num(p,3)
ci_txt <- function(ci,digits=3) paste0('(',num(ci[1],digits),'; ',num(ci[2],digits),')')

# Wald interval (computed by students), Wilson and Newcombe intervals (given for comparison) and the pooled test.
wald <- function(x,n,z=qnorm(.975)) { p <- x/n; h <- z*sqrt(p*(1-p)/n); c(p=p,lo=p-h,hi=p+h) }
wald2 <- function(x1,n1,x2,n2,z=qnorm(.975)) { p1 <- x1/n1; p2 <- x2/n2; s <- sqrt(p1*(1-p1)/n1+p2*(1-p2)/n2); d <- p1-p2; c(d=d,se=s,lo=d-z*s,hi=d+z*s) }
wilson <- function(x,n,z=qnorm(.975)) {
  p <- x/n; mid <- (p+z^2/(2*n))/(1+z^2/n); half <- z/(1+z^2/n)*sqrt(p*(1-p)/n+z^2/(4*n^2))
  c(p=p,lo=mid-half,hi=mid+half)
}
newcombe <- function(x1,n1,x2,n2) {
  a <- wilson(x1,n1); b <- wilson(x2,n2); d <- unname(a['p']-b['p'])
  c(d=d,lo=unname(d-sqrt((a['p']-a['lo'])^2+(b['hi']-b['p'])^2)),hi=unname(d+sqrt((a['hi']-a['p'])^2+(b['p']-b['lo'])^2)))
}
pooled <- function(x1,n1,x2,n2) {
  p <- (x1+x2)/(n1+n2); se <- sqrt(p*(1-p)*(1/n1+1/n2)); z <- (x1/n1-x2/n2)/se
  list(p=p,se=se,z=z,pv=2*pnorm(-abs(z)))
}

# Page frame: graphs on the left, explanatory panel on the right -------------------
frame <- function(widths) { layout(matrix(seq_along(widths),1),widths=widths); par(las=1,col.axis=c_ink,col.lab=c_ink,fg=c_ink,cex=1.05,mgp=c(2.9,.7,0)) }
heading <- function(title,subtitle=NULL) {
  title(title,line=2.4,adj=0,cex.main=1.12,col.main=c_ink)
  if(!is.null(subtitle)) mtext(subtitle,side=3,line=.9,adj=0,cex=.88,col=c_gray)
}
panel <- function(items) {
  par(mar=c(4.6,.6,4.6,.6)); plot.new(); plot.window(c(0,1),c(0,1)); y <- .98
  for(it in items) {
    if(is.null(it$text)) { y <- y-.035; next }
    nl <- length(strsplit(it$text,'\n')[[1]])
    text(0,y,it$text,adj=c(0,1),cex=if(isTRUE(it$head)) 1 else .92,font=if(isTRUE(it$head)) 2 else 1,col=if(is.null(it$col)) c_ink else it$col)
    y <- y-.047*nl-.02
  }
}
H <- function(text) list(text=text,head=TRUE); T <- function(text,col=NULL) list(text=text,col=col); G <- list()
ci_bar <- function(y,ci,m,col,lwd=4) { segments(ci[1],y,ci[2],y,col=col,lwd=lwd,lend=1); points(m,y,pch=21,bg='white',col=col,cex=1.5,lwd=2) }
ci_col <- function(x,ci,m,col,lwd=4) { segments(x,ci[1],x,ci[2],col=col,lwd=lwd,lend=1); points(x,m,pch=21,bg='white',col=col,cex=1.5,lwd=2) }

page_u1 <- function() {
  w <- lapply(1:2,function(j) wilson(u1['x',j],u1['n',j])); wa <- lapply(1:2,function(j) wald(u1['x',j],u1['n',j])); pi0 <- u1['pi0',1]
  z <- sapply(1:2,function(j) (u1['x',j]/u1['n',j]-pi0)/sqrt(pi0*(1-pi0)/u1['n',j])); pv <- 2*pnorm(-abs(z))
  lab <- paste0(u1['x',],' z ',u1['n',],' pokusů')
  frame(c(2.6,1.3))
  par(mar=c(4.6,9.5,4.6,1))
  plot(NA,xlim=c(.2,.75),ylim=c(.4,2.7),yaxt='n',bty='l',xlab='Podíl správných odpovědí',ylab='')
  axis(2,at=2:1,labels=lab,tick=FALSE)
  abline(v=pi0,lty=2,col=c_gray); text(pi0,2.65,'hádání: 1/3',pos=4,cex=.85,col=c_gray)
  for(j in 1:2) { y <- 3-j
    ci_bar(y+.15,wa[[j]][c('lo','hi')],wa[[j]]['p'],c_orange); ci_bar(y-.15,w[[j]][c('lo','hi')],w[[j]]['p'],c_blue)
    text(wa[[j]]['hi'],y+.15,ci_txt(wa[[j]][c('lo','hi')]),pos=4,cex=.85,col=c_orange); text(w[[j]]['hi'],y-.15,ci_txt(w[[j]][c('lo','hi')]),pos=4,cex=.85,col=c_blue) }
  legend('bottomright',c('Waldův interval (počítáte)','Wilsonův interval (uveden pro srovnání)'),col=c(c_orange,c_blue),lwd=4,bty='n',cex=.85)
  heading('U1: stejný podíl, různě velký pokus','bod = podíl ve výběru; úsečky = 95% intervaly')
  panel(list(H(lab[1]),T(paste0('Waldův ',ci_txt(wa[[1]][c('lo','hi')]),'\nWilsonův ',ci_txt(w[[1]][c('lo','hi')]))),T(paste0('skórový test: z = ',num(z[1]),'; p = ',pval(pv[1]),'\n1/3 uvnitř obou intervalů: H0 nezamítáme')),G,
    H(lab[2]),T(paste0('Waldův ',ci_txt(wa[[2]][c('lo','hi')]),'\nWilsonův ',ci_txt(w[[2]][c('lo','hi')]))),T(paste0('skórový test: z = ',num(z[2]),'; p = ',pval(pv[2]),'\n1/3 mimo oba intervaly: H0 zamítáme')),G,
    H('Čeho si všimnout'),T('Čtyřnásobný počet pokusů zmenší\nšířku intervalu na polovinu.',c_gray),
    T('Wilsonův interval je mírně užší\na posunutý k 0,5.',c_gray)))
}

page_u2 <- function() {
  a <- wald(u2['s','x'],u2['s','n']); b <- wald(u2['bez','x'],u2['bez','n'])
  wd <- wald2(u2['s','x'],u2['s','n'],u2['bez','x'],u2['bez','n'])
  nc <- newcombe(u2['s','x'],u2['s','n'],u2['bez','x'],u2['bez','n']); te <- pooled(u2['s','x'],u2['s','n'],u2['bez','x'],u2['bez','n'])
  rr <- a['p']/b['p']; or <- (u2['s','x']/(u2['s','n']-u2['s','x']))/(u2['bez','x']/(u2['bez','n']-u2['bez','x']))
  frame(c(1.5,1.1,1.3))
  par(mar=c(4.6,4.8,4.6,1))
  plot(NA,xlim=c(.5,2.5),ylim=c(.3,.95),xaxt='n',bty='l',xlab='',ylab='Podíl klientů, kteří přišli')
  axis(1,at=1:2,labels=c('s připomínkou','bez připomínky'))
  ci_col(1,a[c('lo','hi')],a['p'],c_orange); ci_col(2,b[c('lo','hi')],b['p'],c_orange)
  text(1,a['p'],num(a['p'],3),pos=4,cex=.9); text(2,b['p'],num(b['p'],3),pos=4,cex=.9)
  heading('U2: dva podíly','podíl ± 1,96 × směrodatná chyba podílu')
  par(mar=c(4.6,4.8,4.6,1))
  plot(NA,xlim=c(.5,2.5),ylim=c(-.1,.45),xaxt='n',bty='l',xlab='',ylab='Rozdíl podílů (s − bez)')
  axis(1,at=1:2,labels=c('Waldův','Newcombův'))
  abline(h=0,lty=2,col=c_gray); ci_col(1,wd[c('lo','hi')],wd['d'],c_orange); ci_col(2,nc[c('lo','hi')],nc['d'],c_blue)
  text(1,wd['hi'],ci_txt(wd[c('lo','hi')]),pos=3,cex=.8,col=c_orange); text(2,nc['hi'],ci_txt(nc[c('lo','hi')]),pos=3,cex=.8,col=c_blue)
  heading('Rozdíl','95% intervaly; Newcombův uveden pro srovnání')
  panel(list(H('Odhad'),T(paste0('rozdíl ',num(wd['d'],3),'; směrodatná chyba ',num(wd['se'],4))),T(paste0('Waldův interval ',ci_txt(wd[c('lo','hi')]),'\nNewcombův interval ',ci_txt(nc[c('lo','hi')]))),G,
    H('Test se společným podílem'),T(paste0('společný podíl ',num(te$p,3))),T(paste0('z = ',num(te$z),'; p = ',pval(te$pv))),T(paste0('chí-kvadrát = z² = ',num(te$z^2))),G,
    H('Poměry (referenční: bez připomínky)'),T(paste0('poměr rizik ',num(rr),'; poměr šancí ',num(or))),G,
    H('Čeho si všimnout'),T('Oba intervaly leží nad nulou\na liší se jen o setiny.',c_gray),T('Poměr šancí není poměr rizik.',c_gray)))
}

page_u3 <- function() {
  f <- u3[,'f']; n <- sum(f); e <- n*u3[,'pi0']; chi <- sum((f-e)^2/e); v <- length(f)-1; pv <- pchisq(chi,v,lower.tail=FALSE)
  frame(c(2.6,1.3))
  par(mar=c(4.6,4.8,4.6,1))
  bp <- barplot(rbind(f,e),beside=TRUE,col=c(c_fill,'white'),border=c_ink,ylim=c(0,max(f,e)*1.2),ylab='Četnost',names.arg=rownames(u3))
  text(bp[1,],f,f,pos=3,cex=.9); text(bp[2,],e,num(e,1),pos=3,cex=.9,col=c_gray)
  legend('topright',c('pozorovaná četnost','očekávaná četnost'),fill=c(c_fill,'white'),border=c_ink,bty='n',cex=.9)
  heading('U3: ročníky ve výběru a na fakultě','očekávaná četnost = počet studentů × podíl ročníku na fakultě')
  panel(list(H('Příspěvky (f − e)² / e'),T(paste(paste0(1:4,'. ročník: ',num((f-e)^2/e,3)),collapse='\n')),G,
    H('Test dobré shody'),T(paste0('chí-kvadrát = ',num(chi),'; v = ',v)),T(paste0('p = ',pval(pv),'; kritická hodnota ',num(qchisq(.95,v)))),T('H0 nezamítáme'),G,
    H('Čeho si všimnout'),T('Nejvíc přispívají 1. a 3. ročník.',c_gray),T('Nezamítnutí neznamená, že výběr\nsložení fakulty přesně odpovídá.',c_gray)))
}

page_u4 <- function() {
  n <- sum(u4); e <- outer(rowSums(u4),colSums(u4))/n; chi <- sum((u4-e)^2/e); v <- 4; pv <- pchisq(chi,v,lower.tail=FALSE)
  rp <- u4/rowSums(u4); tot <- colSums(u4)/n; V <- sqrt(chi/(n*2))
  sr <- (u4-e)/sqrt(e*outer(1-rowSums(u4)/n,1-colSums(u4)/n))
  cols <- c(c_blue,c_mute,c_orange)
  frame(c(2.6,1.3))
  par(mar=c(4.6,4.8,4.6,1))
  bp <- barplot(t(rp),beside=TRUE,col=cols,border=c_ink,ylim=c(0,.7),ylab='Podíl v rámci ročníku (řádkový podíl)',names.arg=paste0(rownames(u4),' (n = ',rowSums(u4),')'))
  text(bp,t(rp),num(t(rp)),pos=3,cex=.82)
  for(j in 1:3) segments(bp[j,]-.5,tot[j],bp[j,]+.5,tot[j],lty=2,col=c_ink)
  legend('topleft',c(colnames(u4),'podíl z celého výběru'),fill=c(cols,NA),border=c(rep(c_ink,3),NA),lty=c(NA,NA,NA,2),bty='n',cex=.9)
  heading('U4: hlavní zdroj stresu podle ročníku','řádkové podíly; přerušovaně podíl z celého výběru 200 studentů')
  big <- order(-abs(sr))[1:4]; rc <- arrayInd(big,dim(sr))
  panel(list(H('Test nezávislosti'),T(paste0('chí-kvadrát = ',num(chi),'; v = ',v)),T(paste0('p = ',pval(pv),'; Cramérovo V = ',num(V))),T('H0 zamítáme'),G,
    H('Největší standardizovaná rezidua'),T(paste(paste0(rownames(u4)[rc[,1]],' × ',colnames(u4)[rc[,2]],': ',num(sr[big])),collapse='\n')),G,
    H('Čeho si všimnout'),T('S ročníkem ubývá studia\na přibývá financí.',c_gray),T('Rezidua popisují vzorec;\nnejsou to samostatné testy.',c_gray)))
}

page_u5 <- function() {
  n <- sum(u5); p1 <- sum(u5['pred_ano',])/n; p2 <- sum(u5[,'po_ano'])/n; up <- u5['pred_ne','po_ano']; down <- u5['pred_ano','po_ne']; nd <- up+down
  pv <- 2*pbinom(min(up,down),nd,.5); chi <- (up-down)^2/nd
  frame(c(1.3,1.3,1.3))
  par(mar=c(4.6,4.8,4.6,1))
  bp <- barplot(c(p1,p2),col=c(c_fill,c_blue),border=c_ink,ylim=c(0,.7),ylab='Podíl studentů s potížemi se spánkem',names.arg=c('před','po'))
  text(bp,c(p1,p2),num(c(p1,p2),3),pos=3,cex=.9)
  heading('U5: tíž studenti dvakrát',paste0('všech ',n,' úplných dvojic'))
  bp <- barplot(c(up,down),col=c(c_orange,c_mute),border=c_ink,ylim=c(0,max(up,down)*1.25),ylab='Počet neshodných dvojic',names.arg=c('ne → ano','ano → ne'))
  text(bp,c(up,down),c(up,down),pos=3,cex=.9); abline(h=nd/2,lty=2,col=c_gray); text(bp[2],nd/2,paste0('očekáváno při H0: ',num(nd/2,1)),pos=3,cex=.82,col=c_gray)
  heading('Neshodné dvojice',paste0('shodných dvojic je ',n-nd,' a do testu nevstupují'))
  panel(list(H('Odhad'),T(paste0('podíl před ',num(p1,3),', po ',num(p2,3))),T(paste0('rozdíl (',up,' − ',down,') / ',n,' = ',num(p2-p1,3))),G,
    H('McNemarův test'),T(paste0('přesně (binomicky): p = ',pval(pv))),T(paste0('přibližně: chí-kvadrát = ',num(chi),';\np = ',pval(pchisq(chi,1,lower.tail=FALSE)))),T('H0 zamítáme'),G,
    H('Čeho si všimnout'),T('O testu rozhoduje jen 19 neshodných\ndvojic; rozdíl podílů se vztahuje\nke všem 80 dvojicím.',c_gray),
    T('Bez kontrolní skupiny nelze změnu\npřipsat zkouškovému období.',c_gray)))
}

cairo_pdf(out_file,width=13.33,height=7.5,onefile=TRUE,family='Arial')
page_u1(); page_u2(); page_u3(); page_u4(); page_u5()
invisible(dev.off())
options(old_options)
cat('Saved',out_file,'\n')
