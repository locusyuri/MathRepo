<#
.SYNOPSIS
    MathRepo PDF 上传至 OSS 脚本

.DESCRIPTION
    将仓库中编译生成的 initial.pdf 上传到阿里云 OSS，并重命名为学科名。

    命名映射:
      本地: 1.Analyse/Analyse Complexe/initial.pdf
      OSS:  oss://math-repo/math/main/1.Analyse/Analyse Complexe.pdf

    同步策略:
    - 预览: 比较本地与远程的 size + ETag(MD5)，仅显示有差异的文件
    - 上传: 逐文件 ossutil cp（仅上传差异文件）

.PARAMETER Yes
    跳过交互式确认，直接执行上传

.PARAMETER ListOnly
    仅列出映射关系，不执行上传

.EXAMPLE
    .\upload-pdfs.ps1                # 交互式模式
    .\upload-pdfs.ps1 -Yes           # 直接上传差异文件
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

function Write-Title($text) { Write-Host "`n$text" -ForegroundColor Cyan }
function Write-Ok($text)    { Write-Host $text -ForegroundColor Green }
function Write-Err($text)   { Write-Host $text -ForegroundColor Red }
function Write-Warn($text)  { Write-Host $text -ForegroundColor Yellow }

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

function ConvertFrom-OssutilTime($timeStr) {
    if ($timeStr -match '^(.+ [+-]\d{4})\s+\w+$') {
        $clean = $Matches[1]
    } else {
        $clean = $timeStr
    }
    $dt = [DateTime]::MinValue
    [void][DateTime]::TryParse($clean, [ref]$dt)
    return $dt.ToUniversalTime()
}

function Get-OssFileList {
    # 返回 @{ Relative; Size; Etag; MtimeUtc } 数组
    # 注意: OSS 的 LastModified 是上传时间而非文件 mtime，不可靠；
    #       内容比较使用 Size + ETag（单次上传时 ETag 即内容 MD5）。
    $output = & ossutil ls $OssPrefix 2>&1
    if ($LASTEXITCODE -ne 0) { return @() }

    $entries = @()
    foreach ($line in $output) {
        $ossIdx = $line.IndexOf('oss://')
        if ($ossIdx -lt 0) { continue }
        $fullPath = $line.Substring($ossIdx).Trim()
        if ($fullPath.Length -le $OssPrefix.Length) { continue }
        $relative = $fullPath.Substring($OssPrefix.Length)
        if ($relative.EndsWith('/')) { continue }

        $prefix = $line.Substring(0, $ossIdx).TrimEnd()
        $size = 0L; $etag = ''; $mtimeUtc = [DateTime]::MinValue
        if ($prefix -match '^(\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\s+[+-]\d{4}\s+\w+)\s+(\d+)\s+\S+\s+([0-9A-Fa-f-]+)$') {
            $mtimeUtc = ConvertFrom-OssutilTime $Matches[1]
            $size = [long]$Matches[2]
            $etag = $Matches[3]
        }

        $entries += [PSCustomObject]@{
            Relative = $relative
            Size     = $size
            Etag     = $etag
            MtimeUtc = $mtimeUtc
        }
    }
    $entries
}

function Test-OssContentMatch($localPath, $localSize, $remote) {
    if ($null -eq $remote) { return $false }
    if ($remote.Size -ne $localSize) { return $false }
    if ($remote.Etag -notmatch '^[0-9A-Fa-f]{32}$') { return $true }
    if (-not (Test-Path -LiteralPath $localPath)) { return $false }
    $localEtag = (Get-FileHash -Algorithm MD5 -LiteralPath $localPath).Hash
    return $localEtag -eq $remote.Etag
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

        $ossKey = "$category/$subject.pdf"

        if ($seen.ContainsKey($ossKey)) { continue }
        $seen[$ossKey] = $true

        $mappings += [PSCustomObject]@{
            Local    = $relative
            OssKey   = $ossKey
            File     = $pdf
            MtimeUtc = $pdf.LastWriteTimeUtc
        }
    }
    $mappings
}

function Get-PdfUploadDiff($mappings, $ossFiles) {
    $remoteMap = @{}
    foreach ($e in $ossFiles) { $remoteMap[$e.Relative] = $e }

    $diff = @()
    foreach ($m in $mappings) {
        $remote = if ($remoteMap.ContainsKey($m.OssKey)) { $remoteMap[$m.OssKey] } else { $null }
        if (-not (Test-OssContentMatch $m.File.FullName $m.File.Length $remote)) {
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
    $failed = 0

    for ($i = 0; $i -lt $total; $i++) {
        $m = $mappings[$i]
        $num = $i + 1
        Write-Host "[$num/$total] $($m.OssKey)" -NoNewline
        & ossutil cp $m.File.FullName "$OssPrefix$($m.OssKey)" -f 2>&1 | Out-Null
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

$mappings = @(Get-PdfMapping)
if ($mappings.Count -eq 0) {
    Write-Warn "`n未找到任何 initial.pdf，请先编译笔记"
    exit 0
}

# ListOnly: 显示全部映射
if ($ListOnly) {
    Write-Title "PDF 映射预览"
    Show-MappingList $mappings
    exit 0
}

# 需要 OSS 连接来计算 diff
Test-OssConnection

$ossFiles = @(Get-OssFileList)
$diff = @(Get-PdfUploadDiff $mappings $ossFiles)

if ($diff.Count -eq 0) {
    Write-Ok "`n所有 PDF 已同步，无需上传 (本地 $($mappings.Count) 个文件均与 OSS 一致)"
    exit 0
}

# 参数模式: -Yes 直接上传
if ($Yes) {
    Write-Host "`n开始上传 $($diff.Count) 个差异 PDF..." -ForegroundColor Cyan
    Show-MappingList $diff
    Write-Host "  (本地共 $($mappings.Count) 个 PDF，$($diff.Count) 个有差异)"
    Invoke-Upload $diff
    exit 0
}

# 交互式模式
Write-Title "MathRepo PDF 上传工具"
Write-Host "OSS 路径: $OssPrefix"
Write-Host "仓库根目录: $RepoRoot"

Show-MappingList $diff
Write-Host "  (本地共 $($mappings.Count) 个 PDF，$($diff.Count) 个有差异)"

if (-not (Confirm-Action "确认上传以上 $($diff.Count) 个差异 PDF 到 OSS？")) {
    Write-Host "已取消"
    exit 0
}

Invoke-Upload $diff
