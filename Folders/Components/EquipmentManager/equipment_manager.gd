class_name EquipmentManager
extends Node

# See the All-Tasks.md for explanation on why the visual and the logic are in the same script
# Search for 'Separate `equipment_manager` and `equipment_scene_manager`'

@export var sword_scene: SwordScene

var equipped_helmet_item_id: int = Constants.NO_ITEM
var equipped_chestplate_item_id: int = Constants.NO_ITEM
var equipped_leggings_item_id: int = Constants.NO_ITEM
var equipped_boots_item_id: int = Constants.NO_ITEM
var equipped_weapon_item_id: int = Constants.NO_ITEM
var selected_item_id: int = Constants.NO_ITEM

func setup(player: Player) -> void:
	player.facing_direction_changed.connect(update_sword_direction)

	SignalBus.item_selected.connect(select_item)
	SignalBus.equip_item.connect(equip)
	
	sword_scene.hide()

func get_item_entry(item_id: int) -> ItemEntry:
	return InfoGetter.get_all_globla_items_manager().get_item_by_id(item_id)

func equip(item_id: int, slot_index: int) -> void:
	print("\nEquipment Manager: Equip func called with item id: ", item_id)

	if item_id == Constants.NO_ITEM:
		SignalBus.swap_hotbar_item.emit(slot_index, Constants.NO_ITEM)
		return

	var new_item: ItemEntry = get_item_entry(item_id)

	var item_type: All_Enums.ITEM_TYPES = new_item.item_type

	match item_type:
		All_Enums.ITEM_TYPES.Helmet:
			var previous_helmet_item_id = equipped_helmet_item_id

			equipped_helmet_item_id = item_id
			SignalBus.swap_hotbar_item.emit(slot_index, previous_helmet_item_id)
			return

		All_Enums.ITEM_TYPES.Chestplate:
			var previous_chestplate_item_id = equipped_chestplate_item_id

			equipped_chestplate_item_id = item_id
			SignalBus.swap_hotbar_item.emit(slot_index, previous_chestplate_item_id)
			return

		All_Enums.ITEM_TYPES.Leggings:
			var previous_leggings_item_id = equipped_leggings_item_id

			equipped_leggings_item_id = item_id
			SignalBus.swap_hotbar_item.emit(slot_index, previous_leggings_item_id)
			return

		All_Enums.ITEM_TYPES.Boots:
			var previous_boots_item_id = equipped_boots_item_id

			equipped_boots_item_id = item_id
			SignalBus.swap_hotbar_item.emit(slot_index, previous_boots_item_id)
			return

		All_Enums.ITEM_TYPES.Weapon:
			var previous_weapon_item_id: int = equipped_weapon_item_id

			handle_equipping_of_weapon(new_item)

			SignalBus.swap_hotbar_item.emit(slot_index, previous_weapon_item_id)
			return

	push_warning("Equipment Manager: I don't really think the end of the equip func is supposed to be reached. Search into it.")
	SignalBus.swap_hotbar_item.emit(slot_index, Constants.NO_ITEM)

func select_item(item_id: int) -> void:
	selected_item_id = item_id

func unequip_item(item_id: int) -> void:
	var new_item: ItemEntry = get_item_entry(item_id)

	var item_type: All_Enums.ITEM_TYPES = new_item.item_type

	match item_type:
		All_Enums.ITEM_TYPES.Helmet:
			equipped_helmet_item_id = Constants.NO_ITEM

		All_Enums.ITEM_TYPES.Chestplate:
			equipped_chestplate_item_id = Constants.NO_ITEM

		All_Enums.ITEM_TYPES.Leggings:
			equipped_leggings_item_id = Constants.NO_ITEM

		All_Enums.ITEM_TYPES.Boots:
			equipped_boots_item_id = Constants.NO_ITEM

		All_Enums.ITEM_TYPES.Weapon:
			handle_unequipping_of_weapon(new_item)

# ===================================================
# Equipping nad unequipping of weapons
# ===================================================

func handle_equipping_of_weapon(new_item: ItemEntry) -> void:
	equipped_weapon_item_id = new_item.item_id
	
	var item_weapon_type: All_Enums.WEAPON_TYPES = new_item.item_weapon_type

	match item_weapon_type:
		All_Enums.WEAPON_TYPES.Sword:
			handle_equipping_of_sword(new_item)
		All_Enums.WEAPON_TYPES.None:
			push_error("Equipment Manager: Invalid weapon")
 
func handle_equipping_of_sword(new_item: ItemEntry) -> void:
	sword_scene.setup(new_item)
	
	sword_scene.appear()

func handle_unequipping_of_weapon(new_item: ItemEntry) -> void:
	equipped_weapon_item_id = Constants.NO_ITEM
	
	var item_weapon_type: All_Enums.WEAPON_TYPES = new_item.item_weapon_type

	match item_weapon_type:
		All_Enums.WEAPON_TYPES.Sword:
			handle_unequipping_of_sword()

func handle_unequipping_of_sword() -> void:
	sword_scene.hide()

# ===================================================
# Handle Sword Logic
# ===================================================

func update_sword_direction(player_facing_direction: int) -> void:
	if sword_scene.visible:
		sword_scene.face_where_player_is_facing(player_facing_direction)