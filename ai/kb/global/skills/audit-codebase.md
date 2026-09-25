---
description: Performs an exhaustive, intelligent architectural and security audit of the codebase
---

# Deep Codebase Architectural & Security Audit

Inspect the target directory `$ARGUMENTS` (default to current directory if not specified). Run an intelligent, thorough, and highly critical audit of the project without requiring prior assumptions.

## Phase 1: Tech Stack & Architecture Discovery
1. **Detect Ecosystem & Dependencies:**
   - Scan manifests: `composer.json`, `package.json`, `pyproject.toml`, `requirements.txt`, `go.mod`, `Cargo.toml`.
   - Identify versions, active frameworks (Laravel, FastAPI, React, Vue, Next.js, etc.), and database engines.
2. **Scan Project Documentation:**
   - Read `README.md`, `ARCHITECTURE.md`, `.ai/` knowledge bases, and API specs to understand intended business goals and domain model.
3. **Map High-Level Structure:**
   - Map route registries, controllers/endpoints, data models/migrations, and background jobs.
   - Exclude third-party vendor dirs, build artifacts, lockfiles, and binaries.

## Phase 2: Deep Critical Audit

### 1. Security Posture (Zero Tolerance)
- **Auth & Authorization:** Missing policy checks, tenant leaks in multi-tenant contexts, bypassable middleware.
- **Input Validation & Sanitization:** SQL injection, command injection, unvalidated deserialization, mass assignment, unescaped raw HTML.
- **Secrets & Data Privacy:** Hardcoded tokens, exposed `.env` files, logging sensitive user data/passwords, weak crypto.
- **Network & Headers:** Insecure CORS, missing rate limits, missing CSRF protection on mutation routes.

### 2. Architecture & Code Health
- **Separation of Concerns:** Fat controllers/handlers vs clean action/service layers.
- **Database Hygiene:** N+1 query traps, unindexed foreign keys, lack of transaction blocks around multi-table mutations, risky destructive migration patterns.
- **Error Handling & Resilience:** Empty catch blocks, silent failures, lack of retry/backoff on third-party calls, potential data corruption.
- **Dependencies & Bloat:** Unnecessary external packages when standard library or native framework features suffice (Ponytail principle).

### 3. Idiomatic Standards & Best Practices
- Strict typing, modern language idioms (e.g. PHP 8.4+ property hooks, Python modern type unions & Pydantic v2, TypeScript strict mode).
- Testing coverage gaps: missing tests for core business rules, failure cases, or edge conditions.

---

## Phase 3: Deliverables & Report Format

Present the audit findings strictly structured as follows:

```markdown
# Codebase Audit: [Project / Directory Name]

## 1. Executive Summary & Tech Stack Overview
- **Detected Stack:** [Frameworks, Runtimes, DBs, Key Libraries]
- **Architecture Style:** [e.g. Action-domain, MVC, Hexagonal, Script-based]
- **Overall Health Score:** [A - Critical / B - Fair / C - Needs Refactor / D - High Risk]

## 2. Codebase Strengths (Pros)
- [Well-implemented patterns, clean abstractions, good test coverage, etc.]

## 3. Critical Flaws & Security Risks (Cons)
- **[CRITICAL / HIGH / MEDIUM / LOW] <Issue Title>**
  - **Location:** `path/to/file.ext:line`
  - **Risk:** [What could go wrong: exploit vector, data loss, race condition]
  - **Evidence:** Brief snippet or logical breakdown of the flaw.
  - **Remediation:** Exact fix required.

## 4. Technical Debt & Anti-Patterns to Avoid
- [Things the team is doing wrong that will hurt maintainability, performance, or scaling]

## 5. Prioritized Action Plan
1. **Immediate (Blockers):** [Security fixes, credential exposure, data safety]
2. **Short-Term (High ROI):** [Missing indexes, N+1 query fixes, error handling]
3. **Medium-Term (Refactoring):** [De-bloating, simplifying architecture, filling test gaps]
```
