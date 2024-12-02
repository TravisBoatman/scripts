$themeOptions = @("nord", "amro", "none")
$themeChoice = $null

while ($null -eq $themeChoice) {
    $themeChoice = Read-Host "Please choose a theme (nord, amro, or none)" -ForegroundColor Yellow
    if ($themeOptions -notcontains $themeChoice) {
        Write-Host "Invalid choice. Please choose either 'nord', 'amro', or 'none'." -ForegroundColor Red
        $themeChoice = $null
    }
}

$themeValue = switch ($themeChoice) {
    "nord" { "nordcustom.omp.json" }
    "amro" { "amro.omp.json" }
    "none" { $null }
}

if ($themeChoice -eq "none") {
    $content = ". ""$env:TB_SCRIPTS\scripts\profile.ps1"""
} else {
    $content = ". ""$env:TB_SCRIPTS\scripts\profile.ps1"" $themeValue"
}

function Add-FirstLine {
    param (
        [string]$filePath,
        [string]$newContent
    )

    if (Test-Path $filePath) {
        $existingContent = Get-Content -Path $filePath
    } else {
        $existingContent = @()
    }

    $updatedContent = @($newContent) + $existingContent

    Set-Content -Path $filePath -Value $updatedContent
}

$docsPath = [environment]::GetFolderPath('MyDocuments')
$filePaths = @("$docsPath\PowerShell\Microsoft.PowerShell_profile.ps1", 
               "$docsPath\WindowsPowerShell\Microsoft.PowerShell_profile.ps1")

foreach ($filePath in $filePaths) {
    if (!(Test-Path $filePath)) {
        New-Item -ItemType Directory -Path (Split-Path $filePath) -Force | Out-Null
        New-Item -ItemType File -Path $filePath -Force | Out-Null
        Write-Host "Created: $filePath"
    }

    Add-FirstLine -filePath $filePath -newContent $content
}

Write-Host "Setup completed. Restart any open consoles to apply the changes. Be sure to set the font in your terminal settings to the Nerd Font you downloaded.`n" -ForegroundColor Yellow
Write-Host "You can copy my terminal settings from $env:TB_SCRIPTS\configs\term-settings.json if you want to use them.`n" -ForegroundColor Yellow
Write-Host "Configure your 'go' and 'open' commands by creating 'locations.json' and 'actions.json' files in $env:TB_SCRIPTS\paths. Actions allow file paths and CLI commands with params. Locations allow directory paths only.`n" -ForegroundColor Yellow