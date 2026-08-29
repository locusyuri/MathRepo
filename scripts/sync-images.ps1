<#
.SYNOPSIS
    MathRepo 图片与 OSS 双向同步脚本

.DESCRIPTION
    将仓库中的图片文件与阿里云 OSS 进行双向同步，保持目录结构一致。
    OSS 路径: oss://math-repo/imgs/

    同步策略:
    - 上行: 复制图片到临时目录 → ossutil sync --update → 清理临时目录
    - 下行: 逐文件 ossutil cp --update（仅下载图片，避免拉取非图片文件）
    - 比较文件大小和最后修改时间，跳过未变更的文件

.PARAMETER Direction
    同步方向: "up" (本地→OSS) 或 "down" (OSS→本地)

.PARAMETER Yes
    跳过交互式确认，直接执行同步

.PARAMETER ListOnly
    仅列出待同步文件，不执行实际操作

.EXAMPLE
    .\sync-images.ps1                        # 交互式模式
    .\sync-images.ps1 -Direction up -Yes     # 直接上传，无需确认
    .\sync-images.ps1 -Direction down        # 交互式下载
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

function Get-LocalImageList {
    $result = @()
    foreach ($ext in $ImageExts) {
        $found = Get-ChildItem -Path $RepoRoot -Recurse -Filter "*$ext" -File -ErrorAction SilentlyContinue |
            Where-Object { $_.FullName -notlike '*\.git\*' }
        foreach ($f in $found) {
            $result += [PSCustomObject]@{
                FullName = $f.FullName
                Relative = $f.FullName.Substring($RepoRoot.Length + 1)
            }
        }
    }
    $result | Sort-Object Relative | Group-Object Relative | ForEach-Object { $_.Group[0] }
}

function Get-OssImageList {
    $output = & ossutil ls $OssPrefix 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Err "查询 OSS 文件列表失败"
        return @()
    }
    $images = @()
    foreach ($line in $output) {
        $idx = $line.IndexOf('oss://')
        if ($idx -lt 0) { continue }
        $fullPath = $line.Substring($idx).Trim()
        if ($fullPath.Length -le $OssPrefix.Length) { continue }
        $relative = $fullPath.Substring($OssPrefix.Length)
        if ($relative.EndsWith('/')) { continue }
        if (Test-IsImage $relative) {
            $images += $relative
        }
    }
    $images | Sort-Object
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

    $localImages = Get-LocalImageList
    if ($localImages.Count -eq 0) {
        Write-Warn "本地未找到任何图片文件"
        return
    }

    Show-FileList ($localImages | ForEach-Object { $_.Relative }) "待上传文件"

    if (-not (Confirm-Action "确认上传以上 $($localImages.Count) 个文件到 OSS？")) {
        Write-Host "已取消"
        return
    }

    # 使用临时目录 staging，仅包含图片文件，保持目录结构
    $staging = Join-Path $env:TEMP "mathrepo-img-upload-$(Get-Random)"
    New-Item -ItemType Directory -Path $staging -Force | Out-Null

    try {
        Write-Host "`n准备临时目录..." -ForegroundColor Cyan
        foreach ($img in $localImages) {
            $dest = Join-Path $staging $img.Relative
            $destDir = Split-Path -Parent $dest
            if (-not (Test-Path $destDir)) {
                New-Item -ItemType Directory -Path $destDir -Force | Out-Null
            }
            Copy-Item -Path $img.FullName -Destination $dest -Force
        }

        Write-Host "同步到 OSS..." -ForegroundColor Cyan
        & ossutil sync $staging $OssPrefix --update -f
        $exitCode = $LASTEXITCODE
    } finally {
        Remove-Item -Path $staging -Recurse -Force -ErrorAction SilentlyContinue
    }

    if ($exitCode -eq 0) {
        Write-Ok "`n上传完成"
    } else {
        Write-Err "`n上传失败 (exit code: $exitCode)"
    }
}

function Invoke-Download {
    Write-Title "下行同步: OSS → 本地"

    $ossImages = Get-OssImageList
    if ($ossImages.Count -eq 0) {
        Write-Warn "OSS 上未找到任何图片文件"
        return
    }

    Show-FileList $ossImages "待下载文件"

    if (-not (Confirm-Action "确认从 OSS 下载以上 $($ossImages.Count) 个文件到本地？")) {
        Write-Host "已取消"
        return
    }

    $total = $ossImages.Count
    $success = 0
    $failed = 0

    for ($i = 0; $i -lt $total; $i++) {
        $relative = $ossImages[$i]
        $num = $i + 1
        $destPath = Join-Path $RepoRoot ($relative -replace '/', '\')
        $destDir = Split-Path -Parent $destPath
        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }

        Write-Host "[$num/$total] $relative" -NoNewline
        & ossutil cp "$OssPrefix$relative" $destPath --update 2>&1 | Out-Null
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
    $local = Get-LocalImageList
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
