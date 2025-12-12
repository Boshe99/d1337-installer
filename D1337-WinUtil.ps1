<#
.SYNOPSIS
    D1337 WinUtil v2.0 - Windows Utility Tool by MoneyHunter Community
.DESCRIPTION
    A comprehensive Windows utility for debloating, installing tools,
    privacy tweaks, performance optimization, and system configuration.
.AUTHOR
    D1337 | MoneyHunter Community
    GitHub: https://github.com/Boshe99
.VERSION
    2.0.0
#>

# Require Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run as Administrator!"
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# ==================== APP DATABASE ====================
$AppDatabase = @{
    # Browsers
    "Brave" = "Brave.Brave"
    "Chrome" = "Google.Chrome"
    "Firefox" = "Mozilla.Firefox"
    "Firefox ESR" = "Mozilla.Firefox.ESR"
    "LibreWolf" = "LibreWolf.LibreWolf"
    "Edge" = "Microsoft.Edge"
    "Tor Browser" = "TorProject.TorBrowser"
    "Vivaldi" = "Vivaldi.Vivaldi"
    "Opera" = "Opera.Opera"
    "Chromium" = "Nickel.Nickel"

    # Communications
    "Discord" = "Discord.Discord"
    "Slack" = "SlackTechnologies.Slack"
    "Telegram" = "Telegram.TelegramDesktop"
    "Signal" = "OpenWhisperSystems.Signal"
    "Teams" = "Microsoft.Teams"
    "Zoom" = "Zoom.Zoom"
    "Element" = "Element.Element"
    "Thunderbird" = "Mozilla.Thunderbird"
    "HexChat" = "HexChat.HexChat"

    # Development
    "Python 3.11" = "Python.Python.3.11"
    "Python 3.12" = "Python.Python.3.12"
    "Git" = "Git.Git"
    "VS Code" = "Microsoft.VisualStudioCode"
    "VS Code Insiders" = "Microsoft.VisualStudioCode.Insiders"
    "Visual Studio 2022" = "Microsoft.VisualStudio.2022.Community"
    "Node.js LTS" = "OpenJS.NodeJS.LTS"
    "Node.js" = "OpenJS.NodeJS"
    "Go" = "GoLang.Go"
    "Rust" = "Rustlang.Rust.MSVC"
    "Java 17" = "Amazon.Corretto.17.JDK"
    "Java 21" = "Amazon.Corretto.21.JDK"
    "Docker Desktop" = "Docker.DockerDesktop"
    "Podman" = "RedHat.Podman"
    "GitHub CLI" = "GitHub.cli"
    "GitHub Desktop" = "GitHub.GitHubDesktop"
    "GitKraken" = "Axosoft.GitKraken"
    "Neovim" = "Neovim.Neovim"
    "Sublime Text" = "SublimeHQ.SublimeText.4"
    "Sublime Merge" = "SublimeHQ.SublimeMerge"
    "Notepad++" = "Notepad++.Notepad++"
    "JetBrains Toolbox" = "JetBrains.Toolbox"
    "Postman" = "Postman.Postman"
    "Insomnia" = "Insomnia.Insomnia"
    "CMake" = "Kitware.CMake"
    "LLVM" = "LLVM.LLVM"
    "NVM Windows" = "CoreyButler.NVMforWindows"
    "Lazygit" = "JesseDuffield.lazygit"
    "Helix" = "Helix.Helix"

    # Security & Networking
    "Nmap" = "Insecure.Nmap"
    "Wireshark" = "WiresharkFoundation.Wireshark"
    "Burp Suite" = "PortSwigger.BurpSuite.Community"
    "PuTTY" = "PuTTY.PuTTY"
    "WinSCP" = "WinSCP.WinSCP"
    "OpenVPN" = "OpenVPNTechnologies.OpenVPN"
    "Mullvad VPN" = "MullvadVPN.MullvadVPN"
    "Tailscale" = "tailscale.tailscale"
    "Angry IP Scanner" = "angryziber.AngryIPScanner"
    "Advanced IP Scanner" = "Famatech.AdvancedIPScanner"
    "mRemoteNG" = "mRemoteNG.mRemoteNG"
    "FileZilla" = "TimKosse.FileZilla.Client"
    "Termius" = "Termius.Termius"
    "RustDesk" = "RustDesk.RustDesk"
    "Portmaster" = "Safing.Portmaster"
    "Simplewall" = "Henry++.simplewall"

    # Utilities
    "7-Zip" = "7zip.7zip"
    "WinRAR" = "RARLab.WinRAR"
    "PeaZip" = "Giorgiotani.Peazip"
    "Windows Terminal" = "Microsoft.WindowsTerminal"
    "PowerShell 7" = "Microsoft.PowerShell"
    "PowerToys" = "Microsoft.PowerToys"
    "Everything" = "voidtools.Everything"
    "ShareX" = "ShareX.ShareX"
    "Greenshot" = "Greenshot.Greenshot"
    "Flameshot" = "Flameshot.Flameshot"
    "QuickLook" = "QL-Win.QuickLook"
    "Flow Launcher" = "Flow-Launcher.Flow-Launcher"
    "AutoHotkey" = "AutoHotkey.AutoHotkey"
    "Ditto" = "Ditto.Ditto"
    "KeePassXC" = "KeePassXCTeam.KeePassXC"
    "Bitwarden" = "Bitwarden.Bitwarden"
    "1Password" = "AgileBits.1Password"
    "Rufus" = "Rufus.Rufus"
    "Ventoy" = "Ventoy.Ventoy"
    "Etcher" = "Balena.Etcher"
    "TreeSize" = "JAMSoftware.TreeSize.Free"
    "WizTree" = "AntibodySoftware.WizTree"
    "SpaceSniffer" = "UderzoSoftware.SpaceSniffer"
    "BleachBit" = "BleachBit.BleachBit"
    "BCUninstaller" = "Klocman.BulkCrapUninstaller"
    "Revo Uninstaller" = "RevoUninstaller.RevoUninstaller"
    "Glary Utilities" = "Glarysoft.GlaryUtilities"
    "CPU-Z" = "CPUID.CPU-Z"
    "GPU-Z" = "TechPowerUp.GPU-Z"
    "HWiNFO" = "REALiX.HWiNFO"
    "HWMonitor" = "CPUID.HWMonitor"
    "CrystalDiskInfo" = "CrystalDewWorld.CrystalDiskInfo"
    "CrystalDiskMark" = "CrystalDewWorld.CrystalDiskMark"
    "Speccy" = "Piriform.Speccy"
    "NVCleanstall" = "TechPowerUp.NVCleanstall"
    "DDU" = "Wagnardsoft.DisplayDriverUninstaller"
    "MSI Afterburner" = "Guru3D.Afterburner"
    "Process Lasso" = "BitSum.ProcessLasso"
    "AnyDesk" = "AnyDesk.AnyDesk"
    "TeamViewer" = "TeamViewer.TeamViewer"
    "Parsec" = "Parsec.Parsec"
    "LocalSend" = "LocalSend.LocalSend"
    "Syncthing" = "SyncTrayzor.SyncTrayzor"
    "qBittorrent" = "qBittorrent.qBittorrent"
    "Deluge" = "DelugeTeam.Deluge"
    "Transmission" = "Transmission.Transmission"
    "JDownloader" = "AppWork.JDownloader"

    # Multimedia
    "VLC" = "VideoLAN.VLC"
    "MPC-HC" = "clsid2.mpc-hc"
    "mpv" = "mpv.net"
    "PotPlayer" = "Daum.PotPlayer"
    "Foobar2000" = "PeterPawlowski.foobar2000"
    "AIMP" = "AIMP.AIMP"
    "Spotify" = "Spotify.Spotify"
    "Audacity" = "Audacity.Audacity"
    "OBS Studio" = "OBSProject.OBSStudio"
    "Streamlabs" = "Streamlabs.Streamlabs"
    "GIMP" = "GIMP.GIMP"
    "Inkscape" = "Inkscape.Inkscape"
    "Krita" = "KDE.Krita"
    "Paint.NET" = "dotPDN.PaintDotNet"
    "Blender" = "BlenderFoundation.Blender"
    "DaVinci Resolve" = "Blackmagic.DaVinciResolve"
    "HandBrake" = "HandBrake.HandBrake"
    "FFmpeg" = "Gyan.FFmpeg"
    "ImageGlass" = "DuongDieuPhap.ImageGlass"
    "IrfanView" = "IrfanSkiljan.IrfanView"
    "K-Lite Codec" = "CodecGuide.K-LiteCodecPack.Standard"
    "Kdenlive" = "KDE.Kdenlive"
    "ScreenToGif" = "NickeManarin.ScreenToGif"

    # Documents
    "Adobe Reader" = "Adobe.Acrobat.Reader.64-bit"
    "Foxit Reader" = "Foxit.FoxitReader"
    "SumatraPDF" = "SumatraPDF.SumatraPDF"
    "Okular" = "KDE.Okular"
    "LibreOffice" = "TheDocumentFoundation.LibreOffice"
    "ONLYOFFICE" = "ONLYOFFICE.DesktopEditors"
    "Obsidian" = "Obsidian.Obsidian"
    "Notion" = "Notion.Notion"
    "Logseq" = "Logseq.Logseq"
    "Joplin" = "Joplin.Joplin"
    "Typora" = "Typora.Typora"
    "MarkText" = "marktext.marktext"
    "Calibre" = "calibre.calibre"

    # Gaming
    "Steam" = "Valve.Steam"
    "Epic Games" = "EpicGames.EpicGamesLauncher"
    "GOG Galaxy" = "GOG.Galaxy"
    "EA App" = "ElectronicArts.EADesktop"
    "Ubisoft Connect" = "Ubisoft.Connect"
    "Battle.net" = "Blizzard.BattleNet"
    "Playnite" = "Playnite.Playnite"
    "Heroic Launcher" = "HeroicGamesLauncher.HeroicGamesLauncher"
    "Prism Launcher" = "PrismLauncher.PrismLauncher"
    "Discord" = "Discord.Discord"
    "GeForce Experience" = "Nvidia.GeForceExperience"

    # Microsoft Tools
    "PowerToys" = "Microsoft.PowerToys"
    ".NET 6 Runtime" = "Microsoft.DotNet.DesktopRuntime.6"
    ".NET 7 Runtime" = "Microsoft.DotNet.DesktopRuntime.7"
    ".NET 8 Runtime" = "Microsoft.DotNet.DesktopRuntime.8"
    "VC++ 2015-2022" = "Microsoft.VCRedist.2015+.x64"
    "DirectX" = "Microsoft.DirectX"
    "Sysinternals" = "Microsoft.Sysinternals.ProcessMonitor"
    "Autoruns" = "Microsoft.Sysinternals.Autoruns"
    "TCPView" = "Microsoft.Sysinternals.TCPView"
    "SQL Server Management" = "Microsoft.SQLServerManagementStudio"
    "Azure Data Studio" = "Microsoft.AzureDataStudio"

    # Virtualization
    "VirtualBox" = "Oracle.VirtualBox"
    "VMware Player" = "VMware.WorkstationPlayer"
    "Hyper-V" = "Microsoft.Hyper-V"
    "WSL" = "Microsoft.WSL"
    "Sandboxie Plus" = "Sandboxie.Plus"
}

# ==================== XAML GUI ====================
[xml]$XAML = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="D1337 WinUtil v2.0 | MoneyHunter"
    Height="800" Width="1100"
    WindowStartupLocation="CenterScreen"
    Background="#0a0a0a"
    ResizeMode="CanResize">

    <Window.Resources>
        <Style TargetType="Button">
            <Setter Property="Background" Value="#1a1a1a"/>
            <Setter Property="Foreground" Value="#00ff00"/>
            <Setter Property="BorderBrush" Value="#00ff00"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="10,5"/>
            <Setter Property="Margin" Value="5"/>
            <Setter Property="Cursor" Value="Hand"/>
            <Setter Property="FontFamily" Value="Consolas"/>
        </Style>
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#00ff00"/>
            <Setter Property="Margin" Value="5,3"/>
            <Setter Property="FontFamily" Value="Consolas"/>
            <Setter Property="FontSize" Value="11"/>
        </Style>
        <Style TargetType="Label">
            <Setter Property="Foreground" Value="#00ff00"/>
            <Setter Property="FontFamily" Value="Consolas"/>
        </Style>
        <Style TargetType="TextBlock">
            <Setter Property="Foreground" Value="#00ff00"/>
            <Setter Property="FontFamily" Value="Consolas"/>
        </Style>
        <Style TargetType="TabItem">
            <Setter Property="Background" Value="#1a1a1a"/>
            <Setter Property="Foreground" Value="#00ff00"/>
            <Setter Property="FontFamily" Value="Consolas"/>
            <Setter Property="Padding" Value="10,5"/>
        </Style>
        <Style TargetType="GroupBox">
            <Setter Property="BorderBrush" Value="#333333"/>
            <Setter Property="Foreground" Value="#00ff00"/>
            <Setter Property="FontFamily" Value="Consolas"/>
            <Setter Property="Margin" Value="5"/>
            <Setter Property="Padding" Value="5"/>
        </Style>
    </Window.Resources>

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Header -->
        <Border Grid.Row="0" Background="#0d0d0d" Padding="15">
            <Grid>
                <StackPanel HorizontalAlignment="Left">
                    <TextBlock Text=" ██████╗  ██╗██████╗ ██████╗ ███████╗" FontSize="8"/>
                    <TextBlock Text=" ██╔══██╗███║╚════██╗╚════██╗╚════██║" FontSize="8"/>
                    <TextBlock Text=" ██║  ██║╚██║ █████╔╝ █████╔╝    ██╔╝" FontSize="8"/>
                    <TextBlock Text=" ██║  ██║ ██║ ╚═══██╗ ╚═══██╗   ██╔╝ " FontSize="8"/>
                    <TextBlock Text=" ██████╔╝ ██║██████╔╝██████╔╝   ██║  " FontSize="8"/>
                    <TextBlock Text=" ╚═════╝  ╚═╝╚═════╝ ╚═════╝    ╚═╝  " FontSize="8"/>
                </StackPanel>
                <StackPanel HorizontalAlignment="Center" VerticalAlignment="Center">
                    <TextBlock Text="D1337 WINUTIL v2.0" FontSize="24" FontWeight="Bold"/>
                    <TextBlock Text="by MoneyHunter Community" FontSize="11" Foreground="#888888" HorizontalAlignment="Center"/>
                </StackPanel>
                <StackPanel HorizontalAlignment="Right" VerticalAlignment="Center">
                    <Button x:Name="btnRestorePoint" Content="[CREATE RESTORE POINT]" FontSize="10"/>
                    <TextBlock Text="Always backup first!" FontSize="9" Foreground="#ff6600" HorizontalAlignment="Center"/>
                </StackPanel>
            </Grid>
        </Border>

        <!-- Main Content -->
        <TabControl Grid.Row="1" Background="#0a0a0a" BorderBrush="#00ff00" Margin="10">

            <!-- Tab 0: Fresh RDP -->
            <TabItem Header=" FRESH RDP " Background="#003300">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <StackPanel Margin="20">
                        <TextBlock Text="[FRESH RDP/VPS SETUP]" FontSize="16" FontWeight="Bold"/>
                        <TextBlock Text="One-click setup for fresh Windows RDP/VPS!" FontSize="11" Foreground="#888888" Margin="0,0,0,15"/>

                        <WrapPanel>
                            <Button x:Name="btnFullHacker" Content="[FULL HACKER]" Width="150" Height="50" Margin="5"/>
                            <Button x:Name="btnDevSetup" Content="[DEV SETUP]" Width="150" Height="50" Margin="5"/>
                            <Button x:Name="btnSecuritySetup" Content="[SECURITY]" Width="150" Height="50" Margin="5"/>
                            <Button x:Name="btnMinimalSetup" Content="[MINIMAL]" Width="150" Height="50" Margin="5"/>
                            <Button x:Name="btnGamingSetup" Content="[GAMING]" Width="150" Height="50" Margin="5"/>
                            <Button x:Name="btnCreatorSetup" Content="[CREATOR]" Width="150" Height="50" Margin="5"/>
                        </WrapPanel>

                        <GroupBox Header="AUTO OPTIMIZATIONS" Margin="0,15,0,0">
                            <WrapPanel>
                                <CheckBox x:Name="chkAutoDebloat" Content="Auto Debloat" IsChecked="True"/>
                                <CheckBox x:Name="chkAutoPrivacy" Content="Auto Privacy" IsChecked="True"/>
                                <CheckBox x:Name="chkAutoPerformance" Content="Auto Performance" IsChecked="True"/>
                                <CheckBox x:Name="chkInstallChoco" Content="Chocolatey"/>
                                <CheckBox x:Name="chkInstallScoop" Content="Scoop"/>
                                <CheckBox x:Name="chkInstallWinget" Content="Winget" IsChecked="True"/>
                            </WrapPanel>
                        </GroupBox>

                        <GroupBox Header="PYTHON PACKAGES (pip)">
                            <WrapPanel>
                                <CheckBox x:Name="chkPipRequests" Content="requests, httpx, aiohttp"/>
                                <CheckBox x:Name="chkPipHacking" Content="pwntools, impacket, paramiko"/>
                                <CheckBox x:Name="chkPipScraping" Content="beautifulsoup4, selenium, scrapy"/>
                                <CheckBox x:Name="chkPipData" Content="pandas, numpy, matplotlib"/>
                                <CheckBox x:Name="chkPipAI" Content="openai, langchain, transformers"/>
                            </WrapPanel>
                        </GroupBox>
                    </StackPanel>
                </ScrollViewer>
            </TabItem>

            <!-- Tab 1: Install Apps -->
            <TabItem Header=" INSTALL ">
                <Grid>
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <!-- Column 1: Browsers & Comms -->
                    <ScrollViewer Grid.Column="0" VerticalScrollBarVisibility="Auto" Margin="5">
                        <StackPanel>
                            <TextBlock Text="BROWSERS" FontWeight="Bold" Foreground="#ffff00"/>
                            <CheckBox x:Name="appBrave" Content="Brave"/>
                            <CheckBox x:Name="appChrome" Content="Chrome"/>
                            <CheckBox x:Name="appFirefox" Content="Firefox"/>
                            <CheckBox x:Name="appLibreWolf" Content="LibreWolf"/>
                            <CheckBox x:Name="appTor" Content="Tor Browser"/>
                            <CheckBox x:Name="appVivaldi" Content="Vivaldi"/>

                            <TextBlock Text="COMMUNICATIONS" FontWeight="Bold" Foreground="#ffff00" Margin="0,10,0,0"/>
                            <CheckBox x:Name="appDiscord" Content="Discord"/>
                            <CheckBox x:Name="appSlack" Content="Slack"/>
                            <CheckBox x:Name="appTelegram" Content="Telegram"/>
                            <CheckBox x:Name="appSignal" Content="Signal"/>
                            <CheckBox x:Name="appElement" Content="Element"/>
                            <CheckBox x:Name="appThunderbird" Content="Thunderbird"/>
                        </StackPanel>
                    </ScrollViewer>

                    <!-- Column 2: Development -->
                    <ScrollViewer Grid.Column="1" VerticalScrollBarVisibility="Auto" Margin="5">
                        <StackPanel>
                            <TextBlock Text="DEVELOPMENT" FontWeight="Bold" Foreground="#ffff00"/>
                            <CheckBox x:Name="appPython" Content="Python 3.11"/>
                            <CheckBox x:Name="appGit" Content="Git"/>
                            <CheckBox x:Name="appVSCode" Content="VS Code"/>
                            <CheckBox x:Name="appNodeJS" Content="Node.js LTS"/>
                            <CheckBox x:Name="appGo" Content="Go"/>
                            <CheckBox x:Name="appRust" Content="Rust"/>
                            <CheckBox x:Name="appJava" Content="Java 21"/>
                            <CheckBox x:Name="appDocker" Content="Docker Desktop"/>
                            <CheckBox x:Name="appGitHubCLI" Content="GitHub CLI"/>
                            <CheckBox x:Name="appGitHubDesktop" Content="GitHub Desktop"/>
                            <CheckBox x:Name="appNeovim" Content="Neovim"/>
                            <CheckBox x:Name="appSublime" Content="Sublime Text"/>
                            <CheckBox x:Name="appNotepadpp" Content="Notepad++"/>
                            <CheckBox x:Name="appPostman" Content="Postman"/>
                            <CheckBox x:Name="appJetBrains" Content="JetBrains Toolbox"/>
                        </StackPanel>
                    </ScrollViewer>

                    <!-- Column 3: Security & Utils -->
                    <ScrollViewer Grid.Column="2" VerticalScrollBarVisibility="Auto" Margin="5">
                        <StackPanel>
                            <TextBlock Text="SECURITY" FontWeight="Bold" Foreground="#ffff00"/>
                            <CheckBox x:Name="appNmap" Content="Nmap"/>
                            <CheckBox x:Name="appWireshark" Content="Wireshark"/>
                            <CheckBox x:Name="appBurp" Content="Burp Suite"/>
                            <CheckBox x:Name="appPuTTY" Content="PuTTY"/>
                            <CheckBox x:Name="appWinSCP" Content="WinSCP"/>
                            <CheckBox x:Name="appOpenVPN" Content="OpenVPN"/>
                            <CheckBox x:Name="appTailscale" Content="Tailscale"/>
                            <CheckBox x:Name="appmRemoteNG" Content="mRemoteNG"/>
                            <CheckBox x:Name="appRustDesk" Content="RustDesk"/>
                            <CheckBox x:Name="appSimplewall" Content="Simplewall"/>

                            <TextBlock Text="UTILITIES" FontWeight="Bold" Foreground="#ffff00" Margin="0,10,0,0"/>
                            <CheckBox x:Name="app7zip" Content="7-Zip"/>
                            <CheckBox x:Name="appTerminal" Content="Windows Terminal"/>
                            <CheckBox x:Name="appPowerShell" Content="PowerShell 7"/>
                            <CheckBox x:Name="appPowerToys" Content="PowerToys"/>
                            <CheckBox x:Name="appEverything" Content="Everything"/>
                            <CheckBox x:Name="appShareX" Content="ShareX"/>
                        </StackPanel>
                    </ScrollViewer>

                    <!-- Column 4: Media & Gaming -->
                    <ScrollViewer Grid.Column="3" VerticalScrollBarVisibility="Auto" Margin="5">
                        <StackPanel>
                            <TextBlock Text="MULTIMEDIA" FontWeight="Bold" Foreground="#ffff00"/>
                            <CheckBox x:Name="appVLC" Content="VLC"/>
                            <CheckBox x:Name="appOBS" Content="OBS Studio"/>
                            <CheckBox x:Name="appGIMP" Content="GIMP"/>
                            <CheckBox x:Name="appBlender" Content="Blender"/>
                            <CheckBox x:Name="appAudacity" Content="Audacity"/>
                            <CheckBox x:Name="appHandBrake" Content="HandBrake"/>
                            <CheckBox x:Name="appKdenlive" Content="Kdenlive"/>

                            <TextBlock Text="GAMING" FontWeight="Bold" Foreground="#ffff00" Margin="0,10,0,0"/>
                            <CheckBox x:Name="appSteam" Content="Steam"/>
                            <CheckBox x:Name="appEpic" Content="Epic Games"/>
                            <CheckBox x:Name="appGOG" Content="GOG Galaxy"/>
                            <CheckBox x:Name="appPlaynite" Content="Playnite"/>

                            <TextBlock Text="DOCUMENTS" FontWeight="Bold" Foreground="#ffff00" Margin="0,10,0,0"/>
                            <CheckBox x:Name="appLibreOffice" Content="LibreOffice"/>
                            <CheckBox x:Name="appObsidian" Content="Obsidian"/>
                            <CheckBox x:Name="appSumatraPDF" Content="SumatraPDF"/>
                        </StackPanel>
                    </ScrollViewer>

                    <StackPanel Grid.Row="1" Grid.ColumnSpan="4" Orientation="Horizontal" HorizontalAlignment="Center" Margin="10">
                        <Button x:Name="btnInstallSelected" Content="[INSTALL SELECTED]" Width="200" Height="40"/>
                        <Button x:Name="btnSelectAll" Content="[SELECT ALL]" Width="120" Height="40"/>
                        <Button x:Name="btnDeselectAll" Content="[DESELECT ALL]" Width="120" Height="40"/>
                    </StackPanel>
                </Grid>
            </TabItem>

            <!-- Tab 2: Tweaks -->
            <TabItem Header=" TWEAKS ">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <Grid Margin="10">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="*"/>
                        </Grid.ColumnDefinitions>

                        <!-- Essential Tweaks -->
                        <StackPanel Grid.Column="0" Margin="5">
                            <TextBlock Text="ESSENTIAL TWEAKS" FontWeight="Bold" Foreground="#00ff00" FontSize="14"/>
                            <CheckBox x:Name="twkTelemetry" Content="Disable Telemetry"/>
                            <CheckBox x:Name="twkActivityHistory" Content="Disable Activity History"/>
                            <CheckBox x:Name="twkLocation" Content="Disable Location Tracking"/>
                            <CheckBox x:Name="twkWiFiSense" Content="Disable Wi-Fi Sense"/>
                            <CheckBox x:Name="twkHibernation" Content="Disable Hibernation"/>
                            <CheckBox x:Name="twkGameDVR" Content="Disable GameDVR"/>
                            <CheckBox x:Name="twkEndTask" Content="Enable End Task Right-Click"/>
                            <CheckBox x:Name="twkServicesManual" Content="Set Services to Manual"/>
                            <CheckBox x:Name="twkTempFiles" Content="Delete Temp Files"/>
                            <CheckBox x:Name="twkDiskCleanup" Content="Run Disk Cleanup"/>
                            <CheckBox x:Name="twkPS7Telemetry" Content="Disable PS7 Telemetry"/>

                            <Button x:Name="btnApplyEssential" Content="[APPLY ESSENTIAL]" Margin="0,15,0,0"/>
                        </StackPanel>

                        <!-- Advanced Tweaks -->
                        <StackPanel Grid.Column="1" Margin="5">
                            <TextBlock Text="ADVANCED TWEAKS" FontWeight="Bold" Foreground="#ff6600" FontSize="14"/>
                            <CheckBox x:Name="twkCopilot" Content="Disable Microsoft Copilot"/>
                            <CheckBox x:Name="twkRecall" Content="Disable Recall AI"/>
                            <CheckBox x:Name="twkEdgeDisable" Content="Disable Edge"/>
                            <CheckBox x:Name="twkEdgeUninstall" Content="Make Edge Uninstallable"/>
                            <CheckBox x:Name="twkClassicMenu" Content="Classic Right-Click Menu"/>
                            <CheckBox x:Name="twkRemoveHome" Content="Remove Home from Explorer"/>
                            <CheckBox x:Name="twkRemoveGallery" Content="Remove Gallery from Explorer"/>
                            <CheckBox x:Name="twkStorageSense" Content="Disable Storage Sense"/>
                            <CheckBox x:Name="twkBgApps" Content="Disable Background Apps"/>
                            <CheckBox x:Name="twkIPv6" Content="Prefer IPv4 over IPv6"/>
                            <CheckBox x:Name="twkTeredo" Content="Disable Teredo"/>

                            <Button x:Name="btnApplyAdvanced" Content="[APPLY ADVANCED]" Margin="0,15,0,0"/>
                        </StackPanel>

                        <!-- Software Debloat -->
                        <StackPanel Grid.Column="2" Margin="5">
                            <TextBlock Text="SOFTWARE DEBLOAT" FontWeight="Bold" Foreground="#ff0000" FontSize="14"/>
                            <CheckBox x:Name="twkBraveDebloat" Content="Brave Debloat (Rewards, VPN)"/>
                            <CheckBox x:Name="twkEdgeDebloat" Content="Edge Debloat"/>
                            <CheckBox x:Name="twkAdobeDebloat" Content="Adobe Debloat"/>
                            <CheckBox x:Name="twkAdobeBlock" Content="Adobe Network Block"/>
                            <CheckBox x:Name="twkRemoveAllStore" Content="Remove ALL MS Store Apps"/>

                            <TextBlock Text="UI CUSTOMIZATION" FontWeight="Bold" Foreground="#00ffff" FontSize="14" Margin="0,15,0,0"/>
                            <CheckBox x:Name="twkDarkMode" Content="Enable Dark Mode"/>
                            <CheckBox x:Name="twkBingSearch" Content="Disable Bing in Start Menu"/>
                            <CheckBox x:Name="twkNumLock" Content="NumLock on Startup"/>
                            <CheckBox x:Name="twkVerboseLogon" Content="Verbose Logon Messages"/>
                            <CheckBox x:Name="twkRecommendations" Content="Disable Start Recommendations"/>

                            <Button x:Name="btnApplyDebloat" Content="[APPLY DEBLOAT]" Margin="0,15,0,0"/>
                        </StackPanel>
                    </Grid>
                </ScrollViewer>
            </TabItem>

            <!-- Tab 3: Debloat -->
            <TabItem Header=" DEBLOAT ">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <Grid Margin="10">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="*"/>
                        </Grid.ColumnDefinitions>

                        <StackPanel Grid.Column="0" Margin="5">
                            <TextBlock Text="MICROSOFT APPS" FontWeight="Bold" Foreground="#ffff00"/>
                            <CheckBox x:Name="dbCortana" Content="Cortana"/>
                            <CheckBox x:Name="dbXbox" Content="Xbox Apps"/>
                            <CheckBox x:Name="dbOneDrive" Content="OneDrive"/>
                            <CheckBox x:Name="dbTeams" Content="Microsoft Teams"/>
                            <CheckBox x:Name="dbSkype" Content="Skype"/>
                            <CheckBox x:Name="dbTodo" Content="Microsoft To Do"/>
                            <CheckBox x:Name="dbMail" Content="Mail and Calendar"/>
                            <CheckBox x:Name="dbMaps" Content="Windows Maps"/>
                            <CheckBox x:Name="dbPeople" Content="Microsoft People"/>
                            <CheckBox x:Name="dbYourPhone" Content="Your Phone"/>
                            <CheckBox x:Name="dbOfficeHub" Content="Office Hub"/>
                            <CheckBox x:Name="dbOneNote" Content="OneNote"/>
                        </StackPanel>

                        <StackPanel Grid.Column="1" Margin="5">
                            <TextBlock Text="BLOATWARE" FontWeight="Bold" Foreground="#ffff00"/>
                            <CheckBox x:Name="dbSpotify" Content="Spotify"/>
                            <CheckBox x:Name="dbBingWeather" Content="Bing Weather"/>
                            <CheckBox x:Name="dbBingNews" Content="Bing News"/>
                            <CheckBox x:Name="dbSolitaire" Content="Solitaire"/>
                            <CheckBox x:Name="dbCandyCrush" Content="Candy Crush"/>
                            <CheckBox x:Name="dbDisney" Content="Disney+"/>
                            <CheckBox x:Name="dbTikTok" Content="TikTok"/>
                            <CheckBox x:Name="dbInstagram" Content="Instagram"/>
                            <CheckBox x:Name="dbFacebook" Content="Facebook"/>
                            <CheckBox x:Name="dbAmazon" Content="Amazon Apps"/>
                            <CheckBox x:Name="dbClipchamp" Content="Clipchamp"/>
                        </StackPanel>

                        <StackPanel Grid.Column="2" Margin="5">
                            <TextBlock Text="SYSTEM APPS" FontWeight="Bold" Foreground="#ffff00"/>
                            <CheckBox x:Name="dbMixedReality" Content="Mixed Reality Portal"/>
                            <CheckBox x:Name="db3DViewer" Content="3D Viewer"/>
                            <CheckBox x:Name="dbFeedback" Content="Feedback Hub"/>
                            <CheckBox x:Name="dbGetHelp" Content="Get Help"/>
                            <CheckBox x:Name="dbTips" Content="Tips"/>
                            <CheckBox x:Name="dbStickyNotes" Content="Sticky Notes"/>
                            <CheckBox x:Name="dbAlarms" Content="Alarms and Clock"/>
                            <CheckBox x:Name="dbCamera" Content="Camera"/>
                            <CheckBox x:Name="dbVoiceRecorder" Content="Voice Recorder"/>
                            <CheckBox x:Name="dbGrooveMusic" Content="Groove Music"/>

                            <Button x:Name="btnDebloatSelected" Content="[DEBLOAT SELECTED]" Margin="0,20,0,0"/>
                            <Button x:Name="btnDebloatAll" Content="[DEBLOAT ALL]" Margin="0,5,0,0" Foreground="#ff0000"/>
                        </StackPanel>
                    </Grid>
                </ScrollViewer>
            </TabItem>

            <!-- Tab 4: Performance -->
            <TabItem Header=" PERFORMANCE ">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <Grid Margin="10">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="*"/>
                        </Grid.ColumnDefinitions>

                        <StackPanel Grid.Column="0" Margin="10">
                            <TextBlock Text="VISUAL &amp; SYSTEM" FontWeight="Bold" Foreground="#ffff00" FontSize="14"/>
                            <CheckBox x:Name="perfVisualEffects" Content="Disable Visual Effects"/>
                            <CheckBox x:Name="perfTransparency" Content="Disable Transparency"/>
                            <CheckBox x:Name="perfAnimations" Content="Disable Animations"/>
                            <CheckBox x:Name="perfGameMode" Content="Enable Game Mode"/>
                            <CheckBox x:Name="perfUltimatePower" Content="Ultimate Performance Plan"/>
                            <CheckBox x:Name="perfHighPerf" Content="High Performance Plan"/>
                            <CheckBox x:Name="perfFastStartup" Content="Disable Fast Startup (SSD)"/>
                            <CheckBox x:Name="perfHibernate" Content="Disable Hibernation"/>

                            <TextBlock Text="SERVICES" FontWeight="Bold" Foreground="#ffff00" FontSize="14" Margin="0,15,0,0"/>
                            <CheckBox x:Name="perfSearchIndex" Content="Disable Search Indexing"/>
                            <CheckBox x:Name="perfSysMain" Content="Disable SysMain/SuperFetch"/>
                            <CheckBox x:Name="perfPrintSpooler" Content="Disable Print Spooler"/>
                            <CheckBox x:Name="perfFax" Content="Disable Fax Service"/>
                            <CheckBox x:Name="perfRemoteRegistry" Content="Disable Remote Registry"/>
                        </StackPanel>

                        <StackPanel Grid.Column="1" Margin="10">
                            <TextBlock Text="NETWORK" FontWeight="Bold" Foreground="#ffff00" FontSize="14"/>
                            <CheckBox x:Name="perfNagle" Content="Disable Nagle Algorithm"/>
                            <CheckBox x:Name="perfThrottling" Content="Disable Network Throttling"/>
                            <CheckBox x:Name="perfLargeMTU" Content="Enable Large MTU"/>
                            <CheckBox x:Name="perfDNS" Content="Set DNS to Cloudflare"/>

                            <TextBlock Text="GAMING" FontWeight="Bold" Foreground="#ffff00" FontSize="14" Margin="0,15,0,0"/>
                            <CheckBox x:Name="perfFSO" Content="Disable Fullscreen Optimizations"/>
                            <CheckBox x:Name="perfHPET" Content="Disable HPET"/>
                            <CheckBox x:Name="perfMouseAccel" Content="Disable Mouse Acceleration"/>
                            <CheckBox x:Name="perfPointerPrecision" Content="Disable Pointer Precision"/>

                            <Button x:Name="btnApplyPerformance" Content="[APPLY PERFORMANCE TWEAKS]" Width="250" Height="40" Margin="0,30,0,0"/>
                        </StackPanel>
                    </Grid>
                </ScrollViewer>
            </TabItem>

            <!-- Tab 5: Updates -->
            <TabItem Header=" UPDATES ">
                <StackPanel Margin="20">
                    <TextBlock Text="[WINDOWS UPDATE MANAGEMENT]" FontSize="16" FontWeight="Bold"/>
                    <TextBlock Text="Control Windows Update behavior" Foreground="#888888" Margin="0,0,0,20"/>

                    <GroupBox Header="UPDATE SETTINGS">
                        <StackPanel>
                            <CheckBox x:Name="updDisableAuto" Content="Disable Automatic Updates"/>
                            <CheckBox x:Name="updSecurityOnly" Content="Security Updates Only"/>
                            <CheckBox x:Name="updDefer" Content="Defer Feature Updates (365 days)"/>
                            <CheckBox x:Name="updNoDrivers" Content="Don't Include Drivers in Updates"/>
                            <CheckBox x:Name="updNoRestart" Content="Disable Auto-Restart"/>
                            <CheckBox x:Name="updActiveHours" Content="Set Active Hours (8AM-11PM)"/>
                        </StackPanel>
                    </GroupBox>

                    <WrapPanel Margin="0,20,0,0">
                        <Button x:Name="btnApplyUpdates" Content="[APPLY UPDATE SETTINGS]" Width="200"/>
                        <Button x:Name="btnCheckUpdates" Content="[CHECK FOR UPDATES]" Width="180"/>
                        <Button x:Name="btnResetUpdates" Content="[RESET TO DEFAULT]" Width="160"/>
                    </WrapPanel>

                    <GroupBox Header="QUICK ACTIONS" Margin="0,20,0,0">
                        <WrapPanel>
                            <Button x:Name="btnPauseUpdates" Content="[PAUSE 7 DAYS]" Width="130"/>
                            <Button x:Name="btnPause30" Content="[PAUSE 30 DAYS]" Width="130"/>
                            <Button x:Name="btnResumeUpdates" Content="[RESUME UPDATES]" Width="140"/>
                        </WrapPanel>
                    </GroupBox>
                </StackPanel>
            </TabItem>

            <!-- Tab 6: Config -->
            <TabItem Header=" CONFIG ">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <StackPanel Margin="20">
                        <TextBlock Text="[SYSTEM CONFIGURATION]" FontSize="16" FontWeight="Bold"/>
                        <TextBlock Text="Troubleshooting and system configuration tools" Foreground="#888888" Margin="0,0,0,20"/>

                        <GroupBox Header="WINDOWS FEATURES">
                            <WrapPanel>
                                <Button x:Name="btnEnableWSL" Content="[ENABLE WSL]" Width="130"/>
                                <Button x:Name="btnEnableHyperV" Content="[ENABLE HYPER-V]" Width="140"/>
                                <Button x:Name="btnEnableSandbox" Content="[ENABLE SANDBOX]" Width="145"/>
                                <Button x:Name="btnEnableNET" Content="[ENABLE .NET 3.5]" Width="140"/>
                            </WrapPanel>
                        </GroupBox>

                        <GroupBox Header="FIXES &amp; REPAIRS" Margin="0,10,0,0">
                            <WrapPanel>
                                <Button x:Name="btnSFC" Content="[RUN SFC]" Width="100"/>
                                <Button x:Name="btnDISM" Content="[RUN DISM]" Width="100"/>
                                <Button x:Name="btnResetNetwork" Content="[RESET NETWORK]" Width="140"/>
                                <Button x:Name="btnFlushDNS" Content="[FLUSH DNS]" Width="110"/>
                                <Button x:Name="btnResetWinsock" Content="[RESET WINSOCK]" Width="135"/>
                                <Button x:Name="btnClearIconCache" Content="[CLEAR ICON CACHE]" Width="150"/>
                            </WrapPanel>
                        </GroupBox>

                        <GroupBox Header="USEFUL SHORTCUTS" Margin="0,10,0,0">
                            <WrapPanel>
                                <Button x:Name="btnDevMgr" Content="[DEVICE MANAGER]" Width="145"/>
                                <Button x:Name="btnDiskMgmt" Content="[DISK MANAGEMENT]" Width="155"/>
                                <Button x:Name="btnServices" Content="[SERVICES]" Width="100"/>
                                <Button x:Name="btnRegedit" Content="[REGEDIT]" Width="100"/>
                                <Button x:Name="btnMsconfig" Content="[MSCONFIG]" Width="105"/>
                                <Button x:Name="btnGpedit" Content="[GPEDIT]" Width="90"/>
                                <Button x:Name="btnTaskMgr" Content="[TASK MANAGER]" Width="130"/>
                                <Button x:Name="btnSysInfo" Content="[SYSTEM INFO]" Width="120"/>
                            </WrapPanel>
                        </GroupBox>

                        <GroupBox Header="FILE EXPLORER OPTIONS" Margin="0,10,0,0">
                            <StackPanel>
                                <CheckBox x:Name="cfgShowHidden" Content="Show Hidden Files"/>
                                <CheckBox x:Name="cfgShowExtensions" Content="Show File Extensions"/>
                                <CheckBox x:Name="cfgShowFullPath" Content="Show Full Path in Title Bar"/>
                                <CheckBox x:Name="cfgLaunchToThisPC" Content="Open Explorer to This PC"/>
                                <Button x:Name="btnApplyExplorerConfig" Content="[APPLY EXPLORER OPTIONS]" Width="200" Margin="0,10,0,0"/>
                            </StackPanel>
                        </GroupBox>
                    </StackPanel>
                </ScrollViewer>
            </TabItem>

            <!-- Tab 7: About -->
            <TabItem Header=" ABOUT ">
                <StackPanel Margin="20" HorizontalAlignment="Center" VerticalAlignment="Center">
                    <TextBlock Text="D1337 WinUtil" FontSize="32" FontWeight="Bold" HorizontalAlignment="Center"/>
                    <TextBlock Text="Version 2.0.0" FontSize="14" HorizontalAlignment="Center" Foreground="#888888"/>
                    <TextBlock Text="The Ultimate Windows Utility for Hackers" FontSize="12" HorizontalAlignment="Center" Foreground="#00ff00" Margin="0,5,0,20"/>

                    <TextBlock Text="Created by MoneyHunter Community" FontSize="14" HorizontalAlignment="Center"/>
                    <TextBlock Text="GitHub: github.com/Boshe99" FontSize="12" HorizontalAlignment="Center" Foreground="#888888" Margin="0,5,0,0"/>
                    <TextBlock Text="Website: tools.d1337.ai" FontSize="12" HorizontalAlignment="Center" Foreground="#00ffff"/>

                    <Border BorderBrush="#333333" BorderThickness="1" Padding="20" Margin="0,30,0,0" Width="500">
                        <TextBlock TextWrapping="Wrap" TextAlignment="Center">
                            D1337 WinUtil is a comprehensive Windows utility tool designed for hackers, developers, and power users.
                            Features include: debloating Windows, installing security/dev tools, privacy tweaks, performance optimization,
                            and system configuration - all in one place.
                        </TextBlock>
                    </Border>

                    <TextBlock Text="USE AT YOUR OWN RISK" FontSize="14" Foreground="#ff0000" FontWeight="Bold" HorizontalAlignment="Center" Margin="0,30,0,0"/>
                    <TextBlock Text="Always create a restore point before making changes!" FontSize="11" Foreground="#ff6600" HorizontalAlignment="Center"/>

                    <WrapPanel HorizontalAlignment="Center" Margin="0,30,0,0">
                        <Button x:Name="btnGitHub" Content="[GITHUB]" Width="100"/>
                        <Button x:Name="btnWebsite" Content="[WEBSITE]" Width="100"/>
                        <Button x:Name="btnDiscord" Content="[DISCORD]" Width="100"/>
                    </WrapPanel>
                </StackPanel>
            </TabItem>
        </TabControl>

        <!-- Footer -->
        <Border Grid.Row="2" Background="#0d0d0d" Padding="10">
            <Grid>
                <TextBlock x:Name="txtStatus" Text="[STATUS] Ready - Create a restore point before making changes!" HorizontalAlignment="Left" VerticalAlignment="Center"/>
                <TextBlock Text="D1337 | MoneyHunter Community | v2.0" HorizontalAlignment="Right" VerticalAlignment="Center" Foreground="#888888"/>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

# Parse XAML
$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$Window = [Windows.Markup.XamlReader]::Load($reader)

# Get all controls
$txtStatus = $Window.FindName("txtStatus")

# ==================== HELPER FUNCTIONS ====================

function Update-Status {
    param([string]$Message)
    $txtStatus.Text = "[STATUS] $Message"
    $Window.Dispatcher.Invoke([action]{}, "Render")
}

function Create-RestorePoint {
    Update-Status "Creating restore point..."
    try {
        Enable-ComputerRestore -Drive "C:\" -ErrorAction SilentlyContinue
        Checkpoint-Computer -Description "D1337 WinUtil Restore Point" -RestorePointType "MODIFY_SETTINGS"
        Update-Status "Restore point created!"
        [System.Windows.MessageBox]::Show("Restore point created successfully!", "D1337 WinUtil", "OK", "Information")
    } catch {
        Update-Status "Failed to create restore point"
        [System.Windows.MessageBox]::Show("Failed to create restore point. Run as Administrator.", "Error", "OK", "Error")
    }
}

function Install-Winget {
    $winget = Get-Command winget -ErrorAction SilentlyContinue
    if (-not $winget) {
        Update-Status "Installing winget..."
        try {
            $progressPreference = 'silentlyContinue'
            Invoke-WebRequest -Uri "https://aka.ms/getwinget" -OutFile "$env:TEMP\winget.msixbundle"
            Add-AppxPackage -Path "$env:TEMP\winget.msixbundle"
        } catch {
            Update-Status "Winget install failed - try Microsoft Store"
        }
    }
}

function Install-App {
    param([string]$AppId)
    Update-Status "Installing $AppId..."
    Start-Process winget -ArgumentList "install --id $AppId --accept-source-agreements --accept-package-agreements -h" -Wait -NoNewWindow
}

function Install-Chocolatey {
    Update-Status "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

function Install-Scoop {
    Update-Status "Installing Scoop..."
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

function Remove-BloatApp {
    param([string]$AppName)
    Update-Status "Removing $AppName..."
    Get-AppxPackage -Name "*$AppName*" -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
    Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like "*$AppName*" | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}

# ==================== EVENT HANDLERS ====================

# Restore Point Button
$Window.FindName("btnRestorePoint").Add_Click({ Create-RestorePoint })

# Install Tab Buttons
$Window.FindName("btnInstallSelected").Add_Click({
    Install-Winget
    $appMappings = @{
        "appBrave" = "Brave.Brave"
        "appChrome" = "Google.Chrome"
        "appFirefox" = "Mozilla.Firefox"
        "appLibreWolf" = "LibreWolf.LibreWolf"
        "appTor" = "TorProject.TorBrowser"
        "appVivaldi" = "Vivaldi.Vivaldi"
        "appDiscord" = "Discord.Discord"
        "appSlack" = "SlackTechnologies.Slack"
        "appTelegram" = "Telegram.TelegramDesktop"
        "appSignal" = "OpenWhisperSystems.Signal"
        "appElement" = "Element.Element"
        "appThunderbird" = "Mozilla.Thunderbird"
        "appPython" = "Python.Python.3.11"
        "appGit" = "Git.Git"
        "appVSCode" = "Microsoft.VisualStudioCode"
        "appNodeJS" = "OpenJS.NodeJS.LTS"
        "appGo" = "GoLang.Go"
        "appRust" = "Rustlang.Rust.MSVC"
        "appJava" = "Amazon.Corretto.21.JDK"
        "appDocker" = "Docker.DockerDesktop"
        "appGitHubCLI" = "GitHub.cli"
        "appGitHubDesktop" = "GitHub.GitHubDesktop"
        "appNeovim" = "Neovim.Neovim"
        "appSublime" = "SublimeHQ.SublimeText.4"
        "appNotepadpp" = "Notepad++.Notepad++"
        "appPostman" = "Postman.Postman"
        "appJetBrains" = "JetBrains.Toolbox"
        "appNmap" = "Insecure.Nmap"
        "appWireshark" = "WiresharkFoundation.Wireshark"
        "appBurp" = "PortSwigger.BurpSuite.Community"
        "appPuTTY" = "PuTTY.PuTTY"
        "appWinSCP" = "WinSCP.WinSCP"
        "appOpenVPN" = "OpenVPNTechnologies.OpenVPN"
        "appTailscale" = "tailscale.tailscale"
        "appmRemoteNG" = "mRemoteNG.mRemoteNG"
        "appRustDesk" = "RustDesk.RustDesk"
        "appSimplewall" = "Henry++.simplewall"
        "app7zip" = "7zip.7zip"
        "appTerminal" = "Microsoft.WindowsTerminal"
        "appPowerShell" = "Microsoft.PowerShell"
        "appPowerToys" = "Microsoft.PowerToys"
        "appEverything" = "voidtools.Everything"
        "appShareX" = "ShareX.ShareX"
        "appVLC" = "VideoLAN.VLC"
        "appOBS" = "OBSProject.OBSStudio"
        "appGIMP" = "GIMP.GIMP"
        "appBlender" = "BlenderFoundation.Blender"
        "appAudacity" = "Audacity.Audacity"
        "appHandBrake" = "HandBrake.HandBrake"
        "appKdenlive" = "KDE.Kdenlive"
        "appSteam" = "Valve.Steam"
        "appEpic" = "EpicGames.EpicGamesLauncher"
        "appGOG" = "GOG.Galaxy"
        "appPlaynite" = "Playnite.Playnite"
        "appLibreOffice" = "TheDocumentFoundation.LibreOffice"
        "appObsidian" = "Obsidian.Obsidian"
        "appSumatraPDF" = "SumatraPDF.SumatraPDF"
    }

    $installed = 0
    foreach ($app in $appMappings.Keys) {
        $checkbox = $Window.FindName($app)
        if ($checkbox -and $checkbox.IsChecked) {
            Install-App -AppId $appMappings[$app]
            $installed++
        }
    }

    if ($installed -gt 0) {
        Update-Status "Installed $installed apps!"
        [System.Windows.MessageBox]::Show("Successfully installed $installed apps!", "D1337 WinUtil", "OK", "Information")
    } else {
        [System.Windows.MessageBox]::Show("No apps selected!", "D1337 WinUtil", "OK", "Warning")
    }
})

$Window.FindName("btnSelectAll").Add_Click({
    $appNames = @("appBrave","appChrome","appFirefox","appLibreWolf","appTor","appVivaldi","appDiscord","appSlack","appTelegram","appSignal","appElement","appThunderbird","appPython","appGit","appVSCode","appNodeJS","appGo","appRust","appJava","appDocker","appGitHubCLI","appGitHubDesktop","appNeovim","appSublime","appNotepadpp","appPostman","appJetBrains","appNmap","appWireshark","appBurp","appPuTTY","appWinSCP","appOpenVPN","appTailscale","appmRemoteNG","appRustDesk","appSimplewall","app7zip","appTerminal","appPowerShell","appPowerToys","appEverything","appShareX","appVLC","appOBS","appGIMP","appBlender","appAudacity","appHandBrake","appKdenlive","appSteam","appEpic","appGOG","appPlaynite","appLibreOffice","appObsidian","appSumatraPDF")
    foreach ($name in $appNames) {
        $cb = $Window.FindName($name)
        if ($cb) { $cb.IsChecked = $true }
    }
})

$Window.FindName("btnDeselectAll").Add_Click({
    $appNames = @("appBrave","appChrome","appFirefox","appLibreWolf","appTor","appVivaldi","appDiscord","appSlack","appTelegram","appSignal","appElement","appThunderbird","appPython","appGit","appVSCode","appNodeJS","appGo","appRust","appJava","appDocker","appGitHubCLI","appGitHubDesktop","appNeovim","appSublime","appNotepadpp","appPostman","appJetBrains","appNmap","appWireshark","appBurp","appPuTTY","appWinSCP","appOpenVPN","appTailscale","appmRemoteNG","appRustDesk","appSimplewall","app7zip","appTerminal","appPowerShell","appPowerToys","appEverything","appShareX","appVLC","appOBS","appGIMP","appBlender","appAudacity","appHandBrake","appKdenlive","appSteam","appEpic","appGOG","appPlaynite","appLibreOffice","appObsidian","appSumatraPDF")
    foreach ($name in $appNames) {
        $cb = $Window.FindName($name)
        if ($cb) { $cb.IsChecked = $false }
    }
})

# Fresh RDP Presets
$Window.FindName("btnFullHacker").Add_Click({
    $result = [System.Windows.MessageBox]::Show("Install FULL HACKER SETUP?`n`nIncludes: Python, Git, VS Code, Node.js, Go, Nmap, Wireshark, Burp, Terminal, Firefox, 7zip, and more", "D1337 WinUtil", "YesNo", "Question")
    if ($result -eq "Yes") {
        Install-Winget
        $tools = @("Python.Python.3.11","Git.Git","Microsoft.VisualStudioCode","OpenJS.NodeJS.LTS","GoLang.Go","Insecure.Nmap","WiresharkFoundation.Wireshark","PortSwigger.BurpSuite.Community","PuTTY.PuTTY","WinSCP.WinSCP","7zip.7zip","Notepad++.Notepad++","Microsoft.WindowsTerminal","Microsoft.PowerShell","Mozilla.Firefox","Brave.Brave","Discord.Discord","voidtools.Everything","Microsoft.PowerToys")
        foreach ($t in $tools) { Install-App -AppId $t }
        Update-Status "Full Hacker Setup Complete!"
        [System.Windows.MessageBox]::Show("Full Hacker Setup completed!", "D1337 WinUtil", "OK", "Information")
    }
})

$Window.FindName("btnDevSetup").Add_Click({
    $result = [System.Windows.MessageBox]::Show("Install DEV SETUP?", "D1337 WinUtil", "YesNo", "Question")
    if ($result -eq "Yes") {
        Install-Winget
        $tools = @("Python.Python.3.11","Git.Git","Microsoft.VisualStudioCode","OpenJS.NodeJS.LTS","GoLang.Go","Docker.DockerDesktop","GitHub.cli","Microsoft.WindowsTerminal","Microsoft.PowerShell","Postman.Postman")
        foreach ($t in $tools) { Install-App -AppId $t }
        Update-Status "Dev Setup Complete!"
        [System.Windows.MessageBox]::Show("Dev Setup completed!", "D1337 WinUtil", "OK", "Information")
    }
})

$Window.FindName("btnSecuritySetup").Add_Click({
    $result = [System.Windows.MessageBox]::Show("Install SECURITY SETUP?", "D1337 WinUtil", "YesNo", "Question")
    if ($result -eq "Yes") {
        Install-Winget
        $tools = @("Python.Python.3.11","Git.Git","Insecure.Nmap","WiresharkFoundation.Wireshark","PortSwigger.BurpSuite.Community","PuTTY.PuTTY","WinSCP.WinSCP","TorProject.TorBrowser","mRemoteNG.mRemoteNG","Henry++.simplewall")
        foreach ($t in $tools) { Install-App -AppId $t }
        Update-Status "Security Setup Complete!"
        [System.Windows.MessageBox]::Show("Security Setup completed!", "D1337 WinUtil", "OK", "Information")
    }
})

$Window.FindName("btnMinimalSetup").Add_Click({
    $result = [System.Windows.MessageBox]::Show("Install MINIMAL SETUP?", "D1337 WinUtil", "YesNo", "Question")
    if ($result -eq "Yes") {
        Install-Winget
        $tools = @("Python.Python.3.11","Git.Git","7zip.7zip","Notepad++.Notepad++","Microsoft.WindowsTerminal")
        foreach ($t in $tools) { Install-App -AppId $t }
        Update-Status "Minimal Setup Complete!"
        [System.Windows.MessageBox]::Show("Minimal Setup completed!", "D1337 WinUtil", "OK", "Information")
    }
})

$Window.FindName("btnGamingSetup").Add_Click({
    $result = [System.Windows.MessageBox]::Show("Install GAMING SETUP?", "D1337 WinUtil", "YesNo", "Question")
    if ($result -eq "Yes") {
        Install-Winget
        $tools = @("Valve.Steam","EpicGames.EpicGamesLauncher","GOG.Galaxy","Discord.Discord","Playnite.Playnite","7zip.7zip","Microsoft.WindowsTerminal")
        foreach ($t in $tools) { Install-App -AppId $t }
        Update-Status "Gaming Setup Complete!"
        [System.Windows.MessageBox]::Show("Gaming Setup completed!", "D1337 WinUtil", "OK", "Information")
    }
})

$Window.FindName("btnCreatorSetup").Add_Click({
    $result = [System.Windows.MessageBox]::Show("Install CREATOR SETUP?", "D1337 WinUtil", "YesNo", "Question")
    if ($result -eq "Yes") {
        Install-Winget
        $tools = @("OBSProject.OBSStudio","GIMP.GIMP","BlenderFoundation.Blender","Audacity.Audacity","HandBrake.HandBrake","KDE.Kdenlive","VideoLAN.VLC","7zip.7zip","Microsoft.WindowsTerminal")
        foreach ($t in $tools) { Install-App -AppId $t }
        Update-Status "Creator Setup Complete!"
        [System.Windows.MessageBox]::Show("Creator Setup completed!", "D1337 WinUtil", "OK", "Information")
    }
})

# Debloat
$Window.FindName("btnDebloatSelected").Add_Click({
    $bloatMappings = @{
        "dbCortana" = "Microsoft.549981C3F5F10"
        "dbXbox" = "Microsoft.Xbox"
        "dbOneDrive" = "OneDrive"
        "dbTeams" = "MicrosoftTeams"
        "dbSkype" = "Microsoft.SkypeApp"
        "dbTodo" = "Microsoft.Todos"
        "dbMail" = "microsoft.windowscommunicationsapps"
        "dbMaps" = "Microsoft.WindowsMaps"
        "dbPeople" = "Microsoft.People"
        "dbYourPhone" = "Microsoft.YourPhone"
        "dbOfficeHub" = "Microsoft.MicrosoftOfficeHub"
        "dbOneNote" = "Microsoft.Office.OneNote"
        "dbSpotify" = "SpotifyAB.SpotifyMusic"
        "dbBingWeather" = "Microsoft.BingWeather"
        "dbBingNews" = "Microsoft.BingNews"
        "dbSolitaire" = "Microsoft.MicrosoftSolitaireCollection"
        "dbCandyCrush" = "king.com.CandyCrush"
        "dbDisney" = "Disney"
        "dbTikTok" = "TikTok"
        "dbInstagram" = "Instagram"
        "dbFacebook" = "Facebook"
        "dbAmazon" = "Amazon"
        "dbClipchamp" = "Clipchamp"
        "dbMixedReality" = "Microsoft.MixedReality.Portal"
        "db3DViewer" = "Microsoft.Microsoft3DViewer"
        "dbFeedback" = "Microsoft.WindowsFeedbackHub"
        "dbGetHelp" = "Microsoft.GetHelp"
        "dbTips" = "Microsoft.Getstarted"
        "dbStickyNotes" = "Microsoft.MicrosoftStickyNotes"
        "dbAlarms" = "Microsoft.WindowsAlarms"
        "dbCamera" = "Microsoft.WindowsCamera"
        "dbVoiceRecorder" = "Microsoft.WindowsSoundRecorder"
        "dbGrooveMusic" = "Microsoft.ZuneMusic"
    }

    $removed = 0
    foreach ($app in $bloatMappings.Keys) {
        $checkbox = $Window.FindName($app)
        if ($checkbox -and $checkbox.IsChecked) {
            Remove-BloatApp -AppName $bloatMappings[$app]
            $removed++
        }
    }

    # Special handling for OneDrive
    $chkOneDrive = $Window.FindName("dbOneDrive")
    if ($chkOneDrive -and $chkOneDrive.IsChecked) {
        Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue
        if (Test-Path "$env:SystemRoot\SysWOW64\OneDriveSetup.exe") {
            Start-Process "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" "/uninstall" -Wait
        } elseif (Test-Path "$env:SystemRoot\System32\OneDriveSetup.exe") {
            Start-Process "$env:SystemRoot\System32\OneDriveSetup.exe" "/uninstall" -Wait
        }
    }

    Update-Status "Debloat complete! Removed $removed apps"
    [System.Windows.MessageBox]::Show("Debloat completed! Removed $removed apps.", "D1337 WinUtil", "OK", "Information")
})

$Window.FindName("btnDebloatAll").Add_Click({
    $result = [System.Windows.MessageBox]::Show("WARNING: This will remove ALL bloatware!`n`nAre you sure?", "D1337 WinUtil", "YesNo", "Warning")
    if ($result -eq "Yes") {
        $allBloat = @("Microsoft.549981C3F5F10","Microsoft.Xbox","Microsoft.SkypeApp","Microsoft.Todos","microsoft.windowscommunicationsapps","Microsoft.WindowsMaps","Microsoft.People","Microsoft.YourPhone","Microsoft.MicrosoftOfficeHub","SpotifyAB.SpotifyMusic","Microsoft.BingWeather","Microsoft.BingNews","Microsoft.MicrosoftSolitaireCollection","king.com.CandyCrush","Microsoft.MixedReality.Portal","Microsoft.Microsoft3DViewer","Microsoft.WindowsFeedbackHub","Microsoft.GetHelp","Microsoft.Getstarted","Microsoft.MicrosoftStickyNotes","Microsoft.WindowsAlarms","Microsoft.WindowsSoundRecorder","Microsoft.ZuneMusic")
        foreach ($app in $allBloat) { Remove-BloatApp -AppName $app }
        Update-Status "Full debloat complete!"
        [System.Windows.MessageBox]::Show("Full debloat completed!", "D1337 WinUtil", "OK", "Information")
    }
})

# Performance Tweaks
$Window.FindName("btnApplyPerformance").Add_Click({
    Update-Status "Applying performance tweaks..."

    $perfVisualEffects = $Window.FindName("perfVisualEffects")
    $perfTransparency = $Window.FindName("perfTransparency")
    $perfGameMode = $Window.FindName("perfGameMode")
    $perfUltimatePower = $Window.FindName("perfUltimatePower")
    $perfHibernate = $Window.FindName("perfHibernate")
    $perfSearchIndex = $Window.FindName("perfSearchIndex")
    $perfSysMain = $Window.FindName("perfSysMain")
    $perfNagle = $Window.FindName("perfNagle")
    $perfThrottling = $Window.FindName("perfThrottling")
    $perfDNS = $Window.FindName("perfDNS")
    $perfFSO = $Window.FindName("perfFSO")
    $perfMouseAccel = $Window.FindName("perfMouseAccel")

    if ($perfVisualEffects.IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 -Force -ErrorAction SilentlyContinue
    }
    if ($perfTransparency.IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -Force -ErrorAction SilentlyContinue
    }
    if ($perfGameMode.IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1 -Force -ErrorAction SilentlyContinue
    }
    if ($perfUltimatePower.IsChecked) {
        powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>$null
    }
    if ($perfHibernate.IsChecked) {
        powercfg -h off
    }
    if ($perfSearchIndex.IsChecked) {
        Stop-Service "WSearch" -Force -ErrorAction SilentlyContinue
        Set-Service "WSearch" -StartupType Disabled -ErrorAction SilentlyContinue
    }
    if ($perfSysMain.IsChecked) {
        Stop-Service "SysMain" -Force -ErrorAction SilentlyContinue
        Set-Service "SysMain" -StartupType Disabled -ErrorAction SilentlyContinue
    }
    if ($perfNagle.IsChecked) {
        $adapters = Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
        foreach ($adapter in $adapters) {
            Set-ItemProperty -Path $adapter.PSPath -Name "TcpAckFrequency" -Value 1 -Force -ErrorAction SilentlyContinue
            Set-ItemProperty -Path $adapter.PSPath -Name "TCPNoDelay" -Value 1 -Force -ErrorAction SilentlyContinue
        }
    }
    if ($perfThrottling.IsChecked) {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xffffffff -Force -ErrorAction SilentlyContinue
    }
    if ($perfDNS.IsChecked) {
        $adapters = Get-NetAdapter | Where-Object {$_.Status -eq "Up"}
        foreach ($adapter in $adapters) {
            Set-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex -ServerAddresses ("1.1.1.1","1.0.0.1") -ErrorAction SilentlyContinue
        }
    }
    if ($perfFSO.IsChecked) {
        New-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehaviorMode" -Value 2 -PropertyType DWord -Force -ErrorAction SilentlyContinue
    }
    if ($perfMouseAccel.IsChecked) {
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value "0" -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value "0" -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value "0" -Force -ErrorAction SilentlyContinue
    }

    Update-Status "Performance tweaks applied!"
    [System.Windows.MessageBox]::Show("Performance tweaks applied! Restart recommended.", "D1337 WinUtil", "OK", "Information")
})

# Tweaks Tab - Essential
$Window.FindName("btnApplyEssential").Add_Click({
    Update-Status "Applying essential tweaks..."

    # Disable Telemetry
    if ($Window.FindName("twkTelemetry").IsChecked) {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Force -ErrorAction SilentlyContinue
        Stop-Service "DiagTrack" -Force -ErrorAction SilentlyContinue
        Set-Service "DiagTrack" -StartupType Disabled -ErrorAction SilentlyContinue
    }

    # Disable Activity History
    if ($Window.FindName("twkActivityHistory").IsChecked) {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0 -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0 -Force -ErrorAction SilentlyContinue
    }

    # Disable Location
    if ($Window.FindName("twkLocation").IsChecked) {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Value 1 -Force -ErrorAction SilentlyContinue
    }

    # Disable WiFi Sense
    if ($Window.FindName("twkWiFiSense").IsChecked) {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -Value 0 -Force -ErrorAction SilentlyContinue
    }

    # Disable Hibernation
    if ($Window.FindName("twkHibernation").IsChecked) {
        powercfg -h off
    }

    # Disable GameDVR
    if ($Window.FindName("twkGameDVR").IsChecked) {
        Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0 -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" -Name "AllowGameDVR" -Value 0 -Force -ErrorAction SilentlyContinue
    }

    # End Task Right-Click
    if ($Window.FindName("twkEndTask").IsChecked) {
        New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings" -Name "TaskbarEndTask" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue
    }

    # Delete Temp Files
    if ($Window.FindName("twkTempFiles").IsChecked) {
        Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
    }

    # Disk Cleanup
    if ($Window.FindName("twkDiskCleanup").IsChecked) {
        Start-Process cleanmgr -ArgumentList "/sagerun:1" -Wait
    }

    Update-Status "Essential tweaks applied!"
    [System.Windows.MessageBox]::Show("Essential tweaks applied!", "D1337 WinUtil", "OK", "Information")
})

# Tweaks Tab - Advanced
$Window.FindName("btnApplyAdvanced").Add_Click({
    Update-Status "Applying advanced tweaks..."

    # Disable Copilot
    if ($Window.FindName("twkCopilot").IsChecked) {
        New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Force -ErrorAction SilentlyContinue | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Name "TurnOffWindowsCopilot" -Value 1 -Force -ErrorAction SilentlyContinue
    }

    # Disable Recall
    if ($Window.FindName("twkRecall").IsChecked) {
        New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsAI" -Force -ErrorAction SilentlyContinue | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsAI" -Name "DisableAIDataAnalysis" -Value 1 -Force -ErrorAction SilentlyContinue
    }

    # Disable Edge
    if ($Window.FindName("twkEdgeDisable").IsChecked) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Force -ErrorAction SilentlyContinue | Out-Null
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Name "PreventFirstRunPage" -Value 1 -Force -ErrorAction SilentlyContinue
    }

    # Classic Right-Click Menu
    if ($Window.FindName("twkClassicMenu").IsChecked) {
        New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Force -ErrorAction SilentlyContinue | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value "" -Force -ErrorAction SilentlyContinue
    }

    # Remove Home from Explorer
    if ($Window.FindName("twkRemoveHome").IsChecked) {
        New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -PropertyType DWord -Force -ErrorAction SilentlyContinue
    }

    # Disable Storage Sense
    if ($Window.FindName("twkStorageSense").IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" -Name "01" -Value 0 -Force -ErrorAction SilentlyContinue
    }

    # Disable Background Apps
    if ($Window.FindName("twkBgApps").IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Name "GlobalUserDisabled" -Value 1 -Force -ErrorAction SilentlyContinue
    }

    # Prefer IPv4
    if ($Window.FindName("twkIPv6").IsChecked) {
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" -Name "DisabledComponents" -Value 32 -Force -ErrorAction SilentlyContinue
    }

    # Disable Teredo
    if ($Window.FindName("twkTeredo").IsChecked) {
        netsh interface teredo set state disabled
    }

    Update-Status "Advanced tweaks applied!"
    [System.Windows.MessageBox]::Show("Advanced tweaks applied! Restart recommended.", "D1337 WinUtil", "OK", "Information")
})

# Tweaks Tab - Debloat
$Window.FindName("btnApplyDebloat").Add_Click({
    Update-Status "Applying debloat tweaks..."

    # Dark Mode
    if ($Window.FindName("twkDarkMode").IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Force
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Force
    }

    # Disable Bing Search
    if ($Window.FindName("twkBingSearch").IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Value 0 -Force -ErrorAction SilentlyContinue
    }

    # NumLock
    if ($Window.FindName("twkNumLock").IsChecked) {
        Set-ItemProperty -Path "Registry::HKU\.DEFAULT\Control Panel\Keyboard" -Name "InitialKeyboardIndicators" -Value "2" -Force -ErrorAction SilentlyContinue
    }

    # Disable Start Recommendations
    if ($Window.FindName("twkRecommendations").IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_IrisRecommendations" -Value 0 -Force -ErrorAction SilentlyContinue
    }

    Update-Status "Debloat tweaks applied!"
    [System.Windows.MessageBox]::Show("Debloat tweaks applied!", "D1337 WinUtil", "OK", "Information")
})

# Config Tab - Windows Features
$Window.FindName("btnEnableWSL").Add_Click({
    Update-Status "Enabling WSL..."
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
    [System.Windows.MessageBox]::Show("WSL enabled! Restart required.", "D1337 WinUtil", "OK", "Information")
})

$Window.FindName("btnEnableHyperV").Add_Click({
    Update-Status "Enabling Hyper-V..."
    dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V-All /all /norestart
    [System.Windows.MessageBox]::Show("Hyper-V enabled! Restart required.", "D1337 WinUtil", "OK", "Information")
})

$Window.FindName("btnEnableSandbox").Add_Click({
    Update-Status "Enabling Windows Sandbox..."
    dism.exe /online /enable-feature /featurename:Containers-DisposableClientVM /all /norestart
    [System.Windows.MessageBox]::Show("Sandbox enabled! Restart required.", "D1337 WinUtil", "OK", "Information")
})

$Window.FindName("btnEnableNET").Add_Click({
    Update-Status "Enabling .NET 3.5..."
    dism.exe /online /enable-feature /featurename:NetFx3 /all /norestart
    [System.Windows.MessageBox]::Show(".NET 3.5 enabled!", "D1337 WinUtil", "OK", "Information")
})

# Config Tab - Fixes
$Window.FindName("btnSFC").Add_Click({
    Update-Status "Running SFC..."
    Start-Process powershell -ArgumentList "-Command sfc /scannow" -Verb RunAs -Wait
    Update-Status "SFC completed"
})

$Window.FindName("btnDISM").Add_Click({
    Update-Status "Running DISM..."
    Start-Process powershell -ArgumentList "-Command DISM /Online /Cleanup-Image /RestoreHealth" -Verb RunAs -Wait
    Update-Status "DISM completed"
})

$Window.FindName("btnFlushDNS").Add_Click({
    ipconfig /flushdns
    [System.Windows.MessageBox]::Show("DNS cache flushed!", "D1337 WinUtil", "OK", "Information")
})

$Window.FindName("btnResetNetwork").Add_Click({
    netsh winsock reset
    netsh int ip reset
    [System.Windows.MessageBox]::Show("Network reset! Restart required.", "D1337 WinUtil", "OK", "Information")
})

$Window.FindName("btnResetWinsock").Add_Click({
    netsh winsock reset
    [System.Windows.MessageBox]::Show("Winsock reset! Restart required.", "D1337 WinUtil", "OK", "Information")
})

$Window.FindName("btnClearIconCache").Add_Click({
    ie4uinit.exe -show
    [System.Windows.MessageBox]::Show("Icon cache cleared!", "D1337 WinUtil", "OK", "Information")
})

# Config Tab - Shortcuts
$Window.FindName("btnDevMgr").Add_Click({ Start-Process devmgmt.msc })
$Window.FindName("btnDiskMgmt").Add_Click({ Start-Process diskmgmt.msc })
$Window.FindName("btnServices").Add_Click({ Start-Process services.msc })
$Window.FindName("btnRegedit").Add_Click({ Start-Process regedit })
$Window.FindName("btnMsconfig").Add_Click({ Start-Process msconfig })
$Window.FindName("btnGpedit").Add_Click({ Start-Process gpedit.msc })
$Window.FindName("btnTaskMgr").Add_Click({ Start-Process taskmgr })
$Window.FindName("btnSysInfo").Add_Click({ Start-Process msinfo32 })

# Config Tab - Explorer Options
$Window.FindName("btnApplyExplorerConfig").Add_Click({
    $cfgShowHidden = $Window.FindName("cfgShowHidden")
    $cfgShowExtensions = $Window.FindName("cfgShowExtensions")
    $cfgShowFullPath = $Window.FindName("cfgShowFullPath")
    $cfgLaunchToThisPC = $Window.FindName("cfgLaunchToThisPC")

    if ($cfgShowHidden.IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Value 1 -Force
    }
    if ($cfgShowExtensions.IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Force
    }
    if ($cfgShowFullPath.IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState" -Name "FullPath" -Value 1 -Force
    }
    if ($cfgLaunchToThisPC.IsChecked) {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -Force
    }

    # Restart Explorer
    Stop-Process -Name explorer -Force
    Start-Process explorer

    [System.Windows.MessageBox]::Show("Explorer options applied!", "D1337 WinUtil", "OK", "Information")
})

# Updates Tab
$Window.FindName("btnApplyUpdates").Add_Click({
    Update-Status "Applying update settings..."

    if ($Window.FindName("updDisableAuto").IsChecked) {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 1 -Force -ErrorAction SilentlyContinue
    }
    if ($Window.FindName("updNoDrivers").IsChecked) {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Value 1 -Force -ErrorAction SilentlyContinue
    }
    if ($Window.FindName("updNoRestart").IsChecked) {
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoRebootWithLoggedOnUsers" -Value 1 -Force -ErrorAction SilentlyContinue
    }

    [System.Windows.MessageBox]::Show("Update settings applied!", "D1337 WinUtil", "OK", "Information")
})

$Window.FindName("btnCheckUpdates").Add_Click({
    Start-Process "ms-settings:windowsupdate"
})

$Window.FindName("btnPauseUpdates").Add_Click({
    $pause = (Get-Date).AddDays(7).ToString("yyyy-MM-dd")
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "PauseUpdatesExpiryTime" -Value $pause -Force -ErrorAction SilentlyContinue
    [System.Windows.MessageBox]::Show("Updates paused for 7 days!", "D1337 WinUtil", "OK", "Information")
})

$Window.FindName("btnPause30").Add_Click({
    $pause = (Get-Date).AddDays(30).ToString("yyyy-MM-dd")
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "PauseUpdatesExpiryTime" -Value $pause -Force -ErrorAction SilentlyContinue
    [System.Windows.MessageBox]::Show("Updates paused for 30 days!", "D1337 WinUtil", "OK", "Information")
})

$Window.FindName("btnResumeUpdates").Add_Click({
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "PauseUpdatesExpiryTime" -Force -ErrorAction SilentlyContinue
    [System.Windows.MessageBox]::Show("Updates resumed!", "D1337 WinUtil", "OK", "Information")
})

$Window.FindName("btnResetUpdates").Add_Click({
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Force -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" -Name "ExcludeWUDriversInQualityUpdate" -Force -ErrorAction SilentlyContinue
    [System.Windows.MessageBox]::Show("Update settings reset to default!", "D1337 WinUtil", "OK", "Information")
})

# About Tab
$Window.FindName("btnGitHub").Add_Click({ Start-Process "https://github.com/Boshe99/d1337-installer" })
$Window.FindName("btnWebsite").Add_Click({ Start-Process "https://tools.d1337.ai" })
$Window.FindName("btnDiscord").Add_Click({ Start-Process "https://discord.gg/moneyhunter" })

# Show Window
$Window.ShowDialog() | Out-Null
