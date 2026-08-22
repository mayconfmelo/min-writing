#let defaults = (
  heading: (numbering: none),
  text: (
    font: "libertinus serif"),
  page: (
    margin: auto,
    width: "595.28pt",
    height: "841.89pt",
  ),
  table: (
    stroke: "1pt + black",
    fill: none,
    cell: (inset: auto),
  ),
  rect: (stroke: none),
  raw: (text: (font: "dejavu sans mono")),
  outline: (indent: auto),
)


#let custom-divider(self, color: white) = {
 if self.func() != divider {self} else {
    set align(center)
    set line(stroke: 1pt + color)
    set circle(fill: color)
    
    v(1em)
    (
      line(length: 20%),
      circle(radius: 1pt),
      circle(radius: 2pt),
      circle(radius: 1pt),
      line(length: 20%),
    ).map(box.with(inset: (x: 2pt))).join()
    v(1em)
  }
}