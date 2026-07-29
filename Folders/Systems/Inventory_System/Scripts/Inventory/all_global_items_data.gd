class_name AllGlobalItemsData
extends Resource

@export var all_global_items: Array[ItemEntry] = []

@export var items_by_id_dict: Dictionary

@export var global_max_id: int = 0

func clear_inventory() -> void:
    