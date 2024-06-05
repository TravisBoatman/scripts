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
    $content = "& ""$env:TB_SCRIPTS\profile.ps1"""
} else {
    $content = "& ""$env:TB_SCRIPTS\profile.ps1"" $themeValue"
}

$filePath = "$home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Set-Content -Path $filePath -Value $content

Write-Host "PowerShell profile setup complete. Restart terminal to apply changes. Create custom paths and actions under $env:TB_PATHS for 'go' and 'open' commands."
Write-Host "If you want to set your own OhMyPosh theme edit $Profile and add the name of the theme as a parameter. The file should exist under $env:TB_CONFIGS."
Write-Host "If you already selected a theme, run this script again to change it."
