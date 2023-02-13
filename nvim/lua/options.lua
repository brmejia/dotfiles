local options = {
    -- Make it obvious where 90 characters is
    textwidth = 0,
    -- formatoptions = "cqj",
    colorcolumn = "+8",
    list = true,
    listchars = {
        tab = "▸·",
        -- eol = "¬",
        trail = "·",
        nbsp = "·",
        extends = "❯",
        precedes = "❮"
    },
    confirm = true,
    fillchars = 'eob: ',
    backup = true, -- creates a backup file
    backupdir = vim.fn.stdpath 'data' .. '/backup//',
    clipboard = "", -- allows neovim to access the system clipboard
    --Set completeopt to have a better completion experience
    -- :help completeopt
    -- menuone: popup even when there's only one match
    -- noinsert: Do not insert text until a selection is made
    -- noselect: Do not select, force to select one from the menu
    -- shortness: avoid showing extra messages when using completion
    -- updatetime: set updatetime for CursorHold
    completeopt = { "menuone", "noselect", "noinsert" }, -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 10, -- pop up menu height
    showtabline = 2, -- always show tabs
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
    undofile = true, -- enable persistent undo
    redrawtime = 5000, -- Allow more time for loading syntax on large files,
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true, -- convert tabs to spaces
    cursorline = true, -- highlight the current line
    -- code folding settings
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
    foldenable = false, -- don't fold by default
    foldlevelstart = 2,
    foldlevel = 2,
    foldnestmax = 10, -- deepest fold is 10 levels
    -- Tab control
    smarttab = true, -- tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
    tabstop = 4, -- the visible width of tabs
    softtabstop = 4, -- edit as if the tabs are 4 characters wide
    shiftwidth = 4, -- number of spaces to use for indent and unindent
    shiftround = true, -- round indent to a multiple of 'shiftwidth'
    -- searching
    ignorecase = true, -- case insensitive searching
    smartcase = true, -- case-sensitive if expresson contains a capital letter
    hlsearch = false, -- highlight search results
    incsearch = true, -- set incremental search, like modern browsers
    lazyredraw = false, -- don't redraw while executing macros
    magic = true, -- set magic on, for regular expressions
    sidescrolloff = 8,
    history = 1000,
    linespace = 10,
    fileformat = "unix",
    -- Appearance
    ---------------------------------------------------------
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    termguicolors = true, -- set term gui colors (most terminals support this)
    number = true, -- show line numbers
    relativenumber = true, -- set relative numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    wrap = false, -- turn on line wrapping
    wrapmargin = 0, -- wrap lines when coming within n characters from side
    linebreak = false, -- set soft wrapping
    showbreak = "↪",
    autoindent = true, -- automatically set indent of new line
    ttyfast = true, -- faster redrawing
    laststatus = 3, -- show the global statusline all the time
    scrolloff = 8, -- set 8 lines to the cursors - when moving vertical
    wildmenu = true, -- enhanced command line completion
    hidden = true, -- current buffer can be put into background
    showcmd = true, -- show incomplete commands
    -- wildmode = {"list", "longest:full", "full"} ,-- complete files like a shell
    shell = vim.env.SHELL,
    cmdheight = 1, -- more space in the neovim command bar line for displaying messages
    title = true, -- set terminal title
    showmatch = true, -- show matching braces
    mat = 2, -- how many tenths of a second to blink
    updatetime = 300, -- faster completion (4000ms default)
    signcolumn = "yes:2", -- always show the sign column, otherwise it would shift the text each time
    shortmess = "atToOFc", -- prompt message options
}
vim.opt.shortmess = vim.opt.shortmess + { c = true }

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
-- vim.cmd([[
-- autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
-- ]])
