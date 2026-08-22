#let unnumbered-headings(enable: true, body) = {
  if not enable {return body}
  
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
  if not enable {return body}
  
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


#let breaks(enable: true, paged: false, body) = {
  if not enable {return body}
  
  /*if not paged {
    show regex("\\\\+"): it => if it.text.len() == 3 {divider()} else {it}
    
    body
    
    return
  }*/
  
  show regex("\\\\+"): it => {
    if it.text.len() == 2 {parbreak()}
    else if it.text.len() == 3 {
      if paged {pagebreak()} else {divider()}
    }
    else {it}
  }
  
  body
}


#let inline(enable: true, accent-color: black, body) = context {
  if not enable {return body}
  
  let nbsp = sym.space.nobreak
  
  // Dark magick: bring elements back from string representation
  show regex("\\|\\|[^\\|\s]+\\|\\|.*?\\|\\|[^\\|\s]+\\|\\|"): it => {
    import "@preview/nexus-tools:0.3.0": content2str
    
    let body = content2str(it)
    let func = body.match(regex("\\|\\|(.*?)\\|\\|")).captures.at(0)
    let body = body.match(regex(func + "\\|\\|(.*?)\\|\\|" + func)).captures.at(0)
    let functions = (
      emph: text.with(style: "italic"),
      strong: text.with(weight: "bold"),
      raw: raw
    )
    
    func = functions.at(func)
    
    func(body + sym.zws)
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
  show regex("::.+?::"): it => {
    import "cmd.typ": boxed
    
    show ":": ""
    
    boxed(it, stroke: 1pt + accent-color)
  }
  
  // Underline
  show regex(":::.+?:::"): it => {
    show ":::": ""
    
    underline(it)
  }
  
  // Footnote
  show regex("\\[\\^.+?\\]"): it => {
    footnote({
      show regex("[\\[\\]\\^]"): ""
      
      it
    })
  }
  
  // Dark magick: Transform elements into string representation
  show selector.or(strong, emph, raw.where(block: false)): it => {
    import "@preview/nexus-tools:0.3.0": content2str
    
    let func = "||" + repr(it.func()) + "||"
    let body = content2str(it)
    
    if body.ends-with(sym.zws) {return it}
    
    func
    body
    func
  }
  
  body
}


#let check-lists(enable: true, body, stroke: black, fill: white) = {
  if not enable {return body}
  
  import "@preview/cheq:0.4.0": checklist
  
  checklist(body, fill: fill, stroke: stroke)
}


#let dividers(enable: true, body) = {
  if not enable {return body}
  
  show regex("^(?:[—–-][—–-]){1,}-?\s*$"): divider()
  
  body
}


#let toc(enable: true, body) = {
  if not enable {return body}
  
  show regex("^(?i)\S*\\[toc\\]\s*$"): outline()
  
  body
}


#let tables(enable: true, body) = {
  if not enable {return body}
  
  show par: it => {
    import "@preview/nexus-tools:0.3.0": content2str
    
    let string = content2str(it.body)
    
    if string != none and string.contains(regex("^\s*\\|.*\\|\s*$")) {
      import "@preview/tablem:0.3.0": tablem
      
      let body = it.body.children.map(elem => if elem == [—] [---] else if elem == [–] [--] else {elem})
      
      tablem(body.join())
    }
    else {it}
  }
  
  body
}


#let mermaid(enable: true, body) = {
  if not enable {return body}
  
  import "@preview/oxdraw:0.1.0": oxdraw
  
  show raw.where(lang: "mermaid"): oxdraw
  
  body
}