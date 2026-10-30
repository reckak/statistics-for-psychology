#set par(justify: true, leading: 0.65em)
#show link: set text(fill: rgb("245b78"))
#show figure.caption: set text(size: 9pt)
#show table: set text(size: 9pt)
#show table: set par(justify: false)
#show table: set text(hyphenate: false)
#show figure.where(kind: "quarto-float-tbl"): set figure.caption(position: top)
#show figure.where(kind: "quarto-float-tbl"): set align(left)
#show figure.where(kind: "quarto-float-tbl"): it => {
  show figure.caption: cap => context {
    let label = [#cap.supplement #counter(figure.where(kind: "quarto-float-tbl")).display(it.numbering)]
    block(above: 0pt, below: 6pt)[#strong(label) #linebreak()#emph(cap.body)]
  }
  it
}
// Pandoc supplies table.header and cells in source order. Find semantic totals.
#show table: it => {
  if type(it.stroke) == function { return it }
  let cells = ()
  for child in it.children {
    if child.func() == table.header or child.func() == table.footer {
      cells += child.children
    } else if child.func() == table.cell { cells.push(child) }
  }
  let columns = it.columns.len()
  let rows = calc.ceil(cells.len() / columns)
  let summaries = ()
  for (i, cell) in cells.enumerate() {
    if calc.rem(i, columns) == 0 and repr(cell.body).contains(regex("(Součet|Celkem)")) {
      summaries.push(calc.floor(i / columns))
    }
  }
  let args = it.fields()
  let _ = args.remove("children")
  args.stroke = (x, y) => (
    top: if y <= 1 or y in summaries { 0.8pt } else { (paint: rgb("c8c8c8"), thickness: 0.3pt) },
    bottom: if y == rows - 1 { 0.8pt } else { none },
    left: none, right: none,
  )
  // Override the writer's explicit default hline with the agreed header rule.
  show table.hline: set table.hline(stroke: 0.8pt)
  table(..args, ..it.children)
}
#show raw: set text(size: 8.5pt)
#show <refs>: set par(hanging-indent: 1.27cm, justify: false)
#counter(heading).update(@OFFSET@)
#set figure(numbering: n => "@CHAPTER@." + str(n))
#set page(header: text(size: 8pt, fill: rgb("666666"))[Základy statistiky pro psychology 1 · Kapitola @CHAPTER@])
#pagebreak()
