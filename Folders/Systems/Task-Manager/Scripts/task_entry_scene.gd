extends PanelContainer


var task_entry: Task

var task_name: String
var task_status : All_Enums.TASK_STATUS

func setup(new_task_entry: Task) -> void:
	task_entry = new_task_entry