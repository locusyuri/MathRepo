# Typst 笔记结构规范

本文档记录 `Mécanique Analytique` 笔记的完整代码结构，作为 Typst 长文档的目录结构样板。

---

## 目录结构

每 `#part` 对应一个知识模块，每个 `= Chapter` 为一个完整章节，`==` 为节，`===` 为子节。

注释目录（`// Chapter`, `// Section`）位于实际代码上方，两者保持同步。

示例如下：
### Part I: Mathematical Foundations (数学基础)

```
// =========================================================================
// --- Part I: Mathematical Foundations (数学基础) ---
// =========================================================================
#part("Mathematical Foundations") // 数学基础

// Chapter 1: Variational Calculus (变分法)
//   Section 1.1: Variational Method and First Variation (变分法与第一变分)
//   Section 1.2: Euler-Lagrange Equations (欧拉-拉格朗日方程)
//   Section 1.3: Variational Problems with Constraints (带约束的变分问题)
= Variational Calculus  // 变分法
== Variational Method and First Variation // 变分法与第一变分
== Euler-Lagrange Equations // 欧拉-拉格朗日方程
== Variational Problems with Constraints // 带约束的变分问题
```
