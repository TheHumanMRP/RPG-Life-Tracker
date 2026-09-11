extends PanelContainer


var task_entry: Task

var task_name: String
var task_status: All_Enums.TASK_STATUS

@export var 

func setup(new_task_entry: Task, new_task_status: All_Enums.TASK_STATUS) -> void:
	task_entry = new_task_entry
	task_status = new_task_status

func refresh_ui() -> void:
	pass