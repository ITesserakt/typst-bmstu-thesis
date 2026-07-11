#import "task.typ": add_task_part
#import "preambule.typ"

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
  slides: ([Введение],),
  keywords: ("@keywords@",),
  solved_tasks: ("предложено ...", "создано ...", "разработано ...", "проведены вычислительные эксперименты ..."),
  insert_pages: ("title", "abstract"),
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
    date: datetime.today(),
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
    solved_tasks: solved_tasks,
  )

  let first = state("__is_first_page", true)
  let insert_if_contains(name, body) = context if (
    insert_pages == auto or (type(insert_pages) == array and insert_pages.contains(name))
  ) {
    if not first.get() { pagebreak() }
    body(..named_args)
    first.update(false)
  } else {}

  {
    set page(numbering: none)
    insert_if_contains("title", title_page)
    insert_if_contains("task", task_page)
    insert_if_contains("plan", plan_page)
  }
  insert_if_contains("abstract", abstract_page)
  preambule.wrap_with_big_heading(outline(depth: 3, indent: 1.2cm, title: [СОДЕРЖАНИЕ]))

  doc
}

#let appendix(doc) = {
  import "preambule.typ": chapter_aware_numbering

  counter(heading).update(0)
  counter(heading.where(depth: 1)).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(math.equation).update(0)

  show heading.where(depth: 1): set heading(numbering: none, supplement: "Приложение")
  show heading.where(depth: 2): set heading(numbering: "A.1", supplement: "Приложение")
  show heading.where(depth: 1): set align(center)

  set figure(numbering: chapter_aware_numbering.with(pattern: "A.1"))
  show figure.where(kind: table): set figure(numbering: chapter_aware_numbering.with(pattern: "A.1"))
  set math.equation(numbering: chapter_aware_numbering.with(pattern: "(A.1)"))

  doc
}

