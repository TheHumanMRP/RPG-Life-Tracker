class_name EquipmentLogicComponent
extends Resource

const EMPTY_EQUIPMENT_SLOT: int = -1

var helmet_item_id: int = -1
var chestplate_item_id: int = -1
var leggings_item_id: int = -1
var boots_item_id: int = -1
var weapon_item_id: int = -1

func get_item_entry(item_id: int) -> ItemEntry:
	var inventory_logic: InventoryLogicComponent = Global.get_inventory_logic()

	return inventory_logic.get_item_by_id(item_id)

func equip_new_helmet(new_helmet_item_id: int) -> void:
	var new_helmet: ItemEntry = get_item_entry(new_helmet_item_id)

	if new_helmet.item_type == 