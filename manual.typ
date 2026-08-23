#import "@preview/min-manual:0.3.0": manual

#show: manual.with(
  title: "Minimal Writings",
  logo: image("docs/assets/manual-logo.png"),
  manifest: toml("typst.toml"),
  from-comments:
    read("src/lib.typ") +
    read("src/cmd.typ") +
    read("src/syntax.typ"),
)


= Copyright

Copyright #sym.copyright #datetime.today().year() Maycon F. Melo. \
This manual is licensed under MIT. \
The manual source code is free software:
you are free to change and redistribute it.  There is NO WARRANTY, to the
extent permitted by law.