Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$systemSid = 'S-1-5-18'
$contextMenuRelativePath = 'Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}'

function Get-ExecutionSid {
    return [System.Security.Principal.WindowsIdentity]::GetCurrent().User.Value
}

function Get-TargetProfiles {
    $executionSid = Get-ExecutionSid

    if ($executionSid -ne $systemSid) {
        return @(
            [pscustomobject]@{
                Label = 'Current user'
                RegRoot = 'HKCU'
            }
        )
    }

    $profiles = Get-ChildItem -Path Registry::HKEY_USERS |
        Where-Object { $_.PSChildName -match '^S-1-5-21-\d+-\d+-\d+-\d+$' } |
        Sort-Object -Property PSChildName |
        ForEach-Object {
            [pscustomobject]@{
                Label = $_.PSChildName
                RegRoot = "HKEY_USERS\$($_.PSChildName)"
            }
        }

    if (-not $profiles) {
        throw 'No loaded user profiles were found under HKEY_USERS. Sign in to Windows and run the script again, or run it in the target user context.'
    }

    return @($profiles)
}

function Restart-WindowsExplorer {
    $executionSid = Get-ExecutionSid
    Write-Host 'Restarting Windows Explorer to apply changes...'

    $explorerProcesses = Get-Process explorer -ErrorAction SilentlyContinue
    if ($explorerProcesses) {
        $explorerProcesses | Stop-Process -Force
    }

    if ($executionSid -eq $systemSid) {
        Write-Host 'Explorer was stopped for logged-in sessions. Windows should relaunch it automatically.'
        Write-Host 'If the menu does not update immediately, sign out and back in once.'
        return
    }

    Start-Process explorer.exe
    Write-Host 'Restart complete.'
}

foreach ($profile in Get-TargetProfiles) {
    & reg.exe add "$($profile.RegRoot)\$contextMenuRelativePath\InprocServer32" /f /ve | Out-Null
    Write-Host "Enabled classic menu for $($profile.Label)."
}

Restart-WindowsExplorer
