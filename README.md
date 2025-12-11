# D1337 Toolkit Installer

One-liner installer untuk semua tools.

## Usage

```powershell
irm "d1337.ai/x" | iex
```

## Hosting Setup

### Option 1: Cloudflare Pages (Gratis)
1. Push folder ini ke GitHub
2. Connect ke Cloudflare Pages
3. Set redirect: `d1337.ai/x` → `install.ps1`

### Option 2: VPS/cPanel
1. Upload `install.ps1` ke server
2. Setup `.htaccess` redirect:
```apache
RewriteRule ^x$ /install.ps1 [L]
```

### Option 3: Vercel
1. Buat `vercel.json`:
```json
{
  "rewrites": [
    { "source": "/x", "destination": "/install.ps1" }
  ]
}
```

## What Gets Installed

### Full Install
- Chocolatey + Scoop
- Git, Python 3.11, Node.js
- VS Code, Windows Terminal
- Recon: subfinder, httpx, nuclei, nmap, ffuf, amass
- Python packages: requests, aiohttp, boto3, etc.

### Minimal Install
- Git, Python 3.11, Windows Terminal
- Python packages

### Recon Only
- subfinder, httpx, nuclei, nmap, ffuf, amass, massdns, dnsx, katana
