class_name TestingScript
extends Resource

var inventory_logic: InventoryLogicComponent
var hotbar_logic: HotBarLogicComponent

func _init() -> void:
	inventory_logic = Global.get_inventory_logic()
	hotbar_logic = Global.get_hotbar_logic()

