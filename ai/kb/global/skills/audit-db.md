---
description: Audits database schema for performance and best practices
---

Read migration files and Models in the current project.

## Identify:
1. Missing indexes on foreign keys or searched columns.
2. N+1 query traps in Model relationships.
3. Poorly normalized tables or redundant data.
4. Mismatching database and codebase structure.

## Output:
- Report of issues found
- Safe migration commands to fix each issue
- DO NOT modify existing migrations.