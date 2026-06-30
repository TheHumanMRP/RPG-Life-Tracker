extends Control
class_name InventorySlot

@export var item: ItemEntry:
	set(new_item):
		item = new_item
		refresh()

@export var accepted_item_type: String = "base_item"

@export var id: int

@onready var display_logo: TextureRect = $%Logo_Display

const EMPTY_SLOT: int = -1

func _ready() -> void:
	display_logo.texture = null
	SignalBus.inventory_changed.connect(refresh)
	check_type_of_item()
	refresh()

func setup

func refresh() -> void:
	print("Inventory Slot: Refresh called")

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