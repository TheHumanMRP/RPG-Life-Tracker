class_name InventoryRelatedManagers
extends RefCounted

var inventory_manager: InventoryManager
var hotbar_manager: HotbarManager

func setup() -> void:
	inventory_manager = InventoryManager.new()
	hotbar_manager = HotbarManager.new()