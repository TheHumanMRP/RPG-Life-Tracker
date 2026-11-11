@tool
extends Control

@export var button: Button

func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	print("Dungeon Room Editor initialized!")

func _on_button_pressed() -> void:
	print("Button pressed!")