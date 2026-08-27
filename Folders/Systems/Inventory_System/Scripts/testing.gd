class_name TestingScript
extends Node

func test() -> void:
	var hotbar_logic_component: HotbarLogic = HotbarLogic.new()

	AllGlobalItemsManager.add_test_sword()

	hotbar_logic_component.add_item_to_hotbar(1, 5)

	print("\nTesting: Testing Done!")
