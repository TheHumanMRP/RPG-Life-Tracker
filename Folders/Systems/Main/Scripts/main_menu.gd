class_name MainMenu
extends Control

@export var main_menu_label: Label
@export var dungeon_selection_menu_button: Button
@export var task_manager_button: Button
@export var quit_game_button: Button

# ==============================================
# Initialize
# ==============================================
func _init() -> void:
	_set_global_state()

func _ready() -> void:
	self.add_to_group("main_menu")
	_setup_signals()
	_set_mouse_filters()

# ==============================================
# Setup
# ==============================================
func _set_global_state() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.MainMenu)

func _setup_signals() -> void:
	dungeon_selection_menu_button.pressed.connect(_on_dungeon_selection_menu_button_pressed)
	task_manager_button.pressed.connect(_on_task_manager_button_pressed)
	quit_game_button.pressed.connect(_on_quit_game_button_pressed)
	SignalBus.right_click_menu_option_selected.connect(_on_right_click_menu_option_selected)

func _set_mouse_filters() -> void:
	self.mouse_filter = Control.MOUSE_FILTER_STOP

	var children: Array[Node] = get_children()

	for child in children:
		child.mouse_filter = Control.MOUSE_FILTER_PASS

# ==============================================
# Handling Input
# ==============================================
func _on_dungeon_selection_menu_button_pressed() -> void:
	SignalBus.switch_scene.emit(self, Constants.PATH_TO_DUNGEON_SELECTION_MENU, true)

func _on_task_manager_button_pressed() -> void:
	SignalBus.switch_scene.emit(self, Constants.PATH_TO_TASK_MANAGER, true)

func _on_quit_game_button_pressed() -> void:
	SignalBus.quit_game.emit()

# ==============================================
# Right Click Menu
# ==============================================
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
	SignalBus.popup_right_click_menu.emit(Constants.MAIN_MENU_RIGHT_CLICK_MENU_OPTIONS, get_global_mouse_position())


func _on_right_click_menu_option_selected(option: String) -> void:
	match option:
		"Quit Game":
			SignalBus.quit_game.emit()