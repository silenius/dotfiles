set nocompatible
filetype off
call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-plug'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'neovim/nvim-lspconfig'
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
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

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
let g:python3_host_prog='/usr/local/bin/python3.9'

set completeopt=menu,menuone,noselect

lua <<EOF

require'lualine'.setup{
    options = { 
        theme = 'gruvbox',
        section_separators = '', component_separators = '',
    },
    extensions = {
        'fzf'
    }
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


  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }





EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

let g:indent_blankline_use_treesitter = v:true


