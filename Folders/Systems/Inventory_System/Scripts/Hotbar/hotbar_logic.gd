class_name HotbarLogic
extends Resource

# ============================================================================
# Initialization
# ============================================================================

func _init() -> void:
	print("\nHotbar Logic: Init called")
	Global.signal_bus.hotbar_item_selected.connect(_on_hotbar_item_selected)
	Global.signal_bus.hotbar_item_equipped.connect(_on_hotbar_item_equipped)

# ============================================================================
# Item Management
# ============================================================================

## Resets every hotbar slot to an empty state.
func clear_hotbar() -> void:
	Global.info_getter.get_hotbar_slots().clear()

	while Global.info_getter.get_hotbar_slots().size() < Global.info_getter.NUMBER_OF_HOTBAR_SLOTS:
		Global.info_getter.get_hotbar_slots().append(Global.info_getter.EMPTY_HOTBAR_SLOT)

## Places an item into the specified hotbar slot.
func add_item_to_hotbar(item_id: int, slot_index: int) -> void:
	print("\nHotbar Logic: Add item func called with item id and slot index: ", item_id, " : ", slot_index)

	if not check_if_slot_empty(slot_index):
		push_error("HotBarLogic: Hotbar slot already occupied: ", slot_index)
		return

	print(Global.info_getter.get_hotbar())

	Global.info_getter.get_hotbar()[slot_index] = item_id

	print(Global.info_getter.get_hotbar())
	
	notify_hotbar_changed()

# ============================================================================
# Queries
# ============================================================================

## Returns `true` if the specified hotbar slot is empty.
func check_if_slot_empty(slot: int) -> bool:
	return Global.info_getter.get_hotbar()[slot] == Constants.NO_ITEM

func _on_hotbar_item_selected(slot_index: int) -> void:
	Global.save_data.hotbar_save_data.selected_hotbar_slot_index = slot_index

	var selected_item_id: int = Global.info_getter.get_hotbar()[slot_index]

	if selected_item_id != Constants.NO_ITEM:
		Global.signal_bus.item_selected.emit(selected_item_id)

	notify_hotbar_changed()

func _on_hotbar_item_equipped(slot_index: int) -> void:
	var item_id: int = Global.save_data.hotbar_save_data.hotbar_slots[slot_index]
	
	Global.signal_bus.equip_item.emit(item_id)

	Global.save_data.hotbar_save_data.hotbar_slots[slot_index] = Constants.NO_ITEM

	notify_hotbar_changed()
	
	
## This shit is here so that I don't have to go to a billion places if I by mistakely somehow change the signal name
func notify_hotbar_changed() -> void:
	Global.signal_bus.hotbar_changed.emit()
	Global.signal_bus.save_game.emit()
