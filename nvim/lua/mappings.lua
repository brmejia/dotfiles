-- Shorten function name
local keymap = require "lib.utils".keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",


------------
-- Normal --
------------

-- Leader Mappings
-- keymap("n", "<Leader>w", ":update<CR>")
-- keymap("n", "<Leader>q", ":qall<CR>")
-- keymap('n', '<leader>Q', ':bufdo bdelete<CR>')

-- keymap("n", "<Leader><Leader>r", ":source ~/.config/nvim/init.lua<CR>")

-- Auto-center on buffer movements
keymap("n", "G", "Gzz")
keymap("n", "n", "nzz")
keymap("n", "N", "Nzzlk")
keymap("n", "}", "}zz")
keymap("n", "{", "{zz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-f>", "<C-f>zz")

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize +2<CR>")
keymap("n", "<C-Right>", ":vertical resize -2<CR>")

-- Navigate buffers
keymap("n", "L", ":bnext<CR>")
keymap("n", "H", ":bprevious<CR>")
keymap("n", "<C-PageDown>", ":bnext<CR>")
keymap("n", "<C-PageUp>", ":bprevious<CR>")

-- Move text up and down
keymap("n", "<A-j>", ":move .+1<CR>==")
keymap("n", "J", "<Nop>")
keymap("n", "<A-k>", ":move .-2<CR>==")


-- Arrows movements
keymap("n", "<Up>",  "<cmd>lua vim.notify_once('Utiliza k en lugar de Up', 'error')<CR>")
keymap("n", "<Down>",  "<cmd>lua vim.notify_once('Utiliza j en lugar de Down', 'error')<CR>")
keymap("n", "<Left>",  "<cmd>lua vim.notify_once('Utiliza h en lugar de Left', 'error')<CR>")
keymap("n", "<Right>",  "<cmd>lua vim.notify_once('Utiliza l en lugar de Right', 'error')<CR>")

-- <C-_> is equivalent to <C-/> for Neovim
-- keymap("n", "<C-_>", "<cmd>Commentary<CR>")
keymap("n", "<C-_>", "gc")

-- Disable Ex Mode
keymap("n", "Q", "<Nop>")

-- Disable annoying command line thing
keymap('n', 'q:', ':q<CR>')

------------
-- Insert --
------------
-- Arrows movements
-- keymap("i", "<Up>",  "<Nop>")
-- keymap("i", "<Down>",  "<Nop>")
-- keymap("i", "<Left>",  "<Nop>")
-- keymap("i", "<Right>",  "<Nop>")

-- Tab completion for insert mode
keymap("i", "<S-Tab>", "<C-D>")
-- Allows to delete words backwards with Alt+Backspace
keymap("i", "<A-BS>", "<C-W>")

------------
-- Visual --
------------

-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Move text up and down
keymap("v", "<A-j>", ":move '>+1<CR>gv=gv")
keymap("v", "J", ":move '>+1<CR>gv=gv")
keymap("v", "<A-k>", ":move '<-2<CR>gv=gv")
keymap("v", "K", ":move '<-2<CR>gv=gv")

-- keymap("v", "<C-_>", "<cmd>Commentary<CR>")
keymap("v", "<C-_>", "gc")

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
keymap('v', 'y', 'myy`hay')
keymap('v', 'Y', 'myY`y')

------------------
-- Visual Block --
------------------
-- Move text up and down
keymap("v", "<A-j>", ":move '>+1<CR>gv=gv")
keymap("v", "J", ":move '>+1<CR>gv=gv")
keymap("v", "<A-k>", ":move '<-2<CR>gv=gv")
keymap("v", "K", ":move '<-2<CR>gv=gv")


-- vim.cmd([[
-- " Git mappings
-- map <Leader>gs :Gstatus<CR>
-- map <Leader>gc :Git<CR>
-- map <Leader>gp :Git push<CR>
-- ]])
