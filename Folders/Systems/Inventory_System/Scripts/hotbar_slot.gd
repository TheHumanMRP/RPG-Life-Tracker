extends Control
class_name InventorySlot

@export var accepted_item_type: String = "base_item"
@export var item_id: int

@onready var display_logo: TextureRect = $%Logo_Display
@onready var slot_number_label : 

const EMPTY_SLOT: int = -1

var item: ItemEntry

func _ready() -> void:
	setup()

func setup() -> void:
	display_logo.texture = null
	SignalBus.inventory_changed.connect(refresh_logo)
	
	check_type_of_item()
	refresh_logo()

	assaign_item()

func assaign_item() -> void:
	check_id()

	if item_id == EMPTY_SLOT:
		return

	item = Global.get_inventory_logic().get_iten_by_id(item_id)
	
	check_type_of_item()

func check_id() -> void:
	var inventory_items: Array[ItemEntry] = Global.get_inventory()

	if item_id >= 0 and item_id < inventory_items.size():
		return
	
	if item_id == EMPTY_SLOT:
		return

	push_error("Inventory Slot: Invalid item id: ", item_id)


func refresh_logo() -> void:
	if not item:
		return
	
	if not item.logo:
		return

	display_logo.texture = item.logo

func check_type_of_item() -> void:
	if accepted_item_type == "base_item":
		return
	
	if item.type == accepted_item_type:
		return
	
	push_error("Inventory Slot: Invalid item type ")
