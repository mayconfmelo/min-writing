#import "/src/lib.typ": writing

#set page(width: 15cm, height: auto, margin: 1em)
#set document(
  title: "Extended syntax disabling test",
  date: datetime(year: 2026, month: 8, day: 23)
)

#show: writing.with(syntax: false, custom-styling: false)


[TOC]

|= Unnumbered level 1

|== Unnumbered level 2

|=== Unnumbered level 3

|==== Unnumbered level 4

|===== Unnumbered level 5

|====== Unnumbered level 6

=Marked=
::Boxed::
:::Underline:::
~~Strikethrough~~
[^This is a footnote]

This is an """inline quotation""".

> This is a block quotation.
> --- Attribution

| *Centered* | *Left*    | *Right* | *None* |
| :--------: | :-------- | ------: | ------ |
| AAAA       | AAAA      | AAAA    | AAAA   |
| AAA        | AAA       | AAA     | AAA    |

This is a paragraph. \\\\ This is another paragraph. \\\\\\ This is in another page (when paged)

```mermaid
graph TD
    A[Start] --> B[Finish]
```

-----

- [ ] Item
- [X] Item
- [/] Item
- [-] Item
- [!] Item