# LaTeX setup and workflow

[← Documentation index](README.md) · [Snippet trigger catalog](LATEX_SNIPPETS.md)

## VimTeX and PDF compilation

The configuration treats `.tex` files as LaTeX and uses **VimTeX + latexmk + Zathura**. `latexmk` runs in continuous mode, with SyncTeX, file/line errors, and nonstop interaction enabled. The quickfix window does not automatically open for compiler warnings.

LaTeX, plain TeX, and BibTeX buffers get soft wrapping (`wrap` and `linebreak`). VimTeX and its Which-Key hints are used in LaTeX buffers; not every command necessarily applies to `.bib` files.

### VimTeX keys

`<Space>l` is VimTeX's local-leader command prefix in a LaTeX buffer.

| Key | Action |
| --- | --- |
| `<Space>ll` / `<Space>lL` | Toggle continuous compilation / compile selection |
| `<Space>lv` / `<Space>lr` | View PDF (forward search) / reverse search command |
| `<Space>lk` / `<Space>lK` | Stop current / all compilers |
| `<Space>lc` / `<Space>lC` | Clean auxiliary files / clean including PDF |
| `<Space>le` / `<Space>lo` | Open errors / compiler output |
| `<Space>lt` / `<Space>lT` | Show / toggle table of contents |
| `<Space>li` / `<Space>lI` | Info / full info |
| `<Space>lg` / `<Space>lG` | Compilation status / full status |
| `<Space>lq` | Show compiler log |
| `<Space>ls` / `<Space>la` | Toggle main file / context menu |
| `<Space>lm` / `<Space>lx` | List insert-mode mappings / reload VimTeX |

### LaTeX surround operations

| Key | Action |
| --- | --- |
| `cse` / `dse` | Change / delete environment |
| `csc` / `dsc` | Change / delete command |
| `cs$` / `ds$` | Change / delete math delimiters |
| `csd` / `dsd` | Change / delete surrounding delimiter |
| `tse` / `tsc` | Toggle starred environment / command |
| `ts$` / `tsd` | Toggle inline vs display math / left-right delimiters |
| `tsf` | Toggle fraction style |

These are VimTeX operations listed in the configuration's Which-Key hints, not additional user-defined implementations.

## Snippets: manual expansion only

LuaSnip and `luasnip-latex-snippets.nvim` supply the snippet collection. The config disables autosnippets and wraps plugin registration to convert autosnippets to ordinary manual snippets. **Type the trigger and press `<Tab>` to expand**, subject to its math/text, beginning-of-line, and pattern restrictions.

| Key | Mode | Action |
| --- | --- | --- |
| `<Tab>` | Insert / Select | Expand a matching snippet or jump to next placeholder; otherwise insert Tab |
| `<S-Tab>` | Insert / Select | Jump to previous placeholder when available |
| `<C-e>` | Insert / Select | Cycle an active snippet choice; otherwise preserve normal Ctrl-E behavior |

The plugin is configured with `use_treesitter = false` for TeX syntax checks and `allow_on_markdown = true`. Markdown support is plugin-dependent and may use different context detection. See the [complete trigger catalog](LATEX_SNIPPETS.md) for names, expansions, and conditions. The catalog derives from the supplied upstream inventory and is not a live dump of installed snippets.

## Inkscape PDF+LaTeX figures

The diagram commands are buffer-local in `.tex` and `.plaintex` files. Start Neovim from your project directory (`:pwd`), because relative figure paths are based on its working directory, not automatically the location of the current TeX file.

| Key | Action |
| --- | --- |
| `<Space>ib` | Insert the three required Inkscape-related `\usepackage` lines after the current line |
| `<Space>id` | Prompt for a figure name, create/reuse SVG, insert figure markup below cursor, and open Inkscape |
| `<Space>ie` | Reopen an existing diagram referenced on the current `\input{figures/...pdf_tex}` line |
| `<Space>ix` | Force-export the diagram referenced on that line |

### Workflow

1. Put the cursor in the preamble and press `<Space>ib` **once**. This inserts `graphicx`, `color`, and `transparent` package declarations; the mapping does not check for duplicates.
2. In the document, press `<Space>id` and enter a relative name such as `mechanics/pendulum` (without `.svg`). Names allow letters, numbers, `_`, `-`, and `/` for nested directories; no absolute paths or path traversal.
3. The command creates `figures/mechanics/pendulum.svg` if necessary, inserts a `figure` environment after the cursor line, and opens the SVG in Inkscape. The inserted block includes `\graphicspath`, `\svgwidth`, `\input{figures/mechanics/pendulum.pdf_tex}`, a generated caption, and a figure label.
4. Draw in Inkscape and save (`Ctrl+S`). While Neovim is running, a filesystem watcher detects saves and asynchronously exports a drawing-area PDF plus corresponding `.pdf_tex` file; short bursts of changes are debounced.
5. Build with `<Space>ll` and view using `<Space>lv`. To revise, place the cursor on the figure's `\input{...pdf_tex}` line and press `<Space>ie`; use `<Space>ix` if the watcher did not export.

### Figure files

For the example name `mechanics/pendulum`, the project contains:

```text
figures/
└── mechanics/
    ├── pendulum.svg       # Editable Inkscape source
    ├── pendulum.pdf       # Drawing export
    └── pendulum.pdf_tex   # LaTeX text-overlay export
```

The code uses `inkscape --export-area-drawing --export-type=pdf --export-latex`. A completely blank SVG may fail to export until something has been drawn. Figure export watching only operates while the Neovim process remains open. If watching is unavailable, `<Space>ix` is the manual fallback.
