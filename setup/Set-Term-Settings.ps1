$content = Get-Content -Path "$env:TB_CONFIGS\term-settings.json"
$filePath = "$home\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
Set-Content -Path $filePath -Value $content