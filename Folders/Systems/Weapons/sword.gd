extends Area2D

@onready var attack_component: AttackComponent = AttackComponent.new()

func attack() -> void:
	var things_in_attack_range: Array = 