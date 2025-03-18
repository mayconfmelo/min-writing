#import "@preview/min-writing:0.1.0": syntax

#set heading(numbering: "1.1.1.1.1 ")

#rect[
  This document import only the syntax-related features of _min-manual_. This
  is useful when just these commands are needed, and not the whole package.
]


= Horizontal Rule Command

#import syntax: horizontalrule, hr

#lorem(50)

#horizontalrule()

#lorem(50)

#hr()

#lorem(50)


= Blockquote Command

#import syntax: blockquote

#blockquote(by: "Einstein")[
  Don't believe everything you read on the internet.
]


= Unnumbered Headings

#import syntax: unnum-headings

Now tue special syntax for creating `#heading(numered: false)` headings is enabled:

#show: unnum-headings

|= Unnumbered Heading Level 1

|== Unnumbered Heading Level 2

|=== Unnumbered Heading Level 3

|==== Unnumbered Heading Level 4

|===== Unnumbered Heading Level 5


= Smart Page Breaks

#import syntax: pagebreak

Basically, make the `#pagebreak` command stop workin when `#page(heigth: auto)`.
Example in the next page:

#page(height: auto)[
  This page height is `auto`, and between these two lines \
  #pagebreak()
  There is a pagebreak, believe it or not.
]


= Markdown-ish Syntax
#sym.ballot.cross

#import syntax: markdown-ish
#show: markdown-ish.with()


> Citation
>> Nested citation

https://example.com
[Link](https://example.com)

![Image](https://images.unsplash.com/photo-1518639192441-8fce0a366e2e?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D)

- [x] Tarefa concluída
- [ ] Tarefa pendente
- Foo

-----

> Note: Isso é uma nota.

> Warning: Isso é um aviso.

> Tip: Isso é uma dica.

{center}[Content]

