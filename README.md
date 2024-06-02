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







## Usage

Run the script with the following commands:

- **Display Tasks Due Today:**

    ```bash
    ./todo.sh
    ```

- **Create a New Task:**

    ```bash
    ./todo.sh create
    ```

- **Update an Existing Task:**

    ```bash
    ./todo.sh update
    ```

- **Delete an Existing Task:**

    ```bash
    ./todo.sh delete
    ```

- **Show Details of a Task:**

    ```bash
    ./todo.sh show
    ```

- **List Tasks for a Specific Date:**

    ```bash
    ./todo.sh list
    ```

- **Search for a Task by Title:**

    ```bash
    ./todo.sh search
    ```

- **Display Help Message:**

    ```bash
    ./todo.sh help
    ```

### Detailed Command Descriptions

- **create**
    - Description: Create a new task.
    - Prompts:
        - Enter title: Required.
        - Enter description: Optional.
        - Enter due date (format DD-MM-YYYY): Required.
        - Enter due time (format HH:MM): Optional.

- **update**
    - Description: Update an existing task.
    - Prompts:
        - Enter task ID to update: Required.
        - Enter new title: Optional.
        - Enter new description: Optional.
        - Enter new due date: Optional (format DD-MM-YYYY).
        - Enter new due time: Optional (format HH:MM).
        - Enter new completion state (true/false): Optional.

- **delete**
    - Description: Delete an existing task.
    - Prompts:
        - Enter task ID to delete: Required.

- **show**
    - Description: Show details of a task.
    - Prompts:
        - Enter task ID to show: Required.

- **list**
    - Description: List tasks for a given date.
    - Prompts:
        - Enter date to list tasks (format DD-MM-YYYY): Required.

- **search**
    - Description: Search for a task by title.
    - Prompts:
        - Enter title to search: Required.

### Output

The script formats and displays tasks in a user-friendly table with the following columns:

- **ID:** Task ID.
- **Title:** Task title.
- **Description:** Task description.
- **Due Date and Time:** Task due date and time.
- **Completed:** Task completion status (true/false).

### Example

Here's how to create a new task:

1. Run the command:

    ```bash
    ./todo.sh create
    ```

2. Follow the prompts to enter the task details:

    - (required) Enter title: Finish project
    - (optional) Enter description: Complete the final project for the course.
    - (required) Enter due date (format DD-MM-YYYY): 15-06-2024
    - (optional) Enter due time (format HH:MM): 23:59

3. The task is added, and the script confirms the creation:

    ```bash
    Task created successfully.
    ```

### Note

- Ensure the **todo.csv** file is in the same directory as the script.
- The script auto-generates the **todo.csv** file if it doesn't exist.
- Task IDs are automatically assigned and reorganized after each operation for consistency.

### Pro Tip

Stay organized and conquer your tasks with ease! 💪

---

Feel free to customize this README further to match your specific project. Happy organizing! 😊🚀
