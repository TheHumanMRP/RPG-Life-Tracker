extends Control

## Handles the inventory hotbar UI.
@onready var hotbar: HBoxContainer = $%Hot_Bar

var number_of_hotbar_slots: int

@onready var hotbar_logic: HotbarManager = InfoGetter.get_hotbar_manager()

func _ready() -> void:
	number_of_hotbar_slots = Constants.NUMBER_OF_HOTBAR_SLOTS

	recreate_inventory_slots()

	SignalBus.refresh_ui.connect(recreate_inventory_slots)
	SignalBus.hotbar_changed.connect(assaign_proper_id_to_hotbar_slots)

func recreate_inventory_slots() -> void:
	# Remove old slots before recreating them.
	for child in hotbar.get_children():
		child.queue_free()

	var packed_inventory_slot: PackedScene = load("res://Folders/Systems/Inventory_System/Scenes/hotbar_slot.tscn")

	for i in range(number_of_hotbar_slots):
		var hotbar_slot: HotbarSlot = packed_inventory_slot.instantiate()

		hotbar_slot.slot_index = i

		hotbar.add_child(hotbar_slot)
	
	assaign_proper_id_to_hotbar_slots()

func assaign_proper_id_to_hotbar_slots() -> void:
	var hotbar_slots: Array[int] = InfoGetter.get_hotbar()

	print("\nHotbar UI: Reassigning id to hotbar slots, here's the hotbar: ", hotbar_slots)

	var hotbar_children: Array[Node] = hotbar.get_children()

	for i in range(number_of_hotbar_slots):
		hotbar_children[i].refresh()
