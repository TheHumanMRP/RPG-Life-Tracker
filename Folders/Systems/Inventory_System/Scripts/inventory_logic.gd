class_name InventoryLogicComponent
extends Resource

# -------------------------------------------------------------------
# Inventory Data
# -------------------------------------------------------------------

var inventory_items: Array[ItemEntry]
var max_id: int = 0


# -------------------------------------------------------------------
# Initialization
# -------------------------------------------------------------------

func _init() -> void:
	call_deferred("calculate_max_id")


# -------------------------------------------------------------------
# ID Management
# -------------------------------------------------------------------

## Finds the next available item ID based on existing inventory items.
func calculate_max_id() -> void:
	max_id = 0

	for item in inventory_items:
		if item.item_id >= max_id:
			max_id = item.item_id + 1


# -------------------------------------------------------------------
# Inventory Operations
# -------------------------------------------------------------------

## Adds a new item to the inventory and assigns it a unique ID.
func add_item(new_item_entry: ItemEntry) -> void:
	new_item_entry.item_id = max_id

	inventory_items.append(new_item_entry)

	# Notify listeners that the inventory has changed.
	SignalBus.inventory_changed.emit(inventory_items)


## Removes an item with the specified ID from the inventory.
func remove_item(item_id: int) -> void:
	for index in range(inventory_items.size()):
		if inventory_items[index].item_id != item_id:
			continue

		inventory_items.pop_at(index)

		# Notify listeners that the inventory has changed.
		SignalBus.inventory_changed.emit(inventory_items)

		return

	push_error(
		"InventoryLogic: Item with ID ",
		item_id,
		" was not found for removal."
	)

func use_item(item_id: int) -> void:
	for item in inventory_items:
		if not item.item_id == item_id:
			continue
		
		item.use_item()

		SignalBus.inventory_changed.emit()

func get_iten_by_id(item_id: int) -> ItemEntry:
	for item in inventory_items:
		if not item.item_id == item_id:
			continue
		
		return item
	
	push_error("Item not found with item_id: ", item_id)
	return
