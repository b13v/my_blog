# Sound Money

A multilingual static blog about Bitcoin and the Austrian School of Economics.

- **URL:** https://soundmoney.kz
- **Author:** Beibut Yerzhanov
- **Languages:** Russian, Kazakh
- **Built with:** [Blogatto](https://github.com/veeso/blogatto) (Gleam)

## Project structure

```text
src/                    # Gleam source code
  soundmoney.gleam      # Build entrypoint
  soundmoney/
    config.gleam        # Blogatto configuration
    views.gleam         # Shared Lustre views
    i18n.gleam          # Russian / Kazakh strings
blog/                   # Markdown posts
  what-is-bitcoin/
    index-ru.md
    index-kz.md
  ...
static/                 # Static assets
  css/style.css
dist/                   # Generated site (ignored by git)
.tools/                 # Local Gleam + rebar3 binaries (ignored by git)
```

## Local tooling

This project uses a local copy of Gleam so the system-wide installation is not affected.

```sh
# Build the site
./.tools/gleam run

# Serve locally (after building)
python3 -m http.server 8080 --directory dist
```

Then open http://127.0.0.1:8080.

## Add a new post

1. Create a directory under `blog/{post-slug}/`.
2. Add `index-ru.md` and `index-kz.md` with YAML frontmatter:

```markdown
---
title: Post title
date: 2025-06-30 00:00:00
description: Short description
slug: post-slug
tags: tag1, tag2
---

# Post title

Your content here.
```

3. Run `./.tools/gleam run` to rebuild.

## Deploy

Upload the contents of `dist/` to your static hosting provider.
