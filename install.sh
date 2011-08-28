#!/bin/sh

BASE=${PWD}

for x in $BASE/.* ; do
  fname=$(basename $x)
  realdot=$fname

  echo Linking ~/$realdot to $x
  ln -sf $x $HOME/$realdot

done
