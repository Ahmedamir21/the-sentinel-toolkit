#!/bin/bash

tasks_file=".admin_tasks.csv"

if [ ! -f "$tasks_file" ]; then
    echo "Task,Priority,Due Date" > "$tasks_file"
fi
file=".admin_tasks.csv"

while true; do
    clear
    echo "*** Admin Task List ***"
    echo "1. Add Task"
    echo "2. View Tasks"
    echo "3. Delete Task"
    echo "4. Edit Task"
    read -p "Choice: " opt

    if [ "$opt" = "1" ]; then
        task_count=$(wc -l < "$file")
        if [ "$task_count" -gt 1 ]; then
            echo "--- Current Tasks ---"
            tail -n +2 "$file" | sort -t, -k2,2 -k3,3 | awk -F, '{print $1 " | " $2 " | " $3}'
            echo "---------------------"
        fi

        read -p "Task: " task
        read -p "Priority (HIGH/MED/LOW): " priority
        read -p "Due Date (YYYY-MM-DD): " date
        echo "$task,$priority,$date" >> "$file"
        echo "Task added successfully."

    elif [ "$opt" = "2" ]; then
        task_count=$(wc -l < "$file")
        if [ "$task_count" -gt 1 ]; then
            echo " Task | Priority | Due Date "
            echo "----------------------------"
            tail -n +2 "$file" | sort -t, -k2,2 -k3,3 | awk -F, '{print $1 " | " $2 " | " $3}'
        else
            echo "Error: No tasks found. Please try again."
        fi

    elif [ "$opt" = "3" ]; then
        task_count=$(wc -l < "$file")
        if [ "$task_count" -gt 1 ]; then
            echo "--- Current Tasks ---"
            tail -n +2 "$file" | sort -t, -k2,2 -k3,3 | awk -F, '{print $1 " | " $2 " | " $3}'
            echo "---------------------"

            read -p "Enter exact task name to delete: " del_task

            if grep -q "^$del_task," "$file"; then
                sed -i "/^$del_task,/d" "$file"
                echo "Task deleted successfully."
            else
                echo "Error: Task not found."
            fi
        else
            echo "Error: No tasks found. Please try again."
        fi

    elif [ "$opt" = "4" ]; then
        task_count=$(wc -l < "$file")
        if [ "$task_count" -gt 1 ]; then
            echo "--- Current Tasks ---"
            tail -n +2 "$file" | sort -t, -k2,2 -k3,3 | awk -F, '{print $1 " | " $2 " | " $3}'
            echo "---------------------"

            read -p "Enter exact task name to edit: " edit_task

            if grep -q "^$edit_task," "$file"; then
                read -p "New Task Name: " new_task
                read -p "New Priority (HIGH/MED/LOW): " new_priority
                read -p "New Due Date (YYYY-MM-DD): " new_date
                sed -i "s/^$edit_task,.*/$new_task,$new_priority,$new_date/" "$file"
                echo "Task updated successfully."
            else
                echo "Error: Task not found."
            fi
        else
            echo "Error: No tasks found. Please try again."
        fi

    else
        echo "Invalid option."
    fi

    while true; do
        read -p "Do you want to continue? (y/n): " ans
        if [[ "$ans" = "y" || "$ans" = "Y" ]]; then
            break
        elif [[ "$ans" = "n" || "$ans" = "N" ]]; then
            exit 0
        else
            echo "Error: Invalid input. Please enter y or n."
        fi
    done
done
