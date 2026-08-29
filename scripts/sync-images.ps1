<#
.SYNOPSIS
    MathRepo 图片与 OSS 双向同步脚本

.DESCRIPTION
    将仓库中的图片文件与阿里云 OSS 进行双向同步，保持目录结构一致。
    OSS 路径: oss://math-repo/imgs/

    同步策略 (ossutil sync --update):
    - 比较文件大小和最后修改时间
    - 跳过大小和 mtime 均相同的文件
    - 不删除对端已不存在的文件（安全模式）

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

$RepoRoot    = $PSScriptRoot
$OssPrefix   = 'oss://math-repo/imgs/'
$ImageExts   = @('.png', '.jpg', '.jpeg', '.svg', '.webp', '.gif', '.bmp')

# ── helpers ──────────────────────────────────────────────────────────────────

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

function Get-LocalImages {
    $files = @()
    foreach ($ext in $ImageExts) {
        $found = Get-ChildItem -Path $RepoRoot -Recurse -Filter "*$ext" -File -ErrorAction SilentlyContinue |
            Where-Object { $_.FullName -notlike '*\.git\*' }
        $files += $found
    }
    $files | Sort-Object FullName | Get-Unique -AsString
}

function Get-OssImages {
    $output = & ossutil ls $OssPrefix 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Err "查询 OSS 文件列表失败"
        return @()
    }

    $images = @()
    foreach ($line in $output) {
        # 从每行末尾提取 oss:// 路径（完整输出格式: LastModifiedTime Size StorageClass ETAG ObjectName）
        if ($line -match '(oss://\S+)$') {
            $fullPath = $Matches[1]
            if ($fullPath.Length -le $OssPrefix.Length) { continue }
            $relative = $fullPath.Substring($OssPrefix.Length)
            # 跳过目录标记（以 / 结尾）
            if ($relative.EndsWith('/')) { continue }
            $ext = [System.IO.Path]::GetExtension($relative).ToLower()
            if ($ImageExts -contains $ext) {
                $images += $relative
            }
        }
    }
    $images | Sort-Object
}

function Show-FileList($files, $label) {
    Write-Host "`n$label ($($files.Count) 个文件):" -ForegroundColor White
    Write-Host ("-" * 60)
    $maxDisplay = 50
    $display = if ($files.Count -gt $maxDisplay) { $files | Select-Object -First $maxDisplay } else { $files }
    foreach ($f in $display) {
        Write-Host "  $f"
    }
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

    $localFiles = Get-LocalImages
    if ($localFiles.Count -eq 0) {
        Write-Warn "本地未找到任何图片文件"
        return
    }

    $relativePaths = $localFiles | ForEach-Object { $_.FullName.Replace("$RepoRoot\", '') }
    Show-FileList $relativePaths "待上传文件"

    if (-not (Confirm-Action "确认上传以上 $($relativePaths.Count) 个文件到 OSS？")) {
        Write-Host "已取消"
        return
    }

    Write-Host "`n开始上传..." -ForegroundColor Cyan
    & ossutil sync $RepoRoot $OssPrefix --update -f
    $exitCode = $LASTEXITCODE

    if ($exitCode -eq 0) {
        Write-Ok "`n上传完成"
    } else {
        Write-Err "`n上传失败 (exit code: $exitCode)"
    }
}

function Invoke-Download {
    Write-Title "下行同步: OSS → 本地"

    $ossFiles = Get-OssImages
    if ($ossFiles.Count -eq 0) {
        Write-Warn "OSS 上未找到任何图片文件"
        return
    }

    Show-FileList $ossFiles "待下载文件"

    if (-not (Confirm-Action "确认从 OSS 下载以上 $($ossFiles.Count) 个文件到本地？")) {
        Write-Host "已取消"
        return
    }

    Write-Host "`n开始下载..." -ForegroundColor Cyan
    & ossutil sync $OssPrefix $RepoRoot --update -f
    $exitCode = $LASTEXITCODE

    if ($exitCode -eq 0) {
        Write-Ok "`n下载完成"
    } else {
        Write-Err "`n下载失败 (exit code: $exitCode)"
    }
}

# ── main ─────────────────────────────────────────────────────────────────────

Test-Ossutil

# ListOnly: 仅列出本地图片
if ($ListOnly) {
    Write-Title "本地图片文件"
    $local = Get-LocalImages
    if ($local.Count -eq 0) {
        Write-Warn "未找到任何图片文件"
    } else {
        Show-FileList ($local | ForEach-Object { $_.FullName.Replace("$RepoRoot\", '') }) "图片文件"
    }
    exit 0
}

# 参数模式: 已指定 Direction
if ($Direction) {
    Test-OssConnection
    if ($Direction -eq 'up') {
        Invoke-Upload
    } else {
        Invoke-Download
    }
    exit $LASTEXITCODE
}

# 交互式模式
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
    '1' {
        Test-OssConnection
        Invoke-Upload
    }
    '2' {
        Test-OssConnection
        Invoke-Download
    }
    '0' {
        Write-Host "已取消"
        exit 0
    }
    default {
        Write-Err "无效选项: $choice"
        exit 1
    }
}
