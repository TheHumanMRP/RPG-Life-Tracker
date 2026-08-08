class_name SwordScene
extends Area2D

@onready var attack_component: AttackComponent = AttackComponent.new()

var rotation_speed: float = 5.0

var target_angle: float = global_position.angle_to_point(get_global_mouse_position())

func _process(_delta: float) -> void:
	target_angle = global_position.angle_to_point(get_global_mouse_position())

	rotation = 

func attack() -> void:
	var nodes_in_attack_range: Array[Node2D] = self.get_overlapping_bodies()

	for node in nodes_in_attack_range:
		if not node.is_in_group("enemies"):
			continue
		
		attack_component.attack_target(node)