class_name SaveData
extends Resource

@export var inventory_logic: InventoryLogicComponent
@export var hotbar_logic: HotBarLogicComponent
@export var equipment_logic_component: EquipmentManagerComponent

func _init() -> void:
	inventory_logic = InventoryLogicComponent.new()
	hotbar_logic = HotBarLogicComponent.new()
	equipment_logic_component = EquipmentManagerComponent.new()