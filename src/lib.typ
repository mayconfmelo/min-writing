#import "cmd.typ": mark, boxed, mermaid

#let writing(
  syntax: true,
  paged: false,
  custom-styling: true,
  catppuccin-flavor: "mocha",
  accent-color: auto,
  help: false,
  body
) = context {
  import "@preview/catppuccin:1.1.0": catppuccin, get-flavor
  import "@preview/nexus-tools:0.3.0": default, storage
  import "util.typ": defaults, custom-divider
  import "syntax.typ" as syntax-init
  
  let default = default.with(not custom-styling)
  let flavor = get-flavor(catppuccin-flavor)
  let accent-color = if accent-color == auto {flavor.colors.mauve.rgb} else {accent-color}
  let font-size = text.size
  let body = body
  
  storage.add("accent-color", accent-color, namespace: "min-writing")
  
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
      when: repr(table.stroke) == defaults.table.stroke,
      value: (stroke: 1pt + flavor.colors.crust.rgb),
    ),
    ..default(
      when: table.fill == defaults.table.fill,
      value: (fill: (_,y) => if calc.even(y) {flavor.colors.mantle.rgb} else {none}),
    ),
  )
  set table.cell(
    ..default(
      when: table.cell.inset == defaults.table.cell.inset,
      value: (inset: (x: 0.5em, y: 0.75em))
    ),
  )
  set rect(
    ..default(
      when: rect.fill == defaults.rect.stroke,
      value: (stroke: accent-color),
    ),
  )
  set outline(
    ..default(
      when: not paged and outline.indent == defaults.outline.indent,
      value: (indent: 2em),
    ),
  )
  set par(justify: true)
  set terms(separator: [: ], tight: true)
  set footnote.entry(separator: line(length: 30% + 0pt, stroke: 0.05em + flavor.colors.subtext0.rgb))
  
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
  show raw: it => {
    set text(
      size: font-size,
      ..default(
        when: text.font == defaults.raw.text.font,
        value: (font: ("fira mono", "inconsolata")),
      ),
    )
    
    it
  }
  show outline.entry: it => link(
    it.element.location(),
    it.indented(it.prefix(), it.body()),
  )
  show divider: custom-divider.with(color: flavor.colors.subtext0.rgb)
  show footnote: set line(stroke: 1pt + flavor.colors.subtext0.rgb)
  show figure.caption: set text(size: 1em - 2pt)
  show figure: set figure.caption(position: top)
  show footnote.entry: set text(size: font-size - 2pt)
  show heading.where(numbering: none): set align(center)
  show math.equation.where(block: true): set math.equation(numbering: "(1)")
  show quote.where(block: true): it => pad(x: 1em, it)
  show raw.where(block: true): it => pad(left: 1em, it)
  show bibliography: bibliography.with(style: "associacao-brasileira-de-normas-tecnicas")
  show: it => if custom-styling {catppuccin(flavor, it)} else {body} // set document styling
  show: syntax-init.unnumbered-headings.with(enable: syntax)
  show: syntax-init.quotes.with(enable: syntax)
  show: syntax-init.breaks.with(enable: syntax, paged: paged)
  show: syntax-init.inline.with(enable: syntax, accent-color: accent-color.transparentize(50%))
  show: syntax-init.check-lists.with(enable: syntax, stroke: accent-color, fill: if custom-styling {flavor.colors.base.rgb} else {white})
  show: syntax-init.dividers.with(enable: syntax)
  show: syntax-init.toc.with(enable: syntax)
  show: syntax-init.tables.with(enable: syntax)
  show: syntax-init.mermaid.with(enable: syntax)
  
  // Ignore #pagebreak
  if not paged {
    body = body.children.map(elem => if elem.func() == pagebreak {divider()} else {elem}).join()
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
  
  let header-data = ()
  
  // Document date
  if document.date != none {
    import "@preview/datify:1.0.0": custom-date-format
    
    let date = if document.date != auto {document.date} else {datetime.today()}
    
    date = custom-date-format(date, pattern: "long", lang: text.lang)

    header-data.push(date)
  }
  
  // Document author
  if not document.author in (none, ()) {
    header-data.push(document.author.map(author => emph(author) + linebreak()).join())
  }
  
  // Generate header data
  if header-data.len() > 0 {
    set align(center)
    
    grid(
      columns: (1fr,) * header-data.len(),
      align: (left, right),
      ..header-data,
    )
  }
  
  if document.description != none {
    set align(center)
    
    block(document.description, width: 90%, above: par.spacing)
    
    v(1em)
  }
  
  body
  
  if help {
    import "@preview/min-manual:0.3.0": example, arg
    import "lib.typ"
    
    set page(
      height: auto,
      header: align(right)[_`min-writing` help_]
    )
    
    let example = example.with(source: dictionary(lib))
    
    example(```
      strike
    ```)
  }
}