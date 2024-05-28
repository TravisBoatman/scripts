param (
    [Parameter(Mandatory=$false)]
    [string]$name = 'help'
)

$actions = @{
    "mail"  = { Start-Process "https://outlook.office.com/mail/inbox" }
    "teams" = { Start-Process "https://teams.microsoft.com" }
    "slack" = { Start-Process "https://app.slack.com/client/ETE2L7KH6" }
    "okta"  = { Start-Process "https://kcura.okta.com" }
    "rider" = { Start-Process "$home\AppData\Local\Programs\Rider\bin\rider64.exe" }
    "dg"    = { Start-Process "$home\AppData\Local\Programs\DataGrip\bin\datagrip64.exe" }
    "pyc"   = { Start-Process "$home\AppData\Local\Programs\PyCharm Professional\bin\pycharm64.exe" }
    "ws"    = { Start-Process "$home\AppData\Local\Programs\WebStorm\bin\webstorm64.exe" }
    "gitk"  = { Start-Process "$home\AppData\Local\gitkraken\gitkraken.exe" }
    "web"   = { Start-Process "/Program Files (x86)\Microsoft\Edge\Application\msedge.exe" }
}

function Show-Options {
    Write-Host "Available options:"
    $actions.Keys | Sort-Object | ForEach-Object { Write-Host "`t$_" }
}

if ($name -eq "help") {
    Show-Options
    exit
}

if ($actions.ContainsKey($name)) {
    & $actions[$name]
} else {
    Write-Host "Unknown option: $name"
    Show-Options
}