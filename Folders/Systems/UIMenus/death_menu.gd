extends PanelContainer

@onready var respawn_button: Button = $%Respawn_Button
@onready var main_menu_button: Button = $%Main_Menu_Button
@onready var you_died_label: Label = $%You_Died_Label

func _ready() -> void:
	respawn_button.pressed.connect(_on_respawn_button_pressed)

	main_menu_button.pressed.connect(_on_main_menu_button_pressed)

	you_died_label.text = "You Died!"

func _on_respawn_button_pressed() -> void:
	SignalBus.respawn_player.emit()


func _on_main_menu_button_pressed() -> void:
	pass