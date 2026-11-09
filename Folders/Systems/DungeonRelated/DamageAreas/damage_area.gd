@tool
extends Area2D

# ==================================================
# Vars
# ==================================================

@export var dungeon_area_resource: DungeonAreaResource
@onready var timer: Timer = $%Timer

# ==================================================
# Lifecycle
# ==================================================

func _ready() -> void:
	_update_collision()

	timer.wait_time = dungeon_area_resource.interval_in_seconds
	timer.timeout.connect(damage)

# ==================================================
# Signal Callbacks
# ==================================================

func _on_body_entered(body: Node2D) -> void:
	scan()

# ==================================================
# Public Methods
# ==================================================

# Starts a damage scan and, if enabled,
# begins periodic damage ticks.
func scan() -> void:
	var bodies = get_overlapping_bodies()

	if not bodies.size() > 0:
		timer.stop()
		return

	damage()

	if not dungeon_area_resource.one_time_damage:
		timer.start()

# Applies damage to all valid overlapping bodies.
func damage() -> void:
	var attack_component: AttackComponent = AttackComponent.new()

	attack_component.setup(dungeon_area_resource.damage_per_interval)

	var bodies: Array = get_overlapping_bodies()

	for body in bodies:
		if dungeon_area_resource.player_only and not body.is_in_group("player"):
			continue

		if dungeon_area_resource.insta_kill:
			attack_component.insta_kill_target(body)
			continue
		
		attack_component.attack_target(body)

# ==================================================
# Internal Methods
# ==================================================

# Updates the collision shape size based on
# the exported width and height values.
func _update_collision() -> void:
	var collision_shape := $%CollisionShape2D

	if collision_shape == null:
		return

	if collision_shape.shape == null:
		collision_shape.shape = RectangleShape2D.new()

	(collision_shape.shape as RectangleShape2D).size = Vector2(dungeon_area_resource.width, dungeon_area_resource.height)
