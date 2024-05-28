$scriptFiles = Get-ChildItem -Path $env:TB_SCRIPTS -Filter *.ps1

foreach ($file in $scriptFiles) {
    $filenameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($file.FullName)
    Write-Output $filenameWithoutExtension
}