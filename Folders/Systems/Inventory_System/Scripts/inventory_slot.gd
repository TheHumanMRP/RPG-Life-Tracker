extends Control
class_name InventorySlot

@export var accepted_item_type: String = "base_item"

@export var id: int

@onready var display_logo: TextureRect = $%Logo_Display

const EMPTY_SLOT: int = -1

var item: ItemEntry

func _ready() -> void:
	setup()

func setup() -> void:
	display_logo.texture = null
	SignalBus.inventory_changed.connect(refresh)
	
	check_type_of_item()
	refresh()

	item = Global.get_inventory()[id]

func check_id() -> void:
	var inventory_items: Array[ItemEntry] = Global.get_inventory().inventory_items

	if not id <= 0 or id > inventory_items.size()
	
	if id == EMPTY_SLOT:
func refresh() -> void:
	print("Inventory Slot: Refresh called")

	if not item:
		return
	
	if not item.logo:
		return

	check_type_of_item()

	display_logo.texture = item.logo

func check_type_of_item() -> void:
	if accepted_item_type == "base_item":
		return
	
	if item.type == accepted_item_type:
		return
	
	push_error("Inventory Slot: Invalid item type ")