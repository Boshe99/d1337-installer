<#
.SYNOPSIS
    D1337 WinUtil TUI v2.1 - Terminal User Interface
.DESCRIPTION
    Terminal-based Windows utility for debloating, installing tools,
    privacy tweaks, performance optimization, and RDP privacy shield.
.AUTHOR
    D1337 | MoneyHunter Community
    GitHub: https://github.com/Boshe99
.VERSION
    2.1.0
#>

# Require Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "`n[!] Please run as Administrator!" -ForegroundColor Red
    Write-Host "    Right-click PowerShell > Run as Administrator`n" -ForegroundColor Yellow
    pause
    exit
}

$Host.UI.RawUI.WindowTitle = "D1337 WinUtil TUI"
$script:Version = "2.1.0"

# ==================== COLORS ====================
$c = @{
    Primary   = "Cyan"
    Success   = "Green"
    Warning   = "Yellow"
    Danger    = "Red"
    Muted     = "DarkGray"
    White     = "White"
    Magenta   = "Magenta"
}

# ==================== UI HELPERS ====================
function Write-Header {
    param([string]$Title)
    Clear-Host
    Write-Host ""
    Write-Host "  ██████╗  ██╗██████╗ ██████╗ ███████╗" -ForegroundColor $c.Primary
    Write-Host "  ██╔══██╗███║╚════██╗╚════██╗╚════██║" -ForegroundColor $c.Primary
    Write-Host "  ██║  ██║╚██║ █████╔╝ █████╔╝    ██╔╝" -ForegroundColor $c.Primary
    Write-Host "  ██║  ██║ ██║ ╚═══██╗ ╚═══██╗   ██╔╝" -ForegroundColor $c.Primary
    Write-Host "  ██████╔╝ ██║██████╔╝██████╔╝   ██║" -ForegroundColor $c.Primary
    Write-Host "  ╚═════╝  ╚═╝╚═════╝ ╚═════╝    ╚═╝" -ForegroundColor $c.Primary
    Write-Host ""
    if ($Title) {
        Write-Host "  $Title" -ForegroundColor $c.White
    } else {
        Write-Host "  W I N U T I L  TUI v$script:Version" -ForegroundColor $c.White
    }
    Write-Host "  by MoneyHunter Community" -ForegroundColor $c.Muted
    Write-Host ""
    Write-Host "  ══════════════════════════════════════════════════" -ForegroundColor $c.Muted
}

function Write-MenuOption {
    param([string]$Key, [string]$Text, [string]$Desc = "", [string]$Color = "Green")
    Write-Host "    [$Key] " -ForegroundColor $Color -NoNewline
    Write-Host "$Text " -ForegroundColor $c.White -NoNewline
    if ($Desc) {
        Write-Host "- $Desc" -ForegroundColor $c.Muted
    } else {
        Write-Host ""
    }
}

function Write-Status {
    param([string]$Message, [string]$Type = "info")
    switch ($Type) {
        "info"    { Write-Host "  [*] $Message" -ForegroundColor $c.Primary }
        "success" { Write-Host "  [+] $Message" -ForegroundColor $c.Success }
        "warning" { Write-Host "  [!] $Message" -ForegroundColor $c.Warning }
        "error"   { Write-Host "  [-] $Message" -ForegroundColor $c.Danger }
    }
}

function Write-Separator {
    Write-Host ""
    Write-Host "  ──────────────────────────────────────────────────" -ForegroundColor $c.Muted
    Write-Host ""
}

function Pause-Menu {
    Write-Host ""
    Write-Host "  Press any key to continue..." -ForegroundColor $c.Muted
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}

function Get-SystemInfo {
    $os = Get-CimInstance Win32_OperatingSystem
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    $ram = [math]::Round($os.TotalVisibleMemorySize / 1MB, 0)

    return @{
        OS = $os.Caption
        Build = $os.BuildNumber
        PC = $env:COMPUTERNAME
        User = $env:USERNAME
        RAM = "${ram}GB"
        CPU = $cpu.Name.Trim()
    }
}

# ==================== MAIN MENU ====================
function Show-MainMenu {
    $sysInfo = Get-SystemInfo

    Write-Header
    Write-Host ""
    Write-MenuOption "1" "Fresh RDP Setup" "Quick setup untuk RDP baru" "Green"
    Write-MenuOption "2" "Install Tools" "Install apps via winget" "Cyan"
    Write-MenuOption "3" "Debloat Windows" "Remove bloatware" "Yellow"
    Write-MenuOption "4" "Privacy Tweaks" "Disable telemetry & tracking" "Magenta"
    Write-MenuOption "5" "Performance Boost" "Optimize Windows performance" "Green"
    Write-MenuOption "6" "RDP Privacy Shield" "Ultimate RDP privacy protection" "Red"
    Write-MenuOption "7" "System Config" "Windows features & tools" "Cyan"
    Write-MenuOption "8" "Windows Updates" "Manage Windows updates" "Yellow"
    Write-MenuOption "9" "About" "Info & credits" "White"
    Write-MenuOption "0" "Exit" "" "Red"
    Write-Separator
    Write-Host "  System: " -NoNewline -ForegroundColor $c.Muted
    Write-Host "$($sysInfo.OS)" -ForegroundColor $c.White -NoNewline
    Write-Host " | RAM: " -NoNewline -ForegroundColor $c.Muted
    Write-Host "$($sysInfo.RAM)" -ForegroundColor $c.White -NoNewline
    Write-Host " | User: " -NoNewline -ForegroundColor $c.Muted
    Write-Host "$($sysInfo.User)" -ForegroundColor $c.White
    Write-Host ""

    $choice = Read-Host "  Select [0-9]"
    return $choice
}

# ==================== 1. FRESH RDP SETUP ====================
function Show-FreshRDPMenu {
    while ($true) {
        Write-Header "FRESH RDP SETUP"
        Write-Host ""
        Write-MenuOption "1" "Full Hacker Setup" "All tools + security" "Green"
        Write-MenuOption "2" "Developer Setup" "Python, Git, Node, VS Code" "Cyan"
        Write-MenuOption "3" "Security Setup" "Nmap, Wireshark, Burp" "Magenta"
        Write-MenuOption "4" "Minimal Setup" "Essential tools only" "Yellow"
        Write-MenuOption "5" "Gaming Setup" "Steam, Discord, drivers" "Green"
        Write-MenuOption "0" "Back" "" "Red"
        Write-Separator

        $choice = Read-Host "  Select [0-5]"

        switch ($choice) {
            "1" { Install-FullHacker }
            "2" { Install-DevSetup }
            "3" { Install-SecuritySetup }
            "4" { Install-MinimalSetup }
            "5" { Install-GamingSetup }
            "0" { return }
        }
    }
}

function Install-Winget {
    $winget = Get-Command winget -ErrorAction SilentlyContinue
    if (-not $winget) {
        Write-Status "Installing winget..." "info"
        try {
            $progressPreference = 'silentlyContinue'
            Invoke-WebRequest -Uri "https://aka.ms/getwinget" -OutFile "$env:TEMP\winget.msixbundle"
            Add-AppxPackage -Path "$env:TEMP\winget.msixbundle"
            Write-Status "Winget installed!" "success"
        } catch {
            Write-Status "Failed to install winget" "error"
        }
    }
}

function Install-WingetApp {
    param([string]$AppId, [string]$Name)
    Write-Status "Installing $Name..." "info"
    winget install --id $AppId --accept-source-agreements --accept-package-agreements -h 2>&1 | Out-Null
    Write-Status "$Name installed!" "success"
}

function Install-FullHacker {
    Write-Header "INSTALLING FULL HACKER SETUP"
    Write-Host ""
    Install-Winget

    $apps = @{
        "Python.Python.3.11" = "Python 3.11"
        "Git.Git" = "Git"
        "Microsoft.VisualStudioCode" = "VS Code"
        "OpenJS.NodeJS.LTS" = "Node.js"
        "GoLang.Go" = "Go"
        "Microsoft.WindowsTerminal" = "Windows Terminal"
        "Microsoft.PowerShell" = "PowerShell 7"
        "Insecure.Nmap" = "Nmap"
        "WiresharkFoundation.Wireshark" = "Wireshark"
        "PortSwigger.BurpSuite.Community" = "Burp Suite"
        "PuTTY.PuTTY" = "PuTTY"
        "WinSCP.WinSCP" = "WinSCP"
        "7zip.7zip" = "7-Zip"
        "Notepad++.Notepad++" = "Notepad++"
    }

    foreach ($app in $apps.GetEnumerator()) {
        Install-WingetApp -AppId $app.Key -Name $app.Value
    }

    Write-Status "Full Hacker Setup complete!" "success"
    Pause-Menu
}

function Install-DevSetup {
    Write-Header "INSTALLING DEVELOPER SETUP"
    Write-Host ""
    Install-Winget

    $apps = @{
        "Python.Python.3.11" = "Python 3.11"
        "Git.Git" = "Git"
        "Microsoft.VisualStudioCode" = "VS Code"
        "OpenJS.NodeJS.LTS" = "Node.js"
        "Microsoft.WindowsTerminal" = "Windows Terminal"
        "GitHub.cli" = "GitHub CLI"
        "Docker.DockerDesktop" = "Docker"
    }

    foreach ($app in $apps.GetEnumerator()) {
        Install-WingetApp -AppId $app.Key -Name $app.Value
    }

    Write-Status "Developer Setup complete!" "success"
    Pause-Menu
}

function Install-SecuritySetup {
    Write-Header "INSTALLING SECURITY SETUP"
    Write-Host ""
    Install-Winget

    $apps = @{
        "Insecure.Nmap" = "Nmap"
        "WiresharkFoundation.Wireshark" = "Wireshark"
        "PortSwigger.BurpSuite.Community" = "Burp Suite"
        "PuTTY.PuTTY" = "PuTTY"
        "WinSCP.WinSCP" = "WinSCP"
        "OpenVPNTechnologies.OpenVPN" = "OpenVPN"
    }

    foreach ($app in $apps.GetEnumerator()) {
        Install-WingetApp -AppId $app.Key -Name $app.Value
    }

    Write-Status "Security Setup complete!" "success"
    Pause-Menu
}

function Install-MinimalSetup {
    Write-Header "INSTALLING MINIMAL SETUP"
    Write-Host ""
    Install-Winget

    $apps = @{
        "Git.Git" = "Git"
        "Microsoft.WindowsTerminal" = "Windows Terminal"
        "7zip.7zip" = "7-Zip"
        "Notepad++.Notepad++" = "Notepad++"
    }

    foreach ($app in $apps.GetEnumerator()) {
        Install-WingetApp -AppId $app.Key -Name $app.Value
    }

    Write-Status "Minimal Setup complete!" "success"
    Pause-Menu
}

function Install-GamingSetup {
    Write-Header "INSTALLING GAMING SETUP"
    Write-Host ""
    Install-Winget

    $apps = @{
        "Valve.Steam" = "Steam"
        "Discord.Discord" = "Discord"
        "EpicGames.EpicGamesLauncher" = "Epic Games"
        "Microsoft.DirectX" = "DirectX"
    }

    foreach ($app in $apps.GetEnumerator()) {
        Install-WingetApp -AppId $app.Key -Name $app.Value
    }

    Write-Status "Gaming Setup complete!" "success"
    Pause-Menu
}

# ==================== 2. INSTALL TOOLS ====================
function Show-InstallToolsMenu {
    while ($true) {
        Write-Header "INSTALL TOOLS"
        Write-Host ""
        Write-MenuOption "1" "Browsers" "Chrome, Firefox, Brave, Tor" "Cyan"
        Write-MenuOption "2" "Development" "Python, Git, VS Code, Node" "Green"
        Write-MenuOption "3" "Security" "Nmap, Wireshark, Burp" "Magenta"
        Write-MenuOption "4" "Utilities" "7-Zip, Terminal, Notepad++" "Yellow"
        Write-MenuOption "5" "Communication" "Discord, Telegram, Slack" "Cyan"
        Write-MenuOption "6" "Media" "VLC, OBS, GIMP" "Green"
        Write-MenuOption "0" "Back" "" "Red"
        Write-Separator

        $choice = Read-Host "  Select [0-6]"

        switch ($choice) {
            "1" { Show-BrowsersMenu }
            "2" { Show-DevToolsMenu }
            "3" { Show-SecurityToolsMenu }
            "4" { Show-UtilitiesMenu }
            "5" { Show-CommunicationMenu }
            "6" { Show-MediaMenu }
            "0" { return }
        }
    }
}

function Show-AppSelectionMenu {
    param([hashtable]$Apps, [string]$Title)

    Write-Header $Title
    Write-Host ""

    $index = 1
    $appList = @{}
    foreach ($app in $Apps.GetEnumerator()) {
        Write-MenuOption $index $app.Value "" "Cyan"
        $appList[$index.ToString()] = $app
        $index++
    }
    Write-MenuOption "A" "Install All" "" "Green"
    Write-MenuOption "0" "Back" "" "Red"
    Write-Separator

    $choice = Read-Host "  Select"

    if ($choice -eq "0") { return }

    Install-Winget

    if ($choice -eq "A" -or $choice -eq "a") {
        foreach ($app in $Apps.GetEnumerator()) {
            Install-WingetApp -AppId $app.Key -Name $app.Value
        }
    } elseif ($appList.ContainsKey($choice)) {
        $selected = $appList[$choice]
        Install-WingetApp -AppId $selected.Key -Name $selected.Value
    }

    Pause-Menu
}

function Show-BrowsersMenu {
    $apps = @{
        "Google.Chrome" = "Google Chrome"
        "Mozilla.Firefox" = "Firefox"
        "Brave.Brave" = "Brave"
        "TorProject.TorBrowser" = "Tor Browser"
        "LibreWolf.LibreWolf" = "LibreWolf"
        "Vivaldi.Vivaldi" = "Vivaldi"
    }
    Show-AppSelectionMenu -Apps $apps -Title "BROWSERS"
}

function Show-DevToolsMenu {
    $apps = @{
        "Python.Python.3.11" = "Python 3.11"
        "Git.Git" = "Git"
        "Microsoft.VisualStudioCode" = "VS Code"
        "OpenJS.NodeJS.LTS" = "Node.js LTS"
        "GoLang.Go" = "Go"
        "Rustlang.Rust.MSVC" = "Rust"
        "Docker.DockerDesktop" = "Docker"
        "GitHub.cli" = "GitHub CLI"
    }
    Show-AppSelectionMenu -Apps $apps -Title "DEVELOPMENT TOOLS"
}

function Show-SecurityToolsMenu {
    $apps = @{
        "Insecure.Nmap" = "Nmap"
        "WiresharkFoundation.Wireshark" = "Wireshark"
        "PortSwigger.BurpSuite.Community" = "Burp Suite"
        "PuTTY.PuTTY" = "PuTTY"
        "WinSCP.WinSCP" = "WinSCP"
        "OpenVPNTechnologies.OpenVPN" = "OpenVPN"
        "tailscale.tailscale" = "Tailscale"
    }
    Show-AppSelectionMenu -Apps $apps -Title "SECURITY TOOLS"
}

function Show-UtilitiesMenu {
    $apps = @{
        "7zip.7zip" = "7-Zip"
        "Microsoft.WindowsTerminal" = "Windows Terminal"
        "Microsoft.PowerShell" = "PowerShell 7"
        "Notepad++.Notepad++" = "Notepad++"
        "Microsoft.PowerToys" = "PowerToys"
        "voidtools.Everything" = "Everything Search"
        "ShareX.ShareX" = "ShareX"
    }
    Show-AppSelectionMenu -Apps $apps -Title "UTILITIES"
}

function Show-CommunicationMenu {
    $apps = @{
        "Discord.Discord" = "Discord"
        "Telegram.TelegramDesktop" = "Telegram"
        "SlackTechnologies.Slack" = "Slack"
        "OpenWhisperSystems.Signal" = "Signal"
        "Element.Element" = "Element"
    }
    Show-AppSelectionMenu -Apps $apps -Title "COMMUNICATION"
}

function Show-MediaMenu {
    $apps = @{
        "VideoLAN.VLC" = "VLC"
        "OBSProject.OBSStudio" = "OBS Studio"
        "GIMP.GIMP" = "GIMP"
        "Audacity.Audacity" = "Audacity"
        "HandBrake.HandBrake" = "HandBrake"
        "BlenderFoundation.Blender" = "Blender"
    }
    Show-AppSelectionMenu -Apps $apps -Title "MEDIA"
}

# ==================== 3. DEBLOAT ====================
function Show-DebloatMenu {
    while ($true) {
        Write-Header "DEBLOAT WINDOWS"
        Write-Host ""
        Write-MenuOption "1" "Remove All Bloatware" "Remove semua apps bawaan" "Red"
        Write-MenuOption "2" "Remove Xbox Apps" "" "Yellow"
        Write-MenuOption "3" "Remove Cortana" "" "Yellow"
        Write-MenuOption "4" "Remove OneDrive" "" "Yellow"
        Write-MenuOption "5" "Remove Teams" "" "Yellow"
        Write-MenuOption "6" "Remove Widgets" "" "Yellow"
        Write-MenuOption "7" "Remove Bing Search" "Dari Start Menu" "Yellow"
        Write-MenuOption "0" "Back" "" "Red"
        Write-Separator

        $choice = Read-Host "  Select [0-7]"

        switch ($choice) {
            "1" { Remove-AllBloatware }
            "2" { Remove-XboxApps }
            "3" { Remove-Cortana }
            "4" { Remove-OneDrive }
            "5" { Remove-Teams }
            "6" { Remove-Widgets }
            "7" { Remove-BingSearch }
            "0" { return }
        }
    }
}

function Remove-BloatApp {
    param([string]$AppName, [string]$DisplayName)
    Write-Status "Removing $DisplayName..." "info"
    Get-AppxPackage -Name "*$AppName*" -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like "*$AppName*" | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    Write-Status "$DisplayName removed!" "success"
}

function Remove-AllBloatware {
    Write-Header "REMOVING ALL BLOATWARE"
    Write-Host ""

    $bloatApps = @(
        @("Xbox", "Microsoft.Xbox"),
        @("Cortana", "Microsoft.549981C3F5F10"),
        @("Bing Weather", "Microsoft.BingWeather"),
        @("Bing News", "Microsoft.BingNews"),
        @("Get Help", "Microsoft.GetHelp"),
        @("Tips", "Microsoft.Getstarted"),
        @("Solitaire", "Microsoft.MicrosoftSolitaireCollection"),
        @("Mixed Reality", "Microsoft.MixedReality"),
        @("3D Viewer", "Microsoft.Microsoft3DViewer"),
        @("Feedback Hub", "Microsoft.WindowsFeedbackHub"),
        @("Your Phone", "Microsoft.YourPhone"),
        @("Skype", "Microsoft.SkypeApp"),
        @("Groove Music", "Microsoft.ZuneMusic"),
        @("Movies & TV", "Microsoft.ZuneVideo"),
        @("People", "Microsoft.People"),
        @("Mail", "microsoft.windowscommunicationsapps"),
        @("Maps", "Microsoft.WindowsMaps"),
        @("OneNote", "Microsoft.Office.OneNote"),
        @("Teams", "MicrosoftTeams"),
        @("Clipchamp", "Clipchamp.Clipchamp"),
        @("To Do", "Microsoft.Todos")
    )

    foreach ($app in $bloatApps) {
        Remove-BloatApp -DisplayName $app[0] -AppName $app[1]
    }

    Write-Status "All bloatware removed!" "success"
    Pause-Menu
}

function Remove-XboxApps {
    Write-Header "REMOVING XBOX APPS"
    Write-Host ""
    Remove-BloatApp -DisplayName "Xbox" -AppName "Microsoft.Xbox"
    Remove-BloatApp -DisplayName "Xbox Game Bar" -AppName "Microsoft.XboxGamingOverlay"
    Remove-BloatApp -DisplayName "Xbox Identity" -AppName "Microsoft.XboxIdentityProvider"
    Write-Status "Xbox apps removed!" "success"
    Pause-Menu
}

function Remove-Cortana {
    Write-Header "REMOVING CORTANA"
    Write-Host ""
    Remove-BloatApp -DisplayName "Cortana" -AppName "Microsoft.549981C3F5F10"
    Write-Status "Cortana removed!" "success"
    Pause-Menu
}

function Remove-OneDrive {
    Write-Header "REMOVING ONEDRIVE"
    Write-Host ""
    Write-Status "Stopping OneDrive..." "info"
    Stop-Process -Name OneDrive -Force -ErrorAction SilentlyContinue

    Write-Status "Uninstalling OneDrive..." "info"
    if (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe") {
        & "$env:SystemRoot\System32\OneDriveSetup.exe" /uninstall
    }
    if (Test-Path "$env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
        & "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" /uninstall
    }

    Write-Status "OneDrive removed!" "success"
    Pause-Menu
}

function Remove-Teams {
    Write-Header "REMOVING MICROSOFT TEAMS"
    Write-Host ""
    Remove-BloatApp -DisplayName "Teams" -AppName "MicrosoftTeams"
    Write-Status "Teams removed!" "success"
    Pause-Menu
}

function Remove-Widgets {
    Write-Header "REMOVING WIDGETS"
    Write-Host ""
    Remove-BloatApp -DisplayName "Widgets" -AppName "MicrosoftWindows.Client.WebExperience"
    Write-Status "Widgets removed!" "success"
    Pause-Menu
}

function Remove-BingSearch {
    Write-Header "REMOVING BING SEARCH"
    Write-Host ""
    Write-Status "Disabling Bing Search in Start Menu..." "info"

    $path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
    if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -Path $path -Name "DisableSearchBoxSuggestions" -Value 1 -Force

    Write-Status "Bing Search disabled!" "success"
    Pause-Menu
}

# ==================== 4. PRIVACY TWEAKS ====================
function Show-PrivacyMenu {
    while ($true) {
        Write-Header "PRIVACY TWEAKS"
        Write-Host ""
        Write-MenuOption "1" "Apply All Privacy Tweaks" "Recommended" "Green"
        Write-MenuOption "2" "Disable Telemetry" "" "Yellow"
        Write-MenuOption "3" "Disable Activity History" "" "Yellow"
        Write-MenuOption "4" "Disable Location Tracking" "" "Yellow"
        Write-MenuOption "5" "Disable Advertising ID" "" "Yellow"
        Write-MenuOption "6" "Disable Cortana" "" "Yellow"
        Write-MenuOption "7" "Disable Error Reporting" "" "Yellow"
        Write-MenuOption "0" "Back" "" "Red"
        Write-Separator

        $choice = Read-Host "  Select [0-7]"

        switch ($choice) {
            "1" { Apply-AllPrivacy }
            "2" { Disable-Telemetry }
            "3" { Disable-ActivityHistory }
            "4" { Disable-LocationTracking }
            "5" { Disable-AdvertisingID }
            "6" { Disable-CortanaPrivacy }
            "7" { Disable-ErrorReporting }
            "0" { return }
        }
    }
}

function Apply-AllPrivacy {
    Write-Header "APPLYING ALL PRIVACY TWEAKS"
    Write-Host ""
    Disable-Telemetry
    Disable-ActivityHistory
    Disable-LocationTracking
    Disable-AdvertisingID
    Disable-CortanaPrivacy
    Disable-ErrorReporting
    Write-Status "All privacy tweaks applied!" "success"
    Pause-Menu
}

function Disable-Telemetry {
    Write-Status "Disabling telemetry..." "info"

    $paths = @(
        "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    )

    foreach ($path in $paths) {
        if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
        Set-ItemProperty -Path $path -Name "AllowTelemetry" -Value 0 -Force
    }

    # Disable services
    Stop-Service -Name "DiagTrack" -Force -ErrorAction SilentlyContinue
    Set-Service -Name "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
    Stop-Service -Name "dmwappushservice" -Force -ErrorAction SilentlyContinue
    Set-Service -Name "dmwappushservice" -StartupType Disabled -ErrorAction SilentlyContinue

    Write-Status "Telemetry disabled!" "success"
}

function Disable-ActivityHistory {
    Write-Status "Disabling Activity History..." "info"

    $path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
    if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -Path $path -Name "EnableActivityFeed" -Value 0 -Force
    Set-ItemProperty -Path $path -Name "PublishUserActivities" -Value 0 -Force
    Set-ItemProperty -Path $path -Name "UploadUserActivities" -Value 0 -Force

    Write-Status "Activity History disabled!" "success"
}

function Disable-LocationTracking {
    Write-Status "Disabling Location Tracking..." "info"

    $path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors"
    if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -Path $path -Name "DisableLocation" -Value 1 -Force
    Set-ItemProperty -Path $path -Name "DisableLocationScripting" -Value 1 -Force

    Write-Status "Location Tracking disabled!" "success"
}

function Disable-AdvertisingID {
    Write-Status "Disabling Advertising ID..." "info"

    $path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo"
    if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -Path $path -Name "DisabledByGroupPolicy" -Value 1 -Force

    Write-Status "Advertising ID disabled!" "success"
}

function Disable-CortanaPrivacy {
    Write-Status "Disabling Cortana..." "info"

    $path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
    if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -Path $path -Name "AllowCortana" -Value 0 -Force

    Write-Status "Cortana disabled!" "success"
}

function Disable-ErrorReporting {
    Write-Status "Disabling Error Reporting..." "info"

    $path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting"
    if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -Path $path -Name "Disabled" -Value 1 -Force

    Stop-Service -Name "WerSvc" -Force -ErrorAction SilentlyContinue
    Set-Service -Name "WerSvc" -StartupType Disabled -ErrorAction SilentlyContinue

    Write-Status "Error Reporting disabled!" "success"
}

# ==================== 5. PERFORMANCE ====================
function Show-PerformanceMenu {
    while ($true) {
        Write-Header "PERFORMANCE BOOST"
        Write-Host ""
        Write-MenuOption "1" "Apply All Performance Tweaks" "Recommended" "Green"
        Write-MenuOption "2" "Disable Visual Effects" "" "Yellow"
        Write-MenuOption "3" "Enable Game Mode" "" "Yellow"
        Write-MenuOption "4" "Ultimate Performance Plan" "" "Yellow"
        Write-MenuOption "5" "Disable Superfetch" "" "Yellow"
        Write-MenuOption "6" "Disable Search Indexing" "" "Yellow"
        Write-MenuOption "7" "Network Optimization" "" "Yellow"
        Write-MenuOption "0" "Back" "" "Red"
        Write-Separator

        $choice = Read-Host "  Select [0-7]"

        switch ($choice) {
            "1" { Apply-AllPerformance }
            "2" { Disable-VisualEffects }
            "3" { Enable-GameMode }
            "4" { Enable-UltimatePerformance }
            "5" { Disable-Superfetch }
            "6" { Disable-SearchIndexing }
            "7" { Optimize-Network }
            "0" { return }
        }
    }
}

function Apply-AllPerformance {
    Write-Header "APPLYING ALL PERFORMANCE TWEAKS"
    Write-Host ""
    Disable-VisualEffects
    Enable-GameMode
    Enable-UltimatePerformance
    Disable-Superfetch
    Disable-SearchIndexing
    Optimize-Network
    Write-Status "All performance tweaks applied!" "success"
    Pause-Menu
}

function Disable-VisualEffects {
    Write-Status "Disabling Visual Effects..." "info"

    $path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
    Set-ItemProperty -Path $path -Name "VisualFXSetting" -Value 2 -Force -ErrorAction SilentlyContinue

    # Disable transparency
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -Force -ErrorAction SilentlyContinue

    Write-Status "Visual Effects disabled!" "success"
}

function Enable-GameMode {
    Write-Status "Enabling Game Mode..." "info"

    $path = "HKCU:\Software\Microsoft\GameBar"
    if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -Path $path -Name "AllowAutoGameMode" -Value 1 -Force
    Set-ItemProperty -Path $path -Name "AutoGameModeEnabled" -Value 1 -Force

    Write-Status "Game Mode enabled!" "success"
}

function Enable-UltimatePerformance {
    Write-Status "Enabling Ultimate Performance..." "info"

    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>&1 | Out-Null
    $scheme = powercfg -list | Select-String "Ultimate Performance"
    if ($scheme) {
        $guid = ($scheme -split '\s+')[3]
        powercfg -setactive $guid
    }

    Write-Status "Ultimate Performance enabled!" "success"
}

function Disable-Superfetch {
    Write-Status "Disabling Superfetch/SysMain..." "info"

    Stop-Service -Name "SysMain" -Force -ErrorAction SilentlyContinue
    Set-Service -Name "SysMain" -StartupType Disabled -ErrorAction SilentlyContinue

    Write-Status "Superfetch disabled!" "success"
}

function Disable-SearchIndexing {
    Write-Status "Disabling Search Indexing..." "info"

    Stop-Service -Name "WSearch" -Force -ErrorAction SilentlyContinue
    Set-Service -Name "WSearch" -StartupType Disabled -ErrorAction SilentlyContinue

    Write-Status "Search Indexing disabled!" "success"
}

function Optimize-Network {
    Write-Status "Optimizing Network..." "info"

    # Disable Nagle's Algorithm
    $path = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
    Get-ChildItem $path | ForEach-Object {
        Set-ItemProperty -Path $_.PSPath -Name "TcpAckFrequency" -Value 1 -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $_.PSPath -Name "TCPNoDelay" -Value 1 -Force -ErrorAction SilentlyContinue
    }

    # Disable throttling
    netsh int tcp set global autotuninglevel=normal 2>&1 | Out-Null

    Write-Status "Network optimized!" "success"
}

# ==================== 6. RDP PRIVACY SHIELD ====================
function Show-RDPPrivacyMenu {
    while ($true) {
        Write-Header "RDP PRIVACY SHIELD"
        Write-Host ""
        Write-Host "  Ultimate privacy protection untuk RDP users" -ForegroundColor $c.Muted
        Write-Host ""
        Write-MenuOption "1" "FULL PRIVACY SHIELD" "Run semua proteksi" "Red"
        Write-Separator
        Write-MenuOption "2" "Scan for Monitoring Software" "" "Cyan"
        Write-MenuOption "3" "Kill Suspicious Processes" "" "Magenta"
        Write-MenuOption "4" "Clean All Logs" "" "Yellow"
        Write-MenuOption "5" "Disable Telemetry & Tracking" "" "Yellow"
        Write-MenuOption "6" "Block Telemetry Domains" "" "Yellow"
        Write-MenuOption "7" "Show Active Connections" "" "Cyan"
        Write-MenuOption "8" "Setup Auto-Clean on Logout" "" "Green"
        Write-MenuOption "9" "Setup Encrypted Workspace" "" "Green"
        Write-MenuOption "0" "Back" "" "Red"
        Write-Separator

        $choice = Read-Host "  Select [0-9]"

        switch ($choice) {
            "1" { Invoke-FullPrivacyShield }
            "2" { Invoke-ScanMonitoring }
            "3" { Invoke-KillSuspicious }
            "4" { Invoke-CleanAllLogs }
            "5" { Invoke-DisableTracking }
            "6" { Invoke-BlockTelemetryDomains }
            "7" { Invoke-ShowConnections }
            "8" { Invoke-SetupAutoClean }
            "9" { Invoke-SetupEncryptedWorkspace }
            "0" { return }
        }
    }
}

function Invoke-FullPrivacyShield {
    Write-Header "FULL PRIVACY SHIELD ACTIVATED"
    Write-Host ""
    Write-Host "  ===========================================" -ForegroundColor $c.Danger
    Write-Host "     RUNNING ALL PRIVACY PROTECTIONS" -ForegroundColor $c.Danger
    Write-Host "  ===========================================" -ForegroundColor $c.Danger
    Write-Host ""

    Invoke-ScanMonitoring
    Write-Host ""
    Invoke-KillSuspicious
    Write-Host ""
    Invoke-DisableTracking
    Write-Host ""
    Invoke-CleanAllLogs
    Write-Host ""
    Invoke-BlockTelemetryDomains
    Write-Host ""
    Invoke-SetupAutoClean

    Write-Host ""
    Write-Host "  ===========================================" -ForegroundColor $c.Success
    Write-Host "     FULL PRIVACY SHIELD COMPLETE!" -ForegroundColor $c.Success
    Write-Host "  ===========================================" -ForegroundColor $c.Success

    Pause-Menu
}

function Invoke-ScanMonitoring {
    Write-Status "Scanning for monitoring software..." "info"

    $suspiciousNames = @(
        "keylog", "spy", "monitor", "sniff", "capture", "hook",
        "vnc", "teamviewer", "anydesk", "rustdesk", "supremo",
        "radmin", "ammyy", "logmein", "screenconnect", "bomgar",
        "dameware", "netop", "remotepc", "splashtop"
    )

    $foundCount = 0

    # Check processes
    Write-Status "Scanning processes..." "info"
    $processes = Get-Process | Select-Object ProcessName, Id -ErrorAction SilentlyContinue
    foreach ($proc in $processes) {
        foreach ($name in $suspiciousNames) {
            if ($proc.ProcessName -match $name) {
                Write-Status "FOUND PROCESS: $($proc.ProcessName) (PID: $($proc.Id))" "warning"
                $foundCount++
            }
        }
    }

    # Check services
    Write-Status "Scanning services..." "info"
    $services = Get-Service -ErrorAction SilentlyContinue
    foreach ($svc in $services) {
        foreach ($name in $suspiciousNames) {
            if ($svc.Name -match $name -or $svc.DisplayName -match $name) {
                Write-Status "FOUND SERVICE: $($svc.DisplayName) [$($svc.Status)]" "warning"
                $foundCount++
            }
        }
    }

    if ($foundCount -eq 0) {
        Write-Status "No suspicious software detected!" "success"
    } else {
        Write-Status "Found $foundCount suspicious items!" "warning"
    }
}

function Invoke-KillSuspicious {
    Write-Status "Killing suspicious processes..." "info"

    $toKill = @("teamviewer", "anydesk", "rustdesk", "supremo", "vnc", "radmin", "ammyy", "logmein", "screenconnect", "splashtop")
    $killed = 0

    foreach ($name in $toKill) {
        $procs = Get-Process -Name "*$name*" -ErrorAction SilentlyContinue
        foreach ($proc in $procs) {
            try {
                Stop-Process -Id $proc.Id -Force -ErrorAction Stop
                Write-Status "Killed: $($proc.ProcessName)" "success"
                $killed++
            } catch {
                Write-Status "Cannot kill: $($proc.ProcessName)" "error"
            }
        }
    }

    if ($killed -eq 0) {
        Write-Status "No suspicious processes to kill" "info"
    }
}

function Invoke-CleanAllLogs {
    Write-Status "Cleaning all logs..." "info"

    # Event Logs
    $eventLogs = @("Application", "Security", "System", "Setup",
        "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational",
        "Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational",
        "Microsoft-Windows-PowerShell/Operational")

    foreach ($log in $eventLogs) {
        wevtutil cl $log 2>&1 | Out-Null
    }
    Write-Status "Event logs cleared!" "success"

    # RDP Cache
    Remove-Item "$env:LOCALAPPDATA\Microsoft\Terminal Server Client\Cache\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item "HKCU:\Software\Microsoft\Terminal Server Client\Default" -Recurse -Force -ErrorAction SilentlyContinue
    Remove-Item "HKCU:\Software\Microsoft\Terminal Server Client\Servers" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Status "RDP cache cleared!" "success"

    # Temp files
    Remove-Item "$env:TEMP\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\Temp\*" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item "C:\Windows\Prefetch\*" -Force -Recurse -ErrorAction SilentlyContinue
    Write-Status "Temp files cleared!" "success"

    # Recent files
    Remove-Item "$env:APPDATA\Microsoft\Windows\Recent\*" -Force -ErrorAction SilentlyContinue
    Write-Status "Recent files cleared!" "success"

    # Browser data
    Remove-Item "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\History" -Force -ErrorAction SilentlyContinue
    Remove-Item "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\History" -Force -ErrorAction SilentlyContinue
    Write-Status "Browser history cleared!" "success"

    # PowerShell history
    Remove-Item "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" -Force -ErrorAction SilentlyContinue
    Write-Status "PowerShell history cleared!" "success"

    # Flush DNS
    ipconfig /flushdns 2>&1 | Out-Null
    Write-Status "DNS cache flushed!" "success"
}

function Invoke-DisableTracking {
    Write-Status "Disabling tracking services..." "info"

    $services = @("DiagTrack", "dmwappushservice", "WMPNetworkSvc", "RemoteRegistry")

    foreach ($svc in $services) {
        Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
        Set-Service -Name $svc -StartupType Disabled -ErrorAction SilentlyContinue
    }

    # Disable telemetry registry
    $paths = @(
        "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
    )

    foreach ($path in $paths) {
        if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
        Set-ItemProperty -Path $path -Name "AllowTelemetry" -Value 0 -Force
    }

    Write-Status "Tracking services disabled!" "success"
}

function Invoke-BlockTelemetryDomains {
    Write-Status "Blocking telemetry domains..." "info"

    $domains = @(
        "0.0.0.0 vortex.data.microsoft.com",
        "0.0.0.0 vortex-win.data.microsoft.com",
        "0.0.0.0 telecommand.telemetry.microsoft.com",
        "0.0.0.0 oca.telemetry.microsoft.com",
        "0.0.0.0 sqm.telemetry.microsoft.com",
        "0.0.0.0 watson.telemetry.microsoft.com",
        "0.0.0.0 watson.live.com"
    )

    $hostsPath = "C:\Windows\System32\drivers\etc\hosts"
    $hostsContent = Get-Content $hostsPath -ErrorAction SilentlyContinue

    $added = 0
    foreach ($domain in $domains) {
        if ($hostsContent -notcontains $domain) {
            Add-Content -Path $hostsPath -Value $domain -ErrorAction SilentlyContinue
            $added++
        }
    }

    ipconfig /flushdns 2>&1 | Out-Null
    Write-Status "Blocked $added telemetry domains!" "success"
}

function Invoke-ShowConnections {
    Write-Header "ACTIVE NETWORK CONNECTIONS"
    Write-Host ""

    $connections = netstat -n | Select-String "ESTABLISHED"
    foreach ($conn in $connections) {
        Write-Host "  $($conn.ToString().Trim())" -ForegroundColor $c.Muted
    }

    Pause-Menu
}

function Invoke-SetupAutoClean {
    Write-Status "Setting up auto-clean on logout..." "info"

    $cleanScript = @'
$logs = @("Application", "Security", "System", "Microsoft-Windows-TerminalServices-LocalSessionManager/Operational")
foreach ($log in $logs) { wevtutil cl $log 2>&1 | Out-Null }
Remove-Item "$env:TEMP\*" -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item "$env:APPDATA\Microsoft\Windows\Recent\*" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Microsoft\Terminal Server Client\Cache\*" -Force -Recurse -ErrorAction SilentlyContinue
ipconfig /flushdns | Out-Null
'@

    $scriptPath = "$env:USERPROFILE\d1337-autoclean.ps1"
    Set-Content -Path $scriptPath -Value $cleanScript

    try {
        $taskAction = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$scriptPath`""
        $taskTrigger = New-ScheduledTaskTrigger -AtLogOff
        $taskPrincipal = New-ScheduledTaskPrincipal -UserId $env:USERNAME -LogonType Interactive
        $taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

        Unregister-ScheduledTask -TaskName "D1337-AutoClean" -Confirm:$false -ErrorAction SilentlyContinue
        Register-ScheduledTask -TaskName "D1337-AutoClean" -Action $taskAction -Trigger $taskTrigger -Principal $taskPrincipal -Settings $taskSettings -Force | Out-Null

        Write-Status "Auto-clean task registered!" "success"
        Write-Status "Will run on every logout" "info"
    } catch {
        Write-Status "Failed to create scheduled task" "error"
    }
}

function Invoke-SetupEncryptedWorkspace {
    Write-Header "ENCRYPTED WORKSPACE SETUP"
    Write-Host ""

    Write-Status "Installing VeraCrypt..." "info"
    Install-Winget
    winget install --id IDRIX.VeraCrypt --accept-source-agreements --accept-package-agreements -h 2>&1 | Out-Null

    $workDir = "$env:USERPROFILE\SecureWorkspace"
    if (!(Test-Path $workDir)) {
        New-Item -ItemType Directory -Path $workDir -Force | Out-Null
    }

    $mountScript = @'
@echo off
echo ================================
echo  D1337 Secure Workspace
echo ================================
set /p PASSWORD="Enter password: "
"C:\Program Files\VeraCrypt\VeraCrypt.exe" /q /v "%USERPROFILE%\SecureWorkspace\vault.hc" /l Z /p %PASSWORD%
if %ERRORLEVEL% EQU 0 (echo [+] Mounted to Z: & explorer Z:\) else (echo [-] Failed)
pause
'@

    Set-Content -Path "$workDir\MountSecure.bat" -Value $mountScript

    Write-Status "VeraCrypt installed!" "success"
    Write-Status "Workspace folder: $workDir" "info"
    Write-Host ""
    Write-Host "  To create encrypted vault:" -ForegroundColor $c.Warning
    Write-Host "  1. Open VeraCrypt" -ForegroundColor $c.Muted
    Write-Host "  2. Create Volume > Encrypted file container" -ForegroundColor $c.Muted
    Write-Host "  3. Save as: $workDir\vault.hc" -ForegroundColor $c.Muted
    Write-Host "  4. Use MountSecure.bat to mount" -ForegroundColor $c.Muted

    Pause-Menu
}

# ==================== 7. SYSTEM CONFIG ====================
function Show-SystemConfigMenu {
    while ($true) {
        Write-Header "SYSTEM CONFIG"
        Write-Host ""
        Write-MenuOption "1" "Enable WSL" "" "Cyan"
        Write-MenuOption "2" "Enable Hyper-V" "" "Cyan"
        Write-MenuOption "3" "Enable Windows Sandbox" "" "Cyan"
        Write-MenuOption "4" "Run SFC /scannow" "" "Yellow"
        Write-MenuOption "5" "Run DISM Repair" "" "Yellow"
        Write-MenuOption "6" "Flush DNS" "" "Yellow"
        Write-MenuOption "7" "Reset Network" "" "Yellow"
        Write-MenuOption "8" "Open Device Manager" "" "Green"
        Write-MenuOption "9" "Open Services" "" "Green"
        Write-MenuOption "0" "Back" "" "Red"
        Write-Separator

        $choice = Read-Host "  Select [0-9]"

        switch ($choice) {
            "1" { Enable-WSL }
            "2" { Enable-HyperV }
            "3" { Enable-Sandbox }
            "4" { Run-SFC }
            "5" { Run-DISM }
            "6" { Invoke-FlushDNS }
            "7" { Reset-Network }
            "8" { devmgmt.msc }
            "9" { services.msc }
            "0" { return }
        }
    }
}

function Enable-WSL {
    Write-Header "ENABLING WSL"
    Write-Host ""
    Write-Status "Enabling WSL feature..." "info"
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart 2>&1 | Out-Null
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart 2>&1 | Out-Null
    Write-Status "WSL enabled! Restart required." "success"
    Pause-Menu
}

function Enable-HyperV {
    Write-Header "ENABLING HYPER-V"
    Write-Host ""
    Write-Status "Enabling Hyper-V..." "info"
    dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart 2>&1 | Out-Null
    Write-Status "Hyper-V enabled! Restart required." "success"
    Pause-Menu
}

function Enable-Sandbox {
    Write-Header "ENABLING WINDOWS SANDBOX"
    Write-Host ""
    Write-Status "Enabling Windows Sandbox..." "info"
    dism.exe /online /enable-feature /featurename:Containers-DisposableClientVM /all /norestart 2>&1 | Out-Null
    Write-Status "Windows Sandbox enabled! Restart required." "success"
    Pause-Menu
}

function Run-SFC {
    Write-Header "RUNNING SFC"
    Write-Host ""
    Write-Status "Running System File Checker..." "info"
    sfc /scannow
    Pause-Menu
}

function Run-DISM {
    Write-Header "RUNNING DISM"
    Write-Host ""
    Write-Status "Running DISM repair..." "info"
    DISM /Online /Cleanup-Image /RestoreHealth
    Pause-Menu
}

function Invoke-FlushDNS {
    Write-Header "FLUSHING DNS"
    Write-Host ""
    ipconfig /flushdns
    Write-Status "DNS cache flushed!" "success"
    Pause-Menu
}

function Reset-Network {
    Write-Header "RESETTING NETWORK"
    Write-Host ""
    Write-Status "Resetting network stack..." "info"
    netsh winsock reset 2>&1 | Out-Null
    netsh int ip reset 2>&1 | Out-Null
    ipconfig /flushdns 2>&1 | Out-Null
    Write-Status "Network reset! Restart required." "success"
    Pause-Menu
}

# ==================== 8. WINDOWS UPDATES ====================
function Show-UpdatesMenu {
    while ($true) {
        Write-Header "WINDOWS UPDATES"
        Write-Host ""
        Write-MenuOption "1" "Open Windows Update" "" "Cyan"
        Write-MenuOption "2" "Pause Updates (7 days)" "" "Yellow"
        Write-MenuOption "3" "Pause Updates (30 days)" "" "Yellow"
        Write-MenuOption "4" "Resume Updates" "" "Green"
        Write-MenuOption "5" "Disable Auto Updates" "" "Red"
        Write-MenuOption "6" "Enable Auto Updates" "" "Green"
        Write-MenuOption "0" "Back" "" "Red"
        Write-Separator

        $choice = Read-Host "  Select [0-6]"

        switch ($choice) {
            "1" { Start-Process "ms-settings:windowsupdate" }
            "2" { Pause-Updates 7 }
            "3" { Pause-Updates 30 }
            "4" { Resume-Updates }
            "5" { Disable-AutoUpdates }
            "6" { Enable-AutoUpdates }
            "0" { return }
        }
    }
}

function Pause-Updates {
    param([int]$Days)
    Write-Header "PAUSING UPDATES"
    Write-Host ""
    $pause = (Get-Date).AddDays($Days).ToString("yyyy-MM-dd")
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "PauseUpdatesExpiryTime" -Value $pause -Force -ErrorAction SilentlyContinue
    Write-Status "Updates paused for $Days days!" "success"
    Pause-Menu
}

function Resume-Updates {
    Write-Header "RESUMING UPDATES"
    Write-Host ""
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "PauseUpdatesExpiryTime" -Force -ErrorAction SilentlyContinue
    Write-Status "Updates resumed!" "success"
    Pause-Menu
}

function Disable-AutoUpdates {
    Write-Header "DISABLING AUTO UPDATES"
    Write-Host ""
    $path = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
    if (!(Test-Path $path)) { New-Item -Path $path -Force | Out-Null }
    Set-ItemProperty -Path $path -Name "NoAutoUpdate" -Value 1 -Force
    Write-Status "Auto updates disabled!" "success"
    Pause-Menu
}

function Enable-AutoUpdates {
    Write-Header "ENABLING AUTO UPDATES"
    Write-Host ""
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Force -ErrorAction SilentlyContinue
    Write-Status "Auto updates enabled!" "success"
    Pause-Menu
}

# ==================== 9. ABOUT ====================
function Show-About {
    Write-Header "ABOUT"
    Write-Host ""
    Write-Host "  D1337 WinUtil TUI v$script:Version" -ForegroundColor $c.White
    Write-Host "  The Ultimate Windows Utility for Hackers" -ForegroundColor $c.Success
    Write-Host ""
    Write-Host "  Created by MoneyHunter Community" -ForegroundColor $c.Muted
    Write-Host ""
    Write-Host "  GitHub: " -NoNewline -ForegroundColor $c.Muted
    Write-Host "github.com/Boshe99/d1337-installer" -ForegroundColor $c.Primary
    Write-Host "  Website: " -NoNewline -ForegroundColor $c.Muted
    Write-Host "tools.d1337.ai" -ForegroundColor $c.Primary
    Write-Host ""
    Write-Host "  ──────────────────────────────────────────" -ForegroundColor $c.Muted
    Write-Host ""
    Write-Host "  Features:" -ForegroundColor $c.White
    Write-Host "  - Fresh RDP Setup" -ForegroundColor $c.Muted
    Write-Host "  - Install 50+ Tools via Winget" -ForegroundColor $c.Muted
    Write-Host "  - Windows Debloater" -ForegroundColor $c.Muted
    Write-Host "  - Privacy Tweaks" -ForegroundColor $c.Muted
    Write-Host "  - Performance Optimization" -ForegroundColor $c.Muted
    Write-Host "  - RDP Privacy Shield" -ForegroundColor $c.Muted
    Write-Host "  - System Configuration" -ForegroundColor $c.Muted
    Write-Host ""
    Write-Host "  USE AT YOUR OWN RISK!" -ForegroundColor $c.Danger
    Write-Host ""

    Pause-Menu
}

# ==================== MAIN LOOP ====================
function Start-TUI {
    while ($true) {
        $choice = Show-MainMenu

        switch ($choice) {
            "1" { Show-FreshRDPMenu }
            "2" { Show-InstallToolsMenu }
            "3" { Show-DebloatMenu }
            "4" { Show-PrivacyMenu }
            "5" { Show-PerformanceMenu }
            "6" { Show-RDPPrivacyMenu }
            "7" { Show-SystemConfigMenu }
            "8" { Show-UpdatesMenu }
            "9" { Show-About }
            "0" {
                Write-Host "`n  Goodbye!" -ForegroundColor $c.Success
                exit
            }
        }
    }
}

# Run
Start-TUI
