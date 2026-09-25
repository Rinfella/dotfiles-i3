---
description: Common Git operations
---

Common Git operations workflow.

## Steps:
1. Ask what operation needed.
2. Execute safely.
3. Show result.

## Common Commands

```bash
# Status and logs
git status
git log --oneline -10
git log --graph --oneline --all
git diff
git diff --staged

# Branching
git branch -a
git checkout -b new-branch
git checkout main
git branch -d branch-name

# Stashing
git stash
git stash pop
git stash list

# Remote
git remote -v
git fetch --all
git pull
git push
git push -u origin branch

# Undo
git checkout -- file      # Discard changes
git reset --soft HEAD~1 # Undo commit, keep changes
git reset --hard HEAD~1 # Undo commit, discard (DANGEROUS)

# Aliases (add to .gitconfig)
[alias]
  st = status
  co = checkout
  br = branch
  ci = commit
  unstage = reset HEAD --
  last = log -1 HEAD
  visual = log --graph --oneline --all
```

## Best Practices
- Always `git status` before operations
- Use `git diff --staged` before commit
- Commit often with meaningful messages