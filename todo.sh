#!/bin/bash



TODO_FILE="todo.csv"
if [ ! -f "$TODO_FILE" ]; then
  touch "$TODO_FILE"
fi


function header {
  cls=$(clear)
  echo $cls
  echo -e "
  
                        ░        ░░░      ░░░       ░░░░      ░░
                        ▒▒▒▒  ▒▒▒▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒
                        ▓▓▓▓  ▓▓▓▓▓  ▓▓▓▓  ▓▓  ▓▓▓▓  ▓▓  ▓▓▓▓  ▓
                        ████  █████  ████  ██  ████  ██  ████  █
                        ████  ██████      ███       ████      ██
                                        

  "
}

function reorganize_tasks {
  temp_file=$(mktemp)
  awk -F',' '{ $1=NR; print $0 }' OFS=',' "$TODO_FILE" > "$temp_file"
  mv "$temp_file" "$TODO_FILE"
  rm "$temp_file"
  echo "Tasks reorganized successfully."
}

function error_msg_redirect {
  echo "$1" >&2
}

function create_task {
  read -p "(required)/  Enter title: " title
  if [ -z "$title" ]; then
    error_msg_redirect "Title is required when creating a task!"
    exit 1
  fi
  read -p "(optional)/  Enter description : " description
  read -p "(required)/  Enter due date (format DD-MM-YYYY): " due_date
  if ! [[ "$due_date" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
    error_msg_redirect "Invalid date format when creating a task!"
    exit 1
  fi
  read -p "(optional)/  Enter due time (format HH:MM): " due_time
  if [[ -n "$due_time" && ! "$due_time" =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
    error_msg_redirect "Invalid time format when creating a task!"
    exit 1
  fi
  
  id=$(($(wc -l < "$TODO_FILE") + 1))
  echo "$id,$title,$description,$due_date $due_time,false" >> "$TODO_FILE"
  echo "Task created successfully."
}

function update_task {
  read -p "Enter task ID to update: " id
  if ! grep -q "^$id," "$TODO_FILE"; then
    error_msg_redirect "Task ID not found."
    exit 1
  fi
  read -p "(leave blank to keep current)/  Enter new title: " title
  read -p "(leave blank to keep current)/  Enter new description: " description
  read -p "(leave blank to keep current)/  Enter new due date: " due_date
  if [[ -n "$due_date" && ! "$due_date" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
    error_msg_redirect "Invalid date format when updating a task."
    exit 1
  fi
  read -p "(leave blank to keep current)/  Enter new due time: " due_time
  if [[ -n "$due_time" && ! "$due_time" =~ ^[0-9]{2}:[0-9]{2}$ ]]; then
    error_msg_redirect "Invalid time format when updating a task."
    exit 1
  fi
  read -p "(leave blank to keep current)/  Enter new completion state (true/false): " completed

  old_task=$(grep "^$id," "$TODO_FILE")
  IFS=',' read -r -a task_fields <<< "$old_task"
  [[ -n "$title" ]] && task_fields[1]=$title
  [[ -n "$description" ]] && task_fields[2]=$description
  [[ -n "$due_date" ]] && task_fields[3]=$due_date
  [[ -n "$due_time" ]] && task_fields[3]+=" $due_time"

  [[ -n "$completed" ]] && task_fields[4]=$completed

  new_task=$(IFS=,; echo "${task_fields[*]}")
  sed -i "s/^$old_task\$/$new_task/" "$TODO_FILE"
  echo "Task updated successfully."
}

function delete_task {
  read -p "Enter task ID to delete: " id
  if ! grep -q "^$id," "$TODO_FILE"; then
    error_msg_redirect "Task ID not found when trying to delete a task!"
    exit 1
  fi
  sed -i "/^$id,/d" "$TODO_FILE"
  echo "Task deleted successfully."
}

function reorganize_tasks {
  temp_file=$(mktemp)
  awk -F',' '{ $1=NR; print $0 }' OFS=',' "$TODO_FILE" > "$temp_file"
  mv "$temp_file" "$TODO_FILE"
  rm "$temp_file"
  #echo "Tasks reorganized successfully."
}

function show_task {
  read -p "Enter task ID to show: " id
  task_info=$(grep "^$id," "$TODO_FILE")
  if [ -z "$task_info" ]; then
    error_msg_redirect "Task ID not found when trying to show the details of a task!"
    exit 1
  fi

  IFS=',' read -r id title description due_date_time completion_marker <<< "$task_info"

  field_width=20
  value_width=36

  max_value_length=$(printf "%s\n" "$id" "$title" "$description" "$due_date_time" "$completion_marker" | awk '{ if ( length > max ) max = length } END { print max }')

  if [ "$max_value_length" -gt "$value_width" ]; then
    value_width=$max_value_length
  fi

  separator_line="+-$(printf "%-${field_width}s" "" | tr ' ' '-')-+-$(printf "%-${value_width}s" "" | tr ' ' '-')-+"

  echo "$separator_line"
  printf "| %-${field_width}s | %-${value_width}s |\n" "Field" "Value"
  echo "$separator_line"
  printf "| %-${field_width}s | %-${value_width}s |\n" "ID" "$id"
  printf "| %-${field_width}s | %-${value_width}s |\n" "Title" "$title"
  printf "| %-${field_width}s | %-${value_width}s |\n" "Description" "$description"
  printf "| %-${field_width}s | %-${value_width}s |\n" "Due Date and Time" "$due_date_time"
  printf "| %-${field_width}s | %-${value_width}s |\n" "Completed" "$completion_marker"
  echo "$separator_line"
}

function search_task {
  read -p "Enter title to search: " search_title
  task_info=$(grep -i ",$search_title," "$TODO_FILE")
  if [ -z "$task_info" ]; then
    echo "Title not found when trying to search for a task!"
    error_msg_redirect "Title not found when trying to search for a task!"
    exit 1
  fi

  field_width=20
  value_width=36

  max_value_length=$(printf "%s\n" "$task_info" | awk -F',' '{print $2 "\n" $3 "\n" $4 "\n" $5}' | awk '{ if ( length > max ) max = length } END { print max }')

  if [ "$max_value_length" -gt "$value_width" ]; then
    value_width=$max_value_length
  fi

  separator_line="+-$(printf "%-${field_width}s" "" | tr ' ' '-')-+-$(printf "%-${value_width}s" "" | tr ' ' '-')-+"

  while IFS=',' read -r id title description due_date_time completion_marker; do
    echo "$separator_line"
    printf "| %-${field_width}s | %-${value_width}s |\n" "Field" "Value"
    echo "$separator_line"
    printf "| %-${field_width}s | %-${value_width}s |\n" "ID" "$id"
    printf "| %-${field_width}s | %-${value_width}s |\n" "Title" "$title"
    printf "| %-${field_width}s | %-${value_width}s |\n" "Description" "$description"
    printf "| %-${field_width}s | %-${value_width}s |\n" "Due Date and Time" "$due_date_time"
    printf "| %-${field_width}s | %-${value_width}s |\n" "Completed" "$completion_marker"
    echo "$separator_line"
  done <<< "$task_info"
}

function print_table_header {
  printf "+----+----------------------+------------------------------+---------------------+------------+\n"
  printf "| ID | Title                | Description                  | Due Date and Time   | Completed  |\n"
  printf "+----+----------------------+------------------------------+---------------------+------------+\n"
}

function print_table_footer {
  printf "+----+----------------------+------------------------------+---------------------+------------+\n"
}

function print_task_row {
  local id=$1
  local title=$2
  local description=$3
  local due_date_time=$4
  local completion_marker=$5
  title=$(truncate_text "$title" 20)
  description=$(truncate_text "$description" 28)
  printf "| %-2s | %-20s | %-28s | %-19s | %-10s |\n" "$id" "$title" "$description" "$due_date_time" "$completion_marker"
}

function truncate_text {
  local text="$1"
  local max_length="$2"
  if [ ${#text} -gt $max_length ]; then
    echo "${text:0:$((max_length-3))}..."
  else
    echo "$text"
  fi
}

function list_all_tasks {
  if [ ! -s "$TODO_FILE" ]; then
    echo "No tasks found when trying to list all tasks"
    error_msg_redirect "No tasks found when trying to list all tasks"
    return
  fi

  print_table_header

  while IFS=, read -r id title description due_date_time completion_marker; do 
    print_task_row "$id" "$title" "$description" "$due_date_time" "$completion_marker"
  done < "$TODO_FILE"

  print_table_footer
}

function list_today_tasks {
  local due_date=$(date +"%d-%m-%y")

  echo "Today's tasks:"
  print_table_header
  while IFS=, read -r id title description due_date_time completion_marker; do
    if [[ "$due_date_time" == "$due_date"* ]]; then
      print_task_row "$id" "$title" "$description" "$due_date_time" "$completion_marker"
    fi
  done < "$TODO_FILE"
  print_table_footer
}

function list_tasks_date {
  read -p "Enter date to list tasks (format DD-MM-YYYY): " due_date
  if ! [[ "$due_date" =~ ^[0-9]{2}-[0-9]{2}-[0-9]{4}$ ]]; then
    error_msg_redirect "Invalid date format while searching for a task!"
    exit 1
  fi

  echo "Tasks for $due_date:"
  print_table_header
  while IFS=, read -r id title description due_date_time completion_marker; do
    if [[ "$due_date_time" == "$due_date"* ]]; then
      print_task_row "$id" "$title" "$description" "$due_date_time" "$completion_marker"
    fi
  done < "$TODO_FILE"
  print_table_footer
}

function help_msg {
  echo "🔥 Welcome to the Ultimate To-Do Manager 🔥"
  echo "Usage: todo [command]"
  echo ""
  echo "✨ Available Commands ✨"
  echo "  🚀 create   - Create a new task"
  echo "  ✏️  update   - Update an existing task"
  echo "  ❌ delete   - Delete an existing task"
  echo "  👀 show     - Show details of a task"
  echo "  📅 list     - List tasks for a given day"
  echo "  🔍 search   - Search for a task by title"
  echo "  🆘 help     - Display this help message"
  echo ""
  echo "Pro Tip: Stay organized and conquer your tasks with ease! 💪"
}


case "$1" in
  l)
    header
    list_all_tasks
    ;;
  create)
    header
    create_task
    ;;
  update)
    header
    list_all_tasks
    update_task
    ;;
  delete)
    header
    list_all_tasks
    delete_task
    reorganize_tasks
    ;;
  show)
    header
    list_all_tasks
    show_task
    ;;
  list)
    header
    list_tasks_date
    ;;
  search)
    header
    search_task
    ;;
  help)
    header
    help_msg
    ;;
  *)
    header
    list_today_tasks
    ;;
esac





