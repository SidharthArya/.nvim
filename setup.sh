#!/usr/bin/env bash

# Verify if anaconda exists
# Python Setup
conda create -n neovim python=3.8
eval $(conda shell.sh activate neovim)
python -m pip install neovim

# Verify if ruby exists
# Verify if rvm is installed
# Verify if xcode exists
# Ruby
rvm use default
gem install neovim


# Node
# Verify if nvm is installed
nvm use default
npm install -g neovim
