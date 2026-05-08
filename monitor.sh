#!/bin/bash

while true; do
    clear
    echo " -------------------------------------- "
    echo "        System Resource Monitor         "
    echo " -------------------------------------- "

    echo "*** Disk Usage ***"
    df -h | head -n 5
    echo ""

    echo "*** Memory Usage ***"
    free -m
    echo ""

    echo "*** CPU Usage ***"
    cpu_load=$(top -bn1 | grep "Cpu(s)" | awk '{print int($2)}')
    echo "Current CPU Load: $cpu_load%"

    if [ "$cpu_load" -gt 80 ]; then
        echo -e "\e[31mWARNING: CPU Usage is critically high!\e[0m"
    else
        echo -e "\e[32mCPU Usage is normal.\e[0m"
    fi

    echo " -------------------------------------- "
    echo "Press 'q' to stop monitoring."
    
    read -t 2 -n 1 -s key
    if [[ "$key" = "q" || "$key" = "Q" ]]; then
        while true; do
            echo ""
            read -p "Are you sure you want to exit the monitor? (y/n): " ans
            if [[ "$ans" = "y" || "$ans" = "Y" ]]; then
                exit 0
            elif [[ "$ans" = "n" || "$ans" = "N" ]]; then
                break
            else
                echo "Error: Invalid input. Please enter y or n."
            fi
        done
    fi
done
