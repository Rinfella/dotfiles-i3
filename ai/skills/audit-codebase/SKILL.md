---
name: audit-codebase
description: "Exhaustive codebase architectural, security, and quality audit with automatic tech stack detection."
---

# Deep Codebase Architectural & Security Audit

Use this skill when auditing any repository or directory without prior context. The audit is designed to act as an objective, strict critic evaluating security posture, architectural patterns, database health, and technical debt.

## Audit Workflow

### 1. Tech Stack Detection
- Scan package manifests: `composer.json`, `package.json`, `pyproject.toml`, `requirements.txt`, `go.mod`, `Cargo.toml`.
- Identify language runtime versions, frameworks (Laravel, FastAPI, Express, React, Vue, Next.js, etc.), and database engines.
- Inspect `README.md`, `ARCHITECTURE.md`, and configuration files to extract domain context and intended business logic.

### 2. Deep Security Inspection
- **Authentication & Authorization**: Verify middleware enforcement, RBAC/policy checks, tenant isolation, and session handling.
- **Input Validation**: Check for SQL injection, command execution, unsafe deserialization, mass assignment vulnerabilities, and SSRF.
- **Secrets Management**: Detect hardcoded API keys, exposed `.env` files, unhashed passwords, and insecure token storage.
- **Network & Headers**: Audit CORS configurations, CSRF protection on state-modifying requests, and rate-limiting enforcement.

### 3. Architecture & Code Health
- **Separation of Concerns**: Audit controller bloat, service boundaries, and adherence to clean architectural patterns.
- **Database Hygiene**: Identify N+1 queries, unindexed foreign keys, missing transaction boundaries, and destructive migration risks.
- **Error Handling**: Detect silent exception swallowing, empty catch blocks, lack of retries on network calls, and potential data corruption.
- **Dependency Bloat**: Flag redundant dependencies that could be replaced by native platform/standard library features (Ponytail principle).

### 4. Deliverable Format
Deliver a structured Markdown audit report:
- **1. Executive Summary & Stack Overview**: Detected components and overall health rating (A to D).
- **2. Codebase Strengths (Pros)**: Well-architected modules and clean patterns.
- **3. Critical Flaws & Vulnerabilities (Cons)**: Ranked by severity (Critical / High / Medium / Low) with exact file:line references, impact, and remediation steps.
- **4. Prioritized Action Plan**: Immediate fixes vs mid-term refactoring items.
