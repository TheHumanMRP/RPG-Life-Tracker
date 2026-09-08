class_name TaskManagerBackend
extends RefCounted


# ===================================================================
# Initialization
# ===================================================================

func _init() -> void:
	_calculate_max_id()


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

func mark_task_as_todo(task_id: int) -> void:
	var tasks: Array[Task] = get_save_data().all_tasks

	for task in tasks:
		if task.task_id == task_id:
			

## Adds a new task.
func add_task(task_name: String) -> int:
	print("\nTask Manager Backend: Adding a new task.")

	var data: TasksSaveData = get_save_data()

	var new_task: Task = Task.new()

	new_task.setup(task_name, data.max_task_id)

	data.all_tasks.append(new_task)

	data.max_task_id += 1

	print_all_tasks(data)

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
func get_task_by_id(task_id: int) -> Task:
	var data: TasksSaveData = get_save_data()

	for task in data.all_tasks:
		if task.task_id == task_id:
			return task

	push_error("Task Manager Backend: No task with task_id: ", task_id)

	return null


## Returns whether a task exists at the given array index.
func check_if_task_at_index_exists(index: int) -> bool:
	var data: TasksSaveData = get_save_data()

	if index < 0 or index >= data.all_tasks.size():
		return false

	return true


# ===================================================================
# Debug
# ===================================================================

func print_all_tasks(tasks_save_data: TasksSaveData = get_save_data()) -> void:
	var tasks: Array[Task] = tasks_save_data.all_tasks

	if tasks.is_empty():
		print("\nTask Manager Backend: No tasks to print.")
		return

	print("\nTask Manager Backend: Printing all tasks, size: ", tasks.size())

	for task in tasks:
		print("\t", task.task_name, " : ", task.task_id)


# ===================================================================
# Notification
# ===================================================================

func tasks_changed() -> void:
	SignalBus.save_game.emit()