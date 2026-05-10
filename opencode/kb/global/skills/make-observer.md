---
description: Creates a new Eloquent Observer following Laravel conventions
---

I need a new Observer for a model.

## Steps:
1. Ask for the model name.
2. Create in `app/Observers/` with proper naming.
3. Implement event handlers (created, updated, deleted, etc.).
4. Register in a Service Provider.

## Constraints:
- Use strict typing: `declare(strict_types=1);`
- Follow event-driven patterns.
- Keep observers focused on single responsibility.