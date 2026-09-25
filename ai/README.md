# ~/.config/ai — Global AI Agent Hub

Single source of truth for Gemini CLI, OpenCode, Codex CLI.

## Architecture

```
~/.config/ai/                    ← CENTRAL HUB (owns shared data)
├── env                          ← Single env var source for ALL agents
├── RULES.md                     ← Canonical architecture doc
├── README.md                    ← This file
├── mcp/
│   ├── mcp_config.json          ← Gemini MCP config (shared via symlink)
│   ├── <tool>/README.md         ← Per-tool reference (consolidated, not JSONs)
├── kb/                          ← Knowledge base
│   ├── global/rules/            ← Cross-agent dev rules (loaded every session)
│   ├── global/skills/           ← Domain skill guides (referenced by commands)
│   └── project/                 ← Per-project context, plans, templates
├── skills/                      ← Global shareable skills (6 native)
├── superpowers/                 ← Process skills framework (14 skills, git-managed)
└── config/
    ├── memory/                  ← Shared agent memory (persona/human/project)
    ├── plugins/                 ← Plugin storage (not auto-loaded, agent-specific)
    ├── gemini-projects/         ← Gemini project metadata
    └── GLOBAL-vs-PROJECT.md     ← MCP/skills/rules boundary doc
```

## Override Chain (Priority: High → Low)

```
PROJECT config (.agents/, project opencode.json)
    ↑ overrides
AGENT config (~/.config/opencode/, ~/.config/codex/, ~/.gemini/)
    ↑ overrides
GLOBAL hub (~/.config/ai/)
    ↑ base
```

**Rule**: Project config overrides agent config overrides global.
**Example**: Project `opencode.json` can override MCP from global. Project `.agents/rules/` overrides `kb/global/rules/`.

## What Is Shared vs Agent-Specific

### SHARED (~/.config/ai/) — One copy, all agents read

| Path | Contents | Accessed by |
|------|----------|-------------|
| `env` | API keys (CONTEXT7, FIRECRAWL, GITHUB, NEON) | All via symlink or shell source |
| `kb/global/rules/` | Dev rules (00-global-directives, TALL stack, infra, CI/CD) | OpenCode (instructions[]), Gemini (GEMINI.md refs) |
| `kb/global/skills/` | Domain guides (Laravel, sysadmin, git, etc.) | OpenCode (command templates reference these) |
| `kb/project/` | Active task, architecture notes, plans | All (symlinked at project level) |
| `mcp/mcp_config.json` | Gemini MCP definitions | Gemini (direct). OpenCode/Codex have their own MCP config formats |
| `mcp/<tool>/README.md` | Per-tool setup + usage reference | All (human-readable reference) |
| `skills/` | Shareable skill dirs (code-simplifier, devops-helper, etc.) | OpenCode (skills symlink). Gemini (skills symlink). |
| `superpowers/` | Process skills framework | OpenCode (superpowers symlink + plugin). Gemini (skills symlink). |
| `config/memory/` | Persona + human memory blocks | OpenCode (memory symlink). Gemini (config symlink). |
| `config/plugins/` | Plugin packages (caveman, antigravity, etc.) | Gemini (plugins symlink). Stored centrally but each agent loads only compatible plugins. |

### AGENT-SPECIFIC — Stays in agent dir

| Agent | Config file | Owns |
|-------|-------------|------|
| **Gemini** | `~/.gemini/GEMINI.md`, `antigravity-*/settings.json` | Agent rules, permissions, trusted workspaces, keybindings. Antigravity data (brain, conversations, annotations). |
| **OpenCode** | `~/.config/opencode/opencode.json`, `tui.json` | Model selection, plugins[], commands[], permissions, formatter, agents (subagent type defs), TUI theme. Plus `plugins/` (ponytail), `commands/` (slash commands). |
| **Codex** | `~/.config/codex/config.toml` | Model defaults, approval policy, app integrations (github, vercel, openai), project trust levels. Plus `skills/` (codex-operator, document-reader, etc. — agent-native format). |

### PROJECT-SPECIFIC — In project root

| Path | Contents | Overrides |
|------|----------|-----------|
| `.agents/` | Project rules, skills, MCPs, plans, context | Agent rules, global MCPs |
| `opencode.json` (project root) | Project MCPs, commands | Agent opencode.json |
| `.codex/config.toml` (project root) | Project MCPs, project skills | Agent config.toml |
| `CLAUDE.md` / `GEMINI.md` / `AGENTS.md` | Project instructions | Global directives |

## Lazy Loading Strategy

### OpenCode — Built-in lazy via `enabled` field

```json
"mcp-name": {
    "type": "local",
    "command": ["npx", "-y", "some-package"],
    "enabled": false   // ← not loaded until explicitly needed
}
```

**Current lazy config** (opencode.json):

| MCP | enabled | When needed |
|-----|---------|-------------|
| sequential-thinking | always | Complex problem solving |
| firecrawl | always | Web search/scrape |
| github | true | Code review, PRs, issues |
| context7 | true | Library docs lookup |
| playwright | true | Browser inspection (already light — npx on demand) |
| fetch | always | URL content fetch |
| memory | always | Persistent memory blocks |
| brave-search | always | Web search |
| puppeteer | always | Headless browser |
| filesystem | always | File operations |

**Lazy candidates** (set `enabled: false`):

| MCP | Why lazy | Enable by |
|------|----------|-----------|
| playwright | Browser inspection only needed per-task | Command or task agent auto-enables |
| puppeteer | Duplicates playwright functionality | Uncommon — remove if playwright covers needs |
| memory | Only needed on memory operations | On-demand |
| brave-search | Firecrawl is primary search, brave is fallback | On-demand |
| filesystem | Always available natively, MCP rarely needed | On-demand |

### Gemini — No built-in lazy. All MCPs load at startup.

**Mitigation**: Use per-project `mcp_config.json` in project roots. Keep global `mcp_config.json` minimal.

### Codex — Per-project MCP separation

**Per-project MCPs** in `project/.codex/config.toml` keep project-specific tools (databases, local services) out of global startup.

**`startup_timeout_sec`** prevents slow MCPs from blocking startup.

### Skills — Auto-discovered, not loaded until invoked

- OpenCode `skill` tool lists all skills but loads SKILL.md only when invoked
- Superpowers skills discovered via plugin, not loaded until `use_skill` called
- KB skills are reference docs — not loaded as skills, only read when command references them

## How Tools/Skills/MCPs/Plugins Are Installed

### MCP Server

1. Add to agent config: opencode.json / mcp_config.json / config.toml
2. Set env vars in `~/.config/ai/env` if needed
3. First run: agent downloads package via npx (allow network)

### Skill

**Global skill** (`~/.config/ai/skills/`):
1. Create dir `~/.config/ai/skills/<name>/SKILL.md`
2. Agents auto-discover via symlinks

**Process skill** (`~/.config/ai/superpowers/skills/`):
1. Already git-managed. Don't modify directly.
2. Loaded via superpowers plugin `use_skill` tool.

**KB skill** (`~/.config/ai/kb/global/skills/`):
1. Just a markdown file — not a skill loader format.
2. Referenced by commands or read explicitly.

### Plugin (OpenCode)

1. Install npm package in `~/.config/opencode/` or create local plugin dir
2. Add to `opencode.json` `plugin[]` array
3. Plugin code loaded at startup

### Plugin (Gemini)

1. Stored in `~/.config/ai/config/plugins/<name>/`
2. Symlinked via `~/.gemini/plugins/`
3. Each plugin has `plugin.json` with metadata

## Env Var Management

File: `~/.config/ai/env`

| Variable | Purpose | Used by |
|----------|---------|---------|
| CONTEXT7_API_KEY | Library docs lookup | context7 MCP |
| FIRECRAWL_API_KEY | Web search/scrape | firecrawl MCP |
| GITHUB_TOKEN | GitHub API | OpenCode github MCP, Gemini github MCP |
| CODEX_GITHUB_PERSONAL_ACCESS_TOKEN | GitHub API (codex) | Codex github MCP (same value as GITHUB_TOKEN) |
| NEON_API_KEY | Neon database | Optional fallback |

**Adding new var**: Edit `~/.config/ai/env` only. Source via `~/.zshenv`: `source ~/.config/ai/env`

## Directory Tree (After Consolidation)

```
~/.config/ai/
├── env
├── README.md
├── RULES.md
├── mcp/
│   ├── mcp_config.json
│   ├── brave-search/README.md          (DISABLED — add BRAVE_SEARCH_API_KEY to enable)
│   ├── chrome-devtools-mcp/README.md   (29 tool JSONs = Gemini plugin cache)
│   ├── context7/README.md
│   ├── fetch/README.md
│   ├── filesystem/README.md
│   ├── firecrawl/README.md + instructions.md
│   ├── github/README.md
│   ├── memory/README.md
│   ├── neon/README.md
│   ├── playwright/README.md
│   ├── puppeteer/README.md
│   ├── sequential-thinking/README.md
│   ├── tabularis/README.md
│   └── vercel/README.md
├── kb/
│   ├── global/rules/       (4 files: 00-global-directives, 01-tall-stack, 02-infrastructure, 03-cicd)
│   ├── global/skills/      (22 files: Laravel helpers, sysadmin, git, etc.)
│   └── project/            (active-task, architecture, plans, MCP_EXTRAS)
├── skills/                 (6 native skills)
├── superpowers/            (14 process skills, git repo)
├── RULES.md                (this file)
└── config/
    ├── memory/             (persona.md, human.md)
    ├── plugins/            (10 plugin packages)
    ├── gemini-projects/    (20+ project UUID configs)
    ├── GLOBAL-vs-PROJECT.md
    └── README.md
```

## Removed / Consolidated

| Path | Action | Reason |
|------|--------|--------|
| mcp/chrome-devtools/ (29 files) | Purged | Triple duplicate, kept chrome-devtools-mcp |
| mcp/chrome_devtools/ (31 files) | Purged | Triple duplicate |
| mcp/*/tool.json (82 files across 7 dirs) | → README.md | Consolidated per-tool manifests |
| skills/firecrawl-* (29 broken symlinks) | Purged | Stale artifacts |
| opencode/skills/superpowers (broken) | Fixed → ai/superpowers/skills | Wrong path |
| opencode/skills/ (was 1 broken symlink) | → ai/skills symlink | Share all global skills |
| gemini antigravity symlinks (4 broken) | Fixed | Wrong paths in sub-agents |
| codex/.env + kb (missing) | Added symlinks | Now shares central hub |

Backup: `/tmp/opencode/ai-backup/` (2.1M)
