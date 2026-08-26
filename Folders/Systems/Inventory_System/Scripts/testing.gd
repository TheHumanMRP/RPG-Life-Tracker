class_name TestingScript
extends Node

func test() -> void:
	var hotbar_logic_component: HotBarLogicComponent = HotBarLogicComponent.new()

	var sword: SwordClass = SwordClass.new()

	sword.setup()

	Global.all_global_items_manager.add_item(sword, "NEW_SWORD", load("res://Folders/Assets/icon.svg"))

	hotbar_logic_component.add_item_to_hotbar(1, 1)