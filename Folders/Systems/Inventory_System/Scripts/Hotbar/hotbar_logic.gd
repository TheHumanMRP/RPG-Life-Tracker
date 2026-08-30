class_name HotbarLogic
extends Resource

# ============================================================================
# Initialization
# ============================================================================

func _init() -> void:
	print("\nHotbar Logic: Init called")
	SignalBus.hotbar_item_selected.connect(_on_hotbar_item_selected)
	SignalBus.hotbar_item_equipped.connect(_on_hotbar_item_equipped)
	SignalBus.swap_hotbar_item.connect(_on_swap_hotbar_item)

# ============================================================================
# Item Management
# ============================================================================

## Resets every hotbar slot to an empty state.
func clear_hotbar() -> void:
	InfoGetter.get_hotbar_slots().clear()

	while InfoGetter.get_hotbar_slots().size() < InfoGetter.NUMBER_OF_HOTBAR_SLOTS:
		InfoGetter.get_hotbar_slots().append(Constants.EMPTY_HOTBAR_SLOT)

## Places an item into the specified hotbar slot.
func add_item_to_hotbar(item_id: int, slot_index: int) -> void:
	print("\nHotbar Logic: Add item func called with item id and slot index: ", item_id, " : ", slot_index)

	if not check_if_slot_empty(slot_index):
		push_error("HotBarLogic: Hotbar slot already occupied: ", slot_index)
		return

	InfoGetter.get_hotbar()[slot_index] = item_id

	notify_hotbar_changed()

func _on_swap_hotbar_item(slot_index: int, item_id: int) -> void:
	InfoGetter.get_hotbar()[slot_index] = item_id

	notify_hotbar_changed()


# ============================================================================
# Queries
# ============================================================================

## Returns `true` if the specified hotbar slot is empty.
func check_if_slot_empty(slot: int) -> bool:
	return InfoGetter.get_hotbar()[slot] == Constants.NO_ITEM

func _on_hotbar_item_selected(slot_index: int) -> void:
	Global.save_data.hotbar_save_data.selected_hotbar_slot_index = slot_index

	var selected_item_id: int = InfoGetter.get_hotbar()[slot_index]

	if selected_item_id != Constants.NO_ITEM:
		SignalBus.item_selected.emit(selected_item_id)

	notify_hotbar_changed()

func _on_hotbar_item_equipped(slot_index: int) -> void:
	var item_id: int = Global.save_data.hotbar_save_data.hotbar_slots[slot_index]
	
	SignalBus.equip_item.emit(item_id, slot_index)

	Global.save_data.hotbar_save_data.hotbar_slots[slot_index] = Constants.NO_ITEM

	notify_hotbar_changed()
	
	
## This shit is here so that I don't have to go to a billion places if I by mistakely somehow change the signal name
func notify_hotbar_changed() -> void:
	SignalBus.hotbar_changed.emit()
	SignalBus.save_game.emit()
