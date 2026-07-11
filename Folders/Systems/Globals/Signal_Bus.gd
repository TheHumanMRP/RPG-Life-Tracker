extends Node

signal refresh_ui
signal inventory_changed(new_inventory: Array[ItemEntry])
signal hotbar_changed
signal hotbar_selected(slot_index: int)
signal item_selected(item_id: int)
signal equip_item(item: ItemEntry)
signal respawn_player
signal save_game

func _ready() -> void:
	await get_tree().process_frame
	refresh_ui.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("respawn"):
		respawn_player.emit()