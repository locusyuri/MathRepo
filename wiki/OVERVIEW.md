---
name: MathRepo Wiki 总入口
description: 目录导航、分区定位、权威源（SSOT）声明与维护约定；进入 wiki 先读本文
---

# MathRepo Wiki

面向维护者与 Agent 的项目文档。笔记正文在 6 个学科目录里，这里只管"怎么维护它"。

## 导航

| 想知道 | 去哪 |
|---|---|
| 现在写到哪、下一步做什么 | [plan/OVERVIEW.md](plan/OVERVIEW.md) |
| 某章的写作大纲 | [plan/outlines/](plan/outlines/) |
| 待办 | [issues/TODOS.md](issues/TODOS.md) |
| 踩过的坑与解法 | [issues/SOLUTIONS.md](issues/SOLUTIONS.md) |
| 批注审查归档 | [issues/REVIEWS/](issues/REVIEWS/) |
| 笔记的结构规范 | [spec/STRUCTURE.md](spec/STRUCTURE.md) |
| 编译/校验/出图/分发命令 | [spec/BUILD.md](spec/BUILD.md) |
| 工程脚本清单 | [../scripts/README.md](../scripts/README.md) |
| 外部来源 | [reference/SOURCES.md](reference/SOURCES.md) |
| 已完成的计划 | [archive/](archive/) |

## 分区定位

| 目录 | 放 | 不放 |
|---|---|---|
| `plan/` | 目标、阶段、写作大纲、进度 | 已完成事项的追忆（→ `issues/`） |
| `issues/` | 待办、踩坑解法、批注归档 | 进行中的大纲（→ `plan/outlines/`） |
| `spec/` | 结构规范、构建命令等必须遵守的约定 | 设计动机与背景 |
| `reference/` | 外部一手材料与来源登记（只读） | 需要维护的内容 |
| `assets/` | 占位图等共享素材 | 笔记插图（在各笔记 `img/`） |
| `archive/` | 已完结的计划 | 少量作废版本（原地留档即可） |

笔记目录内的 `docs/`（写作草稿、REFACTOR 方案）、`ref/`（外部资料）、`scripts/`（一图一脚本）属于笔记内容，不迁入 wiki。

## SSOT 声明

| 主题 | 权威源 |
|---|---|
| 笔记结构（Part / Chapter / 节 / 注释目录） | [spec/STRUCTURE.md](spec/STRUCTURE.md) |
| 构建、校验、出图、分发命令 | [spec/BUILD.md](spec/BUILD.md) |
| 工程脚本清单与用法 | [../scripts/README.md](../scripts/README.md) |
| 符号与排版约定 | `.agents/skills/violet-typst-writing-conventions/SKILL.md` |
| 模板组件 API | `TypstTemplate/math-notes.typ` |
| 写作流程（大纲 → 正文 → 配图） | `.agents/skills/violet-make-outline`、`.agents/skills/violet-typst-writing-conventions` |
| 写作进度 | [plan/OVERVIEW.md](plan/OVERVIEW.md) |

同一事实只在一处维护。根目录 `README.md` 是面向 GitHub 访客的展示版，内部约定以本 wiki 为准。

## 维护约定

- 进度只写 `plan/OVERVIEW.md`，其他文档不复制进度表。
- 计划做完移到 `archive/`；批注处理完移到 `issues/REVIEWS/`。
- 本 wiki 的路径被技能、脚本、笔记注释引用；改名必须全仓 grep（含 `.agents/skills`、`README.md`、笔记 `initial.typ` 注释）。
- 不设 `updated` 字段，改动时间看 git。
