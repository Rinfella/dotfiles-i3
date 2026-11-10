---
description: Query real-time library documentation and API usage via Context7 and Firecrawl.
agent: docs
---

# Real-Time Web & Framework Documentation Lookup

Query up-to-date documentation for: `$ARGUMENTS`

## Execution Steps:
1. **Context7 First**: If `$ARGUMENTS` references a recognized developer library (e.g. React, Next.js, FastAPI, Laravel, Pydantic, Vue, Tailwind, Bun), call Context7 tools (`resolve-library-id`, `get-library-docs`) to retrieve official, version-accurate documentation.
2. **Firecrawl / OmniRoute Web Search Fallback**: If Context7 doesn't cover the topic, call `omniroute_web_search` or `firecrawl_search` to query official documentation sites and GitHub releases.
3. **Synthesize & Provide Snippets**:
   - Provide the exact method signature, configuration options, or minimal reproducible snippet.
   - Note any breaking changes or deprecations in the latest versions.
