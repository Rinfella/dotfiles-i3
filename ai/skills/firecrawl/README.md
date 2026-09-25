# Firecrawl Global Skill

This global skill has been configured for the Gemini coding agent.

## Configuration Details
- **Skill Directory**: `/home/rf/.gemini/config/skills/firecrawl/`
- **Main Instruction File**: [SKILL.md](file:///home/rf/.gemini/config/skills/firecrawl/SKILL.md)
- **API Credentials**: Loaded from `/home/rf/.gemini/.env` (using the `FIRECRAWL_API_KEY` key).

## Description
Firecrawl gives AI agents fast, reliable web context with search, scraping, and interaction tools. The skill teaches the agent:
1. **CLI Tools/Skills** (`firecrawl/cli`) for executing commands during the active session.
2. **Build Skills** (`firecrawl/skills`) for integrating Firecrawl API/SDK calls inside product code.
3. **Workflow Skills** (`firecrawl/firecrawl-workflows`) for generating finished web-data deliverables.

## How to Install the CLI Tools (Human Action)
If you want to use the live CLI tools or workflow automation tools in this workspace, run:
```bash
npx -y firecrawl-cli@latest init --all --browser
```
