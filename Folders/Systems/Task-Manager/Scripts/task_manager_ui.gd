extends MarginContainer

# ==============================================
# Initialize
# ==============================================
func _init() -> void:
	print("Init called")
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.TaskManager)

func _ready() -> void:
	SignalBus.right_click_menu_option_selected.connect(_on_right_click_menu_option_selected)
	_set_mouse_filter()

# ==============================================
# Setup
# ==============================================
func _set_mouse_filter() -> void:
	self.mouse_filter = Control.MOUSE_FILTER_STOP

	var children: Array[Control] = self.get_children() as Array[Control]

	for child in children:
		child.mouse_filter = Control.MOUSE_FILTER_PASS

# ==============================================
# Handle Input
# ==============================================
func _on_right_click_menu_option_selected(option: String) -> void:
	match option:
		"Add Task":
			pass
	
func _gui_input(event: InputEvent) -> void:
	_detect_right_mouse_click(event)

func _detect_right_mouse_click(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return

	# Check if it's the right mouse button and it was just pressed down
	if event.button_index != MOUSE_BUTTON_RIGHT or not event.pressed:
		return
	
	_open_right_click_menu()

func _open_right_click_menu() -> void:
	SignalBus.popup_right_click_menu.emit(Constants.TASK_MANAGER_RIGHT_CLICK_MENU_OPTIONS, get_global_mouse_position())