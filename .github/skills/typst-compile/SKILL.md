---
name: typst-compile
description: 本技能文件规定了如何编译验证 Typst 文件，确保修改后的笔记可以正确生成 PDF。
user_invocable: false
---

## 1. 编译命令

每次修改 `.typ` 文件后，必须编译验证。编译命令格式：

```bash
typst compile "<path-to-initial.typ>" "<output-pdf-path>" --root .
```

- `--root .` 必须指定，因为模板文件在仓库根目录的 `TypstTemplate/` 下，需要允许跨目录访问
- 工作目录（`cwd`）必须是仓库根目录 `c:\Notiz\MathRepo`

---

## 2. 输出路径规则

PDF 输出到 `initial.typ` 同级目录，文件名为 `initial.pdf`：

```
Subject/
  initial.typ      ← 编译入口（所有内容写在此文件）
  initial.pdf      ← 输出 PDF（同级）
  references.bib
  img/
```

---

## 3. 编译示例

```bash
# 在仓库根目录执行
typst compile "1.Analyse/Analyse Réelle/initial.typ" "1.Analyse/Analyse Réelle/initial.pdf" --root .

typst compile "1.Analyse/Analyse Complexe/initial.typ" "1.Analyse/Analyse Complexe/initial.pdf" --root .
```

---

## 4. 编译入口

- 始终编译 `initial.typ`（主入口），所有内容直接写在此文件中。
- 不再使用 `chapters/` 分文件模式。

---

## 5. 错误处理

### 常见编译错误

| 错误信息 | 原因 | 解决方案 |
|----------|------|----------|
| `cannot read file outside of project root` | 缺少 `--root .` | 添加 `--root .` 参数 |
| `unknown variable` | 多字母变量未加引号 | 用 `"var"` 包裹或空格分开 |
| `expected expression` | 裸下标 `$_x$` | 改为 `$""_x$` |
| `unexpected token` | 语法错误（括号不匹配等） | 检查 `[...]` 和 `(...)` 配对 |
| `file not found` | `#import` 路径错误 | 检查相对路径层级 |
| `failed to write PDF file` | 输出目录不存在 | 确保输出路径的目录已创建 |

### 编译验证流程

1. 修改 `.typ` 文件
2. 执行 `typst compile` 命令
3. 如果编译成功（exit code 0），验证通过
4. 如果编译失败，根据错误信息修复后重新编译

---

## 6. 注意事项

- 编译可能需要网络下载外部包（如 `@preview/xarrow`），首次编译时可能稍慢
- 编译输出为 PDF，不需要额外的构建系统
- 不要将 PDF 输出到 `tmp/` 目录（那是旧的约定），直接输出到 `initial.typ` 同级
