# `~/.config/opencode` — OpenCode Config Root

Thin config. Central hub at `~/.config/ai/`.

## Directory Layout

```
~/.config/opencode/
├── opencode.json            # Main config: model, plugins, MCP, commands, agents, permissions
├── opencode-notifier.json   # Notifier plugin settings
├── rate-limit-fallback.json # Rate limit fallback config
├── package.json             # npm deps for local plugins
├── plugins/                 # OpenCode-specific plugins
│   ├── ponytail/            # Ponytail plugin (lazy coding mode)
│   └── superpowers.js → ~/.config/ai/superpowers/.opencode/plugins/superpowers.js
├── skills → ~/.config/ai/skills/          # SYMLINK — 35 global skills
├── superpowers → ~/.config/ai/superpowers/ # SYMLINK — 14 process skills
├── kb → ~/.config/ai/kb/                 # SYMLINK — shared KB
├── memory → ~/.config/ai/config/memory/  # SYMLINK — shared memory
├── .opencode/memory/       # Plugin runtime data
├── commands/               # Slash command .md files
└── tui.json                # TUI theme config
```

## Installed Plugins

| Plugin | Source | Purpose |
|--------|--------|---------|
| `@mumme-it/opencode-caveman` | npm | Ultra-terse communication mode |
| `ponytail` | local (`plugins/ponytail`) | YAGNI-first lazy dev mode |
| `superpowers` | symlink → ai/superpowers | Skills framework, 14 process skills |
| `opencode-agent-memory` | npm | Persistent memory blocks |
| `cc-safety-net` | npm | Blocks destructive git/filesystem commands |
| `@azumag/opencode-rate-limit-fallback` | npm | Auto-switch models on rate limit |
| `@mohak34/opencode-notifier` | npm | Desktop notifications |

## MCP Servers

All defined in `opencode.json`. Lazy loading via `enabled: false`.

| Server | State | Command |
|--------|-------|---------|
| omniroute | enabled | `omniroute --mcp` (stdio transport to local router :20128) |
| sequential-thinking | enabled | `npx @modelcontextprotocol/server-sequential-thinking` |
| filesystem | enabled | `npx @modelcontextprotocol/server-filesystem` |
| firecrawl | disabled | `npx firecrawl-mcp` — needs `FIRECRAWL_API_KEY` |
| github | disabled | `npx @modelcontextprotocol/server-github` — needs `GITHUB_TOKEN` |
| context7 | disabled | remote `https://mcp.context7.com/mcp` — needs `CONTEXT7_API_KEY` |
| playwright | disabled | `npx @playwright/mcp@latest` |
| fetch | disabled | `uvx mcp-server-fetch` |
| memory | disabled | `npx @modelcontextprotocol/server-memory` |
| brave-search | disabled | `npx @anthropic/mcp-brave-search` |
| puppeteer | disabled | `npx @puppeteer/mcp` — duplicates playwright |

Project MCPs (DB, local services) go in project `opencode.json` — never load globally.

## LSP Servers

| Server | Extensions | Notes |
|--------|-----------|-------|
| laravel-lsp | `.php`, `.blade.php` | Absolute path to composer global bin; requires `composer global require laravel/lsp` |

Install:
```bash
composer global require laravel/lsp
```

Restart opencode after changing `opencode.json` — config loads once at startup.

## Custom Agents

| Agent | Mode | Model | Use |
|-------|------|-------|-----|
| `@deep-debugger` | subagent | `omniroute/combo-reason-architect` | Deep architectural debugging & root-cause analysis |
| `@explore` | subagent | `omniroute/combo-free-overflow` | Fast zero-cost repo exploration & file search (read-only) |
| `@test` | subagent | `omniroute/mistral/codestral-latest` | Write and execute tests |
| `@code-reviewer` | subagent | `omniroute/combo-reason-architect` | Strict architectural & security review (read-only) |
| `@plan` | subagent | `omniroute/combo-fast-chat` | Architecture planning & step-by-step roadmaps (read-only) |
| `@devops` | subagent | `omniroute/combo-fast-chat` | System administration, Docker, systemd, journalctl |
| `@docs` | subagent | `omniroute/combo-fast-chat` | Documentation, changelogs, docstrings, README drafting |
| `@fastapi` | subagent | `omniroute/combo-code-heavy` | Python FastAPI & Pydantic v2 specialist |

## Slash Commands

### Analysis & Docs: `/audit`, `/explore`, `/deep-debug`, `/docs`
### Laravel/Filament: `/filament`, `/seed`, `/debug`, `/audit-db`, `/test`, `/make-migration`, `/make-service`, `/make-observer`, `/make-policy`, `/make-job`
### System (Arch): `/sys-update`, `/sys-service`, `/sys-packages`, `/sys-logs`, `/sys-stats`

## Permission Safety

```
bash:  sudo* → ask, rm -rf /* → deny, git push --force* → ask
       php artisan migrate:fresh* → deny
read:  *.env → deny
edit:  **/.env, **/config/*.key → deny
```

## Model

- Primary: `omniroute/combo-code-heavy` (local proxy router)
- Small: `omniroute/combo-fast-chat` (fast low-latency router)
- Free Fallbacks: OpenRouter Free Auto, Mistral Codestral, Gemma 4, Nemotron 3
- Quarantined: AWS Bedrock models (manual selection only)
- Theme: Catppuccin
- Rate-limit fallback: auto-cycle via circuit breaker

## Shared via Central Hub

| Symlink | Target | Shares |
|---------|--------|--------|
| `kb/` | `~/.config/ai/kb/` | Global rules + domain skills |
| `skills/` | `~/.config/ai/skills/` | 35 global skills |
| `superpowers/` | `~/.config/ai/superpowers/` | 14 process skills |
| `memory/` | `~/.config/ai/config/memory/` | Persona/human/project memory |
