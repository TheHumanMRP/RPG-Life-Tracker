extends Area2D

@onready var attack_component: AttackComponent = AttackComponent.new()

func attack() -> void:
	var : Array[Node2D] = self.get_overlapping_bodies()

	for 