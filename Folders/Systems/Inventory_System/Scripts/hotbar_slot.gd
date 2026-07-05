extends Control
class_name HotbarSlot

@export var accepted_item_type: String = "base_item"
@export var item_id: int
@export var slot_index: int

@onready var selection_color_fade: ColorRect = $%Selection_Color_Fade
@onready var display_logo: TextureRect = $%Logo_Display
@onready var slot_number_label: Label = $%Slot_Number

const UNSELECTED_HEX_VALUE: String = "34343400"
const SELECTED_HEX_VALUE: String = "34343464"

var EMPTY_SLOT: int = Global.get_empty_hotbar_slot_const()

var item: ItemEntry

func _ready() -> void:
	refresh()

func refresh() -> void:
	check_type_of_item()
	
	assaign_item()

	refresh_logo()

	set_proper_selection_color_rect_opacity()

	slot_number_label.text = str(slot_index + 1)

func set_proper_selection_color_rect_opacity() -> void:
	var selected_slot_index: int = Global.get_selected_hotbar_index()

	if selected_slot_index != slot_index:
		selection_color_fade.color.hex(int(UNSELECTED_HEX_VALUE))
		return
	
	selection_color_fade.color = int(SELECTED_HEX_VALUE)
	

func assaign_item() -> void:
	check_id()

	if item_id == EMPTY_SLOT:
		return

	item = Global.get_inventory_logic().get_item_by_id(item_id)
	
	check_type_of_item()

func check_id() -> void:
	var inventory_items: Array[ItemEntry] = Global.get_inventory()

	if item_id >= 0 and item_id < inventory_items.size():
		return
	
	if item_id == EMPTY_SLOT:
		return

	push_error("Inventory Slot: Invalid item id: ", item_id)


func refresh_logo() -> void:
	display_logo.texture = null

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

func _gui_input(event: InputEvent):
	check_for_mouse_click(event)

func check_for_mouse_click(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return

	if event.button_index != MOUSE_BUTTON_LEFT:
			return

	if not event.pressed:
		return

	print("\nHotbar Slot: I was clicked, here's my index: ", slot_index)
	
	notify_hotbar_selected()

	
func notify_hotbar_selected() -> void:
	SignalBus.hotbar_selected.emit(slot_index)