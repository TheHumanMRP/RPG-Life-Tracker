extends CanvasLayer

func _init() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.TaskManager)
	SignalBus.right_click_menu_option_selected.connect(_on_right_click_menu_option_selected)

func _on_right_click_menu_option_selected(option: String) -> void:
	match option:
		"Add Task":
			pass

func _ready() -> void:
	_set_propogation()

func _set_propogation() -> void:
	self.mouse_filter = Control.MOUSE_FILTER_STOP

	var children: Array[Control] = get_children() as Array[Control]

	for child in children:
		child.mouse_filter = Control.MOUSE_FILTER_PASS