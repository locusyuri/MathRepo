# scripts/ 工程脚本索引

仓库级工具链。**笔记内的 `<subject>/<note>/scripts/*.py` 是内容资产（一图一脚本），不在这里**。

所有命令在仓库根目录执行。

| 目录 | 放什么 | 什么时候用 |
|---|---|---|
| `images/` | 插图渲染 | 新增/修改绘图脚本后重建 `img/` |
| `check/` | 静态校验 | 提交前检查 Typst 语法、交叉引用 |
| `pdf/` | 产物分发 | 编译完 PDF 后本地归类或上传 OSS |

## images/

| 脚本 | 用途 |
|---|---|
| `build-images.ps1` | 交互式包装，预览「已存在 / 待生成」后选择覆盖或跳过 |
| `build-images.py` | 底层实现：扫描 `<subject>/<note>/scripts/*.py`，按输出声明出图 |

```powershell
.\scripts\images\build-images.ps1 -DryRun                              # 只预览
.\scripts\images\build-images.ps1 -SkipExisting                        # 只补缺失
.\scripts\images\build-images.ps1 -Note "3.Géométrie/Géométrie Analytique" -Overwrite
```

## check/

| 脚本 | 用途 |
|---|---|
| `check-typst-attachments.py` | 检查 `_^` 后紧跟括号、`_{}` 残留、LaTeX 宏残留；`--fix` 只做可机械推导的替换 |

```powershell
uv run scripts/check/check-typst-attachments.py --summary
uv run scripts/check/check-typst-attachments.py --fix
```

退出码：检查模式有命中为 1，无命中为 0。

## pdf/

| 脚本 | 用途 |
|---|---|
| `migrate-pdfs.ps1` | 把各笔记 `initial.pdf` 按 `<学科>/<笔记>.pdf` 复制到本地目标目录（size + MD5 比对） |
| `upload-pdfs.ps1` | 上传到 `oss://math-repo/math/main/`，仅传差异文件 |

```powershell
.\scripts\pdf\migrate-pdfs.ps1 -ListOnly
.\scripts\pdf\upload-pdfs.ps1 -Yes
```

前置：PDF 分发需要 `ossutil` 已安装并 `ossutil config` 配置完成。

## 不归本目录管

- `.agents/hooks/scripts/check-typst-syntax.ps1` —— Agent 钩子（LaTeX 宏拦截），由 `.agents/hooks/check-typst-syntax.json` 调用，属 Agent 基建。
- 笔记目录内的 `scripts/`、`docs/`、`img/` —— 笔记内容与写作草稿。

相关文档：[wiki/spec/BUILD.md](../wiki/spec/BUILD.md)、[wiki/spec/STRUCTURE.md](../wiki/spec/STRUCTURE.md)。
