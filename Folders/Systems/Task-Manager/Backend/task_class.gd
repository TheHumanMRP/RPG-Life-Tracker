class_name Task

@export var task_name: String
@export var task_status: bool

func setup(new_task_name: String) -> void:
	task_name = new_task_name

func mark_task_as_completed() -> void:
	task_status = 