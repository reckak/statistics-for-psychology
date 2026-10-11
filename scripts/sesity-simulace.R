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
