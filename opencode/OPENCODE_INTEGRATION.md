# OmniRoute Integration with OpenCode (Overhaul Edition)

## 1. Overview
OmniRoute runs locally as an OpenAI-compatible proxy and intelligent routing gateway on port `20128`.
OpenCode connects to OmniRoute using the `@ai-sdk/openai-compatible` adapter.

- **OmniRoute Base URL**: `http://127.0.0.1:20128/v1`
- **Canonical Env File**: `~/.config/ai/env` (contains `OMNIROUTE_API_KEY`, `BEDROCK_API_KEY`, etc.)
- **OpenCode Config**: `~/.config/opencode/opencode.json` (symlinked from `~/.config/doti3/opencode/opencode.json`)
- **Default Coding Model**: `omniroute/combo-code-heavy`
- **Default Small/Helper Model**: `omniroute/combo-fast-chat`

---

## 2. Multi-Provider Scenario Combos

OmniRoute combines models across **Kiro**, **AGY**, **NVIDIA NIM**, **Mistral**, **LiteRouter**, **Ollama Cloud**, and **OpenRouter**, with **AWS Bedrock** quarantined strictly as a terminal emergency fallback:

| Combo Name | Strategy | Priority / Distribution Sequence | Description |
| :--- | :--- | :--- | :--- |
| `combo-code-heavy` | **Priority Failover** | 1. Kiro Claude Sonnet 4.5<br>2. **AGY Claude Sonnet 4.6** (5h refresh subscription)<br>3. Mistral Codestral<br>4. NVIDIA Devstral 123B<br>5. Kiro Qwen 3 Coder Next<br>6. AGY Gemini 3.7 Flash High<br>7. LiteRouter DeepSeek V4 Flash<br>8. Ollama Cloud Qwen 3.5 397B<br>9. *AWS Bedrock Sonnet 4.5 (Emergency Fallback only)* | Primary coding combo for dev & devops workloads. Prioritizes free high-tier & 5h refreshing AGY models. |
| `combo-reason-architect` | **Priority Failover** | 1. AGY Gemini 3.1 Pro Low<br>2. **AGY Claude Sonnet 4.6 High** (5h refresh subscription)<br>3. Kiro Claude Sonnet 4.5 High<br>4. LiteRouter DeepSeek R1<br>5. NVIDIA Nemotron 3 Ultra 550B<br>6. Ollama Cloud DeepSeek V4 Pro<br>7. *AWS Bedrock Claude Opus 4.6 (Emergency Fallback only)* | Deep reasoning and planning combo for `/agent plan` and `/review`. |
| `combo-fast-chat` | **Round-Robin** | • AGY Gemini 3.7 Flash Low<br>• Kiro Claude Haiku 4.5<br>• Mistral Small Latest<br>• NVIDIA Llama 3.3 Nemotron 49B<br>• LiteRouter DeepSeek V3<br>• Ollama Cloud GPT-OSS 20B | High-speed, low-latency conversational pool. Zero Bedrock. |
| `combo-free-overflow` | **Round-Robin** | • Kiro Claude Sonnet 4.5<br>• Mistral Devstral<br>• NVIDIA Qwen 3.5 397B<br>• AGY Gemini 3.7 Flash Medium<br>• LiteRouter DeepSeek V4 Flash<br>• Ollama Cloud DeepSeek V4 Flash<br>• OpenRouter Free Auto | Zero-cost multi-provider fallback and overflow pool. Zero Bedrock. |

---

## 3. Direct Individual Model Selection (`/model`)

All individual provider models can still be invoked directly at any time:

### Antigravity (AGY - Paid Subscription, 5h Quota Refresh)
- `/model omniroute/agy/claude-sonnet-4-6`
- `/model omniroute/agy/claude-sonnet-4-6-high`
- `/model omniroute/agy/gemini-3.1-pro-low`
- `/model omniroute/agy/gemini-3.7-flash-high`
- `/model omniroute/agy/gemini-3.7-flash-medium`
- `/model omniroute/agy/gemini-3.7-flash-low`

### Kiro (Free AWS Builders Tier)
- `/model omniroute/kiro/claude-sonnet-4.5`
- `/model omniroute/kiro/claude-haiku-4.5`
- `/model omniroute/kiro/qwen3-coder-next`
- `/model omniroute/kiro/deepseek-3.2`
- `/model omniroute/kiro/glm-5`
- `/model omniroute/kiro/minimax-m2.5`
- `/model omniroute/kiro/minimax-m2.1`

### NVIDIA NIM (Free Tier)
- `/model omniroute/nvidia/mistralai/devstral-2-123b-instruct-2512`
- `/model omniroute/nvidia/nvidia/nemotron-3-ultra-550b-a55b`
- `/model omniroute/nvidia/nvidia/llama-3.3-nemotron-super-49b-v1`
- `/model omniroute/nvidia/qwen/qwen3.5-397b-a17b`

### Mistral (Free Tier)
- `/model omniroute/mistral/codestral-latest`
- `/model omniroute/mistral/devstral-latest`
- `/model omniroute/mistral/mistral-small-latest`
- `/model omniroute/mistral/mistral-large-latest`

### LiteRouter
- `/model omniroute/literouter/deepseek-r1`
- `/model omniroute/literouter/deepseek-v4-flash`
- `/model omniroute/literouter/deepseek-v3`

### Ollama Cloud
- `/model omniroute/ollama-cloud/qwen3.5:397b`
- `/model omniroute/ollama-cloud/deepseek-v4-pro`
- `/model omniroute/ollama-cloud/deepseek-v4-flash`
- `/model omniroute/ollama-cloud/gpt-oss:20b`

### OpenRouter
- `/model omniroute/openrouter/openrouter/free`

---

## 4. Specialized Agents

OpenCode subagents are mapped to optimal models:
- **`plan`** (`/agent plan`): `omniroute/combo-reason-architect` (Deep planning & system design, read-only).
- **`code-reviewer`** (`/agent code-reviewer`): `omniroute/combo-reason-architect` (Security, architecture & standards compliance, read-only).
- **`debug`** (`/agent debug`): `omniroute/combo-code-heavy` (Log parsing, stack tracing, error resolution).
- **`test`** (`/agent test`): `omniroute/kiro/qwen3-coder-next` (Pest v3, pytest, unit & feature tests).
- **`devops`** (`/agent devops`): `omniroute/combo-code-heavy` (Systemd, Docker, journalctl, network & package management).
- **`fastapi`** (`/agent fastapi`): `omniroute/combo-code-heavy` (FastAPI 0.115+, Pydantic v2 schemas, async routes).
- **`refactor`** (`/agent refactor`): `omniroute/combo-code-heavy` (Ponytail lazy dev code simplification and dead code cleanup).

---

## 5. Workflow Commands (Slash Commands)

- `/commit`: Inspect staged diff (`git diff --cached`) and generate a Conventional Commit message.
- `/review`: Review staged code changes using the `code-reviewer` agent.
- `/routes`: Audit registered application routes (Laravel or FastAPI).
- `/fastapi`: Scaffold or audit FastAPI routers and schemas.
- `/devops`: Diagnose systemd units, containers, and logs.
- `/filament`: Scaffold complete Filament v5 resources.
- `/audit-db`: Check schema for missing indexes, foreign keys, and N+1 query risks.

---

## 6. Knowledge Base Rules Loaded

OpenCode loads the following centralized guidelines on every session:
1. `00-global-directives.md`: Proactive state management, planning protocol, non-destructive safety.
2. `01-tall-stack.md`: Modern Laravel 13+, Filament v5+, PHP 8.4+, MariaDB primary, Pest v3 testing.
3. `02-infrastructure.md`: Linux sysadmin, systemd units, Docker orchestration.
4. `03-cicd.md`: GitHub Actions, automated checks, deployment safety.
5. `04-python-fastapi.md`: FastAPI 0.115+, Python 3.12+, Pydantic v2, async DB sessions, lifespan context.
6. `05-modern-frontend.md`: Bun/pnpm, Vite, Tailwind CSS v4, accessibility, Core Web Vitals.
7. `06-dos-and-donts.md`: Data protection, Ponytail philosophy, Bedrock quarantine policy.
8. `07-git-workflow.md`: Conventional commits, clean staging discipline, no force-pushing.
