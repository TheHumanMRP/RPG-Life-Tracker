extends Node

# ============================================================================
# Player
# ============================================================================

func get_player_max_health() -> int:
	return Global.save_data.player_stats.player_max_health

# ============================================================================
# Inventory
# ============================================================================

# Returns all items currently stored in the inventory.
func get_inventory() -> Array[ItemEntry]:
	return Global.save_data.inventory_items_data.inventory_items

# Returns true if an item exists at the given inventory index.
func check_if_item_at_index_in_inventory_exists(index: int) -> bool:
	return Global.save_data.inventory_logic.check_if_item_at_index_in_inventory_exists(index)

func get_all_global_items_data() -> AllGlobalItemsData:
	return Global.save_data.all_global_items_data

# ============================================================================
# Hotbar
# ============================================================================

func get_save_data() -> TasksSaveData:
	return Global.save_data.tasks_save_data

# ============================================================================
# Task Manager
# ============================================================================

func get_all_tasks() -> Array[Task]:
	return Global.save_data.tasks_save_data.all_tasks

func get_max_task_id() -> int:
	return Global.save_data.tasks_save_data.max_task_id