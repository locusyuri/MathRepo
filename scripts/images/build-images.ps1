<#
.SYNOPSIS
    Regenerate the figures of every note from the matplotlib scripts.

.DESCRIPTION
    Thin wrapper around scripts/images/build-images.py.  Without switches it runs in
    interactive mode: it previews which images already exist and which will be
    produced, then asks whether to overwrite them or to skip them.

.PARAMETER Note
    Restrict the run to one note, e.g. "3.Géométrie/Géométrie Analytique".

.PARAMETER Overwrite
    Rebuild every image, overwriting the files that already exist.

.PARAMETER SkipExisting
    Only fill in the missing images, leaving the existing ones untouched.

.PARAMETER DryRun
    Preview only; no script is executed.

.PARAMETER Verbose
    List every image together with the script that produces it.

.EXAMPLE
    .\scripts\images\build-images.ps1

.EXAMPLE
    .\scripts\images\build-images.ps1 -DryRun

.EXAMPLE
    .\scripts\images\build-images.ps1 -Overwrite

.EXAMPLE
    .\scripts\images\build-images.ps1 -Note "3.Géométrie/Géométrie Analytique" -SkipExisting
#>
param(
    [string]$Note,
    [switch]$Overwrite,
    [switch]$SkipExisting,
    [switch]$DryRun,
    [switch]$Verbose
)

$ErrorActionPreference = 'Stop'

if ($Overwrite -and $SkipExisting) {
    throw 'Use either -Overwrite or -SkipExisting, not both.'
}

if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    throw 'uv was not found in PATH; install it from https://docs.astral.sh/uv/ first.'
}

$repo = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$cli = @('run', 'scripts/images/build-images.py')
if ($DryRun)       { $cli += '--dry-run' }
if ($Overwrite)    { $cli += '--overwrite' }
if ($SkipExisting) { $cli += '--skip-existing' }
if ($Note)         { $cli += @('--note', $Note) }
if ($Verbose)      { $cli += '--verbose' }

Push-Location $repo
$code = 0
try {
    Write-Host ("uv " + ($cli -join ' ')) -ForegroundColor DarkGray
    & uv @cli
    $code = $LASTEXITCODE
}
finally {
    Pop-Location
}

exit $code
