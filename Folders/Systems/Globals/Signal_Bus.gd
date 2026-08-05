extends Node

# ==============================================
# Player
# ==============================================

signal player_inventory_changed(new_inventory: Array[ItemEntry])

signal refresh_ui
signal hotbar_changed
signal hotbar_selected(slot_index: int)
signal item_selected(item_id: int)
signal equip_item(item_id)
signal respawn_player
signal save_game
signal notify_global_inventory_changed

func _ready() -> void:
	await get_tree().process_frame
	refresh_ui.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("respawn"):
		respawn_player.emit()