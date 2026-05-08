#!/bin/bash

if [ ! -f backup.log ]; then
    touch backup.log
fi

if [ ! -f uptime.log ]; then
    touch uptime.log
fi

if [ ! -f fileserver_access.log ]; then
    touch fileserver_access.log
fi

if [ ! -f .sentinel_users ]; then
    touch .sentinel_users
    chmod 600 .sentinel_users
fi

if [ ! -f .admin_tasks.csv ]; then
    echo "Task,Priority,Due Date" > .admin_tasks.csv
fi

if [ ! -f .watchlist.conf ]; then
    echo "8.8.8.8" > .watchlist.conf
    echo "google.com" >> .watchlist.conf
    echo "192.168.1.99" >> .watchlist.conf
fi

echo " -------------------------------------- "
echo "        Welcome to The Sentinel         "
echo " -------------------------------------- "

./auth.sh

if [ $? -ne 0 ]; then
    echo -e "\n\e[31mAccess Denied. Exiting The Sentinel ... \e[0m"
    exit 1
fi

while true; do
    clear
    echo " -------------------------------------- "
    echo "      THE SENTINEL: ADMIN TOOLKIT       "
    echo " -------------------------------------- "
    echo "1. Secure Authentication"
    echo "2. System Resource Monitor"
    echo "3. Backup Utility"
    echo "4. Admin Task List"
    echo "5. Remote Uptime Monitor"
    echo "6. Temporary File Server"
    echo "7. Exit"
    echo " -------------------------------------- "

    read -p "Select an option (1-7): " opt

    while [ -z "$opt" ]; do
        read -p "Please select an option (1-7): " opt
    done

    if [ "$opt" = "1" ]; then
        ./auth.sh
    elif [ "$opt" = "2" ]; then
        ./monitor.sh
    elif [ "$opt" = "3" ]; then
        ./backup.sh
    elif [ "$opt" = "4" ]; then
        ./tasks.sh
    elif [ "$opt" = "5" ]; then
        ./uptime.sh
    elif [ "$opt" = "6" ]; then
        ./fileserver.sh
    elif [ "$opt" = "7" ]; then
        echo "Exiting The Sentinel ... Goodbye!"
        exit 0
    else
        echo "Invalid option. Please try again."
        sleep 1
    fi
done
