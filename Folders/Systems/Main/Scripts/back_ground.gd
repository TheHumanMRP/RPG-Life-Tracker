extends CanvasLayer
class_name Background

@export var background_control_node: Control

func _ready() -> void:
	background_control_node.gui_input.connect(_gui_input)

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
	# Just use an empty array as a null representative
	var right_click_menu_options: Array[String] = []

	match Global.current_game_state:
		All_Enums.GAME_STATES.MainMenu:
			right_click_menu_options = Constants.MAIN_MENU_RIGHT_CLICK_MENU_OPTIONS
		All_Enums.GAME_STATES.TaskManager:
			right_click_menu_options = Constants.TASK_MANAGER_RIGHT_CLICK_MENU_OPTIONS
	
	# Checks if the right_click_menu_options wasn't filled with the match
	# Meaning it's a game state where I don't need the right click menu
	if right_click_menu_options == []:
		return

	SignalBus.popup_right_click_menu.emit(right_click_menu_options, background_control_node.get_global_mouse_position())