// NAME: Minimal Writings
// REQ: min-manual:0.1.0 (documentation)
// TODO: Make markup more similar to markdown.
// TODO: Separate each standalone feature in its own submodule.

/**
 * = Quick Start
 * 
 * ```typ
 * #import "@preview/min-writing:0.1.0": writing, pagebreak
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
 * moment instead of everything that tue package offers.
 * 
 * This manual will be updated only when new versions break or modify something;
 * otherwise, it will be valid to all newer versions starting by the one documented
 * here.
 * 
 * #pagebreak()
**/

#let writing-glossary-state = state("glossary-state", (:))

// Original `pagebreak` command
#let pagebreak-origin = pagebreak

// Shadows `pagebreak` to nullify it in "mobile" and "screen" modes
#let pagebreak(..args) = context {
  if page.height == auto {
    []
  }
  else {
    pagebreak-origin(..args)
  }
}

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
      let level = it.text.find(regex("=+"))
      let title = it.text.replace(regex("^\|=+\s*"), "")
      
      heading(
        level : level.len(),
        numbering: none,
      )[#title]
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
  context if writing-glossary-state.final() != (:) {
    pagebreak(weak: true)
    
    // Glossary title
    heading(
      level: 1,
      numbering: none,
      glossary-title
    )
    
    let final-glossary-state = writing-glossary-state.final()
    
    for entry in final-glossary-state.keys().sorted() {
      let value = final-glossary-state.at(entry)
      
      // abbreviations with long name and definition too:
      if type(value) == array {
        if value.at(1) == none {
          entry = upper(entry)
          value = value.at(0)
        }
        else {
          entry = value.at(0) + " (" + upper(entry) + ")"
          value = value.at(1)
        }
      }
      else {
        // Try to capitalize first letter
        entry = upper(entry.first()) + entry.slice(1)
      }
      
      set terms(separator: [:#linebreak()], tight: true)
      
      block(breakable: false)[
        #terms.item(entry, value)
      ]
    }
  }
}


/** 
 * = Pagebreak Command
 *
 * :pagebreak:
 *
 * This is a wrapper that shadows the default `#pagebreak()`, to nullify it in
 * `mobile` and `screen` modes --- otherwise the document will be printed only until
 * the first `#pagebreak()`.
**/


/**
 * = Abbreviations command
 *
 * :abbrev:
 *
 * This command manages abbreviations this way: The first time it is used, will
 * print the full long name, and its abbreviation between parenthesis; from then
 * on, when is used again with the same abbreviation, it will print just the
 * abbreviation. Additionally, every new abbreviation is collected to be used in
 * a glossary automatically generated, along with a optional longer definition
 * of the abbreviation and its long name.
**/
#let abbrev(
  abbreviation,
    /** <- string | content <required>
      * The abbreviation itself. Does not support stylization or quotes. Lowercase
      * letters are automatically uppercased. **/
  ..definitions
    /** <- arguments
      * Receives two positional arguments: a `LONG` full name of the abbreviation,
      * and an optional short `DEFINITION` to be used in the glossary.
      * #parbreak()
      * When no `DEFINITION` is set, `LONG` is used as the `DEFINITION`. **/
) = context {
  let current-glossary-state = writing-glossary-state.get()
  let abbrev
  
  // Get abbrev from content or string
  if type(abbreviation) == content {
    if abbreviation.at("children", default: none) == none {
      abbrev = abbreviation.text
    }
    else {
      panic("Abbreviation is not plain text: " repr(abbreviation))
    }
  }
  else {
    abbrev = abbreviation
  }
  
  // Checks if this abbrev was already used before
  if current-glossary-state.at(abbrev, default: none) != none {
    [#upper(abbrev)]
  }
  else {
    /**
     * The `..definitions` is an argument sink that makes it possible to get
     * optional positional arguments. This way you can use `#abbrev` either way:
     * 
     * ```typm
     * #abbrev[idk][I do not know]
     * ```
     * or else
     * ```typm
     * #abbrev[idk][I do not know][
     *   Response to a question whose answer is unknown to you.
     * ]
     * ```
    **/
  
  
    let long = definitions.pos().at(0, default: none)
    
    if long == none {
      panic("No long name provided by " + abbrev)
    }
    
    let definition
    
    if definitions.pos().len() >= 2 {
      definition = definitions.pos().at(1)
      
      current-glossary-state.insert(abbrev, (long, definition))
    }
    else {
      current-glossary-state.insert(abbrev, (long, none))
    }
    
    writing-glossary-state.update(current-glossary-state)
    
    [#long (#upper(abbrev))]
  }
}


/**
 * = Glossary Term Command
 *
 * :gloss:
 * 
 * This commands works alongside `#abbrev` collecting terms for a automatically
 * generated glossary. While `abbrev` only collects abbreviations, `gloss` can
 * collect any word or expression. It just retrieves the data and then prints the
 * term in the place where the command is writen; later, the `article` command use
 * this data to generate a automatic glossary after the main text body, as the.
 * If no data is collected by neither `gloss` nor `abbrev`, no glossary is
 * generated.
**/
#let gloss(
  term-name,
    /** <- string | content <required>
      * The name of the term in the glossary; it is what will be defined. If the
      * name have any fancy characters like apostrophes or quotes, is recommended
      * to use a string instead of content. **/
  definition
    /** <- string | content <required>
      * The definution of `term-name`; a brief text that describes and explains it. **/
) = context {
  let current-glossary-state = writing-glossary-state.get()
  let term
  
  if type(term-name) == content {
    term = term-name.text
  }
  else {
    term = term-name
  }
  
  if current-glossary-state.at(term, default: none) == none {
    current-glossary-state.insert(term, definition)
  }
  writing-glossary-state.update(current-glossary-state)
  
  [#term]
}


// Enables glossary generation (show)
// TODO: Test if #glossary works
// TODOC: write doc-comments if #glossary it works
#let glossary(
  title: "Glossary",
  body
) = {
  body

  pagebreak(weak: true)
    
  // Glossary title
  heading(
    level: 1,
    numbering: none,
    title
  )
  
  let final-glossary-state = writing-glossary-state.final()
  
  for entry in final-glossary-state.keys().sorted() {
    let value = final-glossary-state.at(entry)
    
    // abbreviations with long name and definition too:
    if type(value) == array {
      if value.at(1) == none {
        entry = upper(entry)
        value = value.at(0)
      }
      else {
        entry = value.at(0) + " (" + upper(entry) + ")"
        value = value.at(1)
      }
    }
    else {
      // Try to capitalize first letter
      entry = upper(entry.first()) + entry.slice(1)
    }
    
    set terms(separator: [:#linebreak()], tight: true)
    
    block(breakable: false)[
      #terms.item(entry, value)
    ]
  }
}


/** #pagebreak()
 * 
 * = Horizontal Rule Command
 * 
 * :horizontalrule:
 * 
 * Adds horizontal rules, used to separate suble changes of subject in book texts.
 * Can be called by its name or its alias `#hr`.
 * 
**/
#let horizontalrule(
  symbol: [#sym.ast.op #sym.ast.op #sym.ast.op],
    /** <- content
      * Defines the content at the center of the horizontal rule. By default,
      * the line is struck by three #sym.ast.op in its center. **/
  spacing: 1em,
    /** <- length
      * Defines the vertical space before and after the horizontal rule. **/
  line-size: 15%,
    /** <- length
      * Defines the size of the horizontal rule line. **/
) = context [
  #let line-fill = if page.height == auto {
    white
  } else {
    black
  }

  #v(spacing, weak: true)
  #align(center)[
  #block(width: 100%)[
    #box(height: 1em,
      align(center+horizon)[#line(length: line-size, stroke: line-fill)]
    )
    #box(height: 1em)[#symbol]
    #box(height: 1em,
      align(center+horizon)[#line(length: line-size, stroke: line-fill)]
    )
  ]
  ]
  #v(spacing, weak: true)
]

// Alias for creating a visial text separator
#let hr = horizontalrule


/**
 * = Blockquote Command
 * 
 * :blockquote:
 * 
 * Adds a block version of the `quote` command. In fact, it is just a simple
 * wrapper of ```typc quote(block: true)``` with some minor modifications. The
 * `by` argument is an alias for the original `attribution` argument, so that a
 * blockquote can be written:
 * 
 * ```typm
 * #blockquote(by: "Einstein")[
 *   Don't believe everithing you read on the internet.
 * ]
 * ```
**/
#let blockquote(by: none, ..args) = quote(block: true, attribution: by, ..args)


/**
 * = Argument Command
 * 
 * :arg:
 * 
 * This command offers a convenient way to document the arguments --- or parameters,
 * or options, or whatever they are called; and even structures can be easily
 * explained.
**/
#let arg(
  title,
    /** <- string
      *  Defines the argument `NAME`, `TYPE`s, and if it is `REQUIRED` using the 
      * following syntaxes:
      * #parbreak()
      * #align(center)[
      *   `"NAME <- TYPE | TYPE | TYPE <REQUIRED>"`
      *   #line(length: 60%, stroke: luma(220))
      *   `"NAME -> TYPE | TYPE | TYPE"`
      * ]
      * The name can be #raw("```LANG NAME```") to get syntax highlight. The
      * `<-` arrow indicates that `NAME` receives any of the value `TYPE`s, and
      * `->` indicates that `NAME` returns one of the value `TYPE`s. A special
      * `nothing` type is used when nothing is received and/or returned. For
      * optional arguments, just don't write the `<REQUIRED>`. **/
  body
    /** <- content | string
      * A brief description of what the argument does. **/
) = {
  let name
  let output = false
  let types = none
  let required = title.contains("<required>")
  
  // Adapt types fill color to page color
  let type-fill = if page.height == auto {
    luma(20)
  } else {
    luma(235)
  }
  
  // Remove any <required> in title:
  if required != none {
    title = title.replace("<required>", "")
  }
  
  let arrow = title.match(regex("<-|->")).text
  
  if arrow == "->" {
    output = true
  }
  
  // split NAME <- TYPES or NAME -> TYPES
  let parts = title.split(arrow)
  
  name = parts.at(0).trim()
  
  if name == "" {
    panic("Argument name required: " + title)
  }
  
  // Set types, if any
  if parts.len() > 1 {
    types = parts.at(1)
      .replace(regex("\s*\|\s*"), "|")
      .trim()
      
    // If TYPES is "nothing", maintain types = none
    if types == "nothing" {
      types = none
    }
    else {
      types = types.split("|")
    }
  }
  
  // Eval ```LANG name``` to become raw
   if name.contains(regex("```.*```")) {
     name = eval(name, mode: "markup")
  }

  v(0.5em)
  block(breakable: false)[
    #par(
      spacing: 0.9em,
      leading: 0.65em,
    )[
      #strong[
        // If the name is string, show as raw.
        // If the name is raw, show it as it is.
        #if type(name) == str {
          raw(name)
        } else {
          name
          h(1em)
        }
      ]
      #if types != none {
        // Show arrow when documenting output
        if output == true {
          sym.arrow.r
          h(0.5em)
        }
      
        // Turn string types into array:
        if type(types) == str {
          types = (types,)
        }
        for type in types {
          box(
            fill: type-fill,
            inset: (x: 3pt, y: 0pt),
            outset: (y: 3pt),
            type.trim()
          ) + " "
        }
        
      }
      // Insert required note
      #if required == true {
        box(width: 1fr)[
          #align(right)[ (_required_) ]
        ]
      }
      #linebreak()
      #if body != [] {
        // Show padded text:
        pad(left: 1em)[#body]
      }
    ]
  ]
}

/**
 * = Unnumbered Headings Command
 * 
 * :unnum-headings: show
 * 
 * Activates only the unnumbered headings syntax, without the need to use
 * `#writing` and all its other features included. By importing and using this
 * command, you can write unnumbered headinds using a special syntax:
 * 
 * ```typm
 * #show: unnum-headings
 * 
 * |= This is a unnumbered level 1 heading
 * |== This is a unnumbered level 2 heading
 * ```
 * 
**/
#let unnum-headings(body) = {
  show regex("^\|=+.*$"): it => {
    // Enable |= unnumbered heading markup:
    if unnumbered-heading-markup == true {
      let level = it.text.find(regex("=+"))
      let title = it.text.replace(regex("^\|=+\s*"), "")
      
      heading(
        level : level.len(),
        numbering: none,
      )[#title]
    }
    else {
      it
    }
  }
  
  body
}


/**
 * = Copyright
 * 
 * Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
 * This manual is licensed under MIT. \
 * The manual source code is free software:
 * you are free to change and redistribute it.  There is NO WARRANTY, to the
 * extent permitted by law.
**/
