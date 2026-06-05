# Style guide

Typographic and copy conventions for this blog. Pairs with `AGENTS.md`,
which documents structural and authoring conventions; `STYLE.md` is
narrower — capitalization, punctuation, and label phrasing.

## Foundational references

- **Butterick, *Practical Typography*** (https://practicaltypography.com).
  Sentence-case bias, restraint with bold and decoration, opinionated
  defaults for body type, links, and lists.
- **Tufte's caption conventions** (https://edwardtufte.github.io/tufte-css/).
  Quiet labels, italic captions, minimal chrome. The "Fig N." prefix in
  this blog is set in roman + italic body, no bold — Tufte-style.

## Casing

The blog mixes two casing conventions, by role:

- **Section headings** (`##`, `###`) — **title case**.
  "Path Tracing in WGSL", "Next-Event Estimation", "What's Next".
- **Labels and captions** — figure captions, `<summary>` text, inline
  callouts — **sentence case**, with proper nouns and literal filenames
  preserved.
  - "Cornell Box construction" — proper noun preserved.
  - "Cargo.toml dependencies" — literal filename preserved.
  - "Ray-quad intersection" — first word capitalized, hyphenated
    compound's tail lowercased.
  - "Sampling the area light" — plain sentence case.

The split is Butterick's: sentence case reads as native prose for
in-flow labels, title case signals a structural heading.

## Figure captions

Descriptive, not instructional — the caption says *what the figure is*,
not *how to interact with it*. Interactive affordances belong on the
figure itself (e.g. the "☞ Interactive" badge), never in the caption.

The auto-numbered "Fig N." prefix is set by CSS; author writes only
the descriptive body.

## Code-sample summaries (`<details><summary>`)

Same sentence-case rule applies. The summary describes the snippet by
**intent**, not by function name:

- ✓ "Cornell Box construction"
- ✗ "the cornell_box function"

Each summary is prefixed with **"Source: "** followed by the
sentence-case description — e.g. *"Source: Cornell Box construction"*,
*"Source: Path-trace integrator"*. The "Source:" framing leans toward
"the actual code that does this" over "an illustrative example."

## Statement on AI

Every blog post carries a non-italicized link in the post header reading
"Read my statement on AI" → `/on-ai/`. The link uses the standard body
link color; size matches the `.post-meta` date line above it.
