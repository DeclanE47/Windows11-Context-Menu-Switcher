param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('Classic', 'Default')]
    [string]$Mode
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$systemSid = 'S-1-5-18'
$contextMenuRelativePath = 'Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}'
$contextMenuProviderPath = 'Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}'

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
                PsRoot = 'HKCU:\'
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
                PsRoot = "Registry::HKEY_USERS\$($_.PSChildName)"
            }
        }

    if (-not $profiles) {
        throw 'No loaded user profiles were found under HKEY_USERS. Sign in to Windows and run the script again, or run it in the target user context.'
    }

    return @($profiles)
}

function Set-ClassicContextMenuState {
    param(
        [Parameter(Mandatory = $true)]
        [bool]$Enable
    )

    $profiles = Get-TargetProfiles

    foreach ($profile in $profiles) {
        $psContextMenuKey = Join-Path $profile.PsRoot $contextMenuProviderPath

        if ($Enable) {
            $regInprocKey = "$($profile.RegRoot)\$contextMenuRelativePath\InprocServer32"
            & reg.exe add $regInprocKey /f /ve | Out-Null
            Write-Host "Enabled classic menu for $($profile.Label)."
            continue
        }

        if (Test-Path -Path $psContextMenuKey) {
            Remove-Item -Path $psContextMenuKey -Recurse -Force
        }

        Write-Host "Restored default menu for $($profile.Label)."
    }
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

switch ($Mode) {
    'Classic' {
        Set-ClassicContextMenuState -Enable $true
    }
    'Default' {
        Set-ClassicContextMenuState -Enable $false
    }
}

Restart-WindowsExplorer
