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

| Server | Load | Command |
|--------|------|---------|
| sequential-thinking | always | `npx @modelcontextprotocol/server-sequential-thinking` |
| firecrawl | always | `npx firecrawl-mcp` |
| github | always | `npx @modelcontextprotocol/server-github` |
| context7 | always | remote `https://mcp.context7.com/mcp` |
| playwright | always | `npx @playwright/mcp@latest` |
| fetch | always | `uvx mcp-server-fetch` |
| memory | always | `npx @modelcontextprotocol/server-memory` |
| brave-search | always | `npx @anthropic/mcp-brave-search` |
| filesystem | always | `npx @modelcontextprotocol/server-filesystem` |
| puppeteer | LAZY | `npx @puppeteer/mcp` — disabled by default, duplicates playwright |

Project MCPs (DB, local services) go in project `opencode.json` — never load globally.

## Custom Agents

| Agent | Mode | Model | Use |
|-------|------|-------|-----|
| `@debug` | subagent | Claude Haiku 4 | Debug errors |
| `@test` | subagent | Claude Haiku 4 | Write/run tests |
| `@code-reviewer` | subagent | Claude Sonnet 4 | Code review (read-only) |
| `@plan` | subagent | Claude Haiku 4 | Architecture/planning (read-only) |

## Slash Commands

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

- Primary: `amazon-bedrock/anthropic.claude-sonnet-4-20250514-v1:0`
- Small: `amazon-bedrock/anthropic.claude-haiku-4-20250514-v1:0`
- Theme: Catppuccin
- Rate-limit fallback: auto-cycle via circuit breaker

## Shared via Central Hub

| Symlink | Target | Shares |
|---------|--------|--------|
| `kb/` | `~/.config/ai/kb/` | Global rules + domain skills |
| `skills/` | `~/.config/ai/skills/` | 35 global skills |
| `superpowers/` | `~/.config/ai/superpowers/` | 14 process skills |
| `memory/` | `~/.config/ai/config/memory/` | Persona/human/project memory |
