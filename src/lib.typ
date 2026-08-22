#import "cmd.typ": mark, boxed

#let writing(
  syntax: true,
  paged: false,
  custom-styling: true,
  catppuccin-flavor: "mocha",
  accent-color: auto,
  body
) = context {
  import "@preview/catppuccin:1.1.0": catppuccin, get-flavor
  import "@preview/nexus-tools:0.3.0": default, storage
  import "util.typ": defaults
  import "syntax.typ" as syntax-init
  
  let default = default.with(not custom-styling)
  let flavor = get-flavor(catppuccin-flavor)
  let accent-color = if accent-color == auto {flavor.colors.mauve.rgb} else {accent-color}
  let font-size = text.size
  let body = body
  
  storage.add("catppuccin-flavor", catppuccin-flavor, namespace: "min-writing")
  
  set page(
    ..default(
      when: not paged and page.margin == defaults.page.margin,
      value: (margin: (x: 2em, y: 3em)),
    ),
    ..default(
      when: not paged and repr(page.width) == defaults.page.width,
      value: (width: 26em),
    ),
    ..default(
      when: not paged and repr(page.height) == defaults.page.height,
      value: (height: auto),
    ),
    header: context if locate(here()).page() > 1 {
      set align(right)
      text(
        document.title,
        style: "italic",
        fill: flavor.colors.subtext0.rgb,
      )
    },
    footer: {
      set align(center)
      text(
        counter(page).display("1/1", both: true),
        style: "italic",
        fill: flavor.colors.subtext0.rgb,
      )
    },
  )
  set heading(
    ..default(
      when: heading.numbering == defaults.heading.numbering,
      value: (numbering: "1."),
    ),
  )
  set text(
    ..default(
      when: text.font == defaults.text.font,
      value: (font: ("tex gyre heros", "arial")),
    ),
  )
  set table(
    ..default(
      when: syntax and repr(table.stroke) == defaults.table.stroke,
      value: (stroke: 1pt + flavor.colors.crust.rgb),
    ),
    ..default(
      when: syntax and table.fill == defaults.table.fill,
      value: (fill: (_,y) => if calc.even(y) {flavor.colors.mantle.rgb} else {none}),
    ),
  )
  set rect(
    ..default(
      when: syntax and rect.fill == defaults.rect.stroke,
      value: (stroke: accent-color),
    ),
  )
  set par(justify: true)
  set terms(separator: [: ], tight: true)
  
  show heading: it => {
    set text(
      ..default(
        when: text.font == ("tex gyre heros", "arial"),
        value: (font: ("tex gyre adventor", "century gothic")),
      ),
      size: font-size + 5pt,
    )
    
    it
  }
  show divider: it => if it.func() != divider {it} else {
    set align(center)
    set text(size: 5pt)
    set line(stroke: 1pt + flavor.colors.subtext0.rgb)
    
    v(1em)
    text({
      line(length: 70%)
      line(length: 60%)
      line(length: 50%)
    })
    v(1em)
  }
  show figure.caption: set text(size: 1em - 2pt)
  show figure: set figure.caption(position: top)
  show footnote.entry: set text(size: font-size - 2pt)
  show heading.where(numbering: none): set align(center)
  show math.equation.where(block: true): set math.equation(numbering: "(1)")
  show quote.where(block: true): it => pad(x: 1em, it)
  show raw.where(block: true): it => pad(left: 1em, it)
  show bibliography: bibliography.with(style: "associacao-brasileira-de-normas-tecnicas")
  show: catppuccin.with(flavor) // set document styling
  show: syntax-init.unnumbered-headings.with(enable: syntax)
  show: syntax-init.quotes.with(enable: syntax)
  show: syntax-init.pagebreaks.with(enable: syntax, paged: paged)
  show: syntax-init.inline.with(enable: syntax, accent-color: accent-color)
  
  // Ignore #pagebreak
  if not paged {
    body = body.children.filter(elem => elem.func() != pagebreak).join()
  }
  
  // Document title heading
  if document.title != none {
    heading(
      level: 1,
      outlined: false,
      numbering: none,
      align(center)[#document.title]
    )
  }
  
  // Insert document author
  if document.author != () {
    set align(right)
    
    let authors = document.author
    
    if type(authors) != array {authors = (authors)}
    
    authors.map(author => emph(author) + linebreak()).join()
  }
  
  body
}