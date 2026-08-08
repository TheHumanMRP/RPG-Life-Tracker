class_name Entity
extends Node

var health_component: HealthComponent
var movement_component: MovementComponent

func setup(new_max_health: int, new_owner_name: String) -> void:
    health_component.setup(new_max_health, new_owner_name)