class_name MainMenu
extends CanvasLayer

@export var main_menu_label: Label
@export var dungeon_selection_menu_button: Button
@export var task_manager_button: Button
@export var quit_game_button: Button

func _init() -> void:
	set_global_state()

func _ready() -> void:
	self.add_to_group("main_menu")
	setup_signals()

func set_global_state() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.MainMenu)

func setup_signals() -> void:
	dungeon_selection_menu_button.pressed.connect(_on_dungeon_selection_menu_button_pressed)
	task_manager_button.pressed.connect(_on_task_manager_button_pressed)
	quit_game_button.pressed.connect(_on_quit_game_button_pressed)
	SignalBus.right_click_menu_option_selected.connect(_on_right_click_menu_option_selected)

func _on_dungeon_selection_menu_button_pressed() -> void:
	SignalBus.switch_scene.emit(self, Constants.PATH_TO_DUNGEON_SELECTION_MENU, true)

func _on_task_manager_button_pressed() -> void:
	SignalBus.switch_scene.emit(self, Constants.PATH_TO_TASK_MANAGER, true)

func _on_quit_game_button_pressed() -> void:
	SignalBus.quit_game.emit()


func _on_right_click_menu_option_selected(option: String) -> void:
	match option:
		"Quit Game":
			SignalBus.quit_game.emit()