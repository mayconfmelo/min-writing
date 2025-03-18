
/**
 * = Horizontal Rule Command
 * 
 * :syntax.horizontalrule:
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
 * :syntax.blockquote:
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


// Make it work in s
/**
 * = Unnumbered Headings Command
 * 
 * :syntax.unnum-headings: show
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
**/
#let unnum-headings(
  show-line: true,
    /** <- bollean
      * Show or hide a non-continuous line below headings that indicates its level. **/
  body
    /** <- content
      * The content that has unnumbered headings inside; automatically set in
      * `#show` rules. **/
) = {
  show regex("^\|=+.*$"): it => {
    let level = it.text.find(regex("=+"))
    let title = it.text.replace(regex("^\|=+\s*"), "")
    let line-color = if page.height == auto {white} else {black}
    
    show heading: set block(below: 0.5em)
    
    heading(
      level : level.len(),
      numbering: none,
      title
    )
    
    if show-line == true {
      box(
        width: 1fr,
        inset: (x: 5pt),
        line(
          length: 100%,
          stroke: 1pt + line-color
        )
      ) * level.len()
    }
    
    v(1.5em, weak: true)
  }
  
  body
}


// Original `pagebreak` command
#let pagebreak-origin = pagebreak

/** 
 * = Pagebreak Command
 *
 * This is a wrapper that shadows the default `#pagebreak()` command to nullify
 * it in `mobile` and `screen` modes and create a single-paged document: when
 * one of these modes are set, `#pagebreak` does nothing; but when the `print`
 * mode is set, `#pagebreak` works as default.
 * 
 * ```typm
 * #import "@preview/min-writing:0.1.0": writing, pagebreak
 * ```
 * 
 * To use it, just import the `pagebreak` command alongside `writing` from as
 * shown above.
**/
#let pagebreak(..args) = context {
  if page.height == auto {
    []
  }
  else {
    pagebreak-origin(..args)
  }
}


// TODO: decide whether markdown-ish will be used
#let markdown-ish(body) = {
  assert.ne(body, none, message: "#markdown-ish needs a content body")
  
  // Checklist
  show list.item: it => {
    //[#it.body.fields()]
    if it.body.has("children") {
      let open = it.body.children.at(0).at("text", default: none)
      let close = it.body.children.at(2).at("text", default: none)
      
      if open + close == "[]" {
        let mark = it.body.children.at(1).at("text", default: none)
        let cont = it.body.children.slice(3).join(" ")
        
        if mark == none {
          sym.ballot
        }
        else if mark.contains(regex("[xX]")) {
          sym.ballot.cross
        }
        cont
        linebreak()
      }
      else {
        it
      }
    }
    else {
      it
    }
  }
  
  // horizontal Rule
  show regex("^[-–—]+$"): it => align(center, line(length: 80%))
  
  // URL link
  show regex("\!\[.*\]\(.*\)"): it => "+++"
  
  body
  
  repr(body)
}
