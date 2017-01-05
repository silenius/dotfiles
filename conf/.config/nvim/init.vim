set nocompatible
filetype off
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-plug'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'bling/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'w0ng/vim-hybrid'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-fugitive'
Plug 'hynek/vim-python-pep8-indent'
Plug 'saltstack/salt-vim'
Plug 'rking/ag.vim'
Plug 'scrooloose/syntastic'
Plug 'rust-lang/rust.vim'
Plug 'haproxy'
Plug 'airblade/vim-gitgutter'
Plug 'icinga/icinga2'
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

let g:indent_guides_color_change_percent = 5
let g:indent_guides_enable_on_vim_startup=1

if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 0
else
    let g:ctrlp_user_command = 'find %s -not -path "*/\.*" -type f -exec grep -Iq . {} \; -and -print'
endif

autocmd! BufWritePost * Neomake
