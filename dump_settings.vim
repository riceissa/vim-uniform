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

" Both Vim and Neovim try to detect the terminal background color, but I think
" they do so in different ways because they differ by default. It makes no
" sense to pick one or the other, and I don't think there is a way to reliably
" detect the color, so I'm just going to leave this one to the vimrc.
" set background?

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
  echo "nocscopeverbose"
endif
set define?
set diffopt?
set directory?
set display?
set encoding?
set equalalways?

" This option differs, but it's a visual difference and I don't really feel
" like adding the Unicode fillchars to the Vim version, so I think I'm just
" going to leave it alone.
" set fillchars?

set formatoptions?
set fsync?

" For some reason Neovim doesn't print the trailing whitespace, so we append a
" visible character at the end to make the diff nicer.
echo "grepprg=" . &grepprg . "|"
set grepformat?

set guicursor?
set hidden?
set history?
set hlsearch?
set ignorecase?

" Vim has no inccommand option, so commenting this out as unfixable.
" if exists('+inccommand')
"   set inccommand?
" else
"   echo "noinccommand"
" endif

set include?
set incsearch?
set isfname
set joinspaces?

" I think Neovim's default of jumpoptions=clean makes the most sense. However,
" Vim doesn't support it (yet). So there's no point in forcing consistency
" here.
" set jumpoptions?

set keywordprg?
set langmap?
set langnoremap?
set langremap?
set laststatus?
set list?
set listchars?
set modeline?
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
set smartcase?
set smarttab?
if exists('+smoothscroll')
  set smoothscroll?
else
  echo 'Does not have smoothscroll support'
endif
set spellfile?
set startofline?
set suffixes?
set switchbuf?
set tabpagemax?
set tags?
set termguicolors?
set ttimeout?
set ttimeoutlen?
set ttyfast?
set undodir?
set viewoptions?
echo "viminfo/shada=" . &viminfo
set wildmenu?
set wildoptions?

nmap Y
imap <C-U>
imap <C-W>
nmap <C-L>
nmap &

" Vim doesn't seem to have a reg_recorded() function, so there is no way to
" query for the last recorded macro. This means Neovim's default mapping
" cannot be done in Vim.
" xmap Q

xmap @
xmap #
xmap *
nmap gc
xmap gc
nmap gcc

nmap grn
nmap grr
nmap gri
nmap gO
nmap gra
imap <C-S>
smap <C-S>

nmap [q
nmap ]q
nmap [Q
nmap ]Q
nmap [<C-Q>
nmap ]<C-Q>
nmap [l
nmap ]l
nmap [L
nmap ]L
nmap [<C-L>
nmap ]<C-L>
nmap [t
nmap ]t
nmap [T
nmap ]T
nmap [<C-T>
nmap ]<C-T>
nmap [a
nmap ]a
nmap [A
nmap ]A
nmap [b
nmap ]b
nmap [B
nmap ]B
nmap [<Space>
nmap ]<Space>
nmap [[
nmap ]]
nmap <Tab>
nmap <S-Tab>

" I'm not even sure what a 'diagnostic' is (the docs never explain it; see
" :help ]d-default in nvim), so I'm commenting this stuff out for now.
" nmap [d
" nmap ]d
" nmap <C-W>d

" This will show all defined maps, but includes a lot of potentially junk.
" map

" let augroups = ['nvim_terminal', 'nvim_cmdwin', 'nvim_swapfile', 'vimStartup', 'vimHints']
let augroups = ['vimStartup', 'vimHints']
for augroup in augroups
  if exists('#' . augroup)
    exe 'autocmd ' . augroup
  else
    echo augroup . " augroup does not exist"
  endif
endfor

echo "t_Co=" . &t_Co
if exists('b:editorconfig') || exists('g:loaded_EditorConfig')
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

" I like Neovim's behavior better, but there is no way to get it in Vim since
" as I wrote above, Vim doesn't have a reg_recorded() function. So I'm
" commenting this stuff out as unfixable.
" if maparg('Q', 'n') ==# ''
"   if has('nvim')
"     echo "Q replays the last recorded macro"
"   else
"     echo "Q switches to Ex mode with some slight modifications"
"   endif
" else
"   nmap Q
" endif
" if maparg('gQ', 'n') ==# ''
"   if has('nvim')
"     echo "gQ switches to Ex mode"
"   else
"     echo "gQ switches to Ex mode"
"   endif
" else
"   nmap gQ
" endif

command DiffOrig

endfunction

redir @a
silent call Out()

" I don't know exactly why, but c_comment_strings is not visible inside of a
" function (some kind of scope problem, I think, where functions can only
" access g:-prefixed variables from the outside?), so we gotta run it out
" here.
if exists('c_comment_strings')
  echo "c_comment_strings = " . c_comment_strings
else
  echo "c_comment_strings does not exist"
endif

redir END
put a

" Remove blank lines
global/^$/d
