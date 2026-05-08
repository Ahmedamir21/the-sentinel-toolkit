#!/bin/bash

main_dir=$(pwd)
log="$main_dir/fileserver_access.log"
pid_file="$main_dir/.server.pid"

while true; do
    clear
    echo " -------------------------------------- "
    echo "         Temporary File Server          "
    echo " -------------------------------------- "
    echo "1. Start Sharing"
    echo "2. Stop Sharing"
    read -p "Choice (1 or 2): " choice

    if [ "$choice" = "1" ]; then
        if [ -f "$pid_file" ]; then
            echo "Error: Server is already running!"
        else
            read -p "Enter directory path: " mydir

            if [ -z "$mydir" ] || [ ! -d "$mydir" ]; then
                echo "Error: Directory not found or empty."
            else
                cd "$mydir"
                python3 -m http.server 8000 >> "$log" 2>&1 &
                echo $! > "$pid_file"
                cd "$main_dir"
                echo "Server is now running in the background (Port 8000)."
                echo "Logs are saved in fileserver_access.log"
            fi
        fi
    elif [ "$choice" = "2" ]; then
        if [ -f "$pid_file" ]; then
            server_pid=$(cat "$pid_file")
            kill $server_pid
            rm "$pid_file"
            echo "Server stopped successfully."
        else
            echo "Error: No server is running."
        fi
    else
        echo "Error: Invalid choice."
    fi

    while true; do
        read -p "Do you want to continue in File Server? (y/n): " ans
        if [[ "$ans" = "y" || "$ans" = "Y" ]]; then
            break
        elif [[ "$ans" = "n" || "$ans" = "N" ]]; then
            exit 0
        else
            echo "Error: Invalid input. Please enter y or n."
        fi
    done
done
