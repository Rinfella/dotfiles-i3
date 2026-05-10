---
description: Creates a new Laravel migration with proper structure
---

I need a new migration for the database.

## Steps:
1. Ask for the table name and columns.
2. Design the migration following `.ai/rules/01-tall-stack.md`.
3. Use `make:migration` or write manually.
4. Ensure safe column types for MariaDB.

## Constraints:
- Always use `id()` with `$table->id()` for primary key.
- Use `uuid()` or `ulid()` for public identifiers.
- Always include timestamps.
- Add indexes for foreign keys.