#!/bin/sh

BASE=${PWD}

for x in $BASE/.??* ; do
    fname=$(basename $x)

    echo Linking ~/$fname to $x
    ln -sf $x $HOME/$fname
done
