if exists('g:loaded_uniform')
  finish
else
  let g:loaded_uniform = 'yes'
endif

" From defaults.vim (including comment):
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" From defaults.vim and sensible.vim (comment from defaults.vim):
" This must be first, because it changes other options as a side effect.
" Avoid side effects when it was already reset.
if &compatible
  set nocompatible
endif

" From defaults.vim (including comment):
" When the +eval feature is missing, the set command above will be skipped.
" Use a trick to reset compatible only when the +eval feature is missing.
silent! while 0
  set nocompatible
silent! endwhile

" From defaults.vim and sensible.vim
set ruler
if has('reltime')
  set incsearch
endif

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
if has('nvim') || v:version >= 900
  set wildoptions=pum,tagfile
endif
silent! while 0
  silent! set wildoptions=pum,tagfile
silent! endwhile

" From defaults.vim and sensible.vim
set ttimeout
" Both defaults.vim and sensible.vim use 100, but I prefer Neovim's default
" value of 50. This makes the escape key more responsive.
if (&ttimeoutlen < 0) || (&ttimeoutlen > 50)
  set ttimeoutlen=50
endif
" The above conditional does not work in vim-tiny, so we use a trick to force
" ttimeoutlen to 50 for vim-tiny.
silent! while 0
  set ttimeoutlen=50
silent! endwhile

" Both defaults.vim and sensible.vim try to set this to truncate, but I prefer
" Neovim's default of lastline because truncate seems to waste a whole line of
" space just to put the "@@@" marker at the left side of the screen.
set display=lastline

" Both defaults.vim and sensible.vim try to set this to a positive number, but
" I prefer Neovim's default of 0.
set scrolloff=0

" For consistency with scrolloff.
set sidescrolloff=0

" From sensible.vim (including the comment):
" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^Eterm'
  set t_Co=16
endif

" From defaults.vim (including the comment): Do not recognize octal numbers
" for Ctrl-A and Ctrl-X, most users find it confusing.
set nrformats-=octal

" From sensible.vim. Break the undo sequence before CTRL-U and CTRL-W
if empty(mapcheck('<C-U>', 'i'))
  inoremap <C-U> <C-G>u<C-U>
endif
if empty(mapcheck('<C-W>', 'i'))
  inoremap <C-W> <C-G>u<C-W>
endif

" Use Neovim's default of maximum history. There's no reason to keep any less
" on a modern computer. The conditional is future-proofing in case the maximum
" allowed value increases in the future.
if &history < 10000
  set history=10000
endif
" The above conditional does not work in vim-tiny, so we use a trick to force
" the value for vim-tiny.
silent! while 0
  set history=10000
silent! endwhile

if &tabpagemax < 50
  set tabpagemax=50
endif
" The above conditional does not work in vim-tiny, so we use a trick to force
" the value for vim-tiny.
silent! while 0
  set tabpagemax=50
silent! endwhile

" From Neovim. Set silently so that it works for old Neovim versions.
silent! set switchbuf=uselast

set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
" Check to make this work on vim-tiny without errors (vim-tiny does not have
" +eval).
if 1
  " Check from
  " <https://github.com/tpope/vim-sensible/commit/38fea1c9356d46cc285f67c9f8e7bc3ba39fc0be>
  let s:use_unicode = !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
  if s:use_unicode
    let &listchars = "tab:\u25b8 ,trail:\u00b7,extends:\u2192,precedes:\u2190,nbsp:\u00b7"
  endif
endif

" Most searches are for navigation; some are to find something or all of
" something. It's only the last kind of search that benefits from highlighting
" the matches, and in the other two cases it's just very distracting to have a
" bunch of stuff getting highlighted.
set nohlsearch

set nojoinspaces
set belloff=all

" This is the Vim default
if has('unix')
  set path=.,/usr/include,,
endif
set define=^\\s*#\\s*define
set include=^\\s*#\\s*include

" Neovim uses 'rg --vimgrep -uu ' but I see no reason why I would ever want to
" search inside of directories like .git; ripgrep's smart filtering is there
" by default for a reason.
if executable('rg')
  let &grepprg='rg --vimgrep '
  set grepformat=%f:%l:%c:%m
endif

" I like that nohidden forces you to always save your buffers before making
" them invisible, but nohidden also forgets the undo history when the buffer
" becomes invisible, which is a huge pain (maybe there's a way to get
" persistent history without hidden, but I think this shows that hidden does
" something useful, so I'm keeping it).
set hidden

if has('mouse')
  set mouse=nv
endif
" The above conditional does not work in vim-tiny, so we use a trick to force
" the value for vim-tiny.
silent! while 0
  silent! set mouse=nv
silent! endwhile

set autoindent
set startofline

nnoremap Y y$

nnoremap & :&&<CR>

" From Neovim (but sensible.vim) has something similar.
" vim-tiny doesn't have nohlsearch so guard it with a conditional
if exists(':nohlsearch') && exists(':diffupdate') && exists(':normal')
  nnoremap <C-L> <Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>
endif

" From Neovim
if exists('*reg_recorded')
  xnoremap <expr> Q mode() ==# 'V' ? ':normal! @<C-R>=reg_recorded()<CR><CR>' : 'Q'
endif
xnoremap <expr> @ mode() ==# 'V' ? ':normal! @'.getcharstr().'<CR>' : '@'

" By default, Vim sets the swap directory to the same directory as the file
" being edited, which is a security risk when editing files on a server (e.g.
" if one is editing a MediaWiki LocalSettings.php file on a server, then
" anyone can navigate to the public URL for the MediaWiki and access
" LocalSettings.php.swp and download potentially sensitive data like the
" database password). The same is true for the backupdir as well (though Vim
" doesn't turn on backups by default so this is only a problem if one enables
" that setting). I think the same is true for undodir, but I haven't looked
" into it.
if !(has('win64') || has('win32'))
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
" The above conditional does not work in vim-tiny, so we use a trick to force
" the value for vim-tiny.
silent! while 0
  silent! setglobal tags=./tags;,tags
silent! endwhile

" Neovim adds the unicode bullet, but I think this is a bad idea. Once you
" allow one Unicode character, it sets you up for adding more and more of them
" and the work seems endless.
set comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-

set mousemodel=popup_setpos

" TODO: look through each letter more carefully. I made one mistake where I
" really like seeing the count messages when searching, but I had put S in
" here.
set shortmess=filnxtToO
" The C flag is not available in old Vim/Neovim versions. Instead of trying to
" figure out the exact versions in which the flag becomes available, I have
" decided to just try to set it silently. This way it will automatically work
" on Vim installations without the +eval feature too.
silent! set shortmess+=C

set commentstring=
set sidescroll=1

" From debian.vim: "modelines have historically been a source of
" security/resource vulnerabilities -- disable by default, even when
" 'nocompatible' is set". Also, I feel modelines were mainly useful back
" before EditorConfig was a thing, but now we have EditorConfig which I think
" solves the same problem in a better way.
" set nomodeline
" However, on Windows, nvim-qt can't detect the filetype of Vim help pages
" (which have a .txt extension) for some reason (despite having the same
" version as the Nvim on my WSL), so I'm going to leave modeline on for now,
" and hope that this gets fixed in the future.
set modeline

" From sensible.vim (Neovim also has this by default, but logic and comment
" are from sensible.vim):
" Persist g:UPPERCASE variables, used by some plugins, in .viminfo.
if !empty(&viminfo)
  set viminfo^=!
endif

" From sensible.vim (including the comment):
" Delete comment character when joining commented lines.
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif
" The above conditional does not work in vim-tiny, so we use a trick to force
" the value for vim-tiny.
silent! while 0
  silent! set formatoptions+=j
silent! endwhile

" From sensible.vim (including the comment):
" Disable completing keywords in included files (e.g., #include in C).  When
" configured properly, this can result in the slow, recursive scanning of
" hundreds of files of dubious relevance.
set complete-=i

" From defaults.vim
if has('langmap') && exists('+langremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If set (default), this may break plugins (but it's backward
  " compatible).
  set nolangremap
endif

" In Git Bash, the jump from showmatch pauses text insertion so some
" characters get lost if I type too quickly. It turns out in Git Bash the file
" /etc/vimrc is read, which turns on showmatch. I am turning off visualbell as
" well because I find it really annoying and for some reason Git Bash's
" /etc/vimrc sets that.
set noshowmatch
set novisualbell
" Newer versions of Git Bash also set this option to something awful, so reset
" it to the Vim/Neovim default.
set wildmode=full
" Git Bash's /etc/vimrc sets this to unnamed, which I don't like, so reset it
" to the Vim/Neovim default.
set clipboard=

" From sensible.vim (including the comment):
" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" From sensible.vim (including the comment):
" Enable the :Man command shipped inside Vim's man filetype plugin.
if exists(':Man') != 2 && !exists('g:loaded_man') && &filetype !=? 'man' && !has('nvim')
  runtime ftplugin/man.vim
  setglobal keywordprg=:Man
endif

if !has('nvim')
  silent! packadd editorconfig
endif

" Modified from defaults.vim:
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
" See :help :DiffOrig for more information.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" Correctly highlight $() and other modern affordances in filetype=sh.
if !exists('g:is_posix') && !exists('g:is_bash') && !exists('g:is_kornshell') && !exists('g:is_dash')
  let g:is_posix = 1
endif

" defaults.vim sets c_comment_strings=1 to highlight strings (and numerical
" constants?) inside C comments. It turns out I don't really like this (it is
" kind of distracting to have random bits of stuff be a different color in
" comments), so turn it off.
unlet! c_comment_strings

" Comment and "if 1" check from defaults.vim.
" Only do this part when Vim was compiled with the +eval feature.
if 1
  " From sensible.vim:
  if !(exists('g:did_load_filetypes') && exists('g:did_load_ftplugin') && exists('g:did_indent_on'))
    filetype plugin indent on
  endif
  if has('syntax') && !exists('g:syntax_on')
    syntax enable
  endif

  " Modified from defaults.vim:
  augroup vimStartup
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim), for a commit or rebase message
    " (likely a different one than last time), and when using xxd(1) to filter
    " and edit binary files (it transforms input files back and forth, causing
    " them to have dual nature, so to speak) or when running the new tutor
    autocmd BufReadPost *
      \ let line = line("'\"")
      \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
      \      && index(['xxd', 'gitrebase', 'tutor'], &filetype) == -1
      \ |   execute "normal! g`\""
      \ | endif
  augroup END

  " Reset this augroup because I don't want the hint to show up every time.
  augroup vimHints
    autocmd!
  augroup END
endif
