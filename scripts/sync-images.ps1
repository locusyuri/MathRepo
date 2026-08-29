<#
.SYNOPSIS
    MathRepo 图片与 OSS 双向同步脚本

.DESCRIPTION
    将仓库中的图片文件与阿里云 OSS 进行双向同步，保持目录结构一致。
    OSS 路径: oss://math-repo/imgs/

    同步策略:
    - 预览: 比较本地与远程的 size + ETag(MD5)，仅显示有差异的文件
    - 上行: 复制差异文件到临时目录 → ossutil sync → 清理临时目录
    - 下行: 逐文件 ossutil cp（仅下载差异文件）

.PARAMETER Direction
    同步方向: "up" (本地→OSS) 或 "down" (OSS→本地)

.PARAMETER Yes
    跳过交互式确认，直接执行同步

.PARAMETER ListOnly
    仅列出本地图片，不执行同步

.EXAMPLE
    .\sync-images.ps1                        # 交互式模式
    .\sync-images.ps1 -Direction up -Yes     # 直接上传差异文件
    .\sync-images.ps1 -Direction down        # 交互式下载差异文件
    .\sync-images.ps1 -ListOnly              # 仅查看本地图片列表
#>

[CmdletBinding()]
param(
    [ValidateSet('up', 'down')]
    [string]$Direction,

    [Alias('y')]
    [switch]$Yes,

    [switch]$ListOnly
)

$ErrorActionPreference = 'Stop'

$RepoRoot  = Split-Path -Parent $PSScriptRoot
$OssPrefix = 'oss://math-repo/imgs/'
$ImageExts = @('.png', '.jpg', '.jpeg', '.svg', '.webp', '.gif', '.bmp')

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

function Test-IsImage($path) {
    $ext = [System.IO.Path]::GetExtension($path).ToLower()
    $ImageExts -contains $ext
}

function ConvertFrom-OssutilTime($timeStr) {
    # "2026-08-29 20:01:56 +0800 CST" → DateTime
    # 去掉 " CST" 后缀，保留 "+0800" 偏移量供解析
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
    # 返回 @{ Relative; Size; Etag; MtimeUtc } 数组，含所有文件
    # 注意: OSS 的 LastModified 是上传时间而非文件 mtime，不能用于内容比较；
    #       真正可靠的信号是 Size 与 ETag（单次上传时 ETag 即内容 MD5）。
    $output = & ossutil ls $OssPrefix 2>&1
    if ($LASTEXITCODE -ne 0) { return @() }

    $entries = @()
    foreach ($line in $output) {
        # 提取 oss:// 路径（可能含空格）
        $ossIdx = $line.IndexOf('oss://')
        if ($ossIdx -lt 0) { continue }
        $fullPath = $line.Substring($ossIdx).Trim()
        if ($fullPath.Length -le $OssPrefix.Length) { continue }
        $relative = $fullPath.Substring($OssPrefix.Length)
        if ($relative.EndsWith('/')) { continue }

        # 解析 oss:// 之前的列: LastModifiedTime Size(B) StorageClass ETAG
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
    # 判断本地文件与远程对象内容是否一致（决定是否需要传输）
    if ($null -eq $remote) { return $false }
    if ($remote.Size -ne $localSize) { return $false }
    # 分片上传的 ETag 含 '-'，无法直接比对 MD5，退化为按 size 判定
    if ($remote.Etag -notmatch '^[0-9A-Fa-f]{32}$') { return $true }
    if (-not (Test-Path -LiteralPath $localPath)) { return $false }
    $localEtag = (Get-FileHash -Algorithm MD5 -LiteralPath $localPath).Hash
    return $localEtag -eq $remote.Etag
}

function Get-LocalImageList {
    $result = @()
    foreach ($ext in $ImageExts) {
        $found = Get-ChildItem -Path $RepoRoot -Recurse -Filter "*$ext" -File -ErrorAction SilentlyContinue |
            Where-Object { $_.FullName -notlike '*\.git\*' }
        foreach ($f in $found) {
            $result += [PSCustomObject]@{
                FullName = $f.FullName
                Relative = $f.FullName.Substring($RepoRoot.Length + 1)
                Size     = $f.Length
                MtimeUtc = $f.LastWriteTimeUtc
            }
        }
    }
    $result | Sort-Object Relative | Group-Object Relative | ForEach-Object { $_.Group[0] }
}

function Get-UploadDiff($localImages, $ossFiles) {
    $remoteMap = @{}
    foreach ($e in $ossFiles) { $remoteMap[$e.Relative] = $e }

    $diff = @()
    foreach ($img in $localImages) {
        $ossKey = $img.Relative -replace '\\', '/'
        $remote = if ($remoteMap.ContainsKey($ossKey)) { $remoteMap[$ossKey] } else { $null }
        if (-not (Test-OssContentMatch $img.FullName $img.Size $remote)) {
            $diff += $img
        }
    }
    $diff
}

function Get-DownloadDiff($ossFiles, $localImages) {
    $diff = @()
    foreach ($e in $ossFiles) {
        if (-not (Test-IsImage $e.Relative)) { continue }
        $localPath = Join-Path $RepoRoot ($e.Relative -replace '/', '\')
        $localSize = if (Test-Path -LiteralPath $localPath) { (Get-Item -LiteralPath $localPath).Length } else { -1 }
        if (-not (Test-OssContentMatch $localPath $localSize $e)) {
            $diff += $e
        }
    }
    $diff
}

function Show-FileList($files, $label) {
    Write-Host "`n$label ($($files.Count) 个文件):" -ForegroundColor White
    Write-Host ("-" * 60)
    $maxDisplay = 50
    $display = if ($files.Count -gt $maxDisplay) { $files | Select-Object -First $maxDisplay } else { $files }
    foreach ($f in $display) { Write-Host "  $f" }
    if ($files.Count -gt $maxDisplay) {
        Write-Warn "  ... 还有 $($files.Count - $maxDisplay) 个文件未显示"
    }
    Write-Host ("-" * 60)
}

function Confirm-Action($message) {
    if ($Yes) { return $true }
    Write-Host "`n$message [Y/n] " -NoNewline -ForegroundColor Yellow
    $input = (Read-Host).Trim().ToLower()
    return $input -ne 'n'
}

# ── sync actions ─────────────────────────────────────────────────────────────

function Invoke-Upload {
    Write-Title "上行同步: 本地 → OSS"

    $localImages = @(Get-LocalImageList)
    if ($localImages.Count -eq 0) {
        Write-Warn "本地未找到任何图片文件"
        return
    }

    $ossFiles = @(Get-OssFileList)
    $diff = @(Get-UploadDiff $localImages $ossFiles)

    if ($diff.Count -eq 0) {
        Write-Ok "所有图片已同步，无需上传 (本地 $($localImages.Count) 个文件均与 OSS 一致)"
        return
    }

    Show-FileList ($diff | ForEach-Object { $_.Relative }) "待上传差异文件"
    Write-Host "  (本地共 $($localImages.Count) 个文件，$($diff.Count) 个有差异)"

    if (-not (Confirm-Action "确认上传以上 $($diff.Count) 个文件到 OSS？")) {
        Write-Host "已取消"
        return
    }

    # 仅复制差异文件到临时目录
    $staging = Join-Path $env:TEMP "mathrepo-img-upload-$(Get-Random)"
    New-Item -ItemType Directory -Path $staging -Force | Out-Null

    try {
        Write-Host "`n准备临时目录..." -ForegroundColor Cyan
        foreach ($img in $diff) {
            $dest = Join-Path $staging $img.Relative
            $destDir = Split-Path -Parent $dest
            if (-not (Test-Path $destDir)) {
                New-Item -ItemType Directory -Path $destDir -Force | Out-Null
            }
            Copy-Item -Path $img.FullName -Destination $dest -Force
        }

        Write-Host "同步到 OSS..." -ForegroundColor Cyan
        & ossutil sync $staging $OssPrefix -f
        $exitCode = $LASTEXITCODE
    } finally {
        Remove-Item -Path $staging -Recurse -Force -ErrorAction SilentlyContinue
    }

    if ($exitCode -eq 0) {
        Write-Ok "`n上传完成 ($($diff.Count) 个文件)"
    } else {
        Write-Err "`n上传失败 (exit code: $exitCode)"
    }
}

function Invoke-Download {
    Write-Title "下行同步: OSS → 本地"

    $ossFiles = @(Get-OssFileList)
    if ($ossFiles.Count -eq 0) {
        Write-Warn "OSS 上未找到任何文件"
        return
    }

    $localImages = @(Get-LocalImageList)
    $diff = @(Get-DownloadDiff $ossFiles $localImages)

    if ($diff.Count -eq 0) {
        Write-Ok "所有图片已同步，无需下载 (OSS 共 $(@(($ossFiles | Where-Object { Test-IsImage $_.Relative })).Count) 个图片，本地 $($localImages.Count) 个)"
        return
    }

    Show-FileList ($diff | ForEach-Object { $_.Relative }) "待下载差异文件"
    Write-Host "  (OSS 图片 $(@(($ossFiles | Where-Object { Test-IsImage $_.Relative })).Count) 个，$($diff.Count) 个有差异)"

    if (-not (Confirm-Action "确认从 OSS 下载以上 $($diff.Count) 个文件到本地？")) {
        Write-Host "已取消"
        return
    }

    $total = $diff.Count
    $success = 0
    $failed = 0

    for ($i = 0; $i -lt $total; $i++) {
        $relative = $diff[$i].Relative
        $num = $i + 1
        $destPath = Join-Path $RepoRoot ($relative -replace '/', '\')
        $destDir = Split-Path -Parent $destPath
        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }

        Write-Host "[$num/$total] $relative" -NoNewline
        & ossutil cp "$OssPrefix$relative" $destPath -f 2>&1 | Out-Null
        if ($LASTEXITCODE -eq 0) {
            Write-Ok " ✓"
            $success++
        } else {
            Write-Err " ✗"
            $failed++
        }
    }

    Write-Host "`n下载完成: $success 成功, $failed 失败" -ForegroundColor $(if ($failed -eq 0) { 'Green' } else { 'Yellow' })
}

# ── main ─────────────────────────────────────────────────────────────────────

Test-Ossutil

if ($ListOnly) {
    Write-Title "本地图片文件"
    $local = @(Get-LocalImageList)
    if ($local.Count -eq 0) {
        Write-Warn "未找到任何图片文件"
    } else {
        Show-FileList ($local | ForEach-Object { $_.Relative }) "图片文件"
    }
    exit 0
}

if ($Direction) {
    Test-OssConnection
    if ($Direction -eq 'up') { Invoke-Upload } else { Invoke-Download }
    exit $LASTEXITCODE
}

Write-Title "MathRepo 图片同步工具"
Write-Host "OSS 路径: $OssPrefix"
Write-Host "仓库根目录: $RepoRoot"
Write-Host ""
Write-Host "请选择操作:"
Write-Host "  [1] 上行 - 本地图片上传到 OSS"
Write-Host "  [2] 下行 - 从 OSS 下载图片到本地"
Write-Host "  [0] 退出"
Write-Host ""

$choice = Read-Host "请输入选项 (0/1/2)"

switch ($choice) {
    '1' { Test-OssConnection; Invoke-Upload }
    '2' { Test-OssConnection; Invoke-Download }
    '0' { Write-Host "已取消"; exit 0 }
    default { Write-Err "无效选项: $choice"; exit 1 }
}
