#import "task.typ": add_task_part
#import "preambule.typ": big_heading, wrap_with_big_heading

#let template(
  author: "@Фамилия И.О.@",
  author_full: "@Фамилия Имя Отчество@",
  city: "Москва",
  consultant: none,
  department_index: [РК],
  department: ["Системы автоматизированного проектирования (РК-6)"],
  faculty_index: [РК-6],
  head_of_faculty: [Карпенко А.П.],
  faculty: ["Робототехника и комплексная автоматизация"],
  group: [\@РК6-8XБ\@],
  normocontroller: [Грошев С.В],
  secretary: [Балыкина А.М.],
  supervisor: [\@Фамилия И.О.\@],
  theme: "@Тема работы@",
  goal: "@Цель выполнения работы@",
  object: "@Объект исследований@",
  global_task: "@Основная задача, на решение которой направлена работа@",
  abstract: "@Начать можно так: “Работа посвящена...”. Объём около 0.5 страницы. Здесь следует кратко рассказать о чём работа, на что направлена, что и какими методами было достигнуто. Реферат должен быть подготовлен так, чтобы после её прочтения захотелось перейти к основному тексту работы.@",
  year: datetime.today().year(),
  slides: ([Введение], ),
  keywords: ("@keywords@", ),
  solved_tasks: ("предложено ...", "создано ...", "разработано ...", "проведены вычислительные эксперименты ..."),
  doc,
) = {
  import "preambule.typ": conf
  import "title.typ": title_page
  import "task.typ": task_page
  import "plan.typ": plan_page
  import "abstract.typ": abstract_page
  show: conf

  set document(
    author: author,
    title: theme,
    date: datetime.today()
  )

  let named_args = (
    author: author,
    author_full: author_full,
    theme: theme,
    goal: goal,
    object: object,
    global_task: global_task,
    abstract: abstract,
    department: department,
    department_index: department_index,
    faculty_index: faculty_index,
    head_of_faculty: head_of_faculty,
    normocontroller: normocontroller,
    secretary: secretary,
    faculty: faculty,
    group: group,
    supervisor: supervisor,
    city: city,
    year: year,
    consultant: consultant,
    slides: slides,
    keywords: keywords,
    solved_tasks: solved_tasks
  )

  title_page(..named_args)
  pagebreak()
  task_page(..named_args)
  pagebreak()
  plan_page(..named_args)
  pagebreak()
  abstract_page(..named_args)
  wrap_with_big_heading(outline(depth: 3, indent: 1.25cm, title: [Содержание]))

  doc
}

#let appendix(doc) = {
  import "preambule.typ": chapter_aware_numbering

  counter(heading).update(0)
  counter(heading.where(depth: 1)).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(math.equation).update(0)

  show heading.where(depth: 1): set heading(numbering: "Приложение A. ", supplement: "Приложение")
  show heading.where(depth: 2): set heading(numbering: "A.1", supplement: "Приложение")
  show heading.where(depth: 1): set align(center)

  set figure(numbering: chapter_aware_numbering.with(pattern: "A.1"))
  show figure.where(kind: table): set figure(numbering: chapter_aware_numbering.with(pattern: "A.1"))
  set math.equation(numbering: chapter_aware_numbering.with(pattern: "(A.1)"))

  doc
}

