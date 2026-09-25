# Python FastAPI & Modern Backend Guidelines

## 1. Runtime & Python Standards (Python 3.12+ / FastAPI 0.115+)
- Use modern Python type hints (`str | None`, `list[int]`, `dict[str, Any]`, `Self`, `TypeVar`).
- Prefer standard library features over external helper libraries where possible.
- Formatting & linting: follow PEP 8 and use Ruff for ultra-fast linting and formatting.

## 2. Pydantic v2 Patterns
- Inherit from `pydantic.BaseModel` with strict typing.
- Always use Pydantic v2 decorators:
  - `@field_validator("field_name", mode="after")`
  - `@model_validator(mode="after")`
  - `@computed_field` for dynamic model properties.
- Use `Field(..., description="...", ge=0)` for validation boundaries.
- Separate Schemas cleanly:
  - `CreateSchema` (input payload)
  - `UpdateSchema` (optional input fields with `None = None`)
  - `ReadSchema` (response model with `model_config = ConfigDict(from_attributes=True)`)

## 3. Dependency Injection & Routing
- Use `Annotated` pattern for all dependencies:
  - `DbSession = Annotated[AsyncSession, Depends(get_db)]`
  - `CurrentUser = Annotated[User, Depends(get_current_active_user)]`
- Structure endpoints modularly with `APIRouter`:
  - Group by resource (`routers/auth.py`, `routers/users.py`, `routers/items.py`).
  - Set explicit `prefix`, `tags`, and `responses` on routers.
  - Always declare explicit `response_model` or type annotation on path operations.

## 4. Async & Concurrency Best Practices
- Never use blocking synchronous code (e.g. `time.sleep`, standard `requests`, synchronous file I/O) inside `async def` endpoints.
- If synchronous third-party libraries must be called, execute them via `starlette.concurrency.run_in_threadpool` or `asyncio.to_thread`.
- Use the modern `lifespan` context manager on `FastAPI` instance:
  ```python
  @asynccontextmanager
  async def lifespan(app: FastAPI):
      # Startup logic (e.g., DB pool init, cache warm)
      yield
      # Teardown logic (e.g., close DB pool, cleanup)
  ```
- Do not use deprecated `@app.on_event("startup")` or `@app.on_event("shutdown")`.

## 5. Database & Migrations (SQLAlchemy 2.0+ / SQLModel)
- Use 2.0-style queries (`select(Model).where(...)` with `await session.execute(...)`).
- Never perform bulk deletes or drops without explicit approval and safe rollback migrations in Alembic.
- Always handle connection pooling and session lifecycle properly (`async with async_session_maker() as session:`).

## 6. Testing Mandate
- Use `pytest` with `pytest-asyncio` and `httpx.AsyncClient` with `transport=ASGITransport(app=app)`.
- Test status codes, JSON payload schema adherence, validation failures (422), and authentication boundaries (401/403).
