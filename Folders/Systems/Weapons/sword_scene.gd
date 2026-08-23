class_name SwordScene
extends Area2D

var damage_power: int
var logo: Texture2D

@onready var attack_component: AttackComponent = AttackComponent.new()

func setup(new_sword: ItemEntry) -> void:
	if new_sword.item_weapon_type != All_Enums.WEAPON_TYPES.Sword:
		push_error("\nSword Scene: Invalid Weapon type!")

func face_where_player_is_facing(player_looking_direction: int) -> void:
	if player_looking_direction == 1:
		rotation_degrees = 0
	elif player_looking_direction == -1:
		rotation_degrees = 180

func attack() -> void:
	var nodes_in_attack_range: Array[Node2D] = self.get_overlapping_bodies()

	for node in nodes_in_attack_range:
		if not node.is_in_group("enemies"):
			continue
		
		attack_component.attack_target(node)