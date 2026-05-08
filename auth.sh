#!/bin/bash

user_file=".sentinel_users"

while true; do
    clear
    echo " -------------------------------------- "
    echo "           Authentication Menu            "
    echo " -------------------------------------- "
    echo "1. Sign Up (New Admin)"
    echo "2. Sign In (Existing Admin)"

    read -p "Choose an option (1 or 2): " choice

    if [ "$choice" = "1" ]; then
        while true; do
            read -p "(Note:If you want to go back Press q) Enter new username: " username
            if [ "$username" = "q" ] || [ "$username" = "Q" ]; then
                continue 2
            fi
            if grep -q "^$username:" "$user_file"; then
                echo "Error: Username already exists."
            else
                break
            fi
        done
        read -s -p "Enter new password: " password
        echo ""

        hashed_pw=$(echo -n "$password" | sha256sum | awk '{print $1}')
        echo "$username:$hashed_pw" >> "$user_file"
        echo "Account created successfully!"
        exit 0
    elif [ "$choice" = "2" ]; then
        read -p "(Note:If you want to go back Press q) Enter username: " username
        if [ "$username" = "q" ] || [ "$username" = "Q" ]; then
            continue
        fi

        read -s -p "Enter password: " password
        echo ""

        hashed_pw=$(echo -n "$password" | sha256sum | awk '{print $1}')

        if grep -q "^$username:$hashed_pw$" "$user_file"; then
            echo "Login successful! Welcome $username."
            exit 0
        else
            echo "Error: Invalid username or password."
        fi
    else
        echo "Error: Invalid option."
        read -p "Do you want to try again? (y/n): " ans
        if [[ "$ans" = "n" || "$ans" = "N" ]]; then
            exit 1
        fi
    fi
done
