extends Node

signal refresh_ui
signal inventory_changed(new_inventory: Array[ItemEntry])
signal respawn_player

func _ready() -> void:
	await get_tree().process_frame
	refresh_ui.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Respawn"):
		respawn_player.emit()