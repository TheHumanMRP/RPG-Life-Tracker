class_name TestingScript
extends Node

var inventory_component: InventoryLogicComponent = InventoryLogicComponent.new()
var hotbar_logic: HotBarLogicComponent = HotBarLogicComponent.new()

func test() -> void:
	AllGlobalItemsManager.clear_inventory()