# GitHub Sync Guide - Manual Setup Required

Your EmulTesting project needs to be synced with GitHub at: **https://github.com/CiGit-Franck/EmulTesting.git**

## ⚠️ Git Installation Required

Git is not currently installed on your system. Follow **ONE** of the steps below:

### Option 1: Windows Package Manager (Easiest)
```powershell
winget install Git.Git
```
Then restart your terminal.

### Option 2: GitHub Desktop (User-Friendly)
1. Download: https://desktop.github.com
2. Install GitHub Desktop
3. Clone from: https://github.com/CiGit-Franck/EmulTesting.git
4. Copy files from `c:\devpt\java\EmulTesting\pom.xml` to the cloned repo
5. Commit and push in GitHub Desktop

### Option 3: Direct Download & Install
1. Download Git: https://git-scm.com/download/win
2. Run the installer
3. Accept all defaults
4. Restart your terminal

### Option 4: Chocolatey (If installed)
```powershell
choco install git -y
```

---

## After Installing Git

Once Git is installed, run these commands in PowerShell:

```powershell
cd c:\devpt\java\EmulTesting

# Configure Git (first time only)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Initialize repository
git init

# Add GitHub remote
git remote add origin https://github.com/CiGit-Franck/EmulTesting.git

# Pull latest from GitHub (if repo has files)
git pull origin main

# Add your changes
git add .

# Commit
git commit -m "Java 25 upgrade and project setup"

# Push to GitHub
git push -u origin main
```

**Note**: When prompted for password, use a GitHub Personal Access Token from: https://github.com/settings/tokens

---

## What Needs to be Synced

- **Modified**: `pom.xml` - Java 25 compiler settings
- **New**: Various setup files for GitHub integration
- **Status**: Project ready to push

Create your GitHub Personal Access Token:
1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Set scope: `repo` (full)
4. Copy token and use as password when Git prompts

---

**Repository**: https://github.com/CiGit-Franck/EmulTesting.git  
**Status**: Awaiting Git installation and manual sync
