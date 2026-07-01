class_name SaveData
extends Resource

@export var inventory_logic: InventoryLogicComponent
@export var hotbar_logic: HotBarLogicComponent

func _init() -> void:
	inventory_logic = InventoryLogicComponent.new()
	hotbar_logic = HotBarLogicComponent.new()