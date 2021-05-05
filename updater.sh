#!/bin/bash

cd "${1}/${2}"
git pull >/dev/null 2>&1
makepkg -si
