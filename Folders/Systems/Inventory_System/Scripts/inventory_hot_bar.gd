extends Control

@onready var h_box_container: HBoxContainer = $%Hot_Bar

var number_of_inventory_slots: int = 9

func _ready() -> void:
	for i in range(number_of_inventory_slots):
		var packed_inveotory_slot: PackedScene = load("res://Folders/Systems/Inventory_System/Scenes/inventory_slot.tscn")
		var inventory_slot: Node = packed_inveotory_slot.instantiate()
		
		h_box_container.add_child(inventory_slot)