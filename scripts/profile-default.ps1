oh-my-posh init pwsh | Invoke-Expression

Import-Module Terminal-Icons
Import-Module PSReadLine
Import-Module gsudoModule
Import-Module PSScriptTools

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

$scriptDirectory = $env:TB_SCRIPTS
$scriptFiles = Get-ChildItem -Path $scriptDirectory -Filter *.ps1

foreach ($file in $scriptFiles) {
    $filenameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($file.FullName)
    Set-Alias -Name $filenameWithoutExtension -Value $file.FullName
}