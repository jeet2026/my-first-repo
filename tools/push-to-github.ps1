#Requires -Version 5.1
<#
    push-to-github.ps1
    Point this repo at your GitHub repository and push it.

    Usage (run from the repo root):
        powershell -ExecutionPolicy Bypass -File .\tools\push-to-github.ps1 -User yourname
        powershell -ExecutionPolicy Bypass -File .\tools\push-to-github.ps1 -User yourname -Repo my-first-repo

    What it does:
        1. checks that git is available
        2. sets (or replaces) the "origin" remote
        3. pushes main and all tags
        4. prints the repository and Pages URLs

    Requirements:
        - a repo already created on GitHub (empty, no README)
        - you will be asked to sign in the first time
#>
param(
    [Parameter(Mandatory = $false)][string]$User,
    [string]$Repo = "my-first-repo",
    [switch]$SkipPush
)

$ErrorActionPreference = "Stop"

if (-not $User) { $User = Read-Host "GitHub username" }
if (-not $User) { throw "Username is required." }

$git = Get-Command git -ErrorAction SilentlyContinue
if (-not $git) {
    $git = Get-Item "C:\Program Files\Git\cmd\git.exe" -ErrorAction SilentlyContinue
    if (-not $git) { throw "git not found. Install Git for Windows first." }
    $gitCmd = $git.FullName
} else {
    $gitCmd = $git.Source
}

$url = "https://github.com/$User/$Repo.git"
Write-Host "Remote: $url" -ForegroundColor Cyan

$existing = & $gitCmd remote 2>$null
if ($existing -contains "origin") {
    & $gitCmd remote set-url origin $url
    Write-Host "Updated existing 'origin'." -ForegroundColor Yellow
} else {
    & $gitCmd remote add origin $url
    Write-Host "Added 'origin'." -ForegroundColor Yellow
}

if ($SkipPush) {
    Write-Host "SkipPush set - remote configured only." -ForegroundColor Yellow
    exit 0
}

Write-Host "Pushing main..." -ForegroundColor Cyan
& $gitCmd push -u origin main
if ($LASTEXITCODE -ne 0) { throw "push failed (exit $LASTEXITCODE). Sign in or check the repo URL." }

Write-Host "Pushing tags..." -ForegroundColor Cyan
& $gitCmd push --tags

Write-Host ""
Write-Host "Repo : https://github.com/$User/$Repo" -ForegroundColor Green
Write-Host "Pages: https://$User.github.io/$Repo/ (enable in Settings > Pages)" -ForegroundColor Green
