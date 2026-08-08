class_name RespawnManager
extends RefCounted

@export var respawn_point: Vector2

func setup(new_spawn_point: Vector2) -> void:
	respawn_point = new_spawn_point
	respawn()