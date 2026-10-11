# Export the very same simulated observations used in chapter 4 figures.
# No additional random draws and no change to the established seed/order.
if (.Platform$OS.type == 'windows') Sys.setlocale('LC_CTYPE', '.UTF-8')
source('scripts/kapitola_04.R', encoding='UTF-8')
dir.create('tmp',showWarnings=FALSE)
json <- paste(vapply(names(ch4_simulations),function(nm) {
  paste0('"',nm,'":[',paste(format(ch4_simulations[[nm]],digits=17,decimal.mark='.',trim=TRUE),collapse=','),']')
},character(1)),collapse=',')
writeLines(paste0('{',json,'}'),'tmp/sesity-simulace.json',useBytes=TRUE)
