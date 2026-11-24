# General settings and keybindings

[← Documentation index](README.md)

All `<Space>` mappings below are in normal mode unless a different mode is shown. `<leader>` and `<localleader>` both equal `<Space>`. The configuration uses `which-key.nvim` (Helix preset, 200 ms popup delay) to show mapping groups.

## Editor behavior

| Area | Setting |
| --- | --- |
| Line numbers | Absolute and relative numbers; highlighted cursor line; permanent sign column |
| Movement | 8 lines/columns of scroll context; mouse enabled |
| Splits | New vertical splits on right; horizontal splits below |
| Indentation | Spaces; 2-space shiftwidth, tabstop, and softtabstop; smartindent |
| Wrapping | Off by default (LaTeX buffers override this) |
| Search | Incremental, highlighted, case-insensitive unless query contains uppercase |
| Clipboard | System clipboard (`unnamedplus`) |
| Files | No swap or backup files; persistent undo enabled |
| Interface | True color; native mode display hidden; visual block virtual edit enabled |
| Completion | Menu-based completion with no automatic selection |
| Paths | Recursive `**` path search; excludes Git folders and common LaTeX artifacts |
| Netrw | Tree display, hidden banner, window width 25% |
| Timing | `updatetime=200`, `timeoutlen=300` (milliseconds) |

Neovim restores the last edit position when a file is reopened.

## Files and buffers

| Key | Action |
| --- | --- |
| `<Space>ff` | Find file in `path` (`:find` prompt) |
| `<Space>fs` | Save current file |
| `<Space>fS` | Save all modified files |
| `<Space>fr` | Show recently opened files |
| `<Space>fR` | Reload current file from disk, discarding unsaved changes |
| `<Space>fp` | Edit `init.lua` |
| `<Space>bb` | List buffers and prompt for a buffer number |
| `<Space>bn` / `<Space>bp` | Next / previous buffer |
| `<Space>bd` / `<Space>bD` | Delete / force-delete buffer |
| `<Space>br` | Switch to alternate buffer |
| `<Space><Space>` | List buffers and prompt for a buffer number |

## Windows, tmux, and terminal

| Key | Action |
| --- | --- |
| `<Space>ws` / `<Space>wv` | Horizontal / vertical split |
| `<Space>wc` / `<Space>wo` | Close current / all other windows |
| `<Space>w=` | Equalize window dimensions |
| `<Space>wh`, `wj`, `wk`, `wl` | Move between Neovim windows / tmux panes |
| `<C-h>`, `<C-j>`, `<C-k>`, `<C-l>` | Direct left, down, up, right navigation |
| `<C-\>` | Jump to previously active window/pane |
| `<Space>op` | Open netrw explorer |
| `<Space>ot` | Open a 12-line terminal split at the bottom |
| `<Esc><Esc>` (terminal mode) | Leave terminal insert mode |

The tmux navigation commands are supplied by `vim-tmux-navigator`. To make switching work across tmux panes, tmux must also be configured appropriately; the Neovim file alone does not configure tmux.

## Editing, searching, and sessions

| Key | Mode | Action |
| --- | --- | --- |
| `J` / `K` | Visual | Move selected lines down / up and reindent |
| `<C-d>` / `<C-u>` | Normal | Half-page scroll, then center |
| `n` / `N` | Normal | Next / previous search match, centered |
| `<Space>p` | Visual | Paste without replacing the unnamed clipboard/register with selected text |
| `<Esc>` | Normal | Clear search highlights |
| `<Space>qq` / `<Space>qQ` | Normal | Quit all / force quit all |
| `<Space>qr` | Normal | Reload `init.lua` |

For LaTeX-only commands and snippet controls, see [LaTeX setup](LATEX_SETUP.md).
