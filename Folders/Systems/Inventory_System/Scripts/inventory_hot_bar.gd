extends Control

@onready var h_box_container: HBoxContainer = $%Hot_Bar

func _ready() -> void:
	refresh_inventory_slots()
	SignalBus.refresh_ui.connect(refresh_inventory_slots)

func refresh_inventory_slots() -> void:
	# Get the var from the global script
	var number_of_inventory_slots: int = Global.number_of_inventory_slots
	
	# Clear the existing inventory slots
	for child in h_box_container.get_children():
		child.queue_free()
	
	# Add all the item slots again
	for i in range(number_of_inventory_slots):
		var packed_inveotory_slot: PackedScene = load("res://Folders/Systems/Inventory_System/Scenes/inventory_slot.tscn")
		var inventory_slot: Node = packed_inveotory_slot.instantiate()
		
		# Global.get_inventory() returns the inventory, and this checks if the item at index i exists or not.
		if Global.get_inventory()[i] != null:
			inventory_slot.item = globa

		h_box_container.add_child(inventory_slot)