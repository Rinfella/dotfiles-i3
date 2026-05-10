# Database Design Proposal

*Agent: Duplicate to `.ai/plans/active-design.md` when planning new features.*

## Feature Overview
(Brief description of what we're building)

## Proposed Tables
**Table:** `example_table`
- `id` (ulid/uuid) - Primary key
- `name` (string) - Description
- ...

## Relationships
- 1:1, 1:N, M:N relationships
- Cascade behaviors

## Performance
- Potential N+1 queries and prevention
- Required indexes