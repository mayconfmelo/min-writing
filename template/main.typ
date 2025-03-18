#import "@preview/min-writing:0.0.9": writing, pagebreak, glossary, syntax, doc

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


// Enables documentation-related features:
#import doc: arg, univ, pip, crate, pkg

= Argument Command

```typm
#set feature(
  arg,
  arg
)
```

#arg("```typm set feature()``` -> nothing")[
  Explanation of what is this structure, what it does, and how to set it.
]

#arg("```typm #show: feature.with()``` -> string | content")[
  Explanation of what is this structure, what it does, and how to set it.
]

#arg("```typm #feature()``` -> string | content")[
  Explanation of what is this structure, what it does, and how to set it.
]

#arg("arg: <- string | content <required>")[
  Explanation of what is this argument, what it does, and how to set it.
]

#arg("arg: <- string | content <required>")[
  Explanation of what is this argument, what it does, and how to set it.
]


= Dependencies

Requires the #univ("example") Typst package. To setup the project you will need
the #pip("fictional") Python module, or the #crate("nonexistent") crate. If this
package does not work, just go back to LaTeX and use
#pkg("alternative", "https://ctan.org/pkg/") instead, or delve into Regex and
one-liners with the #pkg("OG::Solution", "https://metacpan.org/pod/") Perl module.


// Enables glossary-related features:
#import glossary: abbrev, gloss, insert-glossary

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

#rect[
  The _min-writing_ automatically generates a glossary at tue end of tje document,
  but this one below is a copy manually inserted here:
  
  #insert-glossary()
]

#pagebreak()


// Enables syntax-related features:
#import syntax: horizontalrule, hr, blockquote

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

