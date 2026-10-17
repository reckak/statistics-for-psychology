# Export the very same simulated observations used in chapter 4 figures.
# No additional random draws and no change to the established seed/order.
if (.Platform$OS.type == 'windows') Sys.setlocale('LC_CTYPE', '.UTF-8')
source('scripts/kapitola_04.R', encoding='UTF-8')
dir.create('tmp',showWarnings=FALSE)
json <- paste(vapply(names(ch4_simulations),function(nm) {
  paste0('"',nm,'":[',paste(format(ch4_simulations[[nm]],digits=17,decimal.mark='.',trim=TRUE),collapse=','),']')
},character(1)),collapse=',')
writeLines(paste0('{',json,'}'),'tmp/sesity-simulace.json',useBytes=TRUE)
# Chapter 5: the 40 simulated guessing scores shown in the model-versus-data figure.
source('scripts/kapitola_05.R', encoding='UTF-8')
writeLines(paste0('{"hadani":[',paste(ch5_sim_hadani,collapse=','),']}'),'tmp/sesity-simulace-05.json',useBytes=TRUE)
# Chapter 6: simulated sample means, differences, the displayed sample and the groups of the funnel figure.
# Values are rounded to three decimals to keep the workbook small; the chapter quotes at most two.
source('scripts/kapitola_06.R', encoding='UTF-8')
ch6_json <- function(x) paste0('[',paste(format(round(x,3),nsmall=3,decimal.mark='.',trim=TRUE,scientific=FALSE),collapse=','),']')
writeLines(paste0('{"prumery":{',paste(vapply(seq_along(ch6_sizes),function(j) paste0('"n',ch6_sizes[j],'":',ch6_json(ch6_means[,j])),character(1)),collapse=','),
  '},"rozdily":',ch6_json(ch6_diffs),',"vyber":',ch6_json(ch6_one_sample),
  ',"skupiny_n":[',paste(ch6_group_n,collapse=','),'],"skupiny_m":',ch6_json(ch6_group_m),'}'),'tmp/sesity-simulace-06.json',useBytes=TRUE)
# Chapter 7: the 100 simulated samples of the repeated-interval figure, summarized per sample.
# Interval bounds come from unrounded means and SDs; the 0/1 hits are computed before rounding.
source('scripts/kapitola_07.R', encoding='UTF-8')
ch7_json <- function(x) paste0('[',paste(format(round(x,3),nsmall=3,decimal.mark='.',trim=TRUE,scientific=FALSE),collapse=','),']')
writeLines(paste0('{"prumer":',ch7_json(ch7_sim_m),',"sd":',ch7_json(ch7_sim_s),
  ',"z_dolni":',ch7_json(ch7_sim_z[,1]),',"z_horni":',ch7_json(ch7_sim_z[,2]),
  ',"t_dolni":',ch7_json(ch7_sim_t[,1]),',"t_horni":',ch7_json(ch7_sim_t[,2]),
  ',"z_zachytil":[',paste(as.integer(ch7_hit_z),collapse=','),'],"t_zachytil":[',paste(as.integer(ch7_hit_t),collapse=','),']}'),
  'tmp/sesity-simulace-07.json',useBytes=TRUE)
