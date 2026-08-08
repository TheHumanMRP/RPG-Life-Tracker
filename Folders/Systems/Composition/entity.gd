class_name Entity
extends Node

var health_component: HealthComponent
var movement_component: MovementComponent

func setup(new_max_health: int, new_owner_name: String) -> void:
	health_component = HealthComponent.new()
	
	health_component.setup(new_max_health, new_owner_name)

func take_damage(amount: float) -> void:
	health_component.take_damage(amount)

func heal(amount: float) -> void:
	health_component.heal(amount)

func _init() -> void:
	call_deferred("reset")

func reset() -> void:
	health = max_health
	dead = false
	print("\nHealth Component [", owner_name, "]: Reset Func Called, here's the dead var: ", dead)

func check_if_dead() -> void:
	print("\nHealth Component [", owner_name, "]: Check if dead called: here's health and dead brother: ", health, ", ", dead)
	if health == 0 and not dead:
		dead = true
		died.emit()

func kill_self() -> void:
	health = 0