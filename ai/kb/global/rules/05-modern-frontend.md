# Modern Frontend Guidelines (Bun, Vite, Tailwind v4, TS/JS)

## 1. Tooling & Runtimes
- **Package Manager:** Prefer `bun` or `pnpm` for fast, reproducible dependency resolution. Avoid bloated global installs.
- **Bundler:** Vite 6+ or native framework bundlers (Next.js / Nuxt / SvelteKit).
- **TypeScript:** Strict mode enabled (`"strict": true`, `"noImplicitAny": true`). Treat types as living documentation.

## 2. Tailwind CSS v4 Standards
- Use Tailwind v4 native CSS-first configuration:
  - Import via `@import "tailwindcss";` in your main CSS file.
  - Define custom theme tokens using `@theme { --color-brand: ...; }`.
  - Use `@utility` for custom reusable utilities instead of bloated arbitrary values.
- Do not refactor global layout stylesheets, reset Tailwind configurations, or modify shared CSS variables unless explicitly requested.
- Maintain responsive-first design: start with mobile/base styles, then layer `sm:`, `md:`, `lg:`, `xl:` breakpoints.

## 3. Component Architecture & UI State
- Small, focused, single-responsibility components.
- State colocation: keep state as close as possible to where it is consumed. Avoid unnecessary global stores for local component state.
- Handle all component states explicitly:
  1. Default / Idle
  2. Loading / Skeleton
  3. Empty state
  4. Error state with actionable recovery
  5. Disabled / Submitting state

## 4. Accessibility & Core Web Vitals
- Semantic HTML tags (`<main>`, `<nav>`, `<article>`, `<header>`, `<footer>`, `<aside>`, `<button>`). Never use `<div onclick="...">`.
- Keyboard navigation: ensure all interactive elements have visible focus rings (`focus-visible:ring-2`) and support `Enter` and `Space`.
- ARIA: use valid ARIA roles and attributes only when native HTML elements cannot represent the semantic (`aria-expanded`, `aria-controls`, `aria-label`).
- Optimize for Core Web Vitals:
  - LCP: lazy-load off-screen images, use modern formats (AVIF/WebP), preload hero assets.
  - CLS: specify explicit width/height or aspect ratios on media elements and containers.
  - INP: avoid heavy synchronous tasks on the main thread during user interaction.
