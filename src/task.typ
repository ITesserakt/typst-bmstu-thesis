#let add_task_part(name, content, planned_date: (none, "02")) = {
  import "preambule.typ": task_parts

  task_parts.update(it => {
    it.push((name: name, description: content, planned_date: planned_date))
    it
  })
}

#let task_page(..args) = [
  #import "preambule.typ": empty_underline, task_parts

  #set par(leading: 0.5em, first-line-indent: 0pt)
  #set text(size: 12pt)

  #{
    set align(center)
    set text(size: 10.99pt)
    show: strong

    [
      Министерство науки и высшего образования Российской Федерации \
      #v(0.5em)
      Федеральное государственное автономное образовательное учреждение высшего образования \
      "Московский государственный технический университет имени Н.Э. Баумана \
      (национальный исследовательский университет)" \
      (МГТУ им. Н.Э. Баумана)
    ]
  }

  #line(start: (0%, 0%), end: (100%, 0%), stroke: 2pt)

  #{
    set grid.hline(stroke: 0.5pt)

    grid(
      columns: (1fr, 1fr, 15%, auto, auto),
      inset: (y: 0.25em),
      column-gutter: 0.5em,
      // stroke: black,
      none, none, grid.cell(colspan: 3, align: center)[УТВЕРЖДАЮ],

      none, none, grid.cell(colspan: 2)[Заведующий кафедрой], grid.cell(align: center, args.at("faculty_index", default: "@Индекс@")),
      grid.hline(start: 4, end: 5),

      none, none, none, none, grid.cell(align: center, text(size: 9pt)[(индекс)]),

      none, none, none, grid.cell(colspan: 2, align: center, args.at("head_of_faculty", default: "@Фамилия И.О.@")),
      grid.hline(start: 2, end: 3),
      grid.hline(start: 3, end: 5),

      none, none, none, grid.cell(colspan: 2, align: center, text(size: 9pt)[(инициалы и фамилия)]),

      none,
      none,
      grid.cell(
        colspan: 3,
        align: center,
      )["#empty_underline(1cm)" #empty_underline(3cm) 2026 г.],
    )
  }

  #{
    set align(center)
    show: strong

    [
      #text(size: 18pt)[ЗАДАНИЕ] \
      #text(size: 16pt)[на выполнение выпускной квалификационной работы]
    ]
  }

  Студент группы: #{ args.at("group", default: "@РК6-8XБ@") }

  #grid(
    columns: 1fr,
    align: center,
    inset: 0.25em,
    args.at("author_full", default: "@Фамилия Имя Отчество@"),
    grid.hline(stroke: 0.5pt),
    text(size: 9pt)[(фамилия, имя, отчество)]
  )

  Тема выпускной квалификационной работы: #{ args.at("theme", default: "@Тема работы@") }

  При выполнении ВКР:

  #show table.cell.where(y: 0): set text(weight: "regular")
  #table(
    columns: (auto, 1fr, auto),
    none, [Используется / Не используется], [Да/Нет],
    [1)], [Литературные источники и документы, имеющие гриф секретности], none,
    [2)],
    [Литературные источники и документы, имеющие пометку "Для служебного пользования", иных пометок, запрещающих открытое опубликование],
    none,

    [3)], [Служебные материалы других организаций], none,
    [4)], [Результаты НИР (ОКР), выполняемой в МГТУ им. Н.Э. Баумана], none,
    [5)],
    [Материалы по незавершенным исследованиям или материалы по завершенным исследованиям, но ещё не опубликованные в открытой печати],
    none,
  )

  #v(1em)

  #table(
    columns: (auto, 1fr),
    table.cell(colspan: 2)[Тема выпускной квалификационной работы утверждена распоряжением по факультету:],
    [Название факультета:], args.at("faculty", default: ["Робототехника и комплексная автоматизация"]),
    [Дата и рег. номер распоряжения:],
    [№ #empty_underline(2.5cm) от "#empty_underline(1cm)" #empty_underline(3cm) #args.at("year", default: datetime.today().year()) г.],
  )

  #v(1em)

  #context {
    set par(leading: 0.75em)
    for (i, it) in task_parts.final().enumerate(start: 1) {
      show: emph
      par[
        *Часть #i*. #underline(it.name) \
        #underline(it.description)
      ]
    }
  }

  *Оформление выпускной квалификационной работы:*
  #let final_count(of) = counter(of).at(bibliography).first()
  #let citation_count = query(cite).map(it => it.key).dedup().len()

  Расчётно-пояснительная записка на #context { counter(page).at(<appendix-start>).first() } листах формата А4. \
  Перечень графического (иллюстративного) материала (чертежи, плакаты, слайды и т.п.):

  #table(
    columns: 1fr,
    [количество: #context { final_count(figure.where(kind: image)) } рис., #context { final_count(figure.where(kind: table)) } табл., #context { citation_count } источн.],
    ..args.at("slides", default: ()).enumerate(start: 1).map(((i, it)) => [
      Слайд #i. #it
    ])
  )

  Дата выдачи задания "#empty_underline(1cm)" #empty_underline(3cm) #args.at("year", default: datetime.today().year()) г.

  В соответствии с учебным планом выпускную квалификационную работу выполнить в полном объёме в срок до "#empty_underline(1cm)" #empty_underline(3cm) #args.at("year", default: datetime.today().year()) г.

  #{
    set grid.hline(stroke: 0.5pt)
    show grid.cell.where(align: center): set text(size: 9pt)
    grid(
      columns: (1fr, 20%, auto),
      inset: (y: 0.25em),
      column-gutter: 0.5em,
      // stroke: black,
      [*Студент*], none, args.at("author", default: "@И.О. Фамилия@"),
      grid.hline(start: 1, end: 2),
      grid.hline(start: 2, end: 3),

      none, grid.cell(align: center)[(подпись, дата)], grid.cell(align: center)[(И.О. Фамилия)],

      [*Руководитель выпускной квалификационной работы*], none, args.at("supervisor", default: "@И.О. Фамилия@"),
      grid.hline(start: 1, end: 2),
      grid.hline(start: 2, end: 3),

      none, grid.cell(align: center)[(подпись, дата)], grid.cell(align: center)[(И.О. Фамилия)],
    )
  }

  Примечание: Задание оформляется в двух экземплярах: один выдаётся студенту, второй хранится на кафедре.
]
