set nocompatible
filetype off
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'bling/vim-airline'
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

" Colorschemes
Plug 'w0ng/vim-hybrid'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'mhartington/oceanic-next'
Plug 'MaxSt/FlatColor'
Plug 'iCyMind/NeoSolarized'
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

colorscheme hybrid
set background=dark

augroup apache
    autocmd!
    autocmd BufNewFile,BufRead */etc/apache2*/extra/*.conf setfiletype apache
augroup END

augroup filetype_make
    autocmd!
    autocmd filetype make setlocal noexpandtab
augroup END

augroup filetype_python
    autocmd!
    " Trim trailing white spaces for Python files
    autocmd filetype python autocmd BufWritePre <buffer> :%s/\s\+$//e
augroup END

augroup filetype_html_xml
    autocmd!
    autocmd filetype html,xml set textwidth=0
augroup END

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
let g:python3_host_prog='/usr/local/bin/python3.8'

lua <<EOF
require'lspconfig'.pyright.setup{
    cmd = {"$HOME/neovim/node_modules/.bin/pyright-langserver", "--stdio" }
}

require'nvim-treesitter.configs'.setup {
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
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

let g:indent_blankline_use_treesitter = v:true
