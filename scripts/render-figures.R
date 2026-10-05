# Explicit UTF-8 input and Windows locale keep Czech labels portable.
if (.Platform$OS.type == 'windows') {
  locale <- Sys.setlocale('LC_CTYPE', '.UTF-8')
  if (locale == '') stop('A UTF-8 locale is required for the chapter figures.')
}
source('scripts/kapitola_02.R', encoding = 'UTF-8')
source('scripts/kapitola_03.R', encoding = 'UTF-8')
