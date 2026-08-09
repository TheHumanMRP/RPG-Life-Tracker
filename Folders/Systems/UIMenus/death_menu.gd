extends PanelContainer

@onready var respawn_button: Button = $%Respawn_Button
@onready var main_menu_button: Button = $%Main_Menu_Button
@onready var you_died_label: Label = $%You_Died_Label

func _ready() -> void:
	respawn_button.pressed.connect()

func _on_respawn_button_pressed