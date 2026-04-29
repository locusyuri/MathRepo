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
    4. The destination folder will be cleared before export starts.
    5. The destination structure will mirror the categories (e.g., 'Destination\1.Analyse\').
    6. The copied file will be renamed to match its module's name (e.g., 'Analyse Mathématique.pdf').
    7. Original source files and folders will not be modified.

.PARAMETER SourceRoot
    The path to the root folder containing the category subdirectories (e.g., 'C:\MyNotes'). This is a mandatory parameter.

.PARAMETER DestinationRoot
    The path to the output folder where the renamed PDFs will be saved. The script will create this folder if it doesn't exist,
    then clear its existing contents before copying. This is a mandatory parameter.

.EXAMPLE
    .\copy_modules.ps1 -SourceRoot "D:\Mes documents\Mathématiques" -DestinationRoot "D:\Mes documents\Mathématiques_Compilées"

    This command will scan the "D:\Mes documents\Mathématiques" directory and output the processed PDF files
    into "D:\Mes documents\Mathématiques_Compilées", preserving the category structure.
#>
[CmdletBinding()]
param ()

Add-Type -AssemblyName System.Windows.Forms

$SourceRoot = "C:\Users\Violet\OneDrive\Notiz\Mathématiques"
$DestinationRoot = "C:\Users\Violet\WPSDrive\1774341244\WPS企业云盘\哈尔滨工业大学\我的企业文档\PDF\Mathématiques"

function Show-PdfChoiceDialog {
    param(
        [string]$ModuleName,
        [string]$RootPdfPath,
        [string]$TmpPdfPath
    )
    
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "PDF 冲突选择"
    $form.Width = 450
    $form.Height = 200
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedDialog"
    $form.MaximizeBox = $false
    $form.MinimizeBox = $false
    
    $label = New-Object System.Windows.Forms.Label
    $label.Text = "模块 ""$ModuleName"" 中发现多个 PDF 文件，请选择要导出的版本："
    $label.Location = New-Object System.Drawing.Point(20, 20)
    $label.AutoSize = $true
    
    $rootRadio = New-Object System.Windows.Forms.RadioButton
    $rootRadio.Text = "模块根目录: $RootPdfPath"
    $rootRadio.Location = New-Object System.Drawing.Point(30, 55)
    $rootRadio.AutoSize = $true
    $rootRadio.Checked = $true
    
    $tmpRadio = New-Object System.Windows.Forms.RadioButton
    $tmpRadio.Text = "tmp 目录: $TmpPdfPath"
    $tmpRadio.Location = New-Object System.Drawing.Point(30, 80)
    $tmpRadio.AutoSize = $true
    
    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Text = "确定"
    $okButton.Location = New-Object System.Drawing.Point(170, 115)
    $okButton.DialogResult = "OK"
    $form.AcceptButton = $okButton
    
    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelButton.Text = "取消导出"
    $cancelButton.Location = New-Object System.Drawing.Point(250, 115)
    $cancelButton.DialogResult = "Cancel"
    $form.CancelButton = $cancelButton
    
    $form.Controls.AddRange(@($label, $rootRadio, $tmpRadio, $okButton, $cancelButton))
    
    $result = $form.ShowDialog()
    
    if ($result -eq "OK") {
        if ($rootRadio.Checked) { return $RootPdfPath }
        else { return $TmpPdfPath }
    }
    return $null
}

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

# Clear destination root before exporting to avoid stale files
$destinationItems = Get-ChildItem -Path $DestinationRoot -Force -ErrorAction SilentlyContinue
if ($destinationItems) {
    Write-Host "Clearing destination folder: $DestinationRoot"
    Remove-Item -Path $destinationItems.FullName -Recurse -Force -ErrorAction Stop
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
        
        # 检查两个可能位置的 PDF 文件
        $rootPdfPath = Join-Path -Path $moduleFolder.FullName -ChildPath "initial.pdf"
        $tmpPdfPath = Join-Path -Path $moduleFolder.FullName -ChildPath "tmp\initial.pdf"
        
        $rootPdfExists = Test-Path -Path $rootPdfPath -PathType Leaf
        $tmpPdfExists = Test-Path -Path $tmpPdfPath -PathType Leaf
        
        # 确定要复制的 PDF 路径
        $pdfToCopy = $null
        if ($rootPdfExists -and $tmpPdfExists) {
            # 两者都存在，弹出选择框
            Write-Host "  检测到冲突：模块 '$moduleName' 在根目录和 tmp 目录都有 PDF 文件。"
            $pdfToCopy = Show-PdfChoiceDialog -ModuleName $moduleName -RootPdfPath $rootPdfPath -TmpPdfPath $tmpPdfPath
            if ($null -eq $pdfToCopy) {
                Write-Host "  用户取消导出，跳过此模块。" -ForegroundColor Yellow
                continue
            }
        }
        elseif ($rootPdfExists) {
            $pdfToCopy = $rootPdfPath
        }
        elseif ($tmpPdfExists) {
            $pdfToCopy = $tmpPdfPath
        }
        else {
            Write-Warning "  模块 '$moduleName' 中未找到 'initial.pdf' 文件。"
            continue
        }
        
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
        Write-Host "  Found '$pdfToCopy'. Copying to '$destinationPdfPath'..."
        try {
            Copy-Item -Path $pdfToCopy -Destination $destinationPdfPath -Force -ErrorAction Stop
            Write-Host "  Successfully copied." -ForegroundColor Green
        }
        catch {
            Write-Error "  Failed to copy file for module '$moduleName'. Error: $_"
        }
    }
}

Write-Host "`nProcessing complete."

# # Archive the resulting PDF-only export
# $downloadsPath = Join-Path -Path $home -ChildPath "Downloads"
# $zipFileName = "Mathématiques-Export_$([DateTime]::UtcNow.ToString('yyyyMMdd-HHmmss')).zip"
# $zipFilePath = Join-Path -Path $downloadsPath -ChildPath $zipFileName

# try {
#     if (Test-Path -Path $zipFilePath) {
#         Remove-Item -Path $zipFilePath -Force
#     }
#     Compress-Archive -Path (Join-Path -Path $DestinationRoot -ChildPath '*') -DestinationPath $zipFilePath -Force
#     Write-Host "Export archive created at: $zipFilePath"
# }
# catch {
#     Write-Error "Failed to create export archive: $_"
# }
