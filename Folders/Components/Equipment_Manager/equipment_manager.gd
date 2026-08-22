class_name EquipmentManager
extends Node

@export var sword_scene: SwordScene

var helmet_item_id: int = -1
var chestplate_item_id: int = -1
var leggings_item_id: int = -1
var boots_item_id: int = -1
var selected_item_id: int = -1

func _init() -> void:
	SignalBus.item_selected.connect(select_item)
	SignalBus.equip_item.connect(equip)

func get_item_entry(item_id: int) -> ItemEntry:
	return AllGlobalItemsManager.get_item_by_id(item_id)


func equip(item_id: int) -> void:
	var new_item: ItemEntry = get_item_entry(item_id)

	var item_type: All_Enums.ITEM_TYPES = new_item.item_type

	match item_type:
		All_Enums.ITEM_TYPES.Helmet:
			if new_item.item_type != All_Enums.ITEM_TYPES.Helmet:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of helmet.")
				return
			
			helmet_item_id = item_id

		All_Enums.ITEM_TYPES.Chestplate:
			if new_item.item_type != All_Enums.ITEM_TYPES.Chestplate:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of chestplate.")
				return
			
			chestplate_item_id = item_id

		All_Enums.ITEM_TYPES.Leggings:
			if new_item.item_type != All_Enums.ITEM_TYPES.Leggings:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of leggings.")
				return
			
			leggings_item_id = item_id

		All_Enums.ITEM_TYPES.Boots:
			if new_item.item_type != All_Enums.ITEM_TYPES.Boots:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of boots.")
				return
			
			boots_item_id = item_id

func select_item(item_id: int) -> void:
	selected_item_id = item_id

func unequip_item(item_id: int) -> void:
	var new_item: ItemEntry = get_item_entry(item_id)

	var item_type: All_Enums.ITEM_TYPES = new_item.item_type

	match item_type:
		All_Enums.ITEM_TYPES.Helmet:
			helmet_item_id = Constants.EMPTY_EQUIPMENT_SLOT

		All_Enums.ITEM_TYPES.Chestplate:
			chestplate_item_id = Constants.EMPTY_EQUIPMENT_SLOT

		All_Enums.ITEM_TYPES.Leggings:
			leggings_item_id = Constants.EMPTY_EQUIPMENT_SLOT

		All_Enums.ITEM_TYPES.Boots:
			boots_item_id = Constants.EMPTY_EQUIPMENT_SLOT

		All_Enums.ITEM_TYPES.Item:
			selected_item_id = Constants.EMPTY_EQUIPMENT_SLOT

func unequip_helmet() -> void:
	helmet_item_id = Constants.EMPTY_EQUIPMENT_SLOT

func unequip_chestplate() -> void:
	chestplate_item_id = Constants.EMPTY_EQUIPMENT_SLOT

func unequip_leggings() -> void:
	leggings_item_id = Constants.EMPTY_EQUIPMENT_SLOT

func unequip_boots() -> void:
	boots_item_id = Constants.EMPTY_EQUIPMENT_SLOT

func unequip_selected_item() -> void:
	selected_item_id = Constants.EMPTY_EQUIPMENT_SLOT
