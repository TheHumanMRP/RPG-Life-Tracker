extends CanvasLayer

func _init() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.TaskManager)

func _on_right_click_menu_option_selected(option: String) -> void:
	match option:
		"Add Task":
			pass

func _ready() -> void:
	for child in get_children():
		child.mouse_filter = .Propogate