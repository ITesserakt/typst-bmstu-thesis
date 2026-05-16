#let abstract_page(..args) = [
  #import "preambule.typ": big_heading

  #align(center)[*РЕФЕРАТ*]

  #v(1em)

  #let count_of(of) = context { counter(of).final().last() }

  выпускная квалификационная работа: #count_of(page) с., #count_of(figure.where(kind: image)) рис., #count_of(figure.where(kind: table)) табл., #count_of(cite) источн.

  #v(1em)

  #{args.at("keywords", default: ("@KEYWORDS@", )).map(upper).join(", ")}

  #args.at(
    "abstract",
    default: "@Начать можно так: “Работа посвящена...”. Объём около 0.5 страницы. Здесь следует кратко рассказать о чём работа, на что направлена, что и какими методами было достигнуто. Реферат должен быть подготовлен так, чтобы после её прочтения захотелось перейти к основному тексту работы.@",
  )

  *Тип работы*: выпускная квалификационная работа.

  *Тема работы*: _"#{ args.at("theme", default: "@Тема работы@") }"_

  *Объект исследований*: #args.at("object", default: "@Объект исследований@")

  *Основная задача, на решение которой направлена работа*: #args.at("global_task", default: "@Основная задача, на решение которой направлена работа@")

  *Цель работы*: #args.at("goal", default: "@Цель выполнения работы@")

  В результате выполнения работы: #args.at("solved_tasks", default: ("предложено ...", "создано ...", "разработано ...", "проведены вычислительные эксперименты ...")).enumerate(start: 1).map(((i, it)) => [#{ i }) #it]).join("; ").
]
