extends PanelContainer


var task_id: int

var task_name: String
var task_status: All_Enums.TASK_STATUS

@export var task_name_label: Label
@export var task_status_option_button: OptionButton

func setup(new_task_id: int) -> void:
	task_id = new_task_id

func refresh() -> void:
	var task: Task = _get_task()

	task_name = task.task_name
	task_status = task.task_status

func _refresh_status_option_button() -> void:
	for i in range(task_status_option_button.item_count):
		task_status_option_button.remove_item(0)

	for option in range(Constants.TASK_STATUS_OPTIONS.size()):
		task_status_option_button.add_item(option)

func _get_task() -> Task:
	return InfoGetter.get_task_by_task_id(task_id)

func _refresh_ui() -> void:
	task_name_label.text = task_name