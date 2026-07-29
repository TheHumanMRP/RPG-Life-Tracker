class_name SaveData
extends Resource

@export var all_global_item_manager: AllGlobalItemManager
@export var inventory_component: InventoryComponent
@export var hotbar_logic: HotBarLogicComponent
@export var equipment_logic_component: EquipmentLogicComponent

func _init() -> void:
	inventory_component = InventoryComponent.new()
	hotbar_logic = HotBarLogicComponent.new()
	equipment_logic_component = EquipmentLogicComponent.new()