param (
    [Parameter(Mandatory=$false)]
    [string]$app
)

function Show-TerminalShortcuts {
    $terminalShortcuts = @"
Windows Terminal Shortcuts:
===========================
Ctrl + Shift + P   : Command palette
Ctrl + ``           : Open a new tab with the default profile
Ctrl + Shift + N   : Open a new Windows Terminal instance
Ctrl + Shift + W   : Close current tab
Ctrl + Tab         : Move forward through tabs
Ctrl + Shift + Tab : Move backward through tabs
Alt + Enter        : Toggle full screen
Alt + Shift + D    : Duplicate current pane
"@
    Write-Output $terminalShortcuts
}

function Show-EdgeShortcuts {
    $edgeShortcuts = @"
Microsoft Edge Shortcuts:
=========================
Ctrl + T           : Open a new tab
Ctrl + W           : Close the current tab
Ctrl + Shift + T   : Reopen the last closed tab
Ctrl + L           : Focus the address bar
Ctrl + Tab         : Move forward through tabs
Ctrl + Shift + Tab : Move backward through tabs
Ctrl + D           : Add current site to bookmarks
Alt + F4           : Close the current window
"@
    Write-Output $edgeShortcuts
}

function Show-WindowsShortcuts {
    $windowsShortcuts = @"
General Windows Shortcuts:
==========================
Win + D            : Show desktop
Win + E            : Open File Explorer
Win + L            : Lock your PC
Win + R            : Open Run dialog box
Win + I            : Open Settings
Win + Tab          : Open Task view
Alt + Tab          : Switch between open apps
Ctrl + Shift + Esc : Open Task Manager
"@
    Write-Output $windowsShortcuts
}

switch($app){
    "term" { Show-TerminalShortcuts }
    "edge" { Show-EdgeShortcuts }
    "win" { Show-WindowsShortcuts }
}