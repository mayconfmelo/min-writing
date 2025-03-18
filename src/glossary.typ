#let writing-glossary-state = state("glossary-state", (:))

/**
 * = Abbreviations command
 *
 * :glossary.abbrev:
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
      panic("Abbreviation is not plain text: " + str(repr(abbreviation)))
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
 * :glossary.gloss:
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
/**
 * = Glossary Insert Command
 * 
 * :glossary.insert-glossary:
 * 
 * This command inserts a glossary in-place, with given `title`, if any glossary
 * term is defined using `#abbrev` and/or `#gloss`. By default, `#manual`
 * automatically inserts a Glossary at the end of document if any glossary term
 * is defined; but `#insert-glossary` is useful when no `#manual` is used.
**/
#let insert-glossary(
  title: "Glossary"
) = context {
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
    
    block(breakable: false, below: 1em)[
      #terms.item(entry, value)
    ]
  }
}