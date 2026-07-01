class_name HotBarLogic
extends Resource

const EMPTY_HOTBAR_SLOT: int = -1

@export var hotbar_slots: Array[int] = [
	-1, -1, -1, -1,
	-1, -1, -1, -1,
	-1
]

func reset_hotbar_slots() -> void:
	hotbar_slots.clear()

	while hotbar_slots.size() < Global.number_of_hotbar_slots:
		hotbar_slots.append(EMPTY_HOTBAR_SLOT)

## Places an item into a hotbar slot.
func add_item_to_hotbar(item_id: int, slot: int) -> void:
	if not check_if_slot_empty(slot):
		push_error("InventoryLogic: Hotbar slot already occupied: ", slot)
		return

	hotbar_slots[slot] = item_id

	SignalBus.inventory_changed.emit()

## Returns true if the slot is empty.
func check_if_slot_empty(slot: int) -> bool:
	return hotbar_slots[slot] == EMPTY_HOTBAR_SLOT
