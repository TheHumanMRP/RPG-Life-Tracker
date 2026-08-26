class_name InfoGetter
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

# Returns the array representing the hotbar slots.
func get_hotbar() -> Array[int]:
	return Global.save_data.hotbar_save_data.hotbar_slots

# Returns the currently selected hotbar slot index.
func get_selected_hotbar_index() -> int:
	return Global.save_data.hotbar_save_data.selected_hotbar_slot_index
