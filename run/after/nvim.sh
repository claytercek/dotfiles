#!/bin/bash

nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall

cp ~/.config/nvim/space.vim ~/.config/nvim/plugged/vim-airline-themes/autoload/airline/themes/space.vim
