extends Control

## Handles the inventory hotbar UI.

@onready var hotbar: HBoxContainer = $%Hot_Bar

var number_of_hotbar_slots: int = Global.number_of_hotbar_slots

func _ready() -> void:
	recreate_inventory_slots()

	SignalBus.refresh_ui.connect(set_inventory_slot_items)
	SignalBus.inventory_changed.connect(set_inventory_slot_items)


func recreate_inventory_slots() -> void:
	# Remove old slots before recreating them.
	for child in hotbar.get_children():
		child.queue_free()

	var packed_inventory_slot: PackedScene = load("res://Folders/Systems/Inventory_System/Scenes/inventory_slot.tscn")

	var inventory_hot_bar_slots: Array[int] = Global.get_hotbar()

	for i in range(number_of_hotbar_slots):
		var inventory_slot: InventorySlot = packed_inventory_slot.instantiate()
		inventory_slot.item_id = inventory_hot_bar_slots[i]

		hotbar.add_child(inventory_slot)


func set_inventory_slot_items() -> void:
	var hotbar_slots: Array[int] = Global.get_hotbar()

	var hotbar_children: Array = hotbar.get_children()

	for i in range(number_of_hotbar_slots):
		hotbar_children[i].item_id = hotbar_slots[i]