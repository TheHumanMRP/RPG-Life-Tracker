extends CanvasLayer

@onready var main_menu_label: Label = $%Main_Menu_Label
@onready var dungeon_button: Button = $%Dungoen_Button
@onready var task_manager_button: Button = $%Task_Manager_Button


func _ready() -> void:
	set_global_state()
	setup_labels()
	setup_signals()

	print("\nMain Menu: _ready func ran")

func set_global_state() -> void:
	Global.signal_bus.set_game_state.emit(All_Enums.GAME_STATES.UIMenu)

func setup_labels() -> void:
	main_menu_label.text = Constants.MAIN_MENU_LABEL_TEXT
	dungeon_button.text = Constants.MAIN_MENU_DUNGOEN_BUTTON_TEXT
	task_manager_button.text = Constants.MAIN_MENU_TASK_MANAGER_BUTTON_TEXT

	print("\nMain Menu: Setup labels func ran")

func setup_signals() -> void:
	dungeon_button.pressed.connect(_on_dungeon_button_pressed)
	task_manager_button.pressed.connect(_on_task_manager_button_pressed)

	print("\nMain Menu: Setup signals func ran")

func _on_dungeon_button_pressed() -> void:
	Global.main_node.switch_to_scene(self, Constants.PATH_TO_DUNGEON_SELECTION_MENU, true)

func _on_task_manager_button_pressed() -> void:
	print("\nMain Menu: Task manager button pressed")
