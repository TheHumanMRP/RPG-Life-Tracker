class_name TestingScript
extends Node

func test() -> void:
	var hotbar_logic_component: HotbarLogic = HotbarLogic.new()

	Global.all_global_items_manager.add_test_sword()

	hotbar_logic_component.add_item_to_hotbar(1, 1)

	print("\nTesting: Testing Done!")
