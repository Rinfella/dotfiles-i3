---
name: git-diff-reviewer
description: Examines a git diff before staging/committing to find potential bugs, cleanups, or improvements.
---

# Git Diff Reviewer

This skill helps review code changes before making commits or opening pull requests. It ensures high code quality, consistency, and safety.

## When to Use
Trigger this skill when reviewing code changes, preparing to commit, or checking for bugs in recent modifications.

## Checklist
1. **Security & Secrets**:
   - Check if any API keys, credentials, or sensitive configurations are hardcoded.
   - Look for unsafe inputs, unescaped database queries, or path injection.
2. **Logic & Typos**:
   - Spot typos in variable names, functions, or comments.
   - Look for logic holes (e.g. missing error/null checks, potential edge cases, off-by-one errors).
3. **Style & Cleanup**:
   - Verify if any debug logs (e.g. `console.log`, `print`) are left behind.
   - Ensure clean formatting, correct indentation, and meaningful naming conventions.
   - Keep comments and docstrings updated with code changes.

## Review Output Format
Provide a terse summary of findings:
* **Critical**: Security/logic issues that must be fixed.
* **Suggestions**: Code cleanups, optimizations, or refactoring ideas.
* **Approved**: If everything looks perfect.
