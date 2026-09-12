class_name TestingScript
extends Node

func test() -> void:
	test_task_manager_backend()

func test_task_manager_backend() -> void:
	var task_manager_backend: TaskManagerBackend = TaskManagerBackend.new()

	task_manager_backend.add_task("Hello")
	task_manager_backend.add_task("Hello")

func test_hotbar() -> void:
	var hotbar_logic_component: HotbarLogic = HotbarLogic.new()

	var test_sword_item_id: int = Global.all_global_items_manager.add_test_sword("Test Sword", load("res://Folders/Assets/Project_Display/Mouse-Cursor.png"))

	var second_test_sword_item_id: int = Global.all_global_items_manager.add_test_sword()

	hotbar_logic_component.add_item_to_hotbar(test_sword_item_id, 5)

	hotbar_logic_component.add_item_to_hotbar(second_test_sword_item_id, 2)
	
	print("\nTesting: Testing Done!")
