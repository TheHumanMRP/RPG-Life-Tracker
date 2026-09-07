class_name TaskManagerBackend
extends RefCounted

func get_save_data() -> TasksSaveData:
	return InfoGetter.get_tasks_save_data()

func add_task(task_name: String) -> void:
	var tasks_save_data: TasksSaveData = get_save_data()

	var new_task: Task = Task.new()

	new_task.setup(task_name, tasks_save_data.max_task_id)

	tasks_save_data.max_task_id += 1

	tasks_save_data.all_tasks.append(new_task)
	tasks_save_data.all_tasks.append(new_task)

	print("\nTask Manager Backend: Add task func called, printing all tasks")

	print_all_tasks(tasks_save_data)

	tasks_changed()

func print_all_tasks(tasks_save_data: TasksSaveData) -> void:
	var tasks: Array[Task] = tasks_save_data.all_tasks

	if tasks_save_data.all_tasks.size() == 0:
		print("\nTask Manager Backend: No tasks to print.")
		return

	print("\nTask Manager Backend: Printing all tasks")

	for task in tasks_save_data.all_tasks:
		print("\t", task.task_name, " : ", task.task_index)


func tasks_changed() -> void:
	SignalBus.save_game.emit()