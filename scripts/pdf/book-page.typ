// Book PDF: each top-level heading opens a page; the running header names it.
#show heading.where(level: 1): it => { pagebreak(weak: true); it }
#set page(header: context {
  let previous = query(heading.where(level: 1).before(here()))
  let starting = query(heading.where(level: 1)).filter(h => h.location().page() == here().page())
  let current = if starting.len() > 0 { starting.first() } else if previous.len() > 0 { previous.last() }
  if current != none and starting.len() == 0 {
    let label = if current.numbering != none {
      [Kapitola #counter(heading).at(current.location()).first() · #current.body]
    } else { current.body }
    text(size: 8pt, fill: rgb("666666"))[Základy statistiky pro psychology · #label]
  }
})
// Long reference tables continue on the following pages with a repeated header.
#show figure.where(kind: "quarto-float-tbl"): set block(breakable: true)
