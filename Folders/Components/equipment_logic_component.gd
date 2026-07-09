class_name EquipmentLogicComponent
extends Resource

const EMPTY_EQUIPMENT_SLOT: int = -1

var helmet_item_id: int = -1
var chestplate_item_id: int = -1
var leggings_item_id: int = -1
var boots_item_id: int = -1
var weapon_item_id: int = -1

func equip_new_helmet(helmet_item_id:) -> void:
	