#!/usr/bin/env powershell
# GitHub Setup Script for EmulTesting Project
# This script automates the Git initialization and GitHub connection

param(
    [Parameter(Mandatory=$false)]
    [string]$GitHubURL = "https://github.com/CiGit-Franck/EmulTesting.git",
    
    [Parameter(Mandatory=$false)]
    [string]$GitName = "EmulTesting Developer",
    
    [Parameter(Mandatory=$false)]
    [string]$GitEmail = "developer@example.com"
)

Write-Host "===========================================" -ForegroundColor Cyan
Write-Host "  EmulTesting GitHub Setup Script" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check if Git is installed
Write-Host "[1/5] Checking Git installation..." -ForegroundColor Yellow
if (Get-Command git -ErrorAction SilentlyContinue) {
    Write-Host "✓ Git is installed" -ForegroundColor Green
    git --version
} else {
    Write-Host "✗ Git is not installed" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Git first:" -ForegroundColor Yellow
    Write-Host "  Option 1: winget install --id Git.Git -e --accept-source-agreements"
    Write-Host "  Option 2: Download from https://git-scm.com/download/win"
    Write-Host "  Option 3: choco install git"
    Write-Host ""
    Write-Host "After installing Git, restart your terminal and run this script again."
    exit 1
}

Write-Host ""

# Step 2: Navigate to project directory
Write-Host "[2/5] Setting up project directory..." -ForegroundColor Yellow
$projectDir = "c:\devpt\java\EmulTesting"
if (-not (Test-Path $projectDir)) {
    Write-Host "✗ Project directory not found: $projectDir" -ForegroundColor Red
    exit 1
}
Set-Location $projectDir
Write-Host "✓ Project directory: $(Get-Location)" -ForegroundColor Green

Write-Host ""

# Step 3: Initialize Git repository
Write-Host "[3/5] Initializing Git repository..." -ForegroundColor Yellow
if (Test-Path .git) {
    Write-Host "✓ Git repository already initialized" -ForegroundColor Green
} else {
    git init 2>&1 | Out-Null
    Write-Host "✓ Git repository initialized" -ForegroundColor Green
}

Write-Host ""

# Step 4: Configure Git user
Write-Host "[4/5] Configuring Git user..." -ForegroundColor Yellow
git config user.name "$GitName"
git config user.email "$GitEmail"
Write-Host "✓ Git configured:" -ForegroundColor Green
Write-Host "  Name: $(git config user.name)"
Write-Host "  Email: $(git config user.email)"

Write-Host ""

# Step 5: Add GitHub remote
Write-Host "[5/5] Configuring GitHub remote..." -ForegroundColor Yellow

if ([string]::IsNullOrWhiteSpace($GitHubURL)) {
    Write-Host ""
    Write-Host "GitHub repository URL not provided." -ForegroundColor Yellow
    Write-Host "Please enter your GitHub repository URL: " -ForegroundColor Cyan -NoNewline
    $GitHubURL = Read-Host
    
    if ([string]::IsNullOrWhiteSpace($GitHubURL)) {
        Write-Host "✗ No URL provided. Skipping remote setup." -ForegroundColor Red
        Write-Host ""
        Write-Host "To add remote later, run:" -ForegroundColor Yellow
        Write-Host "  git remote add origin <your-github-url>" -ForegroundColor Yellow
        exit 1
    }
}

# Check if remote already exists
if ((git remote 2>$null) | Select-String -Pattern "origin" -Quiet) {
    Write-Host "Remote 'origin' already exists. Updating..." -ForegroundColor Yellow
    git remote set-url origin $GitHubURL 2>&1 | Out-Null
} else {
    git remote add origin $GitHubURL 2>&1 | Out-Null
}

Write-Host "✓ GitHub remote configured" -ForegroundColor Green
git remote -v

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "  Setup Complete!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""

Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Create a .gitignore file (if needed):"
Write-Host "   git config --global core.excludesfile ~/.gitignore_global"
Write-Host ""
Write-Host "2. Stage changes:"
Write-Host "   git add ."
Write-Host ""
Write-Host "3. Commit:"
Write-Host "   git commit -m 'Initial commit: Java 25 upgrade'"
Write-Host ""
Write-Host "4. Push to GitHub:"
Write-Host "   git push -u origin main"
Write-Host ""
Write-Host "5. (If prompted for credentials, use a Personal Access Token:)"
Write-Host "   https://github.com/settings/tokens"
Write-Host ""
