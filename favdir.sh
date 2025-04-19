#!/bin/bash

FAV_FILE="$HOME/.favdirs"

mkdir -p "$(dirname "$FAV_FILE")"
touch "$FAV_FILE"

function bigtext() {
    if command -v figlet >/dev/null 2>&1; then
        if command -v lolcat >/dev/null 2>&1; then
            figlet "$1" | lolcat
        else
            figlet "$1"
        fi
    else
        echo "=== $1 ==="
    fi
}

function show_menu() {
    clear
    bigtext "Fav Dirs"

    echo "1) Go to directory"
    echo "2) Add current directory"
    echo "3) Remove saved directory"
    echo "4) Exit"
    echo ""
    read -rp "Choose an option: " choice

    case $choice in
        1)
            go_to_directory
            ;;
        2)
            add_current_directory
            ;;
        3)
            remove_directory
            ;;
        4)
            return
            ;;
        *)
            echo "Invalid choice."
            ;;
    esac
}

function go_to_directory() {
    if [ ! -s "$FAV_FILE" ]; then
        echo "No directories saved."
        sleep 1.5
        return
    fi

    if command -v fzf >/dev/null 2>&1; then
        dir=$(cat "$FAV_FILE" | fzf)
    else
        echo
        echo "Choose a directory:"
        IFS=$'\n' read -d '' -r -a dirs < "$FAV_FILE"
        select dir in "${dirs[@]}"; do
            break
        done
    fi

    if [ -n "$dir" ]; then
        cd "$dir" || echo "Directory not found."
    fi
}

function add_current_directory() {
    pwd >> "$FAV_FILE"
    awk '!seen[$0]++' "$FAV_FILE" > "${FAV_FILE}.tmp" && mv "${FAV_FILE}.tmp" "$FAV_FILE"
    echo "Added $(pwd)" | lolcat 2>/dev/null || echo "Added $(pwd)"
    sleep 1
}

function remove_directory() {
    if [ ! -s "$FAV_FILE" ]; then
        echo "No directories to remove."
        sleep 1.5
        return
    fi

    if command -v fzf >/dev/null 2>&1; then
        dir=$(cat "$FAV_FILE" | fzf)
    else
        echo
        echo "Choose a directory to remove:"
        IFS=$'\n' read -d '' -r -a dirs < "$FAV_FILE"
        select dir in "${dirs[@]}"; do
            break
        done
    fi

    if [ -n "$dir" ]; then
        grep -Fxv "$dir" "$FAV_FILE" > "${FAV_FILE}.tmp" && mv "${FAV_FILE}.tmp" "$FAV_FILE"
        echo "Removed $dir" | lolcat 2>/dev/null || echo "Removed $dir"
        sleep 1
    fi
}

show_menu
