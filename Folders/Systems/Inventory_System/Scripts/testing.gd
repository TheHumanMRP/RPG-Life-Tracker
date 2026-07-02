class_name TestingScript
extends Resource

var inventory_logic: InventoryLogicComponent
var hotbar_logic: HotBarLogicComponent

func _init() -> void:
	testing()

func testing() -> void:
	inventory_logic = Global.get_inventory_logic()
	hotbar_logic = Global.get_hotbar_logic()

	inventory_logic.

func testing_inventory() -> void:
	print_all_items()

	clear_inventory()
	add_test_sword()