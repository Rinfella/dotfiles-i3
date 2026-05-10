---
description: Creates a Laravel Job class (queued or synchronous)
---

I need a new Job class.

## Steps:
1. Ask for job purpose and if it should be queued.
2. Create in `app/Jobs/` with proper namespace.
3. Implement `handle()` method.
4. Add middleware if needed.

## Constraints:
- Use strict typing.
- Use `Dispatchable` trait.
- For queued jobs, implement `ShouldQueue`.