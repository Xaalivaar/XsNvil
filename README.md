# Neovim for LaTeX

A lightweight, single-file Neovim configuration with Doom-inspired leader mappings, VimTeX PDF compilation, **manual** LaTeX snippets, tmux pane navigation, and an integrated Inkscape figure workflow. Plugins are installed directly from GitHub on first launch; no plugin manager configuration is needed.

## Documentation

| Guide | What it covers |
| --- | --- |
| [System requirements & installation](INSTALLATION.md) | Dependencies, setup, verification, portability |
| [General settings & keybindings](GENERAL_SETTINGS.md) | Editor behavior, file/buffer/window commands, navigation, tmux |
| [LaTeX setup & workflow](LATEX_SETUP.md) | VimTeX, compilation, snippets usage, Inkscape figures and LaTeX-specific mappings |
| [Complete LaTeX snippet trigger table](LATEX_SNIPPETS.md) | Every recorded trigger, context restriction, and expansion |

## At a glance

- **Leader and local leader:** `<Space>`
- **PDF:** `latexmk` compilation via VimTeX, viewing in Zathura
- **Snippets:** type a trigger then press `<Tab>`; automatic expansion is disabled in this configuration
- **Figures:** create an SVG and insert LaTeX figure markup, draw in Inkscape, and export PDF+LaTeX on save
- **Navigation:** `which-key.nvim`, netrw, and Neovim/tmux pane switching

Start with [Installation](INSTALLATION.md), then consult the dedicated guide for the feature you need. The [`init.lua`](init.lua) file is the configuration source of truth.
