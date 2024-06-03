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

function Show-ChromeShortcuts {
    $chromeShortcuts = @"
Google Chrome Shortcuts:
========================
Ctrl + T           : Open a new tab
Ctrl + W           : Close the current tab
Ctrl + Shift + T   : Reopen the last closed tab
Ctrl + L           : Focus the address bar
Ctrl + Tab         : Move forward through tabs
Ctrl + Shift + Tab : Move backward through tabs
Ctrl + D           : Add current site to bookmarks
Alt + F4           : Close the current window
"@
    Write-Output $chromeShortcuts
}

function Show-FirefoxShortcuts {
    $firefoxShortcuts = @"
Mozilla Firefox Shortcuts:
==========================
Ctrl + T           : Open a new tab
Ctrl + W           : Close the current tab
Ctrl + Shift + T   : Reopen the last closed tab
Ctrl + L           : Focus the address bar
Ctrl + Tab         : Move forward through tabs
Ctrl + Shift + Tab : Move backward through tabs
Ctrl + D           : Add current site to bookmarks
Alt + F4           : Close the current window
"@
    Write-Output $firefoxShortcuts
}

function Show-VSShortcuts {
    $vsShortcuts = @"
Visual Studio Shortcuts:
========================
Ctrl + N           : Create new file
Ctrl + S           : Save current file
Ctrl + Shift + S   : Save all files
Ctrl + O           : Open file
Ctrl + Shift + O   : Open project
F5                 : Start debugging
Ctrl + Shift + B   : Build solution
"@
    Write-Output $vsShortcuts
}

function Show-VSCodeShortcuts {
    $vscodeShortcuts = @"
Visual Studio Code Shortcuts:
=============================
Ctrl + P           : Quick open
Ctrl + Shift + P   : Command palette
Ctrl + N           : New file
Ctrl + S           : Save
Ctrl + Shift + S   : Save all
Ctrl + W           : Close editor
Ctrl + Shift + W   : Close all editors
Ctrl + `           : Toggle terminal
"@
    Write-Output $vscodeShortcuts
}

function Show-RiderShortcuts {
    $riderShortcuts = @"
Rider Shortcuts:
================
Ctrl + N           : Go to class
Ctrl + Shift + N   : Go to file
Alt + Enter        : Show intention actions
Ctrl + Shift + F10 : Run configuration
Shift + F9         : Debug configuration
Ctrl + Shift + F9  : Compile
"@
    Write-Output $riderShortcuts
}

function Show-DataGripShortcuts {
    $datagripShortcuts = @"
DataGrip Shortcuts:
===================
Ctrl + N           : Go to class
Ctrl + Shift + N   : Go to file
Ctrl + F12         : File structure
Shift + F6         : Rename
Ctrl + Alt + L     : Reformat code
Alt + F7           : Find usages
"@
    Write-Output $datagripShortcuts
}

function Show-PyCharmShortcuts {
    $pycharmShortcuts = @"
PyCharm Shortcuts:
==================
Ctrl + N           : Go to class
Ctrl + Shift + N   : Go to file
Alt + Enter        : Show intention actions
Ctrl + Shift + F10 : Run configuration
Shift + F9         : Debug configuration
Ctrl + Shift + F9  : Compile
"@
    Write-Output $pycharmShortcuts
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
    "chrome" { Show-ChromeShortcuts }
    "firefox" { Show-FirefoxShortcuts }
    "vs" { Show-VSShortcuts }
    "vscode" { Show-VSCodeShortcuts }
    "rider" { Show-RiderShortcuts }
    "datagrip" { Show-DataGripShortcuts }
    "pycharm" { Show-PyCharmShortcuts }
    "win" { Show-WindowsShortcuts }
}
