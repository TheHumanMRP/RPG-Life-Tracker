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

func get_all_globla_items_manager() -> AllGlobalItemsManager:
	return Global.inventory_related_managers.all_global_items_manager

# ============================================================================
# Hotbar
# ============================================================================

# Returns the array representing the hotbar slots.
func get_hotbar() -> Array[int]:
	return Global.save_data.hotbar_save_data.hotbar_slots

# Returns the currently selected hotbar slot index.
func get_selected_hotbar_index() -> int:
	return Global.save_data.hotbar_save_data.selected_hotbar_slot_index

func get_hotbar_manager() -> HotbarManager:
	return Global.inventory_related_managers.hotbar_manager

# ============================================================================
# Task Manager
# ============================================================================

func get_tasks_save_data() -> TasksSaveData:
	return Global.save_data.tasks_save_data

func get_task_by_task_id(task_id: int) -> Task:
	return Global.tasks_related_managers.tasks_manager.get_task_by_task_id(task_id)

func get_task_manager