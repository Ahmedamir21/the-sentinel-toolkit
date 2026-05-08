#!/bin/bash

config_file=".watchlist.conf"
log_file="uptime.log"

if [ ! -f "$config_file" ]; then
    echo "8.8.8.8" > "$config_file"
    echo "google.com" >> "$config_file"
    echo "192.168.1.99" >> "$config_file"
fi

while true; do
    clear
    echo " -------------------------------------- "
    echo "         Remote Uptime Monitor          "
    echo " -------------------------------------- "
    
    if [ ! -s "$config_file" ]; then
        echo "Error: Watchlist is empty."
    else
        echo "Pinging servers from $config_file..."
        echo " -------------------------------------- "

        while IFS= read -r server || [ -n "$server" ]; do
            if [ -z "$server" ]; then
                continue
            fi

            ping_output=$(ping -c 1 -W 2 "$server" 2>/dev/null)

            if [ $? -eq 0 ]; then
                time_ms=$(echo "$ping_output" | awk -F'time=' '/time=/{print $2}' | awk '{print $1 " " $2}')
                echo -e "Server: $server \t Status: \e[32m[ UP ]\e[0m \t Response Time: $time_ms"
            else
                echo -e "Server: $server \t Status: \e[31m[ DOWN ]\e[0m \t Response Time: Timeout"
                fail_time=$(date +%Y-%m-%d_%H:%M:%S)
                echo "[$fail_time] Server $server was DOWN" >> "$log_file"
            fi
        done < "$config_file"

        echo " -------------------------------------- "
        echo "Failures are logged in $log_file"
    fi

    while true; do
        read -p "Do you want to check again? (y/n): " ans
        if [[ "$ans" = "y" || "$ans" = "Y" ]]; then
            break
        elif [[ "$ans" = "n" || "$ans" = "N" ]]; then
            exit 0
        else
            echo "Error: Invalid input. Please enter y or n."
        fi
    done
done
