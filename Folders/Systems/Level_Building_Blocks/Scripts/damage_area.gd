@tool
extends Area2D

# ==================================================
# Settings
# ==================================================

@export var insta_kill: bool = false
@export var player_only: bool = false
@export var one_time_damage: bool = false
@export var damage_per_interval: float = 10.0

@export var interval_in_seconds: float = 1.0:
	set(value):
		if value > 0:
			interval_in_seconds = value
			return

		push_error("Interval should be greater than 0.")

@export var width: float = 64.0:
	set(value):
		width = value
		_update_collision()

@export var height: float = 64.0:
	set(value):
		height = value
		_update_collision()

# ==================================================
# Vars
# ==================================================

@onready var timer: Timer = $%Timer

# ==================================================
# Lifecycle
# ==================================================

func _ready() -> void:
	_update_collision()

	timer.wait_time = interval_in_seconds
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

	if not one_time_damage:
		timer.start()

# Applies damage to all valid overlapping bodies.
func damage() -> void:
	var attack_component: AttackComponent = AttackComponent.new()

	attack_component.setup(damage_per_interval)

	var bodies: Array = get_overlapping_bodies()

	for body in bodies:
		if player_only and not body.is_in_group("player"):
			continue

		if insta_kill:
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

	(collision_shape.shape as RectangleShape2D).size = Vector2(width, height)
