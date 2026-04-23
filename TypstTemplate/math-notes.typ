// ╔════════════════════════════════════════════════════════════════════╗
// ║                                                                    ║
// ║                ELEGANTBOOK 风格的 Typst 数学笔记模板              ║
// ║                        目前仅实现封面、页眉、页脚                 ║
// ║                                                                    ║
// ║   说明:                                                            ║
// ║   - 版式参考 elegantbook.cls 的封面和页眉页脚                      ║
// ║   - 代码组织方式参考 computer-notes.typ                            ║
// ║   - 其余样式后续再逐步迁移                                         ║
// ║                                                                    ║
// ╚════════════════════════════════════════════════════════════════════╝


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 0: 全局变量                                                │
// │                                                                    │
// │ 先把后续会反复用到的颜色、字体和尺寸集中定义，便于统一调整。        │
// └────────────────────────────────────────────────────────────────────┘

/// 主题主色 - 深蓝灰色调，优雅沉稳
#let color-structure = rgb("#2C5F7C")

/// 封面横条颜色 - 柔和的珊瑚色作为点缀
#let color-cover-line = rgb("#E07B54")

/// 标题主色 - 深墨色
#let color-title = rgb("#1C1C1C")

/// 正文主色 - 柔和深灰
#let color-main-text = rgb("#2D2D2D")

/// 次级说明文字颜色 - 中灰
#let color-muted = rgb("#5A5A5A")

// 高亮背景色 - 柔和琥珀色
#let color-highlight = rgb("#E8C547")

/// 浅灰边框色
#let color-border-light = rgb("#D4D4D4")

/// theorem-like 主要组件渐变色系
#let color-theorem-bg-1 = rgb("#FFF4F4")
#let color-theorem-bg-2 = rgb("#F8E7E7")
#let color-theorem-border = rgb("#C95A5A")

#let color-definition-bg-1 = rgb("#F2FAEF")
#let color-definition-bg-2 = rgb("#E5F3DF")
#let color-definition-border = rgb("#4FA36A")

#let color-proposition-bg-1 = rgb("#F2F6FF")
#let color-proposition-bg-2 = rgb("#E5ECFA")
#let color-proposition-border = rgb("#4E77B7")

#let color-axiom-bg-1 = rgb("#FBF2FF")
#let color-axiom-bg-2 = rgb("#F0E3FA")
#let color-axiom-border = rgb("#9B65C9")

#let color-example-bg-1 = rgb("#FFF8EC")
#let color-example-bg-2 = rgb("#F9EFD6")
#let color-example-border = rgb("#D59A2A")

#let color-annot-note-bg = rgb("#F3F5F8")
#let color-annot-note-border = rgb("#96A2B6")
#let color-annot-note-accent = rgb("#50627E")

#let color-annot-caution-bg = rgb("#FFF0F0")
#let color-annot-caution-border = rgb("#E39A9A")
#let color-annot-caution-accent = rgb("#B03A3A")

/// 页面基础边距
#let page-margin-top = 2.1cm
#let page-margin-bottom = 1.2cm
#let page-margin-left = 1.8cm
#let page-margin-right = 1.8cm

/// 页眉页脚文字大小
#let font-header-size = 10pt
#let font-footer-size = 10pt

/// 封面标题和副标题字号
#let font-cover-title-size = 30pt
#let font-cover-subtitle-size = 15pt

/// 封面信息区字号
#let font-cover-meta-size = 11pt

/// 组件统一字号：主组件正文
#let font-widget-body-size = 11pt

/// 组件统一字号：主组件标题/标签
#let font-widget-title-size = 11pt

/// 组件统一字号：主组件编号
#let font-widget-number-size = 11pt

/// 组件统一字号：次要组件标题
#let font-widget-secondary-title-size = 12pt

/// 封面右下角 Logo 大小
#let cover-logo-size = 4.2cm

/// Part 页面罗马数字字号
#let part-num-size = 7.5em

/// Part 页面标题字号
#let part-title-size = 2.5em

/// 中文正文字体回退链
#let font-cjk-main = ("Source Han Serif SC", "STSong", "SimSun")

/// 拉丁正文字体回退链
#let font-latin-main = ("Book Antiqua", "Times New Roman")

/// Part 名称（与 elegantbook 的 partname 对齐）
#let part-name = "Part"

/// 拉丁标题字体回退链
#let font-latin-title = ("Georgia", "Merriweather", "Times New Roman")

/// 主要组件标签字体（参考 elegantbook 的 cursivetitle 气质）
#let font-major-label = ("Monotype Corsiva", "Merriweather", "Georgia")

/// note / caution 注释字体
#let font-annot-text = ("Neutra Text TF", "Segoe UI", "Times New Roman")

/// theorem-like 正文字体（参考 elegantbook theorem/definition/proposition 字体）
#let font-theorem-widget = ("Stempel Garamond LT Std", "Times New Roman", "Palatino Linotype")

/// 等宽字体回退链
#let font-mono = ("Consolas", "JetBrainsMono NF", "Courier New")


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 0.5: Part 状态                                            │
// │                                                                    │
// │ Part 在 math 模板里只承担章节分组作用，因此单独提供一个命令。      │
// └────────────────────────────────────────────────────────────────────┘

/// 当前 Part 标题
#let part-title-state = state("part-title", none)

/// 当前 Part 位置
#let part-location-state = state("part-location", none)

/// Part 计数器
#let part-counter = counter("part-counter")

/// Part 首个 Chapter 编号（用于目录中判断何时显示 Part 行）
#let part-first-chapter-num = state("part-first-chapter-num", 0)

/// Chapter 计数器（独立于 Typst heading 默认计数，避免编号异常）
#let chapter-counter = counter("chapter-counter")

/// Section 计数器
#let section-counter = counter("section-counter")

/// theorem-like 组件计数器
#let theorem-counter = counter("theorem-counter")
#let corollary-counter = counter("corollary-counter")
#let lemma-counter = counter("lemma-counter")
#let definition-counter = counter("definition-counter")
#let proposition-counter = counter("proposition-counter")
#let property-counter = counter("property-counter")
#let example-counter = counter("example-counter")
#let axiom-counter = counter("axiom-counter")
#let postulate-counter = counter("postulate-counter")

/// theorem-like 显示编号：章号.本组件序号（例如 1.1）
#let chapter-widget-number(local-num) = {
  let ch = chapter-counter.get().first()
  let chapter-num = if ch > 0 { ch } else { 1 }
  str(chapter-num) + "." + str(local-num)
}

/// Chapter 显示编号状态（供目录读取）
#let chapter-num-state = state("chapter-num-state", 0)

/// Section 显示编号状态（供目录读取）
#let section-num-state = state("section-num-state", 0)


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 1: 辅助函数                                                │
// │                                                                    │
// │ 这些函数专门用于提取当前页的章节信息。页眉逻辑会依赖它们。          │
// └────────────────────────────────────────────────────────────────────┘

/// 获取某一级标题在指定位置之前出现的最后一个标题文本
#let last-heading-before(level, location) = {
  let elems = query(heading.where(level: level).before(location))
  if elems.len() > 0 { elems.last().body } else { none }
}

/// 判断当前页是否正好是一级标题所在页
#let page-has-level-1-heading(page-number) = {
  let found = false
  for item in query(heading.where(level: 1)) {
    if item.location().page() == page-number {
      found = true
      break
    }
  }
  found
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 1.5: Part 页面                                             │
// │                                                                    │
// │ 优雅的 Part 页面设计：简洁装饰、清晰层次。                         │
// └────────────────────────────────────────────────────────────────────┘

/// 独立 Part 页面
#let part(title) = {
  context {
    let next-chapter-num = counter(heading).get().first() + 1
    part-first-chapter-num.update(next-chapter-num)
  }

  part-title-state.update(_ => title)
  part-counter.step()
  context {
    let loc = here()
    part-location-state.update(loc)
  }

  [
    #pagebreak(weak: true)
    #page(margin: 0cm, header: none, footer: none)[
      #set par(justify: false, first-line-indent: 0em)

      // 背景：浅色渐变
      #place(top + left)[
        #box(width: 100%, height: 100%, fill: gradient.linear(
          (color-structure.lighten(90%), 0%),
          (white, 30%),
          (white, 70%),
          (color-structure.lighten(92%), 100%),
        ))
      ]

      // 左侧装饰条
      #place(top + left)[
        #box(width: 0.5cm, height: 100%, fill: color-structure)
      ]

      // 右下角装饰
      #place(bottom + right)[
        #box(width: 8cm, height: 0.3cm, fill: color-cover-line)
      ]

      // Part 编号：超大罗马数字
      #place(center, dy: 4cm, context [
        #text(
          font: font-latin-title,
          size: 80pt,
          weight: "bold",
          fill: color-structure.lighten(70%),
        )[
          #numbering("I", part-counter.get().first())
        ]
      ])

      // Part 标签
      #place(center, dy: 5cm)[
        #text(
          font: font-latin-title,
          size: 14pt,
          fill: color-muted,
          style: "italic",
        )[
          #part-name
        ]
      ]

      // Part 标题
      #place(center, dy: 9cm)[
        #text(
          font: font-latin-title,
          size: part-title-size + 6pt,
          weight: "bold",
          fill: color-title,
        )[
          #title
        ]
      ]

      // 标题下装饰线
      #place(center, dy: 13cm)[
        #box(width: 20%, height: 2pt, fill: color-structure)
      ]
    ]
    // #pagebreak()
  ]
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 2: 页眉页脚                                                │
// │                                                                    │
// │ 这里直接复刻 elegantbook 的核心结构：                               │
// │ - 章节页第一页不显示页眉                                            │
// │ - 偶数页显示章标题（左侧）                                          │
// │ - 奇数页显示节标题（右侧）                                          │
// │ - 页脚居中显示页码                                                 │
// └────────────────────────────────────────────────────────────────────┘

/// 页眉：仿 elegantbook 的章/节标题布局
#let elegant-header = context {
  let current-page = here().page()
  let is-even-page = calc.rem(current-page, 2) == 0

  // 一级标题所在页不显示页眉，和 elegantbook 的 plain 页面效果保持一致
  if page-has-level-1-heading(current-page) {
    none
  } else {
    let chapter-title = last-heading-before(1, here())
    let section-title = last-heading-before(2, here())
    let header-title = if is-even-page {
      chapter-title
    } else {
      if section-title != none { section-title } else { chapter-title }
    }

    if header-title == none {
      none
    } else {
      [
        #if is-even-page [
          #text(size: font-header-size, font: font-latin-main, fill: color-structure)[#header-title]
        ] else [
          #align(right)[
            #text(size: font-header-size, font: font-latin-main, fill: color-structure)[#header-title]
          ]
        ]
        #v(-5pt)
        #line(length: 100%, stroke: (thickness: 1pt, paint: color-structure))
      ]
    }
  }
}

/// 页脚：居中页码
#let elegant-footer = context {
  align(center)[
    #text(size: font-footer-size, font: font-latin-main, fill: color-structure)[
      #counter(page).display()
    ]
  ]
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 3: 封面工具                                                │
// │                                                                    │
// │ 现代简洁风格封面设计：                                             │
// │ - 几何装饰元素（色块、线条）                                       │
// │ - 居中对称布局                                                     │
// │ - 清晰的信息层级                                                  │
// │ - 无图片依赖                                                       │
// └────────────────────────────────────────────────────────────────────┘

/// 封面信息行：用于显示作者、单位、日期、版本等信息
#let cover-meta-row(label, value) = {
  if value == none {
    []
  } else {
    [
      #text(size: font-cover-meta-size, fill: color-muted, font: font-cjk-main)[
        #text(weight: "bold")[#label]
      ]
      #text(size: font-cover-meta-size, fill: color-muted, font: font-cjk-main)[#value]
      #linebreak()
    ]
  }
}

/// 封面页
///
/// 参数说明：
/// - title: 封面主标题
/// - author: 作者
/// - subtitle: 副标题（可选）
/// - institute: 单位（可选）
/// - date: 日期（可选）
/// - version: 版本号（可选）
/// - extra-info: 底部补充说明（可选）
/// - cover-image: 顶部封面图（可选，已弃用）
/// - logo-image: 右下角 Logo（可选，已弃用）
#let make-cover(
  title,
  author,
  subtitle: none,
  institute: none,
  date: none,
  version: none,
  extra-info: none,
  cover-image: none,
  logo-image: none,
) = {
  return [
    #pagebreak(weak: true)
    #page(margin: 0cm, header: none, footer: none)[
      #set par(justify: false, first-line-indent: 0em)
      #set text(font: font-cjk-main, fill: color-main-text)

      // 顶部装饰：左侧色块 + 右侧渐变条
      #place(top + left)[
        #box(width: 35%, height: 2.8cm, fill: color-structure)
      ]
      #place(top + right)[
        #box(width: 65%, height: 2.8cm, fill: gradient.linear(
          (color-structure.lighten(15%), 0%),
          (color-structure.lighten(45%), 100%),
        ))
      ]

      // 左上角装饰：小方块点缀
      #place(top + left, dx: 1.2cm, dy: 0.6cm)[
        #box(width: 0.4cm, height: 0.4cm, fill: white, radius: 2pt)
      ]
      #place(top + left, dx: 1.9cm, dy: 0.6cm)[
        #box(width: 0.4cm, height: 0.4cm, fill: white.lighten(30%), radius: 2pt)
      ]
      #place(top + left, dx: 2.6cm, dy: 0.6cm)[
        #box(width: 0.4cm, height: 0.4cm, fill: white.lighten(50%), radius: 2pt)
      ]

      #v(4.5cm)

      // 主标题区域：居中显示
      #align(center)[
        #v(17em)
        // 主标题
        #text(size: font-cover-title-size + 6pt, font: font-latin-title, weight: "bold", fill: color-title)[
          #title
        ]

        #v(0.8em)

        // 装饰线：渐变效果
        #box(width: 40%, height: 3pt, fill: gradient.linear(
          (color-structure.lighten(60%), 0%),
          (color-structure, 50%),
          (color-structure.lighten(60%), 100%),
        ))

        #v(1.2em)

        // 副标题
        #if subtitle != none [
          #text(size: font-cover-subtitle-size + 2pt, font: font-cjk-main, fill: color-muted)[
            #subtitle
          ]
          #v(1.5em)
        ]
      ]

      #v(3.0fr)

      // 作者信息区域：居中显示
      #align(center)[
        #box(width: 50%)[
          #align(center)[
            #cover-meta-row("Author: ", author)
            #cover-meta-row("Institute: ", institute)
            #cover-meta-row("Date: ", date)
            #cover-meta-row("Version: ", version)
          ]
        ]
      ]

      #v(1.0fr)

      // 底部装饰：细线 + 补充说明
      #align(center)[
        #box(width: 60%, height: 1pt, fill: color-structure.lighten(70%))
      ]

      #v(0.8em)

      #if extra-info != none [
        #align(center)[
          #text(size: 10pt, font: font-cjk-main, fill: color-muted.lighten(20%))[
            #extra-info
          ]
        ]
      ]

      #v(1.7cm)

      // 底部装饰：右侧色块
      #place(bottom + right)[
        #box(width: 70%, height: 0.5cm, fill: color-cover-line)
      ]
      #place(bottom + right, dx: -70%)[
        #box(width: 30%, height: 0.5cm, fill: color-cover-line.lighten(25%))
      ]
    ]
    #pagebreak()
  ]
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 3.5: 目录页                                                │
// │                                                                    │
// │ 目录页参考 elegantbook 的层级风格：                                 │
// │ - Part: 居中高亮条                                                  │
// │ - Chapter: 明显的主条目                                             │
// │ - Section: 次级条目                                                 │
// └────────────────────────────────────────────────────────────────────┘

/// 单行目录条目渲染
#let outline-row(
  text-size: 11pt,
  text-weight: "regular",
  text-color: black,
  number: none,
  title: none,
  page: "0",
  location: none,
) = {
  set text(size: text-size, fill: text-color, weight: text-weight)
  box(width: 100%)[
    #grid(
      columns: (1.2cm, 1fr, auto),
      align: (left + top, left, left),
      gutter: 0pt,
      number,
      [ #link(location, title) #box(width: 1fr, repeat(text(weight: "regular")[· #h(4pt)])) ],
      [ #h(4pt) #link(location, page) ],
    )
  ]
}

/// 主目录生成器
#let make-outline(depth: 3, title: "Contents") = {
  return [
    // 现代简洁的目录标题设计
    #v(2.5em)
    #align(center)[
      // 主标题
      #text(size: 36pt, font: font-latin-title, weight: "bold", fill: color-title)[
        #title
      ]
      #v(-1.2em)
      // 装饰线：渐变效果
      #box(width: 30%, height: 3pt, fill: gradient.linear(
        (color-structure.lighten(70%), 0%),
        (color-structure, 50%),
        (color-structure.lighten(70%), 100%),
      ))
      #v(0.8em)
      // 副标题
      #text(size: 12pt, font: font-latin-title, fill: color-muted, style: "italic")[
        Table of Contents
      ]
    ]
    #v(2.0em)
    
    // 使用 query 手动生成目录，完全控制渲染
    #context {
      // 获取所有层级的标题（从1到depth）
      let headings = query(heading.where())
      
      for elem in headings {
        // 只处理指定深度内的标题
        if elem.level > depth {
          continue
        }
        
        let counter-int = counter(heading).at(elem.location())
        let numbering-setting = elem.numbering
        let num = none
        if numbering-setting != none and counter-int.first() > 0 {
          num = numbering("1.", ..counter-int)
        }
        let title-content = elem.body
        let heading-page = str(elem.location().page())

        if elem.level == 1 {
          // Chapter 层级
          let p-state = part-title-state.at(elem.location())
          let p-location = part-location-state.at(elem.location())
          let p-counter = part-counter.at(elem.location())
          let p-first-ch = part-first-chapter-num.at(elem.location())

          // 判断是否是新 Part 的首个 Chapter
          let is-new-part = (p-location != none) and (counter-int.first() == p-first-ch)

          if (is-new-part) {
            grid(
              columns: (1.2cm, 1fr),
              align: (center + horizon),
              gutter: 0pt,
              rect(
                width: 1.2cm,
                height: 0.7cm,
                fill: color-structure.lighten(80%),
                inset: 2pt,
                align(center, text(
                  size: 1.3em,
                  weight: "bold",
                  fill: color-structure.lighten(30%),
                  font: font-latin-title,
                  numbering("I", p-counter.first()),
                )),
              ),
              rect(
                width: 100% - 0.2cm,
                fill: color-structure.lighten(60%),
                inset: 5pt,
                align(center, link(p-location, text(
                  size: 1.3em,
                  weight: "bold",
                  font: font-latin-title,
                  p-state,
                ))),
              ),
            )
          } else {
            v(0.3cm, weak: true)
          }
          // Chapter 层级
          outline-row(
            text-weight: "bold",
            text-size: 13pt,
            text-color: color-structure,
            number: num,
            title: title-content,
            page: heading-page,
            location: elem.location(),
          )
        } else if elem.level == 2 {
          // Section 层级
          outline-row(
            text-weight: "bold",
            text-size: 11pt,
            text-color: black,
            number: num,
            title: title-content,
            page: heading-page,
            location: elem.location(),
          )
        } else if elem.level == 3 {
          // Subsection 层级
          outline-row(
            text-weight: "regular",
            text-size: 10pt,
            text-color: black,
            number: num,
            title: title-content,
            page: heading-page,
            location: elem.location(),
          )
        }
      }
    }
  ]
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 4: theorem-like 主要组件                                   │
// │                                                                    │
// │ 采用 elegantbook 风格的左上角标签 + 右下角花色装饰，                │
// │ 底层排版结构参考 computer-notes 的 callout。                        │
// └────────────────────────────────────────────────────────────────────┘

/// theorem-like 通用生成器
#let major-box(label, suit, bg-1, bg-2, border-color, body, number: none, name: none, body-font: font-theorem-widget, body-style: "normal") = {
  return [
    #v(0.8em)
    #block(width: 100%)[
      #set par(first-line-indent: 0em)
      #set text(size: font-widget-body-size, fill: color-main-text, font: body-font, style: body-style)

      // 主体内容块：明显渐变背景 + 整体边框
      #block(
        fill: gradient.linear(
          (bg-1.lighten(32%), 0%),
          (bg-1.lighten(10%), 12%),
          (bg-2.lighten(8%), 44%),
          (bg-1.darken(2%), 72%),
          (bg-1.darken(22%), 100%),
        ),
        stroke: 1.15pt + border-color.darken(10%),
        radius: 5pt,
        inset: (left: 1.15em, top: 0.9em, bottom: 0.9em, right: 1em),
        width: 100%,
      )[
        #body
      ]

      // 左上角标签：模仿 elegantbook 的 theorem title 贴边样式
      #place(top + left, dx: 0.8em, dy: -0.7em)[
        #box(
          fill: border-color,
          stroke: 0.7pt + border-color.darken(10%),
          radius: 0pt,
          inset: (x: 0.55em, y: 0.25em),
        )[
          #text(font: font-major-label, size: font-widget-title-size, weight: "bold", fill: white)[
            #label
            #if number != none [
              #h(0.35em)
              #text(font: font-major-label, size: font-widget-number-size, weight: "regular")[#number]
            ]
            #if name != none [
              #h(0.4em)
              #text(font: body-font, size: font-widget-number-size, weight: "regular")[#name]
            ]
          ]
        ]
      ]

      // 右下角花色：四种花色作为统一装饰
      #place(bottom + right, dx: -0.45em, dy: -0.1em)[
        #text(font: font-latin-title, size: 19pt, weight: "bold", fill: border-color.darken(2%))[
          #suit
        ]
      ]
    ]
    #v(0.15em)
  ]
}

/// 主要组件：定理 / 推论 / 引理
#let theorem(body, name: none) = {
  context {
    let local-num = theorem-counter.get().first() + 1
    theorem-counter.step()
    let num = chapter-widget-number(local-num)
    major-box("Theorem", [♥], color-theorem-bg-1, color-theorem-bg-2, color-theorem-border, body, number: num, name: name, body-font: font-theorem-widget)
  }
}
#let corollary(body, name: none) = {
  context {
    let local-num = corollary-counter.get().first() + 1
    corollary-counter.step()
    let num = chapter-widget-number(local-num)
    major-box("Corollary", [♥], color-theorem-bg-1, color-theorem-bg-2, color-theorem-border, body, number: num, name: name, body-font: font-theorem-widget)
  }
}
#let lemma(body, name: none) = {
  context {
    let local-num = lemma-counter.get().first() + 1
    lemma-counter.step()
    let num = chapter-widget-number(local-num)
    major-box("Lemma", [♥], color-theorem-bg-1, color-theorem-bg-2, color-theorem-border, body, number: num, name: name, body-font: font-theorem-widget)
  }
}

/// 主要组件：定义
#let definition(body, name: none) = {
  context {
    let local-num = definition-counter.get().first() + 1
    definition-counter.step()
    let num = chapter-widget-number(local-num)
    major-box("Definition", [♣], color-definition-bg-1, color-definition-bg-2, color-definition-border, body, number: num, name: name, body-font: font-theorem-widget)
  }
}

/// 主要组件：命题 / 性质 / 例子
#let proposition(body, name: none) = {
  context {
    let local-num = proposition-counter.get().first() + 1
    proposition-counter.step()
    let num = chapter-widget-number(local-num)
    major-box("Proposition", [♠], color-proposition-bg-1, color-proposition-bg-2, color-proposition-border, body, number: num, name: name, body-font: font-theorem-widget)
  }
}
#let property(body, name: none) = {
  context {
    let local-num = property-counter.get().first() + 1
    property-counter.step()
    let num = chapter-widget-number(local-num)
    major-box("Property", [♣], color-definition-bg-1, color-definition-bg-2, color-definition-border, body, number: num, name: name, body-font: font-theorem-widget)
  }
}
#let example(body, name: none) = {
  context {
    let local-num = example-counter.get().first() + 1
    example-counter.step()
    let num = chapter-widget-number(local-num)
    major-box("Example", [♠], color-example-bg-1, color-example-bg-2, color-example-border, body, number: num, name: name, body-font: font-theorem-widget)
  }
}

/// 主要组件：公理 / 公设
#let axiom(body, name: none) = {
  context {
    let local-num = axiom-counter.get().first() + 1
    axiom-counter.step()
    let num = chapter-widget-number(local-num)
    major-box("Axiom", [♦], color-axiom-bg-1, color-axiom-bg-2, color-axiom-border, body, number: num, name: name, body-font: font-theorem-widget)
  }
}
#let postulate(body, name: none) = {
  context {
    let local-num = postulate-counter.get().first() + 1
    postulate-counter.step()
    let num = chapter-widget-number(local-num)
    major-box("Postulate", [♦], color-axiom-bg-1, color-axiom-bg-2, color-axiom-border, body, number: num, name: name, body-font: font-theorem-widget)
  }
}

/// 注释类配色方案（仅保留 note / caution）
#let note-palette(kind: "note") = {
  if kind == "caution" {
    (title: "Caution", icon: [!], bg: color-annot-caution-bg, border: color-annot-caution-border, accent: color-annot-caution-accent)
  } else {
    (title: "Note", icon: [i], bg: color-annot-note-bg, border: color-annot-note-border, accent: color-annot-note-accent)
  }
}

/// 注释组件：独立于主组件族，不编号，可切换/覆盖色系
#let note(
  body,
  kind: "note",
  title: none,
  icon: none,
  bg: none,
  border: none,
  accent: none,
) = {
  let p = note-palette(kind: kind)
  let title-text = if title != none { title } else { p.title }
  let icon-text = if icon != none { icon } else { p.icon }
  let bg-color = if bg != none { bg } else { p.bg }
  let border-color = if border != none { border } else { p.border }
  let accent-color = if accent != none { accent } else { p.accent }

  [
    #v(0.7em)
    #block(
      width: 100%,
      fill: gradient.linear((bg-color.lighten(7%), 0%), (bg-color, 65%), (bg-color.darken(3%), 100%)),
      stroke: (
        left: 2.2pt + accent-color,
        top: 0.85pt + border-color,
        right: 0.85pt + border-color,
        bottom: 0.85pt + border-color,
      ),
      radius: 4pt,
      inset: (left: 0.9em, right: 0.9em, top: 0.62em, bottom: 0.62em),
    )[
      #set par(first-line-indent: 0em)
      #set text(
        size: font-widget-body-size,
        fill: color-main-text,
        font: font-annot-text,
        style: "normal",
      )

      #text(font: font-annot-text, size: 11pt, style: "normal", weight: "bold", fill: accent-color)[#icon-text #h(0.35em) #title-text]
      #v(0.18em)
      #body
    ]
    #v(0.1em)
  ]
}

/// 快捷别名
#let caution(body, title: none) = note(body, kind: "caution", title: title)


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 4.5: 次要组件                                             │
// │                                                                    │
// │ proof / solution: 低饱和边框、无背景，突出推导过程。               │
// │ exercise: 轻量练习块，不编号。                                     │
// └────────────────────────────────────────────────────────────────────┘

/// proof / solution 通用块（不编号）
#let reasoning-box(label, icon, end-mark, body, name: none) = {
  [
    #v(0.7em)
    #block(
      width: 100%,
      stroke: 0.9pt + color-border-light.darken(15%),
      radius: 3pt,
      inset: (left: 0.9em, right: 0.9em, top: 0.6em, bottom: 0.55em),
    )[
      #set par(first-line-indent: 0em)
      #set text(
        size: font-widget-body-size,
        fill: color-main-text,
        font: (..font-latin-main, ..font-cjk-main),
        style: "normal",
      )

      #grid(
        columns: (auto, 1fr),
        gutter: 0.35em,
        align: (left + horizon, left + horizon),
        text(font: font-latin-title, size: font-widget-title-size, weight: "bold", fill: color-structure)[#icon],
        text(font: font-major-label, size: font-widget-secondary-title-size, style: "italic", weight: "bold", fill: color-title)[
          #label
          #if name != none [#h(0.35em)#name]
        ],
      )
      #v(0.25em)

      #body

      #v(0.35em)
      #align(right)[
        #text(size: 10.5pt, fill: color-title)[#end-mark]
      ]
    ]
    #v(0.1em)
  ]
}

/// Proof：结尾实心黑方框
#let proof(body, name: none) = reasoning-box("Proof", [◆], [■], body, name: name)

/// Solution：结尾空心方框
#let solution(body, name: none) = reasoning-box("Solution", [◇], [□], body, name: name)

/// Exercise：轻量练习块（不编号）
#let exercise(body, name: none) = {
  [
    #v(0.65em)
    #block(
      width: 100%,
      fill: color-structure.lighten(95%),
      stroke: 0.95pt + color-structure.lighten(35%),
      radius: 4pt,
      inset: (left: 0.9em, right: 0.9em, top: 0.65em, bottom: 0.65em),
    )[
      #set par(first-line-indent: 0em)
      #set text(size: font-widget-body-size, fill: color-main-text, font: font-theorem-widget)

      #text(font: font-latin-title, size: font-widget-title-size, weight: "bold", fill: color-structure)[
        Exercise
        #if name != none [#h(0.35em)#name]
      ]
      #v(0.22em)
      #body
    ]
    #v(0.1em)
  ]
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 4.6: 表格工具                                             │
// │                                                                    │
// │ 直接移植 computer-notes 的表格思路：                               │
// │ - tex-table:   主题风格表格，只有横线                              │
// │ - plain-table: 普通网格表格，完整表线                              │
// │ - fancy-divider: 渐变分隔线                                        │
// └────────────────────────────────────────────────────────────────────┘

/// 统一单元格内容的基线对齐（解决中英文混排偏移问题）
#let cell-content(c) = {
  text(top-edge: "cap-height", bottom-edge: "baseline")[#c]
}

/// 主题风格表格（无竖线，仅横线分隔）
#let tex-table(..args) = {
  let arr = args.pos()
  if arr.len() == 0 { return [] }

  let header = arr.at(0)
  let data-rows = arr.slice(1)
  let col-count = header.len()

  // 表头单元格（加粗 + 居中基线对齐）
  let header-cells = header.map(c => cell-content(text(weight: "bold")[#c]))

  // 数据单元格（居中基线对齐）
  let body-cells = ()
  for row in data-rows {
    for cell in row { body-cells.push(cell-content(cell)) }
  }

  // 构建并居中显示表格
  let col-defs = (auto,) * col-count
  align(center)[
    #table(
      columns: col-defs,
      align: center + horizon,
      stroke: (x, y) => if y == 0 {
        (bottom: 0.7pt + black)
        (top: 0.7pt + black)
      }
      else if y == data-rows.len() {
        (bottom: 0.7pt + black)
      }
      else {
        none
      },
      ..header-cells, ..body-cells,
    )
  ]
}

/// 普通网格表格（有横线和竖线）
#let plain-table(..args) = {
  let arr = args.pos()
  if arr.len() == 0 { return [] }

  let header = arr.at(0)
  let data-rows = arr.slice(1)
  let col-count = header.len()

  // 表头单元格（加粗 + 居中基线对齐）
  let header-cells = header.map(c => cell-content(text(font: font-latin-title, weight: "bold")[#c]))

  // 数据单元格（居中基线对齐）
  let body-cells = ()
  for row in data-rows {
    for cell in row { body-cells.push(cell-content(cell)) }
  }

  // 构建并居中显示表格
  let col-defs = (auto,) * col-count
  align(center)[
    #table(
      columns: col-defs,
      align: center + horizon,
      stroke: gradient.linear(gray, silver),
      gutter: 1.5pt,
      fill: (col, row) => {
        if row == 0 { silver } 
        else if (col == 0) { silver }
        // else if (calc.rem(row, 2) == 0) { gray.lighten(76%) } 
        else { white }
      },
      ..header-cells, ..body-cells,
    )
  ]
}

/// 默认表格样式配置对象（可直接传入 table/tablex 的参数）
#let default-table-style = (
  inset: (x: 8pt, y: 5pt),
  stroke: color-border-light,
)

/// 行内高亮文字（复刻 computer-notes 的 highlight 样式）
#let highlight(body) = {
  [
    #box(
      fill: color-highlight.lighten(60%),
      inset: (x: 2pt, y: 2pt),
      baseline: 2pt,
      radius: 2pt,
    )[
      #body
    ]
  ]
}



// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 5: 主样式入口                                              │
// │                                                                    │
// │ 目前只接管页面尺寸、页眉页脚和基础字体。                            │
// │ 后续章节标题、列表、表格等再分批迁移。                              │
// └────────────────────────────────────────────────────────────────────┘

/// 应用全局样式
#let apply-style(doc) = {
  set page(
    paper: "a4",
    margin: (
      top: page-margin-top,
      bottom: page-margin-bottom,
      left: page-margin-left,
      right: page-margin-right,
    ),
    header-ascent: 20%,
    footer-descent: 20%,
    header: elegant-header,
    footer: elegant-footer,
  )

  // 目录逻辑参考 computer-notes：保留 heading 的 numbering 配置，
  // 便于 make-outline 通过 it.element.numbering 判定是否生成目录编号。
  set heading(numbering: (..nums) => {
    let vals = nums.pos()
    if vals.len() == 1 { none } else { str(vals.last()) }
  })

  // 正文字体先只做基础设定，后续迁移标题、列表和数学样式时再细化
  set text(
    font: (..font-latin-main, ..font-cjk-main),
    size: 11pt,
    fill: color-main-text,
    lang: "en",
  )

  // 正文首行缩进（不影响标题和显式布局块）
  set par(first-line-indent: 2em)

  // ── Chapter: 一级标题 (=) ──
  show heading.where(level: 1): it => {
    set par(first-line-indent: 0em)
    chapter-counter.step()
    section-counter.update(0)
    theorem-counter.update(0)
    corollary-counter.update(0)
    lemma-counter.update(0)
    definition-counter.update(0)
    proposition-counter.update(0)
    property-counter.update(0)
    example-counter.update(0)
    axiom-counter.update(0)
    postulate-counter.update(0)
    context {
      let ch-num = chapter-counter.get().first()
      chapter-num-state.update(ch-num)
      section-num-state.update(0)
    }
    pagebreak(weak: false)
    v(1.0em)
    
    // Chapter 编号：优雅的大号数字
    align(center, context {
      let chapter-num = chapter-counter.get().first()
      text(size: 42pt, font: font-latin-title, weight: "bold", fill: color-structure.lighten(70%))[
        #chapter-num
      ]
    })
    v(-0.5em)
    
    // 装饰线
    align(center)[
      #box(width: 12%, height: 2pt, fill: color-structure)
    ]
    v(0.4em)
    
    // Chapter 标签
    align(center, text(size: 12pt, font: font-latin-title, fill: color-muted, style: "italic")[
      Chapter
    ])
    v(0.3em)
    
    // Chapter 标题
    align(center, text(size: 24pt, font: font-latin-title, weight: "bold", fill: color-title)[#it.body])
    v(1.5em)
  }

  // ── Section: 二级标题 (==) ──
  show heading.where(level: 2): it => {
    set par(first-line-indent: 0em)
    section-counter.step()
    context {
      let ch-num = if chapter-counter.get().first() > 0 { chapter-counter.get().first() } else { 1 }
      let sec-num = section-counter.get().first()
      chapter-num-state.update(ch-num)
      section-num-state.update(sec-num)
    }
    v(1.2em)
    context {
      let chapter-num = if chapter-counter.get().first() > 0 { chapter-counter.get().first() } else { 1 }
      let section-num = section-counter.get().first()
      
      // 编号部分：紧凑的数字设计
      text(size: 20pt, font: font-latin-title, weight: "bold", fill: color-structure.lighten(60%))[
        #chapter-num.#section-num
      ]
      h(0.5em)
      
      // 标题文本
      text(size: 18pt, font: font-latin-title, weight: "bold", fill: color-title)[
        #it.body
      ]
    }
    v(0.5em)
  }

  // ── Paragraph: 三级标题 (===) ──
  // 优雅的左侧装饰设计
  show heading.where(level: 3): it => {
    set par(first-line-indent: 0em)
    v(0.8em)
    
    // 左侧装饰：渐变色块
    box(width: 4pt, height: 1.2em, fill: color-structure, radius: 1pt, baseline: 1.5pt)
    h(0.6em)
    
    // 标题文本
    text(size: 14pt, font: font-latin-title, weight: "semibold", fill: color-title)[
      #it.body
    ]
    
    v(0.4em)
  }

  doc
}
