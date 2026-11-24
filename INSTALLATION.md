# System requirements and installation

[← Documentation index](README.md)

## Requirements

| Dependency | Why it is used |
| --- | --- |
| Neovim (recent release with Lua and `vim.uv`/`vim.loop`) | Editor and filesystem watching |
| Git | Clones plugins on first launch |
| A working clipboard provider | Supports `unnamedplus` clipboard integration |
| A TeX distribution providing `latexmk` and the necessary LaTeX packages | Builds LaTeX documents |
| Zathura, with a PDF backend | Opens compiled PDF files via VimTeX |
| Inkscape 1.x | SVG editing and PDF+LaTeX export |
| A graphical desktop session | Runs the Inkscape window and PDF viewer |
| tmux (optional) | Cross-pane navigation when working inside tmux |

The configuration installs these plugins automatically: `folke/which-key.nvim`, `christoomey/vim-tmux-navigator`, `lervag/vimtex`, `L3MON4D3/LuaSnip`, and `iurimateus/luasnip-latex-snippets.nvim`. GitHub access is needed on initial setup. The configuration does **not** pin plugin versions, so later installations may behave differently.

## Installation

1. Install Neovim, Git, a TeX distribution (`latexmk` included), Zathura and its PDF backend, and Inkscape. Install tmux if you use it.
2. Back up an existing Neovim configuration if necessary:

   ```sh
   test ! -f ~/.config/nvim/init.lua || cp ~/.config/nvim/init.lua ~/.config/nvim/init.lua.bak
   ```

3. Copy the supplied `init.lua` to the standard Linux configuration location:

   ```sh
   mkdir -p ~/.config/nvim
   cp init.lua ~/.config/nvim/init.lua
   ```

4. Start Neovim with `nvim`. On first launch, the configuration clones its five plugins to Neovim's `stdpath('data')/site/pack/plugins/start/` directory. If cloning fails, check Git/network access and restart.
5. Run the checks below before starting a project.

## Verify the setup

Run these in a terminal:

```sh
nvim --version
git --version
latexmk -v
zathura --version
inkscape --version
```

Then in Neovim:

```vim
:checkhealth
:echo executable('latexmk')
:echo executable('inkscape')
:echo executable('zathura')
```

The executable checks should print `1`. Open a `.tex` file to check VimTeX and LuaSnip initialization; then test compiling a minimal document. For figure creation, start Neovim from the **LaTeX project root** (`:pwd` should match the directory containing `figures/`).

## Notes and limitations

- The commands and config placement above assume Linux, which matches the Inkscape GUI workflow described in `init.lua`; other platforms require adjustments.
- LaTeX packages referenced by a document must be installed in the TeX distribution. The three figure-related preamble packages are inserted by a LaTeX mapping described in the workflow guide.
- The SVG watcher runs inside Neovim; saving an SVG after quitting Neovim will not trigger this configuration's automatic export.
- No `watch_inkscape.sh` or `inotify-tools` dependency is required: Neovim's libuv filesystem notifications handle the export trigger.
