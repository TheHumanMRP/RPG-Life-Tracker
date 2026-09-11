extends PanelContainer


var task_index: int

var task_name: String
var task_status: All_Enums.TASK_STATUS

@export var task_name_label: Label
@export var task_status_lable: Label

func setup(new_task_index: int) -> void:
	task_index = new_task_index
	
	task_name = task_entry.task_name
	task_status = task_entry.task_status

func get_task() -> Task:
	

func refresh_ui() -> void:
	task_name_label = task_name