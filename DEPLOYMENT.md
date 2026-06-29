# Deployment — Executive Presentation

Live static hosting via **GitHub Pages**. The presentation is a single
self-contained `index.html` (inline CSS, JS and SVG — no external assets),
so it works on any static host and opens directly in Microsoft Edge.

## Live URL

```
https://<github-user>.github.io/medical-development-presentation/
```

(The exact URL is printed by `./deploy.sh` and shown in the repo's
**Settings → Pages**.)

## Update workflow (single command)

After editing `index.html`:

```bash
./deploy.sh "what changed"
```

That stages, commits and pushes. GitHub Pages automatically rebuilds and
republishes within ~30–60 seconds. The equivalent manual form is:

```bash
git add .
git commit -m "what changed"
git push
```

No build step, no CLI re-auth, no manual upload — pushing to the default
branch is the deploy.

## How it was set up (one-time)

1. `index.html` — the presentation (copied from the approved source file).
2. `.nojekyll` — tells GitHub Pages to serve files as-is (no Jekyll processing).
3. Repository created and pushed with the GitHub CLI:
   ```bash
   gh repo create medical-development-presentation --public --source=. --remote=origin --push
   ```
4. Pages enabled from the default branch root:
   ```bash
   gh api -X POST repos/<owner>/medical-development-presentation/pages \
     -f 'source[branch]=main' -f 'source[path]=/'
   ```

## Requirements

- `git` (preinstalled on macOS).
- `gh` (GitHub CLI) — installed at `~/.local/bin/gh`. Only needed for the
  one-time repo creation / Pages enablement; day-to-day updates need only `git`.
- GitHub authentication is stored by `gh` after a one-time browser login;
  `git push` reuses it.

## Editing source

The canonical source also lives at:
`/Users/Ingomar/Documents/Codex/2026-06-29/yeah/outputs/medical-development-executive-presentation-de.html`

If you edit there, copy it back into the repo before deploying:

```bash
cp /Users/Ingomar/Documents/Codex/2026-06-29/yeah/outputs/medical-development-executive-presentation-de.html index.html
./deploy.sh "sync from source"
```
