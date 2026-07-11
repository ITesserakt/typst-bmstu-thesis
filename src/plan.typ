#let plan_page(..args) = [
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
      columns: (auto, auto, 1fr, 25%, auto, auto),
      inset: (y: 0.25em),
      column-gutter: 0.5em,
      // stroke: black,
      grid.cell(align: right)[*ФАКУЛЬТЕТ*],
      [*#{ args.at("department_index", default: "@ИНДЕКС@") }*],
      none,
      grid.cell(colspan: 3, align: center)[УТВЕРЖДАЮ],
      grid.hline(start: 1, end: 2),

      grid.cell(align: right)[*КАФЕДРА*],
      [*#{ args.at("faculty_index", default: "@ИНДЕКС@") }*],
      none,
      grid.cell(colspan: 2)[Заведующий кафедрой],
      grid.cell(align: center, args.at("faculty_index", default: "@Индекс@")),
      grid.hline(start: 1, end: 2),
      grid.hline(start: 5, end: 6),

      grid.cell(align: right)[*ГРУППА*],
      [*#{ args.at("group", default: "@РК6-8XБ@") }*],
      none,
      none,
      none,
      grid.cell(align: center + top, text(size: 9pt)[(индекс)]),
      grid.hline(start: 1, end: 2),

      none,
      none,
      none,
      none,
      grid.cell(colspan: 2, align: center, args.at("head_of_faculty", default: "@Фамилия И.О.@")),
      grid.hline(start: 3, end: 4),
      grid.hline(start: 4, end: 6),

      none,
      none,
      none,
      none,
      grid.cell(colspan: 2, align: center, text(size: 9pt)[(инициалы и фамилия)]),

      none,
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
    set text(size: 14pt)

    [
      КАЛЕНДАРНЫЙ ПЛАН \
      выполнения выпускной квалификационной работы
    ]
  }

  #v(1em)

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

  #context {
    set text(size: 10pt)
    show table.cell.where(y: 1): it => {
      show: strong
      it
    }
    set par(justify: false)

    let year = args.at("year", default: datetime.today().year())
    let supervisor = args.at("supervisor", default: "@Фамилия И.О.@")
    let mkDate(day, month) = [
      #let _day = if day == none { empty_underline(0.3cm) } else { day }
      #let _month = if month == none { empty_underline(0.3cm) } else { month }

      #set text(size: 10pt)
      #{ _day }.#{ _month }.#{ year }
    ]
    let final_task_parts = task_parts.final()

    table(
      columns: (6%, 3fr, 1fr, 1fr, 17%, 17%),
      align: (x, y) => if y == 0 or y == 1 or x != 1 { center + horizon } else { left + horizon },
      table.cell(rowspan: 2)[№ п/п],
      table.cell(rowspan: 2)[Наименование этапов выпускной квалификационной работы],
      table.cell(colspan: 2)[Сроки выполнения этапов],
      table.cell(colspan: 2)[Отметка о выполнении],
      [план], [факт], [Должность], [ФИО, подпись],

      [1.],
      [Задание на выполнение работы. \ Формулировка проблемы, цели и задач],
      mkDate("11", "02"),
      none,
      text(size: 10pt)[Руководитель ВКР],
      text(size: 8pt, supervisor),

      [2.],
      [Часть 1: #underline(final_task_parts.first().name)],
      mkDate(..final_task_parts.first().planned_date),
      none,
      text(size: 10pt)[Руководитель ВКР],
      text(size: 8pt, supervisor),

      [3.],
      [Утверждение окончательных формулировок решаемой проблемы, цели работы и задачи],
      mkDate("27", "02"),
      none,
      text(size: 10pt)[Заведующий кафедрой],
      text(size: 8pt, args.at("head_of_faculty", default: "@Фамилия И.О.@")),

      ..{
        final_task_parts
          .enumerate(start: 3)
          .filter(((i, it)) => i != 3)
          .map(((i, it)) => {
            (
              [#{ i }.],
              [Часть #{ i - 2 }: #underline(it.name)],
              mkDate(..it.planned_date),
              none,
              text(size: 10pt)[Руководитель ВКР],
              text(size: 8pt, supervisor),
            )
          })
          .flatten()
      },

      [#{ final_task_parts.len() + 3 }.],
      [1-я редакция работы],
      mkDate("31", "05"),
      none,
      text(size: 10pt)[Руководитель ВКР],
      text(size: 8pt, supervisor),

      [#{ final_task_parts.len() + 4 }.],
      [Подготовка доклада и презентации],
      mkDate("16", "06"),
      none,
      text(size: 10pt)[Руководитель ВКР],
      text(size: 8pt, supervisor),

      [#{ final_task_parts.len() + 5 }.],
      [Отзыв руководителя],
      mkDate("19", "06"),
      none,
      text(size: 10pt)[Руководитель ВКР],
      text(size: 8pt, supervisor),

      [#{ final_task_parts.len() + 6 }.],
      [Нормоконтроль],
      mkDate("22", "06"),
      none,
      text(size: 10pt)[Нормоконтролер],
      text(size: 8pt, args.at("normocontroller", default: "@Фамилия И.О.@")),

      [#{ final_task_parts.len() + 7 }.],
      [Внешняя рецензия],
      mkDate("23", "06"),
      none,
      text(size: 10pt)[Секретарь ГЭК],
      text(size: 8pt, args.at("secretary", default: "@Фамилия И.О.@")),

      [#{ final_task_parts.len() + 8 }.],
      [Защита работы на ГЭК],
      mkDate("26", "06"),
      none,
      text(size: 10pt)[Секретарь ГЭК],
      text(size: 8pt, args.at("secretary", default: "@Фамилия И.О.@")),
    )
  }

  #{
    set grid.hline(stroke: 0.5pt)
    show grid.cell.where(align: center): set text(size: 9pt)
    set text(size: 10pt)

    grid(
      columns: (auto, auto, auto, 1fr, auto, auto, auto),
      inset: (y: 0.25em),
      column-gutter: 0.5em,
      [Студент],
      none,
      args.at("author", default: "@Фамилия И.О.@"),
      none,
      [Руководитель ВКР],
      none,
      args.at("supervisor", default: "@Фамилия И.О.@"),
      grid.hline(start: 1, end: 2),
      grid.hline(start: 2, end: 3),
      grid.hline(start: 5, end: 6),
      grid.hline(start: 6, end: 7),

      none,
      grid.cell(align: center)[(подпись, дата)],
      grid.cell(align: center)[(ФИО)],
      none,
      none,
      grid.cell(align: center)[(подпись, дата)],
      grid.cell(align: center)[(ФИО)],
    )
  }
]
