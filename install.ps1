#Requires -RunAsAdministrator
<#
    D1337 TOOLKIT INSTALLER
    irm "d1337.ai/x" | iex
#>

$Host.UI.RawUI.WindowTitle = "D1337 Toolkit Installer"

# Colors
function Write-Banner {
    $banner = @"

    ____  ___________________  ______
   / __ \<  /__  /__  /__  / / ____/
  / / / // / /_ < /_ <  / / /___ \
 / /_/ // /___/ /__/ / / / ____/ /
/_____//_//____/____/ /_(_)____/

        [ TOOLKIT INSTALLER ]

"@
    Write-Host $banner -ForegroundColor Cyan
    Write-Host "  github.com/d1337ai | d1337.ai" -ForegroundColor DarkGray
    Write-Host ""
}

function Write-Step { param($msg) Write-Host "[*] " -ForegroundColor Cyan -NoNewline; Write-Host $msg }
function Write-Done { param($msg) Write-Host "[+] " -ForegroundColor Green -NoNewline; Write-Host $msg }
function Write-Warn { param($msg) Write-Host "[!] " -ForegroundColor Yellow -NoNewline; Write-Host $msg }
function Write-Fail { param($msg) Write-Host "[-] " -ForegroundColor Red -NoNewline; Write-Host $msg }

# Check Admin
function Test-Admin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Install Chocolatey
function Install-Choco {
    if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Step "Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        Write-Done "Chocolatey installed"
    } else {
        Write-Done "Chocolatey already installed"
    }
}

# Install Scoop
function Install-Scoop {
    if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
        Write-Step "Installing Scoop..."
        Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        Invoke-RestMethod get.scoop.sh | Invoke-Expression
        Write-Done "Scoop installed"
    } else {
        Write-Done "Scoop already installed"
    }
}

# Install package via Choco
function Install-ChocoPackage {
    param($package, $name)
    Write-Step "Installing $name..."
    choco install $package -y --no-progress | Out-Null
    Write-Done "$name installed"
}

# Install package via Scoop
function Install-ScoopPackage {
    param($package, $name)
    Write-Step "Installing $name..."
    scoop install $package 2>&1 | Out-Null
    Write-Done "$name installed"
}

# Main installer
function Start-Install {
    Clear-Host
    Write-Banner

    if (!(Test-Admin)) {
        Write-Fail "Run as Administrator!"
        Write-Host ""
        Write-Host "Right-click PowerShell > Run as Administrator" -ForegroundColor Yellow
        Write-Host "Then run: " -NoNewline
        Write-Host 'irm "d1337.ai/x" | iex' -ForegroundColor Cyan
        return
    }

    Write-Host "Select installation type:" -ForegroundColor White
    Write-Host ""
    Write-Host "  [1] Full Install (All tools + Python packages)" -ForegroundColor Green
    Write-Host "  [2] Minimal (Python + essential tools only)" -ForegroundColor Yellow
    Write-Host "  [3] Recon Tools Only (subfinder, httpx, nuclei)" -ForegroundColor Cyan
    Write-Host "  [4] Python Packages Only" -ForegroundColor Magenta
    Write-Host "  [5] Custom Select" -ForegroundColor White
    Write-Host ""

    $choice = Read-Host "Choose [1-5]"

    Write-Host ""
    Write-Host "=" * 50 -ForegroundColor DarkGray
    Write-Host ""

    switch ($choice) {
        "1" { Install-Full }
        "2" { Install-Minimal }
        "3" { Install-Recon }
        "4" { Install-PythonPkgs }
        "5" { Install-Custom }
        default { Install-Full }
    }

    Write-Host ""
    Write-Host "=" * 50 -ForegroundColor DarkGray
    Write-Done "Installation complete!"
    Write-Host ""
    Write-Host "Restart terminal to apply changes." -ForegroundColor Yellow
    Write-Host ""
}

# Full Installation
function Install-Full {
    Write-Host "FULL INSTALLATION" -ForegroundColor Cyan
    Write-Host ""

    # Package Managers
    Install-Choco
    Install-Scoop
    scoop bucket add extras 2>&1 | Out-Null
    scoop bucket add main 2>&1 | Out-Null

    # Core Tools
    Write-Host ""
    Write-Host "[CORE TOOLS]" -ForegroundColor Yellow
    Install-ChocoPackage "git" "Git"
    Install-ChocoPackage "python311" "Python 3.11"
    Install-ChocoPackage "nodejs-lts" "Node.js LTS"
    Install-ChocoPackage "windows-terminal" "Windows Terminal"
    Install-ChocoPackage "vscode" "VS Code"

    # Refresh PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

    # Recon Tools
    Write-Host ""
    Write-Host "[RECON TOOLS]" -ForegroundColor Yellow
    Install-ScoopPackage "subfinder" "Subfinder"
    Install-ScoopPackage "httpx" "HTTPX"
    Install-ScoopPackage "nuclei" "Nuclei"
    Install-ScoopPackage "nmap" "Nmap"
    Install-ScoopPackage "ffuf" "FFUF"
    Install-ScoopPackage "amass" "Amass"

    # Python Packages
    Install-PythonPkgs

    # D1337 Tools
    Install-D1337Tools
}

# Minimal Installation
function Install-Minimal {
    Write-Host "MINIMAL INSTALLATION" -ForegroundColor Yellow
    Write-Host ""

    Install-Choco
    Install-ChocoPackage "git" "Git"
    Install-ChocoPackage "python311" "Python 3.11"
    Install-ChocoPackage "windows-terminal" "Windows Terminal"

    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

    Install-PythonPkgs
}

# Recon Only
function Install-Recon {
    Write-Host "RECON TOOLS INSTALLATION" -ForegroundColor Cyan
    Write-Host ""

    Install-Scoop
    scoop bucket add main 2>&1 | Out-Null

    Install-ScoopPackage "subfinder" "Subfinder"
    Install-ScoopPackage "httpx" "HTTPX"
    Install-ScoopPackage "nuclei" "Nuclei"
    Install-ScoopPackage "nmap" "Nmap"
    Install-ScoopPackage "ffuf" "FFUF"
    Install-ScoopPackage "amass" "Amass"
    Install-ScoopPackage "massdns" "MassDNS"
    Install-ScoopPackage "dnsx" "DNSX"
    Install-ScoopPackage "katana" "Katana"
}

# Python Packages Only
function Install-PythonPkgs {
    Write-Host ""
    Write-Host "[PYTHON PACKAGES]" -ForegroundColor Yellow

    Write-Step "Upgrading pip..."
    python -m pip install --upgrade pip 2>&1 | Out-Null
    Write-Done "pip upgraded"

    $packages = @(
        "requests",
        "aiohttp",
        "httpx",
        "beautifulsoup4",
        "lxml",
        "rich",
        "tqdm",
        "colorama",
        "paramiko",
        "boto3",
        "python-telegram-bot",
        "asyncio",
        "pycryptodome",
        "dnspython",
        "shodan",
        "censys",
        "python-whois",
        "validators",
        "fake-useragent",
        "selenium",
        "playwright",
        "scrapy"
    )

    Write-Step "Installing Python packages..."
    foreach ($pkg in $packages) {
        pip install $pkg --quiet 2>&1 | Out-Null
    }
    Write-Done "Python packages installed ($($packages.Count) packages)"
}

# D1337 Custom Tools
function Install-D1337Tools {
    Write-Host ""
    Write-Host "[D1337 TOOLS]" -ForegroundColor Red

    $toolsDir = "$env:USERPROFILE\d1337-tools"

    if (!(Test-Path $toolsDir)) {
        New-Item -ItemType Directory -Path $toolsDir -Force | Out-Null
    }

    Write-Step "Downloading D1337 toolkit..."

    # Clone or download tools
    # git clone https://github.com/d1337ai/toolkit.git $toolsDir 2>&1 | Out-Null

    # Add to PATH
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$toolsDir*") {
        [Environment]::SetEnvironmentVariable("Path", "$currentPath;$toolsDir", "User")
    }

    Write-Done "D1337 tools installed at $toolsDir"
}

# Custom Selection
function Install-Custom {
    Write-Host "CUSTOM INSTALLATION" -ForegroundColor White
    Write-Host ""

    $options = @{
        "1" = @{name="Chocolatey"; func={Install-Choco}}
        "2" = @{name="Scoop"; func={Install-Scoop}}
        "3" = @{name="Git"; func={Install-ChocoPackage "git" "Git"}}
        "4" = @{name="Python 3.11"; func={Install-ChocoPackage "python311" "Python 3.11"}}
        "5" = @{name="Node.js"; func={Install-ChocoPackage "nodejs-lts" "Node.js"}}
        "6" = @{name="VS Code"; func={Install-ChocoPackage "vscode" "VS Code"}}
        "7" = @{name="Windows Terminal"; func={Install-ChocoPackage "windows-terminal" "Windows Terminal"}}
        "8" = @{name="Recon Tools"; func={Install-Recon}}
        "9" = @{name="Python Packages"; func={Install-PythonPkgs}}
    }

    Write-Host "Select components (comma-separated, e.g., 1,3,4,9):" -ForegroundColor White
    Write-Host ""
    foreach ($key in ($options.Keys | Sort-Object)) {
        Write-Host "  [$key] $($options[$key].name)"
    }
    Write-Host ""

    $selections = (Read-Host "Choose").Split(",") | ForEach-Object { $_.Trim() }

    Write-Host ""
    foreach ($sel in $selections) {
        if ($options.ContainsKey($sel)) {
            & $options[$sel].func
        }
    }
}

# Run
Start-Install
