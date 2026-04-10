// ╔════════════════════════════════════════════════════════════════════╗
// ║                                                                    ║
// ║           COMPUTER SCIENCE NOTES Typst 样式文件                     ║
// ║                        蓝色科技风主题                               ║
// ║                                                                    ║
// ║   版本: v1.0.0                                                     ║
// ║   日期: 2026-04-03                                                  ║
// ║                                                                    ║
// ╚════════════════════════════════════════════════════════════════════╝

// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 0: 外部包导入                                              │
// │                                                                     │
// │ - itemize: 增强列表样式（树形列表、checklist、圆圈连接线）          │
// │ - catppuccin: 配色方案（用于树形列表颜色）                           │
// │ - tablex: 高级表格（合并单元格、自动列宽）[已弃用]                    │
// │ - codly: 美化代码块（语言图标、行号、高亮）                          │
// └────────────────────────────────────────────────────────────────────┘

#import "@preview/itemize:0.2.0" as el
#import "@preview/catppuccin:1.0.1": get-flavor
#import "@preview/codly:1.3.0": codly, codly-init
#import calc: rem


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 1: 颜色定义                                                │
// │                                                                     │
// │ 全局配色方案，所有组件共享这些变量。修改此处可全局更换主题色。        │
// └────────────────────────────────────────────────────────────────────┘

/// 主色调 - Part 页面、Chapter 标题、Section 背景、超链接等核心元素
#let color-accent = rgb("#4870AC")

/// 标题颜色 - 封面标题等大字文本
#let color-title = rgb("#1A1A1A")

/// 正文文字颜色 - 段落默认文字色
#let color-main-text = rgb("#262626")

/// 浅色背景 - 代码块、行内代码等背景
#let color-bg-light = rgb("#F7F7F7")

/// 边框颜色 - 表格、代码块等边框
#let color-border-light = rgb("#D9D9D9")

/// 绿色强调 - 低层级标题（Paragraph、Subparagraph）
#let color-new-green = rgb("#00A087")

/// 纯白色
#let white = rgb("#FFFFFF")

// --- Callout 提示框颜色系统 ---

/// 笔记框: 蓝色调
#let color-note-bg = rgb("#E6F0FA")
#let color-note-border = rgb("#2980B9")

/// 技巧框: 绿色调
#let color-tip-bg = rgb("#F0FAEA")
#let color-tip-border = rgb("#46B846")

/// 信息框: 蓝灰色调
#let color-info-bg = rgb("#E8F4FF")
#let color-info-border = rgb("#4A7CB4")

/// 警告框: 金黄色调
#let color-warning-bg = rgb("#FFF8E1")
#let color-warning-border = rgb("#DAA520")

/// 注意框: 红粉色调
#let color-caution-bg = rgb("#FFF0F0")
#let color-caution-border = rgb("#DC143C")

/// 危险框: 深红色调
#let color-danger-bg = rgb("#FFE6E6")
#let color-danger-border = rgb("#B22222")

/// 待办框: 橙色调
#let color-todo-bg = rgb("#FFFAF0")
#let color-todo-border = rgb("#FF8C00")

/// 终端命令背景与前景色
#let color-terminal-bg = rgb("#2D2C25")
#let color-terminal-text = rgb("#CCCCCC")

/// 算法框背景与边框色
#let color-algorithm-bg = rgb("#f5f8ff")
#let color-algorithm-border = rgb("#4682B4")


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 2: 字体配置                                                │
// │                                                                     │
// │ 字体大小和字体族定义。如需更换字体，修改以下变量即可。                │
// └────────────────────────────────────────────────────────────────────┘

/// 正文基础字号
#let font-main-size = 11pt

/// 代码块字号
#let font-code-size = 10pt

/// Callout 提示框内文字字号
#let font-callout-size = 10pt

/// 中文字体 - 正文首选（霞鹜文楷）
#let font-cjk-main = "LXGW WenKai"

/// 中文字体 - 回退选项（思源宋体）
#let font-cjk-fallback = "Source Han Serif SC"

/// 幼圆字体 - 用于强调文字
#let font-yuan = "未来圆SC"

#let font-yuan2 = "极影毁片圆"

// 苹方字体 - 用于 Callout 提示框
#let font-pingfang = "PingFang SC"

/// 拉丁文字体 - 正文（Cantarell）
#let font-latin-main = "Cantarell"

/// 拉丁文字体 - 标题/封面（Merriweather 衬线体）
#let font-latin-title = "Merriweather"

/// 等宽字体 - 代码/终端/快捷键（Consolas）
#let font-mono = "Consolas"


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 3: 页面设置                                                │
// │                                                                     │
// │ 页边距参数。在 apply-style() 中通过 set page() 应用。                 │
// └────────────────────────────────────────────────────────────────────┘

/// 上边距
#let page-margin-top = 2.1cm

/// 下边距
#let page-margin-bottom = 1.2cm

/// 左边距
#let page-margin-left = 1.8cm

/// 右边距
#let page-margin-right = 1.8cm


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 4: 状态变量                                                │
// │                                                                     │
// │ 用于跨页面跟踪文档结构状态：                                          │
// │ - part-state:     当前 Part 标题名称                                 │
// │ - part-counter:   Part 计数器（生成罗马数字 I, II, III...）          │
// │ - part-location:  Part 页面位置（用于目录跳转链接）                   │
// │ - part-change:    标记是否刚进入新 Part（控制目录中 Part 标题显示）    │
// └────────────────────────────────────────────────────────────────────┘

#let part-state = state("part-state", none)
#let part-counter = counter("part-counter")
#let part-location = state("part-location", none)
#let part-first-chapter-num = state("part-first-chapter-num", 0)


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 5: 小目录函数 (Part 页面右下角)                              │
// │                                                                     │
// │ 用于 Part 页面右下角，仅显示属于当前 Part 的章节条目。                  │
// │ 必须在 part() 函数之前定义，因为 part() 会调用它。                     │
// │                                                                     │
// │ 使用方式（内部调用，无需手动使用）:                                    │
// │   make-outline-small(part-title, depth, width)                       │
// └────────────────────────────────────────────────────────────────────┘

/// 单行小目录条目渲染
/// 参数: text-size, text-weight, text-color, number, title, page, location
#let outline-small-row(
  text-size: 10pt,
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
      columns: (0.8cm, 1fr, auto),
      align: (left + top, left, left),
      gutter: 0pt,
      number,
      [
        #link(location, title)
        #box(width: 1fr, repeat(text(weight: "regular")[· #h(3pt)]))
      ],
      [
        #h(3pt)
        #link(location, page)
      ],
    )
  ]
}

/// 小目录生成器 - 筛选并渲染当前 Part 的章节
#let make-outline-small(part-title, depth, width) = [
  #show outline.entry: it => {
    let counter-int = counter(heading).at(it.element.location())
    let numbering-format = "1."
    let num = none
    if counter-int.first() > 0 {
      num = numbering(numbering-format, ..counter-int)
    }
    let title = it.element.body
    let heading-page = it.page()
    let current-part-state = part-state.at(it.element.location())
    if (current-part-state == part-title and counter-int.first() > 0) {
      if it.level == 1 {
        v(0.3cm, weak: true)
        outline-small-row(
          text-weight: "bold", text-size: 10pt, text-color: color-accent,
          number: num, title: title, page: heading-page, location: it.element.location(),
        )
      } else if it.level == 2 {
        outline-small-row(
          text-weight: "regular", text-size: 9pt, text-color: black,
          number: num, title: title, page: heading-page, location: it.element.location(),
        )
      }
    } else {
      v(-0.65em, weak: true)
    }
  }
  #box(width: width, outline(title: none, depth: depth, indent: 0em))
]


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 6: Part 页面函数                                           │
// │                                                                     │
// │ 创建独立的 Part 起始页，包含：                                       │
// │   - 全幅浅色背景填充                                                 │
// │   - 左上角罗马数字编号（I, II, III...）                              │
// │   - 右侧 Part 标题                                                  │
// │   - 右下角小目录（当前 Part 的章节列表）                               │
// │                                                                     │
// │ 使用方式:                                                            │
// │   #part("第一部分：基础概念")                                         │
// │                                                                     │
// │ 可通过 part-style 变量切换布局样式（0 或 1）。                        │
// └────────────────────────────────────────────────────────────────────┘

/// Part 页面布局风格: 0=左上罗马数字+右上标题, 1=左侧布局
#let part-style = 0

/// Part 页面罗马数字大小
#let part-num-size = 7.5em

/// Part 页面标题字体大小
#let part-font-size = 2.5em

/// 小目录显示深度（显示到第几级标题）
#let outline-small-depth = 2

/// 小目录宽度
#let outline-small-width = 9.5cm

/// 创建一个 Part 页面
#let part(title) = {
  // 保存下一个 Chapter 的编号（当前 counter + 1，因为 counter 在 heading 出现时才 step）
  context {
    let ch-num = counter(heading).get().first() + 1
    part-first-chapter-num.update(x => ch-num)
  }

  // 更新状态变量
  part-state.update(x => title)
  part-counter.step()

  // 保存当前位置（用于目录中的链接）
  context {
    let her = here()
    part-location.update(x => her)
  }

  // 渲染 Part 页面
  page(margin: 0cm, header: none)[
    #set par(justify: false)

    #if part-style == 0 [
      // 样式 A: 左上罗马数字 + 右上标题

      // 背景填充
      #place(block(
        width: 100%, height: 100%,
        outset: (x: 3cm, bottom: 2.5cm, top: 3cm),
        fill: color-accent.lighten(70%),
      ))

      // 左上角: 罗马数字编号
      #place(top + left, dx: 3cm, dy: 3cm, context text(
        fill: color-accent, size: part-num-size, weight: "bold",
        numbering("I", part-counter.at(here()).first()),
      ))

      // 右上角: Part 标题
      #place(top + right, dx: -2cm, dy: 4cm, text(fill: black, size: part-font-size, weight: "bold", box(
        width: 60%, title,
      )))

    ] else if part-style == 1 [
      // 样式 B: 左侧垂直布局

      #place(block(
        width: 100%, height: 100%,
        outset: (x: 3cm, bottom: 2.5cm, top: 3cm),
        fill: color-accent.lighten(70%),
      ))

      #place(top + left)[
        #block(context text(fill: black, size: 2.5em, weight: "bold",
          "Part " + numbering("I", part-counter.at(here()).first())))
        #v(1cm, weak: true)
        #move(dx: -4pt, block(text(fill: color-accent, size: 6em, weight: "bold", title)))
      ]
    ]

    // 右下角小目录
    #align(bottom + right, move(dx: -1cm, dy: -2cm, make-outline-small(title, 2, 9.5cm)))
  ]
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 7: 主目录样式                                               │
// │                                                                     │
// │ 文档主目录页，显示完整层级结构：                                      │
// │   - Part:     居中，带背景色方框 + 编号                               │
// │   - Chapter:  加粗，主题色，带编号                                   │
// │   - Section:  加粗黑色                                             │
// │   - Subsection: 常规黑色                                            │
// │                                                                     │
// │ 使用方式:                                                            │
// │   #make-outline(depth: 3)  // 显示前 3 级标题                        │
// └────────────────────────────────────────────────────────────────────┘

/// 单行目录条目渲染
#let outline-row(
  text-size: 11pt, text-weight: "regular", text-color: black,
  number: none, title: none, page: "0", location: none,
) = {
  set text(size: text-size, fill: text-color, weight: text-weight)
  box(width: 100%)[
    #grid(
      columns: (1.2cm, 1fr, auto),
      align: (left + top, left, left), gutter: 0pt,
      number,
      [ #link(location, title) #box(width: 1fr, repeat(text(weight: "regular")[· #h(4pt)])) ],
      [ #h(4pt) #link(location, page) ],
    )
  ]
}

/// 主目录生成器
#let make-outline(depth: 3) = {
  return [
    #show outline.entry: it => {
      let counter-int = counter(heading).at(it.element.location())
      let numbering-setting = it.element.numbering
      let num = none
      if numbering-setting != none and counter-int.first() > 0 {
        num = numbering("1.", ..counter-int)
      }
      let title = it.element.body
      let heading-page = it.page()

      if it.level == 1 {
        // Chapter 层级
        let p-state = part-state.at(it.element.location())
        let p-location = part-location.at(it.element.location())
        let p-counter = part-counter.at(it.element.location())
        let p-first-ch = part-first-chapter-num.at(it.element.location())

        // 判断是否是新 Part 的首个 Chapter：
        // 1. 当前 Part 位置存在（不是 none）
        // 2. 并且是 Part 后的第一个 Chapter（heading counter = 该 Part 的首个 chapter 编号）
        let is-new-part = (p-location != none) and (counter-int.first() == p-first-ch)

        if (is-new-part) {
          v(0.5cm, weak: true)
          box(width: 1.1cm, height: 0.7cm, fill: color-accent.lighten(80%), inset: 2pt,
            align(center, text(size: 1.3em, weight: "bold", fill: color-accent.lighten(30%),
              numbering("I", p-counter.first()))))
          h(0.1cm)
          box(width: 100% - 1.2cm, fill: color-accent.lighten(60%), inset: 5pt,
            align(center, link(p-location, text(size: 1.3em, weight: "bold", p-state))))
          v(0.3cm, weak: true)
        } else {
          v(0.3cm, weak: true)
        }
        outline-row(text-weight: "bold", text-size: 13pt, text-color: color-accent,
          number: num, title: title, page: heading-page, location: it.element.location())
      } else if it.level == 2 {
        outline-row(text-weight: "bold", text-size: 11pt, text-color: black,
          number: num, title: title, page: heading-page, location: it.element.location())
      } else if it.level == 3 {
        outline-row(text-weight: "regular", text-size: 10pt, text-color: black,
          number: num, title: title, page: heading-page, location: it.element.location())
      }
    }
    #outline(title: "目 录", depth: depth, indent: 0em)
  ]
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 8: Callout 提示框                                          │
// │                                                                     │
// │ 七种语义化提示框，带左侧彩色粗边框：                                  │
// │   note / tip / info / warning / caution / danger / todo             │
// │                                                                     │
// │ 使用方式:                                                            │
// │   #note[这是一段笔记内容]                                            │
// │   #tip[这是一个实用技巧]                                              │
// └────────────────────────────────────────────────────────────────────┘

/// Callout 通用构造器
#let callout(title, title-color, bg-color, border-color, body) = {
  return [
    #v(0.8em)
    #block(width: 100%)[

      // 主体内容块（带左边框）
      #block(
        fill: bg-color,
        stroke: (left: (thickness: 4pt, paint: border-color)),
        radius: (left: 5pt),
        inset: (left: 1.2em, top: 0.8em, bottom: 0.6em, right: 0.8em),
        width: 100%,
      )[
        #text(size: font-callout-size, font: font-pingfang, fill: black, body)
      ]
      // #v(0.3em)
      // 标题标签（使用 place 绝对定位）
      #place(top + left, dx: 0.8em, dy: -0.7em)[
        #rect(
          fill: title-color,
          stroke: none,
          radius: 3pt,
          inset: (x: 0.5em, y: 0.25em),
          text(
            font: font-latin-title,
            size: {font-callout-size - 1.2pt},
            weight: "bold",
            fill: white,
            upper(title)
          )
        )
      ]
    ]
    #v(0.1em)
  ]
}

/// 笔记框 - 用于补充说明、背景知识
#let note(body) = callout("NOTE", color-note-border, color-note-bg, color-note-border, body)

/// 技巧框 - 用于实践经验、优化建议
#let tip(body) = callout("TIP", color-tip-border, color-tip-bg, color-tip-border, body)

/// 信息框 - 用于通用说明
#let info(body) = callout("INFO", color-info-border, color-info-bg, color-info-border, body)

/// 警告框 - 用于可能出错的情况
#let warning(body) = callout("WARNING", color-warning-border, color-warning-bg, color-warning-border, body)

/// 注意框 - 用于容易忽略的细节
#let caution(body) = callout("CAUTION", color-caution-border, color-caution-bg, color-caution-border, body)

/// 危险框 - 用于高风险操作或错误示范
#let danger(body) = callout("DANGER", color-danger-border, color-danger-bg, color-danger-border, body)

/// 待办框 - 用于标记待补充内容
#let todo(body) = callout("TODO", color-todo-border, color-todo-bg, color-todo-border, body)


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 9: 代码块与终端                                            │
// │                                                                     │
// │ - codeblock: 基础代码块（已被 codly 替代，保留作为后备）              │
// │ - terminal:  终端命令样式（深色背景模拟终端窗口）                      │
// └────────────────────────────────────────────────────────────────────┘

/// 基础代码块（后备方案，优先使用 codly 美化的代码块）
#let codeblock(lang, code) = {
  return [
    #block(
      fill: color-bg-light, stroke: color-border-light,
      width: 100%, inset: (x: 5pt, y: 5pt), radius: 4pt,
    )[ #text(size: font-code-size, font: font-mono)[#code] ]
  ]
}

/// 终端命令样式 - 模拟深色终端窗口
/// 使用方式: #terminal[git status]
#let terminal(command) = {
  return [
    #block(
      fill: color-terminal-bg, stroke: rgb("#3C3C3C"),
      width: 100%, inset: (x: 8pt, y: 6pt), radius: 3pt,
    )[ #text(size: 8.5pt, font: font-mono, fill: color-terminal-text)[#command] ]
  ]
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 10: 行内组件                                                │
// │                                                                     │
// │ 行内使用的辅助组件：                                                  │
// │   file       - 文件路径样式                                          │
// │   highlight  - 高亮文字（带底色）                                     │
// │   emphasis   - 强调文字（主题色幼圆字体）                             │
// │   shortcut   - 快捷键样式（边框按钮）                                 │
// │   algorithm  - 算法伪代码块                                          │
// └────────────────────────────────────────────────────────────────────┘

/// 文件路径样式
/// 使用方式: #file[src/main/java/App.java]
#let file(path) = {
  return text(size: 9pt, font: font-mono, fill: color-accent)[#path]
}

/// 高亮文字 - 带浅色背景的强调文本
/// 使用方式: #highlight[关键术语]
#let highlight(body) = {
  return [ #box(fill: color-accent.lighten(80%), inset: (x: 2pt, y: 2pt), baseline: 2pt, radius: 2pt)[#body] ]
}

/// 强调文字 - 使用主题色的特殊字体
/// 使用方式: #emphasis[重点内容]
#let emphasis(body) = {
  return text(fill: color-accent, font: font-yuan)[#body]
}

/// 快捷键样式 - 模拟键盘按键外观
/// 使用方式: #shortcut[Ctrl + Shift + I]
#let shortcut(keys) = {
  return [
    #box(
      stroke: color-accent, fill: color-accent.lighten(90%),
      inset: (x: 6pt, y: 3pt), radius: 3pt, baseline: 1.5pt,
    )[ #text(size: 9pt, font: font-mono)[#keys] ]
  ]
}

/// 算法伪代码块 - 渐变背景 + 标题栏
/// 使用方式: #algorithm[算法步骤描述...]
#let algorithm(body) = {
  return [
    #block(
      fill: gradient.linear(color-algorithm-bg, color-algorithm-bg.lighten(70%)),
      stroke: 1.3pt + color-algorithm-border,
      inset: (left: 1em, top: 0.5em, bottom: 0.5em, right: 0.8em),
      width: 100%, breakable: true,
      radius: 7pt,
    )[
      #v(0.2em)
      #text(font: font-latin-title, weight: "bold", fill: color-algorithm-border)[Algorithm]
      #v(-0.3em)
      #body
    ]
  ]
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 11: 主样式应用函数                                          │
// │                                                                     │
// │ 文档入口函数，集中管理所有全局样式设置：                                │
// │   - 页面配置（纸张、边距、页眉页脚）                                  │
// │   - 正文字体与语言                                                   │
// │   - 各级标题样式（Chapter → Subparagraph 共 6 级）                    │
// │   - 列表样式（有序、无序、checklist、树形）                            │
// │   - 超链接、脚注、行内代码、代码块美化                                │
// │                                                                     │
// │ 使用方式:                                                            │
// │   #show: apply-style                                                 │
// └────────────────────────────────────────────────────────────────────┘

// 圆圈连接线有序列表样式定义
#let circle-line-enum = el.default-enum-list.with(
  size: (1.5em, auto),
  fill: (red, auto),
  body-indent: .5em,
  label-align: (center + horizon, auto),
  label-format: (circle.with(stroke: 1pt + blue, fill: white, width: 1.5em), auto),
  body-format: (
    inner: (
      stroke: ((left: 2pt + blue), auto),
      outset: (((left: 1.5em + 1pt, top: 0em), (left: 1.5em + 1pt, top: 1.3em)), auto),
    ),
  ),
)

/// 应用全部全局样式
#let apply-style(doc) = {

  // ── 页面设置 ──
  set page(
    paper: "a4",
    margin: (
      top: page-margin-top, bottom: page-margin-bottom,
      left: page-margin-left, right: page-margin-right,
    ),
    header-ascent: -5%, footer-descent: 20%,
  )

  // 页眉: 左Chapter右页码，底部有横线
  set page(
    header: context {
      // 获取当前页的第一个和最后一个 heading
      let all-chapters = query(heading.where(level: 1))
      let current-page = here().page()
      
      // 检查当前页是否有 chapter 开始
      let has-chapter-start = false
      for ch in all-chapters {
        if ch.location().page() == current-page {
          has-chapter-start = true
          break
        }
      }
      
      // 如果是 chapter 第一页，不显示页眉
      if has-chapter-start {
        return none
      }
      
      // 否则显示页眉
      let elems = query(heading.where(level: 1).before(here()))
      if elems.len() > 0 {
        let chapter-text = elems.last().body
        grid(
          columns: (1fr, auto),
          column-gutter: 0pt,
          align: (left, right),
          text(size: 10pt, font: font-latin-main, fill: color-accent)[#chapter-text],
          text(size: 10pt, font: font-latin-main, fill: color-accent)[#counter(page).display()],
        )
        v(-4pt) // 页眉文字与横线的间距
        line(length: 100%, stroke: gradient.linear(color-accent, color-accent.lighten(50%), color-accent))
        v(-3pt) // 页眉下移
        align(center, box(inset: (left: 8pt, right: 8pt))[
          #text(size: 8pt, fill: color-accent)[· · ·]
        ])
      }
    },
    // 页脚: 统一居中页码
    footer: context {
      align(center)[
        #text(size: 10pt, font: font-latin-main, fill: color-accent)[#counter(page).display()]
      ]
    },
  )

  // ── 正文字体与语言 ──
  set text(font: (font-latin-main, font-cjk-main), size: font-main-size, fill: color-main-text, lang: "zh")

  // ── 重写加粗样式（*xxx*）- 使用超粗字重 + 幼圆字体 ──
  show strong: it => text(weight: 100, font: font-yuan2, fill: color-main-text)[#it]

  // ── 标题编号规则: level 1 不编号, level 2+ 只显示本级编号 ──
  set heading(numbering: (..nums) => {
    let vals = nums.pos()
    if vals.len() == 1 { return none }
    else { str(vals.last()) }
  })

  // ── Level 1: Chapter (#=) ──
  // 三行布局: "Chapter N" / 标题 / 居中横线
  show heading.where(level: 1): it => {
    set text(size: 10pt)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(math.equation).update(0)

    pagebreak(weak: false)
    v(1.5em)
    align(center, context {
      let ch-num = counter(heading).get().first()
      text(24pt, font: font-cjk-fallback, weight: "bold", fill: color-accent)[Chapter #ch-num]
    })
    v(0.3em)
    align(center, text(24pt, font: font-latin-title, weight: "bold", fill: color-accent)[#it.body])
    v(2.9em)
    align(center, line(length: 80%, stroke: (thickness: 0.8pt, paint: color-accent)))
    v(0.5em)
  }

  // ── Level 2: Section (#==) ──
  // 主题色背景胶囊形状，白字加粗
  show heading.where(level: 2): it => {
    v(1em)
    context {
      let sec-num = counter(heading).get().last()
      box(fill: color-accent, inset: (x: 12pt, y: 6pt), radius: 3pt)[
        #text(18pt, font: font-cjk-fallback, weight: "bold", fill: white)[#sec-num #h(0.5em)#it.body]
      ]
    }
  }

  // ── Level 3: Subsection (#===) ──
  // 编号格式: "M.N 标题"
  show heading.where(level: 3): it => {
    v(0.2em)
    context {
      let nums = counter(heading).get()
      let sec-num = nums.at(1)
      let subsec-num = nums.at(2)
      text(16pt, font: font-cjk-fallback, weight: "bold", fill: color-accent)[#sec-num.#subsec-num #h(0.3em)#it.body]
    }
    v(0.2em)
  }

  // ── Level 4: Sub-subsection (#====) ──
  // 左侧蓝色竖线装饰
  show heading.where(level: 4): it => {
    v(0.3em)
    grid(columns: (auto, 1fr), align: (center + horizon, left + horizon), gutter: 8pt,
      box(width: 3pt, height: 1.1em, fill: color-info-border, radius: 1.5pt),
      text(13pt, font: font-cjk-fallback, weight: "bold", fill: color-accent)[#it.body],
    )
    v(0.3em)
  }

  // ── Level 5: Paragraph (#=====) ──
  // 绿色加粗文字
  show heading.where(level: 5): it => {
    v(0.6em)
    text(12pt, font: font-cjk-fallback, weight: "bold", fill: color-new-green)[#it.body]
    v(0.2em)
  }

  // ── Level 6: Subparagraph (#======) ──
  // 绿色常规文字
  show heading.where(level: 6): it => {
    v(0.5em)
    text(11pt, font: font-cjk-fallback, fill: color-new-green)[#it.body]
    v(0.2em)
  }

  // ── 列表样式 ──
  // 无序列表标记 + 列表后间距
  show list: it => {
    set list(marker: ([•], [◦], [▪]))
    el.default-list.with(
      list-spacing: 0.5em, 
      item-spacing: 0.3em,
      label-baseline: auto,
      )(it)
    v(0.3em)
  }

  // 有序列表增强（itemize 包）+ 列表后间距
  show enum: it => {
    el.default-enum-list.with(
      enum-margin: array, item-spacing: 0.5em, enum-spacing: 0.5em, label-align: auto,
    )(it)
    v(0.3em)
  }

  // Checklist 复选列表（itemize 包）
  show: el.config.checklist.with(
    baseline: auto, enable-format: true, extras: true,
    format-map: ("!": text.with(fill: blue, weight: "bold")),
  )

  // 超链接样式
  show link: it => text(fill: color-accent)[#it]

  // ── 行内代码样式 (`反引号`) ──
  // 使用字体数组：英文等宽 + 中文回退
  show raw: it => box(
    fill: color-bg-light, stroke: 0.5pt + color-border-light, radius: 3pt,
    inset: (x: 6pt, y: 2pt),
    text(size: 1.2em, font: (font-mono, font-cjk-main), fill: color-accent.darken(20%))[#it], baseline: 1.5pt,
  )

  // ── Codly 代码块美化 ──
  show: codly-init.with()
  codly(
    stroke: 1.2pt + color-border-light.darken(20%),
    radius: 4pt,
    languages: (
      java: (name: "Java", icon: "☕", color: rgb("#F89820")),
      python: (name: "Python", icon: "🐍", color: rgb("#3776AB")),
      rust: (name: "Rust", icon: "🦀", color: rgb("#CE412B")),
      javascript: (name: "JavaScript", icon: "⚡", color: rgb("#F7DF1E")),
      typescript: (name: "TypeScript", icon: "📘", color: rgb("#3178C6")),
      go: (name: "Go", icon: "🔵", color: rgb("#00ADD8")),
      bash: (name: "Bash", icon: "💻", color: rgb("#4EAA25")),
      sql: (name: "SQL", icon: "🗄️", color: rgb("#336791")),
      json: (name: "JSON", icon: "{}", color: rgb("#000000")),
      typ: (name: "Typst", icon: "📝", color: rgb("#239DAD")),
      c: (name: "C", icon: "⚙️", color: rgb("#A8B9CC")),
      cpp: (name: "C++", icon: "🔧", color: rgb("#00599C")),
      csharp: (name: "C#", icon: "🟣", color: rgb("#68217A")),
      ruby: (name: "Ruby", icon: "💎", color: rgb("#CC342D")),
      php: (name: "PHP", icon: "🐘", color: rgb("#777BB4")),
      kotlin: (name: "Kotlin", icon: "🟣", color: rgb("#7F52FF")),
      swift: (name: "Swift", icon: "🍎", color: rgb("#FA7343")),
      dart: (name: "Dart", icon: "🎯", color: rgb("#0175C2")),
      scala: (name: "Scala", icon: "🔴", color: rgb("#DC322F")),
      haskell: (name: "Haskell", icon: "λ", color: rgb("#5E5086")),
      lua: (name: "Lua", icon: "🌙", color: rgb("#000080")),
      r: (name: "R", icon: "📊", color: rgb("#276DC3")),
      matlab: (name: "MATLAB", icon: "🔶", color: rgb("#0076A8")),
      html: (name: "HTML", icon: "🌐", color: rgb("#E34F26")),
      css: (name: "CSS", icon: "🎨", color: rgb("#1572B6")),
      yaml: (name: "YAML", icon: "⚙️", color: rgb("#CB171E")),
      toml: (name: "TOML", icon: "📋", color: rgb("#9C4121")),
      dockerfile: (name: "Docker", icon: "🐳", color: rgb("#2496ED")),
    ),
  )

  // ── 脚注样式 ──
  set footnote.entry(separator: line(length: 28%, stroke: (thickness: 0.5pt, paint: color-border-light)))

  doc
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 13: 封面生成函数                                            │
// │                                                                     │
// │ 生成文档封面页：居中布局，包含标题、副标题分隔线、作者、日期。         │
// │                                                                     │
// │ 使用方式:                                                            │
// │   #make-cover("文档标题", "作者名")                                   │
// │   #make-cover("文档标题", "作者名", date: datetime.today().display())  │
// └────────────────────────────────────────────────────────────────────┘

#let make-cover(title, author, date: none) = {
  return [
    #pagebreak(weak: true)
    #v(1fr)
    #align(center)[
      #text(32pt, font: font-latin-title, weight: "bold", fill: color-title)[#title]
      #v(20pt)
      #line(length: 40%, stroke: (thickness: 1.5pt, paint: color-accent))
      #v(40pt)
      #text(14pt, font: font-latin-main, fill: color-main-text)[#author]
      #v(10pt)
      #text(12pt, font: font-latin-main, fill: color-border-light)[#date]
    ]
    #v(1fr)
    #pagebreak()
  ]
}


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 14: 特殊列表样式                                            │
// │                                                                     │
// │ 基于 itemize 包的高级列表样式：                                      │
// │   tree-list          - 带连接线的树形列表（数学公式风格标记）          │
// │   circle-line-enum   - 圆圈 + 连接线的有序列表                       │
// └────────────────────────────────────────────────────────────────────┘

// 树形列表: Catppuccin Latte 配色 + 数学符号标记
#let flavor = get-flavor("latte")
#let palette = flavor.colors
#let timeso = if sys.version >= version(0, 14, 0) { [$times.o$] } else [$times.circle$]
#let asto = if sys.version >= version(0, 14, 0) { [$ast.o$] } else [$ast.circle$]

/// 树形列表标记符号（数学符号: ÷, ×, ∗, ★）
#let tree-marker = ([$times.div$], timeso, asto, [$star.filled$])

/// 树形列表颜色梯度
#let tree-colors = (color-accent, color-accent.lighten(20%), color-accent.lighten(40%), color-new-green)

/// 树形列表样式定义 - 彩色标记 + 连接线
#let tree-list = el.default-list.with(
  indent: ((0pt,),),
  fill: tree-colors,
  item-spacing: .7em,
  enum-spacing: (auto, .7em),
  label-align: (center + horizon),
  label-baseline: .3em,
  body-indent: 0pt,
  label-format: it => {
    let marker-content = box(height: 1.2em, fill: white)[
      #set text(baseline: -.05em)
      #it.body #box(baseline: -.35em)[#line(length: 1em)]~
    ]
    if it.level == 1 { none } else { marker-content }
  },
  body-format: (
    style: (fill: tree-colors),
    outer: (
      stroke: it => {
        if it.level == 1 { auto }
        else if (it.n == it.n-last and it.n-last >= 2) { auto }
        else { (left: 1pt) }
      },
      outset: it => {
        if it.level == 1 { auto }
        else if it.n-last == 1 { (left: -.5em + 1pt, top: .8em - 1pt, bottom: -100%) }
        else if it.n == it.n-last - 1 { (left: -.5em + 1pt, top: .8em - 1pt, bottom: .7em) }
        else { (left: -.5em + 1pt, top: .8em - 1pt) }
      },
    ),
  ),
)

/// 圆圈 + 连接线有序列表样式
#let circle-line-enum = el.default-enum-list.with(
  size: (1.5em, auto), fill: (red, auto), body-indent: .5em,
  label-align: (center + horizon, auto),
  label-baseline: auto,
  label-format: (circle.with(stroke: 1pt + blue, fill: white, width: 1.3em), auto),
  body-format: (
    inner: (
      stroke: ((left: 2pt + blue), auto),
      outset: (((left: 1.5em + 1pt, top: 0em), (left: 1.5em + 1pt, top: 1.3em)), auto),
    ),
  ),
)


// ┌────────────────────────────────────────────────────────────────────┐
// │ SECTION 15: 表格工具函数                                            │
// │                                                                     │
// │ 快速创建美观表格的工具函数：                                          │
// │   tex-table         - 主题风格表格（无竖线）                         │
// │   plain-table       - 普通网格表格（有横线和竖线）                    │
// │   default-table-style - 默认表格样式配置                              │
// │   fancy-divider      - 渐变装饰分隔线                                 │
// └────────────────────────────────────────────────────────────────────┘

/// 统一单元格内容的基线对齐（解决中英文混排偏移问题）
#let cell-content(c) = {
  text(top-edge: "cap-height", bottom-edge: "baseline")[#c]
}

/// 主题风格表格（无竖线，仅横线分隔）
///
/// 使用方式:
///   #tex-table(
///     ("姓名", "年龄", "城市"),   // 表头行（必须）
///     ("张三", "28", "北京"),      // 数据行1
///     ("李四", "34", "上海"),      // 数据行2
///   )
///
/// 特性: 自动表头加粗, 整个表格居中, 单元格内容居中对齐
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
///
/// 使用方式:
///   #plain-table(
///     ("姓名", "年龄", "城市"),   // 表头行（必须）
///     ("张三", "28", "北京"),      // 数据行1
///     ("李四", "34", "上海"),      // 数据行2
///   )
///
/// 特性: 自动表头加粗, 整个表格居中, 单元格内容居中对齐, 有完整网格线
#let plain-table(..args) = {
  let arr = args.pos()
  if arr.len() == 0 { return [] }

  let header = arr.at(0)
  let data-rows = arr.slice(1)
  let col-count = header.len()

  // 表头单元格（加粗 + 居中基线对齐）
  let header-cells = header.map(c => cell-content(text(font: font-yuan, weight: "bold")[#c]))

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

/// 精美渐变分隔线 - 带三个圆点装饰
///
/// 使用方式: #fancy-divider
#let fancy-divider = {
  align(center)[
    #v(1em)
    #box(width: 60%, height: 4pt)[
      // 渐变线条
      #place(box(width: 100%, height: 1.5pt, fill: gradient.linear(
        (color-border-light.lighten(50%), 0%),
        (color-accent, 30%), (color-accent, 70%),
        (color-border-light.lighten(50%), 100%))))
      // 三个圆点装饰（中间最大）
      #place(center, dx: -20%, dy: -0.5pt, circle(radius: 2pt, fill: color-accent.lighten(30%)))
      #place(center, dx: 0%, dy: -1pt, circle(radius: 2.5pt, fill: color-accent))
      #place(center, dx: 20%, dy: -0.5pt, circle(radius: 2pt, fill: color-accent.lighten(30%)))
    ]
    #v(1em)
  ]
}
