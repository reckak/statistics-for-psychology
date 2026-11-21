# Original teaching examples for chapter 5; base R, UTF-8, deterministic project-root paths.
# Model values and simulations only; no empirical psychological data.
ch5_out <- 'assets/chapter-05/plots'
ch5_old_options <- options(OutDec=',')
dir.create(ch5_out,recursive=TRUE,showWarnings=FALSE)
ch5_blue <- '#245D78'; ch5_orange <- '#B54E24'; ch5_fill <- '#B8DDE8'; ch5_gray <- '#4D5A63'; ch5_pale <- '#E1E8EB'; ch5_sand <- '#FAECDD'
ch5_num <- function(x,digits=3) formatC(x,format='f',digits=digits,decimal.mark=',')
ch5_draw <- function(name,code,width=8,height=4.5) {
  svg(file.path(ch5_out,paste0(name,'.svg')),width=width,height=height,family='sans',bg='white')
  par(mar=c(4.5,4.5,2.6,.8),mgp=c(2.7,.7,0),las=1,col.axis='#223744',col.lab='#223744',fg='#223744',cex=.9)
  force(code); dev.off()
}
# Data and descriptions of the figures for the AI tutor (tmp/tutor-figures/kapitola_05/); see scripts/tutor/figure-data.R.
source('scripts/tutor/figure-data.R',encoding='UTF-8')
ch5_fig <- function(...) tf_figure('kapitola_05',...)
# Fixed teaching inputs -------------------------------------------------------
ch5_cards <- c(podstatna=40,slovesa=35,pridavna=25)
ch5_dependent <- matrix(c(40,60,30,70),2,byrow=TRUE,dimnames=list(c('Žena','Muž'),c('Zvýšený stres','Nízký stres')))
ch5_independent <- matrix(c(30,70,30,70),2,byrow=TRUE,dimnames=dimnames(ch5_dependent))
ch5_sens <- .95; ch5_spec <- .90
# Natural frequencies: state present/absent by positive/negative result.
ch5_screen <- function(total,prev,sens=ch5_sens,spec=ch5_spec) {
  present <- total*prev; absent <- total-present
  c(present=present,absent=absent,tp=present*sens,fn=present*(1-sens),fp=absent*(1-spec),tn=absent*spec)
}
ch5_ppv <- function(f) unname(f['tp']/(f['tp']+f['fp']))
ch5_npv <- function(f) unname(f['tn']/(f['tn']+f['fn']))
ch5_n <- 5; ch5_pi <- .25
# Simulations: guessing one of four options; seeds fixed for reproducible figures.
set.seed(5)
ch5_runs <- vapply(1:5,function(j) cumsum(rbinom(1000,1,ch5_pi))/(1:1000),numeric(1000))
set.seed(20261012)
ch5_sim_hadani <- rbinom(40,ch5_n,ch5_pi)
# Figures -----------------------------------------------------------------------
ch5_draw('relativni-cetnost', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,2.2))
  cols <- c(ch5_blue,'#6E9FB3','#8A6D3B',ch5_gray,'#7A4E8A')
  for(k in 1:2) {
    m <- c(50,1000)[k]
    plot(NA,xlim=c(1,m),ylim=c(0,if(k==1)1 else .5),xlab='Počet dosavadních pokusů',ylab='Relativní četnost správných tipů',main=c('Prvních 50 pokusů','Celých 1 000 pokusů')[k],bty='l')
    abline(h=ch5_pi,lty=2,lwd=1.8,col=ch5_orange)
    for(j in 1:5) lines(1:m,ch5_runs[1:m,j],col=cols[j],lwd=1.5,lty=j)
    axis(4,at=ch5_pi,labels='0,25',col.axis=ch5_orange,tick=FALSE,line=-.9)
  }
},width=10,height=4.4)
ch5_fig('relativni-cetnost','simulace',note='Dva panely vedle sebe ukazují týchž pět simulovaných řad hádání jedné ze čtyř možností; řady se liší barvou a typem čáry. Oranžová přerušovaná vodorovná čára leží v pravděpodobnosti 0,25 a je popsána u pravého okraje. V levém panelu jsou uvedeny všechny pokusy; v pravém kvůli rozsahu prvních 20 pokusů, do 200. pokusu každý desátý (30, 40, …, 200) a dále každý dvacátý (220, 240, …, 1 000), obrázek přitom spojuje všech 1 000 bodů.',panels=lapply(1:2,function(k) {
  m <- c(50,1000)[k]; i <- if(k==1) 1:50 else c(1:20,seq(30,200,by=10),seq(220,1000,by=20))
  tf_panel(c('Prvních 50 pokusů','Celých 1 000 pokusů')[k],'čárový graf','Počet dosavadních pokusů','Relativní četnost správných tipů',xlim=c(1,m),ylim=c(0,if(k==1) 1 else .5),
    guides=list(tf_guide('y',ch5_pi,'pravděpodobnost 0,25')),note=if(k==2 && any(ch5_runs>.5)) 'Hodnoty nad 0,5 (jen v prvních pokusech) leží nad horním okrajem grafu.',
    series=lapply(1:5,function(j) tf_series(paste0('Řada ',j),data.frame(x=i,y=ch5_runs[i,j]),'cara',digits=3))) }))
ch5_draw('karticky', {
  par(mar=c(.6,.6,2.4,.6))
  plot(NA,xlim=c(0,14.6),ylim=c(-.2,10.2),axes=FALSE,xlab='',ylab='',asp=1,main='Sto kartiček se slovy: 100 možných výsledků')
  kind <- rep(1:3,ch5_cards); fills <- c(ch5_fill,ch5_sand,ch5_pale); lab <- c('P','S','A')
  for(i in 0:99) {
    x <- i%%10; y <- 9-i%/%10
    rect(x+.06,y+.06,x+.94,y+.94,col=fills[kind[i+1]],border='#7F929C')
    text(x+.5,y+.5,lab[kind[i+1]],cex=.72)
  }
  rect(2.03,8.03,2.97,8.97,border=ch5_orange,lwd=3)
  arrows(10.6,9.2,3.1,8.6,length=.09,col=ch5_orange,lwd=1.6)
  text(10.7,9.2,'jedna kartička\n= jeden výsledek',adj=0,cex=.82,col=ch5_orange)
  rect(10.7,5.5+.06,11.4,6.2,col=fills[1],border='#7F929C'); text(11.6,5.87,'P: podstatné jméno, 40',adj=0,cex=.82)
  rect(10.7,4.5+.06,11.4,5.2,col=fills[2],border='#7F929C'); text(11.6,4.87,'S: sloveso, 35',adj=0,cex=.82)
  rect(10.7,3.5+.06,11.4,4.2,col=fills[3],border='#7F929C'); text(11.6,3.87,'A: přídavné jméno, 25',adj=0,cex=.82)
  text(10.7,2.2,'Jev „podstatné jméno“\nobsahuje 40 výsledků.',adj=0,cex=.82)
},width=8.6,height=5.6)
ch5_fig('karticky','data',note='Mřížka 10 × 10 čtverečků (kartiček) zaplněná po řádcích zleva doprava a shora dolů: nejprve 40 kartiček P (světle modré), potom 35 kartiček S (světle oranžové) a 25 kartiček A (světle šedé). Třetí kartička ve druhém řádku je oranžově orámovaná a šipka k ní nese popisek „jedna kartička = jeden výsledek“. Vpravo je legenda a text, že jev „podstatné jméno“ obsahuje 40 výsledků.',panels=list(
  tf_panel('Sto kartiček se slovy: 100 možných výsledků','tabulka',
    series=list(tf_series('Složení kartiček',data.frame(oznaceni=c('P','S','A'),slovni_druh=c('podstatné jméno','sloveso','přídavné jméno'),cetnost=as.numeric(ch5_cards)),'tabulka')))))
# Mosaic of a 2 x 2 table: rows have equal height, widths show row proportions.
ch5_mosaic <- function(tab,highlight,main,dim_row=integer(0)) {
  plot(NA,xlim=c(-.19,1),ylim=c(-.02,1.12),axes=FALSE,xlab='',ylab='',main=main)
  for(r in 1:2) {
    y1 <- 1-(r-1)*.5; y0 <- y1-.5; w <- tab[r,1]/sum(tab[r,])
    xs <- list(c(0,w),c(w,1))
    for(cc in 1:2) {
      on <- highlight[r,cc]; faded <- r %in% dim_row
      rect(xs[[cc]][1],y0+.01,xs[[cc]][2],y1-.01,col=if(on) ch5_fill else if(faded) 'white' else ch5_pale,border=if(faded) '#B5C1C8' else '#223744',lwd=if(on) 2.4 else 1,lty=if(faded) 3 else 1)
      text(mean(xs[[cc]]),(y0+y1)/2,tab[r,cc],cex=1.15,font=if(on) 2 else 1,col=if(faded) '#8A99A2' else '#223744')
    }
    text(-.03,(y0+y1)/2,rownames(tab)[r],adj=1,cex=.95,col=if(r %in% dim_row) '#8A99A2' else '#223744')
  }
  text(tab[1,1]/sum(tab[1,])/2,1.06,colnames(tab)[1],cex=.95); text((1+tab[1,1]/sum(tab[1,]))/2,1.06,colnames(tab)[2],cex=.95)
}
# The same mosaic as a tutor panel: one row per cell, with the arguments of ch5_mosaic().
ch5_mosaic_panel <- function(tab,highlight,main,note,dim_row=integer(0)) {
  r <- rep(1:2,each=2)
  tf_panel(main,'tabulka',note=note,series=list(tf_series('Pole tabulky',data.frame(pohlavi=rownames(tab)[r],stres=rep(colnames(tab),2),cetnost=as.vector(t(tab)),podil_v_radku=as.vector(t(tab/rowSums(tab))),
    zvyrazneno=ifelse(as.vector(t(highlight)),'ano',ifelse(r %in% dim_row,'potlačeno','ne'))),'tabulka')))
}
ch5_mosaic_note <- 'Dva panely vedle sebe, každý s tabulkou 2 × 2 nakreslenou jako mozaika: oba řádky jsou stejně vysoké a šířka pole odpovídá podílu v řádku. V každém poli je jeho četnost; zvýrazněná pole jsou světle modrá se silným obrysem a tučným číslem, ostatní světle šedá. Pod každým panelem je řádek s výpočtem, který uvádí poznámka k panelu.'
ch5_draw('prunik-sjednoceni', {
  par(mfrow=c(1,2),mar=c(2.6,.6,2.6,.6))
  ch5_mosaic(ch5_dependent,matrix(c(TRUE,FALSE,FALSE,FALSE),2,byrow=TRUE),'Průnik: žena a zároveň zvýšený stres')
  mtext('40 z 200, tedy 0,20',1,line=.6,cex=.9)
  ch5_mosaic(ch5_dependent,matrix(c(TRUE,TRUE,TRUE,FALSE),2,byrow=TRUE),'Sjednocení: žena nebo zvýšený stres')
  mtext('40 + 60 + 30 = 130 z 200, tedy 0,65',1,line=.6,cex=.9)
},width=10,height=4.2)
ch5_fig('prunik-sjednoceni','data',note=ch5_mosaic_note,panels=list(
  ch5_mosaic_panel(ch5_dependent,matrix(c(TRUE,FALSE,FALSE,FALSE),2,byrow=TRUE),'Průnik: žena a zároveň zvýšený stres','40 z 200, tedy 0,20'),
  ch5_mosaic_panel(ch5_dependent,matrix(c(TRUE,TRUE,TRUE,FALSE),2,byrow=TRUE),'Sjednocení: žena nebo zvýšený stres','40 + 60 + 30 = 130 z 200, tedy 0,65')))
ch5_draw('podmineni', {
  par(mfrow=c(1,2),mar=c(2.6,.6,2.6,.6))
  ch5_mosaic(ch5_dependent,matrix(c(TRUE,FALSE,TRUE,FALSE),2,byrow=TRUE),'Celek: všech 200 studentů')
  mtext('P(zvýšený stres) = 70/200 = 0,35',1,line=.6,cex=.9)
  ch5_mosaic(ch5_dependent,matrix(c(TRUE,FALSE,FALSE,FALSE),2,byrow=TRUE),'Podmínka: jen 100 žen',dim_row=2)
  mtext('P(zvýšený stres | žena) = 40/100 = 0,40',1,line=.6,cex=.9)
},width=10,height=4.2)
ch5_fig('podmineni','data',note=paste(ch5_mosaic_note,'V pravém panelu jsou pole řádku „Muž“ (v datech „potlačeno“) vybledlá: bílá, s tečkovaným obrysem a šedým písmem.'),panels=list(
  ch5_mosaic_panel(ch5_dependent,matrix(c(TRUE,FALSE,TRUE,FALSE),2,byrow=TRUE),'Celek: všech 200 studentů','P(zvýšený stres) = 70/200 = 0,35'),
  ch5_mosaic_panel(ch5_dependent,matrix(c(TRUE,FALSE,FALSE,FALSE),2,byrow=TRUE),'Podmínka: jen 100 žen','P(zvýšený stres | žena) = 40/100 = 0,40',dim_row=2)))
ch5_draw('nezavislost', {
  par(mfrow=c(1,2),mar=c(3.6,.6,2.6,.6))
  ch5_mosaic(ch5_independent,matrix(c(TRUE,FALSE,TRUE,FALSE),2,byrow=TRUE),'Nezávislost: v obou řádcích 30 %')
  mtext('P(zvýšený stres | žena) = P(zvýšený stres | muž)',1,line=.6,cex=.9); mtext('= P(zvýšený stres) = 0,30',1,line=1.8,cex=.9)
  ch5_mosaic(ch5_dependent,matrix(c(TRUE,FALSE,TRUE,FALSE),2,byrow=TRUE),'Závislost: 40 % a 30 %')
  mtext('P(zvýšený stres | žena) = 0,40',1,line=.6,cex=.9); mtext('P(zvýšený stres | muž) = 0,30',1,line=1.8,cex=.9)
},width=10,height=4.2)
ch5_fig('nezavislost','data',note=paste(ch5_mosaic_note,'Levý panel ukazuje jinou tabulku (nezávislost) než pravý (závislost); hranice mezi poli je vlevo v obou řádcích na stejném místě, vpravo je posunutá.'),panels=list(
  ch5_mosaic_panel(ch5_independent,matrix(c(TRUE,FALSE,TRUE,FALSE),2,byrow=TRUE),'Nezávislost: v obou řádcích 30 %','P(zvýšený stres | žena) = P(zvýšený stres | muž) = P(zvýšený stres) = 0,30'),
  ch5_mosaic_panel(ch5_dependent,matrix(c(TRUE,FALSE,TRUE,FALSE),2,byrow=TRUE),'Závislost: 40 % a 30 %','P(zvýšený stres | žena) = 0,40; P(zvýšený stres | muž) = 0,30')))
ch5_box <- function(x,y,w,h,label,fill='white',lwd=1,cex=.86) { rect(x-w/2,y-h/2,x+w/2,y+h/2,col=fill,border='#223744',lwd=lwd); text(x,y,label,cex=cex) }
ch5_draw('strom', {
  par(mar=c(.4,.4,.4,.4))
  f <- ch5_screen(1000,.10)
  plot(NA,xlim=c(0,10),ylim=c(0,7),axes=FALSE,xlab='',ylab='')
  ch5_box(5,6.3,2.6,.8,'1 000 studentů')
  ch5_box(2.5,4.2,3,.9,paste0(f['present'],'\nporucha přítomna')); ch5_box(7.5,4.2,3,.9,paste0(f['absent'],'\nporucha nepřítomna'))
  segments(5,5.9,2.5,4.65); segments(5,5.9,7.5,4.65)
  text(3.4,5.45,'0,10\n(prevalence)',cex=.8,adj=1); text(6.6,5.45,'0,90\n(1 − prevalence)',cex=.8,adj=0)
  xs <- c(1.15,3.85,6.15,8.85); labs <- c(paste0(f['tp'],'\npozitivní'),paste0(f['fn'],'\nnegativní'),paste0(f['fp'],'\npozitivní'),paste0(f['tn'],'\nnegativní'))
  for(i in 1:4) { ch5_box(xs[i],2,2.1,.9,labs[i],fill=if(i %in% c(1,3)) ch5_fill else 'white',lwd=if(i %in% c(1,3)) 2.2 else 1); segments(c(2.5,2.5,7.5,7.5)[i],3.75,xs[i],2.45) }
  text(c(1.65,6.65),3.12,c('0,95\n(senzitivita)','0,10\n(1 − specificita)'),cex=.76,adj=1)
  text(c(3.35,8.35),3.12,c('0,05\n(1 − senzitivita)','0,90\n(specificita)'),cex=.76,adj=0)
  text(5,.75,'Pozitivní výsledek má 95 + 90 = 185 studentů; poruchu z nich má 95.',cex=.9)
  text(5,.25,'Prediktivní hodnota pozitivního testu: 95/185 = 0,514',cex=.9,font=2)
},width=8.6,height=5.4)
ch5_fig('strom','data',note='Strom shora dolů: kořen, dvě větve podle přítomnosti poruchy a z každé dvě větve podle výsledku testu. V rámečcích jsou četnosti, u větví pravděpodobnosti s názvem v závorce. Rámečky pozitivních výsledků jsou světle modré se silným obrysem. Pod stromem jsou dva řádky textu, které uvádí poznámka k panelu; druhý je tučně.',panels=list(local({
  f <- ch5_screen(1000,.10); poz <- f[['tp']]+f[['fp']]
  tf_panel('Strom přirozených četností: 1 000 studentů a výsledek testu','tabulka',
    note=paste0('Pozitivní výsledek má ',ch5_num(f[['tp']],0),' + ',ch5_num(f[['fp']],0),' = ',ch5_num(poz,0),' studentů; poruchu z nich má ',ch5_num(f[['tp']],0),'. Prediktivní hodnota pozitivního testu: ',ch5_num(f[['tp']],0),'/',ch5_num(poz,0),' = ',ch5_num(ch5_ppv(f)),'.'),
    series=list(tf_series('Uzly stromu',data.frame(uroven=c(1,2,2,3,3,3,3),
      uzel=c('všichni studenti','porucha přítomna','porucha nepřítomna','porucha přítomna, pozitivní','porucha přítomna, negativní','porucha nepřítomna, pozitivní','porucha nepřítomna, negativní'),
      rodic=c('','všichni studenti','všichni studenti','porucha přítomna','porucha přítomna','porucha nepřítomna','porucha nepřítomna'),
      cetnost=c(1000,f[['present']],f[['absent']],f[['tp']],f[['fn']],f[['fp']],f[['tn']]),pravdepodobnost_vetve=c(NA,.10,.90,ch5_sens,1-ch5_sens,1-ch5_spec,ch5_spec),
      vyznam_vetve=c('','prevalence','1 − prevalence','senzitivita','1 − senzitivita','1 − specificita','specificita'),zvyrazneno=c('ne','ne','ne','ano','ne','ano','ne')),'tabulka',
      note='řádky v pořadí shora dolů a zleva doprava; kořen nemá větev'))) })))
ch5_draw('dve-prevalence', {
  par(mar=c(4.5,10.5,2.6,1))
  a <- ch5_screen(10000,.10); b <- ch5_screen(10000,.01)
  plot(NA,xlim=c(0,2600),ylim=c(.3,2.9),yaxt='n',xlab='Počet pozitivních výsledků z 10 000 testovaných',ylab='',bty='l',main='Stejný test, různá prevalence')
  axis(2,at=c(2.2,1),labels=c('Prevalence 10 %\n(poradna)','Prevalence 1 %\n(plošný screening)'),tick=FALSE)
  for(k in 1:2) {
    f <- list(a,b)[[k]]; y <- c(2.2,1)[k]
    rect(0,y-.28,f['tp'],y+.28,col=ch5_blue,border='white'); rect(f['tp'],y-.28,f['tp']+f['fp'],y+.28,col=ch5_sand,border='#223744')
    text(f['tp']/2,y+.45,f['tp'],cex=.9,col=ch5_blue); text(f['tp']+f['fp']/2,y,f['fp'],cex=.9)
    text(f['tp']+f['fp']+30,y,paste0('prediktivní hodnota\npozitivního testu ',ch5_num(ch5_ppv(f))),adj=0,cex=.9,font=2,xpd=NA)
  }
  legend('topright',c('správně pozitivní','falešně pozitivní'),fill=c(ch5_blue,ch5_sand),bty='n',cex=.85,inset=c(0,-.02))
},width=9,height=4.2)
ch5_fig('dve-prevalence','sloupce',note='V obrázku jsou pruhy vodorovné: kategorie leží na svislé ose (nahoře prevalence 10 %, dole 1 %) a četnosti na vodorovné ose. Každý pruh se skládá z modré části (správně pozitivní) a na ni navazující světlé části (falešně pozitivní); u částí jsou jejich četnosti a vpravo od pruhu tučně prediktivní hodnota pozitivního testu. Legenda je vpravo nahoře.',panels=list(local({
  a <- ch5_screen(10000,.10); b <- ch5_screen(10000,.01); kat <- c('Prevalence 10 % (poradna)','Prevalence 1 % (plošný screening)')
  tf_panel('Stejný test, různá prevalence','sloupcový graf','Prevalence (prostředí)','Počet pozitivních výsledků z 10 000 testovaných',ylim=c(0,2600),
    series=list(tf_series('Pozitivní výsledky',data.frame(kategorie=rep(kat,each=2),skupina=rep(c('správně pozitivní','falešně pozitivní'),2),y=c(a[['tp']],a[['fp']],b[['tp']],b[['fp']])),'sloupce',arrangement='skládané'),
      tf_series('Prediktivní hodnota pozitivního testu (popisek u pruhu)',data.frame(kategorie=kat,prediktivni_hodnota=c(ch5_ppv(a),ch5_ppv(b))),'tabulka',digits=3))) })))
ch5_draw('rozdeleni-model-data', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.7))
  k <- 0:ch5_n; p <- dbinom(k,ch5_n,ch5_pi); obs <- as.numeric(table(factor(ch5_sim_hadani,levels=k)))/length(ch5_sim_hadani)
  plot(k,p,type='h',lwd=9,lend=1,col=ch5_blue,xlim=c(-.4,5.4),ylim=c(0,.5),xlab='Počet správných tipů z pěti',ylab='Pravděpodobnost',main='Model: rozdělení pravděpodobnosti',bty='l')
  text(k,p+.03,ch5_num(p),cex=.74)
  plot(k,obs,type='h',lwd=9,lend=1,col=ch5_gray,xlim=c(-.4,5.4),ylim=c(0,.5),xlab='Počet správných tipů z pěti',ylab='Relativní četnost',main='Data: 40 simulovaných studentů',bty='l')
  text(k,obs+.03,ch5_num(obs),cex=.74)
},width=10,height=4.4)
ch5_fig('rozdeleni-model-data','simulace',note='Dva panely vedle sebe se stejnými osami; sloupce jsou úzké svislé úsečky a nad každým je jeho hodnota. Vlevo modře přesné binomické pravděpodobnosti pro n = 5 a π = 0,25, vpravo šedě relativní četnosti ve výběru 40 simulovaných studentů.',panels=local({
  k <- 0:ch5_n; p <- dbinom(k,ch5_n,ch5_pi); cnt <- as.numeric(table(factor(ch5_sim_hadani,levels=k)))
  list(tf_panel('Model: rozdělení pravděpodobnosti','sloupcový graf','Počet správných tipů z pěti','Pravděpodobnost',xlim=c(-.4,5.4),ylim=c(0,.5),
      series=list(tf_series('Binomické pravděpodobnosti',data.frame(x=k,y=p),'sloupce',digits=4))),
    tf_panel('Data: 40 simulovaných studentů','sloupcový graf','Počet správných tipů z pěti','Relativní četnost',xlim=c(-.4,5.4),ylim=c(0,.5),
      series=list(tf_series('Relativní četnosti',data.frame(x=k,y=cnt/length(ch5_sim_hadani),cetnost=cnt),'sloupce',digits=4)))) }))
# Two guesses with four options: from the random experiment to the distribution of X.
ch5_two <- c(NN=.75*.75,NS=.75*.25,SN=.25*.75,SS=.25*.25)
ch5_two_dist <- c(ch5_two['NN'],ch5_two['NS']+ch5_two['SN'],ch5_two['SS'])
ch5_draw('od-pokusu-k-rozdeleni', {
  par(mar=c(.3,.3,.3,.3))
  plot(NA,xlim=c(0,10),ylim=c(0,10),axes=FALSE,xlab='',ylab='')
  ink <- '#223744'
  # Random experiment
  rect(1.5,9.27,8.5,9.85,col=ch5_pale,border=ink)
  text(5,9.56,'Náhodný pokus: tip na dvě otázky se čtyřmi možnostmi (π = 0,25)',cex=.9,font=2)
  arrows(5,9.27,5,8.98,length=.07,col=ink)
  # Sample space
  rect(.15,5.55,9.85,8.95,border=ink,lwd=1.3)
  text(.35,8.72,'Výběrový prostor: všechny možné výsledky',adj=0,cex=.88,font=2)
  text(9.65,8.72,'jistý jev, součet pravděpodobností:',adj=1,cex=.74,col=ch5_gray)
  text(9.65,8.45,'0,5625 + 0,1875 + 0,1875 + 0,0625 = 1',adj=1,cex=.74,col=ch5_gray)
  # Event A = {X = 1}
  rect(2.85,5.72,7.15,8.25,col='#EEF6F9',border=ch5_blue,lty=2,lwd=1.5)
  text(5,6.72,'Jev A = {X = 1}: právě jedna správná odpověď',cex=.8,font=2,col=ch5_blue)
  text(5,6.33,'P(A) = 0,1875 + 0,1875 = 0,375',cex=.8,col=ch5_blue)
  text(5,5.97,'Tentýž jev jako X = 1, proto P(A) = P(X = 1).',cex=.76,col=ch5_blue)
  # Outcomes
  xs <- c(NN=1.4,NS=4,SN=6,SS=8.6)
  calc <- c(NN='0,75 × 0,75 = 0,5625',NS='0,75 × 0,25 = 0,1875',SN='0,25 × 0,75 = 0,1875',SS='0,25 × 0,25 = 0,0625')
  for(o in names(xs)) {
    hl <- o=='NN'
    rect(xs[o]-.98,7.07,xs[o]+.98,8.02,col='white',border=if(hl) ch5_orange else ink,lwd=if(hl) 2.6 else 1)
    text(xs[o],7.75,o,cex=1.05,font=2)
    text(xs[o],7.33,calc[o],cex=.7)
  }
  text(xs['NN'],8.25,'jeden výsledek',cex=.8,col=ch5_orange,font=2)
  text(xs['SS'],6.9,'S = správně, N = nesprávně',cex=.68,col=ch5_gray)
  # Random variable: rule and values
  vx <- c(1.4,5,8.6); tgt <- c(NN=1,NS=2,SN=2,SS=3)
  for(o in names(xs)) arrows(xs[o],5.55,vx[tgt[o]],4.3,length=.08,col=ink,lwd=1.2)
  text(2.95,5.08,'náhodná proměnná X (pravidlo):',cex=.78,font=2)
  text(2.95,4.78,'počet správných odpovědí',cex=.78)
  for(i in 1:3) { rect(vx[i]-.42,3.73,vx[i]+.42,4.28,col=ch5_sand,border=ink); text(vx[i],4.0,i-1,cex=1.05,font=2) }
  text(3.2,4.0,'hodnoty náhodné proměnné',cex=.74,font=3,col=ch5_gray)
  text(6.8,4.0,'hodnoty náhodné proměnné',cex=.74,font=3,col=ch5_gray)
  # Distribution
  text(.35,3.3,'Rozdělení pravděpodobnosti X',adj=0,cex=.88,font=2)
  text(9.65,3.3,'součet: 0,5625 + 0,375 + 0,0625 = 1',adj=1,cex=.74,col=ch5_gray)
  segments(.3,.55,9.7,.55,col=ink)
  h <- ch5_two_dist*3.6
  lab <- c('P(X = 0) = 0,5625','P(X = 1) = 0,1875 + 0,1875 = 0,375','P(X = 2) = 0,0625')
  for(i in 1:3) {
    rect(vx[i]-.45,.55,vx[i]+.45,.55+h[i],col=if(i==2) ch5_fill else ch5_pale,border=ink,lwd=if(i==2) 2 else 1)
    text(vx[i],.55+h[i]+.22,lab[i],cex=.78,font=if(i==2) 2 else 1)
    text(vx[i],.3,paste0('X = ',i-1),cex=.78)
  }
},width=9,height=8)
ch5_fig('od-pokusu-k-rozdeleni','data',note='Schéma shora dolů. Rámeček náhodného pokusu: tip na dvě otázky se čtyřmi možnostmi (π = 0,25). Pod ním rámeček výběrového prostoru se čtyřmi výsledky NN, NS, SN, SS (S = správně, N = nesprávně) a výpočtem jejich pravděpodobností; výsledek NN je oranžově orámován s popiskem „jeden výsledek“, výsledky NS a SN obklopuje modrý přerušovaný rámeček jevu A = {X = 1}. Od výsledků vedou šipky k hodnotám 0, 1, 2 náhodné proměnné X (pravidlo: počet správných odpovědí). Dole je sloupcový graf rozdělení pravděpodobnosti X bez svislé osy.',panels=list(
  tf_panel('Výběrový prostor: všechny možné výsledky','tabulka',
    note='Jistý jev, součet pravděpodobností: 0,5625 + 0,1875 + 0,1875 + 0,0625 = 1. Jev A = {X = 1}, právě jedna správná odpověď: P(A) = 0,1875 + 0,1875 = 0,375; je to tentýž jev jako X = 1, proto P(A) = P(X = 1).',
    series=list(tf_series('Výsledky náhodného pokusu',data.frame(vysledek=names(ch5_two),vypocet=c('0,75 × 0,75','0,75 × 0,25','0,25 × 0,75','0,25 × 0,25'),pravdepodobnost=as.numeric(ch5_two),
      hodnota_x=c(0,1,1,2),jev_a=c('ne','ano','ano','ne')),'tabulka',digits=4,note='šipka vede od výsledku k jeho hodnotě X'))),
  tf_panel('Rozdělení pravděpodobnosti X','sloupcový graf','Hodnota náhodné proměnné X (počet správných odpovědí)','Pravděpodobnost',
    note='Nad sloupci jsou popisky P(X = 0) = 0,5625, P(X = 1) = 0,1875 + 0,1875 = 0,375 a P(X = 2) = 0,0625; součet: 0,5625 + 0,375 + 0,0625 = 1. Sloupec X = 1 je zvýrazněn světle modrou výplní, silným obrysem a tučným popiskem.',
    series=list(tf_series('P(X = x)',data.frame(x=0:2,y=as.numeric(ch5_two_dist),zvyrazneno=c('ne','ano','ne')),'sloupce',digits=4)))))
ch5_draw('kombinace', {
  par(mar=c(.5,.5,2.4,.5))
  cmb <- combn(5,2)
  plot(NA,xlim=c(-.4,12.4),ylim=c(-.2,6.2),axes=FALSE,xlab='',ylab='',main='Deset způsobů, jak mít právě 2 z 5 tipů správně')
  for(j in 1:10) {
    x0 <- ((j-1)%/%5)*6.6; y <- 5-(j-1)%%5
    text(x0-.1,y,paste0(j,'.'),adj=1,cex=.85)
    for(q in 1:5) {
      hit <- q %in% cmb[,j]
      symbols(x0+q*.95,y,circles=.33,inches=FALSE,add=TRUE,bg=if(hit) ch5_blue else 'white',fg='#223744')
      text(x0+q*.95,y,if(hit) 'S' else 'N',cex=.74,col=if(hit) 'white' else '#223744')
    }
  }
  text(6,-.05,'S = správně, N = nesprávně; pořadí kroužků odpovídá otázkám 1 až 5.',cex=.82)
},width=8.6,height=4.8)
ch5_fig('kombinace','data',note='Deset řádků po pěti kroužcích ve dvou sloupcích (vlevo způsoby 1 až 5, vpravo 6 až 10). Kroužek správně zodpovězené otázky je modře vyplněný s bílým písmenem S, kroužek nesprávně zodpovězené otázky bílý s písmenem N; pořadí kroužků odpovídá otázkám 1 až 5.',panels=list(local({
  cmb <- combn(5,2); m <- t(vapply(1:10,function(j) ifelse(1:5 %in% cmb[,j],'S','N'),character(5)))
  tf_panel('Deset způsobů, jak mít právě 2 z 5 tipů správně','tabulka',note='S = správně, N = nesprávně.',
    series=list(tf_series('Způsoby',data.frame(zpusob=1:10,otazka_1=m[,1],otazka_2=m[,2],otazka_3=m[,3],otazka_4=m[,4],otazka_5=m[,5],spravne_otazky=apply(cmb,2,paste,collapse=' a ')),'tabulka'))) })))
ch5_bars <- function(n,p,main,highlight=NULL,xlim=NULL,ylim=NULL,lwd=7) {
  k <- 0:n; pr <- dbinom(k,n,p)
  if(is.null(xlim)) xlim <- c(0,n)
  if(is.null(ylim)) ylim <- c(0,max(pr)*1.18)
  col <- rep(ch5_blue,length(k)); if(!is.null(highlight)) col <- ifelse(k %in% highlight,ch5_orange,'#A9BAC3')
  plot(k,pr,type='h',lwd=lwd,lend=1,col=col,xlim=xlim,ylim=ylim,xlab='Počet úspěchů k',ylab='Pravděpodobnost',main=main,bty='l')
}
# The bars of ch5_bars() as a tutor panel; `k` limits the listed bars to the plotted x range, `extra` adds further series.
ch5_bars_panel <- function(n,p,main,highlight=NULL,xlim=c(0,n),ylim,k=0:n,extra=NULL,...) {
  d <- data.frame(x=k,y=dbinom(k,n,p)); if(!is.null(highlight)) d$zvyrazneno <- ifelse(k %in% highlight,'ano','ne')
  tf_panel(main,'sloupcový graf','Počet úspěchů k','Pravděpodobnost',xlim=xlim,ylim=ylim,series=c(list(tf_series(paste0('Binomické pravděpodobnosti, n = ',n,', π = ',ch5_num(p,2)),d,'sloupce',digits=4)),extra),...)
}
ch5_normal_series <- function(n,p,from,to,points) tf_curve(paste0('Normální křivka, μ = nπ = ',ch5_num(n*p,0),', σ = √(nπ(1 − π)) = ',ch5_num(sqrt(n*p*(1-p)),2)),function(x) dnorm(x,n*p,sqrt(n*p*(1-p))),from,to,points)
ch5_draw('binomicke-tvar', {
  par(mfrow=c(2,2),mar=c(4.3,4.6,2.5,.6))
  ch5_bars(5,.25,'n = 5, π = 0,25',ylim=c(0,.45),lwd=10)
  ch5_bars(20,.25,'n = 20, π = 0,25',ylim=c(0,.45))
  ch5_bars(20,.5,'n = 20, π = 0,50',ylim=c(0,.45))
  ch5_bars(20,.9,'n = 20, π = 0,90',ylim=c(0,.45))
},width=9.4,height=6.6)
ch5_fig('binomicke-tvar','sloupce',note='Čtyři panely ve dvou řadách po dvou se stejným rozsahem svislé osy; binomické pravděpodobnosti jsou nakresleny jako modré úzké svislé sloupce.',panels=list(
  ch5_bars_panel(5,.25,'n = 5, π = 0,25',ylim=c(0,.45)),ch5_bars_panel(20,.25,'n = 20, π = 0,25',ylim=c(0,.45)),
  ch5_bars_panel(20,.5,'n = 20, π = 0,50',ylim=c(0,.45)),ch5_bars_panel(20,.9,'n = 20, π = 0,90',ylim=c(0,.45))))
ch5_draw('binom-oblasti', {
  par(mfrow=c(1,3),mar=c(4.5,4.2,2.6,.5),mgp=c(2.5,.6,0),cex=.85)
  ch5_bars(20,.25,'Právě 5',highlight=5,ylim=c(0,.24),lwd=5); text(13,.2,ch5_num(dbinom(5,20,.25)),cex=1.05,col=ch5_orange)
  ch5_bars(20,.25,'Nejvýše 5',highlight=0:5,ylim=c(0,.24),lwd=5); text(13,.2,ch5_num(pbinom(5,20,.25)),cex=1.05,col=ch5_orange)
  ch5_bars(20,.25,'Alespoň 10',highlight=10:20,ylim=c(0,.24),lwd=5); text(13,.2,ch5_num(1-pbinom(9,20,.25)),cex=1.05,col=ch5_orange)
},width=10,height=3.9)
ch5_fig('binom-oblasti','sloupce',note='Tři panely vedle sebe s týmž binomickým rozdělením (n = 20, π = 0,25). Zvýrazněné sloupce jsou oranžové, ostatní šedé; oranžové číslo v panelu je součet zvýrazněných pravděpodobností.',panels=list(
  ch5_bars_panel(20,.25,'Právě 5',highlight=5,ylim=c(0,.24),note=paste0('Pravděpodobnost zvýrazněného sloupce: ',ch5_num(dbinom(5,20,.25)),'.')),
  ch5_bars_panel(20,.25,'Nejvýše 5',highlight=0:5,ylim=c(0,.24),note=paste0('Součet zvýrazněných sloupců: ',ch5_num(pbinom(5,20,.25)),'.')),
  ch5_bars_panel(20,.25,'Alespoň 10',highlight=10:20,ylim=c(0,.24),note=paste0('Součet zvýrazněných sloupců: ',ch5_num(1-pbinom(9,20,.25)),'.'))))
ch5_draw('aproximace', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.7))
  ch5_bars(20,.05,'n = 20, π = 0,05: podmínka nesplněna',xlim=c(-3,8),ylim=c(0,.45),lwd=9)
  curve(dnorm(x,20*.05,sqrt(20*.05*.95)),from=-3,to=8,add=TRUE,col=ch5_blue,lwd=2,lty=2,n=400)
  abline(v=0,lty=3,col=ch5_gray); text(-1.6,.3,'záporný počet
není možný',cex=.78,col=ch5_gray)
  ch5_bars(200,.6,'n = 200, π = 0,60: podmínka splněna',highlight=135:200,xlim=c(95,145),ylim=c(0,.066),lwd=3)
  curve(dnorm(x,200*.6,sqrt(200*.6*.4)),from=95,to=145,add=TRUE,col=ch5_blue,lwd=2,lty=2,n=400)
  text(139,.03,'135\na více',cex=.82,col=ch5_orange)
  legend('topleft',c('binomické pravděpodobnosti','normální křivka'),lty=c(1,2),lwd=c(4,2),col=c('#A9BAC3',ch5_blue),bty='n',cex=.74)
},width=10,height=4.4)
ch5_fig('aproximace','sloupce',note='Dva panely vedle sebe: binomické pravděpodobnosti jako svislé sloupce a přes ně modrá přerušovaná normální křivka se stejnou střední hodnotou a směrodatnou odchylkou. Vlevo jsou sloupce modré a tečkovaná svislá čára v nule nese popisek „záporný počet není možný“. Vpravo jsou sloupce pro 135 a více úspěchů oranžové (popisek „135 a více“), ostatní šedé; legenda rozlišuje binomické pravděpodobnosti a normální křivku.',panels=list(
  ch5_bars_panel(20,.05,'n = 20, π = 0,05: podmínka nesplněna',xlim=c(-3,8),ylim=c(0,.45),k=0:8,extra=list(ch5_normal_series(20,.05,-3,8,67)),
    guides=list(tf_guide('x',0,'záporný počet není možný')),note='Sloupce pro více než 8 úspěchů leží mimo zobrazený rozsah a nejsou uvedeny; jejich pravděpodobnosti jsou téměř nulové.'),
  ch5_bars_panel(200,.6,'n = 200, π = 0,60: podmínka splněna',highlight=135:200,xlim=c(95,145),ylim=c(0,.066),k=95:145,extra=list(ch5_normal_series(200,.6,95,145,61)),
    note='Uvedeny jsou sloupce v zobrazeném rozsahu 95 až 145 úspěchů; pravděpodobnosti ostatních jsou téměř nulové.')))
options(ch5_old_options)
