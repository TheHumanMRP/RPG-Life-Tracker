class_name TestingScript
extends Node

func test() -> void:

	

func test_hotbar() -> void:
	var hotbar_logic_component: HotbarLogic = HotbarLogic.new()

	var test_sword_item_id: int = AllGlobalItemsManager.add_test_sword("Test Sword", load("res://Folders/Assets/Project_Display/Mouse-Cursor.png"))

	var second_test_sword_item_id: int = AllGlobalItemsManager.add_test_sword()

	hotbar_logic_component.add_item_to_hotbar(test_sword_item_id, 5)

	hotbar_logic_component.add_item_to_hotbar(second_test_sword_item_id, 2)
	
	print("\nTesting: Testing Done!")
