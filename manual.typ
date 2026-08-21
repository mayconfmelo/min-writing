#import "@preview/min-manual:0.3.0": manual

#show: manual.with(
  title: "Mininal Writings",
  logo: image("docs/assets/manual-logo.png"),
  manifest: toml("typst.toml"),
  from-comments: read("src/lib.typ")
)


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software:
you are free to change and redistribute it.  There is NO WARRANTY, to the
extent permitted by law.