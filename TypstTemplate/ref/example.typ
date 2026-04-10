// ╔════════════════════════════════════════════════════════════════════╗
// ║                                                                    ║
// ║             COMPUTER SCIENCE NOTES Typst 示例文档                   ║
// ║                      完整功能演示                                  ║
// ║                                                                    ║
// ║   编译: typst compile example.typ                                  ║
// ║   预览: typst watch example.typ                                    ║
// ║                                                                    ║
// ╚════════════════════════════════════════════════════════════════════╝

// 导入样式文件（使用 * 导入所有导出的函数和变量）
#import "computer-notes.typ": *


// ─────────────────────────────────────────────────────────────────────
// 文档元信息
// ─────────────────────────────────────────────────────────────────────
#set document(
  title: "计算机科学笔记示例",
  author: "Violet",
  date: datetime.today(),
)

// 应用全局样式（必须放在封面和目录之前）
#show: apply-style


// ══════════════════════════════════════════════════════════════════════
// 封面
// ══════════════════════════════════════════════════════════════════════

#make-cover(
  "计算机科学笔记示例",
  "Violet",
  date: datetime.today().display(),
)

// 目录（显示到三级标题）
#make-outline(depth: 3)


// ══════════════════════════════════════════════════════════════════════
// 第一部分：模板基础与排版
// ══════════════════════════════════════════════════════════════════════

#part("第一部分：模板基础与排版")


// ── Chapter 1: 模板概述 ──
= 模板概述

== 设计目标

本模板旨在为计算机科学课程笔记提供一套统一、美观、易用的排版方案。模板集成了常见的排版需求，包括多级标题、代码高亮、提示框、表格和数学公式等，让笔记作者能够专注于内容创作，而非格式调整。

#note[
  本模板基于 Typst 构建，相较于 LaTeX，Typst 具有编译速度快、语法简洁、学习曲线平缓等优势。
]

模板的核心设计原则：

- #emphasis[一致性]：所有组件共享统一的配色方案和字体设置
- #emphasis[可复用性]：组件化设计便于在不同文档中重复使用
- #emphasis[语义化]：通过颜色和样式区分不同类型的内容


== 组件来源说明

本模板的组件基于以下来源构建：

#tex-table(
  ("组件类型", "来源", "封装方式"),
  ("表格", "`table`", "`tex-table` / `plain-table` 封装"),
  ("无序列表", "`list`", "重写 marker 样式"),
  ("有序列表", "`enum`", "重写 marker 样式"),
  ("树形列表", "`itemize` 包", "`tree-list` 样式配置"),
  ("Checklist", "`itemize` 包", "`config.checklist` 封装"),
  ("代码块", "`codly` 包", "`codly-init` 全局配置"),
  ("行内代码", "`raw`", "重写 show 规则"),
  ("页眉页脚", "`page`", "context 动态内容"),
)


== Typst 原生功能演示

Typst 内置了许多强大的排版功能，本模板已集成以下原生特性：

=== 脚注 (footnote)

脚注用于添加补充说明或引用来源。模板已定义脚注样式（细线分隔符）。

使用方式：`^[脚注内容]` 语法

这是一个包含脚注的句子^[这是一个使用 Typst 原生语法添加的脚注示例。]，脚注会出现在页面底部。

=== 交叉引用 (label + ref) <sec-cross-ref>

Typst 支持强大的交叉引用功能，可以引用标题、图表、公式等元素。

标签使用 `<name>` 语法直接添加在标题后面，如本节标题 `<sec-cross-ref>`。

引用使用 `@name` 语法：可以引用本节 @sec-cross-ref。

#tip[
  标签命名建议：`heading-*` 用于标题，`fig-*` 用于图片，`table-*` 用于表格，`eq-*` 用于公式。
]

=== 超链接 (link)

使用 `#link` 创建可点击的超链接：

- 外部链接：#link("https://typst.app")[Typst 官网]
- 邮箱链接：#link("mailto:example@example.com")[发送邮件]

=== 图片 (image)

Typst 原生支持图片插入，使用 `#figure` 函数：

#figure(
  image("./circle.png", width: 60%),
  caption: [示例图片（来源：Picsum）],
) <fig-example>

可以使用 `@fig-example` 引用该图片：如图 @fig-example 所示。

#note[
  `#image` 是 Typst 原生函数，参数依次为：路径/URL、宽度、高度（可选）、caption（可选）。图片会自动编号并加入目录。
]

=== 布局容器

Typst 提供多种布局容器：

- *`box`*：创建带样式的文本容器
- *`grid`*：网格布局（模板中用于表格）
- *`stack`*：堆叠布局
- *`move`*：偏移定位

#tip[
  这些容器是 Typst 原生组件，本模板中的许多复杂效果（如提示框、标题样式）都是通过组合这些容器实现的。
]


// ── Chapter 2: 标题层级 ──
= 标题层级

本模板提供了七级标题体系，每一级都有独特的视觉样式：

== 二级标题（Section）

二级标题用于划分文档的主要章节，样式为主题色背景的胶囊形状。

=== 三级标题（Subsection）

三级标题用于组织章节内的主要内容，样式为蓝色编号前缀。

==== 四级标题（Sub-subsection）

四级标题用于细分小节，左侧带有蓝色竖线装饰。

===== 五级标题（Paragraph）

五级标题用于标记独立的知识点，绿色加粗样式便于识别重点。

====== 六级标题（Subparagraph）

六级标题用于进一步细化内容，绿色常规样式。

#tip[
  建议实际使用时，最多使用到四级标题。过深的层级结构会增加阅读负担。
]


// ── Chapter 3: 文本样式 ──
= 文本样式

=== 行内强调

模板提供了多种行内强调方式：

- *普通强调*：使用粗体，适合一般强调
- #emphasis[强调文字]：使用主题色和圆体字体，适合突出重点
- #highlight[高亮文字]：带浅色背景，适合标记关键术语
- #file[src/main/App.java]：文件路径专用样式
- #shortcut[Ctrl + C]：模拟键盘按键

#warning[
  行内强调应适度使用，过多的强调会削弱其效果。建议每个段落不超过 2-3 处强调。
]

=== 数学公式

模板支持完整的数学公式排版：

集合框架的时间复杂度分析中，哈希表的查找复杂度接近 $O(1)$，而红黑树则为 $O(log n)$。

#set math.equation(numbering: "(1)")
$
  T(n) = T(n/2) + O(1) quad => quad T(n) = O(log n) <"eq-recurrence">
$

负载因子的定义：
$
  alpha = (n)/(m) = ("元素数量") / ("桶数量") <"eq-load-factor">
$

可以使用 `@"eq-recurrence"` 和 `@"eq-load-factor"` 引用公式：见公式 @"eq-recurrence" 和 @"eq-load-factor"

#fancy-divider


// ══════════════════════════════════════════════════════════════════════
// 第二部分：列表与表格
// ══════════════════════════════════════════════════════════════════════

#part("第二部分：列表与表格")


// ── Chapter 4: 列表样式 ──
= 列表样式

== 无序列表

一级无序列表用于罗列并列的要点：

- 数据结构是计算机科学的基础
- 算法设计需要考虑时间复杂度和空间复杂度
- 代码实现应当注重可读性和可维护性

二级列表适合展开说明：

- 函数式编程范式
  - 纯函数：不依赖外部状态
  - 不可变性：避免副作用
- 面向对象编程范式
  - 封装：隐藏实现细节
  - 继承：复用代码结构
  - 多态：统一接口多种实现

#note[
  原生无序列表使用 `-` 标记，通过 `set list(marker: ...)` 重写标记样式。本模板定义了 `• ◦ ▪` 三级标记。
]

== 有序列表

有序列表适合表达步骤或流程：

+ 分析问题需求
+ 设计数据结构和算法
+ 编写代码实现
+ 编写单元测试
+ 优化性能

#note[
  有序列表使用 `+` 标记（Typst 会自动编号）。本模板通过 `show: el.default-enum-list` 增强了样式。
]

== Checklist 复选列表

Checklist 适合标记待办事项：

- [x] 完成模板基础功能
- [x] 实现代码高亮
- [ ] 添加更多代码语言支持
- [ ] 优化提示框样式
- [/] 完善示例文档
- [-] 移除废弃功能
- [\>] 向右箭头，表示下一步或前进
- [\<] 日历图标，表示日期或时间相关
- [\?] 问号，表示不确定或需要进一步调查
- [\!] 感叹号，表示重要或需要注意
- [\*] 星号，表示重点或收藏
- ["] 引号，表示引用或强调
- [l] 定位图标，表示位置相关
- [b] 书签图标，表示参考资料或链接
- [i] 信息图标，表示提示或说明
- [S] 钱袋图标，表示成本或预算
- [I] 灯泡图标，表示创意或建议
- [p] 赞图标，表示优点、认可或推荐
- [c] 踩图标，表示缺点、反对或不推荐
- [f] 火焰图标，表示热门或高优先级
- [k] 钥匙图标，表示关键点或解决方案
- [w] 奖杯图标，表示成就或完成
- [u] 向上箭头，表示提升或改进
- [d] 向下箭头，表示降低或放弃

#note[
  Checklist 基于 `itemize` 包的 `config.checklist` 实现。通过 `show: el.config.checklist` 全局启用。
]

== 树形列表

树形列表适合展示层次结构：

#v(0.3em)
#[
  #set list(marker: tree-marker)
  #show: tree-list
  - 算法分类
    - 排序算法
      - 比较排序
        - 快速排序
        - 归并排序
        - 堆排序
      - 非比较排序
        - 计数排序
        - 基数排序
    - 搜索算法
      - 二分查找
      - 哈希查找
    - 图算法
      - BFS
      - DFS
      - Dijkstra
]
#v(0.3em)

#note[
  树形列表基于 `itemize` 包，定义在 `computer-notes.typ` 的 `tree-list` 变量中。树形标记使用数学符号（÷ × ∗ ★）。
]

== 圆圈连接线列表

#circle-line-enum[
  + 分析问题规模，确定算法复杂度要求
    - 数据量大小
    - 实时性要求
  + 选择合适的数据结构
  + 设计算法逻辑
    + 编写伪代码
    + 验证边界条件
  + 实现并测试
]

#note[
  圆圈连接线列表基于 `itemize` 包的 `el.default-enum-list`，配置在 `circle-line-enum` 变量中。使用 `#circle-line-enum[...]` 调用。
]


// ── Chapter 5: 表格 ──
= 表格

== 快速表格

使用 `#plain-table` 创建普通网格表格（基于原生 `table`，有完整网格线）：

#plain-table(
  ("列1", "列2", "列3"),
  ("数据1", "数据2", "数据3"),
  ("数据4", "数据5", "数据6"),
  ("Data7", "Data8", "Data9"),
  ("Data10", "数据11", "Data12"),
)

使用 `#tex-table` 快速创建 tex 风格的表格（基于原生 `table`，仅水平线）：

#tex-table(
  ("语言", "特点", "典型应用"),
  ("Python", "简洁易学", "数据分析、AI"),
  ("Java", "跨平台、企业级", "后端开发"),
  ("JavaScript", "前端必备", "Web开发"),
  ("Rust", "安全高性能", "系统编程"),
)

== 复杂表格

复杂功能（如单元格合并）需要直接调用原生 `#table` 函数：

#align(center)[
  #table(
    columns: 4,
    align: center + horizon,
    stroke: color-border-light,
    fill: (col, row) => {
      if row < 2 { color-accent.lighten(85%) }
      else { white }
    },
    /* --- header --- */
    table.cell(rowspan: 2)[*姓名*], table.cell(colspan: 2)[*成绩*], table.cell(rowspan: 2)[*总分*],
    /* -------------- */
    /* --- sub-header --- */
    [*平时*], [*期末*],
    /* ----------------- */
    [张三], [85], [92], [177],
    [李四], [78], [88], [166],
    [王五], [90], [95], [185],
    [赵六], [82], [79], [161],
  )
]

#note[
  原生 `table` 函数支持：
  - `table.cell(colspan: n)` / `table.cell(rowspan: n)`：单元格合并
  - `fill` 参数：自定义单元格填充色（函数形式）
  - `align` 参数：单元格对齐方式
  - `stroke` 参数：边框样式
]

#tip[
  表格列宽可以使用 `1fr`、`auto` 或固定值（如 `3cm`）进行设置。
]


// ══════════════════════════════════════════════════════════════════════
// 第三部分：提示框与代码
// ══════════════════════════════════════════════════════════════════════

#part("第三部分：提示框与代码")


// ── Chapter 6: 提示框 ──
= 提示框

== 提示框系统

模板内置了七种提示框，适用于不同的语义场景：

#note[
  笔记框用于补充说明、背景知识或记忆要点。本模板使用霞鹜文楷作为主要中文字体。添加更多文字以测试多行内容的显示效果和自动换行功能。
]

#tip[
  技巧框用于分享实践经验、优化建议或操作捷径。例如，使用 #shortcut[Alt + Tab] 快速切换窗口。
]

#info[
  信息框用于通用说明或背景知识。测试长内容时的自动换行效果。
]

#warning[
  警告框用于提醒可能出错或需要谨慎处理的情况。例如，删除操作不可恢复。
]

#caution[
  注意框用于强调容易忽略但影响较大的细节。如版本兼容性、数据迁移风险等。
]

#danger[
  危险框用于标记高风险操作或明确禁止的行为。执行前请务必确认后果。
]

#todo[
  待办框用于标记后续需要补充或完善的内容。可配合 Checklist 使用。
]

== 提示框实现原理

提示框基于以下组件组合实现：

#tex-table(
  ("组件", "用途"),
  ("`block`", "创建带背景色和边框的容器"),
  ("`place`", "绝对定位标题标签"),
  ("`rect`", "标题背景框"),
  ("`text`", "标题和内容文字"),
)

#note[
  `callout` 是提示框的通用构造器函数，定义在 `computer-notes.typ` 中。各个提示框（`note`、`tip` 等）都是对它的调用。
]

== 提示框使用建议

#tip[
  - 每种提示框的语义应当保持一致，不要混用
  - 避免在单个页面中使用过多提示框
  - 提示框内容应简洁明了，一针见血
]


// ── Chapter 7: 代码块 ──
= 代码块

== 行内代码

行内代码像 Markdown 一样是使用成对的反引号（\`）包裹，已重写样式：
这是一个行内代码示例：`"int x = 10;" // 这是注释`，适合标记代码片段或命令。

== 基础代码块

模板使用 Codly 包实现代码语法高亮，支持 30+ 编程语言：

=== Java 示例

```java
import java.util.*;

public class QuickSort {
    public static void sort(int[] arr, int low, int high) {
        if (low < high) {
            int pi = partition(arr, low, high);
            sort(arr, low, pi - 1);
            sort(arr, pi + 1, high);
        }
    }
    
    private static int partition(int[] arr, int low, int high) {
        int pivot = arr[high];
        int i = low - 1;
        for (int j = low; j < high; j++) {
            if (arr[j] < pivot) {
                i++;
                swap(arr, i, j);
            }
        }
        swap(arr, i + 1, high);
        return i + 1;
    }
}
```

=== Python 示例

```python
def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quicksort(left) + middle + quicksort(right)
```

=== JavaScript 示例

```javascript
const quicksort = (arr) => {
  if (arr.length <= 1) return arr;
  const pivot = arr[Math.floor(arr.length / 2)];
  const left = arr.filter(x => x < pivot);
  const middle = arr.filter(x => x === pivot);
  const right = arr.filter(x => x > pivot);
  return [...quicksort(left), ...middle, ...quicksort(right)];
};
```

=== Rust 示例

```rust
fn quicksort<T: Ord + Clone>(arr: &[T]) -> Vec<T> {
    if arr.len() <= 1 {
        return arr.to_vec();
    }
    let pivot = arr[arr.len() / 2].clone();
    let left: Vec<T> = arr.iter().filter(|x| **x < pivot).cloned().collect();
    let middle: Vec<T> = arr.iter().filter(|x| **x == pivot).cloned().collect();
    let right: Vec<T> = arr.iter().filter(|x| **x > pivot).cloned().collect();
    
    let mut result = quicksort(&left);
    result.extend(middle);
    result.extend(quicksort(&right));
    result
}
```

== 配置与标记语言

=== JSON 配置

```json
{
  "name": "computer-notes",
  "version": "1.0.0",
  "author": "Violet",
  "features": {
    "syntax-highlight": true,
    "auto-toc": true,
    "multiple-themes": false
  }
}
```

=== YAML 配置

```yaml
database:
  host: localhost
  port: 5432
  name: myapp
  
logging:
  level: info
  format: json
```

=== Dockerfile

```dockerfile
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

== 终端命令

终端样式适合展示命令行操作：

#terminal[git status]

#terminal[git commit -m "feat: add quicksort implementation"]

#terminal[docker compose up -d --build]

#note[
  终端样式是一个自定义组件（`terminal` 函数），基于 `block` 和 `text` 构建，模拟深色终端窗口外观。
]


// ── Chapter 8: 算法与流程 ──
= 算法与流程

== 算法伪代码

#algorithm[
  快速排序算法：
  - 输入：数组 arr，左边界 low，右边界 high
  - 如果 low < high：
    - 选取基准元素 pivot = arr[high]
    - 划分：小于 pivot 的放左边，大于的放右边
    - 递归排序左右两部分
  - 输出：已排序的数组
]

#note[
  `algorithm` 函数基于 `block` 组件，添加渐变背景和标题栏样式。
]

== 综合示例

下面用一个小主题串起多个组件：

=== 选择排序的原则

在选择集合类型时，需要综合考虑以下因素：

#tex-table(
  ("场景", "推荐数据结构", "原因"),
  ("快速查找", "HashMap", "O(1) 时间复杂度"),
  ("有序遍历", "TreeMap", "自动维护顺序"),
  ("频繁插入删除", "LinkedList", "O(1) 操作"),
  ("去重计数", "HashSet", "自动去重"),
)

#warning[
  不要过早优化。在没有性能问题的情况下，应该优先选择实现简单、易于维护的数据结构。
]

具体选择时：

- 如果强调随机访问，优先考虑 *ArrayList* 或 *HashMap*
- 如果强调元素顺序，优先考虑 *TreeMap* 或 *LinkedList*
- 如果强调并发安全，优先考虑 *ConcurrentHashMap*

#emphasis[核心原则：根据实际需求选择最合适的数据结构，而非追求"最优"解决方案。]


// ══════════════════════════════════════════════════════════════════════
// 附录
// ══════════════════════════════════════════════════════════════════════

#part("附录")

// ── 附录 A: 模板速查 ──
= 模板速查

== 组件来源速查表

#plain-table(
  ("功能", "底层来源", "模板封装"),
  ("标题 1-6 级", "`heading`", "`show heading.where(level: n)`"),
  ("列表", "`list` / `enum`", "`set list(marker: ...)`"),
  ("树形列表", "`itemize` 包", "`show: tree-list`"),
  ("Checklist", "`itemize` 包", "`show: el.config.checklist`"),
  ("表格", "`table`", "`tex-table` / `plain-table`"),
  ("代码块", "`codly` 包", "`codly-init` / `codly`"),
  ("行内代码", "`raw`", "`show raw`"),
  ("提示框", "`block` + `place`", "`note` / `tip` 等函数"),
  ("页眉页脚", "`page`", "`set page(header/footer: ...)`"),
  ("数学公式", "`$` / `math`", "原生支持"),
  ("脚注", "`footnote`", "原生支持 + 样式定制"),
  ("交叉引用", "`label` + `ref`", "原生支持"),
  ("链接", "`link`", "原生支持 + 样式定制"),
)

== 可用命令速查

#tex-table(
  ("命令", "用途", "示例"),
  (`#file("path")`, "文件路径", `#file("src/main/App.java")`),
  (`#highlight("text")`, "高亮文字", `#highlight("重点")`),
  (`#emphasis("text")`, "强调文字", `#emphasis("关键点")`),
  (`#shortcut("keys")`, "快捷键", `#shortcut("Ctrl + S")`),
  (`#terminal("cmd")`, "终端命令", `#terminal("npm install")`),
  (`#algorithm[内容]`, "算法伪代码", `#algorithm[...]`),
)
  (`#fancy-divider`, "装饰分隔线", `#fancy-divider`),
)

== 提示框类型

- #note[#text(size: 9pt)[`#note[内容]`: 笔记]]
- #tip[#text(size: 9pt)[`#tip[内容]`: 技巧]]
- #info[#text(size: 9pt)[`#info[内容]`: 信息]]
- #warning[#text(size: 9pt)[`#warning[内容]`: 警告]]
- #caution[#text(size: 9pt)[`#caution[内容]`: 注意]]
- #danger[#text(size: 9pt)[`#danger[内容]`: 危险]]
- #todo[#text(size: 9pt)[`#todo[内容]`: 待办]]

== 快捷键说明

- 编译文档：#shortcut[Ctrl + Shift + B]
- 预览文档：#shortcut[Ctrl + Shift + P]
- 格式化代码：#shortcut[Shift + Alt + F]


// ── 附录 B: Typst 原生功能速查 ──
= Typst 原生功能速查

== 文档结构

#tex-table(
  ("功能", "语法", "说明"),
  ("文档元信息", `#set document(...)`, "标题、作者、日期"),
  ("页面设置", `#set page(...)`, "纸张、边距、页眉页脚"),
  ("目录", `#outline(depth: n)`, "自动生成目录"),
)

== 文本格式

#tex-table(
  ("功能", "语法", "说明"),
  ("加粗", `*文本*`, "粗体显示"),
  ("斜体", `_文本_`, "斜体显示"),
  ("等宽", "`代码`", "代码字体"),
  ("上标", "`^{文本}`", "上标文字，配对使用 ^...^"),
  ("下标", "`~{文本}`", "下标文字，配对使用 ~...~"),
)

== 布局组件

#tex-table(
  ("组件", "语法", "用途"),
  ("块", `#block[...]`, "独占一行"),
  ("盒", `#box[...]`, "行内容器"),
  ("网格", `#grid(...)`, "二维布局"),
  ("堆叠", `#stack(...)`, "垂直/水平堆叠"),
  ("对齐", `#align(...)`, "对齐内容"),
  ("定位", `#place(...)`, "绝对/相对定位"),
)

== 数学公式

数学公式使用 `$...$` 包裹，支持复杂的数学排版：

- 行内公式：`$x^2 + y^2 = z^2$`
- 独立公式：`$$...$$` 或 `$ ... $` + `#set math.equation(numbering: ...)`
- 常用符号：`sum`, `prod`, `int`, `infty`, `alpha`, `beta` 等
- 矩阵：`matrix(...)` 函数
- 分式：`1/2` 或 `\(a)/(b)`

== 交叉引用

#tex-table(
  ("功能", "语法", "示例"),
  ("定义标签", `<name>`, "在标题/公式末尾添加，如 `== 标题 <sec-intro>`"),
  ("引用", `@name`, "`@sec-intro` 引用标题/公式/图片"),
  ("公式标签", `<"eq-name">`, "数学公式中用引号包裹，如 `<\"eq-abc\">`"),
)

== 外部资源

#tex-table(
  ("资源", "语法", "说明"),
  ("图片", `#figure(image(...), caption: [...])`, "带编号和标题"),
  ("图片", `#image("path", width: 60%)`, "纯图片，无编号"),
  ("链接", `#link("url")[text]`, "可点击超链接"),
  ("脚注", `^[脚注内容]`, "快捷语法（推荐）"),
  ("脚注", `#footnote([内容])`, "函数形式"),
)


// ── 附录 C: 更新日志 ──
= 更新日志

== v1.0.1 (2026-04-06)

- 添加详细的组件来源说明
- 新增 Typst 原生功能演示（脚注、交叉引用、链接等）
- 添加完整的模板速查表
- 修正脚注语法速查表（`^[...]` 为推荐语法）
- 修正交叉引用语法说明（标签直接放在标题/公式后）
- 修正文本格式速查表（上标 `^{...}`、下标 `~{...}`）
- 修正 circle-line-enum 来源说明（基于 `el.default-enum-list`）

== v1.0.0 (2026-04-05)

- 初始版本发布
- 实现七级标题体系
- 集成 Codly 代码高亮
- 添加七种提示框
- 支持表格
- 实现树形列表和圆圈连接线列表

#fancy-divider

本文档完
