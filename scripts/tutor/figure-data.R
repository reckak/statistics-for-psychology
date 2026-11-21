# Data and a short description of a chapter figure for the AI tutor, so that the tutor can
# redraw the figure in a chat. Base R only; numbers always use a decimal point, whatever
# options(OutDec) says. One JSON file per figure: tmp/tutor-figures/<chapter>/<name>.json.
# The chapter script stays the single source of the plotted values: call tf_figure() right
# after the drawing code with the same objects. The export reads these files; the web book does not.

tf_num <- function(x) {
  out <- formatC(x, digits = 10, format = 'g', decimal.mark = '.')
  out <- trimws(out)
  out[!is.finite(x)] <- 'null'
  out
}
tf_str <- function(x) {
  x <- enc2utf8(as.character(x))
  x <- gsub('\\', '\\\\', x, fixed = TRUE)
  x <- gsub('"', '\\"', x, fixed = TRUE)
  x <- gsub('\n', '\\n', x, fixed = TRUE)
  paste0('"', x, '"')
}
tf_json <- function(x) {
  if (is.null(x)) return('null')
  if (is.data.frame(x)) {
    rows <- vapply(seq_len(nrow(x)), function(i) {
      paste0('[', paste(vapply(x, function(col) if (is.numeric(col)) tf_num(col[i]) else tf_str(col[i]), ''), collapse = ','), ']')
    }, '')
    return(paste0('{"columns":[', paste(tf_str(names(x)), collapse = ','), '],"rows":[', paste(rows, collapse = ','), ']}'))
  }
  if (is.list(x)) {
    if (is.null(names(x))) return(paste0('[', paste(vapply(x, tf_json, ''), collapse = ','), ']'))
    keep <- !vapply(x, is.null, TRUE)
    return(paste0('{', paste(paste0(tf_str(names(x)[keep]), ':', vapply(x[keep], tf_json, '')), collapse = ','), '}'))
  }
  if (is.logical(x)) return(if (length(x) == 1) tolower(as.character(x)) else paste0('[', paste(tolower(as.character(x)), collapse = ','), ']'))
  if (is.numeric(x)) return(if (length(x) == 1) tf_num(x) else paste0('[', paste(tf_num(x), collapse = ','), ']'))
  if (length(x) == 1) tf_str(x) else paste0('[', paste(tf_str(x), collapse = ','), ']')
}

# One plotted series. `data` is a data frame of the values as drawn; `mark` says how to draw it.
# A text column `kategorie` may stand for the numeric position (x or poloha): rows are then
# categories in axis order.
#   'body'      points: x, y
#   'sloupce'   bars at x with height y; optional `skupina` with arrangement 'skládané' / 'vedle sebe'
#   'histogram' bins od–do with cetnost, hustota or podil
#   'cara'      a line through the listed points: x, y
#   'plocha'    a filled area between y0 (zero if absent) and y over x
#   'interval'  a segment od–do at poloha with an optional point stred; `direction` gives its
#               orientation ('vodorovně' / 'svisle'); a missing bound is an open end
#   'usecky'    separate segments x0, y0, x1, y1
#   'krabice'   a box plot: dolni_vous, q1, median, q3, horni_vous at poloha; `direction` as above
#   'tabulka'   cells of a table or mosaic; columns are free
tf_marks <- c('body', 'sloupce', 'histogram', 'cara', 'plocha', 'interval', 'usecky', 'krabice', 'tabulka')
tf_series <- function(name, data, mark = 'body', digits = 2, note = NULL, direction = NULL, arrangement = NULL) {
  stopifnot(is.data.frame(data), nrow(data) > 0, mark %in% tf_marks,
            is.null(direction) || direction %in% c('vodorovně', 'svisle'),
            is.null(arrangement) || arrangement %in% c('skládané', 'vedle sebe'),
            !(mark %in% c('interval', 'krabice')) || !is.null(direction))
  data[] <- lapply(data, function(col) if (is.numeric(col)) round(col, digits) else { col <- as.character(col); col[is.na(col)] <- ''; col })
  rownames(data) <- NULL
  list(name = name, mark = mark, direction = direction, arrangement = arrangement, note = note, data = data)
}
# A curve f sampled at n points as a 'cara' (or 'plocha') series.
tf_curve <- function(name, f, from, to, n = 61, digits = 4, note = NULL, mark = 'cara') {
  x <- seq(from, to, length.out = n)
  tf_series(name, data.frame(x = x, y = f(x)), mark, digits, note)
}
# Reference line: axis 'x' (vertical at value), 'y' (horizontal at value), 'primka'
# (value = c(intercept, slope)), or a shaded band 'pasmo x' / 'pasmo y' (value = c(from, to)).
tf_guide <- function(axis, value, label = NULL) {
  stopifnot(axis %in% c('x', 'y', 'primka', 'pasmo x', 'pasmo y'))
  list(axis = axis, value = signif(value, 6), label = label)
}
tf_band <- function(axis, from, to, label = NULL) tf_guide(paste('pasmo', axis), c(from, to), label)
tf_types <- c('bodový graf', 'histogram', 'sloupcový graf', 'čárový graf', 'intervalový graf', 'krabicový graf',
              'výsečový graf', 'tabulka')
# Axis labels may be NULL only where the panel has no axes (a table, a pie chart).
tf_panel <- function(title, type, xlab = NULL, ylab = NULL, series, xlim = NULL, ylim = NULL, guides = NULL, note = NULL) {
  stopifnot(type %in% tf_types, length(series) > 0, type %in% c('výsečový graf', 'tabulka') || (!is.null(xlab) && !is.null(ylab)))
  rng <- function(r) if (!is.null(r)) signif(r, 6)
  list(title = title, type = type, x = if (!is.null(xlab)) list(label = xlab, range = rng(xlim)), y = if (!is.null(ylab)) list(label = ylab, range = rng(ylim)),
       guides = guides, note = note, series = series)
}
# Histogram bins exactly as drawn by hist(v, breaks); empty bins are left out.
# `scale`: 'cetnost' (counts), 'hustota' (density) or 'podil' (proportion of values).
tf_bins <- function(v, breaks, scale = 'cetnost') {
  h <- hist(v, breaks = breaks, plot = FALSE)
  out <- data.frame(od = head(h$breaks, -1), do = h$breaks[-1])
  out[[scale]] <- switch(scale, cetnost = h$counts, hustota = h$density, podil = h$counts / sum(h$counts))
  out[h$counts > 0, ]
}
# `kind`: 'data' (observed or authored teaching data), 'simulace' (fixed-seed simulation; the
# listed values are those in the figure), 'krivka' (a curve from stated parameters),
# 'sloupce' (bars or counts), 'schema' (a diagram with no data; panels = NULL).
tf_figure <- function(chapter, name, kind, title = NULL, note = NULL, panels = NULL) {
  stopifnot(kind %in% c('data', 'simulace', 'krivka', 'sloupce', 'schema'), kind == 'schema' || length(panels) > 0)
  dir <- file.path('tmp', 'tutor-figures', chapter)
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
  json <- tf_json(list(figure = name, kind = kind, title = title, note = note, panels = panels))
  con <- file(file.path(dir, paste0(name, '.json')), open = 'wb')
  on.exit(close(con))
  writeBin(charToRaw(enc2utf8(json)), con)
  invisible(NULL)
}
tf_schema <- function(chapter, name) tf_figure(chapter, name, 'schema')
