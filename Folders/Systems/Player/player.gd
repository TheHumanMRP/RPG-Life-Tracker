extends CharacterBody2D

## Player character controller.
##
## Handles player movement, health, respawning, and player input.
## Movement and health logic are delegated to their respective
## components.

# --------------------------------------------------------------------
# Components
# --------------------------------------------------------------------

## Handles the player's health.
@export var health_component: HealthComponent = HealthComponent.new()

## Handles the player's movement.
@export var movement_component: MovementComponent = MovementComponent.new()

# --------------------------------------------------------------------
# Spawn
# --------------------------------------------------------------------

## The position the player respawns at.
@export var spawn_point: Vector2

# --------------------------------------------------------------------
# Movement Component Configuration
# --------------------------------------------------------------------

# Pixel Art movement configuration:
#
# movement_component.set_movement_component_values(
# 	200, 500, 200, 1500, 200, 2.5, 200, 600, 0.12
# )

func _ready() -> void:
	# Add the player to its group for easier lookup.
	add_to_group("player")

	# Connect all required signals.
	_connect_signals()

	# Ensure all required components exist.
	_setup_component()


## Connects all component and global signals.
func _connect_signals() -> void:
	# Health component signals.
	health_component.died.connect(dies)
	health_component.damage_taken.connect(damage_taken)

	# Global signal bus.
	SignalBus.respawn_player.connect(respawn)


## Ensures every required component exists.
##
## Creates a default component if one has not been assigned.
func _setup_component() -> void:
	if not health_component:
		health_component = HealthComponent.new()

	if not movement_component:
		movement_component = MovementComponent.new()


## Sets the player's spawn point and respawns them.
func setup(new_spawn_point: Vector2) -> void:
	spawn_point = new_spawn_point
	respawn()


## Respawns the player at the current spawn point.
##
## Also resets the player's velocity and health.
func respawn() -> void:
	print("\nPlayer: Respawnning")

	global_position = spawn_point
	velocity = Vector2.ZERO

	health_component.reset()


## Returns the player's horizontal movement direction.
##
## Returns:
## - `-1` when moving left.
## - `1` when moving right.
## - `0` when idle or when both directions are pressed.
func _get_axis() -> int:
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")

	var direction = int(right) - int(left)

	return direction


func _physics_process(delta: float) -> void:
	# Get the player's movement direction.
	var x_direction = _get_axis()

	# Check if the player wants to jump.
	var jump: bool = Input.is_action_just_pressed("jump")

	# Calculate the new velocity.
	velocity = movement_component.get_velocity(
		velocity,
		x_direction,
		is_on_floor(),
		is_on_wall_only(),
		get_wall_normal().x,
		jump,
		delta
	)

	print("Player: Here's the get_wall_normal.x: ", get_wall_normal().x)

	# Move the player.
	move_and_slide()


## Instantly kills the player.
func kill_self() -> void:
	health_component.die()


## Damages the player.
func take_damage(amount: float) -> void:
	health_component.take_damage(amount)


## Heals the player.
func heal(amount: float) -> void:
	health_component.heal(amount)


## Called whenever the player takes damage.
##
## Plays a brief red flash to indicate the hit.
func damage_taken(new_health: float) -> void:
	print("\nPlayer: Health Changed to ", new_health)

	var tween := create_tween()

	tween.tween_property(self, "modulate", Color.RED, 0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.1)

	await tween.finished


## Called when the player's health reaches zero.
##
## Emits the global respawn signal.
func dies() -> void:
	SignalBus.respawn_player.emit()