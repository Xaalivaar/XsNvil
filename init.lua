-- ========================================================================== --
--                           LEADER & ESSENTIALS                              --
-- ========================================================================== --
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core UI & Editor Feel
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.showmode = false          -- Hide native mode indicator (cleaner statusline)
vim.opt.splitright = true         -- Vertical splits open to the right
vim.opt.splitbelow = true         -- Horizontal splits open below
vim.opt.virtualedit = "block"     -- Allow cursor anywhere in visual block mode

-- Search & Timing
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.updatetime = 200
vim.opt.timeoutlen = 300

-- Indentation & Formatting
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.wrap = false

-- Backup, History & Undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

-- Clipboard & Completion
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.wildmode = "longest:full,full"
vim.opt.path:append("**")
vim.opt.wildignore:append({ "*/.git/*", "*.aux", "*.fls", "*.fdb_latexmk", "*.synctex.gz", "*.pdf" })

-- Fast netrw setup (clean tree look without extra file managers)
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

-- ========================================================================== --
--                        VIMTEX PRE-LOAD CONFIGURATION                       --
-- ========================================================================== --
-- Must be set BEFORE VimTeX is added to runtimepath
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_quickfix_mode = 0    -- Don't auto-open quickfix on warnings

vim.g.vimtex_compiler_latexmk = {
  callback = 1,
  continuous = 1,
  executable = "latexmk",
  options = {
    "-verbose",
    "-file-line-error",
    "-synctex=1",
    "-interaction=nonstopmode",
  },
}

-- ========================================================================== --
--                            STANDALONE PLUGINS                              --
-- ========================================================================== --
local uv = vim.uv or vim.loop
local data_dir = vim.fn.stdpath("data") .. "/site/pack/plugins/start/"

local function ensure_plugin(repo, dir_name)
  local install_path = data_dir .. dir_name
  if not uv.fs_stat(install_path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/" .. repo .. ".git",
      install_path,
    })
  end
  vim.opt.rtp:prepend(install_path)
end

-- Bootstrap plugins
ensure_plugin("folke/which-key.nvim", "which-key.nvim")
ensure_plugin("christoomey/vim-tmux-navigator", "vim-tmux-navigator")
ensure_plugin("lervag/vimtex", "vimtex")
ensure_plugin("L3MON4D3/LuaSnip", "LuaSnip")
ensure_plugin("iurimateus/luasnip-latex-snippets.nvim", "luasnip-latex-snippets.nvim")

-- ========================================================================== --
--                          WHICH-KEY CONFIGURATION                           --
-- ========================================================================== --
local ok_wk, wk = pcall(require, "which-key")
if ok_wk then
  wk.setup({
    preset = "helix",
    delay = 200,
  })

  wk.add({
    -- Core Doom-style leader groups
    { "<leader>b", group = "Buffer" },
    { "<leader>f", group = "File" },
    { "<leader>o", group = "Open / Toggle" },
    { "<leader>q", group = "Quit / Session" },
    { "<leader>w", group = "Window" },

    -- Standalone leader & visual shortcuts
    { "<leader><space>", desc = "Switch buffer" },
    { "<leader>p", desc = "Paste without overwriting register", mode = "x" },

    -- Navigation & editing hints
    { "J", desc = "Move selection down", mode = "v" },
    { "K", desc = "Move selection up", mode = "v" },
  })
end

-- ========================================================================== --
--                      LUASNIP & LATEX SNIPPETS SETUP                        --
-- ========================================================================== --
local ok_ls, ls = pcall(require, "luasnip")
if ok_ls then
  ls.config.setup({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    enable_autosnippets = true,
  })

  local ok_latex_snip, latex_snip = pcall(require, "luasnip-latex-snippets")
  if ok_latex_snip then
    latex_snip.setup({
      use_treesitter = false,     -- Uses VimTeX syntax detection instead of Tree-sitter
      allow_on_markdown = false,
    })
  end

  -- Expand snippet or jump forward within current snippet
  vim.keymap.set({ "i", "s" }, "<Tab>", function()
    if ls.expand_or_locally_jumpable() then
      ls.expand_or_jump()
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
    end
  end, { silent = true, desc = "LuaSnip expand or jump forward" })

  -- Jump backward within current snippet
  vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
    if ls.locally_jumpable(-1) then
      ls.jump(-1)
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true), "n", false)
    end
  end, { silent = true, desc = "LuaSnip jump backward" })

  -- Cycle choice nodes if a snippet offers alternatives
  vim.keymap.set({ "i", "s" }, "<C-e>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { silent = true, desc = "LuaSnip next choice node" })
end

-- ========================================================================== --
--                           DOOM EMACS KEYBINDINGS                           --
-- ========================================================================== --

-- File operations (<leader>f)
vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file in path" })
vim.keymap.set("n", "<leader>fs", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>fS", "<cmd>wa<CR>", { desc = "Save all files" })
vim.keymap.set("n", "<leader>fr", "<cmd>oldfiles<CR>", { desc = "Recent files" })
vim.keymap.set("n", "<leader>fR", "<cmd>edit!<CR>", { desc = "Revert buffer" })
vim.keymap.set("n", "<leader>fp", "<cmd>edit $MYVIMRC<CR>", { desc = "Open config (init.lua)" })

-- Buffer operations (<leader>b)
vim.keymap.set("n", "<leader>bb", "<cmd>buffers<CR>:buffer<Space>", { desc = "Switch buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>bdelete!<CR>", { desc = "Force delete buffer" })
vim.keymap.set("n", "<leader>br", "<cmd>b#<CR>", { desc = "Alternate buffer" })

-- Window operations (<leader>w)
vim.keymap.set("n", "<leader>ws", "<cmd>split<CR>", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>wc", "<cmd>close<CR>", { desc = "Close current window" })
vim.keymap.set("n", "<leader>wo", "<cmd>only<CR>", { desc = "Close other windows" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Balance windows" })

-- Window navigation under <leader>w (synced with Tmux)
vim.keymap.set("n", "<leader>wh", "<cmd>TmuxNavigateLeft<CR>", { desc = "Focus left window/pane" })
vim.keymap.set("n", "<leader>wj", "<cmd>TmuxNavigateDown<CR>", { desc = "Focus window/pane below" })
vim.keymap.set("n", "<leader>wk", "<cmd>TmuxNavigateUp<CR>", { desc = "Focus window/pane above" })
vim.keymap.set("n", "<leader>wl", "<cmd>TmuxNavigateRight<CR>", { desc = "Focus right window/pane" })

-- Direct Neovim <-> Tmux navigation (Ctrl + hjkl / \)
vim.keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Window/Pane left" })
vim.keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Window/Pane down" })
vim.keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Window/Pane up" })
vim.keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Window/Pane right" })
vim.keymap.set("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", { desc = "Window/Pane previous" })

-- Open / Toggle (<leader>o)
vim.keymap.set("n", "<leader>op", "<cmd>Explore<CR>", { desc = "Open file tree (Netrw)" })
vim.keymap.set("n", "<leader>ot", function()
  vim.cmd("botright 12split | terminal")
  vim.cmd("startinsert")
end, { desc = "Open bottom terminal" })

-- Quit & Reload (<leader>q)
vim.keymap.set("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit Neovim" })
vim.keymap.set("n", "<leader>qQ", "<cmd>qa!<CR>", { desc = "Force quit all" })
vim.keymap.set("n", "<leader>qr", "<cmd>source $MYVIMRC<CR>", { desc = "Reload init.lua" })

-- Buffer switcher shortcut & clear search
vim.keymap.set("n", "<leader><space>", "<cmd>buffers<CR>:buffer<Space>", { desc = "Find buffer" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- ========================================================================== --
--                         TEXT EDITING & UTILITIES                           --
-- ========================================================================== --

-- Visual line moving with auto-indent
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Centered scrolling & searching
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous match (centered)" })

-- Paste over selection without replacing clipboard contents
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })

-- Terminal mode quick-exit
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ========================================================================== --
--                               AUTOCOMMANDS                                 --
-- ========================================================================== --
local augroup = vim.api.nvim_create_augroup("UserConfigs", { clear = true })

-- Return to last edit position on file reopen
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Buffer-local LaTeX settings & Which-Key entries
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "tex", "plaintex", "bib" },
  callback = function(ev)
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true

    if ok_wk then
      wk.add({
        -- VimTeX <localleader>l commands (<Space>l)
        { "<localleader>l",  group = "LaTeX (VimTeX)", buffer = ev.buf },
        { "<localleader>ll", desc = "Compile (toggle continuous)", buffer = ev.buf },
        { "<localleader>lL", desc = "Compile selected", buffer = ev.buf },
        { "<localleader>lv", desc = "View PDF / Forward search", buffer = ev.buf },
        { "<localleader>lr", desc = "Reverse search", buffer = ev.buf },
        { "<localleader>lk", desc = "Stop compilation", buffer = ev.buf },
        { "<localleader>lK", desc = "Stop all compilations", buffer = ev.buf },
        { "<localleader>lc", desc = "Clean aux files", buffer = ev.buf },
        { "<localleader>lC", desc = "Clean all (incl. PDF)", buffer = ev.buf },
        { "<localleader>le", desc = "Show errors (Quickfix)", buffer = ev.buf },
        { "<localleader>lo", desc = "Show compiler output", buffer = ev.buf },
        { "<localleader>lt", desc = "Open Table of Contents", buffer = ev.buf },
        { "<localleader>lT", desc = "Toggle Table of Contents", buffer = ev.buf },
        { "<localleader>li", desc = "VimTeX info", buffer = ev.buf },
        { "<localleader>lI", desc = "VimTeX full info", buffer = ev.buf },
        { "<localleader>lg", desc = "Compilation status", buffer = ev.buf },
        { "<localleader>lG", desc = "Full compilation status", buffer = ev.buf },
        { "<localleader>lq", desc = "Show VimTeX log", buffer = ev.buf },
        { "<localleader>ls", desc = "Toggle main file", buffer = ev.buf },
        { "<localleader>la", desc = "Context menu", buffer = ev.buf },
        { "<localleader>lm", desc = "List insert-mode mappings", buffer = ev.buf },
        { "<localleader>lx", desc = "Reload VimTeX", buffer = ev.buf },

        -- VimTeX structural surround edits
        { "cs",  group = "Change surrounding (LaTeX)", buffer = ev.buf },
        { "cse", desc = "Change environment", buffer = ev.buf },
        { "csc", desc = "Change command", buffer = ev.buf },
        { "cs$", desc = "Change math zone", buffer = ev.buf },
        { "csd", desc = "Change delimiter", buffer = ev.buf },

        { "ds",  group = "Delete surrounding (LaTeX)", buffer = ev.buf },
        { "dse", desc = "Delete environment", buffer = ev.buf },
        { "dsc", desc = "Delete command", buffer = ev.buf },
        { "ds$", desc = "Delete math zone", buffer = ev.buf },
        { "dsd", desc = "Delete delimiter", buffer = ev.buf },

        { "ts",  group = "Toggle surrounding (LaTeX)", buffer = ev.buf },
        { "tse", desc = "Toggle starred environment", buffer = ev.buf },
        { "tsc", desc = "Toggle starred command", buffer = ev.buf },
        { "ts$", desc = "Toggle inline/display math", buffer = ev.buf },
        { "tsd", desc = "Toggle \\left/\\right delimiters", buffer = ev.buf },
        { "tsf", desc = "Toggle fraction style", buffer = ev.buf },
      })
    end
  end,
})
