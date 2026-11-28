# Statistical symbols in chapter figures set in the math font STIX Two Math (R89).
#
# Markup inside an ordinary label string:
#   *r*    Latin letters as mathematical italic, e.g. '40 studentů: *r* = 0,52', '*t*-test'
#   _{..}  subscript of the preceding symbol, e.g. '*r*_{*s*}', '*H*_{0}', 'τ_{*b*}', '*s*_{*D*}'
#   ^{..}  superscript, e.g. '*z*^{2}'
# Greek letters, '√' and ²/³ directly after a symbol or after ')' are set upright in the
# math font automatically. Numbers, '=', words and units stay in the figure font. A label without
# markup or Greek is passed unchanged to the base function, so it looks exactly as before.
#
# Base graphics cannot mix font families within one string (plotmath only switches faces),
# so labels with symbols are drawn segment by segment. The baselines follow R's own
# placement rules, measured on the cairo svg() device on 2026-11-28 (see quarto/README.md):
#   text(adj = c(x, y)): last line's baseline at y - y_adj * (M height + (lines - 1) * line height);
#   pos 1-4: offsets in character heights, vertical adjustment 5/6, 1/3 or 0 of the M height;
#   margins: side 1 and 4 at line + 1 - ylbias, side 2 and 3 at line + ylbias;
#   title(main): centred in the top margin, or the last line at `line` when given.
# The font must be installed (docs/PROVOZ.md); fl_check_font() stops a render that would
# silently fall back to another font.

fl_family <- 'STIX Two Math'

fl_check_font <- function() {
  w <- function(f) strwidth('\U0001D45F\U0001D45A', units = 'inches', family = f)
  if (abs(w(fl_family) - w('sans')) < 1e-6)
    stop('Písmo "', fl_family, '" není dostupné; nainstalujte scripts/fonts/STIXTwoMath-Regular.otf (docs/PROVOZ.md).', call. = FALSE)
}

fl_symbol_pattern <- '[*_^√Α-Ωα-ω]'
# options(fl.force = TRUE) routes plain labels through the segment drawing as well; the
# calibration check compares their glyph positions with the base functions.
fl_has_symbols <- function(s) !is.na(s) & (isTRUE(getOption('fl.force')) | grepl(fl_symbol_pattern, s, perl = TRUE))

# Code points: mathematical italic (bold italic in bold labels), bold upright Greek and digits.
fl_italic <- function(s, bold) {
  cp <- utf8ToInt(s); up <- cp >= 0x41 & cp <= 0x5A; lo <- cp >= 0x61 & cp <= 0x7A
  if (bold) { cp[up] <- 0x1D468 + cp[up] - 0x41; cp[lo] <- 0x1D482 + cp[lo] - 0x61 }
  else { h <- cp == 0x68; cp[up] <- 0x1D434 + cp[up] - 0x41; cp[lo] <- 0x1D44E + cp[lo] - 0x61; cp[h] <- 0x210E }
  intToUtf8(cp)
}
fl_upright <- function(s, bold) {
  if (!bold) return(s)
  cp <- utf8ToInt(s)
  g1 <- cp >= 0x391 & cp <= 0x3A9; g2 <- cp >= 0x3B1 & cp <= 0x3C9; d <- cp >= 0x30 & cp <= 0x39
  cp[g1] <- 0x1D6A8 + cp[g1] - 0x391; cp[g2] <- 0x1D6C2 + cp[g2] - 0x3B1; cp[d] <- 0x1D7CE + cp[d] - 0x30
  intToUtf8(cp)
}

# One line of a label -> data frame of segments: text, math font?, relative size, shift (-1 sub, 1 sup).
fl_segments <- function(s, bold = FALSE) {
  pat <- '\\*[A-Za-z]+\\*|_\\{[^{}]*\\}|\\^\\{[^{}]*\\}|[√Α-Ωα-ω]|[²³]'
  m <- gregexpr(pat, s, perl = TRUE)[[1]]
  out <- list(); add <- function(txt, math, size = 1, shift = 0)
    if (nzchar(txt)) out[[length(out) + 1]] <<- data.frame(txt = txt, math = math, size = size, shift = shift)
  # Content of a sub- or superscript: everything belongs to the symbol, so all of it is math font.
  inner <- function(x, shift) {
    mm <- gregexpr('\\*[A-Za-z]+\\*', x, perl = TRUE)[[1]]; pos <- 1
    if (mm[1] > 0) for (j in seq_along(mm)) {
      add(fl_upright(substr(x, pos, mm[j] - 1), bold), TRUE, .7, shift)
      add(fl_italic(substr(x, mm[j] + 1, mm[j] + attr(mm, 'match.length')[j] - 2), bold), TRUE, .7, shift)
      pos <- mm[j] + attr(mm, 'match.length')[j] }
    add(fl_upright(substr(x, pos, nchar(x)), bold), TRUE, .7, shift)
  }
  pos <- 1
  if (m[1] > 0) for (j in seq_along(m)) {
    add(substr(s, pos, m[j] - 1), FALSE)
    tok <- substr(s, m[j], m[j] + attr(m, 'match.length')[j] - 1)
    first <- substr(tok, 1, 1)
    if (first == '*') add(fl_italic(substr(tok, 2, nchar(tok) - 1), bold), TRUE)
    else if (first == '_') inner(substr(tok, 3, nchar(tok) - 1), -1)
    else if (first == '^') inner(substr(tok, 3, nchar(tok) - 1), 1)
    else if (tok %in% c('²', '³')) {
      # A square after a symbol or a bracketed expression of symbols belongs to the formula;
      # STIX has no bold ², so bold labels get a raised bold digit instead.
      prev <- if (length(out)) out[[length(out)]] else NULL
      math <- !is.null(prev) && (prev$math || grepl('[)]$', prev$txt))
      if (math && bold) add(fl_upright(if (tok == '²') '2' else '3', TRUE), TRUE, .7, 1) else add(tok, math)
    }
    else add(fl_upright(tok, bold), TRUE)
    pos <- m[j] + attr(m, 'match.length')[j]
  }
  add(substr(s, pos, nchar(s)), FALSE)
  if (!length(out)) return(data.frame(txt = '', math = FALSE, size = 1, shift = 0))
  d <- do.call(rbind, out)
  if (any(grepl('[*]|[_^][{]', d$txt[!d$math])))   # literal braces, e.g. {X = 1}, are allowed
    stop('Nepárová značka v popisku: ', s, call. = FALSE)
  d
}

# Segment widths in inches; cex is relative to par('cex') as in text().
fl_widths <- function(d, cex, font) {
  vapply(seq_len(nrow(d)), function(i)
    strwidth(d$txt[i], units = 'inches', cex = cex * d$size[i], font = if (d$math[i]) 1 else font,
             family = if (d$math[i]) fl_family else par('family')), 0)
}

# Draws prepared lines from an anchor in device inches.
# ax: adjustment along the reading direction; v_last: baseline of the last line relative
# to the anchor (inches, up = positive in the text frame); srt 0 or 90.
fl_draw <- function(lines, x_in, y_in, ax, v_last, cex, col, font, srt, lh) {
  th <- srt * pi / 180; eu <- c(cos(th), sin(th)); ev <- c(-sin(th), cos(th))
  em <- par('ps') * par('cex') * cex / 72
  n <- length(lines)
  for (j in seq_len(n)) {
    d <- lines[[j]]; w <- fl_widths(d, cex, font); start <- -ax * sum(w)
    v <- v_last + (n - j) * lh
    for (i in seq_len(nrow(d))) {
      u <- start + sum(w[seq_len(i - 1)])
      vv <- v + c(-.22, 0, .38)[d$shift[i] + 2] * em
      px <- x_in + u * eu[1] + vv * ev[1]; py <- y_in + u * eu[2] + vv * ev[2]
      text(grconvertX(px, 'inches', 'user'), grconvertY(py, 'inches', 'user'), d$txt[i], adj = c(0, 0), srt = srt,
           cex = cex * d$size[i], col = col, font = if (d$math[i]) 1 else font,
           family = if (d$math[i]) fl_family else par('family'), xpd = NA)
    }
  }
}

fl_lines <- function(s, bold) lapply(strsplit(s, '\n', fixed = TRUE)[[1]], fl_segments, bold = bold)
fl_mheight <- function(cex, font) strheight('M', units = 'inches', cex = cex, font = font)
fl_lheight <- function(cex) par('cin')[2] * par('cex') * cex * par('lheight')
fl_bold <- function(font) font %in% c(2, 4)

# R's "exact" vertical centring of a one-line label without a vertical adj: half of (highest
# ascent - deepest descent) of its characters. Computed for the label as it would be set
# entirely in the figure font, i.e. where base text() would have put the plain label.
fl_plain <- function(s) gsub('[*]|[_^][{]|[}]', '', s)
fl_centre <- function(s, cex, font) {
  gp <- grid::gpar(fontfamily = par('family'), fontface = font, fontsize = par('ps'), cex = par('cex') * cex)
  g <- grid::textGrob(fl_plain(s), gp = gp)
  .5 * (grid::convertHeight(grid::grobAscent(g), 'inches', valueOnly = TRUE) -
        grid::convertHeight(grid::grobDescent(g), 'inches', valueOnly = TRUE))
}

# text() with symbols. Supports adj, pos/offset, cex, col, font, srt 0 or 90 and '\n'.
fl_text <- function(x, y = NULL, labels, adj = NULL, pos = NULL, offset = .5, cex = 1, col = par('col'),
                    font = par('font'), srt = 0, xpd = par('xpd')) {
  xy <- xy.coords(x, y, recycle = TRUE, setLab = FALSE); n <- max(length(xy$x), length(labels))
  labels <- rep_len(as.character(labels), n); xs <- rep_len(xy$x, n); ys <- rep_len(xy$y, n)
  cex <- rep_len(cex, n); col <- rep_len(col, n); font <- rep_len(font, n); if (!is.null(pos)) pos <- rep_len(pos, n)
  for (i in seq_len(n)) {
    if (!fl_has_symbols(labels[i])) {
      text(xs[i], ys[i], labels[i], adj = adj, pos = if (!is.null(pos)) pos[i], offset = offset, cex = cex[i], col = col[i],
           font = font[i], srt = srt, xpd = xpd); next }
    fl_check_font()
    if (!(srt %in% c(0, 90))) stop('fl_text: srt musí být 0 nebo 90.', call. = FALSE)
    a <- if (is.null(adj)) c(par('adj'), NA) else if (length(adj) == 1) c(adj, NA) else adj
    x_in <- grconvertX(xs[i], 'user', 'inches'); y_in <- grconvertY(ys[i], 'user', 'inches')
    if (!is.null(pos)) {
      off <- offset * par('cin')[2] * par('cex')   # character heights at par('cex'), whatever the label's cex
      a <- switch(pos[i], c(.5, 5/6), c(1, 1/3), c(.5, 0), c(0, 1/3))
      d <- switch(pos[i], c(0, -off), c(-off, 0), c(0, off), c(off, 0))
      x_in <- x_in + d[1]; y_in <- y_in + d[2] }
    ln <- fl_lines(labels[i], fl_bold(font[i])); lh <- fl_lheight(cex[i])
    v_last <- if (is.na(a[2]) && length(ln) == 1) -fl_centre(labels[i], cex[i], font[i])
              else -(if (is.na(a[2])) .5 else a[2]) * (fl_mheight(cex[i], font[i]) + (length(ln) - 1) * lh)
    fl_draw(ln, x_in, y_in, a[1], v_last, cex[i], col[i], font[i], srt, lh)
  }
  invisible(NULL)
}

# Plot region (or, for outer = TRUE, the inner region within the outer margins) in device
# inches and the margin line height.
fl_frame <- function(outer = FALSE) {
  L <- par('csi') * par('mex')
  if (outer) return(list(l = grconvertX(0, 'nic', 'inches'), r = grconvertX(1, 'nic', 'inches'),
                         b = grconvertY(0, 'nic', 'inches'), t = grconvertY(1, 'nic', 'inches'), L = L))
  u <- par('usr')
  list(l = grconvertX(u[1], 'user', 'inches'), r = grconvertX(u[2], 'user', 'inches'),
       b = grconvertY(u[3], 'user', 'inches'), t = grconvertY(u[4], 'user', 'inches'), L = L)
}

# mtext() with symbols (cex is absolute, as in mtext()). Text parallel to the axis, or
# horizontal text in the side margins (las = 1 or 2 on side 2 and 4); one line only.
fl_mtext <- function(text, side = 3, line = 0, outer = FALSE, at = NA, adj = NA, cex = NA, col = NA, font = NA, las = par('las')) {
  if (!fl_has_symbols(text)) {
    mtext(text, side = side, line = line, outer = outer, at = at, adj = adj, cex = cex, col = col, font = font, las = las); return(invisible()) }
  fl_check_font()
  if (side %in% c(1, 3) && las %in% c(2, 3)) stop('fl_mtext: svislý text na straně 1 a 3 není podporován.', call. = FALSE)
  cex <- if (is.na(cex)) 1 / par('cex') else cex / par('cex'); col <- if (is.na(col)) par('col') else col
  font <- if (is.na(font)) par('font') else font
  if (outer && !is.na(at)) stop('fl_mtext: outer = TRUE jen bez at.', call. = FALSE)
  f <- fl_frame(outer); ylb <- par('ylbias')
  ln <- fl_lines(text, fl_bold(font)); lh <- fl_lheight(cex)
  if (length(ln) > 1) stop('fl_mtext: víceřádkový text není podporován.', call. = FALSE)
  if (side %in% c(2, 4) && las %in% c(1, 2)) {
    # Horizontal: aligned towards the axis at `line`, centred on `at` by half the M height.
    ax <- if (is.na(adj)) as.numeric(side == 2) else adj
    y <- if (is.na(at)) (f$b + f$t) / 2 else grconvertY(at, 'user', 'inches')
    x <- if (side == 2) f$l - line * f$L else f$r + line * f$L
    fl_draw(ln, x, y, ax, -.5 * fl_mheight(cex, font), cex, col, font, 0, lh)
    return(invisible(NULL))
  }
  adj <- if (is.na(adj)) .5 else adj
  pos_along <- function(lo, hi, user) if (is.na(at)) lo + adj * (hi - lo) else user
  if (side %in% c(1, 3)) {
    x <- pos_along(f$l, f$r, grconvertX(at, 'user', 'inches'))
    y <- if (side == 1) f$b - (line + 1 - ylb) * f$L else f$t + (line + ylb) * f$L
    fl_draw(ln, x, y, adj, 0, cex, col, font, 0, lh)
  } else {
    y <- pos_along(f$b, f$t, grconvertY(at, 'user', 'inches'))
    x <- if (side == 2) f$l - (line + ylb) * f$L else f$r + (line + 1 - ylb) * f$L
    fl_draw(ln, x, y, adj, 0, cex, col, font, 90, lh)
  }
  invisible(NULL)
}

# Width of a label as drawn by the fl_* functions (widest line), in user x units or inches.
fl_strwidth <- function(s, units = 'user', cex = 1, font = par('font')) {
  vapply(s, function(x) {
    w <- if (!fl_has_symbols(x)) max(strwidth(strsplit(x, '
', fixed = TRUE)[[1]], units = 'inches', cex = cex, font = font))
         else max(vapply(fl_lines(x, fl_bold(font)), function(d) sum(fl_widths(d, cex, font)), 0))
    if (units == 'inches') w else abs(diff(grconvertX(c(0, w), 'inches', 'user')))
  }, 0, USE.NAMES = FALSE)
}

# title() with symbols; arguments without symbols go to title() unchanged.
fl_title <- function(main = NULL, xlab = NULL, ylab = NULL, line = NA, adj = par('adj'),
                     cex.main = par('cex.main'), font.main = par('font.main'), col.main = par('col.main'),
                     cex.lab = par('cex.lab'), font.lab = par('font.lab'), col.lab = par('col.lab')) {
  plain <- function(s) !is.null(s) && !fl_has_symbols(s)
  if (plain(main)) title(main = main, line = line, adj = adj, cex.main = cex.main, font.main = font.main, col.main = col.main)
  if (plain(xlab)) title(xlab = xlab, line = line, adj = adj, cex.lab = cex.lab, font.lab = font.lab, col.lab = col.lab)
  if (plain(ylab)) title(ylab = ylab, line = line, adj = adj, cex.lab = cex.lab, font.lab = font.lab, col.lab = col.lab)
  f <- fl_frame()
  if (!is.null(main) && fl_has_symbols(main)) {
    fl_check_font(); ln <- fl_lines(main, fl_bold(font.main)); lh <- fl_lheight(cex.main)
    block <- fl_mheight(cex.main, font.main) + (length(ln) - 1) * lh
    y <- if (is.na(line)) f$t + par('mar')[3] * f$L / 2 - block / 2 else f$t + line * f$L
    fl_draw(ln, f$l + adj * (f$r - f$l), y, adj, 0, cex.main, col.main, font.main, 0, lh)
  }
  lab_line <- if (is.na(line)) par('mgp')[1] else line
  if (!is.null(xlab) && fl_has_symbols(xlab)) {
    # Below the axis further lines go downwards: the first line keeps the usual baseline.
    fl_check_font(); ln <- fl_lines(xlab, fl_bold(font.lab)); lh <- fl_lheight(cex.lab)
    fl_draw(ln, f$l + adj * (f$r - f$l), f$b - (lab_line + 1 - par('ylbias')) * f$L,
            adj, -(length(ln) - 1) * lh, cex.lab, col.lab, font.lab, 0, lh) }
  if (!is.null(ylab) && fl_has_symbols(ylab)) {
    fl_check_font()
    fl_draw(fl_lines(ylab, fl_bold(font.lab)), f$l - (lab_line + par('ylbias')) * f$L, f$b + adj * (f$t - f$b),
            adj, 0, cex.lab, col.lab, font.lab, 90, fl_lheight(cex.lab)) }
  invisible(NULL)
}

# Tick labels with symbols: horizontal labels on side 1, or on side 2 with las = 1. The axis
# line and ticks come from axis(); every label is then placed by the same rules as axis() uses.
fl_axis <- function(side, at, labels, line = NA, cex.axis = par('cex.axis'), col.axis = par('col.axis'),
                    font.axis = par('font.axis'), las = par('las'), ...) {
  if (!(side == 1 || side == 2 && las == 1)) stop('fl_axis: podporována je strana 1 a strana 2 s las = 1.', call. = FALSE)
  axis(side, at = at, labels = FALSE, line = line, ...)
  if (any(fl_has_symbols(labels))) fl_check_font()
  f <- fl_frame(); ml <- par('mgp')[2] + if (is.na(line)) 0 else line
  labels <- rep_len(as.character(labels), length(at))
  for (i in seq_along(at)) {
    ln <- fl_lines(labels[i], fl_bold(font.axis)); lh <- fl_lheight(cex.axis)
    if (side == 1)
      fl_draw(ln, grconvertX(at[i], 'user', 'inches'), f$b - (ml + 1 - par('ylbias')) * f$L, .5, -(length(ln) - 1) * lh,
              cex.axis, col.axis, font.axis, 0, lh)
    else
      fl_draw(ln, f$l - ml * f$L, grconvertY(at[i], 'user', 'inches'), 1,
              -.5 * (fl_mheight(cex.axis, font.axis) + (length(ln) - 1) * lh), cex.axis, col.axis, font.axis, 0, lh)
  }
  invisible(NULL)
}

# legend() with symbols: the legend is drawn with empty labels of the right width,
# then the labels are added at the returned text positions (legend draws them with adj = c(0, 0.5)).
fl_legend <- function(x, y = NULL, legend, cex = 1, text.col = par('col'), text.font = NULL, ncol = 1, horiz = FALSE, ...) {
  if (missing(legend) && is.character(y)) { legend <- y; y <- NULL }   # legend('topright', labels, ...)
  if (!any(fl_has_symbols(legend))) return(invisible(graphics::legend(x, y, legend = legend, cex = cex, text.col = text.col,
                                                                       text.font = text.font, ncol = ncol, horiz = horiz, ...)))
  fl_check_font()
  font <- if (is.null(text.font)) par('font') else text.font
  w <- fl_strwidth(legend, cex = cex, font = font)
  # Like legend()'s default, every column gets the width of the widest label.
  r <- graphics::legend(x, y, legend = rep('', length(legend)), cex = cex, text.font = text.font, ncol = ncol, horiz = horiz,
                        text.width = max(w), ...)
  fl_text(r$text$x, r$text$y, legend, adj = c(0, .5), cex = cex, col = text.col, font = font, xpd = NA)
  invisible(r)
}
