---
description: Scaffolds a complete Filament Resource (Model, Migration, Resource, Test)
---

I want to create a new Filament feature. Ask me for the entity name and the data fields it needs.

## Steps:
1. Propose database schema in `.ai/plans/active-design.md`. Wait for my approval.
2. Generate the Model with strict typing and `$fillable`.
3. Generate Migration (safe column types, indexes).
4. Generate Filament Resource with `--view` flag, following UI rules in `.ai/rules/01-tall-stack.md`.
5. Write Pest tests (create, validate, view).

## Constraints:
- Use `declare(strict_types=1);` in all PHP files.
- Follow PSR-12.
- Model relationships must prevent N+1 queries.
- UI must use Sections and proper searchable/sortable.