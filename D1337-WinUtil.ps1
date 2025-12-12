<#
.SYNOPSIS
    D1337 WinUtil - Windows Utility Tool by MoneyHunter Community
.DESCRIPTION
    A comprehensive Windows utility for debloating, installing hacking tools,
    privacy tweaks, and performance optimization.
.AUTHOR
    D1337 | MoneyHunter Community
    GitHub: https://github.com/Boshe99
.VERSION
    1.0.0
#>

# Require Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Please run as Administrator!"
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms

# ==================== XAML GUI ====================
[xml]$XAML = @"
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="D1337 WinUtil v1.0 | MoneyHunter"
    Height="700" Width="900"
    WindowStartupLocation="CenterScreen"
    Background="#0a0a0a"
    ResizeMode="CanMinimize">

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
            <Setter Property="Margin" Value="5"/>
            <Setter Property="FontFamily" Value="Consolas"/>
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
        </Style>
    </Window.Resources>

    <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Header -->
        <Border Grid.Row="0" Background="#0d0d0d" Padding="20">
            <StackPanel>
                <TextBlock Text="██████╗  ██╗██████╗ ██████╗ ███████╗" FontSize="10" HorizontalAlignment="Center"/>
                <TextBlock Text="██╔══██╗███║╚════██╗╚════██╗╚════██║" FontSize="10" HorizontalAlignment="Center"/>
                <TextBlock Text="██║  ██║╚██║ █████╔╝ █████╔╝    ██╔╝" FontSize="10" HorizontalAlignment="Center"/>
                <TextBlock Text="██║  ██║ ██║ ╚═══██╗ ╚═══██╗   ██╔╝ " FontSize="10" HorizontalAlignment="Center"/>
                <TextBlock Text="██████╔╝ ██║██████╔╝██████╔╝   ██║  " FontSize="10" HorizontalAlignment="Center"/>
                <TextBlock Text="╚═════╝  ╚═╝╚═════╝ ╚═════╝    ╚═╝  " FontSize="10" HorizontalAlignment="Center"/>
                <TextBlock Text="W I N U T I L" FontSize="24" FontWeight="Bold" HorizontalAlignment="Center" Margin="0,10,0,0"/>
                <TextBlock Text="by MoneyHunter Community" FontSize="12" HorizontalAlignment="Center" Foreground="#888888"/>
            </StackPanel>
        </Border>

        <!-- Main Content -->
        <TabControl Grid.Row="1" Background="#0a0a0a" BorderBrush="#00ff00" Margin="10">

            <!-- Tab 1: Debloat -->
            <TabItem Header=" DEBLOAT ">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <StackPanel Margin="20">
                        <TextBlock Text="[WINDOWS DEBLOATER]" FontSize="16" FontWeight="Bold" Margin="0,0,0,15"/>

                        <TextBlock Text="Remove Bloatware Apps:" FontWeight="Bold" Margin="0,10,0,5"/>
                        <CheckBox x:Name="chkCortana" Content="Remove Cortana"/>
                        <CheckBox x:Name="chkXbox" Content="Remove Xbox Apps"/>
                        <CheckBox x:Name="chkOneDrive" Content="Remove OneDrive"/>
                        <CheckBox x:Name="chkTeams" Content="Remove Microsoft Teams"/>
                        <CheckBox x:Name="chkSkype" Content="Remove Skype"/>
                        <CheckBox x:Name="chkSpotify" Content="Remove Spotify"/>
                        <CheckBox x:Name="chkBingWeather" Content="Remove Bing Weather"/>
                        <CheckBox x:Name="chkBingNews" Content="Remove Bing News"/>
                        <CheckBox x:Name="chkSolitaire" Content="Remove Solitaire"/>
                        <CheckBox x:Name="chkMixedReality" Content="Remove Mixed Reality Portal"/>
                        <CheckBox x:Name="chk3DViewer" Content="Remove 3D Viewer"/>
                        <CheckBox x:Name="chkFeedback" Content="Remove Feedback Hub"/>

                        <Button x:Name="btnDebloat" Content="[EXECUTE DEBLOAT]" Width="200" Margin="0,20,0,0"/>
                    </StackPanel>
                </ScrollViewer>
            </TabItem>

            <!-- Tab 2: Install Tools -->
            <TabItem Header=" INSTALL TOOLS ">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <StackPanel Margin="20">
                        <TextBlock Text="[HACKING TOOLS INSTALLER]" FontSize="16" FontWeight="Bold" Margin="0,0,0,15"/>

                        <TextBlock Text="Development:" FontWeight="Bold" Margin="0,10,0,5"/>
                        <CheckBox x:Name="chkPython" Content="Python 3.x"/>
                        <CheckBox x:Name="chkGit" Content="Git"/>
                        <CheckBox x:Name="chkVSCode" Content="Visual Studio Code"/>
                        <CheckBox x:Name="chkNodeJS" Content="Node.js"/>
                        <CheckBox x:Name="chkGolang" Content="Go (Golang)"/>

                        <TextBlock Text="Security Tools:" FontWeight="Bold" Margin="0,15,0,5"/>
                        <CheckBox x:Name="chkNmap" Content="Nmap"/>
                        <CheckBox x:Name="chkWireshark" Content="Wireshark"/>
                        <CheckBox x:Name="chkBurp" Content="Burp Suite Community"/>
                        <CheckBox x:Name="chkPutty" Content="PuTTY"/>
                        <CheckBox x:Name="chkWinSCP" Content="WinSCP"/>

                        <TextBlock Text="Utilities:" FontWeight="Bold" Margin="0,15,0,5"/>
                        <CheckBox x:Name="chk7zip" Content="7-Zip"/>
                        <CheckBox x:Name="chkNotepadpp" Content="Notepad++"/>
                        <CheckBox x:Name="chkSublime" Content="Sublime Text"/>
                        <CheckBox x:Name="chkTerminal" Content="Windows Terminal"/>
                        <CheckBox x:Name="chkPowershell7" Content="PowerShell 7"/>

                        <TextBlock Text="Browsers:" FontWeight="Bold" Margin="0,15,0,5"/>
                        <CheckBox x:Name="chkFirefox" Content="Firefox"/>
                        <CheckBox x:Name="chkBrave" Content="Brave Browser"/>
                        <CheckBox x:Name="chkTor" Content="Tor Browser"/>

                        <Button x:Name="btnInstall" Content="[INSTALL SELECTED]" Width="200" Margin="0,20,0,0"/>
                    </StackPanel>
                </ScrollViewer>
            </TabItem>

            <!-- Tab 3: Privacy -->
            <TabItem Header=" PRIVACY ">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <StackPanel Margin="20">
                        <TextBlock Text="[PRIVACY TWEAKS]" FontSize="16" FontWeight="Bold" Margin="0,0,0,15"/>

                        <TextBlock Text="Telemetry:" FontWeight="Bold" Margin="0,10,0,5"/>
                        <CheckBox x:Name="chkTelemetry" Content="Disable Windows Telemetry"/>
                        <CheckBox x:Name="chkDiagnostics" Content="Disable Diagnostic Data"/>
                        <CheckBox x:Name="chkAdvertisingID" Content="Disable Advertising ID"/>
                        <CheckBox x:Name="chkActivityHistory" Content="Disable Activity History"/>

                        <TextBlock Text="Tracking:" FontWeight="Bold" Margin="0,15,0,5"/>
                        <CheckBox x:Name="chkLocation" Content="Disable Location Tracking"/>
                        <CheckBox x:Name="chkCamera" Content="Disable Camera for Apps"/>
                        <CheckBox x:Name="chkMicrophone" Content="Disable Microphone for Apps"/>
                        <CheckBox x:Name="chkClipboard" Content="Disable Clipboard History"/>

                        <TextBlock Text="Services:" FontWeight="Bold" Margin="0,15,0,5"/>
                        <CheckBox x:Name="chkDefenderTelemetry" Content="Disable Defender Telemetry"/>
                        <CheckBox x:Name="chkErrorReporting" Content="Disable Error Reporting"/>
                        <CheckBox x:Name="chkWiFiSense" Content="Disable Wi-Fi Sense"/>

                        <Button x:Name="btnPrivacy" Content="[APPLY PRIVACY TWEAKS]" Width="200" Margin="0,20,0,0"/>
                    </StackPanel>
                </ScrollViewer>
            </TabItem>

            <!-- Tab 4: Performance -->
            <TabItem Header=" PERFORMANCE ">
                <ScrollViewer VerticalScrollBarVisibility="Auto">
                    <StackPanel Margin="20">
                        <TextBlock Text="[PERFORMANCE OPTIMIZATION]" FontSize="16" FontWeight="Bold" Margin="0,0,0,15"/>

                        <TextBlock Text="Visual Effects:" FontWeight="Bold" Margin="0,10,0,5"/>
                        <CheckBox x:Name="chkVisualEffects" Content="Disable Visual Effects"/>
                        <CheckBox x:Name="chkTransparency" Content="Disable Transparency"/>
                        <CheckBox x:Name="chkAnimations" Content="Disable Animations"/>

                        <TextBlock Text="System:" FontWeight="Bold" Margin="0,15,0,5"/>
                        <CheckBox x:Name="chkGameMode" Content="Enable Game Mode"/>
                        <CheckBox x:Name="chkUltimatePerf" Content="Enable Ultimate Performance Plan"/>
                        <CheckBox x:Name="chkFastStartup" Content="Disable Fast Startup (for SSD)"/>
                        <CheckBox x:Name="chkHibernation" Content="Disable Hibernation"/>

                        <TextBlock Text="Services:" FontWeight="Bold" Margin="0,15,0,5"/>
                        <CheckBox x:Name="chkSearchIndexing" Content="Disable Search Indexing"/>
                        <CheckBox x:Name="chkSuperFetch" Content="Disable SuperFetch/SysMain"/>
                        <CheckBox x:Name="chkPrintSpooler" Content="Disable Print Spooler"/>

                        <TextBlock Text="Network:" FontWeight="Bold" Margin="0,15,0,5"/>
                        <CheckBox x:Name="chkNagle" Content="Disable Nagle Algorithm"/>
                        <CheckBox x:Name="chkNetworkThrottling" Content="Disable Network Throttling"/>

                        <Button x:Name="btnPerformance" Content="[APPLY PERFORMANCE TWEAKS]" Width="200" Margin="0,20,0,0"/>
                    </StackPanel>
                </ScrollViewer>
            </TabItem>

            <!-- Tab 5: About -->
            <TabItem Header=" ABOUT ">
                <StackPanel Margin="20" HorizontalAlignment="Center" VerticalAlignment="Center">
                    <TextBlock Text="D1337 WinUtil" FontSize="28" FontWeight="Bold" HorizontalAlignment="Center"/>
                    <TextBlock Text="Version 1.0.0" FontSize="14" HorizontalAlignment="Center" Foreground="#888888" Margin="0,5,0,20"/>

                    <TextBlock Text="Created by MoneyHunter Community" FontSize="14" HorizontalAlignment="Center"/>
                    <TextBlock Text="GitHub: github.com/Boshe99" FontSize="12" HorizontalAlignment="Center" Foreground="#888888" Margin="0,5,0,20"/>

                    <TextBlock TextWrapping="Wrap" TextAlignment="Center" Width="400" Margin="0,20,0,0">
                        A Windows utility tool for hackers and power users.
                        Debloat Windows, install security tools, apply privacy
                        tweaks, and optimize performance - all in one place.
                    </TextBlock>

                    <TextBlock Text="USE AT YOUR OWN RISK" FontSize="12" Foreground="#ff0000" HorizontalAlignment="Center" Margin="0,30,0,0"/>
                    <TextBlock Text="Create a restore point before making changes!" FontSize="10" Foreground="#888888" HorizontalAlignment="Center"/>
                </StackPanel>
            </TabItem>
        </TabControl>

        <!-- Footer -->
        <Border Grid.Row="2" Background="#0d0d0d" Padding="10">
            <Grid>
                <TextBlock x:Name="txtStatus" Text="[STATUS] Ready" HorizontalAlignment="Left" VerticalAlignment="Center"/>
                <TextBlock Text="D1337 | MoneyHunter" HorizontalAlignment="Right" VerticalAlignment="Center" Foreground="#888888"/>
            </Grid>
        </Border>
    </Grid>
</Window>
"@

# Parse XAML
$reader = (New-Object System.Xml.XmlNodeReader $XAML)
$Window = [Windows.Markup.XamlReader]::Load($reader)

# Get Controls
$chkCortana = $Window.FindName("chkCortana")
$chkXbox = $Window.FindName("chkXbox")
$chkOneDrive = $Window.FindName("chkOneDrive")
$chkTeams = $Window.FindName("chkTeams")
$chkSkype = $Window.FindName("chkSkype")
$chkSpotify = $Window.FindName("chkSpotify")
$chkBingWeather = $Window.FindName("chkBingWeather")
$chkBingNews = $Window.FindName("chkBingNews")
$chkSolitaire = $Window.FindName("chkSolitaire")
$chkMixedReality = $Window.FindName("chkMixedReality")
$chk3DViewer = $Window.FindName("chk3DViewer")
$chkFeedback = $Window.FindName("chkFeedback")
$btnDebloat = $Window.FindName("btnDebloat")

$chkPython = $Window.FindName("chkPython")
$chkGit = $Window.FindName("chkGit")
$chkVSCode = $Window.FindName("chkVSCode")
$chkNodeJS = $Window.FindName("chkNodeJS")
$chkGolang = $Window.FindName("chkGolang")
$chkNmap = $Window.FindName("chkNmap")
$chkWireshark = $Window.FindName("chkWireshark")
$chkBurp = $Window.FindName("chkBurp")
$chkPutty = $Window.FindName("chkPutty")
$chkWinSCP = $Window.FindName("chkWinSCP")
$chk7zip = $Window.FindName("chk7zip")
$chkNotepadpp = $Window.FindName("chkNotepadpp")
$chkSublime = $Window.FindName("chkSublime")
$chkTerminal = $Window.FindName("chkTerminal")
$chkPowershell7 = $Window.FindName("chkPowershell7")
$chkFirefox = $Window.FindName("chkFirefox")
$chkBrave = $Window.FindName("chkBrave")
$chkTor = $Window.FindName("chkTor")
$btnInstall = $Window.FindName("btnInstall")

$btnPrivacy = $Window.FindName("btnPrivacy")
$btnPerformance = $Window.FindName("btnPerformance")
$txtStatus = $Window.FindName("txtStatus")

# ==================== FUNCTIONS ====================

function Update-Status {
    param([string]$Message)
    $txtStatus.Text = "[STATUS] $Message"
    $Window.Dispatcher.Invoke([action]{}, "Render")
}

# Debloat Functions
$btnDebloat.Add_Click({
    Update-Status "Starting debloat..."

    $apps = @()
    if ($chkCortana.IsChecked) { $apps += "Microsoft.549981C3F5F10" }
    if ($chkXbox.IsChecked) {
        $apps += "Microsoft.XboxApp"
        $apps += "Microsoft.XboxGameOverlay"
        $apps += "Microsoft.XboxGamingOverlay"
        $apps += "Microsoft.XboxIdentityProvider"
        $apps += "Microsoft.XboxSpeechToTextOverlay"
    }
    if ($chkOneDrive.IsChecked) {
        Stop-Process -Name "OneDrive" -Force -ErrorAction SilentlyContinue
        Start-Process "$env:SystemRoot\SysWOW64\OneDriveSetup.exe" "/uninstall" -Wait
    }
    if ($chkTeams.IsChecked) { $apps += "MicrosoftTeams" }
    if ($chkSkype.IsChecked) { $apps += "Microsoft.SkypeApp" }
    if ($chkSpotify.IsChecked) { $apps += "SpotifyAB.SpotifyMusic" }
    if ($chkBingWeather.IsChecked) { $apps += "Microsoft.BingWeather" }
    if ($chkBingNews.IsChecked) { $apps += "Microsoft.BingNews" }
    if ($chkSolitaire.IsChecked) { $apps += "Microsoft.MicrosoftSolitaireCollection" }
    if ($chkMixedReality.IsChecked) { $apps += "Microsoft.MixedReality.Portal" }
    if ($chk3DViewer.IsChecked) { $apps += "Microsoft.Microsoft3DViewer" }
    if ($chkFeedback.IsChecked) { $apps += "Microsoft.WindowsFeedbackHub" }

    foreach ($app in $apps) {
        Update-Status "Removing $app..."
        Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $app | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
    }

    Update-Status "Debloat complete!"
    [System.Windows.MessageBox]::Show("Debloat completed successfully!", "D1337 WinUtil", "OK", "Information")
})

# Install Tools Functions
$btnInstall.Add_Click({
    Update-Status "Installing tools via winget..."

    # Check if winget is available
    $winget = Get-Command winget -ErrorAction SilentlyContinue
    if (-not $winget) {
        [System.Windows.MessageBox]::Show("Winget not found! Please install App Installer from Microsoft Store.", "Error", "OK", "Error")
        return
    }

    $tools = @()
    if ($chkPython.IsChecked) { $tools += "Python.Python.3.11" }
    if ($chkGit.IsChecked) { $tools += "Git.Git" }
    if ($chkVSCode.IsChecked) { $tools += "Microsoft.VisualStudioCode" }
    if ($chkNodeJS.IsChecked) { $tools += "OpenJS.NodeJS.LTS" }
    if ($chkGolang.IsChecked) { $tools += "GoLang.Go" }
    if ($chkNmap.IsChecked) { $tools += "Insecure.Nmap" }
    if ($chkWireshark.IsChecked) { $tools += "WiresharkFoundation.Wireshark" }
    if ($chkBurp.IsChecked) { $tools += "PortSwigger.BurpSuite.Community" }
    if ($chkPutty.IsChecked) { $tools += "PuTTY.PuTTY" }
    if ($chkWinSCP.IsChecked) { $tools += "WinSCP.WinSCP" }
    if ($chk7zip.IsChecked) { $tools += "7zip.7zip" }
    if ($chkNotepadpp.IsChecked) { $tools += "Notepad++.Notepad++" }
    if ($chkSublime.IsChecked) { $tools += "SublimeHQ.SublimeText.4" }
    if ($chkTerminal.IsChecked) { $tools += "Microsoft.WindowsTerminal" }
    if ($chkPowershell7.IsChecked) { $tools += "Microsoft.PowerShell" }
    if ($chkFirefox.IsChecked) { $tools += "Mozilla.Firefox" }
    if ($chkBrave.IsChecked) { $tools += "Brave.Brave" }
    if ($chkTor.IsChecked) { $tools += "TorProject.TorBrowser" }

    foreach ($tool in $tools) {
        Update-Status "Installing $tool..."
        Start-Process winget -ArgumentList "install --id $tool --accept-source-agreements --accept-package-agreements -h" -Wait -NoNewWindow
    }

    Update-Status "Installation complete!"
    [System.Windows.MessageBox]::Show("Tools installed successfully!", "D1337 WinUtil", "OK", "Information")
})

# Privacy Tweaks
$btnPrivacy.Add_Click({
    Update-Status "Applying privacy tweaks..."

    # Disable Telemetry
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Force -ErrorAction SilentlyContinue

    # Disable Advertising ID
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" -Name "Enabled" -Value 0 -Force -ErrorAction SilentlyContinue

    # Disable Activity History
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0 -Force -ErrorAction SilentlyContinue
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0 -Force -ErrorAction SilentlyContinue

    # Disable Location
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Value 1 -Force -ErrorAction SilentlyContinue

    # Disable Error Reporting
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1 -Force -ErrorAction SilentlyContinue

    # Disable WiFi Sense
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -Value 0 -Force -ErrorAction SilentlyContinue

    Update-Status "Privacy tweaks applied!"
    [System.Windows.MessageBox]::Show("Privacy tweaks applied successfully!", "D1337 WinUtil", "OK", "Information")
})

# Performance Tweaks
$btnPerformance.Add_Click({
    Update-Status "Applying performance tweaks..."

    # Visual Effects - Best Performance
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" -Name "VisualFXSetting" -Value 2 -Force -ErrorAction SilentlyContinue

    # Disable Transparency
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Value 0 -Force -ErrorAction SilentlyContinue

    # Enable Game Mode
    Set-ItemProperty -Path "HKCU:\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -Value 1 -Force -ErrorAction SilentlyContinue

    # Ultimate Performance Power Plan
    powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 2>$null

    # Disable Hibernation
    powercfg -h off

    # Disable Search Indexing
    Stop-Service "WSearch" -Force -ErrorAction SilentlyContinue
    Set-Service "WSearch" -StartupType Disabled -ErrorAction SilentlyContinue

    # Disable SysMain (SuperFetch)
    Stop-Service "SysMain" -Force -ErrorAction SilentlyContinue
    Set-Service "SysMain" -StartupType Disabled -ErrorAction SilentlyContinue

    # Disable Nagle Algorithm
    $adapters = Get-ChildItem "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
    foreach ($adapter in $adapters) {
        Set-ItemProperty -Path $adapter.PSPath -Name "TcpAckFrequency" -Value 1 -Force -ErrorAction SilentlyContinue
        Set-ItemProperty -Path $adapter.PSPath -Name "TCPNoDelay" -Value 1 -Force -ErrorAction SilentlyContinue
    }

    Update-Status "Performance tweaks applied!"
    [System.Windows.MessageBox]::Show("Performance tweaks applied! Restart recommended.", "D1337 WinUtil", "OK", "Information")
})

# Show Window
$Window.ShowDialog() | Out-Null
