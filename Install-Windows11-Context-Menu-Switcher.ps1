Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$scriptUrl = 'https://raw.githubusercontent.com/DeclanE47/Windows11-Context-Menu-Switcher/main/Windows11-Context-Menu-Switcher.ps1'
$downloadDirectory = Join-Path $HOME 'Downloads'

if (-not (Test-Path -Path $downloadDirectory)) {
    $downloadDirectory = $env:TEMP
}

$scriptPath = Join-Path $downloadDirectory 'Windows11-Context-Menu-Switcher.ps1'

Write-Host 'Downloading Windows 11 Context Menu Switcher...'
Invoke-WebRequest -Uri $scriptUrl -OutFile $scriptPath
Unblock-File -Path $scriptPath -ErrorAction SilentlyContinue

Write-Host "Saved to: $scriptPath"
Write-Host ''

$runNow = Read-Host 'Run it now? (Y/N)'

if ($runNow -match '^(?i)y(?:es)?$') {
    Start-Process powershell.exe -ArgumentList @(
        '-NoProfile'
        '-ExecutionPolicy', 'Bypass'
        '-File', $scriptPath
    )
}
