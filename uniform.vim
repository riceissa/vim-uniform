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

" From sensible.vim and Neovim
set autoread
set backspace=indent,eol,start
set laststatus=2
set wildmenu
set smarttab
set sessionoptions-=options
set viewoptions-=options

" From Neovim
set wildoptions=pum,tagfile

" From defaults.vim and sensible.vim
set ttimeout
" Both defaults.vim and sensible.vim use 100, but I prefer Neovim's default
" value of 50
if (&ttimeoutlen < 0) || (&ttimeoutlen > 50)
  set ttimeoutlen=50
endif

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

" Use Neovim's default of maximum history. There's no reason to keep any less
" on a modern computer.
if &history < 10000
  set history=10000
endif

if &tabpagemax < 50
  set tabpagemax=50
endif

" From Neovim
set switchbuf=uselast

" Check from
" <https://github.com/tpope/vim-sensible/commit/38fea1c9356d46cc285f67c9f8e7bc3ba39fc0be>
let s:use_unicode = !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
if s:use_unicode
  let &listchars = "tab:\u25b8 ,trail:\u00b7,extends:\u2192,precedes:\u2190,nbsp:\u00b7"
else
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

" Most searches are for navigation; some are to find something or all of
" something. It's only the last kind of search that benefits from highlighting
" the matches, and in the other two cases it's just very distracting to have a
" bunch of stuff getting highlighted.
set nohlsearch

set nojoinspaces
set belloff=all

" Might change this if it's too annoying
set nohidden

if has('mouse')
  set mouse=nv
endif

set autoindent
set startofline

nnoremap Y y$

nnoremap & :&&<CR>

nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>

" By default, Vim sets the swap directory to the same directory as the file
" being edited, which is a security risk when editing files on a server (e.g.
" if one is editing a MediaWiki LocalSettings.php file on a server, then
" anyone can navigate to the public URL for the MediaWiki and access
" LocalSettings.php.swp and download potentially sensitive data like the
" database password). The same is true for the backupdir as well (though Vim
" doesn't turn on backups by default so this is only a problem if one enables
" that setting). I think the same is true for undodir, but I haven't looked
" into it.
if !has('win64')
  if !isdirectory(expand('~/.vim/backup'))
    call mkdir(expand('~/.vim/backup'), 'p')
  endif
  set backupdir=~/.vim/backup//
  if !isdirectory(expand('~/.vim/swap'))
    call mkdir(expand('~/.vim/swap'), 'p')
  endif
  set directory=~/.vim/swap//
  if !isdirectory(expand('~/.vim/undo'))
    call mkdir(expand('~/.vim/undo'), 'p')
  endif
  set undodir=~/.vim/undo//
endif

if has('path_extra')
  setglobal tags=./tags;,tags
endif

" Neovim adds the unicode bullet, but I think this is a bad idea. Once you
" allow one Unicode character, it sets you up for adding more and more of them
" and the work seems endless.
set comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-

set mousemodel=popup_setpos
set shortmess=filnxtToOSC
set commentstring=
set sidescroll=1

" From defaults.vim
if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

filetype plugin indent on
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif
