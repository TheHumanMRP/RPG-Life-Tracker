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
    SignalBus.set_game_state.emit(All_Enums.GAME_STATES.UIMenu)

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
    # var packed_dungeon_selection_menu: PackedScene = load(Constants.PATH_TO_DUNGEON_SELECTION_MENU)
    # var dungeon_selection_menu: Node = packed_dungeon_selection_menu.instantiate()
    # var main_node: MainNode = get_tree().get_first_node_in_group("main") as MainNode
    # main_node.switch_to_scene(self, dungeon_selection_menu)
    get_tree().change_scene_to_file(Constants.PATH_TO_DUNGEON_SELECTION_MENU)

func _on_task_manager_button_pressed() -> void:
    print("\nMain Menu: Task manager button pressed")