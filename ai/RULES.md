# ~/.config/ai — Global AI Agent Hub

Single source of truth: Gemini CLI, OpenCode, Codex CLI.

## Override Chain (HIGH → low)

```
PROJECT (.agents/, project opencode.json, CLAUDE.md)
    ↑ overrides
AGENT (~/.config/opencode/, ~/.gemini/, ~/.config/codex/)
    ↑ overrides
GLOBAL (~/.config/ai/)
```

Rule: Project beats agent beats global. Same key defined higher hides lower.

## Architecture

```
~/.config/ai/              ← CENTRAL HUB (owns all shared data)
├── env                    ← SINGLE env var source
├── RULES.md               ← This file
├── mcp/
│   ├── mcp_config.json    ← Gemini MCP config (shared via symlink)
│   ├── <tool>/README.md   ← Per-tool reference docs (consolidated)
├── kb/                    ← Knowledge base (rules + skills)
│   ├── global/rules/      ← Cross-agent dev rules
│   ├── global/skills/     ← Domain skill guides
│   └── project/           ← Per-project context/plans
├── skills/                ← Shareable skills (6 native skills)
├── superpowers/           ← Superpowers skills framework (14 skills)
│   └── skills/            ← Process skills (TDD, debugging, etc.)
└── config/
    ├── memory/            ← Shared agent memory
    ├── plugins/           ← Plugin storage (agent-specific)
    └── gemini-projects/   ← Gemini project metadata
```

## Agent Wiring

| Agent | Central hub access | Agent-specific dir |
|-------|-------------------|--------------------|
| **Gemini CLI** | `~/.gemini/config → ~/.config/ai` (full symlink)<br>`~/.gemini/.env → ~/.config/ai/env` | `~/.gemini/antigravity/`<br>`~/.gemini/antigravity-cli/`<br>`~/.gemini/antigravity-ide/` |
| **OpenCode** | `~/.config/opencode/kb → ~/.config/ai/kb`<br>`~/.config/opencode/superpowers → ~/.config/ai/superpowers`<br>`~/.config/opencode/skills → ~/.config/ai/skills`<br>`~/.config/opencode/memory → ~/.config/ai/config/memory` | `~/.config/opencode/opencode.json`<br>`~/.config/opencode/plugins/`<br>`~/.config/opencode/commands/` |
| **Codex CLI** | `~/.config/codex/.env → ~/.config/ai/env`<br>`~/.config/codex/kb → ~/.config/ai/kb` | `~/.config/codex/config.toml`<br>`~/.config/codex/skills/` (agent-native) |

## Separation of Concerns

### GLOBAL (~/.config/ai/) — Shared, never agent-specific
- **env**: API keys, tokens — single file, all agents
- **mcp/**: Tool reference docs + shared MCP config. Each tool gets one `README.md` (not N JSON manifests)
- **kb/**: Cross-agent development rules (TALL stack, infra, CI/CD, etc.)
- **skills/**: Any skill usable across agents
- **superpowers/**: Process skills framework (git repo, don't modify directly)

### AGENT-SPECIFIC — Stays in agent's config dir
- **Model selection**: opencode.json (OpenCode), settings.json (Gemini CLI), config.toml (Codex)
- **Plugins**: Plugin code is agent-specific. Stored centrally at `~/.config/ai/config/plugins/` for discovery but each agent loads only compatible ones.
- **Permissions**: opencode.json permission block, Gemini settings.json trustedWorkspaces
- **Commands**: Slash commands (opencode), keybindings (Gemini CLI)
- **Agent data**: Conversations, brain, history — never shared

### PROJECT-SPECIFIC — Stays in project root (`.agents/`)
- Project MCPs (DB, local services)
- Project rules (`PROJECT_RULES.md`, `AGENTS.md`, `CLAUDE.md`)
- Project context and plans
- Project skills (`.agents/skills/`)

## MCP Strategy (Hybrid)

1. **Shared MCP config**: `~/.config/ai/mcp/mcp_config.json` — used by Gemini (via symlink)
2. **Tool reference**: Each tool gets one `README.md` in `~/.config/ai/mcp/<tool>/` — setup + usage
3. **Agent-native MCPs**: OpenCode defines MCPs in `opencode.json`, Codex in `config.toml` — their format requirements differ
4. **Project MCPs**: In project `.agents/` — DB, local services, deployment

## Lazy Loading

### OpenCode — `enabled: false` per MCP

| MCP | Mode | Rationale |
|-----|------|-----------|
| sequential-thinking | always | Core reasoning tool |
| firecrawl | always | Primary web search |
| github | always | Code review, PRs, issues |
| context7 | always | Docs lookup |
| playwright | always | Browser inspection (npx on-demand) |
| fetch | always | URL content |
| memory | always | Persistence |
| brave-search | DISABLED | No API key. Enable after adding BRAVE_SEARCH_API_KEY to env. |
| puppeteer | LAZY (disabled) | Duplicates playwright. Enable per-task. |
| filesystem | always | File ops |

**Project-level lazy**: Project MCPs (DB, local services) defined only in project `opencode.json` — never load globally.

### Gemini — All MCPs load at startup. No lazy.

Mitigation: Keep `mcp_config.json` minimal. Project MCPs go in project `mcp_config.json`.

### Codex — Per-project MCP separation

Project `.codex/config.toml` keeps DB/service MCPs out of global startup.

Skills auto-discovered but content loaded only on invocation (OpenCode: `skill` tool; Superpowers: `use_skill`).

## Env Var Management

Single source: `~/.config/ai/env`

| Variable | Used by | Purpose |
|----------|---------|---------|
| `CONTEXT7_API_KEY` | All agents | Library docs lookup |
| `FIRECRAWL_API_KEY` | All agents | Web search/scrape |
| `GITHUB_TOKEN` | OpenCode, Gemini | GitHub API |
| `CODEX_GITHUB_PERSONAL_ACCESS_TOKEN` | Codex only | GitHub API (same token value, different var name) |
| `NEON_API_KEY` | Fallback | Neon DB access |

Add new var: edit `~/.config/ai/env` only. Source from `~/.zshenv`:
```bash
source ~/.config/ai/env
```

## How Skills/Tools/MCPs/Plugins Install

### MCP Server
1. Add to agent config (opencode.json / mcp_config.json / config.toml)
2. Set env var in `~/.config/ai/env` if needed
3. First run: npx downloads package (allow network)

### Global Skill (`~/.config/ai/skills/`)
1. Create `~/.config/ai/skills/<name>/SKILL.md`
2. Agents auto-discover via symlinks

### Process Skill (`~/.config/ai/superpowers/skills/`)
Git-managed. Don't modify directly. Loaded via `use_skill` tool.

### KB Domain Skill (`~/.config/ai/kb/global/skills/`)
Markdown reference doc. Not skill-loader format. Read explicitly when referenced.

### Plugin (OpenCode)
1. Install npm package in `~/.config/opencode/` or create local plugin dir
2. Add to `opencode.json` `plugin[]` array
3. Loaded at startup

### Plugin (Gemini)
Stored in `~/.config/ai/config/plugins/<name>/`. Symlinked via `~/.gemini/plugins/`. Each has `plugin.json`.

## Consolidation Rules

1. **No duplicate tool dirs** — One tool = one dir in `~/.config/ai/mcp/<tool>/`
2. **No per-file JSON manifests** — Tool reference = one `README.md`, not N tool JSONs
3. **No stale symlinks** — Broken symlinks must be removed or fixed
4. **Agent configs stay thin** — Agent owns model/plugins/permissions/commands, references hub for rest
5. **Backup before destructive ops** — Per GEMINI.md safety rules
6. **Project overrides respected** — Project config always beats global

## Inventory After Consolidation

### MCP Reference Docs (in ~/.config/ai/mcp/)
- `brave-search/README.md` — Web & local search
- `chrome-devtools-mcp/README.md` — Browser automation (KEPT, others purged)
- `context7/README.md` — Library documentation
- `fetch/README.md` — URL content retrieval
- `firecrawl/README.md` — Web data platform (search/scrape/crawl/monitor/agent)
- `filesystem/README.md` — Filesystem access
- `github/README.md` — GitHub API (repos/issues/PRs/CI/search)
- `memory/README.md` — Persistent memory
- `neon/README.md` — Neon database
- `playwright/README.md` — Browser testing
- `puppeteer/README.md` — Headless browser (lazy)
- `sequential-thinking/README.md` — Structured problem solving
- `tabularis/README.md` — DB schema inspection
- `vercel/README.md` — Vercel deployment
- `mcp_config.json` — Shared MCP config

### Skills (in ~/.config/ai/skills/)
- 6 native skills: code-simplifier, devops-helper, firecrawl, git-diff-reviewer, laravel-assistant, modern-web-developer
- 14 superpowers skills: brainstorming, TDD, debugging, code review, etc.
- 22 KB domain skills: Laravel helpers, sysadmin procedures, etc.

### Removed/Consolidated
| Path | Action | Reason |
|------|--------|--------|
| `mcp/chrome-devtools/` (29 files) | Purged | Triple duplicate, kept chrome-devtools-mcp |
| `mcp/chrome_devtools/` (31 files) | Purged | Triple duplicate, kept chrome-devtools-mcp |
| `mcp/context7/*.json` (3 files) | → README.md | Consolidated tool manifests |
| `mcp/firecrawl/*.json` (22 files) | → README.md | Consolidated tool manifests |
| `mcp/github/*.json` (26 files) | → README.md | Consolidated tool manifests |
| `mcp/brave-search/*.json` (2+SETUP) | → README.md | Consolidated tool manifests |
| `mcp/fetch/fetch.json` (1 file) | → README.md | Renamed for consistency |
| `mcp/sequential-thinking/*.json` (1 file) | → README.md | Renamed for consistency |
| `mcp/tabularis/*.json` (4 files) | → README.md | Consolidated tool manifests |
| `skills/firecrawl-*` (29 symlinks) | Purged | Broken symlinks (stale artifacts) |
| `opencode/skills/superpowers` | Fixed → ai/superpowers/skills | Broken symlink path |
| `opencode/skills/` | → ai/skills symlink | Share all global skills |
| `codex/.env` | → ai/env symlink | Share env vars |
| `codex/kb` | → ai/kb symlink | Share knowledge base |
| `opencode puppeteer` | enabled: false | Duplicates playwright, lazy load |
| `mcp/chrome-devtools/` (29 files) | Pending `rm -rf` | Stale duplicate of chrome-devtools-mcp/ |
| `mcp/filesystem/SETUP.md` (6 files) | Renamed → README.md | Consistency with other 8 tool dirs |
| `~/.config/ai/plugins` (3 symlinks) | Fixed circular ref | Pointed to config/plugins/ directly |
| `~/.zshenv env source` | Added `set -a` wrapper | Vars now exported to MCP child processes |

## Backup

Pre-consolidation backup: `/tmp/opencode/ai-backup/` (2.1M).
Restore:
```bash
cp -a /tmp/opencode/ai-backup/config/ai/ ~/.config/ai/
cp -a /tmp/opencode/ai-backup/config/opencode/ ~/.config/opencode/
cp -a /tmp/opencode/ai-backup/config/gemini/ ~/.gemini/
cp -a /tmp/opencode/ai-backup/config/codex/ ~/.config/codex/
```

## Notes

- **Per-file JSON manifests** in `mcp/<tool>/*.json` (130 files + 29 chrome-devtools-mcp) are Gemini plugin tool cache. Gemini regenerates them on tool load. Do NOT manually remove unless verified harmless.
- **Gemini loads ALL MCPs at startup** (no lazy load). Mitigation: project-specific MCPs go in project `.agents/`, not global config.
- **Codex uses native skills format** in `~/.config/codex/skills/` — does NOT share `~/.config/ai/skills/`. Symlinks only for .env + kb.

