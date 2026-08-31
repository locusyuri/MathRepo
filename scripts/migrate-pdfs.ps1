<#
.SYNOPSIS
    MathRepo PDF 本地迁移脚本

.DESCRIPTION
    将仓库中编译生成的 initial.pdf 复制到目标文件夹，按「学科名.pdf」重命名归类，便于查看。

    命名映射:
      本地:  1.Analyse/Analyse Complexe/initial.pdf
      目标:  <Target>\1.Analyse\Analyse Complexe.pdf

    同步策略:
    - 比较源与目标的 size + MD5，仅复制有差异的文件

.PARAMETER Yes
    跳过交互式确认，直接执行复制

.PARAMETER ListOnly
    仅列出映射关系，不执行复制

.PARAMETER Target
    目标文件夹路径，默认为 WPS 云盘 NewMath 目录

.EXAMPLE
    .\migrate-pdfs.ps1                # 交互式模式
    .\migrate-pdfs.ps1 -Yes           # 直接复制差异文件
    .\migrate-pdfs.ps1 -ListOnly      # 仅查看映射列表
    .\migrate-pdfs.ps1 -Target "D:\PDF\Math"   # 自定义目标目录
#>

[CmdletBinding()]
param(
    [Alias('y')]
    [switch]$Yes,

    [switch]$ListOnly,

    [string]$Target = 'C:\Users\Violet\WPSDrive\1774341244\WPS企业云盘\哈尔滨工业大学\我的企业文档\PDF\NewMath'
)

$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path -Parent $PSScriptRoot

# ── helpers ─────────────────────────────────────────────────────────────────

function Write-Title($text) { Write-Host "`n$text" -ForegroundColor Cyan }
function Write-Ok($text)    { Write-Host $text -ForegroundColor Green }
function Write-Err($text)   { Write-Host $text -ForegroundColor Red }
function Write-Warn($text)  { Write-Host $text -ForegroundColor Yellow }

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

        $category = $null
        $subject  = $null

        if ($parts.Count -eq 3 -and $parts[2] -eq 'initial.pdf') {
            $category = $parts[0]
            $subject  = $parts[1]
        } elseif ($parts.Count -eq 4 -and $parts[2] -eq 'tmp' -and $parts[3] -eq 'initial.pdf') {
            $category = $parts[0]
            $subject  = $parts[1]
        } else {
            Write-Warn "  跳过异常路径: $relative"
            continue
        }

        $targetRel = Join-Path $category "$subject.pdf"

        if ($seen.ContainsKey($targetRel)) { continue }
        $seen[$targetRel] = $true

        $mappings += [PSCustomObject]@{
            Local     = $relative
            TargetRel = $targetRel
            File      = $pdf
            MtimeUtc  = $pdf.LastWriteTimeUtc
        }
    }
    $mappings
}

function Test-ContentMatch($sourcePath, $sourceSize, $targetPath) {
    if (-not (Test-Path -LiteralPath $targetPath)) { return $false }
    $targetItem = Get-Item -LiteralPath $targetPath
    if ($targetItem.Length -ne $sourceSize) { return $false }
    $sourceHash = (Get-FileHash -Algorithm MD5 -LiteralPath $sourcePath).Hash
    $targetHash = (Get-FileHash -Algorithm MD5 -LiteralPath $targetPath).Hash
    return $sourceHash -eq $targetHash
}

function Get-PdfCopyDiff($mappings) {
    $diff = @()
    foreach ($m in $mappings) {
        $targetPath = Join-Path $Target $m.TargetRel
        if (-not (Test-ContentMatch $m.File.FullName $m.File.Length $targetPath)) {
            $diff += $m
        }
    }
    $diff
}

function Show-MappingList($mappings) {
    Write-Host "`n映射关系 ($($mappings.Count) 个文件):" -ForegroundColor White
    Write-Host ("-" * 70)
    foreach ($m in $mappings) {
        Write-Host "  $($m.Local)" -NoNewline
        Write-Host " → " -NoNewline -ForegroundColor Cyan
        Write-Host $m.TargetRel
    }
    Write-Host ("-" * 70)
}

function Confirm-Action($message) {
    if ($Yes) { return $true }
    Write-Host "`n$message [Y/n] " -NoNewline -ForegroundColor Yellow
    $answer = (Read-Host).Trim().ToLower()
    return $answer -ne 'n'
}

function Invoke-Copy($mappings) {
    $total = $mappings.Count
    $success = 0
    $failed = 0

    for ($i = 0; $i -lt $total; $i++) {
        $m = $mappings[$i]
        $num = $i + 1
        $targetPath = Join-Path $Target $m.TargetRel
        $targetDir = Split-Path -Parent $targetPath
        Write-Host "[$num/$total] $($m.TargetRel)" -NoNewline
        try {
            if (-not (Test-Path -LiteralPath $targetDir)) {
                New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
            }
            Copy-Item -LiteralPath $m.File.FullName -Destination $targetPath -Force
            Write-Ok " ✓"
            $success++
        } catch {
            Write-Err " ✗ ($($_.Exception.Message))"
            $failed++
        }
    }

    Write-Host ""
    Write-Host "复制完成: " -NoNewline
    Write-Ok "$success 成功" -NoNewline
    if ($failed -gt 0) { Write-Host ", "; Write-Err "$failed 失败" -NoNewline }
    Write-Host ""
}

# ── main ────────────────────────────────────────────────────────────────────

$mappings = @(Get-PdfMapping)
if ($mappings.Count -eq 0) {
    Write-Warn "`n未找到任何 initial.pdf，请先编译笔记"
    exit 0
}

# ListOnly: 显示全部映射
if ($ListOnly) {
    Write-Title "PDF 映射预览"
    Write-Host "目标目录: $Target"
    Show-MappingList $mappings
    exit 0
}

$diff = @(Get-PdfCopyDiff $mappings)

if ($diff.Count -eq 0) {
    Write-Ok "`n所有 PDF 已同步，无需复制 (本地 $($mappings.Count) 个文件均与目标一致)"
    exit 0
}

# 参数模式: -Yes 直接复制
if ($Yes) {
    Write-Host "`n开始复制 $($diff.Count) 个差异 PDF..." -ForegroundColor Cyan
    Show-MappingList $diff
    Write-Host "  (本地共 $($mappings.Count) 个 PDF，$($diff.Count) 个有差异)"
    Write-Host "  目标目录: $Target"
    Invoke-Copy $diff
    exit 0
}

# 交互式模式
Write-Title "MathRepo PDF 本地迁移工具"
Write-Host "目标目录: $Target"
Write-Host "仓库根目录: $RepoRoot"

Show-MappingList $diff
Write-Host "  (本地共 $($mappings.Count) 个 PDF，$($diff.Count) 个有差异)"

if (-not (Confirm-Action "确认复制以上 $($diff.Count) 个差异 PDF 到目标目录？")) {
    Write-Host "已取消"
    exit 0
}

Invoke-Copy $diff
