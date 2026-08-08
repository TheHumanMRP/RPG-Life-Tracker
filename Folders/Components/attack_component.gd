class_name AttackComponent
extends RefCounted

@export var attack_power: int = 100

func setup(new_attack_power: int) -> void:
	attack_power = new_attack_power

func attack_target(target: Node) -> void:
	if not "health_component" in target:
		return

	target.health_component.take_damage(attack_power)

func insta_kill_target(target: Node) -> void:
	if not "health_component" in target:
		return
	
	target.health_component.kill_self()