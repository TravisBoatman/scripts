param (
    [string]$theme
)

if ($theme -ne $null) {
    oh-my-posh init pwsh --config "$env:TB_CONFIGS\$theme" | Invoke-Expression
}
else {
    oh-my-posh init pwsh | Invoke-Expression
}

Import-Module Terminal-Icons
Import-Module PSReadLine
Import-Module gsudoModule
Import-Module PSScriptTools

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

$scriptDirectories = @($env:TB_SCRIPTS, $env:TB_ADDITIONAL_SCRIPTS)

foreach ($scriptDirectory in $scriptDirectories) {
    $scriptFiles = Get-ChildItem -Path $scriptDirectory -Filter *.ps1 -ErrorAction SilentlyContinue

    foreach ($file in $scriptFiles) {
        $filenameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($file.FullName)
        Set-Alias -Name $filenameWithoutExtension -Value $file.FullName
    }
}