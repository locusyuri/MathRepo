[Homepage](https://lis-azure.vercel.app/indexes/math) | [Github](https://github.com/locusyuri/MathRepo) | [CNB](https://cnb.cool/catmono/MathRepo) | 

![License](https://img.shields.io/github/license/locusyuri/MathRepo) ![Repo Size](https://img.shields.io/github/repo-size/locusyuri/MathRepo) ![Commit Activity](https://img.shields.io/github/commit-activity/w/locusyuri/MathRepo) ![Last Commit](https://img.shields.io/github/last-commit/locusyuri/MathRepo) ![Issues](https://img.shields.io/github/issues/locusyuri/MathRepo)  ![Stargazers](https://img.shields.io/github/stars/locusyuri/MathRepo?style=social) ![Forks](https://img.shields.io/github/forks/locusyuri/MathRepo?style=social) ![Watchers](https://img.shields.io/github/watchers/locusyuri/MathRepo?style=social) ![Language](https://img.shields.io/github/languages/top/locusyuri/MathRepo) ![Top Language](https://img.shields.io/github/languages/count/locusyuri/MathRepo)



------

# Structure | 目录结构
This repository collects bilingual mathematics notes organized by subject. The list below reflects the current folder tree; folders shown with ~~strike through~~ are still under construction.

## 1.Analyse | 分析学
- [Analyse Complexe | 复分析](https://lis-azure.vercel.app/notes/analyse-complexe)
- [Analyse Harmonique | 调和分析](https://lis-azure.vercel.app/notes/analyse-harmonique)
- [Analyse Fonctionnelle | 泛函分析](https://lis-azure.vercel.app/notes/analyse-fonctionnelle)
- [Analyse Mathématique | 数学分析](https://lis-azure.vercel.app/notes/analyse-math%C3%A9matique)
- [Analyse Réelle | 实分析](https://lis-azure.vercel.app/notes/analyse-r%C3%A9elle)
- [Équation Différentielle Ordinaire | 常微分方程](https://lis-azure.vercel.app/notes/%C3%A9quation-diff%C3%A9rentielle-ordinaire)
- [Équations aux Dérivées Partielles | 偏微分方程](https://lis-azure.vercel.app/notes/%C3%A9quations-aux-d%C3%A9riv%C3%A9es-partielles)


## 2.Algèbre | 代数学
- [Algèbre Abstraite | 抽象代数](https://lis-azure.vercel.app/notes/alg%C3%A8bre-abstraite)
- [Algèbre Linéaire | 线性代数](https://lis-azure.vercel.app/notes/alg%C3%A8bre-lin%C3%A9aire)
- [Polynôme | 多项式](https://lis-azure.vercel.app/notes/polyn%C3%B4me)
- [Théorie des Nombres | 数论](https://lis-azure.vercel.app/notes/th%C3%A9orie-des-nombres)


## 3.Géométrie | 几何学
- [Géométrie Analytique | 解析几何](https://lis-azure.vercel.app/notes/g%C3%A9om%C3%A9trie-analytique)
- [Topologie Algébrique  | 代数拓扑](https://lis-azure.vercel.app/notes/topologie-alg%C3%A9brique)
- [Topologie Générale | 点集拓扑](https://lis-azure.vercel.app/notes/topologie-g%C3%A9n%C3%A9rale)

## 4.Mathématiques discrètes | 离散数学
- [Combinatoire | 组合数学](https://lis-azure.vercel.app/notes/combinatoire)
- [Logique Mathématique | 数理逻辑](https://lis-azure.vercel.app/notes/logique-math%C3%A9matique)
- [Théorie des Ensembles | 集合论](https://lis-azure.vercel.app/notes/th%C3%A9orie-des-ensembles)
- [Théorie des Graphes | 图论](https://lis-azure.vercel.app/notes/th%C3%A9orie-des-graphes)

## 5.Statistique | 统计学
- [Probabilités | 概率论](https://lis-azure.vercel.app/notes/probabilit%C3%A9s)
- [Processus Stochastique | 随机过程](https://lis-azure.vercel.app/notes/processus-stochastique)


## 6.Mathématiques appliquées | 应用数学
- [Électrodynamique | 电动力学](https://lis-azure.vercel.app/notes/%C3%A9lectrodynamique)
- [Latex | Latex 教程](https://lis-azure.vercel.app/notes/latex)
- [Mécanique analytique | 分析力学](https://lis-azure.vercel.app/notes/m%C3%A9canique-analytique)
- [Mécanique quantique | 量子力学](https://lis-azure.vercel.app/notes/m%C3%A9canique-quantique)


---
# Asset Sync | 资源同步

本仓库的图片和 PDF 文件不纳入 Git 版本控制，而是通过阿里云 OSS 存储。
clone 仓库后需要手动下载图片才能正常编译 PDF。

## 前置要求

- [ossutil](https://help.aliyun.com/document_detail/120075.html) 已安装并配置（`ossutil config`）
- PowerShell 5.1+ / PowerShell Core

## 图片同步 (`scripts/sync-images.ps1`)

图片存储在 `oss://math-repo/imgs/`，保持与本地相同的目录结构。

```powershell
# 下行同步：从 OSS 下载所有图片到本地
.\scripts\sync-images.ps1 -Direction down -Yes

# 上行同步：将本地图片上传到 OSS
.\scripts\sync-images.ps1 -Direction up -Yes

# 交互式模式（带文件预览和确认）
.\scripts\sync-images.ps1
```

## PDF 上传 (`scripts/upload-pdfs.ps1`)

PDF 存储在 `oss://math-repo/math/main/`，保持与本地相同的目录结构。仅支持上传。

```powershell
# 直接上传，无需确认
.\scripts\upload-pdfs.ps1 -Yes

# 交互式模式（带文件预览和确认）
.\scripts\upload-pdfs.ps1

# 仅查看本地 PDF 列表
.\scripts\upload-pdfs.ps1 -ListOnly
```

## 同步策略

使用 `ossutil sync --update`，基于文件大小和修改时间判断是否需要传输，
跳过未变更的文件，不删除对端已不存在的文件。

---
# Term Index | 术语索引
## A

## B
- **Banach Space (巴拿赫空间)** | 
- **Bounded Variation (有界变差)** | Analyse Mathématique
## C
- **Continuation (延拓)** | Théorie des Ensembles
## D
## E
## F
## G
## H
- **Hilbert Space (希尔伯特空间)** |
- **Homogeneous Function (齐次函数)** | Équation Différentielle Ordinaire

## I
## J
## K
## L

- **Linear Space (线性空间)** | Algèbre Linéaire

## M
## N
## O
## P
## Q
## R
## S
## T
## U
## V
## W
## X
## Y
## Z

------

Copyright © 2026 Cat Mono. All rights reserved.
