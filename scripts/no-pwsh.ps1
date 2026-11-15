<#
.SYNOPSIS
    MathRepo 万能任务脚本 —— 一键执行编译、出图、校验、分发与状态查看。

.DESCRIPTION
    交互式：  .\scripts\no-pwsh.ps1
    参数式：  .\scripts\no-pwsh.ps1 -Task build
              .\scripts\no-pwsh.ps1 -Task build -Note "2.Algèbre/Théorie des Nombres"
              .\scripts\no-pwsh.ps1 -Task publish -Yes

    任务：
      build    编译每本笔记的 initial.typ（默认全部，-Note 限定一本）
      images   重新生成插图（默认只补缺失，-Overwrite 全量覆盖）
      check    静态校验 Typst 附件（只报告，-Fix 自动修可机械项）
      migrate  PDF 按 <学科>/<笔记>.pdf 复制到本地目标目录
      upload   PDF 上传到 oss://math-repo/math/main/
      publish  编译 → 归类 → 上传（一键发布）
      status   查看笔记数、已编译数与 git 状态

    为什么合并成一个脚本而不是散着：仓库根、笔记枚举、日志目录、退出码语义它们全共用，
    抄 N 份必然漂移。扩展方式 = 写一个 Invoke-Xxx 函数 + 在 $Tasks 里加一行，菜单自动出现。

.PARAMETER Task
    要执行的任务键；省略则弹出交互菜单（有 fzf 走 fzf，否则数字菜单）。

.PARAMETER Note
    build / images 的作用范围，形如 "3.Géométrie/Géométrie Analytique"。省略即全仓库。

.PARAMETER Overwrite
    images 任务全量重出（默认只补缺失，避免无意义的重算与无 diff 的等待）。

.PARAMETER Fix
    check 任务写回可机械推导的替换（paren / brace）；macro 类仍只报告，需人工改写。

.PARAMETER Yes
    跳过二次确认，供脚本 / CI 调用。⛔ 对外动作（OSS 上传）仍会照常执行。

.EXAMPLE
    .\scripts\no-pwsh.ps1

.EXAMPLE
    .\scripts\no-pwsh.ps1 -Task build -Note "1.Analyse/Analyse Complexe"

.EXAMPLE
    .\scripts\no-pwsh.ps1 -Task publish -Yes

.NOTES
    日志：logs/<任务>-<yyyyMMdd-HHmmss>.log（⛔ logs/ 已进 .gitignore）
    PDF 与插图都不入库；图片可由 images 任务随时重建。
    脚本位于 scripts/ 下，仓库根 = 上跳一级；所以子脚本的根推导比它各自单独运行时要少想一层。
    文档：scripts/README.md、wiki/spec/BUILD.md
#>

[CmdletBinding()]
param(
    [ValidateSet('build', 'images', 'check', 'migrate', 'upload', 'publish', 'status')]
    [Alias('t')]
    [string]$Task,

    [string]$Note,

    [switch]$Overwrite,

    [switch]$Fix,

    [Alias('y')]
    [switch]$Yes
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
# native 命令的退出码由本脚本自己判断，别让它抛异常（PS 7.4+ 可能默认开启）
if (Test-Path variable:PSNativeCommandUseErrorActionPreference) {
    $PSNativeCommandUseErrorActionPreference = $false
}

$RepoRoot = Split-Path -Parent $PSScriptRoot     # 脚本在 scripts/ 下 → 上跳一级到仓库根
$LogDir = Join-Path $RepoRoot 'logs'

# 唯一任务注册表：扩展只改这里
$Tasks = [ordered]@{
    build   = @{ Title = '编译笔记（全部 / -Note 限定一本）'; Action = { Invoke-Build } }
    images  = @{ Title = '生成插图（默认只补缺失）';           Action = { Invoke-Images } }
    check   = @{ Title = '静态校验（只报告）';                 Action = { Invoke-Check } }
    migrate = @{ Title = 'PDF 本地归类';                       Action = { Invoke-Migrate } }
    upload  = @{ Title = 'PDF 上传 OSS';                       Action = { Invoke-Upload } }
    publish = @{ Title = '发布（编译 → 归类 → 上传）';         Action = { Invoke-Publish } }
    status  = @{ Title = '查看仓库状态';                       Action = { Invoke-Status } }
}

# ── 输出 ────────────────────────────────────────────────────────────────────

function Write-Section([string]$Text) { Write-Host "`n$Text" -ForegroundColor Cyan }
function Write-Step([string]$Text)    { Write-Host "  → $Text" -ForegroundColor DarkGray }
function Write-Ok([string]$Text)      { Write-Host "  ✓ $Text" -ForegroundColor Green }
function Write-Note([string]$Text)    { Write-Host "  · $Text" -ForegroundColor Yellow }
function Write-Bad([string]$Text)     { Write-Host "  ✗ $Text" -ForegroundColor Red }

# 中文标题按 2 字符宽计算，否则数字菜单必然错位
function Get-DisplayWidth([string]$Text) {
    $width = 0
    foreach ($ch in $Text.ToCharArray()) {
        $code = [int]$ch
        if (($code -ge 0x1100 -and $code -le 0x115F) -or
            ($code -ge 0x2E80 -and $code -le 0xA4CF) -or
            ($code -ge 0xAC00 -and $code -le 0xD7A3) -or
            ($code -ge 0xF900 -and $code -le 0xFAFF) -or
            ($code -ge 0xFE30 -and $code -le 0xFE6F) -or
            ($code -ge 0xFF00 -and $code -le 0xFF60) -or
            ($code -ge 0xFFE0 -and $code -le 0xFFE6)) {
            $width += 2
        } else {
            $width += 1
        }
    }
    return $width
}

function Confirm-Action([string]$Message) {
    if ($Yes) { Write-Note '已跳过确认（-Yes）'; return $true }
    $answer = (Read-Host "$Message [y/N]").Trim().ToLower()
    return ($answer -in @('y', 'yes'))
}

# 聚合任务（publish）已经确认过一次，子任务不再重复问
$script:ChildAuto = $false

function Assert-Command([string]$Name, [string]$Hint) {
    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "未找到 $Name —— $Hint"
    }
}

# ── 菜单 ────────────────────────────────────────────────────────────────────

function Show-Menu {
    if (Get-Command fzf -ErrorAction SilentlyContinue) { return Show-MenuFzf }
    return Show-MenuNumbered
}

function Show-MenuFzf {
    # 第一列必须是任务键（后面回解析要用），标题在后
    $lines = @($Tasks.Keys | ForEach-Object { '{0,-14} {1}' -f $_, $Tasks[$_].Title })
    $chosen = ($lines -join "`n") | fzf --height=60% --layout=reverse --cycle `
        --prompt='任务 > ' --header='Enter=执行  Esc=取消'
    if (-not $chosen) { return '' }
    return ($chosen -split '\s+')[0]
}

function Show-MenuNumbered {
    Write-Section 'MathRepo 任务脚本'
    $keys = @($Tasks.Keys)
    for ($i = 0; $i -lt $keys.Count; $i++) {
        $title = $Tasks[$keys[$i]].Title
        $pad = ' ' * [math]::Max(1, 38 - (Get-DisplayWidth $title))
        Write-Host ('  {0}. {1}{2}[{3}]' -f ($i + 1), $title, $pad, $keys[$i])
    }
    Write-Host '  0. 退出'
    $sel = Read-Host '请选择'
    if ([string]::IsNullOrWhiteSpace($sel) -or $sel -eq '0') { return '' }
    $idx = 0
    if ([int]::TryParse($sel, [ref]$idx) -and $idx -ge 1 -and $idx -le $keys.Count) { return $keys[$idx - 1] }
    if ($Tasks.Contains($sel)) { return $sel }
    Write-Bad "无效选择：$sel"
    return ''
}

# ── 笔记枚举 ────────────────────────────────────────────────────────────────

function Get-NoteLabel($TypFile) {
    $note = $TypFile.Directory
    return ('{0}/{1}' -f $note.Parent.Name, $note.Name)
}

function Get-TargetNotes {
    # <学科>/<笔记>/initial.typ 恰好三层，tmp/ 下的副本与 TypstTemplate 都不会命中
    $notes = @(Get-ChildItem -Path (Join-Path $RepoRoot '*\*\initial.typ') -File | Sort-Object FullName)
    if ($Note) {
        $key = $Note.Replace('\', '/').Trim('/')
        $notes = @($notes | Where-Object { (Get-NoteLabel $_) -eq $key })
        if ($notes.Count -eq 0) { throw "没有找到笔记：$Note" }
    }
    return $notes
}

# ── 任务 ────────────────────────────────────────────────────────────────────

function Invoke-Build {
    Assert-Command typst '安装见 https://typst.app/'
    $notes = @(Get-TargetNotes)
    Write-Section ('任务：编译 {0} 本笔记' -f $notes.Count)

    $failed = @()
    foreach ($typ in $notes) {
        $rel = Get-NoteLabel $typ
        $pdf = Join-Path $typ.Directory.FullName 'initial.pdf'
        & typst compile $typ.FullName $pdf --root $RepoRoot
        if ($LASTEXITCODE -eq 0) { Write-Ok $rel } else { Write-Bad "$rel 编译失败"; $failed += $rel }
    }

    if ($failed.Count -gt 0) {
        throw ('{0} 本编译失败：{1}' -f $failed.Count, ($failed -join '、'))
    }
    Write-Ok ('全部 {0} 本编译通过' -f $notes.Count)
}

function Invoke-Images {
    Assert-Command uv '安装见 https://docs.astral.sh/uv/'
    $mode = '只补缺失'
    if ($Overwrite) { $mode = '全量覆盖' }
    Write-Section "任务：生成插图（$mode）"

    if (-not (Confirm-Action '确认开始生成插图？')) { Write-Note '已取消'; return }

    $cli = @('run', 'scripts/images/build-images.py')
    if ($Overwrite) { $cli += '--overwrite' } else { $cli += '--skip-existing' }
    if ($Note) { $cli += @('--note', $Note) }

    & uv @cli
    if ($LASTEXITCODE -ne 0) { throw "插图生成失败（退出码 $LASTEXITCODE），失败脚本见上方输出" }
    Write-Ok '插图生成完成'
}

function Invoke-Check {
    Assert-Command uv '安装见 https://docs.astral.sh/uv/'
    Write-Section '任务：静态校验 Typst 附件'

    $cli = @('run', 'scripts/check/check-typst-attachments.py', '--summary')
    if ($Fix) { $cli += '--fix' }

    & uv @cli
    $code = $LASTEXITCODE
    if ($code -eq 0) {
        Write-Ok '无命中'
    } else {
        # 有命中不是工具失败，是待办；退出码保留在提示里便于 CI 判断
        Write-Note "有命中（退出码 $code）；-Fix 只改可机械项，修完请不带 -Fix 再复核一次"
    }
}

function Invoke-Migrate {
    $ps1 = Join-Path $RepoRoot 'scripts/pdf/migrate-pdfs.ps1'
    Write-Section '任务：PDF 本地归类'
    if ($Yes -or $script:ChildAuto) { & $ps1 -Yes } else { & $ps1 }
    if ($LASTEXITCODE -ne 0) { throw "PDF 归类失败（退出码 $LASTEXITCODE）" }
}

function Invoke-Upload {
    $ps1 = Join-Path $RepoRoot 'scripts/pdf/upload-pdfs.ps1'
    Write-Section '任务：PDF 上传 OSS'
    if ($Yes -or $script:ChildAuto) { & $ps1 -Yes } else { & $ps1 }
    if ($LASTEXITCODE -ne 0) { throw "PDF 上传失败（退出码 $LASTEXITCODE）" }
    Write-Ok '上传完成'
}

function Invoke-Publish {
    Write-Section '任务：发布（编译 → 归类 → 上传）'
    if (-not (Confirm-Action '确认编译全部笔记并把 PDF 上传到 OSS？')) { Write-Note '已取消'; return }

    $script:ChildAuto = $true
    try {
        Invoke-Build
        Invoke-Migrate
        Invoke-Upload
    }
    finally {
        $script:ChildAuto = $false
    }
    Write-Ok '发布完成'
}

function Get-ImageSummary {
    # 复用 build-images.py 的 --dry-run：它会解析 .typ 引用与脚本输出声明，
    # 统计口径只有一处实现，避免这里再写一遍正则。
    $out = & uv run scripts/images/build-images.py --dry-run 2>&1
    $lines = @($out | Where-Object { $_ -match '张插图；已存在' })
    if ($lines.Count -eq 0) { return $null }
    if ($lines[-1] -match '(\d+)\s*张插图；已存在\s*(\d+)，缺失\s*(\d+)') {
        return [PSCustomObject]@{
            Total   = [int]$Matches[1]
            Present = [int]$Matches[2]
            Missing = [int]$Matches[3]
        }
    }
    return $null
}

function Invoke-Status {
    Write-Section '仓库状态'

    $notes = @(Get-ChildItem -Path (Join-Path $RepoRoot '*\*\initial.typ') -File)
    $missing = @($notes | Where-Object { -not (Test-Path (Join-Path $_.Directory.FullName 'initial.pdf')) } |
        ForEach-Object { Get-NoteLabel $_ })

    Write-Note ('笔记 {0} 本，已编译 {1} 本' -f $notes.Count, ($notes.Count - $missing.Count))
    if ($missing.Count -gt 0) { Write-Note ('未编译：{0}' -f ($missing -join '、')) }

    if (Get-Command git -ErrorAction SilentlyContinue) {
        $branch = & git rev-parse --abbrev-ref HEAD 2>$null
        $dirty = @(& git status --porcelain).Count
        Write-Note ('分支 {0}，未提交改动 {1} 项' -f $branch, $dirty)
    }

    if (Get-Command uv -ErrorAction SilentlyContinue) {
        Write-Step '统计插图…'
        $images = Get-ImageSummary
        if ($null -eq $images) {
            Write-Bad '插图统计失败，可单独运行 .\scripts\images\build-images.ps1 -DryRun 查看'
        } elseif ($images.Missing -eq 0) {
            Write-Ok ('插图 {0} 张，全部就绪' -f $images.Total)
        } else {
            Write-Note ('插图 {0} 张，缺失 {1} 张（已存在 {2}）' -f $images.Total, $images.Missing, $images.Present)
        }
    } else {
        Write-Bad '未找到 uv，跳过插图统计'
    }
}

# ── 入口 ────────────────────────────────────────────────────────────────────

$target = if ([string]::IsNullOrWhiteSpace($Task)) { Show-Menu } else { $Task }
# ⚠ 不要回写 $Task：ValidateSet 对后续赋值同样生效，空值会报错
if ([string]::IsNullOrWhiteSpace($target)) { return }

$null = New-Item -ItemType Directory -Force -Path $LogDir
$logFile = Join-Path $LogDir ('{0}-{1}.log' -f $target, (Get-Date -Format 'yyyyMMdd-HHmmss'))
Start-Transcript -Path $logFile -Force | Out-Null

Push-Location $RepoRoot
try {
    & $Tasks[$target].Action
} catch {
    Write-Bad $_.Exception.Message
    Write-Note "完整日志：$logFile"
    exit 1
} finally {
    Pop-Location
    Stop-Transcript | Out-Null
}
