#!/usr/bin/env bash

/usr/bin/vim -u NONE -c 'source dump_settings.vim|write! out/vim-none.txt|quit'
/usr/bin/vim -Nu NORC -c 'source dump_settings.vim|write! out/vim-norc.txt|quit'
/usr/bin/vim --clean -c 'source dump_settings.vim|write! out/vim-clean.txt|quit'
nvim --clean -c 'source dump_settings.vim|write! out/nvim.txt|quit'
