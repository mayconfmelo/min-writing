#import "@preview/min-writing:0.1.0": (
  writing, pagebreak, abbrev, gloss,
  horizontalrule, hr, blockquote, arg
)

#show: writing.with(  
	title: "Main Title",
	subtitle: "Complementary subtitle, generally two lines long or less",
	authors: (
	  "Text Author <mailto:author@email.com>",
	  "Collaborator <https://collab.site.com>"
	),
	mode: "mobile",
)

= Primary section

#lorem(45)

== Secondary section

#lorem(45)

=== Tertiary section

#lorem(45)

==== Quaternary section

#lorem(45)

===== Quinary section

#lorem(45)

#pagebreak()

|= Primary unnumbered section

#lorem(45)

|== Secondary unnumbered section

#lorem(45)

|=== Tertiary unnumbered section

#lorem(45)

|==== Quaternary unnumbered section

#lorem(45)

|===== Quinary unnumbered section

#lorem(45)

#pagebreak()


= Math

#lorem(24)

$ sum_0^10 $

Inline math: $sum_0^10$. #lorem(21)

#lorem(24)


= Tables

#lorem(24)

#figure(
  kind: "table",
  supplement: "Table",
  caption: "Example of table inside a figure",
  table(
    columns: 3,
    table.header(
      [Things], [Stuff], [Results],
    ),
    [Some thing], [Some stuff], [Some result],
    [Another thing], [Another stuff], [Another result]
  )
)

#lorem(24)


= Glossary and abbreviations

Abbreviations with definitions are automatically included in the glossary:
#abbrev("abnt")[Associação Brasileira de Normas Técnicas][Brazilian association
responsible for normatization and standardization.]

Abbreviations without definitions are automatically included as well:
#abbrev[idk][I don't know]

Glosary terms are automatically included too:
#gloss[saudade][Brazilian word with no direct translation; represents a
feeling of longing for a known someone or something, and a strong desire to
have this someone or something back.]

As to abbreviations, if the same abbreviation is used again it will be
automatically retrieved: #abbrev[abnt]

#pagebreak()


= Horizontal Rule Command

#lorem(50)

#horizontalrule()

#lorem(50)

#hr()

#lorem(50)

= Blockquote Command

#blockquote(by: "Einstein")[
  Don't believe everything you read on the internet.
]


= Argument Command

#arg(
  "name:", ("string", "content"),
  required: true
)[
  Explanation of what is this argument, what it does, and how to set it.
]

#arg(
  "author:", ("string", "content"),
  required: true
)[
  Explanation of what is this argument, what it does, and how to set it.
]
