#!/usr/bin/env bash
#
# One-command deploy for the executive presentation.
# Usage:  ./deploy.sh "optional commit message"
#
# GitHub Pages auto-republishes on every push to the default branch,
# so this script just stages, commits and pushes.
set -euo pipefail

cd "$(dirname "$0")"

MSG="${1:-Update presentation $(date '+%Y-%m-%d %H:%M')}"

# Make sure gh is reachable even if ~/.local/bin is not on PATH yet.
export PATH="$HOME/.local/bin:$PATH"

git add -A

if git diff --cached --quiet; then
  echo "No changes to deploy."
  exit 0
fi

git commit -m "$MSG"
git push origin "$(git rev-parse --abbrev-ref HEAD)"

echo
echo "Pushed. GitHub Pages will republish in ~30-60 seconds."
echo "Live URL:"
git remote get-url origin | sed -E 's#git@github.com:#https://#; s#https://github.com/#https://#; s#\.git$##' \
  | awk -F/ '{print "  https://" $(NF-1) ".github.io/" $NF "/"}'
