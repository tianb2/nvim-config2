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

-- treesitter for syntax highlighting
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

Plug('voldikss/vim-floaterm')

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
vim.opt.cinoptions = "l1" -- fix some indentation in c++ https://stackoverflow.com/a/3445040

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
    theme = "auto",
    disabled_filetypes = { "nerdtree" },
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
  'coc-html',
  'coc-eslint',
  'coc-prettier',
  'coc-sumneko-lua',
  'coc-rust-analyzer',
  'coc-clangd',
  'coc-solargraph',
  'coc-pyright',
  '@yaegassy/coc-volar'
}
require('coc_defaults')
-- consider words with dashes when doing completion
-- with the buffer source
vim.api.nvim_create_autocmd('FileType', {
  pattern = { '*' },
  callback = function()
    vim.b.coc_additional_keywords = { '-' }
  end
})

-- telescope
vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files)
vim.keymap.set('n', '<C-g>', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<C-f>', require('telescope.builtin').buffers)

-- treesitter
require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = {
    "c",
    "lua",
    "vim", "vimdoc",
    "markdown",
    "rust",
    "cpp",
    "javascript", "typescript",
    "json",
    "ruby",
    "python",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- floaterm
vim.keymap.set('n', '<C-t>', ':FloatermToggle<CR>')
vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:FloatermToggle<CR>', { noremap = true, silent = true })

-- vue workspace root
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vue",
  callback = function()
    vim.b.coc_root_patterns = {
      ".git", ".env", "package.json", "tsconfig.json", "jsconfig.json",
      "vite.config.ts", "vite.config.js", "vue.config.js", "nuxt.config.ts"
    }
  end,
})

-- utils
-- insert iso date string
vim.keymap.set("n", "<leader>dt", function()
  local ts = os.date("!%Y-%m-%dT%H:%M:%S.")
  local ms = math.floor(vim.loop.hrtime() / 1e6) % 1000
  local full = ts .. string.format("%03dZ", ms)
  vim.api.nvim_put({ full }, "c", true, true)
end)
