set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'majutsushi/tagbar'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'w0ng/vim-hybrid'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-fugitive'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'saltstack/salt-vim'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/syntastic'
Plugin 'rust-lang/rust.vim'
Plugin 'haproxy'
Plugin 'airblade/vim-gitgutter'
Plugin 'Icinga/icinga2', {'rtp': 'tools/syntax/vim'}
call vundle#end()
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

" GUI
if has("gui_running")
    set list
    set listchars=eol:$,tab:>~
    set browsedir=buffer
    set guifont=Tixus\ 6
    set guioptions=aegimt
    set vb t_vb=
endif

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

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local"
endif
