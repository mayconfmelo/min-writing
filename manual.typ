// NAME: Minimal Writings Manual
// REQ: min-manual

#import "@preview/min-manual:0.1.1": manual

#show: manual.with(
  title: "Minimal Writings",
  description: "Simple and basic general purpose writings",
  authors: "Maycon F. Melo <https://github.com/mayconfmelo>",
  cmd: "min-writing",
  version: "0.1.0",
  license: "MIT",
  logo: image("docs/assets/manual-logo.png"),
  from-comments:
    read("src/lib.typ") +
    read("src/doc.typ") +
    read("src/glossary.typ") +
    read("src/syntax.typ")
)

// This file gathers doc-comments in the source code, located in src/

= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software:
you are free to change and redistribute it.  There is NO WARRANTY, to the
extent permitted by law.