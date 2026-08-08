class_name HealthComponent
extends Node

@export var owner_name: String = "None"
@export var max_health: int = 100
var health: float:
	set(new_health):
		new_health = clamp(new_health, 0, max_health)

		if new_health < health:
			print("\nHealth Component [, ", owner_name, "]: Damage Taken signal emitted")
			damage_taken.emit(new_health)
		elif new_health > health:
			healed.emit(new_health)

		health = new_health

		check_if_dead()

var dead: bool

signal died
signal damage_taken(new_health)
signal healed(new_health)

func setup(new_max_health: int, new_owner_name: String) -> void:
	max_health = new_max_health
	owner_name = new_owner_name

	print("\nHealth Component: ")

func _init() -> void:
	call_deferred("reset")

func reset() -> void:
	health = max_health
	dead = false
	print("\nHealth Component: Reset Func Called, here's the dead var: ", dead)

func take_damage(amount: float) -> void:
	health -= amount

func heal(amount: float) -> void:
	health += amount

func check_if_dead() -> void:
	print("\nHealth Component: Check if dead called: here's health and dead brother: ", health, ", ", dead)
	if health == 0 and not dead:
		dead = true
		died.emit()

func die() -> void:
	health = 0