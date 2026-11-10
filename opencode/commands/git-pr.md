---
description: Draft a production-grade Pull Request title and description from git diff.
agent: docs
---

# Pull Request Drafter

Analyze the git diff between `origin/main` (or upstream branch) and HEAD:

1. Execute `git log origin/main..HEAD --oneline` and `git diff --stat origin/main..HEAD` to understand all changes in this branch.
2. Draft a clean, professional Pull Request description using GitHub Markdown formatting:

```markdown
## Title
<type>(<scope>): <concise imperatively phrased summary>

### Summary & Context
- Why are these changes needed?
- What problem does this solve?

### Key Changes
- List key file-by-file or architectural changes clearly.
- Mention any removed dead code or dependencies.

### Verification & Testing
- What tests or manual verification checks were run?
- Any specific commands to verify this PR?

### Breaking Changes / Checklist
- [ ] No breaking database schema or config changes without migration/fallback
- [ ] Environment variables documented in `~/.config/ai/env`
- [ ] Documentation updated
```
