# Agent Architecture — Separation of Concerns

## Override Priority (HIGH → low)

```
1. PROJECT root (.agents/, CLAUDE.md, project opencode.json)
2. AGENT dir  (~/.config/opencode/, ~/.gemini/, ~/.config/codex/)
3. GLOBAL hub (~/.config/ai/)
```

**Rule**: Project beats agent beats global. Exact same key defined at higher level hides lower.

## Per-Agent Config Details

### Gemini CLI (`~/.gemini/`)

**File**: `GEMINI.md` — agent rules + safety directives.

**Symlinks**: `config/ → ~/.config/ai/` (full hub access). `.env → ~/.config/ai/env`.

**MCP**: Reads `mcp/mcp_config.json` via symlink chain. All MCPs load at startup (no lazy).

**Plugins**: Stored in `~/.config/ai/config/plugins/`, symlinked via `~/.gemini/plugins/`.

**Skills**: `skills/ → ~/.config/ai/skills/`. Also reads superpowers/skills.

**Per-project**: Place `mcp_config.json` in project root for project-specific MCPs (overrides global).

**Data** (NOT shared): `antigravity/` brain, conversations, annotations, browser recordings, implicit, knowledge.

### OpenCode (`~/.config/opencode/`)

**File**: `opencode.json` — model, plugins, MCPs, commands, agents, permissions, formatter.

**Symlinks**: `kb/, superpowers/, skills/, memory/ → ~/.config/ai/`.

**MCP lazy loading**: `enabled: false` in opencode.json → MCP not loaded until needed.

**Skills**: Discovered via `skills/` symlink + superpowers plugin auto-discovery.

**Plugins**: npm packages (`@mumme-it/opencode-caveman`) + local dirs (`plugins/ponytail/`) + symlinks (`plugins/superpowers.js`).

**Commands**: Slash commands in `commands/` dir. Each is a markdown template with agent type.

**Agents**: Subagent definitions (`@debug`, `@test`, `@code-reviewer`, `@plan`) with model/permission settings.

**Per-project**: `opencode.json` in project root merges/overrides global. See `~/.config/ai/kb/project/AGENTS_TEMPLATE.md`.

### Codex CLI (`~/.config/codex/`)

**File**: `config.toml` — MCPs, apps, approval policy, project trust.

**Symlinks**: `.env → ~/.config/ai/env`, `kb/ → ~/.config/ai/kb`.

**MCP**: Defined in `[mcp_servers.*]` sections. Remote MCPs via URL (vercel, openai). Local via npx (playwright, context7). GitHub via bearer token.

**Skills**: Native skills in `skills/` dir (codex-operator, document-reader, mcp-troubleshooter, web-dev-qol). Does NOT use `~/.config/ai/skills/` directly (different skill format).

**Apps**: `[apps.*]` sections define tool integrations (github, vercel, openai-developers) with approval modes.

**Per-project**: `project/.codex/config.toml` for project-specific MCPs. Trust via `[projects."path"]`.

## Loading Order

```
1. Global rules (kb/global/rules/) injected into system prompt
2. Agent config loaded (model, plugins, permissions)
3. MCP servers start (all at once for Gemini, lazy for OpenCode)
4. Skills discovered (listed but content loaded on demand)
5. Project config merged on top (overrides)
6. User message processed
7. Tools/skills invoked as needed
```

## MCP Separation

| Scope | Where defined | Example |
|-------|---------------|---------|
| **Global** | `opencode.json`, `mcp_config.json`, `config.toml` | sequential-thinking, context7, firecrawl, github |
| **Agent** | Same files (agent-specific) | ponytail plugin, codex-operator skill |
| **Project** | Project `opencode.json`, `.codex/config.toml`, `.agents/` | Database MCPs, local services, project rules |

## Config Override Examples

### Project overrides global Firebase MCP
```
# project/opencode.json
{ "mcp": { "firebase": { "type": "local", "command": [...], "enabled": true } } }
```

### Project disables a global MCP
```
# project/opencode.json
{ "mcp": { "brave-search": { "enabled": false } } }
```

### Project adds project-specific rules
```
# project/.agents/rules/PROJECT_RULES.md
# Loaded in addition to kb/global/rules/
```

## Safety Net (cc-safety-net plugin)

Blocks destructive commands unless explicitly approved:
- `rm -rf outside cwd`
- `git push --force`, `git reset --hard`
- `php artisan migrate:fresh`, `migrate:reset`
- `sudo` commands (asks)

Configured in `opencode.json` `permission.bash` block.

## Migration Guide (Adding New Agent)

1. Create agent config dir
2. Symlink `~/.config/ai/env` for env vars
3. Symlink `~/.config/ai/kb` for common rules
4. Add MCP definitions in agent's config format
5. Symlink `~/.config/ai/skills` if agent supports shared skills
6. Reference `~/.config/ai/RULES.md` as onboarding doc
