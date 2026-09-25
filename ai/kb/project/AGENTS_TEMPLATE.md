# Project AI Agent Setup Template

Copy this template to new project root. Adapt as needed.

## Quick Start

```bash
# Create basic .agents/ structure
mkdir -p .agents/rules .agents/skills .agents/plans .agents/context
echo "# $(basename $(pwd))" > .agents/context/project.md
```

---

## 1. Project opencode.json (if using OpenCode)

Place in project root. Overrides `~/.config/opencode/opencode.json`.

```json
{
    "mcp": {
        "project-db": {
            "type": "local",
            "command": ["npx", "-y", "some-db-mcp"],
            "environment": {
                "DB_HOST": "localhost",
                "DB_NAME": "project_db"
            }
        },
        "global-mcp-to-disable": {
            "enabled": false
        }
    },
    "instructions": [
        ".agents/rules/PROJECT_RULES.md",
        ".agents/context/project.md"
    ]
}
```

## 2. Project .codex/config.toml (if using Codex)

```toml
[mcp_servers.project-db]
command = "npx"
args = ["-y", "some-db-mcp"]

[projects."/absolute/path/to/project"]
trust_level = "trusted"
```

## 3. Project Rules File

`.agents/rules/PROJECT_RULES.md`:

```markdown
# Project Rules

## Stack
- Framework: [name]
- Language: [name]
- Database: [name]
- Testing: [framework]

## Conventions
- [pattern 1]
- [pattern 2]

## Commands
- `npm run dev` — Start dev server
- `npm test` — Run tests
- `npm run lint` — Lint code
```

## 4. Project Context File

`.agents/context/project.md`:

```markdown
# Project Context

## Purpose
[what this project does]

## Architecture
[key architectural decisions]

## Current Task
[what we're working on now]

## Known Issues
[bugs, gotchas, tech debt]
```

## 5. Project Skills (optional)

`.agents/skills/<name>/SKILL.md`:

```markdown
---
name: project-specific-skill
description: Use when [triggering condition]
---

# Skill Name

## Overview
[1-2 sentences]

## Pattern
[code or steps]
```

## Override Summary

| What | Global default | Project override |
|------|---------------|------------------|
| Rules | `~/.config/ai/kb/global/rules/` | `.agents/rules/` |
| Context | None | `.agents/context/` |
| Skills | `~/.config/ai/skills/` | `.agents/skills/` |
| MCPs | Agent config | Project `opencode.json` or `.codex/config.toml` |
| Plans | `kb/project/plans/` | `.agents/plans/` |
| Commands | Agent's commands dir | Project `opencode.json` commands |

## Init Command (OpenCode)

If available: run `/init-workspace` in project root. Copies KB, creates .gitignore, sets up stow symlinks.

## Per-Agent Init

| Agent | Init command |
|-------|-------------|
| OpenCode | `/init-workspace` (custom command) |
| Gemini | `gemini init` (if available) or manual `.agents/` dir setup |
| Codex | Manual `.codex/config.toml` setup |
