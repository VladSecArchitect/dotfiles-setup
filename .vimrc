" Disable compatibility mode to use modern Vim features
set nocompatible

" Enable syntax highlighting
syntax on

" Enable line numbers
set number
set relativenumber         " Show relative line numbers for easy navigation

" Highlight matching parentheses
set showmatch

" Enable mouse support
set mouse=a

" Use spaces instead of tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4          " Matches tabstop for consistent behavior

" Enable search highlighting
set hlsearch
set incsearch
set ignorecase             " Ignore case in search patterns
set smartcase              " Override ignorecase if search pattern contains uppercase

" Persistent undo (requires Vim compiled with +persistent_undo)
if has("persistent_undo")
    set undodir=~/.vim/undodir
    set undofile
endif

" Better colorscheme support
set termguicolors          " Enables 24-bit RGB colors

" Auto-indent new lines
set autoindent
set smartindent

" Faster scrolling
set lazyredraw
set scrolloff=5            " Keep 5 lines visible above/below the cursor

" Disable backup and swap files
set nobackup
set noswapfile
set nowritebackup          " Disable temporary write backup files

" Set default encoding
set encoding=utf-8

" Status line enhancements
set laststatus=2           " Always show the status line
set ruler                  " Show cursor position in the status line

" Better split behavior
set splitbelow             " New horizontal splits appear below the current window
set splitright             " New vertical splits appear to the right

" Map Ctrl+S to save the current file
nnoremap <C-s> :w<CR>       " Normal mode: Save file
inoremap <C-s> <Esc>:w<CR>  " Insert mode: Save file and exit insert mode
vnoremap <C-s> <Esc>:w<CR>  " Visual mode: Save file and exit visual mode

" Map leader key for convenience
let mapleader=" "          " Set the leader key to space
nnoremap <leader>w :w<CR>   " Save file with <leader>w
nnoremap <leader>q :q<CR>   " Quit with <leader>q

" Clipboard support (requires +clipboard support in Vim)
set clipboard=unnamedplus  " Use system clipboard for copy-paste

" Disable annoying sounds
set noerrorbells
set novisualbell

" Faster timeout for mapped sequences
set timeoutlen=500         " Reduce key sequence timeout to 500ms

" Colorscheme (replace 'desert' with your preferred colorscheme)
colorscheme desert

" Auto-create undodir if it doesn't exist
if !isdirectory($HOME."/.vim/undodir")
    call mkdir($HOME."/.vim/undodir", "p")
endif
