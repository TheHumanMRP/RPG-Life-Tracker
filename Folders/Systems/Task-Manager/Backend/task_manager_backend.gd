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

	for task in tasks_save_data.all_tasks:
		print(task.task_name, " ", task.task_index)

	tasks_changed()

func tasks_changed() -> void:
	SignalBus.save_game.emit()