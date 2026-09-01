class_name TaskManager
extends RefCounted

func get_all_tasks() -> Array[Task]:
	return InfoGetter.get_all_tasks()

func get_max_task_id() -> int:
	return InfoGetter.get_max_task_id()

func add_item(task_name: String) -> void:
	var new_task: Task = Task.new()

	new_task.setup(task_name)
