#import "@preview/min-writing:0.0.0": writing, mark, boxed

#set document(
  title: "Writing",
  author: "mayconfmelo",
)

#show: writing

#lorem(50)

#lorem(50)

= Level 1

== Level 2

=== Level 3

==== Level 4

===== Level 5

====== Level 6

#lorem(50)

|= Level 1

|== Level 2

|=== Level 3

|==== Level 4

|===== Level 5

|====== Level 6

Lorem """inline quotation""" ipsum dolor sit amet.

> Block *quotation*.
> Foo
> — Attibution

> a b

foo \\\\ bar

#table(
  columns: 2,
  lorem(4), lorem(4),
  lorem(4), lorem(4),
  lorem(4), lorem(4)
)

=Mark=
:Boxed:
::Underline::
~~Strikethrough~~
[^Footnote *a*]

#mark[Mark]
#boxed[Boxed]
#underline[=Underline=]
#strike[Strikethrough]
#footnote[Footnote *b*]
#rect[Rect]

#pagebreak()

#lorem(50)

#divider()