set nocompatible
filetype off
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
"Plug 'bling/vim-airline'
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
"Plug 'nathanaelkane/vim-indent-guides'
"Plug 'pangloss/vim-javascript'
"Plug 'tpope/vim-fugitive'
"Plug 'hynek/vim-python-pep8-indent'
"Plug 'saltstack/salt-vim'
"Plug 'rust-lang/rust.vim'
"Plug 'airblade/vim-gitgutter'
"Plug 'dense-analysis/ale'
"Plug 'mattn/emmet-vim'
"Plug 'nginx/nginx', { 'rtp': 'contrib/vim' }
"Plug 'icinga/icinga2', { 'rtp': 'tools/syntax/vim' }
"Plug 'lukas-reineke/indent-blankline.nvim'


" Autocompletion
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'hrsh7th/cmp-buffer'
"Plug 'hrsh7th/cmp-path'
"Plug 'hrsh7th/cmp-cmdline'
"Plug 'hrsh7th/nvim-cmp'
"Plug 'hrsh7th/cmp-vsnip'
"Plug 'hrsh7th/vim-vsnip'

" Colorschemes
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
call plug#end()


syntax on
filetype plugin indent on
set hlsearch
set showmatch
set showmode
set nocursorline
set nocursorcolumn
set ruler
set wrap
set number
set numberwidth=4
set history=50
set undolevels=50
set textwidth=79
set colorcolumn=+1
set laststatus=2
set report=0
set autoindent
set modeline
set t_Co=256
set backupdir=~/.vim/tmp
set directory=~/.vim/tmp
set wildmenu
set wildmode=full
set wildignore+=*.pyc,*.pyo,*.egg,*.egg-info
set wildignore+=*.swp
set wildignore+=*.so

" TAB SETTINGS
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" ENCODING
set encoding=utf-8
set termencoding=utf-8

set background=dark

autocmd BufRead *.vue setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd BufRead *.sls setlocal syntax=yaml tabstop=2 softtabstop=2 shiftwidth=2

imap <c-d> <esc>ddi
map! <esc>[7~ <Home>
map! <esc>[8~ <End>
map <esc>[7~ <Home>
map <esc>[8~ <End>
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

noremap <C-X> "+x
noremap <C-X> "+y
map <C-V> "+gP
imap <C-V> <Esc>"+gPa


" :highlight NeomakeWarningMsg ctermfg=227 ctermbg=16
" :highlight NeomakeErrorMsg ctermfg=1 ctermbg=16
" let g:neomake_warning_sign={'text': '!W', 'texthl': 'NeomakeWarningMsg'}
" let g:neomake_error_sign={'text': '!E', 'texthl': 'NeomakeErrorMsg'}
" autocmd! BufWritePost * Neomake
"
let g:python3_host_prog='/usr/local/bin/python3.9'

set completeopt=menu,menuone,noselect

lua <<EOF

require('gitsigns').setup()

require'lualine'.setup{
    options = { 
        theme = 'tokyonight-night',
        section_separators = '', component_separators = '',
    },
    extensions = {
        'fzf'
    }
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "vue", "rust", "html", "yaml", "css", "sql" },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  }
}

-- Setup language servers.
local lspconfig = require('lspconfig')

lspconfig.pyright.setup {}

local vue_language_server_path = './node_modules/@vue/language-server'

lspconfig.tsserver.setup {
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
      },
    },
  },
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}

-- No need to set `hybridMode` to `true` as it's the default value
lspconfig.volar.setup {}

lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

vim.cmd[[colorscheme tokyonight-night]]

EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

let g:indent_blankline_use_treesitter = v:true
