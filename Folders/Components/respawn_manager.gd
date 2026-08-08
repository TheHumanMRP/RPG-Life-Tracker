class_name RespawnManager
extends RefCounted

@export var respawn_point: Vector2

var user: Node

func setup(new_spawn_point: Vector2, new_user: Node) -> void:
	respawn_point = new_spawn_point
	user = new_user
    respawn()