Deployment notes — GitHub Pages (docs/) export

This project includes a static export of the homepage suitable for GitHub Pages.
Files created:
- `docs/index.html` — static snapshot of the homepage
- `docs/static/...` — copied static assets (CSS, images)
- `docs/.nojekyll` — prevents Jekyll processing on GitHub Pages

Scripts:
- `export_static.py` — renders the Django homepage and writes `docs/index.html` and copies static files
- `fix_docs_assets.py` — removes cache-busting query strings from `docs/index.html`
- `validate_docs.py` — checks `docs/index.html` for missing local assets
- `push_docs.ps1` — helper PowerShell script to commit and push `docs/` to the remote repo

Quick publish steps (PowerShell):
1. Regenerate export (if you've made changes):
   py export_static.py
   py fix_docs_assets.py
   py validate_docs.py

2. Commit & push to GitHub (example remote: `https://github.com/quielnyopagod50-web/Quiel-Jxen_portfolio.git`):
   # run in project root
   .\push_docs.ps1 -RemoteUrl 'https://github.com/quielnyopagod50-web/QUIEL-JXEN_PORTFOLIO.git' -Branch 'main' -CommitMessage 'Publish static site to GitHub Pages'
   The repository URL you provided is:
   `https://github.com/quielnyopagod50-web/QUIEL-JXEN_PORTFOLIO`

3. On GitHub: open repository `quielnyopagod50-web/Quiel-Jxen_portfolio`, go to Settings → Pages.
   - Source: Branch `main`
   - Folder: `/docs`
   - Save. Wait ~1-2 minutes for the site to become available.

Notes:
- GitHub Pages serves static files only — dynamic Django views or database-driven pages will not work.
- If you need the site to run dynamically, consider deploying to Render / Railway / Heroku and I'll help prepare it.
