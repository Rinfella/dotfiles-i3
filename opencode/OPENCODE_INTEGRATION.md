# OmniRoute Integration with OpenCode

## Overview
OmniRoute runs locally as an OpenAI-compatible proxy and aggregator on port `20128`.
OpenCode connects to OmniRoute using the `@ai-sdk/openai-compatible` adapter.

## Configuration Details

- **OpenCode Config**: `~/.config/opencode/opencode.json` (backup saved at `opencode.json.bak`)
- **OmniRoute Base URL**: `http://127.0.0.1:20128/v1`
- **OmniRoute API Key**: `{env:OMNIROUTE_API_KEY}` in `~/.config/ai/.env`

## Registered Models in OpenCode

| Model ID | Display Name | Backend Target |
| :--- | :--- | :--- |
| `omniroute/rinfela-combo` | OmniRoute (Rinfela Combo) | Smart auto-failover combo |
| `omniroute/static-best-free` | OmniRoute (Static Best Free) | Best curated free models |
| `omniroute/auto/best-coding` | OmniRoute (Auto Best Coding) | Automatic top coding model |
| `omniroute/agy/gemini-3.1-pro-low` | Gemini 3.1 Pro (AGY) | Direct Antigravity CLI Gemini 3.1 Pro |
| `omniroute/agy/gemini-3.7-flash-medium` | Gemini 3.7 Flash Medium (AGY) | Direct Antigravity CLI Gemini 3.7 Flash |
| `omniroute/kiro/claude-sonnet-4.5` | Claude Sonnet 4.5 (Kiro) | Direct Kiro Claude Sonnet 4.5 |
| `omniroute/kiro/qwen3-coder-next` | Qwen 3 Coder Next (Kiro) | Direct Kiro Qwen 3 Coder Next |

## Usage Commands

- Start OpenCode with the default combo:
  ```bash
  opencode
  ```
- Switch models inside OpenCode interactive session:
  ```text
  /model omniroute/rinfela-combo
  /model omniroute/kiro/claude-sonnet-4.5
  /model omniroute/agy/gemini-3.1-pro-low
  ```
- Verify OmniRoute service status:
  ```bash
  curl -s http://127.0.0.1:20128/v1/models -H "Authorization: Bearer sk-452e2a2a6207984d-6bebb2-6a6a0d10"
  ```

## Automatic Fallback (Rate-Limit Protection)
Configured in `~/.config/opencode/rate-limit-fallback.json`:
- If `omniroute/rinfela-combo` hits any rate limit or goes down, OpenCode automatically fails over to:
  1. `bedrock-mantle/qwen.qwen3-coder-next` (AWS Bedrock)
  2. `omniroute/static-best-free`

## Startup & Performance Optimizations
Configured in `~/.config/opencode/opencode.json`:
- `small_model`: Set to `omniroute/agy/gemini-3.7-flash-medium` for sub-second title generation.
- `autoupdate`: Set to `false` to avoid checking remote registries on startup.
- `watcher.ignore`: Ignores `node_modules`, `.git`, `vendor`, `storage`, `.next`, and `dist` to avoid inotify lag.
- `setCacheKey`: Enabled under `provider.omniroute.options` for instant prompt caching.
- `mcp`: `sequential-thinking` and `github` installed globally and run directly from disk (`mcp-server-*`) instead of `npx -y`.

## Specialized Agents
- **`plan`** (`/agent plan`): `omniroute/kiro/claude-sonnet-4.5` (Deep architectural planning)
- **`code-reviewer`**: `omniroute/kiro/claude-sonnet-4.5` (Security & code reviews)
- **`test`**: `omniroute/kiro/qwen3-coder-next` (Test suite generation)
- **`debug`**: `omniroute/rinfela-combo` (Failover resilience)

## Workflow Commands
- `/review`: Review staged git diff against Laravel guidelines.
- `/routes`: Audit registered Laravel routes for missing authorization & duplicate endpoints.
- `/filament`: Scaffold Filament resources.
- `/audit-db`: Check schema for missing indexes & N+1 issues.

