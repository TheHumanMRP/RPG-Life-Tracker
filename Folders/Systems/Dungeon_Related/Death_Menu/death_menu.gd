extends CanvasLayer

@export var quit_dungeon_button: Button
@export var return_button: Button
@export var you_died_label: Label

func _ready() -> void:
	setup_properties()

	setup_signals()

func setup_signals() -> void:
	respawn_button.pressed.connect(_on_quit_dungeon_button_pressed)
	return_button.pressed.connect(_on_return_button_pressed)
	
	SignalBus.player_died.connect(_on_player_died)
	SignalBus.conformation_menu_option_selected.connect(_on_conformation_menu_option_selected)

func setup_properties() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	self.hide()

	you_died_label.text = "You Died!"

func _on_player_died() -> void:
	print("\nDeath Menu: PLayer Died signal received")

	await get_tree().create_timer(0.5).timeout

	set_global_state_death_menu()

	self.show()

func _on_quit_dungeon_button_pressed() -> void:
	SignalBus.respawn_player.emit()

	set_global_state_dungeon_playing()

	self.hide()

	print("\nDeath Menu: Respawn Button Pressed")

func _on_return_button_pressed() -> void:
	SignalBus.popup_conformation_menu.emit(self, "Are you sure you want to quit the dungeon?", "Yes", "No", "quit dungeon")

func set_global_state_death_menu() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DeathMenu)

func set_global_state_dungeon_playing() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DungeonPlaying)

func _on_conformation_menu_option_selected(request_sender: Node, conformed: bool, tag: String) -> void:
	if request_sender != self:
		return
	
	if not conformed:
		return
	
	match tag:
		"quit dungeon":
			SignalBus.switch_scene.emit(self, Constants.PATH_TO_MAIN_MENU, true)