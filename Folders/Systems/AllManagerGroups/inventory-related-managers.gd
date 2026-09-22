class_name InventoryRelatedManagers
extends RefCounted

var all_global_items_manager: AllGlobalItemsManager
var hotbar_manager: HotbarManager

func setup() -> void:
	all_global_items_manager = AllGlobalItemsManager.new()
	hotbar_manager = HotbarManager.new()