set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'altercation/vim-colors-solarized'
call vundle#end()
syntax on
filetype plugin indent on
set hlsearch
set showmatch
set showmode
set cursorline
set cursorcolumn
set ruler
set wrap
set number
set numberwidth=4
set background=dark
set history=50
set undolevels=50
set textwidth=79
set colorcolumn=+1
set laststatus=2
set report=0
set autoindent
set modeline
set t_Co=256
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.

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
    set guifont=Tixus
    set guioptions=aegimt

    colorscheme lucius

    highlight CursorLine guibg=Grey20 term=NONE cterm=NONE gui=NONE
    highlight CursorColumn guibg=Grey20 term=NONE cterm=NONE gui=NONE
endif

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
