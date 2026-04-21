# Windows 11 Context Menu Switcher

A simple PowerShell script that lets you switch between the old style right-click context menu and the default Windows 11 context menu. It provides a menu-driven interface and automatically restarts Windows Explorer so the change applies immediately.

## Quick Start

Run this in PowerShell:

```powershell
irm https://raw.githubusercontent.com/DeclanE47/Windows11-Context-Menu-Switcher/main/Install-Windows11-Context-Menu-Switcher.ps1 | iex
```

This downloads the script into your `Downloads` folder, shows where it was saved, and asks whether to launch it immediately.

## What It Does

- Enable the classic Windows context menu on Windows 11.
- Restore the default Windows 11 context menu.
- Restart Windows Explorer automatically so the change applies straight away.
- Provide a simple interactive menu instead of requiring manual registry commands.
- Offer interactive, parameterized, and single-purpose deployment options.

## Features

- Enable the old style right-click context menu on Windows 11.
- Switch back to the default Windows 11 right-click context menu.
- Automatically restarts Windows Explorer to apply changes.
- Easy-to-use menu interface.
- One-line download command that can optionally launch the script right away.
- Unattended one-touch PowerShell script for RMM tools such as Action1.
- Dedicated enable/restore scripts for single-action deployment jobs.

## How to Use

### Local script

1. Download or clone the repository.
2. Run `Windows11-Context-Menu-Switcher.ps1` in PowerShell.
3. Choose an option:
   - **Option 1:** Enable the old style right-click menu.
   - **Option 2:** Restore the default Windows 11 right-click menu.
   - **Option 3:** Exit the script.

The script automatically restarts Windows Explorer to apply the change.

### One-touch / RMM script

For tools such as Action1, use `Windows11-Context-Menu-Switcher-OneTouch.ps1`.

Local examples:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Windows11-Context-Menu-Switcher-OneTouch.ps1 -Mode Classic
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Windows11-Context-Menu-Switcher-OneTouch.ps1 -Mode Default
```

Direct run examples:

```powershell
& ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/DeclanE47/Windows11-Context-Menu-Switcher/main/Windows11-Context-Menu-Switcher-OneTouch.ps1'))) -Mode Classic
```

```powershell
& ([scriptblock]::Create((Invoke-RestMethod 'https://raw.githubusercontent.com/DeclanE47/Windows11-Context-Menu-Switcher/main/Windows11-Context-Menu-Switcher-OneTouch.ps1'))) -Mode Default
```

This version is non-interactive and is intended for one-click or remote deployment scenarios.
When run by an RMM under `SYSTEM`, it applies the change to loaded user profiles instead of the `SYSTEM` profile.

### Single-purpose scripts

If you want separate scripts with no parameters, use:

- `Enable-Classic-Context-Menu.ps1`
- `Restore-Default-Context-Menu.ps1`

Local examples:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Enable-Classic-Context-Menu.ps1
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Restore-Default-Context-Menu.ps1
```

Direct run examples:

```powershell
irm https://raw.githubusercontent.com/DeclanE47/Windows11-Context-Menu-Switcher/main/Enable-Classic-Context-Menu.ps1 | iex
```

```powershell
irm https://raw.githubusercontent.com/DeclanE47/Windows11-Context-Menu-Switcher/main/Restore-Default-Context-Menu.ps1 | iex
```

These are useful for RMM jobs, scheduled tasks, or any deployment flow where you want one script per action.

### Action1 / Remote Run Tip

If your RMM runs a script body directly instead of first placing a `.ps1` file on disk, use either:

- one of the single-purpose scripts directly
- one of the direct run examples above

Do not use `-File .\SomeScript.ps1` unless that script already exists on the target machine.
If Explorer does not refresh the menu immediately in a remote session, sign out and back in once.

## Requirements

- Windows 11
- PowerShell

## Notes

- If PowerShell blocks local scripts, run them with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\Windows11-Context-Menu-Switcher.ps1
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to contribute to the project by submitting issues, suggesting features, or creating pull requests. 

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/emerytools)

## Author

**Declan**  
- GitHub: [DeclanE47](https://github.com/DeclanE47)

