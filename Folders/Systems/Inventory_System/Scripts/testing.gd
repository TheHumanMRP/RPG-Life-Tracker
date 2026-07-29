class_name TestingScript
extends Node

var inventory_component: InventoryLogicComponent = InventoryLogicComponent.new()
var hotbar_logic: HotBarLogicComponent = HotBarLogicComponent.new()

func test() -> void:
	pass
	inventory_component.setup(Global.PLAYER_INVENTORY_NAME)

	inventory_component.print_all_items()
	inventory_component.clear_inventory()
	inventory_component.add_test_sword()

	hotbar_logic.clear_hotbar()

	var item_id: int = 0
	var slot_index: int = 0

	hotbar_logic.add_item_to_hotbar(item_id, slot_index)
