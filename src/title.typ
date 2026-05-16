#let title_page(
  ..args,
) = [
  #set page(numbering: none)

  #{
    set par(leading: 0.5em)
    set text(size: 11pt)
    grid(
      columns: (1fr, auto),
      column-gutter: 0.5em,
      image("bmstu.svg"),
      align(center, strong[
        Министерство науки и высшего образования Российской Федерации \
        Федеральное государственное автономное образовательное учреждение высшего \
        образования "Москвский государственный технический университет \
        имени Н.Э. Баумана (национальный исследовательский университет)" \
        (МГТУ им Н.Э. Баумана)
      ]),
    )
  }

  #{
    set par(spacing: 0.25em)
    line(start: (0%, 0%), end: (100%, 0%), stroke: 2pt)
    line(start: (0%, 0%), end: (100%, 0%), stroke: 0.5pt)
  }

  #{
    grid(
      columns: (auto, 1fr),
      // stroke: black,
      column-gutter: 2em,
      row-gutter: 1em,
      [ФАКУЛЬТЕТ], underline(offset: 3.5pt, args.at("faculty", default: ["Робототехника и комплексная автоматизация"])),
      [КАФЕДРА],
      underline(offset: 3.5pt, args.at("department", default: ["Системы автоматизированного проектирования (РК-6)"])),
    )
  }

  #v(1fr)

  #{
    set text(size: 22pt)
    set par(leading: 1em)
    set align(center)
    [
      #text(size: 22pt)[РАСЧЁТНО-ПОЯСНИТЕЛЬНАЯ ЗАПИСКА] \
      #text(size: 20pt)[к выпускной квалификационной работе] \
      #text(size: 20pt)[на тему] \
      #text(size: 18pt)["#{args.at("theme", default: [\@Тема работы@])}"]
    ]
  }

  #v(1fr)

  #{
    set grid.hline(stroke: 0.5pt)
    set text(size: 12pt)
    show grid.cell.where(x: 4): set align(center)
    
    show grid.cell.where(align: center): set text(size: 9pt)
    grid(
      columns: (auto, auto, 1fr, 25%, auto),
      inset: (y: 0.25em),
      column-gutter: 0.5em,
      // stroke: black,
      [Студент],
      args.at("group", default: [\@РК6-8XБ\@]),
      none,
      none,
      args.at("author", default: [\@Фамилия И.О.\@]),
      grid.hline(start: 1, end: 2),
      grid.hline(start: 3, end: 4),
      grid.hline(start: 4, end: 5),

      none,
      grid.cell(align: center)[группа],
      none,
      grid.cell(align: center)[подпись, дата],
      grid.cell(align: center)[ФИО],

      grid.cell(colspan: 2)[Руководитель ВКР],
      none,
      none,
      args.at("supervisor", default: [\@Фамилия И.О.\@]),
      grid.hline(start: 3, end: 4),
      grid.hline(start: 4, end: 5),

      none,
      none,
      none,
      grid.cell(align: center)[подпись, дата],
      grid.cell(align: center)[ФИО],

      ..{
        if "consultant" in args.named() and args.at("consultant") != none {
          (
            grid.cell(colspan: 2)[Консультант],
            none,
            none,
            args.at("consultant"),
            grid.hline(start: 3, end: 4),
            grid.hline(start: 4, end: 5),
            none,
            none,
            none,
            grid.cell(align: center)[подпись, дата],
            grid.cell(align: center)[ФИО],
          )
        }
      },

      grid.cell(colspan: 2)[Нормоконтролёр],
      none,
      none,
      args.at("normocontroller", default: [\@Фамилия И.О.\@]),
      grid.hline(start: 3, end: 4),
      grid.hline(start: 4, end: 5),

      none,
      none,
      none,
      grid.cell(align: center)[подпись, дата],
      grid.cell(align: center)[ФИО],
    )
  }

  #v(1fr)

  #{
    set align(center)
    [#args.at("city", default: "@Город@"), #args.at("year", default: datetime.today().year())]
  }
]
