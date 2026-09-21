class_name MovementComponent
extends Node

@export_group("Movement")
@export var max_speed: float = 600.0
@export var acceleration: float = 2500.0
@export var air_acceleration: float = 1000.0
@export var friction: float = 1500.0
@export var air_resistance: float = 200.0
@export var turn_friction_multiplier: float = 2.5

@export_group("Jumping")
@export var jump_force: float = 400
@export var wall_jump_force: float = 800
@export var allow_wall_jump: bool = true
@export var allow_air_jump: bool = true
@export var coyote_time: float = 0.12

@export_group("Gravity")
@export var gravity: float = 1000.0
@export var increase_gravity_while_falling: bool = true
@export var gravity_multiplier_while_falling: float = 1.5

var jumped: bool = false
var air_jumped: bool = false
var coyote_timer = 0

func get_velocity(
	current_velocity: Vector2,
	direction: int,
	is_on_floor: bool,
	is_on_wall: bool,
	wall_dir: int,
	jump: bool,
	delta: float
) -> Vector2:
	var velocity := current_velocity

	# Apply gravity
	if not is_on_floor:
		if increase_gravity_while_falling and velocity.y > 0 and jumped:
			velocity.y += gravity * gravity_multiplier_while_falling * delta
		else:
			velocity.y += gravity * delta

	coyote_timer += delta

	if is_on_floor:
		velocity.y = 0
		coyote_timer = 0
		jumped = false
		air_jumped = false
		
	# Jump
	velocity = handle_jump(velocity, is_on_wall, is_on_floor, wall_dir, jump)

	# Decelerate when no input
	if direction == 0:
		var decel := friction if is_on_floor else air_resistance
		velocity.x = move_toward(velocity.x, 0.0, decel * delta)
		return velocity

	# Accelerate toward max speed
	var accel := acceleration if is_on_floor else air_acceleration
	var is_turning := signf(direction) != signf(velocity.x) and velocity.x != 0
	if is_turning:
		accel *= turn_friction_multiplier

	velocity.x = move_toward(velocity.x, direction * max_speed, accel * delta)

	return velocity

func handle_jump(velocity: Vector2, is_on_wall: bool, is_on_floor: bool, wall_dir: int, jump: bool) -> Vector2:
	if jump:
		jumped = true

		if is_on_floor:
			velocity.y = - jump_force
			return velocity

		if is_on_wall:
			velocity.x = wall_dir * wall_jump_force
			velocity.y = - jump_force
			return velocity

		if not air_jumped and not is_on_floor:
			air_jumped = true
			velocity.y = - jump_force
			return velocity

	return velocity

func reset() -> void:
	jumped = false
	air_jumped = false
	coyote_timer = 0