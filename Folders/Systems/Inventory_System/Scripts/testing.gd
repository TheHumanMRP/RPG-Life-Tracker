class_name TestingScript
extends Node

var inventory_logic: InventoryLogicComponent
var hotbar_logic: HotBarLogicComponent

func test() -> void:
	pass
	inventory_logic = InfoGetter.get_inventory_logic()
	hotbar_logic = InfoGetter.get_hotbar_logic()

	inventory_logic.print_all_items()
	inventory_logic.clear_inventory()
	inventory_logic.add_test_sword()

	hotbar_logic.clear_hotbar()

	var item_id: int = 0
	var slot_index: int = 0

	hotbar_logic.add_item_to_hotbar(item_id, slot_index)