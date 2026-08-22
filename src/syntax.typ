#let unnumbered-headings(enable: true, body) = {
  if not enable {return}
  
  show regex("(?s)^\|=+.*$"): it => {
    set circle(
      fill: text.fill,
      radius: 1pt,
    )
    set box(
      inset: (x: 5pt),
    )
    set align(center)
    
    let level = it.text.find(regex("=+")).len()
    let title = it.text.replace(regex("^\|=+\s*"), "")
    
    assert.ne(level, 0, message: "min-writing failed to parse syntax")
    
    v(1.5em)
    box(circle()) * level
    v(-1.5em)
    
    heading(
      title,
      level : level,
      numbering: none,
    )
  }
  
  body
}


#let quotes(enable: true, body) = {
  if not enable {return}
  
  show regex("\"\"\".*\"\"\""): it => quote(it.text.trim("\"\"\""))
  
  show par: it => {
    import "@preview/nexus-tools:0.3.0": content2str
    
    let string = content2str(it.body)
    let attribution
    
    if string != none and string.starts-with(">") {
      attribution = string.match(regex(".*>\s*—\s(.*)$"))
      attribution = if attribution  != none{attribution.captures.at(0)} else {attribution}
      
      show regex(">\s*(?:—\s*" + attribution + ")?\s*"): ""
      
      quote(it, attribution: attribution, block: true)
    }
    else {it}
  }
  
  body
}


#let pagebreaks(enable: true, paged: false, body) = {
  if not enable {return}
  
  if not paged {
    show regex("\\\\+"): it => if it.text.len() == 2 {""} else {it}
    
    body
    
    return
  }
  
  show regex("\\\\+"): it => if it.text.len() == 2 {pagebreak()} else {it}
  
  body
}


#let inline(enable: true, accent-color: black, body) = context {
  if not enable {return}
  
  let nbsp = sym.space.nobreak
  
  // Restore em, strong
  show regex("\\|\\|[^\s]+\\|\\|.*?\\|\\|[^\s]+\\|\\|"): it => {
    import "@preview/nexus-tools:0.3.0": content2str
    
    let body = content2str(it)
    let func = body.match(regex("\\|\\|(.*?)\\|\\|")).captures.at(0)
    let body = body.match(regex(func + "\\|\\|(.*?)\\|\\|" + func)).captures.at(0)
    let functions = (
      emph: text.with(style: "italic"),
      strong: text.with(weight: "bold"),
    )
    
    func = functions.at(func)
    
    func(body)
  }
  
  // Strikethrough
  show regex(nbsp + nbsp + ".+?" + nbsp + nbsp): it => {
    show nbsp: ""
    
    strike(it)
  }
  
  // Marker
  show regex("=.+?="): it => {
    import "cmd.typ": mark
    
    show "=": ""
    
    mark(it, fill: accent-color)
  }
  
  // Box
  show regex(":.+?:"): it => {
    import "cmd.typ": boxed
    
    show ":": ""
    
    boxed(it, stroke: 1pt + accent-color)
  }
  
  // Underline
  show regex("::.+?::"): it => {
    show "::": ""
    
    underline(it)
  }
  
  // Footnote
  show regex("\\[\\^.+?\\]"): it => {
    footnote({
      show regex("[\\[\\]\\^]"): ""
      
      it
    })
  }
  
  // Make em, strong work wity special syntax
  show selector.or(strong, emph): it => {
    import "@preview/nexus-tools:0.3.0": content2str
    
    let func = "||" + repr(it.func()) + "||"
    
    func
    content2str(it.body)
    func
  }
  
  body
}