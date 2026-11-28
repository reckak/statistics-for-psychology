# Original teaching examples; base R, UTF-8, deterministic project-root paths.
ch4_data <- read.csv('data/kapitola_04.csv', fileEncoding='UTF-8')
ch4_x <- ch4_data$skor_body
ch4_p <- (seq_along(ch4_x)-.5)/length(ch4_x)
ch4_z <- qnorm(ch4_p)
ch4_reference <- mean(ch4_x)+sd(ch4_x)*ch4_z
ch4_sten_breaks <- c(-Inf,seq(-2,2,.5),Inf)
ch4_stanine_breaks <- c(-Inf,seq(-1.75,1.75,.5),Inf)
ch4_sten <- function(z) as.integer(cut(z,ch4_sten_breaks,right=TRUE))
ch4_stanine <- function(z) as.integer(cut(z,ch4_stanine_breaks,right=TRUE))
ch4_sten_proportions <- diff(pnorm(ch4_sten_breaks))
ch4_stanine_proportions <- diff(pnorm(ch4_stanine_breaks))
ch4_out <- 'assets/chapter-04/plots'
ch4_old_options <- options(OutDec=',')
dir.create(ch4_out,recursive=TRUE,showWarnings=FALSE)
ch4_blue <- '#245D78'; ch4_orange <- '#B54E24'; ch4_fill <- '#B8DDE8'; ch4_gray <- '#4D5A63'
ch4_draw <- function(name,code,width=8,height=4.5) {
  svg(file.path(ch4_out,paste0(name,'.svg')),width=width,height=height,family='sans',bg='white')
  par(mar=c(4.5,4.5,2.6,.8),mgp=c(2.7,.7,0),las=1,col.axis='#223744',col.lab='#223744',fg='#223744',cex=.9)
  force(code); dev.off()
}
# Data and descriptions of the figures for the AI tutor (tmp/tutor-figures/kapitola_04/); see scripts/tutor/figure-data.R.
source('scripts/tutor/figure-data.R',encoding='UTF-8')
source('scripts/figure-labels.R',encoding='UTF-8')   # statistical symbols in the math font (R89)
ch4_fig <- function(...) tf_figure('kapitola_04',...)
ch4_num <- function(x,digits=2) sub('^-','−',formatC(x,format='f',digits=digits,decimal.mark=','))
# Series of the model N(50, 10) shared by the figure records: the density curve and a shaded area under it.
ch4_tf_density <- function(from=10,to=90,n=41) tf_curve('Hustota normálního modelu N(50, 10)',function(x) dnorm(x,50,10),from,to,n)
ch4_tf_area <- function(name,from,to,n=max(11,ceiling((to-from)/2)+1)) tf_curve(name,function(x) dnorm(x,50,10),from,to,n,mark='plocha')
ch4_curve <- function(mu=50,sigma=10,main='',xlim=c(10,90),ylim=c(0,.044)) {
  x <- seq(xlim[1],xlim[2],length.out=1001)
  plot(x,dnorm(x,mu,sigma),type='l',lwd=2.3,col=ch4_blue,xlab='Skór pozornosti (body)',ylab='Hustota (na bod)',main=main,xlim=xlim,ylim=ylim,bty='l')
}
ch4_area <- function(lower,upper,mu=50,sigma=10,fill=ch4_fill) {
  v <- seq(max(lower,mu-4*sigma),min(upper,mu+4*sigma),length.out=400)
  polygon(c(v[1],v,tail(v,1)),c(0,dnorm(v,mu,sigma),0),col=fill,border=NA)
  curve(dnorm(x,mu,sigma),add=TRUE,lwd=2.3,col=ch4_blue)
}
ch4_draw('standardizace', {
  par(mfrow=c(2,1),mar=c(3.5,3.5,2.1,1))
  v <- c(4,5,5,6,10); z <- (v-mean(v))/sd(v); h <- c(1,1,1.25,1,1)
  for(k in 1:2) {
    a <- if(k==1) v else z
    plot(a,h,pch=19,cex=1.35,col=ch4_blue,yaxt='n',ylab='',ylim=c(.6,1.6),xlim=range(a)+c(-.15,.15)*diff(range(a)),bty='n',xlab='',main=if(k==1)'Původní hodnoty' else 'Po standardizaci')
    fl_title(xlab=if(k==1)'Doba dokončení úlohy (minuty)' else '*z*-skór')
    abline(v=if(k==1)mean(v) else 0,lty=2,col=ch4_orange)
  }
},height=5)
ch4_fig('standardizace','data',note='Dva panely pod sebou se stejným rozmístěním bodů; body jsou modré, oranžová přerušovaná svislá čára leží v průměru. Svislá osa nemá stupnici ani význam: druhá ze dvou shodných hodnot je jen vykreslena o něco výš.',panels=local({
  v <- c(4,5,5,6,10); z <- (v-mean(v))/sd(v); h <- c(1,1,1.25,1,1)
  lim <- function(a) range(a)+c(-.15,.15)*diff(range(a))
  list(tf_panel('Původní hodnoty','bodový graf','Doba dokončení úlohy (minuty)','Svislá poloha bodu (bez stupnice)',xlim=lim(v),ylim=c(.6,1.6),
      guides=list(tf_guide('x',mean(v),paste0('průměr ',ch4_num(mean(v),0),' minut'))),series=list(tf_series('Pět dob dokončení úlohy',data.frame(x=v,y=h)))),
    tf_panel('Po standardizaci','bodový graf','z-skór','Svislá poloha bodu (bez stupnice)',xlim=lim(z),ylim=c(.6,1.6),
      guides=list(tf_guide('x',0,'průměr 0')),series=list(tf_series('z-skóry týchž pěti dob',data.frame(x=z,y=h),digits=3)))) }))
ch4_draw('parametry', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.6,.6))
  ch4_curve(main='Mění se průměr',xlim=c(10,110))
  curve(dnorm(x,65,10),add=TRUE,col=ch4_orange,lwd=2.3,lty=2)
  fl_legend('topright',c('*N*(50, 10)','*N*(65, 10)'),col=c(ch4_blue,ch4_orange),lty=1:2,lwd=2,bty='n',cex=.74)
  ch4_curve(main='Mění se směrodatná odchylka',xlim=c(0,100))
  curve(dnorm(x,50,15),add=TRUE,col=ch4_orange,lwd=2.3,lty=2)
  fl_legend('topright',c('*N*(50, 10)','*N*(50, 15)'),col=c(ch4_blue,ch4_orange),lty=1:2,lwd=2,bty='n',cex=.74)
},width=10)
ch4_fig('parametry','krivka',note='Dva panely vedle sebe. V každém je modrá plná křivka hustoty modelu N(50, 10) a oranžová přerušovaná křivka druhého modelu; legenda vpravo nahoře uvádí oba modely zápisem N(průměr, směrodatná odchylka).',panels=local({
  p <- function(title,xlim,mu,sigma) tf_panel(title,'čárový graf','Skór pozornosti (body)','Hustota (na bod)',xlim=xlim,ylim=c(0,.044),
    series=list(tf_curve('N(50, 10): průměr 50, směrodatná odchylka 10',function(x) dnorm(x,50,10),xlim[1],xlim[2],81),
      tf_curve(paste0('N(',mu,', ',sigma,'): průměr ',mu,', směrodatná odchylka ',sigma),function(x) dnorm(x,mu,sigma),xlim[1],xlim[2],81)))
  list(p('Mění se průměr',c(10,110),65,10),p('Mění se směrodatná odchylka',c(0,100),50,15)) }))
ch4_draw('hustota', {
  par(mfrow=c(1,2),mar=c(4.6,4.7,3,.7))
  plot(NA,xlim=c(20,80),ylim=c(0,.048),xlab='Skór (body)',ylab='Hustota (na bod)',main='Schéma histogramu',bty='l')
  b <- seq(20,80,10); heights <- c(.005,.015,.03,.03,.015,.005)
  rect(b[-7],0,b[-1],heights,col=c(rep('#E1E8EB',3),ch4_fill,rep('#E1E8EB',2)),border='white')
  text(55,.037,'0,03 × 10 = 0,30',cex=.82)
  ch4_curve(main='Normální model')
  ch4_area(50,60)
  text(68,.025,'Plocha\n0,341',cex=.95)
},width=9)
ch4_fig('hustota','krivka',note='Dva panely vedle sebe. Vlevo schematický histogram ze šesti sloupců širokých 10 bodů; sloupec 50–60 je světle modrý (ostatní šedé) a nad ním je výpočet plochy „0,03 × 10 = 0,30“. Vpravo modrá křivka hustoty se světle modrou plochou mezi 50 a 60 body a popiskem „Plocha 0,341“.',panels=list(
  tf_panel('Schéma histogramu','histogram','Skór (body)','Hustota (na bod)',xlim=c(20,80),ylim=c(0,.048),
    series=list(tf_series('Sloupce histogramu',data.frame(od=seq(20,70,10),do=seq(30,80,10),hustota=c(.005,.015,.03,.03,.015,.005),zvyrazneno=c('ne','ne','ne','ano','ne','ne')),'histogram',digits=4))),
  tf_panel('Normální model','čárový graf','Skór pozornosti (body)','Hustota (na bod)',xlim=c(10,90),ylim=c(0,.044),
    series=list(ch4_tf_density(),ch4_tf_area(paste0('Plocha mezi 50 a 60 body: ',ch4_num(pnorm(60,50,10)-pnorm(50,50,10),3)),50,60)))))
# Density above, distribution function below: the coloured area equals the coloured height.
ch4_hi <- '#F0B08C'; ch4_hi_text <- '#9A3F17'; ch4_lo <- ch4_fill; ch4_lo_text <- '#1D5670'
ch4_fmt <- function(v) format(round(v,3),nsmall=3)
ch4_F <- function(x) pnorm(x,50,10)
ch4_top_mar <- c(1.6,4.7,2.2,.8); ch4_bottom_mar <- c(4.5,4.7,1.4,.8)
ch4_density_panel <- function(title,ylab='Hustota (na bod)') {
  par(mar=ch4_top_mar)
  x <- seq(10,90,length.out=1001)
  plot(x,dnorm(x,50,10),type='n',xlab='',ylab=ylab,xlim=c(10,90),ylim=c(0,.044),bty='l',xaxt='n')
  axis(1,at=seq(10,90,20),labels=FALSE)
  title(main=title,adj=0,cex.main=1)
}
ch4_density_line <- function() curve(dnorm(x,50,10),from=10,to=90,add=TRUE,lwd=2.3,col=ch4_blue)
ch4_cdf_panel <- function(title,ylab='Podíl nejvýše po hranici') {
  par(mar=ch4_bottom_mar)
  plot(NA,xlim=c(10,90),ylim=c(0,1.04),yaxs='i',xlab='Skór pozornosti (body)',ylab=ylab,bty='l',yaxt='n')
  axis(2,at=seq(0,1,.25),labels=c('0','0,25','0,5','0,75','1'))
  abline(h=1,col='#C9D3D8',lty=3)
  title(main=title,adj=0,cex.main=1)
}
ch4_cdf_line <- function() curve(ch4_F(x),from=10,to=90,add=TRUE,lwd=2.5,col=ch4_blue)
# Column at the boundary: stacked pieces c(y0,y1,fill).
ch4_column <- function(x,pieces,w=2.6) for(p in pieces) rect(x-w/2,p[[1]],x+w/2,p[[2]],col=p[[3]],border=ch4_gray,lwd=.8)
# One dashed boundary line through both panels; call in the top panel, then link() in the bottom one.
ch4_link_start <- function(xs) { segments(xs,0,xs,.044,lty=2,lwd=1.4,col=ch4_orange); grconvertY(0,'user','ndc') }
ch4_link_end <- function(xs,ndc) { op <- par(xpd=NA); segments(xs,0,xs,grconvertY(ndc,'ndc','user'),lty=2,lwd=1.4,col=ch4_orange); par(op) }
# Panels of the figure records that mirror ch4_density_panel() and ch4_cdf_panel(). `areas`: list(from,to,name) shaded
# under the density; `columns`: x, skupina and y (height of the piece) of the stacked column(s); `at`: dashed boundaries.
ch4_tf_boundaries <- function(at) lapply(at,function(a) tf_guide('x',a,paste('hranice',a,'bodů')))
ch4_tf_density_panel <- function(title,areas,at) tf_panel(title,'čárový graf','Skór pozornosti (body)','Hustota (na bod)',xlim=c(10,90),ylim=c(0,.044),
  guides=ch4_tf_boundaries(at),series=c(list(ch4_tf_density()),lapply(areas,function(a) ch4_tf_area(a[[3]],a[[1]],a[[2]]))))
ch4_tf_cdf_panel <- function(title,columns,at,segments=NULL,top=TRUE,extra=NULL) tf_panel(title,'čárový graf','Skór pozornosti (body)','Podíl nejvýše po hranici',xlim=c(10,90),ylim=c(0,1.04),
  guides=c(ch4_tf_boundaries(at),if(top) list(tf_guide('y',1,'podíl 1 (tečkovaně)'))),
  series=c(list(tf_curve('Distribuční funkce modelu N(50, 10)',ch4_F,10,90,41),
      tf_series('Sloupec na hranici',columns,'sloupce',digits=4,arrangement='skládané',note='Úzký sloupec (šířka asi 3 body) se středem na hranici; y je výška dílu, díly téže hranice leží na sobě.')),
    if(!is.null(segments)) list(tf_series('Tečkované vodorovné úsečky ve výšce distribuční funkce',segments,'usecky',digits=4)),extra))
ch4_tf_piece <- function(what,value,colour) paste0(what,': ',value,' (',colour,')')
ch4_draw('distribucni', {
  layout(matrix(1:2,2))
  ch4_density_panel('Hustota: podíl je plocha')
  ch4_area(-Inf,60,fill=ch4_hi); ch4_density_line()
  text(43,.014,ch4_fmt(ch4_F(60)),col=ch4_hi_text,font=2,cex=1.15)
  ndc <- ch4_link_start(60)
  ch4_cdf_panel('Distribuční funkce: podíl je výška')
  ch4_column(60,list(list(0,ch4_F(60),ch4_hi)))
  segments(10,ch4_F(60),60,ch4_F(60),lty=3,col=ch4_gray)
  ch4_cdf_line(); ch4_link_end(60,ndc)
  text(63,ch4_F(60)/2,ch4_fmt(ch4_F(60)),col=ch4_hi_text,font=2,cex=1.15,adj=0)
},width=7,height=6.6)
ch4_fig('distribucni','krivka',note='Dva panely pod sebou se společnou vodorovnou osou, popsanou jen u dolního. Nahoře hustota s oranžově vybarvenou plochou vlevo od 60 bodů a popiskem 0,841; dole distribuční funkce, z níž v 60 bodech vystupuje oranžový sloupec vysoký 0,841. Oranžová přerušovaná svislá čára spojuje hranici 60 v obou panelech.',panels=list(
  ch4_tf_density_panel('Hustota: podíl je plocha',list(list(10,60,ch4_tf_piece('Plocha do 60 bodů',ch4_fmt(ch4_F(60)),'oranžově'))),60),
  ch4_tf_cdf_panel('Distribuční funkce: podíl je výška',data.frame(x=60,skupina=ch4_tf_piece('podíl do 60 bodů',ch4_fmt(ch4_F(60)),'oranžově'),y=ch4_F(60)),60,
    data.frame(x0=10,y0=ch4_F(60),x1=60,y1=ch4_F(60)))))
ch4_draw('oblasti', {
  layout(matrix(1:6,2))
  ttl <- c('Nejvýše 60','Nad 60','Nad 60 a nejvýše 70')
  for(k in 1:3) {
    yl <- if(k==1) 'Hustota (na bod)' else ''
    ch4_density_panel(ttl[k],ylab=yl)
    if(k==1) { ch4_area(-Inf,60,fill=ch4_hi); text(43,.014,ch4_fmt(ch4_F(60)),col=ch4_hi_text,font=2) }
    if(k==2) { ch4_area(-Inf,60,fill=ch4_lo); ch4_area(60,Inf,fill=ch4_hi)
      text(43,.014,ch4_fmt(ch4_F(60)),col=ch4_lo_text,font=2); text(76,.016,ch4_fmt(1-ch4_F(60)),col=ch4_hi_text,font=2) }
    if(k==3) { ch4_area(-Inf,60,fill=ch4_lo); ch4_area(60,70,fill=ch4_hi)
      text(43,.014,ch4_fmt(ch4_F(60)),col=ch4_lo_text,font=2); text(78,.02,ch4_fmt(ch4_F(70)-ch4_F(60)),col=ch4_hi_text,font=2) }
    ch4_density_line()
    xs <- if(k==3) c(60,70) else 60
    ndc <- ch4_link_start(xs)
    ch4_cdf_panel('',ylab=if(k==1) 'Podíl nejvýše po hranici' else '')
    if(k==1) { ch4_column(60,list(list(0,ch4_F(60),ch4_hi)))
      text(63,.42,ch4_fmt(ch4_F(60)),col=ch4_hi_text,font=2,adj=0) }
    if(k==2) { ch4_column(60,list(list(0,ch4_F(60),ch4_lo),list(ch4_F(60),1,ch4_hi)))
      text(63,.42,ch4_fmt(ch4_F(60)),col=ch4_lo_text,font=2,adj=0)
      text(12,.9,paste0('1 − ',ch4_fmt(ch4_F(60)),' = ',ch4_fmt(1-ch4_F(60))),col=ch4_hi_text,font=2,adj=0,cex=.9) }
    if(k==3) { segments(60,ch4_F(60),70,ch4_F(60),lty=3,col=ch4_gray)
      ch4_column(70,list(list(0,ch4_F(60),ch4_lo),list(ch4_F(60),ch4_F(70),ch4_hi)))
      text(73,.42,ch4_fmt(ch4_F(60)),col=ch4_lo_text,font=2,adj=0)
      text(12,.9,paste0(ch4_fmt(ch4_F(70)),' − ',ch4_fmt(ch4_F(60)),' = ',ch4_fmt(ch4_F(70)-ch4_F(60))),col=ch4_hi_text,font=2,adj=0,cex=.9) }
    ch4_cdf_line(); ch4_link_end(xs,ndc)
  }
},width=10.5,height=6.4)
ch4_fig('oblasti','krivka',note='Šest panelů ve třech sloupcích nadepsaných „Nejvýše 60“, „Nad 60“ a „Nad 60 a nejvýše 70“; panely jsou uvedeny po sloupcích, vždy hustota a pod ní distribuční funkce, která v obrázku vlastní titulek nemá. Hledaný podíl je oranžový, odečítaný podíl do 60 bodů modrý; u ploch a sloupců jsou hodnoty a v dolních panelech výpočty „1 − 0,841 = 0,159“ a „0,977 − 0,841 = 0,136“. Oranžové přerušované svislé čáry spojují hranice v obou panelech sloupce.',panels=local({
  f60 <- ch4_F(60); f70 <- ch4_F(70)
  area_lo <- list(10,60,ch4_tf_piece('Plocha do 60 bodů',ch4_fmt(f60),'modře')); piece_lo <- ch4_tf_piece('podíl do 60 bodů',ch4_fmt(f60),'modře')
  list(ch4_tf_density_panel('Nejvýše 60',list(list(10,60,ch4_tf_piece('Plocha do 60 bodů',ch4_fmt(f60),'oranžově'))),60),
    ch4_tf_cdf_panel('Nejvýše 60: distribuční funkce',data.frame(x=60,skupina=ch4_tf_piece('podíl do 60 bodů',ch4_fmt(f60),'oranžově'),y=f60),60),
    ch4_tf_density_panel('Nad 60',list(area_lo,list(60,90,ch4_tf_piece('Plocha nad 60 bodů',ch4_fmt(1-f60),'oranžově'))),60),
    ch4_tf_cdf_panel('Nad 60: distribuční funkce',data.frame(x=60,skupina=c(piece_lo,ch4_tf_piece('podíl nad 60 bodů',ch4_fmt(1-f60),'oranžově')),y=c(f60,1-f60)),60),
    ch4_tf_density_panel('Nad 60 a nejvýše 70',list(area_lo,list(60,70,ch4_tf_piece('Plocha mezi 60 a 70 body',ch4_fmt(f70-f60),'oranžově'))),c(60,70)),
    ch4_tf_cdf_panel('Nad 60 a nejvýše 70: distribuční funkce',data.frame(x=70,skupina=c(piece_lo,ch4_tf_piece('podíl mezi 60 a 70 body',ch4_fmt(f70-f60),'oranžově')),y=c(f60,f70-f60)),c(60,70),
      data.frame(x0=60,y0=f60,x1=70,y1=f60))) }))
ch4_draw('mezi', {
  layout(matrix(c(1,2,3,4,5,6,6,6,6,6),2,byrow=TRUE),widths=c(1,.22,1,.22,1),heights=c(1,1.25))
  mini <- function(parts,lab,labcol,ticks) {
    par(mar=c(2.2,.6,2,.6))
    plot(NA,xlim=c(15,85),ylim=c(0,.044),axes=FALSE,xlab='',ylab='')
    for(p in parts) ch4_area(p[[1]],p[[2]],fill=p[[3]])
    ch4_density_line(); axis(1,at=ticks,cex.axis=.9); abline(h=0,col=ch4_gray)
    title(main=lab,col.main=labcol,cex.main=1.05)
  }
  sym <- function(s) { par(mar=c(2.2,0,2,0)); plot.new(); text(.5,.45,s,cex=2.6,font=2,col='#223744') }
  mini(list(list(60,70,ch4_hi)),paste('Mezi 60 a 70:',ch4_fmt(ch4_F(70)-ch4_F(60))),ch4_hi_text,c(60,70))
  sym('=')
  mini(list(list(-Inf,60,ch4_lo),list(60,70,ch4_hi)),paste('Do 70:',ch4_fmt(ch4_F(70))),'#223744',70)
  sym('−')
  mini(list(list(-Inf,60,ch4_lo)),paste('Do 60:',ch4_fmt(ch4_F(60))),ch4_lo_text,60)
  par(mar=c(4.5,4.7,2.2,.8))
  plot(NA,xlim=c(10,90),ylim=c(0,1.04),yaxs='i',xlab='Skór pozornosti (body)',ylab='Podíl nejvýše po hranici',bty='l',yaxt='n')
  axis(2,at=seq(0,1,.25),labels=c('0','0,25','0,5','0,75','1'))
  title(main='Distribuční funkce: tentýž rozdíl jako rozdíl dvou výšek',adj=0,cex.main=1)
  abline(v=c(60,70),lty=2,lwd=1.4,col=ch4_orange)
  segments(10,c(ch4_F(60),ch4_F(70)),c(60,70),c(ch4_F(60),ch4_F(70)),lty=3,col=ch4_gray)
  ch4_column(60,list(list(0,ch4_F(60),ch4_lo)),w=3)
  ch4_column(70,list(list(0,ch4_F(60),ch4_lo),list(ch4_F(60),ch4_F(70),ch4_hi)),w=3)
  ch4_cdf_line()
  text(58,.1,paste('Výška v 60:',ch4_fmt(ch4_F(60))),col=ch4_lo_text,font=2,adj=1)
  text(72,.42,paste('Výška v 70:',ch4_fmt(ch4_F(70))),col='#223744',font=2,adj=0)
  arrows(73,ch4_F(60),73,ch4_F(70),code=3,length=.05,col=ch4_hi_text,lwd=1.5)
  text(74.5,(ch4_F(60)+ch4_F(70))/2-.07,paste0(ch4_fmt(ch4_F(70)),' − ',ch4_fmt(ch4_F(60)),' = ',ch4_fmt(ch4_F(70)-ch4_F(60))),col=ch4_hi_text,font=2,adj=0,cex=.95)
},width=10,height=6.6)
ch4_fig('mezi','krivka',note='Horní řada: tři malé panely hustoty bez svislé osy, mezi nimi velké symboly „=“ a „−“: plocha mezi 60 a 70 body (oranžově) = plocha do 70 bodů (modrá část do 60, oranžová část 60–70) − plocha do 60 bodů (modře); na vodorovné ose jsou popsány jen hranice 60 a 70. Dolní panel přes celou šířku: distribuční funkce se sloupci v 60 a 70 bodech a popisky „Výška v 60: 0,841“ a „Výška v 70: 0,977“; oboustranná šipka u oranžové části sloupce nese výpočet „0,977 − 0,841 = 0,136“.',panels=local({
  f60 <- ch4_F(60); f70 <- ch4_F(70)
  lo <- list(15,60,'Plocha do 60 bodů (modře)',19); hi <- list(60,70,'Plocha mezi 60 a 70 body (oranžově)',11)
  mini <- function(title,areas) tf_panel(title,'čárový graf','Skór pozornosti (body)','Hustota (na bod)',xlim=c(15,85),ylim=c(0,.044),
    series=c(list(ch4_tf_density(15,85,36)),lapply(areas,function(a) ch4_tf_area(a[[3]],a[[1]],a[[2]],a[[4]]))))
  list(mini(paste('Mezi 60 a 70:',ch4_fmt(f70-f60)),list(hi)),mini(paste('Do 70:',ch4_fmt(f70)),list(lo,hi)),mini(paste('Do 60:',ch4_fmt(f60)),list(lo)),
    ch4_tf_cdf_panel('Distribuční funkce: tentýž rozdíl jako rozdíl dvou výšek',data.frame(x=c(60,70,70),y=c(f60,f60,f70-f60),
        skupina=c(rep(ch4_tf_piece('výška v 60 bodech',ch4_fmt(f60),'modře'),2),ch4_tf_piece('rozdíl výšek v 70 a 60 bodech',ch4_fmt(f70-f60),'oranžově'))),c(60,70),
      data.frame(x0=c(10,10),y0=c(f60,f70),x1=c(60,70),y1=c(f60,f70)),top=FALSE,
      extra=list(tf_series('Oboustranná šipka: rozdíl výšek',data.frame(x0=73,y0=f60,x1=73,y1=f70),'usecky',digits=4)))) }))
ch4_draw('kvantily', {
  par(mfrow=c(1,2),mar=c(4.7,4.7,2.7,.7))
  ch4_curve(main='Horních 5 %');a<-qnorm(.95,50,10);ch4_area(a,Inf)
  abline(v=a,lty=2,col=ch4_orange);text(74,.014,'5 %');axis(1,at=a,labels='66,45',line=1.3,tick=FALSE,cex.axis=.8)
  ch4_curve(main='Prostředních 95 %');a<-qnorm(c(.025,.975),50,10);ch4_area(a[1],a[2])
  abline(v=a,lty=2,col=ch4_orange);text(50,.018,'95 %');text(c(19,81),.007,'2,5 %',cex=.8)
  axis(1,at=a,labels=c('30,40','69,60'),line=1.3,tick=FALSE,cex.axis=.8)
},width=9)
ch4_fig('kvantily','krivka',note='Dva panely vedle sebe s modrou křivkou hustoty; vybarvená plocha je světle modrá, oranžové přerušované svislé čáry leží v kvantilech a jejich hodnoty jsou vypsány pod osou. Vlevo je u plochy popisek „5 %“, vpravo „95 %“ uprostřed a „2,5 %“ v každém chvostu.',panels=local({
  a <- qnorm(.95,50,10); b <- qnorm(c(.025,.975),50,10)
  p <- function(title,q,area) tf_panel(title,'čárový graf','Skór pozornosti (body)','Hustota (na bod)',xlim=c(10,90),ylim=c(0,.044),
    guides=lapply(q,function(v) tf_guide('x',v,paste0('kvantil ',ch4_num(v),' bodu'))),series=list(ch4_tf_density(),area))
  list(p('Horních 5 %',a,ch4_tf_area('Horních 5 % plochy',a,90)),p('Prostředních 95 %',b,ch4_tf_area('Prostředních 95 % plochy',b[1],b[2]))) }))
ch4_draw('skaly', {
  par(mar=c(1,9,1,1))
  zz<--3:3
  plot(NA,xlim=c(-3.2,3.2),ylim=c(-1.3,4.5),axes=FALSE,xlab='',ylab='')
  abline(v=zz,col='#D6E0E5',lty=3)
  for(k in 1:4) {
    y<-5-k;segments(-3,y,3,y,col=ch4_blue,lwd=1.5)
    points(zz,rep(y,7),pch=19,col=ch4_blue)
    text(zz,y+.23,list(zz,50+10*zz,100+15*zz,10+3*zz)[[k]])
    fl_mtext(c('*z*-skór','T-skór','IQ-skór (100/15)','Subtestový skór (10/3)')[k],side=2,at=y,line=.5,las=1,cex=.85)
  }
  segments(-3,0,3,0,col=ch4_orange,lwd=1.5)
  points(zz,rep(0,7),pch=19,col=ch4_orange)
  text(zz,.23,format(round(100*pnorm(zz),1),decimal.mark=',',trim=TRUE),col=ch4_orange)
  mtext('Percentilové pořadí\nJEN normální model',side=2,at=0,line=.5,las=1,cex=.8,col=ch4_orange)
  fl_text(0,-.85,'Krok *z* = 0 → 1: +34,1     Krok *z* = 1 → 2: +13,6\nRozdíly na stupnici percentilového pořadí',cex=.82)
},height=5.8)
ch4_fig('skaly','schema',note=paste0('Pět vodorovných stupnic pod sebou se sedmi svisle zarovnanými body pro z = −3 až 3: z-skór, T-skór (50 + 10z: 20 až 80), IQ-skór (100 + 15z: 55 až 145) a subtestový skór (10 + 3z: 1 až 19) modře, pod nimi oranžově percentilové pořadí s nadpisem „JEN normální model“ (',
  paste(ch4_num(100*pnorm(-3:3),1),collapse='; '),'). Pod stupnicemi je text o nestejných krocích percentilového pořadí: krok z = 0 → 1 je +34,1, krok z = 1 → 2 je +13,6.'))
ch4_draw('z-jako-jednotka', {
  par(mar=c(0,0,0,0));plot.new();plot.window(xlim=c(0,10),ylim=c(0,7),xaxs='i',yaxs='i')
  for(k in 1:2) {
    y<-if(k==1) 5 else 2
    text(.5,y+1.3,if(k==1) 'Test A: průměr 50 bodů; směrodatná odchylka 10 bodů' else 'Test B: průměr 30 bodů; směrodatná odchylka 6 bodů',adj=0,font=2)
    xx<-c(2,4,6);segments(1,y,7,y,col=ch4_blue)
    points(xx,rep(y,3),pch=19,col=ch4_blue)
    text(xx,y-.5,if(k==1)c('50','60','70') else c('30','36','42'))
    for(j in seq_len(k)) {
      arrows(xx[j],y+.5,xx[j+1],y+.5,length=.08,code=3,col=ch4_orange)
      text(mean(xx[j:(j+1)]),y+.8,if(k==1)'10 bodů' else '6 bodů',cex=.85)
    }
    points(xx[k+1],y,pch=21,cex=2.7,col=ch4_orange,bg='white',lwd=2)
    fl_text(8.5,y,paste0('*z* = ',k),font=2,cex=1.25)
    text(2,y-.95,'průměr',cex=.85)
  }
  text(.5,.25,'Porovnáváme počet kroků od průměru, nikoli počty hrubých bodů.',adj=0,cex=.85)
},width=8,height=5.4)
ch4_fig('z-jako-jednotka','schema',note='Dvě číselné osy pod sebou. Test A (průměr 50 bodů, směrodatná odchylka 10 bodů): body 50, 60, 70, jedna oranžová šipka „10 bodů“ od průměru k zakroužkovanému výsledku 60, vpravo „z = 1“. Test B (průměr 30 bodů, směrodatná odchylka 6 bodů): body 30, 36, 42, dvě šipky „6 bodů“ k zakroužkovanému výsledku 42, vpravo „z = 2“. Dole věta „Porovnáváme počet kroků od průměru, nikoli počty hrubých bodů.“')
ch4_draw('pasma-skoru', {
  par(mfrow=c(2,1),mar=c(6.2,4.4,4.6,1),cex=.95)
  pct<-function(v) paste0(format(round(100*v,1),nsmall=1,decimal.mark=',',trim=TRUE),' %')
  # Text on a white box so that it stays legible over the band boundaries.
  boxed<-function(x,y,label,adj=0,cex=.8,col='#223744') {
    w<-fl_strwidth(label,cex=cex);h<-strheight(label,cex=cex)
    x0<-x-adj*w;rect(x0-.05,y-h/2-.012,x0+w+.05,y+h/2+.012,col='white',border=NA)
    fl_text(x0,y,label,adj=c(0,.5),cex=cex,col=col)
  }
  for(k in 1:2) {
    breaks<-if(k==1) ch4_sten_breaks else ch4_stanine_breaks
    props<-if(k==1) ch4_sten_proportions else ch4_stanine_proportions
    inner<-breaks[is.finite(breaks)]
    finite_breaks<-pmax(-3.5,pmin(3.5,breaks));target<-if(k==1) ch4_sten(1.2) else ch4_stanine(1.2)
    plot(NA,xlim=c(-3.5,3.5),ylim=c(0,.48),xlab='',ylab='Hustota',bty='l',xaxt='n',yaxs='i')
    title(main=if(k==1)'Deset stenových pásem' else 'Devět staninových pásem',line=3)
    for(j in seq_len(length(breaks)-1)) {
      v<-seq(finite_breaks[j],finite_breaks[j+1],length.out=150)
      polygon(c(v[1],v,tail(v,1)),c(0,dnorm(v),0),border=NA,
        col=if(j==target)'#F3C395' else c('#DAEBF1','#B8DDE8')[(j%%2)+1])
    }
    curve(dnorm(x),add=TRUE,col=ch4_blue,lwd=2)
    abline(v=inner,col='#667078',lty=3)
    mids<-(head(finite_breaks,-1)+tail(finite_breaks,-1))/2
    axis(1,at=inner,cex.axis=.78)
    # Axis title right under the z values; band numbers form a separate row below.
    fl_mtext('*z*-skór',side=1,line=1.75,cex=.95)
    mtext(if(k==1)'Sten:' else 'Stanin:',side=1,line=4.4,at=-3.3,cex=.8)
    mtext(seq_along(mids),side=1,line=4.4,at=mids,cex=.85)
    # Model share of every band just above the axis; cumulative share above each boundary.
    text(mids,ifelse(is.finite(head(breaks,-1))&is.finite(breaks[-1]),.016,.035),pct(props),cex=.6,col='#223744')
    mtext(pct(pnorm(inner)),side=3,line=.25,at=inner,cex=.62,col=ch4_hi_text)
    mtext('Kumulativně:',side=3,line=.25,at=-3.5,adj=0,cex=.62,col=ch4_hi_text)
    points(1.2,dnorm(1.2),pch=19,col=ch4_orange)
    arrows(1.2,.36,1.2,dnorm(1.2)+.02,length=.08,col=ch4_orange)
    boxed(1.25,.39,paste0('*z* = 1,2 → ',if(k==1)'sten ' else 'stanin ',target),cex=.85)
    arrows(c(-2.8,2.8),c(.07,.07),c(-3.4,3.4),c(.07,.07),length=.08)
    text(c(-2.8,2.8),c(.1,.1),'pokračuje',cex=.7)
    if(k==1) {
      points(c(1.1,1.4),c(.07,.07),pch=21,bg='white',col=ch4_orange,cex=.9)
      boxed(-3.35,.41,'Malé kroužky: *z* = 1,1 a 1,4',cex=.75)
      boxed(-3.35,.36,'Oba výsledky patří do stenu 8.',cex=.75)
    }
  }
},width=8.5,height=8.8)
ch4_fig('pasma-skoru','krivka',note='Dva panely pod sebou se shodnou osou z: hustota normovaného normálního rozdělení rozdělená tečkovanými svislými čarami na pásma. Plocha pod křivkou je po pásmech střídavě vybarvena dvěma odstíny modré, pásmo s hodnotou z = 1,2 oranžově; na oranžový bod na křivce ukazuje šipka s popiskem. Těsně nad osou je v každém pásmu jeho modelový podíl, pod osou číslo pásma a nad každou mezí kumulativní podíl; šipky „pokračuje“ u okrajů připomínají, že krajní pásma nejsou zvenku omezená.',panels=lapply(1:2,function(k) {
  breaks <- if(k==1) ch4_sten_breaks else ch4_stanine_breaks; props <- if(k==1) ch4_sten_proportions else ch4_stanine_proportions
  inner <- breaks[is.finite(breaks)]; finite_breaks <- pmax(-3.5,pmin(3.5,breaks)); target <- if(k==1) ch4_sten(1.2) else ch4_stanine(1.2)
  word <- if(k==1) 'sten' else 'stanin'; pct <- function(v) paste0(ch4_num(100*v,1),' %')
  tf_panel(if(k==1) 'Deset stenových pásem' else 'Devět staninových pásem','čárový graf','z-skór','Hustota',xlim=c(-3.5,3.5),ylim=c(0,.48),
    guides=lapply(inner,function(b) tf_guide('x',b,paste0('mez pásem; kumulativně ',pct(pnorm(b))))),
    series=c(list(tf_curve('Hustota normovaného normálního rozdělení',dnorm,-3.5,3.5,71),
        tf_curve(paste0('Oranžové pásmo: ',word,' ',target),dnorm,finite_breaks[target],finite_breaks[target+1],11,mark='plocha'),
        tf_series(paste0('Pásma (',word,'y)'),data.frame(pasmo=seq_along(props),z_od=head(finite_breaks,-1),z_do=finite_breaks[-1],podil=props,kumulativni_podil=pnorm(breaks[-1]),
          zvyrazneno=ifelse(seq_along(props)==target,'ano','ne')),'tabulka',digits=4,note='Krajní pásma nejsou zvenku omezená; hodnoty −3,5 a 3,5 jsou okraje grafu.'),
        tf_series('Zvýrazněná hodnota na křivce',data.frame(x=1.2,y=dnorm(1.2),popisek=paste0('z = 1,2 → ',word,' ',target)),digits=4)),
      if(k==1) list(tf_series('Malé kroužky: dva výsledky ve stejném stenu',data.frame(x=c(1.1,1.4),y=c(.07,.07),popisek=c('z = 1,1','z = 1,4')),note='Popisek v grafu: „Oba výsledky patří do stenu 8.“')))) }))
ch4_norm_x <- c(11,12,12,13,14,14,14,16,17,19,22,26,31,39,52)
ch4_norm_z <- qnorm((rank(ch4_norm_x)-.5)/length(ch4_norm_x))
ch4_draw('normalizace', {
  par(mar=c(4.3,4.6,2.6,4.6))
  x <- ch4_norm_x; z <- ch4_norm_z; g <- 2.6; w <- 7.6
  ux <- function(v) (v-10)/45; uz <- function(v) (v+2.25)/4.5
  hx <- hist(x,breaks=seq(10,55,5),right=FALSE,plot=FALSE)
  hz <- hist(z,breaks=seq(-2,2,.5),right=FALSE,plot=FALSE)
  plot(NA,xlim=c(-g-w,g+w),ylim=c(0,1),xaxs='i',yaxs='i',axes=FALSE,xlab='',ylab='')
  abline(h=ux(seq(10,55,5)),col='#EEF2F4'); box(bty='l',col='#223744'); box(bty='7',col='#223744')
  rect(-g-hx$counts,ux(head(hx$breaks,-1)),-g,ux(hx$breaks[-1]),col=ch4_fill,border=ch4_blue,lwd=.8)
  rect(g,uz(head(hz$breaks,-1)),g+hz$counts,uz(hz$breaks[-1]),col=ch4_hi,border=ch4_hi_text,lwd=.8)
  # Tied values sit side by side; each pair of dots is joined by a translucent line.
  tie <- ave(x,x,FUN=function(v) seq_along(v)-(length(v)+1)/2)*.32
  xl <- -g+.75+tie; xr <- g-.75+tie
  segments(xl,ux(x),xr,uz(z),col=adjustcolor(ch4_gray,.5),lwd=1.3)
  points(xl,ux(x),pch=21,bg=ch4_blue,col='white',cex=1.25)
  points(xr,uz(z),pch=21,bg=ch4_hi_text,col='white',cex=1.25)
  axis(2,at=ux(seq(10,50,10)),labels=seq(10,50,10))
  axis(4,at=uz(-2:2),labels=c('−2','−1','0','1','2'))
  mtext('Doba řešení (s)',side=2,line=2.8,las=0); fl_mtext('*z*-skór po normalizaci',side=4,line=2.8,las=0)
  cnt <- 0:7
  axis(1,at=c(-g-cnt,g+cnt),labels=c(cnt,cnt))
  mtext('Četnost',side=1,line=2.5)
  mtext('Původní doby',side=3,line=.6,at=-g-w/2,font=2)
  mtext('Po normalizaci',side=3,line=.6,at=g+w/2,font=2)
},width=8,height=5.6)
ch4_fig('normalizace','data',note='Jeden zrcadlový graf: dva histogramy otočené na bok se společnou vodorovnou osou četností (0 až 7 na obě strany od středu). Vlevo modře původní doby se stupnicí na levé svislé ose a sloupci mířícími doleva; vpravo oranžově z-skóry po normalizaci se stupnicí na pravé svislé ose a sloupci mířícími doprava. V pruhu mezi histogramy je každá z 15 hodnot vynesena dvakrát, vlevo ve výšce své doby a vpravo ve výšce svého z-skóru, a oba body spojuje šedá čára; shodné doby leží vedle sebe.',panels=local({
  hx <- hist(ch4_norm_x,breaks=seq(10,55,5),right=FALSE,plot=FALSE); hz <- hist(ch4_norm_z,breaks=seq(-2,2,.5),right=FALSE,plot=FALSE)
  bins <- function(h) data.frame(od=head(h$breaks,-1),do=h$breaks[-1],cetnost=h$counts)[h$counts>0,]
  closed <- 'Intervaly jsou zleva uzavřené a zprava otevřené. V obrázku je osa hodnot svislá a četnost vodorovná.'
  list(tf_panel('Původní doby','histogram','Doba řešení (s)','Četnost',xlim=c(10,55),ylim=c(0,7.6),note=closed,
      series=list(tf_series('Četnosti původních dob',bins(hx),'histogram'),
        tf_series('Spojnice mezi histogramy: doba a z-skór téže hodnoty',data.frame(doba_s=ch4_norm_x,z_skor=ch4_norm_z),'tabulka',digits=3))),
    tf_panel('Po normalizaci','histogram','z-skór po normalizaci','Četnost',xlim=c(-2.25,2.25),ylim=c(0,7.6),note=closed,
      series=list(tf_series('Četnosti z-skórů po normalizaci',bins(hz),'histogram')))) }))
ch4_draw('qq-konstrukce', {
  par(mar=c(0,0,0,0));plot.new();plot.window(xlim=c(0,10),ylim=c(0,9),xaxs='i',yaxs='i')
  box_label<-function(x,y,w,h,label,fill=ch4_fill) {
    rect(x-w/2,y-h/2,x+w/2,y+h/2,col=fill,border=ch4_blue)
    fl_text(x,y,label,cex=.93)
  }
  box_label(5,8.1,7,1,'První pořadí z 12 seřazených skórů: *i* = 1')
  arrows(c(4,6),7.5,c(2.5,7.5),6.8,length=.1)
  box_label(2.5,6,4,1.4,'DATA\nPrvní pozorovaný skór: 35 bodů')
  box_label(7.5,6,4,1.4,'MODEL\nPodíl *p* = (1 − 0,5) / 12\n≈ 0,041667')
  arrows(7.5,5.2,7.5,4.7,length=.1)
  box_label(7.5,3.9,4,1.4,'Normální kvantil pro tento podíl\n*z* ≈ −1,731664')
  arrows(2.5,5.2,3.6,2,length=.1)
  arrows(7.5,3.1,6.4,2,length=.1)
  text(1.65,3.65,'Svislá osa\npozorovaný skór',cex=.85)
  text(8.05,2.5,'Vodorovná osa\nteoretický kvantil',cex=.85)
  box_label(5,1.3,5.5,1.2,'Bod Q–Q grafu: (−1,73; 35)',fill='#FAECDD')
  text(5,.25,'Pořadí propojí data s modelem; nejde o dvě měření jednoho člověka.',cex=.85)
},width=8,height=6.7)
ch4_fig('qq-konstrukce','schema',note='Vývojový diagram se šipkami. Nahoře „První pořadí z 12 seřazených skórů: i = 1“; odtud vlevo větev DATA („První pozorovaný skór: 35 bodů“, svislá osa) a vpravo větev MODEL („Podíl p = (1 − 0,5) / 12 ≈ 0,041667“, potom „Normální kvantil pro tento podíl z ≈ −1,731664“, vodorovná osa). Obě větve se sbíhají v poli „Bod Q–Q grafu: (−1,73; 35)“; dole věta „Pořadí propojí data s modelem; nejde o dvě měření jednoho člověka.“')
ch4_draw('qq-priklad', {
  plot(ch4_z,ch4_x,pch=19,col=ch4_blue,cex=1.15,xlab='',ylab='Pozorovaný skór pozornosti (body)',bty='l',xlim=c(-2,2),ylim=c(30,70))
  fl_title(xlab='Teoretický normální kvantil (*z*)')
  abline(a=mean(ch4_x),b=sd(ch4_x),col=ch4_orange,lwd=2,lty=2)
  fl_legend('topleft',c('Pozorované skóry','Referenční přímka *m* + *s* *z*'),col=c(ch4_blue,ch4_orange),pch=c(19,NA),lty=c(NA,2),bty='n',cex=.85)
},width=7)
ch4_fig('qq-priklad','data',note='Modré body jsou pozorované skóry, oranžová přerušovaná čára je referenční přímka; legenda vlevo nahoře: „Pozorované skóry“ a „Referenční přímka m + s z“. Obrázek nemá titulek.',panels=list(
  tf_panel('Normální Q–Q graf dvanácti skórů pozornosti','bodový graf','Teoretický normální kvantil (z)','Pozorovaný skór pozornosti (body)',xlim=c(-2,2),ylim=c(30,70),
    guides=list(tf_guide('primka',c(mean(ch4_x),sd(ch4_x)),paste0('referenční přímka m + s·z, m = ',ch4_num(mean(ch4_x)),', s = ',ch4_num(sd(ch4_x))))),
    series=list(tf_series('Pozorované skóry',data.frame(poradi=seq_along(ch4_x),x=ch4_z,y=ch4_x),digits=3)))))
# Distinct simulations for graphical diagnosis; not empirical psychological data.
set.seed(20261010)
# New sets are appended so that the earlier draws keep their values.
ch4_simulations <- list(normalni=rnorm(200,50,10),sikme=30+rexp(200,rate=1/15),chvosty=50+8*rt(200,df=3),smes=c(rnorm(100,36,5),rnorm(100,64,5)),
  sikme_vlevo=70-rexp(200,rate=1/10),lehke=runif(200,30,70))
# Same heavy-tailed model, another draw (2026-10-31): the first draw showed the heavy tail only at
# the top. Replaced after the list so that the other simulations keep their values.
set.seed(20263319); ch4_simulations$chvosty <- 50+8*rt(200,df=3)
ch4_titles <- c(normalni='Normální model',sikme='Rozdělení zešikmené doprava',chvosty='Těžší chvosty',smes='Směs dvou skupin',
  sikme_vlevo='Rozdělení zešikmené doleva',lehke='Lehčí chvosty')
# Highlighted percentiles: each lies between two neighbouring ranks, (i - 0.5)/n just below and
# just above p; the same pair brackets PERCENTIL.INC (type 7). Both observations are coloured.
ch4_qq_groups <- list(list(p=c(.01,.99),col='#7B3294',lab='1. a 99. percentil'),
  list(p=c(.25,.75),col='#1B9E77',lab='25. a 75. percentil'),
  list(p=.5,col='#E6AB02',lab='Medián (50. percentil)'))
ch4_qq_ranks <- function(p,n) sort(unique(c(floor(n*p+.5),ceiling(n*p+.5))))
for(nm in names(ch4_simulations)) ch4_draw(paste0('diagnostika-',nm), {
  v<-ch4_simulations[[nm]]; n<-length(v); z<-qnorm((seq_len(n)-.5)/n); vs<-sort(v)
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.6))
  h<-hist(v,breaks='FD',plot=FALSE);xx<-seq(min(h$breaks),max(h$breaks),length.out=500)
  plot(h,freq=FALSE,col=ch4_fill,border='white',main=ch4_titles[nm],xlab='Simulovaný skór',ylab='Hustota',ylim=c(0,1.12*max(h$density,dnorm(xx,mean(v),sd(v)))));lines(xx,dnorm(xx,mean(v),sd(v)),col=ch4_orange,lwd=2)
  plot(z,vs,pch=19,cex=.55,col='#8FB3C6',xlab='',ylab='Seřazený simulovaný skór',main='Normální Q–Q graf',bty='l')
  fl_title(xlab='Teoretický normální kvantil (*z*)')
  abline(a=mean(v),b=sd(v),lty=2,col=ch4_orange,lwd=2)
  for(g in ch4_qq_groups) { r<-unlist(lapply(g$p,ch4_qq_ranks,n=n)); points(z[r],vs[r],pch=21,cex=1.25,bg=g$col,col='#1F2A30',lwd=.9) }
  legend(if(nm=='sikme_vlevo') 'bottomright' else 'topleft',vapply(ch4_qq_groups,`[[`,'',"lab"),pt.bg=vapply(ch4_qq_groups,`[[`,'',"col"),
    pch=21,col='#1F2A30',pt.cex=1.15,bty='n',cex=.74,inset=.01)
},width=9,height=4.4)
for(nm in names(ch4_simulations)) local({
  v <- ch4_simulations[[nm]]; n <- length(v); z <- qnorm((seq_len(n)-.5)/n); vs <- sort(v)
  h <- hist(v,breaks='FD',plot=FALSE); f <- function(x) dnorm(x,mean(v),sd(v)); xx <- seq(min(h$breaks),max(h$breaks),length.out=500)
  level <- rep('ne',n); for(g in ch4_qq_groups) level[unlist(lapply(g$p,ch4_qq_ranks,n=n))] <- g$lab
  ch4_fig(paste0('diagnostika-',nm),'simulace',note='Dva panely vedle sebe z týchž 200 simulovaných hodnot. Vlevo světle modrý histogram a oranžová křivka normálního rozdělení s průměrem a směrodatnou odchylkou těchto hodnot. Vpravo normální Q–Q graf: šedomodré body, oranžová přerušovaná referenční přímka a dvojice větších barevných bodů u vybraných percentilů podle legendy (1. a 99. percentil fialově, 25. a 75. percentil zeleně, medián žlutě).',panels=list(
    tf_panel(ch4_titles[[nm]],'histogram','Simulovaný skór','Hustota',ylim=c(0,1.12*max(h$density,f(xx))),
      series=list(tf_series('200 simulovaných hodnot',tf_bins(v,'FD','hustota'),'histogram',digits=4),
        tf_curve(paste0('Normální křivka: průměr ',ch4_num(mean(v)),', směrodatná odchylka ',ch4_num(sd(v))),f,min(h$breaks),max(h$breaks),61))),
    tf_panel('Normální Q–Q graf','bodový graf','Teoretický normální kvantil (z)','Seřazený simulovaný skór',
      guides=list(tf_guide('primka',c(mean(v),sd(v)),'referenční přímka: průměr + směrodatná odchylka · z')),
      series=list(tf_series('Seřazené hodnoty',data.frame(x=z,y=vs,zvyrazneno=level),digits=3,note='Každý vybraný percentil leží mezi dvěma sousedními pořadími; zvýrazněna jsou obě pozorování.')))))
})
# Optional extension: the same right-skewed simulation as a Q-Q plot and a P-P plot.
ch4_draw('pp-qq', {
  v<-sort(ch4_simulations$sikme); n<-length(v); p<-(seq_len(n)-.5)/n; z<-qnorm(p)
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.8))
  plot(z,v,pch=19,cex=.55,col=ch4_blue,xlab='',ylab='Seřazený simulovaný skór',main='Q–Q graf: porovnává hodnoty',bty='l')
  fl_title(xlab='Teoretický normální kvantil (*z*)')
  abline(a=mean(v),b=sd(v),lty=2,col=ch4_orange,lwd=2)
  plot(p,pnorm((v-mean(v))/sd(v)),pch=19,cex=.55,col=ch4_blue,xlab='',ylab='Modelový podíl podle normálního modelu',main='P–P graf: porovnává podíly',bty='l',xlim=c(0,1),ylim=c(0,1),xaxs='i',yaxs='i')
  fl_title(xlab='Empirický podíl (*i* − 0,5)/*n*')
  abline(0,1,lty=2,col=ch4_orange,lwd=2)
},width=9,height=4.4)
ch4_fig('pp-qq','simulace',note='Dva panely vedle sebe z týchž 200 simulovaných hodnot zešikmených doprava (stejné hodnoty jako v obrázku „Rozdělení zešikmené doprava“): modré body a oranžová přerušovaná referenční přímka.',panels=local({
  v <- sort(ch4_simulations$sikme); n <- length(v); p <- (seq_len(n)-.5)/n; z <- qnorm(p)
  list(tf_panel('Q–Q graf: porovnává hodnoty','bodový graf','Teoretický normální kvantil (z)','Seřazený simulovaný skór',
      guides=list(tf_guide('primka',c(mean(v),sd(v)),'referenční přímka: průměr + směrodatná odchylka · z')),series=list(tf_series('Seřazené hodnoty',data.frame(x=z,y=v),digits=3))),
    tf_panel('P–P graf: porovnává podíly','bodový graf','Empirický podíl (i − 0,5)/n','Modelový podíl podle normálního modelu',xlim=c(0,1),ylim=c(0,1),
      guides=list(tf_guide('primka',c(0,1),'úhlopříčka: shodné podíly')),series=list(tf_series('Podíly',data.frame(x=p,y=pnorm((v-mean(v))/sd(v))),digits=4)))) }))
# Same normal simulation: the curve matches bar heights only on the density scale.
ch4_draw('histogram-krivka', {
  v<-ch4_simulations$normalni; h<-hist(v,breaks='FD',plot=FALSE)
  xx<-seq(min(h$breaks),max(h$breaks),length.out=500); yy<-dnorm(xx,mean(v),sd(v))
  par(mfrow=c(1,2),mar=c(4.6,4.7,2.7,.6))
  plot(h,freq=TRUE,col=ch4_fill,border='white',main='Svislá osa: četnost',xlab='Simulovaný skór',ylab='Četnost',ylim=c(0,1.12*max(h$counts)))
  lines(xx,yy,col=ch4_orange,lwd=2)
  plot(h,freq=FALSE,col=ch4_fill,border='white',main='Svislá osa: hustota',xlab='Simulovaný skór',ylab='Hustota (na bod)',ylim=c(0,1.12*max(h$density,yy)))
  lines(xx,yy,col=ch4_orange,lwd=2)
},width=9,height=4.4)
ch4_fig('histogram-krivka','simulace',note='Dva panely vedle sebe: tentýž světle modrý histogram 200 simulovaných hodnot (stejné hodnoty jako v obrázku „Normální model“) a táž oranžová křivka hustoty normálního rozdělení s průměrem a směrodatnou odchylkou těchto hodnot. Vlevo je svislá osa v četnostech, vpravo v hustotě; křivka má v obou panelech stejné hodnoty hustoty.',panels=local({
  v <- ch4_simulations$normalni; h <- hist(v,breaks='FD',plot=FALSE); f <- function(x) dnorm(x,mean(v),sd(v))
  yy <- f(seq(min(h$breaks),max(h$breaks),length.out=500))
  line <- tf_curve(paste0('Křivka hustoty: průměr ',ch4_num(mean(v)),', směrodatná odchylka ',ch4_num(sd(v))),f,min(h$breaks),max(h$breaks),61)
  list(tf_panel('Svislá osa: četnost','histogram','Simulovaný skór','Četnost',ylim=c(0,1.12*max(h$counts)),series=list(tf_series('200 simulovaných hodnot',tf_bins(v,'FD'),'histogram'),line)),
    tf_panel('Svislá osa: hustota','histogram','Simulovaný skór','Hustota (na bod)',ylim=c(0,1.12*max(h$density,yy)),series=list(tf_series('200 simulovaných hodnot',tf_bins(v,'FD','hustota'),'histogram',digits=4),line))) }))
options(ch4_old_options)
