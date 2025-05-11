// NAME: Minimal Writings
// INFO: This package provides embedded doc-comments used by min-manual.
// TODO: Implement web writing/post (HTML) when stable

#import "doc.typ"
#import "glossary.typ"
#import "syntax.typ"

/**
 * = Quick Start
 * 
 * ```typ
 * #import "@preview/min-writing:0.1.1": writing, pagebreak
 * #show: writing.with(  
 *   title: "Main Title",
 *   subtitle: "Subtitle, generally two lines long or less",
 *   authors: (
 *     "Text Author <mailto:author@email.com>",
 *     "Collaborator <https://collab.site.com>"
 *   ),
 *   mode: "mobile",
 * )
 * ```
 * 
 * = Description
 * 
 * Generate everyday texts, writings, and anotations that can be confortably read
 * in smartphone screens, bigger screens, or printed paper.  This package also
 * provides some useful tools and helpers that simplify the writing process, to
 * make it easier and faster. The features can work in a all-parts-detachable way:
 * you can import each feature separately and use only whatever is useful at the
 * moment instead of everything that the package offers.
 * 
 * This manual will be updated only when new versions break or modify something;
 * otherwise, it will be valid to all newer versions starting by the one documented
 * here.
 * 
 * #pagebreak()
**/

// Nullifies page breaks in "mobile" amd "screen" modes
#let pagebreak = syntax.pagebreak


/** 
 * = Options
 * 
 * Those are the full list of options available and its default values:
 * 
 * :writing: show
 * 
 * Seems like an awfull lot to start with, but let's just break down all this to
 * understand it better, shall we?
 * 
 * ```typm #show: writing.with()``` -> content
 * Pass the entire document through `#writing` rules and stylizations with given
 * arguments, and then show it.
**/
#let writing(
  title: none,
    /** <- string | content | none
      * The title of the text, if any. **/
  subtitle: none,
    /** <- string | content | none
      * The text subtitle, if any; generally two lines long or less. **/
  authors: none,
    /** <- string | array
      * The author or authors of what is being documented --- not the manual.
      * When more than one author, is an array of strings, in format \
      * `("NAME <URL>", "NAME <URL>")`, where `<URL>` is optional. **/
  mode: "mobile",
    /** <- string
      * The document layout mode: if `"mobile"`, the document will be suitable
      * for reading on smartphones; if `"screen"`, it will be suitable to be
      * read in bigger screns; and if `"print"`, it will be suitable to be
      * read printed on paper. **/
  pages: false,
    /** <- boolean
      * Set multiple pages on in _mobile_ and _screen_ modes --- by default,
      these modes use a singular page with automatic height. **/
  glossary-title: "Glossary",
    /** <- string | content
      * Set the title for the automatically created glossary, if any. **/
  unnumbered-heading-markup: true,
    /** <- boolean
      * Turn on/off special `|=` markup for unnumbered headings. **/
  date: datetime.today(),
    /** <- array | datetime
      * The text writing or publication date, in an array `(yyyy, mm, dd)`, or a
      * proper `#datetime`. **/
  paper: "a4",
    /** <- string
      * Defines the page paper type --- and its size, therefore. **/
  lang: "en",
    /** <- string
      * Defines the text language. **/
  justify: true,
    /** <- boolean
      * Defines if the text will have justified aligment. **/
  line-space: 0.5em,
    /** <- length
      * Defines the space between text lines in paragraphs. **/
  par-margin: 0.5em,
    /** <- length
      * Defines the margin space after each paragraph. Set it the same as
      * `line-space` to get no additional space between paragraphs. **/
  first-line-indent: 1em,
    /** <- length
      * Defines the first line indentation of all paragraphs in a sequence, except
      * the first one. **/
  margin: (
    top: 3cm,
    bottom: 2cm,
    left: 2.5cm,
    right: 2.5cm
  ),
    /** margin: (top: 3cm, bottom: 2cm, x: 2.5cm) <- length
      * Defines the document margins. **/
  font: ("Book Antiqua", "Inconsolata"),
    /** <- array | string
      * Defines the font families for the text: a main font and its falbacks. **/
  font-size: 12pt,
    /** <- length
      * Defines the size of the text in tue document. **/
  body
    /** <- content
      * The entire document content (automatically set in `#show` rules). **/
) = {
  // Joins title (if any) and subtitle (if any) with a ": " in the middle:
  let full-title = if subtitle != none and title != none {
    title + ": " + subtitle
  }
  else if title != none {
    title
  }
  
  if authors != none {
    // Forces authors to always be an array of arrays:
    if type(authors) == str {
      authors = (authors, )
    }
  }
  
  // Transform (yyyy, mm, dd) array into datetime
  if type(date) == array {
    date = datetime(
      year: date.at(0),
      month: date.at(1),
      day: date.at(2)
    )
  }

  set document(
    title: full-title,
    author: if authors != none {
          authors.join(", ").replace(regex(" *<.*>"), "")
      } else { "Unknown" },
    date: date 
  )
  set par(
    justify: justify,
    leading: line-space,
    spacing: par-margin,
    first-line-indent: first-line-indent
  )
  set terms(separator: [: ], tight: true)
  set heading(numbering: "1.1.1.1.1 ")
  
  // Mode-aware configurations
  let text-args = (:)
  let page-args = (:)
  let table-stroke = black
  
  // Change layout based on `mode` argument:
  if mode == "mobile" {
    page-args = (
      height: auto,
      width: 10cm,
      margin: (x: 1em, y: 4em),
      fill: luma(50)
    )
    text-args = (
      fill: luma(250),
      size: font-size
    )
    table-stroke = white
  }
  else if mode == "screen" {
    page-args = (
      height: auto,
      width: 595.28pt,
      margin: margin,
      fill: luma(50)
    )
    text-args = (
      fill: luma(250),
      size: font-size
    )
    table-stroke = white
  }
  else if mode == "print" {
    page-args = (
      paper: paper,
      margin: margin,
      footer: context if locate(here()).page() > 1 {
        align(center)[
          #locate(here()).page()/#numbering("1", ..counter(page).final())
        ]
      }
    )
  }
  else {
    panic("Invalid mode: " + mode)
  }
  
  // Turn pages on in _mobile_ and _screen_ modes
  if page-args.at("height", default: none) != none and pages == true {
    page-args.insert("height", 20cm)
  }
  
  set page(..page-args)
  set text(
    font: font,
    size: font-size,
    lang: lang,
    ..text-args
  )
  set footnote.entry(separator: line(length: 5cm, stroke: table-stroke))
  
  show figure.caption: set text(size: 1em - 2pt)
  show figure: set figure.caption(position: top)
  show footnote.entry: set text(size: font-size - 2pt)
  show heading: set block(above: font-size * 1.5, below: font-size * 1.5)
  show heading.where(numbering: none): set align(center)
  show heading.where(level: 1): set text(size: font-size + 2pt)
  
  show selector.or(
    heading.where(level: 2),
    heading.where(level: 3),
    heading.where(level: 4),
    heading.where(level: 5),
  ): set text(size: font-size + 1pt)
  
  show regex("^\|=+.*$"): it => {
    // Enable |= unnumbered heading markup:
    if unnumbered-heading-markup == true {
      syntax.unnum-headings(it)
    }
    else {
      it
    }
  }
  
  // Simple ABNT table
  set table(
    stroke: (_, y) => (
       top: if y <= 1 { 1pt + table-stroke } else { 0pt },
       bottom: 1pt + table-stroke,
      ),
    align: (_, y) => (
      if y == 0 { center }
      else { left }
    )
  )
  
  show selector.or(
    terms, enum, list, figure,
    math.equation.where(block: true), raw.where(block:true)
  ): it => {
    v(font-size, weak: true)
    it
    v(font-size, weak: true)
  }

  show math.equation.where(block: true): set math.equation(numbering: "(1)")
  show quote.where(block: true): it => pad(x: 1em, it)
  show raw.where(block: true): it => pad(left: 1em)[#it]

  // Main title:
  if title != none {
    heading(
      level: 1,
      outlined: false,
      numbering: none,
      align(center)[#full-title]
    )
  }
  
  // Authors
  if authors != none {
    set align(right)
    set footnote(numbering: "*")
    
    v(1.5em)
    for author in authors {
      let name = author.find(regex("^[^<]*"))
      let url = author.find(regex("<(.*)>"))
      
      if author != none {
        name.trim()
        
        if url != none {
          url = url.trim(regex("[<>]"))
          footnote(link(url))
        }
        linebreak()
      }
    }
    v(4.5em)
    
    set footnote(numbering: "1")
    counter(footnote).update(0)
  }
  
  // Set ABNT-compliant bibliography
  set bibliography(style: "associacao-brasileira-de-normas-tecnicas")

  // Textual content
  body
  
  // Glossary
  context if glossary.writing-glossary-state.final() != (:) {
    pagebreak(weak: true)
    
    glossary.insert-glossary(title: glossary-title)
  }
}


/**
 * = Detachable Parts
 * 
 * ```typm
 * #import "@preview/min-writing:0.1.1": doc, glossary, syntax
 * #import doc: *
 * #import glossary: *
 * #import syntax: *
 * ```
 * 
 * To conveniently allow the use of separate features of _min-writing_, each set
 * of commands are grouped in sub-modules by area: `doc`umentation commands,
 * `glossary` commands, and `syntax` commands.
**/


