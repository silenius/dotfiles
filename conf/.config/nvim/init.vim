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

" let g:indent_guides_color_change_percent = 5
" let g:indent_guides_enable_on_vim_startup=1

"let g:airline#extensions#ale#enabled = 1
"let g:ale_sign_error = '!E'
"let g:ale_sign_warning = '!W'
" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" :highlight NeomakeWarningMsg ctermfg=227 ctermbg=16
" :highlight NeomakeErrorMsg ctermfg=1 ctermbg=16
" let g:neomake_warning_sign={'text': '!W', 'texthl': 'NeomakeWarningMsg'}
" let g:neomake_error_sign={'text': '!E', 'texthl': 'NeomakeErrorMsg'}
" autocmd! BufWritePost * Neomake
"
let g:python3_host_prog='/usr/local/bin/python3.9'

set completeopt=menu,menuone,noselect

lua <<EOF

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

local opts = { noremap=true, silent=true }

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
}

require'lspconfig'.volar.setup{
    cmd = {'./node_modules/@volar/vue-language-server/bin/vue-language-server.js', '--stdio'},
    on_attach = on_attach,
    filetypes = {
        'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'
    }
}

vim.cmd[[colorscheme tokyonight-night]]

EOF


set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

let g:indent_blankline_use_treesitter = v:true


