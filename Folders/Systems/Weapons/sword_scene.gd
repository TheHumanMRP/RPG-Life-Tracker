class_name SwordScene
extends Area2D

var sword_item_entry: ItemEntry

var damage_power: int
var logo: Texture2D
var durability: float

@onready var attack_component: AttackComponent = AttackComponent.new()

func setup(new_sword_item_entry: ItemEntry) -> void:
	if new_sword_item_entry.item_weapon_type != All_Enums.WEAPON_TYPES.Sword:
		push_error("\nSword Scene: Invalid Weapon type!")

	sword_item_entry = new_sword_item_entry

	refresh_values()

func refresh_values() -> void:
	damage_power = sword_item_entry.item.damage_power
	logo = sword_item_entry.logo
	durability = sword_item_entry.durability

func appear() -> void:
	print("\nSword Scene: Appear func called")

	self.show()

	print()

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