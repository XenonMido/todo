# The Ultimate ToDo Manager

Welcome to the **The Ultimate ToDo Manager**! This powerful yet simple command-line tool helps you manage your tasks efficiently, ensuring you stay organized and on top of your to-do list. Below is the detailed guide to using this script.

## Features

- **Create Tasks**: Add new tasks with titles, descriptions, due dates, and times.
- **Update Tasks**: Modify existing tasks' details.
- **Delete Tasks**: Remove tasks from your list.
- **Show Task Details**: View detailed information about specific tasks.
- **List Tasks**: Display tasks for a given date or list all tasks.
- **Search Tasks**: Find tasks by their titles.
- **Help Message**: Display helpful information about using the tool.

## Installation

Follow these steps to install the Ultimate ToDo Manager:
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/XenonMido/todo.git
   ```
2. **Navigate the the Directory**:
   ```bash
   cd todo
   ```
3. **Make the script executable**:
   ```bash
   chmod +x todo.sh
   ```








### Detailed Command Descriptions:

```markdown
## Detailed Command Descriptions

### `create`
- **Description**: Create a new task.
- **Prompts**:
  - `Enter title`: Required.
  - `Enter description`: Optional.
  - `Enter due date (format DD-MM-YYYY)`: Required.
  - `Enter due time (format HH:MM)`: Optional.

### `update`
- **Description**: Update an existing task.
- **Prompts**:
  - `Enter task ID to update`: Required.
  - `Enter new title`: Optional.
  - `Enter new description`: Optional.
  - `Enter new due date`: Optional (format DD-MM-YYYY).
  - `Enter new due time`: Optional (format HH:MM).
  - `Enter new completion state (true/false)`: Optional.

### `delete`
- **Description**: Delete an existing task.
- **Prompts**:
  - `Enter task ID to delete`: Required.

### `show`
- **Description**: Show details of a task.
- **Prompts**:
  - `Enter task ID to show`: Required.

### `list`
- **Description**: List tasks for a given date.
- **Prompts**:
  - `Enter date to list tasks (format YYYY-MM-DD)`: Required.

### `search`
- **Description**: Search for a task by title.
- **Prompts**:
  - `Enter title to search`: Required.

### `help`
- **Description**: Display help message with all available commands and their descriptions.


