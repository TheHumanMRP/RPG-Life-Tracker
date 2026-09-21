extends CanvasLayer

@onready var main_menu_label: Label = $%Main_Menu_Label
@onready var dungeon_selection_menu_button: Button = $%Dungoen
@onready var task_manager_button: Button = $%Task_Manager_Button

func _init() -> void:
	set_global_state()

func _ready() -> void:
	setup_labels()
	setup_signals()

func set_global_state() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.MainMenu)

func setup_labels() -> void:
	main_menu_label.text = Constants.MAIN_MENU_LABEL_TEXT
	dungeon_button.text = Constants.MAIN_MENU_DUNGOEN_BUTTON_TEXT
	task_manager_button.text = Constants.MAIN_MENU_TASK_MANAGER_BUTTON_TEXT

	print("\nMain Menu: Setup labels func ran")

func setup_signals() -> void:
	dungeon_button.pressed.connect(_on_dungeon_button_pressed)
	task_manager_button.pressed.connect(_on_task_manager_button_pressed)

func _on_dungeon_button_pressed() -> void:
	Global.main_node.switch_to_scene(self, Constants.PATH_TO_DUNGEON_SELECTION_MENU, true)

func _on_task_manager_button_pressed() -> void:
	Global.main_node.switch_to_scene(self, Constants.PATH_TO_TASK_MANAGER, true)
