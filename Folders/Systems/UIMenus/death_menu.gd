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

	Global.signal_bus.player_died.connect(_on_player_died)

func _on_player_died() -> void:
	print("\nDeath Menu: PLayer Died signal received")

	await get_tree().create_timer(0.5).timeout

	set_global_state()

	show()

func _on_respawn_button_pressed() -> void:
	Global.signal_bus.respawn_player.emit()

	print("\nDeath Menu: Respawn Button Pressed")

	hide()

func _on_main_menu_button_pressed() -> void:
	Global.info_getter.get_main_node().switch_to_scene(self, Constants.PATH_TO_MAIN_MENU, true)

func set_global_state() -> void:
	Global.signal_bus.set_game_state.emit(All_Enums.GAME_STATES.UIMenu)
