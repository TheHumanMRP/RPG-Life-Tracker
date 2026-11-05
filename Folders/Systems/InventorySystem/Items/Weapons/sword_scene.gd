class_name SwordScene
extends Node2D

var sword_item_entry: ItemEntry

var damage_power: int
var display_texture: Texture2D
var durability: float

var attack_component: AttackComponent = AttackComponent.new()

@export var attack_area: Area2D
@export var display_texture_sprite_2d: Sprite2D

func setup(new_sword_item_entry: ItemEntry) -> void:
	if new_sword_item_entry.item_weapon_type != All_Enums.WEAPON_TYPES.Sword:
		push_error("\nSword Scene: Invalid Weapon type!")

	sword_item_entry = new_sword_item_entry

	refresh_values()

func refresh_values() -> void:
	damage_power = sword_item_entry.item.damage_power
	durability = sword_item_entry.durability

func update_sword_texture() -> void:
	display_texture_sprite_2d.texture = display_texture

func appear() -> void:
	self.show()

	print("\nSword Scene: Appear func called, here's the visibility: ", self.visible)

func face_where_player_is_facing(player_facing_direction: int) -> void:
	scale.x = player_facing_direction

func attack() -> void:
	var nodes_in_attack_range: Array[Node2D] = attack_area.get_overlapping_bodies()

	for node in nodes_in_attack_range:
		if not node.is_in_group("enemies"):
			continue
		
		attack_component.attack_target(node)
