# Minimal Writings

<center>
Simple and basic general purpose writings.
</center>


## Quick Start

```typst
#import "@preview/min-writing:0.1.0": writing, pagebreak
#show: writing.with(  
  title: "Main Title",
  subtitle: "Complementary subtitle, generally two lines long or less",
  authors: (
    "Text Author <mailto:author@email.com>",
    "Collaborator <https://collab.site.com>"
  ),
  mode: "mobile",
)
```


## Description

Generate everyday texts, writings, and anotations that can be confortably read
in smartphone screens, bigger screens, or printed paper.  This package also
provides some useful tools and helpers that simplify the writing process, to
make it easier and faster. The features can work in a all-parts-detachable way:
you can import each feature separately and use only whatever is useful at the
moment instead of everything that the package offers.


## More Information

- [Official manual](https://raw.githubusercontent.com/mayconfmelo/min-writing/refs/tags/0.1.0/docs/manual.pdf)
- [Example PDF result](https://raw.githubusercontent.com/mayconfmelo/min-writing/refs/tags/0.1.0/docs/example.pdf)
- [Example Typst code](https://github.com/mayconfmelo/min-writing/blob/0.1.0/template/main.typ)
- [Example of standalone features usage](https://github.com/mayconfmelo/min-writing/blob/0.1.0/template/parts/)
- [Changelog](https://github.com/mayconfmelo/min-writing/blob/main/CHANGELOG.md)