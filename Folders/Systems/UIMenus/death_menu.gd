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

	Global.current_game_state = Global.GAME_STATES.UIMenu

	show()

func _on_respawn_button_pressed() -> void:
	SignalBus.respawn_player.emit()

	print("\nDeath Menu: Respawn Button Pressed")

	hide()

func _on_main_menu_button_pressed() -> void:
	print("\nDeath Menu: Main Menu Button Pressed")
