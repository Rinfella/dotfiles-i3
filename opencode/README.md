# OpenCode Knowledge Base - Complete Cheatsheet

> Your personal AI coding assistant configuration for Laravel + Filament development.
> Edit this file to add your own notes, workflows, and customize to your needs.

---

## Table of Contents

1. [Directory Structure](#directory-structure)
2. [Quick Start](#quick-start)
3. [Custom Commands](#custom-commands)
4. [MCP Servers](#mcp-servers)
5. [Skills Reference](#skills-reference)
6. [Rules Reference](#rules-reference)
7. [OpenCode CLI](#opencode-cli)
8. [Configuration](#configuration)
9. [Troubleshooting](#troubleshooting)
10. [Examples](#examples)
11. [Quick Reference](#quick-reference)

---

## Directory Structure

```
~/.config/opencode/
├── opencode.json              # Global OpenCode config
├── README.md         # This cheatsheet
└── kb/                    # Knowledge Base
    ├── global/              # Rules & skills (all projects)
    │   ├── rules/           # Agent directives
    │   │   ├── 00-global-directives.md
    │   │   ├── 01-tall-stack.md
    │   │   ├── 02-infrastructure.md
    │   │   └── 03-cicd.md
    │   └── skills/          # 12 skills
    │       ├── make-filament-feature.md
    │       ├── make-migration.md
    │       ├── make-service.md
    │       ├── make-observer.md
    │       ├── make-policy.md
    │       ├── make-job.md
    │       ├── generate-seeders.md
    │       ├── audit-db.md
    │       ├── debug-laravel.md
    │       ├── write-tests.md
    │       ├── run-tests.md
    │       └── document-api.md
    └── project/             # Templates (copied per project)
        ├── context/
        │   ├── architecture.md
        │   └── active-task.md
        ├── plans/
        │   └── database-design-template.md
        ├── rules/
        └── skills/
```

---

## Quick Start

### Initialize a New Project

```bash
# 1. Navigate to project
cd /path/to/laravel-project

# 2. Start OpenCode
opencode

# 3. Initialize workspace
/init-workspace
```

This creates:
```
project/
├── .ai/                    # Shared knowledge base (ALL agents)
│   ├── rules/               # Copied from kb/global/rules/
│   ├── skills/             # Copied from kb/global/skills/
│   ├── context/             # Copied from kb/project/context/
│   └── plans/              # Copied from kb/project/plans/
├── .opencode.json           # OpenCode config (references .ai/)
├── .opencode.local.json     # Project MCPs (git, mariadb)
└── .gitignore updated      # .ai, .opencode*.json added
```

### Run OpenCode

```bash
# Basic
opencode

# In specific directory
opencode /path/to/project

# Debug config
opencode debug config

# Check version
opencode --version
```

---

## Custom Commands

### Available Commands (10)

| Command | Description | Usage Example |
|---------|-------------|--------------|
| `/filament` | Scaffold Model + Migration + Filament Resource + Tests | `/filament` then describe your entity |
| `/seed` | Generate Factories with relational data | `/seed` then specify counts |
| `/debug` | Debug Laravel errors from logs | `/debug` |
| `/audit-db` | Audit database schema | `/audit-db` |
| `/test` | Run test suite with coverage | `/test` |
| `/make-migration` | Create safe migration | `/make-migration` |
| `/make-service` | Create Service class | `/make-service` |
| `/make-observer` | Create Eloquent Observer | `/make-observer` |
| `/make-policy` | Create Authorization Policy | `/make-policy` |
| `/make-job` | Create Job class | `/make-job` |

### Using Commands

```bash
opencode
/filament
> Create a User model with name, email, role fields
> Include Filament resource with table and form
> Add validation rules
```

### Command Syntax

Commands are defined in `opencode.json`:

```jsonc
"command": {
  "filament": {
    "template": "Create a new Filament feature: Model, Migration, Resource, Tests...",
    "description": "Scaffold Filament resource",
    "agent": "build"
  }
}
```

---

## MCP Servers

### Global MCPs (in ~/.config/opencode/opencode.json)

| Server | Package | Purpose | Command |
|--------|---------|---------|--------|
| `sequential-thinking` | `@modelcontextprotocol/server-sequential-thinking` | Chain-of-thought reasoning | `npx -y @modelcontextprotocol/server-sequential-thinking` |
| `puppeteer` | `@modelcontextprotocol/server-puppeteer` | Browser automation | `npx -y @modelcontextprotocol/server-puppeteer` |
| `fetch` | `mcp-server-fetch` | Web fetching | `uvx mcp-server-fetch` |
| `memory` | `@modelcontextprotocol/server-memory` | Persistent memory | `npx -y @modelcontextprotocol/server-memory` |

### Project MCPs (in .opencode.local.json)

| Server | Package | Purpose | Note |
|--------|---------|---------|------|
| `mariadb-local` | `@modelcontextprotocol/server-mysql` | MySQL/MariaDB access | Requires DB connection string |
| `git` | `mcp-server-git` | Git operations | Requires repository path |

### Adding Project MCPs

Edit `.opencode.local.json`:

```json
{
  "mcp": {
    "mariadb-local": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-mysql", "mysql://root:password@localhost:3306/mydb"]
    }
  }
}
```

---

## Skills Reference

### Overview

Skills are located in `~/.config/opencode/kb/global/skills/`. Each skill is a markdown file with:
- Frontmatter with description
- Steps to execute
- Constraints/rules

### Scaffolding Skills (6)

#### make-filament-feature.md
- Creates: Model + Migration + Filament Resource + Tests
- Use when: Building new entity with admin panel
- Steps: Propose DB schema → Create Model → Migration → Resource → Tests

#### make-migration.md
- Creates: Database migration
- Use when: Adding/modifying tables
- Steps: Ask for table/columns → Generate migration

#### make-service.md
- Creates: Service class in app/Services/
- Use when: Business logic needs encapsulation
- Steps: Ask for purpose → Create with constructor injection

#### make-observer.md
- Creates: Eloquent Observer
- Use when: Reacting to model events (created, updated, deleted)
- Steps: Ask for model → Create observer → Register

#### make-policy.md
- Creates: Authorization Policy
- Use when: Restricting access to resources
- Steps: Ask for model → Define methods → Register

#### make-job.md
- Creates: Job class (queued or sync)
- Use when: Background processing
- Steps: Ask for purpose → Create job → Add middleware

### Data Skills (2)

#### generate-seeders.md
- Creates: Factories + DatabaseSeeder
- Use when: Need realistic test data
- Rules: No dangling data, use Faker, idempotent

#### audit-db.md
- Analyzes: Migration files + Models
- Checks: Missing indexes, N+1 queries, normalization
- Output: Safe migration commands (never modifies existing)

### Development Skills (4)

#### debug-laravel.md
- Reads: storage/logs/laravel.log
- Steps: Analyze stack trace → Identify root cause → Fix

#### write-tests.md
- Creates: Pest/PHPUnit tests
- Coverage: Success, failure, edge cases

#### run-tests.md
- Runs: Test suite with coverage
- Shows: Failures first, suggest fixes

#### document-api.md
- Creates: API documentation
- Format: Markdown or OpenAPI YAML

---

## Rules Reference

### 00-global-directives.md

Core workflow rules:
- **Proactive state management**: Update `.ai/` files after major tasks
- **Planning protocol**: Read before coding, clarify requirements, database-first design
- **Safety first**: No destructive commands without permission
- **Testing mandate**: Write tests for all features
- **Deployment agnostic**: Keep code modular

### 01-tall-stack.md

Laravel + Filament standards:

**Safety**
- NEVER run `php artisan migrate:fresh` or `migrate:reset`
- Only standard migrations to alter tables

**Coding Standards**
- PSR-12 conventions
- `declare(strict_types=1);` in ALL PHP files
- Typed class constants, readonly properties
- Fat Models, Skinny Controllers

**Filament UI**
- Always use `--view` flag
- Chain validation: `->required()->maxLength(255)`
- Use `Section::make()`
- Primary columns: `searchable()->sortable()`
- Secondary: `toggleable(isToggledHiddenByDefault: true)`

**Database (MariaDB)**
- Assume MariaDB unless told otherwise
- Use MariaDB's native JSON functions
- Use dedicated test DB, not production

**Testing**
- Pest or PHPUnit
- Test success, failure, edge cases
- Tests pass = feature complete

### 02-infrastructure.md

AWS/GCP/DevOps guidelines:
- Use IAM roles, not access keys
- Infrastructure as code (Terraform/CDK)
- Managed databases with auto backups
- Encryption at rest and in transit
- VPC/private subnets
- Structured logging (JSON)

### 03-cicd.md

CI/CD practices:
- GitHub Actions: test on PR/push
- Lint before tests
- Quality gates: test + lint passing
- Migrations in CI: backup before prod

---

## OpenCode CLI

### Basic Commands

```bash
# Start OpenCode
opencode

# With specific project
opencode /path/to/project

# Debug config issues
opencode debug config

# Update OpenCode
opencode update

# Check version
opencode --version
```

### In-Session Commands

| Command | Action |
|---------|--------|
| `/init` | Initialize project (create AGENTS.md) |
| `/init-workspace` | Setup .ai/ knowledge base |
| `/share` | Share conversation link |
| `/undo` | Undo last change |
| `/redo` | Redo undone change |
| `/models` | List/select models |
| `/connect` | Connect LLM provider |
| `/help` | Show help |

### Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Tab` | Toggle Plan/Build mode |
| `@` | Fuzzy search files |
| `Ctrl+K` | Search |
| `Ctrl+C` | Cancel current |
| `Ctrl+L` | Clear |

### Plan Mode

Press `Tab` to toggle:
- **Plan mode**: Agent suggests approach, no changes made
- **Build mode**: Agent makes changes

Switch to Plan mode before complex tasks to review the plan first.

---

## Configuration

### Config Locations

| Scope | Path |
|-------|------|
| Global | `~/.config/opencode/opencode.json` |
| Project | `./.opencode.json` |
| Project MCPs | `./.opencode.local.json` |

### Config Schema

```jsonc
{
  "$schema": "https://opencode.ai/config.json",
  
  // Model (Gemini, Claude, etc.)
  "model": "gemini/gemini-2.5-pro",
  
  // Instructions (rules to follow)
  "instructions": [
    "~/.config/opencode/kb/global/rules/00-global-directives.md",
    "~/.config/opencode/kb/global/rules/01-tall-stack.md"
  ],
  
  // MCP servers
  "mcp": {
    "sequential-thinking": {
      "type": "local",
      "command": ["npx", "-y", "@modelcontextprotocol/server-sequential-thinking"]
    }
  },
  
  // Custom commands
  "command": {
    "filament": {
      "template": "...",
      "description": "...",
      "agent": "build"
    }
  },
  
  // Code formatters
  "formatter": {
    "php-cs-fixer": {
      "command": ["vendor/bin/php-cs-fixer", "fix", "$FILE"],
      "extensions": [".php"]
    }
  }
}
```

### Environment Variables

```bash
# Custom config path
OPENCODE_CONFIG=/path/to/config.json

# Custom config directory  
OPENCODE_CONFIG_DIR=/path/to/directory

# TUI config
OPENCODE_TUI_CONFIG=/path/to/tui.json
```

---

## Troubleshooting

### MCP Server Not Starting

```bash
# Test manually
npx -y @modelcontextprotocol/server-sequential-thinking
uvx mcp-server-fetch

# Check config
opencode debug config

# View logs
# MCP output in OpenCode terminal
```

### Knowledge Base Not Loading

```bash
# Verify files exist
ls -la ~/.config/opencode/kb/global/rules/
ls -la ~/.config/opencode/kb/global/skills/

# Check in project
ls -la .ai/rules/
```

### Model Not Working

```bash
# Select different model
/models

# Check API key
/connect

# Update config
/opencode.json → model key
```

### Permission Issues

```bash
# Check config permissions
ls -la ~/.config/opencode/opencode.json

# Fix if needed
chmod 644 ~/.config/opencode/opencode.json
```

---

## Examples

### 1. Create Filament Resource

```bash
opencode
/filament
> I need a Product model with:
> - name (string, required)
> - price (decimal, required)
> - description (text, nullable)
> - category_id (foreign key)
> - is_active (boolean, default true)
> Include Filament resource with table and form
```

### 2. Generate Seed Data

```bash
opencode
/seed
> Generate:
> - 10 users (with varied roles)
> - 50 products
> - 5 categories
> Use realistic data with Faker
```

### 3. Debug Error

```bash
opencode
/debug
> Read storage/logs/laravel.log
> Find the error that happened at 3pm
> Fix it following our TALL stack rules
```

### 4. Run Tests

```bash
opencode
/test
> Run full test suite
> Show coverage report
> Show failures first
```

### 5. Audit Database

```bash
opencode
/audit-db
> Check for missing indexes on foreign keys
> Check for potential N+1 queries
> Check normalization
```

---

## Quick Reference

```
╔═══════════════════════════════════════════════════════════╗
║            OPENCODE QUICK REFERENCE                    ║
╠═══════════════════════════════════════════════════════════╣
║  START          │  opencode                             ║
║  SETUP          │  /init-workspace                     ║
║  NEW FEATURE    │  /filament                            ║
║  SEED DATA      │  /seed                               ║
║  DEBUG         │  /debug                              ║
║  AUDIT DB       │  /audit-db                           ║
║  TESTS         │  /test                               ║
║  PLAN/_BUILD   │  Tab key                             ║
║  UNDO          │  /undo                               ║
║  REDO          │  /redo                               ║
╠═══════════════════════════════════════════════════════════╣
║  FILE SEARCH   │  @filename                           ║
║  HELP         │  /help                               ║
║  MODELS       │  /models                            ║
║  CONNECT     │  /connect                           ║
╚═══════════════════════════════════════════════════════════╝
```

---

## File Locations Summary

| Purpose | Path |
|---------|------|
| Global config | `~/.config/opencode/opencode.json` |
| Global KB rules | `~/.config/opencode/kb/global/rules/` |
| Global KB skills | `~/.config/opencode/kb/global/skills/` |
| Project KB | `./.ai/` |
| Project config | `./.opencode.json` |
| Project MCPs | `./.opencode.local.json` |
| Auth data | `~/.local/share/opencode/auth.json` |
| This cheatsheet | `~/.config/opencode/KB_ARCHITECTURE.md` |

---

## Additional Resources

- [OpenCode Docs](https://opencode.ai/docs)
- [OpenCode GitHub](https://github.com/anomalyco/opencode)
- [MCP Servers](https://github.com/modelcontextprotocol/servers)
- [Model Context Protocol](https://modelcontextprotocol.io)

---

*Last updated: May 2026*
*Edit this file at `~/.config/opencode/KB_ARCHITECTURE.md`*
