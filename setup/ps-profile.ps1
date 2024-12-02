$themeOptions = @("nord", "amro", "none")
$themeChoice = $null

while ($null -eq $themeChoice) {
    $themeChoice = Read-Host "Please choose a theme (nord, amro, or none)"
    if ($themeOptions -notcontains $themeChoice) {
        Write-Host "Invalid choice. Please choose either 'nord', 'amro', or 'none'."
        $themeChoice = $null
    }
}

$themeValue = switch ($themeChoice) {
    "nord" { "nordcustom.omp.json" }
    "amro" { "amro.omp.json" }
    "none" { $null }
}

if ($themeChoice -ne "none") {
    $setupTerminal = Read-Host "Do you want to use the selected oh-my-posh theme ($themeChoice)? (yes/no)"
}

if ($themeChoice -ne "none" -or $setupTerminal -eq "no") {
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

$filePathPS7 = "$home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
$filePathPSWin = "$home\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
Add-FirstLine -filePath $filePathPS7 -newContent $content
Add-FirstLine -filePath $filePathPSWin -newContent $content

Write-Host "Setup completed. Restart any open consoles to apply the changes."
Write-Host "You can copy my terminal settings from $env:TB_SCRIPTS\configs\term-settings.json if you want to use them."
Write-Host "Configure your 'go' and 'open' commands by creating 'locations.json' and 'actions.json' files in $env:TB_SCRIPTS\paths. Actions allow file paths and CLI commands with params. Locations allow directory paths only."