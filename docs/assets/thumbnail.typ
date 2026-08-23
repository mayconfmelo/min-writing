#import "@preview/min-writing:0.1.0": writing, boxed, mermaid, figure

#set document(
  title: "Minimal Writings",
  author: "mayconfmelo",
  date: datetime(year: 2026, month: 8, day: 23),
  description: [
    This is the document description, and above it are its title, date, and author;
    all this data is obtained from `#document` when present, otherwise it is
    omitted—except for the date.
  ],
)

#show: writing.with(paged: true)


=Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam rhoncus faucibus ex vel tincidunt=
Integer sed ornare felis, et scelerisque sapien. Nam a tellus mi. ::Curabitur:: accumsan, nulla at sodales
imperdiet, ~~magnus~~ magna turpis mattis justo,[^Maecenas leo est, commodo ut mollis vel, sagittis ac leo.
Donec commodo leo mi, vitae rhoncus nibh tincidunt at.] commodo tempor metus urna at erat. In et urna tincidunt.

|= Unnumbered Heading

#lorem(30)

- [ ] Item
- [X] Item
- [ ] Item
- [ ] Item
- [!] Item

#lorem(50)

----

#lorem(45)

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam rhoncus faucibus ex vel tincidunt.
> Integer sed ornare felis, et scelerisque sapien. Nam a tellus mi.
> --- Curabitur accumsan

#lorem(60)