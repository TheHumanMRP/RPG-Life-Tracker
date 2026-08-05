class_name AttackComponent
extends RefCounted

@export var attack_power: int = 100

func setup(new_attack_power: int) -> void:
    attack_power = new_attack_power

