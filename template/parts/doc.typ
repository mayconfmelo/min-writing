// Import documentation-related features
#import "@preview/min-writing:0.1.0": doc

#rect[
  This document import only the documentation-related features of _min-manual_. This
  is useful when just these commands are needed, and not the whole package.
]


= Argument Command

// Import #arg command from doc
#import doc: arg

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


= Package Citation

// Import packagr citation commands from doc
#import doc: univ, pip, crate, pkg

Requires the #univ("example") Typst package. To setup the project you will need
the #pip("fictional") Python module, or the #crate("nonexistent") crate. If this
package does not work, just go back to LaTeX and use
#pkg("alternative", "https://ctan.org/pkg/") instead, or delve into Regex and
one-liners with the #pkg("OG::Solution", "https://metacpan.org/pod/") Perl module.
