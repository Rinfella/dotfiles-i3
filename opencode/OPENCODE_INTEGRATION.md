# OmniRoute Integration with OpenCode

## 1. Overview
OmniRoute runs locally as an OpenAI-compatible proxy and intelligent routing gateway on port `20128`.
OpenCode connects to OmniRoute using the `@ai-sdk/openai-compatible` adapter.

- **OmniRoute Base URL**: `http://127.0.0.1:20128/v1`
- **Canonical Env File**: `~/.config/ai/env` (contains `OMNIROUTE_API_KEY`, `FIRECRAWL_API_KEY`, etc.)
- **OpenCode Config**: `~/.config/opencode/opencode.json`
- **Default Coding Model**: `omniroute/combo-code-heavy`
- **Default Small/Helper Model**: `omniroute/combo-fast-chat`

---

## 2. Multi-Provider Scenario Combos

OmniRoute orchestrates models across **AGY (Dual Accounts)**, **Free-AI**, **KiloCode**, **Mistral**, **OpenRouter**, **Ollama Cloud**, **LiteRouter**, and **Kiro**:

| Combo Name | Strategy | Priority / Distribution Sequence | Description |
| :--- | :--- | :--- | :--- |
| `combo-code-heavy` | **Priority Failover** | 1. **AGY Claude Sonnet 4.6** (Dual-account pool)<br>2. **Mistral Codestral Latest** (256k context dedicated coding model, 0.9s)<br>3. **Free-AI Qwen 3.6 Coder 35B** (1.6s fast coding)<br>4. **AGY Gemini 3.8 Flash High** (1M context failover)<br>5. **OpenRouter Cohere North Mini Code Free** (0.6s reasoning coder)<br>6. **KiloCode Nemotron 3.5 Super VL Free** (0.9s)<br>7. **Ollama Cloud Gemma 4 31B** (1.8s cloud 31B)<br>8. **LiteRouter DeepSeek V3.2**<br>9. *Kiro Claude Sonnet 4.5 (Quota fallback)*<br>10. *Kiro Qwen 3 Coder Next (Quota fallback)* | Primary coding combo for dev & execution workloads. Context-safe 1M token ceiling prevents truncation during codebase analysis handoffs. Dual AGY accounts prevent quota drops. |
| `combo-reason-architect` | **Priority Failover** | 1. **AGY Claude Opus 4.6 Thinking** (Deepest architectural reasoning, dual-account pool)<br>2. **AGY Claude Sonnet 4.6** (Deep coding intelligence)<br>3. **AGY Gemini 3.8 Flash High** (1M context reasoning)<br>4. **OpenRouter Nemotron 3.5 Lightning Free** (0.8s fast reasoning)<br>5. **Free-AI Qwen 3.6 Coder 35B** (Reasoning coder)<br>6. **OpenRouter Cohere North Mini Code Free**<br>7. **KiloCode Auto Free Tier** (1.3s)<br>8. **Mistral Codestral** (256k context)<br>9. **LiteRouter DeepSeek V3.2**<br>10. *Kiro Claude Sonnet 4.5 (Quota fallback)* | Deep reasoning and planning combo for `/agent plan`, `@deep-debugger`, and `/review`. |
| `combo-fast-chat` | **Round-Robin** | • **Free-AI Qwen 3.6 35B** (1.1s)<br>• **KiloCode Flint 1.0 Free** (0.8s)<br>• **AGY Gemini 3.8 Flash Low**<br>• **AGY Gemini 3.5 Flash Lite** (2.1s)<br>• **OpenRouter Dots 3 Note Free** (1.2s)<br>• **OpenRouter Free Auto**<br>• **Ollama Cloud Gemma 4 31B** (1.8s)<br>• **KiloCode Auto Free Tier** | High-speed, low-latency conversational pool across 100% free models. Used by `@devops`, `@docs`, and small helper tasks. |
| `combo-free-overflow` | **Round-Robin** | • **Free-AI Qwen 3.6 Coder 35B**<br>• **KiloCode Nemotron 3.5 Super VL Free**<br>• **OpenRouter Free Auto**<br>• **OpenRouter Cohere North Mini Code Free**<br>• **OpenRouter Nemotron 3.5 Lightning Free**<br>• **Mistral Codestral** (256k context)<br>• **Ollama Cloud Gemma 4 31B**<br>• **LiteRouter DeepSeek V3.2**<br>• **AGY Gemini 3.5 Flash Lite** | Zero-cost multi-provider fallback and overflow pool used by `@explore` across all 7 connected free providers. |

---

## 3. Direct Individual Model Selection (`/model`)

All individual provider models can be selected directly in OpenCode:

### Antigravity (AGY - Dual Account Load-Balanced Pool)
- `/model omniroute/agy/claude-sonnet-4-6` (Anthropic Claude Sonnet 4.6)
- `/model omniroute/agy/claude-opus-4-6-thinking` (Claude Opus 4.6 Thinking / Gemini 3 Flash)
- `/model omniroute/agy/gemini-3.8-flash-high` (1M Context)
- `/model omniroute/agy/gemini-3.8-flash-medium` (1M Context)
- `/model omniroute/agy/gemini-3.8-flash-low` (1M Context)
- `/model omniroute/agy/gemini-3.8-flash-tiered` (1M Context)
- `/model omniroute/agy/gemini-3.5-flash-lite` (Ultra Fast 1M Context)
- `/model omniroute/agy/gemini-3-flash` (Fast 1M Context)

### Mistral
- `/model omniroute/mistral/codestral-latest` (Codestral 2508 - 256k Context, 0.9s)

### Free-AI (NEW!)
- `/model omniroute/free-ai/qwen-coder` (Qwen 3.6 Coder 35B - 1.6s)
- `/model omniroute/free-ai/qwen7b` (Qwen 3.6 35B Fast - 1.1s)

### KiloCode (NEW!)
- `/model omniroute/kilocode/kilo-auto/free` (KiloCode Auto Free Tier - 1.3s)
- `/model omniroute/kilocode/nvidia/nemotron-3.5-super-vl:free` (Nemotron 3.5 Super VL - 0.9s)
- `/model omniroute/kilocode/recursive/flint-v1.0:free` (Flint 1.0 Free - 0.8s)

### Ollama Cloud
- `/model omniroute/ollama-cloud/gemma4:31b` (Gemma 4 31B Instruct - 1.8s)

### OpenRouter Free
- `/model omniroute/openrouter/openrouter/free` (Auto-routing Free Tier - 2.0s)
- `/model omniroute/openrouter/cohere/north-mini-code:free` (Reasoning Code - 0.6s)
- `/model omniroute/openrouter/nvidia/nemotron-3.5-lightning:free` (Fast Reasoning - 0.8s)
- `/model omniroute/openrouter/dots-studio/dots-3-note-preview:free` (Fast Chat - 1.2s)

### LiteRouter (NEW!)
- `/model omniroute/literouter/deepseek-v3.2` (DeepSeek V3.2)

### Kiro (AWS Builders Tier — Quota Resets Monthly on 1st)
- `/model omniroute/kiro/claude-sonnet-4.5`
- `/model omniroute/kiro/claude-haiku-4.5`
- `/model omniroute/kiro/qwen3-coder-next`

---

## 4. Specialized Agents

OpenCode subagents mapped to optimal models:
- **`plan`** (`/agent plan`): `omniroute/combo-reason-architect` (Deep planning & system design, read-only).
- **`code-reviewer`** (`/agent code-reviewer`): `omniroute/combo-reason-architect` (Security, architecture & standards compliance, read-only).
- **`debug`** (`/agent debug`): `omniroute/combo-code-heavy` (Log parsing, stack tracing, error resolution).
- **`deep-debugger`** (`/agent deep-debugger`): `omniroute/combo-reason-architect` (Deep root-cause analysis).
- **`explore`** (`/agent explore`): `omniroute/combo-free-overflow` (Fast zero-cost repository exploration, read-only).
- **`test`** (`/agent test`): `omniroute/mistral/codestral-latest` (Pest v3, pytest, test suite execution).
- **`devops`** (`/agent devops`): `omniroute/combo-fast-chat` (Systemd, Docker, journalctl, network & package management).
- **`docs`** (`/agent docs`): `omniroute/combo-fast-chat` (Documentation, changelogs, docstrings, README drafting).
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
- `/audit-codebase`: Exhaustive architectural, security, and quality audit.
- `/explore`: Quick workspace exploration with free models.
- `/deep-debug`: Root cause debugging with architectural reasoning.
- `/docs`: Write/update documentation.
