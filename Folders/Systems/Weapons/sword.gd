class_name SwordNode
extends Area2D

@onready var attack_component: AttackComponent = AttackComponent.new()

func attack() -> void:
	var nodes_in_attack_range: Array[Node2D] = self.get_overlapping_bodies()

	for node in nodes_in_attack_range:
		if not node.is_in_group("enemies"):
			continue
		
		attack_component.attack_target(node)