#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NOCOLOR='\033[0m'

mapfile -t dir_list < <( find $1 -maxdepth 1 -mindepth 1 -type d -printf '%f\n' )

for dir in ${dir_list[@]}
do
    cd "${1}/${dir}"
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
    cd ${1}
done

mapfile -t update_list < <( checkupdates )
checkupdates >/dev/null 2>&1
retval=$?

if [ ${retval} -eq 0 ]
then
    for update in ${update_list[@]}
    do
        echo -e "${GREEN}* PACMAN Update for ${update} available${NOCOLOR}"
    done
elif [ ${retval} -eq 1 ]
then
    echo -e "${RED}* ERROR: Unknonw cause of failure${NOCOLOR}"
elif [ ${retval} -eq 2 ]
then
    :
else
    echo -e "${RED}* ERROR: Undefined return value of \`checkupdates\` command${NOCOLOR}"
fi
