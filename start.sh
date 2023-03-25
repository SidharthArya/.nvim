#!/usr/bin/env bash

ARGS=$*

if [[ -z $CONDA_PREFIX ]];
then
  eval $(conda shell.bash activate neovim)
fi
nvim $ARGS
