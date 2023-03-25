#!/usr/bin/env bash
#
ARGS=$*

if [[ -f $ARGS ]];
then
  bat --color=always $ARGS
elif [[ -d $ARGS ]];
then 
  tree $ARGS
else
  echo Create file $ARGS
fi
