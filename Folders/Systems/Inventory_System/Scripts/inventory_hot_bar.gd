extends Control

@onready var h_box_container: HBoxContainer = $%Hot_Bar

var number_of_inventory_slots: int = Global.number_of_inventory_slots

func _ready() -> void:
	recreate_inventory_slots()
	SignalBus.refresh_ui.connect(refresh_inventory_slots)
	SignalBus.inventory_changed.connect(refresh_inventory_slots)

func recreate_inventory_slots() -> void:
	# Clear the existing inventory slots
	for child in h_box_container.get_children():
		child.queue_free()

	# Add all the item slots again
	for i in range(number_of_inventory_slots):
		var packed_inveotory_slot: PackedScene = load("res://Folders/Systems/Inventory_System/Scenes/inventory_slot.tscn")
		var inventory_slot: InventorySlot = packed_inveotory_slot.instantiate()

		inventory_slot.id = i

		h_box_container.add_child(inventory_slot)

func refresh_inventory_slots() -> void:
	var inventory: Array[ItemEntry] = Global.get_inventory()
	
	var inventory_slots: Array = h_box_container.get_children()

	for i in range(number_of_inventory_slots):
		if not i >= 0 and i < inventory.size():
			return
		
		if not inventory[i] != null:
			continue
			
		var new_item: ItemEntry = inventory[i]

		for slot in inventory_slots.size()):
			if not slot.id == i:
				continue
			

