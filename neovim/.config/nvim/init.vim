hi Normal guibg=none

set nocompatible

call plug#begin()

Plug 'sheerun/vim-polyglot'

call plug#end()

set clipboard=unnamedplus

autocmd FileType gitcommit setlocal colorcolumn=51,73
