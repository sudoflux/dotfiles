" Neovim basic configuration

" General Settings
set number                  " Show line numbers
set relativenumber          " Show relative line numbers
set expandtab               " Use spaces instead of tabs
set tabstop=2               " 1 tab = 2 spaces
set shiftwidth=2            " Indent with 2 spaces
set softtabstop=2           " Tab key indent with 2 spaces 
set autoindent              " Auto-indent new lines
set smartindent             " Enable smart-indent
set smarttab                " Enable smart-tabs
set wrap                    " Wrap lines
set linebreak               " Break lines at word
set showmatch               " Highlight matching brackets
set hlsearch                " Highlight all search results
set incsearch               " Show search results as you type
set ignorecase              " Case insensitive searching
set smartcase               " Case-sensitive when search contains an uppercase character
set cursorline              " Highlight current line
set scrolloff=8             " Start scrolling before reaching the bottom/top of the screen
set sidescrolloff=8         " Start scrolling horizontally before reaching the side of the screen
set mouse=a                 " Enable mouse for all modes
set clipboard=unnamedplus   " Use system clipboard
set encoding=utf-8          " Set default encoding
set fileencoding=utf-8      " Set file encoding
set termguicolors           " Enable true color support
set hidden                  " Allow hiding buffers with unsaved changes
set nobackup                " No backup files
set nowritebackup           " No backup files during editing
set noswapfile              " No swap file
set updatetime=300          " Faster completion
set timeoutlen=500          " Time to wait for a mapped sequence
set formatoptions-=cro      " Stop newline continuation of comments
set splitbelow              " Horizontal splits below current window
set splitright              " Vertical splits to right of current window
set showtabline=2           " Always show tabline
set signcolumn=yes          " Always show signcolumn
set wildmenu                " Command-line completion
set wildmode=longest:full,full " Complete the longest common string, then each full match
set completeopt=menuone,noinsert,noselect " Better completion experience
set shortmess+=c            " Don't show insert completion messages
set laststatus=2            " Always show statusline
set cmdheight=1             " Height of the command bar
set title                   " Change the terminal title
set noshowmode              " Don't show current mode in command-line
set spelllang=en_us         " Spell check language

" Basic Mappings
let mapleader = " "         " Set leader key to space

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Escape in terminal mode
tnoremap <Esc> <C-\><C-n>

" Clear search highlighting
nnoremap <leader>n :nohl<CR>

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>wq :wq<CR>

" Auto Commands
autocmd BufWritePre * :%s/\s\+$//e " Remove trailing whitespace on save

" This is a basic Neovim configuration. 
" To extend functionality, consider using plugins via a plugin manager like vim-plug.
" When you're ready to enhance this setup, uncomment the plugin section below and add desired plugins.

"" Plugin Section (vim-plug) - Commented out until needed
" call plug#begin('~/.local/share/nvim/plugged')
" 
" " Essential plugins to consider:
" " Plug 'tpope/vim-sensible'            " Sensible defaults
" " Plug 'tpope/vim-commentary'          " Comment code
" " Plug 'tpope/vim-surround'            " Manage surroundings
" " Plug 'jiangmiao/auto-pairs'          " Auto pair brackets/quotes
" " Plug 'nvim-lua/plenary.nvim'         " Dependency for many plugins
" " Plug 'nvim-telescope/telescope.nvim' " Fuzzy finder
" " Plug 'neovim/nvim-lspconfig'         " LSP configuration
" " Plug 'hrsh7th/nvim-cmp'              " Completion engine
" " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " Syntax
" " Plug 'folke/tokyonight.nvim'         " Theme
" " Plug 'kyazdani42/nvim-web-devicons'  " Icons
" " Plug 'kyazdani42/nvim-tree.lua'      " File explorer
" " Plug 'nvim-lualine/lualine.nvim'     " Status line
" 
" call plug#end()
" 
" " Plugin settings would go here
" 