param(
    [switch]$SkipDownload = $false
)

$gitPath = "C:\Program Files\Git\bin\git.exe"
$gitExe = "C:\temp\Git-2.45.0-64-bit.exe"
$gitDir = "C:\temp"

# Check if Git already installed
if (Test-Path $gitPath) {
    Write-Host "Git is already installed at: $gitPath" -ForegroundColor Green
    & $gitPath --version
    exit 0
}

# Create temp directory if needed
if (-not (Test-Path $gitDir)) {
    New-Item -ItemType Directory -Path $gitDir -Force | Out-Null
}

Write-Host "Downloading Git for Windows..." -ForegroundColor Yellow
$ProgressPreference = 'SilentlyContinue'

try {
    Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.45.0.windows.1/Git-2.45.0-64-bit.exe" -OutFile $gitExe -UseBasicParsing
    Write-Host "Downloaded successfully" -ForegroundColor Green
} catch {
    Write-Host "Failed to download Git: $_" -ForegroundColor Red
    exit 1
}

if (Test-Path $gitExe) {
    Write-Host "Installing Git..." -ForegroundColor Yellow
    
    # Run installer
    & $gitExe /VERYSILENT /NORESTART | Out-Null
    
    # Wait for completion
    Start-Sleep -Seconds 10
    
    # Verify
    if (Test-Path $gitPath) {
        Write-Host "Git installed successfully!" -ForegroundColor Green
        & $gitPath --version
    } else {
        Write-Host "Installation may not have completed. Please try manual installation." -ForegroundColor Red
        Write-Host "Go to: https://git-scm.com/download/win" -ForegroundColor Yellow
    }
} else {
    Write-Host "Download verification failed" -ForegroundColor Red
    exit 1
}
