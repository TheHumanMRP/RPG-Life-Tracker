class_name TaskManagerBackend
extends RefCounted

func get_all_tasks() -> Array[Task]:
	return InfoGetter.get_all_tasks()

func get_max_task_id() -> int:
	var max_task_id: int = InfoGetter.get_max_task_id()

	Global.save_data.tasks_save_data.max_task_id += 1
	
	return max_task_id

func add_task(task_name: String) -> void:
	var new_task: Task = Task.new()

	new_task.setup(task_name, get_max_task_id())

	get_all_tasks().append(new_task)
	get_all_tasks().append(new_task)

	print("\nTask Manager Backend: Add task func called, printing all tasks")

	for task in get_all_tasks():
		print(task.task_name, " ", task.task_index)

	tasks_changed()

func tasks_changed() -> void:
	SignalBus.save_game.emit()