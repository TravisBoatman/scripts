param (
    [string]$theme
)

if ($theme -ne $null) {
    oh-my-posh init pwsh --config "$env:TB_SCRIPTS\configs\$theme" | Invoke-Expression
}
else {
    oh-my-posh init pwsh | Invoke-Expression
}

Import-Module Terminal-Icons
Import-Module PSReadLine

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

Set-Alias -Name sudo -Value gsudo

$scriptDirectories = @("$env:TB_SCRIPTS\scripts", "$env:TB_SCRIPTS\additional-scripts")

foreach ($scriptDirectory in $scriptDirectories) {
    $scriptFiles = Get-ChildItem -Path $scriptDirectory -Filter *.ps1 -ErrorAction SilentlyContinue

    foreach ($file in $scriptFiles) {
        $filenameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($file.FullName)
        Set-Alias -Name $filenameWithoutExtension -Value $file.FullName
    }
}