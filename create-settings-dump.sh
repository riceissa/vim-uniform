#!/usr/bin/env bash

mkdir -p out

# /usr/bin/vim -u NONE -c 'source ~/sensible.vim' -c 'source dump_settings.vim|write! out/vim-none.txt|quit'
# /usr/bin/vim -Nu NORC -c 'source ~/sensible.vim' -c 'source dump_settings.vim|write! out/vim-norc.txt|quit'
# /usr/bin/vim --clean -c 'source ~/sensible.vim' -c 'source uniform.vim' -c 'source dump_settings.vim|write! out/vim-clean-sensible.txt|quit'


/usr/bin/vim -Nu NONE -c 'source uniform.vim' -c 'source ~/.vim/plugged/vim-commentary/plugin/commentary.vim' -c 'source ~/.vim/plugged/vim-visual-star-search/plugin/visual-star-search.vim' -c 'source dump_settings.vim|write!|quit' out/vim-nu-none.txt
nvim --clean -c 'source uniform.vim' -c 'source ~/.vim/plugged/vim-commentary/plugin/commentary.vim' -c 'source ~/.vim/plugged/vim-visual-star-search/plugin/visual-star-search.vim' -c 'source dump_settings.vim|write!|quit' out/nvim.txt
