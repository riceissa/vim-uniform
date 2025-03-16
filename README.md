# uniform.vim

The goal of uniform.vim is to set any option that stock Vim, Neovim,
[sensible.vim](https://github.com/tpope/vim-sensible), and
[defaults.vim](https://github.com/vim/vim/blob/master/runtime/defaults.vim)
might disagree on. So no matter which of Vim or Neovim you use, and whether you
sourced sensible.vim or defaults.vim, your Vim should behave the same. You can
think of it as an analog of
[Normalize.css](https://necolas.github.io/normalize.css/).

I made this plugin because I use multiple copies of Vim/Neovim on a daily
basis: inside of WSL I use Neovim as my main editor, but to develop stuff on
Windows I use Vim inside of Git Bash, and sometimes I open random files from
Windows Explorer, which opens in `nvim-qt`. Even though I was using the same
vimrc with the same plugins, these different copies of Vim still have subtly
different behavior (there's the Vim vs Neovim difference, but then also Git
Bash bundles its own `/etc/vimrc` file, and the Neovim versions inside of WSL
might not match that of `nvim-qt`) -- not enough to make things unusable, but
enough that I had some subtle frustration every time I encountered a small
difference.

## Installation

Install using your favorite package manager. For example, with vim-plug:

```vim
Plug 'riceissa/vim-uniform'
```

Or you can use Vim's built-in package support:

```bash
mkdir -p ~/.vim/pack/riceissa/start
cd ~/.vim/pack/riceissa/start
git clone https://github.com/riceissa/vim-uniform.git
# Might add documentation later, but for now there are now, so no need to run
# this final step:
# vim -u NONE -c "helptags vim-uniform/doc" -c q
```

## Caveats

- There are some options that I'm deliberately not touching; see the comments
  in `dump_settings.vim` for more information.

  - I care more about _behavior_ than _appearance_, so if it's complicated to
    make the appearance match, I will often just not put in the effort to do
    so.

  - Some stuff like the way `:terminal` behaves seems inherently different
    between Vim/Neovim, so for things like this I will just not try to match
    the behavior.

- I resolve the disagreements by setting the options to whatever I happen to
  prefer. You will probably disagree with me on at least some of the options.
  You can either use uniform.vim directly and then override the options you
  want to change in your vimrc, or you can just fork uniform.vim and use it as
  a template, and change stuff you want to change directly within your copy of
  uniform.vim.

- Some of the things that Neovim includes by default (in particular,
  commenting stuff with `gc` (see `:help gc-default`) and visual star (see
  `:help v_star-default`)) I think are best left to plugins, so for these I
  delegate to [commentary.vim](https://github.com/tpope/vim-commentary) and
  [visual-star-search.vim](https://github.com/nelstrom/vim-visual-star-search).
  So the more extended claim is that if you source uniform.vim followed by
  commentary.vim followed by visual-star-search.vim, then the behavior of
  various Vim setups will be as close as possible.

- Some Linux distributions come with their own Vim config files (e.g. Debian
  comes with `debian.vim`). I'm mostly not going to worry about these. I think
  some of these are a good idea (e.g. Git Bash on Windows comes with statusline
  modifications to show the fileformat (unix, dos, etc.), which really is
  useful on Git Bash since one could be dealing with both types of fileformats)
  while others are a bad idea (distros should not be changing settings like
  `ruler` now that defaults.vim exists).
