#import "@preview/min-manual:0.1.0": manual

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
    read("src/glossary.typ")
)

// This file gathers doc-comments in src/lib.typ source code