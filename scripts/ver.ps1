$versionPath = "./version.txt"
$currentVersion = Get-Content $versionPath -First 1

Write-Host "Current Version: $currentVersion" -ForegroundColor Cyan

$incrementType = Read-Host "Increment [p]atch, [mi]nor, [m]ajor?"
$versionParts = $currentVersion.Split('.')

[int]$major = $versionParts[0]
[int]$minor = $versionParts[1]
[int]$patch = $versionParts[2]

switch ($incrementType) {
    "p" {
        $patch++
    }
    "mi" {
        $minor++
        $patch = 0
    }
    "m" {
        $major++
        $minor = 0
        $patch = 0
    }
}

$newVersion = "$major.$minor.$patch"
Set-Content $versionPath -Value $newVersion
Write-Host "Updated Version: $newVersion" -ForegroundColor Green

$updateChangelog = Read-Host "Update changelog? [y/n]"

if ($updateChangelog -eq 'y') {
    $changelogPath = "./changelog.md"
    $jiraTicket = Read-Host "JIRA Ticket"
    $logText = Read-Host "Log Text"

    $changelogEntry = "## [$newVersion]`r`n[$jiraTicket] - $logText`r`n"

    $changelogContent = Get-Content $changelogPath

    $changelogContent = $changelogContent[0..1] + $changelogEntry + $changelogContent[2..($changelogContent.Length-1)]

    Set-Content $changelogPath -Value $changelogContent
    Write-Host "Changelog updated:" -ForegroundColor Green
    Write-Host $changelogEntry -ForegroundColor Cyan
}