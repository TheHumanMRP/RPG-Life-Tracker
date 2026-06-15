extends CharacterBody2D

@export var health_component: HealthComponent = HealthComponent.new()
@export var movement_component: MovementComponent = MovementComponent.new()

@export var spawn_point: Vector2

# Movement component config
"movement_component.set_movement_component_values(200, 500, 200, 1500, 200, 2.5, 200, 600, 0.12)"

func _ready() -> void:
	# Add to the group for easier coding
	self.add_to_group("player")

	# made a separate func to keep the code clean
	_connect_signals()

	# Setup all the components

func _connect_signals() -> void:
	# Health Component
	health_component.died.connect(dies)
	health_component.damage_taken.connect(damage_taken)

	# Signal Bus
	SignalBus.respawn_player.connect(respawn)

func _setup_component() -> void:
	if not health_component:
		health_component = HealthComponent.new()

	if not movement_component:
		movement_component = MovementComponent.new()


func setup(new_spawn_point: Vector2) -> void:
	spawn_point = new_spawn_point
	respawn()


func respawn() -> void:
	print("\nPlayer: Respawnning")
	global_position = spawn_point
	velocity = Vector2(0, 0)
	health_component.reset()

func _get_axis() -> int:
	var left = Input.is_action_pressed("move_left")
	var right = Input.is_action_pressed("move_right")

	var direction = int(right) - int(left)

	return direction

func _physics_process(delta: float) -> void:
	# Get direction through _get_axis()
	var x_direction = _get_axis()

	# Check for jumps
	var jump: bool = Input.is_action_just_pressed("jump")

	# Ger velocity
	velocity = movement_component.get_velocity(velocity, x_direction, is_on_floor(), jump, delta)

	# Execute movement
	move_and_slide()

func kill_self() -> void:
	health_component.die()

func take_damage(amount: float) -> void:
	health_component.take_damage(amount)

func damage_taken(new_health: float) -> void:
	print("\nPlayer: Health Changed to ", new_health)
	var tween := create_tween()

	tween.tween_property(self , "modulate", Color.RED, 0.1)
	tween.tween_property(self , "modulate", Color.WHITE, 0.1)

	await tween.finished

func dies() -> void:
	SignalBus.respawn_player.emit()