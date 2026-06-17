#!/bin/bash
set -e

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$REPO_ROOT"

echo "Preparing GitHub push (code only, no PDFs)..."

git worktree remove .github-worktree --force 2>/dev/null || true
git branch -D github-main 2>/dev/null || true
rm -rf .github-worktree 2>/dev/null || true

git worktree add .github-worktree -B github-main main

cd .github-worktree

git rm --cached -r --ignore-unmatch "**/*.pdf" "*.pdf" >/dev/null 2>&1
git rm --cached --ignore-unmatch .gitattributes >/dev/null 2>&1

if git diff --cached --quiet 2>/dev/null; then
  echo "No changes to push."
else
  git commit -m "chore: remove PDFs and LFS config for GitHub (code only)"
fi

git push github github-main --force
echo "GitHub push complete."

cd "$REPO_ROOT"
git worktree remove .github-worktree
git branch -d github-main 2>/dev/null || true

echo "Done."
