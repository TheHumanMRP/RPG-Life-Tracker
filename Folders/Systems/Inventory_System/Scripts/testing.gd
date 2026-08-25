class_name TestingScript
extends Node

func test() -> void:
	var hotbar_logic_component: HotBarLogicComponent = HotBarLogicComponent.new()

	

	AllGlobalItemsManager.add_item()

	hotbar_logic_component.add_item_to_hotbar(1, 1)