#let original = (figure: figure, align: align)

#let figure(source: none, align: center, ..args, body) = context {
  set original.figure.caption(position: top)
  
  show block: set original.align(align)
  
  block({
    set original.align(center)
    
    (original.figure)(..args, body)
    
    v(-par.leading)
    text(source, size: 1em - 2pt)
  })
}


#let mark(fill: auto, body) = context {
  import "@preview/catppuccin:1.1.0": get-flavor
  
  let fill = fill
  
  if fill == auto {
    import "@preview/nexus-tools:0.3.0": storage
    
    fill = storage.get("accent-color", gray, namespace: "min-writing")
  }
  
  box(body, fill: fill.transparentize(50%), outset: (y: 2pt), inset: (x: 2pt))
}


#let boxed(stroke: auto, body) = context {
  import "@preview/catppuccin:1.1.0": get-flavor
  
  let stroke = stroke
  
  if stroke == auto {
    import "@preview/nexus-tools:0.3.0": storage
    
    stroke = storage.get("accent-color", gray, namespace: "min-writing")
  }
  
  box(body, stroke: stroke, outset: (y: 2pt), inset: (x: 2pt))
}


#let mermaid(..args) = {
  import "@preview/oxdraw:0.1.0": oxdraw
  
  oxdraw(..args)
}