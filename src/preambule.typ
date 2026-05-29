#let task_parts = state("task_parts", ())

#let big_heading(content) = {
  set align(center)
  heading(
    depth: 1,
    numbering: none,
    upper[*#content*],
  )
}

#let wrap_with_big_heading(body) = {
  show heading: set align(center)
  show heading: it => { upper(it) }

  body
}

#let chapter_aware_numbering(n, pattern: "1.1") = numbering(
  pattern,
  ..counter(heading.where(depth: 1)).get(),
  n,
)

#let empty_underline(width) = box(width: width, stroke: black + 0.75pt, baseline: 2pt)

#let conf(doc) = {
  set page(
    paper: "a4",
    margin: (left: 3cm, right: 1.5cm, top: 2cm, bottom: 2cm),
    numbering: "1",
    number-align: center + bottom,
  )
  set text(
    font: "Times New Roman",
    size: 14pt,
    lang: "ru",
    kerning: false,
    hyphenate: false,
  )
  show raw: set text(font: "Fira Code")

  set par(
    justify: true,
    linebreaks: "optimized",
    first-line-indent: (amount: 1.25cm, all: true),
    spacing: 1em,
    leading: 0.75em,
  )

  set heading(numbering: "1.1", outlined: true)
  show heading: set text(size: 14pt)
  show heading: set par(justify: false)
  show heading: set block(above: 2em, below: 1.5em, breakable: false)
  show heading.where(depth: 1): it => {
    pagebreak()
    it
  }
  show heading.where(depth: 1): set heading(supplement: "Раздел")
  show heading.where(depth: 2): set heading(supplement: "Подраздел")
  show heading.where(depth: 3): set heading(supplement: "Пункт")
  show heading.where(depth: 4): set heading(supplement: "Подпункт")

  set figure(supplement: "Рисунок", numbering: chapter_aware_numbering)
  show figure: set block(breakable: true, sticky: true)
  set figure.caption(separator: [ -- ])
  show figure.caption: set par(leading: 0.5em)

  show figure.where(kind: table): set figure(supplement: "Таблица", numbering: chapter_aware_numbering)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption.where(kind: table): set block(sticky: true)
  show figure.caption.where(kind: table): it => {
    set align(left)
    // TODO: add "Продолжение таблицы ..." on table break
    it
  }

  show figure.where(kind: raw): set figure(supplement: "Листинг")

  set table.header(repeat: false)
  set table(align: left + top)
  show table.cell.where(y: 0): set text(weight: "bold")

  set list(marker: [--], indent: 1.25cm)
  set enum(indent: 1.25cm, numbering: "1)")
  set math.equation(numbering: chapter_aware_numbering.with(pattern: "(1.1)"))

  show math.equation.where(block: true): set par(spacing: 2em)
  // Автоматическая нумерация используемых формул
  show math.equation.where(block: true): it => if (
    it.numbering != none and (not it.has("label") or query(ref.where(target: it.label)).len() == 0)
  ) [
    #counter(math.equation).update(v => calc.max(0, v - 1))
    #math.equation(it.body, block: true, numbering: none)
  ] else {
    it
  }

  // Именование рисунков и таблиц не учитывает падеж
  show ref.where(form: "normal"): set ref(supplement: it => {
    if it.func() == figure {
      if it.kind == image {
        return "рис. "
      } else if it.kind == table {
        return "табл."
      }
    }
    it.supplement
  })

  doc
}

