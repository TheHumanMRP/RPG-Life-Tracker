class_name TaskManager
extends RefCounted

func add_item(task_name: String) -> void:
	var new_task: Task = Task.new()

	new_task.setup(task_name)