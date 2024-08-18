local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('neoclide/coc.nvim', { branch = 'release' })

-- file explorer
Plug('preservim/nerdtree')

-- git integration
Plug('tpope/vim-fugitive')
-- fugitive :GB command
Plug('tpope/vim-rhubarb')

-- colorscheme
Plug('neanias/everforest-nvim', { branch = 'main' })

Plug('windwp/nvim-autopairs')

Plug('nvim-lualine/lualine.nvim')
Plug('nvim-tree/nvim-web-devicons')

-- fuzzy search
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope-fzf-native.nvim', {
  ['do'] = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
})
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.8' })

Plug('iamcco/markdown-preview.nvim', {
  ['do'] = 'cd app && npx --yes yarn install' }
)

vim.call('plug#end')

-- options
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "yes"   -- always show the signcolumn to prevent shifting
vim.opt.smartindent = true
vim.opt.termguicolors = true -- true color

-- keymaps
vim.g.mapleader = ","
vim.keymap.set('n', '<leader>w', ':w<CR>') -- <leader> + w to write
vim.keymap.set('i', 'jj', '<Esc>')         -- jj to escape

vim.keymap.set('n', '<C-h>', '<C-w>h')     -- easier navigation
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- nerdtree
vim.keymap.set('n', '<C-k><C-n>', ':NERDTreeToggle<CR>')
vim.keymap.set('n', '<C-k><C-e>', ':NERDTreeFind<CR>')
vim.g.NERDTreeShowHidden = 1 -- show hidden files by default

-- everforest
local everforest = require('everforest')
everforest.setup({
  background = "hard"
})
everforest.load()

-- lualine
require('lualine').setup({
  options = {
    theme = "auto"
  }
})

-- autopairs
require('nvim-autopairs').setup {
  map_cr = false
}

-- coc
vim.g.coc_global_extensions = {
  'coc-json',
  'coc-tsserver',
  'coc-css',
  'coc-eslint',
  'coc-prettier',
  'coc-sumneko-lua',
  'coc-rust-analyzer'
}
require('coc_defaults')

-- telescope
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files)
vim.keymap.set('n', '<C-g>', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<C-f>', require('telescope.builtin').buffers)
