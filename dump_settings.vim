" Dump the values of all settings that either sensible.vim or Neovim alters.
" Use as follows:
"    vim -c 'source dump_union_settings.vim|write out.txt|quit'
" The idea is to generate dumps from both Vim and Neovim and compare them and
" eliminate differences to create a more consistent experience.
function Out()
filetype
if has('syntax') && exists('g:syntax_on')
  echo "syntax: " . g:syntax_on
else
  echo "syntax: 0"
endif
colorscheme

" See :help nvim-defaults for a list
set autoindent?
set autoread?
set background?
set backspace?
set backupdir?
set belloff?
set comments?
set commentstring?
set compatible?
set complete?
if exists('+cscopeverbose')
  set cscopeverbose?
else
  echo "Does not have cscopeverbose support"
endif
set define?
set directory?
set display?
set encoding?
set fillchars?
set formatoptions?
set fsync?
set grepprg
set guicursor?
set hidden?
set history?
set hlsearch?
set include?
set incsearch?
set isfname
set joinspaces?
set jumpoptions?
set langmap?
set langnoremap?
set langremap?
set laststatus?
set listchars?
set mouse?
set mousemodel?
set nocompatible?
set nrformats?
set path?
set ruler?
set scrolloff?
set sessionoptions?
set shell?
set shortmess?
set showcmd?
set sidescroll?
set sidescrolloff?
set smarttab?
if exists('+smoothscroll')
  set smoothscroll?
else
  echo 'Does not have smoothscroll support'
endif
set startofline?
set switchbuf?
set tabpagemax?
set tags?
set termguicolors?
set ttimeout?
set ttimeoutlen?
set ttyfast?
set undodir?
set viewoptions?
set viminfo?
set wildmenu?
set wildoptions?

nmap Y
imap <C-U>
imap <C-W>
nmap <C-L>
nmap &
xmap Q
xmap @
xmap #
xmap *
nmap gc
xmap gc
nmap gcc
nmap [d
nmap ]d
nmap <C-W>d

map

autocmd nvim_terminal
autocmd nvim_cmdwin
autocmd nvim_swapfile
autocmd vimStartup
autocmd vimHints

echo "t_Co=" . &t_Co
if exists('c_comment_strings')
  echo "c_comment_strings = " . c_comment_strings
else
  echo "c_comment_strings does not exist"
endif
if exists('b:editorconfig')
  echo "editorconfig is enabled"
else
  echo "editorconfig is disabled"
endif
echo "man: " . exists(':Man')
if exists('g:loaded_matchit')
  echo "matchit: " . g:loaded_matchit
else
  echo "matchit: 0"
endif
if exists('g:vimsyn_embed')
  echo "vimsyn_embed: " . g:vimsyn_embed
else
  echo "vimsyn_embed: does not exist"
endif
if exists('g:is_posix')
  echo "is_posix: " . g:is_posix
else
  echo "is_posix: does not exist"
endif

if maparg('Q', 'n') ==# ''
  if has('nvim')
    echo "Q replays the last recorded macro"
    echo "gQ switches to Ex mode"
  else
    echo "Q switches to Ex mode"
  endif
else
  nmap Q
endif

command DiffOrig

endfunction

redir @a
silent call Out()
redir END
put a

" Remove blank lines
global/^$/d
