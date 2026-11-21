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

# One plotted series. `data` is a data frame of the values as drawn; `mark` is one of
# 'body' (points), 'sloupce' (bars at x with height y), 'histogram' (bins od–do with cetnost),
# 'cara' (a line through the listed points).
tf_series <- function(name, data, mark = 'body', digits = 2, note = NULL) {
  stopifnot(is.data.frame(data), nrow(data) > 0, mark %in% c('body', 'sloupce', 'histogram', 'cara'))
  data[] <- lapply(data, function(col) if (is.numeric(col)) round(col, digits) else as.character(col))
  list(name = name, mark = mark, note = note, data = data)
}
# Reference line: axis 'x' (vertical at value), 'y' (horizontal at value) or 'primka'
# (value = c(intercept, slope)).
tf_guide <- function(axis, value, label = NULL) {
  stopifnot(axis %in% c('x', 'y', 'primka'))
  list(axis = axis, value = value, label = label)
}
tf_panel <- function(title, type, xlab, ylab, series, xlim = NULL, ylim = NULL, guides = NULL, note = NULL) {
  stopifnot(type %in% c('bodový graf', 'histogram', 'sloupcový graf', 'čárový graf'), length(series) > 0)
  list(title = title, type = type, x = list(label = xlab, range = xlim), y = list(label = ylab, range = ylim),
       guides = guides, note = note, series = series)
}
# Histogram counts exactly as drawn by hist(v, breaks); empty bins are left out.
tf_bins <- function(v, breaks) {
  h <- hist(v, breaks = breaks, plot = FALSE)
  out <- data.frame(od = head(h$breaks, -1), do = h$breaks[-1], cetnost = h$counts)
  out[out$cetnost > 0, ]
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
