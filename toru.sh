#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NOCOLOR='\033[0m'
AUR_DIR=~/Downloads/AUR/

function makepkg_si_and_clean {
    cd "${AUR_DIR}/${1}"
    git pull >/dev/null 2>&1
    makepkg -si
    git clean -xdf >/dev/null 2>&1
    cd "${AUR_DIR}"
}

function print_usage_error {
    echo -e "${RED}* Error : Wrong usage"
    echo -e "\tEnter usage as argument for instructions${NOCOLOR}"
}

if [ "$1" = "update" ]
then
    shift
    if [ "$#" -eq 0 ]
    then
        mapfile -t dir_list < <( find $AUR_DIR -maxdepth 1 -mindepth 1 -type d -printf '%f\n' )
        for dir in ${dir_list[@]}
        do
            cd "${AUR_DIR}/${dir}"
            git rev-parse >/dev/null 2>&1
            if [ $? -eq 0 ]
            then
                git remote update >/dev/null 2>&1
                git status --porcelain --branch -uno | grep -q "\[behind " && makepkg_si_and_clean "${dir}"
            else
                echo -e "${YELLOW}* WARNING: Ignored directory"
                echo -e "\t$(pwd)"
                echo -e "\tReason: Not an GIT repository${NOCOLOR}"
            fi
            cd ${AUR_DIR}
        done
    else
        for dir in "$@"
        do
            makepkg_si_and_clean "${dir}"
        done
    fi
elif [ "$1" = "install" ]
then
    shift
    if [ "$#" -ge 2 ]
    then
        git clone ${1} ${2}
        if [ "$?" -eq 0 ]
        then
            makepkg_si_and_clean "${2}"
        else
            echo -e "${RED}* Error : ${1} not an git repo${NOCOLOR}"
        fi
    else
        print_usage_error
    fi
elif [ "$1" = "check-update" ]
then
    mapfile -t dir_list < <( find $AUR_DIR -maxdepth 1 -mindepth 1 -type d -printf '%f\n' )
    for dir in ${dir_list[@]}
    do
        cd "${AUR_DIR}/${dir}"
        git rev-parse >/dev/null 2>&1
        if [ $? -eq 0 ]
        then
            git remote update >/dev/null 2>&1
            git status --porcelain --branch -uno | grep -q "\[behind " && echo -e "${GREEN}* AUR Update for \"${dir}\" available${NOCOLOR}"
        else
            echo -e "${YELLOW}* WARNING: Ignored directory"
            echo -e "\t$(pwd)"
            echo -e "\tReason: Not an GIT repository${NOCOLOR}"
        fi
        cd ${AUR_DIR}
    done
elif [ "$1" = "usage" ]
then
    echo -e "${GREEN}aur update${NOCOLOR} <list of package names>"
    echo -e "\tupdate given packages"
    echo -e "\t(if no packages are given all packages get an update)"
    echo -e "\n${GREEN}aur install${NOCOLOR} <link to git repo> <name>"
    echo -e "\tinstalls given aur package by git link"
    echo -e "\tname: name of the git folder in aur folder"
    echo -e "\n${GREEN}aur check-update${NOCOLOR}"
    echo -e "\tprints list of aur packages that have an update"
else
    print_usage_error
fi
