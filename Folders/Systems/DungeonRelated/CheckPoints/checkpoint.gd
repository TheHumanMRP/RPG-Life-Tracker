extends Area2D

const levitate_amount: float = 100.0

# Prevents making running 2 times if player enters again
var is_claimed: bool = false
var checkpoint_resource: CheckpointResource

@export var collision_area: CollisionShape2D
@export var display_texture: Sprite2D

func _ready() -> void:
	# Crash game if checkpoint resource not found
	assert(checkpoint_resource, "Checkpoint: No Checkpoint Resource")

func _setuo() -> void:
	collision_area.move_local_x()
	global_position = checkpoint_resource.respawn_location


func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player") or is_claimed:
		return

	body.spawn_point = checkpoint_resource.respawn_location
	
	claim()
	
func claim() -> void:
	is_claimed = true

	var tween := create_tween()
	var new_global_position: Vector2 = Vector2(global_position.x, global_position.y - levitate_amount)

	tween.parallel().tween_property(self, "modulate:a", 0.0, 1.0)

	tween.parallel().tween_property(self, "global_position", new_global_position, 1)

	await tween.finished

	queue_free()