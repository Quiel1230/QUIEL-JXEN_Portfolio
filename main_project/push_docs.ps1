# Push the docs/ folder to GitHub and enable Pages
# Usage: run in PowerShell from project root
# You will be prompted for credentials by Git when pushing (or use an authenticated Git credential manager/token)

param(
    [string]$RemoteUrl = 'https://github.com/quielnyopagod50-web/QUIEL-JXEN_PORTFOLIO.git',
    [string]$Branch = 'main',
    [string]$CommitMessage = 'Publish static site to GitHub Pages (docs/)'
)

Write-Host "Preparing to push docs/ to remote: $RemoteUrl (branch: $Branch)"

# Ensure docs exists
if (-not (Test-Path -Path .\docs\index.html)) {
    Write-Error "docs/index.html not found. Run export_static.py first."
    exit 1
}

# Initialize git if needed
if (-not (Test-Path -Path .git)) {
    git init
    Write-Host "Initialized new git repository"
}

# Add remote if it doesn't exist
$existing = git remote get-url origin 2>$null
if ($LASTEXITCODE -ne 0) {
    git remote add origin $RemoteUrl
    Write-Host "Added remote origin -> $RemoteUrl"
} else {
    Write-Host "Remote origin already set to: $existing"
}

# Stage files (docs/ and changes)
git add docs
git add main_app/static/images/quiel.jpg main_app/static/images/jayxen.jpg 2>$null
git add main_app/views.py 2>$null

# Commit
git commit -m $CommitMessage 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "No changes to commit or commit failed (maybe empty commit). Continuing to push." -ForegroundColor Yellow
} else {
    Write-Host "Committed changes: $CommitMessage"
}

# Push
Write-Host "Pushing to origin/$Branch..."
# If the remote branch doesn't exist, create it and push
git push origin $Branch --set-upstream

Write-Host "Push complete. Now go to the GitHub repo settings -> Pages -> select Branch: $Branch and /docs folder, Save."
Write-Host "After a minute the site will be available at the repo's GitHub Pages URL."
