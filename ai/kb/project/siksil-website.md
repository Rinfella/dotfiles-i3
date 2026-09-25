# SikSil Website Architecture & Knowledge Base

## Overview
- **Domains**: `siksil.com`, `www.siksil.com`, `siksil.in`, `www.siksil.in`
- **Location**: `/home/rf/projects/siksil/siksil-website-new`
- **Stack**: Cloudflare Workers + Hono + Cloudflare D1 (SQLite) + Cloudflare R2 + HTMX + Tailwind CSS CDN + CodeMirror

## Database & Cloudflare Bindings
- **Cloudflare D1 Database**: `siksil_website` (ID: `c50ec805-d648-4954-a054-66d830f24340`)
  - Tables: `sidebar_items`, `tabs`, `tab_revisions`, `media_assets`, `site_config`
  - **CRITICAL**: Never run `npm run db:init:prod` on production as it drops existing tables and live content.
- **Cloudflare R2 Bucket**: `siksil-web-assets` (`BUCKET` binding in `wrangler.jsonc`)

## Key Architecture & Features
1. **Zero-Flicker Sliding Pill Navigation**:
   - Outlined sliding pill on horizontal tab bar synchronized with 900ms smooth cubic-bezier easing.
   - 0.97 opacity masking veil prevents layout pops during HTMX content swaps.
2. **SVG Scope Isolation Engine**:
   - `scopeSvg()` dynamically scopes class names and style blocks inside uploaded SVGs to prevent stylesheet collisions.
3. **Blueprint Templating Engine**:
   - 9 full-page blueprints: About Us (`company_mission`), Hero Overview (`hero_overview`), Product Specs (`product_specs`), Gallery (`media_gallery`), Whitepaper Docs (`article_docs`), Contact (`contact_inquiry`), Changelog (`changelog_timeline`), Team (`team_showcase`), Comparison Matrix (`comparison_matrix`).
   - 3 modular snippet components: Feature Grid, Media Split, Callout Box.
   - Interactive Live Visual Preview modal and asset binding.
4. **Safety Net & Snapshot Deduplication**:
   - Automatic rolling revisions (max 20 per tab) generated on content change.
   - 1-click JSON backup export endpoint (`/admin/backup/export`).
5. **SEO & Discovery**:
   - Dynamic `/sitemap.xml` and `/robots.txt` automatically populated from Cloudflare D1.
   - Fast client-side search palette (`/api/search-index`, `⌘K` / `Ctrl+K`).
