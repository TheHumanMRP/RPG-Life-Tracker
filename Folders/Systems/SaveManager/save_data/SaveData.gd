class_name SaveData
extends Resource

@export var all_global_items_data: AllGlobalItemsData
@export var inventory_items_data: InventoryItemsData
@export var player_stats: PlayerStats
@export var hotbar_save_data: HotbarSaveData

func _init() -> void:
	all_global_items_data = AllGlobalItemsData.new()
	inventory_items_data = InventoryItemsData.new()
	player_stats = PlayerStats.new()
	hotbar_save_data = HotbarSaveData.new()