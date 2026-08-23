#import "/src/lib.typ": writing

#set document(
  title: "Paged test",
  date: datetime(year: 2026, month: 8, day: 23)
)

#show: writing.with(paged: false, custom-styling: false)

#lorem(50)

#pagebreak() // turns into #divider in quick-note (not paged) mode

#lorem(50)