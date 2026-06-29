extends Control
class_name InventorySlot

@export var item: ItemEntry:
	set(new_item):
		item = new_item
		refresh()

@export var accepted_item_type: String = "base_item"

@export var id: int

@onready var display_logo: TextureRect = $%Logo_Display

func _ready() -> void:
	display_logo.texture = null
	check_type_of_item()
	SignalBus.inventory_changed.connect(refresh)
	refresh()

func refresh() -> void:
	if not item:
		return
	
	if not item.logo:
		return

	check_type_of_item()

	display_logo.texture = item.logo

func check_type_of_item() -> void:
	if not accepted_item_type == "base_item":
		if not item.type == accepted_item_type:
			push_error("Inventory Slot: Invalid item type ")