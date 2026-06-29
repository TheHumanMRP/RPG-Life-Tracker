extends Control

## Controls and manages the inventory hotbar UI.
##
## This script is responsible for:
## - Creating the correct number of inventory slot UI elements.
## - Listening for inventory update signals.
## - Synchronizing each UI slot with the corresponding inventory item.

@onready var h_box_container: HBoxContainer = $%Hot_Bar

## Total number of inventory slots to create.
var number_of_inventory_slots: int = Global.number_of_inventory_slots


## Initializes the hotbar.
##
## Creates the inventory slot UI and connects signals so the UI stays
## synchronized whenever the inventory changes.
func _ready() -> void:
	recreate_inventory_slots()
	SignalBus.refresh_ui.connect(set_inventory_slot_items)
	SignalBus.inventory_changed.connect(set_inventory_slot_items)


## Recreates every inventory slot in the hotbar.
##
## Existing slot nodes are removed before new ones are instantiated to
## ensure the UI matches the current configured inventory size.
func recreate_inventory_slots() -> void:
	# Clear the existing inventory slots.
	for child in h_box_container.get_children():
		child.queue_free()

	var id: int = 0

	# Create and add each inventory slot.
	for i in range(number_of_inventory_slots):
		var packed_inveotory_slot: PackedScene = load("res://Folders/Systems/Inventory_System/Scenes/inventory_slot.tscn")
		var inventory_slot: InventorySlot = packed_inveotory_slot.instantiate()

		# Assign the slot's inventory index.
		inventory_slot.id = id

		id += 1

		h_box_container.add_child(inventory_slot)


## Updates each inventory slot with its corresponding item.
##
## Iterates through every UI slot, retrieves the matching inventory entry,
## and assigns the item to the slot if one exists.
func set_inventory_slot_items() -> void:
	var inventory: Array[ItemEntry] = Global.get_inventory()

	var inventory_slots: Array = h_box_container.get_children()

	print("\n\n\nInvnetory Size: ", inventory.size())

	for slot in inventory_slots:
		var id: int = slot.id

		# Prevent out-of-bounds inventory access.
		if not (id >= 0 and id < inventory.size()):
			continue

		# Skip empty inventory slots.
		if inventory[id] == null:
			continue

		var new_item: ItemEntry = inventory[id]

		# Display the item in the UI slot.
		slot.item = new_item