<#
.SYNOPSIS
    MathRepo PDF 上传至 OSS 脚本

.DESCRIPTION
    将仓库中编译生成的 PDF 文件上传到阿里云 OSS，保持目录结构一致。
    OSS 路径: oss://math-repo/math/main/

    同步策略 (ossutil sync --update):
    - 比较文件大小和最后修改时间
    - 跳过大小和 mtime 均相同的文件
    - 不删除对端已不存在的文件（安全模式）

.PARAMETER Yes
    跳过交互式确认，直接执行上传

.PARAMETER ListOnly
    仅列出本地 PDF 文件，不执行上传

.EXAMPLE
    .\upload-pdfs.ps1                # 交互式模式
    .\upload-pdfs.ps1 -Yes           # 直接上传，无需确认
    .\upload-pdfs.ps1 -ListOnly      # 仅查看 PDF 列表
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

function Get-LocalPdfs {
    Get-ChildItem -Path $RepoRoot -Recurse -Filter '*.pdf' -File -ErrorAction SilentlyContinue |
        Where-Object { $_.FullName -notlike '*\.git\*' } |
        Sort-Object FullName
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

# ── main ─────────────────────────────────────────────────────────────────────

Test-Ossutil

# ListOnly
if ($ListOnly) {
    Write-Title "本地 PDF 文件"
    $local = Get-LocalPdfs
    if ($local.Count -eq 0) {
        Write-Warn "未找到任何 PDF 文件"
    } else {
        $relativePaths = $local | ForEach-Object { $_.FullName.Replace("$RepoRoot\", '') }
        Show-FileList $relativePaths "PDF 文件"
    }
    exit 0
}

# 参数模式: -Yes 直接上传
if ($Yes) {
    Test-OssConnection
    $localFiles = Get-LocalPdfs
    if ($localFiles.Count -eq 0) {
        Write-Warn "本地未找到任何 PDF 文件"
        exit 0
    }
    Write-Host "`n开始上传 $($localFiles.Count) 个 PDF 文件..." -ForegroundColor Cyan
    & ossutil sync $RepoRoot $OssPrefix --update -f
    if ($LASTEXITCODE -eq 0) {
        Write-Ok "`n上传完成"
    } else {
        Write-Err "`n上传失败 (exit code: $LASTEXITCODE)"
        exit 1
    }
    exit 0
}

# 交互式模式
Write-Title "MathRepo PDF 上传工具"
Write-Host "OSS 路径: $OssPrefix"
Write-Host "仓库根目录: $RepoRoot"

Test-OssConnection

$localFiles = Get-LocalPdfs
if ($localFiles.Count -eq 0) {
    Write-Warn "`n本地未找到任何 PDF 文件"
    exit 0
}

$relativePaths = $localFiles | ForEach-Object { $_.FullName.Replace("$RepoRoot\", '') }
Show-FileList $relativePaths "待上传 PDF"

if (-not (Confirm-Action "确认上传以上 $($relativePaths.Count) 个 PDF 文件到 OSS？")) {
    Write-Host "已取消"
    exit 0
}

Write-Host "`n开始上传..." -ForegroundColor Cyan
& ossutil sync $RepoRoot $OssPrefix --update -f
if ($LASTEXITCODE -eq 0) {
    Write-Ok "`n上传完成"
} else {
    Write-Err "`n上传失败 (exit code: $LASTEXITCODE)"
    exit 1
}
