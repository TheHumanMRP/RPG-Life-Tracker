class_name RespawnManagerComponent
extends RefCounted

@export var respawn_point: Vector2

var user: Node

func setup(new_spawn_point: Vector2, new_user: Node) -> void:
	respawn_point = new_spawn_point
	user = new_user
	respawn()

func respawn() -> void:
	user.global_position = respawn_point
	user.velocity = Vector2.ZERO

	user.reset()