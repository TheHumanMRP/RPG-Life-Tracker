class_name Task

@export var task_name: String
@export var task_status: All_Enums.TASK_STATUS

func setup(new_task_name: String) -> void:
	task_name = new_task_name

func mark_task_as_completed() -> void:
	task_status = All_Enums.TASK_STATUS.Completed

func mark_task_as_pending() -> void:
	task_status = All_Enums.TASK_STATUS.Pending

func mark_task_as_