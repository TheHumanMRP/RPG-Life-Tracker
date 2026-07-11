class_name Getter
extends Node

func check_if_item_at_index_in_inventory_exists(index: int) -> bool:
	return Global.save_data.inventory_logic.check_if_item_at_index_in_inventory_exists(index)

func get_inventory_logic() -> InventoryLogicComponent:
	return Global.save_data.inventory_logic

func get_selected_hotbar_index() -> int:
	return save_data.hotbar_logic.selected_hotbar_slot_index

func get_empty_hotbar_slot_const() -> int:
	return save_data.hotbar_logic.EMPTY_HOTBAR_SLOT

func get_number_of_hotbar_slots() -> int:
	return save_data.hotbar_logic.NUMBER_OF_HOTBAR_SLOTS

func get_hotbar_logic() -> HotBarLogicComponent:
	return save_data.hotbar_logic

func get_inventory() -> Array[ItemEntry]:
	return save_data.inventory_logic.inventory_items

func get_hotbar() -> Array[int]:
	return save_data.hotbar_logic.hotbar_slots