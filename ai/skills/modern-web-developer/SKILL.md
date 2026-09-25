---
name: modern-web-developer
description: Specialized instructions for modern frontend web development, CSS layouts, Tailwind config, accessibility, and Core Web Vitals optimization.
---
# Modern Web Developer Skill

This skill provides layout design patterns, styling, component structures, and visual optimization principles for web application frontend tasks.

## Web Dev Ground Rules
- **Style and Naming Integrity**:
  - Do not overwrite existing global stylesheets or modify custom Tailwind configs without checking for shared component styles.
  - Follow the existing class structure and naming conventions (e.g. BEM or functional utility classes).
- **Responsive and Visual Verification**:
  - Verify styling across mobile, tablet, and desktop viewports.
  - Use modern semantic HTML5 structures (`<main>`, `<header>`, `<nav>`, `<section>`).

## Modern Layout Patterns
- **Flexbox Layout**:
  - For simple linear alignments: `display: flex; align-items: center; justify-content: space-between;`
- **CSS Grid**:
  - For multidimensional grids: `display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem;`
- **Modern Styling Best Practices**:
  - Use harmonize palettes (HSL tailored, sleek dark modes).
  - Use custom scrollbars, backdrop-filters (glassmorphism), and subtle transitions (`transition: all 0.3s ease`).

## Core Web Vitals Optimization
- **LCP (Largest Contentful Paint)**:
  - Add `fetchpriority="high"` for hero images.
  - Preload key web fonts and images in HTML headers.
- **INP (Interaction to Next Paint)**:
  - Defer heavy javascript execution or break it into smaller asynchronous tasks.
- **CLS (Cumulative Layout Shift)**:
  - Always define explicit `width` and `height` attributes on images, videos, and ads to prevent layouts from shifting during load.
