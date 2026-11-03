# Helper graphs for the Excel exercises of the chapter 6 presentation
# (presentations/kapitola_06_vyberove_rozdeleni_a_testovani_cviceni.xlsx, sheets U1 to U4).
# Inputs are read from the workbook, so the graphs follow its data. Needs the readxl package.
# Run from the project root: Rscript scripts/kapitola_06-prezentace-cviceni-grafy.R
# Output: presentations/kapitola_06_vyberove_rozdeleni_a_testovani_cviceni_grafy.pdf, one graph per page (16:9).
suppressPackageStartupMessages(library(readxl))
wb <- 'presentations/kapitola_06_vyberove_rozdeleni_a_testovani_cviceni.xlsx'
out_file <- 'presentations/kapitola_06_vyberove_rozdeleni_a_testovani_cviceni_grafy.pdf'
old_options <- options(OutDec=',')

cells <- function(sheet,range) {
  x <- read_excel(wb,sheet=sheet,range=range,col_names=FALSE,.name_repair='minimal')
  as.numeric(unlist(x,use.names=FALSE))
}
u1 <- list(digits=cells('U1_cislice','C4:C103'),means=cells('U1_cislice','D4:D53'),pop=cells('U1_cislice','E4:E5'))
u2 <- setNames(cells('U2_prumer','D4:D8'),c('mu','sigma','x','n','m'))
u3 <- setNames(cells('U3_binom_test','D4:D8'),c('n','k','pi0','pi_e','alpha'))
u4 <- setNames(cells('U4_z_test','D4:D9'),c('mu0','sigma','n','m','alpha','n_small'))
stopifnot(length(u1$digits)==100,length(u1$means)==50,!anyNA(c(u1$digits,u1$means,u1$pop,u2,u3,u4)))

# Chapter 6 palette (scripts/kapitola_06.R) ------------------------------------
c_blue <- '#245D78'; c_orange <- '#B54E24'; c_fill <- '#B8DDE8'; c_gray <- '#4D5A63'; c_ink <- '#223744'
c_h0 <- '#7B868E'; c_pale <- '#E1E8EB'; c_mute <- '#A9BAC3'; c_sand <- '#F3D9C6'
num <- function(x,digits=2) sub('^-','−',formatC(x,format='f',digits=digits,decimal.mark=','))

# Page frame: main graph on the left, explanatory panel on the right -------------
start_page <- function(title,subtitle,xlim,ylim,xlab,ylab='Hustota pravděpodobnosti',xat=NULL,yaxis=TRUE,top=4.4) {
  layout(matrix(1:2,1),widths=c(2.6,1.4))
  par(mar=c(4.6,4.8,top,1),mgp=c(2.9,.7,0),las=1,col.axis=c_ink,col.lab=c_ink,fg=c_ink,cex=1.05)
  plot(NA,xlim=xlim,ylim=ylim,xaxs='i',yaxs='i',bty='l',xaxt='n',yaxt=if(yaxis) 's' else 'n',xlab=xlab,ylab=ylab)
  at <- if(is.null(xat)) pretty(xlim) else xat
  axis(1,at=at,labels=num(at,0))
  title(title,line=top-2,adj=0,cex.main=1.18,col.main=c_ink)
  mtext(subtitle,side=3,line=top-3.5,adj=0,cex=.92,col=c_gray)
}
panel <- function(items) {
  par(mar=c(4.6,.4,4.4,.6)); plot.new(); plot.window(c(0,1),c(0,1))
  y <- .97
  for(it in items) {
    switch(it$type,
      head={ text(0,y,it$text,adj=0,font=2,cex=1,col=c_ink); y <- y-.06 },
      line={ segments(.02,y,.10,y,col=it$col,lwd=it$lwd %||% 2.4,lty=it$lty %||% 1)
             text(.13,y,it$text,adj=0,cex=.95,col=c_ink); y <- y-.055 },
      fill={ rect(.02,y-.022,.10,y+.022,col=if(is.null(it$density)) it$col else 'white',border=if(is.null(it$density)) NA else c_ink)
             if(!is.null(it$density)) rect(.02,y-.022,.10,y+.022,col=c_ink,density=it$density,angle=45,border=c_ink,lwd=.8)
             text(.13,if(is.null(it$sub)) y else y+.012,it$text,adj=0,cex=.95,font=2,col=it$tcol %||% c_ink)
             if(!is.null(it$sub)) text(.13,y-.024,it$sub,adj=0,cex=.84,col=c_gray)
             y <- y-if(is.null(it$sub)) .06 else .085 },
      text={ nl <- if(is.character(it$text)) length(strsplit(it$text,'\n')[[1]]) else 1
             text(0,y,it$text,adj=c(0,1),cex=it$cex %||% .92,col=it$col %||% c_ink,font=it$font %||% 1)
             y <- y-.044*nl-.022 },
      gap={ y <- y-(it$h %||% .03) })
  }
}
area <- function(from,to,dens,...) {
  if(to<=from) return(invisible())
  x <- seq(from,to,length.out=400)
  polygon(c(from,x,to),c(0,dens(x),0),...)
}
curve_line <- function(dens,xlim,...) { x <- seq(xlim[1],xlim[2],length.out=800); lines(x,dens(x),...) }
vline <- function(x,top,label,ylab,col=c_ink,lty=2,cex=.92,font=2,pos=NULL) {
  segments(x,0,x,top,lty=lty,lwd=1.6,col=col)
  if(is.null(pos)) text(x,ylab,label,cex=cex,col=col,font=font) else text(x,ylab,label,pos=pos,offset=.25,cex=cex,col=col,font=font)
}
marker <- function(x,ytip,ytext,label,adj=c(.5,0),col=c_orange) {
  arrows(x,ytext,x,ytip,length=.08,lwd=1.8,col=col)
  text(x,ytext,label,adj=adj,cex=.92,font=2,col=col)
}
bars <- function(k,p,col,width=.8) rect(k-width/2,0,k+width/2,p,col=col,border=NA)

pages <- list()
page <- function(f) pages[[length(pages)+1]] <<- f

# U1: digits and means of samples of five --------------------------------------
mu1 <- u1$pop[1]; sigma1 <- u1$pop[2]
page(function() {
  cnt <- tabulate(u1$digits+1,10)
  start_page('Úkol 1 c): 100 číslic z populace stejně pravděpodobných číslic',
             paste0('List U1_cislice, C4:C103;  m = ',num(mean(u1$digits),2),',  s = ',num(sd(u1$digits),3)),
             c(-.7,9.7),c(0,22),'Číslice',ylab='Počet výskytů',xat=0:9)
  bars(0:9,cnt,c_fill)
  text(0:9,cnt+.5,cnt,adj=c(.5,0),cex=.9,col=c_ink)
  abline(h=10,lty=2,lwd=1.6,col=c_orange)
  text(9.6,10.5,'očekáváno 10',adj=c(1,0),cex=.92,font=2,col=c_orange)
  panel(list(
    list(type='head',text='Co graf ukazuje'),
    list(type='fill',col=c_fill,text='pozorované četnosti číslic'),
    list(type='line',col=c_orange,lty=2,lwd=1.6,text='očekávaná četnost 100 × 0,1'),
    list(type='gap'),
    list(type='text',text='Populace je rovnoměrná: žádná číslice\nnemá navrch. Rozdělení nemá vrchol\nuprostřed, četnosti 4 až 16 jsou jen\nnáhodné kolísání kolem 10.'),
    list(type='gap'),
    list(type='text',text=paste0('Populace: μ = ',num(mu1,1),',  σ = ',num(sigma1,3)),font=2)))
})
page(function() {
  cnt <- tabulate(findInterval(u1$means,seq(-.5,9.5,1)),10)
  se5 <- sigma1/sqrt(5)
  start_page('Úkol 1 c): 50 průměrů výběrů po 5 číslicích',
             paste0('List U1_cislice, D4:D53;  m = ',num(mean(u1$means),3),',  s = ',num(sd(u1$means),3),
                    ';  intervaly o šířce 1 se středem v celých číslech'),
             c(-.7,9.7),c(0,22),'Průměr výběru pěti číslic',ylab='Počet průměrů',xat=0:9)
  bars(0:9,cnt,c_fill,width=.96)
  # Count labels sit above both the bar and the normal curve, so the curve never crosses them.
  top <- pmax(cnt,sapply(0:9,function(k) max(50*dnorm(c(k-.3,k,k+.3),mu1,se5))))
  text((0:9)[cnt>0],top[cnt>0]+.5,cnt[cnt>0],adj=c(.5,0),cex=.9,col=c_ink)
  curve_line(function(x) 50*dnorm(x,mu1,se5),c(-.7,9.7),lwd=2.6,col=c_orange)
  text(7.4,6.2,'normální křivka\npodle CLV',adj=c(0,0),cex=.92,font=2,col=c_orange)
  panel(list(
    list(type='head',text='Co graf ukazuje'),
    list(type='fill',col=c_fill,text='četnosti průměrů (M57:N63)'),
    list(type='line',col=c_orange,text='normální model průměrů'),
    list(type='text',text=bquote('střed μ = '*.(num(mu1,1))*',  '*σ[m]*' = σ / '*sqrt(5)*' = '*.(num(se5,3))),cex=.88,col=c_gray),
    list(type='gap'),
    list(type='text',text='Průměry tvoří jeden vrchol uprostřed\na ke krajům ubývají, přestože populace\nčíslic je rovnoměrná: centrální\nlimitní věta v praxi.'),
    list(type='gap'),
    list(type='text',text=paste0('Průměry kolísají asi √5 ≈ 2,2krát\nméně než číslice (s = ',num(sd(u1$means),2),' proti ',num(sd(u1$digits),2),').'))))
})
page(function() {
  se5 <- sigma1/sqrt(5); se15 <- sigma1/sqrt(15)
  start_page('Úkol 1 d): výběrové rozdělení průměru pro n = 5 a n = 15',
             paste0('Model: populace číslic 0 až 9, μ = ',num(mu1,1),',  σ = ',num(sigma1,3)),
             c(-.7,9.7),c(0,.62),'Číslice, resp. průměr výběru',xat=0:9)
  bars(0:9,rep(.1,10),c_pale,width=.96)
  curve_line(function(x) dnorm(x,mu1,se5),c(-.7,9.7),lwd=2.6,col=c_blue)
  curve_line(function(x) dnorm(x,mu1,se15),c(-.7,9.7),lwd=2.6,col=c_orange)
  text(mu1+1.75,dnorm(mu1+1.75,mu1,se5)+.035,'n = 5',adj=c(0,0),cex=1,font=2,col=c_blue)
  text(mu1+1.05,dnorm(mu1+1.05,mu1,se15)+.06,'n = 15',adj=c(0,0),cex=1,font=2,col=c_orange)
  text(.3,.115,'populace číslic',adj=c(0,0),cex=.92,col=c_gray)
  panel(list(
    list(type='head',text='Rozdělení'),
    list(type='fill',col=c_pale,text='populace číslic (každá 0,1)'),
    list(type='line',col=c_blue,text=bquote('průměry po 5:  '*σ[m]*' = '*.(num(se5,2)))),
    list(type='line',col=c_orange,text=bquote('průměry po 15:  '*σ[m]*' = '*.(num(se15,2)))),
    list(type='gap'),
    list(type='text',text='500 výběrů po 5 číslicích: stejná modrá\nkřivka (střed 4,5, šířka 1,28). Histogram\nz 500 průměrů ji jen věrněji obkreslí.'),
    list(type='text',text='50 výběrů po 15 číslicích: jiné, užší\nrozdělení (oranžové), ještě bližší\nnormálnímu tvaru.'),
    list(type='text',text='Křivky jsou normální modely; skutečné\nprůměry nabývají jen hodnot po 0,2,\nresp. po 1/15.',cex=.84,col=c_gray,font=3)))
})

# U2: one result and the mean of a group ----------------------------------------
dind <- function(x) dnorm(x,u2['mu'],u2['sigma'])
se2 <- u2['sigma']/sqrt(u2['n']); dmean <- function(x) dnorm(x,u2['mu'],se2)
z_x <- (u2['x']-u2['mu'])/u2['sigma']; p_x <- pnorm(z_x)
z_m <- (u2['m']-u2['mu'])/se2; p_m <- pnorm(z_m)
xl2 <- c(450,850)
page(function() {
  start_page('Úkol 2 a): jak neobvyklý je výsledek 490 mezi přijatými?',
             paste0('List U2_prumer;  normální model přijatých: μ = ',u2['mu'],',  σ = ',u2['sigma'],' bodů'),
             xl2,c(0,.0098),'Výsledek v přijímacím testu (body)',xat=seq(450,850,50),top=6)
  area(xl2[1],xl2[2],dind,col=c_pale,border=NA)
  area(xl2[1],u2['x'],dind,col=c_orange,border=NA)
  curve_line(dind,xl2,lwd=2.6,col=c_blue)
  axis(3,at=u2['mu']+(-3:3)*u2['sigma'],labels=num(-3:3,0),cex.axis=.85,col.axis=c_gray,mgp=c(2,.45,0),tcl=-.3)
  mtext('z-skór',side=3,at=xl2[1],adj=0,line=.45,cex=.85,col=c_gray)
  vline(u2['mu'],.0086,'',0)
  marker(u2['x'],.0003,.0022,paste0('x = ',u2['x'],'\nz = ',num(z_x,1)))
  panel(list(
    list(type='head',text='Plochy'),
    list(type='fill',col=c_pale,text='všichni přijatí (plocha 1)'),
    list(type='fill',col=c_orange,text=paste0('490 a méně: ',num(p_x,4)),tcol=c_orange,sub='asi 7 z 10 000 přijatých'),
    list(type='gap'),
    list(type='text',text=bquote(z*' = (x − μ) / σ = (490 − 650) / 50 = '*.(num(z_x,1))),cex=.9),
    list(type='gap'),
    list(type='text',text='Plocha je tak malá, že v grafu je\nsotva vidět. Výsledek je mezi\npřijatými velmi neobvyklý.'),
    list(type='text',text='Proč byl student přijat, ale plocha\nneříká: o přijetí mohla rozhodnout\ni jiná kritéria.',col=c_gray,font=3)))
})
# Illustrative applicant model for b): mean 590, SD 80, admission from 580 points (not in the task).
app_mu <- 590; app_sd <- 80; cut <- 580
p_acc <- pnorm(cut,app_mu,app_sd,lower.tail=FALSE)
dacc <- function(x) ifelse(x>=cut,dnorm(x,app_mu,app_sd)/p_acc,0)
acc_mean <- integrate(function(x) x*dacc(x),cut,Inf)$value
acc_sd <- sqrt(integrate(function(x) (x-acc_mean)^2*dacc(x),cut,Inf)$value)
page(function() {
  start_page('Úkol 2 b): proč je σ přijatých malá a proč nemusí být normální',
             'Ilustrativní model uchazečů (není v zadání): průměr 590, směrodatná odchylka 80, přijetí od 580 bodů',
             c(350,850),c(0,.0118),'Výsledek v přijímacím testu (body)',xat=seq(350,850,50))
  xa <- seq(350,850,length.out=800)
  area(cut,850,dacc,col=c_fill,border=NA)
  lines(xa,dnorm(xa,app_mu,app_sd),lwd=2.4,col=c_h0)
  lines(c(cut,xa[xa>=cut]),c(0,dacc(xa[xa>=cut])),lwd=2.6,col=c_blue)
  curve_line(dind,c(350,850),lwd=2,lty=2,col=c_orange)
  vline(cut,.0108,'hranice přijetí 580',.0112)
  text(520,dnorm(520,app_mu,app_sd)+.0006,'všichni uchazeči',adj=c(1,0),cex=.92,font=2,col=c_h0)
  text(700,.0108,'přijatí: levá část\nrozdělení chybí',adj=c(0,1),cex=.92,font=2,col=c_blue)
  text(712,.0077,'normální model\nμ = 650, σ = 50',adj=c(0,1),cex=.92,font=2,col=c_orange)
  marker(u2['x'],.0002,.0011,'490',col=c_gray)
  panel(list(
    list(type='head',text='Rozdělení'),
    list(type='line',col=c_h0,text='uchazeči (σ = 80)'),
    list(type='line',col=c_blue,text=paste0('přijatí (σ ≈ ',num(acc_sd,0),', průměr ≈ ',num(acc_mean,0),')')),
    list(type='line',col=c_orange,lty=2,lwd=2,text='normální model ze zadání'),
    list(type='gap'),
    list(type='text',text='Přijímací hranice usekne slabší\nuchazeče. Zbylí přijatí jsou si\npodobnější, a proto je σ menší.'),
    list(type='text',text='Rozdělení přijatých má ostrý dolní\nokraj a delší pravý chvost: není\nnormální. Plocha 0,0007 z úkolu a)\nje proto jen přibližná.'),
    list(type='text',text='Čísla uchazečů jsou zvolena jen pro\nnázornost; tvar platí obecně.',cex=.84,col=c_gray,font=3)))
})
page(function() {
  start_page('Úkol 2 c): jak neobvyklý je průměr 630 ve skupině 25 studentů?',
             bquote('Výběrové rozdělení průměru: μ = '*.(num(u2['mu'],0))*',  '*σ[m]*' = σ / '*sqrt(.(u2['n']))*' = '*.(num(se2,0))*' bodů'),
             c(500,800),c(0,.0445),'Výsledek jednotlivce, resp. průměr skupiny (body)',xat=seq(500,800,25))
  area(500,800,dmean,col=c_pale,border=NA)
  area(500,u2['m'],dmean,col=c_orange,border=NA)
  curve_line(dind,c(500,800),lwd=2.2,col=c_h0)
  curve_line(dmean,c(500,800),lwd=2.6,col=c_blue)
  text(705,dind(705)+.0012,'jednotlivci (σ = 50)',adj=c(0,0),cex=.92,font=2,col=c_h0)
  text(663,.038,'průměry 25 studentů',adj=c(0,0),cex=.92,font=2,col=c_blue)
  marker(u2['m'],.0012,.016,paste0('m = ',u2['m'],'\nz = ',num(z_m,0)),adj=c(1.08,0))
  panel(list(
    list(type='head',text='Plochy'),
    list(type='fill',col=c_pale,text='všechny možné průměry (1)'),
    list(type='fill',col=c_orange,text=paste0('630 a méně: ',num(p_m,3)),tcol=c_orange,sub='asi 1 skupina ze 44'),
    list(type='gap'),
    list(type='text',text=bquote(z*' = (m − μ) / '*σ[m]*' = (630 − 650) / 10 = '*.(num(z_m,0))),cex=.9),
    list(type='gap'),
    list(type='text',text='Průměr je jen 20 bodů pod průměrem,\npřesto je neobvyklý: průměry kolísají\npětkrát méně než jednotlivci (užší\nmodrá křivka).')))
})
page(function() {
  q <- qnorm(.975)
  li <- u2['mu']+c(-1,1)*q*u2['sigma']; lm <- u2['mu']+c(-1,1)*q*se2
  start_page('Úkol 2 d): prostředních 95 % jednotlivců a průměrů 25 studentů',
             bquote('Meze μ ± 1,96 × σ pro jednotlivce a μ ± 1,96 × '*σ[m]*' pro průměry'),
             xl2,c(0,.05),'Výsledek jednotlivce, resp. průměr skupiny (body)',xat=seq(450,850,50))
  area(li[1],li[2],dind,col=c_pale,border=NA)
  area(lm[1],lm[2],dmean,col=c_fill,border=NA)
  curve_line(dind,xl2,lwd=2.2,col=c_h0)
  curve_line(dmean,xl2,lwd=2.6,col=c_blue)
  # Brackets above the curves, individuals higher, means lower.
  yb1 <- .0465; yb2 <- .0425
  arrows(li[1],yb1,li[2],yb1,code=3,angle=90,length=.06,lwd=1.6,col=c_gray)
  text(li,yb1,num(li,1),pos=c(2,4),offset=.3,cex=.9,font=2,col=c_gray)
  arrows(lm[1],yb2,lm[2],yb2,code=3,angle=90,length=.06,lwd=1.6,col=c_blue)
  text(lm,yb2,num(lm,1),pos=c(2,4),offset=.3,cex=.9,font=2,col=c_blue)
  segments(li,0,li,yb1,lty=3,col=c_gray); segments(lm,0,lm,yb2,lty=3,col=c_blue)
  text(760,dind(760)+.0012,'jednotlivci',adj=c(0,0),cex=.92,font=2,col=c_h0)
  panel(list(
    list(type='head',text='Prostředních 95 %'),
    list(type='fill',col=c_pale,text=paste0('jednotlivci: ',num(li[1],1),' až ',num(li[2],1)),sub='σ = 50'),
    list(type='fill',col=c_fill,text=paste0('průměry: ',num(lm[1],1),' až ',num(lm[2],1)),sub=bquote(σ[m]*' = 50 / 5 = 10')),
    list(type='gap'),
    list(type='text',text='Rozmezí pro průměry je pětkrát užší,\nprotože směrodatná chyba je σ / √25.'),
    list(type='text',text='Nejde o interval spolehlivosti: μ = 650\nznáme a ptáme se, kde budou ležet\nvýsledky.',col=c_gray,font=3)))
})

# U3: binomial test -------------------------------------------------------------
n3 <- u3['n']; k3 <- u3['k']; a3 <- u3['alpha']
pk <- function(pi) dbinom(0:n3,n3,pi)
up <- n3+1-sum(pbinom((0:n3)-1,n3,u3['pi0'],lower.tail=FALSE)<=a3/2)  # smallest k with P(X >= k) <= alpha/2
lowc <- n3-up
p_two <- pbinom(lowc,n3,u3['pi0'])+pbinom(up-1,n3,u3['pi0'],lower.tail=FALSE)
p_obs <- 2*pbinom(n3-k3,n3,u3['pi0'])
page(function() {
  p <- pk(u3['pi0']); k <- 0:n3; sel <- k>=25 & k<=75
  start_page('Úkol 3 b), c): p-hodnota a kritický obor při π = 0,5',
             paste0('List U3_binom_test;  n = ',n3,',  pozorováno ',k3,' žen;  oboustranný test, α = ',num(a3,2)),
             c(24.3,75.7),c(0,.098),'Počet žen ze 100',ylab='Pravděpodobnost',xat=seq(25,75,5))
  crit <- k<=lowc | k>=up
  bars(k[sel],p[sel],ifelse(crit[sel],c_orange,c_mute))
  vline(lowc+.5,.083,'',0); vline(up-.5,.083,'',0)
  text(lowc+.5,.086,paste0('≤ ',lowc),pos=2,offset=.2,cex=.92,font=2,col=c_ink)
  text(up-.5,.086,paste0('≥ ',up),pos=4,offset=.2,cex=.92,font=2,col=c_ink)
  text(lowc-1,.074,'← kritický obor',adj=c(1,0),cex=.88,col=c_ink)
  text(up+1,.074,'kritický obor →',adj=c(0,0),cex=.88,col=c_ink)
  marker(k3,p[k3+1]+.002,.03,'pozorováno 61',adj=c(-.05,0))
  marker(n3-k3,p[n3-k3+1]+.002,.03,'stejně extrémní 39',adj=c(1.05,0))
  panel(list(
    list(type='head',text='Pravděpodobnosti při π = 0,5'),
    list(type='fill',col=c_orange,text=paste0('p-hodnota = ',num(p_obs,4)),tcol=c_orange,sub=paste0('P(X ≥ ',k3,') + P(X ≤ ',n3-k3,') = 2 × ',num(p_obs/2,4))),
    list(type='fill',col=c_mute,text='méně extrémní počty'),
    list(type='gap'),
    list(type='text',text=paste0('Kritický obor: 0 až ',lowc,' a ',up,' až ',n3,'.\nJeho pravděpodobnost ',num(p_two,4),' je skutečná\nchyba I. druhu, menší než 0,05: počet\nje diskrétní.')),
    list(type='text',text=paste0('S hranicí ',up-1,' by vyšla ',num(2*pbinom(n3-up+1,n3,u3['pi0']),3),' > 0,05.'),col=c_gray),
    list(type='gap'),
    list(type='text',text=paste0('61 leží právě v kritickém oboru:\nzamítáme nulovou hypotézu\nna hladině ',num(a3,2),'.'),font=2)))
})
p_e <- 2*pbinom(k3,n3,u3['pi_e'])
page(function() {
  p <- pk(u3['pi_e']); k <- 0:n3; sel <- k>=45 & k<=95
  start_page('Úkol 3 e): p-hodnota při π = 0,75',
             paste0('Očekáváno n × π = ',n3*u3['pi_e'],' žen;  pozorováno ',k3,';  oboustranně = 2 × menší chvost'),
             c(44.3,95.7),c(0,.105),'Počet žen ze 100',ylab='Pravděpodobnost',xat=seq(45,95,5))
  bars(k[sel],p[sel],ifelse(k[sel]<=k3,c_orange,c_mute))
  vline(n3*u3['pi_e'],.096,'očekáváno 75',.099,col=c_gray,lty=3,font=1)
  marker(k3,p[k3+1]+.002,.035,paste0('pozorováno ',k3,' a méně'),adj=c(.8,0))
  panel(list(
    list(type='head',text='Pravděpodobnosti při π = 0,75'),
    list(type='fill',col=c_orange,text=paste0('P(X ≤ ',k3,') = ',num(p_e/2,4)),tcol=c_orange,sub='menší chvost'),
    list(type='fill',col=c_mute,text='ostatní počty'),
    list(type='gap'),
    list(type='text',text=paste0('Oboustranná p-hodnota = 2 × ',num(p_e/2,4),'\n= ',num(p_e,4),'. Rozdělení není souměrné,\nproto zdvojnásobujeme menší chvost.')),
    list(type='gap'),
    list(type='text',text=paste0('61 žen je při π = 0,75 velmi\nnepravděpodobných: zamítáme i tuto\nnulovou hypotézu.'),font=2)))
})
page(function() {
  pis <- c(.5,2/3,.75); cols <- c(c_h0,c_blue,c_orange)
  pv <- sapply(pis,function(pi) min(1,2*min(pbinom(k3,n3,pi),pbinom(k3-1,n3,pi,lower.tail=FALSE))))
  start_page('Úkol 3 e): s jakým podílem žen jsou data slučitelná?',
             paste0('Binomické rozdělení počtu žen pro tři hodnoty π;  pozorováno ',k3,' žen ze ',n3),
             c(29.5,95.5),c(0,.105),'Počet žen ze 100',ylab='Pravděpodobnost',xat=seq(30,95,5))
  k <- 30:95
  for(j in seq_along(pis)) lines(k,dbinom(k,n3,pis[j]),type='o',pch=16,cex=.55,lwd=2,col=cols[j])
  vline(k3,.096,paste0('pozorováno ',k3),.099,col=c_ink)
  labs <- c('π = 0,5','π = 2/3','π = 0,75'); peaks <- n3*pis
  for(j in seq_along(pis)) text(peaks[j]+.5,dbinom(round(peaks[j]),n3,pis[j])+.004,labs[j],adj=c(.5,0),cex=.95,font=2,col=cols[j])
  panel(list(
    list(type='head',text='Oboustranná p-hodnota'),
    list(type='line',col=cols[1],text=paste0('π = 0,5:  p = ',num(pv[1],3),'  (zamítáme)')),
    list(type='line',col=cols[2],text=paste0('π = 2/3:  p = ',num(pv[2],2),'  (nezamítáme)')),
    list(type='line',col=cols[3],text=paste0('π = 0,75:  p = ',num(pv[3],4),'  (zamítáme)')),
    list(type='gap'),
    list(type='text',text='Svislá čára 61 leží daleko v chvostu\nrozdělení pro π = 0,5 i pro π = 0,75,\nale blízko středu rozdělení pro π = 2/3\n(„dvakrát víc žen“).'),
    list(type='text',text='Nezamítnutí π = 2/3 neznamená, že\nπ = 2/3 platí: slučitelné jsou i blízké\nhodnoty.',col=c_gray,font=3)))
})

# U4: z test of a mean against a norm ----------------------------------------------
xl4 <- c(24,36); q4 <- qnorm(1-u4['alpha']/2)
z_page <- function(n,title) {
  se <- u4['sigma']/sqrt(n); d <- function(x) dnorm(x,u4['mu0'],se)
  crit <- u4['mu0']+c(-1,1)*q4*se; diff <- u4['m']-u4['mu0']
  z <- diff/se; p <- 2*pnorm(-abs(z)); obs <- u4['mu0']+c(-1,1)*abs(diff)
  start_page(title,
             bquote(μ[0]*' = '*.(num(u4['mu0'],0))*',  σ = '*.(num(u4['sigma'],0))*',  n = '*.(n)*',  '*σ[m]*' = σ / '*sqrt(.(n))*' = '*.(num(se,3))*';  oboustranně, α = '*.(num(u4['alpha'],2))),
             xl4,c(0,.56),'Průměr skupiny (body škály sebeúcty)',xat=24:36)
  area(xl4[1],obs[1],d,col=c_orange,border=NA); area(obs[2],xl4[2],d,col=c_orange,border=NA)
  area(xl4[1],crit[1],d,col=c_ink,density=28,angle=45,border=NA,lwd=.9)
  area(crit[2],xl4[2],d,col=c_ink,density=28,angle=45,border=NA,lwd=.9)
  curve_line(d,xl4,lwd=2.6,col=c_blue)
  for(j in 1:2) {
    segments(crit[j],0,crit[j],.505,lty=2,lwd=1.6,col=c_ink)
    text(crit[j],.522,num(crit[j],2),cex=.92,font=2,col=c_ink)
  }
  text(crit[1],.475,'← kritický obor',pos=2,offset=.35,cex=.84,col=c_ink)
  text(crit[2],.475,'kritický obor →',pos=4,offset=.35,cex=.84,col=c_ink)
  text(u4['mu0'],d(u4['mu0'])+.012,bquote(H[0]*': μ = '*.(num(u4['mu0'],0))),adj=c(.5,0),cex=1,font=2,col=c_blue)
  # Observed mean: arrow from the right side, label away from the critical value label.
  yo <- .3; xo <- max(u4['m']+1.6,crit[2]+.35)
  arrows(xo,yo,u4['m']+.03,.006,length=.08,lwd=1.8,col=c_orange)
  text(xo+.05,yo,paste0('m = ',num(u4['m'],1),'\nz = ',num(z,2)),adj=c(0,.3),cex=.92,font=2,col=c_orange)
  dec <- if(p<=u4['alpha']) 'm leží v kritickém oboru a p ≤ α:\nnulovou hypotézu zamítáme.' else 'm neleží v kritickém oboru a p > α:\nnulovou hypotézu nezamítáme.'
  panel(list(
    list(type='head',text='Plochy pod křivkou'),
    list(type='fill',density=28,text=paste0('α = ',num(u4['alpha'],2)),sub='kritický obor, 2,5 % v každém chvostu'),
    list(type='fill',col=c_orange,text=paste0('p-hodnota = ',num(p,3)),tcol=c_orange,
         sub=paste0('za ',num(obs[1],1),' a ',num(obs[2],1),' (± ',num(abs(diff),1),' od ',num(u4['mu0'],0),')')),
    list(type='gap'),
    list(type='text',text=paste0('Kritické hodnoty: ',num(u4['mu0'],0),' ± 1,96 × ',num(se,3),'\n= ',num(crit[1],2),' a ',num(crit[2],2),'.')),
    list(type='gap'),
    list(type='text',text=dec,font=2)))
}
page(function() z_page(u4['n'],paste0('Úkol 4 b), c): z-test pro ',u4['n'],' studentů')))
page(function() {
  z_page(u4['n_small'],paste0('Úkol 4 e): stejný průměr, ale jen ',u4['n_small'],' studentů'))
  text(0,.12,paste0('Rozdíl 1,8 bodu je stejný jako u ',u4['n'],'\nstudentů. Menší skupina jej změří\nméně přesně: křivka je širší.'),adj=c(0,1),cex=.92,col=c_gray,font=3)
})
page(function() {
  n <- u4['n']; se <- u4['sigma']/sqrt(n); d <- function(x) dnorm(x,u4['mu0'],se)
  c1 <- qnorm(1-u4['alpha']); cr <- u4['mu0']+c(-1,1)*c1*se
  p1 <- pnorm((u4['m']-u4['mu0'])/se,lower.tail=FALSE)
  start_page('Úkol 4 f): proč nesmí volit směr testu až po výsledku',
             paste0('n = ',n,';  jednostranný test na hladině 0,05 má kritickou hodnotu ',num(u4['mu0'],0),' + 1,645 × ',num(se,3),' = ',num(cr[2],2)),
             xl4,c(0,.56),'Průměr skupiny (body škály sebeúcty)',xat=24:36)
  area(xl4[1],cr[1],d,col=c_sand,border=NA)
  area(cr[2],xl4[2],d,col=c_orange,border=NA)
  curve_line(d,xl4,lwd=2.6,col=c_blue)
  for(j in 1:2) {
    segments(cr[j],0,cr[j],.505,lty=2,lwd=1.6,col=c_ink)
    text(cr[j],.522,num(cr[j],2),cex=.92,font=2,col=c_ink)
  }
  text(cr[1],.475,'5 % „méně“',pos=2,offset=.35,cex=.84,col=c_ink)
  text(cr[2],.475,'5 % „více“',pos=4,offset=.35,cex=.84,col=c_ink)
  text(u4['mu0'],d(u4['mu0'])+.012,bquote(H[0]*': μ = '*.(num(u4['mu0'],0))),adj=c(.5,0),cex=1,font=2,col=c_blue)
  arrows(u4['m']+1.6,.3,u4['m']+.03,.006,length=.08,lwd=1.8,col=c_ink)
  text(u4['m']+1.65,.3,paste0('m = ',num(u4['m'],1)),adj=c(0,.3),cex=.92,font=2,col=c_ink)
  panel(list(
    list(type='head',text='Směr zvolený předem („více“)'),
    list(type='fill',col=c_orange,text='zamítá jen v pravém chvostu: 5 %'),
    list(type='text',text=paste0('Jednostranná p-hodnota ',num(p1,3),'.'),cex=.9),
    list(type='gap'),
    list(type='head',text='Směr zvolený až podle výsledku'),
    list(type='fill',col=c_sand,text='+ levý chvost: dalších 5 %'),
    list(type='text',text='Kdo vždy vybere stranu, na kterou\nprůměr padl, zamítá v obou 5%\nchvostech: skutečná chyba I. druhu\nje 0,10, ne 0,05.'),
    list(type='gap'),
    list(type='text',text='Směr je součástí pravidla testu a musí\nbýt stanoven před sběrem dat.',font=2)))
})

cairo_pdf(out_file,width=13.33,height=7.5,onefile=TRUE,family='Arial')
for(f in pages) f()
invisible(dev.off())
options(old_options)
cat(sprintf('U1 counts digits: %s\nU1 counts means: %s\n',paste(tabulate(u1$digits+1,10),collapse=' '),paste(tabulate(findInterval(u1$means,seq(-.5,9.5,1)),10),collapse=' ')))
cat(sprintf('U2 p_x=%.6f p_m=%.6f se=%.1f; applicants model: accepted mean %.1f sd %.1f\n',p_x,p_m,se2,acc_mean,acc_sd))
cat(sprintf('U3 crit <=%d >=%d alpha_true=%.6f p=%.6f p_e=%.6f\n',lowc,up,p_two,p_obs,p_e))
cat(sprintf('pages: %d\n',length(pages)))
