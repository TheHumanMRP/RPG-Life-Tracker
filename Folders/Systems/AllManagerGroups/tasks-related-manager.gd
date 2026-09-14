class_name TasksRelatedManagers
extends RefCounted

var tasks_manager: TaskManager

func setup() -> void:
	tasks_manager = TaskManager.new()