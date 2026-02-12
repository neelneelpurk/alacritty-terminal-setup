" --- Line Numbers ---
set number                " Show absolute line numbers
set numberwidth=4         " Width of the number column

" --- Indentation ---
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set autoindent smartindent

" --- Search ---
set incsearch hlsearch ignorecase smartcase

" --- UI ---
set cursorline            " Highlight current line
set scrolloff=8           " Keep 8 lines visible above/below cursor
set termguicolors         " True color support
set background=dark
syntax enable

" --- Status Line ---
set laststatus=2 showmode ruler showcmd
set wildmenu wildmode=list:longest

" --- Editing ---
set backspace=indent,eol,start
set clipboard=unnamed     " System clipboard
set mouse=a               " Full mouse support
set splitbelow splitright
set hidden

" --- Files ---
set noswapfile nobackup
set encoding=utf-8

" --- Key Mappings ---
let mapleader = " "
nnoremap <Esc> :nohlsearch<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" --- Inline Diff Panel (Leader+d to open, Leader+D to close) ---
" Opens a right-side panel showing diff of your unsaved edits vs saved file
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
nnoremap <leader>d :DiffOrig<CR>
nnoremap <leader>D :diffoff! \| only<CR>