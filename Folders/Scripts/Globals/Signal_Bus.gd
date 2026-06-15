extends Node

signal respawn_player

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Respawn"):
		respawn_player.emit()