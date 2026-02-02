<#
.SYNOPSIS
    Scans a source directory for module subdirectories, finds a specific PDF file within them,
    and copies it to a new destination directory with a new name based on the module's name.

.DESCRIPTION
    This script is designed to process a specific folder structure.
    The source directory is expected to contain category folders (e.g., '1.Analyse').
    Each category folder is expected to contain module folders (e.g., 'Analyse Mathématique').
    Each module folder is expected to have a 'tmp\initial.pdf' file.

    The script will:
    1. Iterate through each module in each category.
    2. Find the 'tmp\initial.pdf' file.
    3. Copy this PDF to a destination directory.
    4. The destination structure will mirror the categories (e.g., 'Destination\1.Analyse\').
    5. The copied file will be renamed to match its module's name (e.g., 'Analyse Mathématique.pdf').
    6. Original files and folders will not be modified.

.PARAMETER SourceRoot
    The path to the root folder containing the category subdirectories (e.g., 'C:\MyNotes'). This is a mandatory parameter.

.PARAMETER DestinationRoot
    The path to the output folder where the renamed PDFs will be saved. The script will create this folder if it doesn't exist. This is a mandatory parameter.

.EXAMPLE
    .\copy_modules.ps1 -SourceRoot "D:\Mes documents\Mathématiques" -DestinationRoot "D:\Mes documents\Mathématiques_Compilées"

    This command will scan the "D:\Mes documents\Mathématiques" directory and output the processed PDF files
    into "D:\Mes documents\Mathématiques_Compilées", preserving the category structure.
#>
[CmdletBinding()]
param ()

$SourceRoot = "C:\Users\Violet\OneDrive\Mathématiques"
$DestinationRoot = "C:\Users\Violet\OneDrive - stu.hit.edu.cn\Books\数学\ExportTex"

# --- Validation ---
# Check if the source directory exists
if (-not (Test-Path -Path $SourceRoot -PathType Container)) {
    Write-Error "Source directory not found: $SourceRoot"
    return
}

# Ensure destination root exists before copying
if (-not (Test-Path -Path $DestinationRoot -PathType Container)) {
    New-Item -Path $DestinationRoot -ItemType Directory -Force | Out-Null
}

# --- Main Processing ---
Write-Host "Starting PDF processing..."
Write-Host "Source: $SourceRoot"
Write-Host "Destination: $DestinationRoot"

# Get all category folders (e.g., 0.Mathématiques fondamentales, 1.Analyse, etc.)
$categoryFolders = Get-ChildItem -Path $SourceRoot -Directory

foreach ($categoryFolder in $categoryFolders) {
    Write-Host "`nProcessing category: $($categoryFolder.Name)"

    # Get all module folders inside the current category folder
    $moduleFolders = Get-ChildItem -Path $categoryFolder.FullName -Directory

    if ($moduleFolders.Count -eq 0) {
        Write-Warning "No module folders found in '$($categoryFolder.FullName)'."
        continue
    }

    foreach ($moduleFolder in $moduleFolders) {
        $moduleName = $moduleFolder.Name
        $initialPdfPath = Join-Path -Path $moduleFolder.FullName -ChildPath "tmp\initial.pdf"

        # Check if the 'initial.pdf' file exists
        if (Test-Path -Path $initialPdfPath -PathType Leaf) {
            # --- Destination Path Construction ---
            # 1. Define the destination category folder path
            $destinationCategoryPath = Join-Path -Path $DestinationRoot -ChildPath $categoryFolder.Name

            # 2. Create the destination category folder if it doesn't exist
            if (-not (Test-Path -Path $destinationCategoryPath -PathType Container)) {
                Write-Host "  Creating destination category folder: $destinationCategoryPath"
                New-Item -Path $destinationCategoryPath -ItemType Directory -Force | Out-Null
            }

            # 3. Define the final destination file path with the new name
            $newPdfName = "$moduleName.pdf"
            $destinationPdfPath = Join-Path -Path $destinationCategoryPath -ChildPath $newPdfName

            # --- Copy Operation ---
            Write-Host "  Found '$($initialPdfPath)'. Copying to '$($destinationPdfPath)'..."
            try {
                Copy-Item -Path $initialPdfPath -Destination $destinationPdfPath -Force -ErrorAction Stop
                Write-Host "  Successfully copied." -ForegroundColor Green
            }
            catch {
                Write-Error "  Failed to copy file for module '$moduleName'. Error: $_"
            }
        }
        else {
            Write-Warning "  'initial.pdf' not found for module '$moduleName' at path '$initialPdfPath'."
        }
    }
}

Write-Host "`nProcessing complete."

# Archive the resulting PDF-only export
$downloadsPath = Join-Path -Path $home -ChildPath "Downloads"
$zipFileName = "Mathématiques-Export_$([DateTime]::UtcNow.ToString('yyyyMMdd-HHmmss')).zip"
$zipFilePath = Join-Path -Path $downloadsPath -ChildPath $zipFileName

try {
    if (Test-Path -Path $zipFilePath) {
        Remove-Item -Path $zipFilePath -Force
    }
    Compress-Archive -Path (Join-Path -Path $DestinationRoot -ChildPath '*') -DestinationPath $zipFilePath -Force
    Write-Host "Export archive created at: $zipFilePath"
}
catch {
    Write-Error "Failed to create export archive: $_"
}
