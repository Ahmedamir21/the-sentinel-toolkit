#!/bin/bash

while true; do
    clear
    echo "--- Backup Utility ---"
    read -p "Enter directory to backup: " source_dir

    if [ -z "$source_dir" ]; then
        echo "Error: Directory path cannot be empty."
    elif [ -d "$source_dir" ]; then
        current_time=$(date +%Y-%m-%d_%H-%M)
        destination_file="backup_$current_time.tar.gz"

        tar -czf "$destination_file" "$source_dir"

        size=$(du -sh "$destination_file" | awk '{print $1}')

        echo "[$current_time] Source: $source_dir | Destination: $destination_file | Size: $size" >> backup.log
        echo "Backup created successfully: $destination_file"
    else
        echo "Error: Directory not found!"
    fi

    while true; do
        read -p "Do you want to perform another backup? (y/n): " ans
        if [[ "$ans" = "y" || "$ans" = "Y" ]]; then
            break
        elif [[ "$ans" = "n" || "$ans" = "N" ]]; then
            exit 0
        else
            echo "Error: Invalid input. Please enter y or n."
        fi
    done
done
