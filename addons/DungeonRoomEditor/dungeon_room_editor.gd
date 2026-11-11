@tool
extends Control

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	print("Dungeon Room Editor initialized!")
