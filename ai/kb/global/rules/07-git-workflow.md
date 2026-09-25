# Git & Version Control Guidelines

## 1. Commit Message Standards (Conventional Commits)
All commit messages must follow the Conventional Commits specification:
```
<type>(<scope>): <short imperative summary>

[optional body explaining motivation and context]

[optional footer(s)]
```

### Allowed Types:
- `feat`: A new user-facing or architectural feature.
- `fix`: A bug fix.
- `docs`: Documentation-only changes.
- `style`: Changes that do not affect code logic (formatting, white-space).
- `refactor`: Code changes that neither fix bugs nor add features.
- `perf`: Code changes improving runtime or memory performance.
- `test`: Adding missing tests or correcting existing tests.
- `chore`: Changes to build process, dependency updates, or auxiliary tools.

## 2. Staging & Diff Discipline
- Never run blanket `git add .` without checking untracked files with `git status`.
- Review the staged diff before committing: `git diff --cached`.
- Ensure no `.env`, API credentials, core dumps, or temporary artifacts are accidentally staged.
- Keep commits small, focused, and atomic. A commit should address a single logical change.

## 3. Remote Operations & Safety
- **NEVER force-push (`git push --force`)** to `master` or `main`.
- In agent workflows, **do not automatically push to remote repositories** unless explicitly requested by the user. Leave commits in the local branch ready for user review.
- When pulling upstream changes, prefer `git pull --ff-only` or `git pull --rebase` to prevent messy empty merge commits.
