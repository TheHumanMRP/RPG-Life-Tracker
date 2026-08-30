class_name Player
extends CharacterBody2D

## Player character controller handling movement, health, and respawning.

signal facing_direction_changed(new_direction: int)

# --------------------------------------------------------------------
# Vars
# --------------------------------------------------------------------

var health_component: HealthComponent
var movement_component: MovementComponent
var inventory_logic_component: InventoryLogicComponent

var facing_direction: int

# --------------------------------------------------------------------
# Exported vars
# --------------------------------------------------------------------

@export var spawn_point: Vector2
@export var equipment_manager: EquipmentManager

# --------------------------------------------------------------------
# Lifecycle
# --------------------------------------------------------------------

## Sets the player's spawn point and respawns them.
func setup(new_spawn_point: Vector2) -> void:
	add_to_group("player")
	_setup_component()
	_connect_signals()

	spawn_point = new_spawn_point
	respawn()

## Connects all required signals.
func _connect_signals() -> void:
	health_component.died.connect(_on_player_died)
	health_component.damage_taken.connect(_on_damage_taken)

	SignalBus.respawn_player.connect(respawn)


## Ensures all required components exist.
func _setup_component() -> void:
	facing_direction = 1

	health_component = HealthComponent.new()
	movement_component = MovementComponent.new()
	inventory_logic_component = InventoryLogicComponent.new()

	var player_max_health: int = InfoGetter.get_player_max_health()
	health_component.setup(player_max_health, "Player")
	
	inventory_logic_component.setup(Constants.PLAYER_INVENTORY_NAME)

func _process(delta: float) -> void:
	if health_component.dead:
		return
# --------------------------------------------------------------------
# Spawn & Respawn
# --------------------------------------------------------------------

## Respawns the player.
func respawn() -> void:
	print("\nPlayer: Respawning")

	global_position = spawn_point
	velocity = Vector2.ZERO

	movement_component.reset()
	health_component.reset()

# --------------------------------------------------------------------
# Movement
# --------------------------------------------------------------------

## Returns the horizontal input axis.
func _get_axis() -> int:
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")

	return int(right) - int(left)

func _physics_process(delta: float) -> void:
	if health_component.dead:
		return

	var x_direction = _get_axis()

	_update_facing_direction(x_direction)

	var jump := Input.is_action_just_pressed("jump")

	velocity = movement_component.get_velocity(
		velocity,
		x_direction,
		is_on_floor(),
		is_on_wall(),
		round(get_wall_normal().x),
		jump,
		delta
	)

	move_and_slide()

func _update_facing_direction(direction: int) -> void:
	if direction == 0:
		return

	if direction != facing_direction:
		print("\nPlayer: Facing direction changed signal emitted")
		facing_direction = direction
		facing_direction_changed.emit(facing_direction)

# --------------------------------------------------------------------
# Health
# --------------------------------------------------------------------

## Plays the damage flash effect.
func _on_damage_taken(new_health: float) -> void:
	print("\nPlayer: Health Changed to ", new_health)

	var tween := create_tween()

	tween.tween_property(self, "modulate", Color.RED, 0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.1)

	await tween.finished

## Handles player death.
func _on_player_died() -> void:
	SignalBus.player_died.emit()

	# TO-DO: Add player death animation here 
