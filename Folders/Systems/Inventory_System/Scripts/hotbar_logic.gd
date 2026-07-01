class_name HotBarLogic
extends Resource


# ============================================================================
# Constants
# ============================================================================

const EMPTY_HOTBAR_SLOT: int = -1


# ============================================================================
# Exported Variables
# ============================================================================

@export var hotbar_slots: Array[int] = [
	-1, -1, -1, -1,
	-1, -1, -1, -1,
	-1
]


# ============================================================================
# Initialization
# ============================================================================

## Resets every hotbar slot to an empty state.
func reset_hotbar_slots() -> void:
	hotbar_slots.clear()

	while hotbar_slots.size() < Global.number_of_hotbar_slots:
		hotbar_slots.append(EMPTY_HOTBAR_SLOT)


# ============================================================================
# Item Management
# ============================================================================

## Places an item into the specified hotbar slot.
func add_item_to_hotbar(item_id: int, slot: int) -> void:
	if not check_if_slot_empty(slot):
		push_error("HotBarLogic: Hotbar slot already occupied: ", slot)
		return

	hotbar_slots[slot] = item_id

	SignalBus.inventory_changed.emit()


# ============================================================================
# Queries
# ============================================================================

## Returns `true` if the specified hotbar slot is empty.
func check_if_slot_empty(slot: int) -> bool:
	return hotbar_slots[slot] == EMPTY_HOTBAR_SLOT