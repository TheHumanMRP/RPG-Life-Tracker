class_name Entity
extends Node

var health_component: HealthComponent
var movement_component: MovementComponent

func setup(new_max_health: int) -> void:
    health_component.setup()