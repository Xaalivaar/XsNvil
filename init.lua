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
    { "<leader>i", group = "Inkscape diagrams" },
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
      allow_on_markdown = true,
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

  -- Cycle choice nodes, but preserve Neovim's regular <C-e> outside choices
  vim.keymap.set({ "i", "s" }, "<C-e>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    else
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-e>", true, false, true), "n", false)
    end
  end, { silent = true, desc = "LuaSnip next choice / regular Ctrl-E" })
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


-- ========================================================================== --
--              INKSCAPE DIAGRAMS: <Space>id / <Space>ie / <Space>ix           --
-- ========================================================================== --
-- Requirements: Inkscape 1.x, a graphical Linux session, and a TeX install.
-- No separate watch_inkscape.sh or inotify-tools needed. While Neovim runs,
-- libuv watches SVG files created/opened with these mappings and exports on save.
--
-- Run Neovim in your LaTeX PROJECT ROOT (check :pwd). A name such as
-- "mechanics/pendulum" becomes ./figures/mechanics/pendulum.svg.
-- Add \usepackage{graphicx}, \usepackage{color}, and \usepackage{transparent}
-- to the LaTeX preamble once. Compile with VimTeX (Space ll).

-- Close watchers from a previous :source $MYVIMRC before making replacements.
local previous_diagram_watches = rawget(_G, "__user_inkscape_watches")
if previous_diagram_watches then
  for _, watch in pairs(previous_diagram_watches) do
    watch.closed = true
    if watch.timer then
      pcall(function() watch.timer:stop(); watch.timer:close() end)
    end
    if watch.handle then
      pcall(function() watch.handle:stop(); watch.handle:close() end)
    end
  end
end
local diagram_watches = {}
_G.__user_inkscape_watches = diagram_watches

local function diagram_notify(msg, level)
  vim.notify("Inkscape: " .. msg, level or vim.log.levels.INFO)
end

-- A conservative path policy avoids traversal and LaTeX-unfriendly filenames.
-- Relative slashes are accepted for subdirectories, e.g. maths/commutative.
local function diagram_name(input)
  if not input then return nil end
  local name = vim.trim(input):gsub("%.svg$", "")
  if name == "" or name:sub(1, 1) == "/" or name:sub(-1) == "/"
    or name:find("//", 1, true) or not name:match("^[%w_/%-]+$") then
    diagram_notify("Use a relative name such as geometry/circle (letters, numbers, _ and - only)",
      vim.log.levels.ERROR)
    return nil
  end
  return name
end

local function diagram_paths(root, name)
  local base = root .. "/figures/" .. name
  return base .. ".svg", base .. ".pdf", "figures/" .. name .. ".pdf_tex"
end

local function diagram_signature(path)
  local stat = uv.fs_stat(path)
  if not stat or stat.type ~= "file" then return nil end
  local mt = stat.mtime or {}
  return table.concat({ tostring(mt.sec or 0), tostring(mt.nsec or 0), tostring(stat.size) }, ":")
end

-- Asynchronous export: no GUI freezes while Inkscape renders PDF+LaTeX.
local function export_diagram(watch, force)
  if watch.closed then return end
  local signature = diagram_signature(watch.svg)
  if not signature then return end
  if watch.running then
    watch.pending = true
    return
  end
  if not force and watch.last_exported == signature then return end
  if vim.fn.executable("inkscape") ~= 1 then
    diagram_notify("inkscape executable not found", vim.log.levels.ERROR)
    return
  end

  watch.running = true
  watch.last_exported = signature
  local job = vim.fn.jobstart({
    "inkscape", watch.svg,
    "--export-area-drawing",
    "--export-type=pdf",
    "--export-latex",
    "--export-filename=" .. watch.pdf,
  }, {
    on_exit = function(_, code)
      vim.schedule(function()
        if watch.closed then return end
        watch.running = false
        local changed_during_export = diagram_signature(watch.svg) ~= signature
        if code ~= 0 then
          -- A blank SVG has no drawing area to export; draw something first.
          watch.last_exported = nil
          diagram_notify("Export failed: " .. vim.fn.fnamemodify(watch.svg, ":t") ..
            " (check the drawing and :messages)", vim.log.levels.WARN)
        end
        watch.pending = false
        if changed_during_export then
          -- Inkscape can be saved again while an older export is running.
          export_diagram(watch, false)
        end
      end)
    end,
  })
  if job <= 0 then
    watch.running = false
    watch.last_exported = nil
    diagram_notify("Could not start the Inkscape export command", vim.log.levels.ERROR)
  end
end

local function watch_diagram(svg, pdf)
  local existing = diagram_watches[svg]
  if existing and not existing.closed then return existing end

  local directory = vim.fn.fnamemodify(svg, ":h")
  local filename = vim.fn.fnamemodify(svg, ":t")
  local watch = {
    svg = svg,
    pdf = pdf,
    running = false,
    pending = false,
    last_exported = diagram_signature(svg),
    closed = false,
  }

  local handle = uv.new_fs_event()
  local timer = uv.new_timer()
  if not handle or not timer then
    if handle then handle:close() end
    if timer then timer:close() end
    diagram_notify("Filesystem watcher unavailable; use Space ix to export", vim.log.levels.WARN)
    -- Keep this state for manual export, even if watching is unavailable.
    diagram_watches[svg] = watch
    return watch
  end

  watch.handle = handle
  watch.timer = timer
  local ok, err = handle:start(directory, {}, function(event_err, changed_file)
    if watch.closed or event_err then return end
    -- Directory watching catches both ordinary saves and atomic renames.
    if changed_file and changed_file ~= filename then return end
    timer:stop()
    timer:start(450, 0, vim.schedule_wrap(function()
      if not watch.closed then export_diagram(watch, false) end
    end))
  end)
  if not ok then
    handle:close()
    timer:close()
    watch.handle = nil
    watch.timer = nil
    diagram_notify("Could not watch " .. directory .. ": " .. tostring(err) ..
      "; use Space ix to export", vim.log.levels.WARN)
  end

  diagram_watches[svg] = watch
  return watch
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = augroup,
  callback = function()
    for _, watch in pairs(diagram_watches) do
      watch.closed = true
      if watch.timer then
        pcall(function() watch.timer:stop(); watch.timer:close() end)
      end
      if watch.handle then
        pcall(function() watch.handle:stop(); watch.handle:close() end)
      end
    end
  end,
})

local function open_diagram(svg, pdf)
  if vim.fn.executable("inkscape") ~= 1 then
    diagram_notify("Install Inkscape and ensure it is in PATH", vim.log.levels.ERROR)
    return
  end
  watch_diagram(svg, pdf)
  local job = vim.fn.jobstart({ "inkscape", svg }, { detach = true })
  if job <= 0 then
    diagram_notify("Could not open " .. svg, vim.log.levels.ERROR)
  end
end

local svg_blank_template = {
  '<?xml version="1.0" encoding="UTF-8"?>',
  '<svg xmlns="http://www.w3.org/2000/svg"',
  '     width="160mm" height="100mm" viewBox="0 0 160 100">',
  '</svg>',
}

local function insert_diagram()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1]
  local root = vim.fn.getcwd()

  if not vim.bo[bufnr].modifiable then
    diagram_notify("This buffer is not modifiable", vim.log.levels.WARN)
    return
  end
  if vim.fn.executable("inkscape") ~= 1 then
    diagram_notify("Install Inkscape first", vim.log.levels.ERROR)
    return
  end

  vim.ui.input({
    prompt = "Diagram name in ./figures/ (e.g. mechanics/pendulum): ",
  }, function(input)
    local name = diagram_name(input)
    if not name then return end
    if not vim.api.nvim_buf_is_valid(bufnr) then return end

    local svg, pdf, latex_input = diagram_paths(root, name)
    local parent = vim.fn.fnamemodify(svg, ":h")
    vim.fn.mkdir(parent, "p")
    if vim.fn.isdirectory(parent) ~= 1 then
      diagram_notify("Cannot create directory " .. parent, vim.log.levels.ERROR)
      return
    end

    if vim.fn.filereadable(svg) ~= 1 then
      if vim.fn.writefile(svg_blank_template, svg) ~= 0 then
        diagram_notify("Could not create " .. svg, vim.log.levels.ERROR)
        return
      end
    end

    local name_short = name:match("[^/]+$") or name
    local latex_dir = "figures/" .. (name:match("^(.*)/") or "")
    if latex_dir ~= "figures/" then latex_dir = latex_dir .. "/" end
    local caption = name_short:gsub("[_%-]", " ")
    caption = caption:gsub("^%l", string.upper)

    local block = {
      "\\begin{figure}[htbp]",
      "  \\centering",
      "  \\begingroup",
      "    \\graphicspath{{" .. latex_dir .. "}}",
      "    \\def\\svgwidth{0.8\\linewidth}",
      "    \\input{" .. latex_input .. "}",
      "  \\endgroup",
      "  \\caption{" .. caption .. "}",
      "  \\label{fig:" .. name:gsub("/", "-") .. "}",
      "\\end{figure}",
    }

    local line_count = vim.api.nvim_buf_line_count(bufnr)
    local after_line = math.min(cursor_line, line_count)
    local ok, insert_err = pcall(vim.api.nvim_buf_set_lines,
      bufnr, after_line, after_line, false, block)
    if not ok then
      diagram_notify("Cannot insert LaTeX: " .. tostring(insert_err), vim.log.levels.ERROR)
      return
    end

    open_diagram(svg, pdf)
    diagram_notify("Created reference for " .. name .. ". Draw and save with Ctrl+S.")
  end)
end

-- Reopen a figure by placing the cursor on its \input{figures/...pdf_tex} line.
local function diagram_under_cursor()
  local line = vim.api.nvim_get_current_line()
  local name = line:match("\\input%s*{%s*figures/([%w_/%-]+)%.pdf_tex%s*}")
  if not name then
    diagram_notify("Place the cursor on the \\input{figures/...pdf_tex} line", vim.log.levels.WARN)
    return nil
  end
  local root = vim.fn.getcwd()
  local svg, pdf = diagram_paths(root, name)
  if vim.fn.filereadable(svg) ~= 1 then
    diagram_notify("SVG not found: " .. svg, vim.log.levels.ERROR)
    return nil
  end
  return svg, pdf
end

local function edit_diagram()
  local svg, pdf = diagram_under_cursor()
  if svg then open_diagram(svg, pdf) end
end

local function export_diagram_under_cursor()
  local svg, pdf = diagram_under_cursor()
  if svg then export_diagram(watch_diagram(svg, pdf), true) end
end

-- Buffer-local mappings keep non-LaTeX editing and all your existing keys intact.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "tex", "plaintex" },
  callback = function(ev)
    -- Insert LaTeX packages required for Inkscape figures
    vim.keymap.set("n", "<leader>ib", function()
      local row = vim.api.nvim_win_get_cursor(0)[1]
      vim.api.nvim_buf_set_lines(0, row, row, false, {
        "\\usepackage{graphicx}",
        "\\usepackage{color}",
        "\\usepackage{transparent}",
      })
    end, {
      buffer = ev.buf,
      desc = "Inkscape Preamble",
    })
    vim.keymap.set("n", "<leader>id", insert_diagram,
      { buffer = ev.buf, desc = "Create/insert Inkscape diagram" })
    vim.keymap.set("n", "<leader>ie", edit_diagram,
      { buffer = ev.buf, desc = "Edit diagram on input line" })
    vim.keymap.set("n", "<leader>ix", export_diagram_under_cursor,
      { buffer = ev.buf, desc = "Export diagram on input line" })
  end,
})
