param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('Classic', 'Default')]
    [string]$Mode
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$contextMenuKey = 'HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}'

function Restart-WindowsExplorer {
    Write-Host 'Restarting Windows Explorer to apply changes...'

    Get-Process explorer -ErrorAction SilentlyContinue | Stop-Process -Force
    Start-Process explorer.exe

    Write-Host 'Restart complete.'
}

switch ($Mode) {
    'Classic' {
        & reg.exe add 'HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32' /f /ve | Out-Null
        Write-Host 'Old style right-click menu enabled.'
    }
    'Default' {
        if (Test-Path -Path $contextMenuKey) {
            Remove-Item -Path $contextMenuKey -Recurse -Force
        }

        Write-Host 'Windows 11 right-click menu restored.'
    }
}

Restart-WindowsExplorer
