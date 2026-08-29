<#
.SYNOPSIS
    MathRepo PDF 上传至 OSS 脚本

.DESCRIPTION
    将仓库中编译生成的 initial.pdf 上传到阿里云 OSS，并重命名为学科名。

    命名映射:
      本地: 1.Analyse/Analyse Complexe/initial.pdf
      OSS:  oss://math-repo/math/main/1.Analyse/Analyse Complexe.pdf

    同步策略 (ossutil cp --update):
    - 比较文件大小和最后修改时间
    - 跳过大小和 mtime 均相同的文件

.PARAMETER Yes
    跳过交互式确认，直接执行上传

.PARAMETER ListOnly
    仅列出映射关系，不执行上传

.EXAMPLE
    .\upload-pdfs.ps1                # 交互式模式
    .\upload-pdfs.ps1 -Yes           # 直接上传，无需确认
    .\upload-pdfs.ps1 -ListOnly      # 仅查看映射列表
#>

[CmdletBinding()]
param(
    [Alias('y')]
    [switch]$Yes,

    [switch]$ListOnly
)

$ErrorActionPreference = 'Stop'

$RepoRoot  = Split-Path -Parent $PSScriptRoot
$OssPrefix = 'oss://math-repo/math/main/'

# ── helpers ─────────────────────────────────────────────────────────────────

function Write-Title($text) {
    Write-Host "`n$text" -ForegroundColor Cyan
}

function Write-Ok($text) {
    Write-Host $text -ForegroundColor Green
}

function Write-Err($text) {
    Write-Host $text -ForegroundColor Red
}

function Write-Warn($text) {
    Write-Host $text -ForegroundColor Yellow
}

function Test-Ossutil {
    if (-not (Get-Command ossutil -ErrorAction SilentlyContinue)) {
        Write-Err "错误: 未找到 ossutil，请确认已安装并添加到 PATH"
        exit 1
    }
}

function Test-OssConnection {
    Write-Host "检查 OSS 连接..." -NoNewline
    $null = & ossutil ls $OssPrefix 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Err " 失败"
        Write-Err "无法访问 $OssPrefix，请检查 ossutil 配置和网络连接"
        exit 1
    }
    Write-Ok " 正常"
}

function Get-PdfMapping {
    $mappings = @()
    $seen = @{}

    $pdfs = Get-ChildItem -Path $RepoRoot -Recurse -Filter 'initial.pdf' -File -ErrorAction SilentlyContinue |
        Where-Object {
            $_.FullName -notlike '*\.git\*' -and
            $_.FullName -notlike '*\TexTemplate\*' -and
            $_.FullName -notlike '*\TypstTemplate\*'
        } |
        Sort-Object FullName

    foreach ($pdf in $pdfs) {
        $relative = $pdf.FullName.Substring($RepoRoot.Length + 1)
        $parts = $relative -split '\\|/'

        # 支持两种模式:
        #   Typst:  {学科}/{科目}/initial.pdf       (3 段)
        #   LaTeX:  {学科}/{科目}/tmp/initial.pdf    (4 段)
        $category = $null
        $subject  = $null

        if ($parts.Count -eq 3 -and $parts[2] -eq 'initial.pdf') {
            $category = $parts[0]
            $subject  = $parts[1]
        } elseif ($parts.Count -eq 4 -and $parts[2] -eq 'tmp' -and $parts[3] -eq 'initial.pdf') {
            $category = $parts[0]
            $subject  = $parts[1]
        } else {
            Write-Warn "  跳过异常路径: $relative (期望 {{学科}}/{{科目}}/initial.pdf 或 {{学科}}/{{科目}}/tmp/initial.pdf)"
            continue
        }

        $ossKey = "$category/$subject.pdf"

        if ($seen.ContainsKey($ossKey)) {
            continue
        }
        $seen[$ossKey] = $true

        $mappings += [PSCustomObject]@{
            Local  = $relative
            OssKey = $ossKey
            File   = $pdf
        }
    }
    $mappings
}

function Show-MappingList($mappings) {
    Write-Host "`n映射关系 ($($mappings.Count) 个文件):" -ForegroundColor White
    Write-Host ("-" * 70)
    foreach ($m in $mappings) {
        Write-Host "  $($m.Local)" -NoNewline
        Write-Host " → " -NoNewline -ForegroundColor Cyan
        Write-Host $m.OssKey
    }
    Write-Host ("-" * 70)
}

function Confirm-Action($message) {
    if ($Yes) { return $true }
    Write-Host "`n$message [Y/n] " -NoNewline -ForegroundColor Yellow
    $input = (Read-Host).Trim().ToLower()
    return $input -ne 'n'
}

function Invoke-Upload($mappings) {
    $total = $mappings.Count
    $success = 0
    $skipped = 0
    $failed = 0

    for ($i = 0; $i -lt $total; $i++) {
        $m = $mappings[$i]
        $num = $i + 1
        Write-Host "[$num/$total] $($m.OssKey)" -NoNewline
        & ossutil cp $m.File.FullName "$OssPrefix$($m.OssKey)" --update 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Ok " ✓"
            $success++
        } else {
            Write-Err " ✗ (exit $LASTEXITCODE)"
            $failed++
        }
    }

    Write-Host ""
    Write-Host "上传完成: " -NoNewline
    Write-Ok "$success 成功" -NoNewline
    if ($failed -gt 0) { Write-Host ", "; Write-Err "$failed 失败" -NoNewline }
    Write-Host ""
}

# ── main ────────────────────────────────────────────────────────────────────

Test-Ossutil

$mappings = Get-PdfMapping
if ($mappings.Count -eq 0) {
    Write-Warn "`n未找到任何 initial.pdf，请先编译笔记"
    exit 0
}

# ListOnly
if ($ListOnly) {
    Write-Title "PDF 映射预览"
    Show-MappingList $mappings
    exit 0
}

# 参数模式: -Yes 直接上传
if ($Yes) {
    Test-OssConnection
    Write-Host "`n开始上传 $($mappings.Count) 个 PDF..." -ForegroundColor Cyan
    Show-MappingList $mappings
    Invoke-Upload $mappings
    exit 0
}

# 交互式模式
Write-Title "MathRepo PDF 上传工具"
Write-Host "OSS 路径: $OssPrefix"
Write-Host "仓库根目录: $RepoRoot"

Test-OssConnection

Show-MappingList $mappings

if (-not (Confirm-Action "确认上传以上 $($mappings.Count) 个 PDF 到 OSS？")) {
    Write-Host "已取消"
    exit 0
}

Invoke-Upload $mappings
