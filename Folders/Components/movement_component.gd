class_name MovementComponent
extends Node

@export var max_speed := 700.0
@export var acceleration := 2500.0
@export var air_acceleration := 1000.0
@export var friction := 1500.0
@export var air_resistance := 200.0
@export var turn_friction_multiplier := 2.5
@export var jump_force := 550.0
@export var gravity := 1000.0
@export var wall_jump_force: float = 1000.0
@export var allow_wall_jump: bool = true
@export var allow_air_jump: bool = true
@export var increase_gravity_while_falling: bool = true
@export var gravity_multiplier_while_flling: float = 1.5

@export var coyote_time = 0.12

var jumped: bool = false
var air_jumped: bool = false
var coyote_timer = 0

func set_movement_component_values(
	new_max_speed: float = 700.0,
	new_acceleration: float = 2500.0,
	new_air_acceleration: float = 1000.0,
	new_friction: float = 1500.0,
	new_air_resistance: float = 200.0,
	new_turn_friction_multiplier: float = 2.5,
	new_jump_force: float = 500.0,
	new_gravity: float = 1000.0,
	new_coyote_time: float = 0.12,
	new_wall_jump_force: float = 1000.0,
	new_allow_wall_jump: bool = true,
	new_allow_air_jump: bool = true,
	new_increase_gravity_while_falling: bool = true,
) -> void:
	max_speed = new_max_speed
	acceleration = new_acceleration
	air_acceleration = new_air_acceleration
	friction = new_friction
	air_resistance = new_air_resistance
	turn_friction_multiplier = new_turn_friction_multiplier
	jump_force = new_jump_force
	gravity = new_gravity
	coyote_time = new_coyote_time
	allow_wall_jump = new_allow_wall_jump
	allow_air_jump = new_allow_air_jump
	increase_gravity_while_falling = new_increase_gravity_while_falling

func get_velocity(
	current_velocity: Vector2,
	direction: int,
	is_on_floor: bool,
	is_on_wall: bool,
	wall_dir: float,
	jump: bool,
	delta: float
) -> Vector2:
	var velocity := current_velocity

	# Apply gravity
	if not is_on_floor:
		if increase_gravity_while_falling and velocity.y > 0 and jumped:
			velocity.y += gravity * gravity_multiplier_while_flling * delta
		else:
			velocity.y += gravity * delta

	coyote_timer += delta

	if is_on_floor:
		velocity.y = 0
		coyote_timer = 0
		jumped = false
		air_jumped = false
		
	# Jump
	if jump and not air_jumped:
		velocity.y = - jump_force

		jumped = true
		
		if not is_on_floor:
			air_jumped = true

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