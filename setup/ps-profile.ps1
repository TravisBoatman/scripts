$setupTerminal = Read-Host "Do you want to use nord oh-my-posh theme? (yes/no)"
if ($setupTerminal -eq "yes") {
    $content = "& ""$env:TB_SCRIPTS\profile.ps1"" $true"
} else {
    $content = "oh-my-posh init pwsh | Invoke-Expression `n & `"$env:TB_SCRIPTS\profile.ps1`" $false"
}

$filePath = "$home\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
Set-Content -Path $filePath -Value $content

Write-Host "PowerShell profile setup complete. Restart terminal to apply changes. Create custom paths and actions under $env:TB_PATHS for 'go' and 'open' commands."
Write-Host "If you want to set your own OhMyPosh theme or add additional modules edit $PROFILE. Before the first line add: 'oh-my-posh init pwsh --config ""C:\Path\To\<MyCustomTheme>.omp.json"" | Invoke-Expression'"
Write-Host "If you already selected nord theme run this script again to change it."