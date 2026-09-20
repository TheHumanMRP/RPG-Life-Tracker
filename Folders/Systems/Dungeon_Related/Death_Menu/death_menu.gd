extends CanvasLayer

@onready var respawn_button: Button = $%Respawn_Button
@onready var main_menu_button: Button = $%Main_Menu_Button
@onready var you_died_label: Label = $%You_Died_Label

func _ready() -> void:
	print("\nDeath Menu: _ready func called")

	self.process_mode = Node.PROCESS_MODE_ALWAYS
	self.hide()

	respawn_button.pressed.connect(_on_respawn_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)

	you_died_label.text = "You Died!"

	SignalBus.player_died.connect(_on_player_died)

func _on_player_died() -> void:
	print("\nDeath Menu: PLayer Died signal received")

	await get_tree().create_timer(0.5).timeout

	set_global_state_death_menu()

	show()

func _on_respawn_button_pressed() -> void:
	SignalBus.respawn_player.emit()

	set_global_state_dungeon_playing()

	print("\nDeath Menu: Respawn Button Pressed")

	self.queue_free()

func _on_main_menu_button_pressed() -> void:
	Global.main_node.switch_to_scene(self, Constants.PATH_TO_MAIN_MENU, true)

func set_global_state_death_menu() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DeathMenu)

func set_global_state_dungeon_playing() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DungeonPlaying)