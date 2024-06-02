# todo

Detailed Command Descriptions
create
Description: Create a new task.
Prompts:
Enter title: Required.
Enter description: Optional.
Enter due date (format DD-MM-YYYY): Required.
Enter due time (format HH:MM): Optional.
update
Description: Update an existing task.
Prompts:
Enter task ID to update: Required.
Enter new title: Optional.
Enter new description: Optional.
Enter new due date: Optional (format DD-MM-YYYY).
Enter new due time: Optional (format HH
).
Enter new completion state (true/false): Optional.
delete
Description: Delete an existing task.
Prompts:
Enter task ID to delete: Required.
show
Description: Show details of a task.
Prompts:
Enter task ID to show: Required.
list
Description: List tasks for a given date.
Prompts:
Enter date to list tasks (format YYYY-MM-DD): Required.
search
Description: Search for a task by title.
Prompts:
Enter title to search: Required.
help
Description: Display help message with all available commands and their descriptions.
Output
The script formats and displays tasks in a user-friendly table with the following columns:

ID: Task ID.
Title: Task title.
Description: Task description.
Due Date and Time: Task due date and time.
Completed: Task completion status (true/false)
