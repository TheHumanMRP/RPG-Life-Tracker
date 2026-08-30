class_name EquipmentManager
extends Node

@export var sword_scene: SwordScene

var equipped_helmet_item_id: int = Constants.NO_ITEM
var equipped_chestplate_item_id: int = Constants.NO_ITEM
var equipped_leggings_item_id: int = Constants.NO_ITEM
var equipped_boots_item_id: int = Constants.NO_ITEM
var equipped_weapon_item_id: int = Constants.NO_ITEM
var selected_item_id: int = Constants.NO_ITEM

func _ready() -> void:
	SignalBus.item_selected.connect(select_item)
	SignalBus.equip_item.connect(equip)
	
	sword_scene.hide()

func setup(player: Player)

func get_item_entry(item_id: int) -> ItemEntry:
	return AllGlobalItemsManager.get_item_by_id(item_id)

func equip(item_id: int) -> void:
	if item_id == Constants.NO_ITEM:
		return

	var new_item: ItemEntry = get_item_entry(item_id)

	var item_type: All_Enums.ITEM_TYPES = new_item.item_type

	match item_type:
		All_Enums.ITEM_TYPES.Helmet:
			equipped_helmet_item_id = item_id
			return

		All_Enums.ITEM_TYPES.Chestplate:
			equipped_chestplate_item_id = item_id
			return

		All_Enums.ITEM_TYPES.Leggings:
			equipped_leggings_item_id = item_id
			return

		All_Enums.ITEM_TYPES.Boots:
			equipped_boots_item_id = item_id
			return

		All_Enums.ITEM_TYPES.Weapon:
			print("\nEquipment Manager: Signal reached till match type, weapon")
			handle_equipping_of_weapon(new_item)
			return

	push_warning("Equipment Manager: I don't really think the end of the equip func is supposed to be reached. Search into it.")

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
	print("\nEquipment Manager: Singal reached till handle equipping of weapon")

	equipped_weapon_item_id = new_item.item_id
	
	var item_weapon_type: All_Enums.WEAPON_TYPES = new_item.item_weapon_type

	match item_weapon_type:
		All_Enums.WEAPON_TYPES.Sword:
			handle_equipping_of_sword(new_item)
		All_Enums.WEAPON_TYPES.None:
			push_error("Equipment Manager: Invalid weapon")
 
func handle_equipping_of_sword(new_item: ItemEntry) -> void:
	print("\nEquipment Manager: Signal reached till equpping of sword")

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
