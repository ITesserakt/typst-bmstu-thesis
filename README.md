# Typst package for BMSTU thesis documents

This repository provides a [Typst](https://typst.app/home/) package for creating thesis documents, qualification works, and explanatory notes utilizing BMSTU style conventions.

> BMSTU stands for [Bauman Moscow State Technical University](https://bmstu.ru/).

## Installation

Since this package is not yet included in the official [Typst package list](https://github.com/typst/packages), using it requires some manual setup.

One way to do this is by placing the package in your local Typst package directory:

```sh
git clone https://github.com/ITesserakt/typst-bmstu-thesis
mkdir -p $HOME/.local/share/typst/packages/bmstu-thesis/0.1.0
cp -rv typst-bmstu-thesis/* $HOME/.local/share/typst/packages/bmstu-thesis/0.1.0/
```

> These commands are intended for Linux and copy the package contents to your local Typst package path.

## Usage

A minimal usage example may look like this:

```typst
#import "@local/bmstu-thesis:0.1.0": *

#show: template.with(
  author: "Иванов И.И.",
  author_full: "Иванов Иван Иванович",
  group: [РК6-81Б],
  supervisor: [Петров П.П.],
  theme: "Разработка системы ...",
  goal: "Исследование ...",
)

#add_task_part(
  name: "Аналитическая часть",
  content: "Провести анализ существующих решений",
)

= Введение

Текст работы...
```

For more comprehensive example, see `example/example.typ` and `example/example.pdf` of the current repository.

The package automatically generates:

- title page
- assignment sheet
- calendar plan
- abstract
- table of contents

before the main document body.

### Main API

| Function                | Description                                       |
| ----------------------- | ------------------------------------------------- |
| `template`              | Main document template                            |
| `appendix`              | Appendix formatting environment                   |
| `add_task_part`         | Adds a stage/task to assignment and calendar plan |
| `big_heading`           | Creates large centered heading                    |
| `wrap_with_big_heading` | Applies centered uppercase heading style          |

### Document formatting

The template configures document formatting according to common BMSTU thesis requirements:

- A4 paper
- Times New Roman, 14pt
- Automatic page numbering
- Configured heading hierarchy
- Justified paragraphs with indentation
- Chapter-aware numbering for equations, figures, and tables

### Appendices

The package provides a dedicated `appendix` environment that resets counters and switches numbering to appendix-aware format:

```typst
#appendix[
  = Дополнительные материалы

  ...
]
```

This automatically changes numbering style to formats such as:

- `Приложение A` for chapter supplement
- `A.1` for figure caption
- `(A.1)` in equation numbering

## Fonts

The template is primarily designed around the following fonts:

- Times New Roman
- Fira Code

To ensure correct rendering, provide the path to your fonts directory for the Typst compiler.

This can be done either via `TYPST_FONT_PATHS` environment variable or the `--font-paths` command line option.

**The first option:**

```sh
export TYPST_FONT_PATHS "${TYPST_FONT_PATHS}:$HOME/.local/share/typst/packages/bmstu-thesis/0.1.0/fonts"
```

**The second option:**

```sh
typst compile --font-paths $HOME/.local/share/typst/packages/bmstu-thesis/0.1.0/fonts <file.typ>
```

## License

This project is distributed under the MIT license.
