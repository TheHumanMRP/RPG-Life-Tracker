class_name EquipmentManager
extends Node

@export var sword_scene: SwordScene

var equipped_helmet_item_id: int = Constants.NO_ITEM
var equipped_chestplate_item_id: int = Constants.NO_ITEM
var equipped_leggings_item_id: int = Constants.NO_ITEM
var equipped_boots_item_id: int = Constants.NO_ITEM
var equipped_weapon_item_id: int = Constants.NO_ITEM
var equipped_selected_item_id: int = Constants.NO_ITEM

func _init() -> void:
	SignalBus.item_selected.connect(select_item)
	SignalBus.equip_item.connect(equip)

func get_item_entry(item_id: int) -> ItemEntry:
	return AllGlobalItemsManager.get_item_by_id(item_id)


func equip(item_id: int) -> void:
	if item_id == Constants.NO_ITEM:
		return

	var new_item: ItemEntry = get_item_entry(item_id)

	var item_type: All_Enums.ITEM_TYPES = new_item.item_type

	match item_type:
		All_Enums.ITEM_TYPES.Helmet:
			if new_item.item_type != All_Enums.ITEM_TYPES.Helmet:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of helmet.")
				return
			
			equipped_helmet_item_id = item_id

		All_Enums.ITEM_TYPES.Chestplate:
			if new_item.item_type != All_Enums.ITEM_TYPES.Chestplate:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of chestplate.")
				return
			
			equipped_chestplate_item_id = item_id

		All_Enums.ITEM_TYPES.Leggings:
			if new_item.item_type != All_Enums.ITEM_TYPES.Leggings:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of leggings.")
				return
			
			equipped_leggings_item_id = item_id

		All_Enums.ITEM_TYPES.Boots:
			if new_item.item_type != All_Enums.ITEM_TYPES.Boots:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of boots.")
				return
			
			equipped_boots_item_id = item_id

func select_item(item_id: int) -> void:
	selected_item_id = item_id

func unequip_item(item_id: int) -> void:
	var new_item: ItemEntry = get_item_entry(item_id)

	var item_type: All_Enums.ITEM_TYPES = new_item.item_type

	match item_type:
		All_Enums.ITEM_TYPES.Helmet:
			helmet_item_id = Constants.NO_ITEM

		All_Enums.ITEM_TYPES.Chestplate:
			chestplate_item_id = Constants.NO_ITEM

		All_Enums.ITEM_TYPES.Leggings:
			leggings_item_id = Constants.NO_ITEM

		All_Enums.ITEM_TYPES.Boots:
			boots_item_id = Constants.NO_ITEM

		All_Enums.ITEM_TYPES.Item:
			selected_item_id = Constants.NO_ITEM
