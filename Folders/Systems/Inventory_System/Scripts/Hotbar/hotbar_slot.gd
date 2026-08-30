extends Control
class_name HotbarSlot


# ------------------------------------------------------------------------------
# Exports
# ------------------------------------------------------------------------------

@export var slot_index: int


# ------------------------------------------------------------------------------
# Nodes
# ------------------------------------------------------------------------------

@onready var selection_color_fade: ColorRect = $%Selection_Color_Fade
@onready var display_logo: TextureRect = $%Logo_Display
@onready var slot_number_label: Label = $%Slot_Number

# ------------------------------------------------------------------------------
# Lifecycle
# ------------------------------------------------------------------------------

func _ready() -> void:
	SignalBus.hotbar_changed.connect(refresh)

	refresh()


func _process(_delta: float) -> void:
	check_for_keyboard_selection()


func _gui_input(event: InputEvent) -> void:
	check_for_mouse_click(event)


# ------------------------------------------------------------------------------
# Refresh
# ------------------------------------------------------------------------------

func refresh() -> void:
	refresh_logo()
	set_proper_selection_color_rect_opacity()

	slot_number_label.text = str(slot_index + 1)


func refresh_logo() -> void:
	display_logo.texture = null

	if InfoGetter.get_hotbar()[slot_index] == Constants.NO_ITEM:
		return

	var item: ItemEntry = get_item()

	if not item:
		return

	if not item.logo:
		return

	print("\nHotbar Slot [", slot_index, "]: Updating logo")

	display_logo.texture = item.logo


func set_proper_selection_color_rect_opacity() -> void:
	var selected_slot_index: int = InfoGetter.get_selected_hotbar_index()

	if selected_slot_index != slot_index:
		# Unselected
		selection_color_fade.color.a = Constants.UNSELECTED_HOTBAR_SLOT_OPACITY
		return

	# Selected
	selection_color_fade.color.a = Constants.SELECTED_HOTBAR_SLOT_OPACITY


# ------------------------------------------------------------------------------
# Item Access
# ------------------------------------------------------------------------------

func get_item() -> ItemEntry:
	return AllGlobalItemsManager.get_item_by_id(InfoGetter.get_hotbar()[slot_index])


# ------------------------------------------------------------------------------
# Input
# ------------------------------------------------------------------------------

func check_for_mouse_click(event: InputEvent) -> void:
	if not event is InputEventMouseButton:
		return

	if event.button_index != MOUSE_BUTTON_LEFT:
		return

	if not event.pressed:
		return

	print("\nHotbar Slot: I was clicked, here's my index: ", slot_index)

	notify_hotbar_selected()


func check_for_keyboard_selection() -> void:
	var input_action: String = "select_hotbar_slot_" + str(slot_index)

	if Input.is_action_just_pressed(input_action):
		notify_hotbar_selected()
	
	if Input.is_action_just_pressed("equip_item"):
		equip_item()

func equip_item() -> void:
	var selected_slot_index: int = InfoGetter.get_selected_hotbar_index()

	if selected_slot_index == slot_index:
		print("\nHotbar Slot: Equipped an item with item_id:, ", InfoGetter.get_hotbar()[slot_index], " and slot index: ", slot_index)
		SignalBus.hotbar_item_equipped.emit(slot_index)

# ------------------------------------------------------------------------------
# Selection
# ------------------------------------------------------------------------------

func notify_hotbar_selected() -> void:
	SignalBus.hotbar_item_selected.emit(slot_index)