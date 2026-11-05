extends PanelContainer

var task_id: int = Constants.NO_TASK

var task_name: String
var task_status: All_Enums.TASK_STATUS

@export var task_name_label: Label
@export var task_status_option_button: OptionButton

# ===============================================================
# Setup
# ===============================================================
func _ready() -> void:
	task_status_option_button.item_selected.connect(_on_task_completed_status_changed)
	
	self.mouse_filter = Control.MOUSE_FILTER_STOP

	SignalBus.text_input_submitted_by_user.connect(_on_text_input_submitted_by_user)
	SignalBus.conformation_menu_option_selected.connect(_on_conformation_menu_option_selected)

	SignalBus.right_click_menu_option_selected.connect(_on_right_click_menu_option_selected)

	refresh()


func setup(new_task_id: int) -> void:
	task_id = new_task_id
	refresh()


func refresh() -> void:
	var task: Task = _get_task()

	if task == null:
		return

	task_name = task.task_name
	task_status = task.task_status

	_refresh_ui()


# ===============================================================
# STATUS MANAGEMENT
# ===============================================================
func _on_task_completed_status_changed(option_button_index: int) -> void:
	var new_status: String = (
		task_status_option_button.get_item_text(option_button_index)
	)

	# Set the status by grabbing the value from the constants
	InfoGetter.get_task_manager().set_task_status(task_id, Constants.TASK_STATUS_OPTIONS[new_status])


# ===============================================================
# REFRESH UI
# ===============================================================
func _refresh_ui() -> void:
	_refresh_task_name()
	_refresh_status_option_button()


func _refresh_task_name() -> void:
	task_name_label.text = task_name


func _refresh_status_option_button() -> void:
	task_status_option_button.clear()

	for option in Constants.TASK_STATUS_OPTIONS:
		task_status_option_button.add_item(option)


# ===============================================================
# TASK GETTER
# ===============================================================
func _get_task() -> Task:
	return InfoGetter.get_task_manager().get_task_by_task_id(task_id)

# ===============================================================
# Right Click Management
# ===============================================================

func _gui_input(event: InputEvent) -> void:
	_detect_right_mouse_click(event)

func _detect_right_mouse_click(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return

	# Check if it's the right mouse button and it was just pressed down
	if event.button_index != MOUSE_BUTTON_RIGHT or not event.pressed:
		return
	
	_open_right_click_menu()

func _get_list_of_right_click_menu_options() -> Array[String]:
	var list_of_options: Array[String] = Constants.TASK_MANAGER_RIGHT_CLICK_MENU_OPTIONS.duplicate()
	
	for option in Constants.TASK_ITEM_SCENE_EXTRA_OPTIONS:
		list_of_options.push_front(option)

	return list_of_options

func _open_right_click_menu() -> void:
	SignalBus.popup_right_click_menu.emit(self, _get_list_of_right_click_menu_options(), get_global_mouse_position())

func _on_right_click_menu_option_selected(request_sender: Node, selected_option: String) -> void:
	if request_sender != self:
		return
	
	if selected_option in Constants.TASK_MANAGER_RIGHT_CLICK_MENU_OPTIONS:
		get_tree().get_first_node_in_group("task_manager_ui").handle_right_click_menu_selection(selected_option)
		return

	match selected_option:
		"Remove this task":
			_handle_removing_of_task()
		"Rename this task":
			_handle_renaming_of_task()

func _handle_removing_of_task() -> void:
	var conformation_question: String = "Are you sure you want to delete the task: " + task_name + "?"

	SignalBus.popup_conformation_menu.emit(self, conformation_question, "Yes", "No", "remove task")

func _handle_renaming_of_task() -> void:
	var text_input_question: String = "Enter the new name of the task: " + task_name

	SignalBus.get_text_input_from_user.emit(text_input_question, "rename task", self, "\"" + task_name + "\"")

func _on_conformation_menu_option_selected(request_sender: Node, conformed: bool, tag: String) -> void:
	if request_sender != self:
		return
	
	if not conformed:
		return
	
	if tag == "remove task":
		InfoGetter.get_task_manager().remove_task(task_id)
		SignalBus.refresh_ui.emit()
		return

func _on_text_input_submitted_by_user(text_sumitted: String, tag: String, request_sender: Node) -> void:
	if request_sender != self:
		return
	
	if tag == "rename task":
		_get_task().task_name = text_sumitted
		SignalBus.refresh_ui.emit()
		return