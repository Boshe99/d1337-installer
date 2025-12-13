# D1337 WinUtil

```
 ██████╗  ██╗██████╗ ██████╗ ███████╗
 ██╔══██╗███║╚════██╗╚════██╗╚════██║
 ██║  ██║╚██║ █████╔╝ █████╔╝    ██╔╝
 ██║  ██║ ██║ ╚═══██╗ ╚═══██╗   ██╔╝
 ██████╔╝ ██║██████╔╝██████╔╝   ██║
 ╚═════╝  ╚═╝╚═════╝ ╚═════╝    ╚═╝

        W I N U T I L
    by MoneyHunter Community
```

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows-00ff00?style=for-the-badge&logo=windows&logoColor=white"/>
  <img src="https://img.shields.io/badge/PowerShell-5.1+-00ff00?style=for-the-badge&logo=powershell&logoColor=white"/>
  <img src="https://img.shields.io/badge/License-MIT-00ff00?style=for-the-badge"/>
</p>

## Quick Start

### One-Line Install (Recommended)
```powershell
irm http://tools.d1337.ai/get | iex
```
Akan muncul pilihan:
- **[1] TUI Mode** - Terminal Interface (lightweight)
- **[2] GUI Mode** - Window Interface (visual)

### Direct Links
```powershell
# TUI Version (Terminal)
irm https://raw.githubusercontent.com/Boshe99/d1337-installer/main/D1337-TUI.ps1 | iex

# GUI Version (Window)
irm https://raw.githubusercontent.com/Boshe99/d1337-installer/main/D1337-WinUtil.ps1 | iex
```

### Manual Download
```powershell
# Download
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Boshe99/d1337-installer/main/D1337-TUI.ps1" -OutFile "D1337-TUI.ps1"

# Run as Admin
powershell -ExecutionPolicy Bypass -File "D1337-TUI.ps1"
```

## Features

### 🧹 Windows Debloater
Remove bloatware and unnecessary apps:
- Cortana
- Xbox Apps
- OneDrive
- Microsoft Teams
- Skype, Spotify
- Bing Weather/News
- Mixed Reality Portal
- 3D Viewer, Feedback Hub

### 📦 Hacking Tools Installer
One-click install via winget:

| Category | Tools |
|----------|-------|
| **Development** | Python, Git, VS Code, Node.js, Go |
| **Security** | Nmap, Wireshark, Burp Suite, PuTTY, WinSCP |
| **Utilities** | 7-Zip, Notepad++, Sublime, Terminal, PowerShell 7 |
| **Browsers** | Firefox, Brave, Tor Browser |

### 🔒 Privacy Tweaks
- Disable Windows Telemetry
- Disable Advertising ID
- Disable Activity History
- Disable Location Tracking
- Disable Error Reporting
- Disable Wi-Fi Sense

### ⚡ Performance Optimization
- Disable Visual Effects & Transparency
- Enable Game Mode
- Ultimate Performance Power Plan
- Disable Hibernation & SuperFetch
- Disable Search Indexing
- Network optimizations (Nagle, Throttling)

### 🛡️ RDP Privacy Shield (NEW!)
Ultimate privacy protection untuk user RDP:

| Feature | Description |
|---------|-------------|
| **Full Privacy Shield** | Jalankan semua proteksi sekaligus |
| **Scan for Spyware** | Detect keylogger, monitoring software, remote tools |
| **Kill Suspicious Processes** | Terminate TeamViewer, AnyDesk, VNC, dll |
| **Clean All Logs** | Hapus Event logs, RDP cache, browser data, temp files |
| **Disable Telemetry** | Matikan Windows telemetry & tracking services |
| **Block Telemetry Domains** | Block Microsoft telemetry via hosts file |
| **Network Privacy** | Show connections, flush DNS, reset network |
| **Auto-Clean on Logout** | Scheduled task untuk clean otomatis saat logout |
| **Encrypted Workspace** | Setup VeraCrypt encrypted container |

## TUI vs GUI

| Feature | TUI | GUI |
|---------|-----|-----|
| Interface | Terminal | Window |
| Load Time | Instant | 2-3 sec |
| Dependencies | None | WPF/.NET |
| Works over SSH | ✅ | ❌ |
| Resource Usage | Low | Medium |
| Visual | Hacker style | Modern |

## Screenshot - TUI Mode

```
  ██████╗  ██╗██████╗ ██████╗ ███████╗
  ██╔══██╗███║╚════██╗╚════██╗╚════██║
  ██║  ██║╚██║ █████╔╝ █████╔╝    ██╔╝
  ██║  ██║ ██║ ╚═══██╗ ╚═══██╗   ██╔╝
  ██████╔╝ ██║██████╔╝██████╔╝   ██║
  ╚═════╝  ╚═╝╚═════╝ ╚═════╝    ╚═╝

  W I N U T I L  TUI v2.1
  by MoneyHunter Community

  ══════════════════════════════════════════════════

    [1] Fresh RDP Setup       [6] RDP Privacy Shield
    [2] Install Tools         [7] System Config
    [3] Debloat Windows       [8] Windows Updates
    [4] Privacy Tweaks        [9] About
    [5] Performance Boost     [0] Exit

  ──────────────────────────────────────────────────
  System: Windows 11 Pro | RAM: 16GB | User: Admin

  Select [0-9]: _
```

## Requirements

- Windows 10/11
- PowerShell 5.1+
- Administrator privileges
- Winget (for tool installation)

## ⚠️ Warning

**USE AT YOUR OWN RISK**

- Create a system restore point before making changes
- Some tweaks may affect Windows functionality
- Review each option before applying

## Author

**D1337 | MoneyHunter Community**

GitHub: [@Boshe99](https://github.com/Boshe99)

---

<p align="center">
  <img src="https://img.shields.io/badge/Made%20with-PowerShell-00ff00?style=flat-square"/>
  <img src="https://img.shields.io/badge/Theme-Hacker%20Green-00ff00?style=flat-square"/>
</p>
