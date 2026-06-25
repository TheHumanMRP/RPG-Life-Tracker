extends CharacterBody2D

## Player character controller.
##
## Handles player movement, health, respawning, and input.
## The player delegates movement and health logic to their
## respective components.

# --------------------------------------------------------------------
# Components
# --------------------------------------------------------------------

## Handles the player's health, damage, healing, and death.
@export var health_component: HealthComponent = HealthComponent.new()

## Handles all movement calculations.
@export var movement_component: MovementComponent = MovementComponent.new()

# --------------------------------------------------------------------
# Spawn
# --------------------------------------------------------------------

## Position where the player will respawn.
@export var spawn_point: Vector2

# --------------------------------------------------------------------
# Movement Component Configuration
# --------------------------------------------------------------------

# movement_component.set_movement_component_values(
# 	200,   # Max speed
# 	500,   # Acceleration
# 	200,   # Deceleration
# 	1500,  # Gravity
# 	200,   # Jump velocity
# 	2.5,   # Jump buffer / coyote time (depending on implementation)
# 	200,   # Air acceleration
# 	600,   # Max fall speed
# 	0.12   # Additional movement parameter
# )

func _ready() -> void:
	# Add the player to the "player" group for easier lookup.
	add_to_group("player")

	# Connect all required signals.
	_connect_signals()

	# Setup all components if required.
	_setup_component()


## Connects all component and global signals used by the player.
func _connect_signals() -> void:
	# Health Component
	health_component.died.connect(dies)
	health_component.damage_taken.connect(damage_taken)

	# Global Signal Bus
	SignalBus.respawn_player.connect(respawn)


## Ensures all required components exist.
func _setup_component() -> void:
	if not health_component:
		health_component = HealthComponent.new()

	if not movement_component:
		movement_component = MovementComponent.new()


## Sets the player's spawn point and immediately respawns them there.
##
## @param new_spawn_point The position to use for future respawns.
func setup(new_spawn_point: Vector2) -> void:
	spawn_point = new_spawn_point
	respawn()


## Respawns the player at the current spawn point.
##
## Resets the player's position, velocity, and health.
func respawn() -> void:
	print("\nPlayer: Respawnning")

	global_position = spawn_point
	velocity = Vector2(0, 0)

	health_component.reset()


## Returns the current horizontal input direction.
##
## Returns:
## - `-1` when moving left.
## - `1` when moving right.
## - `0` when no movement keys are pressed or both are pressed.
func _get_axis() -> int:
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")

	var direction = int(right) - int(left)

	return direction


func _physics_process(delta: float) -> void:
	# Read horizontal movement input.
	var x_direction = _get_axis()

	# Check if the player has attempted to jump this frame.
	var jump: bool = Input.is_action_just_pressed("jump")

	# Calculate the new velocity using the movement component.
	velocity = movement_component.get_velocity(
		velocity,
		x_direction,
		is_on_floor(),
		jump,
		delta
	)

	# Apply movement.
	move_and_slide()


## Instantly kills the player.
func kill_self() -> void:
	health_component.die()


## Damages the player.
##
## @param amount Amount of health to remove.
func take_damage(amount: float) -> void:
	health_component.take_damage(amount)


## Heals the player.
##
## @param amount Amount of health to restore.
func heal(amount: float) -> void:
	health_component.heal(amount)


## Called whenever the player's health changes after taking damage.
##
## Creates a brief red flash effect.
##
## @param new_health The player's current health after damage.
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