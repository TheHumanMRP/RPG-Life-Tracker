class_name InfoGetter
extends Node

# ============================================================================
# Main Node
# ============================================================================

func get_main_node() -> MainNode:
	return get_tree().get_first_node_in_group("main_node")

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


# ============================================================================
# Hotbar
# ============================================================================

# Returns the array representing the hotbar slots.
func get_hotbar() -> Array[int]:
	return Global.save_data.hotbar_save_data.hotbar_slots

# Returns the currently selected hotbar slot index.
func get_selected_hotbar_index() -> int:
	return Global.save_data.hotbar_save_data.selected_hotbar_slot_index