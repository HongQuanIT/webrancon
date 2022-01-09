#!/usr/bin/env bash

# prints colored text

print_style () {
    if [ "$2" == "info" ] ; then
        COLOR="96m"
    elif [ "$2" == "success" ] ; then
        COLOR="92m"
    elif [ "$2" == "warning" ] ; then
        COLOR="93m"
    elif [ "$2" == "danger" ] ; then
        COLOR="91m"
    else #default color
        COLOR="0m"
    fi

    STARTCOLOR="\e[$COLOR"
    ENDCOLOR="\e[0m"

    printf "$STARTCOLOR%b$ENDCOLOR" "$1"
}

display_options () {
    printf "Available options :\n";
    print_style "   watch" "success"; printf ": rebuild tailwindcss input.css\n"
}

##### VARIABLES #####
script_folder="$( cd "$(dirname "$0")" ; pwd -P )"
# export COMPOSE_FILE="docker-compose.yml"
#domain="${DEPLOY_DOMAIN:-local}"
author_display () {
    printf "Version: "; print_style "1.0.0\n" "info"
    printf "Author: "; print_style "Quan Dang\n" "info"
}

##### COMMANDS #####

cd $script_folder

# up
if [ "$1" == "watch" ]; then
    print_style "Initializing Docker Compose and up services ...\n" "info"
    author_display
    if [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        cd $script_folder
        npx tailwindcss -i ./src/input.css -o ./dist/output.css --watch
    else
        # Linux or Mac
        npx tailwindcss -i ./src/input.css -o ./dist/output.css --watch
    fi
else
    print_style "Invalid arguments. Please choose arguments bellow:\n" "danger"
    display_options
    author_display
    exit 1
fi
