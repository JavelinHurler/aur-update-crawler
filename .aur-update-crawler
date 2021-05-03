#!/bin/bash

for dir in *
do
  if [ -d "$dir" ]
  then
    cd ${dir}
    git remote update
    git status --porcelain --branch -uno | grep -q "\[behind " && rofi -no-click-to-exit -e ${dir}
    cd ..
  fi
done
