param (
    [bool]$initPosh
)

if ($initPosh -eq $true) {
    oh-my-posh init pwsh --config "$env:TB_CONFIGS\nordcustom.omp.json" | Invoke-Expression
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
