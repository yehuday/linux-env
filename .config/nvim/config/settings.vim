
runtime! debian.vim
set nocompatible        " vim defaults, not vi!
set showmatch		" Show matching brackets.
set incsearch		" Incremental search
set hlsearch            " Higlight seatch results
set autowrite		" Automatically save before commands like :next and :make
set ruler
set number
set backspace=2
set tabstop=8           " show existing tab with 8 spaces width

if has('persistent_undo')      "check if your vim version supports it
  set undofile                 "turn on the feature
  set undodir=$HOME/.nvim/undo  "directory where the undo files will be stored
  set undolevels=1000
  set undoreload=1000
endif

if has("syntax")
  syntax on
endif

filetype on                             " automatic file type detection
filetype plugin on
filetype indent on

" Setup spell checker only for git commit windows
autocmd FileType gitcommit setlocal spell

" Show trailing whitespace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\| \+\ze\t/

"set ignorecase		" Do case insensitive matching
"set paste
"set shiftwidth=8	" when indenting with '>', use 8 spaces width
"set expandtab		" On pressing tab, insert 4 spaces
"set showcmd		" Show (partial) command in status line.
"set smartcase		" Do smart case matching
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
