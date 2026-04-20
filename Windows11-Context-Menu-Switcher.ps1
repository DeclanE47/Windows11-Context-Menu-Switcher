Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$contextMenuKey = 'HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}'

function Restart-WindowsExplorer {
    Write-Host ''
    Write-Host 'Restarting Windows Explorer to apply changes...'

    Get-Process explorer -ErrorAction SilentlyContinue | Stop-Process -Force
    Start-Process explorer.exe

    Write-Host 'Restart complete.'
}

function Wait-ForContinue {
    Write-Host ''
    [void](Read-Host 'Press Enter to continue')
}

function Enable-ClassicContextMenu {
    & reg.exe add 'HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32' /f /ve | Out-Null

    Write-Host ''
    Write-Host 'Old style right-click menu enabled.'
    Restart-WindowsExplorer
}

function Enable-Windows11ContextMenu {
    if (Test-Path -Path $contextMenuKey) {
        Remove-Item -Path $contextMenuKey -Recurse -Force
    }

    Write-Host ''
    Write-Host 'Windows 11 right-click menu restored.'
    Restart-WindowsExplorer
}

function Show-Menu {
    Clear-Host
    Write-Host '==============================='
    Write-Host 'Windows 11 Context Menu Switcher'
    Write-Host '==============================='
    Write-Host 'Created by: Declan'
    Write-Host 'GitHub: https://github.com/DeclanE47'
    Write-Host '==============================='
    Write-Host '1. Enable Old Style Right-Click Menu'
    Write-Host '2. Switch to Windows 11 Right-Click Menu'
    Write-Host '3. Exit'
    Write-Host '==============================='
}

do {
    Show-Menu
    $choice = Read-Host 'Choose an option (1-3)'

    switch ($choice) {
        '1' {
            Enable-ClassicContextMenu
            Wait-ForContinue
        }
        '2' {
            Enable-Windows11ContextMenu
            Wait-ForContinue
        }
        '3' {
            break
        }
        default {
            Write-Host ''
            Write-Host 'Invalid option. Please choose 1, 2, or 3.'
            Wait-ForContinue
        }
    }
} while ($true)
