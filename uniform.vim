" From defaults.vim and sensible.vim
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" From defaults.vim and sensible.vim
set ruler
" From defaults.vim
set showcmd

" From defaults.vim and sensible.vim
set ttimeout
" Both defaults.vim and sensible.vim use 100, but I prefer Neovim's default
" value of 50
set ttimeoutlen=50

" Both defaults.vim and sensible.vim try to set this to truncate, but I prefer
" Neovim's default of lastline
set display=lastline

" Both defaults.vim and sensible.vim try to set this to a positive number, but
" I prefer Neovim's default of 0
set scrolloff=0

" From defaults.vim and sensible.vim
if has('reltime')
  set incsearch
endif

" From defaults.vim: Do not recognize octal numbers for Ctrl-A and Ctrl-X,
" most users find it confusing.
set nrformats-=octal

" From sensible.vim. Break the undo sequence before CTRL-U and CTRL-W
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>
