class_name HealthComponent
extends Node

@export var log_name: String = "None"
@export var max_health: int = 100
var health: float:
	set(new_health):
		health = set_health(new_health)
		check_if_dead()

func set_health(new_health) -> float:
	new_health = clamp(new_health, 0, max_health)

	if new_health < health:
		print("\nHealth Component [", log_name, "]: Damage Taken signal emitted")
		damage_taken.emit(new_health)
	elif new_health > health:
		healed.emit(new_health)

	return new_health


var dead: bool

signal died
signal damage_taken(new_health)
signal healed(new_health)

func setup(new_max_health: int, new_log_name: String) -> void:
	max_health = new_max_health
	log_name = new_log_name

	print("\nHealth Component [", log_name, "]: Setup Done!")

func _init() -> void:
	call_deferred("reset")

func reset() -> void:
	health = max_health
	dead = false
	print("\nHealth Component [", log_name, "]: Reset Func Called, here's the dead var: ", dead)

func take_damage(amount: float) -> void:
	health -= amount

func heal(amount: float) -> void:
	health += amount

func check_if_dead() -> void:
	print("\nHealth Component [", log_name, "]: Check if dead called: here's health and dead brother: ", health, ", ", dead)
	
	if health > 0:
		return
	
	if dead:
		return
	
	dead = true
	died.emit()

func kill_self() -> void:
	health = 0