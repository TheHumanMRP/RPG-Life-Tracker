extends CharacterBody2D

## Player character controller handling movement, health, and respawning.

# --------------------------------------------------------------------
# Vars
# --------------------------------------------------------------------

var health_component: HealthComponent = HealthComponent.new()
var movement_component: MovementComponent = MovementComponent.new()
var inventory_logic_component: InventoryLogicComponent = InventoryLogicComponent.new()

@onready var sword: SwordNode = $Sword

# --------------------------------------------------------------------
# Spawn
# --------------------------------------------------------------------

@export var spawn_point: Vector2

# --------------------------------------------------------------------
# Lifecycle
# --------------------------------------------------------------------

func _ready() -> void:
	add_to_group("player")
	_connect_signals()
	_setup_component()


## Connects all required signals.
func _connect_signals() -> void:
	health_component.died.connect(dies)
	health_component.damage_taken.connect(damage_taken)

	SignalBus.respawn_player.connect(respawn)


## Ensures all required components exist.
func _setup_component() -> void:
	if not health_component:
		health_component = HealthComponent.new()
		health_component.setup(100, "Player")
		
	if not movement_component:
		movement_component = MovementComponent.new()

	if not inventory_logic_component:
		inventory_logic_component = InventoryLogicComponent.new()

func _process(delta: float) -> void:
	sword.rotate(0.01)

	if Input.is_action_just_pressed("attack"):
		sword.attack()

# --------------------------------------------------------------------
# Spawn & Respawn
# --------------------------------------------------------------------
## Sets the player's spawn point and respawns them.
func setup(new_spawn_point: Vector2) -> void:
	spawn_point = new_spawn_point
	respawn()


## Respawns the player.
func respawn() -> void:
	print("\nPlayer: Respawning")

	global_position = spawn_point
	velocity = Vector2.ZERO

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
	var x_direction = _get_axis()
	var jump := Input.is_action_just_pressed("jump")

	velocity = movement_component.get_velocity(
		velocity,
		x_direction,
		is_on_floor(),
		is_on_wall(),
		get_wall_normal().x,
		jump,
		delta
	)

	move_and_slide()

# --------------------------------------------------------------------
# Health
# --------------------------------------------------------------------

## Plays the damage flash effect.
func damage_taken(new_health: float) -> void:
	print("\nPlayer: Health Changed to ", new_health)

	var tween := create_tween()

	tween.tween_property(self, "modulate", Color.RED, 0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.1)

	await tween.finished


## Handles player death.
func dies() -> void:
	SignalBus.player_died.emit()
