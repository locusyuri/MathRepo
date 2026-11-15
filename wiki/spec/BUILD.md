---
name: 构建与验证命令
description: 编译、插图生成、静态校验、PDF 分发的权威命令；改脚本或换环境时读
---

# 构建与验证

所有命令在仓库根目录执行。依赖：`typst`、`uv`（Python 依赖见根 `pyproject.toml`）；PDF 分发另需 `ossutil`（`ossutil config` 配置完成）。

## 一键任务

`scripts/no-pwsh.ps1` 聚合了下列动作：无参出菜单，或 `-Task build|images|check|migrate|upload|publish|status`。日志写 `logs/`（已 gitignore）。

## 编译

```powershell
typst compile "<subject>/<note>/initial.typ" "<subject>/<note>/initial.pdf" --root .
```

只编译入口 `initial.typ`，以退出码 0 为成功标准。`--root .` 不可省略。

## 插图

绘图脚本在 `<subject>/<note>/scripts/*.py`（一图一脚本），输出到同笔记 `img/`。

```powershell
.\scripts\images\build-images.ps1 -DryRun
.\scripts\images\build-images.ps1 -SkipExisting
.\scripts\images\build-images.ps1 -Note "3.Géométrie/Géométrie Analytique" -Overwrite
```

底层是 `scripts/images/build-images.py`，会扫描 `.typ` 中的 `image(...)` 与脚本的输出声明来匹配。

## 静态校验

```powershell
uv run scripts/check/check-typst-attachments.py --summary
uv run scripts/check/check-typst-attachments.py --fix
```

检查模式有命中退出码为 1，无命中为 0；`--fix` 只做可机械推导的替换，之后仍需用检查模式复核。

## PDF 分发

```powershell
.\scripts\pdf\migrate-pdfs.ps1 -ListOnly     # 本地按 <学科>/<笔记>.pdf 归类
.\scripts\pdf\upload-pdfs.ps1 -Yes           # 上传 oss://math-repo/math/main/
```

PDF 与插图都不入 Git（见根 `.gitignore`），图片可随时由脚本重建。
