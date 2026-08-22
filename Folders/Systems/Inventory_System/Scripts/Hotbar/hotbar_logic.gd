class_name HotBarLogicComponent
extends Resource

# ============================================================================
# Initialization
# ============================================================================

func _init() -> void:
	print("\nHotbar Logic: Init called")
	SignalBus.hotbar_item_selected.connect(_on_hotbar_item_selected)
	SignalBus.hotbar_item_equipped.connect(_on_hotbar_item_equipped)

# ============================================================================
# Item Management
# ============================================================================

## Resets every hotbar slot to an empty state.
func clear_hotbar() -> void:
	InfoGetter.get_hotbar_slots().clear()

	while InfoGetter.get_hotbar_slots().size() < InfoGetter.NUMBER_OF_HOTBAR_SLOTS:
		InfoGetter.get_hotbar_slots().append(InfoGetter.EMPTY_HOTBAR_SLOT)

## Places an item into the specified hotbar slot.
func add_item_to_hotbar(item_id: int, slot_index: int) -> void:
	if not check_if_slot_empty(slot_index):
		push_error("HotBarLogic: Hotbar slot already occupied: ", slot_index)
		return

	InfoGetter.get_hotbar_slots()[slot_index] = item_id

	notify_hotbar_changed()

# ============================================================================
# Queries
# ============================================================================

## Returns `true` if the specified hotbar slot is empty.
func check_if_slot_empty(slot: int) -> bool:
	return InfoGetter.get_hotbar_slots()[slot] == InfoGetter.EMPTY_HOTBAR_SLOT

func _on_hotbar_item_selected(slot_index: int) -> void:
	Global.save_data.hotbar_save_data.selected_hotbar_slot_index = slot_index

	var selected_item_id: int = InfoGetter.get_hotbar()[slot_index]

	if selected_item_id != Constants.EMPTY_HOTBAR_SLOT:
		SignalBus.item_selected.emit(selected_item_id)

	notify_hotbar_changed()

func _on_hotbar_item_equipped(slot_index: int) -> void:
	
	var item_id: int = 

	Global.save_data.hotbar_save_data.hotbar_slots[slot_index] = Constants.EMPTY_HOTBAR_SLOT
	
	

	SignalBus.equip_item.emit()

## This shit is here so that I don't have to go to a billion places if I by mistakely somehow change the signal name
func notify_hotbar_changed() -> void:
	SignalBus.hotbar_changed.emit()
	SignalBus.save_game.emit()