# uniform.vim

The goal of uniform.vim is to set any option that stock Vim, Neovim,
sensible.vim, and defaults.vim might disagree on. So no matter which of
Vim/Neovim you use, and whether you sourced [sensible.vim](https://github.com/tpope/vim-sensible) or [defaults.vim](https://github.com/vim/vim/blob/master/runtime/defaults.vim), your
Vim should behave the same.
It can be thought of as an analogue to [Normalize.css](https://necolas.github.io/normalize.css/).

Caveats:

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
  want to change, or you can just copy uniform.vim and use it as a template,
  and change stuff you want to change.

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
  modifications to show the fileformat (unix, dos, etc.)) while others are a
  bad idea (distros should not be changing settings like `ruler` now that
  `defaults.vim` exists).
