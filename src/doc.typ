
/**
 * = Argument Command
 * 
 * :doc.arg:
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
) = context {
  let title = title
  let output = false
  let types = none
  let required = title.contains("<required>")
  let name
  
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
    ]
    #if body != [] {
      // Show padded text:
      pad(left: 1em)[#body]
    }
  ]
}

/**
 * = Package Citation Commands
 * 
 * ```typm
 * #import "@preview/min-manual:0.1.0": doc
 * #import doc: univ, pip, crate, gh, pkg
 * #univ(name)
 * #pip(name)
 * #crate(name)
 * #gh(name, user)
 * #pkg(name, url)
 * ```
 * 
 * These are small helper commands that simplifies the citation of any type of
 * external package, crate, or library using its repository URL. The `#univ` command
 * is used to Typst Universe packages, the `#pip` to Pip/Pypi Python modules, the
 * `#crate` to Rust crates, the `#gh` to GitHub repositories, and `#pkg` to any other
 * repositories in general.
 * 
 * name <- string <required>
 * The name of the package, or library, or crate, or anything else, as it appears
 * in the package repository, e.g.: just the `babel` of
 * `https://ctan.org/pkg/babel`.
 *
 * url <- string <required>
 * Used only by `#pkg`: The package repository URL without package name path,
 * e.g.: just the `https://ctan.org/pkg/` of `https://ctan.org/pkg/babel`.
 *
 * user <- string <required>
 * Used only by `#gh`: The GitHub user, as it appears in GitHub repositories,
 * e.g.: just the `typst` of `https://github.com/typst/packages`.
**/

// Cite a package/library/crate repository by URL.
#let pkg(name, url) = [#link(url + name)[#emph(name)]#footnote(url + name)]

// Shortcut to cite Typst packages from Typst Universe.
#let univ(name) = pkg(name, "https://typst.app/universe/package/")

// Shortcut to cite Python packages from Pypi.
#let pip(name) = pkg(name, "https://pypi.org/project/")

// Shortcut to cite Rust packages from crates.io
#let crate(name) = pkg(name, "https://crates.io/crates/")

// Shortcut to cite GitHub repositories
#let gh(name, user) = pkg(name, "https://github.com/" + user + "/")

