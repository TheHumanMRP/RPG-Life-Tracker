extends Control

## Handles the inventory hotbar UI.

@onready var h_box_container: HBoxContainer = $%Hot_Bar

var number_of_inventory_slots: int = Global.number_of_inventory_slots

func _ready() -> void:
	recreate_inventory_slots()

	SignalBus.refresh_ui.connect(set_inventory_slot_items)
	SignalBus.inventory_changed.connect(set_inventory_slot_items)


func recreate_inventory_slots() -> void:
	# Remove old slots before recreating them.
	for child in h_box_container.get_children():
		child.queue_free()

	var packed_inventory_slot: PackedScene = load("res://Folders/Systems/Inventory_System/Scenes/inventory_slot.tscn")

	var inventory_hot_bar_slots: Array[int] = Global.get_hotbar()

	for i in range(number_of_inventory_slots):
		var inventory_slot: InventorySlot = packed_inventory_slot.instantiate()
		inventory_slot.item_id = inventory_hot_bar_slots[i]

		h_box_container.add_child(inventory_slot)


func set_inventory_slot_items() -> void:
	var inventory: Array[ItemEntry] = Global.get_inventory()
	var inventory_slots: Array = h_box_container.get_children()

	# Debug output.
	for item in inventory:
		print(
			item,
			" | item = ", item.item,
			" | logo = ", item.logo
		)

	for slot in inventory_slots:
		var id: int = slot.item_id

		# Skip invalid or empty inventory slots.
		if id < 0 or id >= inventory.size():
			continue
		if inventory[id] == null:
			continue

		slot.item = inventory[id]