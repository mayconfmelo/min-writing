#let figure() = {
}


#let mark(fill: auto, body) = context {
  import "@preview/catppuccin:1.1.0": get-flavor
  
  let fill = fill
  
  if fill == auto {
    import "@preview/nexus-tools:0.3.0": storage
    
    let catppuccin-flavor = storage.get("catppuccin-flavor", namespace: "min-writing")
    let flavor = get-flavor(catppuccin-flavor)
    
    fill = flavor.colors.mauve.rgb
  }
  
  box(body, fill: fill, outset: (y: 2pt), inset: (x: 2pt))
}

#let boxed(stroke: auto, body) = context {
  import "@preview/catppuccin:1.1.0": get-flavor
  
  let stroke = stroke
  
  if stroke == auto {
    import "@preview/nexus-tools:0.3.0": storage
    
    let catppuccin-flavor = storage.get("catppuccin-flavor", namespace: "min-writing")
    let flavor = get-flavor(catppuccin-flavor)
    
    stroke = flavor.colors.mauve.rgb
  }
  
  box(body, stroke: stroke, outset: (y: 2pt), inset: (x: 2pt))
}



#let strikethrough() = {
  
}