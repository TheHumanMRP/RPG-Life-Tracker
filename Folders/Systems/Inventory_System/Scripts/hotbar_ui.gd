extends Control

## Handles the inventory hotbar UI.

@onready var hotbar: HBoxContainer = $%Hot_Bar

var number_of_hotbar_slots: int = Global.get_number_of_hotbar_slots()

func _ready() -> void:
	recreate_inventory_slots()

	SignalBus.refresh_ui.connect(assaign_proper_id_to_hotbar_slots)
	SignalBus.hotbar_changed.connect(assaign_proper_id_to_hotbar_slots)

func recreate_inventory_slots() -> void:
	# Remove old slots before recreating them.
	for child in hotbar.get_children():
		child.queue_free()

	var packed_inventory_slot: PackedScene = load("res://Folders/Systems/Inventory_System/Scenes/hotbar_slot.tscn")

	var inventory_hot_bar_slots: Array[int] = Global.get_hotbar()

	for i in range(number_of_hotbar_slots):
		var hotbar_slot: HotbarSlot = packed_inventory_slot.instantiate()
		hotbar_slot.item_id = inventory_hot_bar_slots[i]

		hotbar_slot.slot_index = i

		hotbar.add_child(hotbar_slot)
	
	assaign_proper_id_to_hotbar_slots()

func assaign_proper_id_to_hotbar_slots() -> void:
	var hotbar_slots: Array[int] = Global.get_hotbar()

	var hotbar_children: Array[Node] = hotbar.get_children()

	for i in range(number_of_hotbar_slots):
		hotbar_children[i].item_id = hotbar_slots[i]
		hotbar_children[i].refresh()