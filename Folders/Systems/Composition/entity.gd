class_name HealthManager
extends Node

var health_component: HealthComponent

func setup(user_name: String, max_health: int, user: Node, spawn_point: Vector2) -> void:
	health_component = HealthComponent.new()
	health_component.setup(max_health, user_name)

func take_damage(amount: float) -> void:
	health_component.take_damage(amount)

func heal(amount: float) -> void:
	health_component.heal(amount)

func kill_self() -> void:
	health_component.kill_self()