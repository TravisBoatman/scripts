$setupTerminal = Read-Host "Do you want to use pre-made oh-my-posh theme? (yes/no)"
if ($setupTerminal -eq "yes") {
    $content = "& ""$env:TB_SCRIPTS\profile.ps1"""
} else {
    $content = "& ""$env:TB_SCRIPTS\profile-default.ps1"""
}

$filePath = "$home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Set-Content -Path $filePath -Value $content

Write-Host "PowerShell profile setup complete. Restart terminal to apply changes. Now create custom paths and actions under $env:TB_PATHS for 'go' and 'open' commands."