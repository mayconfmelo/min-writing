# 0.1.0

- Document modes
  - `"mobile"` mode turns page dark, bigger text and small single text-wide page
  - `"screen"` mode turns page dark, and set a single text-wide page
  - `"print"` mode renders the standard document style, fit to be printed on paper
- Automatic glossary generation
  - Abbreviation management with `#abbrev`
  - Glosary term management with `#gloss`
- Horizontal rules (visual text separators)
- `#blockquote`, a wrapper for `#quote(block: true)`
- Easy way to document command arguments/options/parameters with `#arg`
- All-parts-detachable philosophy: each feature can also be imported sepparatedly
  and used on its own