extends Node

# ==============================================
# Player
# ==============================================

signal respawn_player
signal player_died

# ==============================================
# Player Inventory
# ==============================================

signal player_inventory_changed(new_inventory: Array[ItemEntry])
signal item_selected(item_id: int)
signal equip_item(item_id: int, slot_index: int)

# ==============================================
# Hotbar
# ==============================================

signal hotbar_item_selected(slot_index: int)
signal hotbar_item_equipped(slot_index: int)
signal swap_hotbar_item(slot_index: int, item_id: int)
signal hotbar_changed

# ==============================================
# Global Inventory
# ==============================================

signal notify_global_inventory_changed
signal add_item_to_global_inventory(new_item_entry: ItemEntry)
signal remove_item_from_global_inventory(item_id: int)
signal rename_item_in_inventory(item_id: int, new_name: String)
signal set_game_state(new_game_state: All_Enums.GAME_STATES)

# ==============================================
# Game State
# ==============================================

signal refresh_ui
signal save_game
signal quit_game

signal switch_scene(caller: Node, new_scene_path: String, clear_all_children: bool)

# ==============================================
# Funcs
# ==============================================

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	await get_tree().process_frame
	refresh_ui.emit()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("respawn"):
		respawn_player.emit()