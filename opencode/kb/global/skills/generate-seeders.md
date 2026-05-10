---
description: Generates Laravel Factories with relational dummy data
---

Read migration files and Models to understand the schema and relationships.

## Task:
Generate Laravel Factories and update `DatabaseSeeder` for realistic relational data.

## Rules:
1. **No Dangling Data:** All related records must be connected.
2. **Use Modern Laravel:** Use `recycle()` or relationship methods (`->hasPayments(3)`).
3. **Realistic Data:** Use Faker for contextually accurate data.
4. **Idempotent:** Safe to run multiple times without constraint errors.

## Output:
- Factory files for all involved models
- Updated `database/seeders/DatabaseSeeder.php`