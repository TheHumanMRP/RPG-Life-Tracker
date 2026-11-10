@tool
extends Area2D

# ==================================================
# Vars
# ==================================================

var damage_area_resource: DamageAreaResource
@export var collision_shape: CollisionShape2D
@onready var timer: Timer = $%Timer

# ==================================================
# Lifecycle
# ==================================================

func _ready() -> void:
	assert(damage_area_resource, "Dungoen Area: No Damage Area Resource!")

	timer.wait_time = damage_area_resource.interval_in_seconds
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

	if not damage_area_resource.one_time_damage:
		timer.start()

# Applies damage to all valid overlapping bodies.
func damage() -> void:
	var attack_component: AttackComponent = AttackComponent.new()

	attack_component.setup(damage_area_resource.damage_per_interval)

	var bodies: Array = get_overlapping_bodies()

	for body in bodies:
		if damage_area_resource.player_only and not body.is_in_group("player"):
			continue

		if damage_area_resource.insta_kill:
			attack_component.insta_kill_target(body)
			continue
		
		attack_component.attack_target(body)

func setup(new_damage_area_resource: DamageAreaResource) -> void:
	damage_area_resource = new_damage_area_resource

	(collision_shape.shape as RectangleShape2D).size = Vector2(damage_area_resource.width, damage_area_resource.height)

	self.position = damage_area_resource.position