class_name AttackComponent
extends RefCounted

@export var attack_power: int = 100

func setup(new_attack_power: int) -> void:
	attack_power = new_attack_power

func attack_target(target: Node) -> void:
	if not target.has_method("take_damage"):
		return

	target.take_damage(attack_power)
