# GitHub Setup Instructions for EmulTesting

This document provides step-by-step instructions to reconnect your EmulTesting project to your GitHub repository.

**Repository**: https://github.com/CiGit-Franck/EmulTesting.git

## Prerequisites

### 1. Install Git (if not already installed)

**Option A: Using Windows Package Manager (winget)**
```powershell
winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
```
*Note: You may need to approve an administrator elevation prompt.*

**Option B: Manual Installation**
- Download from: https://git-scm.com/download/win
- Run the installer and accept defaults
- Restart your terminal/VS Code after installation

**Option C: Using Chocolatey**
```powershell
choco install git -y
```

### 2. Verify Git Installation

After installing, verify Git is working:
```powershell
git --version
```

## Setup Steps

### Step 1: Initialize Git Repository (One-time)

```powershell
cd c:\devpt\java\EmulTesting
git init
```

### Step 2: Configure Git User (One-time)

```powershell
git config user.name "Your Name"
git config user.email "your.email@example.com"
```

*Or globally for all repositories:*
```powershell
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Step 3: Add Remote GitHub Repository

```powershell
git remote add origin https://github.com/CiGit-Franck/EmulTesting.git
```

**Example URLs:**
- `https://github.com/CiGit-Franck/EmulTesting.git` (HTTPS)
- `git@github.com:CiGit-Franck/EmulTesting.git` (SSH - requires SSH key setup)

### Step 4: Create .gitignore (Recommended)

```powershell
# Create a .gitignore file to exclude build artifacts
@'
target/
.idea/
*.class
*.jar
.DS_Store
.vscode/
.settings/
.classpath
.project
*.iml
bin/
'@ | Out-File .gitignore -Encoding UTF8
```

### Step 5: Commit Changes

```powershell
# Stage all changes
git add .

# Commit with message
git commit -m "Initial commit: Java 25 upgrade and project setup"
```

### Step 6: Push to GitHub

```powershell
# Push to main branch (first time)
git push -u origin main

# Or if your default branch is named differently:
git push -u origin master
```

*If prompted for credentials, use your GitHub personal access token (not your password):*
- Go to GitHub → Settings → Developer settings → Personal access tokens
- Create a fine-grained personal access token with repository access
- Use the token as your password when prompted

## Authentication Methods

### HTTPS with Personal Access Token (Recommended)

1. Go to https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Set scopes: `repo` (full control of private repositories)
4. Copy the token
5. When Git prompts for password, paste the token

### SSH Key Setup (Alternative)

1. Generate SSH key:
   ```powershell
   ssh-keygen -t rsa -b 4096 -f $env:USERPROFILE\.ssh\emultesting_key
   ```

2. Add public key to GitHub:
   - Copy contents of `C:\Users\YourUsername\.ssh\emultesting_key.pub`
   - Go to https://github.com/settings/keys
   - Click "New SSH key" and paste the key

3. Update remote URL to use SSH:
   ```powershell
   git remote set-url origin git@github.com:CiGit-Franck/EmulTesting.git
   ```

## Current Project State

### Java Upgrade Completed ✅
- Source: Java 17 → Java 25
- Target: Java 17 → Java 25
- pom.xml updated with Java 25 compiler settings
- Dependencies: jnativehook 2.2.2 (no CVEs detected)

### Files Ready to Commit
```
pom.xml                                    (Updated for Java 25)
src/main/java/org/theryble/emultesting/   
.github/java-upgrade/20260402192827/      (Upgrade artifacts)
```

## Troubleshooting

### "git: command not found"
- Verify Git installation: `Test-Path "C:\Program Files\Git\bin\git.exe"`
- Add to PATH if needed: `$env:Path += ";C:\Program Files\Git\bin"`
- Restart terminal after installing Git

### "Permission denied (publickey)"
- Verify SSH key is properly configured in GitLab settings
- Test connection: `ssh -T git@gitlab.com`

### "fatal: 'origin' does not appear to be a git repository"
- Run `git init` first
- Then add remote with: `git remote add origin <URL>`

### Credential Authentication Failed
- Use a personal access token, not your GitLab password
- For HTTPS: Create token at https://gitlab.com/profile/personal_access_tokens
- Reset stored credentials in Windows Credential Manager if needed

## Quick Reference Commands

```powershell
# Check current status
git status

# View commit history
git log --oneline

# Add specific file
git add path/to/file

# View changes before committing
git diff

# Undo uncommitted changes
git checkout -- path/to/file

# See configured remotes
git remote -v

# Change remote URL
git remote set-url origin new-url
```

## Next Steps

1. Install Git (if not already done)
2. Run the Setup Steps 1-6 above in order
3. Verify successful push to GitLab
4. Continue with development and regular commits

For more help, see: https://docs.gitlab.com/ee/gitlab-basics/

---

**Project**: EmulTesting  
**Java Version**: Java 25 (LTS)  
**Last Updated**: 2026-04-02
