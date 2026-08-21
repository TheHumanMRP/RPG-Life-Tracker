class_name EquipmentManager
extends Node

@export var sword_scene: SwordScene

var helmet_item_id: int = -1
var chestplate_item_id: int = -1
var leggings_item_id: int = -1
var boots_item_id: int = -1
var selected_item_id: int = -1

func _init() -> void:
	SignalBus.item_selected.connect(equip)

func get_item_entry(item_id: int) -> ItemEntry:
	return AllGlobalItemsManager.get_item_by_id(item_id)


func equip(item_type: All_Enums.EQUIPMENT_TPYES, new_item_id: int) -> void:
	var new_item: ItemEntry = get_item_entry(new_item_id)

	match item_type:
		All_Enums.EQUIPMENT_TPYES.Helmet:
			if new_item.item_type != All_Enums.Item_Type.HELMET:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of helmet.")
				return
			
			helmet_item_id = new_item_id

		All_Enums.EQUIPMENT_TPYES.Chestplate:
			if new_item.item_type != All_Enums.Item_Type.CHESTPLATE:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of chestplate.")
				return
			
			chestplate_item_id = new_item_id

		All_Enums.EQUIPMENT_TPYES.Leggings:
			if new_item.item_type != All_Enums.Item_Type.LEGGINGS:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of leggings.")
				return
			
			leggings_item_id = new_item_id

		All_Enums.EQUIPMENT_TPYES.Boots:
			if new_item.item_type != All_Enums.Item_Type.BOOTS:
				push_error("\nEquipment Logic Component: Invalid item type of: ", new_item.item_type, " instead of boots.")
				return
			
			boots_item_id = new_item_id

		All_Enums.EQUIPMENT_TPYES.Item:
			selected_item_id = new_item_id


func equip_new_helmet(new_helmet_item_id: int) -> void:
	var new_helmet: ItemEntry = get_item_entry(new_helmet_item_id)

	if new_helmet.item_type == All_Enums.Item_Type.HELMET:
		push_error("\nEquipment Logic Componenet: Brother, you are inserting an item of type `", new_helmet.item_type, "` into a slot made for fucking helmets man.")
		return
	
	helmet_item_id = new_helmet_item_id

func equip_new_chestplate(new_chestplate_item_id: int) -> void:
	var new_chestplate: ItemEntry = get_item_entry(new_chestplate_item_id)

	if new_chestplate.item_type == All_Enums.Item_Type.CHESTPLATE:
		push_error("\nEquipment Logic Componenet: Brother, you are inserting an item of type `", new_chestplate.item_type, "` into a slot made for fucking chestplates man.")
		return
	
	chestplate_item_id = new_chestplate_item_id

func equip_new_leggings(new_leggings_item_id: int) -> void:
	var new_leggings: ItemEntry = get_item_entry(new_leggings_item_id)

	if new_leggings.item_type == All_Enums.Item_Type.LEGGINGS:
		push_error("\nEquipment Logic Componenet: Brother, you are inserting an item of type `", new_leggings.item_type, "` into a slot made for fucking leggings man.")
		return
	
	leggings_item_id = new_leggings_item_id

func equip_new_boots(new_boots_item_id: int) -> void:
	var new_boots: ItemEntry = get_item_entry(new_boots_item_id)

	if new_boots.item_type == All_Enums.Item_Type.BOOTS:
		push_error("\nEquipment Logic Componenet: Brother, you are inserting an item of type `", new_boots.item_type, "` into a slot made for fucking boots man.")
		return
	
	boots_item_id = new_boots_item_id

func equip_new_selected_item(new_selected_item_id: int) -> void:
	selected_item_id = new_selected_item_id

	print("\nEquipment Component: A new item was selected")

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
