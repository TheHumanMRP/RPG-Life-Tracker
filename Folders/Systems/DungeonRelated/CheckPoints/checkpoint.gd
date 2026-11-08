extends Area2D

@export var levitate_amount: float = 100.0

var respawn_location: Vector2

var is_claimed: bool = false

func _ready() -> void:
	respawn_location = global_position


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or is_claimed:
		return

	body.spawn_point = respawn_location
	
	mark_as_claimed()
	
func mark_as_claimed() -> void:
	is_claimed = true

	var tween := create_tween()
	var new_global_position: Vector2 = Vector2(global_position.x, global_position.y - levitate_amount)

	tween.parallel().tween_property(self, "modulate:a", 0.0, 1.0)

	tween.parallel().tween_property(self, "global_position", new_global_position, 1)

	await tween.finished

	queue_free()