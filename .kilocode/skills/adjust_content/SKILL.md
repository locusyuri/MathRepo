# 调整内容技能

## 用途
本技能提供工作流，用于将 Typst 文档中注释形式的目录调整为与实际文件结构一致。

## 工作流
1. **识别 Part 名称**：从主文件（如 `initial.typ`）中的 `#part("...")` 指令提取
2. **识别 Chapter 名称**：从章节文件中的 `= Chapter Title` 一级标题提取
3. **识别 Section 名称**：从章节文件中的 `== Section Title` 二级标题提取
4. **保留格式**：保持标准格式：
   ```
   // --- Part X: Part Name (翻译) ---
   
   // Chapter Y: Chapter Name (翻译)
   //   Section Y.1: Section Name (翻译)
   //   Section Y.2: Next Section...
   ```
5. **占位处理**：对完全为空的章节/部分标注为 `(currently empty placeholder)`

## 核心规则

### 1. 严禁臆造
- **绝不发明名称**——所有 Part/Chapter/Section 名称必须直接从源文件中提取
- **绝不添加不存在的节**——只列出文件中实际存在的 `==` 二级标题

### 2. 空目录不等于空注释 ⚠️
- **真实目录为空 = 该章节尚未编写**
- **这种情况下，注释里的目录不要改成空**——保留原有的详细规划目录（即未编写前的完整大纲）
- 只有当章节文件**确实存在且有内容**时，才用实际结构替换注释目录
- 示例：`FunctionSpaces.typ` 为空占位文件 → 注释里保留原规划目录，不改成空

### 3. 格式规范
- 保留所有原始双语格式（中文翻译）
- 仅修改注释形式的目录部分，其他内容保持不变
- 保持统一缩进（Section 缩进 2 个空格）
- 章节编号与实际 `==` 标题顺序一致

## 示例输出
```
// --- Part I: Measure Theory (测度论) ---

// Chapter 1: Lebesgue Measure (勒贝格测度)
//   Section 1.1: σ-Algebra and Measure (σ-代数与测度)
//   Section 1.2: Lebesgue Measure (勒贝格测度)
//   Section 1.3: Non-Measurable Sets (非可测集)
//   Section 1.4: Other Views (其他视角)

// --- Part II: Integration Theory (积分理论) ---
// (currently empty placeholder)
```

## 实施要点
- 使用 `read()` 验证实际文件结构后再编辑
- 只有当章节文件**有实质内容**时，才用实际结构替换注释目录
- 章节文件为空/只有 `#import` → 注释目录保持原规划不变
- 保留所有原始双语格式（中文翻译）
- 只修改注释形式的目录部分，其他内容保持不变