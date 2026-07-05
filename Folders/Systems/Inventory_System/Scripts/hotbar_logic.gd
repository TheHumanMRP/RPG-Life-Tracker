class_name HotBarLogicComponent
extends Resource


# ============================================================================
# Constants
# ============================================================================

const EMPTY_HOTBAR_SLOT: int = -1

const NUMBER_OF_HOTBAR_SLOTS: int = 9

var selected_hotbar_slot: int = -1

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

func _init() -> void:
	call_deferred("connect_signals")

func connect_signals() -> void:
	SignalBus.inventory_changed.connect(assaign_items_to_all_hotbars)

# ============================================================================
# Item Management
# ============================================================================

## Resets every hotbar slot to an empty state.
func clear_hotbar() -> void:
	hotbar_slots.clear()

	while hotbar_slots.size() < NUMBER_OF_HOTBAR_SLOTS:
		hotbar_slots.append(EMPTY_HOTBAR_SLOT)

## Places an item into the specified hotbar slot.
func add_item_to_hotbar(item_id: int, slot_index: int) -> void:
	if not check_if_slot_empty(slot_index):
		push_error("HotBarLogic: Hotbar slot already occupied: ", slot_index)
		return

	hotbar_slots[slot_index] = item_id

	notify_hotbar_changed()

## Here for testing only
func assaign_items_to_all_hotbars() -> void:
	var inventory: Array[ItemEntry] = Global.get_inventory()
	
	for i in range(NUMBER_OF_HOTBAR_SLOTS):
		if not Global.check_if_item_at_index_in_inventory_exists(i):
			continue
		
		hotbar_slots[i] = inventory[i].item_id
	
	notify_hotbar_changed()


# ============================================================================
# Queries
# ============================================================================

## Returns `true` if the specified hotbar slot is empty.
func check_if_slot_empty(slot: int) -> bool:
	return hotbar_slots[slot] == EMPTY_HOTBAR_SLOT

## This shit is here so that I don't have to go to a billion places if I by mistakely somehow change the signal name
func notify_hotbar_changed() -> void:
	SignalBus.hotbar_changed.emit()

func hotbar_selected(slot_index: int) -> void:
	selected_hotbar_slot = slot_index