param(
  [Parameter(ValueFromPipeline = $true)]
  [string[]]$Files
)

# LaTeX patterns that should NOT appear in Typst math mode
$latexPatterns = @(
  @{ Pattern = '\\mathbb\{';    Suggestion = 'bb(' }
  @{ Pattern = '\\mathcal\{';   Suggestion = 'cal(' }
  @{ Pattern = '\\mathscr\{';   Suggestion = 'scr(' }
  @{ Pattern = '\\mathfrak\{';  Suggestion = 'frak(' }
  @{ Pattern = '\\mathrm\{';    Suggestion = 'dif or direct text' }
  @{ Pattern = '\\text\{';      Suggestion = 'text("...") with quotes' }
  @{ Pattern = '\\subseteq';    Suggestion = 'subset.eq' }
  @{ Pattern = '\\supseteq';    Suggestion = 'supset.eq' }
  @{ Pattern = '\\subsetneq';   Suggestion = 'subset.ne' }
  @{ Pattern = '\\cup';         Suggestion = 'union' }
  @{ Pattern = '\\cap';         Suggestion = 'inter' }
  @{ Pattern = '\\infty';       Suggestion = 'oo' }
  @{ Pattern = '\\int';         Suggestion = 'integral' }
  @{ Pattern = '\\iint';        Suggestion = 'integral.double' }
  @{ Pattern = '\\iiint';       Suggestion = 'integral.triple' }
  @{ Pattern = '\\oint';        Suggestion = 'integral.cont' }
  @{ Pattern = '\\cdot';        Suggestion = 'dot' }
  @{ Pattern = '\\sim';         Suggestion = '~ 或 approx' }
  @{ Pattern = '\\to\b';        Suggestion = '->' }
  @{ Pattern = '\\rightarrow';  Suggestion = '->' }
  @{ Pattern = '\\Rightarrow';  Suggestion = '=>' }
  @{ Pattern = '\\Leftrightarrow'; Suggestion = '<=>' }
  @{ Pattern = '\\notin';       Suggestion = 'in.not' }
  @{ Pattern = '\\neq';         Suggestion = '!=' }
  @{ Pattern = '\\setminus';    Suggestion = 'backslash' }
  @{ Pattern = '\\backslash';   Suggestion = 'backslash' }
  @{ Pattern = '\\oplus';       Suggestion = 'plus.o' }
  @{ Pattern = '\\preceq';      Suggestion = 'prec.eq' }
  @{ Pattern = '\\partial';     Suggestion = 'partial (no backslash)' }
  @{ Pattern = '\\nabla';       Suggestion = 'nabla (no backslash)' }
  @{ Pattern = '\\ell';         Suggestion = 'ell (no backslash)' }
  @{ Pattern = '\\hbar';        Suggestion = 'hbar (check docs)' }
  @{ Pattern = '\\left\b';      Suggestion = 'remove \left, Typst auto-scales' }
  @{ Pattern = '\\right\b';     Suggestion = 'remove \right, Typst auto-scales' }
  @{ Pattern = '\\ll\b';        Suggestion = '<<' }
  @{ Pattern = '\\gg\b';        Suggestion = '>>' }
  @{ Pattern = '\\circ';        Suggestion = 'compose' }
  @{ Pattern = '\\forall';      Suggestion = 'forall (no backslash)' }
  @{ Pattern = '\\exists';      Suggestion = 'exists (no backslash)' }
  @{ Pattern = '\\lnot';        Suggestion = 'not (no backslash)' }
  @{ Pattern = '\\land';        Suggestion = 'and (no backslash)' }
  @{ Pattern = '\\lor';         Suggestion = 'or (no backslash)' }
  @{ Pattern = '\\chi\b';       Suggestion = 'chi (no backslash)' }
  @{ Pattern = '\\sigma\b';     Suggestion = 'sigma (no backslash)' }
  @{ Pattern = '\\delta\b';     Suggestion = 'delta (no backslash)' }
  @{ Pattern = '\\epsilon\b';   Suggestion = 'epsilon (no backslash)' }
  @{ Pattern = '\\varphi\b';    Suggestion = 'varphi (no backslash)' }
  @{ Pattern = '\\omega\b';     Suggestion = 'omega (no backslash)' }
  @{ Pattern = '\\alpha\b';     Suggestion = 'alpha (no backslash)' }
  @{ Pattern = '\\beta\b';      Suggestion = 'beta (no backslash)' }
  @{ Pattern = '\\gamma\b';     Suggestion = 'gamma (no backslash)' }
  @{ Pattern = '\\lambda\b';    Suggestion = 'lambda (no backslash)' }
  @{ Pattern = '\\mu\b';        Suggestion = 'mu (no backslash)' }
  @{ Pattern = '\\pi\b';        Suggestion = 'pi (no backslash)' }
  @{ Pattern = '\\theta\b';     Suggestion = 'theta (no backslash)' }
  @{ Pattern = '\\infty';       Suggestion = 'oo' }
)

$filesToCheck = @()
if ($Files -and $Files.Count -gt 0 -and $Files[0]) {
  $filesToCheck = $Files | ForEach-Object {
    if ($_ -match '\.typ$') {
      Get-Item $_ -ErrorAction SilentlyContinue
    }
  } | Where-Object { $_ -ne $null }
}
else {
  # Find recently modified .typ files
  $filesToCheck = Get-ChildItem -Recurse -Filter '*.typ' -Path (Get-Location).Path |
    Where-Object { $_.LastWriteTime -gt (Get-Date).AddMinutes(-5) }
}

if ($filesToCheck.Count -eq 0) {
  # No .typ files modified, skip
  exit 0
}

$hasErrors = $false
$errors = @()

foreach ($file in $filesToCheck) {
  $content = Get-Content -Path $file.FullName -Raw 2>$null
  if (-not $content) { continue }

  $lines = $content -split "`n"

  for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]

    # Skip comment lines
    if ($line -match '^\s*//') { continue }

    # Skip lines that are entirely inside comments (after //)
    $codePart = $line
    if ($codePart -match '(?<!:)(//)') {
      $codePart = $codePart -replace '(?<!:)(//).*$', ''
    }

    foreach ($lp in $latexPatterns) {
      if ($codePart -match $lp.Pattern) {
        $hasErrors = $true
        $errors += @{
          File    = $file.FullName
          Line    = $i + 1
          Text    = $line.Trim()
          Pattern = $lp.Pattern -replace '\\', '\\'
          Fix     = $lp.Suggestion
        }
      }
    }
  }
}

if ($hasErrors) {
  Write-Output "## Typst LaTeX Syntax Errors Detected"
  Write-Output ""
  Write-Output "The following lines contain LaTeX macros that are invalid in Typst:"
  Write-Output ""

  $grouped = $errors | Group-Object File
  foreach ($group in $grouped) {
    Write-Output "**$($group.Name):**"
    foreach ($err in $group.Group) {
      Write-Output ("- Line $($err.Line): " + $err.Text + " -> use " + $err.Fix + " instead of " + $err.Pattern)
    }
    Write-Output ""
  }

  Write-Output "---"
  Write-Output "Please fix these errors to ensure the file compiles correctly."

  exit 2
}

exit 0
