class_name InventoryRelatedManagers
extends RefCounted

var all_global_items_manager: AllGlobalItemsM
var hotbar_manager: HotbarManager

func setup() -> void:
	inventory_manager = InventoryManager.new()
	hotbar_manager = HotbarManager.new()