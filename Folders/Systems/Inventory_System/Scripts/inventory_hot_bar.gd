extends Control

@onready var h_box_container: HBoxContainer = $%Hot_Bar

var number_of_inventory_slots: int = Global.number_of_inventory_slots

func _ready() -> void:
	recreate_inventory_slots()
	SignalBus.refresh_ui.connect(set_inventory_slot_items)
	SignalBus.inventory_changed.connect(set_inventory_slot_items)

func recreate_inventory_slots() -> void:
	# Clear the existing inventory slots
	for child in h_box_container.get_children():
		child.queue_free()

	var id: int = 0

	# Add all the item slots again
	for i in range(number_of_inventory_slots):
		var packed_inveotory_slot: PackedScene = load("res://Folders/Systems/Inventory_System/Scenes/inventory_slot.tscn")
		var inventory_slot: InventorySlot = packed_inveotory_slot.instantiate()

		inventory_slot.id = id

		id += 1

		h_box_container.add_child(inventory_slot)

func set_inventory_slot_items() -> void:
	var inventory: Array[ItemEntry] = Global.get_inventory()
	
	var inventory_slots: Array = h_box_container.get_children()

	for slot in inventory_slots:
		var id: int = slot.id

		if not (id >= 0 and id < inventory.size()):
			return

		if inventory[id] == null:
			continue
		
		var new_item: ItemEntry = inventory[id]

		slot.item = new_item