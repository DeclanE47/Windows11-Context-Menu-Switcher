# Windows 11 Context Menu Switcher

Switch between the classic Windows context menu and the default Windows 11 context menu with simple PowerShell scripts.

## Quick Start

Run this in PowerShell:

```powershell
irm https://raw.githubusercontent.com/DeclanE47/Windows11-Context-Menu-Switcher/main/Install-Windows11-Context-Menu-Switcher.ps1 | iex
```

This downloads the script to your `Downloads` folder and asks if you want to run it immediately.

## Choose Your Method

### Option 1: Interactive menu

Best for normal local use.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Windows11-Context-Menu-Switcher.ps1
```

What it does:

- shows a simple menu
- lets you switch to the classic context menu
- lets you restore the default Windows 11 menu
- restarts Windows Explorer automatically

### Option 2: One-touch script

Best for RMM tools, Action1, and unattended runs.

Classic menu:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Windows11-Context-Menu-Switcher-OneTouch.ps1 -Mode Classic
```

Default Windows 11 menu:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Windows11-Context-Menu-Switcher-OneTouch.ps1 -Mode Default
```

Direct-run examples:

```powershell
& ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/DeclanE47/Windows11-Context-Menu-Switcher/main/Windows11-Context-Menu-Switcher-OneTouch.ps1'))) -Mode Classic
```

```powershell
& ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/DeclanE47/Windows11-Context-Menu-Switcher/main/Windows11-Context-Menu-Switcher-OneTouch.ps1'))) -Mode Default
```

### Option 3: Single-purpose scripts

Best if you want one script per action.

Files:

- `Enable-Classic-Context-Menu.ps1`
- `Restore-Default-Context-Menu.ps1`

Local examples:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Enable-Classic-Context-Menu.ps1
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Restore-Default-Context-Menu.ps1
```

Direct-run examples:

```powershell
irm https://raw.githubusercontent.com/DeclanE47/Windows11-Context-Menu-Switcher/main/Enable-Classic-Context-Menu.ps1 | iex
```

```powershell
irm https://raw.githubusercontent.com/DeclanE47/Windows11-Context-Menu-Switcher/main/Restore-Default-Context-Menu.ps1 | iex
```

## Action1 / RMM Notes

- If your RMM runs script text directly, use a direct-run example instead of `-File .\SomeScript.ps1`.
- If your RMM runs under `SYSTEM`, the unattended scripts target loaded user profiles instead of the `SYSTEM` profile.
- If Explorer does not refresh the menu immediately in a remote session, sign out and back in once.

## Requirements

- Windows 11
- PowerShell

## Troubleshooting

If PowerShell blocks local scripts, run them with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Windows11-Context-Menu-Switcher.ps1
```

## Files Included

- `Install-Windows11-Context-Menu-Switcher.ps1` - downloads the main script and offers to run it
- `Windows11-Context-Menu-Switcher.ps1` - interactive menu version
- `Windows11-Context-Menu-Switcher-OneTouch.ps1` - non-interactive version with `-Mode`
- `Enable-Classic-Context-Menu.ps1` - single-purpose classic menu script
- `Restore-Default-Context-Menu.ps1` - single-purpose restore script

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## Contributing

Issues, suggestions, and pull requests are welcome.

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/emerytools)

## Author

**Declan**

- GitHub: [DeclanE47](https://github.com/DeclanE47)
