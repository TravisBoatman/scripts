param (
    [Parameter(Position=0, Mandatory=$true)]
    [string]$email,

    [Parameter(Position=1, Mandatory=$false)]
    [string]$password
)

(Get-Content $HOME\.npmrc) -replace '_auth = .+', "_auth = $([Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("$email" + ":" + "$password")))" | Set-Content $HOME\.npmrc