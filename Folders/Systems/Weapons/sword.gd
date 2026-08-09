class_name SwordScene
extends Area2D

@onready var attack_component: AttackComponent = AttackComponent.new()

func face_where_player_is_facing(player_looking_direction: int) -> void:
	pass

func attack() -> void:
	var nodes_in_attack_range: Array[Node2D] = self.get_overlapping_bodies()

	for node in nodes_in_attack_range:
		if not node.is_in_group("enemies"):
			continue
		
		attack_component.attack_target(node)