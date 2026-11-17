# OmniRoute Integration with OpenCode

## 1. Overview
OmniRoute runs locally as an OpenAI-compatible proxy and intelligent routing gateway on port `20128`.
OpenCode connects to OmniRoute using the `@ai-sdk/openai-compatible` adapter.

- **OmniRoute Base URL**: `http://127.0.0.1:20128/v1`
- **Canonical Env File**: `~/.config/ai/env` (contains `OMNIROUTE_API_KEY`, `FIRECRAWL_API_KEY`, etc.)
- **OpenCode Config**: `~/.config/opencode/opencode.json`
- **Default Coding Model**: `omniroute/combo-code-heavy`
- **Default Small/Helper Model**: `omniroute/combo-fast-chat`
- **Resilience Profile**: `balanced` (fast cooldown recovery, 100 req/min, circuit breaker threshold 5)
- **Automatic Fallback Rules**: Global model pattern matching maps requests (e.g., `claude*`, `gpt-4*`, `deepseek*`) directly to specialized multi-provider combos.

---

## 2. Multi-Provider Scenario Combos

OmniRoute orchestrates resilient model chains across **23 active providers**:
**AGY**, **Mistral**, **NVIDIA (NIM)**, **FastRouter**, **Free-AI**, **OpenRouter**, **TokenHarbor**, **TokenReply**, **MNN AI**, **KiloCode**, **Aion Labs**, **LLM Kiwi**, **Agnes**, **LLM7**, **Void AI**, **Ollama Cloud**, **LiteRouter**, and **Kiro**:

| Combo Name | Strategy | Priority / Distribution Sequence | Description |
| :--- | :--- | :--- | :--- |
| `combo-code-heavy` | **Priority Failover** (15 models) | 1. **AGY Claude Sonnet 4.6** (Dual-account pool)<br>2. **Mistral Codestral Latest** (256k context dedicated coding model, 1.1s)<br>3. **NVIDIA Nemotron 3.5 Super VL 120B** (NIM Ultra High Performance, 1.8s)<br>4. **FastRouter DeepSeek V4.1 Flash** (1.9s fast MoE)<br>5. **Free-AI Qwen 3.6 Coder 35B** (1.6s fast coding)<br>6. **OpenRouter Cohere North Mini Code Free** (1.1s reasoning coder)<br>7. **TokenHarbor DeepSeek V4.1 Flash Free** (2.2s)<br>8. **MNN AI Qwen 3.5 397B A17B** (2.5s heavy MoE)<br>9. **AGY Gemini 3.8 Flash High** (1M context failover)<br>10. **KiloCode Nemotron 3.5 Super VL Free** (1.6s)<br>11. **TokenReply Nemotron 3.5 Lightning Free**<br>12. **Ollama Cloud Gemma 4 31B** (1.8s cloud 31B)<br>13. **LiteRouter DeepSeek V3.2**<br>14. *Kiro Claude Sonnet 4.5 (Quota fallback)*<br>15. *Kiro Qwen 3 Coder Next (Quota fallback)* | Primary coding combo for dev & execution workloads. Context-safe 1M token ceiling prevents truncation during codebase analysis. If AGY is on cooldown or quota-exhausted, instantly cascades down through top free coding models without user intervention. |
| `combo-reason-architect` | **Priority Failover** (16 models) | 1. **AGY Claude Opus 4.6 Thinking** (Deepest architectural reasoning, dual-account pool)<br>2. **AGY Claude Sonnet 4.6** (Deep coding intelligence)<br>3. **NVIDIA Nemotron 3.5 Super VL 120B** (120B reasoning model, 1.8s)<br>4. **FastRouter DeepSeek V4.1 Flash** (Fast reasoning MoE, 1.9s)<br>5. **AGY Gemini 3.8 Flash High** (1M context reasoning)<br>6. **OpenRouter Nemotron 3.5 Lightning Free** (2.2s fast reasoning)<br>7. **Free-AI Qwen 3.6 Coder 35B** (Reasoning coder)<br>8. **TokenHarbor DeepSeek V4.1 Flash Free**<br>9. **Mistral Codestral** (256k context)<br>10. **OpenRouter Cohere North Mini Code Free**<br>11. **MNN AI Gemini 3.1 Flash Lite**<br>12. **Aion Labs Aion 3.0** (3.1s)<br>13. **LLM Kiwi Auto** (4.1s)<br>14. **KiloCode Auto Free Tier** (1.8s)<br>15. **LiteRouter DeepSeek V3.2**<br>16. *Kiro Claude Sonnet 4.5 (Quota fallback)* | Deep reasoning and planning combo for `/agent plan`, `@deep-debugger`, and `/review`. Gracefully degrades across 16 reasoning models. |
| `combo-fast-chat` | **Round-Robin** (15 models) | • **Free-AI Qwen 3.6 35B** (1.1s)<br>• **Mistral Codestral** (1.1s)<br>• **OpenRouter Dots 3 Note Free** (1.2s)<br>• **TokenReply Beam Free** (2.0s)<br>• **NVIDIA Nemotron 3.5 Super VL 120B** (1.8s)<br>• **MNN AI GPT 4.1 Mini** (2.3s)<br>• **MNN AI Gemini 3.1 Flash Lite** (2.7s)<br>• **TokenHarbor DeepSeek V4.1 Flash Free** (2.2s)<br>• **OpenRouter Free Auto** (1.8s)<br>• **KiloCode Auto Free Tier** (1.8s)<br>• **AGY Gemini 3.5 Flash Lite** (2.1s)<br>• **AGY Gemini 3.8 Flash Low**<br>• **Aion Labs Aion 3.0** (3.1s)<br>• **Agnes 2.5 Flash** (4.9s)<br>• **Ollama Cloud Gemma 4 31B** (1.8s) | High-speed, low-latency conversational round-robin pool across 100% free models. Used by `@devops`, `@docs`, and small helper tasks. |
| `combo-free-overflow` | **Round-Robin** (22 models) | • **Mistral Codestral** (1.1s)<br>• **Free-AI Qwen 3.6 Coder 35B** (1.6s)<br>• **Free-AI Qwen 7B** (1.1s)<br>• **NVIDIA Nemotron 3.5 Super VL 120B** (1.8s)<br>• **FastRouter DeepSeek V4.1 Flash** (1.9s)<br>• **OpenRouter Cohere North Mini Code Free** (1.1s)<br>• **OpenRouter Nemotron 3.5 Lightning Free** (2.2s)<br>• **OpenRouter Free Auto** (1.8s)<br>• **TokenHarbor DeepSeek V4.1 Flash Free** (2.2s)<br>• **TokenReply Beam Free** (2.0s)<br>• **TokenReply Nemotron 3.5 Lightning Free** (4.4s)<br>• **MNN AI GPT 4.1 Mini** (2.3s)<br>• **MNN AI Gemini 3.1 Flash Lite** (2.7s)<br>• **KiloCode Nemotron 3.5 Super VL Free** (1.6s)<br>• **KiloCode Auto Free Tier** (1.8s)<br>• **Aion Labs Aion 3.0** (3.1s)<br>• **LLM Kiwi Auto** (4.1s)<br>• **Agnes 2.5 Flash** (4.9s)<br>• **LLM7 DeepSeek V4.1 Flash** (4.4s)<br>• **Ollama Cloud Gemma 4 31B** (1.8s)<br>• **LiteRouter DeepSeek V3.2** (4.8s)<br>• **AGY Gemini 3.5 Flash Lite** (2.1s) | Zero-cost multi-provider fallback and overflow pool used by `@explore` across 14 connected free providers. |

---

## 3. Direct Individual Model Selection (`/model`)

All individual provider models can be selected directly in OpenCode:

### NVIDIA (NIM)
- `/model omniroute/nvidia/nvidia/nemotron-3.5-super-vl-120b-a12b` (Nemotron 3.5 Super VL 120B - Ultra High Performance)

### FastRouter
- `/model omniroute/fastrouter/deepseek/deepseek-v4.1-flash` (DeepSeek V4.1 Flash - 1.9s)
- `/model omniroute/fastrouter/fastrouter/auto` (FastRouter Auto Free)
- `/model omniroute/fastrouter/Qwen/Qwen2.5-72B-Instruct` (Qwen 2.5 72B)

### TokenHarbor
- `/model omniroute/tokenharbor/deepseek-v4.1-flash:free` (DeepSeek V4.1 Flash Free - 2.2s)
- `/model omniroute/tokenharbor/mimo-v2.6-flash:free` (Xiaomi MiMo V2.6 Flash Free)

### TokenReply
- `/model omniroute/tokenreply/beam-free` (Beam Free - 2.0s Ultrafast)
- `/model omniroute/tokenreply/nemotron-3.5-lightning-free` (Nemotron 3.5 Lightning Free)
- `/model omniroute/tokenreply/deepseek-v4.1-flash` (DeepSeek V4.1 Flash)

### MNN AI
- `/model omniroute/mnn-ai/gemini-3.1-flash-lite` (Gemini 3.1 Flash Lite - 2.7s)
- `/model omniroute/mnn-ai/gpt-4.1-mini` (GPT-4.1 Mini - 2.3s)
- `/model omniroute/mnn-ai/qwen-3.5-397b-a17b` (Qwen 3.5 397B MoE Heavyweight)
- `/model omniroute/mnn-ai/nemotron-3.5-lightning` (Nemotron 3.5 Lightning)

### Free-AI
- `/model omniroute/free-ai/qwen-coder` (Qwen 3.6 Coder 35B - 1.6s)
- `/model omniroute/free-ai/qwen3-coder` (Qwen 3 Coder - 2.1s)
- `/model omniroute/free-ai/qwen7b` (Qwen 3.6 35B Fast - 1.1s)

### Aion Labs
- `/model omniroute/aion/aion-labs/aion-3.0` (Aion 3.0 - 3.1s)
- `/model omniroute/aion/aion-labs/aion-3.0-mini` (Aion 3.0 Mini)

### Agnes
- `/model omniroute/agnes/agnes-2.5-flash` (Agnes 2.5 Flash - 4.9s)

### LLM Kiwi
- `/model omniroute/llm-kiwi/auto` (LLM Kiwi Auto Free - 4.1s)
- `/model omniroute/llm-kiwi/minimax-m2.5` (MiniMax M2.5)

### LLM7
- `/model omniroute/llm7/deepseek-v4.1-flash` (DeepSeek V4.1 Flash - 4.4s)
- `/model omniroute/llm7/gemini-3.8-flash-high` (Gemini 3.8 Flash High)

### Void AI
- `/model omniroute/void-ai/deepseek-v4.1-flash` (DeepSeek V4.1 Flash)
- `/model omniroute/void-ai/qwen3-coder-480b-a35b-instruct` (Qwen 3 Coder 480B)
- `/model omniroute/void-ai/sonar` (Perplexity Sonar Web Search)

### Mistral
- `/model omniroute/mistral/codestral-latest` (Codestral Latest - 256k Context, 1.1s)
- `/model omniroute/mistral/mistral-medium-3-5` (Mistral Medium 3.5)
- `/model omniroute/mistral/mistral-small-latest` (Mistral Small Latest)

### KiloCode
- `/model omniroute/kilocode/kilo-auto/free` (KiloCode Auto Free Tier - 1.8s)
- `/model omniroute/kilocode/nvidia/nemotron-3.5-super-vl:free` (Nemotron 3.5 Super VL - 1.6s)

### Ollama Cloud
- `/model omniroute/ollama-cloud/gemma4:31b` (Gemma 4 31B Instruct - 1.8s)
- `/model omniroute/ollama-cloud/kimi-k2.6` (Kimi K2.6)
- `/model omniroute/ollama-cloud/nemotron-3-super` (Nemotron 3 Super)

### OpenRouter Free
- `/model omniroute/openrouter/openrouter/free` (Auto-routing Free Tier - 1.8s)
- `/model omniroute/openrouter/cohere/north-mini-code:free` (Reasoning Code - 1.1s)
- `/model omniroute/openrouter/nvidia/nemotron-3.5-lightning:free` (Fast Reasoning - 2.2s)
- `/model omniroute/openrouter/dots-studio/dots-3-note-preview:free` (Fast Chat - 1.2s)
- `/model omniroute/openrouter/baidu/ernie-5.5-flash-preview:free` (ERNIE 5.5 Flash Free)
- `/model omniroute/openrouter/nvidia/nemotron-3-ultra-550b-a55b:free` (Nemotron 3 Ultra 550B Free)
- `/model omniroute/openrouter/liquid/lfm-3-1.7b:free` (Liquid LFM 3 1.7B Free)

### LiteRouter
- `/model omniroute/literouter/deepseek-v3.2` (DeepSeek V3.2 - 4.8s)

### Antigravity (AGY - Dual Account Load-Balanced Pool)
- `/model omniroute/agy/claude-sonnet-4-6` (Anthropic Claude Sonnet 4.6)
- `/model omniroute/agy/claude-opus-4-6-thinking` (Claude Opus 4.6 Thinking)
- `/model omniroute/agy/gemini-3.8-flash-high` (1M Context)
- `/model omniroute/agy/gemini-3.8-flash-medium` (1M Context)
- `/model omniroute/agy/gemini-3.8-flash-low` (1M Context)
- `/model omniroute/agy/gemini-3.8-flash-tiered` (1M Context)
- `/model omniroute/agy/gemini-3.5-flash-lite` (Ultra Fast 1M Context, 2.1s)
- `/model omniroute/agy/gemini-3.1-flash-lite` (Gemini 3.1 Flash Lite)
- `/model omniroute/agy/gemini-3-flash` (Fast 1M Context)
- `/model omniroute/agy/gpt-oss-120b-medium` (GPT-OSS 120B Medium)

### Kiro (AWS Builders Tier — Quota Resets Monthly on 1st)
- `/model omniroute/kiro/claude-sonnet-4.5`
- `/model omniroute/kiro/claude-haiku-4.5`
- `/model omniroute/kiro/qwen3-coder-next`
- `/model omniroute/kiro/deepseek-3.2`
- `/model omniroute/kiro/glm-5`
- `/model omniroute/kiro/minimax-m2.1`
- `/model omniroute/kiro/minimax-m2.5`

---

## 4. Specialized Agents

OpenCode subagents mapped to optimal models:
- **`plan`** (`/agent plan`): `omniroute/combo-reason-architect` (Deep planning & system design, read-only).
- **`code-reviewer`** (`/agent code-reviewer`): `omniroute/combo-reason-architect` (Security, architecture & standards compliance, read-only).
- **`debug`** (`/agent debug`): `omniroute/combo-code-heavy` (Log parsing, stack tracing, error resolution).
- **`deep-debugger`** (`/agent deep-debugger`): `omniroute/combo-reason-architect` (Deep root-cause analysis).
- **`explore`** (`/agent explore`): `omniroute/combo-free-overflow` (Fast zero-cost repository exploration, read-only).
- **`test`** (`/agent test`): `omniroute/mistral/codestral-latest` (Pest v3, pytest, test suite execution, 1.1s latency).
- **`devops`** (`/agent devops`): `omniroute/combo-fast-chat` (Systemd, Docker, journalctl, network & package management).
- **`docs`** (`/agent docs`): `omniroute/combo-fast-chat` (Documentation, changelogs, docstrings, README drafting).
- **`fastapi`** (`/agent fastapi`): `omniroute/combo-code-heavy` (FastAPI 0.115+, Pydantic v2 schemas, async routes).
- **`refactor`** (`/agent refactor`): `omniroute/combo-code-heavy` (Ponytail lazy dev code simplification and dead code cleanup).

---

## 5. Global Model-to-Combo Auto-Routing Mappings

OmniRoute now includes glob pattern matching rules so external clients requesting standard model names automatically resolve to the optimal fault-tolerant combos:

| Incoming Model Pattern | Priority | Target Combo | Description |
| :--- | :--- | :--- | :--- |
| `claude*sonnet*` | 100 | `combo-code-heavy` | Any Claude Sonnet request routes through full code-heavy failover chain |
| `claude*opus*` | 100 | `combo-reason-architect` | Any Claude Opus request routes through deep reasoning chain |
| `claude*haiku*` | 100 | `combo-fast-chat` | Any Claude Haiku request routes through fast 100% free chat round-robin |
| `gpt-4*` | 90 | `combo-code-heavy` | GPT-4 variants route to code-heavy combo |
| `gpt-5*` | 90 | `combo-reason-architect` | GPT-5 variants route to reason-architect combo |
| `o1*`, `o3*` | 90 | `combo-reason-architect` | OpenAI reasoning models route to reason-architect combo |
| `deepseek*` | 80 | `combo-code-heavy` | DeepSeek queries route to code-heavy combo |
| `qwen*` | 80 | `combo-code-heavy` | Qwen queries route to code-heavy combo |

---

## 6. Workflow Commands (Slash Commands)

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
- `/health`: Audit health and active connections across all 23 OmniRoute providers.
- `/combos`: Inspect all active combos, model chains, and failover topologies.
- `/speed`: Rank fastest reliable providers from live telemetry.
