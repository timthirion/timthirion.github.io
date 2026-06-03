# AGENTS.md

Guidance for AI coding agents (Claude Code, etc.) working in this repo.

## What this is

A personal blog by Tim Thirion, built with Jekyll 4.3 and a heavily customized Minima theme. Deployed via GitHub Pages from `main`.

## Workflow

- **Commit directly to `main` and push.** No feature branches, no pull requests.
- Still confirm before pushing anything non-trivial; the lack of a PR step means there's no second pair of eyes.
- Never force-push.

## Local development

```
bundle install              # first time only
bundle exec jekyll serve    # http://127.0.0.1:4000, live-reloads on file changes
bundle exec jekyll clean    # wipe _site/ and .jekyll-cache/ when stale
```

`_site/` is gitignored — never commit it.

## Project layout

```
_articles/         Blog posts (custom collection, not _posts)
  YYYY-MM-DD-slug/
    index.md      One post per folder; co-locate images here
_layouts/         default, home, page, post — the real layouts live here
_includes/        head, header, footer, social, icons
_sass/minima/     Custom SCSS: Catppuccin themes, custom variables, overrides
assets/js/        theme-toggle.js, copy-code.js
css/              Top-level CSS, Rouge syntax theme overrides
_config.yml       Site config (collection setup is here)
```

Layouts live **only** in `_layouts/`. Do not add `default.html` / `home.html` / `page.html` / `post.html` at the repo root — they used to exist there as scaffold leftovers and were being served as standalone pages.

## Authoring a new article

1. Create `_articles/YYYY-MM-DD-slug/index.md`.
2. Frontmatter:
   ```yaml
   ---
   layout: post
   title:  "Post Title"
   date:   YYYY-MM-DD HH:MM:SS -0400
   slug: kebab-case-slug
   ---
   ```
   (`layout: post` is the default for the collection, so technically optional.)
3. Permalink format is `/:year-:month-:day-:slug/` — set by `collections.articles.permalink` in `_config.yml`.
4. Code blocks: standard fenced markdown (`` ```rust ``) — Rouge handles highlighting. The `{% highlight %}` Liquid tag also works.
5. Math: KaTeX is loaded site-wide via CDN in `_includes/head.html` with auto-render on `document.body`. Use `$$...$$` for both inline and display math.
6. Figures: every image or interactive canvas gets wrapped in `<figure>` with a `<figcaption>` below it. Global styling in `_sass/minima/custom-overrides.scss` handles centering, vertical spacing, the caption's italic mauve treatment, and auto-numbering (a CSS counter scoped to `.post-content` prepends "Fig N." — do **not** write the prefix manually). Author just writes:
   ```html
   <figure>
     <img src="..." alt="..." />
     <figcaption>What this is.</figcaption>
   </figure>
   ```
   Captions are descriptive (what the figure is), not instructional (how to interact) — interactive affordances belong on the figure itself, not in the caption.
7. Code snippets from sibling repos (`quasi`, `motum`): copy **verbatim** — same line breaks, same indentation, same whitespace as the source file at the pinned commit. Don't compress multi-line calls onto one line, don't merge `if (cond) {\n    return;\n}` into single-line form, don't re-align. The `data-src` GitHub link lets readers compare against the file directly, so reformatted snippets read as "you don't trust the source." The only intentional divergence from source is a single top-line language label comment (`// Rust`, `// WGSL`, `# Cargo.toml`). Each snippet also carries a kramdown IAL with the pinned-commit URL: `{:data-src="https://github.com/timthirion/quasi/blob/COMMIT/path/to/file#Lstart-Lend"}`.

## Interactive demos

Live in-browser demos pull from the project repos, not from one-off code in the post:

- Rendering / global illumination / graphics demos → **quasi** — https://github.com/timthirion/quasi (Rust + wgpu)
- Robot motion planning demos → **motum** — https://github.com/timthirion/motum

All three repos (this one, `quasi`, `motum`) are cloned as siblings under the same parent directory locally, so `../quasi` and `../motum` resolve from this repo's root.

Each post pins a specific commit of the source repo, builds a small wasm crate exposing only what that post needs, and vendors the resulting `.wasm` + JS shim under `assets/demos/<post-slug>/`. Frozen per-post bundles keep older posts working as the source repos evolve.

## Theming

- Light/dark toggle in the header; choice persists in `localStorage` under key `theme`. Default is dark. Theme class is set inline in `<head>` to avoid FOUC.
- Color palettes are Catppuccin — Latte (light) and Mocha (dark). Variables and theme switching live in `_sass/minima/catppuccin-*.scss`.
- Site-wide tweaks go in `_sass/minima/custom-overrides.scss` and `custom-variables.scss`.
- Syntax highlighting uses Catppuccin variants under `_sass/minima/catppuccin-syntax-*.scss`. There's also an older `css/xcode-dark-highlighting.*` kept around.

## Conventions

- Match the existing minimalist style; no decorative emojis in posts, layouts, or commits unless explicitly requested.
- Don't add features, abstractions, or "future-proofing" beyond what a change requires. Three similar lines beats a premature helper.
- Don't add backwards-compat shims (renamed-but-unused vars, "// removed" comments, dead re-exports). If something is unused, delete it.
- Avoid adding new third-party CDN scripts to `head.html` without a reason — every entry there is a network dependency on every page load.
