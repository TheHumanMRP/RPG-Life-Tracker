class_name TaskManager
extends RefCounted


# ===================================================================
# ID Management
# ===================================================================

## Calculates the next available task ID.
func _calculate_max_id() -> void:
	var data: TasksSaveData = get_save_data()

	data.max_task_id = 0

	for task in data.all_tasks:
		if task.task_id >= data.max_task_id:
			data.max_task_id = task.task_id + 1

	tasks_changed()


# ===================================================================
# Task Operations
# ===================================================================

func set_task_status(task_id: int, new_task_status: All_Enums.TASK_STATUS) -> void:
	var task: Task = get_task_by_task_id(task_id)

	if task == null:
		return

	task.set_task_status(new_task_status)

	tasks_changed()

## Adds a new task.
func add_task(task_name: String) -> int:
	print("\nTask Manager: Adding a new task.")

	var task_data: TasksSaveData = get_save_data()

	var new_task: Task = Task.new()

	new_task.setup(task_name, task_data.max_task_id)

	print(task_data.all_tasks)

	task_data.all_tasks.append(new_task)

	print(task_data.all_tasks)

	task_data.max_task_id += 1

	print_all_tasks()

	tasks_changed()

	return new_task.task_id


## Removes a task using its unique ID.
func remove_task(task_id: int) -> void:
	print("\nTask Manager Backend: Removing task with task_id: ", task_id)

	var data: TasksSaveData = get_save_data()

	for i in data.all_tasks.size():
		if data.all_tasks[i].task_id == task_id:
			data.all_tasks.remove_at(i)

			tasks_changed()
			return

	push_error("Task Manager Backend: Task not found: ", task_id)


## Removes every task.
func clear_tasks() -> void:
	print("\nTask Manager Backend: Clearing all tasks.")

	var data: TasksSaveData = get_save_data()

	data.all_tasks.clear()
	data.max_task_id = 0

	tasks_changed()


# ===================================================================
# Getters
# ===================================================================

func get_save_data() -> TasksSaveData:
	return InfoGetter.get_tasks_save_data()

## Returns a task using its unique ID.
func get_task_by_task_id(task_id: int) -> Task:
	if task_id == Constants.NO_TASK:
		return

	var data: TasksSaveData = get_save_data()

	for task in data.all_tasks:
		if task.task_id == task_id:
			return task

	push_error("Task Manager Backend: No task with task_id: ", task_id)

	return null


# ===================================================================
# Debug
# ===================================================================

func print_all_tasks() -> void:
	var tasks_save_data: TasksSaveData = get_save_data()

	var tasks: Array[Task] = tasks_save_data.all_tasks

	if tasks.is_empty():
		print("\nTask Manager: No tasks to print.")
		return

	print("\nTask Manager: Printing all tasks, size: ", tasks.size())

	for task in tasks:
		print("\t", task.task_name, " : ", task.task_id)


# ===================================================================
# Notification
# ===================================================================

func tasks_changed() -> void:
	print_stack()
	print("Task Manager: Save game signal emitted")
	SignalBus.save_game.emit()