class_name TestingScript
extends Resource

var inventory_logic: InventoryLogicComponent
var hotbar_logic: HotBarLogicComponent

func setup(new_inventory_logic: InventoryLogicComponent, new_hotbar_logic: HotBarLogicComponent) -> void:
	inventory_logic = new_inventory_logic
	hotbar_logic = new_hotbar_logic

func test() -> void:
	inventory_logic = Global.get_inventory_logic()
	hotbar_logic = Global.get_hotbar_logic()

	inventory_logic.print_all_items()
	inventory_logic.clear_inventory()
	inventory_logic.add_test_sword()

	hotbar_logic.add_item_to_hotbar(0, 0)