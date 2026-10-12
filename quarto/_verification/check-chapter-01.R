# Run from repository root: Rscript --vanilla quarto/_verification/check-chapter-01.R
# No packages, random data, workspace objects, or private sources required.
chapter <- readLines('quarto/kapitola_01.qmd', encoding = 'UTF-8', warn = FALSE)
table_lines <- grep('^\\| P0[1-6] \\|', chapter, value = TRUE)
parts <- lapply(strsplit(table_lines, '|', fixed = TRUE), function(x) trimws(x[2:6]))
dat <- as.data.frame(do.call(rbind, parts), stringsAsFactors = FALSE)
names(dat) <- c('id', 'sleep', 'words', 'time', 'rest')
dat$sleep <- as.numeric(dat$sleep)
dat$words <- as.integer(dat$words)
dat$rest <- as.integer(dat$rest)
stopifnot(nrow(dat) == 6L, !anyDuplicated(dat$id), identical(dat$id, sprintf('P%02d', 1:6)))
stopifnot(identical(which(is.na(dat$sleep)), 5L), dat$words[6] == 0L)
stopifnot(all(dat$sleep >= 0 & dat$sleep <= 24, na.rm = TRUE))
stopifnot(all(dat$words >= 0 & dat$words <= 12), all(dat$rest %in% 1:4))
stopifnot(all(dat$time %in% c('dopoledne', 'odpoledne')))
stopifnot(4L * 7L == 28L, 10 / 5 == 2, 8 / 4 == (8 * 60) / (4 * 60))
# Exercise 8: no invented zero for an unadministered task; known zero retained.
answer <- grep('^\\| K0[1-3] \\|', chapter, value = TRUE)
answer <- tail(answer, 3)
cells <- lapply(strsplit(answer, '|', fixed = TRUE), function(x) trimws(x[2:5]))
stopifnot(cells[[1]][3] == '0', cells[[2]][2] == '', cells[[3]][3] == '')
stopifnot(cells[[2]][1] == 'K02')
cat('Chapter 01: matrix, missing values, exercise 8 and elementary calculations passed.\n')

# Unit changes in the teaching diagram preserve the claimed relations.
celsius <- c(10, 15, 20, 25)
fahrenheit <- celsius * 9 / 5 + 32
stopifnot(identical(fahrenheit, c(50, 59, 68, 77)))
stopifnot(diff(fahrenheit[1:2]) == diff(fahrenheit[3:4]),
          celsius[3] / celsius[1] == 2, fahrenheit[3] / fahrenheit[1] == 1.36)
stopifnot(identical(order(c(1,2,3,4)), order(c(1,2,5,10))),
          length(unique(diff(c(1,2,5,10)))) > 1,
          all(round(c(6.8,7.2)) == 7))
visits <- expand.grid(person=c('A','B'), visit=1:2)
stopifnot(nrow(visits)==4, length(unique(visits$person))==2,
          !anyDuplicated(paste(visits$person,visits$visit)))
cat('Chapter 01: diagram conversions, ordinal recoding, rounding and repeated visits passed.\n')
