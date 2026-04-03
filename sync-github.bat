@echo off
REM GitHub Resync Script for EmulTesting
REM This batch file helps sync your project with GitHub

setlocal enabledelayedexpansion

echo.
echo ============================================
echo  EmulTesting GitHub Resync
echo ============================================
echo.

REM Check if Git is installed
git --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Git is not installed or not in PATH
    echo.
    echo Please install Git first:
    echo   Option 1: winget install Git.Git
    echo   Option 2: Download from https://git-scm.com/download/win
    echo   Option 3: GitHub Desktop https://desktop.github.com
    echo.
    echo After installing, restart your terminal and run this script again.
    pause
    exit /b 1
)

REM Display Git version
echo Git found:
git --version
echo.

REM Change to project directory
cd /d "c:\devpt\java\EmulTesting"
if %errorlevel% neq 0 (
    echo Error: Could not navigate to project directory
    pause
    exit /b 1
)

echo Current directory: %cd%
echo.

REM Check for existing .git directory
if exist .git (
    echo Git repository already initialized.
    echo Current status:
    git status
    echo.
) else (
    echo Initializing Git repository...
    git init
    if %errorlevel% neq 0 (
        echo Error: Failed to initialize Git
        pause
        exit /b 1
    )
    echo Repository initialized.
    echo.
)

REM Configure Git user
echo Configuring Git user...
git config user.name "EmulTesting Developer"
git config user.email "developer@example.com"
echo.

REM Add remote
echo Adding GitHub remote...
git remote remove origin >nul 2>&1
git remote add origin https://github.com/CiGit-Franck/EmulTesting.git
echo Remote configured: https://github.com/CiGit-Franck/EmulTesting.git
echo.

REM Stage changes
echo Staging changes...
git add .
echo.

REM Check status
echo Current status:
git status
echo.

REM Commit
set /p commit_msg="Enter commit message (default: 'Java 25 upgrade and project setup'): "
if "!commit_msg!"=="" set "commit_msg=Java 25 upgrade and project setup"

git commit -m "!commit_msg!"
if %errorlevel% neq 0 (
    echo Error: Commit failed
    pause
    exit /b 1
)
echo.

REM Push to GitHub
echo.
echo Ready to push to GitHub.
echo.
echo IMPORTANT: You will be prompted for credentials:
echo   - Username: Your GitHub username
echo   - Password: Your GitHub Personal Access Token (NOT your password)
echo.
echo Get a PAT at: https://github.com/settings/tokens
echo.
set /p proceed="Do you want to push now? (y/n): "
if /i "!proceed!"=="y" (
    git push -u origin main
    if %errorlevel% equ 0 (
        echo.
        echo ============================================
        echo  Success! Repository synced with GitHub
        echo ============================================
    ) else (
        echo.
        echo Push failed. Check your credentials and try again:
        echo   git push -u origin main
    )
) else (
    echo.
    echo To push later, run:
    echo   git push -u origin main
)

echo.
pause
