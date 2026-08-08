class_name Entity
extends Node

var health_component: HealthComponent
var movement_component: MovementComponent
var respawn_manager: RespawnManager

func setup(user_name: String, max_health: int, user: Node, spawn_point: Vector2) -> void:
	setup_health_component(max_health, user_name)

	setup_respawn_manager(spawn_point, user)

func setup_respawn_manager(spawn_point: Vector2, user: Node) -> void:
	respawn_manager.setup(spawn_point, user)

func setup_health_component(max_health: int, user_name) -> void:
	health_component = HealthComponent.new()
	
	health_component.setup(max_health, user_name)

func take_damage(amount: float) -> void:
	health_component.take_damage(amount)

func heal(amount: float) -> void:
	health_component.heal(amount)

func kill_self() -> void:
	health_component.kill_self()