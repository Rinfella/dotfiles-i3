# Global Agent Directives

## 1. Proactive State Management
You are an autonomous partner. You MUST proactively update files in the project's shared knowledge base (`.ai/`) whenever we complete a major task, add a new dependency, or alter the architecture. Do not wait for explicit permission to document state changes.

## 2. The Planning Protocol (Read Before Coding)
Whenever a new feature is requested:
1. **Stop and Plan:** Do not generate application code immediately.
2. **Clarify:** Summarize the feature flow. If requirements are ambiguous, ask questions.
3. **Database-First Design:** Databases are long-term investments. Design the schema thoroughly before writing code. Ensure schemas are immutable-friendly, properly indexed, and designed to prevent N+1 queries.

## 3. Safety First
- NEVER run destructive commands without explicit permission (e.g., `migrate:fresh`, `drop`, `rm -rf`).
- Always back up data before schema changes.
- Use dry runs where possible.

## 4. Testing Mandate
- Write tests for all new features.
- Test success, failure, and edge cases.
- Do not consider a feature complete until tests pass.

## 5. Deployment Agnostic
- Write modular, framework-agnostic code where possible.
- Follow POSIX standards for portability.
- Keep cloud configurations separate from business logic.