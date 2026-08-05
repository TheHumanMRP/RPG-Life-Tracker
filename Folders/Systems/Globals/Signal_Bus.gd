extends Node

# ==============================================
# Player
# ==============================================

signal respawn_player

# ==============================================
# Player Inventory
# ==============================================

signal player_inventory_changed(new_inventory: Array[ItemEntry])
signal item_selected(item_id: int)
signal equip_item(item_id: int)

# ==============================================
# Hotbar
# ==============================================

signal hotbar_selected(slot_index: int)
signal hotbar_changed

# ==============================================
# Global Inventory
# ==============================================

signal notify_global_inventory_changed
signal add_item_to_global_inventory(new_item_entry: ItemEntry)
signal remove_item_from_global_inventory(item_id: int)
signal rename_item_in_inventory(item_id: int, new_name: String)

# ==============================================
# Game State
# ==============================================

signal refresh_ui
signal save_game

func _ready() -> void:
	await get_tree().process_frame
	refresh_ui.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("respawn"):
		respawn_player.emit()